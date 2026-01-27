/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/common_sink_package_worker.h"

#include <mutex>
#include <fstream>
#include "inc/internal_api.h"
#include "inc/tsd_path_mgr.h"
#include "inc/package_worker_utils.h"
#include "inc/package_worker_factory.h"
#include "driver/ascend_hal.h"
#ifndef TDT_HOST_LIB
#include "inc/tsdaemon.h"
#endif
#include "inc/package_process_config.h"
#include "inc/process_util_common.h"
#include "inc/weak_ascend_hal.h"
 
namespace tsd {
namespace {
    const std::string ENV_NAME_HOME = "HOME";
    const std::string COMMON_SINK_PATH_HEAD = "/home/HwHiAiUser/device-compat-plugin/";
}
TSD_StatusT CommonSinkPackageWorker::LoadPackage(const std::string &packagePath, const std::string &packageName)
{
    const std::lock_guard<std::mutex> lk(packageMtx_);
    const size_t pos = packageName.find("_");
    if ((pos == std::string::npos) || (pos == packageName.size())) {
        TSD_ERROR("invalid package name:%s", packageName.c_str());
        return TSD_INTERNAL_ERROR;
    }

    const std::string tempName = packageName.substr(pos + 1);
    PackageProcessConfig *pkgConf = PackageProcessConfig::GetInstance();
    PackConfDetail curConf = pkgConf->GetConfigDetailInfo(tempName);
    if (!curConf.validFlag) {
        TSD_ERROR("current package:%s cannot find config info", tempName.c_str());
        return TSD_INTERNAL_ERROR;
    }
    curConf.PrintfInfo(tempName);
    SetOriPkgPureName(tempName);
    soInstallRootPath_ = GetSoInstallPathByConfig(static_cast<uint32_t>(curConf.decDstDir));
    PreProcessPackage(packagePath, packageName);

    const ScopeGuard removePackageGuard([this]() {
        (void)PackageWorkerUtils::RemoveFile(originPackagePath_.realPath);
    });
    
    if (!IsNeedLoadPackageByName(tempName)) {
        SetDecompressTimeToNow();
        TSD_INFO("No need decompress current package:%s.", packageName.c_str());
        return TSD_OK;
    }
    bool needIdle = false;
    TSD_RUN_INFO("Start common sink package, originPkg=%s, decomPkg=%s, needIdle:%u",
                 originPackagePath_.realPath.c_str(), decomPackagePath_.realPath.c_str(),
                 static_cast<uint32_t>(needIdle));
#ifndef TDT_HOST_LIB
    if (needIdle) {
        auto startLoadPackage = [this]() {
            return this->StartLoadCommonSinkPackage();
        };
        return TSDaemon::GetInstance()->DoCallBackWhenTsdImplEmpty(startLoadPackage,
            TSD_LOAD_COMMON_SINK_PKG_FAILED_BY_BUSY);
    } else {
        return StartLoadCommonSinkPackage();
    }
#else
    return StartLoadCommonSinkPackage();
#endif
}

std::string CommonSinkPackageWorker::GetCommonSinkTmpStorePath() const
{
    std::string path(COMMON_SINK_PATH_HEAD);
    if ((uniqueVfId_ > 0U) && (uniqueVfId_ < VDEVICE_MAX_CPU_NUM)) {
        (void)path.append(std::to_string(uniqueVfId_)).append("/");
    }
    return path;
}

void CommonSinkPackageWorker::SetDecompressPackagePath()
{
    const std::string decomPath = GetCommonSinkTmpStorePath();
    decomPackagePath_ = PackagePath(decomPath, originPackagePath_.name);
    return;
}

bool CommonSinkPackageWorker::IsNeedLoadPackage()
{
    return true;
}

bool CommonSinkPackageWorker::IsNeedLoadPackageByName(const std::string &fileName)
{
    SetOriPkgHashCode(CalOriginalPkgHashCode());
    const std::string storeHashCode = GetProcessedPkgHashCode(fileName);
    if (GetOriPkgHashCode() == storeHashCode) {
        TSD_RUN_INFO("No need load package:%s, store=%s, host:%s",
            fileName.c_str(), storeHashCode.c_str(), GetOriPkgHashCode().c_str());
        return false;
    }
    return true;
}

std::string CommonSinkPackageWorker::GetMovePackageToDecompressDirCmd() const
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
 
std::string CommonSinkPackageWorker::GetDecompressPackageCmd() const
{
    std::string cmd("");
    cmd.append("mkdir -p -m 0750 ")
    .append(soInstallRootPath_)
    .append(" ; tar --same-owner --same-permissions -ozxf ")
    .append(decomPackagePath_.realPath)
    .append(" -C ")
    .append(soInstallRootPath_);
    return cmd;
}

TSD_StatusT CommonSinkPackageWorker::UnloadPackage()
{
    const std::lock_guard<std::mutex> lk(packageMtx_);
    return TSD_OK;
}

TSD_StatusT CommonSinkPackageWorker::DecompressPackage() const
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

std::string CommonSinkPackageWorker::SetAicpuThreadModeInstallPath() const
{
    std::string installPath("");
    std::string pathEnv("");
    GetScheduleEnv(ENV_NAME_HOME.c_str(), pathEnv);
    if (pathEnv.empty()) {
        TSD_ERROR("Get env %s is empty", ENV_NAME_HOME.c_str());
        return installPath;
    }

    if (!CheckValidatePath(pathEnv)) {
        TSD_ERROR("Env %s invalid, val=%s", ENV_NAME_HOME.c_str(), pathEnv.c_str());
        return installPath;
    }

    if (!CheckRealPath(pathEnv)) {
        TSD_ERROR("Can not get realpath of env %s, val=%s", ENV_NAME_HOME.c_str(), pathEnv.c_str());
        return installPath;
    }

    std::string dstPath = pathEnv + "/";
    if (IsAicpuHeterogeneousThreadMode()) {
        dstPath += "inuse/";
    }
    return TsdPathMgr::BuildKernelSoRootPath(uniqueVfId_, dstPath);
}

std::string CommonSinkPackageWorker::GetSoInstallPathByConfig(const uint32_t conPath) const
{
    std::string installPath = "";
    const DeviceInstallPath installType = static_cast<DeviceInstallPath>(conPath);
    switch (installType) {
        case DeviceInstallPath::RUNTIME_PATH: {
            installPath = TsdPathMgr::GetHeterogeneousRuntimePkgPath(uniqueVfId_);
            break;
        }
        case DeviceInstallPath::OM_PATH: {
            installPath = TsdPathMgr::GetHeterogeneousPkgCommonPrefixPath(uniqueVfId_).append("omfile/");
            break;
        }
        case DeviceInstallPath::AICPU_KERNELS_PATH: {
#ifdef TDT_HOST_LIB
            installPath = SetAicpuThreadModeInstallPath();
#else
            installPath = TsdPathMgr::BuildKernelSoRootPath(uniqueVfId_);
#endif
            break;
        }
        case DeviceInstallPath::COMPAT_PLUGIN_PATH: {
            installPath = TsdPathMgr::BuildCompatPluginPackageDecRootPath(uniqueVfId_);
            break;
        }
        default: {
            TSD_ERROR("invalid install path:%u", static_cast<uint32_t>(conPath));
            break;
        }
    }
    TSD_INFO("get install path:%s", installPath.c_str());
    return installPath;
}

void CommonSinkPackageWorker::PreProcessPackage(const std::string &packagePath, const std::string &packageName)
{
    memoryLimitFilePath_ = TsdPathMgr::BuildMemoryConfigLimitFileDir(deviceId_, vfId_);
    memoryUsedFilePath_ = TsdPathMgr::BuildMemoryConfigUsageFileDir(deviceId_, vfId_);

    DefaultPreProcessPackage(packagePath, packageName);

    return;
}

TSD_StatusT CommonSinkPackageWorker::StartLoadCommonSinkPackage()
{
    TSD_StatusT ret = TSD_OK;
    const ScopeGuard clearGuard([&ret, this]() {
        (void)PackageWorkerUtils::RemoveFile(decomPackagePath_.realPath);
        if (ret != TSD_OK) { Clear(); }
    });

    ret = MoveOriginPackageToDecompressDir();
    if (ret != TSD_OK) {
        TSD_ERROR("Move driver extend package to decompress dir failed, ret=%d", ret);
        return ret;
    }

    ret = PackageWorkerUtils::VerifyPackage(decomPackagePath_.realPath);
    if (ret != TSD_OK) {
        TSD_ERROR("Verify driver extend package failed, ret=%d", ret);
        return ret;
    }

    ret = DecompressPackage();
    if (ret != TSD_OK) {
        SetCurPkgHashCode(GetOriPkgPureName(), "");
        TSD_ERROR("Decompress common sink package failed, ret=%d", ret);
        return ret;
    }

    ret = PostProcessPackage();
    if (ret != TSD_OK) {
        SetCurPkgHashCode(GetOriPkgPureName(), "");
        (void)LoadTsFw(true);
        TSD_ERROR("Post process common sink package failed, ret=%d", ret);
        return ret;
    }
    SetCurPkgHashCode(GetOriPkgPureName(), GetOriPkgHashCode());
    TSD_RUN_INFO("Load common sink package success, originPkg=%s, decomPkg=%s, checkCode=%s",
                 originPackagePath_.realPath.c_str(), decomPackagePath_.realPath.c_str(), GetOriPkgHashCode().c_str());
    return TSD_OK;
}

TSD_StatusT CommonSinkPackageWorker::PostProcessPackage()
{
    const auto ret = LoadTsFw();
    if (ret != TSD_OK) {
        TSD_ERROR("LoadTsFw failed, ret=%u.", ret);
        return ret;
    }
    return TSD_OK;
}

std::string CommonSinkPackageWorker::GetProcessedPkgHashCode(const std::string &pkgName)
{
    const std::lock_guard<std::mutex> lk(priInfoMtx_);
    const auto iter = pkgPrivInfo_.find(pkgName);
    if (iter != pkgPrivInfo_.end()) {
        TSD_INFO("get package:%s, hash value:%s", pkgName.c_str(), iter->second.hashCode.c_str());
        return iter->second.hashCode;
    } else {
        return "";
    }
}

void CommonSinkPackageWorker::SetCurPkgHashCode(const std::string &pkgName, const std::string &hashCode)
{
    const std::lock_guard<std::mutex> lk(priInfoMtx_);
    const auto iter = pkgPrivInfo_.find(pkgName);
    if (iter != pkgPrivInfo_.end()) {
        iter->second.hashCode = hashCode;
    } else {
        SinkPkgPriInfo tempNode = {};
        tempNode.hashCode = hashCode;
        pkgPrivInfo_[pkgName] = tempNode;
    }
}
std::string CommonSinkPackageWorker::CalOriginalPkgHashCode()
{
    return ProcessUtilCommon::CalFileSha256HashValue(originPackagePath_.realPath);
}

void CommonSinkPackageWorker::GetAllPackageHashCode(std::map<std::string, std::string> &pkgHashMap)
{
    const std::lock_guard<std::mutex> lk(priInfoMtx_);
    for (auto iter = pkgPrivInfo_.begin(); iter != pkgPrivInfo_.end(); iter++) {
        pkgHashMap[iter->first] = iter->second.hashCode;
        TSD_INFO("get package:%s, hashcode:%s", iter->first.c_str(), iter->second.hashCode.c_str());
    }
}

TSD_StatusT CommonSinkPackageWorker::LoadTsFw(const bool reset) const
{
#ifdef SUPPORT_LOAD_TSFW
    if (GetOriPkgHashCode() != "cann-tsch-compat.tar.gz") {
        TSD_INFO("current package dose not need to load tsfw");
        return TSD_OK;
    }
    if (&halTsPkgLoad == nullptr) {
        TSD_ERROR("halTsPkgLoad is nullptr");
        return TSD_INTERNAL_ERROR;
    }

    if (TSDaemon::GetInstance()->GetVfMode()) {
        TSD_INFO("vf mode dose not need to load tsfw");
        return TSD_OK;
    }

    TSFW_LOAD_TYPE loadType = reset ? TSFW_DRV_PLUGIN_LOAD : TSFW_PLUGIN_LOAD;
    for (uint32_t index = 0U; index < TSDaemon::GetInstance()->GetRealDeviceNum(); index++) {
        const auto ret = halTsPkgLoad(index, loadType, 0U);
        if ((ret != DRV_ERROR_NONE) && (ret != DRV_ERROR_NOT_SUPPORT)) {
            TSD_ERROR("Fail to halTsPkgLoad[%d] for device[%u], ret is %d", static_cast<int32_t>(loadType),
                index, static_cast<int32_t>(ret));
            return TSD_INTERNAL_ERROR;
        }
    }
    TSD_RUN_INFO("halTsPkgLoad[%d] for device[%u] success, ret is %d", static_cast<int32_t>(loadType),
        index, static_cast<int32_t>(ret));
    return TSD_OK;
#else
    TSD_INFO("load tsfw flag:%u", static_cast<uint32_t>(reset));
    return TSD_OK;
#endif
}
 
REGISTER_PACKAGE_WORKER(PackageWorkerType::PACKAGE_WORKER_COMMON_SINK, CommonSinkPackageWorker);
} // namespace tsd