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

#include "api_global_err.h"
#include "args/args_inner.h"
#include "base.hpp"
#include "errcode_manage.hpp"
#include "error_message_manage.hpp"
#include "spec/base_info.hpp"

namespace cce {
namespace runtime {
namespace {

rtError_t ReportApiHandleValidationError(const rtError_t errCode, const char_t *callerFuncName)
{
    const std::string errorStr = RT_GET_ERRDESC(errCode);
    RT_LOG(RT_LOG_ERROR, "%s", errorStr.c_str());
    ErrorMessageUtils::FuncErrorReason(errCode, callerFuncName);
    RT_LOG_FLUSH();
    return GetRtExtErrCodeAndSetGlobalErr(errCode);
}

} // namespace

rtError_t ValidateModelHandleForApi(rtModel_t handle, Model *&outRealObj, const char_t *callerFuncName)
{
    const rtError_t ret = GetValidatedObject<Model>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateLabelHandleForApi(rtLabel_t handle, Label *&outRealObj, const char_t *callerFuncName)
{
    const rtError_t ret = GetValidatedObject<Label>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateLabelHandleArrayForApi(rtLabel_t *handles, size_t count, std::vector<Label *> &outRealObjs,
    const char_t *callerFuncName)
{
    const rtError_t ret = GetValidatedObjectArray<Label>(handles, count, outRealObjs);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateStreamHandleForApi(rtStream_t handle, Stream *&outRealObj, const char_t *callerFuncName)
{
    const rtError_t ret = GetValidatedObject<Stream>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateEventHandleForApi(rtEvent_t handle, Event *&outRealObj, const char_t *callerFuncName)
{
    const rtError_t ret = GetValidatedObject<Event>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateNotifyHandleForApi(rtNotify_t handle, Notify *&outRealObj, const char_t *callerFuncName)
{
    const rtError_t ret = GetValidatedObject<Notify>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateCountNotifyHandleForApi(rtCntNotify_t handle, CountNotify *&outRealObj, const char_t *callerFuncName)
{
    const rtError_t ret = GetValidatedObject<CountNotify>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateCondHandleHandleForApi(rtCondHandle_t handle, CondHandle *&outRealObj, const char_t *callerFuncName)
{
    const rtError_t ret = GetValidatedObject<CondHandle>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateProgramHandleForApi(rtBinHandle handle, Program *&outRealObj, const char_t *callerFuncName)
{
    const rtError_t ret = GetValidatedObject<Program>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateKernelHandleForApi(rtFuncHandle handle, Kernel *&outRealObj, const char_t *callerFuncName)
{
    const rtError_t ret = GetValidatedObject<Kernel>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateArgsHandleForApi(rtArgsHandle handle, RtArgsHandle *&outRealObj, const char_t *callerFuncName)
{
    const rtError_t ret = GetValidatedObject<RtArgsHandle>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    }

    RtArgsHandle * const legacyArgsHandle = reinterpret_cast<RtArgsHandle *>(handle);
    if (legacyArgsHandle != nullptr) {
        RtArgsHandle *realArgsHandle = nullptr;
        const rtError_t legacyRet = GetValidatedObject<RtArgsHandle>(
            reinterpret_cast<rtArgsHandle>(RtInnerHandleAccessor<RtArgsHandle>::Get(legacyArgsHandle)), realArgsHandle);
        if ((legacyRet == RT_ERROR_NONE) && (realArgsHandle == legacyArgsHandle)) {
            outRealObj = legacyArgsHandle;
            return RT_ERROR_NONE;
        }
    }

    return ReportApiHandleValidationError(ret, callerFuncName);
}

rtError_t ValidateParamHandleForApi(rtParaHandle handle, ParaDetail *&outRealObj, const char_t *callerFuncName)
{
    const rtError_t ret = GetValidatedObject<ParaDetail>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    } else {
        return ReportApiHandleValidationError(ret, callerFuncName);
    }
}

rtError_t ValidateLaunchArgsHandleForApi(rtLaunchArgsHandle handle, rtLaunchArgs_t *&outRealObj,
    const char_t *callerFuncName)
{
    const rtError_t ret = GetValidatedObject<rtLaunchArgs_t>(handle, outRealObj);
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    }

    rtLaunchArgs_t * const legacyLaunchArgs = reinterpret_cast<rtLaunchArgs_t *>(handle);
    if (legacyLaunchArgs != nullptr) {
        rtLaunchArgs_t *realLaunchArgs = nullptr;
        const rtError_t legacyRet = GetValidatedObject<rtLaunchArgs_t>(
            reinterpret_cast<rtLaunchArgsHandle>(RtInnerHandleAccessor<rtLaunchArgs_t>::Get(legacyLaunchArgs)),
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
