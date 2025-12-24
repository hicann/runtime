/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TEST_CASE_WORKSPACE_H
#define TEST_CASE_WORKSPACE_H

#include <string>
#include <mutex>

namespace Tools {

class CaseWorkspace {
public:
    explicit CaseWorkspace(const std::string &caseName, bool autoClean = true);
    ~CaseWorkspace();
    CaseWorkspace(const CaseWorkspace &) = delete;
    CaseWorkspace &operator=(const CaseWorkspace &) = delete;
    std::string Init();
    void Clean() const;
    std::string Root() const;
    void Print(const char *fmt, ...) const;
    void Echo(const std::string &context, const std::string &file, bool endline = false, bool append = true) const;
    std::string Touch(const std::string &file) const;
    std::string Mkdir(const std::string &dir) const;
    void Chmod(const std::string &path, const std::string &mode) const;

private:
    std::string InitRootPath();
    uint64_t GetUniqueId();
    static std::mutex mtx_;
    static uint64_t uniqueId_;
    std::string caseName_;
    std::string rootPath_;
    bool autoClean_;
};
} // namespace Tools
#endif // TEST_CASE_WORKSPACE_H