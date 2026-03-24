/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_STARS_MODEL_EXECUTE_COND_ISA_DEFINE_HPP__
#define __CCE_RUNTIME_STARS_MODEL_EXECUTE_COND_ISA_DEFINE_HPP__

#include "stars_base_cond_isa_define.hpp"
#include "stars_cond_isa_struct.hpp"

namespace cce {
namespace runtime {

#pragma pack(push)
#pragma pack(1)

struct RtStarsModelExeScanSq {
    // this is a goto lable: ScanSqArrInit
    RtStarsCondOpImm addi1;  // ADDI, Assignment 0 to R2. As an sqArrAddr index
    // this is a goto lable: ScanSqArr
    RtStarsCondOpLHWI lhwi1;  // load SqArr array address as the immediate to R1
    RtStarsCondOpLLWI llwi1;
    RtStarsCondOpLHWI lhwi2;  // load sqMax sa immediate to R4
    RtStarsCondOpLLWI llwi2;
    RtStarsCondOpLHWI lhwi3;  // load goto instr num as a immediate to R5
    RtStarsCondOpLLWI llwi3;
    RtStarsCondOpSystemCsr csrrw;  // set goto instr num to jump_pc reg
    RtStarsCondOpBranch bgeu;      // if sqArrAddr index >= sqMax, go to ScanHeadSqArrInit
    RtStarsCondOpImmSLLI slli;     // R2 left 3 bit is offset and assigned to the R3
    RtStarsCondOpOp add;           // get cur sq id addr r4=(r1+3)
    RtStarsCondOpLoad ldr;         // read cur sq id, r3 is cur sq id
};

struct RtStarsModelExeCheckSqFsm {
    RtStarsCondOpLHWI lhwi0;  // LHWI/LLWI: load sq fsm cfg address as the immediate to R4
    RtStarsCondOpLLWI llwi0;
    RtStarsCondOpLHWI lhwi1;  // LHWI/LLWI: read immd reg va cfg mask
    RtStarsCondOpLLWI llwi1;
    RtStarsCondOpSystemCsr csrrc;  // CSRRW: cfg use PA CSR_AXI_USER_REG
    RtStarsCondOpStore sw;         // write_value sqid to sq fsm cfg addr
    RtStarsCondOpLHWI lhwi2;       // LHWI/LLWI: load sq fsm cfg address as the immediate to R4
    RtStarsCondOpLLWI llwi2;
    RtStarsCondOpLoad ldr;    // read fsm status
    RtStarsCondOpLHWI lhwi3;  // LHWI/LLWI: read immd reg va cfg mask
    RtStarsCondOpLLWI llwi3;
    RtStarsCondOpSystemCsr csrrs;  // CSRRW: cfg use PA CSR_AXI_USER_REG

    RtStarsCondOpImm addi;
    RtStarsCondOpImm andi1;
    RtStarsCondOpOp xor1;
    RtStarsSetCsrJumpPc jumpPc0;
    RtStarsCondOpLoop loop0;

    RtStarsCondOpImmSLLI srli1;
    RtStarsCondOpImm andi2;
    RtStarsSetCsrJumpPc jumpPc1;
    RtStarsCondOpLoop loop;

    RtStarsSetCsrJumpPc jumpPc2;
    RtStarsCondOpBranch bne;  // BNE: if sq fsm status is not equal idle(0), goto error
};

struct RtStarsModelExeCheckSqDisable {
    RtStarsCondOpImmSLLI slli1;  // SLLI: R3 is the sqid get offset R5 : R3 << 3.
    RtStarsCondOpLHWI lhwi1;     // LHWI/LLWI : read the starting addr of the virtual addr array to R4
    RtStarsCondOpLLWI llwi1;
    RtStarsCondOpOp add1;     // ADD : ADD : get "sq virtual addr" addr:  virtual addr arry head + sqid * 8
    RtStarsCondOpLoad ldr1;   // LD_R: read sq simaple virutual addr from R4 to R4
    RtStarsCondOpLHWI lhwi3;  // LHWI/LLWI: load goto instr num as a immediate to R5
    RtStarsCondOpLLWI llwi3;
    RtStarsCondOpSystemCsr csrrw1;  // CSRRW: set goto instr num to jump_pc reg
    RtStarsCondOpBranch beq1;       // BNE: sq Virtual Addr = 0 go to error
    RtStarsCondOpLoad ldr2;         // LD_R: read sq head to R1,  from R4 + offset(STARS_SIMPLE_SQ_HEAD_OFFSET)
    RtStarsCondOpImmSLLI slli2;     // SLLI/SRLI: get sq enable flag: R1<<31, then R1>>63
    RtStarsCondOpImmSLLI srli2;
    RtStarsCondOpLHWI lhwi4;  // LHWI/LLWI: load goto instr num as a immediate to r5
    RtStarsCondOpLLWI llwi4;
    RtStarsCondOpSystemCsr csrrw2;  // set goto instr num to jump_pc reg
    RtStarsCondOpBranch beq2;       // BEQ: if sq enable flag is disable(0), goto setSqHead0
};

struct RtStarsModelExeCheckSqHeadTail {
    RtStarsCondOpLoad ldr1;      // LD_R: read sq head to R5,  from R4 + offset(STARS_SIMPLE_SQ_HEAD_OFFSET)
    RtStarsCondOpImmSLLI slli1;  // SLLI/SRLI: get sq head r5: r5<<48, then r5>>48
    RtStarsCondOpImmSLLI srli1;
    RtStarsCondOpLoad ldr2;      // LD_R: read sq tail to R1, from R4 + offset(STARS_SIMPLE_SQ_TAIL_OFFSET)
    RtStarsCondOpImmSLLI slli2;  // SLLI/SRLI: get sq tail r1: r1<<48, then r1>>48
    RtStarsCondOpImmSLLI srli2;
    RtStarsCondOpOp xor1;     // XOR: head is equal tail R1 =R1^R5
    RtStarsCondOpLHWI lhwi1;  // LHWI/LLWI: load goto instr num as a immediate to R5
    RtStarsCondOpLLWI llwi1;
    RtStarsCondOpSystemCsr csrrw;  // CSRRW: set goto instr num to jump_pc reg
    RtStarsCondOpBranch bne;       // BNE: head is not equal tail, R1 is not equal R0, goto error
};

struct RtStarsModelExeDeactiveSq {
    RtStarsCondOpStore sw;           // SW: write_value 0U to STARS_P0_SQ_CFG5, deactive the sq
    RtStarsCondOpStreamGotoR gotoR;  // GOTO_R: R4 set sq head is 0U
};

struct rtStarsModelExeScanHeadSq_t {
    // there is a goto label: ScanHeadSqArrInit
    RtStarsCondOpImm addi1;  // ADDI, Assignment 0 to R2. As an headSqArrAddr index
    // there is a goto label: ScanHeadSqArr
    RtStarsCondOpLHWI lhwi1;  // LHWI/LLWI: load headSqArr array address as the immediate to R11
    RtStarsCondOpLLWI llwi1;
    RtStarsCondOpLHWI lhwi2;  // LHWI/LLWI: load headsqMax sa immediate to R4
    RtStarsCondOpLLWI llwi2;
    RtStarsCondOpLHWI lhwi3;  // LHWI/LLWI: load goto instr num as a immediate to R5
    RtStarsCondOpLLWI llwi3;
    RtStarsCondOpSystemCsr csrrw;  // CSRRW: set goto instr num to jump_pc reg
    RtStarsCondOpBranch bgeu;      // BGEU: if headSqArrAddr index >= sqMax, go to End
    RtStarsCondOpImmSLLI slli;     // slli:R2 left 3 bit is offset and assigned to the R3
    RtStarsCondOpOp add;           // ADD: get cur sq id addr r4=(r1+3)  r4 is cur sq id addr
    RtStarsCondOpLoad ldr;         // LD_R: read cur sq id, r3 is cur sq id
};

struct RtStarsModelExeActiveSq {
    RtStarsCondOpImmSLLI slli;  // SLLI: get stream svm addr offset R3 left 3 bit is offset and assigned to the r5
    RtStarsCondOpImm addi0;     // ADDI, r2,headSqArrAddr index++
    RtStarsCondOpLHWI lhwi1;    // LHWI/LLWI: load stream svm base addr sa immediate to R4
    RtStarsCondOpLLWI llwi1;
    RtStarsCondOpOp add;                 // ADD: r5 is addr saving stream svm addr
    RtStarsCondOpLoad ldr1;              // LD_R: get stream svm addr r4
    RtStarsCondOpLoad ldr2;              // LD_R: get cnt in stream svm addr to r5
    RtStarsCondOpImm addi1;              // ADDI: r5, cnt++
    RtStarsCondOpStore sh;               // SH: save cnt r5 to r4
    RtStarsCondOpStreamActiveR activeR;  // Active_R: acitive sq r3
    RtStarsCondOpLHWI lhwi2;             // LHWI/LLWI: load goto instr num as a immediate to r4
    RtStarsCondOpLLWI llwi2;
    RtStarsCondOpSystemCsr csrrw1;  // CSRRW: set goto instr num to jump_pc reg
    RtStarsCondOpBranch beq;        // BEQ: goto scanHeadSqArr
};

struct RtStarsModelExeExeErrInstr {
    RtStarsCondOpErrorInstr err;
};

struct RtStarsModelExeCheckSqErrInstr {
    RtStarsCondOpLHWI lhwi0;
    RtStarsCondOpLLWI llwi0;
    RtStarsCondOpStore swdfx;
    uint32_t err = 0;
};

struct RtStarsModelExeExeEndInstr {
    RtStarsCondOpNop nop;
};

// model execute func call
struct RtStarsModelExeFuncCall {
    RtStarsModelExeScanSq scanSq;
    RtStarsModelExeCheckSqFsm checkSqFsm;
    RtStarsModelExeCheckSqDisable checkSqDisable;
    RtStarsModelExeCheckSqHeadTail checkSqHeadTail;
    RtStarsModelExeDeactiveSq deactiveSq;
    RtStarsModelExeActiveSq activeHeadSq;
    RtStarsModelExeCheckSqErrInstr checkSqDisableErrInstr;
    RtStarsModelExeCheckSqErrInstr checkSqHeadTailErrInstr;
    RtStarsModelExeExeErrInstr errInstr;
    RtStarsModelExeExeEndInstr endInstr;
};

// model execute func call
struct rtStarsModelExeFuncCallPara_t {
    uint64_t funcCallAddr;
    uint64_t headSqArrAddr;
    uint64_t headSqArrMax;
    uint64_t streamSvmArrAddr;
    uint64_t streamSvmArrMax;
    uint64_t sqFsmSelBasAddr;
    uint64_t sqVirtualAddr;
    uint64_t dfxAddr;
    uint16_t sqHeadOffset;
    uint16_t sqTailOffset;
};

struct RtStarsPivalueModifyFuncCall {
    RtStarsCondOpImm addi1;  // ADDI, Assignment 0 to R2. As an piValueArrAddr index

    RtStarsCondOpLHWI lhwi1;  // load piValueArrAddr array address as the immediate to R1
    RtStarsCondOpLLWI llwi1;

    RtStarsCondOpLHWI lhwi2;  // load piValueArr length sa immediate to R4
    RtStarsCondOpLLWI llwi2;

    RtStarsCondOpLHWI lhwi3;  // load goto instr num as a immediate to R5
    RtStarsCondOpLLWI llwi3;

    RtStarsCondOpSystemCsr csrrw;  // set goto instr num to jump_pc reg
    RtStarsCondOpBranch bgeu;      // if piValueArrAddr index >= length piValueArr, go to ScanHeadSqArrInit

    RtStarsCondOpImmSLLI slli;  // R2 left 3 bit is offset and assigned to the R3

    RtStarsCondOpOp add;  // ADD: get cur pi value addr r4=(r1+3)  r4 is cur pi value addr

    RtStarsCondOpLoad ldr1;  // LD_R: get stream svm addr r4

    RtStarsCondOpLHWI lhwi4;
    RtStarsCondOpLLWI llwi4;
    RtStarsCondOpOp add1;

    RtStarsCondOpLoad ldr2;  // read cur pi value, r3 is cur pi value

    RtStarsCondOpStore swdfx; // 记录当前的pi值

    RtStarsCondOpLHWI lhwi5;
    RtStarsCondOpLLWI llwi5;
    RtStarsCondOpOp   and1;

    RtStarsCondOpLHWI lhwi6;
    RtStarsCondOpLLWI llwi6;
    RtStarsCondOpOp   and2;

    RtStarsCondOpLoad ldr3;  // read cur pi value, r4 is cur value_add0

    RtStarsCondOpOp add2;

    RtStarsCondOpLHWI lhwi7;
    RtStarsCondOpLLWI llwi7;
    RtStarsCondOpOp   and3;

    RtStarsCondOpOp   or1;

    RtStarsCondOpStore sh;   // SH: save cnt r5 to r4

    RtStarsCondOpImm addi3;  // ADDI, r2, piValueArrAddr index++

    RtStarsCondOpLHWI lhwi8;  // LHWI/LLWI: load goto instr num as a immediate to r4
    RtStarsCondOpLLWI llwi8;

    RtStarsCondOpSystemCsr csrrw2;  // CSRRW: set goto instr num to jump_pc reg
    RtStarsCondOpBranch beq;        // BEQ: goto scanHeadSqArr

    RtStarsCondOpNop nop;
};

#pragma pack(pop)

}  // namespace runtime
}  // namespace cce
#endif
