/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "lib_path.h"
#include "mmpa_api.h"
#include "log/hdc_log.h"
#include "log/adx_log.h"
#include "file_utils.h"

namespace Adx {
constexpr char LIBSUFFIX[] = ".so";

LibPath &LibPath::Instance()
{
    static LibPath libPath;
    return libPath;
}

Path LibPath::GetInstallParentPath() const
{
    // get install path from self path : <install path>/x86_64-linux/lib64/ --> <install path>/x86_64-linux
    Path currentPath(LibPath::GetSelfLibraryDir());
    auto installPath = currentPath.ParentPath();
    return installPath;
}

Path LibPath::GetInstallPath() const
{
    // get install path: <install path>/x86_64-linux/lib64/
    Path currentPath(LibPath::GetSelfLibraryDir());
    return currentPath;
}

/**
 * @brief       Get directory path where self dynamic library in
 * @return      Path
 */
Path LibPath::GetSelfLibraryDir() const
{
    mmDlInfo info;
    LibPath& (*instancePtr)() = &LibPath::Instance;
    const auto ret = mmDladdr(reinterpret_cast<void *>(instancePtr), &info);
    if (ret != EN_OK) {
        IDE_LOGE("Cannot find symbol GetSelfLibraryDir");
        return Path();
    }
    IDE_LOGD("Find symbol GetSelfLibraryDir in %s", info.dli_fname);
    Path path(info.dli_fname); // entire so name
    const auto name = path.GetFileName();
    if (name.length() <= strlen(LIBSUFFIX) ||
        name.compare(name.length() - strlen(LIBSUFFIX), strlen(LIBSUFFIX), LIBSUFFIX) != 0) {
        path = GetSelfPath();
    }

    if (!path.RealPath()) {
        IDE_LOGW("Can not get realpath self library path %s.", path.GetCString());
        return Path();
    }

    IDE_LOGI("Get self library path: %s", path.GetCString());

    return path.ParentPath();
}

/**
 * @brief       Get directory path where self binary
 * @return      Path
 */
Path LibPath::GetSelfPath() const
{
    Path selfPath;
    char curPath[MMPA_MAX_PATH + 1] = {0};
    const auto len = readlink("/proc/self/exe", curPath, MMPA_MAX_PATH);
    if (len <= 0 || len > MMPA_MAX_PATH) {
        IDE_LOGE("Get self path failed.");
        return selfPath;
    }
    curPath[len] = '\0';

    selfPath = curPath;
    IDE_LOGI("Get self path: %s", selfPath.GetCString());
    return selfPath;
}

std::string LibPath::GetTargetPath(const std::string &concatName) const
{
    Path installBasePath = GetInstallPath();
    IDE_CTRL_VALUE_FAILED(!installBasePath.Empty(), return "", "Failed to get install path.");
    return installBasePath.Concat(concatName).GetString();
}

bool LibPath::IsPluginSo(const std::string &fileName) const
{
    const std::string prefix = "adump_";
    const std::string suffix = "_plugin.so";
    if (fileName.size() < prefix.size() + suffix.size()) {
        return false;
    }
    if ((fileName.substr(0, prefix.size()) != prefix) || (fileName.substr(fileName.size() - suffix.size()) != suffix)) {
        return false;
    }
    return true;
}

std::vector<std::string> LibPath::ObtainAllPluginSo(const std::string &searchPath) const
{
    std::vector<std::string> result;
    std::string realPath;
    IDE_CTRL_VALUE_WARN(FileUtils::FileNameIsReal(searchPath, realPath) == IDE_DAEMON_OK, return result,
        "Unable to get real path of %s and the search path is %s.", realPath.c_str(), searchPath.c_str());
    IDE_CTRL_VALUE_WARN(FileUtils::IsFileExist(realPath), return result,
        "Unable to find so from %s.", realPath.c_str());

    DIR* dir = opendir(realPath.c_str());
    IDE_CTRL_VALUE_WARN(dir, return result, "Unable to open dir %s with info %s.", realPath.c_str(), strerror(errno));

    struct dirent* entry;
    while ((entry = readdir(dir)) != nullptr) {
        if (entry->d_type == DT_REG) {
            std::string fileName = entry->d_name;
            if (IsPluginSo(fileName)) {
                result.push_back(realPath + "/" + fileName);
            }
        }
    }
    closedir(dir);
    return result;
}

} // namespace Adx

