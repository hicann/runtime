/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "config.hpp"
#include <cstdlib>
#include "error_message_manage.hpp"
#include "config_define_mini.hpp"
#include "config_define_adc.hpp"
#include "config_define.hpp"

namespace cce {
namespace runtime {
HardWareConfig Config::hardWareConfig_[PLATFORM_END];

Config::Config()
{
    (void)InitHardwareInfo();
}

Config::~Config()
{
}

static const std::unordered_map<uint32_t, uint32_t> archVersionMap_ = {
    {PLATFORMCONFIG_MINI_V2_OLD, PLATFORMCONFIG_MINI_V2},
    {PLATFORMCONFIG_MINI_V3_OLD, PLATFORMCONFIG_MINI_V3},
    {PLATFORMCONFIG_MINI_V3_BIN1_OLD, PLATFORMCONFIG_MINI_V3_BIN1},
    {PLATFORMCONFIG_MINI_V3_BIN2_OLD, PLATFORMCONFIG_MINI_V3_BIN2},
    {PLATFORMCONFIG_MINI_V3_BIN3_OLD, PLATFORMCONFIG_MINI_V3_BIN3},
    {PLATFORMCONFIG_MINI_V3_BIN4_OLD, PLATFORMCONFIG_MINI_V3_BIN4},
    {PLATFORMCONFIG_ADC_LITE_OLD, PLATFORMCONFIG_ADC_LITE},
    {PLATFORMCONFIG_DC_OLD, PLATFORMCONFIG_DC},
    {PLATFORMCONFIG_CLOUD_V2_OLD, PLATFORMCONFIG_CLOUD_V2},
    {PLATFORMCONFIG_CLOUD_V2_910B1_OLD, PLATFORMCONFIG_CLOUD_V2_910B1},
    {PLATFORMCONFIG_CLOUD_V2_910B2_OLD, PLATFORMCONFIG_CLOUD_V2_910B2},
    {PLATFORMCONFIG_CLOUD_V2_910B3_OLD, PLATFORMCONFIG_CLOUD_V2_910B3},
    {PLATFORMCONFIG_BS9SX1A_OLD, PLATFORMCONFIG_BS9SX1A},
    {PLATFORMCONFIG_AS31XM1X_OLD, PLATFORMCONFIG_AS31XM1X},
    {PLATFORMCONFIG_CLOUD_V2_910B4_1_OLD, PLATFORMCONFIG_CLOUD_V2_910B4_1},
};

const std::unordered_map<uint32_t, uint32_t> platformConfigMap = {
    {static_cast<uint32_t>(PLATFORM_DAVID_950PR_9599), PLATFORMCONFIG_DAVID_950PR_9599},
    {static_cast<uint32_t>(PLATFORM_DAVID_950PR_9589), PLATFORMCONFIG_DAVID_950PR_9589},
    {static_cast<uint32_t>(PLATFORM_DAVID_950PR_958A), PLATFORMCONFIG_DAVID_950PR_958A},
    {static_cast<uint32_t>(PLATFORM_DAVID_950PR_958B), PLATFORMCONFIG_DAVID_950PR_958B},
    {static_cast<uint32_t>(PLATFORM_DAVID_950PR_957B), PLATFORMCONFIG_DAVID_950PR_957B},
    {static_cast<uint32_t>(PLATFORM_DAVID_950PR_957D), PLATFORMCONFIG_DAVID_950PR_957D},
    {static_cast<uint32_t>(PLATFORM_DAVID_950PR_950Z), PLATFORMCONFIG_DAVID_950PR_950Z},
    {static_cast<uint32_t>(PLATFORM_DAVID_950PR_9579), PLATFORMCONFIG_DAVID_950PR_9579},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_9591), PLATFORMCONFIG_DAVID_950DT_9591},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_9592), PLATFORMCONFIG_DAVID_950DT_9592},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_9581), PLATFORMCONFIG_DAVID_950DT_9581},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_9582), PLATFORMCONFIG_DAVID_950DT_9582},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_9584), PLATFORMCONFIG_DAVID_950DT_9584},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_9587), PLATFORMCONFIG_DAVID_950DT_9587},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_9588), PLATFORMCONFIG_DAVID_950DT_9588},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_9572), PLATFORMCONFIG_DAVID_950DT_9572},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_9575), PLATFORMCONFIG_DAVID_950DT_9575},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_9576), PLATFORMCONFIG_DAVID_950DT_9576},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_9574), PLATFORMCONFIG_DAVID_950DT_9574},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_9577), PLATFORMCONFIG_DAVID_950DT_9577},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_9578), PLATFORMCONFIG_DAVID_950DT_9578},
    {static_cast<uint32_t>(PLATFORM_DAVID_950PR_957C), PLATFORMCONFIG_DAVID_950PR_957C},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_95A1), PLATFORMCONFIG_DAVID_950DT_95A1},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_95A2), PLATFORMCONFIG_DAVID_950DT_95A2},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_9595), PLATFORMCONFIG_DAVID_950DT_9595},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_9596), PLATFORMCONFIG_DAVID_950DT_9596},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_9585), PLATFORMCONFIG_DAVID_950DT_9585},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_9586), PLATFORMCONFIG_DAVID_950DT_9586},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_9583), PLATFORMCONFIG_DAVID_950DT_9583},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_9571), PLATFORMCONFIG_DAVID_950DT_9571},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_9573), PLATFORMCONFIG_DAVID_950DT_9573},
    {static_cast<uint32_t>(PLATFORM_DAVID_950DT_950X), PLATFORMCONFIG_DAVID_950DT_950X},
 	{static_cast<uint32_t>(PLATFORM_DAVID_950DT_950Y), PLATFORMCONFIG_DAVID_950DT_950Y}
};

rtPlatformType_t Config::GetPlatformTypeByConfig(uint32_t platformConfig) const
{
    rtPlatformType_t platformType = PLATFORM_END;
    const auto iter = archVersionMap_.find(platformConfig);
    if (iter != archVersionMap_.end()) {
        platformConfig = iter->second;
    }
    for (uint32_t idx = static_cast<uint32_t>(PLATFORM_BEGIN); idx < static_cast<uint32_t>(PLATFORM_END); idx++) {
        if (hardWareConfig_[idx].platformConfig == platformConfig) {
            platformType = static_cast<rtPlatformType_t>(idx);
            break;
        }
    }

    return platformType;
}

void Config::InitHardwareInfoMiniV2()
{
    constexpr size_t platIndex = static_cast<size_t>(PLATFORM_MINI_V2);
    hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_MINI_V2;
    return;
}

// PLATFORMCONFIG_CLOUD_V2   910B4
void Config::InitHardwareInfoCloudV2()
{
    constexpr size_t platIndex = static_cast<size_t>(PLATFORM_CLOUD_V2);
    hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_CLOUD_V2;
    return;
}

void Config::InitHardwareInfoCloudV1()
{
    const size_t platIndex = static_cast<size_t>(PLATFORM_CLOUD_V1);
    hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_CLOUD_V1;
    return;
}

void Config::InitHardwareInfoDc()
{
    constexpr size_t platIndex = static_cast<size_t>(PLATFORM_DC);
    hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_DC;
    return;
}

void Config::InitHardwareInfo950()
{
    for (uint32_t platIndex = static_cast<uint32_t>(PLATFORM_DAVID_950PR_9599);
        platIndex <= static_cast<uint32_t>(PLATFORM_DAVID_950DT_950Y); platIndex++) {
        std::unordered_map<uint32_t, uint32_t>::const_iterator it = platformConfigMap.find(platIndex);
        if (it == platformConfigMap.end()) {
            continue;
        }
        hardWareConfig_[platIndex].platformConfig = it->second;
    }
    return;
}

void Config::InitHardwareInfo910_5591()
{
    constexpr size_t platIndex = static_cast<size_t>(PLATFORM_SOLOMON);
    hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_ASCEND_910_5591;
    return;
}


void Config::InitHardwareInfo910B()
{
    for (uint32_t platIndex = static_cast<uint32_t>(PLATFORM_CLOUD_V2_910B1);
        platIndex < static_cast<uint32_t>(PLATFORM_END); platIndex++) {
        if (platIndex == static_cast<uint32_t>(PLATFORM_CLOUD_V2_910B1)) {
            hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_CLOUD_V2_910B1;
        } else if (platIndex == static_cast<uint32_t>(PLATFORM_CLOUD_V2_910B2)) {
            hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_CLOUD_V2_910B2;
        } else if (platIndex == static_cast<uint32_t>(PLATFORM_CLOUD_V2_910B3)) {
            hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_CLOUD_V2_910B3;
        } else if (platIndex == static_cast<uint32_t>(PLATFORM_CLOUD_V2_910B2C)) {
            hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_CLOUD_V2_910B2C;
        } else if (platIndex == static_cast<uint32_t>(PLATFORM_CLOUD_V2_910B4_1)) {
            hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_CLOUD_V2_910B4_1;
        } else {
            continue;
        }
    }
    return;
}

void Config::InitHardwareInfoMiniV3()
{
    for (uint32_t platIndex = static_cast<uint32_t>(PLATFORM_MINI_V3);
        platIndex <= static_cast<uint32_t>(PLATFORM_MINI_V3_B4); platIndex++) {
        if (platIndex == static_cast<uint32_t>(PLATFORM_MINI_V3)) {
            hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_MINI_V3;
        } else if (platIndex == static_cast<uint32_t>(PLATFORM_MINI_V3_B1)) {
            hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_MINI_V3_BIN1;
        } else if (platIndex == static_cast<uint32_t>(PLATFORM_MINI_V3_B2)) {
            hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_MINI_V3_BIN2;
        } else if (platIndex == static_cast<uint32_t>(PLATFORM_MINI_V3_B3)) {
            hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_MINI_V3_BIN3;
        } else if (platIndex == static_cast<uint32_t>(PLATFORM_MINI_V3_B4)) {
            hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_MINI_V3_BIN4;
        } else {
            continue;
        }
    }

    return;
}

void Config::InitHardwareInfoAs31xm1x()
{
    const size_t platIdx = static_cast<size_t>(PLATFORM_AS31XM1X);
    hardWareConfig_[platIdx].platformConfig = PLATFORMCONFIG_AS31XM1X;
    return;
}

void Config::InitHardwareInfoAscend031()
{
    constexpr size_t platIndex = static_cast<size_t>(PLATFORM_ASCEND_031);
    hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_MINI_5612;
    return;
}

void Config::InitHardwareInfoBs9sx1a()
{
    constexpr size_t platIdx = static_cast<size_t>(PLATFORM_BS9SX1A);
    hardWareConfig_[platIdx].platformConfig = PLATFORMCONFIG_BS9SX1A;
    return;
}

void Config::InitHardwareInfoLite()
{
    const size_t platIndex = static_cast<size_t>(PLATFORM_ADC_LITE);
    hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_ADC_LITE;
    return;
}

void Config::InitHardwareInfoMc62cm12a()
{
    constexpr size_t platIndex = static_cast<size_t>(PLATFORM_MC62CM12A);
    hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_MC62CM12A;
    return;
}

rtError_t Config::InitHardwareInfo() const
{
    InitHardwareInfoCloudV1();
    InitHardwareInfoMiniV2();
    InitHardwareInfoDc();
    InitHardwareInfoCloudV2();
    InitHardwareInfo950();
    InitHardwareInfo910_5591();
    InitHardwareInfoMiniV3();
    InitHardwareInfoAs31xm1x();
    InitHardwareInfoAscend031();
    InitHardwareInfo910B();
    InitHardwareInfoBs9sx1a();
    InitHardwareInfoLite();
    InitHardwareInfoMc62cm12a();

    return RT_ERROR_NONE;
}

}
}
