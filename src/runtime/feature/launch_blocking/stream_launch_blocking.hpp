/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_STREAM_LAUNCH_BLOCKING_HPP
#define CCE_RUNTIME_STREAM_LAUNCH_BLOCKING_HPP

#include <cstdint>
#include "base.hpp"
#include "osal.hpp"

namespace cce {
namespace runtime {

class Stream;

class StreamLaunchBlocking {
public:
    static rtError_t SetLaunchBlockingMode(Stream* const stm, const uint32_t mode);
    static rtError_t GetLaunchBlockingMode(const Stream* const stm, uint32_t* const mode);
    static rtError_t NonBlockingLaunchBegin(Stream* const stream);
    static rtError_t NonBlockingLaunchEnd(Stream* const stream);
    static bool IsNonBlockingLaunchActive(const Stream* const stm);
    static bool ShouldLaunchBlock(const Stream* const stm);

private:
    friend class Stream;
    StreamLaunchBlocking();

    void SetMode(uint32_t mode) { mode_.Set(mode); }
    uint32_t GetMode() const { return mode_.Value(); }
    void Begin() { nonBlockingDepth_.Add(1U); }
    bool End(bool& isNonBlockingSectionClosed);

    static rtError_t GetLaunchBlockingState(Stream* const stm, StreamLaunchBlocking*& launchBlockingState);
    static void ReleaseLaunchBlockingState(Stream* const stm);

    Atomic<uint32_t> mode_;
    Atomic<uint32_t> nonBlockingDepth_;
};

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_STREAM_LAUNCH_BLOCKING_HPP
