/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "trace_node.h"
#include "trace_types.h"
#include "adiag_print.h"
#include "trace_system_api.h"

#define MAX_DEV_NUM         64

TraStatus TraceTsPushNode(SessionNode *sessionNode, uint8_t flag, void *data, uint32_t len)
{
    if ((sessionNode == NULL) || (data == NULL)) {
        ADIAG_ERR("invalid input for node searching");
        return TRACE_INVALID_PARAM;
    }
    TraceNode *node = (TraceNode *)AdiagMalloc(sizeof(TraceNode));
    if (node == NULL) {
        ADIAG_ERR("malloc node failed, strerr=%s.", strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }
    node->data = data;
    node->dataLen = len;
    node->flag = flag;
    TraStatus ret = TraceQueueEnqueue(sessionNode->queue, node);
    if (ret != TRACE_SUCCESS) {
        ADIAG_SAFE_FREE(node);
        ADIAG_ERR("enqueue failed, ret = %d.", ret);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

TraceNode *TraceTsPopNode(SessionNode *sessionNode)
{
    if (sessionNode == NULL) {
        ADIAG_ERR("invalid input for node searching.");
        return NULL;
    }
    TraceNode *node = NULL;
    TraStatus ret = TraceQueueDequeue(sessionNode->queue, &node);
    if ((ret != TRACE_SUCCESS) && (ret != TRACE_QUEUE_NULL)) {
        ADIAG_ERR("trace node dequeue failed, ret = %d.", ret);
        return NULL;
    }
    return node;
}