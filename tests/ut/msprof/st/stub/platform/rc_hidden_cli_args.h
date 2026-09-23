/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DVVP_TEST_STUB_PLATFORM_RC_HIDDEN_CLI_ARGS_H
#define DVVP_TEST_STUB_PLATFORM_RC_HIDDEN_CLI_ARGS_H
#include <string>
#include <vector>

namespace Dvvp {
namespace Collect {
namespace Platform {
// msprof long option names that each RC form hides from users. The names follow the msprofbin long
// option table, which maps them back to its own argument ids. Groups shared by several forms are
// declared once and composed per chip id, so no list repeats another one line by line.
inline void AppendRcCliArgs(std::vector<std::string>& args, const std::vector<std::string>& group)
{
    args.insert(args.end(), group.begin(), group.end());
}

inline const std::vector<std::string>& RcAivCliArgs()
{
    static const std::vector<std::string> args = {"ai-vector-core", "aiv-freq", "aiv-mode", "aiv-metrics"};
    return args;
}

inline const std::vector<std::string>& RcAnalysisCliArgs()
{
    static const std::vector<std::string> args = {
        "parse", "query", "export", "iteration-id", "model-id", "python-path", "summary-format", "analyze", "rule"};
    return args;
}

inline const std::vector<std::string>& RcCollectCliArgs()
{
    static const std::vector<std::string> args = {
        "sys-io-profiling",
        "sys-io-sampling-freq",
        "sys-interconnection-profiling",
        "sys-interconnection-freq",
        "aicpu",
        "task-block",
        "instr-profiling",
        "instr-profiling-freq",
        "dynamic",
        "pid",
        "delay",
        "duration",
        "sys-lp",
        "sys-lp-freq",
        "sys-mem-serviceflow"};
    return args;
}

// chip id 2
inline const std::vector<std::string>& RcHiddenCliArgs()
{
    static const std::vector<std::string> args = [] {
        std::vector<std::string> list = RcCollectCliArgs();
        AppendRcCliArgs(list, RcAnalysisCliArgs());
        AppendRcCliArgs(list, {"optype"});
        return list;
    }();
    return args;
}

// chip id 12: chip id 2 list plus the aiv group
inline const std::vector<std::string>& RcLiteHiddenCliArgs()
{
    static const std::vector<std::string> args = [] {
        std::vector<std::string> list = RcHiddenCliArgs();
        AppendRcCliArgs(list, RcAivCliArgs());
        return list;
    }();
    return args;
}

// chip id 11: chip id 12 list plus the host-sys and model-execution switches
inline const std::vector<std::string>& RcMiniV3HiddenCliArgs()
{
    static const std::vector<std::string> args = [] {
        std::vector<std::string> list = RcLiteHiddenCliArgs();
        AppendRcCliArgs(list, {"host-sys", "host-sys-pid", "model-execution"});
        return list;
    }();
    return args;
}

// chip id 17 and chip id 18 hide the aiv group only
inline const std::vector<std::string>& RcV2HiddenCliArgs() { return RcAivCliArgs(); }
} // namespace Platform
} // namespace Collect
} // namespace Dvvp
#endif
