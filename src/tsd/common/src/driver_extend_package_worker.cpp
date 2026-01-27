/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/driver_extend_package_worker.h"

#include <mutex>
#include <fstream>
#include "inc/internal_api.h"
#include "inc/tsd_path_mgr.h"
#include "inc/package_worker_utils.h"
#include "inc/package_worker_factory.h"
#include "inc/tsd_hash_verify.h"
#include "driver/ascend_hal.h"
#include "inc/tsdaemon.h"

namespace tsd {
    namespace {
        constexpr const uint64_t MAX_VERION_INFO_LINE = 10UL;
        constexpr const char *VERSION_INFO_STR = "Version=";
    }

TSD_StatusT DriverExtendPackageWorker::LoadPackage(const std::string &packagePath, const std::string &packageName)
{
    const std::lock_guard<std::mutex> lk(packageMtx_);

    PreProcessPackage(packagePath, packageName);

    const ScopeGuard removePackageGuard([this]() {
        (void)PackageWorkerUtils::RemoveFile(originPackagePath_.realPath);
    });

    TSD_RUN_INFO("Start load driver extend package, originPkg=%s, decomPkg=%s",
                 originPackagePath_.realPath.c_str(), decomPackagePath_.realPath.c_str());
    return TSD_OK; 
}

TSD_StatusT DriverExtendPackageWorker::PostProcessPackage()
{
    TSD_StatusT ret = ReadAndUpdateDriverVersion();
    if (ret != TSD_OK) {
        TSD_ERROR("driver version update failed, ret=%u", ret);
        return ret;
    }
    ret = ExecuteScript();
    if (ret != TSD_OK) {
        TSD_ERROR("execute script failed, ret=%u", ret);
        return ret;
    }
    (void)BasePackageWorker::PostProcessPackage();

    TSD_INFO("Post process of driver extend package success");

    return TSD_OK;
}

void DriverExtendPackageWorker::SetDecompressPackagePath()
{
    const std::string decomPath = TsdPathMgr::BuildDriverExtendPackageRootPath(uniqueVfId_);
    decomPackagePath_ = PackagePath(decomPath, originPackagePath_.name);
    return;
}

bool DriverExtendPackageWorker::IsNeedLoadPackage()
{
    const uint64_t packageSize = GetOriginPackageSize();
    if (packageSize == GetCheckCode()) {
        TSD_RUN_INFO("No need load driver extend pkg, packageSize=%lu, checkCode=%lu", packageSize, GetCheckCode());
        return false;
    }
 
    return true;
}

std::string DriverExtendPackageWorker::GetMovePackageToDecompressDirCmd() const
{
    std::string cmd("");
    // rm -f {decomPath}*.tar.gz ; mv {orgFile} {decomFile}
    cmd.append("rm -f ")
       .append(decomPackagePath_.path)
       .append("*.tar.gz ; mv ")
       .append(originPackagePath_.realPath)
       .append(" ")
       .append(decomPackagePath_.realPath);

    return cmd;
}
 
std::string DriverExtendPackageWorker::GetDecompressPackageCmd() const
{
    std::string cmd("");
    cmd.append("sudo /var/tsdaemon_add_to_usermemory.sh decompress ")
       .append(std::to_string(uniqueVfId_))
       .append(" ")
       .append(originPackagePath_.name);

    return cmd;
}

TSD_StatusT DriverExtendPackageWorker::UnloadPackage()
{
    const std::lock_guard<std::mutex> lk(packageMtx_);
    return TSD_OK;
}

bool DriverExtendPackageWorker::IsBinHashCfgExist(const uint32_t uniqueVfId) const
{
    const std::string path = TsdPathMgr::BuildDriverExtendKernelSoRootPath(uniqueVfId) + "bin_hash.cfg";
    if (access(path.c_str(), F_OK) != 0) {
        TSD_INFO("Bin hash config does not exist, path=%s", path.c_str());
        return false;
    }
    return true;
}

uint64_t DriverExtendPackageWorker::GetPackageCheckCode()
{
    std::unique_lock<std::mutex> lk(packageMtx_);
    if (GetCheckCode() == 0UL) {
        return 0UL;
    }

    if (!DriverExtendPackageWorker::IsBinHashCfgExist(uniqueVfId_)) {
        SetCheckCode(0UL);
        return 0UL;
    }

    return GetCheckCode();
}

TSD_StatusT DriverExtendPackageWorker::DecompressPackage() const
{
    TSD_StatusT ret = TSD_OK;
    const bool isNeedMemLimit = PackageWorkerUtils::IsSetMemLimit(IsVfMode(), deviceId_, vfId_);
    uint64_t oldSize = 0UL;
    uint64_t newSize = 0UL;
    if (isNeedMemLimit) {
        ret = PackageWorkerUtils::CheckMemoryUsage(soInstallRootPath_, memoryLimitFilePath_,
                                                   memoryUsedFilePath_, deviceId_, vfId_);
        if (ret != TSD_OK) {
            TSD_ERROR("Check memory usage failed, deviceId=%u, vfId=%u, ret=%u", deviceId_, vfId_, ret);
            return ret;
        }

        oldSize = PackageWorkerUtils::GetDirSize(soInstallRootPath_);
    }

    ret = BasePackageWorker::DecompressPackage();
    if (ret != TSD_OK) {
        TSD_ERROR("Decompress package failed, ret=%u", ret);
        return ret;
    }

    if (isNeedMemLimit) {
        newSize = PackageWorkerUtils::GetDirSize(soInstallRootPath_);

        ret = PackageWorkerUtils::RestoreMemUsage(oldSize, newSize, deviceId_, vfId_, memoryLimitFilePath_);
        if (ret != TSD_OK) {
            TSD_ERROR("Check memory usage failed, deviceId=%u, vfId=%u, ret=%u", deviceId_, vfId_, ret);
            return ret;
        }
    }

    return ret;
}

void DriverExtendPackageWorker::PreProcessPackage(const std::string &packagePath, const std::string &packageName)
{
    soInstallRootPath_ = TsdPathMgr::BuildDriverExtendPackageDecRootPath(uniqueVfId_);
    memoryLimitFilePath_ = TsdPathMgr::BuildMemoryConfigLimitFileDir(deviceId_, vfId_);
    memoryUsedFilePath_ = TsdPathMgr::BuildMemoryConfigUsageFileDir(deviceId_, vfId_);

    DefaultPreProcessPackage(packagePath, packageName);

    return;
}

TSD_StatusT DriverExtendPackageWorker::ReadAndUpdateDriverVersion() const
{
    std::string verionFile = TsdPathMgr::BuildDriverExtendKernelSoRootPath(uniqueVfId_) + "version.info";
    std::ifstream ifFile(verionFile);
    if (!ifFile) {
        TSD_ERROR("open file:%s nok, reason=%s", verionFile.c_str(), SafeStrerror().c_str());
        return TSD_INTERNAL_ERROR;
    }
    const ScopeGuard fileGuard([&ifFile] () { ifFile.close(); });
    std::string verionStr;
    std::string inputLine;
    uint64_t lineCnt = 0UL;
    while ((getline(ifFile, inputLine)) && (lineCnt < MAX_VERION_INFO_LINE)) {
        lineCnt++;
        if (inputLine.compare(0, strlen(VERSION_INFO_STR), VERSION_INFO_STR) == 0) {
            verionStr = std::move(inputLine);
            break;
        } else {
            continue;
        }
    }

    if (verionStr.empty()) {
        TSD_ERROR("version info is empty");
        return TSD_INTERNAL_ERROR;
    }

    std::string versionValue = verionStr.substr(strlen(VERSION_INFO_STR));
    TSD_RUN_INFO("get version info:%s, version value:%s", verionStr.c_str(), versionValue.c_str());
    const void *updateValue = static_cast<const void *>(versionValue.c_str());
    if (TSDaemon::GetInstance()->GetVfMode()) {
        const drvError_t ret = halSetDeviceInfoByBuff(TSDaemon::GetInstance()->GetVfId(), MODULE_TYPE_SYSTEM,
            INFO_TYPE_SDK_EX_VERSION, const_cast<void *>(updateValue), versionValue.size());
        if (ret != DRV_ERROR_NONE) {
            TSD_ERROR("set verion info failed ret:%d, version:%s, index:%u", ret, versionValue.c_str(),
                TSDaemon::GetInstance()->GetVfId());
            return TSD_INTERNAL_ERROR;
        }
        TSD_RUN_INFO("set verion info success version:%s, index:%u", versionValue.c_str(),
            TSDaemon::GetInstance()->GetVfId());
    } else {
        for (uint32_t index = 0U; index < TSDaemon::GetInstance()->GetRealDeviceNum(); index++) {
            const drvError_t ret = halSetDeviceInfoByBuff(index, MODULE_TYPE_SYSTEM, INFO_TYPE_SDK_EX_VERSION,
                const_cast<void *>(updateValue), versionValue.size());
            if (ret != DRV_ERROR_NONE) {
                TSD_ERROR("set verion info failed ret:%d, version:%s, index:%u", ret, versionValue.c_str(), index);
                return TSD_INTERNAL_ERROR;
            }
            TSD_RUN_INFO("set verion info success version:%s, index:%u", versionValue.c_str(), index);
        }
    }
    return TSD_OK;
}
TSD_StatusT DriverExtendPackageWorker::ExecuteScript() const
{
    return TSD_OK;
}

TSD_StatusT DriverExtendPackageWorker::BackupTheOldFile() const
{
    std::string cmd("sudo /var/tsdaemon_add_to_usermemory.sh backup ");
    cmd.append(std::to_string(uniqueVfId_));
    TSD_RUN_INFO("backup cmd:%s", cmd.c_str());
    const int32_t ret = PackSystem(cmd.c_str());
    if (ret != 0) {
        TSD_ERROR("back up file failed. cmd=%s, ret=%d, reason=%s.", cmd.c_str(), ret, SafeStrerror().c_str());
        return TSD_INTERNAL_ERROR;
    }
    return TSD_OK;
}

void DriverExtendPackageWorker::ReStoreTheBackupFile() const
{
    std::string cmd("sudo /var/tsdaemon_add_to_usermemory.sh restore ");
    cmd.append(std::to_string(uniqueVfId_));
    TSD_RUN_INFO("restore cmd:%s", cmd.c_str());
    const int32_t ret = PackSystem(cmd.c_str());
    if (ret != 0) {
        TSD_RUN_WARN("back up file failed. cmd=%s, ret=%d, reason=%s.", cmd.c_str(), ret, SafeStrerror().c_str());
        return;
    }
}

TSD_StatusT DriverExtendPackageWorker::LoadPackageWhenTsdEmpty()
{
    TSD_StatusT ret = TSD_OK;
    const ScopeGuard clearGuard([&ret, this]() {
        (void)PackageWorkerUtils::RemoveFile(decomPackagePath_.realPath);
        if (ret != TSD_OK) { Clear(); }
    });

    TSD_RUN_INFO("Load driver extend package success, originPkg=%s, decomPkg=%s, checkCode=%lu",
                 originPackagePath_.realPath.c_str(), decomPackagePath_.realPath.c_str(), GetCheckCode());
    return TSD_OK;
}
REGISTER_PACKAGE_WORKER(PackageWorkerType::PACKAGE_WORKER_DRIVER_EXTEND, DriverExtendPackageWorker);
} // namespace tsd