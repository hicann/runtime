/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "kernel_tensor.h"
#include "kernel_tpipe.h"
#include "kernel_operator_scalar_intf.h"
#include "kernel_operator_sys_var_intf.h"
#include "kernel_operator_data_copy_intf.h"
#include "kernel_operator_vec_binary_intf.h"
#include "kernel_operator_block_sync_intf.h"
#include "kernel_operator_utils_intf.h"

#include "../../task_queue/aivec_task_queue.h"

#include <cstddef>
#include <cstdint>

using namespace AscendC;

namespace {
constexpr uint32_t kChunkBytes = 24U * 1024U;
constexpr uint32_t kBufBytes = kChunkBytes;

constexpr uint32_t kBufNum = 2U;
constexpr uint32_t kModeEncrypt = 0U;
constexpr uint32_t kAivPerSyncGroup = 8U;
constexpr uint32_t kDescRetryLimit = 2000U;

template <typename T>
__aicore__ inline T LoadGmBypass(const __gm__ volatile T* addr)
{
    return ReadGmByPassDCache(const_cast<__gm__ T*>(addr));
}

template <typename T>
__aicore__ inline void StoreGmBypass(__gm__ volatile T* addr, T value)
{
    WriteGmByPassDCache(const_cast<__gm__ T*>(addr), value);
}

} // namespace

// 仅 0 号核更新队列状态；其他核只读，每片完成后全核同步。
class KernelKsXorAiv {
public:
    __aicore__ inline void Init(GM_ADDR queueGm, const uint64_t ctlPacked)
    {
        queue_ = reinterpret_cast<__gm__ BarTaskQueue*>(queueGm);
        ctlPacked_ = ctlPacked;
        pipe_.InitBuffer(inQueue_, kBufNum, kBufBytes);
        pipe_.InitBuffer(ksQueue_, kBufNum, kBufBytes);
        pipe_.InitBuffer(outQueue_, kBufNum, kBufBytes);
    }

    __aicore__ inline void Process()
    {
        const uint32_t totalSlices = static_cast<uint32_t>(ctlPacked_ & 0xFFFFFFFFULL);
        const uint32_t mode = static_cast<uint32_t>(ctlPacked_ >> 32U);
        const uint32_t blockIdx = GetBlockIdx();
        const uint32_t blockNum = GetBlockNum();
        if (blockNum > kAivPerSyncGroup) {
            FailAndTerminate(blockIdx, AICC_QUEUE_ERR_PARAM_INVALID);
            return;
        }
        if (IsBarTaskQueueTerminated(queue_)) {
            FailAndTerminate(blockIdx, AICC_QUEUE_ERR_TERMINATED);
            return;
        }

        for (uint32_t s = 0U; s < totalSlices; ++s) {
            __gm__ uint8_t* const taskDesc = (blockIdx == 0U) ? PopBarTaskAt(queue_, s) : PeekBarTaskAt(queue_, s);
            if (taskDesc == nullptr) {
                FailAndTerminate(blockIdx, AICC_QUEUE_ERR_TERMINATED);
                return;
            }
            AiccKeystreamXorSliceDesc desc;
            if (!LoadDescReady(taskDesc, desc)) {
                FailAndTerminate(blockIdx, AICC_QUEUE_ERR_PARAM_INVALID);
                return;
            }

            const uint32_t len = desc.plaintextLen;
            const uint32_t chunks = (len + kChunkBytes - 1U) / kChunkBytes;
            const uint32_t perChunk = chunks / blockNum;
            const uint32_t remChunk = chunks % blockNum;
            const uint32_t startChunk = (blockIdx * perChunk) + ((blockIdx < remChunk) ? blockIdx : remChunk);
            const uint32_t endChunk = startChunk + perChunk + ((blockIdx < remChunk) ? 1U : 0U);
            for (uint32_t c = startChunk; c < endChunk; ++c) {
                const uint32_t off = c * kChunkBytes;
                const uint32_t n = ((len - off) > kChunkBytes) ? kChunkBytes : (len - off);
                DoChunk(desc, off, n, mode);
            }

            AscendC::SyncAll<true>();
            if (blockIdx == 0U) {
                PipeBarrier<PIPE_ALL>();
                (void)UpdateBarTaskComplete(queue_);
            }
        }

        if (blockIdx == 0U) {
            StoreGmBypass(&queue_->deviceErrCode, static_cast<uint32_t>(AICC_QUEUE_ERR_OK));
            TerminateBarTaskQueue(queue_);
        }
    }

private:
    __aicore__ inline void FailAndTerminate(const uint32_t blockIdx, const uint32_t errCode)
    {
        if (blockIdx != 0U) {
            return;
        }
        StoreGmBypass(&queue_->deviceErrCode, errCode);
        TerminateBarTaskQueue(queue_);
    }

    __aicore__ inline bool LoadDescReady(__gm__ const uint8_t* const descAddr, AiccKeystreamXorSliceDesc& out)
    {
        for (uint32_t retry = 0U; retry <= kDescRetryLimit; ++retry) {
            out = LoadDesc(descAddr);
            if ((out.plaintextLen != 0U) && (out.ciphertextLen == out.plaintextLen)) {
                return true;
            }
            for (volatile uint32_t spin = 0U; spin < 100U; ++spin) {
            }
        }
        return false;
    }

    __aicore__ inline AiccKeystreamXorSliceDesc LoadDesc(__gm__ const uint8_t* const desc) const
    {
        const __gm__ AiccKeystreamXorSliceDesc* const p =
            reinterpret_cast<__gm__ const AiccKeystreamXorSliceDesc*>(desc);
        AiccKeystreamXorSliceDesc d;
        d.ciphertextAddr = LoadGmBypass(&p->ciphertextAddr);
        d.plaintextAddr = LoadGmBypass(&p->plaintextAddr);
        d.ciphertextLen = LoadGmBypass(&p->ciphertextLen);
        d.plaintextLen = LoadGmBypass(&p->plaintextLen);
        d.keystreamAddr = LoadGmBypass(&p->keystreamAddr);
        return d;
    }

    __aicore__ inline void CopyPadGmToUb(LocalTensor<uint8_t> local, __gm__ uint8_t* const gm, uint32_t bytes)
    {
        GlobalTensor<uint8_t> gmTensor;
        gmTensor.SetGlobalBuffer(gm, bytes);
        const DataCopyExtParams extParams{1U, bytes, 0U, 0U, 0U};
        const DataCopyPadExtParams<uint8_t> padParams{false, 0U, 0U, 0U};
        DataCopyPad(local, gmTensor, extParams, padParams);
    }

    __aicore__ inline void CopyPadUbToGm(__gm__ uint8_t* const gm, LocalTensor<uint8_t> local, uint32_t bytes)
    {
        GlobalTensor<uint8_t> gmTensor;
        gmTensor.SetGlobalBuffer(gm, bytes);
        const DataCopyExtParams extParams{1U, bytes, 0U, 0U, 0U};
        DataCopyPad(gmTensor, local, extParams);
    }

    __aicore__ inline void DoChunk(
        const AiccKeystreamXorSliceDesc& desc, const uint32_t off, const uint32_t n, const uint32_t mode)
    {
        __gm__ uint8_t* cipher = reinterpret_cast<__gm__ uint8_t*>(static_cast<uint64_t>(desc.ciphertextAddr));
        __gm__ uint8_t* plain = reinterpret_cast<__gm__ uint8_t*>(static_cast<uint64_t>(desc.plaintextAddr));
        __gm__ uint8_t* ks = reinterpret_cast<__gm__ uint8_t*>(static_cast<uint64_t>(desc.keystreamAddr));
        __gm__ uint8_t* const src = (mode == kModeEncrypt) ? (plain + off) : (cipher + off);
        __gm__ uint8_t* const dst = (mode == kModeEncrypt) ? (cipher + off) : (plain + off);
        __gm__ uint8_t* const ksPtr = ks + off;

        LocalTensor<uint8_t> srcLocal = inQueue_.AllocTensor<uint8_t>();
        LocalTensor<uint8_t> ksLocal = ksQueue_.AllocTensor<uint8_t>();
        LocalTensor<uint8_t> dstLocal = outQueue_.AllocTensor<uint8_t>();

        CopyPadGmToUb(srcLocal, src, n);
        CopyPadGmToUb(ksLocal, ksPtr, n);

        inQueue_.EnQue(srcLocal);
        ksQueue_.EnQue(ksLocal);

        LocalTensor<uint8_t> srcIn = inQueue_.DeQue<uint8_t>();
        LocalTensor<uint8_t> ksIn = ksQueue_.DeQue<uint8_t>();

        const uint32_t vecBytes = (n / 2U) * 2U;
        const uint32_t elems16 = vecBytes / 2U;
        if (elems16 > 0U) {
            auto srcW = srcIn.ReinterpretCast<int16_t>();
            auto ksW = ksIn.ReinterpretCast<int16_t>();
            auto dstW = dstLocal.ReinterpretCast<int16_t>();
            Or(dstW, srcW, ksW, elems16);
            And(srcW, srcW, ksW, elems16);
            Sub(dstW, dstW, srcW, elems16);
        }
        for (uint32_t i = vecBytes; i < n; ++i) {
            dstLocal.SetValue(i, static_cast<uint8_t>(srcIn.GetValue(i) ^ ksIn.GetValue(i)));
        }

        inQueue_.FreeTensor(srcIn);
        ksQueue_.FreeTensor(ksIn);

        outQueue_.EnQue<uint8_t>(dstLocal);
        LocalTensor<uint8_t> outLocal = outQueue_.DeQue<uint8_t>();
        CopyPadUbToGm(dst, outLocal, n);
        outQueue_.FreeTensor(outLocal);
    }

private:
    TPipe pipe_;
    TQue<QuePosition::VECIN, kBufNum> inQueue_;
    TQue<QuePosition::VECIN, kBufNum> ksQueue_;
    TQue<QuePosition::VECOUT, kBufNum> outQueue_;
    __gm__ BarTaskQueue* queue_{nullptr};
    uint64_t ctlPacked_{0U};
};

extern "C" __global__ __aicore__ void AiccKeystreamXor(GM_ADDR queueGm, const uint64_t ctlPacked)
{
    KernelKsXorAiv op;
    op.Init(queueGm, ctlPacked);
    op.Process();
}
