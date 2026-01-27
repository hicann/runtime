/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_MEMCPY_C_HPP__
#define __CCE_RUNTIME_MEMCPY_C_HPP__

#include "runtime/mem.h"
#include "base.hpp"
#include "stream.hpp"

namespace cce {
namespace runtime {
    rtError_t MemcpyAsyncPtrForDavid(rtDavidMemcpyAddrInfo * const memcpyAddrInfo, const uint64_t count, Stream *stm,
        const rtTaskCfgInfo_t * const cfgInfo = nullptr);
    rtError_t Memcpy2DAsync(void * const dst, const uint64_t dstPitch, const void * const src, const uint64_t srcPitch,
        const uint64_t width, const uint64_t height, const rtMemcpyKind_t kind, uint64_t * const realSize,
        Stream * const stm, const uint64_t fixedSize);
    rtError_t MemcopyAsync(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cpySize,
        const rtMemcpyKind_t kind, Stream * const stm, uint64_t * const realSize,
        const std::shared_ptr<void> &guardMem = nullptr, const rtTaskCfgInfo_t * const cfgInfo = nullptr,
        const rtD2DAddrCfgInfo_t * const addrCfg = nullptr);
    rtError_t MemcpyReduceAsync(void * const dst, const void * const src, const uint64_t cpySize,
        const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm,
        const rtTaskCfgInfo_t * const cfgInfo = nullptr);
    rtError_t MemSetAsync(Stream * const stm, void * const ptr, const uint64_t destMax,
                          const uint32_t fillVal, const uint64_t fillCount);
}  // namespace runtime
}  // namespace cce

#endif