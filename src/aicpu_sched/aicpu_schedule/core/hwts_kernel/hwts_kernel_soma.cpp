/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "hwts_kernel_soma.h"

#include "aicpusd_hal_interface_ref.h"
#include "hwts_kernel_common.h"

namespace AicpuSchedule {
namespace {
const std::string SOMA_MEM_MNG = "SomaMemMng";  // runtime fill kernelName && opName
}

enum class SomaOpType : int32_t {
    SOMA_OP_MALLOC = 0,
    SOMA_OP_FREE = 1,
};

int32_t SomaMemMngTsKernel::Compute(const aicpu::HwtsTsKernel &tsKernelInfo)
{
    const aicpu::HwtsCceKernel &kernel = tsKernelInfo.kernelBase.cceKernel;
    const auto Mng = PtrToPtr<void, SomaMemMng>(ValueToPtr(kernel.paramBase));
    auto op = static_cast<SomaOpType>(Mng->memAsyncOpType);
    soma_mem_pool_t pool = {
        .poolId = Mng->mempoolId,
        .devId = Mng->deviceId
    };
    drvError_t ret = DRV_ERROR_NONE;
    switch (op) {
        case SomaOpType::SOMA_OP_MALLOC:
            aicpusd_info("SOMA: malloc deviceId=%u,mempoolId=%llx,va=%llx,size=%llu,memAsyncSubCMD=%u.", Mng->deviceId, Mng->mempoolId, Mng->va, Mng->size, Mng->memAsyncSubCMD);
            ret = halMemPoolMalloc(pool, Mng->va, Mng->size, Mng->memAsyncSubCMD);
            break;
        case SomaOpType::SOMA_OP_FREE:
            aicpusd_info("SOMA: free deviceId=%u,mempoolId=%llx,va=%llx,memAsyncSubCMD=%u.", Mng->deviceId, Mng->mempoolId, Mng->va, Mng->memAsyncSubCMD);
            ret = halMemPoolFree(pool, Mng->va, Mng->memAsyncSubCMD);
            break;
        default:
            aicpusd_err("Ts Kernel SomaMemMng OpType [%d] is invalid.", static_cast<int32_t>(op));
            ret = DRV_ERROR_INVALID_VALUE;
            break;
    }
    if (ret != DRV_ERROR_NONE) {
        aicpusd_err("Ts Kernel SomaMemMng Compute failed, OpType [%d] had been processed, malloc deviceId=%u,mempoolId=%llx,va=%llx,size=%llu,memAsyncSubCMD=%u, errcode=%d", 
            static_cast<int32_t>(op), Mng->deviceId, Mng->mempoolId, Mng->va, Mng->size, Mng->memAsyncSubCMD, static_cast<int32_t>(ret));
        return AICPU_SCHEDULE_FAIL;
    }
    aicpusd_debug(
        "Finish to process ts kernel stream pool event, OpType [%d] had been processed.", static_cast<int32_t>(op));
    return AICPU_SCHEDULE_OK;
}

REGISTER_HWTS_KERNEL(SOMA_MEM_MNG, SomaMemMngTsKernel);

}  // namespace AicpuSchedule