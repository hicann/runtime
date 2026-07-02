/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "uvm_callback.hpp"
#include "base.hpp"
#include "npu_driver.hpp"
#include "api_impl.hpp"
#include "error_message_manage.hpp"
#include "inner_thread_local.hpp"

namespace cce {
namespace runtime {

void UvmCallback::MemsetAsyncCallback(void *fnData)
{
    NULL_PTR_RETURN_DIRECTLY(fnData);
    auto *params = static_cast<MemsetCallbackStruct*>(fnData);
    const rtError_t ret = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER)->
        MemSetSync(params->ptr, params->destMax, params->val, params->cnt);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "MemSetAsync failed when calling MemSetSync, ret is %u.", static_cast<uint32_t>(ret));
    }
    delete params;
    return;
}

void UvmCallback::MemcpyAsyncCallback(void *userData)
{
    RT_LOG(RT_LOG_DEBUG, "MemcpyAsync start callback.");
    NULL_PTR_RETURN_DIRECTLY(userData);
    auto* params = RtPtrToPtr<rtMemcpyCallbackParam*>(userData);
    rtMemcpyKind_t kindCov = static_cast<rtMemcpyKind_t>(params->kind);

    Stream * const stm = params->stm;
    Device* device = stm->Device_();
    Driver* driver = device->Driver_();

    if (device->IsSPM(params->dst)) {
        kindCov = (driver->GetRunMode() == static_cast<uint32_t>(RT_RUN_MODE_ONLINE)) ?
            RT_MEMCPY_HOST_TO_DEVICE : RT_MEMCPY_DEVICE_TO_DEVICE;
    }
    
    const rtError_t error = driver->MemCopySync(params->dst, params->destMax, params->src, params->cnt, kindCov);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Memcopy sync failed with code=%u dst=%p destMax=%u src=%p cnt=%u kind=%u", static_cast<uint32_t>(error), 
            params->dst, params->destMax, params->src, params->cnt, static_cast<uint32_t>(kindCov));
    }
    delete params;
}

bool UvmCallback::IsUvmMem(const void * const ptr, const uint64_t cnt)
{
    rtMemLocationType locationStart;
    rtMemLocationType realLocationStart;
    rtError_t ret = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER)->PtrGetRealLocation(ptr, locationStart, realLocationStart);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Failed to get mem start location, ret = %u.", static_cast<uint32_t>(ret));
        return false;
    }

    rtMemLocationType locationEnd;
    rtMemLocationType realLocationEnd;
    // 驱动申请内存地址范围为左闭右开，所以在进行UVM内存尾地址判断时需要ptr + cnt - 1
    ret = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER)->PtrGetRealLocation(
        static_cast<const void *>((static_cast<const char_t*>(ptr)) + cnt - 1), locationEnd, realLocationEnd);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Failed to get mem end location, ret = %u.", static_cast<uint32_t>(ret));
        return false;
    }

    if ((locationStart == RT_MEMORY_LOC_UVM_MANAGED) && (locationEnd == RT_MEMORY_LOC_UVM_MANAGED)) {
        return true;
    }

    return false;
}

void UvmCallback::CreateMemcpyCallbackParam(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
    const rtMemcpyKind_t kind, bool checkKind, Stream * const curStm, rtMemcpyCallbackParam* memcpyCallbackParam)
{
    memcpyCallbackParam->dst = dst;
    memcpyCallbackParam->destMax = destMax;
    memcpyCallbackParam->src = src;
    memcpyCallbackParam->cnt = cnt;
    memcpyCallbackParam->kind = kind;
    memcpyCallbackParam->checkKind = checkKind;
    memcpyCallbackParam->stm = curStm;
}

drv_uvm_location_type UvmCallback::ConvertUvmLocTypeToDrvUvmLocType(rtMemManagedLocationType const uvmLocType)
{
    switch (uvmLocType) {
        case rtMemLocationTypeHost:
            return DRV_UVM_LOCATION_TYPE_HOST;
        case rtMemLocationTypeDevice:
            return DRV_UVM_LOCATION_TYPE_DEVICE;
        case rtMemLocationTypeHostNuma:
            return DRV_UVM_LOCATION_TYPE_HOST_NUMA;
        case rtMemLocationTypeHostNumaCurrent:
            return DRV_UVM_LOCATION_TYPE_HOST_NUMA;
        default:
            return DRV_UVM_LOCATION_TYPE_INVALID;
    }
}

int32_t UvmCallback::ConvertUvmLocIdForHostNumaType(drv_uvm_location_type drvUvmLocType, int32_t oriDrvUvmLocId)
{
    // When location type is DRV_UVM_LOCATION_TYPE_HOST_NUM, runtime should pass (id + 1) to drv
    if (drvUvmLocType == DRV_UVM_LOCATION_TYPE_HOST_NUMA) {
        return oriDrvUvmLocId + 1;
    }
    return oriDrvUvmLocId;
}

rtError_t UvmCallback::ConvertUvmLocationStruct(drv_uvm_location& drvUvmLoc, rtMemManagedLocation& memManagedLoc)
{
    const drv_uvm_location_type tmpDrvUvmLocType = ConvertUvmLocTypeToDrvUvmLocType(memManagedLoc.type);
    if (tmpDrvUvmLocType == DRV_UVM_LOCATION_TYPE_INVALID) {
        return RT_ERROR_INVALID_VALUE;
    }

    const rtMemManagedLocationType memManagedLocType = memManagedLoc.type;
    int32_t drvUvmLocId = memManagedLoc.id;
    // For hostNumaCurrent type, runtime need to get numa node id related to current thread
    if (memManagedLocType == rtMemLocationTypeHostNumaCurrent) {
        COND_RETURN_WARN(&halGetCurrentThreadNumaNode == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
            "[drv api] halGetCurrentThreadNumaNode does not exist.");
        const int32_t currentNumaNode = static_cast<int32_t>(halGetCurrentThreadNumaNode());
        if (currentNumaNode == RT_INVALID_NUMA_NODE_ID) {
            RT_LOG(RT_LOG_ERROR, "[drv api] halGetCurrentThreadNumaNode get invalid numa node id: -1");
            return RT_ERROR_DRV_ERR;
        }
        drvUvmLocId = currentNumaNode;
    }

    drvUvmLoc.type = tmpDrvUvmLocType;
    drvUvmLoc.id = ConvertUvmLocIdForHostNumaType(tmpDrvUvmLocType, drvUvmLocId);
    return RT_ERROR_NONE;
}

void UvmCallback::PrefetchCallbackWrapper(void *userData)
{
    RT_LOG(RT_LOG_DEBUG, "enter PrefetchCallbackWrapper");
    NULL_PTR_RETURN_DIRECTLY(userData);

    PrefetchParams* params = static_cast<PrefetchParams*>(userData);

    if (params->ptr == 0) {
        RT_LOG(RT_LOG_ERROR, "Device pointer cannot be 0");
        DELETE_O(params);
        return;
    }

    if (params->location.type > DRV_UVM_LOCATION_TYPE_HOST_NUMA) {
        RT_LOG(RT_LOG_ERROR, "Invalid memory side");
        DELETE_O(params);
        return;
    }

    // halMemManagedPrefetch existance has been checked before sending hostFunc task.
    const drvError_t drvRet = halMemManagedPrefetch(params->ptr, params->size, params->location, params->flags);
    if (drvRet != RT_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemManagedPrefetch failed: size=%zu, loc_type=%u, loc_id=%d, flags=%u, "
            "drvRetCode=%d!", params->size, static_cast<uint32_t>(params->location.type), params->location.id,
            params->flags, static_cast<int32_t>(drvRet));
    }
    DELETE_O(params);
    return;
}

void UvmCallback::PrefetchBatchCallbackWrapper(void *userData)
{
    RT_LOG(RT_LOG_DEBUG, "enter PrefetchBatchCallbackWrapper");
    NULL_PTR_RETURN_DIRECTLY(userData);
    uint8_t* memBuffer = static_cast<uint8_t*>(userData);
    size_t tmpOffset = 0;
    const size_t count = *(RtPtrToPtr<size_t*>(userData));
    tmpOffset += sizeof(count);
    const size_t numPrefetchLocs = *(RtPtrToPtr<size_t*>(memBuffer + tmpOffset));
    tmpOffset += sizeof(numPrefetchLocs);
    const uint64_t flags = *(RtPtrToPtr<uint64_t*>(memBuffer + tmpOffset));
    tmpOffset += sizeof(flags);
    // Extract devPtrs
    DVdeviceptr* devPtrs = RtPtrToPtr<DVdeviceptr*>(memBuffer + tmpOffset);
    tmpOffset += count * sizeof(DVdeviceptr);
    // Extract size
    size_t* size = RtPtrToPtr<size_t*>(memBuffer + tmpOffset);
    tmpOffset += count * sizeof(size_t*);
    // Extract prefetchLocs
    drv_uvm_location* prefetchLocs = RtPtrToPtr<drv_uvm_location*>(memBuffer + tmpOffset);
    tmpOffset += numPrefetchLocs * sizeof(drv_uvm_location*);
    // Extract prefetchLocIdxs
    size_t* prefetchLocIdxs = RtPtrToPtr<size_t*>(memBuffer + tmpOffset);

    // halMemManagedPrefetchBatch existance has been checked before sending hostFunc task.
    const drvError_t drvRet = halMemManagedPrefetchBatch(devPtrs, size, count, prefetchLocs, prefetchLocIdxs,
        numPrefetchLocs, flags);
    if (drvRet != RT_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemManagedPrefetchBatch failed: count=%zu, numPrefetchLocs=%zu, "
            "flags=%lu, drvRetCode=%d!", count, numPrefetchLocs, flags, static_cast<int32_t>(drvRet));
    }
    DELETE_A(memBuffer);
    return;
}

} // namespace runtime
} // namespace cce

