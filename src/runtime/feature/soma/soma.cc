/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "soma.hpp"
#include "stream_mem_pool.hpp"
#include "npu_driver.hpp"
#include "driver/ascend_hal_define.h"

namespace cce {
namespace runtime {

const char* SomaApi::MemPoolAttrToName(rtMemPoolAttr attr)
{
    switch (attr) {
        case rtMemPoolAttrReservedMemCurrent:
            return "rtMemPoolAttrReservedMemCurrent";
        case rtMemPoolAttrUsedMemCurrent:
            return "rtMemPoolAttrUsedMemCurrent";
        default:
            return "Unknown";
    }
}

rtError_t SomaApi::GetDevicePoolAlignSize(rtMemPoolProps &curPoolProps, size_t &alignSize)
{
    rtDrvMemProp_t prop = {};
    prop.devid = curPoolProps.devId;
    prop.side = curPoolProps.side;
    prop.mem_type = MEM_HBM_TYPE;
    prop.module_id = APP_MODE_ID;
    prop.pg_type = MEM_HUGE_PAGE_TYPE;
    prop.reserve = curPoolProps.reserve;

    size_t granularity = 0;
    const rtError_t error = NpuDriver::GetAllocationGranularity(&prop, RT_MEM_ALLOC_GRANULARITY_RECOMMENDED, &granularity);
    if (error == RT_ERROR_DRV_NOT_SUPPORT) {
        RT_LOG(RT_LOG_WARNING, "Get device memory allocation granularity not supported (error=%#x), "
            "fallback to default align size %zu.", static_cast<uint32_t>(error),
            static_cast<size_t>(DEVICE_POOL_ALIGN_SIZE));
        alignSize = DEVICE_POOL_ALIGN_SIZE;
        return RT_ERROR_NONE;
    }
    ERROR_RETURN(error, "Get device memory allocation granularity failed, error=%#x.",
        static_cast<uint32_t>(error));
    COND_RETURN_ERROR(granularity == 0, RT_ERROR_INVALID_VALUE,
        "Get device memory allocation granularity returned invalid value 0.");

    RT_LOG(RT_LOG_DEBUG, "Use device memory allocation granularity %zu as memory pool align size.", granularity);
    alignSize = granularity;
    return RT_ERROR_NONE;
}

rtError_t SomaApi::StreamMemPoolCreate(rtMemPool_t *memPool, const rtMemPoolProps *poolProps)
{
    rtError_t error = PoolRegistry::Instance().Init();
    ERROR_RETURN_MSG_INNER(error, "PoolRegistry init failed.");

    rtMemPoolProps curPoolProps = *poolProps;
    uint32_t phyDevId;
    error = Runtime::Instance()->ChgUserDevIdToDeviceId(curPoolProps.devId, &phyDevId, false);
    ERROR_RETURN_MSG_INNER(error, "Convert user devId to physical devId failed! userDevId=%u, error Code=%u!",
        curPoolProps.devId, static_cast<uint32_t>(error));

    size_t freeSize = 0;
    size_t totalSize = 0;
    error = Runtime::Instance()->CurrentContext()->Device_()->Driver_()->MemGetInfoEx(phyDevId,
        RT_MEMORYINFO_HBM, &freeSize, &totalSize);
    ERROR_RETURN_MSG_INNER(error, "Get device totalSize failed, deviceId=%u, retCode=%#x!",
        phyDevId, static_cast<uint32_t>(error));

    size_t alignSize = DEVICE_POOL_ALIGN_SIZE;
    error = GetDevicePoolAlignSize(curPoolProps, alignSize);
    ERROR_RETURN(error, "Get device memory pool align size failed, deviceId=%u.", phyDevId);

    error = SomaApi::AlignAndValidatePoolSize(curPoolProps, totalSize, alignSize);
    COND_RETURN_AND_MSG_OUTER(error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE, ErrorCode::EE1011, "Create memory pool",
        std::to_string(poolProps->maxSize / BYTES_PER_MB) + " MB", "rtMemPoolProps.maxSize",
        RtFmtMsg("The memory pool size after %zu MB alignment is %zu MB, which exceeds the available device memory %zu MB on the Device(device_id=%d)",
        alignSize / BYTES_PER_MB, curPoolProps.maxSize / BYTES_PER_MB, totalSize / BYTES_PER_MB, phyDevId));

    SegmentManager *retMemPool = PoolRegistry::Instance().CreateManager(nullptr, curPoolProps.devId, true);
    COND_RETURN_AND_MSG_OUTER(retMemPool == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, std::to_string(sizeof(SegmentManager)).c_str(), "new");

    uint64_t outVa = 0;
    error = Runtime::Instance()->CurrentContext()->Device_()->Driver_()->StreamMemPoolCreate(
        retMemPool->DeviceId(), retMemPool->MemPoolId(), curPoolProps.maxSize, false, outVa);
    if (error != RT_ERROR_NONE) {
        PoolRegistry::Instance().DeleteManager(retMemPool);
        RT_LOG(RT_LOG_ERROR, "Stream mem pool alloc failed in drv.");
        return error;
    }

    error = PoolRegistry::InitializeMemPool(retMemPool, outVa, curPoolProps.maxSize);
    if (error != RT_ERROR_NONE) {
        (void)Runtime::Instance()->CurrentContext()->Device_()->Driver_()->StreamMemPoolDestroy(
            retMemPool->DeviceId(), retMemPool->MemPoolId());
        PoolRegistry::Instance().DeleteManager(retMemPool);
        RT_LOG(RT_LOG_ERROR, "Stream mem pool initialize failed.");
        return error;
    }

    PoolRegistry::Instance().RegisterMemPool(retMemPool);
    *memPool = RtPtrToPtr<rtMemPool_t>(retMemPool);
    RT_LOG(RT_LOG_DEBUG, "stream mem pool create success, memPool=%p.", *memPool);
    return RT_ERROR_NONE;
}

rtError_t SomaApi::StreamMemPoolDestroy(rtMemPool_t const memPool)
{
    SegmentManager *delMemPool = RtPtrToPtr<SegmentManager*>(memPool);
    std::shared_ptr<SegmentManager> owned = PoolRegistry::Instance().QueryMemPool(delMemPool);
    COND_RETURN_ERROR(owned == nullptr, RT_ERROR_MEM_POOL_NULL,
        "Memory pool is not created or destroyed.");

    COND_RETURN_ERROR(!owned->CanDelete(), RT_ERROR_POOL_OP_INVALID,
        "Failed to destroy not deletable memPool(Id=%#" PRIx64 ").",
        owned->MemPoolId());

    const uint32_t deviceId = owned->DeviceId();
    const uint64_t poolId = owned->MemPoolId();
    rtError_t error = Runtime::Instance()->CurrentContext()->Device_()->Driver_()->StreamMemPoolDestroy(
        deviceId, poolId);
    ERROR_RETURN(error, "Failed to destroy memPoolId in device, deviceId=%u, memPoolId=%#" PRIx64,
        deviceId, poolId);

    error = PoolRegistry::Instance().RemoveMemPool(delMemPool, owned);
    ERROR_RETURN(error, "Failed to remove memPool handle=%p.", delMemPool);

    owned.reset();
    return error;
}

rtError_t SomaApi::StreamMemPoolSetAttr(rtMemPool_t memPool, rtMemPoolAttr attr, void *value)
{
    std::shared_ptr<SegmentManager> segMgr = PoolRegistry::Instance().QueryMemPool(RtPtrToPtr<SegmentManager *>(memPool));
    COND_RETURN_AND_MSG_OUTER(segMgr == nullptr, RT_ERROR_INVALID_VALUE, ErrorCode::EE1017,
        "Setting memory pool attribute", "memPool",
        RtFmtMsg("The specified memory pool %p is not created, please create the memory pool before setting its attributes", memPool));

    COND_RETURN_AND_MSG_OUTER((attr == rtMemPoolAttrReservedMemCurrent) || (attr == rtMemPoolAttrUsedMemCurrent), RT_ERROR_INVALID_VALUE,
        ErrorCode::EE1011, "Setting memory pool attribute", RtFmtMsg("%s(%u)", MemPoolAttrToName(attr), static_cast<uint32_t>(attr)),
        "This attribute is read-only and does not support setting");

    if ((attr == rtMemPoolReuseFollowEventDependencies) || (attr == rtMemPoolReuseAllowOpportunistic) ||
        (attr == rtMemPoolReuseAllowInternalDependencies)) {
        return segMgr->SetAttribute(attr, value);
    }

    Driver* const driver = Runtime::Instance()->CurrentContext()->Device_()->Driver_();
    const rtError_t error = driver->StreamMemPoolSetAttr(segMgr->DeviceId(), segMgr->MemPoolId(), attr, value);
    if (error == RT_ERROR_FEATURE_NOT_SUPPORT) {
        return segMgr->SetAttribute(attr, value);
    }
    return error;
}

rtError_t SomaApi::StreamMemPoolGetAttr(rtMemPool_t memPool, rtMemPoolAttr attr, void *value)
{
    std::shared_ptr<SegmentManager> segMgr = PoolRegistry::Instance().QueryMemPool(RtPtrToPtr<SegmentManager *>(memPool));
    COND_RETURN_AND_MSG_OUTER(segMgr == nullptr, RT_ERROR_INVALID_VALUE, ErrorCode::EE1017,
        "Getting memory pool attribute", "memPool",
        RtFmtMsg("The specified memory pool %p is not created, please create the memory pool before getting its attributes", memPool));

    if ((attr == rtMemPoolReuseFollowEventDependencies) || (attr == rtMemPoolReuseAllowOpportunistic) ||
        (attr == rtMemPoolReuseAllowInternalDependencies)) {
        return segMgr->GetAttribute(attr, value);
    }

    Driver* const driver = Runtime::Instance()->CurrentContext()->Device_()->Driver_();
    const rtError_t error = driver->StreamMemPoolGetAttr(segMgr->DeviceId(), segMgr->MemPoolId(), attr, value);
    if (error == RT_ERROR_FEATURE_NOT_SUPPORT) {
        return segMgr->GetAttribute(attr, value);
    }
    return error;
}

rtError_t SomaApi::AlignAndValidatePoolSize(rtMemPoolProps &poolProps, size_t totalSize, size_t alignSize)
{
    COND_RETURN_ERROR(alignSize == 0, RT_ERROR_INVALID_VALUE, "Invalid memory pool align size 0.");
    if (poolProps.maxSize == 0) {
        RT_LOG(RT_LOG_DEBUG, "Create stream memory pool by default maxSize.");
        // Align the memory pool size to alignSize with down-rounding
        poolProps.maxSize = (totalSize / alignSize) * alignSize;
    } else {
        // Align the memory pool size to alignSize with up-rounding
        poolProps.maxSize = ((poolProps.maxSize + alignSize - 1) / alignSize) * alignSize;
    }

    COND_RETURN_ERROR(poolProps.maxSize > totalSize, RT_ERROR_INVALID_VALUE,
        "Memory pool size (%zu bytes) exceeds device total memory (%zu bytes).", poolProps.maxSize, totalSize);
    return RT_ERROR_NONE;
}

rtError_t SomaApi::CheckMemPool(SegmentManager *memPool)
{
    return PoolRegistry::Instance().CheckRemoveMemPool(memPool);
}

rtError_t SomaApi::DestroyMemPool(SegmentManager *memPool)
{
    std::shared_ptr<SegmentManager> owned;
    const rtError_t error = PoolRegistry::Instance().RemoveMemPool(memPool, owned);
    if (error != RT_ERROR_NONE) {
        return error;
    }

    owned.reset();
    return error;
}

rtError_t SomaApi::AllocFromMemPool(void **ptr, uint64_t size, rtMemPool_t memPool, int32_t streamId, ReuseFlag &flag)
{
    COND_RETURN_ERROR(ptr == nullptr, RT_ERROR_MEM_POOL_NULL,
        "Output pointer cannot be null for memory allocation.");
    COND_RETURN_ERROR(memPool == nullptr, RT_ERROR_MEM_POOL_NULL,
        "Memory pool handle is invalid.");
    COND_RETURN_ERROR(streamId == INVALID_STREAM_ID, RT_ERROR_MEM_POOL_NULL,
        "Stream ID is invalid for memory allocation.");
 
    // Align the allocation size to DEVICE_POOL_MIN_BLOCK_SIZE
    size = (size + DEVICE_POOL_MIN_BLOCK_SIZE - 1) & ~(DEVICE_POOL_MIN_BLOCK_SIZE - 1);

    SegmentManager *curMemPool = RtPtrToPtr<SegmentManager *>(memPool);

    Segment *seg = nullptr;
    const rtError_t error = curMemPool->SegmentAlloc(seg, size, streamId, flag);
    COND_RETURN_ERROR((error != RT_ERROR_NONE || seg == nullptr), RT_ERROR_MEM_POOL_ALLOC,
        "Failed to allocate segment from memory pool, size=%#" PRIx64 ", memPoolId=%#" PRIx64 ", streamId=%d.",
        size, curMemPool->MemPoolId(), streamId);

    *ptr = RtValueToPtr<void *>(seg->basePtr);
    return RT_ERROR_NONE;
}

std::shared_ptr<SegmentManager> SomaApi::QueryMemPool(rtMemPool_t memPool)
{
    if (memPool == nullptr) {
        return nullptr;
    }
    return PoolRegistry::Instance().QueryMemPool(RtPtrToPtr<SegmentManager *>(memPool));
}

rtError_t SomaApi::FreeToMemPool(void *ptr, bool forceFree)
{
    COND_RETURN_ERROR(ptr == nullptr, RT_ERROR_MEM_POOL_NULL, "Unable to free null pointer.");
    std::shared_ptr<SegmentManager> curMemPool = SomaApi::FindMemPoolByPtr(ptr);
    COND_RETURN_ERROR(curMemPool == nullptr, RT_ERROR_POOL_PTR_NOTFOUND,
        "Unable to locate which memory pool the pointer is in, ptr=%#" PRIx64 ".", RtPtrToValue(ptr));

    const rtError_t error = curMemPool->SegmentFree(RtPtrToValue(ptr), forceFree);
    ERROR_RETURN(error, "Unable to free ptr=%#" PRIx64 ".", RtPtrToValue(ptr));

    return RT_ERROR_NONE;
}

void SomaApi::MemPoolAsyncConfig(rtMemPool_t memPool, uint64_t va, uint64_t size, bool flag)
{
    SegmentManager* mempool = RtPtrToPtr<SegmentManager*>(memPool);
    (void)Runtime::Instance()->CurrentContext()->Device_()->Driver_()->StreamMemPoolAsyncConfig(
        mempool->DeviceId(), mempool->MemPoolId(), va, size, flag);
}

rtError_t SomaApi::MemPoolTrimTo(rtMemPool_t memPool, uint64_t minBytesToKeep)
{
    COND_RETURN_ERROR(memPool == nullptr, RT_ERROR_INVALID_VALUE, "MemPoolTrimTo invalid memPool: nullptr.");

    std::shared_ptr<SegmentManager> curMemPool = PoolRegistry::Instance().QueryMemPool(RtPtrToPtr<SegmentManager *>(memPool));
    COND_RETURN_ERROR(curMemPool == nullptr, RT_ERROR_MEM_POOL_NULL, "Memory pool invalid or destroyed.");

    uint64_t poolBusySize = 0;
    uint64_t poolReservedSize = 0;
    uint32_t devId = curMemPool->DeviceId();
    uint64_t poolId = curMemPool->MemPoolId();
    uint64_t size = minBytesToKeep;

    RT_LOG(RT_LOG_INFO, "Start getting attribute of mempool.");
    rtError_t error = curMemPool->GetAttribute(rtMemPoolAttrUsedMemCurrent, &poolBusySize);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "Get used mem failed, ret=%d.", error);
    error = curMemPool->GetAttribute(rtMemPoolAttrReservedMemCurrent, &poolReservedSize);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "Get reserved mem failed, ret=%d.", error);
    COND_RETURN_ERROR(poolReservedSize < poolBusySize, RT_ERROR_INVALID_VALUE, "Invalid mempool state, poolReservedSize %lu < poolBusySize %lu.", poolReservedSize, poolBusySize);

    uint64_t poolFreeSize = poolReservedSize - poolBusySize;
    RT_LOG(RT_LOG_DEBUG, "Call halMemPoolTrim, size=%lu, poolBusySize=%lu, poolFreeSize=%lu.", size, poolBusySize, poolFreeSize);
    
    error = Runtime::Instance()->CurrentContext()->Device_()->Driver_()->StreamMemPoolTrim(devId, poolId, &size, poolBusySize, poolFreeSize);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "halMemPoolTrim failed, ret=%d.", error);

    if (size != minBytesToKeep) {
        RT_LOG(RT_LOG_DEBUG, "halMemPoolTrim target not reached (expect=%lu, actual=%lu).", minBytesToKeep, size);
    }
    error = curMemPool->TrimTo(size);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "TrimTo failed, ret=%d.", error);

    return RT_ERROR_NONE;
}

//Temporary workaround, will be restored later.
rtError_t SomaApi::MemPoolTrimImplicit(bool includeGraphPool)
{
    UNUSED(includeGraphPool);
    return RT_ERROR_NONE;
}

bool SomaApi::InMemPoolRegion(void * const ptr)
{
    uint64_t p = RtPtrToValue(ptr);
    return PoolRegistry::Instance().InMemPoolRegion(p);
}

std::shared_ptr<SegmentManager> SomaApi::FindMemPoolByPtr(void * const ptr)
{
    const uint64_t p = RtPtrToValue(ptr);
    return PoolRegistry::Instance().FindMemPoolByPtr(p);
}

uint64_t SomaApi::GetAllocSize(void * const ptr)
{
    std::shared_ptr<SegmentManager> segMgr = FindMemPoolByPtr(ptr);
    if (segMgr == nullptr) {
        return 0;
    }
    return segMgr->GetAllocSize(RtPtrToValue(ptr));
}

} // namespace runtime
} // namespace cce
