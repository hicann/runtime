/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "npu_driver_dcache_lock.hpp"
#include "base.hpp"
#include "runtime.hpp"
#include "errcode_manage.hpp"
#include "aix_c.hpp"
#include "driver/ascend_hal.h"
#include "driver/ascend_hal_define.h"
#include "tsch_defines.h"

namespace cce {
namespace runtime {

rtError_t DcacheLockSendTask(Context *ctx, const uint32_t blockDim, const void * const funcAddr, Stream *stream)
{
    (void)ctx;
    // 算子args需要3个uint64的占位符
    constexpr uint32_t argsSize = 24U;
    std::array<uint8_t, argsSize> argsHost{0};
    rtArgsEx_t argsInfo = {};
    argsInfo.args = argsHost.data();
    argsInfo.argsSize = argsSize;
    rtTaskCfgInfo_t cfgInfo = {};
    cfgInfo.schemMode = 1U;
    const rtError_t error = StreamLaunchKernelV1(funcAddr, blockDim, &argsInfo, stream, 0U, &cfgInfo);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "launch kernel failed, reCode=%#x", error);
        return error;
    }
    return RT_ERROR_NONE;
}

rtError_t AllocAddrForDcache(const uint32_t deviceId, void *&dcacheAddr, const uint64_t size, void *&drvHandle)
{
#ifndef CFG_DEV_PLATFORM_PC
    COND_RETURN_WARN(&halMemCreate == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMemCtl does not exist");
    COND_RETURN_WARN(&halMemGetAddressReserveRange == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemGetAddressReserveRange does not exist");
    COND_RETURN_WARN(&halMemAddressReserve == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemAddressReserve does not exist");
    COND_RETURN_WARN(&halMemMap == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemMap does not exist");
    size_t outSize = 0;
    struct drv_mem_prop prop;
    drv_mem_handle_t *handle = nullptr;
    prop.side = MEM_DEV_SIDE;
    prop.devid = deviceId;
    prop.pg_type = MEM_HUGE_PAGE_TYPE;
    prop.mem_type = MEM_HBM_TYPE;
    prop.module_id = MODULEID_RUNTIME;
    prop.reserve = 0ULL;
    const uint64_t readSize = (size % MEM_CTRL_TWO_M_GRANULARITY == 0U) ? size :
        ((size / MEM_CTRL_TWO_M_GRANULARITY + 1U) * MEM_CTRL_TWO_M_GRANULARITY);
    drvError_t drvRet = halMemCreate(&handle, readSize, &prop, 0U);
    if (drvRet != DRV_ERROR_NONE || handle == nullptr) {
        RT_LOG(RT_LOG_WARNING, "drv api] halMemCreate failed, drvRet=%u, size=%lld, readSize=%lld.",
            drvRet, size, readSize);
        return RT_ERROR_DCACHE_MEM_ALLOC_FAIL;
    }
    void *addr = nullptr; 
    const uint64_t offset = deviceId * DCACHE_LOCK_DEVICE_OFFSET;
    drvRet = halMemGetAddressReserveRange(&addr, &outSize, MEM_ADDR_RESERVE_TYPE_DCACHE, 0U);
    if ((drvRet != DRV_ERROR_NONE) || (addr == nullptr) || (static_cast<uint64_t>(outSize) < offset)) {
        (void)halMemRelease(handle);
        RT_LOG(RT_LOG_WARNING, "[drv api]halMemGetAddressReserveRange failed, drvRet=%u, outSize=%zd", drvRet, outSize);
        return RT_ERROR_DCACHE_MEM_ALLOC_FAIL;
    }

    void *readVaAddr = RtPtrToPtr<void *>((RtPtrToPtr<uint8_t *>(addr) + offset));
    void *outAddr = nullptr; 
    drvRet = halMemAddressReserve(&outAddr, readSize, 0U, readVaAddr, static_cast<uint64_t>(MEM_NORMAL_PAGE_TYPE));
    if ((drvRet != DRV_ERROR_NONE) || (outAddr != readVaAddr)) {
        (void)halMemRelease(handle);
        RT_LOG(RT_LOG_WARNING, "[drv api]halMemAddressReserve failed, drvRet=%u, outSize=%zd", drvRet, outSize);
        return RT_ERROR_DCACHE_MEM_ALLOC_FAIL;
    }
    drvRet = halMemMap(outAddr, readSize, 0, handle, 0ULL);
    if (drvRet != DRV_ERROR_NONE) {
        (void)halMemFree(outAddr);
        (void)halMemRelease(handle);
        RT_LOG(RT_LOG_WARNING, "[drv api]halMemMap failed, drvRet=%u, outSize=%zd", drvRet, outSize);
        return RT_ERROR_DCACHE_MEM_ALLOC_FAIL;
    }
    dcacheAddr = outAddr;
    drvHandle = RtPtrToPtr<void *>(handle);
    RT_LOG(RT_LOG_INFO, "readVaAddr=%p, dcacheAddr=0x%p, outSize=%zd, handle=%p, drvHandle=%p.", readVaAddr, dcacheAddr, outSize, handle, drvHandle);
    return RT_ERROR_NONE;
#else
    (void)deviceId;
    (void)dcacheAddr;
    (void)size;
    (void)drvHandle;
    return RT_ERROR_FEATURE_NOT_SUPPORT;
#endif
}

void FreeDcacheAddr(const uint32_t deviceId, void *&dcacheAddr, void *&drvHandle)
{
    (void)deviceId;
    if (dcacheAddr != nullptr && drvHandle != nullptr) {
        COND_RETURN_VOID_WARN(&halMemAddressFree == nullptr, "[drv api] halMemAddressFree does not exist");
        COND_RETURN_VOID_WARN(&halMemUnmap == nullptr, "[drv api] halMemUnmap does not exist");
        COND_RETURN_VOID_WARN(&halMemRelease == nullptr, "[drv api] halMemRelease does not exist");
        (void)halMemUnmap(dcacheAddr);
        (void)halMemAddressFree(dcacheAddr);
        (void)halMemRelease(RtPtrToPtr<drv_mem_handle_t *>(drvHandle));
        dcacheAddr = nullptr;
        drvHandle = nullptr;
    }
}
}  // namespace runtime
}  // namespace cce
