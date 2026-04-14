/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_PUB_FACILITY_TSDLOG_LOG_H
#define TSD_PUB_FACILITY_TSDLOG_LOG_H

#include <mutex>
#include <queue>
#include <string>
#include "inc/weak_log.h"
#include "tsd/status.h"
#include "inc/error_code.h"
#include "mmpa/mmpa_api.h"

#define TSD_INFO(log, ...)                                                                                 \
    do {                                                                                                   \
        if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                     \
            dlog_info(static_cast<int32_t>(TDT), "[%s][tid:%llu] " log,                                    \
                      &__FUNCTION__[0U], mmGetTid(), ##__VA_ARGS__);                                       \
        }                                                                                                  \
    } while (false)

#define TSD_ERROR(log, ...)                                                                                \
    do {                                                                                                   \
        if (&DlogRecord != nullptr) {                                                                      \
            dlog_error(static_cast<int32_t>(TDT), "[%s][tid:%llu] " log,                                   \
                       &__FUNCTION__[0U], mmGetTid(), ##__VA_ARGS__);                                      \
        }                                                                                                  \
    } while (false)


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
#endif  // TSD_PUB_FACILITY_TSDLOG_LOG_H
