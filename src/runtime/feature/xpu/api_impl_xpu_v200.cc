/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "common/enum_log.hpp"
#include "runtime/base.h"
#include "api_impl_xpu.hpp"
#include "api_impl_xpu_common.hpp"
#include "base.hpp"
#include "context.hpp"
#include "error_message_manage.hpp"
#include "inner_thread_local.hpp"
#include "runtime.hpp"
#include "tprt.hpp"
#include "tprt_api.h"
#include "xpu_device.hpp"

namespace cce {
namespace runtime {
namespace {
// 仅供 XpuProfilingHandle 回调调用，不作为对外接口
rtError_t XpuProfilingCommandHandle(uint32_t type, void* data, uint32_t len)
{
    if (type != PROF_CTRL_SWITCH) {
        RT_LOG(RT_LOG_WARNING, "does not support the type: %u", type);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    RT_LOG(RT_LOG_DEBUG, "len:%u.", len);
    NULL_PTR_RETURN_MSG(data, RT_ERROR_INVALID_VALUE);

    if (len != sizeof(rtProfCommandHandle_t)) {
        RT_LOG_OUTER_MSG_INVALID_PARAM_WITH_DESC(
            "Processing the profiling control command", len, sizeof(rtProfCommandHandle_t));
        return RT_ERROR_INVALID_VALUE;
    }

    rtProfCommandHandle_t* const profilerConfig = static_cast<rtProfCommandHandle_t*>(data);
    if (profilerConfig->type == PROF_COMMANDHANDLE_TYPE_START) {
        Context* const curCtx = Runtime::Instance()->GetXpuCtxt();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        XpuDevice* const xpuDevice = static_cast<XpuDevice*>(curCtx->Device_());
        NULL_PTR_RETURN_MSG(xpuDevice, RT_ERROR_DEVICE_NULL);
        xpuDevice->SetXpuTaskReportEnable(true);
        TprtProfilingEnable(true);
        return RT_ERROR_NONE;
    } else if (profilerConfig->type == PROF_COMMANDHANDLE_TYPE_STOP) {
        Context* const curCtx = Runtime::Instance()->GetXpuCtxt();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        XpuDevice* const xpuDevice = static_cast<XpuDevice*>(curCtx->Device_());
        NULL_PTR_RETURN_MSG(xpuDevice, RT_ERROR_DEVICE_NULL);
        xpuDevice->SetXpuTaskReportEnable(false);
        TprtProfilingEnable(false);
        return RT_ERROR_NONE;
    } else {
        RT_LOG(RT_LOG_INFO, "runtime does not support type:%u", profilerConfig->type);
    }
    return RT_ERROR_NONE;
}
} // namespace

rtError_t XpuProfilingHandle(uint32_t type, void* data, uint32_t len)
{
    Runtime* const runtime = Runtime::Instance();
    NULL_PTR_RETURN_MSG(runtime, RT_ERROR_INSTANCE_NULL);

    return XpuProfilingCommandHandle(type, data, len);
}

rtError_t ApiImplXpu::SetXpuDevice(const rtXpuDevType devType, const uint32_t devId)
{
    const rtError_t paramRet = CheckSetXpuDeviceParam(devType, devId);
    if (paramRet != RT_ERROR_NONE) {
        return paramRet;
    }

    RT_LOG(
        RT_LOG_INFO, "Set xpu device device_id=%u, devType=" RT_ENUM_LOG_FORMAT("%u") ".", devId,
        RT_ENUM_LOG_VALUE(static_cast<uint32_t>(devType), "DEV_TYPE_DPU"));
    Runtime* const rt = Runtime::Instance();
    Context* context = nullptr;
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
    InnerThreadLocalContainer::SetCurRef(nullptr);
    InnerThreadLocalContainer::SetCurCtx(context);
    MsprofRegisterCallback(RUNTIME, &XpuProfilingHandle);
    RT_LOG(RT_LOG_INFO, "Set current context success, device_id=%u, curCtx=%p.", devId, context);
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
