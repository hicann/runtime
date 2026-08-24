/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include <algorithm>
#include <cstdint>
#include <elf.h>
#include <limits>
#include <string>
#include <vector>
#include "securec.h"
#include "mockcpp/mockcpp.hpp"
#include "adump_dsmi.h"
#include "adump_platform_manager.h"
#include "adump_pub.h"
#include "exception_info_common.h"
#include "kernel_symbol_locator.h"
#include "kernel_pc_fixer.h"
#include "runtime/base.h"
#include "runtime/rts/rts_kernel.h"
#include "acc_error_info.h"

using namespace Adx;

namespace {
constexpr uint64_t TEXT_SIZE = 0x1000ULL;
constexpr uint64_t TEST_PC = 0x123456789ABCDEF0ULL;
std::string g_mockElf;

struct SymbolSpec {
    std::string name;
    uint8_t bind;
    uint8_t type;
    uint64_t value;
    uint64_t size;
    uint16_t shndx;
    uint8_t other;
    bool overrideNameOffset;
    uint32_t nameOffset;
};

uint16_t Swap16(uint16_t value) { return __builtin_bswap16(value); }

uint32_t Swap32(uint32_t value) { return __builtin_bswap32(value); }

uint64_t Swap64(uint64_t value) { return __builtin_bswap64(value); }

template <typename T>
void SwapField(T& field)
{
    field = static_cast<T>(Swap64(static_cast<uint64_t>(field)));
}

template <>
void SwapField<uint32_t>(uint32_t& field)
{
    field = Swap32(field);
}

template <>
void SwapField<uint16_t>(uint16_t& field)
{
    field = Swap16(field);
}

size_t Align(size_t value, size_t alignment)
{
    if (alignment == 0U) {
        return value;
    }
    return (value + alignment - 1U) / alignment * alignment;
}

void ResizeForWrite(std::vector<char>& data, size_t offset, size_t len)
{
    if (data.size() < offset + len) {
        data.resize(offset + len, 0);
    }
}

void NormalizeForBigEndian(Elf64_Ehdr& ehdr)
{
    SwapField(ehdr.e_type);
    SwapField(ehdr.e_machine);
    SwapField(ehdr.e_version);
    SwapField(ehdr.e_entry);
    SwapField(ehdr.e_phoff);
    SwapField(ehdr.e_shoff);
    SwapField(ehdr.e_flags);
    SwapField(ehdr.e_ehsize);
    SwapField(ehdr.e_phentsize);
    SwapField(ehdr.e_phnum);
    SwapField(ehdr.e_shentsize);
    SwapField(ehdr.e_shnum);
    SwapField(ehdr.e_shstrndx);
}

void NormalizeForBigEndian(Elf64_Shdr& shdr)
{
    SwapField(shdr.sh_name);
    SwapField(shdr.sh_type);
    SwapField(shdr.sh_flags);
    SwapField(shdr.sh_addr);
    SwapField(shdr.sh_offset);
    SwapField(shdr.sh_size);
    SwapField(shdr.sh_link);
    SwapField(shdr.sh_info);
    SwapField(shdr.sh_addralign);
    SwapField(shdr.sh_entsize);
}

void NormalizeForBigEndian(Elf64_Sym& sym)
{
    sym.st_name = Swap32(sym.st_name);
    sym.st_shndx = Swap16(sym.st_shndx);
    sym.st_value = Swap64(sym.st_value);
    sym.st_size = Swap64(sym.st_size);
}

template <typename T>
bool WriteStruct(std::vector<char>& data, size_t offset, T value, bool bigEndian)
{
    if (bigEndian) {
        NormalizeForBigEndian(value);
    }
    ResizeForWrite(data, offset, sizeof(T));
    const errno_t ret = memcpy_s(data.data() + offset, data.size() - offset, &value, sizeof(T));
    if (ret != EOK) {
        return false;
    }
    return true;
}

bool WriteBytes(std::vector<char>& data, size_t offset, const void* src, size_t len)
{
    ResizeForWrite(data, offset, len);
    const errno_t ret = memcpy_s(data.data() + offset, data.size() - offset, src, len);
    if (ret != EOK) {
        return false;
    }
    return true;
}

void BuildSymbolTable(const std::vector<SymbolSpec>& symbols, std::string& strtab, std::vector<Elf64_Sym>& elfSymbols)
{
    strtab.assign(1U, '\0');
    elfSymbols.clear();
    Elf64_Sym nullSym = {};
    elfSymbols.push_back(nullSym);
    for (const SymbolSpec& spec : symbols) {
        Elf64_Sym sym = {};
        const uint32_t offset = static_cast<uint32_t>(strtab.size());
        strtab.append(spec.name);
        strtab.push_back('\0');
        sym.st_name = spec.overrideNameOffset ? spec.nameOffset : offset;
        sym.st_info = ELF64_ST_INFO(spec.bind, spec.type);
        sym.st_other = spec.other;
        sym.st_shndx = spec.shndx;
        sym.st_value = spec.value;
        sym.st_size = spec.size;
        elfSymbols.push_back(sym);
    }
}

void FillElfHeader(Elf64_Ehdr& ehdr, bool bigEndian, size_t shoff, uint16_t sectionNum)
{
    ehdr = {};
    ehdr.e_ident[EI_MAG0] = ELFMAG0;
    ehdr.e_ident[EI_MAG1] = ELFMAG1;
    ehdr.e_ident[EI_MAG2] = ELFMAG2;
    ehdr.e_ident[EI_MAG3] = ELFMAG3;
    ehdr.e_ident[EI_CLASS] = ELFCLASS64;
    ehdr.e_ident[EI_DATA] = bigEndian ? ELFDATA2MSB : ELFDATA2LSB;
    ehdr.e_ident[EI_VERSION] = EV_CURRENT;
    ehdr.e_type = ET_REL;
    ehdr.e_machine = EM_X86_64;
    ehdr.e_version = EV_CURRENT;
    ehdr.e_ehsize = sizeof(Elf64_Ehdr);
    ehdr.e_shentsize = sizeof(Elf64_Shdr);
    ehdr.e_shoff = shoff;
    ehdr.e_shnum = sectionNum;
    ehdr.e_shstrndx = SHN_UNDEF;
}

void FillSections(
    std::vector<Elf64_Shdr>& sections, bool includeSymtab, bool invalidSymEntSize, bool invalidStrtabType,
    size_t textOffset, size_t textSize, size_t symtabOffset, size_t symtabSize, size_t strtabOffset, size_t strtabSize)
{
    sections[1].sh_type = SHT_PROGBITS;
    sections[1].sh_flags = SHF_ALLOC | SHF_EXECINSTR;
    sections[1].sh_offset = textOffset;
    sections[1].sh_size = textSize;
    sections[1].sh_addralign = 16U;
    if (!includeSymtab) {
        return;
    }
    sections[2].sh_type = SHT_SYMTAB;
    sections[2].sh_offset = symtabOffset;
    sections[2].sh_size = symtabSize;
    sections[2].sh_link = 3U;
    sections[2].sh_addralign = 8U;
    sections[2].sh_entsize = invalidSymEntSize ? sizeof(Elf64_Sym) - 1U : sizeof(Elf64_Sym);
    sections[3].sh_type = invalidStrtabType ? SHT_PROGBITS : SHT_STRTAB;
    sections[3].sh_offset = strtabOffset;
    sections[3].sh_size = strtabSize;
    sections[3].sh_addralign = 1U;
}

std::string MakeElf(
    const std::vector<SymbolSpec>& symbols, bool bigEndian = false, bool includeSymtab = true,
    bool invalidSymEntSize = false, bool invalidStrtabType = false)
{
    std::string strtab;
    std::vector<Elf64_Sym> elfSymbols;
    BuildSymbolTable(symbols, strtab, elfSymbols);
    const size_t textOffset = Align(sizeof(Elf64_Ehdr), 16U);
    const size_t textSize = static_cast<size_t>(TEXT_SIZE);
    const size_t symtabOffset = Align(textOffset + textSize, 8U);
    const size_t symtabSize = includeSymtab ? elfSymbols.size() * sizeof(Elf64_Sym) : 0U;
    const size_t strtabOffset = Align(symtabOffset + symtabSize, 8U);
    const size_t strtabSize = strtab.size();
    const size_t shoff = Align(strtabOffset + strtabSize, 8U);
    const uint16_t sectionNum = includeSymtab ? 4U : 2U;

    std::vector<Elf64_Shdr> sections(sectionNum);
    FillSections(
        sections, includeSymtab, invalidSymEntSize, invalidStrtabType, textOffset, textSize, symtabOffset, symtabSize,
        strtabOffset, strtabSize);

    Elf64_Ehdr ehdr = {};
    FillElfHeader(ehdr, bigEndian, shoff, sectionNum);

    std::vector<char> data;
    if (!WriteStruct(data, 0, ehdr, bigEndian)) {
        return {};
    }
    ResizeForWrite(data, textOffset, textSize);
    if (includeSymtab) {
        for (size_t i = 0; i < elfSymbols.size(); i++) {
            if (!WriteStruct(data, symtabOffset + i * sizeof(Elf64_Sym), elfSymbols[i], bigEndian)) {
                return {};
            }
        }
        if (!WriteBytes(data, strtabOffset, strtab.data(), strtab.size())) {
            return {};
        }
    }
    for (size_t i = 0; i < sections.size(); i++) {
        if (!WriteStruct(data, shoff + i * sizeof(Elf64_Shdr), sections[i], bigEndian)) {
            return {};
        }
    }
    return std::string(data.data(), data.size());
}

std::vector<SymbolSpec> ValidSymbols()
{
    std::vector<SymbolSpec> symbols;
    symbols.push_back({"hidden_mix_aic", STB_GLOBAL, STT_FUNC, 0x20ULL, 0x10ULL, 1U, STV_HIDDEN, false, 0U});
    symbols.push_back({"kernel_mix_aic", STB_GLOBAL, STT_FUNC, 0x100ULL, 0x40ULL, 1U, STV_DEFAULT, false, 0U});
    symbols.push_back({"kernel_mix_aiv", STB_GLOBAL, STT_FUNC, 0x300ULL, 0x30ULL, 1U, STV_DEFAULT, false, 0U});
    symbols.push_back({"zero_size_func", STB_LOCAL, STT_FUNC, 0x180ULL, 0ULL, 1U, STV_DEFAULT, false, 0U});
    symbols.push_back({"next_func", STB_LOCAL, STT_FUNC, 0x1C0ULL, 0x20ULL, 1U, STV_DEFAULT, false, 0U});
    symbols.push_back({"dup_func", STB_GLOBAL, STT_FUNC, 0x240ULL, 0x20ULL, 1U, STV_DEFAULT, false, 0U});
    symbols.push_back({"dup_func", STB_GLOBAL, STT_FUNC, 0x240ULL, 0x20ULL, 1U, STV_DEFAULT, false, 0U});
    symbols.push_back({"object_symbol", STB_GLOBAL, STT_OBJECT, 0x280ULL, 0x20ULL, 1U, STV_DEFAULT, false, 0U});
    symbols.push_back({"undef_func", STB_GLOBAL, STT_FUNC, 0x2A0ULL, 0x20ULL, SHN_UNDEF, STV_DEFAULT, false, 0U});
    symbols.push_back({"bad_section_func", STB_GLOBAL, STT_FUNC, 0x2C0ULL, 0x20ULL, 99U, STV_DEFAULT, false, 0U});
    symbols.push_back({"bad_name_func", STB_GLOBAL, STT_FUNC, 0x2E0ULL, 0x20ULL, 1U, STV_DEFAULT, true, 0xFFFFFFF0U});
    symbols.push_back({"", STB_GLOBAL, STT_FUNC, 0x340ULL, 0x20ULL, 1U, STV_DEFAULT, false, 0U});
    return symbols;
}

rtExceptionErrRegInfo_t MakeCore(uint32_t coreId, rtCoreType_t coreType, uint64_t startPc, uint64_t currentPc)
{
    rtExceptionErrRegInfo_t core = {};
    core.coreId = coreId;
    core.coreType = coreType;
    core.startPC = startPc;
    core.currentPC = currentPc;
    return core;
}

int32_t MockGetBinDataFromHandle(rtBinHandle binHandle, std::string& binData, uint32_t& binSize)
{
    (void)binHandle;
    binData = g_mockElf;
    binSize = static_cast<uint32_t>(g_mockElf.size());
    return ADUMP_SUCCESS;
}

rtError_t RtsBinaryGetDevAddressSuccess(const rtBinHandle binHandle, void** bin, uint32_t* binSize)
{
    (void)binHandle;
    if (bin != nullptr) {
        *bin = reinterpret_cast<void*>(static_cast<uintptr_t>(0x1000U));
    }
    if (binSize != nullptr) {
        *binSize = 0x800U;
    }
    return RT_ERROR_NONE;
}

rtError_t RtsBinaryGetDevAddressNullAddr(const rtBinHandle binHandle, void** bin, uint32_t* binSize)
{
    (void)binHandle;
    if (bin != nullptr) {
        *bin = nullptr;
    }
    if (binSize != nullptr) {
        *binSize = 0U;
    }
    return RT_ERROR_NONE;
}

void InitAicoreException(rtExceptionInfo& exception, rtBinHandle binHandle, const std::string& kernelName)
{
    exception = {};
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    rtExceptionKernelInfo_t& kernelInfo = exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo;
    kernelInfo.bin = binHandle;
    kernelInfo.kernelName = kernelName.c_str();
    kernelInfo.kernelNameSize = static_cast<uint32_t>(kernelName.size());
}

class KernelSymbolLocatorUTest : public testing::Test {
protected:
    void SetUp() override
    {
        g_mockElf.clear();
        KernelSymbolLocator::ClearCache();
        PcFixerFactory::instance_.reset();
        Adx::ResetAllPlatformManagers();
    }

    void TearDown() override
    {
        g_mockElf.clear();
        KernelSymbolLocator::ClearCache();
        PcFixerFactory::instance_.reset();
        Adx::ResetAllPlatformManagers();
        GlobalMockObject::verify();
    }
};
} // namespace

TEST_F(KernelSymbolLocatorUTest, InitFromBinBufferRejectsInvalidInputs)
{
    KernelSymbolLocator locator;
    EXPECT_EQ(ADUMP_FAILED, locator.InitFromBinBuffer(""));
    EXPECT_EQ(ADUMP_FAILED, locator.InitFromBinBuffer("bad elf"));
    EXPECT_FALSE(locator.initialized_);

    KernelSymbolSet symbols;
    EXPECT_EQ(ADUMP_FAILED, locator.ParseElfSymbols(nullptr, 0, symbols));

    std::string noSymtabElf = MakeElf({}, false, false);
    EXPECT_EQ(ADUMP_FAILED, locator.InitFromBinBuffer(noSymtabElf));

    std::string invalidSymtabElf = MakeElf(ValidSymbols(), false, true, true, false);
    EXPECT_EQ(ADUMP_FAILED, locator.InitFromBinBuffer(invalidSymtabElf));

    std::string invalidStrtabElf = MakeElf(ValidSymbols(), false, true, false, true);
    EXPECT_EQ(ADUMP_FAILED, locator.InitFromBinBuffer(invalidStrtabElf));
}

TEST_F(KernelSymbolLocatorUTest, InitFromBinBufferParsesAndNormalizesLittleEndianElf)
{
    KernelSymbolLocator locator;
    std::string elf = MakeElf(ValidSymbols());

    ASSERT_EQ(ADUMP_SUCCESS, locator.InitFromBinBuffer(elf));
    EXPECT_TRUE(locator.initialized_);
    EXPECT_EQ(6U, locator.kernelSymbols_.symbols.size());

    const auto it = std::find_if(
        locator.kernelSymbols_.symbols.begin(), locator.kernelSymbols_.symbols.end(),
        [](const KernelSymbol& symbol) { return symbol.name == "zero_size_func"; });
    ASSERT_NE(locator.kernelSymbols_.symbols.end(), it);
    EXPECT_EQ(0x40ULL, it->size);
}

TEST_F(KernelSymbolLocatorUTest, InitFromBinBufferParsesBigEndianElf)
{
    KernelSymbolLocator locator;
    std::string elf = MakeElf(ValidSymbols(), true);

    ASSERT_EQ(ADUMP_SUCCESS, locator.InitFromBinBuffer(elf));
    EXPECT_FALSE(locator.kernelSymbols_.symbols.empty());
}

TEST_F(KernelSymbolLocatorUTest, InitFromBinHandleUsesCacheAndRejectsNullHandle)
{
    KernelSymbolLocator locator;
    EXPECT_EQ(ADUMP_FAILED, locator.InitFromBinHandle(nullptr));

    g_mockElf = MakeElf(ValidSymbols());
    rtBinHandle handle = reinterpret_cast<rtBinHandle>(0x1234);
    MOCKER_CPP(&ExceptionInfoCommon::GetBinDataFromHandle).stubs().will(invoke(MockGetBinDataFromHandle));

    ASSERT_EQ(ADUMP_SUCCESS, locator.InitFromBinHandle(handle));
    KernelSymbolLocator cachedLocator;
    EXPECT_EQ(ADUMP_SUCCESS, cachedLocator.InitFromBinHandle(handle));
    EXPECT_TRUE(cachedLocator.initialized_);
    EXPECT_EQ(locator.kernelSymbols_.symbols.size(), cachedLocator.kernelSymbols_.symbols.size());
}

TEST_F(KernelSymbolLocatorUTest, GetKernelDeviceAddrUsesRtsDevAddress)
{
    rtBinHandle handle = reinterpret_cast<rtBinHandle>(0x1234);
    void* devAddr = nullptr;
    MOCKER(rtsBinaryGetDevAddress).expects(once()).will(invoke(RtsBinaryGetDevAddressSuccess));
    EXPECT_EQ(ADUMP_SUCCESS, ExceptionInfoCommon::GetKernelDeviceAddr(handle, devAddr));
    EXPECT_EQ(reinterpret_cast<void*>(static_cast<uintptr_t>(0x1000U)), devAddr);
    GlobalMockObject::verify();

    devAddr = reinterpret_cast<void*>(static_cast<uintptr_t>(0x2000U));
    MOCKER(rtsBinaryGetDevAddress).expects(once()).will(invoke(RtsBinaryGetDevAddressNullAddr));
    EXPECT_EQ(ADUMP_FAILED, ExceptionInfoCommon::GetKernelDeviceAddr(handle, devAddr));
    EXPECT_EQ(nullptr, devAddr);
}

TEST_F(KernelSymbolLocatorUTest, UpdateStartPCFromDeviceAddrIgnoresErrRegStartPC)
{
    KernelSymbolLocator locator;
    ASSERT_EQ(ADUMP_SUCCESS, locator.InitFromBinBuffer(MakeElf(ValidSymbols())));

    rtBinHandle handle = reinterpret_cast<rtBinHandle>(0x1234);
    MOCKER(rtsBinaryGetDevAddress).expects(once()).will(invoke(RtsBinaryGetDevAddressSuccess));
    locator.UpdateStartPCFromDeviceAddr(handle);
    EXPECT_TRUE(locator.hasKernelDeviceStartPC_);
    EXPECT_EQ(0x1000ULL, locator.kernelDeviceStartPC_);

    uint64_t fixedStartPC = 0;
    rtExceptionErrRegInfo_t core = MakeCore(0U, RT_CORE_TYPE_AIC, 0x5000ULL, 0x1120ULL);
    EXPECT_TRUE(locator.GetCorrectedStartPC(core, fixedStartPC));
    EXPECT_EQ(0x1000ULL, fixedStartPC);
}

TEST_F(KernelSymbolLocatorUTest, LocateAndPrintRejectsInvalidStateAndInputs)
{
    KernelSymbolLocator locator;
    ExceptionRegInfo regInfo{0U, nullptr};
    std::vector<ErrorLocation> locations;
    ErrorLocation singleLocation;
    EXPECT_EQ(ADUMP_FAILED, locator.LocateErrorSymbols(regInfo, locations));
    EXPECT_EQ(ADUMP_FAILED, locator.LocateErrorSymbolsForCore(0U, RT_CORE_TYPE_AIC, regInfo, singleLocation));

    ASSERT_EQ(ADUMP_SUCCESS, locator.InitFromBinBuffer(MakeElf(ValidSymbols())));
    EXPECT_EQ(ADUMP_FAILED, locator.LocateErrorSymbols(regInfo, locations));

    rtExceptionErrRegInfo_t core = MakeCore(1U, RT_CORE_TYPE_AIC, 0x1000ULL, 0x1010ULL);
    ExceptionRegInfo singleCoreRegInfo{1U, &core};
    EXPECT_EQ(ADUMP_FAILED, locator.LocateErrorSymbolsForCore(2U, RT_CORE_TYPE_AIC, singleCoreRegInfo, singleLocation));
}

TEST_F(KernelSymbolLocatorUTest, LocateAndPrintCoversMatchedNoMatchedAndLowFixedPcBranches)
{
    KernelSymbolLocator locator;
    ASSERT_EQ(ADUMP_SUCCESS, locator.InitFromBinBuffer(MakeElf(ValidSymbols())));

    uint32_t v2Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2Type)).will(returnValue(true));

    rtExceptionErrRegInfo_t cores[3] = {
        MakeCore(0U, RT_CORE_TYPE_AIC, 0x1000ULL, 0x1000ULL),
        MakeCore(1U, RT_CORE_TYPE_AIV, 0x1000ULL, 0x1010ULL),
        MakeCore(2U, RT_CORE_TYPE_AIC, 0x2000ULL, 0x1000ULL),
    };
    ExceptionRegInfo regInfo{3U, cores};
    std::vector<ErrorLocation> locations;
    ErrorLocation singleLocation;
    EXPECT_EQ(ADUMP_SUCCESS, locator.LocateErrorSymbols(regInfo, locations));
    EXPECT_EQ(ADUMP_SUCCESS, locator.LocateErrorSymbolsForCore(1U, RT_CORE_TYPE_AIV, regInfo, singleLocation));
}

TEST_F(KernelSymbolLocatorUTest, LocateAndPrintNormalCloudV2)
{
    KernelSymbolLocator locator;
    ASSERT_EQ(ADUMP_SUCCESS, locator.InitFromBinBuffer(MakeElf(ValidSymbols())));

    uint32_t v2Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2Type)).will(returnValue(true));

    rtExceptionErrRegInfo_t core = MakeCore(0U, RT_CORE_TYPE_AIC, 0ULL, 0ULL);
    core.errReg[RT_V100_AIC_ERR_0] = 1U << 9U;
    core.errReg[RT_V100_CUBE_ERR_0] = 0U;
    ExceptionRegInfo regInfo{1U, &core};
    std::vector<ErrorLocation> locations;
    EXPECT_EQ(ADUMP_SUCCESS, locator.LocateErrorSymbols(regInfo, locations));
}

TEST_F(KernelSymbolLocatorUTest, LocateAndPrintNormalCloudV4)
{
    KernelSymbolLocator locator;
    ASSERT_EQ(ADUMP_SUCCESS, locator.InitFromBinBuffer(MakeElf(ValidSymbols())));

    uint32_t v4Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4Type)).will(returnValue(true));

    rtExceptionErrRegInfo_t core = MakeCore(0U, RT_CORE_TYPE_AIC, 0ULL, 0ULL);
    core.errReg[RT_V200_SU_ERROR_T0_0] = 1U;
    core.errReg[RT_V200_SU_ERR_INFO_T0_0] = 0U;
    ExceptionRegInfo regInfo{1U, &core};
    std::vector<ErrorLocation> locations;
    EXPECT_EQ(ADUMP_SUCCESS, locator.LocateErrorSymbols(regInfo, locations));
}

TEST_F(KernelSymbolLocatorUTest, GetErrorRegisterItemsAndJoinedStrStayConsistent)
{
    rtExceptionErrRegInfo_t noFixerCore = MakeCore(0U, RT_CORE_TYPE_AIC, 0ULL, 0ULL);
    EXPECT_TRUE(KernelSymbolLocator::GetErrorRegisterItems(noFixerCore).empty());
    EXPECT_EQ("", KernelSymbolLocator::GetErrorRegisters(noFixerCore));

    uint32_t v5Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V5);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v5Type)).will(returnValue(true));
    rtExceptionErrRegInfo_t core = MakeCore(0U, RT_CORE_TYPE_AIC, 0ULL, 0ULL);
    for (uint32_t i = 0; i < RT_ERR_REG_NUMS; i++) {
        core.errReg[i] = 0xDEADBEEFU;
    }

    // V5 沿用 V200_REG_NAMES，共 40 项，单项不含分隔空格。
    const std::vector<std::string> items = KernelSymbolLocator::GetErrorRegisterItems(core);
    ASSERT_EQ(40U, items.size());
    // 本地副本传参：避免按引用 ODR-use 类内 static constexpr 成员。
    const size_t itemMaxLen = PcFixerInterface::REG_ITEM_MAX_LEN;
    for (const std::string& item : items) {
        EXPECT_EQ(std::string::npos, item.find(' '));
        EXPECT_GE(itemMaxLen, item.size() + 1U);
    }

    // 整串等价于逐项以空格拼接，避免两个入口输出漂移。
    std::string joined;
    for (const std::string& item : items) {
        joined += item + " ";
    }
    EXPECT_EQ(joined, KernelSymbolLocator::GetErrorRegisters(core));
}

TEST_F(KernelSymbolLocatorUTest, BuildRegisterLinesSplitsByFixedCountAndBoundsLineLength)
{
    const size_t numPerLine = KernelSymbolLocator::REG_NUM_PER_LINE;
    const size_t itemMaxLen = PcFixerInterface::REG_ITEM_MAX_LEN;

    EXPECT_TRUE(KernelSymbolLocator::BuildRegisterLines({}).empty());

    // 未满一行：只出一行。
    auto lines = KernelSymbolLocator::BuildRegisterLines({"A=0x1", "B=0x2"});
    ASSERT_EQ(1U, lines.size());
    EXPECT_EQ("A=0x1 B=0x2 ", lines[0]);

    std::vector<std::string> exact(numPerLine, "R=0x1");
    EXPECT_EQ(1U, KernelSymbolLocator::BuildRegisterLines(exact).size());
    std::vector<std::string> exactTwice(numPerLine * 2U, "R=0x1");
    EXPECT_EQ(2U, KernelSymbolLocator::BuildRegisterLines(exactTwice).size());

    // 40 项应切成 4 行：12/12/12/4，不丢项且行长在上限内。
    std::vector<std::string> items;
    for (size_t i = 0; i < 40U; ++i) {
        items.push_back("SU_SPR_CONDITION_0=0xdeadbeef");
    }
    lines = KernelSymbolLocator::BuildRegisterLines(items);
    ASSERT_EQ(4U, lines.size());
    size_t totalItems = 0;
    for (const std::string& line : lines) {
        // 行长上限保证加上日志头后不触发 slog 截断。
        EXPECT_GE(numPerLine * itemMaxLen, line.size());
        totalItems += static_cast<size_t>(std::count(line.begin(), line.end(), ' '));
    }
    EXPECT_EQ(40U, totalItems);
    EXPECT_EQ(numPerLine, static_cast<size_t>(std::count(lines[0].begin(), lines[0].end(), ' ')));
    EXPECT_EQ(4U, static_cast<size_t>(std::count(lines[3].begin(), lines[3].end(), ' ')));
}

TEST_F(KernelSymbolLocatorUTest, PrintErrorRegistersSplitsByFixedRegisterCount)
{
    // 列表为空时仍打印一条，便于确认该核已处理。
    KernelSymbolLocator::PrintErrorRegisters(0U, static_cast<uint32_t>(RT_CORE_TYPE_AIC), {});

    KernelSymbolLocator::PrintErrorRegisters(0U, static_cast<uint32_t>(RT_CORE_TYPE_AIC), {"A=0x1", "B=0x2"});

    // 满寄存器场景：40 项按 12 个/行切成 4 行。
    uint32_t v5Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V5);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v5Type)).will(returnValue(true));
    rtExceptionErrRegInfo_t core = MakeCore(0U, RT_CORE_TYPE_AIC, 0ULL, 0ULL);
    for (uint32_t i = 0; i < RT_ERR_REG_NUMS; i++) {
        core.errReg[i] = 0xDEADBEEFU;
    }
    const std::vector<std::string> items = KernelSymbolLocator::GetErrorRegisterItems(core);
    ASSERT_FALSE(items.empty());
    // 整串超过 slog 单条上限，故必须分行。
    EXPECT_LT(1024U, KernelSymbolLocator::GetErrorRegisters(core).size());
    EXPECT_EQ(4U, KernelSymbolLocator::BuildRegisterLines(items).size());
    KernelSymbolLocator::PrintErrorRegisters(core.coreId, static_cast<uint32_t>(core.coreType), items);
}

TEST_F(KernelSymbolLocatorUTest, StaticPcHelpersUseFactoryResult)
{
    rtExceptionErrRegInfo_t core = MakeCore(0U, RT_CORE_TYPE_AIC, 0, 0);
    core.currentPC = TEST_PC;
    EXPECT_EQ(TEST_PC, KernelSymbolLocator::FixPcByErrorRegs(core));

    uint32_t v4Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4Type)).will(returnValue(true));
    core.errReg[RT_V200_SU_ERROR_T0_0] = 1U;
    core.errReg[RT_V200_SU_ERR_INFO_T0_0] = 0x1234U;
    EXPECT_EQ((TEST_PC & ~0x3FFFCULL) | 0x48D0ULL, KernelSymbolLocator::FixPcByErrorRegs(core));
}

TEST_F(KernelSymbolLocatorUTest, DumpErrorSymbolsCoversFailureAndSuccessPaths)
{
    rtExceptionInfo exception = {};
    const std::string kernelName = "kernel_mix_aic";
    rtBinHandle handle = reinterpret_cast<rtBinHandle>(0x1234);
    InitAicoreException(exception, handle, kernelName);
    rtExceptionErrRegInfo_t core = MakeCore(0U, RT_CORE_TYPE_AIC, 0ULL, 0ULL);
    ExceptionRegInfo regInfo{1U, &core};

    const std::string dumpPath = "./";
    MOCKER_CPP(&ExceptionInfoCommon::GetBinDataFromHandle).stubs().will(returnValue(ADUMP_FAILED));
    KernelSymbolLocator::DumpErrorSymbols(exception, regInfo, dumpPath);
    GlobalMockObject::verify();

    g_mockElf = MakeElf(ValidSymbols());
    MOCKER_CPP(&ExceptionInfoCommon::GetBinDataFromHandle).stubs().will(invoke(MockGetBinDataFromHandle));
    uint32_t v2Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2Type)).will(returnValue(true));
    KernelSymbolLocator::DumpErrorSymbols(exception, regInfo, dumpPath);
    GlobalMockObject::verify();

    MOCKER_CPP(&ExceptionInfoCommon::GetExceptionRegInfo).stubs().will(returnValue(ADUMP_FAILED));
    KernelSymbolLocator::DumpErrorSymbols(exception, dumpPath);
}
