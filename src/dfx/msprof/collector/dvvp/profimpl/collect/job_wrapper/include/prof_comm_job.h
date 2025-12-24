/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_JOB_WRAPPER_PROF_JOB_COMM_H
#define ANALYSIS_DVVP_JOB_WRAPPER_PROF_JOB_COMM_H

#include <string>
#include <vector>
#include "collection_register.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::common::config;


#define CHECK_JOB_EVENT_PARAM_RET(cfg, ACTION)  do {                                   \
    if ((cfg) == nullptr || (cfg)->comParams == nullptr ||                             \
        (cfg)->jobParams.events == nullptr || (cfg)->jobParams.events->size() == 0) {  \
        MSPROF_LOGI("Job check event param not pass");                                 \
        ACTION;                                                                        \
    }                                                                                  \
} while (0)

#define CHECK_JOB_CONTEXT_PARAM_RET(cfg, ACTION)  do {                                 \
    if ((cfg) == nullptr || (cfg)->comParams == nullptr ||                             \
        (cfg)->comParams->jobCtx == nullptr || (cfg)->comParams->params == nullptr) {  \
        MSPROF_LOGI("Job check context param failed");                                 \
        ACTION;                                                                        \
    }                                                                                  \
} while (0)

#define CHECK_JOB_COMMON_PARAM_RET(cfg, ACTION) do {                                   \
    if ((cfg) == nullptr || (cfg)->comParams == nullptr) {                             \
        MSPROF_LOGI("Job check comm param failed");                                    \
        ACTION;                                                                        \
    }                                                                                  \
} while (0)

#define CHECK_JOB_CONFIG_UNSIGNED_SIZE_RET(size, ACTION) do {                          \
    if ((size) == 0 || (size) > 0x7FFFFFFF) {                                          \
        MSPROF_LOGE("Profiling Config Size Out Range");                                \
        ACTION;                                                                        \
    }                                                                                  \
} while (0)

constexpr int32_t DEFAULT_PERIOD_TIME = 10;

class ProfDrvJob : public ICollectionJob {
public:
    ProfDrvJob();
    ~ProfDrvJob() override;

protected:
    void AddReader(const std::string &key, int32_t devId, analysis::dvvp::driver::AI_DRV_CHANNEL channelId,
        const std::string &filePath);
    void RemoveReader(const std::string &key, int32_t devId, analysis::dvvp::driver::AI_DRV_CHANNEL channelId) const;
    std::string GetEventsStr(const std::vector<std::string> &events, const std::string &separator = ",") const;
    uint32_t GetEventSize(const std::vector<std::string> &events) const;
    std::string BindFileWithChannel(const std::string &fileName) const;
    std::string GenerateFileName(const std::string &fileName, int32_t devId) const;

protected:
    SHARED_PTR_ALIA<CollectionJobCfg> collectionJobCfg_;
};

class ProfPeripheralJob : public ProfDrvJob {
public:
    ProfPeripheralJob();
    ~ProfPeripheralJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    virtual int32_t SetPeripheralConfig();
    int32_t Process() override;
    int32_t Uninit() override;

protected:
    uint32_t samplePeriod_;
    analysis::dvvp::driver::AI_DRV_CHANNEL channelId_;
    analysis::dvvp::driver::DrvPeripheralProfileCfg peripheralCfg_;
    std::string eventsStr_;
};
}
}
}
#endif