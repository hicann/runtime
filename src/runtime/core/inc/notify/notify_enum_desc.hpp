/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_NOTIFY_ENUM_DESC_HPP
#define CCE_RUNTIME_NOTIFY_ENUM_DESC_HPP

#include <cstdint>
#include <string>
#include "runtime/config.h"
#include "rt_log.h"

namespace cce {
namespace runtime {

static inline std::string NotifyFlagToString(const uint32_t flag)
{
    std::string desc;
    switch (flag) {
        case RT_NOTIFY_FLAG_DEFAULT: desc = "NOTIFY_FLAG_DEFAULT(0)"; break;
        case RT_NOTIFY_FLAG_DOWNLOAD_TO_DEV: desc = "NOTIFY_FLAG_DOWNLOAD_TO_DEV(1)"; break;
        case RT_NOTIFY_FLAG_SHR_ID_SHADOW: desc = "NOTIFY_FLAG_SHR_ID_SHADOW(64)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%u)", static_cast<uint64_t>(flag)); break;
    }
    return desc;
}

static inline std::string RecordModeToString(const rtCntNotifyRecordMode_t mode)
{
    std::string desc;
    switch (mode) {
        case RECORD_STORE_MODE: desc = "RECORD_STORE_MODE(0)"; break;
        case RECORD_ADD_MODE: desc = "RECORD_ADD_MODE(1)"; break;
        case RECORD_WRITE_BIT_MODE: desc = "RECORD_WRITE_BIT_MODE(2)"; break;
        case RECORD_INVALID_MODE: desc = "RECORD_INVALID_MODE(3)"; break;
        case RECORD_CLEAR_BIT_MODE: desc = "RECORD_CLEAR_BIT_MODE(4)"; break;
        case RECORD_MODE_MAX: desc = "RECORD_MODE_MAX(5)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(mode)); break;
    }
    return desc;
}

static inline std::string WaitModeToString(const rtCntNotifyWaitMode_t mode)
{
    std::string desc;
    switch (mode) {
        case WAIT_LESS_MODE: desc = "WAIT_LESS_MODE(0)"; break;
        case WAIT_EQUAL_MODE: desc = "WAIT_EQUAL_MODE(1)"; break;
        case WAIT_BIGGER_MODE: desc = "WAIT_BIGGER_MODE(2)"; break;
        case WAIT_BIGGER_OR_EQUAL_MODE: desc = "WAIT_BIGGER_OR_EQUAL_MODE(3)"; break;
        case WAIT_BITMAP_MODE: desc = "WAIT_BITMAP_MODE(4)"; break;
        case WAIT_MODE_MAX: desc = "WAIT_MODE_MAX(5)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(mode)); break;
    }
    return desc;
}

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_NOTIFY_ENUM_DESC_HPP
