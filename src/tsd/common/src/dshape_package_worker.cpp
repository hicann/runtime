/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/dshape_package_worker.h"

#include <mutex>
#include "inc/internal_api.h"
#include "inc/tsd_path_mgr.h"
#include "inc/package_worker_utils.h"
#include "inc/package_worker_factory.h"


namespace tsd {
namespace {
constexpr uint64_t HELPER_PKG_REMOVE_DELAY = 120UL;
}

TSD_StatusT DshapePackageWorker::LoadPackage(const std::string &packagePath, const std::string &packageName)
{
    const std::lock_guard<std::mutex> lk(packageMtx_);

    PreProcessPackage(packagePath, packageName);

    const ScopeGuard removePackageGuard([this]() {
        (void)PackageWorkerUtils::RemoveFile(originPackagePath_.realPath);
    });

    if (!IsNeedLoadPackage()) {
        SetDecompressTimeToNow();
        TSD_INFO("No need decompress dshape package.");
        return TSD_OK;
    }

    TSD_RUN_INFO("Start load dshape package, originPkg=%s, decomPkg=%s",
                 originPackagePath_.realPath.c_str(), decomPackagePath_.realPath.c_str());

    TSD_StatusT ret = TSD_OK;
    const ScopeGuard clearGuard([&ret, this]() {
        (void)PackageWorkerUtils::RemoveFile(decomPackagePath_.realPath);
        if (ret != TSD_OK) { Clear(); }
    });

    ret = MoveOriginPackageToDecompressDir();
    if (ret != TSD_OK) {
        TSD_ERROR("Move dshape package to decompress dir failed, ret=%d", ret);
        return ret;
    }

    ret = PackageWorkerUtils::VerifyPackage(decomPackagePath_.realPath);
    if (ret != TSD_OK) {
        TSD_ERROR("Verify dshape package failed, ret=%d", ret);
        return ret;
    }

    ret = DecompressPackage();
    if (ret != TSD_OK) {
        TSD_ERROR("Decompress dshape package failed, ret=%d", ret);
        return ret;
    }

    ret = PostProcessPackage();
    if (ret != TSD_OK) {
        TSD_ERROR("Post process dshape package failed, ret=%d", ret);
        return ret;
    }

    TSD_RUN_INFO("Load dshape package success, originPkg=%s, decomPkg=%s, checkCode=%lu",
                 originPackagePath_.realPath.c_str(), decomPackagePath_.realPath.c_str(), GetCheckCode());

    return TSD_OK;
}

void DshapePackageWorker::SetDecompressPackagePath()
{
    const std::string decomPath = TsdPathMgr::GetHeterogeneousPkgCommonPrefixPath(uniqueVfId_);
    decomPackagePath_ = PackagePath(decomPath, originPackagePath_.name);
    return;
}

bool DshapePackageWorker::IsNeedLoadPackage()
{
    const uint64_t packageSize = GetOriginPackageSize();
    if ((packageSize == GetCheckCode()) || (IsVfMode())) {
        TSD_RUN_INFO("No need load dshape pkg, packageSize=%lu, checkCode=%lu", packageSize, GetCheckCode());
        return false;
    }
 
    return true;
}

std::string DshapePackageWorker::GetMovePackageToDecompressDirCmd() const
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
 
std::string DshapePackageWorker::GetDecompressPackageCmd() const
{
    std::string cmd("");
    cmd.append("rm -rf ")
       .append(TsdPathMgr::GetHeterogeneousOppPkgPath(uniqueVfId_))
       .append(" ; tar -xf ")
       .append(decomPackagePath_.realPath)
       .append(" -C ")
       .append(decomPackagePath_.path);

    return cmd;
}

TSD_StatusT DshapePackageWorker::UnloadPackage()
{
    const std::unique_lock<std::mutex> lk(packageMtx_, std::try_to_lock);
    if (!lk.owns_lock()) {
        TSD_INFO("Dshape package does not have package lock");
        return TSD_OK;
    }
 
    if (!IsNeedUnloadPackage()) {
        return TSD_OK;
    }

    const ScopeGuard clearGuard([this]() { Clear(); });
 
    const std::string dstPath = TsdPathMgr::GetHeterogeneousOppPkgPath(uniqueVfId_);
    const std::string opsPath = TsdPathMgr::GetHeterogeneousOpsPkgPath(uniqueVfId_);
    std::string removeCmd = "rm -rf " + dstPath + " ; rm -rf " + opsPath;
    const int32_t ret = PackSystem(removeCmd.c_str());
    if (ret != TSD_OK) {
        TSD_RUN_WARN("Unload dshape package failed. ret=%d, cmd=%s, reason=%s",
                     ret, removeCmd.c_str(), strerror(errno));
    }

    TSD_RUN_INFO("Unload dshape package end, pkg=%s", dstPath.c_str());

    return TSD_OK;
}

bool DshapePackageWorker::IsNeedUnloadPackage()
{
    if (GetCheckCode() == 0UL) {
        return false;
    }

    const TimePoint curTime = std::chrono::high_resolution_clock::now();
    if (curTime <= GetDecompressTime()) {
        TSD_RUN_INFO("No need unload dshape package, current time bofore decompress time");
        return false;
    }

    const size_t duration = std::chrono::duration_cast<std::chrono::seconds>(curTime - GetDecompressTime()).count();
    if (duration < HELPER_PKG_REMOVE_DELAY) {
        TSD_INFO("No need unload dshape package by package delay unload, duration=%lu, max=%lu",
                 duration, HELPER_PKG_REMOVE_DELAY);
        return false;
    }

    return true;
}

REGISTER_PACKAGE_WORKER(PackageWorkerType::PACKAGE_WORKER_DSHAPE, DshapePackageWorker);
} // namespace tsd