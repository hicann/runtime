/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_PUB_FACILITY_UTIL_FUNC_TSD_UTIL_FUNC_H
#define TSD_PUB_FACILITY_UTIL_FUNC_TSD_UTIL_FUNC_H

#include <memory>
#include <chrono>
#include <string>
#include "tsd/status.h"
#include "log.h"
#include "tsd_scope_guard.h"

#define TSD_CHECK_NO_RETURN(condition, log, ...)                                \
    do {                                                                        \
        const bool cond = (condition);                                          \
        if (!cond) {                                                            \
            TSD_ERROR(log, ##__VA_ARGS__);                                      \
        }                                                                       \
    } while (false)

#define TSD_CHECK_NO_RETURN_RUNINFO_LOG(condition, log, ...)                    \
    do {                                                                        \
        const bool cond = (condition);                                          \
        if (!cond) {                                                            \
            TSD_RUN_INFO(log, ##__VA_ARGS__);                                   \
        }                                                                       \
    } while (false)

#define TSD_CHECK_EQ_RETURN_RUNWARN_LOG(condition, errCode, log, ...)           \
    do {                                                                        \
        const bool cond = (condition);                                          \
        if (cond) {                                                             \
            TSD_RUN_WARN(log, ##__VA_ARGS__);                                   \
            return (errCode);                                                   \
        }                                                                       \
    } while (false)

#define TSD_CHECK(condition, retValue, log, ...)                                \
    do {                                                                        \
        const bool cond = (condition);                                          \
        if (!cond) {                                                            \
            TSD_ERROR(log, ##__VA_ARGS__);                                      \
            return (retValue);                                                  \
        }                                                                       \
    } while (false)

#define TSD_CHECK_NULLPTR_VOID(value)                                           \
    do {                                                                        \
        if ((value) == nullptr) {                                               \
            return;                                                             \
        }                                                                       \
    } while (false)

#define TSD_CHECK_NULLPTR(value, errorCode, log, ...)                           \
    do {                                                                        \
        if ((value) == nullptr) {                                               \
            TSD_ERROR(log, ##__VA_ARGS__);                                      \
            return (errorCode);                                                 \
        }                                                                       \
    } while (false)


#define TSD_BITMAP_GET(val, pos) (((val) >> (pos)) & 0x01U)

#define TSD_BITMAP_SET(val, pos) ((val) |= (1ULL << (pos)))

namespace tsd {

    constexpr uint32_t TSD_SUPPORT_HS_AISERVER_FEATURE_BIT = 0U;

    constexpr uint32_t TSD_SUPPORT_BUILTIN_UDF_BIT = 1U;

    constexpr uint32_t TSD_SUPPORT_CLOSE_LIST_BIT = 2U;

    constexpr uint32_t TSD_SUPPORT_ADPROF_BIT = 3U;

    constexpr uint32_t TSD_SUPPORT_EXTEND_PKG = 4U;

    constexpr uint32_t TSD_SUPPORT_MUL_HCCP = 5U;

    constexpr uint32_t TSD_SUPPORT_DRIVER_EXTEND_BIT = 6U;

    constexpr uint32_t TSD_SUPPORT_ASCENDCPP_PKG = 7U;

    constexpr uint32_t TSD_SUPPORT_COMMON_SINK_PKG_CONFIG = 8U;

    constexpr uint32_t MAX_DEVNUM_PER_OS = 64U;  // 当前单OS上芯片最大数是64个

    constexpr uint32_t TSDCLIENT_SUPPORT_NEW_ERRORCODE= 1U;

    constexpr uint32_t MAX_DEVNUM_PER_HOST = 128U;  // 当前host侧看到的是两个OS拼接后的芯片数8个,对应不同进程

    constexpr int32_t TDT_RETURN_ERROR = -1;

    constexpr uint64_t S_TO_NS = 1000000UL;

    constexpr uint64_t MS_TO_NS = 1000UL;

    constexpr uint64_t S_TO_MS = 1000UL;

    void Trim(std::string& str);

    uint64_t CalFileSize(const std::string &filePath);

    bool ValidateStr(const std::string &str, const std::string &mode);

    bool IsFpgaEnv();

    inline uint64_t GetCurrentTime()
    {
        uint64_t ret = 0U;
        struct timeval tv;
        if (gettimeofday(&tv, nullptr) == 0) {
            ret = (static_cast<uint64_t>(tv.tv_sec) * S_TO_NS) + static_cast<uint64_t>(tv.tv_usec);
        }

        return ret;
    }

    inline bool IsHeterogeneousProduct()
    {
#ifdef TSD_HELPER
        return true;
#else
        return false;
#endif
    }

    void GetScheduleEnv(const char_t * const envName, std::string &envValue);

    bool CheckRealPath(const std::string &inputPath);

    bool CheckValidatePath(const std::string &path);

    int32_t PackSystem(const char_t * const cmdLine);

    std::string SafeStrerror();

    uint32_t CalcUniqueVfId(const uint32_t deviceId, const uint32_t vfId);

    bool TransStrToInt(const std::string &para, int32_t &value);

    void RemoveOneFile(const std::string &filePath);

    std::string CalFileSha256HashValue(const std::string &filePath);

    bool IsCurrentVfMode(const uint32_t deviceId, const uint32_t vfId);

    bool IsVfModeCheckedByDeviceId(const uint32_t deviceId);

    bool IsDirEmpty(const std::string &dirPath);

    bool GetFlagFromEnv(const char_t * const envStr, const char_t * const envValue);
}
#endif  // TSD_PUB_FACILITY_UTIL_FUNC_TSD_UTIL_FUNC_H
