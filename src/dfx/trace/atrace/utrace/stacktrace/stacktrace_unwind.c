/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stacktrace_unwind.h"
#include <execinfo.h>
#include <stdlib.h>
#include <pthread.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <link.h>
#include "stacktrace_unwind_inner.h"
#include "stacktrace_unwind_instr.h"
#include "stacktrace_fp.h"
#include "stacktrace_signal.h"
#include "stacktrace_unwind_dfx.h"
#include "stddef.h"
#include "securec.h"
#include "trace_system_api.h"
#include "adiag_utils.h"
#include "adiag_print.h"
#include "scd_memory.h"
#include "scd_maps.h"
#include "scd_dwarf.h"

#define FDE_ENTRY_SIZE      8U
#define MAX_SHARE_LIB_NUM 500U
#define UNWIND_MAP_NUM 2U

// 记录所有动态库信息
typedef struct ShareLibInfo {
    uint32_t shareLibNum;
    TraceUnwindMapInfo unwindMapInfo[MAX_SHARE_LIB_NUM];
} ShareLibInfo;

static ShareLibInfo g_shareLibInfo[UNWIND_MAP_NUM];  // ping pong manager
static uint32_t g_shareLibIdx = 0;

static void TraceGetElfUnwindInfo(struct dl_phdr_info *pstInfo, TraceUnwindMapInfo *unwindMapInfo)
{
    const ElfW(Phdr) *psthdr = pstInfo->dlpi_phdr;
    unwindMapInfo->loadBase = pstInfo->dlpi_addr;
    unwindMapInfo->codeListNum = 0;
    unwindMapInfo->size = psthdr->p_memsz;
    errno_t ret;
    for (int i = pstInfo->dlpi_phnum; i > 0; i--) {
        if (psthdr->p_type == PT_LOAD) {
            unwindMapInfo->codeList[unwindMapInfo->codeListNum].loadProgSegAddr = psthdr->p_vaddr + pstInfo->dlpi_addr;
            unwindMapInfo->codeList[unwindMapInfo->codeListNum].segSize = (uint32_t)psthdr->p_memsz;
            if (pstInfo->dlpi_name[0] == '\0') {
                ret = strcpy_s(unwindMapInfo->objName, sizeof(unwindMapInfo->objName), program_invocation_short_name);
            } else {
                ret = strcpy_s(unwindMapInfo->objName, sizeof(unwindMapInfo->objName), pstInfo->dlpi_name);
            }
            if (ret != EOK) {
                LOGW("strcpy_s failed, err = %d, strerr = %s.", (int32_t)ret, strerror(AdiagGetErrorCode()));
            }
            unwindMapInfo->codeListNum++;
        } else if (psthdr->p_type == PT_GNU_EH_FRAME) {
            unwindMapInfo->unwindSegStart = psthdr->p_vaddr + pstInfo->dlpi_addr;
            unwindMapInfo->count = psthdr->p_memsz / FDE_ENTRY_SIZE;
            unwindMapInfo->size = psthdr->p_memsz;
            LOGI("[LLT] unwindSegStart : %lx, unwindMapInfo->count : %zu",
                unwindMapInfo->unwindSegStart, unwindMapInfo->count);
        } else {
            ;
        }
        psthdr++;
    }
    for (uint32_t j = 0; j < unwindMapInfo->codeListNum; j++) {
        TraceLoadProgSegInfo *segInfo = &unwindMapInfo->codeList[j];
        LOGI("[%u] [%lx, %lx] %s", j, segInfo->loadProgSegAddr,
            segInfo->loadProgSegAddr + segInfo->segSize, unwindMapInfo->objName);
    }
}

/**
 * @brief           callback function called by dl_iterate_phdr, record dynamic library load info
 * @param [in]      pstInfo:            a pointer to a structure containing information about the shared object
 * @param [in]      size:               the size of the structure pointed to by info
 * @param [in]      ptr:                a copy of whatever value was passed by the calling program as the
 *                                      second argument (also named data) in the call to dl_iterate_phdr().
 * @return          0 for success, others for failed
 */
STATIC int32_t TraceFindunwindSegCallback(struct dl_phdr_info *pstInfo, size_t size, void *ptr)
{
    if (size < sizeof(struct dl_phdr_info)) {
        return -1;
    }
    ShareLibInfo *shareLibInfo = (ShareLibInfo *)ptr;
    if (shareLibInfo->shareLibNum == MAX_SHARE_LIB_NUM) {
        LOGE("share lib num exceeding the size of array %u", MAX_SHARE_LIB_NUM);
        return -1;
    }
    TraceUnwindMapInfo *unwindMapInfo = &shareLibInfo->unwindMapInfo[shareLibInfo->shareLibNum];
    TraceGetElfUnwindInfo(pstInfo, unwindMapInfo);
    shareLibInfo->shareLibNum++;
    return 0;
}

static void TraceGetAllModuleBaseInfo(void)
{
    ShareLibInfo *shareLibInfo = &g_shareLibInfo[1U - g_shareLibIdx];
    shareLibInfo->shareLibNum = 0;
    (void)dl_iterate_phdr(TraceFindunwindSegCallback, shareLibInfo);
    g_shareLibIdx = 1U - g_shareLibIdx;
}

static void DumpStack(uint32_t idx, uintptr_t pc, char*data, size_t len)
{
    for (uint32_t i = 0; i < g_shareLibInfo[g_shareLibIdx].shareLibNum; i++) {
        TraceUnwindMapInfo *unwindMapInfo = &g_shareLibInfo[g_shareLibIdx].unwindMapInfo[i];
        for (uint32_t j = 0; j < unwindMapInfo->codeListNum; j++) {
            TraceLoadProgSegInfo *segInfo = &unwindMapInfo->codeList[j];
            if (pc < segInfo->loadProgSegAddr || pc > segInfo->loadProgSegAddr + segInfo->segSize) {
                continue;
            }
            int ret = snprintf_s(data, len, len - 1U,
                "#%02u 0x%016lx 0x%016lx %s\n", idx, pc, unwindMapInfo->codeList[0].loadProgSegAddr, unwindMapInfo->objName);
            LOGR("#%02u 0x%016lx 0x%016lx %s", idx, pc, unwindMapInfo->codeList[0].loadProgSegAddr, unwindMapInfo->objName);
            if (ret == -1) {
                LOGE("snprintf_s stack info failed, strerr=%s.", strerror(AdiagGetErrorCode()));
            }
            return;
        }
    }
}

static void TraceDumpResult(uintptr_t *callstack, uint32_t maxDepth, TraceStackInfo *stackInfo)
{
    stackInfo->layer = 0;
    for (uint32_t i = 0; i < maxDepth; i++) {
        if (callstack[i] != 0) {
            DumpStack(i, callstack[i], stackInfo->frame[i].info, sizeof(stackInfo->frame[i].info));
            stackInfo->layer++;
        }
    }
    stackInfo->layer--;
}

/**
 * 获取eh_frame_hdr地址
 * @param [in] pc 程序计数器
 * @param [out] count 反向解码计数
 * @param [out] dwarf pc所在的dwarf信息
 * @return 如果找到匹配的地址，返回地址；否则返回0
 */
TraStatus TraceGetEhFrameHdrAddr(uintptr_t pc, ScdDwarf *dwarf)
{
    for (uint32_t i = 0; i < g_shareLibInfo[g_shareLibIdx].shareLibNum; i++) {
        TraceUnwindMapInfo *unwindMapInfo = &g_shareLibInfo[g_shareLibIdx].unwindMapInfo[i];
        TraceLoadProgSegInfo *baseSegInfo = &unwindMapInfo->codeList[0]; // use first codeList for base
        for (uint32_t j = 0; j < unwindMapInfo->codeListNum; j++) {
            // 获取当前代码段的信息
            TraceLoadProgSegInfo *segInfo = &unwindMapInfo->codeList[j];
            if (pc >= segInfo->loadProgSegAddr && pc < segInfo->loadProgSegAddr + segInfo->segSize) {
                dwarf->fdeCount = unwindMapInfo->count;
                LOGI("use codeList [0x%lx, 0x%lx], unwindSegStart %lx", baseSegInfo->loadProgSegAddr,
                    baseSegInfo->loadProgSegAddr + baseSegInfo->segSize, unwindMapInfo->unwindSegStart);
                LOGI("unwindMapInfo->unwindSegStart %lx ", unwindMapInfo->unwindSegStart);
                LOGI("[LLT] PC offset %lx, unwindSegStart offset %lx", pc - baseSegInfo->loadProgSegAddr,
                    unwindMapInfo->unwindSegStart - baseSegInfo->loadProgSegAddr);
                dwarf->loadBias = 0;
                dwarf->memory->data = unwindMapInfo->unwindSegStart;
                dwarf->memory->size = UINT32_MAX; // unable to determine size of elf, set to maximum value to avoid check
                return TRACE_SUCCESS;
            }
        }
    }
    // 如果没有找到匹配的地址，返回0
    return TRACE_FAILURE;
}
typedef struct TraceStackAddrLimit {
    uintptr_t stackMaxAddr;
    uintptr_t stackMinAddr;
} TraceStackAddrLimit;

/**
 * 通过异常处理程序的栈帧获取调用栈。
 *
 * @param [in]  stackAddr 堆栈地址限制信息。
 * @param [in]  regs 核心寄存器数组。
 * @param [out] callstack 调用栈缓冲区，用于存储获取到的调用栈信息。
 * @param [in]  maxDepth 最大调用栈深度。
 *
 * @return      : !=0 failure; ==0 success
 */
static TraStatus TraceCallStackGetByUnwind(const TraceStackAddrLimit *stackAddr, ScdRegs *regs,
    uintptr_t *callstack, uint32_t maxDepth)
{
    uint32_t depth = 0;
    uintptr_t nextPc = 0;
    uintptr_t pc = regs->r[VOS_R_IP];
    regs->r[VOS_R_IP] = 0;
    callstack[depth] = pc;
    depth++;
    ScdDwarfStepArgs args;
    ScdMemory memory;
    ScdMemoryInitLocal(&memory);
    args.stackMinAddr = stackAddr->stackMinAddr;
    args.stackMaxAddr = stackAddr->stackMaxAddr;
    args.isFirstStack = true;
    for (;depth < maxDepth; depth++) {
        ScdDwarf dwarf = {0};
        dwarf.memory = &memory;
        dwarf.ehFrameHdrOffset = 0;
        if ((TraceGetEhFrameHdrAddr(pc, &dwarf) != TRACE_SUCCESS) || (dwarf.memory->data == 0)) {
            LOGE("cannot find pc 0x%lx in so", pc);
            return TRACE_FAILURE;
        }
        int ret = ScdDwarfStep(&dwarf, regs, &args, pc, &nextPc);
        if (ret != TRACE_SUCCESS) {
            LOGE("get next pc by unwind failed");
            return ret;
        }
        if (nextPc == 0) {
            break;
        }
        args.isFirstStack = false;
        pc = nextPc;
        callstack[depth] = nextPc;
    }
    return TRACE_SUCCESS;
}

void TraceStackUnwindInit(void)
{
    TraceGetAllModuleBaseInfo();
}

/**
 * @brief       get backtrace by unwind info
 * @param [in]  arg:        thread argument
 * @param [in]  regsAddr:   register info
 * @param [in]  regNum:     number of register
 * @param [out] stackInfo:  stack info get by unwind info
 * @return      TraStatus
 */
TraStatus TraceStackUnwind(const ThreadArgument *arg, uintptr_t *regsAddr, uint32_t regNum, TraceStackInfo *stackInfo)
{
    if ((arg == NULL) || (stackInfo == NULL) || (regsAddr == NULL) || (regNum < MAX_USE_REG_NUM)) {
        LOGE("invalid argument arg or stackInfo");
        return TRACE_FAILURE;
    }

    uintptr_t callstack[MAX_STACK_LAYER] = {0};
    ScdRegs regs = {0};
    errno_t err = memcpy_s(regs.r, sizeof(uintptr_t) * TRACE_CORE_REG_NUM, regsAddr, sizeof(uintptr_t) * TRACE_CORE_REG_NUM);
    if (err != EOK) {
        LOGE("memcpy failed, err = %d, strerr = %s.", err, strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }

    uintptr_t nfp = regs.r[VOS_R_BP]; // RBP register
    uintptr_t sp = regs.r[VOS_R_SP]; // RSP register
    uintptr_t pc = regs.r[VOS_R_IP]; // RIP register
    LOGI("pc : %lx, sp : %lx, nfp : %lx", pc, sp, nfp);
    TraceStackAddrLimit stackAddr = {0};
    stackAddr.stackMaxAddr = arg->stackBaseAddr;
    stackAddr.stackMinAddr = sp;
    LOGI("stack addr : [%lx, %lx]", stackAddr.stackMinAddr, stackAddr.stackMaxAddr);
    DumpStackToFile(stackAddr.stackMinAddr, stackAddr.stackMaxAddr - stackAddr.stackMinAddr);

    TraStatus ret = TraceCallStackGetByUnwind(&stackAddr, &regs, callstack, MAX_STACK_LAYER);
    if (ret != TRACE_SUCCESS) {
        return ret;
    }
    TraceDumpResult(callstack, MAX_STACK_LAYER, stackInfo);
    return TRACE_SUCCESS;
}
