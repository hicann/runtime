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

struct RtStarsDqsMbufFreeFc {
    RtStarsCondOpLLWI              llwi;
    RtStarsCondOpLHWI              lhwi;
    RtStarsCondOpImm               andi;
    RtStarsCondOpLLWI              llwi1;
    RtStarsCondOpLHWI              lhwi1;
    RtStarsCondOpLLWI              llwi2;
    RtStarsCondOpLHWI              lhwi2;
    RtStarsCondOpLLWI              llwi3;
    RtStarsCondOpLHWI              lhwi3;
    RtStarsCondOpLoad              ldr1; // 读mbuf handle 32bit
    RtStarsCondOpImmSLLI           slli1;
    RtStarsCondOpImmSLLI           srli1;
    RtStarsCondOpLLWI              llwi4;
    RtStarsCondOpLHWI              lhwi4;
    RtStarsCondOpLLWI              llwi5;
    RtStarsCondOpLHWI              lhwi5;
    RtStarsSetCsrJumpPc            jumpPc1;
    RtStarsCondOpBranch            bne;
    RtStarsCondOpLLWI              llwiMaxMbuf;
    RtStarsCondOpLHWI              lhwiMaxMbuf;
    RtStarsSetCsrJumpPc            jumpPc2;
    RtStarsCondOpBranch            bgeu1;
    RtStarsCondOpLLWI              llwi6;
    RtStarsCondOpLHWI              lhwi6;
    RtStarsCondOpLLWI              llwi7;
    RtStarsCondOpLHWI              lhwi7;
    RtStarsCondOpOp                mult;
    RtStarsCondOpOp                add;
    RtStarsCondOpLoad              ldr2;
    RtStarsCondOpImmSLLI           slli2;
    RtStarsCondOpImmSLLI           srli2;
    RtStarsCondOpStore             sw1;
    RtStarsCondOpStore             sw2;
    RtStarsCondOpImm               addi1;
    RtStarsSetCsrJumpPc            jumpPc3;
    RtStarsCondOpBranch            bgeu2;
    RtStarsCondOpLoad              ldr3;
    RtStarsCondOpSystemCsr         csrrc; // use PA
    RtStarsCondOpStore             sw3;
    RtStarsCondOpSystemCsr         csrrs; // restore to VA
    RtStarsCondOpImm               addi2;
    RtStarsCondOpImm               addi3;
    RtStarsCondOpImm               addi4;
    RtStarsSetCsrJumpPc            jumpPc4;
    RtStarsCondOpBranch            blt1;
    RtStarsCondOpNop               end;  // end of func, must be the last instruction
};

#pragma pack(pop)
}
}
#endif // __CCE_RUNTIME_STARS_COND_ISA_BATCH_STRUCT_HPP__
