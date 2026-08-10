/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpu_timeout_control.h"

#include "aicpu_c.hpp"
#include "aicpu_schedule/aicpusd_info.h"
#include "device.hpp"
#include "inner_thread_local.hpp"
#include "npu_driver.hpp"
#include "osal.hpp"
#include "rt_external_mem.h"
#include "stream.hpp"

namespace cce {
namespace runtime {
namespace {
constexpr const char_t* AICPU_CHECK_SUPPORTED_KERNEL_NAME = "CheckKernelSupported";
constexpr const char_t* AICPU_CLOSE_MONITOR_KERNEL_NAME = "CloseAicpuMonitor";
constexpr uint32_t AICPU_KERNEL_SUPPORTED = 0U;
constexpr uint8_t AICPU_MONITOR_RESULT_UNSET = UINT8_MAX;
constexpr int32_t AICPU_MONITOR_COMPAT_KERNEL_SYNC_TIMEOUT_MS = 10000;

struct CloseAicpuMonitorArgs {
    uint8_t monitorEnabled;
    uint8_t retCode;
    uint8_t rsv[2];
};
} // namespace

rtError_t AicpuTimeoutControl::CloseAicpuMonitor(const Device* const dev, bool& closed)
{
    closed = false;
    Driver* const drv = dev->Driver_();
    COND_RETURN_ERROR(drv == nullptr, RT_ERROR_INVALID_VALUE, "driver is null, deviceId=%u", dev->Id_());

    const uint32_t devId = dev->Id_();
    void* devArgsBuf = nullptr;

    rtError_t ret = drv->DevMemAlloc(&devArgsBuf, sizeof(CloseAicpuMonitorArgs), RT_MEMORY_DEFAULT, devId);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "DevMemAlloc args failed, deviceId=%u, ret=%d", devId, ret);
        return ret;
    }
    const ScopeGuard memGuard([&drv, &devArgsBuf, devId]() {
        if (devArgsBuf != nullptr) {
            (void)drv->DevMemFree(devArgsBuf, devId);
        }
    });

    CloseAicpuMonitorArgs args = {};
    args.monitorEnabled = 1U; // Protocol value 1 disables AI CPU self-monitoring.
    args.retCode = AICPU_MONITOR_RESULT_UNSET;
    ret = drv->MemCopySync(devArgsBuf, sizeof(args), &args, sizeof(args), RT_MEMCPY_HOST_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "MemCopySync args H2D failed, deviceId=%u, ret=%d", devId, ret);
        return ret;
    }

    Stream* const stm = dev->GetCtrlSQStream(dev->PrimaryStream_());
    COND_RETURN_ERROR(
        stm == nullptr, RT_ERROR_INVALID_VALUE, "Stream for AI CPU compatibility kernel is null, deviceId=%u", devId);
    ret =
        LaunchAicpuBuiltinKernel(stm, AICPU_CLOSE_MONITOR_KERNEL_NAME, devArgsBuf, static_cast<uint32_t>(sizeof(args)));
    if (ret != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "Launch AI CPU compatibility kernel failed, kernel=%s, deviceId=%u, ret=%d",
            AICPU_CLOSE_MONITOR_KERNEL_NAME, devId, ret);
        return ret;
    }
    ret = stm->Synchronize(false, AICPU_MONITOR_COMPAT_KERNEL_SYNC_TIMEOUT_MS);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR,
            "Synchronize AI CPU compatibility kernel failed, kernel=%s, deviceId=%u, timeout=%d ms, ret=%d",
            AICPU_CLOSE_MONITOR_KERNEL_NAME, devId, AICPU_MONITOR_COMPAT_KERNEL_SYNC_TIMEOUT_MS, ret);
        return ret;
    }

    CloseAicpuMonitorArgs result = {};
    ret = drv->MemCopySync(&result, sizeof(result), devArgsBuf, sizeof(result), RT_MEMCPY_DEVICE_TO_HOST);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "MemCopySync args D2H failed, deviceId=%u, ret=%d", devId, ret);
        return ret;
    }

    if (result.retCode != 0U) {
        RT_LOG(RT_LOG_ERROR, "CloseAicpuMonitor rejected by AI CPU, deviceId=%u, retCode=%u", devId, result.retCode);
        return RT_ERROR_INVALID_VALUE;
    }

    closed = true;
    RT_LOG(RT_LOG_INFO, "CloseAicpuMonitor success, deviceId=%u", devId);
    return RT_ERROR_NONE;
}

rtError_t AicpuTimeoutControl::CheckKernelSupported(
    const Device* const dev, const std::string& kernelName, bool& isSupported)
{
    isSupported = false;
    Driver* const drv = dev->Driver_();
    COND_RETURN_ERROR(drv == nullptr, RT_ERROR_INVALID_VALUE, "driver is null, deviceId=%u", dev->Id_());
    COND_RETURN_ERROR(kernelName.empty(), RT_ERROR_INVALID_VALUE, "kernelName is empty");
    const uint32_t devId = dev->Id_();
    const uint32_t nameLen = static_cast<uint32_t>(kernelName.length());
    void* devNameBuf = nullptr;
    void* devResultBuf = nullptr;
    void* devCfgBuf = nullptr;

    rtError_t ret = drv->DevMemAlloc(&devNameBuf, nameLen, RT_MEMORY_DEFAULT, devId);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "DevMemAlloc name failed, len=%u, ret=%d", nameLen, ret);
        return ret;
    }
    const ScopeGuard memGuard([&drv, &devNameBuf, &devResultBuf, &devCfgBuf, devId]() {
        if (devNameBuf != nullptr) {
            (void)drv->DevMemFree(devNameBuf, devId);
        }
        if (devResultBuf != nullptr) {
            (void)drv->DevMemFree(devResultBuf, devId);
        }
        if (devCfgBuf != nullptr) {
            (void)drv->DevMemFree(devCfgBuf, devId);
        }
    });

    ret = drv->DevMemAlloc(&devResultBuf, sizeof(uint32_t), RT_MEMORY_DEFAULT, devId);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "DevMemAlloc result failed, ret=%d", ret);
        return ret;
    }
    ret = drv->DevMemAlloc(&devCfgBuf, sizeof(CheckKernelSupportedConfig), RT_MEMORY_DEFAULT, devId);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "DevMemAlloc config failed, ret=%d", ret);
        return ret;
    }

    ret = drv->MemCopySync(devNameBuf, nameLen, kernelName.c_str(), nameLen, RT_MEMCPY_HOST_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "MemCopySync name H2D failed, ret=%d", ret);
        return ret;
    }
    const uint32_t initResult = MAX_UINT32_NUM;
    ret = drv->MemCopySync(devResultBuf, sizeof(uint32_t), &initResult, sizeof(uint32_t), RT_MEMCPY_HOST_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "MemCopySync result H2D failed, ret=%d", ret);
        return ret;
    }

    CheckKernelSupportedConfig cfg = {};
    cfg.kernelNameAddr = RtPtrToValue(devNameBuf);
    cfg.kernelNameLen = nameLen;
    cfg.checkResultAddr = RtPtrToValue(devResultBuf);
    cfg.checkResultLen = static_cast<uint32_t>(sizeof(uint32_t));
    ret = drv->MemCopySync(devCfgBuf, sizeof(cfg), &cfg, sizeof(cfg), RT_MEMCPY_HOST_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "MemCopySync config H2D failed, ret=%d", ret);
        return ret;
    }

    Stream* const stm = dev->GetCtrlSQStream(dev->PrimaryStream_());
    COND_RETURN_ERROR(
        stm == nullptr, RT_ERROR_INVALID_VALUE, "Stream for AI CPU compatibility kernel is null, deviceId=%u", devId);
    ret =
        LaunchAicpuBuiltinKernel(stm, AICPU_CHECK_SUPPORTED_KERNEL_NAME, devCfgBuf, static_cast<uint32_t>(sizeof(cfg)));
    if (ret != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "Launch AI CPU compatibility kernel failed, kernel=%s, query=%s, deviceId=%u, ret=%d",
            AICPU_CHECK_SUPPORTED_KERNEL_NAME, kernelName.c_str(), devId, ret);
        return ret;
    }
    ret = stm->Synchronize(false, AICPU_MONITOR_COMPAT_KERNEL_SYNC_TIMEOUT_MS);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR,
            "Synchronize AI CPU compatibility kernel failed, kernel=%s, deviceId=%u, timeout=%d ms, ret=%d",
            AICPU_CHECK_SUPPORTED_KERNEL_NAME, devId, AICPU_MONITOR_COMPAT_KERNEL_SYNC_TIMEOUT_MS, ret);
        return ret;
    }

    uint32_t queryResult = MAX_UINT32_NUM;
    ret = drv->MemCopySync(&queryResult, sizeof(uint32_t), devResultBuf, sizeof(uint32_t), RT_MEMCPY_DEVICE_TO_HOST);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "MemCopySync result D2H failed, ret=%d", ret);
        return ret;
    }

    isSupported = (queryResult == AICPU_KERNEL_SUPPORTED);
    RT_LOG(
        RT_LOG_INFO, "CheckKernelSupported query=%s, result=%u, supported=%d", kernelName.c_str(), queryResult,
        isSupported);
    return RT_ERROR_NONE;
}

rtError_t AicpuTimeoutControl::LaunchAicpuBuiltinKernel(
    Stream* const stm, const char_t* const kernelName, void* const devArgs, const uint32_t argsSize)
{
    if (stm == nullptr) {
        RT_LOG(RT_LOG_ERROR, "stream is null");
        return RT_ERROR_INVALID_VALUE;
    }
    rtKernelLaunchNames_t launchNames = {};
    launchNames.soName = nullptr;
    launchNames.kernelName = kernelName;
    launchNames.opName = kernelName;

    rtArgsEx_t argsInfo = {};
    argsInfo.args = devArgs;
    argsInfo.argsSize = argsSize;
    argsInfo.isNoNeedH2DCopy = 1U;

    const uint32_t lastTaskId = InnerThreadLocalContainer::GetLastTaskId();
    const uint32_t lastStreamId = InnerThreadLocalContainer::GetLastStreamId();
    const ScopeGuard lastTaskInfoGuard([lastTaskId, lastStreamId]() {
        InnerThreadLocalContainer::SetLastTaskId(lastTaskId);
        InnerThreadLocalContainer::SetLastStreamId(lastStreamId);
    });
    const rtError_t launchRet = StreamLaunchCpuKernel(&launchNames, 1U, &argsInfo, stm, RT_KERNEL_DEFAULT);
    if (launchRet != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Launch AI CPU compatibility kernel failed, kernel=%s, ret=%d", kernelName, launchRet);
        return launchRet;
    }

    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
