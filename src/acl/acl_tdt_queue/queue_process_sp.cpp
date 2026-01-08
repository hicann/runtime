/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "queue_process_sp.h"
#include "log_inner.h"
#include "runtime/rt_mem_queue.h"
#include "runtime/dev.h"
#include "queue_schedule/qs_client.h"

namespace acl {
    aclError QueueProcessorSp::GrantQueue2Cp(const int32_t deviceId, const uint32_t qid) const
    {
        int32_t cpPid;
        // if cp is found
        if (GetDstInfo(deviceId, CP_PID, cpPid) == ACL_SUCCESS) {
            rtMemQueueShareAttr_t permission;
            ACL_REQUIRES_CALL_RTS_OK(GetQueuePermission(deviceId, qid, permission), GetQueuePermission);
            if (permission.manage != 0U) {
                ACL_REQUIRES_CALL_RTS_OK(rtMemQueueGrant(deviceId, qid, cpPid, &permission), rtMemQueueGrant);
            } else {
                ACL_LOG_INNER_ERROR("current process has no manage permission on qid %u", qid);
                return ACL_ERROR_FAILURE;
            }
        }
        return ACL_SUCCESS;
    }

    aclError QueueProcessorSp::acltdtCreateQueue(const acltdtQueueAttr *const attr, uint32_t *const qid)
    {
        ACL_LOG_INFO("Start to acltdtCreateQueue");
        ACL_REQUIRES_NOT_NULL(qid);
        constexpr int32_t deviceId = 0;
        static bool isQueueIint = false;
        const std::lock_guard<std::recursive_mutex> lk(muForQueueCtrl_);
        if (!isQueueIint) {
            ACL_LOG_INFO("need to init queue once");
            const rtError_t ret =  rtMemQueueInit(deviceId);
            if ((ret != ACL_RT_SUCCESS) && (ret != ACL_ERROR_RT_REPEATED_INIT)) {
                ACL_LOG_INNER_ERROR("queue init failed, ret is %d", ret);
                return ret;
            }
            isQueueIint = true;
        }

        ACL_REQUIRES_OK(acltdtCreateQueueWithAttr(deviceId, attr, qid));
        int32_t cpPid = 0;
        if (GetDstInfo(deviceId, CP_PID, cpPid) == ACL_SUCCESS) {
            ACL_LOG_INFO("get cp pid %d", cpPid);
            rtMemQueueShareAttr_t rtAttr = {0U, 0U, 0U, 0U};
            rtAttr.read = 1U;
            rtAttr.manage = 1U;
            rtAttr.write = 1U;
            ACL_REQUIRES_CALL_RTS_OK(rtMemQueueGrant(deviceId, *qid, cpPid, &rtAttr), rtMemQueueGrant);
        }
        ACL_LOG_INFO("Successfully to execute acltdtCreateQueue, qid is %u", *qid);
        return ACL_SUCCESS;
    }

    aclError QueueProcessorSp::acltdtDestroyQueue(const uint32_t qid)
    {
        return acltdtDestroyQueueOndevice(qid);
    }

    aclError QueueProcessorSp::acltdtGrantQueue(const uint32_t qid, const int32_t pid, const uint32_t permission,
        const int32_t timeout)
    {
        ACL_LOG_INFO("start to acltdtGrantQueue, qid is %u, pid is %d, permisiion is %u, timeout is %d",
                     qid, pid, permission, timeout);
        constexpr int32_t deviceId = 0;
        rtMemQueueShareAttr_t attr = {0U, 0U, 0U, 0U};
        attr.manage = permission & static_cast<uint32_t>(ACL_TDT_QUEUE_PERMISSION_MANAGE);
        attr.read = permission & static_cast<uint32_t>(ACL_TDT_QUEUE_PERMISSION_DEQUEUE);
        attr.write = permission & static_cast<uint32_t>(ACL_TDT_QUEUE_PERMISSION_ENQUEUE);
        const std::lock_guard<std::recursive_mutex> lk(muForQueueCtrl_);
        ACL_REQUIRES_CALL_RTS_OK(rtMemQueueGrant(deviceId, qid, pid, &attr), rtMemQueueGrant);
        ACL_LOG_INFO("successfully execute acltdtGrantQueue, qid is %u, pid is %d, permisiion is %u, timeout is %d",
                     qid, pid, permission, timeout);
        return ACL_SUCCESS;
    }

    aclError QueueProcessorSp::acltdtAttachQueue(const uint32_t qid, const int32_t timeout,
        uint32_t *const permission)
    {
        ACL_REQUIRES_NOT_NULL(permission);
        ACL_LOG_INFO("start to acltdtAttachQueue, qid is %u, permisiion is %u, timeout is %d",
                     qid, *permission, timeout);
        constexpr int32_t deviceId = 0;
        const std::lock_guard<std::recursive_mutex> lk(muForQueueCtrl_);
        ACL_REQUIRES_CALL_RTS_OK(rtMemQueueAttach(deviceId, qid, timeout), rtMemQueueAttach);
        (void)GrantQueue2Cp(deviceId, qid);
        rtMemQueueShareAttr_t attr;
        ACL_REQUIRES_CALL_RTS_OK(GetQueuePermission(deviceId, qid, attr), GetQueuePermission);
        uint32_t tmp = 0U;
        tmp = (attr.manage != 0) ? (tmp | static_cast<uint32_t>(ACL_TDT_QUEUE_PERMISSION_MANAGE)) : tmp;
        tmp = (attr.read != 0) ? (tmp | static_cast<uint32_t>(ACL_TDT_QUEUE_PERMISSION_DEQUEUE)) : tmp;
        tmp = (attr.write != 0) ? (tmp | static_cast<uint32_t>(ACL_TDT_QUEUE_PERMISSION_ENQUEUE)) : tmp;
        *permission = tmp;
        ACL_LOG_INFO("successfully execute acltdtAttachQueue, qid is %u, permisiion is %u, timeout is %d",
                     qid, *permission, timeout);
        return ACL_SUCCESS;
    }

    aclError QueueProcessorSp::acltdtBindQueueRoutes(acltdtQueueRouteList *const qRouteList)
    {
        ACL_REQUIRES_NOT_NULL(qRouteList);
        ACL_LOG_INFO("Start to acltdtBindQueueRoutes, queue route is %zu", qRouteList->routeList.size());
        constexpr int32_t deviceId = 0;
        // get dst id
        ACL_REQUIRES_OK(InitQueueSchedule(deviceId));
        int32_t dstPid = 0;
        ACL_REQUIRES_OK(GetDstInfo(deviceId, QS_PID, dstPid));
        const std::lock_guard<std::recursive_mutex> lk(muForQueueCtrl_);
        for (size_t i = 0UL; i < qRouteList->routeList.size(); ++i) {
            rtMemQueueShareAttr_t attrSrc = {0U, 0U, 0U, 0U};
            attrSrc.read = 1U;
            rtMemQueueShareAttr_t attrDst = {0U, 0U, 0U, 0U};
            attrDst.write = 1U;
            ACL_REQUIRES_CALL_RTS_OK(rtMemQueueGrant(deviceId, qRouteList->routeList[i].srcId, dstPid, &attrSrc),
                                     rtMemQueueGrant);
            ACL_REQUIRES_CALL_RTS_OK(rtMemQueueGrant(deviceId, qRouteList->routeList[i].dstId, dstPid, &attrDst),
                                     rtMemQueueGrant);
        }
        rtEschedEventSummary_t eventSum = {0, 0U, 0, 0U, 0U, nullptr, 0U, 0};
        rtEschedEventReply_t ack = {nullptr, 0U, 0U};
        bqs::QsProcMsgRsp qsRsp = {0UL, 0, 0U, 0U, 0U, {0}};
        eventSum.pid = dstPid;
        eventSum.grpId = bqs::BIND_QUEUE_GROUP_ID;
        eventSum.eventId = RT_MQ_SCHED_EVENT_QS_MSG;
        eventSum.dstEngine = static_cast<uint32_t>(RT_MQ_DST_ENGINE_CCPU_DEVICE);
        ack.buf = reinterpret_cast<char_t *>(&qsRsp);
        ack.bufLen = sizeof(qsRsp);
        if (!isQsInit_) {
            ACL_REQUIRES_OK(SendConnectQsMsg(deviceId, eventSum, ack));
            ACL_REQUIRES_CALL_RTS_OK(rtMemQueueAttach(deviceId, qsContactId_, 0), rtMemQueueAttach);
            isQsInit_ = true;
        }
        ACL_REQUIRES_OK(SendBindUnbindMsgOnDevice(qRouteList, true, eventSum, ack));
        ACL_LOG_INFO("Successfully to execute acltdtBindQueueRoutes, queue route is %zu", qRouteList->routeList.size());
        return ACL_SUCCESS;
    }

    aclError QueueProcessorSp::acltdtUnbindQueueRoutes(acltdtQueueRouteList *const qRouteList)
    {
        ACL_REQUIRES_NOT_NULL(qRouteList);
        ACL_LOG_INFO("Start to acltdtUnBindQueueRoutes, queue route is %zu", qRouteList->routeList.size());
        constexpr int32_t deviceId = 0;
        // get dst id
        int32_t dstPid = 0;
        ACL_REQUIRES_OK(GetDstInfo(deviceId, QS_PID, dstPid));
        rtEschedEventSummary_t eventSum = {0, 0U, 0, 0U, 0U, nullptr, 0U, 0};
        rtEschedEventReply_t ack = {nullptr, 0U, 0U};
        bqs::QsProcMsgRsp qsRsp = {0UL, 0, 0U, 0U, 0U, {0}};
        eventSum.pid = dstPid;
        eventSum.grpId = bqs::BIND_QUEUE_GROUP_ID;
        eventSum.eventId = RT_MQ_SCHED_EVENT_QS_MSG;
        eventSum.dstEngine = static_cast<uint32_t>(RT_MQ_DST_ENGINE_CCPU_DEVICE);
        ack.buf = reinterpret_cast<char_t *>(&qsRsp);
        ack.bufLen = sizeof(qsRsp);
        const std::lock_guard<std::recursive_mutex> lk(muForQueueCtrl_);
        ACL_REQUIRES_OK(SendBindUnbindMsgOnDevice(qRouteList, false, eventSum, ack));
        ACL_LOG_INFO("Successfully to execute acltdtUnBindQueueRoutes, queue route is %zu",
                     qRouteList->routeList.size());
        return ACL_SUCCESS;
    }

    aclError QueueProcessorSp::acltdtQueryQueueRoutes(const acltdtQueueRouteQueryInfo *const queryInfo,
                                                       acltdtQueueRouteList *const qRouteList)
    {
        ACL_REQUIRES_NOT_NULL(queryInfo);
        ACL_REQUIRES_NOT_NULL(qRouteList);
        ACL_LOG_INFO("Start to acltdtQueryQueueRoutes");
        constexpr int32_t deviceId = 0;
        // get dst id
        int32_t dstPid = 0;
        ACL_REQUIRES_OK(GetDstInfo(deviceId, QS_PID, dstPid));
        rtEschedEventSummary_t eventSum = {0, 0U, 0, 0U, 0U, nullptr, 0U, 0};
        rtEschedEventReply_t ack = {nullptr, 0U, 0U};
        bqs::QsProcMsgRsp qsRsp = {0UL, 0, 0U, 0U, 0U, {0}};
        eventSum.pid = dstPid;
        eventSum.grpId = bqs::BIND_QUEUE_GROUP_ID;
        eventSum.eventId = RT_MQ_SCHED_EVENT_QS_MSG;
        eventSum.dstEngine = static_cast<uint32_t>(RT_MQ_DST_ENGINE_CCPU_DEVICE);
        ack.buf = reinterpret_cast<char_t *>(&qsRsp);
        ack.bufLen = sizeof(qsRsp);
        const std::lock_guard<std::recursive_mutex> lk(muForQueueCtrl_);
        size_t routeNum = 0UL;
        ACL_REQUIRES_OK(GetQueueRouteNum(queryInfo, deviceId, eventSum, ack, routeNum));
        ACL_REQUIRES_OK(QueryQueueRoutesOnDevice(queryInfo, routeNum, eventSum, ack, qRouteList));
        return ACL_SUCCESS;
    }

    aclError QueueProcessorSp::acltdtAllocBuf(const size_t size, const uint32_t type, acltdtBuf *const buf)
    {
        if ((type != static_cast<uint32_t>(ACL_TDT_NORMAL_MEM)) && (type != static_cast<uint32_t>(ACL_TDT_DVPP_MEM))) {
            acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_MSG,
                std::vector<const char *>({"param", "value", "reason"}),
                std::vector<const char *>({"type", std::to_string(type).c_str(), "must be equal to zero currently"}));
            ACL_LOG_ERROR("[Check][Param]param type must be equal to zero currently");
            return ACL_ERROR_INVALID_PARAM;
        }
        ACL_REQUIRES_OK(QueryAllocGroup());
        ACL_REQUIRES_OK(acltdtAllocBufData(size, type, buf));
        return ACL_SUCCESS;
    }
}