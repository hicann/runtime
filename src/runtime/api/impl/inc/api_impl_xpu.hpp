/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_API_API_IMPL_XPU_HPP_
#define RUNTIME_API_API_IMPL_XPU_HPP_

#include "api_xpu.hpp"

namespace cce {
namespace runtime {

// Runtime APIXPU implement
class ApiImplXpu : public ApiXpu {
public:
    rtError_t SetXpuDevice(const rtXpuDevType devType, const uint32_t devId) override;
    rtError_t ResetXpuDevice(const rtXpuDevType devType, const uint32_t devId) override;
    rtError_t GetXpuDevCount(const rtXpuDevType devType, uint32_t* devCount) override;
    rtError_t XpuSetTaskFailCallback(const rtXpuDevType devType, const char_t* moduleName, void* callback) override;
};

} // namespace runtime
} // namespace cce

#endif // RUNTIME_API_API_IMPL_XPU_HPP_