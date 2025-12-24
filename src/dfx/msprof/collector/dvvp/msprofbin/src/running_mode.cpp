/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "running_mode.h"
#include <chrono>
#include "errno/error_code.h"
#include "input_parser.h"
#include "cmd_log/cmd_log.h"
#include "msprof_dlog.h"
#include "ai_drv_dev_api.h"
#include "msprof_params_adapter.h"
#include "config_manager.h"
#include "application.h"
#include "transport/file_transport.h"
#include "transport/uploader_mgr.h"
#include "task_relationship_mgr.h"
#include "osal.h"
#include "platform/platform.h"
#include "env_manager.h"
#include "dyn_prof_client.h"

namespace Collector {
namespace Dvvp {
namespace Msprofbin {
using namespace analysis::dvvp::message;
using namespace analysis::dvvp::common::cmdlog;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::driver;
using namespace Analysis::Dvvp::Msprof;
using namespace Analysis::Dvvp::Common::Config;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::common::utils;
using namespace Collector::Dvvp::DynProf;

RunningMode::RunningMode(std::string preCheckParams, std::string modeName, SHARED_PTR_ALIA<ProfileParams> params)
    : isQuit_(false),
      modeName_(modeName),
      taskPid_(MSVP_PROCESS),
      preCheckParams_(preCheckParams),
      blackSet_(),
      whiteSet_(),
      neccessarySet_(),
      params_(params),
      taskMap_()
{
}

RunningMode::~RunningMode() {}

std::string RunningMode::ConvertParamsSetToString(std::set<int32_t> &srcSet) const
{
    std::string result;
    if (srcSet.empty()) {
        return result;
    }
    std::stringstream ssParams;
    for (int32_t paramId : srcSet) {
        ssParams << "--" << LONG_OPTIONS[paramId].name << " ";
    }
    result = ssParams.str();
    Utils::RemoveEndCharacter(result, ' ');
    return result;
}

int32_t RunningMode::CheckForbiddenParams() const
{
    if (params_ == nullptr || params_->usedParams.empty()) {
        return PROFILING_FAILED;
    }
    std::set<int32_t> usedForbiddenParams;
    set_intersection(params_->usedParams.begin(), params_->usedParams.end(), blackSet_.begin(), blackSet_.end(),
                     inserter(usedForbiddenParams, usedForbiddenParams.begin()));
    if (!usedForbiddenParams.empty()) {
        std::string forbiddenParamsStr = ConvertParamsSetToString(usedForbiddenParams);
        CmdLog::CmdErrorLog("The argument %s is forbidden when --%s is not empty", forbiddenParamsStr.c_str(),
                            preCheckParams_.c_str());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t RunningMode::CheckNeccessaryParams() const
{
    if (params_ == nullptr || params_->usedParams.empty()) {
        return PROFILING_FAILED;
    }
    std::set<int32_t> moreReqParams;
    set_difference(neccessarySet_.begin(), neccessarySet_.end(), params_->usedParams.begin(), params_->usedParams.end(),
                   inserter(moreReqParams, moreReqParams.begin()));
    if (!moreReqParams.empty()) {
        std::string reqParams = ConvertParamsSetToString(moreReqParams);
        CmdLog::CmdErrorLog("The argument %s is neccessary when --%s is not empty", reqParams.c_str(),
                            preCheckParams_.c_str());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

void RunningMode::OutputUselessParams() const
{
    if (params_ == nullptr || params_->usedParams.empty()) {
        return;
    }
    std::set<int32_t> uselessParams;
    set_difference(params_->usedParams.begin(), params_->usedParams.end(), whiteSet_.begin(), whiteSet_.end(),
                   inserter(uselessParams, uselessParams.begin()));
    if (!uselessParams.empty()) {
        std::string noEffectParams = ConvertParamsSetToString(uselessParams);
        CmdLog::CmdWarningLog("The argument %s is useless when --%s is not empty", noEffectParams.c_str(),
                              preCheckParams_.c_str());
    }
}

void RunningMode::UpdateOutputDirInfo()
{
    int32_t ret = GetOutputDirInfoFromRecord();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGW("Unable to get output info from RunningMode.");
    }
}

int32_t RunningMode::GetOutputDirInfoFromParams()
{
    if (!jobResultDir_.empty()) {
        MSPROF_LOGW("Unable to get output info from params, exist output info before.");
        return PROFILING_FAILED;
    }
    jobResultDir_ = params_->result_dir;
    return PROFILING_SUCCESS;
}

int32_t RunningMode::GetOutputDirInfoFromRecord()
{
    if (!jobResultDir_.empty()) {
        MSPROF_LOGW("Unable to get output info from record, exist output info before.");
        return PROFILING_FAILED;
    }
    std::string baseDir;
    std::ifstream fin;
    std::string resultDirTmp = params_->result_dir;
    Utils::EnsureEndsInSlash(resultDirTmp);
    std::string pidStr = std::to_string(Utils::GetPid());
    std::string recordFile = pidStr + MSVP_UNDERLINE + OUTPUT_RECORD;
    std::string outPut = resultDirTmp + recordFile;
    int64_t fileSize = Utils::GetFileSize(outPut);
    if (fileSize > MSVP_SMALL_FILE_MAX_LEN || fileSize <= 0) {
        MSPROF_LOGW("File size is invalid. fileName:%s, size:%lld bytes.", recordFile.c_str(), fileSize);
        return PROFILING_FAILED;
    }
    outPut = Utils::CanonicalizePath(outPut);
    FUNRET_CHECK_EXPR_ACTION(outPut.empty(), return PROFILING_FAILED,
                             "The output path: %s does not exist or permission denied.", outPut.c_str());
    fin.open(outPut, std::ifstream::in);
    if (fin.is_open()) {
        while (getline(fin, baseDir)) {
            jobResultDirList_.insert(resultDirTmp + baseDir);
        }
        fin.close();
        RemoveRecordFile(outPut);
        return PROFILING_SUCCESS;
    } else {
        char errBuf[MAX_ERR_STRING_LEN + 1] = { 0 };
        MSPROF_LOGE("Open file failed, fileName:%s, error: %s", Utils::BaseName(recordFile).c_str(),
                    OsalGetErrorFormatMessage(OsalGetErrorCode(), errBuf, MAX_ERR_STRING_LEN));
        return PROFILING_FAILED;
    }
}

void RunningMode::RemoveRecordFile(const std::string &fileName) const
{
    if (!(Utils::IsFileExist(fileName))) {
        return;
    }
    if (remove(fileName.c_str()) != EOK) {
        MSPROF_LOGE("Remove file: %s failed!", Utils::BaseName(fileName).c_str());
        return;
    }
    return;
}

void RunningMode::StopRunningTasks() const
{
    if (taskPid_ == MSVP_PROCESS) {
        return;
    }
    static const std::string ENV_PATH = "PATH=/usr/bin/:/usr/sbin:/var:/bin";
    std::vector<std::string> envsV;
    envsV.push_back(ENV_PATH);
    std::string cmd = "kill";
    ExecCmdParams execCmdParams(cmd, true, "");
    std::vector<std::string> argsV;
    argsV.push_back(std::to_string(static_cast<int32_t>(taskPid_)));
    int32_t exitCode = INVALID_EXIT_CODE;
    OsalProcess killProces = MSVP_PROCESS;
    int32_t ret = analysis::dvvp::common::utils::Utils::ExecCmd(execCmdParams, argsV, envsV, exitCode, killProces);
    MSPROF_LOGI("[%s mode] Stop %s Process:%d, ret=%d", modeName_.c_str(), taskName_.c_str(),
                static_cast<int32_t>(taskPid_), ret);
}

void RunningMode::SetEnvList(std::vector<std::string> &envsV) const
{
    envsV = Analysis::Dvvp::App::EnvManager::instance()->GetGlobalEnv();
}

int32_t RunningMode::StartAnalyzeTask()
{
    if (isQuit_) {
        MSPROF_LOGE("Start analyze task error, msprofbin has quited.");
        return PROFILING_FAILED;
    }

    if (taskPid_ != MSVP_PROCESS) {
        MSPROF_LOGE("Start analyze task error, process %d is running,"
                    "only one child process can run at the same time.",
                    static_cast<int32_t>(taskPid_));
        return PROFILING_FAILED;
    }

    if (jobResultDir_.empty() || analysisPath_.empty()) {
        MSPROF_LOGE("Start analyze task error, get output dir and msprof.py script failed.");
        return PROFILING_FAILED;
    }

    CmdLog::CmdInfoLog("Start analyze data in %s.", Utils::BaseName(jobResultDir_).c_str());
    taskName_ = "Analyze";
    std::string cmd = params_->pythonPath;
    ExecCmdParams execCmdParams(cmd, true, "");
    std::vector<std::string> envsV;
    int32_t exitCode = INVALID_EXIT_CODE;
    SetEnvList(envsV);
    std::vector<std::string> argsV = { analysisPath_, "analyze", "-dir=" + jobResultDir_,
                                       "-r=" + params_->analyzeRuleSwitch };
    if (params_->clearSwitch == "on") {
        argsV.push_back("--clear");
    }
    if (params_->exportType == "db") {
        argsV.push_back("--type=db");
    }

    int32_t ret = Utils::ExecCmd(execCmdParams, argsV, envsV, exitCode, taskPid_);
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("Failed to launch analyze task, data path: %s", Utils::BaseName(jobResultDir_).c_str());
        return PROFILING_FAILED;
    }

    ret = WaitRunningProcess(taskName_);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to wait analyze process %d to exit, ret=%d", static_cast<int32_t>(taskPid_), ret);
        return PROFILING_FAILED;
    }

    taskPid_ = MSVP_PROCESS;
    exitCode = INVALID_EXIT_CODE;
    CmdLog::CmdInfoLog("Analyze all data in %s done.", Utils::BaseName(jobResultDir_).c_str());
    return PROFILING_SUCCESS;
}

int32_t RunningMode::StartParseTask()
{
    if (isQuit_) {
        MSPROF_LOGE("Start parse task error, msprofbin has quited");
        return PROFILING_FAILED;
    }
    if (taskPid_ != MSVP_PROCESS) {
        MSPROF_LOGE("Start parse task error, process %d is running,"
                    "only one child process can run at the same time.",
                    static_cast<int32_t>(taskPid_));
        return PROFILING_FAILED;
    }
    if (jobResultDir_.empty() || analysisPath_.empty()) {
        MSPROF_LOGE("Start parse task error, get output dir and msprof.py script failed.");
        return PROFILING_FAILED;
    }
    CmdLog::CmdInfoLog("Start parse data in %s.", Utils::BaseName(jobResultDir_).c_str());
    taskName_ = "Parse";

    std::string cmd = params_->pythonPath;
    ExecCmdParams execCmdParams(cmd, true, "");
    std::vector<std::string> envsV;
    int32_t exitCode = INVALID_EXIT_CODE;
    SetEnvList(envsV);
    std::vector<std::string> argsV = { analysisPath_, "import", "-dir=" + jobResultDir_ };
    int32_t ret = analysis::dvvp::common::utils::Utils::ExecCmd(execCmdParams, argsV, envsV, exitCode, taskPid_);
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("Failed to launch parse task, data path: %s", Utils::BaseName(jobResultDir_).c_str());
        return PROFILING_FAILED;
    }
    ret = WaitRunningProcess(taskName_);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to wait parse process %d to exit, ret=%d", static_cast<int32_t>(taskPid_), ret);
        return PROFILING_FAILED;
    }
    taskPid_ = MSVP_PROCESS;
    exitCode = INVALID_EXIT_CODE;
    CmdLog::CmdInfoLog("Parse all data in %s done.", Utils::BaseName(jobResultDir_).c_str());
    return PROFILING_SUCCESS;
}

int32_t RunningMode::StartQueryTask()
{
    if (isQuit_) {
        MSPROF_LOGE("Start query task error, msprofbin has quited");
        return PROFILING_FAILED;
    }
    if (taskPid_ != MSVP_PROCESS) {
        MSPROF_LOGE("Start query task error, process %d is running,"
                    "only one child process can run at the same time.",
                    static_cast<int32_t>(taskPid_));
        return PROFILING_FAILED;
    }
    if (jobResultDir_.empty() || analysisPath_.empty()) {
        MSPROF_LOGE("Start query task error, get output dir and msprof.py script failed.");
        return PROFILING_FAILED;
    }
    CmdLog::CmdInfoLog("Start query data in %s.", Utils::BaseName(jobResultDir_).c_str());
    taskName_ = "Query";

    std::string cmd = params_->pythonPath;
    ExecCmdParams execCmdParams(cmd, true, "");
    std::vector<std::string> envsV;
    int32_t exitCode = INVALID_EXIT_CODE;
    SetEnvList(envsV);
    std::vector<std::string> argsV = { analysisPath_, "query", "-dir=" + jobResultDir_ };
    int32_t ret = analysis::dvvp::common::utils::Utils::ExecCmd(execCmdParams, argsV, envsV, exitCode, taskPid_);
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("Failed to launch query task, data path: %s", Utils::BaseName(jobResultDir_).c_str());
        return PROFILING_FAILED;
    }
    ret = WaitRunningProcess(taskName_);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to wait query process %d to exit, ret=%d", static_cast<int32_t>(taskPid_), ret);
        return PROFILING_FAILED;
    }
    taskPid_ = MSVP_PROCESS;
    exitCode = INVALID_EXIT_CODE;
    CmdLog::CmdInfoLog("Query all data in %s done.", Utils::BaseName(jobResultDir_).c_str());
    return PROFILING_SUCCESS;
}

int32_t RunningMode::RunExportDbTask(const ExecCmdParams &execCmdParams, std::vector<std::string> &envsV,
                                  int32_t &exitCode)
{
    std::vector<std::string> argsDbV = { analysisPath_, "export", "db", "-dir=" + jobResultDir_ };

    int32_t ret = analysis::dvvp::common::utils::Utils::ExecCmd(execCmdParams, argsDbV, envsV, exitCode, taskPid_);
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("Failed to launch export db task, data path: %s", Utils::BaseName(jobResultDir_).c_str());
        return PROFILING_FAILED;
    }
    ret = WaitRunningProcess(taskName_ + " db");
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to wait export db process %d to exit, ret=%d", static_cast<int32_t>(taskPid_), ret);
        return PROFILING_FAILED;
    }
    taskPid_ = MSVP_PROCESS;
    exitCode = INVALID_EXIT_CODE;
    return PROFILING_SUCCESS;
}

int32_t RunningMode::RunExportSummaryTask(const ExecCmdParams &execCmdParams, std::vector<std::string> &envsV,
                                      int32_t &exitCode)
{
    std::vector<std::string> argsSummaryV = { analysisPath_, "export", "summary", "-dir=" + jobResultDir_,
                                              "--format=" + params_->exportSummaryFormat };
    if (params_->clearSwitch == "on") {
        argsSummaryV.emplace_back("--clear");
    }
    if (params_->exportModelId != DEFAULT_MODEL_ID) {
        argsSummaryV.emplace_back("--model-id=" + params_->exportModelId);
    }
    if (params_->exportIterationId != DEFAULT_INTERATION_ID) {
        argsSummaryV.emplace_back("--iteration-id=" + params_->exportIterationId);
    }
    int32_t ret = analysis::dvvp::common::utils::Utils::ExecCmd(execCmdParams, argsSummaryV, envsV, exitCode, taskPid_);
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("Failed to launch export summary task, data path: %s", Utils::BaseName(jobResultDir_).c_str());
        return PROFILING_FAILED;
    }
    ret = WaitRunningProcess(taskName_ + " summary");
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to wait export summary process %d to exit, ret=%d", static_cast<int32_t>(taskPid_), ret);
        return PROFILING_FAILED;
    }
    taskPid_ = MSVP_PROCESS;
    exitCode = INVALID_EXIT_CODE;
    return PROFILING_SUCCESS;
}
int32_t RunningMode::RunExportTimelineTask(const ExecCmdParams &execCmdParams, std::vector<std::string> &envsV,
                                       int32_t &exitCode)
{
    std::vector<std::string> argsTimelineV = { analysisPath_, "export", "timeline", "-dir=" + jobResultDir_ };
    if (params_->exportModelId != DEFAULT_MODEL_ID) {
        argsTimelineV.emplace_back("--model-id=" + params_->exportModelId);
    }
    if (params_->exportIterationId != DEFAULT_INTERATION_ID) {
        argsTimelineV.emplace_back("--iteration-id=" + params_->exportIterationId);
    }
    if (!params_->reportsPath.empty()) {
        argsTimelineV.emplace_back("-reports=" + params_->reportsPath);
    }
    int32_t ret = analysis::dvvp::common::utils::Utils::ExecCmd(execCmdParams, argsTimelineV, envsV, 
        exitCode, taskPid_);
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("Failed to launch export timeline task, data path: %s", Utils::BaseName(jobResultDir_).c_str());
        return PROFILING_FAILED;
    }
    ret = WaitRunningProcess(taskName_ + " timeline");
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to wait export timeline process %d to exit, ret=%d", static_cast<int32_t>(taskPid_), ret);
        return PROFILING_FAILED;
    }
    taskPid_ = MSVP_PROCESS;
    exitCode = INVALID_EXIT_CODE;
    return PROFILING_SUCCESS;
}

int32_t RunningMode::StartExportTask()
{
    if (isQuit_) {
        MSPROF_LOGE("Start export task error, msprofbin has quited");
        return PROFILING_FAILED;
    }
    if (taskPid_ != MSVP_PROCESS) {
        MSPROF_LOGE("Start export task error, process %d is running,"
                    "only one child process can run at the same time.",
                    static_cast<int32_t>(taskPid_));
        return PROFILING_FAILED;
    }
    if (jobResultDir_.empty() || analysisPath_.empty()) {
        MSPROF_LOGE("Start export task error, get output dir and msprof.py script failed.");
        return PROFILING_FAILED;
    }
    CmdLog::CmdInfoLog("Start export data in %s.", Utils::BaseName(jobResultDir_).c_str());
    taskName_ = "Export";

    std::string cmd = params_->pythonPath;
    ExecCmdParams execCmdParams(cmd, true, "");
    std::vector<std::string> envsV;
    int32_t exitCode = INVALID_EXIT_CODE;
    SetEnvList(envsV);
    if (params_->exportType == "db") {
        if (RunExportDbTask(execCmdParams, envsV, exitCode) != PROFILING_SUCCESS) {
            MSPROF_LOGE("Export db failed in %s.", Utils::BaseName(jobResultDir_).c_str());
            return PROFILING_FAILED;
        }
    } else {
        if (RunExportTimelineTask(execCmdParams, envsV, exitCode) != PROFILING_SUCCESS) {
            MSPROF_LOGE("Export timeline failed in %s.", Utils::BaseName(jobResultDir_).c_str());
            return PROFILING_FAILED;
        }
        if (RunExportSummaryTask(execCmdParams, envsV, exitCode) != PROFILING_SUCCESS) {
            MSPROF_LOGE("Export summary failed in %s.", Utils::BaseName(jobResultDir_).c_str());
            return PROFILING_FAILED;
        }
    }
    CmdLog::CmdInfoLog("Export all data in %s done.", Utils::BaseName(jobResultDir_).c_str());
    return PROFILING_SUCCESS;
}

void RunningMode::StopNoWait()
{
    CmdLog::CmdWarningLog("Receive stop singal.");
    DynProfCliMgr::instance()->StopDynProfCli();
    StopRunningTasks();
    UpdateOutputDirInfo();
}

int32_t RunningMode::WaitRunningProcess(std::string processUsage)
{
    if (taskPid_ == MSVP_PROCESS) {
        MSPROF_LOGE("[WaitRunningProcess] Invalid task pid.");
        return PROFILING_FAILED;
    }
    bool isExited = false;
    int32_t exitCode = 0;
    int32_t ret = PROFILING_SUCCESS;
    static const int32_t SLEEP_INTEVAL_US = 1000000;
    const int32_t lltExitCode = 256;

    for (;;) {
        ret = analysis::dvvp::common::utils::Utils::WaitProcess(taskPid_, isExited, exitCode, false);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to wait %s process %d to exit, ret=%d", processUsage.c_str(),
                        static_cast<int32_t>(taskPid_), ret);
            return ret;
        }
        if (isExited) {
            MSPROF_EVENT("%s process %d exited, exit code:%d", processUsage.c_str(), static_cast<int32_t>(taskPid_),
                         exitCode);
            if (exitCode != 0 && !isQuit_) {
                MSPROF_LOGW("An exception has occurred in process %s, return code: %s.", processUsage.c_str(),
                            strerror(exitCode));
                CmdLog::CmdWarningLog("An exception has occurred in process %s, return code: %s.",
                            processUsage.c_str(), strerror(exitCode));
            }
            if (exitCode == lltExitCode) {
                return PROFILING_FAILED;
            }
            return PROFILING_SUCCESS;
        }
        if (isQuit_) {
            StopNoWait();
        }
        analysis::dvvp::common::utils::Utils::UsleepInterupt(SLEEP_INTEVAL_US);
    }
}

SHARED_PTR_ALIA<MsprofTask> RunningMode::GetRunningTask(const std::string &jobId)
{
    const auto iter = taskMap_.find(jobId);
    if (iter != taskMap_.end()) {
        return iter->second;
    } else {
        return nullptr;
    }
}

int32_t RunningMode::CheckAnalysisEnv()
{
    if (isQuit_) {
        MSPROF_LOGE("Check Analysis env failed, msprofbin has quited");
        return PROFILING_FAILED;
    }
    if (Platform::instance()->RunSocSide()) {
        CmdLog::CmdWarningLog("Not in host side, analysis is not supported");
        return PROFILING_FAILED;
    }
    if (params_->pythonPath.empty()) {
        const std::string PYTHON_CMD{ "python3" };
        params_->pythonPath = PYTHON_CMD;
    }
    // check analysis scripts
    std::string absolutePath = Utils::GetSelfPath();
    std::string dirName = Utils::DirName(absolutePath);
    std::string msprofToolsPath;
    std::string binPath;
    if (Utils::SplitPath(dirName, msprofToolsPath, binPath) != PROFILING_SUCCESS) {
        CmdLog::CmdWarningLog("Get profiler path failed.");
        return PROFILING_FAILED;
    }
    Utils::EnsureEndsInSlash(msprofToolsPath);
    const std::string ANALYSIS_SCRIPT_PATH{ "profiler_tool/analysis/msprof/msprof.py" };
    analysisPath_ = msprofToolsPath + ANALYSIS_SCRIPT_PATH;
    if (!Utils::IsFileExist(analysisPath_)) {
        CmdLog::CmdWarningLog("No analysis script found in %s", Utils::BaseName(analysisPath_).c_str());
        return PROFILING_FAILED;
    }
    if (OsalAccess2(analysisPath_.c_str(), OSAL_X_OK) != OSAL_EN_OK) {
        CmdLog::CmdWarningLog("Analysis script permission denied, path: %s", Utils::BaseName(analysisPath_).c_str());
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("Found available analysis script, script path: %s", Utils::BaseName(ANALYSIS_SCRIPT_PATH).c_str());

    return PROFILING_SUCCESS;
}

AppMode::~AppMode() {}

int32_t AppMode::ModeParamsCheck()
{
    if (params_ == nullptr) {
        MSPROF_LOGE("[App Mode] Invalid params!");
        return PROFILING_FAILED;
    }
    OutputUselessParams();
    if (HandleProfilingParams() != PROFILING_SUCCESS) {
        MSPROF_LOGE("[App Mode] HandleProfilingParams failed");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t AppMode::RunModeTasks()
{
    if (params_ == nullptr) {
        MSPROF_LOGE("[App Mode] Invalid params!");
        return PROFILING_FAILED;
    }
    SetDefaultParams();
    if (DynProfCliMgr::instance()->IsDynProfCliEnable()) {
        return StartAppTaskForDynProf();
    }

    auto startTime = std::chrono::high_resolution_clock::now();
    if (StartAppTask() != PROFILING_SUCCESS) {
        MSPROF_LOGE("[App Mode] Run application task failed.");
        return PROFILING_FAILED;
    }
    auto endTime = std::chrono::high_resolution_clock::now();
    UpdateOutputDirInfo();

    if (jobResultDirList_.empty()) {
        auto duration = std::chrono::duration_cast<std::chrono::seconds>(endTime - startTime);
        if (!params_->delayTime.empty() && static_cast<uint64_t>(duration.count()) <= std::stoull(params_->delayTime)) {
            MSPROF_LOGW("[App Mode] Before delay time, the app process has exited.");
            return PROFILING_SUCCESS;
        }
        MSPROF_LOGE("[App Mode] Failed to find profiling data");
        CmdLog::CmdErrorLog("Failed to find profiling data,"
                            " please check that the application executes AI-related business,"
                            " or ensure that aclInit/GEInitialize is invoked in the application");
        return PROFILING_FAILED;
    }

    if (CheckAnalysisEnv() != PROFILING_SUCCESS) {
        MSPROF_LOGW("[App Mode] Analysis environment is not OK, auto parse will not start.");
        return PROFILING_SUCCESS;
    }

    std::set<std::string>::iterator iter;
    for (iter = jobResultDirList_.begin(); iter != jobResultDirList_.end(); ++iter) {
        jobResultDir_ = *iter;
        if (StartExportTask() != PROFILING_SUCCESS) {
            MSPROF_LOGW("[App Mode] The export task did not complete successfully.");
            return PROFILING_SUCCESS;
        }
        if (StartQueryTask() != PROFILING_SUCCESS) {
            MSPROF_LOGW("[App Mode] The query task did not complete successfully.");
            return PROFILING_SUCCESS;
        }
    }
    return PROFILING_SUCCESS;
}

void AppMode::SetDefaultParams() const
{
    if (params_->acl.empty()) {
        params_->acl = "on";
    }
    if (params_->ts_keypoint.empty()) {
        params_->ts_keypoint = "on";
    }
    if (params_->ai_core_profiling.empty()) {
        params_->ai_core_lpm = "on";
        params_->ai_core_profiling = "on";
    }
    if (params_->ai_core_profiling_mode.empty()) {
        params_->ai_core_profiling_mode = PROFILING_MODE_TASK_BASED;
    }
    if (params_->ai_core_profiling == "on" && params_->aiv_profiling.empty()) {
        params_->ai_core_lpm = "on";
        params_->aiv_profiling = "on";
    }
    if (params_->aiv_profiling_mode.empty()) {
        params_->aiv_profiling_mode = PROFILING_MODE_TASK_BASED;
    }
    if (params_->aiv_profiling_mode == PROFILING_MODE_SAMPLE_BASED ||
        !Platform::instance()->CheckIfSupport(PLATFORM_TASK_AICORE_LPM)) {
        params_->ai_core_lpm = "off";
    }

    SetDefaultParamsByPlatformType();
}

int32_t AppMode::StartAppTaskForDynProf()
{
    if (isQuit_) {
        MSPROF_LOGE("Failed to launch app, msprofbin has quited");
        return PROFILING_FAILED;
    }
    if (DynProfCliMgr::instance()->IsAppMode()) {
        if (analysis::dvvp::app::Application::LaunchApp(params_, taskPid_) != PROFILING_SUCCESS) {
            MSPROF_LOGE("Dynamic profiling failed to launch application.");
            return PROFILING_FAILED;
        }
        // wait server start
        const int32_t sleepUs = 2 * 1000 * 1000;  // 2s
        Utils::UsleepInterupt(sleepUs);
    }

    if (DynProfCliMgr::instance()->StartDynProfCli(params_->ToString()) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Dynamic profiling start client thread fail.");
        // 关闭app
        StopRunningTasks();
        return PROFILING_FAILED;
    }

    MSPROF_LOGI("Dynamic profiling start client success.");
    DynProfCliMgr::instance()->WaitQuit();

    taskName_ = "app";
    if (DynProfCliMgr::instance()->IsAppMode() && !isQuit_) {
        CmdLog::CmdInfoLog("waiting for app process exit......");
        // wait app exit
        auto ret = WaitRunningProcess(taskName_);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to wait process %d to exit, ret=%d", static_cast<int32_t>(taskPid_), ret);
            return PROFILING_FAILED;
        }
    }
    taskPid_ = MSVP_PROCESS;
    return PROFILING_SUCCESS;
}

int32_t AppMode::StartAppTask(bool needWait)
{
    if (isQuit_) {
        MSPROF_LOGE("Failed to launch app, msprofbin has quited");
        return PROFILING_FAILED;
    }
    int32_t ret = analysis::dvvp::app::Application::LaunchApp(params_, taskPid_);
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("Failed to launch app");
        return PROFILING_FAILED;
    }
    taskName_ = "app";
    if (needWait) {
        // wait app exit
        ret = WaitRunningProcess("App");
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to wait process %d to exit, ret=%d", static_cast<int32_t>(taskPid_), ret);
            return PROFILING_FAILED;
        }
    }
    taskPid_ = MSVP_PROCESS;
    return PROFILING_SUCCESS;
}

SystemMode::~SystemMode() {}

int32_t SystemMode::CheckIfDeviceOnline() const
{
    if (params_->devices.compare("all") == 0) {
        return PROFILING_SUCCESS;
    }
    auto devIds = Utils::Split(params_->devices, false, "", ",");
    const int32_t numDevices = DrvGetDevNum();
    if (numDevices <= 0) {
        CmdLog::CmdErrorLog("Get dev's num %d failed", numDevices);
        return PROFILING_FAILED;
    }
    std::vector<int32_t> devices;
    int32_t ret = DrvGetDevIds(numDevices, devices);
    if (ret != PROFILING_SUCCESS) {
        CmdLog::CmdErrorLog("Get dev's id failed");
        return PROFILING_FAILED;
    }
    UtilsStringBuilder<int32_t> builder;
    builder.Join(devices, ",");
    std::set<std::string> validIds;
    std::vector<std::string> invalidIds;
    for (auto devId : devIds) {
        if (!Utils::CheckStringIsNonNegativeIntNum(devId)) {
            CmdLog::CmdErrorLog("The device (%s) is not valid, please check it!", devId.c_str());
            return PROFILING_FAILED;
        }
        int32_t devIdInt = 0;
        FUNRET_CHECK_EXPR_ACTION(!Utils::StrToInt32(devIdInt, devId), return PROFILING_FAILED, 
            "devId %s is invalid", devId.c_str());
        auto it = find(devices.begin(), devices.end(), devIdInt);
        if (it == devices.end()) {
            invalidIds.push_back(devId);
        } else {
            validIds.insert(devId);
        }
    }
    UtilsStringBuilder<std::string> strBuilder;
    if (!invalidIds.empty()) {
        CmdLog::CmdWarningLog("The following devices(%s) are offline and will not collect.",
                              strBuilder.Join(invalidIds, ",").c_str());
    }
    if (validIds.empty()) {
        CmdLog::CmdErrorLog("Argument --sys-devices is invalid,"
                            "Please enter a valid --sys-devices value.");
        return PROFILING_FAILED;
    }
    std::vector<std::string> validIdList;
    validIdList.assign(validIds.begin(), validIds.end());
    params_->devices = strBuilder.Join(validIdList, ",");
    return PROFILING_SUCCESS;
}

int32_t SystemMode::CheckHostSysParams() const
{
    if (params_->host_sys.empty() && params_->hostSysUsage.empty() && CheckIfDeviceOnline() != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    if (!params_->host_sys.empty() && params_->host_sys_pid < 0) {
        CmdLog::CmdErrorLog("The argument --host-sys-pid"
                            " are required when app is empty and --host-sys is on.");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

bool SystemMode::DataWillBeCollected() const
{
    if (params_ == nullptr || params_->usedParams.empty()) {
        return false;
    }
    std::set<int32_t> unneccessaryParams;
    set_difference(params_->usedParams.begin(), params_->usedParams.end(), neccessarySet_.begin(), neccessarySet_.end(),
                   inserter(unneccessaryParams, unneccessaryParams.begin()));
    set_intersection(params_->usedParams.begin(), params_->usedParams.end(), unneccessaryParams.begin(),
                     unneccessaryParams.end(), inserter(unneccessaryParams, unneccessaryParams.begin()));
    if (unneccessaryParams.size() == 1 && *(unneccessaryParams.begin()) == ARGS_SYS_DEVICES) {
        CmdLog::CmdWarningLog("No collection data type is specified, profiling will not start");
        return false;
    }
    return true;
}

int32_t SystemMode::ModeParamsCheck()
{
    if (params_ == nullptr) {
        MSPROF_LOGE("[System Mode] Invalid params!");
        return PROFILING_FAILED;
    }

    if (CheckNeccessaryParams() != PROFILING_SUCCESS) {
        MSPROF_LOGE("[System Mode] Check neccessary params failed!");
        return PROFILING_FAILED;
    }
    if (!DataWillBeCollected()) {
        MSPROF_LOGE("[System Mode] No data will be collected!");
        return PROFILING_FAILED;
    }
    OutputUselessParams();

    if (CheckHostSysParams() != PROFILING_SUCCESS) {
        MSPROF_LOGE("[System Mode] Check host sys params failed!");
        return PROFILING_FAILED;
    }

    if (HandleProfilingParams() != PROFILING_SUCCESS) {
        MSPROF_LOGE("[System Mode] HandleProfilingParams failed");
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

int32_t SystemMode::RunModeTasks()
{
    if (params_ == nullptr) {
        MSPROF_LOGE("[System Mode] Invalid params!");
        return PROFILING_FAILED;
    }
    SetSysDefaultParams();
    int32_t ret = StartSysTask();
    if (ret != PROFILING_SUCCESS) {
        if (ret != PROFILING_NOTSUPPORT) {
            MSPROF_LOGE("[System Mode] Run system task failed.");
        } else {
            UpdateOutputDirInfo();
        }
        return ret;
    }
    UpdateOutputDirInfo();
    if (CheckAnalysisEnv() != PROFILING_SUCCESS) {
        MSPROF_LOGW("[System Mode] Analysis environment is not OK, auto parse will not start.");
        return PROFILING_SUCCESS;
    }

    std::set<std::string>::iterator iter;
    for (iter = jobResultDirList_.begin(); iter != jobResultDirList_.end(); ++iter) {
        jobResultDir_ = *iter;
        if (StartExportTask() != PROFILING_SUCCESS) {
            MSPROF_LOGW("[System Mode] The export task did not complete successfully.");
            return PROFILING_SUCCESS;
        }
        if (StartQueryTask() != PROFILING_SUCCESS) {
            MSPROF_LOGW("[System Mode] The query task did not complete successfully.");
            return PROFILING_SUCCESS;
        }
    }
    return PROFILING_SUCCESS;
}

void SystemMode::SetSysDefaultParams() const
{
    if (params_->ai_core_profiling == "on") {
        params_->aiv_profiling = "on";
        params_->ai_core_profiling_mode = PROFILING_MODE_SAMPLE_BASED;
        params_->aiv_profiling_mode = PROFILING_MODE_SAMPLE_BASED;
    }
    params_->profMode = MSVP_PROF_SYSTEM_MODE;
}

int32_t SystemMode::CreateJobDir(std::string device, std::string &resultDir) const
{
    resultDir = params_->result_dir;
    resultDir = resultDir + MSVP_SLASH + baseDir_ + MSVP_SLASH;
    resultDir.append(Utils::CreateResultPath(device));
    if (Utils::CreateDir(resultDir) != PROFILING_SUCCESS) {
        char errBuf[MAX_ERR_STRING_LEN + 1] = { 0 };
        CmdLog::CmdErrorLog("Create dir (%s) failed.ErrorCode: %d, ErrorInfo: %s.", Utils::BaseName(resultDir).c_str(),
                            OsalGetErrorCode(),
                            OsalGetErrorFormatMessage(OsalGetErrorCode(), errBuf, MAX_ERR_STRING_LEN));
        return PROFILING_FAILED;
    }
    analysis::dvvp::common::utils::Utils::EnsureEndsInSlash(resultDir);
    return PROFILING_SUCCESS;
}

int32_t SystemMode::RecordOutPut() const
{
    std::string pidStr = std::to_string(Utils::GetPid());
    std::string recordFile = pidStr + MSVP_UNDERLINE + OUTPUT_RECORD;
    std::string absolutePath = params_->result_dir + MSVP_SLASH + recordFile;
    std::ofstream file;
    file.open(absolutePath, std::ios::out | std::ios::app);
    if (!file.is_open()) {
        MSPROF_LOGE("Failed to open %s", Utils::BaseName(recordFile).c_str());
        return PROFILING_FAILED;
    }
    file << baseDir_ << std::endl << std::flush;
    file.close();

    return PROFILING_SUCCESS;
}

int32_t SystemMode::StartHostTask(const std::string resultDir, uint32_t deviceId)
{
    auto params = GenerateHostParam(params_);
    if (params == nullptr) {
        MSPROF_LOGE("GenerateHostParam failed.");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("StartHostTask : %u, job_id : %s", deviceId, params->job_id.c_str());
    params->devices = std::to_string(deviceId);
    if (deviceId == DEFAULT_HOST_ID) {
        params->hostProfiling = true;
    } else if (params->hardware_mem.compare(MSVP_PROF_ON) == 0) {
        params->qosProfiling = MSVP_PROF_ON;
        Platform::instance()->GetQosProfileInfo(deviceId, params->qosEvents, params->qosEventId);
    }
    bool retu = CreateSampleJsonFile(params, resultDir);
    if (!retu) {
        MSPROF_LOGE("CreateSampleJsonFile failed");
        return PROFILING_FAILED;
    }
    params->result_dir = resultDir;
    int32_t ret = CreateUploader(params->job_id, resultDir);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("CreateUploader failed");
        return PROFILING_FAILED;
    }
    SHARED_PTR_ALIA<ProfSocTask> task = nullptr;
    MSVP_MAKE_SHARED2(task, ProfSocTask, deviceId, params, return PROFILING_FAILED);
    ret = task->Init();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("DeviceTask init failed, deviceId:%u", deviceId);
        return PROFILING_FAILED;
    }
    ret = task->Start();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("DeviceTask start failed, deviceId:%u", deviceId);
        return PROFILING_FAILED;
    }
    taskMap_[params->job_id] = task;
    taskList_.push_back(task);
    return PROFILING_SUCCESS;
}

int32_t SystemMode::StartDeviceTask(const std::string resultDir, const std::string device)
{
    MSPROF_LOGD("StartDeviceTask : %s", device.c_str());
    auto params = GenerateDeviceParam(params_);
    if (params == nullptr) {
        MSPROF_LOGE("GenerateDeviceParam failed.");
        return PROFILING_FAILED;
    }
    params->devices = device;
    int32_t ret = CreateUploader(params->job_id, resultDir);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("CreateUploader failed");
        return PROFILING_FAILED;
    }
    SHARED_PTR_ALIA<ProfRpcTask> task = nullptr;
    int32_t devId = 0;
    FUNRET_CHECK_EXPR_ACTION(!Utils::StrToInt32(devId, device), return PROFILING_FAILED, 
        "device %s is invalid", device.c_str());
    MSVP_MAKE_SHARED2(task, ProfRpcTask, devId, params, return PROFILING_FAILED);
    ret = task->Init();
    if (ret != PROFILING_SUCCESS) {
        if (ret != PROFILING_NOTSUPPORT) {
            MSPROF_LOGE("[StartDeviceTask]DeviceTask init failed, deviceId:%s", device.c_str());
        }
        return ret;
    }
    ret = task->Start();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[StartDeviceTask]DeviceTask start failed, deviceId:%s", device.c_str());
        return PROFILING_FAILED;
    }
    taskMap_[params->job_id] = task;
    taskList_.push_back(task);
    return PROFILING_SUCCESS;
}

void SystemMode::StopTask()
{
    if (taskList_.empty()) {
        return;
    }
    for (auto task = taskList_.end() - 1; task >= taskList_.begin(); task--) {
        (*task)->Stop();
        (*task)->Wait();
    }
    taskList_.clear();
    taskMap_.clear();
}

int32_t SystemMode::WaitSysTask() const
{
    uint32_t times = 0;
    uint32_t cycles = 0;

    if (params_->profiling_period > 0) {
        cycles = static_cast<uint32_t>(params_->profiling_period * US_TO_SECOND_TIMES(PROCESS_WAIT_TIME));
    }
    while ((times < cycles) && (!isQuit_)) {
        analysis::dvvp::common::utils::Utils::UsleepInterupt(PROCESS_WAIT_TIME);
        times++;
    }
    return PROFILING_SUCCESS;
}

int32_t SystemMode::CreateUploader(const std::string &jobId, const std::string &resultDir) const
{
    if (jobId.empty() || resultDir.empty()) {
        return PROFILING_FAILED;
    }
    auto transport =
        analysis::dvvp::transport::FileTransportFactory().CreateFileTransport(resultDir, params_->storageLimit, true);
    if (transport == nullptr) {
        MSPROF_LOGE("CreateFileTransport failed, key:%s", jobId.c_str());
        return PROFILING_FAILED;
    }
    int32_t ret = analysis::dvvp::transport::UploaderMgr::instance()->CreateUploader(jobId, transport);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("CreateUploader failed, key:%s", jobId.c_str());
        return PROFILING_FAILED;
    }
    Analysis::Dvvp::TaskHandle::TaskRelationshipMgr::instance()->AddLocalFlushJobId(jobId);

    return PROFILING_SUCCESS;
}

SHARED_PTR_ALIA<ProfileParams> SystemMode::GenerateHostParam(SHARED_PTR_ALIA<ProfileParams> params) const
{
    if (params == nullptr) {
        return nullptr;
    }
    SHARED_PTR_ALIA<ProfileParams> dstParams = nullptr;
    MSVP_MAKE_SHARED0(dstParams, ProfileParams, return nullptr);
    std::string dstParamsStr = params->ToString();
    if (!(dstParams->FromString(dstParamsStr))) {
        MSPROF_LOGE("[ProfManager::StartTask]Failed to parse dstParamsStr.");
        return nullptr;
    }
    uintptr_t addr = reinterpret_cast<uintptr_t>(dstParams.get());
    dstParams->job_id = Utils::ProfCreateId(static_cast<uint64_t>(addr));
    if (dstParams->ai_core_profiling_mode.empty()) {
        dstParams->ai_core_profiling_mode = PROFILING_MODE_SAMPLE_BASED;
    }
    if (dstParams->aiv_profiling_mode.empty()) {
        dstParams->aiv_profiling_mode = PROFILING_MODE_SAMPLE_BASED;
    }
    dstParams->msprof_llc_profiling = params->msprof_llc_profiling;
    dstParams->host_sys_pid = params->host_sys_pid;
    dstParams->profiling_period = params->profiling_period;
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_V4_1_0) {
        dstParams->instrProfiling = params->instrProfiling;
        dstParams->instrProfilingFreq = params->instrProfilingFreq;
    }
    return dstParams;
}

bool SystemMode::CreateSampleJsonFile(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params,
                                      const std::string &resultDir) const
{
    if (resultDir.empty()) {
        return true;
    }
    const std::string fileName = "sample.json";
    int32_t ret = Utils::CreateDir(resultDir);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("create dir error , %s", Utils::BaseName(resultDir).c_str());
        Utils::PrintSysErrorMsg();
        return false;
    }
    MSPROF_LOGI("CreateSampleJsonFile ");
    ret = WriteCtrlDataToFile(resultDir + fileName, params->ToString().c_str(), params->ToString().size());
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to write local files");
        return false;
    }

    return true;
}

bool SystemMode::CreateDoneFile(const std::string &absolutePath, const std::string &fileSize) const
{
    std::ofstream file;

    file.open(absolutePath, std::ios::out);
    if (!file.is_open()) {
        MSPROF_LOGE("Failed to open %s", Utils::BaseName(absolutePath).c_str());
        return false;
    }
    file << "filesize: " << fileSize << std::endl;
    file.flush();
    file.close();

    return true;
}

int32_t SystemMode::WriteCtrlDataToFile(const std::string &absolutePath, const std::string &data, int32_t dataLen) const
{
    std::ofstream file;

    if (Utils::IsFileExist(absolutePath)) {
        MSPROF_LOGI("file exist: %s", Utils::BaseName(absolutePath).c_str());
        return PROFILING_SUCCESS;
    }

    if (data.empty() || dataLen <= 0) {
        MSPROF_LOGE("Failed to open %s", Utils::BaseName(absolutePath).c_str());
        return PROFILING_FAILED;
    }
    file.open(absolutePath, std::ios::out | std::ios::trunc);
    if (!file.is_open()) {
        MSPROF_LOGE("Failed to open %s", Utils::BaseName(absolutePath).c_str());
        return PROFILING_FAILED;
    }
    file.write(data.c_str(), dataLen);
    file.flush();
    file.close();

    if (!(CreateDoneFile(absolutePath + ".done", std::to_string(dataLen)))) {
        MSPROF_LOGE("set device done file failed");
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

int32_t SystemMode::StartDeviceJobs(const std::string &device)
{
    std::string resultDir;
    int32_t ret = CreateJobDir(device, resultDir);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }
    uint32_t devId = 0;
    if (!Utils::StrToUint32(devId, device)) {
        MSPROF_LOGE("Convert device id:%s to uint32 failed", device.c_str());
        return PROFILING_FAILED;
    }
    // this host data is for device mapping(llc, ddr, aicore, etc)
    ret = StartHostTask(resultDir, devId);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("StartHostTask failed");
        StopTask();
        return PROFILING_FAILED;
    }

    if (IsDeviceJob() && (!Platform::instance()->PlatformIsSocSide()) &&
        ((Platform::instance()->GetPlatformType() == CHIP_MINI_V3) ||
        (!Platform::instance()->CheckIfSupportAdprof(devId)))) { // 1911ep collect device system data from HDC
        ret = StartDeviceTask(resultDir, device);
        if (ret != PROFILING_SUCCESS) {
            if (ret != PROFILING_NOTSUPPORT) {
                MSPROF_LOGE("StartHostTask failed");
            }
            StopTask();
            return ret;
        }
    }
    return PROFILING_SUCCESS;
}

int32_t SystemMode::StartHostJobs()
{
    MSPROF_LOGI("StartHostJobs");
    std::string resultDir;
    int32_t ret = CreateJobDir(std::to_string(DEFAULT_HOST_ID), resultDir);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }
    ret = StartHostTask(resultDir, DEFAULT_HOST_ID);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("StartHostTask failed");
        StopTask();
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t SystemMode::StartSysTask()
{
    std::vector<std::string> devices = Utils::Split(params_->devices, false, "", ",");
    params_->PrintAllFields();
    baseDir_ = Utils::CreateProfDir(0);
    if (RecordOutPut() != PROFILING_SUCCESS) {
        MSPROF_LOGW("Unable to record output dir: %s", Utils::BaseName(baseDir_).c_str());
    }
    if (params_->IsHostProfiling()) {
        if (StartHostJobs() != PROFILING_SUCCESS) {
            return PROFILING_FAILED;
        }
    }
    for (auto device : devices) {
        auto ret = StartDeviceJobs(device);
        if (ret != PROFILING_SUCCESS) {
            return ret;
        }
    }
    int32_t waitRet = WaitSysTask();
    if (waitRet != PROFILING_SUCCESS) {
        MSPROF_LOGE("WaitSysTask failed");
        return PROFILING_FAILED;
    }
    StopTask();
    return waitRet;
}

ParseMode::ParseMode(std::string preCheckParams, SHARED_PTR_ALIA<ProfileParams> params)
    : RunningMode(preCheckParams, "parse", params)
{
    whiteSet_ = { ARGS_OUTPUT, ARGS_PARSE, ARGS_PYTHON_PATH };
    neccessarySet_ = { ARGS_OUTPUT, ARGS_PARSE };
    blackSet_ = { ARGS_QUERY, ARGS_EXPORT, ARGS_ANALYZE, ARGS_RULE, ARGS_CLEAR };
}

ParseMode::~ParseMode() {}

int32_t ParseMode::ModeParamsCheck()
{
    if (params_ == nullptr) {
        MSPROF_LOGE("[Parse Mode] Invalid params!");
        return PROFILING_FAILED;
    }
    if (CheckForbiddenParams() != PROFILING_SUCCESS || CheckNeccessaryParams() != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    OutputUselessParams();

    return PROFILING_SUCCESS;
}

void ParseMode::UpdateOutputDirInfo()
{
    int32_t ret = GetOutputDirInfoFromParams();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGW("Unable to get output info from ParseMode.");
    }
}

int32_t ParseMode::RunModeTasks()
{
    if (params_ == nullptr) {
        MSPROF_LOGE("[Parse Mode] Invalid params!");
        return PROFILING_FAILED;
    }
    if (CheckAnalysisEnv() != PROFILING_SUCCESS) {
        MSPROF_LOGW("[Parse Mode] Analysis environment is not OK, parse will not start.");
        return PROFILING_FAILED;
    }
    UpdateOutputDirInfo();
    if (StartParseTask() != PROFILING_SUCCESS) {
        MSPROF_LOGE("[Parse Mode] Run parse task failed.");
        return PROFILING_FAILED;
    }
    if (StartQueryTask() != PROFILING_SUCCESS) {
        MSPROF_LOGE("[Parse Mode] Run query task failed.");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

QueryMode::QueryMode(std::string preCheckParams, SHARED_PTR_ALIA<ProfileParams> params)
    : RunningMode(preCheckParams, "query", params)
{
    whiteSet_ = { ARGS_OUTPUT, ARGS_QUERY, ARGS_PYTHON_PATH };
    neccessarySet_ = { ARGS_OUTPUT, ARGS_QUERY };
    blackSet_ = { ARGS_PARSE, ARGS_EXPORT, ARGS_ANALYZE, ARGS_RULE, ARGS_CLEAR };
}

QueryMode::~QueryMode() {}

int32_t QueryMode::ModeParamsCheck()
{
    if (params_ == nullptr) {
        MSPROF_LOGE("[Query Mode] Invalid params!");
        return PROFILING_FAILED;
    }
    if (CheckForbiddenParams() != PROFILING_SUCCESS || CheckNeccessaryParams() != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    OutputUselessParams();

    return PROFILING_SUCCESS;
}

void QueryMode::UpdateOutputDirInfo()
{
    int32_t ret = GetOutputDirInfoFromParams();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGW("Unable to get output info from QueryMode.");
    }
}

int32_t QueryMode::RunModeTasks()
{
    if (params_ == nullptr) {
        MSPROF_LOGE("[Query Mode] Invalid params!");
        return PROFILING_FAILED;
    }
    UpdateOutputDirInfo();
    if (CheckAnalysisEnv() != PROFILING_SUCCESS) {
        MSPROF_LOGW("[Query Mode] Analysis environment is not OK, query will not start.");
        return PROFILING_FAILED;
    }
    if (StartQueryTask() != PROFILING_SUCCESS) {
        MSPROF_LOGE("[Query Mode] Run query task failed.");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

ExportMode::ExportMode(std::string preCheckParams, SHARED_PTR_ALIA<ProfileParams> params)
    : RunningMode(preCheckParams, "export", params)
{
    whiteSet_ = { ARGS_OUTPUT, ARGS_EXPORT, ARGS_EXPORT_ITERATION_ID, ARGS_EXPORT_MODEL_ID, ARGS_SUMMARY_FORMAT,
                  ARGS_PYTHON_PATH, ARGS_CLEAR, ARGS_EXPORT_TYPE, ARGS_REPORTS };
    neccessarySet_ = { ARGS_OUTPUT, ARGS_EXPORT };
    blackSet_ = { ARGS_QUERY, ARGS_PARSE, ARGS_ANALYZE, ARGS_RULE };
}

ExportMode::~ExportMode() {}

int32_t ExportMode::ModeParamsCheck()
{
    if (params_ == nullptr) {
        MSPROF_LOGE("[Export Mode] Invalid params!");
        return PROFILING_FAILED;
    }
    if (params_->exportType == "db") {
        preCheckParams_ = "export and --type";
        whiteSet_ = { ARGS_OUTPUT, ARGS_EXPORT, ARGS_EXPORT_TYPE, ARGS_PYTHON_PATH };
        neccessarySet_ = { ARGS_OUTPUT, ARGS_EXPORT, ARGS_EXPORT_TYPE };
        blackSet_ = { ARGS_QUERY, ARGS_PARSE, ARGS_ANALYZE, ARGS_RULE, ARGS_EXPORT_ITERATION_ID,
                        ARGS_EXPORT_MODEL_ID, ARGS_SUMMARY_FORMAT, ARGS_CLEAR, ARGS_REPORTS };
    }
    if (CheckForbiddenParams() != PROFILING_SUCCESS || CheckNeccessaryParams() != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    OutputUselessParams();

    return PROFILING_SUCCESS;
}

void ExportMode::UpdateOutputDirInfo()
{
    int32_t ret = GetOutputDirInfoFromParams();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGW("Unable to get output info from ExportMode.");
    }
}

int32_t ExportMode::RunModeTasks()
{
    if (params_ == nullptr) {
        MSPROF_LOGE("[Export Mode] Invalid params!");
        return PROFILING_FAILED;
    }
    UpdateOutputDirInfo();
    if (CheckAnalysisEnv() != PROFILING_SUCCESS) {
        MSPROF_LOGW("[Export Mode] Analysis environment is not OK, export will not start.");
        return PROFILING_FAILED;
    }
    if (StartExportTask() != PROFILING_SUCCESS) {
        MSPROF_LOGE("[Export Mode] Run export task failed.");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

AnalyzeMode::AnalyzeMode(std::string preCheckParams, SHARED_PTR_ALIA<ProfileParams> params)
    : RunningMode(preCheckParams, "analyze", params)
{
    whiteSet_ = { ARGS_OUTPUT, ARGS_ANALYZE, ARGS_PYTHON_PATH, ARGS_RULE, ARGS_CLEAR, ARGS_EXPORT_TYPE };
    neccessarySet_ = { ARGS_OUTPUT, ARGS_ANALYZE };
    blackSet_ = { ARGS_QUERY, ARGS_EXPORT, ARGS_PARSE };
}

AnalyzeMode::~AnalyzeMode() {}

int32_t AnalyzeMode::ModeParamsCheck()
{
    MSPROF_LOGI("[AnalyzeMode] ModeParamsCheck");
    if (params_ == nullptr) {
        MSPROF_LOGE("[Analyze Mode] Invalid params!");
        return PROFILING_FAILED;
    }

    if (CheckForbiddenParams() != PROFILING_SUCCESS || CheckNeccessaryParams() != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }

    OutputUselessParams();
    return PROFILING_SUCCESS;
}

void AnalyzeMode::UpdateOutputDirInfo()
{
    MSPROF_LOGI("[AnalyzeMode] UpdateOutputDirInfo");
    int32_t ret = GetOutputDirInfoFromParams();
    FUNRET_CHECK_EXPR_LOGW(ret != PROFILING_SUCCESS, "Unable to get output info from AnalyzeMode.");
}

int32_t AnalyzeMode::RunModeTasks()
{
    MSPROF_LOGI("[AnalyzeMode] RunModeTasks");
    if (params_ == nullptr) {
        MSPROF_LOGE("[Analyze Mode] Invalid params!");
        return PROFILING_FAILED;
    }

    if (CheckAnalysisEnv() != PROFILING_SUCCESS) {
        MSPROF_LOGW("[Analyze Mode] Analysis environment is not OK, parse will not start.");
        return PROFILING_FAILED;
    }

    UpdateOutputDirInfo();
    if (StartAnalyzeTask() != PROFILING_SUCCESS) {
        MSPROF_LOGE("[Analyze Mode] Run analyze task failed.");
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}
}
}
}
