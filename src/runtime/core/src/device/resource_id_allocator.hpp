/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_RESOURCE_ID_ALLOCATOR_HPP
#define CCE_RUNTIME_RESOURCE_ID_ALLOCATOR_HPP

#include <cstdint>

namespace cce {
namespace runtime {

class ResourceIdAllocator {
public:
    ResourceIdAllocator() = default;
    virtual ~ResourceIdAllocator() = default;
    ResourceIdAllocator(const ResourceIdAllocator&) = delete;
    ResourceIdAllocator& operator=(const ResourceIdAllocator&) = delete;

    virtual int32_t Init(const uint32_t maxStreamIdCnt, const uint32_t maxModelIdCnt) = 0;
    virtual int32_t AllocStreamId() const = 0;
    virtual void FreeStreamId(int32_t id) = 0;
    virtual void OccupyStreamId(const int32_t id) = 0;
    virtual int32_t AllocModelId() const = 0;
    virtual void FreeModelId(int32_t id) = 0;
    virtual void OccupyModelId(const int32_t id) = 0;
};

ResourceIdAllocator* CreateResourceIdAllocator();

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_RESOURCE_ID_ALLOCATOR_HPP
