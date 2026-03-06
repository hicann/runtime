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
RTS_API rtError_t rtStreamGetTasks(rtStream_t stm, rtTask_t* tasks, uint32_t* numTasks);

#if defined(__cplusplus)
}
#endif
#endif // CCE_RUNTIME_RT_INNER_STREAM_H