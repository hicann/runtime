/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef SLOG_API_H
#define SLOG_API_H
#include "slog.h"
#ifdef __cplusplus
#ifndef LOG_CPP
extern "C" {
#endif
#endif // __cplusplus

typedef struct TagKv {
    char *kname;
    char *value;
} KeyValue;

/**
 * @ingroup slog
 * @brief Internal log interface, other modules are not allowed to call this interface
 */
LOG_FUNC_VISIBILITY void DlogErrorInner(int32_t moduleId, const char *fmt, ...);
LOG_FUNC_VISIBILITY void DlogWarnInner(int32_t moduleId, const char *fmt, ...);
LOG_FUNC_VISIBILITY void DlogInfoInner(int32_t moduleId, const char *fmt, ...);
LOG_FUNC_VISIBILITY void DlogDebugInner(int32_t moduleId, const char *fmt, ...);
LOG_FUNC_VISIBILITY void DlogEventInner(int32_t moduleId, const char *fmt, ...);
LOG_FUNC_VISIBILITY void DlogInner(int32_t moduleId, int32_t level, const char *fmt, ...);
LOG_FUNC_VISIBILITY void DlogWithKVInner(int32_t moduleId, int32_t level,
    const KeyValue *pstKVArray, int32_t kvNum, const char *fmt, ...);

#ifdef __cplusplus
#ifndef LOG_CPP
}
#endif // LOG_CPP
#endif // __cplusplus

#ifdef LOG_CPP
#ifdef __cplusplus
extern "C" {
#endif

/**
 * @ingroup slog
 * @brief Internal log interface, other modules are not allowed to call this interface
 */
LOG_FUNC_VISIBILITY void DlogInnerForC(int32_t moduleId, int32_t level, const char *fmt, ...);
LOG_FUNC_VISIBILITY void DlogWithKVInnerForC(int32_t moduleId, int32_t level,
    const KeyValue *pstKVArray, int32_t kvNum, const char *fmt, ...);

#ifdef __cplusplus
}
#endif
#endif // LOG_CPP
#endif