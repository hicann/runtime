/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_DEVICE_TOPOLOGY_HPP
#define CCE_RUNTIME_API_DEVICE_TOPOLOGY_HPP

#include "base.hpp"

namespace cce {
namespace runtime {

class ApiDeviceTopology {
public:
    ApiDeviceTopology() = default;
    virtual ~ApiDeviceTopology() = default;

    ApiDeviceTopology(const ApiDeviceTopology&) = delete;
    ApiDeviceTopology& operator=(const ApiDeviceTopology&) = delete;
    ApiDeviceTopology(ApiDeviceTopology&&) = delete;
    ApiDeviceTopology& operator=(ApiDeviceTopology&&) = delete;

    static ApiDeviceTopology* Instance();

    virtual rtError_t EnableP2P(const uint32_t devIdDes, const uint32_t phyIdSrc, const uint32_t flag) = 0;
    virtual rtError_t DisableP2P(const uint32_t devIdDes, const uint32_t phyIdSrc) = 0;
    virtual rtError_t DeviceCanAccessPeer(
        int32_t* const canAccessPeer, const uint32_t devId, const uint32_t peerDevice) = 0;
    virtual rtError_t GetP2PStatus(const uint32_t devIdDes, const uint32_t phyIdSrc, uint32_t* const status) = 0;
    virtual rtError_t GetPairDevicesInfo(
        const uint32_t devId, const uint32_t otherDevId, const int32_t infoType, int64_t* const val) = 0;
    virtual rtError_t GetPairPhyDevicesInfo(
        const uint32_t devId, const uint32_t otherDevId, const int32_t infoType, int64_t* const val) = 0;
};

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_API_DEVICE_TOPOLOGY_HPP
