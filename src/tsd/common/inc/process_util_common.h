/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TDT_COMMON_COMMON_INC_PROCESS_UTIL_COMMON_H
#define TDT_COMMON_COMMON_INC_PROCESS_UTIL_COMMON_H
#include <sched.h>
#include <string>
#include "tsd/status.h"
#include "inc/tsd_event_interface.h"
#include "inc/internal_api.h"
#include "driver/ascend_hal_define.h"

namespace tsd {
    class ProcessUtilCommon {
    public:

        static TSD_StatusT SetThreadAffinity(const pthread_t &threadId, const std::vector<uint32_t> &cpuIds);

        static TSD_StatusT SaveThreadAffinity(pthread_t &threadId, cpu_set_t * const cpusetSaved);

        static TSD_StatusT RestoreThreadAffinity(pthread_t &threadId, const cpu_set_t * const cpusetSaved);

        static TSD_StatusT ReadCurMemCtrolType(const std::string &path, std::string &memCtrolType);

        static TSD_StatusT GetCurHomePath(std::string &curHomePath);

        static bool IsInBlackEnvList(const std::string &curEnv);

        static std::string CalFileSha256HashValue(const std::string &filePath);
    };
} // namespace tsd
#endif // TDT_COMMON_COMMON_INC_PROCESS_UTIL_COMMON_H
