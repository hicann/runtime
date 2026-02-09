/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef COLLECTOR_DVVP_MSPROF_DYNAMIC_PROFILING_DYN_PROF_SERVER_H
#define COLLECTOR_DVVP_MSPROF_DYNAMIC_PROFILING_DYN_PROF_SERVER_H

#include <cstdint>
#include <map>
#include <string>
#include <mutex>
#include "dyn_prof_def.h"
#include "thread/thread.h"

namespace Collector {
namespace Dvvp {
namespace DynProf {
class DynProfServer : public analysis::dvvp::common::thread::Thread {
public:
    DynProfServer() = default;
    ~DynProfServer() override = default;

    int32_t Start() override;
    int32_t Stop() override;
    bool IsProfStarted();
    void SaveDevicesInfo(DynProfDeviceInfo data);

protected:
    void Run(const struct error_message::Context &errorContext) override;

private:
    void DynProfSrvInitProcFunc();
    int32_t DynProfSrvCreate();
    int32_t DynProfSrvRecvParams();
    void DynProfSrvRsqMsg(DynProfMsgType type, DynProfMsgRsqCode rsqCode) const;
    void DynProfSrvProc();
    void DynProfSrvProcStart();
    void DynProfSrvProcStop();
    void DynProfSrvProcQuit();
    bool IdleConnectOverTime(uint32_t &recvIdleTimes) const;
    void NotifyClientDisconnect();

    int32_t srvSockFd_ { -1 };
    int32_t cliSockFd_ { -1 };
    bool srvStarted_ { false };
    bool profStarted_ { false };
    std::string socketPath_;
    std::string dynProfParams_;
    std::map<DynProfMsgType, ProcFunc> procFuncMap_;
    std::map<uint32_t, DynProfDeviceInfo> devicesInfo_;
    std::mutex devInfoMtx_;
    std::mutex devMtx_;
};
} // namespace DynProf
} // namespace Dvvp
} // namespace Collector

#endif