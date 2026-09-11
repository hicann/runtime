/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_DEVICE_DEBUG_C_HPP
#define CCE_RUNTIME_DEVICE_DEBUG_C_HPP

#include "runtime/dev.h"
#include "runtime/mem.h"

namespace cce {
namespace runtime {

class Device;
struct RtDebugSendInfo;
struct rtDebugReportInfo_t;

rtError_t SendAndRecvDebugTask(
    RtDebugSendInfo* const sendInfo, rtDebugReportInfo_t* const reportInfo, const Device* const device);

rtError_t DebugSetDumpMode(const uint64_t mode, Device* const device);

rtError_t DebugGetStalledCore(rtDbgCoreInfo_t* const coreInfo, const Device* const device);

rtError_t DebugReadAICore(const rtDebugMemoryParam_t* const param, const Device* const device = nullptr);

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_DEVICE_DEBUG_C_HPP
