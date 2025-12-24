/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef LOG_CONFIG_H
#define LOG_CONFIG_H

#define CONF_NAME_MAX_LEN   63
#define CONF_VALUE_MAX_LEN  1023
#define CONF_FILE_MAX_LINE (CONF_NAME_MAX_LEN + CONF_VALUE_MAX_LEN + 1)


#define ENABLEEVENT_KEY             "enableEvent"
#define GLOBALLEVEL_KEY             "global_level"
#define LOG_AGENT_FILE_DIR_STR      "logAgentFileDir"
#define PERMISSION_FOR_ALL          "permission_for_all"
#define ZIP_SWITCH                  "zip_switch"
#define SYS_LOG_BUF_SIZE_STR        "SysLogBufSize"
#define APP_LOG_BUF_SIZE_STR        "AppLogBufSize"
#define RESERVE_DEVICE_APP_DIR_NUMS "DeviceAppDirNums"

#ifndef SLOG_CONF_FILE_PATH
#if (OS_TYPE_DEF == LINUX)
#ifdef LINUX_ETC_CONF
    #define SLOG_CONF_FILE_PATH "/etc/slog.conf"
#else
    #define SLOG_CONF_FILE_PATH "/var/log/npu/conf/slog/slog.conf"
#endif
#else
    #define SLOG_CONF_FILE_PATH ("C:\\Program Files\\Huawei\\Ascend\\conf\\slog\\slog.conf")
#endif
#endif

#endif
