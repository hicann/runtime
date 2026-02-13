/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_monitor.h"
#include "aicpusd_status.h"
#include "tdt/status.h"
#include "aicpu_context.h"
#include "aicpu_pulse.h"
#include "aicpusd_resource_manager.h"
#include "aicpusd_util.h"
#include "aicpusd_meminfo_process.h"
#include "aicpusd_drv_manager.h"

namespace AicpuSchedule {
    AicpuMonitor::AicpuMonitor() {}
    AicpuMonitor &AicpuMonitor::GetInstance()
    {
        static AicpuMonitor instance;
        return instance;
    }
    AicpuMonitor::~AicpuMonitor() {}
    void AicpuMonitor::DisableModelTimeout() {}
}
namespace tdt {
    StatusFactory* StatusFactory::GetInstance()
    {
        static StatusFactory instance_;
        return &instance_;
    }
    void StatusFactory::RegisterErrorNo(const uint32_t err, const std::string& desc) {}
    StatusFactory::StatusFactory() {}
}

namespace {
    // current thread context
    thread_local aicpu::aicpuContext_t g_curCtx;
}

namespace aicpu {
__attribute__((visibility("default"))) status_t aicpuSetContext(aicpuContext_t *ctx)
{
    aicpusd_info("Aicpu set ctx in stub func[%s].", __func__);
    g_curCtx = *ctx;
    return AICPU_ERROR_NONE;
}

__attribute__((visibility("default"))) status_t aicpuGetContext(aicpuContext_t *ctx)
{
    aicpusd_info("Aicpu get ctx in stub func[%s].", __func__);
    *ctx = g_curCtx;
    return AICPU_ERROR_NONE;
}
}

namespace AicpuSchedule {
    BufManager &BufManager::GetInstance()
    {
        static BufManager instance;
        return instance;
    }
    ModelStreamManager &ModelStreamManager::GetInstance()
    {
        static ModelStreamManager instance;
        return instance;
    }
    void BufManager::InitBufManager()
    {
    }
    EventWaitManager &EventWaitManager::NotifyWaitManager(const uint32_t waitIdCount)
    {
        static EventWaitManager notifyWaitInstance("Notify", waitIdCount);
        return notifyWaitInstance;
    }

    EventWaitManager &EventWaitManager::EndGraphWaitManager(const uint32_t waitIdCount)
    {
        static EventWaitManager endGraphWaitInstance("EndGraph", waitIdCount);
        return endGraphWaitInstance;
    }

    EventWaitManager &EventWaitManager::QueueNotEmptyWaitManager(const uint32_t waitIdCount)
    {
        static EventWaitManager queueNotEmptyWaitInstance("QueueNotEmpty", waitIdCount);
        return queueNotEmptyWaitInstance;
    }

    EventWaitManager &EventWaitManager::QueueNotFullWaitManager(const uint32_t waitIdCount)
    {
        static EventWaitManager queueNotFullWaitInstance("QueueNotFull", waitIdCount);
        return queueNotFullWaitInstance;
    }

    EventWaitManager &EventWaitManager::PrepareMemWaitManager(const uint32_t waitIdCount)
    {
        static EventWaitManager prepareMemWaitInstance("PrepareMem", waitIdCount);
        return prepareMemWaitInstance;
    }

    EventWaitManager &EventWaitManager::AnyQueNotEmptyWaitManager(const uint32_t waitIdCount)
    {
        static EventWaitManager anyQueNotEmptyWaitInstance("AnyQueNotEmpty", waitIdCount);
        return anyQueNotEmptyWaitInstance;
    }

    EventWaitManager &EventWaitManager::TableUnlockWaitManager(const uint32_t waitIdCount)
    {
        static EventWaitManager tableUnlockWaitInstance("TableUnlock", waitIdCount);
        return tableUnlockWaitInstance;
    }
}