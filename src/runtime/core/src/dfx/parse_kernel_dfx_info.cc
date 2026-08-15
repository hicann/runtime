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
namespace cce {
namespace runtime {

rtError_t ParseKernelDfxInfo::SetCallback(rtParseDfxInfoFunc func)
{
    const std::lock_guard<std::mutex> callbackLock(parseKernelDfxInfoMutex_);
    // runtime不校验cb合法性，客户端传入什么runtime侧保留什么：
    // 1. 允许func为nullptr（清除已有回调）
    // 2. 允许重复注册（新值覆盖旧值）
    cb_ = func;
    if (func != nullptr) {
        RT_LOG(RT_LOG_INFO, "Register parse dfx info callback success, func=%p.", func);
    } else {
        RT_LOG(RT_LOG_INFO, "Clear parse dfx info callback success.");
    }
    return RT_ERROR_NONE;
}

rtParseDfxInfoFunc ParseKernelDfxInfo::GetCallback()
{
    const std::lock_guard<std::mutex> callbackLock(parseKernelDfxInfoMutex_);
    return cb_;
}

} // namespace runtime
} // namespace cce
