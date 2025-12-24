/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "feature_manager.h"
#include <unordered_map>
#include "config_manager.h"
#include "errno/error_code.h"

namespace Analysis {
namespace Dvvp {
namespace Common {
namespace Config {

using namespace analysis::dvvp::common::error;
namespace {
// featureName, compatibility, featureVersion, affectedComponent, affectedComponentVersion, infoLog
std::vector<FeatureRecord> FEATURE_V1 = {
    {"ATTR\0", "1\0", "2\0", "all\0", "all\0", "It not support feature: ATTR!\0"},
};

std::unordered_map<PlatformType, std::vector<FeatureRecord>> FEATURE_V2_TABLE = {
    {
        PlatformType::CHIP_V4_1_0, {
            {"ATTR\0", "1\0", "2\0", "all\0", "all\0", "It not support feature: ATTR!\0"},
            {"MemoryAccess\0", "1\0", "2\0", "all\0", "all\0", "It not support feature: MEMORY_ACCESS!\0"},
        }
    },
};

static const std::string FILE_NAME = "incompatible_features.json";

static std::vector<FeatureRecord>& GetCurPlatformFeatures(bool isV2 = true)
{
    if (!isV2) {
        return FEATURE_V1;
    }
    PlatformType platformType = ConfigManager::instance()->GetPlatformType();
    auto it = FEATURE_V2_TABLE.find(platformType);
    if (it != FEATURE_V2_TABLE.end()) {
        return it->second;
    }
    return FEATURE_V1;
}
}

FeatureManager::FeatureManager() {}
 
FeatureManager::~FeatureManager()
{
    Uninit();
}

int32_t FeatureManager::Init()
{
    if (isInit_) {
        MSPROF_LOGI("FeatureManager is already initialized.");
        return PROFILING_SUCCESS;
    }
    FUNRET_CHECK_EXPR_ACTION(!CheckCreateFeatures(), return PROFILING_FAILED,
        "Failed to check feature list.");

    isInit_ = true;
    MSPROF_LOGI("FeatureManager initialized successfully.");
    return PROFILING_SUCCESS;
}

bool FeatureManager::CheckCreateFeatures() const
{
    // check v2 features
    for (const auto& platformFeatures : FEATURE_V2_TABLE) {
        for (const auto& feature : platformFeatures.second) {
            FUNRET_CHECK_EXPR_ACTION(feature.featureName[0] == '\0' || feature.info.affectedComponent[0] == '\0' ||
                feature.info.affectedComponentVersion[0] == '\0' || feature.info.compatibility[0] == '\0' ||
                feature.info.featureVersion[0] == '\0' || feature.info.infoLog[0] == '\0', return false,
                "V2 function initialization failed. Member fields are empty.");
        }
    }

    // check v1 features
    for (const auto& feature : FEATURE_V1) {
        FUNRET_CHECK_EXPR_ACTION(feature.featureName[0] == '\0' || feature.info.affectedComponent[0] == '\0' ||
            feature.info.affectedComponentVersion[0] == '\0' || feature.info.compatibility[0] == '\0' ||
            feature.info.featureVersion[0] == '\0' || feature.info.infoLog[0] == '\0', return false,
            "V1 function initialization failed. Member fields are empty.");
    }
    MSPROF_LOGI("All feature checks are successful.");
    return true;
}

FeatureRecord* FeatureManager::GetIncompatibleFeatures(size_t *featuresSize, bool isV2) const
{
    MSPROF_LOGD("Start to obtain the address information of the feature.");
    FUNRET_CHECK_EXPR_ACTION(featuresSize == nullptr, return nullptr,
        "Input parameter featuresSize for GetIncompatibleFeatures is nullptr.");

    auto &feature = GetCurPlatformFeatures(isV2);
    *featuresSize = feature.size();
    MSPROF_LOGD("Stop to obtain the address information of the feature.");
    return feature.data();
}

void FeatureManager::Uninit()
{
    isInit_ = false;
}
 
}  // namespace Config
}  // namespace Comon
}  // namespace Dvvp
}  // namespace Analysis