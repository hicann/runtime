/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <fstream>
#include <algorithm>
#include "base.hpp"
#include "utils.h"

namespace cce {
namespace runtime {
bool GetConfigIniValueInt32(const std::string &userFileName, const std::string &key, int32_t &val)
{
    const std::string fileName = RealPath(userFileName);
    if (fileName.empty()) {
        RT_LOG(RT_LOG_INFO, "file is not exist or can not access, path=[%s]", userFileName.c_str());
        return false;
    }

    std::ifstream ifs(fileName, std::ifstream::in);
    if (!ifs.is_open()) {
        RT_LOG(RT_LOG_INFO, "file %s is not exist or can not access.", fileName.c_str());
        return false;
    }

    bool ret = false;
    std::string line;
    std::string valueOfStr;
    while (std::getline(ifs, line)) {
        const std::size_t found = line.find(key);
        if (found == 0UL) {
            valueOfStr = line.substr(key.length());
            ret = true;
            break;
        }
    }
    ifs.close();

    if (ret) {
        try {
            val = std::stoi(valueOfStr);
        } catch (const std::invalid_argument& ia) {
            RT_LOG(RT_LOG_WARNING, "%s failed: invalid_argument, string(%s), file(%s).",
                ia.what(), line.c_str(), fileName.c_str());
            ret = false;
        } catch (const std::out_of_range& oor) {
            RT_LOG(RT_LOG_WARNING, "%s failed: out_of_range, string(%s), file(%s).",
                oor.what(), line.c_str(), fileName.c_str());
            ret = false;
        }

        RT_LOG(RT_LOG_INFO, "read file %s result: value=%d, valueOfStr=%s.",
            fileName.c_str(), val, valueOfStr.c_str());
    }

    if (!ret) {
        RT_LOG(RT_LOG_WARNING, "read file %s failed.", fileName.c_str());
    }
    return ret;
}

const std::string RealPath(const std::string &path)
{
    if (path.empty()) {
        RT_LOG(RT_LOG_ERROR, "path string is empty.");
        return "";
    }
    if (path.size() >= PATH_MAX) {
        RT_LOG(RT_LOG_ERROR, "file path %s is too long, max length is %d.", path.c_str(), PATH_MAX);
        return "";
    }

    // PATH_MAX is the system marco，indicate the maximum length for file path
    char resolvedPath[PATH_MAX] = {0x0};

    // path not exists or not allowed to read，return nullptr
    // path exists and readable, return the resolved path
    std::string res = "";
    if (realpath(path.c_str(), resolvedPath) != nullptr) {
        res = resolvedPath;
    }
    return res;
}

bool IsStringNumeric(const std::string& str)
{
    return std::all_of(str.begin(), str.end(), [](char c) {
        return std::isdigit(static_cast<unsigned char>(c));
    });
}

bool GetDriverPath(std::string &driverPath)
{
    const std::string driverPathKey = "Driver_Install_Path_Param=";
    const std::string ascendInstallPath = "/etc/ascend_install.info";
    std::ifstream ifs(ascendInstallPath, std::ifstream::in);
    if (!ifs.is_open()) {
        RT_LOG(RT_LOG_WARNING, "Open ascend install file [%s] failed: %s.", ascendInstallPath.c_str(), strerror(errno));
        return false;
    }

    driverPath.clear();
    std::string line;
    while (std::getline(ifs, line)) {
        const auto &pos = line.find(driverPathKey);
        if (pos == std::string::npos) {
            continue;
        }
        RT_LOG(RT_LOG_INFO, "driver path is [%s].", line.c_str());
        driverPath = line.substr(pos + driverPathKey.length());
        if (!driverPath.empty()) {
            return true;
        }
    }
    return false;
}

std::string GetFileName(const std::string &path)
{
    const size_t lastSlashPos = path.find_last_of("\\/");
    if (lastSlashPos != std::string::npos) {
        return path.substr(lastSlashPos + 1U);
    }

    return path; // 如果没有找到斜杠，则整个字符串就是文件名
}

std::string GetFilePathByExtension(const std::string &binPath, std::string extension)
{
    std::string soFilePath;
    const auto dotPos = binPath.find_last_of(".");
    if (dotPos != std::string::npos) {
        soFilePath = binPath.substr(0, dotPos);
    }
    soFilePath = soFilePath + extension;

    return soFilePath;
}

const std::string RealPathForFileNotExists(const std::string &inputPath)
{
    size_t lastSlash = inputPath.find_last_of("/\\");
    std::string dirPath;
    std::string fileName;
    std::string fullPath;

    if (lastSlash == std::string::npos) {
        //input path contains file name only;
        fullPath = inputPath;
    } else {
        dirPath = inputPath.substr(0, lastSlash);
        fileName = inputPath.substr(lastSlash + 1);
        std::string canonicalDir = RealPath(dirPath);
        if (canonicalDir.empty()) {
            return "";
        }
        fullPath = canonicalDir + "/" + fileName;
    }
    return fullPath;
}

uint64_t GetQuickHash(const void *data, const size_t size)
{
    // Using the FNV-1a algorithm for hash computation offers faster speed.
    const uint8_t *bytes = static_cast<const uint8_t *>(data);
    const uint64_t prime = 1099511628211UL;
    uint64_t hash = 14695981039346656037UL;
    for (size_t i = 0UL; i < size; i++) {
        hash ^= bytes[i];
        hash *= prime;
    }

    return hash;
}
}
}
