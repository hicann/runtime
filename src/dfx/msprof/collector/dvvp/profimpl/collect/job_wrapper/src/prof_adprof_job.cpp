/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_adprof_job.h"
#include "collection_job.h"
#include "platform/platform.h"
#include "osal.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Platform;
const std::string LIBTSD_LIB_PATH = "libtsdclient.so";
const char * const ADPROF_EVENT_MSG_GRP_NAME = "prof_adprof_grp";
constexpr uint32_t PROCESS_NUM = 1;

ProfAdprofJob::ProfAdprofJob() : channelId_(PROF_CHANNEL_ADPROF),
    procStatusParam_{0, TSD_SUB_PROC_ADPROF, SUB_PROCESS_STATUS_MAX},
    eventAttr_{0, channelId_, ADPROF_COLLECTION_JOB, false, false, false, false, 0, false, false, nullptr},
    processCount_(0), phyId_(0)
{
}

ProfAdprofJob::~ProfAdprofJob()
{
    if (tsdLibHandle_ != nullptr) {
        OsalDlclose(tsdLibHandle_);
    }
}

int32_t ProfAdprofJob::InitAdprof()
{
    if (LoadTsdApi() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to load tsd api");
        return PROFILING_FAILED;
    }

    bool result = false;
    uint32_t ret = tsdCapabilityGet_(collectionJobCfg_->comParams->devId, TSD_CAPABILITY_ADPROF,
                                     reinterpret_cast<uint64_t>(&result));
    if (ret != tsd::TSD_OK || !result) {
        MSPROF_LOGW("Tsd client not support adprof");
        return PROFILING_FAILED;
    }

    eventAttr_.deviceId = collectionJobCfg_->comParams->devId;
    eventAttr_.grpName = ADPROF_EVENT_MSG_GRP_NAME;
    ret = profDrvEvent_.SubscribeEventThreadInit(&eventAttr_);
    if (ret != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }

    ProcOpenArgs procOpenArgs = {TSD_SUB_PROC_ADPROF, nullptr, 0, nullptr, 0, nullptr, 0, nullptr};
    BuildSysProfCmdArg(procOpenArgs);
    pid_t adprofPid = 0;
    procOpenArgs.subPid = &adprofPid;
    ret = tsdProcessOpen_(collectionJobCfg_->comParams->devId, &procOpenArgs);
    if (ret != tsd::TSD_OK) {
        MSPROF_LOGE("Call TsdProcessOpen failed, ret:%d, devId:%d", ret, collectionJobCfg_->comParams->devId);
        return PROFILING_FAILED;
    }
    procStatusParam_.pid = adprofPid;

    ret = tsdGetProcListStatus_(collectionJobCfg_->comParams->devId, &procStatusParam_, PROCESS_NUM);
    if (ret != tsd::TSD_OK) {
        MSPROF_LOGE("Call TsdGetProcListStatus Failure, ret:%d, devId:%d", ret, collectionJobCfg_->comParams->devId);
        return PROFILING_FAILED;
    }
    if (procStatusParam_.curStat != SUB_PROCESS_STATUS_NORMAL) {
        MSPROF_LOGE("Adprof status '%d' not normal, devId:%d",
            static_cast<int32_t>(procStatusParam_.curStat), collectionJobCfg_->comParams->devId);
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

int32_t ProfAdprofJob::LoadTsdApi()
{
    tsdLibHandle_ = OsalDlopen(LIBTSD_LIB_PATH.c_str(), RTLD_LAZY | RTLD_NODELETE);
    if (tsdLibHandle_ == nullptr) {
        MSPROF_LOGE("Failed to load tsd library, dlopen error: %s", OsalDlerror());
        return PROFILING_FAILED;
    }
    tsdCapabilityGet_ = reinterpret_cast<TsdCapabilityGetFunc>(OsalDlsym(tsdLibHandle_, "TsdCapabilityGet"));
    if (tsdCapabilityGet_ == nullptr) {
        MSPROF_LOGE("Failed to dlsym TsdCapabilityGet");
        return PROFILING_FAILED;
    }
    tsdProcessOpen_ = reinterpret_cast<TsdProcessOpenFunc>(OsalDlsym(tsdLibHandle_, "TsdProcessOpen"));
    if (tsdProcessOpen_ == nullptr) {
        MSPROF_LOGE("Failed to dlsym TsdProcessOpen");
        return PROFILING_FAILED;
    }
    tsdGetProcListStatus_ = reinterpret_cast<TsdGetProcListStatusFunc>(OsalDlsym(tsdLibHandle_,
                                                                                 "TsdGetProcListStatus"));
    if (tsdGetProcListStatus_ == nullptr) {
        MSPROF_LOGE("Failed to dlsym TsdGetProcListStatus");
        return PROFILING_FAILED;
    }
    processCloseSubProcList_ = reinterpret_cast<ProcessCloseSubProcListFunc>(OsalDlsym(tsdLibHandle_,
                                                                                       "ProcessCloseSubProcList"));
    if (processCloseSubProcList_ == nullptr) {
        MSPROF_LOGE("Failed to dlsym ProcessCloseSubProcList");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

void ProfAdprofJob::BuildSysProfCmdArg(ProcOpenArgs &procOpenArgs)
{
    cmdVec_.emplace_back("adprof");
    cmdVec_.emplace_back("host_pid:" + std::to_string(Utils::GetPid()));
    cmdVec_.emplace_back("dev_id:" + std::to_string(phyId_)); // set physical device id
    cmdVec_.emplace_back("profiling_period:" + std::to_string(collectionJobCfg_->comParams->params->profiling_period));
    if (collectionJobCfg_->comParams->params->cpu_profiling == MSVP_PROF_ON) {
        cmdVec_.emplace_back("cpu_profiling:" + collectionJobCfg_->comParams->params->cpu_profiling);
        cmdVec_.emplace_back("aiCtrlCpuProfiling:" + collectionJobCfg_->comParams->params->aiCtrlCpuProfiling);
        cmdVec_.emplace_back("ai_ctrl_cpu_profiling_events:" +
            collectionJobCfg_->comParams->params->ai_ctrl_cpu_profiling_events);
        cmdVec_.emplace_back("cpu_sampling_interval:" +
            std::to_string(collectionJobCfg_->comParams->params->cpu_sampling_interval));
        cmdVec_.emplace_back("hscb:" + collectionJobCfg_->comParams->params->hscb);
    }
    if (collectionJobCfg_->comParams->params->sys_profiling == MSVP_PROF_ON) {
        cmdVec_.emplace_back("sys_profiling:" + collectionJobCfg_->comParams->params->sys_profiling);
        cmdVec_.emplace_back("sys_sampling_interval:" +
            std::to_string(collectionJobCfg_->comParams->params->sys_sampling_interval));
    }
    if (collectionJobCfg_->comParams->params->pid_profiling == MSVP_PROF_ON) {
        cmdVec_.emplace_back("pid_profiling:" + collectionJobCfg_->comParams->params->pid_profiling);
        cmdVec_.emplace_back("pid_sampling_interval:" +
            std::to_string(collectionJobCfg_->comParams->params->pid_sampling_interval));
    }
    params_.reserve(cmdVec_.size());
    for (uint32_t i = 0; i < cmdVec_.size(); i++) {
        params_[i].paramInfo = cmdVec_[i].c_str();
        params_[i].paramLen = cmdVec_[i].size();
    }

    procOpenArgs.extParamList = params_.data();
    procOpenArgs.extParamCnt = cmdVec_.size();
}

int32_t ProfAdprofJob::Process()
{
    CHECK_JOB_CONTEXT_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    MSPROF_LOGI("Begin to start profiling adprof");

    if (!eventAttr_.isChannelValid) {
        MSPROF_LOGI("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId, channelId_);
        return PROFILING_SUCCESS;
    }

    // ensure only done once
    uint8_t expected = 0;
    if (!processCount_.compare_exchange_strong(expected, 1)) {
        MSPROF_LOGI("Only process once");
        return PROFILING_SUCCESS;
    }

    std::string filePath = BindFileWithChannel(collectionJobCfg_->jobParams.dataPath);
    AddReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId_, filePath);

    const int32_t drvRet = DrvAdprofStart(collectionJobCfg_->comParams->devId, channelId_);
    FUNRET_CHECK_RET_VAL(drvRet != PROFILING_SUCCESS);
    eventAttr_.isProcessRun = true;
    MSPROF_LOGI("Start profiling adprof, ret=%d", drvRet);
    return drvRet;
}

void ProfAdprofJob::CloseAdprof() const
{
    uint32_t ret = processCloseSubProcList_(collectionJobCfg_->comParams->devId, &procStatusParam_, PROCESS_NUM);
    FUNRET_CHECK_EXPR_LOGW(ret != tsd::TSD_OK && ret != tsd::TSD_HDC_CLIENT_CLOSED_EXTERNAL, 
        "Close adprof process unexpectedly, ret:%u devId:%d", ret, collectionJobCfg_->comParams->devId);
}

int32_t ProfAdprofJob::Uninit()
{
    CHECK_JOB_CONTEXT_PARAM_RET(collectionJobCfg_, return PROFILING_SUCCESS);

    eventAttr_.isExit = true;
    if (eventAttr_.isThreadStart) {
        if (OsalJoinTask(&eventAttr_.handle) != OSAL_EN_OK) {
            MSPROF_LOGW("Event thread not exist");
        } else {
            MSPROF_LOGI("Adprof event thread exit");
        }
    }
    if (eventAttr_.isAttachDevice) {
        profDrvEvent_.SubscribeEventThreadUninit(static_cast<uint32_t>(collectionJobCfg_->comParams->devId));
    }

    if (!eventAttr_.isProcessRun) {
        MSPROF_LOGI("ProfAdprofJob Process is not run, return");
        return PROFILING_SUCCESS;
    }

    int32_t ret = DrvStop(collectionJobCfg_->comParams->devId, channelId_);
    MSPROF_LOGI("Stop profiling Channel %d data, ret=%d", static_cast<int32_t>(channelId_), ret);

    CloseAdprof();

    RemoveReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId_);
    return ret;
}
}
}
}