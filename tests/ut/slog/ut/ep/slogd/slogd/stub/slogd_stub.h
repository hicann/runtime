/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef SLOGD_STUB_H
#define SLOGD_STUB_H

#include "slogd_thread_mgr.h"
#include "slogd_flush.h"
#include "slogd_recv_core.h"

// flush
typedef struct {
    int32_t (*flush)(void *, size_t, bool);
    int32_t (*get)(void *, void*, size_t);
} FlushNode;

typedef struct {
    ComThread comThread;
    FlushNode comNode[LOG_PRIORITY_TYPE_NUM];
} FlushComThreadMgr;

typedef struct {
    int32_t devNum;
    DevThread devThread[MAX_DEV_NUM];   // DevThread devThread[GROUP_NUM][MAX_DEV_NUM]
    FlushNode devNode[LOG_PRIORITY_TYPE_NUM];    // FlushNode devNode[GROUP_NUM][LOG_PRIORITY_TYPE_NUM]
} FlushDevThreadMgr;

typedef struct {
    FlushComThreadMgr commonMgr;
    FlushDevThreadMgr devThreadMgr;
} FlushMgr;

// receive
struct LogRecFuncNode {
    void (*receive)(void *);
};

typedef struct {
    struct {
        LogDistributeNode distributeNode[LOG_PRIORITY_TYPE_NUM];
    } distributeMgr;
    struct {
        int32_t devNum;
        DevThread devThread[MAX_DEV_NUM];
        struct LogRecFuncNode devNode[LOG_PRIORITY_TYPE_NUM];
        bool isThreadExit;
    } devThreadMgr;
    struct {
        ComThread comThread;
        struct LogRecFuncNode comNode;
        bool isThreadExit;
    } comThreadMgr;
} ReceiveMgr;

#endif // SLOGD_STUB_H