/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DOMAIN_COLLECT_TASK_TASK_MANAGER_H
#define DOMAIN_COLLECT_TASK_TASK_MANAGER_H
#include "osal/osal.h"
#include "task/task_slot.h"
#include "transport/transport.h"

#ifdef __cplusplus
extern "C" {
#endif

int32_t TaskManagerInitialize(uint32_t deviceId, TaskSlotAttribute *attr);
int32_t TaskManagerStart(ProfileParam *params, const TransportType transType, TaskSlotAttribute *attr);
int32_t TaskManagerStop(ProfileParam *params, TaskSlotAttribute *attr);
int32_t TaskManagerFinalize(TaskSlotAttribute *attr);

#ifdef __cplusplus
}
#endif
#endif
