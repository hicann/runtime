/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CONFIG_STUB_H
#define CONFIG_STUB_H

#ifdef __cplusplus
extern "C" {
#endif

#define DEVICE_MAX_FILE_NUM_STR              "DeviceMaxFileNum"
#define DEVICE_OS_MAX_FILE_NUM_STR           "DeviceOsMaxFileNum"
#define DEVICE_NDEBUG_MAX_FILE_NUM_STR       "DeviceOsNdebugMaxFileNum"
#define DEVICE_APP_MAX_FILE_NUM_STR          "DeviceAppMaxFileNum"
#define DEVICE_MAX_FILE_SIZE_STR             "DeviceMaxFileSize"
#define DEVICE_OS_MAX_FILE_SIZE_STR          "DeviceOsMaxFileSize"
#define DEVICE_NDEBUG_MAX_FILE_SIZE_STR      "DeviceOsNdebugMaxFileSize"
#define DEVICE_APP_MAX_FILE_SIZE_STR         "DeviceAppMaxFileSize"
#define LOG_CONFIG_FILE                      "slog.conf"
#define DEFAULT_LOG_BUF_SIZE                 (256 * 1024) // 256KB
#define DEFAULT_RESERVE_DEVICE_APP_DIR_NUMS  24

#ifdef __cplusplus
}
#endif
#endif