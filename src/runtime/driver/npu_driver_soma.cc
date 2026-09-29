/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "npu_driver.hpp"
#include "driver/ascend_hal.h"
#include "error_message_manage.hpp"
#include "npu_driver_base.hpp"
#include "npu_driver_base_soma.hpp"
namespace cce {
namespace runtime {
rtError_t NpuDriver::StreamMemPoolCreate(
    const uint32_t deviceId, const uint64_t poolId, const uint64_t size, bool isGraphPool, uint64_t& outVa)
{
    UNUSED(isGraphPool);

    COND_RETURN_WARN(
        &halMemPoolCreate == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMemPoolCreate does not exist.");

    soma_mem_pool_t pool = {.poolId = poolId, .devId = deviceId};

    struct drv_mem_prop mem_prop = {
        .side = MEM_DEV_SIDE,
        .devid = deviceId,
        .module_id = ASCENDCL_MODULE_ID,
        .pg_type = MEM_HUGE_PAGE_TYPE,
        .mem_type = MEM_HBM_TYPE,
        .reserve = 0};

    soma_mem_pool_prop prop = {
        .handle_type = static_cast<drv_mem_handle_type>(RT_MEM_HANDLE_TYPE_POSIX),
        .mem_prop = mem_prop,
        .va = 0ULL,
        .maxSize = size};

    drvError_t drvRet = halMemPoolCreate(pool, &prop);
    DRV_PROCESS_ERROR_RETURN(
        drvRet, "Call driver api halMemPoolCreate failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));

    COND_RETURN_ERROR(prop.va == 0ULL, RT_ERROR_INVALID_VALUE, "Driver returns an invalid pool va=%#" PRIx64, prop.va);

    outVa = prop.va;
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::StreamMemPoolDestroy(const uint32_t deviceId, const uint64_t poolId)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    soma_mem_pool_t pool = {.poolId = poolId, .devId = deviceId};

    COND_RETURN_WARN(
        &halMemPoolDestroy == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMemPoolDestroy does not exist");
    drvRet = halMemPoolDestroy(pool);
    DRV_PROCESS_ERROR_RETURN(
        drvRet, "Call driver api halMemPoolDestroy failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::StreamMemPoolTrim(
    const uint32_t deviceId, const uint64_t poolId, uint64_t* size, uint64_t poolUsedSize, uint64_t poolFreeSize)
{
    COND_RETURN_WARN(
        &halMemPoolTrim == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMemPoolTrim does not exist");

    soma_mem_pool_t pool = {.poolId = poolId, .devId = deviceId};
    const drvError_t drvRet = halMemPoolTrim(pool, size, poolUsedSize, poolFreeSize);
    DRV_PROCESS_ERROR_RETURN(
        drvRet, "Call driver api halMemPoolTrim failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::StreamMemPoolAsyncConfig(
    const uint32_t deviceId, const uint64_t poolId, const uint64_t va, const uint64_t size,
    const halMemPoolConfig_t config)
{
    COND_RETURN_WARN(
        &halMemPoolAsyncConfig == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemPoolAsyncConfig does not exist");

    soma_mem_pool_t pool = {.poolId = poolId, .devId = deviceId};
    const drvError_t drvRet = halMemPoolAsyncConfig(pool, va, size, config);
    DRV_PROCESS_ERROR_RETURN(
        drvRet, "Call driver api halMemPoolAsyncConfig failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));
    return RT_ERROR_NONE;
}

static soma_mem_pool_attr ConvertMemPoolAttr(rtMemPoolAttr attr)
{
    switch (attr) {
        case rtMemPoolAttrReleaseThreshold:
            return MEM_POOL_ATTR_RELEASE_THRESHOLD;
        case rtMemPoolAttrReservedMemCurrent:
            return MEM_POOL_ATTR_RESERVED_MEM_CURRENT;
        case rtMemPoolAttrReservedMemHigh:
            return MEM_POOL_ATTR_RESERVED_MEM_HIGH;
        case rtMemPoolAttrUsedMemCurrent:
            return MEM_POOL_ATTR_USED_MEM_CURRENT;
        case rtMemPoolAttrUsedMemHigh:
            return MEM_POOL_ATTR_USED_MEM_HIGH;
        default:
            return MEM_POOL_ATTR_MAX;
    }
}

rtError_t NpuDriver::StreamMemPoolSetAttr(
    const uint32_t deviceId, const uint64_t poolId, const rtMemPoolAttr attr, void* value)
{
    COND_RETURN_WARN(
        &halMemPoolSetAttr == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMemPoolSetAttr does not exist");

    const soma_mem_pool_attr halAttr = ConvertMemPoolAttr(attr);
    if (halAttr == MEM_POOL_ATTR_MAX) {
        return RT_ERROR_INVALID_VALUE;
    }
    soma_mem_pool_t pool = {.poolId = poolId, .devId = deviceId};
    const drvError_t drvRet = halMemPoolSetAttr(pool, halAttr, value);
    DRV_PROCESS_ERROR_RETURN(
        drvRet, "Call driver api halMemPoolSetAttr failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::StreamMemPoolGetAttr(
    const uint32_t deviceId, const uint64_t poolId, const rtMemPoolAttr attr, void* value)
{
    COND_RETURN_WARN(
        &halMemPoolGetAttr == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMemPoolGetAttr does not exist");

    const soma_mem_pool_attr halAttr = ConvertMemPoolAttr(attr);
    if (halAttr == MEM_POOL_ATTR_MAX) {
        return RT_ERROR_INVALID_VALUE;
    }
    soma_mem_pool_t pool = {.poolId = poolId, .devId = deviceId};
    const drvError_t drvRet = halMemPoolGetAttr(pool, halAttr, value);
    DRV_PROCESS_ERROR_RETURN(
        drvRet, "Call driver api halMemPoolGetAttr failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
