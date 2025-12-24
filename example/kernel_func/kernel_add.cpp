/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
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
    constexpr int32_t BUFFER_NUM = 2;  // tensor num for each queue

    class KernelAdd {
    public:
        __aicore__ inline KernelAdd() {}

        __aicore__ inline void Init(__gm__ float* srcA, __gm__ float* srcB, __gm__ float* dst, uint32_t totalSize)
        {
            blockIdx = GetBlockIdx();
            blockDim = GetBlockNum();
            elementsPerBlock = totalSize / blockDim;
            tileLength = elementsPerBlock / TILE_NUM / BUFFER_NUM;
            startIdx = blockIdx * elementsPerBlock;

            // Set the global buffer
            srcAGlobal.SetGlobalBuffer(srcA + startIdx, elementsPerBlock);
            srcBGlobal.SetGlobalBuffer(srcB + startIdx, elementsPerBlock);
            dstGlobal.SetGlobalBuffer(dst + startIdx, elementsPerBlock);

            // Initialize the pipe buffer
            pipe.InitBuffer(queueInA, BUFFER_NUM, tileLength * sizeof(float));
            pipe.InitBuffer(queueInB, BUFFER_NUM, tileLength * sizeof(float));
            pipe.InitBuffer(queueOut, BUFFER_NUM, tileLength * sizeof(float));
        }

        __aicore__ inline void Process()
        {
            int32_t loopCount = TILE_NUM * BUFFER_NUM;
            for (int32_t i = 0; i < loopCount; i++) {
                CopyIn(i);
                Compute(i);
                CopyOut(i);
            }
        }

    private:
        __aicore__ inline void CopyIn(int32_t progress)
        {
            LocalTensor<float> localA = queueInA.AllocTensor<float>();
            LocalTensor<float> localB = queueInB.AllocTensor<float>();

            DataCopy(localA, srcAGlobal[progress * tileLength], tileLength);
            DataCopy(localB, srcBGlobal[progress * tileLength], tileLength);
    
            queueInA.EnQue(localA);
            queueInB.EnQue(localB);
        }

        __aicore__ inline void Compute(int32_t progress)
        {
            LocalTensor<float> localA = queueInA.DeQue<float>();
            LocalTensor<float> localB = queueInB.DeQue<float>();
            LocalTensor<float> localOut = queueOut.AllocTensor<float>();

            Add(localOut, localA, localB, tileLength);

            queueOut.EnQue<float>(localOut);
            queueInA.FreeTensor(localA);
            queueInB.FreeTensor(localB);
        }

        __aicore__ inline void CopyOut(int32_t progress)
        {
            LocalTensor<float> localOut = queueOut.DeQue<float>();
            DataCopy(dstGlobal[progress * tileLength], localOut, tileLength);
            queueOut.FreeTensor(localOut);
        }

    private:
        TPipe pipe;
        TQue<QuePosition::VECIN, BUFFER_NUM> queueInA;
        TQue<QuePosition::VECIN, BUFFER_NUM> queueInB;
        TQue<QuePosition::VECOUT, BUFFER_NUM> queueOut;
        GlobalTensor<float> srcAGlobal;
        GlobalTensor<float> srcBGlobal;
        GlobalTensor<float> dstGlobal;

        uint32_t blockIdx;
        uint32_t blockDim;
        uint32_t elementsPerBlock;
        uint32_t startIdx;
        uint32_t tileLength;
        static constexpr int32_t TILE_NUM = 8; // split data into 8 tiles for each core
    };
} // namespace

extern "C" __global__ __aicore__ void AddKernel(__gm__ float* srcA, __gm__ float* srcB, __gm__ float* dst,
    uint32_t totalSize)
{
    KernelAdd op;
    op.Init(srcA, srcB, dst, totalSize);
    op.Process();
}

void AddDo(uint32_t blockDim, void* stream, float* srcA, float* srcB, float* dst, uint32_t totalSize)
{
    AddKernel<<<blockDim, nullptr, stream>>>(srcA, srcB, dst, totalSize);
}