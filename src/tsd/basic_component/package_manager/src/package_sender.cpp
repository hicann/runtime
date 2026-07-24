/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "package_sender.h"
#include "package_manager.h"
#include <string>
#include <sys/file.h>
#include "driver/ascend_hal.h"
#include "error_manager.h"
#include "env_internal_api.h"
#include "tsd_log.h"
#include "tsd_scope_guard.h"
#include "tsd_util_func.h"
#include "package_process_config.h"
#include "hdc_message_builder.h"

namespace {
constexpr uint32_t INVALID_NUMBER = 0xFFFFFFFFU;
constexpr uint32_t DRIVER_EXTEND_MAX_PROCESS_TIME = 140U;
} // namespace

namespace tsd {

PackageSender::PackageSender(
    PackageManager& mgr, DeviceCommAgent& commAgent, CapabilityManager& capabilityMgr, PackageEnvInfo& envInfo,
    PackageHashStore& hashStore, bool& deviceIdle, bool& getCheckCodeRetrySupport)
    : mgr_(mgr),
      commAgent_(commAgent),
      capabilityMgr_(capabilityMgr),
      envInfo_(envInfo),
      hashStore_(hashStore),
      deviceIdle_(deviceIdle),
      getCheckCodeRetrySupport_(getCheckCodeRetrySupport)
{}

TSD_StatusT PackageSender::SendAICPUPackageSimple(
    const int32_t peerNode, const std::string& orgFile, const std::string& dstFile, bool useCannPath)
{
    TSD_RUN_INFO(
        "[TsdClient][deviceId=%u] no equal to begin send file[%s] to [%s]", envInfo_.GetLogicDeviceId(),
        orgFile.c_str(), dstFile.c_str());
    if (useCannPath) {
        const auto ret = drvHdcSendFileV2(
            peerNode, static_cast<int32_t>(envInfo_.GetLogicDeviceId()), orgFile.c_str(), dstFile.c_str(), nullptr);
        if (ret != DRV_ERROR_NONE) {
            TSD_ERROR(
                "[TsdClient][deviceId=%u] drvHdcSendFile file[%s] to [%s] failed ret = %d", envInfo_.GetLogicDeviceId(),
                orgFile.c_str(), dstFile.c_str(), ret);
            return TSD_INTERNAL_ERROR;
        }
    } else {
        const auto ret = drvHdcSendFile(
            peerNode, static_cast<int32_t>(envInfo_.GetLogicDeviceId()), orgFile.c_str(), dstFile.c_str(), nullptr);
        if (ret != DRV_ERROR_NONE) {
            TSD_ERROR(
                "[TsdClient][deviceId=%u] drvHdcSendFile file[%s] to [%s] failed ret = %d", envInfo_.GetLogicDeviceId(),
                orgFile.c_str(), dstFile.c_str(), ret);
            return TSD_INTERNAL_ERROR;
        }
    }

    TSD_RUN_INFO(
        "[TsdClient][deviceId=%u] hdc send file[%s] to [%s] success", envInfo_.GetLogicDeviceId(), orgFile.c_str(),
        dstFile.c_str());
    return TSD_OK;
}

TSD_StatusT PackageSender::SendMsgAndHostPackage(
    const int32_t peerNode, const std::string& orgFile, const std::string& dstFile, HDCMessage& msg,
    const std::function<bool(void)>& compareCallBack, bool useCannPath)
{
    msg.set_wait_flag(false);
    TSD_StatusT ret = mgr_.GetDeviceCheckCodeRetry(msg);
    if (ret != TSD_OK) {
        if (ret >= TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT) {
            return ret;
        }
        return TSD_INTERNAL_ERROR;
    }
    if (compareCallBack()) {
        TSD_INFO("host check and compare to device, no need to load package");
        return TSD_OK;
    }

    if (mgr_.SendAICPUPackageSimple(peerNode, orgFile, dstFile, useCannPath) != TSD_OK) {
        REPORT_INPUT_ERROR("E39006", std::vector<std::string>(), std::vector<std::string>());
        return TSD_INTERNAL_ERROR;
    }

    msg.set_wait_flag(true);
    ret = mgr_.GetDeviceCheckCodeRetry(msg);
    if (ret != TSD_OK) {
        if (ret >= TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT) {
            return ret;
        }
        return TSD_INTERNAL_ERROR;
    }

    return TSD_OK;
}

TSD_StatusT PackageSender::SendHostPackageComplex(
    const int32_t peerNode, const std::string& orgFile, const std::string& dstFile, HDCMessage& msg,
    const std::function<bool(void)>& compareCallBack, bool useCannPath)
{
    if (envInfo_.hostSoPath_.empty()) {
        return mgr_.SendMsgAndHostPackage(peerNode, orgFile, dstFile, msg, compareCallBack, useCannPath);
    }
    const std::string mutexFileName = envInfo_.GetCurHostMutexFile(useCannPath);
    const std::string mutexFile = envInfo_.hostSoPath_ + mutexFileName;
    TSD_RUN_INFO("get host mutex file:%s, logicDeviceId:%u", mutexFile.c_str(), envInfo_.GetLogicDeviceId());
    if (!CheckRealPath(mutexFile)) {
        TSD_INFO("Cannot get realpath of mutexFile[%s]", mutexFile.c_str());
        return mgr_.SendMsgAndHostPackage(peerNode, orgFile, dstFile, msg, compareCallBack, useCannPath);
    }
    const int32_t fileData = open(mutexFile.c_str(), O_RDONLY);
    if (fileData < 0) {
        TSD_INFO("Opening qs so [%s] was not successful, reason[%s]", mutexFile.c_str(), SafeStrerror().c_str());
        return mgr_.SendMsgAndHostPackage(peerNode, orgFile, dstFile, msg, compareCallBack, useCannPath);
    } else {
        TSD_INFO("Open qs so [%s] success", mutexFile.c_str());
    }
    const ScopeGuard fileDataGuard([&fileData]() { (void)close(fileData); });
    const int32_t flockRet = flock(fileData, LOCK_EX);
    if (flockRet == -1) {
        TSD_RUN_WARN(
            "File lock was not successful, ret[%d], errno[%d], reason[%s]", flockRet, errno, SafeStrerror().c_str());
    }

    const ScopeGuard fileLockGuard([&fileData]() { (void)flock(fileData, LOCK_UN); });
    return mgr_.SendMsgAndHostPackage(peerNode, orgFile, dstFile, msg, compareCallBack, useCannPath);
}

TSD_StatusT PackageSender::SendAICPUPackage(const int32_t peerNode, const std::string& path)
{
    const uint32_t packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL);
    if (envInfo_.packageName_[packageType].empty()) {
        TSD_RUN_INFO(
            "[TsdClient][deviceId_=%u] aicpu package is not existed, skip send package", envInfo_.GetLogicDeviceId());
        return TSD_OK;
    }

    if (mgr_.packageHostCheckCode_[packageType] == mgr_.packagePeerCheckCode_[packageType]) {
        TSD_RUN_INFO(
            "[TsdClient][deviceId_=%u] the checksum of host package[%u] is the same as device[%u], skip send package.",
            envInfo_.GetLogicDeviceId(), mgr_.packageHostCheckCode_[packageType],
            mgr_.packagePeerCheckCode_[packageType]);
        return TSD_OK;
    }

    const std::string orgFile = envInfo_.packagePath_[packageType] + envInfo_.packageName_[packageType];
    const std::string dstFile =
        path + "/" + std::to_string(commAgent_.GetProcSign().tgid) + "_" + envInfo_.packageName_[packageType];
    if ((!getCheckCodeRetrySupport_) || (IsAsanMmSysEnv()) || (IsFpgaMmSysEnv())) {
        return mgr_.SendAICPUPackageSimple(peerNode, orgFile, dstFile, false);
    } else {
        MessageContext ctx{};
        ctx.logicDeviceId = envInfo_.GetLogicDeviceId();
        ctx.checkCode = mgr_.packageHostCheckCode_[packageType];
        ctx.packageType = packageType;
        HDCMessage msg;
        if (HdcMessageBuilder::BuildCheckPackageRetry(msg, ctx) != TSD_OK) {
            return TSD_INTERNAL_ERROR;
        }
        auto aicpuPkgCompareMethd = [this, packageType]() {
            if (mgr_.packageHostCheckCode_[packageType] == mgr_.packagePeerCheckCode_[packageType]) {
                TSD_INFO(
                    "[TsdClient] after lock, the checksum of aicpu package[%u] is same as device[%u], skip send",
                    mgr_.packageHostCheckCode_[packageType], mgr_.packagePeerCheckCode_[packageType]);
                return true;
            }
            return false;
        };
        return mgr_.SendHostPackageComplex(peerNode, orgFile, dstFile, msg, aicpuPkgCompareMethd, false);
    }
}

TSD_StatusT PackageSender::SendCommonPackage(
    const int32_t peerNode, const std::string& path, const uint32_t packageType)
{
    if (envInfo_.packageName_[packageType].empty()) {
        TSD_RUN_INFO(
            "[TsdClient][deviceId_=%u] package is not existed, skip send, packageType[%u]", envInfo_.GetLogicDeviceId(),
            packageType);
        return TSD_OK;
    }

    uint32_t supportLevelName = INVALID_NUMBER;
    if (packageType == static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)) {
        supportLevelName = TSD_SUPPORT_EXTEND_PKG;
    } else if (packageType == static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP)) {
        supportLevelName = TSD_SUPPORT_ASCENDCPP_PKG;
    }
    if (TSD_BITMAP_GET(capabilityMgr_.GetTsdSupportLevel(), supportLevelName) == 0U) {
        mgr_.packageHostCheckCode_[packageType] = 0U;
        TSD_RUN_INFO(
            "[TsdClient][deviceId_=%u] device does not support, skip send, packageType[%u]",
            envInfo_.GetLogicDeviceId(), packageType);
        return TSD_OK;
    }

    if (mgr_.packageHostCheckCode_[packageType] == mgr_.packagePeerCheckCode_[packageType]) {
        TSD_INFO(
            "[TsdClient][deviceId_=%u] the checksum of host package[%u] is same as device[%u], skip send package, "
            "packageType[%u]",
            envInfo_.GetLogicDeviceId(), mgr_.packageHostCheckCode_[packageType],
            mgr_.packagePeerCheckCode_[packageType], packageType);
        return TSD_OK;
    }

    const std::string orgFile = envInfo_.packagePath_[packageType] + envInfo_.packageName_[packageType];
    const std::string dstFile =
        path + "/" + std::to_string(commAgent_.GetProcSign().tgid) + "_" + envInfo_.packageName_[packageType];
    TSD_INFO(
        "[TsdClient][deviceId=%u] hostCheckCode[%u] no equal to deviceCheckCode[%u], begin send file[%s] to [%s], "
        "packageType[%u]",
        envInfo_.GetLogicDeviceId(), mgr_.packageHostCheckCode_[packageType], mgr_.packagePeerCheckCode_[packageType],
        orgFile.c_str(), dstFile.c_str(), packageType);
    const auto ret = drvHdcSendFile(
        peerNode, static_cast<int32_t>(envInfo_.GetLogicDeviceId()), orgFile.c_str(), dstFile.c_str(), nullptr);
    if (ret != DRV_ERROR_NONE) {
        TSD_ERROR(
            "[TsdClient][deviceId=%u] drvHdcSendFile file[%s] to [%s] failed, ret[%d], packageType[%u]",
            envInfo_.GetLogicDeviceId(), orgFile.c_str(), dstFile.c_str(), ret, packageType);
        mgr_.packageHostCheckCode_[packageType] = 0U;
        return TSD_INTERNAL_ERROR;
    }
    TSD_INFO(
        "[TsdClient][deviceId=%u] hdc send file[%s] to [%s] success, packageType[%u]", envInfo_.GetLogicDeviceId(),
        orgFile.c_str(), dstFile.c_str(), packageType);
    return TSD_OK;
}

TSD_StatusT PackageSender::SendFileToDevice(
    const char_t* const filePath, const uint64_t pathLen, const char_t* const fileName, const uint64_t fileNameLen,
    const bool addPreFix)
{
    TSD_RUN_INFO(
        "[TsdClient] [deviceId=%u][pathLen=%llu] SendFileToDevice enter", envInfo_.GetLogicDeviceId(), pathLen);
    constexpr int32_t peerNode = 0;
    const std::string basePath = envInfo_.GetTrustedBasePath(false);
    std::string curPid;
    if (commAgent_.IsInit()) {
        curPid = std::to_string(commAgent_.GetProcSign().tgid);
    } else {
        process_sign processSign;
        const int32_t ret = drvGetProcessSign(&processSign);
        if (ret != DRV_ERROR_NONE) {
            TSD_ERROR("driver get process sign failed. ret[%d].", ret);
            return TSD_INTERNAL_ERROR;
        }
        curPid = std::to_string(processSign.tgid);
    }
    std::string curFile(fileName, fileNameLen);
    std::string dstFile = basePath + "/";
    if (addPreFix) {
        dstFile += curPid + "_";
    }
    dstFile += curFile;
    std::string orgPath(filePath, pathLen);
    std::string orgFile;
    if (!orgPath.empty() && orgPath.back() == '/') {
        orgFile = orgPath + curFile;
    } else {
        orgFile = orgPath + "/" + curFile;
    }
    const auto ret = drvHdcSendFile(
        peerNode, static_cast<int32_t>(envInfo_.GetLogicDeviceId()), orgFile.c_str(), dstFile.c_str(), nullptr);
    if (ret != DRV_ERROR_NONE) {
        TSD_ERROR(
            "[TsdClient][deviceId=%u] drvHdcSendFile file[%s] to [%s] failed, "
            "ret = %d",
            envInfo_.GetLogicDeviceId(), orgFile.c_str(), dstFile.c_str(), ret);
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO(
        "[TsdClient][deviceId=%u] hdc send file[%s] to [%s] success", envInfo_.GetLogicDeviceId(), orgFile.c_str(),
        dstFile.c_str());
    return TSD_OK;
}

TSD_StatusT PackageSender::CompareAndSendCommonSinkPkg(
    const std::string& pkgPureName, const std::string& hostPkgHash, const int32_t peerNode, const std::string& orgFile,
    const std::string& dstFile)
{
    MessageContext ctx{};
    ctx.logicDeviceId = envInfo_.GetLogicDeviceId();
    ctx.packageName = pkgPureName;
    ctx.hashCode = hostPkgHash;
    const PluginPkgVersion pv = PackageProcessConfig::GetInstance()->GetHostPluginVersion(pkgPureName);
    ctx.hostPluginVersion.version = pv.version;
    ctx.hostPluginVersion.timestamp = pv.timestamp;
    ctx.packageWorkerType = static_cast<uint32_t>(PackageWorkerType::PACKAGE_WORKER_COMMON_SINK);
    ctx.packageMaxProcessTime = DRIVER_EXTEND_MAX_PROCESS_TIME;
    ctx.packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_COMMON_SINK);
    HDCMessage msg;
    if (HdcMessageBuilder::BuildNormalCheckCode(msg, ctx) != TSD_OK) {
        TSD_ERROR("build normal check code msg failed");
        return TSD_INTERNAL_ERROR;
    }
    auto commonSinkPkgCompareMethd = [this, pkgPureName]() {
        if (hashStore_.IsCommonSinkHostAndDevicePkgSame(pkgPureName)) {
            TSD_INFO(
                "checksum of driver package[%s] is same as device[%u], idle[%d], skip send",
                hashStore_.GetHostCommonSinkPackHashValue(pkgPureName).c_str(), envInfo_.GetLogicDeviceId(),
                deviceIdle_);
            return true;
        }
        return false;
    };
    if (mgr_.SendHostPackageComplex(peerNode, orgFile, dstFile, msg, commonSinkPkgCompareMethd, true) != TSD_OK) {
        TSD_ERROR("send common sink package to device failed");
        return TSD_INTERNAL_ERROR;
    }
    return TSD_OK;
}

} // namespace tsd
