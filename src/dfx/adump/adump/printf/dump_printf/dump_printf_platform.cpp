/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstring>
#include "runtime/base.h"
#include "runtime/dev.h"
#include "dump_printf_platform.h"
#include "adump_platform_manager.h"

#ifdef __cplusplus
extern "C" {
#endif

size_t AdxGetCoreTypeIDOffset()
{
    static const Adx::DataDumpInterface defaultPlat;
    auto *plat = Adx::DataDumpManager::Get();
    return (plat != nullptr) ? plat->GetCoreTypeIDOffset() : defaultPlat.GetCoreTypeIDOffset();
}

size_t AdxGetBlockNum() {
    static const Adx::DataDumpInterface defaultPlat;
    auto *plat = Adx::DataDumpManager::Get();
    return (plat != nullptr) ? plat->GetBlockNum() : defaultPlat.GetBlockNum();
}

bool AdxEnableSimtDump(size_t dumpWorkSpaceSize)
{
    auto *plat = Adx::DataDumpManager::Get();
    if (plat == nullptr) {
        return false;
    }
    return plat->IsSimtDumpEnabled(dumpWorkSpaceSize);
}

int32_t GetStreamSynchronizeTimeout()
{
    static const Adx::DataDumpInterface defaultPlat;
    auto *plat = Adx::DataDumpManager::Get();
    return (plat != nullptr) ? plat->GetStreamSyncTimeout() : defaultPlat.GetStreamSyncTimeout();
}

#ifdef __cplusplus
}
#endif
