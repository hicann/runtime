/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SCD_UTIL_H
#define SCD_UTIL_H
#include <stdio.h>
#include <stdint.h>
#include <stddef.h>
#include <unistd.h>
#include <sys/types.h>
#include "atrace_types.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define SCD_UTIL_TMP_BUF_LEN    256U
#define SCD_MAX(a,b) ((a) > (b) ? (a) : (b))
#define SCD_MIN(a,b) ((a) < (b) ? (a) : (b))
#define SCD_UTIL_RETRY(exp) ({                     \
            __typeof__(exp) rc;                    \
            do {                                   \
                errno = 0;                         \
                rc = (exp);                        \
            } while (rc == -1 && errno == EINTR);  \
            rc; })

TraStatus ScdUtilTrim(char *start, uint32_t len, const char **pos);
void ScdUtilGetProcessName(int32_t pid, char *buf, size_t len);
void ScdUtilGetThreadName(int32_t pid, int32_t tid, char *buf, size_t len);
size_t ScdUtilsPtraceRead(int32_t pid, uintptr_t src, void *dst, size_t dstLen);

TraStatus ScdUtilReadStdin(void *buf, size_t len);
ssize_t ScdUtilReadLine(int32_t fd, char *buf, size_t len);
int32_t ScdUtilOpen(const char *path);
size_t ScdUtilWrite(int32_t fd, const void *data, size_t len);
void ScdUtilWriteTitle(int32_t fd, const char *title);
void ScdUtilWriteNewLine(int32_t fd);
int32_t ScdUtilGetProcFd(int32_t pid, const char* fileName);
TraStatus ScdUtilWriteProcInfo(int32_t fd, int32_t pid, const char* fileName);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif
