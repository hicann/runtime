/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TDT_COMMON_COMMON_INC_TSD_UTIL_H
#define TDT_COMMON_COMMON_INC_TSD_UTIL_H

#include <functional>
namespace tsd {
class ScopeGuard {
public:
    explicit ScopeGuard(const std::function<void()> exitScope)
        : exitScope_(exitScope)
    {}

    ~ScopeGuard()
    {
        exitScope_();
    }

private:
    ScopeGuard(ScopeGuard const&) = delete;
    ScopeGuard& operator=(ScopeGuard const&) = delete;
    ScopeGuard& operator=(ScopeGuard &) = delete;
    ScopeGuard(ScopeGuard&&) = delete;
    ScopeGuard& operator=(ScopeGuard&&) = delete;
    std::function<void()> exitScope_;
};
} // namespace tdt
#endif // TDT_COMMON_COMMON_INC_TSD_UTIL_H
