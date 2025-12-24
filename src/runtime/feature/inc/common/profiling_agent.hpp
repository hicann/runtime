/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_PROFILING_AGENT_HPP
#define CCE_RUNTIME_PROFILING_AGENT_HPP

#include "runtime/base.h"
#include "base.hpp"
#include "profiler_struct.hpp"
#include "toolchain/prof_api.h"

namespace cce {
namespace runtime {
/**
 * @brief used for profiling agent
 */
class ProfilingAgent {
public:
    static ProfilingAgent &Instance();

    void SetMsprofReporterCallback(MsprofReporterCallback const callback);

    rtError_t Init() const;

    rtError_t UnInit() const;

    void ReportProfApi(const uint32_t devId, RuntimeProfApiData &profApiData) const;

    MsprofReporterCallback GetMsprofReporterCallback() const;

private:

    ProfilingAgent() = default;

    ~ProfilingAgent() = default;

    ProfilingAgent(const ProfilingAgent &other) = delete;

    ProfilingAgent &operator=(const ProfilingAgent &other) = delete;

    ProfilingAgent(ProfilingAgent &&other) = delete;

    ProfilingAgent &operator=(ProfilingAgent &&other) = delete;

    rtError_t RegisterProfTypeInfo() const;

private:
    MsprofReporterCallback profReporterCallback_;
};
RuntimeProfApiData &ProfilerGetProfApiData(void);
TaskTrackInfo &ProfilerGetProfTaskTrackData(void);
}
}

#endif // CCE_RUNTIME_PROFILING_AGENT_HPP
