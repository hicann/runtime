/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ALOG_STUB_H
#define ALOG_STUB_H

#include <stdint.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include "share_mem.h"
#include "dlog_socket.h"

#ifdef __cplusplus
extern "C" {
#endif

enum SlogFuncIndex {
    DLOG_INIT = 0,
    DLOG_GET_LEVEL,
    DLOG_SET_LEVEL,
    CHECK_LOG_LEVEL,
    DLOG_GET_ATTR,
    DLOG_SET_ATTR,
    DLOG_VA_LIST,
    DLOG_FLUSH,
    DLOG_FUNC_MAX
};

void *logDlopen(const char *fileName, int mode);
int logDlclose(void *handle);
void *logDlsym(void *handle, const char* funcName);

int32_t GetSlogFuncCallCount(int32_t index);

void SetShmem(uint8_t msgType);
ShmErr ShMemRead_stub(int32_t shmId, char *value, size_t len, size_t offset);
int32_t CreatSocket_stub(uint32_t devId);

#ifdef __cplusplus
}
#endif
#endif // ALOG_STUB_H