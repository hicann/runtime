/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_STARS_BASE_COND_ISA_DEFINE_HPP__
#define __CCE_RUNTIME_STARS_BASE_COND_ISA_DEFINE_HPP__

#include "base.hpp"

#define STARS_SIMPLE_SQ_TAIL_OFFSET (0x8ULL)
#define STARS_SIMPLE_SQ_HEAD_OFFSET (0x10ULL)
#define STARS_SIMPLE_SQ_ENABLE_OFFSET (0x14ULL)
#define DAVID_SIMPLE_SQ_TAIL_OFFSET (0x0ULL)

namespace cce {
namespace runtime {
enum RtStarsCondIsaOpCode : uint32_t {
    RT_STARS_COND_ISA_OP_CODE_OP_IMM = 0B0010011,                      // Integer Register-immd Instructions
    RT_STARS_COND_ISA_OP_CODE_NOP = RT_STARS_COND_ISA_OP_CODE_OP_IMM,  // NOP is using OP_IMM ADDI R0,R0,0
    RT_STARS_COND_ISA_OP_CODE_OP = 0B0110011,                          // Integer Register-Register Operations
    RT_STARS_COND_ISA_OP_CODE_LWI = 0B1011011,                         // load immd
    RT_STARS_COND_ISA_OP_CODE_BRANCH = 0B1100011,                      // Conditional stream-jump
    RT_STARS_COND_ISA_OP_CODE_LOOP = 0B1111011,                        // LOOP
    RT_STARS_COND_ISA_OP_CODE_STREAM = 0B0101011,                      // STREAM
    RT_STARS_COND_ISA_OP_CODE_LOAD_IMM = 0B0000111,                    // LOAD immd
    RT_STARS_COND_ISA_OP_CODE_LOAD = 0B0000011,                        // Load
    RT_STARS_COND_ISA_OP_CODE_STORE = 0B0100111,                       // Store
    RT_STARS_COND_ISA_OP_CODE_FUNC_CALL = 0B1101011,                   // FUNC_CALL
    RT_STARS_COND_ISA_OP_CODE_SYSTEM = 0B1110011,                      // CSR
    RT_STARS_COND_ISA_OP_CODE_GQM = 0B0000101                          // GQM
};

enum rtStarsCondCsrRegister_t : uint32_t {
    RT_STARS_COND_CSR_AXI_USER_REG = 0,
    RT_STARS_COND_CSR_CSQ_STATUS_REG = 1,
    RT_STARS_COND_CSR_EXE_INFO_REG = 2,
    RT_STARS_COND_CSR_JUMP_PC_REG = 3,
};

// enum for isa op Load Imm func3
enum rtStarsCondIsaLoadImmFunc3_t : uint32_t {
    RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LB = 0B000,
    RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LH = 0B001,
    RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LW = 0B010,
    RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LD = 0B011,
    RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LBU = 0B100,
    RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LHU = 0B101,
    RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LWU = 0B110
};
// enum for isa op Op Imm func3
enum RtStarsCondIsaOpImmFunc3 : uint32_t{
    RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI = 0B000,
    RT_STARS_COND_ISA_OP_IMM_FUNC3_NOP = RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI,  // NOP is using OP_IMM ADDI R0,R0,0
    RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI = 0B001,
    RT_STARS_COND_ISA_OP_IMM_FUNC3_SLTI = 0B010,
    RT_STARS_COND_ISA_OP_IMM_FUNC3_SLTIU = 0B011,
    RT_STARS_COND_ISA_OP_IMM_FUNC3_XORI = 0B100,
    RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI = 0B101,
    RT_STARS_COND_ISA_OP_IMM_FUNC3_ORI = 0B110,
    RT_STARS_COND_ISA_OP_IMM_FUNC3_ANDI = 0B111,
    RT_STARS_COND_ISA_OP_IMM_FUNC3_SRAI = 0B101  // diff with SRLI by func7
};

// enum for isa op Op Imm func7
enum rtStarsCondIsaOpImmFunc7_t : uint32_t {
    RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI = 0B000000,
    RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI = 0B000000,
    RT_STARS_COND_ISA_OP_IMM_FUNC7_SRAI = 0B010000
};

// enum for isa op Op func3. OP:Integer Register-Register Operations

enum rtStarsCondIsaOpFunc3_t : uint32_t {
    RT_STARS_COND_ISA_OP_FUNC3_ADD = 0B000,
    RT_STARS_COND_ISA_OP_FUNC3_SLL = 0B001,
    RT_STARS_COND_ISA_OP_FUNC3_SLT = 0B010,
    RT_STARS_COND_ISA_OP_FUNC3_SLTU = 0B011,
    RT_STARS_COND_ISA_OP_FUNC3_XOR = 0B100,
    RT_STARS_COND_ISA_OP_FUNC3_SRL = 0B101,
    RT_STARS_COND_ISA_OP_FUNC3_OR = 0B110,
    RT_STARS_COND_ISA_OP_FUNC3_AND = 0B111,
    RT_STARS_COND_ISA_OP_FUNC3_SUB = 0B000,
    RT_STARS_COND_ISA_OP_FUNC3_SRA = 0B101,
    RT_STARS_COND_ISA_OP_FUNC3_MUL = 0B000
};

// enum for isa op Op func7. OP:Integer Register-Register Operations
enum RtStarsCondIsaOpFunc7 : uint32_t {
    RT_STARS_COND_ISA_OP_FUNC7_ADD = 0B0000000,
    RT_STARS_COND_ISA_OP_FUNC7_SLL = 0B0000000,
    RT_STARS_COND_ISA_OP_FUNC7_SLT = 0B0000000,
    RT_STARS_COND_ISA_OP_FUNC7_SLTU = 0B0000000,
    RT_STARS_COND_ISA_OP_FUNC7_XOR = 0B0000000,
    RT_STARS_COND_ISA_OP_FUNC7_SRL = 0B0000000,
    RT_STARS_COND_ISA_OP_FUNC7_OR = 0B0000000,
    RT_STARS_COND_ISA_OP_FUNC7_AND = 0B0000000,
    RT_STARS_COND_ISA_OP_FUNC7_SUB = 0B0100000,
    RT_STARS_COND_ISA_OP_FUNC7_SRA = 0B0100000,
    RT_STARS_COND_ISA_OP_FUNC7_MUL = 0B0000001
};

// enum for isa op LOAD func3
enum rtStarsCondIsaLoadFunc3_t : uint32_t { RT_STARS_COND_ISA_LOAD_FUNC3_LDR = 0B011 };

// enum for isa op LWI func3
enum rtStarsCondIsaLwiFunc3_t : uint32_t { RT_STARS_COND_ISA_LWI_FUNC3_LHWI = 0B000, RT_STARS_COND_ISA_LWI_FUNC3_LLWI = 0B001 };

// enum for isa op Branch func3
enum rtStarsCondIsaBranchFunc3_t : uint32_t {
    RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ = 0B000,
    RT_STARS_COND_ISA_BRANCH_FUNC3_BNE = 0B001,
    RT_STARS_COND_ISA_BRANCH_FUNC3_BLT = 0B100,
    RT_STARS_COND_ISA_BRANCH_FUNC3_BGE = 0B101,
    RT_STARS_COND_ISA_BRANCH_FUNC3_BLTU = 0B110,
    RT_STARS_COND_ISA_BRANCH_FUNC3_BGEU = 0B111
};

// enum for isa op Stream func3
enum RtStarsCondIsaStreamFunc3 : uint32_t {
    RT_STARS_COND_ISA_STREAM_FUNC3_GOTO_I = 0B000,
    RT_STARS_COND_ISA_STREAM_FUNC3_ACTIVE_I = 0B001,
    RT_STARS_COND_ISA_STREAM_FUNC3_DEACTIVE_I = 0B010,
    RT_STARS_COND_ISA_STREAM_FUNC3_GOTO_R = 0B100,
    RT_STARS_COND_ISA_STREAM_FUNC3_ACTIVE_R = 0B101,
    RT_STARS_COND_ISA_STREAM_FUNC3_DEACTIVE_R = 0B110
};

// enum for isa op store func3
enum RtStarsCondIsaStoreFunc3 : uint32_t {
    RT_STARS_COND_ISA_STORE_FUNC3_SB = 0B000,
    RT_STARS_COND_ISA_STORE_FUNC3_SH = 0B001,
    RT_STARS_COND_ISA_STORE_FUNC3_SW = 0B010,
    RT_STARS_COND_ISA_STORE_FUNC3_SD = 0B011,
};

// enum for isa op system func3
enum rtStarsCondIsaSystemFunc3_t : uint32_t {
    RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW = 0B001,
    RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRS = 0B010,
    RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRC = 0B011,
    RT_STARS_COND_ISA_SYSTEM_FUNC3_BIA = 0B111,
};

// enum for func_call func3
enum RtStarsCondFuncCallFunc3 : uint32_t {
    RT_STARS_COND_FUNC_CALL_FUNC3 = 0B000,
};
}  // namespace runtime
}  // namespace cce
#endif
