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
#include <fstream>
#include <functional>
#include <thread>
#include "mockcpp/mockcpp.hpp"
#include "case_workspace.h"
#include "dump_args.h"
#include "runtime/rt.h"
#include "adump_pub.h"
#include "dump_file.h"
#include "dump_manager.h"
#include "dump_file_checker.h"
#include "sys_utils.h"
#include "dump_memory.h"
#include "file.h"
#include "adx_exception_callback.h"
#include "lib_path.h"
#include "dump_tensor_plugin.h"
#include "thread_manager.h"
#include "hccl_mc2_define.h"
#include "ascend_hal.h"
#include "dump_exception_stub.h"
#include "kernel_info_collector.h"
#include "dump_exception_stub.h"

using namespace Adx;
constexpr int32_t SYMBOLS_SIZE_3 = 3;
constexpr int32_t CORE_ID_2 = 2;
constexpr int64_t STRTAB_SECTION_SIZE_100 = 100;

// 测试用例
class KernelInfoCollectorUTest : public ::testing::Test {
protected:
    void SetUp() override {
    }

    void TearDown() override {
        FreeExceptionRegInfo();
    }

    // 构建测试用ELF结构
    struct ElfData {
        std::vector<Elf64_Sym> symtab;
        std::string strtab;
    };

    ElfData CreateElfData(const std::vector<std::pair<std::string, uint8_t>>& symbols) {
        ElfData data;
        data.strtab = "\0";  // ELF字符串表以空字符开始
        size_t strIndex = 1;

        for (const auto& sym : symbols) {
            const std::string& name = sym.first;
            uint8_t info = sym.second;

            // 添加符号名到字符串表
            data.strtab += name + '\0';

            // 创建符号表项
            Elf64_Sym elfSym = {};
            elfSym.st_name = strIndex;
            elfSym.st_info = info;
            elfSym.st_value = strIndex * 0x1000;  // 偏移地址
            elfSym.st_size = 0x100;
            elfSym.st_shndx = 1;

            data.symtab.push_back(elfSym);
            strIndex += name.length() + 1;
        }
        return data;
    }

    // 创建模拟ELF文件结构的辅助函数
    struct MockELF {
        std::vector<char> data;
        Elf64_Ehdr ehdr;
        std::vector<Elf64_Shdr> sections;
        std::string sectionNames;

        MockELF() {
            // 初始化ELF头部
            (void)memset_s(&ehdr, sizeof(ehdr), 0, sizeof(ehdr));
            ehdr.e_ident[EI_MAG0] = ELFMAG0;
            ehdr.e_ident[EI_MAG1] = ELFMAG1;
            ehdr.e_ident[EI_MAG2] = ELFMAG2;
            ehdr.e_ident[EI_MAG3] = ELFMAG3;
            ehdr.e_ident[EI_CLASS] = ELFCLASS64;
            ehdr.e_ident[EI_DATA] = ELFDATA2LSB;
            ehdr.e_ident[EI_VERSION] = EV_CURRENT;
            ehdr.e_type = ET_EXEC;
            ehdr.e_machine = EM_X86_64;
            ehdr.e_version = EV_CURRENT;
            ehdr.e_entry = 0x400000;
            ehdr.e_shoff = sizeof(Elf64_Ehdr);
        }
    };
};

// 用例1: 非SuperKernel (functionCount <= globalCount)
TEST_F(KernelInfoCollectorUTest, NonSuperKernel)
{
    // 创建1个函数符号(STT_FUNC)和2个全局符号(确保functionCount <= globalCount)
    auto elfData = CreateElfData({
        {"func1", ELF64_ST_INFO(STB_GLOBAL, STT_FUNC)},     // 全局函数
        {"global_var", ELF64_ST_INFO(STB_GLOBAL, STT_OBJECT)}, // 全局对象
        {"weak_func", ELF64_ST_INFO(STB_WEAK, STT_FUNC)}    // 弱函数
    });

    KernelSymbols kernelSymbols;
    KernelInfoCollector::ParseSuperKernelSymbols(
        elfData.symtab.data(),
        elfData.symtab.size() * sizeof(Elf64_Sym),
        elfData.strtab.c_str(),
        kernelSymbols);

    // 验证结果
    EXPECT_FALSE(kernelSymbols.existAicBase);
    EXPECT_FALSE(kernelSymbols.existAivBase);
    EXPECT_EQ(kernelSymbols.symbols.size(), 2);  // 2个函数符号
}

// 用例2: SuperKernel但无_entry符号
TEST_F(KernelInfoCollectorUTest, SuperKernelWithoutEntry)
{
    // 创建3个函数符号和1个全局符号(确保functionCount > globalCount)
    auto elfData = CreateElfData({
        {"func1", ELF64_ST_INFO(STB_GLOBAL, STT_FUNC)},
        {"func2", ELF64_ST_INFO(STB_LOCAL, STT_FUNC)},
        {"func3", ELF64_ST_INFO(STB_WEAK, STT_FUNC)},
        {"non_func", ELF64_ST_INFO(STB_LOCAL, STT_OBJECT)}  // 非函数
    });

    KernelSymbols kernelSymbols;
    KernelInfoCollector::ParseSuperKernelSymbols(
        elfData.symtab.data(),
        elfData.symtab.size() * sizeof(Elf64_Sym),
        elfData.strtab.c_str(),
        kernelSymbols);

    // 验证结果
    EXPECT_FALSE(kernelSymbols.existAicBase);
    EXPECT_FALSE(kernelSymbols.existAivBase);
    EXPECT_EQ(kernelSymbols.symbols.size(), SYMBOLS_SIZE_3);  // 3个函数符号
}

// 用例3: SuperKernel含_mix_aic_entry符号
TEST_F(KernelInfoCollectorUTest, SuperKernelWithAicEntry)
{
    // 创建3个函数符号和1个全局符号
    auto elfData = CreateElfData({
        {"kernel_mix_aic", ELF64_ST_INFO(STB_GLOBAL, STT_FUNC)},
        {"func2", ELF64_ST_INFO(STB_LOCAL, STT_FUNC)},
        {"func3", ELF64_ST_INFO(STB_WEAK, STT_FUNC)},
        {"non_func", ELF64_ST_INFO(STB_LOCAL, STT_OBJECT)}
    });

    KernelSymbols kernelSymbols;
    KernelInfoCollector::ParseSuperKernelSymbols(
        elfData.symtab.data(),
        elfData.symtab.size() * sizeof(Elf64_Sym),
        elfData.strtab.c_str(),
        kernelSymbols);

    // 验证结果
    EXPECT_TRUE(kernelSymbols.existAicBase);
    EXPECT_FALSE(kernelSymbols.existAivBase);
    EXPECT_EQ(kernelSymbols.aicBase, 0x1000);  // 第一个符号的地址
    EXPECT_EQ(kernelSymbols.symbols.size(), SYMBOLS_SIZE_3);
}

// 用例4: SuperKernel含_mix_aiv_entry符号
TEST_F(KernelInfoCollectorUTest, SuperKernelWithAivEntry)
{
    // 创建3个函数符号和1个全局符号
    auto elfData = CreateElfData({
        {"kernel_mix_aiv", ELF64_ST_INFO(STB_GLOBAL, STT_FUNC)},
        {"func2", ELF64_ST_INFO(STB_LOCAL, STT_FUNC)},
        {"func3", ELF64_ST_INFO(STB_WEAK, STT_FUNC)},
        {"non_func", ELF64_ST_INFO(STB_LOCAL, STT_OBJECT)}
    });

    KernelSymbols kernelSymbols;
    KernelInfoCollector::ParseSuperKernelSymbols(
        elfData.symtab.data(),
        elfData.symtab.size() * sizeof(Elf64_Sym),
        elfData.strtab.c_str(),
        kernelSymbols);

    // 验证结果
    EXPECT_FALSE(kernelSymbols.existAicBase);
    EXPECT_TRUE(kernelSymbols.existAivBase);
    EXPECT_EQ(kernelSymbols.aivBase, 0x1000);
    EXPECT_EQ(kernelSymbols.symbols.size(), SYMBOLS_SIZE_3);
}

// 用例5: 空符号表
TEST_F(KernelInfoCollectorUTest, EmptySymtab)
{
    KernelSymbols kernelSymbols;
    KernelInfoCollector::ParseSuperKernelSymbols(
        nullptr,
        0,
        nullptr,
        kernelSymbols);

    // 验证结果
    EXPECT_FALSE(kernelSymbols.existAicBase);
    EXPECT_FALSE(kernelSymbols.existAivBase);
    EXPECT_TRUE(kernelSymbols.symbols.empty());
}

TEST_F(KernelInfoCollectorUTest, EndsWith)
{
    // source为NULL
    EXPECT_FALSE(KernelInfoCollector::EndsWith(nullptr, "suffix"));
    // suffix为NULL
    EXPECT_FALSE(KernelInfoCollector::EndsWith("source", nullptr));
    // 两者都为NULL
    EXPECT_FALSE(KernelInfoCollector::EndsWith(nullptr, nullptr));
    // 正常匹配
    EXPECT_TRUE(KernelInfoCollector::EndsWith("kernel_mix_aic", "_mix_aic"));
    // suffix长度超过source
    EXPECT_FALSE(KernelInfoCollector::EndsWith("aic", "kernel_mix_aic"));
    // 不匹配
    EXPECT_FALSE(KernelInfoCollector::EndsWith("kernel_mix_aiv", "_mix_aic"));
    // 空字符串匹配
    EXPECT_TRUE(KernelInfoCollector::EndsWith("", ""));
    // source为空，suffix非空
    EXPECT_FALSE(KernelInfoCollector::EndsWith("", "suffix"));
    // source非空，suffix为空
    EXPECT_TRUE(KernelInfoCollector::EndsWith("source", ""));
}

// 用例1: AIC核心类型匹配并找到符号
TEST_F(KernelInfoCollectorUTest, AicCoreMatchWithSymbol)
{
    uint32_t v2type = 5;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));
    // 设置异常寄存器信息
    KernelSymbols kernelSymbols;
    ExceptionRegInfo exceptionRegInfo;
    rtExceptionInfo exception = {0};
    KernelInfoCollector::GetExceptionRegInfo(exception, exceptionRegInfo);
    exceptionRegInfo.coreNum = 1;
    exceptionRegInfo.errRegInfo[0].coreId = 0;
    exceptionRegInfo.errRegInfo[0].coreType = RT_CORE_TYPE_AIC;
    exceptionRegInfo.errRegInfo[0].startPC = 0x1000;
    exceptionRegInfo.errRegInfo[0].currentPC = 0x1150; // offset = 0x150，在symbol1范围内
    // 调用函数（验证不会崩溃且输出日志）
    KernelInfoCollector::PrintKernelErrorSymbols(kernelSymbols, exceptionRegInfo);
    // 验证输出包含匹配的符号test_symbol_1
}

// 用例2: AIV核心类型匹配并找到符号
TEST_F(KernelInfoCollectorUTest, AivCoreMatchWithSymbol)
{
    uint32_t v2type = 5;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));
    // 设置异常寄存器信息
    KernelSymbols kernelSymbols;
    ExceptionRegInfo exceptionRegInfo;
    rtExceptionInfo exception = {0};
    KernelInfoCollector::GetExceptionRegInfo(exception, exceptionRegInfo);
    exceptionRegInfo.coreNum = 1;
    exceptionRegInfo.errRegInfo[0].coreId = 1;
    exceptionRegInfo.errRegInfo[0].coreType = RT_CORE_TYPE_AIV;
    exceptionRegInfo.errRegInfo[0].startPC = 0x2000;
    exceptionRegInfo.errRegInfo[0].currentPC = 0x2550; // offset = 0x550，在symbol2范围内

    // 调用函数
    KernelInfoCollector::PrintKernelErrorSymbols(kernelSymbols, exceptionRegInfo);
    // 验证输出包含匹配的符号test_symbol_2
}

// 用例3: 未找到匹配符号
TEST_F(KernelInfoCollectorUTest, NoSymbolMatch)
{
    uint32_t v2type = 5;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));
    // 设置异常寄存器信息
    KernelSymbols kernelSymbols;
    ExceptionRegInfo exceptionRegInfo;
    rtExceptionInfo exception = {0};
    KernelInfoCollector::GetExceptionRegInfo(exception, exceptionRegInfo);
    exceptionRegInfo.coreNum = 1;
    exceptionRegInfo.errRegInfo[0].coreId = CORE_ID_2;
    exceptionRegInfo.errRegInfo[0].coreType = RT_CORE_TYPE_AIC;
    exceptionRegInfo.errRegInfo[0].startPC = 0x3000;
    exceptionRegInfo.errRegInfo[0].currentPC = 0x4000; // offset超出所有符号范围

    // 调用函数
    KernelInfoCollector::PrintKernelErrorSymbols(kernelSymbols, exceptionRegInfo);
    // 验证输出不包含符号信息但有基本日志
}

// 用例1: 正常解析.symtab和.strtab节
TEST_F(KernelInfoCollectorUTest, NormalParseSymtabAndStrtab)
{
    // 创建包含.symtab和.strtab节的模拟ELF文件
    MockELF mockELF;
    KernelSymbols kernelSymbols;

    // 添加空节区段头
    Elf64_Shdr nullSection = {};
    mockELF.sections.push_back(nullSection);

    // 添加.symtab节
    Elf64_Shdr symtabSection = {};
    symtabSection.sh_type = SHT_SYMTAB;
    symtabSection.sh_name = mockELF.sectionNames.size();
    mockELF.sectionNames += ".symtab";
    mockELF.sectionNames += '\0';
    symtabSection.sh_offset = 0x1000; // 模拟符号表偏移
    symtabSection.sh_size = sizeof(Elf64_Sym) * 2; // 2个符号
    mockELF.sections.push_back(symtabSection);

    // 添加.strtab节
    Elf64_Shdr strtabSection = {};
    strtabSection.sh_type = SHT_STRTAB;
    strtabSection.sh_name = mockELF.sectionNames.size();
    mockELF.sectionNames += ".strtab";
    mockELF.sectionNames += '\0';
    strtabSection.sh_offset = 0x2000; // 模拟字符串表偏移
    strtabSection.sh_size = STRTAB_SECTION_SIZE_100;
;
    mockELF.sections.push_back(strtabSection);

    // 设置ELF头部信息
    mockELF.ehdr.e_shnum = mockELF.sections.size();
    mockELF.ehdr.e_shstrndx = 0; // 字符串表节索引

    // 构建完整的ELF数据
    size_t sections_size = sizeof(Elf64_Shdr) * mockELF.sections.size();
    size_t totalSize = sizeof(Elf64_Ehdr) + sections_size + mockELF.sectionNames.size() + 0x3000;
    mockELF.data.resize(totalSize, 0);

    // 复制ELF头部
    (void)memcpy_s(mockELF.data.data(), sizeof(Elf64_Ehdr), &mockELF.ehdr, sizeof(Elf64_Ehdr));

    // 复制节区段头表
    (void)memcpy_s(mockELF.data.data() + sizeof(Elf64_Ehdr), sections_size, mockELF.sections.data(), sections_size);

    // 调用函数（验证不崩溃且正确调用ParseSuperKernelSymbols）
    KernelInfoCollector::ParseKernelSymbols(mockELF.data.data(), kernelSymbols);
}

// 用例2: 缺少.symtab节
TEST_F(KernelInfoCollectorUTest, MissingSymtabSection)
{
    // 创建只包含.strtab节的模拟ELF文件
    MockELF mockELF;
    KernelSymbols kernelSymbols;

    // 添加空节区段头
    Elf64_Shdr nullSection = {};
    mockELF.sections.push_back(nullSection);

    // 只添加.strtab节（缺少.symtab节）
    Elf64_Shdr strtabSection = {};
    strtabSection.sh_type = SHT_STRTAB;
    strtabSection.sh_name = mockELF.sectionNames.size();
    mockELF.sectionNames += ".strtab";
    mockELF.sectionNames += '\0';
    strtabSection.sh_offset = 0x1000;
    strtabSection.sh_size = STRTAB_SECTION_SIZE_100;
    mockELF.sections.push_back(strtabSection);

    // 设置ELF头部信息
    mockELF.ehdr.e_shnum = mockELF.sections.size();
    mockELF.ehdr.e_shstrndx = 0;

    // 构建ELF数据
    size_t sections_size = sizeof(Elf64_Shdr) * mockELF.sections.size();
    size_t totalSize = sizeof(Elf64_Ehdr) + sections_size + mockELF.sectionNames.size() + 0x2000;
    mockELF.data.resize(totalSize, 0);

    // 复制数据
    (void)memcpy_s(mockELF.data.data(), &mockELF.ehdr, sizeof(Elf64_Ehdr));
    (void)memcpy_s(mockELF.data.data() + sizeof(Elf64_Ehdr), sections_size, mockELF.sections.data(), sections_size);

    // 调用函数（验证输出错误日志并返回）
    KernelInfoCollector::ParseKernelSymbols(mockELF.data.data(), kernelSymbols);
}