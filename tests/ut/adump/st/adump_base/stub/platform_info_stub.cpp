/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "platform/platform_info.h"

namespace fe {
PlatformInfoManager::PlatformInfoManager() : init_flag_(false), runtime_init_flag_(false), opti_compilation_info_()
{}

PlatformInfoManager::~PlatformInfoManager()
{}

PlatformInfoManager &PlatformInfoManager::Instance()
{
    static PlatformInfoManager platform_info;
    return platform_info;
}

PlatformInfoManager &PlatformInfoManager::GeInstance()
{
    static PlatformInfoManager ge_platform_info;
    return ge_platform_info;
}

uint32_t PlatformInfoManager::GetPlatformInfoWithOutSocVersion(PlatformInfo &platform_info,
    OptionalInfo &opti_compilation_info)
{
    return 0;
}

uint32_t fe::PlatformInfoManager::InitializePlatformInfo()
{
    return 0;
}

uint32_t PlatformInfoManager::GetPlatformInfo(const string SoCVersion, PlatformInfo &platform_info,
    OptionalInfo &opti_compilation_info)
{
    (void)SoCVersion;
    (void)opti_compilation_info;
    platform_info.vector_core_spec.ub_size = 262144;
    platform_info.soc_info.ai_core_cnt = 8;
    platform_info.soc_info.vector_core_cnt = 7;
    // 910B/C
    platform_info.ai_core_spec.l0_a_size = 65536;
    platform_info.ai_core_spec.l0_b_size = 65536;
    platform_info.ai_core_spec.l0_c_size = 262144;
    platform_info.ai_core_spec.l1_size = 1048576;
    platform_info.ai_core_spec.ub_size = 262144;
    return 0;
}
}  // namespace fe
