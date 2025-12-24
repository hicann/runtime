/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dumper_process.h"
#include <dirent.h>
#include <unistd.h>
#include <sys/syscall.h>
#include "adiag_utils.h"
#include "trace_types.h"
#include "trace_system_api.h"
#include "stacktrace_unwind.h"
#include "stacktrace_fp.h"
#include "stacktrace_monitor.h"
#define STACKTRACE_SLEEP_PERIOD  10000U // 10ms
#define STACKTRACE_WAIT_UPDATE_TIMEOUT 100U // 0.01s * 100 = 1s
#define STACKTRACE_DIR_BUF_LEN 1024U

static ScdThreadMgr g_threadMgr = { 0 };


void ScdProcessLoadSingleThread(pid_t crashPid, pid_t crashTid)
{
    (void)memset_s(&g_threadMgr, sizeof(ScdThreadMgr), 0, sizeof(ScdThreadMgr));
    LOGI("crash pid[%d] crash tid[%d]", crashPid, crashTid);
    g_threadMgr.crashPid = crashPid;
    g_threadMgr.crashTid = crashTid;
    // set crash tid at first
    g_threadMgr.threadTid[0] = crashTid;
    g_threadMgr.threadNum = 1U;
}

TraStatus ScdProcessLoadAllThreads(pid_t crashPid, pid_t crashTid)
{
    char path[CORE_BUFFER_LEN] = { 0 };
    char direntBuf[STACKTRACE_DIR_BUF_LEN] = { 0 };
    struct dirent *ent = NULL;
    uint32_t threadIdx = 0;

    (void)memset_s(&g_threadMgr, sizeof(ScdThreadMgr), 0, sizeof(ScdThreadMgr));
    LOGI("crash pid[%d] crash tid[%d]", crashPid, crashTid);
    g_threadMgr.crashPid = crashPid;
    g_threadMgr.crashTid = crashTid;
    // set crash tid at first
    g_threadMgr.threadTid[threadIdx] = crashTid;
    threadIdx++;
    g_threadMgr.threadNum = threadIdx;

    int32_t ret = snprintf_s(path, sizeof(path), sizeof(path) - 1U, "/proc/%d/task", crashPid);
    if (ret == -1) {
        LOGE("snprintf_s task path failed");
        return TRACE_FAILURE;
    }

    int32_t fd = open(path, (uint32_t)O_RDONLY | (uint32_t)O_DIRECTORY);
    if (fd == -1) {
        LOGE("open dir failed, crash pid=%d, errno=%d", crashPid, errno);
        return TRACE_FAILURE;
    }

    while (1) {
        int64_t nRead = syscall(SYS_getdents64, fd, direntBuf, STACKTRACE_DIR_BUF_LEN);
        if (nRead <= 0) {
            break;
        }

        int64_t pos = 0;
        while ((pos < nRead) && (threadIdx < MAX_THREAD_NUM)) {
            ent = (struct dirent *)(direntBuf + pos);
            if ((strcmp(ent->d_name, ".") != 0) && (strcmp(ent->d_name, "..") != 0)) {
                pid_t tid = 0;
                if ((AdiagStrToInt(ent->d_name, &tid) == TRACE_SUCCESS) && (tid != crashTid)) {
                    g_threadMgr.threadTid[threadIdx] = tid;
                    threadIdx++;
                }
            }

            pos += (int64_t)ent->d_reclen;
        }
    }

    TraceClose(&fd);

    AdiagQuickSort(g_threadMgr.threadTid, 1, (int32_t)threadIdx - 1);
    g_threadMgr.threadNum = threadIdx;

    return TRACE_SUCCESS;
}

void ScdProcessSuspendThreads(pid_t crashTid)
{
    uint32_t threadNum = g_threadMgr.threadNum;
    pid_t tid = 0;
    pid_t monitorTid = StacktraceMonitorGetTid();
    for (uint32_t threadIdx = 0; threadIdx < threadNum; threadIdx++) {
        tid = g_threadMgr.threadTid[threadIdx];
        if (tid != monitorTid) {
            (void)DumperThreadSuspend(tid);
        }
    }
    if (monitorTid == crashTid) {
        (void)DumperThreadSuspend(monitorTid);
        return;
    }
    LOGI("wait load info update start, tid %d", monitorTid);
    uint32_t cnt = 0;
    while (!StacktraceCheckUpdateFinished()) {
        (void)usleep(STACKTRACE_SLEEP_PERIOD);
        cnt++;
        if (cnt > STACKTRACE_WAIT_UPDATE_TIMEOUT) {
            LOGW("wait load info update timeout");
            break;
        }
    }
    LOGI("wait load info update finish, cnt %u", cnt);
    (void)DumperThreadSuspend(monitorTid);
}

void ScdProcessResumeThreads(void)
{
    uint32_t threadNum = g_threadMgr.threadNum;
    pid_t tid = 0;
    for (uint32_t threadIdx = 0; threadIdx < threadNum; threadIdx++) {
        tid = g_threadMgr.threadTid[threadIdx];
        DumperThreadResume(tid);
    }
}

static TraStatus ScdProcessWriteProcessInfo(const ThreadArgument *arg)
{
    uintptr_t sp = 0;
    const mcontext_t *mcontext = &(arg->ucontext.uc_mcontext);
    if (mcontext != NULL) {
        sp = GET_SPREG_FROM_CONTEXT(mcontext);
    }

    TraceStackProcessInfo info = { arg->signo, arg->pid, arg->tid, arg->crashTime, arg->stackBaseAddr, sp };
    return TraceSaveProcessInfo(&info);
}

static TraStatus ScdProcessWriteStackInfo(uint32_t threadIdx, const ThreadArgument *arg)
{
    TraceStackInfo *stackInfo = TraceSafeGetStackBuffer();
    uintptr_t regs[TRACE_CORE_REG_NUM] = { 0 };
    (void)memset_s(stackInfo, sizeof(TraceStackInfo), 0, sizeof(TraceStackInfo));
    pid_t pid = arg->pid;
    pid_t tid = g_threadMgr.threadTid[threadIdx];
    stackInfo->threadIdx = threadIdx;
    stackInfo->threadTid = tid;
    DumperThreadGetName(pid, tid, stackInfo->threadName, THREAD_NAME_LEN);

    LOGI("thread index[%u] is %d", threadIdx, tid);
    // get register info
    TraStatus ret = TRACE_SUCCESS;
    if (tid == g_threadMgr.crashTid) {
        const ucontext_t *utext = &arg->ucontext;
        const mcontext_t *mcontext = (const mcontext_t *)&(utext->uc_mcontext);
        GET_REGISTER_FROM_CONTEXT(regs, mcontext);
        (void)TraceSaveProcessReg(regs, (uint32_t)sizeof(regs));
    } else {
        uintptr_t regBuf[TRACE_CORE_REG_NUM + 1U] = { 0 }; //big enough for all architectures
        ret = DumperThreadGetRegs(tid, regBuf, TRACE_CORE_REG_NUM + 1U);
        if (ret != TRACE_SUCCESS) {
            LOGW("can not get thread %d regs, ret=%d.", tid, ret);
            return ret;
        }
        GET_REGISTER_FROM_PTRACE(regs, regBuf);
    }

    // derivation stack
#if defined(ENABLE_UNWIND)
    ret = TraceStackUnwind(arg, regs, TRACE_CORE_REG_NUM, stackInfo);
#else
    ret = TRACE_FAILURE;
#endif
    if (ret != TRACE_SUCCESS && tid == g_threadMgr.crashTid) {
        LOGW("can not derivation thread %d stack by unwind, ret=%d.", tid, ret);
        ret = TraceStackFp(arg, regs, TRACE_CORE_REG_NUM, stackInfo);
        if (ret != TRACE_SUCCESS) {
            LOGW("can not derivation thread %d stack by fp, ret=%d.", tid, ret);
        }
    }

    return TraceSaveStackInfo(stackInfo);
}

TraStatus ScdProcessUnwindStack(const ThreadArgument *arg)
{
    int32_t fd = -1;
    TraceStackRecorderInfo info = {arg->crashTime, arg->signo, arg->pid, arg->tid};
    TraStatus ret = TraceSafeGetFd(&info, TRACE_FILE_BIN_SUFFIX, &fd);
    if (ret != TRACE_SUCCESS) {
        LOGE("get fd failed.");
        return TRACE_FAILURE;
    }

    ret = ScdProcessWriteProcessInfo(arg);
    if (ret != TRACE_SUCCESS) {
        LOGW("can not write process info to file, ret=%d.", ret);
    }

    uint32_t threadNum = g_threadMgr.threadNum;
    LOGI("thread num = %d", threadNum);
    for (uint32_t threadIdx = 0; threadIdx < threadNum; threadIdx++) {
        ret = ScdProcessWriteStackInfo(threadIdx, arg);
        if (ret != TRACE_SUCCESS) {
            LOGW("can not write stack info to file, ret=%d.", ret);
        }
    }
    (void)TraceSafeWriteBuff(fd);
    ret = TraceSafeWriteSystemInfo(fd, arg->pid);
    if (ret != TRACE_SUCCESS) {
        LOGW("can not write system info to file, ret=%d.", ret);
    }
    TraceClose(&fd);
    LOGI("write stackcore file end.");
    return TRACE_SUCCESS;
}
