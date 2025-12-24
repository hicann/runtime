/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_JOB_WRAPPER_PROF_BIU_PERF_JOB_H
#define ANALYSIS_DVVP_JOB_WRAPPER_PROF_BIU_PERF_JOB_H

#include "prof_comm_job.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::config;

class ProfBiuPerfJob : public ProfDrvJob {
public:
    ProfBiuPerfJob();
    ~ProfBiuPerfJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Process() override;
    int32_t Uninit() override;

private:
    uint32_t GenGroupVector(int64_t aiCoreNum);

private:
    uint32_t groupNum_;
    uint32_t biuPcSamplingMode_;
    // Determined by the DRV and corresponding to the aicore quantity configuration
    std::vector<uint32_t> groupVector_;
    std::string profBiuPerfJobName_;
    AI_DRV_CHANNEL groupChannelIdMap_[BIU_PERF_HIGHER_GROUP_NUM][INSTR_PROFILING_GROUP_CHANNEL_NUM] = {
        {PROF_CHANNEL_BIU_GROUP0_AIC, PROF_CHANNEL_BIU_GROUP0_AIV0, PROF_CHANNEL_BIU_GROUP0_AIV1},
        {PROF_CHANNEL_BIU_GROUP1_AIC, PROF_CHANNEL_BIU_GROUP1_AIV0, PROF_CHANNEL_BIU_GROUP1_AIV1},
        {PROF_CHANNEL_BIU_GROUP2_AIC, PROF_CHANNEL_BIU_GROUP2_AIV0, PROF_CHANNEL_BIU_GROUP2_AIV1},
        {PROF_CHANNEL_BIU_GROUP3_AIC, PROF_CHANNEL_BIU_GROUP3_AIV0, PROF_CHANNEL_BIU_GROUP3_AIV1},
        {PROF_CHANNEL_BIU_GROUP4_AIC, PROF_CHANNEL_BIU_GROUP4_AIV0, PROF_CHANNEL_BIU_GROUP4_AIV1},
        {PROF_CHANNEL_BIU_GROUP5_AIC, PROF_CHANNEL_BIU_GROUP5_AIV0, PROF_CHANNEL_BIU_GROUP5_AIV1},
    };
};

}
}
}
#endif