/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ATRACE_CLIENT_COMMUNICATION_H
#define ATRACE_CLIENT_COMMUNICATION_H

#include "atrace_types.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

typedef struct {
    char *eventName;
    char *eventTime;
    char *buf;
    uint32_t bufLen;
    int32_t devPid;
    bool endFlag;
    uint8_t saveType;
} TraceMsgInfo;

TraStatus AtraceClientSendHello(int32_t devId);
TraStatus AtraceClientSendEnd(int32_t devId);

TraStatus AtraceClientCreateLongLink(int32_t devId, int32_t timeout, void **handle);
TraStatus AtraceClientRecv(void *handle, char **data, uint32_t *len, int32_t timeout);
bool AtraceClientIsHandleValid(void *handle);
void AtraceClientReleaseHandle(void **handle);

bool AtraceClientIsEventMsg(char *data, uint32_t len);
bool AtraceClientIsEndMsg(char *data, uint32_t len);
TraStatus AtraceClientParseEventMsg(char *data, uint32_t len, TraceMsgInfo *info);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif