/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef KERNEL_SYMBOL_LOCATOR_H
#define KERNEL_SYMBOL_LOCATOR_H

#include <stdint.h>
#include <string>
#include <vector>
#include <unordered_map>
#include "runtime/rt.h"
#include "exception_info_common.h"
#include "kernel_pc_fixer.h"
#include "kernel_source_symbolizer.h"
#include "adump_pub.h"

namespace Adx {

struct KernelSymbol {
    uint64_t offset;
    uint64_t size;
    uint64_t sectionEnd;
    uint16_t sectionIndex;
    uint8_t bind;
    uint8_t visibility;
    std::string name;
};

struct KernelSymbolSet {
    std::vector<KernelSymbol> symbols;
};

// 单个异常 core 的定位结果：寄存器修正 PC、符号命中、源码行号，以及使用的 .o。
struct ErrorLocation {
    uint32_t coreId = 0;
    uint32_t coreType = 0;
    uint64_t fixedPCOffset = 0;
    bool hasSymbol = false;
    std::string symbolName;      // FindBestMatchedSymbol 命中的函数符号名
    uint64_t symbolOffset = 0;   // fixedPCOffset - symbol.offset
    SymbolizeResult src;         // llvm-symbolizer 解析出的源码信息
    std::string oFilePath;       // 实际用于 symbolize 的 .o
    bool skipped = false;        // fixedCurrentPC < fixedStartPC 等无法定位的情形
};

class KernelSymbolLocator {
public:
    KernelSymbolLocator();
    ~KernelSymbolLocator();

    int32_t InitFromBinHandle(rtBinHandle binHandle);
    int32_t InitFromBinBuffer(const std::string& binData);
    void UpdateStartPCFromDeviceAddr(rtBinHandle binHandle);

    // 注入实际用于 symbolize 的 .o 路径（_host.o 优先，无 .debug_line 时上层可回退）。
    void SetOFilePath(const std::string& oFilePath);

    // 定位并打印所有异常 core 的错误符号，同时把每个 core 的定位结果收集到 outLocations。
    // 每个 core 拿到偏移后即刻 symbolize 并回填 src（RunSymbolizer 原样打印原始输出）。
    int32_t LocateErrorSymbols(const ExceptionRegInfo& regInfo, std::vector<ErrorLocation>& outLocations);
    // 构建指定 core 的 ErrorLocation（定位 + 打印错误寄存器 + 即刻 symbolize 回填 src）。
    int32_t LocateErrorSymbolsForCore(uint32_t coreId, uint32_t coreType, ExceptionRegInfo exceptionRegInfo,
        ErrorLocation& outLocation);

    static uint64_t FixPcByErrorRegs(const rtExceptionErrRegInfo& coreInfo);
    static std::string GetErrorRegisters(const rtExceptionErrRegInfo& coreInfo);
    // 默认（非回调）异常路径：同步落 _host.o，即刻 symbolize，并打印分类汇总。
    static void DumpErrorSymbols(const rtExceptionInfo& exception, const std::string& dumpPath);
    static void DumpErrorSymbols(const rtExceptionInfo& exception, ExceptionRegInfo& exceptionRegInfo,
        const std::string& dumpPath);
    // 依据 _host.o 是否含 .debug_line 决定实际 symbolize 用的 .o，无调试信息时返回空串。
    static std::string ResolveOFilePath(const std::string& hostOPath);

    // 按 (oFilePath, fixedPCOffset) 对异常 core 聚类，统一打印分类汇总到 adump 日志。
    static void PrintClassificationSummary(const std::vector<ErrorLocation>& locations);

    static void ClearCache();

private:
    KernelSymbolSet kernelSymbols_;
    uint64_t kernelDeviceStartPC_ = 0;
    bool hasKernelDeviceStartPC_ = false;
    bool initialized_ = false;
    std::string oFilePath_;

    int32_t ParseElfSymbols(const char* elf, size_t elfSize, KernelSymbolSet& symbols);
    // 定位单个 core 的错误寄存器/PC/symbol 并回填 outLocation（不做 symbolize，源码解析统一批量执行）。
    void PrintErrorForCore(rtExceptionErrRegInfo_t coreInfo, ErrorLocation& outLocation);
    // 按 fixedPCOffset 匹配最优符号并回填 outLocation，未命中时打印符号区间辅助定位。
    void MatchSymbolForCore(const rtExceptionErrRegInfo_t& coreInfo, uint64_t fixedPCOffset,
        ErrorLocation& outLocation);
    // 对同一 .o(oFilePath_) 下所有未跳过 core 的偏移一次性批量 symbolize，按序回填各 loc.src。
    // 单进程处理全部偏移，最坏耗时收敛为单次超时，避免逐核各起进程导致的 coreNum×timeout 放大。
    void SymbolizeCollectedLocations(std::vector<ErrorLocation>& locations) const;
    void ResetState();
    bool GetCorrectedStartPC(const rtExceptionErrRegInfo& coreInfo, uint64_t& startPC) const;

    static std::unordered_map<rtBinHandle, KernelSymbolSet> cache_;
};

} // namespace Adx

#endif
