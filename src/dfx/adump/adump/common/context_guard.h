/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADUMP_COMMON_CONTEXT_GUARD_H
#define ADUMP_COMMON_CONTEXT_GUARD_H
#include <functional>

namespace Adx {
using OnExitFn = std::function<void()>;

class ContextGuard {
public:
    explicit ContextGuard(const OnExitFn &onExit) : onExit_(onExit) {}
    ~ContextGuard()
    {
        if (onExit_ != nullptr) {
            try {
                onExit_();
            } catch (std::bad_function_call &) {
                // just catch exception
            } catch (...) {
                // just catch exception
            }
        }
    }

private:
    OnExitFn onExit_;
};

#define MAKE_CONTEXT_GUARD(var, cb) const ::Adx::ContextGuard ctxGuard_##var __attribute__((unused))(cb)
} // namespace Adx
#endif // ADUMP_COMMON_CONTEXT_GUARD_H