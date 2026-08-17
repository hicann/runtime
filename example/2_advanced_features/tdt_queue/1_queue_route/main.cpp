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
#include "acl/acl.h"
#include "acl/acl_tdt_queue.h"
#include "2_advanced_features/tdt_common_utils.h"
#include "utils.h"

namespace {
constexpr size_t kQueueNamePtrSize = sizeof(const char*);

struct QueueRouteSample {
    static constexpr int32_t kDeviceId = 0;
    static constexpr uint32_t kQueueDepth = 4;

    uint32_t srcQid = 0;
    uint32_t dstQid = 0;
    bool aclInitialized = false;
    bool deviceSet = false;
    bool srcQueueCreated = false;
    bool dstQueueCreated = false;
    bool routeAdded = false;
    bool bindAttempted = false;
    acltdtQueueRoute* route = nullptr;
    acltdtQueueRouteList* bindList = nullptr;
    acltdtQueueRouteQueryInfo* queryInfo = nullptr;
    acltdtQueueRouteList* queryList = nullptr;
};

aclError CreateQueueWithAttr(const char* name, uint32_t depth, uint32_t* qid)
{
    if (qid == nullptr) {
        return ACL_ERROR_INVALID_PARAM;
    }

    acltdtQueueAttr* attr = acltdtCreateQueueAttr();
    if (attr == nullptr) {
        return ACL_ERROR_INVALID_PARAM;
    }

    aclError ret = acltdtSetQueueAttr(attr, ACL_TDT_QUEUE_DEPTH_UINT32, sizeof(depth), &depth);
    if ((ret == ACL_SUCCESS) && (name != nullptr)) {
        // ACL_TDT_QUEUE_NAME_PTR expects a pointer-sized payload that points to the queue name.
        const char* namePtr = name;
        ret = acltdtSetQueueAttr(attr, ACL_TDT_QUEUE_NAME_PTR, kQueueNamePtrSize, &namePtr);
    }
    if (ret == ACL_SUCCESS) {
        ret = acltdtCreateQueue(attr, qid);
    }

    (void)acltdtDestroyQueueAttr(attr);
    return ret;
}

aclError CreateQueue(const char* name, uint32_t depth, uint32_t* qid)
{
    aclError ret = CreateQueueWithAttr(name, depth, qid);
    if ((ret != ACL_ERROR_INVALID_PARAM) || (name == nullptr)) {
        return ret;
    }

    WARN_LOG(
        "CreateQueue with explicit name \"%s\" returned ACL_ERROR_INVALID_PARAM, retrying with an auto-generated "
        "queue name. This usually means the runtime rejected the fixed queue name, for example because a previous "
        "abnormal exit left a stale same-name queue behind.",
        name);
    return CreateQueueWithAttr(nullptr, depth, qid);
}

int32_t CreateQueues(QueueRouteSample& sample)
{
    aclError ret = CreateQueue("route_src_queue", QueueRouteSample::kQueueDepth, &sample.srcQid);
    if (ret != ACL_SUCCESS) {
        ERROR_LOG(
            "Operation failed: CreateQueue(\"route_src_queue\", QueueRouteSample::kQueueDepth, &sample.srcQid) "
            "returned error code %d",
            static_cast<int32_t>(ret));
        return -1;
    }
    sample.srcQueueCreated = true;

    ret = CreateQueue("route_dst_queue", QueueRouteSample::kQueueDepth, &sample.dstQid);
    if (ret != ACL_SUCCESS) {
        ERROR_LOG(
            "Operation failed: CreateQueue(\"route_dst_queue\", QueueRouteSample::kQueueDepth, &sample.dstQid) "
            "returned error code %d",
            static_cast<int32_t>(ret));
        return -1;
    }
    sample.dstQueueCreated = true;
    return 0;
}

int32_t BindQueueRoute(QueueRouteSample& sample)
{
    sample.route = acltdtCreateQueueRoute(sample.srcQid, sample.dstQid);
    if (!tdt::CheckNotNull(sample.route, "acltdtCreateQueueRoute")) {
        return -1;
    }

    sample.bindList = acltdtCreateQueueRouteList();
    if (!tdt::CheckNotNull(sample.bindList, "acltdtCreateQueueRouteList")) {
        return -1;
    }
    CHECK_ERROR(acltdtAddQueueRoute(sample.bindList, sample.route));
    sample.routeAdded = true;
    sample.bindAttempted = true;
    CHECK_ERROR(acltdtBindQueueRoutes(sample.bindList));
    return 0;
}

int32_t PrepareRouteQuery(QueueRouteSample& sample)
{
    sample.queryInfo = acltdtCreateQueueRouteQueryInfo();
    if (!tdt::CheckNotNull(sample.queryInfo, "acltdtCreateQueueRouteQueryInfo")) {
        return -1;
    }

    acltdtQueueRouteQueryMode mode = ACL_TDT_QUEUE_ROUTE_QUERY_SRC_AND_DST;
    CHECK_ERROR(
        acltdtSetQueueRouteQueryInfo(sample.queryInfo, ACL_TDT_QUEUE_ROUTE_QUERY_MODE_ENUM, sizeof(mode), &mode));
    CHECK_ERROR(acltdtSetQueueRouteQueryInfo(
        sample.queryInfo, ACL_TDT_QUEUE_ROUTE_QUERY_SRC_ID_UINT32, sizeof(sample.srcQid), &sample.srcQid));
    CHECK_ERROR(acltdtSetQueueRouteQueryInfo(
        sample.queryInfo, ACL_TDT_QUEUE_ROUTE_QUERY_DST_ID_UINT32, sizeof(sample.dstQid), &sample.dstQid));

    sample.queryList = acltdtCreateQueueRouteList();
    if (!tdt::CheckNotNull(sample.queryList, "acltdtCreateQueueRouteList(query)")) {
        return -1;
    }
    CHECK_ERROR(acltdtQueryQueueRoutes(sample.queryInfo, sample.queryList));
    return 0;
}

aclError GetQueueRouteParamValue(
    acltdtQueueRoute* route, decltype(ACL_TDT_QUEUE_ROUTE_SRC_UINT32) paramType, const char* apiName, size_t valueSize,
    void* value)
{
    size_t paramSize = 0;
    const aclError ret = acltdtGetQueueRouteParam(route, paramType, valueSize, &paramSize, value);
    if (ret != ACL_SUCCESS) {
        ERROR_LOG("Operation failed: %s returned error code %d", apiName, static_cast<int32_t>(ret));
    }
    return ret;
}

int32_t LogQueriedRoute(const QueueRouteSample& sample)
{
    const size_t routeNum = acltdtGetQueueRouteNum(sample.queryList);
    INFO_LOG("Queried route count: %zu", routeNum);
    if (routeNum == 0) {
        return 0;
    }

    acltdtQueueRoute* routeView = acltdtCreateQueueRoute(sample.srcQid, sample.dstQid);
    if (!tdt::CheckNotNull(routeView, "routeView")) {
        return -1;
    }

    const aclError getRouteRet = acltdtGetQueueRoute(sample.queryList, 0, routeView);
    if (getRouteRet != ACL_SUCCESS) {
        (void)acltdtDestroyQueueRoute(routeView);
        ERROR_LOG(
            "Operation failed: acltdtGetQueueRoute(sample.queryList, 0, routeView) returned error code %d",
            static_cast<int32_t>(getRouteRet));
        return -1;
    }

    uint32_t queriedSrc = 0;
    uint32_t queriedDst = 0;
    int32_t queriedStatus = 0;
    if (GetQueueRouteParamValue(
            routeView, ACL_TDT_QUEUE_ROUTE_SRC_UINT32,
            "acltdtGetQueueRouteParam(routeView, ACL_TDT_QUEUE_ROUTE_SRC_UINT32, sizeof(queriedSrc), &paramSize, "
            "&queriedSrc)",
            sizeof(queriedSrc), &queriedSrc) != ACL_SUCCESS ||
        GetQueueRouteParamValue(
            routeView, ACL_TDT_QUEUE_ROUTE_DST_UINT32,
            "acltdtGetQueueRouteParam(routeView, ACL_TDT_QUEUE_ROUTE_DST_UINT32, sizeof(queriedDst), &paramSize, "
            "&queriedDst)",
            sizeof(queriedDst), &queriedDst) != ACL_SUCCESS ||
        GetQueueRouteParamValue(
            routeView, ACL_TDT_QUEUE_ROUTE_STATUS_INT32,
            "acltdtGetQueueRouteParam(routeView, ACL_TDT_QUEUE_ROUTE_STATUS_INT32, sizeof(queriedStatus), "
            "&paramSize, &queriedStatus)",
            sizeof(queriedStatus), &queriedStatus) != ACL_SUCCESS) {
        (void)acltdtDestroyQueueRoute(routeView);
        return -1;
    }

    INFO_LOG("Route: src=%u dst=%u status=%d", queriedSrc, queriedDst, queriedStatus);
    CHECK_ERROR(acltdtDestroyQueueRoute(routeView));
    return 0;
}

int32_t RunSample(QueueRouteSample& sample)
{
    CHECK_ERROR(aclInit(nullptr));
    sample.aclInitialized = true;
    CHECK_ERROR(aclrtSetDevice(QueueRouteSample::kDeviceId));
    sample.deviceSet = true;

    if (CreateQueues(sample) != 0) {
        return -1;
    }
    if (BindQueueRoute(sample) != 0) {
        return -1;
    }
    if (PrepareRouteQuery(sample) != 0) {
        return -1;
    }
    return LogQueriedRoute(sample);
}

void CleanupRouteResources(QueueRouteSample& sample, int32_t& finalResult)
{
    if (sample.bindAttempted && sample.routeAdded && (sample.bindList != nullptr)) {
        tdt::UpdateFinalResultOnError(
            "acltdtUnbindQueueRoutes(sample.bindList)", acltdtUnbindQueueRoutes(sample.bindList), finalResult);
    }
    if (sample.queryList != nullptr) {
        tdt::UpdateFinalResultOnError(
            "acltdtDestroyQueueRouteList(sample.queryList)", acltdtDestroyQueueRouteList(sample.queryList),
            finalResult);
    }
    if (sample.queryInfo != nullptr) {
        tdt::UpdateFinalResultOnError(
            "acltdtDestroyQueueRouteQueryInfo(sample.queryInfo)", acltdtDestroyQueueRouteQueryInfo(sample.queryInfo),
            finalResult);
    }
    if (sample.bindList != nullptr) {
        tdt::UpdateFinalResultOnError(
            "acltdtDestroyQueueRouteList(sample.bindList)", acltdtDestroyQueueRouteList(sample.bindList), finalResult);
    }
    if (sample.route != nullptr) {
        tdt::UpdateFinalResultOnError(
            "acltdtDestroyQueueRoute(sample.route)", acltdtDestroyQueueRoute(sample.route), finalResult);
    }
}

void CleanupQueues(QueueRouteSample& sample, int32_t& finalResult)
{
    if (sample.dstQueueCreated) {
        tdt::UpdateFinalResultOnError(
            "acltdtDestroyQueue(sample.dstQid)", acltdtDestroyQueue(sample.dstQid), finalResult);
    }
    if (sample.srcQueueCreated) {
        tdt::UpdateFinalResultOnError(
            "acltdtDestroyQueue(sample.srcQid)", acltdtDestroyQueue(sample.srcQid), finalResult);
    }
}

void CleanupAclRuntime(int32_t& finalResult, const QueueRouteSample& sample)
{
    if (sample.deviceSet) {
        tdt::UpdateFinalResultOnError(
            "aclrtResetDeviceForce(QueueRouteSample::kDeviceId)", aclrtResetDeviceForce(QueueRouteSample::kDeviceId),
            finalResult);
    }
    if (sample.aclInitialized) {
        tdt::UpdateFinalResultOnError("aclFinalize()", aclFinalize(), finalResult);
    }
}

void CleanupSample(QueueRouteSample& sample, int32_t& finalResult)
{
    CleanupRouteResources(sample, finalResult);
    CleanupQueues(sample, finalResult);
    CleanupAclRuntime(finalResult, sample);
}

} // namespace

int main()
{
    QueueRouteSample sample;
    int32_t finalResult = RunSample(sample);
    CleanupSample(sample, finalResult);
    if (finalResult == 0) {
        INFO_LOG("Run the queue_route sample successfully.");
    }
    return finalResult;
}
