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
#include "driver/ascend_hal.h"
#include "driver/ascend_hal_define.h"
#include "tsch_defines.h"

namespace cce {
namespace runtime {
void FreeDcacheAddr(const uint32_t deviceId, void *&dcacheAddr, void *&drvHandle)
{
    drvHandle = nullptr;
    if (dcacheAddr != nullptr && halMemCtl != nullptr) {
        struct ProcessCpMunmap munmapInfo;
        munmapInfo.devid = deviceId;
        munmapInfo.ptr = RtPtrToValue(dcacheAddr);
        munmapInfo.size = 0ULL;
        const drvError_t drvRet =
            halMemCtl(CTRL_TYPE_PROCESS_CP_MUNMAP, RtPtrToPtr<void *>(&munmapInfo), sizeof(struct ProcessCpMunmap),
                      nullptr, nullptr);
        if (drvRet != DRV_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "Free dcache stack phy failed, drvRet=%#x.", drvRet);
        }
        dcacheAddr = nullptr;
    }
}

rtError_t AllocAddrForDcache(const uint32_t deviceId, void *&dcacheAddr, const uint64_t size, void *&drvHandle)
{
    COND_RETURN_WARN(halMemCtl == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMemCtl does not exist");
    void *checkTempPtr = nullptr;
    size_t outSize = 0;
    drvError_t drvRet = halMemCtl(CTRL_TYPE_GET_DCACHE_ADDR, nullptr, 0, &checkTempPtr, &outSize);
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "halMemCtl failed, drvRet=%u, outSize=%zu", drvRet, outSize);
        return RT_ERROR_DCACHE_MEM_ALLOC_FAIL;
    }

    struct ProcessCpMmap mmapInfo;
    mmapInfo.devid = deviceId;
    mmapInfo.ptr = RtPtrToValue(checkTempPtr);
    mmapInfo.size = size;
    mmapInfo.flag = 0ULL;
    drvRet =
        halMemCtl(CTRL_TYPE_PROCESS_CP_MMAP, RtPtrToPtr<void *>(&mmapInfo), sizeof(struct ProcessCpMmap), &dcacheAddr, &outSize);
    if (drvRet != DRV_ERROR_NONE || (checkTempPtr != dcacheAddr) || (outSize == 0)) {  // 这里需要将dcacheAddr释放
        RT_LOG(RT_LOG_WARNING,
            "halMemCtl failed, drvRet=%u, checkTempPtr=%p, dcacheAddr=%p, outSize=%zu",
            drvRet,
            checkTempPtr,
            dcacheAddr,
            outSize);
        FreeDcacheAddr(deviceId, dcacheAddr, drvHandle);
        dcacheAddr = nullptr;
        return RT_ERROR_DCACHE_MEM_ALLOC_FAIL;
    }

    RT_LOG(RT_LOG_INFO, "checkTempPtr=%p, dcacheAddr=%p, outSize=%zu", checkTempPtr, dcacheAddr, outSize);
    return RT_ERROR_NONE;
}

rtError_t DcacheLockSendTask(Context *ctx, const uint32_t blockDim, const void * const funcAddr, Stream *stream)
{
    // 算子args需要3个uint64的占位符
    constexpr uint32_t argsSize = 24U;
    uint8_t argsHost[argsSize] = {0U};
    rtArgsEx_t argsInfo = {};
    argsInfo.args = RtPtrToPtr<void *, uint8_t *>(argsHost);
    argsInfo.argsSize = argsSize;
    TaskCfg taskCfg = {};
    taskCfg.isBaseValid = 1U;
    taskCfg.base.schemMode = 1U;
    rtError_t error = ctx->LaunchKernel(funcAddr, blockDim, &argsInfo, nullptr, stream, 0U, &taskCfg, false);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "launch kernel failed, reCode=%#x", error);
        return error;
    }
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce
