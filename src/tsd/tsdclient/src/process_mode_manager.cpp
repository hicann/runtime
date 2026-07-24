/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/process_mode_manager.h"
#include <string>
#include "tsd_log.h"
#include "tsd/status.h"
#include "env_internal_api.h"
#include "tsd_msg_parse_reg.h"

namespace {
constexpr int32_t ERROR_LOG = 3;
constexpr int32_t DEBUG_LOG = 0;
constexpr uint32_t DEFAULT_NET_SERVICE = 2U;
} // namespace

namespace tsd {

TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc1, HDCMessage::TSD_START_PROC_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc2, HDCMessage::TSD_CLOSE_PROC_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc3, HDCMessage::TSD_UPDATE_PROIFILING_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc4, HDCMessage::TSD_CHECK_PACKAGE_RSP, &ProcessModeManager::PackageInfoMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc5, HDCMessage::TSD_GET_PID_QOS_RSP, &ProcessModeManager::CapabilityResMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc6, HDCMessage::TSD_DRV_BIND_HOST_PID_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc7, HDCMessage::TSD_GET_DEVICE_RUNTIME_CHECKCODE_RSP, &ProcessModeManager::PackageInfoMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc8, HDCMessage::TSD_REMOVE_FILE_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc9, HDCMessage::TSD_OPEN_SUB_PROC_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc10, HDCMessage::TSD_GET_SUB_PROC_STATUS_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc11, HDCMessage::TSD_OM_PKG_DECOMPRESS_STATUS_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc12, HDCMessage::TSD_CLOSE_SUB_PROC_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc13, HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL_RSP,
    &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc14, HDCMessage::TSD_GET_DEVICE_DSHAPE_CHECKCODE_RSP, &ProcessModeManager::PackageInfoMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc15, HDCMessage::TSD_SUPPORT_OM_INNER_DEC_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc16, HDCMessage::TSD_CLOSE_SUB_PROC_LIST_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc17, HDCMessage::TSD_GET_SUPPORT_ADPROF_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc18, HDCMessage::TSD_CHECK_PACKAGE_RETRY_RSP, &ProcessModeManager::PackageInfoMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc19, HDCMessage::TSD_GET_DEVICE_PACKAGE_CHECKCODE_NORMAL_RSP,
    &ProcessModeManager::PackageInfoMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc20, HDCMessage::TSD_UPDATE_PACKAGE_PROCESS_CONFIG_RSP,
    &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc21, HDCMessage::TSD_GET_DEVICE_CANN_HS_CHECKCODE_RSP, &ProcessModeManager::PackageInfoMsgProc);

ProcessModeManager::ProcessModeManager(const uint32_t deviceId, const uint32_t deviceMode)
    : ClientManager(deviceId),
      logLevel_("003"),
      commAgent_(deviceId),
      sharedCtx_(),
      capabilityMgr_(deviceId, commAgent_, IsAdcEnv()),
      packageMgr_(deviceId, commAgent_, capabilityMgr_, GetPlatInfoMode(), IsAdcEnv(), GetPlatInfoChipType()),
      rspDispatcher_(sharedCtx_, packageMgr_, capabilityMgr_),
      tsdCtrl_(commAgent_, capabilityMgr_, packageMgr_, sharedCtx_, deviceMode),
      subProcCtrl_(tsdCtrl_, commAgent_, capabilityMgr_, packageMgr_, sharedCtx_),
      ccecpuLogLevel_(""),
      aicpuLogLevel_("")
{
    sharedCtx_.logicDeviceId = deviceId;
    sharedCtx_.isAdcEnv = IsAdcEnv();
    sharedCtx_.platInfoMode = GetPlatInfoMode();
    sharedCtx_.aicpuSchedMode = aicpuSchedMode_;
    GetLogLevel();
    SyncSharedCtxLogLevels();
    tsdCtrl_.SetTsdStartInfo(false, false, false);
}

void ProcessModeManager::Destroy()
{
    tsdCtrl_.SetTsdStartInfo(false, false, false);
    commAgent_.ReleaseDeviceConnection();
    packageMgr_.ResetOnClose();
}

void ProcessModeManager::ParseModuleLogLevelByKey(const std::string& keyStr, const std::string& valStr)
{
    int32_t val = 0;
    if (TransStrToInt(valStr, val)) {
        if (val >= DEBUG_LOG && val <= ERROR_LOG) {
            if (keyStr == "CCECPU") {
                ccecpuLogLevel_ = valStr;
            } else if (keyStr == "AICPU") {
                aicpuLogLevel_ = valStr;
            } else {
                TSD_INFO("[TsdClient] invalid key[%s]", keyStr.c_str());
            }
        }
    }
}

void ProcessModeManager::ParseModuleLogLevel(const std::string& envModuleLogLevel)
{
    std::size_t offsetColon = 0;
    std::size_t offsetEqual = 0;
    std::string keyStr = "";
    std::string valStr = "";
    std::string moduleLogLevel = envModuleLogLevel;
    while (true) {
        offsetColon = moduleLogLevel.find(":");
        if (offsetColon == std::string::npos) {
            offsetEqual = moduleLogLevel.find("=");
            if (offsetEqual != std::string::npos) {
                keyStr = moduleLogLevel.substr(0U, offsetEqual);
                valStr = moduleLogLevel.substr(offsetEqual + 1UL);
                ParseModuleLogLevelByKey(keyStr, valStr);
            }
            return;
        } else {
            std::string moduleLogLevelPart1 = moduleLogLevel.substr(0U, offsetColon);
            offsetEqual = moduleLogLevelPart1.find("=");
            if (offsetEqual != std::string::npos) {
                keyStr = moduleLogLevelPart1.substr(0U, offsetEqual);
                valStr = moduleLogLevelPart1.substr(offsetEqual + 1UL);
                ParseModuleLogLevelByKey(keyStr, valStr);
            }
            moduleLogLevel = moduleLogLevel.substr(offsetColon + 1UL);
        }
    }
}

void ProcessModeManager::GetLogLevel()
{
    int32_t defaultEventLevel = 1;
    int32_t defaultLogLevel = 3;
    if (&dlog_getlevel != nullptr) {
        defaultLogLevel = dlog_getlevel(AICPU, &defaultEventLevel);
    }
    std::string eventLevelString = std::to_string(defaultEventLevel);
    std::string logLevelString = std::to_string(defaultLogLevel);
    if (!IsAdcEnv()) {
        const std::string logPattern = "^[0-4]{1}$";
        const std::string eventPattern = "^[0-1]{1}$";
        std::string envLogLevel;
        std::string envModuleLogLevel;
        std::string envEventLevel;
        GetEnvFromMmSys(MM_ENV_ASCEND_GLOBAL_LOG_LEVEL, "ASCEND_GLOBAL_LOG_LEVEL", envLogLevel);
        GetEnvFromMmSys(MM_ENV_ASCEND_GLOBAL_EVENT_ENABLE, "ASCEND_GLOBAL_EVENT_ENABLE", envEventLevel);
        GetEnvFromMmSys(MM_ENV_ASCEND_MODULE_LOG_LEVEL, "ASCEND_MODULE_LOG_LEVEL", envModuleLogLevel);
        TSD_RUN_INFO(
            "[TsdClient] get ASCEND_GLOBAL_LOG_LEVEL [%s] ASCEND_GLOBAL_EVENT_ENABLE [%s] "
            "ASCEND_MODULE_LOG_LEVEL [%s]",
            envLogLevel.c_str(), envEventLevel.c_str(), envModuleLogLevel.c_str());
        if (ValidateStr(envLogLevel.c_str(), logPattern.c_str())) {
            logLevelString = envLogLevel;
        }
        if (ValidateStr(envEventLevel.c_str(), eventPattern.c_str())) {
            eventLevelString = envEventLevel;
        }
        if (ValidateStr(envModuleLogLevel.c_str(), envModuleLogLevel.c_str())) {
            ParseModuleLogLevel(envModuleLogLevel);
        }
    }
    logLevel_ = eventLevelString + "0" + logLevelString;
    TSD_INFO("[TsdClient] Get Log Level[%s]", logLevel_.c_str());
    SyncSharedCtxLogLevels();
}

void ProcessModeManager::SyncSharedCtxLogLevels()
{
    sharedCtx_.logLevel = logLevel_;
    sharedCtx_.ccecpuLogLevel = ccecpuLogLevel_;
    sharedCtx_.aicpuLogLevel = aicpuLogLevel_;
    sharedCtx_.profilingMode = static_cast<uint32_t>(profilingMode_);
    sharedCtx_.aicpuSchedMode = aicpuSchedMode_;
}

TSD_StatusT ProcessModeManager::Open(const uint32_t rankSize) { return tsdCtrl_.Open(rankSize); }

TSD_StatusT ProcessModeManager::OpenAicpuSd() { return tsdCtrl_.OpenAicpuSd(); }

TSD_StatusT ProcessModeManager::Close(const uint32_t flag) { return tsdCtrl_.Close(flag); }

TSD_StatusT ProcessModeManager::GetHdcConctStatus(int32_t& hdcSessStat)
{
    return tsdCtrl_.GetHdcConctStatus(hdcSessStat);
}

TSD_StatusT ProcessModeManager::UpdateProfilingConf(const uint32_t& flag) { return tsdCtrl_.UpdateProfilingConf(flag); }

TSD_StatusT ProcessModeManager::InitQs(const InitFlowGwInfo* const initInfo) { return tsdCtrl_.InitQs(initInfo); }

ProcessModeManager::~ProcessModeManager() {}

TSD_StatusT ProcessModeManager::CapabilityGet(const int32_t type, const uint64_t ptr)
{
    return capabilityMgr_.CapabilityGet(type, ptr);
}

TSD_StatusT ProcessModeManager::LoadFileToDevice(
    const char_t* const filePath, const uint64_t pathLen, const char_t* const fileName, const uint64_t fileNameLen)
{
    return packageMgr_.LoadFileToDevice(filePath, pathLen, fileName, fileNameLen, tsdCtrl_.BuildBaseMessageContext());
}

TSD_StatusT ProcessModeManager::ProcessOpenSubProc(ProcOpenArgs* openArgs)
{
    return subProcCtrl_.OpenSubProc(openArgs);
}

TSD_StatusT ProcessModeManager::ProcessCloseSubProc(const pid_t closePid)
{
    return subProcCtrl_.CloseSubProc(closePid);
}

TSD_StatusT ProcessModeManager::GetSubProcStatus(ProcStatusInfo* pidInfo, const uint32_t arrayLen)
{
    return subProcCtrl_.GetSubProcStatus(pidInfo, arrayLen);
}

TSD_StatusT ProcessModeManager::RemoveFileOnDevice(const char_t* const filePath, const uint64_t pathLen)
{
    return subProcCtrl_.RemoveFileOnDevice(filePath, pathLen);
}

TSD_StatusT ProcessModeManager::ProcessCloseSubProcList(const ProcStatusParam* closeList, const uint32_t listSize)
{
    return subProcCtrl_.CloseSubProcList(closeList, listSize);
}

TSD_StatusT ProcessModeManager::GetSubProcListStatus(ProcStatusParam* pidInfo, const uint32_t arrayLen)
{
    return subProcCtrl_.GetSubProcListStatus(pidInfo, arrayLen);
}

TSD_StatusT ProcessModeManager::OpenNetService(const NetServiceOpenArgs* args)
{
    if (!capabilityMgr_.IsSupportCommonInterface(TSD_SUPPORT_MUL_HCCP)) {
        TSD_RUN_INFO("current package does not support opening net service with args");
        if (tsdCtrl_.Open(DEFAULT_NET_SERVICE) != TSD_OK) {
            TSD_ERROR("open default net service failed");
            return TSD_OPEN_DEFAULT_NET_SERVICE_FAILED;
        } else {
            return TSD_OK;
        }
    } else {
        if (args == nullptr) {
            TSD_ERROR("openArgs is null");
            return TSD_INTERNAL_ERROR;
        }
        ProcOpenArgs openArgs;
        pid_t subPid = 0;
        openArgs.procType = SubProcType::TSD_SUB_PROC_HCCP;
        openArgs.envParaList = nullptr;
        openArgs.envCnt = 0UL;
        openArgs.filePath = nullptr;
        openArgs.pathLen = 0UL;
        openArgs.extParamCnt = args->extParamCnt;
        openArgs.extParamList = args->extParamList;
        openArgs.subPid = &subPid;
        return subProcCtrl_.OpenSubProc(&openArgs);
    }
}

TSD_StatusT ProcessModeManager::CloseNetService()
{
    if (!capabilityMgr_.IsSupportCommonInterface(TSD_SUPPORT_MUL_HCCP)) {
        TSD_RUN_INFO("current package does not support closing net service with args");
        return TsdClose(0U);
    } else {
        ProcStatusParam closeList;
        closeList.pid = tsdCtrl_.GetHccpPid();
        closeList.curStat = SubProcessStatus::SUB_PROCESS_STATUS_NORMAL;
        closeList.procType = SubProcType::TSD_SUB_PROC_HCCP;
        return subProcCtrl_.CloseSubProcList(&closeList, 1U);
    }
}

void ProcessModeManager::ServerToClientMsgProc(const uint32_t sessionID, const HDCMessage& msg)
{
    TSD_INFO("[ServerToClientMsgProc] [sessionID=%u]", sessionID);
    const uint32_t realDeviceId = msg.real_device_id();
    const std::shared_ptr<ProcessModeManager> client =
        std::dynamic_pointer_cast<ProcessModeManager>(ClientManager::GetInstance(realDeviceId, DIE_MODE, false));
    TSD_CHECK_NULLPTR_VOID(client);
    client->GetDispatcher().DeviceMsgProcess(msg);
}

void ProcessModeManager::PackageInfoMsgProc(const uint32_t sessionID, const HDCMessage& msg)
{
    TSD_INFO("[PackageInfoMsgProc] [sessionID=%u]", sessionID);
    const uint32_t realDeviceId = msg.real_device_id();
    TSD_INFO(
        "[PackageInfoMsgProc] [sessionID=%u] deviceId[%u], checkCode[%u]", sessionID, realDeviceId, msg.check_code());
    const std::shared_ptr<ProcessModeManager> client =
        std::dynamic_pointer_cast<ProcessModeManager>(ClientManager::GetInstance(realDeviceId, DIE_MODE, false));
    TSD_CHECK_NULLPTR_VOID(client);
    client->GetDispatcher().SaveDeviceCheckCode(msg);
}

void ProcessModeManager::CapabilityResMsgProc(const uint32_t sessionID, const HDCMessage& msg)
{
    TSD_INFO("[CapabilityResMsgProc] [sessionID=%u]", sessionID);
    const uint32_t realDeviceId = msg.real_device_id();
    const std::shared_ptr<ProcessModeManager> client =
        std::dynamic_pointer_cast<ProcessModeManager>(ClientManager::GetInstance(realDeviceId, DIE_MODE, false));
    TSD_CHECK_NULLPTR_VOID(client);
    client->GetDispatcher().PidQosMsgProc(msg);
}

} // namespace tsd
