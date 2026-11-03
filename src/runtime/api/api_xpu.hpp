/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_API_API_XPU_HPP_
#define RUNTIME_API_API_XPU_HPP_

#include "base.hpp"
#include "runtime/rt_external_base.h"

namespace cce {
namespace runtime {

// Runtime APIXpu interface
class ApiXpu {
public:
    ApiXpu() = default;
    virtual ~ApiXpu() = default;

    ApiXpu(const ApiXpu&) = delete;
    ApiXpu& operator=(const ApiXpu&) = delete;
    ApiXpu(ApiXpu&&) = delete;
    ApiXpu& operator=(ApiXpu&&) = delete;

    // Get ApiXpu instance
    static ApiXpu* Instance();

    virtual rtError_t SetXpuDevice(const rtXpuDevType devType, const uint32_t devId) = 0;
    virtual rtError_t ResetXpuDevice(const rtXpuDevType devType, const uint32_t devId) = 0;
    virtual rtError_t GetXpuDevCount(const rtXpuDevType devType, uint32_t* devCount) = 0;
    virtual rtError_t XpuSetTaskFailCallback(const rtXpuDevType devType, const char_t* moduleName, void* callback) = 0;
};
} // namespace runtime
} // namespace cce

#endif // RUNTIME_API_API_XPU_HPP_