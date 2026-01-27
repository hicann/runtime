/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/aicpu_package_process.h"

#include <regex>
#include <memory>
#include <fstream>
#include <sstream>
#include "securec.h"
#include "inc/log.h"
#include "inc/tsd_util.h"
#include "inc/tsd_path_mgr.h"
#include "inc/internal_api.h"
#include "inc/package_worker_utils.h"


namespace tsd {
namespace {
const std::string SAND_BOX_DIR_NAME = "sand_box";
const std::string SAND_BOX_SO_ITEM_NAME = "SandBoxSo=";
} // namespace

TSD_StatusT AicpuPackageProcess::CheckPackageName(const std::string &soInstallPath, const std::string &packageName)
{
    std::string srcPkgName("");
    TSD_StatusT ret = GetSrcPackageName(packageName, srcPkgName);
    if (ret != TSD_OK) {
        TSD_ERROR("Get src package name failed");
        return ret;
    }

    std::string innerPkgName("");
    ret = GetInnerPkgName(soInstallPath, innerPkgName);
    if (ret != TSD_OK) {
        TSD_ERROR("Get inner package name failed, soInstallPath=%s", soInstallPath.c_str());
        return ret;
    }

    if (srcPkgName != innerPkgName) {
        TSD_ERROR("Package source name is not same as package inner name, srcPkgName=%s, innerPkgName=%s",
                  srcPkgName.c_str(), innerPkgName.c_str());
        return TSD_INTERNAL_ERROR;
    }

    return TSD_OK;
}

TSD_StatusT AicpuPackageProcess::GetSrcPackageName(const std::string &packageName, std::string &srcPkgName)
{
    std::smatch ret;
    const std::regex rule("Ascend.*\\.tar\\.gz");
    const bool searchRet = std::regex_search(packageName, ret, rule);
    if (!searchRet) {
        TSD_ERROR("Package name is invalid, name=%s", packageName.c_str());
        return TSD_START_FAIL;
    }

    srcPkgName = ret.str();

    return TSD_OK;
}

TSD_StatusT AicpuPackageProcess::GetInnerPkgName(const std::string &soInstallPath, std::string &innerPkgName)
{
    const auto handler = [&innerPkgName] (const std::string &line) -> bool {
        const auto idx = line.find("=");
        if ((idx != std::string::npos) && (line.find("Name") != std::string::npos)) {
            innerPkgName = line.substr(idx + 1UL);
            TSD_INFO("Get inner package name success, name=%s", innerPkgName.c_str());
            return true;
        }

        return false;
    };

    const TSD_StatusT ret = WalkInVersionFile(soInstallPath, handler);
    if (ret != TSD_OK) {
        TSD_ERROR("Walk in version file to get inner package name failed, path=%s", soInstallPath.c_str());
    }

    return ret;
}

TSD_StatusT AicpuPackageProcess::WalkInVersionFile(const std::string &soInstallPath, const VersionLineHandler &handler)
{
    std::unique_ptr<char_t []> path(new (std::nothrow) char_t[PATH_MAX]);
    if (path == nullptr) {
        TSD_ERROR("Alloc memory for path failed.");
        return TSD_INTERNAL_ERROR;
    }

    const int32_t eRet = memset_s(path.get(), PATH_MAX, 0, PATH_MAX);
    if (eRet != EOK) {
        TSD_ERROR("Memset path failed, ret=%d", eRet);
        return TSD_INTERNAL_ERROR;
    }

    const std::string versionInfoFilePath = TsdPathMgr::AddVersionInfoName(soInstallPath);
    if (realpath(versionInfoFilePath.data(), path.get()) == nullptr) {
        TSD_ERROR("Get real path of version file failed, file=%s, reason=%s",
                  versionInfoFilePath.c_str(), SafeStrerror().c_str());
        return TSD_INTERNAL_ERROR;
    }

    TSD_INFO("Start walk in version file, file=%s", path.get());

    std::fstream f;
    f.open(path.get(), std::fstream::in);
    if (!f.is_open()) {
        TSD_ERROR("Open version file failed, file=%s");
        return TSD_INTERNAL_ERROR;
    }
    ScopeGuard fGuard([&f]() { f.close(); });

    std::string line("");
    while (getline(f, line)) {
        if (handler(line)) {
            break;
        };
    }

    return TSD_OK;
}

TSD_StatusT AicpuPackageProcess::MoveSoToSandBox(const std::string &soInstallPath)
{
    std::string soList("");
    TSD_StatusT ret = GetSandBoxSoListInVersionFile(soInstallPath, soList);
    if ((ret != TSD_OK) || (soList.empty())) {
        TSD_ERROR("Sandbox so item value is empty, ret=%u.", ret);
        return TSD_INTERNAL_ERROR;
    }

    // make sand box dir
    const std::string sandBoxPath = soInstallPath + SAND_BOX_DIR_NAME + "/";
    ret = PackageWorkerUtils::MakeDirectory(sandBoxPath);
    if (ret != TSD_OK) {
        TSD_ERROR("Check or make sandbox dir failed, ret=%u, path=%s", ret, sandBoxPath.c_str());
        return TSD_INTERNAL_ERROR;
    }

    // move so to sand box
    std::istringstream iss(soList);
    std::string soName("");
    while (getline(iss, soName, ',')) {
        Trim(soName);
        if (soName.empty()) {
            continue;
        }
        const std::string orgFile = soInstallPath + soName;
        const std::string dstFile = sandBoxPath + soName;
        const int32_t status = rename(orgFile.c_str(), dstFile.c_str());
        if (status != 0) {
            TSD_RUN_WARN("Rename sandbox so failed, status=%d, orgFile=%s, dstFile=%s, reason=%s,",
                         status, orgFile.c_str(), dstFile.c_str(), SafeStrerror().c_str());
        } else {
            TSD_RUN_INFO("Rename sandbox so success, orgFile=%s, dstFile=%s", orgFile.c_str(), dstFile.c_str());
        }
    }

    return TSD_OK;
}

TSD_StatusT AicpuPackageProcess::GetSandBoxSoListInVersionFile(const std::string &soInstallPath, std::string &soList)
{
    const auto handler = [&soList] (const std::string &line) -> bool {
        const auto idx = line.find("=");
        if ((idx != std::string::npos) && (line.find(SAND_BOX_SO_ITEM_NAME) != std::string::npos)) {
            soList = line.substr(idx + 1UL);
            TSD_INFO("Get sand box items success, soList=%s", soList.c_str());
            return true;
        }

        return false;
    };

    const TSD_StatusT ret = WalkInVersionFile(soInstallPath, handler);
    if (ret != TSD_OK) {
        TSD_ERROR("Walk in version file to get sandbox so list failed, path=%s", soInstallPath.c_str());
    }

    return ret;
}

bool AicpuPackageProcess::IsSoExist(const uint32_t uniqueVfId)
{
    const std::string path = TsdPathMgr::BuildKernelSoPath(uniqueVfId);
    if (access(path.c_str(), F_OK) != 0) {
        TSD_INFO("Aicpu so does not exist, path=%s", path.c_str());
        return false;
    }
    return true;
}

TSD_StatusT AicpuPackageProcess::CopyExtendSoToCommonSoPath(const std::string &soInstallRootPath, const bool isAsan)
{
    const std::string aicpuSoPath = TsdPathMgr::BuildKernelSoPath(soInstallRootPath);
    const std::string extendSoPath = TsdPathMgr::BuildExtendKernelSoPath(soInstallRootPath);
    const std::string extendHashCfgPath = TsdPathMgr::BuildExtendKernelHashCfgPath(soInstallRootPath);
    const std::string hashCfgFile = extendSoPath + BASE_HASH_CFG_FILE;
    std::string cmd;
    if (access(hashCfgFile.c_str(), F_OK) == 0) {
        cmd = "mkdir -p " + aicpuSoPath + " ; mv " + extendSoPath + "*.so* " + aicpuSoPath +
              " ; mv " + hashCfgFile + " " + extendHashCfgPath + " && rm -rf " + extendSoPath;
    } else {
        cmd = "mkdir -p " + aicpuSoPath + " ; mv " + extendSoPath + "*.so* " + aicpuSoPath +
              " && rm -rf " + extendSoPath;
    }
    const int32_t ret = PackSystem(cmd.c_str());
    if ((isAsan) && (ret != 0)) {
        TSD_INFO("Move extend so to common so path end. cmd=%s, ret=%d, reason=%s.",
                 cmd.c_str(), ret, SafeStrerror().c_str());
    } else if (ret != 0) {
        TSD_ERROR("Move extend so to common so path failed. cmd=%s, ret=%d, reason=%s.",
                  cmd.c_str(), ret, SafeStrerror().c_str());
        return TSD_INTERNAL_ERROR;
    }

    TSD_RUN_INFO("Move extend so to common so path success, cmd=%s", cmd.c_str());
    return TSD_OK;
}
}