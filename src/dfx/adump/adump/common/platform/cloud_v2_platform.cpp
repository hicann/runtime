/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cloud_v2_platform.h"

#include <string>
#include "runtime/base.h"
#include "log/adx_log.h"
#include "adump_platform_registry.h"
#include "kernel_pc_fixer.h"
#include "register_config.h"
#include "dump_common.h"
#include "dump_core.h"
#include "hccl_mc2_define.h"

namespace Adx {

ADUMP_PLATFORM_REGISTER(ExceptionDumpInterface, PlatformType::CHIP_CLOUD_TYPE, CloudLegacyException);
ADUMP_PLATFORM_REGISTER(FeaturesSupportInterface, PlatformType::CHIP_CLOUD_V2, CloudV2Features);
ADUMP_PLATFORM_REGISTER(CoredumpInterface, PlatformType::CHIP_CLOUD_V2, CloudV2Coredump);
ADUMP_PLATFORM_REGISTER(ExceptionDumpInterface, PlatformType::CHIP_CLOUD_V2, CloudV2Exception);
ADUMP_PLATFORM_REGISTER(DataDumpInterface, PlatformType::CHIP_CLOUD_V2, CloudV2DataDump);

namespace {
uint64_t GetAscend910Mc2StructSize()
{
    constexpr uint32_t socVersionLength = 128U;
    char version[socVersionLength] = {0};
    rtError_t ret = rtGetSocVersion(version, socVersionLength);
    if (ret != RT_ERROR_NONE) {
        IDE_LOGE("[AdumpPlatform] Get soc version failed for mc2 struct size.");
        return 0;
    }
    if (std::string(version).find("Ascend910_93") != std::string::npos) {
        return sizeof(HcclOpResParam);
    }
    return sizeof(HcclCombinOpParam);
}
} // namespace

bool CloudLegacyException::SupportMc2SpacesDump() const
{
    return true;
}

uint64_t CloudLegacyException::GetMc2StructSize() const
{
    return GetAscend910Mc2StructSize();
}

CloudV2Features::CloudV2Features()
{
    supported_ = {
        AdumpPlatformFeature::FEATURE_DATA_DUMP,
        AdumpPlatformFeature::FEATURE_OVERFLOW_DUMP,
        AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L0,
        AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L1,
        AdumpPlatformFeature::FEATURE_CORE_DUMP,
    };
}

std::unique_ptr<PcFixerInterface> CloudV2Coredump::CreatePcFixer() const
{
    return std::unique_ptr<PcFixerInterface>(new (std::nothrow) CloudV2PcFixer());
}

std::shared_ptr<RegisterInterface> CloudV2Coredump::CreateRegister() const
{
    return std::make_shared<CloudV2Register>();
}

void CloudV2Coredump::DumpRegister(DumpCore& core, uint8_t coreType, uint16_t coreId) const
{
    core.DumpV2Register(coreType, coreId);
}

uint16_t CloudV2Coredump::ConvertCoreId(uint8_t coreType, uint16_t coreId) const
{
    return (coreType == CORE_TYPE_AIC) ? coreId : static_cast<uint16_t>(CORE_SIZE_AIC + coreId);
}

bool CloudV2Exception::SupportMc2SpacesDump() const
{
    return true;
}

uint64_t CloudV2Exception::GetMc2StructSize() const
{
    return GetAscend910Mc2StructSize();
}

bool CloudV2Exception::IsArgsDataTypeSizeByByte() const
{
    return true;
}

uint64_t CloudV2DataDump::GetKfcStackSize() const
{
    constexpr uint32_t OP_STACK_910B = 75;
    return CalcKfcStackSize(OP_STACK_910B);
}

std::string CloudV2DataDump::GetKfcBinName() const
{
    return "kfc_dump_stat_ascend910B.o";
}

bool CloudV2DataDump::IsUbFromAiCore() const
{
    return true;
}

} // namespace Adx
