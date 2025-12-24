/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef LOG_DAEMON_STUB_H
#define LOG_DAEMON_STUB_H

#include "ascend_hal_error.h"

#define SET_SUCCESS_MSG            "Configuration successfully set"
#define DRV_NOT_READY              "Driver api wait timeout"
#define DRV_ERROR                  "Set config failed, check slogdlog for more information"
#define TS_NOT_SUPPORT             "This chip platform does not support"
#define TS_CORE_ID_INVALID         "The specified core id is invalid"
#define TS_CORE_ID_PF_DOWN         "The specified core is pg down core and does not support the operation"
#define TS_NOT_SUPPORT_CORE        "This chip platform not support core mask"
#define TS_NOT_SUPPORT_AIV_CORE    "This chip platform not support aiv core"
#define TS_CORE_NOT_IN_POOL        "The specified core maybe not in pool"
#define TS_POOLING_STATUS_FAIL     "The specified core need pooling status"
#ifdef __cplusplus
extern "C" {
#endif

int LogGetCpuAlarmNum(void);
int LogGetCpuStatNum(void);
int LogGetMemAlarmNum(void);
int LogGetMemStatNum(void);
int LogGetFdAlarmNum(void);
int LogGetFdTopNum(void);
int LogGetFdStatNum(void);
int LogGetZpAlarmNum(void);
int LogGetZpStatNum(void);
int LogGetFrameStart(void);
void LogClearPrintNum(void);

#ifdef __cplusplus
}
#endif
#endif