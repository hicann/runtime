/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __KFC_DUMP_BASE_H__
#define __KFC_DUMP_BASE_H__

#include <type_traits>
#include "kernel_operator.h"
#include "kfc_dump_param.h"

// 是否支持 fp8 数据类型（hifloat8/fp8_e5m2/fp8_e4m3fn）
// 当前仅 David 系列支持，但语义上与架构指令差异独立
// KFC_DUMP_ARCH_DAVID 定义见 kfc_dump_param.h
#define KFC_DUMP_SUPPORT_FP8 KFC_DUMP_ARCH_DAVID

namespace KfcDumpStat {
using namespace AscendC;

constexpr float FP_INF = 3.4e40;                   // INF 标量
constexpr int64_t BUFFER_NUM = 2;                  // 使能 DOUBLE BUFFER
constexpr int64_t MAX_STAT_NUM = 64;               // 最大支持的统计项个数
constexpr int64_t MAX_OUTPUT_BYTE_SIZE = 8;        // 单个统计项结果所占的字节数
constexpr int64_t MAX_WORKSPACE_BYTE_SIZE = 32;    // 申请的 workspace 32B 字节对齐
constexpr int64_t MULTI_CORE_BYTES_NUM = 8 * 1024; // 单核模板多核模板分界字节数
constexpr int64_t BLOCK_SIZE = 32;                 // DataCopy 最小搬运单元 32B
constexpr int64_t COMMAND_SIZE = 256;              // Compare 命令需要 256B 对齐
#if KFC_DUMP_SUPPORT_FP8
constexpr int64_t MAX_MASK_NUM = 32; // 单核模板中，mask 需要最大的 UB 数量, david为处理fp8需扩大
#else
constexpr int64_t MAX_MASK_NUM = 16;        // 单核模板中，mask 需要最大的 UB 数量
#endif

constexpr int64_t DTYPE_BYTE_SIZE_b8 = 1;  // b8 字节数
constexpr int64_t DTYPE_BYTE_SIZE_b16 = 2; // b16 字节数
constexpr int64_t DTYPE_BYTE_SIZE_b32 = 4; // b32 字节数

#if KFC_DUMP_ARCH_DAVID
constexpr int64_t UB_BUF_CNT_b8 = 15;       // 1 origin value, 2 + 4 cast value, 4 worklocal, 4 cache
constexpr int64_t UB_BUF_CNT_b8_MULTI = 16; // 1 origin value, 2 + 4 cast value, 4 worklocal, 4 cache, 1 mask
#else
constexpr int64_t UB_BUF_CNT_b8 = 11;       // 1 origin value, 2 + 4 cast value, 4 worklocal
constexpr int64_t UB_BUF_CNT_b8_MULTI = 12; // 1 origin value, 2 + 4 cast value, 4 worklocal, 1 mask
#endif
constexpr int64_t UB_BUF_CNT_b16 = 8;       // 1 origin value, 1 + 2 cast value, 2 worklocal, 2 cache
constexpr int64_t UB_BUF_CNT_b32 = 5;       // 1 origin value, 1 cast value, 1 worklocal, 2 cache
constexpr int64_t UB_BUF_CNT_b16_MULTI = 9; // 1 origin value, 1 + 2 cast value, 2 worklocal, 2 cache, 1 mask
constexpr int64_t UB_BUF_CNT_b32_MULTI = 5; // 1 origin value, 1 cast value, 1 worklocal, 1 cache tensor, 1 mask

__aicore__ inline int64_t CalculateMaxProcCount(int64_t xDtypeSize, int64_t ubSize)
{
    // 满足 256B 对齐，可能存在 double buffer，保证每次最大搬运数量 256B 对齐
    if (xDtypeSize == DTYPE_BYTE_SIZE_b8) {
        int64_t divisor = UB_BUF_CNT_b8 * COMMAND_SIZE * BUFFER_NUM;
        if (divisor != 0 && xDtypeSize != 0) {
            return (((ubSize - MAX_MASK_NUM * BLOCK_SIZE - MAX_STAT_NUM * BLOCK_SIZE - MULTI_CORE_BYTES_NUM) /
                     divisor) *
                    COMMAND_SIZE * BUFFER_NUM) /
                   xDtypeSize;
        } else {
            return -1;
        }
    } else if (xDtypeSize == DTYPE_BYTE_SIZE_b16) {
        int64_t divisor = UB_BUF_CNT_b16 * COMMAND_SIZE * BUFFER_NUM;
        if (divisor != 0 && xDtypeSize != 0) {
            return (((ubSize - MAX_MASK_NUM * BLOCK_SIZE - MAX_STAT_NUM * BLOCK_SIZE - MULTI_CORE_BYTES_NUM) /
                     divisor) *
                    COMMAND_SIZE * BUFFER_NUM) /
                   xDtypeSize;
        } else {
            return -1;
        }
    } else if (xDtypeSize == DTYPE_BYTE_SIZE_b32) {
        int64_t divisor = UB_BUF_CNT_b32 * COMMAND_SIZE * BUFFER_NUM;
        if (divisor != 0 && xDtypeSize != 0) {
            return (((ubSize - MAX_MASK_NUM * BLOCK_SIZE - MAX_STAT_NUM * BLOCK_SIZE - MULTI_CORE_BYTES_NUM) /
                     divisor) *
                    COMMAND_SIZE * BUFFER_NUM) /
                   xDtypeSize;
        } else {
            return -1;
        }
    } else { // error data byte size
        return -1;
    }
}

__aicore__ inline int64_t CalculateMaxProcCountMulti(int64_t xDtypeSize, int64_t ubSize)
{
    // 满足 256B 对齐，可能存在 double buffer，保证每次最大搬运数量 256B 对齐
    if (xDtypeSize == DTYPE_BYTE_SIZE_b8) {
        int64_t divisor = UB_BUF_CNT_b8_MULTI * COMMAND_SIZE * BUFFER_NUM;
        if (divisor != 0 && xDtypeSize != 0) {
            return (((ubSize - MAX_STAT_NUM * BLOCK_SIZE - MULTI_CORE_BYTES_NUM) / divisor) * COMMAND_SIZE *
                    BUFFER_NUM) /
                   xDtypeSize;
        } else {
            return -1;
        }
    } else if (xDtypeSize == DTYPE_BYTE_SIZE_b16) {
        int64_t divisor = UB_BUF_CNT_b16_MULTI * COMMAND_SIZE * BUFFER_NUM;
        if (divisor != 0 && xDtypeSize != 0) {
            return (((ubSize - MAX_STAT_NUM * BLOCK_SIZE - MULTI_CORE_BYTES_NUM) / divisor) * COMMAND_SIZE *
                    BUFFER_NUM) /
                   xDtypeSize;
        } else {
            return -1;
        }
    } else if (xDtypeSize == DTYPE_BYTE_SIZE_b32) {
        int64_t divisor = UB_BUF_CNT_b32_MULTI * COMMAND_SIZE * BUFFER_NUM;
        if (divisor != 0 && xDtypeSize != 0) {
            return (((ubSize - MAX_STAT_NUM * BLOCK_SIZE - MULTI_CORE_BYTES_NUM) / divisor) * COMMAND_SIZE *
                    BUFFER_NUM) /
                   xDtypeSize;
        } else {
            return -1;
        }
    } else { // error data byte size
        return -1;
    }
}

template <typename T1, typename T2>
__aicore__ inline T1 CeilDiv(T1 a, T2 b)
{
    T1 bTemp(b);
    return bTemp == 0 ? a : (a + bTemp - 1) / bTemp;
}

template <typename T1, typename T2>
__aicore__ inline T1 CeilAlign(T1 a, T2 b)
{
    T1 bTemp(b);
    return bTemp == 0 ? a : CeilDiv(a, bTemp) * bTemp;
}

// 当前调用方式多核同步不支持硬同步，因此需要软同步
__aicore__ inline void SyncAllCore(
    TQue<QuePosition::VECOUT, BUFFER_NUM>& workQueue, uint64_t syncspace, uint64_t aiCoreNum)
{
    GlobalTensor<int32_t> syncGlobal;
    syncGlobal.SetGlobalBuffer((__gm__ int32_t*)syncspace, aiCoreNum * (BLOCK_SIZE / sizeof(int32_t)));

    LocalTensor<int32_t> workLocal = workQueue.AllocTensor<int32_t>();

    SyncAll<true>(syncGlobal, workLocal, aiCoreNum);
    workQueue.FreeTensor(workLocal);
}

template <typename T>
__aicore__ inline void CopyInData(
    LocalTensor<T>& dstUB, GlobalTensor<T>& srcGM, int64_t dataCount, int64_t perBlockCount)
{
    if (dataCount % perBlockCount) {
        int64_t floorAlignCnt = dataCount / perBlockCount * perBlockCount;
        if (floorAlignCnt > 0) {
            DataCopy(dstUB, srcGM, floorAlignCnt);
            pipe_barrier(PIPE_ALL);
        }
        for (int64_t i = floorAlignCnt; i < dataCount; ++i) {
            dstUB.SetValue(i, srcGM.GetValue(i));
        }
    } else {
        DataCopy(dstUB, srcGM, dataCount);
    }
    pipe_barrier(PIPE_ALL);
}

template <typename T>
__aicore__ inline void CopyInX(
    TQue<QuePosition::VECIN, BUFFER_NUM>& xQue, GlobalTensor<T>& xGm, int64_t gmOffset, int64_t dataCount,
    int64_t perBlockCount)
{
    LocalTensor<T> xIn = xQue.AllocTensor<T>();
    GlobalTensor<T> xOut = xGm[gmOffset];
    CopyInData(xIn, xOut, dataCount, perBlockCount);
    xQue.EnQue(xIn);
}

template <typename OutputT>
__aicore__ inline void UpdateCoreOutput(uint64_t addr, OutputT outputValue)
{
    GlobalTensor<OutputT> outputGm;
    outputGm.SetGlobalBuffer((__gm__ OutputT*)addr);
    outputGm.SetValue(0, outputValue);

    DataCacheCleanAndInvalid<OutputT, CacheLine::SINGLE_CACHE_LINE, DcciDst::CACHELINE_OUT>(outputGm);
}

template <typename OutputT>
__aicore__ inline OutputT GetCoreOutput(uint64_t addr)
{
    GlobalTensor<OutputT> outputGm;
    outputGm.SetGlobalBuffer((__gm__ OutputT*)addr);
    DataCacheCleanAndInvalid<OutputT, CacheLine::SINGLE_CACHE_LINE, DcciDst::CACHELINE_OUT>(outputGm);
    return outputGm.GetValue(0);
}

__aicore__ inline void CopyOutToWorkspace(
    LocalTensor<uint64_t>& localT, int64_t curCoreStart, uint64_t workspace, int64_t blockIdx, uint64_t statNum)
{
    uint64_t curWorkSpaceAddr =
        workspace + blockIdx * (statNum * MAX_WORKSPACE_BYTE_SIZE) + curCoreStart * MAX_WORKSPACE_BYTE_SIZE;
    GlobalTensor<uint64_t> workspaceOut;
    workspaceOut.SetGlobalBuffer((__gm__ uint64_t*)curWorkSpaceAddr, MAX_WORKSPACE_BYTE_SIZE / sizeof(uint64_t));
    DataCopy(workspaceOut, localT, MAX_WORKSPACE_BYTE_SIZE / sizeof(uint64_t));
    pipe_barrier(PIPE_ALL);
}

__aicore__ inline void UpdateMsg(__gm__ KfcDumpStatMsg* sMsg, __gm__ KfcDumpStatMsg* rMsg, bool isSuccess)
{
    GlobalTensor<uint32_t> rcvMsgGM;
    rcvMsgGM.SetGlobalBuffer((__gm__ uint32_t*)rMsg);

    GlobalTensor<uint32_t> sendMsgGM;
    sendMsgGM.SetGlobalBuffer((__gm__ uint32_t*)sMsg);

    auto iterCount = sizeof(KfcDumpStatMsg) / sizeof(uint32_t);
    for (int32_t i = 0; i < iterCount; ++i) {
        sendMsgGM.SetValue(i, rcvMsgGM.GetValue(i));
    }

    sendMsgGM.SetValue(MSG_TYPE_INDEX, static_cast<uint32_t>(DumpStatMsgType::KFC_DUMP_MSG_RESPONSE));

    if (isSuccess) {
        sendMsgGM.SetValue(MSG_RESULT_INDEX, MSG_RESULT_SUCCESS);
    } else {
        sendMsgGM.SetValue(MSG_RESULT_INDEX, MSG_RESULT_FAILED);
    }

    sendMsgGM.SetValue(MSG_VALID_INDEX, DUMP_MSG_VALID_MASK);

    rcvMsgGM.SetValue(MSG_VALID_INDEX, ~DUMP_MSG_VALID_MASK);

    DataCacheCleanAndInvalid<uint32_t, CacheLine::SINGLE_CACHE_LINE, DcciDst::CACHELINE_OUT>(rcvMsgGM);
    DataCacheCleanAndInvalid<uint32_t, CacheLine::SINGLE_CACHE_LINE, DcciDst::CACHELINE_OUT>(sendMsgGM);
}

// fp8 类型仅在部分架构上存在，统一通过该trait判断，避免散落的架构宏
template <typename T>
struct IsFp8Type {
#if KFC_DUMP_SUPPORT_FP8
    static constexpr bool value =
        std::is_same_v<T, hifloat8_t> || std::is_same_v<T, fp8_e4m3fn_t> || std::is_same_v<T, fp8_e5m2_t>;
#else
    static constexpr bool value = false;
#endif
};

// 尾块对齐填充：将尾部 appendNum 个元素填充为 fillValue（fillValue 取首元素或 0）
template <typename T>
__aicore__ inline void AppendTailPadding(LocalTensor<T>& x, int64_t curProcessCount, int64_t appendNum)
{
    if (appendNum <= 0) {
        return;
    }
#if KFC_DUMP_SUPPORT_FP8
    if constexpr (IsFp8Type<T>::value) {
        return; // fp8 尾块在 cast 到 float32 后填充
    } else {
        T appendValue{0};
        for (int64_t i = curProcessCount - appendNum; i < curProcessCount; ++i) {
            x.SetValue(i, appendValue);
        }
    }
#else
    T appendValue{0};
    for (int64_t i = curProcessCount - appendNum; i < curProcessCount; ++i) {
        x.SetValue(i, appendValue);
    }
#endif
    pipe_barrier(PIPE_ALL);
}

// fp8 尾块在 cast 后以 float 填充（fp8 不支持 SetValue 填充自身类型）。
// 求和/计数类统计（mean/l2norm/nan/inf）补 0 不影响结果；
// max/min 需以首元素值填充，否则全负数据的 max / 全正数据的 min 会被错误统计为 0
__aicore__ inline void AppendTailPaddingFp32(
    LocalTensor<float>& x, int64_t curProcessCount, int64_t appendNum, float appendValue = 0.0f)
{
    if (appendNum <= 0) {
        return;
    }
    for (int64_t i = curProcessCount - appendNum; i < curProcessCount; ++i) {
        x.SetValue(i, appendValue);
    }
    pipe_barrier(PIPE_ALL);
}

// 将输入 x cast 到 float32（b8 走 half 中转），返回 float32 tensor；float 原样返回
template <typename T>
__aicore__ inline LocalTensor<float> CastXToFloat32(
    LocalTensor<T>& x, TBuf<TPosition::VECCALC>& castXBuf, int64_t curProcessCount)
{
    if constexpr (std::is_same_v<T, float>) {
        return x;
    } else if constexpr (std::is_same_v<T, uint8_t> || std::is_same_v<T, int8_t>) {
        LocalTensor<half> float16X = castXBuf.Get<half>();
        Cast(float16X, x, RoundMode::CAST_NONE, curProcessCount);
        pipe_barrier(PIPE_ALL);

        LocalTensor<uint8_t> float32Addr = castXBuf.Get<uint8_t>()[curProcessCount * sizeof(half)];
        LocalTensor<float> float32X = float32Addr.ReinterpretCast<float>();
        Cast(float32X, float16X, RoundMode::CAST_NONE, curProcessCount);
        return float32X;
    } else {
        // int16/int32/half/bfloat16 及支持的 fp8 类型统一直接 cast 到 float32
        LocalTensor<float> float32X = castXBuf.Get<float>();
        Cast(float32X, x, RoundMode::CAST_NONE, curProcessCount);
        return float32X;
    }
}

// 不支持的类型（整型）统计项：结果置 0 并释放队列
template <typename T>
__aicore__ inline void ResetStatValueAndFree(
    TQue<QuePosition::VECIN, BUFFER_NUM>& xQue, LocalTensor<T>& x, LocalTensor<uint8_t>& calMidAddr)
{
    LocalTensor<int32_t> curValue = calMidAddr[sizeof(float)].ReinterpretCast<int32_t>();
    curValue.SetValue(0, 0);
    xQue.FreeTensor(x);
}

// 将 cur*Addr 处的统计结果搬到 calMidAddr 首地址，供 CopyOutToWorkspace 使用
template <typename OutputT>
__aicore__ inline void WriteStatOutput(LocalTensor<uint8_t>& calMidAddr, LocalTensor<uint8_t>& curValueAddr)
{
    LocalTensor<OutputT> targetValue = curValueAddr.ReinterpretCast<OutputT>();
    OutputT outputValue = targetValue.GetValue(0);
    LocalTensor<OutputT> localOutput = calMidAddr.ReinterpretCast<OutputT>();
    localOutput.SetValue(0, outputValue);
    pipe_barrier(PIPE_ALL);
}

// 整型是否为 nan/inf 统计不支持的类型
template <typename T>
struct IsIntType {
    static constexpr bool value = std::is_same_v<T, uint8_t> || std::is_same_v<T, int8_t> ||
                                  std::is_same_v<T, int16_t> || std::is_same_v<T, int32_t>;
};

// 浮点统计骨架：取数 -> 整型早退 -> 尾块填充 -> cast 到 float32 -> 回调 ComputeFunc -> 释放。
// nan/inf 等仅支持浮点输入的统计项复用该骨架，只需提供各自的 ComputeFunc
template <typename T, typename ComputeFunc>
__aicore__ inline void ComputeFloatStatSkeleton(
    TQue<QuePosition::VECIN, BUFFER_NUM>& xQue, TBuf<TPosition::VECCALC>& castXBuf,
    TQue<QuePosition::VECOUT, BUFFER_NUM>& workQueue, TBuf<TPosition::VECCALC>& maskBuf,
    TBuf<TPosition::VECCALC>& cacheBuf1, LocalTensor<uint8_t>& calMidAddr, int64_t curLoop, int64_t curProcessCount,
    int64_t appendNum, ComputeFunc computeFunc)
{
    LocalTensor<T> x = xQue.DeQue<T>();
    if constexpr (IsIntType<T>::value) {
        // 整型不支持该统计项，结果置 0
        ResetStatValueAndFree<T>(xQue, x, calMidAddr);
        return;
    }

    AppendTailPadding<T>(x, curProcessCount, appendNum);

    if constexpr (std::is_same_v<T, float>) {
        computeFunc(workQueue, maskBuf, cacheBuf1, x, calMidAddr, curLoop, curProcessCount);
    } else {
        // half/bfloat16 及支持的 fp8 类型统一 cast 到 float32 后统计
        LocalTensor<float> float32X = CastXToFloat32<T>(x, castXBuf, curProcessCount);
        AppendTailPaddingFp32(float32X, curProcessCount, appendNum);
        pipe_barrier(PIPE_ALL);
        computeFunc(workQueue, maskBuf, cacheBuf1, float32X, calMidAddr, curLoop, curProcessCount);
    }

    xQue.FreeTensor(x);
}

} // namespace KfcDumpStat

#endif // __KFC_DUMP_BASE_H__