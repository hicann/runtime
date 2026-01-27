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
 
namespace cce {
namespace runtime {
 
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
}  // namespace runtime
}  // namespace cce