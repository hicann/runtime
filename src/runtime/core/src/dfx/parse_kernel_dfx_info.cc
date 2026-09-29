/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "parse_kernel_dfx_info.hpp"
#include <atomic>

namespace cce {
namespace runtime {
namespace {
std::atomic<rtParseDfxInfoFunc> g_parseDfxInfoFunc{nullptr};
}

rtError_t SetParseDfxInfoFunc(rtParseDfxInfoFunc func)
{
    g_parseDfxInfoFunc.store(func, std::memory_order_release);
    if (func != nullptr) {
        RT_LOG(RT_LOG_INFO, "Register parse dfx info callback success, func=%p.", func);
    } else {
        RT_LOG(RT_LOG_INFO, "Clear parse dfx info callback success.");
    }
    return RT_ERROR_NONE;
}

rtParseDfxInfoFunc GetParseDfxInfoFunc() { return g_parseDfxInfoFunc.load(std::memory_order_acquire); }

} // namespace runtime
} // namespace cce
