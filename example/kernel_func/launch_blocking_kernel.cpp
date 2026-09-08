/*
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "kernel_operator.h"

using namespace AscendC;

namespace {
constexpr int32_t kTotalLength = 2048;
constexpr int32_t kCoreNum = 1;
constexpr int32_t kBlockLength = kTotalLength / kCoreNum;
constexpr int32_t kTileNum = 8;
constexpr int32_t kBufferNum = 2;
constexpr int32_t kTileLength = kBlockLength / kTileNum / kBufferNum * kBufferNum;
} // namespace

class LaunchBlockingKernel {
public:
    __aicore__ inline LaunchBlockingKernel() = default;

    __aicore__ inline void Init(GM_ADDR x, GM_ADDR y, GM_ADDR z, GM_ADDR loop)
    {
        xGm_.SetGlobalBuffer((__gm__ half*)x + kBlockLength * GetBlockIdx(), kBlockLength);
        yGm_.SetGlobalBuffer((__gm__ half*)y + kBlockLength * GetBlockIdx(), kBlockLength);
        zGm_.SetGlobalBuffer((__gm__ half*)z + kBlockLength * GetBlockIdx(), kBlockLength);
        loopGm_.SetGlobalBuffer((__gm__ uint64_t*)loop, 1);
        pipe_.InitBuffer(xQueue_, kBufferNum, kTileLength * sizeof(half));
        pipe_.InitBuffer(yQueue_, kBufferNum, kTileLength * sizeof(half));
        pipe_.InitBuffer(zQueue_, kBufferNum, kTileLength * sizeof(half));
    }

    __aicore__ inline void Process()
    {
        const uint64_t loopSpin = loopGm_.GetValue(0);
        for (int32_t tile = 0; tile < kTileNum; ++tile) {
            CopyIn(tile);
            Compute(loopSpin);
            CopyOut(tile);
        }
    }

private:
    __aicore__ inline void CopyIn(const int32_t tile)
    {
        LocalTensor<half> xLocal = xQueue_.AllocTensor<half>();
        LocalTensor<half> yLocal = yQueue_.AllocTensor<half>();
        DataCopy(xLocal, xGm_[tile * kTileLength], kTileLength);
        DataCopy(yLocal, yGm_[tile * kTileLength], kTileLength);
        xQueue_.EnQue(xLocal);
        yQueue_.EnQue(yLocal);
    }

    __aicore__ inline void Compute(const uint64_t loopSpin)
    {
        LocalTensor<half> xLocal = xQueue_.DeQue<half>();
        LocalTensor<half> yLocal = yQueue_.DeQue<half>();
        LocalTensor<half> zLocal = zQueue_.AllocTensor<half>();
        for (uint64_t i = 0; i < loopSpin; ++i) {
            Add(zLocal, xLocal, yLocal, kTileLength);
        }
        zQueue_.EnQue<half>(zLocal);
        xQueue_.FreeTensor(xLocal);
        yQueue_.FreeTensor(yLocal);
    }

    __aicore__ inline void CopyOut(const int32_t tile)
    {
        LocalTensor<half> zLocal = zQueue_.DeQue<half>();
        DataCopy(zGm_[tile * kTileLength], zLocal, kTileLength);
        zQueue_.FreeTensor(zLocal);
    }

    TPipe pipe_;
    TQue<QuePosition::VECIN, kBufferNum> xQueue_;
    TQue<QuePosition::VECIN, kBufferNum> yQueue_;
    TQue<QuePosition::VECOUT, kBufferNum> zQueue_;
    GlobalTensor<half> xGm_;
    GlobalTensor<half> yGm_;
    GlobalTensor<half> zGm_;
    GlobalTensor<uint64_t> loopGm_;
};

extern "C" __global__ __aicore__ void launch_blocking_kernel(GM_ADDR x, GM_ADDR y, GM_ADDR z, GM_ADDR loop)
{
    LaunchBlockingKernel kernel;
    kernel.Init(x, y, z, loop);
    kernel.Process();
}
