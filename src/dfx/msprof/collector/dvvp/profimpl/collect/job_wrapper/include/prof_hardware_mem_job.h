/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_JOB_WRAPPER_PROF_HARDWARE_MEM_H
#define ANALYSIS_DVVP_JOB_WRAPPER_PROF_HARDWARE_MEM_H
#include "prof_comm_job.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
class ProfDdrJob : public ProfPeripheralJob {
public:
    ProfDdrJob();
    ~ProfDdrJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t SetPeripheralConfig() override;
};

class ProfHbmJob : public ProfPeripheralJob {
public:
    ProfHbmJob();
    ~ProfHbmJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t SetPeripheralConfig() override;
};

class ProfAppMemJob : public ProfPeripheralJob {
public:
    ProfAppMemJob();
    ~ProfAppMemJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t SetPeripheralConfig() override;
};

class ProfDevMemJob : public ProfPeripheralJob {
public:
    ProfDevMemJob();
    ~ProfDevMemJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t SetPeripheralConfig() override;
};

class ProfAiStackMemJob : public ProfPeripheralJob {
public:
    ProfAiStackMemJob();
    ~ProfAiStackMemJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t SetPeripheralConfig() override;
};

class ProfLlcJob : public ProfPeripheralJob {
public:
    ProfLlcJob();
    ~ProfLlcJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t SetPeripheralConfig() override;
    bool IsGlobalJobLevel() override;
};

constexpr size_t MAX_QOS_STREAM_COLLECT = 8;
class ProfQosJob : public ProfPeripheralJob {
public:
    ProfQosJob();
    ~ProfQosJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t SetPeripheralConfig() override;
};
}
}
}

#endif
