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

#include <unistd.h>
#include <sys/syscall.h>
#include "aicpusd_weak_log.h"
#include "ascend_hal.h"

namespace AicpuSchedule {
inline const uint64_t GetTid()
{
    thread_local static const uint64_t tid = static_cast<uint64_t>(syscall(__NR_gettid));
    return tid;
}

constexpr int32_t INNER_ERROR_BASE = 500000;

// 21001 ~ 21200: error codes for hwts task execution
// 21201 ~: inner error code
using StatusCode = int32_t;
constexpr int32_t AICPU_SCHEDULE_OK = 0;
constexpr int32_t AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID = 21001;
constexpr int32_t AICPU_SCHEDULE_ERROR_DUMP_FAILED = 21002;
constexpr int32_t AICPU_SCHEDULE_ERROR_FROM_DRV =  21003;
constexpr int32_t AICPU_SCHEDULE_ERROR_TOOL_ERR = 21004;
constexpr int32_t AICPU_SCHEDULE_ERROR_NOT_FOUND_LOGICAL_TASK = 21005;
constexpr int32_t AICPU_SCHEDULE_ERROR_TASK_EXECUTE_FAILED = 21006;
constexpr int32_t AICPU_SCHEDULE_ERROR_TASK_EXECUTE_TIMEOUT = 21007;
constexpr int32_t AICPU_SCHEDULE_ERROR_INNER_ERROR = 21008;
// error code for overflow
constexpr int32_t AICPU_SCHEDULE_ERROR_UNDERFLOW = 21010;
constexpr int32_t AICPU_SCHEDULE_ERROR_OVERFLOW = 21011;
constexpr int32_t AICPU_SCHEDULE_ERROR_DIVISIONZERO = 21012;
// error code for model
constexpr int32_t AICPU_SCHEDULE_ERROR_IN_WORKING = 21100;
constexpr int32_t AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND = 21101;
constexpr int32_t AICPU_SCHEDULE_ERROR_STREAM_NOT_FOUND = 21102;
constexpr int32_t AICPU_SCHEDULE_ERROR_MODEL_STATUS_NOT_ALLOW_OPERATE = 21103;
constexpr int32_t AICPU_SCHEDULE_ERROR_MODEL_EXIT_ERR = 21104;
constexpr int32_t AICPU_SCHEDULE_ERROR_NOT_SUPPORT = 21105;
constexpr int32_t AICPU_SCHEDULE_ERROR_MODEL_EXECUTE_FAILED = 21106;
constexpr int32_t AICPU_SCHEDULE_ERROR_TSCH_OTHER_ERROR = 21107;
constexpr int32_t AICPU_SCHEDULE_ERROR_DISCARD_DATA = 21108;
// reserved inner error
constexpr int32_t AICPU_SCHEDULE_ERROR_RESERVED = 21200;

// the following error codes are uniformly normalized to AICPU_SCHEDULE_ERROR_INNER_ERROR
constexpr int32_t AICPU_SCHEDULE_ERROR_NOT_FOUND_CMD_TYPE = 21201;
constexpr int32_t AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT = 21202;
constexpr int32_t AICPU_SCHEDULE_ERROR_INIT_CP_FAILED = 21203;
constexpr int32_t AICPU_SCHEDULE_ERROR_REPEART_INIT = 21204;
constexpr int32_t AICPU_SCHEDULE_ERROR_INIT_FAILED = 21205;
constexpr int32_t AICPU_SCHEDULE_ERROR_DRV_ERR = 21206;
constexpr int32_t AICPU_SCHEDULE_ERROR_MALLOC_MEM_FAIL_THROUGH_DRV = 21207;
constexpr int32_t AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR = 21208;
constexpr int32_t AICPU_SCHEDULE_ERROR_INVAILD_EVENT_SUBMIT = 21209;
constexpr int32_t AICPU_SCHEDULE_ERROR_UNKNOW_AICPU_EVENT = 21210;
constexpr int32_t AICPU_SCHEDULE_ERROR_COMMON_ERROR = 21211;
constexpr int32_t AICPU_SCHEDULE_ERROR_NOT_FIND_KERNEL_ERROR = 21212;
constexpr int32_t AICPU_SCHEDULE_ERROR_LOAD_CONFIG_JSON_FILE_ERROR = 21213;
constexpr int32_t AICPU_SCHEDULE_ERROR_CGROUP_FAILED = 21214;
constexpr int32_t AICPU_SCHEDULE_ERROR_QUEUE_FULL = 21215;
constexpr int32_t AICPU_SCHEDULE_ERROR_MODEL_UNLOAD = 21216;
constexpr int32_t AICPU_SCHEDULE_ERROR_NOT_FOUND_VERSION = 21217;
constexpr int32_t AICPU_SCHEDULE_ERROR_INVALID_MAGIC_NUM = 21218;
constexpr int32_t AICPU_SCHEDULE_ERROR_NOT_FOUND_FUNCTION = 21219;


// error code for queue scheduler process
constexpr int32_t AICPU_SCHEDULE_CALL_DRIVER_ERROR = 21300;
constexpr int32_t AICPU_SCHEDULE_ERROR_GRANT_QUEUE_FAILED = 21301;
constexpr int32_t AICPU_SCHEDULE_ERROR_SLAVE_GRP_INVALID = 21302;
constexpr int32_t AICPU_SCHEDULE_ERROR_MULTI_GRP_ERROR = 21303;
constexpr int32_t AICPU_SCHEDULE_ERROR_GRP_AUTH_ERROR = 21304;
constexpr int32_t AICPU_SCHEDULE_ERROR_NOT_FOUND_QUEUE_SUB_EVENT_ID = 21305;
constexpr int32_t AICPU_SCHEDULE_ERROR_CREATE_CALLBACK_FAILED = 21306;
constexpr int32_t AICPU_SCHEDULE_ERROR_ADD_CALLBACK_FAILED = 21307;
constexpr int32_t AICPU_SCHEDULE_ERROR_GET_CALLBACK_FAILED = 21308;
constexpr int32_t AICPU_SCHEDULE_ERROR_REPEATED_BIND_QUEUE_INIT = 21309;
constexpr int32_t AICPU_SCHEDULE_ERROR_BIND_QUEUE_INIT_RET_FAILED = 21310;
constexpr int32_t AICPU_SCHEDULE_ERROR_ROUTE_NUM_IS_ZERO = 21311;
constexpr int32_t AICPU_SCHEDULE_ERROR_CP_QS_PIPELINE_NOT_INIT = 21312;
constexpr int32_t AICPU_SCHEDULE_ERROR_CALL_QS_BIND_FAILED = 21313;
constexpr int32_t AICPU_SCHEDULE_ERROR_TRANS_MODELINFO_FAILED = 21314;
constexpr int32_t AICPU_SCHEDULE_ERROR_SET_PRIORITY_FAILED = 21315;

// error code for mem info process
constexpr int32_t AICPU_SCHEDULE_ERROR_READ_JSON_FAILED = 21400;
constexpr int32_t AICPU_SCHEDULE_ERROR_GET_PATH_FAILED = 21401;
constexpr int32_t AICPU_SCHEDULE_ERROR_GET_APP_NAME_FAILED = 21402;
constexpr int32_t AICPU_SCHEDULE_ERROR_GET_RUN_MODE_FAILED = 21403;

// error code for hccl
constexpr int32_t AICPU_SCHEDULE_ERROR_CALL_HCCL = 21500;
}

#ifdef ONLY_ERROR

#define aicpusd_err(fmt, ...) \
    if (&DlogRecord != nullptr) {    \
        dlog_error(static_cast<int32_t>(CCECPU), "[%s][tid:%llu]" fmt, &__FUNCTION__[0], \
                   AicpuSchedule::GetTid(), ##__VA_ARGS__);   \
    }

#define aicpusd_warn(fmt, ...)
#define aicpusd_info(fmt, ...)
#define aicpusd_debug(fmt, ...)
#define aicpusd_memory_log(fmt, ...)
#define aicpusd_run_info(fmt, ...)
#define aicpusd_run_warn(fmt, ...)

#else
#define aicpusd_err(fmt, ...)   \
    if (&DlogRecord != nullptr) {    \
        dlog_error(static_cast<int32_t>(CCECPU), "[%s][tid:%llu] " fmt, \
                   &__FUNCTION__[0], AicpuSchedule::GetTid(), ##__VA_ARGS__); \
    }

#define aicpusd_warn(fmt, ...)  \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {  \
        dlog_warn(static_cast<int32_t>(CCECPU), "[%s][tid:%llu] " fmt, \
                  &__FUNCTION__[0], AicpuSchedule::GetTid(), ##__VA_ARGS__);  \
    }

#define aicpusd_info(fmt, ...)  \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {  \
        dlog_info(static_cast<int32_t>(CCECPU), "[%s][tid:%llu] " fmt, \
                  &__FUNCTION__[0], AicpuSchedule::GetTid(), ##__VA_ARGS__);  \
    }

#define aicpusd_debug(fmt, ...) \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {  \
        dlog_debug(static_cast<int32_t>(CCECPU), "[%s][tid:%llu] " fmt, \
                   &__FUNCTION__[0], AicpuSchedule::GetTid(), ##__VA_ARGS__);  \
    }

#define aicpusd_memory_log(fmt, ...)  \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {  \
        dlog_info(static_cast<int32_t>(CCECPU), "[%s][tid:%llu] " fmt, \
                  &__FUNCTION__[0], AicpuSchedule::GetTid(), ##__VA_ARGS__);  \
    }

#define aicpusd_run_info(fmt, ...)  \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {  \
        dlog_info(static_cast<int32_t>(static_cast<uint32_t>(CCECPU) |  \
                  static_cast<uint32_t>(RUN_LOG_MASK)), \
                  "[%s][tid:%llu] " fmt, &__FUNCTION__[0], AicpuSchedule::GetTid(), ##__VA_ARGS__);  \
    }

#define aicpusd_run_warn(fmt, ...)  \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {  \
        dlog_warn(static_cast<int32_t>(static_cast<uint32_t>(CCECPU) |  \
                  static_cast<uint32_t>(RUN_LOG_MASK)), \
                  "[%s][tid:%llu] " fmt, &__FUNCTION__[0], AicpuSchedule::GetTid(), ##__VA_ARGS__);  \
    }
#endif

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
