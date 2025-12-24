/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stacktrace_monitor.h"
#include "stacktrace_unwind.h"
#include "adiag_print.h"
#include "mmpa_api.h"
typedef void (*ThreadAtFork)(void);

#define STACKTRACE_SLEEP_PERIOD  100000U  // 100ms
#define STACKTRACE_UPDATE_PERIOD 100U     // 0.1s * 100 = 10s
#define STACKTRACE_THREAD_STACK_SIZE     128 * 1024
#define THREAD_STATUS_INIT          0
#define THREAD_STATUS_RUN           1
#define THREAD_STATUS_WAIT_EXIT     2

#define STACKTRACE_UPDATE_STATUS_INIT    0U
#define STACKTRACE_UPDATE_STATUS_START   1U
#define STACKTRACE_UPDATE_STATUS_FINISH  2U

static int32_t g_stacktraceMonitorThreadStatus = THREAD_STATUS_INIT;

static mmThread g_stacktraceMonitorPthreadId = 0;
static pid_t g_stacktraceMonitorthreadId = 0;
static uint32_t g_stacktraceUpdateStatus;
static bool g_forking = false;
STATIC pthread_mutex_t g_forkMutex = PTHREAD_MUTEX_INITIALIZER;


void StacktraceMonitorStartUpdate(void)
{
    g_stacktraceUpdateStatus = STACKTRACE_UPDATE_STATUS_START;
}

pid_t StacktraceMonitorGetTid(void)
{
    return g_stacktraceMonitorthreadId;
}

bool StacktraceCheckUpdateFinished(void)
{
    return (g_stacktraceUpdateStatus == STACKTRACE_UPDATE_STATUS_FINISH);
}

static void *StacktraceMonitorProcess(void *arg)
{
    (void)arg;
    g_stacktraceMonitorthreadId = (pid_t)syscall(SYS_gettid);
    (void)mmSetCurrentThreadName("AtraceMonitor");
    while (g_stacktraceMonitorThreadStatus == THREAD_STATUS_RUN) {
        (void)usleep(STACKTRACE_SLEEP_PERIOD);
        if (g_stacktraceUpdateStatus == STACKTRACE_UPDATE_STATUS_START) {
            // ensure dl_iterate_phdr is not being called when fork
            (void)pthread_mutex_lock(&g_forkMutex);
            TraceStackUnwindInit();
            (void)pthread_mutex_unlock(&g_forkMutex);
            
            g_stacktraceUpdateStatus = STACKTRACE_UPDATE_STATUS_FINISH;
        }
    }
    return NULL;
}

static TraStatus StacktraceCreateMonitorThread(void)
{
    mmUserBlock_t thread;
    thread.procFunc = StacktraceMonitorProcess;
    thread.pulArg = NULL;
    mmThreadAttr attr = { 0, 0, 0, 0, 0, 0, STACKTRACE_THREAD_STACK_SIZE };
    mmThread tid = 0;
    if (mmCreateTaskWithThreadAttr(&tid, &thread, &attr) != 0) {
        ADIAG_ERR("create task failed, strerr=%s.", strerror(errno));
        return TRACE_FAILURE;
    }
    g_stacktraceMonitorPthreadId = tid;
    return TRACE_SUCCESS;
}

static void StacktraceMonitorThreadInit(void)
{
    g_stacktraceMonitorThreadStatus = THREAD_STATUS_RUN;
    g_stacktraceUpdateStatus = STACKTRACE_UPDATE_STATUS_INIT;
    TraStatus ret = StacktraceCreateMonitorThread();
    if (ret != TRACE_SUCCESS) {
        // call unwind  in case thread creation fails
        g_stacktraceMonitorPthreadId = 0;
        ADIAG_ERR("Create monitor thread failed");
        return;
    }
}

static void StacktraceSubProcessInit(void)
{
    if (!g_forking) {
        // sub process has been initialized
        return;
    }
    (void)pthread_mutex_unlock(&g_forkMutex);
    g_stacktraceMonitorThreadStatus = THREAD_STATUS_WAIT_EXIT;
    StacktraceMonitorThreadInit();
    g_forking = false;
}

STATIC void StacktraceProcessUnInit(void)
{
    if (g_forking) {
        return;
    }
    (void)pthread_mutex_lock(&g_forkMutex);
    g_forking = true; // set forking to true to avoid repeat uninit and init
}

STATIC void StacktraceProcessInit(void)
{
    g_forking = false;
    (void)pthread_mutex_unlock(&g_forkMutex);
}

static void StacktracePrepareForFork(void)
{
    int32_t ret = pthread_atfork((ThreadAtFork)StacktraceProcessUnInit, (ThreadAtFork)StacktraceProcessInit,
        (ThreadAtFork)StacktraceSubProcessInit);
    if (ret != 0) {
        ADIAG_WAR("can not call pthread_atfork, ret=%d", ret);
    }
}

void StacktraceMonitorInit(void)
{
    StacktracePrepareForFork();
    StacktraceMonitorThreadInit();
}

void StacktraceMonitorExit(void)
{
    if (g_stacktraceMonitorThreadStatus != THREAD_STATUS_RUN) {
        return;
    }
    g_stacktraceMonitorThreadStatus = THREAD_STATUS_WAIT_EXIT;
    if (g_stacktraceMonitorPthreadId != 0) {
        (void)mmJoinTask(&g_stacktraceMonitorPthreadId);
        g_stacktraceMonitorPthreadId = 0;
        g_stacktraceMonitorthreadId = 0;
    }
}