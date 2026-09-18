/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aggregation.h"
#include "kernel_operator.h"

extern "C" __global__ __aicore__ void AggregateCounters(GM_ADDR input, GM_ADDR output, uint32_t hostAtomic)
{
    KERNEL_TASK_TYPE_DEFAULT(KERNEL_TYPE_AIV_ONLY);
    AscendC::TPipe pipe;
    AscendC::TBuf<AscendC::TPosition::VECCALC> buffer;
    pipe.InitBuffer(buffer, kCategoryCount * sizeof(int32_t));
    auto partial = buffer.Get<int32_t>();
    AscendC::GlobalTensor<int32_t> inputGm;
    AscendC::GlobalTensor<int32_t> outputGm;
    inputGm.SetGlobalBuffer(reinterpret_cast<__gm__ int32_t*>(input));
    outputGm.SetGlobalBuffer(reinterpret_cast<__gm__ int32_t*>(output));

    // Each block sums a disjoint set of records for all eight categories.
    for (uint32_t category = 0; category < kCategoryCount; ++category) {
        int32_t sum = 0;
        for (uint32_t record = AscendC::GetBlockIdx(); record < kRecordCount; record += AscendC::GetBlockNum()) {
            sum += inputGm.GetValue(record * kCategoryCount + category);
        }
        partial.SetValue(category, sum);
    }
    AscendC::PipeBarrier<PIPE_ALL>();

    // Only the capability-approved path atomically updates mapped Host memory.
    if (hostAtomic != 0) {
        AscendC::SetAtomicAdd<int32_t>();
        AscendC::DataCopy(outputGm, partial, kCategoryCount);
        AscendC::SetAtomicNone();
    } else {
        AscendC::DataCopy(outputGm[AscendC::GetBlockIdx() * kCategoryCount], partial, kCategoryCount);
    }
    AscendC::PipeBarrier<PIPE_ALL>();
}

int32_t AggregateCountersDo(uint32_t blockDim, void* stream, void* input, void* output, bool hostAtomic)
{
    return static_cast<int32_t>(AggregateCounters<<<blockDim, nullptr, stream>>>(
        static_cast<uint8_t*>(input), static_cast<uint8_t*>(output), static_cast<uint32_t>(hostAtomic)));
}
