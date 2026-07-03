/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_CAPTURE_MODEL_ENUM_DESC_HPP
#define CCE_RUNTIME_CAPTURE_MODEL_ENUM_DESC_HPP

#include <cstdint>
#include <string>
#include "capture_model.hpp"
#include "common/thread_local_container.hpp"
#include "rt_log.h"

namespace cce {
namespace runtime {

static inline std::string CaptureModelStatusToString(const RtCaptureModelStatus status)
{
    std::string desc;
    switch (status) {
        case RtCaptureModelStatus::NONE: desc = "NONE(0)"; break;
        case RtCaptureModelStatus::CAPTURE_ACTIVE: desc = "CAPTURE_ACTIVE(1)"; break;
        case RtCaptureModelStatus::CAPTURE_INVALIDATED: desc = "CAPTURE_INVALIDATED(2)"; break;
        case RtCaptureModelStatus::UPDATING: desc = "UPDATING(3)"; break;
        case RtCaptureModelStatus::FAULT: desc = "FAULT(4)"; break;
        case RtCaptureModelStatus::READY: desc = "READY(5)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(status)); break;
    }
    return desc;
}

static inline std::string StreamCaptureModeToString(const rtStreamCaptureMode mode)
{
    std::string desc;
    switch (mode) {
        case RT_STREAM_CAPTURE_MODE_GLOBAL: desc = "GLOBAL(0)"; break;
        case RT_STREAM_CAPTURE_MODE_THREAD_LOCAL: desc = "THREAD_LOCAL(1)"; break;
        case RT_STREAM_CAPTURE_MODE_RELAXED: desc = "RELAXED(2)"; break;
        case RT_STREAM_CAPTURE_MODE_MAX: desc = "MAX(3)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(mode)); break;
    }
    return desc;
}

static inline std::string CaptureEventModeToString(const uint8_t mode)
{
    std::string desc;
    switch (mode) {
        case static_cast<uint8_t>(CaptureEventModeType::SOFTWARE_MODE): desc = "SOFTWARE_MODE(0)"; break;
        case static_cast<uint8_t>(CaptureEventModeType::HARDWARE_MODE): desc = "HARDWARE_MODE(1)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%u)", static_cast<uint64_t>(mode)); break;
    }
    return desc;
}

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_CAPTURE_MODEL_ENUM_DESC_HPP
