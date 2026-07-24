/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef INNER_INC_PROCESS_MODE_MANAGER_H
#define INNER_INC_PROCESS_MODE_MANAGER_H

#include "inc/client_manager.h"
#include "inc/process_shared_context.h"
#include "inc/response_msg_dispatcher.h"
#include "inc/sub_process_controller.h"
#include "inc/tsd_process_controller.h"
#include "capability_manager.h"
#include "package_manager.h"
#include "device_comm.h"
#include "device_comm_agent.h"
#include "driver/ascend_hal.h"
#include "proto/tsd_message.pb.h"

namespace tsd {
class ProcessModeManager : public ClientManager {
public:
    explicit ProcessModeManager(const uint32_t deviceId, const uint32_t deviceMode);

    TSD_StatusT Open(const uint32_t rankSize) override;

    TSD_StatusT OpenAicpuSd() override;

    TSD_StatusT Close(const uint32_t flag) override;

    TSD_StatusT GetHdcConctStatus(int32_t& hdcSessStat) override;

    TSD_StatusT UpdateProfilingConf(const uint32_t& flag) override;

    TSD_StatusT InitQs(const InitFlowGwInfo* const initInfo) override;

    TSD_StatusT CapabilityGet(const int32_t type, const uint64_t ptr) override;

    static void ServerToClientMsgProc(const uint32_t sessionID, const HDCMessage& msg);

    static void CapabilityResMsgProc(const uint32_t sessionID, const HDCMessage& msg);

    static void PackageInfoMsgProc(const uint32_t sessionID, const HDCMessage& msg);

    void Destroy() override;

    virtual ~ProcessModeManager() override;

    TSD_StatusT LoadFileToDevice(
        const char_t* const filePath, const uint64_t pathLen, const char_t* const fileName,
        const uint64_t fileNameLen) override;

    TSD_StatusT ProcessOpenSubProc(ProcOpenArgs* openArgs) override;

    TSD_StatusT ProcessCloseSubProc(const pid_t closePid) override;

    TSD_StatusT GetSubProcStatus(ProcStatusInfo* pidInfo, const uint32_t arrayLen) override;

    TSD_StatusT RemoveFileOnDevice(const char_t* const filePath, const uint64_t pathLen) override;

    TSD_StatusT ProcessCloseSubProcList(const ProcStatusParam* closeList, const uint32_t listSize) override;

    TSD_StatusT GetSubProcListStatus(ProcStatusParam* pidInfo, const uint32_t arrayLen) override;

    TSD_StatusT OpenNetService(const NetServiceOpenArgs* args) override;

    TSD_StatusT CloseNetService() override;

    PackageManager& GetPackageManager() { return packageMgr_; }

    ResponseMsgDispatcher& GetDispatcher() { return rspDispatcher_; }

    SubProcessController& GetSubProcessController() { return subProcCtrl_; }

    TsdProcessController& GetTsdController() { return tsdCtrl_; }

    void DeviceMsgProcess(const HDCMessage& msg) { rspDispatcher_.DeviceMsgProcess(msg); }

private:
    void GetLogLevel();
    void SyncSharedCtxLogLevels();
    void ParseModuleLogLevelByKey(const std::string& keyStr, const std::string& valStr);

    void ParseModuleLogLevel(const std::string& envModuleLogLevel);

    std::string logLevel_;
    DeviceCommAgent commAgent_;
    ProcessSharedContext sharedCtx_;
    CapabilityManager capabilityMgr_;
    PackageManager packageMgr_;
    ResponseMsgDispatcher rspDispatcher_;
    TsdProcessController tsdCtrl_;
    SubProcessController subProcCtrl_;
    std::string ccecpuLogLevel_;
    std::string aicpuLogLevel_;
};

} // namespace tsd
#endif // INNER_INC_PROCESS_MODE_MANAGER_H
