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

class KernelInfoCollector {
public:
    KernelInfoCollector()
        : kernelBinHandle_(nullptr),
          kernelBinSize_(0){};
    ~KernelInfoCollector() = default;
    void LoadKernelInfo(const rtExceptionArgsInfo &argsInfo);
    int32_t InitFromBinHandle(rtBinHandle BinHandle, const std::string &kernelName);
    int32_t LoadKernelBinBuffer();
    int32_t StartCollectKernel(const std::string &dumpPath) const;
    // 快速同步落 _host.o（纯内存 buffer 写），从 StartCollectKernel 拆出、供调用方单独同步调用；
    // outHostOPath 回传落盘绝对路径，供后续 symbolize 使用。
    int32_t DumpHostKernelBin(const std::string &dumpPath, std::string &outHostOPath) const;
    // 拼出 _host.o 落盘路径（不落盘），供回退/校验使用。
    std::string GetHostOFilePath(const std::string &dumpPath) const;
    std::string GetProcessedKernelName() const;
    std::vector<std::string> GetSearchPath() const;
    std::string SearchJsonFiles(const std::string &rootPath, const std::string &targetString) const;
private:
    bool ContainsString(const std::string &filePath, const std::string &targetString) const;
    std::string GetFirstItem(const std::string &curLine, size_t& curPlace) const;
    bool IsTargetLine(const std::string &currentLine, const std::string &key, const std::string &value) const;
    int32_t CollectKernelFile(const std::string &kernelName, const std::string &dumpPath) const;
    std::vector<std::string> SplitString(const std::string &str, char delimiter) const;
    rtBinHandle kernelBinHandle_;
    std::string kernelBinData_;
    uint32_t kernelBinSize_;
    std::string kernelName_;
};
int32_t StartCollectKernelAsync(std::shared_ptr<KernelInfoCollector> collector, const std::string &dumpPath);
} // namespace Adx
#endif // KERNEL_INFO_COLLECTOR_H
