/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "receiver.h"
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "task_manager.h"

namespace analysis {
namespace dvvp {
namespace device {
using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::transport;
using namespace Analysis::Dvvp::MsprofErrMgr;

Receiver::Receiver(SHARED_PTR_ALIA<analysis::dvvp::transport::AdxTransport> transport)
    : dispatcher_(nullptr), transport_(transport), devId_(-1), devIdOnHost_(-1), inited_(false)
{
}

Receiver::~Receiver()
{
    Uinit();
}

int32_t Receiver::Init(int32_t devId)
{
    int32_t ret = PROFILING_FAILED;

    do {
        MSVP_MAKE_SHARED0_NODO(dispatcher_, analysis::dvvp::message::MsgDispatcher, break);

        SHARED_PTR_ALIA<JobStartHandler> jobStartHandler;
        MSVP_MAKE_SHARED1_NODO(jobStartHandler, JobStartHandler, transport_, break);
        dispatcher_->RegisterMessageHandler<analysis::dvvp::proto::JobStartReq>(jobStartHandler);

        SHARED_PTR_ALIA<JobStopHandler> jobStopHandler;
        MSVP_MAKE_SHARED0_NODO(jobStopHandler, JobStopHandler, break);
        dispatcher_->RegisterMessageHandler<analysis::dvvp::proto::JobStopReq>(jobStopHandler);

        SHARED_PTR_ALIA<ReplayStartHandler> replayStartHandler;
        MSVP_MAKE_SHARED0_NODO(replayStartHandler, ReplayStartHandler, break);
        dispatcher_->RegisterMessageHandler<analysis::dvvp::proto::ReplayStartReq>(replayStartHandler);

        SHARED_PTR_ALIA<ReplayStopHandler> replayStopHandler;
        MSVP_MAKE_SHARED0_NODO(replayStopHandler, ReplayStopHandler, break);
        dispatcher_->RegisterMessageHandler<analysis::dvvp::proto::ReplayStopReq>(replayStopHandler);

        devId_ = devId;
        inited_ = true;
        ret = PROFILING_SUCCESS;
    } while (0);

    return ret;
}

int32_t Receiver::Uinit()
{
    MSPROF_LOGI("Receiver Unint");
    if (transport_ != nullptr) {
        transport_->CloseSession();
        FUNRET_CHECK_EXPR_LOGW(Stop() != PROFILING_SUCCESS, "Unable to stop thread: %s", GetThreadName().c_str());
        transport_.reset();
    }

    devId_ = -1;
    inited_ = false;

    return PROFILING_SUCCESS;
}

void Receiver::SetDevIdOnHost(int32_t devIdOnHost)
{
    devIdOnHost_ = devIdOnHost;
}

int32_t Receiver::SendMessage(SHARED_PTR_ALIA<google::protobuf::Message> message)
{
    int32_t ret = PROFILING_FAILED;

    if (message != nullptr) {
        std::string encoded = analysis::dvvp::message::EncodeMessage(message);
        ret = transport_->SendBuffer(encoded.c_str(), encoded.size());
        MSPROF_LOGI("DeviceOnHost(%d) Send message size %zu ret %d",
            devIdOnHost_, encoded.size(), ret);
    }

    return ret;
}

const SHARED_PTR_ALIA<analysis::dvvp::transport::AdxTransport> Receiver::GetTransport()
{
    return transport_;
}

void Receiver::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);
    MSPROF_LOGI("Receiver begin, devId:%d, devIdOnHost:%d", devId_, devIdOnHost_);
    if (!inited_) {
        MSPROF_LOGE("Receiver is not inited.");
        MSPROF_INNER_ERROR("EK9999", "Receiver is not inited.");
        return;
    }

    do {
        // wait for next message
        TLV_REQ_PTR packet = nullptr;
        int32_t bytesReceived = transport_->RecvPacket(&packet);
        if (bytesReceived < 0 || packet == nullptr) {
            MSPROF_LOGW("devIdOnHost(%d) unable to recv packet from host", devIdOnHost_);
            analysis::dvvp::device::TaskManager::instance()->ConnectionReset(transport_);
            StopNoWait();
            break;
        }

        MSPROF_LOGI("DeviceOnHost(%d) Receiver message size %d", devIdOnHost_, bytesReceived);
        std::string buf(packet->value, packet->len);
        transport_->DestroyPacket(packet);
        packet = nullptr;

        dispatcher_->OnNewMessage(analysis::dvvp::message::DecodeMessage(buf));
    } while (!IsQuit());
    MSPROF_LOGI("Receiver end, devId:%d, devIdOnHost:%d", devId_, devIdOnHost_);
}
}  // namespace device
}  // namespace dvvp
}  // namespace analysis
