/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ALOG_STUB_H
#define ALOG_STUB_H

#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

void *logDlopen(const char *fileName, int mode);
int logDlclose(void *handle);
void *logDlsym(void *handle, const char* funcName);

int32_t GetSlogFuncCallCount(int32_t index);
int32_t GetPlogFuncCallCount(int32_t index);

void SetUnifiedSwitch(bool swtich);

#ifdef __cplusplus
}
#endif
#endif // ALOG_STUB_H