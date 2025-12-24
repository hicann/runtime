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
#include "npu_driver.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
UmaArgLoader::UmaArgLoader(Device * const dev)
    : ArgLoader(dev), argAllocator_(nullptr), superArgAllocator_(nullptr), maxArgAllocator_(nullptr),
    argPcieBarAllocator_(nullptr), randomAllocator_(nullptr), handleAllocator_(nullptr),
    kernelInfoAllocator_(nullptr), itemSize_(0U), maxItemSize_(0U)
{
}

UmaArgLoader::~UmaArgLoader()
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
        if(device_->GetDevProperties().argsAllocatorSize != 0U){
            argAllocatorSize = device_->GetDevProperties().argsAllocatorSize;
        } 
        argAllocator_ = new (std::nothrow) H2DCopyMgr(device_, itemSize_, argAllocatorSize,
            Runtime::macroValue_.maxSupportTaskNum, BufferAllocator::LINEAR, COPY_POLICY_DEFAULT); // 512 cell for init

        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, argAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
            "Init uma arg loader stage1 failed, new BufferAllocator failed.");
        if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_UMA_SUPER_ARGS_ALLOC)) {
            const uint32_t superArgAllocatorSize = device_->GetDevProperties().superArgAllocatorSize;
            superArgAllocator_ = new (std::nothrow) H2DCopyMgr(device_, MULTI_GRAPH_SUPER_ARG_ENTRY_SIZE,
                superArgAllocatorSize, Runtime::macroValue_.maxSupportTaskNum,
                BufferAllocator::LINEAR, COPY_POLICY_DEFAULT);

            COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, superArgAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
                "Init uma arg loader stage2 failed, new BufferAllocator failed.");
            const uint32_t maxArgAllocatorSize =  device_->GetDevProperties().maxArgAllocatorSize;
            maxArgAllocator_ = new (std::nothrow) H2DCopyMgr(device_, maxItemSize_, maxArgAllocatorSize,
                Runtime::macroValue_.maxSupportTaskNum, BufferAllocator::LINEAR, COPY_POLICY_DEFAULT);

            COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, maxArgAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
                "Init uma arg loader stage3 failed, new BufferAllocator failed.");
        } else {
            // only when the aicpu does not exist, do this
            if (Runtime::Instance()->GetAicpuCnt() != 0) {
                maxArgAllocator_ = new (std::nothrow) H2DCopyMgr(device_, maxItemSize_, ARG_MAX_ENTRY_INIT_NUM,
                    Runtime::macroValue_.maxSupportTaskNum, BufferAllocator::LINEAR, COPY_POLICY_DEFAULT);
                COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, maxArgAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
                    "Init uma arg loader stage3 failed, new BufferAllocator failed.");
            }
        }
    }

    randomAllocator_ = new (std::nothrow) H2DCopyMgr(device_, COPY_POLICY_SYNC);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, randomAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        "Init uma arg loader stage4 failed, new BufferAllocator failed.");

    RT_LOG(RT_LOG_INFO, "new BufferAllocator superArgAllocator_ ok, Runtime_alloc_size %zu", sizeof(BufferAllocator));
    const uint32_t handleAllocatorSize = device_->GetDevProperties().handleAllocatorSize;
    handleAllocator_ = new (std::nothrow) BufferAllocator(static_cast<uint32_t>(sizeof(Handle)), handleAllocatorSize,
        Runtime::macroValue_.maxSupportTaskNum);

    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, handleAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        "Init uma arg loader stage4 failed, new BufferAllocator failed.");
    RT_LOG(RT_LOG_INFO, "new BufferAllocator handleAllocator_ ok, Runtime_alloc_size %zu", sizeof(BufferAllocator));
    const uint32_t kernelInfoAllocatorSize =  device_->GetDevProperties().kernelInfoAllocatorSize;
    kernelInfoAllocator_ = new (std::nothrow) BufferAllocator(KERNEL_INFO_ENTRY_SIZE, kernelInfoAllocatorSize,
                                                            Runtime::macroValue_.maxSupportTaskNum,
                                                            BufferAllocator::LINEAR, &MallocBuffer,
                                                            &FreeBuffer, device_);

    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, kernelInfoAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        "Init uma arg loader stage5 failed, new BufferAllocator failed.");
    RT_LOG(RT_LOG_INFO, "new BufferAllocator kernelInfoAllocator_ ok, Runtime_alloc_size %zu", sizeof(BufferAllocator));

    RT_LOG(RT_LOG_INFO, "ALLOC PCIE is support[%d]", static_cast<int32_t>(isPcieBarSupport));
    if ((drv_->GetRunMode() == static_cast<uint32_t>(RT_RUN_MODE_ONLINE)) && isPcieBarSupport) {
        argPcieBarAllocator_ = new (std::nothrow) H2DCopyMgr(device_, PCIE_BAR_COPY_SIZE, 1024U,
            Runtime::macroValue_.maxSupportTaskNum, BufferAllocator::LINEAR, COPY_POLICY_PCIE_BAR);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, argPcieBarAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
            "Init uma arg loader stage6 failed, new BufferAllocator failed.");
    }
    return RT_ERROR_NONE;
}

void *UmaArgLoader::MallocBuffer(const size_t size, void * const para)
{
    void *addr = nullptr;
    Device * const dev = static_cast<Device *>(para);
    (void)dev->Driver_()->DevMemAlloc(&addr, static_cast<uint64_t>(size), RT_MEMORY_HBM, dev->Id_());
    return addr;
}

void UmaArgLoader::FreeBuffer(void * const addr, void * const para)
{
    Device * const dev = static_cast<Device *>(para);
    (void)dev->Driver_()->DevMemFree(addr, dev->Id_());
}

rtError_t UmaArgLoader::LoadSmDescArgs(const rtSmDesc_t * const smDesc, void ** const smArgs,
                                       bool &copyL2Desc, bool &freeL2Desc) const
{
    rtError_t error = RT_ERROR_NONE;

    // copy l2ctrl when not SPM
    if ((smDesc != nullptr) &&
        (!device_->IsSPM(static_cast<const void *>(const_cast<const rtSmDesc_t *>(smDesc))))) {
        error = device_->AllocSPM(smArgs, sizeof(rtSmDesc_t));
        ERROR_RETURN(error, "Alloc spm failed, retCode=%#x.", static_cast<uint32_t>(error));

        copyL2Desc = true;
        if ((drv_->GetRunMode() == static_cast<uint32_t>(RT_RUN_MODE_OFFLINE)) ||
            (drv_->GetRunMode() == static_cast<uint32_t>(RT_RUN_MODE_AICPU_SCHED))) {
            freeL2Desc = true;
            error = drv_->MemCopySync(*smArgs, sizeof(rtSmDesc_t), smDesc, sizeof(rtSmDesc_t),
                                      RT_MEMCPY_DEVICE_TO_DEVICE);
        } else {
            freeL2Desc = true;
            error = drv_->MemCopySync(*smArgs, sizeof(rtSmDesc_t), smDesc, sizeof(rtSmDesc_t),
                                      RT_MEMCPY_HOST_TO_DEVICE);
        }
        ERROR_RETURN(error, "Memcpy L2 description failed, retCode=%#x.", static_cast<uint32_t>(error));
    }
    return error;
}

void UmaArgLoader::UpdateAddrField(const void* const kerArgs,
                                   void* const argsHostAddr,
                                   const uint16_t hostInputInfoNum,
                                   const rtHostInputInfo* const hostInputInfoPtr) const
{
    for (uint16_t i = 0U; i < hostInputInfoNum; i++) {
        // set host mem data offset to host mem addr
        const uint32_t addrOffset = hostInputInfoPtr[i].addrOffset;
        const uint32_t dataOffset = hostInputInfoPtr[i].dataOffset;
        *(RtPtrToPtr<uint64_t *, char_t *>(RtPtrToPtr<char_t *, void *>(argsHostAddr) + addrOffset)) =
            RtPtrToValue<const void*>(kerArgs) + dataOffset;
    }
}

void UmaArgLoader::UpdateArgsAddr(const void * const kerArgs, const rtArgsEx_t *argsInfo) const
{
    if (argsInfo->hasTiling != 0) {
        // set tiling data offset to tiling addr
        *(RtPtrToPtr<uint64_t *, char_t *>(RtPtrToPtr<char_t *, void *>(argsInfo->args) + argsInfo->tilingAddrOffset)) =
            RtPtrToValue<const void *>(kerArgs) + argsInfo->tilingDataOffset;
    }
    UpdateAddrField(kerArgs, argsInfo->args, argsInfo->hostInputInfoNum, argsInfo->hostInputInfoPtr);
}


void UmaArgLoader::UpdateAicpuArgsEx(const void * const kerArgs, const rtAicpuArgsEx_t *argsInfo) const
{
    UpdateAddrField(kerArgs, argsInfo->args, argsInfo->hostInputInfoNum, argsInfo->hostInputInfoPtr);
    UpdateAddrField(kerArgs, argsInfo->args, argsInfo->kernelOffsetInfoNum, argsInfo->kernelOffsetInfoPtr);
}

rtError_t UmaArgLoader::LoadInputOutputArgsHuge(const Stream * const stm, void *&kerArgs, H2DCopyMgr * const umaArgAllocator,
                                            bool &copyArgs, const uint32_t size,
                                            const void * const args, const rtArgsEx_t * const argsInfo) const
{
    rtError_t error = RT_ERROR_NONE;
    RT_LOG(RT_LOG_DEBUG, "hugeargs size=%u, use randomAllocator.", size);

    if ((stm->NonSupportModelCompile()) || (stm->GetModelNum() == 0U) || (argsInfo->isNoNeedH2DCopy == 0U)) {
        kerArgs = umaArgAllocator->AllocDevMem(size);
        NULL_PTR_RETURN(kerArgs, RT_ERROR_MEMORY_ALLOCATION);

        copyArgs = true;
        UpdateArgsAddr(umaArgAllocator->GetDevAddr(kerArgs), argsInfo);
        const uint64_t cpySize = static_cast<uint64_t>(size);
        error = umaArgAllocator->H2DMemCopy(kerArgs, args, cpySize);
        ERROR_RETURN_MSG_INNER(error, "H2DMemCopy, kind=%d, retCode=%#x.",
            static_cast<int32_t>(RT_MEMCPY_HOST_TO_DEVICE), static_cast<uint32_t>(error));
    }

    return error;
}


rtError_t UmaArgLoader::LoadInputOutputArgs(const Stream * const stm, void *&kerArgs, H2DCopyMgr * const umaArgAllocator,
                                            bool &copyArgs, const uint32_t kernelType, const uint32_t size,
                                            const void * const args, const rtArgsEx_t * const argsInfo) const
{
    UNUSED(kernelType);
    rtError_t error = RT_ERROR_NONE;
    if ((stm->NonSupportModelCompile()) || (stm->GetModelNum() == 0U) || (argsInfo->isNoNeedH2DCopy == 0U)) {
        const bool isLogError = stm->Device_()->GetDevProperties().isNeedlogErrorLevel;
        kerArgs = umaArgAllocator->AllocDevMem(isLogError);
        if (kerArgs == nullptr) {
            RtLogErrorLevelControl(isLogError, "kerArgs is NULL!");
            return RT_ERROR_MEMORY_ALLOCATION;
        }

        copyArgs = true;
        UpdateArgsAddr(umaArgAllocator->GetDevAddr(kerArgs), argsInfo);

        const uint32_t argItemSize = (size > itemSize_) ? maxItemSize_ : itemSize_;
        const uint64_t cpySize = ((argItemSize > size) ?
            static_cast<uint64_t>(size) : static_cast<uint64_t>(argItemSize));
        error = umaArgAllocator->H2DMemCopy(kerArgs, args, cpySize);
        ERROR_RETURN_MSG_INNER(error, "H2DMemCopy, kind=%d, retCode=%#x.",
            static_cast<int32_t>(RT_MEMCPY_HOST_TO_DEVICE), static_cast<uint32_t>(error));
    }

    return error;
}

rtError_t UmaArgLoader::LoadInputOutputArgsForMix(const Stream * const stm, void *kerArgs, H2DCopyMgr * const umaArgAllocator,
                                                  bool &copyArgs, const uint32_t kernelType, const uint32_t size,
                                                  const void * const args, const rtArgsEx_t * const argsInfo) const
{
    UNUSED(kernelType);
    rtError_t error = RT_ERROR_NONE;
    if ((stm->GetModelNum() == 0U) || (argsInfo->isNoNeedH2DCopy == 0U)) {
        RT_LOG(RT_LOG_INFO, "args loader load for mix");
        void *devAddr = static_cast<void *>(RtPtrToPtr<char_t *, void *>(umaArgAllocator->GetDevAddr(kerArgs)) +
                                                                       CONTEXT_ALIGN_LEN);
        copyArgs = true;
        UpdateArgsAddr(devAddr, argsInfo);
        error = umaArgAllocator->H2DMemCopy(devAddr, args, size);
        ERROR_RETURN_MSG_INNER(error, "H2DMemCopy, kind=%d, retCode=%#x.",
            static_cast<int32_t>(RT_MEMCPY_HOST_TO_DEVICE), static_cast<uint32_t>(error));
    }

    return error;
}

rtError_t UmaArgLoader::AllocCopyPtr(const uint32_t size, ArgLoaderResult * const result)
{
    Handle *argHandle = nullptr;
    result->handle = handleAllocator_->AllocItem();
    NULL_PTR_RETURN(result->handle, RT_ERROR_MEMORY_ALLOCATION);
    argHandle = static_cast<Handle *>(result->handle);
    argHandle->freeArgs = false;
    bool isRandom = false;

    H2DCopyMgr *umaArgAllocator = nullptr;
    if ((argPcieBarAllocator_ != nullptr) && (size <= PCIE_BAR_COPY_SIZE)) {
        umaArgAllocator = argPcieBarAllocator_;
    } else if (size <= itemSize_) {
        umaArgAllocator = argAllocator_;
    } else if ((superArgAllocator_ != nullptr) && (size <= MULTI_GRAPH_SUPER_ARG_ENTRY_SIZE)) {
        umaArgAllocator = superArgAllocator_;
    } else if ((maxArgAllocator_ != nullptr) && (size <= maxItemSize_)) {
        umaArgAllocator = maxArgAllocator_;
    } else {
        umaArgAllocator = randomAllocator_;
        isRandom = true;
    }

    void *kerArgs = nullptr;
    if (isRandom) {
        kerArgs = umaArgAllocator->AllocDevMem(size);
    } else {
        kerArgs = umaArgAllocator->AllocDevMem();
    }
    if (kerArgs == nullptr) {
        handleAllocator_->FreeByItem(argHandle);
        result->handle = nullptr;
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    RT_LOG(RT_LOG_DEBUG, "Alloc args dev loader mem success.");
    argHandle->kerArgs = kerArgs;
    argHandle->freeArgs = true;
    argHandle->argsAlloc = umaArgAllocator;
    result->kerArgs = umaArgAllocator->GetDevAddr(kerArgs);
    return RT_ERROR_NONE;
}

rtError_t UmaArgLoader::LoadForMix(const uint32_t kernelType, const rtArgsEx_t * const argsInfo,
                                   rtSmDesc_t * const smDesc, Stream * const stm, ArgLoaderResult * const result, bool &mixOpt)
{
    Handle *argHandle = nullptr;
    rtError_t error;
    void *kerArgs = argsInfo->args;
    void *smArgs = smDesc;
    bool copyL2Desc = false;
    bool freeL2Desc = false;
    bool copyArgs = false;
    const uint32_t size = argsInfo->argsSize;
    void * const args = argsInfo->args;
    H2DCopyMgr *umaArgAllocator = argPcieBarAllocator_;

    if ((umaArgAllocator == nullptr) || (size > PCIE_BAR_COPY_SIZE)) {
        ERROR_RETURN_MSG_INNER(RT_ERROR_INVALID_VALUE, "invalid para, byteSize=%u.", size);
    }
    argHandle = static_cast<Handle *>(handleAllocator_->AllocItem());
    NULL_PTR_RETURN(argHandle, RT_ERROR_MEMORY_ALLOCATION);
    kerArgs = umaArgAllocator->AllocDevMem();
    if (kerArgs == nullptr) {
        error = RT_ERROR_MEMORY_ALLOCATION;
        ERROR_GOTO_MSG_INNER(error, RECYCLE, "alloc kerArgs failed");
    }

    if (argsInfo->isNoNeedH2DCopy == 0U) {
        RT_LOG(RT_LOG_INFO, "args loader load for mix");
        error = LoadInputOutputArgsForMix(stm, kerArgs, umaArgAllocator, copyArgs, kernelType, size, args,
            argsInfo);
        ERROR_GOTO_MSG_INNER(error, RECYCLE, "load args(size=%u) failed, retCode=%#x.", size, static_cast<uint32_t>(error));
    }

    error = LoadSmDescArgs(smDesc, &smArgs, copyL2Desc, freeL2Desc);
    ERROR_GOTO(error, RECYCLE, "load L2 description failed, retCode=%#x.", static_cast<uint32_t>(error));

    argHandle->kerArgs = umaArgAllocator->GetDevAddr(kerArgs);
    argHandle->smArgs = smArgs;
    argHandle->freeL2Desc = freeL2Desc;
    argHandle->freeArgs = true;
    argHandle->argsAlloc = umaArgAllocator;
    result->kerArgs = copyArgs ?
        static_cast<void *>(RtPtrToPtr<char_t *, void *>(umaArgAllocator->GetDevAddr(kerArgs)) + CONTEXT_ALIGN_LEN) :
        argsInfo->args;
    result->smArgs = smArgs;
    result->handle = static_cast<void *>(argHandle);
    mixOpt = (stm->GetModelNum() == 0) ? true : false;
    return RT_ERROR_NONE;

RECYCLE:
    if (copyL2Desc) {
        (void)device_->FreeSPM(smArgs);
    }

    umaArgAllocator->FreeDevMem(kerArgs);
    handleAllocator_->FreeByItem(argHandle);
    return error;
}
TIMESTAMP_EXTERN(LoadInputOutputArgsHuge);
rtError_t UmaArgLoader::Load(const uint32_t kernelType, const rtArgsEx_t * const argsInfo,
                             rtSmDesc_t * const smDesc, Stream * const stm, ArgLoaderResult * const result)
{
    Handle *argHandle = nullptr;
    rtError_t error;
    void *kerArgs = argsInfo->args;
    void *smArgs = smDesc;
    bool copyL2Desc = false;
    bool freeL2Desc = false;
    bool copyArgs = false;
    const uint32_t size = argsInfo->argsSize;
    void * const args = argsInfo->args;
    H2DCopyMgr *umaArgAllocator = ((size > itemSize_) && (maxArgAllocator_ != nullptr)) ?
        maxArgAllocator_ : argAllocator_;

    if ((argPcieBarAllocator_ != nullptr) && (size <= PCIE_BAR_COPY_SIZE)) {
        umaArgAllocator = argPcieBarAllocator_;
    }
    argHandle = static_cast<Handle *>(handleAllocator_->AllocItem());
    NULL_PTR_RETURN(argHandle, RT_ERROR_MEMORY_ALLOCATION);
    if (argsInfo->isNoNeedH2DCopy == 0U) {
        if (size > (ARG_ENTRY_INCRETMENT_SIZE + ARG_ENTRY_SIZE)) {
            umaArgAllocator = randomAllocator_;
            TIMESTAMP_BEGIN(LoadInputOutputArgsHuge);
            error = LoadInputOutputArgsHuge(stm, kerArgs, umaArgAllocator, copyArgs, size, args, argsInfo);
            TIMESTAMP_END(LoadInputOutputArgsHuge);
        } else {
            error = LoadInputOutputArgs(stm, kerArgs, umaArgAllocator, copyArgs, kernelType, size, args,
                argsInfo);
            if ((error == RT_ERROR_MEMORY_ALLOCATION) && (umaArgAllocator == argPcieBarAllocator_) &&
                device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_ARGS_ALLOC_DEFAULT)) {
                umaArgAllocator = ((size > itemSize_) && (maxArgAllocator_ != nullptr)) ?
                    maxArgAllocator_ : argAllocator_;
                error = LoadInputOutputArgs(stm, kerArgs, umaArgAllocator, copyArgs, kernelType, size, args,
                                            argsInfo);
                RT_LOG(RT_LOG_DEBUG, "alloc pcie bar failed, rollback.");                            
            }
        }
        ERROR_GOTO_MSG_INNER(error, RECYCLE, "load args(size=%u) failed, retCode=%#x.", size,
            static_cast<uint32_t>(error));
    }

    error = LoadSmDescArgs(smDesc, &smArgs, copyL2Desc, freeL2Desc);
    ERROR_GOTO(error, RECYCLE, "load L2 description failed, retCode=%#x.", static_cast<uint32_t>(error));

    argHandle->kerArgs = kerArgs;
    argHandle->smArgs = smArgs;
    argHandle->freeL2Desc = freeL2Desc;
    argHandle->freeArgs = copyArgs;
    argHandle->argsAlloc = umaArgAllocator;
    result->kerArgs = copyArgs ? umaArgAllocator->GetDevAddr(kerArgs) : kerArgs;
    result->smArgs = smArgs;
    result->handle = static_cast<void *>(argHandle);
    return RT_ERROR_NONE;

RECYCLE:
    if (copyL2Desc) {
        (void)device_->FreeSPM(smArgs);
    }
    if (copyArgs) {
        umaArgAllocator->FreeDevMem(kerArgs);
    }
    handleAllocator_->FreeByItem(argHandle);
    return error;
}

rtError_t UmaArgLoader::PureLoad(const uint32_t size, const void * const args, ArgLoaderResult * const result)
{
    Handle *argHandle = nullptr;
    rtError_t error;
    void *kerArgs = nullptr;
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, size > (ARG_ENTRY_INCRETMENT_SIZE + ARG_ENTRY_SIZE),
        RT_ERROR_INVALID_VALUE, "size=%u is more than MaxSize=%u", size,
        (ARG_ENTRY_INCRETMENT_SIZE + ARG_ENTRY_SIZE));

    // auto choose policcy
    H2DCopyMgr *umaArgAllocator = ((size > itemSize_) && (maxArgAllocator_ != nullptr))
                                  ? maxArgAllocator_ : argAllocator_;
    if ((argPcieBarAllocator_ != nullptr) && (size <= PCIE_BAR_COPY_SIZE)) {
        umaArgAllocator = argPcieBarAllocator_;
    }

    argHandle = static_cast<Handle *>(handleAllocator_->AllocItem());
    NULL_PTR_RETURN(argHandle, RT_ERROR_MEMORY_ALLOCATION);

    std::function<void()> const resRecycle = [&umaArgAllocator, &kerArgs, &argHandle, this]() {
        umaArgAllocator->FreeDevMem(kerArgs);
        handleAllocator_->FreeByItem(argHandle);
    };
    ScopeGuard resGuard(resRecycle);

    // DevAddr 128-byte auto-alignment by drv
    kerArgs = umaArgAllocator->AllocDevMem();
    NULL_PTR_RETURN(kerArgs, RT_ERROR_MEMORY_ALLOCATION);

    const uint32_t argItemSize = (size > itemSize_) ? maxItemSize_ : itemSize_;
    const uint64_t cpySize = ((argItemSize > size) ? static_cast<uint64_t>(size) : static_cast<uint64_t>(argItemSize));
    error = umaArgAllocator->H2DMemCopy(kerArgs, args, cpySize);
    ERROR_RETURN_MSG_INNER(error, "H2DMemCopy, kind=%d, retCode=%#x.",
        static_cast<int32_t>(RT_MEMCPY_HOST_TO_DEVICE), error);

    argHandle->kerArgs = kerArgs;
    argHandle->freeArgs = true;
    argHandle->argsAlloc = umaArgAllocator;
    // real DevAddr for PCIE_DMA
    result->kerArgs = umaArgAllocator->GetDevAddr(kerArgs);
    result->handle = static_cast<void *>(argHandle);

    resGuard.ReleaseGuard();
    return RT_ERROR_NONE;
}

rtError_t UmaArgLoader::LoadCpuKernelArgs(const rtArgsEx_t * const argsInfo, Stream * const stm,
                                          ArgLoaderResult * const result)
{
    H2DCopyMgr *umaArgAllocator = nullptr;
    Handle *argHandle = nullptr;
    void *kerArgs = nullptr;
    rtError_t error;
    bool copyArgs = false;

    if ((stm->NonSupportModelCompile()) || (argsInfo->isNoNeedH2DCopy == 0)) {
        uint64_t cpySize;
        if (argsInfo->argsSize > MULTI_GRAPH_ARG_ENTRY_SIZE) {
            COND_RETURN_ERROR(superArgAllocator_ == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
                "superArgAllocator_ is nullptr.");
            kerArgs = superArgAllocator_->AllocDevMem();
            umaArgAllocator = superArgAllocator_;
            cpySize = ((argsInfo->argsSize < MULTI_GRAPH_SUPER_ARG_ENTRY_SIZE) ?
                static_cast<uint64_t>(argsInfo->argsSize) : static_cast<uint64_t>(MULTI_GRAPH_SUPER_ARG_ENTRY_SIZE));
            RT_LOG(RT_LOG_DEBUG, "LoadCpuKernelArgs super arg_size %u.", argsInfo->argsSize);
        } else {
            kerArgs = argAllocator_->AllocDevMem();
            umaArgAllocator = argAllocator_;
            cpySize = ((argsInfo->argsSize < itemSize_) ?
                static_cast<uint64_t>(argsInfo->argsSize) : static_cast<uint64_t>(itemSize_));
        }
        NULL_PTR_RETURN(kerArgs, RT_ERROR_MEMORY_ALLOCATION)
        UpdateArgsAddr(umaArgAllocator->GetDevAddr(kerArgs), argsInfo);

        copyArgs = true;
        error = umaArgAllocator->H2DMemCopy(kerArgs, argsInfo->args, cpySize);
        ERROR_GOTO_MSG_CALL(ERR_MODULE_DRV, error, RECYCLE, "Synchronize memcpy failed, kind=%d, retCode=%#x.",
            static_cast<int32_t>(RT_MEMCPY_HOST_TO_DEVICE), static_cast<uint32_t>(error));
    }

    result->kerArgs = (copyArgs ? umaArgAllocator->GetDevAddr(kerArgs) : argsInfo->args);
    result->handle = handleAllocator_->AllocItem();
    result->smArgs = nullptr;
    NULL_PTR_GOTO_MSG_INNER(result->handle, RECYCLE, error, RT_ERROR_MEMORY_ALLOCATION);

    argHandle = static_cast<Handle *>(result->handle);
    argHandle->freeArgs = copyArgs;
    argHandle->kerArgs = kerArgs;
    argHandle->argsAlloc = umaArgAllocator;
    argHandle->freeL2Desc = false;
    argHandle->smArgs = nullptr;
    return RT_ERROR_NONE;

RECYCLE:
    if (copyArgs) {
        umaArgAllocator->FreeDevMem(kerArgs);
    }
    return error;
}

rtError_t UmaArgLoader::LoadCpuKernelArgsEx(const rtAicpuArgsEx_t * const argsInfo, Stream * const stm,
                                            ArgLoaderResult * const result)
{
    Handle *handle = nullptr;
    void *kerArgs = nullptr;
    H2DCopyMgr *umaArgAllocator = nullptr;
    rtError_t error;
    const uint32_t size = argsInfo->argsSize;
    bool copyArgs = false;

    if ((stm->NonSupportModelCompile()) || (argsInfo->isNoNeedH2DCopy == 0U)) {
        uint64_t cpySize;
        if (size > (ARG_ENTRY_INCRETMENT_SIZE + itemSize_)) {
            // if args size is greater than max size,
            // then get memory from the system instead of the arg mem pool;
            RT_LOG(RT_LOG_DEBUG, "LoadCpuKernelArgsEx using random allocator %u.", size);
            kerArgs = randomAllocator_->AllocDevMem(size);
            umaArgAllocator = randomAllocator_;
            cpySize = static_cast<uint64_t>(size);
        } else if (size > itemSize_) {
            COND_RETURN_ERROR(maxArgAllocator_ == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
                "maxArgAllocator_ is nullptr.");
            kerArgs = maxArgAllocator_->AllocDevMem();
            umaArgAllocator = maxArgAllocator_;
            cpySize = ((size < maxItemSize_) ? static_cast<uint64_t>(size) : static_cast<uint64_t>(maxItemSize_));
            RT_LOG(RT_LOG_DEBUG, "LoadCpuKernelArgsEx arg_size %u.", size);
        } else if ((argPcieBarAllocator_ == nullptr) || ((size <= itemSize_) && (size > PCIE_BAR_COPY_SIZE))) {
            RT_LOG(RT_LOG_DEBUG, "LoadCpuKernelArgsEx using arg allocator %u.", size);
            kerArgs = argAllocator_->AllocDevMem();
            umaArgAllocator = argAllocator_;
            cpySize = ((size < itemSize_) ? static_cast<uint64_t>(size) : static_cast<uint64_t>(itemSize_));
        } else {
            RT_LOG(RT_LOG_DEBUG, "LoadCpuKernelArgsEx using pcie bar allocator %u.", size);
            const bool isLogError =
                device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DFX_ARGS_DOT_ALLOC_ERROR_LOG);
            kerArgs = argPcieBarAllocator_->AllocDevMem(isLogError);
            if ((kerArgs == nullptr) &&
                device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_ARGS_ALLOC_DEFAULT)) {
                kerArgs = argAllocator_->AllocDevMem();
                umaArgAllocator = argAllocator_;
                cpySize = ((size < itemSize_) ? static_cast<uint64_t>(size) : static_cast<uint64_t>(itemSize_));
                RT_LOG(RT_LOG_DEBUG, "alloc pcie bar failed, rollback.");
            } else {
                umaArgAllocator = argPcieBarAllocator_;
                cpySize = ((size < PCIE_BAR_COPY_SIZE) ?
                    static_cast<uint64_t>(size) : static_cast<uint64_t>(PCIE_BAR_COPY_SIZE));
            }
        }
        NULL_PTR_RETURN(kerArgs, RT_ERROR_MEMORY_ALLOCATION)
        UpdateAicpuArgsEx(umaArgAllocator->GetDevAddr(kerArgs), argsInfo);
        copyArgs = true;
        RT_LOG(RT_LOG_DEBUG, "H2DMemCopy src:%p, dst:%p, size:%u.", argsInfo->args, kerArgs, size);
        error = umaArgAllocator->H2DMemCopy(kerArgs, argsInfo->args, cpySize);
        ERROR_GOTO_MSG_CALL(ERR_MODULE_DRV, error, RECYCLE, "Load cpu kernel args failed, kind=%d, retCode=%#x.",
            static_cast<int32_t>(RT_MEMCPY_HOST_TO_DEVICE), static_cast<uint32_t>(error));
    }

    result->kerArgs = (copyArgs ? umaArgAllocator->GetDevAddr(kerArgs) : argsInfo->args);
    result->handle = handleAllocator_->AllocItem();
    result->smArgs = nullptr;
    COND_PROC_GOTO_MSG_CALL(ERR_MODULE_DRV, result->handle == nullptr, RECYCLE,
        error = RT_ERROR_MEMORY_ALLOCATION, "handle alloc failed");

    handle = static_cast<Handle *>(result->handle);
    handle->kerArgs = kerArgs;
    handle->freeArgs = copyArgs;
    handle->argsAlloc = umaArgAllocator;
    handle->freeL2Desc = false;
    handle->smArgs = nullptr;
    return RT_ERROR_NONE;
RECYCLE:
    if (copyArgs) {
        umaArgAllocator->FreeDevMem(kerArgs);
    }
    handleAllocator_->FreeByItem(handle);
    return error;
}

rtError_t UmaArgLoader::GetKernelInfoDevAddr(const char_t * const name, const KernelInfoType type, void ** const addr)
{
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_KERNEL_NAME);

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
            RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
                             "Invalid kernel info type, current type = %d, valid type is %d or %d.",
                             static_cast<int32_t>(type), static_cast<int32_t>(SO_NAME),
                             static_cast<int32_t>(KERNEL_NAME));
            error = RT_ERROR_KERNEL_TYPE;
            break;
        }
    }
    return error;
}

void UmaArgLoader::FindKernelInfoName(std::string &name, std::unordered_map<std::string, void *> &nameMap, const void *addr) const
{
    for (std::pair<std::string, void *> iter : nameMap) {
        if (iter.second == addr) {
            name = iter.first;
            RT_LOG(RT_LOG_INFO, "Find kernel info name %s success!", name.c_str());
            break;
        }
    }
    return;
}

void UmaArgLoader::GetKernelInfoFromAddr(std::string &name, const KernelInfoType type, void* addr)
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
            RT_LOG_INNER_MSG(RT_LOG_ERROR,
                             "Invalid kernel info type, current type = %d, valid type is %d or %d.",
                             static_cast<int32_t>(type), static_cast<int32_t>(SO_NAME),
                             static_cast<int32_t>(KERNEL_NAME));
            break;
        }
    }
    return;
}

void UmaArgLoader::RestoreAiCpuKernelInfo(void)
{
    for (std::pair<std::string, void *> iter : soNameMap_) {
        std::string name = iter.first;
        const void * const src = name.data();
        void * const dst = static_cast<void *>(iter.second);
        const size_t cpySize = strnlen(name.c_str(), static_cast<size_t>(KERNEL_INFO_ENTRY_SIZE - 1U)) + 1UL;
        RT_LOG(RT_LOG_INFO, "addr=%p, SoName=%s, len=%u", dst, name.c_str(), cpySize);
        drv_->MemCopySync(dst, cpySize, src, cpySize, RT_MEMCPY_HOST_TO_DEVICE);
    }

    for (std::pair<std::string, void *> iter : kernelNameMap_) {
        std::string name = iter.first;
        const void * const src = name.data();
        void * const dst = static_cast<void *>(iter.second);
        const size_t cpySize = strnlen(name.c_str(), static_cast<size_t>(KERNEL_INFO_ENTRY_SIZE - 1U)) + 1UL;
        RT_LOG(RT_LOG_INFO, "addr=%p, kernelName=%s, len=%u", dst, name.c_str(), cpySize);
        drv_->MemCopySync(dst, cpySize, src, cpySize, RT_MEMCPY_HOST_TO_DEVICE);
    }
    return;
}
bool UmaArgLoader::CheckPcieBar(void)
{
    if (argPcieBarAllocator_ == nullptr) {
        return false;
    } else {
        return true;
    }
}

rtError_t UmaArgLoader::LoadStreamSwitchNArgs(Stream * const stm, const void * const valuePtr,
                                              const uint32_t valueSize, Stream ** const trueStreamPtr,
                                              const uint32_t elementSize, const rtSwitchDataType_t dataType,
                                              StreamSwitchNLoadResult * const result)
{
    rtError_t error;
    void *valueDevAddr = nullptr;
    void *streamIdDevAddr = nullptr;
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

    Runtime * const rtInstance = Runtime::Instance();
    rtMemType_t memType = rtInstance->GetTsMemType(MEM_REQUEST_FEATURE_DEFAULT, valueDevSize);

    RT_LOG(RT_LOG_DEBUG, "memType=%u, chip type=%d.", static_cast<uint32_t>(memType),
           static_cast<int32_t>(rtInstance->GetChipType()));

    error = drv_->DevMemAlloc(&valueDevAddr, valueDevSize, memType, device_->Id_());
    ERROR_RETURN(error, "Failed to alloc dev value memory, memType=%u, deviceId=%u, retCode=%#x",
        static_cast<uint32_t>(memType), device_->Id_(), static_cast<uint32_t>(error));

    error = drv_->MemCopySync(valueDevAddr, valueDevSize, valuePtr, valueDevSize, RT_MEMCPY_HOST_TO_DEVICE);
    if (error != RT_ERROR_NONE) {
        (void)drv_->DevMemFree(valueDevAddr, device_->Id_());
        RT_LOG(RT_LOG_ERROR,
               "Failed to copy value to device when load stream switchN args, kind=%d, retCode=%#x",
               static_cast<int32_t>(RT_MEMCPY_HOST_TO_DEVICE), static_cast<uint32_t>(error));
        return error;
    }
    stm->PushbackSwitchNArgs(valueDevAddr);

    memType = rtInstance->GetTsMemType(MEM_REQUEST_FEATURE_DEFAULT, streamIdDevSize);
    error = drv_->DevMemAlloc(&streamIdDevAddr, streamIdDevSize, memType, device_->Id_());
    if (error != RT_ERROR_NONE) {
        (void)drv_->DevMemFree(valueDevAddr, device_->Id_());
        RT_LOG(RT_LOG_ERROR, "Failed to alloc device stream ID memory, memType=%u, deviceId=%u, retCode=%#x",
            static_cast<uint32_t>(memType), device_->Id_(), static_cast<uint32_t>(error));
        return error;
    }

    error = drv_->MemCopySync(streamIdDevAddr, streamIdDevSize, vecStreamId.data(),
                              streamIdDevSize, RT_MEMCPY_HOST_TO_DEVICE);
    if (error != RT_ERROR_NONE) {
        (void)drv_->DevMemFree(valueDevAddr, device_->Id_());
        (void)drv_->DevMemFree(streamIdDevAddr, device_->Id_());
        RT_LOG(RT_LOG_ERROR, "Failed to copy true stream ID to device, kind=%d, retCode=%#x",
               static_cast<int32_t>(RT_MEMCPY_HOST_TO_DEVICE), static_cast<uint32_t>(error));
        return error;
    }

    stm->PushbackSwitchNArgs(streamIdDevAddr);
    result->valuePtr = valueDevAddr;
    result->trueStreamPtr = streamIdDevAddr;

    return RT_ERROR_NONE;
}

rtError_t UmaArgLoader::FindOrInsertDevAddr(const char_t * const name,
                                            std::unordered_map<std::string, void *> &nameMap,
                                            void ** const addr) const
{
    rtError_t error = RT_ERROR_NONE;
    std::string kernelInfoName(name);
    const auto iter = nameMap.find(kernelInfoName);
    if (iter != nameMap.end()) {
        *addr = iter->second;
        return RT_ERROR_NONE;
    }

    // Alloc device addr and insert to map
    void * const devAddr = kernelInfoAllocator_->AllocItem();
    if (devAddr == nullptr) {
        RT_LOG(RT_LOG_ERROR, "devAddr is nullptr! Alloc addr for kernel info name %s failed.", name);
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    const size_t cpySize = strnlen(name, static_cast<size_t>(KERNEL_INFO_ENTRY_SIZE - 1U)) + 1UL;
    if (cpySize == KERNEL_INFO_ENTRY_SIZE) {
        char tempName[KERNEL_INFO_ENTRY_SIZE];
        (void)memset_s(&tempName[0], KERNEL_INFO_ENTRY_SIZE, 0, KERNEL_INFO_ENTRY_SIZE);
        (void)memcpy_s(&tempName[0], cpySize - 1, name, cpySize - 1);
        error = drv_->MemCopySync(devAddr, cpySize, static_cast<const void *>(&tempName[0]),
            cpySize, RT_MEMCPY_HOST_TO_DEVICE);
    } else {
        error = drv_->MemCopySync(devAddr, cpySize, static_cast<const void *>(name),
            cpySize, RT_MEMCPY_HOST_TO_DEVICE);
    }

    if (error != RT_ERROR_NONE) {
        kernelInfoAllocator_->FreeByItem(devAddr);
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "MemCopySync for so name %s failed, retCode=%#x",
                         name, static_cast<uint32_t>(error));
        return error;
    }

    *addr = devAddr;
    RT_LOG(RT_LOG_DEBUG, "Alloc device addr for kernel info name %s success!", name);
    (void)nameMap.insert(std::make_pair(kernelInfoName, *addr));
    return RT_ERROR_NONE;
}

rtError_t UmaArgLoader::Release(void * const argHandle)
{
    const rtError_t error = RT_ERROR_NONE;
    if (argHandle == nullptr) {
        return error;
    }

    Handle *hdl = static_cast<Handle *>(argHandle);
    if (hdl->freeArgs) {
        hdl->argsAlloc->FreeDevMem(hdl->kerArgs);
        RT_LOG(RT_LOG_DEBUG, "Release arg memory!");
    }
    if (hdl->freeL2Desc) {
        (void)device_->FreeSPM(hdl->smArgs);
    }

    handleAllocator_->FreeByItem(argHandle);
    return error;
}
}
}
