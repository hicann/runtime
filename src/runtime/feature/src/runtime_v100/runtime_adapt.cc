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
#include "api_impl_mbuf.hpp"
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
#include "prof_api.h"
#include "profiling_agent.hpp"
#include "task_submit.hpp"
#include "atrace_log.hpp"
#include "platform/platform_info.h"
#include "stream_state_callback_manager.hpp"
#include "memory_pool.hpp"
#include "soc_info.h"
#include "runtime_keeper.h"
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
    DestroyReportRasThread();
    isExiting_ = true;
    (void)WaitMonitorExit();
    for (uint32_t i = 0U; i < RT_MAX_DEV_NUM; i++) {
        for (uint32_t j = 0U; j < tsNum_; j++) {
            Context *context = priCtxs_[i][j].GetVal(false);
            priCtxs_[i][j].ResetVal();
            if (context != nullptr) {
                if (context->GetCount() == 0ULL) {
                    try {
                        (void)context->TearDown();
                    } catch (...) {
                    }
                    delete context;
                    context = nullptr;
                }
            }
        }
    }

    for (uint32_t i = 0U; i < maxProgramNum_; i++) {
        if (programAllocator_ == nullptr) {
            break;
        }
        if (!programAllocator_->CheckIdValid(i)) {
            continue;
        }

        RefObject<Program *> * const programItem = programAllocator_->GetDataToItem(i);
        Program *programInst = programItem->GetVal(false);
        if (programInst != nullptr) {
            delete programInst;
            programInst = nullptr;
            programItem->ResetVal();
        }
    }

    if (tsdClientHandle_ != nullptr) {
        (void)mmDlclose(tsdClientHandle_);
    }

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

    DELETE_O(apiImpl_);
    DELETE_O(apiImplMbuf_);
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