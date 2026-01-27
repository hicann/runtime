/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "env_internal_api.h"

namespace tsd {
    void GetEnvFromMmSys(mmEnvId id, const char *envName, std::string &envValue)
    {
        constexpr size_t envValueMaxLen = 1024UL * 1024UL;
        try {
            const char *envPath = nullptr;
            envPath = (&mmSysGetEnv != nullptr) ? mmSysGetEnv(id) : getenv(envName);
            if ((envPath == nullptr) || (strnlen(envPath, envValueMaxLen) >= envValueMaxLen)) {
                TSD_WARN("Get env[%s] failed", envName);
                return;
            }
            envValue = envPath;
        } catch (std::exception &e) {
            TSD_ERROR("get env failed:[%s]", e.what());
        }
    }

    bool GetFlagFromMmSys(mmEnvId id, const char_t * const envStr, const char_t * const envValue)
    {
        std::string isFlag;
        GetEnvFromMmSys(id, envStr, isFlag);
        if (!isFlag.empty()) {
            if (isFlag == envValue) {
                return true;
            }
        }
        return false;
    }

    bool IsFpgaMmSysEnv()
    {
        const bool isFpga = GetFlagFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "DATAMASTER_RUN_MODE", "1");
        return isFpga;
    }

    bool IsAsanMmSysEnv()
    {
        const bool isAsan = GetFlagFromMmSys(MM_ENV_ASAN_RUN_MODE, "ASAN_RUN_MODE", "1");
        return isAsan;
    }
}