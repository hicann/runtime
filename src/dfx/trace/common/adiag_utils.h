/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TRACE_UTILS_H
#define TRACE_UTILS_H

#include <time.h>
#include <string.h>
#include "adiag_types.h"
#define SEC_TO_NS               1000000000ULL
#define FREQ_GHZ_TO_KHZ         1000000ULL
#define TIME_ONE_THOUSAND_MS    1000ULL
#define TIMESTAMP_MAX_LENGTH    29U

#define MAX_DEV_NUM             64
#define MIN_VFID_NUM            32 // min val of vfid
#define MAX_VFID_NUM            63 // max val of vfid

#define SOCKET_PATH_MAX_LENGTH  32U
#ifndef SOCKET_FILE_DIR
#define SOCKET_FILE_DIR         "/usr/slog/"
#endif
#define SOCKET_FILE             "/socket_trace"

#define FILE_SAVE_MODE_CHAR     0
#define FILE_SAVE_MODE_BIN      1


#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define ADIAG_SAFE_FREE(p) do { \
    AdiagFree(p);               \
    (p) = NULL;                 \
} while (0)

void *AdiagMalloc(size_t size);
void AdiagFree(void *ptr);
int32_t AdiagGetErrorCode(void);
AdiagStatus AdiagStrToInt(const char *str, int32_t *num);

void AdiagQuickSort(int32_t arr[], int32_t low, int32_t high);

uint64_t GetRealTime(void);
uint64_t GetMonotonicTime(void);
uint64_t GetCpuCycleCounter(void);
uint64_t GetCpuFrequency(void);
uint32_t GetNearestPowerOfTwo(uint32_t n);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif

