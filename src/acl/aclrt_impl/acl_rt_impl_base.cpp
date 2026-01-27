/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "acl_rt_impl_base.h"
#include <mutex>
#include <string>
#include <fstream>
#include <sstream>
#include <map>
#include <unordered_set>
#include <string>
#include "runtime/dev.h"
#include "acl_rt_impl.h"
#include "acl/acl_base.h"
#include "common/log_inner.h"
#include "common/error_codes_inner.h"
#include "platform/platform_info.h"
#include "runtime/config.h"

namespace {
std::mutex aclSocVersionMutex;
std::string aclSocVersion;
constexpr size_t SOC_VERSION_LEN = 128U;
std::recursive_mutex aclInitMutex;
uint64_t aclInitRefCount = 0;
std::string aclConfigStr;
}

namespace acl {
    constexpr int32_t MODULE_TYPE_VECTOR_CORE = 7;
    constexpr int32_t MODULE_TYPE_AICORE = 4;
    constexpr int32_t INFO_TYPE_CORE_NUM = 3;
    std::mutex g_platformInfoInitMutex;
    std::unordered_set<int32_t> g_platformInfoInitSet;

    aclError UpdatePlatformInfoWithDevice(int32_t deviceId)
    {
#ifdef __GNUC__
        // init platform info
        const char *socName = aclrtGetSocNameImpl();
        if (socName == nullptr) {
            ACL_LOG_ERROR("Init SocVersion failed");
            return ACL_ERROR_INTERNAL_ERROR;
        }
        const std::string socVersion(socName);
        if (fe::PlatformInfoManager::GeInstance().InitRuntimePlatformInfos(socVersion) != 0U) {
            ACL_LOG_WARN("[Init][PlatformInfo]init runtime platform info unsuccessfully, SocVersion = %s",
                         socVersion.c_str());
            return ACL_ERROR_INTERNAL_ERROR;
        }

        const std::unique_lock<std::mutex> lk(g_platformInfoInitMutex);
        if (g_platformInfoInitSet.count(deviceId) > 0U) {
            return ACL_SUCCESS;
        }

        uint32_t aicCnt = 0U;
        auto rtErr = rtGetAiCoreCount(&aicCnt);
        if (rtErr != RT_ERROR_NONE) {
            ACL_LOG_WARN("get aicore count unsuccessfully, runtime result = %d", static_cast<int32_t>(rtErr));
            return ACL_GET_ERRCODE_RTS(rtErr);
        }

        int64_t vecCoreCnt = 0U;
        // some chips has no vector core
        rtErr = rtGetDeviceInfo(static_cast<uint32_t>(deviceId), MODULE_TYPE_VECTOR_CORE,
                                INFO_TYPE_CORE_NUM, &vecCoreCnt);
        if (rtErr != RT_ERROR_NONE) {
            ACL_LOG_WARN("get vector core count unsuccessfully, runtime result = %d", static_cast<int32_t>(rtErr));
            return ACL_GET_ERRCODE_RTS(rtErr);
        }

        int64_t cubeCoreCnt = 0U;
        rtErr = rtGetDeviceInfo(static_cast<uint32_t>(deviceId), MODULE_TYPE_AICORE,
                                INFO_TYPE_CUBE_NUM, &cubeCoreCnt);
        if (rtErr != RT_ERROR_NONE) {
            ACL_LOG_WARN("get cube core count unsuccessfully, runtime result = %d", static_cast<int32_t>(rtErr));
            return ACL_GET_ERRCODE_RTS(rtErr);
        }

        fe::PlatFormInfos platformInfos;
        uint32_t platformRet =
            fe::PlatformInfoManager::GeInstance().GetRuntimePlatformInfosByDevice(deviceId, platformInfos);
        if (platformRet != 0U) {
            ACL_LOG_WARN("get runtime platformInfos by device unsuccessfully, deviceId = %d", deviceId);
            return ACL_ERROR_INTERNAL_ERROR;
        }

        const std::string socInfoKey = "SoCInfo";
        const std::string aicCntKey = "ai_core_cnt";
        const std::string vecCoreCntKey = "vector_core_cnt";
        const std::string cubeCoreCntKey = "cube_core_cnt";
        std::map<std::string, std::string> res;
        if (!platformInfos.GetPlatformResWithLock(socInfoKey, res)) {
            ACL_LOG_WARN("unable to get platform result");
            return ACL_ERROR_INTERNAL_ERROR;
        }

        res[aicCntKey] = std::to_string(aicCnt);
        res[vecCoreCntKey] = std::to_string(vecCoreCnt);
        res[cubeCoreCntKey] = std::to_string(cubeCoreCnt);
        platformInfos.SetPlatformResWithLock(socInfoKey, res);
        platformRet =
            fe::PlatformInfoManager::GeInstance().UpdateRuntimePlatformInfosByDevice(deviceId, platformInfos);
        if (platformRet != 0U) {
            ACL_LOG_WARN("update runtime platformInfos by device unsuccessfully, deviceId = %d", deviceId);
            return ACL_ERROR_INTERNAL_ERROR;
        }
        (void)g_platformInfoInitSet.emplace(deviceId);
        ACL_LOG_INFO("Successfully to UpdatePlatformInfoWithDevice, deviceId = %d, aicCnt = %u, vecCoreCnt = %ld, "
                     "cubeCoreCnt = %ld", deviceId, aicCnt, vecCoreCnt, cubeCoreCnt);
#endif
        return ACL_SUCCESS;
    }

aclError InitSocVersion()
{
    const std::unique_lock<std::mutex> lk(aclSocVersionMutex);
    if (aclSocVersion.empty()) {
        // get socVersion
        char_t socVersion[SOC_VERSION_LEN] = {};
        const auto rtErr = rtGetSocVersion(socVersion, static_cast<uint32_t>(sizeof(socVersion)));
        if (rtErr != RT_ERROR_NONE) {
            ACL_LOG_INFO("can not get soc version, runtime errorCode is %d", static_cast<int32_t>(rtErr));
            return ACL_GET_ERRCODE_RTS(rtErr);
        }
        aclSocVersion = std::string(socVersion);
    }
    ACL_LOG_INFO("get SocVersion success, SocVersion = %s", aclSocVersion.c_str());
    return ACL_SUCCESS;
}

const std::string &GetSocVersion()
{
    ACL_LOG_INFO("socVersion is %s", aclSocVersion.c_str());
    return aclSocVersion;
}

bool GetAclInitFlag()
{
    return aclInitRefCount > 0UL;
}

uint64_t &GetAclInitRefCount()
{
    return aclInitRefCount;
}

std::recursive_mutex &GetAclInitMutex()
{
    return aclInitMutex;
}

std::string &GetConfigPathStr()
{
    return aclConfigStr;
}

void SetConfigPathStr(std::string &configStr)
{
    aclConfigStr = configStr;
}

aclError GetStrFromConfigPath(const char *configPath, std::string &configStr) {
    // 文件路径为空，按照空文件处理
    if (configPath != nullptr && strlen(configPath) != 0UL) {
        char_t realPath[MMPA_MAX_PATH] = {};
        if (mmRealPath(configPath, realPath, MMPA_MAX_PATH) != EN_OK) {
            ACL_LOG_ERROR("Invalid file: %s", configPath);
            return ACL_ERROR_INVALID_FILE;
        }
        std::ifstream file(realPath, std::ios::binary);
        if (!file.is_open()) {
            ACL_LOG_ERROR("Failed to open file: %s", configPath);
            return ACL_ERROR_INVALID_FILE;
        }

        std::stringstream buffer;
        buffer << file.rdbuf();
        configStr = buffer.str();
        file.close();  // 显式关闭文件
    }
    return ACL_SUCCESS;
}
} // namespace acl

const char *aclrtGetSocNameImpl()
{
    ACL_LOG_INFO("start to execute aclrtGetSocName.");
    // get socVersion
    const auto ret = acl::InitSocVersion();
    if (ret != ACL_SUCCESS) {
        ACL_LOG_INFO("can not init soc version, errorCode = %d", ret);
        return nullptr;
    }
    ACL_LOG_INFO("execute aclrtGetSocName successfully");
    return aclSocVersion.c_str();
}

aclError aclrtGetVersionImpl(int32_t *majorVersion, int32_t *minorVersion, int32_t *patchVersion)
{
    ACL_LOG_INFO("start to execute aclrtGetVersion.");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(majorVersion);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(minorVersion);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(patchVersion);

    // Acl version is (*majorVersion).(*minorVersion).(*patchVersion)
    *majorVersion = ACL_MAJOR_VERSION;
    *minorVersion = ACL_MINOR_VERSION;
    *patchVersion = ACL_PATCH_VERSION;
    ACL_LOG_INFO("acl version is %d.%d.%d", *majorVersion, *minorVersion, *patchVersion);

    return ACL_SUCCESS;
}
