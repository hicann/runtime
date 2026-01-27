/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "inc/process_util_common.h"
#include <fstream>
#include <vector>
#ifdef TSD_HOST_LIB
#include <openssl/sha.h>
#endif
#include <fstream>
#include <sstream>
#include <iomanip>

namespace {
    const std::vector<std::string> BLACK_ENV_LIST = {
        "LD_PRELOAD",
        "LD_LIBRARY_PATH",
        "PATH"
    };
    constexpr const int32_t HX_PRINT_POS = 2;
    constexpr uint32_t SUB_PROC_HASH_INFO_MAX_LEN = 100U;
}
namespace tsd {
TSD_StatusT ProcessUtilCommon::ReadCurMemCtrolType(const std::string &path, std::string &memCtrolType)
{
    std::ifstream fs;
    fs.open(path);
    if (!fs.is_open()) {
        return static_cast<uint32_t>(TSD_INTERNAL_ERROR);
    }
    (void)getline(fs, memCtrolType);
    if (memCtrolType.empty()) {
        fs.close();
        return static_cast<uint32_t>(TSD_INTERNAL_ERROR);
    }
    fs.close();
    return TSD_OK;
}

TSD_StatusT ProcessUtilCommon::SetThreadAffinity(const pthread_t &threadId, const std::vector<uint32_t> &cpuIds)
{
    // 可能包含获取不到ctrlcpu的情况
    if (cpuIds.size() == 0U) {
        return TSD_OK;
    }
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    for (const uint32_t cpuId: cpuIds) {
        CPU_SET(cpuId, &cpuset);
        TSD_RUN_INFO("prepare bind threadId=%lu to cpuId=%u", threadId, cpuId);
    }
    TSD_RUN_INFO("begin call pthread_setaffinity_np threadId=%lu", threadId);
    // 设置线程亲和性
    int32_t ret = pthread_setaffinity_np(threadId, sizeof(cpu_set_t), &cpuset);
    if (ret != 0) {
        TSD_ERROR("BindCpu threadId=%lu set affinity failed, ret=%d", threadId, ret);
        return static_cast<uint32_t>(TSD_INTERNAL_ERROR);
    }
    // 检查线程实际亲和性
    ret = pthread_getaffinity_np(threadId, sizeof(cpu_set_t), &cpuset);
    if (ret != 0) {
        TSD_ERROR("BindCpu threadId=%lu get affinity failed, ret=%d", threadId, ret);
        return static_cast<uint32_t>(TSD_INTERNAL_ERROR);
    }
    for (int32_t cpuId = 0; cpuId < CPU_SETSIZE; cpuId++) {
        if (CPU_ISSET(cpuId, &cpuset) != 0) {
            TSD_INFO("BindCpu threadId=%lu to cpuId=%d success", threadId, static_cast<int32_t>(cpuId));
        }
    }
    return TSD_OK;
}

TSD_StatusT ProcessUtilCommon::SaveThreadAffinity(pthread_t &threadId, cpu_set_t * const cpusetSaved)
{
    // 保存当前线程亲和性,失败时，仅记录日志，不退出
    const int32_t ret = pthread_getaffinity_np(threadId, sizeof(cpu_set_t), cpusetSaved);
    if (ret != 0) {
        TSD_ERROR("BindCpu threadId=%lu get affinity failed, ret=%d", threadId, ret);
        return static_cast<uint32_t>(TSD_BIND_CPUCORE_FAILED);
    }
    return TSD_OK;
}

TSD_StatusT ProcessUtilCommon::RestoreThreadAffinity(pthread_t &threadId, const cpu_set_t * const cpusetSaved)
{
    const int32_t ret = pthread_setaffinity_np(threadId, sizeof(cpu_set_t), cpusetSaved);
    if (ret != 0) {
        TSD_ERROR("BindCpu threadId=%lu set affinity failed, ret=%d", threadId, ret);
        return static_cast<uint32_t>(TSD_BIND_CPUCORE_FAILED);
    }
    return TSD_OK;
}

TSD_StatusT ProcessUtilCommon::GetCurHomePath(std::string &curHomePath)
{
    std::string pathEnv;
    GetScheduleEnv("HOME", pathEnv);
    if (pathEnv.empty()) {
        TSD_ERROR("Env HOME is invalid");
        return TSD_INTERNAL_ERROR;
    }
    if (!CheckValidatePath(pathEnv)) {
        TSD_ERROR("Env HOME[%s] is not correct", pathEnv.c_str());
        return TSD_INTERNAL_ERROR;
    }
    if (!CheckRealPath(pathEnv)) {
        TSD_ERROR("Env HOME[%s] is not realpath", pathEnv.c_str());
        return TSD_INTERNAL_ERROR;
    }
    curHomePath = pathEnv;
    TSD_RUN_INFO("home path:%s", curHomePath.c_str());
    return TSD_OK;
}

bool ProcessUtilCommon::IsInBlackEnvList(const std::string &curEnv)
{
    for (const auto &iter : BLACK_ENV_LIST) {
        if (curEnv == iter) {
            return true;
        }
    }
    return false;
}
#ifdef TSD_HOST_LIB
std::string ProcessUtilCommon::CalFileSha256HashValue(const std::string &filePath)
{
    std::ifstream curFile(filePath, std::ios::binary);
    if (!curFile) {
        TSD_RUN_WARN("open file:%s not success, reason:%s", filePath.c_str(), SafeStrerror().c_str());
        return "";
    }

    std::stringstream fileBuffer;
    fileBuffer << curFile.rdbuf();
    std::string fileBinaryValue = fileBuffer.str();
    unsigned char hashValue[SHA256_DIGEST_LENGTH];
#ifndef tsd_UT
    SHA256(PtrToPtr<const char, const unsigned char>(fileBinaryValue.c_str()), fileBinaryValue.size(), hashValue);
#endif
    std::stringstream sha256Str;
    sha256Str << std::hex << std::setfill('0');
    for (auto i = 0; i < SHA256_DIGEST_LENGTH; i++) {
        sha256Str << std::setw(HX_PRINT_POS) << static_cast<int32_t>(hashValue[i]);
    }
    curFile.close();
    return sha256Str.str();
}
#else
std::string ProcessUtilCommon::CalFileSha256HashValue(const std::string &filePath)
{
    std::string queryHash = "";
    const std::string cmd = "sha256sum " + filePath;
    FILE *pip = popen(cmd.c_str(), "r");
    if (pip == nullptr) {
        TSD_RUN_INFO("Popen execute cmd [%s], returned nullptr", cmd.c_str());
        return queryHash;
    }

    const ScopeGuard popenGuarad([&pip]() {
        const auto ret = pclose(pip);
        if (ret == -1) {
            TSD_WARN("Pclose failed");
        }
    });

    std::array<char_t, SUB_PROC_HASH_INFO_MAX_LEN> buffer;
    while (fgets(buffer.data(), static_cast<int32_t>(SUB_PROC_HASH_INFO_MAX_LEN), pip) != nullptr) {
        queryHash += buffer.data();
    }
    std::string result;
    if (!queryHash.empty()) {
        auto pos = queryHash.find(" ");
        if ((pos != std::string::npos) && (pos != queryHash.size() - 1)) {
            result = queryHash.substr(0, pos);
        }
    }
    
    TSD_INFO("get query hash:%s, result:%s, len:%d", queryHash.c_str(), result.c_str(), HX_PRINT_POS);
    return result;
}
#endif
}  // namespace tsd