/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_HOST_WRITE_INFO_H
#define ANALYSIS_DVVP_HOST_WRITE_INFO_H

#include <map>
#include <memory>
#include <vector>
#include "ai_drv_dsmi_api.h"
#include "ai_drv_dev_api.h"
#include "utils/utils.h"
namespace analysis {
namespace dvvp {
namespace host {
const char *const PLATFORM_CLOUD = "cloud";
const char INFO_FILE_NAME[] = "info.json";

#define CPU_ID_STR(id_str, begin, num)                                                                              \
    do {                                                                                                            \
        for (unsigned int k = begin; k < num; k++) {                                                                \
            id_str.append((k == static_cast<unsigned int>(begin)) ? std::to_string(k) : ("," + std::to_string(k))); \
        }                                                                                                           \
    } while (0)

struct InfoCpu {
    int32_t id;
    std::string name;
    std::string frequency;
    std::string logicalCpuCount;
    std::string type;
};

struct InfoDeviceInfo {
    int64_t id;
    int64_t envType;
    int64_t ctrlCpuCoreNum;
    int64_t ctrlCpuEndianLittle;
    int64_t tsCpuCoreNum;
    int64_t aiCpuCoreNum;
    int64_t aiCoreNum;
    int64_t aiCpuCoreId;
    int64_t aiCoreId;
    int64_t aiCpuOccupyBitMap;
    int64_t aivNum;
    std::string ctrlCpuId;
    std::string ctrlCpu;
    std::string aiCpu;
    std::string hwtsFrequency;
    std::string aicFrequency;
    std::string aivFrequency;
};

struct NetCardInfo {
    std::string netCardName;
    int32_t speed;
};
struct InfoMain {
    std::string version;
    std::string jobInfo;
    std::string os;
    std::string hostname;
    std::string hwtype;
    std::string devices;
    std::string platform;
    std::string platformVersion;
    std::string pid;
    std::string upTime;
    uint64_t memoryTotal;
    uint32_t cpuNums;
    uint32_t sysClockFreq;
    uint32_t cpuCores;
    uint32_t netCardNums;
    int32_t rankId;
    std::vector<InfoCpu> infoCpus;
    std::vector<InfoDeviceInfo> deviceInfos;
    std::vector<NetCardInfo> netCardInfos;
    uint32_t drvVersion;
};

struct DeviceInfo {
    int64_t envType; /**< 0, FPGA  1, EMU 2, ESL*/
    int64_t ctrlCpuId;
    int64_t ctrlCpuCoreNum;
    int64_t ctrlCpuEndianLittle;
    int64_t tsCpuCoreNum;
    int64_t aiCpuCoreNum;
    int64_t aiCoreNum;
    int64_t aivNum;
    int64_t aiCpuCoreId;
    int64_t aiCoreId;
    int64_t aiCpuOccupyBitMap;
    DeviceInfo()
        : envType(0), ctrlCpuId(0), ctrlCpuCoreNum(0), ctrlCpuEndianLittle(0), tsCpuCoreNum(0), aiCpuCoreNum(0),
          aiCoreNum(0), aivNum(0), aiCpuCoreId(0), aiCoreId(0), aiCpuOccupyBitMap(0)
    {}
};

class InfoJson {
public:
    InfoJson(const std::string &jobInfo, const std::string &devices, int32_t hostpid);
    virtual ~InfoJson();
    int32_t Generate(std::string &content);

private:
    int32_t InitDeviceIds();
    int32_t AddHostInfo(SHARED_PTR_ALIA<InfoMain> infoMain) const;
    int32_t AddDeviceInfo(SHARED_PTR_ALIA<InfoMain> infoMain);
    int32_t AddOtherInfo(SHARED_PTR_ALIA<InfoMain> infoMain);
    int32_t GetCtrlCpuInfo(uint32_t devId, struct DeviceInfo &devInfo) const;
    int32_t GetDevInfo(int32_t deviceId, struct DeviceInfo &devInfo) const;
    void SetPlatFormVersion(SHARED_PTR_ALIA<InfoMain> infoMain) const;
    void SetPidInfo(SHARED_PTR_ALIA<InfoMain> infoMain, int32_t pid) const;
    void AddSysConf(SHARED_PTR_ALIA<InfoMain> infoMain) const;
    void AddSysTime(SHARED_PTR_ALIA<InfoMain> infoMain) const;
    void AddMemTotal(SHARED_PTR_ALIA<InfoMain> infoMain) const;
    void AddNetCardInfo(SHARED_PTR_ALIA<InfoMain> infoMain) const;
    void SetVersionInfo(SHARED_PTR_ALIA<InfoMain> infoMain) const;
    void SetRankId(SHARED_PTR_ALIA<InfoMain> infoMain) const;
    int32_t GetRankId() const;
    std::string GetHostOscFrequency() const;
    std::string GetDeviceOscFrequency(uint32_t deviceId, const std::string &freq) const;
    std::string EncodeInfoMainJson(SHARED_PTR_ALIA<InfoMain> infoMain) const;
    void SetDrvVersion(SHARED_PTR_ALIA<InfoMain> infoMain) const;

private:
    std::string jobInfo_;
    std::string devices_;
    std::vector<int32_t> devIds_;
    std::vector<int32_t> hostIds_;
    std::string hostIdSerial_;
    int32_t hostpid_;
};
}  // namespace host
}  // namespace dvvp
}  // namespace analysis

#endif
