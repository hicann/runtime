/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "acl_rt_impl.h"
#include "runtime/rt_model.h"
#include "runtime/stream.h"
#include "runtime/rts/rts_model.h"
#include "runtime/rts/rts_stream.h"
#include "common/log_inner.h"
#include "common/error_codes_inner.h"
#include "common/prof_reporter.h"

aclError aclmdlRIExecuteAsyncImpl(aclmdlRI modelRI, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIExecuteAsync);
    ACL_LOG_INFO("start to execute aclmdlRIExecuteAsync");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);
    const rtError_t rtErr = rtModelExecute(static_cast<rtModel_t>(modelRI), static_cast<rtStream_t>(stream), 0U);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("execute rtModel failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclmdlRIExecuteAsync");
    return ACL_SUCCESS;
}

aclError aclmdlRIDestroyImpl(aclmdlRI modelRI)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIDestroy);
    ACL_LOG_INFO("start to execute aclmdlRIDestroy");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);
    const rtError_t rtErr = rtModelDestroy(static_cast<rtModel_t>(modelRI));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("destroy rtModel failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclmdlRIDestroy");
    return ACL_SUCCESS;
}

aclError aclmdlRICaptureBeginImpl(aclrtStream stream, aclmdlRICaptureMode mode)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRICaptureBegin);
    ACL_LOG_INFO("start to execute aclmdlRICaptureBegin, mode is %d", static_cast<int32_t>(mode));
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);
    const rtError_t rtErr = rtStreamBeginCapture(static_cast<rtStream_t>(stream),
                                                 static_cast<rtStreamCaptureMode>(mode));
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            ACL_LOG_WARN("begin capture stream failed, runtime result = %d", static_cast<int32_t>(rtErr));
        } else {
            ACL_LOG_CALL_ERROR("begin capture stream failed, runtime result = %d", static_cast<int32_t>(rtErr));
        }
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclmdlRICaptureBegin");
    return ACL_SUCCESS;
}

aclError aclmdlRICaptureGetInfoImpl(aclrtStream stream, aclmdlRICaptureStatus *status, aclmdlRI *modelRI)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRICaptureGetInfo);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);
    if (status == nullptr && modelRI == nullptr) {
        ACL_LOG_INNER_ERROR("status and modelRI cannot be nullptr at the same time");
        return ACL_ERROR_INVALID_PARAM;
    }
    rtStreamCaptureStatus rtStatus = RT_STREAM_CAPTURE_STATUS_NONE;
    rtModel_t rtModel = nullptr;
    const rtError_t rtErr = rtStreamGetCaptureInfo(static_cast<rtStream_t>(stream), &rtStatus, &rtModel);
    if (rtErr != RT_ERROR_NONE) {
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    if (status != nullptr) {
        *status = static_cast<aclmdlRICaptureStatus>(static_cast<uint32_t>(rtStatus));
    }

    if (modelRI != nullptr) {
        *modelRI = static_cast<aclmdlRI>(rtModel);
    }

    return ACL_SUCCESS;
}

aclError aclmdlRICaptureEndImpl(aclrtStream stream, aclmdlRI *modelRI)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRICaptureEnd);
    ACL_LOG_INFO("start to execute aclmdlRICaptureEnd");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);

    rtModel_t rtModel = nullptr;
    const rtError_t rtErr = rtStreamEndCapture(static_cast<rtStream_t>(stream), &rtModel);
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            ACL_LOG_WARN("end capture stream failed, runtime result = %d", static_cast<int32_t>(rtErr));
        } else {
            ACL_LOG_CALL_ERROR("end capture stream failed, runtime result = %d", static_cast<int32_t>(rtErr));
        }
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    *modelRI = static_cast<aclmdlRI>(rtModel);

    ACL_LOG_INFO("successfully execute aclmdlRICaptureEnd");
    return ACL_SUCCESS;
}

aclError aclmdlRIDebugPrintImpl(aclmdlRI modelRI)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIDebugPrint);
    ACL_LOG_INFO("start to execute aclmdlRIDebugPrint");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);
    const rtError_t rtErr = rtModelDebugDotPrint(static_cast<rtStream_t>(modelRI));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("print model debug info failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclmdlRIDebugPrint");
    return ACL_SUCCESS;
}

aclError aclmdlRIDebugJsonPrintImpl(aclmdlRI modelRI, const char *path, uint32_t flags)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIDebugJsonPrint);
    ACL_LOG_INFO("start to execute aclmdlRIDebugJsonPrint");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(path);
    const rtError_t rtErr = rtModelDebugJsonPrint(static_cast<rtStream_t>(modelRI), path, flags);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("print model debug info failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclmdlRIDebugJsonPrint");
    return ACL_SUCCESS;
}

aclError aclmdlRICaptureThreadExchangeModeImpl(aclmdlRICaptureMode *mode)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRICaptureThreadExchangeMode);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(mode);
    ACL_LOG_INFO("start to execute aclmdlRICaptureThreadExchangeMode, input mode is %d", static_cast<int32_t>(*mode));
    rtStreamCaptureMode rtMode = static_cast<rtStreamCaptureMode>(*mode);
    const rtError_t rtErr = rtThreadExchangeCaptureMode(&rtMode);
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            ACL_LOG_WARN("exchange capture mode failed, runtime result = %d", static_cast<int32_t>(rtErr));
        } else {
            ACL_LOG_CALL_ERROR("exchange capture mode failed, runtime result = %d", static_cast<int32_t>(rtErr));
        }
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    *mode = static_cast<aclmdlRICaptureMode>(rtMode);

    ACL_LOG_INFO("successfully execute aclmdlRICaptureThreadExchangeMode, output mode is %d",
                 static_cast<int32_t>(*mode));
    return ACL_SUCCESS;
}

aclError aclmdlRICaptureTaskGrpBeginImpl(aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRICaptureTaskGrpBegin);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);
    ACL_LOG_INFO("start to execute aclmdlRICaptureTaskGrpBegin");
    const rtError_t rtErr = rtsStreamBeginTaskGrp(static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            ACL_LOG_WARN("begin capture task group failed, runtime result = %d", static_cast<int32_t>(rtErr));
        } else {
            ACL_LOG_CALL_ERROR("begin capture task group failed, runtime result = %d", static_cast<int32_t>(rtErr));
        }
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclmdlRICaptureTaskGrpBegin");
    return ACL_SUCCESS;
}

aclError aclmdlRICaptureTaskGrpEndImpl(aclrtStream stream, aclrtTaskGrp *handle)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRICaptureTaskGrpEnd);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(handle);
    ACL_LOG_INFO("start to execute aclmdlRICaptureTaskGrpEnd");
    rtTaskGrp_t rtHandle = nullptr;
    const rtError_t rtErr = rtsStreamEndTaskGrp(static_cast<rtStream_t>(stream), &rtHandle);
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            ACL_LOG_WARN("end capture task group failed, runtime result = %d", static_cast<int32_t>(rtErr));
        } else {
            ACL_LOG_CALL_ERROR("end capture task group failed, runtime result = %d", static_cast<int32_t>(rtErr));
        }
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    *handle = static_cast<aclrtTaskGrp>(rtHandle);

    ACL_LOG_INFO("successfully execute aclmdlRICaptureTaskGrpEnd");
    return ACL_SUCCESS;
}

aclError aclmdlRICaptureTaskUpdateBeginImpl(aclrtStream stream, aclrtTaskGrp handle)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRICaptureTaskUpdateBegin);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(handle);
    ACL_LOG_INFO("start to execute aclmdlRICaptureTaskUpdateBegin");
    const rtError_t rtErr = rtsStreamBeginTaskUpdate(static_cast<rtStream_t>(stream), static_cast<rtTaskGrp_t>(handle));
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            ACL_LOG_WARN("begin update capture task group failed, runtime result = %d", static_cast<int32_t>(rtErr));
        } else {
            ACL_LOG_CALL_ERROR("begin update capture task group failed, runtime result = %d",
                               static_cast<int32_t>(rtErr));
        }
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclmdlRICaptureTaskUpdateBegin");
    return ACL_SUCCESS;
}

aclError aclmdlRICaptureTaskUpdateEndImpl(aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRICaptureTaskUpdateEnd);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);
    ACL_LOG_INFO("start to execute aclmdlRICaptureTaskUpdateEnd");
    const rtError_t rtErr = rtsStreamEndTaskUpdate(static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            ACL_LOG_WARN("end update capture task group failed, runtime result = %d", static_cast<int32_t>(rtErr));
        } else {
            ACL_LOG_CALL_ERROR("end update capture task group failed, runtime result = %d",
                               static_cast<int32_t>(rtErr));
        }
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclmdlRICaptureTaskUpdateEnd");
    return ACL_SUCCESS;
}

aclError aclmdlRIBuildBeginImpl(aclmdlRI *modelRI, uint32_t flag)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIBuildBegin);
    ACL_LOG_INFO("start to execute aclmdlRIBuildBegin, flag is [%u]", flag);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);

    const rtError_t rtErr = rtsModelCreate(static_cast<rtModel_t*>(modelRI), flag);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsModelCreate failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclmdlRIBuildBegin");
    return ACL_SUCCESS;
}

aclError aclmdlRIBindStreamImpl(aclmdlRI modelRI, aclrtStream stream, uint32_t flag)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIBindStream);
    ACL_LOG_INFO("start to execute aclmdlRIBindStream, flag is [%u].", flag);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);

    const rtError_t rtErr = rtsModelBindStream(static_cast<rtModel_t>(modelRI), static_cast<rtStream_t>(stream), flag);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsModelBindStream failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclmdlRIBindStream");
    return ACL_SUCCESS;
}

aclError aclmdlRIEndTaskImpl(aclmdlRI modelRI, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIEndTask);
    ACL_LOG_INFO("start to execute aclmdlRIEndTask");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);

    const rtError_t rtErr = rtsEndGraph(static_cast<rtModel_t>(modelRI), static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsEndGraph failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclmdlRIEndTask");
    return ACL_SUCCESS;
}

aclError aclmdlRIBuildEndImpl(aclmdlRI modelRI, void *reserve)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIBuildEnd);
    ACL_LOG_INFO("start to execute aclmdlRIBuildEnd");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);
    if (reserve != nullptr) {
        ACL_LOG_ERROR("[Check][reserve]param must be null.");
        acl::AclErrorLogManager::ReportInputError("EH0002", {"param"}, {"reserve"});
        return ACL_ERROR_INVALID_PARAM;
    }

    const rtError_t rtErr = rtsModelLoadComplete(static_cast<rtModel_t>(modelRI), reserve);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsModelLoadComplete failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclmdlRIBuildEnd");
    return ACL_SUCCESS;
}

aclError aclmdlRIUnbindStreamImpl(aclmdlRI modelRI, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIUnbindStream);
    ACL_LOG_INFO("start to execute aclmdlRIUnbindStream");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);

    const rtError_t rtErr = rtsModelUnbindStream(static_cast<rtModel_t>(modelRI), static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsModelUnbindStream failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclmdlRIUnbindStream");
    return ACL_SUCCESS;
}

aclError aclmdlRIExecuteImpl(aclmdlRI modelRI, int32_t timeout)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIExecute);
    ACL_LOG_INFO("start to execute aclmdlRIExecute, timeout is [%d] ms.", timeout);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);

    const rtError_t rtErr = rtsModelExecute(static_cast<rtModel_t>(modelRI), timeout);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsModelExecute failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclmdlRIExecute");
    return ACL_SUCCESS;
}

aclError aclmdlRISetNameImpl(aclmdlRI modelRI, const char *name)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRISetName);
    ACL_LOG_INFO("start to execute aclmdlRISetName");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(name);

    const rtError_t rtErr = rtsModelSetName(static_cast<rtModel_t>(modelRI), name);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsModelSetName failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclmdlRISetName");
    return ACL_SUCCESS;
}

aclError aclmdlRIGetNameImpl(aclmdlRI modelRI, uint32_t maxLen, char *name)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIGetName);
    ACL_LOG_INFO("start to execute aclmdlRIGetName, maxLen is [%u]", maxLen);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(name);

    const rtError_t rtErr = rtsModelGetName(static_cast<rtModel_t>(modelRI), maxLen, name);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsModelGetName failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclmdlRIGetName");
    return ACL_SUCCESS;
}

aclError aclmdlRIAbortImpl(aclmdlRI modelRI)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIAbort);
    ACL_LOG_INFO("start to execute aclmdlRIAbort");

    const rtError_t rtErr = rtsModelAbort(static_cast<rtModel_t>(modelRI));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call aclmdlRIAbort failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclmdlRIAbort");
    return ACL_SUCCESS;
}