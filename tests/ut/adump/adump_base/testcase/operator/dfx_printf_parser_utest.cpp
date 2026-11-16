/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

// printf 完整格式语法对拍用例：oracle = host snprintf，经 ParseDfxInfo 全链路渲染对拍（设计 §8.1）

#include <gtest/gtest.h>
#include <cstdarg>
#include <cstdint>
#include <cstring>
#include <vector>
#include <limits>
#include "securec.h"
#define protected public
#define private public

#include "dfx_info_parser.h"
#include "dfx_printf_parser.h"

using namespace Adx;
using cce::runtime::BlockInfo;
using cce::runtime::BlockReadInfo;
using cce::runtime::BlockWriteInfo;
using cce::runtime::DumpInfoHead;

static constexpr uint32_t PRINT_ARG_LEN = 8U;
static constexpr uint32_t RESV_LEN = 8U;
static constexpr uint32_t RESV_LEN_SIMT = 40U;

static DumpInfoHead* WriteTlv(uint8_t* buf, cce::runtime::DumpType type, uint32_t infoLen)
{
    DumpInfoHead* head = reinterpret_cast<DumpInfoHead*>(buf);
    head->type = type;
    head->infoLen = infoLen;
    return head;
}

// 按设备侧槽位协议构造 printf TLV；strSlotIdxs 为各 %s 实参的槽下标，缺省取末尾连续 N 个
static uint32_t BuildPrintfSlotsTlv(
    uint8_t* buf, const std::string& fmt, const std::vector<uint64_t>& slots,
    const std::vector<std::string>& strArgs = {}, bool isSimt = false, const std::vector<size_t>& strSlotIdxs = {})
{
    const uint32_t resvOffset = isSimt ? RESV_LEN_SIMT : RESV_LEN;
    DumpInfoHead* head =
        WriteTlv(buf, isSimt ? cce::runtime::DumpType::DUMP_SIMT_PRINTF : cce::runtime::DumpType::DUMP_SCALAR, 0);
    uint8_t* infoMsg = head->infoMsg;
    (void)memset_s(infoMsg, resvOffset, 0, resvOffset);
    const uint64_t strOffset = (slots.size() + 1) * PRINT_ARG_LEN;
    (void)memcpy_s(infoMsg + resvOffset, sizeof(uint64_t), &strOffset, sizeof(uint64_t));
    for (size_t i = 0; i < slots.size(); ++i) {
        (void)memcpy_s(infoMsg + resvOffset + (i + 1) * PRINT_ARG_LEN, sizeof(uint64_t), &slots[i], sizeof(uint64_t));
    }
    for (size_t k = 0; (k < strSlotIdxs.size()) && (k < strArgs.size()); ++k) {
        const size_t slotIdx = strSlotIdxs[k];
        uint64_t strArgCursor = (slots.size() - slotIdx) * PRINT_ARG_LEN + fmt.size() + 1;
        for (size_t j = 0; j < k; ++j) {
            strArgCursor += strArgs[j].size() + 1;
        }
        (void)memcpy_s(
            infoMsg + resvOffset + (slotIdx + 1) * PRINT_ARG_LEN, sizeof(uint64_t), &strArgCursor, sizeof(uint64_t));
    }
    (void)memcpy_s(infoMsg + resvOffset + strOffset, fmt.size() + 1, fmt.c_str(), fmt.size() + 1);
    size_t off = resvOffset + strOffset + fmt.size() + 1;
    for (const auto& s : strArgs) {
        (void)memcpy_s(infoMsg + off, s.size() + 1, s.c_str(), s.size() + 1);
        off += s.size() + 1;
    }
    head->infoLen = static_cast<uint32_t>(off);
    return sizeof(DumpInfoHead) + head->infoLen;
}

// 对齐 asc_printf_impl_assert_msg 设备侧真实形态：dump_head "[ASSERT] %s:%u: %s: Assertion '%s' failed. "
// 拼在用户 fmt 之前，实参依次为 file/line/function/assertion + 用户实参
static uint32_t BuildAssertMsgSlotsTlv(
    uint8_t* buf, const std::string& userFmt, const std::vector<uint64_t>& slots,
    const std::vector<std::string>& strArgs, bool isSimt = false, const std::vector<size_t>& strSlotIdxs = {})
{
    const std::string dumpHead = "[ASSERT] %s:%u: %s: Assertion '%s' failed. ";
    const std::string fmt = dumpHead + userFmt;
    const uint32_t resvOffset = isSimt ? RESV_LEN_SIMT : RESV_LEN;
    DumpInfoHead* head =
        WriteTlv(buf, isSimt ? cce::runtime::DumpType::DUMP_SIMT_ASSERT : cce::runtime::DumpType::DUMP_ASSERT, 0);
    uint8_t* infoMsg = head->infoMsg;
    (void)memset_s(infoMsg, resvOffset, 0, resvOffset);
    const uint64_t strOffset = (slots.size() + 1) * PRINT_ARG_LEN;
    (void)memcpy_s(infoMsg + resvOffset, sizeof(uint64_t), &strOffset, sizeof(uint64_t));
    for (size_t i = 0; i < slots.size(); ++i) {
        (void)memcpy_s(infoMsg + resvOffset + (i + 1) * PRINT_ARG_LEN, sizeof(uint64_t), &slots[i], sizeof(uint64_t));
    }
    for (size_t k = 0; (k < strSlotIdxs.size()) && (k < strArgs.size()); ++k) {
        const size_t slotIdx = strSlotIdxs[k];
        uint64_t strArgCursor = (slots.size() - slotIdx) * PRINT_ARG_LEN + fmt.size() + 1;
        for (size_t j = 0; j < k; ++j) {
            strArgCursor += strArgs[j].size() + 1;
        }
        (void)memcpy_s(
            infoMsg + resvOffset + (slotIdx + 1) * PRINT_ARG_LEN, sizeof(uint64_t), &strArgCursor, sizeof(uint64_t));
    }
    (void)memcpy_s(infoMsg + resvOffset + strOffset, fmt.size() + 1, fmt.c_str(), fmt.size() + 1);
    size_t off = resvOffset + strOffset + fmt.size() + 1;
    for (const auto& s : strArgs) {
        (void)memcpy_s(infoMsg + off, s.size() + 1, s.c_str(), s.size() + 1);
        off += s.size() + 1;
    }
    head->infoLen = static_cast<uint32_t>(off);
    return sizeof(DumpInfoHead) + head->infoLen;
}

static uint32_t BuildFloatSlot(float v)
{
    uint32_t bits = 0U;
    (void)memcpy_s(&bits, sizeof(bits), &v, sizeof(v));
    return bits;
}

static uint64_t BuildDoubleSlot(double v)
{
    uint64_t bits = 0U;
    (void)memcpy_s(&bits, sizeof(bits), &v, sizeof(v));
    return bits;
}

// 走完整 ParseDfxInfo 链路渲染并返回 stdout 捕获串
struct PrintfRenderHelper {
    struct BlockBuffer {
        std::vector<uint8_t> data;
        uint8_t* blockAddr = nullptr;
        uint8_t* dumpStartAddr = nullptr;

        explicit BlockBuffer(uint32_t dataAreaSize)
        {
            const uint32_t totalSize =
                sizeof(BlockInfo) + sizeof(BlockReadInfo) + dataAreaSize + sizeof(BlockWriteInfo);
            data.resize(totalSize, 0);
            blockAddr = data.data();
            auto* blockInfo = reinterpret_cast<BlockInfo*>(blockAddr);
            blockInfo->remainLen = dataAreaSize;
            blockInfo->magic = 0xAE86U;
            auto* writeInfo = reinterpret_cast<BlockWriteInfo*>(blockAddr + totalSize - sizeof(BlockWriteInfo));
            writeInfo->packIdx = std::numeric_limits<uint64_t>::max();
            dumpStartAddr = blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo);
        }
    };

    static std::string Render(
        const std::vector<uint64_t>& slots, const std::string& fmt, const std::vector<std::string>& strArgs = {},
        bool isSimt = false, const std::vector<size_t>& strSlotIdxs = {})
    {
        BlockBuffer block(1024);
        std::vector<size_t> idxs = strSlotIdxs;
        if (idxs.empty() && !strArgs.empty()) {
            for (size_t k = 0; k < strArgs.size(); ++k) {
                idxs.push_back(slots.size() - strArgs.size() + k);
            }
        }
        const uint32_t tlvLen = BuildPrintfSlotsTlv(block.dumpStartAddr, fmt, slots, strArgs, isSimt, idxs);
        uint64_t consumedLen = 0U;
        const uint32_t coreType = isSimt ? 2U : 0U;
        rtDfxParseParam param;
        (void)memset_s(&param, sizeof(param), 0, sizeof(param));
        param.data = block.blockAddr;
        param.datalen = block.data.size();
        param.readIdx = 0;
        param.writeIdx = tlvLen;
        param.coreType = coreType;
        param.coreId = 0U;
        param.deviceId = 0U;
        testing::internal::CaptureStdout();
        DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
        return testing::internal::GetCapturedStdout();
    }

    // slog stub 把 IDE_LOGx 也打到捕获流，且告警与渲染同线交错；
    // 逐段剥离日志行（从 [LEVEL] 前缀起删到行尾），保留全部渲染文本
    static std::string RenderExact(
        const std::vector<uint64_t>& slots, const std::string& fmt, const std::vector<std::string>& strArgs = {},
        bool isSimt = false, const std::vector<size_t>& strSlotIdxs = {})
    {
        const std::string output = Render(slots, fmt, strArgs, isSimt, strSlotIdxs);
        static const char* logTags[] = {"[INFO]", "[WARING]", "[ERROR]", "[DEBUG]"};
        std::string render;
        size_t pos = 0U;
        while (pos < output.size()) {
            size_t cut = std::string::npos;
            for (const char* tag : logTags) {
                const size_t p = output.find(tag, pos);
                if (p != std::string::npos && (cut == std::string::npos || p < cut)) {
                    cut = p;
                }
            }
            if (cut == std::string::npos) {
                render += output.substr(pos);
                break;
            }
            render += output.substr(pos, cut - pos);
            const size_t nl = output.find('\n', cut);
            pos = (nl == std::string::npos) ? output.size() : nl + 1U;
        }
        return render;
    }

    // 对齐 asc_printf_impl_assert_msg：dump_head 拼前缀 + assert 走 IDE_LOGE 日志级别
    static std::string RenderAssert(
        const std::string& userFmt, const std::vector<uint64_t>& slots, const std::vector<std::string>& strArgs,
        bool isSimt, const std::vector<size_t>& strSlotIdxs)
    {
        BlockBuffer block(1024);
        const uint32_t tlvLen =
            BuildAssertMsgSlotsTlv(block.dumpStartAddr, userFmt, slots, strArgs, isSimt, strSlotIdxs);
        uint64_t consumedLen = 0U;
        const uint32_t coreType = isSimt ? 2U : 0U;
        rtDfxParseParam param;
        (void)memset_s(&param, sizeof(param), 0, sizeof(param));
        param.data = block.blockAddr;
        param.datalen = block.data.size();
        param.readIdx = 0;
        param.writeIdx = tlvLen;
        param.coreType = coreType;
        param.coreId = 0U;
        testing::internal::CaptureStdout();
        DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
        return testing::internal::GetCapturedStdout();
    }
};

static std::string RenderPrintfSlots(
    const std::vector<uint64_t>& slots, const std::string& fmt, const std::vector<std::string>& strArgs = {},
    bool isSimt = false, const std::vector<size_t>& strSlotIdxs = {})
{
    return PrintfRenderHelper::Render(slots, fmt, strArgs, isSimt, strSlotIdxs);
}

static std::string RenderPrintfExact(
    const std::vector<uint64_t>& slots, const std::string& fmt, const std::vector<std::string>& strArgs = {},
    bool isSimt = false, const std::vector<size_t>& strSlotIdxs = {})
{
    return PrintfRenderHelper::RenderExact(slots, fmt, strArgs, isSimt, strSlotIdxs);
}

// 与实现一致的 width 上限（超限钳制）
static constexpr int32_t MAX_PRINT_WIDTH_REF = 1000000;

// oracle 期望串构造：与渲染实现同一 host snprintf
static std::string SnprintfRef(const char* fmt, ...)
{
    va_list args;
    va_start(args, fmt);
    va_list argsCopy;
    va_copy(argsCopy, args);
    const int32_t need = vsnprintf(nullptr, 0, fmt, argsCopy);
    va_end(argsCopy);
    std::string result;
    if (need >= 0) {
        std::vector<char> buf(static_cast<size_t>(need) + 1U);
        (void)vsnprintf(buf.data(), buf.size(), fmt, args);
        result.assign(buf.data(), static_cast<size_t>(need));
    }
    va_end(args);
    return result;
}

// flags 组合与 host snprintf 对拍
TEST(DfxPrintfParserUtest, Test_PrintfFormat_FlagsCombinations)
{
    EXPECT_EQ(RenderPrintfExact({42}, "%-5d|"), "42   |");
    EXPECT_EQ(RenderPrintfExact({42}, "%+d|"), "+42|");
    EXPECT_EQ(RenderPrintfExact({42}, "% d|"), " 42|");
    EXPECT_EQ(RenderPrintfExact({static_cast<uint64_t>(-42)}, "% d|"), "-42|");
    EXPECT_EQ(RenderPrintfExact({42}, "%05d|"), "00042|");
    EXPECT_EQ(RenderPrintfExact({255}, "%#x|"), "0xff|");
    EXPECT_EQ(RenderPrintfExact({5}, "% d"), " 5");
    EXPECT_EQ(RenderPrintfExact({6, 3}, "%0*d"), "000003"); // '*' width 先耗 1 槽，再耗值槽
    EXPECT_EQ(RenderPrintfExact({1}, "% 5d|"), "    1|");
    const double f = BuildDoubleSlot(3.14159);
    EXPECT_EQ(RenderPrintfExact({f}, "%-+8.2f|"), "+3.14   |");
    EXPECT_EQ(RenderPrintfExact({BuildFloatSlot(2.5f), 7}, "%f %d"), "2.500000 7");
}

// specifier 补齐项 o e E g G a A c 与 host snprintf 对拍
TEST(DfxPrintfParserUtest, Test_PrintfFormat_AllSpecifiers)
{
    EXPECT_EQ(RenderPrintfExact({8}, "%o"), SnprintfRef("%o", 8));
    EXPECT_EQ(RenderPrintfExact({BuildDoubleSlot(100000.0)}, "%e"), SnprintfRef("%e", 100000.0));
    EXPECT_EQ(RenderPrintfExact({BuildFloatSlot(100000.0f)}, "%E"), SnprintfRef("%E", 100000.0));
    EXPECT_EQ(RenderPrintfExact({BuildDoubleSlot(0.00001234)}, "%g"), SnprintfRef("%g", 0.00001234));
    EXPECT_EQ(RenderPrintfExact({BuildDoubleSlot(0.00001234)}, "%G"), SnprintfRef("%G", 0.00001234));
    EXPECT_EQ(RenderPrintfExact({BuildDoubleSlot(255.5)}, "%a"), SnprintfRef("%a", 255.5));
    EXPECT_EQ(RenderPrintfExact({BuildDoubleSlot(255.5)}, "%A"), SnprintfRef("%A", 255.5));
    EXPECT_EQ(RenderPrintfExact({'A'}, "%c"), "A");
    EXPECT_EQ(RenderPrintfExact({65}, "%c"), SnprintfRef("%c", 65));
}

// length 修饰符：hh/h 截断、l/ll 64 位、z/Z/t/j、无 length 截断语义（设计 §2.4-3：按 C 标准读 32 位）
TEST(DfxPrintfParserUtest, Test_PrintfFormat_LengthModifiers)
{
    EXPECT_EQ(RenderPrintfExact({0x1234'5678'9ABC'DEFFULL}, "%hhx"), SnprintfRef("%hhx", 0x9ABC'DEFFU));
    EXPECT_EQ(RenderPrintfExact({0x1234'5678'9ABC'DEFFULL}, "%hx"), SnprintfRef("%hx", 0x9ABC'DEFFU));
    EXPECT_EQ(RenderPrintfExact({0x1234'5678'9ABC'DEFFULL}, "%hhd"), SnprintfRef("%hhd", 0x9ABC'DEFF));
    EXPECT_EQ(RenderPrintfExact({static_cast<uint64_t>(-1)}, "%zu"), SnprintfRef("%zu", static_cast<size_t>(-1)));
    EXPECT_EQ(RenderPrintfExact({static_cast<uint64_t>(-1)}, "%Zu"), SnprintfRef("%zu", static_cast<size_t>(-1)));
    EXPECT_EQ(RenderPrintfExact({static_cast<uint64_t>(-1)}, "%td"), SnprintfRef("%td", static_cast<ptrdiff_t>(-1)));
    EXPECT_EQ(RenderPrintfExact({static_cast<uint64_t>(-1)}, "%ju"), SnprintfRef("%ju", static_cast<uintmax_t>(-1)));
    EXPECT_EQ(RenderPrintfExact({static_cast<uint64_t>(INT64_MAX)}, "%ld"), SnprintfRef("%ld", INT64_MAX));
    EXPECT_EQ(RenderPrintfExact({static_cast<uint64_t>(INT64_MIN)}, "%ld"), SnprintfRef("%ld", INT64_MIN));
    EXPECT_EQ(RenderPrintfExact({UINT64_MAX}, "%lu"), SnprintfRef("%lu", UINT64_MAX));
    EXPECT_EQ(RenderPrintfExact({UINT64_MAX}, "%lx"), SnprintfRef("%lx", UINT64_MAX));
    // 越界误用（int64 配 %d）：按 C 标准截断低 32 位（设计 §4.5 修复项，如 0x7FFFFFFFFFFFFFF8→-8）
    EXPECT_EQ(RenderPrintfExact({static_cast<uint64_t>(0x7FFFFFFFFFFFFFFFLL - 7LL)}, "%d"), "-8");
    EXPECT_EQ(RenderPrintfExact({0xFFFFFFFFFFFFFFFFULL}, "%x"), "ffffffff");
    EXPECT_EQ(RenderPrintfExact({0xFFFFFFFFFFFFFFFFULL}, "%u"), "4294967295");
}

// 边界值：INT64_MIN/MAX、±0.0、nan/inf、%F 大写化
TEST(DfxPrintfParserUtest, Test_PrintfFormat_BoundaryValues)
{
    EXPECT_EQ(RenderPrintfExact({static_cast<uint64_t>(INT64_MIN)}, "%lld"), SnprintfRef("%lld", INT64_MIN));
    EXPECT_EQ(RenderPrintfExact({static_cast<uint64_t>(INT64_MAX)}, "%lld"), SnprintfRef("%lld", INT64_MAX));
    EXPECT_EQ(RenderPrintfExact({0}, "%d"), "0");
    EXPECT_EQ(RenderPrintfExact({BuildDoubleSlot(-0.0)}, "%f"), SnprintfRef("%f", -0.0));
    const double nanVal = std::numeric_limits<double>::quiet_NaN();
    const double infVal = std::numeric_limits<double>::infinity();
    EXPECT_EQ(RenderPrintfExact({BuildDoubleSlot(nanVal)}, "%f"), SnprintfRef("%f", nanVal));
    EXPECT_EQ(RenderPrintfExact({BuildDoubleSlot(infVal)}, "%f"), SnprintfRef("%f", infVal));
    EXPECT_EQ(RenderPrintfExact({BuildDoubleSlot(nanVal)}, "%F"), SnprintfRef("%F", nanVal));
    EXPECT_EQ(RenderPrintfExact({BuildDoubleSlot(infVal)}, "%F"), SnprintfRef("%F", infVal));
    EXPECT_EQ(RenderPrintfExact({BuildFloatSlot(std::numeric_limits<float>::quiet_NaN())}, "%f"), "nan");
}

// 浮点启发式：float32/double 槽消歧、%lf 强制 8B
TEST(DfxPrintfParserUtest, Test_PrintfFormat_FloatHeuristic)
{
    EXPECT_EQ(RenderPrintfExact({BuildFloatSlot(3.5f)}, "%f"), SnprintfRef("%f", 3.5));
    EXPECT_EQ(RenderPrintfExact({BuildDoubleSlot(123.456)}, "%f"), SnprintfRef("%f", 123.456));
    EXPECT_EQ(RenderPrintfExact({BuildDoubleSlot(654.321)}, "%lf"), SnprintfRef("%f", 654.321));
    double slotView = 0.0;
    const uint32_t floatBits = BuildFloatSlot(9.5f);
    (void)memcpy_s(&slotView, sizeof(slotView), &floatBits, sizeof(floatBits)); // 复刻槽内 8B 布局
    EXPECT_EQ(
        RenderPrintfExact({static_cast<uint64_t>(*reinterpret_cast<uint64_t*>(&slotView))}, "%lf"),
        SnprintfRef("%f", slotView));
}

// width/precision：数字/`*`/`.*`/负值/`.`后无数字
TEST(DfxPrintfParserUtest, Test_PrintfFormat_WidthPrecision)
{
    EXPECT_EQ(RenderPrintfExact({42}, "%10d|"), "        42|");
    EXPECT_EQ(RenderPrintfExact({42}, "%-10d|"), "42        |");
    EXPECT_EQ(RenderPrintfExact({BuildDoubleSlot(3.14159)}, "%.2f"), "3.14");
    EXPECT_EQ(RenderPrintfExact({2, BuildDoubleSlot(3.14159)}, "%.*f"), "3.14");
    EXPECT_EQ(RenderPrintfExact({7, 42}, "%*d"), "     42");
    EXPECT_EQ(RenderPrintfExact({static_cast<uint64_t>(-7), 42}, "%*d"), "42     "); // 负 width -> '-' 标志 + 绝对值
    EXPECT_EQ(RenderPrintfExact({BuildDoubleSlot(5.0)}, "%.f"), "5");
    EXPECT_EQ(RenderPrintfExact({42}, "%.3d"), "042");
    EXPECT_EQ(RenderPrintfExact({static_cast<uint64_t>(-2), BuildDoubleSlot(2.5)}, "%.*f"), "2.500000");
}

// width 超上限钳制到 1M，渲染不溢出；整条累计超 MAX_PRINT_RECORD(1M) 后停渲染降级
TEST(DfxPrintfParserUtest, Test_PrintfFormat_WidthClamped)
{
    const std::string output = RenderPrintfSlots({1}, "%999999999d");
    EXPECT_NE(output.find("exceeds max"), std::string::npos);
    // 剥离日志行后应恰为 1M 字符（999999 空格 + '1'）
    static const char* logTags[] = {"[INFO]", "[WARING]", "[ERROR]", "[DEBUG]"};
    std::string render;
    size_t pos = 0U;
    while (pos < output.size()) {
        size_t cut = std::string::npos;
        for (const char* tag : logTags) {
            const size_t p = output.find(tag, pos);
            if (p != std::string::npos && (cut == std::string::npos || p < cut)) {
                cut = p;
            }
        }
        if (cut == std::string::npos) {
            render += output.substr(pos);
            break;
        }
        render += output.substr(pos, cut - pos);
        const size_t nl = output.find('\n', cut);
        pos = (nl == std::string::npos) ? output.size() : nl + 1U;
    }
    EXPECT_EQ(render.size(), static_cast<size_t>(MAX_PRINT_WIDTH_REF));

    // 三个 1M 宽 directive：前两个渲染后累计超 MAX_PRINT_RECORD(1MiB)，第三个停渲染降级
    const std::string overRaw = RenderPrintfSlots({1, 2, 3}, "%999999999d a %999999999d b %999999999d c");
    EXPECT_NE(overRaw.find("rest directives are kept as-is"), std::string::npos) << overRaw;
    const std::string overRender = RenderPrintfExact({1, 2, 3}, "%999999999d a %999999999d b %999999999d c");
    EXPECT_EQ(overRender.substr(overRender.size() - 13U), "%999999999d c"); // 第三个原文回显 + 尾部字面量保留
    EXPECT_LT(overRender.size(), 2500000U); // 第三个不再渲染（若全渲染应 ≥3M）
}

// '*' 路径的 width/precision 槽值超上限同样钳制到 1M（与字面量路径同口径），
// 防止设备侧/损坏 dump 写入超大槽值导致探测阶段长时间占用 CPU 或 GB 级分配
TEST(DfxPrintfParserUtest, Test_PrintfFormat_StarClamped)
{
    // %*d 且 width 槽 = INT32_MAX：钳制告警 + 渲染恰好 1M 字符
    const std::string widthOut = RenderPrintfSlots({static_cast<uint64_t>(INT32_MAX), 7}, "%*d");
    EXPECT_NE(widthOut.find("exceeds max"), std::string::npos) << widthOut;
    static const char* logTags[] = {"[INFO]", "[WARING]", "[ERROR]", "[DEBUG]"};
    std::string render;
    size_t pos = 0U;
    while (pos < widthOut.size()) {
        size_t cut = std::string::npos;
        for (const char* tag : logTags) {
            const size_t p = widthOut.find(tag, pos);
            if (p != std::string::npos && (cut == std::string::npos || p < cut)) {
                cut = p;
            }
        }
        if (cut == std::string::npos) {
            render += widthOut.substr(pos);
            break;
        }
        render += widthOut.substr(pos, cut - pos);
        const size_t nl = widthOut.find('\n', cut);
        pos = (nl == std::string::npos) ? widthOut.size() : nl + 1U;
    }
    EXPECT_EQ(render.size(), static_cast<size_t>(MAX_PRINT_WIDTH_REF));
    EXPECT_EQ(render.back(), '7');

    // %.*f 且 precision 槽 = INT32_MAX：钳制告警 + 渲染不超 1M（且不长时间阻塞）
    const std::string precOut = RenderPrintfSlots({static_cast<uint64_t>(INT32_MAX), BuildDoubleSlot(1.0)}, "%.*f");
    EXPECT_NE(precOut.find("exceeds max"), std::string::npos) << precOut;
    EXPECT_NE(precOut.find("1.000000"), std::string::npos) << precOut;
}

// 超长输出（>512B）动态分配缓冲，分片打屏完整
TEST(DfxPrintfParserUtest, Test_PrintfFormat_LongFieldOutput)
{
    // 剥离与渲染同线交错的日志段（printf 不补换行）
    const auto stripLogParts = [](const std::string& s) {
        static const char* logTags[] = {"[INFO]", "[WARING]", "[ERROR]", "[DEBUG]"};
        std::string out;
        size_t pos = 0U;
        while (pos < s.size()) {
            size_t cut = std::string::npos;
            for (const char* tag : logTags) {
                const size_t p = s.find(tag, pos);
                if (p != std::string::npos && (cut == std::string::npos || p < cut)) {
                    cut = p;
                }
            }
            if (cut == std::string::npos) {
                out += s.substr(pos);
                break;
            }
            out += s.substr(pos, cut - pos);
            const size_t nl = s.find('\n', cut);
            pos = (nl == std::string::npos) ? s.size() : nl + 1U;
        }
        return out;
    };
    const std::string expect = SnprintfRef("%.30f", std::numeric_limits<double>::max());
    const std::string output =
        stripLogParts(RenderPrintfSlots({BuildDoubleSlot(std::numeric_limits<double>::max())}, "%.30f"));
    EXPECT_EQ(output, expect);
    // %.256f × 10：渲染超 2560B，验证动态分配缓冲
    std::vector<uint64_t> slots(10, BuildDoubleSlot(1.0 / 3.0));
    const std::string out10 = stripLogParts(
        RenderPrintfSlots(slots, "%.256f %.256f %.256f %.256f %.256f %.256f %.256f %.256f %.256f %.256f"));
    EXPECT_GT(out10.size(), 2560U);
    EXPECT_EQ(
        out10, SnprintfRef(
                   "%.256f %.256f %.256f %.256f %.256f %.256f %.256f %.256f %.256f %.256f", 1.0 / 3.0, 1.0 / 3.0,
                   1.0 / 3.0, 1.0 / 3.0, 1.0 / 3.0, 1.0 / 3.0, 1.0 / 3.0, 1.0 / 3.0, 1.0 / 3.0, 1.0 / 3.0));
}

// %p 与 host snprintf 对拍
TEST(DfxPrintfParserUtest, Test_PrintfFormat_Pointer)
{
    const uint64_t addr = 0x1234abcdULL;
    EXPECT_EQ(RenderPrintfExact({addr}, "ptr=%p"), SnprintfRef("ptr=%p", reinterpret_cast<void*>(addr)));
    EXPECT_EQ(RenderPrintfExact({0}, "%p"), SnprintfRef("%p", reinterpret_cast<void*>(0)));
}

// 异常 directive 三路径统一语义：原文照抄、不占槽、扫描走完 fmt
//   解析期失败（%q/%lll/%5尾）：回显原文 + 继续【渲染】（CPU 同构，0 槽不偷参）
//   组合违例（%n/%hhf/%lc 等）：回显原文 + 停渲染【降级】——后续 directive 全按原文输出（避免槽错位）
//   参数不足：保留原文 + 继续【渲染】（0 槽不偷参）
TEST(DfxPrintfParserUtest, Test_PrintfFormat_FaultTolerance)
{
    // 解析期失败：坏点回显原文，前后合法 directive 照常渲染取参（0 槽）
    EXPECT_EQ(RenderPrintfExact({11, 33, 44}, "a=%d b=%llld c=%d"), "a=11 b=%llld c=33");
    EXPECT_EQ(RenderPrintfExact({555123}, "head %z tail %d"), "head %z tail 555123");
    EXPECT_EQ(RenderPrintfExact({1, 888}, "a=%d b=%z c=%d"), "a=1 b=%z c=888");
    EXPECT_EQ(RenderPrintfExact({33}, "a=%llld b=%ld"), "a=%llld b=33");
    // 回显无长度上限（MAX_DIR_MSG_LEN 仅限告警文本）：40 个 q 全量
    EXPECT_EQ(
        RenderPrintfExact({}, "cut:%qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"),
        "cut:%qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");
    EXPECT_EQ(RenderPrintfExact({}, "x%qy%qw%qz"), "x%qy%qw%qz");
    EXPECT_EQ(RenderPrintfExact({}, "a%5"), "a%5");

    // 组合违例：违例 directive 原文照抄 + 停渲染降级（尾部不丢、directive 不再取参）
    EXPECT_EQ(RenderPrintfExact({}, "a%n b=%d end"), "a%n b=%d end");
    EXPECT_EQ(RenderPrintfExact({1, 777}, "a=%d b%n c=%d"), "a=1 b%n c=%d"); // 777 不再消费
    EXPECT_EQ(RenderPrintfExact({}, "a%hhf done"), "a%hhf done");
    EXPECT_EQ(RenderPrintfExact({}, "%n %% end"), "%n %% end");              // 降级后 %% 保持原文

    // 参数不足：缺参 directive 原文保留，前后照常渲染
    EXPECT_EQ(RenderPrintfExact({42}, "a=%d b=%d end"), "a=42 b=%d end");
    EXPECT_EQ(RenderPrintfExact({42}, "a=%d b=%s c=%d end"), "a=42 b=%s c=%d end");
    EXPECT_EQ(RenderPrintfExact({7}, "w=%*d|"), "w=%*d|");
    EXPECT_EQ(RenderPrintfExact({}, "[%10d][%-+08.3ld][%#x][%.*f]"), "[%10d][%-+08.3ld][%#x][%.*f]");

    // 边界：串尾悬空 %、%%
    EXPECT_EQ(RenderPrintfExact({}, "end%"), "end%");
    EXPECT_EQ(RenderPrintfExact({}, "100%% done"), "100% done");

    // 告警存在性（违例走 "Illegal conversion directive"，解析失败走 "is illegal"）
    std::string output = RenderPrintfSlots({}, "a%n");
    EXPECT_NE(output.find("Illegal conversion"), std::string::npos) << output;
    output = RenderPrintfSlots({BuildDoubleSlot(1.0)}, "a%llf");
    EXPECT_NE(output.find("Illegal conversion"), std::string::npos) << output;
    output = RenderPrintfSlots({}, "a%lc");
    EXPECT_NE(output.find("Illegal conversion"), std::string::npos) << output;
    output = RenderPrintfSlots({}, "a%q");
    EXPECT_NE(output.find("is illegal"), std::string::npos) << output;
    output = RenderPrintfSlots({42}, "a=%d b=%d");
    EXPECT_NE(output.find("Too many placeholders"), std::string::npos) << output;
}

// %s precision 截断（%.Ns）
TEST(DfxPrintfParserUtest, Test_PrintfFormat_StringPrecision)
{
    const std::string output = RenderPrintfExact({UINT64_MAX}, "msg=%.3s", {"hello"});
    EXPECT_EQ(output, "msg=hel");
}

// SIMT 链路（40B 预留区）同格式语法渲染一致
TEST(DfxPrintfParserUtest, Test_PrintfFormat_SimtFullSyntax)
{
    EXPECT_EQ(RenderPrintfExact({42}, "val=%-6d|", {}, true), "val=42    |");
    EXPECT_EQ(RenderPrintfExact({BuildFloatSlot(1.5f)}, "f=%08.2f", {}, true), "f=00001.50");
    EXPECT_EQ(RenderPrintfExact({UINT64_MAX}, "s=%s", {"simt"}, true), "s=simt");
}

// 对齐 asc_printf_impl_assert_msg：设备侧把 "[ASSERT] %s:%u: %s: Assertion '%s' failed. " dump_head
// 拼在用户 fmt 前，实参为 file/line/function/assertion(+用户实参)——%s 偏移按槽序独立
TEST(DfxPrintfParserUtest, Test_PrintfFormat_SimtAssertMsgHead)
{
    const std::string file = "vec_add.cpp";
    const uint64_t line = 128U;
    const std::string func = "DoCompute";
    const std::string assertion = "x > 0";
    const int32_t userVal = 3;
    // 槽序：file(0) line(1) func(2) assertion(3) userVal(4)；%s 取 file/func/assertion
    const std::string output = PrintfRenderHelper::RenderAssert(
        "val=%d", {0U, line, 0U, 0U, static_cast<uint64_t>(static_cast<int64_t>(userVal))}, {file, func, assertion},
        true, {0U, 2U, 3U});
    const std::string expect = SnprintfRef(
        "[ASSERT] %s:%u: %s: Assertion '%s' failed. val=%d", file.c_str(), static_cast<uint32_t>(line), func.c_str(),
        assertion.c_str(), userVal);
    // assert 走 IDE_LOGE，渲染段与日志行同线交错：截首个日志前缀前断言
    static const char* logTags[] = {"[INFO]", "[WARING]", "[ERROR]", "[DEBUG]"};
    size_t logPos = std::string::npos;
    for (const char* tag : logTags) {
        const size_t p = output.find(tag);
        if (p != std::string::npos && (logPos == std::string::npos || p < logPos)) {
            logPos = p;
        }
    }
    const std::string renderPart = (logPos == std::string::npos) ? output : output.substr(0, logPos);
    EXPECT_EQ(renderPart, expect) << output;
}

// 存量正确用法零变化回归（§4.5）
TEST(DfxPrintfParserUtest, Test_PrintfFormat_LegacyCompat)
{
    EXPECT_EQ(RenderPrintfExact({42}, "value=%d"), "value=42");
    EXPECT_EQ(RenderPrintfExact({static_cast<uint64_t>(-7)}, "%i"), "-7");
    EXPECT_EQ(RenderPrintfExact({100}, "%u"), "100");
    EXPECT_EQ(RenderPrintfExact({0xABCD}, "%x"), SnprintfRef("%x", 0xABCD));
    EXPECT_EQ(RenderPrintfExact({0xABCD}, "%X"), SnprintfRef("%X", 0xABCD));
    EXPECT_EQ(RenderPrintfExact({123456}, "%ld"), "123456");
    EXPECT_EQ(RenderPrintfExact({789012}, "%lld"), "789012");
    EXPECT_EQ(RenderPrintfExact({999}, "%lu"), "999");
    EXPECT_EQ(RenderPrintfExact({888}, "%llu"), "888");
    EXPECT_EQ(RenderPrintfExact({0xDEAD}, "%lx"), SnprintfRef("%lx", 0xDEAD));
    EXPECT_EQ(RenderPrintfExact({0xBEEF}, "%llx"), SnprintfRef("%llx", 0xBEEF));
    EXPECT_EQ(RenderPrintfExact({0xCAFE}, "%lX"), SnprintfRef("%lX", 0xCAFE));
    EXPECT_EQ(RenderPrintfExact({0xFACE}, "%llX"), SnprintfRef("%llX", 0xFACE));
    EXPECT_EQ(RenderPrintfExact({BuildFloatSlot(3.14f)}, "val=%f"), "val=3.140000");
}

// %s 偏移越界：告警 + 跳过该参数，后续照常续打
TEST(DfxPrintfParserUtest, Test_PrintfFormat_StringInvalidOffset)
{
    const std::string output = RenderPrintfSlots({UINT64_MAX, 55}, "a=%s b=%d");
    EXPECT_NE(output.find("Invalid string param offset"), std::string::npos) << output;
    EXPECT_EQ(output.find("a=hello"), std::string::npos) << output;
    EXPECT_NE(output.find("b=55"), std::string::npos) << output;
}

// 混合类型长记录（%s 居中）与 snprintf 对拍
TEST(DfxPrintfParserUtest, Test_PrintfFormat_MixedLongRecord)
{
    const int32_t i32 = -123456;
    const uint64_t u64 = 0xDEADBEEFCAFEBABEULL;
    const double dbl = 2.718281828;
    const char* str = "mixed";
    const uint64_t ptr = 0x7f0000abc000ULL;
    const std::string expect =
        SnprintfRef("i=%d u=%#llx f=%.6f s=%s p=%p ok", i32, u64, dbl, str, reinterpret_cast<void*>(ptr));
    const std::string output = RenderPrintfExact(
        {static_cast<uint64_t>(static_cast<int64_t>(i32)), u64, BuildDoubleSlot(dbl), 0U, ptr},
        "i=%d u=%#llx f=%.6f s=%s p=%p ok", {str}, false, {3U});
    EXPECT_EQ(output, expect);
}

// 纯正文与空格式串原样输出
TEST(DfxPrintfParserUtest, Test_PrintfFormat_PlainTextAndEmpty)
{
    EXPECT_EQ(RenderPrintfExact({}, "plain text"), "plain text");
    EXPECT_EQ(RenderPrintfExact({}, ""), "");
}

// 多 %s 实参槽偏移独立
TEST(DfxPrintfParserUtest, Test_PrintfFormat_MultipleStrings)
{
    const std::string output = RenderPrintfExact({UINT64_MAX, UINT64_MAX}, "first=%s second=%s", {"one", "two"});
    EXPECT_EQ(output, "first=one second=two");
}

TEST(DfxPrintfParserUtest, Test_PrintfFormat_ArgsNumExceedsInfoLen)
{
    // 槽区布局与真实 dump 一致：argsBase 首槽为 strOffset 占位（下标 0），值槽从下标 1 起
    std::vector<uint8_t> argsArea(5U * PRINT_ARG_LEN, 0U); // 占位 + 4 值槽
    auto writeSlot = [&argsArea](const size_t idx, const uint64_t v) {
        (void)memcpy_s(argsArea.data() + idx * PRINT_ARG_LEN, sizeof(uint64_t), &v, sizeof(uint64_t));
    };
    writeSlot(1U, 11U); // 值槽 1（第 1 个实参）
    writeSlot(2U, 22U);
    writeSlot(3U, 33U);
    const uint64_t fullInfoLen = RESV_LEN + argsArea.size();
    // 正常基线：3 值槽 + 1 富余槽，argsNum 与 infoLen 一致，%d 正常渲染
    {
        const Adx::PrintfRenderCtx ctx{argsArea.data(), 3U, fullInfoLen, RESV_LEN};
        testing::internal::CaptureStdout();
        Adx::ParsePrintToLog("a=%d b=%d", ctx, false);
        const std::string output = testing::internal::GetCapturedStdout();
        EXPECT_NE(output.find("a=11 b=22"), std::string::npos) << output;
    }

    // argsNum=8 声称 8 值槽，但 infoLen 只覆盖占位 + 2 值槽 —— 第 3 槽起读取必须被拦为参数不足
    {
        const uint64_t twoSlotInfoLen = RESV_LEN + 3U * PRINT_ARG_LEN; // 占位 + 2 值槽
        const Adx::PrintfRenderCtx ctx{argsArea.data(), 8U, twoSlotInfoLen, RESV_LEN};
        testing::internal::CaptureStdout();
        Adx::ParsePrintToLog("x=%d y=%d z=%d", ctx, false);
        const std::string output = testing::internal::GetCapturedStdout();
        EXPECT_NE(output.find("exceeds args area"), std::string::npos) << output;     // 收敛告警存在
        EXPECT_NE(output.find("x=11"), std::string::npos) << output;                  // 区内首槽正常渲染
        EXPECT_NE(output.find("y=22"), std::string::npos) << output;                  // 区内次槽正常渲染
        EXPECT_EQ(output.find("z=33"), std::string::npos) << output;                  // 越界槽不渲染值
        EXPECT_NE(output.find("Too many placeholders"), std::string::npos) << output; // 拦为参数不足
        EXPECT_NE(output.find("z=%d"), std::string::npos) << output;                  // 原文回显
    }

    // infoLen 小到不含任何完整值槽：全部 directive 拦为参数不足，原文回显
    {
        const uint64_t zeroSlotInfoLen = RESV_LEN + PRINT_ARG_LEN; // 仅占位槽
        const Adx::PrintfRenderCtx ctx{argsArea.data(), 5U, zeroSlotInfoLen, RESV_LEN};
        testing::internal::CaptureStdout();
        Adx::ParsePrintToLog("x=%d", ctx, false);
        const std::string output = testing::internal::GetCapturedStdout();
        EXPECT_NE(output.find("Too many placeholders"), std::string::npos) << output;
        EXPECT_EQ(output.find("x=11"), std::string::npos) << output;
        EXPECT_NE(output.find("x=%d"), std::string::npos) << output;
    }
}
