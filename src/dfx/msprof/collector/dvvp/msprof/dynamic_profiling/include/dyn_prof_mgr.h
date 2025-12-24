/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DYNAMIC_PROFILING_MANAGER_H
#define DYNAMIC_PROFILING_MANAGER_H

#include <string>
#include <mutex>
#include "singleton/singleton.h"
#include "dyn_prof_server.h"
#include "dyn_prof_thread.h"

namespace Collector {
namespace Dvvp {
namespace DynProf {
using namespace analysis::dvvp::common::thread;

class DynProfMgr : public analysis::dvvp::common::singleton::Singleton<DynProfMgr> {
public:
    DynProfMgr();
    ~DynProfMgr() override;
public:
    int32_t StartDynProf();
    void StopDynProf();
    void SaveDevicesInfo(uint32_t chipId, uint32_t devId, bool isOpenDevice);
    void SaveDevicesInfoSecurity(uint32_t chipId, uint32_t devId, bool isOpenDevice);
    bool IsDynStarted();
    bool IsProfStarted() const;

private:
    bool isStarted_;
    std::mutex startMtx_;
    SHARED_PTR_ALIA<DynProfServer> dynProfSrv_;
    SHARED_PTR_ALIA<DynProfThread> dynProfThread_;
};
} // DynProf
} // Dvvp
} // Collect
#endif