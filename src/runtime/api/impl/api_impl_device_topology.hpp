/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_IMPL_DEVICE_TOPOLOGY_HPP
#define CCE_RUNTIME_API_IMPL_DEVICE_TOPOLOGY_HPP

#include "api_device_topology.hpp"

namespace cce {
namespace runtime {

class ApiImplDeviceTopology : public ApiDeviceTopology {
public:
    rtError_t EnableP2P(const uint32_t devIdDes, const uint32_t phyIdSrc, const uint32_t flag) override;
    rtError_t DisableP2P(const uint32_t devIdDes, const uint32_t phyIdSrc) override;
    rtError_t DeviceCanAccessPeer(
        int32_t* const canAccessPeer, const uint32_t devId, const uint32_t peerDevice) override;
    rtError_t GetP2PStatus(const uint32_t devIdDes, const uint32_t phyIdSrc, uint32_t* const status) override;
    rtError_t GetPairDevicesInfo(
        const uint32_t devId, const uint32_t otherDevId, const int32_t infoType, int64_t* const val) override;
    rtError_t GetPairPhyDevicesInfo(
        const uint32_t devId, const uint32_t otherDevId, const int32_t infoType, int64_t* const val) override;
    rtError_t GetDeviceCount(int32_t* const cnt) override;
    rtError_t GetDevicePhyIdByIndex(const uint32_t devIndex, uint32_t* const phyId) override;
    rtError_t GetDeviceIndexByPhyId(const uint32_t phyId, uint32_t* const devIndex) override;
    rtError_t GetLogicDevIdByUserDevId(const int32_t userDevId, int32_t* const logicDevId) override;
    rtError_t GetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t* const userDevId) override;
    rtError_t GetDeviceUuid(const int32_t devId, rtUuid_t* const uuid) override;
    rtError_t GetDevicePCIBusId(const int32_t devId, char* const pciBusId, const int32_t len) override;
    rtError_t GetDeviceByPCIBusId(const char* const pciBusId, int32_t* const devId) override;
    rtError_t GetHostAtomicCapabilities(
        uint32_t* const capabilities, const rtAtomicOperation* const operations, const uint32_t count,
        const int32_t deviceId) override;
    rtError_t GetP2PAtomicCapabilities(
        uint32_t* const capabilities, const rtAtomicOperation* const operations, const uint32_t count,
        const int32_t srcDeviceId, const int32_t dstDeviceId) override;
};

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_API_IMPL_DEVICE_TOPOLOGY_HPP
