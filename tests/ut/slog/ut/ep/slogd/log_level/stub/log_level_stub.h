/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef LOG_LEVEL_STUB_H
#define LOG_LEVEL_STUB_H

#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/file.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

int32_t shmgetStub(key_t key, size_t size, int32_t shmflg);

void *shmatStub(int32_t shmid, const void *shmaddr, int32_t shmflg);

int32_t shmdtStub(const void *shmaddr);

int32_t shmctlStub(int32_t shmid, int32_t cmd, struct shmid_ds *buf);

#ifdef __cplusplus
}
#endif
#endif