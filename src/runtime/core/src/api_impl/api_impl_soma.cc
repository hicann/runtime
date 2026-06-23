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
#include "api_impl_soma.hpp"
#include "base.hpp"
#include "stream.hpp"
#include "thread_local_container.hpp"
#include "dvpp_grp.hpp"
#include "inner_thread_local.hpp"
#include "soma.hpp"
#include "aicpu_c.hpp"
 
namespace cce {
namespace runtime {
 
rtError_t ApiImplSoma::StreamMemPoolCreate(rtMemPool_t *memPool, const rtMemPoolProps *poolProps)
{
    NULL_PTR_RETURN_MSG_OUTER(memPool, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(poolProps, RT_ERROR_INVALID_VALUE);
    RT_LOG(RT_LOG_DEBUG, "Stream memory pool create.");
    return SomaApi::StreamMemPoolCreate(memPool, poolProps);
}
 
rtError_t ApiImplSoma::StreamMemPoolDestroy(const rtMemPool_t memPool)
{
    NULL_PTR_RETURN_MSG_OUTER(memPool, RT_ERROR_INVALID_VALUE);
    RT_LOG(RT_LOG_DEBUG, "Stream memory pool destroy, poolId=%#" PRIx64 ".", RtPtrToValue(memPool));
    return SomaApi::StreamMemPoolDestroy(memPool);
}
 
rtError_t ApiImplSoma::StreamMemPoolSetAttr(rtMemPool_t memPool, rtMemPoolAttr attr, void *value)
{
    NULL_PTR_RETURN_MSG_OUTER(memPool, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(value, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR((attr == rtMemPoolAttrReservedMemCurrent) || (attr == rtMemPoolAttrUsedMemCurrent),
        RT_ERROR_POOL_OP_INVALID, "Read only attribute does not allow setting.");
    RT_LOG(RT_LOG_DEBUG, "Stream memory pool set attribute, poolId=%#" PRIx64 ", attr=%u.", RtPtrToValue(memPool), static_cast<uint32_t>(attr));
    return SomaApi::StreamMemPoolSetAttr(memPool, attr, value);
}
 
rtError_t ApiImplSoma::StreamMemPoolGetAttr(rtMemPool_t memPool, rtMemPoolAttr attr, void *value)
{
    NULL_PTR_RETURN_MSG_OUTER(memPool, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(value, RT_ERROR_INVALID_VALUE);
    RT_LOG(RT_LOG_DEBUG, "Stream memory pool get attribute, poolId=%#" PRIx64 ", attr=%u.", RtPtrToValue(memPool), static_cast<uint32_t>(attr));
    return SomaApi::StreamMemPoolGetAttr(memPool, attr, value);
}
 
rtError_t ApiImplSoma::MemPoolMallocAsync(void ** const devPtr, const uint64_t size, const rtMemPool_t memPoolId, Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(devPtr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(memPoolId, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_STREAM_NULL);
    Context * const curCtx = Runtime::Instance()->CurrentContext();
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM(stm, curCtx, RT_ERROR_STREAM_CONTEXT);
    
    const int32_t streamId = stm->Id_();
    RT_LOG(RT_LOG_DEBUG, "Memory allocation stream_id=%d.", streamId);

    // Align the allocation size to DEVICE_POOL_MIN_BLOCK_SIZE
    uint64_t aligned_size = (size + DEVICE_POOL_MIN_BLOCK_SIZE - 1) & ~(DEVICE_POOL_MIN_BLOCK_SIZE - 1);
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;
    rtError_t error = SomaApi::AllocFromMemPool(devPtr, aligned_size, memPoolId, streamId, flag);
    ERROR_RETURN_MSG_INNER(error, "Failed to allocate memory from pool, stream_id=%d, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    RT_LOG(RT_LOG_INFO, "Memory allocated success! Start ptr=0x%llx, end ptr=0x%llx",
        RtPtrToValue(*devPtr), (RtPtrToValue(*devPtr) + size));
    uint64_t va = RtPtrToValue(*devPtr);
    
    AicpuOpType opType = AicpuOpType::MALLOC;
    error = SomaAicpuKernelLaunch("SomaMemMng", aligned_size, va, memPoolId, stm, static_cast<int32_t>(opType), static_cast<int32_t>(flag));
    if (error != RT_ERROR_NONE) {
        (void)SomaApi::FreeToMemPool(RtValueToPtr<void*>(va));
        COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT);
        RT_LOG(RT_LOG_ERROR, "Soma malloc aicpu kernel launch failed, size=%" PRIu64 ", memPoolId=%#" PRIx64, size,
            RtPtrToValue<void*>(memPoolId));
    }
    return error;
}
 
rtError_t ApiImplSoma::MemPoolFreeAsync(void * const ptr, Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(ptr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_STREAM_NULL);
    Context * const curCtx = Runtime::Instance()->CurrentContext();
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM(stm, curCtx, RT_ERROR_STREAM_CONTEXT);
 
    RT_LOG(RT_LOG_DEBUG, "Free memory ptr=%#" PRIx64 ", stream_id=%d.", RtPtrToValue(ptr), stm->Id_());

    if (SomaApi::InMemPoolRegion(ptr)) {
        rtMemPool_t memPool = RtPtrToPtr<rtMemPool_t>(SomaApi::FindMemPoolByPtr(ptr));
        COND_RETURN_ERROR(memPool == nullptr, RT_ERROR_INVALID_VALUE, "Find mempool ptr == nullptr.");
        uint64_t va = RtPtrToValue(ptr);
        rtError_t error = SomaApi::FreeToMemPool(ptr);
        ERROR_RETURN_MSG_INNER(error, "Failed to free memory to pool, ptr=%#" PRIx64 ", stream_id=%d, retCode=%#x.",
            va, stm->Id_(), static_cast<uint32_t>(error));
        RT_LOG(
            RT_LOG_INFO, "The va is successfully released to the memory pool, ptr=%#" PRIx64 ", stream_id=%d.",
            RtPtrToValue(ptr), stm->Id_());

        AicpuOpType opType = AicpuOpType::FREE;
        SomaAicpuSubCmd subCmd = SomaAicpuSubCmd::FREE;
        error = SomaAicpuKernelLaunch("SomaMemMng", 0ULL, va, memPool, stm, static_cast<int32_t>(opType), static_cast<int32_t>(subCmd));
        COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT);
        ERROR_RETURN_MSG_INNER(error, "Failed to launch soma free aicpu kernel, va=%" PRIu64 ", memPoolId=%#" PRIx64 ", retCode=%#x.",
            va, RtPtrToValue<void*>(memPool), static_cast<uint32_t>(error));
        return error;
    } 

    RT_LOG(RT_LOG_INFO, "Pointer %#" PRIx64 " is not in SOMA memory pool range, assuming it's allocated by sync api.",
        RtPtrToValue(ptr));
    uint8_t *memBuffer = new (std::nothrow) uint8_t[sizeof(MemPoolFreeAsyncCallbackData)];
    COND_RETURN_AND_MSG_OUTER(memBuffer == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        ErrorCode::EE1013, std::to_string(sizeof(MemPoolFreeAsyncCallbackData)));
    MemPoolFreeAsyncCallbackData *params = RtPtrToPtr<MemPoolFreeAsyncCallbackData *>(memBuffer);
    params->ptr = ptr;
    params->stm = stm;
    RT_LOG(RT_LOG_DEBUG, "Register MemPoolFreeAsync callback with data ptr=%#" PRIx64 ", stream_id=%d.",
        RtPtrToValue(ptr), stm->Id_());
    rtError_t error = Runtime::Instance()->ApiImpl_()->LaunchHostFunc(stm, ApiImplSoma::MemPoolFreeAsyncCallback, RtPtrToPtr<void *>(memBuffer));
    if (error != RT_ERROR_NONE) {
        DELETE_A(memBuffer);
        RT_LOG(RT_LOG_ERROR, "Failed to register MemPoolFreeAsync callback, retCode=%#x.", static_cast<uint32_t>(error));
        return error;
    }
    return RT_ERROR_NONE;
}

void ApiImplSoma::MemPoolFreeAsyncCallback(void *fnData)
{
    COND_RETURN_VOID(fnData == nullptr, "MemPoolFreeAsync callback fn data is nullptr.");
    MemPoolFreeAsyncCallbackData *params = RtPtrToPtr<MemPoolFreeAsyncCallbackData *>(fnData);

    void *ptr = params->ptr;
    Stream *stm = params->stm;
    uint8_t *memBuffer = RtPtrToPtr<uint8_t *>(params);
    DELETE_A(memBuffer);
    RT_LOG(RT_LOG_INFO, "MemPoolFreeAsync callback with data ptr=%#" PRIx64 ", stream_id=%d.",
        RtPtrToValue(ptr), stm->Id_());

    Context *const ctx = stm->Context_();
    rtError_t error = ApiImpl::DevFreeStatic(ptr, ctx);
    COND_LOG_ERROR(error != RT_ERROR_NONE, "Failed to free physical memory, retCode=%#x ptr=%#" PRIx64 ".",
        static_cast<uint32_t>(error), RtPtrToValue(ptr));
}

rtError_t ApiImplSoma::SomaAicpuLaunchValidation(const rtKernelLaunchNames_t * const launchNames, const uint32_t blockDim,
    const rtArgsEx_t * const argsInfo, const Stream * const stm, const uint32_t flags) const
{
    NULL_PTR_RETURN_MSG_OUTER(launchNames->kernelName, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(argsInfo, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(argsInfo->args, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(argsInfo->argsSize);
 
    COND_RETURN_AND_MSG_OUTER(((stm->Flags() & RT_STREAM_CP_PROCESS_USE) != 0U),
        RT_ERROR_STREAM_INVALID, ErrorCode::EE1006, __func__, "Stream flags value " + std::to_string(stm->Flags()),
        RtFmtMsg("Stream %d with the flag RT_STREAM_CP_PROCESS_USE(0x800U) cannot be used for kernel launch", stm->Id_()));
    
    RT_LOG(RT_LOG_DEBUG,
           "Launch CPU kernel params: coreDim=%u, argsSize=%u, hostInputLen=%hu,"
           " flag=%u.", blockDim, argsInfo->argsSize, argsInfo->hostInputInfoNum, flags);
    ERROR_RETURN_MSG_INNER(Runtime::Instance()->StartAicpuSd(Runtime::Instance()->CurrentContext()->Device_()),
           "CPU kernel launch ex with args failed, check and start tsd open AICPU sd error.");
    COND_RETURN_WARN(&halMemPoolMalloc == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
    "[drv api] halMemPoolMalloc does not exist");
    COND_RETURN_WARN(&halMemPoolFree == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
    "[drv api] halMemFree does not exist");
    return RT_ERROR_NONE;
}
 
rtError_t ApiImplSoma::SomaAicpuKernelLaunch(const char *kernelName, const uint64_t size, const uint64_t va,
 	const rtMemPool_t memPool, Stream * const stm, const int32_t opType, const int32_t subCmd)
{   
    rtKernelLaunchNames_t launchNames;
    launchNames.kernelName = kernelName;
    launchNames.soName = nullptr;
    launchNames.opName = nullptr;
 
    SegmentManager* mempool = RtPtrToPtr<SegmentManager*>(memPool);
    
    AicpuPoolCtxArgs args;
    args.size = size;
    args.va = va;
    args.mempoolId = mempool->MemPoolId();
    args.deviceId = mempool->DeviceId();
    args.memAsyncOpType = opType;
    args.memAsyncSubCMD = subCmd;
    RT_LOG(RT_LOG_DEBUG,
        "AICPU arguments: Kernel Name: %s, Size: %" PRIu64 ", VA: %#" PRIx64 ", "
        "MemPool: %#" PRIx64 ", DeviceID: %u, MemAsyncOpType: %d, MemAsyncSubCMD: %d",
        launchNames.kernelName, args.size, args.va, args.mempoolId, args.deviceId, args.memAsyncOpType, args.memAsyncSubCMD);
 
    rtArgsEx_t rtArgs;
    (void)memset_s(&rtArgs, sizeof(rtArgs), 0, sizeof(rtArgs));
    rtArgs.args = &args;
    rtArgs.argsSize = sizeof(args);
    rtError_t error;
    error = SomaAicpuLaunchValidation(&launchNames, 1U, &rtArgs, stm, 0U);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_MSG_INNER(error, "Failed to validate soma aicpu launch params, retCode=%#x.", static_cast<uint32_t>(error));
    
    error = StreamLaunchCpuKernel(&launchNames, 1U, &rtArgs, stm, 0U);
    ERROR_RETURN_MSG_INNER(error, "Failed to launch soma aicpu kernel, retCode=%#x.", static_cast<uint32_t>(error));
 
    return RT_ERROR_NONE;
}
 
rtError_t ApiImplSoma::MemPoolTrimTo(rtMemPool_t memPool, uint64_t minBytesToKeep)
{
    return SomaApi::MemPoolTrimTo(memPool, minBytesToKeep);
}

rtError_t ApiImplSoma::MemPoolTrimImplicit(bool includeGraphPool)
{
    return SomaApi::MemPoolTrimImplicit(includeGraphPool);
}

bool ApiImplSoma::InMemPoolRegion(void * const ptr)
{
    return SomaApi::InMemPoolRegion(ptr);
}

rtError_t ApiImplSoma::MemPoolFreeSync(void* const ptr)
{
    return SomaApi::FreeToMemPool(ptr, true);
}

}  // namespace runtime
}  // namespace cce