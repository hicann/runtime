/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DLOG_MESSAGE_H
#define DLOG_MESSAGE_H

#include "slog.h"
#include "log_communication.h"
#include "dlog_common.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define MODULE_ID_MASK 0x0000FFFFU
#define LOG_TYPE_MASK  0xFFFF0000U

typedef struct {
    uint32_t moduleId;
    uint32_t typeMask;
    int32_t level;
    int32_t selfPid;
    LogAttr attr;
    char timestamp[TIMESTAMP_LEN];
    KeyValueArg kvArg;
} LogMsgArg;

typedef struct {
    LogType type;
    int32_t level;
    uint32_t moduleId;
    uint32_t contentLength;
    char *logContent; // pointer to real log content
    uint32_t msgLength;
    char msg[MSG_LENGTH];
} LogMsg;

void DlogParseLogMsg(LogMsgArg *msgArg, LogMsg *logMsg);
int32_t DlogSetMessage(LogMsg *logMsg, const LogMsgArg *msgArg, const char *fmt, va_list v);
void DlogSetMessageNl(LogMsg *logMsg);

LogStatus DlogAddMessageTag(LogMsg *logMsg, const LogMsgArg *msgArg, char *buffer, uint32_t bufLen);
LogStatus DlogAddMessageHead(LogMsg *logMsg, char *buffer, uint32_t bufLen);
#ifdef __cplusplus
}
#endif // __cplusplus
#endif

