/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef KFC_DUMP_UT_KERNEL_OPERATOR_STUB_H
#define KFC_DUMP_UT_KERNEL_OPERATOR_STUB_H

// dump_stat_op UT 专用 kernel_operator.h 桩：以 CPU 内存模拟 UB/GM，向量 API 按
// 真实语义逐元素实现，使被测算子代码可在 host 侧独立编译与运行。
// 仅覆盖被测代码用到的 API 子集；不引入任何 CANN 头文件。

#include <cmath>
#include <cstdint>
#include <cstring>
#include <algorithm>
#include "securec.h"

#define __aicore__
#define __gm__
#define __ubuf__
#define __global__
#define GM_ADDR uint64_t

namespace AscendC {

// 单次搬运字节上限（与 TPipe UB 池一致），供 DataCopy 长度校验
inline constexpr uint64_t STUB_UB_POOL_LIMIT = 64ULL * 1024 * 1024;

// ---------------------------------------------------------------------------
// 基础类型
// ---------------------------------------------------------------------------
class half {
public:
    half() = default;
    half(float v) : value_(v) {}
    operator float() const { return value_; }

private:
    float value_ = 0.0f;
};

class bfloat16_t {
public:
    bfloat16_t() = default;
    bfloat16_t(float v) : value_(v) {}
    operator float() const { return value_; }

private:
    float value_ = 0.0f;
};

// fp8 类型（仅作 David 分支 UT 的占位实现：以 float 存值，语义与 half 类似）
class hifloat8_t {
public:
    hifloat8_t() = default;
    hifloat8_t(float v) : value_(v) {}
    operator float() const { return value_; }

private:
    float value_ = 0.0f;
};

class fp8_e4m3fn_t {
public:
    fp8_e4m3fn_t() = default;
    fp8_e4m3fn_t(float v) : value_(v) {}
    operator float() const { return value_; }

private:
    float value_ = 0.0f;
};

class fp8_e5m2_t {
public:
    fp8_e5m2_t() = default;
    fp8_e5m2_t(float v) : value_(v) {}
    operator float() const { return value_; }

private:
    float value_ = 0.0f;
};

enum class QuePosition { VECIN, VECOUT };
enum class TPosition { VECCALC };
enum class CacheLine { SINGLE_CACHE_LINE, ENTIRE_DATA_CACHE };
enum class DcciDst { CACHELINE_ALL, CACHELINE_UB, CACHELINE_OUT, CACHELINE_ATOMIC };
enum class RoundMode { CAST_NONE, CAST_RINT };
enum class PipeBarrierType : int32_t { PIPE_ALL };
// 被测代码以 PIPE_ALL 宏形式使用（pipe_barrier(PIPE_ALL) / PipeBarrier<PIPE_ALL>()）
#define PIPE_ALL (AscendC::PipeBarrierType::PIPE_ALL)
enum class CMPMODE { EQ, NE, LT, LE, GT, GE };
enum class SELMODE { VSEL_TENSOR_SCALAR_MODE };

// ---------------------------------------------------------------------------
// Tensor：以 host 内存指针 + 偏移模拟
// ---------------------------------------------------------------------------
template <typename T>
class GlobalTensor {
public:
    GlobalTensor() = default;

    void SetGlobalBuffer(T* ptr, uint32_t len = 0)
    {
        ptr_ = ptr;
        len_ = len;
    }

    // 支持 tensor[offset] 形式（返回副本语义的视图）
    GlobalTensor<T> operator[](int64_t offset) const
    {
        GlobalTensor<T> view;
        view.ptr_ = ptr_ + offset;
        view.len_ = (len_ > static_cast<uint32_t>(offset)) ? (len_ - static_cast<uint32_t>(offset)) : 0U;
        return view;
    }

    T GetValue(int64_t index) const { return ptr_[index]; }
    void SetValue(int64_t index, T value) const { ptr_[index] = value; }

    T* GetPhyAddr() const { return ptr_; }

private:
    T* ptr_ = nullptr;
    uint32_t len_ = 0;
};

template <typename T>
class LocalTensor {
public:
    LocalTensor() = default;
    explicit LocalTensor(T* ptr) : ptr_(ptr) {}

    T GetValue(int64_t index) const { return ptr_[index]; }
    void SetValue(int64_t index, T value) const { ptr_[index] = value; }

    // 偏移视图
    LocalTensor<T> operator[](int64_t offset) const { return LocalTensor<T>(ptr_ + offset); }

    template <typename U>
    LocalTensor<U> ReinterpretCast() const
    {
        return LocalTensor<U>(reinterpret_cast<U*>(ptr_));
    }

    T* GetPhyAddr() const { return ptr_; }

private:
    T* ptr_ = nullptr;
};

// ---------------------------------------------------------------------------
// UB 内存池：TPipe 统一分配，64MB 上限足够测试场景
// ---------------------------------------------------------------------------
struct StubUbBlock {
    uint8_t* base = nullptr;
    uint64_t size = 0;
};

class TQueBind {};

template <QuePosition POS>
class TQueBase {
public:
    TQueBase() = default;

    template <typename T>
    LocalTensor<T> AllocTensor()
    {
        return LocalTensor<T>(reinterpret_cast<T*>(buffer_));
    }

    template <typename T>
    LocalTensor<T> AllocTensor(uint32_t len)
    {
        (void)len;
        return LocalTensor<T>(reinterpret_cast<T*>(buffer_));
    }

    template <typename T>
    void EnQue(LocalTensor<T>&)
    {}

    template <typename T>
    LocalTensor<T> DeQue()
    {
        return LocalTensor<T>(reinterpret_cast<T*>(buffer_));
    }

    template <typename T>
    void FreeTensor(LocalTensor<T>&)
    {}

    void InitBuffer(uint8_t* buffer, uint32_t len)
    {
        buffer_ = buffer;
        bufferLen_ = len;
    }

private:
    uint8_t* buffer_ = nullptr;
    uint32_t bufferLen_ = 0;
};

template <QuePosition POS, int32_t BUFFER_NUM = 2>
class TQue : public TQueBase<POS> {};

template <TPosition POS>
class TBuf {
public:
    TBuf() = default;

    template <typename T>
    LocalTensor<T> Get()
    {
        return LocalTensor<T>(reinterpret_cast<T*>(buffer_));
    }

    void InitBuffer(uint8_t* buffer, uint32_t len)
    {
        buffer_ = buffer;
        bufferLen_ = len;
    }

private:
    uint8_t* buffer_ = nullptr;
    uint32_t bufferLen_ = 0;
};

class TPipe {
public:
    TPipe() : ub_(new uint8_t[UB_POOL_SIZE]()), used_(0) { (void)memset_s(ub_, UB_POOL_SIZE, 0, UB_POOL_SIZE); }

    ~TPipe() { delete[] ub_; }

    TPipe(const TPipe&) = delete;
    TPipe& operator=(const TPipe&) = delete;

    // 兼容两种调用形态：InitBuffer(buf, len) 与 InitBuffer(que, bufNum, len)
    // 长度取最后一个参数（不能按类型重载解析：len 可能是 int/uint32_t/int64_t 等多种字面量类型）
    template <typename T>
    void InitBuffer(T& buf, uint64_t len)
    {
        // 32B 对齐
        used_ = (used_ + 31U) & ~31U;
        buf.InitBuffer(ub_ + used_, static_cast<uint32_t>(len));
        used_ += len;
    }

    template <typename T, typename BufNumT>
    void InitBuffer(T& buf, BufNumT, uint64_t len)
    {
        InitBuffer(buf, len);
    }

    void Destroy() {}

private:
    static constexpr uint64_t UB_POOL_SIZE = 64ULL * 1024 * 1024;

    uint8_t* ub_;
    uint64_t used_;
};

// ---------------------------------------------------------------------------
// 标量/向量计算 API：CPU 语义实现
// ---------------------------------------------------------------------------
__aicore__ inline void pipe_barrier(PipeBarrierType) {}
template <PipeBarrierType P>
__aicore__ inline void PipeBarrier()
{}

template <int countValue = 1>
__aicore__ inline int64_t ScalarGetCountOfValue(uint64_t valueIn)
{
    int64_t count = 0;
    while (valueIn != 0U) {
        count += static_cast<int64_t>(valueIn & 1ULL);
        valueIn >>= 1U;
    }
    return count;
}

template <typename T, CacheLine L, DcciDst D>
__aicore__ inline void DataCacheCleanAndInvalid(const GlobalTensor<T>&)
{}

template <typename T, CacheLine L>
__aicore__ inline void DataCacheCleanAndInvalid(const GlobalTensor<T>&)
{}

// 当前 block 序号：由 UT 用例通过 KfcDumpUtSetBlockIdx 注入（模拟多核场景）
inline int64_t& StubBlockIdxRef()
{
    static int64_t idx = 0;
    return idx;
}

// 屏障到达计数：按核记录 SyncAll 到达次数（数组容量按 1024 核预留）。
// 全核屏障语义要求各核每代都到达，否则真实硬件上参与核会永久等待。
// UT 用例在多核模拟结束后调用 StubCheckBarrierCounts 校验各核到达次数一致
inline constexpr int64_t STUB_MAX_CORE_NUM = 1024;
inline int64_t* StubBarrierCounts()
{
    static int64_t counts[STUB_MAX_CORE_NUM] = {0};
    return counts;
}
inline void StubBarrierArrive()
{
    int64_t idx = StubBlockIdxRef();
    if (idx >= 0 && idx < STUB_MAX_CORE_NUM) {
        ++StubBarrierCounts()[idx];
    }
}
// 校验前 coreNum 个核的屏障到达次数一致；返回 false 时 outCore 返回不一致的核号
inline bool StubCheckBarrierCounts(int64_t coreNum, int64_t& outIdx)
{
    for (int64_t i = 0; i < coreNum; ++i) {
        if (StubBarrierCounts()[i] != StubBarrierCounts()[0]) {
            outIdx = i;
            return false;
        }
    }
    return true;
}
inline void StubResetBarrierCounts()
{
    (void)memset_s(StubBarrierCounts(), sizeof(int64_t) * STUB_MAX_CORE_NUM, 0, sizeof(int64_t) * STUB_MAX_CORE_NUM);
}

__aicore__ inline int64_t GetBlockIdx() { return StubBlockIdxRef(); }
__aicore__ inline int64_t GetBlockNum() { return 1; }

// 软同步（单线程直接返回，但记录各核到达次数供 UT 校验屏障对称性）
template <bool barrier = false>
__aicore__ inline void SyncAll()
{
    StubBarrierArrive();
}

template <bool barrier = false>
__aicore__ inline void SyncAll(GlobalTensor<int32_t>&, LocalTensor<int32_t>&, int64_t)
{
    StubBarrierArrive();
}

// GM <-> UB 搬运
// count 上限校验：搬运字节数超过单 buffer 上限(64MB)视为非法，直接返回
__aicore__ inline bool StubCheckCopyLen(int64_t byteLen)
{
    return byteLen > 0 && static_cast<uint64_t>(byteLen) <= STUB_UB_POOL_LIMIT;
}

template <typename T>
__aicore__ inline void DataCopy(LocalTensor<T>& dst, GlobalTensor<T>& src, int64_t count)
{
    if (StubCheckCopyLen(count * static_cast<int64_t>(sizeof(T)))) {
        (void)memcpy_s(
            dst.GetPhyAddr(), static_cast<uint64_t>(count) * sizeof(T), src.GetPhyAddr(),
            static_cast<uint64_t>(count) * sizeof(T));
    }
}

template <typename T>
__aicore__ inline void DataCopy(GlobalTensor<T>& dst, LocalTensor<T>& src, int64_t count)
{
    if (StubCheckCopyLen(count * static_cast<int64_t>(sizeof(T)))) {
        (void)memcpy_s(
            dst.GetPhyAddr(), static_cast<uint64_t>(count) * sizeof(T), src.GetPhyAddr(),
            static_cast<uint64_t>(count) * sizeof(T));
    }
}

template <typename T>
__aicore__ inline void Duplicate(LocalTensor<T>& dst, T srcValue, int64_t count)
{
    for (int64_t i = 0; i < count; ++i) {
        dst.SetValue(i, srcValue);
    }
}

// 通用 Cast：数值转换（b8/b16 -> float 等）
template <typename DstT, typename SrcT>
__aicore__ inline void CastImpl(LocalTensor<DstT>& dst, const LocalTensor<SrcT>& src, int64_t count)
{
    for (int64_t i = 0; i < count; ++i) {
        dst.SetValue(i, static_cast<DstT>(static_cast<float>(src.GetValue(i))));
    }
}

template <typename DstT, typename SrcT>
__aicore__ inline void Cast(LocalTensor<DstT>& dst, const LocalTensor<SrcT>& src, RoundMode, int64_t count)
{
    CastImpl(dst, src, count);
}

// 归约
template <typename T>
__aicore__ inline void ReduceMax(
    LocalTensor<T>& dst, const LocalTensor<T>& src, LocalTensor<T>& work, int64_t count, bool)
{
    if (count <= 0) {
        return;
    }
    T maxVal = src.GetValue(0);
    for (int64_t i = 1; i < count; ++i) {
        T cur = src.GetValue(i);
        if (static_cast<float>(cur) > static_cast<float>(maxVal)) {
            maxVal = cur;
        }
    }
    dst.SetValue(0, maxVal);
    (void)work;
}

template <typename T>
__aicore__ inline void ReduceMin(
    LocalTensor<T>& dst, const LocalTensor<T>& src, LocalTensor<T>& work, int64_t count, bool)
{
    if (count <= 0) {
        return;
    }
    T minVal = src.GetValue(0);
    for (int64_t i = 1; i < count; ++i) {
        T cur = src.GetValue(i);
        if (static_cast<float>(cur) < static_cast<float>(minVal)) {
            minVal = cur;
        }
    }
    dst.SetValue(0, minVal);
    (void)work;
}

template <typename T>
__aicore__ inline void ReduceSum(LocalTensor<T>& dst, const LocalTensor<T>& src, LocalTensor<T>& work, int64_t count)
{
    float sum = 0.0f;
    for (int64_t i = 0; i < count; ++i) {
        sum += static_cast<float>(src.GetValue(i));
    }
    dst.SetValue(0, static_cast<T>(sum));
    (void)work;
}

// 逐元素二元
template <typename T>
__aicore__ inline void Max(LocalTensor<T>& dst, const LocalTensor<T>& src0, const LocalTensor<T>& src1, int64_t count)
{
    for (int64_t i = 0; i < count; ++i) {
        T a = src0.GetValue(i);
        T b = src1.GetValue(i);
        dst.SetValue(i, (static_cast<float>(a) > static_cast<float>(b)) ? a : b);
    }
}

template <typename T>
__aicore__ inline void Min(LocalTensor<T>& dst, const LocalTensor<T>& src0, const LocalTensor<T>& src1, int64_t count)
{
    for (int64_t i = 0; i < count; ++i) {
        T a = src0.GetValue(i);
        T b = src1.GetValue(i);
        dst.SetValue(i, (static_cast<float>(a) < static_cast<float>(b)) ? a : b);
    }
}

template <typename T>
__aicore__ inline void Mul(LocalTensor<T>& dst, const LocalTensor<T>& src0, const LocalTensor<T>& src1, int64_t count)
{
    for (int64_t i = 0; i < count; ++i) {
        dst.SetValue(i, static_cast<T>(static_cast<float>(src0.GetValue(i)) * static_cast<float>(src1.GetValue(i))));
    }
}

// 比较与选择：mask 结果以 uint8 存放
// UT 探针：记录最近一次 Compare 的 true 计数与 count（仅调试用，正式 stub 无副作用）
inline int64_t& StubCmpTrueCount()
{
    static int64_t c = 0;
    return c;
}
inline int64_t& StubCmpTotalCount()
{
    static int64_t c = 0;
    return c;
}

__aicore__ inline void Compare(
    LocalTensor<uint8_t>& dst, const LocalTensor<float>& src0, const LocalTensor<float>& src1, CMPMODE mode,
    int64_t count)
{
    StubCmpTrueCount() = 0;
    StubCmpTotalCount() = count;
    for (int64_t i = 0; i < count; ++i) {
        float a = src0.GetValue(i);
        float b = src1.GetValue(i);
        bool r = false;
        switch (mode) {
            case CMPMODE::EQ:
                r = (a == b); // 硬件语义：NaN == NaN 判 false（无序比较）
                break;
            case CMPMODE::NE:
                r = (a != b) && !(std::isnan(a) && std::isnan(b));
                break;
            case CMPMODE::LT:
                r = a < b;
                break;
            case CMPMODE::LE:
                r = a <= b;
                break;
            case CMPMODE::GT:
                r = a > b;
                break;
            case CMPMODE::GE:
                r = a >= b;
                break;
        }
        dst.SetValue(i, r ? 1 : 0);
        if (r) {
            StubCmpTrueCount()++;
        }
    }
}

__aicore__ inline void CompareScalar(
    LocalTensor<uint8_t>& dst, const LocalTensor<float>& src, float scalar, CMPMODE mode, int64_t count)
{
    for (int64_t i = 0; i < count; ++i) {
        float a = src.GetValue(i);
        bool r = false;
        switch (mode) {
            case CMPMODE::EQ:
                r = a == scalar;
                break;
            case CMPMODE::NE:
                r = a != scalar;
                break;
            case CMPMODE::LT:
                r = a < scalar;
                break;
            case CMPMODE::LE:
                r = a <= scalar;
                break;
            case CMPMODE::GT:
                r = a > scalar;
                break;
            case CMPMODE::GE:
                r = a >= scalar;
                break;
        }
        dst.SetValue(i, r ? 1 : 0);
    }
}

// 硬件语义：mask[i] 为 false(0) 时选 scalar，为 true(非 0) 时选 src[i]
// 被测代码依赖该语义（Select ones where compare result is false）统计 NaN/Inf
__aicore__ inline void Select(
    LocalTensor<float>& dst, const LocalTensor<uint8_t>& mask, const LocalTensor<float>& src, float scalar, SELMODE,
    int64_t count)
{
    for (int64_t i = 0; i < count; ++i) {
        dst.SetValue(i, (mask.GetValue(i) != 0) ? src.GetValue(i) : scalar);
    }
}

} // namespace AscendC

// sqrt 重载：被测代码在命名空间内以 ADL 方式调用（kfc_dump_base.h 的 sqrt(half) 等）
inline float sqrt(AscendC::half v) { return std::sqrt(static_cast<float>(v)); }
inline float sqrt(AscendC::bfloat16_t v) { return std::sqrt(static_cast<float>(v)); }
inline float sqrt(AscendC::hifloat8_t v) { return std::sqrt(static_cast<float>(v)); }
inline float sqrt(AscendC::fp8_e4m3fn_t v) { return std::sqrt(static_cast<float>(v)); }
inline float sqrt(AscendC::fp8_e5m2_t v) { return std::sqrt(static_cast<float>(v)); }

#endif // KFC_DUMP_UT_KERNEL_OPERATOR_STUB_H
