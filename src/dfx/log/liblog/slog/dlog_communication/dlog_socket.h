/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DLOG_SOCKET_H
#define DLOG_SOCKET_H
#include "dlog_common.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

int32_t IsSocketConnected(void);
void SetSocketConnectedStatus(int32_t status);
bool IsSocketFdValid(void);
void SetSocketFd(int32_t fd);
toolSockHandle GetSocketFd(void);
toolSockHandle GetRsyslogSocketFd(uint32_t typeMask);
toolSockHandle CreatSocket(uint32_t devId);
int32_t CloseSocket(void);
void CloseLogInternal(void);
void SigPipeHandler(int32_t signo);

#ifdef __cplusplus
}
#endif // __cplusplus

#endif // DLOG_SOCKET_H