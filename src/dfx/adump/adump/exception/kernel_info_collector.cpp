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
#include "kernel_info_collector.h"

namespace Adx {
namespace {
const std::set<char> INVALID_FILE_NAME_CHAR = {' ', '.', '/', '\\'};
constexpr uint64_t JSON_SUFFIX_LEN = 5;  // length of ".json"
constexpr uint32_t ELF_STT_TYPE = 0xF;
constexpr uint32_t ELF_STB_BIND = 4;
}  // namespace

int32_t StartCollectKernelAsync(std::shared_ptr<KernelInfoCollector> collector, const std::string &dumpPath) {
    int32_t ret = collector->LoadKernelBinBuffer();
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
    kernelBinHandle_ = argsInfo.exceptionKernelInfo.bin;  // binHandle
    kernelBinSize_ = argsInfo.exceptionKernelInfo.binSize;
    if ((argsInfo.exceptionKernelInfo.kernelName != nullptr) && (argsInfo.exceptionKernelInfo.kernelNameSize != 0)) {
        kernelName_ = std::string(argsInfo.exceptionKernelInfo.kernelName, argsInfo.exceptionKernelInfo.kernelNameSize);
    }
    IDE_LOGI("Kernel handle: %p, kernel size: %u, name addr: %p, name size: %u, kernel name: %s", kernelBinHandle_,
             kernelBinSize_, argsInfo.exceptionKernelInfo.kernelName, argsInfo.exceptionKernelInfo.kernelNameSize,
             kernelName_.c_str());
}

int32_t KernelInfoCollector::LoadKernelBinBuffer()
{
    if (kernelBinHandle_ == nullptr){
        return ADUMP_SUCCESS;
    }
    uint32_t binSize = 0;
    void *binAddr = nullptr;
    rtError_t rtRet = rtGetBinBuffer(kernelBinHandle_, RT_BIN_HOST_ADDR, &binAddr, &binSize);
    if (rtRet != RT_ERROR_NONE || binAddr == nullptr || binSize == 0) {
        IDE_LOGE("rtGetBinBuffer kernel bin addr failed, ret: %d", static_cast<int32_t>(rtRet));
        kernelBinData_ = "";
        return ADUMP_FAILED;
    }
    kernelBinData_ = std::string(static_cast<AdxStringBuffer>(binAddr), binSize);
    IDE_LOGI("Get kernel addr: %p", binAddr);
    return ADUMP_SUCCESS;
}

std::string KernelInfoCollector::GetProcessedKernelName() const
{
    std::string kernelName = kernelName_;
    std::string mixSuffix[] = {"_mix_aic", "_mix_aiv"};
    for (const auto &suffix : mixSuffix) {
        std::string::size_type pos = kernelName.find(suffix);
        if (pos != std::string::npos) {
            kernelName.replace(pos, suffix.size(), "");
        }
    }
    return kernelName;
}

int32_t KernelInfoCollector::StartCollectKernel(const std::string &dumpPath) const
{
    if (kernelName_.empty() || kernelBinHandle_ == nullptr || kernelBinSize_ == 0) {
        IDE_LOGI("Kernel name or kernel bin is empty, skip dump kernel.");
        return ADUMP_SUCCESS;
    }

    std::string kernelName = GetProcessedKernelName();

    // dump host kernel
    int32_t ret = ADUMP_SUCCESS;
    if (DumpHostKernelBin(kernelName, dumpPath) != ADUMP_SUCCESS) {
        IDE_LOGE("Dump host kernel bin failed.");
        ret = ADUMP_FAILED;
    }

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
 * @param [in]  : kernelName    kernel name get from runtime removed the _mix_aic and _mix_aiv fields
 * @param [in]  : dumpPath      path of the exception dump file
 * @return      : ADUMP_SUCCESS succeed; ADUMP_FAILED failed
 */
int32_t KernelInfoCollector::DumpHostKernelBin(const std::string &kernelName, const std::string &dumpPath) const
{
    if (kernelBinData_.empty()) {
        IDE_LOGE("Kernel bin data is empty.");
        return ADUMP_FAILED;
    }
    Path hostKernelBinPath(dumpPath);
    std::string hostKernelBinName = StrUtils::Replace(kernelName, INVALID_FILE_NAME_CHAR, '_') + "_host.o";
    hostKernelBinPath.Concat(hostKernelBinName);
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
        IDE_LOGE("Write host kernel bin file[%s] failed.", hostKernelBinPath.GetCString());
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

int32_t KernelInfoCollector::GetExceptionRegInfo(const rtExceptionInfo &exception, ExceptionRegInfo &exceptionRegInfo)
{
    uint32_t platform = 0;
    IDE_CTRL_VALUE_FAILED(AdumpDsmi::DrvGetPlatformType(platform), return ADUMP_FAILED, "Get platform type failed.");
    if (static_cast<PlatformType>(platform) != PlatformType::CHIP_CLOUD_V2) {
        IDE_LOGW("Not support to get error register information from RTS.");
        return ADUMP_FAILED;
    }
    rtError_t rtRet = rtGetExceptionRegInfo(&exception, &exceptionRegInfo.errRegInfo, &exceptionRegInfo.coreNum);
    IDE_CTRL_VALUE_FAILED(rtRet == RT_ERROR_NONE, return ADUMP_FAILED,
        "Call rtGetExceptionRegInfo for error register information failed. ret: %d", static_cast<int32_t>(rtRet));
    IDE_LOGE("Get error register information. coreNum=%u", exceptionRegInfo.coreNum);
    return ADUMP_SUCCESS;
}

void KernelInfoCollector::GetKernelBinInfo(const rtExceptionInfo &exception, std::vector<char> &binData,
    uint32_t *binSize)
{
    rtExceptionArgsInfo_t exceptionArgsInfo{};
    rtExceptionExpandType_t exceptionTaskType = exception.expandInfo.type;
    (void)ExceptionInfoCommon::GetExceptionInfo(exception, exceptionTaskType, exceptionArgsInfo);
    void *binAddr = nullptr;
    rtError_t rtRet = rtGetBinBuffer(exceptionArgsInfo.exceptionKernelInfo.bin, RT_BIN_HOST_ADDR, &binAddr, binSize);
    IDE_CTRL_VALUE_FAILED((rtRet == RT_ERROR_NONE) && (binAddr != nullptr), return,
        "Call rtGetBinBuffer for host kernel object failed. ret: %d", static_cast<int32_t>(rtRet));
    binData.assign(static_cast<char*>(binAddr), static_cast<char*>(binAddr) + *binSize);
    IDE_LOGI("Get host kernel object success. kernel size=%u", *binSize);
}

void KernelInfoCollector::DumpKernelErrorSymbols(const rtExceptionInfo &exception, ExceptionRegInfo &exceptionRegInfo)
{
    IDE_CTRL_VALUE_FAILED(GetExceptionRegInfo(exception, exceptionRegInfo) == ADUMP_SUCCESS, return,
        "Get exception register information failed!");
    std::vector<char> binData;
    uint32_t binSize = 0;
    GetKernelBinInfo(exception, binData, &binSize);
    IDE_CTRL_VALUE_FAILED(!binData.empty(), return, "Get host kernel object failed!");
    KernelSymbols kernelSymbols{false, false, 0, 0, {}};
    ParseKernelSymbols(binData.data(), kernelSymbols);
    PrintKernelErrorSymbols(kernelSymbols, exceptionRegInfo);
}

void KernelInfoCollector::DumpKernelErrorSymbols(const rtExceptionInfo &exception)
{
    ExceptionRegInfo exceptionRegInfo{0, nullptr};
    DumpKernelErrorSymbols(exception, exceptionRegInfo);
}

bool KernelInfoCollector::EndsWith(const char* source, const char* suffix)
{
    if (!source || !suffix) {
        return false;
    }

    size_t srcLen = strlen(source);
    size_t suffixLen = strlen(suffix);
    if (suffixLen > srcLen) {
        return false;
    }
    return strncmp(source + srcLen - suffixLen, suffix, suffixLen) == 0;
}

void KernelInfoCollector::ParseSuperKernelSymbols(const Elf64_Sym *symbolTable, size_t symbolSize,
    const char *strTable, KernelSymbols &kernelSymbols)
{
    uint32_t functionCount = 0;
    uint32_t globalCount = 0;
    for (uint64_t i = 0; i < symbolSize / sizeof(Elf64_Sym); i++) {
        if ((symbolTable[i].st_info & ELF_STT_TYPE) == STT_FUNC) {
            functionCount++;
        }
        if (static_cast<uint8_t>(symbolTable[i].st_info >> ELF_STB_BIND) == static_cast<uint8_t>(STB_GLOBAL)) {
            globalCount++;
        }

        if ((symbolTable[i].st_info & ELF_STT_TYPE) != STT_FUNC) {
            continue;
        }
        const char* name = strTable + symbolTable[i].st_name;
        uint64_t offset = symbolTable[i].st_value;
        uint64_t size = symbolTable[i].st_size;
        IDE_LOGI("Function Symbol. offset=%08lx, size=%08lx, name=%s", offset, size, name);
        KernelSymbolInfo symbolInfo{offset, size, std::string(name)};
        kernelSymbols.symbols.emplace_back(symbolInfo);

        // find global function symbol for entry symbol
        if (static_cast<uint8_t>(symbolTable[i].st_info >> ELF_STB_BIND) != static_cast<uint8_t>(STB_GLOBAL)) {
            continue;
        }
        if (!kernelSymbols.existAicBase && EndsWith(name, "_mix_aic")) {
            kernelSymbols.aicBase = offset;
            kernelSymbols.existAicBase = true;
            IDE_LOGE("Find mix_aic entry function symbol. offset=%08lx, size=%08lx, name=%s", offset, size, name);
        }
        if (!kernelSymbols.existAivBase && EndsWith(name, "_mix_aiv")) {
            kernelSymbols.aivBase = offset;
            kernelSymbols.existAivBase = true;
            IDE_LOGE("Find mix_aiv entry function symbol. offset=%08lx, size=%08lx, name=%s", offset, size, name);
        }
    }

    if (functionCount <= globalCount) {
        kernelSymbols.existAicBase = false;
        kernelSymbols.existAivBase = false;
        IDE_LOGE("It is Non-SuperKernel. functionCount=%u, globalCount=%u", functionCount, globalCount);
    }
}

void KernelInfoCollector::ParseKernelSymbols(const char *elf, KernelSymbols &kernelSymbols)
{
    IDE_CTRL_VALUE_FAILED(elf != nullptr, return, "kernel object is nil");
    const Elf64_Ehdr *ehdr = reinterpret_cast<const Elf64_Ehdr *>(elf);
    uint64_t sectionCount = ehdr->e_shnum;
    const Elf64_Shdr *sectionHeader = reinterpret_cast<const Elf64_Shdr *>(elf + ehdr->e_shoff);
    const char *sectionStrTable = elf + sectionHeader[ehdr->e_shstrndx].sh_offset;
    const char *strTable = nullptr;
    const Elf64_Sym *symbolTable = nullptr;
    size_t symbolSize = 0;
    for (uint64_t i = 0; i < sectionCount; i++) {
        if (sectionHeader[i].sh_type == SHT_NULL || sectionHeader[i].sh_type == SHT_NOBITS) {
            continue;
        }
        const char *sectionName = sectionStrTable + sectionHeader[i].sh_name;
        if (strcmp(".symtab", sectionName) == 0) {
            symbolTable = reinterpret_cast<const Elf64_Sym *>(elf + sectionHeader[i].sh_offset);
            symbolSize = sectionHeader[i].sh_size;
        } else if (strcmp(".strtab", sectionName) == 0) {
            strTable = elf + sectionHeader[i].sh_offset;
        }
    }
    if (!symbolTable || !strTable) {
        IDE_LOGE("readelf from kernel object error. Not find symtab[%p] or strtab[%p]", symbolTable, strTable);
        return;
    }
    ParseSuperKernelSymbols(symbolTable, symbolSize, strTable, kernelSymbols);
}

void KernelInfoCollector::PrintKernelErrorSymbols(const KernelSymbols &kernelSymbols,
    const ExceptionRegInfo &exceptionRegInfo)
{
    rtExceptionErrRegInfo_t coreErrRegInfo;
    uint64_t offset = 0;
    for (uint32_t i = 0; i < exceptionRegInfo.coreNum; i++) {
        coreErrRegInfo = exceptionRegInfo.errRegInfo[i];
        if (coreErrRegInfo.coreType == RT_CORE_TYPE_AIC && kernelSymbols.existAicBase) {
            offset = coreErrRegInfo.currentPC - coreErrRegInfo.startPC;
        } else if (coreErrRegInfo.coreType == RT_CORE_TYPE_AIV && kernelSymbols.existAivBase) {
            offset = coreErrRegInfo.currentPC - coreErrRegInfo.startPC + kernelSymbols.aivBase;
        } else {
            continue;
        }
        IDE_LOGI("coreId=%u, coreType=%hhu, startPC=%lx, currentPC=%lx, offset=%lx",
            coreErrRegInfo.coreId, coreErrRegInfo.coreType, coreErrRegInfo.startPC,
            coreErrRegInfo.currentPC, offset);
        for (const KernelSymbolInfo &symbolInfo: kernelSymbols.symbols) {
            if (symbolInfo.offset <= offset && offset < symbolInfo.offset + symbolInfo.size) {
                IDE_LOGE("[Dump][Exception] coreId=%u, coreType=%hhu, startPC=%lx, currentPC=%lx, offset=%lx, "
                    "symbol name=%s, symbol size=%lx, symbol offset=%lx",
                    coreErrRegInfo.coreId, coreErrRegInfo.coreType, coreErrRegInfo.startPC, coreErrRegInfo.currentPC,
                    offset, symbolInfo.name.c_str(), symbolInfo.size, symbolInfo.offset);
            }
        }
    }
}
}  // namespace Adx