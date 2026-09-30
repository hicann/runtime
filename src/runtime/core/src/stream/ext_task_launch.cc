/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "ext_task_launch.hpp"
#include "device.hpp"
#include "device_enum_desc.hpp"
#include "error_message_manage.hpp"
#include "stream.hpp"
#include "task_info.hpp"

namespace cce {
namespace runtime {
namespace {

ExtTaskLaunchFunc g_extTaskLaunchFuncs[CHIP_END][TS_TASK_TYPE_RESERVED] = {};

bool IsValidExtTaskLaunchIndex(const rtChipType_t chipType, const tsTaskType_t taskType)
{
    return (chipType >= CHIP_BEGIN) && (chipType < CHIP_END) && (taskType >= TS_TASK_TYPE_KERNEL_AICORE) &&
           (taskType < TS_TASK_TYPE_RESERVED);
}

} // namespace

void RegisterExtTaskLaunch(rtChipType_t chipType, tsTaskType_t taskType, ExtTaskLaunchFunc func)
{
    if (!IsValidExtTaskLaunchIndex(chipType, taskType)) {
        RT_LOG(
            RT_LOG_ERROR, "Invalid ext task launch index, chipType=%s, taskType=%s(%d).",
            ChipTypeToString(chipType).c_str(), GetTaskDescByType(static_cast<uint8_t>(taskType)),
            static_cast<int32_t>(taskType));
        return;
    }
    g_extTaskLaunchFuncs[chipType][taskType] = func;
}

ExtTaskLaunchFunc GetExtTaskLaunchFunc(rtChipType_t chipType, tsTaskType_t taskType)
{
    if (!IsValidExtTaskLaunchIndex(chipType, taskType)) {
        return nullptr;
    }
    return g_extTaskLaunchFuncs[chipType][taskType];
}

rtError_t Stream::LaunchExtTask(tsTaskType_t taskType, const void* params)
{
    ExtTaskLaunchFunc const launchFunc = GetExtTaskLaunchFunc(device_->GetChipType(), taskType);
    COND_RETURN_ERROR_MSG_INNER(
        launchFunc == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "Ext task launch is not registered, chipType=%s, taskType=%s(%d).",
        ChipTypeToString(device_->GetChipType()).c_str(), GetTaskDescByType(static_cast<uint8_t>(taskType)),
        static_cast<int32_t>(taskType));
    return launchFunc(this, params);
}

} // namespace runtime
} // namespace cce
