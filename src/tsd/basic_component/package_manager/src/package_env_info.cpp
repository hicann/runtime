/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "package_env_info.h"
#include <string>
#include <vector>
#include "driver/ascend_hal.h"
#include "capability_manager.h"
#include "env_internal_api.h"
#include "error_manager.h"
#include "platform_info.h"
#include "tsd_log.h"
#include "tsd/status.h"
#include "tsd_util_func.h"
#include "package_process_config.h"

namespace {
const std::string AICPU_PACKAGE_PATTERN = "^Ascend([0-9]{3}(rc)?(P)?)?-aicpu_syskernels\\.tar\\.gz$";
const std::string EXTEND_PACKAGE_PATTERN = "^Ascend([0-9]{3}(rc)?(P)?)?-aicpu_extend_syskernels\\.tar\\.gz$";
const std::string ASCENDCPP_PACKAGE_PATTERN = "^transformer_tile_fwk_aicpu_kernel\\.tar\\.gz$";
constexpr uint32_t SOC_VERSION_LEN = 50U;
const std::string QUEUE_SCHEDULE_SO = "libqueue_schedule.so";
const int64_t SUPPORT_MAX_DEVICE_PER_HOST = 8;
} // namespace

namespace tsd {

PackageEnvInfo::PackageEnvInfo(uint32_t logicDeviceId, uint32_t platInfoMode, bool isAdcEnv, uint32_t chipType)
    : platInfoMode_(platInfoMode), isAdcEnv_(isAdcEnv), chipType_(chipType), logicDeviceId_(logicDeviceId)
{
    packagePattern_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = AICPU_PACKAGE_PATTERN;
    packagePattern_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)] =
        EXTEND_PACKAGE_PATTERN;
    packagePattern_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP)] = ASCENDCPP_PACKAGE_PATTERN;
    hostSoPath_ = tsd::GetHostSoPath();
}

std::string PackageEnvInfo::GetTrustedBasePath(bool useV2) const
{
    constexpr int32_t peerNode = 0;
    constexpr uint32_t hdcNameMax = 256U;
    char_t path[hdcNameMax] = {};
    int32_t drvRet;
    if (useV2) {
        drvRet = drvHdcGetTrustedBasePathV2(peerNode, static_cast<int32_t>(logicDeviceId_), &path[0], hdcNameMax);
    } else {
        drvRet = drvHdcGetTrustedBasePath(peerNode, static_cast<int32_t>(logicDeviceId_), &path[0], hdcNameMax);
    }
    if (drvRet != DRV_ERROR_NONE) {
        TSD_ERROR("[PackageManager][deviceId_=%u] get trusted base path failed, ret[%d]", logicDeviceId_, drvRet);
    }
    return std::string(path);
}

void PackageEnvInfo::GetAscendLatestIntallPath(std::string& pkgBasePath) const
{
    GetEnvFromMmSys(MM_ENV_ASCEND_LATEST_INSTALL_PATH, "ASCEND_LATEST_INSTALL_PATH", pkgBasePath);
    if (pkgBasePath.empty()) {
        GetEnvFromMmSys(MM_ENV_ASCEND_HOME_PATH, "ASCEND_HOME_PATH", pkgBasePath);
        if (pkgBasePath.empty()) {
            pkgBasePath = "/usr/local/Ascend/latest/";
            TSD_INFO(
                "[TsdClient][logicDeviceId_=%u] ASCEND_LATEST_INSTALL_PATH is not set, use default value[%s]",
                logicDeviceId_, pkgBasePath.c_str());
        }
    }
    TSD_RUN_INFO("latest install path:%s", pkgBasePath.c_str());
}

TSD_StatusT PackageEnvInfo::GetTrustedBasePathFromDevice(int32_t& peerNode, std::string& dstDirPreFix) const
{
    peerNode = 0;
    dstDirPreFix = GetTrustedBasePath(true);
    return TSD_OK;
}

std::string PackageEnvInfo::GetCurHostMutexFile(bool useCannPath) const
{
    if (!useCannPath) {
        return QUEUE_SCHEDULE_SO;
    }
    int64_t masterId = 0;
    uint32_t phyId = 0U;
    auto drvRet = drvDeviceGetPhyIdByIndex(logicDeviceId_, &phyId);
    if (drvRet != DRV_ERROR_NONE) {
        TSD_RUN_WARN("Getting the physical ID was not successful, retCode[%d] deviceId[%u]", drvRet, logicDeviceId_);
        return QUEUE_SCHEDULE_SO;
    }
    TSD_INFO("deviceId[%u] physical ID[%u]", logicDeviceId_, phyId);
    drvRet = halGetDeviceInfo(phyId, MODULE_TYPE_SYSTEM, INFO_TYPE_MASTERID, &masterId);
    if (drvRet != DRV_ERROR_NONE) {
        TSD_RUN_WARN(
            "Calling halGetDeviceInfo was not successful, retCode[%d] deviceId[%u] physical ID[%u]", drvRet,
            logicDeviceId_, phyId);
        return QUEUE_SCHEDULE_SO;
    }
    const int64_t devOsId = masterId % SUPPORT_MAX_DEVICE_PER_HOST;
    std::string mutexFile = MUTEX_FILE_PREFIX + std::to_string(devOsId) + ".cfg";
    TSD_RUN_INFO(
        "get masterId:%lld, logicDeviceId:%u, physicalDeviceId[%u],devOsId:%lld, mutexFile:%s, maxcount:%lld", masterId,
        logicDeviceId_, phyId, devOsId, mutexFile.c_str(), SUPPORT_MAX_DEVICE_PER_HOST);
    return mutexFile;
}

bool PackageEnvInfo::GetShortSocVersion(std::string& shortSocVersion) const
{
    char_t socVersion[SOC_VERSION_LEN] = {};
    const auto drvRet = halGetSocVersion(logicDeviceId_, &socVersion[0U], SOC_VERSION_LEN);
    if (drvRet != DRV_ERROR_NONE) {
        TSD_RUN_WARN("get soc_version by halGetSocVersion failed");
        return false;
    }
    TSD_INFO("get soc_version:%s", socVersion);
    (void)fe::PlatformInfoManager::Instance().InitializePlatformInfo();
    fe::OptionalInfos optionalInfos;
    fe::PlatFormInfos platformInfos;
    (void)fe::PlatformInfoManager::Instance().GetPlatformInfos(socVersion, platformInfos, optionalInfos);
    const bool ret = platformInfos.GetPlatformRes("version", "Short_SoC_version", shortSocVersion);
    if (!ret) {
        TSD_RUN_WARN("get short_soc_version by fe::PlatFormInfos::GetPlatformRes failed.");
        return false;
    }
    TSD_RUN_INFO("get short_soc_version:%s", shortSocVersion.c_str());
    return true;
}

bool PackageEnvInfo::ResolvePackageTitle(uint32_t chipType, uint32_t platInfoMode, std::string& packageTitle)
{
    switch (static_cast<ChipType_t>(chipType)) {
        case CHIP_MINI:
            if (platInfoMode == static_cast<uint32_t>(ModeType::OFFLINE)) {
                packageTitle = "Ascend310RC";
            } else {
                packageTitle = "Ascend310";
            }
            break;
        case CHIP_ASCEND_910A:
            packageTitle = "Ascend910";
            break;
        case CHIP_DC:
            packageTitle = "Ascend310P";
            break;
        case CHIP_ASCEND_950:
        case CHIP_ASCEND_910B:
        case CHIP_CLOUD_V5:
        case CHIP_MINI_V3:
        case CHIP_ASCEND_350:
            packageTitle = "Ascend";
            break;
        default:
            packageTitle = "";
            break;
    }
    return !packageTitle.empty();
}

bool PackageEnvInfo::GetPackageTitle(std::string& packageTitle) const
{
    return ResolvePackageTitle(chipType_, platInfoMode_, packageTitle);
}

bool PackageEnvInfo::GetPackagePath(std::string& packagePath, const uint32_t packageType) const
{
    std::string ascendAicpuPath;
    GetEnvFromMmSys(MM_ENV_ASCEND_AICPU_PATH, "ASCEND_AICPU_PATH", ascendAicpuPath);
    if (ascendAicpuPath.empty()) {
        ascendAicpuPath = "/usr/local/Ascend/";
        TSD_INFO(
            "[TsdClient][deviceId=%u] environment variable ASCEND_AICPU_PATH is not set, use default "
            "value[%s]",
            logicDeviceId_, ascendAicpuPath.c_str());
    }
    std::string title = "";
    if (!GetPackageTitle(title)) {
        TSD_RUN_INFO("[TsdClient][deviceId=%u] skip load aicpu opkernel packages", logicDeviceId_);
        return false;
    }

    if (packageType == static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL) ||
        packageType == static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)) {
        packagePath = ascendAicpuPath + "/opp/" + title + "/aicpu/";
    } else if (packageType == static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP)) {
        packagePath = ascendAicpuPath + "/opp/built-in/";
    } else {
        return false;
    }

    TSD_INFO("[TsdClient][deviceId=%u] get packagePath[%s]", logicDeviceId_, packagePath.c_str());
    return true;
}

bool PackageEnvInfo::CheckPackageExistsOnce(const uint32_t packageType)
{
    std::string pkgPath;
    if (!GetPackagePath(pkgPath, packageType)) {
        TSD_INFO(
            "[TsdClient][deviceId=%u] Package path is invalid, skip load package file, packageType[%u]", logicDeviceId_,
            packageType);
        return false;
    }
    if ((mmAccess(pkgPath.c_str()) != EN_OK) || (mmIsDir(pkgPath.c_str()) != EN_OK)) {
        TSD_WARN(
            "[TsdClient][deviceId=%u] path[%s] does not exist, packageType[%u]", logicDeviceId_, pkgPath.c_str(),
            packageType);
        return false;
    }

    std::vector<std::string> packages = ScanAndMatchPackages(pkgPath, packageType);
    packageName_[packageType] = "";
    if (packages.size() != 1U) {
        TSD_RUN_INFO(
            "[TsdClient][deviceId=%u] pkg size[%zu] in path[%s] must be only one, skip send package, packageType[%u]",
            logicDeviceId_, packages.size(), pkgPath.c_str(), packageType);
        return false;
    }
    packageName_[packageType] = packages[0U];
    packagePath_[packageType] = pkgPath;
    TSD_RUN_INFO(
        "[TsdClient][deviceId=%u] set package path[%s], package name[%s], packageType[%u]", logicDeviceId_,
        packagePath_[static_cast<uint32_t>(packageType)].c_str(), packageName_[packageType].c_str(), packageType);
    return true;
}

std::vector<std::string> PackageEnvInfo::ScanAndMatchPackages(
    const std::string& pkgPath, const uint32_t packageType) const
{
    mmDirent2** fileList = nullptr;
    const int32_t fileCount = mmScandir2(pkgPath.c_str(), &fileList, nullptr, nullptr);
    if (fileCount < 0) {
        TSD_WARN(
            "[TsdClient][deviceId=%u] scandir path[%s] failed, packageType[%u]", logicDeviceId_, pkgPath.c_str(),
            packageType);
        return {};
    }
    std::vector<std::string> files;
    for (int32_t i = 0; i < fileCount; i++) {
        files.emplace_back(fileList[i]->d_name);
    }
    mmScandirFree2(fileList, fileCount);

    std::vector<std::string> packages;
    for (const std::string& fileName : files) {
        TSD_INFO(
            "[TsdClient][deviceId=%u] check file[%s], packageType[%u]", logicDeviceId_, fileName.c_str(), packageType);
        if (ValidateStr(fileName.c_str(), packagePattern_[packageType].c_str())) {
            TSD_INFO(
                "[TsdClient][deviceId=%u] find package[%s] in path[%s], packageType[%u]", logicDeviceId_,
                fileName.c_str(), pkgPath.c_str(), packageType);
            packages.emplace_back(fileName);
        }
    }
    return packages;
}

bool PackageEnvInfo::CheckPackageExists(const bool loadAicpuKernelFlag)
{
    bool hasPackage = false;
    std::vector<uint32_t> packageTypes;
    if (loadAicpuKernelFlag) {
        packageTypes.push_back(static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL));
        packageTypes.push_back(static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL));
    }
    packageTypes.push_back(static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP));
    for (const auto packageType : packageTypes) {
        if (CheckPackageExistsOnce(packageType)) {
            TSD_INFO("[TsdClient][deviceId=%u] get package successfully, packageType[%u]", logicDeviceId_, packageType);
            hasPackage = true;
        }
    }

    return hasPackage;
}

} // namespace tsd
