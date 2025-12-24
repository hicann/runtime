/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stacktrace_exec.h"
#include "adiag_print.h"
#include "stacktrace_safe_recorder.h"
#include "stacktrace_err_code.h"
#include "scd_process.h"

#define STACKTRACE_DUMP_EXE "asc_dumper"
#define STACKTRACE_DUMP_BIN_MODE  0xAABB0003U
#define TRACE_UTIL_TEMP_FAILURE_RETRY(exp) ({      \
            __typeof__(exp) rc;                    \
            do {                                   \
                errno = 0;                         \
                rc = (exp);                        \
            } while (rc == -1 && errno == EINTR);  \
            rc; })

STATIC TraStatus ScExecSetArgs(ScdProcessArgs *args, const ThreadArgument *info)
{
    errno_t ret = memcpy_s(&args->si, sizeof(siginfo_t), &info->siginfo, sizeof(siginfo_t));
    if (ret != EOK) {
        LOGE("copy siginfo failed, err=%d.", ret);
        return TRACE_FAILURE;
    }
    ret = memcpy_s(&args->uc, sizeof(ucontext_t), &info->ucontext, sizeof(ucontext_t));
    if (ret != EOK) {
        LOGE("copy context failed, err=%d.", ret);
        return TRACE_FAILURE;
    }
    ret = strcpy_s(args->filePath, SCD_MAX_FILEPATH_LEN + 1U, info->filePath);
    if (ret != EOK) {
        LOGE("copy file path failed, err=%d.", ret);
        return TRACE_FAILURE;
    }
    ret = strcpy_s(args->fileName, SCD_MAX_FILENAME_LEN + 1U, info->fileName);
    if (ret != EOK) {
        LOGE("copy file name failed, err=%d.", ret);
        return TRACE_FAILURE;
    }
    args->pid = info->pid;
    args->crashTid = info->tid;
    args->signo = info->signo;
    args->crashTime = info->crashTime;
    args->stackBaseAddr = info->stackBaseAddr;

    // set mode
    uint32_t mode = (uint32_t)info->siginfo.si_value.sival_int;
    if ((info->signo == SIG_ATRACE) && (mode == STACKTRACE_DUMP_BIN_MODE)) {
        args->handleType = SCD_DUMP_THREADS_BIN;
        LOGR("core path=%s/%s.bin", args->filePath, args->fileName);
    } else {
        args->handleType = SCD_DUMP_THREADS_TXT;
        LOGR("core path=%s/%s.txt", args->filePath, args->fileName);
    }

    return TRACE_SUCCESS;
}

STATIC int32_t ScExecEntry(void *args)
{
    if (args == NULL) {
        LOGE("args is null.");
        return 1;
    }
    const ThreadArgument *info = (const ThreadArgument *)args;
    ScdProcessArgs scdArgs;
    if (ScExecSetArgs(&scdArgs, info) != TRACE_SUCCESS) {
        LOGE("set args failed.");
        return SCD_ERR_CODE_SET_ARG;
    }

    //create args pipe
    int32_t pipeFd[2];
    errno = 0;
    if(pipe2(pipeFd, O_CLOEXEC) != 0) {
        LOGE("create args pipe failed, errno=%d.", errno);
        return SCD_ERR_CODE_PIPE2;
    }
    int32_t writeLen = (int32_t)sizeof(ScdProcessArgs);
    if(fcntl(pipeFd[1], F_SETPIPE_SZ, writeLen) < writeLen) {
        LOGE("set args pipe size failed, errno=%d", errno);
        return SCD_ERR_CODE_FCNTL;
    }

    //write args to pipe
    struct iovec iovs[1] = {
        {.iov_base = &scdArgs, .iov_len = sizeof(ScdProcessArgs)}
    };
    int32_t iovsCnt = 1;
    ssize_t ret = TRACE_UTIL_TEMP_FAILURE_RETRY(writev(pipeFd[1], iovs, iovsCnt));
    if (ret != writeLen) {
        LOGE("write args to pipe failed, ret=%ld, errno=%d.", ret, errno);
        return SCD_ERR_CODE_WRITEV;
    }
    if (TRACE_UTIL_TEMP_FAILURE_RETRY(dup2(pipeFd[0], STDIN_FILENO)) == -1) {
        LOGE("dup2 stdin failed, errno=%d.", errno);
        return SCD_ERR_CODE_DUP2;
    }
    (void)syscall(SYS_close, pipeFd[0]);
    (void)syscall(SYS_close, pipeFd[1]);

    if (execlp(info->exePath, STACKTRACE_DUMP_EXE, NULL) < 0) {
        LOGE("execlp stacktrace dumper process failed, path=%s, errno=%d.", info->exePath, errno);
        _exit(SCD_ERR_CODE_EXECLP);
    }
    return SCD_ERR_CODE_SUCCESS;
}

TraStatus ScExecStart(void *stack, ThreadArgument *args, int32_t *pid)
{
    if (stack == NULL) {
        LOGE("stack for clone is null");
        return TRACE_FAILURE;
    }
    int32_t err = prctl(PR_SET_DUMPABLE, 1, 0, 0, 0);
    if (err != 0) {
        LOGE("set dumpable failed, errno=%d", errno);
        return TRACE_FAILURE;
    }
    const int32_t child = clone(ScExecEntry, stack, CLONE_VFORK | CLONE_FS | CLONE_UNTRACED, args, NULL, NULL, NULL);
    if (child == -1) {
        STACKTRACE_LOG_ERR("clone failed, errno=%d", errno);
        return TRACE_FAILURE;
    }
    *pid = child;
    STACKTRACE_LOG_RUN("create sub process, pid=%d", child);
    err = prctl(PR_SET_PTRACER, child, 0, 0, 0);
    if (err != 0) {
        STACKTRACE_LOG_ERR("set ptracer failed, child=%d, errno=%d", child, errno);
    } else {
        LOGI("set ptracer successfully, child=%d", child);
        TraceStackRecorderInfo recordInfo = {args->crashTime, args->signo, args->pid, args->tid};
        TraStatus ret = TraceSafeMkdirPath(&recordInfo);
        if (ret != TRACE_SUCCESS) {
            LOGE("mkdir path failed, ret=%d.", ret);
        }
    }
    return TRACE_SUCCESS;
}

TraStatus ScExecEnd(int32_t pid)
{
    int32_t status = 0;
    int32_t ret = TRACE_UTIL_TEMP_FAILURE_RETRY(waitpid(pid, &status, __WALL));
    if (ret == -1) {
        STACKTRACE_LOG_ERR("waitpid failed, child=%d, errno=%d", pid, errno);
        return TRACE_FAILURE;
    }

    //check child process state
    if (WIFEXITED(status)) {
        int32_t exitStatus = WEXITSTATUS(status);
        STACKTRACE_LOG_RUN("get sub process result(%d).", exitStatus);
        if (exitStatus == 0) {
            LOGR("child %d exited normally with zero", pid);
            return TRACE_SUCCESS;
        } else {
            LOGE("child %d exited normally with non-zero exit status(%d)", pid, exitStatus);
        }
    } else if (WIFSIGNALED(status)) {
        int32_t signalNum = WTERMSIG(status);
        STACKTRACE_LOG_RUN("sub process exited by signal, signal(%d).", signalNum);
        LOGE("child %d exited by signal %d", pid, signalNum);
    } else {
        LOGE("child %d did not exit normally", pid);
    }

    return TRACE_FAILURE;
}