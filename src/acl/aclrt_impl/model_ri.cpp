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
#include "runtime/rt_inner_model.h"
#include "common/log_inner.h"
#include "common/error_codes_inner.h"
#include "common/prof_reporter.h"

#ifdef __cplusplus
extern "C" {
#endif

aclError aclmdlRIExecuteAsyncImpl(aclmdlRI modelRI, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIExecuteAsync);
    ACL_LOG_INFO("start to execute aclmdlRIExecuteAsync");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);
    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtModelExecute(static_cast<rtModel_t>(modelRI), static_cast<rtStream_t>(stream), 0U), rtModelExecute);

    ACL_LOG_INFO("successfully execute aclmdlRIExecuteAsync");
    return ACL_SUCCESS;
}

aclError aclmdlRIDestroyImpl(aclmdlRI modelRI)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIDestroy);
    ACL_LOG_INFO("start to execute aclmdlRIDestroy");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);
    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtModelDestroy(static_cast<rtModel_t>(modelRI)), rtModelDestroy);

    ACL_LOG_INFO("successfully execute aclmdlRIDestroy");
    return ACL_SUCCESS;
}

aclError aclmdlRICaptureBeginImpl(aclrtStream stream, aclmdlRICaptureMode mode)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRICaptureBegin);
    ACL_LOG_INFO("start to execute aclmdlRICaptureBegin, mode is %d", static_cast<int32_t>(mode));
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);
    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtStreamBeginCapture(static_cast<rtStream_t>(stream),
                                             static_cast<rtStreamCaptureMode>(mode)), rtStreamBeginCapture);

    ACL_LOG_INFO("successfully execute aclmdlRICaptureBegin");
    return ACL_SUCCESS;
}

aclError aclmdlRICaptureGetInfoImpl(aclrtStream stream, aclmdlRICaptureStatus *status, aclmdlRI *modelRI)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRICaptureGetInfo);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);
    if (status == nullptr && modelRI == nullptr) {
        ACL_LOG_ERROR("status and modelRI cannot be nullptr at the same time");
        std::string funcName = acl::AclErrorLogManager::GetFuncNameWithoutImplSuffix(__func__);
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_REASON_MSG,
            std::vector<const char *>({"func", "value", "param", "reason"}),
            std::vector<const char *>({funcName.c_str(), "nullptr/nullptr", "status/modelRI", "both cannot be nullptr at the same time"}));
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
    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtStreamEndCapture(static_cast<rtStream_t>(stream), &rtModel), rtStreamEndCapture);
    *modelRI = static_cast<aclmdlRI>(rtModel);

    ACL_LOG_INFO("successfully execute aclmdlRICaptureEnd");
    return ACL_SUCCESS;
}

aclError aclmdlRIUpdateImpl(aclmdlRI modelRI)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIUpdate);
    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtModelUpdate(static_cast<rtModel_t>(modelRI)), rtModelUpdate);
    ACL_LOG_INFO("successfully execute aclmdlRIUpdate");
    return ACL_SUCCESS;
}

aclError aclmdlRIDebugPrintImpl(aclmdlRI modelRI)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIDebugPrint);
    ACL_LOG_INFO("start to execute aclmdlRIDebugPrint");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);
    ACL_REQUIRES_RTS_OK(rtModelDebugDotPrint(static_cast<rtStream_t>(modelRI)));
    ACL_LOG_INFO("successfully execute aclmdlRIDebugPrint");
    return ACL_SUCCESS;
}

aclError aclmdlRIDebugJsonPrintImpl(aclmdlRI modelRI, const char *path, uint32_t flags)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIDebugJsonPrint);
    ACL_LOG_INFO("start to execute aclmdlRIDebugJsonPrint");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(path);
    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtModelDebugJsonPrint(static_cast<rtStream_t>(modelRI), path, flags), rtModelDebugJsonPrint);

    ACL_LOG_INFO("successfully execute aclmdlRIDebugJsonPrint");
    return ACL_SUCCESS;
}

aclError aclmdlRICaptureThreadExchangeModeImpl(aclmdlRICaptureMode *mode)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRICaptureThreadExchangeMode);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(mode);
    ACL_LOG_INFO("start to execute aclmdlRICaptureThreadExchangeMode, input mode is %d", static_cast<int32_t>(*mode));
    rtStreamCaptureMode rtMode = static_cast<rtStreamCaptureMode>(*mode);
    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtThreadExchangeCaptureMode(&rtMode), rtThreadExchangeCaptureMode);
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
    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtsStreamBeginTaskGrp(static_cast<rtStream_t>(stream)), rtsStreamBeginTaskGrp);
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
    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtsStreamEndTaskGrp(static_cast<rtStream_t>(stream), &rtHandle), rtsStreamEndTaskGrp);
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
    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtsStreamBeginTaskUpdate(static_cast<rtStream_t>(stream), static_cast<rtTaskGrp_t>(handle)), rtsStreamBeginTaskUpdate);
    ACL_LOG_INFO("successfully execute aclmdlRICaptureTaskUpdateBegin");
    return ACL_SUCCESS;
}

aclError aclmdlRICaptureTaskUpdateEndImpl(aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRICaptureTaskUpdateEnd);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);
    ACL_LOG_INFO("start to execute aclmdlRICaptureTaskUpdateEnd");
    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtsStreamEndTaskUpdate(static_cast<rtStream_t>(stream)), rtsStreamEndTaskUpdate);
    ACL_LOG_INFO("successfully execute aclmdlRICaptureTaskUpdateEnd");
    return ACL_SUCCESS;
}

aclError aclmdlRIBuildBeginImpl(aclmdlRI *modelRI, uint32_t flag)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIBuildBegin);
    ACL_LOG_INFO("start to execute aclmdlRIBuildBegin, flag is [%u]", flag);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);

    ACL_REQUIRES_RTS_OK(rtsModelCreate(static_cast<rtModel_t*>(modelRI), flag));

    ACL_LOG_INFO("successfully execute aclmdlRIBuildBegin");
    return ACL_SUCCESS;
}

aclError aclmdlRIBindStreamImpl(aclmdlRI modelRI, aclrtStream stream, uint32_t flag)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIBindStream);
    ACL_LOG_INFO("start to execute aclmdlRIBindStream, flag is [%u].", flag);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);

    ACL_REQUIRES_RTS_OK(rtsModelBindStream(static_cast<rtModel_t>(modelRI), static_cast<rtStream_t>(stream), flag));

    ACL_LOG_INFO("successfully execute aclmdlRIBindStream");
    return ACL_SUCCESS;
}

aclError aclmdlRIEndTaskImpl(aclmdlRI modelRI, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIEndTask);
    ACL_LOG_INFO("start to execute aclmdlRIEndTask");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);

    ACL_REQUIRES_RTS_OK(rtsEndGraph(static_cast<rtModel_t>(modelRI), static_cast<rtStream_t>(stream)));

    ACL_LOG_INFO("successfully execute aclmdlRIEndTask");
    return ACL_SUCCESS;
}

aclError aclmdlRIBuildEndImpl(aclmdlRI modelRI, void *reserve)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIBuildEnd);
    ACL_LOG_INFO("start to execute aclmdlRIBuildEnd");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);
    ACL_CHECK_INVALID_PARAM_NO_VALUE(reserve == nullptr, "reserve",
        "reserve is a reserved parameter and must be nullptr");

    ACL_REQUIRES_RTS_OK(rtsModelLoadComplete(static_cast<rtModel_t>(modelRI), reserve));

    ACL_LOG_INFO("successfully execute aclmdlRIBuildEnd");
    return ACL_SUCCESS;
}

aclError aclmdlRIUnbindStreamImpl(aclmdlRI modelRI, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIUnbindStream);
    ACL_LOG_INFO("start to execute aclmdlRIUnbindStream");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);

    ACL_REQUIRES_RTS_OK(rtsModelUnbindStream(static_cast<rtModel_t>(modelRI), static_cast<rtStream_t>(stream)));

    ACL_LOG_INFO("successfully execute aclmdlRIUnbindStream");
    return ACL_SUCCESS;
}

aclError aclmdlRIExecuteImpl(aclmdlRI modelRI, int32_t timeout)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIExecute);
    ACL_LOG_INFO("start to execute aclmdlRIExecute, timeout is [%d] ms.", timeout);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);

    ACL_REQUIRES_RTS_OK(rtsModelExecute(static_cast<rtModel_t>(modelRI), timeout));

    ACL_LOG_INFO("successfully execute aclmdlRIExecute");
    return ACL_SUCCESS;
}

aclError aclmdlRISetNameImpl(aclmdlRI modelRI, const char *name)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRISetName);
    ACL_LOG_INFO("start to execute aclmdlRISetName");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(name);

    ACL_REQUIRES_RTS_OK(rtsModelSetName(static_cast<rtModel_t>(modelRI), name));

    ACL_LOG_INFO("successfully execute aclmdlRISetName");
    return ACL_SUCCESS;
}

aclError aclmdlRIGetNameImpl(aclmdlRI modelRI, uint32_t maxLen, char *name)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIGetName);
    ACL_LOG_INFO("start to execute aclmdlRIGetName, maxLen is [%u]", maxLen);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(name);

    ACL_REQUIRES_RTS_OK(rtsModelGetName(static_cast<rtModel_t>(modelRI), maxLen, name));

    ACL_LOG_INFO("successfully execute aclmdlRIGetName");
    return ACL_SUCCESS;
}

aclError aclmdlRIGetIdImpl(aclmdlRI modelRI, uint32_t *modelRIId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIGetId);
    ACL_LOG_INFO("start to execute aclmdlRIGetId");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRIId);

    ACL_REQUIRES_RTS_OK(rtModelGetId(static_cast<rtModel_t>(modelRI), modelRIId));

    ACL_LOG_INFO("successfully execute aclmdlRIGetId");
    return ACL_SUCCESS;
}

aclError aclmdlRIAbortImpl(aclmdlRI modelRI)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIAbort);
    ACL_LOG_INFO("start to execute aclmdlRIAbort");
    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtsModelAbort(static_cast<rtModel_t>(modelRI)), rtsModelAbort);
    ACL_LOG_INFO("successfully execute aclmdlRIAbort");
    return ACL_SUCCESS;
}

aclError aclmdlRIGetStreamsImpl(aclmdlRI modelRI, aclrtStream *streams, uint32_t *numStreams)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIGetStreams);
    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtModelGetStreams(static_cast<rtModel_t>(modelRI),  static_cast<rtStream_t *>(streams), numStreams), rtModelGetStreams);

    return ACL_SUCCESS;
}

aclError aclmdlRIDestroyRegisterCallbackImpl(aclmdlRI modelRI, aclrtCallback func, void *userData) {
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIDestroyRegisterCallback);
    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtModelDestroyRegisterCallback(static_cast<rtModel_t>(modelRI),
        reinterpret_cast<rtCallback_t>(func), userData), rtModelDestroyRegisterCallback);

    return ACL_SUCCESS;
}

aclError aclmdlRIDestroyUnregisterCallbackImpl(aclmdlRI modelRI, aclrtCallback func) {
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIDestroyUnregisterCallback);
    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtModelDestroyUnregisterCallback(static_cast<rtModel_t>(modelRI),
        reinterpret_cast<rtCallback_t>(func)), rtModelDestroyUnregisterCallback);

    return ACL_SUCCESS;
}

aclError aclmdlRICondHandleCreateImpl(aclmdlRI modelRI, uint32_t defaultLaunchValue,
    aclmdlRICondHandleFlag flag, aclmdlRICondHandle *handle)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRICondHandleCreate);
    ACL_LOG_INFO("start to execute aclmdlRICondHandleCreate");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(handle);

    rtCondHandle_t rtHandle = nullptr;
    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtModelCondHandleCreate(static_cast<rtModel_t>(modelRI),
        defaultLaunchValue, static_cast<rtCondHandleFlag_t>(flag), &rtHandle), rtModelCondHandleCreate);

    if (rtHandle != nullptr) {
        *handle = static_cast<aclmdlRICondHandle>(rtHandle);
    }

    ACL_LOG_INFO("successfully execute aclmdlRICondHandleCreate");
    return ACL_SUCCESS;
}

aclError aclmdlRICondHandleGetCondPtrImpl(aclmdlRICondHandle handle, uint64_t **ptr)
{ 
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRICondHandleGetCondPtr);
    ACL_LOG_INFO("start to execute aclmdlRICondHandleGetCondPtr");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(handle);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(ptr);

    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtModelCondHandleGetCondPtr(static_cast<rtCondHandle_t>(handle), ptr), rtModelCondHandleGetCondPtr);

    ACL_LOG_INFO("successfully execute aclmdlRICondHandleGetCondPtr");
    return ACL_SUCCESS;
}

aclError aclmdlRIAddCondTaskImpl(aclmdlRICondTaskParams params, aclrtStream stream, uint32_t flags)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRIAddCondTask);
    ACL_LOG_INFO("start to execute aclmdlRIAddCondTask");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);

    rtCondTaskParams rtParams = {};
    rtParams.handle = static_cast<rtCondHandle_t>(params.handle);
    rtParams.type = static_cast<rtCondTaskType_t>(params.type);
    rtParams.size = params.size;
    rtParams.modelRIArray = reinterpret_cast<rtModel_t *>(params.modelRIArray);

    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtStreamAddCondTask(rtParams, static_cast<rtStream_t>(stream), flags), rtStreamAddCondTask);
    for (uint32_t i = 0; i < params.size; ++i) {
 	    params.modelRIArray[i] = static_cast<aclmdlRI>(rtParams.modelRIArray[i]);
 	}

    ACL_LOG_INFO("successfully execute aclmdlRIAddCondTask");
    return ACL_SUCCESS;
}

aclError aclmdlRICaptureToModelRIBeginImpl(aclrtStream stream, aclmdlRI modelRI, aclmdlRICaptureMode mode)
{
    ACL_PROFILING_REG(acl::AclProfType::AclmdlRICaptureToModelRIBegin);
    ACL_LOG_INFO("start to execute aclmdlRICaptureToModelRIBegin");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(modelRI);

    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtStreamBeginCaptureToModel(static_cast<rtStream_t>(stream), static_cast<rtModel_t>(modelRI), 
        static_cast<rtStreamCaptureMode>(mode)), rtStreamBeginCaptureToModel);

    ACL_LOG_INFO("successfully execute aclmdlRICaptureToModelRIBegin");
    return ACL_SUCCESS;
}

#ifdef __cplusplus
}
#endif
