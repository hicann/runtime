/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_TASK_ENUM_DESC_HPP
#define CCE_RUNTIME_TASK_ENUM_DESC_HPP

#include <cstdint>
#include <string>
#include "runtime/rt_external_preload.h"
#include "runtime/rt_external_stars.h"
#include "rt_log.h"

namespace cce {
namespace runtime {

static inline std::string TaskBuffTypeToString(const rtTaskBuffType_t type)
{
    std::string desc;
    switch (type) {
        case HWTS_STATIC_TASK_DESC: desc = "HWTS_STATIC_TASK_DESC(0)"; break;
        case HWTS_DYNAMIC_TASK_DESC: desc = "HWTS_DYNAMIC_TASK_DESC(1)"; break;
        case PARAM_TASK_INFO_DESC: desc = "PARAM_TASK_INFO_DESC(2)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(type)); break;
    }
    return desc;
}

static inline std::string MultipleTaskTypeToString(const rtMultipleTaskType_t type)
{
    std::string desc;
    switch (type) {
        case RT_MULTIPLE_TASK_TYPE_DVPP: desc = "MULTIPLE_TASK_TYPE_DVPP(0)"; break;
        case RT_MULTIPLE_TASK_TYPE_AICPU: desc = "MULTIPLE_TASK_TYPE_AICPU(1)"; break;
        case RT_MULTIPLE_TASK_TYPE_AICPU_BY_HANDLE: desc = "MULTIPLE_TASK_TYPE_AICPU_BY_HANDLE(2)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(type)); break;
    }
    return desc;
}

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_TASK_ENUM_DESC_HPP
