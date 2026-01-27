/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_STARS_COND_ISA_BATCH_STRUCT_HPP__
#define __CCE_RUNTIME_STARS_COND_ISA_BATCH_STRUCT_HPP__

#include "stars_cond_isa_base_struct.hpp"
#include "stars_cond_isa_struct.hpp"

namespace cce {
namespace runtime {

#pragma pack(push)
#pragma pack(1)

struct RtStarsDqsBatchDequeueFc {
    RtStarsCondOpLLWI llwiGqmAddr;
    RtStarsCondOpLHWI lhwiGqmAddr;

    RtStarsCondOpLLWI llwiInputMbufHandleAddr;
    RtStarsCondOpLHWI lhwiInputMbufHandleAddr;

    RtStarsCondOpLLWI llwiMbufFreeAddr;
    RtStarsCondOpLHWI lhwiMbufFreeAddr;

    RtStarsCondOpLLWI llwiIndex;
    RtStarsCondOpLHWI lhwiIndex;

    RtStarsCondOpLLWI llwiAddrMask;
    RtStarsCondOpLHWI lhwiAddrMask;

    RtStarsCondOpLLWI llwi1GqmCmd;
    RtStarsCondOpLHWI lhwi1GqmCmd;

    RtStarsCondOpLLWI llwicntNotifyReadAddr;
    RtStarsCondOpLHWI lhwicntNotifyReadAddr;
    RtStarsCondOpSystemCsr csrrcCntNotfiy;
    RtStarsCondOpLoad ldrCntNotifyStat;
    RtStarsCondOpSystemCsr csrrsCntNotfiy;
    RtStarsCondOpImm left1;
    RtStarsCondOpImm right1;

    RtStarsCondOpLLWI llwiMbufPoolIndexMax;
    RtStarsCondOpLHWI lhwiMbufPoolIndexMax;

    RtStarsCondOpLLWI llwiOne;
    RtStarsCondOpLHWI lhwiOne;
    RtStarsCondOpOp LeftQueueStatus;
    RtStarsCondOpOp AndQueueStatus;

    RtStarsSetCsrJumpPc jumpNextIteration;
    RtStarsCondOpBranch eqNoData;

    RtStarsCondOpLLWI llwicntNotifyClearAddr;
    RtStarsCondOpLHWI lhwicntNotifyClearAddr;
    RtStarsCondOpSystemCsr csrrcClearNotify;
    RtStarsCondOpStore swClearNotify;
    RtStarsCondOpSystemCsr csrrsClearNotify;

    RtStarsCondOpLoad ldrGqmRealAddr;
    RtStarsCondGqm gqm;

    RtStarsCondOpLLWI llwiDfxAddr;
    RtStarsCondOpLHWI lhwiDfxAddr;
    RtStarsCondOpStore swdfxGqmPopRes;
    RtStarsCondOpImmSLLI slliGqmErrcode;
    RtStarsSetCsrJumpPc jumpPopError;
    RtStarsCondOpBranch bneErrPop;

    RtStarsCondOpStore swdfxHandle;

    RtStarsSetCsrJumpPc jumpPcHandleErr;
    RtStarsCondOpImmSLLI srliHandleValue;
    RtStarsCondOpBranch bneErrHandle;

    RtStarsCondOpImm ldrHandleCacheAddr;
    RtStarsCondOpLLWI llwiHandleCnt;
    RtStarsCondOpLHWI lhwiHandleCnt;
    RtStarsCondOpOp AddQueueStatus;
    RtStarsCondOpLoad ldrHandleCacheCnt;
    RtStarsCondOpImm left2;
    RtStarsCondOpImm right2;

    RtStarsSetCsrJumpPc jumpNotFull;
    RtStarsCondOpBranch bneCacheSize0;

    RtStarsCondOpLoad ldrNewValue;
    RtStarsCondOpImm left3;
    RtStarsCondOpImm right3;
    RtStarsCondOpImm addi1GetOldAddr;
    RtStarsCondOpLoad ldrOldValue;
    RtStarsCondOpImm left4;
    RtStarsCondOpImm right4;
    RtStarsCondOpStore swNew;

    RtStarsCondOpLLWI llwiHandleCacheDeep;
    RtStarsCondOpLHWI lhwiHandleCacheDeep;
    RtStarsSetCsrJumpPc jumpNotFull2;
    RtStarsCondOpBranch bneCacheSize1;

    RtStarsCondOpStore swHandle;

    RtStarsSetCsrJumpPc jumpFreeHandle;
    RtStarsCondOpBranch beqFreeHandle;

    RtStarsCondOpLLWI llwiHandleCnt1;
    RtStarsCondOpLHWI lhwiHandleCnt1;
    RtStarsCondOpOp AddQueueStatus1;
    RtStarsCondOpImm addi1CntAdd;
    RtStarsCondOpStore swNew1;
    RtStarsCondOpStore swHandle1;

    RtStarsSetCsrJumpPc jumpNextIteration1;
    RtStarsCondOpBranch eqNoDataPorcess;

    RtStarsCondOpLoad ldrMbuffMangAddr;

    RtStarsCondOpLLWI llwiAddrMask1;
    RtStarsCondOpLHWI lhwiAddrMask1;

    RtStarsCondOpSystemCsr csrrcMbufManag;
    RtStarsCondOpStore swHanleForFree;
    RtStarsCondOpSystemCsr csrrsMbufManag;

    RtStarsCondOpImm addi1UpdateGqmAddr;
    RtStarsCondOpImm addi1UpdateInputMbufHandleAddr;
    RtStarsCondOpImm addi1UpdateMbufFreeAddr;
    RtStarsCondOpImm addi1UpdateIndex;

    RtStarsCondOpLLWI llwiMbufPoolIndexMax1;
    RtStarsCondOpLHWI lhwiMbufPoolIndexMax1;
    RtStarsSetCsrJumpPc jumpStartLoop;

    RtStarsCondOpBranch bltStartLoop;

    RtStarsSetCsrJumpPc jumpEnd;
    RtStarsCondOpBranch EqJumpEnd;

    RtStarsCondOpSystemCsr wPopErr;
    RtStarsSetCsrJumpPc jumpPcErr;
    RtStarsCondOpBranch EqJumpErr;
    RtStarsCondOpSystemCsr wHandleErr;
    RtStarsCondOpLoad ldrMbuffMangAddr1;
    RtStarsCondOpLLWI llwiAddrMask2;
    RtStarsCondOpLHWI lhwiAddrMask2;
    RtStarsCondOpSystemCsr csrrcMbufManag1;
    RtStarsCondOpStore swHanleForFree1;
    RtStarsCondOpSystemCsr csrrsMbufManag1;
    RtStarsCondOpErrorInstr err;

    RtStarsCondOpNop end;
};

struct RtStarsDqsFrameAlignFc {
    RtStarsCondOpLLWI           llwi1;
    RtStarsCondOpLHWI           lhwi1;
    RtStarsCondOpLoad           load1;

    RtStarsSetCsrJumpPc         jumpPc1;
    RtStarsCondOpBranch         bne;

    RtStarsCondOpLLWI           llwi2;
    RtStarsCondOpLHWI           lhwi2;
    RtStarsCondOpStreamGotoR    gotor;

    RtStarsCondOpNop            end;
};

#pragma pack(pop)
}
}
#endif // __CCE_RUNTIME_STARS_COND_ISA_BATCH_STRUCT_HPP__
