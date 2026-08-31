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
constexpr uint32_t kHeight = 8;
constexpr uint32_t kWidth = 8;
constexpr uint32_t kDevicePitchElements = 16;
constexpr uint32_t kBufferElements = kDevicePitchElements * kHeight;
constexpr uint32_t kBufferBytes = kBufferElements * sizeof(uint16_t);
} // namespace

extern "C" __global__ __aicore__ void pitched_shift(GM_ADDR input, GM_ADDR output)
{
    AscendC::GlobalTensor<uint16_t> inputTensor;
    AscendC::GlobalTensor<uint16_t> outputTensor;
    inputTensor.SetGlobalBuffer(reinterpret_cast<__gm__ uint16_t*>(input), kBufferElements);
    outputTensor.SetGlobalBuffer(reinterpret_cast<__gm__ uint16_t*>(output), kBufferElements);

    AscendC::TPipe pipe;
    AscendC::TBuf<AscendC::TPosition::VECCALC> inputBuffer;
    AscendC::TBuf<AscendC::TPosition::VECCALC> outputBuffer;
    pipe.InitBuffer(inputBuffer, kBufferBytes);
    pipe.InitBuffer(outputBuffer, kBufferBytes);

    AscendC::LocalTensor<uint16_t> inputLocal = inputBuffer.Get<uint16_t>();
    AscendC::LocalTensor<uint16_t> outputLocal = outputBuffer.Get<uint16_t>();
    AscendC::DataCopy(inputLocal, inputTensor, kBufferElements);
    const AscendC::TEventID copyInEvent = pipe.FetchEventID(AscendC::HardEvent::MTE2_S);
    AscendC::SetFlag<AscendC::HardEvent::MTE2_S>(copyInEvent);
    AscendC::WaitFlag<AscendC::HardEvent::MTE2_S>(copyInEvent);

    for (uint32_t row = 0; row < kHeight; ++row) {
        for (uint32_t column = 0; column < kWidth; ++column) {
            const uint32_t sourceRow = (row + 1) % kHeight;
            const uint32_t sourceColumn = (column + 2) % kWidth;
            outputLocal.SetValue(
                row * kDevicePitchElements + column,
                inputLocal.GetValue(sourceRow * kDevicePitchElements + sourceColumn));
        }
    }

    const AscendC::TEventID copyOutEvent = pipe.FetchEventID(AscendC::HardEvent::S_MTE3);
    AscendC::SetFlag<AscendC::HardEvent::S_MTE3>(copyOutEvent);
    AscendC::WaitFlag<AscendC::HardEvent::S_MTE3>(copyOutEvent);
    AscendC::DataCopy(outputTensor, outputLocal, kBufferElements);
}
