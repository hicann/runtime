/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "platform_info.h"
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

uint32_t PlatformInfoManager::Finalize() {
  return 0U;
}

__attribute__((visibility("default"))) uint32_t PlatformInfoManager::InitializePlatformInfo()
{
    return 0;
}

__attribute__((visibility("default"))) uint32_t PlatformInfoManager::GetPlatformInfo(const std::string SoCVersion,
    PlatformInfo &platform_info, OptionalInfo &opti_compilation_info)
{
    return 0;
}

__attribute__((visibility("default"))) uint32_t PlatformInfoManager::GetPlatformInfos(const std::string SoCVersion,
    PlatFormInfos &platform_info, OptionalInfos &opti_compilation_info)
{
    return 0;
}

__attribute__((visibility("default"))) uint32_t PlatformInfoManager::GetPlatformInstanceByDevice(
    const uint32_t &device_id, PlatFormInfos &platform_info)
{
    return 0;
}

__attribute__((visibility("default"))) uint32_t PlatformInfoManager::GetPlatformInfoWithOutSocVersion(
    PlatFormInfos &platform_info, OptionalInfos &opti_compilation_info)
{
    return 0;
}

uint32_t PlatformInfoManager::UpdateRuntimePlatformInfosByDevice(const uint32_t &device_id,
    PlatFormInfos &platform_infos)
{
    return 0;
}

uint32_t PlatformInfoManager::UpdatePlatformInfos(fe::PlatFormInfos &platform_info)
{
    return 0;
}

uint32_t PlatformInfoManager::GetRuntimePlatformInfosByDevice(const uint32_t &device_id,
    PlatFormInfos &platform_infos, bool need_deep_copy)
{
    return 0;
}

uint32_t PlatformInfoManager::UpdatePlatformInfos(const std::string &soc_version, fe::PlatFormInfos &platform_info)
{
    return 0;
}

uint32_t PlatformInfoManager::InitRuntimePlatformInfos(const std::string &SoCVersion)
{
    return 0;
}
}  // namespace fe
