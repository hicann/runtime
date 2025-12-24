/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "trace_queue.h"
#include "adiag_print.h"
#include "adiag_utils.h"
#include "trace_types.h"

void XFreeTraceNode(TraceNode **node)
{
    ADIAG_CHK_NULL_PTR(node, return);
    ADIAG_CHK_NULL_PTR(*node, return);

    TraceNode *tmp = (TraceNode *)*node;
    ADIAG_SAFE_FREE(tmp->data);
    ADIAG_SAFE_FREE(tmp);
    *node = NULL;
}

TraStatus TraceQueueInit(TraceQueue *queue)
{
    ADIAG_CHK_NULL_PTR(queue, return TRACE_INVALID_PTR);

    queue->count = 0;
    queue->size = 0;
    queue->head = NULL;
    queue->rear = NULL;
    return TRACE_SUCCESS;
}

// not free trace_queue
TraStatus TraceQueueFree(TraceQueue *queue)
{
    ADIAG_CHK_NULL_PTR(queue, return TRACE_INVALID_PTR);

    TraceNode *tmp = NULL;
    int32_t num = (int32_t)queue->count;
    for (int32_t i = 0; i < num; i++) {
        TraStatus ret = TraceQueueDequeue(queue, &tmp);
        if (ret == TRACE_QUEUE_NULL) {
            break;
        }
        XFreeTraceNode(&tmp);
    }

    return TRACE_SUCCESS;
}

STATIC TraStatus TraceQueueFull(const TraceQueue *queue)
{
    if ((queue->count >= MAX_QUEUE_COUNT) ||
        (queue->size >= MAX_QUEUE_SIZE)) {
        return TRACE_QUEUE_FULL;
    }

    return TRACE_SUCCESS;
}

STATIC TraStatus TraceQueueNULL(const TraceQueue *queue)
{
    if ((queue->count == 0) || (queue->size == 0) ||
        ((queue->head == NULL) && (queue->rear == NULL))) {
        return TRACE_QUEUE_NULL;
    }

    return TRACE_SUCCESS;
}

TraStatus TraceQueueEnqueue(TraceQueue *queue, TraceNode *node)
{
    ADIAG_CHK_NULL_PTR(queue, return TRACE_INVALID_PTR);
    ADIAG_CHK_NULL_PTR(node, return TRACE_INVALID_PTR);
    ADIAG_CHK_EXPR_ACTION(node->dataLen == 0, return TRACE_INVALID_PARAM, "trace node is empty.");

    // queue would be more than max_size, but node max_count
    if (TraceQueueFull(queue) != TRACE_SUCCESS) {
        ADIAG_RUN_INF("queue is full.");
        return TRACE_QUEUE_FULL;
    }

    if (TraceQueueNULL(queue) != TRACE_SUCCESS) {
        queue->head = node;
        queue->rear = node;
        queue->count = 1;
        queue->size = node->dataLen;
    } else {
        queue->rear->next = node; // firstly, join the node to list
        queue->rear = node; // secondly, mv rear to listRear
        queue->count++;
        queue->size += node->dataLen;
    }

    return TRACE_SUCCESS;
}

TraStatus TraceQueueDequeue(TraceQueue *queue, TraceNode **node)
{
    ADIAG_CHK_NULL_PTR(queue, return TRACE_INVALID_PTR);
    ADIAG_CHK_NULL_PTR(node, return TRACE_INVALID_PTR);

    if (TraceQueueNULL(queue) != TRACE_SUCCESS) {
        return TRACE_QUEUE_NULL;
    }

    *node = queue->head; // get head
    if (queue->count == 1) {
        (void)TraceQueueInit(queue);
    } else {
        TraceNode *tmp = queue->head;
        queue->count--;
        queue->size -= tmp->dataLen;
        queue->head = tmp->next;
        tmp->next = NULL;
    }

    return TRACE_SUCCESS;
}
