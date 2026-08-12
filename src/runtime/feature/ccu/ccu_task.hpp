/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_CCU_TASK_HPP__
#define __CCE_RUNTIME_CCU_TASK_HPP__

#include "task_info.hpp"
#include "device_error_inner_data.hpp"
#include "runtime_task_manager.h"
namespace cce {
namespace runtime {
void CcuLaunchTaskInit(TaskInfo* taskInfo, rtCcuTaskInfo_t* const ccuInfo);
void PrintErrorInfoForCcuLaunchTask(TaskInfo* taskInfo, const uint32_t devId);
void DoCompleteSuccessForCcuLaunchTask(TaskInfo* taskInfo, const uint32_t devId);
void SetResultForCcuLaunchTask(TaskInfo* taskInfo, const rtLogicCqReport_t& logicCq);
void TaskFailCallBackForFusionKernelTask(
    const TaskInfo* const taskInfo, const uint32_t deviceId, const StarsDeviceErrorInfo* const info,
    rtFusionExType_t fusionDetailType);
} // namespace runtime
} // namespace cce

#endif
