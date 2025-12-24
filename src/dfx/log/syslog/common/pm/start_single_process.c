/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifdef SCRIPT_MONITOR

#include "start_single_process.h"
#include <fcntl.h>
#include "log_common.h"
#include "log_print.h"

#define ARRAY_LENGTH 10
#define FILE_MASK_WC 0640
#define HUNDRED_MILLI_SECOND 100
#define RETRY_TIMES 5

// File lock, Just start a process
STATIC int32_t g_lockFd = -1;

STATIC int32_t LockReg(const LockRegParams *params)
{
    if (params->fd <= 0) {
        return 0;
    }
    struct flock lock = { 0 };
    lock.l_type = (short)params->type;
    lock.l_start = params->offset;
    lock.l_whence = (short)params->whence;
    lock.l_len = params->len;
    return (fcntl(params->fd, params->cmd, &lock));
}

LogStatus JustStartAProcess(const char *file)
{
    ONE_ACT_WARN_LOG(file == NULL, return LOG_INVALID_PARAM, "[input] file is null.");

    char buf[ARRAY_LENGTH] = "";
    g_lockFd = ToolOpenWithMode(file, O_WRONLY | O_CREAT, FILE_MASK_WC);
    ONE_ACT_ERR_LOG(g_lockFd < 0, return LOG_INVALID_DATA, "open file=%s failed, strerr=%s",
                    file, strerror(ToolGetErrorCode()));

    LockRegParams params = { g_lockFd, F_SETLK, F_WRLCK, 0, SEEK_SET, 0 };
    int32_t retry = 0;
    // perhaps slogd which is killed by cmd is still running, wait until it quit
    while (LockReg(&params) == -1) {
        if ((ToolGetErrorCode() == EAGAIN) && (retry < RETRY_TIMES)) {
            ToolSleep(HUNDRED_MILLI_SECOND);
            retry++;
        } else {
            SELF_LOG_ERROR("fcntl file failed, file=%s, strerr=%s.", file, strerror(ToolGetErrorCode()));
            return LOG_PROCESS_REPEAT;
        }
    }

    int32_t ret = ftruncate(g_lockFd, 0);
    TWO_ACT_ERR_LOG(ret == -1, SingleResourceCleanup(file), return LOG_INVALID_DATA,
                    "reset file size to zero failed, file=%s, strerr=%s.", file, strerror(ToolGetErrorCode()));

    ret = sprintf_s(buf, sizeof(buf), "%d\n", ToolGetPid());
    TWO_ACT_ERR_LOG(ret == -1, SingleResourceCleanup(file), return LOG_INVALID_DATA,
                    "sprintf_s process id failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));

    ret = ToolWrite(g_lockFd, buf, (UINT32)strlen(buf));
    TWO_ACT_ERR_LOG((ret < 0) || ((unsigned)ret != strlen(buf)), SingleResourceCleanup(file), return LOG_INVALID_DATA,
                    "write buffer to file failed, file=%s, strerr=%s.", file, strerror(ToolGetErrorCode()));

    ret = fcntl(g_lockFd, F_GETFD, 0);
    TWO_ACT_ERR_LOG(ret == -1, SingleResourceCleanup(file), return LOG_INVALID_DATA,
                    "fcntl file failed, file=%s, strerr=%s.", file, strerror(ToolGetErrorCode()));
    unsigned int res = (unsigned int)ret;
    res |= FD_CLOEXEC;
    ret = fcntl(g_lockFd, F_SETFD, res);
    TWO_ACT_ERR_LOG(ret == -1, SingleResourceCleanup(file), return LOG_INVALID_DATA,
                    "fcntl file failed, file=%s, strerr=%s.", file, strerror(ToolGetErrorCode()));
    return LOG_SUCCESS;
}

// File lock, end
void SingleResourceCleanup(const char *file)
{
    ONE_ACT_NO_LOG((file == NULL) || (strlen(file) == 0), return);

    if (ToolUnlink(file) != 0) {
        SELF_LOG_ERROR("unlink file failed, file=%s, strerr=%s.", file, strerror(ToolGetErrorCode()));
    }
    LOG_CLOSE_FD(g_lockFd);
}
#endif
