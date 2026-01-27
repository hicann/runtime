/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_COREDUMP_C_HPP__
#define __CCE_RUNTIME_COREDUMP_C_HPP__

#include "task_info.hpp"

namespace cce {
namespace runtime {

rtError_t ReadAICoreDebugInfo(const rtDebugMemoryParam_t * const param);
rtError_t GetStackBufferInfo(const rtBinHandle binHandle, const uint32_t coreType, const uint32_t coreId,
    const void **stack, uint32_t *stackSize);

}  // namespace runtime
}  // namespace cce

#endif // __CCE_RUNTIME_COREDUMP_C_HPP__