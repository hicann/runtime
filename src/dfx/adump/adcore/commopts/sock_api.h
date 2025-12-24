/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef SOCK_API_H
#define SOCK_API_H
#include <cstdint>
#include <string>
#include "extra_config.h"
#define ADX_LOCAL_CLOSE_AND_SET_INVALID(fd) do {    \
    if ((fd) >= 0) {                                  \
        (void)close(fd);                            \
        fd = -1;                                    \
    }                                               \
} while (0)

int32_t SockServerCreate(const std::string &adxLocalChan);
int32_t SockServerDestroy(int32_t &sockFd);
int32_t SockClientCreate();
int32_t SockClientDestory(int32_t &sockFd);
int32_t SockAccept(int32_t sockFd);
int32_t SockConnect(int32_t sockFd, const std::string &adxLocalChan);
int32_t SockRead(int32_t fd, IdeRecvBuffT readBuf, IdeI32Pt recvLen, int32_t flag);
int32_t SockWrite(int32_t fd, IdeSendBuffT writeBuf, int32_t len, int32_t flag);
int32_t SockClose(int32_t &sockFd);
#endif