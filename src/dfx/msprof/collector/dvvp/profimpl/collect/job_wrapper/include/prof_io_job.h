/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_JOB_WRAPPER_PROF_IO_H
#define ANALYSIS_DVVP_JOB_WRAPPER_PROF_IO_H
#include "prof_comm_job.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
class ProfNicJob : public ProfPeripheralJob {
public:
    ProfNicJob();
    ~ProfNicJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
};

class ProfRoceJob : public ProfPeripheralJob {
public:
    ProfRoceJob();
    ~ProfRoceJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
};
}
}
}

#endif