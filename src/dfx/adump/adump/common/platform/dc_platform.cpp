/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dc_platform.h"

#include "adump_platform_registry.h"

namespace Adx {

ADUMP_PLATFORM_REGISTER(FeaturesSupportInterface, PlatformType::CHIP_DC_TYPE, DcFeatures);
ADUMP_PLATFORM_REGISTER(ExceptionDumpInterface, PlatformType::CHIP_DC_TYPE, DcException);
ADUMP_PLATFORM_REGISTER(DataDumpInterface, PlatformType::CHIP_DC_TYPE, DcDataDump);

DcFeatures::DcFeatures()
{
    supported_ = {
        AdumpPlatformFeature::FEATURE_DATA_DUMP,
        AdumpPlatformFeature::FEATURE_OVERFLOW_DUMP,
        AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L0,
        AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L1,
    };
}

bool DcException::IsArgsDataTypeSizeByByte() const
{
    return true;
}

uint64_t DcDataDump::GetKfcStackSize() const
{
    constexpr uint32_t OP_STACK_310P = 2;
    return CalcKfcStackSize(OP_STACK_310P);
}

std::string DcDataDump::GetKfcBinName() const
{
    return "kfc_dump_stat_ascend310p3.o";
}

} // namespace Adx
