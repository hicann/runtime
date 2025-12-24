/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SLOGD_THREAD_MGR_H
#define SLOGD_THREAD_MGR_H

#include "log_common.h"
#include "log_system_api.h"

#ifdef __cplusplus
extern "C" {
#endif

#define THREAD_NAME_MAX_LEN 15

typedef enum {
    FIRMWARE_LOG_PRIORITY,
    GROUP_LOG_PRIORITY,
    EVENT_LOG_PRIORITY,
    SYS_LOG_PRIORITY,
    APP_LOG_PRIORITY,
    LOG_PRIORITY_TYPE_NUM
} LogPriority;

typedef enum {
    COMMON_THREAD_TYPE = 0,
    DEVICE_THREAD_TYPE,
    THREAD_TYPE_NUM
} ThreadType;

typedef struct {
    ToolUserBlock threadInfo;
    ToolThread tid;
} ComThread;

typedef struct {
    int32_t deviceId;
    ToolUserBlock threadInfo;
    ToolThread tid;
} DevThread;

typedef struct {
    int32_t comThreadNum;
    ComThread *comThread;
    int32_t devNum;
    DevThread *devThread;
} ThreadManage;

int32_t SlogdThreadMgrCreateCommonThread(ComThread *comThread, ToolProcFunc procFunc);
int32_t SlogdThreadMgrCreateDeviceThread(DevThread *deviceThreadArr, int32_t arrLen, int32_t *devNum,
    ToolProcFunc procFunc);
void SlogdThreadMgrExit(ThreadManage *threadManage);

#ifdef __cplusplus
}
#endif

#endif /* SLOGD_THREAD_MGR_H */