/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_HOST_DEVICE_H
#define ANALYSIS_DVVP_HOST_DEVICE_H

#include <condition_variable>
#include <memory>
#include <mutex>
#include "ai_drv_dev_api.h"
#include "job_adapter.h"
#include "message/prof_params.h"
#include "thread/thread.h"
#include "transport/transport.h"

namespace analysis {
namespace dvvp {
namespace host {
using DeviceCallback = void (*) (int32_t devId);
class Device : public analysis::dvvp::common::thread::Thread {
public:
    Device(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params, const std::string &devId);
    virtual ~Device();

public:
    void Run(const struct error_message::Context &errorContext) override;
    int32_t Stop() override;
    int32_t Wait();
    void PostStopReplay();
    const SHARED_PTR_ALIA<analysis::dvvp::message::StatusInfo> GetStatus();
    int32_t Init();
    int32_t SetResponseCallback(DeviceCallback callback);

private:
    int32_t InitJobAdapter();
    void WaitStopReplay();

private:
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params_;
    // for host app/training, devId from Constructor is phyId
    // for device app, devId from Constructor is phyId(on host), indexId(on device)
    std::string indexIdStr_;     // devId from Constructor
    int32_t indexId_;
    int32_t hostId_;
    bool isQuited_;
    // sync start/stop
    std::mutex mtx_;
    bool isStopReplayReady_;
    std::condition_variable cvSyncStopReplay;
    // store result
    SHARED_PTR_ALIA<analysis::dvvp::message::StatusInfo> status_;
    // init
    bool isInited_;
    DeviceCallback deviceResponseCallack_;
    SHARED_PTR_ALIA<Analysis::Dvvp::JobWrapper::JobAdapter> jobAdapter_;
};
}  // namespace host
}  // namespace dvvp
}  // namespace analysis

#endif
