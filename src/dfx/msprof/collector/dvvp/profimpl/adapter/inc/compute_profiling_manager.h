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
#include <vector>
#include "common/singleton/singleton.h"
#include "message/prof_params.h"
#include "prof_common.h"
#include "transport/injection_transport.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
class JobAdapter;
}
namespace ProfilerCommon {

struct ComputeProfileConfig {
    uint32_t devId = 0;
    uint64_t profSwitch = 0;
    std::string dumpPath;
    std::vector<uint32_t> aicoreMetrics;
    bool enableLog = false;
    bool enablePmu = false;
    bool enableInstr = false;
    bool enableBiuPerf = false;
    bool enablePcSampling = false;
    bool enableBlock = false;
    uint32_t blockMode = 0;
};

class ComputeProfilingManager : public analysis::dvvp::common::singleton::Singleton<ComputeProfilingManager> {
public:
    ComputeProfilingManager();
    ~ComputeProfilingManager() override;

    int32_t RegisterDataCallback(uint32_t type, void* callback);
    MsprofRawDataCallback GetComputeRawDataCallback();
    int32_t Start(const void* data, uint32_t length);
    int32_t Stop(const void* data, uint32_t length);

private:
    int32_t ParseConfig(const MsprofConfig& config, ComputeProfileConfig& outConfig) const;
    int32_t ParseConfigAttrs(const MsprofConfigInfo& configInfo, ComputeProfileConfig& outConfig) const;
    int32_t ParseInstrMode(uint32_t instrMode, ComputeProfileConfig& outConfig) const;
    int32_t ParseBlockMode(uint32_t blockMode, ComputeProfileConfig& outConfig) const;
    int32_t InitRuntime();
    int32_t CreateComputeUploader(const std::string& devIdStr);
    void RegisterComputeUploaderMap(uint32_t devId, const std::string& jobId) const;
    int32_t CreateComputeJobAdapter(uint32_t devId);
    int32_t StartComputeJob(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params, uint32_t devId);
    int32_t StopComputeJob();
    int32_t StartComputeJobAndCallback(
        SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params, const ComputeProfileConfig& config);
    int32_t StartComponentCallback(uint32_t devId, uint64_t profSwitch) const;
    int32_t StopComponentCallback() const;
    void RollbackComputeUploader(const std::string& devIdStr);
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> BuildProfileParams(
        const ComputeProfileConfig& config, const std::string& devIdStr) const;
    std::string BuildMetricEvents(const std::vector<uint32_t>& metrics) const;
    void FlushComputeUploader(uint32_t timeoutSec) const;
    void PrintCallbackFailedStatistics() const;
    void ClearContext();

private:
    std::mutex mutex_;
    MsprofRawDataCallback computeCallback_;
    bool running_;
    std::string runningDevId_;
    uint64_t runningProfSwitch_;
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> runningParams_;
    SHARED_PTR_ALIA<Analysis::Dvvp::JobWrapper::JobAdapter> jobAdapter_;
    SHARED_PTR_ALIA<analysis::dvvp::transport::InjectionTransport> injectionTransport_;
};

} // namespace ProfilerCommon
} // namespace Dvvp
} // namespace Analysis

#endif
