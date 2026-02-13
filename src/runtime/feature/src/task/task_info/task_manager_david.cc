/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream_david.hpp"
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "driver.hpp"
#include "stars.hpp"
#include "task_fail_callback_manager.hpp"
#include "davinci_kernel_task.h"
#include "event_task.h"
#include "memory_task.h"
#include "rdma_task.h"
#include "reduce_task.h"
#include "cond_op_task.h"
#include "debug_task.h"
#include "stream_task.h"
#include "davinci_multiple_task.h"
#include "stars_common_task.h"
#include "cmo_task.h"
#include "barrier_task.h"
#include "model_maintaince_task.h"
#include "notify_record_task.h"
#include "timeout_set_task.h"
#include "ringbuffer_maintain_task.h"
#include "model_update_task.h"
#include "end_graph_task.h"
#include "model_to_aicpu_task.h"
#include "maintenance_task.h"
#include "davinci_kernel_task.h"
#include "task_info.h"
#include "error_code.h"
#include "task_manager.h"
#include "task_manager_david.h"
#include "device_error_proc.hpp"
#include "starsv2_base.hpp"
namespace cce {
namespace runtime {
constexpr uint32_t CCU_TASK_LOCAL_MEM_ERROR = 0x02U;
constexpr uint32_t CCU_TASK_REMOTE_MEM_ERROR = 0x03U;
constexpr uint32_t CCU_TASK_LOCAL_MEM_ERROR_SUBSTATUS = 0x0U;   

rtError_t DavidModelMaintainceTaskInit(TaskInfo * const taskInfo, const MmtType mType,
    Model *const modelPtr, Stream *const opStreamPtr, const rtModelStreamType_t modelStreamType,
    const uint32_t firstTaskIndex)
{
    ModelMaintainceTaskInfo *modelMaintainceTaskInfo = &(taskInfo->u.modelMaintainceTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_MODEL_MAINTAINCE;
    taskInfo->typeName = "MODEL_MAINTAINCE";

    modelMaintainceTaskInfo->type = mType;
    modelMaintainceTaskInfo->opStream = opStreamPtr;
    modelMaintainceTaskInfo->model = modelPtr;
    modelMaintainceTaskInfo->streamType = modelStreamType;
    modelMaintainceTaskInfo->firstTaskId = firstTaskIndex;
    modelMaintainceTaskInfo->execTimesSvmOffset = 0x0U;

    if (mType == MMT_STREAM_ADD) {
        uint16_t * const execTimesSvm = modelMaintainceTaskInfo->opStream->GetExecutedTimesSvm();
        modelMaintainceTaskInfo->execTimesSvmOffset =
            RtPtrToValue<uint16_t *>(execTimesSvm);
    }
    return RT_ERROR_NONE;
}

#if F_DESC("SetResultAdapt")
static void SetStarsResultCommonForDavid(TaskInfo *taskInfo, const rtLogicCqReport_t &logicCq)
{
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) != 0U) {
        if (logicCq.errorCode != TS_SUCCESS) {
            taskInfo->errorCode = logicCq.errorCode;
        } else {
            static uint32_t errMap[TS_STARS_ERROR_MAX_INDEX] = {
                TS_ERROR_TASK_EXCEPTION,
                TS_ERROR_TASK_BUS_ERROR,
                TS_ERROR_TASK_TIMEOUT,
                TS_ERROR_TASK_SQE_ERROR,
                TS_ERROR_TASK_RES_CONFLICT_ERROR,
                TS_ERROR_TASK_SW_STATUS_ERROR};
            const uint32_t errorIndex =
                static_cast<uint32_t>(BitScan(static_cast<uint64_t>(logicCq.errorType) & RT_STARS_EXIST_ERROR));
            taskInfo->errorCode = errMap[errorIndex];
        }
    }
}
#endif

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

rtError_t UbDbSendTaskInit(TaskInfo* taskInfo, const rtUbDbInfo_t *dbInfo)
{
    TaskCommonInfoInit(taskInfo);
    UbSendTaskInfo *ubSend = &taskInfo->u.ubSendTask;
    taskInfo->type = TS_TASK_TYPE_UB_DB_SEND;
    taskInfo->typeName = const_cast<char_t*>("UB_DB_SEND");
    ubSend->wrCqe = dbInfo->wrCqe;
    ubSend->dbNum = dbInfo->dbNum;
    for (size_t i = 0; i < ubSend->dbNum; i++) {
        ubSend->info[i].dieId = dbInfo->info[i].dieId;
        ubSend->info[i].jettyId = dbInfo->info[i].jettyId;
        ubSend->info[i].funcId = dbInfo->info[i].functionId;
        ubSend->info[i].piVal = dbInfo->info[i].piValue;
    }
    return RT_ERROR_NONE;
}

static void PrintErrorInfoForUbDbSendTask(TaskInfo *taskInfo, const uint32_t devId)
{
    UbSendTaskInfo *ubSend = &taskInfo->u.ubSendTask;
    Stream * const stream = taskInfo->stream;

    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = stream->Id_();
    RT_LOG(RT_LOG_ERROR, "ub db send failed device_id=%u, stream_id=%d, taskId=%u, wrCqe=%u, dbNum=%u.",
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
        expandInfo.u.ubInfo.info[i].functionId = taskInfo->u.ubSendTask.info[i].funcId;
        expandInfo.u.ubInfo.info[i].dieId = taskInfo->u.ubSendTask.info[i].dieId;
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

static void DoCompleteSuccessForUbDmaDbModeTask(TaskInfo* taskInfo, const uint32_t devId)
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

static void SetResultForUbDmaTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq)
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
    directSend->wrCqe = wqeInfo->wrCqe;
    directSend->wqeSize = wqeInfo->wqeSize;
    directSend->dieId = wqeInfo->dieId;
    directSend->jettyId = wqeInfo->jettyId;
    directSend->funcId = wqeInfo->functionId;
    directSend->wqe = wqeInfo->wqe;
    directSend->wqePtrLen = wqeInfo->wqePtrLen;
    return;
}

static void PrintErrorInfoForUbDirectSendTask(TaskInfo* taskInfo, const uint32_t devId)
{
    DirectSendTaskInfo *directSend = &taskInfo->u.directSendTask;
    Stream * const stream = taskInfo->stream;

    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = stream->Id_();
    RT_LOG(RT_LOG_ERROR, "ub direct send failed device_id=%u, stream_id=%d, taskId=%u,",
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

static void DoCompleteSuccessForUbDmaDirectWqeModeTask(TaskInfo* taskInfo, const uint32_t devId)
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

#if F_DESC("CcuLaunchTask")
void CcuLaunchTaskInit(TaskInfo *taskInfo, rtCcuTaskInfo_t *const ccuInfo)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_CCU_LAUNCH;
    taskInfo->typeName = const_cast<char_t*>("CCU");

    CcuLaunchTaskInfo *ccuLaunchTsk = &(taskInfo->u.ccuLaunchTask);
    ccuLaunchTsk->errInfo.err = 0U;
    ccuLaunchTsk->dieId = ccuInfo->dieId;
    ccuLaunchTsk->missionId = ccuInfo->missionId;
    ccuLaunchTsk->ccu_size = (ccuInfo->argSize == RT_CCU_SQE_ARGS_LEN_128B) ? 0U : 1U;
    ccuLaunchTsk->instStartId = ccuInfo->instStartId;
    ccuLaunchTsk->instCnt = ccuInfo->instCnt;
    ccuLaunchTsk->timeout = ccuInfo->timeout;
    ccuLaunchTsk->key = ccuInfo->key;
    ccuLaunchTsk->args = RtPtrToPtr<uint32_t *, uint64_t*>(ccuInfo->args);
    return;
}

static void PrintErrorInfoForCcuLaunchTask(TaskInfo *taskInfo, const uint32_t devId)
{
    CcuLaunchTaskInfo *ccuLaunchTsk = &(taskInfo->u.ccuLaunchTask);
    Stream *const reportStream = GetReportStream(taskInfo->stream);
    if ((ccuLaunchTsk->errInfo.err & STARS_CCU_EXIST_ERROR) != 0U) {
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_HCCL,
            "CCU Launch task error status [%#x], subStatus [%#x], device_id=%u, stream_id=%d, "
            "task_id=%hu, udie_id=%u, missionId=%hu, sq_id=%u.",
            ccuLaunchTsk->errInfo.info.status, ccuLaunchTsk->errInfo.info.subStatus,
            devId, reportStream->Id_(), taskInfo->id, ccuLaunchTsk->dieId,
            ccuLaunchTsk->missionId, reportStream->GetSqId());
    } else {
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_HCCL,
            "CCU Launch task error device_id=%u, stream_id=%d, "
            "task_id=%hu, udie_id=%u, missionId=%hu, sq_id=%u.",
            devId, reportStream->Id_(), taskInfo->id, ccuLaunchTsk->dieId,
            ccuLaunchTsk->missionId, reportStream->GetSqId());
    }    
    return;
}

static void MapCcuErrorCodeForFastRecovery(TaskInfo* taskInfo, const uint32_t devId)
{
    CcuLaunchTaskInfo *ccuLaunchTsk = &(taskInfo->u.ccuLaunchTask);

    // Verify device status
    const auto device = taskInfo->stream->Device_();
    COND_RETURN_VOID(device == nullptr, "Invalid device");
    RT_LOG(RT_LOG_DEBUG,
                "CCU Launch task error status [%#x], subStatus [%#x], device_id=%u, stream_id=%d, task_id=%hu",
                ccuLaunchTsk->errInfo.info.status, ccuLaunchTsk->errInfo.info.subStatus, devId, taskInfo->stream->Id_(), taskInfo->id);
    bool hasMteErr = HasMteErr(device);
    // map local mem error
    if (ccuLaunchTsk->errInfo.info.status == CCU_TASK_LOCAL_MEM_ERROR && 
        ccuLaunchTsk->errInfo.info.subStatus == CCU_TASK_LOCAL_MEM_ERROR_SUBSTATUS) {
        if (hasMteErr && IsEventIdAndRasCodeMatch(devId, g_ubNonMemPoisonRasList) && !HasMemUceErr(devId, g_aicOrSdmaOrHcclLocalMulBitEccEventIdBlkList)) {
            taskInfo->errorCode = TS_ERROR_LOCAL_MEM_ERROR;
            RT_LOG(RT_LOG_DEBUG,
                "CCU Launch local HBM UCE fault occurred: device_id=%u, stream_id=%d, task_id=%hu, retCode=%u",
                devId, taskInfo->stream->Id_(), taskInfo->id, taskInfo->errorCode);
        }
    } 
    // map remote mem error
    else if (ccuLaunchTsk->errInfo.info.status == CCU_TASK_REMOTE_MEM_ERROR) {
        if (!hasMteErr && !HasMemUceErr(devId, g_hcclRemoteMulBitEccEventIdBlkList)) {
            taskInfo->errorCode = TS_ERROR_REMOTE_MEM_ERROR;
            RT_LOG(RT_LOG_DEBUG,
                "CCU Launch remote HBM UCE fault occurred: device_id=%u, stream_id=%d, task_id=%hu, retCode=%u",
                devId, taskInfo->stream->Id_(), taskInfo->id, taskInfo->errorCode);
        }
    }
}

static void DoCompleteSuccessForCcuLaunchTask(TaskInfo* taskInfo, const uint32_t devId)
{
    Stream * const stream = taskInfo->stream;
    CcuLaunchTaskInfo *ccuLaunchTsk = &(taskInfo->u.ccuLaunchTask);
    if (unlikely((taskInfo->errorCode != static_cast<uint32_t>(RT_ERROR_NONE)))) {
        MapCcuErrorCodeForFastRecovery(taskInfo, devId);
        RT_LOG(RT_LOG_ERROR, "CCU Launch task error, device_id=%u, retCode=%#x, [%s].",
            devId, taskInfo->errorCode, GetTsErrCodeDesc(taskInfo->errorCode));
        stream->SetErrCode(taskInfo->errorCode);
        PrintErrorInfoForCcuLaunchTask(taskInfo, devId);
        ccuLaunchTsk->errInfo.err = 0U;
        return;
    }
    RT_LOG(RT_LOG_INFO,
        "CCU Launch finished: device_id=%u, stream_id=%d, task_id=%hu, udie_id=%u, missionId=%hu, sq_id=%u",
        devId, stream->Id_(), taskInfo->id, ccuLaunchTsk->dieId, ccuLaunchTsk->missionId, stream->GetSqId());
}

static void SetResultForCcuLaunchTask(TaskInfo *taskInfo, const rtLogicCqReport_t &logicCq)
{
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) != 0U) {
        if ((logicCq.errorCode & STARS_CCU_EXIST_ERROR) != 0U) {
            taskInfo->u.ccuLaunchTask.errInfo.err = logicCq.errorCode;
        }
        uint32_t errMap[TS_STARS_ERROR_MAX_INDEX] = {
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
}
#endif

#if F_DESC("FusionKernelTask")
static void DoCompleteSuccessForFusionKernelTask(TaskInfo* taskInfo, const uint32_t devId)
{
    const uint32_t errorCode = taskInfo->errorCode;
    Stream * const stream = taskInfo->stream;
    if ((taskInfo->mte_error == TS_ERROR_AICORE_MTE_ERROR) || (taskInfo->mte_error == TS_ERROR_LINK_ERROR)) {
        taskInfo->errorCode = taskInfo->mte_error;
        taskInfo->mte_error = 0U;
    }
    if (unlikely(errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        stream->SetErrCode(taskInfo->errorCode);
        RT_LOG(RT_LOG_ERROR, "fusion kernel task proc error, retCode=%#x.", errorCode);
        PrintErrorInfo(taskInfo, devId);
    }
}
static void FusionKernelTaskUnInit(TaskInfo *taskInfo)
{
    static_cast<DavidStream *>(taskInfo->stream)->ArgReleaseSingleTask(taskInfo, true);
    FusionTaskInfo * const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    fusionKernelTask->args = nullptr;
    for (uint32_t i = 0; i < FUSION_SUB_TASK_MAX_CPU_NUM; i++) {
        fusionKernelTask->aicpuArgsDesc[i].funcName = nullptr;
        fusionKernelTask->aicpuArgsDesc[i].soName = nullptr;
    }
    RT_LOG(RT_LOG_INFO, "fusion kernel task uninit.");
}

static rtError_t GetArgsInfoForFusionKernelTask(TaskInfo* taskInfo)
{
    FusionTaskInfo *const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    void *hostMem = nullptr;
    COND_RETURN_ERROR_MSG_INNER((fusionKernelTask->args == nullptr) || (fusionKernelTask->argsSize == 0U),
        RT_ERROR_INVALID_VALUE, "Get args info failed, address size=%u", fusionKernelTask->argsSize);
    const auto dev = taskInfo->stream->Device_();
    rtError_t error = dev->Driver_()->HostMemAlloc(&hostMem, static_cast<uint64_t>(fusionKernelTask->argsSize) + 1U,
        dev->Id_());
    ERROR_RETURN(error, "Malloc host memory for args failed, retCode=%#x", static_cast<uint32_t>(error));
    error = dev->Driver_()->MemCopySync(hostMem, static_cast<uint64_t>(fusionKernelTask->argsSize) + 1U,
        fusionKernelTask->args, static_cast<uint64_t>(fusionKernelTask->argsSize), RT_MEMCPY_DEVICE_TO_HOST);
    COND_PROC_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, (void)dev->Driver_()->HostMemFree(hostMem);,
        "Memcpy failed, size=%u, type=%d(RT_MEMCPY_DEVICE_TO_HOST), retCode=%#x",
        fusionKernelTask->argsSize, static_cast<int32_t>(RT_MEMCPY_DEVICE_TO_HOST), static_cast<uint32_t>(error));
    // args info
    const uint32_t totalLen = fusionKernelTask->argsSize / static_cast<uint32_t>(sizeof(void *));
    const uint32_t argsTimes = (totalLen % ARGS_PER_STRING_MAX_LEN > 0) ? static_cast<uint32_t>((totalLen / ARGS_PER_STRING_MAX_LEN) + 1) :
            static_cast<uint32_t>(totalLen / ARGS_PER_STRING_MAX_LEN);
    for (size_t j = 1UL; j <= argsTimes; j++) {
        std::stringstream ss;
        size_t i = 0U;
        uint32_t curLen = totalLen > (j * ARGS_PER_STRING_MAX_LEN) ? (j * ARGS_PER_STRING_MAX_LEN) : totalLen;
        for (i = (j - 1) * ARGS_PER_STRING_MAX_LEN; i < curLen; ++i) {
            ss << RtPtrToPtr<uint64_t *, uint64_t>(*(RtPtrToPtr<uint64_t *, void *>(hostMem) + i)) << ", ";
        }
        RT_LOG(RT_LOG_ERROR, "[FUSION_KERNEL_INFO] args(%u to %u) after execute:%s ",
            (j - 1) * ARGS_PER_STRING_MAX_LEN, curLen, ss.str().c_str());
    }
    RT_LOG(RT_LOG_ERROR, "fusion kernel print %u Times totalLen=(%u*8), argsSize=%u", argsTimes, totalLen,
        fusionKernelTask->argsSize);
    (void)dev->Driver_()->HostMemFree(hostMem);
    return RT_ERROR_NONE;
}

static void PrintErrorInfoForFusionKernelTask(TaskInfo* taskInfo, const uint32_t devId)
{
    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = taskInfo->stream->Id_();
    FusionTaskInfo *const fusionKernelTask = &(taskInfo->u.fusionKernelTask);

    Stream *const reportStream = GetReportStream(taskInfo->stream);
    string kernelNameStr = "";
    string kernelInfoExt = "";
    if ((fusionKernelTask != nullptr) && (fusionKernelTask->aicPart.kernel != nullptr)) {
        kernelNameStr = fusionKernelTask->aicPart.kernel->Name_();
        kernelInfoExt = fusionKernelTask->aicPart.kernel->KernelInfoExtString();
    }

    kernelNameStr = kernelNameStr.empty() ? ("none") : kernelNameStr;
    kernelInfoExt = kernelInfoExt.empty() ? ("none") : kernelInfoExt;

    const rtError_t ret = GetArgsInfoForFusionKernelTask(taskInfo);
    RT_LOG(RT_LOG_ERROR, "Fusion kernel execute failed, device_id=%u, stream_id=%d, report_stream_id=%d, task_id=%u,"
        " flip_num=%hu, kernel_name=%s, kernel info ext=%s", devId, streamId, reportStream->Id_(), taskId,
        taskInfo->flipNum, kernelNameStr.c_str(), kernelInfoExt.c_str());
    STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_TBE, "[FUSION_KERNEL_INFO] after execute: %s",
        (ret != RT_ERROR_NONE) ? "(no result)" : "args print end");
}

static void SetStarsResultForFusionKernelTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq)
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
        RT_LOG(RT_LOG_ERROR, "FusionKernelTask errorCode=%u, logicCq:errType=%u, errCode=%u, "
            "stream_id=%hu, task_id=%hu", taskInfo->errorCode, logicCq.errorType, logicCq.errorCode,
            taskInfo->stream->Id_(), taskInfo->id);
    }
}
#endif

#if F_DESC("CmoTask")
static void PrintErrorInfoForDavidCmoTask(TaskInfo* taskInfo, const uint32_t devId)
{
    const auto dev = taskInfo->stream->Device_();
    CmoAddrTaskInfo *cmoAddrTaskInfo = &(taskInfo->u.cmoAddrTaskInfo);
    Stream * const stream = taskInfo->stream;
    const int32_t streamId = stream->Id_();
    const uint32_t taskId = taskInfo->id;
    if (stream->Model_() == nullptr) {
        return;
    }
    constexpr size_t cmoInfoSize = sizeof(rtDavidCmoAddrInfo) / sizeof(uint32_t);
    std::array<uint32_t, cmoInfoSize> cmoInfo = {0};
    
    const rtError_t error = dev->Driver_()->MemCopySync(RtPtrToPtr<void *>(cmoInfo.data()), sizeof(rtDavidCmoAddrInfo),
        cmoAddrTaskInfo->cmoAddrInfo, sizeof(rtDavidCmoAddrInfo), RT_MEMCPY_DEVICE_TO_HOST);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Memcpy failed, size=%lu(Bytes), type=%d(RT_MEMCPY_DEVICE_TO_HOST), retCode=%#x",
            sizeof(rtDavidCmoAddrInfo), static_cast<int32_t>(RT_MEMCPY_DEVICE_TO_HOST), static_cast<uint32_t>(error));
        return;
    }

    RT_LOG(RT_LOG_ERROR, "Sdma for CmoAddrTask in model stream execute failed, device_id=%u, stream_id=%d, task_id=%u,"
           "cmoAddrInfo=0x%llx.", devId, streamId, taskId, RtPtrToValue(cmoAddrTaskInfo->cmoAddrInfo));
    for (size_t i = 0UL; i < cmoInfoSize; i += 8U) {
        RT_LOG(RT_LOG_ERROR, "%s: %08x %08x %08x %08x %08x %08x %08x %08x", "rtCmoAddrInfo",
            cmoInfo[i], cmoInfo[i + 1U], cmoInfo[i + 2U], cmoInfo[i + 3U], cmoInfo[i + 4U], cmoInfo[i + 5U],
            cmoInfo[i + 6U], cmoInfo[i + 7U]);
    }
}
#endif

#if F_DESC("AicpuMsgVersionTask")
void AicpuMsgVersionTaskInit(TaskInfo *taskInfo)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_TSFW_AICPU_MSG_VERSION;
    taskInfo->typeName = "TSFW_AICPU_MSG_VERSION";

    AicpuMsgVersionTaskInfo *task = &(taskInfo->u.aicpuMsgVersionTask);
    task->magicNum = MAGIC_NUMBER_FOR_AICPU_MSG_VERSION;     /* magic number */
    task->version = AICPU_MSG_VERSION_FOR_DAVID;
    return;
}
#endif

#if F_DESC("钩子注册框架")

static void DavidRegSetStarsResultFunc(void)
{
    for (auto &item : g_setStarsResultFunc) {
        item = &SetStarsResultCommonForDavid;
    }
    g_setStarsResultFunc[TS_TASK_TYPE_KERNEL_AICPU] = &SetStarsResultForDavinciTask;
    g_setStarsResultFunc[TS_TASK_TYPE_KERNEL_AIVEC] = &SetStarsResultForDavinciTask;
    g_setStarsResultFunc[TS_TASK_TYPE_KERNEL_AICORE] = &SetStarsResultForDavinciTask;
    g_setStarsResultFunc[TS_TASK_TYPE_MEMCPY] = &SetStarsResultForMemcpyAsyncTask;
    g_setStarsResultFunc[TS_TASK_TYPE_EVENT_RECORD] = &SetStarsResultForEventRecordTask;
    g_setStarsResultFunc[TS_TASK_TYPE_DAVID_EVENT_RECORD] = &SetStarsResultForDavidEventRecordTask;
    g_setStarsResultFunc[TS_TASK_TYPE_MODEL_EXECUTE] = &SetStarsResultForModelExecuteTask;
    g_setStarsResultFunc[TS_TASK_TYPE_DATADUMP_LOADINFO] = &SetStarsResultForDataDumpLoadInfoTask;
    g_setStarsResultFunc[TS_TASK_TYPE_MODEL_TO_AICPU] = &SetStarsResultForModelToAicpuTask;
    g_setStarsResultFunc[TS_TASK_TYPE_STREAM_WAIT_EVENT] = &SetStarsResultForEventWaitTask;
    g_setStarsResultFunc[TS_TASK_TYPE_DAVID_EVENT_WAIT] = &SetStarsResultForEventWaitTask;
    g_setStarsResultFunc[TS_TASK_TYPE_AICPU_INFO_LOAD] = &SetStarsResultForAicpuInfoLoadTask;
    g_setStarsResultFunc[TS_TASK_TYPE_CCU_LAUNCH] = &SetResultForCcuLaunchTask;
    g_setStarsResultFunc[TS_TASK_TYPE_FUSION_KERNEL] = &SetStarsResultForFusionKernelTask;
    g_setStarsResultFunc[TS_TASK_TYPE_UB_DB_SEND] = &SetResultForUbDmaTask;
    g_setStarsResultFunc[TS_TASK_TYPE_DIRECT_SEND] = &SetResultForUbDmaTask;
}

static void DavidRegPrintErrorInfoFunc(void)
{
    for (auto &item : g_printErrorInfoFunc) {
        item = &PrintErrorInfoCommon;
    }
    g_printErrorInfoFunc[TS_TASK_TYPE_KERNEL_AICPU] = &PrintErrorInfoForDavinciTask;
    g_printErrorInfoFunc[TS_TASK_TYPE_KERNEL_AIVEC] = &PrintErrorInfoForDavinciTask;
    g_printErrorInfoFunc[TS_TASK_TYPE_KERNEL_AICORE] = &PrintErrorInfoForDavinciTask;
    g_printErrorInfoFunc[TS_TASK_TYPE_MEMCPY] = &PrintErrorInfoForMemcpyAsyncTask;
    g_printErrorInfoFunc[TS_TASK_TYPE_MODEL_MAINTAINCE] = &PrintErrorInfoForModelMaintainceTask;
    g_printErrorInfoFunc[TS_TASK_TYPE_MODEL_EXECUTE] = &PrintErrorInfoForModelExecuteTask;
    g_printErrorInfoFunc[TS_TASK_TYPE_MODEL_TO_AICPU] = &PrintErrorInfoForModelToAicpuTask;
    g_printErrorInfoFunc[TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX] = &PrintErrorInfoForStreamLabelSwitchByIndexTask;
    g_printErrorInfoFunc[TS_TASK_TYPE_STARS_COMMON] = &PrintErrorInfoForStarsCommonTask;
    g_printErrorInfoFunc[TS_TASK_TYPE_NOTIFY_WAIT] = &PrintErrorInfoForNotifyWaitTask;
    g_printErrorInfoFunc[TS_TASK_TYPE_STREAM_SWITCH] = &PrintErrorInfoForStreamSwitchTask;
    g_printErrorInfoFunc[TS_TASK_TYPE_STREAM_ACTIVE] = &PrintErrorInfoForStreamActiveTask;
    g_printErrorInfoFunc[TS_TASK_TYPE_STREAM_WAIT_EVENT] = &PrintErrorInfoForEventWaitTask;
    g_printErrorInfoFunc[TS_TASK_TYPE_DAVID_EVENT_WAIT] = &PrintErrorInfoForDavidEventWaitTask;
    g_printErrorInfoFunc[TS_TASK_TYPE_CMO] = &PrintErrorInfoForDavidCmoTask;
    g_printErrorInfoFunc[TS_TASK_TYPE_CCU_LAUNCH] = &PrintErrorInfoForCcuLaunchTask;
    g_printErrorInfoFunc[TS_TASK_TYPE_FUSION_KERNEL] = &PrintErrorInfoForFusionKernelTask;
    g_printErrorInfoFunc[TS_TASK_TYPE_UB_DB_SEND] = &PrintErrorInfoForUbDbSendTask;
    g_printErrorInfoFunc[TS_TASK_TYPE_DIRECT_SEND] = &PrintErrorInfoForUbDirectSendTask;
}

static void DavidRegTaskUnInitFunc(void)
{
    for (uint32_t i = 0U; i < TS_TASK_TYPE_RESERVED; i++) {
        g_taskUnInitFunc[i] = nullptr;
    }

    g_taskUnInitFunc[TS_TASK_TYPE_KERNEL_AICORE] = &DavinciTaskUnInit;
    g_taskUnInitFunc[TS_TASK_TYPE_KERNEL_AIVEC] = &DavinciTaskUnInit;
    g_taskUnInitFunc[TS_TASK_TYPE_KERNEL_AICPU] = &DavinciTaskUnInit;
    g_taskUnInitFunc[TS_TASK_TYPE_MULTIPLE_TASK] = &DavinciMultipleTaskUnInit;
    g_taskUnInitFunc[TS_TASK_TYPE_MEMCPY] = &MemcpyAsyncTaskUnInit;
    g_taskUnInitFunc[TS_TASK_TYPE_EVENT_RECORD] = &EventRecordTaskUnInit;
    g_taskUnInitFunc[TS_TASK_TYPE_EVENT_RESET] = &EventResetTaskUnInit;
    g_taskUnInitFunc[TS_TASK_TYPE_DAVID_EVENT_RECORD] = &DavidEventRecordTaskUnInit;
    g_taskUnInitFunc[TS_TASK_TYPE_DAVID_EVENT_RESET] = &DavidEventResetTaskUnInit;
    g_taskUnInitFunc[TS_TASK_TYPE_DAVID_EVENT_WAIT] = &DavidEventWaitTaskUnInit;
    g_taskUnInitFunc[TS_TASK_TYPE_MODEL_EXECUTE] = &ModelExecuteTaskUnInit;
    g_taskUnInitFunc[TS_TASK_TYPE_STREAM_SWITCH] = &StreamSwitchTaskUnInit;
    g_taskUnInitFunc[TS_TASK_TYPE_STREAM_ACTIVE] = &StreamActiveTaskUnInit;
    g_taskUnInitFunc[TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX] = &StreamLabelSwitchByIndexTaskUnInit;
    g_taskUnInitFunc[TS_TASK_TYPE_STARS_COMMON] = &StarsCommonTaskUnInit;
    g_taskUnInitFunc[TS_TASK_TYPE_FUSION_KERNEL] = &FusionKernelTaskUnInit;
    g_taskUnInitFunc[TS_TASK_TYPE_MEM_WAIT_VALUE] = &MemWaitTaskUnInit;
}

static void DavidRegDoCompleteSuccFunc(void)
{
    for (auto &item : g_doCompleteSuccFunc) {
        item = &DoCompleteSuccess;
    }
    g_doCompleteSuccFunc[TS_TASK_TYPE_KERNEL_AIVEC] = &DoCompleteSuccessForDavinciTask;
    g_doCompleteSuccFunc[TS_TASK_TYPE_KERNEL_AICORE] = &DoCompleteSuccessForDavinciTask;
    g_doCompleteSuccFunc[TS_TASK_TYPE_KERNEL_AICPU] = &DoCompleteSuccessForDavinciTask;

    g_doCompleteSuccFunc[TS_TASK_TYPE_MEMCPY] = &DoCompleteSuccessForMemcpyAsyncTask;

    g_doCompleteSuccFunc[TS_TASK_TYPE_EVENT_RECORD] = &DoCompleteSuccessForEventRecordTask;
    g_doCompleteSuccFunc[TS_TASK_TYPE_STREAM_WAIT_EVENT] = &DoCompleteSuccessForEventWaitTask;
    g_doCompleteSuccFunc[TS_TASK_TYPE_EVENT_RESET] = &DoCompleteSuccessForEventResetTask;
    g_doCompleteSuccFunc[TS_TASK_TYPE_DAVID_EVENT_RECORD] = &DoCompleteSuccessForDavidEventRecordTask;
    g_doCompleteSuccFunc[TS_TASK_TYPE_DAVID_EVENT_WAIT] = &DoCompleteSuccessForDavidEventWaitTask;
    g_doCompleteSuccFunc[TS_TASK_TYPE_DAVID_EVENT_RESET] = &DoCompleteSuccessForDavidEventResetTask;

    g_doCompleteSuccFunc[TS_TASK_TYPE_NOTIFY_WAIT] = &DoCompleteSuccessForNotifyWaitTask;
    g_doCompleteSuccFunc[TS_TASK_TYPE_NOTIFY_RECORD] = &DoCompleteSuccessForNotifyRecordTask;

    g_doCompleteSuccFunc[TS_TASK_TYPE_MODEL_MAINTAINCE] = &DoCompleteSuccessForModelMaintainceTask;
    g_doCompleteSuccFunc[TS_TASK_TYPE_MODEL_EXECUTE] = &DoCompleteSuccessForModelExecuteTask;
    g_doCompleteSuccFunc[TS_TASK_TYPE_MODEL_TO_AICPU] = &DoCompleteSuccForModelToAicpuTask;

    g_doCompleteSuccFunc[TS_TASK_TYPE_CCU_LAUNCH] = &DoCompleteSuccessForCcuLaunchTask;
    g_doCompleteSuccFunc[TS_TASK_TYPE_UB_DB_SEND] = &DoCompleteSuccessForUbDmaDbModeTask;
    g_doCompleteSuccFunc[TS_TASK_TYPE_DIRECT_SEND] = &DoCompleteSuccessForUbDmaDirectWqeModeTask;
    g_doCompleteSuccFunc[TS_TASK_TYPE_FUSION_KERNEL] = &DoCompleteSuccessForFusionKernelTask;
}


void RegDavidTaskFunc(void)
{
    RegTaskToCommandFunc();
    RegTaskToDavidSqefunc();
    DavidRegTaskUnInitFunc();
    DavidRegDoCompleteSuccFunc();
    DavidRegPrintErrorInfoFunc();
    DavidRegSetStarsResultFunc();
    return;
}
#endif
}  // namespace runtime
}  // namespace cce