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
        {CCU_ERROR, &ProcessDavidStarsCcuErrorInfo}
    };
    funcMap = davidFuncMap;
    return;
}

uint16_t GetMteErrWaitCount()
{
    return 20U;
}

void MteErrorProc(const TaskInfo * const errTaskPtr, const Device * const dev, const int32_t errorCode, bool &hasSpecialErrorCode)
{
    UNUSED(errTaskPtr);
    UNUSED(errorCode);
    SetDeviceFaultTypeByErrorType(dev, AICORE_ERROR, hasSpecialErrorCode);
}

void SetDeviceFaultTypeByErrorType(const Device * const dev, const rtErrorType errorType, bool &hasSpecialErrorCode)
{
    constexpr uint32_t maxFaultNum = 128U;
    rtDmsFaultEvent *faultEventInfo = new (std::nothrow)rtDmsFaultEvent[maxFaultNum];
    COND_RETURN_VOID((faultEventInfo == nullptr), "new rtDmsFaultEvent failed.");
    const size_t totalSize = maxFaultNum * sizeof(rtDmsFaultEvent);
    (void)memset_s(faultEventInfo, totalSize, 0, totalSize);

    const std::function<void()> releaseFunc = [&faultEventInfo]() { DELETE_A(faultEventInfo); };
    ScopeGuard faultEventInfoRelease(releaseFunc);
    uint32_t eventCount = 0U;
    rtError_t error = GetDeviceFaultEvents(dev->Id_(), faultEventInfo, eventCount, maxFaultNum);
    if (error != RT_ERROR_NONE) {
        return;
    }

    if (errorType == AICORE_ERROR) {  // if hit the blacklist, aicore set aicore unknow error and sdma do nothing.
        (RtPtrToUnConstPtr<Device *>(dev))->SetDeviceFaultType(DeviceFaultType::AICORE_UNKNOWN_ERROR);
    }
    if (IsFaultEventOccur(L2_BUFFER_ECC_EVENT_ID, faultEventInfo, eventCount) &&
        (!IsHitBlacklist(faultEventInfo, eventCount, g_l2MulBitEccEventIdBlkList))) {
        hasSpecialErrorCode = true;
        (RtPtrToUnConstPtr<Device *>(dev))->SetDeviceFaultType(DeviceFaultType::L2_BUFFER_ERROR);
    } else if (IsFaultEventOccur(HBM_ECC_EVENT_ID, faultEventInfo, eventCount) &&
        (!IsHitBlacklist(faultEventInfo, eventCount, g_mulBitEccEventIdBlkList))) {
        hasSpecialErrorCode = true;
        (RtPtrToUnConstPtr<Device *>(dev))->SetDeviceFaultType(DeviceFaultType::HBM_UCE_ERROR);
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
        RT_LOG(
            RT_LOG_ERROR,
            "fast ring buffer report error, "
            "device_id=%u, stream_id=%u, task_id=%u, sq_head=%u, sqe_type=%u, error_code=%#x, kernel_name=%s.",
            device_->Id_(), report->streamId, report->taskId, report->sqHead, report->sqeType, report->errorCode,
            GetTaskKernelName(tsk).c_str());
        if (tsk == nullptr) {
            RT_LOG(RT_LOG_ERROR, "stream_id=%u, task_id=%u, task has been recycled.", report->streamId, report->taskId);
            head = (head + 1U) % depth;
            ctrlInfo->head = head;
            continue;
        }
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
         {{TS_ERROR_TASK_EXCEPTION, TS_ERROR_SDMA_ERROR}, {TS_ERROR_TASK_TIMEOUT, TS_ERROR_SDMA_TIMEOUT}}}};
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