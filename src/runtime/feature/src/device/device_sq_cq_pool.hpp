/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_DEVICE_SQ_CQ_POOL_HPP
#define CCE_RUNTIME_DEVICE_SQ_CQ_POOL_HPP

#include <list>
#include <mutex>
#include "base.hpp"

namespace cce {
namespace runtime {
class Device;

typedef struct {
    uint32_t sqId;
    uint32_t cqId;
    uint64_t sqRegVirtualAddr;
} rtDeviceSqCqInfo_t;

class DeviceSqCqPool : public NoCopy {
public:
    explicit DeviceSqCqPool(Device * const dev);
    ~DeviceSqCqPool() override;

    rtError_t Init(void) const;
    void PreAllocSqCq(void);
    rtError_t AllocSqCq(const uint32_t allcocNum, rtDeviceSqCqInfo_t * const sqCqList);

    // Release sqcqs in bulk, only releasing them to the pool;
    // actual resources are not released to the driver, making it convenient for future requests of sqcqs.
    rtError_t FreeSqCqLazy(const rtDeviceSqCqInfo_t * const sqCqList, const uint32_t freeNum);

    // Release sqcq in batches, release them from the pool, and simultaneously call the driver interface to release them.
    rtError_t FreeSqCqImmediately(const rtDeviceSqCqInfo_t * const sqCqList, const uint32_t freeNum);

    rtError_t AllocSqCqFromDrv(rtDeviceSqCqInfo_t * const sqCqInfo) const;
    rtError_t BatchAllocSqCq(const uint32_t allcocNum);
    rtError_t FreeSqCqToDrv(const uint32_t sqId, const uint32_t cqId) const;
    rtError_t SetSqRegVirtualAddrToDevice(const uint32_t sqId, const uint64_t sqRegVirtualAddr) const;
    rtError_t AllocSqRegVirtualAddr(const uint32_t sqId, uint64_t &sqRegVirtualAddr) const;
    uint32_t GetSqCqPoolTotalResNum(void);
    uint32_t GetSqCqPoolFreeResNum(void);
    rtError_t TryFreeSqCqToDrv(void);

private:
    Device *device_;
    std::mutex deviceSqCqLock_;
    std::list<rtDeviceSqCqInfo_t> deviceSqCqFreeList_;
    std::list<rtDeviceSqCqInfo_t> deviceSqCqOccupyList_;
};

}  // namespace runtime
}  // namespace cce

#endif  // CCE_RUNTIME_DEVICE_SQ_CQ_POOL_HPP