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
#include "errcode_manage.hpp"
#include "error_message_manage.hpp"
#include "label.hpp"
#include "model.hpp"
#include "count_notify.hpp"
#include "event.hpp"
#include "notify.hpp"
#include "stream.hpp"

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

} // namespace runtime
} // namespace cce
