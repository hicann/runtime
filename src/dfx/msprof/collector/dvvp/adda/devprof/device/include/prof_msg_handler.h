/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_DEVICE_PROF_MSG_HANDLER_H
#define ANALYSIS_DVVP_DEVICE_PROF_MSG_HANDLER_H

#include "message/dispatcher.h"
#include "message/prof_params.h"
#include "proto/profiler.pb.h"
#include "transport/transport.h"
#include "prof_manager.h"
namespace analysis {
namespace dvvp {
namespace device {
extern SHARED_PTR_ALIA<google::protobuf::Message> CreateResponse(
    analysis::dvvp::message::StatusInfo &statusInfo);

class IJobCallback {
public:
    virtual ~IJobCallback() {}

public:
    virtual int32_t OnJobStart(SHARED_PTR_ALIA<analysis::dvvp::proto::JobStartReq> message,
                           analysis::dvvp::message::StatusInfo &statusInfo) = 0;

    virtual int32_t OnJobEnd(analysis::dvvp::message::StatusInfo &statusInfo) = 0;

    virtual int32_t OnReplayStart(SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStartReq> message,
                              analysis::dvvp::message::StatusInfo &statusInfo) = 0;

    virtual int32_t OnReplayEnd(SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStopReq> message,
                            analysis::dvvp::message::StatusInfo &statusInfo) = 0;

    virtual int32_t OnConnectionReset() = 0;

    virtual int32_t GetDevId() = 0;
};

class JobStartHandler : public analysis::dvvp::message::IMsgHandler {
public:
    explicit JobStartHandler(SHARED_PTR_ALIA<analysis::dvvp::transport::ITransport> transport)
    {
        transport_ = transport;
    }
    virtual ~JobStartHandler() {}

public:
    void OnNewMessage(SHARED_PTR_ALIA<google::protobuf::Message> message) override;

private:
    SHARED_PTR_ALIA<analysis::dvvp::transport::ITransport> transport_;
};

class JobStopHandler : public analysis::dvvp::message::IMsgHandler {
public:
    explicit JobStopHandler() {}
    virtual ~JobStopHandler() {}

public:
    void OnNewMessage(SHARED_PTR_ALIA<google::protobuf::Message> message) override;
};

class ReplayStartHandler : public analysis::dvvp::message::IMsgHandler {
public:
    explicit ReplayStartHandler() {}
    virtual ~ReplayStartHandler() {}

public:
    void OnNewMessage(SHARED_PTR_ALIA<google::protobuf::Message> message) override;
};

class ReplayStopHandler : public analysis::dvvp::message::IMsgHandler {
public:
    explicit ReplayStopHandler() {}
    virtual ~ReplayStopHandler() {}

public:
    void OnNewMessage(SHARED_PTR_ALIA<google::protobuf::Message> message) override;
};
}  // namespace device
}  // namespace dvvp
}  // namespace analysis

#endif
