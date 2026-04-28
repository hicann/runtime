/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_DEV_INFO_H
#define CCE_RUNTIME_DEV_INFO_H
#include <cstdint>
#include "base.hpp"

namespace cce {
namespace runtime {
struct RtIniAttributes {
    uint32_t normalStreamNum = 0U;   // ini SoCInfo.normal_stream_num
    uint32_t normalStreamDepth = 0U; // ini SoCInfo.normal_stream_depth
    uint32_t hugeStreamNum = 0U;     // ini SoCInfo.huge_stream_num
    uint32_t hugeStreamDepth = 0U;   // ini SoCInfo.huge_stream_depth
    int64_t npuArch = 0;             // ini version.NpuArch, 0 means invalid or uninitialized
};

struct DevProperties;
using DEV_PROPS_UPDATE_FUNC = void (*)(DevProperties&);

// Dynamic attribute processing, which is registered in the SO opened in dlopen mode,
struct DevDynInfoProcFunc {
    DEV_PROPS_UPDATE_FUNC devPropsUpdateFunc = nullptr;
};
}  // namespace runtime
}  // namespace cce
#endif
