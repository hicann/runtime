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
char_t* MemLocationTypeToStr(const rtMemLocationType type)
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
        default:
            return "RT_MEMORY_LOCATION_MAX";
    }
}

}  // namespace runtime
}  // namespace cce