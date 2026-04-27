/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "api_c.h"
#include "api.hpp"
#include "api_handle_guard.h"
#include "osal.hpp"
#include "thread_local_container.hpp"
#include "rts/rts.h"
#include "global_state_manager.hpp"
#include "api_handle_guard.h"

using namespace cce::runtime;

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

VISIBILITY_DEFAULT
rtError_t rtModelCreate(rtModel_t *mdl, uint32_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ModelCreate(RtPtrToPtr<Model **>(mdl), flag);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    Model *realModel = RtPtrToPtr<Model *>(*mdl);
    *mdl = ExportEmbeddedHandle<rtModel_t>(realModel);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetModelName(rtModel_t mdl, const char_t *mdlName)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(mdl, Model, realModel);
    const rtError_t error = apiInstance->ModelNameSet(realModel, mdlName);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtModelExecuteSync(rtModel_t mdl, rtStream_t stm, uint32_t flag, int32_t timeout)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(mdl, Model, realModel);
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, exeStream);
    const rtError_t error = apiInstance->ModelExecute(realModel,
        exeStream, flag, timeout);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsModelCreate(rtModel_t *mdl, uint32_t flag)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((flag != 0), ACL_ERROR_RT_PARAM_INVALID, flag, "0");
    return rtModelCreate(mdl, flag);
}

VISIBILITY_DEFAULT
rtError_t rtsModelBindStream(rtModel_t mdl, rtStream_t stm, uint32_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(((flag != RT_MODEL_STREAM_FLAG_HEAD) && (flag != RT_MODEL_STREAM_FLAG_DEFAULT)),
        ACL_ERROR_RT_PARAM_INVALID, flag, std::to_string(RT_MODEL_STREAM_FLAG_HEAD) + " or " + std::to_string(RT_MODEL_STREAM_FLAG_DEFAULT));
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(mdl, Model, realModel);
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, bindStream);
    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER((bindStream != nullptr) &&
        ((bindStream->Flags() & RT_STREAM_PERSISTENT) == 0), RT_ERROR_INVALID_VALUE,
        ErrorCode::EE1001, "Non-persistent stream cannot be bound to a model.");
    if ((bindStream != nullptr) && (bindStream->GetModelNum() != 0)) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1007, bindStream->Id_(),
            "The stream is bound to more than one mdlRI. Size: " + std::to_string(bindStream->GetModelNum()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_STREAM_MODEL);
    }

    rtError_t error = apiInstance->ModelBindStream(realModel, bindStream, flag);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    error = apiInstance->SetStreamSqLockUnlock(bindStream, true);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsEndGraph(rtModel_t mdl, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(mdl, Model, realModel);
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, exeStream);
    rtError_t error = apiInstance->SetStreamSqLockUnlock(exeStream, false);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    error = apiInstance->ModelEndGraph(realModel, exeStream, 0U);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsModelLoadComplete(rtModel_t mdl, void* reserve)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((reserve != nullptr), ACL_ERROR_RT_PARAM_INVALID, reserve, "nullptr");
    return rtModelLoadComplete(mdl);
}

VISIBILITY_DEFAULT
rtError_t rtsModelUnbindStream(rtModel_t mdl, rtStream_t stm)
{
    return rtModelUnbindStream(mdl, stm);
}

VISIBILITY_DEFAULT
rtError_t rtsModelDestroy(rtModel_t mdl)
{
    return rtModelDestroy(mdl);
}

VISIBILITY_DEFAULT
rtError_t rtsModelExecute(rtModel_t mdl, int32_t timeout)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(mdl, Model, realModel);
    const rtError_t error = apiInstance->ModelExecuteSync(realModel, timeout);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsModelExecuteAsync(rtModel_t mdl, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(mdl, Model, realModel);
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, exeStream);
    const rtError_t error = apiInstance->ModelExecuteAsync(realModel, exeStream);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsLabelCreate(rtLabel_t *lbl)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->LabelCreate(RtPtrToPtr<Label **>(lbl), nullptr);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    Label *realLabel = RtPtrToPtr<Label *>(*lbl);
    *lbl = ExportEmbeddedHandle<rtLabel_t>(realLabel);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsLabelDestroy(rtLabel_t lbl)
{
    return rtLabelDestroy(lbl);
}

VISIBILITY_DEFAULT
rtError_t rtsLabelSwitchListCreate(rtLabel_t *labels, size_t num, void **labelList)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    COND_RETURN_WITH_EXT_ERRCODE(((num == 0U) || (num > static_cast<size_t>(MAX_UINT16_NUM))), RT_ERROR_INVALID_VALUE,
        "Invalid label num, current num=%zu, valid range is (0, %u].",
        num, MAX_UINT16_NUM);
    RT_VALIDATE_AND_UNWRAP_OBJECT_ARRAY(labels, num, Label, realLabels);
    const rtError_t error = apiInstance->LabelSwitchListCreate(realLabels.data(), num, labelList);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsLabelSwitchListDestroy(void *labelList)
{
    return rtsFree(labelList);
}

VISIBILITY_DEFAULT
rtError_t rtsLabelSet(rtLabel_t lbl, rtStream_t stm)
{
    return rtLabelSet(lbl, stm);
}

VISIBILITY_DEFAULT
rtError_t rtsLabelSwitchByIndex(void *ptr, uint32_t maxValue, void *labelInfoPtr, rtStream_t stm)
{
    return rtLabelSwitchByIndex(ptr, maxValue, labelInfoPtr, stm);
}

VISIBILITY_DEFAULT
rtError_t rtsModelSetName(rtModel_t mdl, const char_t *mdlName)
{
    return rtSetModelName(mdl, mdlName);
}

VISIBILITY_DEFAULT
rtError_t rtsModelGetName(rtModel_t mdl, const uint32_t maxLen, char_t * const mdlName)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(mdl, Model, realModel);
    const rtError_t error = apiInstance->ModelGetName(realModel, maxLen, mdlName);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsModelGetId(rtModel_t mdl, uint32_t *modelId)
{
    return rtModelGetId(mdl, modelId);
}

VISIBILITY_DEFAULT
rtError_t rtsModelAbort(rtModel_t mdl)
{
    return rtModelAbort(mdl);
}

#ifdef __cplusplus
}
#endif // __cplusplus
