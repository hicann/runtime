/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_ENUM_TO_STRING_UTILS_HPP
#define CCE_RUNTIME_ENUM_TO_STRING_UTILS_HPP

#include <string>
#include "runtime/mem_base.h"
#include "runtime/rt_external_stars_define.h"
#include "runtime/stream.h"
#include "runtime/event.h"
#include "runtime/rts/rts_event.h"
#include "runtime/kernel.h"
#include "runtime/dev.h"
#include "runtime/config.h"
#include "runtime/rt_preload_task.h"
#include "runtime/rt_inner_model.h"
#include "runtime/rt_inner_device.h"
#include "driver/ascend_hal_base.h"
#include "capture_model.hpp"
#include "common/thread_local_container.hpp"
#include "device.hpp"

namespace cce {
namespace runtime {

std::string ReduceKindToString(const rtRecudeKind_t kind);
std::string DataTypeToString(const rtDataType_t type);
std::string CaptureModelStatusToString(const RtCaptureModelStatus status);
std::string StreamCaptureModeToString(const rtStreamCaptureMode mode);
std::string StreamFlagsToString(const uint32_t flags);
std::string EventFlagsToString(const uint64_t flags);
std::string KernelFlagToString(const uint32_t flag);
std::string NotifyFlagToString(const uint32_t flag);
std::string RecordModeToString(const rtCntNotifyRecordMode_t mode);
std::string WaitModeToString(const rtCntNotifyWaitMode_t mode);
std::string CaptureEventModeToString(const uint8_t mode);
std::string InfoTypeToString(const uint32_t infoType);
std::string ModuleTypeToString(const int32_t moduleType);
std::string DevResTypeToString(const rtDevResType_t type);
std::string DevResProcTypeToString(const rtDevResProcType_t type);
std::string UbDevQueryCmdToString(const rtUbDevQueryCmd cmd);
std::string DeviceStateCallbackToString(const DeviceStateCallback type);
std::string LastErrLevelToString(const rtLastErrLevel_t level);
std::string TaskBuffTypeToString(const rtTaskBuffType_t type);
std::string MemcpyKindToString(const rtMemcpyKind_t kind);
std::string MemcpyNewKindToString(const rtMemcpyKind kind);
std::string WriteValueSizeTypeToString(const rtWriteValueSizeType_t type);
std::string CondHandleFlagToString(const rtCondHandleFlag_t flag);
std::string CondTaskTypeToString(const rtCondTaskType_t type);
std::string DevFeatureTypeToString(const int32_t devFeatureType);

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_ENUM_TO_STRING_UTILS_HPP
