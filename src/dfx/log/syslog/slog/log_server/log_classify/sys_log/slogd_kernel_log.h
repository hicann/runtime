/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SLOGD_KERNEL_LOG_H
#define SLOGD_KERNEL_LOG_H

#include <poll.h>
#include "slogd_recv_core.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef int32_t (*SysLogWriteFunc)(const char *, uint32_t, const LogInfo *);

typedef struct {
    int32_t fd;
    struct pollfd pollFd;
    char *recvBuf;
    SysLogWriteFunc write;
} SlogdKernelLogMgr;

LogStatus SlogdKernelLogInit(SysLogWriteFunc func);
void SlogdKernelLogExit(void);

#ifdef __cplusplus
}
#endif
#endif

