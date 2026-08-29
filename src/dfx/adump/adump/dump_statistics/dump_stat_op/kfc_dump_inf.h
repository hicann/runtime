/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __KFC_DUMP_INF_H__
#define __KFC_DUMP_INF_H__

#include "kfc_dump_base.h"

namespace KfcDumpStat {

template <typename T, bool isStatPosInf>
__aicore__ inline void ComputeInfSingleType(
    TQue<QuePosition::VECOUT, BUFFER_NUM>& workQueue, TBuf<TPosition::VECCALC>& maskBuf,
    TBuf<TPosition::VECCALC>& cacheBuf1, LocalTensor<float>& procesLocal, LocalTensor<uint8_t>& calMidAddr,
    int64_t curLoop, int64_t curProcessCount)
{
    LocalTensor<uint8_t> curInfAddr = calMidAddr[sizeof(float)]; // 四个字节偏移作为当前最大值存放的地址
    LocalTensor<uint8_t> compareResult = maskBuf.Get<uint8_t>();
    LocalTensor<uint8_t> workLocal = workQueue.AllocTensor<uint8_t>();
    LocalTensor<int16_t> cacheTensor = cacheBuf1.Get<int16_t>();

    Compare(compareResult, procesLocal, procesLocal, CMPMODE::EQ, curProcessCount);

    float inputVal(0);
    LocalTensor<float> cacluateLocal = workLocal.ReinterpretCast<float>();
    LocalTensor<float> selectLocal = cacheTensor.ReinterpretCast<float>();
    Duplicate<float>(cacluateLocal, inputVal, curProcessCount);
    PipeBarrier<PIPE_ALL>();

    Select(
        selectLocal, compareResult, cacluateLocal, static_cast<float>(1), SELMODE::VSEL_TENSOR_SCALAR_MODE,
        curProcessCount);
    PipeBarrier<PIPE_ALL>();

    ReduceSum<float>(selectLocal, selectLocal, selectLocal, curProcessCount);
    PipeBarrier<PIPE_ALL>();

    int32_t nanNum = static_cast<int32_t>(selectLocal.GetValue(0));
    if (isStatPosInf) {
        CompareScalar(compareResult, procesLocal, FP_INF, CMPMODE::LT, curProcessCount);
    } else {
        CompareScalar(compareResult, procesLocal, -FP_INF, CMPMODE::GT, curProcessCount);
    }
    Duplicate<float>(cacluateLocal, inputVal, curProcessCount);
    PipeBarrier<PIPE_ALL>();

    Select(
        selectLocal, compareResult, cacluateLocal, static_cast<float>(1), SELMODE::VSEL_TENSOR_SCALAR_MODE,
        curProcessCount);
    PipeBarrier<PIPE_ALL>();

    ReduceSum<float>(selectLocal, selectLocal, selectLocal, curProcessCount);
    PipeBarrier<PIPE_ALL>();

    int32_t infNum = static_cast<int32_t>(selectLocal.GetValue(0) - nanNum);

    // 更新最终结果
    LocalTensor<int32_t> curInf = curInfAddr.ReinterpretCast<int32_t>();
    if (curLoop == 0) {
        curInf.SetValue(0, infNum);
    } else {
        curInf.SetValue(0, curInf.GetValue(0) + infNum);
    }
    PipeBarrier<PIPE_ALL>();

    workQueue.FreeTensor(workLocal);
}

// inf 统计计算回调：供 ComputeFloatStatSkeleton 在 cast 完成后调用
template <typename T, bool isStatPosInf>
struct InfComputeFunc {
    __aicore__ inline void operator()(
        TQue<QuePosition::VECOUT, BUFFER_NUM>& workQue, TBuf<TPosition::VECCALC>& mask,
        TBuf<TPosition::VECCALC>& cache1, LocalTensor<float>& inputLocal, LocalTensor<uint8_t>& midAddr, int64_t loop,
        int64_t processCount) const
    {
        ComputeInfSingleType<T, isStatPosInf>(workQue, mask, cache1, inputLocal, midAddr, loop, processCount);
    }
};

template <typename T, bool isStatPosInf>
__aicore__ inline void ComputeInfMultiDataType(
    TQue<QuePosition::VECIN, BUFFER_NUM>& xQue, TBuf<TPosition::VECCALC>& castXBuf,
    TQue<QuePosition::VECOUT, BUFFER_NUM>& workQueue, TBuf<TPosition::VECCALC>& maskBuf,
    TBuf<TPosition::VECCALC>& cacheBuf1, LocalTensor<uint8_t>& calMidAddr, int64_t curLoop, int64_t curProcessCount,
    int64_t appendNum)
{
    ComputeFloatStatSkeleton<T>(
        xQue, castXBuf, workQueue, maskBuf, cacheBuf1, calMidAddr, curLoop, curProcessCount, appendNum,
        InfComputeFunc<T, isStatPosInf>());
}

template <typename T, bool isStatPosInf>
__aicore__ inline void ProcessInf(
    TQue<QuePosition::VECIN, BUFFER_NUM>& xQue, TBuf<TPosition::VECCALC>& calMiddleBuf,
    TBuf<TPosition::VECCALC>& castXBuf, TQue<QuePosition::VECOUT, BUFFER_NUM>& workQueue, GlobalTensor<T>& xGm,
    TBuf<TPosition::VECCALC>& maskBuf, TBuf<TPosition::VECCALC>& cacheBuf1, int64_t innerLoopTime,
    int64_t tileLengthMean, int64_t tileLengthEnd, int64_t perBlockCount, int64_t blockOffset, int64_t tileNumEnd,
    uint64_t xDtypeSize)
{
    StatClass statClass = isStatPosInf ? StatClass::STAT_POS_INF : StatClass::STAT_NEG_INF;
    LocalTensor<uint8_t> calMidAddr = calMiddleBuf.Get<uint8_t>()[static_cast<int64_t>(statClass) * BLOCK_SIZE];
    LocalTensor<uint8_t> curInfAddr = calMidAddr[sizeof(float)];

    for (int64_t curLoopTime = 0; curLoopTime < innerLoopTime; ++curLoopTime) {
        CopyInX(xQue, xGm, blockOffset + curLoopTime * tileLengthMean, tileLengthMean, perBlockCount);
        int64_t appendNum = 0;
        ComputeInfMultiDataType<T, isStatPosInf>(
            xQue, castXBuf, workQueue, maskBuf, cacheBuf1, calMidAddr, curLoopTime, tileLengthMean, appendNum);
    }

    if (tileNumEnd) {
        CopyInX(xQue, xGm, blockOffset + innerLoopTime * tileLengthMean, tileLengthEnd, perBlockCount);
        auto appendNum = CeilAlign(tileLengthEnd * xDtypeSize, COMMAND_SIZE) / xDtypeSize - tileLengthEnd;
        ComputeInfMultiDataType<T, isStatPosInf>(
            xQue, castXBuf, workQueue, maskBuf, cacheBuf1, calMidAddr, innerLoopTime, tileLengthEnd + appendNum,
            appendNum);
    }

    WriteStatOutput<int32_t>(calMidAddr, curInfAddr);
}

} // namespace KfcDumpStat

#endif // __KFC_DUMP_INF_H__
