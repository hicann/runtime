/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_handle_guard.h"

#include "api.hpp"
#include "api_global_err.h"
#include "args/args_inner.h"
#include "errcode_manage.hpp"
#include "error_message_manage.hpp"
#include "spec/base_info.hpp"

namespace cce {
namespace runtime {
namespace {

rtError_t ReportApiHandleValidationError(const rtError_t errCode, const char_t* callerFuncName)
{
    const std::string errorStr = RT_GET_ERRDESC(errCode);
    RT_LOG(RT_LOG_ERROR, "%s", errorStr.c_str());
    ErrorMessageUtils::FuncErrorReason(errCode, callerFuncName);
    RT_LOG_FLUSH();
    return GetRtExtErrCodeAndSetGlobalErr(errCode);
}

static bool HasExpectedMagic(const void* handle, const uint64_t expectedMagic)
{
    const auto* const innerObject = static_cast<const rtInnerObject*>(handle);
    return innerObject->magic.load(std::memory_order_acquire) == expectedMagic;
}

template <typename T>
rtError_t ProbeValidatedObject(const void* handle, T*& outRealObj)
{
    if (handle == nullptr) {
        outRealObj = nullptr;
        return RT_ERROR_NONE;
    }

    const auto* const innerObject = static_cast<const rtInnerObject*>(handle);
    if (innerObject->magic.load(std::memory_order_acquire) != RtMagicTraits<T>::value) {
        return RT_ERROR_INVALID_HANDLE;
    }

    outRealObj = static_cast<T*>(innerObject->object);
    return RT_ERROR_NONE;
}

} // namespace

rtError_t ValidateModelHandleForApi(rtModel_t handle, Model*& outRealObj, const char_t* callerFuncName)
{
    const rtError_t ret = GetValidatedObject<Model>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateLabelHandleForApi(rtLabel_t handle, Label*& outRealObj, const char_t* callerFuncName)
{
    const rtError_t ret = GetValidatedObject<Label>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateLabelHandleArrayForApi(
    rtLabel_t* handles, size_t count, std::vector<Label*>& outRealObjs, const char_t* callerFuncName)
{
    const rtError_t ret = GetValidatedObjectArray<Label>(handles, count, outRealObjs);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateStreamHandleForApi(rtStream_t handle, Stream*& outRealObj, const char_t* callerFuncName)
{
    const rtError_t ret = GetValidatedObject<Stream>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateEventHandleForApi(rtEvent_t handle, Event*& outRealObj, const char_t* callerFuncName)
{
    const rtError_t ret = GetValidatedObject<Event>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateNotifyHandleForApi(rtNotify_t handle, Notify*& outRealObj, const char_t* callerFuncName)
{
    const rtError_t ret = GetValidatedObject<Notify>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateCountNotifyHandleForApi(rtCntNotify_t handle, CountNotify*& outRealObj, const char_t* callerFuncName)
{
    const rtError_t ret = GetValidatedObject<CountNotify>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateCondHandleHandleForApi(rtCondHandle_t handle, CondHandle*& outRealObj, const char_t* callerFuncName)
{
    const rtError_t ret = GetValidatedObject<CondHandle>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateProgramHandleForApi(rtBinHandle handle, Program*& outRealObj, const char_t* callerFuncName)
{
    const rtError_t ret = GetValidatedObject<Program>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateKernelHandleForApi(const void* handle, Kernel*& outRealObj, const char_t* callerFuncName)
{
    const rtError_t ret = GetValidatedObject<Kernel>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ConvertFuncToKernel(
    Api* const apiInstance, const void* func, Kernel*& kernel, const char_t* const callerFuncName)
{
    Kernel* symbolKernel = nullptr;
    const rtError_t ret = apiInstance->GetFunctionBySymbol(func, &symbolKernel);
    // 若用户传入的参数已经是 func handle，GetFunctionBySymbol 会找不到对应的 handle 返回错误。
    // 这是正常情况，因此失败时不直接返回，而是将 func 当作 handle 使用。
    if (ret == RT_ERROR_NONE) {
        RT_LOG(RT_LOG_INFO, "find function handle by symbol");
        kernel = symbolKernel;
        return RT_ERROR_NONE;
    } else if (ret == RT_ERROR_INVALID_DEVICE_FUNCTION) {
        RT_LOG(RT_LOG_INFO, "cannot find function handle by symbol, treat func as handle directly");
        return ValidateKernelHandleForApi(func, kernel, callerFuncName);
    } else {
        ErrorMessageUtils::FuncErrorReason(ret, callerFuncName);
        RT_LOG_FLUSH();
        return GetRtExtErrCodeAndSetGlobalErr(ret);
    }
}

rtError_t ValidateArgsHandleForApi(rtArgsHandle handle, RtArgsHandle*& outRealObj, const char_t* callerFuncName)
{
    const rtError_t ret = ProbeValidatedObject<RtArgsHandle>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    }

    RtArgsHandle* const legacyArgsHandle = RtPtrToPtr<RtArgsHandle*>(handle);
    if (legacyArgsHandle != nullptr) {
        RtArgsHandle* realArgsHandle = nullptr;
        const rtError_t legacyRet = ProbeValidatedObject<RtArgsHandle>(
            RtPtrToPtr<rtArgsHandle>(RtInnerHandleAccessor<RtArgsHandle>::Get(legacyArgsHandle)), realArgsHandle);
        if ((legacyRet == RT_ERROR_NONE) && (realArgsHandle == legacyArgsHandle)) {
            outRealObj = legacyArgsHandle;
            return RT_ERROR_NONE;
        }
    }

    return ReportApiHandleValidationError(ret, callerFuncName);
}

rtError_t ValidateArgsHandleForUserMemApi(rtArgsHandle handle, RtArgsHandle*& outRealObj, const char_t* callerFuncName)
{
    if (handle == nullptr) {
        outRealObj = nullptr;
        return RT_ERROR_NONE;
    }

    if (HasExpectedMagic(handle, RT_ARGS_HANDLE_MAGIC)) {
        return ValidateArgsHandleForApi(handle, outRealObj, callerFuncName);
    }

    RtArgsHandle* const legacyArgsHandle = RtPtrToPtr<RtArgsHandle*>(handle);
    RtArgsHandle* realArgsHandle = nullptr;
    const rtError_t ret = GetValidatedObject<RtArgsHandle>(
        RtPtrToPtr<rtArgsHandle>(RtInnerHandleAccessor<RtArgsHandle>::Get(legacyArgsHandle)), realArgsHandle);
    if ((ret == RT_ERROR_NONE) && (realArgsHandle == legacyArgsHandle)) {
        outRealObj = legacyArgsHandle;
        return RT_ERROR_NONE;
    }

    return ReportApiHandleValidationError(RT_ERROR_INVALID_HANDLE, callerFuncName);
}

rtError_t ValidateParamHandleForApi(rtParaHandle handle, ParaDetail*& outRealObj, const char_t* callerFuncName)
{
    const rtError_t ret = GetValidatedObject<ParaDetail>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateLaunchArgsHandleForApi(
    rtLaunchArgsHandle handle, rtLaunchArgs_t*& outRealObj, const char_t* callerFuncName)
{
    const rtError_t ret = ProbeValidatedObject<rtLaunchArgs_t>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    }

    rtLaunchArgs_t* const legacyLaunchArgs = RtPtrToPtr<rtLaunchArgs_t*>(handle);
    if (legacyLaunchArgs != nullptr) {
        rtLaunchArgs_t* realLaunchArgs = nullptr;
        const rtError_t legacyRet = ProbeValidatedObject<rtLaunchArgs_t>(
            RtPtrToPtr<rtLaunchArgsHandle>(RtInnerHandleAccessor<rtLaunchArgs_t>::Get(legacyLaunchArgs)),
            realLaunchArgs);
        if ((legacyRet == RT_ERROR_NONE) && (realLaunchArgs == legacyLaunchArgs)) {
            outRealObj = legacyLaunchArgs;
            return RT_ERROR_NONE;
        }
    }

    return ReportApiHandleValidationError(ret, callerFuncName);
}

} // namespace runtime
} // namespace cce
