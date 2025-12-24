/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_PROFILER_COMMAND_HANDLE_H
#define ANALYSIS_DVVP_PROFILER_COMMAND_HANDLE_H

#include <cstdint>
#include <map>
#include <set>
#include "acl/acl_base.h"
#include "utils/utils.h"
#include "prof_api.h"
#include "prof_common.h"

namespace Analysis {
namespace Dvvp {
namespace ProfilerCommon {
using ProfCommand = MsprofCommandHandle;
constexpr uint32_t PROF_INVALID_MODE_ID = 0xFFFFFFFFUL;
int32_t CommandHandleProfInit();
int32_t CommandHandleProfStart(const uint32_t devIdList[], uint32_t devNums, uint64_t profSwitch,
                               uint64_t profSwitchHi);
int32_t CommandHandleProfStop(const uint32_t devIdList[], uint32_t devNums, uint64_t profSwitch, uint64_t profSwitchHi);
int32_t CommandHandleProfFinalize();
int32_t CommandHandleProfUnSubscribe(uint32_t modelId);
void CommandHandleFinalizeGuard();
int32_t ProfRegisterCallback(uint32_t moduleId, ProfCommandHandle callback);

class ProfModuleReprotMgr {
public:
    static ProfModuleReprotMgr &GetInstance()
    {
        static ProfModuleReprotMgr mgr;
        return mgr;
    }
    void DoCallbackHandle(ProfCommandHandle callback);
    int32_t ModuleRegisterCallback(uint32_t moduleId, ProfCommandHandle callback);
    int32_t ModuleReportInit();
    int32_t ModuleReportStart(const uint32_t devIdList[], uint32_t devNums, uint64_t profSwitch,
                              uint64_t profSwitchHi);
    int32_t ModuleReportStop(const uint32_t devIdList[], uint32_t devNums, uint64_t profSwitch, uint64_t profSwitchHi);
    int32_t ModuleReportFinalize();
    int32_t ModuleReportUnSubscribe(uint32_t modelId);
    int32_t ProfSetProCommand(ProfCommand &command);
    void ProfSetFinalizeGuard();

private:
    ProfModuleReprotMgr() : finalizeGuard_(false)
    {
        command_.type = PROF_COMMANDHANDLE_TYPE_MAX;
    }
    ~ProfModuleReprotMgr();
    int32_t SetCommandHandleProf(ProfCommand &command) const;
    void ProcessDeviceList(ProfCommand &command, const uint32_t devIdList[], uint32_t devNums) const;

    std::mutex regCallback_;
    ProfCommand command_;
    std::map<uint32_t, std::set<ProfCommandHandle>> moduleCallbacks_;
    bool finalizeGuard_;
};
}  // namespace ProfilerCommon
}  // namespace Dvvp
}  // namespace Analysis

#endif
