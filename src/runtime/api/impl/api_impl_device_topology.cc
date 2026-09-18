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

#include <cstring>
#include <new>
#include <string>

#include "api_impl_creator.hpp"
#include "device_enum_desc.hpp"
#include "driver_enum_desc.hpp"
#include "error_message_manage.hpp"
#include "npu_driver.hpp"
#include "profiler_c.hpp"
#include "runtime.hpp"
#include "spec/base_info.hpp"

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

namespace {
rtError_t ValidateAtomicOperations(const rtAtomicOperation* const operations, const uint32_t count)
{
    for (uint32_t i = 0U; i < count; ++i) {
        COND_RETURN_AND_MSG_OUTER(
            (operations[i] < RT_ATOMIC_OPERATION_INTEGER_ADD) || (operations[i] > RT_ATOMIC_OPERATION_SIMD_SCALAR_EXCH),
            RT_ERROR_INVALID_VALUE, ErrorCode::EE1011, "Validating atomic operations",
            "UNKNOWN(" + std::to_string(static_cast<int32_t>(operations[i])) + ")",
            "operations[" + std::to_string(i) + "]",
            "the operation must be in [" + std::to_string(RT_ATOMIC_OPERATION_INTEGER_ADD) + ", " +
                std::to_string(RT_ATOMIC_OPERATION_SIMD_SCALAR_EXCH) + "]");
    }
    return RT_ERROR_NONE;
}

rtError_t GetAtomicDevProperties(uint32_t* const capabilities, const uint32_t count, DevProperties& prop)
{
    for (uint32_t i = 0U; i < count; ++i) {
        capabilities[i] = 0U;
    }
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    const rtError_t error = GET_DEV_PROPERTIES(chipType, prop);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE, "GetDevProperties fail");
    return RT_ERROR_NONE;
}

void FillAtomicCapabilities(
    uint32_t* const capabilities, const rtAtomicOperation* const operations, const uint32_t count,
    const uint32_t* const sourceCapabilities)
{
    for (uint32_t i = 0U; i < count; ++i) {
        if ((operations[i] >= 0) && (operations[i] < RT_ATOMIC_OPERATION_MAX_VAL)) {
            capabilities[i] = sourceCapabilities[operations[i]];
        }
    }
}

rtError_t CheckHostAtomicSupport(const int32_t deviceId, bool& supported)
{
    supported = false;
    Driver* const curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);

    int64_t topoType = 0;
    const rtError_t error = curDrv->GetDevInfo(
        static_cast<uint32_t>(deviceId), static_cast<int32_t>(MODULE_TYPE_SYSTEM),
        static_cast<int32_t>(INFO_TYPE_HD_CONNECT_TYPE), &topoType);
    if (error != RT_ERROR_NONE) {
        if (error == RT_ERROR_DRV_INPUT) {
            return RT_ERROR_NONE;
        }
        RT_LOG(RT_LOG_ERROR, "GetDevInfo fail, retCode=%#x", error);
        return error;
    }

    RT_LOG(RT_LOG_INFO, "the topoType=%ld", topoType);
    if (topoType != HOST_DEVICE_CONNECT_TYPE_UB) {
        RT_LOG(RT_LOG_INFO, "Atomic operations are not supported for topoType=%ld", topoType);
        return RT_ERROR_NONE;
    }
    supported = true;
    return RT_ERROR_NONE;
}

rtError_t CheckP2PAtomicSupport(const int32_t srcDeviceId, const int32_t dstDeviceId, bool& supported)
{
    supported = false;
    Driver* const curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);

    int64_t topoType = 0;
    const rtError_t error = curDrv->GetPairDevicesInfo(
        static_cast<uint32_t>(srcDeviceId), static_cast<uint32_t>(dstDeviceId),
        static_cast<int32_t>(DEVS_INFO_TYPE_TOPOLOGY), &topoType);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "GetPairDevicesInfo fail, retCode=%#x", error);
        return error;
    }

    RT_LOG(RT_LOG_INFO, "the topoType=%ld", topoType);
    if ((topoType != TOPOLOGY_HCCS) && (topoType != TOPOLOGY_SIO) && (topoType != TOPOLOGY_HCCS_SW) &&
        (topoType != TOPOLOGY_UB)) {
        RT_LOG(RT_LOG_INFO, "Atomic operations are not supported for topoType=%ld", topoType);
        return RT_ERROR_NONE;
    }
    supported = true;
    return RT_ERROR_NONE;
}

} // namespace

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

rtError_t ApiImplDeviceTopology::GetDeviceCount(int32_t* const cnt)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(cnt, RT_ERROR_INVALID_VALUE, "Obtaining the number of devices");
    return Runtime::Instance()->GetDeviceCount(cnt);
}

rtError_t ApiImplDeviceTopology::GetDevicePhyIdByIndex(const uint32_t devIndex, uint32_t* const phyId)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        phyId, RT_ERROR_INVALID_VALUE, "Querying the physical ID of a device based on its logical ID");
    uint32_t realDeviceId = 0U;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devIndex, &realDeviceId);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to convert the user device ID %u to driver device ID.", devIndex);
    // the api use before setdevice, so it do not need context
    RT_LOG(RT_LOG_INFO, "get PhyId by Index=%u.", realDeviceId);
    error = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER)->GetDevicePhyIdByIndex(realDeviceId, phyId);
    ERROR_RETURN(error, "Get device physical id by index failed, index=%u.", devIndex);
    return error;
}

rtError_t ApiImplDeviceTopology::GetDeviceIndexByPhyId(const uint32_t phyId, uint32_t* const devIndex)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        devIndex, RT_ERROR_INVALID_VALUE, "Querying the logical ID of a device based on its physical ID");

    uint32_t realDeviceId = 0U;
    rtError_t error = RT_ERROR_NONE;
    do {
        // the api use before setdevice, so it do not need context
        RT_LOG(RT_LOG_INFO, "get Index by PhyId=%u.", phyId);
        error = Runtime::Instance()->CheckCurCtxValid(static_cast<int32_t>(phyId));
        if (unlikely(error != RT_ERROR_NONE)) {
            RT_LOG(RT_LOG_ERROR, "Current Context is null, phyId[%d].", phyId);
            error = RT_ERROR_CONTEXT_NULL;
            break;
        }
        error = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER)->GetDeviceIndexByPhyId(phyId, &realDeviceId);
        if (unlikely(error != RT_ERROR_NONE)) {
            RT_LOG_INNER_MSG(
                RT_LOG_ERROR, "GetDeviceIndexByPhyId failed, phyId = %u, retCode=%#x.", phyId,
                static_cast<uint32_t>(error));
            break;
        }
    } while (false);

    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Get device index by physical id failed, phyId:%u, realDeviceId=%u", phyId, realDeviceId);
        return error;
    }
    error = Runtime::Instance()->GetUserDevIdByDeviceId(realDeviceId, devIndex);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error,
        "Failed to convert the driver device ID %u to user device ID, phyId=%u, retCode=%#x", realDeviceId, phyId,
        static_cast<uint32_t>(error));
    RT_LOG(RT_LOG_DEBUG, "realDeviceId:%u, phyId=%u, devIndex=%u.", realDeviceId, phyId, *devIndex);
    return RT_ERROR_NONE;
}

rtError_t ApiImplDeviceTopology::GetLogicDevIdByUserDevId(const int32_t userDevId, int32_t* const logicDevId)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        (userDevId < 0), RT_ERROR_DEVICE_ID, "Obtaining the logical device ID based on the user device ID", userDevId,
        "greater than or equal to 0");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        logicDevId, RT_ERROR_INVALID_VALUE, "Obtaining the logical device ID based on the user device ID");

    Runtime* const rt = Runtime::Instance();
    rt->CallApiBegin(RT_PROF_API_USER_TO_LOGIC_ID);

    int32_t realDeviceId = 0;
    rtError_t error = RT_ERROR_NONE;
    do {
        error = rt->ChgUserDevIdToDeviceId(static_cast<uint32_t>(userDevId), RtPtrToPtr<uint32_t*>(&realDeviceId));
        if (unlikely(error != RT_ERROR_NONE)) {
            RT_LOG(RT_LOG_ERROR, "Failed to convert the user device ID %d to driver device ID.", userDevId);
            break;
        }
    } while (false);

    rt->CallApiEnd(error);

    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Get logicDevId failed.");
    error = rt->CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "logicDevId is invalid, devId=%d, retCode=%#x", realDeviceId,
        static_cast<uint32_t>(error));
    *logicDevId = realDeviceId;
    return RT_ERROR_NONE;
}

rtError_t ApiImplDeviceTopology::GetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t* const userDevId)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        (logicDevId < 0), RT_ERROR_DEVICE_ID, "Obtaining the user device ID based on the logical device ID", logicDevId,
        "greater than or equal to 0");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        userDevId, RT_ERROR_INVALID_VALUE, "Obtaining the user device ID based on the logical device ID");

    Runtime* const rt = Runtime::Instance();
    rtError_t error = rt->CheckDeviceIdIsValid(logicDevId);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "logicDevId is invalid, devId=%d, retCode=%#x", logicDevId,
        static_cast<uint32_t>(error));

    rt->CallApiBegin(RT_PROF_API_LOGIC_TO_USER_ID);

    do {
        int32_t realDeviceId = 0;
        error = rt->GetUserDevIdByDeviceId(static_cast<uint32_t>(logicDevId), RtPtrToPtr<uint32_t*>(&realDeviceId));
        if (unlikely(error != RT_ERROR_NONE)) {
            RT_LOG_INNER_MSG(
                RT_LOG_ERROR, "Failed to convert the driver device ID %u to user device ID, retCode=%#x", logicDevId,
                static_cast<uint32_t>(error));
            break;
        }
        *userDevId = realDeviceId;
    } while (false);

    rt->CallApiEnd(error);
    return error;
}

rtError_t ApiImplDeviceTopology::GetDeviceUuid(const int32_t devId, rtUuid_t* const uuid)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        (devId < 0), RT_ERROR_DEVICE_ID, "Obtaining the device UUID", devId, "greater than or equal to 0");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(uuid, RT_ERROR_INVALID_VALUE, "Obtaining the device UUID");
    int32_t drvDeviceId = 0;
    rtError_t error =
        Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId), RtPtrToPtr<uint32_t*>(&drvDeviceId));
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to convert the user device ID %d to driver device ID.", devId);
    error = Runtime::Instance()->CheckDeviceIdIsValid(drvDeviceId);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "drvDeviceId is invalid, drvDeviceId=%d, ErrorCode=%#x", drvDeviceId,
        static_cast<uint32_t>(error));
    RT_LOG(RT_LOG_DEBUG, "Get device uuid, drv devId=%d.", drvDeviceId);
    int32_t drvRetUuidSize = RT_NPU_UUID_LENGTH;
    return NpuDriver::GetDeviceInfoByBuff(
        static_cast<uint32_t>(drvDeviceId), MODULE_TYPE_SYSTEM, INFO_TYPE_UUID, uuid->bytes, &drvRetUuidSize);
}

rtError_t ApiImplDeviceTopology::GetHostAtomicCapabilities(
    uint32_t* const capabilities, const rtAtomicOperation* const operations, const uint32_t count,
    const int32_t deviceId)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        capabilities, RT_ERROR_INVALID_VALUE,
        "Querying details about the atomic operations supported between a specified device and the host");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        operations, RT_ERROR_INVALID_VALUE,
        "Querying details about the atomic operations supported between a specified device and the host");
    ZERO_RETURN_AND_MSG_OUTER_WITH_FUNC_DESC(
        count, "Querying details about the atomic operations supported between a specified device and the host");

    Runtime* const rt = Runtime::Instance();
    int32_t realDeviceId;
    rtError_t error =
        rt->ChgUserDevIdToDeviceId(static_cast<uint32_t>(deviceId), RtPtrToPtr<uint32_t*>(&realDeviceId), true);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, RT_ERROR_DEVICE_ID, "Failed to convert the user device ID %d to driver device ID.",
        deviceId);
    error = rt->CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "drv devId is invalid, drv devId=%d, retCode=%#x", realDeviceId,
        static_cast<uint32_t>(error));
    error = ValidateAtomicOperations(operations, count);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "validate atomic operations failed, retCode=%#x", static_cast<uint32_t>(error));

    rt->CallApiBegin(RT_PROF_API_GET_HOST_ATOMIC_CAPABILITIES);

    do {
        DevProperties prop;
        error = GetAtomicDevProperties(capabilities, count, prop);
        if (error != RT_ERROR_NONE) {
            break;
        }

        bool supported = false;
        error = CheckHostAtomicSupport(realDeviceId, supported);
        if (error != RT_ERROR_NONE) {
            break;
        }

        if (supported) {
            FillAtomicCapabilities(capabilities, operations, count, prop.hostAtomicCapabilities.data());
        }
    } while (false);

    rt->CallApiEnd(error, static_cast<uint32_t>(realDeviceId));
    return error;
}

rtError_t ApiImplDeviceTopology::GetP2PAtomicCapabilities(
    uint32_t* const capabilities, const rtAtomicOperation* const operations, const uint32_t count,
    const int32_t srcDeviceId, const int32_t dstDeviceId)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        capabilities, RT_ERROR_INVALID_VALUE, "Querying details about the atomic operations supported between devices");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        operations, RT_ERROR_INVALID_VALUE, "Querying details about the atomic operations supported between devices");
    ZERO_RETURN_AND_MSG_OUTER_WITH_FUNC_DESC(
        count, "Querying details about the atomic operations supported between devices");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        srcDeviceId == dstDeviceId, RT_ERROR_DEVICE_ID,
        "Querying details about the atomic operations supported between devices", srcDeviceId,
        "srcDeviceId must be different from dstDeviceId");

    Runtime* const rt = Runtime::Instance();
    int32_t realSrcDeviceId;
    rtError_t error =
        rt->ChgUserDevIdToDeviceId(static_cast<uint32_t>(srcDeviceId), RtPtrToPtr<uint32_t*>(&realSrcDeviceId), true);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, RT_ERROR_DEVICE_ID, "Failed to convert the user device ID %d to driver device ID.",
        srcDeviceId);
    error = rt->CheckDeviceIdIsValid(realSrcDeviceId);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "drv devId is invalid, drv devId=%d, retCode=%#x", realSrcDeviceId,
        static_cast<uint32_t>(error));

    int32_t realDstDeviceId;
    error =
        rt->ChgUserDevIdToDeviceId(static_cast<uint32_t>(dstDeviceId), RtPtrToPtr<uint32_t*>(&realDstDeviceId), true);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, RT_ERROR_DEVICE_ID, "Failed to convert the user device ID %d to driver device ID.",
        dstDeviceId);
    error = rt->CheckDeviceIdIsValid(realDstDeviceId);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "drv devId is invalid, drv devId=%d, retCode=%#x", realDstDeviceId,
        static_cast<uint32_t>(error));
    error = ValidateAtomicOperations(operations, count);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "validate atomic operations failed, retCode=%#x", static_cast<uint32_t>(error));

    rt->CallApiBegin(RT_PROF_API_GET_P2P_ATOMIC_CAPABILITIES);

    do {
        DevProperties prop;
        error = GetAtomicDevProperties(capabilities, count, prop);
        if (error != RT_ERROR_NONE) {
            break;
        }

        bool supported = false;
        error = CheckP2PAtomicSupport(realSrcDeviceId, realDstDeviceId, supported);
        if (error != RT_ERROR_NONE) {
            break;
        }

        if (supported) {
            FillAtomicCapabilities(capabilities, operations, count, prop.p2pAtomicCapabilities.data());
        }
    } while (false);

    rt->CallApiEnd(error, static_cast<uint32_t>(realSrcDeviceId));
    return error;
}

rtError_t ApiImplDeviceTopology::GetDevicePCIBusId(const int32_t devId, char* const pciBusId, const int32_t len)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        (devId < 0), RT_ERROR_DEVICE_ID, "Obtaining the device PCI bus id", devId, "greater than or equal to 0");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(pciBusId, RT_ERROR_INVALID_VALUE, "Obtaining the device PCI bus id");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        (len < static_cast<int32_t>(RT_PCI_BUS_ID_MIN_LEN)), RT_ERROR_INVALID_VALUE, "Obtaining the device PCI bus id",
        len, "greater than or equal to " + std::to_string(RT_PCI_BUS_ID_MIN_LEN));

    int32_t drvDeviceId = 0;
    rtError_t error =
        Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId), RtPtrToPtr<uint32_t*>(&drvDeviceId));
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to convert the user device ID %d to driver device ID.", devId);
    error = Runtime::Instance()->CheckDeviceIdIsValid(drvDeviceId);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "drvDeviceId is invalid, drvDeviceId=%d, ErrorCode=%#x", drvDeviceId,
        static_cast<uint32_t>(error));

    RT_LOG(RT_LOG_DEBUG, "Get device PCI bus id, drv devId=%d.", drvDeviceId);
    return NpuDriver::GetDevicePCIBusId(static_cast<uint32_t>(drvDeviceId), pciBusId, len);
}

rtError_t ApiImplDeviceTopology::GetDeviceByPCIBusId(const char* const pciBusId, int32_t* const devId)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(pciBusId, RT_ERROR_INVALID_VALUE, "Obtaining the device by PCI bus id");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(devId, RT_ERROR_INVALID_VALUE, "Obtaining the device by PCI bus id");
    RT_LOG(RT_LOG_DEBUG, "Get device by PCI bus id, pciBusId=%s.", pciBusId);

    Runtime* const rt = Runtime::Instance();
    uint32_t devCnt = rt->deviceCnt;
    if (devCnt == 0U) {
        FacadeDriver& curDrv = rt->FacadeDriver_();
        int32_t drvDeviceCnt = 0;
        const rtError_t error = curDrv.GetDeviceCount(&drvDeviceCnt);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "GetDeviceCount failed, error=%#x.", static_cast<uint32_t>(error));
            return error;
        }
        devCnt = static_cast<uint32_t>(drvDeviceCnt);
    }
    for (uint32_t logicalDevId = 0U; logicalDevId < devCnt; ++logicalDevId) {
        char curBdf[RT_PCI_BUS_ID_MIN_LEN] = {0};
        rtError_t error = NpuDriver::GetDevicePCIBusId(logicalDevId, curBdf, static_cast<int32_t>(sizeof(curBdf)));
        if (error != RT_ERROR_NONE) {
            RT_LOG(
                RT_LOG_DEBUG, "GetDevicePCIBusId failed for logicalDevId=%u, error=%#x.", logicalDevId,
                static_cast<uint32_t>(error));
            continue;
        }
        if (strcmp(pciBusId, curBdf) == 0) {
            error = rt->GetUserDevIdByDeviceId(logicalDevId, reinterpret_cast<uint32_t*>(devId));
            if (error != RT_ERROR_NONE) {
                RT_LOG(
                    RT_LOG_ERROR, "GetUserDevIdByDeviceId failed for logicalDevId=%u, error=%#x.", logicalDevId,
                    static_cast<uint32_t>(error));
                return error;
            }
            return RT_ERROR_NONE;
        }
    }
    RT_LOG(RT_LOG_ERROR, "No device matched PCI bus id: %s.", pciBusId);
    RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
        ErrorCode::EE1003, "Obtaining the device by PCI bus id", std::string(pciBusId), "pciBusId",
        "a valid PCI bus id string (e.g., 0000:86:00.0)");
    return RT_ERROR_INVALID_VALUE;
}
} // namespace runtime
} // namespace cce
