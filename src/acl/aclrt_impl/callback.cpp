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
#include "runtime/rts/rts_kernel.h"
#include "runtime/kernel.h"
#include "runtime/base.h"
#include "runtime/rts/rts_stream.h"
#include "runtime/rts/rts_device.h"
#include "common/log_inner.h"
#include "common/error_codes_inner.h"
#include "common/prof_reporter.h"
#include "utils/data_type_utils.h"

namespace {
    constexpr uint32_t ACL_ERROR_INVALID_EXCEPTION_INFO = 0xFFFFFFFFU;
}

aclError aclrtSubscribeReportImpl(uint64_t threadId, aclrtStream stream)
{
    ACL_LOG_INFO("start to execute aclrtSubscribeReport, threadId is %lu.", threadId);
    const rtError_t rtErr = rtSubscribeReport(threadId, static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("subscribe report failed, runtime errorCode = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtSubscribeReport, threadId is %lu.", threadId);
    return ACL_SUCCESS;
}

aclError aclrtSetExceptionInfoCallbackImpl(aclrtExceptionInfoCallback callback)
{
    ACL_LOG_INFO("start to execute aclrtSetExceptionInfoCallback.");
    const rtError_t rtErr = rtRegTaskFailCallbackByModule(acl::ACL_MODULE_NAME,
        static_cast<rtTaskFailCallback>(callback));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("set callback of fail task failed, runtime errorCode = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtSetExceptionInfoCallback");
    return ACL_SUCCESS;
}

uint32_t aclrtGetTaskIdFromExceptionInfoImpl(const aclrtExceptionInfo *info)
{
    ACL_REQUIRES_NOT_NULL_RET_INPUT_REPORT(info, static_cast<aclError>(ACL_ERROR_INVALID_EXCEPTION_INFO));
    return info->taskid;
}

uint32_t aclrtGetStreamIdFromExceptionInfoImpl(const aclrtExceptionInfo *info)
{
    ACL_REQUIRES_NOT_NULL_RET_INPUT_REPORT(info, static_cast<aclError>(ACL_ERROR_INVALID_EXCEPTION_INFO));
    return info->streamid;
}

uint32_t aclrtGetThreadIdFromExceptionInfoImpl(const aclrtExceptionInfo *info)
{
    ACL_REQUIRES_NOT_NULL_RET_INPUT_REPORT(info, static_cast<aclError>(ACL_ERROR_INVALID_EXCEPTION_INFO));
    return info->tid;
}

uint32_t aclrtGetDeviceIdFromExceptionInfoImpl(const aclrtExceptionInfo *info)
{
    ACL_REQUIRES_NOT_NULL_RET_INPUT_REPORT(info, static_cast<aclError>(ACL_ERROR_INVALID_EXCEPTION_INFO));
    return info->deviceid;
}

uint32_t aclrtGetErrorCodeFromExceptionInfoImpl(const aclrtExceptionInfo *info)
{
    ACL_REQUIRES_NOT_NULL_RET_INPUT_REPORT(info, static_cast<aclError>(ACL_ERROR_INVALID_EXCEPTION_INFO));
    return info->retcode;
}

aclError aclrtGetArgsFromExceptionInfoImpl(const aclrtExceptionInfo *info, void **devArgsPtr, uint32_t *devArgsLen)
{
    ACL_REQUIRES_NOT_NULL_RET_INPUT_REPORT(info, static_cast<aclError>(ACL_ERROR_INVALID_EXCEPTION_INFO));
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(devArgsPtr);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(devArgsLen);
    
    if (info->expandInfo.type == RT_EXCEPTION_AICORE) {
        *devArgsPtr = info->expandInfo.u.aicoreInfo.exceptionArgs.argAddr;
        *devArgsLen = info->expandInfo.u.aicoreInfo.exceptionArgs.argsize;
    } else if (info->expandInfo.type == RT_EXCEPTION_FUSION && 
        info->expandInfo.u.fusionInfo.type == RT_FUSION_AICORE_CCU) {
        *devArgsPtr = info->expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.argAddr;
        *devArgsLen = info->expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.argsize;
    } else {
        ACL_LOG_ERROR("exception information type = %d is invalid, get args failed.", info->expandInfo.type);
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_VALUE_MSG,
            std::vector<const char *>({"func", "value", "param", "expect"}),
            std::vector<const char *>({__func__, acl::GetExceptionExpandTypeDesc(info->expandInfo.type),
                "info->expandInfo.type", "RT_EXCEPTION_AICORE or RT_EXCEPTION_FUSION"}));
        return ACL_ERROR_INVALID_EXCEPTION_INFO;
    }
    
    return ACL_SUCCESS;
}

aclError aclrtGetFuncHandleFromExceptionInfoImpl(const aclrtExceptionInfo *info, aclrtFuncHandle *func)
{
    ACL_REQUIRES_NOT_NULL_RET_INPUT_REPORT(info, static_cast<aclError>(ACL_ERROR_INVALID_EXCEPTION_INFO));
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(func);
    const rtError_t rtErr = rtGetFuncHandleFromExceptionInfo(info, func);
    if (rtErr != ACL_RT_SUCCESS) {
        ACL_LOG_CALL_ERROR("get func handle from exception info failed, runtime result = %d.", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    
    return ACL_SUCCESS;
}

aclError aclrtBinarySetExceptionCallbackImpl(aclrtBinHandle binHandle, aclrtOpExceptionCallback callback, void *userData)
{
    ACL_LOG_INFO("start to execute aclrtBinarySetExceptionCallback.");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(binHandle);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(callback);

    const rtError_t rtErr = rtBinarySetExceptionCallback(binHandle, callback, userData);
    if (rtErr != ACL_RT_SUCCESS) {
        ACL_LOG_CALL_ERROR("binary set exception callback failed, runtime result = %d.", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    
    return ACL_SUCCESS;
}

aclError aclrtLaunchCallbackImpl(aclrtCallback fn, void *userData, aclrtCallbackBlockType blockType,
    aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtLaunchCallback);
    ACL_LOG_INFO("start to execute aclrtLaunchCallback.");
    ACL_CHECK_INVALID_VALUE_WITH_DESC(
        (blockType == ACL_CALLBACK_BLOCK || blockType == ACL_CALLBACK_NO_BLOCK),
        acl::GetCallbackBlockTypeDesc(blockType), "blockType",
        "ACL_CALLBACK_BLOCK or ACL_CALLBACK_NO_BLOCK",
        ACL_ERROR_INVALID_PARAM);
    const bool isBlock = (blockType == ACL_CALLBACK_BLOCK);
    const rtError_t rtErr = rtCallbackLaunch(static_cast<rtCallback_t>(fn), userData,
        static_cast<rtStream_t>(stream), isBlock);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("launch callback task failed, runtime errorCode = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtLaunchCallback");
    return ACL_SUCCESS;
}

aclError aclrtLaunchHostFuncImpl(aclrtStream stream, aclrtHostFunc fn, void *args) 
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtLaunchHostFunc);
    ACL_LOG_INFO("start to execute aclrtLaunchHostFunc.");
    const rtError_t rtErr = rtsLaunchHostFunc(static_cast<rtStream_t>(stream), static_cast<rtCallback_t>(fn), args);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("launch callback task failed, runtime errorCode = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtLaunchHostFunc");
    return ACL_SUCCESS;
}

aclError aclrtProcessReportImpl(int32_t timeout)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtProcessReport);
    ACL_LOG_INFO("start to execute aclrtProcessReport, timeout is %dms.", timeout);
    // -1 represents infinite wait, timeout value greater than 0 represents waiting for a fixed time.
    // other value is invalid.
    ACL_CHECK_INVALID_PARAM_WITH_REASON_RET(
        (timeout < -1 || timeout == 0), timeout,
        "-1 represents infinite wait, timeout value greater than 0 represents waiting for a fixed time",
        ACL_ERROR_INVALID_PARAM);
    const rtError_t rtErr = rtProcessReport(timeout);
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_THREAD_SUBSCRIBE) {
            ACL_LOG_INFO("no subscribereport info, runtime errorCode = %d", static_cast<int32_t>(rtErr));
        } else if (rtErr == ACL_ERROR_RT_REPORT_TIMEOUT) {
            ACL_LOG_INFO("wait subscribereport timeout, runtime errorCode = %d", static_cast<int32_t>(rtErr));
        } else {
            ACL_LOG_CALL_ERROR("process report failed, runtime errorCode = %d", static_cast<int32_t>(rtErr));
        }
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully aclrtProcessReport, timeout is %dms.", timeout);
    return ACL_SUCCESS;
}

aclError aclrtUnSubscribeReportImpl(uint64_t threadId, aclrtStream stream)
{
    ACL_LOG_INFO("start to execute aclrtUnSubscribeReport, threadId is %lu.", threadId);
    const rtError_t rtErr = rtUnSubscribeReport(threadId, static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("unsubscribe report failed, runtime errorCode = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtUnSubscribeReport, threadId is %lu.", threadId);
    return ACL_SUCCESS;
}

aclError aclrtRegStreamStateCallbackImpl(const char *regName, aclrtStreamStateCallback callback, void *args)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtRegStreamStateCallback);
    ACL_LOG_INFO("start to execute aclrtRegStreamStateCallback");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(regName);
    const rtError_t rtErr = rtsRegStreamStateCallback(regName, reinterpret_cast<rtsStreamStateCallback>(callback), args);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsRegStreamStateCallback failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtRegStreamStateCallback");
    return ACL_SUCCESS;
}

aclError aclrtRegDeviceStateCallbackImpl(const char *regName, aclrtDeviceStateCallback callback, void *args)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtRegDeviceStateCallback);
    ACL_LOG_INFO("start to execute aclrtRegDeviceStateCallback");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(regName);

    const rtError_t rtErr = rtsRegDeviceStateCallback(regName, reinterpret_cast<rtsDeviceStateCallback>(callback), args);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsRegDeviceStateCallback failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtRegDeviceStateCallback");
    return ACL_SUCCESS;
}

aclError aclrtSetDeviceTaskAbortCallbackImpl(const char *regName, aclrtDeviceTaskAbortCallback callback, void *args)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetDeviceTaskAbortCallback);
    ACL_LOG_INFO("start to execute aclrtSetDeviceTaskAbortCallback");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(regName);

    const rtError_t rtErr = rtsSetDeviceTaskAbortCallback(regName, reinterpret_cast<rtsDeviceTaskAbortCallback>(callback), args);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsSetDeviceTaskAbortCallback failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtSetDeviceTaskAbortCallback");
    return ACL_SUCCESS;
}