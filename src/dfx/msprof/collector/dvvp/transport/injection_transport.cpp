/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "injection_transport.h"
#include <algorithm>
#include <chrono>
#include "config/config.h"
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "securec.h"
#include "utils/utils.h"

namespace analysis {
namespace dvvp {
namespace transport {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;

namespace {
constexpr char BIU_PERF_GROUP_PREFIX[] = "biu_perf_group";
constexpr size_t BIU_PERF_GROUP_PREFIX_LENGTH = sizeof(BIU_PERF_GROUP_PREFIX) - 1U;
constexpr char BIU_PERF_AIC_NAME[] = "aic";
constexpr char BIU_PERF_AIV0_NAME[] = "aiv0";
constexpr char BIU_PERF_AIV1_NAME[] = "aiv1";

struct BiuPerfFileInfo {
    uint32_t groupId;
    RawDataType type;
};

bool ParseBiuPerfFileName(const std::string& fileName, BiuPerfFileInfo& fileInfo)
{
    const size_t groupPos = fileName.find(BIU_PERF_GROUP_PREFIX);
    if (groupPos == std::string::npos) {
        return false;
    }

    const size_t groupStart = groupPos + BIU_PERF_GROUP_PREFIX_LENGTH;
    const size_t underlinePos = fileName.find('_', groupStart);
    if (underlinePos == std::string::npos || underlinePos == groupStart) {
        return false;
    }

    const std::string groupNumber = fileName.substr(groupStart, underlinePos - groupStart);
    uint64_t groupId = 0;
    if (!Utils::StrToUint64(groupId, groupNumber) ||
        groupId >= static_cast<uint64_t>(analysis::dvvp::common::config::BIU_PERF_HIGHER_GROUP_NUM)) {
        return false;
    }
    fileInfo.groupId = static_cast<uint32_t>(groupId);

    const size_t coreNameStart = underlinePos + 1U;
    const size_t dotPos = fileName.find('.', coreNameStart);
    const size_t coreNameEnd = dotPos == std::string::npos ? fileName.size() : dotPos;
    if (coreNameEnd == coreNameStart) {
        return false;
    }

    const std::string coreName = fileName.substr(coreNameStart, coreNameEnd - coreNameStart);
    if (coreName == BIU_PERF_AIC_NAME) {
        fileInfo.type = BIU_PERF_DATA_TYPE;
    } else if (coreName == BIU_PERF_AIV0_NAME) {
        fileInfo.type = BIU_PERF_AIV0_DATA_TYPE;
    } else if (coreName == BIU_PERF_AIV1_NAME) {
        fileInfo.type = BIU_PERF_AIV1_DATA_TYPE;
    } else {
        return false;
    }
    return true;
}

} // namespace

InjectionTransport::InjectionTransport(MsprofRawDataCallback callback)
    : callback_(callback), callbackFailedCount_(0), callbackFailedBytes_(0), pendingSendBuffers_(0)
{}

InjectionTransport::~InjectionTransport() { UnRegisterRawDataCallback(); }

int32_t InjectionTransport::SendBuffer(CONST_VOID_PTR buffer, int32_t length)
{
    if (buffer == nullptr || length <= 0) {
        MSPROF_LOGE("Invalid injection raw buffer, length:%d.", length);
        return PROFILING_FAILED;
    }
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq = nullptr;
    MSVP_MAKE_SHARED0(fileChunkReq, analysis::dvvp::ProfileFileChunk, return PROFILING_FAILED);
    fileChunkReq->chunk.assign(static_cast<const char*>(buffer), static_cast<size_t>(length));
    fileChunkReq->chunkSize = static_cast<size_t>(length);
    fileChunkReq->isLastChunk = true;
    return SendBuffer(fileChunkReq);
}

RawDataType InjectionTransport::ConvertRawDataType(const std::string& fileName) const
{
    if (fileName.find("stars_soc.data") != std::string::npos) {
        return LOG_DATA_TYPE;
    }
    if (fileName.find("ffts_profile") != std::string::npos) {
        return PMU_DATA_TYPE;
    }
    if (fileName.find("biu_perf") != std::string::npos) {
        return BIU_PERF_DATA_TYPE;
    }
    if (fileName.find("pc_sampling") != std::string::npos) {
        return PC_SAMPLING_DATA_TYPE;
    }
    return DEFAULT_DATA_TYPE;
}

InjectionTransport::RawDataMetadata InjectionTransport::ConvertRawDataMetadata(
    const std::string& fileName, int32_t chunkModule) const
{
    BiuPerfFileInfo fileInfo = {};
    if (ParseBiuPerfFileName(fileName, fileInfo)) {
        return {fileInfo.type, static_cast<int32_t>(fileInfo.groupId)};
    }

    const RawDataType type = ConvertRawDataType(fileName);
    if (type == BIU_PERF_DATA_TYPE) {
        MSPROF_LOGW("Failed to parse BIU perf file metadata, file:%s.", fileName.c_str());
    }
    return {type, chunkModule};
}

bool InjectionTransport::IsSupportedChannelFile(const std::string& fileName) const
{
    return fileName.find("stars_soc.data") != std::string::npos || fileName.find("ffts_profile") != std::string::npos ||
           fileName.find("biu_perf") != std::string::npos || fileName.find("pc_sampling") != std::string::npos;
}

bool InjectionTransport::ParseDeviceId(const std::string& extraInfo, uint32_t& deviceId) const
{
    std::string devIdStr = Utils::GetInfoSuffix(extraInfo);
    if (devIdStr.empty() || !Utils::StrToUint32(deviceId, devIdStr)) {
        MSPROF_LOGE(
            "Failed to parse injection device id, extraInfo:%s, devIdSuffix:%s.", extraInfo.c_str(), devIdStr.c_str());
        return false;
    }
    return true;
}

InjectionTransport::SendBufferGuard::SendBufferGuard(InjectionTransport& transport) : transport_(transport)
{
    std::lock_guard<std::mutex> lock(transport_.sendBufferMutex_);
    transport_.pendingSendBuffers_.fetch_add(1);
}

InjectionTransport::SendBufferGuard::~SendBufferGuard()
{
    {
        std::lock_guard<std::mutex> lock(transport_.sendBufferMutex_);
        transport_.pendingSendBuffers_.fetch_sub(1);
    }
    transport_.sendBufferDoneCv_.notify_all();
}

int32_t InjectionTransport::PushRawData(const MsprofRawData& rawData)
{
    MsprofRawDataCallback callback = GetRawDataCallback();
    if (callback == nullptr) {
        MSPROF_LOGE("Compute raw data callback is not registered.");
        return PROFILING_FAILED;
    }
    int32_t ret = callback(const_cast<MsprofRawData*>(&rawData));
    if (ret != PROFILING_SUCCESS) {
        callbackFailedCount_.fetch_add(1);
        callbackFailedBytes_.fetch_add(rawData.chunkSize);
    }
    return PROFILING_SUCCESS;
}

int32_t InjectionTransport::SendBuffer(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (fileChunkReq == nullptr) {
        MSPROF_LOGE("Invalid injection file chunk.");
        return PROFILING_FAILED;
    }
    if (GetRawDataCallback() == nullptr) {
        MSPROF_LOGE("Compute raw data callback is not registered.");
        return PROFILING_FAILED;
    }
    SendBufferGuard guard(*this);
    if (!IsSupportedChannelFile(fileChunkReq->fileName)) {
        MSPROF_LOGW("Skip unsupported injection file:%s.", fileChunkReq->fileName.c_str());
        return PROFILING_SUCCESS;
    }
    if (fileChunkReq->chunk.empty() || fileChunkReq->chunkSize == 0) {
        MSPROF_LOGD("Skip empty injection file chunk, file:%s.", fileChunkReq->fileName.c_str());
        return PROFILING_SUCCESS;
    }

    const size_t rawSize = std::min(fileChunkReq->chunkSize, fileChunkReq->chunk.size());
    const RawDataMetadata metadata = ConvertRawDataMetadata(fileChunkReq->fileName, fileChunkReq->chunkModule);
    size_t offset = 0;
    while (offset < rawSize) {
        MsprofRawData rawData = {};
        rawData.offset = offset;
        rawData.chunkModule = metadata.chunkModule;
        uint32_t deviceId = 0;
        (void)ParseDeviceId(fileChunkReq->extraInfo, deviceId);
        rawData.deviceId = static_cast<int32_t>(deviceId);
        rawData.type = metadata.type;
        rawData.chunkSize = std::min(static_cast<size_t>(RAW_DATA_MAXSIZE), rawSize - offset);
        rawData.isLastChunk = offset + rawData.chunkSize >= rawSize;
        errno_t err = memcpy_s(rawData.chunk, RAW_DATA_MAXSIZE, fileChunkReq->chunk.data() + offset, rawData.chunkSize);
        if (err != EOK) {
            MSPROF_LOGE("Failed to copy injection raw data, err:%d.", err);
            return PROFILING_FAILED;
        }
        (void)PushRawData(rawData);
        offset += rawData.chunkSize;
    }
    return PROFILING_SUCCESS;
}

int32_t InjectionTransport::CloseSession() { return PROFILING_SUCCESS; }

void InjectionTransport::WriteDone() {}

void InjectionTransport::RegisterRawDataCallback(MsprofRawDataCallback callback)
{
    std::lock_guard<std::mutex> lock(callbackMutex_);
    callback_ = callback;
}

void InjectionTransport::UnRegisterRawDataCallback()
{
    std::lock_guard<std::mutex> lock(callbackMutex_);
    callback_ = nullptr;
}

bool InjectionTransport::IsRegisterRawDataCallback() { return GetRawDataCallback() != nullptr; }

MsprofRawDataCallback InjectionTransport::GetRawDataCallback() const
{
    std::lock_guard<std::mutex> lock(callbackMutex_);
    return callback_;
}

uint64_t InjectionTransport::GetCallbackFailedCount() const { return callbackFailedCount_.load(); }

uint64_t InjectionTransport::GetCallbackFailedBytes() const { return callbackFailedBytes_.load(); }

int32_t InjectionTransport::WaitAllCallbackDone(uint32_t timeoutSec) const
{
    std::unique_lock<std::mutex> lock(sendBufferMutex_);
    const auto timeout = std::chrono::seconds(timeoutSec);
    bool completed = sendBufferDoneCv_.wait_for(lock, timeout, [this]() { return pendingSendBuffers_.load() == 0; });
    if (!completed) {
        MSPROF_LOGE(
            "Wait injection send buffer done timeout, timeoutSec:%u, pending:%u.", timeoutSec,
            pendingSendBuffers_.load());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

} // namespace transport
} // namespace dvvp
} // namespace analysis
