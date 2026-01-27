/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream.hpp"
#include "runtime.hpp"
#include "driver.hpp"
#include "thread_local_container.hpp"
#include "stars_cond_isa_helper.hpp"
#include "event.hpp"
#include "notify.hpp"
#include "task_fail_callback_manager.hpp"
#include "device/device_error_proc.hpp"
#include "hwts.hpp"
#include "stars_common_task.h"
#include "task_manager.h"
#include "model.hpp"
#include "error_code.h"
#include "davinci_kernel_task.h"
#include "rdma_task.h"
#include "stub_task.hpp"
#include "task_scheduler_error.h"

namespace cce {
namespace runtime {
namespace {
bool IsSdmaMteErrorCode(const int32_t errCode)
{
    return (errCode == TS_ERROR_SDMA_LINK_ERROR) || (errCode == TS_ERROR_SDMA_POISON_ERROR) ||
           (errCode == TS_ERROR_SDMA_DDRC_ERROR) || (errCode == AICPU_HCCL_OP_SDMA_LINK_FAILED);
}
} // namespace

#if F_DESC("CreateL2AddrTask")

rtError_t CreateL2AddrTaskInit(TaskInfo * const taskInfo, const uint64_t ptePtrAddr)
{
    CreateL2AddrTaskInfo *createL2AddrTaskInfo = &(taskInfo->u.createL2AddrTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_CREATE_L2_ADDR;
    taskInfo->typeName = "CREATE_L2_ADDR";
    createL2AddrTaskInfo->ptePA = ptePtrAddr;
    return RT_ERROR_NONE;
}

void ToCommandBodyForCreateL2AddrTask(TaskInfo * const taskInfo, rtCommand_t *const command)
{
    CreateL2AddrTaskInfo *createL2AddrTaskInfo = &(taskInfo->u.createL2AddrTaskInfo);
    Stream * const stream = taskInfo->stream;

    command->u.createL2Addr.l2BaseVaddrForsdma =
        RtPtrToValue<void *>(stream->Device_()->GetL2Buffer_());
    RT_LOG(RT_LOG_DEBUG, "l2BaseVaddrForsdma=%#" PRIx64, command->u.createL2Addr.l2BaseVaddrForsdma);
    command->u.createL2Addr.ptePA = createL2AddrTaskInfo->ptePA;
    RT_LOG(RT_LOG_DEBUG, "ptePA=%#" PRIx64, command->u.createL2Addr.ptePA);
    command->u.createL2Addr.pid = PidTidFetcher::GetCurrentPid();
    command->u.createL2Addr.virAddr = MAX_UINT32_NUM;
}

#endif


#if F_DESC("KernelFusionTask")

rtError_t KernelFusionTaskInit(TaskInfo * const taskInfo, const FusionFlag fusFlag)
{
    KernelFusionTaskInfo *kernelFusionTaskInfo = &(taskInfo->u.kernelFusionTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_FUSION_ISSUE;
    taskInfo->typeName = "KERNEL_FUSION";
    kernelFusionTaskInfo->flag = fusFlag;
    return RT_ERROR_NONE;
}

void ToCommandBodyForKernelFusionTask(TaskInfo * const taskInfo, rtCommand_t *const command)
{
    KernelFusionTaskInfo *kernelFusionTaskInfo = &(taskInfo->u.kernelFusionTaskInfo);
    command->u.fusion.flag = kernelFusionTaskInfo->flag;
}

#endif

#if F_DESC("AllocDsaAddrTask")
rtError_t AllocDsaAddrTaskInit(TaskInfo * const taskInfo, const uint16_t sqId)
{
    AllocDsaAddrInfoTaskInfo *dsaTaskInfo = &(taskInfo->u.allocDsaAddrTask);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_ALLOC_DSA_ADDR;
    taskInfo->typeName = "ALLOC_DSA_ADDR";
    dsaTaskInfo->sqId = sqId;

    return RT_ERROR_NONE;
}

void ConstructSqeForAllocDsaAddrTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    AllocDsaAddrInfoTaskInfo *dsaTaskInfo = &(taskInfo->u.allocDsaAddrTask);
    Stream *const stm = taskInfo->stream;

    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = 1U;
    sqe->res0 = 0U;
    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_ALLOC_DSA_ADDR;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.allocDsaAddrInfo.sq_id = dsaTaskInfo->sqId;
    PrintSqe(command, "AllocDsaAddrTask");
    RT_LOG(RT_LOG_INFO, "Send AllocDsaAddrTask succ, "
        "sqe_type=%u, pre_p=%u, stream_id=%u, task_id=%u, task_type=%u, dsa_sq_id=%u.",
        sqe->type, sqe->pre_p, sqe->rt_streamID, sqe->task_id, sqe->task_type, dsaTaskInfo->sqId);
}
#endif

#if F_DESC("PCTraceTask")
void PCTraceTaskUnInit(TaskInfo * const taskInfo)
{
    taskInfo->pcTrace.reset();
}

rtError_t PCTraceTaskInit(TaskInfo * const taskInfo, const uint16_t enableTaskIndex,
                          const uint16_t coreDims, std::shared_ptr<PCTrace> pcTracePtr)
{
    NULL_PTR_RETURN_MSG(pcTracePtr, RT_ERROR_PCTRACE_NULL);

    PCTraceTaskInfo *pcTraceTaskInfo = &(taskInfo->u.pcTraceTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_PCTRACE_ENABLE;
    taskInfo->typeName = "PC_TRACE";

    pcTraceTaskInfo->enableTaskID = enableTaskIndex;
    pcTraceTaskInfo->coreDim = coreDims;
    taskInfo->pcTrace = std::move(pcTracePtr);
    pcTraceTaskInfo->pctraceAddr = taskInfo->pcTrace->GetPcTraceAddr();
    return RT_ERROR_NONE;
}

void ToCommandBodyForPCTraceTask(TaskInfo * const taskInfo, rtCommand_t *const command)
{
    PCTraceTaskInfo *pcTraceTaskInfo = &(taskInfo->u.pcTraceTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();

    rtError_t error;
    uint64_t pctracePhyAddr;
    const int32_t devId = static_cast<int32_t>(stream->Device_()->Id_());
    error = driver->MemAddressTranslate(devId, pcTraceTaskInfo->pctraceAddr, &pctracePhyAddr);
    COND_RETURN_VOID(error != RT_ERROR_NONE, "translate virtual address to physic failed, retCode=%#x.", error);
    RT_LOG(RT_LOG_INFO, "PC trace address=%#" PRIx64 ", physical address=%#" PRIx64,
        pcTraceTaskInfo->pctraceAddr, pctracePhyAddr);

    command->u.pctraceTask.enableTaskID = pcTraceTaskInfo->enableTaskID;
    command->u.pctraceTask.contentAddr = pctracePhyAddr;
    command->u.pctraceTask.coreDim = pcTraceTaskInfo->coreDim;
    command->u.pctraceTask.virAddr = MAX_UINT32_NUM;
}

#endif

#if F_DESC("NotifyWaitTask")
rtError_t NotifyWaitTaskInit(TaskInfo *taskInfo, const uint32_t notifyIndex, const uint32_t timeOutNum,
    const CountNotifyWaitInfo * const cntNtfyInfo, void * const inNotify, const bool isCountNotify)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_NOTIFY_WAIT;
    taskInfo->typeName = "NOTIFY_WAIT";

    NotifyWaitTaskInfo* notifyWaitTask = &(taskInfo->u.notifywaitTask);
    notifyWaitTask->notifyId = notifyIndex;
    notifyWaitTask->timeout = timeOutNum;
    notifyWaitTask->timestamp = 0UL;
    notifyWaitTask->isEndGraphNotify = false;
    notifyWaitTask->captureModel = nullptr;
    notifyWaitTask->isCountNotify = isCountNotify;
    if (isCountNotify) {
        if (inNotify == nullptr) {
            return RT_ERROR_NOTIFY_NULL;
        }
        notifyWaitTask->u.countNotify = static_cast<CountNotify *>(inNotify);
        notifyWaitTask->cntNtfyInfo = *cntNtfyInfo;
    } else {
        notifyWaitTask->u.notify = static_cast<Notify *>(inNotify);
    }
    return RT_ERROR_NONE;
}

void ToCommandBodyForNotifyWaitTask(TaskInfo *taskInfo, rtCommand_t *const command)
{
    command->u.notifywaitTask.notifyid = static_cast<uint16_t>(taskInfo->u.notifywaitTask.notifyId);
    command->u.notifywaitTask.timeout = static_cast<uint32_t>(taskInfo->u.notifywaitTask.timeout);
    command->taskInfoFlag = taskInfo->stream->GetTaskRevFlag(taskInfo->bindFlag);
}

void ConstructSqeForNotifyWaitTask(TaskInfo *taskInfo, rtStarsSqe_t *const command)
{
    NotifyWaitTaskInfo* notifyWaitTask = &(taskInfo->u.notifywaitTask);
    Stream* const stream = taskInfo->stream;
    RtStarsNotifySqe *const sqe = &(command->notifySqe);
    sqe->header.type = RT_STARS_SQE_TYPE_NOTIFY_WAIT;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wr_cqe = stream->GetStarsWrCqeFlag();
    sqe->kernel_credit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;
    sqe->header.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    sqe->notify_id = notifyWaitTask->notifyId;
    sqe->header.task_id = taskInfo->id;

    sqe->res2 = 0U;
    sqe->res3 = 0U;
    sqe->timeout = notifyWaitTask->timeout;

    PrintSqe(command, "NotifyWaitTask");
    RT_LOG(RT_LOG_INFO, "notify_wait: notify_id=%u, stream_id=%d, task_id=%hu, sq_id=%u, device_id=%u, "
        "timeout=%us.", notifyWaitTask->notifyId, stream->Id_(), taskInfo->id, stream->GetSqId(),
        stream->Device_()->Id_(), notifyWaitTask->timeout);
}

void PrintErrorInfoForNotifyWaitTask(TaskInfo *const taskInfo, const uint32_t devId)
{
    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = taskInfo->stream->Id_();
    Stream *const reportStream = GetReportStream(taskInfo->stream);
    STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_HCCL,
        "Notify wait execute failed, device_id=%u, stream_id=%d, %s=%u, flip_num=%hu, "
        "notify_id=%u, isCountNotify=%u.", devId, streamId, TaskIdDesc(), taskId, taskInfo->flipNum,
        taskInfo->u.notifywaitTask.notifyId, taskInfo->u.notifywaitTask.isCountNotify);
}

void MapNotifyErrorCodeForFastRecovery(TaskInfo *taskInfo, const uint32_t devId)
{
    Stream * const stream = taskInfo->stream;
    if (taskInfo->errorCode == AICPU_HCCL_OP_RETRY_FAILED) {
        taskInfo->errorCode = TS_ERROR_AICPU_HCCL_OP_RETRY_FAILED;
    } else if (taskInfo->errorCode == AICPU_HCCL_OP_UB_DDRC_FAILED) {
        if(HasMteErr(stream->Device_()) && IsEventIdAndRasCodeMatch(stream->Device_()->Id_(), g_ubNonMemPoisonRasList) && !HasMemUceErr(stream->Device_()->Id_(), g_aicOrSdmaOrHcclLocalMulBitEccEventIdBlkList)) {
            taskInfo->errorCode = TS_ERROR_LOCAL_MEM_ERROR;
            RT_LOG(RT_LOG_ERROR,
                "hccl aicpu task error is local mem error, device_id=%u, stream_id=%d, task_id=%hu, taskInfo->errorCode=%u",
                devId, stream->Id_(), taskInfo->id, taskInfo->errorCode);
        }  
    } else if (taskInfo->errorCode == AICPU_HCCL_OP_UB_POISON_FAILED) {
        if (!HasMteErr(stream->Device_()) && !HasMemUceErr(stream->Device_()->Id_(), g_hcclRemoteMulBitEccEventIdBlkList)) {
            taskInfo->errorCode = TS_ERROR_REMOTE_MEM_ERROR;
            RT_LOG(RT_LOG_ERROR,
                "hccl aicpu task error is remote mem error, device_id=%u, stream_id=%d, task_id=%hu, taskInfo->errorCode=%u",
                devId, stream->Id_(), taskInfo->id, taskInfo->errorCode);
        }
    }
}

static void ReportNotifyErrorForNotifyWaitTask(TaskInfo *taskInfo, const uint32_t devId)
{
    Stream * const stream = taskInfo->stream;
    if (IsSdmaMteErrorCode(static_cast<int32_t>(taskInfo->errorCode))) {
        if (HasMteErr(stream->Device_())) {
            taskInfo->errorCode = TS_ERROR_SDMA_POISON_ERROR;
        } else if (!HasMemUceErr(stream->Device_()->Id_())) {
            taskInfo->errorCode = TS_ERROR_SDMA_LINK_ERROR;
        } else {
            taskInfo->errorCode = TS_ERROR_SDMA_ERROR;
        }
    } else {
        MapNotifyErrorCodeForFastRecovery(taskInfo, devId);
    }
    const uint32_t errorCode = taskInfo->errorCode;
    RT_LOG(RT_LOG_ERROR, "Kernel task happen error, retCode=%#x, [%s].",
        errorCode, GetTsErrCodeDesc(errorCode));
    stream->SetErrCode(errorCode);
    PrintErrorInfoForNotifyWaitTask(taskInfo, devId);
    TaskFailCallBack(static_cast<uint32_t>(stream->Id_()), static_cast<uint32_t>(taskInfo->id),
        taskInfo->tid, errorCode, stream->Device_());
}

void DoCompleteSuccessForNotifyWaitTask(TaskInfo *taskInfo, const uint32_t devId)
{
    if (unlikely(taskInfo->errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        if ((!taskInfo->u.notifywaitTask.isCountNotify) && (taskInfo->u.notifywaitTask.u.notify != nullptr) &&
            (taskInfo->u.notifywaitTask.u.notify->GetEndGraphModel() != nullptr)) {
            ReportModelEndGraphErrorForNotifyWaitTask(taskInfo, devId);
        } else {
            ReportNotifyErrorForNotifyWaitTask(taskInfo, devId);
        }
    }

    if (Runtime::Instance()->ChipIsHaveStars() && (!(taskInfo->bindFlag))) {
        Stream* const stream = taskInfo->stream;
        RT_LOG(RT_LOG_INFO, "[DFX_SYNC] notify wait finish. notify_id=%u, stream_id=%d, task_id=%hu, sq_id=%u,"
            " device_id=%u", taskInfo->u.notifywaitTask.notifyId, stream->Id_(), taskInfo->id,
            stream->GetSqId(), stream->Device_()->Id_());
        PrintDfxInfoForRdmaPiValueModifyTask(taskInfo, devId);
    }

    if ((taskInfo->u.notifywaitTask.isEndGraphNotify) &&
        (taskInfo->u.notifywaitTask.captureModel != nullptr)) {
        taskInfo->stream->Device_()->DeleteEndGraphNotifyInfo(taskInfo->stream,
            taskInfo->u.notifywaitTask.captureModel, taskInfo->pos);
    }
}

TaskInfo* GetRealReportFaultTaskForNotifyWaitTask(TaskInfo *taskInfo, const void *info)
{
    Notify* const notify = taskInfo->u.notifywaitTask.u.notify;
    if (unlikely(notify == nullptr)) {
        return nullptr;
    }

    if (notify->GetEndGraphModel() != nullptr) {
        rtStarsCqeSwStatus_t sw_status;
        sw_status.value = *(static_cast<const uint32_t *>(info));
        uint16_t streamId = sw_status.model_exec.stream_id;
        uint16_t taskId = sw_status.model_exec.task_id;
        Device *const dev = taskInfo->stream->Device_();
        if ((dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_ACL_GRAPH_SOFTWARE_ENABLE)) && 
            (dev->CheckFeatureSupport(TS_FEATURE_SOFTWARE_SQ_ENABLE))) {
            streamId = notify->GetEndGraphModel()->GetStreamIdBySqId(sw_status.model_exec_ex.sq_id);
            taskId = sw_status.model_exec_ex.task_id;
        }

        TaskInfo *taskPtr = GetTaskInfo(dev, static_cast<uint32_t>(streamId), static_cast<uint32_t>(taskId));
        
        return taskPtr;
    }
    return nullptr;
}

#endif

#if F_DESC("NotifyResetTask")
rtError_t NotifyResetTaskInit(TaskInfo *taskInfo, const uint32_t notifyIndex,
    const SingleBitNotifyRecordInfo * const singleInfo, void * const notify)
{
    COND_RETURN_ERROR((notify == nullptr), RT_ERROR_NOTIFY_NULL, "notify is nullptr.");
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_NOTIFY_RECORD;
    taskInfo->typeName = "NOTIFY_RESET";
    NotifyRecordTaskInfo *notifyReset = &(taskInfo->u.notifyrecordTask);
    notifyReset->notifyId = notifyIndex;
    notifyReset->isCountNotify = false;
    notifyReset->uPtr.notify = static_cast<Notify *>(notify);
    notifyReset->uInfo.singleBitNtfyInfo = *singleInfo;
    return RT_ERROR_NONE;
}

#endif

rtError_t NopTaskInit(TaskInfo* taskInfo)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_NOP;
    taskInfo->typeName = "NOP";
    return RT_ERROR_NONE;
}

#if F_DESC("AicpuInfoLoadTask")
rtError_t AicpuInfoLoadTaskInit(TaskInfo* taskInfo, const void *const aicpuInfo, const uint32_t len)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_AICPU_INFO_LOAD;
    taskInfo->typeName = "AICPU_LOADINFO";
    taskInfo->u.aicpuInfoLoadTask.aicpuInfo = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(aicpuInfo));
    taskInfo->u.aicpuInfoLoadTask.length = len;
    RT_LOG(RT_LOG_DEBUG, "aicpu task load info,stream_id=%d,task_id=%hu,length=%u,task_type=%d(%s)",
           taskInfo->stream->Id_(), taskInfo->id, len,
           static_cast<int32_t>(taskInfo->type), taskInfo->typeName);

    return RT_ERROR_NONE;
}

void ToCommandBodyForAicpuInfoLoadTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    command->u.aicpuInfoLoadTask.aicpuInfoPtr = taskInfo->u.aicpuInfoLoadTask.aicpuInfo;
    command->u.aicpuInfoLoadTask.length = taskInfo->u.aicpuInfoLoadTask.length;
}

void ConstructSqeForAicpuInfoLoadTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    Stream * const stm = taskInfo->stream;
    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = stm->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->task_type = 0U;

    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_AICPU_INFO_LOAD;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.ai_cpu_load_info.aicpufoPtr = taskInfo->u.aicpuInfoLoadTask.aicpuInfo;
    sqe->u.ai_cpu_load_info.length = taskInfo->u.aicpuInfoLoadTask.length;
    sqe->u.ai_cpu_load_info.stream_id = static_cast<uint16_t>(stm->Id_());
    sqe->u.ai_cpu_load_info.task_id = taskInfo->id;
    sqe->u.ai_cpu_load_info.reserved[0] = 0U;
    sqe->u.ai_cpu_load_info.reserved[1] = 0U;

    PrintSqe(command, "AicpuInfoLoadTask");
    RT_LOG(RT_LOG_INFO, "AicpuInfoLoadTask stream_id:%d task_id:%hu", stm->Id_(), taskInfo->id);
}

void DoCompleteSuccessForAicpuInfoLoadTask(TaskInfo* taskInfo, const uint32_t devId)
{
    UNUSED(devId);
    const uint32_t errorCode = taskInfo->errorCode;
    if (unlikely(errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        taskInfo->stream->SetErrCode(errorCode);
        RT_LOG(RT_LOG_ERROR, "Ai Cpu Load Info retCode=%#x, [%s].",
               errorCode, GetTsErrCodeDesc(errorCode));
    }
}

void SetStarsResultForAicpuInfoLoadTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq)
{
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) != 0U) {
        Stream *const reportStream = GetReportStream(taskInfo->stream);
        taskInfo->errorCode = logicCq.errorCode;
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_AICPU, "aicpu task happen error, retCode=%#x.",
            taskInfo->errorCode);
    }
}
#endif

#if F_DESC("GetDevMsgTask")
rtError_t GetDevMsgTaskInit(TaskInfo* taskInfo, const void * const devMemAddr,
                            const uint32_t devMemSize,
                            const rtGetDevMsgType_t messageType)
{
    GetDevMsgTaskInfo *getDevMsgTask = &(taskInfo->u.getDevMsgTask);
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_GET_DEVICE_MSG;
    taskInfo->typeName = "GET_DEVICE_MSG";
    getDevMsgTask->devMem = const_cast<void*>(devMemAddr);
    getDevMsgTask->msgBufferLen = devMemSize;
    getDevMsgTask->msgType = messageType;
    getDevMsgTask->offset = MAX_UINT64_NUM;
    Stream * const stm = taskInfo->stream;

    if (!stm->Device_()->IsDavidPlatform()) {
        const rtError_t error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
            static_cast<int32_t>(taskInfo->stream->Device_()->Id_()),
            RtPtrToValue<void *>(getDevMsgTask->devMem),
            &(getDevMsgTask->offset));
        ERROR_RETURN_MSG_INNER(error, "MemAddressTranslate address error=%#x,msg type=%d,msgBuffer length=%u",
            error, messageType, getDevMsgTask->msgBufferLen);
    }

    RT_LOG(RT_LOG_DEBUG, "Create GetDevMsgTask task,task_id=%hu,task_type=%d(%s),stream_id=%d, "
           "msgBufferLen=%u,msgType=%d,offset=%" PRIu64, taskInfo->id, taskInfo->type, taskInfo->typeName,
           taskInfo->stream->Id_(), getDevMsgTask->msgBufferLen, messageType, getDevMsgTask->offset);
    return RT_ERROR_NONE;
}

void ToCommandBodyForGetDevMsgTask(TaskInfo* taskInfo, rtCommand_t * const command)
{
    GetDevMsgTaskInfo *getDevMsgTask = &(taskInfo->u.getDevMsgTask);
    command->u.getDevMsgTask.len = getDevMsgTask->msgBufferLen;
    command->u.getDevMsgTask.devAddr =
        RtPtrToValue<void *>(getDevMsgTask->devMem);
    command->u.getDevMsgTask.offset = getDevMsgTask->offset;
    command->u.getDevMsgTask.type = static_cast<uint16_t>(getDevMsgTask->msgType);
    RT_LOG(RT_LOG_INFO, "Device message device offset=%#" PRIx64 ",msgType=%d", getDevMsgTask->offset,
        getDevMsgTask->msgType);
}

void ConstructSqeForGetDevMsgTask(TaskInfo* taskInfo, rtStarsSqe_t * const command)
{
    GetDevMsgTaskInfo *getDevMsgTask = &(taskInfo->u.getDevMsgTask);
    Stream * const stm = taskInfo->stream;
    RtStarsPhSqe * const sqe = &(command->phSqe);

    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = stm->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_GET_DEVICE_MSG;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.get_dev_msg_info.len = getDevMsgTask->msgBufferLen;
    sqe->u.get_dev_msg_info.devAddr =
        RtPtrToValue<void *>(getDevMsgTask->devMem);
    sqe->u.get_dev_msg_info.offset = getDevMsgTask->offset;
    sqe->u.get_dev_msg_info.type = static_cast<uint16_t>(getDevMsgTask->msgType);

    PrintSqe(command, "GetDevMsgTask");
    RT_LOG(RT_LOG_INFO, "stream_id:%d, task_id:%u.", stm->Id_(), static_cast<uint32_t>(taskInfo->id));
}

#endif

#if F_DESC("AddModelExitTask")
rtError_t AddModelExitTaskInit(TaskInfo* taskInfo, const uint32_t modelId)
{
    TaskCommonInfoInit(taskInfo);
    Stream *stm = taskInfo->stream;
    taskInfo->typeName = "MODEL_EXIT_GRAPH";
    taskInfo->type = TS_TASK_TYPE_MODEL_EXIT_GRAPH;
    taskInfo->u.addModelExitTask.modelId = modelId;
    taskInfo->u.addModelExitTask.streamId = static_cast<uint32_t>(stm->Id_());
    RT_LOG(RT_LOG_DEBUG, "Create model exit task,mode_id=%u,task_id=%u,task_type=%d(%s),stream_id=%d.",
        modelId, static_cast<uint32_t>(taskInfo->id), static_cast<int32_t>(taskInfo->type),
        taskInfo->typeName, static_cast<uint32_t>(taskInfo->stream->Id_()));
    return RT_ERROR_NONE;
}

void ToCmdBodyForAddModelExitTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    command->u.modelExitTask.modelId = taskInfo->u.addModelExitTask.modelId;
    command->u.modelExitTask.streamId = taskInfo->u.addModelExitTask.streamId;
    command->taskInfoFlag |= static_cast<uint8_t>(ENDGRAPH_INFO_FLAG);
}

#endif

#if F_DESC("CallbackLaunchTask")

rtError_t CallbackLaunchTaskInit(TaskInfo* taskInfo, const rtCallback_t callBackFunction, void *const functionData,
                                 const bool isBlockFlag, const int32_t evtId)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "HOSTFUNC_CALLBACK";
    taskInfo->type = TS_TASK_TYPE_HOSTFUNC_CALLBACK;
    taskInfo->u.callbackLaunchTask.callBackFunc = callBackFunction;
    taskInfo->u.callbackLaunchTask.fnData = functionData;
    taskInfo->u.callbackLaunchTask.isBlock = isBlockFlag;
    taskInfo->u.callbackLaunchTask.eventId = evtId;
    return RT_ERROR_NONE;
}

void ToCmdBodyForCallbackLaunchTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    command->u.hostFuncCBTask.hostFuncCBPtr =
        RtPtrToValue<rtCallback_t>(taskInfo->u.callbackLaunchTask.callBackFunc);
    command->u.hostFuncCBTask.fnDataPtr =
        RtPtrToValue<void *>(taskInfo->u.callbackLaunchTask.fnData);
    command->u.hostFuncCBTask.cbRptCqid = static_cast<uint32_t>(taskInfo->stream->GetCbRptCqid());
    command->u.hostFuncCBTask.isBlock = static_cast<uint8_t>(taskInfo->u.callbackLaunchTask.isBlock);
}

void ConstructSqeForCallbackLaunchTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    uint32_t pid = 0U;
    RtStarsHostfuncCallbackSqe *const sqe = &(command->callbackSqe);
    Stream *stm = taskInfo->stream;

    sqe->header.type = RT_STARS_SQE_TYPE_AICPU;
    sqe->header.l1_lock = 0U;
    sqe->header.l1_unlock = 0U;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wr_cqe = 1U;    // callback need write cqe
    sqe->header.reserved = 0U;
    sqe->header.block_dim = 1U;
    sqe->header.rt_stream_id = static_cast<uint16_t>(stm->Id_());
    sqe->header.task_id = taskInfo->id;

    sqe->kernel_type = static_cast<uint16_t>(TS_AICPU_KERNEL_NON);
    sqe->batch_mode = 0U;

    if (taskInfo->stream->Device_()->Driver_()->GetRunMode() == RT_RUN_MODE_OFFLINE) {
        sqe->topic_type = TOPIC_TYPE_DEVICE_CTRL_CPU;
        // TSCPU, Device CtrlCPU and DvppCPU must init dest_pid
        (void)taskInfo->stream->Device_()->Driver_()->DeviceGetBareTgid(&pid);
    } else {
        sqe->topic_type = TOPIC_TYPE_HOST_CTRL_CPU;
    }

    sqe->qos = 0U;
    sqe->res1 = 0U;
    sqe->sqe_index = 0U; // useless
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    sqe->cb_cq_id = static_cast<uint16_t>(stm->GetCbRptCqid());
    sqe->cb_group_id = static_cast<uint16_t>(stm->GetCbGrpId());
    sqe->dev_id = static_cast<uint16_t>(stm->Device_()->Id_());
    sqe->stream_id = static_cast<uint16_t>(stm->Id_());

    sqe->event_id = static_cast<uint16_t>(taskInfo->u.callbackLaunchTask.eventId);
    sqe->isBlock = taskInfo->u.callbackLaunchTask.isBlock;
    sqe->task_id = taskInfo->id;  //  send taskId callback cqe

    uint64_t addr = RtPtrToValue<rtCallback_t>(taskInfo->u.callbackLaunchTask.callBackFunc);
    sqe->hostfunc_addr_low = static_cast<uint32_t>(addr);
    sqe->hostfuncAddrHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    addr = RtPtrToValue<void *>(taskInfo->u.callbackLaunchTask.fnData);
    sqe->fndata_low = static_cast<uint32_t>(addr);
    sqe->fndata_high = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    sqe->subTopicId = 0U;
    sqe->topicId = 26U;     // EVENT_TS_CALLBACK_MSG
    sqe->group_id = 11U;     // 11U, drv defined
    sqe->usr_data_len = 32U; // word 4 to word 11
    sqe->dest_pid = pid;

    PrintSqe(command, "CallbackLaunch");
    RT_LOG(RT_LOG_INFO, "CallbackLaunch, topic_type=%hu, stream_id=%hu, task_id=%hu, event_id=%hu, isBlock=%hu, pid=%u",
        sqe->topic_type, sqe->stream_id, taskInfo->id, sqe->event_id, sqe->isBlock, sqe->dest_pid);
}

#endif

#if F_DESC("NpuGetFloatStatusTask")
rtError_t NpuGetFloatStaTaskInit(TaskInfo *taskInfo, void * const outputAddrPtr,
                                 const uint64_t outputSize, const uint32_t checkMode,
                                 bool debugFlag)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "NPU_GET_FLOAT_STATUS";
    taskInfo->type = TS_TASK_TYPE_NPU_GET_FLOAT_STATUS;

    NpuGetFloatStatusTaskInfo *npuGetFloatSta = &taskInfo->u.npuGetFloatStatusTask;

    npuGetFloatSta->outputAddrPtr = outputAddrPtr;
    npuGetFloatSta->outputSize = outputSize;
    npuGetFloatSta->checkMode = checkMode;
    npuGetFloatSta->debugFlag = debugFlag;
    return RT_ERROR_NONE;
}

void ConstructSqeForNpuGetFloatStaTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    RtStarsGetFloatStatusSqe &sqe = command->getFloatStatusSqe;
    NpuGetFloatStatusTaskInfo *npuGetFltSta = &taskInfo->u.npuGetFloatStatusTask;
    Stream *const stm = taskInfo->stream;
    (void)memset_s(&sqe, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    sqe.debugFlag = npuGetFltSta->debugFlag ? 1U : 0U;
    ConstructGetFloatStatusInstr(
        RtPtrToValue<void *>(npuGetFltSta->outputAddrPtr),
        npuGetFltSta->outputSize, sqe);

    sqe.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe.sqeHeader.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe.sqeHeader.pre_p = 1U;
    sqe.sqeHeader.post_p = RT_STARS_SQE_INT_DIR_NO;
    sqe.sqeHeader.wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();
    sqe.sqeHeader.reserved = 0U;
    sqe.sqeHeader.block_dim = 0U;
    sqe.sqeHeader.rt_stream_id = static_cast<uint16_t>(taskInfo->stream->Id_());
    sqe.sqeHeader.task_id = taskInfo->id;
    sqe.conds_sub_type = CONDS_SUB_TYPE_GET_FLOAT_STATUS;
    sqe.kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe.csc = 1U;

    PrintSqe(command, "NpuGetFloatStatusTask");
    RT_LOG(RT_LOG_INFO, "ConstructModelSqe finish, stream_id=%d, task_id=%u, debugFlag=%hhu",
           stm->Id_(), static_cast<uint32_t>(taskInfo->id), sqe.debugFlag);
}
#endif

#if F_DESC("NpuClearFloatStatusTask")

rtError_t NpuClrFloatStaTaskInit(TaskInfo *taskInfo, const uint32_t checkMode, bool debugFlag)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "NPU_CLEAR_FLOAT_STATUS";
    taskInfo->type = TS_TASK_TYPE_NPU_CLEAR_FLOAT_STATUS;
    taskInfo->u.npuClrFloatStatusTask.checkMode = checkMode;
    taskInfo->u.npuClrFloatStatusTask.debugFlag = debugFlag;
    return RT_ERROR_NONE;
}

void ConstructSqeForNpuClrFloatStaTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    RtStarsPhSqe *const sqe = &(command->phSqe);
    NpuClearFloatStatusTaskInfo *npuClrFltSta = &taskInfo->u.npuClrFloatStatusTask;
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->post_p = 0U;
    sqe->pre_p = 1U;
    sqe->wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->task_type = TS_TASK_TYPE_NPU_CLEAR_FLOAT_STATUS;

    sqe->rt_streamID = static_cast<uint16_t>(taskInfo->stream->Id_());
    sqe->task_id = taskInfo->id;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.debugStatusInfo.debugFlag = npuClrFltSta->debugFlag ? 1U : 0U;

    PrintSqe(command, "NpuClearFloatStatusTask");
    RT_LOG(RT_LOG_INFO, "stream_id=%d, task_id=%u, debug_flag=%d",
        taskInfo->stream->Id_(), static_cast<uint32_t>(taskInfo->id), npuClrFltSta->debugFlag);
}

#endif

#if F_DESC("WriteValueTask")

rtError_t WriteValueTaskInit(TaskInfo *taskInfo, uint64_t addr, WriteValueSize size,
                             uint8_t *value, TaskWrCqeFlag cqeFlag)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "WriteValueTask";
    taskInfo->type = TS_TASK_TYPE_WRITE_VALUE;

    WriteValueTaskInfo *writeValTsk = &taskInfo->u.writeValTask;
    writeValTsk->addr = addr;
    writeValTsk->awSize = size;
    writeValTsk->cqeFlag = cqeFlag;
    const uint32_t writeLen = (1U << static_cast<uint32_t>(size));

    for (uint32_t i = 0U; i < writeLen; i++) {
        writeValTsk->value[i] = value[i];
    }

    return RT_ERROR_NONE;
}

rtError_t WriteValuePtrTaskInit(TaskInfo *taskInfo, const void * const pointedAddr,
    TaskWrCqeFlag cqeFlag)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = const_cast<char_t*>("WriteValuePtrTask");
    taskInfo->type = TS_TASK_TYPE_WRITE_VALUE;

    WriteValueTaskInfo *writeValTsk = &taskInfo->u.writeValTask;
    writeValTsk->sqeAddr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(pointedAddr));
    writeValTsk->cqeFlag = cqeFlag;
    writeValTsk->ptrFlag = 1U;

    return RT_ERROR_NONE;
}

void ConstructSqeForWriteValueTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    WriteValueTaskInfo *writeValTsk = &taskInfo->u.writeValTask;
    RtStarsWriteValueSqe *evSqe = &(command->writeValueSqe);

    evSqe->header.type = RT_STARS_SQE_TYPE_WRITE_VALUE;
    evSqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    evSqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    evSqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;

    switch (writeValTsk->cqeFlag) {
        case TASK_WR_CQE_DEFAULT:
            evSqe->header.wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();
            break;
        case TASK_WR_CQE_NEVER:
            evSqe->header.wr_cqe = 0U;
            break;
        default:
            evSqe->header.wr_cqe = 1U;
            break;
    }

    evSqe->header.rt_stream_id = static_cast<uint16_t>(taskInfo->stream->Id_());
    evSqe->header.task_id = taskInfo->id;
    evSqe->va = 1U;  // va only

    evSqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    evSqe->awsize = writeValTsk->awSize;
    evSqe->snoop = 0U;
    evSqe->awcache = 2U;  // 2U: 0010 Normal Non-cacheable Non-bufferable
    evSqe->awprot = 0U;

    evSqe->write_addr_low = static_cast<uint32_t>(writeValTsk->addr & MASK_32_BIT);
    evSqe->write_addr_high = static_cast<uint32_t>((writeValTsk->addr >> UINT32_BIT_NUM) & MASK_17_BIT);

    evSqe->res3 = 0U;
    evSqe->res4 = 0U;
    evSqe->res5 = 0U;
    evSqe->res6 = 0U;
    evSqe->res7 = 0U;

    uint32_t *temp = RtPtrToPtr<uint32_t *, uint8_t*>(writeValTsk->value);
    evSqe->write_value_part0 = temp[0U];    // 0: part0
    evSqe->write_value_part1 = temp[1U];    // 1: part1
    evSqe->write_value_part2 = temp[2U];    // 2: part2
    evSqe->write_value_part3 = temp[3U];    // 3: part3
    evSqe->write_value_part4 = temp[4U];    // 4: part4
    evSqe->write_value_part5 = temp[5U];    // 5: part5
    evSqe->write_value_part6 = temp[6U];    // 6: part6
    evSqe->write_value_part7 = temp[7U];    // 7: part7

    PrintSqe(command, "WriteValueTask");
    RT_LOG(RT_LOG_DEBUG, "WriteValueTask streamId=%d, taskId=%hu, addr=%#." PRIx64, taskInfo->stream->Id_(),
        taskInfo->id, writeValTsk->addr);
}
#endif

#if F_DESC("GetStarsVersionTask")
rtError_t StarsVersionTaskInit(TaskInfo * const taskInfo)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_GET_STARS_VERSION;
    taskInfo->typeName = "STARS_VERSION";

    if (taskInfo->stream->Device_()->IsStarsPlatform()) {
        taskInfo->isNeedStreamSync = true;
    }

    return RT_ERROR_NONE;
}

void ConstructSqeForStarsVersionTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    Stream *const stm = taskInfo->stream;
    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = 1U;
    sqe->res0 = 0U;
    sqe->res1 = stm->Device_()->GetTsLogToHostFlag(); // runtime version
    uint16_t stream_id = static_cast<uint16_t>(stm->Id_());
    if (!stm->IsSeparateSendAndRecycle()) {
        stream_id |= RT_SYNC_TASK_FLAG;
    }
    sqe->rt_streamID = stream_id;
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_GET_STARS_VERSION;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.starsVersionInfo.buildVersion = RUNTIME_BUILD_VERSION;
    PrintSqe(command, "GetStarsVersionTask");
    RT_LOG(RT_LOG_INFO, "Send GetStarsVersionTask success, sqe_type=%u,pre_p=%u,sqe->rt_streamID=%u, stream_id=%d,"
        "task_id=%u,task_type=%u.", sqe->type, sqe->pre_p, sqe->rt_streamID, stm->Id_(), sqe->task_id, sqe->task_type);
}

void SetStarsResultForStarsVersionTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq)
{
    taskInfo->errorCode = logicCq.errorCode;
    RT_LOG(RT_LOG_DEBUG, "StarsVersionTask errorCode=%u,logicCq:err=%u,errCode=%u, stream_id=%hu, task_id=%hu",
           taskInfo->errorCode, logicCq.errorType, logicCq.errorCode, logicCq.streamId, logicCq.taskId);
}

void DoCompleteSuccessForStarsVersionTask(TaskInfo* taskInfo, const uint32_t devId)
{
    UNUSED(devId);
    Device *const dev = taskInfo->stream->Device_();
    COND_RETURN_VOID(dev == nullptr, "dev is NULL.");
    uint32_t tschVersion = taskInfo->errorCode == 0 ? (uint32_t)TS_VERSION_STARS_COMPATIBILITY : taskInfo->errorCode;
    RT_LOG(RT_LOG_INFO, "Complete StarsVersionTask success, retCode=%u, tschVersion=%u.",
           taskInfo->errorCode, tschVersion);
    dev->SetTschVersion(tschVersion);
}

#endif

#if F_DESC("FlipTask")
void FlipTaskInit(TaskInfo* taskInfo, const uint16_t flipNum)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_FLIP;
    taskInfo->typeName = "FLIP_TASK";
    taskInfo->u.flipTask.flipNumReport = flipNum;
    return;
}

void ToCmdBodyForFlipTask(TaskInfo *const taskInfo, rtCommand_t *const command)
{
    command->u.flipTask.flipNumReport = taskInfo->u.flipTask.flipNumReport;
}

void ToCommandForNopTask(TaskInfo *const taskInfo, rtCommand_t *const command)
{
    UNUSED(taskInfo);
    UNUSED(command);

    return;
}

void ToCommandBodyForModelUpdateTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    MdlUpdateTaskInfo *mdlUpdateTaskInfo = &(taskInfo->u.mdlUpdateTask);
    command->u.modelUpdateTask.destaskId = static_cast<uint16_t>(mdlUpdateTaskInfo->destaskId);
    command->u.modelUpdateTask.desStreamId = mdlUpdateTaskInfo->desStreamId;
    command->u.modelUpdateTask.tilingKeyOffset = mdlUpdateTaskInfo->tilingKeyOffset;
    command->u.modelUpdateTask.tilingTabOffset = mdlUpdateTaskInfo->tilingTabOffset;
    command->u.modelUpdateTask.blockDimOffset = mdlUpdateTaskInfo->blockDimOffset;
    command->u.modelUpdateTask.tilingTabLen = mdlUpdateTaskInfo->tilingTabLen;

    Stream *const stm = taskInfo->stream;
    RT_LOG(RT_LOG_DEBUG,
        "task_id=%u, stream_id=%u, taskId=%u, streamId=%u, [offset]tilingKey=%llu, blockDim=%llu, tilingTab=%llu.",
        taskInfo->id, static_cast<uint16_t>(stm->Id_()), mdlUpdateTaskInfo->destaskId, mdlUpdateTaskInfo->desStreamId,
        mdlUpdateTaskInfo->tilingKeyOffset, mdlUpdateTaskInfo->blockDimOffset, mdlUpdateTaskInfo->tilingTabOffset);

    return;
}

void ConstructSqeForFlipTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    FlipTaskInfo *flipTaskInfo = &(taskInfo->u.flipTask);
    Stream *const stm = taskInfo->stream;
    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = 0U;
    sqe->res0 = 0U;
    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_FLIP;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.flip_task_info.flipNumReport = flipTaskInfo->flipNumReport;
    PrintSqe(command, "FlipTask");
    RT_LOG(RT_LOG_INFO, "launch FlipTask succ, sqe_type=%u, pre_p=%u, stream_id=%u, task_id=%u, flip_num=%u.",
           sqe->type, sqe->pre_p, sqe->rt_streamID, sqe->task_id, flipTaskInfo->flipNumReport);
}
#endif

void ConstructSqeForNopTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    Stream *const stm = taskInfo->stream;
    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 0U;
    sqe->post_p = 0U;
    sqe->wr_cqe = 0U;
    sqe->res0 = 0U;
    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_NOP;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    PrintSqe(command, "NoOperationTask");
}

#if F_DESC("UpdateAddressTaskInit")
// Construct the update address sqe.
void ConstructSqeForUpdateAddressTask(TaskInfo * const taskInfo, rtStarsSqe_t * const command)
{
    UpdateAddressTaskInfo *updateAddrTask = &(taskInfo->u.updateAddrTask);
    Stream *const stream = taskInfo->stream;

    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->wr_cqe = stream->GetStarsWrCqeFlag();
    sqe->rt_streamID = static_cast<uint16_t>(stream->Id_());
    sqe->task_id = taskInfo->id;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->task_type = TS_TASK_TYPE_UPDATE_ADDRESS;
    sqe->pre_p = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    sqe->post_p = RT_STARS_SQE_INT_DIR_NO;

    sqe->u.updateAddrInfo.dev_addr = updateAddrTask->devAddr;
    sqe->u.updateAddrInfo.len = updateAddrTask->len;
    PrintSqe(command, "UpdateAddressByPlaceHolder");
    RT_LOG(RT_LOG_INFO, "ConstructSqe, len=%" PRIu64 ", stream_id=%d.", updateAddrTask->len, stream->Id_());
}

rtError_t UpdateAddressTaskInit(TaskInfo* taskInfo, uint64_t devAddr, uint64_t len)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "Update_Address";
    taskInfo->type = TS_TASK_TYPE_UPDATE_ADDRESS;
    taskInfo->u.updateAddrTask.devAddr = devAddr;
    taskInfo->u.updateAddrTask.len = len;
    return RT_ERROR_NONE;
}
#endif

#if F_DESC("CommonCmdTask")
void CommonCmdTaskInit(TaskInfo * const taskInfo, const PhCmdType cmdType, const CommonCmdTaskInfo * cmdInfo)
{
    CommonCmdTaskInfo *commonCmdTaskInfo = &(taskInfo->u.commonCmdTask);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_COMMON_CMD;
    commonCmdTaskInfo->cmdType = cmdType;
    if (cmdType == CMD_STREAM_CLEAR) {
        taskInfo->typeName = "STREAM_CLEAR_TASK";
        commonCmdTaskInfo->streamId = static_cast<uint16_t>(cmdInfo->streamId);
        commonCmdTaskInfo->step = static_cast<uint16_t>(cmdInfo->step);
    } else if (cmdType == CMD_NOTIFY_RESET) {
        taskInfo->typeName = "NOTIFY_RESET_TASK";
        commonCmdTaskInfo->notifyId = cmdInfo->notifyId;
    } else {
        // no operation
    }
    return;
}

void ConstructSqeForStreamClearTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    CommonCmdTaskInfo *commonCmdTaskInfo = &(taskInfo->u.commonCmdTask);
    Stream *const stm = taskInfo->stream;

    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = 0U;
    sqe->res0 = 0U;
    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_COMMON_CMD;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.commonCmdInfo.cmdType = commonCmdTaskInfo->cmdType;
    sqe->u.commonCmdInfo.streamId = commonCmdTaskInfo->streamId;
    sqe->u.commonCmdInfo.step = commonCmdTaskInfo->step;
    PrintSqe(command, "StreamClearTask");
    RT_LOG(RT_LOG_INFO, "Send stream clear task succ,"
        "sqe_type=%u, pre_p=%u, stream_id=%u, task_id=%u, task_type=%u, clear target stream_id=%u.",
        sqe->type, sqe->pre_p, sqe->rt_streamID, sqe->task_id, sqe->task_type, commonCmdTaskInfo->streamId);
}

void ConstructSqeForNotifyResetTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    CommonCmdTaskInfo *commonCmdTaskInfo = &(taskInfo->u.commonCmdTask);
    Stream *const stm = taskInfo->stream;

    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = 0U;
    sqe->res0 = 0U;
    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_COMMON_CMD;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.commonCmdInfo.cmdType = commonCmdTaskInfo->cmdType;
    sqe->u.commonCmdInfo.notifyId = commonCmdTaskInfo->notifyId;
    PrintSqe(command, "NotifyResetTask");
    RT_LOG(RT_LOG_INFO, "Send NotifyReset task succ,"
        "sqe_type=%u, pre_p=%u, stream_id=%u, task_id=%u, task_type=%u, reset target notify_id=%u.",
        sqe->type, sqe->pre_p, sqe->rt_streamID, sqe->task_id, sqe->task_type, commonCmdTaskInfo->notifyId);
}

void ConstructSqeForCommonCmdTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    CommonCmdTaskInfo *commonCmdTaskInfo = &(taskInfo->u.commonCmdTask);
    if (commonCmdTaskInfo->cmdType == CMD_STREAM_CLEAR) {
        ConstructSqeForStreamClearTask(taskInfo, command);
    } else if (commonCmdTaskInfo->cmdType == CMD_NOTIFY_RESET) {
        ConstructSqeForNotifyResetTask(taskInfo, command);
    } else {
        // no operation
    }
}
#endif

}  // namespace runtime
}  // namespace cce
