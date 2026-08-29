/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "uma_arg_loader.hpp"
#include <vector>
#include "securec.h"
#include "runtime.hpp"
#include "device.hpp"
#include "stream.hpp"
#include "api.hpp"
#include "error_message_manage.hpp"
#include "enum_desc.hpp"

namespace cce {
namespace runtime {
UmaArgLoader::UmaArgLoader(Device* const dev)
    : ArgLoader(dev),
      argAllocator_(nullptr),
      superArgAllocator_(nullptr),
      maxArgAllocator_(nullptr),
      argPcieBarAllocator_(nullptr),
      randomAllocator_(nullptr),
      handleAllocator_(nullptr),
      kernelInfoAllocator_(nullptr),
      itemSize_(0U),
      maxItemSize_(0U)
{}

UmaArgLoader::~UmaArgLoader() { TearDown(); }

void UmaArgLoader::TearDown(void) noexcept
{
    DELETE_O(argAllocator_);
    DELETE_O(superArgAllocator_);
    DELETE_O(maxArgAllocator_);
    DELETE_O(handleAllocator_);
    DELETE_O(kernelInfoAllocator_);
    DELETE_O(argPcieBarAllocator_);
    DELETE_O(randomAllocator_);

    soNameMap_.clear();
    kernelNameMap_.clear();
}

rtError_t UmaArgLoader::Init()
{
    uint32_t initCount = DEFAULT_INIT_CNT;
    itemSize_ = device_->GetDevProperties().argsItemSize;
    initCount = device_->GetDevProperties().argInitCountSize;

    maxItemSize_ = itemSize_ + ARG_ENTRY_INCRETMENT_SIZE;
    bool isPcieBarSupport = false;
    if (!Runtime::Instance()->GetConnectUbFlag()) {
        uint32_t val = RT_CAPABILITY_NOT_SUPPORT;
        (void)device_->Driver_()->CheckSupportPcieBarCopy(device_->Id_(), val, false);
        isPcieBarSupport = (val == RT_CAPABILITY_SUPPORT);
        uint32_t argAllocatorSize = initCount;
        if (device_->GetDevProperties().argsAllocatorSize != 0U) {
            argAllocatorSize = device_->GetDevProperties().argsAllocatorSize;
        }
        argAllocator_ = new (std::nothrow) H2DCopyMgr(
            device_, itemSize_, argAllocatorSize, device_->GetDevProperties().maxSupportTaskNum,
            BufferAllocator::LINEAR, COPY_POLICY_DEFAULT); // 512 cell for init
        COND_RETURN_AND_MSG_OUTER(
            argAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, sizeof(H2DCopyMgr), "new");
        if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_UMA_SUPER_ARGS_ALLOC)) {
            const uint32_t superArgAllocatorSize = device_->GetDevProperties().superArgAllocatorSize;
            superArgAllocator_ = new (std::nothrow) H2DCopyMgr(
                device_, MULTI_GRAPH_SUPER_ARG_ENTRY_SIZE, superArgAllocatorSize,
                device_->GetDevProperties().maxSupportTaskNum, BufferAllocator::LINEAR, COPY_POLICY_DEFAULT);

            COND_RETURN_AND_MSG_OUTER(
                superArgAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, sizeof(H2DCopyMgr),
                "new");
            const uint32_t maxArgAllocatorSize = device_->GetDevProperties().maxArgAllocatorSize;
            maxArgAllocator_ = new (std::nothrow) H2DCopyMgr(
                device_, maxItemSize_, maxArgAllocatorSize, device_->GetDevProperties().maxSupportTaskNum,
                BufferAllocator::LINEAR, COPY_POLICY_DEFAULT);

            COND_RETURN_AND_MSG_OUTER(
                maxArgAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, sizeof(H2DCopyMgr), "new");
        } else {
            // only when the aicpu does not exist, do this
            if (Runtime::Instance()->GetAicpuCnt() != 0) {
                maxArgAllocator_ = new (std::nothrow) H2DCopyMgr(
                    device_, maxItemSize_, ARG_MAX_ENTRY_INIT_NUM, device_->GetDevProperties().maxSupportTaskNum,
                    BufferAllocator::LINEAR, COPY_POLICY_DEFAULT);
                COND_RETURN_AND_MSG_OUTER(
                    maxArgAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, sizeof(H2DCopyMgr),
                    "new");
            }
        }
    }

    randomAllocator_ = new (std::nothrow) H2DCopyMgr(device_, COPY_POLICY_SYNC);
    COND_RETURN_AND_MSG_OUTER(
        randomAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, sizeof(H2DCopyMgr), "new");

    RT_LOG(RT_LOG_INFO, "new BufferAllocator superArgAllocator_ ok, Runtime_alloc_size %zu", sizeof(BufferAllocator));
    const uint32_t handleAllocatorSize = device_->GetDevProperties().handleAllocatorSize;
    handleAllocator_ = new (std::nothrow) BufferAllocator(
        static_cast<uint32_t>(sizeof(Handle)), handleAllocatorSize, device_->GetDevProperties().maxSupportTaskNum);

    COND_RETURN_AND_MSG_OUTER(
        handleAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, sizeof(BufferAllocator), "new");
    RT_LOG(RT_LOG_INFO, "new BufferAllocator handleAllocator_ ok, Runtime_alloc_size %zu", sizeof(BufferAllocator));
    const uint32_t kernelInfoAllocatorSize = device_->GetDevProperties().kernelInfoAllocatorSize;
    kernelInfoAllocator_ = new (std::nothrow) BufferAllocator(
        KERNEL_INFO_ENTRY_SIZE, kernelInfoAllocatorSize, device_->GetDevProperties().maxSupportTaskNum,
        BufferAllocator::LINEAR, &MallocBuffer, &FreeBuffer, device_);

    COND_RETURN_AND_MSG_OUTER(
        kernelInfoAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, sizeof(BufferAllocator), "new");
    RT_LOG(RT_LOG_INFO, "new BufferAllocator kernelInfoAllocator_ ok, Runtime_alloc_size %zu", sizeof(BufferAllocator));

    RT_LOG(RT_LOG_INFO, "ALLOC PCIE is support[%d]", static_cast<int32_t>(isPcieBarSupport));
    if ((drv_->GetRunMode() == static_cast<uint32_t>(RT_RUN_MODE_ONLINE)) && isPcieBarSupport) {
        argPcieBarAllocator_ = new (std::nothrow) H2DCopyMgr(
            device_, PCIE_BAR_COPY_SIZE, 1024U, device_->GetDevProperties().maxSupportTaskNum, BufferAllocator::LINEAR,
            COPY_POLICY_PCIE_BAR);
        COND_RETURN_AND_MSG_OUTER(
            argPcieBarAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, sizeof(H2DCopyMgr), "new");
    }
    return RT_ERROR_NONE;
}

void* UmaArgLoader::MallocBuffer(const size_t size, void* const para)
{
    void* addr = nullptr;
    Device* const dev = static_cast<Device*>(para);
    (void)dev->Driver_()->DevMemAlloc(&addr, static_cast<uint64_t>(size), RT_MEMORY_HBM, dev->Id_());
    return addr;
}

void UmaArgLoader::FreeBuffer(void* const addr, void* const para)
{
    Device* const dev = static_cast<Device*>(para);
    (void)dev->Driver_()->DevMemFree(addr, dev->Id_());
}

rtError_t UmaArgLoader::AllocCopyPtrWithGenericPolicy(const uint32_t size, ArgLoaderResult* const result)
{
    UNUSED(size);
    UNUSED(result);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t UmaArgLoader::LoadForMix(
    const rtArgsEx_t* const argsInfo, Stream* const stm, ArgLoaderResult* const result, bool& mixOpt)
{
    UNUSED(argsInfo);
    UNUSED(stm);
    UNUSED(result);
    UNUSED(mixOpt);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}
rtError_t UmaArgLoader::Load(const rtArgsEx_t* const argsInfo, Stream* const stm, ArgLoaderResult* const result)
{
    UNUSED(argsInfo);
    UNUSED(stm);
    UNUSED(result);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t UmaArgLoader::PureLoad(const uint32_t size, const void* const args, ArgLoaderResult* const result)
{
    UNUSED(size);
    UNUSED(args);
    UNUSED(result);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t UmaArgLoader::LoadCpuKernelArgs(
    const rtArgsEx_t* const argsInfo, Stream* const stm, ArgLoaderResult* const result)
{
    UNUSED(argsInfo);
    UNUSED(stm);
    UNUSED(result);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t UmaArgLoader::LoadCpuKernelArgsEx(
    const rtAicpuArgsEx_t* const argsInfo, Stream* const stm, ArgLoaderResult* const result)
{
    UNUSED(argsInfo);
    UNUSED(stm);
    UNUSED(result);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t UmaArgLoader::GetKernelInfoDevAddr(const char_t* const name, const KernelInfoType type, void** const addr)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        name, RT_ERROR_KERNEL_NAME,
        "Querying the start address of the corresponding operator on the device based on the kernel name.");

    rtError_t error;
    switch (type) {
        case SO_NAME: {
            std::unique_lock<std::mutex> taskLock(soNameMapLock_);
            error = FindOrInsertDevAddr(name, soNameMap_, addr);
            break;
        }
        case KERNEL_NAME: {
            std::unique_lock<std::mutex> taskLock(kernelNameMapLock_);
            error = FindOrInsertDevAddr(name, kernelNameMap_, addr);
            break;
        }
        default: {
            RT_LOG(
                RT_LOG_ERROR, "Invalid kernel info type=%d, valid type is [%d, %d).", static_cast<int32_t>(type),
                static_cast<int32_t>(SO_NAME), static_cast<int32_t>(MAX_NAME));
            error = RT_ERROR_KERNEL_TYPE;
            break;
        }
    }
    return error;
}

void UmaArgLoader::FindKernelInfoName(
    std::string& name, std::unordered_map<std::string, void*>& nameMap, const void* addr) const
{
    for (std::pair<std::string, void*> iter : nameMap) {
        if (iter.second == addr) {
            name = iter.first;
            RT_LOG(RT_LOG_INFO, "Find kernel info name %s success!", name.c_str());
            break;
        }
    }
    return;
}

void UmaArgLoader::GetKernelInfoFromAddr(std::string& name, const KernelInfoType type, void* addr)
{
    switch (type) {
        case SO_NAME: {
            std::unique_lock<std::mutex> taskLock(soNameMapLock_);
            (void)FindKernelInfoName(name, soNameMap_, addr);
            break;
        }
        case KERNEL_NAME: {
            std::unique_lock<std::mutex> taskLock(kernelNameMapLock_);
            (void)FindKernelInfoName(name, kernelNameMap_, addr);
            break;
        }
        default: {
            RT_LOG(
                RT_LOG_ERROR, "Invalid kernel info type, current type = %d, valid type is %d or %d.",
                static_cast<int32_t>(type), static_cast<int32_t>(SO_NAME), static_cast<int32_t>(KERNEL_NAME));
            break;
        }
    }
    return;
}

void UmaArgLoader::RestoreAiCpuKernelInfo(void) {}

bool UmaArgLoader::CheckPcieBar(void)
{
    if (argPcieBarAllocator_ == nullptr) {
        return false;
    } else {
        return true;
    }
}

rtError_t UmaArgLoader::LoadStreamSwitchNArgs(
    Stream* const stm, const void* const valuePtr, const uint32_t valueSize, Stream** const trueStreamPtr,
    const uint32_t elementSize, const rtSwitchDataType_t dataType, StreamSwitchNLoadResult* const result)
{
    rtError_t error;
    void* valueDevAddr = nullptr;
    void* streamIdDevAddr = nullptr;
    uint64_t valueDevSize;
    uint64_t streamIdDevSize;
    std::vector<uint32_t> vecStreamId(elementSize);
    for (size_t i = 0UL; i < elementSize; i++) {
        vecStreamId[i] = static_cast<uint32_t>(trueStreamPtr[i]->Id_());
    }

    if (dataType == RT_SWITCH_INT32) {
        valueDevSize = static_cast<uint64_t>(valueSize) * sizeof(int32_t);
    } else {
        valueDevSize = static_cast<uint64_t>(valueSize) * sizeof(int64_t);
    }
    streamIdDevSize = sizeof(uint32_t) * elementSize;

    Runtime* const rtInstance = Runtime::Instance();
    rtMemType_t memType = rtInstance->GetTsMemType(MEM_REQUEST_FEATURE_DEFAULT, valueDevSize);

    RT_LOG(
        RT_LOG_DEBUG, "memType=%u, chip type=%d.", static_cast<uint32_t>(memType),
        static_cast<int32_t>(rtInstance->GetChipType()));

    error = drv_->DevMemAlloc(&valueDevAddr, valueDevSize, memType, device_->Id_());
    ERROR_RETURN(
        error, "Failed to alloc dev value memory, memType=%u, deviceId=%u, retCode=%#x", static_cast<uint32_t>(memType),
        device_->Id_(), static_cast<uint32_t>(error));

    error = drv_->MemCopySync(valueDevAddr, valueDevSize, valuePtr, valueDevSize, RT_MEMCPY_HOST_TO_DEVICE);
    if (error != RT_ERROR_NONE) {
        (void)drv_->DevMemFree(valueDevAddr, device_->Id_());
        RT_LOG(
            RT_LOG_ERROR, "Failed to copy value to device when load stream switchN args, kind=%s, retCode=%#x",
            MemcpyKindToStr(RT_MEMCPY_HOST_TO_DEVICE), static_cast<uint32_t>(error));
        return error;
    }
    stm->PushbackSwitchNArgs(valueDevAddr);

    memType = rtInstance->GetTsMemType(MEM_REQUEST_FEATURE_DEFAULT, streamIdDevSize);
    error = drv_->DevMemAlloc(&streamIdDevAddr, streamIdDevSize, memType, device_->Id_());
    if (error != RT_ERROR_NONE) {
        (void)drv_->DevMemFree(valueDevAddr, device_->Id_());
        RT_LOG(
            RT_LOG_ERROR, "Failed to alloc device stream ID memory, memType=%u, deviceId=%u, retCode=%#x",
            static_cast<uint32_t>(memType), device_->Id_(), static_cast<uint32_t>(error));
        return error;
    }

    error = drv_->MemCopySync(
        streamIdDevAddr, streamIdDevSize, vecStreamId.data(), streamIdDevSize, RT_MEMCPY_HOST_TO_DEVICE);
    if (error != RT_ERROR_NONE) {
        (void)drv_->DevMemFree(valueDevAddr, device_->Id_());
        (void)drv_->DevMemFree(streamIdDevAddr, device_->Id_());
        RT_LOG(
            RT_LOG_ERROR, "Failed to copy true stream ID to device, kind=%s, retCode=%#x",
            MemcpyKindToStr(RT_MEMCPY_HOST_TO_DEVICE), static_cast<uint32_t>(error));
        return error;
    }

    stm->PushbackSwitchNArgs(streamIdDevAddr);
    result->valuePtr = valueDevAddr;
    result->trueStreamPtr = streamIdDevAddr;

    return RT_ERROR_NONE;
}

rtError_t UmaArgLoader::FindOrInsertDevAddr(
    const char_t* const name, std::unordered_map<std::string, void*>& nameMap, void** const addr) const
{
    rtError_t error = RT_ERROR_NONE;
    std::string kernelInfoName(name);
    const auto iter = nameMap.find(kernelInfoName);
    if (iter != nameMap.end()) {
        *addr = iter->second;
        return RT_ERROR_NONE;
    }

    // Alloc device addr and insert to map
    void* const devAddr = kernelInfoAllocator_->AllocItem();
    if (devAddr == nullptr) {
        RT_LOG(RT_LOG_ERROR, "devAddr is nullptr! Alloc addr for kernel info name %s failed.", name);
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    const size_t cpySize = strnlen(name, static_cast<size_t>(KERNEL_INFO_ENTRY_SIZE - 1U)) + 1UL;
    if (cpySize == KERNEL_INFO_ENTRY_SIZE) {
        char tempName[KERNEL_INFO_ENTRY_SIZE];
        (void)memset_s(&tempName[0], KERNEL_INFO_ENTRY_SIZE, 0, KERNEL_INFO_ENTRY_SIZE);
        (void)memcpy_s(&tempName[0], cpySize - 1, name, cpySize - 1);
        error = drv_->MemCopySync(
            devAddr, cpySize, static_cast<const void*>(&tempName[0]), cpySize, RT_MEMCPY_HOST_TO_DEVICE);
    } else {
        error = drv_->MemCopySync(devAddr, cpySize, static_cast<const void*>(name), cpySize, RT_MEMCPY_HOST_TO_DEVICE);
    }

    if (error != RT_ERROR_NONE) {
        kernelInfoAllocator_->FreeByItem(devAddr);
        RT_LOG(RT_LOG_ERROR, "MemCopySync for so name %s failed, retCode=%#x", name, static_cast<uint32_t>(error));
        return error;
    }

    *addr = devAddr;
    RT_LOG(RT_LOG_DEBUG, "Alloc device addr for kernel info name %s success!", name);
    (void)nameMap.insert(std::make_pair(kernelInfoName, *addr));
    return RT_ERROR_NONE;
}

rtError_t UmaArgLoader::Release(void* const argHandle)
{
    const rtError_t error = RT_ERROR_NONE;
    if (argHandle == nullptr) {
        return error;
    }

    Handle* hdl = static_cast<Handle*>(argHandle);
    if (hdl->freeArgs) {
        hdl->argsAlloc->FreeDevMem(hdl->kerArgs);
        RT_LOG(RT_LOG_DEBUG, "Release arg memory!");
    }

    handleAllocator_->FreeByItem(argHandle);
    return error;
}

rtError_t UmaArgLoader::AllocNoCopyPtr(void* hostArgs, ArgLoaderResult* result)
{
    Handle* argHandle = static_cast<Handle*>(handleAllocator_->AllocItem());
    NULL_PTR_RETURN(argHandle, RT_ERROR_MEMORY_ALLOCATION);
    argHandle->kerArgs = hostArgs;
    argHandle->freeArgs = false;
    argHandle->argsAlloc = argAllocator_;
    result->kerArgs = hostArgs;
    result->handle = static_cast<void*>(argHandle);
    result->allocatedEntrySize = 0U;
    return RT_ERROR_NONE;
}

rtError_t UmaArgLoader::AllocCopyPtrWithSpecificPolicy(uint32_t size, LoadPolicy policy, ArgLoaderResult* result)
{
    UNUSED(size);
    UNUSED(policy);
    UNUSED(result);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}
} // namespace runtime
} // namespace cce
