/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "platform_manager_v2.h"

#include "platform_error_define.h"

namespace {
constexpr const char* TINY_SOC_VERSION = "Ascend031";
constexpr const char* TINY_DEFAULT_SOC_SPEC = "3004";

struct TinySocSpec {
    const char* label;
    const char* key;
    const char* value;
};

constexpr TinySocSpec TINY_SOC_SPECS[] = {
    {"version", "NpuArch", "3004"},          {"version", "Chip_type", "8"},
    {"SoCInfo", "ai_core_cnt", "1"},         {"SoCInfo", "ai_cpu_cnt", "4"},
    {"SoCInfo", "normal_stream_num", "480"}, {"SoCInfo", "normal_stream_depth", "2048"},
    {"SoCInfo", "huge_stream_num", "0"},     {"SoCInfo", "huge_stream_depth", "0"},
};
} // namespace

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

PlatformManagerV2& PlatformManagerV2::Instance()
{
    static PlatformManagerV2 platform_info;
    return platform_info;
}

int32_t PlatformManagerV2::GetSocSpec(
    const std::string& soc_version, const std::string& label, const std::string& key, std::string& value)
{
    if (soc_version == TINY_SOC_VERSION) {
        for (const auto& spec : TINY_SOC_SPECS) {
            if ((label == spec.label) && (key == spec.key)) {
                value = spec.value;
                return PLATFORM_SUCCESS;
            }
        }
    }
    value = TINY_DEFAULT_SOC_SPEC;
    return PLATFORM_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus
