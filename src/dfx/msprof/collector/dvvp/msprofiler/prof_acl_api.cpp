/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_acl_api.h"
#include <cstdlib>
#include <unordered_set>
#include <vector>
#include "acl/acl_prof.h"
#include "msprof_dlog.h"
#include "errno/error_code.h"
#include "prof_acl_intf.h"
#include "prof_inner_api.h"
#include "prof_api_runtime.h"
#include "config/config.h"
#include "msprof_error_manager.h"
#include "securec.h"
#include "utils/utils.h"
#include "mmpa_api.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::utils;
using namespace Msprof::Engine::Intf;

struct aclprofConfig {
    ProfConfig config;
};
using ACL_PROF_CONFIG_PTR = aclprofConfig *;
using ACL_PROF_CONFIG_CONST_PTR = const aclprofConfig *;

aclError aclprofInit(const char *profilerResultPath, size_t length)
{
    std::string envStr;
    MSPROF_GET_ENV(MM_ENV_PROFILING_MODE, envStr);
    if (!envStr.empty() && DYNAMIC_PROFILING_VALUE.compare(envStr) == 0) {
        MSPROF_EVENT("acl api not support in dynamic profiling mode");
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }
    return ProfAclInit(ACL_API_TYPE, profilerResultPath, length);
}

aclError aclprofFinalize()
{
    return ProfAclFinalize(ACL_API_TYPE);
}

namespace {
constexpr size_t CONFIG_MAX_LENGTH = 256;
bool IsValidProfConfigPreCheck(
    const uint32_t *deviceIdList, uint32_t deviceNums, const aclprofAicoreEvents *aicoreEvents)
{
    if (deviceNums != 0 && deviceIdList == nullptr) {
        MSPROF_LOGE("deviceIdList is nullptr");
        MSPROF_INPUT_ERROR("EK0006", std::vector<std::string>({"api", "param"}),
            std::vector<std::string>({"aclprofCreateConfig", "deviceIdList"}));
        return false;
    }

    if (aicoreEvents != nullptr) {
        MSPROF_LOGE("aicoreEvents must be nullptr");
        MSPROF_INPUT_ERROR("EK0001",
            std::vector<std::string>({"value", "param", "reason"}),
            std::vector<std::string>({"*aicoreEvents", "aicoreEvents", "The value of aicoreEvents must be nullptr"}));
        return false;
    }

    if (deviceNums > PROF_MAX_DEV_NUM) {
        MSPROF_LOGE("The device nums is invalid.");
        std::string errorReason = "The device number should be less than " + std::to_string(PROF_MAX_DEV_NUM);
        MSPROF_INPUT_ERROR("EK0001",
            std::vector<std::string>({"value", "param", "reason"}),
            std::vector<std::string>({std::to_string(deviceNums), "deviceNums", errorReason}));
        return false;
    }
    return true;
}

bool IsValidDevId(const uint32_t *deviceIdList, uint32_t deviceNums)
{
    // real device num
    const int32_t devCount = ProfAclDrvGetDevNum();
    if (devCount == PROFILING_FAILED) {
        MSPROF_LOGE("Get the Device count fail.");
        return false;
    }

    if (deviceNums > static_cast<uint32_t>(devCount)) {
        MSPROF_LOGE("Device num(%u) is not in range 1 ~ %d.", deviceNums, devCount);
        std::string errorReason = "The device number should be in range [1, " + std::to_string(devCount) + "]";
        MSPROF_INPUT_ERROR("EK0001",
            std::vector<std::string>({"value", "param", "reason"}),
            std::vector<std::string>({std::to_string(deviceNums), "deviceNums", errorReason}));
        return false;
    }

    std::unordered_set<uint32_t> record;
    for (size_t i = 0; i < deviceNums; ++i) {
        uint32_t devId = deviceIdList[i];
        if (devId >= static_cast<uint32_t>(devCount)) {
            MSPROF_LOGE(
                "[IsValidProfConfig]Device id %u is not in range 0 ~ %d(exclude %d)", devId, devCount, devCount);
            std::string errorReason = "The device id should be in range [0," + std::to_string(devCount) + "]";
            MSPROF_INPUT_ERROR("EK0001",
                std::vector<std::string>({"value", "param", "reason"}),
                std::vector<std::string>({std::to_string(devId), "device id", errorReason}));
            return false;
        }
        if (record.count(devId) > 0) {
            MSPROF_LOGE("[IsValidProfConfig]Device id %u is duplicatedly set", devId);
            std::string errorReason = "device id is duplicatedly set";
            MSPROF_INPUT_ERROR("EK0001",
                std::vector<std::string>({"value", "param", "reason"}),
                std::vector<std::string>({std::to_string(devId), "device id", errorReason}));
            return false;
        }
        record.insert(devId);
    }
    return true;
}

bool IsValidProfConfig(const uint32_t *deviceIdList, uint32_t deviceNums, const aclprofAicoreEvents *aicoreEvents)
{
    if (!IsValidProfConfigPreCheck(deviceIdList, deviceNums, aicoreEvents)) {
        return false;
    }
    if (!IsValidDevId(deviceIdList, deviceNums)) {
        return false;
    }
    return true;
}

static bool AlterLogicDeviceId(const uint32_t *deviceIdList, uint32_t deviceNums, ACL_PROF_CONFIG_PTR profCfg)
{
    ProfRtAPI::ExtendPlugin::instance()->RuntimeApiInit();
    for (uint32_t i = 0; i < deviceNums; i++) {
        int32_t visibleDevId = 0;
        int32_t ret = ProfRtAPI::ExtendPlugin::instance()->ProfGetVisibleDeviceIdByLogicDeviceId(static_cast<int32_t>(
            deviceIdList[i]),  &visibleDevId);
        if (ret == PROFILING_NOTSUPPORT) {
            MSPROF_LOGI("ProfGetVisibleDeviceIdByLogicDeviceId is not support, using logic devId");
            if (memcpy_s(profCfg->config.devIdList, sizeof(profCfg->config.devIdList),
                deviceIdList, deviceNums * sizeof(uint32_t)) != EOK) {
                MSPROF_LOGE("copy devID failed. size = %u", deviceNums);
                return false;
            }
            return true;
        } else if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("get visible devID failed, logic devId = %d", deviceIdList[i]);
            return false;
        }
        MSPROF_LOGI("Get visible devID = %d", visibleDevId);
        profCfg->config.devIdList[i] = static_cast<uint32_t>(visibleDevId);
    }
    if (!IsValidDevId(profCfg->config.devIdList, deviceNums)) {
        return false;
    }
    return true;
}
}  // namespace

ACL_PROF_CONFIG_PTR aclprofCreateConfig(uint32_t *deviceIdList, uint32_t deviceNums,
    aclprofAicoreMetrics aicoreMetrics, const aclprofAicoreEvents *aicoreEvents, uint64_t dataTypeConfig)
{
    if (!IsValidProfConfig(deviceIdList, deviceNums, aicoreEvents)) {
        return nullptr;
    }
    if ((deviceNums == 0) && (dataTypeConfig & PROF_MSPROFTX_MASK) == 0) {
        return nullptr;
    }

    ACL_PROF_CONFIG_PTR profConfig = new (std::nothrow) aclprofConfig();
    if (profConfig == nullptr) {
        MSPROF_LOGE("new aclprofConfig fail");
        MSPROF_ENV_ERROR("EK0201",
            std::vector<std::string>({"buf_size"}),
            std::vector<std::string>({std::to_string(sizeof(aclprofConfig))}));
        return nullptr;
    }
    profConfig->config.aicoreMetrics = static_cast<ProfAicoreMetrics>(aicoreMetrics);
    profConfig->config.dataTypeConfig = dataTypeConfig | PROF_AICPU_MODEL;

    profConfig->config.devNums = deviceNums;
    if (deviceNums != 0) {
        if (!AlterLogicDeviceId(deviceIdList, deviceNums, profConfig)) {
            MSPROF_LOGE("get visible devID failed");
            delete profConfig;
            return nullptr;
        }
    }

    if ((dataTypeConfig & PROF_TASK_TIME_L1_MASK) != 0) {  // 采集task time L1，同时配置task time L0
        profConfig->config.dataTypeConfig |= PROF_TASK_TIME;
    }
    // 采集task time L2 或 op attr，同时配置task time L0, L1
    if ((dataTypeConfig & PROF_TASK_TIME_L2_MASK) != 0 || (dataTypeConfig & PROF_OP_ATTR_MASK) != 0) {
        profConfig->config.dataTypeConfig |= PROF_TASK_TIME | PROF_TASK_TIME_L1;
    }
    // 采集task time L3, 同时配置task time L0, L1, L2
    if ((dataTypeConfig & PROF_TASK_TIME_L3_MASK) != 0) {
        profConfig->config.dataTypeConfig |= PROF_TASK_TIME | PROF_TASK_TIME_L1 | PROF_TASK_TIME_L2;
    }
    profConfig->config.devIdList[profConfig->config.devNums] = PROF_DEFAULT_HOST_ID;
    profConfig->config.devNums++;
    MSPROF_LOGI("Successfully create prof config");
    return profConfig;
}

aclError aclprofDestroyConfig(ACL_PROF_CONFIG_CONST_PTR profilerConfig)
{
        if (profilerConfig == nullptr) {
            MSPROF_LOGE("destroy profilerConfig failed, profilerConfig must not be nullptr");
            std::string errorReason = "profilerConfig can not be nullptr";
            MSPROF_INPUT_ERROR("EK0006", std::vector<std::string>({"api", "param"}),
                std::vector<std::string>({"aclprofDestroyConfig", "profilerConfig"}));
            return ACL_ERROR_INVALID_PARAM;
        }
        try {
            delete profilerConfig;
        } catch(const std::string& error_msg) {
            MSPROF_LOGE("destroy profilerConfig failed, %s", error_msg.c_str());
            return ACL_ERROR_INVALID_PARAM;
        }
        MSPROF_LOGI("Successfully destroy prof config");
        return ACL_SUCCESS;
}

aclError aclprofWarmup(ACL_PROF_CONFIG_CONST_PTR profilerConfig)
{
    if (profilerConfig == nullptr) {
        MSPROF_LOGE("Param profilerConfig is nullptr");
        MSPROF_INPUT_ERROR("EK0006", std::vector<std::string>({"api", "param"}),
            std::vector<std::string>({"aclprofStart", "profilerConfig"}));
        return ACL_ERROR_INVALID_PARAM;
    }
    return ProfAclWarmup(ACL_API_TYPE, &profilerConfig->config);
}

aclError aclprofStart(ACL_PROF_CONFIG_CONST_PTR profilerConfig)
{
    if (profilerConfig == nullptr) {
        MSPROF_LOGE("Param profilerConfig is nullptr");
        MSPROF_INPUT_ERROR("EK0006", std::vector<std::string>({"api", "param"}),
            std::vector<std::string>({"aclprofStop", "profilerConfig"}));
        return ACL_ERROR_INVALID_PARAM;
    }
    return ProfAclStart(ACL_API_TYPE, &profilerConfig->config);
}

aclError aclprofStop(ACL_PROF_CONFIG_CONST_PTR profilerConfig)
{
    if (profilerConfig == nullptr) {
        MSPROF_LOGE("Param profilerConfig is nullptr");
        MSPROF_INPUT_ERROR("EK0001",
            std::vector<std::string>({"value", "param", "reason"}),
            std::vector<std::string>({"nullptr", "profilerConfig", "Prof config can not be nullptr"}));
        return ACL_ERROR_INVALID_PARAM;
    }
    return ProfAclStop(ACL_API_TYPE, &profilerConfig->config);
}

/**
 * @brief profiler layer of aclprofSetConfig, not support in hisi pack now
 * @param configType [IN] config type
 * @param val [IN] pointer to config
 * @param valLen [IN] length of config
 */
aclError aclprofSetConfig(aclprofConfigType configType, const char *config, size_t configLength)
{
    if (configType <= ACL_PROF_ARGS_MIN || configType >= ACL_PROF_ARGS_MAX) {
        MSPROF_LOGE("[aclprofSetConfig]ConfigType %d is not support.", static_cast<int32_t>(configType));
        return ACL_ERROR_INVALID_PARAM;
    }
    if (configLength > CONFIG_MAX_LENGTH) {
        MSPROF_LOGE("length of config is illegal, the value is %zu, it should be in (0, %zu)",
                    configLength, CONFIG_MAX_LENGTH);
        return ACL_ERROR_INVALID_PARAM;
    }
    if (config == nullptr || std::strlen(config) != configLength) {
        MSPROF_LOGE("[aclprofSetConfig]Input value is nullptr or its length does not equal to given length.");
        return ACL_ERROR_INVALID_PARAM;
    }

    return ProfAclSetConfig(configType, config, configLength);
}

int32_t aclprofGetSupportedFeatures(size_t *featuresSize, void **featuresData)
{
    if (featuresData == nullptr || *featuresData != nullptr || featuresSize == nullptr) {
        MSPROF_LOGE("Features data or size is null.");
        return ACL_ERROR_INVALID_PARAM;
    }
    return ProfAclGetCompatibleFeatures(featuresSize, featuresData);
}

int32_t aclprofGetSupportedFeaturesV2(size_t *featuresSize, void **featuresData)
{
    if (featuresData == nullptr || *featuresData != nullptr || featuresSize == nullptr) {
        MSPROF_LOGE("Features data or size is null.");
        return ACL_ERROR_INVALID_PARAM;
    }
    return ProfAclGetCompatibleFeaturesV2(featuresSize, featuresData);
}

int aclprofRegisterDeviceCallback()
{
    return ProfAclRegisterDeviceCallback();
}