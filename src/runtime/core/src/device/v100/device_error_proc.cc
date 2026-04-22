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
#include "stream.hpp"
#include "context.hpp"
 
namespace cce {
namespace runtime {
 
void UpdateDeviceErrorProcFunc(std::map<uint64_t, DeviceErrorProc::StarsErrorInfoProc> &funcMap)
{
    static const std::map<uint64_t, DeviceErrorProc::StarsErrorInfoProc> starsFuncMap = {
        {AICORE_ERROR, &DeviceErrorProc::ProcessStarsCoreErrorInfo},
        {AIVECTOR_ERROR, &DeviceErrorProc::ProcessStarsCoreErrorInfo},
        {FFTS_PLUS_AICORE_ERROR, &DeviceErrorProc::ProcessStarsCoreErrorInfo},
        {FFTS_PLUS_AIVECTOR_ERROR, &DeviceErrorProc::ProcessStarsCoreErrorInfo},
        {WAIT_TIMEOUT_ERROR, &DeviceErrorProc::ProcessStarsWaitTimeoutErrorInfo},
        {SDMA_ERROR, &DeviceErrorProc::ProcessStarsSdmaErrorInfo},
        {AICPU_ERROR, &ProcessStarsAicpuErrorInfo},
        {FFTS_PLUS_SDMA_ERROR, &DeviceErrorProc::ProcessStarsSdmaErrorInfo},
        {FFTS_PLUS_AICPU_ERROR, &ProcessStarsAicpuErrorInfo},
        {DVPP_ERROR, &DeviceErrorProc::ProcessStarsDvppErrorInfo},
        {DSA_ERROR, &DeviceErrorProc::ProcessStarsDsaErrorInfo},
        {FFTS_PLUS_DSA_ERROR, &DeviceErrorProc::ProcessStarsDsaErrorInfo},
        {SQE_ERROR, &DeviceErrorProc::ProcessStarsSqeErrorInfo},
        {HCCL_FFTSPLUS_TIMEOUT_ERROR, &DeviceErrorProc::ProcessStarsHcclFftsPlusTimeoutErrorInfo},
        {AICORE_TIMEOUT_DFX, &DeviceErrorProc::ProcessStarsCoreTimeoutDfxInfo}
    };
    funcMap = starsFuncMap;
    return;
}

uint16_t GetMteErrWaitCount()
{
    return 120U;
}

void MteErrorProc(const TaskInfo * const errTaskPtr, const Device * const dev, const int32_t errorCode, bool &hasSpecialErrorCode)
{
    UNUSED(dev);
    UNUSED(errorCode);
    UNUSED(hasSpecialErrorCode);
    if ((errTaskPtr->stream != nullptr) && (errTaskPtr->stream->Context_() != nullptr) &&
        (errTaskPtr->stream->Device_() != nullptr)) {
        (RtPtrToUnConstPtr<TaskInfo *>(errTaskPtr))->stream->SetAbortStatus(errorCode);
        (RtPtrToUnConstPtr<TaskInfo *>(errTaskPtr))->stream->Context_()->SetFailureError(errorCode);
        (RtPtrToUnConstPtr<TaskInfo *>(errTaskPtr))->stream->Device_()->SetDeviceStatus(errorCode);
    }
}

void SetDeviceFaultTypeByErrorType(const Device * const dev, const rtErrorType errorType, bool &hasSpecialErrorCode)
{
    UNUSED(dev);
    UNUSED(errorType);
    hasSpecialErrorCode = true;
}
 
uint32_t GetRingbufferElementNum()
{
    return RINGBUFFER_LEN;
}

// fast ringbuffer(4k): DevRingBufferCtlInfo + RingBufferElementInfo + StarsOpExceptionInfo
void DeviceErrorProc::ProcessReportFastRingBuffer()
{
    COND_RETURN_VOID(device_ == nullptr, "device_ can not be nullptr.");
    if (fastRingBufferAddr_ == nullptr) {
        return; // not support fast ringbuffer
    }

    DevRingBufferCtlInfo *ctrlInfo = RtPtrToPtr<DevRingBufferCtlInfo *>(fastRingBufferAddr_);
    COND_PROC((ctrlInfo->magic != RINGBUFFER_MAGIC), return); // no error return
    StarsOpExceptionInfo report;
    {
        const std::lock_guard<std::mutex> lk(fastRingbufferMutex_);
        StarsOpExceptionInfo *starsReport = RtValueToPtr<StarsOpExceptionInfo *>(RtPtrToValue(fastRingBufferAddr_) +
        sizeof(DevRingBufferCtlInfo) + sizeof(RingBufferElementInfo));
        report = *starsReport;
        __sync_synchronize(); // 最后置标记位, 防止指令重排
        ctrlInfo->magic = 0U; // 释放fast ring buffer, 以下不要使用
    }
    ConvertErrorCodeForFastReport(&report);
    TaskInfo *tsk = device_->GetTaskFactory()->GetTask(static_cast<int32_t>(report.streamId), report.taskId);
    RT_LOG(RT_LOG_ERROR, "fast ring buffer report error, "
        "device_id=%u, stream_id=%u, task_id=%u, sqe_type=%u, error_code=%#x, kernel_name=%s.",
        device_->Id_(), report.streamId, report.taskId, report.sqeType, report.errorCode,
        GetTaskKernelName(tsk).c_str());
    COND_RETURN_VOID(tsk == nullptr, "stream_id=%u, task_id=%u, task has been recycled.",
        report.streamId, report.taskId);
    tsk->stream->SetErrCode(report.errorCode);
    tsk->stream->EnterFailureAbort();
    TaskFailCallBack(report.streamId, report.taskId, tsk->tid, report.errorCode, device_);
    return;
}

void GetFastRingBufferErrorMap(std::unordered_map<uint32_t, std::unordered_map<uint32_t, uint32_t>>& errorMap)
{
    // 定义映射表 [任务类型][原错误码] -> 新错误码
    errorMap = {
        {RT_STARS_SQE_TYPE_FFTS,
         {{TS_ERROR_TASK_EXCEPTION, TS_ERROR_AICORE_EXCEPTION},
          {TS_ERROR_TASK_TIMEOUT, TS_ERROR_AICORE_TIMEOUT},
          {TS_ERROR_TASK_TRAP, TS_ERROR_AICORE_TRAP_EXCEPTION}}},
        {RT_STARS_SQE_TYPE_AICPU,
         {{TS_ERROR_TASK_EXCEPTION, TS_ERROR_AICPU_EXCEPTION}, {TS_ERROR_TASK_TIMEOUT, TS_ERROR_AICPU_TIMEOUT}}},
        {RT_STARS_SQE_TYPE_SDMA,
         {{TS_ERROR_TASK_EXCEPTION, TS_ERROR_SDMA_ERROR}, {TS_ERROR_TASK_TIMEOUT, TS_ERROR_SDMA_TIMEOUT}}}};
}

void DeviceErrorProc::ProcClearFastRingBuffer() const
{
    if (fastRingBufferAddr_ == nullptr) {
        return;
    }
    DevRingBufferCtlInfo *ctrlInfo = RtPtrToPtr<DevRingBufferCtlInfo *>(fastRingBufferAddr_);
    ctrlInfo->magic = 0U;
}

void InitFastRingBuffer(void* fastRingBufferAddr)
{
    UNUSED(fastRingBufferAddr); 
}

}  // namespace runtime
}  // namespace cce