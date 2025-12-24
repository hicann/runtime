/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_PARAM_CONVERTOR_HPP
#define RUNTIME_PARAM_CONVERTOR_HPP

#include "base.hpp"

namespace cce {
namespace runtime {
constexpr uint8_t DATA_DUMP_ENABLE = 1U;
constexpr uint8_t DATA_DUMP_DISABLE = 0U;

constexpr uint8_t BLOCK_PREFETCH_ENABLE = 1U;
constexpr uint8_t BLOCK_PREFETCH_DISABLE = 0U;

// Launch kernel接口新老参数信息适配
rtError_t ConvertLaunchCfgToTaskCfg(TaskCfg &taskCfg, const rtKernelLaunchCfg_t* const cfg);
// RtArgsHandle 转化成 rtArgsEx_t
rtError_t ConvertArgsByArgsHandle(rtArgsEx_t &oldArgs, const RtArgsHandle * const argsHandle,
    rtHostInputInfo_t specialArgsInfos[], const uint8_t arrayArgsNum);
rtError_t ConvertCpuArgsByArgsHandle(rtCpuKernelArgs_t &oldArgs, const RtArgsHandle *const argsHandle,
    rtHostInputInfo_t specialArgsInfos[], const uint8_t arrayArgsNum);
uint64_t ConvertTimeoutToInner(uint64_t timeout);
uint64_t ConvertAicpuTimeout(const rtAicpuArgsEx_t * const argsInfo, const TaskCfg *taskCfg,
    const uint32_t flag);
}
}

#endif  // RUNTIME_PARAM_CONVERTOR_HPP