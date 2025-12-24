/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_host_job.h"
#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
#include <windows.h>
#else
#include <unistd.h>
#endif
#include "config/config.h"
#include "logger/msprof_dlog.h"
#include "osal.h"
#include "platform/platform.h"
#include "uploader_mgr.h"
#include "utils/utils.h"
#include "prof_comm_job.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::MsprofErrMgr;

const int32_t FILE_FIND_REPLAY = 10;

static void StartHostProfTimer(TimerHandlerTag tag, SHARED_PTR_ALIA<TimerHandler> handler)
{
    TimerManager::instance()->StartProfTimer();
    TimerManager::instance()->RegisterProfTimerHandler(tag, handler);
}

static void StopHostProfTimer(TimerHandlerTag tag)
{
    TimerManager::instance()->RemoveProfTimerHandler(tag);
    TimerManager::instance()->StopProfTimer();
}

int32_t ProfHostDataBase::CheckHostProfiling(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) const
{
    CHECK_JOB_CONTEXT_PARAM_RET(cfg, return PROFILING_FAILED);
    if (!(cfg->comParams->params->hostProfiling)) {
        return PROFILING_NOTSUPPORT;
    }
    if (Platform::instance()->RunSocSide()) {
        MSPROF_LOGI("Not in host Side, host profiling not enabled");
        return PROFILING_NOTSUPPORT;
    }

#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
    MSPROF_LOGI("Currently, only the Linux environment is supported.");
    return PROFILING_NOTSUPPORT;
#endif
    return PROFILING_SUCCESS;
}

int32_t ProfHostDataBase::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_CONTEXT_PARAM_RET(cfg, return PROFILING_FAILED);
    const int32_t ret = CheckHostProfiling(cfg);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }
    collectionJobCfg_ = cfg;

    analysis::dvvp::transport::UploaderMgr::instance()->GetUploader(cfg->comParams->params->job_id, upLoader_);
    if (upLoader_ == nullptr) {
        MSPROF_LOGE("Failed to get host upLoader, job_id=%s", cfg->comParams->params->job_id.c_str());
        MSPROF_INNER_ERROR("EK9999", "Failed to get host upLoader, job_id=%s", cfg->comParams->params->job_id.c_str());
        return PROFILING_FAILED;
    }
    // default 20ms collecttion interval
    const uint32_t profStatIntervalMs = 20;  // 20 MS
    const uint32_t profMsToNs = 1000000;     // 1000000 NS
    sampleIntervalNs_ = (static_cast<unsigned long long>(profStatIntervalMs) * profMsToNs);
    return PROFILING_SUCCESS;
}

int32_t ProfHostDataBase::Uninit()
{
    upLoader_.reset();
    return PROFILING_SUCCESS;
}

ProfHostCpuJob::ProfHostCpuJob() : ProfHostDataBase() {}

ProfHostCpuJob::~ProfHostCpuJob() {}

int32_t ProfHostCpuJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_CONTEXT_PARAM_RET(cfg, return PROFILING_FAILED);
    const int32_t ret = ProfHostDataBase::Init(cfg);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }

    if (collectionJobCfg_->comParams->params->host_cpu_profiling.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("Host cpu profiling not enabled");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfHostCpuJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);

    SHARED_PTR_ALIA<ProcHostCpuHandler> cpuHandler;
    SHARED_PTR_ALIA<TimerAttr> attr = nullptr;
    MSVP_MAKE_SHARED4(attr, TimerAttr, PROF_HOST_PROC_CPU, 0, PROC_HOST_PROC_DATA_BUF_SIZE,
        sampleIntervalNs_, return PROFILING_FAILED);
    attr->retFileName = PROF_HOST_PROC_CPU_USAGE_FILE;
    MSVP_MAKE_SHARED4(cpuHandler, ProcHostCpuHandler, attr, collectionJobCfg_->comParams->params,
        collectionJobCfg_->comParams->jobCtx, upLoader_, return PROFILING_FAILED);
    if (cpuHandler->Init() != PROFILING_SUCCESS) {
        MSPROF_LOGE("HostCpuHandler Init Failed");
        MSPROF_INNER_ERROR("EK9999", "HostCpuHandler Init Failed");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("HostCpuHandler Init succ, sampleIntervalNs_:%" PRIu64, sampleIntervalNs_);

    StartHostProfTimer(PROF_HOST_PROC_CPU, cpuHandler);
    return PROFILING_SUCCESS;
}

int32_t ProfHostCpuJob::Uninit()
{
    StopHostProfTimer(PROF_HOST_PROC_CPU);
    (void)ProfHostDataBase::Uninit();
    return PROFILING_SUCCESS;
}

ProfHostMemJob::ProfHostMemJob() : ProfHostDataBase() {}

ProfHostMemJob::~ProfHostMemJob() {}

int32_t ProfHostMemJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_CONTEXT_PARAM_RET(cfg, return PROFILING_FAILED);
    const int32_t ret = ProfHostDataBase::Init(cfg);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }

    if (collectionJobCfg_->comParams->params->host_mem_profiling.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("Host memory profiling not enabled");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfHostMemJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);

    SHARED_PTR_ALIA<ProcHostMemHandler> memHandler;
    SHARED_PTR_ALIA<TimerAttr> attr = nullptr;
    MSVP_MAKE_SHARED4(attr, TimerAttr, PROF_HOST_PROC_MEM, 0, PROC_HOST_PROC_DATA_BUF_SIZE,
        sampleIntervalNs_, return PROFILING_FAILED);
    attr->retFileName = PROF_HOST_PROC_MEM_USAGE_FILE;
    MSVP_MAKE_SHARED4(memHandler, ProcHostMemHandler, attr, collectionJobCfg_->comParams->params,
        collectionJobCfg_->comParams->jobCtx, upLoader_, return PROFILING_FAILED);
    if (memHandler->Init() != PROFILING_SUCCESS) {
        MSPROF_LOGE("HostMemHandler Init Failed");
        MSPROF_INNER_ERROR("EK9999", "HostMemHandler Init Failed");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("HostMemHandler Init succ, sampleIntervalNs_:%" PRIu64, sampleIntervalNs_);

    StartHostProfTimer(PROF_HOST_PROC_MEM, memHandler);
    return PROFILING_SUCCESS;
}

int32_t ProfHostMemJob::Uninit()
{
    StopHostProfTimer(PROF_HOST_PROC_MEM);
    (void)ProfHostDataBase::Uninit();
    return PROFILING_SUCCESS;
}

ProfHostAllPidJob::ProfHostAllPidJob() : ProfHostDataBase() {}

ProfHostAllPidJob::~ProfHostAllPidJob() {}

int32_t ProfHostAllPidJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    const int32_t ret = ProfHostDataBase::Init(cfg);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }

    if (collectionJobCfg_->comParams->params->hostAllPidCpuProfiling.compare(MSVP_PROF_ON) == 0 &&
        collectionJobCfg_->comParams->params->hostAllPidMemProfiling.compare(MSVP_PROF_ON) == 0) {
        tag_ = PROF_HOST_ALL_PID;
    } else if (collectionJobCfg_->comParams->params->hostAllPidCpuProfiling.compare(MSVP_PROF_ON) == 0) {
        tag_ = PROF_HOST_ALL_PID_CPU;
    } else if (collectionJobCfg_->comParams->params->hostAllPidMemProfiling.compare(MSVP_PROF_ON) == 0) {
        tag_ = PROF_HOST_ALL_PID_MEM;
    } else {
        MSPROF_LOGI("hostAllPidCpuProfiling and hostAllPidMemProfiling not enabled");
        return PROFILING_FAILED;
    }
    sampleIntervalNs_ =
        static_cast<unsigned long long>(cfg->comParams->params->hostProfilingSamplingInterval) * MS_TO_NS;

    return PROFILING_SUCCESS;
}

int32_t ProfHostAllPidJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);

    SHARED_PTR_ALIA<ProcAllPidsFileHandler> pidsHandler;
    SHARED_PTR_ALIA<TimerAttr> attr = nullptr;
    MSVP_MAKE_SHARED4(attr, TimerAttr, tag_, collectionJobCfg_->comParams->devId, 0,
        sampleIntervalNs_, return PROFILING_FAILED);
    MSVP_MAKE_SHARED4(pidsHandler, ProcAllPidsFileHandler, attr, collectionJobCfg_->comParams->params,
        collectionJobCfg_->comParams->jobCtx, upLoader_, return PROFILING_FAILED);
    if (pidsHandler->Init() != PROFILING_SUCCESS) {
        MSPROF_LOGE("All pids handler cpu init fail");
        MSPROF_INNER_ERROR("EK9999", "pidsHandler Init Failed");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("All pids handler cpu init success, sampleIntervalNs_:%llu", sampleIntervalNs_);

    StartHostProfTimer(tag_, pidsHandler);
    return PROFILING_SUCCESS;
}

int32_t ProfHostAllPidJob::Uninit()
{
    StopHostProfTimer(tag_);
    (void)ProfHostDataBase::Uninit();
    return PROFILING_SUCCESS;
}

ProfHostNetworkJob::ProfHostNetworkJob() : ProfHostDataBase() {}

ProfHostNetworkJob::~ProfHostNetworkJob() {}

int32_t ProfHostNetworkJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_CONTEXT_PARAM_RET(cfg, return PROFILING_FAILED);
    const int32_t ret = ProfHostDataBase::Init(cfg);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }

    if (collectionJobCfg_->comParams->params->host_network_profiling.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("Host network profiling not enabled");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfHostNetworkJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);

    SHARED_PTR_ALIA<ProcHostNetworkHandler> networkHandler;
    SHARED_PTR_ALIA<TimerAttr> attr = nullptr;
    MSVP_MAKE_SHARED4(attr, TimerAttr, PROF_HOST_SYS_NETWORK, 0, PROC_HOST_PROC_DATA_BUF_SIZE,
        sampleIntervalNs_, return PROFILING_FAILED);
    attr->retFileName = PROF_HOST_SYS_NETWORK_USAGE_FILE;
    MSVP_MAKE_SHARED4(networkHandler, ProcHostNetworkHandler, attr, collectionJobCfg_->comParams->params,
        collectionJobCfg_->comParams->jobCtx, upLoader_, return PROFILING_FAILED);
    if (networkHandler->Init() != PROFILING_SUCCESS) {
        MSPROF_LOGE("HostNetworkHandler Init Failed");
        MSPROF_INNER_ERROR("EK9999", "HostNetworkHandler Init Failed");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("HostNetworkHandler Init succ, sampleIntervalNs_:%" PRIu64, sampleIntervalNs_);

    StartHostProfTimer(PROF_HOST_SYS_NETWORK, networkHandler);
    return PROFILING_SUCCESS;
}

int32_t ProfHostNetworkJob::Uninit()
{
    StopHostProfTimer(PROF_HOST_SYS_NETWORK);
    (void)ProfHostDataBase::Uninit();
    return PROFILING_SUCCESS;
}

ProfHostSysCallsJob::ProfHostSysCallsJob() : ProfHostDataBase() {}

ProfHostSysCallsJob::~ProfHostSysCallsJob() {}

int32_t ProfHostSysCallsJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_CONTEXT_PARAM_RET(cfg, return PROFILING_FAILED);
    int32_t ret = ProfHostDataBase::CheckHostProfiling(cfg);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }

    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->host_osrt_profiling.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("Host_syscalls_profiling not enabled");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfHostSysCallsJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(profHostService_, ProfHostService, return PROFILING_FAILED);

    int32_t ret = profHostService_->Init(collectionJobCfg_, PROF_HOST_SYS_CALL);
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("[ProfHostSysCallsJob]Failed Init profHostService_");
        MSPROF_INNER_ERROR("EK9999", "Failed Init profHostService_");
        return ret;
    }

    ret = profHostService_->Start();
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("[ProfHostSysCallsJob]Failed Start profHostService_");
        MSPROF_INNER_ERROR("EK9999", "Failed Start profHostService_");
        return ret;
    }
    return ret;
}

int32_t ProfHostSysCallsJob::Uninit()
{
    MSPROF_LOGI("Start ProfHostSysCallsJob Uninit");
    if (profHostService_ == nullptr) {
        MSPROF_LOGE("ProfHostSysCallsJob profHostService_ is null");
        MSPROF_INNER_ERROR("EK9999", "ProfHostSysCallsJob profHostService_ is null");
        return PROFILING_FAILED;
    }
    profHostService_->WakeupTimeoutEnd();
    int32_t ret = profHostService_->Stop();
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("[HostSysCalls]Failed Stop profHostService_");
        MSPROF_INNER_ERROR("EK9999", "[HostSysCalls]Failed Stop profHostService_");
    }
    return ret;
}

ProfHostPthreadJob::ProfHostPthreadJob() : ProfHostDataBase() {}

ProfHostPthreadJob::~ProfHostPthreadJob() {}

int32_t ProfHostPthreadJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_CONTEXT_PARAM_RET(cfg, return PROFILING_FAILED);
    int32_t ret = ProfHostDataBase::CheckHostProfiling(cfg);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }

    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->host_osrt_profiling.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("Host_pthread_profiling not enabled");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfHostPthreadJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(profHostService_, ProfHostService, return PROFILING_FAILED);

    int32_t ret = profHostService_->Init(collectionJobCfg_, PROF_HOST_SYS_PTHREAD);
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("[ProfHostPthreadJob]Failed Init profHostService_");
        MSPROF_INNER_ERROR("EK9999", "Failed Init profHostService_");
        return ret;
    }

    ret = profHostService_->Start();
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("[ProfHostPthreadJob]Failed Start profHostService_");
        MSPROF_INNER_ERROR("EK9999", "Failed Start profHostService_");
        return ret;
    }
    return ret;
}

int32_t ProfHostPthreadJob::Uninit()
{
    MSPROF_LOGI("Start ProfHostPthreadJob Uninit");
    if (profHostService_ == nullptr) {
        MSPROF_LOGE("ProfHostPthreadJob profHostService_ is null");
        MSPROF_INNER_ERROR("EK9999", "ProfHostPthreadJob profHostService_ is null");
        return PROFILING_FAILED;
    }
    profHostService_->WakeupTimeoutEnd();
    int32_t ret = profHostService_->Stop();
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("[HostPthread]Failed Stop profHostService_");
        MSPROF_INNER_ERROR("EK9999", "[HostPthread]Failed Stop profHostService_");
    }
    return ret;
}

ProfHostDiskJob::ProfHostDiskJob() : ProfHostDataBase() {}

ProfHostDiskJob::~ProfHostDiskJob() {}

int32_t ProfHostDiskJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_CONTEXT_PARAM_RET(cfg, return PROFILING_FAILED);
    int32_t ret = ProfHostDataBase::CheckHostProfiling(cfg);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }

    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->host_disk_profiling.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("Host_disk_profiling not enabled");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfHostDiskJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(profHostService_, ProfHostService, return PROFILING_FAILED);

    int32_t ret = profHostService_->Init(collectionJobCfg_, PROF_HOST_SYS_DISK);
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("[ProfHostDiskJob]Failed Init profHostService_");
        MSPROF_INNER_ERROR("EK9999", "Failed Init profHostService_");
        return ret;
    }

    ret = profHostService_->Start();
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("[ProfHostDiskJob]Failed Start profHostService_");
        MSPROF_INNER_ERROR("EK9999", "Failed Start profHostService_");
        return ret;
    }
    return ret;
}

int32_t ProfHostDiskJob::Uninit()
{
    MSPROF_LOGI("Start ProfHostDiskJob Uninit");
    if (profHostService_ == nullptr) {
        MSPROF_LOGE("ProfHostDiskJob profHostService_ is null");
        MSPROF_INNER_ERROR("EK9999", "ProfHostDiskJob profHostService_ is null");
        return PROFILING_FAILED;
    }
    profHostService_->WakeupTimeoutEnd();
    int32_t ret = profHostService_->Stop();
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("[HostDisk]Failed Stop profHostService_");
        MSPROF_INNER_ERROR("EK9999", "[HostDisk]Failed Stop profHostService_");
    }
    return ret;
}

ProfHostService::ProfHostService() : hostTimerTag_(PROF_HOST_MAX_TAG), hostProcess_(MSVP_PROCESS) {}

ProfHostService::~ProfHostService() {}

int32_t ProfHostService::GetCmdStr(int32_t hostSysPid, std::string &profHostCmd)
{
    int32_t ret = PROFILING_FAILED;
    switch (hostTimerTag_) {
        case PROF_HOST_SYS_CALL:
            ret = GetCollectSysCallsCmd(hostSysPid, profHostCmd);
            break;
        case PROF_HOST_SYS_PTHREAD:
            ret = GetCollectPthreadsCmd(hostSysPid, profHostCmd);
            break;
        case PROF_HOST_SYS_DISK:
            ret = GetCollectIOTopCmd(hostSysPid, profHostCmd);
            break;
        default:
            break;
    }
    return ret;
}

/**
 * Start the collection tool process.
 */
int32_t ProfHostService::Process()
{
    std::string profHostCmd;
    int32_t hostSysPid = collectionJobCfg_->comParams->params->host_sys_pid;
    int32_t ret = GetCmdStr(hostSysPid, profHostCmd);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Get profHostCmd failed,toolName:%s", toolName_.c_str());
        MSPROF_INNER_ERROR("EK9999", "Get profHostCmd failed,toolName:%s", toolName_.c_str());
        return PROFILING_FAILED;
    }
    if (profHostCmd.size() > 0) {
        MSPROF_LOGI("Begin to start profiling:%s,cmd=%s", toolName_.c_str(), profHostCmd.c_str());
        std::vector<std::string> params = analysis::dvvp::common::utils::Utils::Split(profHostCmd.c_str());
        if (params.empty()) {
            MSPROF_LOGE("profHostCmd:%s empty", toolName_.c_str());
            MSPROF_INNER_ERROR("EK9999", "profHostCmd:%s empty", toolName_.c_str());
            return PROFILING_FAILED;
        }
        std::string cmd = params[0];
        std::vector<std::string> argsV;
        std::vector<std::string> envsV;
        if (params.size() > 1) {
            argsV.assign(params.begin() + 1, params.end());
        }
        envsV.push_back("PATH=/usr/bin/:/usr/sbin:/var");
        hostProcess_ = MSVP_PROCESS;
        int32_t exitCode = analysis::dvvp::common::utils::INVALID_EXIT_CODE;
        std::string redirectionPath = profHostOutDir_ + MSVP_PROF_PERF_RET_FILE_SUFFIX;
        hostWriteDoneInfo_.startTime = std::to_string(analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw());
        ExecCmdParams execCmdParams(cmd, true, redirectionPath);
        ret = analysis::dvvp::common::utils::Utils::ExecCmd(execCmdParams, argsV, envsV, exitCode, hostProcess_);
        MSPROF_LOGI("start profiling host job %s, pid = %d, ret=%d", toolName_.c_str(), hostProcess_, ret);
        FUNRET_CHECK_FAIL_PRINT(ret != PROFILING_SUCCESS);
    }
    ret = WaitCollectToolStart();
    return ret;
}

int32_t ProfHostService::KillToolAndWaitHostProcess() const
{
    static const std::string ENV_PATH = "PATH=/usr/bin:/usr/sbin";
    std::vector<std::string> envV;
    envV.push_back(ENV_PATH);
    std::vector<std::string> argsV;
    argsV.push_back(PROF_SCRIPT_FILE_PATH);
    argsV.push_back("pkill");
    argsV.push_back(toolName_);
    int32_t exitCode = analysis::dvvp::common::utils::VALID_EXIT_CODE;
    static const std::string CMD = "sudo";
    OsalProcess appProcess = MSVP_PROCESS;
    ExecCmdParams execCmdParams(CMD, false, "");
    int32_t ret = analysis::dvvp::common::utils::Utils::ExecCmd(execCmdParams, argsV, envV, exitCode, appProcess);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to kill process %s, ret=%d, exitCode=%d", toolName_.c_str(), ret, exitCode);
        MSPROF_INNER_ERROR("EK9999", "Failed to kill process %s, ret=%d, exitCode=%d", toolName_.c_str(), ret,
                           exitCode);
        return ret;
    }
    if (hostProcess_ > 0) {
        bool isExited = false;
        ret = analysis::dvvp::common::utils::Utils::WaitProcess(hostProcess_, isExited, exitCode, true);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to wait process %d, ret=%d,  exitCode=%d", hostProcess_, ret, exitCode);
            MSPROF_INNER_ERROR("EK9999", "Failed to wait process %d, ret=%d, exitCode=%d", hostProcess_, ret, exitCode);
            return ret;
        } else {
            MSPROF_LOGI("Process %d exited, exitcode=%d", hostProcess_, exitCode);
            if (exitCode != 0) {
                MSPROF_LOGE("An error has occurred in process %s, error info: %s.", toolName_.c_str(),
                            strerror(exitCode));
            }
        }
    }
    return PROFILING_SUCCESS;
}

/**
 *  Stop collection tool process.
 */
int32_t ProfHostService::Uninit()
{
    int32_t ret = KillToolAndWaitHostProcess();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGI("Failed to kill process %s, ", toolName_.c_str());
        return ret;
    }
    MSPROF_LOGI("Succeeded to kill process %s", toolName_.c_str());
    ret = WaitCollectToolEnd();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGW("Unable to wait process %s", toolName_.c_str());
    }
    if (hostTimerTag_ == PROF_HOST_SYS_DISK) {
        std::string fileName = profHostOutDir_ + MSVP_PROF_PERF_RET_FILE_SUFFIX;
        std::string diskIoStartTime = "start_time " + hostWriteDoneInfo_.startTime + "\n";
        std::ofstream in;
        in.open(fileName, std::ios::app);
        if (!in.is_open()) {
            MSPROF_LOGE("Failed to open %s", fileName.c_str());
            MSPROF_INNER_ERROR("EK9999", "Failed to open %s", fileName.c_str());
            return PROFILING_FAILED;
        }
        in << diskIoStartTime;
        in.close();
    }
    StoreData();  // upload collect data
    return PROFILING_SUCCESS;
}

int32_t ProfHostService::GetCollectSysCallsCmd(int32_t pid, std::string &profHostCmd)
{
    if (pid < 0) {
        MSPROF_LOGE("ProfHostSysCallsJob pid: %d is invalid.", pid);
        MSPROF_INNER_ERROR("EK9999", "ProfHostSysCallsJob pid: %d is invalid.", pid);
        return PROFILING_FAILED;
    }

    std::stringstream ssPerfHostCmd;
    ssPerfHostCmd << "sudo ";
    ssPerfHostCmd << PROF_SCRIPT_FILE_PATH;
    ssPerfHostCmd << " perf ";
    ssPerfHostCmd << pid;

    profHostCmd = ssPerfHostCmd.str();
    startProcessCmd_ = "perf trace -T --syscalls";
    return PROFILING_SUCCESS;
}

int32_t ProfHostService::GetCollectPthreadsCmd(int32_t pid, std::string &profHostCmd)
{
    if (pid < 0) {
        MSPROF_LOGE("ProfHostPthreadJob pid: %d is invalid.", pid);
        MSPROF_INNER_ERROR("EK9999", "ProfHostPthreadJob pid: %d is invalid.", pid);
        return PROFILING_FAILED;
    }

    std::stringstream ssPerfHostCmd;
    ssPerfHostCmd << "sudo ";
    ssPerfHostCmd << PROF_SCRIPT_FILE_PATH;
    ssPerfHostCmd << " ltrace ";
    ssPerfHostCmd << pid;

    profHostCmd = ssPerfHostCmd.str();
    startProcessCmd_ = "ltrace -ttt -T -e pthread_";
    return PROFILING_SUCCESS;
}

int32_t ProfHostService::GetCollectIOTopCmd(int32_t pid, std::string &profHostCmd)
{
    if (pid < 0) {
        MSPROF_LOGE("ProfHostDiskJob pid: %d is invalid.", pid);
        MSPROF_INNER_ERROR("EK9999", "ProfHostDiskJob pid: %d is invalid.", pid);
        return PROFILING_FAILED;
    }
    std::stringstream ssPerfHostCmd;
    ssPerfHostCmd << "sudo ";
    ssPerfHostCmd << PROF_SCRIPT_FILE_PATH;
    ssPerfHostCmd << " iotop ";
    ssPerfHostCmd << pid;

    profHostCmd = ssPerfHostCmd.str();
    startProcessCmd_ = "iotop -b -d";
    return PROFILING_SUCCESS;
}

int32_t ProfHostService::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg, const HostTimerHandlerTag hostTimerTag)
{
    CHECK_JOB_CONTEXT_PARAM_RET(cfg, return PROFILING_FAILED);
    if (hostTimerTag < PROF_HOST_SYS_CALL || hostTimerTag >= PROF_HOST_MAX_TAG) {
        MSPROF_LOGI("hostTimerTag invalid");
        return PROFILING_FAILED;
    }

    MSVP_MAKE_SHARED0(collectionJobCfg_, CollectionJobCfg, return PROFILING_FAILED);
    collectionJobCfg_ = cfg;
    hostTimerTag_ = hostTimerTag;
    toolName_ = PROF_HOST_TOOL_NAME[hostTimerTag_];
    profHostOutDir_ = collectionJobCfg_->comParams->tmpResultDir + PROF_HOST_OUTDATA[hostTimerTag_];
    isStarted_ = true;
    MSPROF_LOGI("Init ProfHostService success, profHostOutDir: %s", profHostOutDir_.c_str());
    return PROFILING_SUCCESS;
}

int32_t ProfHostService::Start()
{
    MSPROF_LOGI("Start ProfHostService begin, toolName:%s", toolName_.c_str());
    if (!isStarted_) {
        MSPROF_LOGE("ProfHostService not started, toolName:%s", toolName_.c_str());
        MSPROF_INNER_ERROR("EK9999", "ProfHostService not started, toolName:%s", toolName_.c_str());
        return PROFILING_FAILED;
    }
    std::string threadName = "MSVP_PORF_HOST_TOOL_TIMER";
    analysis::dvvp::common::thread::Thread::SetThreadName(threadName);
    int32_t ret = analysis::dvvp::common::thread::Thread::Start();
    if (ret != PROFILING_SUCCESS) {
        isStarted_ = false;
        MSPROF_LOGE("Thread start failed, toolName:%s", toolName_.c_str());
        MSPROF_INNER_ERROR("EK9999", "Thread start failed, toolName:%s", toolName_.c_str());
        return PROFILING_FAILED;
    }

    MSPROF_LOGI("Start ProfHostService success, toolName:%s", toolName_.c_str());
    return PROFILING_SUCCESS;
}

int32_t ProfHostService::Stop()
{
    MSPROF_LOGI("Stop ProfHostService begin, toolName:%s", toolName_.c_str());
    if (!isStarted_) {
        MSPROF_LOGE("ProfHostService not started, toolName:%s", toolName_.c_str());
        MSPROF_INNER_ERROR("EK9999", "ProfHostService not started, toolName:%s", toolName_.c_str());
        return PROFILING_FAILED;
    }
    isStarted_ = false;

    int32_t ret = analysis::dvvp::common::thread::Thread::Stop();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Thread stop failed, toolName:%s", toolName_.c_str());
        MSPROF_INNER_ERROR("EK9999", "Thread stop failed, toolName:%s", toolName_.c_str());
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("Stop ProfHostService success, toolName:%s", toolName_.c_str());

    return PROFILING_SUCCESS;
}

void ProfHostService::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);
    int32_t ret = Process();
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("The run toolName:%s process failed.", toolName_.c_str());
        MSPROF_INNER_ERROR("EK9999", "The run toolName:%s process failed.", toolName_.c_str());
        return;
    }
    std::string fileName = profHostOutDir_ + MSVP_PROF_PERF_RET_FILE_SUFFIX;
    MSPROF_LOGI("Run ProfHostService Task, fileName: %s", fileName.c_str());
    do {
        int64_t len = analysis::dvvp::common::utils::Utils::GetFileSize(fileName);
        if (len > MSVP_SMALL_FILE_MAX_LEN) {
            Handler();
            MSPROF_LOGI("The file:%s data is too large, and the file is fragmented.", fileName.c_str());
        }
        WaitTimeoutEnd();
    } while (isStarted_);
    Uninit();
}

/**
 *  When the data volume is too large,
 *  stop the current collection process and then start a new collection process.
 */
int32_t ProfHostService::Handler()
{
    MSPROF_LOGI("Run Handler start");
    int32_t ret = Uninit();
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGW("The toolName:%s Uninit did not complete successfully.", toolName_.c_str());
    }
    ret = Process();
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("The toolName:%s process failed.", toolName_.c_str());
        MSPROF_INNER_ERROR("EK9999", "The toolName:%s process failed.", toolName_.c_str());
    }
    return ret;
}

void ProfHostService::StoreData() const
{
    std::string txtFileName = profHostOutDir_ + MSVP_PROF_PERF_RET_FILE_SUFFIX;
    std::string uploadFileName = PROF_HOST_OUTDATA[hostTimerTag_];
    txtFileName = Utils::CanonicalizePath(txtFileName);
    FUNRET_CHECK_EXPR_ACTION(txtFileName.empty(), return,
        "The txtFileName: %s does not exist or permission denied.", txtFileName.c_str());
    std::ifstream ifs(txtFileName, std::ifstream::in);
    if (!ifs.is_open()) {
        return;
    }
    // This file is about 2MB and does not need to be split.
    SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx = collectionJobCfg_->comParams->jobCtx;
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params = collectionJobCfg_->comParams->params;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk;
    MSVP_MAKE_SHARED0(fileChunk, analysis::dvvp::ProfileFileChunk, return );
    fileChunk->fileName = Utils::PackDotInfo(uploadFileName, jobCtx->tag);
    fileChunk->offset = -1;
    fileChunk->chunk = std::string(std::istreambuf_iterator<char>(ifs), std::istreambuf_iterator<char>());
    fileChunk->chunkSize = fileChunk->chunk.size();
    fileChunk->isLastChunk = false;
    fileChunk->chunkModule = FileChunkDataModule::PROFILING_IS_FROM_MSPROF_HOST;
    fileChunk->extraInfo = Utils::PackDotInfo(jobCtx->job_id, jobCtx->dev_id);
    if (fileChunk->chunkSize != 0) {
        if (analysis::dvvp::transport::UploaderMgr::instance()->UploadData(params->job_id, fileChunk) !=
            PROFILING_SUCCESS) {
            MSPROF_LOGE("Upload host server data failed , jobId: %s, fileName: %s", params->job_id.c_str(),
                        uploadFileName.c_str());
            MSPROF_INNER_ERROR("EK9999", "Upload host server data failed , jobId: %s, fileName: %s",
                               params->job_id.c_str(), uploadFileName.c_str());
        }
    }

    ifs.close();
    MSPROF_LOGI("ProfHostService success to store data, fileName: %s", uploadFileName.c_str());
    (void)::remove(txtFileName.c_str());
}

void ProfHostService::PrintFileContent(const std::string filePath) const
{
    std::string context;
    std::ifstream psFile;
    std::string canonicalizedPath = Utils::CanonicalizePath(filePath);
    FUNRET_CHECK_EXPR_ACTION(canonicalizedPath.empty(), return,
        "The filePath: %s does not exist or permission denied.", filePath.c_str());
    psFile.open(canonicalizedPath, std::ifstream::in);
    if (psFile.is_open()) {
        while (getline(psFile, context)) {
            MSPROF_LOGD("File:%s, context:%s", canonicalizedPath.c_str(), context.c_str());
        }
        psFile.close();
    } else {
        MSPROF_LOGE("File:%s, open failed", canonicalizedPath.c_str());
    }
}

int32_t ProfHostService::CollectToolIsRun()
{
    int32_t hostSysPid = collectionJobCfg_->comParams->params->host_sys_pid;
    std::string checkToolRunCmd =
        "ps -ef | grep \"" + startProcessCmd_ + "\" | grep -v grep | grep " + std::to_string(hostSysPid);
    std::vector<std::string> envV;
    envV.push_back("PATH=/usr/bin:/usr/sbin");
    std::vector<std::string> argsV;
    argsV.push_back("-c");
    argsV.push_back(checkToolRunCmd);
    int32_t exitCode = VALID_EXIT_CODE;
    OsalProcess appProcess = MSVP_PROCESS;
    std::string redirectionPath = profHostOutDir_ + ".slice_temp" + std::to_string(Utils::GetClockRealtime());
    ExecCmdParams execCmdParams("sh", false, redirectionPath);
    const int32_t ret = analysis::dvvp::common::utils::Utils::ExecCmd(execCmdParams, argsV, envV, exitCode, appProcess);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to check process %s, ret=%d", toolName_.c_str(), ret);
        MSPROF_INNER_ERROR("EK9999", "Failed to check process %s, ret=%d", toolName_.c_str(), ret);
        return ret;
    }
    for (int32_t i = 0; i < FILE_FIND_REPLAY; ++i) {
        if (!(Utils::IsFileExist(redirectionPath))) {
            OsalSleep(1);  // If the file is not found, the delay is 1 ms.
            continue;
        } else {
            break;
        }
    }
    if (!(Utils::IsFileExist(redirectionPath))) {
        MSPROF_LOGE("The file:%s is not exist", redirectionPath.c_str());
        MSPROF_INNER_ERROR("EK9999", "The file:%s is not exist", redirectionPath.c_str());
        return PROFILING_FAILED;
    }
    PrintFileContent(redirectionPath);
    const int64_t len = Utils::GetFileSize(redirectionPath);
    OsalUnlink(redirectionPath.c_str());
    if (len > 0) {
        return PROFILING_SUCCESS;
    }
    MSPROF_LOGI("The tool:%s is not running", toolName_.c_str());
    return PROFILING_FAILED;
}

int32_t ProfHostService::WaitCollectToolStart()
{
    int32_t ret = PROFILING_FAILED;
    for (int32_t i = 0; i < FILE_FIND_REPLAY; ++i) {
        ret = CollectToolIsRun();
        if (ret != PROFILING_SUCCESS) {
            continue;
        } else {
            break;
        }
    }
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("Failed to start the process: %s", toolName_.c_str());
        MSPROF_INNER_ERROR("EK9999", "Failed to start the process: %s", toolName_.c_str());
    }
    return ret;
}

int32_t ProfHostService::WaitCollectToolEnd()
{
    int32_t ret = PROFILING_FAILED;
    for (int32_t i = 0; i < FILE_FIND_REPLAY; ++i) {
        ret = CollectToolIsRun();
        if (ret == PROFILING_SUCCESS) {
            continue;
        } else {
            break;
        }
    }
    if (ret == PROFILING_SUCCESS) {
        MSPROF_LOGW("Unable to end the process: %s", toolName_.c_str());
        ret = PROFILING_FAILED;
    } else {
        ret = PROFILING_SUCCESS;
    }
    return ret;
}

void ProfHostService::WakeupTimeoutEnd()
{
    std::lock_guard<std::mutex> lk(needUnintMtx_);
    isJobUnint_.notify_all();
}

void ProfHostService::WaitTimeoutEnd()
{
    MSPROF_LOGI("Wakeup Unint start");
    std::unique_lock<std::mutex> lk(needUnintMtx_);
    static const int32_t CHECK_FILE_SIZE_INTERVAL_US = 500000;  // 500000 means 500 ms
    const auto res = isJobUnint_.wait_for(lk, std::chrono::microseconds(CHECK_FILE_SIZE_INTERVAL_US));
    if (res == std::cv_status::timeout) {
        MSPROF_LOGI("Wakeup Unint timeout");
        return;
    }
}
}
}
}
