/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_PROFILER_COMPUTE_CONFIG_ADAPTER_H
#define ANALYSIS_DVVP_PROFILER_COMPUTE_CONFIG_ADAPTER_H

#include "message/prof_params.h"
#include "prof_common.h"

namespace Analysis {
namespace Dvvp {
namespace ProfilerCommon {

class ComputeConfigAdapter {
public:
    static int32_t ToProfileParams(
        const MsprofConfig& config, SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams>& params);
};

} // namespace ProfilerCommon
} // namespace Dvvp
} // namespace Analysis

#endif
