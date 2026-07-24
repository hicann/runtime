/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "package_loader.h"
#include "package_manager.h"
#include <string>
#include <vector>
#include "driver/ascend_hal.h"
#include "driver/ascend_inpackage_hal.h"
#include "error_manager.h"
#include "tsd_log.h"
#include "tsd/status.h"
#include "weak_ascend_hal.h"
#include "tsd_util_func.h"
#include "env_internal_api.h"
#include "package_process_config.h"
#include "platform_info.h"
#include "hdc_message_builder.h"

namespace {
const std::string RUNTIME_PKG_NAME = "Ascend-runtime_device-minios.tar.gz";
const std::string DSHAPE_PKG_NAME = "Ascend-opp_rt-minios.aarch64.tar.gz";
const std::string UDF_PKG_NAME = "cann-udf-compat.tar.gz";
const std::string HCCD_PKG_NAME = "cann-hccd-compat.tar.gz";
const std::string HIXL_PKG_NAME = "cann-hixl-compat.tar.gz";
constexpr uint32_t OMFILE_LOAD_TIMEOUT = 200000U;
constexpr uint64_t HELPER_INPUT_MAX_FILE_PATH_LEN = 4096UL;
constexpr uint64_t HELPER_INPUT_MAX_FILE_NAME_LEN = 256UL;
const std::map<std::string, std::vector<tsd::ChipType_t>> PKG_CHIP_SUPPORT_MAP = {
    {"aicpu_hccl.tar.gz", {tsd::CHIP_ASCEND_910B, tsd::CHIP_ASCEND_950, tsd::CHIP_CLOUD_V5, tsd::CHIP_ASCEND_350}},
    {"mc2_server.tar.gz", {tsd::CHIP_ASCEND_950, tsd::CHIP_ASCEND_350}},
    {"aicpu_hcomm.tar.gz",
     {tsd::CHIP_DC, tsd::CHIP_ASCEND_910B, tsd::CHIP_ASCEND_950, tsd::CHIP_ASCEND_350, tsd::CHIP_CLOUD_V5}},
    {"cann-hcomm-compat.tar.gz",
     {tsd::CHIP_ASCEND_910B, tsd::CHIP_ASCEND_950, tsd::CHIP_ASCEND_350, tsd::CHIP_CLOUD_V5}},
    {HCCD_PKG_NAME, {tsd::CHIP_ASCEND_910B}},
    {"cann-tsch-compat.tar.gz", {}},
    {UDF_PKG_NAME, {tsd::CHIP_ASCEND_910B}},
    {HIXL_PKG_NAME, {tsd::CHIP_ASCEND_910B, tsd::CHIP_ASCEND_950, tsd::CHIP_ASCEND_350, tsd::CHIP_CLOUD_V5}}};

std::string ConstructVerifyPkgErrorReason(const std::string& loadPackageErrorMsg)
{
    std::string reason;
    if (loadPackageErrorMsg.find("does not match") != std::string::npos) {
        const std::string certType = tsd::ExtractSubString(loadPackageErrorMsg, "certType [", "]");
        const std::string verifyFlag = tsd::ExtractSubString(loadPackageErrorMsg, "verifyFlag [", "]");
        reason = "The current signature verification mode is [" + verifyFlag +
                 "], which does not match the actual digital signature [" + certType +
                 "] of the software package. Change the signature verification mode";
    } else if (loadPackageErrorMsg.find("verifyFlag is not [Close]") != std::string::npos) {
        const std::string verifyFlag = tsd::ExtractSubString(loadPackageErrorMsg, "verifyFlag [", "]");
        reason = "The signature verification mode has been enabled. However, the soft package does not "
                 "have a signature. Disable signature verification or use a software package whose "
                 "digital signature matches the current signature verification mode [" +
                 verifyFlag + "]";
    } else if (loadPackageErrorMsg.find("Signature verification failed") != std::string::npos) {
        reason = "Signature verification failed. The possible cause is that a multi-bit ECC error occurred "
                 "on the device or the software package has been tampered with. Obtain the device log, check whether "
                 "ECC errors are reported, and contact technical support at https://www.hiascend.com/support";
    }
    return reason;
}
} // namespace

namespace tsd {

PackageLoader::PackageLoader(
    PackageManager& mgr, DeviceCommAgent& commAgent, CapabilityManager& capabilityMgr, PackageEnvInfo& envInfo,
    PackageHashStore& hashStore, ResponseCode& pkgRspCode, std::string& loadPackageErrorMsg)
    : mgr_(mgr),
      commAgent_(commAgent),
      capabilityMgr_(capabilityMgr),
      envInfo_(envInfo),
      hashStore_(hashStore),
      pkgRspCode_(pkgRspCode),
      loadPackageErrorMsg_(loadPackageErrorMsg)
{}

void PackageLoader::Reset()
{
    aicpuPackageExistInDevice_ = false;
    hasSendConfigFile_ = false;
    hashStore_.Clear();
}

TSD_StatusT PackageLoader::LoadSysOpKernel()
{
    const bool loadAicpuKernelFlag = ShouldLoadLegacyPackage();
    if (!mgr_.CheckPackageExists(loadAicpuKernelFlag)) {
        TSD_RUN_INFO("[TsdClient][logicDeviceId_=%u] cannot find aicpu packages", envInfo_.GetLogicDeviceId());
        return TSD_OK;
    }

    TSD_StatusT ret = mgr_.GetDeviceCheckCode();
    if (ret == TSD_AICPUPACKAGE_EXISTED) {
        return TSD_OK;
    }
    if (ret != TSD_OK) {
        return (ret >= TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT) ? ret : TSD_DEVICEID_ERROR;
    }

    if (envInfo_.GetPlatInfoMode() == static_cast<uint32_t>(ModeType::OFFLINE)) {
        TSD_RUN_INFO("[TsdClient]in process offline mode, ignore send any package!");
        return TSD_OK;
    }

    return SendAllPackagesToPeer();
}

bool PackageLoader::ShouldLoadLegacyPackage() const
{
    if (!capabilityMgr_.IsSupportCommonSink()) {
        return true;
    }
    std::string packageTitle;
    (void)envInfo_.GetPackageTitle(packageTitle);
    const std::string pkgName = packageTitle + "-aicpu_legacy.tar.gz";
    if (PackageProcessConfig::GetInstance()->GetPackageHostTruePath(pkgName).empty()) {
        return true;
    }
    TSD_RUN_INFO("[TsdClient][logicDeviceId_=%u] use legacy package", envInfo_.GetLogicDeviceId());
    return false;
}

TSD_StatusT PackageLoader::SendAllPackagesToPeer()
{
    constexpr int32_t peerNode = 0;
    char_t drvPath[256U] = {};
    const int32_t drvRet =
        drvHdcGetTrustedBasePath(peerNode, static_cast<int32_t>(envInfo_.GetLogicDeviceId()), &drvPath[0], 256U);
    if (drvRet != DRV_ERROR_NONE) {
        TSD_ERROR(
            "[TsdClient][deviceId_=%u] drvHdcGetTrustedBasePath failed, ret[%d]", envInfo_.GetLogicDeviceId(), drvRet);
        return TSD_INTERNAL_ERROR;
    }
    const std::string basePath(drvPath);

    TSD_StatusT ret = mgr_.SendAICPUPackage(peerNode, basePath);
    if (ret != TSD_OK) {
        REPORT_INPUT_ERROR("E39006", std::vector<std::string>(), std::vector<std::string>());
        TSD_ERROR("[TsdClient][deviceId=%u] send aicpu package to device failed", envInfo_.GetLogicDeviceId());
        return ret;
    }

    ret = mgr_.SendCommonPackage(
        peerNode, basePath, static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL));
    if (ret != TSD_OK) {
        REPORT_INPUT_ERROR("E39006", std::vector<std::string>(), std::vector<std::string>());
        TSD_ERROR("[TsdClient][deviceId=%u] send extend package to device failed", envInfo_.GetLogicDeviceId());
        return ret;
    }

    ret = mgr_.SendCommonPackage(peerNode, basePath, static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP));
    if (ret != TSD_OK) {
        TSD_ERROR("[TsdClient][deviceId=%u] send ascendcpp package to device failed", envInfo_.GetLogicDeviceId());
    }
    return ret;
}

TSD_StatusT PackageLoader::LoadHsPkgToDevice(
    const std::string& pkgName, const std::string& subPath, TsdLoadPackageType pkgType, HDCMessage::MsgType msgType,
    const MessageContext& baseCtx)
{
    std::string basePath;
    envInfo_.GetAscendLatestIntallPath(basePath);
    if (!basePath.empty() && basePath.back() == '/') {
        basePath = basePath + subPath;
    } else {
        basePath = basePath + "/" + subPath;
    }
    const std::string fullPkgPath = basePath + pkgName;
    TSD_INFO("target pkg path:%s pkgName:%s", basePath.c_str(), fullPkgPath.c_str());
    if ((mmAccess(basePath.c_str()) != EN_OK) || (mmIsDir(basePath.c_str()) != EN_OK)) {
        TSD_ERROR("[TsdClient] path[%s] does not exist, deviceId[%u]", basePath.c_str(), envInfo_.GetLogicDeviceId());
        return TSD_INTERNAL_ERROR;
    }
    if (mmAccess(fullPkgPath.c_str()) != EN_OK) {
        TSD_ERROR(
            "[TsdClient] file[%s] does not exist, deviceId[%u]", fullPkgPath.c_str(), envInfo_.GetLogicDeviceId());
        return TSD_INTERNAL_ERROR;
    }
    mgr_.packagePeerCheckCode_[static_cast<uint32_t>(pkgType)] = 0U;
    const uint32_t checkCode = CalFileSize(fullPkgPath.c_str());
    const auto ret =
        mgr_.SendFileToDevice(basePath.c_str(), basePath.length(), pkgName.c_str(), pkgName.length(), true);
    TSD_CHECK(ret == TSD_OK, ret, "send pkg to device failed.");
    if (mgr_.GetDeviceHsPkgCheckCode(checkCode, msgType, false, baseCtx) != TSD_OK) {
        TSD_ERROR("GetDeviceHsPkgCheckCode failed");
        return TSD_INTERNAL_ERROR;
    }
    if (checkCode != mgr_.packagePeerCheckCode_[static_cast<uint32_t>(pkgType)]) {
        TSD_ERROR(
            "checode verify is failed checkCode:%u, peerCheckCode:%u", checkCode,
            mgr_.packagePeerCheckCode_[static_cast<uint32_t>(pkgType)]);
        return TSD_INTERNAL_ERROR;
    }
    return TSD_OK;
}

TSD_StatusT PackageLoader::LoadRuntimePkgToDevice(const MessageContext& baseCtx)
{
    if (capabilityMgr_.IsSupportCommonSink() && (&drvHdcSendFileV2 != nullptr) &&
        (&drvHdcGetTrustedBasePathV2 != nullptr)) {
        (void)mgr_.LoadPackageConfigInfoToDevice(false);
        if (mgr_.LoadCannHsPkgToDevice(UDF_PKG_NAME, baseCtx) != TSD_OK) {
            TSD_ERROR("Load package failed, package:%s", UDF_PKG_NAME.c_str());
            return TSD_INTERNAL_ERROR;
        }
        if (mgr_.LoadCannHsPkgToDevice(HCCD_PKG_NAME, baseCtx) != TSD_OK) {
            TSD_ERROR("Load package failed, package:%s", HCCD_PKG_NAME.c_str());
            return TSD_INTERNAL_ERROR;
        }
        TSD_RUN_INFO("Load udf and hccd package success.");
        return TSD_OK;
    }

    return this->LoadHsPkgToDevice(
        RUNTIME_PKG_NAME, "runtime/lib64/", TsdLoadPackageType::TSD_PKG_TYPE_RUNTIME,
        HDCMessage::TSD_GET_DEVICE_RUNTIME_CHECKCODE, baseCtx);
}

TSD_StatusT PackageLoader::LoadCannHsPkgToDevice(const std::string& pkgPureName, const MessageContext& baseCtx)
{
    int32_t peerNode = 0;
    const std::string dstDirPreFix = envInfo_.GetTrustedBasePath(true);

    PackageProcessConfig* pkgConInst = PackageProcessConfig::GetInstance();
    std::string orgFile;
    std::string dstFile = dstDirPreFix;
    if (pkgConInst->GetPkgHostAndDeviceDstPath(pkgPureName, orgFile, dstFile, commAgent_.GetProcSign().tgid) !=
        TSD_OK) {
        return TSD_INTERNAL_ERROR;
    }
    if (orgFile.empty()) {
        TSD_RUN_WARN("cannot find package:%s, optional is true skip", pkgPureName.c_str());
        return TSD_OK;
    }

    const std::string hostHash = CalFileSha256HashValue(orgFile);
    hashStore_.SetHostCommonSinkPackHashValue(pkgPureName, hostHash);
    if (mgr_.IsCommonSinkHostAndDevicePkgSame(pkgPureName)) {
        TSD_INFO("current package:%s is same as device, skip load", pkgPureName.c_str());
        return TSD_OK;
    }

    if (mgr_.LoadFileAndWaitRsp(pkgPureName, hostHash, peerNode, orgFile, dstFile, baseCtx) != TSD_OK) {
        TSD_ERROR("compare and send package to device failed");
        return TSD_INTERNAL_ERROR;
    }

    if (static_cast<uint32_t>(pkgRspCode_) != 0U) {
        TSD_ERROR("host and device check code compare failed, package:%s", pkgPureName.c_str());
        return TSD_INTERNAL_ERROR;
    }

    TSD_RUN_INFO("Load package success, package:%s", pkgPureName.c_str());
    return TSD_OK;
}

TSD_StatusT PackageLoader::LoadFileAndWaitRsp(
    const std::string& pkgPureName, const std::string& hostPkgHash, const int32_t peerNode, const std::string& orgFile,
    const std::string& dstFile, const MessageContext& baseCtx)
{
    if (mgr_.SendAICPUPackageSimple(peerNode, orgFile, dstFile, true) != TSD_OK) {
        TSD_ERROR("send package to device failed, package:%s", pkgPureName.c_str());
        return TSD_INTERNAL_ERROR;
    }

    if (mgr_.GetCannHsPkgCheckCode(pkgPureName, hostPkgHash, baseCtx) != TSD_OK) {
        TSD_ERROR("get check code from device failed, package:%s", pkgPureName.c_str());
        return TSD_INTERNAL_ERROR;
    }

    return TSD_OK;
}

TSD_StatusT PackageLoader::LoadDShapePkgToDevice(const MessageContext& baseCtx)
{
    return this->LoadHsPkgToDevice(
        DSHAPE_PKG_NAME, "ops/built-in/", TsdLoadPackageType::TSD_PKG_TYPE_DSHAPE,
        HDCMessage::TSD_GET_DEVICE_DSHAPE_CHECKCODE, baseCtx);
}

TSD_StatusT PackageLoader::LoadOmFileToDevice(
    const char_t* const filePath, const uint64_t pathLen, const char_t* const fileName, const uint64_t fileNameLen,
    const MessageContext& baseCtx)
{
    if ((filePath == nullptr) || (pathLen == 0UL) || (pathLen >= HELPER_INPUT_MAX_FILE_PATH_LEN)) {
        TSD_ERROR("input param is error");
        return TSD_INTERNAL_ERROR;
    }
    try {
        std::string filePathStr(filePath, pathLen);
        TSD_RUN_INFO("file path is:%s", filePathStr.c_str());
    } catch (std::exception& e) {
        TSD_ERROR("input str is invalid reason:%s", e.what());
        return TSD_INTERNAL_ERROR;
    }
    auto ret = mgr_.SendFileToDevice(filePath, pathLen, fileName, fileNameLen, true);
    TSD_CHECK(ret == TSD_OK, ret, "SendFileToDevice failed.");

    ret = mgr_.InitTsdClient();
    TSD_CHECK(ret == TSD_OK, ret, "Init hdc client failed.");
    TSD_CHECK_NULLPTR(commAgent_.GetDeviceComm(), TSD_INSTANCE_NOT_FOUND, "devCommClient_ is null in send function");
    std::string curFile(fileName, fileNameLen);
    HDCMessage msg;
    const std::string curPid = std::to_string(commAgent_.GetProcSign().tgid);
    curFile = curPid + "_" + curFile;
    TSD_INFO("Load om file name:%s to device logic device id:%u", curFile.c_str(), envInfo_.GetLogicDeviceId());
    MessageContext ctx = baseCtx;
    ctx.omfileName = curFile;
    ret = HdcMessageBuilder::BuildOmFileDecompress(msg, ctx);
    TSD_CHECK(ret == TSD_OK, ret, "build TSD_OM_PKG_DECOMPRESS_STATUS msg failed.");
    ret = commAgent_.SendMsg(msg);
    TSD_CHECK(ret == TSD_OK, ret, "send TSD_OM_PKG_DECOMPRESS_STATUS msg failed.");
    ret = mgr_.WaitPkgRsp(OMFILE_LOAD_TIMEOUT);
    TSD_CHECK(ret == TSD_OK, ret, "Wait TSD_OM_PKG_DECOMPRESS_STATUS response from device failed.");
    TSD_INFO("LoadOmFileToDevice success filepath:%s, filename:%s", filePath, fileName);
    return TSD_OK;
}

TSD_StatusT PackageLoader::LoadFileToDevice(
    const char_t* const filePath, const uint64_t pathLen, const char_t* const fileName, const uint64_t fileNameLen,
    const MessageContext& baseCtx)
{
    if (!mgr_.IsOkToLoadFileToDevice(fileName, fileNameLen)) {
        TSD_ERROR("IsOkToLoadFileToDevice is false");
        return TSD_INTERNAL_ERROR;
    }
    const std::string loadFile(fileName, fileNameLen);
    TSD_RUN_INFO("begin load file:%s", loadFile.c_str());
    if (loadFile == RUNTIME_PKG_NAME) {
        return mgr_.LoadRuntimePkgToDevice(baseCtx);
    } else if (loadFile == DSHAPE_PKG_NAME) {
        return mgr_.LoadDShapePkgToDevice(baseCtx);
    } else {
        return mgr_.LoadOmFileToDevice(filePath, pathLen, fileName, fileNameLen, baseCtx);
    }
}

bool PackageLoader::IsOkToLoadFileToDevice(const char_t* const fileName, const uint64_t fileNameLen) const
{
    if ((fileName == nullptr) || (fileNameLen == 0UL) || (fileNameLen >= HELPER_INPUT_MAX_FILE_NAME_LEN)) {
        TSD_ERROR("input param is error");
        return false;
    }
    if (!capabilityMgr_.IsSupportCommonInterface(TSD_SUPPORT_HS_AISERVER_FEATURE_BIT)) {
        TSD_ERROR("cur device does not support heterogeneous AIServer");
        return false;
    }
    try {
        std::string loadFile(fileName, fileNameLen);
        TSD_RUN_INFO("loadfile name:%s", loadFile.c_str());
    } catch (std::exception& e) {
        TSD_ERROR("input fileName is invalid reason:%s", e.what());
        return false;
    }
    return true;
}

TSD_StatusT PackageLoader::LoadPackageConfigInfoToDevice(const bool hasPluginVersion)
{
    if ((capabilityMgr_.IsSupportCommonSink() == false) || (&drvHdcSendFileV2 == nullptr) ||
        (&drvHdcGetTrustedBasePathV2 == nullptr) || envInfo_.IsAdcEnv() || (&halGetSocVersion == nullptr)) {
        TSD_RUN_INFO("device does not support common sink package config info");
        return TSD_OK;
    }

    if (hasSendConfigFile_) {
        TSD_RUN_INFO(
            "The package config file has send to device, no need send again. deviceId=%u", envInfo_.GetLogicDeviceId());
        return TSD_OK;
    }

    TSD_StatusT ret = mgr_.InitTsdClient();
    if (ret != TSD_OK) {
        TSD_ERROR("[TsdClient][deviceId_=%u] InitTsdClient failed, ret[%d]", envInfo_.GetLogicDeviceId(), ret);
        return TSD_INTERNAL_ERROR;
    }
    TSD_CHECK_NULLPTR(commAgent_.GetDeviceComm(), TSD_INSTANCE_NOT_FOUND, "devCommClient is null");
    std::string packageTitle;
    (void)envInfo_.GetPackageTitle(packageTitle);
    std::string shortSocVersion;
    (void)envInfo_.GetShortSocVersion(shortSocVersion);
    packageTitle = packageTitle + ";" + shortSocVersion;
    PackageProcessConfig* pkgConInst = PackageProcessConfig::GetInstance();
    ret = pkgConInst->ParseConfigDataFromFile(packageTitle);
    if (ret != TSD_OK) {
        TSD_ERROR("Parsing config data was not successful");
        return TSD_INTERNAL_ERROR;
    }
    if (hasPluginVersion) {
        pkgConInst->RefreshHostPluginVersions();
    }

    MessageContext ctx{};
    ctx.logicDeviceId = envInfo_.GetLogicDeviceId();
    ctx.procSign = commAgent_.GetProcSign();
    HDCMessage msg;
    if (HdcMessageBuilder::BuildUpdatePackageConfig(msg, ctx) != TSD_OK) {
        TSD_ERROR("build update package config msg failed");
        return TSD_INTERNAL_ERROR;
    }
    pkgConInst->ConstructPkgConfigMsg(msg);

    ret = commAgent_.SendMsg(msg);
    if (ret != TSD_OK) {
        TSD_ERROR("Send update package config message failed.");
        return ret;
    }

    ret = commAgent_.RecvData();
    TSD_RUN_INFO("Receive load package config response result:%u", ret);

    hasSendConfigFile_ = true;

    return TSD_OK;
}

bool PackageLoader::SupportLoadPkg(const std::string& pkgName) const
{
    const auto iter = PKG_CHIP_SUPPORT_MAP.find(pkgName);
    if (iter == PKG_CHIP_SUPPORT_MAP.end()) {
        TSD_INFO("current package:%s does not need to check chiptype", pkgName.c_str());
        return true;
    }

    if ((pkgName == UDF_PKG_NAME) || (pkgName == HCCD_PKG_NAME)) {
        TSD_INFO("package is not need load, name:%s", pkgName.c_str());
        return false;
    }

    for (const auto chip : iter->second) {
        if (envInfo_.GetPlatInfoChipType() == static_cast<uint32_t>(chip)) {
            TSD_INFO("current device chip:%u support package:%s", envInfo_.GetPlatInfoChipType(), pkgName.c_str());
            return true;
        }
    }

    TSD_RUN_INFO("current device chip:%u does not support package:%s", envInfo_.GetPlatInfoChipType(), pkgName.c_str());
    return false;
}

TSD_StatusT PackageLoader::LoadSinglePackageToDevice(
    const std::string& pkgPureName, const PackConfDetail& detail, int32_t peerNode, const std::string& dstDirPreFix)
{
    PackageProcessConfig* pkgConInst = PackageProcessConfig::GetInstance();
    std::string orgFile;
    std::string dstFile = dstDirPreFix;
    TSD_RUN_INFO("begin to load package:%s to device:%u", pkgPureName.c_str(), envInfo_.GetLogicDeviceId());
    if ((!detail.loadAsPerSocFlag) && (!mgr_.SupportLoadPkg(pkgPureName))) {
        TSD_RUN_INFO(
            "current package:%s does not need to load to device:%u", pkgPureName.c_str(), envInfo_.GetLogicDeviceId());
        return TSD_OK;
    }
    if ((pkgPureName == "cann-hcomm-compat.tar.gz") && (envInfo_.GetPlatInfoChipType() == tsd::CHIP_ASCEND_910B) &&
        (!capabilityMgr_.IsSupportCommonInterface(TSD_SUPPORT_CANN_HCOMM_COMPAT_910B))) {
        TSD_RUN_INFO(
            "device does not support cann-hcomm-compat package, skip load to device:%u", envInfo_.GetLogicDeviceId());
        return TSD_OK;
    }
    if (pkgConInst->GetPkgHostAndDeviceDstPath(pkgPureName, orgFile, dstFile, commAgent_.GetProcSign().tgid) !=
        TSD_OK) {
        return TSD_INTERNAL_ERROR;
    }
    if (orgFile.empty()) {
        TSD_RUN_INFO("cannot find package:%s, optional is true skip", pkgPureName.c_str());
        return TSD_OK;
    }
    const std::string hostPkgHash = CalFileSha256HashValue(orgFile);
    hashStore_.SetHostCommonSinkPackHashValue(pkgPureName, hostPkgHash);
    if (mgr_.IsCompatPluginPackage(detail) && !mgr_.ShouldLoadCompatPluginPkg(pkgPureName)) {
        TSD_RUN_INFO("skip load compat plugin package:%s by version/strategy check", pkgPureName.c_str());
        return TSD_OK;
    }
    if (!mgr_.IsCompatPluginPackage(detail) && mgr_.IsCommonSinkHostAndDevicePkgSame(pkgPureName)) {
        TSD_RUN_INFO("current package:%s is same as device, skip load", pkgPureName.c_str());
        return TSD_OK;
    }
    if (mgr_.CompareAndSendCommonSinkPkg(pkgPureName, hostPkgHash, peerNode, orgFile, dstFile) != TSD_OK) {
        TSD_ERROR("compare and send package to device failed package:%s", pkgPureName.c_str());
        return TSD_INTERNAL_ERROR;
    }
    if (static_cast<uint32_t>(pkgRspCode_) != 0U) {
        this->ReportSinkPkgRspError(pkgPureName);
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO("load package:%s to device:%u success", pkgPureName.c_str(), envInfo_.GetLogicDeviceId());
    return TSD_OK;
}

void PackageLoader::ReportSinkPkgRspError(const std::string& pkgPureName)
{
    bool reportedFlag = false;
    if (!loadPackageErrorMsg_.empty()) {
        TSD_ERROR("[Device error message] %s", loadPackageErrorMsg_.c_str());
        const bool isCmsVerifyFail = (loadPackageErrorMsg_.find("cms verify failed") != std::string::npos);
        const std::string reason =
            isCmsVerifyFail ? ConstructVerifyPkgErrorReason(loadPackageErrorMsg_) : std::string{};
        if (!reason.empty()) {
            const std::vector<std::string> keys{"package_name", "reason"};
            const std::vector<std::string> values{pkgPureName, reason};
            REPORT_INPUT_ERROR("E30009", keys, values);
            reportedFlag = true;
        }
        loadPackageErrorMsg_ = "";
    }
    if (!reportedFlag) {
        REPORT_INPUT_ERROR("E39011", std::vector<std::string>{"package_name"}, std::vector<std::string>{pkgPureName});
    }
    TSD_ERROR("host and device checkcode compare failed package:%s", pkgPureName.c_str());
}

TSD_StatusT PackageLoader::LoadPackageToDeviceByConfig()
{
    if ((capabilityMgr_.IsSupportCommonSink() == false) || (&drvHdcSendFileV2 == nullptr) ||
        (&drvHdcGetTrustedBasePathV2 == nullptr) || envInfo_.IsAdcEnv()) {
        TSD_RUN_INFO("device does not support common sink package config info");
        return TSD_OK;
    }

    int32_t peerNode = 0;
    std::string dstDirPreFix;
    if (envInfo_.GetTrustedBasePathFromDevice(peerNode, dstDirPreFix) != TSD_OK) {
        return TSD_INTERNAL_ERROR;
    }

    PackageProcessConfig* pkgConInst = PackageProcessConfig::GetInstance();
    std::map<std::string, PackConfDetail> configMap = pkgConInst->GetAllPackageConfigInfo();

    for (auto& entry : configMap) {
        if (mgr_.LoadSinglePackageToDevice(entry.first, entry.second, peerNode, dstDirPreFix) != TSD_OK) {
            return TSD_INTERNAL_ERROR;
        }
    }

    return TSD_OK;
}

} // namespace tsd
