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
#include "utils/data_type_utils.h"

#include <fstream>
#include <sys/stat.h>
#include "acl_rt_impl.h"
#include "utils/file_utils.h"
#include "common/json_parser.h"

namespace acl {
namespace {
#if defined(ONLY_ENABLE_ACL_UT)
constexpr const char_t* const SW_CONFIG_FILE = "tmp_run_data/ascendcl_config/swFeatureList.json";
constexpr const char_t* const RUNTIME_VERSION_PATH = "tests/tmp_run_data/share/info/runtime/version.info";
#else
constexpr const char_t* const SW_CONFIG_FILE = "data/ascendcl_config/swFeatureList.json";
constexpr const char_t* const RUNTIME_VERSION_PATH = "share/info/runtime/version.info";
#endif
constexpr const char_t* const VERSION_INFO_KEY = "Version=";
constexpr size_t MAX_INSTALL_PATH_SEARCH_DEPTH = 8U;

std::string StripTrailingSlash(const std::string& path)
{
    if ((path.size() > 1UL) && (path.back() == '/')) {
        return path.substr(0, path.size() - 1UL);
    }
    return path;
}

std::string GetParentDir(const std::string& path)
{
    const std::string strippedPath = StripTrailingSlash(path);
    const size_t pos = strippedPath.rfind('/');
    if (pos == std::string::npos) {
        return "";
    }
    return strippedPath.substr(0, pos + 1UL);
}

bool IsRegularFile(const std::string& path)
{
    struct stat fileStat = {};
    return (stat(path.c_str(), &fileStat) == 0) && S_ISREG(fileStat.st_mode);
}

bool FindFileFromCurrentToParents(const std::string& startDir, const std::string& relativePath, std::string& matchedDir)
{
    std::string currentDir = startDir;
    for (size_t depth = 0U; depth < MAX_INSTALL_PATH_SEARCH_DEPTH; ++depth) {
        if (currentDir.empty()) {
            return false;
        }
        if (IsRegularFile(currentDir + relativePath)) {
            matchedDir = currentDir;
            return true;
        }
        const std::string parentDir = GetParentDir(currentDir);
        if ((parentDir.empty()) || (parentDir == currentDir)) {
            return false;
        }
        currentDir = parentDir;
    }
    return false;
}
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

aclError CannInfoUtils::GetAttributeList(const aclCannAttr** cannAttr, size_t* num)
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

aclError CannInfoUtils::GetAttribute(aclCannAttr cannAttr, int32_t* value)
{
    const aclError ret = Initialize();
    if (ret != ACL_SUCCESS) {
        ACL_LOG_INNER_ERROR("initialize CannInfoUtils failed, ret = %d", static_cast<int32_t>(ret));
        return ret;
    }

    auto iter = attrToCannInfo_.find(cannAttr);
    if (iter == attrToCannInfo_.end()) {
        ACL_LOG_WARN("find cann attr failed, attr value = %s", acl::GetCannAttrDesc(cannAttr));
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
        ACL_LOG_INNER_ERROR("Failed to get swFeatureList.json, please check ascendcl_config path.");
        return ret;
    }

    // parse requirments of each attributes
    ret = JsonParser::GetAttrConfigFromFile(swConfigPath_.c_str(), attrToCannInfo_);
    if (ret != ACL_SUCCESS) {
        ACL_LOG_INNER_ERROR("Failed to parse requirements of Cann attrs, ret = %d.", ret);
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
    ACL_LOG_INFO(
        "Successfully initialized CannInfoUtils: current CannInfo[runtime = %d, attrNum = %zu]", currentRuntimeVersion_,
        attrNum_);

    return ACL_SUCCESS;
}

aclError CannInfoUtils::GetConfigInstallPath()
{
    std::string path;
    const aclError ret = file_utils::GetSoRealPath(path);
    if (ret != ACL_SUCCESS) {
        ACL_LOG_WARN("Failed to get libascendcl.so file path.");
        return ret;
    }
    ACL_LOG_DEBUG("current path = %s", path.c_str());
    const std::string soDir = path;
    path = path.substr(0, path.rfind('/'));
    path = path.substr(0, path.rfind('/') + 1UL);
    swConfigPath_ = path + SW_CONFIG_FILE;
    if (!IsRegularFile(swConfigPath_)) {
        std::string matchedDir;
        if (FindFileFromCurrentToParents(soDir, SW_CONFIG_FILE, matchedDir)) {
            swConfigPath_ = matchedDir + SW_CONFIG_FILE;
            path = matchedDir;
            ACL_LOG_INFO("fallback to swConfigPath = %s", swConfigPath_.c_str());
        }
    }
    ACL_LOG_DEBUG("swConfigPath = %s", swConfigPath_.c_str());
    path.pop_back();
    defaultInstallPath_ = path.substr(0, path.rfind('/') + 1UL);
    if (!IsRegularFile(defaultInstallPath_ + RUNTIME_VERSION_PATH)) {
        std::string matchedDir;
        if (FindFileFromCurrentToParents(soDir, RUNTIME_VERSION_PATH, matchedDir)) {
            defaultInstallPath_ = matchedDir;
            ACL_LOG_INFO("fallback to defaultInstallPath = %s", defaultInstallPath_.c_str());
        }
    }
    ACL_LOG_DEBUG("defaultInstallPath = %s", defaultInstallPath_.c_str());
    return ACL_SUCCESS;
}

aclError CannInfoUtils::ParseVersionInfo(const std::string& path, int32_t* version)
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

aclError CannInfoUtils::ParseVersionValue(const std::string& str, int32_t* value)
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

bool CannInfoUtils::MatchVersionInfo(const CannInfo& configCannInfo)
{
    // if version is not set, skip matching and return true
    if (configCannInfo.minimumRuntimeVersion == UNKNOWN_VERSION) {
        return true;
    }
    return (currentRuntimeVersion_ >= configCannInfo.minimumRuntimeVersion);
}

bool CannInfoUtils::CheckNPUFeatures(const CannInfo& configInfo)
{
    if (configInfo.socSpecLabel.empty() || configInfo.socSpecKey.empty()) {
        // label 或 key 为空说明特性与芯片无关, 无需查询
        return true;
    }
    constexpr uint32_t kMaxValueLen = 16U;
    char_t value[kMaxValueLen] = {0};
    const auto ret = rtGetSocSpec(configInfo.socSpecLabel.c_str(), configInfo.socSpecKey.c_str(), value, kMaxValueLen);
    if (ret != RT_ERROR_NONE) {
        ACL_LOG_WARN(
            "Cannot get platform info, label = [%s], key = [%s]", configInfo.socSpecLabel.c_str(),
            configInfo.socSpecKey.c_str());
        return false;
    }
    // value "0" 或空 或非法内容 都认为 false
    const std::string strVal(value);
    return strVal == "1";
}

void CannInfoUtils::CheckAndUpdateAttrAvailability()
{
    for (auto& item : attrToCannInfo_) {
        auto& swConfigInfo = item.second;
        if (MatchVersionInfo(swConfigInfo) && CheckNPUFeatures(swConfigInfo)) {
            ACL_LOG_INFO("support cann attribute [%s]", swConfigInfo.readableAttrName.c_str());
            swConfigInfo.isAvailable = 1;
            attrArray_[attrNum_] = item.first;
            ++attrNum_;
        }
    }
}

const char* GetDataTypeDesc(aclDataType type)
{
    switch (type) {
        case ACL_DT_UNDEFINED:
            return "DT_UNDEFINED(-1)";
        case ACL_FLOAT:
            return "FLOAT(0)";
        case ACL_FLOAT16:
            return "FLOAT16(1)";
        case ACL_INT8:
            return "INT8(2)";
        case ACL_INT32:
            return "INT32(3)";
        case ACL_UINT8:
            return "UINT8(4)";
        case ACL_INT16:
            return "INT16(6)";
        case ACL_UINT16:
            return "UINT16(7)";
        case ACL_UINT32:
            return "UINT32(8)";
        case ACL_INT64:
            return "INT64(9)";
        case ACL_UINT64:
            return "UINT64(10)";
        case ACL_DOUBLE:
            return "DOUBLE(11)";
        case ACL_BOOL:
            return "BOOL(12)";
        case ACL_STRING:
            return "STRING(13)";
        case ACL_COMPLEX64:
            return "COMPLEX64(16)";
        case ACL_COMPLEX128:
            return "COMPLEX128(17)";
        case ACL_BF16:
            return "BF16(27)";
        case ACL_INT4:
            return "INT4(29)";
        case ACL_UINT1:
            return "UINT1(30)";
        case ACL_COMPLEX32:
            return "COMPLEX32(33)";
        case ACL_HIFLOAT8:
            return "HIFLOAT8(34)";
        case ACL_FLOAT8_E5M2:
            return "FLOAT8_E5M2(35)";
        case ACL_FLOAT8_E4M3FN:
            return "FLOAT8_E4M3FN(36)";
        case ACL_FLOAT8_E8M0:
            return "FLOAT8_E8M0(37)";
        case ACL_FLOAT6_E3M2:
            return "FLOAT6_E3M2(38)";
        case ACL_FLOAT6_E2M3:
            return "FLOAT6_E2M3(39)";
        case ACL_FLOAT4_E2M1:
            return "FLOAT4_E2M1(40)";
        case ACL_FLOAT4_E1M2:
            return "FLOAT4_E1M2(41)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

const char* GetMemcpyKindDesc(aclrtMemcpyKind kind)
{
    switch (kind) {
        case ACL_MEMCPY_HOST_TO_HOST:
            return "MEMCPY_HOST_TO_HOST(0)";
        case ACL_MEMCPY_HOST_TO_DEVICE:
            return "MEMCPY_HOST_TO_DEVICE(1)";
        case ACL_MEMCPY_DEVICE_TO_HOST:
            return "MEMCPY_DEVICE_TO_HOST(2)";
        case ACL_MEMCPY_DEVICE_TO_DEVICE:
            return "MEMCPY_DEVICE_TO_DEVICE(3)";
        case ACL_MEMCPY_DEFAULT:
            return "MEMCPY_DEFAULT(4)";
        case ACL_MEMCPY_HOST_TO_BUF_TO_DEVICE:
            return "MEMCPY_HOST_TO_BUF_TO_DEVICE(5)";
        case ACL_MEMCPY_INNER_DEVICE_TO_DEVICE:
            return "MEMCPY_INNER_DEVICE_TO_DEVICE(6)";
        case ACL_MEMCPY_INTER_DEVICE_TO_DEVICE:
            return "MEMCPY_INTER_DEVICE_TO_DEVICE(7)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(kind));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

const char* GetMemAttrDesc(aclrtMemAttr attr)
{
    switch (attr) {
        case ACL_DDR_MEM:
            return "DDR_MEM(0)";
        case ACL_HBM_MEM:
            return "HBM_MEM(1)";
        case ACL_DDR_MEM_HUGE:
            return "DDR_MEM_HUGE(2)";
        case ACL_DDR_MEM_NORMAL:
            return "DDR_MEM_NORMAL(3)";
        case ACL_HBM_MEM_HUGE:
            return "HBM_MEM_HUGE(4)";
        case ACL_HBM_MEM_NORMAL:
            return "HBM_MEM_NORMAL(5)";
        case ACL_DDR_MEM_P2P_HUGE:
            return "DDR_MEM_P2P_HUGE(6)";
        case ACL_DDR_MEM_P2P_NORMAL:
            return "DDR_MEM_P2P_NORMAL(7)";
        case ACL_HBM_MEM_P2P_HUGE:
            return "HBM_MEM_P2P_HUGE(8)";
        case ACL_HBM_MEM_P2P_NORMAL:
            return "HBM_MEM_P2P_NORMAL(9)";
        case ACL_HBM_MEM_HUGE1G:
            return "HBM_MEM_HUGE1G(10)";
        case ACL_HBM_MEM_P2P_HUGE1G:
            return "HBM_MEM_P2P_HUGE1G(11)";
        case ACL_MEM_NORMAL:
            return "MEM_NORMAL(12)";
        case ACL_MEM_HUGE:
            return "MEM_HUGE(13)";
        case ACL_MEM_HUGE1G:
            return "MEM_HUGE1G(14)";
        case ACL_MEM_P2P_NORMAL:
            return "MEM_P2P_NORMAL(15)";
        case ACL_MEM_P2P_HUGE:
            return "MEM_P2P_HUGE(16)";
        case ACL_MEM_P2P_HUGE1G:
            return "MEM_P2P_HUGE1G(17)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(attr));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

const char* GetCannAttrDesc(aclCannAttr attr)
{
    switch (attr) {
        case ACL_CANN_ATTR_UNDEFINED:
            return "CANN_ATTR_UNDEFINED(-1)";
        case ACL_CANN_ATTR_INF_NAN:
            return "CANN_ATTR_INF_NAN(0)";
        case ACL_CANN_ATTR_BF16:
            return "CANN_ATTR_BF16(1)";
        case ACL_CANN_ATTR_JIT_COMPILE:
            return "CANN_ATTR_JIT_COMPILE(2)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(attr));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

const char* GetDevResLimitTypeDesc(aclrtDevResLimitType type)
{
    switch (type) {
        case ACL_RT_DEV_RES_CUBE_CORE:
            return "RT_DEV_RES_CUBE_CORE(0)";
        case ACL_RT_DEV_RES_VECTOR_CORE:
            return "RT_DEV_RES_VECTOR_CORE(1)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

const char* GetReduceKindDesc(aclrtReduceKind kind)
{
    switch (kind) {
        case ACL_RT_MEMCPY_SDMA_AUTOMATIC_SUM:
            return "RT_MEMCPY_SDMA_AUTOMATIC_SUM(10)";
        case ACL_RT_MEMCPY_SDMA_AUTOMATIC_MAX:
            return "RT_MEMCPY_SDMA_AUTOMATIC_MAX(11)";
        case ACL_RT_MEMCPY_SDMA_AUTOMATIC_MIN:
            return "RT_MEMCPY_SDMA_AUTOMATIC_MIN(12)";
        case ACL_RT_MEMCPY_SDMA_AUTOMATIC_EQUAL:
            return "RT_MEMCPY_SDMA_AUTOMATIC_EQUAL(13)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(kind));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

const char* GetMemLinkTypeDesc(aclrtMemLinkType type)
{
    switch (type) {
        case ACL_RT_MEM_ACCESS_LINK_SIO:
            return "RT_MEM_ACCESS_LINK_SIO(0)";
        case ACL_RT_MEM_ACCESS_LINK_HCCS:
            return "RT_MEM_ACCESS_LINK_HCCS(1)";
        case ACL_RT_MEM_ACCESS_UB_ONE_PORT_PATH:
            return "RT_MEM_ACCESS_UB_ONE_PORT_PATH(2)";
        case ACL_RT_MEM_ACCESS_UB_MULTI_PORT_PATH:
            return "RT_MEM_ACCESS_UB_MULTI_PORT_PATH(3)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

const char* GetErrorTypeDesc(aclrtErrorType type)
{
    switch (type) {
        case ACL_RT_NO_ERROR:
            return "RT_NO_ERROR(0)";
        case ACL_RT_ERROR_MEMORY:
            return "RT_ERROR_MEMORY(1)";
        case ACL_RT_ERROR_L2:
            return "RT_ERROR_L2(2)";
        case ACL_RT_ERROR_AICORE:
            return "RT_ERROR_AICORE(3)";
        case ACL_RT_ERROR_LINK:
            return "RT_ERROR_LINK(4)";
        case ACL_RT_ERROR_L3_PORT:
            return "RT_ERROR_L3_PORT(5)";
        case ACL_RT_ERROR_OTHERS:
            return "RT_ERROR_OTHERS(65535)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

const char* GetStreamAttrDesc(aclrtStreamAttr attr)
{
    switch (attr) {
        case ACL_STREAM_ATTR_FAILURE_MODE:
            return "STREAM_ATTR_FAILURE_MODE(1)";
        case ACL_STREAM_ATTR_FLOAT_OVERFLOW_CHECK:
            return "STREAM_ATTR_FLOAT_OVERFLOW_CHECK(2)";
        case ACL_STREAM_ATTR_USER_CUSTOM_TAG:
            return "STREAM_ATTR_USER_CUSTOM_TAG(3)";
        case ACL_STREAM_ATTR_CACHE_OP_INFO:
            return "STREAM_ATTR_CACHE_OP_INFO(4)";
        case ACL_STREAM_ATTR_PRIORITY:
            return "STREAM_ATTR_PRIORITY(5)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(attr));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

const char* GetConditionDesc(aclrtCondition condition)
{
    switch (condition) {
        case ACL_RT_EQUAL:
            return "RT_EQUAL(0)";
        case ACL_RT_NOT_EQUAL:
            return "RT_NOT_EQUAL(1)";
        case ACL_RT_GREATER:
            return "RT_GREATER(2)";
        case ACL_RT_GREATER_OR_EQUAL:
            return "RT_GREATER_OR_EQUAL(3)";
        case ACL_RT_LESS:
            return "RT_LESS(4)";
        case ACL_RT_LESS_OR_EQUAL:
            return "RT_LESS_OR_EQUAL(5)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(condition));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

const char* GetCompareDataTypeDesc(aclrtCompareDataType type)
{
    switch (type) {
        case ACL_RT_SWITCH_INT32:
            return "RT_SWITCH_INT32(0)";
        case ACL_RT_SWITCH_INT64:
            return "RT_SWITCH_INT64(1)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

const char* GetIpcMemAttrTypeDesc(aclrtIpcMemAttrType type)
{
    switch (type) {
        case ACL_RT_IPC_MEM_ATTR_ACCESS_LINK:
            return "RT_IPC_MEM_ATTR_ACCESS_LINK(0)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

const char* GetFloatOverflowModeDesc(aclrtFloatOverflowMode mode)
{
    switch (mode) {
        case ACL_RT_OVERFLOW_MODE_SATURATION:
            return "RT_OVERFLOW_MODE_SATURATION(0)";
        case ACL_RT_OVERFLOW_MODE_INFNAN:
            return "RT_OVERFLOW_MODE_INFNAN(1)";
        case ACL_RT_OVERFLOW_MODE_UNDEF:
            return "RT_OVERFLOW_MODE_UNDEF(2)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(mode));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

const char* GetCmoTypeDesc(aclrtCmoType type)
{
    switch (type) {
        case ACL_RT_CMO_TYPE_PREFETCH:
            return "RT_CMO_TYPE_PREFETCH(0)";
        case ACL_RT_CMO_TYPE_WRITEBACK:
            return "RT_CMO_TYPE_WRITEBACK(1)";
        case ACL_RT_CMO_TYPE_INVALID:
            return "RT_CMO_TYPE_INVALID(2)";
        case ACL_RT_CMO_TYPE_FLUSH:
            return "RT_CMO_TYPE_FLUSH(3)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

const char* GetDeviceLimitDesc(aclrtDeviceLimit limit)
{
    switch (limit) {
        case ACL_RT_DEV_LIMIT_SIMT_STACK_SIZE:
            return "RT_DEV_LIMIT_SIMT_STACK_SIZE(0)";
        case ACL_RT_DEV_LIMIT_SIMT_DVG_WARP_STACK_SIZE:
            return "RT_DEV_LIMIT_SIMT_DVG_WARP_STACK_SIZE(1)";
        case ACL_RT_DEV_LIMIT_SIMD_STACK_SIZE:
            return "RT_DEV_LIMIT_SIMD_STACK_SIZE(2)";
        case ACL_RT_DEV_LIMIT_SIMD_PRINTF_FIFO_SIZE_PER_CORE:
            return "RT_DEV_LIMIT_SIMD_PRINTF_FIFO_SIZE_PER_CORE(3)";
        case ACL_RT_DEV_LIMIT_SIMT_PRINTF_FIFO_SIZE:
            return "RT_DEV_LIMIT_SIMT_PRINTF_FIFO_SIZE(4)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(limit));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}
} // namespace acl
