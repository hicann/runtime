/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <vector>
#include <list>
#include "api.hpp"
#include "npu_driver.hpp"
#include "error_message_manage.hpp"
#include "arg_loader_ub.hpp"

namespace cce {

namespace runtime {

UbArgLoader::UbArgLoader(Device * const dev)
    : NoCopy(), device_(dev), argAllocator_(nullptr), superArgAllocator_(nullptr),
    handleAllocator_(nullptr)
{
}

UbArgLoader::~UbArgLoader()
{
    DELETE_O(argAllocator_);
    DELETE_O(superArgAllocator_);
    DELETE_O(handleAllocator_);
}

rtError_t UbArgLoader::Init()
{
    argAllocator_ = new (std::nothrow) H2DCopyMgr(device_, UB_ARG_MAX_ENTRY_SIZE, UB_ARG_INIT_CNT,
        Runtime::macroValue_.maxSupportTaskNum, BufferAllocator::LINEAR, COPY_POLICY_UB);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, argAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        "Init ubArgLoader stage1 failed, new BufferAllocator failed.");

    superArgAllocator_ = new (std::nothrow) H2DCopyMgr(device_, UB_ARG_MAX_SUPER_ENTRY_SIZE, UB_ARG_SUPER_INIT_CNT,
        Runtime::macroValue_.maxSupportTaskNum, BufferAllocator::LINEAR, COPY_POLICY_UB);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, superArgAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        "Init ubArgLoader stage2 failed, new BufferAllocator failed.");

    handleAllocator_ = new (std::nothrow) BufferAllocator(static_cast<uint32_t>(sizeof(UbHandle)), UB_ARG_INIT_CNT,
        Runtime::macroValue_.maxSupportTaskNum);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, handleAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        "Init ubArgLoader stage3 failed, new BufferAllocator failed.");
    RT_LOG(RT_LOG_INFO, "new argAllocator and handleAllocator success.");

    return RT_ERROR_NONE;
}

void UbArgLoader::ReleaseDevArgPool(UbHandle * const argHandle)
{
    argHandle->argsAlloc->FreeDevMem(argHandle->kerArgs);
    RT_LOG(RT_LOG_DEBUG, "Release args dev loader mem.");
}

void UbArgLoader::ReleaseDynamic(UbHandle * const argHandle)
{
    void *devPtr = argHandle->kerArgs;
    void *hostPtr = argHandle->hostAddr;

    if (devPtr != nullptr) {
        (void)device_->Driver_()->DevMemFree(devPtr, device_->Id_());
        RT_LOG(RT_LOG_DEBUG, "Recycle args dynamic dev mem, device_id=%u.", device_->Id_());
    }
    if (hostPtr != nullptr) {
        (void)device_->Driver_()->HostMemFree(hostPtr);
        RT_LOG(RT_LOG_DEBUG, "Recycle args dynamic host mem, device_id=%u.", device_->Id_());
    }
    if (argHandle->memTsegInfo != nullptr) {
        (void)device_->Driver_()->PutTsegInfo(device_->Id_(), &(argHandle->memTsegInfo->hostTsegInfo));
        (void)device_->Driver_()->PutTsegInfo(device_->Id_(), &(argHandle->memTsegInfo->devTsegInfo));
        (void)device_->Driver_()->HostMemFree(static_cast<void *>(argHandle->memTsegInfo));
        RT_LOG(RT_LOG_DEBUG, "Recycle args dynamic tseg info, device_id=%u.", device_->Id_());
    }
}

rtError_t UbArgLoader::Release(void * const argHandle)
{
    if (argHandle == nullptr) {
        return RT_ERROR_NONE;
    }

    UbHandle *hdl = static_cast<UbHandle *>(argHandle);
    if (hdl->argsAlloc != nullptr) {
        ReleaseDevArgPool(hdl);
    } else {
        ReleaseDynamic(hdl);
    }

    handleAllocator_->FreeByItem(argHandle);
    return RT_ERROR_NONE;
}

rtError_t UbArgLoader::AllocDevArgPool(const uint32_t size, UbHandle * const argHandle, void **devTsegInfo,
    void **hostTsegInfo)
{
    uint64_t hostAddr = 0U;
    H2DCopyMgr *ubArgAllocator = (size > UB_ARG_MAX_ENTRY_SIZE) ? superArgAllocator_ : argAllocator_;

    void *devAddr = ubArgAllocator->AllocDevMem();
    if (devAddr == nullptr) {
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    hostAddr = ubArgAllocator->GetUbHostAddr(RtPtrToValue<const void *>(devAddr), devTsegInfo, hostTsegInfo);
    if (hostAddr == 0U) {
        ubArgAllocator->FreeDevMem(devAddr);
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    RT_LOG(RT_LOG_DEBUG, "Alloc args dev loader mem success.");

    argHandle->kerArgs = devAddr;
    argHandle->hostAddr = RtValueToPtr<void *>(hostAddr);
    argHandle->argsAlloc = ubArgAllocator;
    return RT_ERROR_NONE;
}

rtError_t UbArgLoader::AllocDynamic(const uint32_t size, UbHandle * const argHandle, void **devTsegInfo,
    void **hostTsegInfo)
{
    void *devAddr = nullptr;
    void *hostAddr = nullptr;
    void *tsegInfoAddr = nullptr;

    rtError_t error = device_->Driver_()->DevMemAlloc(&devAddr, static_cast<uint64_t>(size), RT_MEMORY_HBM, device_->Id_());
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Alloc args dynamic dev mem failed, retCode=%#x, size=%u, device_id=%u.",
            error, size, device_->Id_());
        return error;
    }

    error = device_->Driver_()->HostMemAlloc(&hostAddr, static_cast<uint64_t>(size), device_->Id_());
    if (error != RT_ERROR_NONE) {
        (void)device_->Driver_()->DevMemFree(devAddr, device_->Id_());
        RT_LOG(RT_LOG_ERROR, "Alloc args dynamic host mem failed, retCode=%#x, size=%u, device_id=%u.",
            error, size, device_->Id_());
        return error;
    }

    error = device_->Driver_()->HostMemAlloc(&tsegInfoAddr, sizeof(struct memTsegInfo), device_->Id_());
    ERROR_PROC_RETURN_MSG_INNER(error, (void)device_->Driver_()->HostMemFree(hostAddr);
                                       (void)device_->Driver_()->DevMemFree(devAddr, device_->Id_());,
                                       "Alloc mem for tseg info failed, retCode=%#x, size=%zu, device_id=%u.",
                                       error, sizeof(struct memTsegInfo), device_->Id_());
    
    argHandle->memTsegInfo = (struct memTsegInfo *)tsegInfoAddr;
    error = GetMemTsegInfo(device_, devAddr, hostAddr, static_cast<uint64_t>(size), &(argHandle->memTsegInfo->devTsegInfo),
        &(argHandle->memTsegInfo->hostTsegInfo));
    ERROR_PROC_RETURN_MSG_INNER(error, (void)device_->Driver_()->HostMemFree(argHandle->memTsegInfo);
                                       argHandle->memTsegInfo = nullptr;,
                                       "get tseg info failed, retCode=%#x, size=%u, device_id=%u.",
                                       error, size, device_->Id_());

    RT_LOG(RT_LOG_DEBUG, "Alloc args dynamic mem success.");

    argHandle->kerArgs = devAddr;
    argHandle->hostAddr = hostAddr;
    *devTsegInfo = &(argHandle->memTsegInfo->devTsegInfo);
    *hostTsegInfo = &(argHandle->memTsegInfo->hostTsegInfo);
    return error;
}

rtError_t UbArgLoader::AllocCopyPtr(const uint32_t size, DavidArgLoaderResult * const result)
{
    rtError_t error = RT_ERROR_NONE;
    UbHandle *argHandle = nullptr;

    result->handle = handleAllocator_->AllocItem();
    NULL_PTR_RETURN(result->handle, RT_ERROR_MEMORY_ALLOCATION);
    argHandle = static_cast<UbHandle *>(result->handle);
    argHandle->argsAlloc = nullptr;
    void *devTsegInfo = nullptr;
    void *hostTsegInfo = nullptr;

    if (size <= UB_ARG_MAX_SUPER_ENTRY_SIZE) {
        error = AllocDevArgPool(size, argHandle, &devTsegInfo, &hostTsegInfo);
    } else {
        error = AllocDynamic(size, argHandle, &devTsegInfo, &hostTsegInfo);
    }
    if (error != RT_ERROR_NONE) {
        handleAllocator_->FreeByItem(argHandle);
        result->handle = nullptr;
        return error;
    }
    result->kerArgs = argHandle->kerArgs;
    result->hostAddr = argHandle->hostAddr;
    result->devTsegInfo = devTsegInfo;
    result->hostTsegInfo = hostTsegInfo;
    return error;
}

}
}