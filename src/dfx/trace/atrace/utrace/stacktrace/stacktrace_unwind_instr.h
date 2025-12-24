/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef STACKCORE_UNWIND_INSTR_H
#define STACKCORE_UNWIND_INSTR_H

#include <stddef.h>
#include "atrace_types.h"
#include "stacktrace_unwind.h"
#include "scd_regs.h"
#include "scd_dwarf.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

typedef struct TraceAddrRange {
    uintptr_t start;
    uintptr_t end;
} TraceAddrRange;

typedef enum RegType {
    REG_UNSAVED,
    REG_SAVED_OFFSET,
    REG_SAVED_REG,
    REG_SAVED_EXP,
    REG_SAVED_VAL_OFFSET,
    REG_SAVED_VAL_EXP,
    REG_UNDEFINED
} RegType;

typedef struct TraceStagRegInfo {
    union {
        uintptr_t reg;
        intptr_t offset;
        const uint8_t *valExp;
    } regLoc;
    uint32_t reserved;
    RegType regHow;
} TraceStagRegInfo;

typedef enum CfaType {
    VOS_CFA_UNSET,
    VOS_CFA_REG_OFFSET,
    VOS_CFA_EXP
} CfaType;

#define TRACE_CORE_REG_NUM 0x20U
typedef struct TraceFrameStateInfo {
    TraceStagRegInfo regInfo[TRACE_CORE_REG_NUM];
    uintptr_t cfaReg;
    intptr_t cfaOffset;
    const uint8_t *cfaExp;
    uint32_t reserved;
    CfaType cfaHow;
}TraceFrameStateInfo;

// 记录每层堆栈的信息
typedef struct TraceFrameRegStateInfo {
    TraceFrameStateInfo frameStateInfo;
    uintptr_t pc;                  // pc of current frame
    uintptr_t range;
    uintptr_t ret;                 // return address of current frame
    uintptr_t codeAlign;
    intptr_t dataAlign;
    uintptr_t retColumn;  // Return Address Register
    uint8_t fdeEnc;
    uint8_t optFlag;    /* 表征增量数据长度和增量数据，1表示存在，0表示不存在 */
    uint8_t flag;      /* 表征增量字符串里是否有'R'，1表示有，0表示无 */
    uint8_t sigFrmFlag; /* 表征增量字符串里是否有'S'，表示该层函数是信号帧，1表示有，0表示无 */
    uint8_t reserved[4];
}TraceFrameRegStateInfo;

/* op 指令中不压栈的指令 */
#define VOS_IS_NO_PUSH_CODE(opcode) \
    ((DW_OP_ROT == (opcode)) || (DW_OP_DROP == (opcode)) || (DW_OP_SWAP == (opcode)) || \
        (DW_OP_SKIP == (opcode)) || (DW_OP_BRA == (opcode)) || (DW_OP_NOP == (opcode)))

/* the operation stack size */
#define VOS_OP_STACK_DEPTH 0x40
#define REG_VAILD_MASK 0x1fU /* 防止寄存器数组越界的掩码 */
#define VOS_OP_STACK_MASK 0x3fU /* 防止表达栈越界的掩码 */
/* unwind推栈时使用的寄存器数目 */
#define VOS_CORE_REGS_NUM 0x20
#define VOS_INS_PC_LOC(opcode) \
    ((DW_CFA_SET_LOC <= (opcode)) && \
        (DW_CFA_ADVANCE_LOC4 >= (opcode)))
#define VOS_INS_REG_DEF(opcode) \
    ((DW_CFA_OFFSET_EXTENDED == (opcode)) || \
        (DW_CFA_RESTORE_EXTENDED == (opcode)) || \
        (DW_CFA_SAME_VALUE == (opcode)) || \
        (DW_CFA_UNDEFINED == (opcode)) || \
        (DW_CFA_REGISTER == (opcode)) || \
        (DW_CFA_EXPRESSION == (opcode)) || \
        (DW_CFA_OFF_EXTENDED_SF == (opcode)) || \
        (DW_CFA_GNU_NEG_OFF_EXT == (opcode)))
#define VOS_INS_CFA_DEF(opcode) \
    ((DW_CFA_DEF_CFA == (opcode)) || \
        (DW_CFA_DEF_CFA_REGISTER == (opcode)) || \
        (DW_CFA_DEF_CFA_OFFSET == (opcode)) || \
        (DW_CFA_DEF_CFA_EXPRESSION == (opcode)) || \
        (DW_CFA_DEF_CFA_SF == (opcode)) || \
        (DW_CFA_DEF_CFA_OFFSET_SF == (opcode)))
#define VOS_INS_REG_VALUE_DEF(opcode) \
    ((DW_CFA_VAL_OFFSET == (opcode)) || \
        (DW_CFA_VAL_OFFSET_SF == (opcode)) || \
        (DW_CFA_VAL_EXPRESSION == (opcode)))
#define VOS_INS_OTHER_DEF(opcode) \
    ((DW_CFA_NOP == (opcode)) || \
        (DW_CFA_REMEMBER_STATE == (opcode)) || \
        (DW_CFA_RESTORE_STATE == (opcode)) || \
        (DW_CFA_GNU_ARG_SIZE == (opcode)) || \
        (DW_CFA_GNU_WIN_SAVE == (opcode)))


/* OP指令圈复杂度优化 */
#define VOS_ENC_OP_LIT(opType) \
    ((DW_OP_LIT0 <= (opType)) && (DW_OP_LIT31 >= (opType)))
#define VOS_ENC_OP_REG(opType) \
    ((DW_OP_REG0 <= (opType)) && (DW_OP_REG31 >= (opType)))
#define VOS_ENC_OP_BREG(opType) \
    ((DW_OP_BREG0 <= (opType)) && (DW_OP_BREG31 >= (opType)))
#define VOS_ENC_OP_CONST(opType) \
    ((DW_OP_COUST1U <= (opType)) && (DW_OP_COUSTS >= (opType)))
#define VOS_ENC_OP_STACK_OPR(opType) ((DW_OP_DUP <= (opType)) && (DW_OP_ROT >= (opType)))
#define VOS_ENC_OP_ONE_DATA(opType) \
    ((DW_OP_DEREF == (opType)) || (DW_OP_DEREF_SIZE == (opType)) || (DW_OP_ABS == (opType)) || \
        (DW_OP_NEG == (opType)) || (DW_OP_NOT == (opType)) || (DW_OP_PLUS_UCONST == (opType)))
#define VOS_ENC_OP_TWO_DATA(opType) ((DW_OP_AND == (opType)) || (DW_OP_DIV == (opType)) || \
        (DW_OP_MINUS == (opType)) || (DW_OP_MOD == (opType)) || (DW_OP_MUL == (opType)) || \
        (DW_OP_OR == (opType)) || (DW_OP_PLUS == (opType)) || (DW_OP_SHL == (opType)) || \
        (DW_OP_SHR == (opType)) || (DW_OP_SHRA == (opType)) || (DW_OP_XOR == (opType)) || \
        (DW_OP_LE == (opType)) || (DW_OP_GE == (opType)) || (DW_OP_EQ == (opType)) || \
        (DW_OP_LT == (opType)) || (DW_OP_GT == (opType)) || (DW_OP_NE == (opType)))
#define VOS_ENC_OP_TWO_DATA1(opType) ((DW_OP_AND == (opType)) || (DW_OP_DIV == (opType)) || \
        (DW_OP_MINUS == (opType)) || (DW_OP_MOD == (opType)) || (DW_OP_MUL == (opType)) || \
        (DW_OP_OR == (opType)) || (DW_OP_PLUS == (opType)))
#define VOS_ENC_OP_TWO_DATA2(opType) ((DW_OP_SHL == (opType)) || (DW_OP_SHR == (opType)) || \
        (DW_OP_SHRA == (opType)) || (DW_OP_XOR == (opType)) || (DW_OP_LE == (opType)) || \
        (DW_OP_GE == (opType)) || (DW_OP_EQ == (opType)) || (DW_OP_LT == (opType)) || \
        (DW_OP_GT == (opType)) || (DW_OP_NE == (opType)))
#define VOS_ENC_OP_OTHER_OPR(opType)  ((DW_OP_REGX == (opType)) || (DW_OP_BREGX == (opType)) || \
        (DW_OP_ADDR == (opType)) || (DW_OP_GNU_ENC_ADDR == (opType)) || (DW_OP_SKIP == (opType)) || \
        (DW_OP_BRA == (opType)) || (DW_OP_NOP == (opType)))


#define TRACE_STACK_ADDR_INVALID_CHECK(args, vsp) (((vsp) >= (args)->stackMaxAddr) || \
                                                            ((vsp) < (args)->stackMinAddr) || \
                                                            (((vsp) & 3U) != 0))

/* Call frame instruction: encoded one or more byte.The opcode is
 * one byte, the upper 2 bits are primary,the lower 6 bits are secondary
 * the additional operands is followed by the opcode
 */
#define DW_CFA_NOP 0x00             /* high 2 bits is 0x0,lower 6 bits is 0, no operand */
/* The DW_CFA_set_loc instruction takes a single operand that represents a target address. The required action is to
    create a new table row using the specified address as the location. All other values in the new row are initially
    identical to the current row. The new location value is always greater than the current one. If the segment_size
    field of this FDE's CIE is nonzero, the initial location is preceded by a segment selector of the given length. */
#define DW_CFA_SET_LOC 0x01         /* high 2 bits is 0x00,lower 6 bits is 0x01,operand1 is addr */
/* The DW_CFA_advance_loc1 instruction takes a single ubyte operand that represents a constant delta.
    This instruction is identical to DW_CFA_advance_loc except for the encoding and size of the delta operand. */
#define DW_CFA_ADVANCE_LOC1 0x02    /* high 2 bits is 0x00,lower 6 bits is 0x02,operand1 is 1-byte delta */
/* The DW_CFA_advance_loc2 instruction takes a single uhalf operand that represents a constant delta.
    This instruction is identical to DW_CFA_advance_loc except for the encoding and size of the delta operand. */
#define DW_CFA_ADVANCE_LOC2 0x03    /* high 2 bits is 0x00,lower 6 bits is 0x03,operand1 is 2-byte delta */
/* The DW_CFA_advance_loc4 instruction takes a single uword operand that represents a constant delta.
    This instruction is identical to DW_CFA_advance_loc except for the encoding and size of the delta operand. */
#define DW_CFA_ADVANCE_LOC4 0x04    /* high 2 bits is 0x00,lower 6 bits is 0x04,operand1 is 4-byte delta */
#define DW_CFA_OFFSET_EXTENDED 0x05      /* high 2 bits 0x00,lower 6 bits 0x05,opr1 ULEB128 reg, opr2 ULEB128 offset */
#define DW_CFA_RESTORE_EXTENDED 0x06     /* high 2 bits 0x00,lower 6 bits 0x06,opr1 ULEB128 reg */
#define DW_CFA_UNDEFINED 0x07       /* high 2 bits 0x00,lower 6 bits 0x07,opr1 ULEB128 reg */
#define DW_CFA_SAME_VALUE 0x08      /* high 2 bits 0x00,lower 6 bits 0x08,opr1 ULEB128 reg */
#define DW_CFA_REGISTER 0x09        /* high 2 bits 0x00,lower 6 bits 0x09,opr1 ULEB128 reg, opr2 ULEB128 reg */
#define DW_CFA_REMEMBER_STATE 0x0a       /* high 2 bits 0x00,lower 6 bits 0x0a,no operand */
#define DW_CFA_RESTORE_STATE 0x0b       /* high 2 bits 0x00,lower 6 bits 0x0b,no operand */
#define DW_CFA_DEF_CFA 0x0c         /* high 2 bits 0x00,lower 6 bits 0x0c,opr1 ULEB128 reg, opr2 ULEB128 off */
#define DW_CFA_DEF_CFA_REGISTER 0x0d     /* high 2 bits 0x00,lower 6 bits 0x0d,opr1 ULEB128 reg */
#define DW_CFA_DEF_CFA_OFFSET 0x0e     /* high 2 bits 0x00,lower 6 bits 0x0e,opr1 ULEB128 off */
#define DW_CFA_DEF_CFA_EXPRESSION 0x0f     /* high 2 bits 0x00,lower 6 bits 0x0f,opr1 BLOCK */
#define DW_CFA_EXPRESSION 0x10             /* high 2 bits 0x00,lower 6 bits 0x10,opr1 ULEB128 reg, opr2 BLOCK */
#define DW_CFA_OFF_EXTENDED_SF 0x11      /* high 2 bits 0x00,lower 6 bits 0x11,opr1 ULEB128 reg, opr2 SLEB128 off */
#define DW_CFA_DEF_CFA_SF 0x12      /* high 2 bits 0x00,lower 6 bits 0x12,opr1 ULEB128 reg, opr2 SLEB128 off */
#define DW_CFA_DEF_CFA_OFFSET_SF 0x13  /* high 2 bits 0x00,lower 6 bits 0x13,opr1 SLEB128 off */
#define DW_CFA_VAL_OFFSET 0x14         /* high 2 bits 0x00,lower 6 bits 0x14,opr1 ULEB128, opr2 ULEB128 */
#define DW_CFA_VAL_OFFSET_SF 0x15      /* high 2 bits 0x00,lower 6 bits 0x15,opr1 ULEB128, opr2 SLEB128 */
#define DW_CFA_VAL_EXPRESSION 0x16         /* high 2 bits 0x00,lower 6 bits 0x16,opr1 ULEB128, opr2 BLOCK */
#define DW_CFA_LO_USER 0x1c         /* high 2 bits 0x00,lower 6 bits 0x1c, no operand */
#define DW_CFA_GNU_WIN_SAVE 0x2d    /* high 2 bits 0x00,lower 6 bits 0x2d, no operand */
#define DW_CFA_GNU_ARG_SIZE 0x2e    /* high 2 bits 0x00,lower 6 bits 0x2e, opr1 ULEB128 */
#define DW_CFA_GNU_NEG_OFF_EXT 0x2f /* high 2 bits 0x00,lower 6 bits 0x2f, opr1 ULEB128 reg, opr2 ULEB128 off */
#define DW_CFA_HI_USER 0x3f         /* high 2 bits 0x00,lower 6 bits 0x3f, no operand */
#define DW_CFA_ADVANCE_LOC 0x40     /* high 2 bits is 0x01, lower 6 bits is delta, no operand */
#define DW_CFA_OFFSET 0x80          /* high 2 bits is 0x02, lower 6 bits is reg, operand1 is offset need multiply */
                                    /* Data_alignment_factor */
#define DW_CFA_RESTORE 0xc0         /* high 2 bits is 0x03,lower 6 bits is reg, no operand */

/* the type of executing the DWARF expression */
#define DW_OP_ADDR              0x03U /* one operand, constant address */
#define DW_OP_DEREF             0x06U /* 0 operand */
#define DW_OP_COUST1U           0x08U /* one operand, 1U byte constant */
#define DW_OP_COUST1S           0x09U /* one operand, 1S byte constant */
#define DW_OP_COUST2U           0x0aU /* one operand, 2U byte constant */
#define DW_OP_COUST2S           0x0bU /* one operand, 2S byte constant */
#define DW_OP_COUST4U           0x0cU /* one operand, 4U byte constant */
#define DW_OP_COUST4S           0x0dU /* one operand, 4S byte constant */
#define DW_OP_COUST8U           0x0eU /* one operand, 8U byte constant */
#define DW_OP_COUST8S           0x0fU /* one operand, 8S byte constant */
#define DW_OP_COUSTU            0x10U /* one operand, ULEB128 constant */
#define DW_OP_COUSTS            0x11U /* one operand, SLEB128 constant */
#define DW_OP_DUP               0x12U /* 0 operand */
#define DW_OP_DROP              0x13U /* 0 operand */
#define DW_OP_OVER              0x14U /* 0 operand */
#define DW_OP_PICK              0x15U /* one operand, 1-byte stack index */
#define DW_OP_SWAP              0x16U /* 0 operand */
#define DW_OP_ROT               0x17U /* 0 operand */
#define DW_OP_XDEREF            0x18U /* 0 operand */
#define DW_OP_ABS               0x19U /* 0 operand */
#define DW_OP_AND               0x1aU /* 0 operand */
#define DW_OP_DIV               0x1bU /* 0 operand */
#define DW_OP_MINUS             0x1cU /* 0 operand */
#define DW_OP_MOD               0x1dU /* 0 operand */
#define DW_OP_MUL               0x1eU /* 0 operand */
#define DW_OP_NEG               0x1fU /* 0 operand */
#define DW_OP_NOT               0x20U /* 0 operand */
#define DW_OP_OR                0x21U /* 0 operand */
#define DW_OP_PLUS              0x22U /* 0 operand */
#define DW_OP_PLUS_UCONST       0x23U /* one operand, ULEB128 addend */
#define DW_OP_SHL               0x24U /* 0 operand */
#define DW_OP_SHR               0x25U /* 0 operand */
#define DW_OP_SHRA              0x26U /* 0 operand */
#define DW_OP_XOR               0x27U /* 0 operand */
#define DW_OP_BRA               0x28U /* 1 operand,2U byte constant */
#define DW_OP_EQ                0x29U /* 0 operand */
#define DW_OP_GE                0x2aU /* 0 operand */
#define DW_OP_GT                0x2bU /* 0 operand */
#define DW_OP_LE                0x2cU /* 0 operand */
#define DW_OP_LT                0x2dU /* 0 operand */
#define DW_OP_NE                0x2eU /* 0 operand */
#define DW_OP_SKIP              0x2fU /* 1 operand,2U byte constant */
#define DW_OP_LIT0              0x30U /* 0 operand LIT0 + lit */
#define DW_OP_LIT1              0x31U /* 0 operand LIT0 + lit */
#define DW_OP_LIT2              0x32U /* 0 operand LIT0 + lit */
#define DW_OP_LIT3              0x33U /* 0 operand LIT0 + lit */
#define DW_OP_LIT4              0x34U /* 0 operand LIT0 + lit */
#define DW_OP_LIT5              0x35U /* 0 operand LIT0 + lit */
#define DW_OP_LIT6              0x36U /* 0 operand LIT0 + lit */
#define DW_OP_LIT7              0x37U /* 0 operand LIT0 + lit */
#define DW_OP_LIT8              0x38U /* 0 operand LIT0 + lit */
#define DW_OP_LIT9              0x39U /* 0 operand LIT0 + lit */
#define DW_OP_LIT10             0x3aU /* 0 operand LIT0 + lit */
#define DW_OP_LIT11             0x3bU /* 0 operand LIT0 + lit */
#define DW_OP_LIT12             0x3cU /* 0 operand LIT0 + lit */
#define DW_OP_LIT13             0x3dU /* 0 operand LIT0 + lit */
#define DW_OP_LIT14             0x3eU /* 0 operand LIT0 + lit */
#define DW_OP_LIT15             0x3fU /* 0 operand LIT0 + lit */
#define DW_OP_LIT16             0x40U /* 0 operand LIT0 + lit */
#define DW_OP_LIT17             0x41U /* 0 operand LIT0 + lit */
#define DW_OP_LIT18             0x42U /* 0 operand LIT0 + lit */
#define DW_OP_LIT19             0x43U /* 0 operand LIT0 + lit */
#define DW_OP_LIT20             0x44U /* 0 operand LIT0 + lit */
#define DW_OP_LIT21             0x45U /* 0 operand LIT0 + lit */
#define DW_OP_LIT22             0x46U /* 0 operand LIT0 + lit */
#define DW_OP_LIT23             0x47U /* 0 operand LIT0 + lit */
#define DW_OP_LIT24             0x48U /* 0 operand LIT0 + lit */
#define DW_OP_LIT25             0x49U /* 0 operand LIT0 + lit */
#define DW_OP_LIT26             0x4aU /* 0 operand LIT0 + lit */
#define DW_OP_LIT27             0x4bU /* 0 operand LIT0 + lit */
#define DW_OP_LIT28             0x4cU /* 0 operand LIT0 + lit */
#define DW_OP_LIT29             0x4dU /* 0 operand LIT0 + lit */
#define DW_OP_LIT30             0x4eU /* 0 operand LIT0 + lit */
#define DW_OP_LIT31             0x4fU /* 0 operand LIT0 + lit */
#define DW_OP_REG0              0x50U /* 0 operand REG0 + Regnum */
#define DW_OP_REG1              0x51U /* 0 operand REG0 + Regnum */
#define DW_OP_REG2              0x52U /* 0 operand REG0 + Regnum */
#define DW_OP_REG3              0x53U /* 0 operand REG0 + Regnum */
#define DW_OP_REG4              0x54U /* 0 operand REG0 + Regnum */
#define DW_OP_REG5              0x55U /* 0 operand REG0 + Regnum */
#define DW_OP_REG6              0x56U /* 0 operand REG0 + Regnum */
#define DW_OP_REG7              0x57U /* 0 operand REG0 + Regnum */
#define DW_OP_REG8              0x58U /* 0 operand REG0 + Regnum */
#define DW_OP_REG9              0x59U /* 0 operand REG0 + Regnum */
#define DW_OP_REG10             0x5aU /* 0 operand REG0 + Regnum */
#define DW_OP_REG11             0x5bU /* 0 operand REG0 + Regnum */
#define DW_OP_REG12             0x5cU /* 0 operand REG0 + Regnum */
#define DW_OP_REG13             0x5dU /* 0 operand REG0 + Regnum */
#define DW_OP_REG14             0x5eU /* 0 operand REG0 + Regnum */
#define DW_OP_REG15             0x5fU /* 0 operand REG0 + Regnum */
#define DW_OP_REG16             0x60U /* 0 operand REG0 + Regnum */
#define DW_OP_REG17             0x61U /* 0 operand REG0 + Regnum */
#define DW_OP_REG18             0x62U /* 0 operand REG0 + Regnum */
#define DW_OP_REG19             0x63U /* 0 operand REG0 + Regnum */
#define DW_OP_REG20             0x64U /* 0 operand REG0 + Regnum */
#define DW_OP_REG21             0x65U /* 0 operand REG0 + Regnum */
#define DW_OP_REG22             0x66U /* 0 operand REG0 + Regnum */
#define DW_OP_REG23             0x67U /* 0 operand REG0 + Regnum */
#define DW_OP_REG24             0x68U /* 0 operand REG0 + Regnum */
#define DW_OP_REG25             0x69U /* 0 operand REG0 + Regnum */
#define DW_OP_REG26             0x6aU /* 0 operand REG0 + Regnum */
#define DW_OP_REG27             0x6bU /* 0 operand REG0 + Regnum */
#define DW_OP_REG28             0x6cU /* 0 operand REG0 + Regnum */
#define DW_OP_REG29             0x6dU /* 0 operand REG0 + Regnum */
#define DW_OP_REG30             0x6eU /* 0 operand REG0 + Regnum */
#define DW_OP_REG31             0x6fU /* 0 operand REG0 + Regnum */
#define DW_OP_BREG0             0x70U /* 1 operand REG + offset */
#define DW_OP_BREG1             0x71U /* 1 operand REG + offset */
#define DW_OP_BREG2             0x72U /* 1 operand REG + offset */
#define DW_OP_BREG3             0x73U /* 1 operand REG + offset */
#define DW_OP_BREG4             0x74U /* 1 operand REG + offset */
#define DW_OP_BREG5             0x75U /* 1 operand REG + offset */
#define DW_OP_BREG6             0x76U /* 1 operand REG + offset */
#define DW_OP_BREG7             0x77U /* 1 operand REG + offset */
#define DW_OP_BREG8             0x78U /* 1 operand REG + offset */
#define DW_OP_BREG9             0x79U /* 1 operand REG + offset */
#define DW_OP_BREG10            0x7aU /* 1 operand REG + offset */
#define DW_OP_BREG11            0x7bU /* 1 operand REG + offset */
#define DW_OP_BREG12            0x7cU /* 1 operand REG + offset */
#define DW_OP_BREG13            0x7dU /* 1 operand REG + offset */
#define DW_OP_BREG14            0x7eU /* 1 operand REG + offset */
#define DW_OP_BREG15            0x7fU /* 1 operand REG + offset */
#define DW_OP_BREG16            0x80U /* 1 operand REG + offset */
#define DW_OP_BREG17            0x81U /* 1 operand REG + offset */
#define DW_OP_BREG18            0x82U /* 1 operand REG + offset */
#define DW_OP_BREG19            0x83U /* 1 operand REG + offset */
#define DW_OP_BREG20            0x84U /* 1 operand REG + offset */
#define DW_OP_BREG21            0x85U /* 1 operand REG + offset */
#define DW_OP_BREG22            0x86U /* 1 operand REG + offset */
#define DW_OP_BREG23            0x87U /* 1 operand REG + offset */
#define DW_OP_BREG24            0x88U /* 1 operand REG + offset */
#define DW_OP_BREG25            0x89U /* 1 operand REG + offset */
#define DW_OP_BREG26            0x8aU /* 1 operand REG + offset */
#define DW_OP_BREG27            0x8bU /* 1 operand REG + offset */
#define DW_OP_BREG28            0x8cU /* 1 operand REG + offset */
#define DW_OP_BREG29            0x8dU /* 1 operand REG + offset */
#define DW_OP_BREG30            0x8eU /* 1 operand REG + offset */
#define DW_OP_BREG31            0x8fU /* 1 operand REG + offset */
#define DW_OP_REGX              0x90U /* 1 operand uleb128 reg */
#define DW_OP_FBREG             0x91U /* 1 operand sleb128 offset */
#define DW_OP_BREGX             0x92U /* 2 operand uleb128 reg + sleb128 offset */
#define DW_OP_PIECE             0x93U /* 1 operand uleb128 size of piece */
#define DW_OP_DEREF_SIZE        0x94U /* 1 operand 1 byte size of data */
#define DW_OP_XDEREF_SIZE       0x95U /* 1 operand 1 byte size of data */
#define DW_OP_NOP               0x96U /* 0 operand */
#define DW_OP_PUSH_OBJ_ADDR     0x97U /* 0 operand */
#define DW_OP_CALL2             0x98U /* 1 operand 2 byte off of DIE */
#define DW_OP_CALL4             0x99U /* 1 operand 4 byte off of DIE */
#define DW_OP_CALL_REF          0x9aU /* 1 operand 4/8 byte off of DIE */
#define DW_OP_FROM_TLS_ADDR     0x9bU /* 0 operand */
#define DW_OP_CALL_FRM_CFA      0x9cU /* 0 operand */
#define DW_OP_BIT_PIECE         0x9dU /* 2 operand uleb128 size + sleb128 offset */
#define DW_OP_IMPLI_VAL         0x9eU /* 2 operand uleb128 size + block of size */
#define DW_OP_STACK_VAL         0x9fU /* 0 operand */
#define DW_OP_LO_USER           0xe0U /* 0 operand */
#define DW_OP_GNU_UNINIT        0xf0U
#define DW_OP_GNU_ENC_ADDR      0xf1U
#define DW_OP_GNU_IMI_PT        0xf2U
#define DW_OP_GNU_ADDR_IDX      0xfbU
#define DW_OP_GNU_CONST_IDX     0xfcU
#define DW_OP_HI_USER           0xffU /* 0 operand */

/* the parse of opcode */
#define TRACE_HIBIT2_OPCODE(x) ((x) & 0xc0ULL)
#define TRACE_LOBIT6_OPCODE(x) ((x) & 0x3fU)
TraStatus TraceStackOpExc(ScdDwarf *dwarf, const uint8_t *opStart, const uint8_t *opEnd, const ScdRegs *coreRegs,
    uintptr_t *ptrResult, uintptr_t initial, const ScdDwarfStepArgs *args);
TraStatus TraceUnwindParseFn(ScdDwarf *dwarf, TraceAddrRange *addrRange, TraceFrameRegStateInfo *frameRegState, bool isFEDTable);
#ifdef __cplusplus
}
#endif // __cplusplus
#endif

