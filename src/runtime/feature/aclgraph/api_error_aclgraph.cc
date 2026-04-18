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

rtError_t ApiErrorDecorator::StreamBeginCapture(Stream * const stm, const rtStreamCaptureMode mode)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(((mode >= RT_STREAM_CAPTURE_MODE_MAX) || (mode < RT_STREAM_CAPTURE_MODE_GLOBAL)), 
        RT_ERROR_INVALID_VALUE, mode, "[" + std::to_string(RT_STREAM_CAPTURE_MODE_GLOBAL) + ", " 
        + std::to_string(RT_STREAM_CAPTURE_MODE_MAX) +")");  
    COND_RETURN_ERROR_MSG_INNER(!StreamFlagIsSupportCapture(stm->Flags()), RT_ERROR_STREAM_INVALID,
        "stream flag does not support capture to model, flag=%u.", stm->Flags());
    return impl_->StreamBeginCapture(stm, mode);
}

rtError_t ApiErrorDecorator::StreamEndCapture(Stream * const stm, Model ** const captureMdl)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(captureMdl, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER(!StreamFlagIsSupportCapture(stm->Flags()), RT_ERROR_STREAM_INVALID,
        "stream flag does not support capture to model, flag=%u.", stm->Flags());

    return impl_->StreamEndCapture(stm, captureMdl);
}

rtError_t ApiErrorDecorator::StreamGetCaptureInfo(const Stream * const stm, rtStreamCaptureStatus * const status,
                                                  Model ** const captureMdl)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    COND_RETURN_OUT_ERROR_MSG_CALL(((status == nullptr) && (captureMdl == nullptr)),
                                   RT_ERROR_INVALID_VALUE, "status and captureMdl cannot both be nullptr.");

    return impl_->StreamGetCaptureInfo(stm, status, captureMdl);
}

rtError_t ApiErrorDecorator::StreamBeginTaskUpdate(Stream * const stm, TaskGroup * handle)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(handle, RT_ERROR_INVALID_VALUE);

    COND_RETURN_ERROR_MSG_INNER((stm->IsCapturing()),
        RT_ERROR_STREAM_CAPTURED, "the stream is capturing.");
    
    COND_RETURN_OUT_ERROR_MSG_CALL(stm->GetModelNum() != 0, RT_ERROR_STREAM_MODEL ,
        "only support single operator stream.");

    return impl_->StreamBeginTaskUpdate(stm, handle);
}

rtError_t ApiErrorDecorator::StreamEndTaskUpdate(Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);

    COND_RETURN_ERROR_MSG_INNER((stm->IsCapturing()),
        RT_ERROR_STREAM_CAPTURED, "the stream is capturing.");
    
    COND_RETURN_OUT_ERROR_MSG_CALL(stm->GetModelNum() != 0, RT_ERROR_STREAM_MODEL ,
        "only support single operator stream.");

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
    COND_RETURN_ERROR_MSG_INNER(captureMdl->GetModelType() != RT_MODEL_CAPTURE_MODEL, RT_ERROR_INVALID_VALUE,
        "model does not support stream to model, modelType=%d .", captureMdl->GetModelType());
    
    COND_RETURN_ERROR_MSG_INNER(!StreamFlagIsSupportCapture(stm->Flags()), RT_ERROR_STREAM_INVALID,
        "stream flag does not support capture to model, flag=%u.", stm->Flags());

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
    COND_RETURN_ERROR_MSG_INNER((!stm->IsCapturing()),
        RT_ERROR_STREAM_NOT_CAPTURED, "the stream is not captured.");
    return impl_->StreamBeginTaskGrp(stm);
}

rtError_t ApiErrorDecorator::StreamEndTaskGrp(Stream * const stm, TaskGroup ** const handle)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(handle, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER((!stm->IsCapturing()),
        RT_ERROR_STREAM_NOT_CAPTURED, "the stream is not captured.");
    return impl_->StreamEndTaskGrp(stm, handle);
}

} // namespace runtime
} // namespace cce
