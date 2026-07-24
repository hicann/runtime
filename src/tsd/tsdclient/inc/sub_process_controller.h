/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef INNER_INC_SUB_PROCESS_CONTROLLER_H
#define INNER_INC_SUB_PROCESS_CONTROLLER_H

#include "inc/process_shared_context.h"
#include "inc/tsd_process_controller.h"
#include "capability_manager.h"
#include "package_manager.h"
#include "device_comm_agent.h"
#include "hdc_message_builder.h"

namespace tsd {

class SubProcessController {
public:
    SubProcessController(
        TsdProcessController& tsdCtrl, DeviceCommAgent& commAgent, CapabilityManager& capabilityMgr,
        PackageManager& packageMgr, ProcessSharedContext& sharedCtx);

    TSD_StatusT OpenSubProc(ProcOpenArgs* openArgs);
    TSD_StatusT CloseSubProc(const pid_t closePid);
    TSD_StatusT CloseSubProcList(const ProcStatusParam* closeList, const uint32_t listSize);
    TSD_StatusT GetSubProcStatus(ProcStatusInfo* pidInfo, const uint32_t arrayLen);
    TSD_StatusT GetSubProcListStatus(ProcStatusParam* pidInfo, const uint32_t arrayLen);
    TSD_StatusT RemoveFileOnDevice(const char_t* const filePath, const uint64_t pathLen);

    TSD_StatusT SendCommonOpenMsg(const ProcOpenArgs* procArgs);
    TSD_StatusT ConstructCommonOpenMsg(HDCMessage& hdcMsg, const ProcOpenArgs* procArgs) const;
    bool SetCommonOpenParamList(MessageContext& ctx, const ProcOpenArgs* const procArgs) const;
    TSD_StatusT ExecuteClosePidList(const ProcStatusParam* closeList, const uint32_t startIndex, const uint32_t pidCnt);

private:
    TsdProcessController& tsdCtrl_;
    DeviceCommAgent& commAgent_;
    CapabilityManager& capabilityMgr_;
    PackageManager& packageMgr_;
    ProcessSharedContext& sharedCtx_;
};

} // namespace tsd

#endif // INNER_INC_SUB_PROCESS_CONTROLLER_H
