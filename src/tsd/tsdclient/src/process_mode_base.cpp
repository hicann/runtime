/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/log.h"
#include "inc/process_mode_manager.h"
#include "env_internal_api.h"

namespace {
constexpr int32_t ERROR_LOG = 3;
constexpr int32_t DEBUG_LOG = 0;
constexpr uint32_t HCCP_START_RANK_SIZE = 1U;
}  // namespace
namespace tsd {
ProcessModeManager::ProcessModeManager(const uint32_t deviceId, const uint32_t deviceMode)
    : ClientManager(deviceId),
      logLevel_("003"),  // error level
      tsdSessionId_(0U),
      hdcTsdClient_(nullptr),
      rspCode_(ResponseCode::FAIL),
      rankSize_(0U),
      aicpuPackageExistInDevice_(false),
      aicpuDeviceMode_(deviceMode),
      schedPolicy_(0U),
      pidQos_(-1),
      tsdSupportLevel_(0U),
      openSubPid_(0U),
      pidArry_(nullptr),
      pidArryLen_(0U),
      supportOmInnerDec_(false),
      pidList_(nullptr),
      tsdVersion_(0UL),
      adprofSupport_(false),
      versionCheckMap_({{TSD_SUB_PROC_UDF, &ProcessModeManager::IsSupportHeterogeneousInterface},
          {TSD_SUB_PROC_NPU, &ProcessModeManager::IsSupportHeterogeneousInterface},
          {TSD_SUB_PROC_BUILTIN_UDF, &ProcessModeManager::IsSupportBuiltinUdfInterface},
          {TSD_SUB_PROC_ADPROF, &ProcessModeManager::IsSupportAdprofInterface}}),
      getCheckCodeRetrySupport_(false),
      hccpPid_(0U),
      isStartedHccp_(false),
      ccecpuLogLevel_(""),
      aicpuLogLevel_(""),
      deviceIdle_(false),
      hostSoPath_(""),
      hasGetHostSoPath_(false),
      hasSendConfigFile_(false),
      loadPackageErrorMsg_("")
{
    GetLogLevel();
    SetTsdStartInfo(false, false, false);
    const auto ret = memset_s(&procSign_, sizeof(procSign_), 0x00, sizeof(procSign_));
    if (ret != EOK) {
        TSD_ERROR("memset set error %d.", ret);
    }
    for (uint32_t index = 0U; index < static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_MAX); index++) {
        packagePeerCheckCode_[index] = 0U;
        packageHostCheckCode_[index] = 0U;
    }
}

void ProcessModeManager::Destroy()
{
    TSD_CHECK_NULLPTR_VOID(hdcTsdClient_);
    initFlag_ = false;
    SetTsdStartInfo(false, false, false);
    hdcTsdClient_->Destroy();
    hdcTsdClient_ = nullptr;
    aicpuPackageExistInDevice_ = false;
}

void ProcessModeManager::ParseModuleLogLevelByKey(const std::string &keyStr, const std::string &valStr)
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

void ProcessModeManager::ParseModuleLogLevel(const std::string &envModuleLogLevel)
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
    // 最后拼装成一个3位字符串 第一位：event级别开关 第二位：预留 第三位：日志级别
    // 101 开启event info级别日志
    // 003 关闭event error级别日志
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
        TSD_RUN_INFO("[TsdClient] get ASCEND_GLOBAL_LOG_LEVEL [%s] ASCEND_GLOBAL_EVENT_ENABLE [%s] "
                     "ASCEND_MODULE_LOG_LEVEL [%s]", envLogLevel.c_str(), envEventLevel.c_str(),
                     envModuleLogLevel.c_str());
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
}

void ProcessModeManager::SetTsdStartInfo(const bool cpStatus, const bool hccpStatus, const bool qsStatus)
{
    tsdStartStatus_.startCp_ = cpStatus;
    tsdStartStatus_.startHccp_ = hccpStatus;
    tsdStartStatus_.startQs_ = qsStatus;
}

uint32_t ProcessModeManager::SetTsdClientCapabilityLevel() const
{
    uint32_t curSupport = 0U;
    TSD_BITMAP_SET(curSupport, TSDCLIENT_SUPPORT_NEW_ERRORCODE);
    TSD_INFO("Set tsdclient capability level, value is [%u].", curSupport);
    return curSupport;
}

bool ProcessModeManager::CheckNeedToOpen(const uint32_t rankSize, TsdStartStatusInfo &startInfo)
{
    if (rankSize <= HCCP_START_RANK_SIZE) {
        if (tsdStartStatus_.startCp_) {
            TSD_INFO("[TsdClient] cp has already opened, no need open again");
            return false;
        } else {
            startInfo.startHccp_ = false;
            startInfo.startCp_ = true;
        }
    } else {
        if ((tsdStartStatus_.startCp_) && (tsdStartStatus_.startHccp_)) {
            TSD_INFO("[TsdClient] hccp and cp has already opened, no need open again");
            return false;
        }
        startInfo.startCp_ = true;
        startInfo.startHccp_ = true;
    }
    TSD_INFO("[TsdClient] get open para startCp[%u] startHccp[%u] (0:false 1:true)",
             static_cast<uint32_t>(startInfo.startCp_), static_cast<uint32_t>(startInfo.startHccp_));
    return true;
}

std::string ProcessModeManager::GetHostSoPath() const
{
    Dl_info info = { };
    if (dladdr(reinterpret_cast<void *>(drvHdcSendFile), &info) == 0) {
        TSD_INFO("get host so path not success error[%s], errorno[%d]", SafeStrerror().c_str(), errno);
        return "";
    }
    TSD_INFO("dli_fname[%s]", info.dli_fname);
    if (info.dli_fname == nullptr) {
        return "";
    }
    std::string path(info.dli_fname);
    const size_t pos = path.find_last_of('/');
    std::string hostSoPath;
    if (pos != std::string::npos) {
        hostSoPath = path.substr (0, pos + static_cast<size_t>(1));
    } else {
        hostSoPath = "./";
    }
    TSD_INFO("host so path[%s]", hostSoPath.c_str());
    return hostSoPath;
}
}