/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_STREAM_TASK_C_HPP
#define CCE_RUNTIME_STREAM_TASK_C_HPP

#include "runtime/base.h"
#include "runtime/rt_stars_define.h"

namespace cce {
namespace runtime {

class Device;
class Stream;

rtError_t StreamNopTask(Stream* const stm);

rtError_t StreamCmoAddrTaskLaunch(
    void* const cmoAddrInfo, const uint64_t destMax, const rtCmoOpCode_t cmoOpCode, Stream* const stm,
    const uint32_t flag);

rtError_t StreamNpuGetFloatStatus(
    void* const outputAddrPtr, const uint64_t outputSize, const uint32_t checkMode, Stream* const stm,
    bool isDebug = false);

rtError_t StreamNpuClearFloatStatus(const uint32_t checkMode, Stream* const stm, bool isDebug = false);

rtError_t StreamSetOverflowSwitch(Stream* const targetStm, const uint32_t flags, Stream* const defaultStm);

rtError_t StreamDatadumpInfoLoad(
    const void* const dumpInfo, const uint32_t length, const uint32_t flag, Stream* const defaultStm);

rtError_t StreamAicpuInfoLoad(
    Stream* const defaultStm, const void* const aicpuInfo, const uint32_t length, Device* const device);

rtError_t StreamDebugRegister(
    Stream* const debugStm, const uint32_t flag, const void* const addr, uint32_t* const streamId,
    uint32_t* const taskId, Stream* const defaultStm);

rtError_t StreamDebugUnRegister(Stream* const debugStm, Stream* const defaultStm);

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_STREAM_TASK_C_HPP
