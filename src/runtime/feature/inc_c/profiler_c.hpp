/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_PROFILER_C_HPP__
#define __CCE_RUNTIME_PROFILER_C_HPP__

#include "profiler.hpp"

namespace cce {
namespace runtime {
    rtError_t ProfTraceEx(const uint64_t id, const uint64_t modelId, const uint16_t tagId, Stream *stm, 
        const Context *ctx);
    void ProfStart(Profiler * const profiler, const uint64_t profConfig, const uint32_t devId,
        const Device * const dev);
    void ProfStop(Profiler * const profiler, const uint64_t profConfig, const uint32_t devId,
        const Device * const dev);
    rtError_t DavidAllocAndSendFlipTask(Stream *const stream, uint32_t prePos, uint32_t sqeNum = 1U);
}  // namespace runtime
}  // namespace cce

#endif