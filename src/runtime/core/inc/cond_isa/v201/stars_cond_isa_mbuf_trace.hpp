/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_STARS_COND_ISA_MBUF_TRACE_HPP__
#define __CCE_RUNTIME_STARS_COND_ISA_MBUF_TRACE_HPP__

#include "stars_cond_isa_base_struct.hpp"

namespace cce {
namespace runtime {

#pragma pack(push)
#pragma pack(1)

struct MbufTraceRegParam {
    rtStarsCondIsaRegister_t loop_index_reg;
    rtStarsCondIsaRegister_t mbuf_handle_reg;
    rtStarsCondIsaRegister_t avail_reg0;
    rtStarsCondIsaRegister_t avail_reg1;
    rtStarsCondIsaRegister_t avail_reg2;
    rtStarsCondIsaRegister_t avail_reg3;
};

struct MbufOpCntFc {
    RtStarsCondOpLLWI llwiCntAddr;
    RtStarsCondOpLHWI lhwiCntAddr;
    RtStarsCondOpLoad ldrCntAddr;
    RtStarsCondOpImm addiCntAddr;
    RtStarsCondOpStore incCnt;
};

struct MbufOpDotInitFc {
    RtStarsCondOpLLWI llwiDotAddr;
    RtStarsCondOpLHWI lhwiDotAddr;
    RtStarsCondOpStore initDotVal;
};

struct DstMemValInitFc {
    RtStarsCondOpLLWI llwiMemAddr;
    RtStarsCondOpLHWI lhwiMemAddr;
    RtStarsCondOpStore initVal;
};

struct CondMbufTraceFc {
    RtStarsCondOpLLWI llwiBlkIdMask;
    RtStarsCondOpLHWI lhwiBlkIdMask;
    RtStarsCondOpOp andWithBlkIdMask;
    RtStarsCondOpImmSLLI srliForGetBlkId;

    RtStarsCondOpLLWI llwiAddrOffset;
    RtStarsCondOpLHWI lhwiAddrOffset;
    RtStarsCondOpOp multGetAddrOffset;

    RtStarsCondOpLLWI llwiTraceBaseAddr;
    RtStarsCondOpLHWI lhwiTraceBaseAddr;
    RtStarsCondOpOp addiGetRealOpTraceAddr;
    RtStarsCondOpLoad ldrTraceOpAddr;
    RtStarsSetCsrJumpPc jumpTraceNop;
    RtStarsCondOpBranch beqForBranch;

    RtStarsCondOpLLWI llwiTraceBlockSizeAddr;
    RtStarsCondOpLHWI lhwiTraceBlockSizeAddr;

    RtStarsCondOpLLWI llwiBlkSizeOffset;
    RtStarsCondOpLHWI lhwiBlkSizeOffset;
    RtStarsCondOpOp multGetBlkSizeOffset;

    RtStarsCondOpOp addiGetRealOpBlockAddr;
    RtStarsCondOpLoad ldrTraceBlockSizeAddr;

    RtStarsCondOpOp muliGetOffset;
    RtStarsCondOpOp addiGetTraceAddr;

    RtStarsCondOpLLWI llwiOpTypeOffset;
    RtStarsCondOpLHWI lhwiOpTypeOffset;
    RtStarsCondOpOp addiGetOpTypeAddr;

    RtStarsCondOpLLWI llwiOpType;
    RtStarsCondOpLHWI lhwiOpType;
    RtStarsCondOpStore storeOpType;

    RtStarsCondOpLLWI llwiOwnIdAddr;
    RtStarsCondOpLHWI lhwiOwnIdAddr;
    RtStarsCondOpLLWI llwiStreamId;
    RtStarsCondOpLHWI lhwiStreamId;
    RtStarsCondOpOp addiGetOwnIdOpAddr;
    RtStarsCondOpStore storeOwnerId;

    RtStarsCondOpLLWI llwiOwnIdOccpySize;
    RtStarsCondOpLHWI lhwiOwnIdOccpySize;
    RtStarsCondOpOp addiGetLeft1BitOpAddr;
    RtStarsCondOpStore storeLeft1BitTo0;

    RtStarsCondOpLLWI llwiQidAddrOffset;
    RtStarsCondOpLHWI lhwiQidAddrOffset;
    RtStarsCondOpOp multGetQidOffset;

    RtStarsCondOpLLWI llwiQidBaseAddr;
    RtStarsCondOpLHWI lhwiQidBaseAddr;
    RtStarsCondOpOp addiGetOpQidAddr;

    RtStarsCondOpLLWI llwiQidOffset;
    RtStarsCondOpLHWI lhwiQidOffset;
    RtStarsCondOpOp addiGetQidAddr;

    RtStarsCondOpLoad ldrDstQid;
    RtStarsCondOpStore storeQid;

    RtStarsCondOpLLWI llwiUpdateTimeOffset;
    RtStarsCondOpLHWI lhwiUpdateTimeOffset;
    RtStarsCondOpOp addiGetUpdateTimeAddr;

    RtStarsCondOpLLWI llwiAxiUserVaCfgMask;
    RtStarsCondOpLLWI llwiLpSysCntAddr;
    RtStarsCondOpLHWI lhwiLpSysCntAddr;
    RtStarsCondOpLoad ldrLpSysCntAddr;
    RtStarsCondOpSystemCsr csrrcForLpSysCntAddr;
    RtStarsCondOpLoad ldrLpSysCnt;
    RtStarsCondOpSystemCsr csrrsForLpSysCntAddr;

    RtStarsCondOpStore storeUpdateTime;
    RtStarsCondOpNop nop;
};

#pragma pack(pop)
} // namespace runtime
} // namespace cce
#endif // __CCE_RUNTIME_STARS_COND_ISA_MBUF_TRACE_HPP__