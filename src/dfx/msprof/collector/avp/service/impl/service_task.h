/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SERVICE_IMPL_SERVICE_TASK_H
#define SERVICE_IMPL_SERVICE_TASK_H
#include "profile_param.h"
#include "transport/transport.h"
#include "report/report_manager.h"
#include "task/task_slot.h"
typedef struct {
    uint32_t count;
    uint32_t apiIndex;
    ProfileParam params;
    TransportType transType;
    ReportAttribute reportAttr;
    TaskSlotAttribute taskSlotAttr[MAX_TASK_SLOT];
} ProfileAttribute;

int32_t ServiceTaskInitialize(ProfileAttribute *attr);
int32_t ServiceTaskStart(uint32_t deviceId,  ProfileAttribute *attr);
int32_t ServiceTaskStop(uint32_t deviceId,  ProfileAttribute *attr);
int32_t ServiceTaskFinalize(ProfileAttribute *attr);
#endif