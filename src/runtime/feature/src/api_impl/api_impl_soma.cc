/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
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
    COND_RETURN_ERROR(devPtr == nullptr, RT_ERROR_INVALID_VALUE, "Invalid pointer for malloc pool async.");
    COND_RETURN_ERROR(memPoolId == nullptr, RT_ERROR_INVALID_VALUE, "Invalid mempoolid for malloc pool async.");
    COND_RETURN_ERROR(stm == nullptr, RT_ERROR_STREAM_NULL, "Invalid stream for malloc pool async.");
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != Runtime::Instance()->CurrentContext(), RT_ERROR_STREAM_CONTEXT,
        "Memory allocated failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    
    const int32_t streamId = stm->Id_();
    RT_LOG(RT_LOG_DEBUG, "Memory allocation stream_id=%d.", streamId);
 
    // Align the allocation size to DEVICE_POOL_MIN_BLOCK_SIZE
    uint64_t aligned_size = (size + DEVICE_POOL_MIN_BLOCK_SIZE - 1) & ~(DEVICE_POOL_MIN_BLOCK_SIZE - 1);
    rtError_t error = SomaApi::AllocFromMemPool(devPtr, aligned_size, memPoolId, streamId);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "AllocFromMemPool failed.");
    RT_LOG(RT_LOG_INFO, "Memory allocated success! Start ptr=0x%llx, end ptr=0x%llx", size, RtPtrToValue<void *>(memPoolId),
           RtPtrToValue(*devPtr), (RtPtrToValue(*devPtr) + size));
    uint64_t va = RtPtrToValue(*devPtr);
    
    AicpuOpType opType = AicpuOpType::MALLOC;
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;
    error = SomaAicpuKernelLaunch("SomaMemMng", aligned_size, va, memPoolId, stm, static_cast<int32_t>(opType), static_cast<int32_t>(flag));
    if (error != RT_ERROR_NONE) {
        (void)SomaApi::FreeToMemPool(RtValueToPtr<void*>(va));
        COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
        RT_LOG(RT_LOG_ERROR, "Soma malloc aicpu kernel launch failed, size=%" PRIu64 ", memPoolId=%" PRIx64, size,
            RtPtrToValue<void*>(memPoolId));
    }
    return error;
}
 
rtError_t ApiImplSoma::MemPoolFreeAsync(void * const ptr, Stream * const stm)
{
    COND_RETURN_ERROR(ptr == nullptr, RT_ERROR_INVALID_VALUE, "Invalid pointer for mempool free async.");
    COND_RETURN_ERROR(stm == nullptr, RT_ERROR_STREAM_NULL, "Invalid stream for mempool free async.");
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != Runtime::Instance()->CurrentContext(), RT_ERROR_STREAM_CONTEXT,
       "Memory free failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
 
    RT_LOG(RT_LOG_DEBUG, "Free memory ptr=%" PRIx64 ", stream_id=%d.", RtPtrToValue(ptr), stm->Id_());
 
    rtMemPool_t memPool = RtPtrToPtr<rtMemPool_t>(SomaApi::FindMemPoolByPtr(ptr));
    COND_RETURN_ERROR(memPool == nullptr, RT_ERROR_INVALID_VALUE, "Find mempool ptr == nullptr.");
    uint64_t va = RtPtrToValue(ptr);
    rtError_t error = SomaApi::FreeToMemPool(ptr);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to release va to the memory pool, ptr=%" PRIx64 ", stream_id=%d.",
        RtPtrToValue(ptr), stm->Id_());
    RT_LOG(
        RT_LOG_INFO, "The va is successfully released to the memory pool, ptr=%" PRIx64 ", stream_id=%d.",
        RtPtrToValue(ptr), stm->Id_());
 
    AicpuOpType opType = AicpuOpType::FREE;
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;
    error = SomaAicpuKernelLaunch("SomaMemMng", 0ULL, va, memPool, stm, static_cast<int32_t>(opType), static_cast<int32_t>(flag));
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Soma free aicpu kernel launch failed, va=%" PRIu64 ", memPoolId=%" PRIx64, va, RtPtrToValue<void*>(memPool));
    return error;
}
 
rtError_t ApiImplSoma::SomaAicpuLaunchValidation(const rtKernelLaunchNames_t * const launchNames, const uint32_t blockDim,
    const rtArgsEx_t * const argsInfo, const Stream * const stm, const uint32_t flags) const
{
    NULL_PTR_RETURN_MSG_OUTER(launchNames->kernelName, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(argsInfo, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(argsInfo->args, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(argsInfo->argsSize);
 
    COND_RETURN_OUT_ERROR_MSG_CALL(
        (stm->Flags() & RT_STREAM_CP_PROCESS_USE) != 0U,
        RT_ERROR_STREAM_INVALID,
        "CPU kernel launch ex with args failed, the stm can not be coprocessor stream flag=%u",
        stm->Flags()
    );
    
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
        "AICPU arguments: Kernel Name: %s, Size: %" PRIu64 ", VA: %" PRIx64 ", "
        "MemPool: %" PRIx64 ", DeviceID: %u, MemAsyncOpType: %d, MemAsyncSubCMD: %d",
        launchNames.kernelName, args.size, args.va, args.mempoolId, args.deviceId, args.memAsyncOpType, args.memAsyncSubCMD);
 
    rtArgsEx_t rtArgs;
    (void)memset_s(&rtArgs, sizeof(rtArgs), 0, sizeof(rtArgs));
    rtArgs.args = &args;
    rtArgs.argsSize = sizeof(args);
    rtError_t error;
    error = SomaAicpuLaunchValidation(&launchNames, 1U, &rtArgs, stm, 0U);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "Soma aicpu launch param validation failed, error code=[%d]", error);
    
    error = StreamLaunchCpuKernel(&launchNames, 1U, &rtArgs, stm, 0U);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "Soma aicpu launch failed error code=[%d]", error);
 
    return RT_ERROR_NONE;
}
 
}  // namespace runtime
}  // namespace cce