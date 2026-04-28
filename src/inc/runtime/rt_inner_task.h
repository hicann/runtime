/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_INNER_TASK_H
#define CCE_RUNTIME_RT_INNER_TASK_H

#include "base.h"

#if defined(__cplusplus)
extern "C" {
#endif

typedef enum {
    RT_TASK_DEFAULT,
    RT_TASK_KERNEL,
    RT_TASK_EVENT_RECORD,
    RT_TASK_EVENT_WAIT,
    RT_TASK_EVENT_RESET,
    RT_TASK_VALUE_WRITE,
    RT_TASK_VALUE_WAIT,
} rtTaskType;

typedef struct rtKernelTaskParams {
    rtFuncHandle funcHandle;
    rtKernelLaunchCfg_t* cfg;
    void* args;
    uint32_t isHostArgs;
    size_t argsSize;
    uint32_t numBlocks;
    uint32_t rsv[10];
} rtKernelTaskParams;

typedef struct rtEventRecordTaskParams {
    rtEvent_t event;
    uint64_t eventFlag;
} rtEventRecordTaskParams;

typedef struct rtEventWaitTaskParams {
    rtEvent_t event;
    uint64_t eventFlag;
} rtEventWaitTaskParams;

typedef struct rtEventResetTaskParams {
    rtEvent_t event;
    uint64_t eventFlag;
} rtEventResetTaskParams;

typedef struct rtValueWriteTaskParams {
    void* devAddr;
    uint64_t value;
} rtValueWriteTaskParams;

typedef struct rtValueWaitTaskParams {
    void* devAddr;
    uint64_t value;
    uint32_t flag;
} rtValueWaitTaskParams;

typedef struct rtTaskParams {
    rtTaskType type;
    uint32_t rsv0[3];
    rtTaskGrp_t taskGrp;
    void* opInfoPtr;
    size_t opInfoSize;
    uint8_t rsv1[32];

    union {
        uint8_t rsv2[128];
        struct rtKernelTaskParams kernelTaskParams;
        struct rtEventRecordTaskParams eventRecordTaskParams;
        struct rtEventWaitTaskParams eventWaitTaskParams;
        struct rtEventResetTaskParams eventResetTaskParams;
        struct rtValueWriteTaskParams valueWriteTaskParams;
        struct rtValueWaitTaskParams valueWaitTaskParams;
    };
} rtTaskParams;

/**
 * @ingroup rt_task
 * @brief get the type of the task
 * @param [in] task: task handle
 * @param [in, out] type: variable to store the task type
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtTaskGetType(rtTask_t task, rtTaskType* type);

/**
 * @ingroup rt_task
 * @brief get sequence id of the task
 * @param [in] task: task handle
 * @param [out] id: sequence id of the task
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtTaskGetSeqId(rtTask_t task, uint32_t *id);

/**
 * @ingroup rt_task
 * @brief Get task parameters
 * @details Retrieve current parameter information from the specified task
 * @note  This API only supports AclGraph
 * @param task [in] task handle
 * @param params [out] Output parameter to store the retrieved parameter information
 * @retval RT_ERROR_NONE for ok
 * @retval OtherValues Failure
 */
RTS_API rtError_t rtModelTaskGetParams(rtTask_t task, rtTaskParams* params);

/**
 * @ingroup rt_task
 * @brief Set task parameters
 * @details Update parameter information for the specified task
 * @note  This API only supports AclGraph 
 * @param task [in] task handle
 * @param params [in] Input parameter containing parameter information to be set
 * @retval RT_ERROR_NONE for ok
 * @retval OtherValues Failure
 */
RTS_API rtError_t rtModelTaskSetParams(rtTask_t task, rtTaskParams* params);

/**
 * @ingroup rt_task
 * @brief Get kernel task launch config info
 * @details Get the launch config info for the specified kernel task
 * @note  This API only supports AclGraph
 * @param task [in] task handle
 * @param attrId [in] the id for config info
 * @param attrValue [out] Output config value corresponding to the attrId
 * @retval RT_ERROR_NONE for ok
 * @retval OtherValues Failure
 */
RTS_API rtError_t rtModelKernelTaskGetAttribute(rtTask_t task, rtLaunchKernelAttrId attrId, rtLaunchKernelAttrVal_t *attrValue);

/**
 * @ingroup rt_task
 * @brief Set the task to disabled
 * @param [in, out] task: task handle
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtModelTaskDisable(rtTask_t task);

/**
 * @ingroup rt_task
 * @brief cache extended info for the last task, specifically for debugging
 * @param [in] extendInfoPtr: pointer to the extended task information buffer
 * @param [in] infoSize: size of the buffer
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtCacheLastTaskExtendInfo(const char* const extendInfoPtr, const size_t infoSize);

#if defined(__cplusplus)
}
#endif

#endif // CCE_RUNTIME_RT_INNER_TASK_H