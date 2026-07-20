/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_INNER_MODEL_H
#define CCE_RUNTIME_RT_INNER_MODEL_H

#include "base.h"

#if defined(__cplusplus)
extern "C" {
#endif

/**
 * @ingroup dvrt_base
 * @brief condition task handle.
 */
typedef void* rtCondHandle_t;

typedef enum tagRtCondHandleFlag {
    RT_COND_HANDLE_ASSIGN_DEFAULT = 1,
} rtCondHandleFlag_t;

typedef enum tagRtCondTaskType {
    RT_COND_TASK_TYPE_IF = 0,
    RT_COND_TASK_TYPE_WHILE = 1,
    RT_COND_TASK_TYPE_SWITCH = 2,
    RT_COND_TASK_TYPE_MAX = 3,
} rtCondTaskType_t;

typedef enum tagRtCondNumber {
    RT_COND_NUMBER_ZERO = 0,
    RT_COND_NUMBER_ONE = 1,
    RT_COND_NUMBER_TWO = 2,
    RT_COND_NUMBER_THREE = 3,
} rtCondNumber_t;

typedef struct rtCondTaskParams {
    rtCondHandle_t handle; // condition handle
    rtCondTaskType_t type; // condition type
    uint32_t
        size; // condition number, 1 or 2 for if condition, 1 for while condition, greater than 0 for switch condition
    rtModel_t* modelRIArray; // sub models.
} rtCondTaskParams;

/**
 * @ingroup rt_model
 * @brief get streams from the model
 * @param [in] mdl: model handle
 * @param [in, out] streams: array to store the retrieved streams
 * @param [in] numStreams: size of streams array
 * @param [out] numStreams: actual number of streams retrieved
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_INSUFFICIENT_INPUT_ARRAY for insufficient tasks array size to hold all streams
 */
RTS_API rtError_t rtModelGetStreams(rtModel_t const mdl, rtStream_t* streams, uint32_t* numStreams);

/**
 * @ingroup rt_model
 * @brief register callback func for model destroy
 * @param [in] mdl
 * @param [in] fn
 * @param [in] ptr
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtModelDestroyRegisterCallback(rtModel_t const mdl, rtCallback_t fn, void* ptr);

/**
 * @ingroup rt_model
 * @brief unregister callback func for model destroy
 * @param [in] mdl
 * @param [in] fn
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtModelDestroyUnregisterCallback(rtModel_t const mdl, rtCallback_t fn);

/**
 * @ingroup rt_model
 * @brief update model
 * @param [in] mdl
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtModelUpdate(rtModel_t mdl);

/**
 * @ingroup AscendCL
 * @brief create condition handle
 * @param [in] modelRI  model to create handle
 * @param [in] defaultLaunchValue  当flag置为ACL_CODN_HANDLE_ASSIGN_DEFAULT，条件变量在每次模型执行开始时被置为该初始值
 * @param [in] flag  当前只支持ACL_CODN_HANDLE_ASSIGN_DEFAULT或0
 * @param [out] handle  条件句柄
 * @retval ACL_SUCCESS The function is successfully executed.
 * @retval OtherValues Failure
 */
RTS_API rtError_t
rtModelCondHandleCreate(rtModel_t mdl, uint32_t defaultLaunchValue, rtCondHandleFlag_t flag, rtCondHandle_t* handle);

/**
 * @ingroup AscendCL
 * @brief create condition handle
 * @param [in] handle  条件句柄
 * @param [out] devicePtr  device ptr用于存放条件值
 * @retval ACL_SUCCESS The function is successfully executed.
 * @retval OtherValues Failure
 */
RTS_API rtError_t rtModelCondHandleGetCondPtr(rtCondHandle_t handle, uint64_t** devPtr);

/**
 * @ingroup AscendCL
 * @brief add condition task to stream
 * @param [in] params  条件算子任务参数，包含条件句柄（条件值、默认值等）、条件类型，分支个数、子图等
 * @param [in] stream  执行条件任务的流，必须是capture status active状态的aclgraph流
 * @param [in] flag    预留参数
 * @retval ACL_SUCCESS The function is successfully executed.
 * @retval OtherValues Failure
 */
RTS_API rtError_t rtStreamAddCondTask(rtCondTaskParams params, rtStream_t stm, uint32_t flags);

/**
 * @ingroup AscendCL
 * @brief stream begin capture for submodel
 * @param [in] stm: stream handle
 * @param [in] mdl: father capture model
 * @param [in] mode: capture mode
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtStreamBeginCaptureToModel(rtStream_t stm, rtModel_t mdl, const rtStreamCaptureMode mode);

#if defined(__cplusplus)
}
#endif
#endif // CCE_RUNTIME_RT_INNER_MODEL_H
