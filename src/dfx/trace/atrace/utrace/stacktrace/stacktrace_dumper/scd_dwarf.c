/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "scd_dwarf.h"
#include "scd_log.h"
#include "stacktrace_unwind.h"
#include "stacktrace_unwind_reg.h"
#include "stacktrace_unwind_instr.h"
#include "stacktrace_unwind_inner.h"
#include "scd_maps.h"

#define TRACE_MAX_AUG_STR_LEN 0x08U // max length of augmentation string in CIE
// .eh_frame_hdr section
typedef struct TraceUnwindEhFrameHdrInfo {
    uint8_t version;       // eh_frame_hdr version, must be 1
    uint8_t ehframeptrEnc; // the encode type of eh_frame_hdr
    uint8_t fdeCountEnc;   // the encode type of FDE count
    uint8_t tabEnc;        // the encode type of binary search table
    uint8_t searchTblFlag; // the flag of table present 1:present 0:no present
    uint8_t reserved[3];   // the reserved
    uintptr_t frameAddr;   // eh_frame section start addr
    size_t fdeCount;       // FDE count in binary search table
    uintptr_t tblStatAddr; // the binary search table addr
} TraceUnwindEhFrameHdrInfo;
// FDE entry in the binary search table
typedef struct FdeEntry {
    int32_t initLocOffset;    // location addr offset relative to eh_frame_hdr addr
    int32_t fdeTableOffset;
} FdeEntry;

typedef struct FDECtrlBlock {
    uintptr_t funcStart;
    uintptr_t unwindEntryAddr;
} FDECtrlBlock;
// the first few filed of an FDE
typedef struct TraceEhFrameFde {
    uint32_t fdeLengh;
    uint32_t cieOffset;
    uint8_t pcBegin[16];
} TraceEhFrameFde;
// the first few filed of an CIE
typedef struct TraceEhFrameCie {
    uint32_t cieLengh;       // the length of CIE except itself
    uint32_t cieId;          // the ID of CIE, must be 0
    uint8_t version;         // the version of CIE
    int8_t augmentation[15]; // the string of Augmentation
} TraceEhFrameCie;

/**
 * @brief           get cie address by offset
 * @param [in]      offset:         offset address
 * @return          cie address
 */
STATIC INLINE uintptr_t GetCieAddressByOffset(uint32_t *offset)
{
    return (uintptr_t)(offset) - (*offset);
}

STATIC INLINE uintptr_t GetAddrByOffset(uintptr_t addr, intptr_t offset)
{
    if (offset >= 0) {
        return addr + (uintptr_t)offset;
    }
    uintptr_t absOffset = (uintptr_t)(-offset);
    if (absOffset > addr) {
        return 0;
    }
    return addr - absOffset;
}

/**
 * @brief extract eh_frame_hdr section
 *
 * @param [in]  ehFrameHdrAddr eh_frame_hdr addr
 * @param [out] ehFrameHdrInfo eh_frame_hdr information
 *
 * @return      : !=0 failure; ==0 success
 */
STATIC TraStatus TraceParseFrameHdrAddr(ScdDwarf *dwarf, TraceUnwindEhFrameHdrInfo *ehFrameHdrInfo)
{
    const uint8_t *addr = (uint8_t *)(dwarf->memory->data + dwarf->ehFrameHdrOffset);
    ehFrameHdrInfo->version = *addr;
    addr++;
    ehFrameHdrInfo->ehframeptrEnc = *addr;
    addr++;
    ehFrameHdrInfo->fdeCountEnc = *addr;
    addr++;
    ehFrameHdrInfo->tabEnc = *addr;
    addr++;
    if (ehFrameHdrInfo->version != 1) {
        SCD_DLOG_ERR("[ERROR] invalid version %d", ehFrameHdrInfo->version);
        return TRACE_FAILURE;
    }
    addr = TraceReadEncodeValue(dwarf, ehFrameHdrInfo->ehframeptrEnc, addr, &ehFrameHdrInfo->frameAddr);
    if (addr == NULL) {
        SCD_DLOG_ERR("read encode value frame addr failed");
        return TRACE_FAILURE;
    }
    
    uintptr_t fdeItem;
    if (TRACE_IS_HDR_TBL_PRESENT(ehFrameHdrInfo)) {
        addr = TraceReadEncodeValue(dwarf, ehFrameHdrInfo->fdeCountEnc, addr, &fdeItem);
        if ((addr == NULL) || (fdeItem == 0)) {
            SCD_DLOG_ERR("read encode value fde item failed");
            return TRACE_FAILURE;
        }
        ehFrameHdrInfo->fdeCount = (size_t)fdeItem;
        ehFrameHdrInfo->tblStatAddr = (uintptr_t)addr;
        ehFrameHdrInfo->searchTblFlag = 1;
    } else {
        ehFrameHdrInfo->searchTblFlag = 0;
    }
    SCD_DLOG_INF("[eh_frame_hdr info] version: %u, ehframeptrEnc: %u, fdeCountEnc: %u, tabEnc: %u, searchTblFlag: %u",
        ehFrameHdrInfo->version, ehFrameHdrInfo->ehframeptrEnc, ehFrameHdrInfo->fdeCountEnc,
        ehFrameHdrInfo->tabEnc, ehFrameHdrInfo->searchTblFlag);
    return TRACE_SUCCESS;
}

STATIC const uint8_t *TraceParseCIEAug(ScdDwarf *dwarf, const char *augStr, const uint8_t *instr, uint32_t idx,
    uintptr_t *retIns, TraceFrameRegStateInfo *frameRegState)
{
    size_t encSize;
    uintptr_t retBegIns = 0;
    uintptr_t ulebTmp;
    const uint8_t *tmpInstr = instr;
    uint32_t  indexTmp = idx;

    /* Check for the presence of 'z' in the augmentation string, which indicates
     * the presence of additional information that affects the instruction range */
    if (augStr[indexTmp] == 'z') {
        tmpInstr = TraceReadUleb128(dwarf, tmpInstr, &ulebTmp);
        SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read uleb128 failed");
        retBegIns = (uintptr_t)tmpInstr + ulebTmp;
        frameRegState->optFlag = 1;
        indexTmp++;
    }

    while (augStr[indexTmp] != '\0') {
        // 'L' indicates a local static anonymous namespace, not processed here
        if (augStr[indexTmp] == 'L') {
            indexTmp++;
            tmpInstr++;
        } else if (augStr[indexTmp] == 'P') {
            // 'P' indicates a procedure linkage table (PLT) entry, not processed here 
            uint8_t ucPEnc = *tmpInstr;
            tmpInstr++;
            encSize = TraceEncValueSizeGet(ucPEnc);
            SCD_CHK_EXPR_ACTION(encSize == 0, return NULL, "get enc value size failed");
            tmpInstr += encSize;
            TRACE_UNWIND_PARSE_ADDR_CHECK_OR_RETURN(tmpInstr);
            indexTmp++;
        } else if (augStr[indexTmp] == 'R') { // 'R' indicates a range,
            frameRegState->fdeEnc = *tmpInstr;
            tmpInstr++;
            frameRegState->flag = 1;
            indexTmp++;
        } else if (*(const char *)tmpInstr == 'S') {  // 'S' indicates a signal frame
            frameRegState->sigFrmFlag = 1;
            indexTmp++;
        } else {
            /* If an unrecognized augmentation string is encountered, and there is no 'z',
             * the function returns early, indicating that the CST contains an unhandled string */
            if (retBegIns == 0) {
                return NULL;
            } else {
                break;
            }
        }
    }
    *retIns = retBegIns;
    return tmpInstr;
}

STATIC TraStatus TraceParseCie(ScdDwarf *dwarf, uintptr_t cieAddr, TraceAddrRange* initIns, TraceFrameRegStateInfo *frameRegState)
{
    TraceEhFrameCie *ehFrameCIEHdr = (TraceEhFrameCie *)cieAddr;
    const uint8_t *skipAug = NULL;
    char ucAugStr[TRACE_MAX_AUG_STR_LEN + 1U] = {0};
    uint32_t idx = 0;
    skipAug = (const uint8_t *)ehFrameCIEHdr->augmentation;
    for (size_t i = 0; i < TRACE_MAX_AUG_STR_LEN; i++) {
        size_t size = TraceReadBytes(dwarf, &skipAug, &ucAugStr[i], sizeof(uint8_t));
        SCD_CHK_EXPR_ACTION(size == 0, return TRACE_FAILURE, "read byte failed");
        if (ucAugStr[i] == '\0') {
            break;
        }
    }
    if (ucAugStr[0] == 'e' && ucAugStr[1] == 'h') {
        skipAug += sizeof(void *);
        idx += 2U; // add 2 for size "eh"
    }
    uintptr_t ulebTmp;
    intptr_t svLebTmp;
    skipAug = TraceReadUleb128(dwarf, skipAug, &ulebTmp);
    SCD_CHK_EXPR_ACTION(skipAug == NULL, return TRACE_FAILURE, "read uleb128 failed");
    frameRegState->codeAlign = ulebTmp;
    skipAug = TraceReadLeb128(dwarf, skipAug, &svLebTmp);
    SCD_CHK_EXPR_ACTION(skipAug == NULL, return TRACE_FAILURE, "read leb128 failed");
    frameRegState->dataAlign = svLebTmp;
    if (ehFrameCIEHdr->version == 1) {
        ulebTmp = (uintptr_t)(*(uint8_t *)(uintptr_t)skipAug);
        skipAug++;
    } else {
        skipAug = TraceReadUleb128(dwarf, skipAug, &ulebTmp);
        SCD_CHK_EXPR_ACTION(skipAug == NULL, return TRACE_FAILURE, "read uleb128 failed");
    }
    frameRegState->retColumn = ulebTmp;
    uintptr_t retIns = 0;
    skipAug = TraceParseCIEAug(dwarf, ucAugStr, skipAug, idx, &retIns, frameRegState);
    SCD_CHK_EXPR_ACTION(skipAug == NULL, return TRACE_FAILURE, "parse CIE aug failed");
 
    // When 'z' appears, the unwind instruction address can be directly obtained through the ret pointer.
    initIns->start = (retIns != 0) ? retIns : (uintptr_t)skipAug;
    initIns->end = (uintptr_t)(cieAddr + ehFrameCIEHdr->cieLengh + sizeof(uint32_t));
    SCD_DLOG_INF("[CIE info] addr : 0x%lx, Length : 0x%x, Extended cieId : %u, version : %u, initIns [0x%lx-0x%lx],"
        "codeAlign:0x%lx, dataAlign:%ld,",
        cieAddr, ehFrameCIEHdr->cieLengh, ehFrameCIEHdr->cieId, ehFrameCIEHdr->version, initIns->start, initIns->end,
        frameRegState->codeAlign, frameRegState->dataAlign);
    return TRACE_SUCCESS;
}

STATIC TraStatus TraceParseFde(ScdDwarf *dwarf, uintptr_t fdeAddr, TraceFrameRegStateInfo *frameRegState, TraceAddrRange* initIns,
    TraceAddrRange* ins)
{
    uintptr_t cieEntry;
    const uint8_t *addr = NULL;
    uintptr_t funStart;
    uintptr_t range;
    TraceEhFrameFde *pstFDEHeadInfo = (TraceEhFrameFde *)fdeAddr;
    cieEntry = GetCieAddressByOffset(&pstFDEHeadInfo->cieOffset);
    TraStatus ret = TraceParseCie(dwarf, cieEntry, initIns, frameRegState);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("parse CIE failed, ret %d", ret);
        return ret;
    }
    addr = pstFDEHeadInfo->pcBegin;
    if (frameRegState->flag == 0) {
        funStart = *(uintptr_t *)(uintptr_t)addr;
        addr += sizeof(void *);
        range = *(uintptr_t *)(uintptr_t)addr;
        addr += sizeof(void *);
    } else {
        // 使用FDE编码解析PC Begin和PC Range
        uint8_t ucFdeEnc = frameRegState->fdeEnc;
        addr = TraceReadEncodeValue(dwarf, ucFdeEnc, addr, &funStart);
        if (addr == NULL) {
            SCD_DLOG_ERR("invalid addr");
            return TRACE_FAILURE;
        }
        addr = TraceReadEncodeValue(dwarf, TRACE_LOBIT4_ENCODE(ucFdeEnc), addr, (uintptr_t *)&range); /* 0x0f */
        if (addr == NULL) {
            SCD_DLOG_ERR("invalid addr");
            return TRACE_FAILURE;
        }
    }
    frameRegState->pc = funStart;
    frameRegState->range = range;

    uintptr_t ulebTmp = 0;
    if (frameRegState->optFlag == 1) {
        addr = TraceReadUleb128(dwarf, addr, &ulebTmp);
        SCD_CHK_EXPR_ACTION(addr == NULL, return TRACE_FAILURE, "read uleb128 failed");
    }

    ins->start = (uintptr_t)(addr + ulebTmp);
    ulebTmp = (uintptr_t)(fdeAddr + pstFDEHeadInfo->fdeLengh + sizeof(uint32_t));
    ins->end = ulebTmp;
    SCD_DLOG_INF("[FDE info] Length:0x%x,CIE Pointer:0x%x,pcBegin:0x%lx,funStart: 0x%lx,range: 0x%lx,ins [0x%lx-0x%lx]",
        pstFDEHeadInfo->fdeLengh, pstFDEHeadInfo->cieOffset, (uintptr_t)pstFDEHeadInfo->pcBegin,
        funStart, range, ulebTmp, ulebTmp + pstFDEHeadInfo->fdeLengh);
    return TRACE_SUCCESS;
}

STATIC void TraceGetCFAAddr(ScdDwarf *dwarf, TraceFrameRegStateInfo *frameRegState, ScdRegs *regs,
    const ScdDwarfStepArgs *args, uintptr_t *cfaAddrPtr)
{
    uintptr_t cfaAddr = 0;
    intptr_t  offset;
    uintptr_t regNum;
    uintptr_t insLen;
    uintptr_t expResult;
    uintptr_t storeReg;
    const uint8_t *expOpAddr = NULL;

    switch (frameRegState->frameStateInfo.cfaHow) {
        case VOS_CFA_REG_OFFSET:
            regNum = frameRegState->frameStateInfo.cfaReg;
            offset = frameRegState->frameStateInfo.cfaOffset;
            storeReg = regs->r[regNum & REG_VAILD_MASK];
            if (storeReg == 0) {
                return;
            } else {
                SCD_DLOG_INF("CFA Addr = reg[%ld]: %lx + offset : %ld", regNum, storeReg, offset);
                cfaAddr = storeReg + (uintptr_t)offset;
            }
            break;
        case VOS_CFA_EXP:
            /* expression 分支走dw_op指令解析流程 */
            expOpAddr = frameRegState->frameStateInfo.cfaExp;
            expOpAddr = TraceReadUleb128(dwarf, expOpAddr, &insLen);
            SCD_CHK_EXPR_ACTION(expOpAddr == NULL, return, "read uleb128 failed");
            (void)TraceStackOpExc(dwarf, expOpAddr, expOpAddr + insLen, regs, &expResult, 0, args);
            cfaAddr = expResult;

            break;
        default:
            break;
    }
    *cfaAddrPtr = cfaAddr;
    return;
}

STATIC TraStatus CallStackRegUpdate(ScdDwarf *dwarf, uint32_t idx, ScdRegs *pstCoreRegsOld, ScdRegs *coreRegs,
    uintptr_t cfaAddr, TraceStagRegInfo *pstRegInfo, const ScdDwarfStepArgs *args)
{
    uintptr_t regNum;
    uintptr_t expResult = 0;
    const uint8_t *expOpAddr = NULL;
    uintptr_t insLen = 0;
    uintptr_t regAddr;
    size_t size;
    TraStatus ret;
    SCD_DLOG_DBG("CallStackRegUpdate reg[%d] %d", idx, pstRegInfo->regHow);
    switch (pstRegInfo->regHow) {
        case REG_SAVED_OFFSET:
            regAddr = GetAddrByOffset(cfaAddr, pstRegInfo->regLoc.offset);
            SCD_CHK_EXPR_ACTION(regAddr == 0, return TRACE_FAILURE,
                "invalid offset %llx", pstRegInfo->regLoc.offset);
            /* 当前使用eh_frame进行unwind推栈的有x86_64、arm64和ilp32，寄存器大小都为64位，因此使用VOS_UINT64取内容 */
            size = ScdMemoryRead(NULL, regAddr, &coreRegs->r[idx & REG_VAILD_MASK], sizeof(uint64_t));
            SCD_CHK_EXPR_ACTION(size == 0, return TRACE_FAILURE, "scd read memory failed 0x%llx", regAddr);
            SCD_DLOG_INF("REG_SAVED_OFFSET reg %u addr:%lx value:%lx offset : %ld",
                idx, regAddr, coreRegs->r[idx & REG_VAILD_MASK], pstRegInfo->regLoc.offset);
            break;
        case REG_SAVED_VAL_OFFSET:
            regAddr = GetAddrByOffset(cfaAddr, pstRegInfo->regLoc.offset);
            SCD_CHK_EXPR_ACTION(regAddr == 0, return TRACE_FAILURE,
                "invalid offset %llx", pstRegInfo->regLoc.offset);
            coreRegs->r[idx & REG_VAILD_MASK] = (uintptr_t)regAddr;
            SCD_DLOG_INF("REG_SAVED_VAL_OFFSET %u %lx", idx, coreRegs->r[idx & REG_VAILD_MASK]);
            break;
        case REG_SAVED_REG:
            regNum = pstRegInfo->regLoc.reg;
            expResult = pstCoreRegsOld->r[regNum & REG_VAILD_MASK];
            coreRegs->r[idx & REG_VAILD_MASK] = expResult;
            SCD_DLOG_INF("REG_SAVED_REG %u %lx", idx, coreRegs->r[idx & REG_VAILD_MASK]);
            break;
        case REG_SAVED_EXP:
            expOpAddr = TraceReadUleb128(dwarf, pstRegInfo->regLoc.valExp, &insLen);
            SCD_CHK_EXPR_ACTION(expOpAddr == NULL, return TRACE_FAILURE, "read uleb128 failed");
            ret = TraceStackOpExc(dwarf, expOpAddr, expOpAddr + insLen, pstCoreRegsOld,
                                  &expResult, cfaAddr, args);
            SCD_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return ret, "stack op exec for add %p failed", expOpAddr);
            /* 异常到正常中间转接函数的unwind指令，由本层SP求出上层所有寄存器(包括SP)
             * 当求sp时不要覆盖，以免无法求8-16号寄存器 最后SP可有CFA求得 */
            if ((idx != VOS_R_SP) && (expResult != 0)) {
                size = ScdMemoryRead(NULL, expResult, &coreRegs->r[idx & REG_VAILD_MASK], sizeof(uint64_t));
                SCD_CHK_EXPR_ACTION(size == 0, return TRACE_FAILURE, "scd read memory failed 0x%llx", expResult);
            }
            SCD_DLOG_INF("REG_SAVED_EXP %u %lx", idx, coreRegs->r[idx & REG_VAILD_MASK]);
            break;
        case REG_SAVED_VAL_EXP:
            expOpAddr = TraceReadUleb128(dwarf, pstRegInfo->regLoc.valExp, &insLen);
            ret = TraceStackOpExc(dwarf, expOpAddr, expOpAddr + insLen, pstCoreRegsOld,
                                  &expResult, cfaAddr, args);
            SCD_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return ret, "stack op exec for add %p failed", expOpAddr);
            coreRegs->r[idx & REG_VAILD_MASK] = expResult;
            SCD_DLOG_INF("REG_SAVED_VAL_EXP %u %lx", idx, coreRegs->r[idx & REG_VAILD_MASK]);
            break;
        case REG_UNSAVED:
        case REG_UNDEFINED:
        default:
            break;
    }
    return TRACE_SUCCESS;
}

static inline bool TraceCheckStackAddrValid(uintptr_t cfaAddr, const ScdDwarfStepArgs *args)
{
    return cfaAddr >= args->stackMinAddr && cfaAddr < args->stackMaxAddr;
}

STATIC TraStatus TraceUnwinRegUpdate(ScdDwarf *dwarf, TraceFrameRegStateInfo *frameRegState,
    ScdRegs *regs, const ScdDwarfStepArgs *args)
{
    ScdRegs oldCoreRegArray;
    uintptr_t cfaAddr = 0;
    TraceGetCFAAddr(dwarf, frameRegState, regs, args, &cfaAddr);
    if (!TraceCheckStackAddrValid((uintptr_t)cfaAddr, args)) {
        SCD_DLOG_ERR("[CFA Addr] : %lx", cfaAddr);
        return TRACE_FAILURE;
    }
    SCD_DLOG_INF("[CFA Addr] : %lx", cfaAddr);
    for (uint32_t i = 0; i < TRACE_CORE_REG_NUM; i++) {
        oldCoreRegArray.r[i] = regs->r[i];
    }
    for (uint32_t i = 0; i < TRACE_CORE_REG_NUM; i++) {
        TraceStagRegInfo *regInfo = &(frameRegState->frameStateInfo.regInfo[i & REG_VAILD_MASK]);
        TraStatus ret = CallStackRegUpdate(dwarf, i, &oldCoreRegArray, regs, cfaAddr, regInfo, args);
        SCD_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return ret, "call stack register update failed");
    }
    if (frameRegState->frameStateInfo.regInfo[frameRegState->retColumn & REG_VAILD_MASK].regHow == REG_UNDEFINED)  {
        regs->r[frameRegState->retColumn & REG_VAILD_MASK] = 0;
    }
    regs->r[VOS_R_SP] = cfaAddr;
    return TRACE_SUCCESS;
}

STATIC TraStatus TraceCallstackParse(ScdDwarf *dwarf, uintptr_t pc, const ScdDwarfStepArgs *args,
    ScdRegs *regs, TraceFrameRegStateInfo *frameRegState, FDECtrlBlock *ctrlBlock)
{
    TraStatus ret;
    uintptr_t fdeAddr = ctrlBlock->unwindEntryAddr;
    TraceAddrRange initIns;
    TraceAddrRange ins;
    frameRegState->retColumn = 0;
    bool isFDEtable = false;
    ret = TraceParseFde(dwarf, fdeAddr, frameRegState, &initIns, &ins);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("TraceParseFde failed");
        return ret;
    }
    if (pc < frameRegState->pc || pc > frameRegState->pc + frameRegState->range) {
        SCD_DLOG_ERR("pc %llx is out of FDE range [%llx, %llx], possible missing CFI",
             pc, frameRegState->pc, frameRegState->pc + frameRegState->range);
        return TRACE_FAILURE;
    }
    frameRegState->ret = pc;
    ret = TraceUnwindParseFn(dwarf, &initIns, frameRegState, isFDEtable);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("TraceUnwindParseFn failed");
        return ret;
    }
    
    isFDEtable = true;
    ret = TraceUnwindParseFn(dwarf, &ins, frameRegState, isFDEtable);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("TraceUnwindParseFn failed");
        return ret;
    }
    ret = TraceUnwinRegUpdate(dwarf, frameRegState, regs, args);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("TraceUnwinRegUpdate failed");
        return ret;
    }
    return TRACE_SUCCESS;
}

STATIC FdeEntry *TraceSearchFdeOffsetTable(ScdDwarf *dwarf, uintptr_t tblStatAddr, uintptr_t pc)
{
    // pc may be smaller than enFrameAddr
    uintptr_t enFrameAddr = dwarf->memory->data + dwarf->ehFrameHdrOffset;
    FdeEntry *fdeItem = (FdeEntry *)tblStatAddr;
    size_t left = 0;
    size_t right = dwarf->fdeCount;
    size_t mid = (left + right) >> 1;
    uintptr_t midLocAddr = 0;
    SCD_DLOG_DBG("search pc 0x%llx", pc);
    while (left < right) {
        midLocAddr = GetAddrByOffset(enFrameAddr, fdeItem[mid].initLocOffset);
        SCD_DLOG_DBG("search in range [%d, %d], compare [%d] 0x%llx, offset 0x%x,",
            left, right, mid, midLocAddr, fdeItem[mid].initLocOffset);
        if (pc == midLocAddr) {
            SCD_DLOG_DBG("match fde[%d], start pc 0x%llx", mid, midLocAddr);
            return &fdeItem[mid];
        }
        if (pc < midLocAddr) {
            right = mid;
        } else {
            left = mid + 1U;
        }
        mid = (left + right) >> 1U;
    }
    mid = right > 0U ? right - 1U : 0U;
    SCD_DLOG_DBG("match fde[%d], start pc 0x%llx", mid, midLocAddr);
    return &fdeItem[mid];
}

/**
 * @brief   get next pc by dwarf and regs
 *
 * @param [in]  dwarf   The dwarf information of the dynamic library where the current PC is located
 * @param [in]  regs    register information of current frame
 * @param [in]  args    step arguments
 * @param [in]  pc      current pc
 * @param [out] nextPc  pc of next frame
 *
 * @return      : !=0 failure; ==0 success
 */
TraStatus ScdDwarfStep(ScdDwarf *dwarf, ScdRegs *regs, const ScdDwarfStepArgs *args, uintptr_t pc, uintptr_t *nextPc)
{
    FDECtrlBlock ctrlBlock;
    TraceFrameRegStateInfo frameRegState = {0};
    SCD_DLOG_INF("scd dwarf step with pc 0x%llx", pc);
    SCD_DLOG_INF("[eh_frame_hdr addr] : %llx, size %zu", dwarf->memory->data, dwarf->memory->size);
    TraceUnwindEhFrameHdrInfo ehFrameHdrInfo;
    if (TraceParseFrameHdrAddr(dwarf, &ehFrameHdrInfo) != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }
    // get fde by search table
    if (ehFrameHdrInfo.searchTblFlag == 1U) {
        SCD_DLOG_INF("has search table");
        uintptr_t ehFramrHdrAddr = dwarf->memory->data + dwarf->ehFrameHdrOffset;
        FdeEntry *entry = TraceSearchFdeOffsetTable(dwarf, ehFrameHdrInfo.tblStatAddr, pc);
        uintptr_t tmpAddr = GetAddrByOffset(ehFramrHdrAddr, entry->fdeTableOffset);
        SCD_CHK_EXPR_ACTION(tmpAddr == 0, return TRACE_FAILURE, "invalid offset %d", entry->fdeTableOffset);
        ctrlBlock.unwindEntryAddr = tmpAddr;
        tmpAddr = GetAddrByOffset(ehFramrHdrAddr, entry->initLocOffset);
        SCD_CHK_EXPR_ACTION(tmpAddr == 0, return TRACE_FAILURE, "invalid offset %d", entry->initLocOffset);
        ctrlBlock.funcStart = tmpAddr;
        SCD_DLOG_INF("[unwindEntryAddr] : %lx, funcStart : %lx", ctrlBlock.unwindEntryAddr, ctrlBlock.funcStart);
    } else {
        // process no search table
        STACKTRACE_LOG_ERR("no search table.");
        return TRACE_FAILURE;
    }
    uintptr_t tempSp = regs->r[VOS_R_SP];
    TraStatus ret = TraceCallstackParse(dwarf, pc, args, regs, &frameRegState, &ctrlBlock);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("call TraceCallstackParse failed");
        return TRACE_FAILURE;
    }
    *nextPc = regs->r[frameRegState.retColumn];
    if (*nextPc == 0) {
        SCD_DLOG_INF("next pc is 0, finished");
        return TRACE_SUCCESS;
    }
    if ((args->isFirstStack == false) && (tempSp == regs->r[VOS_R_SP])) {
        SCD_DLOG_INF("sp has not been changed");
        *nextPc = 0;
        return TRACE_SUCCESS;
    }
    SCD_DLOG_INF("[next pc addr] : 0x%lx", *nextPc);
    return TRACE_SUCCESS;
}