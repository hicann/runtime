/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TRACE_QUEUE_H
#define TRACE_QUEUE_H

#include "atrace_types.h"

#define MAX_QUEUE_COUNT 16
#define MAX_QUEUE_SIZE (8 * 1024 * 1024)

#ifdef __cplusplus
extern "C" {
#endif

typedef struct node {
    uint8_t flag;
    uint32_t dataLen;
    void *data;
    struct node *next;
} TraceNode;

typedef struct {
    uint32_t count;
    uint32_t size;
    TraceNode *head; // void struct should have size
    TraceNode *rear;
} TraceQueue;

// queue init
TraStatus TraceQueueInit(TraceQueue *queue);

// queue free
TraStatus TraceQueueFree(TraceQueue *queue);

// node enqueue
TraStatus TraceQueueEnqueue(TraceQueue *queue, TraceNode *node);

// node dequeue
TraStatus TraceQueueDequeue(TraceQueue *queue, TraceNode **node);

void XFreeTraceNode(TraceNode **node);

#ifdef __cplusplus
}
#endif

#endif  // KTRACE_QUEUE_H
