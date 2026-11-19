/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "enum_log_impl.hpp"

#if RUNTIME_ENABLE_ENUM_LOG_NAMES
#include "../device/device.hpp"

#define RT_TASK_FAIL_CALLBACK_TYPE_META(X)                                     \
    X(RT_SET_TASK_FAIL_CALLBACK, "SET_TASK_FAIL_CALLBACK")                     \
    X(RT_REG_TASK_FAIL_CALLBACK_BY_MODULE, "REG_TASK_FAIL_CALLBACK_BY_MODULE") \
    X(RTS_SET_TASK_FAIL_CALLBACK, "RTS_SET_TASK_FAIL_CALLBACK")                \
    X(TASK_FAIL_CALLBACK_TYPE_MAX, "UNKNOWN")

namespace cce {
namespace runtime {

RT_ENUM_STRING_TO_STRING_SCOPED(TaskFailCallbackTypeToString, TaskFailCallbackType, RT_TASK_FAIL_CALLBACK_TYPE_META)

} // namespace runtime
} // namespace cce

#endif // RUNTIME_ENABLE_ENUM_LOG_NAMES
