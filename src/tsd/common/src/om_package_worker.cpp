/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/om_package_worker.h"
 
#include <fcntl.h>
#include "inc/internal_api.h"
#include "inc/tsd_path_mgr.h"
#include "inc/package_worker_utils.h"
#include "inc/package_worker_factory.h"


namespace tsd {
namespace {
const std::string OM_VERIFY_FILE_NAME = "omfileflag.info";
constexpr uint32_t OM_FILE_PATH_MAX_LEN = 100U;
constexpr size_t STRING_DEVICE_LENGTH = 6;
} // namespace

TSD_StatusT OmPackageWorker::LoadPackage(const std::string &packagePath, const std::string &packageName)
{
    const std::lock_guard<std::mutex> lk(packageMtx_);

    PreProcessPackage(packagePath, packageName);

    const ScopeGuard removePackageGuard([this]() {
        (void)PackageWorkerUtils::RemoveFile(originPackagePath_.realPath);
    });

    if (!IsNeedLoadPackage()) {
        SetDecompressTimeToNow();
        TSD_RUN_INFO("No need decompress om package.");
        return TSD_OK;
    }

    TSD_RUN_INFO("Start load om package, originPkg=%s, decomPkg=%s",
                 originPackagePath_.realPath.c_str(), decomPackagePath_.realPath.c_str());

    TSD_StatusT ret = TSD_OK;
    const ScopeGuard clearGuard([&ret, this]() {
        (void)PackageWorkerUtils::RemoveFile(decomPackagePath_.realPath);
        if (ret != TSD_OK) {
            Clear();
            const std::string cmd = "rm -rf " + decomPackagePath_.path;
            (void)PackSystem(cmd.c_str());
        }
    });

    ret = MoveOriginPackageToDecompressDir();
    if (ret != TSD_OK) {
        TSD_ERROR("Move om package to decompress dir failed, ret=%d", ret);
        return ret;
    }

    ret = DecompressPackage();
    if (ret != TSD_OK) {
        TSD_ERROR("Decompress om pkg failed, ret=%d", ret);
        return ret;
    }

    ret = PostProcessPackage();
    if (ret != TSD_OK) {
        TSD_ERROR("Post process om pkg failed, ret=%d", ret);
        return ret;
    }

    TSD_RUN_INFO("Load om package success, originPkg=%s, decomPkg=%s, verifyName=%s, checkCode=%lu",
                 originPackagePath_.realPath.c_str(), decomPackagePath_.realPath.c_str(),
                 decomPackagePath_.name.c_str(), GetCheckCode());

    return TSD_OK;
}

void OmPackageWorker::PreProcessPackage(const std::string &packagePath, const std::string &packageName)
{
    dualDieDeviceId_ = ExtractDualDieDeviceId(packagePath);

    // Om package decompress in it's own dir, dir name is hostpid
    const TSD_StatusT ret = GetHostPidFromPackageName(packageName);
    if (ret != TSD_OK) {
        TSD_ERROR("Get host pid form pkg name failed, ret=%d", ret);
    }

    BasePackageWorker::DefaultPreProcessPackage(packagePath, packageName);

    return;
}

TSD_StatusT OmPackageWorker::GetHostPidFromPackageName(const std::string &packageName)
{
    const std::size_t pos = packageName.find("_");
    if (pos == std::string::npos) {
        TSD_ERROR("Get hostpid in pkg name failed, pkgName=%s", packageName.c_str());
        return TSD_INTERNAL_ERROR;
    }

    hostPid_ = packageName.substr(0, pos);

    return TSD_OK;
}

void OmPackageWorker::SetDecompressPackagePath()
{
    const std::string decomPath = TsdPathMgr::GetHeterogeneousOmFilePrefixPath(uniqueVfId_, hostPid_);
    decomPackagePath_ = PackagePath(decomPath, originPackagePath_.name);
    return;
}

bool OmPackageWorker::IsNeedLoadPackage()
{
    if (IsVfMode()) {
        TSD_RUN_INFO("No need load om package in vf mode");
        return false;
    }

    return true;
}

std::string OmPackageWorker::GetMovePackageToDecompressDirCmd() const
{
    std::string cmd("");
    // rm -f {decomPath}*.tar.gz && mv {orgFile} {decomFile}
    cmd.append("rm -f ")
       .append(decomPackagePath_.path)
       .append("*.tar.gz ; mv ")
       .append(originPackagePath_.realPath)
       .append(" ")
       .append(decomPackagePath_.realPath);

    return cmd;
}

std::string OmPackageWorker::GetDecompressPackageCmd() const
{
    // rm -rf {decomPath/OM_VERIFY_FILE_NAME} ; tar -xf {decomFile} -C {decomPath}
    std::string cmd("");
    cmd.append("rm -rf ")
       .append(decomPackagePath_.path + std::to_string(dualDieDeviceId_) + OM_VERIFY_FILE_NAME)
       .append(" ; tar -xf ")
       .append(decomPackagePath_.realPath)
       .append(" -C ")
       .append(decomPackagePath_.path);

    return cmd;
}

TSD_StatusT OmPackageWorker::PostProcessPackage()
{
    const auto ret = CheckAndClearLinkFile();
    if (ret != TSD_OK) {
        TSD_ERROR("Check link fail, ret=%d", ret);
        return TSD_INTERNAL_ERROR;
    }

    if (FindAndDecompressOmInnerPkg() != TSD_OK) {
        TSD_ERROR("Decompress om inner pkg failed");
        return TSD_INTERNAL_ERROR;
    }
    if (ChangeOmFileRights() != TSD_OK) {
        TSD_ERROR("Change om file rights failed");
        return TSD_INTERNAL_ERROR;
    }

    if (WritePackageNameToFile() != TSD_OK) {
        TSD_ERROR("Write package name to verify file failed");
        return TSD_INTERNAL_ERROR;
    }

    (void)BasePackageWorker::PostProcessPackage();

    return TSD_OK;
}

TSD_StatusT OmPackageWorker::FindAndDecompressOmInnerPkg() const
{
    const std::string cmd = "/var/tsdaemon_decompress_om_inner_pkg.sh " + decomPackagePath_.path;
    const auto start = std::chrono::steady_clock::now();
    const int32_t ret = PackSystem(cmd.c_str());
    if (ret != 0) {
        TSD_ERROR("Failed to decompress om inner package, ret=%d, cmd=%s, reason=%s",
                  ret, cmd.c_str(), SafeStrerror().c_str());
    }
    const auto end = std::chrono::steady_clock::now();

    TSD_INFO("Decompress om inner package, timeCost=%.2fus",
             std::chrono::duration<double, std::micro>(end - start).count());

    return static_cast<TSD_StatusT>(ret);
}

TSD_StatusT OmPackageWorker::CheckAndClearLinkFile() const
{
    const std::string cmd = "/var/tsdaemon_check_illegal_link.sh " + decomPackagePath_.path;
    const auto start = std::chrono::steady_clock::now();
    const int32_t ret = PackSystem(cmd.c_str());
    if (ret != 0) {
        TSD_ERROR("Failed to check and clear link file, ret=%d, cmd=%s", ret, cmd.c_str());
    }
    const auto end = std::chrono::steady_clock::now();

    TSD_INFO("Check and clear link file, timeCost=%.2fus",
             std::chrono::duration<double, std::micro>(end - start).count());
    return static_cast<TSD_StatusT>(ret);
}

uint32_t OmPackageWorker::ExtractDualDieDeviceId(const std::string &filePath) const
{
    uint32_t deviceId = 0U;
    const size_t pos = filePath.find("device");
    if (pos != std::string::npos) {
        const size_t start = pos + STRING_DEVICE_LENGTH;
        std::string numberPart = filePath.substr(start);
        
        const size_t digitStart = numberPart.find_first_of("0123456789");
        if (digitStart != std::string::npos) {
            try {
                deviceId = static_cast<uint32_t>(std::stoi(numberPart.substr(digitStart)));
            } catch (...) {
                return deviceId;
            }
        }
    }

    TSD_INFO("Extract device id from file path[%s], device id[%u].", filePath.c_str(), deviceId);
    return deviceId;
}
 
TSD_StatusT OmPackageWorker::ChangeOmFileRights() const
{
    const auto handler = [this](const std::string &filePath) {
        ChangeSingleOmFileRights(filePath);
    };

    PackageWorkerUtils::WalkInDir(decomPackagePath_.path, handler, 0);

    return TSD_OK;
}

void OmPackageWorker::ChangeSingleOmFileRights(const std::string &filePath) const
{
    // Add execute auth for dir, add read auth for file
    struct stat st = {};
    int32_t ret = lstat(filePath.c_str(), &st);
    if (ret != 0) {
        TSD_INFO("Get file stat not success, ret=%d, path=%s, reason=%s",
                 ret, filePath.c_str(), SafeStrerror().c_str());
        return;
    }

    const mode_t mode = st.st_mode;
    mode_t newMode = 0UL;
    if (S_ISDIR(mode)) {
        if ((mode & S_IXGRP) != 0) return;
        newMode = mode | S_IXGRP;
    } else {
        if ((mode & S_IRGRP) != 0) return;
        newMode = mode | S_IRGRP;
    }

    ret = chmod(filePath.c_str(), newMode);
    if (ret != 0) {
        TSD_WARN("Change mode not success, ret=%d, path=%s, reason=%s",
                 ret, filePath.c_str(), SafeStrerror().c_str());
    }

    return;
}

TSD_StatusT OmPackageWorker::WritePackageNameToFile() const
{
    const std::string verifyFile = decomPackagePath_.path + std::to_string(dualDieDeviceId_) + OM_VERIFY_FILE_NAME;
    const int32_t fd = open(verifyFile.c_str(), O_CREAT|O_EXCL|O_RDWR,  S_IRUSR|S_IWUSR);
    if (fd < 0) {
        TSD_ERROR("Open om verify file failed, path=%s, reason=%s", verifyFile.c_str(), strerror(errno));
        return TSD_INTERNAL_ERROR;
    }

    const ScopeGuard fdGuard([fd]() { (void)close(fd); });
    const ssize_t ret = write(fd, originPackagePath_.name.c_str(), originPackagePath_.name.length());
    if (ret < 0) {
        TSD_ERROR("Write om verify file failed, ret=%d, path=%s, reason=%s", ret, verifyFile.c_str(), strerror(errno));
        return TSD_INTERNAL_ERROR;
    }

    TSD_INFO("Write package name=%s to file=%s success", originPackagePath_.name.c_str(), verifyFile.c_str());
    return TSD_OK;
}

TSD_StatusT OmPackageWorker::UnloadPackage()
{
    const std::unique_lock<std::mutex> lk(packageMtx_, std::try_to_lock);
    if (!lk.owns_lock()) {
        TSD_INFO("Om package does not have package lock");
        return TSD_OK;
    }

    const ScopeGuard clearGuard([this]() { Clear(); });

    const std::string cmd = "rm -rf " + decomPackagePath_.path;
    const int32_t ret = PackSystem(cmd.c_str());
    if (ret != TSD_OK) {
        TSD_RUN_WARN("Unload om package failed. ret=%d, cmd=%s, reason=%s",
                     ret, cmd.c_str(), strerror(errno));
    }

    TSD_RUN_INFO("Unload om package end, pkg=%s", decomPackagePath_.path.c_str());

    return TSD_OK;
}

bool OmPackageWorker::GetOmFileStatus(const uint32_t hostPid, const std::string &hostFileName, const uint32_t deviceId)
{
    const std::lock_guard<std::mutex> lk(packageMtx_);

    const std::string dstPath = TsdPathMgr::GetHeterogeneousOmFilePrefixPath(uniqueVfId_, hostPid);
    const std::string verifyFile = dstPath + std::to_string(deviceId) + OM_VERIFY_FILE_NAME;
    const int32_t fd = open(verifyFile.c_str(), O_RDWR);
    if (fd < 0) {
        // Do not print error logs because the decompression process has not started and there is no file.
        TSD_INFO("Open om verify file not success, path=%s, reason=%s", verifyFile.c_str(), strerror(errno));
        return false;
    }
    const ScopeGuard fileGuard([&fd]() { (void)close(fd); });

    char_t buf[OM_FILE_PATH_MAX_LEN + 1U];
    const ssize_t ret = static_cast<ssize_t>(read(fd, &buf[0], OM_FILE_PATH_MAX_LEN));
    if (ret < 0) {
        TSD_ERROR("Read om verify file failed, ret=%u", static_cast<uint32_t>(ret));
        return false;
    }

    buf[ret] = '\0';
    const size_t len = (hostFileName.length() <= static_cast<size_t>(ret)) ?
                       hostFileName.length() : static_cast<size_t>(ret);
    if (strncmp(hostFileName.c_str(), &buf[0U], len) != 0) {
        TSD_INFO("Om file status not ok, host file name=%s, om verify file name=%s", hostFileName.c_str(), &buf[0U]);
        return false;
    }

    return true;
}

void OmPackageWorker::Clear()
{
    hostPid_ = "";
    dualDieDeviceId_ = 0U;
    DefaultClear();
}

REGISTER_PACKAGE_WORKER(PackageWorkerType::PACKAGE_WORKER_OM, OmPackageWorker);
} // namespace tsd