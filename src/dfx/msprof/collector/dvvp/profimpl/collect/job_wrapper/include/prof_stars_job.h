/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_JOB_WRAPPER_PROF_STARS_JOB_H
#define ANALYSIS_DVVP_JOB_WRAPPER_PROF_STARS_JOB_H

#include "prof_comm_job.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::config;

class ProfStarsSocLogJob : public ProfDrvJob {
public:
    ProfStarsSocLogJob();
    ~ProfStarsSocLogJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Process() override;
    int32_t Uninit() override;

protected:
    analysis::dvvp::driver::AI_DRV_CHANNEL channelId_;
};

class ProfStarsBlockLogJob : public ProfDrvJob  {
public:
    ProfStarsBlockLogJob();
    ~ProfStarsBlockLogJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Process() override;
    int32_t Uninit() override;

protected:
    analysis::dvvp::driver::AI_DRV_CHANNEL channelId_;
};

class ProfFftsProfileJob : public ProfDrvJob {
public:
    ProfFftsProfileJob();
    ~ProfFftsProfileJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Process() override;
    int32_t Uninit() override;

protected:
    analysis::dvvp::driver::AI_DRV_CHANNEL channelId_;
    uint32_t cfgMode_;
    uint32_t aicMode_;
    uint32_t aivMode_;
    int32_t aicPeriod_;
    int32_t aivPeriod_;
};

class ProfStarsSocProfileJob : public ProfPeripheralJob {
public:
    ProfStarsSocProfileJob();
    ~ProfStarsSocProfileJob() override;
    int32_t SetPeripheralConfig() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
private:
    void SetConfigP(int32_t &period, StarsSocProfileConfigT *configP) const;
};
}
}
}
#endif