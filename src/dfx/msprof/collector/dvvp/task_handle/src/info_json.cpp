/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "info_json.h"
#include <cstdio>
#include <fstream>
#if (defined(linux) || defined(__linux__))
#include <unistd.h>
#endif
#include "ai_drv_dev_api.h"
#include "config/config.h"
#include "config_manager.h"
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "prof_manager.h"
#include "securec.h"
#include "utils/utils.h"
#include "platform/platform.h"
#include "task_relationship_mgr.h"
#include "json/json.h"

namespace analysis {
namespace dvvp {
namespace host {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Analysis::Dvvp::Common::Config;

const char *const PROF_NET_CARD = "/sys/class/net";
const char *const PROF_PROC_MEM = "/proc/meminfo";
const char *const PROF_PROC_UPTIME = "/proc/uptime";

const char *const PROC_MEM_TOTAL = "MemTotal";
const char *const PROC_NET_SPEED = "speed";

InfoJson::InfoJson(const std::string &jobInfo, const std::string &devices, int32_t hostpid)
    : jobInfo_(jobInfo), devices_(devices), hostpid_(hostpid)
{}

std::string InfoJson::EncodeInfoMainJson(SHARED_PTR_ALIA<InfoMain> infoMain) const
{
    using namespace NanoJson;
    std::string out = "";
    if (infoMain == nullptr) {
        return out;
    }
    size_t deviceInfoSize = infoMain->deviceInfos.size();
    size_t netCardInfoSize = infoMain->netCardInfos.size();
    size_t infoCpuSize = infoMain->infoCpus.size();

    Json infoMainJson;
    infoMainJson["DeviceInfo"].SetArraySize(deviceInfoSize);
    infoMainJson["netCard"].SetArraySize(netCardInfoSize);
    infoMainJson["CPU"].SetArraySize(infoCpuSize);

    for (size_t i = 0; i < deviceInfoSize; ++i) {
        infoMainJson["DeviceInfo"][i]["id"] = infoMain->deviceInfos[i].id;
        infoMainJson["DeviceInfo"][i]["env_type"] = infoMain->deviceInfos[i].envType;
        infoMainJson["DeviceInfo"][i]["ctrl_cpu_core_num"] = infoMain->deviceInfos[i].ctrlCpuCoreNum;
        infoMainJson["DeviceInfo"][i]["ctrl_cpu_endian_little"] = infoMain->deviceInfos[i].ctrlCpuEndianLittle;
        infoMainJson["DeviceInfo"][i]["ts_cpu_core_num"] = infoMain->deviceInfos[i].tsCpuCoreNum;
        infoMainJson["DeviceInfo"][i]["ai_cpu_core_num"] = infoMain->deviceInfos[i].aiCpuCoreNum;
        infoMainJson["DeviceInfo"][i]["ai_core_num"] = infoMain->deviceInfos[i].aiCoreNum;
        infoMainJson["DeviceInfo"][i]["ai_cpu_core_id"] = infoMain->deviceInfos[i].aiCpuCoreId;
        infoMainJson["DeviceInfo"][i]["ai_core_id"] = infoMain->deviceInfos[i].aiCoreId;
        infoMainJson["DeviceInfo"][i]["aicpu_occupy_bitmap"] = infoMain->deviceInfos[i].aiCpuOccupyBitMap;
        infoMainJson["DeviceInfo"][i]["aiv_num"] = infoMain->deviceInfos[i].aivNum;
        infoMainJson["DeviceInfo"][i]["ctrl_cpu_id"] = infoMain->deviceInfos[i].ctrlCpuId;
        infoMainJson["DeviceInfo"][i]["ctrl_cpu"] = infoMain->deviceInfos[i].ctrlCpu;
        infoMainJson["DeviceInfo"][i]["ai_cpu"] = infoMain->deviceInfos[i].aiCpu;
        infoMainJson["DeviceInfo"][i]["hwts_frequency"] = infoMain->deviceInfos[i].hwtsFrequency;
        infoMainJson["DeviceInfo"][i]["aic_frequency"] = infoMain->deviceInfos[i].aicFrequency;
        infoMainJson["DeviceInfo"][i]["aiv_frequency"] = infoMain->deviceInfos[i].aivFrequency;
    }

    for (size_t i = 0; i < netCardInfoSize; ++i) {
        infoMainJson["netCard"][i]["netCardName"] = infoMain->netCardInfos[i].netCardName;
        infoMainJson["netCard"][i]["speed"] = infoMain->netCardInfos[i].speed;
    }

    for (size_t i = 0; i < infoCpuSize; ++i) {
        infoMainJson["CPU"][i]["Id"] = infoMain->infoCpus[i].id;
        infoMainJson["CPU"][i]["Name"] = infoMain->infoCpus[i].name;
        infoMainJson["CPU"][i]["Frequency"] = infoMain->infoCpus[i].frequency;
        infoMainJson["CPU"][i]["Logical_CPU_Count"] = infoMain->infoCpus[i].logicalCpuCount;
        infoMainJson["CPU"][i]["Type"] = infoMain->infoCpus[i].type;
    }

    infoMainJson["version"] = infoMain->version;
    infoMainJson["jobInfo"] = infoMain->jobInfo;
    infoMainJson["OS"] = infoMain->os;
    infoMainJson["hostname"] = infoMain->hostname;
    infoMainJson["hwtype"] = infoMain->hwtype;
    infoMainJson["devices"] = infoMain->devices;
    infoMainJson["platform"] = infoMain->platform;
    infoMainJson["platform_version"] = infoMain->platformVersion;
    infoMainJson["pid"] = infoMain->pid;
    infoMainJson["upTime"] = infoMain->upTime;
    infoMainJson["memoryTotal"] = infoMain->memoryTotal;
    infoMainJson["cpuNums"] = infoMain->cpuNums;
    infoMainJson["sysClockFreq"] = infoMain->sysClockFreq;
    infoMainJson["cpuCores"] = infoMain->cpuCores;
    infoMainJson["netCardNums"] = infoMain->netCardNums;
    infoMainJson["rank_id"] = infoMain->rankId;
    infoMainJson["drvVersion"] = infoMain->drvVersion;

    return infoMainJson.ToString();
}

int32_t InfoJson::Generate(std::string &content)
{
    MSPROF_LOGI("Begin to generate info.json, devices: %s.", devices_.c_str());

    SHARED_PTR_ALIA<InfoMain> infoMain = nullptr;
    MSVP_MAKE_SHARED0(infoMain, InfoMain, return PROFILING_FAILED);

    if (InitDeviceIds() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to init devices of info.json");
        return PROFILING_FAILED;
    }
    SetPidInfo(infoMain, hostpid_);
    SetRankId(infoMain);

    if (AddHostInfo(infoMain) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to add host info to json.info.");
        return PROFILING_FAILED;
    }

    if (AddDeviceInfo(infoMain) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to add device info to json.info.");
        return PROFILING_FAILED;
    }

    if (AddOtherInfo(infoMain) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to add other info to json.info.");
        return PROFILING_FAILED;
    }

    try {
        content = EncodeInfoMainJson(infoMain);
    } catch (const std::runtime_error &error) {
        return PROFILING_FAILED;
    }

    MSPROF_LOGI("End to generate info.json, devices: %s.", devices_.c_str());
    return PROFILING_SUCCESS;
}

int32_t InfoJson::InitDeviceIds()
{
    devIds_.clear();
    hostIds_.clear();
    auto devicesVec = analysis::dvvp::common::utils::Utils::Split(devices_, false, "", ",");
    for (size_t i = 0; i < devicesVec.size(); i++) {
        try {
            int32_t devIndexId = std::stoi(devicesVec.at(i));
            if (devIndexId < 0 || devIndexId >= MSVP_MAX_DEV_NUM) {
                continue;
            }
            devIds_.push_back(devIndexId);
            int32_t hostId = Analysis::Dvvp::TaskHandle::TaskRelationshipMgr::instance()->GetHostIdByDevId(devIndexId);
            hostIds_.push_back(hostId);
            MSPROF_LOGI("Init devices in info.json, devId: %d, hostId: %d", devIndexId, hostId);
        } catch (...) {
            MSPROF_LOGE("Failed to transfer Device(%s) to integer.", devicesVec.at(i).c_str());
            return PROFILING_FAILED;
        }
    }
    analysis::dvvp::common::utils::UtilsStringBuilder<int32_t> intBuilder;
    hostIdSerial_ = intBuilder.Join(hostIds_, ",");
    return PROFILING_SUCCESS;
}

void InfoJson::AddSysConf(SHARED_PTR_ALIA<InfoMain> infoMain) const
{
#if (defined(linux) || defined(__linux__))
    long tck = sysconf(_SC_CLK_TCK);
    FUNRET_CHECK_EXPR_ACTION_LOGW(tck == -1, return, "Unable to get system clock, return code %d.", OsalGetErrorCode());
    infoMain->sysClockFreq = tck;

    long cpu = sysconf(_SC_NPROCESSORS_CONF);
    FUNRET_CHECK_EXPR_ACTION_LOGW(cpu == -1, return, "Unable to get system cpu num, return code %d.",
        OsalGetErrorCode());
    infoMain->cpuNums = cpu;
#endif
}

void InfoJson::AddSysTime(SHARED_PTR_ALIA<InfoMain> infoMain) const
{
#if (defined(linux) || defined(__linux__))
    std::string line;
    std::ifstream fin;

    int64_t len = Utils::GetFileSize(PROF_PROC_UPTIME);
    if (len < 0 || len > MSVP_LARGE_FILE_MAX_LEN) {
        MSPROF_LOGW("[AddSysTime] Proc file(%s) size(%lld)", PROF_PROC_UPTIME, len);
        return;
    }
    fin.open(PROF_PROC_UPTIME, std::ifstream::in);
    FUNRET_CHECK_EXPR_ACTION_LOGW(!fin.is_open(), return, "Unable to open file %s.", PROF_PROC_UPTIME);

    if (std::getline(fin, line)) {
        infoMain->upTime = line;
    }
    fin.close();
#endif
}

void InfoJson::AddMemTotal(SHARED_PTR_ALIA<InfoMain> infoMain) const
{
#if (defined(linux) || defined(__linux__))
    std::string line;
    std::ifstream fin;

    int64_t len = Utils::GetFileSize(PROF_PROC_MEM);
    if (len < 0 || len > MSVP_LARGE_FILE_MAX_LEN) {
        MSPROF_LOGW("[AddMemTotal] Proc file(%s) size(%lld)", PROF_PROC_MEM, len);
        return;
    }
    fin.open(PROF_PROC_MEM, std::ifstream::in);
    FUNRET_CHECK_EXPR_ACTION_LOGW(!fin.is_open(), return, "Unable to open file %s.", PROF_PROC_MEM);

    while (std::getline(fin, line)) {
        if (line.find(PROC_MEM_TOTAL) == std::string::npos) {
            continue;
        }

        unsigned start = 0;
        unsigned end = 0;
        for (unsigned i = 0; i < line.size(); i++) {
            char c = line.at(i);
            if (c >= '0' && c <= '9') {
                start = i;
                break;
            }
        }
        for (unsigned i = line.size() - 1; i > start; i--) {
            char c = line.at(i);
            if (c >= '0' && c <= '9') {
                end = i;
                break;
            }
        }
        FUNRET_CHECK_EXPR_ACTION_LOGW(start == 0 || end == 0, break, "MemTotal %s did not parse successfully.",
            line.c_str());
        std::string result = line.substr(start, end - start + 1);
        if (Utils::IsAllDigit(result)) {
            infoMain->memoryTotal = std::stoull(result);
        }
        break;
    }
    fin.close();
#endif
}

void InfoJson::AddNetCardInfo(SHARED_PTR_ALIA<InfoMain> infoMain) const
{
#if (defined(linux) || defined(__linux__))
    std::string line;
    std::ifstream fin;

    std::vector<std::string> netCards;
    Utils::GetChildFilenames(PROF_NET_CARD, netCards);
    if (netCards.empty()) {
        MSPROF_LOGW("Scandir dir %s, no child dirs.", PROF_NET_CARD);
        return;
    }
    std::vector<std::string>::iterator it;
    for (it = netCards.begin(); it != netCards.end(); it++) {
        std::string srcFile(PROF_NET_CARD);
        srcFile += MSVP_SLASH + *it + MSVP_SLASH + PROC_NET_SPEED;
        int64_t len = Utils::GetFileSize(srcFile);
        if (len < 0 || len > MSVP_LARGE_FILE_MAX_LEN) {
            MSPROF_LOGW("[AddMemTotal] Proc file(%s) size(%lld)", srcFile.c_str(), len);
            continue;
        }
        std::string canonicalizedPath = Utils::CanonicalizePath(srcFile);
        FUNRET_CHECK_EXPR_ACTION_LOGW(canonicalizedPath.empty(), continue,
            "The srcFile: %s does not exist or permission denied.", srcFile.c_str());
        fin.open(canonicalizedPath, std::ifstream::in);
        FUNRET_CHECK_EXPR_ACTION_LOGW(!fin.is_open(), continue, "Unable to open file %s.", canonicalizedPath.c_str());

        if (std::getline(fin, line) && (line.length() > 0 && line[0] != '-') &&
            Utils::CheckStringIsNonNegativeIntNum(line)) {
            int32_t speed = 0;
            FUNRET_CHECK_EXPR_ACTION(!Utils::StrToInt32(speed, line), continue, 
                "line %s is invalid", line.c_str());
            infoMain->netCardInfos.push_back({.netCardName = *it, .speed = speed});
        }
        fin.close();
    }
#endif
}

int32_t InfoJson::GetRankId() const
{
    constexpr int32_t invalidRankId = -1;
    std::string rankIdStr;
    MSPROF_GET_ENV(MM_ENV_RANK_ID, rankIdStr);
    MSPROF_LOGI("Environment variable RANK_ID = %s", rankIdStr.c_str());
    if (!Utils::IsAllDigit(rankIdStr)) {
        return invalidRankId;
    }
    try {
        return std::stoi(rankIdStr);
    } catch (...) {
        MSPROF_LOGE("Failed to transfer rank id to integer.");
        return invalidRankId;
    }
}

void InfoJson::SetRankId(SHARED_PTR_ALIA<InfoMain> infoMain) const
{
    int32_t rankId = GetRankId();
    infoMain->rankId = rankId;
}

int32_t InfoJson::AddHostInfo(SHARED_PTR_ALIA<InfoMain> infoMain) const
{
    // fetch and set OS
    MSPROF_LOGI("Begin to AddHostInfo in info.json, devices: %s.", devices_.c_str());
    char str[OSAL_MAX_PATH] = {0};
    int32_t ret = OsalGetOsVersion(str, OSAL_MAX_PATH);
    FUNRET_CHECK_EXPR_LOGW(ret != OSAL_EN_OK, "OsalGetOsVersion did not execute successfully.");

    std::string os(str);
    infoMain->os = os;

    // fetch and set hostname
    (void)memset_s(str, OSAL_MAX_PATH, 0, OSAL_MAX_PATH);
    ret = OsalGetOsName(str, OSAL_MAX_PATH);
    FUNRET_CHECK_EXPR_LOGW(ret != OSAL_EN_OK, "OsalGetOsName did not execute successfully.");

    std::string hostName(str);
    infoMain->hostname = hostName;

    // fetch and set memory, clock freq, uptime, netcard info, logical cpu nums
    AddMemTotal(infoMain);
    AddSysConf(infoMain);
    AddSysTime(infoMain);
    AddNetCardInfo(infoMain);

    // fetch and set cpu infos
    OsalCpuDesc *cpuInfo = nullptr;
    int32_t cpuNum = 0;
    ret = OsalGetCpuInfo(&cpuInfo, &cpuNum);
    if (ret != OSAL_EN_OK || cpuNum <= 0) {
        MSPROF_LOGE("OsalGetCpuInfo failed");
        return PROFILING_FAILED;
    }
    infoMain->hwtype = cpuInfo[0].arch;
    infoMain->cpuCores = cpuNum;
    for (int32_t i = 0; i < cpuNum; i++) {
        infoMain->infoCpus.push_back({.id = i,
            .name = cpuInfo[i].manufacturer,
            .frequency = GetHostOscFrequency(),
            .logicalCpuCount = std::to_string(cpuInfo[i].nthreads == 0 ? cpuInfo[i].ncounts : cpuInfo[i].nthreads),
            .type = cpuInfo[i].version});
    }
    OsalCpuInfoFree(cpuInfo, cpuNum);
    MSPROF_LOGI("End to AddHostInfo in info.json, devices: %s.", devices_.c_str());
    return PROFILING_SUCCESS;
}

std::string InfoJson::GetHostOscFrequency() const
{
    return Analysis::Dvvp::Common::Platform::Platform::instance()->PlatformGetHostOscFreq();
}

std::string InfoJson::GetDeviceOscFrequency(uint32_t deviceId, const std::string &freq) const
{
    return Analysis::Dvvp::Common::Platform::Platform::instance()->PlatformGetDeviceOscFreq(deviceId, freq);
}

int32_t InfoJson::GetCtrlCpuInfo(uint32_t devId, struct DeviceInfo &devInfo) const
{
    int32_t ret = analysis::dvvp::driver::DrvGetCtrlCpuId(devId, devInfo.ctrlCpuId);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to DrvGetCtrlCpuId, deviceId=%d", devId);
        return PROFILING_FAILED;
    }
    ret = analysis::dvvp::driver::DrvGetCtrlCpuCoreNum(devId, devInfo.ctrlCpuCoreNum);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to DrvGetCtrlCpuCoreNum, deviceId=%d", devId);
        return PROFILING_FAILED;
    }
    ret = analysis::dvvp::driver::DrvGetCtrlCpuEndianLittle(devId, devInfo.ctrlCpuEndianLittle);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to DrvGetCtrlCpuEndianLittle, deviceId=%d", devId);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t InfoJson::GetDevInfo(int32_t deviceId, struct DeviceInfo &devInfo) const
{
    uint32_t devId = static_cast<uint32_t>(deviceId);
    int32_t ret = analysis::dvvp::driver::DrvGetEnvType(devId, devInfo.envType);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to DrvGetEnvType, deviceId=%d", deviceId);
        return PROFILING_FAILED;
    }
    ret = GetCtrlCpuInfo(devId, devInfo);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to GetCtrlCpuInfo, deviceId=%d", deviceId);
        return PROFILING_FAILED;
    }
    ret = analysis::dvvp::driver::DrvGetAiCpuCoreNum(devId, devInfo.aiCpuCoreNum);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to DrvGetAiCpuCoreNum, deviceId=%d", deviceId);
        return PROFILING_FAILED;
    }
    ret = analysis::dvvp::driver::DrvGetAivNum(devId, devInfo.aivNum);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to DrvGetAivNum, deviceId=%d", deviceId);
        return PROFILING_FAILED;
    }
    if (devInfo.aiCpuCoreNum != 0 &&
        analysis::dvvp::driver::DrvGetAiCpuCoreId(devId, devInfo.aiCpuCoreId) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to DrvGetAiCpuCoreId, deviceId=%d", deviceId);
        return PROFILING_FAILED;
    }
    ret = analysis::dvvp::driver::DrvGetAiCpuOccupyBitmap(devId, devInfo.aiCpuOccupyBitMap);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to DrvGetAiCpuOccupyBitmap, deviceId=%d", deviceId);
        return PROFILING_FAILED;
    }
    ret = analysis::dvvp::driver::DrvGetTsCpuCoreNum(devId, devInfo.tsCpuCoreNum);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to DrvGetTsCpuCoreNum, deviceId=%d", deviceId);
        return PROFILING_FAILED;
    }
    ret = analysis::dvvp::driver::DrvGetAiCoreId(devId, devInfo.aiCoreId);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to DrvGetAiCoreId, deviceId=%d", deviceId);
        return PROFILING_FAILED;
    }
    ret = analysis::dvvp::driver::DrvGetAiCoreNum(devId, devInfo.aiCoreNum);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to DrvGetAiCoreNum, deviceId=%d", deviceId);
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("Succeeded to drvGetDevInfo, deviceId=%d", deviceId);
    return PROFILING_SUCCESS;
}

int32_t InfoJson::AddDeviceInfo(SHARED_PTR_ALIA<InfoMain> infoMain)
{
    MSPROF_LOGI("Begin to AddDeviceInfo in info.json, devIds: %s.", devices_.c_str());
    std::vector<int64_t> hostIds;
    for (size_t i = 0; i < hostIds_.size() && i < devIds_.size(); i++) {
        int32_t devIndexId = devIds_.at(i);
        int64_t hostId = hostIds_.at(i);
        hostIds.push_back(hostId);
        struct DeviceInfo devInfo;
        if (GetDevInfo(devIndexId, devInfo) != PROFILING_SUCCESS) {
            MSPROF_LOGE("GetDevInfo Device(%d) failed.", devIndexId);
            return PROFILING_FAILED;
        }

        const std::map<int32_t, std::string> cpuTypes = {{0x41d03, "ARMv8_Cortex_A53"},
            {0x41d05, "ARMv8_Cortex_A55"},
            {0x41d07, "ARMv8_Cortex_A57"},
            {0x41d08, "ARMv8_Cortex_A72"},
            {0x41d09, "ARMv8_Cortex_A73"},
            {0x48d01, "TaishanV110"}};
        auto iterator = cpuTypes.find(devInfo.ctrlCpuId);
        std::string ctrlCpuId = "";
        if (iterator != cpuTypes.end()) {
            ctrlCpuId = iterator->second;
        }

        std::string hwtsFrq =
            GetDeviceOscFrequency(static_cast<uint32_t>(devIndexId), ConfigManager::instance()->GetFrequency());
        MSPROF_LOGD("hwtsFrq:%s", hwtsFrq.c_str());

        std::string ctrlCpu;
        CPU_ID_STR(ctrlCpu, 0, devInfo.ctrlCpuCoreNum);  // ctrl cpu, begin with 0
        std::string aiCpu;
        CPU_ID_STR(aiCpu, devInfo.aiCpuCoreId, (devInfo.ctrlCpuCoreNum + devInfo.aiCpuCoreNum));  // ai cpu
        auto freq = Analysis::Dvvp::Driver::DrvGeAicFrq(devIndexId);  // aic and aiv with the same frequency

        infoMain->deviceInfos.push_back({.id = hostId,
            .envType = devInfo.envType,
            .ctrlCpuCoreNum = devInfo.ctrlCpuCoreNum,
            .ctrlCpuEndianLittle = devInfo.ctrlCpuEndianLittle,
            .tsCpuCoreNum = devInfo.tsCpuCoreNum,
            .aiCpuCoreNum = devInfo.aiCpuCoreNum,
            .aiCoreNum = devInfo.aiCoreNum,
            .aiCpuCoreId = devInfo.aiCpuCoreId,
            .aiCoreId = devInfo.aiCoreId,
            .aiCpuOccupyBitMap = devInfo.aiCpuOccupyBitMap,
            .aivNum = devInfo.aivNum,
            .ctrlCpuId = ctrlCpuId,
            .ctrlCpu = ctrlCpu,
            .aiCpu = aiCpu,
            .hwtsFrequency = hwtsFrq,
            .aicFrequency = freq,
            .aivFrequency = freq});
    }
    infoMain->devices = hostIdSerial_;
    MSPROF_LOGI("End to AddDeviceInfo in info.json, hostIds: %s.", hostIdSerial_.c_str());

    return PROFILING_SUCCESS;
}

int32_t InfoJson::AddOtherInfo(SHARED_PTR_ALIA<InfoMain> infoMain)
{
    if (jobInfo_.empty()) {
        jobInfo_ = "NA";
    }
    infoMain->jobInfo = jobInfo_;
    SetPlatFormVersion(infoMain);
    SetVersionInfo(infoMain);
    SetDrvVersion(infoMain);
    return PROFILING_SUCCESS;
}

void InfoJson::SetPidInfo(SHARED_PTR_ALIA<InfoMain> infoMain, int32_t pid) const
{
    std::string pidtmp;
    if (pid == HOST_PID_DEFAULT) {
        pidtmp = "NA";
    } else {
        pidtmp = std::to_string(pid);
    }
    infoMain->pid = pidtmp;
    return;
}

void InfoJson::SetPlatFormVersion(SHARED_PTR_ALIA<InfoMain> infoMain) const
{
    std::string chipId = Analysis::Dvvp::Common::Config::ConfigManager::instance()->GetChipIdStr();
    infoMain->platformVersion = chipId;
}

void InfoJson::SetVersionInfo(SHARED_PTR_ALIA<InfoMain> infoMain) const
{
    infoMain->version = Analysis::Dvvp::Common::Platform::PROF_VERSION_INFO;
}

void InfoJson::SetDrvVersion(SHARED_PTR_ALIA<InfoMain> infoMain) const
{
    infoMain->drvVersion = Platform::instance()->DrvGetApiVersion();
}

InfoJson::~InfoJson()
{}
}  // namespace host
}  // namespace dvvp
}  // namespace analysis
