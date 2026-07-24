/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_PACKAGE_SENDER_H
#define TSD_PACKAGE_SENDER_H

#include "device_comm_agent.h"
#include "capability_manager.h"
#include "package_env_info.h"
#include "package_hash_store.h"
#include "hdc_message_builder.h"
#include "proto/tsd_message.pb.h"
#include "basic_define.h"

#include <string>
#include <functional>

namespace tsd {

class PackageManager;

class PackageSender {
public:
    PackageSender(
        PackageManager& mgr, DeviceCommAgent& commAgent, CapabilityManager& capabilityMgr, PackageEnvInfo& envInfo,
        PackageHashStore& hashStore, bool& deviceIdle, bool& getCheckCodeRetrySupport);
    ~PackageSender() = default;

    TSD_StatusT SendAICPUPackage(const int32_t peerNode, const std::string& path);
    TSD_StatusT SendAICPUPackageSimple(
        const int32_t peerNode, const std::string& orgFile, const std::string& dstFile, bool useCannPath);
    TSD_StatusT SendHostPackageComplex(
        const int32_t peerNode, const std::string& orgFile, const std::string& dstFile, HDCMessage& msg,
        const std::function<bool(void)>& compareCallBack, bool useCannPath);
    TSD_StatusT SendMsgAndHostPackage(
        const int32_t peerNode, const std::string& orgFile, const std::string& dstFile, HDCMessage& msg,
        const std::function<bool(void)>& compareCallBack, bool useCannPath);
    TSD_StatusT SendCommonPackage(const int32_t peerNode, const std::string& path, const uint32_t packageType);
    TSD_StatusT SendFileToDevice(
        const char_t* const filePath, const uint64_t pathLen, const char_t* const fileName, const uint64_t fileNameLen,
        const bool addPreFix = false);
    TSD_StatusT CompareAndSendCommonSinkPkg(
        const std::string& pkgPureName, const std::string& hostPkgHash, const int32_t peerNode,
        const std::string& orgFile, const std::string& dstFile);

private:
    PackageManager& mgr_;
    DeviceCommAgent& commAgent_;
    CapabilityManager& capabilityMgr_;
    PackageEnvInfo& envInfo_;
    PackageHashStore& hashStore_;
    bool& deviceIdle_;
    bool& getCheckCodeRetrySupport_;
};

} // namespace tsd

#endif // TSD_PACKAGE_SENDER_H
