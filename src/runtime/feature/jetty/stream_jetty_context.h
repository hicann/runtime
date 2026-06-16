/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_STREAM_JETTY_CONTEXT_H__
#define __CCE_RUNTIME_STREAM_JETTY_CONTEXT_H__

#include <cstdint>
#include <vector>
#include <memory>
#include "jetty_pool.h"

namespace cce {
namespace runtime {

class Driver;

struct StreamJettyContext {
    static constexpr uint32_t WQE_BUFFER_DEPTH = 2048U;
    static constexpr uint32_t WQE_SIZE = 64U;  // sizeof(rtDavidSqe_t)
    static constexpr uint32_t JETTY_DEPTH_MAX = 32768U;

    // Host WQE buffers, each chunk is WQE_BUFFER_DEPTH * WQE_SIZE bytes
    std::vector<std::unique_ptr<uint8_t[]>> wqeBuffers;

    uint32_t filledWqeCount = 0;
    uint32_t capacity = 0;

    // Record of tasks that need jetty info patch: (taskId, wqeCount)
    std::vector<std::pair<uint32_t, uint32_t>> taskWqeCounts;

    JettyType jettyType = JettyType::JETTY_TYPE_MAX;
    bool isLargeDepth = false;
    uint64_t jettyHandle = 0;

    uint8_t *GetNextWqeBuffer() const;
    rtError_t GrowBuffer(Driver *driver);
    rtError_t RoundUpCapacity(Driver *driver, uint32_t deviceId);
    void ReleaseBuffers(Driver *driver);

private:
    rtError_t AllocWqeBuffer(Driver *driver);
};

} // namespace runtime
} // namespace cce

#endif
