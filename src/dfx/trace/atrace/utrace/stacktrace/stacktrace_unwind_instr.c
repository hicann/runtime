/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stacktrace_unwind_instr.h"
#include <stdlib.h>
#include <pthread.h>
#include <fcntl.h>
#include <string.h>
#include <link.h>
#include "stacktrace_unwind.h"
#include "stacktrace_unwind_inner.h"
#include "stacktrace_fp.h"
#include "stacktrace_signal.h"
#include "stddef.h"
#include "securec.h"
#include "trace_system_api.h"
#include "adiag_utils.h"
#include "adiag_print.h"
#include "scd_log.h"
#include "scd_dwarf.h"

#define VOS_OP_DATA_TYPE_UINT8    1
#define VOS_OP_DATA_TYPE_UINT16   2
#define VOS_OP_DATA_TYPE_UINT32   4
#define VOS_OP_DATA_TYPE_UINT64   8

/**
 * @brief 解析栈操作类指令中的其他类型操作
 *
 * @param [in]  opType 操作类型
 * @param [in]  stackContent 操作栈内容
 * @param [in]  idx 操作栈索引
 * @param [in]  insAddr 指令地址
 * @param [in]  coreRegs 核心寄存器数组
 * @param [out] result 操作结果
 *
 * @return 指令地址
 */
STATIC const uint8_t *TraceOpStackOtherOpt(ScdDwarf *dwarf, uint8_t opType,
    const uintptr_t stackContent[VOS_OP_STACK_DEPTH], uint32_t *idx, const uint8_t *insAddr,
    const ScdRegs *coreRegs, uintptr_t *result)
{
    uintptr_t regData;
    uintptr_t resTmp;
    intptr_t  psvVal;
    uint16_t offset;
    const uint8_t *insAddrTmp = insAddr;
    uintptr_t tmpRes = 0;
    uint32_t  tmpIdx = *idx;

    switch (opType) {
        case DW_OP_REGX:
            insAddrTmp = TraceReadUleb128(dwarf, insAddrTmp, &regData);
            SCD_CHK_EXPR_ACTION(insAddrTmp == NULL, return NULL, "read uleb128 failed");
            tmpRes = (uintptr_t)coreRegs->r[regData & REG_VAILD_MASK];
            break;
        case DW_OP_BREGX:
            insAddrTmp = TraceReadUleb128(dwarf, insAddrTmp, &regData);
            SCD_CHK_EXPR_ACTION(insAddrTmp == NULL, return NULL, "read uleb128 failed");
            insAddrTmp = TraceReadLeb128(dwarf, insAddrTmp, &psvVal);
            SCD_CHK_EXPR_ACTION(insAddrTmp == NULL, return NULL, "read leb128 failed");
            tmpRes = coreRegs->r[regData & REG_VAILD_MASK] + (uintptr_t)psvVal;
            break;
        /* 无编码类型的地址 */
        case DW_OP_ADDR:
            tmpRes = TraceReadUintptr(insAddrTmp, sizeof(uintptr_t));
            insAddrTmp = insAddrTmp + sizeof(void *);
            break;
        case DW_OP_GNU_ENC_ADDR:
            /* 该地址第一个字节表示编码类型，从第二字节开始才表示该编码类型时的数据 */
            insAddrTmp = TraceReadEncodeValue(dwarf, *insAddrTmp, insAddrTmp + 1, &resTmp);
            tmpRes = resTmp;
            break;
        /* dw_op指令跳转 */
        case DW_OP_SKIP:
            offset = TraceReadU16(insAddrTmp, sizeof(uint16_t));
            insAddrTmp += sizeof(uint16_t);
            insAddrTmp += offset;
            break;
        /* dw_op指令依条件跳转 */
        case DW_OP_BRA:
            TRACE_STACK_INDEX_CHECK_RET(tmpIdx, 1U, { return NULL; });
            tmpIdx  = tmpIdx - 1U;
            offset = TraceReadU16(insAddrTmp, sizeof(uint16_t));
            insAddrTmp += sizeof(uint16_t);
            if (stackContent[(tmpIdx & VOS_OP_STACK_MASK)] != 0) {
                insAddrTmp += offset;
            }
            break;
        case DW_OP_NOP:
        default:
            break;
    }
    *result = tmpRes;
    *idx = tmpIdx;
    return insAddrTmp;
}

/**
 * @brief 解析栈操作类指令中两个操作数的高级操作
 *
 * @param [in]  opType 操作类型
 * @param [in]  swapTmp1 栈数据1
 * @param [in]  swapTmp2 栈数据2
 * @param [out] result 操作结果
 *
 * @return 指令地址
 */
STATIC void TraceOpStackTwoDataParseAdvanced(uint8_t opType, uintptr_t swapTmp1,
    uintptr_t swapTmp2, uintptr_t *result)
{
    uintptr_t tmpRes = 0;

    switch (opType) {
        case DW_OP_SHL:
            tmpRes = (uintptr_t)(swapTmp1 << swapTmp2);
            break;
        case DW_OP_SHR:
        case DW_OP_SHRA:
            tmpRes = (uintptr_t)(swapTmp1 >> swapTmp2);
            break;
        case DW_OP_XOR:
            tmpRes = (uintptr_t)(swapTmp1 ^ swapTmp2);
            break;
        case DW_OP_LE:
            tmpRes = (uintptr_t)(swapTmp1 <= swapTmp2);
            break;
        case DW_OP_GE:
            tmpRes = (uintptr_t)(swapTmp1 >= swapTmp2);
            break;
        case DW_OP_EQ:
            tmpRes = (uintptr_t)(swapTmp1 == swapTmp2);
            break;
        case DW_OP_LT:
            tmpRes = (uintptr_t)(swapTmp1 < swapTmp2);
            break;
        case DW_OP_GT:
            tmpRes = (uintptr_t)(swapTmp1 > swapTmp2);
            break;
        case DW_OP_NE:
            tmpRes = (uintptr_t)(swapTmp1 != swapTmp2);
            break;
        default:
            break;  // will never be executed
    }
    *result = tmpRes;
    return;
}


/**
 * @brief 解析栈操作类指令中两个操作数的基础操作
 *
 * @param [in]  opType 操作类型
 * @param [in]  swapTmp1 栈数据1
 * @param [in]  swapTmp2 栈数据2
 * @param [out] result 操作结果
 *
 * @return 指令地址
 */
STATIC TraStatus TraceOpStackTwoDataParseBasic(uint8_t opType, uintptr_t swapTmp1,
    uintptr_t swapTmp2, uintptr_t *result)
{
    uintptr_t tmpRes = 0;
    TraStatus ret = TRACE_SUCCESS;

    switch (opType) {
        case DW_OP_AND:
            tmpRes = swapTmp1 & swapTmp2;
            break;
        case DW_OP_DIV:
            if (swapTmp2 == 0) {
                return TRACE_FAILURE;
            }
            tmpRes = swapTmp1 / swapTmp2;
            break;

        case DW_OP_MINUS:
            tmpRes = (uintptr_t)(swapTmp1 - swapTmp2);
            break;
        case DW_OP_MOD:
            if (swapTmp2 == 0) {
                return TRACE_FAILURE;
            }
            tmpRes = (uintptr_t)(swapTmp1 % swapTmp2);
            break;
        case DW_OP_MUL:
            tmpRes = (uintptr_t)(swapTmp1 * swapTmp2);
            break;
        case DW_OP_OR:
            tmpRes = (uintptr_t)(swapTmp1 | swapTmp2);
            break;
        case DW_OP_PLUS:
            tmpRes = (uintptr_t)(swapTmp1 + swapTmp2);
            break;
        default:
            ret = TRACE_FAILURE;
            break;  // will never be executed
    }
    *result = tmpRes;
    return ret;
}

/**
 * @brief 解析栈操作类指令中两个操作数的操作
 *
 * @param [in]  opType 操作类型
 * @param [in]  swapTmp1 栈数据1
 * @param [in]  swapTmp2 栈数据2
 * @param [out] result 操作结果
 *
 * @return 指令地址
 */
STATIC TraStatus TraceOpStackTwoDataParse(uint8_t opType, uintptr_t swapTmp1, uintptr_t swapTmp2,
    uintptr_t *result)
{
    uintptr_t tmpRes = 0;
    TraStatus ret;

    if (VOS_ENC_OP_TWO_DATA1(opType)) {
        ret = TraceOpStackTwoDataParseBasic(opType, swapTmp1, swapTmp2, &tmpRes);
        if (ret != TRACE_SUCCESS) {
            return ret;
        }
    } else if (VOS_ENC_OP_TWO_DATA2(opType)) {
        TraceOpStackTwoDataParseAdvanced(opType, swapTmp1, swapTmp2, &tmpRes);
    } else {
        return TRACE_FAILURE;
    }
    *result = tmpRes;
    return TRACE_SUCCESS;
}

/**
 * @brief 处理栈操作类指令中两个操作数的操作
 *
 * @param [in]  opType 操作类型
 * @param [in]  stackContent 栈信息
 * @param [in]  idx      栈索引
 * @param [out] result 操作结果
 *
 * @return 指令地址
 */
STATIC TraStatus TraceOpStackTwoDataOpt(uint8_t opType, uintptr_t stackContent[VOS_OP_STACK_DEPTH],
    uint32_t *idx, uintptr_t *result)
{
    uintptr_t swapTmp1;
    uintptr_t swapTmp2;
    uintptr_t tmpRes = 0;
    TraStatus ret = TRACE_SUCCESS;
    uint32_t tmpIdx = *idx;

    switch (opType) {
        /* 逻辑处理 */
        case DW_OP_AND:
        case DW_OP_DIV:
        case DW_OP_MINUS:
        case DW_OP_MOD:
        case DW_OP_MUL:
        case DW_OP_OR:
        case DW_OP_PLUS:
        case DW_OP_SHL:
        case DW_OP_SHR:
        case DW_OP_SHRA:
        case DW_OP_XOR:
        case DW_OP_LE:
        case DW_OP_GE:
        case DW_OP_EQ:
        case DW_OP_LT:
        case DW_OP_GT:
        case DW_OP_NE:
            if (tmpIdx < 2) { /* 2保证数组下标不为负数 */
                return TRACE_FAILURE;
            }
            swapTmp1 = stackContent[(tmpIdx - 2U) & VOS_OP_STACK_MASK]; /* 2是偏移量 */
            swapTmp2 = stackContent[(tmpIdx - 1U) & VOS_OP_STACK_MASK];
            tmpIdx = tmpIdx - 2U;  /* 2是偏移量 */
            ret = TraceOpStackTwoDataParse(opType, swapTmp1, swapTmp2, &tmpRes);
            break;
        default:
            ret = TRACE_FAILURE;
            break;
    }
    *result = tmpRes;
    *idx = tmpIdx;
    return ret;
}

STATIC TraStatus TraceDefSizeGet(const uint8_t ucEncode, uintptr_t pDataAddr, uintptr_t *result)
{
    uintptr_t tmpRes = 0;
    TraStatus ret = TRACE_SUCCESS;
    switch (ucEncode) {
        case VOS_OP_DATA_TYPE_UINT8:
            tmpRes = (uintptr_t)(*(uint8_t *)pDataAddr);
            break;
        case VOS_OP_DATA_TYPE_UINT16:
            tmpRes = (uintptr_t)(*(uint16_t *)pDataAddr);
            break;
        case VOS_OP_DATA_TYPE_UINT32:
            tmpRes = (uintptr_t)(*(uint32_t *)pDataAddr);
            break;
        case VOS_OP_DATA_TYPE_UINT64:
            tmpRes = (uintptr_t)(*(uint64_t *)pDataAddr);
            break;
        default:
            ret = TRACE_FAILURE;
            break;
    }
    *result = tmpRes;
    return ret;
}

/**
 * @brief 解析栈操作类指令中一个操作数的操作
 *
 * @param [in]  opType 操作类型
 * @param [in]  tmpRes  栈数据
 * @param [in]  insAddr 指令地址
 * @param [in]  pstStackLimit 栈地址限制
 * @param [out] result 操作结果
 *
 * @return 指令地址
 */
STATIC const uint8_t *TraceOpStackOneDataParse(ScdDwarf *dwarf, uint8_t opType, uintptr_t tmpRes,
    const uint8_t *insAddr, const ScdDwarfStepArgs *args, uintptr_t *result)
{
    uintptr_t tmp;
    uintptr_t res = 0;
    intptr_t tmpSignedValue;
    TraStatus ret;
    const uint8_t *insAddrTmp = insAddr;

    switch (opType) {
        case DW_OP_DEREF:
            if (TRACE_STACK_ADDR_INVALID_CHECK(args, tmpRes)) {
                return NULL;
            }
            size_t size = ScdMemoryRead(NULL, tmpRes, &res, sizeof(uintptr_t));
            SCD_CHK_EXPR_ACTION(size == 0, return NULL, "scd read memory failed 0x%llx", tmpRes);
            break;
        /* 根据地址所指类型取值,注意地址合法性 */
        case DW_OP_DEREF_SIZE:
            if (TRACE_STACK_ADDR_INVALID_CHECK(args, tmpRes)) {
                return NULL;
            }
            ret = TraceDefSizeGet(*insAddrTmp, tmpRes, &res);
            insAddrTmp++;
            if (ret != TRACE_SUCCESS) {
                return NULL;
            }
            break;
        case DW_OP_ABS:
            tmpSignedValue = (intptr_t)tmpRes;
            if (tmpSignedValue < 0) {
                tmpSignedValue = -tmpSignedValue;
            }
            res = (uintptr_t)tmpSignedValue;
            break;
        case DW_OP_NEG:
            tmpSignedValue = (intptr_t)tmpRes;
            tmpSignedValue = -tmpSignedValue;
            res = (uintptr_t)tmpSignedValue;
            break;
        case DW_OP_NOT:
            res = ~tmpRes;
            break;
        /* 数据相加一常数 */
        case DW_OP_PLUS_UCONST:
            insAddrTmp = TraceReadUleb128(dwarf, insAddrTmp, &tmp);
            SCD_CHK_EXPR_ACTION(insAddrTmp == NULL, return NULL, "read uleb128 failed");
            res = tmp + tmpRes;
            break;
        default:
            insAddrTmp = NULL;
            break;  // will never be executed
    }
    *result = res;
    return insAddrTmp;
}

/**
 * @brief 处理栈操作类指令中一个操作数的操作
 *
 * @param [in]  opType 操作类型
 * @param [in]  stackContent  栈数据
 * @param [in]  idx   栈索引
 * @param [in]  insAddr 指令地址
 * @param [in]  pstStackLimit 栈地址限制
 * @param [out] result 操作结果
 *
 * @return 指令地址
 */
STATIC const uint8_t *TraceOpStackOneDataOpt(ScdDwarf *dwarf, uint8_t opType, uintptr_t stackContent[VOS_OP_STACK_DEPTH],
    uint32_t *idx, const uint8_t *insAddr, const ScdDwarfStepArgs *args, uintptr_t *result)
{
    uintptr_t indircRes;
    uintptr_t dircRes = 0;
    uint32_t tmpIdx = *idx;
    const uint8_t *insAddrTmp = insAddr;

    switch (opType) {
        case DW_OP_DEREF:
        case DW_OP_DEREF_SIZE:
        case DW_OP_ABS:
        case DW_OP_NEG:
        case DW_OP_NOT:
        case DW_OP_PLUS_UCONST:
            TRACE_STACK_INDEX_CHECK_RET(tmpIdx, 1U, { return NULL; });
            indircRes = stackContent[(tmpIdx - 1U) & VOS_OP_STACK_MASK];
            tmpIdx = tmpIdx - 1U;
            insAddrTmp = TraceOpStackOneDataParse(dwarf, opType, indircRes, insAddrTmp, args, &dircRes);
            TRACE_UNWIND_PARSE_ADDR_CHECK_OR_RETURN(insAddrTmp);
            break;
        default:
            insAddrTmp = NULL;
            break;
    }

    *result = dircRes;
    *idx = tmpIdx;

    return insAddrTmp;
}

/**
 * @brief 处理栈操作类指令
 *
 * @param [in]  opType 操作类型
 * @param [in]  stackContent  栈数据
 * @param [in]  idx   栈索引
 * @param [in]  insAddr 指令地址
 * @param [out] result 操作结果
 *
 * @return 指令地址
 */
STATIC const uint8_t *TraceOpStackDataOpt(uint8_t opType, uintptr_t stackContent[VOS_OP_STACK_DEPTH],
    uint32_t *idx, const uint8_t *insAddr, uintptr_t *result)
{
    uintptr_t swapTmp, swapTmp1, swapTmp2, swapTmp3;
    uint32_t offset;
    const uint8_t *insAddrTmp = insAddr;
    uintptr_t tmpRes = 0;
    uint32_t tmpIdx = *idx;

    switch (opType) {
        /* 在栈顶复制一份数据 */
        case DW_OP_DUP:
            TRACE_STACK_INDEX_CHECK_RET(tmpIdx, 1U, { return NULL; });
            tmpRes = stackContent[(tmpIdx - 1U) & VOS_OP_STACK_MASK];
            break;
        /* 栈顶弹出数据 */
        case DW_OP_DROP:
            TRACE_STACK_INDEX_CHECK_RET(tmpIdx, 1U, { return NULL; });
            tmpRes = stackContent[(tmpIdx - 1U) & VOS_OP_STACK_MASK];
            tmpIdx = tmpIdx - 1U;
            break;
        /* 从栈中间获取一数据 */
        case DW_OP_PICK:
            offset = (uint32_t)(*(uint8_t *)(uintptr_t)insAddrTmp);
            insAddrTmp++;
            TRACE_STACK_INDEX_CHECK_RET(tmpIdx, offset + 2U, { return NULL; });
            tmpRes = stackContent[(tmpIdx - offset - 1U) & VOS_OP_STACK_MASK];
            break;
        /* 从栈顶的一层取数据 */
        case DW_OP_OVER:
            TRACE_STACK_INDEX_CHECK_RET(tmpIdx, 2U, { return NULL; });
            tmpRes = stackContent[(tmpIdx - 2U) & VOS_OP_STACK_MASK]; /* 2表示偏移 */
            break;
        /* 交换数据 */
        case DW_OP_SWAP:
            TRACE_STACK_INDEX_CHECK_RET(tmpIdx, 2U, { return NULL; });
            swapTmp = stackContent[(tmpIdx - 2U) & VOS_OP_STACK_MASK]; /* 2表示偏移 */
            /* 2表示偏移 */
            stackContent[(tmpIdx - 2U) & VOS_OP_STACK_MASK] = stackContent[(tmpIdx - 1U) & VOS_OP_STACK_MASK];
            stackContent[(tmpIdx - 1U) & VOS_OP_STACK_MASK] = swapTmp;
            break;
        case DW_OP_ROT:
            TRACE_STACK_INDEX_CHECK_RET(tmpIdx, 3U, { return NULL; });
            swapTmp1 = stackContent[(tmpIdx - 1U) & VOS_OP_STACK_MASK];
            swapTmp2 = stackContent[(tmpIdx - 2U) & VOS_OP_STACK_MASK]; /* 2表示偏移 */
            swapTmp3 = stackContent[(tmpIdx - 3U) & VOS_OP_STACK_MASK]; /* 3表示偏移 */
            stackContent[(tmpIdx - 1U) & VOS_OP_STACK_MASK] = swapTmp2;
            stackContent[(tmpIdx - 2U) & VOS_OP_STACK_MASK] = swapTmp3; /* 2表示偏移 */
            stackContent[(tmpIdx - 3U) & VOS_OP_STACK_MASK] = swapTmp1; /* 3表示偏移 */
            break;
        default:
            insAddrTmp = NULL;
            break;  // will never be executed
    }
    *idx = tmpIdx;
    *result = tmpRes;
    return insAddrTmp;
}

/**
 * @brief 根据操作类型获取常数操作数
 *
 * @param [in]  opType 操作类型
 * @param [in]  insAddr 指令地址
 * @param [out] result 操作结果
 *
 * @return 指令地址
 */
STATIC const uint8_t *TraceOpConstNumGet(ScdDwarf *dwarf, uint8_t opType, const uint8_t *insAddr, uintptr_t *result)
{
    uintptr_t tmp;
    intptr_t tmpSignedValue;
    const uint8_t *insAddrTmp = insAddr;
    uintptr_t *resultTmp = result;

    switch (opType) {
        case DW_OP_COUST1U:
            *resultTmp = (uintptr_t)(*(uint8_t *)(uintptr_t)insAddrTmp);
            insAddrTmp += sizeof(uint8_t);
            break;
        case DW_OP_COUST1S:
            *resultTmp = (uintptr_t)(*(int8_t *)(uintptr_t)insAddrTmp);
            insAddrTmp += sizeof(int8_t);
            break;
        case DW_OP_COUST2U:
            *resultTmp = (uintptr_t)TraceReadU16(insAddrTmp, sizeof(uint16_t));
            insAddrTmp += sizeof(uint16_t);
            break;
        case DW_OP_COUST2S:
            *resultTmp = (uintptr_t)TraceReadS16(insAddrTmp, sizeof(int16_t));
            insAddrTmp += sizeof(int16_t);
            break;
        case DW_OP_COUST4U:
            *resultTmp = (uintptr_t)TraceReadU32(insAddrTmp, sizeof(uint32_t));
            insAddrTmp += sizeof(uint32_t);
            break;
        case DW_OP_COUST4S:
            *resultTmp = (uintptr_t)TraceReadS32(insAddrTmp, sizeof(int32_t));
            insAddrTmp += sizeof(int32_t);
            break;
        case DW_OP_COUST8U:
            *resultTmp = (uintptr_t)TraceReadU64(insAddrTmp, sizeof(uint64_t));
            insAddrTmp += sizeof(uint64_t);
            break;
        case DW_OP_COUST8S:
            *resultTmp = (uintptr_t)TraceReadS64(insAddrTmp, sizeof(int64_t));
            insAddrTmp += sizeof(int64_t);
            break;
        case DW_OP_COUSTU:
            insAddrTmp = TraceReadUleb128(dwarf, insAddrTmp, &tmp);
            SCD_CHK_EXPR_ACTION(insAddrTmp == NULL, return NULL, "read uleb128 failed");
            *resultTmp = (uintptr_t)tmp;
            break;
        case DW_OP_COUSTS:
            insAddrTmp = TraceReadLeb128(dwarf, insAddrTmp, &tmpSignedValue);
            SCD_CHK_EXPR_ACTION(insAddrTmp == NULL, return NULL, "read leb128 failed");
            *resultTmp = (uintptr_t)tmpSignedValue;
            break;
        default:
            *resultTmp = 0;
            insAddrTmp = NULL;
            break;  // will never be executed
    }
    return insAddrTmp;
}

/**
 * @brief 解析操作码
 *
 * @param [in]  opType 操作类型
 * @param [in]  instr 指令地址
 * @param [out] pstFrameRInfo 推栈状态信息结构体
 *
 * @return 指令地址
 */
STATIC const uint8_t *TraceUnwindOpcodeParse(ScdDwarf *dwarf, uint8_t opcode, const uint8_t *instr,
    TraceFrameRegStateInfo *pstFrameRInfo)
{
    uintptr_t offsetTemp;
    intptr_t  offset;
    const uint8_t *tmpInstr = instr;
    uint8_t   ucRegNum;

    switch (TRACE_HIBIT2_OPCODE(opcode)) {
        /* 定位PC位置 */
        case DW_CFA_ADVANCE_LOC:
            pstFrameRInfo->pc += TRACE_LOBIT6_OPCODE((uintptr_t)opcode) * pstFrameRInfo->codeAlign;
            SCD_DLOG_INF("DW_CFA_ADVANCE_LOC %lu to %lx",
                TRACE_LOBIT6_OPCODE((uintptr_t)opcode) * pstFrameRInfo->codeAlign, pstFrameRInfo->pc);
            break;
        /* 依据CFA偏移量获取寄存器的值 */
        case DW_CFA_OFFSET:
            ucRegNum = (uint8_t)TRACE_LOBIT6_OPCODE(opcode);
            tmpInstr = TraceReadUleb128(dwarf, tmpInstr, &offsetTemp);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read uleb128 failed");
            offset = (intptr_t)offsetTemp * pstFrameRInfo->dataAlign;
            pstFrameRInfo->frameStateInfo.regInfo[ucRegNum & REG_VAILD_MASK].regHow = REG_SAVED_OFFSET;
            pstFrameRInfo->frameStateInfo.regInfo[ucRegNum & REG_VAILD_MASK].regLoc.offset  = offset;
            SCD_DLOG_INF("DW_CFA_OFFSET reg %hhu at %ld", ucRegNum,  offsetTemp);
            break;
        /* 指定寄存器信息不保存 */
        case DW_CFA_RESTORE:
            ucRegNum = (uint8_t)TRACE_LOBIT6_OPCODE(opcode);
            pstFrameRInfo->frameStateInfo.regInfo[ucRegNum & REG_VAILD_MASK].regHow = REG_UNSAVED;
            SCD_DLOG_INF("DW_CFA_RESTORE reg %hhu ", ucRegNum);
            break;
        default:
            tmpInstr = NULL;
            break;
    }

    return tmpInstr;
}

/**
 * @brief 解析PC位置信息
 *
 * @param [in]  opcode 操作类型
 * @param [in]  instr 指令地址
 * @param [out] pstFrameRInfo 推栈状态信息结构体
 *
 * @return 指令地址
 */
STATIC const uint8_t *TraceUnwindPCLocParse(ScdDwarf *dwarf, uint8_t opcode, const uint8_t *instr,
    TraceFrameRegStateInfo *pstFrameRInfo)
{
    uintptr_t pc;
    const uint8_t *tmpInstr = instr;

    switch (opcode) {
        /* 直接设置PC指针的位置 */
        case DW_CFA_SET_LOC:
            tmpInstr = TraceReadEncodeValue(dwarf, pstFrameRInfo->fdeEnc, tmpInstr, &pc);
            if (tmpInstr == NULL) {
                return NULL;
            }
            pstFrameRInfo->pc = pc;
            SCD_DLOG_INF("DW_CFA_SET_LOC %lx", pc);
            break;
        case DW_CFA_ADVANCE_LOC1:
            pstFrameRInfo->pc += *tmpInstr * pstFrameRInfo->codeAlign;
            SCD_DLOG_INF("DW_CFA_ADVANCE_LOC1 %lu to %lx", *tmpInstr * pstFrameRInfo->codeAlign, pstFrameRInfo->pc);
            tmpInstr += sizeof(uint8_t);
            break;
        case DW_CFA_ADVANCE_LOC2:
            pstFrameRInfo->pc += TraceReadU16(tmpInstr, sizeof(uint16_t)) * pstFrameRInfo->codeAlign;
            tmpInstr += sizeof(uint16_t);
            break;
        case DW_CFA_ADVANCE_LOC4:
            pstFrameRInfo->pc += TraceReadU32(tmpInstr, sizeof(uint32_t)) * pstFrameRInfo->codeAlign;
            tmpInstr += sizeof(uint32_t);
            break;
        default:
            tmpInstr = NULL;
            break;
    }

    return tmpInstr;
}

/**
 * @brief 解析CFA信息
 *
 * @param [in]  opcode 操作类型
 * @param [in]  instr 指令地址
 * @param [out] pstFrameRInfo 推栈状态信息结构体
 *
 * @return 指令地址
 */
STATIC const uint8_t *TraceUnwindCFADefParse(ScdDwarf *dwarf, uint8_t opcode, const uint8_t *instr,
    TraceFrameRegStateInfo *pstFrameRInfo)
{
    uintptr_t regTmp;
    uintptr_t offsetTemp;
    intptr_t  offset;
    const uint8_t *tmpInstr = instr;

    switch (opcode) {
        /* 获取CFA所需的寄存器和偏移 */
        case DW_CFA_DEF_CFA:
            tmpInstr = TraceReadUleb128(dwarf, tmpInstr, &regTmp);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read uleb128 failed");
            pstFrameRInfo->frameStateInfo.cfaReg = regTmp;
            tmpInstr = TraceReadUleb128(dwarf, tmpInstr, &offsetTemp);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read uleb128 failed");
            pstFrameRInfo->frameStateInfo.cfaOffset = (intptr_t)offsetTemp;
            pstFrameRInfo->frameStateInfo.cfaHow = VOS_CFA_REG_OFFSET;
            SCD_DLOG_INF("DW_CFA_DEF_CFA %lu %lu", regTmp, offsetTemp);
            break;
        /* DWARF3指令，操作数是负数 */
        case DW_CFA_DEF_CFA_SF:
            tmpInstr = TraceReadUleb128(dwarf, tmpInstr, &regTmp);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read uleb128 failed");
            pstFrameRInfo->frameStateInfo.cfaReg = regTmp;
            tmpInstr = TraceReadLeb128(dwarf, tmpInstr, &offset);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read leb128 failed");
            offset = (intptr_t)(offset * pstFrameRInfo->dataAlign);
            pstFrameRInfo->frameStateInfo.cfaOffset = offset;
            pstFrameRInfo->frameStateInfo.cfaHow = VOS_CFA_REG_OFFSET;
            SCD_DLOG_INF("DW_CFA_DEF_CFA_SF %lu %ld", regTmp, offset);
            break;
        /* 获取CFA所需的寄存器 */
        case DW_CFA_DEF_CFA_REGISTER:
            tmpInstr = TraceReadUleb128(dwarf, tmpInstr, &regTmp);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read uleb128 failed");
            pstFrameRInfo->frameStateInfo.cfaReg = regTmp;
            pstFrameRInfo->frameStateInfo.cfaHow = VOS_CFA_REG_OFFSET;
            SCD_DLOG_INF("DW_CFA_DEF_CFA_REGISTER %lu", regTmp);
            break;
        /* 获取CFA所需的偏移 */
        case DW_CFA_DEF_CFA_OFFSET:
            tmpInstr = TraceReadUleb128(dwarf, tmpInstr, &offsetTemp);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read uleb128 failed");
            pstFrameRInfo->frameStateInfo.cfaOffset = (intptr_t)offsetTemp;
            SCD_DLOG_INF("DW_CFA_DEF_CFA_OFFSET %lu", offsetTemp);
            break;
        case DW_CFA_DEF_CFA_OFFSET_SF:
            tmpInstr = TraceReadLeb128(dwarf, tmpInstr, &offset);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read leb128 failed");
            offset = (intptr_t)(offset * pstFrameRInfo->dataAlign);
            pstFrameRInfo->frameStateInfo.cfaOffset = offset;
            SCD_DLOG_INF("DW_CFA_DEF_CFA_OFFSET_SF %ld", offset);
            break;
        /* 通过DW_OP 指令获取CFA */
        case DW_CFA_DEF_CFA_EXPRESSION:
            pstFrameRInfo->frameStateInfo.cfaExp = tmpInstr;
            pstFrameRInfo->frameStateInfo.cfaHow = VOS_CFA_EXP;
            tmpInstr = TraceReadUleb128(dwarf, tmpInstr, &offsetTemp);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read uleb128 failed");
            tmpInstr += offsetTemp;
            SCD_DLOG_INF("DW_CFA_DEF_CFA_EXPRESSION %lu", offsetTemp);
            break;
        default:
            tmpInstr = NULL;
            break;
    }

    return tmpInstr;
}

/**
 * @brief 解析寄存器定义信息
 *
 * @param [in]  opcode 操作类型
 * @param [in]  instr 指令地址
 * @param [out] pstFrameRInfo 推栈状态信息结构体
 *
 * @return 指令地址
 */
STATIC const uint8_t *TraceUnwindRegValueDefParse(ScdDwarf *dwarf, uint8_t opcode, const uint8_t *instr,
    TraceFrameRegStateInfo *pstFrameRInfo)
{
    uintptr_t regTmp;
    uintptr_t offsetTemp;
    intptr_t  offset;
    const uint8_t *tmpInstr = instr;
    TraceStagRegInfo *pstRegInfo = NULL;
    switch (opcode) {
        /* 依据CFA的值获取寄存器信息 */
        case DW_CFA_VAL_OFFSET:
            tmpInstr = TraceReadUleb128(dwarf, tmpInstr, &regTmp);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read uleb128 failed");
            tmpInstr = TraceReadUleb128(dwarf, tmpInstr, &offsetTemp);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read uleb128 failed");
            offset = (intptr_t)offsetTemp * pstFrameRInfo->dataAlign;
            pstRegInfo = &(pstFrameRInfo->frameStateInfo.regInfo[regTmp & REG_VAILD_MASK]);
            pstRegInfo->regHow = REG_SAVED_VAL_OFFSET;
            pstRegInfo->regLoc.offset = offset;
            SCD_DLOG_INF("DW_CFA_VAL_OFFSET");
            break;
        case DW_CFA_VAL_OFFSET_SF:
            tmpInstr = TraceReadUleb128(dwarf, tmpInstr, &regTmp);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read uleb128 failed");
            tmpInstr = TraceReadLeb128(dwarf, tmpInstr, &offset);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read leb128 failed");
            offset = (intptr_t)(offset * pstFrameRInfo->dataAlign);
            pstRegInfo = &(pstFrameRInfo->frameStateInfo.regInfo[regTmp & REG_VAILD_MASK]);
            pstRegInfo->regHow = REG_SAVED_VAL_OFFSET;
            pstRegInfo->regLoc.offset = offset;
            SCD_DLOG_INF("DW_CFA_VAL_OFFSET_SF");
            break;
        case DW_CFA_VAL_EXPRESSION:
            tmpInstr = TraceReadUleb128(dwarf, tmpInstr, &regTmp);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read uleb128 failed");
            pstRegInfo = &(pstFrameRInfo->frameStateInfo.regInfo[regTmp & REG_VAILD_MASK]);
            pstRegInfo->regHow = REG_SAVED_VAL_EXP;
            pstRegInfo->regLoc.valExp = tmpInstr;

            tmpInstr = TraceReadUleb128(dwarf, tmpInstr, &offsetTemp);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read uleb128 failed");
            tmpInstr += offsetTemp;
            SCD_DLOG_INF("DW_CFA_VAL_EXPRESSION");
            break;
        default:
            tmpInstr = NULL;
            break;
    }

    return tmpInstr;
}

/**
 * @brief 解析其他类型的操作码
 *
 * @param [in]  opcode 操作类型
 * @param [in]  instr 指令地址
 * @param [in]  pstStoreFrameRegState 上一轮推栈状态信息结构体
 * @param [out] pstFrameRInfo 推栈状态信息结构体
 *
 * @return 指令地址
 */
STATIC const uint8_t *TraceUnwindOtherCodeParse(ScdDwarf *dwarf, uint8_t opcode, const uint8_t *instr,
    TraceFrameStateInfo *pstStoreFrameRegState, TraceFrameRegStateInfo *pstFrameRInfo)
{
    uintptr_t offsetTemp = 0;
    TraceStagRegInfo *pstRegInfo = NULL;
    const uint8_t *tmpInstr = instr;

    switch (opcode) {
        case DW_CFA_NOP:
            SCD_DLOG_INF("DW_CFA_NOP");
            break;
        /* 将寄存器组的设置状态放在链表前与DW_CFA_RES_STATE配对 */
        case DW_CFA_REMEMBER_STATE:
            (void)memcpy_s((void *)pstStoreFrameRegState, sizeof(TraceFrameStateInfo),
                (void *)&pstFrameRInfo->frameStateInfo, sizeof(TraceFrameStateInfo));
            SCD_DLOG_INF("DW_CFA_REMEMBER_STATE");
            break;
        /* 将链表中最前面的寄存器组设置信息取出，与DW_CFA_REM_STATE配对使用 */
        case DW_CFA_RESTORE_STATE:
            (void)memcpy_s((void *)&pstFrameRInfo->frameStateInfo, sizeof(TraceFrameStateInfo),
                (void *)pstStoreFrameRegState, sizeof(TraceFrameStateInfo));
            SCD_DLOG_INF("DW_CFA_RESTORE_STATE");
            break;
        /*
         * 该指令只用于sun系列的SPARC架构,i686不涉及
         * 从16号寄存器到31号寄存器号寄存器偏移值计算方法
         * 16 不是魔鬼数字 表示16号寄存器
         */
        case DW_CFA_GNU_WIN_SAVE:
            for (uint32_t idx = 16U; idx < VOS_CORE_REGS_NUM; idx++) { /* 16代表寄存器 */
                pstRegInfo = &(pstFrameRInfo->frameStateInfo.regInfo[idx & REG_VAILD_MASK]);
                pstRegInfo->regHow = REG_SAVED_OFFSET;
                pstRegInfo->regLoc.offset = ((intptr_t)idx - 16LL) * (intptr_t)sizeof(void *); /* 16代表寄存器 */
            }
            SCD_DLOG_INF("DW_CFA_GNU_WIN_SAVE");
            break;
        /* 当CPU为cr16c时，才有该unwind指令，i686没有该指令 */
        case DW_CFA_GNU_ARG_SIZE:
            tmpInstr = TraceReadUleb128(dwarf, tmpInstr, &offsetTemp);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read uleb128 failed");
            SCD_DLOG_INF("DW_CFA_GNU_ARG_SIZE");
            break;
        default:
            tmpInstr = NULL;
            break;
    }

    return tmpInstr;
}

/**
 * @brief 解析关于寄存器的unwind操作码
 *
 * @param [in]  opcode 操作类型
 * @param [in]  instr 指令地址
 * @param [out] pstInfo 推栈状态信息结构体
 *
 * @return 指令地址
 */
STATIC const uint8_t *TraceUnwindRegDefParse(ScdDwarf *dwarf, uint8_t opcode, const uint8_t *instr, TraceFrameRegStateInfo *pstInfo)
{
    intptr_t offset;
    uintptr_t regTmp;
    TraceStagRegInfo *pstRegInfo = NULL;
    const uint8_t *tmpInstr = instr;

    tmpInstr = TraceReadUleb128(dwarf, tmpInstr, &regTmp);
    pstRegInfo = &(pstInfo->frameStateInfo.regInfo[regTmp & REG_VAILD_MASK]);

    switch (opcode) {
        /* 扩展类型: 依据CFA偏移量获取寄存器 */
        case DW_CFA_OFFSET_EXTENDED:
            tmpInstr = TraceReadUleb128(dwarf, tmpInstr, &regTmp);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read uleb128 failed");
            offset = (intptr_t)regTmp * pstInfo->dataAlign;
            pstRegInfo->regHow = REG_SAVED_OFFSET;
            pstRegInfo->regLoc.offset = offset;
            SCD_DLOG_INF("reg[%lu] DW_CFA_OFFSET_EXTENDED %lx", regTmp & REG_VAILD_MASK, regTmp);
            break;
        /* dwarf3 新增的unwind指令，操作数有有符号leb128类型 */
        case DW_CFA_OFF_EXTENDED_SF:
            tmpInstr = TraceReadLeb128(dwarf, tmpInstr, &offset);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read leb128 failed");
            offset = (intptr_t)(offset * pstInfo->dataAlign);
            pstRegInfo->regHow = REG_SAVED_OFFSET;
            pstRegInfo->regLoc.offset = offset;
            SCD_DLOG_INF("reg[%lu] DW_CFA_OFFSET_EXT_SF %lx", regTmp & REG_VAILD_MASK, offset);
            break;
        /* 该条指令被DW_CFA_OFF_EXT_SF指令替换， 但是在老的PowerPC编码里会有 */
        case DW_CFA_GNU_NEG_OFF_EXT:
            tmpInstr = TraceReadUleb128(dwarf, tmpInstr, &regTmp);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read uleb128 failed");
            regTmp = (uintptr_t)(regTmp * (uintptr_t)pstInfo->dataAlign);
            pstRegInfo->regHow = REG_SAVED_OFFSET;
            pstRegInfo->regLoc.offset = -(intptr_t)regTmp;
            SCD_DLOG_INF("reg[%lu] DW_CFA_GNU_NEG_OFF_EXT: %lx", regTmp & REG_VAILD_MASK, regTmp);
            break;
        case DW_CFA_SAME_VALUE:
        case DW_CFA_RESTORE_EXTENDED:
            pstRegInfo->regHow = REG_UNSAVED;
            SCD_DLOG_INF("reg[%lu] DW_CFA_RESTORE_EXTENDED", regTmp & REG_VAILD_MASK);
            break;
        case DW_CFA_UNDEFINED:
            pstRegInfo->regHow = REG_UNDEFINED;
            SCD_DLOG_INF("reg[%lu] DW_CFA_UNDEFINED", regTmp & REG_VAILD_MASK);
            break;
        /* 寄存器号变化 */
        case DW_CFA_REGISTER:
            tmpInstr = TraceReadUleb128(dwarf, tmpInstr, &regTmp);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read uleb128 failed");
            pstRegInfo->regHow = REG_SAVED_REG;
            pstRegInfo->regLoc.reg = regTmp;
            SCD_DLOG_INF("reg[%lu] DW_CFA_REGISTER: %lx", regTmp & REG_VAILD_MASK, regTmp);
            break;
        /* 通过DW_OP 指令获取寄存器 */
        case DW_CFA_EXPRESSION:
            pstRegInfo->regHow = REG_SAVED_EXP;
            pstRegInfo->regLoc.valExp = tmpInstr;
            tmpInstr = TraceReadUleb128(dwarf, tmpInstr, &regTmp);
            SCD_CHK_EXPR_ACTION(tmpInstr == NULL, return NULL, "read uleb128 failed");
            tmpInstr = tmpInstr + regTmp;
            SCD_DLOG_INF("reg[%lu] DW_CFA_EXPRESSION: %lx", regTmp & REG_VAILD_MASK, regTmp);
            break;
        default:
            tmpInstr = NULL;
            break;
    }

    return tmpInstr;
}

/**
 * @brief 解析unwind表达式和DW_OP指令
 *
 * @param [in]  opStart  DW_OP指令的起始地址
 * @param [in]  opEnd    DW_OP指令的结束地址
 * @param [in]  coreRegs 寄存器信息
 * @param [out] result   执行dw_op指令之后的返回值
 * @param [in]  initial   放入栈底的初始值
 * @param [in]  args        栈限制地址
 *
 * @return 指令地址
 */
TraStatus TraceStackOpExc(ScdDwarf *dwarf, const uint8_t *opStart, const uint8_t *opEnd, const ScdRegs *coreRegs,
    uintptr_t *ptrResult, uintptr_t initial, const ScdDwarfStepArgs *args)
{
    uintptr_t stackContent[VOS_OP_STACK_DEPTH] = {0};
    uint32_t idx = 0;
    uint8_t opType = 0;
    uintptr_t result = 0;
    intptr_t offset;
    TraStatus ret;
    const uint8_t *pStartTmp = opStart;
    stackContent[idx & VOS_OP_STACK_MASK] = initial;
    idx++;

    /* 执行unwind指令中类型为DWARF expresion的指令，该指令是一串DW_OP类型指令，该指令
     * 操作可看成栈操作，用数组表示一个栈，每次执行完，取栈顶的数据返回
     * 分为以下几种类型 */
    while (pStartTmp < opEnd) {
        if (pStartTmp == NULL) {
            return TRACE_FAILURE;
        }
        opType = *pStartTmp;
        pStartTmp++;

        /* 数值，从0到31，用于后续逻辑处理 */
        if (VOS_ENC_OP_LIT(opType)) {
            result = (uintptr_t)opType - (uintptr_t)DW_OP_LIT0;
        } else if (VOS_ENC_OP_REG(opType)) { /* 无操作数，类型表示寄存器号 */
            result =
                coreRegs->r[(opType - DW_OP_REG0) & REG_VAILD_MASK];
        } else if (VOS_ENC_OP_BREG(opType)) { /* 一个操作数，保存有符号leb128的偏移 */
            pStartTmp = TraceReadLeb128(dwarf, pStartTmp, &offset);
            SCD_CHK_EXPR_ACTION(pStartTmp == NULL, return TRACE_FAILURE, "read leb128 failed");
            result = coreRegs->r[(opType - DW_OP_BREG0) & REG_VAILD_MASK] + (uintptr_t)offset;
        } else if (VOS_ENC_OP_CONST(opType)) { /* 读取该编码类型的一个数据 */
            pStartTmp  = TraceOpConstNumGet(dwarf, opType, pStartTmp, &result);
            if (pStartTmp == NULL) {
                return TRACE_FAILURE;
            }
        } else if (VOS_ENC_OP_STACK_OPR(opType)) { /* 在栈中处理数据 */
            pStartTmp = TraceOpStackDataOpt(opType, stackContent, &idx, pStartTmp, &result);
            if (pStartTmp == NULL) {
                return TRACE_FAILURE;
            }
        } else if (VOS_ENC_OP_ONE_DATA(opType)) { /* 栈中一个数的操作流程 */
            pStartTmp = TraceOpStackOneDataOpt(dwarf, opType, stackContent, &idx, pStartTmp, args, &result);
            if (pStartTmp == NULL) {
                return TRACE_FAILURE;
            }
        } else if (VOS_ENC_OP_TWO_DATA(opType)) { /* 栈中两个数的操作流程 */
            ret = TraceOpStackTwoDataOpt(opType, stackContent, &idx, &result);
            if (ret != TRACE_SUCCESS) {
                return ret;
            }
        } else if (VOS_ENC_OP_OTHER_OPR(opType)) {
            pStartTmp = TraceOpStackOtherOpt(dwarf, opType, stackContent, &idx, pStartTmp, coreRegs, &result);
        } else {
            return TRACE_FAILURE;
        }

        /* 排除非压栈指令 */
        if ((idx < VOS_OP_STACK_DEPTH) && (!(VOS_IS_NO_PUSH_CODE(opType)))) {
            stackContent[idx & VOS_OP_STACK_MASK] = result;
            idx++;
        } else if (idx >= VOS_OP_STACK_DEPTH) {
            return TRACE_FAILURE;
        } else {
            ;
        }
    }

    if (idx < 1) {
        return TRACE_FAILURE;
    }
    idx--;
    /* 取出栈顶数据 */
    *ptrResult = stackContent[idx & VOS_OP_STACK_MASK];

    return TRACE_SUCCESS;
}

/**
 * @brief 解析unwind指令
 * @param [in]  addrRange      要解析的指令地址范围
 * @param [out] frameRegState  推栈状态信息结构体
 * @param [in]  isFEDTable     是FDE还是CIE
 *
 * @return      : !=0 failure; ==0 success
 */
TraStatus TraceUnwindParseFn(ScdDwarf *dwarf, TraceAddrRange *addrRange, TraceFrameRegStateInfo *frameRegState, bool isFEDTable)
{
    const uint8_t *instr = (uint8_t *)addrRange->start;
    uint8_t ucCurInsn;
    uint8_t ucLowCurIns;
    if (instr == NULL) {
        SCD_DLOG_ERR("invalid addr start");
        return TRACE_FAILURE;
    }
    TraceFrameStateInfo stStoreFrameRegState = {0};
    while (instr < (uint8_t *)addrRange->end) {
        // 当pc值等于ret时，需要再推一层
        if (isFEDTable && frameRegState->pc > frameRegState->ret) {
            return TRACE_SUCCESS;
        }
        ucCurInsn = *instr;
        instr++;

        /* 操作码高两位非0时，低6位可表征寄存器号 */
        if (TRACE_HIBIT2_OPCODE(ucCurInsn) != 0) {
            instr = TraceUnwindOpcodeParse(dwarf, ucCurInsn, instr, frameRegState);
            if (instr == NULL) {
                SCD_DLOG_ERR("invalid instr");
                return TRACE_FAILURE;
            }
            continue;
        }

        /* 高2位为0时，低六位就是指令unwind类型 */
        ucLowCurIns = (uint8_t)TRACE_LOBIT6_OPCODE(ucCurInsn);
        /* 直接设置PC指针的位置 */
        if (VOS_INS_PC_LOC(ucLowCurIns)) {
            instr = TraceUnwindPCLocParse(dwarf, ucLowCurIns, instr, frameRegState);
        } else if (VOS_INS_REG_DEF(ucLowCurIns)) { /* 获取寄存器的计算状态 */
            instr = TraceUnwindRegDefParse(dwarf, ucLowCurIns, instr, frameRegState);
        } else if (VOS_INS_CFA_DEF(ucLowCurIns)) { /* 获取CFA的计算状态 */
            instr = TraceUnwindCFADefParse(dwarf, ucLowCurIns, instr, frameRegState);
        } else if (VOS_INS_REG_VALUE_DEF(ucLowCurIns)) { /* 获取寄存器值的计算状态 */
            instr = TraceUnwindRegValueDefParse(dwarf, ucLowCurIns, instr, frameRegState);
        } else if (VOS_INS_OTHER_DEF(ucLowCurIns)) { /* 其他unwind指令解析过程 */
            instr = TraceUnwindOtherCodeParse(dwarf, ucLowCurIns, instr, &stStoreFrameRegState, frameRegState);
        } else {
            SCD_DLOG_ERR("invalid opcode");
            return TRACE_FAILURE;
        }
        if (instr == NULL) {
            SCD_DLOG_ERR("invalid instr");
            return TRACE_FAILURE;
        }
    }
    return TRACE_SUCCESS;
}
