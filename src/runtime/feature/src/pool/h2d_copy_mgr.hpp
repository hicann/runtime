/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_H2D_COPY_MGR_HPP
#define CCE_RUNTIME_H2D_COPY_MGR_HPP

#include <unordered_map>
#include "base.hpp"
#include "osal.hpp"
#include "rw_lock.h"
#include "driver/ascend_hal.h"
#include "buffer_allocator.hpp"

namespace cce {
namespace runtime {
class Device;
class Driver;

enum H2DCopyPolicy {
    COPY_POLICY_DEFAULT,
    COPY_POLICY_PCIE_BAR,
    COPY_POLICY_ASYNC_PCIE_DMA,
    COPY_POLICY_SYNC,
    COPY_POLICY_UB,
    COPY_POLICY_MAX
};

struct CpyAddrMgr {
    uint64_t devBaseAddr;
    uint64_t hostBaseAddr;
    uint64_t hostAddr;
    struct DMA_ADDR dmaAddr;
    bool isDma;
};

struct CpyDmaInfo {
    uint32_t cpyCount;
    uint32_t cpyItemSize;
    Device *device;
    mmRWLock_t *mapLock;
    std::unordered_map<uint64_t, CpyAddrMgr> cpyDmaMap;
};

struct CpyAddrUbMgr {
    uint64_t devBaseAddr;
    uint64_t hostBaseAddr;
    uint64_t hostAddr;
    uint32_t poolIndex;
};

struct memTsegInfo {
    struct halTsegInfo devTsegInfo;
    struct halTsegInfo hostTsegInfo;
};

struct CpyUbInfo {
    uint32_t cpyCount;
    uint32_t cpyItemSize;
    Device *device;
    mmRWLock_t *mapLock;
    std::unordered_map<uint64_t, CpyAddrUbMgr> cpyUbMap;
    uint32_t poolIndex;
    std::unordered_map<uint32_t, struct memTsegInfo *> memTsegInfoMap;
};

struct CpyHandle {
    volatile uint64_t copyStatus;
    void *devAddr;
    struct DMA_ADDR *dmaHandle;
    bool isDmaPool;
};

class H2DCopyMgr : public NoCopy {
public:
    H2DCopyMgr(Device * const dev, const uint32_t size, const uint32_t initCnt,
        const uint32_t maxCnt, const BufferAllocator::Strategy stg, H2DCopyPolicy policy);
    H2DCopyMgr(Device * const dev, H2DCopyPolicy policy);
    ~H2DCopyMgr() override;

    void Init(Device * const dev, const uint32_t size);
    void *AllocDevMem(const bool isLogError = true);
    void *AllocDevMem(const uint32_t size);
    void FreeDevMem(void *item);
    rtError_t H2DMemCopy(void *dst, const void * const src, const uint64_t size);
    rtError_t H2DMemCopyWaitFinish(void *devAddr);
    void *GetDevAddr(void *item) const;
    rtError_t ArgsPoolConvertAddr(void);

    H2DCopyPolicy GetPolicy(void) const
    {
        return policy_;
    }
    uint64_t GetUbHostAddr(const uint64_t devAddr, void **devTsegInfo, void **hostTsegInfo);
    static void *MallocUbBuffer(const size_t size, void * const para);
    static void FreeUbBuffer(void * const addr, void * const para);
private:
    static void *MallocBuffer(const size_t size, void * const para);
    static void FreeBuffer(void * const addr, void * const para);
    static void *MallocPcieBarBuffer(size_t size, void *para);
    static void FreePcieBarBuffer(void *addr, void *para);
    BufferAllocator *devAllocator_;
    BufferAllocator *handleAllocator_;
    Driver *drv_;
    Device *device_;
    bool isPiecBarSupport_;
    H2DCopyPolicy policy_;
    CpyDmaInfo cpyInfoDmaMap_;
    CpyUbInfo cpyInfoUbMap_;
    mmRWLock_t mapLock_;
};

rtError_t GetMemTsegInfo(const Device *const dev, void *devAddr, void *hostAddr, uint64_t size,
    struct halTsegInfo *devTsegInfo, struct halTsegInfo *hostTsegInfo);
}
}

#endif  // CCE_RUNTIME_H2D_COPY_MGR_HPP
