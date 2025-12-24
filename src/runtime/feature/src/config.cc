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
    {PLATFORMCONFIG_910_B_93_OLD, PLATFORMCONFIG_910_B_93},
    {PLATFORMCONFIG_910B1_OLD, PLATFORMCONFIG_910B1},
    {PLATFORMCONFIG_910B2_OLD, PLATFORMCONFIG_910B2},
    {PLATFORMCONFIG_910B3_OLD, PLATFORMCONFIG_910B3},
    {PLATFORMCONFIG_910B4_1_OLD, PLATFORMCONFIG_910B4_1},
};

struct PlatformConfig {
    uint32_t platformConfig;
    uint32_t l2Size;
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

// PLATFORMCONFIG_910_B_93   910B4
void Config::InitHardwareInfoCloudV2()
{
    constexpr size_t platIndex = static_cast<size_t>(PLATFORM_910_B_93);
    hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_910_B_93;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFreq = CUBEFREQ_910_B_93;
    hardWareConfig_[platIndex].aiCoreSpec.cubeMSize = CUBEMSIZE_910_B_93;
    hardWareConfig_[platIndex].aiCoreSpec.cubeKSize = CUBEKSIZE_910_B_93;
    hardWareConfig_[platIndex].aiCoreSpec.cubeNSize = CUBENSIZE_910_B_93;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNFp16 = FRAC_MKN_FP16_910_B_93;
    hardWareConfig_[platIndex].aiCoreSpec.cubeFracMKNInt8 = FRAC_MKN_INT8_910_B_93;
    hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNFp16 = FRAC_VMUL_MKN_FP16_910_B_93;
    hardWareConfig_[platIndex].aiCoreSpec.vecFracVmulMKNInt8 = FRAC_VMUL_MKN_INT8_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0ASize = L0ASIZE_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0BSize = L0BSIZE_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemorySize.l0CSize = L0CSIZE_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemorySize.l1Size = L1SIZE_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemorySize.l2Size = L2SIZE_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemorySize.l2PageNum = L2PAGENUMBER_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemorySize.ubSize = UBSIZE_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemorySize.blockSize = BLOCKSIZE_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankSize = BANKSIZE_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankNum = BANKNUM_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemorySize.bankGroupNum = BANKGROUPNUM_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ddrRate = DDRBW_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2Rate = L2BW_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2ReadRate = L2READBW_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l2WriteRate = L2WRITEBW_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0ARate = L1TOL0ABW_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l1ToL0BRate = L1TOL0BBW_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemoryRates.l0CToUBRate = L0CTOUBBW_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL2 = UBTOL2_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToDDR = UBTODDR_910_B_93;
    hardWareConfig_[platIndex].aiCoreMemoryRates.ubToL1 = UBTOL1_910_B_93;
    hardWareConfig_[platIndex].memoryConfig.flowtableSize = FLOWTABLESIZE_910_B_93;
    hardWareConfig_[platIndex].memoryConfig.compilerSize = COMPILERSIZE_910_B_93;

    return;
}

void Config::InitHardwareInfo910B()
{
    uint32_t l2Size = L2SIZE_910B;
    for (uint32_t platIndex = static_cast<uint32_t>(PLATFORM_910B1);
        platIndex < static_cast<uint32_t>(PLATFORM_END); platIndex++) {
        if (platIndex == static_cast<uint32_t>(PLATFORM_910B1)) {
            hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_910B1;
        } else if (platIndex == static_cast<uint32_t>(PLATFORM_910B2)) {
            hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_910B2;
        } else if (platIndex == static_cast<uint32_t>(PLATFORM_910B3)) {
            hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_910B3;
        } else if (platIndex == static_cast<uint32_t>(PLATFORM_910B2C)) {
            hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_910B2C;
        } else if (platIndex == static_cast<uint32_t>(PLATFORM_910B4_1)) {
            hardWareConfig_[platIndex].platformConfig = PLATFORMCONFIG_910B4_1;
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

rtError_t Config::InitHardwareInfo() const
{
    InitHardwareInfoCloudV2();
    InitHardwareInfo910B();
    return RT_ERROR_NONE;
}

rtError_t Config::GetAiCoreSpec(const  rtPlatformType_t platformType,
                                rtAiCoreSpec_t * const aiCoreSpec) const
{
    *aiCoreSpec = hardWareConfig_[platformType].aiCoreSpec;
    return RT_ERROR_NONE;
}

rtError_t Config::GetAiCoreMemorySizes(const rtPlatformType_t platformType,
                                       rtAiCoreMemorySize_t * const aiCoreMemorySize) const
{
    *aiCoreMemorySize = hardWareConfig_[platformType].aiCoreMemorySize;
    return RT_ERROR_NONE;
}

rtError_t Config::GetAiCoreMemoryRates(const rtPlatformType_t platformType,
                                       rtAiCoreMemoryRates_t * const aiCoreMemoryRates) const
{
    *aiCoreMemoryRates = hardWareConfig_[platformType].aiCoreMemoryRates;
    return RT_ERROR_NONE;
}

rtError_t Config::GetMemoryConfig(const rtPlatformType_t platformType, rtMemoryConfig_t * const memoryConfig) const
{
    *memoryConfig = hardWareConfig_[platformType].memoryConfig;
    return RT_ERROR_NONE;
}

rtError_t Config::SetAiCoreMemSizes(const rtPlatformType_t platformType,
                                    const rtAiCoreMemorySize_t * const aiCoreMemorySize) const
{
    UNUSED(platformType);
    UNUSED(aiCoreMemorySize);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}
}
}
