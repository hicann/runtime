/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "acl/acl_rt_impl.h"
#include "runtime/event.h"
#include "runtime/config.h"
#include "runtime/rt_ras.h"
#include "runtime/rts/rts_event.h"
#include "runtime/rts/rts_device.h"
#include "common/log_inner.h"
#include "common/error_codes_inner.h"
#include "common/prof_reporter.h"
#include "common/resource_statistics.h"

aclError aclrtCreateEventImpl(aclrtEvent *event)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCreateEvent);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_EVENT);
    ACL_LOG_INFO("start to execute aclrtCreateEvent");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);

    rtEvent_t rtEvent = nullptr;
    const rtError_t rtErr = rtEventCreate(&rtEvent);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("create event failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    *event = static_cast<aclrtEvent>(rtEvent);
    ACL_LOG_INFO("successfully execute aclrtCreateEvent");
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_EVENT);
    return ACL_SUCCESS;
}

aclError aclrtCreateEventWithFlagImpl(aclrtEvent *event, uint32_t flag)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCreateEventWithFlag);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_EVENT);
    ACL_LOG_INFO("start to execute aclrtCreateEventWithFlag.");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);
    rtEvent_t rtEvent = nullptr;
    const rtError_t rtErr = rtEventCreateWithFlag(&rtEvent, flag);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("create event flag failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    *event = static_cast<aclrtEvent>(rtEvent);
    ACL_LOG_INFO("successfully execute aclrtCreateEventWithFlag.");
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_EVENT);
    return ACL_SUCCESS;
}

aclError aclrtCreateEventExWithFlagImpl(aclrtEvent *event, uint32_t flag)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCreateEventExWithFlag);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_EVENT);
    ACL_LOG_INFO("start to execute aclrtCreateEventExWithFlag.");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);
    rtEvent_t rtEvent = nullptr;
    const rtError_t rtErr = rtEventCreateExWithFlag(&rtEvent, flag);
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            ACL_LOG_WARN("rtEventCreateExWithFlag unsupport, runtime result = %d", static_cast<int32_t>(rtErr));
        } else {
            ACL_LOG_CALL_ERROR("create event ex with flag failed, runtime result = %d", static_cast<int32_t>(rtErr));
        }
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    *event = static_cast<aclrtEvent>(rtEvent);
    ACL_LOG_INFO("successfully execute aclrtCreateEventExWithFlag.");
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_EVENT);
    return ACL_SUCCESS;
}

aclError aclrtDestroyEventImpl(aclrtEvent event)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDestroyEvent);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_EVENT);
    ACL_LOG_INFO("start to execute aclrtDestroyEvent");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);

    const rtError_t rtErr = rtEventDestroy(static_cast<rtEvent_t>(event));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("destroy event failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtDestroyEvent");
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_EVENT);
    return ACL_SUCCESS;
}

aclError aclrtRecordEventImpl(aclrtEvent event, aclrtStream stream)
{
     ACL_PROFILING_REG(acl::AclProfType::AclrtRecordEvent);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_RECORD_RESET_EVENT);
    ACL_LOG_INFO("start to execute aclrtRecordEvent");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);

    const rtError_t rtErr = rtEventRecord(static_cast<rtEvent_t>(event), static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("record event failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtRecordEvent");
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_RECORD_RESET_EVENT);
    return ACL_SUCCESS;
}

aclError aclrtResetEventImpl(aclrtEvent event, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtResetEvent);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_RECORD_RESET_EVENT);
    ACL_LOG_INFO("start to execute aclrtResetEvent");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);

    const rtError_t rtErr = rtEventReset(static_cast<rtEvent_t>(event), static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("reset event failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("reset event successfully.");
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_RECORD_RESET_EVENT);
    return ACL_SUCCESS;
}

aclError aclrtQueryEventImpl(aclrtEvent event, aclrtEventStatus *status)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtQueryEvent);
    ACL_LOG_INFO("start to execute aclrtQueryEvent");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(status);

    const rtError_t rtErr = rtEventQuery(static_cast<rtEvent_t>(event));
    if (rtErr == RT_ERROR_NONE) {
        *status = ACL_EVENT_STATUS_COMPLETE;
    } else if (rtErr == ACL_ERROR_RT_EVENT_NOT_COMPLETE) {
        *status = ACL_EVENT_STATUS_NOT_READY;
    } else {
        ACL_LOG_INNER_ERROR("query event status failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtQueryEvent");
    return ACL_SUCCESS;
}

aclError aclrtQueryEventStatusImpl(aclrtEvent event, aclrtEventRecordedStatus *status)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtQueryEventStatus);
    ACL_LOG_INFO("start to execute aclrtQueryEventStatus");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(status);

    rtEventStatus_t rtStatus = RT_EVENT_INIT;
    const rtError_t rtErr = rtEventQueryStatus(static_cast<rtEvent_t>(event), &rtStatus);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("[Query][Status]query event recorded status failed, runtime result = %d",
            static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    if (rtStatus == RT_EVENT_RECORDED) {
        *status = ACL_EVENT_RECORDED_STATUS_COMPLETE;
    } else {
        *status = ACL_EVENT_RECORDED_STATUS_NOT_READY;
    }
    ACL_LOG_INFO("successfully execute aclrtQueryEventStatus");
    return ACL_SUCCESS;
}

aclError aclrtQueryEventWaitStatusImpl(aclrtEvent event, aclrtEventWaitStatus *status)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtQueryEventWaitStatus);
    ACL_LOG_INFO("start to execute aclrtQueryEventWaitStatus");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(status);

    rtEventWaitStatus_t rtWaitStatus = EVENT_STATUS_NOT_READY;
    const rtError_t rtErr = rtEventQueryWaitStatus(static_cast<rtEvent_t>(event), &rtWaitStatus);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("[Query][Status]query event wait-status failed, runtime result = %d",
            static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    if (rtWaitStatus == EVENT_STATUS_COMPLETE) {
        *status = ACL_EVENT_WAIT_STATUS_COMPLETE;
    } else {
        *status = ACL_EVENT_WAIT_STATUS_NOT_READY;
    }
    ACL_LOG_INFO("successfully execute aclrtQueryEventWaitStatus");
    return ACL_SUCCESS;
}

aclError aclrtSynchronizeEventImpl(aclrtEvent event)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSynchronizeEvent);
    ACL_LOG_INFO("start to execute aclrtSynchronizeEvent");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);

    const rtError_t rtErr = rtEventSynchronize(static_cast<rtEvent_t>(event));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("wait event to be complete failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtSynchronizeEvent");
    return ACL_SUCCESS;
}

aclError aclrtSynchronizeEventWithTimeoutImpl(aclrtEvent event, int32_t timeout)
{
    ACL_LOG_INFO("start to execute aclrtSynchronizeEventWithTimeout, timeout = %dms", timeout);
    constexpr int32_t default_timeout = -1;
    if (timeout < default_timeout) {
        ACL_LOG_CALL_ERROR("the timeout of synchronize event is invalid");
        return ACL_ERROR_RT_PARAM_INVALID;
    }
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);

    const rtError_t rtErr = rtEventSynchronizeWithTimeout(static_cast<rtEvent_t>(event), timeout);
    if (rtErr == ACL_ERROR_RT_EVENT_SYNC_TIMEOUT) {
        ACL_LOG_CALL_ERROR("synchronize event timeout, timeout = %dms", timeout);
        return ACL_ERROR_RT_EVENT_SYNC_TIMEOUT;
    } else if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("wait event to be complete failed, runtime result = %dms", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtSynchronizeEventWithTimeout");
    return ACL_SUCCESS;
}

aclError aclrtEventElapsedTimeImpl(float *ms, aclrtEvent startEvent, aclrtEvent endEvent)
{
    ACL_LOG_INFO("start to execute aclrtEventElapsedTime");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(ms);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(startEvent);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(endEvent);

    const rtError_t rtErr = rtEventElapsedTime(ms, startEvent, endEvent);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("computes events elapsed time failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtEventElapsedTime");
    return ACL_SUCCESS;
}

aclError aclrtEventGetTimestampImpl(aclrtEvent event, uint64_t *timestamp)
{
    ACL_LOG_INFO("start to execute aclrtEventGetTimestamp");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(timestamp);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);

    ACL_REQUIRES_CALL_RTS_OK(rtEventGetTimeStamp(timestamp, event), rtEventGetTimeStamp);

    ACL_LOG_INFO("successfully execute aclrtEventGetTimestamp");
    return ACL_SUCCESS;
}

aclError aclrtSetOpWaitTimeoutImpl(uint32_t timeout)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetOpWaitTimeout);
    ACL_LOG_INFO("start to execute aclrtSetOpWaitTimeout, timeout = %us", timeout);
    ACL_REQUIRES_CALL_RTS_OK(rtSetOpWaitTimeOut(timeout), rtSetOpWaitTimeOut);
    ACL_LOG_INFO("successfully execute aclrtSetOpWaitTimeout, timeout = %us", timeout);
    return ACL_SUCCESS;
}

aclError aclrtSetOpExecuteTimeOutImpl(uint32_t timeout)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetOpExecuteTimeOut);
    ACL_LOG_INFO("start to execute aclrtSetOpExecuteTimeOut, timeout = %us", timeout);

    const rtError_t rtErr = rtSetOpExecuteTimeOut(timeout);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("set op execute timeout failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtSetOpExecuteTimeOut, timeout = %us", timeout);
    return ACL_SUCCESS;
}

aclError aclrtSetOpExecuteTimeOutWithMsImpl(uint32_t timeout)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetOpExecuteTimeOutWithMs);
    ACL_LOG_INFO("start to execute aclrtSetOpExecuteTimeOutWithMs, timeout = %ums", timeout);

    const rtError_t rtErr = rtSetOpExecuteTimeOutWithMs(timeout);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("set op execute timeout failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtSetOpExecuteTimeOutWithMs, timeout = %ums", timeout);
    return ACL_SUCCESS;
}

aclError aclrtSetOpExecuteTimeOutV2Impl(uint64_t timeout, uint64_t *actualTimeout)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetOpExecuteTimeOutV2);
    ACL_LOG_INFO("start to execute aclrtSetOpExecuteTimeOutV2, timeout = %zu us", timeout);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(actualTimeout);
    ACL_REQUIRES_CALL_RTS_OK(rtSetOpExecuteTimeOutV2(timeout, actualTimeout), rtSetOpExecuteTimeOutV2);
    ACL_LOG_INFO("successfully execute aclrtSetOpExecuteTimeOutV2, timeout = %zu us, actual timeout = %zu us", timeout,
                 *actualTimeout);
    return ACL_SUCCESS;
}

aclError aclrtGetOpTimeOutIntervalImpl(uint64_t *interval)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetOpTimeOutInterval);
    ACL_LOG_INFO("start to execute aclrtGetOpTimeOutIntervalImpl");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(interval);
    ACL_REQUIRES_CALL_RTS_OK(rtGetOpTimeOutInterval(interval), rtGetOpTimeOutInterval);
    ACL_LOG_INFO("successfully execute aclrtGetOpTimeOutIntervalImpl, interval = %zu us", *interval);
    return ACL_SUCCESS;
}

aclError aclrtGetMemUceInfoImpl(int32_t deviceId, aclrtMemUceInfo *memUceInfoArray,
                                size_t arraySize, size_t *retSize)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetMemUceInfo);
    ACL_LOG_INFO("start to execute aclrtGetMemUceInfo on device %d, arraySize %zu", deviceId, arraySize);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(memUceInfoArray);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(retSize);

    rtMemUceInfo rtUceInfo = {};
    ACL_REQUIRES_CALL_RTS_OK(rtGetMemUceInfo(deviceId, &rtUceInfo), rtGetMemUceInfo);
    if (arraySize < rtUceInfo.count) {
        ACL_LOG_ERROR("failed to execute aclrtGetMemUceInfo, because arraySize %zu is less than the required size %u",
                      arraySize, rtUceInfo.count);
        return ACL_ERROR_INVALID_PARAM;
    }

    size_t realSize = std::min(rtUceInfo.count, RT_MAX_RECORD_PA_NUM_PER_DEV);
    for (size_t i = 0; i < realSize; ++i) {
        memUceInfoArray[i].addr = reinterpret_cast<void *>(rtUceInfo.repairAddr[i].ptr);
        memUceInfoArray[i].len = rtUceInfo.repairAddr[i].len;
        (void)memset_s(memUceInfoArray[i].reserved, sizeof(memUceInfoArray[i].reserved),
                       0, sizeof(memUceInfoArray[i].reserved));
    }
    *retSize = realSize;

    ACL_LOG_INFO("successfully execute aclrtGetMemUceInfo on device %d, arraySize %zu, retSize %zu,",
                 deviceId, arraySize, *retSize);
    return ACL_SUCCESS;
}

aclError aclrtMemUceRepairImpl(int32_t deviceId, aclrtMemUceInfo *memUceInfoArray, size_t arraySize)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemUceRepair);
    ACL_LOG_INFO("start to execute aclrtMemUceRepair on device %d, arraySize %zu", deviceId, arraySize);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(memUceInfoArray);

    if (arraySize > RT_MAX_RECORD_PA_NUM_PER_DEV) {
        ACL_LOG_ERROR("failed to execute aclrtMemUceRepair, because arraySize %zu is exceed max size %d",
                      arraySize, RT_MAX_RECORD_PA_NUM_PER_DEV);
        return ACL_ERROR_INVALID_PARAM;
    }

    //reserved value check, should be fill with zero
    size_t reservedZeroValue[UCE_INFO_RESERVED_SIZE] = {0};
    for (size_t i = 0; i < arraySize; ++i) {
        if (memcmp(memUceInfoArray[i].reserved, reservedZeroValue, UCE_INFO_RESERVED_SIZE)) {
            ACL_LOG_ERROR("failed to execute aclrtMemUceRepair with mismatched version, "
                          "pls set valid value only for ptr and len ");
            return ACL_ERROR_INVALID_PARAM;
        }
    }

    rtMemUceInfo rtUceInfo = {};
    rtUceInfo.devid = deviceId;
    rtUceInfo.count = arraySize;
    for (size_t i = 0; i < arraySize; ++i) {
        rtUceInfo.repairAddr[i].ptr = reinterpret_cast<uint64_t>(memUceInfoArray[i].addr);
        rtUceInfo.repairAddr[i].len = memUceInfoArray[i].len;
    }

    const rtError_t rtErr = rtMemUceRepair(deviceId, &rtUceInfo);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("rtMemUceRepair failed, device id is runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtGetEventIdImpl(aclrtEvent event, uint32_t *eventId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetEventId);
    ACL_LOG_INFO("start to execute aclrtGetEventId");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(eventId);

    const rtError_t rtErr = rtsEventGetId(static_cast<rtEvent_t>(event), eventId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsEventGetId failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtGetEventId");
    return ACL_SUCCESS;
}

aclError aclrtGetEventAvailNumImpl(uint32_t *eventCount)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetEventAvailNum);
    ACL_LOG_INFO("start to execute aclrtGetEventAvailNum");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(eventCount);

    const rtError_t rtErr = rtsEventGetAvailNum(eventCount);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsEventGetAvailNum failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtGetEventAvailNum");
    return ACL_SUCCESS;
}

// Implementation of querying detailed information of NPU faults
aclError aclrtGetErrorVerboseImpl(int32_t deviceId, aclrtErrorInfo *errorInfo)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetErrorVerbose);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(errorInfo);

    ACL_LOG_INFO("start to execute aclrtGetErrorVerbose with deviceId %d", deviceId);

    // Type conversion adaptation
    uint32_t rtsDeviceId = static_cast<uint32_t>(deviceId);
    rtErrorInfo *rtsErrorInfo = reinterpret_cast<rtErrorInfo*>(errorInfo);

    // Call RTS interface
    ACL_REQUIRES_CALL_RTS_OK(rtsGetErrorVerbose(rtsDeviceId, rtsErrorInfo), rtsGetErrorVerbose);
    ACL_LOG_INFO("successfully execute aclrtGetErrorVerbose");
    return ACL_SUCCESS;
}

// Repair NPU malfunction implementation
aclError aclrtRepairErrorImpl(int32_t deviceId, const aclrtErrorInfo *errorInfo)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtRepairError);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(errorInfo);
    ACL_LOG_INFO("start to execute aclrtRepairError with deviceId %d and errorType %d", deviceId, errorInfo->errorType);

    // Type conversion adaptation
    uint32_t rtsDeviceId = static_cast<uint32_t>(deviceId);
    const rtErrorInfo *rtsErrorInfo = reinterpret_cast<const rtErrorInfo*>(errorInfo);

    // Call RTS interface
    ACL_REQUIRES_CALL_RTS_OK(rtsRepairError(rtsDeviceId, rtsErrorInfo), rtsRepairError);
    ACL_LOG_INFO("successfully execute aclrtRepairError");
    return ACL_SUCCESS;
}

aclError aclrtStreamWaitEventWithTimeoutImpl(aclrtStream stream, aclrtEvent event, int32_t timeout)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtStreamWaitEventWithTimeout);
    ACL_LOG_INFO("start to execute aclrtStreamWaitEventWithTimeout, timeout is %d", timeout);
    if (timeout <= 0) {
        ACL_LOG_CALL_ERROR("the range of timeout is invalid");
        return ACL_ERROR_RT_PARAM_INVALID;
    }

    const rtError_t rtErr = rtsEventWait(static_cast<rtStream_t>(stream), static_cast<rtEvent_t>(event), timeout);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call aclrtStreamWaitEventWithTimeout failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtStreamWaitEventWithTimeout");
    return ACL_SUCCESS;
}

aclError aclrtIpcGetEventHandleImpl(aclrtEvent event, aclrtIpcEventHandle *handle)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtIpcGetEventHandle);
    ACL_LOG_INFO("start to execute aclrtIpcGetEventHandle.");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(handle);
    const rtError_t rtErr = rtIpcGetEventHandle(static_cast<rtEvent_t>(event), reinterpret_cast<rtIpcEventHandle_t*>(handle));
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            ACL_LOG_WARN("rtIpcGetEventHandle unsupport, runtime result = %d", static_cast<int32_t>(rtErr));
        } else {
            ACL_LOG_CALL_ERROR("call rtIpcGetEventHandle Failed, runtime result = %d", static_cast<int32_t>(rtErr));
        }
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtIpcGetEventHandle.");
    return ACL_SUCCESS;
}

aclError aclrtIpcOpenEventHandleImpl(aclrtIpcEventHandle handle, aclrtEvent *event)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtIpcOpenEventHandle);
    ACL_LOG_INFO("start to execute aclrtIpcOpenEventHandle.");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);
    rtEvent_t rtEvent = nullptr;
    const rtError_t rtErr = rtIpcOpenEventHandle(*(rtIpcEventHandle_t*)&handle, &rtEvent);
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            ACL_LOG_WARN("rtIpcOpenEventHandle unsupport, runtime result = %d", static_cast<int32_t>(rtErr));
        } else {
            ACL_LOG_CALL_ERROR("call rtIpcOpenEventHandle Failed, runtime result = %d", static_cast<int32_t>(rtErr));
        }
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    *event = static_cast<aclrtEvent>(rtEvent);
    ACL_LOG_INFO("successfully execute aclrtIpcOpenEventHandle.");
    return ACL_SUCCESS;
}
