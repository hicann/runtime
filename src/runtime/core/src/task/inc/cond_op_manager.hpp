/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_CORE_SRC_TASK_INC_COND_OP_MANAGER_HPP
#define RUNTIME_CORE_SRC_TASK_INC_COND_OP_MANAGER_HPP

#include "task_info.hpp"
#include "stars_base_cond_isa_define.hpp"
#include "stars_cond_isa_struct.hpp"

namespace cce {
namespace runtime {

using CondIsaTaskFunc = rtError_t (*)(TaskInfo* taskInfo);

struct CondIsaTaskFuncs {
    CondIsaTaskFunc prepareStreamSwitch;
    CondIsaTaskFunc prepareStreamActive;
    CondIsaTaskFunc reconstructStreamActive;
    CondIsaTaskFunc prepareModelExecuteFuncCall;
};

using ConstructNopFunc = void (*)(void* nop);
using ConstructLoadFunc = void (*)(
    rtStarsCondIsaRegister_t rs1Reg, uint16_t imd, rtStarsCondIsaRegister_t dstReg, rtStarsCondIsaLoadFunc3_t func3,
    void* load);
using ConstructLoadImmFunc =
    void (*)(rtStarsCondIsaRegister_t dstReg, uint64_t addr, rtStarsCondIsaLoadImmFunc3_t func3, void* loadImm);
using ConstructOpImmAndiFunc = void (*)(
    rtStarsCondIsaRegister_t rs1Reg, rtStarsCondIsaRegister_t dstReg, uint32_t immd, RtStarsCondIsaOpImmFunc3 func3,
    void* opImmAndi);
using ConstructOpImmSlliFunc = void (*)(
    rtStarsCondIsaRegister_t rs1Reg, rtStarsCondIsaRegister_t dstReg, uint8_t shamt, RtStarsCondIsaOpImmFunc3 func3,
    rtStarsCondIsaOpImmFunc7_t func7, void* opImmSlli);
using ConstructOpOpFunc = void (*)(
    rtStarsCondIsaRegister_t rs1Reg, rtStarsCondIsaRegister_t rs2Reg, rtStarsCondIsaRegister_t dstReg,
    rtStarsCondIsaOpFunc3_t func3, RtStarsCondIsaOpFunc7 func7, void* opOp);
using ConstructLhwiFunc = void (*)(rtStarsCondIsaRegister_t dstReg, uint64_t immd, void* opLHWI);
using ConstructLlwiFunc = void (*)(rtStarsCondIsaRegister_t dstReg, uint64_t immd, void* opLLWI);
using ConstructBranchFunc = void (*)(
    rtStarsCondIsaRegister_t rs1Reg, rtStarsCondIsaRegister_t rs2Reg, rtStarsCondIsaBranchFunc3_t func3,
    uint8_t instrOffset, void* opBranch);
using ConstructLoopFunc =
    void (*)(rtStarsCondIsaRegister_t rs1Reg, uint16_t delayCycle, uint8_t instrOffset, void* opLoop);
using ConstructActiveIFunc = void (*)(rtStarsCondIsaRegister_t dstReg, uint16_t activeStreamSqId, void* opActiveI);
using ConstructDeActiveIFunc =
    void (*)(rtStarsCondIsaRegister_t dstReg, uint16_t deActiveStreamSqId, void* opDeActiveI);
using ConstructActiveRFunc =
    void (*)(rtStarsCondIsaRegister_t rs1Reg, rtStarsCondIsaRegister_t dstReg, void* opActiveR);
using ConstructDeActiveRFunc =
    void (*)(rtStarsCondIsaRegister_t rs1Reg, rtStarsCondIsaRegister_t dstReg, void* opDeActiveR);
using ConstructGotoIFunc =
    void (*)(rtStarsCondIsaRegister_t dstReg, uint16_t activeStreamSqId, uint16_t head, void* opGotoI);
using ConstructGotoRFunc = void (*)(rtStarsCondIsaRegister_t sr1Reg, rtStarsCondIsaRegister_t dstReg, void* opGotoR);
using ConstructStoreFunc = void (*)(
    rtStarsCondIsaRegister_t addrReg, rtStarsCondIsaRegister_t valReg, uint16_t immdOffset,
    RtStarsCondIsaStoreFunc3 func3, void* opStore);
using ConstructSystemCsrFunc = void (*)(
    rtStarsCondIsaRegister_t srReg, rtStarsCondIsaRegister_t dstReg, rtStarsCondCsrRegister_t csrReg,
    rtStarsCondIsaSystemFunc3_t func3, void* opCsr);
using ConstructFuncCallFunc =
    void (*)(rtStarsCondIsaRegister_t rs1Reg, rtStarsCondIsaRegister_t rs2Reg, void* opFuncCall);
using ConstructErrorInstrFunc = void (*)(void* opErrInstr);

struct CondIsaConstructFuncs {
    ConstructNopFunc constructNop;
    ConstructLoadFunc constructLoad;
    ConstructLoadImmFunc constructLoadImm;
    ConstructOpImmAndiFunc constructOpImmAndi;
    ConstructOpImmSlliFunc constructOpImmSlli;
    ConstructOpOpFunc constructOpOp;
    ConstructLhwiFunc constructLhwi;
    ConstructLlwiFunc constructLlwi;
    ConstructBranchFunc constructBranch;
    ConstructLoopFunc constructLoop;
    ConstructActiveIFunc constructActiveI;
    ConstructDeActiveIFunc constructDeActiveI;
    ConstructActiveRFunc constructActiveR;
    ConstructDeActiveRFunc constructDeActiveR;
    ConstructGotoIFunc constructGotoI;
    ConstructGotoRFunc constructGotoR;
    ConstructStoreFunc constructStore;
    ConstructSystemCsrFunc constructSystemCsr;
    ConstructFuncCallFunc constructFuncCall;
    ConstructErrorInstrFunc constructErrorInstr;
};

extern CondIsaConstructFuncs g_condIsaConstructFunc[CHIP_END];

void RegCondIsaTaskFuncs(rtChipType_t chipType, const CondIsaTaskFuncs* funcs);
const CondIsaTaskFuncs* GetCurrentCondIsaTaskFuncs();
void RegCondIsaConstructFunc(rtChipType_t chipType, const CondIsaConstructFuncs& funcs);

} // namespace runtime
} // namespace cce
#endif // RUNTIME_CORE_SRC_TASK_INC_COND_OP_MANAGER_HPP
