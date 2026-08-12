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
#include "runtime.hpp"
#include "task.hpp"
#include "runtime_task_manager.h"

namespace cce {
namespace runtime {

bool IsRasFaultEventId(uint32_t eventId)
{
    return (eventId == HBM_ECC_NOTIFY_EVENT_ID) || (eventId == HBM_ECC_EVENT_ID);
}

static bool RegisterStarsErrorProcFunc()
{
    const auto& chips = GetV100Chips();
    for (const auto chip : chips) {
        RegErrorProcFunc(chip, AICORE_ERROR, &DeviceErrorProc::ProcessStarsCoreErrorInfo);
        RegErrorProcFunc(chip, AIVECTOR_ERROR, &DeviceErrorProc::ProcessStarsCoreErrorInfo);
        RegErrorProcFunc(chip, FFTS_PLUS_AICORE_ERROR, &DeviceErrorProc::ProcessStarsCoreErrorInfo);
        RegErrorProcFunc(chip, FFTS_PLUS_AIVECTOR_ERROR, &DeviceErrorProc::ProcessStarsCoreErrorInfo);
        RegErrorProcFunc(chip, WAIT_TIMEOUT_ERROR, &DeviceErrorProc::ProcessStarsWaitTimeoutErrorInfo);
        RegErrorProcFunc(chip, SDMA_ERROR, &DeviceErrorProc::ProcessStarsSdmaErrorInfo);
        RegErrorProcFunc(chip, AICPU_ERROR, &ProcessStarsAicpuErrorInfo);
        RegErrorProcFunc(chip, FFTS_PLUS_SDMA_ERROR, &DeviceErrorProc::ProcessStarsSdmaErrorInfo);
        RegErrorProcFunc(chip, FFTS_PLUS_AICPU_ERROR, &ProcessStarsAicpuErrorInfo);
        RegErrorProcFunc(chip, DVPP_ERROR, &DeviceErrorProc::ProcessStarsDvppErrorInfo);
        RegErrorProcFunc(chip, DSA_ERROR, &DeviceErrorProc::ProcessStarsDsaErrorInfo);
        RegErrorProcFunc(chip, FFTS_PLUS_DSA_ERROR, &DeviceErrorProc::ProcessStarsDsaErrorInfo);
        RegErrorProcFunc(chip, SQE_ERROR, &DeviceErrorProc::ProcessStarsSqeErrorInfo);
        RegErrorProcFunc(chip, HCCL_FFTSPLUS_TIMEOUT_ERROR, &DeviceErrorProc::ProcessStarsHcclFftsPlusTimeoutErrorInfo);
        RegErrorProcFunc(chip, AICORE_TIMEOUT_DFX, &DeviceErrorProc::ProcessStarsCoreTimeoutDfxInfo);
    }
    return true;
}

static bool g_registerStarsErrorProc = RegisterStarsErrorProcFunc();

uint16_t GetMteErrWaitCount() { return 120U; }

uint32_t GetRingbufferElementNum() { return RINGBUFFER_LEN; }

// fast ringbuffer(4k): DevRingBufferCtlInfo + RingBufferElementInfo + StarsOpExceptionInfo
void DeviceErrorProc::ProcessReportFastRingBuffer()
{
    COND_RETURN_VOID(device_ == nullptr, "device_ can not be nullptr.");
    if (fastRingBufferAddr_ == nullptr) {
        return; // not support fast ringbuffer
    }

    DevRingBufferCtlInfo* ctrlInfo = RtPtrToPtr<DevRingBufferCtlInfo*>(fastRingBufferAddr_);
    COND_PROC((ctrlInfo->magic != RINGBUFFER_MAGIC), return); // no error return
    StarsOpExceptionInfo report;
    {
        const std::lock_guard<std::mutex> lk(fastRingbufferMutex_);
        StarsOpExceptionInfo* starsReport = RtValueToPtr<StarsOpExceptionInfo*>(
            RtPtrToValue(fastRingBufferAddr_) + sizeof(DevRingBufferCtlInfo) + sizeof(RingBufferElementInfo));
        report = *starsReport;
        __sync_synchronize(); // 最后置标记位, 防止指令重排
        ctrlInfo->magic = 0U; // 释放fast ring buffer, 以下不要使用
    }
    ConvertErrorCodeForFastReport(&report);
    TaskInfo* tsk = device_->GetTaskFactory()->GetTask(static_cast<int32_t>(report.streamId), report.taskId);
    if (tsk == nullptr) {
        RT_LOG_INNER_MSG(
            RT_LOG_ERROR,
            "The fast ring buffer reports an error,"
            " device_id=%u, stream_id=%u, task_id=%u, sqe_type=%u, error_code=%#x, kernel_name=none.",
            device_->Id_(), report.streamId, report.taskId, report.sqeType, report.errorCode);
        RT_LOG(RT_LOG_ERROR, "The task has been recycled, stream_id=%u, task_id=%u.", report.streamId, report.taskId);
        return;
    }
    const char* errMsg = "a kernel task";
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
    RT_LOG_CALL_MSG(
        errModule,
        "The fast ring buffer reports %s error,"
        " device_id=%u, stream_id=%u, task_id=%u, sqe_type=%u, error_code=%#x, kernel_name=%s.",
        errMsg, device_->Id_(), report.streamId, report.taskId, report.sqeType, report.errorCode,
        GetTaskKernelName(tsk).c_str());
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
    DevRingBufferCtlInfo* ctrlInfo = RtPtrToPtr<DevRingBufferCtlInfo*>(fastRingBufferAddr_);
    ctrlInfo->magic = 0U;
}

void InitFastRingBuffer(void* fastRingBufferAddr) { UNUSED(fastRingBufferAddr); }

} // namespace runtime
} // namespace cce
