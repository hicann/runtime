/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_HDC_SERVER_H
#define LOG_HDC_SERVER_H
#include <stdint.h>
#include "adx_service_config.h"
#ifdef __cplusplus
extern "C" {
#endif

extern int32_t SysReportInit(void);
extern int32_t SysReportDestroy(void);
extern int32_t SysReportProcess(const CommHandle *handle, const void *value, uint32_t len);
extern int32_t SysGetInit(void);
extern int32_t SysGetDestroy(void);
extern int32_t SysGetProcess(const CommHandle *handle, const void *value, uint32_t len);
struct LogServerInitInfo {
    int32_t mode;      // 0 default, 1 virtual
    int32_t deviceId;  // set -1 is all
};

/**
 * @brief          : initialize server for log hdc function.
 * @return         : SYS_OK     log server init success
 *                   SYS_ERROR  log server init failed
 */
int32_t LogHdcServerInit(const struct LogServerInitInfo *info);
#ifdef __cplusplus
}
#endif
#endif

