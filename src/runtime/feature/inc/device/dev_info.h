/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_DEVICE_INFO_H
#define CCE_RUNTIME_DEVICE_INFO_H
#include <cstdint>
#include "base.hpp"

namespace cce {
namespace runtime {
struct RtMacroValue {
    uint32_t maxPersistTaskNum;
    uint32_t maxTaskNumPerStream;
    uint32_t maxSinkTaskNum;
    uint32_t maxSupportTaskNum;
    uint32_t pctraceFileLength;
    uint32_t pctraceFileHead;
    uint32_t maxAllocStreamNum;
    uint32_t stubEventCount;
    int32_t maxReportTimeoutCnt;
    uint32_t maxTaskNumPerHugeStream;
    uint32_t maxAllocHugeStreamNum;
    uint32_t maxModelNum;
    uint32_t rtsqDepth;
    uint32_t baseAicpuStreamId;
};

using MACRO_VALUE_INIT_FUNC = void (*)(rtSocType_t, RtMacroValue &);

// Dynamic attribute processing, which is registered in the SO opened in dlopen mode,
struct DevDynInfoProcFunc {
    MACRO_VALUE_INIT_FUNC macroInitFunc;
};
}  // namespace runtime
}  // namespace cce
#endif