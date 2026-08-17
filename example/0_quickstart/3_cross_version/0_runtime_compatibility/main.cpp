/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <algorithm>
#include <cstdint>
#include <cstring>

#include "acl/acl.h"
#include "utils.h"

namespace {
const char* CannAttrToString(aclCannAttr attr)
{
    switch (attr) {
        case ACL_CANN_ATTR_INF_NAN:
            return "ACL_CANN_ATTR_INF_NAN";
        case ACL_CANN_ATTR_BF16:
            return "ACL_CANN_ATTR_BF16";
        case ACL_CANN_ATTR_JIT_COMPILE:
            return "ACL_CANN_ATTR_JIT_COMPILE";
        default:
            return "ACL_CANN_ATTR_UNKNOWN";
    }
}

int QueryCannVersion()
{
    char pkgName[] = "runtime";
    char versionStr[ACL_PKG_VERSION_MAX_SIZE] = {};
    int32_t versionNum = 0;

    CHECK_ERROR(aclsysGetVersionStr(pkgName, versionStr));
    CHECK_ERROR(aclsysGetVersionNum(pkgName, &versionNum));
    INFO_LOG("CANN package [%s] version string: %s", pkgName, versionStr);
    INFO_LOG("CANN package [%s] version number: %d", pkgName, versionNum);
    return 0;
}

int QueryCannAttributes()
{
    const aclCannAttr* attrList = nullptr;
    size_t attrCount = 0;
    CHECK_ERROR(aclGetCannAttributeList(&attrList, &attrCount));
    INFO_LOG("CANN attribute count: %zu", attrCount);

    const size_t printCount = std::min<size_t>(attrCount, 3);
    for (size_t i = 0; i < printCount; ++i) {
        int32_t value = 0;
        CHECK_ERROR(aclGetCannAttribute(attrList[i], &value));
        INFO_LOG("CANN attribute %s support value: %d", CannAttrToString(attrList[i]), value);
    }
    return 0;
}

int QueryCompatibilityAndCapability(int32_t deviceId)
{
    const char* socName = aclrtGetSocName();
    if (socName == nullptr || std::strlen(socName) == 0U) {
        WARN_LOG("aclrtGetSocName returned empty soc name. Skip architecture compatibility check.");
    } else {
        int32_t canCompatible = 0;
        CHECK_ERROR(aclrtCheckArchCompatibility(socName, &canCompatible));
        INFO_LOG("Architecture compatibility for %s: %d", socName, canCompatible);
    }

    int32_t capability = 0;
    CHECK_ERROR(aclrtGetDeviceCapability(deviceId, ACL_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV, &capability));
    INFO_LOG("Device capability ACL_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV: %d", capability);
    return 0;
}
} // namespace

int32_t main()
{
    constexpr int32_t deviceId = 0;

    CHECK_ERROR(aclInit(nullptr));
    CHECK_ERROR(aclrtSetDevice(deviceId));

    int ret = QueryCannVersion();
    if (ret == 0) {
        ret = QueryCannAttributes();
    }
    if (ret == 0) {
        ret = QueryCompatibilityAndCapability(deviceId);
    }

    aclError cleanupRet = aclrtResetDeviceForce(deviceId);
    if (cleanupRet != ACL_SUCCESS) {
        ERROR_LOG(
            "Operation failed: aclrtResetDeviceForce(deviceId) returned error code %d",
            static_cast<int32_t>(cleanupRet));
        ret = ret == 0 ? -1 : ret;
    }
    cleanupRet = aclFinalize();
    if (cleanupRet != ACL_SUCCESS) {
        ERROR_LOG("Operation failed: aclFinalize() returned error code %d", static_cast<int32_t>(cleanupRet));
        ret = ret == 0 ? -1 : ret;
    }
    if (ret == 0) {
        INFO_LOG("[SUCCESS] Runtime compatibility sample completed successfully");
    }
    return ret;
}
