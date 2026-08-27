/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "kernel_operator.h"

namespace {
constexpr int32_t TOTAL_LENGTH = 8 * 2048;
constexpr int32_t USE_CORE_NUM = 8;
constexpr int32_t BLOCK_LENGTH = TOTAL_LENGTH / USE_CORE_NUM;
constexpr int32_t TILE_NUM = 8;
constexpr int32_t BUFFER_NUM = 2;
constexpr int32_t TILE_LENGTH = BLOCK_LENGTH / TILE_NUM / BUFFER_NUM;

enum class BinaryOperation : uint8_t {
    ADD,
    SUB,
    MUL,
};
} // namespace

template <BinaryOperation operation>
class KernelBinary {
public:
    __aicore__ inline KernelBinary() {}

    __aicore__ inline void Init(GM_ADDR x, GM_ADDR y, GM_ADDR z)
    {
        xGm.SetGlobalBuffer((__gm__ half*)x + BLOCK_LENGTH * AscendC::GetBlockIdx(), BLOCK_LENGTH);
        yGm.SetGlobalBuffer((__gm__ half*)y + BLOCK_LENGTH * AscendC::GetBlockIdx(), BLOCK_LENGTH);
        zGm.SetGlobalBuffer((__gm__ half*)z + BLOCK_LENGTH * AscendC::GetBlockIdx(), BLOCK_LENGTH);
        pipe.InitBuffer(inQueueX, BUFFER_NUM, TILE_LENGTH * sizeof(half));
        pipe.InitBuffer(inQueueY, BUFFER_NUM, TILE_LENGTH * sizeof(half));
        pipe.InitBuffer(outQueueZ, BUFFER_NUM, TILE_LENGTH * sizeof(half));
    }

    __aicore__ inline void Process()
    {
        constexpr int32_t loopCount = TILE_NUM * BUFFER_NUM;
        for (int32_t i = 0; i < loopCount; i++) {
            CopyIn(i);
            Compute();
            CopyOut(i);
        }
    }

private:
    __aicore__ inline void CopyIn(int32_t progress)
    {
        AscendC::LocalTensor<half> xLocal = inQueueX.AllocTensor<half>();
        AscendC::LocalTensor<half> yLocal = inQueueY.AllocTensor<half>();
        AscendC::DataCopy(xLocal, xGm[progress * TILE_LENGTH], TILE_LENGTH);
        AscendC::DataCopy(yLocal, yGm[progress * TILE_LENGTH], TILE_LENGTH);
        inQueueX.EnQue(xLocal);
        inQueueY.EnQue(yLocal);
    }

    __aicore__ inline void Compute()
    {
        AscendC::LocalTensor<half> xLocal = inQueueX.DeQue<half>();
        AscendC::LocalTensor<half> yLocal = inQueueY.DeQue<half>();
        AscendC::LocalTensor<half> zLocal = outQueueZ.AllocTensor<half>();
        if constexpr (operation == BinaryOperation::ADD) {
            AscendC::Add(zLocal, xLocal, yLocal, TILE_LENGTH);
        } else if constexpr (operation == BinaryOperation::SUB) {
            AscendC::Sub(zLocal, xLocal, yLocal, TILE_LENGTH);
        } else {
            AscendC::Mul(zLocal, xLocal, yLocal, TILE_LENGTH);
        }
        outQueueZ.EnQue<half>(zLocal);
        inQueueX.FreeTensor(xLocal);
        inQueueY.FreeTensor(yLocal);
    }

    __aicore__ inline void CopyOut(int32_t progress)
    {
        AscendC::LocalTensor<half> zLocal = outQueueZ.DeQue<half>();
        AscendC::DataCopy(zGm[progress * TILE_LENGTH], zLocal, TILE_LENGTH);
        outQueueZ.FreeTensor(zLocal);
    }

private:
    AscendC::TPipe pipe;
    AscendC::TQue<AscendC::QuePosition::VECIN, BUFFER_NUM> inQueueX;
    AscendC::TQue<AscendC::QuePosition::VECIN, BUFFER_NUM> inQueueY;
    AscendC::TQue<AscendC::QuePosition::VECOUT, BUFFER_NUM> outQueueZ;
    AscendC::GlobalTensor<half> xGm;
    AscendC::GlobalTensor<half> yGm;
    AscendC::GlobalTensor<half> zGm;
};

extern "C" __global__ __aicore__ void add_custom(GM_ADDR x, GM_ADDR y, GM_ADDR z)
{
    KernelBinary<BinaryOperation::ADD> op;
    op.Init(x, y, z);
    op.Process();
}

extern "C" __global__ __aicore__ void sub_custom(GM_ADDR x, GM_ADDR y, GM_ADDR z)
{
    KernelBinary<BinaryOperation::SUB> op;
    op.Init(x, y, z);
    op.Process();
}

extern "C" __global__ __aicore__ void mul_custom(GM_ADDR x, GM_ADDR y, GM_ADDR z)
{
    KernelBinary<BinaryOperation::MUL> op;
    op.Init(x, y, z);
    op.Process();
}
