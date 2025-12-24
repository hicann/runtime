/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "msprof_reporter.h"
#include "errno/error_code.h"
#include "prof_acl_mgr.h"
#include "prof_reporter.h"
#include "receive_data.h"
#include "prof_common.h"
#include "prof_api_common.h"
#include "uploader_dumper.h"
#include "transport/hash_data.h"

namespace Msprof {
namespace Engine {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::queue;
using namespace analysis::dvvp::transport;

// init map
std::map<uint32_t, MsprofReporter> MsprofReporter::reporters_;
static std::mutex g_reporterMtx;

MsprofReporter::MsprofReporter() {}

MsprofReporter::MsprofReporter(const std::string module) : module_(module)
{
}

MsprofReporter::~MsprofReporter()
{
    reporter_ = nullptr;
}

int32_t MsprofReporter::HandleReportRequest(uint32_t type, VOID_PTR data, uint32_t len)
{
    switch (type) {
        case MSPROF_REPORTER_REPORT:
            return ReportData(data, len);
        case MSPROF_REPORTER_INIT:
            return StartReporter();
        case MSPROF_REPORTER_UNINIT:
            return StopReporter();
        case MSPROF_REPORTER_DATA_MAX_LEN:
            return GetDataMaxLen(data, len);
        case MSPROF_REPORTER_HASH:
            return GetHashId(data, len);
        default:
            MSPROF_LOGE("Invalid reporter callback request type: %d", type);
    }
    return PROFILING_FAILED;
}

void MsprofReporter::ForceFlush()
{
    if (reporter_ != nullptr) {
        MSPROF_LOGI("ForceFlush, module: %s", module_.c_str());
        (std::dynamic_pointer_cast<Msprof::Engine::Reporter>(reporter_))->Flush();
    }
}

int32_t MsprofReporter::SendData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk)
{
    int32_t ret = HandleReportRequest(MSPROF_REPORTER_INIT, nullptr, 0);
    if (ret == PROFILING_SUCCESS) {
        MSPROF_LOGI("SendData, module: %s", module_.c_str());
        return reporter_->SendData(fileChunk);
    } else {
        MSPROF_LOGE("SendData failed, module: %s", module_.c_str());
    }
    return PROFILING_FAILED;
}

void MsprofReporter::InitReporters()
{
    if (!reporters_.empty()) {
        return;
    }
    MSPROF_EVENT("Init all reporters");
    for (auto &module : MSPROF_MODULE_ID_NAME_MAP) {
        reporters_.insert(std::make_pair(module.id, MsprofReporter(module.name)));
    }
}

int32_t MsprofReporter::ReportData(CONST_VOID_PTR data, uint32_t len) const
{
    (void)len;
    if (reporter_ == nullptr) {
        MSPROF_LOGE("reporter is not started, module: %s", module_.c_str());
        return PROFILING_FAILED;
    }
    return reporter_->Report(reinterpret_cast<CONST_REPORT_DATA_PTR>(data));
}

int32_t MsprofReporter::FlushData() const
{
    MSPROF_LOGI("FlushData from module: %s", module_.c_str());
    if (reporter_ == nullptr) {
        MSPROF_LOGE("Reporter is not started, module: %s", module_.c_str());
        return PROFILING_FAILED;
    }
    return (std::dynamic_pointer_cast<Msprof::Engine::Reporter>(reporter_))->Flush();
}

int32_t MsprofReporter::StartReporter()
{
    MSPROF_LOGI("StartReporter from module: %s", module_.c_str());
    if (module_.empty()) {
        MSPROF_LOGE("Empty module is not allowed");
        return PROFILING_FAILED;
    }
    if (reporter_ != nullptr) {
        MSPROF_LOGW("Reporter is already started, module: %s", module_.c_str());
        return PROFILING_SUCCESS;
    }
    if (!Msprofiler::Api::ProfAclMgr::instance()->IsInited() && !Utils::IsDynProfMode()) {
        MSPROF_LOGE("Profiling is not started, reporter can not be inited");
        return PROFILING_FAILED;
    }
    if (HashData::instance()->Init() == PROFILING_FAILED) {
        MSPROF_LOGE("HashData init failed, module: %s", module_.c_str());
    }
    MSVP_MAKE_SHARED1(reporter_, Msprof::Engine::UploaderDumper, module_, return PROFILING_FAILED);
    MSPROF_LOGI("The reporter %s is created successfully", module_.c_str());
    int32_t ret = reporter_->Start();
    if (ret != PROFILING_SUCCESS) {
        reporter_->Stop();
        reporter_.reset();
        MSPROF_LOGE("Failed to start reporter of %s", module_.c_str());
    }
    MSPROF_LOGI("The reporter %s started successfully", module_.c_str());
    return ret;
}

int32_t MsprofReporter::StopReporter()
{
    MSPROF_LOGI("StopReporter from module: %s", module_.c_str());
    if (reporter_ == nullptr) {
        MSPROF_LOGW("Reporter is not started, module: %s", module_.c_str());
        return PROFILING_SUCCESS;
    }
    (std::dynamic_pointer_cast<Msprof::Engine::Reporter>(reporter_))->Flush();
    if (Utils::IsDynProfMode()) {
        return PROFILING_SUCCESS;
    }
    int32_t ret = reporter_->Stop();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to stop reporter of %s", module_.c_str());
    }
    reporter_ = nullptr;
    return ret;
}

int32_t MsprofReporter::GetDataMaxLen(VOID_PTR data, uint32_t len) const
{
    if (reporter_ == nullptr) {
        MSPROF_LOGE("reporter is not started, module: %s", module_.c_str());
        return PROFILING_FAILED;
    }
    if (len < sizeof(uint32_t)) {
        MSPROF_LOGE("len:%d is so less", len);
        return PROFILING_FAILED;
    }
    *(reinterpret_cast<uint32_t *>(data)) = reporter_->GetReportDataMaxLen();
    return PROFILING_SUCCESS;
}

int32_t MsprofReporter::GetHashId(VOID_PTR data, uint32_t len) const
{
    if (!HashData::instance()->IsInit()) {
        MSPROF_LOGE("module:%s, HashData not be inited", module_.c_str());
        return PROFILING_FAILED;
    }
    if (data == nullptr || len != sizeof(struct MsprofHashData)) {
        MSPROF_LOGE("module:%s, params error, data:0x%lx len:%" PRIu64, module_.c_str(), data, len);
        return PROFILING_FAILED;
    }
    auto hData = reinterpret_cast<MsprofHashData *>(data);
    if (hData->data == nullptr || hData->dataLen > HASH_DATA_MAX_LEN || hData->dataLen == 0) {
        MSPROF_LOGE("module:%s, data error, data:0x%lx, dataLen:%" PRIu64,
            module_.c_str(), hData->data, hData->dataLen);
        return PROFILING_FAILED;
    }
    hData->hashId = HashData::instance()->GenHashId(module_,
        reinterpret_cast<CONST_CHAR_PTR>(hData->data), hData->dataLen);
    if (hData->hashId == 0) {
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

void FlushAllModule()
{
    for (auto iter = MsprofReporter::reporters_.begin(); iter != MsprofReporter::reporters_.cend(); iter++) {
        iter->second.ForceFlush();
    }
}

void FlushModule()
{
    std::lock_guard<std::mutex> lk(g_reporterMtx);
    MsprofReporter::reporters_[MSPROF_MODULE_DATA_PREPROCESS].ForceFlush();
}

int32_t SendAiCpuData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk)
{
    std::lock_guard<std::mutex> lk(g_reporterMtx);
    return MsprofReporter::reporters_[MSPROF_MODULE_DATA_PREPROCESS].SendData(fileChunk);
}
}  // namespace Engine
}  // namespace Msprof
