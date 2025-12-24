/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef STACKCORE_STUB_H
#define STACKCORE_STUB_H

#include <stdint.h>
#include <signal.h>

#ifdef __cplusplus
extern "C" {
#endif

#define SUBDIR           "stackcore_subdir"
#define MAX_FILENAME_LEN 256
#define CORE_BUFFER_LEN  512
#define MAX_COREFILE_NUM 50

extern void StackSigHandler(int sigNum, siginfo_t *info, void *data);
extern uintptr_t StackFrame(int layer, uintptr_t fp, char *data, unsigned int len);

int CheckStackcoreFileNum(const char *path);
uintptr_t StackFrame_stub(int layer, uintptr_t fp, char *data, unsigned int len);
int32_t raise_stub(int32_t sig);

#ifdef __cplusplus
}
#endif
#endif // STACKCORE_STUB_H