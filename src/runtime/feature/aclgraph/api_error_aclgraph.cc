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
#include "capture_adapt.hpp"

namespace cce {
namespace runtime {

static rtError_t StreamBeginCaptureMdlCheck(Model * const mdl)
{
    COND_RETURN_WITH_NOLOG((mdl == nullptr), RT_ERROR_NONE);

    COND_RETURN_ERROR_MSG_INNER(mdl->GetModelType() != RT_MODEL_CAPTURE_MODEL, RT_ERROR_INVALID_VALUE,
        "model does not a ACL Graph, modelType=%d .", mdl->GetModelType());

    CaptureModel* captureModel = dynamic_cast<CaptureModel*>(mdl);
    COND_RETURN_ERROR(captureModel == nullptr, RT_ERROR_MODEL_NULL, "the ACL Graph is null.");
    if (!captureModel->IsSubCaptureModel()) {
        RT_LOG(RT_LOG_ERROR, "StreamBeginCapture does not support the ACL Graph");
        return RT_ERROR_INVALID_VALUE;
    }

    return RT_ERROR_NONE;
}

rtError_t ApiErrorDecorator::StreamBeginCapture(Stream * const stm, const rtStreamCaptureMode mode, Model * const mdl)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(((mode >= RT_STREAM_CAPTURE_MODE_MAX) || (mode < RT_STREAM_CAPTURE_MODE_GLOBAL)), 
        RT_ERROR_INVALID_VALUE, mode, "[" + std::to_string(RT_STREAM_CAPTURE_MODE_GLOBAL) + ", " 
        + std::to_string(RT_STREAM_CAPTURE_MODE_MAX) +")");
    COND_RETURN_AND_MSG_OUTER(!StreamFlagIsSupportCapture(stm->Flags()), RT_ERROR_STREAM_INVALID, ErrorCode::EE1011, __func__,
        StreamFlagsToString(stm->Flags()), "stream flag",
        "Stream " + std::to_string(stm->Id_()) + " does not support the ACL Graph"); 
    COND_RETURN_AND_MSG_OUTER(StreamBeginCaptureMdlCheck(mdl) != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE, ErrorCode::EE1017,
        __func__, "modelRI", "The modelRI is not a sub ACL Graph.");

    return impl_->StreamBeginCapture(stm, mode, mdl);
}

rtError_t ApiErrorDecorator::StreamEndCapture(Stream * const stm, Model ** const captureMdl)
{  
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER(!StreamFlagIsSupportCapture(stm->Flags()), RT_ERROR_STREAM_INVALID, ErrorCode::EE1011, __func__,
        StreamFlagsToString(stm->Flags()), "stream flag",
        "Stream " + std::to_string(stm->Id_()) + " does not support the ACL Graph");
    return impl_->StreamEndCapture(stm, captureMdl);
}

rtError_t ApiErrorDecorator::StreamGetCaptureInfo(const Stream * const stm, rtStreamCaptureStatus * const status,
                                                  Model ** const captureMdl)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER((status == nullptr) && (captureMdl == nullptr), RT_ERROR_INVALID_VALUE,
        ErrorCode::EE1022, __func__, "nullptr and nullptr", "status and captureMdl",
        "Parameters status and captureMdl cannot both be nullptr");

    return impl_->StreamGetCaptureInfo(stm, status, captureMdl);
}

rtError_t ApiErrorDecorator::StreamBeginTaskUpdate(Stream * const stm, TaskGroup * handle)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(handle, RT_ERROR_INVALID_VALUE);

    COND_RETURN_AND_MSG_OUTER((stm->IsCapturing()), RT_ERROR_STREAM_CAPTURED, ErrorCode::EE1016,
        __func__, RtFmtMsg("Stream %d during the capture stage is not supported", stm->Id_()));
    
    COND_RETURN_AND_MSG_OUTER(stm->GetModelNum() != 0, RT_ERROR_STREAM_MODEL,
        ErrorCode::EE1016, __func__, "Only single operator stream is supported");

    return impl_->StreamBeginTaskUpdate(stm, handle);
}

rtError_t ApiErrorDecorator::StreamEndTaskUpdate(Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);

    COND_RETURN_AND_MSG_OUTER((stm->IsCapturing()), RT_ERROR_STREAM_CAPTURED, ErrorCode::EE1016,
        __func__, RtFmtMsg("Stream %d during the capture stage is not supported", stm->Id_()));
    
    COND_RETURN_AND_MSG_OUTER(stm->GetModelNum() != 0, RT_ERROR_STREAM_MODEL,
        ErrorCode::EE1016, __func__, "Only single operator stream is supported");

    return impl_->StreamEndTaskUpdate(stm);
}

rtError_t ApiErrorDecorator::ModelGetNodes(const Model * const mdl, uint32_t * const num)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(num, RT_ERROR_INVALID_VALUE);

    return impl_->ModelGetNodes(mdl, num);
}

rtError_t ApiErrorDecorator::ModelDebugDotPrint(const Model * const mdl)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);

    return impl_->ModelDebugDotPrint(mdl);
}

rtError_t ApiErrorDecorator::ModelDebugJsonPrint(const Model * const mdl, const char* path, const uint32_t flags)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(path, RT_ERROR_INVALID_VALUE);
    return impl_->ModelDebugJsonPrint(mdl, path, flags);
}

rtError_t ApiErrorDecorator::StreamAddToModel(Stream * const stm, Model * const captureMdl)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(captureMdl, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER(captureMdl->GetModelType() != RT_MODEL_CAPTURE_MODEL, RT_ERROR_INVALID_VALUE, 
        ErrorCode::EE1016, __func__, "Non ACL Graph mode is not supported");
    
    COND_RETURN_AND_MSG_OUTER(!StreamFlagIsSupportCapture(stm->Flags()), RT_ERROR_STREAM_INVALID, ErrorCode::EE1011, __func__,
        StreamFlagsToString(stm->Flags()), "stream flag",
        "Stream " + std::to_string(stm->Id_()) + " does not support the ACL Graph");

    COND_RETURN_WARN((dynamic_cast<CaptureModel*>(captureMdl))->IsSubCaptureModel(), RT_ERROR_FEATURE_NOT_SUPPORT, "sub ACL Graph does not support adding streams");

    return impl_->StreamAddToModel(stm, captureMdl);
}

rtError_t ApiErrorDecorator::ThreadExchangeCaptureMode(rtStreamCaptureMode * const mode)
{
    NULL_PTR_RETURN_MSG_OUTER(mode, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((static_cast<uint32_t>(*mode) >= RT_STREAM_CAPTURE_MODE_MAX), 
        RT_ERROR_INVALID_VALUE, *mode, "less than " + std::to_string(RT_STREAM_CAPTURE_MODE_MAX));

    return impl_->ThreadExchangeCaptureMode(mode);
}

rtError_t ApiErrorDecorator::StreamBeginTaskGrp(Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER((!stm->IsCapturing()), RT_ERROR_STREAM_NOT_CAPTURED, ErrorCode::EE1016,
        __func__, RtFmtMsg("Stream %d is not in the capture stage", stm->Id_()));
    return impl_->StreamBeginTaskGrp(stm);
}

rtError_t ApiErrorDecorator::StreamEndTaskGrp(Stream * const stm, TaskGroup ** const handle)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(handle, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER((!stm->IsCapturing()), RT_ERROR_STREAM_NOT_CAPTURED, ErrorCode::EE1016,
        __func__, RtFmtMsg("Stream %d is not in the capture stage", stm->Id_()));
    return impl_->StreamEndTaskGrp(stm, handle);
}

rtError_t ApiErrorDecorator::ModelCondHandleCreate(Model * const mdl, uint32_t defaultValue,
    rtCondHandleFlag_t flag, CondHandle ** const handle)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(handle, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(static_cast<uint32_t>(flag) > RT_COND_HANDLE_ASSIGN_DEFAULT, 
        RT_ERROR_INVALID_VALUE, flag, "[0, " + std::to_string(RT_COND_HANDLE_ASSIGN_DEFAULT) + "]");
    COND_RETURN_AND_MSG_OUTER(mdl->GetModelType() != RT_MODEL_CAPTURE_MODEL, RT_ERROR_FEATURE_NOT_SUPPORT,
        ErrorCode::EE1006, __func__, "non ACL Graph mode");
    return impl_->ModelCondHandleCreate(mdl, defaultValue, flag, handle);
}

rtError_t ApiErrorDecorator::ModelCondHandleGetCondPtr(CondHandle * const handle, uint64_t ** const devPtr)
{
    NULL_PTR_RETURN_MSG_OUTER(handle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(devPtr, RT_ERROR_INVALID_VALUE);
    return impl_->ModelCondHandleGetCondPtr(handle, devPtr);
}

rtError_t ApiErrorDecorator::StreamAddCondTask(rtCondTaskParams params, Stream * const stm, uint32_t flags)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((static_cast<uint32_t>(params.type) > RT_COND_TASK_TYPE_SWITCH), RT_ERROR_INVALID_VALUE,
        static_cast<int32_t>(params.type), "[0, " + std::to_string(RT_COND_TASK_TYPE_SWITCH) + "]");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((params.size == 0), RT_ERROR_INVALID_VALUE, params.size, "(0, UINT32_MAX]");
    COND_RETURN_AND_MSG_RESERVED_PARAM((flags != 0), RT_ERROR_INVALID_VALUE, "flags",
        "flags is reserved parameter and must be 0");

    NULL_PTR_RETURN_MSG_OUTER(params.modelRIArray, RT_ERROR_INVALID_VALUE);

    return impl_->StreamAddCondTask(params, stm, flags);
}

} // namespace runtime
} // namespace cce
