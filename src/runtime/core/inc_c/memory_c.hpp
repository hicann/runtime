/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_MEMORY_C_HPP__
#define __CCE_RUNTIME_MEMORY_C_HPP__

#include "stream.hpp"

namespace cce {
namespace runtime {

rtError_t MemWriteValue(const void* const devAddr, const uint64_t value, const uint32_t flag, Stream* const stm);
rtError_t MemWaitValue(const void* const devAddr, const uint64_t value, const uint32_t flag, Stream* const stm);
rtError_t ReduceAsync(
    void* const dst, const void* const src, const uint64_t cpySize, const rtRecudeKind_t kind, const rtDataType_t type,
    Stream* const stm, const rtTaskCfgInfo_t* const cfgInfo = nullptr);
rtError_t ReduceAsyncV2(
    void* const dst, const void* const src, const uint64_t cpySize, const rtRecudeKind_t kind, const rtDataType_t type,
    Stream* const stm, void* const overflowAddr);

rtError_t CheckMemAlign(const void* const addr, const rtDataType_t type);

} // namespace runtime
} // namespace cce

#endif
