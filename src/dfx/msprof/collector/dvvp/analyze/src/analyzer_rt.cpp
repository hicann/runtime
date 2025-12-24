/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "analyzer_rt.h"
#include "acl_prof.h"
#include "prof_api.h"

namespace Analysis {
namespace Dvvp {
namespace Analyze {
constexpr uint32_t RT_COMPACT_INFO_SIZE = sizeof(MsprofCompactInfo);

bool AnalyzerRt::IsRtCompactData(const std::string &tag) const
{
    if (tag.find("task_track") != std::string::npos) {
        return true;
    }

    return false;
}

void AnalyzerRt::RtCompactParse(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (fileChunkReq == nullptr) {
        return;
    }

    totalBytes_ += fileChunkReq->chunkSize;
    if (fileChunkReq->fileName.find("unaging") != std::string::npos) {
        MSPROF_LOGI("Start to analyze compact file: %s", fileChunkReq->fileName.c_str());
        ParseRuntimeTrackData(fileChunkReq->chunk.c_str(), fileChunkReq->chunkSize, false);
        return;
    } else if (fileChunkReq->fileName.find("aging") != std::string::npos && AnalyzerBase::opTypeFlag_) {
        MSPROF_LOGI("Start to analyze compact file: %s", fileChunkReq->fileName.c_str());
        ParseRuntimeTrackData(fileChunkReq->chunk.c_str(), fileChunkReq->chunkSize, true);
        return;
    }
}

void AnalyzerRt::ParseRuntimeTrackData(CONST_CHAR_PTR data, uint32_t len, bool ageFlag)
{
    std::unique_lock<std::mutex> lk(AnalyzerBase::rtThreadMtx_);
    AppendToBufferedData(data, len);
    uint32_t offset = 0;
    while (dataPtr_ != nullptr && offset < dataLen_) {
        uint32_t remainLen = dataLen_ - offset;
        if (remainLen < RT_COMPACT_INFO_SIZE) {
            MSPROF_LOGW("Runtime track remains %u bytes unparsed, which is incomplete data", remainLen);
            break;
        }

        auto rtData = reinterpret_cast<const MsprofCompactInfo *>(dataPtr_ + offset);
        MSPROF_LOGD("ParseRuntimeTrackData level: %hu.", rtData->level);
        if (rtData->level == MSPROF_REPORT_RUNTIME_LEVEL) {
            HandleRuntimeTrackData(dataPtr_ + offset, ageFlag);
            totalRtTimes_++;
        }

        offset += RT_COMPACT_INFO_SIZE;
        analyzedBytes_ += RT_COMPACT_INFO_SIZE;
    }
    BufferRemainingData(offset);
    MatchDeviceOpInfo(AnalyzerBase::rtOpInfo_, AnalyzerBase::tsTmpOpInfo_, AnalyzerBase::geOpInfo_);
}

void AnalyzerRt::HandleRuntimeTrackData(CONST_CHAR_PTR data, bool ageFlag) const
{
    auto compactData = reinterpret_cast<const MsprofCompactInfo *>(data);
    auto rtData = compactData->data.runtimeTrack;
    std::string key;
    if (IsExtPmu()) {
        key = std::to_string(rtData.taskId);
    } else {
        key = std::to_string(rtData.taskId) + KEY_SEPARATOR + std::to_string(rtData.streamId);
        auto hostIter = AnalyzerBase::rtOpInfo_.find(key);
        if (hostIter != AnalyzerBase::rtOpInfo_.end()) {
            EraseRtMapByStreamId(rtData.streamId, AnalyzerBase::rtOpInfo_);
            MSPROF_LOGD("Delete repeat runtime track data with same key. taskId: %u, streamId: %u.",
                rtData.taskId, rtData.streamId);
        }
    }

    RtOpInfo opInfo = {compactData->timeStamp, 0, 0, compactData->threadId, ageFlag, 0, 0, ACL_SUBSCRIBE_OP,
        UINT16_MAX, rtData.deviceId};
    AnalyzerBase::rtOpInfo_[key] = opInfo;
    MSPROF_LOGD("host aging data not found, insert runtime track data in rtOpInfo map"
        ", key: %s, timeStamp: %" PRIu64 ", age: %d", key.c_str(), compactData->timeStamp, ageFlag);
}

void AnalyzerRt::MatchDeviceOpInfo(std::map<std::string, RtOpInfo> &rtOpInfo,
    std::multimap<std::string, RtOpInfo> &tsTmpOpInfo,
    std::multimap<uint32_t, GeOpFlagInfo> &geOpInfo) const
{
    if (tsTmpOpInfo.empty()) {
        return;
    }
    for (auto devIter = tsTmpOpInfo.begin(); devIter != tsTmpOpInfo.end();) {
        auto hostIter = rtOpInfo.find(devIter->first);
        if (hostIter == rtOpInfo.end()) {
            devIter++;
            continue;
        }
        devIter->second.threadId = hostIter->second.threadId;
        devIter->second.tsTrackTimeStamp = hostIter->second.tsTrackTimeStamp;
        MSPROF_LOGD("Success to merge runtime track and Hwts|Ffts data in rt back. timestamp: %" PRIu64 ", "
            "threadId: %u, taskId+streamId: %s, start: %" PRIu64 ", end: %" PRIu64 ", "
            "startAicore: %" PRIu64 ", endAicore: %" PRIu64 ", contextId: %u, age: %d",
            hostIter->second.tsTrackTimeStamp, devIter->second.threadId, devIter->first.c_str(),
            devIter->second.start, devIter->second.end, devIter->second.startAicore, devIter->second.endAicore,
            devIter->second.contextId, hostIter->second.ageFlag);
        if (geOpInfo.empty()) {
            AnalyzerBase::devTmpOpInfo_.emplace_back(std::move(devIter->second));
            tsTmpOpInfo.erase(devIter++);
            continue;
        }
        bool ifUpload = false;
        auto threadGroup = geOpInfo.equal_range(devIter->second.threadId);
        if (threadGroup.first != geOpInfo.end()) {
            for (auto geIter = threadGroup.first; geIter != threadGroup.second; ++geIter) {
                if (devIter->second.tsTrackTimeStamp > geIter->second.end ||
                    devIter->second.tsTrackTimeStamp <= geIter->second.start) { // time include
                    continue;
                }
                ConstructAndUploadOptimizeData(geIter->second, devIter->second);
                ifUpload = true;
                tsTmpOpInfo.erase(devIter++);
                break;
            }
        }
        if (!ifUpload) {
            AnalyzerBase::devTmpOpInfo_.emplace_back(std::move(devIter->second));
            tsTmpOpInfo.erase(devIter++);
        }
    }
}

void AnalyzerRt::PrintStats() const
{
    MSPROF_EVENT("total_size_analyze, module: RT, analyzed %" PRIu64 ", total %" PRIu64 ", rt time %u, merge %u",
        analyzedBytes_,
        totalBytes_,
        totalRtTimes_,
        totalRtMerges_);
}

}
}
}
