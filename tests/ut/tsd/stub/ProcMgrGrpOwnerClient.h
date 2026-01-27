/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PROCMGR_GROUP_OWNER_CLIENT_H
#define PROCMGR_GROUP_OWNER_CLIENT_H

#include <stdint.h>
#include <string>
#ifdef __cplusplus
extern "C"
{
#endif

enum GrpOwnerClientErrCode {
    GRP_OWNER_CLIENT_SUCCESS = 0U,
    GRP_OWNER_CLIENT_FAILED,
};

enum HeartChannelType {
    MIN_CHL = 0U,
    EZCOMM_CHL,
    MMAP_CHL,
    MAX_CHL
};

struct ResMgrHeartBeatCfg {
    uint32_t timeout;
    enum HeartChannelType chlType;
};

uint32_t GrpOwnerClientInit(const char *ownerName);
uint32_t GrpOwnerClientFini(void);
uint32_t GrpOwnerClientRegHeartBeat(struct ResMgrHeartBeatCfg *heartBeatCfg);
uint32_t GrpOwnerClientUnregisterHeartBeat(void);

int32_t RegisterThreadForDog(const char *threadName, const size_t nameLen, uint32_t dogFeedingCycle);
int32_t UnregisterThreadForDog(const char *threadName, const size_t nameLen);
int32_t KickingTheDog(const char *threadName, const size_t nameLen);
#ifdef __cplusplus
}
#endif
#endif
