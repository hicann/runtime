/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef MSPROF_STUB_ST_H
#define MSPROF_STUB_ST_H

#include <sys/syscall.h>
#include <unistd.h>
#include <string>
#include <map>
#include "slog.h"
#ifndef MSPROF_C
#include "config/config_manager.h"
#else
#ifndef MSPROF_C_CPP
#define MSPROF_MODULE_NAME PROFILING

#define MSPROF_LOGD(format, ...) do {                                                                      \
    dlog_debug(MSPROF_MODULE_NAME, " >>> (tid:%ld) " format "\n", syscall(SYS_gettid), ##__VA_ARGS__);    \
} while (0)

#define MSPROF_LOGI(format, ...) do {                                                                      \
    dlog_info(MSPROF_MODULE_NAME, " >>> (tid:%ld) " format "\n", syscall(SYS_gettid), ##__VA_ARGS__);     \
} while (0)

#define MSPROF_LOGW(format, ...) do {                                                                      \
    dlog_warn(MSPROF_MODULE_NAME, " >>> (tid:%ld) " format "\n", syscall(SYS_gettid), ##__VA_ARGS__);     \
} while (0)

#define MSPROF_LOGE(format, ...) do {                                                                      \
    dlog_error(MSPROF_MODULE_NAME, " >>> (tid:%ld) " format "\n", syscall(SYS_gettid), ##__VA_ARGS__);    \
} while (0)

#define MSPROF_EVENT(format, ...) do {                                                                     \
    dlog_info(static_cast<int>(static_cast<unsigned int>(MSPROF_MODULE_NAME) | RUN_LOG_MASK),             \
        " >>> (tid:%ld) " format "\n", syscall(SYS_gettid), ##__VA_ARGS__);                               \
} while (0)
#endif
#endif

enum class StPlatformType {
    MINI_TYPE = 0,
    CLOUD_TYPE,
    MDC_TYPE,
    DC_TYPE = 4,
    CHIP_V4_1_0,
    MINI_V3_TYPE = 7,
    CHIP_TINY_V1 = 8,
    CHIP_NANO_V1 = 9,
    CHIP_MDC_MINI_V3 = 11,
    CHIP_MDC_LITE = 12,
    CHIP_CLOUD_V3 = 15,
    CHIP_CLOUD_V4 = 16,
    END_TYPE
};

enum class StProfConfigType {
    PROF_CONFIG_COMMAND_LINE = 0,
    PROF_CONFIG_ACL_JSON = 1,
    PROF_CONFIG_GE_OPTION = 2,
    PROF_CONFIG_HELPER = 4,
    PROF_CONFIG_PURE_CPU = 5,
    PROF_CONFIG_ACL_API = 6,
    PROF_CONFIG_ACL_SUBSCRIBE = 7,
    PROF_CONFIG_DYNAMIC = 0xFF,
};

const std::map<uint32_t, std::string> CLI_CHECK_OUTPUT = {
    {0, "cliMinistest_workspace/output"},
    {1, "cliCloudstest_workspace/output"},
    {2, "cliMdcstest_workspace/output"},
    {4, "cliDcstest_workspace/output"},
    {5, "cliMilanstest_workspace/output"},
    {7, "cliMiniV3stest_workspace/output"},
    {8, "cliTinystest_workspace/output"},
    {9, "cliNanostest_workspace/output"},
    {11, "cliMdcMiniV3stest_workspace/output"},
    {12, "cliMdcLitestest_workspace/output"},
    {15, "cliDavidstest_workspace/output"},
    {16, "cliDavidV121stest_workspace/output"},
};

void ClearSingleton();
void MockPerfDir(std::string &dir);

#endif