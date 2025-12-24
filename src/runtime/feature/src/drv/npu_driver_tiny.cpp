/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "npu_driver.hpp"
#include "task.hpp"
#include "driver.hpp"
#include "errcode_manage.hpp"
#include "error_message_manage.hpp"
#include "profiler.hpp"
#include "driver/ascend_hal.h"

namespace cce {
namespace runtime {
rtError_t NpuDriver::UpdateAddrVA2PA(uint64_t devAddr, uint64_t len)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(halUpdateAddress == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halUpdateAddress does not exist");

    drvRet = halUpdateAddress(devAddr, len);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halUpdateAddress does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halUpdateAddress failed. drvRet=%d.", drvRet);
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

}  // namespace runtime
}  // namespace cce