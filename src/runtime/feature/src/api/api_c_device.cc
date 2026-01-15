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
#include "driver/ascend_hal.h"
#include "osal.hpp"
#include "prof_map_ge_model_device.hpp"
#include "runtime_keeper.h"
#include "global_state_manager.hpp"

using namespace cce::runtime;

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

VISIBILITY_DEFAULT
rtError_t rtOpenNetService(const rtNetServiceOpenArgs *args)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->OpenNetService(args);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtCloseNetService()
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->CloseNetService();
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetDeviceCount(int32_t *cnt)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->GetDeviceCount(cnt);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsGetDeviceCount(int32_t *cnt)
{
    return rtGetDeviceCount(cnt);
}

VISIBILITY_DEFAULT
rtError_t rtGetDeviceIDs(uint32_t *devices, uint32_t len)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->GetDeviceIDs(devices, len);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsSetDevice(int32_t devId)
{
    return rtSetDevice(devId);
}

VISIBILITY_DEFAULT
rtError_t rtSetDevice(int32_t devId)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->SetDevice(devId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetDevice(int32_t *devId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->GetDevice(devId);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_CONTEXT_NULL, ACL_ERROR_RT_CONTEXT_NULL); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsGetDevice(int32_t *devId)
{
    return rtGetDevice(devId);
}

VISIBILITY_DEFAULT
rtError_t rtGetVisibleDeviceIdByLogicDeviceId(const int32_t logicDeviceId, int32_t * const visibleDeviceId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->GetVisibleDeviceIdByLogicDeviceId(logicDeviceId, visibleDeviceId);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_CONTEXT_NULL, ACL_ERROR_RT_CONTEXT_NULL); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDeviceReset(int32_t devId)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->DeviceReset(devId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsResetDevice(int32_t devId)
{
    return rtDeviceReset(devId);
}

VISIBILITY_DEFAULT
rtError_t rtsDeviceResetForce(int32_t devId)
{
    return rtDeviceResetForce(devId);
}

VISIBILITY_DEFAULT
rtError_t rtsGetRunMode(rtRunMode *runMode)
{
    return rtGetRunMode(runMode);
}

VISIBILITY_DEFAULT
rtError_t rtsGetDeviceUtilizations(const int32_t devId, const rtTypeUtil_t kind, uint8_t * const util)
{
    return rtGetAllUtilizations(devId, kind, util);
}

VISIBILITY_DEFAULT
rtError_t rtsGetSocVersion(char_t *ver, const uint32_t maxLen)
{
    return rtGetSocVersion(ver, maxLen);
}

VISIBILITY_DEFAULT
rtError_t rtsSetOpWaitTimeOut(uint32_t timeout)
{
    return rtSetOpWaitTimeOut(timeout);
}

VISIBILITY_DEFAULT
rtError_t rtDeviceSetLimit(int32_t devId, rtLimitType_t type, uint32_t val)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->DeviceSetLimit(devId, type, val);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsSetDeviceResLimit(const int32_t devId, const rtDevResLimitType_t type, uint32_t value)
{
    Api *const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    if (devId < 0) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(devId, "greater than or equal to 0");
        ERROR_RETURN_WITH_EXT_ERRCODE(RT_ERROR_DEVICE_ID);
    }
    const rtError_t error = apiInstance->SetDeviceResLimit(static_cast<uint32_t>(devId), type, value);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsResetDeviceResLimit(const int32_t devId)
{
    Api *const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    if (devId < 0) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(devId, "greater than or equal to 0");
        ERROR_RETURN_WITH_EXT_ERRCODE(RT_ERROR_DEVICE_ID);
    }
    const rtError_t error = apiInstance->ResetDeviceResLimit(static_cast<uint32_t>(devId));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsGetDeviceResLimit(const int32_t devId, const rtDevResLimitType_t type, uint32_t *value)
{
    Api *const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    if (devId < 0) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(devId, "greater than or equal to 0");
        ERROR_RETURN_WITH_EXT_ERRCODE(RT_ERROR_DEVICE_ID);
    }
    const rtError_t error = apiInstance->GetDeviceResLimit(static_cast<uint32_t>(devId), type, value);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDeviceSynchronize(void)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->DeviceSynchronize();
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDeviceSynchronizeWithTimeout(int32_t timeout)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->DeviceSynchronize(timeout);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDeviceGetStreamPriorityRange(int32_t *leastPriority, int32_t *greatestPriority)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->DeviceGetStreamPriorityRange(leastPriority, greatestPriority);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsDeviceGetStreamPriorityRange(int32_t *leastPriority, int32_t *greatestPriority)
{
    return rtDeviceGetStreamPriorityRange(leastPriority, greatestPriority);
}

VISIBILITY_DEFAULT
rtError_t rtGetDeviceInfo(uint32_t deviceId, int32_t moduleType, int32_t infoType, int64_t *val)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetDeviceInfo(deviceId, moduleType, infoType, val);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetPhyDeviceInfo(uint32_t phyId, int32_t moduleType, int32_t infoType, int64_t *val)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetPhyDeviceInfo(phyId, moduleType, infoType, val);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetDevicePhyIdByIndex(uint32_t devIndex, uint32_t *phyId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->GetDevicePhyIdByIndex(devIndex, phyId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetDeviceIndexByPhyId(uint32_t phyId, uint32_t *devIndex)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->GetDeviceIndexByPhyId(phyId, devIndex);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}
 
VISIBILITY_DEFAULT
rtError_t rtsGetLogicDevIdByPhyDevId(int32_t phyDevId, int32_t * const logicDevId)
{
    if (phyDevId < 0) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(phyDevId, "greater than or equal to 0");
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE);
    }
    return rtGetDeviceIndexByPhyId(static_cast<uint32_t>(phyDevId), RtPtrToPtr<uint32_t *>(logicDevId));
}
 
VISIBILITY_DEFAULT
rtError_t rtsGetPhyDevIdByLogicDevId(int32_t logicDevId, int32_t * const phyDevId)
{
    if (logicDevId < 0) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(logicDevId, "greater than or equal to 0");
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE);
    }
    return rtGetDevicePhyIdByIndex(static_cast<uint32_t>(logicDevId), RtPtrToPtr<uint32_t *>(phyDevId));
}
 
VISIBILITY_DEFAULT
rtError_t rtsGetLogicDevIdByUserDevId(const int32_t userDevId, int32_t * const logicDevId)
{
    if (userDevId < 0) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(userDevId, "greater than or equal to 0");
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE);
    }
    return rtGetLogicDevIdByUserDevId(userDevId, logicDevId);
}
 
VISIBILITY_DEFAULT
rtError_t rtsGetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t * const userDevId)
{
    if (logicDevId < 0) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(logicDevId, "greater than or equal to 0");
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE);
    }
    return rtGetUserDevIdByLogicDevId(logicDevId, userDevId);
}

VISIBILITY_DEFAULT
rtError_t rtEnableP2P(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t flag)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->EnableP2P(devIdDes, phyIdSrc, flag);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDisableP2P(uint32_t devIdDes, uint32_t phyIdSrc)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->DisableP2P(devIdDes, phyIdSrc);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDeviceCanAccessPeer(int32_t* canAccessPeer, uint32_t  devId, uint32_t  peerDevice)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->DeviceCanAccessPeer(canAccessPeer, devId, peerDevice);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetP2PStatus(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t *status)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->GetP2PStatus(devIdDes, phyIdSrc, status);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}


VISIBILITY_DEFAULT
rtError_t rtsSetTsDevice(uint32_t tsId)
{
    return rtSetTSDevice(tsId);
}

VISIBILITY_DEFAULT
rtError_t rtSetTSDevice(uint32_t tsId)
{
    TIMESTAMP_NAME(__func__);
    DevProperties prop;
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    rtError_t ret = GET_DEV_PROPERTIES(rtInstance->GetChipType(), prop);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    if (prop.tsCount == 1U) { // single ts
        return ACL_RT_SUCCESS;
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->DeviceSetTsId(tsId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetDeviceIdByGeModelIdx(uint32_t geModelIdx, uint32_t *deviceId)
{
    RT_LOG(RT_LOG_DEBUG, "geModelIdx:%u", geModelIdx);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(deviceId, RT_ERROR_INVALID_VALUE);

    uint32_t drvDeviceId;
    rtError_t error = ProfMapGeModelDevice::Instance().GetDeviceIdByGeModelIdx(geModelIdx, &drvDeviceId);
    if (error != RT_ERROR_NONE) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "The device of geModelIdx:%u does not exist.", geModelIdx);
        ERROR_RETURN_WITH_EXT_ERRCODE(error);
    }
    
    int32_t userDeviceId;
    error = rtGetUserDevIdByLogicDevId(static_cast<int32_t>(drvDeviceId), &userDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Get userDeviceId by drv devId:%u failed, retCode=%#x",
        drvDeviceId, static_cast<uint32_t>(error));
    *deviceId = static_cast<uint32_t>(userDeviceId);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetDeviceEx(int32_t devId)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->SetDevice(devId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDeviceResetEx(int32_t devId)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->DeviceReset(devId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDeviceGetBareTgid(uint32_t *pid)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->DeviceGetBareTgid(pid);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsDeviceGetBareTgid(uint32_t *pid)
{
    return rtDeviceGetBareTgid(pid);
}

VISIBILITY_DEFAULT
rtError_t rtGetPairDevicesInfo(uint32_t devId, uint32_t otherDevId, int32_t infoType, int64_t *val)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetPairDevicesInfo(devId, otherDevId, infoType, val);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsGetPairDevicesInfo(uint32_t devId, uint32_t otherDevId, int32_t infoType, uint64_t *val)
{
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(val, RT_ERROR_INVALID_VALUE);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    int64_t halVal = 0;
    const rtError_t error = apiInstance->GetPairDevicesInfo(devId, otherDevId, infoType, &halVal);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    *val = 1U << static_cast<uint64_t>(halVal);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetPairPhyDevicesInfo(uint32_t devId, uint32_t otherDevId, int32_t infoType, int64_t *val)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetPairPhyDevicesInfo(devId, otherDevId, infoType, val);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDeviceResetWithoutTsd(int32_t devId)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance(API_ENV_FLAGS_NO_TSD);
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->DeviceReset(devId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetDeviceCapability(int32_t deviceId, int32_t moduleType, int32_t featureType, int32_t *val)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetDeviceCapability(deviceId, moduleType, featureType, val);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsDeviceGetCapability(int32_t deviceId, int32_t devFeatureType, int32_t *val)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    rtError_t error = RT_ERROR_NONE;
    COND_RETURN_ERROR_WITH_EXT_ERRCODE((devFeatureType >= static_cast<int32_t>(RT_DEV_FEATURE_MAX)) || (devFeatureType < 0),
        RT_ERROR_INVALID_VALUE, "rtsDeviceGetCapability failed, invalid devFeatureType=%d.", devFeatureType);

    if (devFeatureType == static_cast<int32_t>(RT_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV)) {
        error = apiInstance->GetDeviceCapability(deviceId, static_cast<int32_t>(RT_MODULE_TYPE_TSCPU),
            static_cast<int32_t>(FEATURE_TYPE_MODEL_TASK_UPDATE), val);
        ERROR_RETURN_WITH_EXT_ERRCODE(error);
        switch (*val) {
            case static_cast<int32_t>(RT_DEV_CAP_SUPPORT):
                *val = static_cast<int32_t>(FEATURE_SUPPORT);
                break;
            case static_cast<int32_t>(RT_DEV_CAP_NOT_SUPPORT):
                *val = static_cast<int32_t>(FEATURE_NOT_SUPPORT);
                break;
            default:
                *val = static_cast<int32_t>(FEATURE_NOT_SUPPORT);
                break;
        }
    } else if (devFeatureType == static_cast<int32_t>(RT_FEATURE_SYSTEM_MEMQ_EVENT_CROSS_DEV)) {
        error = apiInstance->GetDeviceCapability(deviceId, static_cast<int32_t>(RT_MODULE_TYPE_SYSTEM),
            static_cast<int32_t>(FEATURE_TYPE_MEMQ_EVENT_CROSS_DEV), val);
        ERROR_RETURN_WITH_EXT_ERRCODE(error);
    } else if (devFeatureType == static_cast<int32_t>(RT_FEATURE_AICPU_SCHEDULE_TYPE)) {
        error = apiInstance->GetDeviceCapability(deviceId, static_cast<int32_t>(MODULE_TYPE_AICPU),
            static_cast<int32_t>(FEATURE_TYPE_SCHE), val);
        ERROR_RETURN_WITH_EXT_ERRCODE(error);
    } else if (devFeatureType == static_cast<int32_t>(RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH)) {
        error = apiInstance->GetDeviceCapability(deviceId, static_cast<int32_t>(RT_MODULE_TYPE_SYSTEM),
            devFeatureType, val);
        ERROR_RETURN_WITH_EXT_ERRCODE(error);
    } else {
        RT_LOG_OUTER_MSG_INVALID_PARAM(
            devFeatureType,
            "[" + std::to_string(RT_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV) +
                ", " + std::to_string(RT_DEV_FEATURE_MAX) + ")");
        return ACL_ERROR_RT_PARAM_INVALID;
    }
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetDevMsg(rtGetDevMsgType_t getMsgType, rtGetMsgCallback callback)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetDevMsg(getMsgType, callback);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtGetDeviceSatMode(rtFloatOverflowMode_t *floatOverflowMode)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->GetDeviceSatMode(floatOverflowMode);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtGetDeviceSatModeForStream(rtStream_t stm, rtFloatOverflowMode_t *floatOverflowMode)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Stream * const targetStm = static_cast<Stream *>(stm);
    const rtError_t ret = apiInstance->GetDeviceSatModeForStream(targetStm, floatOverflowMode);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtDeviceStatusQuery(const uint32_t devId, rtDeviceStatus *deviceStatus)
{
    Runtime *rtInstance = (IsRuntimeKeeperExiting() ? nullptr : Runtime::Instance());
    NULL_RETURN_WARNING_WITH_EXT_ERRCODE(rtInstance, RT_ERROR_INSTANCE_NULL);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_WARNING_WITH_EXT_ERRCODE(apiInstance, RT_ERROR_API_NULL);
    const rtError_t error = apiInstance->DeviceStatusQuery(devId, deviceStatus);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDeviceTaskAbort(int32_t devId, uint32_t timeout)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->DeviceTaskAbort(devId, timeout);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetDeviceFailureMode(uint64_t failureMode)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_DEVICE_FAILURE_MODE_SET)) {
        REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SetDeviceFailureMode(failureMode);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetDeviceStatus(const int32_t devId, rtDevStatus_t * const status)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    const rtError_t error = apiInstance->GetDeviceStatus(devId, status);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtHdcServerCreate(const int32_t devId, const rtHdcServiceType_t type, rtHdcServer_t * const server)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    const rtError_t error = apiInstance->HdcServerCreate(devId, type, server);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtHdcServerDestroy(rtHdcServer_t const server)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    const rtError_t error = apiInstance->HdcServerDestroy(server);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtHdcSessionConnect(const int32_t peerNode, const int32_t peerDevId, rtHdcClient_t const client,
        rtHdcSession_t * const session)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    const rtError_t error = apiInstance->HdcSessionConnect(peerNode, peerDevId, client, session);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtHdcSessionClose(rtHdcSession_t const session)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    const rtError_t error = apiInstance->HdcSessionClose(session);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetHostCpuDevId(int32_t * const devId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    const rtError_t error = apiInstance->GetHostCpuDevId(devId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetLogicDevIdByUserDevId(const int32_t userDevId, int32_t * const logicDevId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    const rtError_t error = apiInstance->GetLogicDevIdByUserDevId(userDevId, logicDevId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t * const userDevId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    const rtError_t error = apiInstance->GetUserDevIdByLogicDevId(logicDevId, userDevId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDebugSetDumpMode(const uint64_t mode)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->DebugSetDumpMode(mode);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDebugGetStalledCore(rtDbgCoreInfo_t *const coreInfo)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->DebugGetStalledCore(coreInfo);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDebugReadAICore(rtDebugMemoryParam_t *const param)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->DebugReadAICore(param);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}


VISIBILITY_DEFAULT
rtError_t rtGetBinBuffer(const rtBinHandle binHandle, const rtBinBufferType_t type, void **bin,
                         uint32_t *binSize)
{
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetBinBuffer(binHandle, type, bin, binSize);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetStackBuffer(const rtBinHandle binHandle, const uint32_t coreType, const uint32_t coreId,
                           const void **stack, uint32_t *stackSize)
{
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetStackBuffer(binHandle, coreType, coreId, stack, stackSize);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsDeviceStatusQuery(const uint32_t devId, rtDeviceStatus *deviceStatus)
{
    return rtDeviceStatusQuery(devId, deviceStatus);
}

VISIBILITY_DEFAULT
rtError_t rtSetDefaultDeviceId(const int32_t deviceId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SetDefaultDeviceId(deviceId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsSetDefaultDeviceId(const int32_t deviceId)
{
    return rtSetDefaultDeviceId(deviceId);
}
 
VISIBILITY_DEFAULT
RTS_API rtError_t rtsSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal)
{
    return rtSetSysParamOpt(configOpt, configVal);
}

VISIBILITY_DEFAULT
rtError_t rtsDeviceSynchronize(int32_t timeout)
{
    return rtDeviceSynchronizeWithTimeout(timeout);
}

VISIBILITY_DEFAULT
rtError_t rtsDeviceTaskAbort(int32_t devId, uint32_t timeout)
{
    return rtDeviceTaskAbort(devId, timeout);
}

VISIBILITY_DEFAULT
rtError_t rtsSetOpExecuteTimeOut(uint32_t timeout)
{
    return rtSetOpExecuteTimeOut(timeout);
}

VISIBILITY_DEFAULT
rtError_t rtsGetOpExecuteTimeOut(uint32_t * const timeout)
{
    return rtGetOpExecuteTimeOut(timeout);
}

VISIBILITY_DEFAULT
rtError_t rtsSetOpExecuteTimeOutWithMs(uint32_t timeout)
{
    return rtSetOpExecuteTimeOutWithMs(timeout);
}

VISIBILITY_DEFAULT
rtError_t rtsGetSysParamOpt(const rtSysParamOpt configOpt, int64_t * const configVal)
{
    return rtGetSysParamOpt(configOpt, configVal);
}

VISIBILITY_DEFAULT
rtError_t rtsGetP2PStatus(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t *status)
{
    return rtGetP2PStatus(devIdDes, phyIdSrc, status);
}

VISIBILITY_DEFAULT
rtError_t rtsGetErrorVerbose(const uint32_t deviceId, rtErrorInfo * const errorInfo)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_DFX_ERR_GET_AND_REPAIR)) {
        RT_LOG(RT_LOG_WARNING, "Chip type(%d) do not support rtsGetErrorVerbose api.",
            static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    const rtError_t error = apiInstance->GetErrorVerbose(deviceId, errorInfo);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsRepairError(const uint32_t deviceId, const rtErrorInfo * const errorInfo)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_DFX_ERR_GET_AND_REPAIR)) {
        RT_LOG(RT_LOG_WARNING, "Chip type(%d) do not support rtsRepairError api.",
            static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    const rtError_t error = apiInstance->RepairError(deviceId, errorInfo);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsDebugSetDumpMode(const uint64_t mode)
{
    return rtDebugSetDumpMode(mode);
}

VISIBILITY_DEFAULT
rtError_t rtsDebugGetStalledCore(rtDbgCoreInfo_t *const coreInfo)
{
    return rtDebugGetStalledCore(coreInfo);
}

VISIBILITY_DEFAULT
rtError_t rtsBinaryGetDevAddress(const rtBinHandle binHandle, void **bin, uint32_t *binSize)
{
    return rtGetBinBuffer(binHandle, RT_BIN_DEVICE_ADDR, bin, binSize);
}

VISIBILITY_DEFAULT
rtError_t rtsGetStackBuffer(const rtBinHandle binHandle, const rtCoreType_t coreType, const uint16_t coreId,
    const void **stack, uint32_t *stackSize)
{
    return rtGetStackBuffer(
        binHandle, static_cast<uint32_t>(coreType), static_cast<uint32_t>(coreId), stack, stackSize);
}

VISIBILITY_DEFAULT
rtError_t rtsDebugReadAICore(rtDebugMemoryParam *const param)
{
    rtDebugMemoryParam_t debugParam = {};
    debugParam.coreId = param->coreId;
    debugParam.reserve = param->reserve;
    debugParam.coreType = static_cast<uint32_t>(param->coreType);
    debugParam.debugMemType = static_cast<rtDebugMemoryType_t>(static_cast<uint16_t>(param->debugMemType));
    debugParam.elementSize = param->elementSize;
    debugParam.reserved = param->reserved;
    debugParam.srcAddr = param->srcAddr;
    debugParam.dstAddr = param->dstAddr;
    debugParam.memLen = param->memLen;
    return rtDebugReadAICore(&debugParam);
}

VISIBILITY_DEFAULT
rtError_t rtGetDeviceUuid(const int32_t devId, rtUuid_t *uuid)
{
    Api* const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    const rtError_t error = apiInstance->GetDeviceUuid(devId, uuid);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetDeviceWithFlags(int32_t deviceId, uint64_t flags)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    TIMESTAMP_NAME(__func__);
    rtError_t error;
    if (flags == RT_DEVICE_FLAG_DEFAULT) {
        Api * const apiInstance = Api::Instance();
        NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
        error = apiInstance->SetDevice(deviceId);
    } else if (flags == RT_DEVICE_FLAG_NOT_START_CPU_SCHED) {
        Api * const apiInstanceNoTSD = Api::Instance(API_ENV_FLAGS_NO_TSD);
        NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstanceNoTSD);
        error = apiInstanceNoTSD->SetDevice(deviceId);
    } else {
        RT_LOG_OUTER_MSG_INVALID_PARAM(
           flags, std::to_string(RT_DEVICE_FLAG_DEFAULT) + " or " + std::to_string(RT_DEVICE_FLAG_NOT_START_CPU_SCHED));
        error = RT_ERROR_INVALID_VALUE;
    }
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus