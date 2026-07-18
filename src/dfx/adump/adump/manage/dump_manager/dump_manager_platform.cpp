/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dump_manager.h"

#include "log/adx_log.h"
#include "adump_platform_manager.h"

namespace Adx {
bool DumpManager::CheckCoredumpSupportedPlatform() const
{
    auto *plat = FeaturesSupportManager::Get();
    if (plat == nullptr) {
        IDE_LOGW("[DumpManager] Platform unavailable, coredump not supported.");
        return false;
    }
    return plat->FeatureIsSupport(AdumpPlatformFeature::FEATURE_CORE_DUMP);
}
}  // namespace Adx