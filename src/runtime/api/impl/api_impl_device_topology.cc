/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl_device_topology.hpp"

#include <new>
#include <string>

#include "api_impl_creator.hpp"
#include "context.hpp"
#include "error_message_manage.hpp"
#include "heterogenous.h"
#include "npu_driver.hpp"
#include "runtime.hpp"

namespace cce {
namespace runtime {

bool IsImplDeviceTopologySupported() { return true; }

ApiDeviceTopology* CreateImplDeviceTopologyAndGet()
{
    ApiDeviceTopology* const apiImplDeviceTopology = new (std::nothrow) ApiImplDeviceTopology();
    if (apiImplDeviceTopology == nullptr) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, sizeof(ApiImplDeviceTopology), "new");
        RT_LOG(RT_LOG_ERROR, "create ApiImplDeviceTopology failed.");
        return nullptr;
    }
    RT_LOG(RT_LOG_INFO, "ApiImplDeviceTopology:Runtime_alloc_size %zu", sizeof(ApiImplDeviceTopology));
    return apiImplDeviceTopology;
}

void DestroyImplDeviceTopology(ApiDeviceTopology*& apiImplDeviceTopology)
{
    delete apiImplDeviceTopology;
    apiImplDeviceTopology = nullptr;
}

rtError_t ApiImplDeviceTopology::EnableP2P(const uint32_t devIdDes, const uint32_t phyIdSrc, const uint32_t flag)
{
    uint32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devIdDes, &realDeviceId);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to convert the user device ID %u to driver device ID.", devIdDes);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        realDeviceId >= RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE, "Enabling inter-device memory copy", realDeviceId,
        "[0, " + std::to_string(RT_MAX_DEV_NUM) + ")");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        phyIdSrc >= RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE, "Enabling inter-device memory copy", phyIdSrc,
        "[0, " + std::to_string(RT_MAX_DEV_NUM) + ")");

    RT_LOG(RT_LOG_INFO, "Enable P2P drv devId=%u, phyIdSrc=%u.", realDeviceId, phyIdSrc);
    error = NpuDriver::EnableP2P(realDeviceId, phyIdSrc, flag);
    ERROR_RETURN(error, "Enable P2P failed, devIdDes=%u, phyIdSrc=%u.", devIdDes, phyIdSrc);
    return error;
}

rtError_t ApiImplDeviceTopology::DisableP2P(const uint32_t devIdDes, const uint32_t phyIdSrc)
{
    uint32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devIdDes, &realDeviceId);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to convert the user device ID %u to driver device ID.", devIdDes);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        realDeviceId >= RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE, "Disabling inter-device memory copy", realDeviceId,
        "[0, " + std::to_string(RT_MAX_DEV_NUM) + ")");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        phyIdSrc >= RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE, "Disabling inter-device memory copy", phyIdSrc,
        "[0, " + std::to_string(RT_MAX_DEV_NUM) + ")");

    RT_LOG(RT_LOG_INFO, "Disable P2P drv devId=%u, phyIdSrc=%u.", realDeviceId, phyIdSrc);
    error = NpuDriver::DisableP2P(realDeviceId, phyIdSrc);
    ERROR_RETURN(error, "Disable P2P failed, dest deviceId=%u, src phyId=%u.", devIdDes, phyIdSrc);
    return error;
}

rtError_t ApiImplDeviceTopology::DeviceCanAccessPeer(
    int32_t* const canAccessPeer, const uint32_t devId, const uint32_t peerDevice)
{
    uint32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devId, &realDeviceId);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to convert the user device ID %u to driver device ID.", devId);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        realDeviceId >= RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE,
        "Checking whether data exchange is supported between devices", realDeviceId,
        "[0, " + std::to_string(RT_MAX_DEV_NUM) + ")");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        canAccessPeer, RT_ERROR_INVALID_VALUE, "Checking whether data exchange is supported between devices");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        peerDevice >= RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE,
        "Checking whether data exchange is supported between devices", peerDevice,
        "[0, " + std::to_string(RT_MAX_DEV_NUM) + ")");

    do {
        RT_LOG(RT_LOG_INFO, "DeviceCanAccessPeer drv devId=%u, peerDevice=%u.", realDeviceId, peerDevice);
        const Runtime* const rtInstance = Runtime::Instance();
        const rtChipType_t chipType = rtInstance->GetChipType();
        if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DEVICE_P2P)) {
            UNUSED(realDeviceId);
            UNUSED(peerDevice);
            error = RT_ERROR_FEATURE_NOT_SUPPORT;
            break;
        }

        const rtRunMode runMode = static_cast<rtRunMode>(NpuDriver::RtGetRunMode());
        if (runMode == RT_RUN_MODE_OFFLINE) {
            RT_LOG(
                RT_LOG_ERROR, "This feature is not supported in offline mode, drv devId=%u, peer=%u", realDeviceId,
                peerDevice);
            error = RT_ERROR_FEATURE_NOT_SUPPORT;
            break;
        }

        error = Runtime::Instance()->CheckCurCtxValid(static_cast<int32_t>(realDeviceId));
        if (unlikely(error != RT_ERROR_NONE)) {
            RT_LOG(RT_LOG_ERROR, "Current Context is null, drv devId[%lu].", realDeviceId);
            error = RT_ERROR_CONTEXT_NULL;
            break;
        }
        error = NpuDriver::DeviceCanAccessPeer(canAccessPeer, realDeviceId, peerDevice);
    } while (false);

    ERROR_RETURN(error, "Device can access peer failed, devId=%u, peerDevice=%u.", devId, peerDevice);
    return error;
}

rtError_t ApiImplDeviceTopology::GetP2PStatus(const uint32_t devIdDes, const uint32_t phyIdSrc, uint32_t* const status)
{
    uint32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devIdDes, &realDeviceId);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to convert the user device ID %u to driver device ID.", devIdDes);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        realDeviceId >= RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE, "Obtaining the P2P status", realDeviceId,
        "[0, " + std::to_string(RT_MAX_DEV_NUM) + ")");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        phyIdSrc >= RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE, "Obtaining the P2P status", phyIdSrc,
        "[0, " + std::to_string(RT_MAX_DEV_NUM) + ")");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(status, RT_ERROR_INVALID_VALUE, "Obtaining the P2P status");

    do {
        RT_LOG(RT_LOG_INFO, "drv devId=%u, phyIdSrc=%u.", realDeviceId, phyIdSrc);
        error = Runtime::Instance()->CheckCurCtxValid(static_cast<int32_t>(realDeviceId));
        if (unlikely(error != RT_ERROR_NONE)) {
            RT_LOG(RT_LOG_ERROR, "Current Context is null, drv devId[%lu].", realDeviceId);
            error = RT_ERROR_CONTEXT_NULL;
            break;
        }
        error = NpuDriver::GetP2PStatus(realDeviceId, phyIdSrc, status);
    } while (false);

    ERROR_RETURN(error, "Get P2P status failed, dest devId=%u, src phyId=%u.", devIdDes, phyIdSrc);
    return error;
}

rtError_t ApiImplDeviceTopology::GetPairDevicesInfo(
    const uint32_t devId, const uint32_t otherDevId, const int32_t infoType, int64_t* const val)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        val, RT_ERROR_INVALID_VALUE, "Querying the pairing information between two logical devices");
    uint32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devId, &realDeviceId);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to convert the user device ID %u to driver device ID.", devId);
    uint32_t readOtherDeviceId;
    error = Runtime::Instance()->ChgUserDevIdToDeviceId(otherDevId, &readOtherDeviceId);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to convert the user device ID %u to driver device ID.", otherDevId);

    Driver* const curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
    rtError_t ret = curDrv->GetPairDevicesInfo(realDeviceId, readOtherDeviceId, infoType, val);
    if (infoType == DEVS_INFO_TYPE_TOPOLOGY && *val == TOPOLOGY_HCCS_SW && realDeviceId == readOtherDeviceId) {
        *val = TOPOLOGY_HCCS;
    }
    return ret;
}

rtError_t ApiImplDeviceTopology::GetPairPhyDevicesInfo(
    const uint32_t devId, const uint32_t otherDevId, const int32_t infoType, int64_t* const val)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        val, RT_ERROR_INVALID_VALUE, "Querying the pairing information between two physical devices");
    RT_LOG(
        RT_LOG_INFO, "input physical devId=%u, input physical otherDevId=%u, infoType=%d", devId, otherDevId, infoType);

    Driver* const curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
    const rtError_t ret = curDrv->GetPairDevicesInfo(devId, otherDevId, infoType, val, true);
    if (infoType == DEVS_INFO_TYPE_TOPOLOGY && *val == TOPOLOGY_HCCS_SW && devId == otherDevId) {
        *val = TOPOLOGY_HCCS;
    }
    return ret;
}

} // namespace runtime
} // namespace cce
