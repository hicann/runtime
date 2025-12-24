/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "utils.h"
#include <algorithm>
#include <cctype>
#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <ctime>
#include <locale>
#include <iomanip>
#include <string>
#include <ctime>
#include "config/config.h"
#include "securec.h"
#include "cmd_log/cmd_log.h"
#if (defined(linux) || defined(__linux__))
#include <sys/file.h>
#endif

namespace analysis {
namespace dvvp {
namespace common {
namespace utils {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::cmdlog;

std::mutex g_envMtx;
const unsigned long long CHANGE_FROM_S_TO_NS = 1000000000;
const uint32_t MAX_FILE_DEPTH = 10;

unsigned long long Utils::GetClockRealtime()
{
#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
    OsalTimespec now;
    (void)memset_s(&now, sizeof(now), 0, sizeof(now));
    now = OsalGetTickCount();
    return ((unsigned long long)(now.tv_sec) * CHANGE_FROM_S_TO_NS) + (unsigned long long)(now.tv_nsec);
#else
    struct timespec now;
    (void)memset_s(&now, sizeof(now), 0, sizeof(now));
    (void)clock_gettime(CLOCK_REALTIME, &now);
    return (static_cast<unsigned long long>(now.tv_sec) * CHANGE_FROM_S_TO_NS) +
        static_cast<unsigned long long>(now.tv_nsec);
#endif
}

unsigned long long Utils::GetClockMonotonicRaw()
{
    OsalTimespec now = OsalGetTickCount();
    return (static_cast<unsigned long long>(now.tv_sec) * CHANGE_FROM_S_TO_NS) +
        static_cast<unsigned long long>(now.tv_nsec);
}

unsigned long long Utils::GetCPUCycleCounter()
{
    unsigned long long cycles;
#ifndef CPU_CYCLE_NO_SUPPORT
#if defined(__aarch64__)
    asm volatile("mrs %0, cntvct_el0" : "=r" (cycles));
#elif defined(__x86_64__)
    const int32_t uint32Bits = 32;  // 32 is uint bit count
    uint32_t hi = 0;
    uint32_t lo = 0;
    __asm__ __volatile__ ("rdtsc" : "=a"(lo), "=d"(hi));
    cycles = (static_cast<unsigned long long>(lo)) | ((static_cast<unsigned long long>(hi)) << uint32Bits);
#elif defined(__arm__) && !defined(PROF_LITE)
    const int32_t uint32Bits = 32;  // 32 is uint bit count
    uint32_t hi = 0;
    uint32_t lo = 0;
    asm volatile("mrrc p15, 1, %0, %1, c14" : "=r"(lo), "=r"(hi));
    cycles = (static_cast<unsigned long long>(lo)) | ((static_cast<unsigned long long>(hi)) << uint32Bits);
#else
    cycles = 0;
#endif
#else
    cycles = 0;
#endif
    return cycles;
}

int64_t Utils::GetFileSize(const std::string &path)
{
    uint64_t size = 0;

    int32_t ret = OsalGetFileSize(path.c_str(), &size);
    if (ret < 0) {
        return -1;
    }

    return static_cast<int64_t>(size);
}

int32_t Utils::GetVolumeSize(const std::string &path, unsigned long long &size, VolumeSize sizeType)
{
    OsalDiskSize diskSize;
    int32_t ret = OsalGetDiskFreeSpace(path.c_str(), &diskSize);
    if (ret < 0) {
        return PROFILING_FAILED;
    }

    switch (sizeType) {
        case VolumeSize::AVAIL_SIZE:
            size = diskSize.availSize;
            break;
        case VolumeSize::FREE_SIZE:
            size = diskSize.freeSize;
            break;
        case VolumeSize::TOTAL_SIZE:
            size = diskSize.totalSize;
            break;
        default:
            ret = PROFILING_FAILED;
            break;
    }

    return ret;
}

bool Utils::IsDir(const std::string &path)
{
    if (path.length() == 0) {
        return false;
    }

    if (OsalIsDir(path.c_str()) != OSAL_EN_OK) {
        return false;
    }

    return true;
}

bool Utils::IsAllDigit(const std::string &digitStr)
{
    if (digitStr.empty()) {
        return false;
    }
    for (std::string::size_type i = 0; i < digitStr.size(); i++) {
        if (isdigit(digitStr[i]) == 0) {
            return false;
        }
    }
    return true;
}

bool Utils::IsDirAccessible(const std::string &path)
{
    if (!IsDir(path)) {
        MSPROF_LOGW("Path %s is not a dir", path.c_str());
        return false;
    }
    if (OsalAccess2(path.c_str(), OSAL_W_OK) == OSAL_EN_OK) {
        return true;
    }
    MSPROF_LOGW("No access to dir %s", path.c_str());
    return false;
}

bool Utils::IsFileExist(const std::string &path)
{
    if (path.empty()) {
        return false;
    }

    if (OsalAccess(path.c_str()) == OSAL_EN_OK) {
        return true;
    }

    return false;
}

std::vector<std::string> Utils::Split(const std::string &input_str,
                                      bool filter_out_enabled,
                                      const std::string &filter_out,
                                      const std::string &pattern)
{
    std::string::size_type pos;
    std::vector<std::string> res;
    if (input_str.empty()) {
        return res;
    }
    std::string str = input_str + pattern;
    const std::string::size_type size = str.size();
    for (std::string::size_type i = 0; i < size; i++) {
        pos = str.find(pattern, i);
        if (pos < size) {
            bool isOk = true;

            std::string ss = str.substr(i, pos - i);
            if ((filter_out_enabled && (ss.compare(filter_out) == 0))) {
                isOk = false;
            }

            if (isOk) {
                res.push_back(ss);
            }

            i = pos + pattern.size() - 1;
        }
    }

    return res;
}

int32_t Utils::RelativePath(const std::string &path,
                        const std::string &dir,
                        std::string &relativePath)
{
    const size_t pos = path.find(dir);
    if (pos == std::string::npos) {
        MSPROF_LOGE("Failed to find \"%s\" from \"%s\"", dir.c_str(), path.c_str());
        return PROFILING_FAILED;
    }

    relativePath = LeftTrim(path.substr(pos + dir.size()), "/\\");

    return PROFILING_SUCCESS;
}

#if (defined(linux) || defined(__linux__))
std::string Utils::DirName(const std::string &path)
{
    std::string result;
    char *pathc = MSVP_STRDUP(path.c_str());
    if (pathc != nullptr) {
        char *dirc = OsalDirName(pathc);
        if (dirc != nullptr) {
            result = dirc;
        }
        free(pathc);
        pathc = nullptr;
    }
    return result;
}
#else
std::string Utils::DirName(const std::string &path)
{
    std::string result;
    std::string filePath(path);
    const size_t last_slash_idx = filePath.rfind('\\');
    if (std::string::npos != last_slash_idx) {
        result = filePath.substr(0, last_slash_idx);
    }
    return result;
}
#endif

#if (defined(linux) || defined(__linux__))
std::string Utils::BaseName(const std::string &path)
{
    std::string result;
    char *pathc = MSVP_STRDUP(path.c_str());
    if (pathc != nullptr) {
        char *basec = OsalBaseName(pathc);
        if (basec != nullptr) {
            result = basec;
        }
        free(pathc);
        pathc = nullptr;
    }
    return result;
}
#else
std::string Utils::BaseName(const std::string &path)
{
    std::string result;
    std::string filePath(path);
    const size_t last_slash_idx = filePath.rfind('\\');
    if (std::string::npos != last_slash_idx) {
        result = filePath.substr(last_slash_idx + 1);
    }
    return result;
}
#endif

int32_t Utils::SplitPath(const std::string &path, std::string &dir, std::string &base)
{
    int32_t ret = PROFILING_FAILED;

    char *dirc = nullptr;
    char *basec = nullptr;
    char *bname = nullptr;
    char *dname = nullptr;

    dirc = MSVP_STRDUP(path.c_str());
    basec = MSVP_STRDUP(path.c_str());
    if (dirc != nullptr && basec != nullptr) {
        dname = OsalDirName(dirc);
        bname = OsalBaseName(basec);
        if (dname != nullptr && bname != nullptr) {
            dir = std::string(dname);
            base = std::string(bname);
            ret = PROFILING_SUCCESS;
        } else {
            MSPROF_LOGE("OsalDirName or OsalBaseName failed");
        }
    } else {
        MSPROF_LOGE("MSVP_STRDUP failed");
    }

    if (dirc != nullptr) {
        free(dirc);
        dirc = nullptr;
    }

    if (basec != nullptr) {
        free(basec);
        basec = nullptr;
    }

    return ret;
}

#if (defined(linux) || defined(__linux__))
int32_t Utils::CreateDir(const std::string &path)
{
    std::string curr = path;

    if (curr.empty()) {
        return PROFILING_FAILED;
    }
    if (IsFileExist(curr)) {
        MSPROF_LOGD("The file already exists, %s", BaseName(path).c_str());
        return PROFILING_SUCCESS;
    } else {
        std::string dir;
        std::string base;

        int32_t ret = SplitPath(curr, dir, base);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Split path failed");
            return ret;
        }
        ret = CreateDir(dir);
        if (ret != PROFILING_SUCCESS) {
            return ret;
        }
    }

    const OsalMode defaultFileMode = static_cast<OsalMode>(0750);  // 0750 means xwrx-r
    MSPROF_LOGI("CreateDir dir %s with 750", BaseName(path).c_str());
    if ((OsalMkdir(path.c_str(), defaultFileMode) != OSAL_EN_OK) && (errno != EEXIST)) {
        return PROFILING_FAILED;
    }

    if (OsalChmod(path.c_str(), defaultFileMode) != OSAL_EN_OK) {
        MSPROF_LOGW("Chmod : %s unsuccessfully", BaseName(path).c_str());
    }
    MSPROF_LOGI("Success to mkdir, FilePath : %s, FileMode : %o",
                BaseName(path).c_str(), static_cast<int32_t>(defaultFileMode));
    return PROFILING_SUCCESS;
}

#else
int32_t Utils::CreateDir(const std::string &path)
{
    std::string curr = path;
    if (curr.empty()) {
        return PROFILING_FAILED;
    }
    if (IsFileExist(curr)) {
        MSPROF_LOGD("The file already exists, %s", BaseName(path).c_str());
        return PROFILING_SUCCESS;
    }
    const OsalMode defaultFileMode = (OsalMode)0750;  // 0750 means xwrx-r
    if ((OsalMkdir(path.c_str(), defaultFileMode) != OSAL_EN_OK) && (errno != EEXIST)) {
        char errBuf[MAX_ERR_STRING_LEN + 1] = {0};
        MSPROF_LOGE("Failed to mkdir, FilePath : %s, FileMode : %o, ErrorCode : %d, ERRORInfo : %s",
            BaseName(path).c_str(), static_cast<int32_t>(defaultFileMode), OsalGetErrorCode(),
            OsalGetErrorFormatMessage(OsalGetErrorCode(), errBuf, MAX_ERR_STRING_LEN));
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}
#endif

void Utils::RemoveDir(const std::string &dir, bool rmTopDir)
{
    if ((dir.empty()) || (dir.compare("/")) == 0) {
        MSPROF_LOGE("empty compare failed.");
        return;
    }
    MSPROF_LOGI("RemoveDir dir %s", BaseName(dir).c_str());

    if (!rmTopDir) {
        OsalDirent **nameList = nullptr;
        const int32_t count = OsalScandir(dir.c_str(), &nameList, nullptr, nullptr);
        FUNRET_CHECK_EXPR_ACTION_LOGW(count == OSAL_EN_ERROR || count == OSAL_EN_INVALID_PARAM, return,
            "An anomaly was detected when the OsalScandir function processes %s with return code %d.",
            BaseName(dir).c_str(), OsalGetErrorCode());

        if (nameList == nullptr) {
            return;
        }

        for (int32_t i = 0; i < count; i++) {
            std::string fileName = nameList[i]->d_name;
            std::string childPath = dir + MSVP_SLASH + fileName;
            if ((fileName.compare(".") == 0) || (fileName.compare("..") == 0)) {
                continue;
            }

            if (IsDir(childPath)) {
                (void)OsalRmdir(childPath.c_str());
            } else {
                (void)OsalUnlink(childPath.c_str());
            }
        }

        OsalScandirFree(nameList, count);
    } else {
        FUNRET_CHECK_EXPR_ACTION_LOGW(OsalRmdir(dir.c_str()) != OSAL_EN_OK, return,
            "An anomaly was detected when the OsalRmdir function processes %s with return code %d.",
            BaseName(dir).c_str(), OsalGetErrorCode());
    }
}

bool Utils::IsSoftLink(const std::string &path)
{
#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
    return false;   // not soft-link
#else
    struct stat buf1;
    int32_t ret = stat(path.c_str(), &buf1);
    if (ret != 0) {
        MSPROF_LOGE("stat %s fail, ret=%d errno=%u", BaseName(path).c_str(), ret, errno);
        return true;
    }

    struct stat buf2;
    ret = lstat(path.c_str(), &buf2);
    if (ret != 0) {
        MSPROF_LOGE("lstat %s fail, ret=%d errno=%u", BaseName(path).c_str(), ret, errno);
        return true;
    }

    if (buf1.st_ino != buf2.st_ino) {
        return true;     // soft-link
    }

    return false;   // not soft-link
#endif
}

std::string Utils::CanonicalizePath(const std::string &path)
{
    std::string resolvedPath;
    std::string tmpPath = IdeReplaceWaveWithHomedir(path);
    if ((tmpPath.length() == 0) || (tmpPath.length() >= OSAL_MAX_PATH)) {
        return "";
    }

    char realPath[OSAL_MAX_PATH] = { 0 };
    int32_t ret = OsalRealPath(tmpPath.c_str(), realPath, OSAL_MAX_PATH);
    if (ret == OSAL_EN_OK) {
        MSPROF_LOGD("OsalRealPath ret=%d.", ret);
        resolvedPath = realPath;
    }
    MSPROF_LOGD("Input path:%s, canonicalized path:%s",
                BaseName(tmpPath).c_str(), BaseName(resolvedPath).c_str());

    return resolvedPath;
}

int32_t Utils::ExecCmd(const ExecCmdParams &execCmdParams,
    const std::vector<std::string> &argv,
    const std::vector<std::string> &envp,
    int32_t &exitCodeP,
    OsalProcess &childProcess)
{
    int32_t ret = PROFILING_FAILED;
    const std::string &cmd = execCmdParams.cmd;
    bool async = execCmdParams.async;
    std::string stdoutRedirectFile = execCmdParams.stdoutRedirectFile;
    constexpr int32_t maxArgvEnvSize = (1024 * 1024);  // 1024 * 1024 means 1mb
    if (argv.size() > maxArgvEnvSize || envp.size() > maxArgvEnvSize) {
        MSPROF_LOGE("invalid argv or envp size");
        return ret;
    }
    UtilsStringBuilder<std::string> builder;
    std::string argsStr = builder.Join(argv, " ");
    MSPROF_LOGI("Execute cmd:\"%s %s\", stdoutRedirectFile=%s",
                cmd.c_str(), argsStr.c_str(), stdoutRedirectFile.c_str());

    do {
        uint32_t ii = 0;
        const int32_t reserveArgvLen = 2;
        SHARED_PTR_ALIA<CHAR_PTR> argvArray(new(std::nothrow) CHAR_PTR[argv.size() + reserveArgvLen],
                                            std::default_delete<CHAR_PTR[]>());
        FUNRET_CHECK_NULL_PTR(argvArray, return PROFILING_FAILED);
        argvArray.get()[0] = const_cast<CHAR_PTR>(cmd.c_str());
        for (ii = 0; ii < static_cast<uint32_t>(argv.size()); ++ii) {
            argvArray.get()[ii + 1] = const_cast<CHAR_PTR>(argv[ii].c_str());
        }
        argvArray.get()[ii + 1] = nullptr;

        SHARED_PTR_ALIA<CHAR_PTR> envpArray(new(std::nothrow) CHAR_PTR[envp.size() + 1],
                                            std::default_delete<CHAR_PTR[]>());
        FUNRET_CHECK_NULL_PTR(envpArray, return PROFILING_FAILED);
        for (ii = 0; ii < static_cast<uint32_t>(envp.size()); ++ii) {
            envpArray.get()[ii] = const_cast<CHAR_PTR>(envp[ii].c_str());
        }
        envpArray.get()[ii] = nullptr;
        ExecCmdArgv execCmdArgv(argvArray.get(), static_cast<uint32_t>(argv.size() + reserveArgvLen),
            envpArray.get(), static_cast<uint32_t>(envp.size()));
        if (async) {
            ret = ExecCmdCAsync(execCmdArgv, execCmdParams, childProcess);
        } else {
            ret = ExecCmdC(execCmdArgv, execCmdParams, exitCodeP);
        }
    } while (0);
    return ret;
}

int32_t Utils::ChangeWorkDir(const std::string &fileName)
{
    if (fileName.empty()) {
        return PROFILING_FAILED;
    }
    // change work dir
    char *dName = nullptr;
    char *dirc = nullptr;
    dirc = MSVP_STRDUP(fileName.c_str());
    if (dirc == nullptr) {
        return PROFILING_FAILED;
    }
    dName = OsalDirName(dirc);
    if (dName == nullptr || OsalChdir(dName) != OSAL_EN_OK) {
        MSPROF_LOGW("Chdir(%s) did not complete successfully.", dirc);
    }
    if (dirc != nullptr) {
        free(dirc);
        dirc = nullptr;
    }
    return PROFILING_SUCCESS;
}

void Utils::SetArgEnv(CHAR_PTR_CONST argv[],
                      const int32_t argvCount,
                      CHAR_PTR_CONST envp[],
                      const int32_t envCount,
                      OsalArgvEnv &argvEnv)
{
    if (argv != nullptr && envp != nullptr) {
        (void)memset_s(&argvEnv, sizeof(OsalArgvEnv), 0, sizeof(OsalArgvEnv));

        argvEnv.argv = const_cast<CHAR_PTR_PTR>(argv);
        argvEnv.argvCount = argvCount;
        argvEnv.envp = const_cast<CHAR_PTR_PTR>(envp);
        argvEnv.envpCount = envCount;
    }
}

int32_t Utils::DoCreateCmdProcess(const std::string &stdoutRedirectFile,
                              const std::string &fileName,
                              const OsalArgvEnv &argvEnv,
                              OsalProcess &tid)
{
    int32_t ret = 0;
    if (stdoutRedirectFile.empty()) {
        ret = OsalCreateProcess(fileName.c_str(), &argvEnv, nullptr, &tid);
    } else {
        ret = OsalCreateProcess(fileName.c_str(), &argvEnv, stdoutRedirectFile.c_str(), &tid);
    }
    if (ret != OSAL_EN_OK) {
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t Utils::ExecCmdC(const ExecCmdArgv &execCmdArgv, const ExecCmdParams &execCmdParams, int32_t &exitCodeP)
{
    std::string filename = execCmdParams.cmd;
    CHAR_PTR_CONST *argv = execCmdArgv.argv;
    const int32_t argvCount = execCmdArgv.argvCount;
    CHAR_PTR_CONST *envp = execCmdArgv.envp;
    const int32_t envCount = execCmdArgv.envCount;
    std::string stdoutRedirectFile = execCmdParams.stdoutRedirectFile;
    constexpr int32_t invalidExitCode = -1;
    if (filename.empty() || argv == nullptr || envp == nullptr || exitCodeP == invalidExitCode) {
        return PROFILING_FAILED;
    }

    OsalArgvEnv argvEnv;
    OsalProcess tid = 0;
    SetArgEnv(argv, argvCount, envp, envCount, argvEnv);

    if (ChangeWorkDir(filename) == PROFILING_FAILED) {
        return PROFILING_FAILED;
    }
    int32_t ret = DoCreateCmdProcess(stdoutRedirectFile, filename, argvEnv, tid);
    if (ret == PROFILING_FAILED) {
        return PROFILING_FAILED;
    }

    bool exited = false;
    int32_t exitedCode = 0;
    ret = WaitProcess(tid, exited, exitedCode, true);
    if (ret == PROFILING_SUCCESS) {
        if (exitCodeP != invalidExitCode) {
            exitCodeP = exitedCode;
        }
    }

    return ret;
}

int32_t Utils::ExecCmdCAsync(const ExecCmdArgv &execCmdArgv, const ExecCmdParams &execCmdParams,
                         OsalProcess &childProcess)
{
    std::string filename = execCmdParams.cmd;
    CHAR_PTR_CONST *argv = execCmdArgv.argv;
    const int32_t argvCount = execCmdArgv.argvCount;
    CHAR_PTR_CONST *envp = execCmdArgv.envp;
    const int32_t envCount = execCmdArgv.envCount;
    std::string stdoutRedirectFile = execCmdParams.stdoutRedirectFile;

    if (filename.empty() || argv == nullptr || envp == nullptr) {
        return PROFILING_FAILED;
    }
    OsalProcess tid = 0;
    OsalArgvEnv argvEnv;
    SetArgEnv(argv, argvCount, envp, envCount, argvEnv);
    const int32_t ret = DoCreateCmdProcess(stdoutRedirectFile, filename, argvEnv, tid);
    if (ret == PROFILING_FAILED) {
        return PROFILING_FAILED;
    }
    childProcess = tid;

    return PROFILING_SUCCESS;
}

int32_t Utils::WaitProcess(OsalProcess process, bool &isExited, int32_t &exitCode, bool hang /* = true */)
{
    isExited = false;
    int32_t waitStatus = 0;
    uint32_t options = 0;
    uint32_t flags1 = OSAL_WAIT_NOHANG;
    if (!hang) {
        options |= flags1;
    }

    uint32_t flags2 = options & flags1;
    const int32_t ret = OsalWaitPid(process, &waitStatus, options);
    if (ret != OSAL_EN_INVALID_PARAM && ret != OSAL_EN_ERROR) {
        if ((flags2 != 0) && (ret == OSAL_EN_OK)) {
            return PROFILING_SUCCESS;
        }
        if (ret == OSAL_EN_ERR) {
            isExited = true;
            exitCode = waitStatus;
            return PROFILING_SUCCESS;
        }
    }
    return PROFILING_FAILED;
}

bool Utils::ProcessIsRuning(OsalProcess process)
{
    int32_t waitStatus = 0;

    int32_t ret = OsalWaitPid(process, &waitStatus, OSAL_WAIT_NOHANG);
    if (ret == OSAL_EN_OK) {
        return true;
    }
    return false;
}

std::string Utils::LeftTrim(const std::string &str, const std::string &trims)
{
    if (str.length() > 0) {
        size_t posStr = str.find_first_not_of(trims);
        if (posStr != std::string::npos) {
            return str.substr(posStr);
        } else {
            return "";
        }
    }

    return str;
}

std::string Utils::JoinPath(const std::vector<std::string> &paths)
{
    std::string path;

    for (size_t ii = 0; ii < paths.size(); ++ii) {
        if (ii == 0) {
            path = paths[ii];
        } else {
            path += MSVP_SLASH + paths[ii];
        }
    }

    return path;
}

std::string Utils::ToUpper(const std::string &value)
{
    std::string result = value;
    (void)std::transform (result.begin(), result.end(), result.begin(), static_cast<int32_t(*)(int32_t)>(std::toupper));
    return result;
}

std::string Utils::ToLower(const std::string &value)
{
    std::string result = value;
    (void)std::transform(result.begin(), result.end(), result.begin(), static_cast<int32_t(*)(int32_t)>(std::tolower));
    return result;
}

std::string Utils::Trim(const std::string &value)
{
    std::string result = value;
    const size_t pos = result.find_first_not_of(" ");
    if (pos == std::string::npos) {
        return "";
    }
    (void)result.erase(0, pos);
    (void)result.erase(result.find_last_not_of(" ") + 1);
    return result;
}

int32_t Utils::UsleepInterupt(unsigned long usec)
{
    // here we don't need accurate sleep time, so we don't check error code
    const int32_t changeFormUsToMs = 1000;
    (void)OsalSleep(static_cast<uint32_t>(usec / changeFormUsToMs));

    return PROFILING_SUCCESS;
}

void Utils::GetFiles(const std::string &dir, bool isRecur, std::vector<std::string> &files, uint32_t depth)
{
    if (dir.empty() || depth > MAX_FILE_DEPTH) {
        return;
    }

    OsalDirent **dirNameList = nullptr;
    int32_t count = OsalScandir(dir.c_str(), &dirNameList, nullptr, nullptr);
    if (count == OSAL_EN_ERROR || count == OSAL_EN_INVALID_PARAM) {
        return;
    }

    if (dirNameList == nullptr) {
        return;
    }

    for (int32_t j = 0; j < count; j++) {
        std::string fileName = dirNameList[j]->d_name;
        std::string childPath = dir + MSVP_SLASH + fileName;
        if (IsDir(childPath)) {
            if (!isRecur) {
                continue;
            }

            if ((fileName.compare(".") == 0) || (fileName.compare("..") == 0)) {
                continue;
            }

            GetFiles(childPath, isRecur, files, depth + 1);
        } else {
            files.push_back(childPath);
        }
    }

    OsalScandirFree(dirNameList, count);
}

void Utils::GetChildDirs(const std::string &dir, bool isRecur, std::vector<std::string> &childDirs, uint32_t depth)
{
    if (dir.empty() || depth > MAX_FILE_DEPTH) {
        return;
    }

    OsalDirent **nameList = nullptr;
    const int32_t count = OsalScandir(dir.c_str(), &nameList, nullptr, nullptr);
    if (count == OSAL_EN_ERROR || count == OSAL_EN_INVALID_PARAM) {
        return;
    }

    if (nameList == nullptr) {
        return;
    }

    for (int32_t i = 0; i < count; i++) {
        std::string fileName = nameList[i]->d_name;
        std::string childPath = dir + MSVP_SLASH + fileName;
        if (IsDir(childPath)) {
            if ((fileName.compare(".") == 0) || (fileName.compare("..") == 0)) {
                continue;
            }
            childDirs.push_back(childPath);
            if (!isRecur) {
                continue;
            }
            GetChildDirs(childPath, isRecur, childDirs, depth + 1);
        }
    }

    OsalScandirFree(nameList, count);
}

void Utils::GetChildFilenames(const std::string &dir, std::vector<std::string> &files)
{
    if (dir.empty()) {
        return;
    }
    OsalDirent **dirNameList = nullptr;
    int32_t count = OsalScandir(dir.c_str(), &dirNameList, nullptr, nullptr);
    if (count == OSAL_EN_INVALID_PARAM || count == OSAL_EN_ERROR) {
        return;
    }

    if (dirNameList == nullptr) {
        return;
    }

    for (int32_t j = 0; j < count; j++) {
        std::string fileName = dirNameList[j]->d_name;
        if ((fileName.compare(".") == 0) || (fileName.compare("..") == 0)) {
            continue;
        }
        files.push_back(fileName);
    }

    OsalScandirFree(dirNameList, count);
}

std::string Utils::TimestampToTime(const std::string &timestamp, int32_t unit /* = 1 */)
{
    if (timestamp.compare("") == 0 || timestamp.find_first_not_of("1234567890") != std::string::npos
        || unit == 0) {
        return "0";
    }
    time_t secTime;
    uint32_t microTime;
    try {
        secTime = std::stoll(timestamp) / unit;
        microTime = static_cast<uint32_t>(std::stoll(timestamp)) % static_cast<uint32_t>(unit);
    } catch (...) {
        return "0";
    }

    std::string timeString("0-0-0 0:0:0.0");
    struct tm ttime;
    (void)memset_s(&ttime, sizeof(tm), 0, sizeof(ttime));
#if (defined(linux) || defined(__linux__))
    if (localtime_r(&secTime, &ttime) == nullptr) {
        return timeString;
    }
#else
    if (localtime_s(&ttime, &secTime) != 0) {
        return timeString;
    }
#endif
    const int32_t timeLen = 32;
    char timeStr[timeLen] = { 0 };
    (void)strftime(timeStr, sizeof(timeStr), "%Y-%m-%d %H:%M:%S", &ttime);
    timeString = std::string(timeStr);

    (void)memset_s(timeStr, sizeof(timeStr), 0, sizeof(timeStr));
    if (sprintf_s(timeStr, sizeof(timeStr), "%06u", microTime) == PROFILING_FAILED) {
        return "0";
    }
    std::string tmp = timeStr;
    (void)timeString.append(".").append(tmp);

    return timeString;
}

std::string Utils::HandleEnvString(CONST_CHAR_PTR envPtr)
{
    if (envPtr == nullptr) {
        return "";
    }
    std::lock_guard<std::mutex> lock(g_envMtx);

    constexpr int32_t envValMaxLen = 1024 * 8 + 1; // 1024 * 8 : 8k
    char val[envValMaxLen] = { 0 };

    size_t lenOfPtr = strlen(envPtr);
    size_t envLen = 0;
    if (lenOfPtr < (OSAL_MEM_MAX_LEN - 1)) {
        envLen = lenOfPtr + 1U;
    }

    if ((envLen != 0) && (envValMaxLen < envLen)) {
        MSPROF_LOGW("The environment variable exceeds the maximum available length of %d.", envValMaxLen);
        return "";
    }
    errno_t err = memcpy_s(val, envValMaxLen, envPtr, envLen);
    if (err != EOK) {
        MSPROF_LOGE("Failed to copy the environment variable [%s], errno=%d.", envPtr, err);
        return "";
    }

    return std::string(val);
}

std::string Utils::RelativePathToAbsolutePath(const std::string &path)
{
    if (path.empty()) {
        return "";
    }

    if (path[0] != '/') {
        std::string absolutePath = GetCwdString() + MSVP_SLASH + path;
        return absolutePath;
    } else {
        return std::string(path);
    }
}

std::string Utils::GetCwdString(void)
{
    constexpr int32_t cwdValMaxLen = 1024 * 8; // 1024 * 8 : 8k
    char val[cwdValMaxLen + 1] = { 0 };
    (void)memset_s(val, cwdValMaxLen + 1, 0, cwdValMaxLen + 1);
    int32_t ret = OsalGetCwd(val, cwdValMaxLen);
    if (ret == OSAL_EN_OK) {
        return std::string(val);
    }
    return "";
}

bool Utils::CheckStringIsUnsignedIntNum(const std::string &numberStr)
{
    const std::string maxUintValStr = std::to_string(std::numeric_limits<uint32_t>::max());  // max uint32 string
    return CheckStringNumRange(numberStr, maxUintValStr);
}

bool Utils::CheckStringIsNonNegativeIntNum(const std::string &numberStr)
{
    const std::string maxIntValStr = std::to_string(std::numeric_limits<int32_t>::max());  // max int32 string
    return CheckStringNumRange(numberStr, maxIntValStr);
}

bool Utils::CheckStringNumRange(const std::string &numberStr, const std::string &target)
{
    if (numberStr.empty()) {
        return false;
    }

    if (numberStr.length() > target.length()) {  // over max int value
        MSPROF_LOGE("[Utils::CheckStringIsNonNegativeIntNum]numberStr(%s) is too long", numberStr.c_str());
        return false;
    }

    for (uint32_t i = 0; i < numberStr.length(); ++i) {
        if (numberStr[i] < '0' || numberStr[i] > '9') {  // numberStr must be pure number
            MSPROF_LOGE("[Utils::CheckStringIsNonNegativeIntNum]numberStr(%s) is not a positive integer",
                numberStr.c_str());
            return false;
        }
    }

    if (numberStr.length() == target.length()) {  // numberStr len equal max int val length
        for (uint32_t i = 0; i < numberStr.length(); ++i) {
            if (numberStr[i] > target[i]) {
                MSPROF_LOGE("[Utils::CheckStringIsNonNegativeIntNum]numberStr(%s) is over than %s",
                    numberStr.c_str(), target.c_str());
                return false;
            } else if (numberStr[i] == target[i]) {
                continue;
            } else {
                break;
            }
        }
    }
    return true;
}

std::string Utils::IdeGetHomedir()
{
    std::lock_guard<std::mutex> lock(g_envMtx);
#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
    std::string homedir;
#else
    struct passwd *pw = getpwuid(getuid());
    std::string homedir(pw != nullptr ? pw->pw_dir : "");
#endif
    if (!homedir.empty() && homedir[homedir.size() - 1] == '/' && homedir.size() > 1) {
        homedir.pop_back();
    }
    return homedir;
}

std::string Utils::IdeReplaceWaveWithHomedir(const std::string &path)
{
    if (path.size() < 2) { // 2 : path begin with ~/, so size >= 2
        return std::string(path);
    }

    if (path[0] == '~' && path[1] == '/') {
        std::string homedir = IdeGetHomedir();
        (void)homedir.append(path.substr(1));
        return homedir;
    } else {
        return std::string(path);
    }
}

void Utils::EnsureEndsInSlash(std::string& path)
{
#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
    char slash = '\\';
#else
    char slash = '/';
#endif
    if (!path.empty() && path[path.size() - 1] != slash) {
        path += slash;
    }
}

/**
 * @brief malloc memory and memset memory
 * @param size: the size of memory to malloc
 *
 * @return
 *        NULL: malloc memory failed
 *        not NULL: malloc memory succ
 */
void* Utils::ProfMalloc(size_t size)
{
    void *val = nullptr;
    errno_t err;

    if (size == 0) {
        return nullptr;
    }

    val = malloc(size);
    if (val == nullptr) {
        return nullptr;
    }

    err = memset_s(val, size, 0, size);
    if (err != EOK) {
        free(val);
        val = nullptr;
        return nullptr;
    }

    return val;
}

/**
 * @brief free memory
 * @param ptr: the memory to free
 * @return
 */
void Utils::ProfFree(VOID_PTR &ptr)
{
    if (ptr != nullptr) {
        free(ptr);
        ptr = nullptr;
    }
}

std::string Utils::GetCoresStr(const std::vector<int32_t> &cores, const std::string &separator)
{
    analysis::dvvp::common::utils::UtilsStringBuilder<int32_t> builder;
    return builder.Join(cores, separator);
}

std::string Utils::GetEventsStr(const std::vector<std::string> &events, const std::string &separator)
{
    analysis::dvvp::common::utils::UtilsStringBuilder<std::string> builder;
    return builder.Join(events, separator);
}

void Utils::PrintSysErrorMsg()
{
    char errBuf[MAX_ERR_STRING_LEN + 1] = {0};
    int32_t errorNo = OsalGetErrorCode();
    MSPROF_LOGE("ErrorCode:%d, errinfo:%s", errorNo, OsalGetErrorFormatMessage(errorNo, errBuf, MAX_ERR_STRING_LEN));
}

std::string Utils::GetSelfPath()
{
#if (defined(linux) || defined(__linux__))
    std::string selfPath = "/proc/self/exe";
    uint32_t pathSize = OSAL_MAX_PATH + 1;
    SHARED_PTR_ALIA<char> curPath;
    MSVP_MAKE_SHARED_ARRAY(curPath, char, pathSize, return "");
    int32_t len = static_cast<int32_t>(readlink(selfPath.c_str(), curPath.get(), OSAL_MAX_PATH));
    MSPROF_LOGI("Get self bin directory len: %d", len);
    if (len < 0) {
        selfPath = "/local/proc/self/exe";
        len = static_cast<int32_t>(readlink(selfPath.c_str(), curPath.get(), OSAL_MAX_PATH));
    }
    if (len < 0 || len > OSAL_MAX_PATH) {
        MSPROF_LOGW("Can't Get self bin directory");
        return "";
    }
    curPath.get()[len] = '\0';
    return std::string(curPath.get());
#else
    TCHAR path[MAX_PATH] = { 0 };
    GetModuleFileName(nullptr, path, MAX_PATH);
    std::string result;
#ifdef UNICODE
    int32_t iLen = WideCharToMultiByte(CP_ACP, 0, path, -1, nullptr, 0, nullptr, nullptr);
    if (iLen == 0) {
        MSPROF_LOGE("WideCharToMultiByte failed.");
        PrintSysErrorMsg();
        return result;
    }
    SHARED_PTR_ALIA<char> chRtn;
    MSVP_MAKE_SHARED_ARRAY(chRtn, char, iLen * sizeof(char), return "");
    WideCharToMultiByte(CP_ACP, 0, path, -1, chRtn.get(), iLen, nullptr, nullptr);
    result = chRtn.get();
#else
    result = path;
#endif
    MSPROF_LOGI("GetSelfPath is %s", BaseName(result).c_str());
    return result;
#endif
}

std::string Utils::CreateResultPath(const std::string &devId)
{
    std::string result;
    const int32_t deviceIdForHost = DEFAULT_HOST_ID;
    if (devId == std::to_string(deviceIdForHost)) {
        (void)result.append("host");
    } else {
        (void)result.append("device_").append(devId);
    }

    MSPROF_LOGI("[MSPROF][ProfStart] created task id %s of device %s", BaseName(result).c_str(), devId.c_str());

    return result;
}

/**
 * @brief create pid str which fill '0' to left side
 * @param [in] pid: pid string
 * @return: 0.. + pid str whose width is 8
 */
std::string Utils::CreatePidStr(const std::string &pid)
{
    if (pid.length() > MAX_PID_LENGTH) {
        MSPROF_LOGE("The length of input pid str is bigger than %d.", MAX_PID_LENGTH);
    }

    std::stringstream pidStream;
    (void)pidStream.fill('0');
    pidStream << std::setw(MAX_PID_LENGTH) << pid;
    return pidStream.str();
}

/**
 * @brief create PROF_XXX dir to store flush data
 * @param [in] index: number to count profiling start times in acl api
 * @return: PROF_taskId_timeStr_(hostPid + hashId)
 */
std::string Utils::CreateProfDir(uint64_t index, const std::string &title)
{
    std::stringstream randStr;
    const int32_t letterNum = 26; // A - Z
    int32_t randLen = 32; // 32 : the length of the rand str
    srand(static_cast<uint32_t>(time(nullptr)));
    randStr.str("");
    for (int32_t idx = 0; idx < randLen; idx++) {
        randStr << static_cast<char>('A' + rand() % letterNum);
    }
    auto timeSinceEpoch = std::chrono::steady_clock::now().time_since_epoch();
    size_t hashId = std::hash<std::string>()(
        randStr.str() +
        std::to_string(std::chrono::duration_cast<std::chrono::nanoseconds>(timeSinceEpoch).count()) +
        std::to_string(analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw()));
    randStr.str("");
    randLen = 8; // 8 : the lenght of the rand str
    const int32_t hashMod = 18; // change hashId to [A-R]
    for (int32_t idx = 0; idx < randLen; idx++) {
        randStr << static_cast<char>('A' + hashId % hashMod);
        hashId = hashId / hashMod;
    }
    return CreateProfDirSuffix(index, randStr.str(), title);
}

/**
 * @brief create PROF_XXX dir to store flush data in Helper
 * @param [in] index: number to count profiling start times in acl api
 * @param [in] helperPid: progress pid from helper device
 * @return: PROF_taskId_timeStr_(hostPid + devicePid)
 */
std::string Utils::CreateHelperDir(uint64_t index, const std::string &helperPid)
{
    std::string subPidStr = CreatePidStr(helperPid);
    return CreateProfDirSuffix(index, subPidStr, "PROF_");
}

/**
 * @brief create PROF_XXX dir with suffix to store flush data
 * @param [in] index: number to count profiling start times in acl api
 * @param [in] suffix: sub pid or rand hash str
 * @return: PROF_taskId_timeStr_(hostPid + devicePid)
 */
std::string Utils::CreateProfDirSuffix(uint64_t index, std::string suffix, const std::string &title)
{
    // add task id
    std::string result = title;
    std::stringstream taskId;
    (void)taskId.fill('0');
    const int32_t maxLen = 999999;
    const int32_t fillLen = 6;
    taskId << std::setw(fillLen) << ((index % maxLen) + 1);
    result += taskId.str() + "_";

    // add time
    OsalSystemTime sysTime;
    int32_t ret = OsalGetLocalTime(&sysTime);
    FUNRET_CHECK_EXPR_LOGW(ret == OSAL_EN_ERROR, "Unable to get local time.");

    const int32_t timeStrLen = 32;
    char timeStr[timeStrLen] = {0};
    ret = snprintf_s(timeStr, timeStrLen, timeStrLen - 1, "%04d%02d%02d%02d%02d%02d%03d", sysTime.wYear,
        sysTime.wMonth, sysTime.wDay, sysTime.wHour, sysTime.wMinute, sysTime.wSecond, sysTime.wMilliseconds);
    FUNRET_CHECK_EXPR_LOGW(ret == OSAL_EN_ERROR, "Unable to format time expressions.");
    result = result + timeStr + "_";

    // add main progress pid
    std::string mainPidStr = std::to_string(GetPid());
    result += CreatePidStr(mainPidStr);
    result += suffix;
    MSPROF_LOGI("Created output dir name %s", BaseName(result).c_str());
    return result;
}

std::string Utils::ProfCreateId(uint64_t addr)
{
    auto timeSinceEpoch = std::chrono::steady_clock::now().time_since_epoch();
    size_t hashId = std::hash<std::string>()(
        std::to_string(addr) +
        std::to_string(std::chrono::duration_cast<std::chrono::nanoseconds>(timeSinceEpoch).count()) +
        std::to_string(analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw()));
    std::stringstream jobStrSteam;
    jobStrSteam << "trace" << std::setw(PROF_MGR_TRACE_ID_DEFAULT_LEN) << std::setfill('0') << hashId;
    return jobStrSteam.str();
}

uint32_t Utils::GenerateSignature(CONST_UINT8_PTR data, uint64_t len)
{
    uint32_t signature = ~0U;

    if (data == nullptr) {
        return signature;
    }

    static const int32_t TABLE_SIZE = 256;
    static const uint32_t SIGNATURE_TABLE[TABLE_SIZE] = {
        0x00000000, 0xF26B8303, 0xE13B70F7, 0x1350F3F4, 0xC79A971F, 0x35F1141C, 0x26A1E7E8, 0xD4CA64EB,
        0x8AD958CF, 0x78B2DBCC, 0x6BE22838, 0x9989AB3B, 0x4D43CFD0, 0xBF284CD3, 0xAC78BF27, 0x5E133C24,
        0x105EC76F, 0xE235446C, 0xF165B798, 0x030E349B, 0xD7C45070, 0x25AFD373, 0x36FF2087, 0xC494A384,
        0x9A879FA0, 0x68EC1CA3, 0x7BBCEF57, 0x89D76C54, 0x5D1D08BF, 0xAF768BBC, 0xBC267848, 0x4E4DFB4B,
        0x20BD8EDE, 0xD2D60DDD, 0xC186FE29, 0x33ED7D2A, 0xE72719C1, 0x154C9AC2, 0x061C6936, 0xF477EA35,
        0xAA64D611, 0x580F5512, 0x4B5FA6E6, 0xB93425E5, 0x6DFE410E, 0x9F95C20D, 0x8CC531F9, 0x7EAEB2FA,
        0x30E349B1, 0xC288CAB2, 0xD1D83946, 0x23B3BA45, 0xF779DEAE, 0x05125DAD, 0x1642AE59, 0xE4292D5A,
        0xBA3A117E, 0x4851927D, 0x5B016189, 0xA96AE28A, 0x7DA08661, 0x8FCB0562, 0x9C9BF696, 0x6EF07595,
        0x417B1DBC, 0xB3109EBF, 0xA0406D4B, 0x522BEE48, 0x86E18AA3, 0x748A09A0, 0x67DAFA54, 0x95B17957,
        0xCBA24573, 0x39C9C670, 0x2A993584, 0xD8F2B687, 0x0C38D26C, 0xFE53516F, 0xED03A29B, 0x1F682198,
        0x5125DAD3, 0xA34E59D0, 0xB01EAA24, 0x42752927, 0x96BF4DCC, 0x64D4CECF, 0x77843D3B, 0x85EFBE38,
        0xDBFC821C, 0x2997011F, 0x3AC7F2EB, 0xC8AC71E8, 0x1C661503, 0xEE0D9600, 0xFD5D65F4, 0x0F36E6F7,
        0x61C69362, 0x93AD1061, 0x80FDE395, 0x72966096, 0xA65C047D, 0x5437877E, 0x4767748A, 0xB50CF789,
        0xEB1FCBAD, 0x197448AE, 0x0A24BB5A, 0xF84F3859, 0x2C855CB2, 0xDEEEDFB1, 0xCDBE2C45, 0x3FD5AF46,
        0x7198540D, 0x83F3D70E, 0x90A324FA, 0x62C8A7F9, 0xB602C312, 0x44694011, 0x5739B3E5, 0xA55230E6,
        0xFB410CC2, 0x092A8FC1, 0x1A7A7C35, 0xE811FF36, 0x3CDB9BDD, 0xCEB018DE, 0xDDE0EB2A, 0x2F8B6829,
        0x82F63B78, 0x709DB87B, 0x63CD4B8F, 0x91A6C88C, 0x456CAC67, 0xB7072F64, 0xA457DC90, 0x563C5F93,
        0x082F63B7, 0xFA44E0B4, 0xE9141340, 0x1B7F9043, 0xCFB5F4A8, 0x3DDE77AB, 0x2E8E845F, 0xDCE5075C,
        0x92A8FC17, 0x60C37F14, 0x73938CE0, 0x81F80FE3, 0x55326B08, 0xA759E80B, 0xB4091BFF, 0x466298FC,
        0x1871A4D8, 0xEA1A27DB, 0xF94AD42F, 0x0B21572C, 0xDFEB33C7, 0x2D80B0C4, 0x3ED04330, 0xCCBBC033,
        0xA24BB5A6, 0x502036A5, 0x4370C551, 0xB11B4652, 0x65D122B9, 0x97BAA1BA, 0x84EA524E, 0x7681D14D,
        0x2892ED69, 0xDAF96E6A, 0xC9A99D9E, 0x3BC21E9D, 0xEF087A76, 0x1D63F975, 0x0E330A81, 0xFC588982,
        0xB21572C9, 0x407EF1CA, 0x532E023E, 0xA145813D, 0x758FE5D6, 0x87E466D5, 0x94B49521, 0x66DF1622,
        0x38CC2A06, 0xCAA7A905, 0xD9F75AF1, 0x2B9CD9F2, 0xFF56BD19, 0x0D3D3E1A, 0x1E6DCDEE, 0xEC064EED,
        0xC38D26C4, 0x31E6A5C7, 0x22B65633, 0xD0DDD530, 0x0417B1DB, 0xF67C32D8, 0xE52CC12C, 0x1747422F,
        0x49547E0B, 0xBB3FFD08, 0xA86F0EFC, 0x5A048DFF, 0x8ECEE914, 0x7CA56A17, 0x6FF599E3, 0x9D9E1AE0,
        0xD3D3E1AB, 0x21B862A8, 0x32E8915C, 0xC083125F, 0x144976B4, 0xE622F5B7, 0xF5720643, 0x07198540,
        0x590AB964, 0xAB613A67, 0xB831C993, 0x4A5A4A90, 0x9E902E7B, 0x6CFBAD78, 0x7FAB5E8C, 0x8DC0DD8F,
        0xE330A81A, 0x115B2B19, 0x020BD8ED, 0xF0605BEE, 0x24AA3F05, 0xD6C1BC06, 0xC5914FF2, 0x37FACCF1,
        0x69E9F0D5, 0x9B8273D6, 0x88D28022, 0x7AB90321, 0xAE7367CA, 0x5C18E4C9, 0x4F48173D, 0xBD23943E,
        0xF36E6F75, 0x0105EC76, 0x12551F82, 0xE03E9C81, 0x34F4F86A, 0xC69F7B69, 0xD5CF889D, 0x27A40B9E,
        0x79B737BA, 0x8BDCB4B9, 0x988C474D, 0x6AE7C44E, 0xBE2DA0A5, 0x4C4623A6, 0x5F16D052, 0xAD7D5351
    };

    static const int32_t OFFSET = 8;
    while (len > 0) {
        signature = SIGNATURE_TABLE[(signature ^ *data++) & 0xff] ^ (signature >> OFFSET);
        len--;
    }
    return signature;
}

std::string Utils::ConvertIntToStr(const int32_t interval)
{
    std::stringstream result;
    result << std::setw(4) << std::setfill('0') << interval << std::endl; // 4 : Fill to 4 characters
    return Trim(result.str());
}

int32_t Utils::GetPid()
{
    return OsalGetPid();
}

void Utils::RemoveEndCharacter(std::string &input, const char end)
{
    if (input.empty() || input[input.size() - 1] != end) {
        return;
    }
    input.resize(input.size() - 1);
}

bool Utils::IsAppName(const std::string paramsName)
{
    std::string paramBaseName = BaseName(paramsName);
    std::string pythonName = "python";
    std::string pmuploadName = "pmupload";
    if (paramBaseName.compare("bash") == 0 || paramBaseName.compare("sh") == 0 ||
        paramBaseName.substr(0, pythonName.size()) == pythonName || paramBaseName == pmuploadName) {
        return false;
    }
    return true;
}

/**
 * @brief Check if dynamic mode
 * @return true  : find one of dynamic environment
           false : not find any dynamic environment
 */
bool Utils::IsDynProfMode()
{
    CONST_CHAR_PTR envChar = nullptr;
    std::string envStr;
#ifndef OSAL
    MM_SYS_GET_ENV(MM_ENV_PROFILING_MODE, envChar);
#endif
    envStr = HandleEnvString(envChar);
    return (envStr.compare(DYNAMIC_PROFILING_VALUE) == 0) || (envStr.compare(DELAY_DURARION_PROFILING_VALUE) == 0);
}

CHAR_PTR Utils::GetErrno()
{
    static const int32_t MAX_ERR_STR_LEN = 128;
    char errBuf[MAX_ERR_STR_LEN + 1] = {0};
    return OsalGetErrorFormatMessage(OsalGetErrorCode(), errBuf, MAX_ERR_STR_LEN);
}

int32_t Utils::DumpFile(const std::string &output, CONST_CHAR_PTR data, std::size_t length)
{
    int32_t fd = OsalOpen(output.c_str(), O_WRONLY | O_CREAT | O_APPEND, OSAL_IRUSR | OSAL_IWUSR);
    if (fd < 0) {
        MSPROF_LOGE("Failed to create or open binary file: %s, error info %s.",
            BaseName(output).c_str(), strerror(OsalGetErrorCode()));
        return PROFILING_FAILED;
    }
    (void)OsalClose(fd);
    std::ofstream file(output, std::ofstream::app | std::ios::binary);
    if (!file.is_open()) {
        MSPROF_LOGE("Failed to open %s, errinfo:%s", BaseName(output).c_str(), strerror(OsalGetErrorCode()));
        return PROFILING_FAILED;
    }
    file.write(data, length);
    file.flush();
    file.close();
    return PROFILING_SUCCESS;
}

int32_t WriteFile(const std::string &absolutePath, const std::string &recordFile, const std::string &profName)
{
#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
    return analysis::dvvp::common::error::PROFILING_SUCCESS;
#else
    FILE *file;

    if ((file = fopen(absolutePath.c_str(), "a")) == nullptr) {
        MSPROF_LOGE("Failed to open %s", recordFile.c_str());
        return analysis::dvvp::common::error::PROFILING_FAILED;
    }

    int32_t fd = fileno(file);
    if (fd < 0) {
        fclose(file);
        MSPROF_LOGE("Failed to get file description for %s", recordFile.c_str());
        return analysis::dvvp::common::error::PROFILING_FAILED;
    }

    if ((fwrite(profName.c_str(), FILE_WRITE_SIZE, profName.length(), file)) != profName.length()) {
        (void)fclose(file);
        MSPROF_LOGE("Failed to write prof dir");
        return analysis::dvvp::common::error::PROFILING_FAILED;
    }

    (void)fclose(file);
    return analysis::dvvp::common::error::PROFILING_SUCCESS;
#endif
}

std::string Utils::GetInfoSuffix(const std::string &fileName)
{
    const size_t pos = fileName.find_last_of(".");
    if (pos != std::string::npos) {
        return fileName.substr(pos + 1, fileName.length());
    }
    return "";
}

std::string Utils::GetInfoPrefix(const std::string &fileName)
{
    const size_t pos = fileName.find_last_of(".");
    if (pos != std::string::npos) {
        return fileName.substr(0, pos);
    }
    return "";
}

std::string Utils::PackDotInfo(const std::string &leftPattern, const std::string &rightPattern)
{
    return leftPattern + "." + rightPattern;
}

uint64_t Utils::GreenwichToMonotonic(uint64_t inputTime)
{
    // convert greenwichTime to chrono::system_clock::time_point
    auto greenwichTimePoint = std::chrono::system_clock::time_point(
        std::chrono::duration_cast<std::chrono::system_clock::duration>(
        std::chrono::duration<uint64_t>(inputTime)));
    // convert greenwichTimePoint to chrono::steady_clock::time_point
    auto monotonicTimePoint = std::chrono::time_point_cast<std::chrono::steady_clock::duration>(greenwichTimePoint);
    return std::chrono::duration_cast<std::chrono::microseconds>(monotonicTimePoint.time_since_epoch()).count();
}

/**
 * @brief Convert string to uint64_t
 * @return true
           false
 */
bool Utils::StrToUint64(uint64_t &out, const std::string &numStr)
{
    if (!IsAllDigit(numStr)) {
        MSPROF_LOGE("StrToUint64 failed, the input string is not digit.");
        return false;
    }
    size_t pos = 0;
    try {
        out = static_cast<uint64_t>(std::stoull(numStr, &pos));
    } catch (std::exception &ex) {
        MSPROF_LOGE("StrToUint64 failed, the input string is '%s', message: %s.", numStr.c_str(), ex.what());
        return false;
    }
    return true;
}

/**
 * @brief Convert string to uint32_t
 * @return true
           false
 */
bool Utils::StrToUint32(uint32_t &out, const std::string &numStr)
{
    if (!IsAllDigit(numStr)) {
        MSPROF_LOGE("StrToUint32 failed, the input string is not digit.");
        return false;
    }
    size_t pos = 0;
    try {
        out = static_cast<uint32_t>(std::stoul(numStr, &pos));
    } catch (std::exception &ex) {
        MSPROF_LOGE("StrToUint32 failed, the input string is '%s', message: %s.",
            numStr.c_str(), ex.what());
        return false;
    }
    return true;
}

/**
 * @brief Convert string to int32_t
 * @return true
           false
 */
bool Utils::StrToInt32(int32_t &out, const std::string &numStr)
{
    if (numStr.empty()) {
        MSPROF_LOGE("StrToInt32 failed, the input string is empty.");
        return false;
    }
    size_t pos = 0;
    try {
        out = static_cast<int32_t>(std::stoi(numStr, &pos));
    } catch (std::exception &ex) {
        MSPROF_LOGE("StrToInt32 failed, the input string is '%s', message: %s.",
            numStr.c_str(), ex.what());
        return false;
    }
    if (pos != numStr.size()) {
        MSPROF_LOGE("StrToInt32 failed, the input string is '%s'.", numStr.c_str());
        return false;
    }
    return true;
}

/**
 * @brief Convert string to double
 * @return true
           false
 */
bool Utils::StrToDouble(double &out, const std::string &numStr)
{
    if (numStr.empty()) {
        MSPROF_LOGE("StrToDouble failed, the input string is empty.");
        return false;
    }
    size_t pos = 0;
    try {
        out = std::stod(numStr, &pos);
    } catch (std::exception &ex) {
        MSPROF_LOGE("StrToDouble failed, the input string is '%s', message: %s.",
            numStr.c_str(), ex.what());
        return false;
    }
    if (pos != numStr.size()) {
        MSPROF_LOGE("StrToDouble failed, the input string is '%s'.", numStr.c_str());
        return false;
    }
    return true;
}

/**
 * @brief check the length of argc and argv inputted
 *  @return true
           false
 */
bool Utils::CheckInputArgsLength(int32_t argc, CONST_CHAR_PTR argv[])
{
    static const int32_t INPUT_MAX_LEN = 512; // 512 : max length
    if (argc > INPUT_MAX_LEN || argv == nullptr || strlen(*argv) > INPUT_MAX_LEN) {
        CmdLog::CmdErrorLog("input data is invalid,"
            "please input argc less than 512 and argv is not null and the len of argv less than 512");
        return false;
    }
    return true;
}

/**
 * @brief check the binary is exist and executable
 *  @return true
           false
 */
bool Utils::CheckBinValid(const std::string &binPath)
{
    if (Utils::CanonicalizePath(binPath).empty()) {
        CmdLog::CmdErrorLog("The file %s does not exist or permission denied.", binPath.c_str());
        return false;
    }
    if (Utils::IsSoftLink(binPath)) {
        CmdLog::CmdErrorLog("The file %s is soft link, not support!", binPath.c_str());
        return false;
    }
    if (Utils::IsDir(binPath)) {
        CmdLog::CmdErrorLog("The file %s is a directory, "
            "please enter the executable file path.", Utils::CanonicalizePath(binPath).c_str());
        return false;
    }
    if (OsalAccess2(binPath.c_str(), OSAL_X_OK) != OSAL_EN_OK) {
        CmdLog::CmdErrorLog("The file %s has no executable permission.", Utils::CanonicalizePath(binPath).c_str());
        return false;
    }
    return true;
}

std::string Utils::GetHostTime()
{
    std::string hostTime;
    OsalTimeval tv;

    (void)memset_s(&tv, sizeof(tv), 0, sizeof(tv));
    if (OsalGetTimeOfDay(&tv, nullptr) != OSAL_EN_OK) {
        MSPROF_LOGE("[GetHostTime]Failed to get time of day.");
    } else {
        const int32_t timeUs = 1000000;
        hostTime = std::to_string(static_cast<uint64_t>(tv.tv_sec) * timeUs + static_cast<uint64_t>(tv.tv_usec));
    }
    return hostTime;
}

void Utils::GenTimeLineJsonFile(std::string path, const std::string &strData)
{
    // create file and open ofstream
    int32_t fd = OsalOpen(path.c_str(), O_WRONLY | O_CREAT | O_APPEND, OSAL_IRUSR | OSAL_IWUSR);
    if (fd < 0) {
        MSPROF_LOGE("Failed to create or open timeline json file: %s.", path.c_str());
        return;
    }
    (void)OsalClose(fd);
    path = Utils::CanonicalizePath(path);
    FUNRET_CHECK_EXPR_ACTION(path.empty(), return, 
        "The fileName path: %s does not exist or permission denied.", path.c_str());
    std::ofstream jsonFile(path, std::ios::out | std::ios::app);
    if (!jsonFile.is_open()) {
        MSPROF_LOGE("Failed to open timeline json file: %s.", path.c_str());
        return;
    }
    // The beginning and end must be embraced by [].
    jsonFile << "[";
    jsonFile << strData;
    jsonFile << "]";

    jsonFile.close();
}

bool Utils::CheckDuplicateStrings(const std::string &oriStr, const std::string &subStr)
{
    if (subStr.empty()) {
        return false;
    }
    int32_t count = 0;
    size_t pos = 0;
    while ((pos = oriStr.find(subStr, pos)) != std::string::npos) {
        count++;
        pos += subStr.length();
    }
    if (count > 1) {
        return false;
    }
    return true;
}
}  // namespace utils
}  // namespace common
}  // namespace dvvp
}  // namespace analysis
