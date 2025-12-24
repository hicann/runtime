/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stacktrace_signal.h"
#include <stdatomic.h>
#include "adiag_list.h"
#include "adiag_print.h"
#include "adiag_utils.h"
#include "trace_system_api.h"
#include "stacktrace_monitor.h"

#define TRACE_STACK_SIGNAL_ENV              "ASCEND_COREDUMP_SIGNAL"
#define TRACE_STACK_SIGNAL_ENV_LENGTH       256U
#define TRACE_STACK_SIGNAL_NONE             "none"
#define TRACE_STACK_SIGNAL_ALL              "all"
#define TRACE_STACK_SIGNAL_SLEEP            100000U  // 100ms

typedef struct {
    TraceSignalHandle func;
    const void *data;
} TraceSigFuncNode;
struct TraceSigAction {
    bool registerFlag; // has registered to system or not
    int32_t signo; // signal number
    TraceSignalHandle callbackFunc;
    struct sigaction sigAct; // the new action for signo
    struct sigaction oldSigAct; // the previous action for signo
};

struct TraceSigMgr {
    uint64_t timeStamp; // timestamp of signal handle callback
    atomic_bool exitFlag; // exit is running or not
    atomic_bool handleFlag; // signal_handle is running or not
    int32_t handlePid; // signal_handle is running in which process
    struct TraceSigAction sigAct[REGISTER_SIGNAL_NUM];
};

STATIC struct TraceSigMgr g_sigMgr = {
    .timeStamp = 0,
    .exitFlag = false,
    .handleFlag = false,
    .sigAct = {
        {.registerFlag = false, .signo = SIGINT  }, // 2
        {.registerFlag = false, .signo = SIGTERM }, // 15
        {.registerFlag = false, .signo = SIGQUIT }, // 3
        {.registerFlag = false, .signo = SIGILL  }, // 4
        {.registerFlag = false, .signo = SIGTRAP }, // 5
        {.registerFlag = false, .signo = SIGABRT }, // 6
        {.registerFlag = false, .signo = SIGBUS  }, // 7
        {.registerFlag = false, .signo = SIGFPE  }, // 8
        {.registerFlag = false, .signo = SIGSEGV }, // 11
        {.registerFlag = false, .signo = SIGXCPU }, // 24
        {.registerFlag = false, .signo = SIGXFSZ }, // 25
        {.registerFlag = false, .signo = SIGSYS  }, // 31
        {.registerFlag = false, .signo = SIG_ATRACE  }  // 35
        }
};

/**
 * @brief       : set timestamp
 * @return      : NA
 */
STATIC void TraceSignalSetTime(void)
{
    uint64_t signalTime = GetRealTime();
    if (g_sigMgr.timeStamp == 0) {
        g_sigMgr.timeStamp = signalTime;
    }
}

/**
 * @brief       : check function is enabled or not
 * @return      : true  enable; false  disable
 */
STATIC bool TraceSignalCheckEnv(void)
{
    char envSignal[TRACE_STACK_SIGNAL_ENV_LENGTH] = { 0 };
    const char *env = NULL;
    MM_SYS_GET_ENV(MM_ENV_ASCEND_COREDUMP_SIGNAL, (env));
    TraStatus ret = TraceHandleEnvString(env, envSignal, TRACE_STACK_SIGNAL_ENV_LENGTH);
    if (ret != TRACE_SUCCESS) {
        return true;
    }
    if (strcmp(envSignal, TRACE_STACK_SIGNAL_NONE) == 0) {
        ADIAG_RUN_INF("get env %s = %s, close the signal capture function",
            TRACE_STACK_SIGNAL_ENV, TRACE_STACK_SIGNAL_NONE);
        return false;
    } else {
        ADIAG_WAR("env %s is invalid, use default signal capture function.", TRACE_STACK_SIGNAL_ENV);
    }
    return true;
}

/**
 * @brief       signal handler function to register
 * @param [in]  signo:      signo, set by system
 * @param [in]  siginfo:    signo info, set by system
 * @param [in]  ucontext:      no use
 * @return      NA
 */
STATIC void TraceSignalHandler(int32_t signo, siginfo_t *siginfo, void *ucontext)
{
    STACKTRACE_LOG_RUN("receive signal(%d).", signo);
    TraceSignalSetTime();
    StacktraceMonitorStartUpdate();
    TraceSignalInfo info = { signo, siginfo, ucontext, g_sigMgr.timeStamp };
    for (uint32_t i = 0; i < REGISTER_SIGNAL_NUM; i++) {
        if ((signo != g_sigMgr.sigAct[i].signo) || (g_sigMgr.sigAct[i].registerFlag != true)) {
            continue;
        }
        LOGR("start to callback signal %d", signo);
        if (g_sigMgr.sigAct[i].callbackFunc != NULL) {
            g_sigMgr.sigAct[i].callbackFunc(&info);
        }
        if (signo == SIG_ATRACE) {
            return;
        }
#ifdef ENABLE_SCD
        StackcoreLogSave(); // no need to save if receive SIG_ATRACE
#endif
        // recover the signal handler
        if (sigaction(g_sigMgr.sigAct[i].signo, &g_sigMgr.sigAct[i].oldSigAct, NULL) < 0) {
            g_sigMgr.sigAct[i].registerFlag = false;
            return;
        }
        (void)TraceRaise(signo);
    }
}

/**
 * @brief       add func to signal list
 * @param [in]  signo:      signo array
 * @param [in]  size:       size of array
 * @param [in]  func:       func pointer
 * @return      TraStatus
 */
TraStatus TraceSignalAddFunc(const int32_t *signo, uint32_t size, TraceSignalHandle func)
{
    for (uint32_t i = 0 ; i < size; i++) {
        for (uint32_t j = 0; j < REGISTER_SIGNAL_NUM; j++) {
            if (signo[i] != g_sigMgr.sigAct[j].signo) {
                continue;
            }

            g_sigMgr.sigAct[j].callbackFunc = func;
        }
    }
    return TRACE_SUCCESS;
}

#ifdef ATRACE_API
/**
 * @brief       register signal callback to system
 * @return      TraStatus
 */
STATIC TraStatus TraceSignalRegister(void)
{
    for (uint32_t i = 0; i < REGISTER_SIGNAL_NUM; i++) {
        if (sigaction(g_sigMgr.sigAct[i].signo, &g_sigMgr.sigAct[i].sigAct, &g_sigMgr.sigAct[i].oldSigAct) < 0) {
            ADIAG_ERR("register signal handler for signal %d failed, info: %s",
                g_sigMgr.sigAct[i].signo, strerror(AdiagGetErrorCode()));
            return TRACE_FAILURE;
        }
        ADIAG_INF("register signal handler for signal %d succeed.", g_sigMgr.sigAct[i].signo);
        g_sigMgr.sigAct[i].registerFlag = true;
    }
    ADIAG_INF("trace signal init succeed.");
    return TRACE_SUCCESS;
}

/**
 * @brief       recover old signal callback
 * @return      TraStatus
 */
STATIC void TraceSignalUnregister(void)
{
    for (uint32_t i = 0; i < REGISTER_SIGNAL_NUM; i++) {
        if (!g_sigMgr.sigAct[i].registerFlag) {
            continue;
        }
        if (sigaction(g_sigMgr.sigAct[i].signo, &g_sigMgr.sigAct[i].oldSigAct, NULL) < 0) {
            ADIAG_ERR("recover signal handler for signal %d failed, info: %s",
                g_sigMgr.sigAct[i].signo, strerror(AdiagGetErrorCode()));
        }
        g_sigMgr.sigAct[i].registerFlag = false;
    }
    ADIAG_RUN_INF("unregister all signal handlers, can not capture signal.");
}
#else
STATIC TraStatus TraceSignalRegister(void)
{
    return TRACE_SUCCESS;
}

STATIC void TraceSignalUnregister(void)
{
    return;
}
#endif

bool TraceSignalCheckExit(void)
{
    return atomic_load(&g_sigMgr.exitFlag);
}

void TraceSignalSetHandleFlag(bool value)
{
    g_sigMgr.handlePid = getpid();
    atomic_store(&g_sigMgr.handleFlag, value);
}

TraStatus TraceSignalInit(void)
{
    for (uint32_t i = 0; i < REGISTER_SIGNAL_NUM; i++) {
        struct TraceSigAction *sigAct = &g_sigMgr.sigAct[i];
        (void)memset_s(&sigAct->sigAct, sizeof(struct sigaction), 0, sizeof(struct sigaction));
        (void)sigemptyset(&(sigAct->sigAct.sa_mask));
        sigAct->sigAct.sa_sigaction = TraceSignalHandler;
        sigAct->sigAct.sa_flags = SA_SIGINFO;
    }

    if (!TraceSignalCheckEnv()) {
        return TRACE_SUCCESS;
    }
    StacktraceMonitorInit();
    atomic_store(&g_sigMgr.exitFlag, false);
    TraceSignalSetHandleFlag(false);
    TraStatus ret = TraceSignalRegister();
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return ret, "trace register signal failed, ret=%d.", ret);
    return TRACE_SUCCESS;
}

void TraceSignalExit(void)
{
    atomic_store(&g_sigMgr.exitFlag, true);
    TraceSignalUnregister();
    StacktraceMonitorExit();
    // handle func is running, and is in handle process
    while (atomic_load(&g_sigMgr.handleFlag) && (g_sigMgr.handlePid == getpid())) {
        (void)usleep(TRACE_STACK_SIGNAL_SLEEP);
    }
}