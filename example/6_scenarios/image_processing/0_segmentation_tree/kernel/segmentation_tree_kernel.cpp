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
constexpr uint32_t kPixelCount = 64;
constexpr uint32_t kBufferBytes = kPixelCount * sizeof(uint8_t);
} // namespace

extern "C" __global__ __aicore__ void segmentation_tree(GM_ADDR pixels, GM_ADDR fine, GM_ADDR coarse)
{
    AscendC::GlobalTensor<uint8_t> pixelTensor;
    AscendC::GlobalTensor<uint8_t> fineTensor;
    AscendC::GlobalTensor<uint8_t> coarseTensor;
    pixelTensor.SetGlobalBuffer(reinterpret_cast<__gm__ uint8_t*>(pixels), kPixelCount);
    fineTensor.SetGlobalBuffer(reinterpret_cast<__gm__ uint8_t*>(fine), kPixelCount);
    coarseTensor.SetGlobalBuffer(reinterpret_cast<__gm__ uint8_t*>(coarse), kPixelCount);

    AscendC::TPipe pipe;
    AscendC::TBuf<AscendC::TPosition::VECCALC> pixelBuffer;
    AscendC::TBuf<AscendC::TPosition::VECCALC> fineBuffer;
    AscendC::TBuf<AscendC::TPosition::VECCALC> coarseBuffer;
    pipe.InitBuffer(pixelBuffer, kBufferBytes);
    pipe.InitBuffer(fineBuffer, kBufferBytes);
    pipe.InitBuffer(coarseBuffer, kBufferBytes);

    AscendC::LocalTensor<uint8_t> pixelLocal = pixelBuffer.Get<uint8_t>();
    AscendC::LocalTensor<uint8_t> fineLocal = fineBuffer.Get<uint8_t>();
    AscendC::LocalTensor<uint8_t> coarseLocal = coarseBuffer.Get<uint8_t>();
    AscendC::DataCopy(pixelLocal, pixelTensor, kPixelCount);
    const AscendC::TEventID copyInEvent = pipe.FetchEventID(AscendC::HardEvent::MTE2_S);
    AscendC::SetFlag<AscendC::HardEvent::MTE2_S>(copyInEvent);
    AscendC::WaitFlag<AscendC::HardEvent::MTE2_S>(copyInEvent);

    for (uint32_t index = 0; index < kPixelCount; ++index) {
        const uint8_t fineLabel = static_cast<uint8_t>(pixelLocal.GetValue(index) / 64);
        fineLocal.SetValue(index, fineLabel);
        coarseLocal.SetValue(index, static_cast<uint8_t>(fineLabel / 2));
    }

    const AscendC::TEventID copyOutEvent = pipe.FetchEventID(AscendC::HardEvent::S_MTE3);
    AscendC::SetFlag<AscendC::HardEvent::S_MTE3>(copyOutEvent);
    AscendC::WaitFlag<AscendC::HardEvent::S_MTE3>(copyOutEvent);
    AscendC::DataCopy(fineTensor, fineLocal, kPixelCount);
    AscendC::DataCopy(coarseTensor, coarseLocal, kPixelCount);
}
