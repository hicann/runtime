/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef BASIC_HAL_HAL_PROF_H
#define BASIC_HAL_HAL_PROF_H
#include "osal/osal.h"
#include "ascend_hal.h"

#ifdef __cplusplus
extern "C" {
#endif

#define MAX_CHANNEL_NUM  (6)
#define DEFAULT_CHANNEL_POLL_TIMEOUT (1)
#define PROF_CHANNEL_POLL_UNINITIALIZE (-14)

enum AI_DRV_CHANNEL {
    PROF_CHANNEL_UNKNOWN                           = 0,
    PROF_CHANNEL_HBM                               = CHANNEL_HBM,                       // 1
    PROF_CHANNEL_BUS                               = CHANNEL_BUS,                       // 2
    PROF_CHANNEL_PCIE                              = CHANNEL_PCIE,                      // 3
    PROF_CHANNEL_NIC                               = CHANNEL_NIC,                       // 4
    PROF_CHANNEL_DMA                               = CHANNEL_DMA,                       // 5
    PROF_CHANNEL_DVPP                              = CHANNEL_DVPP,                      // 6
    PROF_CHANNEL_DDR                               = CHANNEL_DDR,                       // 7
    PROF_CHANNEL_LLC                               = CHANNEL_LLC,                       // 8
    PROF_CHANNEL_HCCS                              = CHANNEL_HCCS,                      // 9
    PROF_CHANNEL_TS_CPU                            = CHANNEL_TSCPU,                     // 10
    // instr profiling group(0~10) channelId(11~42)
    PROF_CHANNEL_BIU_GROUP0_AIC                    = CHANNEL_BIU_GROUP0_AIC,            // 11
    PROF_CHANNEL_BIU_GROUP0_AIV0                   = CHANNEL_BIU_GROUP0_AIV0,
    PROF_CHANNEL_BIU_GROUP0_AIV1                   = CHANNEL_BIU_GROUP0_AIV1,
    PROF_CHANNEL_BIU_GROUP1_AIC                    = CHANNEL_BIU_GROUP1_AIC,
    PROF_CHANNEL_BIU_GROUP1_AIV0                   = CHANNEL_BIU_GROUP1_AIV0,
    PROF_CHANNEL_BIU_GROUP1_AIV1                   = CHANNEL_BIU_GROUP1_AIV1,
    PROF_CHANNEL_BIU_GROUP2_AIC                    = CHANNEL_BIU_GROUP2_AIC,
    PROF_CHANNEL_BIU_GROUP2_AIV0                   = CHANNEL_BIU_GROUP2_AIV0,
    PROF_CHANNEL_BIU_GROUP2_AIV1                   = CHANNEL_BIU_GROUP2_AIV1,
    PROF_CHANNEL_BIU_GROUP3_AIC                    = CHANNEL_BIU_GROUP3_AIC,
    PROF_CHANNEL_BIU_GROUP3_AIV0                   = CHANNEL_BIU_GROUP3_AIV0,
    PROF_CHANNEL_BIU_GROUP3_AIV1                   = CHANNEL_BIU_GROUP3_AIV1,
    PROF_CHANNEL_BIU_GROUP4_AIC                    = CHANNEL_BIU_GROUP4_AIC,
    PROF_CHANNEL_BIU_GROUP4_AIV0                   = CHANNEL_BIU_GROUP4_AIV0,
    PROF_CHANNEL_BIU_GROUP4_AIV1                   = CHANNEL_BIU_GROUP4_AIV1,
    PROF_CHANNEL_BIU_GROUP5_AIC                    = CHANNEL_BIU_GROUP5_AIC,
    PROF_CHANNEL_BIU_GROUP5_AIV0                   = CHANNEL_BIU_GROUP5_AIV0,
    PROF_CHANNEL_BIU_GROUP5_AIV1                   = CHANNEL_BIU_GROUP5_AIV1,
    PROF_CHANNEL_BIU_GROUP6_AIC                    = CHANNEL_BIU_GROUP6_AIC,
    PROF_CHANNEL_BIU_GROUP6_AIV0                   = CHANNEL_BIU_GROUP6_AIV0,
    PROF_CHANNEL_BIU_GROUP6_AIV1                   = CHANNEL_BIU_GROUP6_AIV1,
    PROF_CHANNEL_BIU_GROUP7_AIC                    = CHANNEL_BIU_GROUP7_AIC,
    PROF_CHANNEL_BIU_GROUP7_AIV0                   = CHANNEL_BIU_GROUP7_AIV0,
    PROF_CHANNEL_BIU_GROUP7_AIV1                   = CHANNEL_BIU_GROUP7_AIV1,
    PROF_CHANNEL_BIU_GROUP8_AIC                    = CHANNEL_BIU_GROUP8_AIC,
    PROF_CHANNEL_BIU_GROUP8_AIV0                   = CHANNEL_BIU_GROUP8_AIV0,
    PROF_CHANNEL_BIU_GROUP8_AIV1                   = CHANNEL_BIU_GROUP8_AIV1,
    PROF_CHANNEL_BIU_GROUP9_AIC                    = CHANNEL_BIU_GROUP9_AIC,
    PROF_CHANNEL_BIU_GROUP9_AIV0                   = CHANNEL_BIU_GROUP9_AIV0,
    PROF_CHANNEL_BIU_GROUP9_AIV1                   = CHANNEL_BIU_GROUP9_AIV1,            // 40
    PROF_CHANNEL_BIU_GROUP10_AIC                   = CHANNEL_BIU_GROUP10_AIC,            // 41
    PROF_CHANNEL_BIU_GROUP10_AIV0                  = CHANNEL_BIU_GROUP10_AIV0,           // 42
    PROF_CHANNEL_AI_CORE                           = CHANNEL_AICORE,                     // 43
    PROF_CHANNEL_TS_FW                             = CHANNEL_TSFW,                       // 44
    PROF_CHANNEL_HWTS_LOG                          = CHANNEL_HWTS_LOG,                   // 45
    PROF_CHANNEL_FMK                               = CHANNEL_KEY_POINT,                  // 46
    PROF_CHANNEL_L2_CACHE                          = CHANNEL_TSFW_L2,                    // 47
    PROF_CHANNEL_AIV_HWTS_LOG                      = CHANNEL_HWTS_LOG1,                  // 48
    PROF_CHANNEL_AIV_TS_FW                         = CHANNEL_TSFW1,                      // 49
    PROF_CHANNEL_STARS_SOC_LOG                     = CHANNEL_STARS_SOC_LOG_BUFFER,       // 50
    PROF_CHANNEL_STARS_BLOCK_LOG                   = CHANNEL_STARS_BLOCK_LOG_BUFFER,     // 51
    PROF_CHANNEL_STARS_SOC_PROFILE                 = CHANNEL_STARS_SOC_PROFILE_BUFFER,   // 52
    PROF_CHANNEL_FFTS_PROFILE_TASK                 = CHANNEL_FFTS_PROFILE_BUFFER_TASK,   // 53
    PROF_CHANNEL_FFTS_PROFILE_SAMPLE               = CHANNEL_FFTS_PROFILE_BUFFER_SAMPLE, // 54
    // instr profiling group(10~20) channelId(55~84)
    PROF_CHANNEL_BIU_GROUP10_AIV1                  = CHANNEL_BIU_GROUP10_AIV1,           // 55
    PROF_CHANNEL_BIU_GROUP11_AIC                   = CHANNEL_BIU_GROUP11_AIC,
    PROF_CHANNEL_BIU_GROUP11_AIV0                  = CHANNEL_BIU_GROUP11_AIV0,
    PROF_CHANNEL_BIU_GROUP11_AIV1                  = CHANNEL_BIU_GROUP11_AIV1,
    PROF_CHANNEL_BIU_GROUP12_AIC                   = CHANNEL_BIU_GROUP12_AIC,
    PROF_CHANNEL_BIU_GROUP12_AIV0                  = CHANNEL_BIU_GROUP12_AIV0,
    PROF_CHANNEL_BIU_GROUP12_AIV1                  = CHANNEL_BIU_GROUP12_AIV1,
    PROF_CHANNEL_BIU_GROUP13_AIC                   = CHANNEL_BIU_GROUP13_AIC,
    PROF_CHANNEL_BIU_GROUP13_AIV0                  = CHANNEL_BIU_GROUP13_AIV0,
    PROF_CHANNEL_BIU_GROUP13_AIV1                  = CHANNEL_BIU_GROUP13_AIV1,
    PROF_CHANNEL_BIU_GROUP14_AIC                   = CHANNEL_BIU_GROUP14_AIC,
    PROF_CHANNEL_BIU_GROUP14_AIV0                  = CHANNEL_BIU_GROUP14_AIV0,
    PROF_CHANNEL_BIU_GROUP14_AIV1                  = CHANNEL_BIU_GROUP14_AIV1,
    PROF_CHANNEL_BIU_GROUP15_AIC                   = CHANNEL_BIU_GROUP15_AIC,
    PROF_CHANNEL_BIU_GROUP15_AIV0                  = CHANNEL_BIU_GROUP15_AIV0,
    PROF_CHANNEL_BIU_GROUP15_AIV1                  = CHANNEL_BIU_GROUP15_AIV1,
    PROF_CHANNEL_BIU_GROUP16_AIC                   = CHANNEL_BIU_GROUP16_AIC,
    PROF_CHANNEL_BIU_GROUP16_AIV0                  = CHANNEL_BIU_GROUP16_AIV0,
    PROF_CHANNEL_BIU_GROUP16_AIV1                  = CHANNEL_BIU_GROUP16_AIV1,
    PROF_CHANNEL_BIU_GROUP17_AIC                   = CHANNEL_BIU_GROUP17_AIC,
    PROF_CHANNEL_BIU_GROUP17_AIV0                  = CHANNEL_BIU_GROUP17_AIV0,
    PROF_CHANNEL_BIU_GROUP17_AIV1                  = CHANNEL_BIU_GROUP17_AIV1,            // 76
    PROF_CHANNEL_BIU_GROUP18_AIC                   = CHANNEL_BIU_GROUP18_AIC,             // 77
    PROF_CHANNEL_BIU_GROUP18_AIV0                  = CHANNEL_BIU_GROUP18_AIV0,
    PROF_CHANNEL_BIU_GROUP18_AIV1                  = CHANNEL_BIU_GROUP18_AIV1,
    PROF_CHANNEL_BIU_GROUP19_AIC                   = CHANNEL_BIU_GROUP19_AIC,
    PROF_CHANNEL_BIU_GROUP19_AIV0                  = CHANNEL_BIU_GROUP19_AIV0,
    PROF_CHANNEL_BIU_GROUP19_AIV1                  = CHANNEL_BIU_GROUP19_AIV1,
    PROF_CHANNEL_BIU_GROUP20_AIC                   = CHANNEL_BIU_GROUP20_AIC,
    PROF_CHANNEL_BIU_GROUP20_AIV0                  = CHANNEL_BIU_GROUP20_AIV0,            // 84
    PROF_CHANNEL_AIV_CORE                          = CHANNEL_AIV,                         // 85
    // instr profiling group(20~24) channelId(86~98)
    PROF_CHANNEL_BIU_GROUP20_AIV1                  = CHANNEL_BIU_GROUP20_AIV1,            // 86
    PROF_CHANNEL_BIU_GROUP21_AIC                   = CHANNEL_BIU_GROUP21_AIC,
    PROF_CHANNEL_BIU_GROUP21_AIV0                  = CHANNEL_BIU_GROUP21_AIV0,
    PROF_CHANNEL_BIU_GROUP21_AIV1                  = CHANNEL_BIU_GROUP21_AIV1,
    PROF_CHANNEL_BIU_GROUP22_AIC                   = CHANNEL_BIU_GROUP22_AIC,
    PROF_CHANNEL_BIU_GROUP22_AIV0                  = CHANNEL_BIU_GROUP22_AIV0,
    PROF_CHANNEL_BIU_GROUP22_AIV1                  = CHANNEL_BIU_GROUP22_AIV1,
    PROF_CHANNEL_BIU_GROUP23_AIC                   = CHANNEL_BIU_GROUP23_AIC,
    PROF_CHANNEL_BIU_GROUP23_AIV0                  = CHANNEL_BIU_GROUP23_AIV0,
    PROF_CHANNEL_BIU_GROUP23_AIV1                  = CHANNEL_BIU_GROUP23_AIV1,
    PROF_CHANNEL_BIU_GROUP24_AIC                   = CHANNEL_BIU_GROUP24_AIC,
    PROF_CHANNEL_BIU_GROUP24_AIV0                  = CHANNEL_BIU_GROUP24_AIV0,
    PROF_CHANNEL_BIU_GROUP24_AIV1                  = CHANNEL_BIU_GROUP24_AIV1,            // 98
    PROF_CHANNEL_ROCE                              = CHANNEL_ROCE,                        // 129
    PROF_CHANNEL_NPU_APP_MEM                       = CHANNEL_NPU_APP_MEM,                 // 130
    PROF_CHANNEL_NPU_MEM                           = CHANNEL_NPU_MEM,                     // 131
    PROF_CHANNEL_LP                                = CHANNEL_LP,                          // 132
    PROF_CHANNEL_DVPP_VENC                         = CHANNEL_DVPP_VENC,                   // 135
    PROF_CHANNEL_DVPP_JPEGE                        = CHANNEL_DVPP_JPEGE,                  // 136
    PROF_CHANNEL_DVPP_VDEC                         = CHANNEL_DVPP_VDEC,                   // 137
    PROF_CHANNEL_DVPP_JPEGD                        = CHANNEL_DVPP_JPEGD,                  // 138
    PROF_CHANNEL_DVPP_VPC                          = CHANNEL_DVPP_VPC,                    // 139
    PROF_CHANNEL_DVPP_PNG                          = CHANNEL_DVPP_PNG,                    // 140
    PROF_CHANNEL_DVPP_SCD                          = CHANNEL_DVPP_SCD,                    // 141
    PROF_CHANNEL_AISTACK_MEM                       = CHANNEL_NPU_MODULE_MEM,              // 142
    PROF_CHANNEL_STARS_NANO_PROFILE                = CHANNEL_STARS_NANO_PROFILE,          // 150
    PROF_CHANNEL_MAX                               = CHANNEL_NUM,                         // 160
};

typedef struct prof_poll_info ChannelPollInfo;
typedef struct prof_start_para ChannelStartPara;
typedef struct channel_list ChannelList;
int32_t HalProfChannelStop(uint32_t deviceId, uint32_t channelId);
int32_t HalProfChannelStart(uint32_t deviceId, uint32_t channelId, ChannelStartPara *para);
int32_t HalProfChannelPoll(ChannelPollInfo *info, uint32_t num, uint32_t timeout);
int32_t HalProfChannelRead(uint32_t deviceId, uint32_t channelId, uint8_t *buffer, uint32_t bufferSize);
int32_t HalProfGetChannelList(uint32_t deviceId, ChannelList *chanList);

#ifdef __cplusplus
}
#endif
#endif