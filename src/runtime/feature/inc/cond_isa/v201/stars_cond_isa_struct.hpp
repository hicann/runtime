/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_STARS_COND_ISA_STRUCT_HPP__
#define __CCE_RUNTIME_STARS_COND_ISA_STRUCT_HPP__

#include "base.hpp"
#include "stars_cond_isa_base_struct.hpp"
#include "stars_cond_isa_para.hpp"

namespace cce {
namespace runtime {

#pragma pack(push)
#pragma pack(1)

// GQM instr
struct RtStarsCondGqm {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 4; // reserved
    uint32_t rs1 : 4;
    uint32_t reserved1 : 1; // reserved
    uint32_t rs2 : 4;
    uint32_t reserved2 : 8; // reserved
};

// GQM PUSH & POP instr
struct RtStarsCondGqmOp {
    uint32_t command : 6;
    uint32_t wakeUp : 1;
    uint32_t reserved0 : 25; // reserved
    uint32_t reserved1; // reserved
};

union RtStarsCondGqmOpFc {
    RtStarsCondGqmOp inst;
    uint64_t value;
};

struct RtStarsCondOpErrorInstr {
    uint32_t err;
};

struct RtStarsSetCsrJumpPc {
    RtStarsCondOpLHWI lhwi;
    RtStarsCondOpLLWI llwi;
    RtStarsCondOpSystemCsr csrrw;
};

struct RtStarsGqmInitFc {
    RtStarsCondOpLLWI              llwi1;
    RtStarsCondOpLLWI              llwi2;
    RtStarsCondGqm                 gqm;
    RtStarsCondOpLLWI              llwi3;
    RtStarsCondOpLHWI              lhwi3;
    RtStarsCondOpStore             swdfx;
    RtStarsSetCsrJumpPc            jumpPc;
    RtStarsCondOpBranch           beq;
    RtStarsCondOpErrorInstr        err;
    RtStarsCondOpNop               end;
};

struct RtStarsDqsMbufFreeFc {
    RtStarsCondOpLLWI              llwi;
    RtStarsCondOpImm               andi;
    RtStarsCondOpLLWI              llwi1;
    RtStarsCondOpLHWI              lhwi1;
    RtStarsCondOpLLWI              llwi2;
    RtStarsCondOpLHWI              lhwi2;
    RtStarsCondOpLLWI              llwi3;
    RtStarsCondOpLHWI              lhwi3;
    RtStarsCondOpLoad              ldr1; // 读mbuf handle 32bit
    RtStarsCondOpLoad              ldr2;
    RtStarsCondOpSystemCsr         csrrc; // use PA
    RtStarsCondOpStore             sw;    // use PA
    RtStarsCondOpSystemCsr         csrrs; // restore use VA
    RtStarsCondOpImm               addi1;
    RtStarsCondOpImm               addi2;
    RtStarsCondOpImm              addi3;
    RtStarsSetCsrJumpPc            jumpPc1;
    RtStarsCondOpBranch            blt1;
    RtStarsCondOpNop               end;  // end of func, mast be the last instruction
};

struct RtStarsDqsEnqueueFc {
    RtStarsCondOpImm               andi1;
    RtStarsCondOpLLWI              llwi1;
    RtStarsCondOpLHWI              lhwi1;
    RtStarsCondOpLLWI              llwi2;
    RtStarsCondOpLHWI              lhwi2;
    RtStarsCondOpLLWI              llwi3;
    RtStarsCondOpLHWI              lhwi3;
    RtStarsCondOpLLWI              llwi7;
    RtStarsCondOpLHWI              lhwi7;
    RtStarsCondOpLLWI              llwi4;
    RtStarsCondOpLHWI              lhwi4;
    RtStarsCondOpLoad              ldr1;
    RtStarsCondOpLoad              ldr2;
    RtStarsCondOpImmSLLI           slli1;
    RtStarsCondOpImmSLLI           srli1;
    RtStarsCondOpLLWI              llwi5;
    RtStarsCondOpLHWI              lhwi5;
    RtStarsSetCsrJumpPc            jumpPc1;
    RtStarsCondOpBranch            beq1;
    RtStarsCondOpLLWI              llwi6;
    RtStarsCondOpLHWI              lhwi6;
    RtStarsSetCsrJumpPc            jumpPc2;
    RtStarsCondOpBranch            beq2;
    RtStarsSetCsrJumpPc            jumpPc3;
    RtStarsCondOpBranch            bne; // if ow, must mbufFree firstly.
    RtStarsCondOpLoad              ldr3;
    RtStarsCondOpLLWI              llwi8;
    RtStarsCondOpLHWI              lhwi8;
    RtStarsCondOpOp                and1;
    RtStarsCondOpLLWI              llwi;
    RtStarsCondOpLHWI              lhwi;
    RtStarsCondOpSystemCsr         csrrc;
    RtStarsCondOpStore             owfree;
    RtStarsCondOpSystemCsr         csrrs;
    RtStarsCondOpLoad              ldr4;
    RtStarsCondOpImmSLLI           slli2;
    RtStarsCondOpImmSLLI           srli2;
    RtStarsCondOpLoad              ldr5;
    RtStarsCondOpStore             enquei;
    RtStarsCondOpImm               addi1;
    RtStarsCondOpImm               addi2;
    RtStarsCondOpImm               addi3;
    RtStarsCondOpImm               addi4;
    RtStarsCondOpImm               addi5;
    RtStarsSetCsrJumpPc            jumpPc4;
    RtStarsCondOpBranch            blt1;
    RtStarsSetCsrJumpPc            jumpPc5;
    RtStarsCondOpBranch            beq3;
    RtStarsCondOpLLWI              llwi9;
    RtStarsCondOpLHWI              lhwi9;
    RtStarsCondOpSystemCsr         dfxFsm1;
    RtStarsCondOpErrorInstr        err1;
    RtStarsCondOpLLWI              llwi10;
    RtStarsCondOpLHWI              lhwi10;
    RtStarsCondOpSystemCsr         dfxFsm2;
    RtStarsCondOpErrorInstr        err2;
    RtStarsCondOpNop               end;
};

struct RtStarsDqsDequeueFc {
    RtStarsCondOpLLWI              llwi1;
    RtStarsCondOpLHWI              lhwi1;
    RtStarsCondOpLLWI              llwi2;
    RtStarsCondOpLHWI              lhwi2;
    RtStarsCondOpLLWI              llwi3;
    RtStarsCondOpLHWI              lhwi3;
    RtStarsCondOpLoad              ldr1;
    RtStarsCondGqm                 gqm;
    RtStarsCondOpLLWI              llwi4;
    RtStarsCondOpLHWI              lhwi4;
    RtStarsCondOpStore             swdfx1;
    RtStarsCondOpImmSLLI           slli;
    RtStarsSetCsrJumpPc            jumpPc1;
    RtStarsCondOpBranch            bne1;
    RtStarsCondOpStore             swdfx2;
    RtStarsSetCsrJumpPc            jumpPc2;

    RtStarsCondOpImmSLLI           srli1;
    RtStarsCondOpBranch            bne2;

    RtStarsCondOpStore             store;
    RtStarsSetCsrJumpPc            jumpPc3;
    RtStarsCondOpBranch            beq1;               // BEQ: r0 r0, goto nop

    RtStarsCondOpLLWI              llwi5;
    RtStarsCondOpSystemCsr         dfxFsm1;
    RtStarsCondOpErrorInstr        err1;

    RtStarsCondOpLLWI              llwi6;
    RtStarsCondOpSystemCsr         dfxFsm2;
    RtStarsCondOpErrorInstr        err2;
    RtStarsCondOpNop               end;                // end of func, mast be the last instruction
};

struct RtStarsDqsPrepareOutFc {
    // 计算input[0] private info addr
    RtStarsCondOpLLWI             llwi1;
    RtStarsCondOpLHWI             lhwi1;
    RtStarsCondOpLoad             load1;
    RtStarsCondOpLLWI             llwi2;
    RtStarsCondOpLHWI             lhwi2;
    RtStarsCondOpOp               and1;
    RtStarsCondOpImmSLLI          srli11;
    RtStarsCondOpLLWI             llwi3;
    RtStarsCondOpLHWI             lhwi4;
    RtStarsCondOpLoad             load2;
    RtStarsCondOpImmSLLI          slli6;
    RtStarsCondOpImmSLLI          srli6;
    RtStarsCondOpOp               mult1;
    RtStarsCondOpLLWI             llwi5;
    RtStarsCondOpLHWI             lhwi5;
    RtStarsCondOpLoad             load3;
    RtStarsCondOpOp               add1;

    // Loop1: 申请output mbuf handle，计算output private info addr、异常处理
    // 初始化index和for循环上界
    RtStarsCondOpImm              addi1;
    RtStarsCondOpImm              addi2;

    // 申请output mbuf，并判断mbuf的合法性
    RtStarsCondOpLLWI             llwi9;
    RtStarsCondOpLHWI             lhwi9;
    RtStarsCondOpImmSLLI          slli1;
    RtStarsCondOpOp               add2;
    RtStarsCondOpLoad             load5;
    RtStarsCondOpLoad             load6;
    RtStarsCondOpLLWI             llwi10;
    RtStarsCondOpLHWI             lhwi10;
    RtStarsCondOpOp               and2;
    RtStarsCondOpLLWI             llwi11;
    RtStarsCondOpLHWI             lhwi11;
    RtStarsCondOpStore            store1;
    RtStarsCondOpLLWI             llwi12;
    RtStarsCondOpLHWI             lhwi12;
    RtStarsCondOpStore            store2;
    RtStarsSetCsrJumpPc           jumpPc1;
    RtStarsCondOpBranch           bne;

    // 将output mbuf存入output_mbuf_list
    RtStarsCondOpLLWI             llwi13;
    RtStarsCondOpLHWI             lhwi13;
    RtStarsCondOpOp               and3;
    RtStarsCondOpLLWI             llwi14;
    RtStarsCondOpLHWI             lhwi14;
    RtStarsCondOpImmSLLI          slli2;
    RtStarsCondOpOp               add3;
    RtStarsCondOpStore            store3;

    // 计算output[i] privateinfo addr
    RtStarsCondOpLLWI             llwi15;
    RtStarsCondOpLHWI             lhwi15;
    RtStarsCondOpImmSLLI          slli3;
    RtStarsCondOpOp               add4;
    RtStarsCondOpLoad             load8;
    RtStarsCondOpImmSLLI          slli4;
    RtStarsCondOpImmSLLI          srli4;

    RtStarsCondOpLLWI             llwi16;
    RtStarsCondOpLHWI             lhwi16;
    RtStarsCondOpOp               add5;
    RtStarsCondOpLoad             load9;

    RtStarsCondOpLLWI             llwi17;
    RtStarsCondOpLHWI             lhwi17; 
    RtStarsCondOpOp               and4;
    RtStarsCondOpImmSLLI          srli14;

    RtStarsCondOpOp               mult2;
    RtStarsCondOpOp               add6;

    // Loop2: 将256B的private info从input[0]拷贝到output[i]，每次拷贝8B
    // 初始化index和for循环上界
    RtStarsCondOpImm              addi3;
    RtStarsCondOpImm              addi4;

    // 拷贝private info
    RtStarsCondOpOp               add7;
    RtStarsCondOpLoad             load10;
    RtStarsCondOpStore            store4;
    RtStarsCondOpImm              addi5;
    RtStarsCondOpImm              addi6;

    // Loop2跳转逻辑
    RtStarsCondOpImm              addi7;
    RtStarsSetCsrJumpPc           jumpPc2;
    RtStarsCondOpBranch           bltu1;

    // Loop1跳转逻辑
    RtStarsCondOpImm              addi8;
    RtStarsSetCsrJumpPc           jumpPc3;
    RtStarsCondOpBranch           bltu2;

    // 异常处理
    RtStarsSetCsrJumpPc           jumpPc4;
    RtStarsCondOpBranch           beq;
    RtStarsCondOpErrorInstr       err;
    RtStarsCondOpNop              end;
};

struct RtStarsDqsZeroCopyFc {
    RtStarsCondOpLLWI              llwi1;
    RtStarsCondOpLHWI              lhwi1;
    RtStarsCondOpLoad              ldr1;
    RtStarsCondOpImmSLLI           slli1;
    RtStarsCondOpImmSLLI           srli1;

    RtStarsCondOpLLWI              llwi2;
    RtStarsCondOpLHWI              lhwi2;
    RtStarsCondOpLoad              ldr2;
    RtStarsCondOpImmSLLI           slli2;
    RtStarsCondOpImmSLLI           srli2;

    RtStarsCondOpLLWI              llwi3;
    RtStarsCondOpLHWI              lhwi3;
    RtStarsCondOpOp                and1;
    RtStarsCondOpImmSLLI           srli3;

    RtStarsCondOpOp                mul1;

    RtStarsCondOpLLWI              llwi4;
    RtStarsCondOpLHWI              lhwi4;
    RtStarsCondOpLoad              ldr3;
    RtStarsCondOpOp                add1;

    RtStarsCondOpLLWI              llwi5;
    RtStarsCondOpLHWI              lhwi5;
    RtStarsCondOpOp                add2;

    RtStarsSetCsrJumpPc            jumpPc1;
    RtStarsCondOpBranch            beq1;

    RtStarsCondOpImmSLLI           slli3;
    RtStarsCondOpLLWI              llwi6;
    RtStarsCondOpLHWI              lhwi6;
    RtStarsCondOpOp                add3;
    RtStarsCondOpLoad              ldr4;

    RtStarsCondOpLLWI              llwi7;
    RtStarsCondOpLHWI              lhwi7;
    RtStarsCondOpOp                add4;
    RtStarsCondOpLoad              ldr5;

    RtStarsCondOpOp                add5;

    RtStarsCondOpStore             store1;
    RtStarsCondOpImmSLLI           srli4;
    RtStarsCondOpStore             store2;
    RtStarsCondOpImm               addi1;
    RtStarsSetCsrJumpPc            jumpPc2;
    RtStarsCondOpBranch            bltu1;

    RtStarsCondOpNop               end;
};

struct RtStarsDqsConditionCopyFc {
    RtStarsCondOpLLWI              llwi1;
    RtStarsCondOpLHWI              lhwi1;
    RtStarsCondOpLoad              ldr1;
    RtStarsSetCsrJumpPc            jumpPc1;
    RtStarsCondOpBranch            beq1;

    RtStarsSetCsrJumpPc            jumpPc2;
    RtStarsCondOpLLWI              llwi2;
    RtStarsCondOpLHWI              lhwi2;
    RtStarsCondOpBranch            bne1;

    RtStarsCondOpLLWI              llwi3;
    RtStarsCondOpLHWI              lhwi3;
    RtStarsCondOpOp                add1;
    RtStarsSetCsrJumpPc            jumpPc3;
    RtStarsCondOpBranch            beq2;

    RtStarsCondOpLLWI              llwi4;
    RtStarsCondOpLHWI              lhwi4;
    RtStarsCondOpImmSLLI           slli1;
    RtStarsCondOpOp                add2;
    RtStarsCondOpLoad              ldr2;

    RtStarsCondOpLLWI              llwi5;
    RtStarsCondOpLHWI              lhwi5;
    RtStarsCondOpOp                add3;
    RtStarsCondOpStore             store1;

    RtStarsCondOpImm               addi1;
    RtStarsSetCsrJumpPc            jumpPc4;
    RtStarsCondOpBranch            bltu1;
    RtStarsCondOpStore             store2;

    RtStarsSetCsrJumpPc            jumpPc5;
    RtStarsCondOpBranch            beq3;

    RtStarsCondOpLLWI              llwi6;
    RtStarsCondOpLHWI              lhwi6;
    RtStarsCondOpSystemCsr         dfxFsm1;
    RtStarsCondOpErrorInstr        err;
    
    RtStarsCondOpNop               end;
};

struct RtStarsDqsInterChipPreProcFc {
    RtStarsCondOpLLWI              llwi;
    RtStarsCondOpLLWI              llwi1;
    RtStarsCondOpLHWI              lhwi1;
    RtStarsCondOpLoad              ldr1;
    RtStarsCondOpSystemCsr         csrrc;
    RtStarsCondOpLoad              ldr2;
    RtStarsCondOpSystemCsr         csrrs;
    RtStarsCondOpImmSLLI           slli1;
    RtStarsCondOpImmSLLI           srli1;

    RtStarsSetCsrJumpPc            jumpPc1;
    RtStarsCondOpBranch            bne1;
    RtStarsCondOpImmSLLI           slli2;
    RtStarsCondOpImmSLLI           srli2;

    RtStarsCondOpLLWI              llwi2;
    RtStarsCondOpLHWI              lhwi2;
    RtStarsCondOpStore             store1;

    RtStarsCondOpLLWI              llwi3;
    RtStarsCondOpLHWI              lhwi3;
    RtStarsCondOpOp                and1;
    RtStarsCondOpImmSLLI           srli3;

    RtStarsCondOpLLWI              llwi4;
    RtStarsCondOpLHWI              lhwi4;
    RtStarsCondOpLoad              ldr4;

    RtStarsCondOpLLWI              llwi5;
    RtStarsCondOpLHWI              lhwi5;
    RtStarsCondOpLoad              ldr5;
    RtStarsCondOpImmSLLI           slli3;
    RtStarsCondOpImmSLLI           srli4;

    RtStarsCondOpOp                mul1;
    RtStarsCondOpOp                add1;
 
    RtStarsCondOpLLWI              llwi6;
    RtStarsCondOpLHWI              lhwi6;
    RtStarsCondOpStore             store2;

    RtStarsCondOpLLWI              llwi7;
    RtStarsCondOpLHWI              lhwi7;
    RtStarsCondOpLoad              ldr6;

    RtStarsCondOpLLWI              llwi8;
    RtStarsCondOpLHWI              lhwi8;
    RtStarsCondOpLoad              ldr7;
    RtStarsCondOpImmSLLI           slli4;
    RtStarsCondOpImmSLLI           srli5;

    RtStarsCondOpOp                mul2;
    RtStarsCondOpOp                add2;

    RtStarsCondOpLLWI              llwi9;
    RtStarsCondOpLHWI              lhwi9;
    RtStarsCondOpStore             store3;
    RtStarsSetCsrJumpPc            jumpPc2;
    RtStarsCondOpBranch            beq1;
    RtStarsCondOpSystemCsr         dfxFsm1;
    RtStarsCondOpErrorInstr        err;

    RtStarsCondOpNop               end;
};

struct RtStarsDqsInterChipPostProcFc {
    RtStarsCondOpLLWI              llwi1;
    RtStarsCondOpLHWI              lhwi1;
    RtStarsCondOpLLWI              llwi2;
    RtStarsCondOpLHWI              lhwi2;
    RtStarsCondOpLoad              ldr1;
    RtStarsCondOpSystemCsr         csrrcow;
    RtStarsCondOpLoad              ldr2;
    RtStarsCondOpSystemCsr         csrrsow;
    RtStarsCondOpImmSLLI           slli1;
    RtStarsCondOpImmSLLI           srli1;

    RtStarsCondOpLLWI              llwi3;
    RtStarsCondOpLHWI              lhwi3;
    RtStarsCondOpLLWI              llwi4;
    RtStarsCondOpLHWI              lhwi4;
    RtStarsSetCsrJumpPc            jumpPc1;
    RtStarsCondOpBranch            beq1;
    RtStarsSetCsrJumpPc            jumpPc2;
    RtStarsCondOpBranch            beq2;
    RtStarsSetCsrJumpPc            jumpPc3;
    RtStarsCondOpBranch            bne;
    RtStarsCondOpLLWI              llwi5;
    RtStarsCondOpLHWI              lhwi5;
    RtStarsCondOpLoad              ldr3;

    RtStarsCondOpLLWI              llwi6;
    RtStarsCondOpLHWI              lhwi6;
    RtStarsCondOpOp                and1;
    RtStarsCondOpSystemCsr         csrrc1;
    RtStarsCondOpStore             sw1;
    RtStarsCondOpSystemCsr         csrrs1;
    RtStarsCondOpLLWI              llwi7;
    RtStarsCondOpLHWI              lhwi7;
    RtStarsCondOpLoad              ldr4;
    RtStarsCondOpLLWI              llwi8;
    RtStarsCondOpLHWI              lhwi8;
    RtStarsCondOpLoad              ldr5;
    RtStarsCondOpSystemCsr         csrrc2;
    RtStarsCondOpStore             sw2;
    RtStarsCondOpSystemCsr         csrrs2;

    RtStarsCondOpLLWI              llwi9;
    RtStarsCondOpLHWI              lhwi9;
    RtStarsCondOpLoad              ldr6;
    RtStarsCondOpLLWI              llwi10;
    RtStarsCondOpLHWI              lhwi10;
    RtStarsCondOpLoad              ldr7;
    RtStarsCondOpSystemCsr         csrrc3;
    RtStarsCondOpStore             sw3;
    RtStarsCondOpSystemCsr         csrrs3;

    RtStarsSetCsrJumpPc            jumpPc4;
    RtStarsCondOpBranch            beq3;
    RtStarsCondOpLLWI              llwi11;
    RtStarsCondOpLHWI              lhwi11;
    RtStarsCondOpSystemCsr         dfxFsm1;
    RtStarsCondOpErrorInstr        err1;
    RtStarsCondOpLLWI              llwi12;
    RtStarsCondOpLHWI              lhwi12;
    RtStarsCondOpSystemCsr         dfxFsm2;
    RtStarsCondOpErrorInstr        err2;
    RtStarsCondOpNop               end;
};

struct RtStarsDqsAdspcFc {
    RtStarsCondOpLLWI             llwi1;
    RtStarsCondOpLHWI             lhwi1;
    RtStarsCondOpLoad             load1;
    RtStarsCondOpImm              andi1;

    RtStarsCondOpLLWI             llwi2;
    RtStarsCondOpLHWI             lhwi2;
    RtStarsCondOpLoad             load2;
    RtStarsCondOpImm              andi2;

    RtStarsCondOpLLWI             llwiDfx;
    RtStarsCondOpLHWI             lhwiDfx;
    RtStarsCondOpStore            storeCqHead;
    RtStarsCondOpStore            storeCqTail;

    RtStarsSetCsrJumpPc           jumpPc1;
    RtStarsCondOpBranch           beq;

    RtStarsCondOpLLWI             llwi3;
    RtStarsCondOpLHWI             lhwi3;
    RtStarsCondOpLLWI             llwi4;
    RtStarsCondOpLHWI             lhwi4;
    RtStarsCondOpOp               mult;
    RtStarsCondOpOp               add;

    RtStarsCondOpImm              addi1;
    RtStarsCondOpImm              addi2;
    RtStarsCondOpLLWI             llwi5;
    RtStarsCondOpLHWI             lhwi5;
    RtStarsCondOpLoad             load3;
    RtStarsCondOpStore            store1;
    RtStarsCondOpImm              addi3;
    RtStarsCondOpImm              addi4;
    RtStarsCondOpImm              addi5;
    RtStarsSetCsrJumpPc           jumpPc2;
    RtStarsCondOpBranch           bltu;

    RtStarsCondOpImm              addi6;
    RtStarsCondOpImm              andi3;
    RtStarsCondOpStore            store2;

    RtStarsCondOpLLWI             llwi6;
    RtStarsCondOpLHWI             lhwi6;
    RtStarsCondOpLoad             load4;
    RtStarsCondOpStore            store3;

    RtStarsCondOpImmSLLI          slli1;
    RtStarsCondOpImmSLLI          srli1;

    RtStarsCondOpLLWI             llwi7;
    RtStarsCondOpLHWI             lhwi7;
    RtStarsSetCsrJumpPc           jumpPc3;
    RtStarsCondOpBranch           beq1;
    RtStarsSetCsrJumpPc           jumpPc4;
    RtStarsCondOpBranch           bneq;

    RtStarsCondOpLLWI             llwi8;
    RtStarsCondOpLHWI             lhwi8;
    RtStarsCondOpLLWI             llwi9;
    RtStarsCondOpLHWI             lhwi9;
    RtStarsCondOpOp               and1;
    RtStarsCondOpStore            store4;

    RtStarsCondOpLLWI             llwi10;
    RtStarsCondOpLHWI             lhwi10;
    RtStarsCondOpLLWI             llwi11;
    RtStarsCondOpLHWI             lhwi11;
    RtStarsCondOpStore            store5;

    RtStarsSetCsrJumpPc           jumpPc5;
    RtStarsCondOpBranch           beq2;

    RtStarsCondOpErrorInstr       err;
    RtStarsCondOpNop              end;
};

#pragma pack(pop)
}
}
#endif // __CCE_RUNTIME_STARS_COND_ISA_STRUCT_HPP__
