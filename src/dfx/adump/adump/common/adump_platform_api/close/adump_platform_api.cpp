/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "adump_platform_api.h"
#include "platform/platform_info.h"
#include "adx_log.h"

namespace Adx {
static const std::map<PlatformType, bool> CHIP_CORE_MAP = { // true = ai core, false = vector core
    {PlatformType::CHIP_DC_TYPE,  false},
    {PlatformType::CHIP_CLOUD_V2, true},
    {PlatformType::CHIP_CLOUD_V4, true}
};

inline bool GetPlatformInfo(const std::string socVersion, fe::PlatformInfo &platInfo, fe::OptionalInfo &optionalInfo)
{
    IDE_CTRL_VALUE_FAILED(fe::PlatformInfoManager::GeInstance().InitializePlatformInfo() == 0U,
        return false, "Init platform info failed.");
    uint32_t ret = fe::PlatformInfoManager::GeInstance().GetPlatformInfo(socVersion, platInfo, optionalInfo);
    IDE_CTRL_VALUE_FAILED(ret == 0U, return false, "Failed to get platform info, ret is %u", ret);
    return true;
}

bool AdumpPlatformApi::GetUBSizeAndCoreNum(const std::string &socVersion, PlatformType platform, PlatformData &data)
{
    fe::PlatformInfo platInfo;
    fe::OptionalInfo optionalInfo;
    IDE_CTRL_VALUE_FAILED(GetPlatformInfo(socVersion, platInfo, optionalInfo), return false,
        "Failed to get ub size and core number.");

    auto it = CHIP_CORE_MAP.find(platform);
    IDE_CTRL_VALUE_FAILED(it != CHIP_CORE_MAP.cend(), return false, "Current chip type %d is not adapted.", platform);
    if (it->second) {
        data.ubSize = platInfo.ai_core_spec.ub_size;
    } else {
        data.ubSize = platInfo.vector_core_spec.ub_size;
    }
    data.aiCoreCnt = platInfo.soc_info.ai_core_cnt;
    data.vectCoreCnt = platInfo.soc_info.vector_core_cnt;
    return true;
}

bool AdumpPlatformApi::GetAicoreSizeInfo(const std::string &socVersion, BufferSize &bufferSize)
{
    fe::PlatformInfo platInfo;
    fe::OptionalInfo optionalInfo;
    IDE_CTRL_VALUE_FAILED(GetPlatformInfo(socVersion, platInfo, optionalInfo), return false,
        "Failed to read size information from ge platform in GetAicoreSizeInfo.");

    bufferSize.l0aSize = platInfo.ai_core_spec.l0_a_size;
    bufferSize.l0bSize = platInfo.ai_core_spec.l0_b_size;
    bufferSize.l0cSize = platInfo.ai_core_spec.l0_c_size;
    bufferSize.l1Size = platInfo.ai_core_spec.l1_size;
    bufferSize.ubSize = platInfo.ai_core_spec.ub_size;
    return true;
}
}