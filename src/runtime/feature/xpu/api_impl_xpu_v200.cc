/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "api_impl_david.hpp"
#include "base.hpp"
#include "context.hpp"
#include "inner_thread_local.hpp"
#include "runtime.hpp"
#include "tprt.hpp"
#include "tprt_api.h"
#include "xpu_device.hpp"

namespace cce {
namespace runtime {

rtError_t ApiImplDavid::XpuProfilingCommandHandle(uint32_t type, void *data, uint32_t len)
{
    if (type != PROF_CTRL_SWITCH) {
        RT_LOG(RT_LOG_WARNING, "dose not support the type: %u", type);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    RT_LOG(RT_LOG_DEBUG, "len:%u.", len);
    NULL_PTR_RETURN_MSG(data, RT_ERROR_INVALID_VALUE);

    if (len != sizeof(rtProfCommandHandle_t)) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(len, sizeof(rtProfCommandHandle_t));
        return RT_ERROR_INVALID_VALUE;
    }

    rtProfCommandHandle_t * const profilerConfig = static_cast<rtProfCommandHandle_t *>(data);
    if (profilerConfig->type == PROF_COMMANDHANDLE_TYPE_START) {
        Context * const curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        XpuDevice * const xpuDevice = static_cast<XpuDevice *>(curCtx->Device_());
        xpuDevice->SetXpuTaskReportEnable(true);
        TprtProfilingEnable(true);
        return RT_ERROR_NONE;
    } else if (profilerConfig->type == PROF_COMMANDHANDLE_TYPE_STOP) {
        Context * const curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        XpuDevice * const xpuDevice = static_cast<XpuDevice *>(curCtx->Device_());
        xpuDevice->SetXpuTaskReportEnable(false);
        TprtProfilingEnable(false);
        return RT_ERROR_NONE;
    } else {
        RT_LOG(RT_LOG_INFO, "runtime does not support type:%u", profilerConfig->type);
    }
    return RT_ERROR_NONE;
}

rtError_t XpuProfilingHandle(uint32_t type, void *data, uint32_t len)
{
    Api * const apiInstance = Runtime::Instance()->ApiImpl_();
    return apiInstance->XpuProfilingCommandHandle(type, data, len);
}

rtError_t ApiImplDavid::SetXpuDevice(const rtXpuDevType devType, const uint32_t devId)
{
    RT_LOG(RT_LOG_INFO, "Set xpu device device_id=%u, devType=%u.", devId, devType);
    Runtime *const rt = Runtime::Instance();
    Context *context = nullptr;
    {
        const std::unique_lock<std::mutex> xpuSetDevLock(rt->XpuSetDevMutex());
        if (rt->GetXpuDevice() == nullptr) {
            context = rt->PrimaryXpuContextRetain(devId);
            NULL_PTR_RETURN_MSG(context, RT_ERROR_DEVICE_RETAIN);
        } else {
            context = rt->GetXpuCtxt();
            NULL_PTR_RETURN_MSG(context, RT_ERROR_CONTEXT_NULL);
        }
    }
    MsprofRegisterCallback(RUNTIME, &XpuProfilingHandle);

    InnerThreadLocalContainer::SetCurRef(nullptr);
    InnerThreadLocalContainer::SetCurCtx(context);
    MsprofNotifySetDevice(0, devId, true);
    RT_LOG(RT_LOG_INFO, "Set current context success, device_id=%u, curCtx=%p.", devId, context);
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::GetXpuDevCount(const rtXpuDevType devType, uint32_t *devCount)
{
    rtError_t error = RT_ERROR_NONE;
    switch (devType) {
        case RT_DEV_TYPE_DPU:
            *devCount = 1;
            break;
        default:
            RT_LOG(RT_LOG_ERROR, "devType=%d is invalid, retCode=%#x", devType,
                static_cast<uint32_t>(RT_ERROR_INVALID_VALUE));
            error = RT_ERROR_INVALID_VALUE;
            break;
    }
    return error;
}

rtError_t ApiImplDavid::ResetXpuDevice(const rtXpuDevType devType, const uint32_t devId)
{
    (void)devType;
    rtError_t error = RT_ERROR_NONE;
    Runtime *const rt = Runtime::Instance();
    error = rt->PrimaryXpuContextRelease(devId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "DeviceReset failed, drv devId=%u, retCode=%#x",
        devId, static_cast<uint32_t>(error));
    RT_LOG(RT_LOG_INFO, "Succ, drv devId=%u.", devId);
    return error;
}

}  // namespace runtime
}  // namespace cce
