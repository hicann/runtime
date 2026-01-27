/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPU_SHARDER_LOG_H
#define AICPU_SHARDER_LOG_H

#ifdef AICPU_SHARDER_UTST

#include <stdio.h>
#define AICPUE_LOGD(fmt, ...) \
    printf("[AICPU_SHARDER] %s:%s:%d:" fmt "\n", &__FUNCTION__[0], __FILE__, __LINE__, ##__VA_ARGS__)
#define AICPUE_LOGI(fmt, ...) \
    printf("[AICPU_SHARDER] %s:%s:%d:" fmt "\n", &__FUNCTION__[0], __FILE__, __LINE__, ##__VA_ARGS__)
#define AICPUE_LOGW(fmt, ...) \
    printf("[AICPU_SHARDER] %s:%s:%d:" fmt "\n", &__FUNCTION__[0], __FILE__, __LINE__, ##__VA_ARGS__)
#define AICPUE_LOGE(fmt, ...) \
    printf("[AICPU_SHARDER] %s:%s:%d:" fmt "\n", &__FUNCTION__[0], __FILE__, __LINE__, ##__VA_ARGS__)
#define AICPUE_RUN_LOGW(fmt, ...) \
    printf("[AICPU_SHARDER] %s:%s:%d:" fmt "\n", &__FUNCTION__[0], __FILE__, __LINE__, ##__VA_ARGS__)

#else
#include <unistd.h>
#include <cstdint>
#include <sys/syscall.h>
#include "aicpu_sharder_weak_log.h"
namespace aicpu {
inline const int64_t GetTid()
{
    thread_local static const int64_t TID = syscall(__NR_gettid);
    return TID;
}
}

#define AICPUE_LOGD(fmt, ...)                                                                                \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                           \
        dlog_debug(static_cast<int32_t>(AICPU), "[%s][tid:%ld][AICPU_SHARDER] " fmt,                         \
                   &__FUNCTION__[0], aicpu::GetTid(), ##__VA_ARGS__);                                        \
    }
#define AICPUE_LOGI(fmt, ...)                                                                                \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                           \
        dlog_info(static_cast<int32_t>(AICPU), "[%s][tid:%ld][AICPU_SHARDER] " fmt,                          \
                  &__FUNCTION__[0], aicpu::GetTid(), ##__VA_ARGS__);                                         \
    }
#define AICPUE_LOGW(fmt, ...)                                                                                \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                           \
        dlog_warn(static_cast<int32_t>(AICPU), "[%s][tid:%ld][AICPU_SHARDER] " fmt,                          \
                  &__FUNCTION__[0], aicpu::GetTid(), ##__VA_ARGS__);                                         \
    }
#define AICPUE_LOGE(fmt, ...)                                                                                \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                           \
        dlog_error(static_cast<int32_t>(AICPU), "[%s][tid:%ld][AICPU_SHARDER] " fmt,                         \
                   &__FUNCTION__[0], aicpu::GetTid(), ##__VA_ARGS__);                                        \
    }
#define AICPUE_LOGD(fmt, ...)                                                                                \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                           \
        dlog_debug(static_cast<int32_t>(AICPU), "[%s][tid:%ld][AICPU_SHARDER] " fmt,                         \
                   &__FUNCTION__[0], aicpu::GetTid(), ##__VA_ARGS__);                                        \
    }

#define AICPUE_RUN_LOGW(fmt, ...) \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                           \
        dlog_warn(static_cast<int32_t>(static_cast<uint32_t>(AICPU) | static_cast<uint32_t>(RUN_LOG_MASK)),  \
                  "[%s][tid:%ld][AICPU_SHARDER] " fmt, &__FUNCTION__[0], aicpu::GetTid(), ##__VA_ARGS__);    \
    }

#endif  // endif AICPU_SHARDER_UTST

#endif
