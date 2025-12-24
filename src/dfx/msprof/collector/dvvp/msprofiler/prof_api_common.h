/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef MSPROF_ENGINE_ACL_API_COMMON_H
#define MSPROF_ENGINE_ACL_API_COMMON_H

#include <cstdint>

#include "prof_acl_api.h"
#include "prof_api.h"
#include "utils.h"

#ifdef MSPROF_DEBUG
const uint64_t PROF_SWITCH_SUPPORT = PROF_ACL_API | PROF_TASK_TIME | PROF_TASK_TIME_L1 | PROF_AICORE_METRICS |
    PROF_AICPU_TRACE | PROF_GE_API_L1 | PROF_RUNTIME_API | PROF_TASK_TSFW | PROF_GE_API_L0 |
    PROF_RUNTIME_TRACE | PROF_SCHEDULE_TIMELINE | PROF_SCHEDULE_TRACE | PROF_AIVECTORCORE_METRICS |
    PROF_SUBTASK_TIME | PROF_TRAINING_TRACE | PROF_HCCL_TRACE | PROF_CPU | PROF_HARDWARE_MEMORY |
    PROF_IO | PROF_INTER_CONNECTION | PROF_DVPP | PROF_SYS_AICORE_SAMPLE | PROF_AIVECTORCORE_SAMPLE |
    PROF_L2CACHE | PROF_MSPROFTX | PROF_AICPU_MODEL | PROF_TASK_MEMORY | PROF_TASK_TIME_L2 | PROF_OP_ATTR |
    PROF_TASK_TIME_L3;
#else
const uint64_t PROF_SWITCH_SUPPORT = PROF_ACL_API | PROF_TASK_TIME | PROF_TASK_TIME_L1 | PROF_AICORE_METRICS |
    PROF_AICPU_TRACE | PROF_L2CACHE | PROF_HCCL_TRACE | PROF_TRAINING_TRACE | PROF_MSPROFTX | PROF_RUNTIME_API |
    PROF_AICPU_MODEL | PROF_TASK_MEMORY | PROF_GE_API_L0 | PROF_GE_API_L1 | PROF_TASK_TIME_L2 |
    PROF_OP_ATTR | PROF_TASK_TIME_L3;
#endif // MSPROF_DEBUG

#define RETURN_IF_NOT_SUCCESS(ret)  \
    do {                            \
        if ((ret) != ACL_SUCCESS) { \
            return ret;             \
        }                           \
    } while (0)
#endif // MSPROF_ENGINE_ACL_API_COMMON_H
