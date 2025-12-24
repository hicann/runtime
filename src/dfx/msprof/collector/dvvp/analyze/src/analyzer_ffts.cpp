/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "analyzer_ffts.h"
#include "analyzer_hwts.h"
#include "acl_prof.h"
#include "data_struct.h"

namespace Analysis {
namespace Dvvp {
namespace Analyze {
using namespace analysis::dvvp::common::utils;
constexpr uint16_t TS_MASK_BIT0_BIT1   = 0x3U;    // 0b11
constexpr uint16_t TS_MASK_BIT0_BIT11  = 0x0FFFU; // take significant bit0~11
constexpr uint16_t TS_MASK_BIT12       = 0x1000U; // bit12 indicate whether taskId is update
constexpr uint16_t TS_MASK_BIT13_BIT15 = 0xE000U; // take significant bit13~15
constexpr uint16_t TS_MASK_BIT12_BIT15 = 0xF000U; // take significant bit12~15
constexpr uint16_t TS_UPDATE_FOR_ALL   = 0b10;
constexpr uint16_t TS_UPDATE_FLAG_BIT  = 12U;
constexpr uint32_t CLOUD_V3_LOG_DATA_SIZE = 32;

bool AnalyzerFfts::IsFftsData(const std::string &fileName) const
{
    // "ffts.data"
    if (fileName.find("stars_soc.data") != std::string::npos) {
        return true;
    }
    return false;
}

void AnalyzerFfts::PrintStats() const
{
    MSPROF_EVENT("total_size_analyze, module: FFTS, analyzed %" PRIu64 ", total %" PRIu64 ", "
                 "ffts time %u, merge %u",
        analyzedBytes_,
        totalBytes_,
        totalFftsTimes_,
        totalFftsMerges_);
}

void AnalyzerFfts::FftsParse(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (fileChunkReq == nullptr) {
        return;
    }
    MSPROF_LOGI("Start to analyze device file: %s", fileChunkReq->fileName.c_str());
    totalBytes_ += fileChunkReq->chunkSize;
    ParseOptimizeFftsData(fileChunkReq->chunk.c_str(), fileChunkReq->chunkSize);
}

void AnalyzerFfts::ParseOptimizeFftsData(CONST_CHAR_PTR data, uint32_t len)
{
    AppendToBufferedData(data, len);
    uint32_t opNum = 0;
    uint32_t curLen = 0;
    uint32_t unknownOpNum = 0;
    uint32_t dataSize = STARS_DATA_SIZE;
    if (IsExtPmu()) {
        dataSize = CLOUD_V3_LOG_DATA_SIZE;
    }
    while (dataPtr_ != nullptr && curLen < dataLen_) {
        const uint32_t remainLen = dataLen_ - curLen;
        if (remainLen < dataSize) {
            MSPROF_LOGW("Ffts remains %u bytes unparsed, which is incomplete data", remainLen);
            break;
        }
        const StarsLogHead *logHead = Utils::ReinterpretCast<const StarsLogHead, const char>(dataPtr_ + curLen);
        const uint32_t logType = logHead->logType;
        if (IsExtPmu() && (logType == ACSQ_TASK_START_FUNC_TYPE || logType == ACSQ_TASK_END_FUNC_TYPE)) {
            const DavidAcsqLog *acsqData = Utils::ReinterpretCast<const DavidAcsqLog, const StarsLogHead>(logHead);
            HandleOptimizeAcsqTaskData(acsqData, logType);
        } else if (logType == ACSQ_TASK_START_FUNC_TYPE || logType == ACSQ_TASK_END_FUNC_TYPE) {
            const StarsAcsqLog *acsqData = Utils::ReinterpretCast<const StarsAcsqLog, const StarsLogHead>(logHead);
            HandleOptimizeAcsqTaskData(acsqData, logType);
        } else if (logType == FFTS_SUBTASK_THREAD_START_FUNC_TYPE || logType == FFTS_SUBTASK_THREAD_END_FUNC_TYPE) {
            const StarsCxtLog *cxtData = Utils::ReinterpretCast<const StarsCxtLog, const StarsLogHead>(logHead);
            HandleOptimizeSubTaskThreadData(cxtData, logType);
        } else {
            MSPROF_LOGD("unknownOp ffts op. logType:%u", logType);
            unknownOpNum++;
        }
        opNum += 1;
        curLen += dataSize;
        analyzedBytes_ += dataSize;
        totalFftsTimes_++;
    }
    BufferRemainingData(curLen);
}

template<typename T>
void AnalyzerFfts::HandleOptimizeAcsqTaskData(const T *acsqLog, uint32_t logType)
{
    uint16_t taskId = acsqLog->taskId;
    uint16_t streamId = acsqLog->streamId;
    std::string key;
    if (IsExtPmu()) {
        key = std::to_string(taskId);
    } else {
        StarsRollBackStreamTaskId(&streamId, &taskId);
        key = std::to_string(taskId) + KEY_SEPARATOR + std::to_string(streamId);
    }

    auto devIter = AnalyzerBase::tsOpInfo_.find(key);
    if (devIter == AnalyzerBase::tsOpInfo_.end()) {
        RtOpInfo opInfo = {0, 0, 0, 0, true, 0, 0, ACL_SUBSCRIBE_OP, UINT16_MAX, 0};
        devIter = AnalyzerBase::tsOpInfo_.insert(std::make_pair(key, opInfo)).first;
    }
    constexpr uint32_t offsetBit = 32;
    uint64_t sysTime = ((static_cast<uint64_t>(acsqLog->sysCountHigh) << offsetBit) | acsqLog->sysCountLow);
    sysTime = sysTime / frequency_;
    switch (logType) {
        case ACSQ_TASK_START_FUNC_TYPE:
            devIter->second.start = sysTime;
            break;
        case ACSQ_TASK_END_FUNC_TYPE:
            devIter->second.end = sysTime;
            break;
        default:
            MSPROF_LOGE("Failed to parse start or end time in AcsqTaskData");
            break;
    }

    if (devIter->second.start > 0 && devIter->second.end > 0) {
        HandleDeviceData(key, devIter->second, totalFftsMerges_);
    }
}

void AnalyzerFfts::HandleOptimizeSubTaskThreadData(const StarsCxtLog *cxtLog, uint32_t logType)
{
    uint16_t taskId = cxtLog->taskId;
    uint16_t streamId = cxtLog->streamId;
    StarsRollBackStreamTaskId(&streamId, &taskId);
    std::string key = std::to_string(taskId) + KEY_SEPARATOR + std::to_string(streamId);
    auto devIter = AnalyzerBase::tsOpInfo_.find(key);
    if (devIter == AnalyzerBase::tsOpInfo_.end()) {
        RtOpInfo opInfo = {0, 0, 0, 0, true, 0, 0, ACL_SUBSCRIBE_OP_THREAD, cxtLog->cxtId, 0};
        devIter = AnalyzerBase::tsOpInfo_.insert(std::make_pair(key, opInfo)).first;
    }

    constexpr uint32_t offsetBit = 32;
    uint64_t sysTime = ((static_cast<uint64_t>(cxtLog->sysCountHigh) << offsetBit) | cxtLog->sysCountLow);
    sysTime = sysTime / frequency_;
    switch (logType) {
        case FFTS_SUBTASK_THREAD_START_FUNC_TYPE:
            devIter->second.start = sysTime;
            break;
        case FFTS_SUBTASK_THREAD_END_FUNC_TYPE:
            devIter->second.end = sysTime;
            break;
        default:
            MSPROF_LOGE("Failed to parse start or end time in AcsqTaskData");
            break;
    }

    if (devIter->second.start > 0 && devIter->second.end > 0) {
        HandleDeviceData(key, devIter->second, totalFftsMerges_);
    }
}

void AnalyzerFfts::StarsRollBackStreamTaskId(uint16_t *streamId, uint16_t *taskId) const
{
    // bit12 == 0 && bit13 == 1: streamId = (bit0~11)taskId, taskId = (bit0~11)streamId | (bit12~15)taskId
    if ((((*streamId) >> TS_UPDATE_FLAG_BIT) & TS_MASK_BIT0_BIT1) == TS_UPDATE_FOR_ALL) {
        const uint16_t tmpTaskId = (*taskId);
        *taskId = ((*streamId) & TS_MASK_BIT0_BIT11) | ((*taskId) & TS_MASK_BIT12_BIT15);
        *streamId = tmpTaskId & TS_MASK_BIT0_BIT11;
        return;
    }
    // bit12 == 1: streamId = (bit0~11)streamId, taskId = (bit0~11)taskId | bit12 | (bit13~15)streamId
    if (((*streamId) & TS_MASK_BIT12) != 0U) {
        *taskId = (((*taskId) & (TS_MASK_BIT0_BIT11 | TS_MASK_BIT12)) | ((*streamId) & TS_MASK_BIT13_BIT15));
        *streamId &= TS_MASK_BIT0_BIT11;
    }
}

template void AnalyzerFfts::HandleOptimizeAcsqTaskData(const StarsAcsqLog *acsqLog, uint32_t logType);
template void AnalyzerFfts::HandleOptimizeAcsqTaskData(const DavidAcsqLog *acsqLog, uint32_t logType);
}  // namespace Analyze
}  // namespace Dvvp
}  // namespace Analysis
