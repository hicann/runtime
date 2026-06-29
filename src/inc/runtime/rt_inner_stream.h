/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_INNER_STREAM_H
#define CCE_RUNTIME_RT_INNER_STREAM_H

#include "base.h"
#include "rt_inner_event.h"

#if defined(__cplusplus)
extern "C" {
#endif

/**
 * @ingroup dvrt_stream
 * @brief get tasks from the model stream
 * @param [in] stm: model stream handle
 * @param [in, out] tasks: array to store the retrieved task
 * @param [in] numTasks: size of tasks array
 * @param [out] numTasks: actual number of tasks retrieved
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_INSUFFICIENT_INPUT_ARRAY for insufficient tasks array size to hold all tasks
 */
RTS_API rtError_t rtStreamGetTasks(rtStream_t const stm, rtTask_t* tasks, uint32_t* numTasks);

/**
 * @ingroup dvrt_stream
 * @brief wait an event with operation-level behavior flag
 * @param [in] stm the wait stream
 * @param [in] evt the event to wait
 * @param [in] timeout timeout value. For RT_EVENT_WAIT_EXTERNAL, only -1 is supported.
 * @param [in] flag RT_EVENT_WAIT_DEFAULT for normal wait, RT_EVENT_WAIT_EXTERNAL for ACL graph external wait
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtStreamWaitEventWithFlag(rtStream_t stm, rtEvent_t evt, int32_t timeout, uint32_t flag);

#if defined(__cplusplus)
}
#endif
#endif // CCE_RUNTIME_RT_INNER_STREAM_H