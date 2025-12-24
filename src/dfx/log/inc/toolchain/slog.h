/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef D_SYSLOG_H_
#define D_SYSLOG_H_

#include "dlog_pub.h"
static const int32_t TMP_LOG = 0;

#ifdef __cplusplus
#ifndef LOG_CPP
extern "C" {
#endif
#endif // __cplusplus

/**
 * @ingroup slog
 *
 * log level id
 */
#define DLOG_EVENT 0x10     // event log print level id

#define LOG_SAVE_MODE_DEF   (0x0U)          // default
#define LOG_SAVE_MODE_UNI   (0xFE756E69U)   // unify save mode
#define LOG_SAVE_MODE_SEP   (0xFE736570U)   // separate save mode

/**
 * @ingroup slog
 *
 * module id
 * if a module needs to be added, add the module at the end and before INVLID_MOUDLE_ID
 */
#define ALL_MODULE  (0x0000FFFFU)

/**
 * @ingroup slog
 * @brief External log interface, which called by modules
 */
LOG_FUNC_VISIBILITY void dlog_init(void);

/**
 * @ingroup slog
 * @brief dlog_event: print event log
 *
 * @param [in]moduleId: module id, eg: CCE
 * @param [in]fmt: log content
 */
#define dlog_event(moduleId, fmt, ...)                                          \
    do {                                                                          \
        DlogRecord(moduleId, DLOG_EVENT, "[%s:%d]" fmt, __FILENAME__, __LINE__, ##__VA_ARGS__); \
    } while (TMP_LOG != 0)

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
 * @brief DlogGetlevelForC: get module debug loglevel and enableEvent
 *
 * @param [in]moduleId: moudule id(see slog.h, eg: CCE), others: invalid
 * @param [out]enableEvent: 1: enable; 0: disable
 * @return: module level(0: debug, 1: info, 2: warning, 3: error, 4: null output)
 */
LOG_FUNC_VISIBILITY int DlogGetlevelForC(int moduleId, int *enableEvent);

/**
 * @ingroup slog
 * @brief DlogSetlevelForC: set module loglevel and enableEvent
 *
 * @param [in]moduleId: moudule id(see slog.h, eg: CCE), -1: all modules, others: invalid
 * @param [in]level: log level(0: debug, 1: info, 2: warning, 3: error, 4: null output)
 * @param [in]enableEvent: 1: enable; 0: disable, others:invalid
 * @return: 0: SUCCEED, others: FAILED
 */
LOG_FUNC_VISIBILITY int32_t DlogSetlevelForC(int32_t moduleId, int32_t level, int32_t enableEvent);

/**
 * @ingroup slog
 * @brief CheckLogLevelForC: check module level enable or not
 * users no need to call it because all dlog interface(include inner interface) has already called
 *
 * @param [in]moduleId: module id, eg: CCE
 * @param [in]logLevel: eg: DLOG_EVENT/DLOG_ERROR/DLOG_WARN/DLOG_INFO/DLOG_DEBUG
 * @return: 1:enable, 0:disable
 */
LOG_FUNC_VISIBILITY int32_t CheckLogLevelForC(int32_t moduleId, int32_t logLevel);

/**
 * @ingroup slog
 * @brief DlogSetAttrForC: set log attr, default pid is 0, default device id is 0, default process type is APPLICATION
 * @param [in]logAttrInfo: attr info, include pid(must be larger than 0), process type and device id(chip ID)
 * @return: 0: SUCCEED, others: FAILED
 */
LOG_FUNC_VISIBILITY int32_t DlogSetAttrForC(LogAttr logAttrInfo);

/**
 * @ingroup slog
 * @brief DlogForC: print log, need caller to specify level
 * call CheckLogLevelForC in advance to optimize performance, call interface with fmt input take time
 *
 * @param [in]moduleId: module id, eg: CCE
 * @param [in]level(0: debug, 1: info, 2: warning, 3: error, 16: event)
 * @param [in]fmt: log content
 */
#define DlogForC(moduleId, level, fmt, ...)                                                 \
    do {                                                                                  \
        if (CheckLogLevelForC(moduleId, level) == 1) {                                           \
            DlogRecordForC(moduleId, level, "[%s:%d]" fmt, __FILENAME__, __LINE__, ##__VA_ARGS__);   \
        }                                                                                  \
    } while (TMP_LOG != 0)

/**
 * @ingroup slog
 * @brief DlogSubForC: print log, need caller to specify level and submodule
 * call CheckLogLevelForC in advance to optimize performance, call interface with fmt input take time
 *
 * @param [in]moduleId: module id, eg: CCE
 * @param [in]submodule: eg: engine
 * @param [in]level(0: debug, 1: info, 2: warning, 3: error, 16: event)
 * @param [in]fmt: log content
 */
#define DlogSubForC(moduleId, submodule, level, fmt, ...)                                                   \
    do {                                                                                                  \
        if (CheckLogLevelForC(moduleId, level) == 1) {                                                           \
            DlogRecordForC(moduleId, level, "[%s:%d][%s]" fmt, __FILENAME__, __LINE__, submodule, ##__VA_ARGS__);    \
        }                                                                                                   \
    } while (TMP_LOG != 0)

/**
 * @ingroup slog
 * @brief DlogFlushForC: flush log buffer to file
 */
LOG_FUNC_VISIBILITY void DlogFlushForC(void);

// log interface
LOG_FUNC_VISIBILITY void DlogRecordForC(int32_t moduleId, int32_t level, const char *fmt, ...) __attribute((weak));

#ifdef __cplusplus
}
#endif
#endif // LOG_CPP
#endif // D_SYSLOG_H_
