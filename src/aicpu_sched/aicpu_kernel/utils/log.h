/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPU_KERNEL_UTILS_LOG_H
#define AICPU_KERNEL_UTILS_LOG_H
#include <sys/syscall.h>
#include <cstdint>
#include <unistd.h>

#include "log_weak.h"

namespace aicpu {
inline int64_t GetTid()
{
  thread_local static int64_t tid = syscall(__NR_gettid);
  return tid;
}
}

#ifdef RUN_TEST
const char KERNEL_MODULE[] = "AICPU";
#define KERNEL_LOG_DEBUG(fmt, ...) ((void)0)
#define KERNEL_LOG_INFO(fmt, ...) ((void)0)
#define KERNEL_LOG_WARN(fmt, ...)                                              \
  printf("[WARN] [%s][%s][%s:%d][tid:%ld]:" fmt "\n", KERNEL_MODULE, __FILE__, \
         __FUNCTION__, __LINE__, aicpu::GetTid(), ##__VA_ARGS__)
#define KERNEL_LOG_ERROR(fmt, ...)                                    \
  printf("[ERROR] [%s][%s][%s:%d][tid:%ld]:" fmt "\n", KERNEL_MODULE, \
         __FILE__, __FUNCTION__, __LINE__, aicpu::GetTid(), ##__VA_ARGS__)
#define KERNEL_LOG_EVENT(fmt, ...)                                    \
  printf("[EVENT] [%s][%s][%s:%d][tid:%ld]:" fmt "\n", KERNEL_MODULE, \
         __FILE__, __FUNCTION__, __LINE__, aicpu::GetTid(), ##__VA_ARGS__)
#else
#define KERNEL_LOG_DEBUG(fmt, ...)                                                    \
  do {                                                                                \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                    \
      dlog_debug(AICPU, "[%s:%d][%s][tid:%ld]" fmt, __FILE__, __LINE__, __func__,     \
                 aicpu::GetTid(), ##__VA_ARGS__);                                     \
    }                                                                                 \
  } while (0)

#define KERNEL_LOG_INFO(fmt, ...)                                                     \
  do {                                                                                \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                    \
      dlog_info(AICPU, "[%s:%d][%s][tid:%ld]" fmt, __FILE__, __LINE__, __func__,      \
                aicpu::GetTid(), ##__VA_ARGS__);                                      \
    }                                                                                 \
  } while (0)

#define KERNEL_LOG_WARN(fmt, ...)                                                     \
  do {                                                                                \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                    \
      dlog_warn(AICPU, "[%s:%d][%s][tid:%ld]" fmt, __FILE__, __LINE__, __func__,      \
                aicpu::GetTid(), ##__VA_ARGS__);                                      \
    }                                                                                 \
  } while (0)

#define KERNEL_LOG_ERROR(fmt, ...)                                                    \
  do {                                                                                \
    if (&DlogRecord != nullptr) {                                                     \
      dlog_error(AICPU, "[%s:%d][%s][tid:%ld]" fmt, __FILE__, __LINE__, __func__,     \
                 aicpu::GetTid(), ##__VA_ARGS__);                                     \
    }                                                                                 \
  } while (0)

#define KERNEL_LOG_EVENT(fmt, ...)                                                    \
  do {                                                                                \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                    \
      dlog_info(static_cast<int32_t>(static_cast<uint32_t>(AICPU) |                   \
                static_cast<uint32_t>(RUN_LOG_MASK)), "[%s:%d][%s][tid:%ld]" fmt,     \
                __FILE__, __LINE__, __func__, aicpu::GetTid(), ##__VA_ARGS__);        \
    }                                                                                 \
  } while (0)
#endif

#define KERNEL_CHECK_NULLPTR_VOID(value, logText...) \
  if (value == nullptr) {                            \
    KERNEL_LOG_ERROR(logText);                       \
    return;                                          \
  }

#define KERNEL_CHECK_FALSE(condition, errorCode, logText...)  \
  if (!(condition)) {                                         \
    KERNEL_LOG_ERROR(logText);                                \
    return errorCode;                                         \
  }

#define KERNEL_CHECK_NULLPTR(value, errorCode, logText...) \
  if (value == nullptr) {                                  \
    KERNEL_LOG_ERROR(logText);                             \
    return errorCode;                                      \
  }

#define KERNEL_CHECK_ASSIGN_64S_MULTI(A, B, result, errorCode)            \
  if ((A) != 0 && (B) != 0 && ((INT64_MAX) / (A)) <= (B)) {               \
    KERNEL_LOG_ERROR("Integer reversed multiA: %ld * multiB: %ld", (A),   \
                     (B));                                                \
    return errorCode;                                                     \
  }                                                                       \
  (result) = ((A) * (B));

#define KERNEL_CHECK_FALSE_RUN_INFO(condition, errorCode, logText...) \
  if (!(condition)) {                                                 \
    KERNEL_LOG_EVENT(logText);                                        \
    return errorCode;                                                 \
  }

#define KERNEL_CHECK_FALSE_VOID(condition, logText...)        \
  if (!(condition)) {                                         \
    KERNEL_LOG_ERROR(logText);                                \
    return;                                                   \
  }

#define KERNEL_HANDLE_ERROR(expression, logText...) {         \
    uint32_t ret = expression;                                \
    if (ret != 0U) {                                          \
      KERNEL_LOG_ERROR(logText);                              \
      return ret;                                             \
    }                                                         \
  }

#define KERNEL_CHECK_ERROR(expression)                        \
  do {                                                        \
    uint32_t ret = expression;                                \
    if (ret != 0U) {                                          \
      return ret;                                             \
    }                                                         \
  } while (0)

#define KERNEL_CHECK_FALSE_EXEC(condition, execExpr...) if (!(condition)) {                                \
        execExpr;                                 \
    }

#define KERNEL_CHECK_RET(condition, errorCode)                \
  do {                                                        \
    if (condition) {                                          \
      return errorCode;                                       \
    }                                                         \
  } while (0)

#endif  // AICPU_KERNEL_UTILS_LOG_H
