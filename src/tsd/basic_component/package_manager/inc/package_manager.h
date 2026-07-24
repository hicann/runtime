/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef INNER_INC_PACKAGE_MANAGER_H
#define INNER_INC_PACKAGE_MANAGER_H

#include "capability_manager.h"
#include "device_comm_agent.h"
#include "package_env_info.h"
#include "package_hash_store.h"
#include "package_process_config.h"
#include "plugin_pkg_version.h"
#include "plugin_version_manager.h"
#include "package_sender.h"
#include "package_check_code_service.h"
#include "package_loader.h"
#include "hdc_message_builder.h"
#include "driver/ascend_hal.h"
#include "proto/tsd_message.pb.h"
#include "basic_define.h"

#include <map>
#include <string>
#include <functional>

namespace tsd {

class PackageManager {
public:
    PackageManager(
        uint32_t logicDeviceId, DeviceCommAgent& commAgent, CapabilityManager& capabilityMgr, uint32_t platInfoMode,
        bool isAdcEnv, uint32_t chipType);
    ~PackageManager();

    // === Open 流程入口 ===
    TSD_StatusT LoadPackageConfigInfoToDevice(const bool hasPluginVersion)
    {
        return loader_.LoadPackageConfigInfoToDevice(hasPluginVersion);
    }
    TSD_StatusT LoadSysOpKernel() { return loader_.LoadSysOpKernel(); }
    TSD_StatusT LoadPackageToDeviceByConfig() { return loader_.LoadPackageToDeviceByConfig(); }

    TSD_StatusT LoadFileToDevice(
        const char_t* const filePath, const uint64_t pathLen, const char_t* const fileName, const uint64_t fileNameLen,
        const MessageContext& baseCtx)
    {
        return loader_.LoadFileToDevice(filePath, pathLen, fileName, fileNameLen, baseCtx);
    }

    // === 设备响应处理（由 ProcessModeManager 静态回调转发）===
    void SaveDeviceCheckCode(const HDCMessage& msg) { checkCodeSvc_.SaveDeviceCheckCode(msg); }
    void StoreAllPkgHashValue(const HDCMessage& msg) { hashStore_.StoreAllPkgHashValue(msg); }

    // === 状态管理 ===
    void ResetOnClose();
    bool IsAicpuPackageExistInDevice() const { return loader_.aicpuPackageExistInDevice_; }
    void SetAicpuPackageExistInDevice(bool val) { loader_.aicpuPackageExistInDevice_ = val; }
    uint32_t GetHostCheckCode(TsdLoadPackageType type) const { return checkCodeSvc_.GetHostCheckCode(type); }
    void GetAscendLatestIntallPath(std::string& pkgBasePath) const { envInfo_.GetAscendLatestIntallPath(pkgBasePath); }

    // === 包扫描 ===
    bool CheckPackageExists(const bool loadAicpuKernelFlag = true)
    {
        return envInfo_.CheckPackageExists(loadAicpuKernelFlag);
    }

    bool GetPackageTitle(std::string& packageTitle) const { return envInfo_.GetPackageTitle(packageTitle); }

    const std::string& GetPackageName(uint32_t type) const { return envInfo_.GetPackageName(type); }

    const std::string& GetPackagePath(uint32_t type) const { return envInfo_.GetPackagePath(type); }

    uint32_t GetPlatInfoMode() const { return envInfo_.GetPlatInfoMode(); }

    void SetPlatInfoMode(uint32_t mode) { envInfo_.SetPlatInfoMode(mode); }
    bool IsAdcEnv() const { return envInfo_.IsAdcEnv(); }
    uint32_t GetPlatInfoChipType() const { return envInfo_.GetPlatInfoChipType(); }
    void SetPlatInfoChipType(uint32_t chipType) { envInfo_.SetPlatInfoChipType(chipType); }

    TSD_StatusT InitTsdClient() { return checkCodeSvc_.InitTsdClient(); }
    TSD_StatusT WaitPkgRsp(const uint32_t timeout, const bool ignoreRecvErr = false)
    {
        return checkCodeSvc_.WaitPkgRsp(timeout, ignoreRecvErr);
    }
    TSD_StatusT SendAICPUPackage(const int32_t peerNode, const std::string& path)
    {
        return sender_.SendAICPUPackage(peerNode, path);
    }
    TSD_StatusT SendAICPUPackageSimple(
        const int32_t peerNode, const std::string& orgFile, const std::string& dstFile, bool useCannPath)
    {
        return sender_.SendAICPUPackageSimple(peerNode, orgFile, dstFile, useCannPath);
    }
    TSD_StatusT SendHostPackageComplex(
        const int32_t peerNode, const std::string& orgFile, const std::string& dstFile, HDCMessage& msg,
        const std::function<bool(void)>& compareCallBack, bool useCannPath)

    {
        return sender_.SendHostPackageComplex(peerNode, orgFile, dstFile, msg, compareCallBack, useCannPath);
    }
    TSD_StatusT SendMsgAndHostPackage(
        const int32_t peerNode, const std::string& orgFile, const std::string& dstFile, HDCMessage& msg,
        const std::function<bool(void)>& compareCallBack, bool useCannPath)

    {
        return sender_.SendMsgAndHostPackage(peerNode, orgFile, dstFile, msg, compareCallBack, useCannPath);
    }
    TSD_StatusT SendCommonPackage(const int32_t peerNode, const std::string& path, const uint32_t packageType)

    {
        return sender_.SendCommonPackage(peerNode, path, packageType);
    }
    TSD_StatusT SendFileToDevice(
        const char_t* const filePath, const uint64_t pathLen, const char_t* const fileName, const uint64_t fileNameLen,
        const bool addPreFix = false)

    {
        return sender_.SendFileToDevice(filePath, pathLen, fileName, fileNameLen, addPreFix);
    }
    TSD_StatusT CompareAndSendCommonSinkPkg(
        const std::string& pkgPureName, const std::string& hostPkgHash, const int32_t peerNode,
        const std::string& orgFile, const std::string& dstFile)
    {
        return sender_.CompareAndSendCommonSinkPkg(pkgPureName, hostPkgHash, peerNode, orgFile, dstFile);
    }

    TSD_StatusT GetDeviceCheckCode() { return checkCodeSvc_.GetDeviceCheckCode(); }
    TSD_StatusT GetDeviceCheckCodeOnce(const HDCMessage& msg) { return checkCodeSvc_.GetDeviceCheckCodeOnce(msg); }
    TSD_StatusT GetDeviceCheckCodeRetry(const HDCMessage& msg) { return checkCodeSvc_.GetDeviceCheckCodeRetry(msg); }
    void GetDeviceCheckCodeRetrySupport() { checkCodeSvc_.GetDeviceCheckCodeRetrySupport(); }
    TSD_StatusT PrepareForCheckCode() { return checkCodeSvc_.PrepareForCheckCode(); }
    TSD_StatusT GetDeviceHsPkgCheckCode(
        const uint32_t checkCode, const HDCMessage::MsgType msgType, const bool beforeSendFlag,
        const MessageContext& baseCtx)
    {
        return checkCodeSvc_.GetDeviceHsPkgCheckCode(checkCode, msgType, beforeSendFlag, baseCtx);
    }
    TSD_StatusT GetCannHsPkgCheckCode(
        const std::string& pkgPureName, const std::string& hostPkgHash, const MessageContext& baseCtx)
    {
        return checkCodeSvc_.GetCannHsPkgCheckCode(pkgPureName, hostPkgHash, baseCtx);
    }

    TSD_StatusT LoadSinglePackageToDevice(
        const std::string& pkgPureName, const PackConfDetail& detail, int32_t peerNode, const std::string& dstDirPreFix)
    {
        return loader_.LoadSinglePackageToDevice(pkgPureName, detail, peerNode, dstDirPreFix);
    }

    TSD_StatusT LoadCannHsPkgToDevice(const std::string& pkgPureName, const MessageContext& baseCtx)

    {
        return loader_.LoadCannHsPkgToDevice(pkgPureName, baseCtx);
    }

    TSD_StatusT LoadFileAndWaitRsp(
        const std::string& pkgPureName, const std::string& hostPkgHash, const int32_t peerNode,
        const std::string& orgFile, const std::string& dstFile, const MessageContext& baseCtx)
    {
        return loader_.LoadFileAndWaitRsp(pkgPureName, hostPkgHash, peerNode, orgFile, dstFile, baseCtx);
    }

    TSD_StatusT LoadRuntimePkgToDevice(const MessageContext& baseCtx)
    {
        return loader_.LoadRuntimePkgToDevice(baseCtx);
    }

    TSD_StatusT LoadDShapePkgToDevice(const MessageContext& baseCtx) { return loader_.LoadDShapePkgToDevice(baseCtx); }

    TSD_StatusT LoadOmFileToDevice(
        const char_t* const filePath, const uint64_t pathLen, const char_t* const fileName, const uint64_t fileNameLen,
        const MessageContext& baseCtx)
    {
        return loader_.LoadOmFileToDevice(filePath, pathLen, fileName, fileNameLen, baseCtx);
    }

    TSD_StatusT GetTrustedBasePathFromDevice(int32_t& peerNode, std::string& dstDirPreFix)
    {
        return envInfo_.GetTrustedBasePathFromDevice(peerNode, dstDirPreFix);
    }
    void SetDeviceCommonSinkPackHashValue(const std::string& pkgName, const std::string& hashValue)
    {
        hashStore_.SetDeviceCommonSinkPackHashValue(pkgName, hashValue);
    }
    std::string GetDeviceCommonSinkPackHashValue(const std::string& pkgName) const
    {
        return hashStore_.GetDeviceCommonSinkPackHashValue(pkgName);
    }
    void SetHostCommonSinkPackHashValue(const std::string& pkgName, const std::string& hashValue)
    {
        hashStore_.SetHostCommonSinkPackHashValue(pkgName, hashValue);
    }
    std::string GetHostCommonSinkPackHashValue(const std::string& pkgName) const
    {
        return hashStore_.GetHostCommonSinkPackHashValue(pkgName);
    }
    bool IsCommonSinkHostAndDevicePkgSame(const std::string& pkgName) const

    {
        return hashStore_.IsCommonSinkHostAndDevicePkgSame(pkgName);
    }
    bool IsCompatPluginPackage(const PackConfDetail& detail) const
    {
        return pluginVersion_.IsCompatPluginPackage(detail);
    }
    PluginUpdateStrategy GetPluginUpdateStrategy() { return pluginVersion_.GetPluginUpdateStrategy(); }
    bool ShouldLoadCompatPluginPkg(const std::string& pkgPureName)

    {
        return pluginVersion_.ShouldLoadCompatPluginPkg(pkgPureName);
    }
    bool CompareHostDeviceCompatPluginVersion(const std::string& pkgPureName)

    {
        return pluginVersion_.CompareHostDeviceCompatPluginVersion(pkgPureName);
    }
    void HandleDevicePluginVersionRsp(const HDCMessage& msg) { pluginVersion_.HandleDevicePluginVersionRsp(msg); }
    void HandleNormalPackageCheckCodeRsp(const HDCMessage& msg) { checkCodeSvc_.HandleNormalPackageCheckCodeRsp(msg); }
    void HandleCannHsCheckCodeRsp(const HDCMessage& msg) { checkCodeSvc_.HandleCannHsCheckCodeRsp(msg); }
    bool SupportLoadPkg(const std::string& pkgName) const { return loader_.SupportLoadPkg(pkgName); }
    bool IsOkToLoadFileToDevice(const char_t* const fileName, const uint64_t fileNameLen)
    {
        return loader_.IsOkToLoadFileToDevice(fileName, fileNameLen);
    }
    void ReportSinkPkgRspError(const std::string& pkgPureName) { loader_.ReportSinkPkgRspError(pkgPureName); }
    std::string GetCurHostMutexFile(bool useCannPath) const { return envInfo_.GetCurHostMutexFile(useCannPath); }
    bool GetShortSocVersion(std::string& shortSocVersion) const { return envInfo_.GetShortSocVersion(shortSocVersion); }
    ResponseCode GetPkgRspCode() const { return pkgRspCode_; }
    void SetPkgRspCode(ResponseCode code) { pkgRspCode_ = code; }
    bool getCheckCodeRetrySupport_;
    bool deviceIdle_;
    std::string loadPackageErrorMsg_;
    ResponseCode pkgRspCode_ = ResponseCode::FAIL;

private:
    PackageEnvInfo envInfo_;
    PackageHashStore hashStore_;
    PluginVersionManager pluginVersion_;
    std::string (&packageName_)[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_MAX)];
    std::map<std::string, std::string>& pkgHostHashValue_;
    std::map<std::string, std::string>& pkgDeviceHashValue_;
    std::string GetTrustedBasePath(bool useV2) const { return envInfo_.GetTrustedBasePath(useV2); }

    DeviceCommAgent& commAgent_;
    CapabilityManager& capabilityMgr_;

    std::map<std::string, PluginPkgVersion>& devicePluginVersions_;
    PluginUpdateStrategy& pluginUpdateStrategy_;
    bool& hasComputedPluginStrategy_;
    PackageSender sender_;
    PackageCheckCodeService checkCodeSvc_;
    PackageLoader loader_;

public:
    bool& aicpuPackageExistInDevice_;
    uint32_t (&packagePeerCheckCode_)[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_MAX)];
    uint32_t (&packageHostCheckCode_)[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_MAX)];
};

} // namespace tsd

#endif // INNER_INC_PACKAGE_MANAGER_H
