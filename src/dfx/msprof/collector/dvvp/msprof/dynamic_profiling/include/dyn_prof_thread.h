/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DYNAMIC_PROFILING_THREAD_H
#define DYNAMIC_PROFILING_THREAD_H

#include <mutex>
#include <condition_variable>
#include <chrono>
#include <map>
#include "thread/thread.h"
#include "prof_api.h"
#include "msprof_error_manager.h"
#include "dyn_prof_def.h"

namespace Collector {
namespace Dvvp {
namespace DynProf {

class DynProfThread : public analysis::dvvp::common::thread::Thread {
public:
    DynProfThread();
    ~DynProfThread() override;
 
    int32_t Start() override;
    int32_t Stop() override;
    void Run(const struct error_message::Context &errorContext) override;
    void SaveDevicesInfo(DynProfDeviceInfo data);
    bool IsProfStarted();

private:
    int32_t GetDelayAndDurationTime();
    int32_t StartProfTask();
    int32_t StopProfTask();

private:
    bool started_;
    bool profStarted_;
    uint32_t delayTime_;
    uint32_t durationTime_;
    bool durationSet_;
    std::condition_variable cvThreadStop_;
    std::mutex threadStopMtx_;
    std::map<uint32_t, DynProfDeviceInfo> devicesInfo_;
    std::mutex devInfoMtx_;
    std::string msprofEnvCfg_;
    std::mutex devMtx_;
};
} // DynProf
} // Dvvp
} // Collect
#endif