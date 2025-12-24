/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "queue_process_host.h"
#include "log_inner.h"
#include "runtime/mem.h"
#include "runtime/rt_mem_queue.h"
#include "runtime/dev.h"
#include "aicpu/queue_schedule/qs_client.h"
#include "utils/math_utils.h"

namespace acl {
    aclError QueueProcessorHost::acltdtCreateQueue(const acltdtQueueAttr *const attr, uint32_t *const qid)
    {
        ACL_LOG_INFO("Start to acltdtCreateQueue");
        ACL_REQUIRES_NOT_NULL(qid);
        int32_t deviceId = 0;
        rtError_t rtRet = RT_ERROR_NONE;
        rtRet = rtGetDevice(&deviceId);
        if (rtRet != ACL_SUCCESS) {
            ACL_LOG_CALL_ERROR("[Get][DeviceId]fail to get deviceId errorCode = %d", rtRet);
            return rtRet;
        }
        const std::lock_guard<std::recursive_mutex> lk(muForQueueCtrl_);
        const rtError_t ret =  rtMemQueueInit(deviceId);
        if ((ret != ACL_RT_SUCCESS) && (ret != ACL_ERROR_RT_REPEATED_INIT)) {
            ACL_LOG_INNER_ERROR("queue init failed, ret is %d", ret);
            return ret;
        }
        ACL_REQUIRES_OK(acltdtCreateQueueWithAttr(deviceId, attr, qid));
        ACL_LOG_INFO("Successfully to execute acltdtCreateQueue, qid is %u", *qid);
        return ACL_SUCCESS;
    }

    aclError QueueProcessorHost::acltdtDestroyQueue(const uint32_t qid)
    {
        int32_t deviceId = 0;
        ACL_REQUIRES_CALL_RTS_OK(rtGetDevice(&deviceId), rtGetDevice);
        // get qs id
        int32_t qsPid = 0;
        size_t routeNum = 0UL;
        const std::lock_guard<std::recursive_mutex> lk(muForQueueCtrl_);
        if (GetDstInfo(deviceId, QS_PID, qsPid) == RT_ERROR_NONE) {
            rtEschedEventSummary_t eventSum = {0, 0U, 0, 0U, 0U, nullptr, 0U, 0};
            rtEschedEventReply_t ack = {nullptr, 0U, 0U};
            bqs::QsProcMsgRsp qsRsp = {0UL, 0, 0U, 0U, 0U, {0}};
            int32_t cpPid = 0;
            ACL_REQUIRES_OK(GetDstInfo(deviceId, CP_PID, cpPid));
            eventSum.pid = cpPid;
            eventSum.grpId = 0U;
            eventSum.eventId = RT_MQ_SCHED_EVENT_QS_MSG;
            eventSum.dstEngine = static_cast<uint32_t>(RT_MQ_DST_ENGINE_ACPU_DEVICE);
            ack.buf = reinterpret_cast<char_t *>(&qsRsp);
            ack.bufLen = sizeof(qsRsp);
            acltdtQueueRouteQueryInfo queryInfo = {bqs::BQS_QUERY_TYPE_SRC_OR_DST, qid, qid, true, true, true};
            ACL_REQUIRES_OK(GetQueueRouteNum(&queryInfo, deviceId, eventSum, ack, routeNum));
        }
        if (routeNum > 0UL) {
            ACL_LOG_ERROR("qid [%u] can not be destroyed, it need to be unbinded first.", qid);
            return ACL_ERROR_FAILURE;
        }
        ACL_REQUIRES_CALL_RTS_OK(rtMemQueueDestroy(deviceId, qid), rtMemQueueDestroy);
        DeleteMutexForData(qid);
        return ACL_SUCCESS;
    }

    aclError QueueProcessorHost::acltdtBindQueueRoutes(acltdtQueueRouteList *const qRouteList)
    {
        ACL_REQUIRES_NOT_NULL(qRouteList);
        ACL_LOG_INFO("Start to acltdtBindQueueRoutes, queue route is %zu", qRouteList->routeList.size());
        int32_t deviceId = 0;
        ACL_REQUIRES_CALL_RTS_OK(rtGetDevice(&deviceId), rtGetDevice);
        ACL_REQUIRES_OK(InitQueueSchedule(deviceId));
        // get dst pid
        int32_t dstPid = 0;
        ACL_REQUIRES_OK(GetDstInfo(deviceId, CP_PID, dstPid));
        rtEschedEventSummary_t eventSum = {0, 0U, 0, 0U, 0U, nullptr, 0U, 0};
        rtEschedEventReply_t ack = {nullptr, 0U, 0U};
        bqs::QsProcMsgRsp qsRsp = {0UL, 0, 0U, 0U, 0U, {0}};
        eventSum.pid = dstPid;
        eventSum.grpId = 0U;
        eventSum.eventId = RT_MQ_SCHED_EVENT_QS_MSG;
        eventSum.dstEngine = static_cast<uint32_t>(RT_MQ_DST_ENGINE_ACPU_DEVICE);
        ack.buf = reinterpret_cast<char_t *>(&qsRsp);
        ack.bufLen = sizeof(qsRsp);
        const std::lock_guard<std::recursive_mutex> lk(muForQueueCtrl_);
        if (!isQsInit_) {
            ACL_REQUIRES_OK(SendConnectQsMsg(deviceId, eventSum, ack));
            isQsInit_ = true;
        }
        ACL_REQUIRES_OK(SendBindUnbindMsg(deviceId, qRouteList, true, eventSum, ack));
        ACL_LOG_INFO("Successfully to execute acltdtBindQueueRoutes, queue route is %zu", qRouteList->routeList.size());
        return ACL_SUCCESS;
    }

    aclError QueueProcessorHost::acltdtUnbindQueueRoutes(acltdtQueueRouteList *const qRouteList)
    {
        ACL_REQUIRES_NOT_NULL(qRouteList);
        ACL_LOG_INFO("Start to acltdtUnBindQueueRoutes, queue route is %zu", qRouteList->routeList.size());
        int32_t deviceId = 0;
        ACL_REQUIRES_CALL_RTS_OK(rtGetDevice(&deviceId), rtGetDevice);
        // get dst pid
        int32_t dstPid = 0;
        ACL_REQUIRES_OK(GetDstInfo(deviceId, CP_PID, dstPid));
        rtEschedEventSummary_t eventSum = {0, 0U, 0, 0U, 0U, nullptr, 0U, 0};
        rtEschedEventReply_t ack = {nullptr, 0U, 0U};
        bqs::QsProcMsgRsp qsRsp = {0UL, 0, 0U, 0U, 0U, {0}};
        eventSum.pid = dstPid;
        eventSum.grpId = 0U;
        eventSum.eventId = RT_MQ_SCHED_EVENT_QS_MSG;
        eventSum.dstEngine = static_cast<uint32_t>(RT_MQ_DST_ENGINE_ACPU_DEVICE);
        ack.buf = reinterpret_cast<char_t *>(&qsRsp);
        ack.bufLen = sizeof(qsRsp);
        const std::lock_guard<std::recursive_mutex> lk(muForQueueCtrl_);
        ACL_REQUIRES_OK(SendBindUnbindMsg(deviceId, qRouteList, false, eventSum, ack));
        ACL_LOG_INFO("Successfully to execute acltdtUnBindQueueRoutes, queue route is %zu",
                     qRouteList->routeList.size());
        return ACL_SUCCESS;
    }

    aclError QueueProcessorHost::acltdtQueryQueueRoutes(const acltdtQueueRouteQueryInfo *const queryInfo,
                                                        acltdtQueueRouteList *const qRouteList)
    {
        ACL_REQUIRES_NOT_NULL(queryInfo);
        ACL_REQUIRES_NOT_NULL(qRouteList);
        ACL_LOG_INFO("Start to acltdtQueryQueueRoutes");
        int32_t deviceId = 0;
        ACL_REQUIRES_CALL_RTS_OK(rtGetDevice(&deviceId), rtGetDevice);
        // get dst id
        int32_t dstPid = 0;
        ACL_REQUIRES_OK(GetDstInfo(deviceId, CP_PID, dstPid));
        rtEschedEventSummary_t eventSum = {0, 0U, 0, 0U, 0U, nullptr, 0U, 0};
        rtEschedEventReply_t ack = {nullptr, 0U, 0U};
        bqs::QsProcMsgRsp qsRsp = {0UL, 0, 0U, 0U, 0U, {0}};
        eventSum.pid = dstPid;
        eventSum.grpId = 0U;
        eventSum.eventId = RT_MQ_SCHED_EVENT_QS_MSG;
        eventSum.dstEngine = static_cast<uint32_t>(RT_MQ_DST_ENGINE_ACPU_DEVICE);
        ack.buf = reinterpret_cast<char_t *>(&qsRsp);
        ack.bufLen = sizeof(qsRsp);
        const std::lock_guard<std::recursive_mutex> lk(muForQueueCtrl_);
        size_t routeNum = 0UL;
        ACL_REQUIRES_OK(GetQueueRouteNum(queryInfo, deviceId, eventSum, ack, routeNum));
        ACL_REQUIRES_OK(QueryQueueRoutes(deviceId, queryInfo, routeNum, eventSum, ack, qRouteList));
        return ACL_SUCCESS;
    }

    aclError QueueProcessorHost::SendBindUnbindMsg(const int32_t deviceId, acltdtQueueRouteList *const qRouteList,
        const bool isBind, rtEschedEventSummary_t &eventSum, rtEschedEventReply_t &ack) const
    {
        ACL_LOG_INFO("start to send bind or unbind msg");
        // send bind or unbind msg
        size_t routeListBody = 0U;
        ACL_CHECK_ASSIGN_SIZET_MULTI(qRouteList->routeList.size(), sizeof(bqs::QueueRoute), routeListBody);
        size_t routeSize = 0U;
        ACL_CHECK_ASSIGN_SIZET_ADD(sizeof(bqs::QsRouteHead), routeListBody, routeSize);
        ACL_LOG_INFO("route size is %zu, queue route num is %zu", routeSize, qRouteList->routeList.size());
        void *devPtr = nullptr;
        constexpr uint32_t flags = RT_MEMORY_DEFAULT | RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY;
        ACL_REQUIRES_CALL_RTS_OK(rtMalloc(&devPtr, routeSize, flags, acl::ACL_MODE_ID_U16), rtMalloc);
        ACL_CHECK_MALLOC_RESULT(devPtr);
        (void)rtMemset(devPtr, routeSize, 0U, routeSize);
        bqs::QsRouteHead head = {0U, 0U, 0U, 0UL};
        head.length = routeSize;
        head.routeNum = qRouteList->routeList.size();
        head.subEventId =
            isBind ? static_cast<uint32_t>(bqs::ACL_BIND_QUEUE) : static_cast<uint32_t>(bqs::ACL_UNBIND_QUEUE);
        auto ret = rtMemcpy(devPtr, routeSize, &head, sizeof(head), RT_MEMCPY_HOST_TO_DEVICE);
        if (ret != ACL_RT_SUCCESS) {
            ACL_LOG_INNER_ERROR("call rtMemcpy failed ,ret is %d", ret);
            (void)rtFree(devPtr);
            devPtr = nullptr;
            return ret;
        }
        size_t offset = sizeof(bqs::QsRouteHead);
        for (size_t i = 0UL; i < qRouteList->routeList.size(); ++i) {
            bqs::QueueRoute tmpRoute = {0U, 0U, 0, 0, 0, 0UL, 0UL, {0}};
            tmpRoute.srcId = qRouteList->routeList[i].srcId;
            tmpRoute.dstId = qRouteList->routeList[i].dstId;
            ret = rtMemcpy((static_cast<uint8_t *>(devPtr) + offset), (routeSize - offset), &tmpRoute,
                sizeof(tmpRoute), RT_MEMCPY_HOST_TO_DEVICE);
            if (ret != ACL_RT_SUCCESS) {
                ACL_LOG_INNER_ERROR("call rtMemcpy failed ,ret is %d", ret);
                (void)rtFree(devPtr);
                devPtr = nullptr;
                return ret;
            }
            offset += sizeof(bqs::QueueRoute);
        }

        bqs::QueueRouteList bqsBindUnbindMsg = {0U, 0U, {0}};
        bqsBindUnbindMsg.routeListMsgAddr = reinterpret_cast<uintptr_t>(devPtr);
        eventSum.subeventId =
            isBind ? static_cast<uint32_t>(bqs::ACL_BIND_QUEUE) : static_cast<uint32_t>(bqs::ACL_UNBIND_QUEUE);
        eventSum.msgLen = sizeof(bqsBindUnbindMsg);
        eventSum.msg = reinterpret_cast<char_t *>(&bqsBindUnbindMsg);
        ret = rtEschedSubmitEventSync(deviceId, &eventSum, &ack);
        eventSum.msgLen = 0U;
        eventSum.msg = nullptr;
        if (ret != RT_ERROR_NONE) {
            ACL_LOG_CALL_ERROR("[Call][Rts]call rts api rtEschedSubmitEventSync failed.");
            (void)rtFree(devPtr);
            devPtr = nullptr;
            return ret;
        }
        bqs::QsProcMsgRsp *const rsp = reinterpret_cast<bqs::QsProcMsgRsp *>(ack.buf);
        if (rsp->retCode != 0) {
            ACL_LOG_INNER_ERROR("send connet qs failed, ret code id %d", rsp->retCode);
            (void)rtFree(devPtr);
            devPtr = nullptr;
            return ACL_ERROR_FAILURE;
        }
        offset = sizeof(bqs::QsRouteHead);
        for (size_t i = 0UL; i < qRouteList->routeList.size(); ++i) {
            bqs::QueueRoute retRoute = {0U, 0U, 0, 0, 0, 0UL, 0UL, {0}};
            ret = rtMemcpy(&retRoute, sizeof(retRoute), (static_cast<uint8_t *>(devPtr) + offset),
                sizeof(retRoute), RT_MEMCPY_DEVICE_TO_HOST);
            if (ret != ACL_RT_SUCCESS) {
                ACL_LOG_INNER_ERROR("call rtMemcpy failed, ret is %d", ret);
                (void)rtFree(devPtr);
                devPtr = nullptr;
                return ret;
            }
            qRouteList->routeList[i].status = retRoute.status;
            ACL_LOG_INFO("route %zu, srcqid is %u, dst pid is %u, status is %d", i, qRouteList->routeList[i].srcId,
                qRouteList->routeList[i].dstId, qRouteList->routeList[i].status);
            offset += sizeof(bqs::QueueRoute);
        }
        (void)rtFree(devPtr);
        devPtr = nullptr;
        return ret;
    }

    aclError QueueProcessorHost::QueryQueueRoutes(const int32_t deviceId,
        const acltdtQueueRouteQueryInfo *const queryInfo,
        const size_t routeNum, rtEschedEventSummary_t &eventSum,
        rtEschedEventReply_t &ack, acltdtQueueRouteList *const qRouteList) const
    {
        ACL_LOG_INFO("start to query queue route %zu", routeNum);
        if (routeNum == 0U) {
            return ACL_SUCCESS;
        }
        size_t routeListBody = 0U;
        ACL_CHECK_ASSIGN_SIZET_MULTI(routeNum, sizeof(bqs::QueueRoute), routeListBody);
        size_t routeSize = 0U;
        ACL_CHECK_ASSIGN_SIZET_ADD((sizeof(bqs::QsRouteHead) + sizeof(bqs::QueueRouteQuery)), routeListBody, routeSize);
        ACL_LOG_INFO("route size is %zu, queue route num is %zu", routeSize, qRouteList->routeList.size());
        void *devPtr = nullptr;
        constexpr uint32_t flags = RT_MEMORY_DEFAULT | RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY;
        ACL_REQUIRES_CALL_RTS_OK(rtMalloc(&devPtr, routeSize, flags, acl::ACL_MODE_ID_U16), rtMalloc);
        ACL_CHECK_MALLOC_RESULT(devPtr);
        (void)rtMemset(devPtr, routeSize, 0U, routeSize);
        bqs::QsRouteHead head = {0U, 0U, 0U, 0UL};
        head.length = routeSize;
        head.routeNum = routeNum;
        head.subEventId = bqs::ACL_QUERY_QUEUE;
        auto ret = rtMemcpy(devPtr, routeSize, &head, sizeof(head), RT_MEMCPY_HOST_TO_DEVICE);
        if (ret != ACL_RT_SUCCESS) {
            ACL_LOG_INNER_ERROR("call rtMemcpy failed ,ret is %d", ret);
            (void)rtFree(devPtr);
            devPtr = nullptr;
            return ret;
        }
        size_t offset = sizeof(bqs::QsRouteHead);
        bqs::QueueRouteQuery routeQuery = {0UL, 0U, 0U, 0U, 0, 0, 0UL, {0}};
        routeQuery.queryType = static_cast<uint32_t>(queryInfo->mode);
        routeQuery.srcId = queryInfo->srcId;
        routeQuery.dstId = queryInfo->dstId;
        ret = rtMemcpy((static_cast<uint8_t *>(devPtr) + offset), (routeSize - offset), &routeQuery,
            sizeof(routeQuery), RT_MEMCPY_HOST_TO_DEVICE);
        if (ret != ACL_RT_SUCCESS) {
            ACL_LOG_INNER_ERROR("call rtMemcpy failed ,ret is %d", ret);
            (void)rtFree(devPtr);
            devPtr = nullptr;
            return ret;
        }

        bqs::QueueRouteList qsCommonMsg = {0U, 0U, {0}};
        qsCommonMsg.routeListMsgAddr = reinterpret_cast<uintptr_t>(devPtr);
        eventSum.subeventId = bqs::ACL_QUERY_QUEUE;
        eventSum.msgLen = sizeof(qsCommonMsg);
        eventSum.msg = reinterpret_cast<char_t *>(&qsCommonMsg);

        ret = rtEschedSubmitEventSync(deviceId, &eventSum, &ack);
        eventSum.msgLen = 0U;
        eventSum.msg = nullptr;
        if (ret != RT_ERROR_NONE) {
            (void)rtFree(devPtr);
            devPtr = nullptr;
            return ret;
        }
        bqs::QsProcMsgRsp *const rsp = reinterpret_cast<bqs::QsProcMsgRsp *>(ack.buf);
        if (rsp->retCode != 0) {
            ACL_LOG_INNER_ERROR("query queue route failed, ret code id %d", rsp->retCode);
            (void)rtFree(devPtr);
            devPtr = nullptr;
            return ACL_ERROR_FAILURE;
        }
        offset = sizeof(bqs::QsRouteHead) + sizeof(bqs::QueueRouteQuery);
        for (size_t i = 0UL; i < routeNum; ++i) {
            bqs::QueueRoute retRoute = {0U, 0U, 0, 0, 0, 0UL, 0UL, {0}};
            ret = rtMemcpy(&retRoute, sizeof(retRoute), (static_cast<uint8_t *>(devPtr) + offset),
                sizeof(retRoute), RT_MEMCPY_DEVICE_TO_HOST);
            if (ret != ACL_RT_SUCCESS) {
                ACL_LOG_INNER_ERROR("call rtMemcpy failed ,ret is %d", ret);
                (void)rtFree(devPtr);
                devPtr = nullptr;
                return ret;
            }
            const acltdtQueueRoute tmpQueueRoute = {retRoute.srcId, retRoute.dstId, retRoute.status};
            qRouteList->routeList.push_back(tmpQueueRoute);
            ACL_LOG_INFO("route %zu, srcqid is %u, dst pid is %u, status is %d", i, qRouteList->routeList[i].srcId,
                qRouteList->routeList[i].dstId, qRouteList->routeList[i].status);
            offset += sizeof(bqs::QueueRoute);
        }
        (void)rtFree(devPtr);
        devPtr = nullptr;
        ACL_LOG_INFO("Successfully to execute acltdtQueryQueueRoutes, queue route is %zu",
                     qRouteList->routeList.size());
        return ACL_SUCCESS;
    }

    aclError QueueProcessorHost::acltdtEnqueue(const uint32_t qid, const acltdtBuf buf, const int32_t timeout)
    {
        (void)(qid);
        (void)(buf);
        (void)(timeout);
        ACL_LOG_ERROR("[Unsupport][Feature]acltdtEnqueue is not supported in this version. Please check.");
        const char_t *argList[] = {"feature", "reason"};
        const char_t *argVal[] = {"acltdtEnqueue", "please check"};
        acl::AclErrorLogManager::ReportInputErrorWithChar(acl::UNSUPPORTED_FEATURE_MSG, argList, argVal, 2UL);
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }

    aclError QueueProcessorHost::acltdtDequeue(const uint32_t qid, acltdtBuf *const buf, const int32_t timeout)
    {
        (void)(qid);
        (void)(buf);
        (void)(timeout);
        ACL_LOG_ERROR("[Unsupport][Feature]acltdtDequeue is not supported in this version. Please check.");
        const char_t *argList[] = {"feature", "reason"};
        const char_t *argVal[] = {"acltdtDequeue", "please check"};
        acl::AclErrorLogManager::ReportInputErrorWithChar(acl::UNSUPPORTED_FEATURE_MSG, argList, argVal, 2UL);
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }

    aclError QueueProcessorHost::acltdtAllocBuf(const size_t size, const uint32_t type, acltdtBuf *const buf)
    {
        (void)(size);
        (void)(type);
        (void)(buf);
        ACL_LOG_ERROR("[Unsupport][Feature]acltdtAllocBuf is not supported in this version. Please check.");
        const char_t *argList[] = {"feature", "reason"};
        const char_t *argVal[] = {"acltdtAllocBuf", "please check"};
        acl::AclErrorLogManager::ReportInputErrorWithChar(acl::UNSUPPORTED_FEATURE_MSG, argList, argVal, 2UL);
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }

    aclError QueueProcessorHost::acltdtFreeBuf(acltdtBuf buf)
    {
        (void)(buf);
        ACL_LOG_ERROR("[Unsupport][Feature]acltdtFreeBuf is not supported in this version. Please check.");
        const char_t *argList[] = {"feature", "reason"};
        const char_t *argVal[] = {"acltdtFreeBuf", "please check"};
        acl::AclErrorLogManager::ReportInputErrorWithChar(acl::UNSUPPORTED_FEATURE_MSG, argList, argVal, 2UL);
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }

    aclError QueueProcessorHost::acltdtGetBufData(const acltdtBuf buf, void **const dataPtr, size_t *const size)
    {
        (void)(buf);
        (void)(dataPtr);
        (void)(size);
        ACL_LOG_ERROR("[Unsupport][Feature]acltdtGetBufData is not supported in this version. Please check.");
        const char_t *argList[] = {"feature", "reason"};
        const char_t *argVal[] = {"acltdtGetBufData", "please check"};
        acl::AclErrorLogManager::ReportInputErrorWithChar(acl::UNSUPPORTED_FEATURE_MSG, argList, argVal, 2UL);
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }

    aclError QueueProcessorHost::acltdtGetBufUserData(const acltdtBuf buf, void *dataPtr,
                                                      const size_t size, const size_t offset)
    {
        (void)(buf);
        (void)(dataPtr);
        (void)(size);
        (void)(offset);
        ACL_LOG_ERROR("[Unsupport][Feature]acltdtGetBufUserData is not supported in this version. Please check.");
        const char_t *argList[] = {"feature", "reason"};
        const char_t *argVal[] = {"acltdtGetBufUserData", "please check"};
        acl::AclErrorLogManager::ReportInputErrorWithChar(acl::UNSUPPORTED_FEATURE_MSG, argList, argVal, 2UL);
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }

    aclError QueueProcessorHost::acltdtSetBufUserData(acltdtBuf buf, const void *dataPtr,
                                                      const size_t size, const size_t offset)
    {
        (void)(buf);
        (void)(dataPtr);
        (void)(size);
        (void)(offset);
        ACL_LOG_ERROR("[Unsupport][Feature]acltdtSetBufUserData is not supported in this version. Please check.");
        const char_t *argList[] = {"feature", "reason"};
        const char_t *argVal[] = {"acltdtSetBufUserData", "please check"};
        acl::AclErrorLogManager::ReportInputErrorWithChar(acl::UNSUPPORTED_FEATURE_MSG, argList, argVal, 2UL);
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }

    aclError QueueProcessorHost::acltdtCopyBufRef(const acltdtBuf buf, acltdtBuf *const newBuf)
    {
        (void)(buf);
        (void)(newBuf);
        ACL_LOG_ERROR("[Unsupport][Feature]acltdtCopyBufRef is not supported in this version. Please check.");
        const char_t *argList[] = {"feature", "reason"};
        const char_t *argVal[] = {"acltdtCopyBufRef", "please check"};
        acl::AclErrorLogManager::ReportInputErrorWithChar(acl::UNSUPPORTED_FEATURE_MSG, argList, argVal, 2UL);
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }

    aclError QueueProcessorHost::acltdtSetBufDataLen(const acltdtBuf buf, const size_t len)
    {
        (void)(buf);
        (void)(len);
        ACL_LOG_ERROR("[Unsupport][Feature]acltdtSetBufDataLen is not supported in this version. Please check.");
        const char_t *argList[] = {"feature", "reason"};
        const char_t *argVal[] = {"acltdtSetBufDataLen", "please check"};
        acl::AclErrorLogManager::ReportInputErrorWithChar(acl::UNSUPPORTED_FEATURE_MSG, argList, argVal, 2UL);
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }

    aclError QueueProcessorHost::acltdtGetBufDataLen(const acltdtBuf buf, size_t *const len)
    {
        (void)(buf);
        (void)(len);
        ACL_LOG_ERROR("[Unsupport][Feature]acltdtGetBufDataLen is not supported in this version. Please check.");
        const char_t *argList[] = {"feature", "reason"};
        const char_t *argVal[] = {"acltdtGetBufDataLen", "please check"};
        acl::AclErrorLogManager::ReportInputErrorWithChar(acl::UNSUPPORTED_FEATURE_MSG, argList, argVal, 2UL);
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }

    aclError QueueProcessorHost::acltdtAppendBufChain(const acltdtBuf headBuf, const acltdtBuf buf)
    {
        (void)(buf);
        (void)(headBuf);
        ACL_LOG_ERROR("[Unsupport][Feature]acltdtAppendBufChain is not supported in this version. Please check.");
        const char_t *argList[] = {"feature", "reason"};
        const char_t *argVal[] = {"acltdtAppendBufChain", "please check"};
        acl::AclErrorLogManager::ReportInputErrorWithChar(acl::UNSUPPORTED_FEATURE_MSG, argList, argVal, 2UL);
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }

    aclError QueueProcessorHost::acltdtGetBufChainNum(const acltdtBuf headBuf, uint32_t *const num)
    {
        (void)(headBuf);
        (void)(num);
        ACL_LOG_ERROR("[Unsupport][Feature]acltdtGetBufChainNum is not supported in this version. Please check.");
        const char_t *argList[] = {"feature", "reason"};
        const char_t *argVal[] = {"acltdtGetBufChainNum", "please check"};
        acl::AclErrorLogManager::ReportInputErrorWithChar(acl::UNSUPPORTED_FEATURE_MSG, argList, argVal, 2UL);
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }

    aclError QueueProcessorHost::acltdtGetBufFromChain(const acltdtBuf headBuf,
        const uint32_t index, acltdtBuf *const buf)
    {
        (void)(buf);
        (void)(headBuf);
        (void)(index);
        ACL_LOG_ERROR("[Unsupport][Feature]acltdtGetBufFromChain is not supported in this version. Please check.");
        const char_t *argList[] = {"feature", "reason"};
        const char_t *argVal[] = {"acltdtGetBufFromChain", "please check"};
        acl::AclErrorLogManager::ReportInputErrorWithChar(acl::UNSUPPORTED_FEATURE_MSG, argList, argVal, 2UL);
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }
}
