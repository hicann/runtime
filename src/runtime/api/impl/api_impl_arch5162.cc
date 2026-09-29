/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl.hpp"
#include "context.hpp"
#include "error_message_manage.hpp"
#include "kernel.hpp"
#include "runtime.hpp"
#include "runtime_thread_aicpu.hpp"
#include "stream.hpp"
#include "task_execute_time.h"

namespace cce {
namespace runtime {

rtError_t ApiImpl::NonBlockingLaunchBegin(Stream* const stream, const uint64_t flag)
{
    UNUSED(stream);
    UNUSED(flag);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::NonBlockingLaunchEnd(Stream* const stream, const uint64_t flag)
{
    UNUSED(stream);
    UNUSED(flag);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::CpuKernelLaunchEx(
    const Kernel* const kernel, const uint32_t coreDim, const rtCpuKernelArgs_t* const argsInfo, const TaskCfg& taskCfg,
    Stream* const stm, const uint32_t flag)
{
    UNUSED(taskCfg);
    UNUSED(flag);
    COND_RETURN_ERROR(
        (kernel == nullptr) || (argsInfo == nullptr), RT_ERROR_INVALID_VALUE, "kernel or argsInfo is null.");
    if (kernel->GetAicpuKernelType_() != static_cast<uint32_t>(KERNEL_TYPE_AICPU)) {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    Context* const context = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(context, RT_ERROR_CONTEXT_NULL);
    Stream* const stream = (stm == nullptr) ? context->DefaultStream_() : stm;
    NULL_PTR_RETURN_MSG(stream, RT_ERROR_STREAM_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        stream, context, RT_ERROR_STREAM_CONTEXT, "Delivering the AI CPU operator task");
    return LaunchRuntimeThreadAicpuKernel(this, kernel, coreDim, argsInfo, stream);
}

rtError_t ApiImpl::DatadumpInfoLoad(const void* const dumpInfo, const uint32_t length, const uint32_t flag)
{
    RT_LOG(RT_LOG_DEBUG, "length=%u, flag=%u.", length, flag);
    if (flag != RT_KERNEL_DEFAULT) {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    Context* const context = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(context, RT_ERROR_CONTEXT_NULL);
    Device* const device = context->Device_();
    COND_RETURN_ERROR(device == nullptr, RT_ERROR_DEVICE_NULL, "Device is null.");
    return LoadRuntimeThreadAicpuDumpInfo(this, device->Id_(), device->DevGetTsId(), dumpInfo, length);
}

rtError_t ApiImpl::SetOpExecuteTimeOutV2(uint64_t timeout, uint64_t* actualTimeout)
{
    Context* const curCtx = CurrentContext(); // 隐式set device
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Runtime* const rtInstance = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rtInstance, RT_ERROR_INSTANCE_NULL);
    const RtTimeoutConfig& timeoutCfg = rtInstance->GetTimeoutConfig();
    COND_RETURN_AND_MSG_OUTER(
        (timeoutCfg.isInit == false), RT_ERROR_DEVICE_RETAIN, ErrorCode::EE1018,
        "Setting the timeout interval for operator execution", "Device is not initialized, call rtSetDevice API first");

    const rtError_t error = rtInstance->SetTimeoutConfig(RT_TIMEOUT_TYPE_OP_EXECUTE, timeout, RT_TIME_UNIT_TYPE_US);
    ERROR_RETURN_MSG_INNER(error, "Failed to set op execute timeout, retCode=%#x.", static_cast<uint32_t>(error));

    if ((timeoutCfg.isOpTimeoutMs) && (timeoutCfg.isCfgOpExcTaskTimeout) && (timeoutCfg.opExcTaskTimeout == 0UL)) {
        *actualTimeout = MAX_UINT64_NUM; // never timeout
    } else {
        uint16_t credit = 0U;
        TransExeTimeoutCfgToKernelCredit(timeout, credit);
        *actualTimeout = static_cast<uint64_t>(static_cast<double>(credit) * timeoutCfg.interval);
    }
    ERROR_RETURN_MSG_INNER(
        SetRuntimeThreadAicpuExecuteTimeout(this, *actualTimeout), "Failed to set RuntimeThreadAicpu execute timeout.");
    RT_LOG(
        RT_LOG_INFO, "set op execute timeout, timeout=%" PRIu64 "us, actualTimeout=%" PRIu64 "us.", timeout,
        *actualTimeout);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::FlushCache(const uint64_t base, const size_t len)
{
    RT_LOG(RT_LOG_INFO, "flush cache base=%" PRIu64 ", len=%zu.", base, len);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        base == 0U, RT_ERROR_INVALID_VALUE, "Cache update", base, "not equal to 0");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        len == 0U, RT_ERROR_INVALID_VALUE, "Cache update", len, "not equal to 0");

    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    rtError_t error = curCtx->Device_()->GetDeviceStatus();
    COND_PROC((error == RT_ERROR_DEVICE_TASK_ABORT), return error);
    return curCtx->Device_()->Driver_()->DevMemFlushCache(base, len);
}

rtError_t ApiImpl::InvalidCache(const uint64_t base, const size_t len)
{
    RT_LOG(RT_LOG_INFO, "invalid cache base=%" PRIu64 ", len=%zu.", base, len);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        base == 0U, RT_ERROR_INVALID_VALUE, "Invalidating cache data", base, "not equal to 0");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        len == 0U, RT_ERROR_INVALID_VALUE, "Invalidating cache data", len, "not equal to 0");

    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    rtError_t error = curCtx->Device_()->GetDeviceStatus();
    COND_PROC((error == RT_ERROR_DEVICE_TASK_ABORT), return error);
    return curCtx->Device_()->Driver_()->DevMemInvalidCache(base, len);
}

} // namespace runtime
} // namespace cce
