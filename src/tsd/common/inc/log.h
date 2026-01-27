/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef INC_TSD_COMMON_HID_INC_LOG_H
#define INC_TSD_COMMON_HID_INC_LOG_H

#include <mutex>
#include <queue>
#include <string>
#include "inc/weak_log.h"
#include "tsd/status.h"
#include "inc/error_code.h"
#include "mmpa/mmpa_api.h"

namespace tsd {
class TSDLog {
public:
    /**
     * @ingroup log
     * @brief 获取TSDLog指针
     */
    static TSDLog *GetInstance();

    /**
     * @ingroup TSDRefreshLevel
     * @brief return error log to client for debug
     */
    std::string GetErrorMsg();

    /**
     * @ingroup TSDRefreshLevel
     * @brief save last 10 error log for debug
     * @param [in]funcPointer : error log need to save
     * @param [in]filePath : error log need to save
     * @param [in]lineNumber : error log need to save
     * @param [in]format : error log need to save
     */
    void RestoreErrorMsg(const char_t * const funcPointer, const char_t * const filePath, const int32_t lineNumber,
                         const char_t * const format, ...);

protected:
    /**
     * @ingroup log
     * @brief TSDLog构造函数
     */
    TSDLog() = default;
    ~TSDLog() = default;

private:
    TSDLog(const TSDLog &) = delete;
    TSDLog(TSDLog &&) = delete;
    TSDLog &operator=(const TSDLog &) = delete;
    TSDLog &operator=(TSDLog &) = delete;
    TSDLog &operator=(TSDLog &&) = delete;

    std::mutex errorListMutex_;
    std::queue<std::string> errorList_;
};
} // namespace tsd

#define TSD_INFO(log, ...)                                                                                 \
    do {                                                                                                   \
        if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                     \
            dlog_info(static_cast<int32_t>(TDT), "[%s][tid:%llu] " log,                                    \
                      &__FUNCTION__[0U], mmGetTid(), ##__VA_ARGS__);                                       \
        }                                                                                                  \
    } while (false)

#ifdef TSD_HOST_LIB
#define TSD_ERROR(log, ...)                                                                                \
    do {                                                                                                   \
        if (&DlogRecord != nullptr) {                                                                      \
            dlog_error(static_cast<int32_t>(TDT), "[%s][tid:%llu] " log,                                   \
                       &__FUNCTION__[0U], mmGetTid(), ##__VA_ARGS__);                                      \
        }                                                                                                  \
    } while (false)
#else
#define TSD_ERROR(log, ...)                                                                                \
    do {                                                                                                   \
        ::tsd::TSDLog::GetInstance()->RestoreErrorMsg(&__FUNCTION__[0U], __FILE__, __LINE__,               \
                                                      (log), ##__VA_ARGS__);                               \
        if (&DlogRecord != nullptr) {                                                                      \
            dlog_error(static_cast<int32_t>(TDT), "[%s][tid:%llu] " log,                                   \
                       &__FUNCTION__[0U], mmGetTid(), ##__VA_ARGS__);                                      \
        }                                                                                                  \
    } while (false)
#endif

#define TSD_WARN(log, ...)                                                                                 \
    do {                                                                                                   \
        if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                     \
            dlog_warn(static_cast<int32_t>(TDT), "[%s][tid:%llu] " log,                                    \
                      &__FUNCTION__[0U], mmGetTid(), ##__VA_ARGS__);                                       \
        }                                                                                                  \
    } while (false)

#define TSD_DEBUG(log, ...)                                                                                \
    do {                                                                                                   \
        if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                     \
            dlog_debug(static_cast<int32_t>(TDT), "[%s][tid:%llu] " log,                                   \
                       &__FUNCTION__[0U], mmGetTid(), ##__VA_ARGS__);                                      \
        }                                                                                                  \
    } while (false)

#define TSD_REPORT_ERROR_CODE "E39999"
#define TSD_REPORT_INNER_ERROR(log, ...)                                                                   \
    do {                                                                                                   \
        REPORT_INNER_ERROR(TSD_REPORT_ERROR_CODE, (log), ##__VA_ARGS__);                                   \
    } while (false)

#define TSD_REPORT_CALL_ERROR(log, ...)                                                                    \
    do {                                                                                                   \
        REPORT_CALL_ERROR(TSD_REPORT_ERROR_CODE, (log), ##__VA_ARGS__);                                    \
    } while (false)

#define TSD_SYS_EVENT(log, ...)                                                                            \
    do {                                                                                                   \
        syslog(LOG_NOTICE, "[%s %d] " log,                                                                 \
                  &__FUNCTION__[0U], __LINE__, ##__VA_ARGS__);                                             \
    } while (false)

#define TSD_RUN_INFO(log, ...)                                                                             \
    do {                                                                                                   \
        if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                     \
            dlog_info(static_cast<int32_t>(static_cast<uint32_t>(TDT) |                                    \
                      static_cast<uint32_t>(RUN_LOG_MASK)),                                                \
                      "[%s][tid:%llu] " log, &__FUNCTION__[0U], mmGetTid(), ##__VA_ARGS__);                \
        }                                                                                                  \
    } while (false)
#define TSD_RUN_WARN(log, ...)                                                                             \
    do {                                                                                                   \
        if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                     \
            dlog_warn(static_cast<int32_t>(static_cast<uint32_t>(TDT) |                                    \
                      static_cast<uint32_t>(RUN_LOG_MASK)),                                                \
                      "[%s][tid:%llu] " log, &__FUNCTION__[0U], mmGetTid(), ##__VA_ARGS__);                \
        }                                                                                                  \
    } while (false)
#endif  // INC_TSD_COMMON_HID_INC_LOG_H
