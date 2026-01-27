/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/aicpu_process_package_worker.h"

#include <fstream>
#include "inc/tsd_feature_ctrl.h"
#include "inc/tsd_path_mgr.h"
#include "inc/aicpu_package_process.h"
#include "inc/package_worker_utils.h"
#include "inc/process_util_common.h"
#include "inc/package_worker_factory.h"
#include "inc/tsd_hash_verify.h"

namespace tsd {
namespace {
constexpr uint32_t MAX_WAIT_TIME_FOR_AICPU_PACKAGE = 5U;
constexpr uint32_t MAX_WAIT_TIME_FOR_VF_AICPU_PACKAGE = 120U;
constexpr uint32_t MAX_WAIT_TIME_FOR_AICPU_PACKAGE_FPGA = 2600U;
static const std::vector<std::string> LIBRARY_LIST = {
    "/usr/lib64/libtensorflow.so",
    "/usr/lib64/aicpu_kernels/libaicpu_kernels.so", // 不能删libdvpp_kernels.so aicpu算子包里面没有放
    "/usr/lib64/aicpu_kernels/libcpu_kernels.so",
    "/usr/lib64/aicpu_kernels/libtensorflow.so",
    "/usr/lib64/aicpu_kernels/libtf_kernels.so",
    "/usr/lib64/aicpu_kernels/libtorch_cpu.so",
    "/usr/lib64/aicpu_kernels/libc10.so",
};
} // namespace

TSD_StatusT AicpuProcessPackageWorker::LoadPackage(const std::string &packagePath, const std::string &packageName)
{
    const std::lock_guard<std::mutex> lk(packageMtx_);
    PreProcessPackage(packagePath, packageName);

    const ScopeGuard removePackageGuard([this]() {
        if (!FeatureCtrl::IsHeterogeneousProduct()) {
            (void)PackageWorkerUtils::RemoveFile(originPackagePath_.realPath);
        }
    });

    if (!IsNeedLoadPackage()) {
        SetDecompressTimeToNow();
        TSD_INFO("No need decompress package.");
        return TSD_OK;
    }

    TSD_RUN_INFO("Start load package, originPkg=%s, decomPkg=%s, checkCode=%lu, pkgSize=%lu",
                 originPackagePath_.realPath.c_str(), decomPackagePath_.realPath.c_str(),
                 GetCheckCode(), GetOriginPackageSize());

    TSD_StatusT ret = TSD_OK;
    const ScopeGuard clearGuard([&ret, this]() {
        (void)PackageWorkerUtils::RemoveFile(decomPackagePath_.realPath);
        if (ret != TSD_OK) Clear();
    });

    ret = MoveOriginPackageToDecompressDir();
    if (ret != TSD_OK) {
        TSD_ERROR("Move package to decompress dir failed");
        return ret;
    }

    ret = PackageWorkerUtils::VerifyPackage(decomPackagePath_.realPath);
    if (ret != TSD_OK) {
        isVerifyOppFail_ = true;
        TSD_ERROR("Verify package failed, ret=%u", ret);
        return ret;
    }

    ret = DecompressPackage();
    if (ret != TSD_OK) {
        TSD_ERROR("Decompress package failed, ret=%d", ret);
        return ret;
    }

    ret = PostProcessPackage();
    if (ret != TSD_OK) {
        TSD_ERROR("Post process package failed, ret=%d", ret);
        return ret;
    }

    TSD_RUN_INFO("Load package success, originPkg=%s, decomPkg=%s, checkCode=%lu",
                 originPackagePath_.realPath.c_str(), decomPackagePath_.realPath.c_str(), GetCheckCode());

    return TSD_OK;
}


void AicpuProcessPackageWorker::PreProcessPackage(const std::string &packagePath, const std::string &packageName)
{
    isVerifyOppFail_ = false;
    soInstallRootPath_ = TsdPathMgr::BuildKernelSoRootPath(uniqueVfId_);
    memoryLimitFilePath_ = TsdPathMgr::BuildMemoryConfigLimitFileDir(deviceId_, vfId_);
    memoryUsedFilePath_ = TsdPathMgr::BuildMemoryConfigUsageFileDir(deviceId_, vfId_);

    DefaultPreProcessPackage(packagePath, packageName);
    return;
}

void AicpuProcessPackageWorker::SetDecompressPackagePath()
{
    const std::string decomPath = TsdPathMgr::BuildAicpuPackageRootPath(uniqueVfId_);
    std::string pkgName("");
    if ((uniqueVfId_ > 0) && (uniqueVfId_ < VDEVICE_MAX_CPU_NUM)) {
        pkgName = std::to_string(uniqueVfId_) + "_" + originPackagePath_.name;
    } else {
        pkgName = "vf" + std::to_string(uniqueVfId_) + "_" + originPackagePath_.name;
    }

    decomPackagePath_ = PackagePath(decomPath, pkgName);
    return;
}

std::string AicpuProcessPackageWorker::GetMovePackageToDecompressDirCmd() const
{
    std::string cmd("");
    // rm -f {decomPath}*.tar.gz ; {cp/mv} {orgFile} {decomFile}
    cmd.append("rm -f ")
       .append(decomPackagePath_.path)
       .append("*.tar.gz ; ");

    FeatureCtrl::IsHeterogeneousProduct() ? cmd.append("cp ") : cmd.append("mv ");

    cmd.append(originPackagePath_.realPath)
       .append(" ")
       .append(decomPackagePath_.realPath);

    return cmd;
}

TSD_StatusT AicpuProcessPackageWorker::DecompressPackage() const
{
    TSD_StatusT ret = TSD_OK;
    const bool isNeedMemLimit = PackageWorkerUtils::IsSetMemLimit(IsVfMode(), deviceId_, vfId_);
    uint64_t oldSize = 0UL;
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
        const uint64_t newSize = PackageWorkerUtils::GetDirSize(soInstallRootPath_);

        ret = PackageWorkerUtils::RestoreMemUsage(oldSize, newSize, deviceId_, vfId_, memoryLimitFilePath_);
        if (ret != TSD_OK) {
            TSD_ERROR("Check memory usage failed, deviceId=%u, vfId=%u, ret=%u", deviceId_, vfId_, ret);
            return ret;
        }
    }

    return ret;
}


std::string AicpuProcessPackageWorker::GetDecompressPackageCmd() const
{
    // mkdir -p {soInstallRootPath_} ; tar --no-same-owner -ozxf {decomPackagePath} {soInstallRootPath}
    std::string cmd("");
    cmd.append("mkdir -p ")
       .append(soInstallRootPath_)
       .append(" ; tar --no-same-owner -ozxf ")
       .append(decomPackagePath_.realPath)
       .append(" -C ")
       .append(soInstallRootPath_);

    return cmd;
}

TSD_StatusT AicpuProcessPackageWorker::PostProcessPackage()
{
    const std::string soInstallPath = TsdPathMgr::BuildKernelSoPath(soInstallRootPath_);
    TSD_StatusT ret = AicpuPackageProcess::CheckPackageName(soInstallPath, decomPackagePath_.name);
    if (ret != TSD_OK) {
        TSD_ERROR("Check package name failed, ret=%u, soInstallPath=%s, name=%s",
                  ret, soInstallPath.c_str(), decomPackagePath_.name.c_str());
        return ret;
    }

    ret = AicpuPackageProcess::MoveSoToSandBox(soInstallPath);
    if (ret != TSD_OK) {
        TSD_RUN_WARN("Move tf so to sandbox failed, ret=%u, path=%s", ret, soInstallRootPath_.c_str());
    }

    RemoveRedundantSoFile();
    const std::string hashFile = TsdPathMgr::BuildKernelHashCfgPath(soInstallRootPath_);
    TsdHashVerify::GetInstance()->ReadAndUpdateTsdHashValue(hashFile, HashMapType::AICPU_KERNELS_HASHMAP);
    (void)BasePackageWorker::PostProcessPackage();

    RecordFinish();

    TSD_INFO("Post process of aicpu process package success");

    return TSD_OK;
}

void AicpuProcessPackageWorker::RemoveRedundantSoFile() const
{
    if (vfId_ != 0) {
        TSD_INFO("In vf mode, don't need remove redundant so");
        return;
    }

    for (const std::string &libPath : LIBRARY_LIST) {
        PackageWorkerUtils::RemoveFile(libPath);
    }

    return;
}

void AicpuProcessPackageWorker::RecordFinish()
{
    isFinish_.notify_all();
    return;
}

TSD_StatusT AicpuProcessPackageWorker::UnloadPackage()
{
    const std::lock_guard<std::mutex> lk(packageMtx_);
    return TSD_OK;
}

uint64_t AicpuProcessPackageWorker::GetPackageCheckCode()
{
    std::unique_lock<std::mutex> lk(packageMtx_);
    if (GetCheckCode() == 0UL) {
        return 0UL;
    }

    if (!AicpuPackageProcess::IsSoExist(uniqueVfId_)) {
        SetCheckCode(0UL);
        return 0UL;
    }

    return GetCheckCode();
}

TSD_StatusT AicpuProcessPackageWorker::CheckSum(const uint64_t curCode)
{
    std::unique_lock<std::mutex> lk(packageMtx_);
    if (curCode == 0UL) {
        TSD_INFO("Current code is 0, skip check package code");
        return TSD_OK;
    }

    const uint32_t waitTime = IsFpgaEnv() ? MAX_WAIT_TIME_FOR_AICPU_PACKAGE_FPGA :
        (MAX_WAIT_TIME_FOR_AICPU_PACKAGE + MAX_WAIT_TIME_FOR_VF_AICPU_PACKAGE);
    TSD_INFO("Before wait for package check code, maxWaitTime=%us", waitTime);

    (void)isFinish_.wait_for(lk, std::chrono::seconds(waitTime), [curCode, this] () {
        TSD_INFO("Check sum, curCode=%lu, checkCode=%lu, deviceId=%u, vfId=%u",
                 curCode, GetCheckCode(), deviceId_, vfId_);
        return ((curCode == GetCheckCode()) || (isStop_.load()));
    });

    if (isStop_.load()) {
        return TSD_INTERNAL_ERROR;
    }

    if (isVerifyOppFail_) {
        TSD_ERROR("Get verify opp fail in check sum, deviceId=%u, vfId=%u", deviceId_, vfId_);
        return TSD_VERIFY_OPP_FAIL;
    }

    if (curCode != GetCheckCode()) {
        TSD_RUN_WARN("Check sum wait %u second timeout. deviceId=%u, vfId=%u, curCode=%lu, checkCode=%lu",
                     waitTime,  deviceId_, vfId_, curCode, GetCheckCode());
        return TSD_INTERNAL_ERROR;
    }

    return TSD_OK;
}

TSD_StatusT ExtendProcessPackageWorker::PostProcessPackage()
{
    const TSD_StatusT ret = AicpuPackageProcess::CopyExtendSoToCommonSoPath(soInstallRootPath_, IsAsanMode());
    if (ret != TSD_OK) {
        TSD_ERROR("Move extend so to common so path failed, ret=%u", ret);
        return ret;
    }

    const std::string hashFile = TsdPathMgr::BuildExtendKernelHashCfgPath(soInstallRootPath_);
    TsdHashVerify::GetInstance()->ReadAndUpdateTsdHashValue(hashFile, HashMapType::AICPU_KERNELS_HASHMAP);
    (void)BasePackageWorker::PostProcessPackage();

    RecordFinish();

    TSD_INFO("Post process of extend process package success");

    return TSD_OK;
}

TSD_StatusT AscendcppProcessPackageWorker::CopyAscendcppSoToCommonSoPath(const std::string &soInstallRootPath, const bool isAsan) const
{
    const std::string aicpuSoPath = TsdPathMgr::BuildKernelSoPath(soInstallRootPath);
    const std::string ascendcppSoPath = TsdPathMgr::BuildAscendcppSoPath(soInstallRootPath);
    const std::string ascendcppHashCfgPath = TsdPathMgr::BuildAscendcppKernelHashCfgPath(soInstallRootPath);
    const std::string hashCfgFile = ascendcppSoPath + BASE_HASH_CFG_FILE;
    std::string cmd;
    if (access(hashCfgFile.c_str(), F_OK) == 0) {
        cmd = "mkdir -p " + aicpuSoPath + " ; mv " + ascendcppSoPath + "*.so* " + aicpuSoPath +
              " ; mv " + hashCfgFile + " " + ascendcppHashCfgPath + " && rm -rf " + ascendcppSoPath;
    } else {
        cmd = "mkdir -p " + aicpuSoPath + " ; mv " + ascendcppSoPath + "*.so* " + aicpuSoPath +
              " && rm -rf " + ascendcppSoPath;
    }
    const int32_t ret = PackSystem(cmd.c_str());
    if ((isAsan) && (ret != 0)) {
        TSD_INFO("Move ascendcppSoPath so to common so path end. cmd=%s, ret=%d, reason=%s.",
                 cmd.c_str(), ret, SafeStrerror().c_str());
    } else if (ret != 0) {
        TSD_ERROR("Move ascendcppSoPath so to common so path failed. cmd=%s, ret=%d, reason=%s.",
                  cmd.c_str(), ret, SafeStrerror().c_str());
        return TSD_INTERNAL_ERROR;
    }

    TSD_RUN_INFO("Move ascendcppSoPath so to common so path success, cmd=%s", cmd.c_str());
    return TSD_OK;
}

TSD_StatusT AscendcppProcessPackageWorker::PostProcessPackage()
{
    const TSD_StatusT ret = CopyAscendcppSoToCommonSoPath(soInstallRootPath_, IsAsanMode());
    if (ret != TSD_OK) {
        TSD_ERROR("Move ascendcpp so to common so path failed, ret=%u", ret);
        return ret;
    }

    const std::string hashFile = TsdPathMgr::BuildAscendcppKernelHashCfgPath(soInstallRootPath_);
    TsdHashVerify::GetInstance()->ReadAndUpdateTsdHashValue(hashFile, HashMapType::AICPU_KERNELS_HASHMAP);
    (void)BasePackageWorker::PostProcessPackage();

    RecordFinish();

    TSD_INFO("Post process of ascendcpp process package success");

    return TSD_OK;
}

REGISTER_PACKAGE_WORKER(PackageWorkerType::PACKAGE_WORKER_AICPU_PROCESS, AicpuProcessPackageWorker);
REGISTER_PACKAGE_WORKER(PackageWorkerType::PACKAGE_WORKER_EXTEND_PROCESS, ExtendProcessPackageWorker);
REGISTER_PACKAGE_WORKER(PackageWorkerType::PACKAGE_WORKER_ASCENDCPP_PROCESS, AscendcppProcessPackageWorker);
} // namespace tsd