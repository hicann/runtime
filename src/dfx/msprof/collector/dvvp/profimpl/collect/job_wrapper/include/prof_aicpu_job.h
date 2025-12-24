/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_JOB_WRAPPER_PROF_AICPU_H
#define ANALYSIS_DVVP_JOB_WRAPPER_PROF_AICPU_H
#include <atomic>
#include "prof_comm_job.h"
#include "prof_drv_event.h"
#include "osal.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {

class ProfAicpuJob : public ProfDrvJob {
public:
    ProfAicpuJob();
    ~ProfAicpuJob() override;
    int32_t Process() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Uninit() override;

protected:
    bool CheckAicpuSwitch(void);
    bool CheckMC2Switch(void);
    bool CheckChannelSwitch(void);

protected:
    analysis::dvvp::driver::AI_DRV_CHANNEL channelId_;
    std::string eventGrpName_;
    struct TaskEventAttr eventAttr_;
    std::atomic<uint8_t> processCount_;
    ProfDrvEvent profDrvEvent_;
};

class ProfAiCustomCpuJob : public ProfAicpuJob {
public:
    ProfAiCustomCpuJob();
};

}  // namespace JobWrapper
}
}
#endif