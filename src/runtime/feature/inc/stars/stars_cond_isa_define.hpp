/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_STARS_COND_ISA_DEFINE_HPP__
#define __CCE_RUNTIME_STARS_COND_ISA_DEFINE_HPP__

#include "base.hpp"
#include "stars_base_cond_isa_define.hpp"
#include "stars_model_execute_cond_isa_define.hpp"

namespace cce {
namespace runtime {
#pragma pack(push)
#pragma pack (1)

struct RtStarsGetSqFsmStateI {
    RtStarsCondOpLHWI      lhwi1;
    RtStarsCondOpLLWI      llwi1;
    RtStarsCondOpLHWI      lhwi2;
    RtStarsCondOpLLWI      llwi2;
    RtStarsCondOpLHWI      lhwi3;
    RtStarsCondOpLLWI      llwi3;
    RtStarsCondOpSystemCsr csrrc;
    RtStarsCondOpStore     sh;
    RtStarsCondOpOp        and1;
    RtStarsCondOpLoadImm   ldi;
    RtStarsCondOpSystemCsr csrrs;
};

struct RtStarsGetSqEnableI {
    RtStarsCondOpOp        and1;
    RtStarsCondOpLoadImm   ldi;
    RtStarsCondOpImm       andi;
};

struct RtStarsGetSqHeadAndTailI {
    RtStarsCondOpLoadImm   ldi1;
    RtStarsCondOpImm       andtail;
    RtStarsCondOpLoadImm   ldi2;
    RtStarsCondOpImm       andhead;
};

struct RtStarsDisableStreamI {
    RtStarsCondOpLHWI      lhwi1;
    RtStarsCondOpLLWI      llwi1;
    RtStarsCondOpStore     sw;
};

struct RtStarsSetCqeStatus {
    RtStarsCondOpSystemCsr csrrw;
};

struct RtStarsAddStreamActiveTimes {
    RtStarsCondOpLoadImm       lwu;
    RtStarsCondOpImm           addi;
    RtStarsCondOpLHWI          lhwi;
    RtStarsCondOpLLWI          llwi;
    RtStarsCondOpStore         sh;
};

// stream active func call
struct RtStarsStreamActiveFc {
    RtStarsGetSqFsmStateI         getSqFsmState_i;
    RtStarsSetCqeStatus             dfxFsm;
    RtStarsCondOpLLWI             llwiDfx0;
    RtStarsCondOpLHWI             lhwiDfx0;
    RtStarsCondOpStore            stdDfx0;
    RtStarsCondOpImm              addi;
    RtStarsCondOpImm              andi1;
    RtStarsCondOpLLWI             llwi1;
    RtStarsCondOpLHWI             lhwi1;
    RtStarsCondOpOp               xor1;
    RtStarsSetCsrJumpPc           jumpPc0;
    RtStarsCondOpLoop             sqNEloop;

    RtStarsCondOpImmSLLI          srli;
    RtStarsCondOpImm              andi2;
    RtStarsCondOpImm              andi9;              // check if fsm is 9, then goto error
    RtStarsSetCsrJumpPc           jumpErr0;
    RtStarsCondOpBranch           fsm9err;
    RtStarsSetCsrJumpPc           jumpPc1;
    RtStarsCondOpLoop             loop;               // go to back
    RtStarsGetSqEnableI           getSqEnable_i;
    RtStarsSetCsrJumpPc           jumpPc2;

    RtStarsCondOpLLWI             llwiDfx1;
    RtStarsCondOpLHWI             lhwiDfx1;
    RtStarsCondOpStore            stdDfx1;

    RtStarsCondOpBranch           beq1;               // BEQ: if sq enable flag is disable(0), goto reset sq head
    RtStarsGetSqHeadAndTailI      getSqHeadAndTail_i;
    RtStarsSetCsrJumpPc           jumpPc3;

    RtStarsCondOpLLWI             llwiDfx2;
    RtStarsCondOpLHWI             lhwiDfx2;
    RtStarsCondOpStore            stdDfx2_0;
    RtStarsCondOpStore            stdDfx2_1;

    RtStarsCondOpBranch           bne2;               // BNE: if sq head is not equal to tail, goto err
    RtStarsDisableStreamI         disableSq_i;
    RtStarsCondOpStreamGotoI      goto_i;             // reset sq head;
    RtStarsAddStreamActiveTimes   addStreamActiveTimes;
    RtStarsCondOpStreamActiveI    active_i;
    RtStarsSetCsrJumpPc           jumpPc4;
    RtStarsCondOpBranch           beq2;               // BEQ: r0 r0, goto nop
    RtStarsCondOpErrorInstr       err;
    RtStarsCondOpNop              end;    /* end of func, mast be the last insruction */
};

// stream active func call para
struct rtStarsStreamActiveFcPara_t {
    uint32_t sqId;
    uint32_t res;
    uint64_t streamExecTimesAddr;
    uint64_t rtSqFsmStateAddr;
    uint64_t rtSqEnableAddr;
    uint64_t rtSqTailAddr;
    uint64_t rtSqHeadAddr;
    uint64_t dfxAddr;
};

struct RtStarsLabelSwitchByIdxCheck {
    RtStarsCondOpLoadImm ldi;
    RtStarsCondOpLHWI    lhwi1;
    RtStarsCondOpLLWI    llwi1;
    RtStarsCondOpBranch  blt;
    RtStarsCondOpLHWI    lhwi2;
    RtStarsCondOpLLWI    llwi2;
    RtStarsCondOpLoadImm ldi1;
    RtStarsSetCqeStatus    dfxLabelIndex;
    RtStarsCondOpBranch  blt1;
    RtStarsCondOpErrorInstr  err;
};

struct RtStarsSwitchGetSqHeadAndTailI {
    RtStarsCondOpLoad      ldr1;
    RtStarsCondOpImm      andtail;
    RtStarsCondOpLoad      ldr2;
    RtStarsCondOpImm      andhead;
};

struct RtStarsSwitchGetSqVirtualAddrI{
    RtStarsCondOpImmSLLI   slli1;        // SLLI: R3 is the sqid get offset R5 : R3 << 3.
    RtStarsCondOpLHWI      lhwi1;        // LHWI/LLWI : read the starting addr of the virtual addr array to R4
    RtStarsCondOpLLWI      llwi1;
    RtStarsCondOpOp        add1;         // ADD : ADD : get "sq virtual addr" addr:  virtual addr arry head + sqid * 8
    RtStarsCondOpLoad      ldr1;         // LD_R: read sq simaple virutual addr from R4 to R4
    RtStarsCondOpLHWI      lhwi2;        // LHWI/LLWI: load goto instr num as a immediate to R5
    RtStarsCondOpLLWI      llwi2;
    RtStarsCondOpSystemCsr csrrw1;       // CSRRW: set goto instr num to jump_pc reg
    RtStarsCondOpBranch    beq1;         // BNE: sq Virtual Addr = 0 go to error
};

struct RtStarsSwitchGetSqEnableI {
    RtStarsCondOpLoad      ldr;
    RtStarsCondOpImm       andi1;
};

struct RtStarsSwitchDisableStreamI {
    RtStarsCondOpStore     sw;
};

struct RtStarsAddExecTimesFc {
    RtStarsCondOpLoadImm          ldi;
    RtStarsCondOpLLWI             llwi1;
    RtStarsCondOpLHWI             lhwi1;
    RtStarsCondOpImmSLLI          slli1;
    RtStarsCondOpOp               add1;
    RtStarsCondOpLoad             ldr1;
    RtStarsCondOpLoad             ldr2;
    RtStarsCondOpImm              addi1;
    RtStarsCondOpStore            sh;
};

struct rtStarsLabelSwitchByIndexFc_t {
    RtStarsLabelSwitchByIdxCheck  labelSwitchCheckIndex_i;
    RtStarsCondOpLLWI             llwiDfx;
    RtStarsCondOpLHWI             lhwiDfx;
    RtStarsCondOpStore            stdDfx;
    RtStarsCondOpImmSLLI          slli;
    RtStarsCondOpLLWI             llwi;
    RtStarsCondOpLHWI             lhwi;
    RtStarsCondOpOp               add;
    RtStarsCondOpLoad             ldr;
    RtStarsCondOpImm              andi1;

    RtStarsCondOpLLWI             llwiDfx0;
    RtStarsCondOpLHWI             lhwiDfx0;
    RtStarsCondOpStore            stdDfx0;

    RtStarsCondOpImm              xori;
    RtStarsSetCsrJumpPc           jumpPc1;
    RtStarsCondOpBranch           beq1;
    RtStarsSwitchGetSqVirtualAddrI getVirAddr_i;
    RtStarsSwitchGetSqEnableI     getSqEnable_i;

    RtStarsCondOpLLWI             llwiDfx1;
    RtStarsCondOpLHWI             lhwiDfx1;
    RtStarsCondOpStore            stdDfx1;

    RtStarsSetCsrJumpPc           jumpPc2;
    RtStarsCondOpBranch           beq2;
    RtStarsSwitchGetSqHeadAndTailI getSqHeadAndTail_i;

    RtStarsCondOpLLWI             llwiDfx2;
    RtStarsCondOpLHWI             lhwiDfx2;
    RtStarsCondOpStore            stdDfx2_0;
    RtStarsCondOpStore            stdDfx2_1;

    RtStarsSetCsrJumpPc           jumpPc3;
    RtStarsCondOpBranch           beq3;
    RtStarsCondOpErrorInstr       err;
    RtStarsSwitchDisableStreamI   disableSq_i;
    RtStarsCondOpStreamGotoR      goto_r1;
    RtStarsSetCsrJumpPc           jumpPc4;
    RtStarsCondOpLoop             loop;
    RtStarsAddExecTimesFc         addExecTimes_1;
    RtStarsCondOpStreamActiveR    active_r;
    RtStarsCondOpStreamDeActiveI  deActiveI;
    RtStarsSetCsrJumpPc           jumpPc5;
    RtStarsCondOpBranch           beq4;
    RtStarsAddExecTimesFc         addExecTimes_2;
    RtStarsCondOpStreamGotoR      goto_r2;
    RtStarsCondOpNop              end;    /* end of func, mast be the last insruction */
};

struct rtStarsLabelSwitchByIndexFcPara_t {
    uint64_t indexPtr;
    uint32_t maxVal;
    uint32_t res;
    uint64_t labelCountPtr;
    uint64_t labelInfoPtr;
    uint64_t sqVirtualAddr;
    uint64_t dfxAddr;
    uint16_t sqHeadOffset;
    uint16_t sqTailOffset;
};
// stream switch func call
struct rtStarsStreamSwitchFc_t {
    RtStarsCondOpLoadImm          load_i;
    RtStarsCondOpLHWI             lhwi;
    RtStarsCondOpLLWI             llwi;
    RtStarsSetCsrJumpPc           jumpPc0;
    RtStarsCondOpBranch           bne0;
    RtStarsStreamActiveFc         streamActiveFc;
    RtStarsCondOpStreamDeActiveI  deActiveI;
    RtStarsCondOpNop              end;    /* end of func, mast be the last insruction */
};

// stream switch func call para
struct rtStarsStreamSwitchFcPara_t {
    uint32_t currentSqId;
    uint32_t trueSqId;
    uint64_t varPtr;
    uint64_t val;
    rtCondition_t condition;
    uint64_t streamExecTimesAddr;
    uint64_t rtSqFsmStateAddr;
    uint64_t rtSqEnableAddr;
    uint64_t rtSqTailAddr;
    uint64_t rtSqHeadAddr;
    uint64_t dfxAddr;
};

// stream switchEx func call
struct rtStarsStreamSwitchExFc_t {
    RtStarsCondOpLoadImm          loadVar_i;
    RtStarsCondOpLoadImm          loadVal_i;
    RtStarsSetCsrJumpPc           jumpPc0;
    RtStarsCondOpBranch           bne0;
    RtStarsStreamActiveFc         streamActiveFc;
    RtStarsCondOpStreamDeActiveI  deActiveI;
    RtStarsCondOpNop              end;    /* end of func, mast be the last insruction */
};

// stream switchEx func call para
struct rtStarsStreamSwitchExFcPara_t {
    uint32_t currentSqId;
    uint32_t trueSqId;
    uint64_t varPtr;
    uint64_t valPtr;
    rtCondition_t condition;
    rtSwitchDataType_t dataType;
    uint64_t streamExecTimesAddr;
    uint64_t rtSqFsmStateAddr;
    uint64_t rtSqEnableAddr;
    uint64_t rtSqTailAddr;
    uint64_t rtSqHeadAddr;
    uint64_t dfxAddr;
};

enum RtMemWaitValueType : std::uint32_t {
    MEM_WAIT_VALUE_TYPE_GEQ = 0U,    // Wait until (*addr >= value)
    MEM_WAIT_VALUE_TYPE_EQ  = 1U,    // Wait until (*addr == value)
    MEM_WAIT_VALUE_TYPE_AND = 2U,    // Wait until (*addr & value) != 0
    MEM_WAIT_VALUE_TYPE_NOR = 3U,    // Wait until ~(*addr | value) != 0

    MEM_WAIT_VALUE_TYPE_MAX = 4U
};

/* used for none-software sq */
struct RtStarsMemWaitValueLastInstrFc {
    RtStarsCondOpImm addi0;           // init loop index, r3 = r0 + 0 = 0
    RtStarsCondOpLHWI lhwi1;          // load value2 to r5
    RtStarsCondOpLLWI llwi1;
    RtStarsCondOpImm addi1;           // init r4, r4 = r0 + 0 = 0
    RtStarsCondOpLLWI llwi2;          // load max loop num to r4
    RtStarsCondOpLoadImm loadValue;   // load value(u64) from virtual addr to r2
    RtStarsCondOpLHWI lhwi3;          // load value1 to r1
    RtStarsCondOpLLWI llwi3;
    RtStarsCondOpOp        op;        // r2 = r2 op value1(r1)
    RtStarsSetCsrJumpPc jumpPc1;
	RtStarsCondOpBranch branch1;      // r2 == r5, goto end
	RtStarsCondOpImm addi2;           // loop index++ r3 = r3 + 1
    RtStarsSetCsrJumpPc jumpPc2;
	RtStarsCondOpBranch bge;          // r3 >= r4, goto modify sqHead
	RtStarsCondOpNop  nop1;
	RtStarsCondOpNop  nop2;
    RtStarsSetCsrJumpPc jumpPc3;
	RtStarsCondOpBranch branch2;      // r2 != r5, goto loadValue
    RtStarsCondOpStreamGotoI goto_i;  // modify sq head;
    RtStarsCondOpNop end;
};

/* used for software sq */
struct RtStarsMemWaitValueLastInstrFcEx {
    RtStarsCondOpImm addi0;           // init loop index, r3 = r0 + 0 = 0
    RtStarsCondOpLHWI lhwi1;          // load value2 to r5
    RtStarsCondOpLLWI llwi1;
    RtStarsCondOpImm addi1;           // init r4, r4 = r0 + 0 = 0
    RtStarsCondOpLLWI llwi2;          // load max loop num to r4
    RtStarsCondOpLoadImm loadValue;   // load value(u64) from virtual addr to r2
    RtStarsCondOpLHWI lhwi3;          // load value1 to r1
    RtStarsCondOpLLWI llwi3;
    RtStarsCondOpOp        op;        // r2 = r2 op value1(r1)
    RtStarsSetCsrJumpPc jumpPc1;
	RtStarsCondOpBranch branch1;      // r2 == r5, goto end
	RtStarsCondOpImm addi2;           // loop index++ r3 = r3 + 1
    RtStarsSetCsrJumpPc jumpPc2;
	RtStarsCondOpBranch bge;          // r3 >= r4, goto modify sqHead
	RtStarsCondOpNop  nop1;
	RtStarsCondOpNop  nop2;
    RtStarsSetCsrJumpPc jumpPc3;
	RtStarsCondOpBranch branch2;      // r2 != r5, goto loadValue
    RtStarsCondOpLoadImm loadSqId;    // load sqid from virtual addr to r3
	RtStarsCondOpLHWI lhwi4;          // load sqHead to r4
    RtStarsCondOpLLWI llwi4;
	RtStarsCondOpImmSLLI slli;        // r4 = r4 < 16
	RtStarsCondOpOp        op2;       // r3 = r3 | r4, sqId=r3[10:0], head=r3[31:16]
	RtStarsCondOpStreamGotoR goto_r;  // modify sq head;
    RtStarsCondOpNop end;
};

// mem wait task func call para
struct RtStarsMemWaitValueInstrFcPara {
    uint64_t devAddr;
    uint64_t value;
    uint64_t maxLoop;
    uint32_t sqId;
    uint64_t sqIdMemAddr;
    uint32_t flag;
    uint32_t sqHeadPre;
    uint16_t awSize;
};

#pragma pack(pop)

}
}
#endif // __CCE_RUNTIME_STARS_COND_ISA_DEFINE_HPP__
