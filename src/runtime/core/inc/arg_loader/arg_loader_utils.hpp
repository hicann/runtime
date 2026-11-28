/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_ARG_LOADER_UTILS_HPP__
#define __CCE_RUNTIME_ARG_LOADER_UTILS_HPP__

#include "runtime/rt_external_kernel.h"

namespace cce {
namespace runtime {
// Validate all address fields before patching any kernel arguments.
// Ordinary arguments: tiling and host input addresses.
rtError_t CheckArgsAddressFields(const rtArgsEx_t* const argsInfo);
// AI CPU arguments: host input and kernel offset addresses.
rtError_t CheckArgsAddressFields(const rtAicpuArgsEx_t* const argsInfo);
// Fusion arguments: host input addresses.
rtError_t CheckArgsAddressFields(const rtFusionArgsEx_t* const argsInfo);
} // namespace runtime
} // namespace cce

#endif // __CCE_RUNTIME_ARG_LOADER_UTILS_HPP__
