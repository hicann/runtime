/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <elf.h>
#include <functional>
#include <fstream>
#include <mutex>
#include <memory>
#include <string>
#include <stack>
#include <thread>
#include <dirent.h>
#include <sys/stat.h>
#include "path.h"
#include "file.h"
#include "sys_utils.h"
#include "str_utils.h"
#include "log/adx_log.h"
#include "log/hdc_log.h"
#include "extra_config.h"
#include "thread_manager.h"
#include "adump_dsmi.h"
#include "runtime/base.h"
#include "exception_info_common.h"
#include "kernel_symbol_locator.h"
#include "kernel_info_collector.h"

namespace Adx {
namespace {
const std::set<char> INVALID_FILE_NAME_CHAR = {' ', '.', '/', '\\'};
constexpr uint64_t JSON_SUFFIX_LEN = 5;  // length of ".json"
}  // namespace

int32_t StartCollectKernelAsync(std::shared_ptr<KernelInfoCollector> collector, const std::string &dumpPath) {
    int32_t ret = collector->LoadKernelBinBuffer();
    // 先同步落 _host.o（纯内存 buffer 写，快），再把慢的 kernel_meta 搜索丢到异步线程。
    (void)collector->DumpHostKernelBin(dumpPath);
    IDE_LOGD("Start collecting kernel file.");
    std::thread collectKernel([collector, dumpPath](){
        int32_t tid = mmGetTid();
        ThreadManager::Instance().TaskAdd(tid);
        (void)collector->StartCollectKernel(dumpPath);
        ThreadManager::Instance().TaskDone(tid);
    });
    collectKernel.detach();
    return ret;
}

void KernelInfoCollector::LoadKernelInfo(const rtExceptionArgsInfo &argsInfo)
{
    kernelBinHandle_ = nullptr;
    kernelBinData_.clear();
    kernelBinSize_ = 0;
    kernelName_.clear();

    kernelBinHandle_ = argsInfo.exceptionKernelInfo.bin;  // binHandle
    kernelBinSize_ = argsInfo.exceptionKernelInfo.binSize;
    if ((argsInfo.exceptionKernelInfo.kernelName != nullptr) && (argsInfo.exceptionKernelInfo.kernelNameSize != 0)) {
        kernelName_ = std::string(argsInfo.exceptionKernelInfo.kernelName, argsInfo.exceptionKernelInfo.kernelNameSize);
    }
    IDE_LOGI("Kernel handle: %p, kernel size: %u, name addr: %p, name size: %u, kernel name: %s", kernelBinHandle_,
             kernelBinSize_, argsInfo.exceptionKernelInfo.kernelName, argsInfo.exceptionKernelInfo.kernelNameSize,
             kernelName_.c_str());
}

int32_t KernelInfoCollector::InitFromBinHandle(rtBinHandle BinHandle, const std::string &kernelName)
{
    kernelBinHandle_ = BinHandle;
    kernelName_ = kernelName;

    return LoadKernelBinBuffer();
}

int32_t KernelInfoCollector::LoadKernelBinBuffer()
{
    if (kernelBinHandle_ == nullptr) {
        return ADUMP_SUCCESS;
    }
    std::string binData;
    uint32_t binSize = 0;
    int32_t ret = ExceptionInfoCommon::GetBinDataFromHandle(kernelBinHandle_, binData, binSize);
    if (ret != ADUMP_SUCCESS) {
        kernelBinData_ = "";
        return ADUMP_FAILED;
    }
    kernelBinSize_ = binSize;
    kernelBinData_ = binData;
    return ADUMP_SUCCESS;
}

std::string KernelInfoCollector::GetProcessedKernelName() const
{
    return ExceptionInfoCommon::GetKernelNameWithoutMixSuffix(kernelName_);
}

int32_t KernelInfoCollector::StartCollectKernel(const std::string &dumpPath) const
{
    if (kernelName_.empty() || kernelBinHandle_ == nullptr || kernelBinSize_ == 0) {
        IDE_LOGI("Kernel name or kernel bin is empty, skip dump kernel.");
        return ADUMP_SUCCESS;
    }

    std::string kernelName = GetProcessedKernelName();

    // _host.o 已由调用方通过 DumpHostKernelBin 单独同步落盘，这里只做慢的 kernel_meta 搜索拷贝。
    int32_t ret = ADUMP_SUCCESS;
    if (CollectKernelFile(kernelName, dumpPath) != ADUMP_SUCCESS) {
        IDE_LOGE("Collect kernel file failed.");
        ret = ADUMP_FAILED;
    }
    return ret;
}

bool KernelInfoCollector::ContainsString(const std::string &filePath, const std::string &targetString) const
{
    Path jsonFilePath(filePath);
    if (!jsonFilePath.RealPath()) {
        IDE_LOGD("The json file path[%s] is invalid, please check the path.", jsonFilePath.GetCString());
        return false;
    }

    std::ifstream file(jsonFilePath.GetString());
    if (!file.is_open()) {
        IDE_LOGD("The json file path[%s] open failed, please check the permission.", jsonFilePath.GetCString());
        return false;
    }
    std::string line;
    while (std::getline(file, line)) {
        if (line.find(targetString) == std::string::npos) {
            continue;
        }
        if (IsTargetLine(line, "kernelName", targetString)) {
            file.close();
            return true;
        }
    }
    file.close();
    return false;
}

bool KernelInfoCollector::IsTargetLine(const std::string &currentLine, const std::string &key,
                                       const std::string &value) const
{
    size_t curPlace = 0;
    if (GetFirstItem(currentLine, curPlace) != key) {
        return false;
    }
    if (GetFirstItem(currentLine, curPlace) != value) {
        return false;
    }
    return true;
}

std::string KernelInfoCollector::GetFirstItem(const std::string &curLine, size_t &curPlace) const
{
    size_t head = curLine.find_first_of('"', curPlace);
    if (head == std::string::npos) {
        return "";
    }
    size_t end = curLine.find_first_of('"', head + 1);
    if (end == std::string::npos) {
        return "";
    }
    curPlace = end + 1;
    return StrUtils::Trim(curLine.substr(head + 1, end - head - 1));
}

std::string KernelInfoCollector::SearchJsonFiles(const std::string &rootPath, const std::string &targetString) const
{
    std::stack<std::string> directories;
    directories.push(rootPath);

    while (!directories.empty()) {
        std::string currentDir = directories.top();
        directories.pop();

        DIR *dir = opendir(currentDir.c_str());
        if (!dir) {
            IDE_LOGW("Unable to open directory[%s].", currentDir.c_str());
            continue;
        }

        struct dirent *entry;
        while ((entry = readdir(dir)) != nullptr) {
            std::string name = entry->d_name;
            if (name == "." || name == ".." ||
                ((currentDir == "./") && (name.find("kernel_meta") == std::string::npos))) {
                continue;
            }

            std::string fullPath = currentDir + "/" + name;
            struct stat fileStat;
            if (stat(fullPath.c_str(), &fileStat) == -1) {
                IDE_LOGD("Unable to stat file[%s].", fullPath.c_str());
                continue;
            }

            if (S_ISDIR(fileStat.st_mode)) {
                directories.push(fullPath);
                continue;
            }
            if (!S_ISREG(fileStat.st_mode) || name.size() <= JSON_SUFFIX_LEN ||
                name.substr(name.size() - JSON_SUFFIX_LEN) != ".json") {
                continue;
            }

            // If the file is a JSON file, check whether the file contains the target character string.
            if (ContainsString(fullPath, targetString)) {
                (void)closedir(dir);
                return fullPath;
            }
        }

        (void)closedir(dir);
    }

    IDE_LOGI("Can not find kernel file in %s, targetString: %s", rootPath.c_str(), targetString.c_str());
    return "";
}

/**
 * @brief       : dump the kernel bin file runtime load from host
 * @param [in]  : dumpPath      path of the exception dump file
 * @return      : ADUMP_SUCCESS succeed; ADUMP_FAILED failed
 * @note        : 从 StartCollectKernel 拆出，供调用方在慢搜索/修正 PC 之前单独同步落 _host.o。
 */
int32_t KernelInfoCollector::DumpHostKernelBin(const std::string &dumpPath) const
{
    // 与拆分前 StartCollectKernel 入口保持一致的前置校验：kernelName 为空会退化成非唯一的 "_host.o"，
    // 不同异常/算子会互相覆盖并污染幂等判断，故此处直接跳过。
    if (kernelName_.empty() || kernelBinHandle_ == nullptr || kernelBinSize_ == 0) {
        IDE_LOGI("Kernel name or kernel bin is empty, skip dump host kernel bin.");
        return ADUMP_SUCCESS;
    }
    if (kernelBinData_.empty()) {
        IDE_LOGE("Kernel bin data is empty.");
        return ADUMP_FAILED;
    }
    std::string kernelName = GetProcessedKernelName();
    Path hostKernelBinPath(dumpPath);
    std::string hostKernelBinName = StrUtils::Replace(kernelName, INVALID_FILE_NAME_CHAR, '_') + "_host.o";
    hostKernelBinPath.Concat(hostKernelBinName);
    // 幂等:_host.o 可能已由调用方在符号化前提前同步落盘。仅当磁盘上文件大小与待写入一致时才跳过，
    // 避免上次部分写(如磁盘满)残留的截断/空文件被 Exist() 误判为已完成而永久跳过重写。
    struct stat hostBinStat;
    if (hostKernelBinPath.Exist() && stat(hostKernelBinPath.GetCString(), &hostBinStat) == 0 &&
        static_cast<uint64_t>(hostBinStat.st_size) == static_cast<uint64_t>(kernelBinSize_)) {
        IDE_LOGI("[Dump][Exception] host kernel bin already dumped, skip. file: %s", hostKernelBinPath.GetCString());
        return ADUMP_SUCCESS;
    }
    File hostKernelBinFile(hostKernelBinPath.GetString(), M_WRONLY | M_CREAT | M_TRUNC);
    int32_t ret = hostKernelBinFile.IsFileOpen();
    if (ret != ADUMP_SUCCESS) {
        IDE_LOGE("Open host kernel bin file[%s] failed.", hostKernelBinPath.GetCString());
        return ADUMP_FAILED;
    }
    static std::mutex KernelBinLock;
    std::lock_guard<std::mutex> lock(KernelBinLock);
    auto writeSize = hostKernelBinFile.Write(kernelBinData_.c_str(), static_cast<int64_t>(kernelBinSize_));
    if (writeSize < 0) {
        // 不清理残留文件(与拆分前行为一致):M_TRUNC 已把文件截为 0,失败后盘上会留下空/截断的 _host.o。
        // 下次调用因大小不匹配会重写,不会误判为完整;但符号化阶段若在此期间读取会拿到残缺文件,故打印告警提醒。
        IDE_LOGE("Write host kernel bin file[%s] failed, an incomplete _host.o may remain on disk.",
            hostKernelBinPath.GetCString());
        return ADUMP_FAILED;
    }
    // File::Write 内部循环处理短写、返回的是最后一次 mmWrite 的长度而非累计值，不能用它判完整性；
    // 改为写后 stat 校验最终文件大小,截断/短写(如磁盘满)时文件大小不足即判失败,避免残留截断文件被幂等误判为完整。
    if (stat(hostKernelBinPath.GetCString(), &hostBinStat) != 0 ||
        static_cast<uint64_t>(hostBinStat.st_size) != static_cast<uint64_t>(kernelBinSize_)) {
        // 同上:残留的截断文件不主动删除,靠下次大小校验重写;此处打印告警提醒盘上存在不完整的 _host.o。
        IDE_LOGE("Write host kernel bin file[%s] incomplete, fileSize=%lld, expect=%u, "
            "an incomplete _host.o may remain on disk.",
            hostKernelBinPath.GetCString(), static_cast<long long>(hostBinStat.st_size), kernelBinSize_);
        return ADUMP_FAILED;
    }
    IDE_LOGE("[Dump][Exception] dump host kernel to file, file: %s", hostKernelBinPath.GetCString());
    (void)mmChmod(hostKernelBinPath.GetCString(), M_IRUSR);  // 安全要求,落盘文件置为最小权限:用户只读, 400

    return ADUMP_SUCCESS;
}

std::vector<std::string> KernelInfoCollector::SplitString(const std::string &str, char delimiter) const
{
    std::vector<std::string> result;
    std::stringstream ss(str);
    std::string item;

    while (std::getline(ss, item, delimiter)) {
        result.push_back(item);
    }

    return result;
}

/*
    按照指定的路径优先级来进行.o和.json文件搜索
*/
std::vector<std::string> KernelInfoCollector::GetSearchPath() const
{
    std::string envStr;
    std::vector<std::string> searchPath;

    ADX_GET_ENV(MM_ENV_ASCEND_CACHE_PATH, envStr);
    if (!envStr.empty()) {
        searchPath.emplace_back(envStr);
        IDE_LOGI("Add ASCEND_CACHE_PATH[%s] to search path.", envStr.c_str());
    }

    ADX_GET_ENV(MM_ENV_HOME, envStr);
    if (!envStr.empty()) {
        envStr += "/atc_data";
        searchPath.emplace_back(envStr);
        IDE_LOGI("Add HOME[%s] to search path.", envStr.c_str());
    }
    
    // custom install path
    ADX_GET_ENV(MM_ENV_ASCEND_CUSTOM_OPP_PATH, envStr);
    if (!envStr.empty()) {
        std::vector<std::string> customPaths = SplitString(envStr, ':');
        for (const auto &customPath : customPaths) {
            searchPath.emplace_back(customPath);
            IDE_LOGI("Add ASCEND_CUSTOM_OPP_PATH[%s] to search path.", customPath.c_str());
        }
    }

    ADX_GET_ENV(MM_ENV_ASCEND_OPP_PATH, envStr);
    if (!envStr.empty()) {
        std::string vendorsPath = envStr + "/vendors";
        searchPath.emplace_back(vendorsPath);
        IDE_LOGI("Add ASCEND_OPP_PATH[%s] to search path.", vendorsPath.c_str());

        std::string buildInPath = envStr + "/built-in";
        searchPath.emplace_back(buildInPath);
        IDE_LOGI("Add ASCEND_OPP_PATH[%s] to search path.", buildInPath.c_str());
    }

    // kernel meta generate in current path
    searchPath.emplace_back("./");
    IDE_LOGI("Add current path[./] to search path.");

    ADX_GET_ENV(MM_ENV_ASCEND_WORK_PATH, envStr);
    if (!envStr.empty()) {
        envStr += "/kernel_meta";
        searchPath.emplace_back(envStr);
    }
    IDE_LOGI("Add current path[%s] to search path.", envStr.c_str());

    return searchPath;
}

int32_t KernelInfoCollector::CollectKernelFile(const std::string &kernelName, const std::string &dumpPath) const
{
    std::vector<std::string> searchPath = GetSearchPath();

    bool failFlag = false;
    for (const auto &path : searchPath) {
        std::string jsonFilePath = SearchJsonFiles(path, kernelName);
        if (jsonFilePath.empty()) {
            continue;
        }

        Path jsonPath(jsonFilePath);
        Path dumpJsonPath(dumpPath);
        dumpJsonPath.Concat(jsonPath.GetFileName());
        static std::mutex KernelfileLock;
        std::lock_guard<std::mutex> lock(KernelfileLock);
        if (File::Copy(jsonFilePath, dumpJsonPath.GetString()) != ADUMP_SUCCESS) {
            IDE_LOGE("Copy kernel file[%s] to dump path[%s] failed.", jsonFilePath.c_str(), dumpJsonPath.GetCString());
            failFlag = true;
        } else {
            IDE_LOGE("[Dump][Exception] dump kernel json to file, file: %s", dumpJsonPath.GetCString());
            (void)mmChmod(dumpJsonPath.GetCString(), M_IRUSR);  // 安全要求,落盘文件置为最小权限:用户只读, 400
        }

        std::string kernelBinPath = jsonFilePath.substr(0, jsonFilePath.size() - JSON_SUFFIX_LEN) + ".o";
        Path kernelPath(kernelBinPath);
        Path dumpKernelPath(dumpPath);
        dumpKernelPath.Concat(kernelPath.GetFileName());
        if (File::Copy(kernelBinPath, dumpKernelPath.GetString()) != ADUMP_SUCCESS) {
            IDE_LOGE("Copy kernel file[%s] to dump path[%s] failed.", kernelBinPath.c_str(),
                     dumpKernelPath.GetCString());
            failFlag = true;
        } else {
            IDE_LOGE("[Dump][Exception] dump kernel to file, file: %s", dumpKernelPath.GetCString());
            (void)mmChmod(dumpKernelPath.GetCString(), M_IRUSR);  // 安全要求,落盘文件置为最小权限:用户只读, 400
        }
        break;
    }
    if (failFlag) {
        return ADUMP_FAILED;
    }

    return ADUMP_SUCCESS;
}

}  // namespace Adx
