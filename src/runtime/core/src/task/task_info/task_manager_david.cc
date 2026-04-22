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
#include "model_execute_task.h"
#include "model_graph_task.h"
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
#include "cond_op_stream_task.h"
#include "cond_op_label_task.h"
#include "debug_task.h"
#include "stream_task.h"
#include "davinci_multiple_task.h"
#include "stars_common_task.h"
#include "cmo_task.h"
#include "dump_task.h"
#include "barrier_task.h"
#include "model_maintaince_task.h"
#include "notify_record_task.h"
#include "timeout_set_task.h"
#include "ringbuffer_maintain_task.h"
#include "model_update_task.h"
#include "model_to_aicpu_task.h"
#include "maintenance_task.h"
#include "davinci_kernel_task.h"
#include "task_info.h"
#include "ccu_task.hpp"
#include "error_code.h"
#include "task_manager.h"
#include "task_manager_david.h"
#include "device_error_proc.hpp"
#include "starsv2_base.hpp"
#include "fusion_task_david.hpp"
#include <vector>
namespace cce {
namespace runtime {

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

rtError_t UbDbSendTaskInit(TaskInfo* taskInfo, const rtUbDbInfo_t *dbInfo, const uint16_t source)
{
    TaskCommonInfoInit(taskInfo);
    UbSendTaskInfo *ubSend = &taskInfo->u.ubSendTask;
    taskInfo->type = TS_TASK_TYPE_UB_DB_SEND;
    taskInfo->typeName = const_cast<char_t*>("UB_DB_SEND");
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

static void PrintErrorInfoForUbDbSendTask(TaskInfo *taskInfo, const uint32_t devId)
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
static void DavidRegDoCompleteSuccFunc(const std::vector<rtChipType_t> &chipTypes)
{
    for (auto chipType : chipTypes) {
        auto &doCompleteSuccFunc = g_taskFuncArrays[chipType].doCompleteSuccFunc;
        for (auto &item : doCompleteSuccFunc) {
            item = &DoCompleteSuccess;
        }

        doCompleteSuccFunc[TS_TASK_TYPE_KERNEL_AIVEC] = &DoCompleteSuccessForDavinciTask;
        doCompleteSuccFunc[TS_TASK_TYPE_KERNEL_AICORE] = &DoCompleteSuccessForDavinciTask;
        doCompleteSuccFunc[TS_TASK_TYPE_KERNEL_AICPU] = &DoCompleteSuccessForDavinciTask;
        
        doCompleteSuccFunc[TS_TASK_TYPE_MEMCPY] = &StarsV2DoCompleteSuccessForMemcpyAsyncTask;
        
        doCompleteSuccFunc[TS_TASK_TYPE_EVENT_RECORD] = &DoCompleteSuccessForEventRecordTask;
        doCompleteSuccFunc[TS_TASK_TYPE_STREAM_WAIT_EVENT] = &DoCompleteSuccessForEventWaitTask;
        doCompleteSuccFunc[TS_TASK_TYPE_EVENT_RESET] = &DoCompleteSuccessForEventResetTask;
        doCompleteSuccFunc[TS_TASK_TYPE_DAVID_EVENT_RECORD] = &DoCompleteSuccessForDavidEventRecordTask;
        doCompleteSuccFunc[TS_TASK_TYPE_DAVID_EVENT_WAIT] = &DoCompleteSuccessForDavidEventWaitTask;
        doCompleteSuccFunc[TS_TASK_TYPE_DAVID_EVENT_RESET] = &DoCompleteSuccessForDavidEventResetTask;
        
        doCompleteSuccFunc[TS_TASK_TYPE_NOTIFY_WAIT] = &DoCompleteSuccessForNotifyWaitTask;
        doCompleteSuccFunc[TS_TASK_TYPE_NOTIFY_RECORD] = &DoCompleteSuccessForNotifyRecordTask;
        
        doCompleteSuccFunc[TS_TASK_TYPE_MODEL_MAINTAINCE] = &DoCompleteSuccessForModelMaintainceTask;
        doCompleteSuccFunc[TS_TASK_TYPE_MODEL_EXECUTE] = &DoCompleteSuccessForModelExecuteTask;
        doCompleteSuccFunc[TS_TASK_TYPE_MODEL_TO_AICPU] = &DoCompleteSuccForModelToAicpuTask;
        
        doCompleteSuccFunc[TS_TASK_TYPE_CCU_LAUNCH] = &DoCompleteSuccessForCcuLaunchTask;
        doCompleteSuccFunc[TS_TASK_TYPE_UB_DB_SEND] = &DoCompleteSuccessForUbDmaDbModeTask;
        doCompleteSuccFunc[TS_TASK_TYPE_DIRECT_SEND] = &DoCompleteSuccessForUbDmaDirectWqeModeTask;
        doCompleteSuccFunc[TS_TASK_TYPE_FUSION_KERNEL] = &DoCompleteSuccessForFusionKernelTask;
    }
}

static void DavidRegTaskUnInitFunc(const std::vector<rtChipType_t> &chipTypes)
{
    PfnTaskUnInit *taskUnInitFunc = nullptr;
    for (auto chipType : chipTypes) {
        taskUnInitFunc = g_taskFuncArrays[chipType].taskUnInitFunc;
        for (uint32_t i = 0U; i < TS_TASK_TYPE_RESERVED; i++) {
            taskUnInitFunc[i] = nullptr;
        }

        taskUnInitFunc[TS_TASK_TYPE_KERNEL_AICORE] = &DavinciTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_KERNEL_AIVEC] = &DavinciTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_KERNEL_AICPU] = &DavinciTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_MULTIPLE_TASK] = &DavinciMultipleTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_MEMCPY] = &StarsV2MemcpyAsyncTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_EVENT_RECORD] = &EventRecordTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_EVENT_RESET] = &EventResetTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_DAVID_EVENT_RECORD] = &DavidEventRecordTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_DAVID_EVENT_RESET] = &DavidEventResetTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_DAVID_EVENT_WAIT] = &DavidEventWaitTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_MODEL_EXECUTE] = &ModelExecuteTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_STREAM_SWITCH] = &StreamSwitchTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_STREAM_ACTIVE] = &StreamActiveTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX] = &StreamLabelSwitchByIndexTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_STARS_COMMON] = &StarsCommonTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_FUSION_KERNEL] = &FusionKernelTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_MEM_WAIT_VALUE] = &MemWaitTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_IPC_WAIT] = &StarsV2IpcEventWaitTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_IPC_RECORD] = &StarsV2IpcEventRecordTaskUnInit;
    }
}

static void DavidRegPrintErrorInfoFunc(const std::vector<rtChipType_t> &chipTypes)
{
    for (auto chipType : chipTypes) {
        auto &printErrorInfoFunc = g_taskFuncArrays[chipType].printErrorInfoFunc;
        for (auto &item : printErrorInfoFunc) {
            item = &PrintErrorInfoCommon;
        }

        printErrorInfoFunc[TS_TASK_TYPE_KERNEL_AICPU] = &PrintErrorInfoForDavinciTask;
        printErrorInfoFunc[TS_TASK_TYPE_KERNEL_AIVEC] = &PrintErrorInfoForDavinciTask;
        printErrorInfoFunc[TS_TASK_TYPE_KERNEL_AICORE] = &PrintErrorInfoForDavinciTask;
        printErrorInfoFunc[TS_TASK_TYPE_MEMCPY] = &PrintErrorInfoForMemcpyAsyncTask;
        printErrorInfoFunc[TS_TASK_TYPE_MODEL_MAINTAINCE] = &PrintErrorInfoForModelMaintainceTask;
        printErrorInfoFunc[TS_TASK_TYPE_MODEL_EXECUTE] = &PrintErrorInfoForModelExecuteTask;
        printErrorInfoFunc[TS_TASK_TYPE_MODEL_TO_AICPU] = &PrintErrorInfoForModelToAicpuTask;
        printErrorInfoFunc[TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX] = &PrintErrorInfoForStreamLabelSwitchByIndexTask;
        printErrorInfoFunc[TS_TASK_TYPE_STARS_COMMON] = &PrintErrorInfoForStarsCommonTask;
        printErrorInfoFunc[TS_TASK_TYPE_NOTIFY_WAIT] = &PrintErrorInfoForNotifyWaitTask;
        printErrorInfoFunc[TS_TASK_TYPE_STREAM_SWITCH] = &PrintErrorInfoForStreamSwitchTask;
        printErrorInfoFunc[TS_TASK_TYPE_STREAM_ACTIVE] = &PrintErrorInfoForStreamActiveTask;
        printErrorInfoFunc[TS_TASK_TYPE_STREAM_WAIT_EVENT] = &PrintErrorInfoForEventWaitTask;
        printErrorInfoFunc[TS_TASK_TYPE_DAVID_EVENT_WAIT] = &PrintErrorInfoForDavidEventWaitTask;
        printErrorInfoFunc[TS_TASK_TYPE_CMO] = &PrintErrorInfoForDavidCmoTask;
        printErrorInfoFunc[TS_TASK_TYPE_CCU_LAUNCH] = &PrintErrorInfoForCcuLaunchTask;
        printErrorInfoFunc[TS_TASK_TYPE_FUSION_KERNEL] = &PrintErrorInfoForFusionKernelTask;
        printErrorInfoFunc[TS_TASK_TYPE_UB_DB_SEND] = &PrintErrorInfoForUbDbSendTask;
        printErrorInfoFunc[TS_TASK_TYPE_DIRECT_SEND] = &PrintErrorInfoForUbDirectSendTask;
    }
}

static void DavidRegSetStarsResultFunc(const std::vector<rtChipType_t> &chipTypes)
{
    for (auto chipType : chipTypes) {
        auto &setStarsResultFunc = g_taskFuncArrays[chipType].setStarsResultFunc;
        for (auto &item : setStarsResultFunc) {
            item = &SetStarsResultCommonForDavid;
        }

        setStarsResultFunc[TS_TASK_TYPE_KERNEL_AICPU] = &SetStarsResultForDavinciTask;
        setStarsResultFunc[TS_TASK_TYPE_KERNEL_AIVEC] = &SetStarsResultForDavinciTask;
        setStarsResultFunc[TS_TASK_TYPE_KERNEL_AICORE] = &SetStarsResultForDavinciTask;
        setStarsResultFunc[TS_TASK_TYPE_MEMCPY] = &SetStarsResultForMemcpyAsyncTask;
        setStarsResultFunc[TS_TASK_TYPE_EVENT_RECORD] = &SetStarsResultForEventRecordTask;
        setStarsResultFunc[TS_TASK_TYPE_DAVID_EVENT_RECORD] = &SetStarsResultForDavidEventRecordTask;
        setStarsResultFunc[TS_TASK_TYPE_MODEL_EXECUTE] = &SetStarsResultForModelExecuteTask;
        setStarsResultFunc[TS_TASK_TYPE_DATADUMP_LOADINFO] = &SetStarsResultForDataDumpLoadInfoTask;
        setStarsResultFunc[TS_TASK_TYPE_MODEL_TO_AICPU] = &SetStarsResultForModelToAicpuTask;
        setStarsResultFunc[TS_TASK_TYPE_STREAM_WAIT_EVENT] = &SetStarsResultForEventWaitTask;
        setStarsResultFunc[TS_TASK_TYPE_DAVID_EVENT_WAIT] = &SetStarsResultForEventWaitTask;
        setStarsResultFunc[TS_TASK_TYPE_AICPU_INFO_LOAD] = &SetStarsResultForAicpuInfoLoadTask;
        setStarsResultFunc[TS_TASK_TYPE_CCU_LAUNCH] = &SetResultForCcuLaunchTask;
        setStarsResultFunc[TS_TASK_TYPE_FUSION_KERNEL] = &SetStarsResultForFusionKernelTask;
        setStarsResultFunc[TS_TASK_TYPE_UB_DB_SEND] = &SetResultForUbDmaTask;
        setStarsResultFunc[TS_TASK_TYPE_DIRECT_SEND] = &SetResultForUbDmaTask;
    }
}

void RegDavidTaskFunc(void)
{
    static const std::vector<rtChipType_t> chipTypes = {
        CHIP_DAVID, CHIP_CLOUD_V5, CHIP_MC62CM12A, CHIP_XPU
    };
    RegTaskToCommandFunc(chipTypes);
    RegTaskToDavidSqefunc();
    DavidRegTaskUnInitFunc(chipTypes);
    DavidRegDoCompleteSuccFunc(chipTypes);
    DavidRegPrintErrorInfoFunc(chipTypes);
    DavidRegSetStarsResultFunc(chipTypes);
    return;
}
#endif
}  // namespace runtime
}  // namespace cce
