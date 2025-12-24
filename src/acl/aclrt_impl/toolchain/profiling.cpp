/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "profiling.h"
#include "mmpa/mmpa_api.h"
#include "common/log_inner.h"
#include "common/json_parser.h"
#include "profiling_manager.h"

namespace {
    const std::string ACL_PROF_CONFIG_NAME = "profiler";
    std::mutex g_aclProfMutex;
    constexpr uint64_t ACL_PROF_ACL_API = 0x0001U;
    constexpr uint32_t START_PROFILING = 1U;
    constexpr uint32_t STOP_PROFILING = 2U;

    static aclError ProfInnerStart(const rtProfCommandHandle_t *const profilerConfig)
    {
        ACL_LOG_INFO("start to execute ProfInnerStart");
        if (!acl::AclProfilingManager::GetInstance().AclProfilingIsRun()) {
            const aclError ret = acl::AclProfilingManager::GetInstance().Init();
            if (ret != ACL_SUCCESS) {
                ACL_LOG_INNER_ERROR("[Init][ProfilingManager]start acl profiling module failed,"" errorCode = %d",
                    ret);
                return ret;
            }
        }
        (void)acl::AclProfilingManager::GetInstance().AddDeviceList(profilerConfig->devIdList, profilerConfig->devNums);
        ACL_LOG_INFO("successfully execute ProfInnerStart");
        return ACL_SUCCESS;
    }

    // inner interface for stoping profiling
    static aclError ProfInnerStop(const rtProfCommandHandle_t *const profilerConfig)
    {
        ACL_LOG_INFO("start to execute ProfInnerStop");
        if (!acl::AclProfilingManager::GetInstance().IsDeviceListEmpty()) {
            (void)acl::AclProfilingManager::GetInstance().RemoveDeviceList(profilerConfig->devIdList,
                profilerConfig->devNums);
        }

        if ((acl::AclProfilingManager::GetInstance().IsDeviceListEmpty()) &&
            (acl::AclProfilingManager::GetInstance().AclProfilingIsRun())) {
            const aclError ret = acl::AclProfilingManager::GetInstance().UnInit();
            if (ret != ACL_SUCCESS) {
                ACL_LOG_INNER_ERROR("[Uninit][ProfilingManager]stop acl failed, errorCode = %d", ret);
                return ret;
            }
        }
        ACL_LOG_INFO("successfully execute ProfInnerStop");
        return ACL_SUCCESS;
    }

    aclError ProcessProfData(void *const data, const uint32_t len)
    {
        ACL_LOG_INFO("start to execute ProcessProfData");
        const std::lock_guard<std::mutex> locker(g_aclProfMutex);
        ACL_REQUIRES_NOT_NULL(data);
        constexpr size_t commandLen = sizeof(rtProfCommandHandle_t);
        if (len < commandLen) {
            ACL_LOG_INNER_ERROR("[Check][Len]len[%u] is invalid, it should not be smaller than %zu", len, commandLen);
            return ACL_ERROR_INVALID_PARAM;
        }
        rtProfCommandHandle_t *const profilerConfig = static_cast<rtProfCommandHandle_t *>(data);
        aclError ret = ACL_SUCCESS;
        const uint64_t profSwitch = profilerConfig->profSwitch;
        const uint32_t type = profilerConfig->type;
        if (((profSwitch & ACL_PROF_ACL_API) != 0U) && (type == START_PROFILING)) {
            ret = ProfInnerStart(profilerConfig);
        }
        if (((profSwitch & ACL_PROF_ACL_API) != 0U) && (type == STOP_PROFILING)) {
            ret = ProfInnerStop(profilerConfig);
        }

        return ret;
    }
}

namespace acl {
    aclError AclProfiling::HandleProfilingCommand(const std::string &config, const bool configFileFlag,
        const bool noValidConfig)
    {
        ACL_LOG_INFO("start to execute HandleProfilingCommand");
        int32_t ret = MSPROF_ERROR_NONE;
        if (noValidConfig) {
            ret = MsprofInit(MSPROF_CTRL_INIT_DYNA, nullptr, 0U);
            if (ret != MSPROF_ERROR_NONE) {
                ACL_LOG_CALL_ERROR("[Init][Profiling]init profiling with nullptr failed, profiling errorCode = %d",
                    ret);
                return ACL_SUCCESS;
            }
        } else {
            if (configFileFlag) {
                ret = MsprofInit(MSPROF_CTRL_INIT_ACL_JSON,
                                 const_cast<char_t *>(config.c_str()),
                                 static_cast<uint32_t>(config.size()));
                if (ret != MSPROF_ERROR_NONE) {
                    ACL_LOG_CALL_ERROR("[Init][Profiling]handle json config of profiling failed, profiling "
                        "result = %d", ret);
                    return ACL_ERROR_INVALID_PARAM;
                }
            } else {
                ret = MsprofInit(MSPROF_CTRL_INIT_ACL_ENV,
                                 const_cast<char_t *>(config.c_str()),
                                 static_cast<uint32_t>(config.size()));
                if (ret != MSPROF_ERROR_NONE) {
                    ACL_LOG_CALL_ERROR("[Init][Profiling]handle env config of profiling failed, profiling "
                        "result = %d", ret);
                    return ACL_ERROR_INVALID_PARAM;
                }
            }
        }
        ACL_LOG_INFO("set profiling config successfully");
        return ACL_SUCCESS;
    }

    bool AclProfiling::GetProfilingConfigFile(std::string &fileName)
    {
        const char_t *environment = nullptr;
        MM_SYS_GET_ENV(MM_ENV_PROFILER_SAMPLECONFIG, environment);
        if (environment != nullptr) {
            ACL_LOG_INFO("get profiling config envValue[%s]", environment);
            fileName = environment;
            return true;
        }
        ACL_LOG_INFO("no profiling config file.");
        return false;
    }

    aclError AclProfiling::HandleProfilingConfig(const char_t *const configPath)
    {
        ACL_LOG_INFO("start to execute HandleProfilingConfig");
        std::string strConfig;
        bool configFileFlag = true; // flag of using config flie mode or not
        bool noValidConfig = false;
        aclError ret = ACL_SUCCESS;
        std::string envValue;
        // use profiling config from env variable if exist
        if ((GetProfilingConfigFile(envValue)) && (!envValue.empty())) {
            configFileFlag = false;
            ACL_LOG_INFO("start to use profiling config by env mode");
        }

        // use profiling config from acl.json if exist
        if (configFileFlag) {
            if ((configPath == nullptr) || (strnlen(configPath, 255U) == 0U)) {
                ACL_LOG_INFO("configPath is null, no need to do profiling.");
                noValidConfig = true;
                ret = HandleProfilingCommand(strConfig, configFileFlag, noValidConfig);
                if (ret != ACL_SUCCESS) {
                    ACL_LOG_INNER_ERROR("[Handle][Command]handle profiling command failed, errorCode = %d", ret);
                }
                return ret;
            }
            bool found = false;
            ret = acl::JsonParser::GetJsonCtxByKey(configPath, strConfig, ACL_PROF_CONFIG_NAME, found);
            if ((ret != ACL_SUCCESS) || (!found)) {
                ACL_LOG_INFO("can not parse profiling config from file[%s], errorCode = %d", configPath, ret);
                noValidConfig = true;
            }

            if (strConfig.empty()) {
                ACL_LOG_INFO("profiling config file[%s] is empty", configPath);
                noValidConfig = true;
            }

            ACL_LOG_INFO("start to use profiling config by config file mode");
        }

        ACL_LOG_INFO("ParseJsonFromFile ok in HandleProfilingConfig");
        ret = HandleProfilingCommand(strConfig, configFileFlag, noValidConfig);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_INNER_ERROR("[Handle][Command]handle profiling command failed, errorCode = %d", ret);
            return ret;
        }

        ACL_LOG_INFO("set HandleProfilingConfig success");
        return ret;
    }
    aclError AclProfCtrlHandle(uint32_t dataType, void *data, uint32_t dataLen)
    {
        ACL_REQUIRES_NOT_NULL(data);

        if (dataType == RT_PROF_CTRL_SWITCH) {
            const aclError ret = ProcessProfData(data, dataLen);
            if (ret != ACL_SUCCESS) {
                ACL_LOG_INNER_ERROR("[Process][ProfSwitch]failed to call ProcessProfData, result is %u", ret);
                return ret;
            }
        } else {
            ACL_LOG_INFO("get unsupported dataType %u while processing profiling data", dataType);
        }
        return ACL_SUCCESS;
    }
}
