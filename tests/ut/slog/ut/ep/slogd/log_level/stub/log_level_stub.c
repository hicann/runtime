/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_level_stub.h"
#include "log_print.h"

#define SHMEM_FILE  "/tmp/ep_slogd_utest_6cEd5299d8d9Be97/shmem.log"

int32_t g_shmFd = -1;
int32_t g_shmFlag = 0;
void *g_value;

int32_t shmgetStub(key_t key, size_t size, int32_t shmflg)
{
    system("rm " SHMEM_FILE);
    system("> "SHMEM_FILE);
    if (g_shmFd == -1) {
        g_shmFd = open(SHMEM_FILE, O_CREAT | O_RDWR);
    }
    return g_shmFd;
}

void *shmatStub(int32_t shmid, const void *shmaddr, int32_t shmflg)
{
    g_shmFlag = shmflg;
    if (g_shmFlag == SHM_RDONLY) {
        read(g_shmFd, shmaddr, strlen(shmaddr));
    }
    g_value = malloc(10240);
    return g_value;
}

int32_t shmdtStub(const void *shmaddr)
{
    if (g_shmFlag == 0) {
        write(g_shmFd, shmaddr, strlen(shmaddr));
    }
    free(g_value);
    return 0;
}

int32_t shmctlStub(int32_t shmid, int32_t cmd, struct shmid_ds *buf)
{
    close(g_shmFd);
    system("rm " SHMEM_FILE);
    return 0;
}