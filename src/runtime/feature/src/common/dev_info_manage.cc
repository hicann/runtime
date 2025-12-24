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
#include <map>
#include <vector>
#include <mutex>
namespace cce {
namespace runtime {
DevInfoManage &DevInfoManage::Instance()
{
    static DevInfoManage devInfo;
    return devInfo;
}

bool DevInfoManage::RegisterSocInfo(const rtSocInfo_t &conf)
{
    if (isDestroy) {
        return false;
    }
    const WriteProtect lk(&socInfoLock);
    socInfos.push_back(conf);
    return true;
}

bool DevInfoManage::BatchRegSocInfo(const rtSocInfo_t *conf, size_t size)
{
    if (isDestroy) {
        return false;
    }
    const WriteProtect lk(&socInfoLock);
    for (size_t i = 0; i < size; ++i) {
        socInfos.push_back(conf[i]);
    }

    return true;
}

rtError_t DevInfoManage::GetSocInfo(const char_t *const socName, rtSocInfo_t &info)
{
    if (isDestroy) {
        return RT_ERROR_INVALID_VALUE;
    }
    const ReadProtect lk(&socInfoLock);
    for (auto &i : socInfos) {
        if (strcmp(i.socName, socName) == 0) {
            info = i;
            return RT_ERROR_NONE;
        } 
    }
    return RT_ERROR_INVALID_VALUE;
}

rtError_t DevInfoManage::GetSocInfo(const rtSocType_t socType, rtSocInfo_t &info)
{
    if (isDestroy) {
        return RT_ERROR_INVALID_VALUE;
    }
    const ReadProtect lk(&socInfoLock);
    for (auto &i : socInfos) {
        if (socType == i.socType) {
            info = i;
            return RT_ERROR_NONE;
        } 
    }
    return RT_ERROR_INVALID_VALUE;
}

rtError_t DevInfoManage::GetSocInfo(rtChipType_t chipType, rtArchType_t archType, rtSocInfo_t &info)
{
    if (isDestroy) {
        return RT_ERROR_INVALID_VALUE;
    }
    const ReadProtect lk(&socInfoLock);
    for (auto &i : socInfos) {
        if ((chipType == i.chipType) && (archType == i.archType)) {
            info = i;
            return RT_ERROR_NONE;
        } 
    }
    return RT_ERROR_INVALID_VALUE;
}

bool DevInfoManage::RegisterDevInfo(const RtDevInfo &conf)
{
    if (isDestroy) {
        return false;
    }
    const WriteProtect lk(&devInfoLock);
    devInfos.push_back(conf);
    return true;
}

bool DevInfoManage::BatchRegDevInfo(const RtDevInfo *conf, size_t size)
{
    if (isDestroy) {
        return false;
    }
    const WriteProtect lk(&devInfoLock);
    for (size_t i = 0; i < size; ++i) {
        devInfos.push_back(conf[i]);
    }

    return true;
}

rtError_t DevInfoManage::GetDevInfo(const char_t *socName, RtDevInfo &info)
{
    if (isDestroy) {
        return RT_ERROR_INVALID_VALUE;
    }
    const ReadProtect lk(&devInfoLock);
    for (auto &i : devInfos) {
        if (strcmp(i.socName, socName) == 0) {
            info = i;
            return RT_ERROR_NONE;
        } 
    }
    return RT_ERROR_INVALID_VALUE;
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
    if (isDestroy) {
        return false;
    }
    const WriteProtect lk(&featureLock);
    // Append
    chipFeatureSet[chip].insert(f.begin(), f.end());
    return true;
}

rtError_t DevInfoManage::GetChipFeatureSet(rtChipType_t chip, std::unordered_set<RtOptionalFeatureType> &f)
{
    if (!isDestroy) {
        const ReadProtect lk(&featureLock);
        auto it = chipFeatureSet.find(chip);
        if (it != chipFeatureSet.end()) {
            f = it->second;
            return RT_ERROR_NONE;
        }
    }
    return RT_ERROR_INVALID_VALUE;
}

bool DevInfoManage::IsSupportChipFeature(rtChipType_t chip, RtOptionalFeatureType f)
{
    if (isDestroy) {
        return false;
    }
    const ReadProtect lk(&featureLock);
    auto it = chipFeatureSet.find(chip);
    if (it != chipFeatureSet.end()) {
        if (it->second.find(f) != it->second.end()) {
            return true;
        }
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