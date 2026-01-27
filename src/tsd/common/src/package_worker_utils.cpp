/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "inc/package_worker_utils.h"

#include <sys/stat.h>
#include <fstream>
#include <sstream>
#include "mmpa/mmpa_api.h" 
#include "inc/log.h"
#include "inc/internal_api.h"
#include "inc/package_verify.h"
#include "inc/tsd_path_mgr.h"
#include "inc/process_util_common.h"

namespace tsd {
namespace {
constexpr uint32_t MAX_DIR_DEPTH = 20U;
const std::string MEM_LIMIT_TYPE_FILE = "/proc/ccfg/numa_id/memctrol_type";
constexpr uint64_t MIN_RESERVED_SPACE = 150UL * 1024UL * 1024UL; // 150M
const std::string SHARED_MEM_LIMIT_TYPE = "shared";
constexpr uint32_t SHELL_RETRY_INTERVAL = 10U;
constexpr uint32_t SHELL_RETRY_TIMES = 6000U;
} // namespace

TSD_StatusT PackageWorkerUtils::VerifyPackage(const std::string &pkgPath)
{
    const PackageVerify pkgVerify(pkgPath);
    const TSD_StatusT ret = pkgVerify.VerifyPackage();
    if (ret != TSD_OK) {
        TSD_ERROR("Verify package failed, ret=%u, path=%s", ret, pkgPath.c_str());
        return TSD_VERIFY_OPP_FAIL;
    }

    return TSD_OK;
}

TSD_StatusT PackageWorkerUtils::MakeDirectory(const std::string &dirPath)
{
    if (dirPath.empty()) {
        TSD_ERROR("Dir path is empty");
        return TSD_INTERNAL_ERROR;
    }

    int32_t ret = access(dirPath.c_str(), F_OK);
    if (ret == 0) {
        ret = mmIsDir(dirPath.c_str());
        if (ret != EN_OK) {
            TSD_ERROR("File exist but not is a dir, ret=%d, path=%s, reason=%s",
                      ret, dirPath.c_str(), SafeStrerror().c_str());
            return TSD_INTERNAL_ERROR;
        }
        return TSD_OK;
    }

    ret = mkdir(dirPath.c_str(), (S_IRWXU|S_IRGRP|S_IXGRP));
    if (ret != 0) {
        TSD_ERROR("Create dir failed, ret=%d, path=%s, reason=%s",
                  ret, dirPath.c_str(), SafeStrerror().c_str());
        return TSD_INTERNAL_ERROR;
    }

    // chmod is necessary, because mkdir can not really change mode in rc
    ret = chmod(dirPath.c_str(), (S_IRWXU|S_IRGRP|S_IXGRP));
    if (ret != 0) {
        TSD_ERROR("Change dir mode failed, ret=%d, path=%s, reason=%s",
                  ret, dirPath.c_str(), SafeStrerror().c_str());
        return TSD_INTERNAL_ERROR;
    }

    return TSD_OK;
}

void PackageWorkerUtils::RemoveFile(const std::string &filePath)
{
    RemoveOneFile(filePath);
}

void PackageWorkerUtils::WalkInDir(const std::string &dirPath,
                                   const PackageWorkerUtils::TraverseFileHandle &handler,
                                   const uint32_t depth)
{
    if (dirPath.empty() || (depth >= MAX_DIR_DEPTH)) {
        TSD_WARN("Dir path is empty or reach max depth, path=%s, depth=%u, maxDepth=%u",
                 dirPath.c_str(), depth, MAX_DIR_DEPTH);
        return;
    }

    DIR *dir = opendir(dirPath.c_str());
    if (dir == nullptr) {
        TSD_WARN("Open dir failed, path=%s, depth=%u, reason=%s", dirPath.c_str(), depth, SafeStrerror().c_str());
        return;
    }

    handler(dirPath);

    dirent *entry = nullptr;
    while ((entry = readdir(dir)) != nullptr)
    {
        std::string childName = entry->d_name;
        std::string childPath = dirPath + "/" + childName;
        if (entry->d_type == DT_DIR) {
            if ((childName == ".") || (childName == "..")) {
                continue;
            }
            PackageWorkerUtils::WalkInDir(childPath, handler, depth+1);
        } else {
            handler(childPath);
        }
    }

    const int32_t ret = closedir(dir);
    if (ret != 0) {
        TSD_RUN_WARN("Close dir failed, ret=%d, path=%s, reason=%s", ret, dirPath.c_str(), strerror(errno));
    }

    return;
}

uint64_t PackageWorkerUtils::GetDirSize(const std::string &dirPath)
{
    if (dirPath.empty()) {
        return 0UL;
    }

    uint64_t size = 0UL;
    const auto handler = [&size] (const std::string &childPath) {
        size += CalFileSize(childPath);
    };

    PackageWorkerUtils::WalkInDir(dirPath, handler, 0);

    return size;
}

uint64_t PackageWorkerUtils::GetFileSize(const std::string &filePath)
{
    return CalFileSize(filePath.c_str());
}


bool PackageWorkerUtils::IsSetMemLimit(bool isVfMode, const uint32_t deviceId, const uint32_t vfId)
{
    if ((isVfMode) && (PackageWorkerUtils::IsCgroupMemMode(deviceId, vfId))) {
        return true;
    }

    return false;
}

bool PackageWorkerUtils::IsCgroupMemMode(const uint32_t deviceId, const uint32_t vfId)
{
    if (access(MEM_LIMIT_TYPE_FILE.c_str(), F_OK) != 0) {
        TSD_INFO("Memory limit type file does not exist, reason=%s", SafeStrerror().c_str());
        return false;
    }

    const std::string userMemoryPath = TsdPathMgr::BuildMemoryConfigRootPath(deviceId, vfId);
    if (access(userMemoryPath.c_str(), F_OK) != 0) {
        TSD_INFO("Memory control file does not exist, reason=%s", SafeStrerror().c_str());
        return false;
    }

    std::string memType("");
    const TSD_StatusT ret = ProcessUtilCommon::ReadCurMemCtrolType(MEM_LIMIT_TYPE_FILE, memType);
    if (ret != TSD_OK) {
        TSD_INFO("Read memory control type not success, ret=%u", ret);
        return false;
    }

    TSD_INFO("Current memory control mode is %s, fixed=%s", memType.c_str(), SHARED_MEM_LIMIT_TYPE.c_str());
    if (memType == SHARED_MEM_LIMIT_TYPE) {
        TSD_INFO("Memory control mode is %s", memType.c_str());
        return true;
    }

    return false;
}

TSD_StatusT PackageWorkerUtils::CheckMemoryUsage(const std::string &soInstallRootPath,
                                                 const std::string &memoryLimitFilePath,
                                                 const std::string &memoryUsedFilePath,
                                                 const uint32_t deviceId,
                                                 const uint32_t vfId)
{
    uint64_t userMemoryLimit = 0UL;
    TSD_StatusT ret = PackageWorkerUtils::GetUserMemoryLimit(userMemoryLimit, memoryLimitFilePath);
    if (ret != TSD_OK) {
        TSD_ERROR("Get user memory limit failed, ret=%u, file=%s, deviceId=%u, vfId=%u",
                  ret, memoryLimitFilePath.c_str(), deviceId, vfId);
        return ret;
    }

    if (access(soInstallRootPath.c_str(), F_OK) == 0) {
        TSD_INFO("Aicpu kernel has exist, no need check, path=%s", soInstallRootPath.c_str());
        return TSD_OK;
    }

    uint64_t userMemoryUsed = 0UL;
    ret = PackageWorkerUtils::GetUserMemoryUsed(userMemoryUsed, memoryUsedFilePath);
    if (ret != TSD_OK) {
        TSD_ERROR("Get user memory usage failed, ret=%u, file=%s, deviceId=%u, vfId=%u",
                  ret, memoryUsedFilePath.c_str(), deviceId, vfId);
        return ret;
    }

    if ((userMemoryLimit < userMemoryUsed) || ((userMemoryLimit - userMemoryUsed) < MIN_RESERVED_SPACE)) {
        TSD_ERROR("Device has no enough space(less than 150M), deviceId=%u, vfId=%u, max=%lubyte, used=%lubyte",
                  deviceId, vfId, userMemoryLimit, userMemoryUsed);
        return TSD_INTERNAL_ERROR;
    }

    return TSD_OK;
}

TSD_StatusT PackageWorkerUtils::GetUserMemoryLimit(uint64_t &userMemoryLimit, const std::string &memoryLimitFilePath)
{
    const TSD_StatusT ret = PackageWorkerUtils::ReadMemControlValue(memoryLimitFilePath, userMemoryLimit);
    if (ret != TSD_OK) {
        TSD_ERROR("Read memory limit from file failed, ret=%u, file=%s", ret, memoryLimitFilePath.c_str());
    }

    return ret;
}

TSD_StatusT PackageWorkerUtils::GetUserMemoryUsed(uint64_t &userMemoryUsed, const std::string &memoryUsedFilePath)
{
    const TSD_StatusT ret = PackageWorkerUtils::ReadMemControlValue(memoryUsedFilePath, userMemoryUsed);
    if (ret != TSD_OK) {
        TSD_ERROR("Read memory usage from file failed, ret=%u, file=%s", ret, memoryUsedFilePath.c_str());
    }

    return ret;
}

TSD_StatusT PackageWorkerUtils::ReadMemControlValue(const std::string &path, uint64_t &memSize)
{
    if (!CheckRealPath(path)) {
        TSD_ERROR("Can not get realpath of path[%s]", path.c_str());
        return TSD_INTERNAL_ERROR;
    }
    std::ifstream fs;
    fs.open(path);
    if (!fs.is_open()) {
        TSD_ERROR("Open file failed, path=%s, reason=%s", path.c_str(), SafeStrerror().c_str());
        return TSD_INTERNAL_ERROR;
    }
    const ScopeGuard fGuard([&fs]() { fs.close(); });

    std::string temp("");
    (void)getline(fs, temp);
    if (temp.empty()) {
        TSD_ERROR("File is empty, path=%s", path.c_str());
        return TSD_INTERNAL_ERROR;
    }

    std::istringstream ss(temp);
    ss >> memSize;
    TSD_INFO("Current memory limit is %sbyte", temp.c_str());

    return TSD_OK;
}

TSD_StatusT PackageWorkerUtils::RestoreMemUsage(const uint64_t oldSize, const uint64_t newSize,
                                                const uint32_t deviceId,const uint32_t vfId,
                                                const std::string &memoryLimitFilePath)
{
    uint64_t userMemoryLimit = 0UL;
    TSD_StatusT ret = PackageWorkerUtils::GetUserMemoryLimit(userMemoryLimit, memoryLimitFilePath);
    if (ret != TSD_OK) {
        TSD_ERROR("Get user memory limit failed");
        return ret;
    }

    TSD_INFO("Before restore memory usage, deviceId=%u, vfId=%u, limit=%lubyte, old=%lubyte, new=%lubyte",
             deviceId, vfId, userMemoryLimit, oldSize, newSize);
    if ((ULLONG_MAX - userMemoryLimit) <= oldSize) {
        TSD_ERROR("Overflow occurred in add operation, deviceId=%u, vfId=%u, limit=%lubyte, old=%lubyte, new=%lubyte",
                  deviceId, vfId, userMemoryLimit, oldSize, newSize);
        return TSD_INTERNAL_ERROR;
    }

    if ((userMemoryLimit + oldSize) <= newSize) {
        TSD_ERROR("User memory is not enough, deviceId=%u, vfId=%u, limit=%lubyte, old=%lubyte, new=%lubyte",
                  deviceId, vfId, userMemoryLimit, oldSize, newSize);
        return TSD_INTERNAL_ERROR;
    }

    userMemoryLimit = userMemoryLimit + oldSize - newSize;
    TSD_INFO("After restore memory usage, limit=%lubyte", userMemoryLimit);
    ret = PackageWorkerUtils::SetMemoryControlValue(userMemoryLimit, deviceId, vfId);
    if (ret != TSD_OK) {
        TSD_ERROR("Set user memory limit failed, ret=%u, deviceId=%u, vfId=%u, limit=%lubyte, old=%lubyte, new=%lubyte",
                  ret, deviceId, vfId, userMemoryLimit, oldSize, newSize);
    }

    return ret;
}

TSD_StatusT PackageWorkerUtils::SetMemoryControlValue(const uint64_t userMemoryLimit, const uint32_t deviceId,
                                                      const uint32_t vfId)
{
    std::string cmd = "cd /var && sudo /var/tsdaemon_modify_usermemory.sh";
    std::string pathStr = "/var/tsdaemon_modify_usermemory.sh";
    if (access(pathStr.c_str(), F_OK) != 0) {
        pathStr = "/usr/local/Ascend/driver/tools/tsdaemon_modify_usermemory.sh";
        if (access(pathStr.c_str(), F_OK) != 0) {
            TSD_INFO("Not find tsdaemon_modify_usermemory.sh.");
            return TSD_OK;
        }
        cmd = "cd /usr/local/Ascend/driver/tools/ && sudo ./tsdaemon_modify_usermemory.sh";
    }
    cmd = cmd + " " + std::to_string(deviceId) + " " + std::to_string(vfId) + " " +
          std::to_string(userMemoryLimit);

    TSD_INFO("Set user memory limit value, cmd=%s", cmd.c_str());

    uint32_t tryTimes = 0U;
    while (tryTimes < SHELL_RETRY_TIMES) {
        /*
        * An error may be reported during the script execution.
        * Therefore, a maximum of 500 attempts can be performed within 5 seconds.
        * If the retry fails, the following process will be continued.
        */
        const int32_t ret = PackSystem(cmd.c_str());
        if (ret == 0) {
            return TSD_OK;
        }
        (void)mmSleep(SHELL_RETRY_INTERVAL);
        ++tryTimes;
    }
    TSD_RUN_WARN("Set user memory limit after retry still not success, cmd=%s, reason=%s",
                 cmd.c_str(), SafeStrerror().c_str());
    return TSD_OK;
}
} // namespace tsd