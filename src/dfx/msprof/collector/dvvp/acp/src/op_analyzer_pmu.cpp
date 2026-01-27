/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "op_analyzer_pmu.h"
#include "data_struct.h"

namespace Dvvp {
namespace Acp {
namespace Analyze {
using namespace Analysis::Dvvp::Analyze;
bool OpAnalyzerPmu::IsStarsData(const std::string &fileName) const
{
    if (fileName.find("stars_soc.data") != std::string::npos) {
        return true;
    }
    return false;
}

bool OpAnalyzerPmu::IsFftsData(const std::string &fileName) const
{
    if (fileName.find("ffts_profile.data") != std::string::npos) {
        return true;
    }
    return false;
}

void OpAnalyzerPmu::ParseStarsData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (fileChunkReq == nullptr) {
        return;
    }
    MSPROF_LOGI("ParseStarsData get chunk, fileName: %s.", fileChunkReq->fileName.c_str());
    uint32_t dataSize = STARS_DATA_SIZE;
    if (IsExtPmu()) {
        dataSize = DAVID_LOG_DATA_SIZE;
    }
    dataPtr_ = fileChunkReq->chunk.c_str();
    dataLen_ = fileChunkReq->chunkSize;
    uint32_t offset = 0;
    while (dataPtr_ != nullptr && offset < dataLen_) {
        uint32_t remainingLen = dataLen_ - offset;
        if (remainingLen < dataSize) {
            break;
        }
        auto logHead = reinterpret_cast<const StarsLogHead *>(dataPtr_ + offset);
        uint16_t logType = logHead->logType;
        if (IsExtPmu() && (logType == ACSQ_TASK_START_FUNC_TYPE || logType == ACSQ_TASK_END_FUNC_TYPE)) {
            auto data = reinterpret_cast<const DavidAcsqLog *>(logHead);
            HandleStarsAcsq(data, logType);
            starsBytes_ += dataSize;
        } else if (logType == ACSQ_TASK_START_FUNC_TYPE || logType == ACSQ_TASK_END_FUNC_TYPE) {
            auto data = reinterpret_cast<const StarsAcsqLog *>(logHead);
            HandleStarsAcsq(data, logType);
            starsBytes_ += dataSize;
        } else if (logType == FFTS_SUBTASK_THREAD_START_FUNC_TYPE || logType == FFTS_SUBTASK_THREAD_END_FUNC_TYPE) {
            HandleSubTaskThread(logHead, logType);
        } else {
            MSPROF_LOGW("Unknown stars pmu data, logType: %u", logType);
        }
        offset += dataSize;
    }
    if (offset < dataLen_) {
        MSPROF_LOGE("Stars data remains %u bytes unparsed, cache it", (dataLen_ - offset));
    }
}

template <typename T>
void OpAnalyzerPmu::HandleStarsAcsq(const T *logData, uint16_t logType)
{
    uint16_t sqeType = logData->head.sqeType;
    if (IsSqeControl(sqeType)) {
        MSPROF_LOGI("HandleStarsAcsq skip control sqe type: %u.", sqeType);
        return;
    }

    std::string key = std::to_string(logData->taskId) + "-" + std::to_string(logData->streamId);
    constexpr uint32_t offsetBit = 32;
    uint64_t sysTime = ((static_cast<uint64_t>(logData->sysCountHigh) << offsetBit) | logData->sysCountLow);
    sysTime = static_cast<uint64_t>(static_cast<double>(sysTime) / frequency_);

    MSPROF_LOGI("HandleStarsAcsq get key: %s, time: %llu, logType: %u.", key.c_str(), sysTime, logType);
    auto iter = logInfo_.find(key); // search for first match
    if (iter == logInfo_.end() ||
        (iter->second.beginTime != 0 && iter->second.endTime != 0)) {
        KernelDetail info{0, 0, 0, 0, 0, 0, 0, 0, {0}, 0, 0};
        info.taskId = logData->taskId;
        info.streamId = logData->streamId;
        iter = logInfo_.insert(std::make_pair(key, info));
    }

    switch (logType) {
        case ACSQ_TASK_START_FUNC_TYPE:
            if (iter->second.beginTime != 0) {
                MSPROF_LOGW("Repeat beginTime, key: %s.", key.c_str());
            }
            iter->second.beginTime = sysTime;
            break;
        case ACSQ_TASK_END_FUNC_TYPE:
            if (iter->second.endTime != 0) {
                MSPROF_LOGW("Repeat endTime, key: %s.", key.c_str());
            }
            iter->second.endTime = sysTime;
            break;
        default:
            MSPROF_LOGE("Failed to parse start or end time in acsq data");
            break;
    }
}

void OpAnalyzerPmu::HandleSubTaskThread(const void *data, uint16_t logType) const
{
    UNUSED(data);
    UNUSED(logType);
    MSPROF_LOGI("SubTaskThread data not support to analyze.");
    return;
}

void OpAnalyzerPmu::ParseFftsData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (fileChunkReq == nullptr) {
        return;
    }
    dataPtr_ = fileChunkReq->chunk.c_str();
    dataLen_ = fileChunkReq->chunkSize;
    uint32_t offset = 0;
    while (dataPtr_ != nullptr && offset < dataLen_) {
        uint32_t remainingLen = dataLen_ - offset;
        if (remainingLen < PMU_DATA_SIZE) {
            break;
        }

        auto pmuHead = reinterpret_cast<const StarsPmuHead *>(dataPtr_ + offset);
        uint8_t funcType = pmuHead->funcType;
        if (IsExtPmu() && (funcType == FUNC_TYPE_DAVID_TASK)) {
            auto data = reinterpret_cast<const DavidProfile *>(pmuHead);
            HandleSubtaskPmu(data, 0, data->coreType, data->endCnt - data->startCnt); // david has no ffts
            fftsSubBytes_ += PMU_DATA_SIZE;
        } else if (IsExtPmu() && (funcType == FUNC_TYPE_DAVID_BLOCK)) {
            auto data = reinterpret_cast<const DavidProfile *>(pmuHead);
            HandleBlockPmu(data);
            fftsSubBytes_ += PMU_DATA_SIZE;
        } else if (funcType == FUNC_TYPE_SUBTASK) {
            auto data = reinterpret_cast<const FftsSubProfile *>(pmuHead);
            HandleSubtaskPmu(data, data->fftsType, 0, 0);
            fftsSubBytes_ += PMU_DATA_SIZE;
        } else if (funcType == FUNC_TYPE_BLOCK) {
            auto data = reinterpret_cast<const FftsBlockProfile *>(pmuHead);
            HandleBlockPmu(data);
            fftsBlockBytes_ += PMU_DATA_SIZE;
        } else {
            MSPROF_LOGW("Unknown ffts pmu data, funcType: %u", funcType);
        }
        offset += PMU_DATA_SIZE;
    }
    if (offset < dataLen_) {
        MSPROF_LOGE("Ffts data remains %u bytes unparsed, cache it", (dataLen_ - offset));
    }
}

template <typename T>
void OpAnalyzerPmu::HandleSubtaskPmu(const T *data, uint8_t fftsType, uint8_t coreType, uint64_t cnt)
{
    bool isAicType = IsAic(fftsType, data->contextType, coreType);
    std::string key = std::to_string(data->taskId) +
        "-" + std::to_string(data->streamId) +
        "_" + std::to_string(data->contextId);
    MSPROF_LOGI("HandleFftsPmu get key: %s, isAicType: %d, fftsType: %u, contextType: %u, totalCycle: %llu, "
        "start Cnt: %llu, endCnt: %llu.", key.c_str(), isAicType, fftsType, data->contextType, data->totalCycle,
        data->startCnt, data->endCnt);

    KernelDetail info{0, 0, 0, 0, 0, 0, 0, 0, {0}, 0, 0};
    info.taskId = data->taskId;
    info.streamId = data->streamId;
    info.aicTotalCycle = (isAicType) ? data->totalCycle : 0;
    info.aivTotalCycle = (isAicType) ? 0 : data->totalCycle;
    info.aicCnt = (coreType == CORE_TYPE_AIC) ? cnt : 0;
    info.aivCnt = (coreType == CORE_TYPE_AIV) ? cnt : 0;
    MSPROF_LOGI("HandleFftsPmu save aicTotalCycle: %llu, aivTotalCycle: %llu, aicCnt: %llu, aivCnt: %llu.",
        info.aicTotalCycle, info.aivTotalCycle, info.aicCnt, info.aivCnt);
    uint32_t pmuStart = (isAicType) ? 0 : pmuNum_; // if aiv type, move pmu write key
    for (uint32_t i = 0; i < pmuNum_; i++) {
        MSPROF_LOGI("HandleFftsPmu get key: %s, i: %u, pmu: %llu.", key.c_str(), i, data->pmu[i]);
        info.pmu[i + pmuStart] = data->pmu[i];
    }
    subTaskInfo_.insert(std::make_pair(key, info));
}

template <typename T>
void OpAnalyzerPmu::HandleBlockPmu(const T *data)
{
    // check if mix type
    if (!IsMixType(data->contextType)) {
        return;
    }
    // check if main core
    if (!IsSlaveCore(data->contextType, data->coreType)) {
        return;
    }
    std::string key = std::to_string(data->taskId) +
        "-" + std::to_string(data->streamId) +
        "_" + std::to_string(data->contextId);
    MSPROF_LOGI("HandleBlockPmu get key: %s, contextType: %u, coreType: %u, totalCycle: %llu.",
        key.c_str(), data->contextType, data->coreType, data->totalCycle);
    KernelDetail info{0, 0, 0, 0, 0, 0, 0, 0, {0}, 0, 0};
    info.taskId = data->taskId;
    info.streamId = data->streamId;
    info.coreType = data->coreType;
    info.aicTotalCycle = (data->coreType == CORE_TYPE_AIC) ? data->totalCycle : 0;
    info.aivTotalCycle = (data->coreType == CORE_TYPE_AIV) ? data->totalCycle : 0;
    info.aicCnt = (data->coreType == CORE_TYPE_AIC) ? (data->endCnt - data->startCnt) : 0;
    info.aivCnt = (data->coreType == CORE_TYPE_AIV) ? (data->endCnt - data->startCnt) : 0;
    // if aiv type, move pmu write key
    uint32_t pmuStart = (data->coreType == CORE_TYPE_AIC) ? 0 : pmuNum_;
    for (uint32_t i = 0; i < pmuNum_; i++) {
        MSPROF_LOGI("HandleBlockPmu get key: %s, i: %u, pmu: %llu.", key.c_str(), i, data->pmu[i]);
        info.pmu[i + pmuStart] = data->pmu[i];
    }
    blockInfo_.insert(std::make_pair(key, info));
}

void OpAnalyzerPmu::PrintStats() const
{
    MSPROF_EVENT("total_size_pmu, stars_bytes: %u, ffts_sub_bytes: %u, ffts_block_bytes: %u, log info size: %zu."
        "sub task info size: %zu, block info size: %zu.", starsBytes_, fftsSubBytes_, fftsBlockBytes_,
        logInfo_.size(), subTaskInfo_.size(), blockInfo_.size());
}

bool OpAnalyzerPmu::IsAic(uint8_t fftsType, uint8_t contextType, uint8_t coreType) const
{
    if (IsExtPmu()) {
        return (coreType == CORE_TYPE_AIC);
    } else {
        return IsFftsAic(fftsType, contextType) ||
            IsTraditionAic(fftsType) ||
            IsFftsMixAic(fftsType, contextType);
    }
}

bool OpAnalyzerPmu::IsFftsAic(uint8_t fftsType, uint8_t contextType) const
{
    if (fftsType == FFTS_TYPE_FFTS && contextType == SUB_TASK_TYPE_AIC) {
        return true;
    }
    return false;
}

bool OpAnalyzerPmu::IsTraditionAic(uint8_t fftsType) const
{
    if (fftsType == FFTS_TYPE_TRADITION_AIC) {
        return true;
    }
    return false;
}

bool OpAnalyzerPmu::IsFftsMixAic(uint8_t fftsType, uint8_t contextType) const
{
    if ((fftsType == FFTS_TYPE_FFTS && contextType == SUB_TASK_TYPE_MIXAIC) ||
        fftsType == FFTS_TYPE_MIX_AIC) {
        return true;
    }
    return false;
}

bool OpAnalyzerPmu::IsFftsMixAiv(uint8_t fftsType, uint8_t contextType) const
{
    if (fftsType == FFTS_TYPE_FFTS && contextType == SUB_TASK_TYPE_MIXAIV) {
        return true;
    }
    return false;
}

bool OpAnalyzerPmu::IsMixType(uint8_t contextType) const
{
    if (contextType == SUB_TASK_TYPE_MIXAIC ||
        contextType == SUB_TASK_TYPE_MIXAIV) {
        return true;
    }
    return false;
}

bool OpAnalyzerPmu::IsSlaveCore(uint8_t contextType, uint8_t coreType) const
{
    if ((contextType == SUB_TASK_TYPE_MIXAIC && coreType == CORE_TYPE_AIV) ||
        (contextType == SUB_TASK_TYPE_MIXAIV && coreType == CORE_TYPE_AIC)) {
        return true;
    }
    return false;
}

bool OpAnalyzerPmu::IsExtPmu() const
{
    if (pmuNum_ == DAVID_PMU_NUM) {
        return true;
    }
    return false;
}

bool OpAnalyzerPmu::IsSqeControl(uint16_t sqeType) const
{
    static std::vector<uint16_t> ctrlSqeVec = {
        PLACE_HOLER_SQE,
        NOTIFY_RECORD_SQE,
        NOTIFY_WAIT_SQE,
        WRITE_VALUE_SQE,
        CONDITION_SQE,
        END_SQE
    };

    if (std::find(ctrlSqeVec.begin(), ctrlSqeVec.end(), sqeType) != ctrlSqeVec.end()) {
        return true;
    }

    return false;
}

template void OpAnalyzerPmu::HandleStarsAcsq(const StarsAcsqLog *logData, uint16_t logType);
template void OpAnalyzerPmu::HandleStarsAcsq(const DavidAcsqLog *logData, uint16_t logType);
template void OpAnalyzerPmu::HandleSubtaskPmu(const FftsSubProfile *data, uint8_t fftsType, uint8_t coreType, uint64_t cnt);
template void OpAnalyzerPmu::HandleSubtaskPmu(const DavidProfile *data, uint8_t fftsType, uint8_t coreType, uint64_t cnt);
template void OpAnalyzerPmu::HandleBlockPmu(const FftsBlockProfile *data);
template void OpAnalyzerPmu::HandleBlockPmu(const DavidProfile *data);
} // namespace Analyze
} // namespace Dvvp
} // namespace Analysis
