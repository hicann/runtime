/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "scd_thread.h"
#include "adiag_utils.h"
#include "scd_log.h"
#include "scd_ptrace.h"

STATIC TraStatus ScdThreadWaitTidStopped(int32_t tid)
{
    int32_t status;
    int32_t ret;
    do {
        ret = SCD_UTIL_RETRY(waitpid(tid, &status, __WALL));
        if (ret == -1) {
            SCD_DLOG_WAR("can not watipid, tid=%d, errno=%d", tid, errno);
            return TRACE_FAILURE;
        }
        if (!WIFSTOPPED(status)) {
            SCD_DLOG_WAR("can not stop thread, tid=%d, status=%x", tid, status);
            return TRACE_FAILURE;
        }
        if (WSTOPSIG (status) == SIGSTOP) {
            break;
        }
        SCD_DLOG_WAR("waitpid ret = %d, status=%x, tid=%d", ret, status, tid);
        // receive other signal, continue with no signal to still wait for SIGSTOP
        ScdPtraceContinue(tid);
    } while (true);
    return TRACE_SUCCESS;
}

TraStatus ScdThreadSuspend(ScdThread *thd)
{
    int32_t tid = thd->tid;
    if (ScdPtraceAttach(tid) != TRACE_SUCCESS) {
        SCD_DLOG_WAR("can not ptrace ATTACH, tid=%d, errno=%d", tid, errno);
        thd->status = SCD_THREAD_STATUS_ATTACH;
        return TRACE_FAILURE;
    }
    return ScdThreadWaitTidStopped(tid);
}

void ScdThreadResume(ScdThread *thd)
{
    ScdPtraceDetach(thd->tid);
}

STATIC void ScdThreadGetName(ScdThread *thd)
{
    ScdUtilGetThreadName(thd->pid, thd->tid, thd->tname, SCD_THREAD_NAME_LEN);
}

STATIC TraStatus ScdThreadGetRegs(ScdThread *thd)
{
    uintptr_t regBuf[SCD_REGS_NUM] = {0};
    // 通过ptrace获取
    if (ScdPtraceGetRegs(thd->tid, regBuf, SCD_REGS_NUM) != TRACE_SUCCESS) {
        thd->status = SCD_THREAD_STATUS_REGS;
        return TRACE_FAILURE;
    }
    GET_REGISTER_FROM_PTRACE(thd->regs.r, regBuf);
    return TRACE_SUCCESS;
}

TraStatus ScdThreadLoadInfo(ScdThread *thd)
{
    ScdThreadGetName(thd);
    TraStatus ret = ScdThreadGetRegs(thd);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_WAR("can not ptrace get regs, tid=%d, errno=%d", thd->tid, errno);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

TraStatus ScdThreadLoadInfoForCrash(ScdThread *thd, ScdRegs *regs)
{
    ScdThreadGetName(thd);
    errno_t ret = memcpy_s(&thd->regs, sizeof(ScdRegs), regs, sizeof(ScdRegs));
    if (ret != EOK) {
        SCD_DLOG_WAR("can not memcpy_s, ret=%d, errno=%d", (int32_t)ret, errno);
        return TRACE_FAILURE;
    }
    SCD_DLOG_DBG("set crash thread info, tid=%d, pc=0x%lx, sp=0x%lx, fp=0x%lx.",
        thd->tid, GET_PCREG(regs->r), GET_SPREG(regs->r), GET_FPREG(regs->r));
    return TRACE_SUCCESS;
}

TraStatus ScdThreadLoadFrames(ScdThread *thd, ScdMaps *maps)
{
    return ScdFramesLoad(&thd->frames, maps, &thd->regs);
}

STATIC TraStatus ScdThreadInit(ScdThread *thd, int32_t pid, int32_t tid)
{
    SCD_CHK_PTR_ACTION(thd, return TRACE_FAILURE);
    thd->status = SCD_THREAD_STATUS_INIT;
    thd->pid = pid;
    thd->tid = tid;
    (void)memset_s(&(thd->regs), sizeof(thd->regs), 0, sizeof(thd->regs));
    return ScdFramesInit(&thd->frames, pid, tid);
}

STATIC void ScdThreadUninit(ScdThread *thd)
{
    ScdFramesUninit(&thd->frames);
}

ScdThread *ScdThreadCreate(int32_t pid, int32_t tid)
{
    ScdThread *thd = AdiagMalloc(sizeof(ScdThread)); 
    if (thd != NULL) {
        TraStatus ret = ScdThreadInit(thd, pid, tid);
        if (ret != TRACE_SUCCESS) {
            ADIAG_SAFE_FREE(thd);
        }
    }
    return thd;
}

void ScdThreadDestroy(ScdThread **thd)
{
    if ((thd != NULL) && (*thd != NULL)) {
        ScdThreadUninit(*thd);
        ADIAG_SAFE_FREE(*thd);
    }
}
