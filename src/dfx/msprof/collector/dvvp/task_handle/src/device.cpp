/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "device.h"
#include "ai_drv_dev_api.h"
#include "config/config.h"
#include "errno/error_code.h"
#include "job_factory.h"
#include "msprof_dlog.h"
#include "param_validation.h"
#include "prof_manager.h"
#include "prof_task.h"
#include "transport/transport.h"
#include "transport/uploader_mgr.h"
#include "utils/utils.h"
#include "platform/platform.h"
#include "task_relationship_mgr.h"

namespace analysis {
namespace dvvp {
namespace host {
using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::message;
using namespace Analysis::Dvvp::JobWrapper;
using namespace Analysis::Dvvp::TaskHandle;
using namespace analysis::dvvp::common::validation;
using namespace Analysis::Dvvp::MsprofErrMgr;

Device::Device(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params,
               const std::string &devId)
    : params_(params),
      indexIdStr_(devId),
      indexId_(-1),
      hostId_(-1),
      isQuited_(false),
      isStopReplayReady_(false),
      isInited_(false),
      deviceResponseCallack_(nullptr),
      jobAdapter_(nullptr)
{
    MSPROF_LOGI("Constructor Device (%s).", indexIdStr_.c_str());
}

Device::~Device()
{
    MSPROF_LOGI("Destroy Device (%d).", indexId_);
    StopNoWait();
    PostStopReplay();
}

int32_t Device::Init()
{
    // init result
    MSVP_MAKE_SHARED0(status_, analysis::dvvp::message::StatusInfo, return PROFILING_FAILED);
    status_->status = analysis::dvvp::message::SUCCESS;
    if (!(params_->hostProfiling) && !ParamValidation::instance()->CheckDeviceIdIsValid(indexIdStr_)) {
        MSPROF_LOGE("[Device::Init] devId %s is not valid!", indexIdStr_.c_str());
        MSPROF_INNER_ERROR("EK9999", "devId %s is not valid!", indexIdStr_.c_str());
        status_->info = "Device id is invalid";
        status_->status = analysis::dvvp::message::ERR;
        return PROFILING_FAILED;
    }
    return InitJobAdapter();
}

int32_t Device::InitJobAdapter()
{
    FUNRET_CHECK_EXPR_ACTION(!Utils::StrToInt32(indexId_, indexIdStr_), return PROFILING_FAILED, 
        "indexIdStr_ %s is invalid", indexIdStr_.c_str());
    status_->dev_id = indexIdStr_;

    if (Platform::instance()->PlatformIsSocSide()) {  // soc scene
        MSPROF_LOGI("Init SOC JobAdapter");
        auto jobFactory = JobSocFactory();
        jobAdapter_ = jobFactory.CreateJobAdapter(indexId_);
    } else {
        const int32_t platform = Platform::instance()->GetPlatform();
        MSPROF_LOGE("[Device::Init]GetPlatform failed, platformInfo is %d", platform);
        MSPROF_INNER_ERROR("EK9999", "GetPlatform failed, platformInfo is %d", platform);
        return PROFILING_FAILED;
    }
    if (jobAdapter_ == nullptr) {
        MSPROF_LOGE("[Device::Init]Create Job Adapter failed!");
        MSPROF_INNER_ERROR("EK9999", "Create Job Adapter failed!");
        return PROFILING_FAILED;
    }

    if (Platform::instance()->RunSocSide()) {
        hostId_ = TaskRelationshipMgr::instance()->GetHostIdByDevId(indexId_);
    } else {
        hostId_ = indexId_;
    }

    if (params_ != nullptr) {
        analysis::dvvp::transport::UploaderMgr::instance()->AddMapByDevIdMode(
            indexId_, params_->profiling_mode, params_->job_id);
    }

    return PROFILING_SUCCESS;
}

/**
 * @brief  : set call back when need
 * @parma  : [in] void(*)() callback : callback function
 */
int32_t Device::SetResponseCallback(DeviceCallback callback)
{
    if (callback == nullptr) {
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("Device SetResponseCallback");
    deviceResponseCallack_ = callback;
    return PROFILING_SUCCESS;
}

void Device::WaitStopReplay()
{
    std::unique_lock<std::mutex> lk(mtx_);
    cvSyncStopReplay.wait(lk, [this] { return (this->isStopReplayReady_ || this->isQuited_); });
    isStopReplayReady_ = false;
}

void Device::PostStopReplay()
{
    std::unique_lock<std::mutex> lk(mtx_);
    isStopReplayReady_ = true;
    cvSyncStopReplay.notify_one();
}

void Device::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);
    MSPROF_LOGI("Device(%d) ctrl thread is running", indexId_);
    int32_t ret = PROFILING_SUCCESS;
    do {
        ret = jobAdapter_->StartProf(params_);
        if (deviceResponseCallack_ != nullptr) {  // call response when start profiling
            MSPROF_LOGI("Send response Device(%d)", indexId_);
            deviceResponseCallack_(indexId_);
        }
        if (ret != PROFILING_SUCCESS) {
            status_->info = "Start failed";
            status_->status = analysis::dvvp::message::ERR;
            break;
        }
        WaitStopReplay();
        if (IsQuit()) {
            break;
        }
        ret = jobAdapter_->StopProf();
        if (ret != PROFILING_SUCCESS) {
            status_->info = "Stop profiling failed";
            status_->status = analysis::dvvp::message::ERR;
            break;
        }
    } while (0);
    isQuited_ = true;
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Device(%d) ctrl thread status failed", indexId_);
        MSPROF_INNER_ERROR("EK9999", "Device(%d) ctrl thread status failed", indexId_);
    } else {
        MSPROF_LOGI("Device(%d) ctrl thread exit", indexId_);
    }
}

int32_t Device::Stop()
{
    return 0;
}

int32_t Device::Wait()
{
    MSPROF_LOGI("Device(%d) wait begin", indexId_);
    isQuited_ = true;
    Join();
    if (deviceResponseCallack_ != nullptr) {
        deviceResponseCallack_(indexId_);
    }
    MSPROF_LOGI("Device(%d) wait end", indexId_);
    return 0;
}

const SHARED_PTR_ALIA<analysis::dvvp::message::StatusInfo> Device::GetStatus()
{
    return status_;
}
}  // namespace host
}  // namespace dvvp
}  // namespace analysis
