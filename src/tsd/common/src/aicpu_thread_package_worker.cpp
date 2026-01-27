/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/aicpu_thread_package_worker.h"

#include <sys/file.h>
#include <fcntl.h>
#include <unistd.h>
#include "inc/internal_api.h"
#include "inc/tsd_path_mgr.h"
#include "inc/aicpu_package_process.h"
#include "inc/package_worker_utils.h"
#include "inc/package_worker_factory.h"


namespace tsd {
namespace {
const std::string ENV_NAME_HOME = "HOME";
constexpr size_t VERIFY_FILE_CONTENT_LEN = 15UL;
} // namespace

TSD_StatusT AicpuThreadPackageWorker::LoadPackage(const std::string &packagePath, const std::string &packageName)
{
    const std::lock_guard<std::mutex> lk(packageMtx_);

    PreProcessPackage(packagePath, packageName);

    TSD_StatusT ret = TSD_OK;
    const ScopeGuard fdGuard([this, &ret]() {
        (void)flock(fd_, LOCK_UN);
        (void)close(fd_);
        fd_ = -1;
        PackageWorkerUtils::RemoveFile(decomPackagePath_.realPath);
        if (ret != TSD_OK) Clear();
    });

    if (!IsNeedLoadPackage()) {
        SetDecompressTimeToNow();
        TSD_INFO("No need decompress package.");
        return TSD_OK;
    }

    TSD_RUN_INFO("Start load package, originPkg=%s, decomPkg=%s, checkCode=%lu, pkgSize=%lu",
                 originPackagePath_.realPath.c_str(), decomPackagePath_.realPath.c_str(),
                 GetCheckCode(), GetOriginPackageSize());

    ret = MoveOriginPackageToDecompressDir();
    if (ret != TSD_OK) {
        TSD_ERROR("Move package to decompress dir failed");
        return ret;
    }

    ret = PackageWorkerUtils::VerifyPackage(decomPackagePath_.realPath);
    if (ret != TSD_OK) {
        TSD_ERROR("Verify package failed, ret=%u", ret);
        return ret;
    }

    ret = DecompressPackage();
    if (ret != TSD_OK) {
        TSD_ERROR("Decompress package failed, ret=%u", ret);
        return ret;
    }

    ret = PostProcessPackage();
    if (ret != TSD_OK) {
        TSD_ERROR("Post process package failed, ret=%u", ret);
        return ret;
    }

    TSD_RUN_INFO("Load package success, originPkg=%s, decomPkg=%s, checkCode=%lu",
                 originPackagePath_.realPath.c_str(), decomPackagePath_.realPath.c_str(), GetCheckCode());

    return TSD_OK;
}

void AicpuThreadPackageWorker::PreProcessPackage(const std::string &packagePath, const std::string &packageName)
{
    DefaultPreProcessPackage(packagePath, packageName);

    verifyFilePath_ = decomPackagePath_.path + verifyFileName_;
    soInstallRootPath_ = TsdPathMgr::BuildKernelSoRootPath(uniqueVfId_, decomPackagePath_.path);

    const TSD_StatusT ret = OpenVerifyFile();
    if (ret != TSD_OK) {
        TSD_ERROR("Open verify file failed.");
    }

    return;
}

void AicpuThreadPackageWorker::SetDecompressPackagePath()
{
    std::string pathEnv("");
    GetScheduleEnv(ENV_NAME_HOME.c_str(), pathEnv);
    if (pathEnv.empty()) {
        TSD_ERROR("Get env %s is empty", ENV_NAME_HOME.c_str());
        return;
    }

    if (!CheckValidatePath(pathEnv)) {
        TSD_ERROR("Env %s invalid, val=%s", ENV_NAME_HOME.c_str(), pathEnv.c_str());
        return;
    }

    if (!CheckRealPath(pathEnv)) {
        TSD_ERROR("Can not get realpath of env %s, val=%s", ENV_NAME_HOME.c_str(), pathEnv.c_str());
        return;
    }

    std::string dstPath = pathEnv + "/";
    if (IsAicpuHeterogeneousThreadMode()) {
        dstPath += "inuse/";
    }

    decomPackagePath_ = PackagePath(dstPath, originPackagePath_.name);

    return;
}

TSD_StatusT AicpuThreadPackageWorker::OpenVerifyFile()
{
    fd_ = open(verifyFilePath_.c_str(), O_CREAT|O_EXCL|O_RDWR,  S_IRUSR|S_IWUSR);
    if (fd_ < 0) {
        TSD_RUN_INFO("Create verify file end, path=%s, reason=%s", verifyFilePath_.c_str(), SafeStrerror().c_str());
        fd_ = open(verifyFilePath_.c_str(), O_RDWR);
        if (fd_ < 0) {
            TSD_ERROR("Create and open verify file failed, path=%s, reason=%s",
                      verifyFilePath_.c_str(), SafeStrerror().c_str());
            return TSD_INTERNAL_ERROR;
        }
    }

    TSD_RUN_INFO("Create or open verify file success, path=%s", verifyFilePath_.c_str());

    return TSD_OK;
}

bool AicpuThreadPackageWorker::IsNeedLoadPackage()
{
    uint64_t savedCheckCode = 0UL;
    TSD_StatusT ret = GetSavedCheckCodeShared(savedCheckCode);
    if (ret != TSD_OK) {
        TSD_ERROR("Get shared check code failed, will not decompress package");
        return false;
    }

    if (savedCheckCode == GetOriginPackageSize()) {
        TSD_INFO("No need to decompress package by shared lock, checkCode=%lu", savedCheckCode);
        return false;
    }

    ret = GetSavedCheckCodeUnshared(savedCheckCode);
    if (ret != TSD_OK) {
        TSD_ERROR("Get unshared check code failed, will not decompress package");
        return false;
    }

    if (savedCheckCode == GetOriginPackageSize()) {
        TSD_INFO("No need to decompress package by unshared lock, checkCode=%lu", savedCheckCode);
        return false;
    }

    SetCheckCode(savedCheckCode);

    return true;
}

TSD_StatusT AicpuThreadPackageWorker::GetSavedCheckCodeShared(uint64_t &savedCheckCode) const
{
    if (fd_ < 0) {
        TSD_ERROR("Verify file not open, fd is less than 0");
        return TSD_INTERNAL_ERROR;
    }

    // used read lock for faster process when parallel case
    int32_t ret = flock(fd_, LOCK_SH);
    if (ret == -1) {
        TSD_ERROR("Lock verify file not success, reason=%s", SafeStrerror().c_str());
        return TSD_INTERNAL_ERROR;
    }

    (void)ReadCheckCode(savedCheckCode);

    ret = flock(fd_, LOCK_UN);
    if (ret == -1) {
        TSD_ERROR("Unlock verify file not success, reason=%s", SafeStrerror().c_str());
        return TSD_INTERNAL_ERROR;
    }

    return TSD_OK;
}

TSD_StatusT AicpuThreadPackageWorker::GetSavedCheckCodeUnshared(uint64_t &savedCheckCode) const
{
    const int32_t ret = flock(fd_, LOCK_EX);
    if (ret == -1) {
        TSD_ERROR("Lock verify file failed, reason=%s", SafeStrerror().c_str());
        return TSD_INTERNAL_ERROR;
    }

    (void)ReadCheckCode(savedCheckCode);

    // File lock released after write check code end

    return TSD_OK;
}

TSD_StatusT AicpuThreadPackageWorker::ReadCheckCode(uint64_t &savedCheckCode) const
{
    savedCheckCode = 0UL;
    char_t buf[VERIFY_FILE_CONTENT_LEN + 1U];
    const int32_t eRet = memset_s(&buf[0], sizeof(char_t)*(VERIFY_FILE_CONTENT_LEN + 1U),
                                  0, sizeof(char_t)*(VERIFY_FILE_CONTENT_LEN + 1U));
    if (eRet != 0) {
        TSD_ERROR("Memset failed in read check code, ret=%d", eRet);
        return TSD_INTERNAL_ERROR;
    }

    const ssize_t ret = static_cast<ssize_t>(read(fd_, &buf[0], VERIFY_FILE_CONTENT_LEN));
    if (ret < 0) {
        TSD_RUN_WARN("Read check code in verify file not success, reason=%s", SafeStrerror().c_str());
        return TSD_OK;
    }

    buf[ret] = '\0';
    int32_t result = 0;
    (void)TransStrToInt(std::string(&buf[0]), result);
    if (result > 0) {
        savedCheckCode = static_cast<uint64_t>(result);
    }

    return TSD_OK;
}

std::string AicpuThreadPackageWorker::GetMovePackageToDecompressDirCmd() const
{
    std::string cmd("");
    cmd.append("cp '")
       .append(originPackagePath_.realPath)
       .append("' '")
       .append(decomPackagePath_.realPath)
       .append("'");
    return cmd;
}

std::string AicpuThreadPackageWorker::GetDecompressPackageCmd() const
{
    std::string cmd("");
    cmd.append("mkdir -p ")
       .append(soInstallRootPath_)
       .append(" ; tar --no-same-owner -ozxf ")
       .append(decomPackagePath_.realPath)
       .append(" -C ")
       .append(soInstallRootPath_);
    return cmd;
}

TSD_StatusT AicpuThreadPackageWorker::PostProcessPackage()
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

    (void)BasePackageWorker::PostProcessPackage();

    (void)WriteCheckCode(fd_, GetCheckCode());

    (void)ResetExtendVerifyFile();

    TSD_INFO("Post process of aicpu thread package success");

    return TSD_OK;
}

TSD_StatusT AicpuThreadPackageWorker::WriteCheckCode(const int32_t fd, const uint64_t checkCode) const
{
    (void)lseek(fd, 0, SEEK_SET);
    const std::string writeCode = std::to_string(checkCode);
    const ssize_t ret = write(fd, writeCode.c_str(), writeCode.length());
    if (ret < 0) {
        TSD_ERROR("Write check code to verify file not success, reason=%s", SafeStrerror().c_str());
        return TSD_INTERNAL_ERROR;
    }

    return TSD_OK;
}

TSD_StatusT AicpuThreadPackageWorker::ResetExtendVerifyFile() const
{
    const std::string extendVerifyFile = decomPackagePath_.path + EXTEND_VERIFY_FILE_NAME;
    const int32_t fd = open(extendVerifyFile.c_str(), O_RDWR);
    if (fd < 0) {
        TSD_INFO("Open extend verify file not success, path=%s, reason=%s",
                 extendVerifyFile.c_str(), SafeStrerror().c_str());
        return TSD_OK;
    }
    const ScopeGuard fdGuard([fd]() { (void)close(fd); });

    if (WriteCheckCode(fd, 0UL) == TSD_OK) {
        TSD_RUN_INFO("Clear extend verify file success, path=%s", extendVerifyFile.c_str());
    } else {
        TSD_RUN_WARN("Clear extend verify file not success, path=%s", extendVerifyFile.c_str());
    }

    return TSD_OK;
}

TSD_StatusT AicpuThreadPackageWorker::UnloadPackage()
{
    const std::lock_guard<std::mutex> lk(packageMtx_);
    return TSD_OK;
}

TSD_StatusT ExtendThreadPackageWorker::PostProcessPackage()
{
    const TSD_StatusT ret = AicpuPackageProcess::CopyExtendSoToCommonSoPath(soInstallRootPath_, IsAsanMode());
    if (ret != TSD_OK) {
        TSD_ERROR("Move extend so to common so path failed, ret=%u", ret);
        return ret;
    }

    (void)BasePackageWorker::PostProcessPackage();

    (void)WriteCheckCode(fd_, GetCheckCode());

    TSD_INFO("Post process of extend thread package success");

    return TSD_OK;
}

REGISTER_PACKAGE_WORKER(PackageWorkerType::PACKAGE_WORKER_AICPU_THREAD, AicpuThreadPackageWorker);
REGISTER_PACKAGE_WORKER(PackageWorkerType::PACKAGE_WORKER_EXTEND_THREAD, ExtendThreadPackageWorker);
} // namespace tsd