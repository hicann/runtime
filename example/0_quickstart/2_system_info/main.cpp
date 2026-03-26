/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdio>
#include <cstdint>
#include "acl/acl.h"
#include "utils.h"

namespace {
const char *RunModeToString(aclrtRunMode runMode)
{
    return runMode == ACL_HOST ? "ACL_HOST" : "ACL_DEVICE";
}

aclError PrintCannVersionInfo()
{
    char pkgName[] = "runtime";
    char versionStr[ACL_PKG_VERSION_MAX_SIZE] = {0};
    int32_t versionNum = 0;

    aclError ret = aclsysGetVersionStr(pkgName, versionStr);
    if (ret != ACL_SUCCESS) {
        return ret;
    }

    ret = aclsysGetVersionNum(pkgName, &versionNum);
    if (ret != ACL_SUCCESS) {
        return ret;
    }

    INFO_LOG("CANN package [%s] version string: %s", pkgName, versionStr);
    INFO_LOG("CANN package [%s] version number: %d", pkgName, versionNum);
    return ACL_SUCCESS;
}
} // namespace

int main()
{
    CHECK_ERROR(aclInit(nullptr));
    INFO_LOG("ACL init successfully");

    int32_t majorVersion = 0;
    int32_t minorVersion = 0;
    int32_t patchVersion = 0;
    CHECK_ERROR(aclrtGetVersion(&majorVersion, &minorVersion, &patchVersion));
    INFO_LOG("ACL Runtime API version: %d.%d.%d", majorVersion, minorVersion, patchVersion);

    CHECK_ERROR(PrintCannVersionInfo());

    aclrtRunMode runMode = ACL_HOST;
    CHECK_ERROR(aclrtGetRunMode(&runMode));
    INFO_LOG("Current run mode: %s", RunModeToString(runMode));

    float originalValue = 1.625f;
    aclFloat16 fp16Value = aclFloatToFloat16(originalValue);
    float restoredValue = aclFloat16ToFloat(fp16Value);
    INFO_LOG("Float conversion: %.6f -> 0x%04x -> %.6f", originalValue, static_cast<unsigned int>(fp16Value),
        restoredValue);

    INFO_LOG("Data type size: ACL_FLOAT=%zu, ACL_FLOAT16=%zu, ACL_INT64=%zu",
        aclDataTypeSize(aclDataType::ACL_FLOAT), aclDataTypeSize(aclDataType::ACL_FLOAT16),
        aclDataTypeSize(aclDataType::ACL_INT64));

    CHECK_ERROR(aclFinalize());
    INFO_LOG("ACL finalize successfully");
    return 0;
}
