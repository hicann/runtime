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

void SafeStrCopy(char *dest, const char *src, size_t maxLen)
{
    if (dest == nullptr || src == nullptr) {
        return;
    }
    size_t srcLen = 0;
    while (src[srcLen] != '\0' && srcLen < (maxLen - 1)) {
        ++srcLen;
    }
    for (size_t i = 0; i < srcLen; ++i) {
        dest[i] = src[i];
    }
    dest[srcLen] = '\0';
}

void SetKernelName(ExceptionDumpInfo &info, const char *name)
{
    SafeStrCopy(info.kernelName, name, MAX_KERNELNAME_LEN);
}

void SetDisplayName(ExceptionDumpInfo &info, const char *name)
{
    SafeStrCopy(info.kernelDisplayName, name, MAX_KERNELNAME_LEN);
}

uint32_t FillCallbackResult(uint32_t realSizeVal, ExceptionDumpMode modeVal,
                           uint32_t *realSize, ExceptionDumpMode *mode)
{
    if (realSize != nullptr) {
        *realSize = realSizeVal;
    }
    if (mode != nullptr) {
        *mode = modeVal;
    }
    return 0;
}

uint32_t MockExceptionCallback(void *exceptionInfo, ExceptionDumpInfo *dumpInfo,
                              uint32_t dumpSize, uint32_t *realSize, ExceptionDumpMode *mode)
{
    (void)exceptionInfo;
    (void)dumpInfo;
    (void)dumpSize;
    return FillCallbackResult(0, ExceptionDumpMode::DUMP_MODE_NONE, realSize, mode);
}

uint32_t MockCallbackWithOverwrite(void *exceptionInfo, ExceptionDumpInfo *dumpInfo,
                                  uint32_t dumpSize, uint32_t *realSize, ExceptionDumpMode *mode)
{
    (void)exceptionInfo;
    if (dumpInfo != nullptr && dumpSize > 0) {
        dumpInfo[0] = {};
        dumpInfo[0].coreType = 1;
        dumpInfo[0].coreId = 1;
        dumpInfo[0].argSize = 128;
        dumpInfo[0].argAddr = reinterpret_cast<void*>(0x1000);
        SetKernelName(dumpInfo[0], "test_kernel");
        SetDisplayName(dumpInfo[0], "test_display");
    }
    return FillCallbackResult(1, ExceptionDumpMode::DUMP_MODE_OVERWRITE, realSize, mode);
}

uint32_t MockCallbackWithAdditional(void *exceptionInfo, ExceptionDumpInfo *dumpInfo,
                                   uint32_t dumpSize, uint32_t *realSize, ExceptionDumpMode *mode)
{
    (void)exceptionInfo;
    if (dumpInfo != nullptr && dumpSize > 0) {
        dumpInfo[0] = {};
        dumpInfo[0].coreType = 2;
        dumpInfo[0].coreId = 2;
        SetKernelName(dumpInfo[0], "add_kernel");
    }
    return FillCallbackResult(1, ExceptionDumpMode::DUMP_MODE_ADDITIONAL, realSize, mode);
}

uint32_t MockCallbackWithNone(void *exceptionInfo, ExceptionDumpInfo *dumpInfo,
                             uint32_t dumpSize, uint32_t *realSize, ExceptionDumpMode *mode)
{
    (void)exceptionInfo;
    (void)dumpInfo;
    (void)dumpSize;
    return FillCallbackResult(0, ExceptionDumpMode::DUMP_MODE_NONE, realSize, mode);
}

uint32_t MockCallbackWithUnsafePathSlash(void *exceptionInfo, ExceptionDumpInfo *dumpInfo,
                                        uint32_t dumpSize, uint32_t *realSize, ExceptionDumpMode *mode)
{
    (void)exceptionInfo;
    if (dumpInfo != nullptr && dumpSize > 0) {
        dumpInfo[0] = {};
        SetKernelName(dumpInfo[0], "safe_kernel");
        SetDisplayName(dumpInfo[0], "unsafe/path");
    }
    return FillCallbackResult(1, ExceptionDumpMode::DUMP_MODE_OVERWRITE, realSize, mode);
}

uint32_t MockCallbackWithUnsafePathBackslash(void *exceptionInfo, ExceptionDumpInfo *dumpInfo,
                                            uint32_t dumpSize, uint32_t *realSize, ExceptionDumpMode *mode)
{
    (void)exceptionInfo;
    if (dumpInfo != nullptr && dumpSize > 0) {
        dumpInfo[0] = {};
        SetKernelName(dumpInfo[0], "unsafe\\kernel");
        SetDisplayName(dumpInfo[0], "safe_display");
    }
    return FillCallbackResult(1, ExceptionDumpMode::DUMP_MODE_OVERWRITE, realSize, mode);
}

uint32_t MockCallbackWithUnsafeParentDir(void *exceptionInfo, ExceptionDumpInfo *dumpInfo,
                                        uint32_t dumpSize, uint32_t *realSize, ExceptionDumpMode *mode)
{
    (void)exceptionInfo;
    if (dumpInfo != nullptr && dumpSize > 0) {
        dumpInfo[0] = {};
        SetKernelName(dumpInfo[0], "../escape");
        SetDisplayName(dumpInfo[0], "normal_name");
    }
    return FillCallbackResult(1, ExceptionDumpMode::DUMP_MODE_ADDITIONAL, realSize, mode);
}

uint32_t MockCallbackWithUnsafeControlChar(void *exceptionInfo, ExceptionDumpInfo *dumpInfo,
                                          uint32_t dumpSize, uint32_t *realSize, ExceptionDumpMode *mode)
{
    (void)exceptionInfo;
    if (dumpInfo != nullptr && dumpSize > 0) {
        dumpInfo[0] = {};
        SetKernelName(dumpInfo[0], "test");
        SetDisplayName(dumpInfo[0], "bad\x0Aname");
    }
    return FillCallbackResult(1, ExceptionDumpMode::DUMP_MODE_OVERWRITE, realSize, mode);
}

uint32_t MockCallbackWithEmptyNames(void *exceptionInfo, ExceptionDumpInfo *dumpInfo,
                                   uint32_t dumpSize, uint32_t *realSize, ExceptionDumpMode *mode)
{
    (void)exceptionInfo;
    if (dumpInfo != nullptr && dumpSize > 0) {
        dumpInfo[0] = {};
        dumpInfo[0].coreType = 1;
        dumpInfo[0].coreId = 1;
        dumpInfo[0].argSize = 16;
        dumpInfo[0].argAddr = reinterpret_cast<void*>(0x2000);
        dumpInfo[0].kernelName[0] = '\0';
        dumpInfo[0].kernelDisplayName[0] = '\0';
    }
    return FillCallbackResult(1, ExceptionDumpMode::DUMP_MODE_OVERWRITE, realSize, mode);
}
}