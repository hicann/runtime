/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TEST_DUMP_EXCEPTION_STUB_H
#define TEST_DUMP_EXCEPTION_STUB_H

#include <vector>
#include "kernel_info_collector.h"
#include "adump_pub.h"

extern std::vector<void *> g_exceptionRegInfoList;

namespace Adx {
void FreeExceptionRegInfo();
void ParseKernelSymbolsStub(const char *elf, KernelSymbols &kernelSymbols);

void SafeStrCopy(char *dest, const char *src, size_t maxLen);
void SetKernelName(ExceptionDumpInfo &info, const char *name);
void SetDisplayName(ExceptionDumpInfo &info, const char *name);
uint32_t FillCallbackResult(uint32_t realSizeVal, ExceptionDumpMode modeVal,
                           uint32_t *realSize, ExceptionDumpMode *mode);
uint32_t MockExceptionCallback(void *exceptionInfo, ExceptionDumpInfo *dumpInfo,
                              uint32_t dumpSize, uint32_t *realSize, ExceptionDumpMode *mode);
uint32_t MockCallbackWithOverwrite(void *exceptionInfo, ExceptionDumpInfo *dumpInfo,
                                  uint32_t dumpSize, uint32_t *realSize, ExceptionDumpMode *mode);
uint32_t MockCallbackWithAdditional(void *exceptionInfo, ExceptionDumpInfo *dumpInfo,
                                   uint32_t dumpSize, uint32_t *realSize, ExceptionDumpMode *mode);
uint32_t MockCallbackWithNone(void *exceptionInfo, ExceptionDumpInfo *dumpInfo,
                             uint32_t dumpSize, uint32_t *realSize, ExceptionDumpMode *mode);

uint32_t MockCallbackWithUnsafePathSlash(void *exceptionInfo, ExceptionDumpInfo *dumpInfo,
                                        uint32_t dumpSize, uint32_t *realSize, ExceptionDumpMode *mode);

uint32_t MockCallbackWithUnsafePathBackslash(void *exceptionInfo, ExceptionDumpInfo *dumpInfo,
                                            uint32_t dumpSize, uint32_t *realSize, ExceptionDumpMode *mode);

uint32_t MockCallbackWithUnsafeParentDir(void *exceptionInfo, ExceptionDumpInfo *dumpInfo,
                                        uint32_t dumpSize, uint32_t *realSize, ExceptionDumpMode *mode);

uint32_t MockCallbackWithUnsafeControlChar(void *exceptionInfo, ExceptionDumpInfo *dumpInfo,
                                          uint32_t dumpSize, uint32_t *realSize, ExceptionDumpMode *mode);

uint32_t MockCallbackWithEmptyNames(void *exceptionInfo, ExceptionDumpInfo *dumpInfo,
                                   uint32_t dumpSize, uint32_t *realSize, ExceptionDumpMode *mode);
}
#endif // TEST_DUMP_EXCEPTION_STUB_H