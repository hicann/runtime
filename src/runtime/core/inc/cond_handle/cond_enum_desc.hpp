/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_COND_ENUM_DESC_HPP
#define CCE_RUNTIME_COND_ENUM_DESC_HPP

#include <cstdint>
#include <string>
#include "rt_inner_model.h"
#include "rt_external_stars_define.h"
#include "rt_log.h"

namespace cce {
namespace runtime {

static inline std::string WriteValueSizeTypeToString(const rtWriteValueSizeType_t type)
{
    std::string desc;
    switch (type) {
        case WRITE_VALUE_SIZE_TYPE_INVALID: desc = "WRITE_VALUE_SIZE_TYPE_INVALID(0)"; break;
        case WRITE_VALUE_SIZE_TYPE_8BIT: desc = "WRITE_VALUE_SIZE_TYPE_8BIT(1)"; break;
        case WRITE_VALUE_SIZE_TYPE_16BIT: desc = "WRITE_VALUE_SIZE_TYPE_16BIT(2)"; break;
        case WRITE_VALUE_SIZE_TYPE_32BIT: desc = "WRITE_VALUE_SIZE_TYPE_32BIT(3)"; break;
        case WRITE_VALUE_SIZE_TYPE_64BIT: desc = "WRITE_VALUE_SIZE_TYPE_64BIT(4)"; break;
        case WRITE_VALUE_SIZE_TYPE_128BIT: desc = "WRITE_VALUE_SIZE_TYPE_128BIT(5)"; break;
        case WRITE_VALUE_SIZE_TYPE_256BIT: desc = "WRITE_VALUE_SIZE_TYPE_256BIT(6)"; break;
        case WRITE_VALUE_SIZE_TYPE_BUFF: desc = "WRITE_VALUE_SIZE_TYPE_BUFF(7)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(type)); break;
    }
    return desc;
}

static inline std::string CondHandleFlagToString(const rtCondHandleFlag_t flag)
{
    std::string desc;
    switch (flag) {
        case RT_COND_HANDLE_ASSIGN_DEFAULT: desc = "COND_HANDLE_ASSIGN_DEFAULT(1)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(flag)); break;
    }
    return desc;
}

static inline std::string CondTaskTypeToString(const rtCondTaskType_t type)
{
    std::string desc;
    switch (type) {
        case RT_COND_TASK_TYPE_IF: desc = "COND_TASK_TYPE_IF(0)"; break;
        case RT_COND_TASK_TYPE_WHILE: desc = "COND_TASK_TYPE_WHILE(1)"; break;
        case RT_COND_TASK_TYPE_SWITCH: desc = "COND_TASK_TYPE_SWITCH(2)"; break;
        case RT_COND_TASK_TYPE_MAX: desc = "COND_TASK_TYPE_MAX(3)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(type)); break;
    }
    return desc;
}

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_COND_ENUM_DESC_HPP
