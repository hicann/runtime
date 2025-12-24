/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SLOGD_APPLOG_H
#define SLOGD_APPLOG_H

#include "log_error_code.h"
#include "log_to_file.h"
#include "slogd_flush.h"
#include "slogd_recv_core.h"

typedef struct TagLogBufList {
    LogType type;
    int32_t aosType;
    uint32_t pid;
    uint32_t deviceId;
    uint32_t noAppDataCount;
    uint32_t writeWaitTime;
    struct TagLogBufList *next;
} AppLogList;

#ifdef __cplusplus
extern "C" {
#endif

AppLogList *SlogdGetAppLogBufList(void);
uint32_t SlogdGetAppNodeNum(void);
AppLogList *SlogdApplogGetNode(const LogInfo *info);
void InnerDeleteAppNode(const AppLogList *input);

LogStatus SlogdApplogFlushInit(void);
void SlogdApplogFlushExit(void);

void SlogdAppLogLock(void);
void SlogdAppLogUnLock(void);

#ifdef APP_LOG_WATCH
LogStatus SlogdFlushToAppBuf(const char *msg, uint32_t msgLen, const LogInfo *info);
LogStatus SlogdApplogFlushToFile(void *buffer, uint32_t bufLen);
#endif

#ifdef __cplusplus
}
#endif
#endif

