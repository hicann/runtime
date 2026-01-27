/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/runtime_package_worker.h"

#include "inc/log.h"
#include "inc/tsd_util.h"
#include "inc/tsd_path_mgr.h"
#include "inc/internal_api.h"
#include "inc/package_worker_utils.h"
#include "inc/package_worker_factory.h"


namespace tsd {
namespace {
constexpr uint64_t HELPER_PKG_REMOVE_DELAY = 120UL;
} // namespace

TSD_StatusT RuntimePackageWorker::LoadPackage(const std::string &packagePath, const std::string &packageName)
{
    const std::lock_guard<std::mutex> lk(packageMtx_);

    PreProcessPackage(packagePath, packageName);

    const ScopeGuard removePackageGuard([this]() { 
        (void)PackageWorkerUtils::RemoveFile(originPackagePath_.realPath);
    });

    if (!IsNeedLoadPackage()) {
        SetDecompressTimeToNow();
        TSD_INFO("No need decompress runtime package.");
        return TSD_OK;
    }

    TSD_RUN_INFO("Start load runtime package, originPkg=%s, decomPkg=%s",
                 originPackagePath_.realPath.c_str(), decomPackagePath_.realPath.c_str());

    TSD_StatusT ret = TSD_OK;
    const ScopeGuard clearGuard([&ret, this]() {
        (void)PackageWorkerUtils::RemoveFile(decomPackagePath_.realPath);
        if (ret != TSD_OK) { Clear(); }
    });

    ret = MoveOriginPackageToDecompressDir();
    if (ret != TSD_OK) {
        TSD_ERROR("Move runtime package to decompress dir failed");
        return ret;
    }

    ret = PackageWorkerUtils::VerifyPackage(decomPackagePath_.realPath);
    if (ret != TSD_OK) {
        TSD_ERROR("Verify runtime package failed, ret=%d", ret);
        return ret;
    }

    ret = DecompressPackage();
    if (ret != TSD_OK) {
        TSD_ERROR("Decompress runtime package failed, ret=%d", ret);
        return ret;
    }

    ret = PostProcessPackage();
    if (ret != TSD_OK) {
        TSD_ERROR("Post process runtime package failed, ret=%d", ret);
        return ret;
    }

    TSD_RUN_INFO("Load runtime package success, originPkg=%s, decomPkg=%s, checkCode=%lu",
                 originPackagePath_.realPath.c_str(), decomPackagePath_.realPath.c_str(), GetCheckCode());

    return TSD_OK;
}

void RuntimePackageWorker::SetDecompressPackagePath()
{
    const std::string decomPath = TsdPathMgr::GetHeterogeneousPkgCommonPrefixPath(uniqueVfId_);
    decomPackagePath_ = PackagePath(decomPath, originPackagePath_.name);
    return;
}

bool RuntimePackageWorker::IsNeedLoadPackage()
{
    const uint64_t packageSize = GetOriginPackageSize();
    if ((packageSize == GetCheckCode()) || (IsVfMode())) {
        TSD_RUN_INFO("No need load runtime package, packageSize=%lu, checkCode=%lu", packageSize, GetCheckCode());
        return false;
    }

    return true;
}

std::string RuntimePackageWorker::GetMovePackageToDecompressDirCmd() const
{
    std::string cmd("");
    // rm -f {decomPath}*.tar.gz ; mv -f {orgFile} {decomFile}
    cmd.append("rm -f ")
       .append(decomPackagePath_.path)
       .append("*.tar.gz ; mv -f ")
       .append(originPackagePath_.realPath)
       .append(" ")
       .append(decomPackagePath_.realPath);

    return cmd;
}

std::string RuntimePackageWorker::GetDecompressPackageCmd() const
{
    std::string cmd("");
    cmd.append("tar -xf ")
       .append(decomPackagePath_.realPath)
       .append(" -C ")
       .append(decomPackagePath_.path);

    return cmd;
}

TSD_StatusT RuntimePackageWorker::PostProcessPackage()
{
    const std::string runtimePkgPath = TsdPathMgr::GetHeterogeneousRuntimePkgPath(uniqueVfId_);
    const std::string cmd = "chmod -R 750 " + runtimePkgPath;
    const int32_t ret = PackSystem(cmd.c_str());
    if (ret != 0) {
        TSD_RUN_WARN("Change runtime package mode failed, ret=%d, cmd=%s, reason=%s",
                     ret, cmd.c_str(), strerror(errno));
    }

    (void)BasePackageWorker::PostProcessPackage();

    return TSD_OK;
}

TSD_StatusT RuntimePackageWorker::UnloadPackage()
{
    return TSD_OK;
}

bool RuntimePackageWorker::IsNeedUnloadPackage()
{
    if (GetCheckCode() == 0UL) {
        return false;
    }

    const TimePoint curTime = std::chrono::high_resolution_clock::now();
    if (curTime <= GetDecompressTime()) {
        TSD_RUN_INFO("No need unload runtime package, current time bofore decompress time");
        return false;
    }

    const size_t duration = std::chrono::duration_cast<std::chrono::seconds>(curTime - GetDecompressTime()).count();
    if (duration < HELPER_PKG_REMOVE_DELAY) {
        TSD_INFO("No need unload runtime package by package delay unload, duration=%lu, max=%lu",
                 duration, HELPER_PKG_REMOVE_DELAY);
        return false;
    }

    return true;
}

REGISTER_PACKAGE_WORKER(PackageWorkerType::PACKAGE_WORKER_RUNTIME, RuntimePackageWorker);
} // namespace tsd
