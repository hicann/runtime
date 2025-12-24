/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_COMMON_CONFIG_FEATURE_MANAGER_H
#define ANALYSIS_DVVP_COMMON_CONFIG_FEATURE_MANAGER_H
#include <vector>
#include <algorithm>
#include "singleton/singleton.h"
#include "msprof_dlog.h"
#include "utils/utils.h"

namespace Analysis {
namespace Dvvp {
namespace Common {
namespace Config {
using namespace analysis::dvvp::common::utils;
struct FeatureInfo {
    char compatibility[16]; /* Indicates whether the feature is supported. The value 0 indicates that the feature
        is compatible, and the value 1 indicates that the feature is not supported.*/
    char featureVersion[16]; /* Version number supported by the feature. Currently, the number indicates 1, 2, and 3.
        The version number will be maintained together with MindStudio profiling. */
    char affectedComponent[16]; /* Indicates the affected components. The value "all" indicates all components. Special
        components include "pta" etc. The components are maintained together with MindStudio profiling.*/
    char affectedComponentVersion[16]; /* Affected components version. The value "all" indicates all versions,
        which will be maintained together with MindStudio profiling. */
    char infoLog[128]; // Logs are displayed when the function is not supported.
    FeatureInfo() = default;
    virtual ~FeatureInfo() {}
};

struct FeatureRecord {
    char featureName[64]; // feature's name
    FeatureInfo info;
    FeatureRecord() = default;
    FeatureRecord(std::string tempFeatureName, std::string tempCompatibility, std::string tempFeatureVersion,
                  std::string tempAffectedComponent, std::string tempAffectedComponentVersion,
                  std::string tempInfoLog) noexcept
    {
        // This section does not care about the result of strcpy and performs empty verification before using it.
        auto ret = strcpy_s(featureName, sizeof(featureName), tempFeatureName.c_str());
        FUNRET_CHECK_EXPR_PRINT(ret != EOK, "Failed to copy feature name %s to struct and ret is %d",
            tempFeatureName.c_str(), ret);
        ret = strcpy_s(info.compatibility, sizeof(info.compatibility), tempCompatibility.c_str());
        FUNRET_CHECK_EXPR_PRINT(ret != EOK, "Failed to copy compatibility %s to struct and ret is %d",
            tempCompatibility.c_str(), ret);
        ret = strcpy_s(info.featureVersion, sizeof(info.featureVersion), tempFeatureVersion.c_str());
        FUNRET_CHECK_EXPR_PRINT(ret != EOK, "Failed to copy featureVersion %s to struct and ret is %d",
            tempFeatureVersion.c_str(), ret);
        ret = strcpy_s(info.affectedComponent, sizeof(info.affectedComponent), tempAffectedComponent.c_str());
        FUNRET_CHECK_EXPR_PRINT(ret != EOK, "Failed to copy affectedComponent %s to struct and ret is %d",
            tempAffectedComponent.c_str(), ret);
        ret = strcpy_s(info.affectedComponentVersion, sizeof(info.affectedComponentVersion),
            tempAffectedComponentVersion.c_str());
        FUNRET_CHECK_EXPR_PRINT(ret != EOK, "Failed to copy affectedComponentVersion %s to struct and ret is %d",
            tempFeatureName.c_str(), ret);
        ret = strcpy_s(info.infoLog, sizeof(info.infoLog), tempInfoLog.c_str());
        FUNRET_CHECK_EXPR_PRINT(ret != EOK, "Failed to copy log info %s to struct and ret is %d",
            tempInfoLog.c_str(), ret);
    }
    virtual ~FeatureRecord() {}
};

class FeatureManager : public analysis::dvvp::common::singleton::Singleton<FeatureManager> {
public:
    FeatureManager();
    ~FeatureManager() override;
    int32_t Init();
    void Uninit();
    FeatureRecord* GetIncompatibleFeatures(size_t *featuresSize, bool isV2 = true) const;
private:
    bool CheckCreateFeatures() const;
private:
    bool isInit_ = false;
};

}  // namespace Config
}  // namespace Comon
}  // namespace Dvvp
}  // namespace Analysis
#endif // ANALYSIS_DVVP_COMMON_CONFIG_FEATURE_MANAGER_H