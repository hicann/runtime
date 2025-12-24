/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_PROCESS_CCPU_H
#define QUEUE_PROCESS_CCPU_H

#include <map>
#include <string>
#include "queue_process.h"

namespace acl {
class QueueProcessorCcpu : public QueueProcessor {
public:
    aclError acltdtCreateQueue(const acltdtQueueAttr *const attr, uint32_t *const qid) override;

    aclError acltdtDestroyQueue(const uint32_t qid) override;

    aclError acltdtBindQueueRoutes(acltdtQueueRouteList *const qRouteList) override;

    aclError acltdtUnbindQueueRoutes(acltdtQueueRouteList *const qRouteList) override;

    aclError acltdtQueryQueueRoutes(const acltdtQueueRouteQueryInfo *const queryInfo,
                                    acltdtQueueRouteList *const qRouteList) override;

    aclError acltdtAllocBuf(const size_t size, const uint32_t type, acltdtBuf *const buf) override;

    aclError acltdtCreateGroup();

    aclError QueryGroup(const int32_t pid, size_t &grpNum, std::string &grpName) const;

    aclError MbufInit() const;

    QueueProcessorCcpu() = default;
    ~QueueProcessorCcpu() override = default;

    // not allow copy constructor and assignment operators
    QueueProcessorCcpu(const QueueProcessorCcpu &) = delete;

    QueueProcessorCcpu &operator=(const QueueProcessorCcpu &) = delete;

    QueueProcessorCcpu(QueueProcessorCcpu &&) = delete;

    QueueProcessorCcpu &&operator=(QueueProcessorCcpu &&) = delete;
};
}

#endif // QUEUE_PROCESS_CCPU_H
