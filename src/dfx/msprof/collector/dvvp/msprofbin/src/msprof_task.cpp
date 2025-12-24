/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "msprof_task.h"
#include "errno/error_code.h"
#include "config/config.h"
#include "job_factory.h"
#include "job_device_rpc.h"
#include "transport/uploader_mgr.h"
#include "task_relationship_mgr.h"
#include "info_json.h"
#include "json/json.h"

namespace Analysis {
namespace Dvvp {
namespace Msprof {
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::JobWrapper;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::TaskHandle;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::host;
using namespace analysis::dvvp::transport;
using namespace Analysis::Dvvp::MsprofErrMgr;

MsprofTask::MsprofTask(const int32_t devId, SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param)
    : isInit_(false),
      deviceId_(devId),
      isQuited_(false),
      isExited_(false),
      isStopReplayReady(false),
      params_(param)
{
}

MsprofTask::~MsprofTask() {}

void MsprofTask::WaitStopReplay()
{
    std::unique_lock<std::mutex> lk(mtx_);
    cvSyncStopReplay.wait(lk, [this] { return (this->isStopReplayReady || this->isQuited_); });
    isStopReplayReady = false;
}

void MsprofTask::PostStopReplay()
{
    std::unique_lock<std::mutex> lk(mtx_);
    isStopReplayReady = true;
    cvSyncStopReplay.notify_one();
}

void MsprofTask::PostSyncDataCtrl() {}

void MsprofTask::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);
    if (params_ == nullptr || !isInit_) {
        MSPROF_LOGE("MsprofTask run failed.");
        return;
    }
    do {
        int32_t ret = CreateCollectionTimeInfo(GetHostTime(), true);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("ProcessDefMode CreateCollectionTimeInfo failed");
        }
        ret = jobAdapter_->StartProf(params_);
        if (ret != PROFILING_SUCCESS) {
            break;
        }
        WaitStopReplay();  // wait SendStopMessage
        ret = jobAdapter_->StopProf();
        if (ret != PROFILING_SUCCESS) {
            break;
        }
        ret = GetHostAndDeviceInfo();
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("GetHostAndDeviceInfo failed");
        }
        (void)CreateCollectionTimeInfo(GetHostTime(), false);
    } while (0);
}

int32_t MsprofTask::Stop()
{
    PostStopReplay();
    return PROFILING_SUCCESS;
}

int32_t MsprofTask::Wait()
{
    MSPROF_LOGI("Device(%d) wait begin", deviceId_);
    isQuited_ = true;
    Join();
    MSPROF_LOGI("Device(%d) wait end", deviceId_);
    WriteDone();
    return 0;
}

void MsprofTask::WriteDone()
{
    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    UploaderMgr::instance()->GetUploader(params_->job_id, uploader);
    if (uploader != nullptr) {
        MSPROF_LOGI("Flush all data, jobId: %s", params_->job_id.c_str());
        (void)uploader->Flush();
        auto transport = uploader->GetTransport();
        if (transport != nullptr) {
            transport->WriteDone();
        }
        uploader = nullptr;
    }
}

void MsprofTask::GenerateFileName(bool isStartTime, std::string &filename)
{
    if (!isStartTime) {
        filename.append("end_info");
    } else {
        filename.append("start_info");
    }
    if (!(params_->hostProfiling)) {
        filename.append(".").append(std::to_string(deviceId_));
    }
}

std::string MsprofTask::EncodeTimeInfoJson(SHARED_PTR_ALIA<CollectionStartEndTime> timeInfo) const
{
    std::string out = "";
    if (timeInfo == nullptr) {
        return out;
    }

    NanoJson::Json timeInfoJson;
    timeInfoJson["collectionDateBegin"] = timeInfo->collectionDateBegin;
    timeInfoJson["collectionDateEnd"] = timeInfo->collectionDateEnd;
    timeInfoJson["collectionTimeBegin"] = timeInfo->collectionTimeBegin;
    timeInfoJson["collectionTimeEnd"] = timeInfo->collectionTimeEnd;
    timeInfoJson["clockMonotonicRaw"] = timeInfo->clockMonotonicRaw;
    return timeInfoJson.ToString();
}

int32_t MsprofTask::CreateCollectionTimeInfo(std::string collectionTime, bool isStartTime)
{
    MSPROF_LOGI("collectionTime:%s us, isStartTime:%d", collectionTime.c_str(), isStartTime);
    // time to unix
    const int32_t timeUs = 1000000;
    SHARED_PTR_ALIA<CollectionStartEndTime> timeInfo = nullptr;
    MSVP_MAKE_SHARED0(timeInfo, CollectionStartEndTime, return PROFILING_FAILED);
    if (!isStartTime) {
        timeInfo->collectionTimeEnd = collectionTime;
        timeInfo->collectionDateEnd = Utils::TimestampToTime(collectionTime, timeUs);
    } else {
        timeInfo->collectionTimeBegin = collectionTime;
        timeInfo->collectionDateBegin = Utils::TimestampToTime(collectionTime, timeUs);
    }
    timeInfo->clockMonotonicRaw = std::to_string(Utils::GetClockMonotonicRaw());
    std::string content;
    try {
        content = EncodeTimeInfoJson(timeInfo);
    } catch (const std::runtime_error &error) {
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("CreateCollectionTimeInfo, content:%s", content.c_str());
    SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx = nullptr;
    MSVP_MAKE_SHARED0(jobCtx, analysis::dvvp::message::JobContext, return PROFILING_FAILED);
    jobCtx->job_id = params_->job_id;
    std::string fileName;
    GenerateFileName(isStartTime, fileName);
    analysis::dvvp::transport::FileDataParams fileDataParams(
        fileName, true, analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_CTRL_DATA);

    MSPROF_LOGI("job_id: %s,fileName: %s", params_->job_id.c_str(), fileName.c_str());
    int32_t ret = analysis::dvvp::transport::UploaderMgr::instance()->UploadCtrlFileData(params_->job_id, content,
                                                                                     fileDataParams, jobCtx);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to upload data for %s", fileName.c_str());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t MsprofTask::GetHostAndDeviceInfo()
{
    std::string endTime = GetHostTime();
    if (endTime.empty()) {
        MSPROF_LOGE("gettimeofday failed");
        return PROFILING_FAILED;
    }
    InfoJson infoJson(params_->jobInfo, params_->devices, params_->host_sys_pid);
    std::string content;
    if (infoJson.Generate(content) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to generate info.json");
        return PROFILING_FAILED;
    }

    SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx = nullptr;
    MSVP_MAKE_SHARED0(jobCtx, analysis::dvvp::message::JobContext, return PROFILING_FAILED);
    jobCtx->job_id = params_->job_id;
    std::string fileName;
    if (!(params_->hostProfiling)) {
        fileName.append(INFO_FILE_NAME).append(".").append(params_->devices);
    } else {
        fileName.append(INFO_FILE_NAME);
    }
    analysis::dvvp::transport::FileDataParams fileDataParams(
        fileName, true, analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_CTRL_DATA);

    MSPROF_LOGI("storeStartTime.id: %s,fileName: %s", params_->job_id.c_str(), fileName.c_str());
    int32_t ret = analysis::dvvp::transport::UploaderMgr::instance()->UploadCtrlFileData(params_->job_id, content,
                                                                                     fileDataParams, jobCtx);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to upload data for %s", fileName.c_str());
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

std::string MsprofTask::GetHostTime() const
{
    std::string hostTime;
    OsalTimeval tv;
    const int32_t timeUs = 1000000;

    (void)memset_s(&tv, sizeof(tv), 0, sizeof(tv));
    int32_t ret = OsalGetTimeOfDay(&tv, nullptr);
    if (ret != OSAL_EN_OK) {
        MSPROF_LOGE("gettimeofday failed");
    } else {
        hostTime = std::to_string((unsigned long long)tv.tv_sec * timeUs + (unsigned long long)tv.tv_usec);
    }
    return hostTime;
}

ProfSocTask::ProfSocTask(const int32_t deviceId, SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param)
    : MsprofTask(deviceId, param)
{
}

ProfSocTask::~ProfSocTask() {}

int32_t ProfSocTask::Init()
{
    MSPROF_LOGI("Init SOC JobAdapter");
    auto jobFactory = JobSocFactory();
    jobAdapter_ = jobFactory.CreateJobAdapter(deviceId_);
    if (jobAdapter_ == nullptr) {
        return PROFILING_FAILED;
    }
    isInit_ = true;
    return PROFILING_SUCCESS;
}

int32_t ProfSocTask::UnInit()
{
    jobAdapter_.reset();
    isInit_ = false;
    return PROFILING_SUCCESS;
}

ProfRpcTask::ProfRpcTask(const int32_t deviceId, SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param)
    : MsprofTask(deviceId, param),
      isDataChannelEnd_(false)
{
}

ProfRpcTask::~ProfRpcTask() {}

int32_t ProfRpcTask::Init()
{
    analysis::dvvp::transport::LoadDevMgrAPI(devMgrAPI_);
    if (devMgrAPI_.pfDevMgrInit == nullptr) {
        MSPROF_LOGE("pfDevMgrInit is null");
        return PROFILING_FAILED;
    }
    if (params_->profiling_period <= 0) {
        MSPROF_LOGE("Profiling period is invalid, and the value is %d", params_->profiling_period);
        return PROFILING_FAILED;
    }
    int32_t ret =
        devMgrAPI_.pfDevMgrInit(params_->job_id, deviceId_, params_->profiling_mode, params_->profiling_period);
    if (ret != PROFILING_SUCCESS) {
        if (ret != PROFILING_NOTSUPPORT) {
            MSPROF_LOGE("Failed to connect device %d", deviceId_);
        }
        return ret;
    }
    MSPROF_LOGI("Init Rpc JobAdapter");
    MSVP_MAKE_SHARED1(jobAdapter_, JobDeviceRpc, deviceId_, return PROFILING_FAILED);
    isInit_ = true;
    return PROFILING_SUCCESS;
}

int32_t ProfRpcTask::UnInit()
{
    if (devMgrAPI_.pfDevMgrUnInit != nullptr) {
        (void)devMgrAPI_.pfDevMgrUnInit();
    }
    jobAdapter_.reset();
    isInit_ = false;
    return PROFILING_SUCCESS;
}

int32_t ProfRpcTask::Stop()
{
    PostStopReplay();
    MSPROF_LOGI("Device(%d) WaitSyncDataCtrl begin", deviceId_);
    WaitSyncDataCtrl();
    MSPROF_LOGI("Device(%d) WaitSyncDataCtrl end", deviceId_);
    return PROFILING_SUCCESS;
}

/**
 * @brief Send data sync signal
 */
void ProfRpcTask::PostSyncDataCtrl()
{
    MSPROF_LOGI("Device(%d) jobId(%s) post data channel.", deviceId_, params_->job_id.c_str());
    std::unique_lock<std::mutex> lk(dataSyncMtx_);
    isDataChannelEnd_ = true;
    cvSyncDataCtrl_.notify_one();
}

/**
 * @brief Wait data sync signal
 */
void ProfRpcTask::WaitSyncDataCtrl()
{
    std::unique_lock<std::mutex> lk(dataSyncMtx_);
    cvSyncDataCtrl_.wait(lk, [this] { return (isDataChannelEnd_ || !isExited_); });
    isDataChannelEnd_ = false;
}
}
}
}
