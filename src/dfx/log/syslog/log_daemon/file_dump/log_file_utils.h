/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_FILE_UTILS_H
#define LOG_FILE_UTILS_H
#include <cstdint>
#include <string>
#include <vector>
#include "mmpa_api.h"
#include "extra_config.h"
#include "ide_daemon_api.h"
namespace Adx {
using FileFilterFn = int (*)(const mmDirent *dir);
class LogFileUtils {
public:
    static std::string ReplaceAll(std::string &base, const std::string &src, const std::string &dst);
    static IdeErrorT CopyFileAndRename(const std::string &src, const std::string &des);
    static bool GetDirFileList(const std::string &path, std::vector<std::string> &list, const FileFilterFn fileter,
        const std::string &fileNamePrefix, int32_t recursiveDepth);
    static bool StartsWith(const std::string &s, const std::string &sub);
    static bool EndsWith(const std::string &s, const std::string &sub);
    static int32_t FilePathIsReal(const std::string &filePath, std::string &resultPath);
    static int32_t FileNameIsReal(const std::string &file, std::string &resultPath);
    static IdeErrorT GetFileName(const std::string &path, std::string &name);
    static bool IsDirectory(const std::string &path);
    static IdeErrorT CreateDir(const std::string &path);
    static std::string GetFileDir(const std::string &path);
    static bool IsDirExist(const std::string &path);
    static bool IsAccessible(const std::string &path);
    static bool IsFileExist(const std::string &path);
    static int32_t RemoveDir(std::string &dirName, int32_t depth);
};
}
#endif