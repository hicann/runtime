/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "ini_parse_utils.h"

#include <cinttypes>
#include <string>

#include "platform_manager_v2.h"

namespace cce {
namespace runtime {

namespace {
// Anonymous namespace keeps these helpers local to this translation unit.
struct StreamFieldConfig {
    const char* fieldName;
    // Pointer-to-member: stores which RtIniAttributes field this ini item maps to.
    uint32_t RtIniAttributes::*target;
};

// constexpr makes the mapping table a compile-time constant with no runtime initialization.
constexpr StreamFieldConfig kStreamFieldConfigs[] = {
    {"normal_stream_num", &RtIniAttributes::normalStreamNum},
    {"normal_stream_depth", &RtIniAttributes::normalStreamDepth},
    {"huge_stream_num", &RtIniAttributes::hugeStreamNum},
    {"huge_stream_depth", &RtIniAttributes::hugeStreamDepth},
};

constexpr const char *SOC_INFO_SECTION = "SoCInfo";
constexpr const char *VERSION_SECTION = "version";
constexpr const char *NPU_ARCH_FIELD = "NpuArch";
} // namespace

static int32_t ReadIniUint32(
    const std::string& socVersion, const char* sectionName, const char* fieldName, uint32_t& value)
{
    value = 0U;
    std::string strValue;
    const int32_t ret = PlatformManagerV2::Instance().GetSocSpec(socVersion, sectionName, fieldName, strValue);
    if (ret != RT_ERROR_NONE) {
        return ret;
    }
    try {
        const uint64_t val64 = std::stoull(strValue);
        if (val64 > UINT32_MAX) {
            RT_LOG(RT_LOG_WARNING, "ini field[%s] value[%" PRIu64 "] exceeds uint32 max, keep default value.",
                fieldName, val64);
            return RT_ERROR_NONE;
        }
        value = static_cast<uint32_t>(val64);
        return RT_ERROR_NONE;
    } catch (...) {
        RT_LOG(RT_LOG_WARNING, "ini field[%s] value[%s] is invalid, keep default value.", fieldName,
            strValue.c_str());
    }
    return RT_ERROR_NONE;
}

static int32_t ReadIniInt64(
    const std::string& socVersion, const char* sectionName, const char* fieldName, int64_t& value)
{
    value = 0;
    std::string strValue;
    const int32_t ret = PlatformManagerV2::Instance().GetSocSpec(socVersion, sectionName, fieldName, strValue);
    if (ret != RT_ERROR_NONE) {
        return ret;
    }

    try {
        value = std::stoll(strValue);
        return RT_ERROR_NONE;
    } catch (...) {
        RT_LOG(
            RT_LOG_WARNING, "ini field[%s.%s] value[%s] is invalid, keep default value.", sectionName, fieldName,
            strValue.c_str());
    }
    return RT_ERROR_NONE;
}

static void GetStreamSpecFromIniFile(const std::string& socVersion, RtIniAttributes& iniAttrs)
{
    for (const auto& fieldConfig : kStreamFieldConfigs) {
        uint32_t value = 0U;
        const int32_t ret = ReadIniUint32(socVersion, SOC_INFO_SECTION, fieldConfig.fieldName, value);
        if (ret == RT_ERROR_NOT_FOUND) {
            continue;
        }
        if (ret != RT_ERROR_NONE) {
            RT_LOG(
                RT_LOG_WARNING, "GetSocSpec failed for socVersion[%s], ret=%d, skip ini parse.", socVersion.c_str(), ret);
            return;
        }
        if (value != 0U) {
            // .* applies a pointer-to-member to a concrete object instance.
            iniAttrs.*(fieldConfig.target) = value;
        }
    }

    RT_LOG(
        RT_LOG_INFO, "iniAttrs: normalStreamNum=%u, normalStreamDepth=%u, hugeStreamNum=%u, hugeStreamDepth=%u.",
        iniAttrs.normalStreamNum, iniAttrs.normalStreamDepth, iniAttrs.hugeStreamNum, iniAttrs.hugeStreamDepth);
}

static void GetArchInfoFromIniFile(const std::string& socVersion, RtIniAttributes& iniAttrs)
{
    int64_t npuArch = 0;
    const int32_t ret = ReadIniInt64(socVersion, VERSION_SECTION, NPU_ARCH_FIELD, npuArch);
    if (ret == RT_ERROR_NOT_FOUND) {
        RT_LOG(RT_LOG_WARNING,
            "GetSocSpec not found for socVersion[%s], section[%s], field[%s], keep default npuArch.",
            socVersion.c_str(), VERSION_SECTION, NPU_ARCH_FIELD);
        return;
    }
    if (ret != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_WARNING, "GetSocSpec failed for socVersion[%s], ret=%d, skip version ini parse.",
            socVersion.c_str(), ret);
        return;
    }

    iniAttrs.npuArch = npuArch;
    RT_LOG(RT_LOG_INFO, "iniAttrs: socVersion=%s, npuArch=%ld.", socVersion.c_str(), iniAttrs.npuArch);
}

void ParseIniFile(const std::string& socVersion, RtIniAttributes& iniAttrs)
{
    if (socVersion.empty()) {
        RT_LOG(RT_LOG_WARNING, "socVersion is empty, skip ini parse.");
        return;
    }

    GetStreamSpecFromIniFile(socVersion, iniAttrs);
    GetArchInfoFromIniFile(socVersion, iniAttrs);
}

} // namespace runtime
} // namespace cce
