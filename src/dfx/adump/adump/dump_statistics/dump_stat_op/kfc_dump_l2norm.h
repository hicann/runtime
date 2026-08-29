/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __KFC_DUMP_L2NORM_H__
#define __KFC_DUMP_L2NORM_H__

#include "kfc_dump_base.h"

namespace KfcDumpStat {

template <typename T, typename InputT>
__aicore__ inline void ComputeL2NormSingleType(
    TQue<QuePosition::VECOUT, BUFFER_NUM>& workQueue, LocalTensor<InputT>& inputLocal, LocalTensor<uint8_t>& calMidAddr,
    int64_t curLoop, int64_t curProcessCount, int64_t appendNum, int64_t totalCount)
{
    LocalTensor<uint8_t> curNormAddr = calMidAddr[sizeof(float)];
    LocalTensor<InputT> workLocal = workQueue.AllocTensor<InputT>();

    Mul(inputLocal, inputLocal, inputLocal, curProcessCount);
    pipe_barrier(PIPE_ALL);

    ReduceSum<InputT>(workLocal, inputLocal, workLocal, curProcessCount);
    pipe_barrier(PIPE_ALL);

    // 更新最终结果
    LocalTensor<InputT> curNorm = curNormAddr.ReinterpretCast<InputT>();
    if (curLoop == 0) {
        curNorm.SetValue(0, workLocal.GetValue(0));
    } else {
        curNorm.SetValue(0, curNorm.GetValue(0) + workLocal.GetValue(0));
    }

    workQueue.FreeTensor(workLocal);
}

template <typename T>
__aicore__ inline void ComputeL2NormMultiDataType(
    TQue<QuePosition::VECIN, BUFFER_NUM>& xQue, TBuf<TPosition::VECCALC>& castXBuf,
    TQue<QuePosition::VECOUT, BUFFER_NUM>& workQueue, LocalTensor<uint8_t>& calMidAddr, int64_t curLoop,
    int64_t curProcessCount, int64_t appendNum, int64_t totalCount)
{
    LocalTensor<T> x = xQue.DeQue<T>();

    AppendTailPadding<T>(x, curProcessCount, appendNum);

    if constexpr (std::is_same_v<T, float>) {
        ComputeL2NormSingleType<float>(workQueue, x, calMidAddr, curLoop, curProcessCount, appendNum, totalCount);
    } else {
        // 整型/half/bfloat16 及支持的 fp8 类型统一 cast 到 float32 后统计
        LocalTensor<float> float32X = CastXToFloat32<T>(x, castXBuf, curProcessCount);
        AppendTailPaddingFp32(float32X, curProcessCount, appendNum);
        pipe_barrier(PIPE_ALL);
        ComputeL2NormSingleType<float>(
            workQueue, float32X, calMidAddr, curLoop, curProcessCount, appendNum, totalCount);
    }

    xQue.FreeTensor(x);
}

template <typename T>
__aicore__ inline void ProcessL2Norm(
    TQue<QuePosition::VECIN, BUFFER_NUM>& xQue, TBuf<TPosition::VECCALC>& calMiddleBuf,
    TBuf<TPosition::VECCALC>& castXBuf, TQue<QuePosition::VECOUT, BUFFER_NUM>& workQueue, GlobalTensor<T>& xGm,
    int64_t innerLoopTime, int64_t tileLengthMean, int64_t tileLengthEnd, int64_t perBlockCount, int64_t blockOffset,
    int64_t tileNumEnd, int64_t totalCount)
{
    LocalTensor<uint8_t> calMidAddr =
        calMiddleBuf.Get<uint8_t>()[static_cast<int64_t>(StatClass::STAT_L2NORM) * BLOCK_SIZE];
    LocalTensor<uint8_t> curNormAddr = calMidAddr[sizeof(float)];

    for (int64_t curLoopTime = 0; curLoopTime < innerLoopTime; ++curLoopTime) {
        CopyInX(xQue, xGm, blockOffset + curLoopTime * tileLengthMean, tileLengthMean, perBlockCount);
        int64_t appendNum = 0;
        ComputeL2NormMultiDataType<T>(
            xQue, castXBuf, workQueue, calMidAddr, curLoopTime, tileLengthMean, appendNum, totalCount);
    }

    if (tileNumEnd) {
        CopyInX(xQue, xGm, blockOffset + innerLoopTime * tileLengthMean, tileLengthEnd, perBlockCount);
        auto appendNum = CeilAlign(tileLengthEnd, perBlockCount) - tileLengthEnd;
        ComputeL2NormMultiDataType<T>(
            xQue, castXBuf, workQueue, calMidAddr, innerLoopTime, tileLengthEnd + appendNum, appendNum, totalCount);
    }

    WriteStatOutput<float>(calMidAddr, curNormAddr);
}

} // namespace KfcDumpStat

#endif // __KFC_DUMP_L2NORM_H__
