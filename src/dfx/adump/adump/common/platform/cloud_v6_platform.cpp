/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cloud_v6_platform.h"

#include "adump_platform_registry.h"
#include "dump_common.h"

namespace Adx {

ADUMP_PLATFORM_REGISTER(FeaturesSupportInterface, PlatformType::CHIP_CLOUD_V6, CloudV6Features);
ADUMP_PLATFORM_REGISTER(CoredumpInterface, PlatformType::CHIP_CLOUD_V6, CloudV6Coredump);
ADUMP_PLATFORM_REGISTER(ExceptionDumpInterface, PlatformType::CHIP_CLOUD_V6, CloudV6Exception);
ADUMP_PLATFORM_REGISTER(DataDumpInterface, PlatformType::CHIP_CLOUD_V6, CloudV6DataDump);

namespace {
constexpr uint32_t MAX_AIC_CORE_COUNT = 18U;
constexpr uint32_t MAX_AIV_CORE_COUNT = 36U;
constexpr uint32_t MAX_ALL_CORE_COUNT = MAX_AIC_CORE_COUNT + MAX_AIV_CORE_COUNT;
} // namespace

uint16_t CloudV6Coredump::ConvertCoreId(uint8_t coreType, uint16_t coreId) const
{
    return (coreType == CORE_TYPE_AIC) ? coreId : static_cast<uint16_t>(MAX_AIC_CORE_COUNT + coreId);
}

uint64_t CloudV6DataDump::GetKfcStackSize() const { return CalcKfcStackSize(MAX_ALL_CORE_COUNT); }

size_t CloudV6DataDump::GetCoreTypeIDOffset() const { return MAX_AIV_CORE_COUNT; }

size_t CloudV6DataDump::GetBlockNum() const { return MAX_ALL_CORE_COUNT; }

} // namespace Adx
