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

namespace cce {
namespace runtime {

rtError_t SomaApi::StreamMemPoolCreate(rtMemPool_t *memPool, const rtMemPoolProps *poolProps)
{
    rtMemPoolProps curPoolProps = *poolProps;
    size_t freeSize = 0;
    size_t totalSize = 0;
    uint32_t phyDevId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(curPoolProps.devId, &phyDevId, false);
    ERROR_RETURN_MSG_INNER(error, "Convert user devId to physical devId failed! userDevId=%u, error Code=%u!",
        curPoolProps.devId, static_cast<uint32_t>(error));

    error = Runtime::Instance()->CurrentContext()->Device_()->Driver_()->MemGetInfoEx(phyDevId, 
        RT_MEMORYINFO_HBM, &freeSize, &totalSize);
    ERROR_RETURN_MSG_INNER(error, "Get device totalSize failed, deviceId=%u, retCode=%#x!",
        phyDevId, static_cast<uint32_t>(error));

    SegmentManager *retMemPool = nullptr;
    error = SomaApi::CreateMemPool(curPoolProps, totalSize, retMemPool);
    ERROR_RETURN(error, "Failed to create MemPool, size=%zu, error code=%u", curPoolProps.maxSize, error);

    RT_LOG(RT_LOG_DEBUG, "Allocate segment with basePtr %p and size %zu.", retMemPool->PoolSegAddr(), retMemPool->PoolSize());
    error = Runtime::Instance()->CurrentContext()->Device_()->Driver_()->StreamMemPoolCreate(retMemPool->DeviceId(),
        retMemPool->MemPoolId(), retMemPool->PoolSegAddr(), retMemPool->PoolSize(), false);
    if (error != RT_ERROR_NONE) {
        (void)SomaApi::DestroyMemPool(retMemPool);
        RT_LOG(RT_LOG_ERROR, "stream mem pool alloc failed in drv.");
        return error;
    }

    *memPool = RtPtrToPtr<rtMemPool_t>(retMemPool);
    RT_LOG(RT_LOG_DEBUG, "stream mem pool create success, memPool=%p.", memPool);
    return RT_ERROR_NONE;
}

rtError_t SomaApi::StreamMemPoolDestroy(const rtMemPool_t memPool)
{
    rtError_t error;
    SegmentManager *delMemPool = RtPtrToPtr<SegmentManager*>(memPool);
    error = SomaApi::CheckMemPool(delMemPool);
    ERROR_RETURN(error, "Failed to destroy memPoolId=%p", delMemPool);
    error = Runtime::Instance()->CurrentContext()->Device_()->Driver_()->StreamMemPoolDestroy(
        delMemPool->DeviceId(), delMemPool->MemPoolId());
    ERROR_RETURN(error, "Failed to destroy memPoolId in device, deviceId=",
        delMemPool->DeviceId(), delMemPool->MemPoolId());
    (void)SomaApi::DestroyMemPool(delMemPool);
    return error;
}

rtError_t SomaApi::StreamMemPoolSetAttr(rtMemPool_t memPool, rtMemPoolAttr attr, void *value)
{
    if (!PoolRegistry::Instance().QueryMemPool(RtPtrToPtr<SegmentManager *>(memPool))) {
        RT_LOG(RT_LOG_ERROR, "Memory pool is not created.");
        return RT_ERROR_INVALID_VALUE;
    }
    return RtPtrToPtr<SegmentManager *>(memPool)->SetAttribute(attr, value);
}

rtError_t SomaApi::StreamMemPoolGetAttr(rtMemPool_t memPool, rtMemPoolAttr attr, void *value)
{
    if (!PoolRegistry::Instance().QueryMemPool(RtPtrToPtr<SegmentManager *>(memPool))) {
        RT_LOG(RT_LOG_ERROR, "Memory pool is not created.");
        return RT_ERROR_INVALID_VALUE;
    }
    return RtPtrToPtr<SegmentManager *>(memPool)->GetAttribute(attr, value);
}

rtError_t SomaApi::CreateMemPool(rtMemPoolProps &poolProps, size_t totalSize, SegmentManager *&retMemPool)
{
    if (poolProps.maxSize == 0) {
        RT_LOG(RT_LOG_DEBUG, "Create stream memory pool by default maxSize.");
        // Align the memory pool size to DEVICE_POOL_ALIGN_SIZE with down-rounding
        poolProps.maxSize = totalSize & ~(DEVICE_POOL_ALIGN_SIZE - 1);
    } else {
        // Align the memory pool size to DEVICE_POOL_ALIGN_SIZE with up-rounding
        poolProps.maxSize = (poolProps.maxSize + DEVICE_POOL_ALIGN_SIZE - 1) & ~(DEVICE_POOL_ALIGN_SIZE - 1);
    }
    // Align the memory pool size to DEVICE_POOL_ALIGN_SIZE
    poolProps.maxSize = (poolProps.maxSize + DEVICE_POOL_ALIGN_SIZE - 1) & ~(DEVICE_POOL_ALIGN_SIZE - 1);

    COND_RETURN_ERROR(poolProps.maxSize > totalSize, RT_ERROR_MEMORY_ALLOCATION,
        "Memory pool size (%zu bytes) exceeds device total memory (%zu bytes).", poolProps.maxSize, totalSize);

    return PoolRegistry::Instance().CreateMemPool(poolProps.maxSize, poolProps.devId, true, retMemPool);
}

rtError_t SomaApi::CheckMemPool(SegmentManager *memPool)
{
    return PoolRegistry::Instance().CheckRemoveMemPool(memPool);
}

rtError_t SomaApi::DestroyMemPool(SegmentManager *memPool)
{
    return PoolRegistry::Instance().RemoveMemPool(memPool);
}

rtError_t SomaApi::AllocFromMemPool(void **ptr, uint64_t size, rtMemPool_t memPool, int32_t streamId)
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
    rtError_t error = curMemPool->SegmentAlloc(seg, size, streamId);
    COND_RETURN_ERROR((error != RT_ERROR_NONE || seg == nullptr), RT_ERROR_MEM_POOL_ALLOC,
        "Failed to allocate segment from memory pool, size=%" PRIx64 ", memPoolId=%" PRIx64 ", streamId=%d.",
        size, curMemPool->MemPoolId(), streamId);
 
    *ptr = RtValueToPtr<void *>(seg->basePtr);
    return RT_ERROR_NONE;
}
 
rtError_t SomaApi::FreeToMemPool(void *ptr)
{
    COND_RETURN_ERROR(ptr == nullptr, RT_ERROR_MEM_POOL_NULL, "Unable to free null pointer.");
    uint64_t p = RtPtrToValue(ptr);
    SegmentManager *curMemPool = PoolRegistry::Instance().FindMemPoolByPtr(ptr);
    COND_RETURN_ERROR(curMemPool == nullptr, RT_ERROR_POOL_PTR_NOTFOUND,
        "Unable to locate which memory pool the pointer is in, ptr=%" PRIx64 ".", p);
 
    rtError_t error = curMemPool->SegmentFree(p);
    ERROR_RETURN(error, "Unable to free ptr=%" PRIx64 ".", p);
 
    return RT_ERROR_NONE;
}
 
SegmentManager* SomaApi::FindMemPoolByPtr(void *ptr)
{
    return PoolRegistry::Instance().FindMemPoolByPtr(ptr);
}

} // namespace runtime
} // namespace cce