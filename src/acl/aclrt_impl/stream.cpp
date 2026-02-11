/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <unordered_map>
#include "acl_rt_impl.h"

#include "runtime/stream.h"
#include "runtime/rts/rts_stream.h"

#include "common/log_inner.h"
#include "common/error_codes_inner.h"
#include "common/prof_reporter.h"
#include "common/resource_statistics.h"

namespace {
std::unordered_map<rtError_t, const char *> succStmSyncErrCodes = {
    {ACL_ERROR_RT_END_OF_SEQUENCE, "end of sequence"},
    {ACL_ERROR_RT_MODEL_ABORT_NORMAL, "model abort normal"},
    {ACL_ERROR_RT_AICORE_OVER_FLOW, "aicore overflow"},
    {ACL_ERROR_RT_AIVEC_OVER_FLOW, "aivec overflow"},
    {ACL_ERROR_RT_OVER_FLOW, "overflow"},
    {ACL_ERROR_RT_SOCKET_CLOSE, "socket close"}};
}

aclError aclrtCreateStreamImpl(aclrtStream *stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCreateStream);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_STREAM);
    ACL_LOG_INFO("start to execute aclrtCreateStream");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);

    rtStream_t rtStream = nullptr;
    const rtError_t rtErr = rtStreamCreate(&rtStream, static_cast<int32_t>(RT_STREAM_PRIORITY_DEFAULT));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("create stream failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    *stream = static_cast<aclrtStream>(rtStream);
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_STREAM);
    return ACL_SUCCESS;
}

aclError aclrtCreateStreamWithConfigImpl(aclrtStream *stream, uint32_t priority, uint32_t flag)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCreateStreamWithConfig);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_STREAM);
    ACL_LOG_INFO("start to execute aclrtCreateStreamWithConfig with priority:%u, flag:%u", priority, flag);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);

    uint32_t streamFlag = 0U;
    if ((flag & ACL_STREAM_FAST_LAUNCH) != 0U) {
        streamFlag |= RT_STREAM_FAST_LAUNCH;
    }
    if ((flag & ACL_STREAM_FAST_SYNC) != 0U) {
        streamFlag |= RT_STREAM_FAST_SYNC;
    }
    if ((flag & ACL_STREAM_PERSISTENT) != 0U) {
        streamFlag |= RT_STREAM_PERSISTENT;
    }
    if ((flag & ACL_STREAM_HUGE) != 0U) {
        streamFlag |= RT_STREAM_HUGE;
    }
    if ((flag & ACL_STREAM_CPU_SCHEDULE) != 0U) {
        streamFlag |= RT_STREAM_CPU_SCHEDULE;
    }
    if ((flag & ACL_STREAM_DEVICE_USE_ONLY) != 0U) {
        streamFlag |= RT_STREAM_CP_PROCESS_USE;
    }

    rtStream_t rtStream = nullptr;
    constexpr size_t numAttrs = 2;
    rtStreamCreateAttr_t attrs[numAttrs];
    attrs[0].id = RT_STREAM_CREATE_ATTR_PRIORITY;
    attrs[0].value.priority = priority;
    attrs[1].id = RT_STREAM_CREATE_ATTR_FLAGS;
    attrs[1].value.flags = streamFlag;
    rtStreamCreateConfig_t config = {attrs, numAttrs};
    const rtError_t rtErr = rtsStreamCreate(&rtStream, &config);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("create stream failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    *stream = static_cast<aclrtStream>(rtStream);
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_STREAM);
    return ACL_SUCCESS;
}

aclError aclrtDestroyStreamImpl(aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDestroyStream);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_STREAM);
    ACL_LOG_INFO("start to execute aclrtDestroyStream");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);

    const rtError_t rtErr = rtStreamDestroy(static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("destroy stream failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("aclrtDestroyStream success");
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_STREAM);
    return ACL_SUCCESS;
}

aclError aclrtDestroyStreamForceImpl(aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDestroyStreamForce);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_STREAM);
    ACL_LOG_INFO("start to execute aclrtDestroyStreamForce");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);

    const rtError_t rtErr = rtStreamDestroyForce(static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("destroy stream force failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("aclrtDestroyStreamForce success");
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_STREAM);
    return ACL_SUCCESS;
}

aclError aclrtSynchronizeStreamImpl(aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSynchronizeStream);

    const rtError_t rtErr = rtStreamSynchronize(static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        const auto it = succStmSyncErrCodes.find(rtErr);
        if (it == succStmSyncErrCodes.cend()) {
            ACL_LOG_CALL_ERROR("synchronize stream failed, runtime result = %d", static_cast<int32_t>(rtErr));
        } else {
            ACL_LOG_INFO("Synchronize stream success, err = %d, desc = %s",
                         static_cast<int32_t>(rtErr), it->second);
        }
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    return ACL_SUCCESS;
}

aclError aclrtSynchronizeStreamWithTimeoutImpl(aclrtStream stream, int32_t timeout)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSynchronizeStreamWithTimeout);
    constexpr int32_t default_timeout = -1;
    if (timeout < default_timeout) {
        ACL_LOG_CALL_ERROR("the timeout of synchronize stream is invalid");
        return ACL_ERROR_RT_PARAM_INVALID;
    }
    const rtError_t rtErr = rtStreamSynchronizeWithTimeout(static_cast<rtStream_t>(stream), timeout);
    if (rtErr == ACL_ERROR_RT_STREAM_SYNC_TIMEOUT) {
        ACL_LOG_CALL_ERROR("synchronize stream timeout, timeout = %dms", timeout);
        return ACL_ERROR_RT_STREAM_SYNC_TIMEOUT;
    }
    if (rtErr != RT_ERROR_NONE) {
        const auto it = succStmSyncErrCodes.find(rtErr);
        if (it == succStmSyncErrCodes.cend()) {
            ACL_LOG_CALL_ERROR("synchronize stream with timeout failed, runtime result = %d",
                               static_cast<int32_t>(rtErr));
        } else {
            ACL_LOG_INFO("synchronize stream with timeout success, err = %d, desc = %s",
                         static_cast<int32_t>(rtErr), it->second);
        }
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    return ACL_SUCCESS;
}

aclError aclrtStreamQueryImpl(aclrtStream stream, aclrtStreamStatus *status)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtStreamQuery);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(status);

    const rtError_t rtErr = rtStreamQuery(static_cast<rtStream_t>(stream));
    if (rtErr == RT_ERROR_NONE) {
        *status = ACL_STREAM_STATUS_COMPLETE;
    } else if (rtErr == ACL_ERROR_RT_STREAM_NOT_COMPLETE) {
        *status = ACL_STREAM_STATUS_NOT_READY;
    } else {
        ACL_LOG_CALL_ERROR("stream query failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    return ACL_SUCCESS;
}

aclError aclrtStreamGetPriorityImpl(aclrtStream stream, uint32_t *priority)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtStreamGetPriority);
    ACL_LOG_INFO("start to execute aclrtStreamGetPriority");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(priority);
    rtStream_t rtStream = static_cast<rtStream_t>(stream);
    uint32_t prio = 0U;
    const rtError_t rtErr = rtStreamGetPriority(rtStream, &prio);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("get stream priority failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    *priority = prio;
    ACL_LOG_INFO("successfully execute aclrtStreamGetPriority, priority is %u", *priority);
    return ACL_SUCCESS;
}

aclError aclrtStreamGetFlagsImpl(aclrtStream stream, uint32_t *flags)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtStreamGetFlags);
    ACL_LOG_INFO("start to execute aclrtStreamGetFlags");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(flags);
    rtStream_t rtStream = static_cast<rtStream_t>(stream);
    uint32_t rtFlags = 0U;
    const rtError_t rtErr = rtStreamGetFlags(rtStream, &rtFlags);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("get stream flags failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    uint32_t aclFlags = 0U;
    if ((rtFlags & RT_STREAM_FAST_LAUNCH) != 0U) {
        aclFlags |= ACL_STREAM_FAST_LAUNCH;
    }
    if ((rtFlags & RT_STREAM_FAST_SYNC) != 0U) {
        aclFlags |= ACL_STREAM_FAST_SYNC;
    }
    if ((rtFlags & RT_STREAM_PERSISTENT) != 0U) {
        aclFlags |= ACL_STREAM_PERSISTENT;
    }
    if ((rtFlags & RT_STREAM_HUGE) != 0U) {
        aclFlags |= ACL_STREAM_HUGE;
    }
    if ((rtFlags & RT_STREAM_CPU_SCHEDULE) != 0U) {
        aclFlags |= ACL_STREAM_CPU_SCHEDULE;
    }
    if ((rtFlags & RT_STREAM_CP_PROCESS_USE) != 0U) {
        aclFlags |= ACL_STREAM_DEVICE_USE_ONLY;
    }
    *flags = aclFlags;
    ACL_LOG_INFO("successfully execute aclrtStreamGetFlags, rtFlags is %#x, aclFlags is %#x", rtFlags, *flags);
    return ACL_SUCCESS;
}

aclError aclrtStreamWaitEventImpl(aclrtStream stream, aclrtEvent event)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtStreamWaitEvent);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);

    const rtError_t rtErr = rtStreamWaitEvent(static_cast<rtStream_t>(stream), static_cast<rtEvent_t>(event));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("stream wait event failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    return ACL_SUCCESS;
}

aclError aclrtSetStreamFailureModeImpl(aclrtStream stream, uint64_t mode)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetStreamFailureMode);
    ACL_LOG_INFO("start to execute aclrtSetStreamFailureMode, mode is %lu", mode);
    const rtError_t rtErr = rtStreamSetMode(static_cast<rtStream_t>(stream), mode);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("rtSetStreamFailureMode failed, runtime result = %d.", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtSetStreamFailureMode, mode is %lu", mode);
    return ACL_SUCCESS;
}

aclError aclrtGetStreamOverflowSwitchImpl(aclrtStream stream, uint32_t *flag)
{
    ACL_LOG_INFO("start to execute aclrtGetStreamOverflowSwitch");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(flag);
    const rtError_t rtErr = rtGetStreamOverflowSwitch(static_cast<rtStream_t>(stream), flag);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("rtGetStreamOverflowSwitch failed, runtime result = %d.", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtGetStreamOverflowSwitch, flag is %d.", *flag);
    return ACL_SUCCESS;
}

aclError aclrtSetStreamOverflowSwitchImpl(aclrtStream stream, uint32_t flag)
{
    ACL_LOG_INFO("start to execute aclrtSetStreamOverflowSwitch, flag is %u.", flag);
    if ((flag != 0U) && ((flag != 1U))) {
        ACL_LOG_ERROR("flag must be 1 or 0, but current value is %u", flag);
        return ACL_ERROR_INVALID_PARAM;
    }
    const rtError_t rtErr = rtSetStreamOverflowSwitch(static_cast<rtStream_t>(stream), flag);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("rtSetStreamOverflowSwitch failed, runtime result = %d.", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute rtSetStreamOverflowSwitch, flag is %u.", flag);
    return ACL_SUCCESS;
}

aclError aclrtStreamAbortImpl(aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtStreamAbort);
    ACL_LOG_INFO("start to execute aclrtStreamAbort");
    const rtError_t rtErr = rtStreamAbort(stream);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("abort stream failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtStreamAbort");
    return ACL_SUCCESS;
}

aclError aclrtStreamGetIdImpl(aclrtStream stream, int32_t *streamId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtStreamGetId);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(streamId);
    const rtError_t rtErr = rtsStreamGetId(static_cast<rtStream_t>(stream), streamId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsStreamGetId failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtGetStreamAvailableNumImpl(uint32_t *streamCount)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetStreamAvailableNum);
    ACL_LOG_INFO("start to execute aclrtGetStreamAvailableNum");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(streamCount);

    const rtError_t rtErr = rtsStreamGetAvailableNum(streamCount);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsStreamGetAvailableNum failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtGetStreamAvailableNum");
    return ACL_SUCCESS;
}

aclError aclrtSetStreamAttributeImpl(aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue *value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetStreamAttribute);
    ACL_LOG_INFO("start to execute aclrtSetStreamAttribute, stmAttrType = [%u]", static_cast<uint32_t>(stmAttrType));
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(value);

    const rtError_t rtErr = rtsStreamSetAttribute(static_cast<rtStream_t>(stream),
        static_cast<rtStreamAttr>(stmAttrType),
        reinterpret_cast<rtStreamAttrValue_t*>(value)
    );
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsStreamSetAttribute failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtSetStreamAttribute");
    return ACL_SUCCESS;
}

aclError aclrtGetStreamAttributeImpl(aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue *value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetStreamAttribute);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(value);

    const rtError_t rtErr = rtsStreamGetAttribute(static_cast<rtStream_t>(stream),
        static_cast<rtStreamAttr>(stmAttrType),
        reinterpret_cast<rtStreamAttrValue_t*>(value)
    );
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsStreamGetAttribute failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    return ACL_SUCCESS;
}

aclError aclrtActiveStreamImpl(aclrtStream activeStream, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtActiveStream);
    ACL_LOG_INFO("start to execute aclrtActiveStream");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(activeStream);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);

    const rtError_t rtErr = rtsActiveStream(static_cast<rtStream_t>(activeStream), static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsActiveStream failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtActiveStream");
    return ACL_SUCCESS;
}

aclError aclrtSwitchStreamImpl(void *leftValue, aclrtCondition cond, void *rightValue, aclrtCompareDataType dataType,
    aclrtStream trueStream, aclrtStream falseStream, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSwitchStream);
    ACL_LOG_INFO("start to execute aclrtSwitchStream, cond is [%u], dataType is [%u]",
        static_cast<uint32_t>(cond), static_cast<uint32_t>(dataType));
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(leftValue);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(rightValue);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(trueStream);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);
    if (falseStream != nullptr) {
        ACL_LOG_ERROR("param falseStream must be nullptr currently.");
        return ACL_ERROR_INVALID_PARAM;
    }

    const rtError_t rtErr = rtsSwitchStream(leftValue, static_cast<rtCondition_t>(cond), rightValue,
        static_cast<rtSwitchDataType_t>(dataType), static_cast<rtStream_t>(trueStream),
        static_cast<rtStream_t>(falseStream), static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsSwitchStream failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtSwitchStream");
    return ACL_SUCCESS;
}

aclError aclrtStreamStopImpl(aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtStreamStop);
    ACL_LOG_INFO("start to execute aclrtStreamStop");

    const rtError_t rtErr = rtsStreamStop(static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsStreamStop failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtStreamStop");
    return ACL_SUCCESS;
}

aclError aclrtPersistentTaskCleanImpl(aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtPersistentTaskClean);
    ACL_LOG_INFO("start to execute aclrtPersistentTaskClean");

    const rtError_t rtErr = rtsPersistentTaskClean(static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsPersistentTaskClean failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtPersistentTaskClean");
    return ACL_SUCCESS;
}
