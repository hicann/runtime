/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "cond_op_manager.hpp"
#include "inner_thread_local.hpp"

namespace cce {
namespace runtime {

static const CondIsaTaskFuncs* g_condIsaTaskFuncs[CHIP_END] = {};

CondIsaConstructFuncs g_condIsaConstructFunc[CHIP_END] = {};

void RegCondIsaTaskFuncs(const rtChipType_t chipType, const CondIsaTaskFuncs* const funcs)
{
    if ((chipType < CHIP_BEGIN) || (chipType >= CHIP_END)) {
        RT_LOG(RT_LOG_ERROR, "Invalid chipType = %d, valid range: [%d, %d).", chipType, CHIP_BEGIN, CHIP_END);
        return;
    }
    if (funcs == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Cond ISA task funcs is null, chipType = %d.", chipType);
        return;
    }
    g_condIsaTaskFuncs[chipType] = funcs;
}

const CondIsaTaskFuncs* GetCurrentCondIsaTaskFuncs()
{
    const rtChipType_t chipType = InnerThreadLocalContainer::GetCurrentChipType();
    if ((chipType < CHIP_BEGIN) || (chipType >= CHIP_END)) {
        RT_LOG(RT_LOG_ERROR, "Invalid chipType = %d, valid range: [%d, %d).", chipType, CHIP_BEGIN, CHIP_END);
        return nullptr;
    }
    return g_condIsaTaskFuncs[chipType];
}

void RegCondIsaConstructFunc(const rtChipType_t chipType, const CondIsaConstructFuncs& funcs)
{
    if ((chipType < CHIP_BEGIN) || (chipType >= CHIP_END)) {
        RT_LOG(RT_LOG_ERROR, "Invalid chipType = %d, valid range: [%d, %d).", chipType, CHIP_BEGIN, CHIP_END);
        return;
    }

    g_condIsaConstructFunc[chipType].constructNop = funcs.constructNop;
    g_condIsaConstructFunc[chipType].constructLoad = funcs.constructLoad;
    g_condIsaConstructFunc[chipType].constructLoadImm = funcs.constructLoadImm;
    g_condIsaConstructFunc[chipType].constructOpImmAndi = funcs.constructOpImmAndi;
    g_condIsaConstructFunc[chipType].constructOpImmSlli = funcs.constructOpImmSlli;
    g_condIsaConstructFunc[chipType].constructOpOp = funcs.constructOpOp;
    g_condIsaConstructFunc[chipType].constructLhwi = funcs.constructLhwi;
    g_condIsaConstructFunc[chipType].constructLlwi = funcs.constructLlwi;
    g_condIsaConstructFunc[chipType].constructBranch = funcs.constructBranch;
    g_condIsaConstructFunc[chipType].constructLoop = funcs.constructLoop;
    g_condIsaConstructFunc[chipType].constructActiveI = funcs.constructActiveI;
    g_condIsaConstructFunc[chipType].constructDeActiveI = funcs.constructDeActiveI;
    g_condIsaConstructFunc[chipType].constructActiveR = funcs.constructActiveR;
    g_condIsaConstructFunc[chipType].constructDeActiveR = funcs.constructDeActiveR;
    g_condIsaConstructFunc[chipType].constructGotoI = funcs.constructGotoI;
    g_condIsaConstructFunc[chipType].constructGotoR = funcs.constructGotoR;
    g_condIsaConstructFunc[chipType].constructStore = funcs.constructStore;
    g_condIsaConstructFunc[chipType].constructSystemCsr = funcs.constructSystemCsr;
    g_condIsaConstructFunc[chipType].constructFuncCall = funcs.constructFuncCall;
    g_condIsaConstructFunc[chipType].constructErrorInstr = funcs.constructErrorInstr;
}

} // namespace runtime
} // namespace cce
