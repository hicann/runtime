/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_PROCESS_HOST_H
#define QUEUE_PROCESS_HOST_H

#include <map>
#include <string>
#include "queue_process.h"

namespace acl {
class QueueProcessorHost : public QueueProcessor {
public:
    aclError acltdtCreateQueue(const acltdtQueueAttr *const attr, uint32_t *const qid) override;

    aclError acltdtDestroyQueue(const uint32_t qid) override;

    aclError acltdtBindQueueRoutes(acltdtQueueRouteList *const qRouteList) override;

    aclError acltdtUnbindQueueRoutes(acltdtQueueRouteList *const qRouteList) override;

    aclError acltdtQueryQueueRoutes(const acltdtQueueRouteQueryInfo *const queryInfo,
                                    acltdtQueueRouteList *const qRouteList) override;

    aclError acltdtEnqueue(const uint32_t qid, const acltdtBuf buf, const int32_t timeout) override;

    aclError acltdtDequeue(const uint32_t qid, acltdtBuf *const buf, const int32_t timeout) override;

    aclError acltdtAllocBuf(const size_t size, const uint32_t type, acltdtBuf *const buf) override;

    aclError acltdtFreeBuf(acltdtBuf buf) override;

    aclError acltdtSetBufDataLen(const acltdtBuf buf, const size_t len) override;

    aclError acltdtGetBufDataLen(const acltdtBuf buf, size_t *const len) override;

    aclError acltdtAppendBufChain(const acltdtBuf headBuf, const acltdtBuf buf) override;

    aclError acltdtGetBufChainNum(const acltdtBuf headBuf, uint32_t *const num) override;

    aclError acltdtGetBufFromChain(const acltdtBuf headBuf, const uint32_t index, acltdtBuf *const buf) override;

    aclError acltdtGetBufData(const acltdtBuf buf, void **const dataPtr, size_t *const size) override;

    aclError acltdtGetBufUserData(const acltdtBuf buf, void *dataPtr,
                                  const size_t size, const size_t offset) override;

    aclError acltdtSetBufUserData(acltdtBuf buf, const void *dataPtr,
                                  const size_t size, const size_t offset) override;

    aclError acltdtCopyBufRef(const acltdtBuf buf, acltdtBuf *const newBuf) override;

    aclError SendBindUnbindMsg(const int32_t deviceId, acltdtQueueRouteList *const qRouteList,
        const bool isBind, rtEschedEventSummary_t &eventSum, rtEschedEventReply_t &ack) const;

    aclError QueryQueueRoutes(const int32_t deviceId, const acltdtQueueRouteQueryInfo *const queryInfo,
        const size_t routeNum, rtEschedEventSummary_t &eventSum,
        rtEschedEventReply_t &ack, acltdtQueueRouteList *const qRouteList) const;

    QueueProcessorHost() = default;
    ~QueueProcessorHost() override = default;

    // not allow copy constructor and assignment operators
    QueueProcessorHost(const QueueProcessorHost &) = delete;

    QueueProcessorHost &operator=(const QueueProcessorHost &) = delete;

    QueueProcessorHost(QueueProcessorHost &&) = delete;

    QueueProcessorHost &&operator=(QueueProcessorHost &&) = delete;
};
}

#endif // QUEUE_PROCESS_HOST_H
