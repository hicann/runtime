/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cloud_v4_platform.h"

#include <string>
#include "adump_platform_registry.h"
#include "kernel_pc_fixer.h"
#include "register_config.h"
#include "dump_common.h"
#include "dump_core.h"

namespace Adx {

ADUMP_PLATFORM_REGISTER(FeaturesSupportInterface, PlatformType::CHIP_CLOUD_V4, CloudV4Features);
ADUMP_PLATFORM_REGISTER(CoredumpInterface, PlatformType::CHIP_CLOUD_V4, CloudV4Coredump);
ADUMP_PLATFORM_REGISTER(ExceptionDumpInterface, PlatformType::CHIP_CLOUD_V4, CloudV4Exception);
ADUMP_PLATFORM_REGISTER(DataDumpInterface, PlatformType::CHIP_CLOUD_V4, CloudV4DataDump);

namespace {
constexpr size_t ADX_MAX_AICORE_ON_ASCEND950 = 36U;
constexpr size_t ADX_MAX_STR_LEN = 1024U * 1024U;
}

CloudV4Features::CloudV4Features()
{
    supported_ = {
        AdumpPlatformFeature::FEATURE_DATA_DUMP,
        AdumpPlatformFeature::FEATURE_OVERFLOW_DUMP,
        AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L0,
        AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L1,
        AdumpPlatformFeature::FEATURE_CORE_DUMP,
    };
}

std::unique_ptr<PcFixerInterface> CloudV4Coredump::CreatePcFixer() const
{
    return std::unique_ptr<PcFixerInterface>(new (std::nothrow) CloudV4PcFixer());
}

std::shared_ptr<RegisterInterface> CloudV4Coredump::CreateRegister() const
{
    return std::make_shared<CloudV4Register>();
}

void CloudV4Coredump::DumpRegister(DumpCore& core, uint8_t coreType, uint16_t coreId) const
{
    core.DumpV4Register(coreType, coreId);
}

uint16_t CloudV4Coredump::ConvertCoreId(uint8_t coreType, uint16_t coreId) const
{
    return (coreType == CORE_TYPE_AIC) ? coreId : static_cast<uint16_t>(CORE_SIZE_AIC_DAVID + coreId);
}

bool CloudV4Exception::IsArgsDataTypeSizeByByte() const
{
    return false;
}

uint64_t CloudV4DataDump::GetKfcStackSize() const
{
    constexpr uint32_t OP_STACK_950 = 108;
    return CalcKfcStackSize(OP_STACK_950);
}

std::string CloudV4DataDump::GetKfcBinName() const
{
    return "kfc_dump_stat_ascend950.o";
}

bool CloudV4DataDump::IsUbFromAiCore() const
{
    return true;
}

size_t CloudV4DataDump::GetCoreTypeIDOffset() const
{
    return ADX_MAX_AICORE_ON_ASCEND950 * 2;
}

size_t CloudV4DataDump::GetBlockNum() const
{
    return ADX_MAX_AICORE_ON_ASCEND950 * 3;
}

int32_t CloudV4DataDump::GetStreamSyncTimeout() const
{
    constexpr int32_t ADX_DAVID_TIMEOUT = 60000 * 30;
    return ADX_DAVID_TIMEOUT;
}

bool CloudV4DataDump::IsSimtDumpEnabled(size_t dumpWorkSpaceSize) const
{
    return dumpWorkSpaceSize > GetBlockNum() * ADX_MAX_STR_LEN;
}

} // namespace Adx
