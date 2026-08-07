/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TSD_UT_COMMON_UTIL_FUNC_H
#define TSD_UT_COMMON_UTIL_FUNC_H
#include <cstdlib>
#include <memory>
#include <string>
namespace tsd {
class ScopedTempFile {
public:
    explicit ScopedTempFile(const std::string& content = "");
    ~ScopedTempFile();
    ScopedTempFile(const ScopedTempFile&) = delete;
    ScopedTempFile& operator=(const ScopedTempFile&) = delete;
    const std::string& Path() const { return path_; }
    bool IsValid() const { return !path_.empty(); }
    void Remove();

private:
    std::string path_;
};

class ScopedTempDir {
public:
    ScopedTempDir();
    ~ScopedTempDir();
    ScopedTempDir(const ScopedTempDir&) = delete;
    ScopedTempDir& operator=(const ScopedTempDir&) = delete;
    const std::string& Path() const { return path_; }
    bool IsValid() const { return !path_.empty(); }
    bool WriteFile(const std::string& name, const std::string& content = "this is tmp file\n") const;

private:
    std::string path_;
};

class ScopedEnvVar {
public:
    explicit ScopedEnvVar(const char* name) : name_(name)
    {
        const char* value = std::getenv(name);
        existed_ = (value != nullptr);
        if (existed_) {
            value_ = value;
        }
    }

    ~ScopedEnvVar()
    {
        if (existed_) {
            (void)setenv(name_.c_str(), value_.c_str(), 1);
        } else {
            (void)unsetenv(name_.c_str());
        }
    }

    ScopedEnvVar(const ScopedEnvVar&) = delete;
    ScopedEnvVar& operator=(const ScopedEnvVar&) = delete;

private:
    std::string name_;
    std::string value_;
    bool existed_ = false;
};
} // namespace tsd
#endif
