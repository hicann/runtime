/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_interface.h"
#include "prof_api.h"
#include "ascend_hal.h"
#include "event_custom_api_struct.h"
#include "aicpusd_info.h"

extern "C" {
/**
 * @brief it is used to load model with queue.
 * @param [in] ptr : the address of the model info
 * @return AICPU_SCHEDULE_OK: success  other: error code
 */
int32_t AicpuLoadModelWithQ(void *ptr)
{
    return 0;
}

int32_t AicpuLoadModel(void *ptr)
{
    return 0;
}

/**
 * @brief it is used to load the task and stream info.
 * @param [in] ptr : the address of the task and stream info
 * @return AICPU_SCHEDULE_OK: success  other: error code
 */
int32_t AICPUModelLoad(void *ptr)
{
    return 0;
}

/**
 * @brief it is used to destroy the model.
 * @param [in] modelId : The id of model will be destroy.
 * @return AICPU_SCHEDULE_OK: success  other: error code
 */
int32_t AICPUModelDestroy(uint32_t modelId)
{
    return 0;
}

/**
 * @brief it is used to execute the model.
 * @param [in] modelId : The id of model will be run.
 * @return AICPU_SCHEDULE_OK: success  other: error code
 */
int32_t AICPUModelExecute(uint32_t modelId)
{
    return 0;
}

/**
 * @ingroup AicpuScheduleInterface
 * @brief it use to execute the model from call interface.
 * @param [in] drvEventInfo : event info.
 * @param [out] drvEventAck : event ack.
 * @return 0: success, other: error code
 */
int32_t AICPUExecuteTask(struct event_info *drvEventInfo, struct event_ack *drvEventAck)
{
    return 0;
}

/**
 * @ingroup AicpuScheduleInterface
 * @brief it use to preload so.
 * @param [in] soName : so name.
 * @return 0: success, other: error code
 */
int32_t AICPUPreOpenKernels(const char *soName)
{
    return 0;
}

/**
 * @brief it is used to init aicpu scheduler for acl.
 * @param [in] deviceId : The id of self cpu.
 * @param [in] hostPid : The id of host
 * @param [in] profilingMode : it used to open or close profiling.
 * @return AICPU_SCHEDULE_OK: success  other: error code in StatusCode
 */
int32_t InitAICPUScheduler(uint32_t deviceId, pid_t hostPid, ProfilingMode profilingMode)
{
    return 0;
}

/**
 * @brief it is used to init aicpu scheduler for helper.
 * @param [in] initParam : init param ptr.
 * @return AICPU_SCHEDULE_SUCCESS: success  other: error code in ErrorCode
 */
int32_t InitCpuScheduler(const CpuSchedInitParam* const initParam)
{
    return 0;
}

/**
 * @brief it is used to update profiling mode for acl.
 * @param [in] deviceId : The id of self cpu.
 * @param [in] hostPid : The id of host
 * @param [in] flag : flag[0] == 1 means PROFILING_OPEN, otherwise PROFILING_CLOSE.
 * @return AICPU_SCHEDULE_OK: success  other: error code in StatusCode
 */
int32_t UpdateProfilingMode(uint32_t deviceId, pid_t hostPid, uint32_t flag)
{
    return 0;
}

/**
 * @brief it is used to stop the aicpu scheduler for acl.
 * @param [in] deviceId : The id of self cpu.
 * @param [in] hostPid : host pid
 * @return AICPU_SCHEDULE_OK: success  other: error code in StatusCode
 */
int32_t StopAICPUScheduler(uint32_t deviceId, pid_t hostPid)
{
    return 0;
}

/**
 * @brief Check if the scheduling module stops running
 * @return true or false
 */
bool AicpuIsStoped()
{
    return false;
}

/**
 * @brief it is used to load op mapping info for data dump.
 * @param [in] infoAddr : The pointer of info.
 * @param [in] len : The length of info
 * @return AICPU_SCHEDULE_OK: success  other: error code in StatusCode
 */
int32_t LoadOpMappingInfo(const void *infoAddr, uint32_t len)
{
    return 0;
}

/**
 * @brief it is used to set report callback function.
 * @param [in] reportCallback : report callback function.
 * @return AICPU_SCHEDULE_OK: success  other: error code in StatusCode
 */
int32_t AicpuSetMsprofReporterCallback(MsprofReporterCallback reportCallback)
{
    return 0;
}

void AicpuReportNotifyInfo(const aicpu::AsyncNotifyInfo &notifyInfo) {}

uint32_t AicpuGetTaskDefaultTimeout()
{
    return 0;
}

void RegLastwordCallback(const std::string mark,
    std::function<void ()> callback, std::function<void ()> &cancelReg)
{
    return;
}
}