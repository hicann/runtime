/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dumper_core.h"
#include <sys/wait.h>
#include <sys/ptrace.h>
#include <sys/prctl.h>
#include <pthread.h>
#include <sched.h>
#include <errno.h>
#include "stacktrace_fp.h"
#include "dumper_process.h"
#include "adiag_print.h"
#include "stacktrace_safe_recorder.h"
#include "stacktrace_parse.h"

#define SCD_RETRY_INTERVAL      (100 * 1000) // ms
#define PTRACE_MAX_RETRY_TIME   10
#define STACKTRACE_DUMP_MODE_1  0xAABB0001U
#define STACKTRACE_DUMP_MODE_2  0xAABB0002U
#define STACKTRACE_DUMP_MODE_3  0xAABB0003U

#define STACKTRACE_DUMP_EXE "asc_dumper"

#define TRACE_UTIL_TEMP_FAILURE_RETRY(exp) ({      \
            __typeof__(exp) rc;                    \
            do {                                   \
                errno = 0;                         \
                rc = (exp);                        \
            } while (rc == -1 && errno == EINTR);  \
            rc; })


STATIC TraStatus ScdCoreDumpAllThreads(const ThreadArgument *args)
{
    TraStatus ret = ScdProcessLoadAllThreads(args->pid, args->tid);
    if (ret != TRACE_SUCCESS) {
        LOGW("get thread info failed");
    }

    ScdProcessSuspendThreads(args->tid);
    ret = ScdProcessUnwindStack(args);
    ScdProcessResumeThreads();
    return ret;
}

STATIC TraStatus ScdCoreDumpSingleThread(const ThreadArgument *args)
{
    ScdProcessLoadSingleThread(args->pid, args->tid);

    ScdProcessSuspendThreads(args->tid);
    TraStatus ret = ScdProcessUnwindStack(args);
    ScdProcessResumeThreads();
    return ret;
}

STATIC TraStatus ScdCoreDumpData(const ThreadArgument *args)
{
    uint32_t mode = (uint32_t)args->siginfo.si_value.sival_int;
    int32_t signo = args->signo;
    LOGR("dump data, signo = %d, mode=%x", signo, mode);
    TraStatus ret = TRACE_FAILURE;
    if (signo != SIG_ATRACE || mode == STACKTRACE_DUMP_MODE_1) {
        ret = ScdCoreDumpAllThreads(args);
        const char* binFile = TraceSafeGetFilePath();
        LOGR("dump bin file by signo %d, mode = %x, bin file path [%s]", signo, mode, binFile);
#if defined _ADIAG_LLT_
        (void)TraceStackParse(binFile, strlen(binFile));
#else
        if (execlp(args->exePath, STACKTRACE_DUMP_EXE, binFile, NULL) < 0) {
            LOGE("execlp parse process failed, errno=%d.", errno);
            _exit(1);
        }
#endif
        return ret;
    }
    if (mode == STACKTRACE_DUMP_MODE_2) {
        ret = ScdCoreDumpSingleThread(args);
        LOGR("dump bin file by mode2, bin file path [%s]", TraceSafeGetFilePath());
        return ret;
    }
    if (mode == STACKTRACE_DUMP_MODE_3) {
        ret = ScdCoreDumpAllThreads(args);
        LOGR("dump bin file by mode3, bin file path [%s]", TraceSafeGetFilePath());
        return ret;
    }
    LOGE("invalid arg, signo=%d, mode=%x", signo, mode);

    return ret;
}

static void ScdCoreIgnSignal(int32_t sigNum)
{
    if (signal(sigNum, SIG_IGN) == SIG_ERR) {
        LOGW("ignoring signal %d failed, errno=%d.", sigNum, errno);
    }
}
STATIC int32_t ScdCoreEntry(void *args)
{
    LOGR("dumper process start.");
    ScdCoreIgnSignal(SIGINT);
    ScdCoreIgnSignal(SIGTERM);

    if (args == NULL) {
        LOGE("args is null.");
        return 1;
    }
    const ThreadArgument *info = (const ThreadArgument *)args;

    long err = 0;
    int32_t count = 0;
    do {
        count++;
        if (count > PTRACE_MAX_RETRY_TIME) {
            return 1; // attach failed
        }
        (void)usleep(SCD_RETRY_INTERVAL); // 100ms
        errno = 0;
        err = ptrace(PTRACE_ATTACH, info->pid, NULL, NULL);
        if ((err != 0) && (errno != 0)) {
            LOGW("can not ptrace, retry time(%d), errno=%d.", count, errno);
        }
    } while(err != 0);
    (void)DumperThreadWaitTidStopped(info->pid);

    // dump data to file
    (void)ptrace(PTRACE_DETACH, info->pid, NULL, NULL);
    TraStatus ret = ScdCoreDumpData(info);
    if (ret != TRACE_SUCCESS) {
        LOGE("unwind process failed, ret=%d.", ret);
        return 1;
    }
    LOGR("dumper process successfully.");
    return 0;
}

TraStatus ScdCoreStart(void *stack, ThreadArgument *args, pid_t *pid)
{
    int32_t err = prctl(PR_SET_DUMPABLE, 1, 0, 0, 0);
    if (err == -1) {
        LOGE("set dumpable failed, errno=%d", errno);
        return TRACE_FAILURE;
    }
    const pid_t child = clone(ScdCoreEntry, stack, (uint32_t)CLONE_VM | (uint32_t)CLONE_FS | (uint32_t)CLONE_UNTRACED,
        args, NULL, NULL, NULL);
    if (child == -1) {
        LOGE("clone failed, errno=%d", errno);
        return TRACE_FAILURE;
    }
    *pid = child;
    err = prctl(PR_SET_PTRACER, child, 0, 0, 0);
    if (err == -1) {
        LOGE("set ptracer failed, child=%d, errno=%d", child, errno);
    } else {
        LOGI("set ptracer successfully, child=%d", child);
    }
    return TRACE_SUCCESS;
}

TraStatus ScdCoreEnd(pid_t pid)
{
    int32_t status = 0;
    int32_t ret = TRACE_UTIL_TEMP_FAILURE_RETRY(waitpid(pid, &status, __WALL));
    if (ret == -1) {
        LOGE("waitpid failed, child=%d, errno=%d", pid, errno);
        return TRACE_FAILURE;
    }

    //check child process state
    if (WIFEXITED(status)) {
        int32_t exitStatus = WEXITSTATUS(status);
        if (exitStatus == 0) {
            LOGI("child %d exited normally with zero", pid);
            return TRACE_SUCCESS;
        } else {
            LOGE("child %d exited normally with non-zero exit status(%d)", pid, exitStatus);
        }
    } else {
        LOGE("child %d did not exit normally", pid);
    }

    return TRACE_FAILURE;
}