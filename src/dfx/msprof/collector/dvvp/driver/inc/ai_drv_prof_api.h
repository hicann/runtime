/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_DEVICE_AI_DRV_API_H
#define ANALYSIS_DVVP_DEVICE_AI_DRV_API_H

#include <vector>
#include <map>
#include <string>
#include "message/prof_params.h"
#include "ascend_hal.h"
#include "utils/utils.h"
#include "singleton/singleton.h"

namespace analysis {
namespace dvvp {
namespace driver {
using namespace analysis::dvvp::common::utils;

enum AI_DRV_CHANNEL {
    PROF_CHANNEL_UNKNOWN = 0,
    PROF_CHANNEL_HBM     = CHANNEL_HBM,   // 1
    PROF_CHANNEL_BUS     = CHANNEL_BUS,   // 2
    PROF_CHANNEL_PCIE    = CHANNEL_PCIE,  // 3
    PROF_CHANNEL_NIC     = CHANNEL_NIC,   // 4
    PROF_CHANNEL_DMA     = CHANNEL_DMA,   // 5
    PROF_CHANNEL_DVPP    = CHANNEL_DVPP,  // 6
    PROF_CHANNEL_DDR     = CHANNEL_DDR,   // 7
    PROF_CHANNEL_LLC     = CHANNEL_LLC,   // 8
    PROF_CHANNEL_HCCS    = CHANNEL_HCCS,  // 9
    PROF_CHANNEL_TS_CPU  = CHANNEL_TSCPU, // 10
    // instr profiling group(0~10) channelId(11~42)
    PROF_CHANNEL_BIU_GROUP0_AIC  = CHANNEL_BIU_GROUP0_AIC, // 11
    PROF_CHANNEL_BIU_GROUP0_AIV0 = CHANNEL_BIU_GROUP0_AIV0,
    PROF_CHANNEL_BIU_GROUP0_AIV1 = CHANNEL_BIU_GROUP0_AIV1,
    PROF_CHANNEL_BIU_GROUP1_AIC  = CHANNEL_BIU_GROUP1_AIC,
    PROF_CHANNEL_BIU_GROUP1_AIV0 = CHANNEL_BIU_GROUP1_AIV0,
    PROF_CHANNEL_BIU_GROUP1_AIV1 = CHANNEL_BIU_GROUP1_AIV1,
    PROF_CHANNEL_BIU_GROUP2_AIC  = CHANNEL_BIU_GROUP2_AIC,
    PROF_CHANNEL_BIU_GROUP2_AIV0 = CHANNEL_BIU_GROUP2_AIV0,
    PROF_CHANNEL_BIU_GROUP2_AIV1 = CHANNEL_BIU_GROUP2_AIV1,
    PROF_CHANNEL_BIU_GROUP3_AIC  = CHANNEL_BIU_GROUP3_AIC,
    PROF_CHANNEL_BIU_GROUP3_AIV0 = CHANNEL_BIU_GROUP3_AIV0,
    PROF_CHANNEL_BIU_GROUP3_AIV1 = CHANNEL_BIU_GROUP3_AIV1,
    PROF_CHANNEL_BIU_GROUP4_AIC  = CHANNEL_BIU_GROUP4_AIC,
    PROF_CHANNEL_BIU_GROUP4_AIV0 = CHANNEL_BIU_GROUP4_AIV0,
    PROF_CHANNEL_BIU_GROUP4_AIV1 = CHANNEL_BIU_GROUP4_AIV1,
    PROF_CHANNEL_BIU_GROUP5_AIC  = CHANNEL_BIU_GROUP5_AIC,
    PROF_CHANNEL_BIU_GROUP5_AIV0 = CHANNEL_BIU_GROUP5_AIV0,
    PROF_CHANNEL_BIU_GROUP5_AIV1 = CHANNEL_BIU_GROUP5_AIV1,
    PROF_CHANNEL_BIU_GROUP6_AIC  = CHANNEL_BIU_GROUP6_AIC,
    PROF_CHANNEL_BIU_GROUP6_AIV0 = CHANNEL_BIU_GROUP6_AIV0,
    PROF_CHANNEL_BIU_GROUP6_AIV1 = CHANNEL_BIU_GROUP6_AIV1,
    PROF_CHANNEL_BIU_GROUP7_AIC  = CHANNEL_BIU_GROUP7_AIC,
    PROF_CHANNEL_BIU_GROUP7_AIV0 = CHANNEL_BIU_GROUP7_AIV0,
    PROF_CHANNEL_BIU_GROUP7_AIV1 = CHANNEL_BIU_GROUP7_AIV1,
    PROF_CHANNEL_BIU_GROUP8_AIC  = CHANNEL_BIU_GROUP8_AIC,
    PROF_CHANNEL_BIU_GROUP8_AIV0 = CHANNEL_BIU_GROUP8_AIV0,
    PROF_CHANNEL_BIU_GROUP8_AIV1 = CHANNEL_BIU_GROUP8_AIV1,
    PROF_CHANNEL_BIU_GROUP9_AIC  = CHANNEL_BIU_GROUP9_AIC,
    PROF_CHANNEL_BIU_GROUP9_AIV0 = CHANNEL_BIU_GROUP9_AIV0,
    PROF_CHANNEL_BIU_GROUP9_AIV1 = CHANNEL_BIU_GROUP9_AIV1,   // 40
    PROF_CHANNEL_BIU_GROUP10_AIC  = CHANNEL_BIU_GROUP10_AIC,  // 41
    PROF_CHANNEL_BIU_GROUP10_AIV0 = CHANNEL_BIU_GROUP10_AIV0, // 42
    PROF_CHANNEL_AI_CORE              = CHANNEL_AICORE,                     // 43
    PROF_CHANNEL_TS_FW                = CHANNEL_TSFW,                       // 44
    PROF_CHANNEL_HWTS_LOG             = CHANNEL_HWTS_LOG,                   // 45
    PROF_CHANNEL_FMK                  = CHANNEL_KEY_POINT,                  // 46
    PROF_CHANNEL_L2_CACHE             = CHANNEL_TSFW_L2,                    // 47
    PROF_CHANNEL_AIV_HWTS_LOG         = CHANNEL_HWTS_LOG1,                  // 48
    PROF_CHANNEL_AIV_TS_FW            = CHANNEL_TSFW1,                      // 49
    PROF_CHANNEL_STARS_SOC_LOG        = CHANNEL_STARS_SOC_LOG_BUFFER,       // 50
    PROF_CHANNEL_STARS_BLOCK_LOG      = CHANNEL_STARS_BLOCK_LOG_BUFFER,     // 51
    PROF_CHANNEL_STARS_SOC_PROFILE    = CHANNEL_STARS_SOC_PROFILE_BUFFER,   // 52
    PROF_CHANNEL_FFTS_PROFILE_TASK    = CHANNEL_FFTS_PROFILE_BUFFER_TASK,   // 53
    PROF_CHANNEL_FFTS_PROFILE_SAMPLE  = CHANNEL_FFTS_PROFILE_BUFFER_SAMPLE, // 54
    // instr profiling group(10~20) channelId(55~84)
    PROF_CHANNEL_BIU_GROUP10_AIV1 = CHANNEL_BIU_GROUP10_AIV1, // 55
    PROF_CHANNEL_BIU_GROUP11_AIC  = CHANNEL_BIU_GROUP11_AIC,
    PROF_CHANNEL_BIU_GROUP11_AIV0 = CHANNEL_BIU_GROUP11_AIV0,
    PROF_CHANNEL_BIU_GROUP11_AIV1 = CHANNEL_BIU_GROUP11_AIV1,
    PROF_CHANNEL_BIU_GROUP12_AIC  = CHANNEL_BIU_GROUP12_AIC,
    PROF_CHANNEL_BIU_GROUP12_AIV0 = CHANNEL_BIU_GROUP12_AIV0,
    PROF_CHANNEL_BIU_GROUP12_AIV1 = CHANNEL_BIU_GROUP12_AIV1,
    PROF_CHANNEL_BIU_GROUP13_AIC  = CHANNEL_BIU_GROUP13_AIC,
    PROF_CHANNEL_BIU_GROUP13_AIV0 = CHANNEL_BIU_GROUP13_AIV0,
    PROF_CHANNEL_BIU_GROUP13_AIV1 = CHANNEL_BIU_GROUP13_AIV1,
    PROF_CHANNEL_BIU_GROUP14_AIC  = CHANNEL_BIU_GROUP14_AIC,
    PROF_CHANNEL_BIU_GROUP14_AIV0 = CHANNEL_BIU_GROUP14_AIV0,
    PROF_CHANNEL_BIU_GROUP14_AIV1 = CHANNEL_BIU_GROUP14_AIV1,
    PROF_CHANNEL_BIU_GROUP15_AIC  = CHANNEL_BIU_GROUP15_AIC,
    PROF_CHANNEL_BIU_GROUP15_AIV0 = CHANNEL_BIU_GROUP15_AIV0,
    PROF_CHANNEL_BIU_GROUP15_AIV1 = CHANNEL_BIU_GROUP15_AIV1,
    PROF_CHANNEL_BIU_GROUP16_AIC  = CHANNEL_BIU_GROUP16_AIC,
    PROF_CHANNEL_BIU_GROUP16_AIV0 = CHANNEL_BIU_GROUP16_AIV0,
    PROF_CHANNEL_BIU_GROUP16_AIV1 = CHANNEL_BIU_GROUP16_AIV1,
    PROF_CHANNEL_BIU_GROUP17_AIC  = CHANNEL_BIU_GROUP17_AIC,
    PROF_CHANNEL_BIU_GROUP17_AIV0 = CHANNEL_BIU_GROUP17_AIV0,
    PROF_CHANNEL_BIU_GROUP17_AIV1 = CHANNEL_BIU_GROUP17_AIV1, // 76
    PROF_CHANNEL_BIU_GROUP18_AIC  = CHANNEL_BIU_GROUP18_AIC,  // 77
    PROF_CHANNEL_BIU_GROUP18_AIV0 = CHANNEL_BIU_GROUP18_AIV0,
    PROF_CHANNEL_BIU_GROUP18_AIV1 = CHANNEL_BIU_GROUP18_AIV1,
    PROF_CHANNEL_BIU_GROUP19_AIC  = CHANNEL_BIU_GROUP19_AIC,
    PROF_CHANNEL_BIU_GROUP19_AIV0 = CHANNEL_BIU_GROUP19_AIV0,
    PROF_CHANNEL_BIU_GROUP19_AIV1 = CHANNEL_BIU_GROUP19_AIV1,
    PROF_CHANNEL_BIU_GROUP20_AIC  = CHANNEL_BIU_GROUP20_AIC,
    PROF_CHANNEL_BIU_GROUP20_AIV0 = CHANNEL_BIU_GROUP20_AIV0,  // 84
    PROF_CHANNEL_AIV_CORE         = CHANNEL_AIV, // 85
    // instr profiling group(20~24) channelId(86~98)
    PROF_CHANNEL_BIU_GROUP20_AIV1 = CHANNEL_BIU_GROUP20_AIV1, // 86
    PROF_CHANNEL_BIU_GROUP21_AIC  = CHANNEL_BIU_GROUP21_AIC,
    PROF_CHANNEL_BIU_GROUP21_AIV0 = CHANNEL_BIU_GROUP21_AIV0,
    PROF_CHANNEL_BIU_GROUP21_AIV1 = CHANNEL_BIU_GROUP21_AIV1,
    PROF_CHANNEL_BIU_GROUP22_AIC  = CHANNEL_BIU_GROUP22_AIC,
    PROF_CHANNEL_BIU_GROUP22_AIV0 = CHANNEL_BIU_GROUP22_AIV0,
    PROF_CHANNEL_BIU_GROUP22_AIV1 = CHANNEL_BIU_GROUP22_AIV1,
    PROF_CHANNEL_BIU_GROUP23_AIC  = CHANNEL_BIU_GROUP23_AIC,
    PROF_CHANNEL_BIU_GROUP23_AIV0 = CHANNEL_BIU_GROUP23_AIV0,
    PROF_CHANNEL_BIU_GROUP23_AIV1 = CHANNEL_BIU_GROUP23_AIV1,
    PROF_CHANNEL_BIU_GROUP24_AIC  = CHANNEL_BIU_GROUP24_AIC,
    PROF_CHANNEL_BIU_GROUP24_AIV0 = CHANNEL_BIU_GROUP24_AIV0,
    PROF_CHANNEL_BIU_GROUP24_AIV1 = CHANNEL_BIU_GROUP24_AIV1, // 98
    PROF_CHANNEL_ROCE        = CHANNEL_ROCE,        // 129
    PROF_CHANNEL_NPU_APP_MEM = CHANNEL_NPU_APP_MEM, // 130
    PROF_CHANNEL_NPU_MEM     = CHANNEL_NPU_MEM,     // 131
    PROF_CHANNEL_LP          = CHANNEL_LP,          // 132
    PROF_CHANNEL_QOS         = CHANNEL_QOS,         // 133
    PROF_CHANNEL_SOC_PMU     = 134,
    PROF_CHANNEL_DVPP_VENC   = CHANNEL_DVPP_VENC,   // 135
    PROF_CHANNEL_DVPP_JPEGE  = CHANNEL_DVPP_JPEGE,  // 136
    PROF_CHANNEL_DVPP_VDEC   = CHANNEL_DVPP_VDEC,   // 137
    PROF_CHANNEL_DVPP_JPEGD  = CHANNEL_DVPP_JPEGD,  // 138
    PROF_CHANNEL_DVPP_VPC    = CHANNEL_DVPP_VPC,    // 139
    PROF_CHANNEL_DVPP_PNG    = CHANNEL_DVPP_PNG,    // 140
    PROF_CHANNEL_DVPP_SCD    = CHANNEL_DVPP_SCD,    // 141
    PROF_CHANNEL_AISTACK_MEM = CHANNEL_NPU_MODULE_MEM,    // 142
    PROF_CHANNEL_AICPU       = CHANNEL_AICPU,       // 143
    PROF_CHANNEL_CUS_AICPU   = CHANNEL_CUS_AICPU,   // 144
    PROF_CHANNEL_ADPROF      = CHANNEL_ADPROF,      // 145
    PROF_CHANNEL_UB = 146,
    PROF_CHANNEL_CCU_INSTR_CCU0 = 147,
    PROF_CHANNEL_CCU_STAT_CCU0,
    PROF_CHANNEL_CCU_INSTR_CCU1,
    PROF_CHANNEL_STARS_NANO_PROFILE     = CHANNEL_STARS_NANO_PROFILE,        // 150
    PROF_CHANNEL_CCU_STAT_CCU1,
    PROF_CHANNEL_MAX                    = CHANNEL_NUM,                       // 160
};

enum PROFILE_MODE {
    PROFILE_REAL_TIME = PROF_REAL,
};

enum TAG_TS_PROF_TYPE {
    TS_PROF_TYPE_TASK_BASE = 0,
    TS_PROF_TYPE_SAMPLE_BASE,
};

enum TAG_FFTS_PROF_TYPE {
    FFTS_PROF_TYPE_TASK_BASE = 0,
    FFTS_PROF_TYPE_SAMPLE_BASE,
    FFTS_PROF_TYPE_BLOCK,
    FFTS_PROF_TYPE_SUBTASK,
    FFTS_PROF_TYPE_BULT,
};

enum TAG_FFTS_PROF_MODE {
    FFTS_PROF_MODE_AIC = 0,
    FFTS_PROF_MODE_AIV,
    FFTS_PROF_MODE_BULT,
};

enum STARS_ACSQ_BITMODE {
    DSA_LOG_EN = 0,
    VDEC_LOG_EN,
    JPEGD_LOG_EN,
    JPEGE_LOG_EN,
    VPC_LOG_EN,
    TOPIC_LOG_EN,
    PCIE_LOG_EN,
    ROCEE_LOG_EN,
    SDMA_LOG_EN,
    CTRL_TASK_LOG_EN,
};

using AI_DRV_CHANNEL_PTR = AI_DRV_CHANNEL *;
using PROF_POLL_INFO_PTR = struct prof_poll_info *;
constexpr uint16_t PMU_EVENT_MAX_NUM = 8;
constexpr uint16_t PMU_EVENT_NOC_MAX_NUM = 4;
constexpr uint16_t ACC_PMU_EVENT_MAX_NUM = 10;
template<typename T>
using TEMPLATE_T_PTR = T *;

using TS_PROFILE_COMMAND_TYPE_T = enum TAG_TS_PROFILE_COMMAND_TYPE {
    TS_PROFILE_COMMAND_TYPE_ACK = 0,
    TS_PROFILE_COMMAND_TYPE_PROFILING_ENABLE = 1,
    TS_PROFILE_COMMAND_TYPE_PROFILING_DISABLE = 2,
    TS_PROFILE_COMMAND_TYPE_BUFFERFULL = 3,
    TS_PROFILE_COMMAND_TASK_BASE_ENABLE = 4,     // task base profiling enable
    TS_PROFILE_COMMAND_TASK_BASE_DISENABLE = 5,  // task base profiling disenable
    TS_PROFILE_COMMAND_TS_FW_ENABLE = 6,         // TS fw data enable
    TS_PROFILE_COMMAND_TS_FW_DISENABLE = 7,      // TS fw data disenable
    TS_PROFILE_COMMAND_TS_FW_MANAGEMENT_ENABLE = 0x81000001,
    TS_PROFILE_COMMAND_TS_FW_AICPU_ENABLE      = 0x82000001,
    TS_PROFILE_COMMAND_TS_FW_MEMCPY_ENABLE     = 0x84000001
};

using TsTsCpuProfileConfigT = struct TagTsTsCpuProfileConfig {
    uint32_t period;
    uint32_t event_num;
    uint32_t event[0];
};

using TsAiCpuProfileConfigT = struct TagTsAiCpuProfileConfig {
    uint32_t period;
    uint32_t event_num;
    uint32_t event[0];
} ;

using TsAiCoreProfileConfigT = struct TagTsAiCoreProfileConfig {
    uint32_t type;                     // 0-task base, 1-sample base
    uint32_t almost_full_threshold;    // sample base
    uint32_t period;                   // sample base
    uint32_t core_mask;                // sample base
    uint32_t event_num;                // public
    uint32_t event[PMU_EVENT_MAX_NUM]; // public
    uint32_t tag;                      // 0-enable immediately, 1-enable delay
};

using TsTsFwProfileConfigT = struct TagTsTsFwProfileConfig {
    uint32_t period;
    uint32_t ts_task_track;     // 1-enable,2-disable
    uint32_t ts_cpu_usage;      // 1-enable,2-disable
    uint32_t ai_core_status;    // 1-enable,2-disable
    uint32_t ts_timeline;       // 1-enable,2-disable
    uint32_t ai_vector_status;  // 1-enable,2-disable
    uint32_t ts_keypoint;       // 1-enable,2-disable
    uint32_t ts_memcpy;         // 1-enable,2-disable
    uint32_t tsBlockdim;       // 1-enable,2-disable
};

using StarsSocLogConfigT = struct TagStarsSocLogConfig {
    uint32_t acsq_task;          // 1-enable,2-disable
    uint32_t accPmu;            // 1-enable,2-disable
    uint32_t cdqm_reg;           // 1-enable,2-disable
    uint32_t dvpp_vpc_block;     // 1-enable,2-disable
    uint32_t dvpp_jpegd_block;   // 1-enable,2-disable
    uint32_t dvpp_jpede_block;   // 1-enable,2-disable
    uint32_t ffts_context_task;  // 1-enable,2-disable
    uint32_t ffts_block;         // 1-enable,2-disable
    uint32_t sdma_dmu;           // 1-enable,2-disable
    uint32_t tag;                // 0-enable immediately, 1-enable delay
    uint32_t blockShinkFlag;     // 1-enable,2-disable
};

using CommonSampleSwitchT = struct TagSocProfileConfig {
    uint32_t innerSwitch;   // 1-enable,2-disable
    uint32_t period;        // ms
};

constexpr uint16_t QOS_STREAM_MAX_NUM = 20;
using QosProfileConfig = struct QosProfileConfig {
    uint32_t period;
    uint16_t streamNum;
    uint16_t res;
    uint8_t mpamId[QOS_STREAM_MAX_NUM];
};

using StarsSocProfileConfigT = struct TagStarsSocProfileConfig {
    CommonSampleSwitchT accPmu;
    CommonSampleSwitchT onChip;
    CommonSampleSwitchT interDie;   // sio_bw
    CommonSampleSwitchT interChip;  // pcie/hccs bw
    CommonSampleSwitchT power;
    CommonSampleSwitchT starsInfo;
    CommonSampleSwitchT ubBw;
};

using StarsSocQosProfileConfigT = struct TagStarsSocQosProfileConfig {
    CommonSampleSwitchT accPmu;
    CommonSampleSwitchT onChip;     // qos
    CommonSampleSwitchT interDie;   // sio_bw
    CommonSampleSwitchT interChip;  // pcie/hccs bw
    CommonSampleSwitchT power;
    CommonSampleSwitchT starsInfo;
    CommonSampleSwitchT ubBw;
    QosProfileConfig    qosConfig;
};

using StarsAiCoreProfileConfigT = struct TagStarsAiCoreConfig {
    uint32_t type;                     // bit0:task base | bit1:sample base | bit2:blk task | bit3:sub task
    uint32_t period;                   // sample base
    uint32_t coreMask;                // sample base
    uint32_t eventNum;                // public
    uint16_t event[PMU_EVENT_MAX_NUM]; // public
};

using FftsProfileConfigT = struct TagFftsProfileConfig {
    uint32_t cfgMode;      // 0-none, 1-aic, 2-aiv, 3-aic&aiv
    StarsAiCoreProfileConfigT aiEventCfg[FFTS_PROF_MODE_BULT];
    uint16_t tag;          // 0-enable immediately, 1-enable delay
    uint16_t aicScale;     // 0-all, 1-partial
};

using AccProfileConfigT = struct TagAccProfileConfig {
    uint32_t type;                         // bit0:task base | bit1:sample base | bit2:blk task | bit3:sub task
    uint32_t period;                       // sample base
    uint32_t coreMask;                     // sample base
    uint32_t eventNum;                     // public
    uint16_t event[ACC_PMU_EVENT_MAX_NUM]; // public
};

using StarsAccProfileConfigT = struct TagStarsAccProfileConfig {
    uint32_t cfgMode;            // 0-none, 1-aic, 2-aiv, 3-aic&aiv
    AccProfileConfigT aiEventCfg[FFTS_PROF_MODE_BULT];
    uint32_t tag;                // 0-enable immediately, 1-enable delay
    uint32_t blockShinkFlag;     // 1-enable, 2-disable
    uint32_t aicScale;           // 0-all, 1-partial
};

using InstrProfileConfigT = struct TagInstrProfileConfig {
    uint32_t period;
    uint32_t biuPcSamplingMode;  // 0: biu instr mode, 1: pc sampling
};

using BiuProfileConfigT = struct TagBiuProfileConfig {
    uint32_t period;
    uint32_t biuPcSamplingMode;  // 0: biu instr mode, 1: pc sampling
    uint32_t groupType;           // 0: aic, 1: aiv0, 2: aiv1
    uint32_t groupNo;             // group number
};

using TsHwtsProfileConfigT = struct TagTsHwtsProfileConfig {
    uint32_t tag; // 0-enable immediately, 1-enable delay
};

struct TagMemProfileConfig {
    uint32_t period;
    uint32_t res1;
    uint32_t event;
    uint32_t res2;
};

struct LpmConvProfileConfig {
    uint32_t period;
    uint32_t version;
};

struct TagDdrProfileConfig {
    uint32_t period;
    uint32_t masterId;  // core_id
    uint32_t eventNum;
    uint32_t event[0];  // read-0,write-1
};

struct TagTsHbmProfileConfig {
    uint32_t period;
    uint32_t masterId;
    uint32_t eventNum;
    uint32_t event[0];
};

/* LLC profile cfg data */
struct TagLlcProfileConfig {
    uint32_t period;      // sample period
    uint32_t sampleType;  // sample data type, 0 read hit rate, 1 write hit rate
};

struct TagTsL2CacheProfileConfig {
    uint32_t eventNum;
    uint32_t event[0];
};

enum class SocPmuTlvType {
    SOC_PMU_PARAM_DESC = 0,
    SOC_PMU_HA_CFG = 1,
    SOC_PMU_SMMU_CFG = 2,
    SOC_PMU_NOC_CFG = 3,
    SOC_PMU_CFG_RESERVE = 4
};

struct SocPmuTlvCfg {
    uint16_t eventType;
    uint16_t eventLen;
};

struct SocPmuConfig {
    uint32_t eventNum;
    uint16_t event[PMU_EVENT_MAX_NUM];
};

struct SocPmuNocConfig {
    uint32_t nocNum;
    uint16_t nocEvent[PMU_EVENT_NOC_MAX_NUM];
};

struct DrvPeripheralProfileCfg {
    DrvPeripheralProfileCfg()
        : startSuccess(false),
          profDeviceId(-1),
          profSamplePeriod(0),
          profSamplePeriodHi(0),
          profChannel(PROF_CHANNEL_UNKNOWN),
          configP(nullptr),
          configSize(0),
          cfgMode(0),
          aicMode(0),
          bufLen(0),
          aivMode(0) {}
    virtual ~DrvPeripheralProfileCfg() {}
    bool startSuccess;
    int32_t profDeviceId;
    int32_t profSamplePeriod;
    int32_t profSamplePeriodHi;
    AI_DRV_CHANNEL profChannel;
    void *configP;
    uint32_t configSize;
    uint32_t cfgMode;
    uint32_t aicMode;
    uint32_t bufLen;
    uint32_t aivMode;
    std::string profDataFilePath;
    std::string profDataFile;
};

int32_t DrvGetChannels(struct DrvProfChannelsInfo &channels);
int32_t DrvPeripheralStart(DrvPeripheralProfileCfg &peripheralCfg);

template<typename T>
int32_t DoProfTsCpuStart(const DrvPeripheralProfileCfg &peripheralCfg,
                     const std::vector<std::string> &profEvents,
                     TEMPLATE_T_PTR<T> configP,
                     uint32_t configSize);

int32_t DrvTscpuStart(const DrvPeripheralProfileCfg &peripheralCfg,
                  const std::vector<std::string> &profEvents);

int32_t DrvAicoreStart(const DrvPeripheralProfileCfg &peripheralCfg,
                   const std::vector<int32_t> &profCores,
                   const std::vector<std::string> &profEvents);

int32_t DrvAicoreTaskBasedStart(int32_t profDeviceId,
    AI_DRV_CHANNEL profChannel, const std::vector<std::string> &profEvents);

int32_t DrvAicpuStart(uint32_t profDeviceId, AI_DRV_CHANNEL profChannel);

int32_t DrvSocPmuTaskStart(int32_t profDeviceId, AI_DRV_CHANNEL profChannel,
    std::string &multiSocPmuEvents);

size_t DrvPackSocPmuSize(const std::string &socPmuEvents);

void DrvCopySocPmuParam(const std::vector<std::string> &eventsList, void *configP, size_t configSize,
    size_t &configPos);
void DrvCopySocPmuNocParam(const std::vector<std::string> &eventsList, void *configP, size_t configSize,
    size_t &configPos);

void DrvCopySocPmuTlv(analysis::dvvp::driver::SocPmuTlvType type, void *configP, size_t configSize,
    size_t &configPos);

void DrvPackSocPmuParam(const std::string &socPmuEvents, void *configP, size_t configSize, size_t &configPos);

int32_t DrvL2CacheTaskStart(int32_t profDeviceId, AI_DRV_CHANNEL profChannel,
    const std::vector<std::string> &profEvents);

int32_t DrvSetTsCommandType(TsTsFwProfileConfigT &configP,
    const SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> profileParams);

int32_t DrvAdprofStart(int32_t profDeviceId, AI_DRV_CHANNEL profChannel);

int32_t DrvTsFwStart(const DrvPeripheralProfileCfg &peripheralCfg,
                 const SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> profileParams);

int32_t DrvStarsSocLogStart(const DrvPeripheralProfileCfg &peripheralCfg,
                        const SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> profileParams);

int32_t DrvFftsProfileStart(const DrvPeripheralProfileCfg &peripheralCfg, const std::vector<int32_t> &aicCores,
                        const std::vector<std::string> &aicEvents, const std::vector<int32_t> &aivCores,
                        const std::vector<std::string> &aivEvents);
int32_t DrvAccProfileStart(DrvPeripheralProfileCfg &peripheralCfg, const std::vector<int32_t> &aicCores,
    const std::vector<std::string> &aicEvents, const std::vector<int32_t> &aivCores,
    const std::vector<std::string> &aivEvents);

int32_t DrvCcuStart(const int32_t deviceId, const AI_DRV_CHANNEL channelId);

int32_t DrvInstrProfileStart(const uint32_t devId, const AI_DRV_CHANNEL channelId, void *userData, size_t dataSize);

int32_t DrvHwtsLogStart(int32_t profDeviceId, AI_DRV_CHANNEL profChannel);

int32_t DrvFmkDataStart(int32_t devId, AI_DRV_CHANNEL profChannel);

int32_t DrvStart(uint32_t profDeviceId, AI_DRV_CHANNEL profChannel, prof_start_para *data);

int32_t DrvStop(int32_t profDeviceId,
            AI_DRV_CHANNEL profChannel);

int32_t DrvChannelRead(int32_t profDeviceId,
                   AI_DRV_CHANNEL profChannel,
                   UNSIGNED_CHAR_PTR outBuf,
                   uint32_t bufSize);

int32_t DrvChannelPoll(PROF_POLL_INFO_PTR outBuf,
                   int32_t num,
                   int32_t timeout);

int32_t DrvProfFlush(uint32_t deviceId, uint32_t channelId, uint32_t &bufSize);

struct DrvProfChannelInfo {
    DrvProfChannelInfo()
        : channelId(PROF_CHANNEL_UNKNOWN),
          channelType(0) {}
    virtual ~DrvProfChannelInfo() {}
    AI_DRV_CHANNEL channelId;
    uint32_t channelType;  /* system or APP */
    std::string channelName;
};

struct DrvProfChannelsInfo {
    DrvProfChannelsInfo()
        : deviceId(-1),
          chipType(0) {}
    virtual ~DrvProfChannelsInfo() {}
    int32_t deviceId;
    uint32_t chipType;
    std::vector<struct DrvProfChannelInfo> channels;
};

class AiDrvProfApi {
public:
    AiDrvProfApi();
    virtual ~AiDrvProfApi();
};

class DrvChannelsMgr : public analysis::dvvp::common::singleton::Singleton<DrvChannelsMgr> {
public:
    DrvChannelsMgr();
    ~DrvChannelsMgr() override;
    int32_t GetAllChannels(int32_t indexId);
    bool ChannelIsValid(int32_t devId, AI_DRV_CHANNEL channelId);

private:
    std::map<int32_t, struct DrvProfChannelsInfo> devIdChannelsMap_;
    std::mutex mtxChannel_;    // mutex for channel mgr
};
}  // namespace driver
}  // namespace dvvp
}  // namespace analysis
#endif
