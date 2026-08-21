/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "capture_model.hpp"
#include "cond_op_manager.hpp"
#include "cond_op_stream_task.h"
#include "model.hpp"
#include "model_execute_task.h"
#include "stars_cond_isa_define.hpp"
#include "stars_cond_isa_helper.hpp"
#include "stars_model_execute_cond_isa_define.hpp"
#include "stream.hpp"
#include "stream_task.h"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
namespace {

#pragma pack(push)
#pragma pack(1)

struct RtStarsGetSqStateI {
    RtStarsCondOpOp and1;
    RtStarsCondOpLoadImm loadState;
};

struct RtStarsStreamActiveFcArch9201 {
    RtStarsGetSqStateI getSqFsmState;
    RtStarsSetCqeStatus dfxFsm;
    RtStarsCondOpLLWI llwiDfx0;
    RtStarsCondOpLHWI lhwiDfx0;
    RtStarsCondOpStore stdDfx0;
    RtStarsCondOpImm andiState;
    RtStarsCondOpImm xoriState9;
    RtStarsSetCsrJumpPc jumpErr;
    RtStarsCondOpBranch branchErr;
    RtStarsSetCsrJumpPc jumpRetry;
    RtStarsCondOpLoop retryLoop;
    RtStarsGetSqEnableI getSqEnable;
    RtStarsSetCsrJumpPc jumpResetHead;
    RtStarsCondOpLLWI llwiDfx1;
    RtStarsCondOpLHWI lhwiDfx1;
    RtStarsCondOpStore stdDfx1;
    RtStarsCondOpBranch branchResetHead;
    RtStarsGetSqHeadAndTailI getSqHeadAndTail;
    RtStarsSetCsrJumpPc jumpHeadTailErr;
    RtStarsCondOpLLWI llwiDfx2;
    RtStarsCondOpLHWI lhwiDfx2;
    RtStarsCondOpStore stdDfx2Head;
    RtStarsCondOpStore stdDfx2Tail;
    RtStarsCondOpBranch branchHeadTailErr;
    RtStarsDisableStreamI disableSq;
    RtStarsCondOpStreamGotoI gotoHead;
    RtStarsAddStreamActiveTimes addStreamActiveTimes;
    RtStarsCondOpStreamActiveI activeSq;
    RtStarsSetCsrJumpPc jumpEnd;
    RtStarsCondOpBranch branchEnd;
    RtStarsCondOpErrorInstr err;
    RtStarsCondOpNop end;
};

struct rtStarsStreamSwitchFcArch9201_t {
    RtStarsCondOpLoadImm loadVar;
    RtStarsCondOpLHWI lhwiValue;
    RtStarsCondOpLLWI llwiValue;
    RtStarsSetCsrJumpPc jumpEnd;
    RtStarsCondOpBranch branchEnd;
    RtStarsStreamActiveFcArch9201 streamActiveFc;
    RtStarsCondOpStreamDeActiveI deactiveCurrentSq;
    RtStarsCondOpNop end;
};

struct rtStarsStreamSwitchExFcArch9201_t {
    RtStarsCondOpLoadImm loadVar;
    RtStarsCondOpLoadImm loadValue;
    RtStarsSetCsrJumpPc jumpEnd;
    RtStarsCondOpBranch branchEnd;
    RtStarsStreamActiveFcArch9201 streamActiveFc;
    RtStarsCondOpStreamDeActiveI deactiveCurrentSq;
    RtStarsCondOpNop end;
};

struct RtStarsModelExeCheckSqState {
    RtStarsCondOpImmSLLI slliSqId;
    RtStarsCondOpLHWI lhwiSqArray;
    RtStarsCondOpLLWI llwiSqArray;
    RtStarsCondOpOp addSqOffset;
    RtStarsCondOpLoad loadSqVirtualAddr;
    RtStarsCondOpLoad loadSqState;
    RtStarsCondOpImm andiSqState;
    RtStarsSetCsrJumpPc jumpRetry;
    RtStarsCondOpLoop retryLoop;
    RtStarsSetCsrJumpPc jumpError;
    RtStarsCondOpBranch branchError;
};

struct RtStarsModelExeFuncCallArch9201 {
    RtStarsModelExeScanSq scanSq;
    RtStarsModelExeCheckSqState checkSqState;
    RtStarsModelExeCheckSqDisable checkSqDisable;
    RtStarsModelExeCheckSqHeadTail checkSqHeadTail;
    RtStarsModelExeDeactiveSq deactiveSq;
    RtStarsModelExeActiveSq activeHeadSq;
    RtStarsModelExeCheckSqErrInstr checkSqDisableErrInstr;
    RtStarsModelExeCheckSqErrInstr checkSqHeadTailErrInstr;
    RtStarsModelExeExeErrInstr errInstr;
    RtStarsModelExeExeEndInstr endInstr;
};

#pragma pack(pop)

static void ConstrucModelExeCheckSqStateArch9201(
    rtStarsModelExeFuncCallPara_t& funcCallPara, RtStarsModelExeCheckSqState& checkSqState)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;

    ConstructOpImmSlli(
        r3, r5, 3U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, checkSqState.slliSqId);
    ConstructLHWI(r4, funcCallPara.sqVirtualAddr, checkSqState.lhwiSqArray);
    ConstructLLWI(r4, funcCallPara.sqVirtualAddr, checkSqState.llwiSqArray);
    ConstructOpOp(r4, r5, r4, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, checkSqState.addSqOffset);
    ConstructLoad(r4, 0U, r4, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, checkSqState.loadSqVirtualAddr);
    ConstructLoad(r4, funcCallPara.sqStateOffset, r4, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, checkSqState.loadSqState);
    ConstructOpImmAndi(r4, r4, 0xFU, RT_STARS_COND_ISA_OP_IMM_FUNC3_ANDI, checkSqState.andiSqState);

    constexpr uint32_t cycle = 1100U;
    const uint64_t retryInstr = funcCallPara.checkSqFsmInstrDistance / sizeof(uint32_t) + funcCallPara.deltaOffset;
    ConstructSetJumpPcFc(r1, retryInstr, checkSqState.jumpRetry);
    ConstructLoop(r4, cycle, static_cast<uint8_t>(retryInstr), checkSqState.retryLoop);

    const uint64_t errorInstr = funcCallPara.errInstrDistance / sizeof(uint32_t) + funcCallPara.deltaOffset;
    ConstructSetJumpPcFc(r1, errorInstr, checkSqState.jumpError);
    ConstructBranch(
        r4, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, static_cast<uint8_t>(errorInstr), checkSqState.branchError);

    const uint32_t* const cmd = RtPtrToPtr<const uint32_t*>(&checkSqState);
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 1) {
        for (size_t i = 0UL; i < (sizeof(checkSqState) / sizeof(uint32_t)); i++) {
            RT_LOG(RT_LOG_DEBUG, "model execute checkSqState, instr[%zu]=0x%08x", i, cmd[i]);
        }
    }
}

static void ConstrucModelExeFuncCallArch9201(
    rtStarsModelExeFuncCallPara_t& funcCallPara, RtStarsModelExeFuncCallArch9201& funcCall)
{
    ConstrucModelExeScanSq(funcCallPara, funcCall.scanSq);
    ConstrucModelExeCheckSqStateArch9201(funcCallPara, funcCall.checkSqState);
    ConstrucModelExeCheckSqDisable(funcCallPara, funcCall.checkSqDisable);
    ConstrucModelExeCheckSqHeadTail(funcCallPara, funcCall.checkSqHeadTail);
    ConstrucModelExeDeactiveSq(funcCall.deactiveSq);
    ConstrucModelExeActiveHeadSq(funcCallPara, funcCall.activeHeadSq);
    ConstrucModelExeCheckSqDisableErrInstr(funcCallPara, funcCall.checkSqDisableErrInstr);
    ConstrucModelExeCheckSqHeadTailErrInstr(funcCallPara, funcCall.checkSqHeadTailErrInstr);
    ConstrucModelExeErrInstr(funcCall.errInstr);
    ConstrucModelExeEndInstrr(funcCall.endInstr);
}

static void ConstructGetSqStateArch9201(const rtStarsStreamActiveFcPara_t& fcPara, RtStarsStreamActiveFcArch9201& fc)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;

    ConstructOpOp(r1, r0, r1, RT_STARS_COND_ISA_OP_FUNC3_AND, RT_STARS_COND_ISA_OP_FUNC7_AND, fc.getSqFsmState.and1);
    ConstructLoadImm(r1, fcPara.rtSqFsmStateAddr, RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LWU, fc.getSqFsmState.loadState);
    ConstructSetCqeStatus(r1, r0, fc.dfxFsm);
    ConstructLLWI(r3, fcPara.dfxAddr, fc.llwiDfx0);
    ConstructLHWI(r3, fcPara.dfxAddr, fc.lhwiDfx0);
    ConstructStore(r3, r1, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.stdDfx0);
    ConstructOpImmAndi(r1, r1, 0xFU, RT_STARS_COND_ISA_OP_IMM_FUNC3_ANDI, fc.andiState);
}

static void ConstructStreamActiveFcArch9201(
    RtStarsStreamActiveFcArch9201& fc, const rtStarsStreamActiveFcPara_t& fcPara, const uint32_t offsetStart)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;

    ConstructGetSqStateArch9201(fcPara, fc);

    uint64_t offset = (offsetof(RtStarsStreamActiveFcArch9201, err) + offsetStart) / sizeof(uint32_t);
    ConstructOpImmAndi(r1, r5, 0x9U, RT_STARS_COND_ISA_OP_IMM_FUNC3_XORI, fc.xoriState9);
    /* if fsm is 9 go to error */
    ConstructSetJumpPcFc(r4, offset, fc.jumpErr);
    ConstructBranch(r5, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.branchErr);

    offset = (offsetof(RtStarsStreamActiveFcArch9201, getSqFsmState) + offsetStart) / sizeof(uint32_t);
    ConstructSetJumpPcFc(r4, offset, fc.jumpRetry);
    constexpr uint16_t cycle = 10000U;
    /* else fsm is not 0 go to back */
    ConstructLoop(r1, cycle, static_cast<uint8_t>(offset), fc.retryLoop);
    /* get rtsq enable value */
    ConstructGetSqEnableFcI(r1, fcPara.rtSqEnableAddr, fc.getSqEnable);
    offset = (offsetof(RtStarsStreamActiveFcArch9201, gotoHead) + offsetStart) / sizeof(uint32_t);
    ConstructSetJumpPcFc(r4, offset, fc.jumpResetHead);
    // Load dfx ptr and store enable flag
    ConstructLLWI(r3, fcPara.dfxAddr, fc.llwiDfx1);
    ConstructLHWI(r3, fcPara.dfxAddr, fc.lhwiDfx1);
    ConstructStore(r3, r1, 0x8U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.stdDfx1);
    /* if rtsq is disable, go to reset rtsq head */
    ConstructBranch(r1, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.branchResetHead);
    /* get rtsq head and tail */
    ConstructGetSqHeadAndTailFcI(r1, r2, fcPara.rtSqTailAddr, fcPara.rtSqHeadAddr, fc.getSqHeadAndTail);
    offset = (offsetof(RtStarsStreamActiveFcArch9201, err) + offsetStart) / sizeof(uint32_t);
    ConstructSetJumpPcFc(r4, offset, fc.jumpHeadTailErr);
    // Load dfx ptr and store enable flag
    ConstructLLWI(r3, fcPara.dfxAddr, fc.llwiDfx2);
    ConstructLHWI(r3, fcPara.dfxAddr, fc.lhwiDfx2);
    ConstructStore(r3, r1, 0x10U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.stdDfx2Head);
    ConstructStore(r3, r2, 0x18U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.stdDfx2Tail);
    /* if the head and tail are not equal, go to error */
    ConstructBranch(r1, r2, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, static_cast<uint8_t>(offset), fc.branchHeadTailErr);
    /* disable stream */
    ConstructDisableStreamFcI(r1, fcPara.rtSqEnableAddr, fc.disableSq);
    /* reset rtsq head */
    ConstructGotoI(r0, static_cast<uint16_t>(fcPara.sqId), 0U, fc.gotoHead);
    /* add stream active times */
    ConstructAddStreamActiveTimesFcI(r1, r2, fcPara.streamExecTimesAddr, fc.addStreamActiveTimes);
    /* active stream */
    ConstructActiveI(r0, static_cast<uint16_t>(fcPara.sqId), fc.activeSq);
    offset = (offsetof(RtStarsStreamActiveFcArch9201, end) + offsetStart) / sizeof(uint32_t);
    ConstructSetJumpPcFc(r4, offset, fc.jumpEnd);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.branchEnd);
    ConstructErrorInstr(fc.err);
    ConstructNop(fc.end);
}

static void ConstructStreamSwitchFcArch9201(
    rtStarsStreamSwitchFcArch9201_t& fc, const rtStarsStreamSwitchFcPara_t& fcPara)
{
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;

    rtStarsCondIsaBranchFunc3_t func3 = RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ;
    bool reverseRegisters = false;
    ConvertConditionToBranchFunc3(fcPara.condition, func3, reverseRegisters);
    ConstructLoadImm(r1, fcPara.varPtr, RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LD, fc.loadVar);
    ConstructLHWI(r2, static_cast<uint64_t>(fcPara.val), fc.lhwiValue);
    ConstructLLWI(r2, static_cast<uint64_t>(fcPara.val), fc.llwiValue);

    uint64_t offset = offsetof(rtStarsStreamSwitchFcArch9201_t, end) / sizeof(uint32_t);
    ConstructSetJumpPcFc(r3, offset, fc.jumpEnd);
    if (reverseRegisters) {
        ConstructBranch(r2, r1, func3, static_cast<uint8_t>(offset), fc.branchEnd);
    } else {
        ConstructBranch(r1, r2, func3, static_cast<uint8_t>(offset), fc.branchEnd);
    }

    rtStarsStreamActiveFcPara_t streamActivePara = {};
    streamActivePara.sqId = fcPara.trueSqId;
    streamActivePara.streamExecTimesAddr = fcPara.streamExecTimesAddr;
    streamActivePara.rtSqFsmStateAddr = fcPara.rtSqFsmStateAddr;
    streamActivePara.rtSqEnableAddr = fcPara.rtSqEnableAddr;
    streamActivePara.rtSqTailAddr = fcPara.rtSqTailAddr;
    streamActivePara.rtSqHeadAddr = fcPara.rtSqHeadAddr;
    streamActivePara.dfxAddr = fcPara.dfxAddr;
    offset = offsetof(rtStarsStreamSwitchFcArch9201_t, streamActiveFc);
    ConstructStreamActiveFcArch9201(fc.streamActiveFc, streamActivePara, static_cast<uint32_t>(offset));
    ConstructDeActiveI(r2, fcPara.currentSqId, fc.deactiveCurrentSq);
    ConstructNop(fc.end);
}

static void ConstructStreamSwitchExFcArch9201(
    rtStarsStreamSwitchExFcArch9201_t& fc, const rtStarsStreamSwitchExFcPara_t& fcPara)
{
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;

    rtStarsCondIsaBranchFunc3_t func3 = RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ;
    bool reverseRegisters = false;
    ConvertConditionToBranchFunc3(fcPara.condition, func3, reverseRegisters);
    const rtStarsCondIsaLoadImmFunc3_t loadFunc = (fcPara.dataType == RT_SWITCH_INT32) ?
                                                      RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LW :
                                                      RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LD;
    ConstructLoadImm(r1, fcPara.varPtr, loadFunc, fc.loadVar);
    ConstructLoadImm(r2, fcPara.valPtr, loadFunc, fc.loadValue);

    uint64_t offset = offsetof(rtStarsStreamSwitchExFcArch9201_t, end) / sizeof(uint32_t);
    ConstructSetJumpPcFc(r3, offset, fc.jumpEnd);
    if (reverseRegisters) {
        ConstructBranch(r2, r1, func3, static_cast<uint8_t>(offset), fc.branchEnd);
    } else {
        ConstructBranch(r1, r2, func3, static_cast<uint8_t>(offset), fc.branchEnd);
    }

    rtStarsStreamActiveFcPara_t streamActivePara = {};
    streamActivePara.sqId = fcPara.trueSqId;
    streamActivePara.streamExecTimesAddr = fcPara.streamExecTimesAddr;
    streamActivePara.rtSqFsmStateAddr = fcPara.rtSqFsmStateAddr;
    streamActivePara.rtSqEnableAddr = fcPara.rtSqEnableAddr;
    streamActivePara.rtSqTailAddr = fcPara.rtSqTailAddr;
    streamActivePara.rtSqHeadAddr = fcPara.rtSqHeadAddr;
    streamActivePara.dfxAddr = fcPara.dfxAddr;
    offset = offsetof(rtStarsStreamSwitchExFcArch9201_t, streamActiveFc);
    ConstructStreamActiveFcArch9201(fc.streamActiveFc, streamActivePara, static_cast<uint32_t>(offset));
    ConstructDeActiveI(r2, fcPara.currentSqId, fc.deactiveCurrentSq);
    ConstructNop(fc.end);
}

static rtError_t InitFuncCallParaForStreamSwitchTaskV1(TaskInfo* taskInfo, rtStarsStreamSwitchFcPara_t& fcPara)
{
    Stream* stm = taskInfo->stream;
    StreamSwitchTaskInfo* streamSwitchTask = &(taskInfo->u.streamswitchTask);
    Stream* trueStream = streamSwitchTask->trueStream;
    uint16_t* const execTimesSvm = trueStream->GetExecutedTimesSvm();
    fcPara.streamExecTimesAddr = RtPtrToValue(execTimesSvm);
    fcPara.currentSqId = static_cast<uint32_t>(stm->GetSqId());
    fcPara.trueSqId = static_cast<uint32_t>(trueStream->GetSqId());
    fcPara.varPtr = streamSwitchTask->ptr;
    fcPara.condition = streamSwitchTask->condition;
    const uint64_t sqVirtualAddr = trueStream->GetSqRegVirtualAddr();
    fcPara.rtSqEnableAddr = STARS_SIMPLE_SQ_ENABLE_OFFSET + sqVirtualAddr;
    fcPara.rtSqTailAddr = DAVID_SIMPLE_SQ_TAIL_OFFSET + sqVirtualAddr;
    fcPara.rtSqHeadAddr = STARS_SIMPLE_SQ_HEAD_OFFSET + sqVirtualAddr;
    fcPara.rtSqFsmStateAddr = DAVID_SIMPLE_SQ_STATE_OFFSET + sqVirtualAddr;
    return RT_ERROR_NONE;
}

static rtError_t InitFuncCallParaForStreamSwitchTaskV2(TaskInfo* taskInfo, rtStarsStreamSwitchExFcPara_t& fcPara)
{
    Stream* stm = taskInfo->stream;
    StreamSwitchTaskInfo* streamSwitchTask = &(taskInfo->u.streamswitchTask);
    Stream* trueStream = streamSwitchTask->trueStream;
    uint16_t* const execTimesSvm = trueStream->GetExecutedTimesSvm();
    fcPara.streamExecTimesAddr = RtPtrToValue(execTimesSvm);
    fcPara.currentSqId = static_cast<uint32_t>(stm->GetSqId());
    fcPara.trueSqId = static_cast<uint32_t>(trueStream->GetSqId());
    fcPara.varPtr = streamSwitchTask->ptr;
    fcPara.condition = streamSwitchTask->condition;
    const uint64_t sqVirtualAddr = trueStream->GetSqRegVirtualAddr();

    fcPara.rtSqEnableAddr = STARS_SIMPLE_SQ_ENABLE_OFFSET + sqVirtualAddr;
    fcPara.rtSqTailAddr = DAVID_SIMPLE_SQ_TAIL_OFFSET + sqVirtualAddr;
    fcPara.rtSqHeadAddr = STARS_SIMPLE_SQ_HEAD_OFFSET + sqVirtualAddr;
    fcPara.rtSqFsmStateAddr = DAVID_SIMPLE_SQ_STATE_OFFSET + sqVirtualAddr;
    return RT_ERROR_NONE;
}

static rtError_t PrepareSqeInfoForStreamSwitchTask(TaskInfo* taskInfo)
{
    rtError_t ret;
    StreamSwitchTaskInfo* const streamSwitchTask = &(taskInfo->u.streamswitchTask);
    if (streamSwitchTask->isCondEx) {
        rtStarsStreamSwitchExFcArch9201_t fc = {};
        rtStarsStreamSwitchExFcPara_t fcPara = {};
        streamSwitchTask->funCallMemSize = sizeof(fc);
        ret = InitFuncCallParaForStreamSwitchTaskV2(taskInfo, fcPara);
        ERROR_RETURN(ret, "Init func call para failed,retCode=%#x.", ret);
        ret = AllocFuncCallMemForStreamSwitchTask(taskInfo);
        ERROR_RETURN(ret, "Alloc func call svm failed,retCode=%#x.", ret);
        fcPara.dataType = streamSwitchTask->dataType;
        fcPara.valPtr = streamSwitchTask->valuePtr;
        fcPara.dfxAddr = RtPtrToValue(streamSwitchTask->dfxPtr);
        ConstructStreamSwitchExFcArch9201(fc, fcPara);
        ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(
            streamSwitchTask->funcCallSvmMem, streamSwitchTask->funCallMemSize, &fc, sizeof(fc),
            RT_MEMCPY_HOST_TO_DEVICE);
    } else {
        rtStarsStreamSwitchFcArch9201_t fc = {};
        rtStarsStreamSwitchFcPara_t fcPara = {};
        streamSwitchTask->funCallMemSize = sizeof(fc);
        ret = InitFuncCallParaForStreamSwitchTaskV1(taskInfo, fcPara);
        ERROR_RETURN(ret, "Init func call para failed,retCode=%#x.", ret);
        ret = AllocFuncCallMemForStreamSwitchTask(taskInfo);
        ERROR_RETURN(ret, "Alloc func call svm failed,retCode=%#x.", ret);
        fcPara.val = static_cast<uint64_t>(streamSwitchTask->value);
        fcPara.dfxAddr = RtPtrToValue(streamSwitchTask->dfxPtr);
        ConstructStreamSwitchFcArch9201(fc, fcPara);
        ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(
            streamSwitchTask->funcCallSvmMem, streamSwitchTask->funCallMemSize, &fc, sizeof(fc),
            RT_MEMCPY_HOST_TO_DEVICE);
    }
    if (ret != RT_ERROR_NONE) {
        (void)FreeFuncCallMemForStreamSwitchTask(taskInfo);
    }
    return ret;
}

static rtError_t InitFuncCallParaForStreamActiveTask(TaskInfo* taskInfo, rtStarsStreamActiveFcPara_t& fcPara)
{
    StreamActiveTaskInfo* streamActiveTask = &(taskInfo->u.streamactiveTask);
    const uint32_t activeStreamSqId = streamActiveTask->activeStreamSqId;
    uint16_t* const execTimesSvm = streamActiveTask->activeStream->GetExecutedTimesSvm();
    fcPara.streamExecTimesAddr = RtPtrToValue<uint16_t*>(execTimesSvm);
    fcPara.sqId = activeStreamSqId;
    fcPara.dfxAddr = RtPtrToValue<void*>(streamActiveTask->dfxPtr);
    RT_LOG(RT_LOG_INFO, "Active streamId=%u,active sqId=%u", streamActiveTask->activeStreamId, activeStreamSqId);
    const uint64_t sqVirtualAddr = streamActiveTask->activeStream->GetSqRegVirtualAddr();
    fcPara.rtSqEnableAddr = STARS_SIMPLE_SQ_ENABLE_OFFSET + sqVirtualAddr;
    fcPara.rtSqTailAddr = DAVID_SIMPLE_SQ_TAIL_OFFSET + sqVirtualAddr;
    fcPara.rtSqHeadAddr = STARS_SIMPLE_SQ_HEAD_OFFSET + sqVirtualAddr;
    fcPara.rtSqFsmStateAddr = DAVID_SIMPLE_SQ_STATE_OFFSET + sqVirtualAddr;
    return RT_ERROR_NONE;
}

static rtError_t PrepareSqeInfoForStreamActiveTask(TaskInfo* taskInfo)
{
    RtStarsStreamActiveFcArch9201 fc = {};
    rtStarsStreamActiveFcPara_t fcPara = {};
    StreamActiveTaskInfo* const streamActiveTask = &(taskInfo->u.streamactiveTask);
    streamActiveTask->funCallMemSize = sizeof(fc);
    rtError_t ret = AllocFuncCallMemForStreamActiveTask(taskInfo);
    ERROR_RETURN(ret, "Alloc func call svm failed,retCode=%#x.", ret);
    if ((streamActiveTask->activeStreamSqId == UINT32_MAX) && streamActiveTask->activeStream->IsSoftwareSqEnable()) {
        CaptureModel* captureMdl = dynamic_cast<CaptureModel*>(streamActiveTask->activeStream->Model_());
        if (captureMdl != nullptr) {
            (void)captureMdl->MarkStreamActiveTask(taskInfo);
        } else {
            RT_LOG(
                RT_LOG_ERROR, "CaptureModel is null, active stream_id=%u, stream_id=%d, task_id=%u.",
                streamActiveTask->activeStreamId, taskInfo->stream->Id_(), taskInfo->id);
            return RT_ERROR_MODEL_NULL;
        }
        return RT_ERROR_NONE;
    }
    ret = InitFuncCallParaForStreamActiveTask(taskInfo, fcPara);
    ERROR_RETURN(ret, "Init func call para failed,retCode=%#x.", ret);
    ConstructStreamActiveFcArch9201(fc, fcPara, 0U);
    return taskInfo->stream->Device_()->Driver_()->MemCopySync(
        streamActiveTask->funcCallSvmMem, streamActiveTask->funCallMemSize, &fc, sizeof(fc), RT_MEMCPY_HOST_TO_DEVICE);
}

static rtError_t ReConstructStreamActiveTaskFc(TaskInfo* taskInfo)
{
    RtStarsStreamActiveFcArch9201 fc = {};
    rtStarsStreamActiveFcPara_t fcPara = {};
    rtError_t ret = InitFuncCallParaForStreamActiveTask(taskInfo, fcPara);
    ERROR_RETURN(ret, "Init func call para failed,retCode=%#x.", ret);
    fcPara.dfxAddr = RtPtrToValue(taskInfo->u.streamactiveTask.dfxPtr);
    ConstructStreamActiveFcArch9201(fc, fcPara, 0U);
    return taskInfo->stream->Device_()->Driver_()->MemCopySync(
        taskInfo->u.streamactiveTask.funcCallSvmMem, taskInfo->u.streamactiveTask.funCallMemSize, &fc, sizeof(fc),
        RT_MEMCPY_HOST_TO_DEVICE);
}

static rtError_t ConstructFuncCallParaForModelExecuteTaskArch9201(
    TaskInfo* const taskInfo, rtStarsModelExeFuncCallPara_t& funcCallPara)
{
    Stream* const stream = taskInfo->stream;
    ModelExecuteTaskInfo* modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    const rtError_t ret = AllocFuncCallMemForModelExecuteTask(taskInfo, funcCallPara);
    ERROR_RETURN(ret, "alloc func call svm failed, retCode=%#x.", ret);
    funcCallPara.sqHeadOffset = STARS_SIMPLE_SQ_HEAD_OFFSET;
    const DevProperties props = taskInfo->stream->Device_()->GetDevProperties();
    funcCallPara.sqTailOffset = props.sqTailOffset;
    funcCallPara.sqVirtualAddr = RtPtrToValue(stream->Device_()->GetSqVirtualArrBaseAddr_());
    funcCallPara.dfxAddr = RtPtrToValue(modelExecuteTaskInfo->model->GetDfxPtr());
    funcCallPara.sqStateOffset = DAVID_SIMPLE_SQ_STATE_OFFSET;
    return RT_ERROR_NONE;
}

static rtError_t PrepareModelExecuteFuncCall(TaskInfo* taskInfo)
{
    RtStarsModelExeFuncCallArch9201 funcCall = {};
    rtStarsModelExeFuncCallPara_t funcCallPara = {};
    funcCallPara.funcCallInstrSize = sizeof(funcCall);
    funcCallPara.checkSqStateInstrSize = sizeof(funcCall.checkSqState);
    funcCallPara.checkSqFsmInstrDistance = RtPtrToValue(&(funcCall.checkSqState.slliSqId)) - RtPtrToValue(&funcCall);
    funcCallPara.endInstrDistance = RtPtrToValue(&(funcCall.endInstr.nop)) - RtPtrToValue(&funcCall);
    funcCallPara.checkSqDisableErrInstrDistance =
        RtPtrToValue(&(funcCall.checkSqDisableErrInstr.lhwi0)) - RtPtrToValue(&funcCall);
    funcCallPara.checkSqHeadTailErrInstrDistance =
        RtPtrToValue(&(funcCall.checkSqHeadTailErrInstr.lhwi0)) - RtPtrToValue(&funcCall);
    funcCallPara.scanSqInstrDistance =
        RtPtrToValue(&(funcCall.scanSq.u.rootModelAdapt.lhwi1)) - RtPtrToValue(&funcCall);
    funcCallPara.errInstrDistance = RtPtrToValue(&(funcCall.errInstr.err)) - RtPtrToValue(&funcCall);
    funcCallPara.deactiveSqGotoRInstrDistance = RtPtrToValue(&(funcCall.deactiveSq.gotoR)) - RtPtrToValue(&funcCall);

    rtError_t ret = ConstructFuncCallParaForModelExecuteTaskArch9201(taskInfo, funcCallPara);
    ERROR_RETURN(ret, "construct func call para failed, retCode=%#x.", ret);
    ConstrucModelExeFuncCallArch9201(funcCallPara, funcCall);

    Model* const model = taskInfo->u.modelExecuteTaskInfo.model;
    ret = memcpy_s(model->GetFuncCallHostMem(), sizeof(funcCall), &funcCall, sizeof(funcCall));
    if (ret != EOK) {
        (void)FreeFuncCallHostMemAndSvmMem(taskInfo);
        RT_LOG(
            RT_LOG_ERROR, "Failed to copy arch9201 model execute funcCall, size=%zu, retCode=%#x.", sizeof(funcCall),
            ret);
        return RT_ERROR_SEC_HANDLE;
    }
    return RT_ERROR_NONE;
}

static bool CondIsaTaskRegister()
{
    static const CondIsaTaskFuncs funcs = {
        &PrepareSqeInfoForStreamSwitchTask,
        &PrepareSqeInfoForStreamActiveTask,
        &ReConstructStreamActiveTaskFc,
        &PrepareModelExecuteFuncCall,
    };
    RegCondIsaTaskFuncs(CHIP_CLOUD_V5, &funcs);
    return true;
}

static bool g_condIsaTaskRegister = CondIsaTaskRegister();
} // namespace

} // namespace runtime
} // namespace cce
