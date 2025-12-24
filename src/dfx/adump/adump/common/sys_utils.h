/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_COMMON_SYS_UTILS_H
#define ADUMP_COMMON_SYS_UTILS_H
#include <string>
#include <cstdint>
#include "mmpa_api.h"

namespace Adx {
const std::string DEFAULT_MILLISECOND_TIME = "19700101000000000";
class SysUtils {
public:
    static std::string GetCurrentWorkDir();
    static std::string HandleEnv(const char* env);
    static uint64_t GetTimestamp();
    static std::string GetCurrentTime();
    static std::string GetCurrentTimeWithMillisecond();
    static std::string GetPid();
    template<typename TO, typename TI>
    static TO *ReinterpretCast(TI *ptr)
    {
        return reinterpret_cast<TO *>(ptr);
    }
};

#define ADX_GET_ENV(IDNAME, envStr)        \
    do {                                   \
        const char *env = nullptr;         \
        MM_SYS_GET_ENV(IDNAME, env);       \
        envStr = SysUtils::HandleEnv(env); \
    } while (0)

}  // namespace Adx
#endif  // ADUMP_COMMON_SYS_UTILS_H