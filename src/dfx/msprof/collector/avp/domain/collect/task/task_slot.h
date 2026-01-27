/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DOMAIN_COLLECT_TASK_TASK_SLOT_H
#define DOMAIN_COLLECT_TASK_TASK_SLOT_H
#include "job/job_manager.h"
#include "utils/utils.h"

typedef struct {
    uint32_t deviceId;
    uint32_t launchRepeatTimes;           // times of starting task called
    OsalThread handle;
    JobManagerAttribute jobAttr;
    bool started;                         // device job is started or not
    bool quit;                            // task slot thread is started or not
    OsalCond taskStartCond;
    OsalCond taskStopCond;
    OsalCond taskEndCond;
    OsalMutex taskMtx;
} TaskSlotAttribute;

int32_t TaskSlotInitialize(TaskSlotAttribute *attr);
int32_t TaskSlotStart(const ProfileParam *params, TaskSlotAttribute *attr);
int32_t TaskSlotStop(TaskSlotAttribute *attr);
int32_t TaskSlotFinalize(TaskSlotAttribute *attr);

#endif
