/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "path.h"
#include <algorithm>
#include "str_utils.h"
#include "log/hdc_log.h"

namespace Adx {
namespace {
constexpr char DIRECTORY_SEPARATOR = '/';
constexpr char FILE_EXTENSION_CHAR = '.';

constexpr mmMode_t DEFAULT_DIR_MODE = M_IRUSR | M_IWUSR | M_IXUSR;
} // namespace

Path &Path::operator = (const std::string &path)
{
    path_ = path;
    return *this;
}

bool Path::operator == (const Path &other) const
{
    return this->path_ == other.GetString();
}

Path &Path::operator += (const std::string &path)
{
    return Append(path);
}

Path &Path::Assign(const std::string &path)
{
    path_ = path;
    return *this;
}

Path &Path::Append(const std::string &path)
{
    AddSeperator();
    AppendPath(path);
    AddSeperator();
    return *this;
}

Path &Path::Concat(const std::string &path)
{
    AddSeperator();
    AppendPath(path);
    return *this;
}

Path &Path::AddExtension(const std::string &extension)
{
    std::string ext = StrUtils::Trim(extension);
    if (path_.empty() || ext.empty() || GetExtension() == ext) {
        return *this;
    }

    if (ext.front() != FILE_EXTENSION_CHAR) {
        path_ += FILE_EXTENSION_CHAR;
    }
    path_.append(ext);
    return *this;
}

std::string Path::GetExtension() const
{
    std::string file = GetFileName();
    const auto pos = file.rfind(FILE_EXTENSION_CHAR);
    return pos != std::string::npos ? file.substr(pos) : "";
}

std::string Path::GetFileName() const
{
    const auto pos = path_.find_last_of(DIRECTORY_SEPARATOR);
    return pos != std::string::npos ? path_.substr(pos + 1) : path_;
}

bool Path::Empty() const
{
    return path_.empty();
}

bool Path::Exist() const
{
    return Asccess(F_OK);
}

bool Path::Asccess(mmMode_t mode) const
{
    return !path_.empty() && mmAccess2(path_.c_str(), mode) == EN_OK;
}

bool Path::IsDirectory() const
{
    return mmIsDir(path_.c_str()) == EN_OK;
}

bool Path::RealPath()
{
    if (path_.empty()) {
        return false;
    }

    char realPath[MMPA_MAX_PATH] = {0};
    const int32_t ret = mmRealPath(path_.c_str(), realPath, MMPA_MAX_PATH);
    if (ret != EN_OK) {
        return false;
    }
    path_ = realPath;
    return true;
}

/*
 * @brief: Get parent path
 *         /path/to/file -> /path/to
 *         / -> /
 *         /file -> /
 *         file -> ""
 */
Path Path::ParentPath() const
{
    if (path_.length() == 1 && path_[0] == DIRECTORY_SEPARATOR) {
        return Path(path_);
    }

    const size_t pos = path_.find_last_of(DIRECTORY_SEPARATOR);
    std::string parentPath = pos != std::string::npos ?
        (pos == 0 ? std::string(&DIRECTORY_SEPARATOR, 1) : path_.substr(0, pos)) : "";
    return Path(parentPath);
}

bool Path::CreateDirectory(bool recursion) const
{
    if (path_.empty() || path_.length() > MMPA_MAX_PATH) {
        IDE_LOGW("Director path is empty or overlength, path: %s", path_.c_str());
        return false;
    }

    if (IsDirectory()) {
        return true;
    }

    if (recursion) {
        Path parentPath = ParentPath();
        if (!parentPath.Empty() && !parentPath.CreateDirectory(recursion)) {
            return false;
        }
    }

    const int32_t ret = mmMkdir(path_.c_str(), DEFAULT_DIR_MODE);
    if (ret != 0 && errno != EEXIST) {
        IDE_LOGW("Can not mkdir %s, mode: %d, errno: %s", path_.c_str(), DEFAULT_DIR_MODE, strerror(errno));
        return false;
    }
    return true;
}

std::string Path::GetString() const
{
    return path_;
}

const char *Path::GetCString() const
{
    return path_.c_str();
}

void Path::AppendPath(const std::string &path)
{
    std::string newPath = StrUtils::Trim(path);
    (void)newPath.erase(newPath.begin(),
        std::find_if(newPath.begin(), newPath.end(), [](uint8_t ch) { return ch != DIRECTORY_SEPARATOR; }));
    (void)newPath.erase(std::find_if(newPath.rbegin(), newPath.rend(),
        [](uint8_t ch) {
            return ch != DIRECTORY_SEPARATOR;
        }).base(),
        newPath.end());
    path_ += newPath;
}

void Path::AddSeperator()
{
    if (!path_.empty() && path_.back() != DIRECTORY_SEPARATOR) {
        path_ += DIRECTORY_SEPARATOR;
    }
}
} // namespace Adx