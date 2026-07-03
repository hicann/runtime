/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_STREAM_ENUM_DESC_HPP
#define CCE_RUNTIME_STREAM_ENUM_DESC_HPP

#include <cstdint>
#include <string>
#include "runtime/rt_external_stream.h"
#include "rt_log.h"

namespace cce {
namespace runtime {

static inline std::string StreamPriorityToString(const uint32_t priority)
{
    std::string desc;
    switch (priority) {
        case RT_STREAM_PRIORITY_DEFAULT: desc = "STREAM_PRIORITY_DEFAULT(0)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%u)", static_cast<uint64_t>(priority)); break;
    }
    return desc;
}

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_STREAM_ENUM_DESC_HPP
