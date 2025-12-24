/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef SLOGD_UTEST_STUB_H
#define SLOGD_UTEST_STUB_H

#include <sys/ipc.h>
#include <sys/shm.h>
#include <stdbool.h>
#include "log_system_api.h"
#include "slogd_argv.h"

struct LogServerInitInfo {
    int32_t deviceId;  // set -1 is all
};

int shmctl_rep(int shmid, int cmd, struct shmid_ds *buf);
ssize_t read_rep(int fd, void *buf, size_t count);

size_t strlen_rep(const char *s);
static toolMsgid g_msgCreatId = 1;
static toolMsgid g_msgOpenId = 0;

int TestMain(int argc, char** argv);
int32_t ParseSlogdArgv(int argc, char **argv, struct SlogdOptions *opt);

void SlogdInitHdcServer(int32_t devId);

int32_t LogHdcServerInit(struct LogServerInitInfo *info);

int JustStartAProcess(const char *file);

void SingleResourceCleanup(const char *file);

void GetZipFlag(void);
int ToolSetThreadName(const char *threadName);;

int CreateThreadWithStackSize(ToolThread  *tid, ToolUserBlock *funcBlock);

ssize_t read(int fd, void *buf, size_t nbytes);

int32_t CheckMutex(void);
#endif
