/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dyn_prof_thread.h"
#include "config.h"
#include "utils/utils.h"
#include "errno/error_code.h"
#include "message/prof_params.h"
#include "prof_acl_mgr.h"
#include "prof_manager.h"
#include "prof_ge_core.h"
#include "msprof_dlog.h"
#include "msprofiler_impl.h"

namespace Collector {
namespace Dvvp {
namespace DynProf {
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::thread;
using namespace Analysis::Dvvp::MsprofErrMgr;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::host;

DynProfThread::DynProfThread() : started_(false), profStarted_(false), delayTime_(0), durationTime_(0),
    durationSet_(false)
{
}

DynProfThread::~DynProfThread()
{
    Stop();
}

/**
 * @brief Get and set delay and duration time input by user
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
int32_t DynProfThread::GetDelayAndDurationTime()
{
    MSPROF_GET_ENV(MM_ENV_PROFILER_SAMPLECONFIG, msprofEnvCfg_);
    if (msprofEnvCfg_.empty()) {
        MSPROF_LOGE("Failed to get profiling sample config");
        return PROFILING_FAILED;
    }
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params;
    MSVP_MAKE_SHARED0(params, analysis::dvvp::message::ProfileParams, return PROFILING_FAILED);
    if (!params->FromString(msprofEnvCfg_)) {
        MSPROF_LOGE("ProfileParams Parse Failed %s", msprofEnvCfg_.c_str());
        return PROFILING_FAILED;
    }
    if (params->delayTime.empty() && params->durationTime.empty()) {
        MSPROF_LOGE("Switch delay and duration both not set in dynamic profiling mode");
        return PROFILING_FAILED;
    }
    if (!params->delayTime.empty() && !Utils::StrToUint32(delayTime_, params->delayTime)) {
        MSPROF_LOGE("Switch delay value %s is invalid", params->delayTime.c_str());
        return PROFILING_FAILED;
    }
    if (!params->durationTime.empty()) {
        if (!Utils::StrToUint32(durationTime_, params->durationTime)) {
            MSPROF_LOGE("Switch duration value %s is invalid", params->durationTime.c_str());
            return PROFILING_FAILED;
        }
        durationSet_ = true;
    }
    MSPROF_LOGI("Dynamic profiling delay time: %us, duration time: %us", delayTime_, durationTime_);
    return PROFILING_SUCCESS;
}

/**
 * @brief Start dynamic delay or duration thread
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
int32_t DynProfThread::Start()
{
    if (started_) {
        MSPROF_LOGW("Dynamic profiling thread has been started!");
        return PROFILING_SUCCESS;
    }
    if (GetDelayAndDurationTime() != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    Thread::SetThreadName("MSVP_DYN_PROF");
    if (Thread::Start() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to start dynamic profiling thread");
        return PROFILING_FAILED;
    }
    started_ = true;
    return PROFILING_SUCCESS;
}

/**
 * @brief Run dynamic delay or duration thread, Wait for the specified time
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
void DynProfThread::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);
    std::unique_lock<std::mutex> lk(threadStopMtx_);
    MSPROF_LOGI("Wait dynamic profiling start after %us", delayTime_);
    auto status = cvThreadStop_.wait_for(lk, std::chrono::seconds(delayTime_));
    if (status != std::cv_status::timeout) {
        MSPROF_LOGI("Receive profiling stop signal");
        started_ = false;
        return;
    }
    StartProfTask();
    if (!durationSet_) { // if duration not set, return and wait task stop
        started_ = false;
        return;
    }
    MSPROF_LOGI("Wait dynamic profiling end after %us", durationTime_);
    status = cvThreadStop_.wait_for(lk, std::chrono::seconds(durationTime_));
    if (status != std::cv_status::timeout) {
        MSPROF_LOGI("Receive profiling stop signal");
    }

    StopProfTask();
    started_ = false;
}

/**
 * @brief Stop dynamic delay or duration thread and notify thread to interrupt waiting
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
int32_t DynProfThread::Stop()
{
    if (started_) {
        {
            std::lock_guard<std::mutex> lk(threadStopMtx_);
            cvThreadStop_.notify_one();
        }
        if (Thread::Stop() != PROFILING_SUCCESS) {
            MSPROF_LOGE("Dynamic profiling thread stop failed");
        }
        started_ = false;
    }
    MSPROF_LOGI("Stop dynamic profiling Thread");
    return PROFILING_SUCCESS;
}

/**
 * @brief Start dynamic delay or duration profiling task
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
int32_t DynProfThread::StartProfTask()
{
    std::unique_lock<std::mutex> lk(devMtx_);
    MSPROF_LOGI("Dynamic profiling begin to start");
    if (devicesInfo_.empty()) {
        MSPROF_LOGW("No devices for dynamic profiling devices, maybe MsprofNotifySetdevice not called");
    }
    int32_t ret = Msprofiler::Api::ProfAclMgr::instance()->MsprofInitAclEnv(msprofEnvCfg_);
    if (ret != MSPROF_ERROR_NONE) {
        MSPROF_LOGE("Dynamic profiling start MsprofInitAclEnv failed, ret=%d.", ret);
        return PROFILING_FAILED;
    }
 
    if (Msprofiler::Api::ProfAclMgr::instance()->Init() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Dynamic profiling failed to init acl manager");
        Msprofiler::Api::ProfAclMgr::instance()->SetModeToOff();
        return PROFILING_FAILED;
    }
    Msprofiler::Api::ProfAclMgr::instance()->MsprofTxHandle();

    std::unique_lock<std::mutex> devLk(devInfoMtx_, std::defer_lock);
    devLk.lock();
    std::vector<DynProfDeviceInfo> notifyInfo;
    for (auto iter = devicesInfo_.begin(); iter != devicesInfo_.end(); iter++) {
        notifyInfo.push_back(iter->second);
    }
    devLk.unlock();

    for (auto &devInfo : notifyInfo) {
        ret = Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(devInfo.chipId, devInfo.devId, devInfo.isOpenDevice);
        if (ret != MSPROF_ERROR_NONE) {
            MSPROF_LOGE("Dynamic profiling start set device failed, ret=%d.", ret);
            return PROFILING_FAILED;
        }
    }

    profStarted_ = true;
    MSPROF_LOGI("Dynamic profiling start successfully");
    return PROFILING_SUCCESS;
}

/**
 * @brief Stop dynamic delay or duration profiling task
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
int32_t DynProfThread::StopProfTask()
{
    MSPROF_LOGI("Dynamic profiling begin to stop");
    const int32_t ret = Msprofiler::Api::ProfAclMgr::instance()->MsprofFinalizeHandle();
    if (ret != MSPROF_ERROR_NONE) {
        MSPROF_LOGE("Dynamic profiling stop MsprofFinalizeHandle failed, ret=%d.", ret);
        return PROFILING_FAILED;
    }
    profStarted_ = false;
    MSPROF_LOGI("Dynamic profiling stop successfully");
    return PROFILING_SUCCESS;
}

/**
 * @brief Save device infomation when user set device
 */
void DynProfThread::SaveDevicesInfo(DynProfDeviceInfo data)
{
    std::unique_lock<std::mutex> devLk(devInfoMtx_);
    auto iter = devicesInfo_.find(data.devId);
    if (iter == devicesInfo_.end()) {
        if (data.isOpenDevice) {
            devicesInfo_.insert(std::pair<uint32_t, DynProfDeviceInfo>(data.devId, data));
        }
    } else {
        if (!data.isOpenDevice) {
            devicesInfo_.erase(iter);
        }
    }
}

/**
 * @brief Check if dynamic delay or duration profiling task start
 */
bool DynProfThread::IsProfStarted()
{
    std::unique_lock<std::mutex> lk(devMtx_);
    return profStarted_;
}
} // DynProf
} // Dvvp
} // Collector