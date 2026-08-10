/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpu_timeout_manager.h"

#include "aicpu_timeout_control.h"
#include "device.hpp"
#include "runtime.hpp"
#include "runtime/kernel.h"
#include "stars.hpp"

namespace cce {
namespace runtime {

bool AicpuTimeoutManager::IsStarsMonitorAicpuTimeoutSupported(const Device* const dev)
{
    return (dev != nullptr) && dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_STARS_MONITOR_AICPU_TIMEOUT) &&
           (dev->GetRunMode() == RT_RUN_MODE_ONLINE);
}

bool AicpuTimeoutManager::IsKfcType(const uint32_t kernelType)
{
    return (kernelType == static_cast<uint32_t>(KERNEL_TYPE_AICPU_KFC)) ||
           (kernelType == static_cast<uint32_t>(KERNEL_TYPE_CUSTOM_KFC));
}

bool AicpuTimeoutManager::IsTimeoutSupportedByKernelType(const Device* const dev, const uint32_t kernelType)
{
    if (IsStarsMonitorAicpuTimeoutSupported(dev)) {
        return true;
    }
    return IsKfcType(kernelType);
}

bool AicpuTimeoutManager::IsTimeoutSupportedByLaunchFlag(const Device* const dev, const uint32_t flag)
{
    if (IsStarsMonitorAicpuTimeoutSupported(dev)) {
        return true;
    }
    return (flag & RT_KERNEL_USE_SPECIAL_TIMEOUT) != 0U;
}

uint16_t AicpuTimeoutManager::GetAicpuDefaultKernelCredit(const Device* const dev)
{
    if (IsStarsMonitorAicpuTimeoutSupported(dev)) {
        return Runtime::Instance()->GetStarsFftsDefaultKernelCredit();
    }
    return RT_STARS_DEFAULT_AICPU_KERNEL_CREDIT;
}

void AicpuTimeoutManager::ClearAicpuTimeoutState(Device* const dev)
{
    if (dev == nullptr) {
        return;
    }
    dev->SetAicpuMonitorClosedStatus(false);
    dev->SetAicpuProcessStopPendingStatus(false);
}

void AicpuTimeoutManager::StopAicpuProcess(const Device* const dev)
{
    if (dev == nullptr) {
        return;
    }
    const uint32_t deviceId = dev->Id_();
    const rtError_t ret = Runtime::Instance()->StopAicpuExecutor(deviceId, dev->DevGetTsId(), true);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "StopAicpuExecutor failed, device_id=%u, ret=%u.", deviceId, ret);
        return;
    }
    RT_LOG(RT_LOG_INFO, "AI CPU process stopped after timeout, device_id=%u.", deviceId);
}

void AicpuTimeoutManager::UpdateAicpuTimeoutStateOnCqeReport(
    Device* const dev, const rtLogicCqReport_t& logicCq, const TaskInfo* const reportTask, TaskInfo* faultTaskPtr)
{
    if (!dev->GetAicpuMonitorClosedStatus()) {
        RT_LOG(RT_LOG_DEBUG, "AI CPU monitor is not closed, skip updating timeout state, device_id=%u.", dev->Id_());
        return;
    }
    const bool isReportTaskTimeout =
        (reportTask != nullptr) && (reportTask->type == TS_TASK_TYPE_KERNEL_AICPU) &&
        ((logicCq.errorType & static_cast<uint8_t>(RT_STARS_CQE_ERR_TYPE_TASK_TIMEOUT)) != 0U);
    const bool isFaultTaskTimeout = (faultTaskPtr != nullptr) && (faultTaskPtr->type == TS_TASK_TYPE_KERNEL_AICPU) &&
                                    (faultTaskPtr->errorCode == AICPU_TIMEOUT_RAW_ERRCODE);
    if (isReportTaskTimeout || isFaultTaskTimeout) {
        dev->SetAicpuProcessStopPendingStatus(true);
        RT_LOG(RT_LOG_INFO, "AI CPU timeout detected, set isAicpuProcessStopPending flag, device_id=%u.", dev->Id_());
    }
}

void AicpuTimeoutManager::CheckAndStopAicpuProcess(Device* const dev)
{
    if (dev == nullptr) {
        return;
    }
    if (!dev->GetAicpuMonitorClosedStatus()) {
        RT_LOG(RT_LOG_DEBUG, "AI CPU monitor is not closed, skip stopping AI CPU process, device_id=%u.", dev->Id_());
        return;
    }
    if (dev->GetAicpuProcessStopPendingStatus()) {
        dev->SetAicpuProcessStopPendingStatus(false);
        StopAicpuProcess(dev);
    }
}

rtError_t AicpuTimeoutManager::TryCloseAicpuMonitor(Device* const dev)
{
    const uint32_t devId = dev->Id_();
    if (!IsStarsMonitorAicpuTimeoutSupported(dev)) {
        RT_LOG(
            RT_LOG_DEBUG, "AI CPU timeout monitor takeover is unsupported, keep AI CPU self-monitor, deviceId=%u",
            devId);
        return RT_ERROR_NONE;
    }
    if (dev->GetAicpuMonitorClosedStatus()) {
        RT_LOG(RT_LOG_DEBUG, "AI CPU monitor is already closed, skip closing it again, device_id=%u.", devId);
        return RT_ERROR_NONE;
    }

    // Keep self-monitoring when the installed AI CPU package lacks the control kernel.
    bool isSupported = false;
    rtError_t ret = AicpuTimeoutControl::CheckKernelSupported(dev, "tsKernel:CloseAicpuMonitor", isSupported);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "CheckKernelSupported failed, deviceId=%u, ret=%u", devId, ret);
        return ret;
    }
    if (!isSupported) {
        RT_LOG(RT_LOG_INFO, "CLOSE_AICPU_MONITOR unsupported, keep AI CPU self-monitor, deviceId=%u", devId);
        return RT_ERROR_NONE;
    }

    bool closed = false;
    ret = AicpuTimeoutControl::CloseAicpuMonitor(dev, closed);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "CloseAicpuMonitor failed, deviceId=%u, ret=%u", devId, ret);
        return ret;
    }

    dev->SetAicpuMonitorClosedStatus(true);
    RT_LOG(RT_LOG_INFO, "AI CPU self-monitor closed via compatibility kernel, deviceId=%u", devId);
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
