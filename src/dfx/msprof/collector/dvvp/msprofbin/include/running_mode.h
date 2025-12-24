/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef COLLECTOR_DVVP_MSPROFBIN_RUNNING_MODE_H
#define COLLECTOR_DVVP_MSPROFBIN_RUNNING_MODE_H
#include <set>
#include <vector>
#include <atomic>
#include "message/prof_params.h"
#include "utils/utils.h"
#include "msprof_task.h"

namespace Collector {
namespace Dvvp {
namespace Msprofbin {

class RunningMode {
public:
    // check params dependence in specific mode
    virtual int32_t ModeParamsCheck() = 0;
    virtual int32_t RunModeTasks() = 0;
    virtual void UpdateOutputDirInfo();
    void StopRunningTasks() const;
    void RemoveRecordFile(const std::string &fileName) const;
    SHARED_PTR_ALIA<Analysis::Dvvp::Msprof::MsprofTask> GetRunningTask(const std::string &jobId);

    // marked when unexcepted quit
    std::atomic<bool> isQuit_;
    std::string jobResultDir_;
    std::set<std::string> jobResultDirList_;
protected:
    RunningMode(std::string preCheckParams, std::string modeName,
        SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);
    virtual ~RunningMode();
    int32_t CheckForbiddenParams() const;
    int32_t CheckNeccessaryParams() const;
    void OutputUselessParams() const;
    int32_t StartAnalyzeTask();
    int32_t StartParseTask();
    int32_t StartQueryTask();
    int32_t StartExportTask();
    int32_t RunExportSummaryTask(const analysis::dvvp::common::utils::ExecCmdParams &execCmdParams,
        std::vector<std::string> &envsV, int32_t &exitCode);
    int32_t RunExportTimelineTask(const analysis::dvvp::common::utils::ExecCmdParams &execCmdParams,
        std::vector<std::string> &envsV, int32_t &exitCode);
    int32_t RunExportDbTask(const analysis::dvvp::common::utils::ExecCmdParams &execCmdParams,
        std::vector<std::string> &envsV, int32_t &exitCode);
    int32_t CheckAnalysisEnv();
    int32_t WaitRunningProcess(std::string processUsage);
    // for parse, export, query mode
    int32_t GetOutputDirInfoFromParams();
    // for app, system mode
    int32_t GetOutputDirInfoFromRecord();
    int32_t HandleProfilingParams() const;
    void StopNoWait();

    std::string modeName_;
    // In any time, at most one child task Process is running in all the mode except system
    OsalProcess taskPid_;
    std::string taskName_;
    std::string preCheckParams_;
    // forbidden params
    std::set<int32_t> blackSet_;
    // useful params
    std::set<int32_t> whiteSet_;
    std::set<int32_t> neccessarySet_;
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params_;
    std::map<std::string, SHARED_PTR_ALIA<Analysis::Dvvp::Msprof::MsprofTask>> taskMap_;
    std::vector<SHARED_PTR_ALIA<Analysis::Dvvp::Msprof::MsprofTask>> taskList_;

private:
    std::string ConvertParamsSetToString(std::set<int32_t>& srcSet) const;
    void SetEnvList(std::vector<std::string> &envsV) const;

    std::string analysisPath_;
};

class AppMode : public RunningMode {
public:
    AppMode(std::string preCheckParams, SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);
    ~AppMode() override;
    int32_t ModeParamsCheck() override;
    int32_t RunModeTasks() override;
private:
    int32_t StartAppTask(bool needWait = true);
    int32_t StartAppTaskForDynProf();
    void SetDefaultParams() const;
    void SetDefaultParamsByPlatformType() const;
};

class SystemMode : public RunningMode {
public:
    SystemMode(std::string preCheckParams, SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);
    ~SystemMode() override;
    int32_t ModeParamsCheck() override;
    int32_t RunModeTasks() override;
private:
    bool DataWillBeCollected() const;
    int32_t CheckIfDeviceOnline() const;
    int32_t CheckHostSysParams() const;
    int32_t StartSysTask();
    int32_t WaitSysTask() const;
    void StopTask();
    bool IsDeviceJob() const;
    int32_t StartDeviceJobs(const std::string& device);
    int32_t StartHostJobs();
    int32_t CreateJobDir(std::string device, std::string &resultDir) const;
    int32_t RecordOutPut() const;
    int32_t StartHostTask(const std::string resultDir, uint32_t deviceId);
    int32_t StartDeviceTask(const std::string resultDir, const std::string device);
    void SetSysDefaultParams() const;
    int32_t CreateUploader(const std::string &jobId, const std::string &resultDir) const;
    bool CreateSampleJsonFile(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params,
        const std::string &resultDir) const;
    bool CreateDoneFile(const std::string &absolutePath, const std::string &fileSize) const;
    int32_t WriteCtrlDataToFile(const std::string &absolutePath, const std::string &data, int32_t dataLen) const;
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> GenerateHostParam(
        SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> GenerateDeviceParam(
        SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;

    std::string baseDir_;
};

class ParseMode : public RunningMode {
public:
    ParseMode(std::string preCheckParams, SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);
    ~ParseMode() override;
    int32_t ModeParamsCheck() override;
    int32_t RunModeTasks() override;
    void UpdateOutputDirInfo() override;
};

class QueryMode : public RunningMode {
public:
    QueryMode(std::string preCheckParams, SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);
    ~QueryMode() override;
    int32_t ModeParamsCheck() override;
    int32_t RunModeTasks() override;
    void UpdateOutputDirInfo() override;
};

class ExportMode : public RunningMode {
public:
    ExportMode(std::string preCheckParams, SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);
    ~ExportMode() override;
    int32_t ModeParamsCheck() override;
    int32_t RunModeTasks() override;
    void UpdateOutputDirInfo() override;
};

class AnalyzeMode : public RunningMode {
public:
    AnalyzeMode(std::string preCheckParams, SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);
    ~AnalyzeMode() override;
    int32_t ModeParamsCheck() override;
    int32_t RunModeTasks() override;
    void UpdateOutputDirInfo() override;
};
}
}
}


#endif