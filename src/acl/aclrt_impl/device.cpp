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
#include "runtime/dev.h"
#include "runtime/kernel.h"
#include "runtime/config.h"
#include "runtime/rts/rts_device.h"
#include "runtime/rts/rts_stream.h"
#include "common/log_inner.h"
#include "common/error_codes_inner.h"
#include "common/prof_reporter.h"
#include "common/resource_statistics.h"

namespace {
    constexpr int32_t DEVICE_UTILIZATION_NOT_SUPPORT = -1;

    int32_t GetAllUtilizations(const int32_t deviceId, const rtTypeUtil_t utilType)
    {
        uint8_t utilRate = 0U;
        const rtError_t rtErr = rtGetAllUtilizations(deviceId, utilType, &utilRate);
        if (rtErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            ACL_LOG_WARN("rtGetAllUtilizations not to support this query, utilType = %d, runtime result = %d.",
                         static_cast<int32_t>(utilType), static_cast<int32_t>(rtErr));
            return DEVICE_UTILIZATION_NOT_SUPPORT;
        }
        if (rtErr != RT_ERROR_NONE) {
            ACL_LOG_CALL_ERROR("rtGetAllUtilizations failed, utilType = %d, runtime result = %d.",
                               static_cast<int32_t>(utilType), static_cast<int32_t>(rtErr));
            return DEVICE_UTILIZATION_NOT_SUPPORT;
        }
        ACL_LOG_INFO("successfully execute rtGetAllUtilizations, utilType = %d, utilRate = %u.",
                     static_cast<int32_t>(utilType), utilRate);
        return static_cast<int32_t>(utilRate);
    }
}

aclError aclrtSetDeviceImpl(int32_t deviceId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetDevice);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_SET_RESET_DEVICE);
    ACL_LOG_INFO("start to execute aclrtSetDevice, deviceId = %d.", deviceId);
    const rtError_t rtErr = rtSetDevice(deviceId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("open device %d failed, runtime result = %d.", deviceId, static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtSetDevice, deviceId = %d", deviceId);
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_SET_RESET_DEVICE);
    // update platform info
    const auto err = acl::UpdatePlatformInfoWithDevice(deviceId);
    if (err != ACL_SUCCESS) {
        ACL_LOG_WARN("update platform info with device failed, error code is [%d], deviceId is [%d]", err, deviceId);
    }
    return ACL_SUCCESS;
}

aclError aclrtSetDeviceWithoutTsdVXXImpl(int32_t deviceId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetDeviceWithoutTsdVXX);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_SET_RESET_DEVICE);
    ACL_LOG_INFO("start to execute aclrtSetDeviceWithoutTsdVXX, deviceId = %d.", deviceId);
    const std::string &socVersion = acl::GetSocVersion();
    if (strncmp(socVersion.c_str(), "Ascend910", (sizeof("Ascend910") - 1UL)) != 0) {
        ACL_LOG_INFO("The soc version is not Ascend910, not support");
        return ACL_ERROR_API_NOT_SUPPORT;
    }
    const rtError_t rtErr = rtSetDeviceWithoutTsd(deviceId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("open device %d failed, runtime result = %d.", deviceId, static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("open device %d successfully.", deviceId);
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_SET_RESET_DEVICE);
    return ACL_SUCCESS;
}

aclError aclrtResetDeviceImpl(int32_t deviceId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtResetDevice);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_SET_RESET_DEVICE);
    ACL_LOG_INFO("start to execute aclrtResetDevice, deviceId = %d.", deviceId);
    const rtError_t rtErr = rtDeviceReset(deviceId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("reset device %d failed, runtime result = %d.", deviceId, static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtResetDevice, reset device %d.", deviceId);
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_SET_RESET_DEVICE);
    return ACL_SUCCESS;
}

aclError aclrtResetDeviceForceImpl(int32_t deviceId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtResetDeviceForce);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_SET_RESET_DEVICE);
    ACL_LOG_INFO("start to execute aclrtResetDeviceForce, deviceId = %d.", deviceId);
    const rtError_t rtErr = rtDeviceResetForce(deviceId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("force reset device %d failed, runtime result = %d.", deviceId, static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtResetDeviceForce, reset device %d.", deviceId);
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_SET_RESET_DEVICE);
    return ACL_SUCCESS;
}

aclError aclrtResetDeviceWithoutTsdVXXImpl(int32_t deviceId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtResetDeviceWithoutTsdVXX);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_SET_RESET_DEVICE);
    ACL_LOG_INFO("start to execute aclrtResetDeviceWithoutTsdVXX, deviceId = %d.", deviceId);
    const std::string &socVersion = acl::GetSocVersion();
    if (strncmp(socVersion.c_str(), "Ascend910", (sizeof("Ascend910") - 1UL)) != 0) {
        ACL_LOG_INNER_ERROR("The soc version is not Ascend910, not support");
        return ACL_ERROR_API_NOT_SUPPORT;
    }
    const rtError_t rtErr = rtDeviceResetWithoutTsd(deviceId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("reset device %d failed, runtime result = %d.", deviceId, static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtResetDeviceWithoutTsdVXX, reset device %d", deviceId);
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_SET_RESET_DEVICE);
    return ACL_SUCCESS;
}

aclError aclrtGetDeviceImpl(int32_t *deviceId)
{
    ACL_LOG_INFO("start to execute aclrtGetDevice");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(deviceId);
    const rtError_t rtErr = rtGetDevice(deviceId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_INFO("can not get device id, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_DEBUG("successfully execute aclrtGetDevice, get device id is %d.", *deviceId);
    return ACL_SUCCESS;
}

aclError aclrtGetRunModeImpl(aclrtRunMode *runMode)
{
    ACL_LOG_INFO("start to execute aclrtGetRunMode");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(runMode);
    rtRunMode rtMode;
    const rtError_t rtErr = rtGetRunMode(&rtMode);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("get runMode failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    if (rtMode == RT_RUN_MODE_OFFLINE) {
        *runMode = ACL_DEVICE;
        return ACL_SUCCESS;
    }
    *runMode = ACL_HOST;
    ACL_LOG_INFO("successfully execute aclrtGetRunMode, current runMode is %d.", static_cast<int32_t>(*runMode));
    return ACL_SUCCESS;
}

aclError aclrtSynchronizeDeviceImpl()
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSynchronizeDevice);
    ACL_LOG_INFO("start to execute aclrtSynchronizeDevice");
    const rtError_t rtErr = rtDeviceSynchronize();
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("wait for compute device to finish failed, runtime result = %d.",
            static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("device synchronize successfully.");
    return ACL_SUCCESS;
}

aclError aclrtSynchronizeDeviceWithTimeoutImpl(int32_t timeout)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSynchronizeDeviceWithTimeout);
    ACL_LOG_INFO("start to execute aclrtSynchronizeDeviceWithTimeout, timeout %dms", timeout);
    constexpr int32_t defaultTimeout = -1;
    if (timeout < defaultTimeout) {
        ACL_LOG_CALL_ERROR("the timeout of synchronize device is invalid, timeout is %d", timeout);
        return ACL_ERROR_RT_PARAM_INVALID;
    }

    const rtError_t rtErr = rtDeviceSynchronizeWithTimeout(timeout);
    if (rtErr == ACL_ERROR_RT_STREAM_SYNC_TIMEOUT) {
        ACL_LOG_CALL_ERROR("synchronize device timeout, timeout = %dms", timeout);
        return ACL_ERROR_RT_STREAM_SYNC_TIMEOUT;
    } else if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("wait for compute device to finish failed, runtime result = %d.",
            static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("device synchronize with timeout %dms successfully.", timeout);
    return ACL_SUCCESS;
}

aclError aclrtSetTsDeviceImpl(aclrtTsId tsId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetTsDevice);
    ACL_LOG_INFO("start to execute aclrtSetTsDevice, tsId = %d.", static_cast<int32_t>(tsId));
    if ((tsId != ACL_TS_ID_AICORE) && (tsId != ACL_TS_ID_AIVECTOR)) {
        ACL_LOG_INNER_ERROR("invalid tsId, tsID is %d.", static_cast<int32_t>(tsId));
        return ACL_ERROR_INVALID_PARAM;
    }
    const rtError_t rtErr = rtSetTSDevice(static_cast<uint32_t>(tsId));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("set device ts %d failed, runtime result = %d.", static_cast<int32_t>(tsId), rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtSetTsDevice, set device ts %d", static_cast<int32_t>(tsId));
    return ACL_SUCCESS;
}

aclError aclrtGetDeviceUtilizationRateImpl(int32_t deviceId, aclrtUtilizationInfo *utilizationInfo)
{
    ACL_LOG_INFO("start to execute aclrtGetDeviceUtilizationRate, device is %d.", deviceId);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(utilizationInfo);
    aclrtUtilizationExtendInfo *utilizationExtend = utilizationInfo->utilizationExtend;
    if (utilizationExtend != nullptr) {
        ACL_LOG_ERROR("utilizationExtend is reserved parameter, current version needs to be null!");
        return ACL_ERROR_INVALID_PARAM;
    }
    utilizationInfo->cubeUtilization = GetAllUtilizations(deviceId, RT_UTIL_TYPE_AICORE);
    utilizationInfo->vectorUtilization = GetAllUtilizations(deviceId, RT_UTIL_TYPE_AIVECTOR);
    utilizationInfo->aicpuUtilization = GetAllUtilizations(deviceId, RT_UTIL_TYPE_AICPU);
    // Currently, memory is not supported
    utilizationInfo->memoryUtilization = DEVICE_UTILIZATION_NOT_SUPPORT;
    ACL_LOG_INFO("successfully execute aclrtGetDeviceUtilizationRate, device is %d.", deviceId);
    return ACL_SUCCESS;
};

aclError aclrtGetDeviceCountImpl(uint32_t *count)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetDeviceCount);
    ACL_LOG_INFO("start to execute aclrtGetDeviceCount");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(count);

    const rtError_t rtErr = rtGetDeviceCount(reinterpret_cast<int32_t *>(count));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("get device count failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtGetDeviceCount, get device count is %u.", *count);
    return ACL_SUCCESS;
}

aclError aclrtGetDeviceSatModeImpl(aclrtFloatOverflowMode *mode)
{
    ACL_LOG_INFO("start to execute aclrtGetDeviceSatMode");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(mode);
    rtFloatOverflowMode_t rtMode = RT_OVERFLOW_MODE_UNDEF;
    const rtError_t rtErr = rtGetDeviceSatMode(&rtMode);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("rtGetDeviceSatMode failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    *mode = static_cast<aclrtFloatOverflowMode>(rtMode);
    ACL_LOG_INFO("successfully execute aclrtGetDeviceSatMode, mode is %d.", *mode);
    return ACL_SUCCESS;
}

aclError aclrtSetDeviceSatModeImpl(aclrtFloatOverflowMode mode)
{
    ACL_LOG_INFO("start to execute aclrtSetDeviceSatMode, mode is %d", mode);
    const rtError_t rtErr = rtSetDeviceSatMode(static_cast<rtFloatOverflowMode_t>(mode));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("rtSetDeviceSatMode failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtSetDeviceSatMode, mode is %d", mode);
    return ACL_SUCCESS;
}

aclError aclrtGetOverflowStatusImpl(void *outputAddr, size_t outputSize, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetOverflowStatus);
    ACL_LOG_INFO("start to execute aclrtGetOverflowStatus, outputSize = %lu", outputSize);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(outputAddr);
    const rtError_t rtErr = rtGetDeviceSatStatus(outputAddr, outputSize, static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("rtGetDeviceSatStatus failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtGetOverflowStatus");
    return ACL_SUCCESS;
}

aclError aclrtResetOverflowStatusImpl(aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtResetOverflowStatus);
    ACL_LOG_INFO("start to execute aclrtResetOverflowStatus");
    const rtError_t rtErr = rtCleanDeviceSatStatus(static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("rtCleanDeviceSatStatus failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtResetOverflowStatus");
    return ACL_SUCCESS;
}

aclError aclrtQueryDeviceStatusImpl(int32_t deviceId, aclrtDeviceStatus *deviceStatus)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtQueryDeviceStatus);
    ACL_LOG_INFO("start to execute aclrtQueryDeviceStatus with device id:%d", deviceId);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(deviceStatus);
    rtDeviceStatus rtDevStatus = RT_DEVICE_STATUS_END;
    const rtError_t rtErr = rtDeviceStatusQuery(static_cast<uint32_t>(deviceId), &rtDevStatus);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_WARN("rtDeviceStatusQuery failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    *deviceStatus = static_cast<aclrtDeviceStatus>(rtDevStatus);
    ACL_LOG_INFO("successfully execute aclrtQueryDeviceStatus");
    return ACL_SUCCESS;
}

aclError aclrtDeviceTaskAbortImpl(int32_t deviceId, uint32_t timeout)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDeviceTaskAbort);
    ACL_LOG_INFO("start to execute aclrtDeviceTaskAbort on device %d, timeout %ums", deviceId, timeout);
    const rtError_t rtErr = rtDeviceTaskAbort(deviceId, timeout);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_ERROR("rtDeviceTaskAbort for device %d, failed, runtime result = %d.",
            deviceId, static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtGetDeviceInfoImpl(uint32_t deviceId, aclrtDevAttr attr, int64_t *value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetDeviceInfo);
    ACL_LOG_INFO("start to execute aclrtGetDeviceInfo");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(value);

    const rtError_t rtErr = rtsDeviceGetInfo(deviceId, static_cast<rtDevAttr>(attr), value);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsDeviceGetInfo failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtGetDeviceInfo");
    return ACL_SUCCESS;
}

aclError aclrtDeviceGetStreamPriorityRangeImpl(int32_t *leastPriority, int32_t *greatestPriority)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDeviceGetStreamPriorityRange);
    ACL_LOG_INFO("start to execute aclrtDeviceGetStreamPriorityRange");

    const rtError_t rtErr = rtsDeviceGetStreamPriorityRange(leastPriority, greatestPriority);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsDeviceGetStreamPriorityRange failed, runtime result = %d.",
            static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtDeviceGetStreamPriorityRange");
    return ACL_SUCCESS;
}

aclError aclrtGetDeviceCapabilityImpl(int32_t deviceId, aclrtDevFeatureType devFeatureType, int32_t *value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetDeviceCapability);
    ACL_LOG_INFO("start to execute aclrtGetDeviceCapability");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(value);

    const rtError_t rtErr = rtsDeviceGetCapability(deviceId, devFeatureType, value);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsDeviceGetCapability failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtGetDeviceCapability");
    return ACL_SUCCESS;
}

aclError aclrtDeviceGetUuidImpl(int32_t deviceId, aclrtUuid *uuid)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDeviceGetUuid);
    ACL_LOG_INFO("start to execute aclrtGetDeviceUuid, deviceId is [%d]", deviceId);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(uuid);

    const rtError_t rtErr = rtGetDeviceUuid(deviceId, reinterpret_cast<rtUuid_t*>(uuid));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("get device uuid failed, deviceId = %d, runtime result = %d", 
                          deviceId, static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtGetDeviceUuid");
    return ACL_SUCCESS;
}

aclError aclrtGetDeviceResLimitImpl(int32_t deviceId, aclrtDevResLimitType type, uint32_t *value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetDeviceResLimit);
    ACL_LOG_INFO("start to execute aclrtGetDeviceResLimit, deviceId is [%d], type is [%u]", deviceId,
        static_cast<uint32_t>(type));
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(value);

    const rtError_t rtErr = rtsGetDeviceResLimit(deviceId, static_cast<rtDevResLimitType_t>(type), value);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsGetDeviceResLimit failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtGetDeviceResLimit");
    return ACL_SUCCESS;
}

aclError aclrtSetDeviceResLimitImpl(int32_t deviceId, aclrtDevResLimitType type, uint32_t value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetDeviceResLimit);
    ACL_LOG_INFO("start to execute aclrtSetDeviceResLimit, deviceId is [%d], type is [%u], value is [%u]", deviceId,
        static_cast<uint32_t>(type), value);

    const rtError_t rtErr = rtsSetDeviceResLimit(deviceId, static_cast<rtDevResLimitType_t>(type), value);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsSetDeviceResLimit failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtSetDeviceResLimit");
    return ACL_SUCCESS;
}

aclError aclrtResetDeviceResLimitImpl(int32_t deviceId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtResetDeviceResLimit);
    ACL_LOG_INFO("start to execute aclrtResetDeviceResLimit, deviceId is [%d]", deviceId);

    const rtError_t rtErr = rtsResetDeviceResLimit(deviceId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsResetDeviceResLimit failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtResetDeviceResLimit");
    return ACL_SUCCESS;
}

aclError aclrtGetStreamResLimitImpl(aclrtStream stream, aclrtDevResLimitType type, uint32_t *value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetStreamResLimit);
    ACL_LOG_INFO("start to execute aclrtGetStreamResLimit, type is [%u]", static_cast<uint32_t>(type));
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(value);
    const rtError_t rtErr = rtsGetStreamResLimit(static_cast<rtStream_t>(stream), static_cast<rtDevResLimitType_t>(type), value);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsGetStreamResLimit failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtGetStreamResLimit, value is [%u]", *value);
    return ACL_SUCCESS;
}

aclError aclrtSetStreamResLimitImpl(aclrtStream stream, aclrtDevResLimitType type, uint32_t value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetStreamResLimit);
    ACL_LOG_INFO("start to execute aclrtSetStreamResLimit, type is [%u], value is [%u]", static_cast<uint32_t>(type), value);
    const rtError_t rtErr = rtsSetStreamResLimit(static_cast<rtStream_t>(stream), static_cast<rtDevResLimitType_t>(type), value);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsSetStreamResLimit failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtSetStreamResLimit");
    return ACL_SUCCESS;
}

aclError aclrtResetStreamResLimitImpl(aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtResetStreamResLimit);
    ACL_LOG_INFO("start to execute aclrtResetStreamResLimit");
    const rtError_t rtErr = rtsResetStreamResLimit(static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsResetStreamResLimit failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtResetStreamResLimit");
    return ACL_SUCCESS;
}

aclError aclrtUseStreamResInCurrentThreadImpl(aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtUseStreamResInCurrentThread);
    ACL_LOG_INFO("start to execute aclrtUseStreamResInCurrentThread");
    const rtError_t rtErr = rtsUseStreamResInCurrentThread(static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsUseStreamResInCurrentThread failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtUseStreamResInCurrentThread");
    return ACL_SUCCESS;
}

aclError aclrtUnuseStreamResInCurrentThreadImpl(aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtUnuseStreamResInCurrentThread);
    ACL_LOG_INFO("start to execute aclrtUnuseStreamResInCurrentThread");
    const rtError_t rtErr = rtsNotUseStreamResInCurrentThread(static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsNotUseStreamResInCurrentThread failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtUnuseStreamResInCurrentThread");
    return ACL_SUCCESS;
}

aclError aclrtGetResInCurrentThreadImpl(aclrtDevResLimitType type, uint32_t *value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetResInCurrentThread);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(value);
    const rtError_t rtErr = rtsGetResInCurrentThread(static_cast<rtDevResLimitType_t>(type), value);
    if (rtErr != RT_ERROR_NONE) {

        ACL_LOG_CALL_ERROR("call rtsGetResInCurrentThread failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    return ACL_SUCCESS;
}

aclError aclrtGetDevicesTopoImpl(uint32_t deviceId, uint32_t otherDeviceId, uint64_t *value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetDevicesTopo);
    ACL_LOG_INFO("start to execute aclrtGetDevicesTopo, deviceId is [%u], otherDeviceId is [%u]",
        deviceId, otherDeviceId);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(value);

    const rtError_t rtErr = rtsGetPairDevicesInfo(deviceId, otherDeviceId,
        static_cast<int32_t>(RT_DEVS_INFO_TYPE_TOPOLOGY), value);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsGetPairDevicesInfo failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtGetDevicesTopo");
    return ACL_SUCCESS;
}

aclError aclrtGetLogicDevIdByUserDevIdImpl(const int32_t userDevid, int32_t *const logicDevId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetLogicDevIdByUserDevId);
    ACL_LOG_INFO("start to execute aclrtGetLogicDevIdByUserDevId, userDevid is [%d]", userDevid);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(logicDevId);
    const rtError_t rtErr = rtsGetLogicDevIdByUserDevId(userDevid, logicDevId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsGetGetLogicDevIdByUserDevId failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtGetLogicDevIdByUserDevId");
    return ACL_SUCCESS;
}

aclError aclrtGetUserDevIdByLogicDevIdImpl(const int32_t logicDevId, int32_t *const userDevid)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetUserDevIdByLogicDevId);
    ACL_LOG_INFO("start to execute aclrtGetUserDevIdByLogicDevId, logicDevId is [%d]", logicDevId);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(userDevid);
    const rtError_t rtErr = rtsGetUserDevIdByLogicDevId(logicDevId, userDevid);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsGetUserDevIdByLogicDevId failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtGetUserDevIdByLogicDevId");
    return ACL_SUCCESS;
}

aclError aclrtGetLogicDevIdByPhyDevIdImpl(int32_t phyDevId, int32_t *const logicDevId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetLogicDevIdByPhyDevId);
    ACL_LOG_INFO("start to execute aclrtGetLogicDevIdByPhyDevId, phyDevId is [%d]", phyDevId);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(logicDevId);
    const rtError_t rtErr = rtsGetLogicDevIdByPhyDevId(phyDevId, logicDevId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsGetLogicDevIdByPhyDevId failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtGetLogicDevIdByPhyDevId");
    return ACL_SUCCESS;
}

aclError aclrtGetPhyDevIdByLogicDevIdImpl(int32_t logicDevId, int32_t *const phyDevId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetPhyDevIdByLogicDevId);
    ACL_LOG_INFO("start to execute aclrtGetPhyDevIdByLogicDevId, logicDevId is [%d]", logicDevId);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(phyDevId);
    const rtError_t rtErr = rtsGetPhyDevIdByLogicDevId(logicDevId, phyDevId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsGetPhyDevIdByLogicDevId failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtGetPhyDevIdByLogicDevId");
    return ACL_SUCCESS;
}

aclError aclrtGetOpExecuteTimeoutImpl(uint32_t *const timeoutMs)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetOpExecuteTimeout);
    ACL_LOG_INFO("start to execute aclrtGetOpExecuteTimeout");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(timeoutMs);
    const rtError_t rtErr = rtGetOpExecuteTimeoutV2(timeoutMs);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtGetOpExecuteTimeoutV2 failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtGetOpExecuteTimeout");
    return ACL_SUCCESS;
}

aclError aclrtCheckArchCompatibilityImpl(const char *socVersion, int32_t *canCompatible)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCheckArchCompatibility);
    ACL_LOG_INFO("start to execute aclrtCheckArchCompatibility");
    const rtError_t rtErr = rtCheckArchCompatibility(socVersion, canCompatible);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR(
            "call aclrtCheckArchCompatibility failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtCheckArchCompatibility");
    return ACL_SUCCESS;
}