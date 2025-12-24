/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ASCEND_CANN_INFO_UTILS_H
#define ASCEND_CANN_INFO_UTILS_H

#include <limits>
#include <mutex>
#include <vector>
#include <string>
#include <map>

#include "runtime/base.h"
#include "acl/acl_base.h"

namespace acl {
    constexpr const size_t MAX_CANN_ATTR_SIZE = 128U;
    // if version info is not set in swFeatureList.json, use UNKNOWN_VERSION as default value
    constexpr const int32_t UNKNOWN_VERSION = -1;
    constexpr const char_t *const SW_CONFIG_RUNTIME = "runtimeVersion";
    constexpr const char_t *const SW_CONFIG_SOC_VERSION = "socVersionList";

    struct CannInfo {
        std::string configKeyName;
        int32_t runtimeVersion;
        std::vector<std::string> socVersions;
        int32_t isAvailable = 0;
        explicit CannInfo(const std::string &name, const int32_t runtime = UNKNOWN_VERSION) noexcept
            : configKeyName(name), runtimeVersion(runtime)
        {
        }
    };

    class CannInfoUtils {
    public:
        static aclError GetAttributeList(const aclCannAttr **cannAttr, size_t *num);
        static aclError GetAttribute(aclCannAttr cannAttr, int32_t *value);
        static aclError ParseVersionValue(const std::string &str, int32_t *value);

    private:
        static aclError Initialize();
        static aclError GetConfigInstallPath();
        static aclError ParseVersionInfo(const std::string &path, int32_t *version);
        static bool MatchVersionInfo(const CannInfo &configCannInfo);
        static bool MatchSocVersion(const std::vector<std::string> &swConfigSocVersions);
        static void CheckAndUpdateAttrAvailability();

        static std::mutex mutex_;
        static bool initFlag_;
        static CannInfo currCannInfo_;
        static std::string swConfigPath_;
        static std::string defaultInstallPath_;
        static aclCannAttr attrArray_[MAX_CANN_ATTR_SIZE];
        static size_t attrNum_;
        static std::map<aclCannAttr, CannInfo> attrToCannInfo_;
    };
} // namespace acl

#endif // ASCEND_CANN_INFO_UTILS_H
