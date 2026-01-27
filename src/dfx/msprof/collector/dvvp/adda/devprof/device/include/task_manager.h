/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_DEVICE_TASK_MGR_H
#define ANALYSIS_DVVP_DEVICE_TASK_MGR_H


#include <map>
#include <memory>
#include <mutex>
#include <string>
#include "prof_job_handler.h"
#include "singleton/singleton.h"

namespace analysis {
namespace dvvp {
namespace device {
class TaskManager : public analysis::dvvp::common::singleton::Singleton<TaskManager> {
public:
    TaskManager();
    virtual ~TaskManager();
    int32_t Init();
    int32_t Uninit();
    SHARED_PTR_ALIA<ProfJobHandler> CreateTask(int32_t hostId, const std::string &jobId,
        SHARED_PTR_ALIA<analysis::dvvp::transport::ITransport> transport);
    SHARED_PTR_ALIA<ProfJobHandler> GetTask(const std::string &jobId);
    bool DeleteTask(const std::string &jobId);
    void ClearTask();
    void ConnectionReset(SHARED_PTR_ALIA<analysis::dvvp::transport::ITransport> transport);
private:
    bool isInited_;
    std::map<std::string, SHARED_PTR_ALIA<ProfJobHandler>> taskMap_;
    std::mutex mtx_;
};
} // device
} // dvvp
} // analysis
#endif
