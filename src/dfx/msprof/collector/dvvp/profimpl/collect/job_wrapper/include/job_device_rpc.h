/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_JOB_DEVICE_RPC_H
#define ANALYSIS_DVVP_JOB_DEVICE_RPC_H

#include "collection_register.h"
#include "job_adapter.h"
#include "message/codec.h"
#include "message/prof_params.h"
#include "proto/profiler.pb.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
class JobDeviceRpc : public JobAdapter {
public:
    explicit JobDeviceRpc(int32_t indexId);
    ~JobDeviceRpc() override;

public:
    int32_t StartProf(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) override;
    int32_t StopProf(void) override;

private:
    int32_t SendMsgAndHandleResponse(SHARED_PTR_ALIA<google::protobuf::Message> msg);
    void BuildStartReplayMessage(SHARED_PTR_ALIA<PMUEventsConfig> cfg,
                                SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStartReq> startReplayMessage) const;
    void BuildCtrlCpuEventMessage(SHARED_PTR_ALIA<PMUEventsConfig> cfg,
                                SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStartReq> startReplayMessage) const;
    void BuildLlcEventMessage(SHARED_PTR_ALIA<PMUEventsConfig> cfg,
                                SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStartReq> startReplayMessage) const;
private:
    int32_t indexId_;
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params_;
    bool isStarted_;
    analysis::dvvp::message::JobContext jobCtx_;
    SHARED_PTR_ALIA<PMUEventsConfig> pmuCfg_;
};
}}}
#endif