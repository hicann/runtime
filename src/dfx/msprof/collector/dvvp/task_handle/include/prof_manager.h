/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_HOST_PROF_MANAGER_H
#define ANALYSIS_DVVP_HOST_PROF_MANAGER_H

#include <map>
#include "message/prof_params.h"
#include "prof_task.h"
#include "singleton/singleton.h"
#include "transport/prof_channel.h"
#include "app/application.h"
#include "utils/utils.h"

namespace analysis {
namespace dvvp {
namespace host {
class ProfManager : public analysis::dvvp::common::singleton::Singleton<ProfManager> {
    friend analysis::dvvp::common::singleton::Singleton<ProfManager>;

public:
    int32_t AclInit();
    int32_t AclUinit();

    int32_t Handle(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);

public:
    SHARED_PTR_ALIA<ProfTask> GetTask(const std::string &jobId);
    int32_t StopTask(const std::string &jobId);
    int32_t OnTaskFinished(const std::string &jobId);
    int32_t WriteCtrlDataToFile(const std::string &absolutePath, const std::string &data, int32_t dataLen) const;
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> HandleProfilingParams(uint32_t deviceId,
        const std::string &sampleConfig) const;
    int32_t IdeCloudProfileProcess(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);
    bool CheckIfDevicesOnline(const std::string paramsDevices, std::string &statusInfo) const;

protected:
    ProfManager() : isInited_(false)
    {
    }
    ~ProfManager() override
    {
    }

private:
    std::string GetParamJsonStr(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;
    bool CreateSampleJsonFile(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params,
                              const std::string &resultDir) const;
    bool CheckHandleSuc(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params,
                        analysis::dvvp::message::StatusInfo &statusInfo);
    int32_t ProcessHandleFailed(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;

private:
    int32_t LaunchTask(SHARED_PTR_ALIA<ProfTask> task, const std::string &jobId, std::string &info);
    SHARED_PTR_ALIA<ProfTask> GetTaskNoLock(const std::string &jobId);
    bool IsDeviceProfiling(const std::vector<std::string> &devices);
    bool CreateDoneFile(const std::string &absolutePath, const std::string &fileSize) const;
    bool PreGetDeviceList(std::vector<int32_t> &devIds) const;

private:
    bool isInited_;
    std::mutex taskMtx_;
    std::map<std::string, SHARED_PTR_ALIA<ProfTask> > _tasks;  // taskptr, task
};
}  // namespace host
}  // namespace dvvp
}  // namespace analysis

#endif
