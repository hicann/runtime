/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_NPU_DRIVER_DCACHE_LOCK_HPP
#define CCE_RUNTIME_NPU_DRIVER_DCACHE_LOCK_HPP

#include "base.hpp"
#include "stream_factory.hpp"
#include "context.hpp"
namespace cce {
namespace runtime {
constexpr uint64_t DCACHE_LOCK_DEVICE_OFFSET = 64U * 1024U * 1024U;
void FreeDcacheAddr(const uint32_t deviceId, void *&dcacheAddr, void *&drvHandle);
rtError_t AllocAddrForDcache(const uint32_t deviceId, void *&dcacheAddr, const uint64_t size, void *&drvHandle);
rtError_t QueryDcacheLockStatus(uint32_t deviceId, uint32_t tsId, const void *dcacheAddr, bool &dCacheLockFlag);
rtError_t DcacheLockSendTask(Context *ctx, const uint32_t blockDim, const void * const funcAddr, Stream *stream);
}  // namespace runtime
}  // namespace cce

#endif
