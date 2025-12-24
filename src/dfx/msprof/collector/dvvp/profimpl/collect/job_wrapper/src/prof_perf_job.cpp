/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_perf_job.h"
#include <algorithm>
#include "ai_drv_prof_api.h"
#include "ai_drv_dev_api.h"
#include "config_manager.h"
#include "param_validation.h"
#include "uploader_mgr.h"
#include "utils/utils.h"
#include "config/config.h"
#include "platform/platform.h"
#include "adprof_collector_proxy.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::validation;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Analysis::Dvvp::Common::Config;
using namespace Analysis::Dvvp::MsprofErrMgr;

constexpr uint32_t PERF_DATA_BUFF_SIZE_M = 262144 + 1;  // 262144 + 1, 256K Byte + '\0'
static const std::string PROF_COLLECT = "sudo";
static const std::string ENV_PATH = "PATH=/usr/bin:/usr/sbin:/var";

PerfExtraTask::PerfExtraTask(uint32_t bufSize, const std::string &retDir,
                             SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx,
                             SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param)
    : isInited_(false),
      dataSize_(0),
      retDir_(retDir),
      buf_(bufSize),
      jobCtx_(jobCtx),
      param_(param)
{
}

PerfExtraTask::~PerfExtraTask() {}

int32_t PerfExtraTask::Init()
{
    if (param_->hostProfiling) {
        return PROFILING_FAILED;
    }

    if (isInited_) {
        MSPROF_LOGE("The PerfExtraTask is inited");
        MSPROF_INNER_ERROR("EK9999", "The PerfExtraTask is inited");
        return PROFILING_FAILED;
    }

    if (!buf_.Init()) {
        MSPROF_LOGE("Buf init failed");
        MSPROF_INNER_ERROR("EK9999", "Buf init failed");
        return PROFILING_FAILED;
    }

    MSPROF_LOGI("PerfExtraTask init succ");
    isInited_ = true;

    return PROFILING_SUCCESS;
}

int32_t PerfExtraTask::UnInit()
{
    if (!isInited_) {
        MSPROF_LOGI("PerfExtraTask is uninited");
        return PROFILING_SUCCESS;
    }

    buf_.Uninit();
    isInited_ = false;
    return PROFILING_SUCCESS;
}

void PerfExtraTask::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);
    while (!IsQuit()) {
        MSPROF_LOGI("PerfExtraTask running");
        Utils::UsleepInterupt(1000000);  // 1000000 : sleep 1s
        PerfScriptTask();
    }

    PerfScriptTask();
    MSPROF_LOGI("PerfExtraTask the total data size: %lld", dataSize_);
}

void PerfExtraTask::PerfScriptTask()
{
    std::vector<std::string> files;
    std::vector<std::string> perfDataFiles;

    Utils::GetFiles(retDir_, false, files, 0);
    for (size_t i = 0; i < files.size(); i++) {
        if (files[i].find(MSVP_PROF_PERF_DATA_FILE) != std::string::npos &&
            std::count(files[i].begin(), files[i].end(), '.') == 3) {  // 3 meaning dot number: ai_ctrl_cpu.data.0.xxx
            perfDataFiles.push_back(files[i]);
        }
    }

    std::sort(perfDataFiles.begin(), perfDataFiles.end());

    size_t i = 0;
    size_t size = perfDataFiles.size();
    std::string retFileName;
    const size_t lastOne = 1;

    for (; (size > lastOne) && (i < (size - lastOne)); i++) {
        MSPROF_LOGI("PerfExtraTask file: %s", perfDataFiles[i].c_str());
        ResolvePerfRecordData(perfDataFiles[i]);
        retFileName = perfDataFiles[i] + MSVP_PROF_PERF_RET_FILE_SUFFIX;
        StoreData(retFileName);

        (void)::remove(perfDataFiles[i].c_str());
        (void)::remove(retFileName.c_str());
    }

    if (IsQuit()) {
        for (; i < size; i++) {
            MSPROF_LOGI("PerfExtraTask file: %s", perfDataFiles[i].c_str());
            ResolvePerfRecordData(perfDataFiles[i]);
            retFileName = perfDataFiles[i] + MSVP_PROF_PERF_RET_FILE_SUFFIX;
            StoreData(retFileName);

            (void)::remove(perfDataFiles[i].c_str());
            (void)::remove(retFileName.c_str());
        }
    }
}

void PerfExtraTask::ResolvePerfRecordData(const std::string &fileName) const
{
    std::vector<std::string> argsVec;
    std::vector<std::string> envVec;

    envVec.push_back(ENV_PATH);

    std::string newFilePath = fileName + MSVP_PROF_PERF_RET_FILE_SUFFIX;
    argsVec.push_back("/var/prof_collect.sh");
    argsVec.push_back("--script");
    argsVec.push_back(fileName);
    int32_t exitCode = VALID_EXIT_CODE;
    OsalProcess appProcess = MSVP_PROCESS;
    ExecCmdParams execCmdParams(PROF_COLLECT, false, newFilePath);
    int32_t ret = Utils::ExecCmd(execCmdParams,
                             argsVec,  // const std::vector<std::string> & argv,
                             envVec,   // const std::vector<std::string> & envp,
                             exitCode, appProcess);
    MSPROF_LOGI("resolve ctrlcpu data:%s, ret=%d, exit_code=%d", fileName.c_str(), ret, exitCode);
}

void PerfExtraTask::StoreData(const std::string &fileName)
{
    if (!(Utils::IsFileExist(fileName))) {
        MSPROF_LOGW("file:%s is not exist", fileName.c_str());
        return;
    }

    const int64_t len = Utils::GetFileSize(fileName);
    if (len <= 0 || len > MSVP_LARGE_FILE_MAX_LEN) {
        MSPROF_LOGE("data file size is invalid");
        MSPROF_INNER_ERROR("EK9999", "data file size is invalid");
        return;
    }

    std::string perfRetName = "data/ai_ctrl_cpu.data";
    UNSIGNED_CHAR_PTR buf = const_cast<UNSIGNED_CHAR_PTR>(buf_.GetBuffer());
    size_t bufSize = buf_.GetBufferSize();
    std::string canonicalizedPath = Utils::CanonicalizePath(fileName);
    FUNRET_CHECK_EXPR_ACTION(canonicalizedPath.empty(), return,
        "The fileName: %s does not exist or permission denied.", fileName.c_str());
    std::ifstream ifs(canonicalizedPath, std::ifstream::in);
    if (!ifs.is_open() || buf == nullptr) {
        return;
    }

    while (ifs.good()) {
        (void)memset_s(buf, bufSize, 0, bufSize);
        ifs.read(reinterpret_cast<CHAR_PTR>(buf), bufSize > 0 ? (bufSize - 1) : 0);

        SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk;
        MSVP_MAKE_SHARED0(fileChunk, analysis::dvvp::ProfileFileChunk, return );
        fileChunk->fileName = Utils::PackDotInfo(perfRetName, jobCtx_->tag);
        fileChunk->offset = -1;
        fileChunk->chunk = std::string(reinterpret_cast<CONST_CHAR_PTR>(buf), ifs.gcount());
        fileChunk->chunkSize = ifs.gcount();
        fileChunk->isLastChunk = false;
        fileChunk->chunkModule = FileChunkDataModule::PROFILING_IS_FROM_DEVICE;
        fileChunk->extraInfo = Utils::PackDotInfo(jobCtx_->job_id, jobCtx_->dev_id);

        if (AdprofCollectorProxy::instance()->AdprofStarted()) {
            AdprofCollectorProxy::instance()->Report(fileChunk);
        } else {
            if (analysis::dvvp::transport::UploaderMgr::instance()->UploadData(param_->job_id,
                fileChunk) != PROFILING_SUCCESS) {
                MSPROF_LOGE("Upload cpu data failed , jobId: %s", param_->job_id.c_str());
                MSPROF_INNER_ERROR("EK9999", "Upload cpu data failed , jobId: %s", param_->job_id.c_str());
            }
        }
        dataSize_ += static_cast<long long>(ifs.gcount());
    }

    ifs.close();
    MSPROF_LOGI("PerfExtraTask data size: %lld", dataSize_);
}

void PerfExtraTask::SetJobCtx(SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx)
{
    if (jobCtx != nullptr) {
        jobCtx_ = jobCtx;
    }
}

ProfCtrlcpuJob::ProfCtrlcpuJob() : ctrlcpuProcess_(MSVP_PROCESS) {}

ProfCtrlcpuJob::~ProfCtrlcpuJob() {}

int32_t ProfCtrlcpuJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_EVENT_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }
    if (!Platform::instance()->RunSocSide()) {
        MSPROF_LOGI("Not in device Side, aiCtrlcpu Profiling not enabled");
        return PROFILING_FAILED;
    }
    collectionJobCfg_ = cfg;
    std::string tmpPath = ConfigManager::instance()->GetPerfDataDir(collectionJobCfg_->comParams->devId);
    const int32_t ret = Utils::CreateDir(tmpPath);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Creating dir failed: %s", Utils::BaseName(tmpPath).c_str());
        MSPROF_INNER_ERROR("EK9999", "Creating dir failed: %s", Utils::BaseName(tmpPath).c_str());
        Utils::PrintSysErrorMsg();
        return ret;
    }
    // perf script
    MSVP_MAKE_SHARED4(perfExtraTask_, PerfExtraTask, PERF_DATA_BUFF_SIZE_M, tmpPath,
                      collectionJobCfg_->comParams->jobCtx, collectionJobCfg_->comParams->params,
                      return PROFILING_FAILED);
    return PROFILING_SUCCESS;
}

int32_t ProfCtrlcpuJob::Process()
{
    std::string profCtrlcpuCmd;
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    if (collectionJobCfg_->jobParams.events != nullptr && collectionJobCfg_->jobParams.events->size() != 0) {
        GetCollectCtrlCpuEventCmd(*(collectionJobCfg_->jobParams.events), profCtrlcpuCmd);
    }

    if (profCtrlcpuCmd.size() > 0) {
        MSPROF_LOGI("start profiling ctrl cpu, cmd=%s", profCtrlcpuCmd.c_str());

        std::vector<std::string> params = Utils::Split(profCtrlcpuCmd.c_str());
        if (params.empty()) {
            MSPROF_LOGE("ProfCtrlcpuJob params empty");
            MSPROF_INNER_ERROR("EK9999", "ProfCtrlcpuJob params empty");
            return PROFILING_FAILED;
        }
        MSPROF_LOGI("Begin to start profiling ctrl cpu");

        std::string cmd = params[0];
        std::vector<std::string> argsV;
        std::vector<std::string> envsV;
        if (params.size() > 1) {
            argsV.assign(params.begin() + 1, params.end());
        }
        envsV.push_back("PATH=/usr/bin:/usr/sbin:/var");

        int32_t exitCode = INVALID_EXIT_CODE;
        ctrlcpuProcess_ = MSVP_PROCESS;
        std::string perfLog =
            ConfigManager::instance()->GetPerfDataDir(collectionJobCfg_->comParams->devId) + MSVP_SLASH + "perf.log";
        ExecCmdParams execCmdParams(cmd, true, perfLog);
        int32_t ret = Utils::ExecCmd(execCmdParams, argsV, envsV, exitCode, ctrlcpuProcess_);
        MSPROF_LOGI("start profiling ctrl cpu, pid=%d, ret=%d", ctrlcpuProcess_, ret);
        FUNRET_CHECK_RET_VALUE(ret != PROFILING_SUCCESS, return ret);
        if (perfExtraTask_ && perfExtraTask_->Init() == PROFILING_SUCCESS) {
            // perf script start
            perfExtraTask_->SetJobCtx(collectionJobCfg_->comParams->jobCtx);
            perfExtraTask_->SetThreadName(MSVP_COLLECT_PERF_SCRIPT_THREAD_NAME);
            ret = perfExtraTask_->Start();
            if (ret != PROFILING_SUCCESS) {
                MSPROF_LOGE("[ProfCtrlcpuJob::Process]Failed to start perfExtraTask_ thread, ret=%d", ret);
                MSPROF_INNER_ERROR("EK9999", "Failed to start perfExtraTask_ thread, ret=%d", ret);
                return ret;
            }
        }
    }
    return PROFILING_SUCCESS;
}

int32_t ProfCtrlcpuJob::GetCollectCtrlCpuEventCmd(const std::vector<std::string> &events, std::string &profCtrlcpuCmd)
{
    const int32_t changeFormMsToS = 1000;
    if (events.empty() || !ParamValidation::instance()->CheckCtrlCpuEventIsValid(events)) {
        return PROFILING_FAILED;
    }
    std::string cpuDataFile;
    const int32_t ret = PrepareDataDir(cpuDataFile);
    if (ret == PROFILING_FAILED) {
        return PROFILING_FAILED;
    }
    std::stringstream ssCombined;
    ssCombined << "{";
    for (size_t jj = 0; jj < events.size(); ++jj) {
        if (jj != 0) {
            ssCombined << ",";
        }
        // replace "0x" to "r" at beginning
        std::string event = events[jj];
        const int32_t eventReplaceLen = 2;
        ssCombined << event.replace(0, eventReplaceLen, "r");
    }
    ssCombined << "}";
    std::stringstream ssPerfCmd;

    int32_t cpuProfilingInterval = 10;  // Profile deltas every 10ms defaultly
    if (collectionJobCfg_->comParams->params->cpu_sampling_interval > 0) {
        cpuProfilingInterval = collectionJobCfg_->comParams->params->cpu_sampling_interval;
    }

    ssPerfCmd << "sudo /var/prof_collect.sh --record ";
    ssPerfCmd << cpuDataFile;
    ssPerfCmd << " ";
    ssPerfCmd << Utils::ConvertIntToStr((changeFormMsToS / cpuProfilingInterval));
    ssPerfCmd << " ";
    ssPerfCmd << ssCombined.str();
    profCtrlcpuCmd = ssPerfCmd.str();

    return PROFILING_SUCCESS;
}

int32_t ProfCtrlcpuJob::PrepareDataDir(std::string &cpuDataFile)
{
    std::string perfDataDir = ConfigManager::instance()->GetPerfDataDir(collectionJobCfg_->comParams->devId);
    int32_t ret = Utils::CreateDir(perfDataDir);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Creating dir: %s err!", Utils::BaseName(perfDataDir).c_str());
        MSPROF_INNER_ERROR("EK9999", "Creating dir: %s err!", Utils::BaseName(perfDataDir).c_str());
        Utils::PrintSysErrorMsg();
        return PROFILING_FAILED;
    }
    std::vector<std::string> ctrlCpuDataPathVec;
    ctrlCpuDataPathVec.push_back(perfDataDir);
    ctrlCpuDataPathVec.push_back("ai_ctrl_cpu.data");
    std::string dataPath = Utils::JoinPath(ctrlCpuDataPathVec);
    cpuDataFile = dataPath + "." + std::to_string(collectionJobCfg_->comParams->devIdOnHost);
    std::ofstream cpuFile(cpuDataFile);
    if (cpuFile.is_open()) {
        cpuFile.close();
    } else {
        MSPROF_LOGE("Failed to open %s, dev_id=%d", cpuDataFile.c_str(), collectionJobCfg_->comParams->devIdOnHost);
        MSPROF_INNER_ERROR("EK9999", "Failed to open %s, dev_id=%d", cpuDataFile.c_str(),
                           collectionJobCfg_->comParams->devIdOnHost);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfCtrlcpuJob::Uninit()
{
    std::vector<std::string> envV;
    envV.push_back(ENV_PATH);
    std::vector<std::string> argsV;
    argsV.push_back("/var/prof_collect.sh");
    argsV.push_back("--kill");

    OsalProcess appProcess = MSVP_PROCESS;
    int32_t exitCode = VALID_EXIT_CODE;
    ExecCmdParams execCmdParams(PROF_COLLECT, false, "");
    int32_t ret = Utils::ExecCmd(execCmdParams, argsV, envV, exitCode, appProcess);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to kill process perf, ret=%d", ret);
        MSPROF_INNER_ERROR("EK9999", "Failed to kill process perf, ret=%d", ret);
    } else {
        MSPROF_LOGI("Succeeded to kill process, ret=%d, exitCode=%d", ret, exitCode);
    }

    if (ctrlcpuProcess_ > 0) {
        bool isExited = false;
        ret = Utils::WaitProcess(ctrlcpuProcess_, isExited, exitCode, true);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to wait process %d, ret=%d", ctrlcpuProcess_, ret);
            MSPROF_INNER_ERROR("EK9999", "Failed to wait process %d, ret=%d", ctrlcpuProcess_, ret);
        } else {
            MSPROF_LOGI("Process %d exited, exit code=%d", ctrlcpuProcess_, exitCode);
        }
        ctrlcpuProcess_ = MSVP_PROCESS;
        // perf script stop
        if (perfExtraTask_) {
            (void)perfExtraTask_->Stop();
            (void)perfExtraTask_->UnInit();
        }
    }

    if (collectionJobCfg_ != nullptr && collectionJobCfg_->jobParams.events != nullptr) {
        collectionJobCfg_->jobParams.events.reset();
    }
    return ret;
}

ProfAicpuHscbJob::ProfAicpuHscbJob() : hscbProcess_(MSVP_PROCESS), deviceMonotonic_(0), deviceSysCnt_(0) {}

ProfAicpuHscbJob::~ProfAicpuHscbJob() {}

int32_t ProfAicpuHscbJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_EVENT_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }

    if (!Platform::instance()->RunSocSide()) {
        MSPROF_LOGI("Not run in device Side, aicpu hscb profiling not enabled");
        return PROFILING_FAILED;
    }

    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->cpu_profiling.compare(MSVP_PROF_ON) != 0 ||
        collectionJobCfg_->comParams->params->hscb.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("Aicpu hscb not enabled.");
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

int32_t ProfAicpuHscbJob::GetAicpuHscbCmd(int32_t devId, const std::vector<std::string> &events,
    std::string &hscbCmd) const
{
    std::string perfDataDir = ConfigManager::instance()->GetPerfDataDir(devId);
    int32_t ret = Utils::CreateDir(perfDataDir);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to creating perf dir: %s.", perfDataDir.c_str());
        Utils::PrintSysErrorMsg();
        return PROFILING_FAILED;
    }

    collectionJobCfg_->jobParams.dataPath = perfDataDir + MSVP_SLASH + "hscb.data";
    std::string filePath =
        collectionJobCfg_->jobParams.dataPath + "." + std::to_string(collectionJobCfg_->comParams->devId);

    std::string canonicalizedPath = Utils::CanonicalizePath(filePath);
    FUNRET_CHECK_EXPR_ACTION(canonicalizedPath.empty(), return PROFILING_FAILED,
        "Failed to find hscb file path: %s, which does not exist or permission denied.", filePath.c_str());
    std::ofstream streamFile(canonicalizedPath);
    if (streamFile.is_open()) {
        streamFile.close();
    } else {
        MSPROF_LOGE("Failed to open %s, devId: %d.", filePath.c_str(), devId);
        return PROFILING_FAILED;
    }

    std::stringstream perfCmd;
    std::string eventsStr = GetEventsStr(events);
    FUNRET_CHECK_EXPR_ACTION(eventsStr.empty(), return PROFILING_FAILED,
        "Failed to set empty hscb events.");

    int32_t perfInterval = (collectionJobCfg_->comParams->params->cpu_sampling_interval > 0) ?
        collectionJobCfg_->comParams->params->cpu_sampling_interval : DEFAULT_PROFILING_INTERVAL_20MS;  // default 20ms
    perfCmd << "sudo /var/prof_collect.sh --stat ";
    perfCmd << filePath;
    perfCmd << " ";
    perfCmd << eventsStr;
    perfCmd << " ";
    perfCmd << perfInterval;
    hscbCmd = perfCmd.str();
    return PROFILING_SUCCESS;
}

int32_t ProfAicpuHscbJob::Process()
{
    CHECK_JOB_EVENT_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);

    std::string hscbCmd = "";
    (void)GetAicpuHscbCmd(collectionJobCfg_->comParams->devId, *(collectionJobCfg_->jobParams.events), hscbCmd);
    if (hscbCmd.size() > 0) {
        MSPROF_LOGI("Begin to start profiling aicpu hscb, cmd: %s", hscbCmd.c_str());
        std::vector<std::string> params = Utils::Split(hscbCmd.c_str());
        std::string cmd = params[0];
        std::vector<std::string> argsV;
        std::vector<std::string> envsV;
        if (params.size() > 1) {
            argsV.assign(params.begin() + 1, params.end());
        }

        envsV.push_back("PATH=/usr/bin/:/usr/sbin:/var");
        hscbProcess_ = MSVP_PROCESS;
        int32_t exitCode = INVALID_EXIT_CODE;
        ExecCmdParams execCmdParams(cmd, true, "");
        (void)DrvGetDeviceTime(collectionJobCfg_->comParams->devId, deviceMonotonic_, deviceSysCnt_);
        int32_t ret = Utils::ExecCmd(execCmdParams, argsV, envsV, exitCode, hscbProcess_);
        FUNRET_CHECK_EXPR_ACTION(ret != PROFILING_SUCCESS, return PROFILING_FAILED,
            "Failed to start profiling aicpu hscb, pid: %d, ret: %d", hscbProcess_, ret);
        MSPROF_LOGI("Success to start profiling aicpu hscb, pid: %d, ret: %d", hscbProcess_, ret);
    }

    return PROFILING_SUCCESS;
}

int32_t ProfAicpuHscbJob::Uninit()
{
    std::vector<std::string> envV;
    envV.push_back(ENV_PATH);
    std::vector<std::string> argsV;
    argsV.push_back("/var/prof_collect.sh");
    argsV.push_back("--kill");
    int32_t exitCode = VALID_EXIT_CODE;
    OsalProcess appProcess = MSVP_PROCESS;
    ExecCmdParams execCmdParams(PROF_COLLECT, false, "");
    int32_t ret = Utils::ExecCmd(execCmdParams, argsV, envV, exitCode, appProcess);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to kill process perf, ret: %d", ret);
    } else {
        MSPROF_LOGI("Succeeded to kill process, ret: %d, exitCode: %d", ret, exitCode);
    }
    if (hscbProcess_ > 0) {
        bool isExited = false;
        ret = Utils::WaitProcess(hscbProcess_, isExited, exitCode, true);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to wait process %d, ret: %d", hscbProcess_, ret);
        } else {
            MSPROF_LOGI("Process %d exited, exit code: %d", hscbProcess_, exitCode);
        }
    }
    SendData();
    return ret;
}

void ProfAicpuHscbJob::SendData() const
{
    SendPerfTimeData();
    std::string hscbDataFile =
        collectionJobCfg_->jobParams.dataPath + "." + std::to_string(collectionJobCfg_->comParams->devId);
    std::string canonicalizedPath = Utils::CanonicalizePath(hscbDataFile);
    FUNRET_CHECK_EXPR_ACTION(canonicalizedPath.empty(), return,
        "Failed to find hscb file path: %s, which does not exist or permission denied.", hscbDataFile.c_str());

    std::ifstream ifs(canonicalizedPath, std::ifstream::in);
    FUNRET_CHECK_EXPR_ACTION(!ifs.is_open(), return,
        "Failed to open hscb file: %s, please check its permissions.", hscbDataFile.c_str());

    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk;
    MSVP_MAKE_SHARED0(fileChunk, analysis::dvvp::ProfileFileChunk, return);
    SHARED_PTR_ALIA<char> buf;
    MSVP_MAKE_SHARED_ARRAY(buf, char, PERF_DATA_BUFF_SIZE_M, return);
    const std::string perfRetName = "data/aicpu.hscb.data";
    while (ifs.good()) {
        (void)memset_s(buf.get(), PERF_DATA_BUFF_SIZE_M, 0, PERF_DATA_BUFF_SIZE_M);
        ifs.read(buf.get(), PERF_DATA_BUFF_SIZE_M - 1);
        fileChunk->fileName = Utils::PackDotInfo(perfRetName, collectionJobCfg_->comParams->jobCtx->tag);
        fileChunk->offset = -1;
        fileChunk->chunk = std::string(static_cast<CONST_CHAR_PTR>(buf.get()), ifs.gcount());
        fileChunk->chunkSize = ifs.gcount();
        fileChunk->isLastChunk = false;
        fileChunk->extraInfo = Utils::PackDotInfo(collectionJobCfg_->comParams->jobCtx->job_id,
                                                  collectionJobCfg_->comParams->jobCtx->dev_id);
        fileChunk->chunkModule = FileChunkDataModule::PROFILING_IS_FROM_DEVICE;
        if (AdprofCollectorProxy::instance()->AdprofStarted()) {
            MSPROF_LOGI("Begin to send data of perf stat, datasize: %zu.", fileChunk->chunkSize);
            AdprofCollectorProxy::instance()->Report(fileChunk);
        }
    }
 
    ifs.close();
    (void)::remove(canonicalizedPath.c_str());
    MSPROF_LOGI("Success to remove hscb data: %s.", canonicalizedPath.c_str());
}

void ProfAicpuHscbJob::SendPerfTimeData() const
{
    const std::string perfRetName = "data/aicpu.hscb.data";
    const std::string timeStr = "HscbStartMono:" + std::to_string(deviceMonotonic_) + "\n"
        + "HscbStartSysCnt:" + std::to_string(deviceSysCnt_) + "\n";
    MSPROF_LOGI("Begin to send time data of perf stat: %s.", timeStr.c_str());
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk;
    MSVP_MAKE_SHARED0(fileChunk, analysis::dvvp::ProfileFileChunk, return);
    fileChunk->fileName = Utils::PackDotInfo(perfRetName, collectionJobCfg_->comParams->jobCtx->tag);
    fileChunk->offset = -1;
    fileChunk->chunk = timeStr;
    fileChunk->chunkSize = timeStr.size();
    fileChunk->isLastChunk = false;
    fileChunk->extraInfo = Utils::PackDotInfo(collectionJobCfg_->comParams->jobCtx->job_id,
                                                collectionJobCfg_->comParams->jobCtx->dev_id);
    fileChunk->chunkModule = FileChunkDataModule::PROFILING_IS_FROM_DEVICE;
    if (AdprofCollectorProxy::instance()->AdprofStarted()) {
        MSPROF_LOGI("Success to send time data of perf stat: %s.", timeStr.c_str());
        AdprofCollectorProxy::instance()->Report(fileChunk);
    }
}
}
}
}