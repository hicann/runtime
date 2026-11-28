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
#include "../../../feature/snapshot/snapshot_socket.hpp"
#include "../device/device.hpp"
#include "runtime/base.h"

// These converters are also needed by the separately linked runtime_common library.
#define RT_TASK_FAIL_CALLBACK_TYPE_META(X)                                     \
    X(RT_SET_TASK_FAIL_CALLBACK, "SET_TASK_FAIL_CALLBACK")                     \
    X(RT_REG_TASK_FAIL_CALLBACK_BY_MODULE, "REG_TASK_FAIL_CALLBACK_BY_MODULE") \
    X(RTS_SET_TASK_FAIL_CALLBACK, "RTS_SET_TASK_FAIL_CALLBACK")                \
    X(TASK_FAIL_CALLBACK_TYPE_MAX, "UNKNOWN")

#define RT_PROF_CTRL_TYPE_META(X)                  \
    X(RT_PROF_CTRL_INVALID, "UNKNOWN")             \
    X(RT_PROF_CTRL_SWITCH, "PROF_CTRL_SWITCH")     \
    X(RT_PROF_CTRL_REPORTER, "PROF_CTRL_REPORTER") \
    X(RT_PROF_CTRL_BUTT, "UNKNOWN")

#define RT_SNAPSHOT_OP_META(X) \
    X(LOCK, "LOCK")            \
    X(BACKUP, "BACKUP")        \
    X(RESTORE, "RESTORE")      \
    X(UNLOCK, "UNLOCK")        \
    X(GET_STATE, "GET_STATE")  \
    X(GET_RESTORE_THREAD_ID, "GET_RESTORE_THREAD_ID")

namespace cce {
namespace runtime {

RT_ENUM_STRING_TO_STRING_SCOPED(TaskFailCallbackTypeToString, TaskFailCallbackType, RT_TASK_FAIL_CALLBACK_TYPE_META)

RT_ENUM_STRING_FROM_VALUE(ProfCtrlTypeToString, rtProfCtrlType_t, RT_PROF_CTRL_TYPE_META, uint32_t)

RT_ENUM_STRING_FROM_VALUE(SnapshotOpToString, rtSnapshotOp, RT_SNAPSHOT_OP_META, uint32_t)

} // namespace runtime
} // namespace cce

#endif // RUNTIME_ENABLE_ENUM_LOG_NAMES
