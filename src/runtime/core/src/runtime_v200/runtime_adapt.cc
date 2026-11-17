/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime.hpp"
#include <fstream>
#include "mmpa/mmpa_api.h"
#include "driver/ascend_hal.h"
#include "api_impl.hpp"
#include "api_snapshot.hpp"
#include "api_impl_soma.hpp"
#include "api_event.hpp"
#include "context.hpp"
#include "ctrl_stream.hpp"
#include "engine_stream_observer.hpp"
#include "raw_device.hpp"
#include "program.hpp"
#include "module.hpp"
#include "api_error.hpp"
#include "logger.hpp"
#include "profiler.hpp"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "driver.hpp"
#include "npu_driver.hpp"
#include "subscribe.hpp"
#include "base.hpp"
#include "device_state_callback_manager.hpp"
#include "prof_ctrl_callback_manager.hpp"
#include "errcode_manage.hpp"
#include "error_message_manage.hpp"
#include "toolchain/prof_acl_api.h"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "profiling_agent.hpp"
#include "task_submit.hpp"
#include "atrace_log.hpp"
#include "platform/platform_info.h"
#include "stream_state_callback_manager.hpp"
#include "memory_pool.hpp"
#include "soc_info.h"
#include "utils.h"
#include "device.hpp"
#include "api_impl_creator.hpp"
#include "api_kernel_args.hpp"
#include "dev_info_manage.h"
#include "global_state_manager.hpp"
#include "kernel.hpp"
namespace cce {
namespace runtime {

static bool IsHostCcMode()
{
    constexpr const char_t* hostCcDevicePath = "/dev/sev-guest";
    return mmAccess2(hostCcDevicePath, M_F_OK) == EN_OK;
}

static rtError_t CheckDeviceCcStatus(const uint32_t deviceId)
{
    bool deviceCcOn = false;
    const rtError_t error = NpuDriver::QueryDeviceCcStatus(deviceId, deviceCcOn);
    ERROR_RETURN(
        error, "Failed to query device CC status, device_id=%u, retCode=%#x.", deviceId, static_cast<uint32_t>(error));
    COND_RETURN_ERROR(
        !deviceCcOn, RT_ERROR_INVALID_VALUE, "Device CC is disabled in a confidential host environment, device_id=%u.",
        deviceId);
    return RT_ERROR_NONE;
}

rtError_t Runtime::CheckVisibleDevicesCcStatus() const
{
    rtError_t error = RT_ERROR_NONE;
    COND_RETURN_ERROR(
        !isHaveDevice_, RT_ERROR_DRV_NO_DEVICE, "No visible device is available in a confidential host environment.");

    // Host CC 开启后，所有可见设备都必须查询成功且处于 CC ON 状态。
    const char_t* visibleEnv = nullptr;
    MM_SYS_GET_ENV(MM_ENV_ASCEND_RT_VISIBLE_DEVICES, visibleEnv);
    if (visibleEnv == nullptr) {
        uint32_t deviceCount = 0U;
        const drvError_t drvRet = drvGetDevNum(&deviceCount);
        COND_RETURN_ERROR(
            drvRet != DRV_ERROR_NONE, RT_ERROR_DRV_ERR, "Failed to get visible devices, drvRetCode=%d.",
            static_cast<int32_t>(drvRet));
        COND_RETURN_ERROR(
            (deviceCount == 0U) || (deviceCount > RT_MAX_DEV_NUM), RT_ERROR_INVALID_VALUE,
            "Invalid visible device count, device_count=%u.", deviceCount);
        for (uint32_t deviceId = 0U; deviceId < deviceCount; ++deviceId) {
            error = CheckDeviceCcStatus(deviceId);
            COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
        }
    } else {
        if (!isSetVisibleDev || (deviceInfo == nullptr) || (deviceCnt == 0U) || (deviceCnt > RT_MAX_DEV_NUM) ||
            (userDeviceCnt == 0U) || (userDeviceCnt > RT_SET_DEVICE_STR_MAX_LEN) || (userDeviceCnt > deviceCnt) ||
            (retType != RT_ALL_DATA_OK)) {
            RT_LOG(RT_LOG_ERROR, "Invalid visible-device configuration, ret_type=%d.", static_cast<int32_t>(retType));
            return (retType == RT_GET_DRIVER_ERROR) ? RT_ERROR_DRV_ERR : RT_ERROR_INVALID_VALUE;
        }
        for (uint32_t index = 0U; index < userDeviceCnt; ++index) {
            COND_RETURN_ERROR(
                (deviceInfo[index] == MAX_UINT32_NUM) || (deviceInfo[index] >= deviceCnt), RT_ERROR_INVALID_VALUE,
                "Invalid visible device id, index=%u, device_id=%u.", index, deviceInfo[index]);
            error = CheckDeviceCcStatus(deviceInfo[index]);
            COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
        }
    }
    return RT_ERROR_NONE;
}

void Runtime::ResetPersistingL2CacheSizes()
{
    for (uint32_t deviceId = 0U; deviceId < RT_MAX_DEV_NUM; ++deviceId) {
        ResetPersistingL2CacheSizes(deviceId);
    }
}

void Runtime::ResetPersistingL2CacheSizes(const uint32_t deviceId)
{
    if (!persistingL2CacheSet_[deviceId].load()) {
        return;
    }

    // The driver treats an all-zero config as a reset; no capacity query is needed.
    L2CachePersistConfig bufContext{};
    const rtError_t error = NpuDriver::SetDeviceInfoByBuff(
        deviceId, MODULE_TYPE_QOS, INFO_TYPE_L2_PERSIST_CAP, &bufContext, sizeof(bufContext));
    if (error == RT_ERROR_NONE) {
        persistingL2CacheSet_[deviceId].store(false);
    } else {
        RT_LOG(
            RT_LOG_WARNING, "Reset persisting L2 cache size failed, device_id=%u, retCode=%#x.", deviceId,
            static_cast<uint32_t>(error));
    }
    RT_LOG(RT_LOG_DEBUG, "Reset persisting L2 cache size done, device_id=%u.", deviceId);
}

rtError_t Runtime::InitCcFeature() const
{
    // CC 特性按芯片函数表注册入口开启：未注册 CC 特性的芯片直接返回，
    // 不做 /dev/sev-guest 探测与可见设备查询，避免无 CC 芯片被误检测。
    DevDynInfoProcFunc func{};
    if ((GET_DEV_INFO_PROC_FUNC(chipType_, func) != RT_ERROR_NONE) || (func.regCCFeatureProcFunc == nullptr)) {
        return RT_ERROR_NONE;
    }

    // CC 特性初始化：环境检测（fail closed）+ 通过芯片函数表触发特性注册。
    COND_RETURN_INFO(!IsHostCcMode(), RT_ERROR_NONE, "CC mode is disabled because host CC is off.");
    RT_LOG(RT_LOG_INFO, "Host CC mode is enabled, /dev/sev-guest detected.");

    // Host CC 开启后，所有可见设备都必须查询成功且处于 CC ON 状态。
    rtError_t error = CheckVisibleDevicesCcStatus();
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to validate visible devices for confidential computing, retCode=%#x.",
        static_cast<uint32_t>(error));
    error = func.regCCFeatureProcFunc(chipType_);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to register CC process functions, retCode=%#x.",
        static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

Runtime::~Runtime()
{
    if (apiImplSnapshot_ != nullptr) {
        apiImplSnapshot_->StopSnapshotService();
    }
    RT_LOG(RT_LOG_EVENT, "runtime destructor.");
    // ConstructRuntimeImpl can create a Runtime that has not run Init(); it must not flip process-wide exit state.
    const bool hasRuntimeExitHostState = HasRuntimeExitHostState();
    if (hasRuntimeExitHostState) {
        PrepareProcessExitNoThrow();
    }

    // Runtime direct-exit must not unload libtsdclient.so: its global destructors
    // can enter TSD/HDC/driver close paths while lower modules are also exiting.
    // The process exit path releases the mapping; explicit device release still
    // closes TSD through the normal DeviceRelease/StopAicpuExecutor flow.
    tsdClientHandle_ = nullptr;
    tsdOpen_ = nullptr;
    tsdOpenEx_ = nullptr;
    tsdClose_ = nullptr;
    tsdCloseEx_ = nullptr;
    tsdInitQs_ = nullptr;
    tsdInitFlowGw_ = nullptr;
    tsdHandleAicpuProfiling_ = nullptr;
    tsdSetProfCallback_ = nullptr;

    api_ = nullptr;
    apiMbuf_ = nullptr;
    apiSoma_ = nullptr;
    apiEvent_ = nullptr;
    apiKernelFunc_ = nullptr;
    apiEsched_ = nullptr;
    apiSnapshot_ = nullptr;
    apiRtConfig_ = nullptr;
    apiDeviceTopology_ = nullptr;
    apiKernelArgs_ = nullptr;
    apiIpcMemory_ = nullptr;
    apiHostMemory_ = nullptr;
    apiVmm_ = nullptr;
    apiXpu_ = nullptr;

    DELETE_O(apiImpl_);
    DestroyImplMbuf(apiImplMbuf_);
    DELETE_O(apiImplSoma_);
    DELETE_O(apiImplEvent_);
    DestroyImplEsched(apiImplEsched_);
    DestroyImplSnapshot(apiImplSnapshot_);
    DestroyImplRtConfig(apiImplRtConfig_);
    DestroyImplDeviceTopology(apiImplDeviceTopology_);
    DestroyImplIpcMemory(apiImplIpcMemory_);
    DestroyImplHostMemory(apiImplHostMemory_);
    DestroyImplVmm(apiImplVmm_);
    DestroyImplXpu(apiImplXpu_);
    DestroyImplKernelArgs(apiImplKernelArgs_);
    DestroyImplKernelFunc(apiImplKernelFunc_);
    DELETE_O(apiError_);
    DELETE_O(logger_);
    DELETE_O(profiler_);
    DELETE_O(streamObserver_);
    DELETE_O(aicpuStreamIdBitmap_);
    DELETE_O(cbSubscribe_);
    DELETE_O(programAllocator_);
    DELETE_O(labelAllocator_);
    DELETE_A(deviceInfo);
    DELETE_A(userDeviceInfo);
    DELETE_O(threadGuard_);

    excptCallBack_ = nullptr;
    virAicoreNum_ = 0U;
    isVirtualMode_ = false;
    isHaveDevice_ = false;
    DeleteModuleBackupPoint();
}

} // namespace runtime
} // namespace cce
