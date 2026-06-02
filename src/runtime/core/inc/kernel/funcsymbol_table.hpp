/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_FUNCSYMBOL_TABLE_HPP__
#define __CCE_RUNTIME_FUNCSYMBOL_TABLE_HPP__

#include <map>
#include "base.hpp"
#include "osal.hpp"
#include "kernel.hpp"

namespace cce {
namespace runtime {

class FuncSymbolTable : public NoCopy {
public:
    FuncSymbolTable() = default;
    ~FuncSymbolTable();

    rtError_t Register(void *binHandle, const void *symbol, const char_t * const kernelName);
    Kernel *Lookup(const void *symbol);

private:
    std::map<const void *, Kernel *> funcSymbolMap_;
    SpinLock funcSymbolMapLock_;
};

} // namespace runtime
} // namespace cce

#endif // __CCE_RUNTIME_FUNCSYMBOL_TABLE_HPP__