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
#include "context_manage.hpp"
#include "device.hpp"
#include "npu_driver.hpp"
#include "reduce_task.h"
#include "runtime.hpp"
#include "task.hpp"
#include "dev_info_manage.h"

namespace cce {
namespace runtime {

TIMESTAMP_EXTERN(rtReduceAsyncV2_part1);
TIMESTAMP_EXTERN(rtReduceAsyncV2_part2);

namespace {
constexpr uint64_t REDUCE_ALIGN_SIZE = 0x4ULL;
constexpr uint64_t REDUCE16_ALIGN_SIZE = 0x2ULL;

rtError_t CheckMemAddrAlign4B(const uint64_t memAddr)
{
    return ((memAddr % REDUCE_ALIGN_SIZE) != 0ULL) ? RT_ERROR_MEMORY_ADDRESS_UNALIGNED : RT_ERROR_NONE;
}

rtError_t CheckMemAddrAlign2B(const uint64_t memAddr)
{
    return ((memAddr % REDUCE16_ALIGN_SIZE) != 0ULL) ? RT_ERROR_MEMORY_ADDRESS_UNALIGNED : RT_ERROR_NONE;
}
} // namespace

rtError_t CheckMemAlign(const void* const addr, const rtDataType_t type)
{
    if ((type == RT_DATA_TYPE_FP16) || (type == RT_DATA_TYPE_INT16) || (type == RT_DATA_TYPE_UINT16) ||
        (type == RT_DATA_TYPE_BFP16)) {
        return CheckMemAddrAlign2B(RtPtrToValue<const void*>(addr));
    } else if ((type == RT_DATA_TYPE_FP32) || (type == RT_DATA_TYPE_INT32) || (type == RT_DATA_TYPE_UINT32)) {
        return CheckMemAddrAlign4B(RtPtrToValue<const void*>(addr));
    } else {
        return RT_ERROR_NONE;
    }
}

rtError_t GetPtrAttributes(const void* const ptr, rtPtrAttributes_t* const attributes)
{
    RT_LOG(RT_LOG_DEBUG, "get memory attribute.");
    Context* const curCtx = Runtime::Instance()->CurrentContext();
    Driver* curDrv = nullptr;
    if (!ContextManage::CheckContextIsValid(curCtx)) {
        curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    } else {
        curDrv = curCtx->Device_()->Driver_();
    }
    rtError_t error = curDrv->PtrGetAttributes(ptr, attributes);
    ERROR_RETURN(error, "failed to PtrGetAttributes, err:%#x", static_cast<uint32_t>(error));
    const rtMemLocationType locationType = attributes->location.type;
    if ((locationType == RT_MEMORY_LOC_DEVICE) || (locationType == RT_MEMORY_LOC_MANAGED)) {
        const uint32_t drvDeviceId = attributes->location.id;
        error = Runtime::Instance()->GetUserDevIdByDeviceId(drvDeviceId, &attributes->location.id);
        COND_RETURN_ERROR_MSG_INNER(
            error != RT_ERROR_NONE, error, "Failed to convert the driver device ID %u to user device ID, retCode=%#x",
            drvDeviceId, static_cast<uint32_t>(error));
    }
    return RT_ERROR_NONE;
}

rtError_t CheckMemAddrRangeValid(const void* const addr, const uint64_t size)
{
    COND_RETURN_ERROR(addr == nullptr, RT_ERROR_INVALID_VALUE, "Memory address is null.");
    COND_RETURN_ERROR(size == 0U, RT_ERROR_INVALID_VALUE, "Memory range size is 0.");

    uint64_t queryAddr = RtPtrToValue(addr);
    uint64_t remainingSize = size;
    while (remainingSize > 0U) {
        void* baseAddr = nullptr;
        size_t allocSize = 0U;
        void* const queryPtr = RtValueToPtr<void*>(queryAddr);
        const rtError_t error = NpuDriver::MemGetAddressRange(queryPtr, &baseAddr, &allocSize);
        ERROR_RETURN(
            error, "Failed to get memory address range, address=%p, size=%" PRIu64 ", retCode=%#x.", queryPtr,
            remainingSize, static_cast<uint32_t>(error));

        const uint64_t baseValue = RtPtrToValue(baseAddr);
        COND_RETURN_ERROR(
            queryAddr < baseValue, RT_ERROR_DRV_ERR,
            "Memory address is before allocation base, address=%p, allocation_base=%p.", queryPtr, baseAddr);

        const uint64_t offset = queryAddr - baseValue;
        COND_RETURN_ERROR(
            offset >= allocSize, RT_ERROR_DRV_ERR,
            "Memory address is outside allocation, address=%p, allocation_base=%p, allocation_size=%zu.", queryPtr,
            baseAddr, allocSize);

        const uint64_t availableSize = allocSize - offset;
        if (remainingSize <= availableSize) {
            return RT_ERROR_NONE;
        }
        queryAddr += availableSize;
        remainingSize -= availableSize;
    }
    return RT_ERROR_NONE;
}

rtError_t CheckMemCpyAttr(
    const void* const dst, const void* const src, const rtMemcpyBatchAttr& memAttr, rtPtrAttributes_t& dstAttr,
    rtPtrAttributes_t& srcAttr)
{
    rtMemLocationType memType;
    rtError_t error = GetPtrAttributes(dst, &dstAttr);
    ERROR_RETURN(error, "get dst attribute failed, error=%#x", error);
    memType = (dstAttr.location.type == RT_MEMORY_LOC_UNREGISTERED) ? RT_MEMORY_LOC_HOST : dstAttr.location.type;
    const rtMemLocationType inputDstType =
        (memAttr.dstLoc.type == RT_MEMORY_LOC_HOST_NUMA) ? RT_MEMORY_LOC_HOST : memAttr.dstLoc.type;
    COND_RETURN_AND_MSG_OUTER(
        ((memType != inputDstType) ||
         ((memType == RT_MEMORY_LOC_DEVICE) && (dstAttr.location.id != memAttr.dstLoc.id))),
        RT_ERROR_INVALID_VALUE, ErrorCode::EE1017, "Checking memory copy attributes", "dst",
        RtFmtMsg(
            "The input memory type %s and the actual memory type %s do not match,"
            " or the input device ID (device_id=%d) and the actual device ID (device_id=%d) do not match",
            MemLocationTypeToString(memAttr.dstLoc.type).c_str(),
            MemLocationTypeToString(dstAttr.location.type).c_str(), memAttr.dstLoc.id, dstAttr.location.id));

    error = GetPtrAttributes(src, &srcAttr);
    ERROR_RETURN(error, "get src attribute failed, error=%#x.", error);
    memType = (srcAttr.location.type == RT_MEMORY_LOC_UNREGISTERED) ? RT_MEMORY_LOC_HOST : srcAttr.location.type;
    const rtMemLocationType inputSrcType =
        (memAttr.srcLoc.type == RT_MEMORY_LOC_HOST_NUMA) ? RT_MEMORY_LOC_HOST : memAttr.srcLoc.type;
    COND_RETURN_AND_MSG_OUTER(
        ((memType != inputSrcType) ||
         ((memType == RT_MEMORY_LOC_DEVICE) && (srcAttr.location.id != memAttr.srcLoc.id))),
        RT_ERROR_INVALID_VALUE, ErrorCode::EE1017, "Checking memory copy attributes", "src",
        RtFmtMsg(
            "The input memory type %s and the actual memory type %s do not match,"
            " or the input device ID (device_id=%d) and the actual device ID (device_id=%d) do not match",
            MemLocationTypeToString(memAttr.srcLoc.type).c_str(),
            MemLocationTypeToString(srcAttr.location.type).c_str(), memAttr.srcLoc.id, srcAttr.location.id));

    return RT_ERROR_NONE;
}

rtError_t ReduceAsyncV2(
    void* const dst, const void* const src, const uint64_t cpySize, const rtRecudeKind_t kind, const rtDataType_t type,
    Stream* const stm, void* const overflowAddr)
{
    rtError_t error;
    TIMESTAMP_BEGIN(rtReduceAsyncV2_part1);
    Device* const dev = stm->Device_();
    Driver* const devDrv = dev->Driver_();
    const uint32_t deviceId = dev->Id_();

    if (devDrv != nullptr) {
        rtDevCapabilityInfo capabilityInfo = {};
        error = dev->GetDeviceCapabilities(capabilityInfo);
        ERROR_RETURN_MSG_INNER(error, "Get chip capability failed, device_id=%u, retCode=%#x.", deviceId, error);

        const uint32_t sdmaReduceSupport = capabilityInfo.sdma_reduce_support;
        const uint32_t offset = static_cast<uint32_t>(type);
        RT_LOG(RT_LOG_INFO, "ReduceAsyncV2 sdma_reduce_support=0x%x.", sdmaReduceSupport);
        if (((sdmaReduceSupport >> offset) & 0x1U) == 0U) {
            RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
                ErrorCode::EE1006, "Performing asynchronous Reduce operations",
                "Parameter type value " + DataTypeToString(type),
                "The current SoC does not support the reduction operation of this data type");
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }
    TIMESTAMP_END(rtReduceAsyncV2_part1);

    TIMESTAMP_BEGIN(rtReduceAsyncV2_part2);
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* rtReduceAsyncV2Task = stm->AllocTask(&submitTask, TS_TASK_TYPE_REDUCE_ASYNC_V2, errorReason);
    NULL_PTR_RETURN_MSG(rtReduceAsyncV2Task, errorReason);

    std::function<void()> const reduceAsyncV2TaskRecycle = [&, rtReduceAsyncV2Task]() {
        (void)dev->GetTaskFactory()->Recycle(rtReduceAsyncV2Task);
    };
    ScopeGuard taskGuarder(reduceAsyncV2TaskRecycle);
    rtReduceAsyncV2Task->u.reduceAsyncV2TaskInfo.overflowAddrOffset = INVALID_CONTEXT_OVERFLOW_OFFSET;
    Context* const ctx = stm->Context_();
    if ((dev->GetTschVersion() >= static_cast<uint32_t>(TS_VERSION_REDUCV2_OPTIMIZE)) &&
        (RtPtrToValue<void*>(overflowAddr) == RtPtrToValue<void*>(ctx->CtxGetOverflowAddr()))) {
        rtReduceAsyncV2Task->u.reduceAsyncV2TaskInfo.overflowAddrOffset = ctx->CtxGetOverflowAddrOffset();
    }

    error = ReduceAsyncV2TaskInit(rtReduceAsyncV2Task, kind, src, dst, cpySize, overflowAddr);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    rtReduceAsyncV2Task->u.reduceAsyncV2TaskInfo.copyDataType = static_cast<uint8_t>(type);

    const char* const expectedAlignment = ((type == RT_DATA_TYPE_FP16) || (type == RT_DATA_TYPE_INT16) ||
                                           (type == RT_DATA_TYPE_UINT16) || (type == RT_DATA_TYPE_BFP16)) ?
                                              "a 2-byte-aligned address" :
                                              "a 4-byte-aligned address";
    UNUSED(expectedAlignment);
    error = CheckMemAlign(src, type);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
        error != RT_ERROR_NONE, error, "Asynchronously performing the Reduce operation", src, "src", expectedAlignment);

    error = CheckMemAlign(dst, type);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
        error != RT_ERROR_NONE, error, "Asynchronously performing the Reduce operation", dst, "dst", expectedAlignment);

    error = dev->SubmitTask(rtReduceAsyncV2Task);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    GET_THREAD_TASKID_AND_STREAMID(rtReduceAsyncV2Task, stm->AllocTaskStreamId());
    taskGuarder.ReleaseGuard();
    TIMESTAMP_END(rtReduceAsyncV2_part2);
    return RT_ERROR_NONE;
}

rtError_t MemSetAsync(
    Stream* const stm, void* const ptr, const uint64_t destMax, const uint32_t fillVal, const uint64_t fillCount)
{
    rtPtrAttributes_t attributes;
    const rtError_t error = stm->Device_()->Driver_()->PtrGetAttributes(ptr, &attributes);
    ERROR_RETURN_MSG_INNER(error, "get pointer attribute failed, retCode=%#x.", error);
    RT_LOG(
        RT_LOG_DEBUG, "memset memory type is %s, fillVal=%u, fillCount=%" PRIu64 ", destMax=%" PRIu64 ".",
        MemLocationTypeToString(attributes.location.type).c_str(), fillVal, fillCount, destMax);

    if ((attributes.location.type == RT_MEMORY_LOC_HOST) || (attributes.location.type == RT_MEMORY_LOC_UNREGISTERED)) {
        const errno_t ret = memset_s(ptr, destMax, static_cast<int32_t>(fillVal), fillCount);
        COND_RETURN_AND_MSG_OUTER(
            ret != EOK, RT_ERROR_SEC_HANDLE, ErrorCode::EE1020, "Asynchronous memory set", "memset_s",
            std::to_string(ret), strerror(ret),
            RtFmtMsg("devPtr=%p, maxCount=%" PRIu64 ", count=%" PRIu64 ".", ptr, destMax, fillCount));
    } else {
        COND_RETURN_ERROR_MSG_INNER(
            fillCount > destMax, RT_ERROR_INVALID_VALUE,
            "fillCount=%" PRIu64 " must be less than or equal to destMax=%" PRIu64 ".", fillCount, destMax);

        const DevProperties& props = stm->Device_()->GetDevProperties();
        if (IsSupportMemsetTask(attributes.location.id, stm->Device_()->Id_(), props)) {
            return DevMemSetAsyncByMemset(stm, ptr, destMax, fillVal, fillCount);
        } else {
            return DevMemSetAsyncByMemcpy(stm, ptr, destMax, fillVal, fillCount);
        }
    }

    return RT_ERROR_NONE;
}

rtError_t DevMemSetAsyncByMemcpy(
    Stream* const stm, void* const ptr, const uint64_t destMax, const uint32_t fillVal, const uint64_t fillCount)
{
    DevDynInfoProcFunc func{};
    if ((GET_DEV_INFO_PROC_FUNC(Runtime::Instance()->GetChipType(), func) == RT_ERROR_NONE) &&
        (func.memProcFunc.devMemsetAsync != nullptr)) {
        const rtError_t callbackError = func.memProcFunc.devMemsetAsync(stm, ptr, destMax, fillVal, fillCount);
        COND_RETURN_WITH_NOLOG(callbackError != RT_ERROR_CONTINUE_EXECUTE, callbackError);
    }
    void* hostPtr = nullptr;
    std::shared_ptr<void> hostPtrGuard;
    const uint64_t setSize = (fillCount < MEM_BLOCK_SIZE) ? fillCount : MEM_BLOCK_SIZE;
    // Allocate host memory via driver interface instead of glibc malloc.
    // Driver-allocated host memory may be pre-pinned, reducing page fault latency on memset.
    Driver* const driver = stm->Device_()->Driver_();
    // driver->HostMemAlloc接口内已经默认做了512字节对齐
    rtError_t error = driver->HostMemAlloc(&hostPtr, setSize, stm->Device_()->Id_());
    ERROR_RETURN(error, "Host alloc failed, size=%" PRIu64 "B, retCode=%#x.", setSize, static_cast<uint32_t>(error));
    NULL_PTR_RETURN_MSG(hostPtr, RT_ERROR_MEMORY_ALLOCATION);
    // hostPtrGuard takes ownership: deleter calls HostMemFree on last reference.
    // Do NOT manually call HostMemFree after this point — shared_ptr handles it.
    hostPtrGuard.reset(hostPtr, [driver](void* p) { (void)driver->HostMemFree(p); });
    const errno_t ret = memset_s(hostPtr, setSize, static_cast<int32_t>(fillVal), setSize);
    if (ret != EOK) {
        RT_LOG(RT_LOG_ERROR, "memset_s failed, retCode=%d, size=%" PRIu64 "B", ret, setSize);
        return RT_ERROR_SEC_HANDLE;
    }

    uint64_t remainSize = (fillCount < MEM_BLOCK_SIZE) ? fillCount : MEM_BLOCK_SIZE;
    uint64_t realSize = 0UL;
    uint64_t doneSize = 0UL;
    while (remainSize > 0ULL) {
        error = MemcopyAsync(
            (RtPtrToPtr<char_t*, void*>(ptr)) + doneSize, destMax - doneSize,
            RtPtrToPtr<char_t*, void*>(hostPtr) + doneSize, remainSize, RT_MEMCPY_HOST_TO_DEVICE, stm, &realSize,
            hostPtrGuard);

        ERROR_RETURN_MSG_INNER(
            error,
            "Memcpy async step1 failed, retCode=%#x,"
            " max size=%" PRIu64 "(bytes), src size=%" PRIu64 "(bytes), type=%s.",
            error, destMax - doneSize, remainSize, MemcpyKindToStr(RT_MEMCPY_HOST_TO_DEVICE));
        doneSize += realSize;
        remainSize -= realSize;
    }

    if (fillCount > MEM_BLOCK_SIZE) {
        const uint64_t memBlockNum = fillCount / MEM_BLOCK_SIZE;
        for (uint64_t idx = 1UL; idx < memBlockNum; idx++) {
            error = MemcopyAsync(
                RtPtrToPtr<char_t*, void*>(ptr) + (idx * MEM_BLOCK_SIZE), destMax - (idx * MEM_BLOCK_SIZE),
                RtPtrToPtr<char_t*, void*>(ptr), MEM_BLOCK_SIZE, RT_MEMCPY_DEVICE_TO_DEVICE, stm, &realSize);
            ERROR_RETURN_MSG_INNER(
                error,
                "Memcpy async step2 failed,"
                " max size=%" PRIu64 "(bytes), src size=%" PRIu64 "(bytes), type=%s.",
                destMax - (idx * MEM_BLOCK_SIZE), MEM_BLOCK_SIZE, MemcpyKindToStr(RT_MEMCPY_DEVICE_TO_DEVICE));
        }

        const uint64_t memRemain = fillCount % MEM_BLOCK_SIZE;
        if (memRemain > 0ULL) {
            char_t* const dstAddr = (RtPtrToPtr<char_t*, void*>(ptr)) + (memBlockNum * MEM_BLOCK_SIZE);
            error = MemcopyAsync(
                dstAddr, destMax - (memBlockNum * MEM_BLOCK_SIZE), static_cast<char_t*>(ptr), memRemain,
                RT_MEMCPY_DEVICE_TO_DEVICE, stm, &realSize);
            ERROR_RETURN_MSG_INNER(
                error,
                "Memcpy async step3 failed,"
                " max size=%" PRIu64 "(bytes), src size=%" PRIu64 "(bytes), type=%s.",
                destMax - (memBlockNum * MEM_BLOCK_SIZE), memRemain, MemcpyKindToStr(RT_MEMCPY_DEVICE_TO_DEVICE));
        }
    }

    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
