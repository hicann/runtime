/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stacktrace_dumper.h"
#include <stdatomic.h>
#include <pthread.h>
#include <sys/ptrace.h>
#include "securec.h"
#include "stacktrace_signal.h"
#include "stacktrace_fp.h"
#include "stacktrace_logger.h"
#include "trace_system_api.h"
#include "trace_recorder.h"
#include "dumper_core.h"
#include "adiag_print.h"
#include "adiag_utils.h"
#include "stacktrace_unwind_reg.h"
#include "stacktrace_safe_recorder.h"
#ifdef ENABLE_SCD
#include "stacktrace_exec.h"
#endif

#define SCD_CRASH_CHILD_STACK_LEN (16U * 1024U)
#ifndef SCD_EXE_RELATIVE_PATH
#define SCD_EXE_RELATIVE_PATH   "/../bin/asc_dumper"
#endif

typedef struct {
    DumperCallback func; // func registered by tracer
    void *arg; // argument for func
} TracerCallback;

typedef struct {
    uint8_t *stack; // dynamically applied address for the sub-process
    uint32_t stackSize; // size of stack
    atomic_flag done; // func has been executed or not
    TracerCallback tracer; // info of tracer callback
    ThreadArgument args; // argument for the sub-process
    pthread_mutex_t mutex;
} StackTraceDumperMgr;
STATIC StackTraceDumperMgr g_dumperMgr = { 0 };

TraStatus TraceDumperSetCallback(DumperCallback func, void *arg)
{
    if ((func == NULL) || (arg == NULL)) {
        ADIAG_ERR("set callback to dumper failed.");
        return TRACE_INVALID_PARAM;
    }
    g_dumperMgr.tracer.func = func;
    g_dumperMgr.tracer.arg = arg;
    return TRACE_SUCCESS;
}

STATIC TraStatus DumperExecuteCallback(uint64_t timeStamp)
{
    if ((g_dumperMgr.tracer.func == NULL) || (g_dumperMgr.tracer.arg == NULL)) {
        return TRACE_INVALID_PARAM;
    }

    TraStatus ret = g_dumperMgr.tracer.func(g_dumperMgr.tracer.arg, timeStamp);
    return ret;
}

STATIC TraStatus DumperSignalSetArgs(const TraceSignalInfo* info)
{
    errno_t err = memcpy_s(&(g_dumperMgr.args.siginfo), sizeof(siginfo_t), info->siginfo, sizeof(siginfo_t));
    if (err != EOK) {
        LOGE("memcpy signal info failed, ret=%d.", (int32_t)err);
        return TRACE_FAILURE;
    }
    err = memcpy_s(&(g_dumperMgr.args.ucontext), sizeof(ucontext_t), info->ucontext, sizeof(ucontext_t));
    if (err != EOK) {
        LOGE("memcpy context failed, ret=%d.", (int32_t)err);
        return TRACE_FAILURE;
    }
    // set file path
    int32_t pid = getpid();
    int32_t tid = (int32_t)syscall(__NR_gettid);
    TraceStackRecorderInfo recordInfo = {info->timeStamp, info->signo, pid, tid};
    TraStatus ret = TraceSafeGetDirPath(&recordInfo, g_dumperMgr.args.filePath, SCD_MAX_FILEPATH_LEN + 1U);
    if (ret != TRACE_SUCCESS) {
        LOGE("get dir path failed, ret=%d.", ret);
        return TRACE_FAILURE;
    }
    ret = TraceSafeGetFileName(&recordInfo, g_dumperMgr.args.fileName, SCD_MAX_FILENAME_LEN + 1U);
    if (ret != TRACE_SUCCESS) {
        LOGE("get file name failed, ret=%d.", ret);
        return TRACE_FAILURE;
    }
    StacktraceLogSetPath(g_dumperMgr.args.filePath, g_dumperMgr.args.fileName);
    g_dumperMgr.args.crashTime = info->timeStamp;
    g_dumperMgr.args.pid = pid;
    g_dumperMgr.args.tid = tid;
    g_dumperMgr.args.signo = info->signo;

    return TRACE_SUCCESS;
}

STATIC TraStatus DumperSignalHandler(const TraceSignalInfo *arg)
{
    LOGR("pid[%d] tid[%ld] start to handle signal.", getpid(), syscall(__NR_gettid));
#if !defined (__aarch64__) && !defined (__x86_64__)
    return TRACE_FAILURE;
#endif
    if (g_dumperMgr.stack == NULL) {
        return TRACE_FAILURE;
    }
    if (arg == NULL) {
        return TRACE_FAILURE;
    }
    const TraceSignalInfo* info = (const TraceSignalInfo *)arg;
    if ((info->ucontext == NULL) || (info->siginfo == NULL)) {
        return TRACE_FAILURE;
    }

    // if sub process receive signal, return and continue to handle signal
    if ((info->signo != SIG_ATRACE) && (g_dumperMgr.args.pid != 0) && (g_dumperMgr.args.pid != getpid())) {
        (void)ptrace(PTRACE_DETACH, g_dumperMgr.args.pid, NULL, NULL); // if sub process receive signal, detach crash pid
        LOGW("current_pid[%d], crash_pid[%d].", getpid(), g_dumperMgr.args.pid);
        return TRACE_FAILURE;
    }

    // if crash thread receive signal(B) again when handler signal(A), return and continue to handle signal(A)
    if ((g_dumperMgr.args.tid != 0) && (g_dumperMgr.args.tid == syscall(__NR_gettid))) {
        LOGW("current_tid[%ld], crash_tid[%d].", syscall(__NR_gettid), g_dumperMgr.args.tid);
        return TRACE_FAILURE;
    }

    (void)pthread_mutex_lock(&g_dumperMgr.mutex);
    // dumper process
    if (DumperSignalSetArgs(info) != TRACE_SUCCESS) {
        (void)pthread_mutex_unlock(&g_dumperMgr.mutex);
        return TRACE_FAILURE;
    }

    TraceSignalSetHandleFlag(true);
    if (TraceSignalCheckExit()) {
        LOGW("pid[%d] tid[%ld] exit is running, can not handle signal.", g_dumperMgr.args.pid, g_dumperMgr.args.tid);
        TraceSignalSetHandleFlag(false);
        (void)pthread_mutex_unlock(&g_dumperMgr.mutex);
        return TRACE_FAILURE;
    }

    pid_t child = -1;
#ifdef ENABLE_SCD
    TraStatus ret = ScExecStart((void *)(g_dumperMgr.stack + g_dumperMgr.stackSize), &g_dumperMgr.args, &child);
#else
    TraStatus ret = ScdCoreStart((void *)(g_dumperMgr.stack + g_dumperMgr.stackSize), &g_dumperMgr.args, &child);    
#endif
    if (ret == TRACE_SUCCESS) {
        LOGI("dumper start successfully, pc=0x%lx, sp=0x%lx, fp=0x%lx.",
            GET_PCREG_FROM_CONTEXT(&(g_dumperMgr.args.ucontext.uc_mcontext)),
            GET_SPREG_FROM_CONTEXT(&(g_dumperMgr.args.ucontext.uc_mcontext)),
            GET_FPREG_FROM_CONTEXT(&(g_dumperMgr.args.ucontext.uc_mcontext)));
#ifdef ENABLE_SCD
        ret = ScExecEnd(child);
#else
        ret = ScdCoreEnd(child);
#endif
    }

    // tracer process, only once
    if (atomic_flag_test_and_set(&g_dumperMgr.done)) {
        LOGI("signal handler has been executed.");
    } else {
        (void)DumperExecuteCallback(info->timeStamp);
    }
    // fp process
    if (ret != TRACE_SUCCESS) {
        LOGW("dumper process can not handle signal, directly derivation stack.");
        ret = TraceStackSigHandler(&g_dumperMgr.args);
    }
    TraceSignalSetHandleFlag(false);
    (void)pthread_mutex_unlock(&g_dumperMgr.mutex);
    g_dumperMgr.args.tid = 0;
    return ret;
}

/**
 * @brief       : get stack start addr
 */
STATIC uintptr_t TraceGetStackBaseAddr(void)
{
    pthread_attr_t attr;
    void *stackAddr = NULL;
    size_t stackSize = 0;

    (void)memset_s(&attr, sizeof(pthread_attr_t), 0, sizeof(pthread_attr_t));
    int32_t ret = pthread_getattr_np(pthread_self(), &attr);
    if (ret != 0) {
        return 0;
    }
    (void)pthread_attr_getstack(&attr, &stackAddr, &stackSize);
    (void)pthread_attr_destroy(&attr);
    return (uintptr_t)stackAddr + (uintptr_t)stackSize;
}

/**
 * @brief       : get bin path by library path
 */
STATIC TraStatus TraceGetExePath(char *path, uint32_t len)
{
    char realPath[TRACE_MAX_PATH] = { 0 };
    char fullPath[TRACE_MAX_PATH] = { 0 };
    mmDlInfo dlInfo = { 0 };
    if (mmDladdr((void *)(&TraceGetExePath), &dlInfo) != EN_OK) {
        ADIAG_ERR("dladdr library failed, error: %s", mmDlerror());
        return TRACE_FAILURE;
    }
    if ((TraceRealPath(dlInfo.dli_fname, fullPath, TRACE_MAX_PATH) != EN_OK) && (AdiagGetErrorCode() != ENOENT)) {
        ADIAG_ERR("can not get realpath, path=%s, strerr=%s.", dlInfo.dli_fname, strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }

    char *pos = strrchr(fullPath, '/');
    if (pos == NULL) {
        ADIAG_ERR("check path failed, path=%s.", fullPath);
        return TRACE_FAILURE;
    }

    errno_t err = strncpy_s(pos, TRACE_MAX_PATH - (pos - fullPath), SCD_EXE_RELATIVE_PATH, strlen(SCD_EXE_RELATIVE_PATH));
    if (err != EOK) {
        ADIAG_ERR("strncpy_s failed.");
        return TRACE_FAILURE;
    }
    if ((TraceRealPath(fullPath, realPath, TRACE_MAX_PATH) != EN_OK) && (AdiagGetErrorCode() != ENOENT)) {
        ADIAG_ERR("can not get realpath, path=%s, strerr=%s.", fullPath, strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }
    err = strncpy_s(path, len, realPath, strlen(realPath));
    if (err != EOK) {
        ADIAG_ERR("strncpy_s failed, path = %s.", realPath);
        return TRACE_FAILURE;
    }

    ADIAG_INF("path = %s", path);
    LOGR("path = %s", path);
    return TRACE_SUCCESS;
}

TraStatus TraceDumperInit(void)
{
    if (g_dumperMgr.stack != NULL) {
        ADIAG_INF("stacktrace dumper has been initialized.");
        return TRACE_SUCCESS;
    }
    uint8_t *stack = AdiagMalloc(SCD_CRASH_CHILD_STACK_LEN);
    if (stack == NULL) {
        ADIAG_ERR("stacktrace dumper malloc for stack failed, size=%u bytes.", SCD_CRASH_CHILD_STACK_LEN);
        return TRACE_FAILURE;
    }
    g_dumperMgr.stack = stack;
    g_dumperMgr.stackSize = SCD_CRASH_CHILD_STACK_LEN;
    g_dumperMgr.args.stackBaseAddr = TraceGetStackBaseAddr();
    TraStatus ret = TraceGetExePath(g_dumperMgr.args.exePath, MAX_BIN_PATH_LEN);
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return ret, "get bin path failed, ret=%d.", ret);
    atomic_flag_clear(&g_dumperMgr.done);

    ret = StacktraceLogInit(STACKTRACE_LOG_TITLE_MAIN);
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return ret, "stacktrace log init failed, ret=%d.", ret);

    int32_t signo[REGISTER_SIGNAL_NUM] = { SIGINT, SIGTERM,
        SIGQUIT, SIGILL, SIGTRAP, SIGABRT, SIGBUS, SIGFPE, SIGSEGV, SIGXCPU, SIGXFSZ, SIGSYS, SIG_ATRACE };
    ret = TraceSignalAddFunc(signo, REGISTER_SIGNAL_NUM, DumperSignalHandler);
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return ret, "stacktrace dumper add func failed, ret=%d.", ret);
    return TRACE_SUCCESS;
}

void TraceDumperExit(void)
{
    StackcoreLogExit();
    if (g_dumperMgr.stack != NULL) {
        ADIAG_SAFE_FREE(g_dumperMgr.stack);
    }
    (void)memset_s(&g_dumperMgr.args, sizeof(ThreadArgument), 0, sizeof(ThreadArgument));
}