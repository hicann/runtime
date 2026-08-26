/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "platform_info.h"

namespace fe {
PlatformInfoManager::PlatformInfoManager() : init_flag_(false), runtime_init_flag_(false) {}

PlatformInfoManager::~PlatformInfoManager() {}

PlatformInfoManager& PlatformInfoManager::Instance()
{
    static PlatformInfoManager platform_info;
    return platform_info;
}

uint32_t PlatformInfoManager::InitializePlatformInfo() { return 0; }

uint32_t PlatformInfoManager::GetPlatformInfos(
    const std::string SoCVersion, PlatFormInfos& platform_info, OptionalInfos& opti_compilation_info)
{
    (void)SoCVersion;
    (void)platform_info;
    (void)opti_compilation_info;
    return 0;
}

bool PlatFormInfos::GetPlatformRes(const std::string& label, const std::string& key, std::string& val)
{
    (void)label;
    (void)key;
    (void)val;
    return false;
}
} // namespace fe
