/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "tsd_util_func.h"
#include <iostream>
#include <fstream>
#include <algorithm>
#include <cctype>
#include <csignal>
#include <cstring>
#include <dirent.h>
#include <dlfcn.h>
#include <semaphore.h>
#include <thread>
#include <cerrno>
#include <sys/wait.h>
#include <regex.h>
#include <climits>
#include <cstdlib>
#include <sstream>
#include <iomanip>
#include "inc/basic_define.h"
#include "inc/weak_ascend_hal.h"
#include "tsd_sha256.h"
#include "tsd_log.h"

namespace {
constexpr int32_t SYSTE_EXECUTE_CMD_ERROR = 127; // 与system实现保持一致
// min number of vDeviceId
constexpr const uint32_t VDEVICE_MIN_CPU_NUM = 32U;
// max number of vDeviceId
constexpr const uint32_t VDEVICE_MAX_CPU_NUM = 64U;
} // namespace

namespace tsd {
void Trim(std::string& str)
{
    if (str.empty()) {
        return;
    }
    (void)str.erase(static_cast<size_t>(0), str.find_first_not_of(" "));
    (void)str.erase(str.find_last_not_of(" ") + static_cast<size_t>(1));
}

void TrimWhitespace(std::string& str)
{
    auto isSpace = [](unsigned char c) { return std::isspace(c) != 0; };
    while (!str.empty() && isSpace(static_cast<unsigned char>(str.back()))) {
        str.pop_back();
    }
    size_t pos = 0U;
    while (pos < str.size() && isSpace(static_cast<unsigned char>(str[pos]))) {
        ++pos;
    }
    if (pos > 0U) {
        (void)str.erase(0U, pos);
    }
}

std::vector<std::string> SplitByChar(const std::string& s, char sep)
{
    std::vector<std::string> tokens;
    std::string cur;
    for (char c : s) {
        if (c == sep) {
            tokens.emplace_back(std::move(cur));
            cur.clear();
        } else {
            cur.push_back(c);
        }
    }
    tokens.emplace_back(std::move(cur));
    return tokens;
}

int32_t CompareSegmentNumeric(const std::string& a, const std::string& b)
{
    auto allDigit = [](const std::string& s) {
        return !s.empty() &&
               std::all_of(s.begin(), s.end(), [](char c) { return std::isdigit(static_cast<unsigned char>(c)) != 0; });
    };
    const bool aDigit = allDigit(a);
    const bool bDigit = allDigit(b);
    if (aDigit && bDigit) {
        std::string aa = a;
        std::string bb = b;
        size_t pa = aa.find_first_not_of('0');
        size_t pb = bb.find_first_not_of('0');
        aa = (pa == std::string::npos) ? "0" : aa.substr(pa);
        bb = (pb == std::string::npos) ? "0" : bb.substr(pb);
        if (aa.size() != bb.size()) {
            return (aa.size() < bb.size()) ? -1 : 1;
        }
        if (aa == bb) {
            return 0;
        }
        return (aa < bb) ? -1 : 1;
    }
    if (a == b) {
        return 0;
    }
    return (a < b) ? -1 : 1;
}

uint64_t CalFileSize(const std::string& filePath)
{
    struct stat st = {};
    const auto ret = lstat(filePath.c_str(), &st);
    if (ret != 0) {
        TSD_RUN_WARN(
            "Getting the file stat was not successful, ret=%d, path=%s, reason=%s", ret, filePath.c_str(),
            SafeStrerror().c_str());
        return 0UL;
    }

    return st.st_size;
}

bool ValidateStr(const std::string& str, const std::string& mode)
{
    regex_t reg;
    int32_t ret = regcomp(&reg, mode.c_str(), REG_EXTENDED | REG_NOSUB);
    if (ret != 0) {
        return false;
    }
    ret = regexec(&reg, str.c_str(), static_cast<size_t>(0), nullptr, 0);
    if (ret != 0) {
        regfree(&reg);
        return false;
    }

    regfree(&reg);
    return true;
}

void GetScheduleEnv(const char_t* const envName, std::string& envValue)
{
    const size_t envValueMaxLen = 1024UL * 1024UL;
    if (envName == nullptr) {
        return;
    }
    try {
        const char_t* const envTemp = std::getenv(envName);
        if ((envTemp == nullptr) || (strnlen(envTemp, envValueMaxLen) >= envValueMaxLen)) {
            TSD_WARN("Get env[%s] failed", envName);
            return;
        }
        envValue = envTemp;
    } catch (std::exception& e) {
        TSD_ERROR("get env failed:[%s]", e.what());
    }
}

bool GetFlagFromEnv(const char_t* const envStr, const char_t* const envValue)
{
    std::string isFlag;
    GetScheduleEnv(envStr, isFlag);
    if (!isFlag.empty()) {
        if (isFlag == envValue) {
            return true;
        }
    }
    return false;
}

bool IsFpgaEnv()
{
    static const bool isFpga = GetFlagFromEnv("DATAMASTER_RUN_MODE", "1");
    return isFpga;
}

bool CheckRealPath(const std::string& inputPath)
{
    if (inputPath.empty()) {
        TSD_RUN_INFO("Input path is empty");
        return false;
    }
    if (inputPath.length() >= static_cast<size_t>(PATH_MAX)) {
        TSD_RUN_INFO("Input path must less than [%d]", PATH_MAX);
        return false;
    }
    std::unique_ptr<char_t[]> path(new (std::nothrow) char_t[PATH_MAX]);
    if (path == nullptr) {
        TSD_RUN_WARN("Alloc memory for path failed.");
        return false;
    }

    const auto eRet = memset_s(path.get(), PATH_MAX, 0, PATH_MAX);
    if (eRet != EOK) {
        TSD_RUN_WARN("Mem set error, ret= [%d]", eRet);
        return false;
    }

    if (realpath(inputPath.data(), path.get()) == nullptr) {
        TSD_RUN_WARN("Format to realpath failed, inputPath is [%s]", inputPath.c_str());
        return false;
    }
    std::string normalizedPath(path.get());
    if (normalizedPath[normalizedPath.size() - static_cast<size_t>(1)] != '/') {
        (void)normalizedPath.append("/");
    }
    if (strncmp(normalizedPath.c_str(), inputPath.c_str(), inputPath.length()) != 0) {
        TSD_RUN_INFO("Invalid path [%s], should be [%s]", inputPath.c_str(), normalizedPath.c_str());
        return false;
    }
    return true;
}

bool CheckValidatePath(const std::string& path)
{
    const std::string pathPattern = "^[0-9a-zA-Z\\/\\_\\.\\-]+$";
    return ValidateStr(path, pathPattern);
}

int32_t TsdExecuteCmd(const std::string& cmd)
{
    if (cmd.empty()) {
        return -1;
    }

    int32_t status = 0;
    const int32_t pid = vfork();
    if (pid < 0) {
        status = -1;
    } else if (pid == 0) {
        (void)execl("/bin/sh", "sh", "-c", cmd.c_str(), nullptr);
        _exit(SYSTE_EXECUTE_CMD_ERROR);
    } else {
        while (waitpid(pid, &status, 0) < 0) {
            if (errno != EINTR) {
                status = -1;
                break;
            }
        }
    }

    return status;
}

int32_t PackSystem(const char_t* const cmdLine)
{
    const sighandler_t oldHandler = signal(SIGCHLD, nullptr);
    // system()函数失败是由于“ No child processes”
    // 如果SIGCHLD信号行为被设置为SIG_IGN时，waitpid()函数有可能因为找不到子进程而报ECHILD错误
    // 是因为system()函数依赖了系统的一个特性，那就是内核初始化进程时对SIGCHLD信号的处理方式为SIG_DFL
    const int32_t ret = TsdExecuteCmd(cmdLine);
    TSD_INFO(
        "[TSDaemon] PackSystem cmd: [%s], result: [%d], errno[%d], reason[%s].", cmdLine, ret, errno,
        SafeStrerror().c_str());
    (void)signal(SIGCHLD, oldHandler);
    return ret;
}

static bool IsTinyRuntime()
{
#ifdef TINY_RUNTIME
    return true;
#else
    return false;
#endif
}

/**
 * int strerror_r(int errnum, char buf[.buflen], size_t buflen); POSIX
 * char *strerror_r(int errnum, char buf[.buflen], size_t buflen); GNU
 */
std::string SafeStrerror()
{
    const uint32_t errnoLen = 256U;
    char_t errBuf[errnoLen] = {};
    auto errorMsg = strerror_r(errno, &errBuf[0], errnoLen);
    if (IsTinyRuntime()) {
        if (errorMsg == 0) {
            errBuf[errnoLen - 1U] = '\0';
            return std::string(errBuf);
        }
    } else {
        const char_t* errorMsgStr = reinterpret_cast<char_t*>(errorMsg);
        if (errorMsgStr != nullptr) {
            return std::string(errorMsgStr);
        }
    }
    return "";
}

uint32_t CalcUniqueVfId(const uint32_t deviceId, const uint32_t vfId)
{
    if (IsVfModeCheckedByDeviceId(deviceId)) {
        return deviceId;
    }

    if ((deviceId == 0U) || (vfId == 0U)) {
        return vfId;
    }

    static uint32_t maxNumSpDev = 0U;
    if ((&halGetDeviceVfMax != nullptr) && (maxNumSpDev == 0U)) {
        const auto retRes = halGetDeviceVfMax(deviceId, &maxNumSpDev);
        if ((retRes != DRV_ERROR_NONE) || (maxNumSpDev > DEVICE_MAX_SPLIT_NUM)) {
            TSD_ERROR("Failed to get device cat vf number, result[%d], max num[%u].", retRes, maxNumSpDev);
            return UINT32_MAX;
        }
    }
    return (maxNumSpDev * deviceId) + vfId;
}

bool TransStrToInt(const std::string& para, int32_t& value)
{
    try {
        value = std::stoi(para);
    } catch (...) {
        return false;
    }

    return true;
}

void RemoveOneFile(const std::string& filePath)
{
    if (filePath.empty()) {
        return;
    }

    if (access(filePath.c_str(), F_OK) != 0) {
        TSD_INFO("The file does not exist, no need to remove, path=%s", filePath.c_str());
        return;
    }

    const int32_t ret = remove(filePath.c_str());
    if (ret != 0) {
        TSD_RUN_WARN(
            "Removing the file was not successful, ret=%d, path=%s, reason=%s", ret, filePath.c_str(),
            SafeStrerror().c_str());
        return;
    }

    TSD_INFO("Remove file success, path=%s", filePath.c_str());
}

bool IsDirEmpty(const std::string& dirPath)
{
    DIR* dir = opendir(dirPath.c_str());
    if (!dir) {
        return true;
    }

    struct dirent* entry;
    int count = 0;

    while ((entry = readdir(dir)) != nullptr) {
        if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
            continue;
        }

        count++;
        if (count > 0) {
            (void)closedir(dir);
            return false;
        }
    }

    (void)closedir(dir);
    return true;
}

std::string CalFileSha256HashValue(const std::string& filePath)
{
    std::ifstream curFile(filePath, std::ios::binary);
    if (!curFile) {
        TSD_RUN_WARN("Opening file:%s was not successful, reason:%s", filePath.c_str(), SafeStrerror().c_str());
        return "";
    }

    std::stringstream fileBuffer;
    fileBuffer << curFile.rdbuf();
    std::string fileBinaryValue = fileBuffer.str();
    std::string hashHex =
        sha256::ComputeHexString(PtrToPtr<const char, const uint8_t>(fileBinaryValue.c_str()), fileBinaryValue.size());
    curFile.close();
    return hashHex;
}

bool IsCurrentVfMode(const uint32_t deviceId, const uint32_t vfId)
{
    if ((IsVfModeCheckedByDeviceId(deviceId)) || (vfId > 0)) {
        return true;
    } else {
        return false;
    }
}

bool IsVfModeCheckedByDeviceId(const uint32_t deviceId)
{
    if ((deviceId >= VDEVICE_MIN_CPU_NUM) && (deviceId < VDEVICE_MAX_CPU_NUM)) {
        return true;
    } else {
        return false;
    }
}

std::string GetHostSoPath()
{
    Dl_info info = {};
    if (dladdr(reinterpret_cast<void*>(drvHdcSendFile), &info) == 0) {
        TSD_INFO("Getting the host so path was not successful, reason[%s], errno[%d]", SafeStrerror().c_str(), errno);
        return "";
    }
    TSD_INFO("dli_fname[%s]", info.dli_fname);
    if (info.dli_fname == nullptr) {
        return "";
    }
    std::string path(info.dli_fname);
    const size_t pos = path.find_last_of('/');
    std::string hostSoPath;
    if (pos != std::string::npos) {
        hostSoPath = path.substr(0, pos + static_cast<size_t>(1));
    } else {
        hostSoPath = "./";
    }
    TSD_INFO("host so path[%s]", hostSoPath.c_str());
    return hostSoPath;
}
} // namespace tsd
