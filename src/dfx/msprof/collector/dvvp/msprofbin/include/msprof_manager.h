/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_MSPROFBIN_MSPROF_MANAGER_H
#define ANALYSIS_DVVP_MSPROFBIN_MSPROF_MANAGER_H
#include "singleton/singleton.h"
#include "msprof_task.h"
#include "message/prof_params.h"
#include "running_mode.h"

namespace Analysis {
namespace Dvvp {
namespace Msprof {

class MsprofManager : public analysis::dvvp::common::singleton::Singleton<MsprofManager> {
public:
    MsprofManager();
    ~MsprofManager() override;
    int32_t Init(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);
    int32_t UnInit();
    void NotifyStop();
    int32_t MsProcessCmd() const;
    SHARED_PTR_ALIA<MsprofTask> GetTask(const std::string &jobId);

    SHARED_PTR_ALIA<Collector::Dvvp::Msprofbin::RunningMode> rMode_;
private:
    int32_t GenerateRunningMode();
    int32_t GenerateCollectRunningMode();
    int32_t GenerateAnalyzeRunningMode();
    // check params dependence and update metrics and events
    int32_t ParamsCheck() const;

    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params_;
};
}
}
}
#endif