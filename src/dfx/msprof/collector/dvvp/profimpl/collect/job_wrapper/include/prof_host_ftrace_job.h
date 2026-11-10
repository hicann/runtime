/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_JOB_WRAPPER_PROF_HOST_FTRACE_JOB_H
#define ANALYSIS_DVVP_JOB_WRAPPER_PROF_HOST_FTRACE_JOB_H

#include <sys/types.h>

#include <string>

#include "collection_job.h"
#include "prof_host_job.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
// Host ftrace collection job.
//
// The job itself does not touch tracefs nor hold the node lock: it computes the
// lock path, spawns the standalone ftrace collector bin, and the bin itself takes
// the lock before enabling tracefs, so "lock held" == "a collector is running".
// See ftrace_design.md 4.2 for the whole flow.
class ProfHostFtraceJob : public ProfHostDataBase {
public:
    ProfHostFtraceJob() = default;
    ~ProfHostFtraceJob() override;

    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Process() override;
    int32_t Uninit() override;

private:
    int32_t CheckPreconditions() const;
    int32_t SpawnCollector();
    int32_t WaitCollector();
    int32_t StopCollector();
    std::string ResolveCollectorPath() const;
    std::string BuildNodeId() const;
    std::string BuildArgString() const;

    pid_t collectorPid_ = -1;
    bool started_ = false;
    bool stopped_ = false;
    std::string nodeId_;
    std::string outputDir_;
    std::string lockPath_;
};
} // namespace JobWrapper
} // namespace Dvvp
} // namespace Analysis
#endif
