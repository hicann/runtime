/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "acl/acl_rt_impl.h"
#include "securec.h"
#include "runtime/context.h"
#include "common/log_inner.h"
#include "common/error_codes_inner.h"
#include "common/prof_reporter.h"
#include "common/resource_statistics.h"

namespace {
static aclError FillAttrValue(const void *const src, const size_t srcLen, void *const dst, const size_t dstLen,
    size_t *const paramRetSize)
{
    ACL_REQUIRES_NOT_NULL(src);
    ACL_REQUIRES_NOT_NULL(dst);
    if (srcLen > dstLen) {
        ACL_LOG_INNER_ERROR("attr real length = %zu is larger than input length = %zu", srcLen, dstLen);
        return ACL_ERROR_INVALID_PARAM;
    }
    const auto ret = memcpy_s(dst, dstLen, src, srcLen);
    if (ret != EOK) {
        ACL_LOG_INNER_ERROR("call memcpy_s failed, result = %d, srcLen = %zu, dstLen = %zu", ret, srcLen, dstLen);
        return ACL_ERROR_FAILURE;
    }
    *paramRetSize = srcLen;

    return ACL_SUCCESS;
}
}

aclError aclrtSetGroupImpl(int32_t groupId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetGroup);
    ACL_LOG_INFO("start to execute aclrtSetGroup, groupId is %d.", groupId);
    const rtError_t rtErr = rtSetGroup(groupId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("set group failed, runtime result = %d, groupId = %d",
            static_cast<int32_t>(rtErr), groupId);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtSetGroup, groupId is %d.", groupId);

    return ACL_SUCCESS;
}

aclError aclrtGetGroupCountImpl(uint32_t *count)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetGroupCount);
    ACL_LOG_INFO("start to execute aclrtGetGroupCount");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(count);
    const rtError_t rtErr = rtGetGroupCount(count);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("get group number failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtGetGroupCount, group number is %u.", *count);

    return ACL_SUCCESS;
}

aclrtGroupInfo *aclrtCreateGroupInfoImpl()
{
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_GROUP_INFO);
    ACL_LOG_INFO("start to execute aclrtCreateGroupInfo");
    uint32_t count = 0U;
    const rtError_t rtErr = rtGetGroupCount(&count);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("get group number failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return nullptr;
    }
    if (count == 0U) { // 0 represents that no group
        ACL_LOG_WARN("group number is 0, no memory allocation");
        return nullptr;
    }

    aclrtGroupInfo *const groupInfo = new(std::nothrow) aclrtGroupInfo[count];
    if (groupInfo == nullptr) {
        ACL_LOG_INNER_ERROR("fail to new group info");
        return nullptr;
    }

    ACL_LOG_INFO("successfully execute aclrtCreateGroupInfo, group number is %u.", count);
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_GROUP_INFO);

    return groupInfo;
}

aclError aclrtDestroyGroupInfoImpl(aclrtGroupInfo *groupInfo)
{
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_GROUP_INFO);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(groupInfo);
    ACL_DELETE_ARRAY_AND_SET_NULL(groupInfo);
    ACL_LOG_INFO("successfully execute aclrtDestroyGroupInfo");

    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_GROUP_INFO);

    return ACL_SUCCESS;
}

aclError aclrtGetAllGroupInfoImpl(aclrtGroupInfo *groupInfo)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetAllGroupInfo);
    ACL_LOG_INFO("start to execute aclrtGetAllGroupInfo");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(groupInfo);
    uint32_t count = 0U;
    rtError_t rtErr = rtGetGroupCount(&count);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("get group number failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    // -1 represents that get all group information
    rtErr = rtGetGroupInfo(-1, static_cast<rtGroupInfo_t *>(groupInfo), count);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("get group info failed, runtime result = %d, group number = %u",
            static_cast<int32_t>(rtErr), count);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtGetAllGroupInfo, group number = %u", count);

    return ACL_SUCCESS;
}

aclError aclrtGetGroupInfoDetailImpl(const aclrtGroupInfo *groupInfo, int32_t groupIndex, aclrtGroupAttr attr,
                                     void *attrValue, size_t valueLen, size_t *paramRetSize)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetGroupInfoDetail);
    ACL_LOG_INFO("start to execute aclrtGetGroupInfoDetail, groupIndex = %d", groupIndex);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(groupInfo);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(attrValue);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(paramRetSize);
    uint32_t count = 0U;
    const rtError_t rtErr = rtGetGroupCount(&count);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("get group number failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    if ((groupIndex < 0) || (static_cast<uint32_t>(groupIndex) >= count)) {
        ACL_LOG_INNER_ERROR("the index value of group is invalid, groupIndex = %d, not in range [0, %u)",
            groupIndex, count);
        return ACL_ERROR_INVALID_PARAM;
    }

    aclError aclRet;
    switch (attr) {
        case ACL_GROUP_AICORE_INT:
            aclRet = FillAttrValue(static_cast<const void *>(&groupInfo[groupIndex].aicoreNum),
                sizeof(groupInfo[groupIndex].aicoreNum), attrValue, valueLen, paramRetSize);
            break;
        case ACL_GROUP_AIV_INT:
            aclRet = FillAttrValue(static_cast<const void *>(&groupInfo[groupIndex].aivectorNum),
                sizeof(groupInfo[groupIndex].aivectorNum), attrValue, valueLen, paramRetSize);
            break;
        case ACL_GROUP_AIC_INT:
            aclRet = FillAttrValue(static_cast<const void *>(&groupInfo[groupIndex].aicpuNum),
                sizeof(groupInfo[groupIndex].aicpuNum), attrValue, valueLen, paramRetSize);
            break;
        case ACL_GROUP_SDMANUM_INT:
            aclRet = FillAttrValue(static_cast<const void *>(&groupInfo[groupIndex].sdmaNum),
                sizeof(groupInfo[groupIndex].sdmaNum), attrValue, valueLen, paramRetSize);
            break;
        case ACL_GROUP_ASQNUM_INT:
            aclRet = FillAttrValue(static_cast<const void *>(&groupInfo[groupIndex].activeStreamNum),
                sizeof(groupInfo[groupIndex].activeStreamNum), attrValue, valueLen, paramRetSize);
            break;
        case ACL_GROUP_GROUPID_INT:
            aclRet = FillAttrValue(static_cast<const void *>(&groupInfo[groupIndex].groupId),
                sizeof(groupInfo[groupIndex].groupId), attrValue, valueLen, paramRetSize);
            break;
        default:
            ACL_LOG_INNER_ERROR("invalid group attribute, attribute = %d", static_cast<int32_t>(attr));
            return ACL_ERROR_INVALID_PARAM;
    }

    ACL_LOG_INFO("end to execute aclrtGetGroupInfoDetail, groupIndex = %d", groupIndex);
    return aclRet;
}
