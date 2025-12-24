/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SLOGD_DISTRIBUTE_H
#define SLOGD_DISTRIBUTE_H

#include "slog.h"
#include "log_common.h"
#include "slogd_thread_mgr.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    LogType type;            //  debug/security/run for sorted log
    ProcessType processType; //  APPLICATION/SYSTEM(0/1)
    uint32_t pid;        //  aicpu process pid, it is available when processType is APPLICATION
    uint32_t deviceId;
    int32_t moduleId;
    int32_t aosType;
    int8_t level;
} LogInfo;

typedef struct {
    LogPriority priority;
    bool (*checkLogType)(const LogInfo *);
    int32_t (*write)(const char *, uint32_t, const LogInfo *);
} LogDistributeNode;

typedef struct {
    LogPriority priority;
    void (*receive)(void *);
} LogReceiveNode;

int32_t SlogdReceiveInit(void);
void SlogdWriteToBuffer(const char *msg, uint32_t msgLen, const LogInfo *info);
int32_t SlogdDistributeRegister(const LogDistributeNode *node);
int32_t SlogdDevReceiveRegister(const LogReceiveNode *node);
int32_t SlogdComReceiveRegister(const LogReceiveNode *node);
void SlogdReceiveExit(void);

#ifdef __cplusplus
}
#endif
#endif /* SLOGD_DISTRIBUTE_H */