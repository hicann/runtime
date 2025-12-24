/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_reporter_mgr.h"
#include <algorithm>
#include "receive_data.h"
#include "error_code.h"
#include "uploader_mgr.h"
#include "hash_data.h"
#include "mstx_data_handler.h"

namespace Dvvp {
namespace Collect {
namespace Report {
using namespace analysis::dvvp::common::error;
using namespace Msprof::Engine;
using namespace analysis::dvvp::transport;
using namespace Analysis::Dvvp::MsprofErrMgr;

ProfReporterMgr::ProfReporterMgr() : isStarted_(false), isUploadStarted_(false), isSyncReporter_(false)
{
    indexMap_ = {
        {MSPROF_REPORT_ACL_LEVEL, 0},
        {MSPROF_REPORT_MODEL_LEVEL, 0},
        {MSPROF_REPORT_NODE_LEVEL, 0},
        {MSPROF_REPORT_HCCL_NODE_LEVEL, 0},
        {MSPROF_REPORT_RUNTIME_LEVEL, 0}
    };
    reportTypeInfoMapVec_ = {
        {MSPROF_REPORT_ACL_LEVEL, std::vector<std::pair<uint32_t, std::string>>()},
        {MSPROF_REPORT_MODEL_LEVEL, std::vector<std::pair<uint32_t, std::string>>()},
        {MSPROF_REPORT_NODE_LEVEL, std::vector<std::pair<uint32_t, std::string>>()},
        {MSPROF_REPORT_HCCL_NODE_LEVEL, std::vector<std::pair<uint32_t, std::string>>()},
        {MSPROF_REPORT_RUNTIME_LEVEL, std::vector<std::pair<uint32_t, std::string>>()}
    };
}

ProfReporterMgr::~ProfReporterMgr()
{
    StopReporters();
    reportTypeInfoMap_.clear();
    reportTypeInfoMapVec_.clear();
}

int32_t ProfReporterMgr::Start()
{
    if (isUploadStarted_) {
        MSPROF_LOGW("type info upload has been started!");
        return PROFILING_SUCCESS;
    }

    Thread::SetThreadName(analysis::dvvp::common::config::MSVP_TYPE_INFO_UPLOAD_THREAD_NAME);

    if (Thread::Start() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to start the upload in ProfReporterMgr::Start().");
        return PROFILING_FAILED;
    } else {
        MSPROF_LOGI("Succeeded in starting the upload in ProfReporterMgr::Start().");
    }
    isUploadStarted_ = true;
    return PROFILING_SUCCESS;
}

void ProfReporterMgr::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);
    while (!IsQuit()) {
        std::unique_lock<std::mutex> lk(notifyMtx_);
        cv_.wait_for(lk, std::chrono::seconds(1), [this] { return this->IsQuit(); });
        SaveData(false);
        SaveDataFormat(false);
        HashData::instance()->SaveNewHashData(false);
    }
}

int32_t ProfReporterMgr::Stop()
{
    MSPROF_LOGI("Stop type info upload thread begin");
    if (!isUploadStarted_) {
        MSPROF_LOGE("type info upload thread not started");
        return PROFILING_FAILED;
    }
    isUploadStarted_ = false;

    int32_t ret = analysis::dvvp::common::thread::Thread::Stop();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("type info upload Thread stop failed");
        return PROFILING_FAILED;
    }

    MSPROF_LOGI("Stop type info upload Thread success");
    return PROFILING_SUCCESS;
}

void ProfReporterMgr::SetSyncReporter()
{
    // set Sync Reporter. This will not start thread.
    isSyncReporter_ = true;
}

int32_t ProfReporterMgr::StartReporters()
{
    std::lock_guard<std::mutex> lk(startMtx_);
    if (isStarted_) {
        MSPROF_LOGI("The reporter have been started, don't need to repeat.");
        return PROFILING_SUCCESS;
    }

    if (reporters_.empty()) {
        for (auto &module : MSPROF_MODULE_REPORT_TABLE) {
            reporters_.emplace_back(MsprofReporter(module.name));
        }
    }

    MSPROF_LOGI("ProfReporterMgr start reporters");
    for (auto &report : reporters_) {
        if (report.StartReporter() != PROFILING_SUCCESS) {
            MSPROF_LOGE("ProfReporterMgr start reporters failed.");
            return PROFILING_FAILED;
        }
    }

    for (auto &level : DEFAULT_TYPE_INFO) {
        for (auto &type : level.second) {
            RegReportTypeInfo(level.first, type.first, type.second);
        }
    }
    if (!isSyncReporter_) {
        Start();
    }
    isStarted_ = true;
    return PROFILING_SUCCESS;
}

int32_t ProfReporterMgr::StartAdprofReporters()
{
    std::lock_guard<std::mutex> lk(startMtx_);
    if (!isStarted_) {
        MSPROF_LOGE("The host reporters have not been started, devprof will not start.");
        return PROFILING_FAILED;
    }

    if (adprofReporters_.empty()) {
        for (auto &module : ADPROF_MODULE_REPORT_TABLE) {
            adprofReporters_.emplace_back(MsprofReporter(module.name));
        }
    }

    for (auto &report : adprofReporters_) {
        if (report.StartReporter() != PROFILING_SUCCESS) {
            MSPROF_LOGE("Devprof start reporters failed.");
            return PROFILING_FAILED;
        }
    }
    return PROFILING_SUCCESS;
}

int32_t ProfReporterMgr::SendAdditionalData(SHARED_PTR_ALIA<ProfileFileChunk> fileChunk)
{
    return reporters_[ADDITIONAL].SendData(fileChunk);
}

void ProfReporterMgr::FlushAdditonalData()
{
    reporters_[ADDITIONAL].ForceFlush();
}

/**
 * @brief Flush all new reporter for subscribe scene
 */
void ProfReporterMgr::FlushAllReporter()
{
    for (auto &report : reporters_) {
        (void)report.ForceFlush();
    }
}

int32_t ProfReporterMgr::RegReportTypeInfo(uint16_t level, uint32_t typeId, const std::string &typeName)
{
    if (level == 0 && typeName.empty()) {
        MSPROF_LOGI("Register type info is invalid, level: [%u], type name %s", level, typeName.c_str());
        return PROFILING_FAILED;
    }
    MSPROF_LOGD("Register type info of reporter[%u], type id %u, type name %s", level, typeId, typeName.c_str());
    std::lock_guard<std::mutex> lk(regTypeInfoMtx_);
    reportTypeInfoMap_[level][typeId] = typeName;
    auto itr = std::find_if(reportTypeInfoMapVec_[level].begin(), reportTypeInfoMapVec_[level].end(),
        [typeId](const std::pair<uint32_t, std::string>& pair) { return pair.first == typeId; });
    if (itr != std::end(reportTypeInfoMapVec_[level])) {
        itr->second = typeName;
    } else {
        reportTypeInfoMapVec_[level].emplace_back(std::pair<uint32_t, std::string>(typeId, typeName));
    }
    return PROFILING_SUCCESS;
}

/**
 * @brief  validate dataFormatStr valid
 * @return true is ok, false is failed
 * rule 1: dataFormat string should be value json
 * rule 2: dataFormat json has 'version' key field
 * rule 3: key 'dependency' should be defined
 * eg,
 * {
 *     "version": 1.0,
 *     "level": "uint64",
 *     "type2": "uint64",
 *     "task_id":"uint64",
 *     "shape": {
 *         "value": "uint64",
 *         "dependency": "type2"
 *      }
 * }
 */
bool ProfReporterMgr::ValidateDataFormat(const std::string& dataFormatStr) const {
    NanoJson::Json dataFormatJson;
	// Rule 1：validate dataFormat is json string
    try {
        dataFormatJson.Parse(dataFormatStr);
    } catch (std::runtime_error& e) {
	    MSPROF_LOGE("Check rule #1 failed! Reason: not valid json.");
        return false;
    }
    // Rule 2：validate dataFormat has version key field
    if (!dataFormatJson.Contains("version")) {
        MSPROF_LOGE("Check rule #2 failed! Reason: no version key field.");
        return false;
    }
    // Rule 3：check dependency's value field should be defined
    std::string keyword = "dependency";
    for (auto it = dataFormatJson.Begin(); it != dataFormatJson.End(); ++it) {
        NanoJson::JsonValue value = it->second;
        if (value.type == NanoJson::JsonValueType::OBJECT && value.Contains(keyword)) {
            NanoJson::JsonValue keywordValue = value[keyword];
            if (keywordValue.type == NanoJson::JsonValueType::STRING) {
                if (!dataFormatJson.Contains(keywordValue.GetValue<std::string>())) {
                    MSPROF_LOGE("Check rule #3 failed! Reason: dependency value is not defined.");
                    return false;
                }
            } else {
                MSPROF_LOGE("Check rule #3 failed! Reason: dependency value type is not string.");
                return false;
            }
        }
    }
    return true;
}

int32_t ProfReporterMgr::RegReportDataFormat(uint16_t level, uint32_t typeId, const std::string &dataFormat)
{
    if (level == 0 && dataFormat.empty()) {
        MSPROF_LOGI("Register data format is invalid, level: [%u], data format %s", level, dataFormat.c_str());
        return PROFILING_FAILED;
    }
    bool ok = ValidateDataFormat(dataFormat);
    if (!ok) {
        return PROFILING_FAILED;
    }
    MSPROF_LOGD("Register data format of reporter[%u], type id %u, data format %s", level, typeId, dataFormat.c_str());
    std::lock_guard<std::mutex> lk(regDataFormatMtx_);
    reportDataFormatMap_[level][typeId] = dataFormat;
    auto itr = std::find_if(reportDataFormatMapVec_[level].begin(), reportDataFormatMapVec_[level].end(),
        [typeId](const std::pair<uint32_t, std::string>& pair) { return pair.first == typeId; });
    if (itr != std::end(reportDataFormatMapVec_[level])) {
        itr->second = dataFormat;
    } else {
        reportDataFormatMapVec_[level].emplace_back(std::pair<uint32_t, std::string>(typeId, dataFormat));
    }
    return PROFILING_SUCCESS;
}

void ProfReporterMgr::GetReportTypeInfo(uint16_t level, uint32_t typeId, std::string& tag)
{
    std::lock_guard<std::mutex> lk(regTypeInfoMtx_);
    if (reportTypeInfoMap_.find(level) != reportTypeInfoMap_.end() &&
        reportTypeInfoMap_[level].find(typeId) != reportTypeInfoMap_[level].end()) {
        tag = reportTypeInfoMap_[level][typeId];
    } else {
        MSPROF_LOGW("This data can not found message: level[%u], type[%u].", level, typeId);
        tag = "invalid";
    }
}

uint64_t ProfReporterMgr::GetHashId(const std::string &info) const
{
    return HashData::instance()->GenHashId(info);
}

void ProfReporterMgr::FillData(const std::string &saveHashData,
    SHARED_PTR_ALIA<ProfileFileChunk> fileChunk, bool isLastChunk, const std::string& filename) const
{
    fileChunk->fileName = filename;
    fileChunk->offset = -1;
    fileChunk->isLastChunk = isLastChunk;
    fileChunk->chunk = saveHashData;
    fileChunk->chunkSize = saveHashData.size();
    fileChunk->chunkModule = FileChunkDataModule::PROFILING_IS_FROM_MSPROF_HOST;
    fileChunk->extraInfo = Utils::PackDotInfo(std::to_string(DEFAULT_HOST_ID), std::to_string(DEFAULT_HOST_ID));
}

void ProfReporterMgr::SaveDataFormat(bool isLastChunk)
{
    std::lock_guard<std::mutex> lk(regDataFormatMtx_);
    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    UploaderMgr::instance()->GetUploader(std::to_string(DEFAULT_HOST_ID), uploader);
    if (uploader == nullptr) {
        return;
    }

    for (auto &dataFormat : reportDataFormatMapVec_) {
        // combined hash map data
        std::string saveHashData;
        size_t currentHashSize = dataFormat.second.size();
        for (size_t i = indexMap_[dataFormat.first]; i < currentHashSize; i++) {
            saveHashData.append(std::to_string(dataFormat.first) + "_" + std::to_string(dataFormat.second[i].first) +
                                HASH_DIC_DELIMITER + dataFormat.second[i].second + "\n");
        }
        if (saveHashData.empty()) {
            continue;
        }
        indexMap_[dataFormat.first] = currentHashSize;
        // construct ProfileFileChunk data
        SHARED_PTR_ALIA<ProfileFileChunk> fileChunk = nullptr;
        MSVP_MAKE_SHARED0_NODO(fileChunk, ProfileFileChunk, break);
        FillData(saveHashData, fileChunk, isLastChunk, "unaging.additional.data_format_dic");
        // upload ProfileFileChunk data
        int32_t ret = analysis::dvvp::transport::UploaderMgr::instance()->UploadData(
            std::to_string(DEFAULT_HOST_ID), fileChunk);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Data format upload data failed, level: %u, dataLen:%zu bytes", dataFormat.first,
                saveHashData.size());
            continue;
        }
        MSPROF_EVENT("total_size_data_format[%u], save data format length: %zu bytes, data format size: %zu",
            dataFormat.first, saveHashData.size(), dataFormat.second.size());
    }
}

void ProfReporterMgr::SaveData(bool isLastChunk)
{
    std::lock_guard<std::mutex> lk(regTypeInfoMtx_);
    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    UploaderMgr::instance()->GetUploader(std::to_string(DEFAULT_HOST_ID), uploader);
    if (uploader == nullptr) {
        return;
    }

    for (auto &typeInfo : reportTypeInfoMapVec_) {
        // combined hash map data
        std::string saveHashData;
        size_t currentHashSize = typeInfo.second.size();
        for (size_t i = indexMap_[typeInfo.first]; i < currentHashSize; i++) {
            saveHashData.append(std::to_string(typeInfo.first) + "_" + std::to_string(typeInfo.second[i].first) +
                                HASH_DIC_DELIMITER + typeInfo.second[i].second + "\n");
        }
        if (saveHashData.empty()) {
            continue;
        }
        indexMap_[typeInfo.first] = currentHashSize;
        // construct ProfileFileChunk data
        SHARED_PTR_ALIA<ProfileFileChunk> fileChunk = nullptr;
        MSVP_MAKE_SHARED0_NODO(fileChunk, ProfileFileChunk, break);
        FillData(saveHashData, fileChunk, isLastChunk, "unaging.additional.type_info_dic");
        // upload ProfileFileChunk data
        int32_t ret = analysis::dvvp::transport::UploaderMgr::instance()->UploadData(
            std::to_string(DEFAULT_HOST_ID), fileChunk);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Type info upload data failed, level: %u, dataLen:%zu bytes", typeInfo.first,
                saveHashData.size());
            continue;
        }
        MSPROF_EVENT("total_size_type_info[%u], save type info length: %zu bytes, type info size: %zu",
            typeInfo.first, saveHashData.size(), typeInfo.second.size());
    }
}

void ProfReporterMgr::NotifyQuit()
{
    std::lock_guard<std::mutex> lk(notifyMtx_);
    StopNoWait();
    cv_.notify_one();
}

void ProfReporterMgr::FlushMstxData()
{
    Collector::Dvvp::Mstx::MstxDataHandler::instance()->Stop();
}

int32_t ProfReporterMgr::StopReporters()
{
    std::lock_guard<std::mutex> lk(startMtx_);
    if (!isStarted_) {
        MSPROF_LOGI("The reporter isn't started, don't need to be stopped.");
        return PROFILING_SUCCESS;
    }
    if (!isSyncReporter_) {
        NotifyQuit();
        Stop();
    }
    MSPROF_LOGI("ProfReporterMgr stop reporters");
    isStarted_ = false;
    FlushMstxData();
    for (auto &report : reporters_) {
        if (report.StopReporter() != PROFILING_SUCCESS) {
            return PROFILING_FAILED;
        }
    }
    for (auto &report : adprofReporters_) {
        if (report.StopReporter() != PROFILING_SUCCESS) {
            return PROFILING_FAILED;
        }
    }
    isSyncReporter_ = false;
    reporters_.clear();
    adprofReporters_.clear();
    for (auto &index : indexMap_) {
        index.second = 0;
    }
    return PROFILING_SUCCESS;
}

/**
 * @name  FlushHostReporters
 * @brief Save type info dic data and flush data from report buffer api_event, compact and additional
 */
void ProfReporterMgr::FlushHostReporters()
{
    std::lock_guard<std::mutex> lk(startMtx_);
    if (!isStarted_) {
        MSPROF_LOGI("The reporter isn't started, don't need to flush.");
        return;
    }
    // Save type info dic data
    SaveData(true);
    SaveDataFormat(true);
    // Flush new report data
    for (auto &report : reporters_) {
        (void)report.ForceFlush();
    }
    for (auto &report : adprofReporters_) {
        (void)report.ForceFlush();
    }
}
}
}
}