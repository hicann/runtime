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

struct PlatformConfig {
    uint32_t platformConfig;
    uint32_t l2Size;
};

const std::unordered_map<uint32_t, PlatformConfig> platformConfigMap = {
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9599), {PLATFORMCONFIG_DAVID_910_9599, L2SIZE_DAVID_910_95}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9589), {PLATFORMCONFIG_DAVID_910_9589, L2SIZE_DAVID_910_95}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_958A), {PLATFORMCONFIG_DAVID_910_958A, L2SIZE_DAVID_910_95}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_958B), {PLATFORMCONFIG_DAVID_910_958B, L1SIZE_DAVID_910_958B}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_957B), {PLATFORMCONFIG_DAVID_910_957B, L1SIZE_DAVID_910_958B}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_957D), {PLATFORMCONFIG_DAVID_910_957D, L1SIZE_DAVID_910_957D}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_950Z), {PLATFORMCONFIG_DAVID_910_950Z, L1SIZE_DAVID_910_950Z}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9579), {PLATFORMCONFIG_DAVID_910_9579, L2SIZE_DAVID_910_95}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9591), {PLATFORMCONFIG_DAVID_910_9591, L2SIZE_DAVID_910_95}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9592), {PLATFORMCONFIG_DAVID_910_9592, L2SIZE_DAVID_910_95}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9581), {PLATFORMCONFIG_DAVID_910_9581, L2SIZE_DAVID_910_95}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9582), {PLATFORMCONFIG_DAVID_910_9582, L2SIZE_DAVID_910_95}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9584), {PLATFORMCONFIG_DAVID_910_9584, L1SIZE_DAVID_910_958B}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9587), {PLATFORMCONFIG_DAVID_910_9587, L1SIZE_DAVID_910_958B}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9588), {PLATFORMCONFIG_DAVID_910_9588, L1SIZE_DAVID_910_958B}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9572), {PLATFORMCONFIG_DAVID_910_9572, L2SIZE_DAVID_910_95}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9575), {PLATFORMCONFIG_DAVID_910_9575, L2SIZE_DAVID_910_95}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9576), {PLATFORMCONFIG_DAVID_910_9576, L2SIZE_DAVID_910_95}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9574), {PLATFORMCONFIG_DAVID_910_9574, L1SIZE_DAVID_910_958B}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9577), {PLATFORMCONFIG_DAVID_910_9577, L1SIZE_DAVID_910_958B}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9578), {PLATFORMCONFIG_DAVID_910_9578, L1SIZE_DAVID_910_958B}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_957C), {PLATFORMCONFIG_DAVID_910_957C, L1SIZE_DAVID_910_958B}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_95A1), {PLATFORMCONFIG_DAVID_910_95A1, L2SIZE_DAVID_910_95}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_95A2), {PLATFORMCONFIG_DAVID_910_95A2, L2SIZE_DAVID_910_95}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9595), {PLATFORMCONFIG_DAVID_910_9595, L2SIZE_DAVID_910_95}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9596), {PLATFORMCONFIG_DAVID_910_9596, L2SIZE_DAVID_910_95}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9585), {PLATFORMCONFIG_DAVID_910_9585, L2SIZE_DAVID_910_95}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9586), {PLATFORMCONFIG_DAVID_910_9586, L2SIZE_DAVID_910_95}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9583), {PLATFORMCONFIG_DAVID_910_9583, L1SIZE_DAVID_910_958B}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9571), {PLATFORMCONFIG_DAVID_910_9571, L2SIZE_DAVID_910_95}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_9573), {PLATFORMCONFIG_DAVID_910_9573, L1SIZE_DAVID_910_958B}},
    {static_cast<uint32_t>(PLATFORM_DAVID_910_950X), {PLATFORMCONFIG_DAVID_910_950X, L2SIZE_DAVID_910_950X}},
 	{static_cast<uint32_t>(PLATFORM_DAVID_910_950Y), {PLATFORMCONFIG_DAVID_910_950Y, L2SIZE_DAVID_910_950X}}
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
    hardWareConfig_[platIndex].aiCoreSpec.cubeFreq = CUBEFREQ_MINI_V2;
    hardWareConfig_[platIndex].aiCoreSpec.cubeMSize = CUBEMSIZE_MINI_V2;
    hardWareConfig_[platIndex].aiCoreSpec.cubeKSize = CUBEKSIZE_MINI_V2;
    hardWareConfig_[platIndex].aiCoreSpec.cubeNSize = CUBENSIZE_MINI_V2;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNFp16 = FRAC_MKN_FP16_MINI_V2;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNInt8 = FRAC_MKN_INT8_MINI_V2;
    hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNFp16 = FRAC_VMUL_MKN_FP16_MINI_V2;
    hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNInt8 = FRAC_VMUL_MKN_INT8_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0ASize = L0ASIZE_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0BSize = L0BSIZE_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0CSize = L0CSIZE_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.l1Size = L1SIZE_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.l2Size = L2SIZE_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.l2PageNum = L2PAGENUMBER_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.ubSize = UBSIZE_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.blockSize = BLOCKSIZE_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankSize = BANKSIZE_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankNum = BANKNUM_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankGroupNum = BANKGROUPNUM_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ddrRate = DDRBW_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2Rate = L2BW_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2ReadRate = L2READBW_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2WriteRate = L2WRITEBW_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0ARate = L1TOL0ABW_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0BRate = L1TOL0BBW_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l0CToUBRate = L0CTOUBBW_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL2 = UBTOL2_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToDDR = UBTODDR_MINI_V2;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL1 = UBTOL1_MINI_V2;
    hardWareConfig_[platIndex].memoryConfig.flowtableSize = FLOWTABLESIZE_MINI_V2;
    hardWareConfig_[platIndex].memoryConfig.compilerSize = COMPILERSIZE_MINI_V2;

    return;
}

// PLATFORMCONFIG_CLOUD_V2   910B4
void Config::InitHardwareInfoCloudV2()
{
    constexpr size_t platIndex = static_cast<size_t>(PLATFORM_CLOUD_V2);
    hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFreq = CUBEFREQ_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreSpec.cubeMSize = CUBEMSIZE_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreSpec.cubeKSize = CUBEKSIZE_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreSpec.cubeNSize = CUBENSIZE_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNFp16 = FRAC_MKN_FP16_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNInt8 = FRAC_MKN_INT8_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNFp16 = FRAC_VMUL_MKN_FP16_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNInt8 = FRAC_VMUL_MKN_INT8_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0ASize = L0ASIZE_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0BSize = L0BSIZE_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0CSize = L0CSIZE_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.l1Size = L1SIZE_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.l2Size = L2SIZE_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.l2PageNum = L2PAGENUMBER_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.ubSize = UBSIZE_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.blockSize = BLOCKSIZE_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankSize = BANKSIZE_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankNum = BANKNUM_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankGroupNum = BANKGROUPNUM_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ddrRate = DDRBW_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2Rate = L2BW_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2ReadRate = L2READBW_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2WriteRate = L2WRITEBW_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0ARate = L1TOL0ABW_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0BRate = L1TOL0BBW_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l0CToUBRate = L0CTOUBBW_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL2 = UBTOL2_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToDDR = UBTODDR_CLOUD_V2;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL1 = UBTOL1_CLOUD_V2;
    hardWareConfig_[platIndex].memoryConfig.flowtableSize = FLOWTABLESIZE_CLOUD_V2;
    hardWareConfig_[platIndex].memoryConfig.compilerSize = COMPILERSIZE_CLOUD_V2;

    return;
}

void Config::InitHardwareInfoCloudV1()
{
    const size_t platIndex = static_cast<size_t>(PLATFORM_CLOUD_V1);
    hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFreq = CUBEFREQ_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreSpec.cubeMSize = CUBEMSIZE_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreSpec.cubeKSize = CUBEKSIZE_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreSpec.cubeNSize = CUBENSIZE_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNFp16 = FRAC_MKN_FP16_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNInt8 = FRAC_MKN_INT8_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNFp16 = FRAC_VMUL_MKN_FP16_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNInt8 = FRAC_VMUL_MKN_INT8_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0ASize = L0ASIZE_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0BSize = L0BSIZE_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0CSize = L0CSIZE_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemorySize.l1Size = L1SIZE_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemorySize.l2Size = L2SIZE_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemorySize.l2PageNum = L2PAGENUMBER_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemorySize.ubSize = UBSIZE_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemorySize.blockSize = BLOCKSIZE_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankSize = BANKSIZE_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankNum = BANKNUM_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankGroupNum = BANKGROUPNUM_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ddrRate = DDRBW_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2Rate = L2BW_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2ReadRate = L2READBW_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2WriteRate = L2WRITEBW_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0ARate = L1TOL0ABW_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0BRate = L1TOL0BBW_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l0CToUBRate = L0CTOUBBW_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL2 = UBTOL2_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToDDR = UBTODDR_CLOUD_V1;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL1 = UBTOL1_CLOUD_V1;
    hardWareConfig_[platIndex].memoryConfig.flowtableSize = FLOWTABLESIZE_CLOUD_V1;
    hardWareConfig_[platIndex].memoryConfig.compilerSize = COMPILERSIZE_CLOUD_V1;

    return;
}

void Config::InitHardwareInfoDc()
{
    constexpr size_t platIndex = static_cast<size_t>(PLATFORM_DC);
    hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_DC;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFreq = CUBEFREQ_DC;
    hardWareConfig_[platIndex].aiCoreSpec.cubeMSize = CUBEMSIZE_DC;
    hardWareConfig_[platIndex].aiCoreSpec.cubeKSize = CUBEKSIZE_DC;
    hardWareConfig_[platIndex].aiCoreSpec.cubeNSize = CUBENSIZE_DC;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNFp16 = FRAC_MKN_FP16_DC;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNInt8 = FRAC_MKN_INT8_DC;
    hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNFp16 = FRAC_VMUL_MKN_FP16_DC;
    hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNInt8 = FRAC_VMUL_MKN_INT8_DC;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0ASize = L0ASIZE_DC;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0BSize = L0BSIZE_DC;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0CSize = L0CSIZE_DC;
    hardWareConfig_[platIndex].aiCoreMemorySize.l1Size = L1SIZE_DC;
    hardWareConfig_[platIndex].aiCoreMemorySize.l2Size = L2SIZE_DC;
    hardWareConfig_[platIndex].aiCoreMemorySize.l2PageNum = L2PAGENUMBER_DC;
    hardWareConfig_[platIndex].aiCoreMemorySize.ubSize = UBSIZE_DC;
    hardWareConfig_[platIndex].aiCoreMemorySize.blockSize = BLOCKSIZE_DC;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankSize = BANKSIZE_DC;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankNum = BANKNUM_DC;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankGroupNum = BANKGROUPNUM_DC;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ddrRate = DDRBW_DC;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2Rate = L2BW_DC;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2ReadRate = L2READBW_DC;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2WriteRate = L2WRITEBW_DC;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0ARate = L1TOL0ABW_DC;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0BRate = L1TOL0BBW_DC;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l0CToUBRate = L0CTOUBBW_DC;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL2 = UBTOL2_DC;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToDDR = UBTODDR_DC;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL1 = UBTOL1_DC;
    hardWareConfig_[platIndex].memoryConfig.flowtableSize = FLOWTABLESIZE_DC;
    hardWareConfig_[platIndex].memoryConfig.compilerSize = COMPILERSIZE_DC;

    return;
}

void Config::InitHardwareInfo910_95()
{
    uint32_t l2Size;
    for (uint32_t platIndex = static_cast<uint32_t>(PLATFORM_DAVID_910_9599);
        platIndex <= static_cast<uint32_t>(PLATFORM_DAVID_910_950Y); platIndex++) {
        std::unordered_map<uint32_t, PlatformConfig>::const_iterator it = platformConfigMap.find(platIndex);
        if (it == platformConfigMap.end()) {
            continue;
        }
        hardWareConfig_[platIndex].platformConfig = it->second.platformConfig;
        l2Size = it->second.l2Size;
        RT_LOG(RT_LOG_INFO, "l2Size: %u", l2Size);
        hardWareConfig_[platIndex].aiCoreSpec.cubeFreq = CUBEFREQ_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreSpec.cubeMSize = CUBEMSIZE_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreSpec.cubeKSize = CUBEKSIZE_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreSpec.cubeNSize = CUBENSIZE_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNFp16 = FRAC_MKN_FP16_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNInt8 = FRAC_MKN_INT8_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNFp16 = FRAC_VMUL_MKN_FP16_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNInt8 = FRAC_VMUL_MKN_INT8_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreMemorySize.l0ASize = L0ASIZE_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreMemorySize.l0BSize = L0BSIZE_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreMemorySize.l0CSize = L0CSIZE_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreMemorySize.l1Size = L1SIZE_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreMemorySize.l2Size = l2Size;
        hardWareConfig_[platIndex].aiCoreMemorySize.l2PageNum = L2PAGENUMBER_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreMemorySize.ubSize = UBSIZE_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreMemorySize.blockSize = BLOCKSIZE_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreMemorySize.bankSize = BANKSIZE_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreMemorySize.bankNum = BANKNUM_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreMemorySize.bankGroupNum = BANKGROUPNUM_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreMemoryRates.ddrRate = DDRBW_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreMemoryRates.l2Rate = L2BW_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreMemoryRates.l2ReadRate = L2READBW_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreMemoryRates.l2WriteRate = L2WRITEBW_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0ARate = L1TOL0ABW_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0BRate = L1TOL0BBW_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreMemoryRates.l0CToUBRate = L0CTOUBBW_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL2 = UBTOL2_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreMemoryRates.ubToDDR = UBTODDR_DAVID_910_95;
        hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL1 = UBTOL1_DAVID_910_95;
        hardWareConfig_[platIndex].memoryConfig.flowtableSize = FLOWTABLESIZE_DAVID_910_95;
        hardWareConfig_[platIndex].memoryConfig.compilerSize = COMPILERSIZE_DAVID_910_95;
    }
    return;
}

void Config::InitHardwareInfo910_5591()
{
    constexpr size_t platIndex = static_cast<size_t>(PLATFORM_SOLOMON);
    hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_ASCEND_910_5591;
    // to do adapter
    return;
}


void Config::InitHardwareInfo910B()
{
    uint32_t l2Size = L2SIZE_910B;
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
            l2Size = L2SIZE_910B4_1;
        } else {
            continue;
        }
        hardWareConfig_[platIndex].aiCoreSpec.cubeFreq = CUBEFREQ_910B;
        hardWareConfig_[platIndex].aiCoreSpec.cubeMSize = CUBEMSIZE_910B;
        hardWareConfig_[platIndex].aiCoreSpec.cubeKSize = CUBEKSIZE_910B;
        hardWareConfig_[platIndex].aiCoreSpec.cubeNSize = CUBENSIZE_910B;
        hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNFp16 = FRAC_MKN_FP16_910B;
        hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNInt8 = FRAC_MKN_INT8_910B;
        hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNFp16 = FRAC_VMUL_MKN_FP16_910B;
        hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNInt8 = FRAC_VMUL_MKN_INT8_910B;
        hardWareConfig_[platIndex].aiCoreMemorySize.l0ASize = L0ASIZE_910B;
        hardWareConfig_[platIndex].aiCoreMemorySize.l0BSize = L0BSIZE_910B;
        hardWareConfig_[platIndex].aiCoreMemorySize.l0CSize = L0CSIZE_910B;
        hardWareConfig_[platIndex].aiCoreMemorySize.l1Size = L1SIZE_910B;
        hardWareConfig_[platIndex].aiCoreMemorySize.l2Size = l2Size;
        hardWareConfig_[platIndex].aiCoreMemorySize.l2PageNum = L2PAGENUMBER_910B;
        hardWareConfig_[platIndex].aiCoreMemorySize.ubSize = UBSIZE_910B;
        hardWareConfig_[platIndex].aiCoreMemorySize.blockSize = BLOCKSIZE_910B;
        hardWareConfig_[platIndex].aiCoreMemorySize.bankSize = BANKSIZE_910B;
        hardWareConfig_[platIndex].aiCoreMemorySize.bankNum = BANKNUM_910B;
        hardWareConfig_[platIndex].aiCoreMemorySize.bankGroupNum = BANKGROUPNUM_910B;
        hardWareConfig_[platIndex].aiCoreMemoryRates.ddrRate = DDRBW_910B;
        hardWareConfig_[platIndex].aiCoreMemoryRates.l2Rate = L2BW_910B;
        hardWareConfig_[platIndex].aiCoreMemoryRates.l2ReadRate = L2READBW_910B;
        hardWareConfig_[platIndex].aiCoreMemoryRates.l2WriteRate = L2WRITEBW_910B;
        hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0ARate = L1TOL0ABW_910B;
        hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0BRate = L1TOL0BBW_910B;
        hardWareConfig_[platIndex].aiCoreMemoryRates.l0CToUBRate = L0CTOUBBW_910B;
        hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL2 = UBTOL2_910B;
        hardWareConfig_[platIndex].aiCoreMemoryRates.ubToDDR = UBTODDR_910B;
        hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL1 = UBTOL1_910B;
        hardWareConfig_[platIndex].memoryConfig.flowtableSize = FLOWTABLESIZE_910B;
        hardWareConfig_[platIndex].memoryConfig.compilerSize = COMPILERSIZE_910B;
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

        hardWareConfig_[platIndex].aiCoreSpec.cubeFreq = CUBEFREQ_MINI_V3;
        hardWareConfig_[platIndex].aiCoreSpec.cubeMSize = CUBEMSIZE_MINI_V3;
        hardWareConfig_[platIndex].aiCoreSpec.cubeKSize = CUBEKSIZE_MINI_V3;
        hardWareConfig_[platIndex].aiCoreSpec.cubeNSize = CUBENSIZE_MINI_V3;
        hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNFp16 = FRAC_MKN_FP16_MINI_V3;
        hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNInt8 = FRAC_MKN_INT8_MINI_V3;
        hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNFp16 = FRAC_VMUL_MKN_FP16_MINI_V3;
        hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNInt8 = FRAC_VMUL_MKN_INT8_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemorySize.l0ASize = L0ASIZE_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemorySize.l0BSize = L0BSIZE_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemorySize.l0CSize = L0CSIZE_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemorySize.l1Size = L1SIZE_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemorySize.l2Size = L2SIZE_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemorySize.l2PageNum = L2PAGENUMBER_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemorySize.ubSize = UBSIZE_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemorySize.blockSize = BLOCKSIZE_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemorySize.bankSize = BANKSIZE_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemorySize.bankNum = BANKNUM_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemorySize.bankGroupNum = BANKGROUPNUM_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemoryRates.ddrRate = DDRBW_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemoryRates.l2Rate = L2BW_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemoryRates.l2ReadRate = L2READBW_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemoryRates.l2WriteRate = L2WRITEBW_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0ARate = L1TOL0ABW_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0BRate = L1TOL0BBW_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemoryRates.l0CToUBRate = L0CTOUBBW_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL2 = UBTOL2_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemoryRates.ubToDDR = UBTODDR_MINI_V3;
        hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL1 = UBTOL1_MINI_V3;
        hardWareConfig_[platIndex].memoryConfig.flowtableSize = FLOWTABLESIZE_MINI_V3;
        hardWareConfig_[platIndex].memoryConfig.compilerSize = COMPILERSIZE_MINI_V3;
    }

    return;
}

void Config::InitHardwareInfoAs31xm1x()
{
    const size_t platIdx = static_cast<size_t>(PLATFORM_AS31XM1X);
    hardWareConfig_[platIdx].platformConfig = PLATFORMCONFIG_AS31XM1X;
    hardWareConfig_[platIdx].aiCoreSpec.cubeFreq = CUBEFREQ_MINI_V3;
    hardWareConfig_[platIdx].aiCoreSpec.cubeMSize = CUBEMSIZE_MINI_V3;
    hardWareConfig_[platIdx].aiCoreSpec.cubeKSize = CUBEKSIZE_MINI_V3;
    hardWareConfig_[platIdx].aiCoreSpec.cubeNSize = CUBENSIZE_MINI_V3;
    hardWareConfig_[platIdx].aiCoreSpec.cubeFracMKNFp16 = FRAC_MKN_FP16_MINI_V3;
    hardWareConfig_[platIdx].aiCoreSpec.cubeFracMKNInt8 = FRAC_MKN_INT8_MINI_V3;
    hardWareConfig_[platIdx].aiCoreSpec.vecFracVmulMKNFp16 = FRAC_VMUL_MKN_FP16_MINI_V3;
    hardWareConfig_[platIdx].aiCoreSpec.vecFracVmulMKNInt8 = FRAC_VMUL_MKN_INT8_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemorySize.l0ASize = L0ASIZE_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemorySize.l0BSize = L0BSIZE_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemorySize.l0CSize = L0CSIZE_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemorySize.l1Size = L1SIZE_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemorySize.l2Size = L2SIZE_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemorySize.l2PageNum = L2PAGENUMBER_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemorySize.ubSize = UBSIZE_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemorySize.blockSize = BLOCKSIZE_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemorySize.bankSize = BANKSIZE_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemorySize.bankNum = BANKNUM_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemorySize.bankGroupNum = BANKGROUPNUM_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemoryRates.ddrRate = DDRBW_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemoryRates.l2Rate = L2BW_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemoryRates.l2ReadRate = L2READBW_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemoryRates.l2WriteRate = L2WRITEBW_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemoryRates.l1ToL0ARate = L1TOL0ABW_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemoryRates.l1ToL0BRate = L1TOL0BBW_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemoryRates.l0CToUBRate = L0CTOUBBW_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemoryRates.ubToL2 = UBTOL2_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemoryRates.ubToDDR = UBTODDR_MINI_V3;
    hardWareConfig_[platIdx].aiCoreMemoryRates.ubToL1 = UBTOL1_MINI_V3;
    hardWareConfig_[platIdx].memoryConfig.flowtableSize = FLOWTABLESIZE_MINI_V3;
    hardWareConfig_[platIdx].memoryConfig.compilerSize = COMPILERSIZE_MINI_V3;

    return;
}

void Config::InitHardwareInfoMini5612()
{
    constexpr size_t platIndex = static_cast<size_t>(PLATFORM_MINI_5612);
    hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_MINI_5612;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFreq = CUBEFREQ_MINI_5612;
    hardWareConfig_[platIndex].aiCoreSpec.cubeMSize = CUBEMSIZE_MINI_5612;
    hardWareConfig_[platIndex].aiCoreSpec.cubeKSize = CUBEKSIZE_MINI_5612;
    hardWareConfig_[platIndex].aiCoreSpec.cubeNSize = CUBENSIZE_MINI_5612;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNFp16 = FRAC_MKN_FP16_MINI_5612;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNInt8 = FRAC_MKN_INT8_MINI_5612;
    hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNFp16 = FRAC_VMUL_MKN_FP16_MINI_5612;
    hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNInt8 = FRAC_VMUL_MKN_INT8_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0ASize = L0ASIZE_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0BSize = L0BSIZE_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0CSize = L0CSIZE_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemorySize.l1Size = L1SIZE_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemorySize.l2Size = L2SIZE_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemorySize.l2PageNum = L2PAGENUMBER_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemorySize.ubSize = UBSIZE_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemorySize.blockSize = BLOCKSIZE_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankSize = BANKSIZE_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankNum = BANKNUM_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankGroupNum = BANKGROUPNUM_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ddrRate = DDRBW_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2Rate = L2BW_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2ReadRate = L2READBW_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2WriteRate = L2WRITEBW_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0ARate = L1TOL0ABW_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0BRate = L1TOL0BBW_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l0CToUBRate = L0CTOUBBW_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL2 = UBTOL2_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToDDR = UBTODDR_MINI_5612;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL1 = UBTOL1_MINI_5612;
    hardWareConfig_[platIndex].memoryConfig.flowtableSize = FLOWTABLESIZE_MINI_5612;
    hardWareConfig_[platIndex].memoryConfig.compilerSize = COMPILERSIZE_MINI_5612;

    return;
}

void Config::InitHardwareInfoBs9sx1a()
{
    constexpr size_t platIdx = static_cast<size_t>(PLATFORM_BS9SX1A);
    hardWareConfig_[platIdx].platformConfig = PLATFORMCONFIG_BS9SX1A;
    hardWareConfig_[platIdx].aiCoreSpec.cubeFreq = CUBEFREQ_ADC_BS9SX1A;
    hardWareConfig_[platIdx].aiCoreSpec.cubeMSize = CUBEMSIZE_MINI_V2;
    hardWareConfig_[platIdx].aiCoreSpec.cubeKSize = CUBEKSIZE_MINI_V2;
    hardWareConfig_[platIdx].aiCoreSpec.cubeNSize = CUBENSIZE_MINI_V2;
    hardWareConfig_[platIdx].aiCoreSpec.cubeFracMKNFp16 = FRAC_MKN_FP16_MINI_V2;
    hardWareConfig_[platIdx].aiCoreSpec.cubeFracMKNInt8 = FRAC_MKN_INT8_MINI_V2;
    hardWareConfig_[platIdx].aiCoreSpec.vecFracVmulMKNFp16 = FRAC_VMUL_MKN_FP16_MINI_V2;
    hardWareConfig_[platIdx].aiCoreSpec.vecFracVmulMKNInt8 = FRAC_VMUL_MKN_INT8_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemorySize.l0ASize = L0ASIZE_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemorySize.l0BSize = L0BSIZE_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemorySize.l0CSize = L0CSIZE_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemorySize.l1Size = L1SIZE_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemorySize.l2Size = L2SIZE_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemorySize.l2PageNum = L2PAGENUMBER_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemorySize.ubSize = UBSIZE_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemorySize.blockSize = BLOCKSIZE_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemorySize.bankSize = BANKSIZE_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemorySize.bankNum = BANKNUM_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemorySize.bankGroupNum = BANKGROUPNUM_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemoryRates.ddrRate = DDRBW_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemoryRates.l2Rate = L2BW_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemoryRates.l2ReadRate = L2READBW_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemoryRates.l2WriteRate = L2WRITEBW_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemoryRates.l1ToL0ARate = L1TOL0ABW_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemoryRates.l1ToL0BRate = L1TOL0BBW_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemoryRates.l0CToUBRate = L0CTOUBBW_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemoryRates.ubToL2 = UBTOL2_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemoryRates.ubToDDR = UBTODDR_MINI_V2;
    hardWareConfig_[platIdx].aiCoreMemoryRates.ubToL1 = UBTOL1_MINI_V2;
    hardWareConfig_[platIdx].memoryConfig.flowtableSize = FLOWTABLESIZE_MINI_V2;
    hardWareConfig_[platIdx].memoryConfig.compilerSize = COMPILERSIZE_MINI_V2;

    return;
}

void Config::InitHardwareInfoLite()
{
    const size_t platIndex = static_cast<size_t>(PLATFORM_ADC_LITE);
    hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFreq = CUBEFREQ_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreSpec.cubeMSize = CUBEMSIZE_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreSpec.cubeKSize = CUBEKSIZE_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreSpec.cubeNSize = CUBENSIZE_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNFp16 = FRAC_MKN_FP16_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNInt8 = FRAC_MKN_INT8_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNFp16 = FRAC_VMUL_MKN_FP16_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNInt8 = FRAC_VMUL_MKN_INT8_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0ASize = L0ASIZE_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0BSize = L0BSIZE_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0CSize = L0CSIZE_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemorySize.l1Size = L1SIZE_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemorySize.l2Size = L2SIZE_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemorySize.l2PageNum = L2PAGENUMBER_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemorySize.ubSize = UBSIZE_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemorySize.blockSize = BLOCKSIZE_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankSize = BANKSIZE_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankNum = BANKNUM_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankGroupNum = BANKGROUPNUM_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ddrRate = DDRBW_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2Rate = L2BW_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2ReadRate = L2READBW_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2WriteRate = L2WRITEBW_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0ARate = L1TOL0ABW_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0BRate = L1TOL0BBW_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l0CToUBRate = L0CTOUBBW_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL2 = UBTOL2_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToDDR = UBTODDR_ADC_LITE;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL1 = UBTOL1_ADC_LITE;
    hardWareConfig_[platIndex].memoryConfig.flowtableSize = FLOWTABLESIZE_ADC_LITE;
    hardWareConfig_[platIndex].memoryConfig.compilerSize = COMPILERSIZE_ADC_LITE;

    return;
}

void Config::InitHardwareInfoMc62cm12a()
{
    constexpr size_t platIndex = static_cast<size_t>(PLATFORM_MC62CM12A);
    hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_MC62CM12A;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFreq = CUBEFREQ_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreSpec.cubeMSize = CUBEMSIZE_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreSpec.cubeKSize = CUBEKSIZE_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreSpec.cubeNSize = CUBENSIZE_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNFp16 = FRAC_MKN_FP16_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNInt8 = FRAC_MKN_INT8_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNFp16 = FRAC_VMUL_MKN_FP16_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNInt8 = FRAC_VMUL_MKN_INT8_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0ASize = L0ASIZE_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0BSize = L0BSIZE_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0CSize = L0CSIZE_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemorySize.l1Size = L1SIZE_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemorySize.l2Size = L2SIZE_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemorySize.l2PageNum = L2PAGENUMBER_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemorySize.ubSize = UBSIZE_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemorySize.blockSize = BLOCKSIZE_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankSize = BANKSIZE_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankNum = BANKNUM_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankGroupNum = BANKGROUPNUM_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ddrRate = DDRBW_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2Rate = L2BW_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2ReadRate = L2READBW_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2WriteRate = L2WRITEBW_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0ARate = L1TOL0ABW_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0BRate = L1TOL0BBW_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l0CToUBRate = L0CTOUBBW_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL2 = UBTOL2_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToDDR = UBTODDR_DAVID_910_95;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL1 = UBTOL1_DAVID_910_95;
    hardWareConfig_[platIndex].memoryConfig.flowtableSize = FLOWTABLESIZE_DAVID_910_95;
    hardWareConfig_[platIndex].memoryConfig.compilerSize = COMPILERSIZE_DAVID_910_95;

    return;
}

rtError_t Config::InitHardwareInfo() const
{
    InitHardwareInfoCloudV1();
    InitHardwareInfoMiniV2();
    InitHardwareInfoDc();
    InitHardwareInfoCloudV2();
    InitHardwareInfo910_95();
    InitHardwareInfo910_5591(); // solomon
    InitHardwareInfoMiniV3();
    InitHardwareInfoAs31xm1x();
    InitHardwareInfoMini5612();
    InitHardwareInfo910B();
    InitHardwareInfoBs9sx1a();
    InitHardwareInfoLite();
    InitHardwareInfoMc62cm12a();

    return RT_ERROR_NONE;
}

}
}
