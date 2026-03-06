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

/**
 * @ingroup rt_task
 * @brief get the type of the task
 * @param [in] task: task handle
 * @param [in, out] type: variable to store the task type
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtTaskGetType(rtTask_t task, rtTaskType* type);

#if defined(__cplusplus)
}
#endif

#endif // CCE_RUNTIME_RT_INNER_TASK_H