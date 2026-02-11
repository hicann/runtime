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
#include "acl_rt_impl_base.h"

#include "runtime/context.h"
#include "runtime/rts/rts_context.h"
#include "runtime/dev.h"
#include "runtime/config.h"

#include "common/log_inner.h"
#include "common/error_codes_inner.h"
#include "common/prof_reporter.h"
#include "common/resource_statistics.h"

aclError aclrtCreateContextImpl(aclrtContext *context, int32_t deviceId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCreateContext);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_CONTEXT);
    ACL_LOG_INFO("start to execute aclrtCreateContext, device is %d.", deviceId);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(context);

    rtContext_t rtCtx = nullptr;
    const rtError_t rtErr = rtCtxCreateEx(&rtCtx, static_cast<uint32_t>(RT_CTX_NORMAL_MODE), deviceId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("create context failed, device is %d, runtime errorCode is %d",
            deviceId, static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtCreateContext, device is %d.", deviceId);
    *context = static_cast<aclrtContext>(rtCtx);
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_CONTEXT);

    // update platform info
    const auto err = acl::UpdatePlatformInfoWithDevice(deviceId);
    if (err != ACL_SUCCESS) {
        ACL_LOG_WARN("update platform info with device failed, error code is [%d], deviceId is [%d]", err, deviceId);
    }
    return ACL_SUCCESS;
}

aclError aclrtDestroyContextImpl(aclrtContext context)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDestroyContext);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_CONTEXT);
    ACL_LOG_INFO("start to execute aclrtDestroyContext.");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(context);

    const rtError_t rtErr = rtCtxDestroyEx(static_cast<rtContext_t>(context));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("destory context failed, runtime errorCode is %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtDestroyContext");
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_CONTEXT);
    return ACL_SUCCESS;
}

aclError aclrtSetCurrentContextImpl(aclrtContext context)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetCurrentContext);
    ACL_LOG_INFO("start to execute aclrtSetCurrentContext.");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(context);

    const rtError_t rtErr = rtCtxSetCurrent(static_cast<rtContext_t>(context));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("set current context failed, runtime errorCode is %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtSetCurrentContext");
    return ACL_SUCCESS;
}

aclError aclrtGetCurrentContextImpl(aclrtContext *context)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetCurrentContext);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(context);

    rtContext_t rtCtx = nullptr;
    const rtError_t rtErr = rtCtxGetCurrent(&rtCtx);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_INFO("can not get current context, runtime errorCode is %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    *context = rtCtx;
    return ACL_SUCCESS;
}

static aclError GetSysParamOpt(aclSysParamOpt opt, int64_t *value, bool isCtx)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(value);
    if (opt != ACL_OPT_DETERMINISTIC && opt != ACL_OPT_ENABLE_DEBUG_KERNEL && opt != ACL_OPT_STRONG_CONSISTENCY) {
        ACL_LOG_INNER_ERROR("[Check][SysParamOpt]opt = %d is invalid, it should be %d or %d or %d",
                            static_cast<int32_t>(opt), static_cast<int32_t>(ACL_OPT_DETERMINISTIC),
                            static_cast<int32_t>(ACL_OPT_ENABLE_DEBUG_KERNEL), 
                            static_cast<int32_t>(ACL_OPT_STRONG_CONSISTENCY));
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_MSG,
            std::vector<const char *>({"param", "value", "reason"}),
            std::vector<const char *>({"aclSysParamOpt", std::to_string(opt).c_str(), "must be 0 or 1 or 2"}));
        return ACL_ERROR_INVALID_PARAM;
    }
    rtError_t rtErr = RT_ERROR_NONE;
    if (isCtx) {
        rtErr = rtCtxGetSysParamOpt(static_cast<rtSysParamOpt>(opt), value);
    }
    else {
        rtErr = rtGetSysParamOpt(static_cast<rtSysParamOpt>(opt), value);
    }
    if (rtErr == ACL_ERROR_RT_SYSPARAMOPT_NOT_SET) {
        ACL_LOG_WARN("option %d is not set, runtime errorCode is %d",
            static_cast<int32_t>(opt),  static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("get sys param failed, runtime result = %d, opt = %d.",
                           static_cast<int32_t>(rtErr), static_cast<int32_t>(opt));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute GetSysParamOpt, opt = %d, value = %ld",
                 static_cast<int32_t>(opt), *value);
    return ACL_SUCCESS;
}

static aclError SetSysParamOpt(aclSysParamOpt opt, int64_t value, bool isCtx)
{
    if (opt != ACL_OPT_DETERMINISTIC && opt != ACL_OPT_ENABLE_DEBUG_KERNEL && opt != ACL_OPT_STRONG_CONSISTENCY) {
        ACL_LOG_INNER_ERROR("[Check][SysParamOpt]opt = %d is invalid, it should be %d or %d or %d",
                            static_cast<int32_t>(opt), static_cast<int32_t>(ACL_OPT_DETERMINISTIC),
                            static_cast<int32_t>(ACL_OPT_ENABLE_DEBUG_KERNEL), 
                            static_cast<int32_t>(ACL_OPT_STRONG_CONSISTENCY));
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_MSG,
            std::vector<const char *>({"param", "value", "reason"}),
            std::vector<const char *>({"aclSysParamOpt", std::to_string(opt).c_str(), "should be 0 or 1 or 2"}));
        return ACL_ERROR_INVALID_PARAM;
    }
    rtError_t rtErr = RT_ERROR_NONE;
    if (isCtx) {
        rtErr = rtCtxSetSysParamOpt(static_cast<rtSysParamOpt>(opt), value);
    } else {
        rtErr = rtSetSysParamOpt(static_cast<rtSysParamOpt>(opt), value);
    }
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("set sys param failed, runtime result = %d, opt = %d.",
                           static_cast<int32_t>(rtErr), static_cast<int32_t>(opt));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtCtxSetSysParamOpt");
    return ACL_SUCCESS;
}


aclError aclrtCtxGetSysParamOptImpl(aclSysParamOpt opt, int64_t *value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCtxGetSysParamOpt);
    return GetSysParamOpt(opt, value, true);
}

aclError aclrtCtxSetSysParamOptImpl(aclSysParamOpt opt, int64_t value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCtxSetSysParamOpt);
    ACL_LOG_INFO("start to execute aclrtCtxSetSysParamOpt, opt = %d, value = %ld.",
                 static_cast<int32_t>(opt), value);
    return SetSysParamOpt(opt, value, true);
}

aclError aclrtGetSysParamOptImpl(aclSysParamOpt opt, int64_t *value)
{
    return GetSysParamOpt(opt, value, false);
}

aclError aclrtSetSysParamOptImpl(aclSysParamOpt opt, int64_t value)
{
    ACL_LOG_INFO("start to execute aclrtSetSysParamOpt, opt = %d, value = %ld.",
                 static_cast<int32_t>(opt), value);
    return SetSysParamOpt(opt, value, false);
}

aclError aclrtPeekAtLastErrorImpl(aclrtLastErrLevel level)
{
    ACL_LOG_INFO("start to execute aclrtPeekAtLastError, level is %d", static_cast<int32_t>(level));
    if (level != ACL_RT_THREAD_LEVEL) {
        ACL_LOG_ERROR("invalid input param level %d, only support ACL_RT_THREAD_LEVEL", static_cast<int32_t>(level));
        return ACL_ERROR_INVALID_PARAM;
    }
    const rtLastErrLevel_t rtLevel = static_cast<rtLastErrLevel_t>(level);
    return rtPeekAtLastError(rtLevel);
}

aclError aclrtGetLastErrorImpl(aclrtLastErrLevel level)
{
    ACL_LOG_INFO("start to execute aclrtGetLastError, level is %d", static_cast<int32_t>(level));
    if (level != ACL_RT_THREAD_LEVEL) {
        ACL_LOG_ERROR("invalid input param level %d, only support ACL_RT_THREAD_LEVEL", static_cast<int32_t>(level));
        return ACL_ERROR_INVALID_PARAM;
    }
    const rtLastErrLevel_t rtLevel = static_cast<rtLastErrLevel_t>(level);
    return rtGetLastError(rtLevel);
}

aclError aclrtCtxGetCurrentDefaultStreamImpl(aclrtStream *stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCtxGetCurrentDefaultStream);
    ACL_LOG_INFO("start to execute aclrtCtxGetCurrentDefaultStream");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);

    const rtError_t rtErr = rtsCtxGetCurrentDefaultStream(stream);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_ERROR("call rtsCtxGetCurrentDefaultStream failed, runtime errorCode is %d",
            static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtCtxGetCurrentDefaultStream");
    return ACL_SUCCESS;
}

aclError aclrtCtxGetFloatOverflowAddrImpl(void **overflowAddr)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCtxGetFloatOverflowAddr);

    const rtError_t rtErr = rtsCtxGetFloatOverflowAddr(overflowAddr);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_ERROR("call rtsCtxGetFloatOverflowAddr failed, runtime errorCode is %d",
            static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    return ACL_SUCCESS;
}

aclError aclrtGetPrimaryCtxStateImpl(int32_t deviceId, uint32_t *flags, int32_t *active)
{
    ACL_LOG_INFO("start to execute aclrtGetPrimaryCtxState");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(active);
    if (flags != nullptr) {
        ACL_LOG_ERROR("[Check][flags]paramete flags is reserved, it must be null.");
            const char_t *argList[] = {"param"};
            const char_t *argVal[] = {"flags"};
        acl::AclErrorLogManager::ReportInputErrorWithChar(acl::INVALID_PARAM_MSG,
            argList, argVal, 1U);
        return ACL_ERROR_INVALID_PARAM;
    }
    uint32_t tmp = 0;
    const rtError_t rtErr = rtsGetPrimaryCtxState(deviceId, &tmp, active);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_WARN("call aclrtGetPrimaryCtxState failed, runtime errorCode is %d, device id is %d",
            static_cast<int32_t>(rtErr), deviceId);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtGetPrimaryCtxState");
    return ACL_SUCCESS;
}