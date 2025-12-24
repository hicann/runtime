/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "analyzer_ge.h"
#include "data_struct.h"
#include "errno/error_code.h"
#include "transport/hash_data.h"
#include "config_manager.h"

namespace Analysis {
namespace Dvvp {
namespace Analyze {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::transport;
using namespace Analysis::Dvvp::Common::Config;
constexpr uint32_t GE_TASK_DATA_SIZE = sizeof(struct MsprofGeProfTaskData);
constexpr int32_t GE_ID_MAP_SIZE = sizeof(struct MsprofGeProfIdMapData);
constexpr int32_t GE_COMPACT_INFO_SIZE = sizeof(MsprofCompactInfo);
constexpr int32_t ADDITIONAL_INFO_SIZE = sizeof(MsprofAdditionalInfo);
constexpr int32_t GE_API_SIZE = sizeof(MsprofApi);

bool AnalyzerGe::IsGeData(const std::string &fileName)
{
    // Ge data starts with "Framework"
    if (fileName.find("Framework") != std::string::npos) {
        return true;
    }
    return false;
}

bool AnalyzerGe::IsGeApiOrEventData(const std::string &fileName) const
{
    // Ge api or event data
    if (fileName.find("api_event") != std::string::npos) {
        return true;
    }
    return false;
}

bool AnalyzerGe::IsGeCompactData(const std::string &tag) const
{
    // Ge compact data
    if (tag.find("node_basic_info") != std::string::npos) {
        return true;
    }
    return false;
}

bool AnalyzerGe::IsGeContextData(const std::string &tag) const
{
    // Ge context data
    if (tag.find("context_id_info") != std::string::npos) {
        return true;
    }
    return false;
}

bool AnalyzerGe::IsGeGraphIdMapData(const std::string &tag) const
{
    // Ge compact data
    if (tag.find("graph_id_map") != std::string::npos) {
        return true;
    }
    return false;
}

bool AnalyzerGe::GetIsAllStaticShape() const
{
    return isAllStaticShape_;
}

bool AnalyzerGe::GetStreamType(const int32_t &streamId, int32_t &streamType) const
{
    auto iter = steamState_.find(streamId);
    if (iter == steamState_.end()) {
        MSPROF_LOGI("Ge stream info is not ready");
        return false;
    } else {
        streamType = iter->second.streamType;
        return true;
    }
}

void AnalyzerGe::Parse(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (fileChunkReq == nullptr) {
        MSPROF_LOGE("ge parse message is null");
        return;
    }
    if (fileChunkReq->fileName.find("id_map_info") != std::string::npos) {
        totalBytes_ += fileChunkReq->chunkSize;
        if (fileChunkReq->chunkSize < GE_ID_MAP_SIZE) {
            MSPROF_LOGE("id_map_info is incomplete data");
            return;
        }
        ParseIdMap(fileChunkReq->chunk.c_str(), fileChunkReq->chunkSize);
        return;
    }
    if (fileChunkReq->fileName.find("task_desc_info") != std::string::npos) {
        totalBytes_ += fileChunkReq->chunkSize;
        ParseTaskDesc(fileChunkReq->chunk.c_str(), fileChunkReq->chunkSize);
        return;
    }
    MSPROF_LOGD("Dropped ge data, fileName: %s", fileChunkReq->fileName.c_str());
}

bool AnalyzerGe::IsOpInfoCompleted(const std::string &opId)
{
    return (opInfos_.find(opId) != opInfos_.end());
}

uint32_t AnalyzerGe::GetModelId(const std::string &opId) const
{
    auto iter = opInfos_.find(opId);
    return (iter == opInfos_.end() ? 0 : iter->second.modelId);
}

uint32_t AnalyzerGe::GetModelId(uint32_t modelId) const
{
    return GetGraphModelId(modelId);
}

std::string AnalyzerGe::GetOpName(const std::string &opId)
{
    const auto iter = opInfos_.find(opId);
    return (iter == opInfos_.end() ? std::string() : iter->second.opName);
}

std::string AnalyzerGe::GetOpType(const std::string &opId)
{
    const auto iter = opInfos_.find(opId);
    return (iter == opInfos_.end() ? std::string() : iter->second.opType);
}

void AnalyzerGe::ParseIdMap(CONST_CHAR_PTR data, uint32_t len)
{
    auto idMapData = reinterpret_cast<const MsprofGeProfIdMapData *>(data);
    int32_t remaindLen = static_cast<int32_t>(len);
    for (; remaindLen >= GE_ID_MAP_SIZE; remaindLen -= GE_ID_MAP_SIZE, idMapData++) {
        if (idMapData->magicNumber != MSPROF_DATA_HEAD_MAGIC_NUM || idMapData->dataTag != MSPROF_GE_DATA_TAG_ID_MAP) {
            MSPROF_LOGE("Check ge id map data fail. len:%u, magicNumber:%u, dataTag:%u",
                len,
                idMapData->magicNumber,
                idMapData->dataTag);
            continue;
        }
        SetGraphModelId(idMapData->modelId, idMapData->graphId);
        analyzedBytes_ += GE_ID_MAP_SIZE;
    }
    FUNRET_CHECK_EXPR_LOGW(remaindLen != 0, "Ge id map data length is invalid. len:%u, remaindLen:%d", len, remaindLen);
}

void AnalyzerGe::ParseTaskDesc(CONST_CHAR_PTR data, uint32_t len)
{
    AppendToBufferedData(data, len);
    uint32_t parsedOpNum = 0;
    uint32_t parsedLen = 0;
    while (dataPtr_ != nullptr && parsedLen < dataLen_) {
        const uint32_t remainLen = dataLen_ - parsedLen;
        if (remainLen < GE_TASK_DATA_SIZE) {
            // remaining is less then GE_TASK_DATA_SIZE, cache it to buffer
            MSPROF_LOGI("Ge remains %u bytes unparsed, cache it", remainLen);
            break;
        }
        if (ParseOpData(dataPtr_ + parsedLen) != PROFILING_SUCCESS) {
            MSPROF_LOGE("ParseOpData failed");
            break;
        }
        parsedOpNum += 1;
        parsedLen += GE_TASK_DATA_SIZE;
    }
    MSPROF_LOGI("Finish parsing ge data, BuffLen:%u NewDataLen:%u parsedLen:%u TotalOpNum:%zu ParsedOp:%u",
        dataLen_,
        len,
        parsedLen,
        opInfos_.size(),
        parsedOpNum);
    BufferRemainingData(parsedLen);
}

void AnalyzerGe::ParseOpName(const MsprofGeProfTaskData &data, struct GeOpInfo &opInfo) const
{
    MsprofMixData *opName = const_cast<MsprofMixData *>(&data.opName);
    if (opName->type == MSPROF_MIX_DATA_STRING) {
        uint32_t dataStrLen = strnlen(opName->data.dataStr, MSPROF_MIX_DATA_STRING_LEN);
        if (dataStrLen == MSPROF_MIX_DATA_STRING_LEN) {
            MSPROF_LOGE("opName data len:%u over max length %u", dataStrLen, MSPROF_MIX_DATA_STRING_LEN - 1);
            opName->data.dataStr[MSPROF_MIX_DATA_STRING_LEN - 1] = 0;
        }
        opInfo.opName = opName->data.dataStr;
    } else {
        opInfo.opName = HashData::instance()->GetHashInfo(opName->data.hashId);
    }
}

void AnalyzerGe::ParseOpType(const MsprofGeProfTaskData &data, struct GeOpInfo &opInfo) const
{
    MsprofGeOpType *opType = const_cast<MsprofGeOpType *>(&data.opType);
    if (opType->type == MSPROF_MIX_DATA_STRING) {
        uint32_t dataStrLen = strnlen(opType->data.dataStr, MSPROF_GE_OP_TYPE_LEN);
        if (dataStrLen == MSPROF_GE_OP_TYPE_LEN) {
            MSPROF_LOGE("opType data len:%u over max length %u", dataStrLen, MSPROF_GE_OP_TYPE_LEN - 1);
            opType->data.dataStr[MSPROF_GE_OP_TYPE_LEN - 1] = 0;
        }
        opInfo.opType = opType->data.dataStr;
    } else {
        opInfo.opType = HashData::instance()->GetHashInfo(opType->data.hashId);
    }
}

int32_t AnalyzerGe::ParseOpData(CONST_CHAR_PTR data)
{
    auto geTaskData = reinterpret_cast<const MsprofGeProfTaskData *>(data);
    if (geTaskData->magicNumber != MSPROF_DATA_HEAD_MAGIC_NUM || geTaskData->dataTag != MSPROF_GE_DATA_TAG_TASK ||
        geTaskData->opName.type > MSPROF_MIX_DATA_STRING || geTaskData->opType.type > MSPROF_MIX_DATA_STRING) {
        MSPROF_LOGE("Check ge op data fail. magicNumber:%u, dataTag:%u, opName:%u, opType:%u",
            geTaskData->magicNumber,
            geTaskData->dataTag,
            geTaskData->opName.type,
            geTaskData->opType.type);
        return PROFILING_FAILED;
    }

    GeOpInfo opInfo = {"", "", "", 0};
    std::string taskId = std::to_string(geTaskData->taskId);
    std::string streamId = std::to_string(geTaskData->streamId);
    std::string iterId = std::to_string(geTaskData->curIterNum);
    std::string contextId = std::to_string(geTaskData->contextId);
    opInfo.modelId = GetModelId(geTaskData->modelId);
    ParseOpName(*geTaskData, opInfo);
    ParseOpType(*geTaskData, opInfo);
    if (geTaskData->curIterNum == 0) {  // static shape
        auto iter = steamState_.find(geTaskData->streamId);
        if (iter == steamState_.end()) {
            StreamInfo streamInfo = {0, 0, KNOWN_SHAPE_STREAM};
            steamState_[geTaskData->streamId] = streamInfo;
            MSPROF_LOGI("Add new known shape stream. stream :%u", geTaskData->streamId);
        }
        opInfo.opId = taskId + KEY_SEPARATOR + streamId + KEY_SEPARATOR + contextId + KEY_SEPARATOR +
                      "0";  // defaultiterid is 0，in future need to change to INT_MAX
    } else if (geTaskData->curIterNum == 1) {
        MSPROF_LOGI("There is unknown shape GE task info");
        isAllStaticShape_ = false;
        opInfo.opId = taskId + KEY_SEPARATOR + streamId + KEY_SEPARATOR + contextId + KEY_SEPARATOR + iterId;
        auto iter = steamState_.find(geTaskData->streamId);
        if (iter == steamState_.end()) {
            StreamInfo streamInfo = {0, 0, UNKNOWN_SHAPE_STREAM};
            steamState_[geTaskData->streamId] = streamInfo;
            MSPROF_LOGI("Add new unknown shape stream. stream :%u", geTaskData->streamId);
        }
    } else {
        MSPROF_LOGI("There is unknown shape GE task info, iterid bigger than 1");
        isAllStaticShape_ = false;
        opInfo.opId = taskId + KEY_SEPARATOR + streamId + KEY_SEPARATOR + contextId + KEY_SEPARATOR + iterId;
    }
    opInfos_.insert(std::make_pair(opInfo.opId, opInfo));
    analyzedBytes_ += GE_TASK_DATA_SIZE;
    MSPROF_LOGD("Analyzer ge data collect op info id=%s, name=%s, type==%s, modelId=%u",
        opInfo.opId.c_str(),
        opInfo.opName.c_str(),
        opInfo.opType.c_str(),
        opInfo.modelId);

    return PROFILING_SUCCESS;
}

void AnalyzerGe::PrintStats()
{
    MSPROF_EVENT("total_size_analyze, module: GE, analyzed %" PRIu64 ", total %" PRIu64 ", api time %u, node time %u,"
        " event time %u, merge %u",
        analyzedBytes_,
        totalBytes_,
        totalApiTimes_,
        totalNodeTimes_,
        totalEventTimes_,
        totalGeMerges_);
}

void AnalyzerGe::GeApiAndEventParse(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (fileChunkReq == nullptr) {
        MSPROF_LOGE("ge api and event parse message is null");
        return;
    }

    if (fileChunkReq->fileName.find("unaging") != std::string::npos) {
        MSPROF_LOGI("Start to analyze api_event file: %s", fileChunkReq->fileName.c_str());
        totalBytes_ += fileChunkReq->chunkSize;
        ParseApiAndEventInfo(fileChunkReq->chunk.c_str(), fileChunkReq->chunkSize, false);
        return;
    } else if (fileChunkReq->fileName.find("aging") != std::string::npos && AnalyzerBase::opTypeFlag_) {
        MSPROF_LOGI("Start to analyze api_event file: %s", fileChunkReq->fileName.c_str());
        totalBytes_ += fileChunkReq->chunkSize;
        ParseApiAndEventInfo(fileChunkReq->chunk.c_str(), fileChunkReq->chunkSize, true);
        return;
    }

    MSPROF_LOGD("Dropped ge data, fileName: %s", fileChunkReq->fileName.c_str());
}

void AnalyzerGe::GeCompactParse(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (fileChunkReq == nullptr) {
        MSPROF_LOGE("ge compact parse message is null");
        return;
    }

    if (fileChunkReq->fileName.find("unaging") != std::string::npos) {
        MSPROF_LOGI("Start to analyze compact file: %s", fileChunkReq->fileName.c_str());
        totalBytes_ += fileChunkReq->chunkSize;
        ParseNodeBasicInfo(fileChunkReq->chunk.c_str(), fileChunkReq->chunkSize, false);
        return;
    } else if (fileChunkReq->fileName.find("aging") != std::string::npos && AnalyzerBase::opTypeFlag_) {
        MSPROF_LOGI("Start to analyze compact file: %s", fileChunkReq->fileName.c_str());
        totalBytes_ += fileChunkReq->chunkSize;
        ParseNodeBasicInfo(fileChunkReq->chunk.c_str(), fileChunkReq->chunkSize, true);
        return;
    }

    MSPROF_LOGD("Dropped ge data, fileName: %s", fileChunkReq->fileName.c_str());
}

void AnalyzerGe::GeContextParse(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (fileChunkReq == nullptr) {
        MSPROF_LOGE("ge context parse message is null");
        return;
    }
    MSPROF_LOGI("Start to analyze additional file: %s", fileChunkReq->fileName.c_str());
    totalBytes_ += fileChunkReq->chunkSize;
    ParseContextIdInfo(fileChunkReq->chunk.c_str(), fileChunkReq->chunkSize);
}

void AnalyzerGe::GeGraphIdMapParse(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (fileChunkReq == nullptr) {
        MSPROF_LOGE("ge compact parse message is null");
        return;
    }

    if (fileChunkReq->fileName.find("unaging") != std::string::npos) {
        MSPROF_LOGI("Start to analyze additional file: %s", fileChunkReq->fileName.c_str());
        totalBytes_ += fileChunkReq->chunkSize;
        ParseGraphIdMap(fileChunkReq->chunk.c_str(), fileChunkReq->chunkSize);
        return;
    }

    MSPROF_LOGD("Dropped ge data, fileName: %s", fileChunkReq->fileName.c_str());
}

void AnalyzerGe::ParseContextIdInfo(CONST_CHAR_PTR data, uint32_t len)
{
    AppendToBufferedData(data, len);
    uint32_t offset = 0;
    while (dataPtr_ != nullptr && offset < dataLen_) {
        const uint32_t remainLen = dataLen_ - offset;
        if (remainLen < ADDITIONAL_INFO_SIZE) {
            MSPROF_LOGW("ContextIdInfo remains %u bytes unparsed, which is incomplete data", remainLen);
            break;
        }

        auto contextData = reinterpret_cast<const MsprofAdditionalInfo *>(dataPtr_ + offset);
        if (contextData->level == MSPROF_REPORT_NODE_LEVEL &&
            contextData->type == MSPROF_REPORT_NODE_CONTEXT_ID_INFO_TYPE) {
            HandleContextIdInfo(dataPtr_ + offset);
            analyzedBytes_ += ADDITIONAL_INFO_SIZE;
        }

        offset += ADDITIONAL_INFO_SIZE;
    }
    BufferRemainingData(offset);
    MatchApiInfo(AnalyzerBase::geApiInfo_, AnalyzerBase::geModelInfo_, AnalyzerBase::geNodeInfo_,
        AnalyzerBase::geContextInfo_);
}

void AnalyzerGe::HandleContextIdInfo(CONST_CHAR_PTR data) const
{
    auto additionalData = reinterpret_cast<const MsprofAdditionalInfo *>(data);
    auto contextIdInfo = reinterpret_cast<const MsprofContextIdInfo *>(additionalData->data);
    uint32_t key = additionalData->threadId;
    GeOpFlagInfo opInfo{contextIdInfo->opName, 0, 0, additionalData->timeStamp, 0, false, false, false,
        static_cast<uint16_t>(contextIdInfo->ctxIds[0])};
    AnalyzerBase::geContextInfo_.insert(std::pair<uint32_t, GeOpFlagInfo>(key, opInfo));
    std::string contextName = HashData::instance()->GetHashInfo(contextIdInfo->opName);
    MSPROF_LOGD("insert ContextIdInfo opName: %s, contextId: %u, num: %u.", contextName.c_str(),
        contextIdInfo->ctxIds[0], contextIdInfo->ctxIdNum);
}

bool AnalyzerGe::HandleContextWithNode(std::multimap<uint32_t, GeOpFlagInfo> &nodeInfo,
    std::multimap<uint32_t, GeOpFlagInfo> &contextInfo) const
{
    if (contextInfo.empty()) {
        return false;
    }

    for (auto nodeIter = nodeInfo.rbegin(); nodeIter != nodeInfo.rend(); nodeIter++) {
        for (auto cxtIter = contextInfo.begin(); cxtIter != contextInfo.end(); cxtIter++) {
            if (nodeIter->first == cxtIter->first &&
                nodeIter->second.start == cxtIter->second.start &&
                nodeIter->second.opNameHash == cxtIter->second.opNameHash) {
                nodeIter->second.contextId = cxtIter->second.contextId;
            }
        }
    }

    return true;
}

void AnalyzerGe::ParseNodeBasicInfo(CONST_CHAR_PTR data, uint32_t len, bool ageFlag)
{
    AppendToBufferedData(data, len);
    uint32_t offset = 0;
    while (dataPtr_ != nullptr && offset < dataLen_) {
        const uint32_t remainLen = dataLen_ - offset;
        if (remainLen < GE_COMPACT_INFO_SIZE) {
            MSPROF_LOGW("NodeBasicInfo remains %u bytes unparsed, which is incomplete data", remainLen);
            break;
        }

        auto nodeData = reinterpret_cast<const MsprofCompactInfo *>(dataPtr_ + offset);
        MSPROF_LOGD("ParseNodeBasicInfo level: %hu.", nodeData->level);
        if (nodeData->level == MSPROF_REPORT_NODE_LEVEL) {
            HandleNodeBasicInfo(dataPtr_ + offset, ageFlag);
            analyzedBytes_ += GE_COMPACT_INFO_SIZE;
            totalNodeTimes_++;
        }

        offset += GE_COMPACT_INFO_SIZE;
    }
    BufferRemainingData(offset);
    MatchApiInfo(AnalyzerBase::geApiInfo_, AnalyzerBase::geModelInfo_, AnalyzerBase::geNodeInfo_,
        AnalyzerBase::geContextInfo_);
}

void AnalyzerGe::ParseGraphIdMap(CONST_CHAR_PTR data, uint32_t len)
{
    std::unique_lock<std::mutex> lk(AnalyzerBase::tsThreadMtx_);
    AppendToBufferedData(data, len);
    uint32_t offset = 0;
    while (dataPtr_ != nullptr && offset < dataLen_) {
        const uint32_t remainLen = dataLen_ - offset;
        if (remainLen < ADDITIONAL_INFO_SIZE) {
            MSPROF_LOGW("ParseGraphIdMap remains %u bytes unparsed, which is incomplete data", remainLen);
            break;
        }

        auto graphIdMapData = reinterpret_cast<const MsprofAdditionalInfo *>(dataPtr_ + offset);
        auto graphIdInfo = reinterpret_cast<const MsprofGraphIdInfo *>(graphIdMapData->data);
        if (graphIdMapData->level == MSPROF_REPORT_MODEL_LEVEL &&
            graphIdInfo->graphId != std::numeric_limits<uint32_t>::max()) {
            SetGraphModelId(graphIdInfo->modelId, graphIdInfo->graphId);
            MSPROF_LOGD("ParseGraphIdMap graph id %u, model id: %u.", graphIdInfo->graphId, graphIdInfo->modelId);
        }
        offset += ADDITIONAL_INFO_SIZE;
    }
    BufferRemainingData(offset);
}

void AnalyzerGe::HandleNodeBasicInfo(CONST_CHAR_PTR data, bool ageFlag) const
{
    auto compactData = reinterpret_cast<const MsprofCompactInfo *>(data);
    auto nodeData = compactData->data.nodeBasicInfo;
    uint32_t key = compactData->threadId;
    const uint64_t opNameHash = nodeData.opName;
    const uint64_t opTypeHash = nodeData.opType;
    const uint64_t timeStamp = compactData->timeStamp;
    std::string nodeName = HashData::instance()->GetHashInfo(opNameHash);
    std::string nodeType = HashData::instance()->GetHashInfo(opTypeHash);
    if (nodeType == "FFTS_PLUS") {
        if (!AnalyzerBase::isFftsPlus_) {
            AnalyzerBase::isFftsPlus_ = true;
            MSPROF_LOGI("Ffts plus mode on");
        }
        return;
    }

    GeOpFlagInfo opInfo{opNameHash, opTypeHash, 0, timeStamp, 0, false, false, ageFlag, UINT16_MAX};
    AnalyzerBase::geNodeInfo_.insert(std::pair<uint32_t, GeOpFlagInfo>(key, opInfo));
    MSPROF_LOGD("insert NodeInfo timeStamp: %" PRIu64 ", opname: %s, optype: %s, age: %d.", timeStamp,
        nodeName.c_str(), nodeType.c_str(), ageFlag);
}

void AnalyzerGe::ParseApiAndEventInfo(CONST_CHAR_PTR data, uint32_t len, bool ageFlag)
{
    AppendToBufferedData(data, len);
    uint32_t offset = 0;
    while (dataPtr_ != nullptr && offset < dataLen_) {
        const uint32_t remainLen = dataLen_ - offset;
        if (remainLen < GE_API_SIZE) {
            MSPROF_LOGW("ModelApiAndEventInfo remains %u bytes unparsed, which is incomplete data", remainLen);
            break;
        }

        auto mlApiData = reinterpret_cast<const MsprofApi *>(dataPtr_ + offset);
        MSPROF_LOGD("ParseMApiAndEvent level: %hu, type %u.", mlApiData->level, mlApiData->type);
        if (mlApiData->endTime != MSPROF_EVENT_FLAG && mlApiData->type == MSPROF_REPORT_NODE_LAUNCH_TYPE) {
            HandleApiInfo(dataPtr_ + offset, ageFlag);
            analyzedBytes_ += GE_API_SIZE;
            totalApiTimes_++;
        } else if (mlApiData->endTime == MSPROF_EVENT_FLAG && mlApiData->level == MSPROF_REPORT_MODEL_LEVEL &&
            mlApiData->type == MSPROF_REPORT_MODEL_LOAD_TYPE) {
            HandleModelInfo(dataPtr_ + offset, ageFlag);
            analyzedBytes_ += GE_API_SIZE;
            totalEventTimes_++;
        }
        offset += GE_API_SIZE;
    }
    BufferRemainingData(offset);
    MatchApiInfo(AnalyzerBase::geApiInfo_, AnalyzerBase::geModelInfo_, AnalyzerBase::geNodeInfo_,
        AnalyzerBase::geContextInfo_);
}

void AnalyzerGe::HandleApiInfo(CONST_CHAR_PTR data, bool ageFlag) const
{
    auto klData = reinterpret_cast<const MsprofApi *>(data);
    uint32_t key = klData->threadId;
    GeOpFlagInfo opInfo{0, 0, 0, klData->beginTime, klData->endTime, false, false, ageFlag, UINT16_MAX};
    AnalyzerBase::geApiInfo_.insert(std::pair<uint32_t, GeOpFlagInfo>(key, opInfo));
    MSPROF_LOGD("Insert to GeApiInfo, key: %u, beginTime: %" PRIu64 ", endTime: %" PRIu64 ", age: %d",
        key, klData->beginTime, klData->endTime, ageFlag);
}

void AnalyzerGe::HandleModelInfo(CONST_CHAR_PTR data, bool ageFlag) const
{
    auto mlData = reinterpret_cast<const MsprofEvent *>(data);
    uint32_t key = mlData->threadId;
    if (AnalyzerBase::geModelInfo_.count(key) == 0) {
        GeOpFlagInfo opInfo = {0, 0, mlData->itemId, mlData->timeStamp, 0, false, false, ageFlag, UINT16_MAX};
        AnalyzerBase::geModelInfo_.insert(std::pair<uint32_t, GeOpFlagInfo>(key, opInfo));
        MSPROF_LOGD("Insert start: %" PRIu64 ", modelId: %" PRIu64 " to geModelInfo map cause no same key. age: %d",
            mlData->timeStamp, mlData->itemId, ageFlag);
        return;
    }

    bool modelIdExist = false;
    for (auto iter = AnalyzerBase::geModelInfo_.begin(); iter != AnalyzerBase::geModelInfo_.end(); iter++) {
        if (iter->second.modelId != mlData->itemId || iter->first != key) { // same modelId and same threadId
            continue;
        }
        if (iter->second.end != 0) {
            iter->second.end = 0;
            iter->second.start = mlData->timeStamp; // repeat modelId and threadId
            MSPROF_LOGD("Repeat Insert start: %" PRIu64 ", modelId: %" PRIu64 " to geModelInfo map.", mlData->timeStamp,
                mlData->itemId);
            return;
        }
        if (iter->second.start >= mlData->timeStamp) { // start end error
            MSPROF_LOGE("Model info: op start latter than op end.");
            return;
        }
        iter->second.end = mlData->timeStamp;
        MSPROF_LOGD("Insert end: %" PRIu64 ", modelId: %" PRIu64 " to geModelInfo map.",
            mlData->timeStamp, mlData->itemId);
        modelIdExist = true;
    }

    if (!modelIdExist) { // same threadId different modelid
        GeOpFlagInfo opInfo{0, 0, mlData->itemId, mlData->timeStamp, 0, false, false, ageFlag, UINT16_MAX};
        AnalyzerBase::geModelInfo_.insert(std::pair<uint32_t, GeOpFlagInfo>(key, opInfo));
        MSPROF_LOGD("Insert start: %" PRIu64 ", modelId: %" PRIu64 " to geModelInfo_ cause no same modelId. age: %d",
            mlData->timeStamp, mlData->itemId, ageFlag);
    }
}

void AnalyzerGe::MatchApiInfo(std::multimap<uint32_t, GeOpFlagInfo> &apiInfo,
    std::multimap<uint32_t, GeOpFlagInfo> &modelInfo,
    std::multimap<uint32_t, GeOpFlagInfo> &nodeInfo,
    std::multimap<uint32_t, GeOpFlagInfo> &contextInfo)
{
    if (apiInfo.empty() || nodeInfo.empty()) {
        return;
    }
    if (modelInfo.empty() && !AnalyzerBase::opTypeFlag_) {
        return;
    }
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_V4_1_0 &&
        AnalyzerBase::isFftsPlus_) {
        if (!HandleContextWithNode(nodeInfo, contextInfo)) {
            return;
        }
    }
    std::unique_lock<std::mutex> lk(AnalyzerBase::geThreadMtx_);
    for (auto api = apiInfo.begin(); api != apiInfo.end();) {
        if (!api->second.modelFlag) {
            MatchModelInfo(modelInfo, api->first, api->second);
        }

        if (!api->second.modelFlag && !AnalyzerBase::opTypeFlag_) {
            api++;
            continue;
        }

        if (!api->second.nodeFlag) {
            MatchNodeInfo(nodeInfo, api->first, api->second);
        }

        if ((api->second.nodeFlag && api->second.modelFlag) || (api->second.nodeFlag && AnalyzerBase::opTypeFlag_)) {
            std::string nodeName = HashData::instance()->GetHashInfo(api->second.opNameHash);
            MSPROF_LOGD("Success to match ge opinfo data and insert in map."
                "Key: %u, start: %" PRIu64 ", end: %" PRIu64 ", name %s, context: %u, age: %d.", api->first,
                api->second.start, api->second.end, nodeName.c_str(), api->second.contextId, api->second.ageFlag);
            AnalyzerBase::geOpInfo_.insert(std::pair<uint32_t, GeOpFlagInfo>(api->first, api->second));
            totalGeMerges_++;
            if (AnalyzerBase::isFftsPlus_) {
                api->second.nodeFlag = false;
            } else {
                apiInfo.erase(api++);
            }
        } else {
            api++;
        }
    }
    MatchDeviceOpInfo(AnalyzerBase::devTmpOpInfo_, AnalyzerBase::geOpInfo_);
}

void AnalyzerGe::MatchModelInfo(std::multimap<uint32_t, GeOpFlagInfo> &modelInfo, uint32_t threadId,
    GeOpFlagInfo &apiInfo) const
{
    for (auto model = modelInfo.begin(); model != modelInfo.end(); model++) {
        if (model->first == threadId &&
            apiInfo.start > model->second.start &&
            apiInfo.end < model->second.end &&
            apiInfo.ageFlag == model->second.ageFlag) { // match modelid
            apiInfo.modelId = model->second.modelId;
            apiInfo.modelFlag = true;
            MSPROF_LOGD("model match threadId: %u, modelId: %" PRIu64, model->first, model->second.modelId);
            break;
        }
    }
}

void AnalyzerGe::MatchNodeInfo(std::multimap<uint32_t, GeOpFlagInfo> &nodeInfo, uint32_t threadId,
    GeOpFlagInfo &apiInfo) const
{
    for (auto node = nodeInfo.begin(); node != nodeInfo.end();) {
        if (node->first == threadId &&
            node->second.start >= apiInfo.start &&
            node->second.start <= apiInfo.end) { // match node
            apiInfo.opNameHash = node->second.opNameHash;
            apiInfo.opTypeHash = node->second.opTypeHash;
            apiInfo.nodeFlag = true;
            apiInfo.contextId = node->second.contextId;
            MSPROF_LOGD("node match threadId: %u, opNameHash: %llu", node->first, node->second.opNameHash);
            node = nodeInfo.erase(node);
            break;
        }
        node++;
    }
}

void AnalyzerGe::MatchDeviceOpInfo(std::vector<RtOpInfo> &devTmpOpInfo,
    std::multimap<uint32_t, GeOpFlagInfo> &geOpInfo) const
{
    if (devTmpOpInfo.empty() || geOpInfo.empty()) {
        return;
    }
    for (auto it = devTmpOpInfo.begin(); it != devTmpOpInfo.end();) {
        bool ifUpload = false;
        auto threadGroup = geOpInfo.equal_range((*it).threadId);
        if (threadGroup.first != geOpInfo.end()) {
            for (auto geIter = threadGroup.first; geIter != threadGroup.second; ++geIter) {
                if ((*it).tsTrackTimeStamp > geIter->second.end ||
                    (*it).tsTrackTimeStamp <= geIter->second.start) { // time include
                    continue;
                }
                ConstructAndUploadOptimizeData(geIter->second, (*it));
                ifUpload = true;
                it = devTmpOpInfo.erase(it);
                break;
            }
        }
        if (!ifUpload) {
            it++;
        }
    }
}

}  // namespace DEF
}  // namespace Dvvp
}  // namespace Analysis
