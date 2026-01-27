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
}  // namespace runtime
}  // namespace cce