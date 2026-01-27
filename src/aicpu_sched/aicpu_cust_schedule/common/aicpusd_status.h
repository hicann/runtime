/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPUSD_STATUS_H
#define AICPUSD_STATUS_H

#include <string>
#include <unistd.h>
#include <sys/syscall.h>
#include "aicpucust_weak_log.h"
#include "type_def.h"
#include "aicpu_error_log_api.h"

namespace AicpuSchedule {
constexpr const char_t *AICPUSD_MODULE = "AICPU_SCHEDULE";
constexpr const char_t *REPORT_DRV_MODULE = "DRV";
constexpr const char_t *REPORT_AICPU_MODULE = "AICPU";
inline const uint64_t GetTid()
{
    thread_local static const uint64_t tid = static_cast<uint64_t>(syscall(__NR_gettid));
    return tid;
}

// 22001 ~ 22200: error codes for hwts task execution
// 22201 ~: inner error code
using StatusCode = int32_t;
constexpr int32_t AICPU_SCHEDULE_OK = 0;
constexpr int32_t AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID = 22001;
constexpr int32_t AICPU_SCHEDULE_ERROR_DRV_ERR = 22002;
constexpr int32_t AICPU_SCHEDULE_ERROR_TOOL_ERR = 22003;
constexpr int32_t AICPU_SCHEDULE_ERROR_TASK_EXECUTE_PARAM_INVALID = 22004;
constexpr int32_t AICPU_SCHEDULE_ERROR_TASK_EXECUTE_FAILED = 22005;
constexpr int32_t AICPU_SCHEDULE_ERROR_TASK_EXECUTE_TIMEOUT = 22006;
constexpr int32_t AICPU_SCHEDULE_ERROR_INNER_ERROR = 22007;
constexpr int32_t AICPU_SCHEDULE_ERROR_DUMP_FAILED = 22008;
// error code for overflow
constexpr int32_t AICPU_SCHEDULE_ERROR_UNDERFLOW = 22010;
constexpr int32_t AICPU_SCHEDULE_ERROR_OVERFLOW = 22011;
constexpr int32_t AICPU_SCHEDULE_ERROR_DIVISIONZERO = 22012;
// reserved inner error
constexpr int32_t AICPU_SCHEDULE_ERROR_RESERVED = 22200;

// the following error codes are uniformly normalized to AICPU_SCHEDULE_ERROR_INNER_ERROR
constexpr int32_t AICPU_SCHEDULE_ERROR_INIT_CP_FAILED = 22201;
constexpr int32_t AICPU_SCHEDULE_ERROR_INIT_FAILED = 22202;
constexpr int32_t AICPU_SCHEDULE_ERROR_UNKNOW_AICPU_EVENT = 22203;
constexpr int32_t AICPU_SCHEDULE_COMMON_FAILED = 22204;
constexpr int32_t AICPU_SCHEDULE_ERROR_COMMON_ERROR = 22205;
constexpr int32_t AICPU_SCHEDULE_ERROR_DUMP_TASK_WAIT_ERROR = 22206;
// the following error codes are uniformly normalized to AICPU_SCHEDULE_ERROR_INNER_ERROR
constexpr int32_t AICPU_SCHEDULE_ERROR_NOT_FOUND_CMD_TYPE = 21201;
constexpr int32_t AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT = 21202;
constexpr int32_t AICPU_SCHEDULE_ERROR_NOT_FOUND_VERSION = 21203;
constexpr int32_t AICPU_SCHEDULE_ERROR_INVALID_MAGIC_NUM = 21204;
constexpr int32_t AICPU_SCHEDULE_ERROR_NOT_FOUND_FUNCTION = 21205;
constexpr int32_t  AICPU_SCHEDULE_ERROR_FROM_DRV = 21206;
}

#define aicpusd_err(fmt, ...)                                                                                        \
    do {                                                                                                             \
        aicpu::RestoreErrorLog(&__FUNCTION__[0], __FILE__, __LINE__, AicpuSchedule::GetTid(), (fmt), ##__VA_ARGS__); \
        if (&DlogRecord != nullptr) {                                                                                \
            dlog_error(static_cast<int32_t>(CCECPU), "[%s][tid:%lu][%s] " fmt, &__func__[0],                         \
                       AicpuSchedule::GetTid(), AicpuSchedule::AICPUSD_MODULE, ##__VA_ARGS__);                       \
        }                                                                                                            \
    } while (0)

#define aicpusd_warn(fmt, ...)                                                                                       \
    do {                                                                                                             \
        if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                               \
            dlog_warn(static_cast<int32_t>(CCECPU), "[%s][tid:%lu][%s] " fmt, &__func__[0],                          \
                      AicpuSchedule::GetTid(), AicpuSchedule::AICPUSD_MODULE, ##__VA_ARGS__);                        \
        }                                                                                                            \
    } while (0)

#define aicpusd_info(fmt, ...)                                                                                       \
    do {                                                                                                             \
        if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                               \
            dlog_info(static_cast<int32_t>(CCECPU), "[%s][tid:%lu][%s] " fmt, &__func__[0],                          \
                      AicpuSchedule::GetTid(), AicpuSchedule::AICPUSD_MODULE, ##__VA_ARGS__);                        \
        }                                                                                                            \
    } while (0)

#define aicpusd_debug(fmt, ...)                                                                                      \
    do {                                                                                                             \
        if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                               \
            dlog_debug(static_cast<int32_t>(CCECPU), "[%s][tid:%lu][%s] " fmt, &__func__[0],                         \
                       AicpuSchedule::GetTid(), AicpuSchedule::AICPUSD_MODULE, ##__VA_ARGS__);                       \
        }                                                                                                            \
    } while (0)

#define aicpusd_memory_log(fmt, ...)                                                                                 \
    do {                                                                                                             \
        if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                               \
            dlog_info(static_cast<int32_t>(CCECPU), "[%s][tid:%lu][%s] " fmt, &__func__[0],                          \
                      AicpuSchedule::GetTid(), AicpuSchedule::AICPUSD_MODULE, ##__VA_ARGS__);                        \
        }                                                                                                            \
    } while (0)

#define aicpusd_run_info(fmt, ...)                                                                                   \
    do {                                                                                                             \
        if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                               \
            dlog_info(static_cast<int32_t>(static_cast<uint32_t>(CCECPU) |                                           \
                      static_cast<uint32_t>(RUN_LOG_MASK)), "[%s][tid:%lu][%s] " fmt,                                \
                      &__func__[0], AicpuSchedule::GetTid(), AicpuSchedule::AICPUSD_MODULE, ##__VA_ARGS__);          \
        }                                                                                                            \
    } while (0)

#define aicpusd_run_warn(fmt, ...)                                                                                   \
    do {                                                                                                             \
        if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                               \
            dlog_warn(static_cast<int32_t>(static_cast<uint32_t>(CCECPU) |                                           \
                      static_cast<uint32_t>(RUN_LOG_MASK)), "[%s][tid:%llu][%s] " fmt,                               \
                      &__FUNCTION__[0], AicpuSchedule::GetTid(), AicpuSchedule::AICPUSD_MODULE, ##__VA_ARGS__);      \
        }                                                                                                            \
    } while (0)

#define UNUSED(expr) do { \
    (void)(expr); \
} while (false)

// 注意: 该宏第一项Condition是期望为真，否则将进行后续的返回和日志记录
#define AICPUSD_CHECK(condition, retValue, log, ...)                            \
    do {                                                                        \
        const bool cond = (condition);                                          \
        if (!cond) {                                                            \
            aicpusd_err(log, ##__VA_ARGS__);                                    \
            return (retValue);                                                  \
        }                                                                       \
    } while (false)

#endif