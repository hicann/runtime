/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "device_error_proc.hpp"
#include "device_error_proc_c.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "task_recycle.hpp"

 
namespace cce {
namespace runtime {
constexpr uint32_t FAST_RING_BUFFER_DEPTH = 2U;

void UpdateDeviceErrorProcFunc(std::map<uint64_t, DeviceErrorProc::StarsErrorInfoProc> &funcMap)
{
    static const std::map<uint64_t, DeviceErrorProc::StarsErrorInfoProc> davidFuncMap = {
        {AICORE_ERROR, &ProcessDavidStarsCoreErrorInfo},
        {AIVECTOR_ERROR, &ProcessDavidStarsCoreErrorInfo},
        {WAIT_TIMEOUT_ERROR, &ProcessDavidStarsWaitTimeoutErrorInfo},
        {SDMA_ERROR, &ProcessStarsSdmaErrorInfo},
        {AICPU_ERROR, &ProcessStarsAicpuErrorInfo},
        {DVPP_ERROR, &DeviceErrorProc::ProcessStarsDvppErrorInfo},
        {SQE_ERROR, &DeviceErrorProc::ProcessStarsSqeErrorInfo},
        {FUSION_KERNEL_ERROR, &ProcessDavidStarsFusionKernelErrorInfo},
        {CCU_ERROR, &ProcessDavidStarsCcuErrorInfo},
        {AICORE_TIMEOUT_DFX, &ProcessStarsV2CoreTimeoutDfxInfo}
    };
    funcMap = davidFuncMap;
    return;
}

uint16_t GetMteErrWaitCount()
{
    return static_cast<uint16_t>(RAS_QUERY_MAX_COUNT);
}

void DeviceErrorProc::MapFusionTaskErrorCode(const TaskInfo* tsk, StarsOpExceptionInfo* report) const
{
    if ((tsk->type != TS_TASK_TYPE_FUSION_KERNEL) || (report->sqeType != RT_DAVID_SQE_TYPE_FUSION)) {
        return;
    }
    constexpr uint8_t SQE_SUB_TYPE_AICORE_BIT = 2U;
    const uint8_t sqeSubType = tsk->u.fusionKernelTask.sqeSubType;
    const bool isTimeout = (report->errorCode == TS_ERROR_TASK_TIMEOUT);
    if ((sqeSubType & (1U << SQE_SUB_TYPE_AICORE_BIT)) != 0U) { // has AICORE sub task
        report->errorCode = isTimeout ? TS_ERROR_AICORE_TIMEOUT : TS_ERROR_AICORE_EXCEPTION;
    } else if (sqeSubType == 0x18U) { // only CCU sub task
        report->errorCode = isTimeout ? TS_ERROR_CCU_TIMEOUT : TS_ERROR_CCU_EXCEPTION;
    } else if (sqeSubType == 0x01U) { // only AICPU sub task
        report->errorCode = isTimeout ? TS_ERROR_AICPU_TIMEOUT : TS_ERROR_AICPU_EXCEPTION;
    } else {
        /* unknown sqe sub type, no-op */
    }
}

// fast ringbuffer(4k): DevRingBufferCtlInfo + RingBufferElementInfo + StarsOpExceptionInfo
void DeviceErrorProc::ProcessReportFastRingBuffer()
{
    COND_RETURN_VOID(device_ == nullptr, "device_ can not be nullptr.");
    if (fastRingBufferAddr_ == nullptr) {
        return; // not support fast ringbuffer
    }

    const std::lock_guard<std::mutex> lk(fastRingbufferMutex_);
    DevRingBufferCtlInfo* ctrlInfo = RtPtrToPtr<DevRingBufferCtlInfo*>(fastRingBufferAddr_);
    COND_PROC((ctrlInfo->magic != RINGBUFFER_MAGIC), return ); // no error return
    COND_PROC((ctrlInfo->head == ctrlInfo->tail), return );    // Empty Fast RingBuffer.no error return
    uint32_t head = ctrlInfo->head;
    const uint32_t tail = ctrlInfo->tail;
    const uint32_t depth = ctrlInfo->ringBufferLen;
    if (depth != FAST_RING_BUFFER_DEPTH) {
        RT_LOG(RT_LOG_ERROR, "fast ring buffer error: depth is not set properly.");
        return;
    }
    if (head >= depth || tail >= depth) {
        RT_LOG(
            RT_LOG_ERROR, "fast ring buffer error: head or tail is bigger than depth. depth=[%u], head=[%u], tail=[%u]",
            depth, head, tail);
        return;
    }
    while (head != tail) {
        RT_LOG(RT_LOG_DEBUG, "fast ring buffer depth=[%u], head=[%u], tail=[%u].", depth, head, tail);
        StarsOpExceptionInfo* report = RtValueToPtr<StarsOpExceptionInfo*>(
            RtPtrToValue(fastRingBufferAddr_) + sizeof(DevRingBufferCtlInfo) + sizeof(RingBufferElementInfo) +
            head * sizeof(StarsOpExceptionInfo));
        ConvertErrorCodeForFastReport(report);
        TaskInfo* tsk =
            GetTaskInfo(device_, static_cast<uint32_t>(report->streamId), static_cast<uint32_t>(report->sqHead), true);
        if (tsk == nullptr) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "The fast ring buffer reports an error,"
                " device_id=%u, stream_id=%u, task_id=%u, sq_head=%u, sqe_type=%u, error_code=%#x, kernel_name=none.",
                device_->Id_(), report->streamId, report->taskId, report->sqHead, report->sqeType, report->errorCode);
            RT_LOG(RT_LOG_ERROR, "The task has been recycled, stream_id=%u, task_id=%u.", report->streamId, report->taskId);
            head = (head + 1U) % depth;
            ctrlInfo->head = head;
            continue;
        }
        MapFusionTaskErrorCode(tsk, report);
        const char *errMsg = "a kernel task";
        uint8_t errModule = ERR_MODULE_TBE;
        if (tsk->type == TS_TASK_TYPE_KERNEL_AIVEC) {
            errMsg = "a Vector Core task";
        } else if (tsk->type == TS_TASK_TYPE_KERNEL_AICORE) {
            errMsg = "an AI Core task";
        } else if (tsk->type == TS_TASK_TYPE_KERNEL_AICPU) {
            errMsg = "an AI CPU task";
            errModule = ERR_MODULE_AICPU;
        } else {
            errModule = ERR_MODULE_RTS;
        }
        RT_LOG_CALL_MSG(errModule, "The fast ring buffer reports %s error,"
            " device_id=%u, stream_id=%u, task_id=%u, sq_head=%u, sqe_type=%u, error_code=%#x, kernel_name=%s.",
            errMsg, device_->Id_(), report->streamId, report->taskId, report->sqHead, report->sqeType, report->errorCode,
            GetTaskKernelName(tsk).c_str());
        tsk->stream->SetErrCode(report->errorCode);
        tsk->stream->EnterFailureAbort();
        TaskFailCallBack(report->streamId, report->taskId, tsk->tid, report->errorCode, device_);
        head = (head + 1U) % depth;
        ctrlInfo->head = head;
    }
    return;
}

void GetFastRingBufferErrorMap(std::unordered_map<uint32_t, std::unordered_map<uint32_t, uint32_t>>& errorMap)
{
    // 定义映射表 [任务类型][原错误码] -> 新错误码
    errorMap = {
        {RT_DAVID_SQE_TYPE_AIC,
         {{TS_ERROR_TASK_EXCEPTION, TS_ERROR_AICORE_EXCEPTION}, {TS_ERROR_TASK_TIMEOUT, TS_ERROR_AICORE_TIMEOUT}}},
        {RT_DAVID_SQE_TYPE_AIV,
         {{TS_ERROR_TASK_EXCEPTION, TS_ERROR_AICORE_EXCEPTION}, {TS_ERROR_TASK_TIMEOUT, TS_ERROR_AICORE_TIMEOUT}}},
        {RT_DAVID_SQE_TYPE_AICPU_H,
         {{TS_ERROR_TASK_EXCEPTION, TS_ERROR_AICPU_EXCEPTION}, {TS_ERROR_TASK_TIMEOUT, TS_ERROR_AICPU_TIMEOUT}}},
        {RT_DAVID_SQE_TYPE_AICPU_D,
         {{TS_ERROR_TASK_EXCEPTION, TS_ERROR_AICPU_EXCEPTION}, {TS_ERROR_TASK_TIMEOUT, TS_ERROR_AICPU_TIMEOUT}}},
        {RT_DAVID_SQE_TYPE_SDMA,
         {{TS_ERROR_TASK_EXCEPTION, TS_ERROR_SDMA_ERROR}, {TS_ERROR_TASK_TIMEOUT, TS_ERROR_SDMA_TIMEOUT}}},
        {RT_DAVID_SQE_TYPE_FUSION,
         {{TS_ERROR_TASK_EXCEPTION, TS_ERROR_TASK_EXCEPTION}, {TS_ERROR_TASK_TIMEOUT, TS_ERROR_TASK_TIMEOUT}}}};
}

void DeviceErrorProc::ProcClearFastRingBuffer() const
{
    if (fastRingBufferAddr_ == nullptr) {
        return;
    }
    DevRingBufferCtlInfo *ctrlInfo = RtPtrToPtr<DevRingBufferCtlInfo *>(fastRingBufferAddr_);
    ctrlInfo->head = ctrlInfo->tail;
}

void InitFastRingBuffer(void* fastRingBufferAddr)
{
    if (fastRingBufferAddr == nullptr) {
        RT_LOG(RT_LOG_ERROR, "fast ring buffer error: FastRingBufferAddr is nullptr.");
        return;
    }
    DevRingBufferCtlInfo* ctrlInfo = RtPtrToPtr<DevRingBufferCtlInfo*>(fastRingBufferAddr);
    ctrlInfo->magic = 0U;
    ctrlInfo->head = 0U;
    ctrlInfo->tail = 0U;
    ctrlInfo->ringBufferLen = FAST_RING_BUFFER_DEPTH; // fast ring buffer circular queue: only one element can be used
}

}  // namespace runtime
}  // namespace cce
