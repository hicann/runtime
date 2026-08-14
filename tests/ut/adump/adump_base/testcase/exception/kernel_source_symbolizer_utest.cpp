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
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <elf.h>
#include <fstream>
#include <string>
#include <vector>
#include <unistd.h>
#include "securec.h"
#include "kernel_source_symbolizer.h"
#include "kernel_symbol_locator.h"
#include "tools/case_workspace.h"

using namespace Adx;

namespace {
// 填充最小合法的 ELF64 文件头：magic、64 位小端、section header 表位置与数量。
void FillElfHeader(Elf64_Ehdr &eh, size_t shOff, uint16_t shnum)
{
    eh.e_ident[EI_MAG0] = ELFMAG0;
    eh.e_ident[EI_MAG1] = ELFMAG1;
    eh.e_ident[EI_MAG2] = ELFMAG2;
    eh.e_ident[EI_MAG3] = ELFMAG3;
    eh.e_ident[EI_CLASS] = ELFCLASS64;
    eh.e_ident[EI_DATA] = ELFDATA2LSB;
    eh.e_ident[EI_VERSION] = EV_CURRENT;
    eh.e_type = ET_REL;
    eh.e_machine = EM_AARCH64;
    eh.e_version = EV_CURRENT;
    eh.e_ehsize = sizeof(Elf64_Ehdr);
    eh.e_shentsize = sizeof(Elf64_Shdr);
    eh.e_shoff = shOff;
    eh.e_shnum = shnum;
    eh.e_shstrndx = 1;  // .shstrtab 为第 1 个段
}

// 构造一个最小 ELF64，可选包含名为 sectionName 的段（用于 .debug_line 探测）。
std::string MakeElfWithSection(bool withSection, const std::string &sectionName = ".debug_line")
{
    // 段名字符串表：首字节 '\0'，随后依次是各段名。
    std::string shstr;
    shstr.push_back('\0');
    uint32_t shstrtabNameOff = static_cast<uint32_t>(shstr.size());
    shstr += ".shstrtab";
    shstr.push_back('\0');
    uint32_t targetNameOff = 0;
    if (withSection) {
        targetNameOff = static_cast<uint32_t>(shstr.size());
        shstr += sectionName;
        shstr.push_back('\0');
    }

    const uint16_t shnum = withSection ? 3 : 2;  // NULL + .shstrtab (+ target)
    const size_t shOff = sizeof(Elf64_Ehdr);
    const size_t shstrOff = shOff + static_cast<size_t>(shnum) * sizeof(Elf64_Shdr);
    std::string buf;
    buf.resize(shstrOff + shstr.size(), '\0');

    Elf64_Ehdr eh{};
    FillElfHeader(eh, shOff, shnum);
    (void)memcpy_s(&buf[0], sizeof(eh), &eh, sizeof(eh));

    std::vector<Elf64_Shdr> shdrs(shnum);
    shdrs[0].sh_type = SHT_NULL;  // [0] NULL，sh_name 默认 0
    shdrs[1].sh_name = shstrtabNameOff;  // [1] .shstrtab
    shdrs[1].sh_type = SHT_STRTAB;
    shdrs[1].sh_offset = shstrOff;
    shdrs[1].sh_size = shstr.size();
    if (withSection) {
        shdrs[2].sh_name = targetNameOff;  // [2] target section
        shdrs[2].sh_type = SHT_PROGBITS;
        shdrs[2].sh_offset = shstrOff;  // 复用字符串表数据区，探测只看段名不看内容
        shdrs[2].sh_size = 1;
    }
    for (uint16_t i = 0; i < shnum; ++i) {
        (void)memcpy_s(&buf[shOff + i * sizeof(Elf64_Shdr)], sizeof(Elf64_Shdr), &shdrs[i], sizeof(Elf64_Shdr));
    }
    (void)memcpy_s(&buf[shstrOff], shstr.size(), shstr.data(), shstr.size());
    return buf;
}

void WriteFile(const std::string &path, const std::string &content)
{
    std::ofstream ofs(path, std::ios::binary | std::ios::trunc);
    ofs.write(content.data(), static_cast<std::streamsize>(content.size()));
    ofs.close();
}

// 写一个假的 llvm-symbolizer 脚本：从 stdin 读偏移，按行输出 func 与 file:line:col。
std::string WriteFakeSymbolizer(const std::string &path, const std::string &body)
{
    WriteFile(path, body);
    (void)chmod(path.c_str(), 0755);
    return path;
}

class KernelSourceSymbolizerUTest : public testing::Test {
protected:
    void SetUp() override
    {
        (void)unsetenv("ADUMP_LLVM_SYMBOLIZER");
        KernelSourceSymbolizer::ResetLocateCacheForTest();
    }
    void TearDown() override
    {
        (void)unsetenv("ADUMP_LLVM_SYMBOLIZER");
        KernelSourceSymbolizer::ResetLocateCacheForTest();
    }
};

TEST_F(KernelSourceSymbolizerUTest, HasDebugLineDetectsSection)
{
    Tools::CaseWorkspace ws("HasDebugLineDetectsSection");
    const std::string withPath = ws.Root() + "/with_debug.o";
    const std::string withoutPath = ws.Root() + "/without_debug.o";
    WriteFile(withPath, MakeElfWithSection(true));
    WriteFile(withoutPath, MakeElfWithSection(false));

    EXPECT_TRUE(KernelSourceSymbolizer::HasDebugLine(withPath));
    EXPECT_FALSE(KernelSourceSymbolizer::HasDebugLine(withoutPath));
    EXPECT_FALSE(KernelSourceSymbolizer::HasDebugLine(ws.Root() + "/not_exist.o"));
}

TEST_F(KernelSourceSymbolizerUTest, NotAvailableWhenToolMissing)
{
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", "/nonexistent/path/llvm-symbolizer", 1);
    // IsAvailable 结果带缓存，进程内首次即固化，此处仅验证不崩溃且 Symbolize 优雅降级。
    std::vector<uint64_t> offsets{0x10};
    std::vector<SymbolizeResult> results;
    // 无论缓存状态如何，Symbolize 在工具不可用或 .o 无效时都应返回 false 且不崩溃。
    EXPECT_FALSE(KernelSourceSymbolizer::Symbolize("/nonexistent/x.o", offsets, results));
}

TEST_F(KernelSourceSymbolizerUTest, SymbolizeParsesOutput)
{
    Tools::CaseWorkspace ws("SymbolizeParsesOutput");
    const std::string oPath = ws.Root() + "/mod.o";
    WriteFile(oPath, MakeElfWithSection(true));

    // 假 symbolizer：为每个输入偏移输出「函数名行 + 位置行 + 空行分隔」。第一个命中、第二个未知。
    // 函数名行故意含冒号（ns::add(int)），验证解析端凭"结尾:数字:数字"识别位置行、不误取函数名行。
    const std::string script =
        "#!/bin/sh\n"
        "i=0\n"
        "while read line; do\n"
        "  if [ \"$i\" = \"0\" ]; then echo 'ns::add(int)'; echo /path/add.cpp:88:12;\n"
        "  else echo '??'; echo '??:0:0'; fi\n"
        "  echo ''\n"
        "  i=$((i+1))\n"
        "done\n";
    const std::string tool = WriteFakeSymbolizer(ws.Root() + "/fake-symbolizer", script);
    // 先设置环境变量，再重置缓存，确保 LocateSymbolizer 首次解析即命中本用例的假工具。
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", tool.c_str(), 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    std::vector<uint64_t> offsets{0x1a4, 0x3c};
    std::vector<SymbolizeResult> results;
    ASSERT_TRUE(KernelSourceSymbolizer::Symbolize(oPath, offsets, results));
    ASSERT_EQ(results.size(), 2U);
    EXPECT_TRUE(results[0].ok);
    EXPECT_EQ(results[0].srcFile, "/path/add.cpp");
    EXPECT_EQ(results[0].srcLine, 88U);
    EXPECT_EQ(results[0].srcColumn, 12U);
    EXPECT_FALSE(results[1].ok);
}

TEST_F(KernelSourceSymbolizerUTest, SymbolizeEmptyOffsetsReturnsFalse)
{
    std::vector<uint64_t> offsets;
    std::vector<SymbolizeResult> results;
    EXPECT_FALSE(KernelSourceSymbolizer::Symbolize("/whatever.o", offsets, results));
    EXPECT_TRUE(results.empty());
}

// 同一个 .o 内多个偏移一次解析：一个进程按序处理，结果与 offsets 一一对应回填。
TEST_F(KernelSourceSymbolizerUTest, SymbolizeMultipleOffsetsInOneOFile)
{
    Tools::CaseWorkspace ws("SymbolizeMultipleOffsetsInOneOFile");
    const std::string addO = ws.Root() + "/add.o";
    WriteFile(addO, MakeElfWithSection(true));

    // 假 symbolizer：按输入行序，每块输出 func_<i> 行、位置行 file_<i>.cpp:<10+i>:1，再补空行分隔。
    const std::string script =
        "#!/bin/sh\n"
        "i=0\n"
        "while read line; do\n"
        "  echo func_$i\n"
        "  echo /src/file_$i.cpp:$((10+i)):1\n"
        "  echo ''\n"
        "  i=$((i+1))\n"
        "done\n";
    const std::string tool = WriteFakeSymbolizer(ws.Root() + "/fake-symbolizer", script);
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", tool.c_str(), 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    std::vector<uint64_t> offsets{0x1a4, 0x3c, 0x20};
    std::vector<SymbolizeResult> results;
    ASSERT_TRUE(KernelSourceSymbolizer::Symbolize(addO, offsets, results));
    ASSERT_EQ(results.size(), 3U);
    EXPECT_TRUE(results[0].ok);
    EXPECT_EQ(results[0].srcFile, "/src/file_0.cpp");
    EXPECT_EQ(results[0].srcLine, 10U);
    EXPECT_TRUE(results[1].ok);
    EXPECT_EQ(results[1].srcFile, "/src/file_1.cpp");
    EXPECT_EQ(results[1].srcLine, 11U);
    EXPECT_TRUE(results[2].ok);
    EXPECT_EQ(results[2].srcFile, "/src/file_2.cpp");
    EXPECT_EQ(results[2].srcLine, 12U);
}

// 内联展开：一个偏移输出多帧（最内层内联 -> 外层），块内取第一条位置行即最内层帧源码位置。
TEST_F(KernelSourceSymbolizerUTest, SymbolizeParsesInlinedFramesTakesInnermostSource)
{
    Tools::CaseWorkspace ws("SymbolizeParsesInlinedFramesTakesInnermostSource");
    const std::string oPath = ws.Root() + "/inl.o";
    WriteFile(oPath, MakeElfWithSection(true));

    // 单偏移多帧：内层 f_inner@/inc/a.h:5:3、外层 f_outer@/src/a.cpp:20:7，块尾空行分隔。
    const std::string script =
        "#!/bin/sh\n"
        "read line\n"
        "echo f_inner\n"
        "echo /inc/a.h:5:3\n"
        "echo f_outer\n"
        "echo /src/a.cpp:20:7\n"
        "echo ''\n";
    const std::string tool = WriteFakeSymbolizer(ws.Root() + "/fake-symbolizer", script);
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", tool.c_str(), 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    std::vector<uint64_t> offsets{0x1a4};
    std::vector<SymbolizeResult> results;
    ASSERT_TRUE(KernelSourceSymbolizer::Symbolize(oPath, offsets, results));
    ASSERT_EQ(results.size(), 1U);
    EXPECT_TRUE(results[0].ok);
    EXPECT_EQ(results[0].srcFile, "/inc/a.h");  // 取最内层帧
    EXPECT_EQ(results[0].srcLine, 5U);
    EXPECT_EQ(results[0].srcColumn, 3U);
}

// 不存在的 .o：整体解析失败返回 false，results 保持占位（ok=false）。
TEST_F(KernelSourceSymbolizerUTest, SymbolizeInvalidOFileReturnsFalse)
{
    Tools::CaseWorkspace ws("SymbolizeInvalidOFileReturnsFalse");
    const std::string script = "#!/bin/sh\ncat >/dev/null\n";
    const std::string tool = WriteFakeSymbolizer(ws.Root() + "/fake-symbolizer", script);
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", tool.c_str(), 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    std::vector<uint64_t> offsets{0x10, 0x20};
    std::vector<SymbolizeResult> results;
    EXPECT_FALSE(KernelSourceSymbolizer::Symbolize(ws.Root() + "/not_exist.o", offsets, results));
    ASSERT_EQ(results.size(), 2U);
    EXPECT_FALSE(results[0].ok);
    EXPECT_FALSE(results[1].ok);
}

// 超时路径：假 symbolizer 收到输入后长时间不输出（sleep 远超 3s 超时），
// 父进程应在 deadline 到达后 kill 子进程、waitpid 回收（无僵尸），并返回 false。
TEST_F(KernelSourceSymbolizerUTest, SymbolizeTimesOutAndReapsChild)
{
    Tools::CaseWorkspace ws("SymbolizeTimesOutAndReapsChild");
    const std::string oPath = ws.Root() + "/hang.o";
    WriteFile(oPath, MakeElfWithSection(true));

    // 读走一行输入后睡眠很久且不产出任何输出，逼父进程走超时分支。
    const std::string script =
        "#!/bin/sh\n"
        "read line\n"
        "sleep 30\n";
    const std::string tool = WriteFakeSymbolizer(ws.Root() + "/fake-symbolizer", script);
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", tool.c_str(), 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    std::vector<uint64_t> offsets{0x1a4};
    std::vector<SymbolizeResult> results;
    // 超时应返回 false；耗时约等于 SYMBOLIZER_TIMEOUT_MS（3s），不应挂到 sleep 30 结束。
    const int64_t startMs =
        std::chrono::duration_cast<std::chrono::milliseconds>(
            std::chrono::steady_clock::now().time_since_epoch()).count();
    EXPECT_FALSE(KernelSourceSymbolizer::Symbolize(oPath, offsets, results));
    const int64_t elapsedMs =
        std::chrono::duration_cast<std::chrono::milliseconds>(
            std::chrono::steady_clock::now().time_since_epoch()).count() - startMs;
    // 明显早于假工具的 30s 睡眠即返回，说明超时 kill 生效（留足裕量，仅验证未被 sleep 拖住）。
    EXPECT_LT(elapsedMs, 15000);
}

// 子进程先关闭 stdout（触发 read EOF），再长时间 sleep 且不退出。
// 验证：即便 poll 循环因 outEof 提前结束（timedOut=false），回收阶段也在宽限 deadline 内完成，
// 不会卡在无界阻塞的 waitpid 上（zhangpengpeng8 检视点）。
TEST_F(KernelSourceSymbolizerUTest, SymbolizeReapsChildThatClosesStdoutButHangs)
{
    Tools::CaseWorkspace ws("SymbolizeReapsChildThatClosesStdoutButHangs");
    const std::string oPath = ws.Root() + "/hang_after_eof.o";
    WriteFile(oPath, MakeElfWithSection(true));

    // 读走一行输入 -> 立刻 close stdout（exec 1>&-）-> sleep 很久不退出。
    const std::string script =
        "#!/bin/sh\n"
        "read line\n"
        "exec 1>&-\n"
        "sleep 30\n";
    const std::string tool = WriteFakeSymbolizer(ws.Root() + "/fake-symbolizer", script);
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", tool.c_str(), 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    std::vector<uint64_t> offsets{0x1a4};
    std::vector<SymbolizeResult> results;
    const int64_t startMs =
        std::chrono::duration_cast<std::chrono::milliseconds>(
            std::chrono::steady_clock::now().time_since_epoch()).count();
    // stdout EOF 后无有效输出，解析结果为空占位；关键在于调用要迅速返回、不被 sleep 30 拖住。
    (void)KernelSourceSymbolizer::Symbolize(oPath, offsets, results);
    const int64_t elapsedMs =
        std::chrono::duration_cast<std::chrono::milliseconds>(
            std::chrono::steady_clock::now().time_since_epoch()).count() - startMs;
    // 远早于 30s：回收纳入宽限 deadline（SIGKILL 兜底），未被挂住的子进程拖死。
    EXPECT_LT(elapsedMs, 15000);
}

// PrintClassificationSummary 聚类逻辑：不崩溃并覆盖分组分支。
TEST(KernelSymbolClassificationUTest, GroupsBySameOFileAndOffset)
{
    std::vector<ErrorLocation> locations;
    // 同一 .o、相同偏移的两个 core -> 归为一组。
    ErrorLocation a;
    a.coreId = 2; a.coreType = 0; a.fixedPCOffset = 0x1a4; a.oFilePath = "add_host.o";
    a.hasSymbol = true; a.symbolName = "add_kernel"; a.symbolOffset = 0x1c;
    a.src.ok = true; a.src.srcFile = "add.cpp"; a.src.srcLine = 88; a.src.srcColumn = 12;
    ErrorLocation b = a;
    b.coreId = 5;
    // 同一 .o、不同偏移 -> 另一组。
    ErrorLocation c;
    c.coreId = 7; c.coreType = 1; c.fixedPCOffset = 0x3c; c.oFilePath = "add_host.o";
    // 不同 .o -> 又一组。
    ErrorLocation d;
    d.coreId = 9; d.coreType = 0; d.fixedPCOffset = 0x10; d.oFilePath = "mul_host.o";
    locations = {a, b, c, d};

    // 仅验证调用不崩溃（输出走日志）。
    KernelSymbolLocator::PrintClassificationSummary(locations);
    KernelSymbolLocator::PrintClassificationSummary({});
    SUCCEED();
}

TEST(KernelSymbolResolveUTest, ResolveOFilePathFallsBackWhenNoDebugLine)
{
    Tools::CaseWorkspace ws("ResolveOFilePathFallsBackWhenNoDebugLine");
    const std::string withPath = ws.Root() + "/with_debug.o";
    const std::string withoutPath = ws.Root() + "/without_debug.o";
    WriteFile(withPath, MakeElfWithSection(true));
    WriteFile(withoutPath, MakeElfWithSection(false));

    EXPECT_EQ(KernelSymbolLocator::ResolveOFilePath(withPath), withPath);
    EXPECT_TRUE(KernelSymbolLocator::ResolveOFilePath(withoutPath).empty());
    EXPECT_TRUE(KernelSymbolLocator::ResolveOFilePath("").empty());
}
} // namespace
