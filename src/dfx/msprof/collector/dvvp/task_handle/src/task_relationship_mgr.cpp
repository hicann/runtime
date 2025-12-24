/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "task_relationship_mgr.h"
#include <string>
#include "msprof_dlog.h"


namespace Analysis {
namespace Dvvp {
namespace TaskHandle {
void TaskRelationshipMgr::AddHostIdDevIdRelationship(int32_t hostId, int32_t devId)
{
    MSPROF_LOGI("hostId: %d, devId: %d Entering HostId DeviceId Map...", hostId, devId);
    std::lock_guard<std::mutex> lock(hostIdMapMutex_);
    hostIdToDevId_[hostId] = devId;
}

int32_t TaskRelationshipMgr::GetDevIdByHostId(int32_t hostId)
{
    std::lock_guard<std::mutex> lock(hostIdMapMutex_);
    const auto iter = hostIdToDevId_.find(hostId);
    if (iter != hostIdToDevId_.end()) {
        return iter->second;
    }
    return hostId;
}

int32_t TaskRelationshipMgr::GetHostIdByDevId(int32_t devId)
{
    std::lock_guard<std::mutex> lock(hostIdMapMutex_);
    for (auto iter = hostIdToDevId_.begin(); iter != hostIdToDevId_.end(); iter++) {
        if (iter->second == devId) {
            return iter->first;
        }
    }
    return devId;
}

void TaskRelationshipMgr::AddLocalFlushJobId(const std::string &jobId)
{
    MSPROF_LOGI("Job %s should flush locally", jobId.c_str());
    (void)localFlushJobIds_.insert(jobId);
}

int32_t TaskRelationshipMgr::GetFlushSuffixDevId(const std::string &jobId, int32_t indexId)
{
    if (localFlushJobIds_.find(jobId) != localFlushJobIds_.end()) {
        return indexId;
    } else {
        return GetHostIdByDevId(indexId);
    }
}
}  // namespace TaskHandle
}  // namespace Dvvp
}  // namespace Analysis
