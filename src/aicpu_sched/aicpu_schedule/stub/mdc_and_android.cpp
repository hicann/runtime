/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "profiling_adp.h"
#include "aicpusd_status.h"

namespace aicpu {
#ifdef __cplusplus
extern "C" {
#endif
bool IsModelProfOpen()
{
    return false;
}

bool IsProfOpen()
{
    return false;
}

void UpdateModelMode(const bool mode)
{
    (void)mode;
    return;
}

void UpdateMode(const bool mode)
{
    (void)mode;
}

uint64_t GetSystemTick()
{
    uint64_t cnt = 0UL;
#ifndef RUN_TEST
    asm volatile("mrs %0, CNTVCT_EL0" : "=r"(cnt) :);
#endif
    return cnt;
}

void SendToProfiling(const std::string &sendData, const std::string &mark)
{
    (void)sendData;
    (void)mark;
}

uint64_t GetSystemTickFreq()
{
    uint64_t freq = 1UL;
#ifndef RUN_TEST
    asm volatile("mrs %0, CNTFRQ_EL0" : "=r"(freq) :);
#endif
    return freq;
}

int32_t SetProfHandle(const std::shared_ptr<ProfMessage> profMsg)
{
    (void)profMsg;
    return 0;
}

uint64_t NowMicros()
{
    return 1UL;
}

void ReleaseProfiling() {}

void InitProfilingDataInfo(const uint32_t deviceId, const pid_t hostPid, const uint32_t channelId)
{
    (void)deviceId;
    (void)hostPid;
    (void)channelId;
}

void InitProfiling(const uint32_t deviceId, const pid_t hostPid, const uint32_t channelId)
{
    (void)deviceId;
    (void)hostPid;
    (void)channelId;
}

void SetProfilingFlagForKFC(const uint32_t flag)
{
    (void)flag;
}
void LoadProfilingLib() {}

bool IsSupportedProfData()
{
    return false;
}

int32_t SetMsprofReporterCallback(MsprofReporterCallback reportCallback)
{
    (void)reportCallback;
    return static_cast<int32_t>(ProfStatusCode::PROFILINE_SUCCESS);
}

#ifdef __cplusplus
}
#endif

ProfMessage::ProfMessage(const char_t *tag) : std::basic_ostringstream<char_t>(), tag_(tag), sendData_()
{
}

ProfMessage::~ProfMessage()
{
}
}
