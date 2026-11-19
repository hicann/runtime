/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_PROFILER_COMPUTE_PROFILING_MANAGER_H
#define ANALYSIS_DVVP_PROFILER_COMPUTE_PROFILING_MANAGER_H

#include <mutex>
#include <string>
#include <map>
#include <vector>
#include "common/singleton/singleton.h"
#include "compute_config_adapter.h"
#include "message/prof_params.h"
#include "prof_common.h"
#include "transport/injection_transport.h"

namespace Analysis {
namespace Dvvp {
namespace ProfilerCommon {

class ComputeProfilingManager : public analysis::dvvp::common::singleton::Singleton<ComputeProfilingManager> {
public:
    ComputeProfilingManager();
    ~ComputeProfilingManager() override;

    int32_t RegisterDataCallback(uint32_t type, void* callback);
    MsprofRawDataCallback GetComputeRawDataCallback();
    int32_t Start(const void* data, uint32_t length);
    int32_t Stop(const void* data, uint32_t length);

private:
    struct ComputeStatus {
        SHARED_PTR_ALIA<analysis::dvvp::transport::InjectionTransport> transport;
    };

    int32_t InitRuntime();
    int32_t CreateComputeUploader(uint32_t devId, ComputeStatus& status);
    int32_t CloneBaselineParams(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams>& params) const;
    void RegisterComputeUploaderMap(uint32_t devId, const std::string& jobId) const;
    int32_t StartComputeJob(uint32_t devId, bool ifInitHost);
    int32_t StopComputeJob(uint32_t devId);
    void RollbackComputeStatus(uint32_t devId);
    void RollbackComputeRuntime(uint32_t devId, bool rollbackHost);
    void FlushComputeUploader(uint32_t devId, uint32_t timeoutSec) const;
    void WaitStatusCallbackDone(uint32_t devId, uint32_t timeoutSec) const;
    void PrintCallbackFailedStatistics(uint32_t devId) const;
    int32_t ReleaseComputeHostContext();
    void ClearContext();
    bool CheckConfigConsistency(const MsprofConfig& config);
    bool IsSameComputeConfig(const MsprofConfig& config) const;
    void SaveBaselineConfig(const MsprofConfig& config);

private:
    std::mutex mutex_;
    MsprofRawDataCallback computeCallback_;
    MsprofConfig baselineConfig_ = {};
    std::vector<MsprofConfigAttr> baselineAttrs_;
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> baselineParams_;
    SHARED_PTR_ALIA<analysis::dvvp::transport::InjectionTransport> hostTransport_;
    std::map<uint32_t, ComputeStatus> statuses_;
};

} // namespace ProfilerCommon
} // namespace Dvvp
} // namespace Analysis

#endif
