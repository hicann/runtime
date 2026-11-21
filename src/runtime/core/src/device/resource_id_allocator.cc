/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "resource_id_allocator.hpp"
#include "bitmap.hpp"

namespace cce {
namespace runtime {
namespace {

class BitmapResourceIdAllocator : public ResourceIdAllocator {
public:
    ~BitmapResourceIdAllocator() override
    {
        streamIdBitmap_.reset();
        modelIdBitmap_.reset();
    }

    rtError_t Init(const uint32_t maxStreamIdCnt, const uint32_t maxModelIdCnt) override
    {
        streamIdBitmap_ = std::unique_ptr<Bitmap>(new (std::nothrow) Bitmap(maxStreamIdCnt));
        if (streamIdBitmap_ == nullptr) {
            return RT_ERROR_MEMORY_ALLOCATION;
        }

        rtError_t error = streamIdBitmap_->AllocBitmap();
        if (error != RT_ERROR_NONE) {
            return error;
        }

        modelIdBitmap_ = std::unique_ptr<Bitmap>(new (std::nothrow) Bitmap(maxModelIdCnt));
        if (modelIdBitmap_ == nullptr) {
            return RT_ERROR_MEMORY_ALLOCATION;
        }

        error = modelIdBitmap_->AllocBitmap();
        if (error != RT_ERROR_NONE) {
            return error;
        }

        return RT_ERROR_NONE;
    }

    int32_t AllocStreamId() const override { return (streamIdBitmap_ == nullptr) ? -1 : streamIdBitmap_->AllocId(); }

    void FreeStreamId(const int32_t id) override
    {
        if (streamIdBitmap_ != nullptr) {
            streamIdBitmap_->FreeId(id);
        }
    }

    void OccupyStreamId(const int32_t id) override { return streamIdBitmap_->OccupyId(id); }

    int32_t AllocModelId() const override { return (modelIdBitmap_ == nullptr) ? -1 : modelIdBitmap_->AllocId(); }

    void FreeModelId(const int32_t id) override
    {
        if (modelIdBitmap_ != nullptr) {
            modelIdBitmap_->FreeId(id);
        }
    }

    void OccupyModelId(const int32_t id) override { return modelIdBitmap_->OccupyId(id); }

private:
    std::unique_ptr<Bitmap> streamIdBitmap_;
    std::unique_ptr<Bitmap> modelIdBitmap_;
};

} // namespace

ResourceIdAllocator* CreateResourceIdAllocator() { return new (std::nothrow) BitmapResourceIdAllocator(); }

} // namespace runtime
} // namespace cce
