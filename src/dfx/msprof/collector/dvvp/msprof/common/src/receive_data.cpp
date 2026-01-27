/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "receive_data.h"
#include "config/config.h"
#include "error_code.h"
#include "json_parser.h"
#include "prof_params.h"
#include "msprof_dlog.h"
#include "queue/ring_buffer.h"
#include "utils.h"
#ifndef MSPROF_LIB
#include "prof_reporter_mgr.h"
#endif

namespace Msprof {
namespace Engine {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::queue;
using namespace Msprofiler::Parser;
#ifndef MSPROF_LIB
using namespace Dvvp::Collect::Report;
#endif
ProfApiBufPopCallback ReceiveData::apiTryPop_;
ProfCompactBufPopCallback ReceiveData::compactTryPop_;
ProfAdditionalBufPopCallback ReceiveData::additionalTryPop_;
ProfReportBufEmptyCallback ReceiveData::reportBufEmpty_;
ProfBatchAddBufPopCallback ReceiveData::batchAdditionalTryPop_;
ProfBatchAddBufIndexShiftCallBack ReceiveData::batchAdditionalBufferIndexShift_;
ProfVarAddBlockBufPopCallback ReceiveData::varAdditionalTryPop_;
ProfVarAddBufIndexShiftCallBack ReceiveData::varAdditionalBufferIndexShift_;

ReceiveData::ReceiveData()
    : started_(false),
      stopped_(false),
      moduleName_(""),
      moduleId_(0),
      profileDataType_(ProfileDataType::MSPROF_DEFAULT_PROFILE_DATA_TYPE),
      totalPopCount_(0),
      totalPopSize_(0),
      timeStamp_(0),
      totalPushCount_(0),
      totalPushSize_(0),
      totalDataLengthFailed_(0) {}

ReceiveData::~ReceiveData()
{
    StopReceiveData();
}

/**
 * @name  DumpProfileData
 * @brief fill field of ProfileFileChunk in repot data and push to fileChunks vectors
 * @param [in] message : report data pop from report buffer
 * @param [out] fileChunks : data vector which need to upload and flush
 * @param [in] ageFlag : if need age
 * @param [in] key : type and level of data
 */
template<typename T>
void ReceiveData::DumpProfileData(std::vector<T> &message, std::vector<SHARED_PTR_ALIA<ProfileFileChunk>>& fileChunks,
    uint32_t ageFlag)
{
    if (!JsonParser::instance()->GetJsonModuleReporterSwitch(moduleId_)) {
        MSPROF_EVENT("GetJsonModuleReporterSwitch, moduleId_: %d", moduleId_);
        return;
    }

    SHARED_PTR_ALIA<ProfileFileChunk> fileChunk = nullptr;
    MSVP_MAKE_SHARED0_NODO(fileChunk, ProfileFileChunk, return);
    MSPROF_LOGD("Dump data, module:%s, level:%u, type:%u, data.size:%zu, ageFlag: %u",
        moduleName_.c_str(), message[0].level, message[0].type, sizeof(message[0]), ageFlag);
    if (DumpData(message, fileChunk, ageFlag) == PROFILING_SUCCESS) {
        fileChunks.push_back(fileChunk); // insert the data into the new vector
    } else {
        MSPROF_LOGE("Dump Received Data failed");
    }
}

/**
 * @name  ApiRun
 * @brief Try pop data from apiBuffer_ and separate into aging and unaging vectors
 * @param [out] fileChunks : data vector which need to upload and flush
 */
void ReceiveData::ApiRun(std::vector<SHARED_PTR_ALIA<ProfileFileChunk>>& fileChunks)
{
    // data binding with batchsize and ageFlag which need to be ordered
    std::vector<MsprofApi> ageVec;
    std::vector<MsprofApi> unageVec;
    uint64_t batchSizeMax = 0;
    uint32_t ageFlag = 1;
    for (; batchSizeMax < MSVP_BATCH_MAX_LEN;) {
        MsprofApi data;
        bool isOK = ReceiveData::apiTryPop_(ageFlag, data);
        if (!isOK) {
            break;
        }
        totalPopCount_++;
        totalPopSize_ += sizeof(MsprofApi);
        if (data.level == 0) {
            MSPROF_EVENT("Receive api data whose level equal to zero.");
            continue;
        }
        batchSizeMax += sizeof(MsprofApi);
        if (ageFlag == static_cast<uint32_t>(1)) {
            ageVec.push_back(data);
        } else {
            unageVec.push_back(data);
        }
    }

    if (ageVec.size() > 0) {
        DumpProfileData<MsprofApi>(ageVec, fileChunks, 1);
    }
 
    if (unageVec.size() > 0) {
        DumpProfileData<MsprofApi>(unageVec, fileChunks, 0);
    }
}

/**
 * @name  CompactRun
 * @brief Try pop data from compactBuffer_
 * @param [out] fileChunks : data vector which need to upload and flush
 */
void ReceiveData::CompactRun(std::vector<SHARED_PTR_ALIA<ProfileFileChunk>>& fileChunks)
{
    // data binding with tag and ageFlag
    std::unordered_map<std::string, std::vector<MsprofCompactInfo>> dataMap;
    uint64_t batchSizeMax = 0;
    uint32_t ageFlag = 1;
    MsprofCompactInfo data;
    for (; batchSizeMax < MSVP_BATCH_MAX_LEN;) {
        bool isOK = ReceiveData::compactTryPop_(ageFlag, data);
        if (!isOK) {
            break;
        }
        totalPopCount_++;
        totalPopSize_ += sizeof(MsprofCompactInfo);
        batchSizeMax += sizeof(ProfileFileChunk);
        std::string tagWizSuffix = std::to_string(data.level) + "." +
                                   std::to_string(data.type) + "." +
                                   std::to_string(ageFlag);
        // classify data by level and type
        dataMap[tagWizSuffix].push_back(data);
    }

    for (auto iter = dataMap.begin(); iter != dataMap.end(); ++iter) {
        if (iter->second.size() > 0) {
            if (Utils::GetInfoSuffix(iter->first) == "1") {
                DumpProfileData<MsprofCompactInfo>(iter->second, fileChunks, 1);
            } else {
                DumpProfileData<MsprofCompactInfo>(iter->second, fileChunks, 0);
            }
        }
    }
}

/**
 * @name  AdditionalRun
 * @brief Try pop data from additionalBuffer_
 * @param [out] fileChunks : data vector which need to upload and flush
 */
void ReceiveData::AdditionalRun(std::vector<SHARED_PTR_ALIA<ProfileFileChunk>>& fileChunks)
{
    // data binding with tag and ageFlag
    std::unordered_map<std::string, std::vector<MsprofAdditionalInfo>> dataMap;
    uint64_t batchSizeMax = 0;
    uint32_t ageFlag = 1;
    MsprofAdditionalInfo data;
    for (; batchSizeMax < MSVP_BATCH_MAX_LEN;) {
        bool isOK = ReceiveData::additionalTryPop_(ageFlag, data);
        if (!isOK) {
            break;
        }
        totalPopCount_++;
        totalPopSize_ += sizeof(MsprofAdditionalInfo);
        batchSizeMax += sizeof(ProfileFileChunk);
        std::string tagWizSuffix = std::to_string(data.level) + "." +
                                   std::to_string(data.type) + "." +
                                   std::to_string(ageFlag);
        // classify data by level and type
        dataMap[tagWizSuffix].push_back(data);
    }

    for (auto iter = dataMap.begin(); iter != dataMap.end(); ++iter) {
        if (iter->second.size() > 0) {
            if (Utils::GetInfoSuffix(iter->first) == "1") {
                DumpProfileData<MsprofAdditionalInfo>(iter->second, fileChunks, 1);
            } else {
                DumpProfileData<MsprofAdditionalInfo>(iter->second, fileChunks, 0);
            }
        }
    }
}

/**
 * @name  AdprofRun
 * @brief Try pop data from batchAdditionalBuffer_
 * @param [out] fileChunks : data vector which need to upload and flush
 */
void ReceiveData::AdprofRun(std::vector<SHARED_PTR_ALIA<ProfileFileChunk>>& fileChunks)
{
    uint64_t allStartTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
    size_t outSize = 524032; // 512K - 256 byte pack
    void *outPtr = ReceiveData::batchAdditionalTryPop_(outSize, true);
    if (outPtr == nullptr) {
        return;
    }
    totalPopSize_ += outSize;
    totalPopCount_ += 1;
    SHARED_PTR_ALIA<ProfileFileChunk> fileChunk = nullptr;
    MSVP_MAKE_SHARED0_NODO(fileChunk, ProfileFileChunk, return);
    uint64_t dumpStartTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
    DumpAdprofData(outPtr, outSize, fileChunk);
    fileChunks.push_back(fileChunk);
    uint64_t dumpEndTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
    ReceiveData::batchAdditionalBufferIndexShift_(outPtr, outSize);
    uint64_t allEndTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
    MSPROF_LOGD("Devprof handle data successfully, dump cost: %llu ns, all cost: %llu ns, data size: %zu",
        (dumpEndTime - dumpStartTime), (allEndTime - allStartTime), outSize);
}

/**
 * @name  VariableAdditionalRun
 * @brief Try pop data from variableAdditionalBuffer_
 * @param [out] fileChunks : data vector which need to upload and flush
 */
void ReceiveData::VariableAdditionalRun(std::vector<SHARED_PTR_ALIA<ProfileFileChunk>>& fileChunks)
{
    uint64_t allStartTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
    size_t outSize = 1048576;
    void *outPtr = ReceiveData::varAdditionalTryPop_(outSize);
    if (outPtr == nullptr) {
        return;
    }
    totalPopSize_ += outSize;
    totalPopCount_ += 1;
    SHARED_PTR_ALIA<ProfileFileChunk> fileChunk = nullptr;
    MSVP_MAKE_SHARED0_NODO(fileChunk, ProfileFileChunk, return);
    uint64_t dumpStartTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
    DumpVariableData(outPtr, outSize, fileChunk);
    fileChunks.push_back(fileChunk);
    uint64_t dumpEndTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
    ReceiveData::varAdditionalBufferIndexShift_(outPtr, outSize);
    uint64_t allEndTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
    MSPROF_LOGD("Variable block buffer handle data successfully, dump cost: %llu ns, all cost: %llu ns, data size: %zu",
        (dumpEndTime - dumpStartTime), (allEndTime - allStartTime), outSize);
}

void ReceiveData::RunProfileData(std::vector<SHARED_PTR_ALIA<ProfileFileChunk>>& fileChunks)
{
    switch (profileDataType_) {
        case ProfileDataType::MSPROF_API_PROFILE_DATA_TYPE:
            ApiRun(fileChunks);
            break;
        case ProfileDataType::MSPROF_COMPACT_PROFILE_DATA_TYPE:
            CompactRun(fileChunks);
            break;
        case ProfileDataType::MSPROF_ADDITIONAL_PROFILE_DATA_TYPE:
            AdditionalRun(fileChunks);
            break;
        case ProfileDataType::ADPROF_ADDITIONAL_PROFILE_DATA_TYPE:
            AdprofRun(fileChunks);
            break;
        case ProfileDataType::MSPROF_VARIABLE_ADDITIONAL_PROFILE_DATA_TYPE:
            VariableAdditionalRun(fileChunks);
            break;
        default:
            MSPROF_LOGE("Entry Run[%s] function is invalid.", moduleName_.c_str());
            break;
    }
}

void ReceiveData::StopReceiveData()
{
    stopped_ = true;
    MSPROF_LOGI("stop this reporter, stopped_: %d, module: %s", stopped_, moduleName_.c_str());
}

void ReceiveData::WriteDone()
{
}

void ReceiveData::TimedTask()
{
}

int32_t ReceiveData::SendData(SHARED_PTR_ALIA<ProfileFileChunk> fileChunk /* = nullptr */)
{
    UNUSED(fileChunk);
    MSPROF_LOGI("ReceiveData::SendData");
    return PROFILING_SUCCESS;
}

void ReceiveData::SetBufferEmptyEvent()
{
    std::lock_guard<std::mutex> lk(cvBufferEmptyMtx_);
    cvBufferEmpty_.notify_one();
}

void ReceiveData::WaitAllBufferEmptyEvent(uint64_t us)
{
    std::unique_lock<std::mutex> lk(cvBufferEmptyMtx_);
    MSPROF_LOGI("Wait all buf empty, moduleName:%s.", moduleName_.c_str());
    bool status;
    int cnt = 0;
    int maxWaitTimes = 3;
    do {
        status = cvBufferEmpty_.wait_for(lk, std::chrono::microseconds(us),
            [this] {
                return ReceiveData::reportBufEmpty_();
            });
        cnt++;
        MSPROF_LOGI("buffer status is:%d, wait all buf empty, moduleName:%s", status, moduleName_.c_str());
    } while (!status && cnt < maxWaitTimes);
}

/**
* @brief Flush: wait device buffer is empty
* @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
*/
int32_t ReceiveData::Flush()
{
    return PROFILING_SUCCESS;
}

/**
* @brief FlushAll: wait all buffer is empty
* @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
*/
int32_t ReceiveData::FlushAll()
{
    WaitAllBufferEmptyEvent(WAIT_BUFF_EMPTY_TIMEOUT_US);
    return PROFILING_SUCCESS;
}

void ReceiveData::PrintTotalSize()
{
    uint64_t totalPushCount = totalPushCount_.load(std::memory_order_relaxed);
    uint64_t totalPushSize = totalPushSize_.load(std::memory_order_relaxed);
    MSPROF_EVENT("total_size_report module:%s, push count:%" PRIu64 ", pop count:%" PRIu64 ", push size:%"
        PRIu64" bytes, pop size:%" PRIu64" bytes", moduleName_.c_str(), totalPushCount, totalPopCount_,
        totalPushSize, totalPopSize_);
}

int32_t ReceiveData::Init()
{
    if (moduleName_.find("api_event") != std::string::npos) {
        profileDataType_ = ProfileDataType::MSPROF_API_PROFILE_DATA_TYPE;
    } else if (moduleName_.find("compact") != std::string::npos) {
        profileDataType_ = ProfileDataType::MSPROF_COMPACT_PROFILE_DATA_TYPE;
    } else if (moduleName_.find("additional") != std::string::npos) {
        profileDataType_ = ProfileDataType::MSPROF_ADDITIONAL_PROFILE_DATA_TYPE;
    } else if (moduleName_.find("adprof") != std::string::npos) {
        profileDataType_ = ProfileDataType::ADPROF_ADDITIONAL_PROFILE_DATA_TYPE;
    } else if (moduleName_.find("variable") != std::string::npos) {
        profileDataType_ = ProfileDataType::MSPROF_VARIABLE_ADDITIONAL_PROFILE_DATA_TYPE;
    } else {
        MSPROF_LOGI("Module name does not support: %s.", moduleName_.c_str());
    }
    MSPROF_LOGI("init profileDataType_ is %d.", profileDataType_);
    return PROFILING_SUCCESS;
}

int32_t ReceiveData::DoReport(CONST_REPORT_DATA_PTR rData) const
{
    (void)rData;
    return PROFILING_SUCCESS;
}

void ReceiveData::DoReportRun()
{
    std::vector<SHARED_PTR_ALIA<ProfileFileChunk> > fileChunks;
    unsigned long sleepIntevalNs = 50000000; // 50,000,000 : 50ms
    timeStamp_ = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();

    for (;;) {
        fileChunks.clear();
        RunProfileData(fileChunks);
        size_t size = fileChunks.size();
        if (size == 0) {
            SetBufferEmptyEvent();
            if (stopped_) {
                WriteDone();
                MSPROF_LOGI("Exit the Run thread");
                break;
            }
            analysis::dvvp::common::utils::Utils::UsleepInterupt(SLEEP_INTEVAL_US);
            unsigned long long curTimeStamp = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
            if ((curTimeStamp - timeStamp_) >= sleepIntevalNs || (timeStamp_ == 0)) {
                TimedTask();
                timeStamp_ = curTimeStamp;
            }
            continue;
        }

        if (Dump(fileChunks) != PROFILING_SUCCESS) {
            MSPROF_LOGE("Dump Received Data failed");
        }
    }
}

int32_t ReceiveData::Dump(std::vector<SHARED_PTR_ALIA<ProfileFileChunk> > &message)
{
    UNUSED(message);
    MSPROF_LOGD("message size is : %zu", message.size());
    return PROFILING_SUCCESS;
}

void ReceiveData::DumpAdprofData(void *outPtr, size_t outSize, SHARED_PTR_ALIA<ProfileFileChunk> fileChunk) const
{
    if (fileChunk == nullptr) {
        MSPROF_LOGE("fileChunk or dataPool is nullptr");
        return;
    }

    fileChunk->fileName = "aicpu.data";
    fileChunk->offset = -1;
    fileChunk->chunk = std::string(reinterpret_cast<char *>(outPtr), outSize);
    fileChunk->isLastChunk = false;
    fileChunk->extraInfo = "null.0"; // set dev id 0 on rc mode
    fileChunk->chunkModule = analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_FROM_DEVICE;
    fileChunk->chunkSize = outSize;
}

void ReceiveData::DumpVariableData(void *outPtr, size_t outSize, SHARED_PTR_ALIA<ProfileFileChunk> fileChunk) const
{
    if (fileChunk == nullptr) {
        MSPROF_LOGE("fileChunk or dataPool is nullptr");
        return;
    }
    fileChunk->fileName = "unaging." + moduleName_ +
                "." + "capture_op_info";
    fileChunk->offset = -1;
    fileChunk->chunk = std::string(reinterpret_cast<CHAR_PTR>(outPtr), outSize);
    fileChunk->isLastChunk = false;
    fileChunk->extraInfo = "null.64";
    fileChunk->chunkModule = analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_FROM_MSPROF_HOST;
    fileChunk->chunkSize = outSize;
}

template<typename T>
int32_t ReceiveData::DumpData(std::vector<T> &message, SHARED_PTR_ALIA<ProfileFileChunk> fileChunk, uint32_t ageFlag)
{
    if (fileChunk == nullptr) {
        MSPROF_LOGE("fileChunk or dataPool is nullptr");
        return PROFILING_FAILED;
    }
    size_t chunkLen = 0;
#ifndef MSPROF_LIB
    bool needTypeInfo = true;
    if (typeid(MsprofApi) == typeid(T)) {
        needTypeInfo = false;
    }
#endif
    bool isFirstMessage = true;
    for (size_t i = 0; i < message.size(); i++) {
        int32_t messageLen = sizeof(T);
        CHAR_PTR dataPtr = reinterpret_cast<CHAR_PTR>(&message[i]);
        if (dataPtr == nullptr) {
            return PROFILING_FAILED;
        }
        if (isFirstMessage) { // deal with the data only need to init once
            std::string tag;
#ifndef MSPROF_LIB
            if (needTypeInfo) {
                ProfReporterMgr::GetInstance().GetReportTypeInfo(message[i].level, message[i].type, tag);
            } else {
                tag = "data";
            }
#endif
            fileChunk->fileName = ((ageFlag == static_cast<uint32_t>(1)) ? "aging." : "unaging.") + moduleName_ +
                "." + tag;
            fileChunk->offset = -1;
            chunkLen = messageLen;
            fileChunk->chunk = std::string(dataPtr, chunkLen);
            fileChunk->isLastChunk = false;
            fileChunk->extraInfo = "null.64";
            isFirstMessage = false;
            devIds_.insert(std::to_string(DEFAULT_HOST_ID));
        } else { // deal with the data need to update according every message
            fileChunk->chunk.insert(chunkLen, std::string(dataPtr, messageLen));
            chunkLen += messageLen;
        }
    }
    fileChunk->chunkModule = analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_FROM_MSPROF_HOST;
    fileChunk->chunkSize = chunkLen;
    return PROFILING_SUCCESS;
}

template int32_t ReceiveData::DumpData(std::vector<MsprofApi> &message,
    SHARED_PTR_ALIA<ProfileFileChunk> fileChunk, uint32_t ageFlag);
template int32_t ReceiveData::DumpData(std::vector<MsprofCompactInfo> &message,
    SHARED_PTR_ALIA<ProfileFileChunk> fileChunk, uint32_t ageFlag);
template int32_t ReceiveData::DumpData(std::vector<MsprofAdditionalInfo> &message,
    SHARED_PTR_ALIA<ProfileFileChunk> fileChunk, uint32_t ageFlag);
template void ReceiveData::DumpProfileData(std::vector<MsprofApi> &message,
    std::vector<SHARED_PTR_ALIA<ProfileFileChunk>>& fileChunks, uint32_t ageFlag);
template void ReceiveData::DumpProfileData(std::vector<MsprofCompactInfo> &message,
    std::vector<SHARED_PTR_ALIA<ProfileFileChunk>>& fileChunks, uint32_t ageFlag);
template void ReceiveData::DumpProfileData(std::vector<MsprofAdditionalInfo> &message,
    std::vector<SHARED_PTR_ALIA<ProfileFileChunk>>& fileChunks, uint32_t ageFlag);
}}
