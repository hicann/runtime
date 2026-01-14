/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_MANAGER_H
#define QUEUE_MANAGER_H

#include <mutex>
#include <memory>
#include <map>
#include "acl_rt_impl.h"
#include "queue_process.h"
#include "queue.h"

namespace acl {
using QueueProcessorPtr = std::unique_ptr<QueueProcessor>;

enum RunEnv : int32_t {
    ACL_ACL_ENV_UNKNOWN = -1,
    ACL_ENV_HOST = 0,
    ACL_ENV_DEVICE_CCPU = 1,
    ACL_ENV_DEVICE_SP = 2,
};

class QueueManager {
public:
    /**
     * Get queue manager instance
     * @return QueueManager reference
     */
    static QueueManager& GetInstance();

    /**
     * Get queue processor
     * @return queueProcessorPtr queue processor pointer
     */
    QueueProcessor *GetQueueProcessor();

    static aclError GetRunningEnv(RunEnv &runningEnv);

    QueueManager() = default;

    ~QueueManager() = default;

    // not allow copy constructor and assignment operators
    QueueManager(const QueueManager &) = delete;

    QueueManager &operator=(const QueueManager &) = delete;

    QueueManager(QueueManager &&) = delete;

    QueueManager &&operator=(QueueManager &&) = delete;

private:
    // queue processor
    QueueProcessorPtr queueProcessProc_ = nullptr;
    RunEnv env_ = ACL_ACL_ENV_UNKNOWN;
    std::mutex muCreateProcessProc_;
};

}

#endif // QUEUE_MANAGER_H
