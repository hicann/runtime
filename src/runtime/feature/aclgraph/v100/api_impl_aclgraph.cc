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
#include "device.hpp"
#include "stream.hpp"
#include "cond_handle/cond_handle.hpp"
#include "api_handle_guard.h"
#include "capture_model_utils.hpp"
#include "aclgraph_cond_task.h"

#define RT_DRV_FAULT_CNT 25U
#define NULL_STREAM_PTR_RETURN_MSG(STREAM)     NULL_PTR_RETURN_MSG((STREAM), RT_ERROR_STREAM_NULL)

namespace cce {
namespace runtime {

rtError_t ApiImpl::StreamBeginCapture(Stream * const stm, const rtStreamCaptureMode mode, Model * const mdl)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM(stm, curCtx, RT_ERROR_STREAM_CONTEXT);
    COND_RETURN_AND_MSG_OUTER(stm->Model_() != nullptr, RT_ERROR_STREAM_MODEL, ErrorCode::EE1017, "Stream begin capture",
        "stream", "Stream " + std::to_string(stm->Id_()) + " is already bound to model " + std::to_string(stm->Model_()->Id_()));
    COND_RETURN_AND_MSG_OUTER((stm == curCtx->DefaultStream_()), RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1017, "Stream begin capture",
        "stream", RtFmtMsg("The default stream (stream_id=%d) cannot be used in the ACL Graph", stm->Id_()));
    return curCtx->StreamBeginCapture(stm, mode, mdl);
}

rtError_t ApiImpl::StreamEndCapture(Stream * const stm, Model ** const captureMdl)
{
    Stream *captureStream = stm->GetCaptureStream();
    bool isSubCaptureModel = true; // 默认是子model，对入参captureMdl 不修改。
    if ((captureStream != nullptr) && (captureStream->Model_() != nullptr)) {
        CaptureModel *captureModel = RtPtrToPtr<CaptureModel *, Model *>(captureStream->Model_());
        if ((captureModel != nullptr) && (!captureModel->IsSubCaptureModel())) {
            isSubCaptureModel = false;
            NULL_PTR_RETURN_MSG_OUTER(captureMdl, RT_ERROR_INVALID_VALUE);
        }
    }
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM(stm, curCtx, RT_ERROR_STREAM_CONTEXT);
    COND_RETURN_AND_MSG_OUTER(stm->Model_() != nullptr, RT_ERROR_STREAM_MODEL, ErrorCode::EE1017, "Stream end capture",
        "stream", "Stream " + std::to_string(stm->Id_()) + " is already bound to model " + std::to_string(stm->Model_()->Id_()));
    COND_RETURN_AND_MSG_OUTER((stm == curCtx->DefaultStream_()), RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1017, "stream end capture",
        "stream", RtFmtMsg("The default stream (stream_id=%d) cannot be used in the ACL Graph", stm->Id_()));

    Model *mdl = nullptr;    
    rtError_t ret = curCtx->StreamEndCapture(stm, &mdl);
    if (ret != RT_ERROR_NONE) {
        if (!isSubCaptureModel) {
            *captureMdl = nullptr;
        }
    } else {
        if (captureMdl != nullptr) {
            *captureMdl = mdl;
        }
    }
    return ret;
}

rtError_t ApiImpl::StreamBeginTaskUpdate(Stream * const stm, TaskGroup * handle)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM(stm, curCtx, RT_ERROR_STREAM_CONTEXT);
    return curCtx->StreamBeginTaskUpdate(stm, handle);
}

rtError_t ApiImpl::StreamEndTaskUpdate(Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM(stm, curCtx, RT_ERROR_STREAM_CONTEXT);
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
    COND_RETURN_AND_MSG_INVALID_CONTEXT_MODEL(mdl, curCtx, RT_ERROR_MODEL_CONTEXT);

    return curCtx->ModelGetNodes(mdl, num);
}

rtError_t ApiImpl::ModelDebugDotPrint(const Model * const mdl)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_MODEL(mdl, curCtx, RT_ERROR_MODEL_CONTEXT);

    return curCtx->ModelDebugDotPrint(mdl);
}

rtError_t ApiImpl::ModelDebugJsonPrint(const Model * const mdl, const char* path, const uint32_t flags)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_MODEL(mdl, curCtx, RT_ERROR_MODEL_CONTEXT);

    return curCtx->ModelDebugJsonPrint(mdl, path, flags);
}

rtError_t ApiImpl::StreamAddToModel(Stream * const stm, Model * const captureMdl)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM(stm, curCtx, RT_ERROR_STREAM_CONTEXT);
    COND_RETURN_AND_MSG_OUTER(stm->Model_() != nullptr, RT_ERROR_STREAM_MODEL, ErrorCode::EE1017, "rtStreamAddToModel",
        "stream", "Stream " + std::to_string(stm->Id_()) + " is already bound to model " + std::to_string(stm->Model_()->Id_()));
    COND_RETURN_AND_MSG_INVALID_CONTEXT_MODEL(captureMdl, curCtx, RT_ERROR_MODEL_CONTEXT);
    COND_RETURN_AND_MSG_OUTER((stm == curCtx->DefaultStream_()), RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1017, "rtStreamAddToModel",
        "stream", RtFmtMsg("The default stream (stream_id=%d) cannot be used in the ACL Graph", stm->Id_()));

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

    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM(stm, curCtx, RT_ERROR_STREAM_CONTEXT);
    return curCtx->StreamBeginTaskGrp(stm);
}

rtError_t ApiImpl::StreamEndTaskGrp(Stream * const stm, TaskGroup ** const handle)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM(stm, curCtx, RT_ERROR_STREAM_CONTEXT);
    return curCtx->StreamEndTaskGrp(stm, handle);
}

rtError_t ApiImpl::ModelCondHandleCreate(Model * const mdl, uint32_t defaultValue,
    rtCondHandleFlag_t flag, CondHandle ** const handle)
{
    CaptureModel *captureModel = dynamic_cast<CaptureModel *>(mdl);
    NULL_PTR_RETURN_MSG_OUTER(captureModel, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER(!(captureModel->IsCaptureActive()),
        RT_ERROR_INVALID_VALUE, ErrorCode::EE1017, "rtModelCondHandleCreate", "modelRI",
        RtFmtMsg("ModelRI (model_id=%d) is not in the capture stage", mdl->Id_()));
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_MODEL(mdl, curCtx, RT_ERROR_MODEL_CONTEXT);
    rtError_t error = CheckCaptureModelSupportCondOp(curCtx->Device_());
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    CondHandle *condHandle = new (std::nothrow) CondHandle(mdl, defaultValue, flag);
    COND_RETURN_AND_MSG_OUTER((condHandle == nullptr), RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, sizeof(CondHandle), "new");

    error = condHandle->Setup(curCtx);
    if (error != RT_ERROR_NONE) {
        DELETE_O(condHandle);
        return error;
    }

    *handle = condHandle;
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ModelCondHandleGetCondPtr(CondHandle * const handle, uint64_t ** const devPtr)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const rtError_t error = CheckCaptureModelSupportCondOp(curCtx->Device_());
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    *devPtr = handle->GetDevAddr();
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::StreamAddCondTaskParasCheck(rtCondTaskParams params, Stream * const stm, CondHandle **handle)
{
    const auto *inner = static_cast<const rtInnerObject *>(params.handle);
    CondHandle *realHandle = static_cast<CondHandle *>(inner->object);
    COND_RETURN_AND_MSG_OUTER((realHandle->GetSubCaptureModels().size() != 0), RT_ERROR_INVALID_VALUE,
        ErrorCode::EE1017, "rtStreamAddCondTask", "params.handle", "The handle has been launched with condition task.");

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM(stm, curCtx, RT_ERROR_STREAM_CONTEXT);
    COND_RETURN_AND_MSG_OUTER(!stm->IsCapturing(), RT_ERROR_STREAM_NOT_CAPTURED,
        ErrorCode::EE1016, "rtStreamAddCondTask", RtFmtMsg("Stream (stream_id=%d) is not in the capture stage", stm->Id_()));
    NULL_PTR_RETURN(stm->GetCaptureStream(), RT_ERROR_STREAM_NOT_CAPTURED);
    rtError_t error = CheckCaptureModelSupportCondOp(curCtx->Device_());
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    COND_RETURN_ERROR_MSG_INNER((stm->GetCaptureStream()->Model_() != realHandle->GetParentModel()), RT_ERROR_INVALID_VALUE,
        "model associated with the condition handle is inconsistent with that associated with the stream, "
        "condhandle model=%p, capture stream model=%p.", realHandle->GetParentModel(), stm->GetCaptureStream()->Model_());

    auto &addStreamMap = (dynamic_cast<CaptureModel *>(stm->GetCaptureStream()->Model_()))->GetAddStreamMap();
    auto it = addStreamMap.find(stm);
    COND_RETURN_AND_MSG_OUTER((it != addStreamMap.end()), RT_ERROR_FEATURE_NOT_SUPPORT,
        ErrorCode::EE1016, "rtStreamAddCondTask", "The ACL Graph add stream does not support add condition task");

    error = CheckCondTaskParamsSize(params);
    ERROR_RETURN_MSG_INNER(error, "Failed to check condition task params, condition type=%u, condition size=%u, retCode=%#x.",
        params.type, params.size, static_cast<uint32_t>(error));
    COND_RETURN_AND_MSG_OUTER(!realHandle->GetSubCaptureModels().empty(), RT_ERROR_INVALID_VALUE, ErrorCode::EE1017,
        "rtStreamAddCondTask", "params.handle", "The condHandle has already been used by rtStreamAddCondTask");

    realHandle->SetCondType(params.type);
    realHandle->SetCondSize(params.size);

    *handle = realHandle;
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::StreamAddCondTask(rtCondTaskParams params, Stream * const stm, uint32_t flags)
{
    CondHandle *realHandle = nullptr;
    rtError_t error = StreamAddCondTaskParasCheck(params, stm, &realHandle);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "condition task parameters check failed.");

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    error = curCtx->CreateSubCaptureModels(realHandle, params, stm);
    ERROR_RETURN_MSG_INNER(error, "Create sub capture model failed, condition type=%u, condition size=%u, retCode=%#x.",
        params.type, params.size, static_cast<uint32_t>(error));

    return curCtx->StreamAddCondTask(realHandle, params, stm, flags);
}

} // namespace runtime
} // namespace cce
