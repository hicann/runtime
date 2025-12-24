/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "uploader_mgr.h"
#include "utils/utils.h"
#include "errno/error_code.h"

namespace analysis {
namespace dvvp {
namespace transport {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;

UploaderMgr::UploaderMgr()
{
}

UploaderMgr::~UploaderMgr()
{
    MSPROF_LOGI("Begin to destroy UploaderMgr.");
    if (uploaderMap_.size() > 0) {
        analysis::dvvp::common::utils::Utils::UsleepInterupt(WAIT_CLEAR_UPLOADER_TIME);
    }
    uploaderMap_.clear();
    devModeJobMap_.clear();
    MSPROF_LOGI("End to destroy UploaderMgr.");
}

int32_t UploaderMgr::Init() const
{
    return PROFILING_SUCCESS;
}

int32_t UploaderMgr::Uninit()
{
    uploaderMap_.clear();
    devModeJobMap_.clear();

    return PROFILING_SUCCESS;
}

void UploaderMgr::AddMapByDevIdMode(int32_t devId, const std::string &mode, const std::string &jobId)
{
    std::string devModeKey = std::to_string(devId) + "_" + mode;
    if (mode.empty()) {
        devModeKey += analysis::dvvp::message::PROFILING_MODE_DEF;
    }
    MSPROF_LOGI("devModeKey:%s, jobId:%s Entering UpdateDevModeJobMap...", devModeKey.c_str(), jobId.c_str());
    std::lock_guard<std::mutex> lock(uploaderMutex_);
    const auto mapIter = devModeJobMap_.find(devModeKey);
    if (mapIter != devModeJobMap_.end()) {
        MSPROF_LOGI("Update devModeJobMap_");
    } else {
        MSPROF_LOGI("Add to devModeJobMap_");
    }
    devModeJobMap_[devModeKey] = jobId;
}

std::string UploaderMgr::GetJobId(int32_t devId, const std::string &mode)
{
    std::string devModeKey = std::to_string(devId) + "_" + mode;
    if (mode.empty()) {
        devModeKey += analysis::dvvp::message::PROFILING_MODE_DEF;
    }
    MSPROF_LOGI("devModeKey:%s, Entering GetJobId...", devModeKey.c_str());
    std::lock_guard<std::mutex> lock(uploaderMutex_);
    const auto mapIter = devModeJobMap_.find(devModeKey);
    if (mapIter != devModeJobMap_.end()) {
        return mapIter->second;
    } else {
        return "";
    }
}

int32_t UploaderMgr::CreateUploader(const std::string &id, SHARED_PTR_ALIA<ITransport> transport, size_t queueSize)
{
    if (transport == nullptr) {
        MSPROF_LOGE("Transport is invalid!");
        return PROFILING_FAILED;
    }
    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    MSVP_MAKE_SHARED1(uploader, Uploader, transport, return PROFILING_FAILED);
    int32_t ret = uploader->Init(queueSize);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to init uploader");
        MSPROF_INNER_ERROR("EK9999", "Failed to init uploader");
        return ret;
    }
    std::string uploaderName = analysis::dvvp::common::config::MSVP_UPLOADER_THREAD_NAME;
    uploaderName.append("_").append(id);
    uploader->SetThreadName(uploaderName);
    ret = uploader->Start();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to start uploader thread");
        MSPROF_INNER_ERROR("EK9999", "Failed to start uploader thread");
        return ret;
    }
    AddUploader(id, uploader);
    return PROFILING_SUCCESS;
}

void UploaderMgr::AddUploader(const std::string &id, SHARED_PTR_ALIA<Uploader> uploader)
{
    MSPROF_LOGI("id: %s Entering AddUploader...", id.c_str());
    std::lock_guard<std::mutex> lock(uploaderMutex_);
    if (uploader != nullptr && !id.empty()) {
        uploaderMap_[id] = uploader;
    }
}

void UploaderMgr::GetUploader(const std::string &id, SHARED_PTR_ALIA<Uploader> &uploader)
{
    MSPROF_LOGD("Get id %s uploader...", id.c_str());
    std::lock_guard<std::mutex> lock(uploaderMutex_);
    auto iter = uploaderMap_.find(id);
    if (iter != uploaderMap_.end() && iter->second != nullptr) {
        uploader = iter->second;
    }
}

void UploaderMgr::DelUploader(const std::string &id)
{
    MSPROF_LOGI("Del id %s uploader...", id.c_str());
    std::lock_guard<std::mutex> lock(uploaderMutex_);
    const auto iter = uploaderMap_.find(id);
    if (iter != uploaderMap_.end()) {
        uploaderMap_.erase(iter);
    }
}

void UploaderMgr::DelAllUploader()
{
    MSPROF_LOGI("DelAllUploader");
    std::lock_guard<std::mutex> lock(uploaderMutex_);
    uploaderMap_.clear();
}

void UploaderMgr::SetAllUploaderTransportStopped()
{
    MSPROF_LOGI("SetAllUploaderTransportStopped");
    std::lock_guard<std::mutex> lock(uploaderMutex_);
    for (auto iter = uploaderMap_.begin(); iter != uploaderMap_.end(); iter++) {
        MSPROF_LOGI("Set uploader %s transport stopped", iter->first.c_str());
        iter->second->SetTransportStopped();
    }
}

int32_t UploaderMgr::SetAllUploaderRegisterPipeTransportCallback(MsprofRawDataCallback callback)
{
    MSPROF_LOGI("SetAllUploaderRegisterPipeTransportCallback");
    std::lock_guard<std::mutex> lock(uploaderMutex_);
    int32_t ret = PROFILING_SUCCESS;
    for (auto iter = uploaderMap_.begin(); iter != uploaderMap_.end(); iter++) {
        MSPROF_LOGI("Set uploader %s register pipe transport callback", iter->first.c_str());
        int32_t tmp = iter->second->RegisterPipeTransportCallback(callback);
        if (tmp == PROFILING_FAILED) {
            ret = PROFILING_FAILED;
        }
    }
    return ret;
}

int32_t UploaderMgr::SetAllUploaderUnRegisterPipeTransportCallback()
{
    MSPROF_LOGI("SetAllUploaderUnRegisterPipeTransportCallback");
    std::lock_guard<std::mutex> lock(uploaderMutex_);
    int32_t ret = PROFILING_SUCCESS;
    for (auto iter = uploaderMap_.begin(); iter != uploaderMap_.end(); iter++) {
        MSPROF_LOGI("Set uploader %s unregister pipe transport callback", iter->first.c_str());
        int32_t tmp = iter->second->UnRegisterPipeTransportCallback();
        if (tmp == PROFILING_FAILED) {
            ret = PROFILING_FAILED;
        }
    }
    return ret;
}

void UploaderMgr::RegisterAllUploaderTransportGenHashIdFuncPtr(HashDataGenIdFuncPtr* ptr)
{
    MSPROF_LOGI("RegisterAllUploaderTransportGenHashIdFuncPtr");
    std::lock_guard<std::mutex> lock(uploaderMutex_);
    for (auto iter = uploaderMap_.begin(); iter != uploaderMap_.end(); iter++) {
        iter->second->RegisterTransportGenHashIdFuncPtr(ptr);
    }
}

int32_t UploaderMgr::UploadData(const std::string &id, CONST_VOID_PTR data, uint32_t dataLen)
{
    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    GetUploader(id, uploader);
    if (uploader != nullptr) {
        return uploader->UploadData(data, dataLen);
    }

    MSPROF_LOGE("Get id[%s] uploader failed, dataLen:%d bytes", id.c_str(), dataLen);
    MSPROF_INNER_ERROR("EK9999", "Get id[%s] uploader failed, dataLen:%u bytes", id.c_str(), dataLen);
    return PROFILING_FAILED;
}

int32_t UploaderMgr::UploadData(const std::string &id, SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    MSPROF_LOGD("UploadData id[%s] uploader start", id.c_str());
    if (!IsUploadDataStart(id, fileChunkReq->fileName)) {
        MSPROF_LOGI("UploadData skipped for device[%s] %s", id.c_str(), fileChunkReq->fileName.c_str());
        return PROFILING_IN_WARMUP;
    }
    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    GetUploader(id, uploader);
    if (uploader != nullptr) {
        return uploader->UploadData(fileChunkReq);
    }

    MSPROF_LOGE("Get id[%s] uploader failed", id.c_str());
    MSPROF_INNER_ERROR("EK9999", "Get id[%s] uploader failed", id.c_str());
    return PROFILING_FAILED;
}

int32_t UploaderMgr::UploadCtrlFileData(const std::string &id,
    const std::string &data,
    const struct FileDataParams &fileDataParams,
    SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx) const
{
    MSPROF_LOGI("UploadCtrlFileData id[%s] uploader start", id.c_str());
    if (data.empty()) {
        MSPROF_LOGE("data is empty");
        MSPROF_INNER_ERROR("EK9999", "data is empty");
        return PROFILING_FAILED;
    }

    if (jobCtx == nullptr) {
        MSPROF_LOGE("jobCtx is null");
        MSPROF_INNER_ERROR("EK9999", "jobCtx is null");
        return PROFILING_FAILED;
    }

    SHARED_PTR_ALIA<ProfileFileChunk> fileChunk;
    MSVP_MAKE_SHARED0(fileChunk, ProfileFileChunk, return PROFILING_FAILED);

    fileChunk->fileName = fileDataParams.fileName;
    fileChunk->offset = -1;
    fileChunk->chunk = std::string(data.c_str(), data.size());
    fileChunk->chunkSize = data.size();
    fileChunk->isLastChunk = fileDataParams.isLastChunk;
    fileChunk->chunkModule = fileDataParams.mode;
    fileChunk->extraInfo = Utils::PackDotInfo(jobCtx->job_id, jobCtx->dev_id);
    return analysis::dvvp::transport::UploaderMgr::instance()->UploadData(id, fileChunk);
}

void UploaderMgr::SetUploadDataIfStart(bool ifStart)
{
    isUploadStart_.store(ifStart);
}

bool UploaderMgr::IsUploadDataStart(const std::string &dataDeviceId, const std::string &dataFileName)
{
    // only return false when data is from device except flip data and upload not started
    if (isUploadStart_.load()) {
        return true;
    }
    if (dataDeviceId == std::to_string(DEFAULT_HOST_ID)) {
        return true;
    }
    if (dataFileName.rfind("data/ts_track", 0) == 0) {
        return true;
    }
    if (dataFileName.rfind("data/aicpu.data", 0) == 0) {
        return true;
    }
    if (dataFileName.rfind("data", 0) == 0) {
        return false;
    }
    return true;
}
}
}
}

