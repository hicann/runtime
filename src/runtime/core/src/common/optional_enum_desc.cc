/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "enum_desc.hpp"
#include "capture_model_enum_desc.hpp"

namespace cce {
namespace runtime {

std::string ManagedMemLocationTypeToString(const rtMemManagedLocationType type)
{
    switch (type) {
        case rtMemLocationTypeInvalid:
            return "MEM_LOCATION_TYPE_INVALID(0)";
        case rtMemLocationTypeDevice:
            return "MEM_LOCATION_TYPE_DEVICE(1)";
        case rtMemLocationTypeHost:
            return "MEM_LOCATION_TYPE_HOST(2)";
        case rtMemLocationTypeHostNuma:
            return "MEM_LOCATION_TYPE_HOST_NUMA(3)";
        case rtMemLocationTypeHostNumaCurrent:
            return "MEM_LOCATION_TYPE_HOST_NUMA_CURRENT(4)";
        default:
            return RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(type));
    }
}

std::string MemPoolAttrToString(const rtMemPoolAttr attr)
{
    switch (attr) {
        case rtMemPoolReuseFollowEventDependencies:
            return "rtMemPoolReuseFollowEventDependencies(1)";
        case rtMemPoolReuseAllowOpportunistic:
            return "rtMemPoolReuseAllowOpportunistic(2)";
        case rtMemPoolReuseAllowInternalDependencies:
            return "rtMemPoolReuseAllowInternalDependencies(3)";
        case rtMemPoolAttrReleaseThreshold:
            return "rtMemPoolAttrReleaseThreshold(4)";
        case rtMemPoolAttrReservedMemCurrent:
            return "rtMemPoolAttrReservedMemCurrent(5)";
        case rtMemPoolAttrReservedMemHigh:
            return "rtMemPoolAttrReservedMemHigh(6)";
        case rtMemPoolAttrUsedMemCurrent:
            return "rtMemPoolAttrUsedMemCurrent(7)";
        case rtMemPoolAttrUsedMemHigh:
            return "rtMemPoolAttrUsedMemHigh(8)";
        default:
            return RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(attr));
    }
}

std::string StreamCaptureStatusToString(const rtStreamCaptureStatus status)
{
    switch (status) {
        case RT_STREAM_CAPTURE_STATUS_NONE:
            return "STREAM_CAPTURE_STATUS_NONE(0)";
        case RT_STREAM_CAPTURE_STATUS_ACTIVE:
            return "STREAM_CAPTURE_STATUS_ACTIVE(1)";
        case RT_STREAM_CAPTURE_STATUS_INVALIDATED:
            return "STREAM_CAPTURE_STATUS_INVALIDATED(2)";
        case RT_STREAM_CAPTURE_STATUS_MAX:
            return "STREAM_CAPTURE_STATUS_MAX(3)";
        default:
            return RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(status));
    }
}

} // namespace runtime
} // namespace cce
