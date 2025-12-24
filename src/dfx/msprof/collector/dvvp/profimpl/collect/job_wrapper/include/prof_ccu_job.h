/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_JOB_WRAPPER_PROF_CCU_JOB_H
#define ANALYSIS_DVVP_JOB_WRAPPER_PROF_CCU_JOB_H

#include "prof_comm_job.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::driver;

class ProfCcuBaseJob : public ProfDrvJob {
public:
    ProfCcuBaseJob(AI_DRV_CHANNEL channelIdCcu0, AI_DRV_CHANNEL channelIdCcu1);
    ~ProfCcuBaseJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Process() override;
    int32_t Uninit() override;

protected:
    int32_t StartCcuChannel(const std::string &jobId, int32_t deviceId, AI_DRV_CHANNEL channelId,
        const std::string &filePath);
    int32_t StopCcuChannel(const std::string &jobId, int32_t deviceId, AI_DRV_CHANNEL channelId) const;

protected:
    AI_DRV_CHANNEL channelIdCcu0_;
    AI_DRV_CHANNEL channelIdCcu1_;
};

class ProfCcuInstrJob : public ProfCcuBaseJob {
public:
    ProfCcuInstrJob();
    ~ProfCcuInstrJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Process() override;
    int32_t Uninit() override;
};

class ProfCcuStatJob : public ProfCcuBaseJob {
public:
    ProfCcuStatJob();
    ~ProfCcuStatJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Process() override;
    int32_t Uninit() override;
};

}
}
}
#endif