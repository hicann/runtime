/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "device_comm_agent.h"
#include "error_manager.h"
#include "tsd_log.h"
#include "tsd/status.h"
#include "tsd_util_func.h"

namespace tsd {
DeviceCommAgent::DeviceCommAgent(const uint32_t logicDeviceId) : logicDeviceId_(logicDeviceId) {}

DeviceCommAgent::~DeviceCommAgent() {}

TSD_StatusT DeviceCommAgent::InitTsdClient(bool isAdcEnv)
{
    isAdcEnv_ = isAdcEnv;
    if (devCommClient_ != nullptr) {
        TSD_INFO("[TsdClient] tsd client has already been initialized");
        return TSD_OK;
    }
    const drvError_t ret = drvGetProcessSign(&procSign_);
    if (ret != DRV_ERROR_NONE) {
        TSD_ERROR("driver get process sign failed. ret[%d].", ret);
        return TSD_CLT_OPEN_FAILED;
    }
    TSD_INFO(
        "[TsdClient][deviceId=%u] get process sign success, procPid[%u]", logicDeviceId_,
        static_cast<uint32_t>(procSign_.tgid));

    if (logicDeviceId_ >= MAX_DEVNUM_PER_HOST) {
        TSD_ERROR("[TsdClient] deviceId[%u] is not supported, not in [0-127] exit open function", logicDeviceId_);
        return TSD_DEVICEID_ERROR;
    }
    TSD_RUN_INFO("[TsdClient] deviceId[%u] begin to init hdc client", logicDeviceId_);
    devCommClient_ = DeviceComm::GetInstance(logicDeviceId_, DeviceCommType::HDC);
    if (devCommClient_ == nullptr) {
        TSD_ERROR("[TsdClient][deviceId=%u] devCommClient_ is null in Open function", logicDeviceId_);
        return TSD_INSTANCE_NOT_FOUND;
    }
    TSD_StatusT hdcRet = devCommClient_->CommInit(static_cast<uint32_t>(procSign_.tgid), isAdcEnv_);
    if (hdcRet != TSD_OK) {
        TSD_ERROR("[TsdClient][deviceId=%u] Init tsdclient failed in Open function", logicDeviceId_);
        ReleaseDeviceConnection();
        return hdcRet;
    }
    uint32_t sessionId = 0U;
    hdcRet = devCommClient_->CommCreateSession(sessionId);
    if (hdcRet != TSD_OK) {
        TSD_ERROR("[TsdClient][deviceId=%u]CreateSession for TSD failed in Open function", logicDeviceId_);
        if (hdcRet == DRV_ERROR_REPEATED_INIT) {
            REPORT_INPUT_ERROR("E39009", std::vector<std::string>(), std::vector<std::string>());
        } else if (hdcRet == DRV_ERROR_REMOTE_NOT_LISTEN) {
            REPORT_INPUT_ERROR("E39005", std::vector<std::string>(), std::vector<std::string>());
        }
        ReleaseDeviceConnection();
        return TSD_HDC_CREATE_SESSION_FAILED;
    }
    tsdSessionId_ = sessionId;
    return hdcRet;
}

TSD_StatusT DeviceCommAgent::SendMsg(const HDCMessage& msg)
{
    if (devCommClient_ == nullptr) {
        TSD_ERROR("[DeviceCommAgent] devCommClient_ is null, send msg failed.");
        return TSD_INSTANCE_NOT_INITIALED;
    }
    return devCommClient_->CommSendMsg(tsdSessionId_, msg);
}

TSD_StatusT DeviceCommAgent::RecvData(bool ignoreRecvErr, uint32_t timeout)
{
    if (devCommClient_ == nullptr) {
        return TSD_INSTANCE_NOT_INITIALED;
    }
    return devCommClient_->CommRecvData(tsdSessionId_, ignoreRecvErr, timeout);
}

TSD_StatusT DeviceCommAgent::GetHdcConctStatus(int32_t& sessStat, bool isAdcEnv)
{
    if (devCommClient_ != nullptr) {
        return devCommClient_->CommGetConctStatus(sessStat);
    }
    TSD_WARN("[DeviceCommAgent] devCommClient_ is null in get status function");
    if (isAdcEnv) {
        sessStat = HDC_SESSION_STATUS_CONNECT;
    } else {
        sessStat = HDC_SESSION_STATUS_CLOSE;
    }
    return TSD_OK;
}

TSD_StatusT DeviceCommAgent::GetVersionVerify(std::shared_ptr<VersionVerify>& inspector)
{
    if (devCommClient_ == nullptr) {
        return TSD_INSTANCE_NOT_INITIALED;
    }
    return devCommClient_->CommGetVersionVerify(tsdSessionId_, inspector);
}

void DeviceCommAgent::ReleaseDeviceConnection()
{
    if (devCommClient_ != nullptr) {
        devCommClient_->CommDestroy();
        devCommClient_ = nullptr;
    }
}
} // namespace tsd
