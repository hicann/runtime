/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DLOG_PUB_H_
#define DLOG_PUB_H_

#include <string.h>
#include <stdint.h>
#include <stdarg.h>
#include "log_types.h"

#ifdef __cplusplus
#ifndef LOG_CPP
extern "C" {
#endif
#endif // __cplusplus

#define __FILENAME__ (strrchr(__FILE__, '/') ? strrchr(__FILE__, '/') + 1 : __FILE__)

/**
 * @brief           get module debug loglevel and enableEvent
 * @param [in]      moduleId       moudule id(see log_types.h, eg: CCE), others: invalid
 * @param [out]     enableEvent    1: enable; 0: disable
 * @return          module level   0: debug, 1: info, 2: warning, 3: error, 4: null output
 */
LOG_FUNC_VISIBILITY int32_t dlog_getlevel(int32_t moduleId, int32_t *enableEvent);

/**
 * @brief           set module loglevel and enableEvent
 * @param [in]      moduleId       moudule id(see log_types.h, eg: CCE), -1: all modules, others: invalid
 * @param [in]      level          log level, eg: DLOG_ERROR/DLOG_WARN/DLOG_INFO/DLOG_DEBUG
 * @param [in]      enableEvent    1: enable; 0: disable, others:invalid
 * @return          0: SUCCEED, others: FAILED
 */
LOG_FUNC_VISIBILITY int32_t dlog_setlevel(int32_t moduleId, int32_t level, int32_t enableEvent);

/**
 * @brief           check module level enable or not
 * @param [in]      moduleId       module id, eg: CCE
 * @param [in]      logLevel       log level, eg: DLOG_ERROR/DLOG_WARN/DLOG_INFO/DLOG_DEBUG
 * @return          1:enable, 0:disable
 */
LOG_FUNC_VISIBILITY int32_t CheckLogLevel(int32_t moduleId, int32_t logLevel);

/**
 * @brief           set log attr, default pid is 0, default device id is 0, default process type is APPLICATION
 * @param [in]      logAttrInfo    attr info, include pid(must be larger than 0), process type and device id(chip ID)
 * @return          0: SUCCEED, others: FAILED
 */
LOG_FUNC_VISIBILITY int32_t DlogSetAttr(LogAttr logAttrInfo);

/**
 * @brief           print log, need va_list variable, exec CheckLogLevel() before call this function
 * @param[in]       moduleId      module id, eg: CCE
 * @param[in]       level         log level, eg: DLOG_ERROR/DLOG_WARN/DLOG_INFO/DLOG_DEBUG
 * @param[in]       fmt           log content
 * @param[in]       list          variable list of log content
 * @return          NA
 */
LOG_FUNC_VISIBILITY void DlogVaList(int32_t moduleId, int32_t level, const char *fmt, va_list list);

/**
 * @brief           flush log buffer to file
 * @return          NA
 */
LOG_FUNC_VISIBILITY void DlogFlush(void);

/**
 * @brief           print error log
 * @param [in]      moduleId      module id, eg: CCE
 * @param [in]      fmt           log content
 * @return          NA
 */
#define dlog_error(moduleId, fmt, ...)                                          \
    do {                                                                          \
        DlogRecord(moduleId, DLOG_ERROR, "[%s:%d]" fmt, __FILENAME__, __LINE__, ##__VA_ARGS__); \
    } while (0)

/**
 * @brief           print warning log
 * call CheckLogLevel in advance to optimize performance, call interface with fmt input take time
 * @param [in]      moduleId      module id, eg: CCE
 * @param [in]      fmt           log content
 * @return          NA
 */
#define dlog_warn(moduleId, fmt, ...)                                               \
    do {                                                                              \
        if (CheckLogLevel(moduleId, DLOG_WARN) == 1) {                                   \
            DlogRecord(moduleId, DLOG_WARN, "[%s:%d]" fmt, __FILENAME__, __LINE__, ##__VA_ARGS__);  \
        }                                                                               \
    } while (0)

/**
 * @brief           print info log
 * call CheckLogLevel in advance to optimize performance, call interface with fmt input take time
 * @param [in]      moduleId      module id, eg: CCE
 * @param [in]      fmt           log content
 * @return          NA
 */
#define dlog_info(moduleId, fmt, ...)                                               \
    do {                                                                              \
        if (CheckLogLevel(moduleId, DLOG_INFO) == 1) {                                   \
            DlogRecord(moduleId, DLOG_INFO, "[%s:%d]" fmt, __FILENAME__, __LINE__, ##__VA_ARGS__);  \
        }                                                                               \
    } while (0)

/**
 * @brief           print debug log
 * call CheckLogLevel in advance to optimize performance, call interface with fmt input take time
 * @param [in]      moduleId      module id, eg: CCE
 * @param [in]      fmt           log content
 * @return          NA
 */
#define dlog_debug(moduleId, fmt, ...)                                              \
    do {                                                                              \
        if (CheckLogLevel(moduleId, DLOG_DEBUG) == 1) {                                  \
            DlogRecord(moduleId, DLOG_DEBUG, "[%s:%d]" fmt, __FILENAME__, __LINE__, ##__VA_ARGS__); \
        }                                                                               \
    } while (0)

/**
 * @brief           print log, need caller to specify level
 * call CheckLogLevel in advance to optimize performance, call interface with fmt input take time
 * @param [in]      moduleId      module id, eg: CCE
 * @param [in]      level         log level, eg: DLOG_ERROR/DLOG_WARN/DLOG_INFO/DLOG_DEBUG
 * @param [in]      fmt           log content
 * @return          NA
 */
#define Dlog(moduleId, level, fmt, ...)                                                 \
    do {                                                                                  \
        if (CheckLogLevel(moduleId, level) == 1) {                                           \
            DlogRecord(moduleId, level, "[%s:%d]" fmt, __FILENAME__, __LINE__, ##__VA_ARGS__);   \
        }                                                                                  \
    } while (0)

/**
 * @brief           print log, need caller to specify level and submodule
 * call CheckLogLevel in advance to optimize performance, call interface with fmt input take time
 * @param [in]      moduleId      module id, eg: CCE
 * @param [in]      submodule     eg: engine
 * @param [in]      level         log level, eg: DLOG_ERROR/DLOG_WARN/DLOG_INFO/DLOG_DEBUG
 * @param [in]      fmt           log content
 * @return          NA
 */
#define DlogSub(moduleId, submodule, level, fmt, ...)                                                   \
    do {                                                                                                  \
        if (CheckLogLevel(moduleId, level) == 1) {                                                           \
            DlogRecord(moduleId, level, "[%s:%d][%s]" fmt, __FILENAME__, __LINE__, submodule, ##__VA_ARGS__);    \
        }                                                                                                   \
    } while (0)

/**
 * @brief           record log
 * @param [in]      moduleId   module id, eg: SLOG
 * @param [in]      level      log level, eg: DLOG_ERROR/DLOG_WARN/DLOG_INFO/DLOG_DEBUG
 * @param [in]      fmt        log content
 * @return:         NA
 */
LOG_FUNC_VISIBILITY void DlogRecord(int32_t moduleId, int32_t level, const char *fmt, ...) __attribute((weak));

#ifdef __cplusplus
#ifndef LOG_CPP
}
#endif // LOG_CPP
#endif // __cplusplus

#endif // DLOG_PUB_H_