/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dev_info_manage.h"
namespace cce {
namespace runtime {
DevInfoManage &DevInfoManage::Instance()
{
    static DevInfoManage devInfo;
    return devInfo;
}

bool DevInfoManage::RegPlatformSoNameInfo(rtChipType_t chip, const std::string &soName)
{
    if (isDestroy) {
        return false;
    }
    const WriteProtect lk(&soLock);
    platformSoName[chip] = soName;

    return true;
}

rtError_t DevInfoManage::GetPlatformSoName(rtChipType_t chip, std::string &soName)
{
    if (isDestroy) {
        return RT_ERROR_INVALID_VALUE;
    }
    const ReadProtect lk(&soLock);
    auto it = platformSoName.find(chip);
    if (it != platformSoName.end()) {
        soName = it->second;
        return RT_ERROR_NONE;
    }
    return RT_ERROR_INVALID_VALUE;
}

bool DevInfoManage::RegChipFeatureSet(rtChipType_t chip, const std::unordered_set<RtOptionalFeatureType> &f)
{
    if (isDestroy || (chip < CHIP_BEGIN)) {
        return false;
    }
    
    std::array<bool, FEATURE_MAX_VALUE> feature = {false};
    for (auto &i : f) {
        const uint32_t index = static_cast<uint32_t>(i);
        if (index < FEATURE_MAX_VALUE) {
            feature[index] = true;
        }
    }
    
    // for high performance, no lock.
    // each chip must be registered only once. Dynamic registration is prohibited.
    if (chip < CHIP_END) {
        chipFeatureSet[chip] = feature;
    } else if ((chip >= CHIP_EXT_BEGIN) && (chip < CHIP_EXT_END)) {
        extChipFeatureSet[chip] = feature;
    } else {
        return false;
    }
    return true;
}

rtError_t DevInfoManage::GetChipFeatureSet(rtChipType_t chip, std::array<bool, FEATURE_MAX_VALUE> &f)
{
    if (isDestroy || (chip < CHIP_BEGIN)) {
        return RT_ERROR_INVALID_VALUE;
    }
    if (chip < CHIP_END) {
        f = chipFeatureSet[chip];
    } else if ((chip >= CHIP_EXT_BEGIN) && (chip < CHIP_EXT_END)) {
        auto it = extChipFeatureSet.find(chip);
        if (it != extChipFeatureSet.end()) {
            f = it->second;
        } else {
            f.fill(false);
        }
    } else {
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

bool DevInfoManage::IsSupportChipFeature(rtChipType_t chip, RtOptionalFeatureType f)
{
    const uint32_t index = static_cast<uint32_t>(f);
    if (isDestroy || (chip < CHIP_BEGIN) || (index >= FEATURE_MAX_VALUE)) {
        return false;
    }
    
    if (chip < CHIP_END) {
        return chipFeatureSet[chip][index];
    }
    
    if ((chip >= CHIP_EXT_BEGIN) && (chip < CHIP_EXT_END)) {
        auto it = extChipFeatureSet.find(chip);
        return it != extChipFeatureSet.end() ? it->second[index] : false;
    }
    return false;
}

bool DevInfoManage::RegDevProperties(const rtChipType_t chip, const DevProperties& properties)
{
    if (isDestroy) {
        return false;
    }
    const WriteProtect lk(&propertiesLock);
    propertiesMap[chip] = properties;
    return true;
}

rtError_t DevInfoManage::SetDevProperties(const rtChipType_t chip, const DevProperties& properties)
{
    if (isDestroy) {
        return RT_ERROR_INVALID_VALUE;
    }

    const WriteProtect lk(&propertiesLock);
    auto it = propertiesMap.find(chip);
    if (it != propertiesMap.end()) {
        it->second = properties;
        return RT_ERROR_NONE;
    }

    return RT_ERROR_INVALID_VALUE;
}

rtError_t DevInfoManage::GetDevProperties(const rtChipType_t chip, DevProperties& properties)
{
    if (isDestroy) {
        return RT_ERROR_INVALID_VALUE;
    }

    const ReadProtect lk(&propertiesLock);
    auto it = propertiesMap.find(chip);
    if (it != propertiesMap.end()) {
        properties = it->second;
        return RT_ERROR_NONE;
    }
 
    return RT_ERROR_INVALID_VALUE;
}

rtError_t DevInfoManage::GetAllDevProperties(std::unordered_map<rtChipType_t, DevProperties> &properties)
{
    if (isDestroy) {
        return RT_ERROR_INVALID_VALUE;
    }
 
    const ReadProtect lk(&propertiesLock);
    properties = propertiesMap;
    return RT_ERROR_NONE;
}

bool DevInfoManage::RegDevInfoProcFunc(const rtChipType_t chip, const DevDynInfoProcFunc& func)
{
    if (isDestroy) {
        return false;
    }
    const WriteProtect lk(&devInfoProcLock);
    devInfoProcMap[chip] = func;
    return true;
}
 
rtError_t DevInfoManage::GetDevInfoProcFunc(const rtChipType_t chip, DevDynInfoProcFunc& func)
{
    if (isDestroy) {
        return RT_ERROR_INVALID_VALUE;
    }

    const ReadProtect lk(&devInfoProcLock);
    auto it = devInfoProcMap.find(chip);
    if (it != devInfoProcMap.end()) {
        func = it->second;
        return RT_ERROR_NONE;
    }

    return RT_ERROR_INVALID_VALUE;
}
}  // namespace runtime
}  // namespace cce
