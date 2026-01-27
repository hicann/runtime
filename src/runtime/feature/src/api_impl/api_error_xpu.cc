/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_error.hpp"
#include "stream.hpp"
#include "error_message_manage.hpp"
#include "runtime.hpp"
#include "runtime/dev.h"

namespace cce {
namespace runtime {
rtError_t ApiErrorDecorator::SetXpuDevice(const rtXpuDevType devType, const uint32_t devId)
{
    COND_RETURN_OUT_ERROR_MSG_CALL(devType != RT_DEV_TYPE_DPU,
        RT_ERROR_INVALID_VALUE,
        "Xpu devType=%d is invalid, retCode=%#x.",
        devType,
        static_cast<uint32_t>(RT_ERROR_INVALID_VALUE));
    COND_RETURN_OUT_ERROR_MSG_CALL((devId != 0U),
        RT_ERROR_DEVICE_ID,
        "Xpu device_id=%d is invalid, retCode=%#x.",
        devId,
        static_cast<uint32_t>(RT_ERROR_DEVICE_ID));
    bool isHaveDevice = Runtime::Instance()->HaveDevice();
    uint32_t runMode = RT_RUN_MODE_RESERVED;
    (void)drvGetPlatformInfo(&runMode);
    drvError_t drvRet = drvGetPlatformInfo(&runMode);
    COND_RETURN_ERROR_MSG_INNER(drvRet != DRV_ERROR_NONE,
        RT_ERROR_DRV_ERR,
        "drvGetPlatformInfo failed: drvRetCode=%#x!",
        static_cast<uint32_t>(drvRet))
    COND_RETURN_ERROR_MSG_INNER((!isHaveDevice || runMode != RT_RUN_MODE_ONLINE),
        RT_ERROR_DEVICE_INVALID,
        "Check set valid xpu device failed, isHaveDevice=%d, run mode=%u, retCode=%#x.",
        isHaveDevice,
        runMode,
        static_cast<uint32_t>(RT_ERROR_DEVICE_INVALID));
    return impl_->SetXpuDevice(devType, devId);
}

rtError_t ApiErrorDecorator::ResetXpuDevice(const rtXpuDevType devType, const uint32_t devId)
{
    COND_RETURN_ERROR_MSG_INNER(devType != RT_DEV_TYPE_DPU,
        RT_ERROR_INVALID_VALUE,
        "devType=%d is invalid, retCode=%#x",
        devType,
        static_cast<uint32_t>(RT_ERROR_INVALID_VALUE));
    COND_RETURN_ERROR_MSG_INNER(((devId != 0U)),
        RT_ERROR_DEVICE_ID,
        "reset xpu device failed, xpu devId=%d is invalid, retCode=%#x",
        devId,
        static_cast<uint32_t>(RT_ERROR_DEVICE_ID));
    return impl_->ResetXpuDevice(devType, devId);
}

rtError_t ApiErrorDecorator::GetXpuDevCount(const rtXpuDevType devType, uint32_t *devCount)
{
    COND_RETURN_ERROR_MSG_INNER(devType != RT_DEV_TYPE_DPU, RT_ERROR_INVALID_VALUE,
        "devType=%d is invalid, retCode=%#x", devType, static_cast<uint32_t>(RT_ERROR_INVALID_VALUE));
    return impl_->GetXpuDevCount(devType, devCount);
}

}
}