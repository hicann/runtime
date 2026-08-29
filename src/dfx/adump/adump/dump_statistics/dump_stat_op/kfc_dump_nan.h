/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __KFC_DUMP_NAN_H__
#define __KFC_DUMP_NAN_H__

#include "kfc_dump_base.h"

namespace KfcDumpStat {

template <typename T, typename InputT>
__aicore__ inline void ComputeNanSingleType(
    TQue<QuePosition::VECOUT, BUFFER_NUM>& workQueue, TBuf<TPosition::VECCALC>& maskBuf,
    TBuf<TPosition::VECCALC>& cacheBuf1, LocalTensor<InputT>& inputLocal, LocalTensor<uint8_t>& calMidAddr,
    int64_t curLoop, int64_t curProcessCount)
{
    LocalTensor<uint8_t> curNanAddr = calMidAddr[sizeof(float)]; // 四个字节偏移作为当前最大值存放的地址
    LocalTensor<InputT> workLocal = workQueue.AllocTensor<InputT>();
    LocalTensor<uint8_t> compareResult = maskBuf.Get<uint8_t>();

    // 单核模板字节数不超过 8192 字节。Nan Inf 统计的数据类型字节数最少 2 字节。
    // 因此最多处理 4096 个元素，最多需要 512 个 uint8，即 16 个 BLOCK_SIZE
    Compare(compareResult, inputLocal, inputLocal, CMPMODE::EQ, curProcessCount);

    InputT inputVal(0);
    Duplicate<InputT>(workLocal, inputVal, curProcessCount);
    LocalTensor<InputT> selectOnesResult = cacheBuf1.Get<InputT>();
    pipe_barrier(PIPE_ALL);

    Select(
        selectOnesResult, compareResult, workLocal, static_cast<InputT>(1), SELMODE::VSEL_TENSOR_SCALAR_MODE,
        curProcessCount);
    pipe_barrier(PIPE_ALL);

    ReduceSum<InputT>(selectOnesResult, selectOnesResult, selectOnesResult, curProcessCount);
    pipe_barrier(PIPE_ALL);

    // 更新最终结果
    LocalTensor<int32_t> curNan = curNanAddr.ReinterpretCast<int32_t>();
    if (curLoop == 0) {
        curNan.SetValue(0, static_cast<int32_t>(selectOnesResult.GetValue(0)));
    } else {
        curNan.SetValue(0, curNan.GetValue(0) + static_cast<int32_t>(selectOnesResult.GetValue(0)));
    }
    pipe_barrier(PIPE_ALL);

    workQueue.FreeTensor(workLocal);
}

// nan 统计计算回调：供 ComputeFloatStatSkeleton 在 cast 完成后调用
template <typename T>
struct NanComputeFunc {
    __aicore__ inline void operator()(
        TQue<QuePosition::VECOUT, BUFFER_NUM>& workQue, TBuf<TPosition::VECCALC>& mask,
        TBuf<TPosition::VECCALC>& cache1, LocalTensor<float>& inputLocal, LocalTensor<uint8_t>& midAddr, int64_t loop,
        int64_t processCount) const
    {
        ComputeNanSingleType<T, float>(workQue, mask, cache1, inputLocal, midAddr, loop, processCount);
    }
};

template <typename T>
__aicore__ inline void ComputeNanMultiDataType(
    TQue<QuePosition::VECIN, BUFFER_NUM>& xQue, TBuf<TPosition::VECCALC>& castXBuf,
    TQue<QuePosition::VECOUT, BUFFER_NUM>& workQueue, TBuf<TPosition::VECCALC>& maskBuf,
    TBuf<TPosition::VECCALC>& cacheBuf1, LocalTensor<uint8_t>& calMidAddr, int64_t curLoop, int64_t curProcessCount,
    int64_t appendNum)
{
    ComputeFloatStatSkeleton<T>(
        xQue, castXBuf, workQueue, maskBuf, cacheBuf1, calMidAddr, curLoop, curProcessCount, appendNum,
        NanComputeFunc<T>());
}

template <typename T>
__aicore__ inline void ProcessNan(
    TQue<QuePosition::VECIN, BUFFER_NUM>& xQue, TBuf<TPosition::VECCALC>& calMiddleBuf,
    TBuf<TPosition::VECCALC>& castXBuf, TQue<QuePosition::VECOUT, BUFFER_NUM>& workQueue, GlobalTensor<T>& xGm,
    TBuf<TPosition::VECCALC>& maskBuf, TBuf<TPosition::VECCALC>& cacheBuf1, int64_t innerLoopTime,
    int64_t tileLengthMean, int64_t tileLengthEnd, int64_t perBlockCount, int64_t blockOffset, int64_t tileNumEnd,
    uint64_t xDtypeSize)
{
    // 获取计算结果保存的地址
    LocalTensor<uint8_t> calMidAddr =
        calMiddleBuf.Get<uint8_t>()[static_cast<int64_t>(StatClass::STAT_NAN) * BLOCK_SIZE];
    LocalTensor<uint8_t> curNanAddr = calMidAddr[sizeof(float)];

    for (int64_t curLoopTime = 0; curLoopTime < innerLoopTime; ++curLoopTime) {
        CopyInX(xQue, xGm, blockOffset + curLoopTime * tileLengthMean, tileLengthMean, perBlockCount);
        int64_t appendNum = 0;
        ComputeNanMultiDataType<T>(
            xQue, castXBuf, workQueue, maskBuf, cacheBuf1, calMidAddr, curLoopTime, tileLengthMean, appendNum);
    }

    if (tileNumEnd) {
        CopyInX(xQue, xGm, blockOffset + innerLoopTime * tileLengthMean, tileLengthEnd, perBlockCount);
        auto appendNum = CeilAlign(tileLengthEnd * xDtypeSize, COMMAND_SIZE) / xDtypeSize - tileLengthEnd;
        ComputeNanMultiDataType<T>(
            xQue, castXBuf, workQueue, maskBuf, cacheBuf1, calMidAddr, innerLoopTime, tileLengthEnd + appendNum,
            appendNum);
    }

    WriteStatOutput<int32_t>(calMidAddr, curNanAddr);
}

} // namespace KfcDumpStat

#endif // __KFC_DUMP_NAN_H__
