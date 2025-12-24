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
#include "dev_info_manage.h"
#include "platform/platform_info.h"
namespace cce {
namespace runtime {
std::string GetSocVersionStrByType(const rtSocType_t socType)
{
    rtSocInfo_t socInfo = {SOC_END, CHIP_END, ARCH_END, nullptr};
    const rtError_t ret = DevInfoManage::Instance().GetSocInfo(socType, socInfo);
    if ((ret != RT_ERROR_NONE) || (socInfo.socName == nullptr)) {
        return std::string();
    }
    // socInfo.socName is registered as a constant string
    return std::string(socInfo.socName);
}

static rtError_t GetSocInfoFromRuntimeByName(const char_t * const socName, rtSocInfo_t &info)
{
    if ((strncmp(socName, "Ascend910_9391", strlen("Ascend910_9391")) == 0 ||
        strncmp(socName, "Ascend910_9381", strlen("Ascend910_9381")) == 0 ||
        strncmp(socName, "Ascend910_9392", strlen("Ascend910_9392")) == 0 ||
        strncmp(socName, "Ascend910_9382", strlen("Ascend910_9382")) == 0 ||
        strncmp(socName, "Ascend910_9372", strlen("Ascend910_9372")) == 0 ||
        strncmp(socName, "Ascend910_9362", strlen("Ascend910_9362")) == 0) &&
        (strlen(socName) == strlen("Ascend910_9391"))) {
        info.socName = "Ascend910_B4";
        info.archType = ARCH_C220;
        info.chipType = CHIP_910_B_93;
        info.socType = SOC_ASCEND910B4;
        return RT_ERROR_NONE;
    }
    return DevInfoManage::Instance().GetSocInfo(socName, info);
}

static rtError_t GetSocInfoFromRuntimeByChipArchType(rtChipType_t chipType, rtArchType_t archType, rtSocInfo_t& info)
{
    return DevInfoManage::Instance().GetSocInfo(chipType, archType, info);
}

rtError_t GetSocInfoByName(const char_t* const socName, rtSocInfo_t& info)
{
    static thread_local int32_t archTypeCache = -1;
    static thread_local int32_t chipTypeCache = -1;
    static thread_local std::string cachedSocName;

    int32_t archType = -1;
    int32_t chipType = -1;
    if (cachedSocName != std::string(socName)) {
        if (fe::PlatformInfoManager::Instance().InitializePlatformInfo() != 0U) {
            RT_LOG(RT_LOG_WARNING, "Unable to initialize platform info.");
            return GetSocInfoFromRuntimeByName(socName, info);
        }
        const std::string socVersion(socName);
        fe::OptionalInfo optInfo;
        fe::PlatformInfo platInfo;
        if (fe::PlatformInfoManager::Instance().GetPlatformInfo(socVersion, platInfo, optInfo) != 0U) {
            RT_LOG(RT_LOG_WARNING, "Unable to get platform info.");
            return GetSocInfoFromRuntimeByName(socName, info);
        }
        archType = platInfo.soc_info.arch_type;
        chipType = platInfo.soc_info.chip_type;
        /* cache platform query result */
        archTypeCache = platInfo.soc_info.arch_type;
        chipTypeCache = platInfo.soc_info.chip_type;
        cachedSocName = socVersion;
    } else {
        archType = archTypeCache;
        chipType = chipTypeCache;
    }

    RT_LOG(RT_LOG_DEBUG, "archType=%d, chipType=%d, socName=%s.", archType, chipType, socName);
    if (((archType >= ARCH_BEGIN) && (archType < ARCH_END)) && ((chipType >= CHIP_BEGIN) && (chipType < CHIP_END))) {
        return GetSocInfoFromRuntimeByChipArchType(
            static_cast<rtChipType_t>(chipType), static_cast<rtArchType_t>(archType), info);
    } else {
        return GetSocInfoFromRuntimeByName(socName, info);
    }
}
}
}