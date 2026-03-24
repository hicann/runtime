/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_STARS_COND_ISA_BASE_STRUCT_HPP__
#define __CCE_RUNTIME_STARS_COND_ISA_BASE_STRUCT_HPP__

#include "base.hpp"

namespace cce {
namespace runtime {

#pragma pack(push)
#pragma pack(1)

enum rtStarsCondIsaRegister_t : uint32_t {
    RT_STARS_COND_ISA_REGISTER_R0 = 0,       // R0 is always zero, can't be destination register
    RT_STARS_COND_ISA_REGISTER_R1 = 1,
    RT_STARS_COND_ISA_REGISTER_R2 = 2,
    RT_STARS_COND_ISA_REGISTER_R3 = 3,
    RT_STARS_COND_ISA_REGISTER_R4 = 4,
    RT_STARS_COND_ISA_REGISTER_R5 = 5,

    RT_STARS_COND_ISA_REGISTER_R6 = 6,       // 1952 add 6~10 destination register
    RT_STARS_COND_ISA_REGISTER_R7 = 7,
    RT_STARS_COND_ISA_REGISTER_R8 = 8,
    RT_STARS_COND_ISA_REGISTER_R9 = 9,
    RT_STARS_COND_ISA_REGISTER_R10 = 10
};

// load data form addr of (rs1+signed(immd)) to register rd, RT_STARS_COND_ISA_OP_CODE_LOAD
// func3: LDR(LD_R)
struct RtStarsCondOpLoad {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1;
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t reserved1 : 1;
    uint32_t immd : 12;
};

// load addr data to register rd, RT_STARS_COND_ISA_OP_CODE_LOAD_IMM
struct RtStarsCondOpLoadImm {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved : 1; // reserved
    uint32_t func3 : 3;
    uint32_t immdAddrHigh : 17;
    uint32_t immdAddrLow;
};

// store register data to ddr, RT_STARS_COND_ISA_OP_CODE_STORE
struct RtStarsCondOpStore {
    uint32_t opCode : 7;
    uint32_t immdLow : 5;
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t reserved1 : 1;
    uint32_t rs2 : 4;
    uint32_t reserved2 : 1;
    uint32_t immdHigh : 7;
};

// Op imm:RT_STARS_COND_ISA_OP_CODE_OP_IMM
// func3 :ADDI/SLTI[U]/ANDI/ORI/XORI
struct RtStarsCondOpImm {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1; // reserved
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t reserved1 : 1; // reserved
    uint32_t immd : 12;
};

// Op imm:RT_STARS_COND_ISA_OP_CODE_OP_IMM
// func3  :SLLI SRLI SRAI
struct RtStarsCondOpImmSLLI {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1; // reserved
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t reserved1 : 1; // reserved
    uint32_t shamt : 6;
    uint32_t func7 : 6;
};

// Op imm:RT_STARS_COND_ISA_OP_CODE_OP
// func3  :ADD SLL SLT SLTU XOR SRL OR AND  func7: 0000000
// func3  :SUB SRA                          func7: 0100000
// func3  :MUL                              func7: 0000001
struct RtStarsCondOpOp {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1; // reserved
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t reserved1 : 1; // reserved
    uint32_t rs2 : 4;
    uint32_t reserved3 : 1; // reserved
    uint32_t func7 : 7;
};

// nop is using op-imm ADDI
using RtStarsCondOpNop = RtStarsCondOpImm;

// LWI LHWI:RT_STARS_COND_ISA_OP_CODE_LWI
struct RtStarsCondOpLHWI {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1; // reserved
    uint32_t func3 : 3;
    uint32_t reserved1 : 2; // reserved
    uint32_t immd : 15;
};

// LWI LLWI: RT_STARS_COND_ISA_OP_CODE_LWI
struct RtStarsCondOpLLWI {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1; // reserved
    uint32_t func3 : 3;
    uint32_t immdHigh : 17;
    uint32_t immdLow : 32;
};

// Branch: RT_STARS_COND_ISA_OP_CODE_BRANCH
struct RtStarsCondOpBranch {
    uint32_t opCode : 7;
    uint32_t jumpInstrOffset : 4;
    uint32_t rsvd : 1;
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t rsvd1 : 1;
    uint32_t rs2 : 4;
    uint32_t rsvd2 : 1;
    uint32_t rsvd3 : 7;
};

// Stream ActiveI: RT_STARS_COND_ISA_OP_CODE_STREAM
struct RtStarsCondOpStreamActiveI {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1; // reserved
    uint32_t func3 : 3;
    uint32_t reserved1 : 5;
    uint32_t sqId : 12;
};

// Stream DeActiveI is same as RtStarsCondOpStreamActiveI
using RtStarsCondOpStreamDeActiveI = RtStarsCondOpStreamActiveI;

// Stream ActiveR: RT_STARS_COND_ISA_OP_CODE_STREAM
struct RtStarsCondOpStreamActiveR {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1;
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t reserved1 : 1;
    uint32_t reserved2 : 12;
};

// Stream DeActiveR is same as RtStarsCondOpStreamActiveR
using RtStarsCondOpStreamDeActiveR = RtStarsCondOpStreamActiveR;

// Stream GotoI: RT_STARS_COND_ISA_OP_CODE_STREAM
struct RtStarsCondOpStreamGotoI {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1; // reserved
    uint32_t func3 : 3;
    uint32_t reserved1 : 17;
    uint32_t sqId : 11;
    uint32_t reserved2 : 5;
    uint32_t sqHead : 16;
};

// Stream Goto_R: RT_STARS_COND_ISA_OP_CODE_STREAM
struct RtStarsCondOpStreamGotoR {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1;
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t reserved1 : 1;
    uint32_t reserved2 : 12;
};

// LOOP  RT_STARS_COND_ISA_OP_CODE_LOOP
struct RtStarsCondOpLoop {
    uint32_t opCode : 7;
    uint32_t jumpInstrOffset : 4;
    uint32_t rsvd : 1;
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t delayCycle : 13;
};

//CSR RT_STARS_COND_ISA_OP_CODE_SYSTEM
struct RtStarsCondOpSystemCsr {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1;
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t reserved1 : 1;
    uint32_t csrReg : 12;
};

// func_call
struct RtStarsCondOpFuncCall {
    uint32_t opCode : 7;
    uint32_t reserved0 : 3;
    uint32_t reserved1 : 2;
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t reserved2 : 1;
    uint32_t rs2 : 4;
    uint32_t reserved3 : 1;
    uint32_t reserved4 : 7;
};

#pragma pack(pop)
}
}
#endif // __CCE_RUNTIME_STARS_COND_ISA_BASE_STRUCT_HPP__

