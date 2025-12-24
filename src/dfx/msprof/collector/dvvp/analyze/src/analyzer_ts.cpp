/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "analyzer_ts.h"
#include "acl_prof.h"

namespace Analysis {
namespace Dvvp {
namespace Analyze {

bool AnalyzerTs::IsTsData(const std::string &fileName)
{
    // ts data contains "ts_track.data"
    if (fileName.find("ts_track.data") != std::string::npos) {
        return true;
    }
    return false;
}

void AnalyzerTs::Parse(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (fileChunkReq == nullptr) {
        return;
    }
    MSPROF_LOGI("Start to analyze device file: %s", fileChunkReq->fileName.c_str());
    totalBytes_ += fileChunkReq->chunkSize;
    ParseTsTrackData(fileChunkReq->chunk.c_str(), fileChunkReq->chunkSize);
}

void AnalyzerTs::ParseTsTrackData(CONST_CHAR_PTR data, uint32_t len)
{
    std::unique_lock<std::mutex> lk(AnalyzerBase::tsThreadMtx_);
    AppendToBufferedData(data, len);
    uint32_t offset = 0;
    while (dataPtr_ != nullptr && offset < dataLen_) {
        uint32_t remainingLen = dataLen_ - offset;
        if (remainingLen < sizeof(TsProfileDataHead)) {
            // remaining is less then TsProfileDataHead, cache it to buffer
            MSPROF_LOGI("Ts remains %u bytes unparsed, cache it", remainingLen);
            break;
        }
        auto tsHeader = reinterpret_cast<const TsProfileDataHead *>(dataPtr_ + offset);
        if (tsHeader->bufSize == 0) {
            // invalid data, reset buffer
            MSPROF_LOGE("TsHeader buf size is 0, invalid data");
            BufferRemainingData(dataLen_);
            return;
        }
        if (remainingLen < tsHeader->bufSize) {
            // remaining is not enough for bufSize to parse, cache it to buffer
            MSPROF_LOGI("Ts remains %u bytes unparsed, bufSize %u, cache it", remainingLen, tsHeader->bufSize);
            break;
        }
        if (tsHeader->rptType == TS_TIMELINE_RPT_TYPE) {
            // data check ok, parse it
            ParseTsTimelineData(dataPtr_ + offset, remainingLen);
        } else if (tsHeader->rptType == TS_KEYPOINT_RPT_TYPE) {
            ParseTsKeypointData(dataPtr_ + offset, remainingLen);
        }
        offset += tsHeader->bufSize;
    }
    MSPROF_LOGI("Finish parsing tstrack data, offset: %u, total len: %u, from buffered len: %u, "
                "op time collected %zu, draft %zu",
        offset,
        dataLen_,
        dataLen_ - len,
        opTimes_.size(),
        opTimeDrafts_.size());
    BufferRemainingData(offset);
}

void AnalyzerTs::ParseTsTimelineData(CONST_CHAR_PTR data, uint32_t len)
{
    if (len >= sizeof(TsProfileTimeline)) {
        auto tsData = reinterpret_cast<const TsProfileTimeline *>(data);
        std::string key = std::to_string(tsData->taskId) + KEY_SEPARATOR + std::to_string(tsData->streamId) +
                          KEY_SEPARATOR + std::to_string(UINT32_MAX);
        std::string optKey = std::to_string(tsData->taskId) + KEY_SEPARATOR + std::to_string(tsData->streamId);
        auto iter = opTimeDrafts_.find(key);
        if (iter == opTimeDrafts_.end()) {
            OpTime opTime = {0, 0, 0, 0, 0, 0, ACL_SUBSCRIBE_OP, tsData->streamId};
            iter = opTimeDrafts_.insert(std::make_pair(key, opTime)).first;
        }
        switch (tsData->taskState) {
            case TS_TIMELINE_START_TASK_STATE:
                iter->second.start = static_cast<uint64_t>(tsData->timestamp / frequency_);
                break;
            case TS_TIMELINE_AICORE_START_TASK_STATE:
                iter->second.startAicore = static_cast<uint64_t>(tsData->timestamp / frequency_);
                break;
            case TS_TIMELINE_AICORE_END_TASK_STATE:
                iter->second.endAicore = static_cast<uint64_t>(tsData->timestamp / frequency_);
                break;
            case TS_TIMELINE_END_TASK_STATE:
                iter->second.end = static_cast<uint64_t>(tsData->timestamp / frequency_);
                break;
            default:
                MSPROF_LOGD("AnalyzerTs dropped timeline task state: %u", tsData->taskState);
        }
        if (iter->second.start > 0 && iter->second.startAicore > 0 && iter->second.endAicore > 0 &&
            iter->second.end > 0) {
            RtOpInfo devOpInfo = {0, iter->second.start, iter->second.end, 0, true, iter->second.startAicore,
                iter->second.endAicore, ACL_SUBSCRIBE_OP, UINT16_MAX, 0};
            HandleDeviceData(optKey, devOpInfo, totalTsMerges_);
            MSPROF_LOGD("Ts op time collected, key %s, start %" PRIu64 ", end %" PRIu64,
                key.c_str(),
                iter->second.start,
                iter->second.end);
            opTimes_.insert(std::make_pair(iter->first, iter->second));
            opTimeCount_++;
            opTimeDrafts_.erase(iter);
        }
        analyzedBytes_ += sizeof(TsProfileTimeline);
    }
}

void AnalyzerTs::ParseTsKeypointData(CONST_CHAR_PTR data, uint32_t len)
{
    if (len < sizeof(TsProfileKeypoint)) {
        return;
    }

    auto tsData = reinterpret_cast<const TsProfileKeypoint *>(data);
    if (tsData->head.bufSize != sizeof(TsProfileKeypoint) || tsData->timestamp == 0) {
        MSPROF_LOGE("keypoint op error. bufSize %" PRIu64 " bytes, struct_len %u, "
            "indexId %" PRIu64 ", taskId %u, streamId %u, timestamp %" PRIu64, tsData->head.bufSize,
            sizeof(TsProfileKeypoint), tsData->indexId, tsData->taskId, tsData->streamId, tsData->timestamp);
        return;
    }

    std::string key = std::to_string(tsData->modelId) + KEY_SEPARATOR + std::to_string(tsData->indexId);
    auto iter = keypointOpInfo_.find(key);
    if (tsData->tagId == TS_KEYPOINT_START_TASK_STATE) {
        if (iter != keypointOpInfo_.end()) {
            MSPROF_LOGE("Reapted start key point. modelId %" PRIu64 ", indexId %" PRIu64 ", taskId %u, streamId %u, "
                "previous taskId %u, previous streamId %u", tsData->modelId, tsData->indexId, tsData->taskId,
                tsData->streamId, iter->second.taskId, iter->second.streamId);
            return;
        }

        KeypointOp opData = {0, 0, 0, 0, 0, 0, 0, 0};
        opData.startTime = static_cast<uint64_t>(tsData->timestamp / frequency_);
        opData.indexId = tsData->indexId;
        opData.modelId = tsData->modelId;
        opData.streamId = tsData->streamId;
        opData.taskId = tsData->taskId;
        opData.uploaded = false;
        keypointOpInfo_[key] = opData;
    } else if (tsData->tagId == TS_KEYPOINT_END_TASK_STATE) {
        if (iter == keypointOpInfo_.end()) {
            MSPROF_LOGW("Start key point is not found. modelId %" PRIu64 ", indexId %" PRIu64 ", taskId %u, "
                "streamId %u", tsData->modelId, tsData->indexId, tsData->taskId, tsData->streamId);
            return;
        }

        KeypointOp &curOp = iter->second;
        uint64_t ts = static_cast<uint64_t>(tsData->timestamp / frequency_);
        if (curOp.endTime != 0 || ts <= curOp.startTime) {
            MSPROF_LOGE("keypoint op error. modelId %" PRIu64 ", indexId %" PRIu64 ", taskId %u, streamId %u, "
                "previous taskId %u, previous streamId %u, startTime %" PRIu64 ", endTime %" PRIu64 ", "
                "timestamp %" PRIu64, tsData->modelId, tsData->indexId, tsData->taskId, tsData->streamId,
                curOp.taskId, curOp.streamId, curOp.startTime, curOp.endTime, ts);
            return;
        } else {
            curOp.endTime = ts;
            MSPROF_LOGD("keypoint op: startTime %" PRIu64 ", endTime %" PRIu64 ", indexId=%" PRIu64 ", endSyscnt %"
                PRIu64, curOp.startTime, curOp.endTime, curOp.indexId, tsData->timestamp);
        }
    } else {
        MSPROF_LOGE("keypoint tagId error. tagId %u", tsData->tagId);
        return;
    }
    analyzedBytes_ += sizeof(TsProfileKeypoint);
}

void AnalyzerTs::PrintStats()
{
    uint64_t times = 0;
    if (!keypointOpInfo_.empty()) {
        times = keypointOpInfo_.begin()->second.findSuccTimes;
    }
    MSPROF_EVENT("total_size_analyze, module: TS, analyzed %" PRIu64 ", total %" PRIu64 ", op time total %" PRIu64 ", "
                 "remain %zu, draft %zu. remain keypoint op %zu, last step find op %" PRIu64 ", merge time %u",
        analyzedBytes_,
        totalBytes_,
        opTimeCount_,
        opTimes_.size(),
        opTimeDrafts_.size(),
        keypointOpInfo_.size(),
        times,
        totalTsMerges_);
}
}  // namespace Analyze
}  // namespace Dvvp
}  // namespace Analysis
