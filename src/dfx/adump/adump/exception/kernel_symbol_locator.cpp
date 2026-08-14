/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <algorithm>
#include <cstring>
#include <elf.h>
#include <limits>
#include <mutex>
#include <sstream>
#include "securec.h"
#include "runtime/kernel.h"
#include "kernel_symbol_locator.h"
#include "kernel_info_collector.h"
#include "kernel_source_symbolizer.h"
#include "exception_info_common.h"
#include "log/adx_log.h"
#include "log/hdc_log.h"

namespace Adx {
namespace {
std::mutex g_cacheMutex;

// 符号过滤计数关系：
// total = accepted + nonFunc + invalidSection + invalidName。
struct SymbolFilterStats {
    // 从有效的 SHT_SYMTAB/SHT_DYNSYM 段读取到的符号总数。
    size_t total = 0;
    // 被接受用于函数定位的有效函数符号数。
    size_t accepted = 0;
    // 因 st_info 类型不是 STT_FUNC 被过滤的符号数。
    size_t nonFunc = 0;
    // 因 st_shndx 为 SHN_UNDEF 或超出 section header 范围被过滤的函数符号数。
    size_t invalidSection = 0;
    // 因 st_name 越界或符号名未在字符串表范围内以 '\\0' 结束被过滤的函数符号数。
    size_t invalidName = 0;
};

template <typename T>
bool ReadStruct(const char* elf, size_t elfSize, size_t offset, T& out)
{
    if (elf == nullptr || offset > elfSize || elfSize - offset < sizeof(T)) {
        return false;
    }
    return memcpy_s(&out, sizeof(T), elf + offset, sizeof(T)) == EOK;
}

bool IsAddOverflow(size_t lhs, size_t rhs) { return lhs > std::numeric_limits<size_t>::max() - rhs; }

bool IsAddOverflow64(uint64_t lhs, uint64_t rhs)
{
    return lhs > std::numeric_limits<uint64_t>::max() - rhs;
}

bool GetSymbolOffsetRange(const std::vector<KernelSymbol>& symbols, uint64_t& minOffset, uint64_t& maxEnd)
{
    bool hasRange = false;
    minOffset = 0;
    maxEnd = 0;
    for (const KernelSymbol& symbol : symbols) {
        if (IsAddOverflow64(symbol.offset, symbol.size)) {
            continue;
        }
        const uint64_t symbolEnd = symbol.offset + symbol.size;
        if (!hasRange) {
            minOffset = symbol.offset;
            maxEnd = symbolEnd;
            hasRange = true;
            continue;
        }
        minOffset = std::min(minOffset, symbol.offset);
        maxEnd = std::max(maxEnd, symbolEnd);
    }
    return hasRange;
}

const KernelSymbol* FindBestMatchedSymbol(const std::vector<KernelSymbol>& symbols, uint64_t fixedPCOffset)
{
    const KernelSymbol* matchedSymbol = nullptr;
    for (const auto& symbol : symbols) {
        if (fixedPCOffset < symbol.offset || fixedPCOffset - symbol.offset >= symbol.size) {
            continue;
        }
        if (matchedSymbol == nullptr || symbol.offset > matchedSymbol->offset ||
            (symbol.offset == matchedSymbol->offset && symbol.size < matchedSymbol->size)) {
            matchedSymbol = &symbol;
        }
    }
    return matchedSymbol;
}

void LogKernelSymbolSummary(
    const KernelSymbolSet& symbols, size_t parsedSymbolCount, const SymbolFilterStats& filterStats)
{
    uint64_t minOffset = 0;
    uint64_t maxEnd = 0;
    const bool hasRange = GetSymbolOffsetRange(symbols.symbols, minOffset, maxEnd);
    IDE_LOGI("Parse kernel symbols success. parsedSymbolCount=%zu, normalizedSymbolCount=%zu, "
        "hasSymbolRange=%u, minSymbolOffset=0x%lx, maxSymbolEnd=0x%lx, symbolTotal=%zu, accepted=%zu, "
        "nonFunc=%zu, invalidSection=%zu, invalidName=%zu.",
        parsedSymbolCount, symbols.symbols.size(), static_cast<uint32_t>(hasRange), minOffset, maxEnd,
        filterStats.total, filterStats.accepted, filterStats.nonFunc, filterStats.invalidSection,
        filterStats.invalidName);
}

uint16_t Swap16(uint16_t value) { return static_cast<uint16_t>((value >> 8U) | (value << 8U)); }

uint32_t Swap32(uint32_t value)
{
    return ((value & 0x000000FFU) << 24U) | ((value & 0x0000FF00U) << 8U) | ((value & 0x00FF0000U) >> 8U) |
           ((value & 0xFF000000U) >> 24U);
}

uint64_t Swap64(uint64_t value)
{
    return ((value & 0x00000000000000FFULL) << 56U) | ((value & 0x000000000000FF00ULL) << 40U) |
           ((value & 0x0000000000FF0000ULL) << 24U) | ((value & 0x00000000FF000000ULL) << 8U) |
           ((value & 0x000000FF00000000ULL) >> 8U) | ((value & 0x0000FF0000000000ULL) >> 24U) |
           ((value & 0x00FF000000000000ULL) >> 40U) | ((value & 0xFF00000000000000ULL) >> 56U);
}

bool IsSupportedElfData(uint8_t data) { return data == ELFDATANONE || data == ELFDATA2LSB || data == ELFDATA2MSB; }

bool IsBigEndianElf(const Elf64_Ehdr& ehdr) { return ehdr.e_ident[EI_DATA] == ELFDATA2MSB; }

bool IsHostBigEndian()
{
    const uint16_t value = 0x0102U;
    const uint8_t* bytes = reinterpret_cast<const uint8_t*>(&value);
    return bytes[0] == 0x01U;
}

bool ShouldSwapElfBytes(const Elf64_Ehdr& ehdr) { return IsBigEndianElf(ehdr) != IsHostBigEndian(); }

void NormalizeElfHeader(Elf64_Ehdr& ehdr, bool shouldSwap)
{
    if (!shouldSwap) {
        return;
    }
    ehdr.e_type = Swap16(ehdr.e_type);
    ehdr.e_machine = Swap16(ehdr.e_machine);
    ehdr.e_version = Swap32(ehdr.e_version);
    ehdr.e_entry = Swap64(ehdr.e_entry);
    ehdr.e_phoff = Swap64(ehdr.e_phoff);
    ehdr.e_shoff = Swap64(ehdr.e_shoff);
    ehdr.e_flags = Swap32(ehdr.e_flags);
    ehdr.e_ehsize = Swap16(ehdr.e_ehsize);
    ehdr.e_phentsize = Swap16(ehdr.e_phentsize);
    ehdr.e_phnum = Swap16(ehdr.e_phnum);
    ehdr.e_shentsize = Swap16(ehdr.e_shentsize);
    ehdr.e_shnum = Swap16(ehdr.e_shnum);
    ehdr.e_shstrndx = Swap16(ehdr.e_shstrndx);
}

void NormalizeSectionHeader(Elf64_Shdr& shdr, bool shouldSwap)
{
    if (!shouldSwap) {
        return;
    }
    shdr.sh_name = Swap32(shdr.sh_name);
    shdr.sh_type = Swap32(shdr.sh_type);
    shdr.sh_flags = Swap64(shdr.sh_flags);
    shdr.sh_addr = Swap64(shdr.sh_addr);
    shdr.sh_offset = Swap64(shdr.sh_offset);
    shdr.sh_size = Swap64(shdr.sh_size);
    shdr.sh_link = Swap32(shdr.sh_link);
    shdr.sh_info = Swap32(shdr.sh_info);
    shdr.sh_addralign = Swap64(shdr.sh_addralign);
    shdr.sh_entsize = Swap64(shdr.sh_entsize);
}

void NormalizeSymbol(Elf64_Sym& sym, bool shouldSwap)
{
    if (!shouldSwap) {
        return;
    }
    sym.st_name = Swap32(sym.st_name);
    sym.st_shndx = Swap16(sym.st_shndx);
    sym.st_value = Swap64(sym.st_value);
    sym.st_size = Swap64(sym.st_size);
}

bool IsValidElfHeader(const Elf64_Ehdr& ehdr)
{
    return std::memcmp(ehdr.e_ident, ELFMAG, SELFMAG) == 0 && ehdr.e_ident[EI_CLASS] == ELFCLASS64 &&
           IsSupportedElfData(ehdr.e_ident[EI_DATA]) && ehdr.e_ehsize == sizeof(Elf64_Ehdr) &&
           ehdr.e_shentsize == sizeof(Elf64_Shdr) && ehdr.e_shoff != 0 && ehdr.e_shnum != 0;
}

bool IsRangeInsideElf(size_t offset, size_t size, size_t elfSize)
{
    return offset <= elfSize && elfSize - offset >= size;
}

bool IsSectionInsideElf(const Elf64_Shdr& section, size_t elfSize)
{
    if (section.sh_offset > static_cast<uint64_t>(std::numeric_limits<size_t>::max()) ||
        section.sh_size > static_cast<uint64_t>(std::numeric_limits<size_t>::max())) {
        return false;
    }
    return IsRangeInsideElf(static_cast<size_t>(section.sh_offset), static_cast<size_t>(section.sh_size), elfSize);
}

bool ReadElfHeader(const char* elf, size_t elfSize, Elf64_Ehdr& ehdr)
{
    if (!ReadStruct(elf, elfSize, 0, ehdr)) {
        return false;
    }
    if (std::memcmp(ehdr.e_ident, ELFMAG, SELFMAG) != 0 || ehdr.e_ident[EI_CLASS] != ELFCLASS64 ||
        !IsSupportedElfData(ehdr.e_ident[EI_DATA])) {
        return false;
    }
    // 与 runtime 保持一致：ELFDATA2MSB 按大端解析字段；ELFDATANONE 按小端处理。
    NormalizeElfHeader(ehdr, ShouldSwapElfBytes(ehdr));
    return IsValidElfHeader(ehdr);
}

bool ReadSectionHeaders(
    const char* elf, size_t elfSize, const Elf64_Ehdr& ehdr, bool shouldSwap, std::vector<Elf64_Shdr>& outShdrs)
{
    const size_t shdrsSize = static_cast<size_t>(ehdr.e_shnum) * sizeof(Elf64_Shdr);
    if (ehdr.e_shoff > static_cast<uint64_t>(std::numeric_limits<size_t>::max()) ||
        !IsRangeInsideElf(static_cast<size_t>(ehdr.e_shoff), shdrsSize, elfSize)) {
        return false;
    }
    if (ehdr.e_shstrndx >= ehdr.e_shnum && ehdr.e_shstrndx != SHN_UNDEF) {
        return false;
    }

    outShdrs.clear();
    outShdrs.reserve(ehdr.e_shnum);
    for (uint16_t i = 0; i < ehdr.e_shnum; i++) {
        Elf64_Shdr shdr = {};
        const size_t offset = static_cast<size_t>(ehdr.e_shoff) + static_cast<size_t>(i) * sizeof(Elf64_Shdr);
        if (!ReadStruct(elf, elfSize, offset, shdr)) {
            return false;
        }
        NormalizeSectionHeader(shdr, shouldSwap);
        outShdrs.push_back(shdr);
    }
    return true;
}

bool IsSymbolTable(const Elf64_Shdr& section) { return section.sh_type == SHT_SYMTAB || section.sh_type == SHT_DYNSYM; }

bool IsValidSymbolAndStringTable(
    size_t elfSize, const std::vector<Elf64_Shdr>& shdrs, const Elf64_Shdr& symtabShdr, const Elf64_Shdr*& strtabShdr)
{
    if (!IsSectionInsideElf(symtabShdr, elfSize) || symtabShdr.sh_size == 0) {
        return false;
    }
    if (symtabShdr.sh_entsize != sizeof(Elf64_Sym) || (symtabShdr.sh_size % sizeof(Elf64_Sym)) != 0) {
        return false;
    }
    if (symtabShdr.sh_link >= shdrs.size()) {
        return false;
    }

    strtabShdr = &shdrs[symtabShdr.sh_link];
    if (strtabShdr->sh_type != SHT_STRTAB || strtabShdr->sh_size == 0) {
        return false;
    }
    return IsSectionInsideElf(*strtabShdr, elfSize);
}

bool GetSymbolSectionEnd(const Elf64_Sym& sym, const std::vector<Elf64_Shdr>& shdrs, uint64_t& sectionEnd)
{
    if (sym.st_shndx >= shdrs.size()) {
        return false;
    }
    const Elf64_Shdr& section = shdrs[sym.st_shndx];
    // ET_REL 中 st_value 通常是 section 内偏移且 sh_addr 为 0；加载态镜像中 st_value 通常可与 sh_addr 比较。
    uint64_t sectionBase = section.sh_addr;
    if (sym.st_value < sectionBase) {
        sectionBase = 0;
    }
    if (sectionBase > std::numeric_limits<uint64_t>::max() - section.sh_size) {
        return false;
    }
    sectionEnd = sectionBase + section.sh_size;
    return sectionEnd > sym.st_value;
}

bool BuildKernelSymbol(
    const Elf64_Sym& sym, const std::vector<Elf64_Shdr>& shdrs, const char* strtab, size_t strtabSize,
    SymbolFilterStats& stats, KernelSymbol& outSymbol)
{
    stats.total++;
    if (ELF64_ST_TYPE(sym.st_info) != STT_FUNC) {
        stats.nonFunc++;
        return false;
    }
    if (sym.st_shndx == SHN_UNDEF) {
        stats.invalidSection++;
        return false;
    }
    if (sym.st_shndx >= shdrs.size()) {
        stats.invalidSection++;
        return false;
    }
    if (sym.st_name >= strtabSize) {
        stats.invalidName++;
        return false;
    }
    // section 结束地址用于给 st_size 为 0 的符号补齐范围。
    (void)GetSymbolSectionEnd(sym, shdrs, outSymbol.sectionEnd);

    const char* strStart = strtab + sym.st_name;
    size_t remaining = strtabSize - sym.st_name;
    const char* strEnd = static_cast<const char*>(std::memchr(strStart, '\0', remaining));
    if (strEnd == nullptr) {
        stats.invalidName++;
        return false;
    }

    outSymbol.offset = sym.st_value;
    outSymbol.size = sym.st_size;
    outSymbol.sectionIndex = sym.st_shndx;
    outSymbol.bind = ELF64_ST_BIND(sym.st_info);
    outSymbol.visibility = ELF64_ST_VISIBILITY(sym.st_other);
    outSymbol.name.assign(strStart, strEnd - strStart);
    IDE_LOGD("Parse kernel symbol, name=%s, offset=0x%lx, size=0x%lx, sectionEnd=0x%lx, "
        "sectionIndex=%u, bind=%u, visibility=%u.",
        outSymbol.name.c_str(), outSymbol.offset, outSymbol.size, outSymbol.sectionEnd,
        static_cast<uint32_t>(outSymbol.sectionIndex), static_cast<uint32_t>(outSymbol.bind),
        static_cast<uint32_t>(outSymbol.visibility));
    stats.accepted++;
    return true;
}

bool ParseFunctionSymbols(
    const char* elf, size_t elfSize, const Elf64_Shdr& symtabShdr, const Elf64_Shdr& strtabShdr, bool shouldSwap,
    const std::vector<Elf64_Shdr>& shdrs, std::vector<KernelSymbol>& outSymbols, SymbolFilterStats& stats)
{
    const size_t symCount = symtabShdr.sh_size / sizeof(Elf64_Sym);
    const char* strtab = elf + strtabShdr.sh_offset;
    for (size_t i = 0; i < symCount; i++) {
        if (IsAddOverflow(static_cast<size_t>(symtabShdr.sh_offset), i * sizeof(Elf64_Sym))) {
            return false;
        }
        Elf64_Sym sym = {};
        const size_t symOffset = static_cast<size_t>(symtabShdr.sh_offset) + i * sizeof(Elf64_Sym);
        if (!ReadStruct(elf, elfSize, symOffset, sym)) {
            return false;
        }
        NormalizeSymbol(sym, shouldSwap);
        KernelSymbol symbol = {};
        if (BuildKernelSymbol(sym, shdrs, strtab, static_cast<size_t>(strtabShdr.sh_size), stats, symbol)) {
            outSymbols.push_back(symbol);
        }
    }
    return true;
}

bool IsSameKernelSymbol(const KernelSymbol& lhs, const KernelSymbol& rhs)
{
    return lhs.offset == rhs.offset && lhs.size == rhs.size && lhs.sectionIndex == rhs.sectionIndex &&
           lhs.name == rhs.name;
}

void SortKernelSymbols(std::vector<KernelSymbol>& symbols)
{
    // 按地址排序，便于后续用同 section 内的下一个符号修正 zero-size 符号范围。
    std::sort(symbols.begin(), symbols.end(), [](const KernelSymbol& lhs, const KernelSymbol& rhs) {
        if (lhs.offset != rhs.offset) {
            return lhs.offset < rhs.offset;
        }
        if (lhs.size != rhs.size) {
            return lhs.size > rhs.size;
        }
        return lhs.name < rhs.name;
    });
}

void DeduplicateKernelSymbols(std::vector<KernelSymbol>& symbols)
{
    std::vector<KernelSymbol> uniqueSymbols;
    uniqueSymbols.reserve(symbols.size());
    for (const KernelSymbol& symbol : symbols) {
        // 同一个函数可能同时出现在 .symtab 和 .dynsym 中。
        if (!uniqueSymbols.empty() && IsSameKernelSymbol(uniqueSymbols.back(), symbol)) {
            uniqueSymbols.back().sectionEnd = std::max(uniqueSymbols.back().sectionEnd, symbol.sectionEnd);
            continue;
        }
        uniqueSymbols.push_back(symbol);
    }
    symbols.swap(uniqueSymbols);
}

void FillZeroSizeSymbolRanges(std::vector<KernelSymbol>& symbols)
{
    for (size_t i = 0; i < symbols.size(); i++) {
        if (symbols[i].size != 0) {
            continue;
        }
        // 参考 LLDB 策略：先用 section 结束地址作为最大范围，再用同 section 的下一个符号地址收缩范围。
        if (symbols[i].sectionEnd > symbols[i].offset) {
            symbols[i].size = symbols[i].sectionEnd - symbols[i].offset;
        }
        for (size_t j = i + 1; j < symbols.size(); j++) {
            if (symbols[j].sectionIndex == symbols[i].sectionIndex && symbols[j].offset > symbols[i].offset) {
                const uint64_t sizeToNextSymbol = symbols[j].offset - symbols[i].offset;
                if (symbols[i].size == 0 || sizeToNextSymbol < symbols[i].size) {
                    symbols[i].size = sizeToNextSymbol;
                }
                break;
            }
        }
    }
}

void FilterValidKernelSymbols(const std::vector<KernelSymbol>& symbols, std::vector<KernelSymbol>& outSymbols)
{
    outSymbols.clear();
    outSymbols.reserve(symbols.size());
    for (const KernelSymbol& symbol : symbols) {
        if (!symbol.name.empty() && symbol.size != 0) {
            outSymbols.push_back(symbol);
        }
    }
}

void NormalizeFunctionSymbols(std::vector<KernelSymbol>& symbols, std::vector<KernelSymbol>& outSymbols)
{
    SortKernelSymbols(symbols);
    DeduplicateKernelSymbols(symbols);
    FillZeroSizeSymbolRanges(symbols);
    FilterValidKernelSymbols(symbols, outSymbols);
}

bool ParseSymbolTables(
    const char* elf, size_t elfSize, const std::vector<Elf64_Shdr>& shdrs, bool shouldSwap,
    std::vector<KernelSymbol>& parsedSymbols, SymbolFilterStats& filterStats, size_t& symbolTableCount,
    size_t& validSymbolTableCount)
{
    for (const Elf64_Shdr& symtabShdr : shdrs) {
        if (!IsSymbolTable(symtabShdr)) {
            continue;
        }
        symbolTableCount++;
        const Elf64_Shdr* strtabShdr = nullptr;
        if (!IsValidSymbolAndStringTable(elfSize, shdrs, symtabShdr, strtabShdr)) {
            continue;
        }
        validSymbolTableCount++;
        if (!ParseFunctionSymbols(elf, elfSize, symtabShdr, *strtabShdr, shouldSwap, shdrs, parsedSymbols,
            filterStats)) {
            IDE_LOGW("ParseElfSymbols failed, invalid ELF symbols, symOffset=%lu, symSize=%lu.",
                symtabShdr.sh_offset, symtabShdr.sh_size);
            return false;
        }
    }
    return true;
}

// 分类汇总用：(oFilePath, fixedPCOffset) 相同的多个异常 core 归为一组。
struct SummaryGroup {
    std::string oFilePath;
    uint64_t fixedPCOffset = 0;
    bool hasSymbol = false;
    std::string symbolName;
    uint64_t symbolOffset = 0;
    SymbolizeResult src;
    std::vector<const ErrorLocation*> cores;
};

// 按 (oFilePath, fixedPCOffset) 聚类：命中已有组则追加 core，否则新建组并拷贝定位信息。
std::vector<SummaryGroup> BuildSummaryGroups(const std::vector<ErrorLocation>& locations)
{
    std::vector<SummaryGroup> groups;
    for (const ErrorLocation& loc : locations) {
        SummaryGroup* target = nullptr;
        for (SummaryGroup& g : groups) {
            if (g.oFilePath == loc.oFilePath && g.fixedPCOffset == loc.fixedPCOffset) {
                target = &g;
                break;
            }
        }
        if (target == nullptr) {
            groups.emplace_back();
            target = &groups.back();
            target->oFilePath = loc.oFilePath;
            target->fixedPCOffset = loc.fixedPCOffset;
            target->hasSymbol = loc.hasSymbol;
            target->symbolName = loc.symbolName;
            target->symbolOffset = loc.symbolOffset;
            target->src = loc.src;
        }
        target->cores.push_back(&loc);
    }
    return groups;
}

// 打印单个分组：core 列表、symbol+偏移、func、source 行号，缺失信息统一显示 unknown。
void PrintSummaryGroup(size_t index, const SummaryGroup& g)
{
    std::ostringstream coresOss;
    for (size_t c = 0; c < g.cores.size(); ++c) {
        if (c != 0) {
            coresOss << ",";
        }
        coresOss << "{id=" << g.cores[c]->coreId << ",type=" << g.cores[c]->coreType << "}";
    }
    std::ostringstream symbolOss;
    if (g.hasSymbol) {
        symbolOss << g.symbolName << "+0x" << std::hex << g.symbolOffset;
    } else {
        symbolOss << "unknown";
    }
    const std::string sourceStr = g.src.ok
        ? (g.src.srcFile + ":" + std::to_string(g.src.srcLine) + ":" + std::to_string(g.src.srcColumn))
        : "unknown";
    IDE_LOGE("[Dump][Exception][Symbolize] Group[%zu] oFile=%s fixedPCOffset=0x%lx symbol=%s "
        "source=%s cores=[%s]",
        index, g.oFilePath.empty() ? "unknown" : g.oFilePath.c_str(), g.fixedPCOffset,
        symbolOss.str().c_str(), sourceStr.c_str(), coresOss.str().c_str());
}
} // namespace

std::unordered_map<rtBinHandle, KernelSymbolSet> KernelSymbolLocator::cache_;

KernelSymbolLocator::KernelSymbolLocator() : initialized_(false) {}
KernelSymbolLocator::~KernelSymbolLocator() = default;

void KernelSymbolLocator::ClearCache()
{
    std::lock_guard<std::mutex> lock(g_cacheMutex);
    cache_.clear();
}

void KernelSymbolLocator::ResetState()
{
    kernelSymbols_ = KernelSymbolSet();
    kernelDeviceStartPC_ = 0;
    hasKernelDeviceStartPC_ = false;
    initialized_ = false;
    oFilePath_.clear();
}

void KernelSymbolLocator::SetOFilePath(const std::string& oFilePath)
{
    oFilePath_ = oFilePath;
}

void KernelSymbolLocator::UpdateStartPCFromDeviceAddr(rtBinHandle binHandle)
{
    void* devAddr = nullptr;
    int32_t ret = ExceptionInfoCommon::GetKernelDeviceAddr(binHandle, devAddr);
    IDE_CTRL_VALUE_WARN(ret == ADUMP_SUCCESS && devAddr != nullptr, return,
        "Get kernel device address failed, skip updating startPC, binHandle=%p.", binHandle);

    kernelDeviceStartPC_ = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(devAddr));
    hasKernelDeviceStartPC_ = true;
    IDE_LOGI("Update kernel startPC from device address, binHandle=%p, startPC=0x%lx.", binHandle,
        kernelDeviceStartPC_);
}

int32_t KernelSymbolLocator::InitFromBinHandle(rtBinHandle binHandle)
{
    ResetState();
    IDE_CTRL_VALUE_WARN(binHandle != nullptr, return ADUMP_FAILED, "binHandle is null.");
    {
        std::lock_guard<std::mutex> lock(g_cacheMutex);
        auto it = cache_.find(binHandle);
        if (it != cache_.end()) {
            kernelSymbols_ = it->second;
            initialized_ = true;
            return ADUMP_SUCCESS;
        }
    }
    std::string binData;
    uint32_t binSize = 0;
    int32_t ret = ExceptionInfoCommon::GetBinDataFromHandle(binHandle, binData, binSize);
    IDE_CTRL_VALUE_WARN(ret == ADUMP_SUCCESS, return ADUMP_FAILED, "Get Kernel bin data failed for ParseElfSymbols");

    KernelSymbolSet symbols;
    ret = ParseElfSymbols(binData.data(), binData.size(), symbols);
    IDE_CTRL_VALUE_FAILED(ret == ADUMP_SUCCESS, return ADUMP_FAILED, "ParseElfSymbols failed.");
    kernelSymbols_ = symbols;
    {
        std::lock_guard<std::mutex> lock(g_cacheMutex);
        cache_[binHandle] = symbols;
    }
    initialized_ = true;
    return ADUMP_SUCCESS;
}

int32_t KernelSymbolLocator::InitFromBinBuffer(const std::string& binData)
{
    ResetState();
    IDE_CTRL_VALUE_WARN(!binData.empty(), return ADUMP_FAILED, "Kernel bin data is empty.");

    int32_t ret = ParseElfSymbols(binData.data(), binData.size(), kernelSymbols_);
    IDE_CTRL_VALUE_FAILED(ret == ADUMP_SUCCESS, return ADUMP_FAILED, "ParseElfSymbols failed.");

    initialized_ = true;
    return ADUMP_SUCCESS;
}

int32_t KernelSymbolLocator::ParseElfSymbols(const char* elf, size_t elfSize, KernelSymbolSet& outSymbols)
{
    Elf64_Ehdr ehdr = {};
    IDE_CTRL_VALUE_WARN(ReadElfHeader(elf, elfSize, ehdr), return ADUMP_FAILED,
        "ParseElfSymbols failed, invalid ELF header, elfSize=%zu.", elfSize);

    const bool shouldSwap = ShouldSwapElfBytes(ehdr);
    std::vector<Elf64_Shdr> shdrs;
    IDE_CTRL_VALUE_WARN(ReadSectionHeaders(elf, elfSize, ehdr, shouldSwap, shdrs), return ADUMP_FAILED,
        "ParseElfSymbols failed, invalid ELF section headers, shoff=%lu, shnum=%u.", ehdr.e_shoff, ehdr.e_shnum);

    std::vector<KernelSymbol> parsedSymbols;
    SymbolFilterStats filterStats;
    size_t symbolTableCount = 0;
    size_t validSymbolTableCount = 0;
    IDE_CTRL_VALUE_WARN(ParseSymbolTables(elf, elfSize, shdrs, shouldSwap, parsedSymbols, filterStats,
        symbolTableCount, validSymbolTableCount), return ADUMP_FAILED, "ParseElfSymbols failed.");

    IDE_CTRL_VALUE_WARN(symbolTableCount != 0, return ADUMP_FAILED,
        "ParseElfSymbols failed, no SHT_SYMTAB or SHT_DYNSYM section found.");
    IDE_CTRL_VALUE_WARN(validSymbolTableCount != 0, return ADUMP_FAILED,
        "ParseElfSymbols failed, no valid symbol table found, symbolTableCount=%zu.", symbolTableCount);

    std::vector<KernelSymbol> normalizedSymbols;
    NormalizeFunctionSymbols(parsedSymbols, normalizedSymbols);
    IDE_CTRL_VALUE_WARN(!normalizedSymbols.empty(), return ADUMP_FAILED,
        "ParseElfSymbols failed, empty function symbols, validSymbolTableCount=%zu, symbolTotal=%zu, "
        "accepted=%zu, nonFunc=%zu, invalidSection=%zu, invalidName=%zu.",
        validSymbolTableCount, filterStats.total, filterStats.accepted, filterStats.nonFunc,
        filterStats.invalidSection, filterStats.invalidName);

    outSymbols.symbols.swap(normalizedSymbols);
    LogKernelSymbolSummary(outSymbols, parsedSymbols.size(), filterStats);
    return ADUMP_SUCCESS;
}

bool KernelSymbolLocator::GetCorrectedStartPC(const rtExceptionErrRegInfo_t& coreInfo, uint64_t& startPC) const
{
    startPC = coreInfo.startPC;
    if (hasKernelDeviceStartPC_) {
        startPC = kernelDeviceStartPC_;
        return true;
    }
    return false;
}

void KernelSymbolLocator::PrintErrorForCore(rtExceptionErrRegInfo_t coreInfo, ErrorLocation& outLocation)
{
    outLocation.coreId = coreInfo.coreId;
    outLocation.coreType = static_cast<uint32_t>(coreInfo.coreType);
    outLocation.oFilePath = oFilePath_;
    // hasSymbol/skipped 只在特定分支置 true，入口先复位，避免调用方复用同一 ErrorLocation 时残留脏值。
    outLocation.hasSymbol = false;
    outLocation.skipped = false;

    uint32_t coreType = static_cast<uint32_t>(coreInfo.coreType);
    IDE_LOGE("[Dump][Exception] Error register information. coreId=%u, coreType=%u, %s",
        coreInfo.coreId, coreType, GetErrorRegisters(coreInfo).c_str());
    uint64_t fixedCurrentPC = FixPcByErrorRegs(coreInfo);
    uint64_t fixedStartPC = coreInfo.startPC;
    if (GetCorrectedStartPC(coreInfo, fixedStartPC)) {
        IDE_LOGI("Correct startPC by kernel address. coreId=%u, coreType=%u, originalStartPC=0x%lx, "
            "fixedStartPC=0x%lx.", coreInfo.coreId, coreType, coreInfo.startPC, fixedStartPC);
    }
    if (fixedCurrentPC < fixedStartPC) {
        IDE_LOGE("coreId=%u, coreType=%u, fixedCurrentPC=0x%lx < fixedStartPC=0x%lx, "
            "originalCurrentPC=0x%lx, originalStartPC=0x%lx, skip lookup symbol.",
            coreInfo.coreId, coreType, fixedCurrentPC, fixedStartPC, coreInfo.currentPC, coreInfo.startPC);
        outLocation.skipped = true;
        return;
    }

    const uint64_t fixedPCOffset = fixedCurrentPC - fixedStartPC;
    outLocation.fixedPCOffset = fixedPCOffset;
    IDE_LOGE("[Dump][Exception] Error PC information. coreId=%u, coreType=%u, originalStartPC=0x%lx, "
        "fixedStartPC=0x%lx, originalCurrentPC=0x%lx, fixedCurrentPC=0x%lx, fixedPCOffset=0x%lx.",
        coreInfo.coreId, coreType, coreInfo.startPC, fixedStartPC, coreInfo.currentPC, fixedCurrentPC,
        fixedPCOffset);

    // 源码解析不在此逐核进行：偏移已回填 outLocation.fixedPCOffset，由 SymbolizeCollectedLocations
    // 收齐所有核后对同一 .o 一次性批量 symbolize，避免每核各起一个 llvm-symbolizer 进程放大超时。
    MatchSymbolForCore(coreInfo, fixedPCOffset, outLocation);
}

void KernelSymbolLocator::MatchSymbolForCore(const rtExceptionErrRegInfo_t& coreInfo, uint64_t fixedPCOffset,
    ErrorLocation& outLocation)
{
    const uint32_t coreType = static_cast<uint32_t>(coreInfo.coreType);
    const KernelSymbol* matchedSymbol = FindBestMatchedSymbol(kernelSymbols_.symbols, fixedPCOffset);
    if (matchedSymbol != nullptr) {
        outLocation.hasSymbol = true;
        outLocation.symbolName = matchedSymbol->name;
        outLocation.symbolOffset = fixedPCOffset - matchedSymbol->offset;
        IDE_LOGE("[Dump][Exception] Error symbol information. coreId=%u, coreType=%u, "
            "symbol=%s+0x%lx.", coreInfo.coreId, coreType, matchedSymbol->name.c_str(),
            outLocation.symbolOffset);
        return;
    }

    uint64_t minSymbolOffset = 0;
    uint64_t maxSymbolEnd = 0;
    const bool hasSymbolRange = GetSymbolOffsetRange(kernelSymbols_.symbols, minSymbolOffset, maxSymbolEnd);
    IDE_LOGE("[Dump][Exception] Not found error symbol information. coreId=%u, coreType=%u, "
        "symbolCount=%zu, hasSymbolRange=%u, minSymbolOffset=0x%lx, maxSymbolEnd=0x%lx.",
        coreInfo.coreId, coreType, kernelSymbols_.symbols.size(),
        static_cast<uint32_t>(hasSymbolRange), minSymbolOffset, maxSymbolEnd);
}

void KernelSymbolLocator::SymbolizeCollectedLocations(std::vector<ErrorLocation>& locations) const
{
    if (oFilePath_.empty() || !KernelSourceSymbolizer::IsAvailable()) {
        return;
    }
    // 收集所有未跳过 core 的偏移；idxMap 记录第 k 个偏移对应 locations 中的下标，便于按序回填。
    std::vector<uint64_t> offsets;
    std::vector<size_t> idxMap;
    for (size_t i = 0; i < locations.size(); ++i) {
        if (!locations[i].skipped) {
            offsets.push_back(locations[i].fixedPCOffset);
            idxMap.push_back(i);
        }
    }
    if (offsets.empty()) {
        return;
    }
    // 同一 .o 的全部偏移由一个 llvm-symbolizer 进程一次解析，最坏耗时收敛为单次超时。
    std::vector<SymbolizeResult> results;
    if (!KernelSourceSymbolizer::Symbolize(oFilePath_, offsets, results)) {
        IDE_LOGW("Symbolize kernel source failed for all cores, oFile=%s, offsetCount=%zu.",
            oFilePath_.c_str(), offsets.size());
        return;
    }
    for (size_t k = 0; k < idxMap.size() && k < results.size(); ++k) {
        locations[idxMap[k]].src = results[k];
    }
}

int32_t KernelSymbolLocator::LocateErrorSymbols(const ExceptionRegInfo& exceptionRegInfo,
    std::vector<ErrorLocation>& outLocations)
{
    IDE_CTRL_VALUE_WARN(initialized_, return ADUMP_FAILED, "KernelSymbolLocator not initialized.");

    IDE_CTRL_VALUE_WARN(
        exceptionRegInfo.errRegInfo != nullptr && exceptionRegInfo.coreNum != 0, return ADUMP_FAILED,
        "Exception register info is null or core num is zero.");

    // 先逐核定位偏移与符号，再对同一 .o 的所有偏移一次性批量 symbolize，避免逐核各起进程放大超时。
    for (uint32_t i = 0; i < exceptionRegInfo.coreNum; i++) {
        ErrorLocation loc;
        PrintErrorForCore(exceptionRegInfo.errRegInfo[i], loc);
        outLocations.push_back(loc);
    }
    SymbolizeCollectedLocations(outLocations);
    return ADUMP_SUCCESS;
}

int32_t KernelSymbolLocator::LocateErrorSymbolsForCore(
    uint32_t coreId, uint32_t coreType, ExceptionRegInfo exceptionRegInfo, ErrorLocation& outLocation)
{
    IDE_CTRL_VALUE_WARN(initialized_, return ADUMP_FAILED, "KernelSymbolLocator not initialized.");

    IDE_CTRL_VALUE_WARN(exceptionRegInfo.errRegInfo != nullptr && exceptionRegInfo.coreNum != 0,
        return ADUMP_FAILED, "Exception register info is null or core num is zero.");

    const rtExceptionErrRegInfo_t* coreInfo = nullptr;
    for (uint32_t i = 0; i < exceptionRegInfo.coreNum; i++) {
        if (exceptionRegInfo.errRegInfo[i].coreId == coreId &&
            exceptionRegInfo.errRegInfo[i].coreType == static_cast<rtCoreType_t>(coreType)) {
            coreInfo = &exceptionRegInfo.errRegInfo[i];
            break;
        }
    }

    IDE_CTRL_VALUE_WARN(coreInfo != nullptr, return ADUMP_FAILED,
        "Core exception register info is not found, coreId=%u, coreType=%u.", coreId, coreType);

    // 先定位偏移与符号，再对该核偏移做一次 symbolize（单核路径每个 .o 本就是一次进程调用）。
    PrintErrorForCore(*coreInfo, outLocation);
    std::vector<ErrorLocation> single{outLocation};
    SymbolizeCollectedLocations(single);
    outLocation = single[0];
    return ADUMP_SUCCESS;
}

void KernelSymbolLocator::PrintClassificationSummary(const std::vector<ErrorLocation>& locations)
{
    if (locations.empty()) {
        return;
    }
    // 按 (oFilePath, fixedPCOffset) 聚类：同一 .o 同一偏移的多核归为一组。
    const std::vector<SummaryGroup> groups = BuildSummaryGroups(locations);
    IDE_LOGE("[Dump][Exception][Symbolize] classification summary. cores=%zu, groups=%zu.",
        locations.size(), groups.size());
    for (size_t i = 0; i < groups.size(); ++i) {
        PrintSummaryGroup(i, groups[i]);
    }
}

uint64_t KernelSymbolLocator::FixPcByErrorRegs(const rtExceptionErrRegInfo_t& coreInfo)
{
    PcFixerInterface* fixer = PcFixerFactory::GetInstance();
    if (fixer == nullptr) {
        return coreInfo.currentPC;
    }
    return fixer->FixPc(coreInfo.currentPC, coreInfo.errReg, RT_ERR_REG_NUMS);
}

std::string KernelSymbolLocator::GetErrorRegisters(const rtExceptionErrRegInfo_t& coreInfo)
{
    PcFixerInterface* fixer = PcFixerFactory::GetInstance();
    if (fixer == nullptr) {
        return "";
    }
    return fixer->GetErrorRegisters(coreInfo.errReg, RT_ERR_REG_NUMS);
}

std::string KernelSymbolLocator::ResolveOFilePath(const std::string& hostOPath)
{
    if (hostOPath.empty()) {
        return "";
    }
    // _host.o 含 .debug_line 时直接使用；否则留空，由调用方决定是否回退到 kernel_meta 的 .o。
    if (KernelSourceSymbolizer::HasDebugLine(hostOPath)) {
        return hostOPath;
    }
    IDE_LOGW("Host kernel .o has no .debug_line, source location unavailable, oFile=%s.", hostOPath.c_str());
    return "";
}

void KernelSymbolLocator::DumpErrorSymbols(const rtExceptionInfo& exception, ExceptionRegInfo& exceptionRegInfo,
    const std::string& dumpPath)
{
    rtExceptionArgsInfo_t exceptionArgsInfo{};
    int32_t ret = ExceptionInfoCommon::GetExceptionInfo(exception, exceptionArgsInfo);
    IDE_CTRL_VALUE_FAILED(ret == ADUMP_SUCCESS, return, "Get exception args info failed, skip dump error symbols.");

    std::string binData;
    uint32_t binSize = 0;
    const rtExceptionKernelInfo_t& kernelInfo = exceptionArgsInfo.exceptionKernelInfo;
    ret = ExceptionInfoCommon::GetBinDataFromHandle(kernelInfo.bin, binData, binSize);
    IDE_CTRL_VALUE_FAILED(ret == ADUMP_SUCCESS, return, "Get kernel bin data failed, skip dump error symbols.");

    KernelSymbolLocator locator;
    ret = locator.InitFromBinBuffer(binData);
    IDE_CTRL_VALUE_FAILED(ret == ADUMP_SUCCESS, return, "Parse kernel symbols failed, skip dump error symbols.");
    locator.UpdateStartPCFromDeviceAddr(kernelInfo.bin);

    // _host.o 已由调用方（DumpHostKernelBinBeforeSymbolize / 回调路径）提前无条件落盘，
    // 此处只复用其路径决定实际 symbolize 用的 .o，不再重复落盘：避免把落盘可靠性绑定到
    // 本函数前面的符号解析步骤（GetBinData/InitFromBinBuffer 失败时提前 return 会漏落盘）。
    KernelInfoCollector collector;
    collector.LoadKernelInfo(exceptionArgsInfo);
    std::string hostOPath = collector.GetHostOFilePath(dumpPath);
    // hostOPath 为空说明 kernelName 缺失/路径拼接失败，符号解析将无 .o 可用，仅告警不阻断后续流程。
    if (hostOPath.empty()) {
        IDE_LOGW("Host .o path is empty, symbolize may fall back without source location.");
    } else {
        locator.SetOFilePath(ResolveOFilePath(hostOPath));
    }

    std::vector<ErrorLocation> locations;
    ret = locator.LocateErrorSymbols(exceptionRegInfo, locations);
    IDE_CTRL_VALUE_WARN(ret == ADUMP_SUCCESS, return, "Locate kernel error symbols failed, ret=%d.", ret);
    // 未找到 llvm-symbolizer 时不打印聚类汇总（无源码信息时该汇总无增量价值）。
    if (KernelSourceSymbolizer::IsAvailable()) {
        PrintClassificationSummary(locations);
    }
}

void KernelSymbolLocator::DumpErrorSymbols(const rtExceptionInfo& exception, const std::string& dumpPath)
{
    ExceptionRegInfo exceptionRegInfo{0, nullptr};
    if (ExceptionInfoCommon::GetExceptionRegInfo(exception, exceptionRegInfo) == ADUMP_SUCCESS) {
        DumpErrorSymbols(exception, exceptionRegInfo, dumpPath);
    }
}

} // namespace Adx
