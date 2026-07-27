/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "kernel/symbol_table.hpp"
#include "runtime.hpp"
#include "context/context.hpp"
#include "kernel/program.hpp"
#include "common/error_message_manage.hpp"

namespace cce {
namespace runtime {

rtError_t SymbolTable::Register(void *binHandle, const void *hostVar, const char *deviceVarName,
                                 size_t size, uint32_t flags)
{
    Program *prog = static_cast<Program *>(binHandle);
    ElfProgram * const elfProg = dynamic_cast<ElfProgram *>(prog);
    COND_RETURN_ERROR_MSG_INNER(elfProg == nullptr, RT_ERROR_INVALID_VALUE, "can't dynamic_cast program.");

    uint64_t symbolOffset = 0ULL;
    uint64_t symbolSizeFromBin = 0ULL;
    rtError_t ret = elfProg->GetGlobalSymbol(deviceVarName, &symbolOffset, &symbolSizeFromBin);
    ERROR_RETURN(ret, "Get global symbol=%s failed, retCode=%#x.", deviceVarName, ret);

    SymbolEntry entry = {};
    entry.binHandle = binHandle;
    entry.hostVar = hostVar;
    entry.deviceVarName = deviceVarName;
    entry.deviceSymbolOffset = static_cast<uint32_t>(symbolOffset);
    entry.deviceSymbolSize = static_cast<uint32_t>(size);
    entry.flags = flags;

    symbolMapLock_.Lock();
    auto it = symbolMap_.find(hostVar);
    if (it != symbolMap_.end()) {
        symbolMapLock_.Unlock();
        RT_LOG(RT_LOG_WARNING, "Symbol hostVar=%p, binHandle=%p already registered, skip duplicate registration.", hostVar, binHandle);
        return RT_ERROR_NONE;
    }
    symbolMap_.emplace(hostVar, entry);
    symbolMapLock_.Unlock();

    RT_LOG(RT_LOG_DEBUG, "Register symbol success, hostVar=%p, deviceVarName=%s, offset=%llu, size=%llu",
        hostVar, deviceVarName, entry.deviceSymbolOffset, entry.deviceSymbolSize);
    return RT_ERROR_NONE;
}

rtError_t SymbolTable::Lookup(const void *hostVar, SymbolEntry &entry)
{
    symbolMapLock_.Lock();
    auto it = symbolMap_.find(hostVar);
    if (it == symbolMap_.end()) {
        symbolMapLock_.Unlock();
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1017, "Looking up symbol table", "symbol",
            "The corresponding device variable cannot be found through the symbol");
        return RT_ERROR_INVALID_SYMBOL;
    }

    entry = it->second;
    symbolMapLock_.Unlock();
    return RT_ERROR_NONE;
}

rtError_t SymbolTable::GetDeviceAddress(const void *hostVar, uint32_t deviceId, void **devPtr)
{
    SymbolEntry entry = {};
    rtError_t ret = Lookup(hostVar, entry);
    COND_RETURN_WITH_NOLOG(ret != RT_ERROR_NONE, ret);

    ElfProgram * const elfProg = dynamic_cast<ElfProgram *>(static_cast<Program *>(entry.binHandle));
    COND_RETURN_ERROR_MSG_INNER(elfProg == nullptr, RT_ERROR_INVALID_VALUE, "can't dynamic_cast program.");

    ret = elfProg->Load2Device();
    ERROR_RETURN(ret, "load program to device_id=%d failed, retCode=%#x", deviceId, ret);

    const void *baseAddr = elfProg->GetBinAlignBaseAddr(deviceId);
    COND_RETURN_ERROR_MSG_INNER(baseAddr == nullptr, RT_ERROR_PROGRAM_DATA,
        "binary not loaded to device, deviceId=%u", deviceId);

    *devPtr = RtValueToPtr<void *>(RtPtrToValue(baseAddr) + entry.deviceSymbolOffset);
    RT_LOG(RT_LOG_DEBUG, "Get symbol device address, hostVar=%p, deviceId=%u, devPtr=%p",
        hostVar, deviceId, *devPtr);
    return RT_ERROR_NONE;
}

rtError_t SymbolTable::GetSize(const void *hostVar, size_t *size)
{
    SymbolEntry entry = {};
    rtError_t ret = Lookup(hostVar, entry);
    COND_RETURN_WITH_NOLOG(ret != RT_ERROR_NONE, ret);

    *size = static_cast<size_t>(entry.deviceSymbolSize);
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce