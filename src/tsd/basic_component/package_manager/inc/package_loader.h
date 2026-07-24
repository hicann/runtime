/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_PACKAGE_LOADER_H
#define TSD_PACKAGE_LOADER_H

#include "device_comm_agent.h"
#include "capability_manager.h"
#include "package_env_info.h"
#include "package_hash_store.h"
#include "package_process_config.h"
#include "hdc_message_builder.h"
#include "proto/tsd_message.pb.h"
#include "basic_define.h"
#include "inc/client_manager.h"

#include <string>

namespace tsd {

class PackageManager;

class PackageLoader {
public:
    PackageLoader(
        PackageManager& mgr, DeviceCommAgent& commAgent, CapabilityManager& capabilityMgr, PackageEnvInfo& envInfo,
        PackageHashStore& hashStore, ResponseCode& pkgRspCode, std::string& loadPackageErrorMsg);
    ~PackageLoader() = default;

    TSD_StatusT LoadSysOpKernel();
    TSD_StatusT LoadRuntimePkgToDevice(const MessageContext& baseCtx);
    TSD_StatusT LoadCannHsPkgToDevice(const std::string& pkgPureName, const MessageContext& baseCtx);
    TSD_StatusT LoadFileAndWaitRsp(
        const std::string& pkgPureName, const std::string& hostPkgHash, const int32_t peerNode,
        const std::string& orgFile, const std::string& dstFile, const MessageContext& baseCtx);
    TSD_StatusT LoadDShapePkgToDevice(const MessageContext& baseCtx);
    TSD_StatusT LoadOmFileToDevice(
        const char_t* const filePath, const uint64_t pathLen, const char_t* const fileName, const uint64_t fileNameLen,
        const MessageContext& baseCtx);
    TSD_StatusT LoadFileToDevice(
        const char_t* const filePath, const uint64_t pathLen, const char_t* const fileName, const uint64_t fileNameLen,
        const MessageContext& baseCtx);
    bool IsOkToLoadFileToDevice(const char_t* const fileName, const uint64_t fileNameLen) const;
    TSD_StatusT LoadPackageConfigInfoToDevice(const bool hasPluginVersion);
    bool SupportLoadPkg(const std::string& pkgName) const;
    TSD_StatusT LoadSinglePackageToDevice(
        const std::string& pkgPureName, const PackConfDetail& detail, int32_t peerNode,
        const std::string& dstDirPreFix);
    void ReportSinkPkgRspError(const std::string& pkgPureName);
    TSD_StatusT LoadPackageToDeviceByConfig();

    void Reset();

    bool aicpuPackageExistInDevice_ = false;

private:
    TSD_StatusT LoadHsPkgToDevice(
        const std::string& pkgName, const std::string& subPath, TsdLoadPackageType pkgType, HDCMessage::MsgType msgType,
        const MessageContext& baseCtx);
    bool ShouldLoadLegacyPackage() const;
    TSD_StatusT SendAllPackagesToPeer();
    bool hasSendConfigFile_ = false;

    PackageManager& mgr_;
    DeviceCommAgent& commAgent_;
    CapabilityManager& capabilityMgr_;
    PackageEnvInfo& envInfo_;
    PackageHashStore& hashStore_;
    ResponseCode& pkgRspCode_;
    std::string& loadPackageErrorMsg_;
};

} // namespace tsd

#endif // TSD_PACKAGE_LOADER_H
