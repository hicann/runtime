/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "analyzer.h"
#include "acl_prof.h"
#include "analyzer_base.h"
#include "analyzer_ge.h"
#include "analyzer_hwts.h"
#include "analyzer_ts.h"
#include "analyzer_rt.h"
#include "analyzer_ffts.h"
#include "config/config.h"
#include "data_struct.h"
#include "errno/error_code.h"
#include "op_desc_parser.h"
#include "prof_channel_manager.h"
#include "uploader.h"
#include "uploader_mgr.h"
#include "transport/hash_data.h"

namespace Analysis {
namespace Dvvp {
namespace Analyze {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::transport;
Analyzer::Analyzer(SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> uploader)
    : resultCount_(0), profileMode_(PROFILE_MODE_STATIC_SHAPE), flushedChannel_(false), flushQueueLen_(0),
      graphTypeFlag_(false)
{
    uploader_ = uploader;

    MSVP_MAKE_SHARED0(analyzerGe_, AnalyzerGe, return);
    MSVP_MAKE_SHARED0(analyzerHwts_, AnalyzerHwts, return);
    MSVP_MAKE_SHARED0(analyzerTs_, AnalyzerTs, return);
    MSVP_MAKE_SHARED0(analyzerRt_, AnalyzerRt, return);
    MSVP_MAKE_SHARED0(analyzerFfts_, AnalyzerFfts, return);

    inited_ = true;
    if ((analyzerHwts_->InitFrequency() != PROFILING_SUCCESS) || (analyzerTs_->InitFrequency() != PROFILING_SUCCESS) ||
        (analyzerFfts_->InitFrequency() != PROFILING_SUCCESS)) {
        inited_ = false;
        MSPROF_LOGE("Analyzer InitFrequency failed. inited_ = false");
    }
}

Analyzer::~Analyzer()
{}

void Analyzer::Flush()
{
    if (uploader_ != nullptr) {
        uploader_->Flush();
    }
}

void Analyzer::PrintDeviceStats()
{
    MSPROF_EVENT("total_size_analyze, upload time: %" PRIu64, resultCount_);
    analyzerHwts_->PrintStats();
    analyzerFfts_->PrintStats();
    analyzerTs_->PrintStats();
}

void Analyzer::PrintHostStats()
{
    MSPROF_EVENT("total_size_analyze, upload time: %" PRIu64, resultCount_);
    analyzerGe_->PrintStats();
    analyzerRt_->PrintStats();
}

void Analyzer::TsDataPostProc()
{
    std::unique_lock<std::mutex> lk(AnalyzerBase::tsThreadMtx_);
    if (profileMode_ == PROFILE_MODE_INVALID) {
        if (!analyzerTs_->keypointOpInfo_.empty()) {
            MSPROF_EVENT("set profile mode: PROFILE_MODE_STEP_TRACE.");
            profileMode_ = PROFILE_MODE_STEP_TRACE;
        } else if (!analyzerTs_->opTimes_.empty()) {
            MSPROF_EVENT("set profile mode: PROFILE_MODE_SINGLE_OP.");
            profileMode_ = PROFILE_MODE_SINGLE_OP;
        }
    }

    if (profileMode_ == PROFILE_MODE_STEP_TRACE && IsNeedUpdateIndexId()) {
        MSPROF_LOGI("received new keypoint op end info.");
        UpdateOpIndexId(analyzerTs_->opTimes_);
        UpdateOpIndexId(analyzerHwts_->opTimes_);
        UploadAppOp(analyzerHwts_->opTimes_);
    }

    UploadAppOp(analyzerTs_->opTimes_);
    UploadKeypointOp();
}

void Analyzer::UploadAppOp(std::multimap<std::string, OpTime> &opTimes)
{
    if (profileMode_ == PROFILE_MODE_STEP_TRACE) {
        UploadAppOpModeStepTrace(opTimes);
    } else if (profileMode_ == PROFILE_MODE_STATIC_SHAPE) {
        UploadAppOpModeStaticShape(opTimes);
    } else if (profileMode_ == PROFILE_MODE_SINGLE_OP) {
        UploadAppOpModeSingleOp(opTimes);
    }
}

void Analyzer::UploadAppOpModeStepTrace(std::multimap<std::string, OpTime> &opTimes)
{
    for (auto iter = opTimes.begin(); iter != opTimes.end();) {
        if (iter->second.indexId == 0) {
            iter++;
            MSPROF_LOGD("Op info is no longer within the keypoint time range.");
            continue;
        }
        std::string key0 = iter->first + KEY_SEPARATOR + "0";
        std::string key1 = iter->first + KEY_SEPARATOR + std::to_string(iter->second.indexId);
        if (analyzerGe_->IsOpInfoCompleted(key0) && analyzerGe_->IsOpInfoCompleted(key1)) {
            MSPROF_LOGE("GE data error. %s %s", key0.c_str(), key1.c_str());
            iter = opTimes.erase(iter);
        } else if (analyzerGe_->IsOpInfoCompleted(key0)) {
            ConstructAndUploadData(key0, iter->second);
            iter = opTimes.erase(iter);
        } else if (analyzerGe_->IsOpInfoCompleted(key1)) {
            ConstructAndUploadData(key1, iter->second);
            iter = opTimes.erase(iter);
        } else {
            iter++;
            MSPROF_LOGD("Op info is incomplete, %s %s", key0.c_str(), key1.c_str());
        }
    }
}

void Analyzer::UploadAppOpModeStaticShape(std::multimap<std::string, OpTime> &opTimes)
{
    if (analyzerGe_->GetIsAllStaticShape()) {
        // in final solution only this branch is needed,need to query high16bit taskid from stream info
        for (auto iter = opTimes.begin(); iter != opTimes.end();) {
            std::string key0 = iter->first + KEY_SEPARATOR + "0";
            if (analyzerGe_->IsOpInfoCompleted(key0)) {
                ConstructAndUploadData(key0, iter->second);
                iter = opTimes.erase(iter);
                MSPROF_LOGD("Op info is Constructed, %s", key0.c_str());
            } else {
                iter++;
                MSPROF_LOGD("Op info is incomplete, %s", key0.c_str());
            }
        }
    } else {
        MSPROF_LOGD("Try to custruct Op info, is not all static");
        for (auto iter = opTimes.begin(); iter != opTimes.end();) {  // tmp solution, discard dynamic shape task
            int32_t streamType;
            if (!analyzerGe_->GetStreamType(iter->second.streamId, streamType)) {
                MSPROF_LOGI("Op Stream info hasn't been received, stream id is %u", iter->second.streamId);
                iter++;
                continue;
            }

            if (streamType == UNKNOWN_SHAPE_STREAM) {
                MSPROF_LOGI("Op belong to unknown shape stream, not supported yet");
                iter = opTimes.erase(iter);
                continue;
            }

            std::string key0 = iter->first + KEY_SEPARATOR + "0";
            if (analyzerGe_->IsOpInfoCompleted(key0)) {
                ConstructAndUploadData(key0, iter->second);
                iter = opTimes.erase(iter);
                MSPROF_LOGD("Op info is Constructed, %s", key0.c_str());
            } else {
                iter++;
                MSPROF_LOGD("Op info is incomplete, %s", key0.c_str());
            }
        }
    }
}

void Analyzer::UploadAppOpModeSingleOp(std::multimap<std::string, OpTime> &opTimes)
{
    for (auto iter = opTimes.begin(); iter != opTimes.cend();) {
        std::string key = iter->first + KEY_SEPARATOR + "0";
        if (analyzerGe_->IsOpInfoCompleted(key)) {
            ConstructAndUploadData(key, iter->second);
            iter = opTimes.erase(iter);
        } else {
            iter++;
        }
    }
}

void Analyzer::UploadKeypointOp()
{
    auto &tsKeypointOp = analyzerTs_->keypointOpInfo_;

    if (profileMode_ == PROFILE_MODE_STATIC_SHAPE) {
        for (auto iter = tsKeypointOp.begin(); iter != tsKeypointOp.end();) {
            if (iter->second.endTime == 0) {
                ++iter;
                MSPROF_LOGD("Key point end is not ready");
                continue;
            }
            const uint32_t graphId = AnalyzerBase::GetGraphModelId(iter->second.modelId);
            if (graphTypeFlag_ && (graphId == iter->second.modelId)) {
                ++iter;
                return;
            }
            std::string nullStr;
            OpTime opTime = {0, 0, 0, 0, 0, 0, ACL_SUBSCRIBE_OP, 0};
            opTime.start = iter->second.startTime;
            opTime.end = iter->second.endTime;
            opTime.indexId = graphId;
            ConstructAndUploadData(nullStr, opTime);
            iter = tsKeypointOp.erase(iter);  // static shape, no need to keep uploaded keypoint
        }
    } else {
        for (auto iter = tsKeypointOp.begin(); iter != tsKeypointOp.end(); ++iter) {
            if (iter->second.uploaded) {
                continue;
            }
            if (iter->second.endTime == 0) {
                continue;
            }
            const uint32_t graphId = AnalyzerBase::GetGraphModelId(iter->second.modelId);
            if (graphTypeFlag_ && (graphId == iter->second.modelId)) {
                return;
            }
            std::string nullStr;
            OpTime opTime = {0, 0, 0, 0, 0, 0, ACL_SUBSCRIBE_OP, 0};
            opTime.start = iter->second.startTime;
            opTime.end = iter->second.endTime;
            opTime.indexId = graphId;
            ConstructAndUploadData(nullStr, opTime);
            iter->second.uploaded = true;
        }
    }
}

uint64_t Analyzer::GetOpIndexId(uint64_t opTimeStamp)
{
    auto &tsKeypointOp = analyzerTs_->keypointOpInfo_;

    const size_t opNum = tsKeypointOp.size();
    if ((opNum == 0) || ((opNum == 1) && (tsKeypointOp.begin()->second.endTime == 0))) {
        MSPROF_LOGD("Get OpIndex failed");
        return 0;
    }

    for (auto iter = tsKeypointOp.begin(); iter != tsKeypointOp.end(); ++iter) {
        if (iter->second.endTime == 0) {
            MSPROF_LOGI("Incomplete keypoint");
            continue;
        }
        if ((opTimeStamp > iter->second.startTime) && (opTimeStamp < iter->second.endTime)) {
            iter->second.findSuccTimes += 1;
            return iter->second.indexId;
        }
    }

    MSPROF_LOGI("Unable to get OpIndexID. opNum %d, opTimeStamp %" PRIu64 ".", opNum, opTimeStamp);
    return 0;
}

void Analyzer::UpdateOpIndexId(std::multimap<std::string, OpTime> &opTimes)
{
    if (profileMode_ == PROFILE_MODE_STATIC_SHAPE) {
        MSPROF_LOGI("Static shape scen, no need to update op index");
        return;
    } else {
        uint64_t maxIndexId = 0;
        for (auto iter = opTimes.begin(); iter != opTimes.end(); iter++) {
            if (iter->second.indexId != 0) {
                continue;
            }
            iter->second.indexId = GetOpIndexId(iter->second.end);
            if (iter->second.indexId > maxIndexId) {
                maxIndexId = iter->second.indexId;
            }
        }

        // clean useless keypoint op
        auto &tsKeypointOp = analyzerTs_->keypointOpInfo_;
        for (auto iter = tsKeypointOp.begin(); iter != tsKeypointOp.end();) {
            if (!iter->second.uploaded) {
                iter++;
                continue;
            }
            if (iter->second.indexId < maxIndexId) {
                MSPROF_LOGI("delete keypoint. indexId:%" PRIu64 " findSuccTimes:%" PRIu64,
                    iter->second.indexId,
                    iter->second.findSuccTimes);
                iter = tsKeypointOp.erase(iter);
            } else {
                iter++;
            }
        }
    }
}

bool Analyzer::IsNeedUpdateIndexId()
{
    auto &tsKeypointOp = analyzerTs_->keypointOpInfo_;

    if (tsKeypointOp.empty()) {
        return false;
    }

    for (auto iter = tsKeypointOp.begin(); iter != tsKeypointOp.end(); ++iter) {
        if (iter->second.endTime != 0 && !(iter->second.uploaded)) {
            return true;
        }
    }
    return false;
}

void Analyzer::ConstructAndUploadData(const std::string &opId, OpTime &opTime)
{
    if (opTime.start > opTime.end || opTime.startAicore > opTime.endAicore) {
        MSPROF_LOGE("End timestamp is less then start. op:%s start:%" PRIu64 " end:%" PRIu64 " startAicore:%" PRIu64
            " endAicore:%" PRIu64, opId.c_str(), opTime.start, opTime.end, opTime.startAicore, opTime.endAicore);
        return;
    }

    ProfOpDesc opDesc;
    const auto ret = memset_s(&opDesc, sizeof(ProfOpDesc), 0, sizeof(ProfOpDesc));
    if (ret != EOK) {
        MSPROF_LOGE("memset failed ret:%d", ret);
        return;
    }
    std::string opName;
    std::string opType;
    if (opId.length() == 0) {
        opDesc.modelId = opTime.indexId;
        opName = KEYPOINT_OP_NAME;
        opType = KEYPOINT_OP_TYPE;
    } else {
        opDesc.modelId = analyzerGe_->GetModelId(opId);
        opName = analyzerGe_->GetOpName(opId);
        opType = analyzerGe_->GetOpType(opId);
    }
    const uint64_t opIndex = OpDescParser::instance()->SetOpTypeAndOpName(opType, opName);
    if (opIndex == 0) {
        return;
    }
    opDesc.opIndex = opIndex;
    opDesc.duration = opTime.end - opTime.start;
    opDesc.start = opTime.start;
    opDesc.end = opTime.end;
    opDesc.flag = opTime.flag;
    if (opType == "FFTS_PLUS") {
        opDesc.flag = ACL_SUBSCRIBE_SUBGRAPH;
    }
    opDesc.threadId = opTime.threadId;
    opDesc.executionTime = opTime.endAicore - opTime.startAicore;  // chipId 0 only
    opDesc.signature = analysis::dvvp::common::utils::Utils::GenerateSignature(
        reinterpret_cast<uint8_t *>(&opDesc) + sizeof(uint32_t), sizeof(ProfOpDesc) - sizeof(uint32_t));
    MSPROF_LOGD("Upload old data. modelId: %u, threadId: %u, opName: %s, opType: %s, start: %" PRIu64 ", end: %" PRIu64
        ", duration: %" PRIu64 ", startAicore: %" PRIu64 ", endAicore: %" PRIu64 ", flag: %u", opDesc.modelId,
        opDesc.threadId, opName.c_str(), opType.c_str(), opDesc.start, opDesc.end, opDesc.duration,
        opTime.startAicore, opTime.endAicore, opDesc.flag);
    uploader_->UploadData(reinterpret_cast<CHAR_PTR>(&opDesc), sizeof(ProfOpDesc));
    resultCount_++;
}

void Analyzer::OnOptimizeData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (!inited_) {
        MSPROF_LOGE("Analyzer is not been inited!");
        return;
    }
    if (fileChunkReq == nullptr || fileChunkReq->fileName.empty()) {
        MSPROF_LOGW("Analyzer OnOptimizeData is not data for analyzing.");
        return;
    }
    if (fileChunkReq->chunkModule == FileChunkDataModule::PROFILING_IS_CTRL_DATA) {
        if (fileChunkReq->fileName == "end_info") {
            AnalyzerBase::isFftsPlus_ = false;
            AnalyzerBase::rtOpInfo_.clear();
            AnalyzerBase::tsOpInfo_.clear();
            AnalyzerBase::geContextInfo_.clear();
            AnalyzerBase::geNodeInfo_.clear();
            AnalyzerBase::geApiInfo_.clear();
            AnalyzerBase::geModelInfo_.clear();
            AnalyzerBase::geOpInfo_.clear();
            AnalyzerBase::graphIdMap_.clear();
            AnalyzerBase::opDescInfos_.clear();
            AnalyzerBase::tsTmpOpInfo_.clear();
            AnalyzerBase::devTmpOpInfo_.clear();
            MSPROF_LOGI("Analyzer OnOptimizeData clear all data.");
        }
        return;
    }

    DispatchOptimizeData(fileChunkReq);
}

void Analyzer::DispatchOptimizeData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (analyzerGe_->IsGeApiOrEventData(fileChunkReq->fileName)) {
        analyzerGe_->GeApiAndEventParse(fileChunkReq);
    } else if (analyzerGe_->IsGeCompactData(fileChunkReq->fileName)) {
        analyzerGe_->GeCompactParse(fileChunkReq);
    } else if (analyzerGe_->IsGeGraphIdMapData(fileChunkReq->fileName)) {
        analyzerGe_->GeGraphIdMapParse(fileChunkReq);
        TsDataPostProc();
    } else if (analyzerGe_->IsGeContextData(fileChunkReq->fileName)) {
        analyzerGe_->GeContextParse(fileChunkReq);
    } else if (analyzerRt_->IsRtCompactData(fileChunkReq->fileName)) {
        analyzerRt_->RtCompactParse(fileChunkReq);
    } else if (analyzerHwts_->IsHwtsData(fileChunkReq->fileName)) {
        analyzerHwts_->HwtsParse(fileChunkReq);
    } else if (analyzerFfts_->IsFftsData(fileChunkReq->fileName)) {
        analyzerFfts_->FftsParse(fileChunkReq);
    } else if (analyzerTs_->IsTsData(fileChunkReq->fileName)) {
        analyzerTs_->Parse(fileChunkReq);
        TsDataPostProc();
    } else {
        MSPROF_LOGD("Analyzer drop data, fileName: %s.", fileChunkReq->fileName.c_str());
        return;
    }
    UploadProfOpDescProc();
}

void Analyzer::UploadProfOpDescProc()
{
    std::unique_lock<std::mutex> lk(AnalyzerBase::opDescInfoMtx_);
    for (auto &it : AnalyzerBase::opDescInfos_) {
        if (uploader_ == nullptr) {
            MSPROF_LOGE("uploader is nullptr in upload optimize data");
            return;
        }
        const uint32_t graphId = AnalyzerBase::GetGraphModelId(it.modelId);
        if (graphTypeFlag_ && (graphId == it.modelId)) {
            return;
        }
        it.modelId = graphId;
        it.signature = analysis::dvvp::common::utils::Utils::GenerateSignature(
            reinterpret_cast<uint8_t *>(&it) + sizeof(uint32_t), sizeof(ProfOpDesc) - sizeof(uint32_t));
        MSPROF_LOGD("Upload opt data pop from vector. modelId: %u, threadId: %u, start: %" PRIu64 ", end: %" PRIu64
            " duration: %" PRIu64 ", flag: %u, exetime: %" PRIu64, it.modelId, it.threadId, it.start, it.end,
            it.duration, it.flag, it.executionTime);
        uploader_->UploadData(reinterpret_cast<CHAR_PTR>(&it), sizeof(ProfOpDesc));
        resultCount_++;
    }
    AnalyzerBase::opDescInfos_.clear();
}

void Analyzer::SetDevId(const std::string &devIdStr)
{
    devIdStr_ = devIdStr;
    MSPROF_LOGI("Analyzer::SetDevId devIdStr_: %s", devIdStr_.c_str());
}

void Analyzer::SetGraphType(bool flag)
{
    graphTypeFlag_ = flag;
    MSPROF_LOGI("Analyzer set graph flag: %d", flag);
}

void Analyzer::SetOpType(bool flag) const
{
    AnalyzerBase::opTypeFlag_ = flag;
    MSPROF_LOGI("Analyzer set optype flag: %d", flag);
}
}  // namespace Analyze
}  // namespace Dvvp
}  // namespace Analysis
