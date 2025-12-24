/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stacktrace_fp.h"
#include <errno.h>
#include <string.h>
#include <ucontext.h>
#include <fcntl.h>
#include <pthread.h>
#include "securec.h"
#include "stacktrace_unwind_reg.h"
#include "adiag_print.h"
#include "adiag_utils.h"
#include "trace_types.h"
#include "trace_system_api.h"

#define EXEC_READ_MAP                       "r"
#define EXEC_MAP_ATTR                       "r-xp"
#define OS_SPLIT                            '/'
#define LR_OFFSET           8U

/**
 * @brief       get current pc self map
 * @param [in]  pc:         exception PC register
 * @param [out] data:       exception map info
 * @param [in]  len:        data buffer length
 * @return      TRACE_SUCCESS  success; TRACE_FAILURE  failure
 */
STATIC TraStatus TraceGetSelfMap(uintptr_t pc, char *data, uint32_t len)
{
    if (data == NULL || len == 0) {
        return TRACE_FAILURE;
    }

    int32_t fd = open(SELF_MAP_PATH, O_RDONLY);
    if (fd < 0) {
        LOGW("self map fopen null");
        return TRACE_FAILURE;
    }

    char *vmPath = NULL;
    uintptr_t vmStart = 0;
    uintptr_t vmEnd = 0;
    char currentPath[CORE_BUFFER_LEN] = { 0 };
    uintptr_t baseAddr = 0; // the minimum addr of load segment
    while (TraceSafeReadLine(fd, data, len) > 0) {
        vmPath = strchr(data, OS_SPLIT);
        if (vmPath == NULL) {
            continue;
        }
        if (sscanf_s(data, "%lx-%lx", &vmStart, &vmEnd) <= 0) {
            continue;
        }

        if (strcmp(currentPath, vmPath) != 0) {
            errno_t err = strncpy_s(currentPath, CORE_BUFFER_LEN, vmPath, CORE_BUFFER_LEN - 1U);
            if (err != 0) {
                LOGE("copy vmPath to currentPath failed.");
                break;
            }
            baseAddr = vmStart; // update baseAddr when path change
        }
        // pcAddr is in code-segment(r-xp)
        if ((pc < vmStart) || (pc > vmEnd) || (strstr(data, EXEC_MAP_ATTR) == NULL)) {
            continue;
        }

        int32_t ret = snprintf_s(data, len, (size_t)len - 1U, "0x%016lx %s", baseAddr, currentPath);
        if (ret == -1) {
            LOGE("snprintf_s map info failed");
            break;
        }
        TraceClose(&fd);
        return TRACE_SUCCESS;
    }
    TraceClose(&fd);
    return TRACE_FAILURE;
}

/**
 * @brief       reason the stack frame by FP
 * @param [in]  layer:      exception layer
 * @param [in]  fp:         exception FP register
 * @param [out] data:       exception info
 * @param [in]  len:        data buffer length
 * @return      0  reason end; other  continue to reason
 */
STATIC uintptr_t TraceStackFrame(int32_t layer, uintptr_t fp, char *data, size_t len)
{
    uintptr_t nfp = 0;
    uintptr_t pc = 0;
    char info[CORE_BUFFER_LEN] = { 0 };
    if (fp == 0 || layer >= MAX_STACK_LAYER || data == NULL || len == 0) {
        return 0;
    }

    if (layer == 0) { // current pc frame
        pc = fp;
        nfp = pc;
    } else { // fp inference pc frame
        uintptr_t lr = fp + LR_OFFSET;
        if (lr < fp) {
            return 0;
        }
        pc = *(uintptr_t *)lr;
        nfp = *(uintptr_t *)fp;
    }
    int32_t ret;
    if (TraceGetSelfMap(pc, info, (uint32_t)sizeof(info)) != TRACE_SUCCESS) {
        ret = snprintf_s(data, len, len - 1U, "invalid pc address 0x%016lx, can not reason stack.\n", pc);
        if (ret == -1) {
            LOGE("snprintf_s core info failed");
        }
        return 0;
    }
    ret = snprintf_s(data, len, len - 1U, "#%02d 0x%016lx %s", layer, pc, info);
    if (ret == -1) {
        LOGE("snprintf_s core info failed");
        return 0;
    }
    return nfp;
}

/**
 * @brief       reason the stack frame by PC
 * @param [in]  layer:      exception layer
 * @param [in]  pc:         current pc
 * @param [out] data:       exception info
 * @param [in]  len:        data buffer length
 */
STATIC void TraceStackPcFrame(int32_t layer, uintptr_t pc, char *data, size_t len)
{
    if (layer >= MAX_STACK_LAYER || data == NULL || len == 0) {
        return;
    }

    if (pc == 0) { // current pc frame
        int32_t ret = snprintf_s(data, len, len - 1U, "#%d 0x%016lx 0x%016lx %s\n",
            layer, pc, pc, program_invocation_name);
        if (ret == -1) {
            LOGE("snprintf_s core info failed");
        }
    }
    (void)TraceStackFrame(layer, pc, data, len);
}

/**
 * @brief       check rbp register value is valid or not
 * @param [in]  rbp:        exception BP register
 * @param [in]  rsp:        exception SP register
 * @return      true  valid; false  invalid
 */
STATIC bool TraceCheckRegister(uintptr_t rbp, uintptr_t rsp, uintptr_t stackBaseAddr)
{
    if ((rbp >= rsp) && (rbp < stackBaseAddr)) {
        return true;
    }

    return false;
}

/**
 * @brief       derivation stack by fp
 * @param [in]  arg:        argument
 * @param [in]  regs:       register info
 * @param [in]  regNum:     number of register
 * @param [out] stackInfo:  buffer to save stack info
 * @return      TraStatus
 */
TraStatus TraceStackFp(const ThreadArgument *arg, uintptr_t *regs, uint32_t regNum, TraceStackInfo *stackInfo)
{
    if (regs == NULL || arg == NULL || stackInfo == NULL || regNum < MAX_USE_REG_NUM) {
        return TRACE_INVALID_PARAM;
    }

    uintptr_t fp = GET_FPREG(regs);
    uintptr_t sp = GET_SPREG(regs);
    uintptr_t pc = GET_PCREG(regs);

    int32_t layer = 0;
    stackInfo->layer = -1;
    char info[CORE_BUFFER_LEN] = { 0 };
    if (!TraceCheckRegister(fp, sp, arg->stackBaseAddr)) {
        int32_t ret = snprintf_s(info, CORE_BUFFER_LEN, CORE_BUFFER_LEN - 1U,
            "invalid register value, stack_start_addr=0x%016lx rbp=0x%016lx rsp=0x%016lx \n\n", arg->stackBaseAddr, fp, sp);
        if (ret != -1) {
            (void)memcpy_s(&stackInfo->errLog, CORE_BUFFER_LEN, info, strlen(info));
        }
        return TRACE_FAILURE;
    }

    // save pc frame info
    TraceStackPcFrame(layer, pc, info, sizeof(info));
    errno_t err = memcpy_s(&stackInfo->frame[0].info, CORE_BUFFER_LEN, info, strlen(info));
    if (err != EOK) {
        LOGE("memcpy pc frame failed, ret=%d", err);
        return TRACE_FAILURE;
    }
    stackInfo->layer = 0;

    // save stack frame info
    uintptr_t nfp = fp;
    while ((fp != 0) && (fp >= nfp) && (layer < MAX_STACK_LAYER - 1)) {
        layer++;
        fp = TraceStackFrame(layer, fp, info, sizeof(info));
        err = memcpy_s(&stackInfo->frame[layer].info, CORE_BUFFER_LEN, info, strlen(info));
        if (err != EOK) {
            LOGE("memcpy stack frame failed, ret=%d", err);
            stackInfo->layer = layer - 1;
            return TRACE_FAILURE;
        }
    }

    stackInfo->layer = layer;
    return TRACE_SUCCESS;
}

/**
 * @brief       write "process" info
 * @param [in]  fd:     handle of stack_core file
 * @param [in]  arg:    argument
 * @return      TraStatus
 */
STATIC TraStatus TraceWriteProcessInfo(int32_t fd, const ThreadArgument *arg)
{
    uintptr_t sp = 0;
    const mcontext_t *mcontext = &(arg->ucontext.uc_mcontext);
    if (mcontext != NULL) {
        sp = GET_SPREG_FROM_CONTEXT(mcontext);
    }

    TraceStackProcessInfo info = { arg->signo, arg->pid, arg->tid, arg->crashTime, arg->stackBaseAddr, sp };
    return TraceSafeWriteProcessInfo(fd, &info);
}

/**
 * @brief       process the exception signal, write info to stack_core file
 * @param [in]  arg:        argument
 * @return      TraStatus
 */
TraStatus TraceStackSigHandler(const ThreadArgument *arg)
{
    if (arg == NULL) {
        return TRACE_FAILURE;
    }

    LOGI("get signal number:%d, start to analysis stack info.", arg->signo);
    TraceStackInfo *stackInfo = TraceSafeGetStackBuffer();
    stackInfo->threadIdx = 0;
    stackInfo->threadTid = arg->tid;
    const ucontext_t *utext = &arg->ucontext;
    const mcontext_t *mcontext = (const mcontext_t *)&(utext->uc_mcontext);
    uintptr_t regs[TRACE_CORE_REG_NUM] = { 0 };
    GET_REGISTER_FROM_CONTEXT(regs, mcontext);
    TraStatus ret = TraceStackFp(arg, regs, TRACE_CORE_REG_NUM, stackInfo);
    if (ret != TRACE_SUCCESS) {
        LOGW("can not derivation stack by fp, ret=%d.", ret);
    }

    int32_t fd = -1;
    TraceStackRecorderInfo info = {arg->crashTime, arg->signo, arg->pid, arg->tid};
    ret = TraceSafeGetFd(&info, TRACE_FILE_TXT_SUFFIX, &fd);
    if (ret != TRACE_SUCCESS) {
        LOGE("get fd failed.");
        return TRACE_FAILURE;
    }

    ret = TraceWriteProcessInfo(fd, arg);
    if (ret != TRACE_SUCCESS) {
        LOGE("write process info to file failed, ret=%d.", ret);
    }

    ret = TraceSafeWriteStackInfo(fd, stackInfo);
    if (ret != TRACE_SUCCESS) {
        LOGE("write stack info to file failed, ret=%d.", ret);
    }

    ret = TraceSafeWriteSystemInfo(fd, arg->pid);
    if (ret != TRACE_SUCCESS) {
        LOGE("write process info to file failed, ret=%d.", ret);
    }

    TraceClose(&fd);
    LOGI("write stackcore file end.");
    return TRACE_SUCCESS;
}