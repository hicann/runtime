/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADX_COMMON_FILE_UTILS_H
#define ADX_COMMON_FILE_UTILS_H
#include <cstdint>
#include <string>
#include "mmpa_api.h"
#include "extra_config.h"
#include "adump_device_pub.h"
#include "ide_os_type.h"
#define FILE_MMCLOSE_AND_SET_INVALID(fd) do {                   \
    if ((fd) >= 0) {                                            \
        (void)mmClose(fd);                                      \
        fd = -1;                                                \
    }                                                           \
} while (0)

namespace Adx {
#if (OS_TYPE == LINUX)
constexpr char OS_SPLIT_CHAR                 = '/';
const std::string OS_SPLIT_STR               = "/";
#else
constexpr char OS_SPLIT_CHAR                 = '\\';
const std::string OS_SPLIT_STR               = "\\";
static const uint32_t WIN_PATH_MIN_LENGTH    = 2;
constexpr char COLON                         = ':';
#endif
constexpr uint32_t DEFAULT_PATH_MODE         = 0700;
constexpr uint32_t DISK_RESERVED_SPACE       = 1048576; // disk reserved space 1Mb
class FileUtils {
public:
    static bool IsFileExist(const std::string &path);
    static IdeErrorT WriteFile(const std::string &fileName, IdeSendBuffT data, uint32_t len, int64_t offset);
    static IdeErrorT CreateDir(const std::string &path);
    static std::string GetFileDir(const std::string &path);
    static bool IsDiskFull(const std::string &path, uint64_t size);
    static IdeErrorT GetFileName(const std::string &path, std::string &name);
    static bool CheckNonCrossPath(const std::string &path);
    static int32_t FilePathIsReal(const std::string &filePath, std::string &resultPath);
    static int32_t FileNameIsReal(const std::string &file, std::string &resultPath);
    static bool IsValidDirChar(const std::string &path);
    static bool StartsWith(const std::string &s, const std::string &sub);
    static bool EndsWith(const std::string &s, const std::string &sub);
    static std::string ReplaceAll(std::string &base, const std::string &src, const std::string &dst);
    static bool IsAbsolutePath(const std::string &path);
    static IdeErrorT AddMappingFileItem(const std::string &fileName, const std::string &hashValue);
    static bool IsPathHasPermission(const std::string &path, std::string &errorMsg);
};
}
#endif