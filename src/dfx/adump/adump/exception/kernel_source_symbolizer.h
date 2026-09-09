/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef KERNEL_SOURCE_SYMBOLIZER_H
#define KERNEL_SOURCE_SYMBOLIZER_H

#include <cstdint>
#include <string>
#include <vector>

namespace Adx {

// 单帧源码位置（file:line:col 或 unknown）。
struct SourceLocation {
    bool ok = false;
    std::string srcFile; // 源文件路径
    uint32_t srcLine = 0;
    uint32_t srcColumn = 0;
};

// 单个 PC 偏移经 llvm-symbolizer 解析后的源码信息（仅取源码位置，不解析函数名）。
// innermost=输出中第一条位置行（最内层内联帧），outermost=最后一条位置行（最外层帧）；
// 无内联展开时两槽相同，均保留打印。
struct SymbolizeResult {
    SourceLocation innermost; // 最内层帧源码位置
    SourceLocation outermost; // 最外层帧源码位置
};

// 借助 llvm-symbolizer 将 .o 内的 PC 偏移解析为源码行号（不依赖 -f/-C/-i 等参数约束输出格式）。
// 所有接口均为 best-effort：定位失败/超时/解析失败只告警并返回 false，绝不阻断落盘。
class KernelSourceSymbolizer {
public:
    // 对同一个 .o 按 offsets 顺序逐 offset 解析：每个偏移独立启动一次 llvm-symbolizer（单次、单 offset、单结果）。
    // results 与 offsets 一一对应并预置默认值；单个偏移失败（进程失败/超时/解析为 unknown）只保留该偏移
    // 默认结果并继续后续偏移。返回值：全部偏移均解析出有效外层帧位置（outermost.ok）时 true，存在任一
    // 失败项即 false；offsets 为空/工具缺失/路径无效等前置校验失败直接 false。
    static bool Symbolize(
        const std::string& oFilePath, const std::vector<uint64_t>& offsets, std::vector<SymbolizeResult>& results);

    // llvm-symbolizer 是否可用（定位结果带缓存）。
    static bool IsAvailable();

    // 探测 ELF 中是否存在 .debug_line 段，用于决定是否回退到 kernel_meta 的 .o。
    static bool HasDebugLine(const std::string& oFilePath);

    // 将原始输出切分为可安全打印的日志块：按行切分（跳过空行、去行尾 \r），
    // 超长行按单条日志可容纳的最大长度分块。声明供 RunSymbolizer 与 UT 共用。
    static std::vector<std::string> SplitRawOutputForLog(const std::string& output);

#ifdef __ADUMP_LLT
    // 测试专用：清除工具定位缓存，保证用例间相互独立。
    static void ResetLocateCacheForTest();
#endif

private:
    // 定位可执行文件：环境变量 ADUMP_LLVM_SYMBOLIZER 优先，其次 ASCEND 工具链相对路径。
    static const std::string& LocateSymbolizer();

    // posix_spawn + 超时执行单偏移：写一行 stdin、读全部 stdout、回收子进程后解析单结果（best-effort）。
    static bool RunSymbolizer(
        const std::string& tool, const std::string& inputLine, uint64_t offset, SymbolizeResult& result);
};

} // namespace Adx

#endif // KERNEL_SOURCE_SYMBOLIZER_H
