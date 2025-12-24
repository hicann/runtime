/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_TRANSPORT_HASH_DATA_H
#define ANALYSIS_DVVP_TRANSPORT_HASH_DATA_H
#include <map>
#include <unordered_map>
#include <mutex>
#include <string>
#include "singleton/singleton.h"
#include "utils/utils.h"
#include "thread/thread.h"
#include "prof_api.h"

namespace analysis {
namespace dvvp {
namespace transport {
using namespace analysis::dvvp::common::utils;

class HashData : public analysis::dvvp::common::singleton::Singleton<HashData> {
public:
    HashData();
    ~HashData() override;

public:
    int32_t Init();
    int32_t Uninit();
    bool IsInit() const;
    void SaveHashData(int32_t devId);
    void SaveNewHashData(bool isLastChunk);
    int32_t GetHashKeys(std::string &saveHashData);
    std::string &GetHashInfo(uint64_t hashId);
    uint64_t GenHashId(const std::string &hashInfo);
    uint64_t GenHashId(const std::string &module, CONST_CHAR_PTR data, uint32_t dataLen);

private:
    uint64_t DoubleHash(const std::string &data) const;
    void FillPbData(const std::string &module, int32_t upDevId, const std::string &saveHashData,
                    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk, bool isLastChunk) const;
    void FillPbData(int32_t upDevId, const std::string &saveHashData,
                    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk, bool isLastChunk) const;
private:
    bool inited_;
    std::mutex initMutex_;
    std::mutex hashMutex_;
    size_t readIndex_;
    bool readStatus_;
    std::vector<std::pair<uint64_t, std::string>> hashVector_;
    std::unordered_map<std::string, uint64_t> hashInfoMap_;   // <hashInfo, hashId>
    std::unordered_map<uint64_t, std::string> hashIdMap_;   // <hashId, hashInfo>
    std::map<std::string, std::shared_ptr<std::mutex>> hashMapMutex_;       // <module, hashMutex>
    std::map<std::string, std::map<std::string, uint64_t>> hashDataKeyMap_; // <module, <data, hashId>>
    std::map<std::string, std::map<uint64_t, std::string>> hashIdKeyMap_;   // <module, <hashId, data>>
};

}
}
}
#endif
