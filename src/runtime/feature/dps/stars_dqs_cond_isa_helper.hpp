/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_STARS_DQS_COND_ISA_HELPER_HPP__
#define __CCE_RUNTIME_STARS_DQS_COND_ISA_HELPER_HPP__

#include "stars_cond_isa_struct.hpp"
#include "stars_cond_isa_helper.hpp"
#include "stars_cond_isa_batch_struct.hpp"

namespace cce {
namespace runtime {
void ConstructMbufFreeInstrFc(RtStarsDqsMbufFreeFc &fc, const RtDqsMbufFreeFcPara &funcCallPara);
void ConstructDqsEnqueueFc(RtStarsDqsEnqueueFc &fc, const RtStarsDqsFcPara &funcCallPara);
void ConstructDqsDequeueFc(RtStarsDqsDequeueFc &fc, const RtStarsDqsFcPara &funcCallPara);
void ConstructDqsBatchDequeueFc(RtStarsDqsBatchDequeueFc &fc, const RtStarsDqsBatchDeqFcPara &funcCallPara);
void ConstructDqsFrameAlignFc(RtStarsDqsFrameAlignFc &fc, const RtStarsDqsFrameAlignFcPara &fcPara);
void ConstructDqsPrepareFc(RtStarsDqsPrepareOutFc &fc, const RtStarsDqsPrepareFcPara &fcPara);
void ConstructDqsZeroCopyFc(RtStarsDqsZeroCopyFc &fc, const RtStarsDqsZeroCopyPara &funcCallPara);
void ConstructConditionCopyFc(RtStarsDqsConditionCopyFc &fc, const RtStarsDqsConditionCopyPara &funcCallPara);
void ConstructDqsInterChipPreProcFc(RtStarsDqsInterChipPreProcFc &fc, const RtStarsDqsInterChipPreProcPara &funcCallPara);
void ConstructDqsInterChipPostProcFc(RtStarsDqsInterChipPostProcFc &fc, const RtStarsDqsInterChipPostProcPara &funcCallPara);
void ConstructDqsAdspcFc(RtStarsDqsAdspcFc &fc, const RtStarsDqsAdspcFcPara &fcPara);

template<typename T>
void ConstructDqsSchedEndInstr(const uint16_t sqId, T &sqe)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
 
    ConstructLHWI(r1, sqId, sqe.lhwi);
    ConstructLLWI(r1, sqId, sqe.llwi);
    ConstructGotoR(r1, r0, sqe.gotor);
    // NOP
    for (RtStarsCondOpNop &nop : sqe.nop) {
        ConstructNop(nop);
    }
}
} // namespace runtime
} // namespace cce
#endif //__CCE_RUNTIME_STARS_DQS_COND_ISA_HELPER_HPP__
