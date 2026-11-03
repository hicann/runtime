/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl_xpu.hpp"
#include "api_impl_xpu_common.hpp"

#include "driver/ascend_hal.h"
#include "error_message_manage.hpp"
#include "runtime.hpp"
#include "task_fail_callback_manager.hpp"

namespace cce {
namespace runtime {

rtError_t CheckSetXpuDeviceParam(const rtXpuDevType devType, const uint32_t devId)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
        devType != RT_DEV_TYPE_DPU, RT_ERROR_INVALID_VALUE, "Setting the extended device to be used",
        RtFmtMsg("%s(%d)", (devType == RT_DEV_TYPE_REV) ? "DEV_TYPE_REV" : "UNKNOWN", static_cast<int32_t>(devType)),
        "devType", "DEV_TYPE_DPU(0)");

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        devId != 0U, RT_ERROR_DEVICE_ID, "Setting the extended device to be used", devId, "0");

    Runtime* const runtime = Runtime::Instance();
    NULL_PTR_RETURN_MSG(runtime, RT_ERROR_INSTANCE_NULL);

    uint32_t runMode = RT_RUN_MODE_RESERVED;
    const drvError_t drvRet = drvGetPlatformInfo(&runMode);
    COND_RETURN_ERROR_MSG_INNER(
        drvRet != DRV_ERROR_NONE, RT_ERROR_DRV_ERR, "drvGetPlatformInfo failed: drvRetCode=%#x.",
        static_cast<uint32_t>(drvRet));

    COND_RETURN_ERROR_MSG_INNER(
        (!runtime->HaveDevice()) || (runMode != RT_RUN_MODE_ONLINE), RT_ERROR_DEVICE_INVALID,
        "Check set valid XPU device failed, isHaveDevice=%d, run mode=%u, retCode=%#x.", runtime->HaveDevice(), runMode,
        static_cast<uint32_t>(RT_ERROR_DEVICE_INVALID));

    return RT_ERROR_NONE;
}

rtError_t CheckResetXpuDeviceParam(const rtXpuDevType devType, const uint32_t devId)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
        devType != RT_DEV_TYPE_DPU, RT_ERROR_INVALID_VALUE, "Resetting the extended device",
        RtFmtMsg("%s(%d)", (devType == RT_DEV_TYPE_REV) ? "DEV_TYPE_REV" : "UNKNOWN", static_cast<int32_t>(devType)),
        "devType", "DEV_TYPE_DPU(0)");

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        devId != 0U, RT_ERROR_DEVICE_ID, "Resetting the extended device", devId, "0");

    return RT_ERROR_NONE;
}

rtError_t ApiImplXpu::GetXpuDevCount(const rtXpuDevType devType, uint32_t* devCount)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
        devType != RT_DEV_TYPE_DPU, RT_ERROR_INVALID_VALUE, "Getting the extended device count",
        RtFmtMsg("%s(%d)", (devType == RT_DEV_TYPE_REV) ? "RT_DEV_TYPE_REV" : "UNKNOWN", static_cast<int32_t>(devType)),
        "devType", "RT_DEV_TYPE_DPU(0)");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(devCount, RT_ERROR_INVALID_VALUE, "Getting the extended device count");

    *devCount = 1;
    return RT_ERROR_NONE;
}

rtError_t ApiImplXpu::ResetXpuDevice(const rtXpuDevType devType, const uint32_t devId)
{
    const rtError_t paramRet = CheckResetXpuDeviceParam(devType, devId);
    if (paramRet != RT_ERROR_NONE) {
        return paramRet;
    }

    rtError_t error = RT_ERROR_NONE;
    Runtime* const rt = Runtime::Instance();
    error = rt->PrimaryXpuContextRelease(devId);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "DeviceReset failed, drv devId=%u, retCode=%#x", devId,
        static_cast<uint32_t>(error));
    RT_LOG(RT_LOG_INFO, "Succ, drv devId=%u.", devId);
    return error;
}

rtError_t ApiImplXpu::XpuSetTaskFailCallback(const rtXpuDevType devType, const char_t* moduleName, void* callback)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
        devType != RT_DEV_TYPE_DPU, RT_ERROR_INVALID_VALUE, "Setting the callback function for XPU task exceptions",
        RtFmtMsg("%s(%d)", (devType == RT_DEV_TYPE_REV) ? "RT_DEV_TYPE_REV" : "UNKNOWN", static_cast<int32_t>(devType)),
        "devType", "RT_DEV_TYPE_DPU(0)");

    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        moduleName, RT_ERROR_INVALID_VALUE, "Setting the callback function for XPU task exceptions");

    return XpuTaskFailCallbackReg(moduleName, callback);
}

} // namespace runtime
} // namespace cce
