/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ProcMgrGrpOwnerClient.h"
#include "ProcMgrSysOperatorAgent.h"
#include <iostream>
uint32_t GrpOwnerClientInit(const char *ownerName)
{
    return 0U;
}
uint32_t GrpOwnerClientFini(void)
{
    return 0U;
}
uint32_t GrpOwnerClientRegHeartBeat(struct ResMgrHeartBeatCfg *heartBeatCfg)
{
    return 0U;
}
uint32_t GrpOwnerClientUnregisterHeartBeat(void)
{
    return 0U;
}

int32_t RegisterThreadForDog(const char *threadName, const size_t nameLen, uint32_t dogFeedingCycle)
{
    return 0;
}

int32_t UnregisterThreadForDog(const char *threadName, const size_t nameLen)
{
    return 0;
}

int32_t KickingTheDog(const char *threadName, const size_t nameLen)
{
    return 0;
}

uint32_t ProcMgrSetScheduler(const std::vector<SetSchedulerInfo>& schedulerInfo)
{
    return 0;
}

int32_t ProcMgrUpdateSePolicy()
{
    return 0;
}