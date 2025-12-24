/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <vector>
#include "dump_common.h"
#include "runtime/rt.h"
#include "runtime/mem.h"
#include "rts/rts_device.h"
#include "rts/rts_stream.h"
#include "rts/rts_kernel.h"
#include "kernel_info_collector.h"
#include "dump_exception_stub.h"

namespace Adx {
void FreeExceptionRegInfo()
{
    for (auto ptr : g_exceptionRegInfoList) {
        free(ptr);
    }
    g_exceptionRegInfoList.clear();
}

void ParseKernelSymbolsStub(const char *elf, KernelSymbols &kernelSymbols)
{
    kernelSymbols.existAicBase = true;
    kernelSymbols.aicBase = 0UL;
    kernelSymbols.existAivBase = true;
    kernelSymbols.aivBase = 1000UL;
    KernelSymbolInfo aic_symbolInfo{0UL, 0UL, std::string("aic_symbol")};
    kernelSymbols.symbols.emplace_back(aic_symbolInfo);
    KernelSymbolInfo aiv_symbolInfo{1000UL, 1000UL, std::string("aiv_symbol")};
    kernelSymbols.symbols.emplace_back(aiv_symbolInfo);
}
}