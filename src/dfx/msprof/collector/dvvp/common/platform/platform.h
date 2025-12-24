/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_COMMON_PLATFORM_H
#define ANALYSIS_DVVP_COMMON_PLATFORM_H

#include "singleton/singleton.h"
#include "platform_interface.h"
#include "ascend_hal.h"

namespace Analysis {
namespace Dvvp {
namespace Common {
namespace Platform {
using namespace ::Dvvp::Collect::Platform;

constexpr uint16_t QOS_STREAM_MAX_NUM = 20;
const char PROF_VERSION_INFO[] = "1.0";  // version info: Major.Minor
enum SysPlatformType {
    DEVICE = 0,
    HOST = 1,
    INVALID = 2
};
using VOID_PTR = void *;
using HalGetAPIVersionFunc = int32_t (*)(int32_t *);
using DrvGetDeviceSplitModeFunc = int32_t (*)(uint32_t, uint32_t *);
using HalGetDeviceInfoByBuffFunc = int32_t (*) (uint32_t, int32_t, int32_t, VOID_PTR, int32_t*);
using HalEschedQueryInfoFunc = int32_t (*) (uint32_t devId, ESCHED_QUERY_TYPE type,
    struct esched_input_info *inPut, struct esched_output_info *outPut);
using HalEschedCreateGrpExFunc = int32_t (*) (uint32_t devId, struct esched_grp_para *grpPara, uint32_t *grpId);

class AscendHalAdaptor {
public:
    AscendHalAdaptor();
    ~AscendHalAdaptor();
    int32_t Init();
    void LoadApi();
    int32_t HalGetAPIVersion(int32_t *version) const;
    int32_t DrvGetDeviceSplitMode(uint32_t deviceId, uint32_t *mode) const;
    int32_t HalGetDeviceInfoByBuff(uint32_t deviceId, int32_t moduleType,
        int32_t infoType, VOID_PTR data, int32_t* length) const;
    int32_t HalEschedQueryInfo(uint32_t devId, ESCHED_QUERY_TYPE type,
        struct esched_input_info *inPut, struct esched_output_info *outPut) const;
    int32_t HalEschedCreateGrpEx(uint32_t devId, struct esched_grp_para *grpPara, uint32_t *grpId) const;
private:
    void *ascendHalLibHandle_{nullptr};
    HalGetAPIVersionFunc halGetAPIVersion_{nullptr};
    DrvGetDeviceSplitModeFunc drvGetDeviceSplitMode_{nullptr};
    HalGetDeviceInfoByBuffFunc halGetDeviceInfoByBuff_{nullptr};
    HalEschedQueryInfoFunc halEschedQueryInfo_{nullptr};
    HalEschedCreateGrpExFunc halEschedCreateGrpEx_{nullptr};
};

constexpr uint16_t QOS_STREAM_NAME_MAX_LENGTH = 256;
struct QosProfileInfo {
    uint32_t devId;     // hal接口需要的字段
    uint16_t streamNum; // mode: 0时, mpamId列表个数，mode: 1时为mpamIdIdx, 默认0
    uint16_t mode;      // 0: 表示查询mpamId列表，1：通过mpamId查询streamName，2：通过streamName查mpamId
    uint8_t mpamId[QOS_STREAM_MAX_NUM]; // mode: 0/2 为出参， mode: 1 为入参
    char streamName[QOS_STREAM_NAME_MAX_LENGTH]; // mode: 0无效，mode: 1 出参, mode: 2为入参
};

class Platform : public analysis::dvvp::common::singleton::Singleton<Platform> {
public:
    Platform();
    ~Platform() override;

    int32_t Init();
    int32_t Uninit();
    PlatformTypeEnum GetPlatformType() const;
    bool PlatformIsSocSide() const;
    bool PlatformIsRpcSide() const;
    void SetPlatformHelperHostSide();
    void EnableRpcHelper();
    bool PlatformIsNeedHelperServer() const;
    bool CheckIfRpcHelper() const;
    bool PlatformIsHelperHostSide() const;
    bool RunSocSide() const;
    void SetPlatformSoc();
    uint32_t GetPlatform(void) const;
    int32_t PlatformInitByDriver();
    std::string PlatformGetHostOscFreq() const;
    std::string PlatformGetDeviceOscFreq(uint32_t deviceId, const std::string &freq) const;
    bool PlatformHostFreqIsEnable() const;
    int32_t GetAicoreEvents(const std::string &aicoreMetricsType, std::string &aicoreEvents) const;
    int32_t GetDataTypeConfig(uint64_t &supportSwitch);
    bool CheckIfSupport(const PlatformFeature feature) const;
    bool CheckIfSupport(const std::string feature) const;
    void SetSubscribeFeature();
    bool CheckIfPlatformExist() const;
    uint64_t PlatformSysCycleTime() const;
    PlatformFeature PmuToFeature(const std::string &key) const;
    uint32_t DrvGetApiVersion() const;
    bool CheckIfSupportAdprof(uint32_t deviceId) const;
    int32_t HalGetDeviceInfoByBuff(uint32_t deviceId, int32_t moduleType,
        int32_t infoType, VOID_PTR data, int32_t* length) const;
    int32_t HalGetDeviceQosInfo(uint32_t deviceId, QosProfileInfo &info, int32_t* length) const;
    void GetQosProfileInfo(uint32_t deviceId, std::string &qosEventInfo, std::vector<uint8_t> &qosEventId);
    uint16_t GetMaxMonitorNumber() const;
    int32_t InitOnlineAnalyzer();
    uint32_t GetMetricsPmuNum(const std::string &name) const;
    std::string GetMetricsTopName(const std::string &name) const;
    PmuCalculationAttr* GetMetricsFunc(const std::string &name, uint32_t index) const;
    float GetTotalTime(uint64_t cycle, double freq, uint16_t blockDim, int64_t coreNum) const;
    void L2CacheAdaptor(std::string &npuEvents, std::string &l2Switch, std::string &l2Events) const;
    std::string GetL2CacheEvents() const;
    std::string GetSmmuEventStr() const;
    int32_t HalEschedQueryInfo(uint32_t devId, ESCHED_QUERY_TYPE type,
        struct esched_input_info *inPut, struct esched_output_info *outPut) const;
    int32_t HalEschedCreateGrpEx(uint32_t devId, struct esched_grp_para *grpPara, uint32_t *grpId) const;

private:
    uint32_t platformType_;
    uint32_t runSide_;
    bool enableHostOscFreq_;
    std::string hostOscFreq_;
    SHARED_PTR_ALIA<PlatformInterface> platform_;
    bool isHelperHostSide_;
    bool isRpcHelper_;
    AscendHalAdaptor ascendHalAdaptor_;
    std::mutex mtx_;
};
}
}
}
}
#endif

