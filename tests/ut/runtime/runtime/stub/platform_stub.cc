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
#include "platform_manager_v2.h"
bool g_init_platform_info_flag = true;
bool g_get_platform_info_flag = true;

fe::PlatformInfoManager& fe::PlatformInfoManager::Instance() {
  static fe::PlatformInfoManager pf;
  return pf;
}

fe::PlatformInfoManager& fe::PlatformInfoManager::GeInstance() {
  static fe::PlatformInfoManager pf;
  return pf;
}

uint32_t fe::PlatformInfoManager::InitializePlatformInfo() {
  if (g_init_platform_info_flag) {
    return 0;
  } else {
    return 1;
  }
}

uint32_t fe::PlatformInfoManager::GetPlatformInfos(
    const string SoCVersion, fe::PlatFormInfos &platform_info, fe::OptionalInfos &opti_compilation_info) {
    return 0U;
}

bool fe::PlatFormInfos::GetPlatformRes(const string &label, const string &key, string &val) {
    return true;
}

uint32_t fe::PlatformInfoManager::GetPlatformInstanceByDevice(const uint32_t &device_id,
                                                              PlatFormInfos &platform_infos) {
  return 0U;
}

uint32_t fe::PlatformInfoManager::GetPlatformInfoWithOutSocVersion(fe::PlatFormInfos &platform_info,
                                                                   fe::OptionalInfos &opti_compilation_info) {
  return 0U;
}
uint32_t fe::PlatformInfoManager::GetPlatformInfo(
    const string SoCVersion, fe::PlatformInfo &platform_info, fe::OptionalInfo &opti_compilation_info) {
  if (g_get_platform_info_flag) {
    return 0U;
  } else {
    return 1U;
  }
}

uint32_t fe::PlatformInfoManager::InitRuntimePlatformInfos(const std::string &SoCVersion)
{
  return 0U;
}

uint32_t fe::PlatformInfoManager::GetRuntimePlatformInfosByDevice(const uint32_t &device_id,
    PlatFormInfos &platform_infos, bool need_deep_copy)
{
  return 0U;
}

uint32_t fe::PlatformInfoManager::UpdateRuntimePlatformInfosByDevice(
    const uint32_t &device_id, PlatFormInfos &platform_infos)
{
  return 0U;
}

uint32_t fe::PlatformInfoManager::Finalize() {
    return 0U;
}

fe::PlatformInfoManager::PlatformInfoManager() {}
fe::PlatformInfoManager::~PlatformInfoManager() {}

uint32_t fe::PlatFormInfos::GetCoreNum() const {
  return 8U;
}

void fe::PlatFormInfos::SetCoreNumByCoreType(const std::string &core_type) {
  return;
}

bool fe::PlatFormInfos::GetPlatformResWithLock(const std::string &label,
                                               const std::string &key, std::string &val) {
  if (label == "DtypeMKN" && key == "Default") {
    val = "16,16,16";
  }
  return true;
}

bool fe::PlatFormInfos::GetPlatformResWithLock(const std::string &label, std::map<std::string, std::string> &res)
{
  if (label == "DtypeMKN") {
    res = {{"DT_UINT8", "16,32,16"},
        {"DT_INT8", "16,32,16"},
        {"DT_INT4", "16,64,16"},
        {"DT_INT2", "16,128,16"},
        {"DT_UINT2", "16,128,16"},
        {"DT_UINT1", "16,256,16"}};
  } else if (label == "SoCInfo") {
    res = {{"ai_core_cnt", "24"}, {"vector_core_cnt", "48"}};
  } else {
    
  }
  return true;
}

void fe::PlatFormInfos::SetPlatformResWithLock(const std::string &label, std::map<std::string, std::string> &res)
{
  return;
}

PlatformManagerV2 &PlatformManagerV2::Instance() {
  static PlatformManagerV2 platform_info;
  return platform_info;
}

uint32_t PlatformManagerV2::GetSocSpec(const std::string &soc_version, const std::string &label,
    const std::string &key, std::string &value)
{
  value = "test";
  return 0U;
}