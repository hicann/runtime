/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "soc_info.h"
#include "platform_config_keys.h"
#include "platform_manager_v2.h"

#include <cstddef>
#include <cstdint>
#include <string>

namespace cce {
namespace runtime {
namespace {

rtError_t GetChipTypeFromPlatformBySocName(const std::string& socName, rtChipType_t& chipType)
{
    std::string result;
    const int32_t ret = PlatformManagerV2::Instance().GetSocSpec(socName, platform_config::kVersionSection,
        platform_config::kChipTypeField, result);
    COND_PROC_RETURN_ERROR(ret != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE, ,
        "Get chip type from platform failed, socName=%s, ret=%d.", socName.c_str(), ret);

    try {
        size_t parsePos = 0U;
        const int64_t chipTypeValue = std::stoll(result, &parsePos, 10);
        const bool isCommonChipType =
            (chipTypeValue >= static_cast<int64_t>(CHIP_BEGIN)) && (chipTypeValue < static_cast<int64_t>(CHIP_END));
        const bool isExtChipType = (chipTypeValue >= static_cast<int64_t>(CHIP_EXT_BEGIN)) &&
                                   (chipTypeValue < static_cast<int64_t>(CHIP_EXT_END));
        COND_PROC_RETURN_ERROR(
            (parsePos != result.size()) || (!isCommonChipType && !isExtChipType), RT_ERROR_INVALID_VALUE, ,
            "Chip_type [%s] of socName=%s is invalid.", result.c_str(), socName.c_str());
        chipType = static_cast<rtChipType_t>(chipTypeValue);
    } catch (...) {
        RT_LOG(RT_LOG_ERROR, "Chip_type [%s] of socName=%s is invalid.", result.c_str(), socName.c_str());
        return RT_ERROR_INVALID_VALUE;
    }

    return RT_ERROR_NONE;
}
}  // namespace

rtError_t GetChipTypeFromPlatform(const char_t* const socName, rtChipType_t& chipType)
{
    COND_PROC_RETURN_ERROR(socName == nullptr, RT_ERROR_INVALID_VALUE, , "socName is null.");
    return GetChipTypeFromPlatformBySocName(std::string(socName), chipType);
}

rtError_t GetNpuArchByName(const char_t* const socName, int32_t* hardwareNpuArch)
{
    COND_PROC_RETURN_ERROR(socName == nullptr, RT_ERROR_INVALID_VALUE, , "socName is null.");
    COND_PROC_RETURN_ERROR(hardwareNpuArch == nullptr, RT_ERROR_INVALID_VALUE, , "hardwareNpuArch is null.");
    std::string result = "";
    const int32_t ret =
        PlatformManagerV2::Instance().GetSocSpec(std::string(socName), platform_config::kVersionSection,
            platform_config::kNpuArchField, result);
    COND_PROC_RETURN_ERROR(ret != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE, ,
        "Get soc spec failed, ret = %u, please check.", ret);
    try {
        *hardwareNpuArch = std::stoi(result);
    } catch (...) {
        *hardwareNpuArch = MAX_INT32_NUM;
        RT_LOG(RT_LOG_ERROR, "NpuArch [%s] is inValid.", result.c_str());
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

}
}
