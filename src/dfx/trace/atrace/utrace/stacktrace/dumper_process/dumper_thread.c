/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dumper_thread.h"
#include <errno.h>
#include <elf.h>
#include <sys/ptrace.h>
#include <sys/uio.h>
#include <sys/wait.h>
#include "stacktrace_safe_recorder.h"
#include "trace_system_api.h"
#include "adiag_print.h"

STATIC int32_t ScdWaitPid(pid_t pid, int32_t *status, int32_t flags)
{
    int32_t ret;
    do {
        ret = waitpid (pid, status, flags);
    } while (ret == -1 && errno == EINTR);
    return ret;
}

TraStatus DumperThreadWaitTidStopped(pid_t tid)
{
    int32_t status;
    int32_t ret;
    do {
        ret = ScdWaitPid(tid, &status, __WALL);
        if (ret == -1) {
            LOGE("[%d]watipid failed, %d", tid, errno);
            return TRACE_FAILURE;
        }
        if (!WIFSTOPPED(status)) {
            LOGE("[%d]failed to stop, status %x", tid, status);
            return TRACE_FAILURE;
        }
        if (WSTOPSIG (status) == SIGSTOP) {
            break;
        }
        LOGW("waitpid ret %d status %x from %d", ret, status, tid);
        // receive other signal, continue with no signal to still wait for SIGSTOP
        (void)ptrace(PTRACE_CONT, tid, NULL, NULL);
    } while (true);
    return TRACE_SUCCESS;
}

TraStatus DumperThreadSuspend(pid_t tid)
{
    if (tid <= 0) {
        LOGW("tid %d is invalid", tid);
        return TRACE_FAILURE;
    }
    if (ptrace(PTRACE_ATTACH, tid, NULL, NULL) != 0) {
        LOGW("THREAD[%d]: can not ptrace ATTACH, errno=%d", tid, errno);
        return TRACE_FAILURE;
    }
    (void)DumperThreadWaitTidStopped(tid);
    return TRACE_SUCCESS;
}

void DumperThreadResume(pid_t tid)
{
    if (tid <= 0) {
        LOGW("tid %d is invalid", tid);
        return;
    }
    (void)ptrace(PTRACE_DETACH, tid, NULL, NULL);
}

void DumperThreadGetName(pid_t pid, pid_t tid, char *threadName, uint32_t nameLen)
{
    if (threadName == NULL || nameLen == 0) {
        LOGE("input pointer is invalid");
        return;
    }
    (void)memcpy_s(threadName, nameLen, "unknown", sizeof("unknown"));
    char path[CORE_BUFFER_LEN] = { 0 };
    int32_t ret = snprintf_s(path, sizeof(path), sizeof(path) - 1U, "/proc/%d/task/%d/comm", pid, tid);
    if (ret == -1) {
        LOGW("snprintf_s comm path failed");
        return;
    }
    int32_t fd = open(path, O_RDONLY);
    if (fd < 0) {
        LOGW("open comm filed, tid=%d", tid);
        return;
    }

    char data[CORE_BUFFER_LEN] = { 0 };
    ssize_t readLen = TraceSafeReadLine(fd, data, CORE_BUFFER_LEN);
    if (readLen > 1 && readLen <= (ssize_t)nameLen) {
        if(data[readLen - 1] == '\n') {
            data[readLen - 1] = '\0';
        }
        (void)memcpy_s(threadName, nameLen, data, nameLen);
    }
    TraceClose(&fd);
}

TraStatus DumperThreadGetRegs(pid_t tid, uintptr_t *regArray, uint32_t regNum)
{
    if (regArray == NULL) {
        LOGE("input pointer is null");
        return TRACE_FAILURE;
    }
    if (tid <= 0) {
        LOGW("tid %d is invalid", tid);
        return TRACE_FAILURE;
    }
    uintptr_t regs[TRACE_CORE_REG_NUM + 1U]; //big enough for all architectures
    size_t regLen = 0;
    
#ifdef PTRACE_GETREGS
    if(ptrace(PTRACE_GETREGS, tid, NULL, &regs) != 0) {
        LOGE("THREAD[%d]: ptrace GETREGS failed, errno=%d", tid, errno);
        return TRACE_FAILURE;
    }
    regLen = TRACE_CORE_REG_NUM;
#else
    struct iovec iovec;
    iovec.iov_base = &regs;
    iovec.iov_len = sizeof(regs);
    if(ptrace(PTRACE_GETREGSET, tid, NT_PRSTATUS, &iovec) != 0) {
        LOGE("THREAD[%d]: ptrace GETREGSET failed, errno=%d", tid, errno);
        return TRACE_FAILURE;
    }
    regLen = iovec.iov_len / sizeof(uintptr_t);
#endif
    regLen = (regLen > regNum) ? regNum : regLen;
    (void)memcpy_s(regArray, sizeof(uintptr_t) * regNum, regs, sizeof(uintptr_t) * regLen);
    return TRACE_SUCCESS;
}
