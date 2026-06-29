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
#include "driver/ascend_hal.h"
#include "api_impl.hpp"
#include "api_impl_mbuf.hpp"
#include "api_impl_soma.hpp"
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
#include "dev_info_manage.h"
#include "global_state_manager.hpp"
#include "kernel.hpp"
namespace cce {
namespace runtime {

Runtime::~Runtime()
{
    RT_LOG(RT_LOG_EVENT, "runtime destructor.");
    // ConstructRuntimeImpl can create a Runtime that has not run Init(); it must not flip process-wide exit state.
    const bool hasRuntimeExitHostState = HasRuntimeExitHostState();
    if (hasRuntimeExitHostState) {
        SetRuntimeExiting(true);
        isExiting_ = true;
        GlobalStateManager::GetInstance().ForceUnlocked();
        DestroyReportRasThread();
        (void)WaitMonitorExit();
        FinalizeRuntimeExitHostState();
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

    DELETE_O(apiImpl_);
    DELETE_O(apiImplMbuf_);
    DELETE_O(apiImplSoma_);
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

rtError_t Runtime::PrimaryXpuContextRelease(const uint32_t devId)
{
    UNUSED(devId);
    return RT_ERROR_NONE;
}

void Runtime::XpuDeviceRelease(Device *dev) const
{
    UNUSED(dev);
}

Device *Runtime::XpuDeviceRetain(const uint32_t devId) const
{
    UNUSED(devId);
    return nullptr;
}

Context *Runtime::PrimaryXpuContextRetain(const uint32_t devId)
{
    UNUSED(devId);
    return nullptr;
}
}  // namespace runtime
}  // namespace cce
