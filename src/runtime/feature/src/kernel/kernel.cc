/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "kernel.hpp"
#include <list>
#include "error_message_manage.hpp"
#include "runtime.hpp"
#include "program.hpp"
#include "context.hpp"
#include "toolchain/prof_api.h"

namespace cce {
namespace runtime {
Kernel::Kernel(const void * const stubFunc, const char_t * const kernelName, const char_t * const kernelInfoExtern,
    Program * const prog, const uint32_t funcOffset1, const uint32_t funcOffset2, const uint8_t mixType,
    const uint32_t taskRation, const uint32_t funcType)
    : program_(prog), kernelType_(0), stubFun_(stubFunc), name_(kernelName), tilingKey_(0ULL),
      offset1_(funcOffset1), offset2_(funcOffset2), length1_(0U), length2_(0U),
      pctraceFlag_(0U), nameOffset_(0U), mixType_(mixType), taskRation_(taskRation),
      funcType_(funcType), dfxAddr_(nullptr), dfxSize_(0), elfDataFlag_(0), nameId_(0U),
      simtFlag_(false), shareMemSize_(0U), prefetchCnt1_(0U), prefetchCnt2_(0U)
{
    if (kernelInfoExtern != nullptr) {
        kernelInfoExt_ = std::string(kernelInfoExtern);
    }

    if (taskRation_ == NONE_TASK_RATION) {
        DevProperties prop;
        rtError_t ret = GET_DEV_PROPERTIES(Runtime::Instance()->GetChipType(), prop);
        if (ret == RT_ERROR_NONE) {
            taskRation_ = prop.defaultTaskRatio;
        }
        RT_LOG(RT_LOG_DEBUG, "GetDevProperties ret=%p.", ret);
    }
}

Kernel::Kernel(const void * const stubFunc, const char_t * const kernelName, const uint64_t key,
    Program * const prog, const uint32_t funcOffset1, const uint32_t funcOffset2, const uint8_t mixType,
    const uint32_t taskRation, const uint32_t funcType)
    : program_(prog), kernelType_(0), stubFun_(stubFunc), name_(kernelName), tilingKey_(key),
      offset1_(funcOffset1), offset2_(funcOffset2), length1_(0U), length2_(0U),
      pctraceFlag_(0U), nameOffset_(0U), mixType_(mixType),
      taskRation_(taskRation), funcType_(funcType), dfxAddr_(nullptr), dfxSize_(0), elfDataFlag_(0), nameId_(0U),
      simtFlag_(false), shareMemSize_(0U), prefetchCnt1_(0U), prefetchCnt2_(0U)
{
    if (taskRation_ == NONE_TASK_RATION) {
        DevProperties prop;
        rtError_t ret = GET_DEV_PROPERTIES(Runtime::Instance()->GetChipType(), prop);
        if (ret == RT_ERROR_NONE) {
            taskRation_ = prop.defaultTaskRatio;
        }
        RT_LOG(RT_LOG_DEBUG, "GetDevProperties ret=%p.", ret);
    }
}

Kernel::Kernel(const std::string &cpuKernelSo, const std::string &cpuFunctionName, const std::string &cpuOpType)
    : program_(nullptr), kernelType_(0), stubFun_(nullptr), name_(cpuOpType), kernelInfoExt_(""), tilingKey_(0ULL), offset1_(0U), offset2_(0U),
	  length1_(0U), length2_(0U), pctraceFlag_(0U), nameOffset_(0U), mixType_(0U), taskRation_(0U), funcType_(0U), userParaNum_(0U),
      systemParaNum_(0U), dfxAddr_(nullptr), dfxSize_(0U), elfDataFlag_(0),
      nameId_(0U), simtFlag_(false), shareMemSize_(0U), prefetchCnt1_(0U), prefetchCnt2_(0U),
	  cpuOpType_(cpuOpType), cpuKernelSo_(cpuKernelSo), cpuFunctionName_(cpuFunctionName)
{
}

uint64_t Kernel::GetNameId()
{
    if (nameId_ != 0U) {
        return nameId_;
    }
    const std::lock_guard<std::mutex> lk(kernelMtx_);
    nameId_ = MsprofStr2Id(name_.c_str(), strlen(name_.c_str()));
    RT_LOG(RT_LOG_DEBUG, "Get kernel name %s id is %llu.", name_.c_str(), nameId_);
    return nameId_;
}

// Get function addr (also known as pc_start) in device.
rtError_t Kernel::GetFunctionDevAddr(uint64_t &func1, uint64_t &func2) const
{
    NULL_PTR_RETURN_MSG(program_, RT_ERROR_PROGRAM_NULL);
    // should check if the program has been loaded to device.
    rtError_t error = program_->CheckLoaded2Device();
    ERROR_RETURN(error, "Get function addr error, failed to load program to device.");
    Context * const curCtx = Runtime::Instance()->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    const uint64_t programBinAlignBaseAddr = RtPtrToValue(program_->GetBinAlignBaseAddr(curCtx->Device_()->Id_()));
    func1 = programBinAlignBaseAddr + static_cast<uint64_t>(offset1_);

    if (offset2_ != 0ULL) {
        func2 = programBinAlignBaseAddr + static_cast<uint64_t>(offset2_);
    }

    RT_LOG(RT_LOG_DEBUG, "Get function device addr, device kernel baseAddr is %#" PRIx64 ", func1 address is %#"
        PRIx64 ", func2 address is %#" PRIx64 ". ", programBinAlignBaseAddr, func1, func2);
    return RT_ERROR_NONE;
}

void Kernel::SetMixMinStackSize()
{
    minStackSize1_ = minStackSize1_ > minStackSize2_ ? minStackSize1_ : minStackSize2_;
}

KernelTable::KernelTable():kernelArr_(nullptr), rtKernelArrPos_(0UL), kernelArrAllocTimes_(1UL)
{
}

KernelTable::~KernelTable()
{
    for (uint32_t i = 0U; i < rtKernelArrPos_; i++) {
        const Kernel * const delKernel = kernelArr_[i].kernel;
        delete delKernel;
    }
    delete [] kernelArr_;
    kernelArr_ = nullptr;
}

void KernelTable::HalfSearch(const uint32_t searchLen, const void * const stub,
                             rtHalfSearchResult_t *halfSearchResult)
{
    int32_t topIndex = searchLen - 1;
    int32_t bottomIndex = 0;
    int32_t middleIndex = 0;
    constexpr int32_t half = 2;
    RT_LOG(RT_LOG_DEBUG, "KernelTable searchLen=%d, stub=%p.", searchLen, stub);
    while (topIndex >= bottomIndex) {
        middleIndex = (topIndex + bottomIndex) / half;
        if (kernelArr_[middleIndex].stub == stub) {
            halfSearchResult->matchFlag = true;
            halfSearchResult->matchIndex = middleIndex;
            return;
        } else if (kernelArr_[middleIndex].stub > stub) {
            topIndex = middleIndex - 1;
        } else {
            bottomIndex = middleIndex + 1;
        }
    }
    halfSearchResult->matchFlag = false;
    halfSearchResult->matchIndex = bottomIndex;
}

rtError_t KernelTable::ArrayInsert(const int32_t insertIndex, const void * const stub,
                                   Kernel *&addKernel)
{
    RT_LOG(RT_LOG_DEBUG, "KernelTable insertIndex=%d.", insertIndex);

    const uint32_t copySize = static_cast<uint32_t>(sizeof(rtKernelArr_t)) *
                              (rtKernelArrPos_ - static_cast<uint32_t>(insertIndex));

    if (copySize > 0) {
        const errno_t ret = memmove_s(kernelArr_ + insertIndex + 1, copySize, kernelArr_ + insertIndex, copySize);
        COND_RETURN_ERROR_MSG_INNER(ret != EOK, RT_ERROR_SEC_HANDLE,
            "Call memmove_s failed, copy size is %u", copySize);
    }

    kernelArr_[insertIndex].stub = stub;
    kernelArr_[insertIndex].kernel = addKernel;

    return RT_ERROR_NONE;
}

rtError_t KernelTable::AllocKernelArr()
{
    if (kernelArr_ == nullptr) {
        kernelArr_ = new (std::nothrow) rtKernelArr_t[kernelArrAllocTimes_ * KERNEL_ARRAY_SIZE_PER_ALLOC];
        if (kernelArr_ == nullptr) {
            RT_LOG(RT_LOG_ERROR, "new KernelTable kernelArr_ failed, Size=%u.",
                   kernelArrAllocTimes_ * KERNEL_ARRAY_SIZE_PER_ALLOC);
        }
        RT_LOG(RT_LOG_DEBUG, "KernelTable AllocKernelArr success.");
    } else if (rtKernelArrPos_ >= kernelArrAllocTimes_ * KERNEL_ARRAY_SIZE_PER_ALLOC) {
        kernelArrAllocTimes_ += 1U;
        rtKernelArr_t *kernelArrTmp =
                      new (std::nothrow) rtKernelArr_t[kernelArrAllocTimes_ * KERNEL_ARRAY_SIZE_PER_ALLOC];
        if (kernelArrTmp == nullptr) {
            RT_LOG(RT_LOG_ERROR, "renew KernelTable kernelArr_ failed, Size=%u.",
                   kernelArrAllocTimes_ * KERNEL_ARRAY_SIZE_PER_ALLOC);
            return RT_ERROR_CALLOC;
        }
        const uint32_t copySize = static_cast<uint32_t>(sizeof(rtKernelArr_t)) *
                                  (kernelArrAllocTimes_ - 1U) * KERNEL_ARRAY_SIZE_PER_ALLOC;
        const errno_t ret =
            memcpy_s(kernelArrTmp, static_cast<size_t>(copySize), kernelArr_, static_cast<size_t>(copySize));
        if (ret != EOK) {
            RT_LOG(RT_LOG_ERROR, "Call memcpy_s failed, copy size is %u", copySize);
            delete [] kernelArrTmp;
            kernelArrTmp = nullptr;
            return RT_ERROR_SEC_HANDLE;
        }

        delete [] kernelArr_;
        kernelArr_ = kernelArrTmp;
        kernelArrTmp = nullptr;
        RT_LOG(RT_LOG_DEBUG, "KernelTable realloc success.");
    } else {
        // nothing
    }
    return RT_ERROR_NONE;
}

rtError_t KernelTable::Add(Kernel *&addKernel)
{
    rtError_t error = RT_ERROR_NONE;
    rtHalfSearchResult_t halfSearchResult;
    const void *stub = addKernel->Stub_();
    const std::string kernelName = addKernel->Name_();
    const char_t *kernelInfoExt = addKernel->KernelInfoExt_();

    kernelMapLock_.Lock();
    error = AllocKernelArr();
    COND_PROC_RETURN_ERROR(error != 0, static_cast<uint32_t>(error), kernelMapLock_.Unlock(),
        "KernelTable AllocKernelArr failed, retCode=%#x.", static_cast<uint32_t>(error));
    HalfSearch(rtKernelArrPos_, stub, &halfSearchResult);
    if (!halfSearchResult.matchFlag) {
        error = ArrayInsert(halfSearchResult.matchIndex, stub, addKernel);
        COND_PROC_RETURN_ERROR(error != 0, static_cast<uint32_t>(error), kernelMapLock_.Unlock(),
            "KernelTable ArrayInsert failed, retCode=%#x.", static_cast<uint32_t>(error));
        invKernelMap_[kernelName] = stub;
        kernelInfoExtMap_[kernelInfoExt] = addKernel;
        const Program *prog = addKernel->Program_();
        (void)programStubMultiMap_.insert({prog, stub});
        rtKernelArrPos_ += 1;
    } else {
        const std::string temp = kernelArr_[halfSearchResult.matchIndex].kernel->Name_();
        RT_LOG_CALL_MSG(ERR_MODULE_TBE, "Add kernel failed, using registered stubfun=%p --> kernel_name=%s", stub,
                        temp.c_str());
        kernelMapLock_.Unlock();
        return RT_ERROR_KERNEL_DUPLICATE;
    }
    kernelMapLock_.Unlock();

    RT_LOG(RT_LOG_DEBUG, "KernelTable add kernel %s success.", kernelName.c_str());
    return error;
}

rtError_t KernelTable::RemoveAll(const Program * const prog)
{
    kernelMapLock_.Lock();
    const auto iterRange = programStubMultiMap_.equal_range(prog);
    for (auto iter = iterRange.first; iter != iterRange.second; ++iter) {
        const void * const stub = iter->second;
        rtHalfSearchResult_t halfSearchResult;
        HalfSearch(rtKernelArrPos_, stub, &halfSearchResult);
        if (halfSearchResult.matchFlag) {
            const Kernel * const delKernel = kernelArr_[halfSearchResult.matchIndex].kernel;
            (void)invKernelMap_.erase(delKernel->Name_());
            (void)kernelInfoExtMap_.erase(delKernel->KernelInfoExt_());
            const uint32_t copySize = sizeof(rtKernelArr_t) *
                                      ((rtKernelArrPos_ - static_cast<uint32_t>(halfSearchResult.matchIndex)) -
                                       1U);

            if (copySize > 0) {
                const errno_t ret = memmove_s(kernelArr_ + halfSearchResult.matchIndex, copySize,
                                        kernelArr_ + halfSearchResult.matchIndex + 1, copySize);
                COND_PROC_RETURN_ERROR(ret != EOK, RT_ERROR_SEC_HANDLE, kernelMapLock_.Unlock(),
                    "Call memmove_s failed, copy size is %u", copySize);
            }

            delete delKernel;
            rtKernelArrPos_ -= 1;
        }
    }
    (void)programStubMultiMap_.erase(iterRange.first, iterRange.second);
    kernelMapLock_.Unlock();

    return RT_ERROR_NONE;
}

// 找到kernel后会使prog ref+1,
Kernel *KernelTable::Lookup(const void * const stub)
{
    Kernel *retKernel = nullptr;
    rtHalfSearchResult_t halfSearchResult;
    kernelMapLock_.Lock();
    HalfSearch(rtKernelArrPos_, stub, &halfSearchResult);
    retKernel = halfSearchResult.matchFlag ?
                kernelArr_[halfSearchResult.matchIndex].kernel : nullptr;
    if (retKernel != nullptr) {
        const Program * const prog = retKernel->Program_();
        const bool notReleased = Runtime::Instance()->GetProgram(prog);
        // Program was releasing and kernel will be deleted later.
        if (!notReleased) {
            retKernel = nullptr;
        }
    }
    kernelMapLock_.Unlock();
    RT_LOG(RT_LOG_DEBUG, "KernelTable Lookup end, stub=%p.", stub);
    return retKernel;
}

// 找到kernel后会使prog ref+1,
const Kernel *KernelTable::KernelInfoExtLookup(const char_t * const stubFunc)
{
    kernelMapLock_.Lock();
    const auto iter = kernelInfoExtMap_.find(std::string(stubFunc));
    const Kernel *kernelObj = (iter != kernelInfoExtMap_.end()) ? iter->second : nullptr;
    if (kernelObj != nullptr) {
        const Program * const prog = kernelObj->Program_();
        const bool notReleased = Runtime::Instance()->GetProgram(prog);
        // Program was releasing and kernel will be deleted later.
        if (!notReleased) {
            kernelObj = nullptr;
        }
    }
    kernelMapLock_.Unlock();
    return kernelObj;
}

const void *KernelTable::InvLookup(const char_t * const name)
{
    kernelMapLock_.Lock();
    const void *func = nullptr;
    const auto iter = invKernelMap_.find(std::string(name));
    if (iter != invKernelMap_.end()) {
        func = iter->second;
    }

    kernelMapLock_.Unlock();
    return func;
}

void KernelTable::ResetAllKernelNameId()
{
    RT_LOG(RT_LOG_DEBUG, "Reset all kernel name id.");
    kernelMapLock_.Lock();
    for (auto &iter : kernelInfoExtMap_) {
        if (iter.second != nullptr) {
            iter.second->ResetNameId();
        }
    }
    kernelMapLock_.Unlock();
}

}  // namespace runtime
}  // namespace cce
