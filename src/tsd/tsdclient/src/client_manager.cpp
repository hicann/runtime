/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/client_manager.h"
#include "driver/ascend_hal.h"
#include "inc/internal_api.h"
#include "inc/log.h"
#include "inc/process_mode_manager.h"
#include "inc/thread_mode_manager.h"
#include "inc/aicpu_thread_mode_manager.h"
#include "driver/dsmi_common_interface.h"
#include "env_internal_api.h"
namespace tsd {
namespace {
std::mutex g_destructFlagMut;
// runtime的context析构时会调TsdClose接口，此时全局变量对象可能已经析构,所以此处使用指针
std::map<const uint32_t, bool> *g_destructFlagMap = nullptr;

std::mutex g_tsdClientMut;
// tsdClientInstanceMap_中存储的对象是全局的，进程销毁时才销毁
static std::map<const uint32_t, std::shared_ptr<ClientManager>> tsdClientInstanceMap_;
const std::string TSD_VERSION_SO = "/usr/lib64/libtsdversion.so";

static std::map<const uint32_t, uint32_t> *g_userDeviceInfo = nullptr;
bool g_hadGetVisibleDevices = false;

struct PlatformInfo {
    uint32_t onlineStatus;
    ChipType_t chipType;
    bool isAdcEnv;
};
static PlatformInfo g_platInfo;
bool g_hadGetPlatformInfo = false;
const std::string AICPU_PACKAGE_PATTERN = "^Ascend([0-9]{3}(rc)?(P)?)?-aicpu_syskernels\\.tar\\.gz$";
const std::string EXTEND_PACKAGE_PATTERN = "^Ascend([0-9]{3}(rc)?(P)?)?-aicpu_extend_syskernels\\.tar\\.gz$";
const std::string ASCENDCPP_PACKAGE_PATTERN = "^transformer_tile_fwk_aicpu_kernel\\.tar\\.gz$";
}  // namespace

RunningMode ClientManager::g_runningMode = RunningMode::UNSET_MODE;
std::mutex ClientManager::g_profilingCallbackMut;
MsprofReporterCallback ClientManager::g_profilingCallback;
SchedMode ClientManager::aicpuSchedMode_ =  AICPU_SCHED_MODE_INTERRUPT;

bool ClientManager::CheckDestructFlag(const uint32_t &logicDevId)
{
    // logicDevId is actually user device id
    if (!g_hadGetPlatformInfo && (ClientManager::GetPlatformInfo(logicDevId) != TSD_OK)) {
        return false;
    }

    uint32_t logicDeviceId = logicDevId;
    if (IsSupportSetVisibleDevices()) {
        const auto ret = ChangeUserDeviceIdToLogicDeviceId(logicDevId, logicDeviceId);
        if (ret != TSD_OK) {
            return false;
        }
    }

    const std::lock_guard<std::mutex> lk(g_destructFlagMut);
    if (g_destructFlagMap == nullptr) {
        g_destructFlagMap = new (std::nothrow) std::map<const uint32_t, bool>;
        if (g_destructFlagMap == nullptr) {
            TSD_ERROR("[TsdClient] new g_destructFlagMap failed");
            return true;
        }
    }
    const std::map<const uint32_t, bool>::const_iterator iter = g_destructFlagMap->find(logicDeviceId);
    if (iter != g_destructFlagMap->end()) {
        return iter->second;
    } else {
        (void)g_destructFlagMap->insert(std::make_pair(logicDeviceId, false));
        return false;
    }
}

ClientManager::ClientManager(const uint32_t &deviceId)
    : logicDeviceId_(deviceId), initFlag_(false),
      profilingMode_(ProfilingMode::PROFILING_CLOSE)
{
    GetProfilingMode();
    packagePattern_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = AICPU_PACKAGE_PATTERN;
    packagePattern_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)] = EXTEND_PACKAGE_PATTERN;
    packagePattern_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP)] = ASCENDCPP_PACKAGE_PATTERN;
}

ClientManager::~ClientManager()
{
    if (g_destructFlagMap != nullptr) {
        const auto iter = g_destructFlagMap->find(logicDeviceId_);
        if (iter != g_destructFlagMap->end()) {
            iter->second = true;
        } else {
            TSD_INFO("[TsdClient] tsd is not open, deviceId[%u]", logicDeviceId_);
        }
    }
}

TSD_StatusT ClientManager::GetHdcConctStatus(int32_t &hdcSessStat)
{
    hdcSessStat = HDC_SESSION_STATUS_CONNECT;
    return TSD_OK;
}

std::shared_ptr<ClientManager> ClientManager::GetInstance(const uint32_t &deviceId, const uint32_t deviceMode, const bool transDevIdFlag)
{
    if (!g_hadGetPlatformInfo && (ClientManager::GetPlatformInfo(deviceId) != TSD_OK)) {
        return nullptr;
    }
    uint32_t logicDeviceId = deviceId;
    if (IsSupportSetVisibleDevices() && transDevIdFlag) {
        const auto ret = ChangeUserDeviceIdToLogicDeviceId(deviceId, logicDeviceId);
        if (ret != TSD_OK) {
            return nullptr;
        }
    }
    const std::lock_guard<std::mutex> lk(g_tsdClientMut);
    std::shared_ptr<ClientManager> clientManager = nullptr;
    const std::map<const uint32_t, std::shared_ptr<ClientManager>>::const_iterator iter =
    tsdClientInstanceMap_.find(logicDeviceId);
    if (iter != tsdClientInstanceMap_.end()) {
        return iter->second;
    } else {
        TSD_INFO("[ClientManager] GetInstance, deviceId[%u], g_runningMode[%d], begin saving instance", logicDeviceId,
                 g_runningMode);
        const RunningMode curMode = GetClientRunMode(logicDeviceId);
        TSD_RUN_INFO("[ClientManager] Current mode:%u", static_cast<uint32_t>(curMode));
        if (curMode == RunningMode::PROCESS_MODE) {
            clientManager.reset(new(std::nothrow)ProcessModeManager(logicDeviceId, deviceMode));
        } else if (curMode == RunningMode::THREAD_MODE) {
            clientManager.reset(new(std::nothrow)ThreadModeManager(logicDeviceId));
        } else if (curMode == RunningMode::AICPU_THREAD_MODE) {
            clientManager.reset(new(std::nothrow)AicpuThreadModeManager(logicDeviceId, deviceMode));
        } else {
            TSD_ERROR("[TsdClient] current mode is error");
            return nullptr;
        }
        TSD_CHECK((clientManager != nullptr), nullptr, "Fail to create clientManager");
        (void)tsdClientInstanceMap_.insert(std::make_pair(logicDeviceId, clientManager));
    }
    return clientManager;
}

TSD_StatusT ClientManager::GetPlatformInfo(const uint32_t deviceId)
{
    uint32_t mode = 0U;
    drvError_t drvRet = drvGetPlatformInfo(&mode);
    if (drvRet != DRV_ERROR_NONE) {
        TSD_ERROR("get run mode by drvGetPlatformInfo failed, errorCode[%d]", drvRet);
        return TSD_CLT_OPEN_FAILED;
    }
    int64_t hardwareVersion = 0;
    drvRet = halGetDeviceInfo(deviceId, MODULE_TYPE_SYSTEM, INFO_TYPE_VERSION, &hardwareVersion);
    if (drvRet != DRV_ERROR_NONE) {
        TSD_ERROR("get device info by halGetDeviceInfo failed, errorCode[%d] deviceId[%u]", drvRet, deviceId);
        return TSD_CLT_OPEN_FAILED;
    }
    const ChipType_t chipType = static_cast<ChipType_t>(TSD_PLAT_GET_CHIP(static_cast<uint64_t>(hardwareVersion)));
    TSD_INFO("[TsdClient] mode[%u] chipType[%u]",
             static_cast<uint32_t>(mode), static_cast<uint32_t>(chipType));
    g_platInfo.onlineStatus = mode;
    g_platInfo.chipType = chipType;
    if ((chipType == static_cast<uint32_t>(CHIP_ADC)) ||
        (chipType == static_cast<uint32_t>(CHIP_AS31XM1)) ||
        (chipType == static_cast<uint32_t>(CHIP_610LITE)) ||
        (chipType == static_cast<uint32_t>(CHIP_MC62CM12A))) {
        g_platInfo.isAdcEnv = true;
    }
    g_hadGetPlatformInfo = true;
    return TSD_OK;
}

uint32_t ClientManager::GetPlatInfoMode() const
{
    return g_platInfo.onlineStatus;
}

uint32_t ClientManager::GetPlatInfoChipType()
{
    return static_cast<uint32_t>(g_platInfo.chipType);
}

bool ClientManager::IsAdcEnv() const
{
    return g_platInfo.isAdcEnv;
}

void ClientManager::SetPlatInfoMode(const uint32_t platInfoMode) const
{
    g_platInfo.onlineStatus = platInfoMode;
}

void ClientManager::SetProfilingCallback(const MsprofReporterCallback &callback)
{
    const std::lock_guard<std::mutex> lk(g_profilingCallbackMut);
    if (g_profilingCallback == nullptr) {
        TSD_RUN_INFO("[TsdClient] set profiling callback successfully");
    }
    g_profilingCallback = callback;
}

TSD_StatusT ClientManager::SetRunMode(const std::string &valueStr)
{
    g_runningMode = RunningMode::UNSET_MODE;
    if (valueStr == "PROCESS_MODE") {
        g_runningMode = RunningMode::PROCESS_MODE;
    }
    if (valueStr == "THREAD_MODE") {
        g_runningMode = RunningMode::THREAD_MODE;
    }
    TSD_RUN_INFO("[TsdClient] set run mode success. runmode[%u]", g_runningMode);
    return tsd::TSD_OK;
}

TSD_StatusT ClientManager::SetAicpuSchedMode(const uint32_t schedMode)
{
    if (schedMode >= AICPU_SCHED_MODE_INVALID) {
        TSD_RUN_WARN("[TsdClient] Invalid aicpu sched mode use interrupt mode. in=%u, max=%u",
                     schedMode, static_cast<uint32_t>(AICPU_SCHED_MODE_INVALID));
        aicpuSchedMode_ = AICPU_SCHED_MODE_INTERRUPT;
        return tsd::TSD_OK;
    }

    TSD_RUN_INFO("[TsdClient] Set aicpu sched mode to %u.", schedMode);
    aicpuSchedMode_ = static_cast<SchedMode>(schedMode);

    return tsd::TSD_OK;
}

bool ClientManager::CheckPackageExistsOnce(const uint32_t packageType)
{
#ifdef WIN_TSD
    std::string packagePath = "C:\\Program Files\\Huawei\\Ascend\\Aicpu\\aicpu\\";
#else
    std::string packagePath;
    if (!GetPackagePath(packagePath, packageType)) {
        TSD_INFO("[TsdClient][deviceId=%u] Package path is invalid, skip load package file, packageType[%u]",
                 logicDeviceId_, packageType);
        return false;
    }
#endif
    if ((mmAccess(packagePath.c_str()) != EN_OK) || (mmIsDir(packagePath.c_str()) != EN_OK)) {
        TSD_WARN("[TsdClient][deviceId=%u] path[%s] does not exist, packageType[%u]", logicDeviceId_,
                 packagePath.c_str(), packageType);
        return false;
    }
    mmDirent2 **fileList;
    const int32_t fileCount = mmScandir2(packagePath.c_str(), &fileList, nullptr, nullptr);
    if (fileCount < 0) {
        TSD_WARN("[TsdClient][deviceId=%u] scandir path[%s] failed, packageType[%u]", logicDeviceId_,
                 packagePath.c_str(), packageType);
        return false;
    }
    std::vector<std::string> files;
    for (int32_t i = 0; i < fileCount; i++) {
        files.emplace_back(fileList[i]->d_name);
    }
    mmScandirFree2(fileList, fileCount);
    std::vector<std::string> packages;
    for (const std::string &fileName : files) { 
        TSD_INFO("[TsdClient][deviceId=%u] check file[%s], packageType[%u]", logicDeviceId_, fileName.c_str(), packageType);
        // c regex, cannot use c++ regex here which g++ compiler not support
        if (ValidateStr(fileName.c_str(), packagePattern_[packageType].c_str())) {
            TSD_INFO("[TsdClient][deviceId=%u] find package[%s] in path[%s], packageType[%u]", logicDeviceId_, fileName.c_str(),
                     packagePath.c_str(), packageType);
            packages.emplace_back(fileName);
        }
    }
    packageName_[packageType] = "";
    bool needSendPackage = false;
    if (packages.size() != 1U) {
        TSD_RUN_INFO("[TsdClient][deviceId=%u] pkg size[%zu] in path[%s] must be only one, skip send package, packageType[%u]",
                     logicDeviceId_, packages.size(), packagePath.c_str(), packageType);
    } else {
        needSendPackage = true;
        if (!packages.empty()) {
            packageName_[packageType] = packages[0U];
        }
    }
    if (needSendPackage) {
        packagePath_[packageType] = packagePath;
        TSD_RUN_INFO("[TsdClient][deviceId=%u] set package path[%s], package name[%s], packageType[%u]", 
                     logicDeviceId_, packagePath_[static_cast<uint32_t>(packageType)].c_str(),
                     packageName_[packageType].c_str(), packageType);
        return true;
    }

    return false;
}

bool ClientManager::CheckPackageExists(const bool loadAicpuKernelFlag)
{
    bool hasPackage = false;
    std::vector<uint32_t> packageTypes;
    if (loadAicpuKernelFlag) {
        packageTypes.push_back(static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL));
        packageTypes.push_back(static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL));
    }
    packageTypes.push_back(static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP));
    for (const auto packageType : packageTypes) {
        if (CheckPackageExistsOnce(packageType)) {
            TSD_INFO("[TsdClient][deviceId=%u] get package successfully, packageType[%u]", logicDeviceId_, packageType);
            hasPackage = true;
        }
    }

    return hasPackage;
}

bool ClientManager::GetPackagePath(std::string &packagePath, const uint32_t packageType) const
{
    std::string ascendAicpuPath;
    GetEnvFromMmSys(MM_ENV_ASCEND_AICPU_PATH, "ASCEND_AICPU_PATH", ascendAicpuPath);
    if (ascendAicpuPath.empty()) {
        ascendAicpuPath = "/usr/local/Ascend/";
        TSD_INFO("[TsdClient][deviceId=%u] environment variable ASCEND_AICPU_PATH is not set, use default "
                 "value[%s]", logicDeviceId_, ascendAicpuPath.c_str());
    }
    std::string packageTitle = "";
    if (!GetPackageTitle(packageTitle)) {
        TSD_RUN_INFO("[TsdClient][deviceId=%u] skip load aicpu opkernel packages, deviceId[%u] ", logicDeviceId_);
        return false;
    }

    if (packageType == static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL) ||
        packageType == static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)) {
        packagePath = ascendAicpuPath + "/opp/" + packageTitle + "/aicpu/";
    } else if (packageType == static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP)) {
        packagePath = ascendAicpuPath + "/opp/built-in/";
    } else {
        return false;
    }

    TSD_INFO("[TsdClient][deviceId=%u] get packagePath[%s] ", logicDeviceId_, packagePath.c_str());
    return true;
}

bool ClientManager::GetPackageTitle(std::string &packageTitle) const
{
    switch (g_platInfo.chipType) {
        case CHIP_MINI:
            if (g_platInfo.onlineStatus == static_cast<uint32_t>(ModeType::OFFLINE)) {
                packageTitle = "Ascend310RC";
            } else {
                packageTitle = "Ascend310";
            }
            break;
        case CHIP_ASCEND_910A:
            packageTitle = "Ascend910";
            break;
        case CHIP_DC:
            packageTitle = "Ascend310P";
            break;
        case CHIP_ASCEND_950:
        case CHIP_ASCEND_910B:
        case CHIP_CLOUD_V5:
        case CHIP_MINI_V3:
            packageTitle = "Ascend";
            break;
        default:
            packageTitle = "";
            break;
    }
    return !packageTitle.empty();
}

void ClientManager::GetProfilingMode()
{
    profilingMode_ = ProfilingMode::PROFILING_CLOSE;
    std::string isProfiling;
    GetEnvFromMmSys(MM_ENV_AICPU_PROFILING_MODE, "AICPU_PROFILING_MODE", isProfiling);
    TSD_INFO("Get AICPU_PROFILING_MODE[%s]", isProfiling.c_str());
    if (!isProfiling.empty()) {
        if (isProfiling == "true") {
            profilingMode_ = ProfilingMode::PROFILING_OPEN;
        }
    }
}

bool ClientManager::ResetClientManagerByConfig(RunningMode &runningMode)
{
#ifdef WIN_TSD
    return false;
#else
    std::string fileName;
    // read env ASCEND_LATEST_INSTALL_PATH
    const char_t *env = nullptr;
    MM_SYS_GET_ENV(MM_ENV_ASCEND_LATEST_INSTALL_PATH, env);
    if ((env == nullptr) || (*env == '\0')) {
        return false;
    } else {
        const std::string rtCfgFile("/runtime/conf/RuntimeConfig.ini");
        const std::string path(env);
        const std::string rawFileName = path + rtCfgFile;
        std::unique_ptr<char_t []> formatPath(new (std::nothrow) char_t[PATH_MAX]);
        if (formatPath == nullptr) {
            TSD_RUN_WARN("Alloc memory for path failed.");
            return false;
        }

        const auto eRet = memset_s(formatPath.get(), PATH_MAX, 0, PATH_MAX);
        if (eRet != EOK) {
            TSD_RUN_WARN("Mem set error, ret= [%d]", eRet);
            return false;
        }

        if (realpath(rawFileName.data(), formatPath.get()) == nullptr) {
            TSD_INFO("Format to realpath not success, rawFileName is [%s]", rawFileName.c_str());
            return false;
        }
        fileName = std::string(formatPath.get());
    }

    const std::string aicpuSdRunMode("AicpuSdRunMode=");
    int32_t valueRunMode = 0;
    const bool ret = GetConfigIniValueInt32(fileName, aicpuSdRunMode, valueRunMode);
    if (!ret) {
        TSD_RUN_INFO("GetConfigIniValueInt32 false");
        return false;
    }
    TSD_RUN_INFO("cur mode is %d", valueRunMode);
    if (valueRunMode == static_cast<int32_t>(RunningMode::PROCESS_MODE)) {
        TSD_RUN_INFO("set process");
        runningMode = RunningMode::PROCESS_MODE;
        return true;
    } else if (valueRunMode == static_cast<int32_t>(RunningMode::THREAD_MODE)) {
        TSD_RUN_INFO("set thread");
        runningMode = RunningMode::THREAD_MODE;
        return true;
    } else if (valueRunMode == static_cast<int32_t>(RunningMode::AICPU_THREAD_MODE)) {
        uint64_t drvVersion;
        const auto res = GetDriverVersion(&drvVersion);
        if ((res == TSD_OK) && (TSD_BITMAP_GET(drvVersion, 0U) != 0U)) {
            runningMode = RunningMode::AICPU_THREAD_MODE;
        } else {
            runningMode = RunningMode::PROCESS_MODE;
        }
        TSD_RUN_INFO("running mode:%u, drvVersion:%d, drvVersion:%x", static_cast<uint32_t>(runningMode),
                     drvVersion, drvVersion);
        return true;
    } else {
        return false;
    }
#endif
}

RunningMode ClientManager::GetClientRunMode(const uint32_t logicDeviceId)
{
    (void)logicDeviceId;
    if (g_runningMode == RunningMode::UNSET_MODE) {
        RunningMode runningMode = RunningMode::UNSET_MODE;
        if (!ResetClientManagerByConfig(runningMode)) {
            TSD_RUN_INFO("runMode:%u", static_cast<uint32_t>(runningMode));
            if ((g_platInfo.onlineStatus == static_cast<uint32_t>(ModeType::OFFLINE)) && !g_platInfo.isAdcEnv) {
                return RunningMode::THREAD_MODE;
            } else {
                return RunningMode::PROCESS_MODE;
            }
        } else {
            TSD_RUN_INFO("runningMode:%u", static_cast<uint32_t>(runningMode));
            return runningMode;
        }
    } else {
        if (g_runningMode == RunningMode::PROCESS_MODE) {
            return RunningMode::PROCESS_MODE;
        }
        if (g_runningMode == RunningMode::THREAD_MODE) {
            return RunningMode::THREAD_MODE;
        }
    }

    return RunningMode::UNSET_MODE;
}

// just for ut test don't use other place
void ClientManager::SetPlatInfoChipType(const ChipType_t curType)
{
    g_platInfo.chipType = curType;
}

void ClientManager::ResetPlatInfoFlag()
{
    g_hadGetPlatformInfo = false;
}

TSD_StatusT ClientManager::GetDriverVersion(uint64_t *halVersion)
{
    void *handle = dlopen(TSD_VERSION_SO.c_str(),
        ((static_cast<uint32_t>(RTLD_LAZY))|(static_cast<uint32_t>(RTLD_GLOBAL))));
    if (handle == nullptr) {
        TSD_RUN_INFO("not open %s reason:%s", TSD_VERSION_SO.c_str(), dlerror());
        (*halVersion) = 0UL;
        return TSD_NO_VERSION_SO;
    }
    const ScopeGuard closeHandleGuard([&handle]() {
        dlclose(handle);
    });
    using GetVersionFunc = uint64_t (*)();
    const GetVersionFunc tsdVersionFuncPtr = reinterpret_cast<GetVersionFunc>(dlsym(handle, "GetCurTsdVersion"));
    if (tsdVersionFuncPtr == nullptr) {
        TSD_ERROR("dlsym GetCurTsdVersion error:%s", dlerror());
        (*halVersion) = 0UL;
        return TSD_INTERNAL_ERROR;
    }
    (*halVersion) = tsdVersionFuncPtr();
    TSD_RUN_INFO("get version %llu", (*halVersion));
    return TSD_OK;
}

bool ClientManager::IsSupportSetVisibleDevices()
{
    bool flag = false;
    switch (g_platInfo.chipType) {
        case CHIP_ASCEND_910A:
        case CHIP_DC:
        case CHIP_ASCEND_910B:
        case CHIP_MINI_V3:
        case CHIP_ASCEND_950:
        case CHIP_CLOUD_V5:
            flag = true;
            break;
        default:
            flag = false;
            break;
    }
    return flag;
}

bool ClientManager::IsNumeric(const std::string& str) {
    if (str.empty()) {
        return false;
    }
    for (char c : str) {
        if (!isdigit(c)) {
            return false;
        }
    }
    return true;
}

void ClientManager::SplitString(const std::string &str, std::vector<std::string> &result)
{
    size_t start = 0;
    size_t end = str.find(',');

    while (end != std::string::npos) {
        std::string substr = str.substr(start, end - start);
        if (!IsNumeric(substr)) {
            TSD_WARN("[TsdClient] invalid device id [%s]", substr.c_str());
            return;
        }
        result.push_back(substr);
        start = end + 1;
        end = str.find(',', start);
    }

    std::string substr = str.substr(start);
    if (!IsNumeric(substr)) {
        TSD_WARN("[TsdClient] invalid device id [%s]", substr.c_str());
        return;
    }
    result.push_back(substr);
}

bool ClientManager::GetVisibleDevices()
{
    // 标记hadGetVisibleDevices表示即将完成ASCEND_RT_VISIBLE_DEVICES解析
    g_hadGetVisibleDevices = true;
    // 获取并校验ASCEND_RT_VISIBLE_DEVICES环境变量配置
    std::string inputStr;
    GetEnvFromMmSys(MM_ENV_ASCEND_RT_VISIBLE_DEVICES, "ASCEND_RT_VISIBLE_DEVICES", inputStr);
    TSD_INFO("[TsdClient] Get env ASCEND_RT_VISIBLE_DEVICES [%s].", inputStr.c_str());
    // 未设置环境变量和设置为空两种情况都认为是没有设置环境变量
    if (inputStr.empty()) {
        return false;
    }
    std::vector<uint32_t> userDeviceInfo;
    // 配置解析并校验
    uint32_t deviceCnt = 0U;
    const drvError_t drvRet = drvGetDevNum(&deviceCnt);
    if (drvRet != DRV_ERROR_NONE) {
        TSD_ERROR("[TsdClient] get device count failed, errorCode [%d]", drvRet);
        return true;
    }
    std::vector<std::string> splitInputStr;
    SplitString(inputStr, splitInputStr);
    TSD_INFO("[TsdClient] splitInputStr size [%zu]", splitInputStr.size());
    for (uint32_t i = 0U; i < static_cast<uint32_t>(splitInputStr.size()); i++) {
        uint32_t tmpValue = 0U;
        try {
            tmpValue = static_cast<uint32_t>(std::stoi(splitInputStr[i]));
        } catch (std::exception &e) {
            TSD_ERROR("[TsdClient] splitInputStr [%s] is invalid, error: %s", splitInputStr[i].c_str(), e.what());
            break;
        }
        if (tmpValue >= deviceCnt) {
            TSD_WARN("[TsdClient] splitInputStr [%s] is exceed device count [%u]", splitInputStr[i].c_str(), deviceCnt);
            break;
        }
        if (std::find(userDeviceInfo.begin(), userDeviceInfo.end(), tmpValue) != userDeviceInfo.end()) {
            TSD_ERROR("[TsdClient] splitInputStr [%s] is repeat", splitInputStr[i].c_str());
            break;
        }
        userDeviceInfo.push_back(tmpValue);
    }
    TSD_INFO("[TsdClient] userDeviceInfo size [%zu]", userDeviceInfo.size());
    if (g_userDeviceInfo == nullptr) {
        g_userDeviceInfo = new (std::nothrow) std::map<const uint32_t, uint32_t>;
        TSD_CHECK((g_userDeviceInfo != nullptr), true, "[TsdClient] new g_userDeviceInfo failed.");
    }
    for (uint32_t i = 0U; i < userDeviceInfo.size(); i++) {
        (void)g_userDeviceInfo->insert(std::make_pair(i, userDeviceInfo[i]));
    }
    return true;
}

TSD_StatusT ClientManager::ChangeUserDeviceIdToLogicDeviceId(const uint32_t userDevId, uint32_t &logicDevId)
{
    if (!g_hadGetVisibleDevices && !GetVisibleDevices()) {
        return TSD_OK;
    }

    // user device id匹配logic id
    if (g_userDeviceInfo == nullptr || g_userDeviceInfo->empty()) {
        return TSD_OK;
    }
    const std::map<const uint32_t, uint32_t>::const_iterator iter = g_userDeviceInfo->find(userDevId);
    if (iter != g_userDeviceInfo->end()) {
        logicDevId = iter->second;
        TSD_INFO("[TsdClient] change userDevId [%u] to logicDevId [%u]", userDevId, logicDevId);
        return TSD_OK;
    } else {
        TSD_ERROR("[TsdClient] userDevId [%u] is exceed g_userDeviceInfo size [%zu]", userDevId, g_userDeviceInfo->size());
        return TSD_PARAMETER_INVALID;
    }
}
}  // namespace tsd
