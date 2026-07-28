/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "mem_type.hpp"

namespace cce {
namespace runtime {

// memory type to string
const char_t* MemLocationTypeToStr(const rtMemLocationType type)
{
    switch (type) {
        case RT_MEMORY_LOC_HOST:
            return "RT_MEMORY_LOCATION_HOST";
        case RT_MEMORY_LOC_DEVICE:
            return "RT_MEMORY_LOCATION_DEVICE";
        case RT_MEMORY_LOC_UNREGISTERED:
            return "RT_MEMORY_LOCATION_UNREGISTERED";
        case RT_MEMORY_LOC_MANAGED:
            return "RT_MEMORY_LOCATION_MANAGED";
        case RT_MEMORY_LOC_HOST_NUMA:
            return "RT_MEMORY_LOC_HOST_NUMA";
        default:
            return "RT_MEMORY_LOCATION_MAX";
    }
}

uint16_t GetMemcpyBatchCopyKind(const rtMemcpyBatchAttr& attr)
{
    const auto isHostMemoryLocation = [](const rtMemLocationType type) {
        return (type == RT_MEMORY_LOC_HOST) || (type == RT_MEMORY_LOC_HOST_NUMA);
    };
    const auto isDeviceMemoryLocation = [](const rtMemLocationType type) { return type == RT_MEMORY_LOC_DEVICE; };

    const rtMemLocationType dstType = attr.dstLoc.type;
    const rtMemLocationType srcType = attr.srcLoc.type;
    if (isHostMemoryLocation(srcType) && isHostMemoryLocation(dstType)) {
        return static_cast<uint16_t>(RT_MEMCPY_KIND_HOST_TO_HOST);
    }
    if (isHostMemoryLocation(srcType) && isDeviceMemoryLocation(dstType)) {
        return static_cast<uint16_t>(RT_MEMCPY_KIND_HOST_TO_DEVICE);
    }
    if (isDeviceMemoryLocation(srcType) && isHostMemoryLocation(dstType)) {
        return static_cast<uint16_t>(RT_MEMCPY_KIND_DEVICE_TO_HOST);
    }
    if (isDeviceMemoryLocation(srcType) && isDeviceMemoryLocation(dstType)) {
        return static_cast<uint16_t>(RT_MEMCPY_KIND_DEVICE_TO_DEVICE);
    }
    return static_cast<uint16_t>(RT_MEMCPY_KIND_MAX);
}

} // namespace runtime
} // namespace cce
