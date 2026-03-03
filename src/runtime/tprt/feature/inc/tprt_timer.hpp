/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_TPRT_TIMER_HPP__
#define __CCE_TPRT_TIMER_HPP__
#include <thread>
#include <string>
#include <chrono>
#include <functional>

namespace cce {
namespace tprt {

class TprtDevice;

class TprtTimer {
public:
    TprtTimer();
    ~TprtTimer();

    void Start(uint32_t interval); 
    void Stop();
    void SetDevice(TprtDevice* device) { device_ = device; }

private:
    bool is_running_;
    uint32_t interval_;
    std::thread workerThread_;
    // the pattern of worker name is : {$pid}_{$devId}
    std::string workerName_;
    TprtDevice* device_;

    void RunPeriodicTask();
};
}
}
#endif