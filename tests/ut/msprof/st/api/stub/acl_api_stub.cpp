/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "acl_api_stub.h"
#include "msprof_stub.h"
#include "utils.h"
#include "prof_manager.h"
#include "platform/platform.h"
#include "config/config_manager.h"
#include "prof_acl_mgr.h"
#include "hash_data.h"
#include "prof_acl_api.h"

namespace Cann {
namespace Dvvp {
namespace Test {
using namespace analysis::dvvp::common::utils;

int32_t AclApiStart(aclprofConfig *config, uint64_t dataTypeConfig)
{
    auto ret = aclprofStart(config);
    if (ret != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclprofStart failed");
        return ret;
    }
    uint32_t modelId = 0;
    void *stream = &modelId; // fake stream
    if (((dataTypeConfig & PROF_MSPROFTX) != 0) &&
        aclprofMarkEx("model execute start", strlen("model execute start"), stream) != 0) {
        MSPROF_LOGE("aclprofMarkEx failed");
        return -1;
    }

    ret = aclmdlExecute(modelId, nullptr, nullptr);
    if (ret != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclmdlExecute failed");
        return ret;
    }
    if (dataTypeConfig | ACL_PROF_AICPU != 0) {
        usleep(100 * 1000);     // sleep 100ms for aicpu
    }
    ret = aclprofStop(config);
    if (ret != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclprofStop failed");
        return ret;
    }
    aclprofDestroyConfig(config);
    aclprofFinalize();
    aclFinalize();
    return 0;
}

int32_t AclApiRepeatStart(aclprofConfig *config, uint64_t dataTypeConfig)
{
    // first time
    auto ret = aclprofStart(config);
    if (ret != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclprofStart failed");
        return ret;
    }
    uint32_t modelId = 0;
    void *stream = &modelId; // fake stream
    if (((dataTypeConfig & PROF_MSPROFTX) != 0) &&
        aclprofMarkEx("model execute start", strlen("model execute start"), stream) != 0) {
        MSPROF_LOGE("aclprofMarkEx failed");
        return -1;
    }

    ret = aclmdlExecute(modelId, nullptr, nullptr);
    if (ret != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclmdlExecute failed");
        return ret;
    }
    if (dataTypeConfig | ACL_PROF_AICPU != 0) {
        usleep(100 * 1000);     // sleep 100ms for aicpu
    }
    ret = aclprofStop(config);
    if (ret != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclprofStop failed");
        return ret;
    }
    // second time
    ret = aclprofStart(config);
    if (ret != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclprofStart failed");
        return ret;
    }
    ret = aclmdlExecute(modelId, nullptr, nullptr);
    if (ret != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclmdlExecute failed");
        return ret;
    }
    if (dataTypeConfig | ACL_PROF_AICPU != 0) {
        usleep(100 * 1000);     // sleep 100ms for aicpu
    }
    ret = aclprofStop(config);
    if (ret != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclprofStop failed");
        return ret;
    }

    aclprofDestroyConfig(config);
    aclprofFinalize();
    aclFinalize();
    return 0;
}

int32_t AclApiStartWithSetDeviceBehind(aclprofConfig *config, uint64_t dataTypeConfig)
{
    auto ret = aclprofStart(config);
    if (ret != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclprofStart failed");
        return ret;
    }

    aclrtSetDevice(0);
    uint32_t modelId = 0;
    void *stream = &modelId; // fake stream
    if (((dataTypeConfig & PROF_MSPROFTX) != 0) &&
        aclprofMarkEx("model execute start", strlen("model execute start"), stream) != 0) {
        MSPROF_LOGE("aclprofMarkEx failed");
        return -1;
    }

    ret = aclmdlExecute(modelId, nullptr, nullptr);
    if (ret != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclmdlExecute failed");
        return ret;
    }
    if (dataTypeConfig | ACL_PROF_AICPU != 0) {
        usleep(100 * 1000);     // sleep 100ms for aicpu
    }
    aclrtResetDevice(0);
    ret = aclprofStop(config);
    if (ret != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclprofStop failed");
        return ret;
    }
    aclprofDestroyConfig(config);
    aclprofFinalize();
    aclFinalize();
    return 0;
}

int32_t CheckDataFiles(std::string &absolutePath, std::vector<std::string> dataList)
{
    std::vector<std::string> files;
    Utils::GetFiles(absolutePath, true, files, 1);
    for (const std::string &dataFile : dataList) {
        bool isFinded = false;
        for (const std::string &file : files) {
            if (file.find(dataFile) != std::string::npos) {
                isFinded = true;
                break;
            }
        }
        if (!isFinded) {
            MSPROF_LOGE("%s is not found", dataFile.c_str());
            return -1;
        }
    }
    return 0;
}

int32_t CheckFiles(std::string &path, std::vector<std::string> deviceDataList, std::vector<std::string> hostDataList)
{
    bool isExist = false;
    DIR *dir = opendir(path.c_str());
    struct dirent *entry;
    std::string profPath;
    if (dir != nullptr) {
        while ((entry = readdir(dir)) != NULL) {
            std::string dirName = entry->d_name;
            if (dirName.compare(0, 4, "PROF") == 0) {
                isExist = true;
                profPath = path + "/" + dirName;
                break;
            }
        }
    }

    if (dir != nullptr) {
        closedir(dir);
    } else {
        MSPROF_LOGE("Failed to find nullptr dir");
        return -1;
    }

    if (!isExist) {
        MSPROF_LOGE("Failed to find data dir");
        return -1;
    }

    std::string deviceDataPath = profPath + "/device_0/data";
    std::string absoluteDevicePath = Utils::RelativePathToAbsolutePath(deviceDataPath);
    if (CheckDataFiles(absoluteDevicePath, deviceDataList) != 0) {
        return -1;
    }

    std::string hostDataPath = profPath + "/host/data";
    std::string absoluteHostPath = Utils::RelativePathToAbsolutePath(hostDataPath);
    if (CheckDataFiles(absoluteHostPath, hostDataList) != 0) {
        return -1;
    }
    return 0;
}

int32_t CheckAllFiles(std::string &path, std::vector<std::string> deviceDataList, std::vector<std::string> hostDataList)
{
    bool isExist = false;
    DIR *dir = opendir(path.c_str());
    struct dirent *entry;
    std::vector<std::string> profPath;
    if (dir != nullptr) {
        while ((entry = readdir(dir)) != NULL) {
            std::string dirName = entry->d_name;
            if (dirName.compare(0, 4, "PROF") == 0) {
                isExist = true;
                std::string tmp = path + "/" + dirName;
                profPath.emplace_back(tmp);
            }
        }
    }

    closedir(dir);
    if (!isExist) {
        MSPROF_LOGE("Failed to find data dir");
        return -1;
    }

    for (auto &pathStr : profPath) {
        std::string deviceDataPath = pathStr + "/device_0/data";
        std::string absoluteDevicePath = Utils::RelativePathToAbsolutePath(deviceDataPath);
        if (CheckDataFiles(absoluteDevicePath, deviceDataList) != 0) {
            return -1;
        }

        std::string hostDataPath = pathStr + "/host/data";
        std::string absoluteHostPath = Utils::RelativePathToAbsolutePath(hostDataPath);
        if (CheckDataFiles(absoluteHostPath, hostDataList) != 0) {
            return -1;
        }
    }
    return 0;
}


void ClearApiSingleton()
{
    Analysis::Dvvp::Common::Platform::Platform::instance()->Uninit();
    Analysis::Dvvp::Common::Config::ConfigManager::instance()->Uninit();
    Analysis::Dvvp::Common::Config::ConfigManager::instance()->Init();
    analysis::dvvp::transport::HashData::instance()->Uninit();
    Msprofiler::Api::ProfAclMgr::instance()->UnInit();
    analysis::dvvp::host::ProfManager::instance()->AclUinit();
}

void InitApiSingleton()
{
    Analysis::Dvvp::Common::Config::ConfigManager::instance()->Init();
    Analysis::Dvvp::Common::Platform::Platform::instance()->Init();
}

}
}
}

