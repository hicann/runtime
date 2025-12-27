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
#include "errcode_manage.hpp"
#include "error_code.h"
#include "osal.hpp"
#include "profiler.hpp"
#include "thread_local_container.hpp"
#include "global_state_manager.hpp"
#define INVALID_UINT32 (0xFFFFFFFFU)

using namespace cce::runtime;

namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(rtStreamCreate);
TIMESTAMP_EXTERN(rtStreamDestroy);
TIMESTAMP_EXTERN(rtStreamDestroyForce);
TIMESTAMP_EXTERN(rtStreamSynchronize);
TIMESTAMP_EXTERN(rtStreamSynchronizeWithTimeout);
TIMESTAMP_EXTERN(rtStreamCreateByGrp);
}  // namespace runtime
}  // namespace cce

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

VISIBILITY_DEFAULT
rtError_t rtStreamCreate(rtStream_t *stm, int32_t priority)
{
    return rtStreamCreateWithFlags(stm, priority, RT_STREAM_DEFAULT);
}

VISIBILITY_DEFAULT
rtError_t rtsStreamCreate(rtStream_t *stream, rtStreamCreateConfig_t *config)
{
    int32_t priority = RT_STREAM_PRIORITY_DEFAULT;
    uint32_t flags = RT_STREAM_DEFAULT;

    if (config != nullptr) {
        COND_RETURN_ERROR_WITH_EXT_ERRCODE((config->attrs == nullptr),
            RT_ERROR_INVALID_VALUE, "Invalid config, attrs is nullptr .");
        for (uint32_t i = 0; i < config->numAttrs; ++i) {
            switch (config->attrs[i].id) {
                case RT_STREAM_CREATE_ATTR_FLAGS:
                    flags = config->attrs[i].value.flags;
                    break;
                case RT_STREAM_CREATE_ATTR_PRIORITY:
                    priority = config->attrs[i].value.priority;
                    break;
                default:
                    RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "Invalid attribute id: %d, "
                        "Supported stream attribute IDs: [%d, %d).", config->attrs[i].id,
                        RT_STREAM_CREATE_ATTR_FLAGS, RT_STREAM_CREATE_ATTR_MAX);
                    return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE);
            }
        }
    }
    return rtStreamCreateWithFlags(stream, priority, flags);
}

VISIBILITY_DEFAULT
rtError_t rtStreamCreateWithFlags(rtStream_t *stm, int32_t priority, uint32_t flags)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_NAME(__func__);
    TIMESTAMP_BEGIN(rtStreamCreate);
    const rtError_t ret = apiInstance->StreamCreate(RtPtrToPtr<Stream **>(stm), priority, flags, nullptr);
    TIMESTAMP_END(rtStreamCreate);
    COND_RETURN_WITH_NOLOG(ret == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamDestroy(rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_NAME(__func__);
    Stream * const exeStream = static_cast<Stream *>(stm);
    TIMESTAMP_BEGIN(rtStreamDestroy);
    const rtError_t error = apiInstance->StreamDestroy(exeStream, false);
    TIMESTAMP_END(rtStreamDestroy);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamDestroyForce(rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_NAME(__func__);
    Stream * const exeStream = static_cast<Stream *>(stm);
    TIMESTAMP_BEGIN(rtStreamDestroyForce);
    const rtError_t error = apiInstance->StreamDestroy(exeStream, true);
    TIMESTAMP_END(rtStreamDestroyForce);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamWaitEvent(rtStream_t stm, rtEvent_t evt)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Stream * const exeStream = static_cast<Stream *>(stm);
    Event * const waitEvent = static_cast<Event *>(evt);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(Runtime::Instance());
    TIMESTAMP_NAME(__func__);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    rtError_t ret;
    DevProperties properties;
    GET_DEV_PROPERTIES(Runtime::Instance()->GetChipType(), properties);
    if (properties.streamWaitEventTimeout != cce::runtime::StreamWaitEventTimeout::NOT_SUPPORT) {
        ret = apiInstance->StreamWaitEvent(exeStream, waitEvent, Runtime::Instance()->GetWaitTimeout());
    } else {
        ret = apiInstance->StreamWaitEvent(exeStream, waitEvent);
    }
    (void)AwdStopThreadWatchdog(watchDogHandle);
    COND_RETURN_WITH_NOLOG(ret == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamSynchronize(rtStream_t stm)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtStreamSynchronize);
    Stream * const exeStream = static_cast<Stream *>(stm);
    const rtError_t error = apiInstance->StreamSynchronize(exeStream);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_END_OF_SEQUENCE, ACL_ERROR_RT_END_OF_SEQUENCE); // special state
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_MODEL_ABORT_NORMAL, ACL_ERROR_RT_MODEL_ABORT_NORMAL); // special state
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_TSFW_AICORE_OVER_FLOW_FAIL, ACL_ERROR_RT_AICORE_OVER_FLOW);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_TSFW_AIVEC_OVER_FLOW_FAIL, ACL_ERROR_RT_AIVEC_OVER_FLOW);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_TSFW_AICPU_OVER_FLOW_FAIL, ACL_ERROR_RT_OVER_FLOW);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_TSFW_SDMA_OVER_FLOW_FAIL, ACL_ERROR_RT_OVER_FLOW);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_SOCKET_CLOSE, ACL_ERROR_RT_SOCKET_CLOSE); // special state

    TIMESTAMP_END(rtStreamSynchronize);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamSynchronizeWithTimeout(rtStream_t stm, int32_t timeout)
{
    Api *const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtStreamSynchronizeWithTimeout);
    Stream * const exeStream = static_cast<Stream *>(stm);
    const rtError_t error = apiInstance->StreamSynchronize(exeStream, timeout);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_END_OF_SEQUENCE, ACL_ERROR_RT_END_OF_SEQUENCE); // special state
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_MODEL_ABORT_NORMAL, ACL_ERROR_RT_MODEL_ABORT_NORMAL); // special state
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_TSFW_AICORE_OVER_FLOW_FAIL, ACL_ERROR_RT_AICORE_OVER_FLOW);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_TSFW_AIVEC_OVER_FLOW_FAIL, ACL_ERROR_RT_AIVEC_OVER_FLOW);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_TSFW_AICPU_OVER_FLOW_FAIL, ACL_ERROR_RT_OVER_FLOW);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_TSFW_SDMA_OVER_FLOW_FAIL, ACL_ERROR_RT_OVER_FLOW);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_SOCKET_CLOSE, ACL_ERROR_RT_SOCKET_CLOSE); // special state

    TIMESTAMP_END(rtStreamSynchronizeWithTimeout);
#ifndef CFG_DEV_PLATFORM_PC
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
#else
    return GetRtExtErrCodeAndSetGlobalErr(error);
#endif
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamQuery(rtStream_t stm)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    Stream * const exeStream = static_cast<Stream *>(stm);
    const rtError_t ret = apiInstance->StreamQuery(exeStream);
    COND_RETURN_WITH_NOLOG(ret == RT_ERROR_STREAM_NOT_COMPLETE, ACL_ERROR_RT_STREAM_NOT_COMPLETE); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetStreamId(rtStream_t stm, int32_t *streamId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    Stream * const exeStream = static_cast<Stream *>(stm);
    const rtError_t ret = apiInstance->GetStreamId(exeStream, streamId);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamGetPriority(const rtStream_t stm, uint32_t *priority)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    Stream * const exeStream = static_cast<Stream *>(stm);
    const rtError_t ret = apiInstance->StreamGetPriority(exeStream, priority);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamGetFlags(const rtStream_t stm, uint32_t *flags)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    Stream * const exeStream = static_cast<Stream *>(stm);
    const rtError_t ret = apiInstance->StreamGetFlags(exeStream, flags);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamGetSqid(const rtStream_t stm, uint32_t *sqId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    Stream * const exeStream = static_cast<Stream *>(stm);
    const rtError_t ret = apiInstance->GetSqId(exeStream, sqId);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamGetCqid(const rtStream_t stm, uint32_t *cqId, uint32_t *logicCqId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    Stream * const exeStream = static_cast<Stream *>(stm);
    const rtError_t ret = apiInstance->GetCqId(exeStream, cqId, logicCqId);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetMaxStreamAndTask(uint32_t streamType, uint32_t *maxStrCount, uint32_t *maxTaskCount)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t ret = apiInstance->GetMaxStreamAndTask(streamType, maxStrCount, maxTaskCount);
    COND_RETURN_WITH_NOLOG(ret == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetAvailStreamNum(const uint32_t streamType, uint32_t * const streamCount)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t ret = apiInstance->GetAvailStreamNum(streamType, streamCount);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetTaskIdAndStreamID(uint32_t *taskId, uint32_t *streamId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t ret = apiInstance->GetTaskIdAndStreamID(taskId, streamId);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamSetMode(rtStream_t stm, const uint64_t stmMode)
{
    Stream * const exeStream = static_cast<Stream *>(stm);
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_STREAM_DOT_SET_MODE)) {
        REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->StreamSetMode(exeStream, stmMode);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamGetMode(rtStream_t const stm, uint64_t * const stmMode)
{
    const Stream * const exeStream = static_cast<Stream *>(stm);
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->StreamGetMode(exeStream, stmMode);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamSwitchEx(void *ptr, rtCondition_t condition, void *valuePtr, rtStream_t trueStream,
                           rtStream_t stm, rtSwitchDataType_t dataType)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->StreamSwitchEx(ptr, condition, valuePtr, static_cast<Stream *>(trueStream),
        static_cast<Stream *>(stm), dataType);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamSwitchN(void *ptr, uint32_t size, void *valuePtr, rtStream_t *trueStreamPtr,
                          uint32_t elementSize, rtStream_t stm, rtSwitchDataType_t dataType)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->StreamSwitchN(ptr, size, valuePtr, RtPtrToPtr<Stream **>(trueStreamPtr),
        elementSize, static_cast<Stream *>(stm), dataType);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamActive(rtStream_t activeStream, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->StreamActive(static_cast<Stream *>(activeStream), static_cast<Stream *>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsSwitchStream(void *leftValue, rtCondition_t cond, void *rightValue, rtSwitchDataType_t dataType,
                          rtStream_t trueStream, rtStream_t falseStream, rtStream_t stream)
{
    COND_RETURN_ERROR_WITH_EXT_ERRCODE((falseStream != nullptr), RT_ERROR_INVALID_VALUE,
        "falseStream is a reserved parameter, only support nullptr.");
    return rtStreamSwitchEx(leftValue, cond, rightValue, trueStream, stream, dataType);
}

VISIBILITY_DEFAULT
rtError_t rtsActiveStream(rtStream_t activeStream, rtStream_t stream)
{
    return rtStreamActive(activeStream, stream);
}

VISIBILITY_DEFAULT
rtError_t rtStreamWaitEventWithTimeout(rtStream_t stm, rtEvent_t evt, uint32_t timeout)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    Stream * const exeStream = static_cast<Stream *>(stm);
    Event * const waitEvent = static_cast<Event *>(evt);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    uint32_t work_timeout = 0;
    DevProperties properties;
    GET_DEV_PROPERTIES(rtInstance->GetChipType(), properties);
    if (properties.streamWaitEventTimeout == cce::runtime::StreamWaitEventTimeout::ZERO) {
        work_timeout = ((timeout == INVALID_UINT32) ? Runtime::Instance()->GetWaitTimeout() : 0);
    } else if (properties.streamWaitEventTimeout == cce::runtime::StreamWaitEventTimeout::CUSTOM) {
        work_timeout = ((timeout == INVALID_UINT32) ? Runtime::Instance()->GetWaitTimeout() : timeout);
    } else {
        // nothing to do
    }
    const rtError_t ret = apiInstance->StreamWaitEvent(exeStream, waitEvent, work_timeout);

    (void)AwdStopThreadWatchdog(watchDogHandle);
    COND_RETURN_WITH_NOLOG(ret == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsStreamSetAttribute(rtStream_t stm, rtStreamAttr stmAttrId, rtStreamAttrValue_t *attrValue)
{
    NULL_PTR_RETURN_MSG_OUTER(attrValue, ACL_ERROR_RT_PARAM_INVALID);
    rtError_t error;
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Stream * const exeStream = static_cast<Stream *>(stm);

    switch (stmAttrId) {
        case RT_STREAM_ATTR_FAILURE_MODE: {
            COND_RETURN_WARN(!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(),
                RtOptionalFeatureType::RT_FEATURE_STREAM_ATTR_FAILURE_MODE), ACL_ERROR_RT_FEATURE_NOT_SUPPORT,
                "chip type(%d) does not support, return.", static_cast<int32_t>(rtInstance->GetChipType()));
            error = apiInstance->StreamSetMode(exeStream, attrValue->failureMode);
            break;
        }
        case RT_STREAM_ATTR_FLOAT_OVERFLOW_CHECK: {
            if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_STREAM_ATTR_OVERFLOW_CHECK)) {
                RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return success.",
                    static_cast<int32_t>(rtInstance->GetChipType()));
                return ACL_RT_SUCCESS;
            }
            error = apiInstance->SetStreamOverflowSwitch(exeStream, attrValue->overflowSwitch);
            break;
        }
        case RT_STREAM_ATTR_USER_CUSTOM_TAG: {
            if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_STREAM_ATTR_USER_CUSTOM_TAG)) {
                RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return success.", static_cast<int32_t>(rtInstance->GetChipType()));
                return ACL_RT_SUCCESS;
            }
            error = apiInstance->SetStreamTag(exeStream, attrValue->userCustomTag);
            break;
        }
        case RT_STREAM_ATTR_CACHE_OP_INFO: {
            error = apiInstance->SetStreamCacheOpInfoSwitch(exeStream, attrValue->cacheOpInfoSwitch);
            break;
        }
        default:
            RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,  "Invalid stream attribute ID: %d, "
                "Supported stream attribute IDs: [%d, %d).", stmAttrId,
                RT_STREAM_ATTR_FAILURE_MODE, RT_STREAM_ATTR_MAX);
            error = RT_ERROR_INVALID_VALUE;
            break;
    }
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsStreamGetAttribute(rtStream_t stm, rtStreamAttr stmAttrId, rtStreamAttrValue_t *attrValue)
{
    NULL_PTR_RETURN_MSG_OUTER(attrValue, ACL_ERROR_RT_PARAM_INVALID);
    rtError_t error;
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
	Stream * const exeStream = static_cast<Stream *>(stm);

    switch (stmAttrId) {
        case RT_STREAM_ATTR_FAILURE_MODE: {
            error = apiInstance->StreamGetMode(exeStream, &attrValue->failureMode);
            break;
        }
        case RT_STREAM_ATTR_FLOAT_OVERFLOW_CHECK: {
            error = apiInstance->GetStreamOverflowSwitch(exeStream, &attrValue->overflowSwitch);
            break;
        }
        case RT_STREAM_ATTR_USER_CUSTOM_TAG: {
            if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_STREAM_ATTR_USER_CUSTOM_TAG)) {
                RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return success.", static_cast<int32_t>(rtInstance->GetChipType()));
                return ACL_RT_SUCCESS;
            }
            error = apiInstance->GetStreamTag(exeStream, &attrValue->userCustomTag);
            break;
        }
        case RT_STREAM_ATTR_CACHE_OP_INFO: {
            error = apiInstance->GetStreamCacheOpInfoSwitch(exeStream, &attrValue->cacheOpInfoSwitch);
            break;
        }
        default:
            RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,  "Invalid stream attribute ID: %d, "
                "Supported stream attribute IDs: [%d, %d).", stmAttrId,
                RT_STREAM_ATTR_FAILURE_MODE, RT_STREAM_ATTR_MAX);
            error = RT_ERROR_INVALID_VALUE;
            break;
    }
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtSetStreamOverflowSwitch(rtStream_t stm, uint32_t flags)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_STREAM_ATTR_OVERFLOW_CHECK)) {
        RT_LOG(RT_LOG_INFO, "chip type(%d) does not support, return success.",
               static_cast<int32_t>(rtInstance->GetChipType()));
        return ACL_RT_SUCCESS;
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Stream * const targetStm = static_cast<Stream *>(stm);
    const rtError_t ret = apiInstance->SetStreamOverflowSwitch(targetStm, flags);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtGetStreamOverflowSwitch(rtStream_t stm, uint32_t *flags)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Stream * const targetStm = static_cast<Stream *>(stm);
    const rtError_t ret = apiInstance->GetStreamOverflowSwitch(targetStm, flags);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtStreamCreateByGrp(rtStream_t *stm, int32_t priority, uint32_t flags, rtDvppGrp_t grp)
{
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(grp, RT_ERROR_INVALID_VALUE);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_BEGIN(rtStreamCreateByGrp);
    const rtError_t ret = apiInstance->StreamCreate(RtPtrToPtr<Stream **>(stm), priority, flags,
        RtPtrToPtr<DvppGrp *>(grp));
    TIMESTAMP_END(rtStreamCreateByGrp);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetStreamTag(rtStream_t stm, uint32_t geOpTag)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_STREAM_TAG)) {
        RT_LOG(RT_LOG_DEBUG, "chip type(%d) does not support, return.", static_cast<int32_t>(rtInstance->GetChipType()));
        return ACL_RT_SUCCESS;
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    Stream * const streamPtr = static_cast<Stream *>(stm);
    const rtError_t error = apiInstance->SetStreamTag(streamPtr, geOpTag);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetStreamTag(rtStream_t stm, uint32_t *geOpTag)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_STREAM_TAG)) {
        RT_LOG(RT_LOG_DEBUG, "chip type(%d) does not support, return.", static_cast<int32_t>(rtInstance->GetChipType()));
        return ACL_RT_SUCCESS;
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    Stream * const streamPtr = static_cast<Stream *>(stm);
    const rtError_t error = apiInstance->GetStreamTag(streamPtr, geOpTag);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetStreamSqLock(rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SetStreamSqLockUnlock(static_cast<Stream *>(stm), true);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetStreamSqUnlock(rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SetStreamSqLockUnlock(static_cast<Stream *>(stm), false);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtThreadExchangeCaptureMode(rtStreamCaptureMode *mode)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_MODEL_ACL_GRAPH)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return.",
            static_cast<int32_t>(chipType));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ThreadExchangeCaptureMode(mode);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamAbort(rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rtInstance, RT_ERROR_INSTANCE_NULL);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    const rtError_t error = apiInstance->StreamAbort(static_cast<Stream *>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsStreamDestroy(rtStream_t stm, uint64_t flags)
{
    constexpr uint64_t STREAM_DESTROY_VALID_FLAGS = (RT_STREAM_DESTORY_FLAG_DEFAULT | RT_STREAM_DESTORY_FLAG_FORCE);
    COND_RETURN_OUT_ERROR_MSG_CALL((flags & (~STREAM_DESTROY_VALID_FLAGS)) != 0U, ACL_ERROR_RT_PARAM_INVALID,
        "flags=%" PRIu64 " does not support.", flags);
    if ((flags & RT_STREAM_DESTORY_FLAG_FORCE) != 0U) {
        return rtStreamDestroyForce(stm);
    }
    return rtStreamDestroy(stm);
}

VISIBILITY_DEFAULT
rtError_t rtsStreamAbort(rtStream_t stm)
{
    return rtStreamAbort(stm);
}

VISIBILITY_DEFAULT
rtError_t rtsStreamSynchronize(rtStream_t stm, int32_t timeout)
{
    COND_RETURN_OUT_ERROR_MSG_CALL((timeout < -1) || (timeout == 0), ACL_ERROR_RT_PARAM_INVALID,
        "timeout=%dms does not support.", timeout);
    if (timeout == -1) {
        return rtStreamSynchronize(stm);
    }
    return rtStreamSynchronizeWithTimeout(stm, timeout);
}

VISIBILITY_DEFAULT
rtError_t rtsStreamQuery(rtStream_t stm)
{
    return rtStreamQuery(stm);
}

VISIBILITY_DEFAULT
rtError_t rtsStreamGetAvailableNum(uint32_t *streamCount)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rtInstance, RT_ERROR_INSTANCE_NULL);
    COND_RETURN_WARN(!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_STREAM_GET_AVILIABLE_NUM),
        ACL_ERROR_RT_FEATURE_NOT_SUPPORT, "feature does not support");

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->GetFreeStreamNum(streamCount);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsStreamGetId(rtStream_t stm, int32_t *streamId)
{
    return rtGetStreamId(stm, streamId);
}

VISIBILITY_DEFAULT
rtError_t rtsStreamBeginTaskGrp(rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_MODEL_ACL_GRAPH)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) or ctx gen mode does not support, return.",
            static_cast<int32_t>(chipType));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->StreamBeginTaskGrp(static_cast<Stream *>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsStreamBeginTaskUpdate(rtStream_t stm, rtTaskGrp_t handle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_MODEL_ACL_GRAPH)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) or ctx gen mode does not support, return.",
            static_cast<int32_t>(chipType));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Stream * const exeStream = static_cast<Stream *>(stm);
    TaskGroup * const taskGrpHandle = static_cast<TaskGroup *>(handle);
    const rtError_t error = apiInstance->StreamBeginTaskUpdate(exeStream, taskGrpHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsStreamEndTaskGrp(rtStream_t stm, rtTaskGrp_t *handle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_MODEL_ACL_GRAPH)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) or ctx gen mode does not support, return.",
            static_cast<int32_t>(chipType));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->StreamEndTaskGrp(
        static_cast<Stream *>(stm), RtPtrToPtr<TaskGroup **>(handle));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsStreamEndTaskUpdate(rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_MODEL_ACL_GRAPH)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) or ctx gen mode does not support, return.",
            static_cast<int32_t>(chipType));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Stream * const exeStream = static_cast<Stream *>(stm);
    const rtError_t error = apiInstance->StreamEndTaskUpdate(exeStream);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsSetStreamResLimit(rtStream_t stm, const rtDevResLimitType_t type, const uint32_t value)
{
    Api *const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SetStreamResLimit(static_cast<Stream *>(stm), type, value);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsResetStreamResLimit(rtStream_t stm)
{
    Api *const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ResetStreamResLimit(static_cast<Stream *>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsGetStreamResLimit(const rtStream_t stm, const rtDevResLimitType_t type, uint32_t *const value)
{
    Api *const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetStreamResLimit(static_cast<const Stream *>(stm), type, value);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsUseStreamResInCurrentThread(const rtStream_t stm) {
    Api *const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->UseStreamResInCurrentThread(static_cast<Stream *>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsNotUseStreamResInCurrentThread(const rtStream_t stm) {
    Api *const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->NotUseStreamResInCurrentThread(static_cast<Stream *>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsGetResInCurrentThread(const rtDevResLimitType_t type, uint32_t *const value) {
    Api *const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetResInCurrentThread(type, value);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus
