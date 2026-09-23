/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cloud_v5_platform.h"

#include "adump_platform_registry.h"
#include "dump_common.h"
#include "kernel_pc_fixer.h"
#include "register_config.h"

namespace Adx {

ADUMP_PLATFORM_REGISTER(FeaturesSupportInterface, PlatformType::CHIP_CLOUD_V5, CloudV5Features);
ADUMP_PLATFORM_REGISTER(CoredumpInterface, PlatformType::CHIP_CLOUD_V5, CloudV5Coredump);
ADUMP_PLATFORM_REGISTER(ExceptionDumpInterface, PlatformType::CHIP_CLOUD_V5, CloudV5Exception);
ADUMP_PLATFORM_REGISTER(DataDumpInterface, PlatformType::CHIP_CLOUD_V5, CloudV5DataDump);

namespace {
constexpr uint32_t MAX_AIC_CORE_COUNT = 70U;
constexpr uint32_t MAX_AIV_CORE_COUNT = 70U;
constexpr uint32_t MAX_ALL_CORE_COUNT = MAX_AIC_CORE_COUNT + MAX_AIV_CORE_COUNT;
} // namespace

CloudV5Features::CloudV5Features()
{
    supported_ = {
        AdumpPlatformFeature::FEATURE_DATA_DUMP,         AdumpPlatformFeature::FEATURE_OVERFLOW_DUMP,
        AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L0, AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L1,
        AdumpPlatformFeature::FEATURE_CORE_DUMP,
    };
}

std::unique_ptr<PcFixerInterface> CloudV5Coredump::CreatePcFixer() const
{
    return std::unique_ptr<PcFixerInterface>(new (std::nothrow) CloudV5PcFixer());
}

std::shared_ptr<RegisterInterface> CloudV5Coredump::CreateRegister() const
{
    return std::make_shared<CloudV5Register>();
}

uint16_t CloudV5Coredump::ConvertCoreId(uint8_t coreType, uint16_t coreId) const
{
    return (coreType == CORE_TYPE_AIC) ? coreId : static_cast<uint16_t>(MAX_AIC_CORE_COUNT + coreId);
}

uint64_t CloudV5DataDump::GetKfcStackSize() const
{
    constexpr uint32_t op_stack_count = MAX_ALL_CORE_COUNT;
    return CalcKfcStackSize(op_stack_count);
}

std::vector<std::string> CloudV5DataDump::GetKfcBinNames() const
{
    return {"dump_stat_op_ascend960.o", "kfc_dump_stat_ascend960.o"};
}

size_t CloudV5DataDump::GetCoreTypeIDOffset() const { return MAX_AIV_CORE_COUNT; }

size_t CloudV5DataDump::GetBlockNum() const { return MAX_ALL_CORE_COUNT; }

} // namespace Adx
