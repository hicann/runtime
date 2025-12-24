/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_TASKHANDLE_TASK_RELATIONSHIP_MGR_H
#define ANALYSIS_DVVP_TASKHANDLE_TASK_RELATIONSHIP_MGR_H

#include <map>
#include <memory>
#include <set>
#include <vector>
#include "singleton/singleton.h"

namespace Analysis {
namespace Dvvp {
namespace TaskHandle {
class TaskRelationshipMgr : public analysis::dvvp::common::singleton::Singleton<TaskRelationshipMgr> {
public:
    // device id - host id
    void AddHostIdDevIdRelationship(int32_t hostId, int32_t devId);
    int32_t GetDevIdByHostId(int32_t hostId);
    int32_t GetHostIdByDevId(int32_t devId);
    void AddLocalFlushJobId(const std::string &jobId);
    int32_t GetFlushSuffixDevId(const std::string &jobId, int32_t indexId);

private:
    std::mutex hostIdMapMutex_;
    std::map<int32_t, int32_t> hostIdToDevId_;
    std::set<std::string> localFlushJobIds_;
};
}  // namespace TaskHandle
}  // namespace Dvvp
}  // namespace Analysis

#endif
