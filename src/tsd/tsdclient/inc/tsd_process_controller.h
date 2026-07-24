/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef INNER_INC_TSD_PROCESS_CONTROLLER_H
#define INNER_INC_TSD_PROCESS_CONTROLLER_H

#include "inc/process_shared_context.h"
#include "capability_manager.h"
#include "package_manager.h"
#include "device_comm_agent.h"
#include "hdc_message_builder.h"

#include <chrono>

namespace tsd {

using TimePoint = std::chrono::high_resolution_clock::time_point;

struct TsdStartStatusInfo {
    bool startHccp_;
    bool startCp_;
    bool startQs_;
};

class TsdProcessController {
public:
    TsdProcessController(
        DeviceCommAgent& commAgent, CapabilityManager& capabilityMgr, PackageManager& packageMgr,
        ProcessSharedContext& sharedCtx, uint32_t aicpuDeviceMode);

    TSD_StatusT Open(uint32_t rankSize);
    TSD_StatusT OpenAicpuSd();
    TSD_StatusT OpenProcess(uint32_t rankSize);
    TSD_StatusT Close(uint32_t flag);
    TSD_StatusT GetHdcConctStatus(int32_t& hdcSessStat);
    TSD_StatusT InitQs(const InitFlowGwInfo* const initInfo);
    TSD_StatusT UpdateProfilingConf(const uint32_t& flag);

    TSD_StatusT InitTsdClient();
    TSD_StatusT WaitRsp(uint32_t timeout, bool ignoreRecvErr = false, bool isClose = false);
    MessageContext BuildBaseMessageContext() const;

    void SetTsdStartInfo(bool cpStatus, bool hccpStatus, bool qsStatus);
    bool CheckNeedToOpen(uint32_t rankSize, TsdStartStatusInfo& startInfo);

    TSD_StatusT ProcessQueueForAdc();
    TSD_StatusT SyncQueueAuthority() const;
    TSD_StatusT ProcessQueueGrant(
        const QueueQueryOutputPara& queueInfoOutBuff, const QueueQueryOutput* const queueInfoList,
        const pid_t aicpuPid) const;
    TSD_StatusT GetAicpusdPid(pid_t& aicpusdPid) const;

    TsdStartStatusInfo& GetTsdStartStatus() { return tsdStartStatus_; }
    const TsdStartStatusInfo& GetTsdStartStatus() const { return tsdStartStatus_; }
    uint32_t GetRankSize() const { return rankSize_; }
    void SetRankSize(uint32_t rankSize) { rankSize_ = rankSize; }
    const std::string& GetQsInitGrpName() const { return qsInitGrpName_; }
    void SetQsInitGrpName(const std::string& name) { qsInitGrpName_ = name; }
    uint64_t GetSchedPolicy() const { return schedPolicy_; }
    void SetSchedPolicy(uint64_t policy) { schedPolicy_ = policy; }
    uint32_t GetHccpPid() const { return hccpPid_; }
    void SetHccpPid(uint32_t pid) { hccpPid_ = pid; }
    bool IsStartedHccp() const { return isStartedHccp_; }
    void SetStartedHccp(bool started) { isStartedHccp_ = started; }

private:
    struct TsdCloseFlag {
        uint32_t quickCloseFlag : 1;
        uint32_t res : 31;
    };
    enum TsdCloseMode { QUICK_CLOSE_MODE = 1 };

    TSD_StatusT SendOpenMsg(uint32_t rankSize, TsdStartStatusInfo startInfo);
    TSD_StatusT SendCloseMsg();
    TSD_StatusT SendUpdateProfilingMsg(uint32_t flag);
    TSD_StatusT ConstructOpenMsg(HDCMessage& hdcMsg, const TsdStartStatusInfo& startInfo);
    TSD_StatusT ConstructCloseMsg(HDCMessage& msg);
    TSD_StatusT MapFailCodeToStatus() const;
    std::string BuildWaitRspErrReport(TSD_StatusT recvRet) const;
    void ParseTsdCloseFlag(uint32_t flag, TsdCloseFlag& tsdCloseFlag) const;
    TSD_StatusT LoadPackagesToDevice();
    TSD_StatusT WaitOpenRsp(const uint32_t rankSize);
    void LogOpenProcessDuration(
        const TimePoint& beginOpen, const TimePoint& finSendOpenMsg, const TimePoint& finRecvRsp,
        const TimePoint& finOpen) const;

    DeviceCommAgent& commAgent_;
    CapabilityManager& capabilityMgr_;
    PackageManager& packageMgr_;
    ProcessSharedContext& sharedCtx_;
    uint32_t aicpuDeviceMode_;
    TsdStartStatusInfo tsdStartStatus_ = {};
    uint32_t rankSize_ = 0U;
    std::string qsInitGrpName_;
    uint64_t schedPolicy_ = 0U;
    uint32_t hccpPid_ = 0U;
    bool isStartedHccp_ = false;
};

} // namespace tsd
#endif // INNER_INC_TSD_PROCESS_CONTROLLER_H
