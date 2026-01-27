/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "task_queue.h"

namespace DataPreprocess {

DataPreprocess::TaskQueueMgr::TaskQueueMgr()
{
    for (int32_t i = TASK_QUEUE_LOW_PRIORITY; i < TASK_QUEUE_MAX_PRIORITY; ++i) {
        preprocessEventfds_[i] = -1; // initialize fd
    }
}
DataPreprocess::TaskQueueMgr::~TaskQueueMgr() {}

TaskQueueMgr &DataPreprocess::TaskQueueMgr::GetInstance()
{
    static TaskQueueMgr instance;
    return instance;
}

void DataPreprocess::TaskQueueMgr::OnPreprocessEvent(uint32_t eventId)
{
    return;
}

} // namespace DataPreprocess