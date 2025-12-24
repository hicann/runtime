/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_task.h"
#include <algorithm>
#include "config/config.h"
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "prof_acl_mgr.h"
#include "prof_manager.h"
#include "securec.h"
#include "transport/transport.h"
#include "transport/file_transport.h"
#include "transport/uploader.h"
#include "transport/uploader_mgr.h"
#include "utils/utils.h"
#include "json/json.h"
#include "info_json.h"
#include "config_manager.h"

namespace analysis {
namespace dvvp {
namespace host {
using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::message;
using namespace analysis::dvvp::transport;
using namespace Analysis::Dvvp::MsprofErrMgr;

ProfTask::ProfTask(const std::vector<std::string> &devices,
                   SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param)
    : params_(param),
      currDevicesV_(devices),
      isInited_(false),
      isFinished_(false)
{
}

ProfTask::~ProfTask()
{
    if (isInited_) {
        devicesMap_.clear();
        StopNoWait();
        cv_.notify_one();
        Join();
        isInited_ = false;
    }
    MSPROF_LOGI("Destroy ProfTask.");
}

int32_t ProfTask::Init()
{
    MSPROF_LOGI("Init ProfTask");
    analysis::dvvp::transport::UploaderMgr::instance()->GetUploader(params_->job_id, uploader_);
    if (uploader_ == nullptr) {
        MSPROF_LOGE("Failed to get correct uploader");
        MSPROF_INNER_ERROR("EK9999", "Failed to get correct uploader");
        return PROFILING_FAILED;
    }

    isInited_ = true;
    return PROFILING_SUCCESS;
}

int32_t ProfTask::Uinit()
{
    if (isInited_) {
        WriteDone();
        analysis::dvvp::transport::UploaderMgr::instance()->DelUploader(params_->job_id);
        isInited_ = false;
        MSPROF_EVENT("Uninit ProfTask successfully");
    }

    return PROFILING_SUCCESS;
}

bool ProfTask::IsDeviceRunProfiling(const std::string &devStr)
{
    std::lock_guard<std::mutex> lck(devicesMtx_);
    auto iter = std::find(currDevicesV_.begin(), currDevicesV_.end(), devStr);
    if (iter != currDevicesV_.end()) {
        return true;
    }
    return false;
}

std::string ProfTask::GetDevicesStr(const std::vector<std::string> &events) const
{
    analysis::dvvp::common::utils::UtilsStringBuilder<std::string> builder;
    return builder.Join(events, ",");
}

void ProfTask::GenerateFileName(bool isStartTime, std::string &filename)
{
    if (!isStartTime) {
        filename.append("end_info");
    } else {
        filename.append("start_info");
    }
    if (!(params_->hostProfiling)) {
        filename.append(".").append(params_->devices);
    }
}

std::string ProfTask::EncodeTimeInfoJson(SHARED_PTR_ALIA<CollectionStartEndTime> timeInfo) const
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

    out = timeInfoJson.ToString();
    return out;
}

int32_t ProfTask::CreateCollectionTimeInfo(std::string collectionTime, bool isStartTime)
{
    MSPROF_LOGI("[CreateCollectionTimeInfo]collectionTime:%s us, isStartTime:%d", collectionTime.c_str(), isStartTime);
    // time to unix
    SHARED_PTR_ALIA<CollectionStartEndTime> timeInfo = nullptr;
    MSVP_MAKE_SHARED0(timeInfo, CollectionStartEndTime, return PROFILING_FAILED);
    static const int32_t TIME_US = 1000000;
    if (!isStartTime) {
        timeInfo->collectionTimeEnd = collectionTime;
        timeInfo->collectionDateEnd = Utils::TimestampToTime(collectionTime, TIME_US);
    } else {
        timeInfo->collectionTimeBegin = collectionTime;
        timeInfo->collectionDateBegin = Utils::TimestampToTime(collectionTime, TIME_US);
    }

    timeInfo->clockMonotonicRaw = std::to_string(Utils::GetClockMonotonicRaw());
    std::string content;
    try {
        content = EncodeTimeInfoJson(timeInfo);
    } catch (const std::runtime_error &error) {
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("[CreateCollectionTimeInfo]content:%s", content.c_str());
    SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx = nullptr;
    MSVP_MAKE_SHARED0(jobCtx, analysis::dvvp::message::JobContext, return PROFILING_FAILED);
    jobCtx->job_id = params_->job_id;
    std::string fileName;
    GenerateFileName(isStartTime, fileName);
    analysis::dvvp::transport::FileDataParams fileDataParams(fileName, true,
                                                             FileChunkDataModule::PROFILING_IS_CTRL_DATA);
    MSPROF_LOGI("[CreateCollectionTimeInfo]job_id: %s,fileName: %s", params_->job_id.c_str(), fileName.c_str());
    const int32_t ret = analysis::dvvp::transport::UploaderMgr::instance()->UploadCtrlFileData(params_->job_id, content,
                                                                                     fileDataParams, jobCtx);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to upload data for %s", fileName.c_str());
        MSPROF_INNER_ERROR("EK9999", "Failed to upload data for %s", fileName.c_str());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfTask::GetHostAndDeviceInfo()
{
    std::vector<std::string> devicesListV;
    devicesListV = _devices_v;
    std::string devicesStr = GetDevicesStr(devicesListV);
    MSPROF_LOGI("GetHostAndDeviceInfo, devices: %s", devicesStr.c_str());
    std::string endTime = Utils::GetHostTime();
    if (endTime.empty()) {
        MSPROF_LOGE("gettimeofday failed");
        MSPROF_INNER_ERROR("EK9999", "gettimeofday failed");
        return PROFILING_FAILED;
    }
    InfoJson infoJson(params_->jobInfo, devicesStr, params_->host_sys_pid);
    std::string content;
    if (infoJson.Generate(content) != PROFILING_SUCCESS) {
        MSPROF_LOGE("[GetHostAndDeviceInfo]Failed to generate info.json");
        MSPROF_INNER_ERROR("EK9999", "Failed to generate info.json");
        return PROFILING_FAILED;
    }
    SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx = nullptr;
    MSVP_MAKE_SHARED0(jobCtx, analysis::dvvp::message::JobContext, return PROFILING_FAILED);
    jobCtx->job_id = params_->job_id;
    std::string fileName;
    if (params_->hostProfiling) {
        fileName.append(INFO_FILE_NAME);
    } else {
        fileName.append(INFO_FILE_NAME).append(".").append(params_->devices);
    }
    analysis::dvvp::transport::FileDataParams fileDataParams(fileName, true,
                                                             FileChunkDataModule::PROFILING_IS_CTRL_DATA);
    MSPROF_LOGI("[GetHostAndDeviceInfo]storeStartTime.id: %s,fileName: %s", params_->job_id.c_str(), fileName.c_str());

    if (analysis::dvvp::transport::UploaderMgr::instance()->UploadCtrlFileData(params_->job_id, content, fileDataParams,
        jobCtx) != PROFILING_SUCCESS) {
        MSPROF_LOGE("[GetHostAndDeviceInfo]Failed to upload data for %s", fileName.c_str());
        MSPROF_INNER_ERROR("EK9999", "Failed to upload data for %s", fileName.c_str());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

void ProfTask::StartDevices(const std::vector<std::string> &devicesVec)
{
    std::lock_guard<std::mutex> lck(devicesMtx_);
    for (size_t i = 0; i < devicesVec.size(); i++) {
        if (devicesVec[i].compare("") == 0) {
            continue;
        }
        const auto iter = devicesMap_.find(devicesVec[i]);
        if (iter != devicesMap_.end()) {
            MSPROF_LOGE("Device %s is already running profiling, skip the device.", devicesVec[i].c_str());
            MSPROF_INNER_ERROR("EK9999", "Device %s is already running profiling, skip the device.",
                               devicesVec[i].c_str());
            continue;
        }

        // insert the new device
        _devices_v.push_back(devicesVec[i]);
        MSPROF_LOGI("Device %s begin init.", devicesVec[i].c_str());

        SHARED_PTR_ALIA<Device> dev;
        MSVP_MAKE_SHARED2_NODO(dev, Device, params_, devicesVec[i], continue);

        int32_t ret = dev->Init();
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Device %s init failed, ret:%d", devicesVec[i].c_str(), ret);
            MSPROF_INNER_ERROR("EK9999", "Device %s init failed, ret:%d", devicesVec[i].c_str(), ret);
            continue;
        }

        MSPROF_LOGI("Device set Response %s", devicesVec[i].c_str());
        dev->SetResponseCallback(Msprofiler::Api::DeviceResponse);
        const int32_t deviceThreadNameLen = 6;
        dev->SetThreadName(MSVP_DEVICE_THREAD_NAME_PREFIX + devicesVec[i].substr(0, deviceThreadNameLen));

        ret = dev->Start();
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Device %s start failed, ret:%d", devicesVec[i].c_str(), ret);
            MSPROF_INNER_ERROR("EK9999", "Device %s start failed, ret:%d", devicesVec[i].c_str(), ret);
            continue;
        }

        devicesMap_[devicesVec[i]] = dev;

        MSPROF_LOGI("Device %s init success.", devicesVec[i].c_str());
    }
}

void ProfTask::ProcessDefMode()
{
    MSPROF_LOGI("Profiling running task");
    StartDevices(currDevicesV_);
    if (GetHostAndDeviceInfo() != PROFILING_SUCCESS) {
        MSPROF_LOGE("ProcessDefMode GetHostAndDeviceInfo failed");
        MSPROF_INNER_ERROR("EK9999", "ProcessDefMode GetHostAndDeviceInfo failed");
    }
    // wait stop notify
    std::unique_lock<std::mutex> lk(taskMtx_);
    MSPROF_EVENT("ProfTask %s started to wait for task stop cv", params_->job_id.c_str());
    cv_.wait(lk, [this] { return this->IsQuit(); });
    MSPROF_EVENT("ProfTask %s finished waiting for task stop cv", params_->job_id.c_str());
}

int32_t ProfTask::NotifyFileDoneForDevice(const std::string &fileName, const std::string &devId) const
{
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk;
    MSVP_MAKE_SHARED0(fileChunk, analysis::dvvp::ProfileFileChunk, return PROFILING_FAILED);

    analysis::dvvp::message::JobContext jobCtx;
    jobCtx.job_id = params_->job_id;
    jobCtx.dev_id = devId;

    fileChunk->fileName = Utils::PackDotInfo(fileName, jobCtx.tag);
    fileChunk->offset = -1;
    fileChunk->chunkSize = 0;
    fileChunk->isLastChunk = true;
    fileChunk->extraInfo = Utils::PackDotInfo(jobCtx.job_id, jobCtx.dev_id);

    const int32_t ret = WriteStreamData(fileChunk);
    FUNRET_CHECK_EXPR_LOGW(ret != PROFILING_SUCCESS, "NotifyFileDoneForDevice did not execute successfully,"
        "jobId:%s, filename:%s, devId:%s", jobCtx.job_id.c_str(), fileName.c_str(), devId.c_str());
    return PROFILING_SUCCESS;
}

void ProfTask::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);
    // process prepare
    MSPROF_LOGI("Task %s begins to run", params_->job_id.c_str());
    ProcessDefMode();

    // wait all device thread stop
    for (auto iter = devicesMap_.cbegin(); iter != devicesMap_.cend(); iter++) {
        iter->second->PostStopReplay();
        iter->second->Wait();
        (void)NotifyFileDoneForDevice("", iter->first);
    }
    MSPROF_LOGI("Prof task begins to finish");
    (void)CreateCollectionTimeInfo(Utils::GetHostTime(), false);
    (void)uploader_->Flush();
    uploader_ = nullptr;

    MSPROF_LOGI("Prof task OnTaskFinished");
    ProfManager::instance()->OnTaskFinished(params_->job_id);

    MSPROF_EVENT("Task %s finished", params_->job_id.c_str());
}

int32_t ProfTask::Stop()
{
    MSPROF_EVENT("Task send finished cv");
    StopNoWait();
    cv_.notify_one();
    const auto ret = Join();
    if (ret == PROFILING_SUCCESS) {
        MSPROF_LOGI("Task %s stopped", params_->job_id.c_str());
    }
    WriteDone();
    return ret;
}

void ProfTask::WriteDone()
{
    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    analysis::dvvp::transport::UploaderMgr::instance()->GetUploader(params_->job_id, uploader);
    if (uploader == nullptr) {
        return;
    }
    MSPROF_LOGI("[WriteDone]Flush all data, jobId: %s", params_->job_id.c_str());
    (void)uploader->Flush();
    auto transport = uploader->GetTransport();
    if (transport != nullptr) {
        transport->WriteDone();
    }
    uploader = nullptr;
}

int32_t ProfTask::WriteStreamData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk) const
{
    if (GetIsFinished()) {
        MSPROF_LOGW("Profiling is already finished, jobId: %s", params_->job_id.c_str());
        return PROFILING_SUCCESS;
    }

    if (uploader_ != nullptr && fileChunk != nullptr) {
        return uploader_->UploadData(fileChunk);
    }
    return PROFILING_FAILED;
}

void ProfTask::SetIsFinished(bool finished)
{
    isFinished_ = finished;
}

bool ProfTask::GetIsFinished() const
{
    return isFinished_;
}
}  // namespace host
}  // namespace dvvp
}  // namespace analysis
