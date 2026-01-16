/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_REGISTER_MEMORY_HPP
#define CCE_RUNTIME_REGISTER_MEMORY_HPP

#include "base.hpp"

namespace cce {
namespace runtime {
void InsertMappedMemory(const void *ptr, const uint64_t size, const void *devPtr);
void InsertPinnedMemory(const void *ptr, const uint64_t size);
void EraseMappedMemory(const void *ptr);
void ErasePinnedMemory(const void *ptr);
bool IsRegisteredMemory(const void *ptr);
bool IsPinnedMemoryBase(const void *ptr);
bool IsMappedMemoryBase(const void *ptr);
void* GetMappedDevicePointer(const void *ptr);
rtError_t CheckMemoryRangeRegistered(const void *ptr, const uint64_t size);
}  // namespace runtime
}  // namespace cce

#endif // REGISTER_MEMORY_HPP