/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_DEVICE_PROF_TASK_H
#define ANALYSIS_DVVP_DEVICE_PROF_TASK_H

#include <mutex>

#include "collect_engine.h"
#include "message/codec.h"
#include "message/dispatcher.h"
#include "prof_msg_handler.h"
#include "thread/thread.h"
#include "transport/transport.h"

namespace analysis {
namespace dvvp {
namespace device {
class ProfJobHandler : public IJobCallback {
public:
    explicit ProfJobHandler();
    ~ProfJobHandler() override;

public:
    int32_t Init(int32_t devId, std::string jobId, SHARED_PTR_ALIA<analysis::dvvp::transport::ITransport> transport);
    int32_t Uinit();
    void SetDevIdOnHost(int32_t devIdOnHost);
    const std::string& GetJobId();
    SHARED_PTR_ALIA<analysis::dvvp::transport::ITransport> GetTransport(void);

public:
    int32_t OnJobStart(SHARED_PTR_ALIA<analysis::dvvp::proto::JobStartReq> message,
                           analysis::dvvp::message::StatusInfo &statusInfo) override;

    int32_t OnJobEnd(analysis::dvvp::message::StatusInfo &statusInfo) override;

    int32_t OnReplayStart(SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStartReq> message,
                              analysis::dvvp::message::StatusInfo &statusInfo) override;

    int32_t OnReplayEnd(SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStopReq> message,
                            analysis::dvvp::message::StatusInfo &statusInfo) override;

    int32_t OnConnectionReset() override;

    int32_t GetDevId() override;

    virtual int32_t InitEngine(analysis::dvvp::message::StatusInfo &statusInfo);

private:
    void ResetTask();
    SHARED_PTR_ALIA<std::vector<std::string>> GetControlCpuEvent(
        SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStartReq> message);
    SHARED_PTR_ALIA<std::vector<std::string>> GetTsCpuEvent(
        SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStartReq> message);
    SHARED_PTR_ALIA<std::vector<std::string>> GetLlcEvent(
        SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStartReq> message);
    int32_t CheckEventValid(SHARED_PTR_ALIA<analysis::dvvp::proto::ReplayStartReq> message);

private:
    bool isInited_;
    SHARED_PTR_ALIA<CollectEngine> engine_;
    int32_t devId_;         // devIndexId
    int32_t devIdOnHost_;   // devPhyId
    std::string jobId_;
    volatile bool _is_started;
    SHARED_PTR_ALIA<analysis::dvvp::transport::ITransport> transport_;
};
}  // namespace device
}  // namespace dvvp
}  // namespace analysis

#endif
