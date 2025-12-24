/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_COMMON_PATH_H
#define ADUMP_COMMON_PATH_H

#include <string>
#include "mmpa_api.h"

namespace Adx {
class Path {
public:
    Path() noexcept : path_() {}
    explicit Path(const std::string &path) : path_(path) {}
    ~Path() = default;

    Path &operator = (const std::string &path);
    bool operator == (const Path &other) const;
    Path &operator += (const std::string &path);
    Path &Assign(const std::string &path);
    Path &Append(const std::string &path);
    Path &Concat(const std::string &path);
    Path &AddExtension(const std::string &extension);
    std::string GetExtension() const;
    std::string GetFileName() const;
    bool Empty() const;
    bool Exist() const;
    bool Asccess(mmMode_t mode) const;
    bool IsDirectory() const;
    bool RealPath();
    Path ParentPath() const;
    bool CreateDirectory(bool recursion = false) const;
    std::string GetString() const;
    const char *GetCString() const;

private:
    void AppendPath(const std::string &path);
    void AddSeperator();
    std::string path_;
};
} // namespace Adx

#endif // ADUMP_COMMON_PATH_H