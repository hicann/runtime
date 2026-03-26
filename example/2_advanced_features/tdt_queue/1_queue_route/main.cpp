/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdint>
#include <cstring>
#include "acl/acl.h"
#include "acl/acl_tdt_queue.h"
#include "2_advanced_features/tdt_common_utils.h"
#include "utils.h"

namespace {
aclError CreateQueue(const char *name, uint32_t depth, uint32_t *qid)
{
    acltdtQueueAttr *attr = acltdtCreateQueueAttr();
    if (attr == nullptr) {
        return ACL_ERROR_INVALID_PARAM;
    }

    aclError ret = acltdtSetQueueAttr(attr, ACL_TDT_QUEUE_NAME_PTR, std::strlen(name) + 1, name);
    if (ret == ACL_SUCCESS) {
        ret = acltdtSetQueueAttr(attr, ACL_TDT_QUEUE_DEPTH_UINT32, sizeof(depth), &depth);
    }
    if (ret == ACL_SUCCESS) {
        ret = acltdtCreateQueue(attr, qid);
    }

    (void)acltdtDestroyQueueAttr(attr);
    return ret;
}

} // namespace

int main()
{
    const int32_t deviceId = 0;
    uint32_t srcQid = 0;
    uint32_t dstQid = 0;

    CHECK_ERROR(aclInit(nullptr));
    CHECK_ERROR(aclrtSetDevice(deviceId));
    CHECK_ERROR(CreateQueue("route_src_queue", 4, &srcQid));
    CHECK_ERROR(CreateQueue("route_dst_queue", 4, &dstQid));

    acltdtQueueRoute *route = acltdtCreateQueueRoute(srcQid, dstQid);
    if (!tdt::CheckNotNull(route, "acltdtCreateQueueRoute")) {
        return -1;
    }

    acltdtQueueRouteList *bindList = acltdtCreateQueueRouteList();
    if (!tdt::CheckNotNull(bindList, "acltdtCreateQueueRouteList")) {
        return -1;
    }
    CHECK_ERROR(acltdtAddQueueRoute(bindList, route));
    CHECK_ERROR(acltdtBindQueueRoutes(bindList));

    acltdtQueueRouteQueryInfo *queryInfo = acltdtCreateQueueRouteQueryInfo();
    if (!tdt::CheckNotNull(queryInfo, "acltdtCreateQueueRouteQueryInfo")) {
        return -1;
    }

    acltdtQueueRouteQueryMode mode = ACL_TDT_QUEUE_ROUTE_QUERY_SRC_AND_DST;
    CHECK_ERROR(acltdtSetQueueRouteQueryInfo(
        queryInfo,
        ACL_TDT_QUEUE_ROUTE_QUERY_MODE_ENUM,
        sizeof(mode),
        &mode));
    CHECK_ERROR(acltdtSetQueueRouteQueryInfo(
        queryInfo,
        ACL_TDT_QUEUE_ROUTE_QUERY_SRC_ID_UINT32,
        sizeof(srcQid),
        &srcQid));
    CHECK_ERROR(acltdtSetQueueRouteQueryInfo(
        queryInfo,
        ACL_TDT_QUEUE_ROUTE_QUERY_DST_ID_UINT32,
        sizeof(dstQid),
        &dstQid));

    acltdtQueueRouteList *queryList = acltdtCreateQueueRouteList();
    if (!tdt::CheckNotNull(queryList, "acltdtCreateQueueRouteList(query)")) {
        return -1;
    }
    CHECK_ERROR(acltdtQueryQueueRoutes(queryInfo, queryList));

    const size_t routeNum = acltdtGetQueueRouteNum(queryList);
    INFO_LOG("Queried route count: %zu", routeNum);

    if (routeNum > 0) {
        acltdtQueueRoute *routeView = acltdtCreateQueueRoute(srcQid, dstQid);
        if (!tdt::CheckNotNull(routeView, "routeView")) {
            return -1;
        }

        CHECK_ERROR(acltdtGetQueueRoute(queryList, 0, routeView));

        uint32_t queriedSrc = 0;
        uint32_t queriedDst = 0;
        int32_t queriedStatus = 0;
        size_t paramSize = 0;

        CHECK_ERROR(acltdtGetQueueRouteParam(
            routeView,
            ACL_TDT_QUEUE_ROUTE_SRC_UINT32,
            sizeof(queriedSrc),
            &paramSize,
            &queriedSrc));
        CHECK_ERROR(acltdtGetQueueRouteParam(
            routeView,
            ACL_TDT_QUEUE_ROUTE_DST_UINT32,
            sizeof(queriedDst),
            &paramSize,
            &queriedDst));
        CHECK_ERROR(acltdtGetQueueRouteParam(
            routeView,
            ACL_TDT_QUEUE_ROUTE_STATUS_INT32,
            sizeof(queriedStatus),
            &paramSize,
            &queriedStatus));

        INFO_LOG("Route: src=%u dst=%u status=%d", queriedSrc, queriedDst, queriedStatus);
        CHECK_ERROR(acltdtDestroyQueueRoute(routeView));
    }

    CHECK_ERROR(acltdtUnbindQueueRoutes(bindList));
    CHECK_ERROR(acltdtDestroyQueueRouteList(queryList));
    CHECK_ERROR(acltdtDestroyQueueRouteQueryInfo(queryInfo));
    CHECK_ERROR(acltdtDestroyQueueRouteList(bindList));
    CHECK_ERROR(acltdtDestroyQueueRoute(route));
    CHECK_ERROR(acltdtDestroyQueue(dstQid));
    CHECK_ERROR(acltdtDestroyQueue(srcQid));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    CHECK_ERROR(aclFinalize());
    return 0;
}
