/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "memory_c.hpp"
#include "memcpy_c.hpp"
#include "memset_common.h"
#include "securec.h"
#include "enum_desc.hpp"
#include "inner_thread_local.hpp"
#include "context.hpp"
#include "device.hpp"
#include "reduce_task.h"
#include "task.hpp"

namespace cce {
namespace runtime {

TIMESTAMP_EXTERN(rtReduceAsyncV2_part1);
TIMESTAMP_EXTERN(rtReduceAsyncV2_part2);

rtError_t ReduceAsyncV2(void * const dst, const void * const src, const uint64_t cpySize,
    const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm, void * const overflowAddr)
{
    rtError_t error;
    TIMESTAMP_BEGIN(rtReduceAsyncV2_part1);
    Device * const dev = stm->Device_();
    Driver * const devDrv = dev->Driver_();
    const uint32_t deviceId = dev->Id_();

    if (devDrv != nullptr) {
        rtDevCapabilityInfo capabilityInfo = {};
        error = dev->GetDeviceCapabilities(capabilityInfo);
        ERROR_RETURN_MSG_INNER(error, "Get chip capability failed, device_id=%u, retCode=%#x.",
            deviceId, error);

        const uint32_t sdmaReduceSupport = capabilityInfo.sdma_reduce_support;
        const uint32_t offset = static_cast<uint32_t>(type);
        RT_LOG(RT_LOG_INFO, "ReduceAsyncV2 sdma_reduce_support=0x%x.", sdmaReduceSupport);
        if (((sdmaReduceSupport >> offset) & 0x1U) == 0U) {
            RT_LOG_OUTER_MSG_WITH_FUNC_DESC(ErrorCode::EE1006, "Performing asynchronous Reduce operations", "Parameter type value " + DataTypeToString(type),
                "The current SoC does not support the reduction operation of this data type");
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }
    TIMESTAMP_END(rtReduceAsyncV2_part1);

    TIMESTAMP_BEGIN(rtReduceAsyncV2_part2);
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtReduceAsyncV2Task = stm->AllocTask(&submitTask, TS_TASK_TYPE_REDUCE_ASYNC_V2, errorReason);
    NULL_PTR_RETURN_MSG(rtReduceAsyncV2Task, errorReason);

    std::function<void()> const reduceAsyncV2TaskRecycle = [&, rtReduceAsyncV2Task]() {
        (void)dev->GetTaskFactory()->Recycle(rtReduceAsyncV2Task);
    };
    ScopeGuard taskGuarder(reduceAsyncV2TaskRecycle);
    rtReduceAsyncV2Task->u.reduceAsyncV2TaskInfo.overflowAddrOffset = INVALID_CONTEXT_OVERFLOW_OFFSET;
    Context * const ctx = stm->Context_();
    if ((dev->GetTschVersion() >= static_cast<uint32_t>(TS_VERSION_REDUCV2_OPTIMIZE)) &&
        (RtPtrToValue<void *>(overflowAddr) == RtPtrToValue<void *>(ctx->CtxGetOverflowAddr()))) {
        rtReduceAsyncV2Task->u.reduceAsyncV2TaskInfo.overflowAddrOffset = ctx->CtxGetOverflowAddrOffset();
    }

    error = ReduceAsyncV2TaskInit(rtReduceAsyncV2Task, kind, src, dst, cpySize, overflowAddr);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    rtReduceAsyncV2Task->u.reduceAsyncV2TaskInfo.copyDataType = static_cast<uint8_t>(type);

    error = ctx->CheckMemAlign(src, type);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    error = ctx->CheckMemAlign(dst, type);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    error = dev->SubmitTask(rtReduceAsyncV2Task);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    GET_THREAD_TASKID_AND_STREAMID(rtReduceAsyncV2Task, stm->AllocTaskStreamId());
    taskGuarder.ReleaseGuard();
    TIMESTAMP_END(rtReduceAsyncV2_part2);
    return RT_ERROR_NONE;
}

rtError_t MemSetAsync(Stream * const stm, void * const ptr, const uint64_t destMax,
    const uint32_t fillVal, const uint64_t fillCount)
{
    rtPtrAttributes_t attributes;
    const rtError_t error = stm->Device_()->Driver_()->PtrGetAttributes(ptr, &attributes);
    ERROR_RETURN_MSG_INNER(error, "get pointer attribute failed, retCode=%#x.", error);
    RT_LOG(RT_LOG_DEBUG, "memset memory type is %u, fillVal=%u, fillCount=%" PRIu64 ", destMax=%" PRIu64 ".",
        attributes.location.type, fillVal, fillCount, destMax);

    if ((attributes.location.type == RT_MEMORY_LOC_HOST) ||
        (attributes.location.type == RT_MEMORY_LOC_UNREGISTERED)) {
        const errno_t ret = memset_s(ptr, destMax, static_cast<int32_t>(fillVal), fillCount);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_SEC_HANDLE,
            "Memset async failed, due to memset_s failed, destMax=%" PRIu64 ", fillCount=%" PRIu64 ", retCode=%d.",
            destMax, fillCount, ret);
    } else {
        COND_RETURN_ERROR_MSG_INNER(fillCount > destMax, RT_ERROR_INVALID_VALUE,
            "fillCount=%" PRIu64 " must be less than or equal to destMax=%" PRIu64 ".", fillCount, destMax);

        const DevProperties &props = stm->Device_()->GetDevProperties();
        if (IsSupportMemsetTask(attributes.location.id, stm->Device_()->Id_(), props)) {
            const uint32_t expandedFillVal = ExpandByteToU32(fillVal);
            return DevMemSetAsyncByMemset(stm, ptr, destMax, expandedFillVal, fillCount);
        } else {
            return DevMemSetAsyncByMemcpy(stm, ptr, destMax, fillVal, fillCount);
        }
    }

    return RT_ERROR_NONE;
}

rtError_t DevMemSetAsyncByMemcpy(Stream * const stm, void * const ptr,
    const uint64_t destMax, const uint32_t fillVal, const uint64_t fillCount)
{
    void *hostPtr = nullptr;
    std::shared_ptr<void> hostPtrGuard;
    const uint64_t setSize = (fillCount < MEM_BLOCK_SIZE) ? fillCount : MEM_BLOCK_SIZE;
    // Allocate host memory via driver interface instead of glibc malloc.
    // Driver-allocated host memory may be pre-pinned, reducing page fault latency on memset.
    Driver * const driver = stm->Device_()->Driver_();
    // 接口内会处理好字节对齐，这里不需要处理
    rtError_t error = driver->HostMemAlloc(&hostPtr, setSize, stm->Device_()->Id_());
    ERROR_RETURN(error, "Alloc host mem failed, size=%" PRIu64 ", retCode=%#x.",
        setSize, static_cast<uint32_t>(error));
    NULL_PTR_RETURN_MSG(hostPtr, RT_ERROR_MEMORY_ALLOCATION);
    // hostPtrGuard takes ownership: deleter calls HostMemFree on last reference.
    // Do NOT manually call HostMemFree after this point — shared_ptr handles it.
    hostPtrGuard.reset(hostPtr, [driver](void *p) { (void)driver->HostMemFree(p); });
    const errno_t ret = memset_s(hostPtr, setSize, static_cast<int32_t>(fillVal), setSize);
    if (ret != EOK) {
        RT_LOG(RT_LOG_ERROR, "memset_s failed, retCode=%d, size=%" PRIu64, ret, setSize);
        return RT_ERROR_SEC_HANDLE;
    }

    uint64_t remainSize = (fillCount < MEM_BLOCK_SIZE) ? fillCount : MEM_BLOCK_SIZE;
    uint64_t realSize = 0UL;
    uint64_t doneSize = 0UL;
    while (remainSize > 0ULL) {
        error = MemcopyAsync((RtPtrToPtr<char_t*, void*>(ptr)) + doneSize, destMax - doneSize,
            RtPtrToPtr<char_t*, void*>(hostPtr) + doneSize, remainSize, RT_MEMCPY_HOST_TO_DEVICE, stm, &realSize,
            hostPtrGuard);

        ERROR_RETURN_MSG_INNER(error, "Memcpy async step1 failed, retCode=%#x,"
            " max size=%" PRIu64 "(bytes), src size=%" PRIu64 "(bytes), type=%d.",
            error, destMax - doneSize, remainSize, RT_MEMCPY_HOST_TO_DEVICE);
        doneSize += realSize;
        remainSize -= realSize;
    }

    if (fillCount > MEM_BLOCK_SIZE) {
        const uint64_t memBlockNum = fillCount / MEM_BLOCK_SIZE;
        for (uint64_t idx = 1UL; idx < memBlockNum; idx++) {
            error = MemcopyAsync(
                RtPtrToPtr<char_t*, void*>(ptr) + (idx * MEM_BLOCK_SIZE), destMax - (idx * MEM_BLOCK_SIZE),
                RtPtrToPtr<char_t*, void*>(ptr), MEM_BLOCK_SIZE, RT_MEMCPY_DEVICE_TO_DEVICE, stm, &realSize);
            ERROR_RETURN_MSG_INNER(error, "Memcpy async step2 failed,"
                " max size=%" PRIu64 "(bytes), src size=%" PRIu64 "(bytes), type=%d.",
                destMax - (idx * MEM_BLOCK_SIZE), MEM_BLOCK_SIZE, RT_MEMCPY_DEVICE_TO_DEVICE);
        }

        const uint64_t memRemain = fillCount % MEM_BLOCK_SIZE;
        if (memRemain > 0ULL) {
            char_t * const dstAddr = (RtPtrToPtr<char_t *, void *>(ptr)) + (memBlockNum * MEM_BLOCK_SIZE);
            error = MemcopyAsync(dstAddr, destMax - (memBlockNum * MEM_BLOCK_SIZE), static_cast<char_t*>(ptr),
                memRemain, RT_MEMCPY_DEVICE_TO_DEVICE, stm, &realSize);
            ERROR_RETURN_MSG_INNER(error, "Memcpy async step3 failed,"
                " max size=%" PRIu64 "(bytes), src size=%" PRIu64 "(bytes), type=%d.",
                destMax - (memBlockNum * MEM_BLOCK_SIZE), memRemain, RT_MEMCPY_DEVICE_TO_DEVICE);
        }
    }

    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
