/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef KERNEL_INFO_COLLECTOR_H
#define KERNEL_INFO_COLLECTOR_H
#include <memory>
#include <string>
#include <vector>
#include <elf.h>
#include "adump_pub.h"
#include "runtime/rt.h"

namespace Adx {
struct ExceptionRegInfo {
    uint32_t coreNum;                        // core number for exception
    rtExceptionErrRegInfo_t *errRegInfo;     // error register information for exception
};

struct KernelSymbolInfo {
    uint64_t offset;                // symbol offset
    uint64_t size;                  // symbol size
    std::string name;               // symbol name
};

struct KernelSymbols {
    bool existAicBase;
    bool existAivBase;
    uint64_t aicBase;
    uint64_t aivBase;
    std::vector<KernelSymbolInfo> symbols;
};

class KernelInfoCollector {
public:
    KernelInfoCollector()
        : kernelBinHandle_(nullptr),
          kernelBinSize_(0){};
    ~KernelInfoCollector() = default;
    void LoadKernelInfo(const rtExceptionArgsInfo &argsInfo);
    int32_t LoadKernelBinBuffer();
    int32_t StartCollectKernel(const std::string &dumpPath) const;
    std::string GetProcessedKernelName() const;
    std::vector<std::string> GetSearchPath() const;
    std::string SearchJsonFiles(const std::string &rootPath, const std::string &targetString) const;
    static void GetKernelBinInfo(const rtExceptionInfo &exception, std::vector<char> &binData, uint32_t *binSize);
    static int32_t GetExceptionRegInfo(const rtExceptionInfo &exception, ExceptionRegInfo &exceptionRegInfo);
    static void DumpKernelErrorSymbols(const rtExceptionInfo &exception);
    static void DumpKernelErrorSymbols(const rtExceptionInfo &exception, ExceptionRegInfo &exceptionRegInfo);
private:
    bool ContainsString(const std::string &filePath, const std::string &targetString) const;
    std::string GetFirstItem(const std::string &curLine, size_t& curPlace) const;
    bool IsTargetLine(const std::string &currentLine, const std::string &key, const std::string &value) const;
    int32_t DumpHostKernelBin(const std::string &kernelName, const std::string &dumpPath) const;
    int32_t CollectKernelFile(const std::string &kernelName, const std::string &dumpPath) const;
    std::vector<std::string> SplitString(const std::string &str, char delimiter) const;
    static bool EndsWith(const char* source, const char* suffix);
    static void ParseKernelSymbols(const char *elf, KernelSymbols &kernelSymbols);
    static void ParseSuperKernelSymbols(const Elf64_Sym *symbolTable, size_t symbolSize, const char *strTable,
        KernelSymbols &kernelSymbols);
    static void PrintKernelErrorSymbols(const KernelSymbols &kernelSymbols, const ExceptionRegInfo &exceptionRegInfo);
    rtBinHandle kernelBinHandle_;
    std::string kernelBinData_;
    uint32_t kernelBinSize_;
    std::string kernelName_;
};
int32_t StartCollectKernelAsync(std::shared_ptr<KernelInfoCollector> collector, const std::string &dumpPath);
} // namespace Adx
#endif // KERNEL_INFO_COLLECTOR_H
