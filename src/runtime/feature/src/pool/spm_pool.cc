/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "spm_pool.hpp"
#include "device.hpp"
#include "error_message_manage.hpp"

namespace {
constexpr uint32_t SPM_ITEM_DEFAULT_SIZE = 512U;
}

namespace cce {
namespace runtime {
SpmPool::SpmPool(Device * const devPtr)
    : NoCopy(),
      spmItemSize_(SPM_ITEM_DEFAULT_SIZE),
      spmPageNum_(16U),
      spmPageSize_(2U * 1024U * 1024U),
      spmPagePad_(512U),
      spmInitCount_((spmPageSize_ - spmPagePad_) / spmItemSize_),
      spmBases_(nullptr),
      dev_(devPtr),
      spmAllocator_(nullptr)
{
}

SpmPool::~SpmPool()
{
    DELETE_O(spmAllocator_);
    DELETE_A(spmBases_);
    dev_ = nullptr;
}

rtError_t SpmPool::Init()
{
    COND_RETURN_ERROR_MSG_INNER((spmPageNum_ == 0U), RT_ERROR_POOL_RESOURCE,
        "Spm pool init failed, page num can not be 0.");
    spmBases_ = new (std::nothrow) uint64_t[spmPageNum_];
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, spmBases_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        "Spm pool init failed, new memory failed.");
    RT_LOG(RT_LOG_INFO, "new buffer ok, Runtime_alloc_size %zu", sizeof(uint64_t) * spmPageNum_);

    uint32_t i = 0U;
    for (; i < spmPageNum_; i++) {
        spmBases_[i] = 0UL;
    }
    constexpr uint32_t zoomSize = 16U;
    const uint32_t spmpoolSize = (dev_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MEM_SPMPOOL_SIZE_DIV)) ? 
        ((spmInitCount_ + 1) / zoomSize - 1) : spmInitCount_;
    spmAllocator_ = new (std::nothrow) BufferAllocator(spmItemSize_, spmpoolSize, spmPageNum_ * spmInitCount_,
        BufferAllocator::LINEAR, &DrvAllocSPM, &DrvFreeSPM, this);

    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, spmAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        "Spm pool init failed, new BufferAllocator failed.");
    RT_LOG(RT_LOG_INFO, "new BufferAllocator ok, Runtime_alloc_size %zu", sizeof(BufferAllocator));

    return RT_ERROR_NONE;
}

rtError_t SpmPool::AllocSPM(void **dptr, const uint64_t size)
{
    NULL_PTR_RETURN(spmAllocator_, RT_ERROR_POOL_RESOURCE);
    UNUSED(size);
    *dptr = spmAllocator_->AllocItem();
    NULL_PTR_RETURN(*dptr, RT_ERROR_MEMORY_ALLOCATION);
    return RT_ERROR_NONE;
}

rtError_t SpmPool::FreeSPM(const void * const dptr)
{
    NULL_PTR_RETURN(spmAllocator_, RT_ERROR_POOL_RESOURCE);
    const int32_t id = spmAllocator_->GetIdByItem(dptr);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, id < 0, RT_ERROR_POOL_RESOURCE, "Free SPM failed, invalid SPM address,"
        "id should be larger than 0, current id is %d", id);
    spmAllocator_->FreeById(id);
    RT_LOG(RT_LOG_DEBUG, "FreeSPM success, id=%d", id);
    return RT_ERROR_NONE;
}

bool SpmPool::IsSPM(const void * const dptr) const
{
    if (likely((dptr != nullptr) && (spmBases_ != nullptr))) {
        for (uint32_t i = 0U; i < spmPageNum_; i++) {
            const uint64_t base = spmBases_[i];
            if ((base != 0ULL) && (base <= RtPtrToValue(dptr)) &&
                    ((RtPtrToValue(dptr)) < (base + spmPageSize_ - spmPagePad_))) {
                return true;
            }
        }
    }
    return false;
}

void *SpmPool::DrvAllocSPM(const size_t size, void * const para)
{
    void *addr = nullptr;
    uint32_t i;
    rtError_t error;

    SpmPool * const spm = static_cast<SpmPool *>(para);

    error = spm->dev_->Driver_()->DevMemAlloc(&addr, static_cast<uint64_t>(size),
        RT_MEMORY_HBM, spm->dev_->Id_());
    COND_LOG(error != RT_ERROR_NONE, "device mem alloc spm failed, "
             "size=%u(bytes), kind=%d, id=%d, retCode=%#x", size, RT_MEMORY_HBM, spm->dev_->Id_(), error);

    for (i = 0U; i < spm->spmPageNum_; i++) {
        if (spm->spmBases_[i] == 0ULL) {
            spm->spmBases_[i] = RtPtrToValue(addr);
            break;
        }
    }
    return addr;
}

void SpmPool::DrvFreeSPM(void * const addr, void * const para)
{
    uint32_t i;
    rtError_t error;
    SpmPool * const spm = static_cast<SpmPool *>(para);

    error = spm->dev_->Driver_()->DevMemFree(addr, spm->dev_->Id_());
    COND_LOG(error != RT_ERROR_NONE, "device mem free spm failed, retCode=%#x", error);

    for (i = 0U; i < spm->spmPageNum_; i++) {
        if (spm->spmBases_[i] == RtPtrToValue(addr)) {
            spm->spmBases_[i] = 0U;
            break;
        }
    }
}

}  // namespace runtime
}  // namespace cce
