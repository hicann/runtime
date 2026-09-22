/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "api_c.h"
#include "api_device_topology.hpp"

using namespace cce::runtime;

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

VISIBILITY_DEFAULT
rtError_t rtGetDeviceCount(int32_t* cnt)
{
    ApiDeviceTopology* const apiDeviceTopologyInstance = ApiDeviceTopology::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiDeviceTopologyInstance);
    const rtError_t error = apiDeviceTopologyInstance->GetDeviceCount(cnt);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsGetDeviceCount(int32_t* cnt) { return rtGetDeviceCount(cnt); }

VISIBILITY_DEFAULT
rtError_t rtGetDevicePhyIdByIndex(uint32_t devIndex, uint32_t* phyId)
{
    ApiDeviceTopology* const apiDeviceTopologyInstance = ApiDeviceTopology::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiDeviceTopologyInstance);
    const rtError_t error = apiDeviceTopologyInstance->GetDevicePhyIdByIndex(devIndex, phyId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetDeviceIndexByPhyId(uint32_t phyId, uint32_t* devIndex)
{
    ApiDeviceTopology* const apiDeviceTopologyInstance = ApiDeviceTopology::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiDeviceTopologyInstance);
    const rtError_t error = apiDeviceTopologyInstance->GetDeviceIndexByPhyId(phyId, devIndex);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsGetLogicDevIdByPhyDevId(int32_t phyDevId, int32_t* const logicDevId)
{
    if (phyDevId < 0) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(phyDevId, "greater than or equal to 0");
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE);
    }
    return rtGetDeviceIndexByPhyId(static_cast<uint32_t>(phyDevId), RtPtrToPtr<uint32_t*>(logicDevId));
}

VISIBILITY_DEFAULT
rtError_t rtsGetPhyDevIdByLogicDevId(int32_t logicDevId, int32_t* const phyDevId)
{
    if (logicDevId < 0) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(logicDevId, "greater than or equal to 0");
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE);
    }
    return rtGetDevicePhyIdByIndex(static_cast<uint32_t>(logicDevId), RtPtrToPtr<uint32_t*>(phyDevId));
}

VISIBILITY_DEFAULT
rtError_t rtGetLogicDevIdByUserDevId(const int32_t userDevId, int32_t* const logicDevId)
{
    ApiDeviceTopology* const apiDeviceTopologyInstance = ApiDeviceTopology::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiDeviceTopologyInstance);
    const rtError_t error = apiDeviceTopologyInstance->GetLogicDevIdByUserDevId(userDevId, logicDevId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsGetLogicDevIdByUserDevId(const int32_t userDevId, int32_t* const logicDevId)
{
    if (userDevId < 0) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(userDevId, "greater than or equal to 0");
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE);
    }
    return rtGetLogicDevIdByUserDevId(userDevId, logicDevId);
}

VISIBILITY_DEFAULT
rtError_t rtGetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t* const userDevId)
{
    ApiDeviceTopology* const apiDeviceTopologyInstance = ApiDeviceTopology::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiDeviceTopologyInstance);
    const rtError_t error = apiDeviceTopologyInstance->GetUserDevIdByLogicDevId(logicDevId, userDevId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsGetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t* const userDevId)
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
    ApiDeviceTopology* const apiDeviceTopologyInstance = ApiDeviceTopology::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiDeviceTopologyInstance);
    const rtError_t error = apiDeviceTopologyInstance->EnableP2P(devIdDes, phyIdSrc, flag);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsEnableP2P(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t flag)
{
    return rtEnableP2P(devIdDes, phyIdSrc, flag);
}

VISIBILITY_DEFAULT
rtError_t rtDisableP2P(uint32_t devIdDes, uint32_t phyIdSrc)
{
    ApiDeviceTopology* const apiDeviceTopologyInstance = ApiDeviceTopology::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiDeviceTopologyInstance);
    const rtError_t error = apiDeviceTopologyInstance->DisableP2P(devIdDes, phyIdSrc);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsDisableP2P(uint32_t devIdDes, uint32_t phyIdSrc) { return rtDisableP2P(devIdDes, phyIdSrc); }

VISIBILITY_DEFAULT
rtError_t rtDeviceCanAccessPeer(int32_t* canAccessPeer, uint32_t devId, uint32_t peerDevice)
{
    ApiDeviceTopology* const apiDeviceTopologyInstance = ApiDeviceTopology::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiDeviceTopologyInstance);
    const rtError_t error = apiDeviceTopologyInstance->DeviceCanAccessPeer(canAccessPeer, devId, peerDevice);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsDeviceCanAccessPeer(uint32_t devId, uint32_t peerDevice, int32_t* canAccessPeer)
{
    return rtDeviceCanAccessPeer(canAccessPeer, devId, peerDevice);
}

VISIBILITY_DEFAULT
rtError_t rtGetP2PStatus(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t* status)
{
    ApiDeviceTopology* const apiDeviceTopologyInstance = ApiDeviceTopology::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiDeviceTopologyInstance);
    const rtError_t error = apiDeviceTopologyInstance->GetP2PStatus(devIdDes, phyIdSrc, status);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsGetP2PStatus(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t* status)
{
    return rtGetP2PStatus(devIdDes, phyIdSrc, status);
}

VISIBILITY_DEFAULT
rtError_t rtGetPairDevicesInfo(uint32_t devId, uint32_t otherDevId, int32_t infoType, int64_t* val)
{
    ApiDeviceTopology* const apiDeviceTopologyInstance = ApiDeviceTopology::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiDeviceTopologyInstance);
    const rtError_t error = apiDeviceTopologyInstance->GetPairDevicesInfo(devId, otherDevId, infoType, val);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsGetPairDevicesInfo(uint32_t devId, uint32_t otherDevId, int32_t infoType, uint64_t* val)
{
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(val, RT_ERROR_INVALID_VALUE);
    ApiDeviceTopology* const apiDeviceTopologyInstance = ApiDeviceTopology::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiDeviceTopologyInstance);
    int64_t halVal = 0;
    const rtError_t error = apiDeviceTopologyInstance->GetPairDevicesInfo(devId, otherDevId, infoType, &halVal);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    *val = 1U << static_cast<uint64_t>(halVal);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetPairPhyDevicesInfo(uint32_t devId, uint32_t otherDevId, int32_t infoType, int64_t* val)
{
    ApiDeviceTopology* const apiDeviceTopologyInstance = ApiDeviceTopology::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiDeviceTopologyInstance);
    const rtError_t error = apiDeviceTopologyInstance->GetPairPhyDevicesInfo(devId, otherDevId, infoType, val);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetDeviceUuid(const int32_t devId, rtUuid_t* uuid)
{
    ApiDeviceTopology* const apiDeviceTopologyInstance = ApiDeviceTopology::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiDeviceTopologyInstance);
    const rtError_t error = apiDeviceTopologyInstance->GetDeviceUuid(devId, uuid);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDeviceGetHostAtomicCapabilities(
    uint32_t* capabilities, const rtAtomicOperation* operations, const uint32_t count, int32_t deviceId)
{
    ApiDeviceTopology* const apiDeviceTopologyInstance = ApiDeviceTopology::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiDeviceTopologyInstance);
    const rtError_t error =
        apiDeviceTopologyInstance->GetHostAtomicCapabilities(capabilities, operations, count, deviceId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDeviceGetP2PAtomicCapabilities(
    uint32_t* capabilities, const rtAtomicOperation* operations, const uint32_t count, int32_t srcDeviceId,
    int32_t dstDeviceId)
{
    ApiDeviceTopology* const apiDeviceTopologyInstance = ApiDeviceTopology::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiDeviceTopologyInstance);
    const rtError_t error =
        apiDeviceTopologyInstance->GetP2PAtomicCapabilities(capabilities, operations, count, srcDeviceId, dstDeviceId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDeviceGetPCIBusId(const int32_t devId, char* pciBusId, const int32_t len)
{
    ApiDeviceTopology* const apiDeviceTopologyInstance = ApiDeviceTopology::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiDeviceTopologyInstance);
    const rtError_t error = apiDeviceTopologyInstance->GetDevicePCIBusId(devId, pciBusId, len);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDeviceGetByPCIBusId(const char* pciBusId, int32_t* devId)
{
    ApiDeviceTopology* const apiDeviceTopologyInstance = ApiDeviceTopology::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiDeviceTopologyInstance);
    const rtError_t error = apiDeviceTopologyInstance->GetDeviceByPCIBusId(pciBusId, devId);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus
