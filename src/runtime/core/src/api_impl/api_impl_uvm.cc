/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl.hpp"
#include "base.hpp"
#include "osal.hpp"
#include "profiler.hpp"
#include "npu_driver.hpp"
#include "uvm_callback.hpp"

namespace cce {
namespace runtime {
rtError_t ApiImpl::MemManagedAdvise(const void *const ptr, uint64_t size, uint16_t advise, rtMemManagedLocation location)
{
    RT_LOG(RT_LOG_DEBUG, "MemManaged advise, size=%" PRIu64 ", advise=%u.", size, advise);
    Context *ctx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(ctx, RT_ERROR_CONTEXT_NULL);

    return ctx->Device_()->Driver_()->MemManagedAdvise(ptr, size, advise, location);
}

rtError_t ApiImpl::MemManagedGetAttr(rtMemManagedRangeAttribute attribute, const void *ptr, size_t size, void *data, size_t dataSize)
{
    RT_LOG(RT_LOG_DEBUG, "get memory attribute.");

    Context * const curCtx = CurrentContext();
    Driver *curDrv = nullptr;
    if (ContextManage::CheckContextIsValid(curCtx, true)) {
        const ContextProtect cp(curCtx);
        curDrv = curCtx->Device_()->Driver_();
    } else {
        curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    }
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
    return curDrv->MemManagedGetAttr(attribute, ptr, size, data, dataSize);
}

rtError_t ApiImpl::MemManagedGetAttrs(rtMemManagedRangeAttribute *attributes, size_t numAttributes, const void *ptr, size_t size, void **data, size_t *dataSizes)
{
    RT_LOG(RT_LOG_DEBUG, "get memory attributes.");
    Context * const curCtx = CurrentContext();
    Driver *curDrv = nullptr;

    const bool isContextValid = ContextManage::CheckContextIsValid(curCtx, true);
    if (!isContextValid) {
        curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    } else {
        const ContextProtect cp(curCtx);
        curDrv = curCtx->Device_()->Driver_();
    }
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
    return curDrv->MemManagedGetAttrs(attributes, numAttributes, ptr, size, data, dataSizes);
}

rtError_t ApiImpl::MemManagedPrefetchAsync(const void* ptr, size_t size, rtMemManagedLocation location,
    uint32_t flags, Stream* const stream)
{
    COND_RETURN_WARN((&halMemManagedPrefetch == nullptr), RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halMemManagedPrefetch does not exist.");
    PrefetchParams *params = new (std::nothrow) PrefetchParams;
    COND_RETURN_ERROR((params == nullptr), RT_ERROR_MEMORY_ALLOCATION,
        "New memory for params failed, mem size=%u", sizeof(PrefetchParams));

    rtError_t ret = UvmCallback::ConvertUvmLocationStruct(params->location, location);
    COND_PROC((ret == RT_ERROR_DRV_NOT_SUPPORT), DELETE_O(params));
    COND_RETURN_WITH_NOLOG((ret == RT_ERROR_DRV_NOT_SUPPORT), ret);
    COND_PROC_RETURN_ERROR_MSG_INNER((ret != RT_ERROR_NONE), ret, DELETE_O(params),
        "ConvertUvmLocationStruct failed, retCode=%#x", static_cast<uint32_t>(ret));

    params->ptr = RtPtrToPtr<DVdeviceptr>(ptr);
    params->size = size;
    params->flags = flags;

    ret = LaunchHostFunc(stream, UvmCallback::PrefetchCallbackWrapper, static_cast<void *>(params));
    ERROR_PROC_RETURN_MSG_INNER(ret, DELETE_O(params), "LaunchHostFunc fails with error code %#x",
        static_cast<uint32_t>(ret));
    return ret;
}

rtError_t ApiImpl::MemManagedPrefetchBatchAsync(const void** ptrs, size_t* sizes, size_t count,
    rtMemManagedLocation* prefetchLocs, size_t* prefetchLocIdxs, size_t numPrefetchLocs, uint64_t flags,
    Stream* const stream)
{
    COND_RETURN_WARN(&halMemManagedPrefetchBatch == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halMemManagedPrefetchBatch does not exist.");

    size_t bufferSize = sizeof(count) + sizeof(numPrefetchLocs) + sizeof(flags) + count * sizeof(DVdeviceptr) +
        count * sizeof(size_t) + numPrefetchLocs * sizeof(drv_uvm_location) + numPrefetchLocs * + sizeof(size_t);
    uint8_t *memBuffer = new (std::nothrow) uint8_t[bufferSize];
    COND_RETURN_ERROR((memBuffer == nullptr), RT_ERROR_MEMORY_ALLOCATION,
        "New memory for memBuffer failed, mem size=%u", bufferSize);

    size_t tmpOffset = 0;
    // Copy int data
    rtError_t ret = UvmCallback::FillIntParaIntoMemBuffer(count, memBuffer, bufferSize, tmpOffset);
    COND_PROC_RETURN_ERROR_MSG_INNER((ret != RT_ERROR_NONE), ret, DELETE_A(memBuffer), "Fill para count failed");
    ret = UvmCallback::FillIntParaIntoMemBuffer(numPrefetchLocs, memBuffer, bufferSize, tmpOffset);
    COND_PROC_RETURN_ERROR_MSG_INNER((ret != RT_ERROR_NONE), ret, DELETE_A(memBuffer), "Fill para numPrefetchLocs failed");
    ret = UvmCallback::FillIntParaIntoMemBuffer(flags, memBuffer, bufferSize, tmpOffset);
    COND_PROC_RETURN_ERROR_MSG_INNER((ret != RT_ERROR_NONE), ret, DELETE_A(memBuffer), "Fill para flags failed");

    // Copy array ptrs
    DVdeviceptr* devPtrArr = RtPtrToPtr<DVdeviceptr *>(memBuffer + tmpOffset);
    for (size_t index = 0; index < count; index++) {
        devPtrArr[index] = RtPtrToPtr<DVdeviceptr>(ptrs[index]);
    }
    tmpOffset += count * sizeof(DVdeviceptr);

    // Copy array sizes
    size_t arrSize = count * sizeof(size_t);
    errno_t err = memcpy_s(memBuffer + tmpOffset, arrSize, sizes, arrSize);
    COND_PROC_RETURN_ERROR_MSG_INNER((err != EOK), RT_ERROR_SEC_HANDLE, DELETE_A(memBuffer),
        "memcpy_s arr failed, retCode=%#x", static_cast<uint32_t>(err));
    tmpOffset += arrSize;

    // copy array prefetchLocs
    drv_uvm_location* drvUvmLocArr = RtPtrToPtr<drv_uvm_location *>(memBuffer + tmpOffset);
    for (size_t index = 0; index < numPrefetchLocs; index++) {
        ret = UvmCallback::ConvertUvmLocationStruct(drvUvmLocArr[index], prefetchLocs[index]);
        COND_PROC((ret == RT_ERROR_DRV_NOT_SUPPORT), DELETE_A(memBuffer));
        COND_RETURN_WITH_NOLOG((ret == RT_ERROR_DRV_NOT_SUPPORT), ret);
        COND_PROC_RETURN_ERROR_MSG_INNER((ret != RT_ERROR_NONE), ret, DELETE_A(memBuffer),
            "ConvertUvmLocationStruct failed, retCode=%#x", static_cast<uint32_t>(ret));
    }
    tmpOffset += numPrefetchLocs * sizeof(drv_uvm_location);

    // copy array prefetchLocIdxs
    arrSize = numPrefetchLocs * sizeof(size_t);
    err = memcpy_s(memBuffer + tmpOffset, arrSize, prefetchLocIdxs, arrSize);
    COND_PROC_RETURN_ERROR_MSG_INNER((err != EOK), RT_ERROR_SEC_HANDLE, DELETE_A(memBuffer),
        "memcpy_s arr failed, retCode=%#x", static_cast<uint32_t>(err));

    ret = LaunchHostFunc(stream, UvmCallback::PrefetchBatchCallbackWrapper, static_cast<void*>(memBuffer));
    ERROR_PROC_RETURN_MSG_INNER(ret, DELETE_A(memBuffer), "LaunchHostFunc fails with error code %#x",
        static_cast<uint32_t>(ret));
    return ret;
}

}  // namespace runtime
}  // namespace cce
