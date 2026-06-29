/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_TEST_RUNTIME_EXIT_TEST_HELPER_H
#define CCE_RUNTIME_TEST_RUNTIME_EXIT_TEST_HELPER_H

#include <cstdint>
#include "engine.hpp"

namespace cce {
namespace runtime {

// This helper intentionally touches private Runtime fields. Include this file only
// while the test translation unit has temporarily defined private as public.
class RuntimeExitStateGuard {
public:
    explicit RuntimeExitStateGuard(Runtime *runtime, const bool exiting)
        : runtime_(runtime), oldExiting_((runtime != nullptr) && runtime->isExiting_)
    {
        if (runtime_ != nullptr) {
            runtime_->isExiting_ = exiting;
        }
    }

    ~RuntimeExitStateGuard()
    {
        if (runtime_ != nullptr) {
            runtime_->isExiting_ = oldExiting_;
        }
    }

private:
    Runtime *runtime_;
    bool oldExiting_;
};

class ExitMockEngine : public Engine {
public:
    explicit ExitMockEngine(Device * const dev) : Engine(dev)
    {
    }

    rtError_t Init() override
    {
        return RT_ERROR_NONE;
    }

    rtError_t Start() override
    {
        return RT_ERROR_NONE;
    }

    rtError_t Stop() override
    {
        stopCalled_++;
        return stopRet_;
    }

    void Run(const void * const param) override
    {
        (void)param;
    }

    bool CheckSendThreadAlive() override
    {
        checkSendCalled_++;
        return true;
    }

    bool CheckReceiveThreadAlive() override
    {
        checkReceiveCalled_++;
        return true;
    }

    bool CheckMonitorThreadAlive() override
    {
        checkMonitorCalled_++;
        return true;
    }

    rtError_t stopRet_ = RT_ERROR_NONE;
    uint32_t stopCalled_ = 0U;
    uint32_t checkSendCalled_ = 0U;
    uint32_t checkReceiveCalled_ = 0U;
    uint32_t checkMonitorCalled_ = 0U;
};

}  // namespace runtime
}  // namespace cce

#endif  // CCE_RUNTIME_TEST_RUNTIME_EXIT_TEST_HELPER_H
