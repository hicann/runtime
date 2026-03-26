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
#include "acl/acl.h"
#include "utils.h"

namespace {
void QueryGroupAttr(const aclrtGroupInfo *groupInfo, int32_t groupIndex, aclrtGroupAttr attr, const char *attrName)
{
    int32_t value = 0; size_t retSize = 0; aclError ret = aclrtGetGroupInfoDetail(groupInfo, groupIndex, attr, &value, sizeof(value), &retSize);
    if (ret == ACL_SUCCESS) { INFO_LOG("groupIndex=%d %s=%d retSize=%zu", groupIndex, attrName, value, retSize); }
    else { WARN_LOG("aclrtGetGroupInfoDetail(%s) failed with error code %d", attrName, static_cast<int32_t>(ret)); }
}
}
#define CHECK_NOT_NULL(ptr, name) do { if ((ptr) == nullptr) { ERROR_LOG("%s is nullptr", name); return -1; } } while (0)
int main()
{
    const int32_t deviceId = 0; aclrtContext context = nullptr; uint32_t groupCount = 0;
    CHECK_ERROR(aclInit(nullptr)); CHECK_ERROR(aclrtSetDevice(deviceId)); CHECK_ERROR(aclrtCreateContext(&context, deviceId)); CHECK_ERROR(aclrtGetGroupCount(&groupCount)); INFO_LOG("Group count: %u", groupCount);
    aclrtGroupInfo *groupInfo = aclrtCreateGroupInfo(); CHECK_NOT_NULL(groupInfo, "aclrtCreateGroupInfo"); CHECK_ERROR(aclrtGetAllGroupInfo(groupInfo));
    if (groupCount > 0) { int32_t groupId = 0; size_t retSize = 0; CHECK_ERROR(aclrtGetGroupInfoDetail(groupInfo, 0, ACL_GROUP_GROUPID_INT, &groupId, sizeof(groupId), &retSize)); CHECK_ERROR(aclrtSetGroup(groupId)); INFO_LOG("Current group set to groupId=%d", groupId); }
    const uint32_t queryCount = std::min(groupCount, 2U); for (uint32_t index = 0; index < queryCount; ++index) { QueryGroupAttr(groupInfo, static_cast<int32_t>(index), ACL_GROUP_GROUPID_INT, "groupId"); QueryGroupAttr(groupInfo, static_cast<int32_t>(index), ACL_GROUP_AICORE_INT, "aicore"); QueryGroupAttr(groupInfo, static_cast<int32_t>(index), ACL_GROUP_AIV_INT, "aiv"); QueryGroupAttr(groupInfo, static_cast<int32_t>(index), ACL_GROUP_SDMANUM_INT, "sdma"); }
    CHECK_ERROR(aclrtDestroyGroupInfo(groupInfo)); CHECK_ERROR(aclrtDestroyContext(context)); CHECK_ERROR(aclrtResetDeviceForce(deviceId)); CHECK_ERROR(aclFinalize()); return 0;
}