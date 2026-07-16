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
#include "base.hpp"

#include <map>

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

namespace {
using cce::runtime::RT_ERROR_INVALID_VALUE;
using cce::runtime::RT_ERROR_NOT_FOUND;

using StubFieldMap = std::map<std::string, std::string>;

struct StubVersionInfo {
    const char* chipType;
    const char* npuArch;
};

const std::map<std::string, StubVersionInfo> kVersionInfoMap = {
    {"Ascend910A", {"1", "1001"}},        {"Ascend910", {"1", "1001"}},   {"Ascend910B", {"1", "1001"}},
    {"Ascend910B1", {"5", "2201"}},       {"Ascend910B2", {"5", "2201"}}, {"Ascend310B1", {"7", "3002"}},
    {"Ascend310P", {"4", "2002"}},        {"Ascend310P1", {"4", "2002"}}, {"Ascend310P3", {"4", "2002"}},
    {"Ascend310P5", {"4", "2002"}},       {"Ascend610", {"2", "2001"}},   {"BS9SX1AA", {"2", "2001"}},
    {"BS9SX1AB", {"2", "2001"}},          {"BS9SX1AC", {"2", "2001"}},    {"AS31XM1X", {"11", "3001"}},
    {"Ascend610Lite", {"12", "3101"}},    {"MC62CM12AA", {"17", "3511"}}, {"MC32DM11AA", {"18", "3512"}},
    {"Ascend950PR_9599", {"15", "3510"}}, {"KirinX90", {"200", "3003"}},  {"Kirin9030", {"201", "3006"}},
    {"Ascend5162A", {"21", "5162"}},
};

const std::map<std::string, StubFieldMap> kSocInfoMap = {
    {"Ascend610Lite",
     {{"normal_stream_num", "512"},
      {"normal_stream_depth", "2048"},
      {"huge_stream_num", "0"},
      {"huge_stream_depth", "0"},
      {"ai_core_cnt", "8"},
      {"vector_core_cnt", "8"},
      {"ai_cpu_cnt", "4"}}},
    {"BS9SX1AA",
     {{"normal_stream_num", "512"},
      {"normal_stream_depth", "2048"},
      {"huge_stream_num", "0"},
      {"huge_stream_depth", "0"},
      {"ai_core_cnt", "8"},
      {"vector_core_cnt", "0"},
      {"ai_cpu_cnt", "4"}}},
    {"BS9SX1AB",
     {{"normal_stream_num", "512"},
      {"normal_stream_depth", "2048"},
      {"huge_stream_num", "0"},
      {"huge_stream_depth", "0"},
      {"ai_core_cnt", "8"},
      {"vector_core_cnt", "0"},
      {"ai_cpu_cnt", "4"}}},
    {"BS9SX1AC",
     {{"normal_stream_num", "512"},
      {"normal_stream_depth", "2048"},
      {"huge_stream_num", "0"},
      {"huge_stream_depth", "0"},
      {"ai_core_cnt", "8"},
      {"vector_core_cnt", "0"},
      {"ai_cpu_cnt", "4"}}},
    {"AS31XM1X",
     {{"normal_stream_num", "1024"},
      {"normal_stream_depth", "2048"},
      {"huge_stream_num", "0"},
      {"huge_stream_depth", "0"},
      {"ai_core_cnt", "32"},
      {"vector_core_cnt", "0"},
      {"ai_cpu_cnt", "8"}}},
    {"MC62CM12AA",
     {{"normal_stream_num", "65535"},
      {"normal_stream_depth", "4089"},
      {"huge_stream_num", "0"},
      {"huge_stream_depth", "0"},
      {"ai_core_cnt", "25"},
      {"vector_core_cnt", "50"},
      {"ai_cpu_cnt", "8"}}},
    {"MC32DM11AA",
     {{"normal_stream_num", "65535"},
      {"normal_stream_depth", "4089"},
      {"huge_stream_num", "0"},
      {"huge_stream_depth", "0"},
      {"ai_core_cnt", "25"},
      {"vector_core_cnt", "50"},
      {"ai_cpu_cnt", "8"}}},
    {"Ascend950PR_9599",
     {{"normal_stream_num", "65535"},
      {"normal_stream_depth", "2049"},
      {"huge_stream_num", "0"},
      {"huge_stream_depth", "0"},
      {"ai_core_cnt", "36"},
      {"vector_core_cnt", "72"},
      {"ai_cpu_cnt", "8"}}},
    {"LLT_ParseIniFile_Success",
     {{"normal_stream_num", "64"},
      {"normal_stream_depth", "8192"},
      {"huge_stream_num", "16"},
      {"huge_stream_depth", "4096"}}},
};

int32_t GetVersionSocSpec(const std::string& socVersion, const std::string& key, std::string& value)
{
    if ((socVersion == "ChipTypeMissing") && (key == "Chip_type")) {
        return RT_ERROR_NOT_FOUND;
    }
    if ((socVersion == "ChipTypeInvalid") && (key == "Chip_type")) {
        value = "invalid";
        return RT_ERROR_NONE;
    }
    if ((socVersion == "ChipTypeOutOfRange") && (key == "Chip_type")) {
        value = "99";
        return RT_ERROR_NONE;
    }
    if ((socVersion == "ChipTypeQueryError") && (key == "Chip_type")) {
        return RT_ERROR_INVALID_VALUE;
    }

    const auto versionIter = kVersionInfoMap.find(socVersion);
    if (versionIter == kVersionInfoMap.end()) {
        return RT_ERROR_NOT_FOUND;
    }

    if (key == "Chip_type") {
        value = versionIter->second.chipType;
        return RT_ERROR_NONE;
    }
    if (key == "NpuArch") {
        value = versionIter->second.npuArch;
        return RT_ERROR_NONE;
    }
    return RT_ERROR_NOT_FOUND;
}

int32_t GetSoCInfoSocSpec(const std::string& socVersion, const std::string& key, std::string& value)
{
    if (socVersion == "LLT_ParseIniFile_Mixed") {
        if (key == "normal_stream_num") {
            return RT_ERROR_NOT_FOUND;
        }
        if (key == "normal_stream_depth") {
            value = "invalid";
            return RT_ERROR_NONE;
        }
        if (key == "huge_stream_num") {
            value = "4294967296";
            return RT_ERROR_NONE;
        }
        if (key == "huge_stream_depth") {
            value = "256";
            return RT_ERROR_NONE;
        }
    }
    if (socVersion == "LLT_ParseIniFile_QueryError") {
        if (key == "normal_stream_num") {
            return RT_ERROR_INVALID_VALUE;
        }
        value = "1024";
        return RT_ERROR_NONE;
    }

    const auto socInfoIter = kSocInfoMap.find(socVersion);
    if (socInfoIter == kSocInfoMap.end()) {
        return RT_ERROR_NOT_FOUND;
    }

    const auto fieldIter = socInfoIter->second.find(key);
    if (fieldIter == socInfoIter->second.end()) {
        return RT_ERROR_NOT_FOUND;
    }
    value = fieldIter->second;
    return RT_ERROR_NONE;
}
} // namespace

int32_t stubPlatformManagerV2GetSocSpec(
    const std::string& soc_version, const std::string& label, const std::string& key, std::string& value)
{
    if (label == "version") {
        return GetVersionSocSpec(soc_version, key, value);
    }
    if (label == "SoCInfo") {
        return GetSoCInfoSocSpec(soc_version, key, value);
    }
    return cce::runtime::RT_ERROR_NOT_FOUND;
}

int32_t PlatformManagerV2::GetSocSpec(
    const std::string& soc_version, const std::string& label, const std::string& key, std::string& value)
{
    return stubPlatformManagerV2GetSocSpec(soc_version, label, key, value);
}
