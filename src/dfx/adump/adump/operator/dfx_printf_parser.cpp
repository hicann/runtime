/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dfx_printf_parser.h"

#include <cstdio>
#include <cstring>
#include <string>
#include <vector>

#include "log/hdc_log.h"

namespace Adx {
namespace {

constexpr uint32_t PRINTF_ARG_LEN = 8U;       // 参数槽宽度
constexpr size_t PRINTF_LOG_SLICE_LEN = 256U; // 打屏/写日志分片长度

constexpr int32_t PRINT_WIDTH_STAR = -2;      // width='*'：渲染时先取一个参数槽
constexpr int32_t PRINT_PREC_STAR = -2;       // precision='.*'：渲染时先取一个参数槽
constexpr int32_t MAX_PRINT_WIDTH = 1000000;  // width/precision/渲染长度上限，超限钳制
constexpr int32_t MAX_PRINT_PRECISION = 1000000;
constexpr int32_t MAX_PRINT_FIELD = 1000000;
constexpr size_t MAX_PRINT_RECORD = 1024U * 1024U; // 整条渲染结果上限：超限转降级（后续 directive 原文输出）
constexpr uint32_t MAX_DIR_MSG_LEN = 32U; // 非法 directive 文本截取上限

constexpr size_t PRINT_RENDER_VIOLATION = SIZE_MAX; // 返回哨兵：组合违例（%n/%hhf 等），调用方回显原文并降级
constexpr size_t PRINT_RENDER_MISSING = SIZE_MAX - 1; // 返回哨兵：参数不足，调用方回显原文继续渲染

inline bool IsPrintConvChar(const char c)
{
    return (
        (c == 'd') || (c == 'i') || (c == 'u') || (c == 'o') || (c == 'x') || (c == 'X') || (c == 'f') || (c == 'F') ||
        (c == 'e') || (c == 'E') || (c == 'g') || (c == 'G') || (c == 'a') || (c == 'A') || (c == 'c') || (c == 's') ||
        (c == 'p') || (c == '%') || (c == 'n'));
}

inline bool IsPrintFloatConv(const char c)
{
    return (
        (c == 'f') || (c == 'F') || (c == 'e') || (c == 'E') || (c == 'g') || (c == 'G') || (c == 'a') || (c == 'A'));
}

inline bool IsPrintDigit(const char c) { return (c >= '0') && (c <= '9'); }

/**
 * @brief      吸收 printf directive 的 flags 段（'-', '+', ' ', '#', '0'，可重复）
 * @param [in] fmt: '%' 之后待解析的格式串
 * @param [out] spec: 解析结果写入 flags 字段
 * @return     消费的字符数
 */
size_t ParsePrintFlags(const char* fmt, PrintfSpec& spec)
{
    size_t idx = 0U;
    while (true) {
        const char c = fmt[idx];
        if (c == '-') {
            spec.leftAlign = true;
        } else if (c == '+') {
            spec.plusSign = true;
        } else if (c == ' ') {
            spec.spaceSign = true;
        } else if (c == '#') {
            spec.altForm = true;
        } else if (c == '0') {
            spec.zeroPad = true;
        } else {
            return idx;
        }
        ++idx;
    }
}

/**
 * @brief      解析 width/precision 的十进制数字串；超上限继续吸收剩余数字（防误当 conv）并钳制到上限
 * @param [in] fmt: '%' 之后待解析的格式串
 * @param [in,out] idx: 当前解析位置，随数字吸收前移
 * @param [in] maxVal: 数字上限，超限钳制
 * @return     解析出的数值（钳制后）；无数字返回 0
 */
int64_t ParsePrintNumber(const char* fmt, size_t& idx, const int32_t maxVal)
{
    int64_t val = 0;
    bool hasDigit = false;
    while (IsPrintDigit(fmt[idx])) {
        hasDigit = true;
        val = val * 10 + static_cast<int64_t>(fmt[idx] - '0');
        if (val > maxVal) {
            val = static_cast<int64_t>(maxVal) + 1;
        }
        ++idx;
    }
    if (hasDigit && (val > maxVal)) {
        IDE_LOGW("Print value[%lld] exceeds max[%d], clamp to max.", static_cast<long long>(val), maxVal);
        val = maxVal;
    }
    return val;
}

/**
 * @brief      解析 length 修饰符（hh h l ll z Z t j）；大写 'L' 按 AscendC 不支持 long double 拒绝
 * @param [in] fmt: '%' 之后待解析的格式串
 * @param [in,out] idx: 当前解析位置，随修饰符吸收前移
 * @param [out] spec: 解析结果写入 length 字段；'L' 时 conv 置 '\0'
 * @return     true=合法；false=遇 'L'（拒绝）
 */
bool ParsePrintLength(const char* fmt, size_t& idx, PrintfSpec& spec)
{
    if (fmt[idx] == 'l') {
        ++idx;
        spec.length = (fmt[idx] == 'l') ? (idx++, PrintfLength::LL) : PrintfLength::L;
    } else if (fmt[idx] == 'h') {
        ++idx;
        spec.length = (fmt[idx] == 'h') ? (idx++, PrintfLength::HH) : PrintfLength::H;
    } else if ((fmt[idx] == 'z') || (fmt[idx] == 'Z')) {
        spec.length = PrintfLength::Z;
        ++idx;
    } else if (fmt[idx] == 't') {
        spec.length = PrintfLength::T;
        ++idx;
    } else if (fmt[idx] == 'j') {
        spec.length = PrintfLength::J;
        ++idx;
    } else if (fmt[idx] == 'L') {
        IDE_LOGW("Print length modifier 'L'(long double) is not supported by AscendC printf.");
        spec.conv = '\0';
        return false;
    }
    return true;
}

/**
 * @brief      解析 '%' 之后的一个 directive，按 % [flags][width][.precision][length]conv 单趟扫描
 * @param [in] fmt: 已跳过首个 '%' 的格式串
 * @param [out] spec: 解析结果；conv 置 '\0' 表示语法耗尽/非法
 * @return     消费的字符数（含 conv）；语法耗尽为已扫描长度，非法为 0
 */
size_t ParsePrintfDirective(const char* fmt, PrintfSpec& spec)
{
    size_t idx = ParsePrintFlags(fmt, spec);
    if (fmt[idx] == '*') { // width
        spec.width = PRINT_WIDTH_STAR;
        ++idx;
    } else {
        spec.width = static_cast<int32_t>(ParsePrintNumber(fmt, idx, MAX_PRINT_WIDTH));
    }
    if (fmt[idx] == '.') { // precision：'.' 后无数字按 C 语义为 0
        ++idx;
        if (fmt[idx] == '*') {
            spec.precision = PRINT_PREC_STAR;
            ++idx;
        } else {
            spec.precision = static_cast<int32_t>(ParsePrintNumber(fmt, idx, MAX_PRINT_PRECISION));
        }
    }
    if (!ParsePrintLength(fmt, idx, spec)) {
        return 0U;
    }
    const char c = fmt[idx];
    if (c == '\0') {
        return idx; // 串尾悬空 '%'：conv 保持 '\0'
    }
    if (!IsPrintConvChar(c)) {
        IDE_LOGW("The print conversion [%c] is illegal.", c);
        spec.conv = '\0';
        return 0U;
    }
    spec.conv = c;
    return idx + 1U; // 含 conv 本身
}

/**
 * @brief      校验 length 与 conv 的合法组合：浮点族仅接受无/l，c/s/p 仅接受无 length，
 *             %n 一律拒绝（主机侧为只读快照，且属公认安全风险）
 * @param [in] spec: 待校验的 directive
 * @return     true=合法可渲染
 */
bool IsPrintSpecLegal(const PrintfSpec& spec)
{
    if (spec.conv == 'n') {
        return false;
    }
    if (spec.conv == '%') {
        return true; // %% 输出字面量（AscendC 仅支持标准 %%，带 flags/width 不承诺对齐 glibc）
    }
    if (IsPrintFloatConv(spec.conv)) {
        return (spec.length == PrintfLength::NONE) || (spec.length == PrintfLength::L);
    }
    if ((spec.conv == 'c') || (spec.conv == 's') || (spec.conv == 'p')) {
        return spec.length == PrintfLength::NONE;
    }
    return true; // d i u o x X：全 length 组法
}

/**
 * @brief      将 length 修饰符写回重组串，按 conv 区分翻译：
 *             - 整数族（d i u o x X）：l/z/Z/t/j 统一翻译为 "ll"，与 AppendPrintInt64/Uint64 传入的
 *               long long 实参严格匹配，保证 LP64/LLP64 平台均为 64 位渲染；
 *             - 浮点族：'l'（%lf）保持单 'l'——设计 §2.4-1 有意偏差（强制读 8B double），
 *               "ll" 会构成非法的 %llf
 * @param [in] conv: 转换符
 * @param [in] length: 解析出的 length 修饰符
 * @param [in] buf: 重组串写入位置（至少 3 字节）
 * @return     写入的字符数
 */
size_t AppendPrintLengthChars(const char conv, const PrintfLength length, char* buf)
{
    switch (length) {
        case PrintfLength::HH:
            buf[0] = 'h';
            buf[1] = 'h';
            return 2U;
        case PrintfLength::H:
            buf[0] = 'h';
            return 1U;
        case PrintfLength::LL:
            buf[0] = 'l';
            buf[1] = 'l';
            return 2U;
        case PrintfLength::L:
        case PrintfLength::Z:
        case PrintfLength::T:
        case PrintfLength::J:
            if (IsPrintFloatConv(conv)) {
                buf[0] = 'l';
                return 1U;
            }
            buf[0] = 'l';
            buf[1] = 'l';
            return 2U;
        case PrintfLength::NONE:
        default:
            return 0U;
    }
}

/**
 * @brief      由 PrintfSpec 重组标准 directive 字符串（width/precision 为已解析数值），
 *             交 snprintf 渲染以保证语义与 C 标准库严格一致
 * @param [in] spec: 已解析 directive（含动态 width/precision 解析后的实际值）
 * @param [out] buf: 重组串输出缓冲
 * @param [in] bufSize: 缓冲大小
 */
void BuildPrintFormatStr(const PrintfSpec& spec, char* buf, const size_t bufSize)
{
    size_t off = 0U;
    buf[off++] = '%';
    if (spec.leftAlign) {
        buf[off++] = '-';
    }
    if (spec.plusSign) {
        buf[off++] = '+';
    }
    if (spec.spaceSign) {
        buf[off++] = ' ';
    }
    if (spec.altForm) {
        buf[off++] = '#';
    }
    if (spec.zeroPad) {
        buf[off++] = '0';
    }
    if (spec.width >= 0) {
        const int32_t printLen = snprintf(buf + off, bufSize - off, "%d", spec.width);
        if (printLen > 0) {
            off += static_cast<size_t>(printLen);
        }
    }
    if (spec.precision >= 0) {
        const int32_t printLen = snprintf(buf + off, bufSize - off, ".%d", spec.precision);
        if (printLen > 0) {
            off += static_cast<size_t>(printLen);
        }
    }
    off += AppendPrintLengthChars(spec.conv, spec.length, buf + off);
    buf[off++] = spec.conv;
    buf[off] = '\0';
}

/**
 * @brief      读一个参数槽的原始 8 字节
 * @param [in] argsBase: 参数区起点
 * @param [in] slotIdx: 槽序号（1-based）
 * @return     槽内 8B 值（无符号解释）
 */
uint64_t ReadPrintSlotU64(const uint8_t* argsBase, const uint32_t slotIdx)
{
    uint64_t val = 0;
    (void)memcpy_s(&val, sizeof(val), argsBase + slotIdx * PRINTF_ARG_LEN, sizeof(val));
    return val;
}

/**
 * @brief      取一个参数槽作为 int（'*' width / '.*' precision 用）；
 *             设备按 int64 打包，读出截 int（超出 int 范围的截断与 C 实参提升语义一致）
 * @param [in] argsBase: 参数区起点
 * @param [in] slotIdx: 槽序号（1-based）
 * @return     槽值低 32 位（有符号解释）
 */
int32_t ReadPrintSlotAsInt(const uint8_t* argsBase, const uint32_t slotIdx)
{
    int64_t val = 0;
    const errno_t err = memcpy_s(&val, sizeof(val), argsBase + slotIdx * PRINTF_ARG_LEN, sizeof(val));
    if (err != EOK) {
        return 0;
    }
    return static_cast<int32_t>(val);
}

/**
 * @brief      浮点启发式取槽值：槽高 4B 全零读低 4B float32（覆盖 float/half/bf16/fp8 实参），
 *             否则读 8B double（贴近 CPU 域 %f=double 语义）；
 *             'l' 修饰（%lf）强制读 8B——设备不做实参提升导致的协议必然偏差
 * @param [in] argsBase: 参数区起点
 * @param [in] slotIdx: 槽序号（1-based）
 * @param [in] forceDouble: true 强制按 8B double 读（'l' 修饰）
 * @return     槽值（浮点解释）
 */
double ReadPrintSlotAsDouble(const uint8_t* argsBase, const uint32_t slotIdx, const bool forceDouble)
{
    const uint8_t* slotAddr = argsBase + slotIdx * PRINTF_ARG_LEN;
    if (forceDouble) {
        double val = 0.0;
        (void)memcpy_s(&val, sizeof(val), slotAddr, sizeof(val));
        return val;
    }
    uint32_t highDword = 0;
    (void)memcpy_s(&highDword, sizeof(highDword), slotAddr + sizeof(uint32_t), sizeof(highDword));
    if (highDword != 0U) {
        double val = 0.0;
        (void)memcpy_s(&val, sizeof(val), slotAddr, sizeof(val));
        return val;
    }
    float val = 0.0F;
    (void)memcpy_s(&val, sizeof(val), slotAddr, sizeof(val));
    return static_cast<double>(val);
}

/**
 * @brief      %s 取串：槽值为相对本槽的字符串偏移，串须 NUL 终止于参数区内；
 *             沿用全部边界校验（槽偏移/串偏移区间/未终止），校验失败由本函数告警
 * @param [in] argsBase: 参数区起点
 * @param [in] slotIdx: 槽序号（1-based）
 * @param [in] argsAreaLen: 参数区可用长度（infoLen - resvOffset）
 * @param [out] strOut: 字符串起始地址
 * @param [out] lenOut: 字符串长度
 * @return     true=校验通过；false=越界/未终止（跳过该参数渲染）
 */
bool ReadPrintSlotAsString(
    const uint8_t* argsBase, const uint32_t slotIdx, const uint64_t argsAreaLen, const char*& strOut, size_t& lenOut)
{
    const uint64_t slotOff = static_cast<uint64_t>(slotIdx) * PRINTF_ARG_LEN;
    if (slotOff + PRINTF_ARG_LEN > argsAreaLen) {
        IDE_LOGW(
            "String param slot[%u] is outside args length[%llu bytes].", slotIdx,
            static_cast<unsigned long long>(argsAreaLen));
        return false;
    }
    uint64_t strOffset = 0;
    (void)memcpy_s(&strOffset, sizeof(strOffset), argsBase + slotOff, sizeof(strOffset));
    const uint64_t maxStrOffset = argsAreaLen - slotOff;
    if ((strOffset < PRINTF_ARG_LEN) || (strOffset > maxStrOffset)) {
        IDE_LOGW(
            "Invalid string param offset[%llu]. Expected range is [%u, %llu].",
            static_cast<unsigned long long>(strOffset), PRINTF_ARG_LEN, static_cast<unsigned long long>(maxStrOffset));
        return false;
    }
    const char* data = reinterpret_cast<const char*>(argsBase + slotOff + strOffset);
    const size_t maxLen = static_cast<size_t>(maxStrOffset - strOffset);
    const size_t dataLen = strnlen(data, maxLen);
    IDE_LOGD("Get string param length[%zu bytes], max length[%zu bytes].", dataLen, maxLen);
    if (dataLen == maxLen) {
        IDE_LOGW("String param has no NUL terminator within max length[%zu bytes].", maxLen);
        return false;
    }
    strOut = data;
    lenOut = dataLen;
    return true;
}

/**
 * @brief      渲染探测长度钳制：超 MAX_PRINT_FIELD 时告警并按上限钳制（防超大 width/precision 打爆内存）
 * @param [in] needLen: snprintf 探测出的渲染长度
 * @return     钳制后的长度
 */
int32_t ClampPrintField(const int32_t needLen)
{
    if (needLen > MAX_PRINT_FIELD) {
        IDE_LOGW("Print field length[%d] exceeds max[%d], clamp to max.", needLen, MAX_PRINT_FIELD);
        return MAX_PRINT_FIELD;
    }
    return needLen;
}

/**
 * @brief      有符号整数渲染：按 length 取低 8/16/32 位或 64 位（无 length 按 C 标准读 32 位），
 *             探测长度 + 动态分配缓冲两段 snprintf 渲染；
 *             64 位路径实参显式转 long long，与重组串的 "ll" 修饰严格匹配（LP64/LLP64 均 64 位）
 * @param [in] spec: 已解析 directive
 * @param [in] val: 槽内 8B 值（有符号解释）
 * @param [in] fmtBuf: 重组后的标准 directive 串
 * @param [out] out: 渲染结果追加目标
 */
void AppendPrintInt64(const PrintfSpec& spec, const int64_t val, const char* fmtBuf, std::string& out)
{
    int32_t needLen = -1;
    const int32_t sval = static_cast<int32_t>(val);      // 无 length 按 C 标准读 32 位
    const long long llval = static_cast<long long>(val); // 64 位路径实参（与 "ll" 修饰匹配）
    switch (spec.length) {
        case PrintfLength::HH:
            needLen = snprintf(nullptr, 0U, fmtBuf, static_cast<int32_t>(static_cast<int8_t>(sval)));
            break;
        case PrintfLength::H:
            needLen = snprintf(nullptr, 0U, fmtBuf, static_cast<int32_t>(static_cast<int16_t>(sval)));
            break;
        case PrintfLength::NONE:
            needLen = snprintf(nullptr, 0U, fmtBuf, sval);
            break;
        default: // l/ll/z/t/j 均为 64 位
            needLen = snprintf(nullptr, 0U, fmtBuf, llval);
            break;
    }
    if (needLen < 0) {
        return;
    }
    needLen = ClampPrintField(needLen);
    std::vector<char> buf(static_cast<size_t>(needLen) + 1U);
    if (spec.length == PrintfLength::HH) {
        (void)snprintf(buf.data(), buf.size(), fmtBuf, static_cast<int32_t>(static_cast<int8_t>(sval)));
    } else if (spec.length == PrintfLength::H) {
        (void)snprintf(buf.data(), buf.size(), fmtBuf, static_cast<int32_t>(static_cast<int16_t>(sval)));
    } else if (spec.length == PrintfLength::NONE) {
        (void)snprintf(buf.data(), buf.size(), fmtBuf, sval);
    } else {
        (void)snprintf(buf.data(), buf.size(), fmtBuf, llval);
    }
    out.append(buf.data(), static_cast<size_t>(needLen));
}

/**
 * @brief      无符号整数渲染：按 length 取低 8/16/32 位或 64 位（无 length 按 C 标准读 32 位），
 *             探测长度 + 动态分配缓冲两段 snprintf 渲染；
 *             64 位路径实参显式转 unsigned long long，与重组串的 "ll" 修饰严格匹配（LP64/LLP64 均 64 位）
 */
void AppendPrintUint64(const PrintfSpec& spec, const uint64_t val, const char* fmtBuf, std::string& out)
{
    int32_t needLen = -1;
    const uint32_t uval = static_cast<uint32_t>(val);                       // 无 length 按 C 标准读 32 位
    const unsigned long long ullval = static_cast<unsigned long long>(val); // 64 位路径实参（与 "ll" 修饰匹配）
    switch (spec.length) {
        case PrintfLength::HH:
            needLen = snprintf(nullptr, 0U, fmtBuf, static_cast<uint32_t>(static_cast<uint8_t>(uval)));
            break;
        case PrintfLength::H:
            needLen = snprintf(nullptr, 0U, fmtBuf, static_cast<uint32_t>(static_cast<uint16_t>(uval)));
            break;
        case PrintfLength::NONE:
            needLen = snprintf(nullptr, 0U, fmtBuf, uval);
            break;
        default: // l/ll/z/t/j 均为 64 位
            needLen = snprintf(nullptr, 0U, fmtBuf, ullval);
            break;
    }
    if (needLen < 0) {
        return;
    }
    needLen = ClampPrintField(needLen);
    std::vector<char> buf(static_cast<size_t>(needLen) + 1U);
    if (spec.length == PrintfLength::HH) {
        (void)snprintf(buf.data(), buf.size(), fmtBuf, static_cast<uint32_t>(static_cast<uint8_t>(uval)));
    } else if (spec.length == PrintfLength::H) {
        (void)snprintf(buf.data(), buf.size(), fmtBuf, static_cast<uint32_t>(static_cast<uint16_t>(uval)));
    } else if (spec.length == PrintfLength::NONE) {
        (void)snprintf(buf.data(), buf.size(), fmtBuf, uval);
    } else {
        (void)snprintf(buf.data(), buf.size(), fmtBuf, ullval);
    }
    out.append(buf.data(), static_cast<size_t>(needLen));
}

/**
 * @brief      探测长度 + 渲染两段 snprintf 的通用骨架（浮点/c/p 用）
 * @param [in] fmtBuf: 重组后的标准 directive 串
 * @param [in] arg: 待渲染实参（double/int/const void*）
 * @param [out] out: 渲染结果追加目标
 */
template <typename T>
void AppendPrintValue(const char* fmtBuf, const T arg, std::string& out)
{
    int32_t needLen = snprintf(nullptr, 0U, fmtBuf, arg);
    if (needLen < 0) {
        return;
    }
    needLen = ClampPrintField(needLen);
    std::vector<char> buf(static_cast<size_t>(needLen) + 1U);
    (void)snprintf(buf.data(), buf.size(), fmtBuf, arg);
    out.append(buf.data(), static_cast<size_t>(needLen));
}

/**
 * @brief      解析 '*' width / '.*' precision：各先耗 1 槽取 int；
 *             负 width 转 '-' 标志 + 绝对值（C 语义），负 precision 视为缺省；
 *             与字面量路径同口径钳制到 MAX_PRINT_WIDTH/MAX_PRINT_PRECISION（防超大槽值打爆渲染）
 * @param [in] spec: 已解析 directive（width/precision 为 STAR 哨兵）
 * @param [in] argsBase: 参数区起点
 * @param [in,out] slotIdx: 当前槽序号，随 star 消耗前移
 * @param [out] renderSpec: 输出实际渲染用的 spec（star 已替换为具体数值）
 */
void ResolvePrintStars(const PrintfSpec& spec, const uint8_t* argsBase, uint32_t& slotIdx, PrintfSpec& renderSpec)
{
    if (spec.width == PRINT_WIDTH_STAR) {
        const int32_t w = ReadPrintSlotAsInt(argsBase, slotIdx);
        ++slotIdx;
        if (w < 0) {
            renderSpec.leftAlign = true;
            renderSpec.width = (w == INT32_MIN) ? MAX_PRINT_WIDTH : -w;
        } else {
            renderSpec.width = w;
        }
        if (renderSpec.width > MAX_PRINT_WIDTH) {
            IDE_LOGW("Print width[%d] exceeds max[%d], clamp to max.", renderSpec.width, MAX_PRINT_WIDTH);
            renderSpec.width = MAX_PRINT_WIDTH;
        }
    }
    if (spec.precision == PRINT_PREC_STAR) {
        const int32_t p = ReadPrintSlotAsInt(argsBase, slotIdx);
        ++slotIdx;
        renderSpec.precision = (p < 0) ? -1 : p;
        if (renderSpec.precision > MAX_PRINT_PRECISION) {
            IDE_LOGW("Print precision[%d] exceeds max[%d], clamp to max.", renderSpec.precision, MAX_PRINT_PRECISION);
            renderSpec.precision = MAX_PRINT_PRECISION;
        }
    }
}

/**
 * @brief      %s 渲染：校验失败（告警已打）仅跳过该参数；precision 截断由 snprintf 的 %.Ns 完成
 * @param [in] ctx: 渲染上下文（槽位区与 %s 校验口径）
 * @param [in] slotIdx: 槽序号（1-based）
 * @param [in] fmtBuf: 重组后的标准 directive 串
 * @param [out] out: 渲染结果追加目标
 */
void AppendPrintString(const PrintfRenderCtx& ctx, const uint32_t slotIdx, const char* fmtBuf, std::string& out)
{
    const char* strArg = nullptr;
    size_t strLen = 0U;
    if (!ReadPrintSlotAsString(ctx.argsBase, slotIdx, ctx.infoLen - ctx.resvOffset, strArg, strLen)) {
        return;
    }
    int32_t needLen = snprintf(nullptr, 0U, fmtBuf, strArg);
    if (needLen < 0) {
        return;
    }
    needLen = ClampPrintField(needLen);
    std::vector<char> buf(static_cast<size_t>(needLen) + 1U);
    const int32_t printLen = snprintf(buf.data(), buf.size(), fmtBuf, strArg);
    if (printLen >= 0) {
        out.append(buf.data(), static_cast<size_t>(std::min(printLen, needLen)));
    }
}

/**
 * @brief      按 conv 分派取值与渲染（d/i/u/o/x/X/f 族/c/s/p）
 * @param [in] renderSpec: 实际渲染用的 spec（star 已解析）
 * @param [in] ctx: 渲染上下文
 * @param [in] slotIdx: 实参槽序号（1-based）
 * @param [in] fmtBuf: 重组后的标准 directive 串
 * @param [out] out: 渲染结果追加目标
 * @return     true=已渲染；false=不可达 conv（理论兜底，IsPrintSpecLegal 已过滤）
 */
bool RenderPrintConv(
    const PrintfSpec& renderSpec, const PrintfRenderCtx& ctx, const uint32_t slotIdx, const char* fmtBuf,
    std::string& out)
{
    switch (renderSpec.conv) {
        case 'd':
        case 'i':
            AppendPrintInt64(renderSpec, static_cast<int64_t>(ReadPrintSlotU64(ctx.argsBase, slotIdx)), fmtBuf, out);
            return true;
        case 'u':
        case 'o':
        case 'x':
        case 'X':
            AppendPrintUint64(renderSpec, ReadPrintSlotU64(ctx.argsBase, slotIdx), fmtBuf, out);
            return true;
        case 'f':
        case 'F':
        case 'e':
        case 'E':
        case 'g':
        case 'G':
        case 'a':
        case 'A':
            AppendPrintValue(
                fmtBuf, ReadPrintSlotAsDouble(ctx.argsBase, slotIdx, renderSpec.length == PrintfLength::L), out);
            return true;
        case 'c': // 取槽低 1 字节
            AppendPrintValue(fmtBuf, static_cast<int32_t>(ctx.argsBase[slotIdx * PRINTF_ARG_LEN]), out);
            return true;
        case 's':
            AppendPrintString(ctx, slotIdx, fmtBuf, out);
            return true;
        case 'p': { // 读 8B 经内存拷贝转 void*（不做整数->指针直转）
            uint64_t val = ReadPrintSlotU64(ctx.argsBase, slotIdx);
            const void* ptr = nullptr;
            (void)memcpy_s(const_cast<void**>(&ptr), sizeof(ptr), &val, sizeof(val));
            AppendPrintValue(fmtBuf, ptr, out);
            return true;
        }
        default:
            return false;
    }
}

/**
 * @brief      渲染一个已解析 directive：合法性校验 + '*' 解析 + 重组格式串 + 按 conv 分派渲染
 * @param [in] spec: 已解析 directive
 * @param [in] ctx: 渲染上下文
 * @param [in] argIdx: 起始槽序号（1-based，首槽为 strOffset 占位）
 * @param [out] out: 渲染结果追加目标
 * @return     消耗的参数槽数（%%=0）；
 *             PRINT_RENDER_VIOLATION：组合违例（%n/%hhf 等），调用方回显原文并降级；
 *             PRINT_RENDER_MISSING：参数不足，调用方回显原文继续渲染（消耗 0 槽）
 */
size_t RenderPrintfDirective(
    const PrintfSpec& spec, const PrintfRenderCtx& ctx, const uint32_t argIdx, std::string& out)
{
    if (!IsPrintSpecLegal(spec)) {
        return PRINT_RENDER_VIOLATION;
    }
    if (spec.conv == '%') {
        out += '%';
        return 0U;
    }
    const uint32_t starCount =
        ((spec.width == PRINT_WIDTH_STAR) ? 1U : 0U) + ((spec.precision == PRINT_PREC_STAR) ? 1U : 0U);
    if (static_cast<uint64_t>(argIdx) + starCount > ctx.argsNum) {
        return PRINT_RENDER_MISSING; // 参数不足：不读槽、不推进槽序号（缺参者不占位）
    }
    uint32_t slotIdx = argIdx;
    PrintfSpec renderSpec = spec;
    ResolvePrintStars(spec, ctx.argsBase, slotIdx, renderSpec);
    char fmtBuf[64];
    BuildPrintFormatStr(renderSpec, fmtBuf, sizeof(fmtBuf));
    return RenderPrintConv(renderSpec, ctx, slotIdx, fmtBuf, out) ? (1U + starCount) : PRINT_RENDER_VIOLATION;
}

/**
 * @brief      非法 directive 告警：文本截取到下一个 '%' 或串尾（上限 MAX_DIR_MSG_LEN，栈缓冲护栏）
 * @param [in] fmt: 指向非法 directive 起始（'%' 之后）
 */
void WarnIllegalPrintDirective(const char* fmt)
{
    char dirText[MAX_DIR_MSG_LEN] = {0};
    size_t len = 0U;
    while ((len < (MAX_DIR_MSG_LEN - 1U)) && (fmt[len] != '\0') && (fmt[len] != '%')) {
        dirText[len] = fmt[len];
        ++len;
    }
    IDE_LOGW("The print format [%%%s] is illegal.", dirText);
}

/**
 * @brief      渲染回显的 directive 文本末尾：到下一个 '%' 或串尾，无长度上限
 *             （printInfo 为 std::string 动态增长，渲染路径无需护栏）
 * @param [in] fmt: 指向非法 directive 起始（'%' 之后）
 * @return     回显区间末尾指针（指向 '\0' 或 '%'）
 */
const char* IllegalDirectiveTextEnd(const char* fmt)
{
    const char* end = fmt;
    while ((*end != '\0') && (*end != '%')) {
        ++end;
    }
    return end;
}

/**
 * @brief      渲染结果分片打屏 + 写日志（assert 走 IDE_LOGE，其余 IDE_LOGI）
 * @param [in] printInfo: 完整渲染结果
 * @param [in] isAssert: 是否断言打印
 */
void FlushPrintInfo(const std::string& printInfo, const bool isAssert)
{
    const size_t infoLenStr = printInfo.size();
    for (size_t curIdx = 0; curIdx < infoLenStr; curIdx += PRINTF_LOG_SLICE_LEN) {
        const size_t curLen =
            (curIdx + PRINTF_LOG_SLICE_LEN) > infoLenStr ? (infoLenStr - curIdx) : PRINTF_LOG_SLICE_LEN;
        (void)printf("%s", printInfo.substr(curIdx, curLen).c_str());
        if (isAssert) {
            IDE_LOGE("%s", printInfo.substr(curIdx, curLen).c_str());
        } else {
            IDE_LOGI("PrintInfo: %s", printInfo.substr(curIdx, curLen).c_str());
        }
    }
}

/**
 * @brief      回显 directive 原文（'%' + [fmt, end) 区间字节拷贝，不取参不渲染）
 * @param [in] fmt: 指向 directive 起始（'%' 之后）
 * @param [in] end: 回显区间末尾（指向 '\0' 或 '%'）
 * @param [out] out: 回显结果追加目标
 * @return     回显后的 fmt 扫描位置（= end）
 */
const char* EchoDirectiveText(const char* fmt, const char* end, std::string& out)
{
    out += '%';
    out.append(fmt, static_cast<size_t>(end - fmt));
    return end;
}

/**
 * @brief      渲染一条合法 directive（含超限/缺参/违例三类容错分派）
 * @param [in,out] fmt: 指向 '%' 之后；渲染成功后前移 consumed
 * @param [in] spec: 已解析 directive；consumed 为其长度
 * @param [in] ctx: 渲染上下文
 * @param [in,out] paramIndex: 已消耗槽数
 * @param [out] printInfo: 渲染结果追加目标
 * @return     true=已降级（超限或违例，后续 directive 停渲染）
 */
bool RenderOneDirective(
    const char*& fmt, const PrintfSpec& spec, const size_t consumed, const PrintfRenderCtx& ctx, uint32_t& paramIndex,
    std::string& printInfo)
{
    if (printInfo.size() > MAX_PRINT_RECORD) { // 渲染字段累计超限（纯文本/原文回显天然有界，不检查）
        IDE_LOGW("Rendered output exceeds max[%zu] bytes, rest directives are kept as-is.", MAX_PRINT_RECORD);
        fmt = EchoDirectiveText(fmt, fmt + consumed, printInfo);
        return true;
    }
    fmt += consumed;
    const size_t used = RenderPrintfDirective(spec, ctx, paramIndex + 1U, printInfo);
    if (used == PRINT_RENDER_MISSING) { // 参数不足：回显原文（0 槽），继续渲染
        IDE_LOGW("Too many placeholders (>%u) for argsNum=%u, directive is kept as-is.", paramIndex + 1U, ctx.argsNum);
        printInfo.append(fmt - consumed - 1, consumed + 1U);
        return false;
    }
    if (used == PRINT_RENDER_VIOLATION) { // 组合违例：为避免后续参数映射混叠，降级
        IDE_LOGW("Illegal conversion directive with conv [%c], argsNum=%u.", spec.conv, ctx.argsNum);
        printInfo.append(fmt - consumed - 1, consumed + 1U);
        return true;
    }
    paramIndex += static_cast<uint32_t>(used);
    return false;
}

} // namespace

void ParsePrintToLog(const char* format, const PrintfRenderCtx& ctx, const bool isAssert)
{
    PrintfRenderCtx effCtx = ctx;
    const uint64_t argsAreaLen = (ctx.infoLen > ctx.resvOffset) ? (ctx.infoLen - ctx.resvOffset) : 0U;
    const uint64_t maxArgSlots = (argsAreaLen >= PRINTF_ARG_LEN) ? (argsAreaLen / PRINTF_ARG_LEN - 1U) : 0U;
    if (static_cast<uint64_t>(ctx.argsNum) > maxArgSlots) {
        IDE_LOGW(
            "Print argsNum[%u] exceeds args area[%llu bytes], clamp to [%llu].", ctx.argsNum,
            static_cast<unsigned long long>(argsAreaLen), static_cast<unsigned long long>(maxArgSlots));
        effCtx.argsNum = static_cast<uint32_t>(maxArgSlots);
    }
    uint32_t paramIndex = 0U; // 已消耗槽数（实参槽从 1 起）
    std::string printInfo;
    bool degraded = false;    // 违例/超限后停渲染：剩余 fmt 全按原文输出
    while ((*format) != '\0') {
        if ((*format) != '%') {
            printInfo += *format;
            ++format;
            continue;
        }
        ++format;             // 跳过 '%'
        if (*format == '\0') {
            printInfo += '%'; // 串尾悬空 '%'：输出后终止
            break;
        }
        PrintfSpec spec;
        const size_t consumed = ParsePrintfDirective(format, spec);
        if (degraded) { // 停渲染：剩余 directive 一律原文输出
            format = EchoDirectiveText(format, format + consumed, printInfo);
            continue;
        }
        if (spec.conv == '\0') { // 解析期失败：告警 + 回显原文（0 槽），扫描继续
            WarnIllegalPrintDirective(format);
            format = EchoDirectiveText(format, IllegalDirectiveTextEnd(format), printInfo);
            continue;
        }
        if (spec.conv == '%') { // %% 字面量（AscendC 仅支持标准 %%，带 flags/width 不承诺对齐 glibc）
            format += consumed;
            printInfo += '%';
            continue;
        }
        degraded = RenderOneDirective(format, spec, consumed, effCtx, paramIndex, printInfo);
    }

    FlushPrintInfo(printInfo, isAssert);
}

} // namespace Adx
