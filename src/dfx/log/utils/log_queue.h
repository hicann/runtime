/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_QUEUE_H
#define LOG_QUEUE_H

#include "log_error_code.h"
#include "log_common.h"


#define MAX_QUEUE_COUNT 8
#define MAX_QUEUE_SIZE (8 * 1024 * 1024)

#ifdef __cplusplus
extern "C" {
#endif

typedef struct Node {
    uint32_t uiNodeDataLen;
    uint32_t uiNodeNum;
    void *stNodeData;
    struct Node *next;
    int16_t moduleId;
} LogNode;

typedef struct {
    uint32_t uiNodeNum;
    void *stNodeData;
} NodesInfo;

typedef struct {
    uint32_t deviceId;
    uint32_t uiCount;
    uint32_t uiSize;
    LogNode *stHead; // void struct should have uiSize
    LogNode *stRear;
} LogQueue;

// queue init
LogRt LogQueueInit(LogQueue *queue, uint32_t deviceId);

// queue free
LogRt LogQueueFree(LogQueue *queue, void (*freeNode)(LogNode **));

// node enqueue
LogRt LogQueueEnqueue(LogQueue *queue, LogNode *node);

// node dequeue
LogRt LogQueueDequeue(LogQueue *queue, LogNode **node);

// check whether queue is full
LogRt LogQueueFull(const LogQueue *queue);

// check whether queue is NULL
LogRt LogQueueNULL(const LogQueue *queue);

void XFreeLogNode(LogNode **node);

#ifdef __cplusplus
}
#endif

#endif  // __LOG_BUF_Q_H__
