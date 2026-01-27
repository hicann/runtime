/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "hash_data.h"
#include "config/config.h"
#include "errno/error_code.h"
#include "uploader_mgr.h"
#include "receive_data.h"
#include "osal.h"

namespace analysis {
namespace dvvp {
namespace transport {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::config;
using namespace Msprof::Engine;
using namespace Analysis::Dvvp::MsprofErrMgr;

HashData::HashData() : inited_(false), readIndex_(0), readStatus_(true) {}

HashData::~HashData()
{
    (void)Uninit();  // clean sc warning
}

int32_t HashData::Init()
{
    std::lock_guard<std::mutex> lock(initMutex_);
    readStatus_ = true;
    if (inited_) {
        MSPROF_LOGW("HashData repeated initialize");
        return PROFILING_SUCCESS;
    }
    for (auto &module : MSPROF_MODULE_ID_NAME_MAP) {
        // init hashMapMutex_
        SHARED_PTR_ALIA<std::mutex> mapMutex = nullptr;
        MSVP_MAKE_SHARED0(mapMutex, std::mutex, return PROFILING_FAILED);
        hashMapMutex_.insert(std::make_pair(module.name, mapMutex));
        // init hashDataKeyMap_
        std::map<std::string, uint64_t> hashDataMap;
        hashDataKeyMap_.insert(std::make_pair(module.name, hashDataMap));
        // init hashIdKeyMap_
        std::map<uint64_t, std::string> hashIdMap;
        hashIdKeyMap_.insert(std::make_pair(module.name, hashIdMap));
    }
    inited_ = true;
    MSPROF_LOGI("HashData initialize success");
    return PROFILING_SUCCESS;
}

int32_t HashData::Uninit()
{
    hashDataKeyMap_.clear();
    hashIdKeyMap_.clear();
    hashMapMutex_.clear();
    hashInfoMap_.clear();
    hashIdMap_.clear();
    inited_ = false;
    MSPROF_LOGI("HashData uninitialize success");
    return PROFILING_SUCCESS;
}

bool HashData::IsInit() const
{
    return inited_;
}

uint64_t HashData::DoubleHash(const std::string &data) const
{
    const uint32_t uint32Bits = 32;   // the number of uint32_t bits
    uint32_t prime[2] = { 29, 131 };  // hash step size,
    uint32_t hash[2] = { 0 };

    for (const char d : data) {
        hash[0] = hash[0] * prime[0] + d;
        hash[1] = hash[1] * prime[1] + d;
    }

    return (((static_cast<uint64_t>(hash[0])) << uint32Bits) | hash[1]);
}

uint64_t HashData::GenHashId(const std::string &module, CONST_CHAR_PTR data, uint32_t dataLen)
{
    if (hashMapMutex_.find(module) == hashMapMutex_.end()) {
        MSPROF_LOGE("HashData not support module:%s", module.c_str());
        return 0;
    }

    std::string strData(data, dataLen);
    std::lock_guard<std::mutex> lock(*hashMapMutex_[module]);
    auto &moduleHashData = hashDataKeyMap_[module];
    const auto iter = moduleHashData.find(strData);
    if (iter != moduleHashData.end()) {
        return iter->second;
    } else {
        const uint64_t hashId = DoubleHash(strData);
        moduleHashData[strData] = hashId;
        auto &moduleHashId = hashIdKeyMap_[module];
        if (moduleHashId.find(hashId) != moduleHashId.end()) {
            MSPROF_LOGW("HashData GenHashId conflict, hashId:%" PRIu64 " oldStr:%s newStr:%s", hashId,
                        moduleHashId[hashId].c_str(), strData.c_str());
        } else {
            moduleHashId[hashId] = strData;
        }
        MSPROF_LOGD("HashData GenHashId id:%" PRIu64 " data:%s", hashId, strData.c_str());
        return hashId;
    }
}

uint64_t HashData::GenHashId(const std::string &hashInfo)
{
    if (hashInfo.empty()) {
        MSPROF_LOGE("HashData hashInfo is empty().");
        return std::numeric_limits<uint64_t>::max();
    }

    std::lock_guard<std::mutex> lock(hashMutex_);
    const auto iter = hashInfoMap_.find(hashInfo);
    if (iter != hashInfoMap_.cend()) {
        return iter->second;
    }

    uint64_t hashId = DoubleHash(hashInfo);
    hashInfoMap_[hashInfo] = hashId;
    std::pair<uint64_t, std::string> tmpHashInfo(hashId, hashInfo);
    hashVector_.emplace_back(tmpHashInfo);
    if (hashIdMap_.find(hashId) != hashIdMap_.end()) {
        MSPROF_LOGW("HashData GenHashId conflict, hashId:%" PRIu64 " oldStr:%s newStr:%s", hashId,
                    hashIdMap_[hashId].c_str(), hashInfo.c_str());
    } else {
        hashIdMap_[hashId] = hashInfo;
    }
    MSPROF_LOGD("HashData GenHashId id:%" PRIu64 " data:%s", hashId, hashInfo.c_str());
    return hashId;
}

std::string &HashData::GetHashInfo(uint64_t hashId)
{
    static std::string empty;
    std::lock_guard<std::mutex> lock(hashMutex_);
    const auto iter = hashIdMap_.find(hashId);
    if (iter != hashIdMap_.cend()) {
        return iter->second;
    } else {
        MSPROF_LOGW("HashData not find hashId:%" PRIu64, hashId);
        return empty;
    }
}

void HashData::FillPbData(int32_t upDevId, const std::string &saveHashData,
                          SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk, bool isLastChunk) const
{
    FillPbData("unaging.additional", upDevId, saveHashData, fileChunk, isLastChunk);
}

void HashData::FillPbData(const std::string &module, int32_t upDevId, const std::string &saveHashData,
                          SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk, bool isLastChunk) const
{
    fileChunk->fileName = Utils::PackDotInfo(module, HASH_TAG);
    fileChunk->offset = -1;
    fileChunk->isLastChunk = isLastChunk;
    fileChunk->chunk = saveHashData;
    fileChunk->chunkSize = saveHashData.size();
    fileChunk->chunkModule = FileChunkDataModule::PROFILING_IS_FROM_MSPROF_HOST;
    fileChunk->extraInfo = Utils::PackDotInfo(std::to_string(upDevId), std::to_string(upDevId));
}

void HashData::SaveHashData(int32_t devId)
{
    if ((devId != MSVP_MAX_DEV_NUM)) {
        MSPROF_LOGI("HashData devId %d is invalid", devId);
        return;
    }

    if (!inited_) {
        MSPROF_LOGW("HashData not inited");
        return;
    }
    for (auto &module : MSPROF_MODULE_ID_NAME_MAP) {
        std::lock_guard<std::mutex> lock(*hashMapMutex_[module.name]);
        if (hashDataKeyMap_[module.name].empty()) {
            MSPROF_LOGI("HashData is null, module:%s", module.name.c_str());
            continue;
        }
        // combined hash map data
        std::string saveHashData;
        for (auto &data : hashDataKeyMap_[module.name]) {
            saveHashData.append(std::to_string(data.second) + HASH_DIC_DELIMITER + data.first + "\n");
        }
        // construct ProfileFileChunk data
        SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk = nullptr;
        MSVP_MAKE_SHARED0_NODO(fileChunk, analysis::dvvp::ProfileFileChunk, break);
        FillPbData(module.name, DEFAULT_HOST_ID, saveHashData, fileChunk, true);
        // upload ProfileFileChunk data
        const int32_t ret =
            analysis::dvvp::transport::UploaderMgr::instance()->UploadData(std::to_string(DEFAULT_HOST_ID), fileChunk);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("HashData upload data failed, module:%s, dataLen:%zu bytes", module.name.c_str(),
                        saveHashData.size());
            continue;
        }
        MSPROF_EVENT("total_size_HashData, module:%s, saveLen:%zu bytes, dataKeyMapSize:%zu bytes,"
                     "idKeyMapSize:%zu bytes",
                     module.name.c_str(), saveHashData.size(), hashDataKeyMap_[module.name].size(),
                     hashIdKeyMap_[module.name].size());
    }
    SaveNewHashData(true);
    readIndex_ = 0;
    readStatus_ = false;
}

void HashData::SaveNewHashData(bool isLastChunk)
{
    if (!inited_) {
        MSPROF_LOGW("HashData not inited");
        return;
    }
    std::unique_lock<std::mutex> lock(hashMutex_);
    // check whether the last save is stopped.
    if (!readStatus_) {
        readStatus_ = true;
        return;
    }
    // combined hash map data
    std::string saveHashData;
    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    UploaderMgr::instance()->GetUploader(std::to_string(DEFAULT_HOST_ID), uploader);
    if (uploader == nullptr || readIndex_ == hashVector_.size()) {
        return;
    }
    // combined hash map data
    const size_t currentHashSize = hashVector_.size();
    for (size_t i = readIndex_; i < currentHashSize; i++) {
        saveHashData.append(std::to_string(hashVector_[i].first) + HASH_DIC_DELIMITER + hashVector_[i].second + "\n");
    }
    readIndex_ = currentHashSize;
    lock.unlock();
    // construct ProfileFileChunk data
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk = nullptr;
    MSVP_MAKE_SHARED0_NODO(fileChunk, analysis::dvvp::ProfileFileChunk, return );
    FillPbData(DEFAULT_HOST_ID, saveHashData, fileChunk, isLastChunk);
    // upload ProfileFileChunk data
    const int32_t ret =
        analysis::dvvp::transport::UploaderMgr::instance()->UploadData(std::to_string(DEFAULT_HOST_ID), fileChunk);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("HashData upload data failed, dataLen:%zu", saveHashData.size());
    }
    MSPROF_EVENT("total_size_HashData, saveLen:%zu bytes, hashIdMap size:%zu bytes, hashInfoMap size:%zu bytes",
                 saveHashData.size(), hashIdMap_.size(), hashInfoMap_.size());
}

/**
 * @brief return hash data keys string seperated by HASH_DIC_DELIMITER
 * @param [in] std:string: saveHashData
 * @return 0:SUCCESS, !0:FAILED
 */
int32_t HashData::GetHashKeys(std::string &saveHashData) {
    std::unique_lock<std::mutex> lock(hashMutex_);
    // combined hash map data
    const size_t currentHashSize = hashVector_.size();
    uint32_t times = 0;
    for (size_t i = 0; i < currentHashSize; i++) {
        try {
            saveHashData.append(hashVector_[i].second);
            saveHashData.append(STR2ID_DELIMITER);
            times++;
        } catch (const std::length_error& e) {
            MSPROF_LOGW("getHashKeys std::length error");
            return PROFILING_FAILED;
        }
    }
    MSPROF_LOGD("get hash keys num:%u from hashVector:%u", times, currentHashSize);
    return PROFILING_SUCCESS;
}

}
}
}
