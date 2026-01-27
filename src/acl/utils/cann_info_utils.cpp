/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "utils/cann_info_utils.h"

#include <fstream>
#include "acl_rt_impl.h"
#include "utils/file_utils.h"
#include "common/json_parser.h"

namespace acl {
    namespace {
#if defined(ONLY_ENABLE_ACL_UT)
        constexpr const char_t *const SW_CONFIG_FILE = "tmp_run_data/ascendcl_config/swFeatureList.json";
        constexpr const char_t *const RUNTIME_VERSION_PATH = "tests/tmp_run_data/share/info/runtime/version.info";
#else
        constexpr const char_t *const SW_CONFIG_FILE = "data/ascendcl_config/swFeatureList.json";
        constexpr const char_t *const RUNTIME_VERSION_PATH = "share/info/runtime/version.info";
#endif
        constexpr const char_t *const VERSION_INFO_KEY = "Version=";
    } // namespace

    std::mutex CannInfoUtils::mutex_;
    bool CannInfoUtils::initFlag_ = false;
    int32_t CannInfoUtils::currentRuntimeVersion_ = UNKNOWN_VERSION;
    std::string CannInfoUtils::swConfigPath_;
    std::string CannInfoUtils::defaultInstallPath_;
    aclCannAttr CannInfoUtils::attrArray_[MAX_CANN_ATTR_SIZE];
    size_t CannInfoUtils::attrNum_ = 0;

    std::map<aclCannAttr, CannInfo> CannInfoUtils::attrToCannInfo_ = {
        {ACL_CANN_ATTR_INF_NAN, CannInfo("INF_NAN", "SoCInfo", "support_inf_nan")},
        {ACL_CANN_ATTR_BF16, CannInfo("BF16", "SoCInfo", "support_bf16")},
        {ACL_CANN_ATTR_JIT_COMPILE, CannInfo("JIT_COMPILE", "", "")},
    };

    aclError CannInfoUtils::GetAttributeList(const aclCannAttr **cannAttr, size_t *num)
    {
        const aclError ret = Initialize();
        if (ret != ACL_SUCCESS) {
            ACL_LOG_INNER_ERROR("initialize CannInfoUtils failed, ret = %d", static_cast<int32_t>(ret));
            return ret;
        }
        *cannAttr = attrArray_;
        *num = attrNum_;
        return ACL_SUCCESS;
    }

    aclError CannInfoUtils::GetAttribute(aclCannAttr cannAttr, int32_t *value)
    {
        const aclError ret = Initialize();
        if (ret != ACL_SUCCESS) {
            ACL_LOG_INNER_ERROR("initialize CannInfoUtils failed, ret = %d", static_cast<int32_t>(ret));
            return ret;
        }

        auto iter = attrToCannInfo_.find(cannAttr);
        if (iter == attrToCannInfo_.end()) {
            ACL_LOG_WARN("find cann attr failed, attr value = %d", static_cast<int32_t>(cannAttr));
            return ACL_ERROR_INVALID_PARAM;
        }
        *value = iter->second.isAvailable;
        return ACL_SUCCESS;
    }

    aclError CannInfoUtils::Initialize()
    {
        std::lock_guard<std::mutex> lock(mutex_);
        if (initFlag_) {
            ACL_LOG_INFO("CannInfoUtils has already initialized.");
            return ACL_SUCCESS;
        }
        ACL_LOG_INFO("Start to initialize CannInfoUtils.");
        // init config path and CANN install path
        auto ret = GetConfigInstallPath();
        if (ret != ACL_SUCCESS) {
            ACL_LOG_INNER_ERROR("failed to get swFeatureList.json, please check ascendcl_config path!");
            return ret;
        }

        // parse requirments of each attributes
        ret = JsonParser::GetAttrConfigFromFile(swConfigPath_.c_str(), attrToCannInfo_);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_INNER_ERROR("failed to parse requirements of Cann attrs, ret = %d", ret);
            return ret;
        }

        // parse current CannInfo
        const std::string runtimeVersionPath = defaultInstallPath_ + RUNTIME_VERSION_PATH;
        ret = ParseVersionInfo(runtimeVersionPath, &currentRuntimeVersion_);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_WARN("cannot get runtime version in current environment!");
            return ACL_ERROR_INTERNAL_ERROR;
        }

        // check and update attr availability
        CheckAndUpdateAttrAvailability();
        initFlag_ = true;
        ACL_LOG_INFO("Successfully initialized CannInfoUtils: current CannInfo[runtime = %d, attrNum = %zu]",
                     currentRuntimeVersion_, attrNum_);

        return ACL_SUCCESS;
    }

    aclError CannInfoUtils::GetConfigInstallPath()
    {
        std::string path;
        const aclError ret = file_utils::GetSoRealPath(path);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_WARN("failed to get libascendcl.so file path");
            return ret;
        }
        ACL_LOG_DEBUG("current path = %s", path.c_str());
        path = path.substr(0, path.rfind('/'));
        path = path.substr(0, path.rfind('/') + 1UL);
        swConfigPath_ = path + SW_CONFIG_FILE;
        ACL_LOG_DEBUG("swConfigPath = %s", swConfigPath_.c_str());
        path.pop_back();
        defaultInstallPath_ = path.substr(0, path.rfind('/') + 1UL);
        ACL_LOG_DEBUG("defaultInstallPath = %s", defaultInstallPath_.c_str());
        return ACL_SUCCESS;
    }

    aclError CannInfoUtils::ParseVersionInfo(const std::string &path, int32_t *version)
    {
        std::ifstream ifs(path, std::ifstream::in);
        if (!ifs.is_open()) {
            ACL_LOG_WARN("Open file [%s] failed.", path.c_str());
            return ACL_ERROR_INTERNAL_ERROR;
        }
        std::string line;
        while (std::getline(ifs, line)) {
            if (line.find(VERSION_INFO_KEY) != std::string::npos) {
                ACL_LOG_DEBUG("Parse version success, content is [%s].", line.c_str());
                ifs.close();
                const size_t prefixLen = strlen(VERSION_INFO_KEY);
                line = line.substr(prefixLen);
                const size_t pos = line.find('.', line.find('.') + 1UL);
                line = line.substr(0, pos);
                return ParseVersionValue(line, version);
            }
        }
        ifs.close();
        ACL_LOG_WARN("cannot find valid Version info, please check path = %s", path.c_str());
        return ACL_ERROR_INTERNAL_ERROR;
    }

    aclError CannInfoUtils::ParseVersionValue(const std::string &str, int32_t *value)
    {
        const size_t pos = str.find('.');
        try {
            const int32_t major = std::stoi(str.substr(0, pos));
            const int32_t minor = std::stoi(str.substr(pos + 1UL));
            *value = 1000 * major + 10 * minor;
        } catch (...) {
            ACL_LOG_WARN("strVal[%s] can not be converted to version value", str.c_str());
            return ACL_ERROR_INTERNAL_ERROR;
        }
        return ACL_SUCCESS;
    }

    bool CannInfoUtils::MatchVersionInfo(const CannInfo &configCannInfo)
    {
        // if version is not set, skip matching and return true
        if (configCannInfo.minimumRuntimeVersion == UNKNOWN_VERSION) {
            return true;
        }
        return (currentRuntimeVersion_ >= configCannInfo.minimumRuntimeVersion);
    }

    bool CannInfoUtils::CheckNPUFeatures(const CannInfo &configInfo)
    {
        if (configInfo.socSpecLabel.empty() || configInfo.socSpecKey.empty()) {
            // label 或 key 为空说明特性与芯片无关, 无需查询
            return true;
        }
        constexpr uint32_t kMaxValueLen = 16UL;
        char_t value[kMaxValueLen] = {0};
        auto ret = rtGetSocSpec(configInfo.socSpecLabel.c_str(), configInfo.socSpecKey.c_str(), value, kMaxValueLen);
        if (ret != RT_ERROR_NONE) {
            ACL_LOG_WARN("Cannot get platform info, label = [%s], key = [%s]", configInfo.socSpecLabel.c_str(),
                         configInfo.socSpecKey.c_str());
            return false;
        }
        // value "0" 或空 或非法内容 都认为 false
        const std::string strVal(value);
        return strVal == "1";
    }

    void CannInfoUtils::CheckAndUpdateAttrAvailability()
    {
        for (auto &item : attrToCannInfo_) {
            auto &swConfigInfo = item.second;
            if (MatchVersionInfo(swConfigInfo) && CheckNPUFeatures(swConfigInfo)) {
                ACL_LOG_INFO("support cann attribute [%s]", swConfigInfo.readableAttrName.c_str());
                swConfigInfo.isAvailable = 1;
                attrArray_[attrNum_] = item.first;
                ++attrNum_;
            }
        }
    }
} // namespace acl