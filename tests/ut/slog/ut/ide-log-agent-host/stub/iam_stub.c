/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "iam.h"
#include "unified_timer.h"

typedef void (*IamRegister) (struct IAMVirtualResourceStatus *resList, const int32_t listNum);
IamRegister g_iamRegRes = NULL;

int32_t IAMRegResStatusChangeCb(void (*ResourceStatusChangeCb)(struct IAMVirtualResourceStatus *resList,
                                                               const int32_t listNum),
                                struct IAMResourceSubscribeConfig config)
{
    struct IAMVirtualResourceStatus virtualResStatus = { "dp:/res/logmgr/logout", IAM_RESOURCE_READY };
    g_iamRegRes = ResourceStatusChangeCb;
    g_iamRegRes(&virtualResStatus, 1);
    return 0;
}

int32_t IAMUnregResStatusChangeCb(void)
{
    g_iamRegRes = NULL;
    return 0;
}

bool IAMCheckServicePreparation(void)
{
    return true;
}

int32_t IAMUnregAssignedResStatusChangeCb(char *resName)
{
    return 0;
}

uint32_t AddUnifiedTimer(const char *timerName, void (*callback)(), int64_t period, enum TimerType type)
{
    return 0U;
}

uint32_t RemoveUnifiedTimer(const char *timerName)
{
    return 0U;
}