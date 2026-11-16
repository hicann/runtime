/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DFX_PRINTF_PARSER_H
#define DFX_PRINTF_PARSER_H

#include <cstdint>

namespace Adx {

// printf directive 解析 + 参数槽取值 + snprintf 渲染（格式基线：printf-format.md）。
// 槽位协议（与 AscendC 打包源码对齐）：每实参占 1 个 8B 槽，先清零再写低位——float/half/bf16/fp8 -> 低 4B
// float32；double -> 8B；有符号 -> int64；无符号/指针 -> uint64；字符串 -> 相对本槽偏移（首槽存 strOffset）。

enum class PrintfLength : uint8_t {
    NONE,
    HH,
    H,
    L,  // 单个 'l'：64 位语义
    LL, // "ll"
    Z,  // 'z'/'Z'：size_t（64 位）
    T,  // 't'：ptrdiff_t（64 位）
    J   // 'j'：intmax_t（64 位）
};

// 一个已解析的 % directive：flags/width/precision/length/conv 五段语法位
struct PrintfSpec {
    bool leftAlign = false; // '-'
    bool plusSign = false;  // '+'
    bool spaceSign = false; // ' '
    bool altForm = false;   // '#'
    bool zeroPad = false;   // '0'
    int32_t width = -1;     // -1 缺省；-2 表示 '*'（从参数槽取）
    int32_t precision = -1; // -1 缺省；-2 表示 '.*'
    PrintfLength length = PrintfLength::NONE;
    char conv = '\0';       // d i u o x X f F e E g G a A c s p %
};

// printf 渲染上下文：槽位区与 %s 校验口径，跨 SIMD/SIMT 复用
struct PrintfRenderCtx {
    const uint8_t* argsBase = nullptr; // 参数区起点（infoMsg + resvOffset，首槽为 strOffset 占位）
    uint32_t argsNum = 0;              // 实参槽总数（不含占位槽）
    uint64_t infoLen = 0;              // dumpHead->infoLen（%s 校验口径）
    uint64_t resvOffset = 0;           // 预留区长度：SIMD=8 / SIMT=40
};

/**
 * @brief      渲染整条 printf 记录：directive 解析 + 参数槽取值 + snprintf 渲染，分片打屏 + 写日志。
 *             异常 directive 统一容错（原文照抄 + 不占槽 + fmt 扫描走完，均不跨记录传播）：
 *             解析期失败/参数不足：告警 + 回显原文，渲染继续（0 槽不偷参）；
 *             组合违例（%n/%hhf 等）/整条渲染超限：告警 + 回显原文，停渲染降级（后续 directive 原文输出）
 * @param [in] format: 格式串（设备侧 dumphead+fmt 拼接后的完整串）
 * @param [in] ctx: 渲染上下文（槽位区与 %s 校验口径）
 * @param [in] isAssert: 是否断言打印（影响日志级别）
 */
void ParsePrintToLog(const char* format, const PrintfRenderCtx& ctx, const bool isAssert);

} // namespace Adx

#endif // DFX_PRINTF_PARSER_H
