/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "queue_process_ccpu.h"
#include "log_inner.h"
#include "runtime/rt_mem_queue.h"
#include "runtime/dev.h"
#include "aicpu/queue_schedule/qs_client.h"

namespace acl {
    aclError QueueProcessorCcpu::acltdtCreateQueue(const acltdtQueueAttr *const attr, uint32_t *const qid)
    {
        ACL_LOG_INFO("Start to create queue");
        ACL_REQUIRES_NOT_NULL(qid);
        ACL_REQUIRES_OK(acltdtCreateGroup());
        constexpr int32_t deviceId = 0;
        static bool isQueueIint = false;
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
        ACL_LOG_INFO("Successfully to execute create queue, qid is %u", *qid);
        return ACL_SUCCESS;
    }

    aclError QueueProcessorCcpu::acltdtCreateGroup()
    {
        static bool isGroupCreate = false;
        if (isGroupCreate) {
            return ACL_SUCCESS;
        }
        ACL_LOG_INFO("Start to create group");
        size_t grpNum = 0U;
        std::string grpName;
        const int32_t pid = mmGetPid();
        const std::lock_guard<std::mutex> groupLock(muForCreateGroup_);
        if (isGroupCreate) {
            return ACL_SUCCESS;
        }
        ACL_REQUIRES_OK(QueryGroup(pid, grpNum, grpName));
        if (grpNum == 0U) {
            ACL_LOG_INFO("need to create group");
            const rtMemGrpConfig_t grpConfig = {};
            const std::string gName = "acltdt" + std::to_string(pid);
            ACL_REQUIRES_CALL_RTS_OK(rtMemGrpCreate(gName.c_str(), &grpConfig), rtMemGrpCreate);

            rtMemGrpShareAttr_t shareAttr = {};
            shareAttr.admin = 1;
            shareAttr.read = 1;
            shareAttr.write = 1;
            shareAttr.alloc = 1;
            ACL_REQUIRES_CALL_RTS_OK(rtMemGrpAddProc(gName.c_str(), pid, &shareAttr), rtMemGrpAddProc);
            ACL_REQUIRES_CALL_RTS_OK(rtMemGrpAttach(gName.c_str(), 0), rtMemGrpAttach);
            ACL_REQUIRES_OK(QueryGroupId(gName));
        } else {
            ACL_REQUIRES_OK(QueryGroupId(grpName));
        }
        ACL_REQUIRES_OK(MbufInit());
        isGroupCreate = true;
        return ACL_SUCCESS;
    }

    aclError QueueProcessorCcpu::acltdtDestroyQueue(const uint32_t qid)
    {
        return acltdtDestroyQueueOndevice(qid, true);
    }

    aclError QueueProcessorCcpu::acltdtBindQueueRoutes(acltdtQueueRouteList *const qRouteList)
    {
        ACL_REQUIRES_NOT_NULL(qRouteList);
        ACL_LOG_INFO("Start to acltdtBindQueueRoutes, queue route is %zu", qRouteList->routeList.size());
        // qs is thread mode, so no need to grant queue to qs
        constexpr int32_t deviceId = 0;
        ACL_REQUIRES_OK(InitQueueSchedule(deviceId));
        // get dst id
        const int32_t dstPid = mmGetPid();
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
        if (!isQsInit_) {
            ACL_REQUIRES_OK(SendConnectQsMsg(deviceId, eventSum, ack));
            ACL_REQUIRES_CALL_RTS_OK(rtMemQueueAttach(deviceId, qsContactId_, 0), rtMemQueueAttach);
            isQsInit_ = true;
        }
        ACL_REQUIRES_OK(SendBindUnbindMsgOnDevice(qRouteList, true, eventSum, ack));
        ACL_LOG_INFO("Successfully to execute acltdtBindQueueRoutes, queue route is %zu",
                     qRouteList->routeList.size());
        return ACL_SUCCESS;
    }

    aclError QueueProcessorCcpu::acltdtUnbindQueueRoutes(acltdtQueueRouteList *const qRouteList)
    {
        ACL_REQUIRES_NOT_NULL(qRouteList);
        ACL_LOG_INFO("Start to acltdtUnBindQueueRoutes, queue route is %zu", qRouteList->routeList.size());
        // get dst id
        const int32_t dstPid = mmGetPid();
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

    aclError QueueProcessorCcpu::acltdtQueryQueueRoutes(const acltdtQueueRouteQueryInfo *const queryInfo,
                                                        acltdtQueueRouteList *const qRouteList)
    {
        ACL_REQUIRES_NOT_NULL(queryInfo);
        ACL_REQUIRES_NOT_NULL(qRouteList);
        ACL_LOG_INFO("Start to acltdtQueryQueueRoutes");
        constexpr int32_t deviceId = 0;
        // get dst id
        const int32_t dstPid = mmGetPid();
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

    aclError QueueProcessorCcpu::QueryGroup(const int32_t pid, size_t &grpNum, std::string &grpName) const
    {
        rtMemGrpQueryInput_t input = {};
        input.cmd = RT_MEM_GRP_QUERY_GROUPS_OF_PROCESS;
        input.grpQueryByProc.pid = pid;
        rtMemGrpQueryOutput_t output = {};
        rtMemGrpOfProc_t outputInfo[QUERY_BUFF_GRP_MAX_NUM] = {{}};
        output.groupsOfProc = outputInfo;
        output.maxNum = QUERY_BUFF_GRP_MAX_NUM;

        ACL_REQUIRES_CALL_RTS_OK(rtMemGrpQuery(&input, &output), rtMemGrpQuery);
        grpNum = output.resultNum;
        if (grpNum > 0) {
            grpName = std::string(output.groupsOfProc->groupName);
        }
        ACL_LOG_INFO("This proc [%d] has [%zu] group, name is %s", input.grpQueryByProc.pid,
                     grpNum, grpName.c_str());

        return ACL_SUCCESS;
    }

    aclError QueueProcessorCcpu::MbufInit() const
    {
        static bool isMbufInit = false;
        if (!isMbufInit) {
            rtMemBuffCfg_t cfg = {{}};
            const rtError_t ret = rtMbufInit(&cfg);
            if ((ret != ACL_RT_SUCCESS) && (ret != ACL_ERROR_RT_REPEATED_INIT)) {
                ACL_LOG_INNER_ERROR("mbuf init failed, ret is %d", ret);
                return ret;
            }
            isMbufInit = true;
        }
        return ACL_SUCCESS;
    }

    aclError QueueProcessorCcpu::acltdtAllocBuf(const size_t size, const uint32_t type, acltdtBuf *const buf)
    {
        ACL_REQUIRES_OK(acltdtCreateGroup());
        ACL_REQUIRES_OK(acltdtAllocBufData(size, type, buf));
        return ACL_SUCCESS;
    }
}
