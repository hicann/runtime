/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "job_device_rpc.h"
#include "errno/error_code.h"
#include "message/codec.h"
#include "msprof_dlog.h"
#include "prof_manager.h"
#include "transport/hdc/dev_mgr_api.h"
#include "ai_drv_dev_api.h"
#include "transport/hdc/device_transport.h"
#include "task_relationship_mgr.h"
#include "config/config.h"
#include "uploader_mgr.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::TaskHandle;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::transport;

JobDeviceRpc::JobDeviceRpc(int32_t indexId)
    : indexId_(indexId),
      isStarted_(false)
{
    jobCtx_.dev_id = std::to_string(indexId);
}

JobDeviceRpc::~JobDeviceRpc()
{
}

int32_t JobDeviceRpc::StartProf(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    int32_t ret = PROFILING_FAILED;
    do {
        if (isStarted_ || params == nullptr) {
            break;
        }
        params_ = params;
        jobCtx_.job_id = params_->job_id;

        SHARED_PTR_ALIA<analysis::dvvp::proto::JobStartReq> startJobMessage;
        MSVP_MAKE_SHARED0_NODO(startJobMessage, analysis::dvvp::proto::JobStartReq, break);

        // set job params
        startJobMessage->mutable_hdr()->set_job_ctx(jobCtx_.ToString());
        startJobMessage->set_sampleconfig(params_->ToString());
        ret = SendMsgAndHandleResponse(startJobMessage);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to start job, devId:%d", indexId_);
            break;
        }
        pmuCfg_ = CreatePmuEventConfig(params, indexId_);
        MSPROF_LOGI("Starting, devId:%d", indexId_);
        SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStartReq> startReplayMessage = nullptr;
        MSVP_MAKE_SHARED0_NODO(startReplayMessage, analysis::dvvp::proto::ReplayStartReq, break);

        BuildStartReplayMessage(pmuCfg_, startReplayMessage);
        startReplayMessage->mutable_hdr()->set_job_ctx(jobCtx_.ToString());
        startReplayMessage->set_replayid(0);
        ret = SendMsgAndHandleResponse(startReplayMessage);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to start, devId:%d", indexId_);
            break;
        }
        isStarted_ = true;
    } while (0);

    return ret;
}


void JobDeviceRpc::BuildCtrlCpuEventMessage(SHARED_PTR_ALIA<PMUEventsConfig> cfg,
    SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStartReq> startReplayMessage) const
{
    if (cfg->ctrlCPUEvents.size() > 0) {
        MSPROF_LOGI("Dev id=%d, add_ctrl_cpu_events:%s.",
            indexId_, Utils::GetEventsStr(cfg->ctrlCPUEvents).c_str());
        for (auto iter = cfg->ctrlCPUEvents.begin(); iter != cfg->ctrlCPUEvents.end(); ++iter) {
            startReplayMessage->add_ctrl_cpu_events(iter->c_str());
        }
    }
}

void JobDeviceRpc::BuildLlcEventMessage(SHARED_PTR_ALIA<PMUEventsConfig> cfg,
    SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStartReq> startReplayMessage) const
{
    if (cfg->llcEvents.size() > 0) {
        MSPROF_LOGI("Dev id=%d, add_llc_events:%s.",
            indexId_, Utils::GetEventsStr(cfg->llcEvents).c_str());
        for (auto iter = cfg->llcEvents.begin(); iter != cfg->llcEvents.end(); ++iter) {
            startReplayMessage->add_llc_events(iter->c_str());
        }
    }
}

void JobDeviceRpc::BuildStartReplayMessage(SHARED_PTR_ALIA<PMUEventsConfig> cfg,
    SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStartReq> startReplayMessage) const
{
    BuildCtrlCpuEventMessage(cfg, startReplayMessage);
    BuildLlcEventMessage(cfg, startReplayMessage);
}

int32_t JobDeviceRpc::StopProf(void)
{
    int32_t ret = PROFILING_FAILED;
    do {
        if (!isStarted_) {
            break;
        }
        MSPROF_LOGI("Stop profiling begin, devId:%d", indexId_);

        SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStopReq> stopReplayMessage;
        MSVP_MAKE_SHARED0_NODO(stopReplayMessage, analysis::dvvp::proto::ReplayStopReq, break);

        stopReplayMessage->mutable_hdr()->set_job_ctx(jobCtx_.ToString());
        stopReplayMessage->set_replayid(0);
        ret = SendMsgAndHandleResponse(stopReplayMessage);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to stop, devId:%d", indexId_);
            break;
        }
        SHARED_PTR_ALIA<analysis::dvvp::proto::JobStopReq> stopJobMessage;
        MSVP_MAKE_SHARED0_NODO(stopJobMessage, analysis::dvvp::proto::JobStopReq, break);

        stopJobMessage->mutable_hdr()->set_job_ctx(jobCtx_.ToString());
        ret = SendMsgAndHandleResponse(stopJobMessage);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to stop job, devId:%d", indexId_);
            break;
        }
        MSPROF_LOGI("Stop profiling success, devId:%d", indexId_);
    } while (0);
    return ret;
}

int32_t JobDeviceRpc::SendMsgAndHandleResponse(SHARED_PTR_ALIA<google::protobuf::Message> msg)
{
    int32_t ret = PROFILING_FAILED;
    do {
        auto devTran = analysis::dvvp::transport::DevTransMgr::instance()->GetDevTransport(params_->job_id, indexId_);
        if (devTran == nullptr) {
            MSPROF_LOGE("DevTransport is null or not inited, jobId: %s , devId: %d", params_->job_id.c_str(), indexId_);
            break;
        }

        // encode message
        auto enc = analysis::dvvp::message::EncodeMessageShared(msg);
        if (enc == nullptr) {
            MSPROF_LOGE("Failed to encode message, devId:%d", indexId_);
            break;
        }

        // send ctrl message and recv response
        TLV_REQ_PTR packet = nullptr;
        ret = devTran->SendMsgAndRecvResponse(*enc, &packet);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to send message, devId:%d", indexId_);
            break;
        }

        ret = devTran->HandlePacket(packet, status_);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to handle response, devId:%d, info=%s", indexId_, status_.info.c_str());
            break;
        }
    } while (0);

    return ret;
}
}}}
