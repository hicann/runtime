/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "errno/error_code.h"

#ifndef BASIC_UTILS_UTILS_H
#define BASIC_UTILS_UTILS_H

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include "osal/osal.h"

#ifdef __cplusplus
extern "C" {
#endif

#define MAX_DEVICE_NUM 64U
#define MAX_ERR_STRING_LEN 256
#define DEFAULT_OUTPUT_MAX_LEGTH 512
#define CWD_VAL_MAX_LEN 8193 // 1024 * 8 + 1: 8k
#define MAX_NUMBER_LONG_LEN 21U // uint64 max len + '\0'
#define MAX_NUMBER_LEN 11U // uint32 max len + '\0'
#define MAX_NUMBER_FLOAT_LEN 8U
#define MAX_NUMBER_VAL 10
#define MIDDLE_NUMBER_VAL 2
#define TRANSFER_FROM_S_TO_NS 1000000000
#define DEFAULT_HOST_ID MAX_DEVICE_NUM
#define MAX_TASK_SLOT   (DEFAULT_HOST_ID + 1U)
#define UNUSED(x) (void)(x)
#define DATESTR_MAXLEN 80U
#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
#define AVP_PROF_API __declspec(dllexport)
#else
#define AVP_PROF_API __attribute__((visibility("default")))
#endif
#if defined(__PROF_LLT)
#define STATIC
#define INLINE
#else
#define STATIC static
#define INLINE inline
#endif

void *MsprofMalloc(size_t size);
void *MsprofRealloc(void *ptr, size_t oldSize, size_t newSize);
bool IsDir(const CHAR* path);
bool IsDirAccessible(const CHAR* path);
bool IsFileExist(const CHAR* path);
bool GetSelfPath(CHAR* resultDir);
bool CreateDirectory(CHAR* resultPath);
bool CheckIsUIntNum(const CHAR* numberStr);
bool CheckStringNumRange(const CHAR* numberStr, const CHAR* target);
bool RelativePathToAbsolutePath(const CHAR* path, CHAR* resultDir, size_t len);
bool GetCwdString(const CHAR* path, CHAR* resultDir, size_t len);
CHAR* TransferUint32ToString(uint32_t num);
CHAR* TransferUint64ToString(uint64_t num);
CHAR* TransferFloatToString(float num);
int64_t GetClockMonotonicTime(void);
uint64_t GetBkdrHashId(const CHAR *str);
uint64_t TransferStringToInt(CHAR *nptr, size_t nptrLen, CHAR **endptr, uint64_t base);
double TransferStringToDouble(CHAR *nptr, size_t nptrLen, CHAR **endptr);
int32_t TransferDoubleToString(double d, CHAR buffer[]);
int32_t VTransferIntToString(CHAR buffer[], const CHAR* format, va_list arglist);
int32_t TransferIntToString(CHAR buffer[], const CHAR* format, ...);
CHAR *TimestampToTime(uint64_t timestamp, uint32_t unit);
CHAR *Strtok(CHAR *strToken, const CHAR *delimit, CHAR **context);

#ifdef __cplusplus
}
#endif
#endif
