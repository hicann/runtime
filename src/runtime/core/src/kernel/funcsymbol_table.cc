/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "kernel/funcsymbol_table.hpp"
#include "runtime.hpp"
#include "context/context.hpp"
#include "kernel/program.hpp"
#include "common/error_message_manage.hpp"

namespace cce {
namespace runtime {

rtError_t FuncSymbolTable::Register(void *binHandle, const void *symbol, const char_t * const kernelName)
{
    Program *prog = static_cast<Program *>(binHandle);
    Kernel *kernel = const_cast<Kernel*>(prog->GetKernelByName(kernelName));
    COND_RETURN_ERROR_MSG_INNER(kernel == nullptr, RT_ERROR_INVALID_VALUE, "can't get kernel in programe.");
    funcSymbolMapLock_.Lock();
    auto it = funcSymbolMap_.find(symbol);
    if (it != funcSymbolMap_.end()) {
        funcSymbolMapLock_.Unlock();
        RT_LOG(RT_LOG_WARNING, "Symbol=%p, binHandle=%p already registered, skip duplicate registration.", symbol, binHandle);
        return RT_ERROR_NONE;
    }
    funcSymbolMap_.emplace(symbol, kernel);
    funcSymbolMapLock_.Unlock();

    RT_LOG(RT_LOG_DEBUG, "Register function symbol success, symbol=%p",symbol);
    return RT_ERROR_NONE;
}

Kernel *FuncSymbolTable::Lookup(const void *symbol)
{
    Kernel *retKernel = nullptr;
    funcSymbolMapLock_.Lock();
    const auto iter = funcSymbolMap_.find(symbol);
    if (iter != funcSymbolMap_.end()) {
        retKernel = iter->second;
    }

    funcSymbolMapLock_.Unlock();
    return retKernel;
}

FuncSymbolTable::~FuncSymbolTable()
{
    funcSymbolMapLock_.Lock();
    funcSymbolMap_.clear();
    funcSymbolMapLock_.Unlock();
}

} // namespace runtime
} // namespace cce