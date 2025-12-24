/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_DEV_INFO_MANAGE_H
#define CCE_RUNTIME_DEV_INFO_MANAGE_H

#include <unordered_set>
#include "base.hpp"
#include "mmpa_api.h"
#include "rw_lock.h"
#include "feature_type.h"
#include "device_properties.h"

namespace std {
    template<>
    struct hash<rtChipType_t> {
        size_t operator()(const rtChipType_t t) const {
            return static_cast<size_t>(t);
        }
    };

    template<>
    struct hash<cce::runtime::RtOptionalFeatureType> {
        size_t operator()(const cce::runtime::RtOptionalFeatureType t) const {
            return static_cast<size_t>(t);
        }
    };
}

namespace cce {
namespace runtime {

class DevInfoManage {
public:
    DevInfoManage()
    {
        (void)mmRWLockInit(&devInfoLock);
        (void)mmRWLockInit(&socInfoLock);
        (void)mmRWLockInit(&soLock);
        (void)mmRWLockInit(&featureLock);
        (void)mmRWLockInit(&propertiesLock);
        (void)mmRWLockInit(&devInfoProcLock);
    };
    ~DevInfoManage()
    {
        SetDestroy();
        (void)mmRWLockDestroy(&devInfoLock);
        (void)mmRWLockDestroy(&socInfoLock);
        (void)mmRWLockDestroy(&soLock);
        (void)mmRWLockDestroy(&featureLock);
        (void)mmRWLockDestroy(&propertiesLock);
        (void)mmRWLockDestroy(&devInfoProcLock);
    };

    static DevInfoManage &Instance();

    bool RegisterSocInfo(const rtSocInfo_t &conf);
    bool BatchRegSocInfo(const rtSocInfo_t *conf, size_t size);
    rtError_t GetSocInfo(const char_t *const socName, rtSocInfo_t &info);
    rtError_t GetSocInfo(const rtSocType_t socType, rtSocInfo_t &info);
    rtError_t GetSocInfo(rtChipType_t chipType, rtArchType_t archType, rtSocInfo_t &info);

    bool RegisterDevInfo(const RtDevInfo &conf);
    bool BatchRegDevInfo(const RtDevInfo *conf, size_t size);
    rtError_t GetDevInfo(const char_t *socName, RtDevInfo &info);

    bool RegPlatformSoNameInfo(rtChipType_t chip, const std::string &soName);
    rtError_t GetPlatformSoName(rtChipType_t chip, std::string &soName);

    bool RegChipFeatureSet(rtChipType_t chip, const std::unordered_set<RtOptionalFeatureType> &f);
    // 支持的在set里，对注册友好
    rtError_t GetChipFeatureSet(rtChipType_t chip, std::unordered_set<RtOptionalFeatureType> &f);
    bool IsSupportChipFeature(rtChipType_t chip, RtOptionalFeatureType f);
    bool RegDevProperties(const rtChipType_t chip, const DevProperties& properties);
    rtError_t GetDevProperties(const rtChipType_t chip, DevProperties& properties);
    rtError_t GetAllDevProperties(std::unordered_map<rtChipType_t, DevProperties> &properties);

    bool RegDevInfoProcFunc(const rtChipType_t chip, const DevDynInfoProcFunc& func);
    rtError_t GetDevInfoProcFunc(const rtChipType_t chip, DevDynInfoProcFunc& func);
    void SetDestroy()
    {
        isDestroy = true;
    }

private:
    std::atomic<bool> isDestroy{false};
    std::mutex info_lock;
    mmRWLock_t devInfoLock;
    std::vector<RtDevInfo> devInfos;
    mmRWLock_t socInfoLock;
    std::vector<rtSocInfo_t> socInfos;

    mmRWLock_t soLock;
    // 不同的chip所在的lib name
    std::unordered_map<rtChipType_t, std::string> platformSoName;

    // Static feature
    mmRWLock_t featureLock;
    std::unordered_map<rtChipType_t, std::vector<bool>> feature;
    std::unordered_map<rtChipType_t, std::unordered_set<RtOptionalFeatureType>> chipFeatureSet;

    mmRWLock_t propertiesLock;
    std::unordered_map<rtChipType_t, DevProperties> propertiesMap;
    // soc/platform/arch maybe need reg

    mmRWLock_t devInfoProcLock;
    std::unordered_map<rtChipType_t, DevDynInfoProcFunc> devInfoProcMap;
    // capability
};
}  // namespace runtime
}  // namespace cce

#ifdef __GNUC__
#define ATTRIBUTE_USED __attribute__((used))
#else
#define ATTRIBUTE_USED
#endif

#define REGISTER_DEV_INFO(conf) \
    static bool g_Register_##conf ATTRIBUTE_USED = cce::runtime::DevInfoManage::Instance().RegisterDevInfo(conf)

#define BATCH_REGISTER_DEV_INFO(conf, size)              \
    static bool g_Batch_Register_##conf ATTRIBUTE_USED = \
        cce::runtime::DevInfoManage::Instance().BatchRegDevInfo((conf), (size))

#define BATCH_REGISTER_SOC_INFO(conf, size)                 \
    static bool g_Batch_RegisterSoc_##conf ATTRIBUTE_USED = \
        cce::runtime::DevInfoManage::Instance().BatchRegSocInfo((conf), (size))

#define REGISTER_SOC_INFO(conf) \
    static bool g_RegisterSoc_##conf ATTRIBUTE_USED = cce::runtime::DevInfoManage::Instance().RegisterSocInfo(conf)

#define REGISTER_PLATFORM_LIB_INFO(chipType, soName)      \
    static bool g_RegisterLib_##chipType ATTRIBUTE_USED = \
        cce::runtime::DevInfoManage::Instance().RegPlatformSoNameInfo((chipType), (soName))

#define GET_PLATFORM_LIB_INFO(chipType, soName) \
    cce::runtime::DevInfoManage::Instance().GetPlatformSoName((chipType), (soName))

#define REGISTER_CHIP_FEATURE_SET(chipType, feature)          \
    static bool g_RegisterFeature_##chipType ATTRIBUTE_USED = \
        cce::runtime::DevInfoManage::Instance().RegChipFeatureSet((chipType), (feature))

#define GET_CHIP_FEATURE_SET(chipType, feature) \
    cce::runtime::DevInfoManage::Instance().GetChipFeatureSet((chipType), (feature))

#define IS_SUPPORT_CHIP_FEATURE(chipType, feature) \
    cce::runtime::DevInfoManage::Instance().IsSupportChipFeature((chipType), (feature))

#define REGISTER_DEV_PROPERTIES(chipType, properties)       \
    static bool g_RegProperties_##chipType ATTRIBUTE_USED = \
        cce::runtime::DevInfoManage::Instance().RegDevProperties((chipType), (properties))

#define GET_DEV_PROPERTIES(chipType, properties) \
    cce::runtime::DevInfoManage::Instance().GetDevProperties((chipType), (properties))

#define GET_ALL_DEV_PROPERTIES(properties) \
    cce::runtime::DevInfoManage::Instance().GetAllDevProperties(properties)

#define REGISTER_DEV_INFO_PROC_FUNC(chipType, func) \
    static bool g_RegDevInfoFunc_##chipType ATTRIBUTE_USED =       \
        cce::runtime::DevInfoManage::Instance().RegDevInfoProcFunc((chipType), (func))

#define GET_DEV_INFO_PROC_FUNC(chipType, func) \
    cce::runtime::DevInfoManage::Instance().GetDevInfoProcFunc((chipType), (func))
#endif
