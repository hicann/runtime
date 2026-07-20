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
#include "runtime/event.h"
#include "runtime/rt_inner_event.h"
#include "runtime/config.h"
#include "runtime/rt_ras.h"
#include "runtime/rts/rts_event.h"
#include "runtime/rts/rts_device.h"
#include "common/log_inner.h"
#include "common/error_codes_inner.h"
#include "common/prof_reporter.h"
#include "common/resource_statistics.h"

#ifdef __cplusplus
extern "C" {
#endif

aclError aclrtCreateEventImpl(aclrtEvent* event)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCreateEvent);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_EVENT);
    ACL_LOG_INFO("start to execute aclrtCreateEvent");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);

    rtEvent_t rtEvent = nullptr;
    ACL_REQUIRES_RTS_OK(rtEventCreate(&rtEvent));

    *event = static_cast<aclrtEvent>(rtEvent);
    ACL_LOG_INFO("successfully execute aclrtCreateEvent");
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_EVENT);
    return ACL_SUCCESS;
}

aclError aclrtCreateEventWithFlagImpl(aclrtEvent* event, uint32_t flag)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCreateEventWithFlag);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_EVENT);
    ACL_LOG_INFO("start to execute aclrtCreateEventWithFlag.");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);
    rtEvent_t rtEvent = nullptr;
    ACL_REQUIRES_RTS_OK(rtEventCreateWithFlag(&rtEvent, flag));
    *event = static_cast<aclrtEvent>(rtEvent);
    ACL_LOG_INFO("successfully execute aclrtCreateEventWithFlag.");
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_EVENT);
    return ACL_SUCCESS;
}

aclError aclrtCreateEventExWithFlagImpl(aclrtEvent* event, uint32_t flag)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCreateEventExWithFlag);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_EVENT);
    ACL_LOG_INFO("start to execute aclrtCreateEventExWithFlag.");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);
    rtEvent_t rtEvent = nullptr;
    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtEventCreateExWithFlag(&rtEvent, flag), rtEventCreateExWithFlag);
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

    ACL_REQUIRES_RTS_OK(rtEventDestroy(static_cast<rtEvent_t>(event)));
    ACL_LOG_INFO("successfully execute aclrtDestroyEvent");
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_EVENT);
    return ACL_SUCCESS;
}

aclError aclrtRecordEventImpl(aclrtEvent event, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtRecordEvent);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_RECORD_RESET_EVENT);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);

    ACL_REQUIRES_RTS_OK(rtEventRecord(static_cast<rtEvent_t>(event), static_cast<rtStream_t>(stream)));
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_RECORD_RESET_EVENT);
    return ACL_SUCCESS;
}

aclError aclrtRecordEventWithFlagImpl(aclrtEvent event, aclrtStream stream, uint32_t flag)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtRecordEventWithFlag);
    ACL_LOG_INFO("start to execute aclrtRecordEventWithFlag");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);
    ACL_CHECK_INVALID_VALUE_WITH_EXPECT_RET(
        (flag == ACL_EVENT_RECORD_DEFAULT) || (flag == ACL_EVENT_RECORD_EXTERNAL), flag,
        "ACL_EVENT_RECORD_DEFAULT or ACL_EVENT_RECORD_EXTERNAL", ACL_ERROR_INVALID_PARAM);

    if (flag == ACL_EVENT_RECORD_DEFAULT) {
        return aclrtRecordEventImpl(event, stream);
    }

    ACL_REQUIRES_RTS_OK(rtEventRecordWithFlag(static_cast<rtEvent_t>(event), static_cast<rtStream_t>(stream), flag));
    return ACL_SUCCESS;
}

aclError aclrtResetEventImpl(aclrtEvent event, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtResetEvent);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_RECORD_RESET_EVENT);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);

    ACL_REQUIRES_RTS_OK(rtEventReset(static_cast<rtEvent_t>(event), static_cast<rtStream_t>(stream)));
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_RECORD_RESET_EVENT);
    return ACL_SUCCESS;
}

aclError aclrtQueryEventImpl(aclrtEvent event, aclrtEventStatus* status)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtQueryEvent);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(status);

    const rtError_t rtErr = rtEventQuery(static_cast<rtEvent_t>(event));
    if (rtErr == RT_ERROR_NONE) {
        *status = ACL_EVENT_STATUS_COMPLETE;
    } else if (rtErr == ACL_ERROR_RT_EVENT_NOT_COMPLETE) {
        *status = ACL_EVENT_STATUS_NOT_READY;
    } else {
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtQueryEventStatusImpl(aclrtEvent event, aclrtEventRecordedStatus* status)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtQueryEventStatus);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(status);

    rtEventStatus_t rtStatus = RT_EVENT_INIT;
    ACL_REQUIRES_RTS_OK(rtEventQueryStatus(static_cast<rtEvent_t>(event), &rtStatus));
    if (rtStatus == RT_EVENT_RECORDED) {
        *status = ACL_EVENT_RECORDED_STATUS_COMPLETE;
    } else {
        *status = ACL_EVENT_RECORDED_STATUS_NOT_READY;
    }
    return ACL_SUCCESS;
}

aclError aclrtQueryEventWaitStatusImpl(aclrtEvent event, aclrtEventWaitStatus* status)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtQueryEventWaitStatus);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(status);

    rtEventWaitStatus_t rtWaitStatus = EVENT_STATUS_NOT_READY;
    ACL_REQUIRES_RTS_OK(rtEventQueryWaitStatus(static_cast<rtEvent_t>(event), &rtWaitStatus));
    if (rtWaitStatus == EVENT_STATUS_COMPLETE) {
        *status = ACL_EVENT_WAIT_STATUS_COMPLETE;
    } else {
        *status = ACL_EVENT_WAIT_STATUS_NOT_READY;
    }
    return ACL_SUCCESS;
}

aclError aclrtSynchronizeEventImpl(aclrtEvent event)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSynchronizeEvent);
    ACL_LOG_INFO("start to execute aclrtSynchronizeEvent");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);

    ACL_REQUIRES_RTS_OK(rtEventSynchronize(static_cast<rtEvent_t>(event)));
    ACL_LOG_INFO("successfully execute aclrtSynchronizeEvent");
    return ACL_SUCCESS;
}

aclError aclrtSynchronizeEventWithTimeoutImpl(aclrtEvent event, int32_t timeout)
{
    ACL_LOG_INFO("start to execute aclrtSynchronizeEventWithTimeout, timeout = %dms", timeout);
    constexpr int32_t defaultTimeout = -1;
    ACL_CHECK_INVALID_VALUE_WITH_EXPECT_RET(
        timeout >= defaultTimeout, timeout, "[-1, INT_MAX]", ACL_ERROR_RT_PARAM_INVALID);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);

    const rtError_t rtErr = rtEventSynchronizeWithTimeout(static_cast<rtEvent_t>(event), timeout);
    if (rtErr == ACL_ERROR_RT_EVENT_SYNC_TIMEOUT) {
        return ACL_ERROR_RT_EVENT_SYNC_TIMEOUT;
    } else if (rtErr != RT_ERROR_NONE) {
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtSynchronizeEventWithTimeout");
    return ACL_SUCCESS;
}

aclError aclrtEventElapsedTimeImpl(float* ms, aclrtEvent startEvent, aclrtEvent endEvent)
{
    ACL_LOG_INFO("start to execute aclrtEventElapsedTime");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(ms);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(startEvent);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(endEvent);

    ACL_REQUIRES_RTS_OK(rtEventElapsedTime(ms, startEvent, endEvent));
    ACL_LOG_INFO("successfully execute aclrtEventElapsedTime");
    return ACL_SUCCESS;
}

aclError aclrtEventGetTimestampImpl(aclrtEvent event, uint64_t* timestamp)
{
    ACL_LOG_INFO("start to execute aclrtEventGetTimestamp");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(timestamp);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);

    ACL_REQUIRES_RTS_OK(rtEventGetTimeStamp(timestamp, event));

    ACL_LOG_INFO("successfully execute aclrtEventGetTimestamp");
    return ACL_SUCCESS;
}

aclError aclrtSetOpWaitTimeoutImpl(uint32_t timeout)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetOpWaitTimeout);
    ACL_LOG_INFO("start to execute aclrtSetOpWaitTimeout, timeout = %us", timeout);
    ACL_REQUIRES_RTS_OK(rtSetOpWaitTimeOut(timeout));
    ACL_LOG_INFO("successfully execute aclrtSetOpWaitTimeout, timeout = %us", timeout);
    return ACL_SUCCESS;
}

aclError aclrtSetOpExecuteTimeOutImpl(uint32_t timeout)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetOpExecuteTimeOut);
    ACL_LOG_INFO("start to execute aclrtSetOpExecuteTimeOut, timeout = %us", timeout);

    ACL_REQUIRES_RTS_OK(rtSetOpExecuteTimeOut(timeout));

    ACL_LOG_INFO("successfully execute aclrtSetOpExecuteTimeOut, timeout = %us", timeout);
    return ACL_SUCCESS;
}

aclError aclrtSetOpExecuteTimeOutWithMsImpl(uint32_t timeout)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetOpExecuteTimeOutWithMs);
    ACL_LOG_INFO("start to execute aclrtSetOpExecuteTimeOutWithMs, timeout = %ums", timeout);

    ACL_REQUIRES_RTS_OK(rtSetOpExecuteTimeOutWithMs(timeout));

    ACL_LOG_INFO("successfully execute aclrtSetOpExecuteTimeOutWithMs, timeout = %ums", timeout);
    return ACL_SUCCESS;
}

aclError aclrtSetOpExecuteTimeOutV2Impl(uint64_t timeout, uint64_t* actualTimeout)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetOpExecuteTimeOutV2);
    ACL_LOG_INFO("start to execute aclrtSetOpExecuteTimeOutV2, timeout = %zu us", timeout);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(actualTimeout);
    ACL_REQUIRES_RTS_OK(rtSetOpExecuteTimeOutV2(timeout, actualTimeout));
    ACL_LOG_INFO(
        "successfully execute aclrtSetOpExecuteTimeOutV2, timeout = %zu us, actual timeout = %zu us", timeout,
        *actualTimeout);
    return ACL_SUCCESS;
}

aclError aclrtGetOpTimeOutIntervalImpl(uint64_t* interval)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetOpTimeOutInterval);
    ACL_LOG_INFO("start to execute aclrtGetOpTimeOutIntervalImpl");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(interval);
    ACL_REQUIRES_RTS_OK(rtGetOpTimeOutInterval(interval));
    ACL_LOG_INFO("successfully execute aclrtGetOpTimeOutIntervalImpl, interval = %zu us", *interval);
    return ACL_SUCCESS;
}

aclError aclrtGetMemUceInfoImpl(int32_t deviceId, aclrtMemUceInfo* memUceInfoArray, size_t arraySize, size_t* retSize)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetMemUceInfo);
    ACL_LOG_INFO("start to execute aclrtGetMemUceInfo on device %d, arraySize %zu", deviceId, arraySize);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(memUceInfoArray);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(retSize);

    rtMemUceInfo rtUceInfo = {};
    ACL_REQUIRES_RTS_OK(rtGetMemUceInfo(deviceId, &rtUceInfo));
    if (arraySize < rtUceInfo.count) {
        ACL_LOG_ERROR(
            "Failed to execute aclrtGetMemUceInfo, because arraySize %zu is less than the required size %u.", arraySize,
            rtUceInfo.count);
        const std::string arraySizeVal = std::to_string(arraySize);
        std::string reason =
            acl::AclErrorLogManager::FormatStr("arraySize must be greater than or equal to %u", rtUceInfo.count);
        std::string funcName = acl::AclErrorLogManager::GetFuncNameWithoutImplSuffix(__func__);
        acl::AclErrorLogManager::ReportInputError(
            acl::INVALID_PARAM_REASON_MSG, std::vector<const char*>({"func", "value", "param", "reason"}),
            std::vector<const char*>({funcName.c_str(), arraySizeVal.c_str(), "arraySize", reason.c_str()}));
        return ACL_ERROR_INVALID_PARAM;
    }

    size_t realSize = std::min(rtUceInfo.count, RT_MAX_RECORD_PA_NUM_PER_DEV);
    for (size_t i = 0; i < realSize; ++i) {
        memUceInfoArray[i].addr = reinterpret_cast<void*>(rtUceInfo.repairAddr[i].ptr);
        memUceInfoArray[i].len = rtUceInfo.repairAddr[i].len;
        (void)memset_s(
            memUceInfoArray[i].reserved, sizeof(memUceInfoArray[i].reserved), 0, sizeof(memUceInfoArray[i].reserved));
    }
    *retSize = realSize;

    ACL_LOG_INFO(
        "successfully execute aclrtGetMemUceInfo on device %d, arraySize %zu, retSize %zu,", deviceId, arraySize,
        *retSize);
    return ACL_SUCCESS;
}

aclError aclrtMemUceRepairImpl(int32_t deviceId, aclrtMemUceInfo* memUceInfoArray, size_t arraySize)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemUceRepair);
    ACL_LOG_INFO("start to execute aclrtMemUceRepair on device %d, arraySize %zu", deviceId, arraySize);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(memUceInfoArray);

    ACL_CHECK_INVALID_PARAM_WITH_REASON_RET(
        arraySize > RT_MAX_RECORD_PA_NUM_PER_DEV, arraySize, "must be less than or equal to 128",
        ACL_ERROR_INVALID_PARAM);

    // reserved value check, should be fill with zero
    size_t reservedZeroValue[UCE_INFO_RESERVED_SIZE] = {0};
    for (size_t i = 0; i < arraySize; ++i) {
        if (memcmp(memUceInfoArray[i].reserved, reservedZeroValue, UCE_INFO_RESERVED_SIZE)) {
            ACL_LOG_ERROR("Failed to execute aclrtMemUceRepair with mismatched version, "
                          "pls set valid value only for ptr and len.");
            const char_t* argList[] = {"func", "param", "reason"};
            std::string funcName = acl::AclErrorLogManager::GetFuncNameWithoutImplSuffix(__func__);
            const char_t* argVal[] = {
                funcName.c_str(), "memUceInfoArray.reserved",
                "memUceInfoArray.reserved is a reserved parameter and must be 0"};
            acl::AclErrorLogManager::ReportInputErrorWithChar(acl::INVALID_PARAM_NO_VALUE_MSG, argList, argVal, 3U);
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

    ACL_REQUIRES_RTS_OK(rtMemUceRepair(deviceId, &rtUceInfo));
    return ACL_SUCCESS;
}

aclError aclrtGetEventIdImpl(aclrtEvent event, uint32_t* eventId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetEventId);
    ACL_LOG_INFO("start to execute aclrtGetEventId");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(eventId);

    ACL_REQUIRES_RTS_OK(rtsEventGetId(static_cast<rtEvent_t>(event), eventId));

    ACL_LOG_INFO("successfully execute aclrtGetEventId");
    return ACL_SUCCESS;
}

aclError aclrtGetEventAvailNumImpl(uint32_t* eventCount)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetEventAvailNum);
    ACL_LOG_INFO("start to execute aclrtGetEventAvailNum");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(eventCount);

    ACL_REQUIRES_RTS_OK(rtsEventGetAvailNum(eventCount));

    ACL_LOG_INFO("successfully execute aclrtGetEventAvailNum");
    return ACL_SUCCESS;
}

// Implementation of querying detailed information of NPU faults
aclError aclrtGetErrorVerboseImpl(int32_t deviceId, aclrtErrorInfo* errorInfo)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetErrorVerbose);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(errorInfo);

    ACL_LOG_INFO("start to execute aclrtGetErrorVerbose with deviceId %d", deviceId);

    // Type conversion adaptation
    uint32_t rtsDeviceId = static_cast<uint32_t>(deviceId);
    rtErrorInfo rtsErrorInfo = {};
    // Call RTS interface
    ACL_REQUIRES_RTS_OK(rtsGetErrorVerbose(rtsDeviceId, &rtsErrorInfo));
    aclrtMemUceInfoArray* uceInfo = &(errorInfo->detail.uceInfo);
    errorInfo->tryRepair = rtsErrorInfo.tryRepair;
    errorInfo->hasDetail = rtsErrorInfo.hasDetail;
    errorInfo->errorType = static_cast<aclrtErrorType>(rtsErrorInfo.errorType);
    errorInfo->detail.aicoreErrType = static_cast<aclrtAicoreErrorType>(rtsErrorInfo.detail.aicoreErrType);
    if ((rtsErrorInfo.hasDetail == 1U) && (rtsErrorInfo.errorType == RT_ERROR_MEMORY)) {
        uceInfo->arraySize = rtsErrorInfo.detail.uceInfo.arraySize;
        size_t realSize =
            std::min(rtsErrorInfo.detail.uceInfo.arraySize, static_cast<size_t>(ACL_RT_MEM_UCE_INFO_MAX_NUM));
        for (size_t i = 0U; i < realSize; ++i) {
            uceInfo->memUceInfoArray[i].addr =
                reinterpret_cast<void*>(rtsErrorInfo.detail.uceInfo.repairAddrArray[i].ptr);
            uceInfo->memUceInfoArray[i].len = rtsErrorInfo.detail.uceInfo.repairAddrArray[i].len;
        }
    }
    ACL_LOG_INFO("successfully execute aclrtGetErrorVerbose");
    return ACL_SUCCESS;
}

// Repair NPU malfunction implementation
aclError aclrtRepairErrorImpl(int32_t deviceId, const aclrtErrorInfo* errorInfo)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtRepairError);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(errorInfo);
    ACL_LOG_INFO("start to execute aclrtRepairError with deviceId %d and errorType %d", deviceId, errorInfo->errorType);

    // Type conversion adaptation
    uint32_t rtsDeviceId = static_cast<uint32_t>(deviceId);
    rtErrorInfo rtsErrorInfo = {};
    rtsErrorInfo.tryRepair = errorInfo->tryRepair;
    rtsErrorInfo.hasDetail = errorInfo->hasDetail;
    rtsErrorInfo.errorType = static_cast<rtErrType>(errorInfo->errorType);
    rtsErrorInfo.detail.aicoreErrType = static_cast<rtAicoreErrorType>(errorInfo->detail.aicoreErrType);
    if ((rtsErrorInfo.hasDetail == 1U) && (rtsErrorInfo.errorType == RT_ERROR_MEMORY)) {
        rtsErrorInfo.detail.uceInfo.arraySize = errorInfo->detail.uceInfo.arraySize;
        size_t realSize =
            std::min(rtsErrorInfo.detail.uceInfo.arraySize, static_cast<size_t>(RT_MAX_RECORD_PA_NUM_PER_DEV));
        for (size_t i = 0U; i < realSize; ++i) {
            rtsErrorInfo.detail.uceInfo.repairAddrArray[i].ptr =
                reinterpret_cast<uint64_t>(errorInfo->detail.uceInfo.memUceInfoArray[i].addr);
            rtsErrorInfo.detail.uceInfo.repairAddrArray[i].len = errorInfo->detail.uceInfo.memUceInfoArray[i].len;
        }
    }
    // Call RTS interface
    ACL_REQUIRES_RTS_OK(rtsRepairError(rtsDeviceId, &rtsErrorInfo));
    ACL_LOG_INFO("successfully execute aclrtRepairError");
    return ACL_SUCCESS;
}

aclError aclrtStreamWaitEventWithTimeoutImpl(aclrtStream stream, aclrtEvent event, int32_t timeout)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtStreamWaitEventWithTimeout);
    ACL_LOG_INFO("start to execute aclrtStreamWaitEventWithTimeout, timeout is %d", timeout);
    ACL_CHECK_INVALID_VALUE_WITH_EXPECT_RET(timeout >= 0, timeout, "[0, INT_MAX]", ACL_ERROR_RT_PARAM_INVALID);

    ACL_REQUIRES_RTS_OK(rtsEventWait(static_cast<rtStream_t>(stream), static_cast<rtEvent_t>(event), timeout));
    ACL_LOG_INFO("successfully execute aclrtStreamWaitEventWithTimeout");
    return ACL_SUCCESS;
}

aclError aclrtIpcGetEventHandleImpl(aclrtEvent event, aclrtIpcEventHandle* handle)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtIpcGetEventHandle);
    ACL_LOG_INFO("start to execute aclrtIpcGetEventHandle.");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(handle);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);
    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(
        rtIpcGetEventHandle(static_cast<rtEvent_t>(event), reinterpret_cast<rtIpcEventHandle_t*>(handle)),
        rtIpcGetEventHandle);
    ACL_LOG_INFO("successfully execute aclrtIpcGetEventHandle.");
    return ACL_SUCCESS;
}

aclError aclrtIpcOpenEventHandleImpl(aclrtIpcEventHandle handle, aclrtEvent* event)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtIpcOpenEventHandle);
    ACL_LOG_INFO("start to execute aclrtIpcOpenEventHandle.");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(event);
    rtEvent_t rtEvent = nullptr;
    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(
        rtIpcOpenEventHandle(*(rtIpcEventHandle_t*)&handle, &rtEvent), rtIpcOpenEventHandle);
    *event = static_cast<aclrtEvent>(rtEvent);
    ACL_LOG_INFO("successfully execute aclrtIpcOpenEventHandle.");
    return ACL_SUCCESS;
}
#ifdef __cplusplus
}
#endif
