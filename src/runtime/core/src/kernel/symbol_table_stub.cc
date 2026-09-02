/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "symbol_table.hpp"

namespace cce {
namespace runtime {
rtError_t SymbolTable::Register(
    void* binHandle, const void* hostVar, const char* deviceVarName, size_t size, uint32_t flags)
{
    UNUSED(binHandle);
    UNUSED(hostVar);
    UNUSED(deviceVarName);
    UNUSED(size);
    UNUSED(flags);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t SymbolTable::Lookup(const void* hostVar, SymbolEntry& entry)
{
    UNUSED(hostVar);
    UNUSED(entry);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t SymbolTable::GetDeviceAddress(const void* hostVar, uint32_t deviceId, void** devPtr)
{
    UNUSED(hostVar);
    UNUSED(deviceId);
    UNUSED(devPtr);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t SymbolTable::GetSize(const void* hostVar, size_t* size)
{
    UNUSED(hostVar);
    UNUSED(size);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

} // namespace runtime
} // namespace cce
