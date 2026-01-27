/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "h2d_copy_mgr.hpp"

#include "device.hpp"
#include "runtime.hpp"
#include "error_message_manage.hpp"
#include "device_snapshot.hpp"

namespace cce {
namespace runtime {
H2DCopyMgr::H2DCopyMgr(Device * const dev, const uint32_t size, const uint32_t initCnt,
    const uint32_t maxCnt, const BufferAllocator::Strategy stg, H2DCopyPolicy policy)
    : NoCopy(),
      devAllocator_(nullptr),
      handleAllocator_(nullptr),
      drv_(dev->Driver_()),
      device_(dev),
      isPiecBarSupport_(false),
      policy_(policy)
{
    Init(dev, size);
    cpyInfoDmaMap_.cpyDmaMap.clear();
    cpyInfoUbMap_.cpyUbMap.clear();
    (void)mmRWLockInit(&mapLock_);
    if (policy_ == COPY_POLICY_PCIE_BAR) {
        devAllocator_ = new (std::nothrow) BufferAllocator(size, initCnt, maxCnt,
            stg, &MallocPcieBarBuffer, &FreePcieBarBuffer, device_);
    } else if (policy_ == COPY_POLICY_ASYNC_PCIE_DMA) {
        cpyInfoDmaMap_.cpyCount = initCnt;
        cpyInfoDmaMap_.cpyItemSize = size;
        cpyInfoDmaMap_.device = device_;
        cpyInfoDmaMap_.mapLock = &mapLock_;
        devAllocator_ = new (std::nothrow) BufferAllocator(size, initCnt, maxCnt,
            stg,  &MallocBuffer, &FreeBuffer, &cpyInfoDmaMap_);
        handleAllocator_ = new (std::nothrow) BufferAllocator(sizeof(CpyHandle), initCnt, maxCnt);
    } else if (policy_ == COPY_POLICY_UB) {
        cpyInfoUbMap_.cpyCount = (initCnt < maxCnt) ? initCnt : maxCnt;
        cpyInfoUbMap_.cpyItemSize = size;
        cpyInfoUbMap_.device = device_;
        cpyInfoUbMap_.mapLock = &mapLock_;
        cpyInfoUbMap_.poolIndex = 0U;
        cpyInfoUbMap_.memTsegInfoMap.clear();
        devAllocator_ = new (std::nothrow) BufferAllocator(size, initCnt, maxCnt,
            stg,  &MallocUbBuffer, &FreeUbBuffer, &cpyInfoUbMap_);
    } else if (policy_ == COPY_POLICY_SYNC) {
        cpyInfoDmaMap_.cpyCount = 0U;
        cpyInfoDmaMap_.device = device_;
        devAllocator_ = new (std::nothrow) BufferAllocator(size, initCnt, maxCnt,
            stg,  &MallocBuffer, &FreeBuffer, &cpyInfoDmaMap_);
    } else {
        // no op
    }
    RT_LOG(RT_LOG_INFO, "alloc h2d copy buff success, policy %d", policy_);
}

H2DCopyMgr::H2DCopyMgr(Device * const dev, H2DCopyPolicy policy)
    : NoCopy(),
      devAllocator_(nullptr),
      handleAllocator_(nullptr),
      drv_(dev->Driver_()),
      device_(dev),
      isPiecBarSupport_(false),
      policy_(policy)
{
    cpyInfoDmaMap_.cpyDmaMap.clear();
    cpyInfoUbMap_.cpyUbMap.clear();
    (void)mmRWLockInit(&mapLock_);
}

H2DCopyMgr::~H2DCopyMgr()
{
    DELETE_O(devAllocator_);
    if (policy_ == COPY_POLICY_ASYNC_PCIE_DMA) {
        DELETE_O(handleAllocator_);
    }
    cpyInfoDmaMap_.cpyDmaMap.clear();
    cpyInfoUbMap_.cpyUbMap.clear();
    cpyInfoUbMap_.memTsegInfoMap.clear();
}

void H2DCopyMgr::Init(Device * const dev, const uint32_t size)
{
    if (policy_ == COPY_POLICY_UB) {
        return;
    }
    drv_ = dev->Driver_();
    uint32_t val = RT_CAPABILITY_NOT_SUPPORT;
    (void)drv_->CheckSupportPcieBarCopy(device_->Id_(), val, false);
    isPiecBarSupport_ = (val == RT_CAPABILITY_SUPPORT);

    if ((policy_ == COPY_POLICY_DEFAULT) || (policy_ == COPY_POLICY_PCIE_BAR)) {
        if (isPiecBarSupport_ && (size <= PCIE_BAR_COPY_SIZE)) {
            policy_ = COPY_POLICY_PCIE_BAR;
        } else {
            policy_ = COPY_POLICY_ASYNC_PCIE_DMA;
        }
    }

    if (policy_ == COPY_POLICY_ASYNC_PCIE_DMA) {
        Runtime * const rtInstance = Runtime::Instance();
        if ((drv_->GetRunMode() != RT_RUN_MODE_ONLINE) || !rtInstance->GetDisableThread() ||
            (&halMemcpySumbit == nullptr) || rtInstance->isRK3588HostCpu() || 
            (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MEM_H2D_MANAGER_POLICY_SYNC_FORCE))) {
            policy_ = COPY_POLICY_SYNC;
        }
    }

    if (size >= DMA_COPY_MAX_SIZE) {
        policy_ = COPY_POLICY_SYNC;
    }
#ifdef CFG_DEV_PLATFORM_PC
    policy_ = COPY_POLICY_SYNC;
#endif
    return;
}

void *H2DCopyMgr::AllocDevMem(const bool isLogError)
{
    if (unlikely(devAllocator_ == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "alloc devAllocator_ failed!");
        return nullptr;
    }
    if (unlikely(policy_ == COPY_POLICY_ASYNC_PCIE_DMA)) {
        if (handleAllocator_ == nullptr) {
            RT_LOG(RT_LOG_ERROR, "alloc handleAllocator_ failed!");
            return nullptr;
        }
        void *item = handleAllocator_->AllocItem();
        if (item == nullptr) {
            RT_LOG(RT_LOG_ERROR, "alloc handle item failed!");
            return nullptr;
        }
        CpyHandle *handle = static_cast<CpyHandle *>(item);
        handle->devAddr = devAllocator_->AllocItem();
        handle->copyStatus = ASYNC_COPY_STATU_INIT;
        return item;
    } else {
        return devAllocator_->AllocItem(isLogError);
    }
}

void *H2DCopyMgr::AllocDevMem(const uint32_t size)
{
    rtError_t error = RT_ERROR_NONE;
    void *addr = nullptr;
    error = drv_->DevMemAlloc(&addr, static_cast<uint64_t>(size), RT_MEMORY_HBM, device_->Id_());
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "DevMemAlloc failed, retCode=%#x", error);
        return nullptr;
    }
    return addr;
}

void *H2DCopyMgr::GetDevAddr(void *item) const
{
    if (unlikely(policy_ == COPY_POLICY_ASYNC_PCIE_DMA)) {
        if (item == nullptr) {
            RT_LOG(RT_LOG_ERROR, "item is null!");
            return nullptr;
        }
        CpyHandle *handle = static_cast<CpyHandle *>(item);
        return handle->devAddr;
    } else {
        return item;
    }
}

void H2DCopyMgr::FreeDevMem(void *item)
{
    if (item == nullptr) {
        RT_LOG(RT_LOG_ERROR, "free item is null!");
        return;
    }
    // devAllocator being null  means this is a random allocator;
    rtError_t error = RT_ERROR_NONE;
    if (unlikely(devAllocator_ == nullptr)) {
        RT_LOG(RT_LOG_INFO, "random allocator freeing device memory");
        error = drv_->DevMemFree(item, device_->Id_());
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "DevMemFree failed, retCode=%#x", error);
        }
        return;
    }

    if (policy_ == COPY_POLICY_ASYNC_PCIE_DMA) {
        CpyHandle *handle = static_cast<CpyHandle *>(item);
        if (handle->copyStatus != ASYNC_COPY_STATU_INIT) {
            if (handle->isDmaPool) {
                error = drv_->MemCopyAsyncWaitFinishEx(handle->dmaHandle);
            } else {
                error = drv_->MemCopyAsyncWaitFinish(handle->copyStatus);
            }
            if (error != RT_ERROR_NONE) {
                RT_LOG(RT_LOG_ERROR, "MemCopyAsyncWaitFinish for cpy result failed, retCode=%#x, isDmaPool=%d.",
                    error, handle->isDmaPool);
            }
            handle->copyStatus = ASYNC_COPY_STATU_INIT;
        }
        devAllocator_->FreeByItem(handle->devAddr);
        handleAllocator_->FreeByItem(item);
    } else {
        devAllocator_->FreeByItem(item);
    }
}

TIMESTAMP_EXTERN(rtKernelLaunch_MemCopyAsync);
TIMESTAMP_EXTERN(rtKernelLaunch_MemCopyPcie);
TIMESTAMP_EXTERN(rtKernelLaunch_MemCopyAsync_HostCpy);
TIMESTAMP_EXTERN(rtKernelLaunch_MemCopyAsync_DmaFind);
rtError_t H2DCopyMgr::H2DMemCopy(void *dst, const void * const src, const uint64_t size)
{
    rtError_t error = RT_ERROR_NONE;

    if (policy_ == COPY_POLICY_PCIE_BAR) {
        TIMESTAMP_BEGIN(rtKernelLaunch_MemCopyPcie);
        const errno_t ret = memcpy_s(dst, size, src, size);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_DRV_MEMORY,
            "Pcie bar memcpy failed, kind=%d, ret=%#x.", RT_MEMCPY_HOST_TO_DEVICE, static_cast<uint32_t>(ret));
        TIMESTAMP_END(rtKernelLaunch_MemCopyPcie);
    } else if (policy_ == COPY_POLICY_ASYNC_PCIE_DMA) {
        CpyHandle *handle = static_cast<CpyHandle *>(dst);
        const ReadProtect rp(&mapLock_);
        TIMESTAMP_BEGIN(rtKernelLaunch_MemCopyAsync_DmaFind);
        const auto iter = cpyInfoDmaMap_.cpyDmaMap.find(RtPtrToValue(handle->devAddr));
        if (iter == cpyInfoDmaMap_.cpyDmaMap.end()) {
            ERROR_RETURN_MSG_INNER(RT_ERROR_MEMORY_ALLOCATION, "can't find dma info by args device addr.");
        }
        TIMESTAMP_END(rtKernelLaunch_MemCopyAsync_DmaFind);
        handle->isDmaPool = iter->second.isDma;
        if (!(iter->second.isDma)) {
            RT_LOG(RT_LOG_WARNING, "dma convert failed, use Async copy, size=%" PRIu64 "(bytes)", size);
            error = drv_->MemCopyAsync(handle->devAddr, size, src, size,
                RT_MEMCPY_HOST_TO_DEVICE, handle->copyStatus);
            ERROR_RETURN_MSG_INNER(error, "Asynchronize memcpy failed, kind=%d, retCode=%#x.",
                RT_MEMCPY_HOST_TO_DEVICE, error);
            return RT_ERROR_NONE;
        }
        TIMESTAMP_BEGIN(rtKernelLaunch_MemCopyAsync_HostCpy);
        const errno_t ret = memcpy_s(RtValueToPtr<void *>(iter->second.hostAddr),
            size, src, size);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_DRV_MEMORY,
            "Pcie bar memcpy failed, kind=%d, ret=%#x.", RT_MEMCPY_HOST_TO_DEVICE, static_cast<uint32_t>(ret));
        handle->dmaHandle = &(iter->second.dmaAddr);
        TIMESTAMP_END(rtKernelLaunch_MemCopyAsync_HostCpy);
        TIMESTAMP_BEGIN(rtKernelLaunch_MemCopyAsync);
        error = drv_->MemCopyAsyncEx(handle->dmaHandle);
        ERROR_RETURN_MSG_INNER(error, "Asynchronize memcpy ex failed, kind=%d, retCode=%#x.",
            RT_MEMCPY_HOST_TO_DEVICE, error);
        TIMESTAMP_END(rtKernelLaunch_MemCopyAsync);
        handle->copyStatus = ASYNC_COPY_STATU_SUCC;
    } else if (policy_ == COPY_POLICY_SYNC) {
        error = drv_->MemCopySync(dst, size, src, size, RT_MEMCPY_HOST_TO_DEVICE);
        ERROR_RETURN_MSG_INNER(error, "Synchronize memcpy failed, kind=%d, retCode=%#x.",
            RT_MEMCPY_HOST_TO_DEVICE, error);
    } else {
        // no op
    }
    return error;
}

rtError_t H2DCopyMgr::H2DMemCopyWaitFinish(void *devAddr)
{
    if (policy_ == COPY_POLICY_ASYNC_PCIE_DMA) {
        CpyHandle *handle = static_cast<CpyHandle *>(devAddr);
        if (handle->copyStatus != ASYNC_COPY_STATU_INIT) {
            rtError_t error = RT_ERROR_NONE;
            if (handle->isDmaPool) {
                error = drv_->MemCopyAsyncWaitFinishEx(handle->dmaHandle);
            } else {
                error = drv_->MemCopyAsyncWaitFinish(handle->copyStatus);
            }
            handle->copyStatus = ASYNC_COPY_STATU_INIT;
            if (error != RT_ERROR_NONE) {
                RT_LOG(RT_LOG_ERROR, "MemCopyAsyncWaitFinish for cpy result failed, retCode=%#x, isDmaPool=%d.",
                    error, handle->isDmaPool);
                return error;
            }
        }
    }

    return RT_ERROR_NONE;
}

rtError_t H2DCopyMgr::ArgsPoolConvertAddr(void)
{
    const WriteProtect wp(cpyInfoDmaMap_.mapLock);
    Device * const dev = cpyInfoDmaMap_.device;
    for (auto iter = cpyInfoDmaMap_.cpyDmaMap.begin(); iter != cpyInfoDmaMap_.cpyDmaMap.end(); ++iter) {
        const uint64_t devAddr = iter->first;
        CpyAddrMgr &cpyAddr = iter->second;
        cpyAddr.dmaAddr.offsetAddr.devid = static_cast<uint32_t>(dev->Id_());
        const rtError_t error = dev->Driver_()->MemConvertAddr(cpyAddr.hostAddr, devAddr,
            static_cast<uint64_t>(cpyInfoDmaMap_.cpyItemSize), &cpyAddr.dmaAddr);
        ERROR_RETURN_MSG_INNER(error,
            "Convert memory address from virtual to dma physical failed, retCode=%#x.", error);
        RT_LOG(RT_LOG_DEBUG, "devAddr=%#llx, iter->second=%p, dmaAddr.phyAddr.priv=%p.",
            devAddr, iter->second.dmaAddr.phyAddr.priv, cpyAddr.dmaAddr.phyAddr.priv);
    }
    return RT_ERROR_NONE;
}

void *H2DCopyMgr::MallocBuffer(const size_t size, void * const para)
{
    void *addr = nullptr;
    CpyDmaInfo *cpyInfoDmaInfo = static_cast<CpyDmaInfo *>(para);
    Device * const dev = cpyInfoDmaInfo->device;
    (void)dev->Driver_()->DevMemAlloc(&addr, static_cast<uint64_t>(size), RT_MEMORY_HBM, dev->Id_());

    if ((cpyInfoDmaInfo->cpyCount != 0U) && (addr != nullptr)) {
        void *hostAddr = nullptr;
        (void)dev->Driver_()->HostMemAlloc(&hostAddr, static_cast<uint64_t>(size), dev->Id_());
        if (hostAddr == nullptr) {
            return addr;
        }
#ifdef __RT_ENABLE_ASAN__
        dev->Driver_()->MemSetSync(hostAddr, size, 0U, size);
#endif
        const WriteProtect wp(cpyInfoDmaInfo->mapLock);
        for (uint32_t item = 0U; item < cpyInfoDmaInfo->cpyCount; item++) {
            CpyAddrMgr cpyAddr;
            cpyAddr.devBaseAddr = RtPtrToValue(addr);
            cpyAddr.hostBaseAddr = RtPtrToValue(hostAddr);
            cpyAddr.hostAddr = cpyAddr.hostBaseAddr + item * static_cast<uint64_t>(cpyInfoDmaInfo->cpyItemSize);
            const uint64_t devAddr = cpyAddr.devBaseAddr + item * static_cast<uint64_t>(cpyInfoDmaInfo->cpyItemSize);
            struct DMA_ADDR dmaAddr;
            dmaAddr.offsetAddr.devid = static_cast<uint32_t>(dev->Id_());
            cpyAddr.isDma = false;
            if (dev->IsDmaCpyNumLimit()) {
                cpyInfoDmaInfo->cpyDmaMap[devAddr] = cpyAddr;
                continue;
            }
            const rtError_t error = dev->Driver_()->MemConvertAddr(cpyAddr.hostAddr, devAddr,
                static_cast<uint64_t>(cpyInfoDmaInfo->cpyItemSize), &dmaAddr);
            cpyAddr.dmaAddr = dmaAddr;
            if (error == RT_ERROR_NONE) {
                cpyAddr.isDma = true;
                dev->DmaCpyIncrease();
            }
            cpyInfoDmaInfo->cpyDmaMap[devAddr] = cpyAddr;
        }
    }
    return addr;
}

void H2DCopyMgr::FreeBuffer(void * const addr, void * const para)
{
    CpyDmaInfo *cpyInfoDmaInfo = static_cast<CpyDmaInfo *>(para);
    Device * const dev = cpyInfoDmaInfo->device;

    if (cpyInfoDmaInfo->cpyCount == 0U) {
        (void)dev->Driver_()->DevMemFree(addr, dev->Id_());
        return;
    }

    const ReadProtect rp(cpyInfoDmaInfo->mapLock);
    const auto iter = cpyInfoDmaInfo->cpyDmaMap.find(RtPtrToValue(addr));
    if ((iter != cpyInfoDmaInfo->cpyDmaMap.end())
        && (iter->second.devBaseAddr == RtPtrToValue(addr))) {
        for (uint32_t item = 0U; item < cpyInfoDmaInfo->cpyCount; item++) {
            const uint64_t devAddr = iter->second.devBaseAddr +
                item * static_cast<uint64_t>(cpyInfoDmaInfo->cpyItemSize);
            auto iter1 = cpyInfoDmaInfo->cpyDmaMap.find(devAddr);
            if ((iter1 != cpyInfoDmaInfo->cpyDmaMap.end()) && iter1->second.isDma) {
                (void)dev->Driver_()->MemDestroyAddr(&(iter1->second.dmaAddr));
                dev->DmaCpyDecrease();
            }
        }
        (void)dev->Driver_()->HostMemFree(RtValueToPtr<void *>(iter->second.hostBaseAddr));
    }

    (void)dev->Driver_()->DevMemFree(addr, dev->Id_());
}

void *H2DCopyMgr::MallocPcieBarBuffer(size_t size, void *para)
{
    void *addr = nullptr;
    void *outAddr = nullptr;
    const bool isLogError = (IS_SUPPORT_CHIP_FEATURE(Runtime::Instance()->GetChipType(), 
        RtOptionalFeatureType::RT_FEATURE_DFX_ARGS_DOT_ALLOC_ERROR_LOG));
    Device * const dev = static_cast<Device *>(para);
    rtError_t ret = dev->Driver_()->DevMemAlloc(&addr, static_cast<uint64_t>(size), RT_MEMORY_P2P_HBM, dev->Id_(),
        MODULEID_RUNTIME, isLogError);
    if (ret != RT_ERROR_NONE) {
        RtLogErrorLevelControl(isLogError, "alloc dev mem failed, retCode=%#x, size=%u(bytes), dev_id=%u.",
            ret, size, dev->Id_());
        return nullptr;
    }
    ret = dev->Driver_()->PcieHostRegister(addr, static_cast<uint64_t>(size), dev->Id_(), outAddr);
    if (ret != RT_ERROR_NONE) {
        (void)dev->Driver_()->DevMemFree(addr, dev->Id_());
        RT_LOG(RT_LOG_ERROR, "Pcie Host Register failed, retCode=%#x, size=%u(bytes), dev_id=%u.",
            ret, size, dev->Id_());
        return nullptr;
    }

    DeviceSnapshot *deviceSnapShot = dev->GetDeviceSnapShot();
    if (deviceSnapShot != nullptr) {
        deviceSnapShot->SetArgPcieBarAddr(addr);
        deviceSnapShot->SetArgPcieBarSize(size);
        RT_LOG(RT_LOG_DEBUG, "pcie bar addr=%p, size=%u(bytes), drv deviceId=%u.",
            addr, size, dev->Id_());
    }
    return addr;
}

void H2DCopyMgr::FreePcieBarBuffer(void *addr, void *para)
{
    if (addr != nullptr) {
        Device * const dev = static_cast<Device *>(para);
        (void)dev->Driver_()->PcieHostUnRegister(addr, dev->Id_());
        (void)dev->Driver_()->DevMemFree(addr, dev->Id_());
    }
}

uint64_t H2DCopyMgr::GetUbHostAddr(const uint64_t devAddr, void **devTsegInfo, void **hostTsegInfo)
{
    const ReadProtect rp(cpyInfoUbMap_.mapLock);
    const auto iter = cpyInfoUbMap_.cpyUbMap.find(devAddr);
    if (iter == cpyInfoUbMap_.cpyUbMap.end()) {
        RT_LOG(RT_LOG_ERROR, "Can't find ub info by args device addr.");
        return 0ULL;
    }
    uint32_t poolIndex = iter->second.poolIndex;
    const auto tsegInfo = cpyInfoUbMap_.memTsegInfoMap.find(poolIndex);
    if (tsegInfo == cpyInfoUbMap_.memTsegInfoMap.end()) {
        RT_LOG(RT_LOG_ERROR, "Can't find tseg info by pool index.");
        return 0ULL;
    }
    *devTsegInfo = static_cast<void *>(&(cpyInfoUbMap_.memTsegInfoMap[poolIndex]->devTsegInfo));
    *hostTsegInfo = static_cast<void *>(&(cpyInfoUbMap_.memTsegInfoMap[poolIndex]->hostTsegInfo));
    return iter->second.hostAddr;
}

rtError_t GetMemTsegInfo(const Device *const dev, void *devAddr, void *hostAddr, uint64_t size,
    struct halTsegInfo *devTsegInfo, struct halTsegInfo *hostTsegInfo)
{
    rtError_t ret = dev->Driver_()->GetTsegInfoByVa(dev->Id_(), RtPtrToValue(hostAddr), size,
        1U, hostTsegInfo);
    ERROR_PROC_RETURN_MSG_INNER(ret, (void)dev->Driver_()->HostMemFree(hostAddr);
                                     (void)dev->Driver_()->DevMemFree(devAddr, dev->Id_());,
                                       "host mem get segment failed, retCode=%#x, size=%lu, device_id=%u.",
                                       ret, size, dev->Id_());
    ret = dev->Driver_()->GetTsegInfoByVa(dev->Id_(), RtPtrToValue(devAddr), size, 0U, devTsegInfo);
    ERROR_PROC_RETURN_MSG_INNER(ret, (void)dev->Driver_()->HostMemFree(hostAddr);
                                     (void)dev->Driver_()->DevMemFree(devAddr, dev->Id_());,
                                       "dev mem get segment failed, retCode=%#x, size=%lu, device_id=%u.",
                                       ret, size, dev->Id_());
    return RT_ERROR_NONE;
}

void *H2DCopyMgr::MallocUbBuffer(const size_t size, void * const para)
{
    void *devAddr = nullptr;
    void *hostAddr = nullptr;
    void *tsegInfoAddr = nullptr;
    uint64_t devBlockAddr = 0;
    CpyUbInfo *cpyInfoUbInfo = static_cast<CpyUbInfo *>(para);
    Device * const dev = cpyInfoUbInfo->device;

    rtError_t ret = dev->Driver_()->DevMemAlloc(&devAddr, static_cast<uint64_t>(size), RT_MEMORY_HBM, dev->Id_());
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "alloc dev mem failed, retCode=%#x, size=%u(bytes), device_id=%u.",
            ret, size, dev->Id_());
        return nullptr;
    }
    ret = dev->Driver_()->HostMemAlloc(&hostAddr, static_cast<uint64_t>(size), dev->Id_());
    if (ret != RT_ERROR_NONE) {
        (void)dev->Driver_()->DevMemFree(devAddr, dev->Id_());
        RT_LOG(RT_LOG_ERROR, "alloc host mem failed, retCode=%#x, size=%u(bytes), device_id=%u.",
            ret, size, dev->Id_());
        return nullptr;
    }
    ret = dev->Driver_()->HostMemAlloc(&tsegInfoAddr, sizeof(struct memTsegInfo), dev->Id_());
    if (ret != RT_ERROR_NONE) {
        (void)dev->Driver_()->HostMemFree(hostAddr);
        (void)dev->Driver_()->DevMemFree(devAddr, dev->Id_());
        RT_LOG(RT_LOG_ERROR, "alloc mem for tseg info failed, retCode=%#x, size=%u(bytes), device_id=%u.",
            ret, sizeof(struct memTsegInfo), dev->Id_());
        return nullptr;
    }
    struct memTsegInfo *memInfo = (struct memTsegInfo *)tsegInfoAddr;
    ret = GetMemTsegInfo(dev, devAddr, hostAddr, static_cast<uint64_t>(size), &(memInfo->devTsegInfo),
        &(memInfo->hostTsegInfo));
    if (ret != RT_ERROR_NONE) {
        (void)dev->Driver_()->HostMemFree(tsegInfoAddr);
        RT_LOG(RT_LOG_ERROR, "get tseg info failed, retCode=%#x, size=%llu(bytes), device_id=%u.",
            ret, size, dev->Id_());
        return nullptr;
    }
    RT_LOG(RT_LOG_INFO, "Ub buffer alloc success, Runtime_alloc_size %u", size);
#ifdef __RT_ENABLE_ASAN__
    dev->Driver_()->MemSetSync(hostAddr, size, 0U, size);
#endif
    const WriteProtect wp(cpyInfoUbInfo->mapLock);
    for (uint32_t item = 0U; item < cpyInfoUbInfo->cpyCount; item++) {
        CpyAddrUbMgr cpyAddr;
        cpyAddr.devBaseAddr = RtPtrToValue(devAddr);
        cpyAddr.hostBaseAddr = RtPtrToValue(hostAddr);
        cpyAddr.hostAddr = cpyAddr.hostBaseAddr + item * static_cast<uint64_t>(cpyInfoUbInfo->cpyItemSize);
        devBlockAddr = cpyAddr.devBaseAddr + item * static_cast<uint64_t>(cpyInfoUbInfo->cpyItemSize);
        cpyAddr.poolIndex = cpyInfoUbInfo->poolIndex;
        cpyInfoUbInfo->cpyUbMap[devBlockAddr] = cpyAddr;
    }

    cpyInfoUbInfo->memTsegInfoMap[cpyInfoUbInfo->poolIndex] = memInfo;
    cpyInfoUbInfo->poolIndex++;
    return devAddr;
}

void H2DCopyMgr::FreeUbBuffer(void * const addr, void * const para)
{
    CpyUbInfo *cpyInfoUbInfo = static_cast<CpyUbInfo *>(para);
    Device * const dev = cpyInfoUbInfo->device;

    const ReadProtect rp(cpyInfoUbInfo->mapLock);
    const auto iter = cpyInfoUbInfo->cpyUbMap.find(RtPtrToValue(addr));
    if ((iter == cpyInfoUbInfo->cpyUbMap.end())
        || (iter->second.devBaseAddr != RtPtrToValue(addr))) {
        RT_LOG(RT_LOG_ERROR, "Invalid buffer addr.");
        return;
    }

    (void)dev->Driver_()->HostMemFree(
        RtValueToPtr<void *>(iter->second.hostBaseAddr));
    (void)dev->Driver_()->DevMemFree(addr, dev->Id_());
    uint32_t poolIndex = iter->second.poolIndex;
    const auto tsegInfo = cpyInfoUbInfo->memTsegInfoMap.find(poolIndex);
    if (tsegInfo == cpyInfoUbInfo->memTsegInfoMap.end()) {
        RT_LOG(RT_LOG_ERROR, "Can't find tseg info by pool index.");
        return;
    }
    (void)dev->Driver_()->PutTsegInfo(dev->Id_(),
        &(cpyInfoUbInfo->memTsegInfoMap[poolIndex]->hostTsegInfo));
    (void)dev->Driver_()->PutTsegInfo(dev->Id_(),
        &(cpyInfoUbInfo->memTsegInfoMap[poolIndex]->devTsegInfo));
    (void)dev->Driver_()->HostMemFree(cpyInfoUbInfo->memTsegInfoMap[poolIndex]);
    cpyInfoUbInfo->memTsegInfoMap[poolIndex] = nullptr;
    cpyInfoUbInfo->memTsegInfoMap.erase(poolIndex);
}
}  // namespace runtime
}  // namespace cce
