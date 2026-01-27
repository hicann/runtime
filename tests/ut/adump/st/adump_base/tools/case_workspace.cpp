/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "case_workspace.h"
#include <iostream>
#include <unistd.h>
#include <stdarg.h>
namespace Tools {

constexpr uint64_t MAX_UNIQUE_ID = 0xffff;
constexpr uint32_t MAX_PATH_LENGTH = 512;

std::mutex CaseWorkspace::mtx_;
uint64_t CaseWorkspace::uniqueId_ = 0;

CaseWorkspace::CaseWorkspace(const std::string &caseName, bool autoClean)
    : caseName_(caseName), autoClean_(autoClean)
{
    (void) Init();
}

CaseWorkspace::~CaseWorkspace()
{
    if (autoClean_) {
        Clean();
    }
}

std::string CaseWorkspace::Init()
{
    rootPath_ = InitRootPath();
    return rootPath_;
}

void CaseWorkspace::Clean() const
{
    Print("Clean : %s", rootPath_.c_str());
    std::string cmd = "rm -fr " + rootPath_;
    system(cmd.c_str());
    return;
}

std::string CaseWorkspace::Root() const
{
    return rootPath_;
}

std::string CaseWorkspace::Touch(const std::string &file) const
{
    std::string absFilePath = rootPath_ + "/" + file;
    Print("Touch %s", absFilePath.c_str());
    std::string cmd = "touch " + absFilePath;
    system(cmd.c_str());
    return absFilePath;
}

std::string CaseWorkspace::Mkdir(const std::string &dir) const
{
    std::string absDirPath = rootPath_ + "/" + dir;
    Print("Mkdir %s", absDirPath.c_str());
    std::string cmd = "mkdir -p " + absDirPath;
    system(cmd.c_str());
    return absDirPath;
}

void CaseWorkspace::Print(const char *fmt, ...) const
{
    if (fmt == nullptr) {
        printf("[CaseWorkspace][%s] null\n", caseName_.c_str());
        fflush(stdout);
        return;
    }
    printf("[CaseWorkspace][%s] ", caseName_.c_str());

    std::string format(fmt);
    if (!format.empty() && format.back() != '\n') {
        format += '\n';
    }
    va_list args;
    va_start(args, format.c_str());
    vfprintf(stdout, format.c_str(), args);
    va_end(args);
    fflush(stdout);
}

void CaseWorkspace::Echo(const std::string &context, const std::string &file, bool endline, bool append) const
{
    std::string newline = endline ? "" : "-n";
    std::string redirect = append ? ">>" : ">";
    std::string absFile = rootPath_ + "/" + file;
    Print("echo %s \"%s\" %s %s", newline.c_str(), context.c_str(), redirect.c_str(), absFile.c_str());
    std::string cmd = "echo " + newline + " \"" + context + "\" " + redirect + " " + absFile;
    system(cmd.c_str());
}

void CaseWorkspace::Chmod(const std::string &path, const std::string &mode) const
{
    std::string absPath = rootPath_ + "/" + path;
    Print("Chmod path %s, mode: %s", absPath.c_str(), mode.c_str());
    std::string cmd = "chmod " + mode + " " + absPath;
    system(cmd.c_str());
}

std::string CaseWorkspace::InitRootPath()
{
    char cwd[MAX_PATH_LENGTH] = {0};
    char *ptr = getcwd(cwd, MAX_PATH_LENGTH);
    if (ptr == nullptr) {
        Print("Get current case cwd failed.");
        return "";
    }

    uint64_t uniqueId = GetUniqueId();
    int32_t pid = static_cast<int32_t>(getpid());
    std::string dirName = caseName_ + "_" + std::to_string(pid) + "_" + std::to_string(uniqueId);

    rootPath_ = std::string(cwd) + "/" + dirName;
    Print("Init : %s", rootPath_.c_str());
    std::string cmd = "mkdir -p " + rootPath_;
    system(cmd.c_str());
    return rootPath_;
}

uint64_t CaseWorkspace::GetUniqueId()
{
    std::lock_guard<std::mutex> lock(mtx_);
    ++uniqueId_;
    uniqueId_ = uniqueId_ % MAX_UNIQUE_ID;
    return uniqueId_;
}

} // namespace Tools