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
#include "runtime/rt_inner_device.h"
#include "utils/data_type_utils.h"

namespace {
constexpr int32_t DEVICE_UTILIZATION_NOT_SUPPORT = -1;

int32_t GetAllUtilizations(const int32_t deviceId, const rtTypeUtil_t utilType)
{
    uint8_t utilRate = 0U;
    const rtError_t rtErr = rtGetAllUtilizations(deviceId, utilType, &utilRate);
    if (rtErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
        ACL_LOG_WARN(
            "rtGetAllUtilizations not to support this query, utilType = %d, runtime result = %d.",
            static_cast<int32_t>(utilType), static_cast<int32_t>(rtErr));
        return DEVICE_UTILIZATION_NOT_SUPPORT;
    }
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR(
            "rtGetAllUtilizations failed, utilType = %d, runtime result = %d.", static_cast<int32_t>(utilType),
            static_cast<int32_t>(rtErr));
        return DEVICE_UTILIZATION_NOT_SUPPORT;
    }
    ACL_LOG_INFO(
        "successfully execute rtGetAllUtilizations, utilType = %d, utilRate = %u.", static_cast<int32_t>(utilType),
        utilRate);
    return static_cast<int32_t>(utilRate);
}
} // namespace

#ifdef __cplusplus
extern "C" {
#endif

aclError aclrtSetDeviceImpl(int32_t deviceId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetDevice);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_SET_RESET_DEVICE);
    ACL_LOG_INFO("start to execute aclrtSetDevice, deviceId = %d.", deviceId);
    ACL_REQUIRES_RTS_OK(rtSetDevice(deviceId));
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
    const std::string& socVersion = acl::GetSocVersion();
    if (strncmp(socVersion.c_str(), "Ascend910", (sizeof("Ascend910") - 1UL)) != 0) {
        ACL_LOG_INFO("The soc version is not Ascend910, which is not supported");
        acl::AclErrorLogManager::ReportInputError(
            acl::UNSUPPORTED_SYSTEM_MSG, {"func"},
            {"aclrtSetDeviceWithoutTsdVXX, only Ascend 910 chips are supported"});
        return ACL_ERROR_API_NOT_SUPPORT;
    }
    ACL_REQUIRES_RTS_OK(rtSetDeviceWithoutTsd(deviceId));
    ACL_LOG_INFO("open device %d successfully.", deviceId);
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_SET_RESET_DEVICE);
    return ACL_SUCCESS;
}

aclError aclrtResetDeviceImpl(int32_t deviceId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtResetDevice);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_SET_RESET_DEVICE);
    ACL_LOG_INFO("start to execute aclrtResetDevice, deviceId = %d.", deviceId);
    ACL_REQUIRES_RTS_OK(rtDeviceReset(deviceId));
    ACL_LOG_INFO("successfully execute aclrtResetDevice, reset device %d.", deviceId);
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_SET_RESET_DEVICE);
    return ACL_SUCCESS;
}

aclError aclrtResetDeviceForceImpl(int32_t deviceId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtResetDeviceForce);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_SET_RESET_DEVICE);
    ACL_LOG_INFO("start to execute aclrtResetDeviceForce, deviceId = %d.", deviceId);
    ACL_REQUIRES_RTS_OK(rtDeviceResetForce(deviceId));
    ACL_LOG_INFO("successfully execute aclrtResetDeviceForce, reset device %d.", deviceId);
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_SET_RESET_DEVICE);
    return ACL_SUCCESS;
}

aclError aclrtResetDeviceWithoutTsdVXXImpl(int32_t deviceId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtResetDeviceWithoutTsdVXX);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_SET_RESET_DEVICE);
    ACL_LOG_INFO("start to execute aclrtResetDeviceWithoutTsdVXX, deviceId = %d.", deviceId);
    const std::string& socVersion = acl::GetSocVersion();
    if (strncmp(socVersion.c_str(), "Ascend910", (sizeof("Ascend910") - 1UL)) != 0) {
        ACL_LOG_ERROR("The soc version is not Ascend910, which is not supported");
        acl::AclErrorLogManager::ReportInputError(
            acl::UNSUPPORTED_SYSTEM_MSG, {"func"},
            {"aclrtResetDeviceWithoutTsdVXX, only Ascend 910 chips are supported"});
        return ACL_ERROR_API_NOT_SUPPORT;
    }
    ACL_REQUIRES_RTS_OK(rtDeviceResetWithoutTsd(deviceId));
    ACL_LOG_INFO("successfully execute aclrtResetDeviceWithoutTsdVXX, reset device %d", deviceId);
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_SET_RESET_DEVICE);
    return ACL_SUCCESS;
}

aclError aclrtGetDeviceImpl(int32_t* deviceId)
{
    ACL_LOG_INFO("start to execute aclrtGetDevice");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(deviceId);
    const rtError_t rtErr = rtGetDevice(deviceId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_INFO("Cannot get device id, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_DEBUG("successfully execute aclrtGetDevice, get device id is %d.", *deviceId);
    return ACL_SUCCESS;
}

aclError aclrtGetRunModeImpl(aclrtRunMode* runMode)
{
    ACL_LOG_INFO("start to execute aclrtGetRunMode");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(runMode);
    rtRunMode rtMode;
    ACL_REQUIRES_RTS_OK(rtGetRunMode(&rtMode));
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
    ACL_REQUIRES_RTS_OK(rtDeviceSynchronize());
    ACL_LOG_INFO("device synchronize successfully.");
    return ACL_SUCCESS;
}

aclError aclrtSynchronizeDeviceWithTimeoutImpl(int32_t timeout)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSynchronizeDeviceWithTimeout);
    ACL_LOG_INFO("start to execute aclrtSynchronizeDeviceWithTimeout, timeout %dms", timeout);
    constexpr int32_t defaultTimeout = -1;
    ACL_CHECK_INVALID_VALUE_WITH_EXPECT_RET(
        timeout >= defaultTimeout, timeout, "[-1, INT_MAX]", ACL_ERROR_RT_PARAM_INVALID);

    const rtError_t rtErr = rtDeviceSynchronizeWithTimeout(timeout);
    if (rtErr == ACL_ERROR_RT_STREAM_SYNC_TIMEOUT) {
        return ACL_ERROR_RT_STREAM_SYNC_TIMEOUT;
    } else if (rtErr != RT_ERROR_NONE) {
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
        std::string funcName = acl::AclErrorLogManager::GetFuncNameWithoutImplSuffix(__func__);
        acl::AclErrorLogManager::ReportInputError(
            acl::INVALID_VALUE_MSG, std::vector<const char*>({"func", "value", "param", "expect"}),
            std::vector<const char*>(
                {funcName.c_str(), acl::GetTsIdDesc(tsId), "tsId", "ACL_TS_ID_AICORE or ACL_TS_ID_AIVECTOR"}));
        return ACL_ERROR_INVALID_PARAM;
    }
    ACL_REQUIRES_RTS_OK(rtSetTSDevice(static_cast<uint32_t>(tsId)));
    ACL_LOG_INFO("successfully execute aclrtSetTsDevice, set device ts %d", static_cast<int32_t>(tsId));
    return ACL_SUCCESS;
}

aclError aclrtGetDeviceUtilizationRateImpl(int32_t deviceId, aclrtUtilizationInfo* utilizationInfo)
{
    ACL_LOG_INFO("start to execute aclrtGetDeviceUtilizationRate, device is %d.", deviceId);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(utilizationInfo);
    aclrtUtilizationExtendInfo* utilizationExtend = utilizationInfo->utilizationExtend;

    ACL_CHECK_INVALID_PARAM_NO_VALUE(
        utilizationExtend == nullptr, "utilizationInfo->utilizationExtend",
        "utilizationExtend is a reserved parameter and must be nullptr");
    utilizationInfo->cubeUtilization = GetAllUtilizations(deviceId, RT_UTIL_TYPE_AICORE);
    utilizationInfo->vectorUtilization = GetAllUtilizations(deviceId, RT_UTIL_TYPE_AIVECTOR);
    utilizationInfo->aicpuUtilization = GetAllUtilizations(deviceId, RT_UTIL_TYPE_AICPU);
    // Currently, memory is not supported
    utilizationInfo->memoryUtilization = DEVICE_UTILIZATION_NOT_SUPPORT;
    ACL_LOG_INFO("successfully execute aclrtGetDeviceUtilizationRate, device is %d.", deviceId);
    return ACL_SUCCESS;
};

aclError aclrtGetDeviceCountImpl(uint32_t* count)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetDeviceCount);
    ACL_LOG_INFO("start to execute aclrtGetDeviceCount");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(count);

    ACL_REQUIRES_RTS_OK(rtGetDeviceCount(reinterpret_cast<int32_t*>(count)));
    ACL_LOG_INFO("successfully execute aclrtGetDeviceCount, get device count is %u.", *count);
    return ACL_SUCCESS;
}

aclError aclrtGetDeviceSatModeImpl(aclrtFloatOverflowMode* mode)
{
    ACL_LOG_INFO("start to execute aclrtGetDeviceSatMode");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(mode);
    rtFloatOverflowMode_t rtMode = RT_OVERFLOW_MODE_UNDEF;
    ACL_REQUIRES_RTS_OK(rtGetDeviceSatMode(&rtMode));
    *mode = static_cast<aclrtFloatOverflowMode>(rtMode);
    ACL_LOG_INFO("successfully execute aclrtGetDeviceSatMode, mode is %d.", *mode);
    return ACL_SUCCESS;
}

aclError aclrtSetDeviceSatModeImpl(aclrtFloatOverflowMode mode)
{
    ACL_LOG_INFO("start to execute aclrtSetDeviceSatMode, mode is %d", mode);
    ACL_REQUIRES_RTS_OK(rtSetDeviceSatMode(static_cast<rtFloatOverflowMode_t>(mode)));
    ACL_LOG_INFO("successfully execute aclrtSetDeviceSatMode, mode is %d", mode);
    return ACL_SUCCESS;
}

aclError aclrtGetOverflowStatusImpl(void* outputAddr, size_t outputSize, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetOverflowStatus);
    ACL_LOG_INFO("start to execute aclrtGetOverflowStatus, outputSize = %lu", outputSize);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(outputAddr);
    ACL_REQUIRES_RTS_OK(rtGetDeviceSatStatus(outputAddr, outputSize, static_cast<rtStream_t>(stream)));
    ACL_LOG_INFO("successfully execute aclrtGetOverflowStatus");
    return ACL_SUCCESS;
}

aclError aclrtResetOverflowStatusImpl(aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtResetOverflowStatus);
    ACL_LOG_INFO("start to execute aclrtResetOverflowStatus");
    ACL_REQUIRES_RTS_OK(rtCleanDeviceSatStatus(static_cast<rtStream_t>(stream)));
    ACL_LOG_INFO("successfully execute aclrtResetOverflowStatus");
    return ACL_SUCCESS;
}

aclError aclrtQueryDeviceStatusImpl(int32_t deviceId, aclrtDeviceStatus* deviceStatus)
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
        ACL_LOG_ERROR(
            "rtDeviceTaskAbort for device %d, failed, runtime result = %d.", deviceId, static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtGetDeviceInfoImpl(uint32_t deviceId, aclrtDevAttr attr, int64_t* value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetDeviceInfo);
    ACL_LOG_INFO("start to execute aclrtGetDeviceInfo");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(value);

    ACL_REQUIRES_RTS_OK(rtsDeviceGetInfo(deviceId, static_cast<rtDevAttr>(attr), value));

    ACL_LOG_INFO("successfully execute aclrtGetDeviceInfo");
    return ACL_SUCCESS;
}

aclError aclrtDeviceGetStreamPriorityRangeImpl(int32_t* leastPriority, int32_t* greatestPriority)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDeviceGetStreamPriorityRange);
    ACL_LOG_INFO("start to execute aclrtDeviceGetStreamPriorityRange");

    ACL_REQUIRES_RTS_OK(rtsDeviceGetStreamPriorityRange(leastPriority, greatestPriority));

    ACL_LOG_INFO("successfully execute aclrtDeviceGetStreamPriorityRange");
    return ACL_SUCCESS;
}

aclError aclrtGetDeviceCapabilityImpl(int32_t deviceId, aclrtDevFeatureType devFeatureType, int32_t* value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetDeviceCapability);
    ACL_LOG_INFO("start to execute aclrtGetDeviceCapability");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(value);

    ACL_REQUIRES_RTS_OK(rtsDeviceGetCapability(deviceId, devFeatureType, value));

    ACL_LOG_INFO("successfully execute aclrtGetDeviceCapability");
    return ACL_SUCCESS;
}

aclError aclrtDeviceGetHostAtomicCapabilitiesImpl(
    uint32_t* capabilities, const aclrtAtomicOperation* operations, const uint32_t count, int32_t deviceId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDeviceGetHostAtomicCapabilities);
    ACL_LOG_INFO(
        "start to execute aclrtDeviceGetHostAtomicCapabilities, deviceId is [%u], count is [%u]", deviceId, count);

    ACL_REQUIRES_RTS_OK(rtDeviceGetHostAtomicCapabilities(
        capabilities, reinterpret_cast<const rtAtomicOperation*>(operations), count, deviceId));

    ACL_LOG_INFO("successfully execute aclrtDeviceGetHostAtomicCapabilities");
    return ACL_SUCCESS;
}

aclError aclrtDeviceGetP2PAtomicCapabilitiesImpl(
    uint32_t* capabilities, const aclrtAtomicOperation* operations, const uint32_t count, int32_t srcDeviceId,
    int32_t dstDeviceId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDeviceGetP2PAtomicCapabilities);
    ACL_LOG_INFO(
        "start to execute aclrtDeviceGetP2PAtomicCapabilities, srcDeviceId is [%u], dstDeviceId is [%u], "
        "count is [%u]",
        srcDeviceId, dstDeviceId, count);

    ACL_REQUIRES_RTS_OK(rtDeviceGetP2PAtomicCapabilities(
        capabilities, reinterpret_cast<const rtAtomicOperation*>(operations), count, srcDeviceId, dstDeviceId));

    ACL_LOG_INFO("successfully execute aclrtDeviceGetP2PAtomicCapabilities");
    return ACL_SUCCESS;
}

aclError aclrtDeviceGetUuidImpl(int32_t deviceId, aclrtUuid* uuid)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDeviceGetUuid);
    ACL_LOG_INFO("start to execute aclrtGetDeviceUuid, deviceId is [%d]", deviceId);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(uuid);
    ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT(rtGetDeviceUuid(deviceId, reinterpret_cast<rtUuid_t*>(uuid)), rtGetDeviceUuid);

    ACL_LOG_INFO("successfully execute aclrtGetDeviceUuid");
    return ACL_SUCCESS;
}

aclError aclrtGetDeviceResLimitImpl(int32_t deviceId, aclrtDevResLimitType type, uint32_t* value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetDeviceResLimit);
    ACL_LOG_INFO(
        "start to execute aclrtGetDeviceResLimit, deviceId is [%d], type is [%u]", deviceId,
        static_cast<uint32_t>(type));
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(value);

    ACL_REQUIRES_RTS_OK(rtsGetDeviceResLimit(deviceId, static_cast<rtDevResLimitType_t>(type), value));

    ACL_LOG_INFO("successfully execute aclrtGetDeviceResLimit");
    return ACL_SUCCESS;
}

aclError aclrtSetDeviceResLimitImpl(int32_t deviceId, aclrtDevResLimitType type, uint32_t value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetDeviceResLimit);
    ACL_LOG_INFO(
        "start to execute aclrtSetDeviceResLimit, deviceId is [%d], type is [%u], value is [%u]", deviceId,
        static_cast<uint32_t>(type), value);

    ACL_REQUIRES_RTS_OK(rtsSetDeviceResLimit(deviceId, static_cast<rtDevResLimitType_t>(type), value));

    ACL_LOG_INFO("successfully execute aclrtSetDeviceResLimit");
    return ACL_SUCCESS;
}

aclError aclrtResetDeviceResLimitImpl(int32_t deviceId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtResetDeviceResLimit);
    ACL_LOG_INFO("start to execute aclrtResetDeviceResLimit, deviceId is [%d]", deviceId);

    ACL_REQUIRES_RTS_OK(rtsResetDeviceResLimit(deviceId));

    ACL_LOG_INFO("successfully execute aclrtResetDeviceResLimit");
    return ACL_SUCCESS;
}

aclError aclrtGetStreamResLimitImpl(aclrtStream stream, aclrtDevResLimitType type, uint32_t* value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetStreamResLimit);
    ACL_LOG_INFO("start to execute aclrtGetStreamResLimit, type is [%u]", static_cast<uint32_t>(type));
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(value);
    ACL_REQUIRES_RTS_OK(
        rtsGetStreamResLimit(static_cast<rtStream_t>(stream), static_cast<rtDevResLimitType_t>(type), value));

    ACL_LOG_INFO("successfully execute aclrtGetStreamResLimit, value is [%u]", *value);
    return ACL_SUCCESS;
}

aclError aclrtSetStreamResLimitImpl(aclrtStream stream, aclrtDevResLimitType type, uint32_t value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetStreamResLimit);
    ACL_LOG_INFO(
        "start to execute aclrtSetStreamResLimit, type is [%u], value is [%u]", static_cast<uint32_t>(type), value);
    ACL_REQUIRES_RTS_OK(
        rtsSetStreamResLimit(static_cast<rtStream_t>(stream), static_cast<rtDevResLimitType_t>(type), value));

    ACL_LOG_INFO("successfully execute aclrtSetStreamResLimit");
    return ACL_SUCCESS;
}

aclError aclrtResetStreamResLimitImpl(aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtResetStreamResLimit);
    ACL_LOG_INFO("start to execute aclrtResetStreamResLimit");
    ACL_REQUIRES_RTS_OK(rtsResetStreamResLimit(static_cast<rtStream_t>(stream)));

    ACL_LOG_INFO("successfully execute aclrtResetStreamResLimit");
    return ACL_SUCCESS;
}

aclError aclrtUseStreamResInCurrentThreadImpl(aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtUseStreamResInCurrentThread);
    ACL_LOG_INFO("start to execute aclrtUseStreamResInCurrentThread");
    ACL_REQUIRES_RTS_OK(rtsUseStreamResInCurrentThread(static_cast<rtStream_t>(stream)));

    ACL_LOG_INFO("successfully execute aclrtUseStreamResInCurrentThread");
    return ACL_SUCCESS;
}

aclError aclrtUnuseStreamResInCurrentThreadImpl(aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtUnuseStreamResInCurrentThread);
    ACL_LOG_INFO("start to execute aclrtUnuseStreamResInCurrentThread");
    ACL_REQUIRES_RTS_OK(rtsNotUseStreamResInCurrentThread(static_cast<rtStream_t>(stream)));

    ACL_LOG_INFO("successfully execute aclrtUnuseStreamResInCurrentThread");
    return ACL_SUCCESS;
}

aclError aclrtGetResInCurrentThreadImpl(aclrtDevResLimitType type, uint32_t* value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetResInCurrentThread);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(value);
    ACL_REQUIRES_RTS_OK(rtsGetResInCurrentThread(static_cast<rtDevResLimitType_t>(type), value));

    return ACL_SUCCESS;
}

aclError aclrtGetDevicesTopoImpl(uint32_t deviceId, uint32_t otherDeviceId, uint64_t* value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetDevicesTopo);
    ACL_LOG_INFO(
        "start to execute aclrtGetDevicesTopo, deviceId is [%u], otherDeviceId is [%u]", deviceId, otherDeviceId);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(value);

    ACL_REQUIRES_RTS_OK(
        rtsGetPairDevicesInfo(deviceId, otherDeviceId, static_cast<int32_t>(RT_DEVS_INFO_TYPE_TOPOLOGY), value));

    ACL_LOG_INFO("successfully execute aclrtGetDevicesTopo");
    return ACL_SUCCESS;
}

aclError aclrtGetLogicDevIdByUserDevIdImpl(const int32_t userDevid, int32_t* const logicDevId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetLogicDevIdByUserDevId);
    ACL_LOG_INFO("start to execute aclrtGetLogicDevIdByUserDevId, userDevid is [%d]", userDevid);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(logicDevId);
    ACL_REQUIRES_RTS_OK(rtsGetLogicDevIdByUserDevId(userDevid, logicDevId));

    ACL_LOG_INFO("successfully execute aclrtGetLogicDevIdByUserDevId");
    return ACL_SUCCESS;
}

aclError aclrtGetUserDevIdByLogicDevIdImpl(const int32_t logicDevId, int32_t* const userDevid)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetUserDevIdByLogicDevId);
    ACL_LOG_INFO("start to execute aclrtGetUserDevIdByLogicDevId, logicDevId is [%d]", logicDevId);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(userDevid);
    ACL_REQUIRES_RTS_OK(rtsGetUserDevIdByLogicDevId(logicDevId, userDevid));

    ACL_LOG_INFO("successfully execute aclrtGetUserDevIdByLogicDevId");
    return ACL_SUCCESS;
}

aclError aclrtGetLogicDevIdByPhyDevIdImpl(int32_t phyDevId, int32_t* const logicDevId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetLogicDevIdByPhyDevId);
    ACL_LOG_INFO("start to execute aclrtGetLogicDevIdByPhyDevId, phyDevId is [%d]", phyDevId);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(logicDevId);
    ACL_REQUIRES_RTS_OK(rtsGetLogicDevIdByPhyDevId(phyDevId, logicDevId));

    ACL_LOG_INFO("successfully execute aclrtGetLogicDevIdByPhyDevId");
    return ACL_SUCCESS;
}

aclError aclrtGetPhyDevIdByLogicDevIdImpl(int32_t logicDevId, int32_t* const phyDevId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetPhyDevIdByLogicDevId);
    ACL_LOG_INFO("start to execute aclrtGetPhyDevIdByLogicDevId, logicDevId is [%d]", logicDevId);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(phyDevId);
    ACL_REQUIRES_RTS_OK(rtsGetPhyDevIdByLogicDevId(logicDevId, phyDevId));

    ACL_LOG_INFO("successfully execute aclrtGetPhyDevIdByLogicDevId");
    return ACL_SUCCESS;
}

aclError aclrtGetUserDevIdByPhyDevIdImpl(const int32_t phyDevId, int32_t* const userDevId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetUserDevIdByPhyDevId);
    ACL_LOG_INFO("start to execute aclrtGetUserDevIdByPhyDevId, phyDevId is [%d]", phyDevId);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(userDevId);
    ACL_REQUIRES_RTS_OK(rtsGetLogicDevIdByPhyDevId(phyDevId, userDevId));

    ACL_LOG_INFO("successfully execute aclrtGetUserDevIdByPhyDevId");
    return ACL_SUCCESS;
}

aclError aclrtGetPhyDevIdByUserDevIdImpl(const int32_t userDevId, int32_t* const phyDevId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetPhyDevIdByUserDevId);
    ACL_LOG_INFO("start to execute aclrtGetPhyDevIdByUserDevId, userDevId is [%d]", userDevId);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(phyDevId);
    ACL_REQUIRES_RTS_OK(rtsGetPhyDevIdByLogicDevId(userDevId, phyDevId));

    ACL_LOG_INFO("successfully execute aclrtGetPhyDevIdByUserDevId");
    return ACL_SUCCESS;
}

aclError aclrtGetOpExecuteTimeoutImpl(uint32_t* const timeoutMs)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetOpExecuteTimeout);
    ACL_LOG_INFO("start to execute aclrtGetOpExecuteTimeout");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(timeoutMs);
    ACL_REQUIRES_RTS_OK(rtGetOpExecuteTimeoutV2(timeoutMs));
    ACL_LOG_INFO("successfully execute aclrtGetOpExecuteTimeout");
    return ACL_SUCCESS;
}

aclError aclrtCheckArchCompatibilityImpl(const char* socVersion, int32_t* canCompatible)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCheckArchCompatibility);
    ACL_LOG_INFO("start to execute aclrtCheckArchCompatibility");
    ACL_REQUIRES_RTS_OK(rtCheckArchCompatibility(socVersion, canCompatible));
    ACL_LOG_INFO("successfully execute aclrtCheckArchCompatibility");
    return ACL_SUCCESS;
}

static constexpr rtLimitType_t ACL_TO_RT_LIMIT_TABLE[] = {
    RT_LIMIT_TYPE_SIMT_STACK_SIZE,
    RT_LIMIT_TYPE_SIMT_DVG_WARP_STACK_SIZE,
    RT_LIMIT_TYPE_STACK_SIZE,
    RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE,
    RT_LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE,
};
static constexpr size_t ACL_TO_RT_LIMIT_TABLE_SIZE = sizeof(ACL_TO_RT_LIMIT_TABLE) / sizeof(ACL_TO_RT_LIMIT_TABLE[0]);

static rtLimitType_t AclLimitToRtLimit(aclrtDeviceLimit limit)
{
    const auto idx = static_cast<size_t>(limit);
    if (idx >= ACL_TO_RT_LIMIT_TABLE_SIZE) {
        return RT_LIMIT_TYPE_RESERVED;
    }
    return ACL_TO_RT_LIMIT_TABLE[idx];
}

aclError aclrtDeviceSetLimitImpl(aclrtDeviceLimit limit, size_t value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDeviceSetLimit);
    ACL_LOG_INFO(
        "start to execute aclrtDeviceSetLimit, limit is [%d], value is [%zu]", static_cast<int32_t>(limit), value);
    const auto rtType = AclLimitToRtLimit(limit);
    if (rtType == RT_LIMIT_TYPE_RESERVED) {
        std::string funcName = acl::AclErrorLogManager::GetFuncNameWithoutImplSuffix(__func__);
        std::string limitStr = std::to_string(static_cast<int32_t>(limit));
        acl::AclErrorLogManager::ReportInputError(
            acl::INVALID_VALUE_MSG, std::vector<const char*>({"func", "value", "param", "expect"}),
            std::vector<const char*>({funcName.c_str(), limitStr.c_str(), "limit", "[0, 4]"}));
        return ACL_ERROR_INVALID_PARAM;
    }
    if (value > static_cast<size_t>(UINT32_MAX)) {
        std::string funcName = acl::AclErrorLogManager::GetFuncNameWithoutImplSuffix(__func__);
        std::string valueStr = std::to_string(value);
        acl::AclErrorLogManager::ReportInputError(
            acl::INVALID_VALUE_MSG, std::vector<const char*>({"func", "value", "param", "expect"}),
            std::vector<const char*>({funcName.c_str(), valueStr.c_str(), "value", "[0, UINT32_MAX]"}));
        return ACL_ERROR_INVALID_PARAM;
    }
    const rtError_t rtSetErr = rtDeviceSetLimit(0, rtType, static_cast<uint32_t>(value));
    if (rtSetErr != RT_ERROR_NONE) {
        if (rtSetErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            ACL_LOG_WARN(
                "aclrtDeviceSetLimit not supported, limit is [%d], value is [%zu].", static_cast<int32_t>(limit),
                value);
            return rtSetErr;
        }
        ACL_LOG_CALL_ERROR("rtDeviceSetLimit failed, runtime result = %d.", static_cast<int32_t>(rtSetErr));
        return ACL_GET_ERRCODE_RTS(rtSetErr);
    }
    ACL_LOG_INFO(
        "successfully execute aclrtDeviceSetLimit, limit is [%d], value is [%zu]", static_cast<int32_t>(limit), value);
    return ACL_SUCCESS;
}

aclError aclrtDeviceGetLimitImpl(aclrtDeviceLimit limit, size_t* value)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDeviceGetLimit);
    ACL_LOG_INFO("start to execute aclrtDeviceGetLimit, limit is [%d]", static_cast<int32_t>(limit));
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(value);
    const auto rtType = AclLimitToRtLimit(limit);
    if (rtType == RT_LIMIT_TYPE_RESERVED) {
        std::string funcName = acl::AclErrorLogManager::GetFuncNameWithoutImplSuffix(__func__);
        std::string limitStr = std::to_string(static_cast<int32_t>(limit));
        acl::AclErrorLogManager::ReportInputError(
            acl::INVALID_VALUE_MSG, std::vector<const char*>({"func", "value", "param", "expect"}),
            std::vector<const char*>({funcName.c_str(), limitStr.c_str(), "limit", "[0, 4]"}));
        return ACL_ERROR_INVALID_PARAM;
    }
    uint32_t rtValue = 0U;
    const rtError_t rtGetErr = rtDeviceGetLimit(rtType, &rtValue);
    if (rtGetErr != RT_ERROR_NONE) {
        if (rtGetErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            ACL_LOG_WARN("aclrtDeviceGetLimit not supported, limit is [%d].", static_cast<int32_t>(limit));
            return rtGetErr;
        }
        ACL_LOG_CALL_ERROR("rtDeviceGetLimit failed, runtime result = %d.", static_cast<int32_t>(rtGetErr));
        return ACL_GET_ERRCODE_RTS(rtGetErr);
    }
    *value = static_cast<size_t>(rtValue);
    ACL_LOG_INFO(
        "successfully execute aclrtDeviceGetLimit, limit is [%d], value is [%zu]", static_cast<int32_t>(limit), *value);
    return ACL_SUCCESS;
}
#ifdef __cplusplus
}
#endif
