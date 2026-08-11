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
#include "kernel_pc_fixer.h"
#include "register_config.h"

namespace Adx {

ADUMP_PLATFORM_REGISTER(FeaturesSupportInterface, PlatformType::CHIP_CLOUD_V5, CloudV5Features);
ADUMP_PLATFORM_REGISTER(CoredumpInterface, PlatformType::CHIP_CLOUD_V5, CloudV5Coredump);
ADUMP_PLATFORM_REGISTER(ExceptionDumpInterface, PlatformType::CHIP_CLOUD_V5, CloudV5Exception);
ADUMP_PLATFORM_REGISTER(DataDumpInterface, PlatformType::CHIP_CLOUD_V5, CloudV5DataDump);

CloudV5Features::CloudV5Features()
{
    supported_ = {
        AdumpPlatformFeature::FEATURE_DATA_DUMP,
        AdumpPlatformFeature::FEATURE_OVERFLOW_DUMP,
        AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L0,
        AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L1,
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

} // namespace Adx
