/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef C_BASE_ERROR_MANAGER_H
#define C_BASE_ERROR_MANAGER_H

#include <stdint.h>

#define LINUX 0
#define LITEOS 1

#if (NANO_OS_TYPE == LITEOS)
#define ERROR_MANAGER_MODULE_CLOSE
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifndef ERROR_MANAGER_MODULE_CLOSE
#define LIMIT_PER_MESSAGE 1024
#define ARRAY(...)  \
    {               \
        __VA_ARGS__ \
    }

#define REPORT_INNER_ERROR(errCode, fmt, ...) \
    FormatReportInner(                        \
        errCode, "[FUNC:%s][FILE:%s][LINE:%zu]" #fmt, &__FUNCTION__[0], __FILE__, (size_t)(__LINE__), ##__VA_ARGS__)

#define REPORT_INPUT_ERROR(errCode, params, vals)                                         \
    do {                                                                                  \
        char *argList[] = params;                                                         \
        char *argVal[] = vals;                                                            \
        ReportErrMessage(errCode, argList, argVal, sizeof(argList) / sizeof(argList[0])); \
    } while (false)

// 请调用者必须保证数组args和arg_values个数一致,且数组个数argsNum正确
void ReportErrMessage(const char *errorCode, char *args[], char *argValues[], int32_t argsNum);
void ReportInterErrMessage(const char *errorCode, const char *errorMsg);
char *GetErrorMessage(void);
void FormatReportInner(const char *errorCode, const char *fmt, ...);
#else
#define REPORT_INNER_ERROR(errCode, fmt, ...)
#define REPORT_INPUT_ERROR(errCode, params, vals)
__attribute__((weak)) char *GetErrorMessage(void)
{
    return NULL;
}

#endif

#ifdef __cplusplus
}
#endif
#endif // C_BASE_ERROR_MANAGER_H