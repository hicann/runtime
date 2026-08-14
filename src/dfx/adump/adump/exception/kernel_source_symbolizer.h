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

// 单个 PC 偏移经 llvm-symbolizer 解析后的源码信息（仅取源码位置，不解析函数名）。
struct SymbolizeResult {
    bool ok = false;
    std::string srcFile;    // 源文件路径
    uint32_t srcLine = 0;
    uint32_t srcColumn = 0;
};

// 借助 llvm-symbolizer 将 .o 内的 PC 偏移解析为源码行号（不依赖 -f/-C/-i 等参数约束输出格式）。
// 所有接口均为 best-effort：定位失败/超时/解析失败只告警并返回 false，绝不阻断落盘。
class KernelSourceSymbolizer {
public:
    // 对同一个 .o 一次性解析多个偏移，results 与 offsets 一一对应。
    static bool Symbolize(const std::string &oFilePath, const std::vector<uint64_t> &offsets,
        std::vector<SymbolizeResult> &results);

    // llvm-symbolizer 是否可用（定位结果带缓存）。
    static bool IsAvailable();

    // 探测 ELF 中是否存在 .debug_line 段，用于决定是否回退到 kernel_meta 的 .o。
    static bool HasDebugLine(const std::string &oFilePath);

#ifdef __ADUMP_LLT
    // 测试专用：清除工具定位缓存，保证用例间相互独立。
    static void ResetLocateCacheForTest();
#endif

private:
    // 定位可执行文件：环境变量 ADUMP_LLVM_SYMBOLIZER 优先，其次 ASCEND 工具链相对路径。
    static const std::string &LocateSymbolizer();

    // posix_spawn + 超时执行，无 shell。inputLines 为逐行 stdin 内容，
    // results 按输出块顺序回填（大小由调用方预置为有效请求数）。
    static bool RunSymbolizer(const std::string &tool, const std::string &inputLines,
        std::vector<SymbolizeResult> &results);
};

} // namespace Adx

#endif // KERNEL_SOURCE_SYMBOLIZER_H
