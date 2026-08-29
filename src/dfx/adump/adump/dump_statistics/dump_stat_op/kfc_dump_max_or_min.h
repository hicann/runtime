/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __KFC_DUMP_MAX_OR_MIN_H__
#define __KFC_DUMP_MAX_OR_MIN_H__

#include "kfc_dump_base.h"

namespace KfcDumpStat {

// max/min 统计共用模板，isStatMax 为编译期常量，由编译器完成分支裁剪
template <typename InputT, bool isStatMax>
__aicore__ inline void ComputeMaxOrMinSingleType(
    TQue<QuePosition::VECOUT, BUFFER_NUM>& workQueue, LocalTensor<InputT>& inputLocal, LocalTensor<uint8_t>& calMidAddr,
    int64_t curLoop, int64_t curProcessCount)
{
    LocalTensor<uint8_t> curMaxOrMinAddr = calMidAddr[sizeof(float)];
    LocalTensor<InputT> workLocal = workQueue.AllocTensor<InputT>();
    LocalTensor<InputT> calMiddleResult = calMidAddr.ReinterpretCast<InputT>();

    if constexpr (isStatMax) {
        ReduceMax<InputT>(calMiddleResult, inputLocal, workLocal, curProcessCount, false);
    } else {
        ReduceMin<InputT>(calMiddleResult, inputLocal, workLocal, curProcessCount, false);
    }
    pipe_barrier(PIPE_ALL);

    // 更新最终结果
    LocalTensor<InputT> curMaxOrMin = curMaxOrMinAddr.ReinterpretCast<InputT>();
    bool needUpdate = curLoop == 0;
    if (!needUpdate) {
        if constexpr (isStatMax) {
            needUpdate = static_cast<float>(calMiddleResult.GetValue(0)) > static_cast<float>(curMaxOrMin.GetValue(0));
        } else {
            needUpdate = static_cast<float>(calMiddleResult.GetValue(0)) < static_cast<float>(curMaxOrMin.GetValue(0));
        }
    }
    if (needUpdate) {
        curMaxOrMin.SetValue(0, calMiddleResult.GetValue(0));
    }
    pipe_barrier(PIPE_ALL);

    workQueue.FreeTensor(workLocal);
}

// int32 走 Max/Min 向量指令，不复用 ReduceMax/ReduceMin 路径
template <bool isStatMax>
__aicore__ inline void ComputeInt32MaxOrMin(
    LocalTensor<int32_t>& int32X, LocalTensor<int32_t>& x, int64_t curLoop, int64_t curProcessCount,
    int64_t tileLengthMean)
{
    if (curLoop == 0) {
        int32_t inputVal = x.GetValue(0);
        Duplicate<int32_t>(int32X, inputVal, tileLengthMean);
        pipe_barrier(PIPE_ALL);
    }

    if constexpr (isStatMax) {
        Max(int32X, x, int32X, curProcessCount);
    } else {
        Min(int32X, x, int32X, curProcessCount);
    }
}

template <typename T, bool isStatMax>
__aicore__ inline bool ComputeMaxOrMinMultiDataType(
    TQue<QuePosition::VECIN, BUFFER_NUM>& xQue, TBuf<TPosition::VECCALC>& castXBuf,
    TQue<QuePosition::VECOUT, BUFFER_NUM>& workQueue, LocalTensor<uint8_t>& calMidAddr, int64_t curLoop,
    int64_t curProcessCount, int64_t appendNum, int64_t tileLengthMean)
{
    LocalTensor<T> x = xQue.DeQue<T>();

    // 32B 对齐，max/min 尾块以首元素填充（不改变最值）；fp8 类型延后到 cast 完成后填充
    if (appendNum > 0) {
        if constexpr (!IsFp8Type<T>::value) {
            T appendValue = x.GetValue(0);
            for (int64_t i = curProcessCount - appendNum; i < curProcessCount; ++i) {
                x.SetValue(i, appendValue);
            }
        }
        pipe_barrier(PIPE_ALL);
    }

    bool isProcessFloat32 = true;
    if constexpr (std::is_same_v<T, uint8_t> || std::is_same_v<T, int8_t>) {
        // b8 转 half 后统计
        LocalTensor<half> float16X = castXBuf.Get<half>();
        Cast(float16X, x, RoundMode::CAST_NONE, curProcessCount);
        pipe_barrier(PIPE_ALL);
        ComputeMaxOrMinSingleType<half, isStatMax>(workQueue, float16X, calMidAddr, curLoop, curProcessCount);
        isProcessFloat32 = false;
    } else if constexpr (std::is_same_v<T, int32_t>) {
        LocalTensor<int32_t> int32X = castXBuf.Get<int32_t>();
        ComputeInt32MaxOrMin<isStatMax>(int32X, x, curLoop, curProcessCount, tileLengthMean);
        isProcessFloat32 = false;
    } else if constexpr (std::is_same_v<T, half>) {
        ComputeMaxOrMinSingleType<half, isStatMax>(workQueue, x, calMidAddr, curLoop, curProcessCount);
        isProcessFloat32 = false;
    } else {
        // int16/bfloat16 及支持的 fp8 类型统一 cast 到 float32 后统计
        LocalTensor<float> float32X = CastXToFloat32<T>(x, castXBuf, curProcessCount);
        // int16/bfloat16 在 cast 前已按首元素填充（首元素已随 cast 携带），仅 fp8 需在 cast 后补填；
        // 同样以首元素填充保证不改变最值，否则全负数据的 max / 全正数据的 min 会被错误统计为 0
        if constexpr (IsFp8Type<T>::value) {
            AppendTailPaddingFp32(float32X, curProcessCount, appendNum, float32X.GetValue(0));
        }
        pipe_barrier(PIPE_ALL);
        ComputeMaxOrMinSingleType<float, isStatMax>(workQueue, float32X, calMidAddr, curLoop, curProcessCount);
    }

    xQue.FreeTensor(x);
    return isProcessFloat32;
}

// 将 curMaxOrMinValueAddr 中的最值搬到 calMidAddr 首地址，不同输入类型的目标读取类型不同
template <typename T, bool isStatMax>
__aicore__ inline void WriteMaxOrMinOutput(
    LocalTensor<uint8_t>& calMidAddr, LocalTensor<uint8_t>& curMaxOrMinValueAddr, TBuf<TPosition::VECCALC>& castXBuf,
    bool isProcessFloat32, int64_t tileLengthMean)
{
    if constexpr (std::is_same_v<T, uint8_t> || std::is_same_v<T, int8_t>) {
        LocalTensor<half> tmpValue = curMaxOrMinValueAddr.ReinterpretCast<half>();
        int32_t outputValue = static_cast<int32_t>(tmpValue.GetValue(0));
        LocalTensor<int32_t> localOutput = calMidAddr.ReinterpretCast<int32_t>();
        localOutput.SetValue(0, outputValue);
    } else if constexpr (std::is_same_v<T, int16_t>) {
        LocalTensor<float> tmpValue = curMaxOrMinValueAddr.ReinterpretCast<float>();
        int32_t outputValue = static_cast<int32_t>(tmpValue.GetValue(0));
        LocalTensor<int32_t> localOutput = calMidAddr.ReinterpretCast<int32_t>();
        localOutput.SetValue(0, outputValue);
    } else if constexpr (std::is_same_v<T, int32_t>) {
        // int32 结果保留在 castXBuf 中，按标量逐个收尾取最值
        LocalTensor<int32_t> int32X = castXBuf.Get<int32_t>();
        int32_t outputValue = int32X.GetValue(0);
        for (int32_t i = 1; i < tileLengthMean; ++i) {
            int32_t curValue = int32X.GetValue(i);
            if (isStatMax && outputValue < curValue) {
                outputValue = curValue;
            } else if (!isStatMax && outputValue > curValue) {
                outputValue = curValue;
            }
        }
        LocalTensor<int32_t> localOutput = calMidAddr.ReinterpretCast<int32_t>();
        localOutput.SetValue(0, outputValue);
    } else if constexpr (std::is_same_v<T, half>) {
        if (isProcessFloat32) {
            LocalTensor<float> tmpValue = curMaxOrMinValueAddr.ReinterpretCast<float>();
            float outputValue = tmpValue.GetValue(0);
            LocalTensor<float> localOutput = calMidAddr.ReinterpretCast<float>();
            localOutput.SetValue(0, outputValue);
        } else {
            LocalTensor<half> tmpValue = curMaxOrMinValueAddr.ReinterpretCast<half>();
            float outputValue = static_cast<float>(tmpValue.GetValue(0));
            LocalTensor<float> localOutput = calMidAddr.ReinterpretCast<float>();
            localOutput.SetValue(0, outputValue);
        }
    } else {
        // float/bfloat16 及支持的 fp8 类型：结果以 float32 存放
        LocalTensor<float> tmpValue = curMaxOrMinValueAddr.ReinterpretCast<float>();
        auto outputValue = tmpValue.GetValue(0);
        LocalTensor<float> localOutput = calMidAddr.ReinterpretCast<float>();
        localOutput.SetValue(0, outputValue);
    }
}

template <typename T, bool isStatMax>
__aicore__ inline void ProcessMaxOrMin(
    TQue<QuePosition::VECIN, BUFFER_NUM>& xQue, TBuf<TPosition::VECCALC>& calMiddleBuf,
    TBuf<TPosition::VECCALC>& castXBuf, TQue<QuePosition::VECOUT, BUFFER_NUM>& workQueue, GlobalTensor<T>& xGm,
    int64_t innerLoopTime, int64_t tileLengthMean, int64_t tileLengthEnd, int64_t perBlockCount, int64_t blockOffset,
    int64_t tileNumEnd)
{
    StatClass statClass = isStatMax ? StatClass::STAT_MAX : StatClass::STAT_MIN;
    LocalTensor<uint8_t> calMidAddr = calMiddleBuf.Get<uint8_t>()[static_cast<int64_t>(statClass) * BLOCK_SIZE];
    LocalTensor<uint8_t> curMaxOrMinValueAddr = calMidAddr[sizeof(float)];
    bool isProcessFloat32 = true;

    for (int64_t curLoopTime = 0; curLoopTime < innerLoopTime; ++curLoopTime) {
        CopyInX(
            xQue, xGm, blockOffset + curLoopTime * tileLengthMean, tileLengthMean,
            perBlockCount); // tileLengthMean 满足 32B 对齐
        int64_t appendNum = 0;
        isProcessFloat32 = ComputeMaxOrMinMultiDataType<T, isStatMax>(
            xQue, castXBuf, workQueue, calMidAddr, curLoopTime, tileLengthMean, appendNum, tileLengthMean);
    }

    if (tileNumEnd) {
        CopyInX(xQue, xGm, blockOffset + innerLoopTime * tileLengthMean, tileLengthEnd, perBlockCount); // 处理尾块
        auto appendNum = CeilAlign(tileLengthEnd, perBlockCount) - tileLengthEnd;
        isProcessFloat32 = ComputeMaxOrMinMultiDataType<T, isStatMax>(
            xQue, castXBuf, workQueue, calMidAddr, innerLoopTime, tileLengthEnd + appendNum, appendNum, tileLengthMean);
    }

    WriteMaxOrMinOutput<T, isStatMax>(calMidAddr, curMaxOrMinValueAddr, castXBuf, isProcessFloat32, tileLengthMean);
    pipe_barrier(PIPE_ALL);
}

} // namespace KfcDumpStat

#endif // __KFC_DUMP_MAX_OR_MIN_H__
