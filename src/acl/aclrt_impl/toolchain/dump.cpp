/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dump.h"

#include <mutex>
#include <sstream>
#include <set>

#include "mmpa/mmpa_api.h"
#include "adx_datadump_server.h"
#include "adump_pub.h"

#include "common/json_parser.h"
#include "common/error_codes_inner.h"

#include "common/log_inner.h"
#include "utils/string_utils.h"
#include "aclrt_impl/acl_rt_impl_base.h"
#include "acl/acl_rt_impl.h"

namespace {
    bool aclmdlInitDumpFlag = false;
    std::mutex aclDumpMutex;
    constexpr int32_t ADX_ERROR_NONE = 0;
}

namespace acl {
    AclDump &AclDump::GetInstance()
    {
        static AclDump aclDumpProc;
        return aclDumpProc;
    }

    aclError AclDump::HandleDumpCommand(const char *configStr, size_t size)
    {
        ACL_LOG_INFO("start to execute HandleDumpCommand.");

        int32_t adxRet = AdxDataDumpServerInit();
        if (adxRet != ADX_ERROR_NONE) {
            ACL_LOG_INNER_ERROR("[AdxDataDumpServer][Init]dump server run failed, adx errorCode = %d", adxRet);
            return ACL_ERROR_INTERNAL_ERROR;
        }
        acl::AclDump::GetInstance().SetAdxInitFromAclInitFlag(true);

        // base dump
        adxRet = Adx::AdumpSetDump(configStr, size);
        if (adxRet != ADX_ERROR_NONE) {
            auto ret =
                (adxRet == Adx::ADUMP_INPUT_FAILED) ? ACL_ERROR_INVALID_DUMP_CONFIG : ACL_ERROR_INTERNAL_ERROR;
            ACL_LOG_INNER_ERROR("[Set][Dump]set dump config failed, adx errorCode = %d", adxRet);
            return ret;
        }

        return ACL_SUCCESS;
    }

    aclError AclDump::HandleDumpConfig(const char_t *const configPath)
    {
        ACL_LOG_INFO("start to execute HandleDumpConfig.");
        std::string configStr;
        aclError ret = acl::JsonParser::GetConfigStrFromFile(configPath, configStr);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_INNER_ERROR("Get config string from file[%s] failed, errorCode = %d",
                configPath, ret);
            return ret;
        }
        try {
            if (!configStr.empty()) {
                return HandleDumpCommand(configStr.c_str(), configStr.size());
            }
        } catch (const nlohmann::json::exception &e) {
            ACL_LOG_INNER_ERROR("[Convert][DumpConfig]parse json for config failed, exception:%s.",
                e.what());
            return ACL_ERROR_INVALID_DUMP_CONFIG;
        }
        ACL_LOG_INFO("HandleDumpConfig end in HandleDumpConfig.");
        return ACL_SUCCESS;
    }
} // namespace acl

aclError aclmdlInitDumpImpl()
{
    ACL_LOG_INFO("start to execute aclmdlInitDump.");
    if (!acl::GetAclInitFlag()) {
        ACL_LOG_INNER_ERROR("[Check][AclInitFlag]aclmdlInitDump is not supported because it does not execute aclInit");
        return ACL_ERROR_UNINITIALIZE;
    }

    const std::unique_lock<std::mutex> lk(aclDumpMutex);
    if (aclmdlInitDumpFlag) {
        ACL_LOG_INNER_ERROR("[Check][InitDumpFlag]repeatedly initialized dump in aclmdlInitDump, "
            "only initialized once");
        return ACL_ERROR_REPEAT_INITIALIZE;
    }

    const int32_t adxRet = AdxDataDumpServerInit();
    if (adxRet != ADX_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("[AdxDataDumpServer][Init]dump server run failed, adx errorCode = %d", adxRet);
        return ACL_ERROR_INTERNAL_ERROR;
    }

    aclmdlInitDumpFlag = true;
    ACL_LOG_INFO("successfully initialized dump in aclmdlInitDump.");
    return ACL_SUCCESS;
}

aclError aclmdlSetDumpImpl(const char *dumpCfgPath)
{
    ACL_LOG_INFO("start to execute aclmdlSetDump.");
    if (!acl::GetAclInitFlag()) {
        ACL_LOG_INNER_ERROR("[Check][AclInitFlag]aclmdlSetDump is not supported because it does not execute aclInit");
        return ACL_ERROR_UNINITIALIZE;
    }

    const std::unique_lock<std::mutex> lk(aclDumpMutex);
    if (!aclmdlInitDumpFlag) {
        ACL_LOG_INNER_ERROR("[Check][aclmdlInitDumpFlag]dump is not initialized in aclmdlInitDump");
        return ACL_ERROR_DUMP_NOT_RUN;
    }

    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(dumpCfgPath);
    std::string configStr;
    aclError ret = acl::JsonParser::GetConfigStrFromFile(dumpCfgPath, configStr);
    if (ret != ACL_SUCCESS) {
        ACL_LOG_INNER_ERROR("Get config string from file[%s] failed, errorCode = %d",
            dumpCfgPath, ret);
        return ret;
    }

    // base dump
    if (!configStr.empty()) {
        ACL_LOG_INFO("Start to set dump.");
        const auto adxRet = Adx::AdumpSetDump(configStr.c_str(), configStr.size());
        if (adxRet != ADX_ERROR_NONE) {
            ret =
                (adxRet == Adx::ADUMP_INPUT_FAILED) ? ACL_ERROR_INVALID_DUMP_CONFIG : ACL_ERROR_INTERNAL_ERROR;
            ACL_LOG_INNER_ERROR("[Set][Dump]set dump config failed, adx errorCode = %d", adxRet);
            return ret;
        }
    }
    ACL_LOG_INFO("set dump config successfully.");
    return ACL_SUCCESS;
}

aclError aclmdlFinalizeDumpImpl()
{
    ACL_LOG_INFO("start to execute aclmdlFinalizeDump.");
    if (!acl::GetAclInitFlag()) {
        ACL_LOG_INNER_ERROR("[Check][AclInitFlag]aclmdlFinalizeDump is not supported because it does not "
            "execute aclInit");
        return ACL_ERROR_UNINITIALIZE;
    }

    const std::unique_lock<std::mutex> lk(aclDumpMutex);
    if (!aclmdlInitDumpFlag) {
        ACL_LOG_INNER_ERROR("[Check][aclmdlInitDumpFlag]dump is not initialized in aclmdlInitDump");
        return ACL_ERROR_DUMP_NOT_RUN;
    }

    // close adump opened
    int32_t adxRet = Adx::AdumpUnSetDump();
    if (adxRet != ADX_ERROR_NONE) {
        ACL_LOG_INNER_ERROR("[Set][Dump]set dump off failed, adx errorCode = %d", adxRet);
        return ACL_ERROR_INTERNAL_ERROR;
    }

    // close dump server
    adxRet = AdxDataDumpServerUnInit();
    if (adxRet != ADX_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("[AdxDataDumpServer][UnInit]generate dump file failed in disk, adx errorCode = %d", adxRet);
        return ACL_ERROR_INTERNAL_ERROR;
    }

    aclmdlInitDumpFlag = false;
    ACL_LOG_INFO("successfully execute aclmdlFinalizeDump, the dump task completed!");
    return ACL_SUCCESS;
}
