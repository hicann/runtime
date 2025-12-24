/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef IDE_DAEMON_COMMON_CONFIG_H
#define IDE_DAEMON_COMMON_CONFIG_H
#include <cstdint>
#include "extra_config.h"
namespace IdeDaemon {
namespace Common {
namespace Config {
/* directory umask */
constexpr int32_t SPECIAL_UMASK                  = (0022);
constexpr int32_t IDE_RESPONSE_WAIT_TIME         = 3;      // 3s Service response time
constexpr int32_t IDE_CREATE_SERVER_TIME         = 5000;   // 5 * 1000ms
constexpr int32_t IDE_HDC_WAIT_TIME_SECS         = 1000;   // 1s 1000ms
constexpr int32_t IDE_DAEMON_BLOCK               = 0;
constexpr int32_t IDE_DAEMON_NOBLOCK             = 1;
constexpr int32_t IDE_DAEMON_TIMEOUT             = 2;
constexpr uint32_t IDE_MAX_HDC_SEGMENT           = 524288;         // (512 * 1024) max size of hdc segment
constexpr uint32_t IDE_MIN_HDC_SEGMENT           = 1024;           // min size of hdc segment
constexpr const char *IDE_HDC_SERVER_THREAD_NAME         = "ide_hdc_server";
constexpr const char *IDE_HDC_PROCESS_THREAD_NAME        = "ide_hdc_process";
constexpr const char *IDE_DEVICE_MONITOR_THREAD_NAME     = "ide_dev_monitor";
constexpr const char *IDE_UNDERLINE                      = "_";
constexpr const char *IDE_HOME_WAVE_DIR                  = "~/";
} // end config
}
}

#endif

