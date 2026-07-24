/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_PACKAGE_CHECK_CODE_SERVICE_H
#define TSD_PACKAGE_CHECK_CODE_SERVICE_H

#include "device_comm_agent.h"
#include "capability_manager.h"
#include "package_env_info.h"
#include "package_hash_store.h"
#include "hdc_message_builder.h"
#include "proto/tsd_message.pb.h"
#include "basic_define.h"
#include "inc/client_manager.h"

#include <string>

namespace tsd {

class PackageManager;

class PackageCheckCodeService {
public:
    PackageCheckCodeService(
        PackageManager& mgr, DeviceCommAgent& commAgent, CapabilityManager& capabilityMgr, PackageEnvInfo& envInfo,
        PackageHashStore& hashStore, ResponseCode& pkgRspCode, bool& getCheckCodeRetrySupport,
        std::string& loadPackageErrorMsg);
    ~PackageCheckCodeService() = default;

    TSD_StatusT InitTsdClient();
    TSD_StatusT WaitPkgRsp(const uint32_t timeout, const bool ignoreRecvErr = false);
    TSD_StatusT GetDeviceCheckCode();
    TSD_StatusT GetDeviceCheckCodeOnce(const HDCMessage& msg);
    TSD_StatusT GetDeviceCheckCodeRetry(const HDCMessage& msg);
    void GetDeviceCheckCodeRetrySupport();
    TSD_StatusT PrepareForCheckCode();
    TSD_StatusT GetDeviceHsPkgCheckCode(
        const uint32_t checkCode, const HDCMessage::MsgType msgType, const bool beforeSendFlag,
        const MessageContext& baseCtx);
    TSD_StatusT GetCannHsPkgCheckCode(
        const std::string& pkgPureName, const std::string& hostPkgHash, const MessageContext& baseCtx);
    void HandleNormalPackageCheckCodeRsp(const HDCMessage& msg);
    void HandleCannHsCheckCodeRsp(const HDCMessage& msg);
    void SaveDeviceCheckCode(const HDCMessage& msg);
    uint32_t GetHostCheckCode(TsdLoadPackageType type) const { return hostCheckCode_[static_cast<uint32_t>(type)]; }

    uint32_t peerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_MAX)];
    uint32_t hostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_MAX)];
    ResponseCode& pkgRspCode_;

private:
    void SetHostCheckCode(HDCMessage& msg, TsdLoadPackageType type);

    PackageManager& mgr_;
    DeviceCommAgent& commAgent_;
    CapabilityManager& capabilityMgr_;
    PackageEnvInfo& envInfo_;
    PackageHashStore& hashStore_;
    bool& getCheckCodeRetrySupport_;
    std::string& loadPackageErrorMsg_;
};

} // namespace tsd

#endif // TSD_PACKAGE_CHECK_CODE_SERVICE_H
