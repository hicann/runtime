/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "sys_utils.h"
#include <map>
#include <ctime>
#include <chrono>
#include <sstream>
#include <iomanip>
#include "adx_log.h"

namespace Adx {
namespace {
constexpr uint64_t SEC_TO_USEC = 1000000UL;
constexpr uint64_t SEC_TO_MSEC = 1000UL;
constexpr uint32_t MILLI_S_FORMAT_LEN = 3;
}  // namespace

std::string SysUtils::GetCurrentWorkDir()
{
    char currentPath[MMPA_MAX_PATH] = {0};
    return mmGetCwd(currentPath, MMPA_MAX_PATH) == EN_OK ? currentPath : "";
}

std::string SysUtils::HandleEnv(const char* env)
{
    if (env == nullptr) {
        return "";
    }
    size_t lenOfRet = strlen(env);
    size_t envLen = lenOfRet;
    if (lenOfRet < MMPA_MEM_MAX_LEN - 1) {
        envLen += 1;
    }

    if ((envLen != MMPA_ZERO) && (MMPA_MAX_PATH - 1 < envLen)) {
        return "";
    }
    char envValue[MMPA_MAX_PATH] = {0};
    IDE_CTRL_VALUE_FAILED(memcpy_s(envValue, MMPA_MAX_PATH - 1, env, envLen) == EN_OK, return "",
        "Failed to copy environment data %s.", env);

    return envValue;
}

uint64_t SysUtils::GetTimestamp()
{
    uint64_t time = 0U;
    mmTimeval tv;
    if (mmGetTimeOfDay(&tv, nullptr) == 0) {
        time = (static_cast<uint64_t>(tv.tv_sec) * SEC_TO_USEC) + static_cast<uint64_t>(tv.tv_usec);
    }
    return time;
}

std::string SysUtils::GetCurrentTime()
{
    const std::time_t now = std::time(nullptr);
    const std::tm *const ptm = std::localtime(&now);
    if (ptm == nullptr) {
        return "";
    }

    constexpr int32_t timeBufferLen = 32;
    char buffer[timeBufferLen + 1] = {0};
    (void)std::strftime(&buffer[0], static_cast<size_t>(timeBufferLen), "%Y%m%d%H%M%S", ptm);
    return std::string(buffer);
}

std::string SysUtils::GetCurrentTimeWithMillisecond()
{
    auto now = std::chrono::system_clock::now();
    std::time_t nowClock = std::chrono::system_clock::to_time_t(now);
    auto duration = now.time_since_epoch();
    auto millis = std::chrono::duration_cast<std::chrono::milliseconds>(duration).count() % SEC_TO_MSEC;

    std::tm localTime{};
    if (localtime_r(&nowClock, &localTime) == nullptr) {
        return DEFAULT_MILLISECOND_TIME;
    }

    std::ostringstream oss;
    oss << std::put_time(&localTime, "%Y%m%d%H%M%S");
    oss << std::setfill('0') << std::setw(MILLI_S_FORMAT_LEN) << millis;

    return oss.str();
}

std::string SysUtils::GetPid()
{
    const auto tid = mmGetPid();
    if (tid != EN_ERROR) {
        return std::to_string(tid);
    }
    return "";
}
}  // namespace Adx