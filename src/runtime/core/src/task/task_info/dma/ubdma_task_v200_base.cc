/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream.hpp"
#include "runtime.hpp"
#include "event_david.hpp"
#include "task_manager.h"
#include "stars.hpp"
#include "stars_david.hpp"
#include "device.hpp"
#include "error_code.h"
#include "task_fail_callback_manager.hpp"

namespace cce {
namespace runtime {

#if F_DESC("UbDbSendTask")
constexpr uint32_t STARS_UBDMA_EXIST_ERROR = 0xFFU;
constexpr uint32_t JETTY_WORK_REQUEST_FLUSHED = 0x6U;
static unordered_map<uint32_t, string> ubdmaTaskErr {
    {1U, "unsupported opcode!"},
    {2U, "local operation error!"},
    {3U, "remote operation error!"},
    {4U, "transaction retry counter exceeded!"},
    {5U, "transaction ack timeout!"},
    {6U, "jetty work request flushed!"}
};

rtError_t UbDbSendTaskInit(TaskInfo* taskInfo, const rtUbDbInfo_t *dbInfo, const uint16_t source)
{
    TaskCommonInfoInit(taskInfo);
    UbSendTaskInfo *ubSend = &taskInfo->u.ubSendTask;
    taskInfo->type = TS_TASK_TYPE_UB_DB_SEND;
    taskInfo->typeName = const_cast<char_t*>("UB_DB_SEND");
    taskInfo->isNoRingbuffer = 1U;
    ubSend->wrCqe = dbInfo->wrCqe;
    ubSend->dbNum = dbInfo->dbNum;
    ubSend->source = source;
    for (size_t i = 0; i < ubSend->dbNum; i++) {
        ubSend->info[i].dieId = dbInfo->info[i].dieId;
        ubSend->info[i].jettyId = dbInfo->info[i].jettyId;
        ubSend->info[i].funcId = dbInfo->info[i].functionId;
        ubSend->info[i].piVal = dbInfo->info[i].piValue;
    }
    return RT_ERROR_NONE;
}

void PrintErrorInfoForUbDbSendTask(TaskInfo *taskInfo, const uint32_t devId)
{
    UbSendTaskInfo *ubSend = &taskInfo->u.ubSendTask;
    Stream * const stream = taskInfo->stream;

    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = stream->Id_();
    RT_LOG(RT_LOG_ERROR, "ub db send failed device_id=%u, stream_id=%d, task_id=%u, wrCqe=%u, dbNum=%u.",
        devId, streamId, taskId, ubSend->wrCqe, ubSend->dbNum);
    for (size_t i = 0; i < ubSend->dbNum; i++) {
        RT_LOG(RT_LOG_ERROR, "dieId=%u, jettyId=%u, funcId=%u, piVal=%u.",
            ubSend->info[i].dieId, ubSend->info[i].jettyId, ubSend->info[i].funcId,
            ubSend->info[i].piVal);
    }
}

static void TaskFailCallBackForDoorBellTask(TaskInfo* taskInfo, const uint32_t deviceId)
{
    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = taskInfo->stream->Id_();
    const uint32_t threadId = taskInfo->tid;
    const uint32_t retCode = taskInfo->errorCode;
    COND_RETURN_NORMAL(retCode == static_cast<uint32_t>(RT_ERROR_NONE),
                       "task ok, stream_id=%d, task_id=%u, retCode=%#x.", streamId, taskId, retCode);
    COND_RETURN_NORMAL(((retCode == TS_ERROR_END_OF_SEQUENCE) || (retCode == TS_MODEL_ABORT_NORMAL)),
                       "task ok, stream_id=%d, task_id=%u, retCode=%#x.", streamId, taskId, retCode);
    rtExceptionInfo_t exceptionInfo;
    rtError_t rtErrCode = RT_ERROR_NONE;
    const char_t *const retDes = GetTsErrCodeMap(retCode, &rtErrCode);
    rtExceptionExpandInfo_t expandInfo = {};
    expandInfo.u.ubInfo.ubType = RT_UB_TYPE_DOORBELL;
    expandInfo.u.ubInfo.ubNum = taskInfo->u.ubSendTask.dbNum;
    for (uint i = 0U; i < taskInfo->u.ubSendTask.dbNum; i++) {
        expandInfo.u.ubInfo.info[i].functionId = static_cast<uint8_t>(taskInfo->u.ubSendTask.info[i].funcId);
        expandInfo.u.ubInfo.info[i].dieId = static_cast<uint8_t>(taskInfo->u.ubSendTask.info[i].dieId);
        expandInfo.u.ubInfo.info[i].jettyId = taskInfo->u.ubSendTask.info[i].jettyId;
        expandInfo.u.ubInfo.info[i].piValue = taskInfo->u.ubSendTask.info[i].piVal;
    }
    exceptionInfo.retcode = static_cast<uint32_t>(RT_GET_EXT_ERRCODE(rtErrCode));
    exceptionInfo.taskid = taskInfo->taskSn;
    exceptionInfo.streamid = streamId;
    exceptionInfo.tid = threadId;
    exceptionInfo.deviceid = deviceId;
    exceptionInfo.expandInfo = expandInfo;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_UB;
    RT_LOG(RT_LOG_WARNING, "doorbell stream_id=%d, exception_task_id=%u, expandType=%u, retCode=%#x,[%s]",
        streamId, exceptionInfo.taskid, exceptionInfo.expandInfo.type, rtErrCode, retDes);

    TaskFailCallBackNotify(&exceptionInfo);
}

void DoCompleteSuccessForUbDmaDbModeTask(TaskInfo* taskInfo, const uint32_t devId)
{
    const uint32_t errorCode = taskInfo->errorCode;
    if (unlikely(errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        taskInfo->stream->SetErrCode(taskInfo->errorCode);
        RT_LOG(RT_LOG_ERROR, "ubdma doorbell mode send error, retCode=%#x.", errorCode);
        PrintErrorInfo(taskInfo, devId);
        TaskFailCallBackForDoorBellTask(taskInfo, devId);
    }
}
#endif

void SetResultForUbDmaTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq)
{
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) != 0U) {
        static uint32_t errMap[TS_STARS_ERROR_MAX_INDEX] = {
            TS_ERROR_TASK_EXCEPTION,
            TS_ERROR_TASK_BUS_ERROR,
            TS_ERROR_TASK_TIMEOUT,
            TS_ERROR_TASK_SQE_ERROR,
            TS_ERROR_TASK_RES_CONFLICT_ERROR,
            TS_ERROR_TASK_SW_STATUS_ERROR};
        const uint32_t errorIndex =
            static_cast<uint32_t>(BitScan(static_cast<uint64_t>(logicCq.errorType & RT_STARS_EXIST_ERROR)));
        taskInfo->errorCode = errMap[errorIndex];
    }
    if (taskInfo->errorCode == TS_ERROR_TASK_SW_STATUS_ERROR) {
        return;
    }
    const uint32_t ubTaskErr = logicCq.errorCode & STARS_UBDMA_EXIST_ERROR;
    RT_LOG(RT_LOG_WARNING, "ubdma report cqe status :0x%x", ubTaskErr);
    if ((ubdmaTaskErr.count(ubTaskErr) != 0) && (ubTaskErr != JETTY_WORK_REQUEST_FLUSHED)) {
        RT_LOG(RT_LOG_ERROR, "ubdma complete status of the cqe :%s", ubdmaTaskErr[ubTaskErr].c_str());
    }
}

#if F_DESC("UbDirectSendTask")
void UbDirectSendTaskInit(TaskInfo* taskInfo, rtUbWqeInfo_t *wqeInfo)
{
    TaskCommonInfoInit(taskInfo);
    DirectSendTaskInfo *directSend = &taskInfo->u.directSendTask;
    taskInfo->type = TS_TASK_TYPE_DIRECT_SEND;
    taskInfo->typeName = const_cast<char_t*>("UB_DIRECT_SEND");
    taskInfo->isNoRingbuffer = 1U;
    directSend->wrCqe = wqeInfo->wrCqe;
    directSend->wqeSize = wqeInfo->wqeSize;
    directSend->dieId = wqeInfo->dieId;
    directSend->jettyId = wqeInfo->jettyId;
    directSend->funcId = wqeInfo->functionId;
    directSend->wqe = wqeInfo->wqe;
    directSend->wqePtrLen = wqeInfo->wqePtrLen;
    return;
}

void PrintErrorInfoForUbDirectSendTask(TaskInfo* taskInfo, const uint32_t devId)
{
    DirectSendTaskInfo *directSend = &taskInfo->u.directSendTask;
    Stream * const stream = taskInfo->stream;

    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = stream->Id_();
    RT_LOG(RT_LOG_ERROR, "ub direct send failed device_id=%u, stream_id=%d, task_id=%u,",
        " wrCqe=%hu, wqeSize=%u, dieId=%u, jettyId=%u, funcId=%u.", devId, streamId, taskId, directSend->wrCqe,
        directSend->wqeSize, directSend->dieId, directSend->jettyId, directSend->funcId);
}

static void TaskFailCallBackForDirectWqeTask(const TaskInfo * const taskInfo, const uint32_t deviceId)
{
    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = taskInfo->stream->Id_();
    const uint32_t threadId = taskInfo->tid;
    const uint32_t retCode = taskInfo->errorCode;
    COND_RETURN_NORMAL(retCode == static_cast<uint32_t>(RT_ERROR_NONE),
                       "task ok, stream_id=%d, task_id=%u, retCode=%#x.", streamId, taskId, retCode);
    COND_RETURN_NORMAL(((retCode == TS_ERROR_END_OF_SEQUENCE) || (retCode == TS_MODEL_ABORT_NORMAL)),
                       "task ok, stream_id=%d, task_id=%u, retCode=%#x.", streamId, taskId, retCode);
    rtExceptionInfo_t exceptionInfo;
    rtError_t rtErrCode = RT_ERROR_NONE;
    const char_t *const retDes = GetTsErrCodeMap(retCode, &rtErrCode);
    rtExceptionExpandInfo_t expandInfo = {};
    (void)memset_s(&(expandInfo.u.ubInfo), sizeof(expandInfo.u.ubInfo), 0, sizeof(expandInfo.u.ubInfo));
    expandInfo.u.ubInfo.ubType = RT_UB_TYPE_DIRECT_WQE;
    expandInfo.u.ubInfo.ubNum = 1U;
    expandInfo.u.ubInfo.info[0].dieId = taskInfo->u.directSendTask.dieId;
    expandInfo.u.ubInfo.info[0].jettyId = taskInfo->u.directSendTask.jettyId;
    expandInfo.u.ubInfo.info[0].functionId = taskInfo->u.directSendTask.funcId;
    exceptionInfo.retcode = static_cast<uint32_t>(RT_GET_EXT_ERRCODE(rtErrCode));
    exceptionInfo.taskid = taskInfo->taskSn;
    exceptionInfo.streamid = streamId;
    exceptionInfo.tid = threadId;
    exceptionInfo.deviceid = deviceId;
    exceptionInfo.expandInfo = expandInfo;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_UB;
    RT_LOG(RT_LOG_WARNING, "stream_id=%d, exception_task_id=%u, expandType=%u, retCode=%#x,[%s]",
        streamId, exceptionInfo.taskid, exceptionInfo.expandInfo.type, rtErrCode, retDes);

    TaskFailCallBackNotify(&exceptionInfo);
}

void DoCompleteSuccessForUbDmaDirectWqeModeTask(TaskInfo* taskInfo, const uint32_t devId)
{
    const uint32_t errorCode = taskInfo->errorCode;
    if (unlikely(errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        taskInfo->stream->SetErrCode(taskInfo->errorCode);
        RT_LOG(RT_LOG_ERROR, "ubdma direct wqe mode send error, retCode=%#x.", errorCode);
        PrintErrorInfo(taskInfo, devId);
        TaskFailCallBackForDirectWqeTask(taskInfo, devId);
    }
}

uint32_t GetSendSqeNumForDirectWqeTask(const TaskInfo * const taskInfo)
{
    // wqeSize 0：64B，1:128B
    uint32_t sqeNum = 0U;
    if (taskInfo->u.directSendTask.wqeSize == 1U) {
        sqeNum = 3U; // need 3 sqe
    } else if (taskInfo->u.directSendTask.wqeSize == 0U) {
        sqeNum = 2U;
    } else {
        // no op
    }
    return sqeNum;
}
#endif

void ConstructDavidSqeForUbDirectSendTask(TaskInfo *taskInfo, void *const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    uint64_t sqBaseAddr = sqeInfo.sqBaseAddr;
    Stream * const stream = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsUbdmaDirectWqemodeSqe * const ubdmaDirectSqe = &(davidSqe->davidUbdmaDirectSqe);
    ubdmaDirectSqe->header.type = RT_DAVID_SQE_TYPE_UBDMA;
    ubdmaDirectSqe->mode = static_cast<uint16_t>(rtDavidUbDmaSqeMode::RT_DAVID_SQE_DIRECTWQE_MODE);
    ubdmaDirectSqe->dieId = taskInfo->u.directSendTask.dieId;
    ubdmaDirectSqe->wqeSize =taskInfo->u.directSendTask.wqeSize;
    ubdmaDirectSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    ubdmaDirectSqe->sqeLength = (taskInfo->u.directSendTask.wqeSize == 1) ? 2U : 1U;
    ubdmaDirectSqe->jettyId = taskInfo->u.directSendTask.jettyId;
    ubdmaDirectSqe->funcId = taskInfo->u.directSendTask.funcId;
    PrintDavidSqe(davidSqe, "UbDirectSend Part0");
    constexpr size_t ubWqesize = 64UL;
    uint8_t *wqe = taskInfo->u.directSendTask.wqe;
    for (uint32_t i = 0U; i <= taskInfo->u.directSendTask.wqeSize; i++) {
        rtDavidSqe_t *curSqe = davidSqe + i + 1U;
        if (sqBaseAddr != 0ULL) {
            const uint32_t pos = taskInfo->id + i + 1U;
            curSqe = GetSqPosAddr(sqBaseAddr, pos);
        }
        const errno_t ret = memcpy_s(curSqe, sizeof(rtDavidSqe_t), wqe + (i * ubWqesize), ubWqesize);
        if (ret != EOK) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to call memcpy_s to copy wqe,"
                " src=%p, dest=%p, dest_max=%zu, count=%zu, retCode=%#x.", wqe + (i * ubWqesize), curSqe,
                sizeof(rtDavidSqe_t), ubWqesize, ret);
            ubdmaDirectSqe->header.type = RT_DAVID_SQE_TYPE_END;
            break;
        }
        std::stringstream descInfo;
        descInfo << "UbDirectSend Part " << (i + 1U);
        PrintDavidSqe(curSqe, descInfo.str().c_str());
    }
    RT_LOG(RT_LOG_INFO, "UbDirectSendTask stream_id=%d, task_id=%hu, wqeSize=%u.",
        stream->Id_(), taskInfo->id, ubdmaDirectSqe->wqeSize);
}

void ConstructDavidSqeForUbDbSendTask(TaskInfo *taskInfo, void *const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsUbdmaDBmodeSqe * const ubdmaDbSqe = &(davidSqe->davidUbdmaDbSqe);
    Stream * const stream = taskInfo->stream;
    ubdmaDbSqe->header.type = RT_DAVID_SQE_TYPE_UBDMA;
    ubdmaDbSqe->header.wrCqe = 0U;
    ubdmaDbSqe->mode = static_cast<uint16_t>(rtDavidUbDmaSqeMode::RT_DAVID_SQE_DOORBELL_MODE);
    ubdmaDbSqe->doorbellNum = taskInfo->u.ubSendTask.dbNum;
    ubdmaDbSqe->source = taskInfo->u.ubSendTask.source;
    ubdmaDbSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    ubdmaDbSqe->sqeLength = 0U;
    ubdmaDbSqe->jettyId1 = taskInfo->u.ubSendTask.info[0].jettyId;
    ubdmaDbSqe->funcId1 = taskInfo->u.ubSendTask.info[0].funcId;
    ubdmaDbSqe->piValue1 = taskInfo->u.ubSendTask.info[0].piVal;
    ubdmaDbSqe->dieId1 = taskInfo->u.ubSendTask.info[0].dieId;
    if (taskInfo->u.ubSendTask.dbNum == UB_DOORBELL_NUM_MAX) {
        ubdmaDbSqe->jettyId2 = taskInfo->u.ubSendTask.info[1].jettyId;
        ubdmaDbSqe->funcId2 = taskInfo->u.ubSendTask.info[1].funcId;
        ubdmaDbSqe->piValue2 = taskInfo->u.ubSendTask.info[1].piVal;
        ubdmaDbSqe->dieId2 = taskInfo->u.ubSendTask.info[1].dieId;
    }
    PrintDavidSqe(davidSqe, "UbDbSend");
    RT_LOG(RT_LOG_INFO, "UbDbSendTask stream_id=%d, task_id=%hu, dbNum=%u.",
        stream->Id_(), taskInfo->id, taskInfo->u.ubSendTask.dbNum);
}

static bool UbDmaTaskRegister()
{
    TaskFuncSingle ubDbFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccessForUbDmaDbModeTask,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForUbDbSendTask,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetResultForUbDmaTask,
    };
    TaskFuncSingle directSendFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccessForUbDmaDirectWqeModeTask,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForUbDirectSendTask,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetResultForUbDmaTask,
    };

    const auto &chips = GetDavidChips();
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_UB_DB_SEND, ubDbFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_DIRECT_SEND, directSendFuncs);
    }

    RegDavidSqeFunc(TS_TASK_TYPE_UB_DB_SEND, &ConstructDavidSqeForUbDbSendTask);
    RegDavidSqeFunc(TS_TASK_TYPE_DIRECT_SEND, &ConstructDavidSqeForUbDirectSendTask);
    return true;
}

static bool g_ubDmaTaskRegister = UbDmaTaskRegister();

}  // namespace runtime
}  // namespace cce
