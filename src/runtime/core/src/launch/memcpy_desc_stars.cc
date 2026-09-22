/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "memcpy_c.hpp"
#include "device.hpp"
#include "device_properties.h"
#include "driver.hpp"
#include "securec.h"

namespace cce {
namespace runtime {

rtError_t SetMemcpyDesc(
    rtMemcpyDesc_t desc, const void* const srcAddr, const void* const dstAddr, const size_t count,
    const Device* const device)
{
    rtMemcpyAddrInfo memcpyData;
    memset_s(&memcpyData, sizeof(rtMemcpyAddrInfo), 0, sizeof(rtMemcpyAddrInfo));
    memcpyData.len = static_cast<uint32_t>(count);
    memcpyData.src = RtPtrToValue<const void*>(srcAddr);
    memcpyData.dst = RtPtrToValue<const void*>(dstAddr);

    constexpr uint64_t dstMax = MEMCPY_DESC_SIZE_V1;
    rtError_t error = RT_ERROR_NONE;
    if (device->Driver_()->GetRunMode() == RT_RUN_MODE_ONLINE) {
        error = device->Driver_()->MemCopySync(
            desc, dstMax, &memcpyData, sizeof(rtMemcpyAddrInfo), RT_MEMCPY_HOST_TO_DEVICE);
        ERROR_RETURN(error, "Failed to memory copy stream info, device_id=%u, retCode=%#x.", device->Id_(), error);

        error = device->Driver_()->DevMemFlushCache(RtPtrToValue(desc), static_cast<size_t>(dstMax));
        ERROR_RETURN(error, "Failed to flush stream info, device_id=%u, retCode=%#x", device->Id_(), error);
    } else {
        error = device->Driver_()->MemCopySync(
            desc, dstMax, &memcpyData, sizeof(rtMemcpyAddrInfo), RT_MEMCPY_HOST_TO_DEVICE);
        ERROR_RETURN(error, "Failed to memory copy stream info, device_id=%u, retCode=%#x", device->Id_(), error);
    }

    RT_LOG(RT_LOG_INFO, "Set memcpyDesc info success, srcAddr=%p, dstAddr=%p, count=%llu", srcAddr, dstAddr, count);
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
