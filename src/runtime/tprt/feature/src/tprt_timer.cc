/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <thread>
#include <chrono>
#include "tprt_timer.hpp"
#include "tprt_base.hpp"
#include "tprt_device.hpp"

namespace cce {
namespace tprt {

TprtTimer::TprtTimer() : is_running_(false), device_(nullptr)
{ 
}

TprtTimer::~TprtTimer() 
{
    TPRT_LOG(TPRT_LOG_EVENT, "worker:%s destructor", workerName_.c_str());
}

void TprtTimer::Start(uint32_t interval) 
{
    if (is_running_) {
        TPRT_LOG(TPRT_LOG_WARNING, "TprtTimer is already running the periodic task.");
        return;
    }
    if (interval == 0) {
        TPRT_LOG(TPRT_LOG_WARNING, "TprtTimer interval is 0.");
        return;
    }
    is_running_ = true;
    interval_ = interval;
    workerName_ = std::to_string(device_->TprtDevGetDevId_());
    workerThread_ = std::thread(&TprtTimer::RunPeriodicTask, this); 
    TPRT_LOG(TPRT_LOG_INFO, "Worker thread of periodic task start, thread_name=%s", workerName_.c_str());
}

void TprtTimer::RunPeriodicTask() 
{
    workerName_ = std::to_string(mmGetTid()) + "_" + workerName_;
    TPRT_LOG(TPRT_LOG_INFO, "Worker thread of periodic task start, thread_name=%s", workerName_.c_str());
    while (is_running_) {
        auto startTime = std::chrono::steady_clock::now();

        if (device_ == nullptr) {
            continue;
        }
        try {
            device_->RunCheckTaskTimeout();
        } catch (...) {
            TPRT_LOG(TPRT_LOG_ERROR, "Exception occurred while running RunCheckTaskTimeout.");
        }

        auto elapsedTime = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now() - startTime); 
        // 计算需要休眠的时间	 
        auto sleepTime = std::chrono::milliseconds(interval_) - elapsedTime;	 
        if (sleepTime.count() > 0) { 
            // 执行休眠 
            std::this_thread::sleep_for(sleepTime); 
        }
    }
}

void TprtTimer::Stop() {
    if (is_running_) {
        is_running_ = false;
        if (workerThread_.joinable()) {
            workerThread_.join();
        }
        TPRT_LOG(TPRT_LOG_INFO, "TprtTimer worker thread stop, thread_name=%s", workerName_.c_str());
    }
}
}
}