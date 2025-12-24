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
#include <string>
namespace IdeDaemon {
namespace Common {
namespace Config {
/* directory umask */
constexpr int32_t DEFAULT_UMASK                  = (0027);
constexpr int32_t SPECIAL_UMASK                  = (0022);
constexpr int32_t IDE_CREATE_SERVER_TIME         = 5000;   // 5 * 1000ms
constexpr int32_t MAX_LISTEN_NUM                 = 100;
constexpr int32_t PATH_LEN                       = 200;
constexpr int32_t IDE_DAEMON_BLOCK               = 0;
constexpr int32_t IDE_DAEMON_NOBLOCK             = 1;
constexpr int32_t IDE_DAEMON_TIMEOUT             = 2;
constexpr uint32_t IDE_MAX_HDC_SEGMENT           = 524288;         // (512 * 1024) max size of hdc segment
constexpr uint32_t IDE_MIN_HDC_SEGMENT           = 1024;           // min size of hdc segment
constexpr uint32_t DISK_RESERVED_SPACE           = 1048576;        // disk reserved space 1Mb
constexpr int32_t NON_DOCKER                     = 1;
constexpr int32_t IS_DOCKER                      = 2;
constexpr int32_t VM_NON_DOCKER                  = 3;
constexpr const char *IDE_HDC_SERVER_THREAD_NAME         = "ide_hdc_server";
constexpr const char *IDE_HDC_PROCESS_THREAD_NAME        = "ide_hdc_process";
constexpr const char *IDE_DEVICE_MONITOR_THREAD_NAME     = "ide_dev_monitor";
constexpr const char *IDE_UNDERLINE                      = "_";
constexpr const char *IDE_HOME_WAVE_DIR                  = "~/";
constexpr const char *IDE_SPLIT_CHAR                     = ";";
constexpr const char *ADX_PF_LOCAL_CHAN                  = "adserver";
constexpr const char *OS_SPLIT_STR                       = "/";
const std::string CONTAINER_NO_SUPPORT_MESSAGE           = "MESSAGE_CONTAINER_NO_SUPPORT";
constexpr char OS_SPLIT                                  = '/';
const std::string SEND_END_MSG                           = "game_over";
const std::string HELPER_HOSTPID                         = "ASCEND_HOSTPID";
} // end config
}
}

#endif

