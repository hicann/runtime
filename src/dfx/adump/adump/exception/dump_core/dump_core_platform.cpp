/**
  * Copyright (c) 2025 Huawei Technologies Co., Ltd.
  * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
  * CANN Open Software License Agreement Version 2.0 (the "License").
  * Please refer to the License for details. You may not use this file except in compliance with the License.
  * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
  * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
  * See LICENSE in the root of the software repository for the full text of the License.
  */
#include "dump_core.h"
#include "log/adx_log.h"
#include "adump_dsmi.h"

namespace Adx {

void DumpCore::DumpRegister(uint8_t coreType, uint16_t coreId)
{
    uint32_t platform = 0;
    IDE_CTRL_VALUE_FAILED(AdumpDsmi::DrvGetPlatformType(platform), return, "Get platform type failed.");
    switch (static_cast<PlatformType>(platform)) {
        case PlatformType::CHIP_CLOUD_V2:
            DumpV2Register(coreType, coreId);
            break;
        default:
            break;
    }
}

uint16_t DumpCore::ConvertCoreId(uint8_t coreType, uint16_t coreId) const
{
    uint32_t platform = 0;
    (void)AdumpDsmi::DrvGetPlatformType(platform);
    switch (static_cast<PlatformType>(platform)) {
        case PlatformType::CHIP_CLOUD_V2:
            return (coreType == CORE_TYPE_AIC) ? coreId : static_cast<uint16_t>(CORE_SIZE_AIC + coreId);
        default:
            break;
    }
    return coreId;
}
}  // namespace Adx
