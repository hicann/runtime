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
#include <sstream>
#include <string>
#include <thread>
#include <vector>
#include <unistd.h>
#include "securec.h"
#include "kernel_source_symbolizer.h"
#include "kernel_symbol_locator.h"
#include "tools/case_workspace.h"

using namespace Adx;

namespace {
// 填充最小合法的 ELF64 文件头：magic、64 位小端、section header 表位置与数量。
void FillElfHeader(Elf64_Ehdr& eh, size_t shOff, uint16_t shnum)
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
    eh.e_shstrndx = 1; // .shstrtab 为第 1 个段
}

// 构造一个最小 ELF64，可选包含名为 sectionName 的段（用于 .debug_line 探测）。
std::string MakeElfWithSection(bool withSection, const std::string& sectionName = ".debug_line")
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

    const uint16_t shnum = withSection ? 3 : 2; // NULL + .shstrtab (+ target)
    const size_t shOff = sizeof(Elf64_Ehdr);
    const size_t shstrOff = shOff + static_cast<size_t>(shnum) * sizeof(Elf64_Shdr);
    std::string buf;
    buf.resize(shstrOff + shstr.size(), '\0');

    Elf64_Ehdr eh{};
    FillElfHeader(eh, shOff, shnum);
    (void)memcpy_s(&buf[0], sizeof(eh), &eh, sizeof(eh));

    std::vector<Elf64_Shdr> shdrs(shnum);
    shdrs[0].sh_type = SHT_NULL;        // [0] NULL，sh_name 默认 0
    shdrs[1].sh_name = shstrtabNameOff; // [1] .shstrtab
    shdrs[1].sh_type = SHT_STRTAB;
    shdrs[1].sh_offset = shstrOff;
    shdrs[1].sh_size = shstr.size();
    if (withSection) {
        shdrs[2].sh_name = targetNameOff; // [2] target section
        shdrs[2].sh_type = SHT_PROGBITS;
        shdrs[2].sh_offset = shstrOff;    // 复用字符串表数据区，探测只看段名不看内容
        shdrs[2].sh_size = 1;
    }
    for (uint16_t i = 0; i < shnum; ++i) {
        (void)memcpy_s(&buf[shOff + i * sizeof(Elf64_Shdr)], sizeof(Elf64_Shdr), &shdrs[i], sizeof(Elf64_Shdr));
    }
    (void)memcpy_s(&buf[shstrOff], shstr.size(), shstr.data(), shstr.size());
    return buf;
}

void WriteFile(const std::string& path, const std::string& content)
{
    std::ofstream ofs(path, std::ios::binary | std::ios::trunc);
    ofs.write(content.data(), static_cast<std::streamsize>(content.size()));
    ofs.close();
}

// 写一个假的 llvm-symbolizer 脚本：从 stdin 读偏移，按行输出 func 与 file:line:col。
std::string WriteFakeSymbolizer(const std::string& path, const std::string& body)
{
    WriteFile(path, body);
    (void)chmod(path.c_str(), 0755);
    return path;
}

// 有状态假工具脚手架（Skips/Sporadic 两用例公共段去重）：ws 由调用方持有以保证工作区生命周期。
// 脚本每次 spawn 读+写计数文件（绝对路径）；hangBefore 语义：调用序号 <= hangBefore 时挂死逼超时，
// 之后输出有效帧 f_x@/src/x.cpp:7:8。返回 {oPath, counterPath}，调用方读 counter 断言实际启动次数。
std::pair<std::string, std::string> SetupStatefulFakeTool(Tools::CaseWorkspace& ws, int hangBefore)
{
    const std::string oPath = ws.Root() + "/stateful.o";
    const std::string counterPath = ws.Root() + "/counter";
    WriteFile(oPath, MakeElfWithSection(true));
    std::ostringstream oss;
    oss << "#!/bin/sh\n"
        << "read line\n"
        << "n=$(cat \"" << counterPath << "\" 2>/dev/null || echo 0)\n"
        << "n=$((n+1))\n"
        << "echo $n > \"" << counterPath << "\"\n"
        << "if [ \"$n\" -le " << hangBefore << " ]; then sleep 30; fi\n"
        << "echo 'f_x'\n"
        << "echo /src/x.cpp:7:8\n"
        << "echo ''\n";
    const std::string tool = WriteFakeSymbolizer(ws.Root() + "/fake-symbolizer", oss.str());
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", tool.c_str(), 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();
    return {oPath, counterPath};
}

// 读取计数文件首行（假工具已启动次数）。
std::string ReadCounterFile(const std::string& path)
{
    std::ifstream ifs(path);
    std::string value;
    std::getline(ifs, value);
    return value;
}

// 双帧样例 ErrorLocation（BuildGroupSummaryText 系列用例共用）。
ErrorLocation MakeDualFrameLocation()
{
    ErrorLocation loc;
    loc.oFilePath = "add_host.o";
    loc.fixedPCOffset = 0x1a4;
    loc.hasSymbol = true;
    loc.symbolName = "add_kernel";
    loc.symbolOffset = 0x1c;
    loc.src.outermost = {true, "/src/a.cpp", 20U, 7U};
    loc.src.innermost = {true, "/inc/a.h", 5U, 3U};
    return loc;
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

    // 假 symbolizer：按 offset 分支，输出「函数名行 + 位置行 + 空行」。第一个命中、第二个未知。
    // 函数名行故意含冒号（ns::add(int)），验证解析端凭"结尾:数字:数字"识别位置行、不误取函数名行。
    const std::string script = "#!/bin/sh\n"
                               "read line\n"
                               "case \"$line\" in\n"
                               "  *0x1a4*) echo 'ns::add(int)'; echo /path/add.cpp:88:12;;\n"
                               "  *) echo '??'; echo '??:0:0';;\n"
                               "esac\n"
                               "echo ''\n";
    const std::string tool = WriteFakeSymbolizer(ws.Root() + "/fake-symbolizer", script);
    // 先设置环境变量，再重置缓存，确保 LocateSymbolizer 首次解析即命中本用例的假工具。
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", tool.c_str(), 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    std::vector<uint64_t> offsets{0x1a4, 0x3c};
    std::vector<SymbolizeResult> results;
    EXPECT_FALSE(KernelSourceSymbolizer::Symbolize(oPath, offsets, results));
    ASSERT_EQ(results.size(), 2U);
    EXPECT_TRUE(results[0].outermost.ok);
    EXPECT_EQ(results[0].outermost.srcFile, "/path/add.cpp");
    EXPECT_EQ(results[0].outermost.srcLine, 88U);
    EXPECT_EQ(results[0].outermost.srcColumn, 12U);
    EXPECT_FALSE(results[1].outermost.ok);
}

TEST_F(KernelSourceSymbolizerUTest, SymbolizeEmptyOffsetsReturnsFalse)
{
    std::vector<uint64_t> offsets;
    std::vector<SymbolizeResult> results;
    EXPECT_FALSE(KernelSourceSymbolizer::Symbolize("/whatever.o", offsets, results));
    EXPECT_TRUE(results.empty());
}

// 同一个 .o 内多个偏移逐偏移独立进程，结果与 offsets 一一对应。
TEST_F(KernelSourceSymbolizerUTest, SymbolizeMultipleOffsetsInOneOFile)
{
    Tools::CaseWorkspace ws("SymbolizeMultipleOffsetsInOneOFile");
    const std::string addO = ws.Root() + "/add.o";
    WriteFile(addO, MakeElfWithSection(true));

    // 假 symbolizer：按 offset 分支，每分支输出 func_<i> 行、位置行，再补空行。
    const std::string script = "#!/bin/sh\n"
                               "read line\n"
                               "case \"$line\" in\n"
                               "  *0x1a4*) echo 'func_0'; echo /src/file_0.cpp:10:1;;\n"
                               "  *0x3c*) echo 'func_1'; echo /src/file_1.cpp:11:1;;\n"
                               "  *0x20*) echo 'func_2'; echo /src/file_2.cpp:12:1;;\n"
                               "esac\n"
                               "echo ''\n";
    const std::string tool = WriteFakeSymbolizer(ws.Root() + "/fake-symbolizer", script);
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", tool.c_str(), 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    std::vector<uint64_t> offsets{0x1a4, 0x3c, 0x20};
    std::vector<SymbolizeResult> results;
    ASSERT_TRUE(KernelSourceSymbolizer::Symbolize(addO, offsets, results));
    ASSERT_EQ(results.size(), 3U);
    EXPECT_TRUE(results[0].outermost.ok);
    EXPECT_EQ(results[0].outermost.srcFile, "/src/file_0.cpp");
    EXPECT_EQ(results[0].outermost.srcLine, 10U);
    EXPECT_TRUE(results[1].outermost.ok);
    EXPECT_EQ(results[1].outermost.srcFile, "/src/file_1.cpp");
    EXPECT_EQ(results[1].outermost.srcLine, 11U);
    EXPECT_TRUE(results[2].outermost.ok);
    EXPECT_EQ(results[2].outermost.srcFile, "/src/file_2.cpp");
    EXPECT_EQ(results[2].outermost.srcLine, 12U);
}

// 内联展开：首条位置行=最内层帧、末条=最外层帧，双槽各取。
TEST_F(KernelSourceSymbolizerUTest, SymbolizeParsesInlinedFramesTakesBothFrames)
{
    Tools::CaseWorkspace ws("SymbolizeParsesInlinedFramesTakesBothFrames");
    const std::string oPath = ws.Root() + "/inl.o";
    WriteFile(oPath, MakeElfWithSection(true));

    // 单偏移多帧：内层 f_inner@/inc/a.h:5:3、外层 f_outer@/src/a.cpp:20:7，块尾空行分隔。
    const std::string script = "#!/bin/sh\n"
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
    EXPECT_TRUE(results[0].innermost.ok);
    EXPECT_EQ(results[0].innermost.srcFile, "/inc/a.h"); // 首条位置行=最内层帧
    EXPECT_EQ(results[0].innermost.srcLine, 5U);
    EXPECT_EQ(results[0].innermost.srcColumn, 3U);
    EXPECT_TRUE(results[0].outermost.ok);
    EXPECT_EQ(results[0].outermost.srcFile, "/src/a.cpp"); // 末条位置行=最外层帧
    EXPECT_EQ(results[0].outermost.srcLine, 20U);
    EXPECT_EQ(results[0].outermost.srcColumn, 7U);
}

// 混合块各槽极值：首条给 innermost、末条给 outermost。
TEST_F(KernelSourceSymbolizerUTest, SymbolizeParsesMixedBlockPerSlotExtremes)
{
    Tools::CaseWorkspace ws("SymbolizeParsesMixedBlockPerSlotExtremes");
    const std::string oPath = ws.Root() + "/mix.o";
    WriteFile(oPath, MakeElfWithSection(true));

    // 假 symbolizer：分支1 有效位置行后跟 ??:0:0（inner 有效、outer 未知），分支2 ??:0:0 后跟有效位置行（inner
    // 未知、outer 有效）。
    const std::string script = "#!/bin/sh\n"
                               "read line\n"
                               "case \"$line\" in\n"
                               "  *0x1a4*) echo 'f_a'; echo /src/a.cpp:20:7; echo '??'; echo '??:0:0';;\n"
                               "  *0x3c*) echo '??'; echo '??:0:0'; echo 'f_b'; echo /src/b.cpp:30:9;;\n"
                               "esac\n"
                               "echo ''\n";
    const std::string tool = WriteFakeSymbolizer(ws.Root() + "/fake-symbolizer", script);
    // 先设置环境变量，再重置缓存，确保 LocateSymbolizer 首次解析即命中本用例的假工具。
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", tool.c_str(), 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    std::vector<uint64_t> offsets{0x1a4, 0x3c};
    std::vector<SymbolizeResult> results;
    EXPECT_FALSE(KernelSourceSymbolizer::Symbolize(oPath, offsets, results));
    ASSERT_EQ(results.size(), 2U);
    EXPECT_TRUE(results[0].innermost.ok);
    EXPECT_EQ(results[0].innermost.srcFile, "/src/a.cpp");
    EXPECT_EQ(results[0].innermost.srcLine, 20U);
    EXPECT_EQ(results[0].innermost.srcColumn, 7U);
    EXPECT_FALSE(results[0].outermost.ok);
    EXPECT_FALSE(results[1].innermost.ok);
    EXPECT_TRUE(results[1].outermost.ok);
    EXPECT_EQ(results[1].outermost.srcFile, "/src/b.cpp");
    EXPECT_EQ(results[1].outermost.srcLine, 30U);
    EXPECT_EQ(results[1].outermost.srcColumn, 9U);
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
    EXPECT_FALSE(results[0].outermost.ok);
    EXPECT_FALSE(results[1].outermost.ok);
}

// 超时路径：假 symbolizer 收到输入后长时间不输出（sleep 远超 3s 超时），
// 父进程应在 deadline 到达后 kill 子进程、waitpid 回收（无僵尸），并返回 false。
TEST_F(KernelSourceSymbolizerUTest, SymbolizeTimesOutAndReapsChild)
{
    Tools::CaseWorkspace ws("SymbolizeTimesOutAndReapsChild");
    const std::string oPath = ws.Root() + "/hang.o";
    WriteFile(oPath, MakeElfWithSection(true));

    // 读走一行输入后睡眠很久且不产出任何输出，逼父进程走超时分支。
    const std::string script = "#!/bin/sh\n"
                               "read line\n"
                               "sleep 30\n";
    const std::string tool = WriteFakeSymbolizer(ws.Root() + "/fake-symbolizer", script);
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", tool.c_str(), 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    std::vector<uint64_t> offsets{0x1a4};
    std::vector<SymbolizeResult> results;
    // 超时应返回 false；耗时约等于 SYMBOLIZER_TIMEOUT_MS（3s），不应挂到 sleep 30 结束。
    const int64_t startMs =
        std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now().time_since_epoch())
            .count();
    EXPECT_FALSE(KernelSourceSymbolizer::Symbolize(oPath, offsets, results));
    const int64_t elapsedMs =
        std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now().time_since_epoch())
            .count() -
        startMs;
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
    const std::string script = "#!/bin/sh\n"
                               "read line\n"
                               "exec 1>&-\n"
                               "sleep 30\n";
    const std::string tool = WriteFakeSymbolizer(ws.Root() + "/fake-symbolizer", script);
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", tool.c_str(), 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    std::vector<uint64_t> offsets{0x1a4};
    std::vector<SymbolizeResult> results;
    const int64_t startMs =
        std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now().time_since_epoch())
            .count();
    // stdout EOF 后无有效输出，解析结果为空占位；关键在于调用要迅速返回、不被 sleep 30 拖住。
    (void)KernelSourceSymbolizer::Symbolize(oPath, offsets, results);
    const int64_t elapsedMs =
        std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now().time_since_epoch())
            .count() -
        startMs;
    // 远早于 30s：回收纳入宽限 deadline（SIGKILL 兜底），未被挂住的子进程拖死。
    EXPECT_LT(elapsedMs, 15000);
}

// PrintClassificationSummary 聚类逻辑：不崩溃并覆盖分组分支。
TEST(KernelSymbolClassificationUTest, GroupsBySameOFileAndOffset)
{
    std::vector<ErrorLocation> locations;
    // 同一 .o、相同偏移的两个 core -> 归为一组。
    ErrorLocation a;
    a.coreId = 2;
    a.coreType = 0;
    a.fixedPCOffset = 0x1a4;
    a.oFilePath = "add_host.o";
    a.hasSymbol = true;
    a.symbolName = "add_kernel";
    a.symbolOffset = 0x1c;
    a.src.outermost.ok = true;
    a.src.outermost.srcFile = "add.cpp";
    a.src.outermost.srcLine = 88;
    a.src.outermost.srcColumn = 12;
    ErrorLocation b = a;
    b.coreId = 5;
    // 同一 .o、不同偏移 -> 另一组。
    ErrorLocation c;
    c.coreId = 7;
    c.coreType = 1;
    c.fixedPCOffset = 0x3c;
    c.oFilePath = "add_host.o";
    // 不同 .o -> 又一组。
    ErrorLocation d;
    d.coreId = 9;
    d.coreType = 0;
    d.fixedPCOffset = 0x10;
    d.oFilePath = "mul_host.o";
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

// 契约：空行与仅含 \r 的行整体跳过；行尾 \r 被去除（Unix 工具输出无 \r，仅防御 DOS 行尾）。
TEST_F(KernelSourceSymbolizerUTest, SplitSkipsBlankLinesAndTrimsCr)
{
    const std::vector<std::string> result = KernelSourceSymbolizer::SplitRawOutputForLog("sq\r\n\n\r\ncalc\n");
    ASSERT_EQ(result.size(), 2U);
    EXPECT_EQ(result[0], "sq");
    EXPECT_EQ(result[1], "calc");

    // 行内容仅为 \r：去 \r 后为空行，应跳过。
    const std::vector<std::string> crOnly = KernelSourceSymbolizer::SplitRawOutputForLog("\r\n");
    EXPECT_TRUE(crOnly.empty());
}

// 契约：最后一行不带换行符时仍作为完整行输出。
TEST_F(KernelSourceSymbolizerUTest, SplitLastLineWithoutNewline)
{
    const std::vector<std::string> result = KernelSourceSymbolizer::SplitRawOutputForLog("sq\ncalc");
    ASSERT_EQ(result.size(), 2U);
    EXPECT_EQ(result[0], "sq");
    EXPECT_EQ(result[1], "calc");
}

// 契约：空输入与全空行输入均产出空结果（不产生无意义日志）。
TEST_F(KernelSourceSymbolizerUTest, SplitEmptyAndAllBlankInput)
{
    EXPECT_TRUE(KernelSourceSymbolizer::SplitRawOutputForLog("").empty());
    EXPECT_TRUE(KernelSourceSymbolizer::SplitRawOutputForLog("\n\n\n").empty());
}

// 契约：超长行按 MAX_LOG_CHUNK_SIZE(704) 分块续打，不整行丢弃也不产生超缓冲行。
TEST_F(KernelSourceSymbolizerUTest, SplitChunksLongLines)
{
    // 2000 = 704 + 704 + 592。
    const std::vector<std::string> a = KernelSourceSymbolizer::SplitRawOutputForLog(std::string(2000, 'a') + "\n");
    ASSERT_EQ(a.size(), 3U);
    EXPECT_EQ(a[0].size(), 704U);
    EXPECT_EQ(a[1].size(), 704U);
    EXPECT_EQ(a[2].size(), 592U);
    EXPECT_EQ(a[0][0], 'a');
    EXPECT_EQ(a[1][0], 'a');
    EXPECT_EQ(a[2][0], 'a');

    // 恰好整块：1 块，size 704。
    const std::vector<std::string> b = KernelSourceSymbolizer::SplitRawOutputForLog(std::string(704, 'b') + "\n");
    ASSERT_EQ(b.size(), 1U);
    EXPECT_EQ(b[0].size(), 704U);
    EXPECT_EQ(b[0][0], 'b');

    // 超出 1 字节：2 块 {704, 1}。
    const std::vector<std::string> c = KernelSourceSymbolizer::SplitRawOutputForLog(std::string(705, 'c') + "\n");
    ASSERT_EQ(c.size(), 2U);
    EXPECT_EQ(c[0].size(), 704U);
    EXPECT_EQ(c[1].size(), 1U);
    EXPECT_EQ(c[0][0], 'c');
    EXPECT_EQ(c[1][0], 'c');

    // 双整块：2 块 {704, 704}。
    const std::vector<std::string> d = KernelSourceSymbolizer::SplitRawOutputForLog(std::string(1408, 'd') + "\n");
    ASSERT_EQ(d.size(), 2U);
    EXPECT_EQ(d[0].size(), 704U);
    EXPECT_EQ(d[1].size(), 704U);
    EXPECT_EQ(d[0][0], 'd');
    EXPECT_EQ(d[1][0], 'd');
}

// 末行以 \r 结尾且无换行：\r 按行尾残留剥离（语义锁定，见 SplitRawOutputForLog 注释）。
TEST_F(KernelSourceSymbolizerUTest, SplitRawOutputForLogCrOnlyLine)
{
    const std::vector<std::string> r = KernelSourceSymbolizer::SplitRawOutputForLog("abc\r");
    ASSERT_EQ(r.size(), 1U);
    EXPECT_EQ(r[0], "abc");
}

// UTF-8 边界切分：切点落在多字节字符内时回退到字符边界，拼接无损、边界字节非续字节。
// 输入以 ASCII 结尾：纯 CJK 尾部经回退后必然残留续字节，无法满足"非末块末字节非续字节"。
TEST_F(KernelSourceSymbolizerUTest, SplitChunksUtf8Boundary)
{
    // 701 个 'a' 使 704 字节切点落在第二个字符的续字节上（0xAD），触发回退；尾随 'b' 保证末块结束在非续字节。
    const std::string line = std::string(701, 'a') + "中文" + "b";
    ASSERT_GT(line.size(), 704U);
    const std::vector<std::string> r = KernelSourceSymbolizer::SplitRawOutputForLog(line + "\n");
    std::string joined;
    for (size_t i = 0; i < r.size(); ++i) {
        EXPECT_LE(r[i].size(), 704U);
        if (i + 1 < r.size()) {
            EXPECT_NE(r[i].back() & 0xC0, 0x80); // 非末块的最后字节不得为 UTF-8 续字节
        }
        joined += r[i];
    }
    EXPECT_EQ(joined, line);
    ASSERT_GE(r.size(), 2U); // 确实发生切分
}

// 逐偏移 best-effort：单个偏移无输出（unknown）不阻断后续偏移；返回值全成功语义为 false。
TEST_F(KernelSourceSymbolizerUTest, SymbolizeContinuesAfterSingleOffsetFailure)
{
    Tools::CaseWorkspace ws("SymbolizeContinuesAfterSingleOffsetFailure");
    const std::string oPath = ws.Root() + "/cont.o";
    WriteFile(oPath, MakeElfWithSection(true));
    const std::string script = "#!/bin/sh\n"
                               "read line\n"
                               "case \"$line\" in\n"
                               "  *0x1a4*) exit 0;;\n"
                               "  *) echo 'f_b'; echo /src/b.cpp:30:9; echo '';;\n"
                               "esac\n";
    const std::string tool = WriteFakeSymbolizer(ws.Root() + "/fake-symbolizer", script);
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", tool.c_str(), 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    std::vector<uint64_t> offsets{0x1a4, 0x3c};
    std::vector<SymbolizeResult> results;
    EXPECT_FALSE(KernelSourceSymbolizer::Symbolize(oPath, offsets, results));
    ASSERT_EQ(results.size(), 2U);
    EXPECT_FALSE(results[0].innermost.ok);
    EXPECT_FALSE(results[0].outermost.ok);
    EXPECT_TRUE(results[1].outermost.ok);
    EXPECT_EQ(results[1].outermost.srcFile, "/src/b.cpp");
}

// 逐偏移连续失败上限：工具级失败（超时）连续达到 MAX_CONSECUTIVE_SYMBOLIZE_FAILURES 次即跳过剩余偏移，
// 病理全挂死场景总耗时收敛为 3×超时（≈9s），不线性放大为 N×3s（jinyingqi 188714057）。
TEST_F(KernelSourceSymbolizerUTest, SymbolizeSkipsRemainingAfterConsecutiveFailures)
{
    Tools::CaseWorkspace ws("SymbolizeSkipsRemainingAfterConsecutiveFailures");
    // 999=全部挂死逼超时，无有效输出。
    const auto setup = SetupStatefulFakeTool(ws, 999);
    const std::string& oPath = setup.first;
    const std::string& counterPath = setup.second;

    std::vector<uint64_t> offsets{0x1, 0x2, 0x3, 0x4};
    std::vector<SymbolizeResult> results;
    const int64_t startMs =
        std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now().time_since_epoch())
            .count();
    EXPECT_FALSE(KernelSourceSymbolizer::Symbolize(oPath, offsets, results));
    const int64_t elapsedMs =
        std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now().time_since_epoch())
            .count() -
        startMs;
    // 4 个偏移按现实现全部超时需 ≈12s；加上限后 3 次超时 ≈9.5s，留足裕量区分"是否跳过剩余偏移"。
    EXPECT_LT(elapsedMs, 20000);
    ASSERT_EQ(results.size(), 4U);
    EXPECT_FALSE(results[0].outermost.ok);
    EXPECT_FALSE(results[1].outermost.ok);
    EXPECT_FALSE(results[2].outermost.ok);
    EXPECT_FALSE(results[3].outermost.ok);
    // RED 断言：无上限实现处理全部 4 个偏移 → counter=="4"；加上限后仅处理前 3 个 → counter=="3"。
    EXPECT_EQ(ReadCounterFile(counterPath), "3");
}

// 偶发失败不触发上限：前 2 个偏移超时后恢复，剩余偏移正常解析；成功解析应重置连续失败计数。
TEST_F(KernelSourceSymbolizerUTest, SymbolizeContinuesAfterSporadicFailures)
{
    Tools::CaseWorkspace ws("SymbolizeContinuesAfterSporadicFailures");
    const auto setup = SetupStatefulFakeTool(ws, 2);
    const std::string& oPath = setup.first;
    const std::string& counterPath = setup.second;

    std::vector<uint64_t> offsets{0x1, 0x2, 0x3, 0x4};
    std::vector<SymbolizeResult> results;
    EXPECT_FALSE(KernelSourceSymbolizer::Symbolize(oPath, offsets, results));
    ASSERT_EQ(results.size(), 4U);
    // 前 2 个超时 unknown，第 3、4 个解析有效。
    EXPECT_FALSE(results[0].outermost.ok);
    EXPECT_FALSE(results[1].outermost.ok);
    EXPECT_TRUE(results[2].outermost.ok);
    EXPECT_EQ(results[2].outermost.srcFile, "/src/x.cpp");
    EXPECT_TRUE(results[3].outermost.ok);
    EXPECT_EQ(results[3].outermost.srcFile, "/src/x.cpp");
    // 偶发失败后恢复不触发上限：4 个偏移全部被处理 → counter=="4"。
    EXPECT_EQ(ReadCounterFile(counterPath), "4");
}

// 并发序列保护：两线程对不同 .o 并发 Symbolize，各自结果正确（锁只保打印序列，结果正确性回归保护）。
TEST_F(KernelSourceSymbolizerUTest, SymbolizeConcurrentDifferentOFiles)
{
    Tools::CaseWorkspace ws("SymbolizeConcurrentDifferentOFiles");
    const std::string oA = ws.Root() + "/a.o";
    const std::string oB = ws.Root() + "/b.o";
    WriteFile(oA, MakeElfWithSection(true));
    WriteFile(oB, MakeElfWithSection(true));
    const std::string script = "#!/bin/sh\n"
                               "read line\n"
                               "case \"$line\" in\n"
                               "  *a.o*0x10*) echo 'fa'; echo /src/a.cpp:1:2; echo '';;\n"
                               "  *b.o*0x20*) echo 'fb'; echo /src/b.cpp:3:4; echo '';;\n"
                               "esac\n";
    const std::string tool = WriteFakeSymbolizer(ws.Root() + "/fake-symbolizer", script);
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", tool.c_str(), 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    std::vector<SymbolizeResult> resA;
    std::vector<SymbolizeResult> resB;
    std::thread ta([&]() {
        std::vector<uint64_t> offs{0x10};
        (void)KernelSourceSymbolizer::Symbolize(oA, offs, resA);
    });
    std::thread tb([&]() {
        std::vector<uint64_t> offs{0x20};
        (void)KernelSourceSymbolizer::Symbolize(oB, offs, resB);
    });
    ta.join();
    tb.join();
    ASSERT_EQ(resA.size(), 1U);
    ASSERT_EQ(resB.size(), 1U);
    EXPECT_TRUE(resA[0].outermost.ok);
    EXPECT_EQ(resA[0].outermost.srcFile, "/src/a.cpp");
    EXPECT_TRUE(resB[0].outermost.ok);
    EXPECT_EQ(resB[0].outermost.srcFile, "/src/b.cpp");
}

// BuildGroupSummaryText 三行格式：双帧 + symbol + cores；缺失字段统一 unknown。
TEST(KernelSymbolSummaryTextUTest, BuildGroupSummaryTextFormatsDualFrames)
{
    const ErrorLocation loc = MakeDualFrameLocation();
    ErrorLocation c0;
    c0.coreId = 2;
    c0.coreType = 0;
    ErrorLocation c1;
    c1.coreId = 5;
    c1.coreType = 0;
    const std::vector<const ErrorLocation*> cores{&c0, &c1};

    const std::string text = KernelSymbolLocator::BuildGroupSummaryText(0, loc, cores);
    EXPECT_EQ(
        text, "Group[0] oFile=add_host.o fixedPCOffset=0x1a4 symbol=add_kernel+0x1c\n"
              "Group[0] outerSrc=/src/a.cpp:20:7 innerSrc=/inc/a.h:5:3\n"
              "Group[0] cores=[{id=2,type=0},{id=5,type=0}]\n");

    ErrorLocation unknown;
    unknown.oFilePath = "";
    unknown.fixedPCOffset = 0x0;
    const std::vector<const ErrorLocation*> single{&unknown};
    const std::string text2 = KernelSymbolLocator::BuildGroupSummaryText(3, unknown, single);
    EXPECT_EQ(
        text2, "Group[3] oFile=unknown fixedPCOffset=0x0 symbol=unknown\n"
               "Group[3] outerSrc=unknown innerSrc=unknown\n"
               "Group[3] cores=[{id=0,type=0}]\n");
}

// 13 cores 应拆为 2 行 cores 行（12+1），共 4 行（头行+src 行+2 行 cores）。
TEST(KernelSymbolSummaryTextUTest, BuildGroupSummaryTextSplitsCoresPerLine)
{
    const ErrorLocation loc = MakeDualFrameLocation();
    ErrorLocation cores13Arr[13];
    std::vector<const ErrorLocation*> cores13;
    for (int i = 0; i < 13; ++i) {
        cores13Arr[i].coreId = static_cast<uint32_t>(i);
        cores13Arr[i].coreType = 0;
        cores13.push_back(&cores13Arr[i]);
    }
    const std::string text = KernelSymbolLocator::BuildGroupSummaryText(3, loc, cores13);
    std::vector<std::string> lines;
    std::istringstream iss(text);
    std::string line;
    while (std::getline(iss, line)) {
        if (!line.empty()) {
            lines.push_back(line);
        }
    }
    ASSERT_EQ(lines.size(), 4U);
    EXPECT_TRUE(lines[2].find("Group[3] cores=[") == 0);
    EXPECT_TRUE(lines[2].find("{id=11,type=0}") != std::string::npos);
    EXPECT_TRUE(lines[2].find("{id=12,") == std::string::npos);
    EXPECT_TRUE(lines[3].find("Group[3] cores=[") == 0);
    EXPECT_EQ(lines[3], "Group[3] cores=[{id=12,type=0}]");
}
} // namespace
