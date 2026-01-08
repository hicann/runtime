/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPUSD_INTERFACE_H
#define AICPUSD_INTERFACE_H

#include <sched.h>

#include "aicpusd_info.h"
#include "prof_api.h"
#include "tsd.h"
#include "aicpu_async_event.h"

extern "C" {
enum __attribute__((visibility("default"))) ErrorCode : int32_t {
    AICPU_SCHEDULE_SUCCESS,
    AICPU_SCHEDULE_FAIL,
    AICPU_SCHEDULE_ABORT,
};

/**
 * @brief it is used to load the task and stream info.
 * @param [in] ptr : the address of the task and stream info
 * @return AICPU_SCHEDULE_SUCCESS: sucess  other: error code in ErrorCode
 */
__attribute__((visibility("default"))) int32_t AICPUModelLoad(void *ptr);

/**
 * @brief it is used to destory the model.
 * @param [in] modelId : The id of model will be destroy.
 * @return AICPU_SCHEDULE_SUCCESS: sucess  other: error code in ErrorCode
 */
__attribute__((visibility("default"))) int32_t AICPUModelDestroy(uint32_t modelId);

/**
 * @brief it is used to execute the model.
 * @param [in] modelId : The id of model will be run.
 * @return AICPU_SCHEDULE_SUCCESS: sucess  other: error code in ErrorCode
 */
__attribute__((visibility("default"))) int32_t AICPUModelExecute(uint32_t modelId);

/**
 * @brief it is used to init aicpu scheduler for acl.
 * @param [in] deviceId : The id of self cpu.
 * @param [in] hostPid :  pid of host appication
 * @param [in] profilingMode : it used to open or close profiling.
 * @return AICPU_SCHEDULE_SUCCESS: sucess  other: error code in ErrorCode
 */
__attribute__((visibility("default"))) int32_t InitAICPUScheduler(uint32_t deviceId, pid_t hostPid,
                                                                  ProfilingMode profilingMode);

/**
 * @brief it is used to update profiling mode for acl.
 * @param [in] deviceId : The id of self cpu.
 * @param [in] hostPid : The id of host
 * @param [in] flag : flag[0] == 1 means PROFILING_OPEN, otherwise PROFILING_CLOSE.
 * @return AICPU_SCHEDULE_OK: sucess  other: error code in StatusCode
 */
__attribute__((visibility("default"))) int32_t UpdateProfilingMode(uint32_t deviceId, pid_t hostPid, uint32_t flag);

/**
 * @brief it is used to stop the aicpu scheduler for acl.
 * @param [in] deviceId : The id of self cpu.
 * @param [in] hostPid : pid of host appication
 * @return AICPU_SCHEDULE_SUCCESS: sucess  other: error code in ErrorCode
 */
__attribute__((visibility("default"))) int32_t StopAICPUScheduler(uint32_t deviceId, pid_t hostPid);

/**
 * @ingroup AicpuScheduleInterface
 * @brief it use to execute the model from call interface.
 * @param [in] drvEventInfo : event info.
 * @param [out] eventAck : event ack.
 * @return 0: sucess, other: error code
 */
__attribute__((visibility("default"))) int32_t AICPUExecuteTask(struct event_info* drvEventInfo,
                                                                struct event_ack* drvEventAck);

/**
 * @ingroup AicpuScheduleInterface
 * @brief it use to preload so.
 * @param [in] soName : so name.
 * @return 0: sucess, other: error code
 */
__attribute__((visibility("default"))) int32_t AICPUPreOpenKernels(const char *soName);

/**
 * @brief it is used to load op mapping info for data dump.
 * @param [in] infoAddr : The pointer of info.
 * @param [in] len : The length of info
 * @return AICPU_SCHEDULE_OK: sucess  other: error code in StatusCode
 */
__attribute__((visibility("default"))) int32_t LoadOpMappingInfo(const void *infoAddr, uint32_t len);

/**
 * @brief it is used to set report callback function.
 * @param [in] reportCallback : report callback function.
 * @return AICPU_SCHEDULE_OK: sucess  other: error code in StatusCode
 */
__attribute__((visibility("default"))) int32_t AicpuSetMsprofReporterCallback(MsprofReporterCallback reportCallback);

/**
 * @brief it is used to init aicpu scheduler for helper.
 * @param [in] initParam : init param.
 * @return AICPU_SCHEDULE_SUCCESS: sucess  other: error code in ErrorCode
 */
__attribute__((visibility("default"))) int32_t InitCpuScheduler(const CpuSchedInitParam * const initParam);

/**
 * @brief it is used to load model with queue.
 * @param [in] ptr : the address of the model info
 * @return AICPU_SCHEDULE_OK: sucess  other: error code
 */
__attribute__((visibility("default"))) int32_t AicpuLoadModelWithQ(void *ptr);

/**
 * @brief it is used to stop aicpu module.
 * @param [in] eventInfo : the message send by tsd
 * @return AICPU_SCHEDULE_OK: sucess  other: error code
 */
__attribute__((visibility("default"))) int32_t StopAicpuSchedulerModule(const struct TsdSubEventInfo * const
                                                                        eventInfo);
/**
 * @brief it is used to start aicpu module.
 * @param [in] eventInfo : the message send by tsd
 * @return AICPU_SCHEDULE_OK: sucess  other: error code
 */
__attribute__((visibility("default"))) int32_t StartAicpuSchedulerModule(const struct TsdSubEventInfo * const
                                                                         eventInfo);

/**
 * @brief it is used to send retcode to ts.
 * @return AICPU_SCHEDULE_OK: sucess  other: error code
 */
__attribute__((weak)) __attribute__((visibility("default"))) void AicpuReportNotifyInfo(
    const aicpu::AsyncNotifyInfo &notifyInfo);

/**
 * @brief it is used to get task default timeout, uint is second.
 * @return timeout: unit is second
 */
__attribute__((weak)) __attribute__((visibility("default"))) uint32_t AicpuGetTaskDefaultTimeout();

/**
 * @brief Check if the scheduling module stops running
 * @return true or false
 */
__attribute__((weak)) __attribute__((visibility("default"))) bool AicpuIsStoped();

/**
 * @brief it is used to register last word.
 * @param [in] mark : module lable.
 * @param [in] callback : record last word callback.
 * @param [out] cancelDeadline : cancel reg closer.
 */
__attribute__((weak)) __attribute__((visibility("default"))) void RegLastwordCallback(const std::string mark,
    std::function<void ()> callback, std::function<void ()> &cancelReg);

/**
 * @brief it is used to load model with event.
 * @param [in] ptr : the address of the model info
 * @return AICPU_SCHEDULE_OK: sucess  other: error code
 */
__attribute__((visibility("default"))) int32_t AicpuLoadModel(void *ptr);

/**
 * @brief it is used to stop model.
 * @param [in] ptr : the address of config
 * @return AICPU_SCHEDULE_OK: sucess  other: error code
 */
__attribute__((visibility("default"))) int32_t AICPUModelStop(const ReDeployConfig * const ptr);

/**
 * @brief it is used to recover model.
 * @param [in] ptr : the address of the config
 * @return AICPU_SCHEDULE_OK: sucess  other: error code
 */
__attribute__((visibility("default"))) int32_t AICPUModelClearInputAndRestart(const ReDeployConfig * const ptr);

/**
 * @brief it is used to check kernel support.
 * @param [in] cfgPtr : cfgPtr which point to CheckKernelSupportedConfig.
 * @return AICPU_SCHEDULE_OK: supported  other: not supported
 */
__attribute__((visibility("default"))) int32_t CheckKernelSupported(const CheckKernelSupportedConfig * const cfgPtr);

/**
 * @brief it is used to stop the aicpu scheduler for helper.
 * @param [in] deviceId : The id of self cpu.
 * @param [in] hostPid : host pid
 * @return AICPU_SCHEDULE_OK: success  other: error code in StatusCode
 */
__attribute__((visibility("default"))) int32_t StopCPUScheduler(const uint32_t deviceId, const pid_t hostPid);


__attribute__((visibility("default"))) int32_t AICPUModelProcessDataException(
    const DataFlowExceptionNotify *const exceptionInfo);
}
#endif  // INC_AICPUSD_AICPUSD_INTERFACE_H_
