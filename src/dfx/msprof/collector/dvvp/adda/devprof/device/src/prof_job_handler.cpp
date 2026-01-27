/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_job_handler.h"
#include "collection_entry.h"
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "param_validation.h"

namespace analysis {
namespace dvvp {
namespace device {
using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::validation;

ProfJobHandler::ProfJobHandler()
    : isInited_(false), engine_(nullptr), devId_(-1), devIdOnHost_(-1), _is_started(false), transport_(nullptr)
{
}

ProfJobHandler::~ProfJobHandler()
{
    Uinit();
}

int32_t ProfJobHandler::Init(int32_t devId, std::string jobId,
    SHARED_PTR_ALIA<analysis::dvvp::transport::ITransport> transport)
{
    if (transport == nullptr) {
        MSPROF_LOGE("Init failed, transport is null");
        return PROFILING_FAILED;
    }
    devId_ = devId;
    jobId_ = jobId;
    transport_ = transport;
    isInited_ = true;

    return PROFILING_SUCCESS;
}

int32_t ProfJobHandler::Uinit()
{
    if (isInited_) {
        devId_ = -1;
        jobId_ = "";
        isInited_ = false;
    }

    return PROFILING_SUCCESS;
}

void ProfJobHandler::SetDevIdOnHost(int32_t devIdOnHost)
{
    devIdOnHost_ = devIdOnHost;
}

const std::string& ProfJobHandler::GetJobId()
{
    return jobId_;
}

void ProfJobHandler::ResetTask()
{
    MSPROF_LOGI("ResetTask begin, _is_started:%d", _is_started);
    if (_is_started) {
        _is_started = false;
        engine_.reset();
    }
}

int32_t ProfJobHandler::InitEngine(analysis::dvvp::message::StatusInfo &statusInfo)
{
    int32_t ret = PROFILING_FAILED;
    do {
        statusInfo.status = analysis::dvvp::message::ERR;
        if (_is_started) {
            MSPROF_LOGE("InitEngine Profiling is already running on device");
            statusInfo.info = "Profiling is already running on device";
            break;
        }

        MSVP_MAKE_SHARED0_NODO(engine_, CollectEngine, break);
        ret = engine_->Init(devId_);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("InitEngine Failed to init collection engine");
            engine_.reset();
            statusInfo.info = "Failed to init collection engine";
            break;
        }

        engine_->SetDevIdOnHost(devIdOnHost_);
    } while (0);

    return ret;
}

int32_t ProfJobHandler::OnJobStart(SHARED_PTR_ALIA<analysis::dvvp::proto::JobStartReq> message,
                               analysis::dvvp::message::StatusInfo &statusInfo)
{
    int32_t ret = PROFILING_FAILED;
    MSPROF_LOGI("receive job start");
    do {
        if (message == nullptr) {
            MSPROF_LOGE("[OnJobStart] message is nullptr");
            break;
        }
        if (InitEngine(statusInfo) != PROFILING_SUCCESS) {
            MSPROF_LOGE("InitEngine failed");
            break;
        }

        ret = engine_->CollectStart(message->sampleconfig(), statusInfo);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("devId %d CollectStart failed", devId_);
            engine_.reset();
            ret = PROFILING_FAILED;
            break;
        }

        _is_started = true;
    } while (0);

    return ret;
}

int32_t ProfJobHandler::OnJobEnd(analysis::dvvp::message::StatusInfo &statusInfo)
{
    int32_t ret = PROFILING_FAILED;
    MSPROF_LOGI("receive job end");
    statusInfo.status = analysis::dvvp::message::ERR;
    if ((!_is_started) || (engine_ == nullptr)) {
        MSPROF_LOGE("OnJobEnd Profiling is not started on device");
        statusInfo.info = "Profiling is not started on device";
        return PROFILING_FAILED;
    }
    ret = engine_->CollectStop(statusInfo);
    ResetTask();

    return ret;
}

SHARED_PTR_ALIA<std::vector<std::string>> ProfJobHandler::GetControlCpuEvent(
    SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStartReq> message)
{
    SHARED_PTR_ALIA<std::vector<std::string>> ctrlCpuEvent;
    do {
        MSVP_MAKE_SHARED0_NODO(ctrlCpuEvent, std::vector<std::string>, break);
        for (int32_t i = 0; i < message->ctrl_cpu_events_size(); i++) {
            ctrlCpuEvent->push_back(message->ctrl_cpu_events(i));
        }
    } while (0);

    return ctrlCpuEvent;
}

SHARED_PTR_ALIA<std::vector<std::string>> ProfJobHandler::GetTsCpuEvent(
    SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStartReq> message)
{
    SHARED_PTR_ALIA<std::vector<std::string>> tsCpuEvent;
    do {
        MSVP_MAKE_SHARED0_NODO(tsCpuEvent, std::vector<std::string>, break);
        for (int32_t i = 0; i < message->ts_cpu_events_size(); i++) {
            tsCpuEvent->push_back(message->ts_cpu_events(i));
        }
    } while (0);

    return tsCpuEvent;
}

SHARED_PTR_ALIA<std::vector<std::string>> ProfJobHandler::GetLlcEvent(
    SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStartReq> message)
{
    // llc
    SHARED_PTR_ALIA<std::vector<std::string>> llcEvent;
    do {
        MSVP_MAKE_SHARED0_NODO(llcEvent, std::vector<std::string>, break);
        for (int32_t i = 0; i < message->llc_events_size(); i++) {
            llcEvent->push_back(message->llc_events(i));
        }
    } while (0);

    return llcEvent;
}

int32_t ProfJobHandler::CheckEventValid(SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStartReq> message)
{
    if (message == nullptr) {
        return PROFILING_FAILED;
    }
    if (!ParamValidation::instance()->CheckPmuEventSizeIsValid(message->ctrl_cpu_events_size())) {
        MSPROF_LOGE("ctrl_cpu_events_size(%d) is not valid!", message->ctrl_cpu_events_size());
        return PROFILING_FAILED;
    }
    if (!ParamValidation::instance()->CheckPmuEventSizeIsValid(message->ts_cpu_events_size())) {
        MSPROF_LOGE("ts_cpu_events_size(%d) is not valid!", message->ts_cpu_events_size());
        return PROFILING_FAILED;
    }
    if (!ParamValidation::instance()->CheckPmuEventSizeIsValid(message->ai_cpu_events_size())) {
        MSPROF_LOGE("ai_cpu_events_size(%d) is not valid!", message->ai_cpu_events_size());
        return PROFILING_FAILED;
    }
    if (!ParamValidation::instance()->CheckPmuEventSizeIsValid(message->llc_events_size())) {
        MSPROF_LOGE("llc_events_size(%d) is not valid!", message->llc_events_size());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfJobHandler::OnReplayStart(SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStartReq> message,
                                  analysis::dvvp::message::StatusInfo &statusInfo)
{
    int32_t ret = PROFILING_FAILED;
    MSPROF_LOGI("receive start");

    do {
        statusInfo.status = analysis::dvvp::message::ERR;
        if (!_is_started) {
            MSPROF_LOGE("Start Profiling is not started on device");
            statusInfo.info = "Profiling is not started on device";
            break;
        }
        ret = CheckEventValid(message);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Start pmu event size is not valid");
            statusInfo.info = "[Start] pmu event size is not valid!";
            break;
        }
        if (engine_ == nullptr) {
            MSPROF_LOGE("Start Engine is null");
            statusInfo.info = "[Start] Start Engine is null!";
            ret = PROFILING_FAILED;
            break;
        }
        ret = engine_->CollectStartReplay(GetControlCpuEvent(message), statusInfo, GetLlcEvent(message));
    } while (0);

    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Start failed, doing ResetTask!");
        ResetTask();
    }

    return ret;
}

int32_t ProfJobHandler::OnReplayEnd(SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStopReq> message,
                                analysis::dvvp::message::StatusInfo &statusInfo)
{
    int32_t ret = PROFILING_FAILED;
    MSPROF_LOGI("receive end");

    do {
        statusInfo.status = analysis::dvvp::message::ERR;
        if (message == nullptr) {
            MSPROF_LOGE("End message is nullptr");
            statusInfo.info = "StopReq message is nullptr";
            break;
        }
        if (!_is_started) {
            MSPROF_LOGE("End Profiling is not started on device");
            statusInfo.info = "Profiling is not started on device";
            break;
        }
        if (engine_ == nullptr) {
            MSPROF_LOGE("End Engine is null");
            statusInfo.info = "[End] End Engine is null!";
            break;
        }
        ret = engine_->CollectStopReplay(statusInfo);
    } while (0);

    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("End failed");
        ResetTask();
    }

    return ret;
}

int32_t ProfJobHandler::OnConnectionReset()
{
    MSPROF_LOGI("receive connection reset, _is_started:%d", _is_started ? 1 : 0);

    if (_is_started) {
        analysis::dvvp::message::StatusInfo statusInfo;
        if (engine_ == nullptr) {
            MSPROF_LOGE("OnConnectionReset engine is null");
            return PROFILING_FAILED;
        }
        if (engine_->CollectStop(statusInfo) != PROFILING_SUCCESS) {
            MSPROF_LOGW("Unable to stop collect.");
        }
        engine_.reset();
    }

    return PROFILING_SUCCESS;
}

int32_t ProfJobHandler::GetDevId()
{
    return devId_;
}

SHARED_PTR_ALIA<analysis::dvvp::transport::ITransport> ProfJobHandler::GetTransport(void)
{
    return transport_;
}
}  // namespace device
}  // namespace dvvp
}  // namespace analysis
