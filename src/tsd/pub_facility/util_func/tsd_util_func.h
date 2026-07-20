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
#include <vector>
#include "tsd/status.h"
#include "tsd_log.h"
#include "tsd_scope_guard.h"

#define TSD_CHECK_NO_RETURN(condition, log, ...) \
    do {                                         \
        const bool cond = (condition);           \
        if (!cond) {                             \
            TSD_ERROR(log, ##__VA_ARGS__);       \
        }                                        \
    } while (false)

#define TSD_CHECK_NO_RETURN_RUNINFO_LOG(condition, log, ...) \
    do {                                                     \
        const bool cond = (condition);                       \
        if (!cond) {                                         \
            TSD_RUN_INFO(log, ##__VA_ARGS__);                \
        }                                                    \
    } while (false)

#define TSD_CHECK_EQ_RETURN_RUNWARN_LOG(condition, errCode, log, ...) \
    do {                                                              \
        const bool cond = (condition);                                \
        if (cond) {                                                   \
            TSD_RUN_WARN(log, ##__VA_ARGS__);                         \
            return (errCode);                                         \
        }                                                             \
    } while (false)

#define TSD_CHECK(condition, retValue, log, ...) \
    do {                                         \
        const bool cond = (condition);           \
        if (!cond) {                             \
            TSD_ERROR(log, ##__VA_ARGS__);       \
            return (retValue);                   \
        }                                        \
    } while (false)

#define TSD_CHECK_NULLPTR_VOID(value) \
    do {                              \
        if ((value) == nullptr) {     \
            return;                   \
        }                             \
    } while (false)

#define TSD_CHECK_NULLPTR(value, errorCode, log, ...) \
    do {                                              \
        if ((value) == nullptr) {                     \
            TSD_ERROR(log, ##__VA_ARGS__);            \
            return (errorCode);                       \
        }                                             \
    } while (false)

#define TSD_BITMAP_GET(val, pos) (((val) >> (pos)) & 0x01U)

#define TSD_BITMAP_SET(val, pos) ((val) |= (1ULL << (pos)))

namespace tsd {

constexpr uint32_t MAX_DEVNUM_PER_OS = 64U; // 当前单OS上芯片最大数是64个

constexpr uint32_t TSDCLIENT_SUPPORT_NEW_ERRORCODE = 1U;

constexpr uint32_t MAX_DEVNUM_PER_HOST = 128U; // 当前host侧看到的是两个OS拼接后的芯片数8个,对应不同进程

constexpr int32_t TDT_RETURN_ERROR = -1;

constexpr uint64_t S_TO_US = 1000000UL;

constexpr uint64_t MS_TO_US = 1000UL;

constexpr uint64_t S_TO_MS = 1000UL;

constexpr uint32_t PER_OS_CHIP_NUM = 4U;

void Trim(std::string& str);

// 修副本中任意空白字符（含空格/制表符/换行/回车等）的首尾
void TrimWhitespace(std::string& str);

// 按字符 sep 切分，不跳过空串
std::vector<std::string> SplitByChar(const std::string& s, char sep);

// 两串完全为数字时按数值比较，否则字典序。返回 -1/0/1
int32_t CompareSegmentNumeric(const std::string& a, const std::string& b);

uint64_t CalFileSize(const std::string& filePath);

bool ValidateStr(const std::string& str, const std::string& mode);

bool IsFpgaEnv();

inline uint64_t GetCurrentTime()
{
    uint64_t ret = 0U;
    struct timeval tv;
    if (gettimeofday(&tv, nullptr) == 0) {
        ret = (static_cast<uint64_t>(tv.tv_sec) * S_TO_US) + static_cast<uint64_t>(tv.tv_usec);
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

void GetScheduleEnv(const char_t* const envName, std::string& envValue);

bool CheckRealPath(const std::string& inputPath);

bool CheckValidatePath(const std::string& path);

int32_t PackSystem(const char_t* const cmdLine);

std::string SafeStrerror();

uint32_t CalcUniqueVfId(const uint32_t deviceId, const uint32_t vfId);

bool TransStrToInt(const std::string& para, int32_t& value);

void RemoveOneFile(const std::string& filePath);

std::string CalFileSha256HashValue(const std::string& filePath);

bool IsCurrentVfMode(const uint32_t deviceId, const uint32_t vfId);

bool IsVfModeCheckedByDeviceId(const uint32_t deviceId);

bool IsDirEmpty(const std::string& dirPath);

bool GetFlagFromEnv(const char_t* const envStr, const char_t* const envValue);

// Locate the directory of the host-side HAL shared library (the .so that
// exports drvHdcSendFile) by inspecting the address of that symbol with
// dladdr(3).  Returns an empty string on failure.
std::string GetHostSoPath();
} // namespace tsd
#endif // TSD_PUB_FACILITY_UTIL_FUNC_TSD_UTIL_FUNC_H
