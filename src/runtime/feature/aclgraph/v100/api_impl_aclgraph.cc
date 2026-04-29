/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "internal_error_define.hpp"
#include "api_impl.hpp"
#include "context.hpp"
#include "stream.hpp"

#define RT_DRV_FAULT_CNT 25U
#define NULL_STREAM_PTR_RETURN_MSG(STREAM)     NULL_PTR_RETURN_MSG((STREAM), RT_ERROR_STREAM_NULL)


namespace {
constexpr uint32_t MEM_POLICY_MASK = 0xFFU;
constexpr uint32_t MEM_TYPE_MASK = 0xFF00U;

}

namespace cce {
namespace runtime {

rtError_t ApiImpl::StreamBeginCapture(Stream * const stm, const rtStreamCaptureMode mode)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT, 
        "stream " + std::to_string(stm->Id_()));
    COND_RETURN_AND_MSG_OUTER(stm->Model_() != nullptr, RT_ERROR_STREAM_MODEL, ErrorCode::EE1017, __func__,
        "stream", "Stream " + std::to_string(stm->Id_()) + " is already bound to model " + std::to_string(stm->Model_()->Id_()));
    COND_RETURN_AND_MSG_OUTER((stm == curCtx->DefaultStream_()), RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1017, __func__,
        "stream", "The default stream cannot be used in the ACL Graph");
    return curCtx->StreamBeginCapture(stm, mode);
}

rtError_t ApiImpl::StreamEndCapture(Stream * const stm, Model ** const captureMdl)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT, 
        "stream " + std::to_string(stm->Id_()));
    COND_RETURN_AND_MSG_OUTER(stm->Model_() != nullptr, RT_ERROR_STREAM_MODEL, ErrorCode::EE1017, __func__,
        "stream", "Stream " + std::to_string(stm->Id_()) + " is already bound to model " + std::to_string(stm->Model_()->Id_()));
    COND_RETURN_AND_MSG_OUTER((stm == curCtx->DefaultStream_()), RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1017, __func__,
        "stream", "The default stream cannot be used in the ACL Graph");

    return curCtx->StreamEndCapture(stm, captureMdl);
}

rtError_t ApiImpl::StreamBeginTaskUpdate(Stream * const stm, TaskGroup * handle)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT, 
        "stream " + std::to_string(stm->Id_()));
    return curCtx->StreamBeginTaskUpdate(stm, handle);
}

rtError_t ApiImpl::StreamEndTaskUpdate(Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT, 
        "stream " + std::to_string(stm->Id_()));
    return curCtx->StreamEndTaskUpdate(stm);
}

rtError_t ApiImpl::StreamGetCaptureInfo(const Stream * const stm, rtStreamCaptureStatus * const status,
                                        Model ** const captureMdl)
{
    Stream *captureStream = stm->GetCaptureStream();
    const rtStreamCaptureStatus statusTmp = stm->GetCaptureStatus();
    Model *mdlTmp = nullptr;

    if ((statusTmp != RT_STREAM_CAPTURE_STATUS_NONE) && (captureStream != nullptr)) {
        mdlTmp = captureStream->Model_();
        if (mdlTmp == nullptr) {
            RT_LOG(RT_LOG_WARNING, "stream is not in capture status, stream_id=%d.", stm->Id_());
        }
    }

    if (status != nullptr) {
        *status = statusTmp;
    }

    if (captureMdl != nullptr) {
        *captureMdl = mdlTmp;
    }

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ModelGetNodes(const Model * const mdl, uint32_t * const num)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT, 
        "model " + std::to_string(mdl->Id_()));

    return curCtx->ModelGetNodes(mdl, num);
}

rtError_t ApiImpl::ModelDebugDotPrint(const Model * const mdl)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT, 
        "model " + std::to_string(mdl->Id_()));

    return curCtx->ModelDebugDotPrint(mdl);
}

rtError_t ApiImpl::ModelDebugJsonPrint(const Model * const mdl, const char* path, const uint32_t flags)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT, 
        "model " + std::to_string(mdl->Id_()));

    return curCtx->ModelDebugJsonPrint(mdl, path, flags);
}

rtError_t ApiImpl::StreamAddToModel(Stream * const stm, Model * const captureMdl)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT, 
        "stream " + std::to_string(stm->Id_()));
    COND_RETURN_AND_MSG_OUTER(stm->Model_() != nullptr, RT_ERROR_STREAM_MODEL, ErrorCode::EE1017, __func__,
        "stream", "Stream " + std::to_string(stm->Id_()) + " is already bound to model " + std::to_string(stm->Model_()->Id_()));
    COND_RETURN_AND_MSG_INVALID_CONTEXT(captureMdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT, 
        "model " + std::to_string(captureMdl->Id_()));
    COND_RETURN_AND_MSG_OUTER((stm == curCtx->DefaultStream_()), RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1017, __func__,
        "stream", "The default stream cannot be used in the ACL Graph");

    return curCtx->StreamAddToModel(stm, captureMdl);
}

rtError_t ApiImpl::ThreadExchangeCaptureMode(rtStreamCaptureMode * const mode)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    return curCtx->ThreadExchangeCaptureMode(mode);
}

rtError_t ApiImpl::StreamBeginTaskGrp(Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_AND_MSG_INVALID_CONTEXT(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT, 
        "stream " + std::to_string(stm->Id_()));
    return curCtx->StreamBeginTaskGrp(stm);
}

rtError_t ApiImpl::StreamEndTaskGrp(Stream * const stm, TaskGroup ** const handle)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_AND_MSG_INVALID_CONTEXT(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT, 
        "stream " + std::to_string(stm->Id_()));
    return curCtx->StreamEndTaskGrp(stm, handle);
}

} // namespace runtime
} // namespace cce
