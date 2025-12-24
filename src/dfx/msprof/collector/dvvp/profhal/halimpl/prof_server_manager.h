/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PROF_SERVER_MANAGER_H
#define PROF_SERVER_MANAGER_H
#include <cstdint>
#include <unordered_map>
#include "singleton/singleton.h"
#include "prof_hdc_server.h"
#include "prof_helper_server.h"
#include "prof_hal_api.h"

namespace Dvvp {
namespace Hal {
namespace Server {
class ServerManager : public analysis::dvvp::common::singleton::Singleton<ServerManager> {
public:
    ServerManager();
    ~ServerManager() override;
    int32_t ProfServerInit(uint32_t moduleType, const ProfHalModuleConfig *moduleConfig, uint32_t length);
    int32_t ProfServerFinal();
    void SetFlushModuleCallback(const ProfHalFlushModuleCallback func);
    void SetSendAicpuDataCallback(const ProfHalSendAicpuDataCallback func);
    void SetHelperDirCallback(const ProfHalHelperDirCallback func);
    void SetSendHelperDataCallback(const ProfHalSendHelperDataCallback func);

private:
    int32_t ProfAiCpuServerInit(uint32_t devId);
    int32_t ProfHelperServerInit(uint32_t devId);
    std::unordered_map<uint32_t, SHARED_PTR_ALIA<Dvvp::Hal::Server::ProfHdcServer>> hdcDevMap_;
    std::unordered_map<uint32_t, SHARED_PTR_ALIA<Dvvp::Hal::Server::ProfHelperServer>> helperDevMap_;
    std::mutex halMtx_;
};
}
}
}
#endif
