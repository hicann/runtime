/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "register_config.h"
#include "adump_dsmi.h"

namespace Adx {
void RegisterManager::CreateRegister()
{
    uint32_t type = 0;
    if (!AdumpDsmi::DrvGetPlatformType(type)) {
        return;
    }
    switch (static_cast<PlatformType>(type)) {
        case PlatformType::CHIP_CLOUD_V2:
            register_ = std::make_shared<CloudV2Register>();
            break;
        case PlatformType::CHIP_CLOUD_V4:
            register_ = std::make_shared<CloudV4Register>();
            break;
        default:
            break;
    }
}
}
