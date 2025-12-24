/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SCD_LOG_H
#define SCD_LOG_H

#include <unistd.h>
#include "stacktrace_logger.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define SCD_RLOG_INF(msg, ...) TraceDlogInner(DLOG_INFO, "[RUN]", msg,  ##__VA_ARGS__)
#define SCD_DLOG_ERR(msg, ...) TraceDlogInner(DLOG_ERROR, "[ERROR]", msg,  ##__VA_ARGS__)
#define SCD_DLOG_WAR(msg, ...) TraceDlogInner(DLOG_WARN, "[WARN]", msg,  ##__VA_ARGS__)
#define SCD_DLOG_INF(msg, ...) TraceDlogInner(DLOG_INFO, "[INFO]", msg,  ##__VA_ARGS__)
#define SCD_DLOG_DBG(msg, ...) TraceDlogInner(DLOG_DEBUG, "[DEBUG]", msg,  ##__VA_ARGS__)

#define SCD_CHK_EXPR_ACTION(expr, ACTION, msg, ...) do { \
    if (expr) { \
        SCD_DLOG_ERR(msg, ##__VA_ARGS__); \
        ACTION; \
    } \
} while (0)

#define SCD_CHK_PTR_ACTION(PTR, ACTION) do { \
    if ((PTR) == NULL) { \
        SCD_DLOG_ERR("invalid ptr parameter [" #PTR "](NULL)."); \
        ACTION; \
    } \
} while (0)

#ifdef __cplusplus
}
#endif // __cplusplus

#endif
