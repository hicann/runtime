/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_monitor.h"
#include "aicpusd_status.h"
#include <stdio.h>

namespace AicpuSchedule {
/**
 * @ingroup AicpuMonitor
 * @brief it is used to construct a object of AicpuMonitor.
 */
AicpuMonitor::AicpuMonitor()
    : deviceId_(0),
      taskTimeoutFlag_(false),
      modelTimeoutFlag_(false),
      done_(false),
      taskTimeout_(UINT64_MAX),
      taskTimeoutTick_(UINT64_MAX),
      modelTimeoutTick_(UINT64_MAX),
      aicpuTaskTimer_(nullptr),
      modelTimer_(nullptr),
      running_(false),
      aicpuCoreNum_(0),
      online_(false),
      opTimeoutFlag_(false)
{}

/**
 * @ingroup AicpuMonitor
 * @brief it is used to destructor a object of AicpuMonitor.
 */
AicpuMonitor::~AicpuMonitor() {}

AicpuMonitor &AicpuMonitor::GetInstance()
{
    static AicpuMonitor instance;
    return instance;
}

int32_t AicpuMonitor::InitMonitor(const uint32_t deviceId, const bool online)
{
    UNUSED(deviceId);
    UNUSED(online);
    return AICPU_SCHEDULE_OK;
}

void AicpuMonitor::SendKillMsgToTsd()
{
    return;
}

void AicpuMonitor::SendKillMsgToTsd(uint64_t delayReportSecond)
{
    UNUSED(delayReportSecond);
    return;
}

void AicpuMonitor::SetTaskInfo(const uint32_t threadIndex, const TaskInfoForMonitor &taskInfo) const
{
    UNUSED(threadIndex);
    UNUSED(taskInfo);
    return;
}

void AicpuMonitor::SetOpExecuteTimeOut(const uint32_t timeOutEn, const uint32_t opExecuteTimeOut)
{
    UNUSED(timeOutEn);
    UNUSED(opExecuteTimeOut);
    return;
}

void AicpuMonitor::SetTaskStartTime(const uint32_t index) 
{
    UNUSED(index);
}

void AicpuMonitor::SetTaskEndTime(const uint32_t index) 
{
    UNUSED(index);
}

void AicpuMonitor::SetAicpuStreamTaskStartTime(const uint32_t taskId) 
{
    UNUSED(taskId);
}

void AicpuMonitor::SetAicpuStreamTaskEndTime(const uint32_t taskId) 
{
    UNUSED(taskId);
}

void AicpuMonitor::SetModelStartTime(const uint32_t modelId) 
{
    UNUSED(modelId);
}

void AicpuMonitor::SetModelEndTime(const uint32_t modelId) 
{
    UNUSED(modelId);
}

int32_t AicpuMonitor::Run()
{
    return AICPU_SCHEDULE_OK;
}

void AicpuMonitor::StopMonitor() {}

int32_t AicpuMonitor::SetTaskTimeoutFlag()
{
    return AICPU_SCHEDULE_OK;
}

int32_t AicpuMonitor::SetModelTimeoutFlag()
{
    return AICPU_SCHEDULE_OK;
}

void AicpuMonitor::Work(AicpuMonitor *monitor) 
{
    UNUSED(monitor);
}

void AicpuMonitor::HandleTaskTimeout() {}

void AicpuMonitor::HandleModelTimeout() {}

void AicpuMonitor::DisableModelTimeout() {}

void AicpuMonitor::SetOpTimerStartTime(const aicpu::TimerHandle timerId, const uint32_t timeInS) 
{
    UNUSED(timerId);
    UNUSED(timeInS);
}

void AicpuMonitor::SetOpTimerEndTime(const aicpu::TimerHandle timerId) 
{
    UNUSED(timerId);
}

void AicpuMonitor::HandleOpTimeout() {}

void AicpuMonitor::InitAsyncOpTimer() {}

uint32_t AicpuMonitor::GetTaskDefaultTimeout() const
{
    return 0U;
}

void AicpuMonitor::SetOpTimeoutFlag(const bool flag) 
{
    UNUSED(flag);
}
}
