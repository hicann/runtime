/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "common_util_func.h"
#include <cerrno>
#include <iostream>
#include <fstream>
#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>
namespace tsd {

ScopedTempFile::ScopedTempFile(const std::string& content)
{
    char path[] = "/tmp/tsd_ut_file_XXXXXX";
    const int fd = mkstemp(path);
    if (fd < 0) {
        return;
    }
    path_ = path;
    if (!content.empty()) {
        (void)write(fd, content.data(), content.size());
    }
    (void)close(fd);
}

ScopedTempFile::~ScopedTempFile() { Remove(); }

void ScopedTempFile::Remove()
{
    if (!path_.empty()) {
        (void)unlink(path_.c_str());
    }
}

ScopedTempDir::ScopedTempDir()
{
    char path[] = "/tmp/tsd_ut_dir_XXXXXX";
    if (mkdtemp(path) != nullptr) {
        path_ = path;
    }
}

ScopedTempDir::~ScopedTempDir()
{
    DIR* dir = opendir(path_.c_str());
    if (dir != nullptr) {
        for (dirent* entry = readdir(dir); entry != nullptr; entry = readdir(dir)) {
            const std::string name = entry->d_name;
            if ((name != ".") && (name != "..")) {
                (void)unlink((path_ + "/" + name).c_str());
            }
        }
        (void)closedir(dir);
    }
    if (!path_.empty()) {
        (void)rmdir(path_.c_str());
    }
}

bool ScopedTempDir::WriteFile(const std::string& name, const std::string& content) const
{
    const std::string dstFile = path_ + "/" + name;
    std::ofstream outFile(dstFile);
    if (!outFile) {
        return false;
    }
    outFile << content;
    outFile.close();
    return outFile.good();
}
} // namespace tsd
