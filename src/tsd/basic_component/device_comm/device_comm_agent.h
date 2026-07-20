/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_BASIC_COMPONENT_DEVICE_COMM_DEVICE_COMM_AGENT_H
#define TSD_BASIC_COMPONENT_DEVICE_COMM_DEVICE_COMM_AGENT_H

#include <memory>
#include "device_comm.h"
#include "driver/ascend_hal.h"
#include "proto/tsd_message.pb.h"
#include "tsd/status.h"
#include "inc/tsd_version_verify.h"

namespace tsd {
class DeviceCommAgent {
public:
    explicit DeviceCommAgent(const uint32_t logicDeviceId);
    ~DeviceCommAgent();

    DeviceCommAgent(const DeviceCommAgent&) = delete;
    DeviceCommAgent& operator=(const DeviceCommAgent&) = delete;

    TSD_StatusT InitTsdClient(bool isAdcEnv);
    TSD_StatusT SendMsg(const HDCMessage& msg);
    TSD_StatusT RecvData(bool ignoreRecvErr = false, uint32_t timeout = 0U);
    TSD_StatusT GetHdcConctStatus(int32_t& sessStat, bool isAdcEnv);
    TSD_StatusT GetVersionVerify(std::shared_ptr<VersionVerify>& inspector);
    void ReleaseDeviceConnection();

    std::shared_ptr<DeviceComm> GetDeviceComm() const { return devCommClient_; }
    uint32_t GetSessionId() const { return tsdSessionId_; }
    bool IsInit() const { return devCommClient_ != nullptr; }
    const process_sign& GetProcSign() const { return procSign_; }

private:
    uint32_t logicDeviceId_;
    bool isAdcEnv_ = false;
    std::shared_ptr<DeviceComm> devCommClient_ = nullptr;
    uint32_t tsdSessionId_ = 0;
    process_sign procSign_ = {};
};
} // namespace tsd
#endif // TSD_BASIC_COMPONENT_DEVICE_COMM_DEVICE_COMM_AGENT_H
