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
#include "package_context.h"
#include "hdc_message_builder.h"
#include "proto/tsd_message.pb.h"
#include "basic_define.h"

#include <string>

namespace tsd {

class PackageCheckCodeService {
public:
    PackageCheckCodeService(
        DeviceCommAgent& commAgent, CapabilityManager& capabilityMgr, PackageEnvInfo& envInfo,
        PackageHashStore& hashStore, PackageContext& ctx);
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
    uint32_t GetHostCheckCode(TsdLoadPackageType type) const { return ctx_.hostCheckCode[static_cast<uint32_t>(type)]; }
    uint32_t GetPeerCheckCode(uint32_t type) const { return ctx_.peerCheckCode[type]; }
    void SetPeerCheckCode(uint32_t type, uint32_t code) { ctx_.peerCheckCode[type] = code; }
    void SetHostCheckCodeByIndex(uint32_t type, uint32_t code) { ctx_.hostCheckCode[type] = code; }
    ResponseCode& GetPkgRspCode() { return ctx_.pkgRspCode; }
    const ResponseCode& GetPkgRspCode() const { return ctx_.pkgRspCode; }

private:
    void SetHostCheckCode(HDCMessage& msg, TsdLoadPackageType type);

    DeviceCommAgent& commAgent_;
    CapabilityManager& capabilityMgr_;
    PackageEnvInfo& envInfo_;
    PackageHashStore& hashStore_;
    PackageContext& ctx_;
};

} // namespace tsd

#endif // TSD_PACKAGE_CHECK_CODE_SERVICE_H
