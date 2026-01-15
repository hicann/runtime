/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "acl/acl.h"

#include <mutex>
#include <fstream>
#include <cctype>
#include <algorithm>
#include "acl/acl_rt_impl.h"
#include "runtime/rt_preload_task.h"
#include "runtime/rt.h"
#include "runtime/rts/rts_device.h"
#include "runtime/rts/rts_stars.h"
#include "runtime/event.h"
#include "adx_datadump_server.h"
#include "base/err_mgr.h"
#include "common/log_inner.h"
#include "toolchain/plog.h"
#include "toolchain/dump.h"
#include "toolchain/profiling.h"
#include "common/error_codes_inner.h"
#include "common/resource_statistics.h"
#include "platform/platform_info.h"
#include "common/json_parser.h"
#include "utils/hash_utils.h"
#include "utils/string_utils.h"
#include "utils/file_utils.h"
#include "aclrt_impl/acl_rt_impl_base.h"
#include "aclrt_impl/init_callback_manager.h"

namespace {
    bool aclFinalizeFlag = false;
    thread_local static std::string aclRecentErrMsg;
    bool isEnableDefaultDevice = false;
    constexpr int32_t INVALID_DEFAULT_DEVICE = -1;
    constexpr int32_t ACL_DEFAULT_DEVICE_DISABLE = 0xFFFFFFFF;
    std::string aclInitJsonHash;
    std::string aclInitJsonPath;
    constexpr const char_t *const kAscendHomeEnvName = "ASCEND_HOME_PATH";
    constexpr const char_t *const kVersionInfoKey = "Version=";
    constexpr const char_t *const kDriverPathKey = "Driver_Install_Path_Param=";
    constexpr const char_t *const kFirmwarePathKey = "Firmware_Install_Path_Param=";
    constexpr const char_t *const kDriverPkgName = "driver";
    constexpr const char_t *const kFirmwarePkgName = "firmware";
    constexpr const char_t *const kRelPathInfo = "/share/info/";
    constexpr const char_t *const kInfoFileName = "/version.info";
    constexpr const char_t *const kPreAlpha = "alpha";
    constexpr const char_t *const kPreBeta = "beta";
    constexpr const char_t *const kPreRC = "rc";
    const int32_t kWeightMajor = 10000000;
    const int32_t kWeightMinor = 100000;
    const int32_t kWeightPatch = 1000;
    const int32_t kWeightAlpha = 300;
    const int32_t kWeightBeta = 200;
    const int32_t kWeightRC = 100;
    const std::string kAscendInstallPath = "/etc/ascend_install.info";
    const std::map<aclCANNPackageName, std::string> kMapToPkgName = {
        { ACL_PKG_NAME_CANN, "runtime" },
        { ACL_PKG_NAME_RUNTIME, "runtime" },
        { ACL_PKG_NAME_COMPILER, "bisheng-compiler" },
        { ACL_PKG_NAME_HCCL, "hccl" },
        { ACL_PKG_NAME_TOOLKIT, "oam-tools" },
        { ACL_PKG_NAME_OPP, "ops-legacy" },
        { ACL_PKG_NAME_OPP_KERNEL, "ops-legacy" },
        { ACL_PKG_NAME_DRIVER, "driver" },
    };

    aclError GetPlatformInfoWithKey(const std::string &key, int64_t *value)
    {
#ifdef __GNUC__
        const char *socName = aclrtGetSocNameImpl();
        if (socName == nullptr) {
            ACL_LOG_ERROR("Init SocVersion failed");
            return ACL_ERROR_INTERNAL_ERROR;
        }
        // call after aclInit
        const string socVersion(socName); 

        // init platform info
        if (fe::PlatformInfoManager::GeInstance().InitializePlatformInfo() != 0U) {
            ACL_LOG_INNER_ERROR("init runtime platform info failed, SocVersion = %s", socVersion.c_str());
            return ACL_ERROR_INTERNAL_ERROR;
        }

        fe::PlatFormInfos platformInfos;
        fe::OptionalInfos optionalInfos;
        if (fe::PlatformInfoManager::GeInstance().GetPlatformInfos(socVersion, platformInfos, optionalInfos) != 0U) {
            ACL_LOG_INNER_ERROR("get platform info failed, SocVersion = %s", socVersion.c_str());
            return ACL_ERROR_INTERNAL_ERROR;
        }
        std::string strVal;
        if (!platformInfos.GetPlatformResWithLock("SoCInfo", key, strVal)) {
            ACL_LOG_CALL_ERROR("get platform result failed, key = %s", key.c_str());
            return ACL_ERROR_INTERNAL_ERROR;
        }

        try {
            *value = std::stoll(strVal);
        } catch (...) {
            ACL_LOG_INNER_ERROR("strVal[%s] can not be converted to digital value", strVal.c_str());
            return ACL_ERROR_INTERNAL_ERROR;
        }
        ACL_LOG_INFO("Successfully get platform info, key = %s, value = %ld", key.c_str(), *value);
#endif
        return ACL_SUCCESS;
    }

    std::string ConvertVersion(const std::string &version) {
        size_t dashPos = version.find('-');
        if (dashPos == std::string::npos) {
            return version;
        }

        std::string prefix = version.substr(0, dashPos);
        std::string suffix = version.substr(dashPos + 1U);
        suffix.erase(std::remove(suffix.begin(), suffix.end(), '.'), suffix.end());

        return prefix + "." + suffix;
    }
}

namespace acl {
void resetAclJsonHash()
{
    aclInitJsonHash.clear();
}

void aclGetMsgCallback(const char_t *msg, uint32_t len)
{
    if (msg == nullptr) {
        return;
    }
    (void)aclRecentErrMsg.assign(msg, static_cast<size_t>(len));
}

int32_t UpdateOpSystemRunCfg(void *cfgAddr, uint32_t cfgLen)
{
    ACL_LOG_INFO("start to execute UpdateOpSystemRunCfg");
    if ((cfgAddr == nullptr) || (static_cast<size_t>(cfgLen) < sizeof(size_t))) {
        ACL_LOG_ERROR("UpdateOpSystemRunCfg failed, invalid config address(null) or invalid length %u.", cfgLen);
        return ACL_ERROR_RT_PARAM_INVALID;
    }

    // get device id
    int32_t devId = 0;
    auto rtErr = rtGetDevice(&devId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_ERROR("can not get device id, runtime errorCode is %d", rtErr);
        return rtErr;
    }

    uint64_t offset = 0;
    // rts interface
    rtErr = rtGetL2CacheOffset(devId, &offset);
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            ACL_LOG_WARN("can not get l2 cache offset, feature not support, device id = %d", devId);
        } else {
            ACL_LOG_ERROR("can not get l2 cache offset, runtime errorCode is %d, device id = %d", rtErr, devId);
        }
        return rtErr;
    }

    uint64_t *addr = static_cast<uint64_t *>(cfgAddr);
    *addr = offset;

    ACL_LOG_INFO("execute UpdateOpSystemRunCfg successfully, l2 cache offset is %lu, device id = %d", offset, devId);
    return ACL_RT_SUCCESS;
}

aclError HandleErrorManagerConfig(const char_t *const configPath, error_message::ErrorMessageMode &error_mode) {
    const std::string ACL_ERR_MSG_CONFIG_NAME = "err_msg_mode";
    const std::string INTERNAL_MODE = "\"0\"";
    const std::string PROCESS_MODE = "\"1\"";
    error_mode = error_message::ErrorMessageMode::INTERNAL_MODE;

    if ((configPath != nullptr) && (strlen(configPath) != 0UL)) {
        std::string strConfig = PROCESS_MODE;
        bool found = false;
        auto ret = acl::JsonParser::GetJsonCtxByKey(configPath, strConfig, ACL_ERR_MSG_CONFIG_NAME, found);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_INNER_ERROR("can not parse err_msg config from file[%s], errorCode = %d", configPath, ret);
            return ret;
        }
        if (!found) {
            return ACL_SUCCESS;
        }
        ACL_LOG_INFO("err_msg mode is set [%s].", strConfig.c_str());
        if (strConfig == INTERNAL_MODE) {
            error_mode = error_message::ErrorMessageMode::INTERNAL_MODE;
        } else if (strConfig == PROCESS_MODE) {
            error_mode = error_message::ErrorMessageMode::PROCESS_MODE;
        } else {
            ACL_LOG_INNER_ERROR("err_msg mode config is invalid %s", strConfig.c_str());
            return ACL_ERROR_INVALID_PARAM;
        }
    }
    return ACL_SUCCESS;
}

aclError HandleEventModeConfig(const char_t *const configPath) {
    ACL_LOG_INFO("Start to execute HandleEventModeConfig, configPath:[%s].", configPath);
    std::string strConfig;
    uint8_t event_mode = 0;
    bool found = false;

    auto ret = acl::JsonParser::GetEventModeFromFile(configPath, event_mode, found);
    if (ret != ACL_SUCCESS) {
        ACL_LOG_ERROR("Can not parse event mode config from file[%s], errorCode = %d", configPath, ret);
        return ret;
    }
    if (!found) {
        ACL_LOG_INFO("Event mode config is not found in file[%s].", configPath);
        return ACL_SUCCESS;
    }
    ACL_LOG_INFO("event mode is set [%d].", event_mode);
    ACL_REQUIRES_CALL_RTS_OK(rtEventWorkModeSet(event_mode), rtEventWorkModeSet);
    ACL_LOG_INFO("Successfully handled event mode config.");
    return ACL_SUCCESS;
}

aclError HandleDefaultDeviceAndStackSize(const char_t *const configPath) {
    size_t stackSize = 0;
    bool stackSizeExist = false;
    auto ret = acl::JsonParser::GetStackSize(configPath, stackSize, stackSizeExist);
    if (ret != ACL_SUCCESS) {
        return ACL_ERROR_FAILURE;
    }
    rtError_t rtErr = RT_ERROR_NONE;
    if (stackSizeExist) {
        rtErr = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, static_cast<uint32_t>(stackSize));
        if (rtErr != RT_ERROR_NONE) {
            ACL_LOG_CALL_ERROR("set limit (aicore_stack_size %zu)failed, runtime result = %d.",
                stackSize, static_cast<int32_t>(ret));
            return ACL_GET_ERRCODE_RTS(rtErr);
        }
        ACL_LOG_INFO("get aicore stack size %zu success\n", stackSize);
    }
    int32_t defaultDeviceId = INVALID_DEFAULT_DEVICE;
    ret = acl::JsonParser::GetDefaultDeviceIdFromFile(configPath, defaultDeviceId);
    if (ret != ACL_SUCCESS) {
        return ACL_ERROR_FAILURE;
    }
    if (defaultDeviceId == INVALID_DEFAULT_DEVICE) {
        return ACL_SUCCESS;
    }
    rtErr = rtSetDefaultDeviceId(defaultDeviceId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("set default device id failed, ret:%d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    isEnableDefaultDevice = true;
    ACL_LOG_INFO("set default device %d success\n", defaultDeviceId);
    return ACL_SUCCESS;
}


bool IsEnableAutoUCMemeory()
{
    const char_t *autoUcMemory = nullptr;
    MM_SYS_GET_ENV(MM_ENV_AUTO_USE_UC_MEMORY, autoUcMemory);
    // enable: env does not exist or set to 1
    bool enable = ((autoUcMemory == nullptr) || (strlen(autoUcMemory) == 0UL) || (autoUcMemory[0] == '1'));
    ACL_LOG_INFO("auto-uc-memory is %s.", enable ? "enabled" : "disabled");
    return enable;
}

void GetAllPackageVersion()
{
    for (const auto &pkgName : kMapToPkgName) {
        aclCANNPackageVersion pkgVersion = {};
        auto ret = aclsysGetCANNVersionImpl(pkgName.first, &pkgVersion);
        if (ret == ACL_SUCCESS) {
            ACL_LOG_EVENT("Version of %s package is %s", pkgName.second.c_str(), pkgVersion.version);
        } else {
            ACL_LOG_EVENT("Version of %s package is not found", pkgName.second.c_str());
        }
    }
}
}

aclError aclInitImpl(const char *configPath)
{
    ACL_LOG_INFO("start to execute aclInit");
    const std::unique_lock<std::recursive_mutex> lk(acl::GetAclInitMutex());

    auto &aclInitRefCount = acl::GetAclInitRefCount();
    if (aclInitRefCount > 0) {
        aclInitRefCount++;
        ACL_LOG_INFO("repeatedly initialized, new aclInitRefCount: %lu", aclInitRefCount);
        return ACL_ERROR_REPEAT_INITIALIZE;
    }

    std::string configStr;
    auto ret = acl::GetStrFromConfigPath(configPath, configStr);
    if (ret != ACL_SUCCESS) {
      ACL_LOG_INNER_ERROR("Get Content from configPath failed, ret=%d", ret);
      return ret;
    }
    acl::SetConfigPathStr(configStr);

    // 读取并计算当前文件的哈希值（若文件不存在或无法打开，上面的json_parser中会检验住，此处无须再次判断）
    std::string currentHash;
    acl::hash_utils::CalculateSimpleHash(configPath, configStr, currentHash);
    // 内容不一致
    if (!aclInitJsonHash.empty() && currentHash != aclInitJsonHash) {
        ACL_LOG_ERROR("config content of [%s] differs from the first aclInit config file path: [%s]", configPath, aclInitJsonPath.c_str());
        return ACL_ERROR_INVALID_PARAM;
    }

    error_message::ErrorMessageMode error_mode = error_message::ErrorMessageMode::INTERNAL_MODE;
    ACL_LOG_INFO("call ErrorManager.Initialize");
    ret = acl::HandleErrorManagerConfig(configPath, error_mode);
    if (ret != ACL_SUCCESS) {
        ACL_LOG_INNER_ERROR("[Process][ErrorMsg]process HandleErrorManagerConfig failed, ret=%d", ret);
        return ret;
    }

    int32_t initRet = static_cast<uint32_t>(error_message::ErrMgrInit(error_mode));
    if (initRet != 0) {
        ACL_LOG_WARN("can not init ge errorManager, ge errorCode = %d", initRet);
    }

    if (DlogReportInitialize() != 0) {
        ACL_LOG_WARN("can not init device's log module");
    }

    // init acl_model
    auto cfgStr = configStr.c_str();
    auto cfgLen = configStr.size();
    ret = acl::InitCallbackManager::GetInstance().NotifyInitCallback(ACL_REG_TYPE_ACL_MODEL,
                                                                     cfgStr, cfgLen);
    if (ret != ACL_SUCCESS) {
      ACL_LOG_INNER_ERROR("call acl_model init callback failed, ret:%d", ret);
      return ret;
    }

    if ((configPath != nullptr) && (strlen(configPath) != 0UL)) {
        // config dump
        ACL_LOG_INFO("set DumpConfig in aclInit");
        ret = acl::AclDump::GetInstance().HandleDumpConfig(configPath);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_INNER_ERROR("[Process][DumpConfig]process HandleDumpConfig failed");
            return ret;
        }
        ACL_LOG_INFO("set HandleDumpConfig success in aclInit");

        // init acl_op_executor
        ret = acl::InitCallbackManager::GetInstance().NotifyInitCallback(ACL_REG_TYPE_ACL_OP_EXECUTOR,
                                                                         cfgStr, cfgLen);
        if (ret != ACL_SUCCESS) {
          ACL_LOG_INNER_ERROR("call acl_op_executor init callback failed, ret:%d", ret);
          return ret;
        }

        ACL_LOG_INFO("set HandleDefaultDeviceAndStackSize in aclInit");
        // parse configPath for defaultDevice and call rtSetDefaultDeviced; parse device limit
        ret = acl::HandleDefaultDeviceAndStackSize(configPath);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_INNER_ERROR("[Process][DefaultDevice]process HandleDefaultDevice failed");
            return ret;
        }
        ACL_LOG_INFO("set HandleDefaultDeviceAndStackSize success in aclInit");

        ret = acl::HandleEventModeConfig(configPath);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_INNER_ERROR("[Process][EventMode]process HandleEventModeConfig failed, ret=%d", ret);
            return ret;
        }
    }
    const auto profRet = MsprofRegisterCallback(ASCENDCL, &acl::AclProfCtrlHandle);
    if (profRet != 0) {
        ACL_LOG_WARN("can not register Callback, prof result = %d", profRet);
    }

    // config profiling
    ACL_LOG_INFO("set ProfilingConfig in aclInit");
    ret = acl::AclProfiling::HandleProfilingConfig(configPath);
    if (ret != ACL_SUCCESS) {
        ACL_LOG_INNER_ERROR("[Process][ProfConfig]process HandleProfilingConfig failed");
        return ret;
    }

    // get socVersion
    const char *socName = aclrtGetSocNameImpl();
    if (socName == nullptr) {
        ACL_LOG_INNER_ERROR("[Init][Version]init soc version failed.");
        return ACL_ERROR_INTERNAL_ERROR;
    }

    // init acl dvpp
    ret = acl::InitCallbackManager::GetInstance().NotifyInitCallback(ACL_REG_TYPE_ACL_DVPP,
                                                                     cfgStr, cfgLen);
    if (ret != ACL_SUCCESS) {
        ACL_LOG_INNER_ERROR("call acl_dvpp init callback failed, ret:%d", ret);
        return ret;
    }

    // register kernel launch fill function
    if (acl::IsEnableAutoUCMemeory()) {
        ACL_LOG_INFO("register kernel launch fill function in aclInit");
        auto rtRegErr = rtRegKernelLaunchFillFunc("g_opSystemRunCfg", acl::UpdateOpSystemRunCfg);
        if (rtRegErr != RT_ERROR_NONE) {
            if (rtRegErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
                ACL_LOG_WARN("can not register kernel launch fill function, feature not support.");
            } else {
                ACL_LOG_INNER_ERROR("[Init][RegFillFunc]register failed,ret = %d.", rtRegErr);
                return ACL_GET_ERRCODE_RTS(rtRegErr);
            }
        }
    }

    ret = acl::InitCallbackManager::GetInstance().NotifyInitCallback(ACL_REG_TYPE_OTHER, cfgStr, cfgLen);
    if (ret != ACL_SUCCESS) {
      ACL_LOG_ERROR("[Init][NotifyCallback]notify other init callback failed, ret = %d", ret);
      return ret;
    }

    acl::GetAllPackageVersion();

    aclFinalizeFlag = false;
    aclInitRefCount = 1;
    // 如果 aclJsonHash 为空，说明是第一次调用，设置aclJsonHash
    if (aclInitJsonHash.empty()) {
        aclInitJsonHash = currentHash;
        if (configPath != nullptr) {
            aclInitJsonPath = configPath;
        }
    }
    ACL_LOG_INFO("successfully execute aclInit, aclInitRefCount is %lu",aclInitRefCount);
    return ACL_SUCCESS;
}

aclError aclFinalizeInternal()
{
    ACL_LOG_INFO("start to execute aclFinalizeInternal");

    if (DlogReportFinalize() != 0) {
        ACL_LOG_WARN("can not init device's log module");
    }
    acl::ResourceStatistics::GetInstance().TraverseStatistics();
    const int32_t profRet = MsprofFinalize();
    if (profRet != MSPROF_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("[Finalize][Profiling]failed to call MsprofFinalize, prof errorCode = %d", profRet);
    }

    auto ret = acl::InitCallbackManager::GetInstance().NotifyFinalizeCallback(ACL_REG_TYPE_ACL_OP_COMPILER);
    if (ret != ACL_SUCCESS) {
      ACL_LOG_INNER_ERROR("call acl_op_compiler finalize callback failed, ret:%d", ret);
      return ret;
    }

    ret = acl::InitCallbackManager::GetInstance().NotifyFinalizeCallback(ACL_REG_TYPE_ACL_MODEL);
    if (ret != ACL_SUCCESS) {
      ACL_LOG_INNER_ERROR("call acl_model finalize callback failed, ret:%d", ret);
      return ret;
    }

    if (acl::AclDump::GetInstance().GetAdxInitFromAclInitFlag()) {
        const int32_t adxRet = AdxDataDumpServerUnInit();
        if (adxRet != 0) {
            ACL_LOG_CALL_ERROR("[Generate][DumpFile]generate dump file failed in disk, adx errorCode = %d", adxRet);
            return ACL_ERROR_INTERNAL_ERROR;
        }
    }

    // finalize acl dvpp
    ret = acl::InitCallbackManager::GetInstance().NotifyFinalizeCallback(ACL_REG_TYPE_ACL_DVPP);
    if (ret != ACL_SUCCESS) {
        ACL_LOG_INNER_ERROR("call acl_dvpp finalize callback failed, ret:%d", ret);
        return ret;
    }

    if (acl::IsEnableAutoUCMemeory()) {
        // unregister kernel launch fill function
        ACL_LOG_INFO("unregister kernel launch fill function in aclFinalize");
        auto rtRegErr = rtUnRegKernelLaunchFillFunc("g_opSystemRunCfg");
        if (rtRegErr != RT_ERROR_NONE) {
            if (rtRegErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
                ACL_LOG_WARN("can not unregister kernel launch fill function, feature not support.");
            } else {
                ACL_LOG_INNER_ERROR("Finalize][UnRegFillFunc]unregister failed,ret = %d.", rtRegErr);
                return ACL_GET_ERRCODE_RTS(rtRegErr);
            }
        }
    }

    // disable default device
    if (isEnableDefaultDevice) {
        ACL_LOG_INFO("disable default device");
        const auto rtErr = rtSetDefaultDeviceId(ACL_DEFAULT_DEVICE_DISABLE);
        if (rtErr != RT_ERROR_NONE) {
            ACL_LOG_WARN("close default device failed, ret:%d", rtErr);
            return ACL_GET_ERRCODE_RTS(rtErr);
        }
    }

    ret = acl::InitCallbackManager::GetInstance().NotifyFinalizeCallback(ACL_REG_TYPE_OTHER);
    if (ret != ACL_SUCCESS) {
      ACL_LOG_ERROR("[Init][NotifyCallback]notify other finalize callback failed, ret = %d", ret);
      return ret;
    }

    aclFinalizeFlag = true;
    auto &aclInitRefCount = acl::GetAclInitRefCount();
    aclInitRefCount = 0;
    ACL_LOG_INFO("execute aclFinalizeInternal successfully");
    return ACL_SUCCESS;
}

aclError aclFinalizeImpl()
{
    ACL_LOG_INFO("start to execute aclFinalize");
    const std::unique_lock<std::recursive_mutex> lk(acl::GetAclInitMutex());
    if (aclFinalizeFlag) {
        ACL_LOG_INNER_ERROR("[Finalize][Acl]repeatedly finalized");
        return ACL_ERROR_REPEAT_FINALIZE;
    }

    const aclError ret = aclFinalizeInternal();
    if (ret != ACL_SUCCESS) {
        ACL_LOG_INNER_ERROR("[Finalize][Acl]finalize internal failed, errorCode = %d", ret);
        return ret;
    }
    ACL_LOG_INFO("successfully execute aclFinalize");
    return ACL_SUCCESS;
}

aclError aclFinalizeReferenceImpl(uint64_t *refCount)
{
    ACL_LOG_INFO("start to execute aclFinalizeReference");
    const std::unique_lock<std::recursive_mutex> lk(acl::GetAclInitMutex());
    auto &aclInitRefCount = acl::GetAclInitRefCount();
    if (refCount != nullptr) {
        *refCount = aclInitRefCount;
    }
    // 如果计数器大于1，则减少计数器并返回
    if (aclInitRefCount > 1) {
        aclInitRefCount--;
        if (refCount != nullptr) {
            *refCount = aclInitRefCount;
        }
        ACL_LOG_INFO("Found multiple acl references, reducing aclInitRefCount by 1. New aclInitRefCount: %lu", aclInitRefCount);
        return ACL_SUCCESS;
    }
    // 如果计数器小于1，报错
    if (aclInitRefCount < 1) {
        ACL_LOG_INNER_ERROR("[Finalize][Acl]aclFinalizeReference called repeatedly or called without proper aclInit");
        return ACL_ERROR_REPEAT_FINALIZE;
    }

    // 如果计数器等于1，则执行实际的资源清理操作
    const aclError ret = aclFinalizeInternal();
    if (refCount != nullptr) {
        *refCount = aclInitRefCount;
    }
    if (ret != ACL_SUCCESS) {
        ACL_LOG_INNER_ERROR("[Finalize][Acl]finalize internal failed, errorCode = %d", ret);
        return ret;
    }
    ACL_LOG_INFO("successfully execute aclFinalizeReference");
    return ACL_SUCCESS;
}

bool IsFileExist(const std::string &path)
{
    char_t realPath[MMPA_MAX_PATH] = {};
    return mmRealPath(path.c_str(), realPath, MMPA_MAX_PATH) == EN_OK;
}

bool ParseVersionInfo(const std::string &path, std::string &versionInfo)
{
    std::ifstream ifs(path, std::ifstream::in);
    if (!ifs.is_open()) {
        ACL_LOG_ERROR("[Check]Open file [%s] failed, reason is [%s].", path.c_str(), strerror(errno));
        return false;
    }

    std::string line;
    std::string lineVersion;
    while (std::getline(ifs, line)) {
        const auto &pos = line.find(kVersionInfoKey);
        if (pos != std::string::npos) {
            ACL_LOG_DEBUG("Parse version success, content is [%s].", line.c_str());
            lineVersion = line.substr(pos + strlen(kVersionInfoKey));
            break;
        }
    }
    ifs.close();

    if (!lineVersion.empty()) {
        versionInfo = lineVersion;
        return true;
    }
    return false;
}

bool FillinPackageVersion(const std::string &versionInfo, aclCANNPackageVersion &version)
{
    std::string versionAlternative = ConvertVersion(versionInfo);
    (void)memset_s(&version, sizeof(aclCANNPackageVersion), 0, sizeof(aclCANNPackageVersion));
    std::vector<std::string> parts;
    acl::StringUtils::Split(versionAlternative, '.', parts);
    constexpr uint32_t pkgVersionPartsMinCount = 2;
    constexpr uint32_t pkgVersionPartsMaxCount = 4;

    if (parts.size() < pkgVersionPartsMinCount) {
        return false;
    }

    while (parts.size() < pkgVersionPartsMaxCount) {
        parts.push_back("0");
    }

    if ((versionAlternative.copy(version.version, ACL_PKG_VERSION_MAX_SIZE - 1) > 0) &&
        (parts[0].copy(version.majorVersion, ACL_PKG_VERSION_PARTS_MAX_SIZE - 1) > 0) &&
        (parts[1].copy(version.minorVersion, ACL_PKG_VERSION_PARTS_MAX_SIZE - 1) > 0) &&
        (parts[2].copy(version.releaseVersion, ACL_PKG_VERSION_PARTS_MAX_SIZE - 1) > 0) &&
        (parts[3].copy(version.patchVersion, ACL_PKG_VERSION_PARTS_MAX_SIZE - 1) > 0)) {
        return true;
    }

    return false;
}

bool GetDriverPath(const std::string &ascendInstallPath, std::string &driverPath)
{
    if (!IsFileExist(ascendInstallPath)) {
        ACL_LOG_WARN("[Check]ascendInstallPath [%s] does not exist.", ascendInstallPath.c_str());
        return false;
    }

    std::ifstream ifs(ascendInstallPath, std::ifstream::in);
    if (!ifs.is_open()) {
        ACL_LOG_ERROR("[Check]Open file [%s] failed, reason is [%s].", ascendInstallPath.c_str(), strerror(errno));
        return false;
    }

    driverPath.clear();
    std::string line;
    while (std::getline(ifs, line)) {
        const auto &pos = line.find(kDriverPathKey);
        if (pos == std::string::npos) {
            continue;
        }
        ACL_LOG_DEBUG("Parse driver path success, content is [%s].", line.c_str());
        driverPath = line.substr(pos + strlen(kDriverPathKey));
        if (!driverPath.empty()) {
            ifs.close();
            ACL_LOG_INFO("driver path is [%s].", driverPath.c_str());
            return true;
        }
    }
    ifs.close();
    return false;
}

aclError GetCANNVersionInternal(const aclCANNPackageName name, aclCANNPackageVersion &version,
    const std::string &installPath)
{
    std::string pkgName = kMapToPkgName.at(name);

    std::string versionInfoPath = installPath + "/" + pkgName + "/version.info";
    if (!IsFileExist(versionInfoPath)) {
        ACL_LOG_INFO("[Check]versionInfoPath [%s] does not exist, try use Alternative versionInfoPath.", versionInfoPath.c_str());
        std::string pkgNameAlternative = pkgName;
        if (pkgName.find('-') != std::string::npos) {
            std::replace(pkgNameAlternative.begin(), pkgNameAlternative.end(), '-', '_');
        }
        versionInfoPath = installPath + "/" + pkgNameAlternative + "/version.info";
        ACL_LOG_INFO("[Check]use Alternative versionInfoPath [%s].", versionInfoPath.c_str());
        if (!IsFileExist(versionInfoPath)) {
            ACL_LOG_WARN("[Check]versionInfoPath [%s] does not exist.", versionInfoPath.c_str());
            return ACL_ERROR_INVALID_FILE;
        }
    }

    std::string versionInfo;
    if (!ParseVersionInfo(versionInfoPath, versionInfo)) {
        ACL_LOG_ERROR("[Check]failed to parse versionInfo, the versionInfoPath is [%s].",
            versionInfoPath.c_str());
        return ACL_ERROR_INVALID_FILE;
    }

    ACL_LOG_INFO("versionInfo is [%s].", versionInfo.c_str());
    if (!FillinPackageVersion(versionInfo, version)) {
        ACL_LOG_ERROR("[Check]failed to run FillinPackageVersion.");
        return ACL_ERROR_INVALID_FILE;
    }

    return ACL_SUCCESS;
}

aclError aclsysGetCANNVersionImpl(aclCANNPackageName name, aclCANNPackageVersion *version)
{
    ACL_LOG_INFO("start to execute aclsysGetCANNVersion.");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(version);
    ACL_LOG_INFO("enum name id is [%d], enum name is [%s].", (int32_t)name,
        kMapToPkgName.count(name) ? kMapToPkgName.at(name).c_str() : "unknown" );

    char *pathEnv = nullptr;
    std::string driverPath;
    aclError ret = ACL_SUCCESS;
    switch (name) {
        case ACL_PKG_NAME_CANN:
        case ACL_PKG_NAME_RUNTIME:
        case ACL_PKG_NAME_COMPILER:
        case ACL_PKG_NAME_HCCL:
        case ACL_PKG_NAME_TOOLKIT:
        case ACL_PKG_NAME_OPP:
        case ACL_PKG_NAME_OPP_KERNEL:
            MM_SYS_GET_ENV(MM_ENV_ASCEND_HOME_PATH, pathEnv);
            if (!pathEnv) {
                ACL_LOG_WARN("[Check]can not get env [%s].", kAscendHomeEnvName);
                ret = ACL_ERROR_INVALID_FILE;
                break;
            }
            ACL_LOG_INFO("value of env [%s] is [%s].", kAscendHomeEnvName, pathEnv);
            ret = GetCANNVersionInternal(name, *version, std::string(pathEnv) + "/share/info");
            break;
        case ACL_PKG_NAME_DRIVER:
            if (!GetDriverPath(kAscendInstallPath, driverPath)) {
                ret = ACL_ERROR_INVALID_FILE;
                break;
            }
            ret = GetCANNVersionInternal(name, *version, driverPath);
            break;
        default:
            ACL_LOG_ERROR("[Check]package name enum id [%d] is invalid.", (int32_t)name);
            ret = ACL_ERROR_INVALID_PARAM;
            break;
    }
    return ret;
}

bool GetPkgPath(const std::string &ascendInstallPath, std::string &pkgPath, const std::string &pkgPathKey)
{
    // Get the path of driver or firmware
    if (!IsFileExist(ascendInstallPath)) {
        ACL_LOG_WARN("[Check]ascendInstallPath [%s] does not exist. Please check if ASCEND_HOME_PATH is set.", ascendInstallPath.c_str());
        return false;
    }

    std::ifstream ifs(ascendInstallPath, std::ifstream::in);
    if (!ifs.is_open()) {
        ACL_LOG_ERROR("[Check]Open file [%s] failed, reason is [%s]. Please check if ASCEND_HOME_PATH is set.", ascendInstallPath.c_str(), strerror(errno));
        return false;
    }

    pkgPath.clear();
    std::string line;
    while (std::getline(ifs, line)) {
        const auto pos = line.find(pkgPathKey);
        if (pos == std::string::npos) {
            continue;
        }
        ACL_LOG_DEBUG("Parse path success, key is [%s], content is [%s].", pkgPathKey.c_str(), line.c_str());
        pkgPath = line.substr(pos + pkgPathKey.length());
        if (!pkgPath.empty()) {
            ifs.close();
            ACL_LOG_INFO("pkg path is [%s].", pkgPath.c_str());
            return true;
        }
    }
    ifs.close();
    return false;
}

aclError GetVersionStringInternal(const std::string &fullPath, const char_t *pkgName, std::string &versionOut, bool isSilent = false) {
    std::ifstream ifs(fullPath);
    if (!ifs.is_open()) {
        if (isSilent) {
            ACL_LOG_WARN("Version file not found at [%s] (Silent check, will retry alternative).", fullPath.c_str());
        } else {
            ACL_LOG_ERROR("Version file not found at [%s]. Please check if the package name [%s] is correct and the package is installed.", 
                          fullPath.c_str(), pkgName);
        }
        return ACL_ERROR_INVALID_FILE;
    }

    std::string line;
    bool found = false;
    const size_t keyLen = std::strlen(kVersionInfoKey); 

    while (std::getline(ifs, line)) {
        size_t pos = line.find(kVersionInfoKey);
        if (pos != std::string::npos) {
            versionOut = acl::StringUtils::Trim(line.substr(pos + keyLen));
            found = true;
            break;
        }
    }
    ifs.close();

    if (!found || versionOut.empty()) {
        ACL_LOG_ERROR("Keyword [%s] not found in file [%s].", kVersionInfoKey, fullPath.c_str());
        return ACL_ERROR_INVALID_FILE;
    }

    return ACL_SUCCESS;
}

aclError GetVersionByPkgName(const std::string &targetPkgName, std::string &versionContent, bool isSilent) {
    std::string fullPath;

    // Driver/Firmware
    if (targetPkgName == kDriverPkgName || targetPkgName == kFirmwarePkgName) {
        std::string pkgPath;
        std::string pkgPathKey = (targetPkgName == kDriverPkgName) ? kDriverPathKey : kFirmwarePathKey;
        
        if (!GetPkgPath(kAscendInstallPath, pkgPath, pkgPathKey)) {
            return ACL_ERROR_INVALID_FILE;
        }
        fullPath = pkgPath + "/" + targetPkgName + kInfoFileName;
    } else {
        char *pathEnv = nullptr;
        MM_SYS_GET_ENV(MM_ENV_ASCEND_HOME_PATH, pathEnv);
        if (pathEnv == nullptr) {
            ACL_LOG_WARN("Can not get env [%s]. Please check if ASCEND_HOME_PATH is set.", "ASCEND_HOME_PATH");
            return ACL_ERROR_INVALID_FILE;
        }
        std::string homePath(pathEnv);
        homePath = acl::file_utils::GetLocalRealPath(homePath);
        if(homePath.empty()){
            ACL_LOG_WARN("ASCEND_HOME_PATH [%s] does not exist.", homePath.c_str());
            return ACL_ERROR_INVALID_FILE;    
        }
        fullPath = homePath + kRelPathInfo + targetPkgName + kInfoFileName;
    }

    return GetVersionStringInternal(fullPath, targetPkgName.c_str(), versionContent, isSilent);
}

aclError GetPkgVersionContent(const char *pkgName, std::string &versionContent) {
    std::string originPkgName(pkgName);
    std::string altPkgName = originPkgName;
    bool hasAlternative = false;

    if (originPkgName.find('-') != std::string::npos) {
        std::replace(altPkgName.begin(), altPkgName.end(), '-', '_'); 
        hasAlternative = true;
    } else if (originPkgName.find('_') != std::string::npos) {
        std::replace(altPkgName.begin(), altPkgName.end(), '_', '-');
        hasAlternative = true;
    }

    bool isSilent = hasAlternative;

    aclError ret = GetVersionByPkgName(originPkgName, versionContent, isSilent);
    if (ret == ACL_SUCCESS) {
        return ret;
    }

    if (hasAlternative) {
        ACL_LOG_INFO("Pkg [%s] not found, trying alternative name [%s]...", 
                     originPkgName.c_str(), altPkgName.c_str());
        
        ret = GetVersionByPkgName(altPkgName, versionContent, false);
        if (ret == ACL_SUCCESS) {
            ACL_LOG_INFO("Found version info using alternative name [%s].", altPkgName.c_str());
            return ACL_SUCCESS;
        }
    }

    return ret;
}

aclError aclsysGetVersionStrImpl(char *pkgName, char *versionStr)
{
    ACL_LOG_INFO("start to execute aclsysGetVersionStr.");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(versionStr);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(pkgName);

    std::string verInfo;
    
    aclError ret = GetPkgVersionContent(pkgName, verInfo);
    if (ret != ACL_SUCCESS) {
        return ret;
    }

    if (strcpy_s(versionStr, ACL_PKG_VERSION_MAX_SIZE, verInfo.c_str()) != EOK) {
        ACL_LOG_ERROR("Copy string failed. Dest buffer size is [%d], source len is [%lu].", 
                      ACL_PKG_VERSION_MAX_SIZE, verInfo.length());
        return ACL_ERROR_INTERNAL_ERROR;
    }

    ACL_LOG_INFO("aclsysGetVersionStr success. Pkg:[%s], Ver:[%s]", pkgName, versionStr);
    return ret;
}

// Allowed format: "001", ".1", "-1"
// Not allowed format: "..1", ".", "-a", "a"
bool ParsePreNumStrict(const std::string &suffix, int32_t &outNum) {
    if (suffix.empty()) {
        outNum = 0;
        return true;
    }

    size_t digitPos = std::string::npos;

    // scan characters
    for (size_t i = 0; i < suffix.length(); ++i) {
        char c = suffix[i];
        if (std::isdigit(static_cast<unsigned char>(c))) {
            digitPos = i;
            break;
        } else if (c == '.' || c == '-') {
            continue; // legal character
        } else {
            return false; // illegal character
        }
    }

    // No number found.
    if (digitPos == std::string::npos) {
        return false;
    }

    // Separators more than one.
    if (digitPos > 1) {
        return false; 
    }

    // Analyze prerelease number.
    std::string numStr = suffix.substr(digitPos);
    size_t endPos = 0;
    try {
        outNum = std::stoi(numStr, &endPos);
    } catch (...) {
        return false;
    }

    // Ensure that number does not contain any suffix characters.
    if (endPos != numStr.length()) {
        return false;
    }

    return true;
}

aclError ParseBaseVersion(const std::string &verStr, int32_t &baseVal, size_t &endPos) {
    int major = 0;
    int minor = 0;
    int patch = 0;

    try {
        // Find first point
        size_t dot1 = verStr.find('.');
        if (dot1 == std::string::npos || dot1 == 0) {
            ACL_LOG_ERROR("Invalid format [%s]. Missing major version.", verStr.c_str());
            return ACL_ERROR_INTERNAL_ERROR;
        }

        // Find second point
        size_t dot2 = verStr.find('.', dot1 + 1);
        if (dot2 == std::string::npos || dot2 == dot1 + 1) {
            ACL_LOG_ERROR("Invalid format [%s]. Missing minor version.", verStr.c_str());
            return ACL_ERROR_INTERNAL_ERROR;
        }

        // Find patch number
        size_t numStart = dot2 + 1;
        size_t numEnd = numStart;
        while (numEnd < verStr.length() && std::isdigit(static_cast<unsigned char>(verStr[numEnd]))) {
            numEnd++;
        }

        if (numEnd == numStart) {
            ACL_LOG_ERROR("Invalid format [%s]. Missing patch version.", verStr.c_str());
            return ACL_ERROR_INTERNAL_ERROR;
        }

        major = std::stoi(verStr.substr(0, dot1));
        minor = std::stoi(verStr.substr(dot1 + 1, dot2 - dot1 - 1));
        patch = std::stoi(verStr.substr(numStart, numEnd - numStart));

        endPos = numEnd;
    } catch (...) {
        ACL_LOG_ERROR("Parse base version failed. Contains non-numeric chars?");
        return ACL_ERROR_INTERNAL_ERROR;
    }

    baseVal = major * kWeightMajor + minor * kWeightMinor + patch * kWeightPatch;
    return ACL_SUCCESS;
}

aclError ParsePrereleasePart(const std::string &rawSuffix, int32_t &adjustment) {
    std::string suffix = rawSuffix;
    std::transform(suffix.begin(), suffix.end(), suffix.begin(),
                   [](unsigned char c){ return std::tolower(c); });

    // Match prerelease keyword(alpha:300, beta:200, rc:100)
    int32_t weight = 0;
    size_t keywordLen = 0;
    size_t keywordIndex = std::string::npos;

    if ((keywordIndex = suffix.find(kPreAlpha)) != std::string::npos) {
        weight = kWeightAlpha;
        keywordLen = strlen(kPreAlpha);
    } else if ((keywordIndex = suffix.find(kPreBeta)) != std::string::npos) {
        weight = kWeightBeta;
        keywordLen = strlen(kPreBeta);
    } else if ((keywordIndex = suffix.find(kPreRC)) != std::string::npos) {
        weight = kWeightRC;
        keywordLen = strlen(kPreRC);
    } else {
        ACL_LOG_ERROR("Unknown version suffix in [%s].", rawSuffix.c_str());
        return ACL_ERROR_INTERNAL_ERROR;
    }

    // Verify the separator before the keyword(zero or one separator allowed).
    if (keywordIndex > 1) {
         ACL_LOG_ERROR("Invalid separator format in [%s]. Too many separators before keyword.", rawSuffix.c_str());
         return ACL_ERROR_INTERNAL_ERROR;
    }

    // Obtain the numeric part after the keyword.
    std::string numPart = rawSuffix.substr(keywordIndex + keywordLen);
    int32_t preNum = 0;

    // Strictly verify the format of the numeric part.
    if (!ParsePreNumStrict(numPart, preNum)) {
        ACL_LOG_ERROR("Invalid prerelease number format in [%s].", rawSuffix.c_str());
        return ACL_ERROR_INTERNAL_ERROR;
    }

    // Calculate the final version number: baseValue - weight + preNum
    adjustment = - weight + preNum;
    return ACL_SUCCESS;
}

aclError CalculateVersionNum(const std::string &verStr, int32_t *verNum) {
    int32_t baseValue = 0;
    size_t endPos = 0;

    // Analyze base version (X.Y.Z)
    aclError ret = ParseBaseVersion(verStr, baseValue, endPos);
    if (ret != ACL_SUCCESS) {
        return ret;
    }

    // Check if there is a suffix content.
    if (endPos >= verStr.length()) {
        *verNum = baseValue;
        return ACL_SUCCESS;
    }

    std::string suffixStr = verStr.substr(endPos);
    int32_t adjustment = 0;

    ret = ParsePrereleasePart(suffixStr, adjustment);
    if (ret != ACL_SUCCESS) {
        return ret;
    }

    *verNum = baseValue + adjustment;
    return ACL_SUCCESS;
}

aclError aclsysGetVersionNumImpl(char *pkgName, int32_t *versionNum)
{
    ACL_LOG_INFO("start to execute aclsysGetVersionNum.");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(versionNum);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(pkgName);

    std::string verInfo;

    aclError ret = GetPkgVersionContent(pkgName, verInfo);
    if (ret != ACL_SUCCESS) {
        return ret;
    }

    ret = CalculateVersionNum(verInfo, versionNum);
    if (ret != ACL_SUCCESS) {
        return ret;
    }

    ACL_LOG_INFO("aclsysGetVersionNum success. Pkg:[%s], Num:[%d]", pkgName, *versionNum);
    return ACL_SUCCESS;
}

static std::string GetFaultEventInfo()
{
    std::string faultInfo;

    int32_t deviceId = 0;
    auto ret = rtGetDevice(&deviceId);
    if (ret != RT_ERROR_NONE) {
        ACL_LOG_INFO("can not get device id, runtime errorCode is %d", static_cast<int32_t>(ret));
        return faultInfo;
    }

    rtDmsEventFilter filter = {};
    const uint32_t maxFaultNum = 128UL; // max is 128
    rtDmsFaultEvent faultEventInfo[maxFaultNum] = {};
    uint32_t eventCount = 0UL;
    ret = rtGetFaultEvent(deviceId, &filter, faultEventInfo, maxFaultNum, &eventCount);
    if (ret != RT_ERROR_NONE || eventCount == 0UL) {
        ACL_LOG_INFO("can not get fault event of device %d, runtime errorCode is %d",
            deviceId, static_cast<int32_t>(ret));
        return faultInfo;
    }

    for (uint32_t faultIndex = 0; faultIndex < eventCount; ++faultIndex) {
        std::ostringstream oss;
        oss << std::hex << faultEventInfo[faultIndex].eventId;
        faultInfo = faultInfo + "[0x" + oss.str() + "]"
            + faultEventInfo[faultIndex].eventName + ";";
    }

    if (faultInfo.empty()) {
        return faultInfo;
    }
    faultInfo = "Fault diagnosis analysis: " + faultInfo;
    return faultInfo;
}

const char *aclGetRecentErrMsgImpl()
{
    ACL_LOG_INFO("start to execute aclGetRecentErrMsg.");
    constexpr const rtGetDevMsgType_t msgType = RT_GET_DEV_ERROR_MSG;
    const auto ret = rtGetDevMsg(msgType, &acl::aclGetMsgCallback);
    if (ret != RT_ERROR_NONE) {
        ACL_LOG_DEBUG("can not get device errorMessage, runtime errorCode is %d",
            static_cast<int32_t>(ret));
    }

    const std::string faultEventMsg = GetFaultEventInfo();
    if (!faultEventMsg.empty()) {
        if (aclRecentErrMsg.empty()) {
            aclRecentErrMsg = faultEventMsg;
        } else {
            aclRecentErrMsg = aclRecentErrMsg + "\n" + faultEventMsg;
        }
    }

    const std::string aclHostErrMsg = std::string(error_message::GetErrMgrErrorMessage().get());
    if ((aclHostErrMsg.empty()) && (aclRecentErrMsg.empty())) {
        ACL_LOG_DEBUG("get errorMessage is empty");
        return nullptr;
    }

    if (aclHostErrMsg.empty()) {
        return aclRecentErrMsg.c_str();
    }

    if (aclRecentErrMsg.empty()) {
        (void)aclRecentErrMsg.assign(aclHostErrMsg);
        return aclRecentErrMsg.c_str();
    }

    aclRecentErrMsg = aclHostErrMsg + "\n" + aclRecentErrMsg;
    ACL_LOG_INFO("execute aclGetRecentErrMsg successfully.");
    return aclRecentErrMsg.c_str();
}

aclError aclGetCannAttributeListImpl(const aclCannAttr **cannAttrList, size_t *num)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(cannAttrList);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(num);
    const aclError ret = acl::CannInfoUtils::GetAttributeList(cannAttrList, num);
    if (ret != ACL_SUCCESS) {
        ACL_LOG_ERROR("failed to get attrList, ret = %d", ret);
        return ret;
    }
    ACL_LOG_INFO("execute aclGetCannAttributeList successfully.");
    return ACL_SUCCESS;
}

aclError aclGetCannAttributeImpl(aclCannAttr cannAttr, int32_t *value)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(value);
    const aclError ret = acl::CannInfoUtils::GetAttribute(cannAttr, value);
    if (ret != ACL_SUCCESS) {
        ACL_LOG_ERROR("failed to check, attr value = %d, ret = %d", static_cast<int32_t>(cannAttr), ret);
        return ret;
    }
    ACL_LOG_INFO("execute aclGetCannAttribute successfully.");
    return ACL_SUCCESS;
}

aclError aclGetDeviceCapabilityImpl(uint32_t deviceId, aclDeviceInfo deviceInfo, int64_t *value)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(value);
    int32_t count = -1;
    const rtError_t rtErr = rtGetDeviceCount(&count);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("get device count failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    // currently check only, deviceId with [0, count - 1]
    ACL_CHECK_LESS_UINT(deviceId, static_cast<uint32_t>(count - 1));
    const std::map<aclDeviceInfo, std::string> infoTypeToKey = {
        {ACL_DEVICE_INFO_AI_CORE_NUM, "ai_core_cnt"},
        {ACL_DEVICE_INFO_VECTOR_CORE_NUM, "vector_core_cnt"},
        {ACL_DEVICE_INFO_L2_SIZE, "l2_size"}
    };
    const auto iter = infoTypeToKey.find(deviceInfo);
    if (iter == infoTypeToKey.end()) {
        ACL_LOG_WARN("get device info failed, invalid info type = %d", static_cast<int32_t>(deviceInfo));
        return ACL_ERROR_INVALID_PARAM;
    }
    const auto &key = iter->second;
    const aclError ret = GetPlatformInfoWithKey(key, value);
    if (ret != ACL_SUCCESS) {
        ACL_LOG_ERROR("get device info failed, info type = %d, key = %s", static_cast<int32_t>(deviceInfo), key.c_str());
        return ret;
    }
    ACL_LOG_INFO("execute aclGetDeviceCapability successfully.");
    return ACL_SUCCESS;
}
