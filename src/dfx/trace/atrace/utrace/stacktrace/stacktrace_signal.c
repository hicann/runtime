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

// Dedicated alternate signal stack. A stack-overflow SIGSEGV exhausts the
// thread stack, so the handler must run on a separate stack (sigaltstack +
// SA_ONSTACK) to be able to capture the crash at all.
//
// Size basis: the crash handler here only does a short prologue (copy siginfo/
// ucontext into the global args, pipe/clone the asc_dumper sub-process, waitpid)
// — the heavy work (ptrace stack unwind, file write) runs in the asc_dumper
// child process, NOT on this stack. 64KB therefore comfortably exceeds
// MINSIGSTKSZ plus the handler's own frame needs. A fixed compile-time constant
// is used because on newer glibc SIGSTKSZ is a runtime sysconf value and cannot
// size a static array.
//
// Limitation (single shared stack): sigaltstack is per-thread, but a newly
// created thread inherits the parent's alt-stack *pointer*, so every thread in
// the host process points at this one buffer. Two threads crashing
// simultaneously would run their handlers on the same memory and corrupt each
// other. This is mitigated, not fully eliminated, by:
//  - g_dumperMgr.mutex serialising the dump path so only one handler does the
//    clone/waitpid heavy work at a time;
//  - the crash ucontext/siginfo being copied into the global g_dumperMgr.args
//    (not kept on the alt stack) before the child reads them;
//  - sa_mask blocking all managed fatal signals on the *handling* thread so it
//    is not re-interrupted mid-handler.
// A true per-thread alt stack would need to intercept host thread creation,
// which a passively-loaded library cannot do; tracked as a follow-up.
#define TRACE_ALT_STACK_SIZE                (64U * 1024U)
STATIC char g_traceAltStack[TRACE_ALT_STACK_SIZE];

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
            if (ScdSignalIsBinDump(info.signo, info.siginfo)) {
                // StackcoreLogSave is safe here: g_stackLogMgr is initialized in
                // TraceDumperInit() which runs before TraceSignalInit() registers
                // signal handlers. StackcoreLogSave() also has NULL check protection.
                StackcoreLogSave();
            }
            return;
        }
        // Save crash signals here (SIG_ATRACE bin dump is saved above).
        // StackcoreLogSave is safe: g_stackLogMgr is initialized before signal
        // handlers are registered, and StackcoreLogSave() has NULL check protection.
        StackcoreLogSave();
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

/**
 * @brief       install a dedicated alternate signal stack so the handler can
 *              still run when the thread stack is exhausted (stack-overflow
 *              SIGSEGV). Failure is not fatal: fall back to the normal stack.
 *              Runs before any signal handler is registered, so strerror is
 *              used here without reentrancy concerns.
 * @return      NA
 */
STATIC void TraceSignalSetupAltStack(void)
{
    stack_t altStack;
    (void)memset_s(&altStack, sizeof(altStack), 0, sizeof(altStack));
    altStack.ss_sp = g_traceAltStack;
    altStack.ss_size = sizeof(g_traceAltStack);
    altStack.ss_flags = 0;
    if (sigaltstack(&altStack, NULL) != 0) {
        ADIAG_WAR("set alternate signal stack failed, info: %s, stack overflow may not be captured.",
            strerror(AdiagGetErrorCode()));
    }
}

TraStatus TraceSignalInit(void)
{
    TraceSignalSetupAltStack();
    for (uint32_t i = 0; i < REGISTER_SIGNAL_NUM; i++) {
        struct TraceSigAction *sigAct = &g_sigMgr.sigAct[i];
        (void)memset_s(&sigAct->sigAct, sizeof(struct sigaction), 0, sizeof(struct sigaction));
        // sa_mask is per-thread: while this handler runs, block every managed
        // fatal signal on the *handling* thread so a second fatal signal cannot
        // re-enter and corrupt the handler on the same thread. (It does not
        // block signals on other threads — see the g_traceAltStack limitation
        // note above.) sigaddset is idempotent.
        (void)sigemptyset(&(sigAct->sigAct.sa_mask));
        for (uint32_t j = 0; j < REGISTER_SIGNAL_NUM; j++) {
            (void)sigaddset(&(sigAct->sigAct.sa_mask), g_sigMgr.sigAct[j].signo);
        }
        sigAct->sigAct.sa_sigaction = TraceSignalHandler;
        // SA_ONSTACK runs the handler on the alternate stack installed above.
        sigAct->sigAct.sa_flags = SA_SIGINFO | SA_ONSTACK;
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
    // Disable the alternate signal stack, symmetric with TraceSignalInit's
    // TraceSignalSetupAltStack(). Avoids leaving a stale alt-stack setting on
    // repeated Init/Exit cycles (e.g. tests, dynamic load). sigaltstack is
    // per-thread; this clears it on the calling (init) thread. SS_DISABLE on a
    // thread that never installed an alt stack is a no-op, so this is safe even
    // if Init never ran.
    stack_t disableStack;
    (void)memset_s(&disableStack, sizeof(disableStack), 0, sizeof(disableStack));
    disableStack.ss_flags = SS_DISABLE;
    (void)sigaltstack(&disableStack, NULL);
}
