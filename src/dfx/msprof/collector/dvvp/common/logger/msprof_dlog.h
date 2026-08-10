/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef MSPROF_DLOG_H
#define MSPROF_DLOG_H

#include <sys/syscall.h>
#include <unistd.h>
#include <cstring>
#include "slog.h"

#if (defined(linux) || defined(__linux__))
#include <syslog.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define MSPROF_MODULE_NAME PROFILING
#define FILENAME (strrchr("/" __FILE__, '/') + 1)
#ifdef OSAL

#define MSPROF_EVENT(format, ...)                                                                             \
    do {                                                                                                      \
        DlogRecord(MSPROF_MODULE_NAME, DLOG_EVENT, "[%s:%d]" format "\n", FILENAME, __LINE__, ##__VA_ARGS__); \
    } while (0)
#define MSPROF_LOGE(format, ...)                                                                              \
    do {                                                                                                      \
        DlogRecord(MSPROF_MODULE_NAME, DLOG_ERROR, "[%s:%d]" format "\n", FILENAME, __LINE__, ##__VA_ARGS__); \
    } while (0)
#define MSPROF_LOGW(format, ...)                                                                             \
    do {                                                                                                     \
        DlogRecord(MSPROF_MODULE_NAME, DLOG_WARN, "[%s:%d]" format "\n", FILENAME, __LINE__, ##__VA_ARGS__); \
    } while (0)
#define MSPROF_LOGI(format, ...)                                                                             \
    do {                                                                                                     \
        DlogRecord(MSPROF_MODULE_NAME, DLOG_INFO, "[%s:%d]" format "\n", FILENAME, __LINE__, ##__VA_ARGS__); \
    } while (0)
#define MSPROF_LOGD(format, ...)                                                                              \
    do {                                                                                                      \
        DlogRecord(MSPROF_MODULE_NAME, DLOG_DEBUG, "[%s:%d]" format "\n", FILENAME, __LINE__, ##__VA_ARGS__); \
    } while (0)

#else

#define MSPROF_LOGD(format, ...)                                                                       \
    do {                                                                                               \
        dlog_debug(MSPROF_MODULE_NAME, " (tid:%ld) " format "\n", syscall(SYS_gettid), ##__VA_ARGS__); \
    } while (0)
#define MSPROF_LOGI(format, ...)                                                                      \
    do {                                                                                              \
        dlog_info(MSPROF_MODULE_NAME, " (tid:%ld) " format "\n", syscall(SYS_gettid), ##__VA_ARGS__); \
    } while (0)
#define MSPROF_LOGW(format, ...)                                                                      \
    do {                                                                                              \
        dlog_warn(MSPROF_MODULE_NAME, " (tid:%ld) " format "\n", syscall(SYS_gettid), ##__VA_ARGS__); \
    } while (0)
#define MSPROF_LOGE(format, ...)                                                                       \
    do {                                                                                               \
        dlog_error(MSPROF_MODULE_NAME, " (tid:%ld) " format "\n", syscall(SYS_gettid), ##__VA_ARGS__); \
    } while (0)
#define MSPROF_EVENT(format, ...)                                                                                      \
    do {                                                                                                               \
        dlog_info(                                                                                                     \
            static_cast<int32_t>(static_cast<uint32_t>(MSPROF_MODULE_NAME) | RUN_LOG_MASK), " (tid:%ld) " format "\n", \
            syscall(SYS_gettid), ##__VA_ARGS__);                                                                       \
    } while (0)

#endif

#ifdef __cplusplus
} // extern "C"

#include <cstdint>

// Map a slog module id (see src/dfx/log/inc/toolchain/log_types.h) to a readable name.
// Only the modules that flow through the profiling control-callback path are named; the
// numeric id is kept by callers so logs stay greppable. Unknown ids return "UNKNOWN".
inline const char* ProfGetModuleName(uint32_t moduleId)
{
    switch (moduleId) {
        case 3:
            return "HCCL";      // HCCL
        case 4:
            return "FMK";       // Adapter
        case 6:
            return "DVPP";      // DVPP
        case 7:
            return "RUNTIME";   // Runtime
        case 23:
            return "KERNEL";    // Kernel
        case 25:
            return "CCECPU";    // aicpu schedule
        case 31:
            return "PROFILING"; // Profiling
        case 36:
            return "AICPU";     // AICPU
        case 45:
            return "GE";        // Fmk
        case 48:
            return "ASCENDCL";  // AscendCL
        default:
            return "UNKNOWN";
    }
}

// Map a MsprofCommandHandleType (see pkg_inc/profiling/aprof_pub.h) to a readable
// name. Out-of-range values return "UNKNOWN".
inline const char* ProfGetCommandTypeName(uint32_t type)
{
    switch (type) {
        case 0:
            return "INIT";
        case 1:
            return "START";
        case 2:
            return "STOP";
        case 3:
            return "FINALIZE";
        case 4:
            return "MODEL_SUBSCRIBE";
        case 5:
            return "MODEL_UNSUBSCRIBE";
        default:
            return "UNKNOWN";
    }
}
#endif // __cplusplus

#endif // MSPROF_LOG_H
