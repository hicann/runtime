/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ACL_LOG_H_
#define ACL_LOG_H_

#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>
#include "log_types.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef uintptr_t acllogCallbackHandle;

typedef enum { OUTPUT_TYPE_DEBUG = 0, OUTPUT_TYPE_RUN = 1, OUTPUT_TYPE_BOTH = 2, OUTPUT_TYPE_MAX } acllogOutputLogType;

typedef int32_t (*acllogRecordCallback)(void* userData, uint32_t outputLogType, const char* logContent, size_t length);

LOG_FUNC_VISIBILITY int32_t acllogRegisterCallback(
    acllogRecordCallback callbackFunc, void* userData, uint32_t outputLogType, acllogCallbackHandle* callbackHandle);

LOG_FUNC_VISIBILITY int32_t acllogUnregisterCallback(acllogCallbackHandle callback);

LOG_FUNC_VISIBILITY int32_t acllogCheckDebugLevel(int32_t moduleId, int32_t logLevel) __attribute((weak));

LOG_FUNC_VISIBILITY void acllogRecord(int32_t moduleId, int32_t level, const char* fmt, ...) __attribute((weak))
__attribute__((format(printf, 3, 4)));

LOG_FUNC_VISIBILITY void acllogVaList(int32_t moduleId, int32_t level, const char* fmt, va_list list)
    __attribute((weak));

#ifdef __cplusplus
}
#endif

#endif // ACL_LOG_H_
