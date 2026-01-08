/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "queue_process.h"
#include "log_inner.h"
#include "runtime/rt_mem_queue.h"
#include "runtime/dev.h"
#include "queue_schedule/qs_client.h"

namespace acl {
    constexpr uint32_t RT_MQ_DEPTH_DEFAULT = 8U;
    constexpr uint16_t MBUF_ENHANCED_QS = 2U;
    constexpr uint16_t MBUF_ENHANCED_ACL = 1U;
    bool QueueProcessor::isInitQs_ = false;
    bool QueueProcessor::isMbufInit_ = false;

    aclError QueueProcessor::acltdtEnqueue(const uint32_t qid, const acltdtBuf buf, const int32_t timeout)
    {
        ACL_REQUIRES_NOT_NULL(buf);
        const QueueDataMutexPtr muPtr = GetMutexForData(qid);
        ACL_CHECK_MALLOC_RESULT(muPtr);
        const uint64_t startTime = GetTimestamp();
        uint64_t endTime = 0U;
        bool continueFlag = false;
        do {
            const std::lock_guard<std::mutex> lk(muPtr->muForDequeue);
            constexpr int32_t deviceId = 0;
            const rtError_t rtRet = rtMemQueueEnQueue(deviceId, qid, buf);
            if (rtRet == RT_ERROR_NONE) {
                return ACL_SUCCESS;
            }
            if (rtRet != ACL_ERROR_RT_QUEUE_FULL) {
                ACL_LOG_CALL_ERROR("[Enqueue][Queue]fail to enqueue result = %d", rtRet);
                return rtRet;
            }
            (void)mmSleep(1U); // sleep 1ms
            endTime = GetTimestamp();
            continueFlag =
                ((endTime - startTime) <= (static_cast<uint64_t>(timeout) * static_cast<uint64_t>(MSEC_TO_USEC)));
        } while (continueFlag || (timeout < 0));
        return ACL_ERROR_FAILURE;
    }

    aclError QueueProcessor::acltdtDequeue(const uint32_t qid, acltdtBuf *const buf, const int32_t timeout)
    {
        ACL_REQUIRES_NOT_NULL(buf);
        const QueueDataMutexPtr muPtr = GetMutexForData(qid);
        ACL_CHECK_MALLOC_RESULT(muPtr);
        const uint64_t startTime = GetTimestamp();
        uint64_t endTime = 0U;
        bool continueFlag = false;
        do {
            const std::lock_guard<std::mutex> lk(muPtr->muForEnqueue);
            constexpr int32_t deviceId = 0;
            const rtError_t rtRet = rtMemQueueDeQueue(deviceId, qid, buf);
            if (rtRet == RT_ERROR_NONE) {
                return ACL_SUCCESS;
            }
            if (rtRet != ACL_ERROR_RT_QUEUE_EMPTY) {
                ACL_LOG_CALL_ERROR("[Dequeue][Queue]fail to dequeue result = %d", rtRet);
                return rtRet;
            }
            (void)mmSleep(1U); // sleep 1ms
            endTime = GetTimestamp();
            continueFlag =
                ((endTime - startTime) <= (static_cast<uint64_t>(timeout) * static_cast<uint64_t>(MSEC_TO_USEC)));
        } while (continueFlag || (timeout < 0));
        return ACL_ERROR_FAILURE;
    }

    aclError QueueProcessor::acltdtGrantQueue(const uint32_t qid, const int32_t pid, const uint32_t permission,
        const int32_t timeout)
    {
        (void)(qid);
        (void)(pid);
        (void)(permission);
        (void)(timeout);
        ACL_LOG_ERROR("[Unsupport][Feature]acltdtGrantQueue is not supported in this version. Please check.");
        const char_t *argList[] = {"feature", "reason"};
        const char_t *argVal[] = {"acltdtGrantQueue", "please check"};
        acl::AclErrorLogManager::ReportInputErrorWithChar(acl::UNSUPPORTED_FEATURE_MSG, argList, argVal, 2UL);
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }

    aclError QueueProcessor::acltdtAttachQueue(const uint32_t qid, const int32_t timeout,
        uint32_t *const permission)
    {
        (void)(qid);
        (void)(permission);
        (void)(timeout);
        ACL_LOG_ERROR("[Unsupport][Feature]acltdtAttachQueue is not supported in this version. Please check.");
        const char_t *argList[] = {"feature", "reason"};
        const char_t *argVal[] = {"acltdtAttachQueue", "please check"};
        acl::AclErrorLogManager::ReportInputErrorWithChar(acl::UNSUPPORTED_FEATURE_MSG, argList, argVal, 2UL);
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }

    aclError QueueProcessor::acltdtDestroyQueueOndevice(const uint32_t qid, const bool isThreadMode)
    {
        ACL_LOG_INFO("Start to destroy queue %u", qid);
        constexpr int32_t deviceId = 0;
        // get qs id
        int32_t dstPid = 0;
        size_t routeNum = 0UL;
        const std::lock_guard<std::recursive_mutex> lk(muForQueueCtrl_);
        if (GetDstInfo(deviceId, QS_PID, dstPid, isThreadMode) == ACL_SUCCESS) {
            ACL_LOG_INFO("find qs pid %d", dstPid);
            rtEschedEventSummary_t eventSum = {0, 0U, 0, 0U, 0U, nullptr, 0U, 0};
            rtEschedEventReply_t ack = {nullptr, 0U, 0U};
            bqs::QsProcMsgRsp qsRsp = {0UL, 0, 0U, 0U, 0U, {0}};
            eventSum.pid = dstPid;
            eventSum.grpId = bqs::BIND_QUEUE_GROUP_ID;
            eventSum.eventId = RT_MQ_SCHED_EVENT_QS_MSG; // qs EVENT_ID
            eventSum.dstEngine = static_cast<uint32_t>(RT_MQ_DST_ENGINE_CCPU_DEVICE);
            ack.buf = reinterpret_cast<char_t *>(&qsRsp);
            ack.bufLen = sizeof(qsRsp);
            const acltdtQueueRouteQueryInfo queryInfo = {bqs::BQS_QUERY_TYPE_SRC_OR_DST, qid, qid, true, true, true};
            ACL_REQUIRES_OK(GetQueueRouteNum(&queryInfo, deviceId, eventSum, ack, routeNum));
        }
        if (routeNum > 0U) {
            ACL_LOG_ERROR("qid [%u] can not be destroyed, it need to be unbinded first.", qid);
            return ACL_ERROR_FAILURE;
        }
        ACL_REQUIRES_CALL_RTS_OK(rtMemQueueDestroy(deviceId, qid), rtMemQueueDestroy);
        DeleteMutexForData(qid);
        ACL_LOG_INFO("successfully to execute destroy queue %u", qid);
        return ACL_SUCCESS;
    }

    aclError QueueProcessor::GetQueuePermission(const int32_t deviceId, uint32_t qid,
        rtMemQueueShareAttr_t &permission) const
    {
        uint32_t outLen = sizeof(permission);
        if (rtMemQueueQuery(deviceId, RT_MQ_QUERY_QUE_ATTR_OF_CUR_PROC,
                            &qid, sizeof(qid), &permission, &outLen) != RT_ERROR_NONE) {
            ACL_LOG_INNER_ERROR("get queue permission failed");
            return ACL_ERROR_FAILURE;
        }
        return ACL_SUCCESS;
    }

    aclError QueueProcessor::InitQueueSchedule(const int32_t devId) const
    {
        if (!isInitQs_) {
            ACL_LOG_INFO("need to init queue schedule");
            ACL_REQUIRES_CALL_RTS_OK(rtMemQueueInitQS(devId, nullptr), rtMemQueueInitQS);
            isInitQs_ = true;
        }
        return ACL_SUCCESS;
    }

    aclError QueueProcessor::GetDstInfo(const int32_t deviceId, const PID_QUERY_TYPE type,
        int32_t &dstPid, const bool isThreadMode) const
    {
        if (isThreadMode && isInitQs_) {
            dstPid = mmGetPid();
            return ACL_SUCCESS;
        }
        rtBindHostpidInfo_t info = {0, 0U, 0U, 0};
        info.hostPid = mmGetPid();
        if (type == CP_PID) {
            info.cpType = RT_DEV_PROCESS_CP1;
        } else {
            info.cpType = RT_DEV_PROCESS_QS;
        }
        info.chipId = static_cast<uint32_t>(deviceId);
        ACL_LOG_INFO("start to get dst pid, deviceId is %d, type is %d", deviceId, type);
        const auto ret = rtQueryDevPid(&info, &dstPid);
        if (ret != ACL_RT_SUCCESS) {
            ACL_LOG_INFO("can not query device pid");
            return ret;
        }
        ACL_LOG_INFO("get dst pid %d success, type is %d", dstPid, type);
        return ACL_SUCCESS;
    }

    static aclError AllocMBufOnDevice(void **const devPtr, void **const mBuf, const size_t size)
    {
        ACL_REQUIRES_CALL_RTS_OK(rtMbufAlloc(mBuf, size), rtMbufAlloc);
        ACL_CHECK_MALLOC_RESULT(*mBuf);
        if (rtMbufGetBuffAddr(*mBuf, devPtr) != RT_ERROR_NONE) {
            (void)rtMbufFree(*mBuf);
            ACL_LOG_INNER_ERROR("[Get][mbuf]get mbuf failed.");
            return ACL_ERROR_BAD_ALLOC;
        }
        if (*devPtr == nullptr) {
            (void)rtMbufFree(*mBuf);
            ACL_LOG_INNER_ERROR("[Get][mbuf]get dataPtr failed.");
            return ACL_ERROR_BAD_ALLOC;
        }
        (void)memset_s(*devPtr, size, 0, size);
        return ACL_SUCCESS;
    }

    aclError QueueProcessor::SendConnectQsMsg(const int32_t deviceId,
                                              rtEschedEventSummary_t &eventSum,
                                              rtEschedEventReply_t &ack)
    {
        // send contact msg
        ACL_LOG_INFO("start to send contact msg");
        bqs::QsBindInit qsInitMsg = {0U, 0, 0U, MBUF_ENHANCED_ACL, {0}};
        qsInitMsg.pid = mmGetPid();
        qsInitMsg.grpId = 0U;
        eventSum.subeventId = bqs::ACL_BIND_QUEUE_INIT;
        eventSum.msgLen = sizeof(qsInitMsg);
        eventSum.msg = reinterpret_cast<char_t *>(&qsInitMsg);
        ACL_REQUIRES_CALL_RTS_OK(rtEschedSubmitEventSync(deviceId, &eventSum, &ack), rtEschedSubmitEventSync);
        bqs::QsProcMsgRsp *const rsp = reinterpret_cast<bqs::QsProcMsgRsp *>(ack.buf);
        if (rsp->retCode != 0) {
            ACL_LOG_INNER_ERROR("send connet qs failed, ret code id %d", rsp->retCode);
            return ACL_ERROR_FAILURE;
        }
        qsContactId_ = rsp->retValue;
        if (rsp->majorVersion >= MBUF_ENHANCED_QS) {
            isMbufEnhanced_ = true;
        }
        eventSum.msgLen = 0U;
        eventSum.msg = nullptr;
        ACL_LOG_INFO("successfully execute to SendConnectQsMsg");
        return ACL_SUCCESS;
    }

    aclError QueueProcessor::SendBindUnbindMsgOnDevice(acltdtQueueRouteList *const qRouteList,
                                                       const bool isBind,
                                                       rtEschedEventSummary_t &eventSum,
                                                       rtEschedEventReply_t &ack) const
    {
        ACL_LOG_INFO("start to send bind or unbind msg");
        // send bind or unbind msg
        const size_t routeSize = sizeof(bqs::QsRouteHead) + (qRouteList->routeList.size() * sizeof(bqs::QueueRoute));
        ACL_LOG_INFO("route size is %zu, queue route num is %zu", routeSize, qRouteList->routeList.size());
        void *devPtr = nullptr;
        void *mBuf = nullptr;
        ACL_REQUIRES_OK(AllocMBufOnDevice(&devPtr, &mBuf, routeSize));
        bqs::QsRouteHead *const head = reinterpret_cast<bqs::QsRouteHead *>(devPtr);
        head->length = routeSize;
        head->routeNum = qRouteList->routeList.size();
        head->subEventId =
            isBind ? static_cast<uint32_t>(bqs::ACL_BIND_QUEUE) : static_cast<uint32_t>(bqs::ACL_UNBIND_QUEUE);
        size_t offset = sizeof(bqs::QsRouteHead);
        for (size_t i = 0UL; i < qRouteList->routeList.size(); ++i) {
            bqs::QueueRoute *const tmp =
                reinterpret_cast<bqs::QueueRoute *>(static_cast<uint8_t *>(devPtr) + offset);
            tmp->srcId = qRouteList->routeList[i].srcId;
            tmp->dstId = qRouteList->routeList[i].dstId;
            offset += sizeof(bqs::QueueRoute);
        }
        // device need to use mbuff
        auto ret = rtMemQueueEnQueue(0, qsContactId_, mBuf);
        if (ret != RT_ERROR_NONE) {
            (void)rtMbufFree(mBuf);
            mBuf = nullptr;
            devPtr = nullptr;
            ACL_LOG_INNER_ERROR("[Call][Rts]call rtMemQueueEnQueue failed");
            return ret;
        }

        bqs::QueueRouteList bqsBindUnbindMsg = {0U, 0U, {0}};
        eventSum.subeventId =
            isBind ? static_cast<uint32_t>(bqs::ACL_BIND_QUEUE) : static_cast<uint32_t>(bqs::ACL_UNBIND_QUEUE);
        eventSum.msgLen = sizeof(bqsBindUnbindMsg);
        eventSum.msg = reinterpret_cast<char_t *>(&bqsBindUnbindMsg);
        ret = rtEschedSubmitEventSync(0, &eventSum, &ack);
        eventSum.msgLen = 0U;
        eventSum.msg = nullptr;
        if (ret != RT_ERROR_NONE) {
            ACL_LOG_INNER_ERROR("call rtEschedSubmitEventSync failed, ret code id %d", ret);
            if (!isMbufEnhanced_) {
                (void)rtMbufFree(mBuf);
                mBuf = nullptr;
                devPtr = nullptr;
            }
            return ret;
        }
        if (isMbufEnhanced_) {
            // after event sync mbuf need to be dequeue to be used as mbuf can not be free by enqueue side
            ACL_REQUIRES_CALL_RTS_OK(rtMemQueueDeQueue(0, qsContactId_, &mBuf), rtMemQueueDeQueue);
            (void)rtMbufGetBuffAddr(mBuf, &devPtr);
        }
        bqs::QsProcMsgRsp *const rsp = reinterpret_cast<bqs::QsProcMsgRsp *>(ack.buf);
        if (rsp->retCode != 0) {
            ACL_LOG_INNER_ERROR("send connet qs failed, ret code id %d", rsp->retCode);
            (void)rtMbufFree(mBuf);
            mBuf = nullptr;
            devPtr = nullptr;
            return ACL_ERROR_FAILURE;
        }
        offset = sizeof(bqs::QsRouteHead);
        for (size_t i = 0UL; i < qRouteList->routeList.size(); ++i) {
            bqs::QueueRoute *const tmp =
                reinterpret_cast<bqs::QueueRoute *>(static_cast<uint8_t *>(devPtr) + offset);
            qRouteList->routeList[i].status = tmp->status;
            ACL_LOG_INFO("route %zu, srcqid is %u, dst pid is %u, status is %d", i, qRouteList->routeList[i].srcId,
                         qRouteList->routeList[i].dstId, qRouteList->routeList[i].status);
            offset += sizeof(bqs::QueueRoute);
        }
        (void)rtMbufFree(mBuf);
        devPtr = nullptr;
        mBuf = nullptr;
        return ret;
    }

    aclError QueueProcessor::GetQueueRouteNum(const acltdtQueueRouteQueryInfo *const queryInfo,
                                              const int32_t deviceId,
                                              rtEschedEventSummary_t &eventSum,
                                              rtEschedEventReply_t &ack,
                                              size_t &routeNum) const
    {
        ACL_LOG_INFO("start to get queue route num");
        bqs::QueueRouteQuery routeQuery = {0UL, 0U, 0U, 0U, 0, 0, 0UL, {0}};
        routeQuery.queryType = static_cast<uint32_t>(queryInfo->mode);
        routeQuery.srcId = queryInfo->srcId;
        routeQuery.dstId = queryInfo->dstId;

        eventSum.subeventId = bqs::ACL_QUERY_QUEUE_NUM;
        eventSum.msgLen = sizeof(routeQuery);
        eventSum.msg = reinterpret_cast<char_t *>(&routeQuery);
        ACL_REQUIRES_CALL_RTS_OK(rtEschedSubmitEventSync(deviceId, &eventSum, &ack), rtEschedSubmitEventSync);
        bqs::QsProcMsgRsp *const rsp = reinterpret_cast<bqs::QsProcMsgRsp *>(ack.buf);
        if (rsp->retCode != 0) {
            ACL_LOG_INNER_ERROR("get queue route num failed, ret code id %d", rsp->retCode);
            return ACL_ERROR_FAILURE;
        }
        routeNum = rsp->retValue;
        eventSum.msgLen = 0U;
        eventSum.msg = nullptr;
        ACL_LOG_INFO("sucessfully to get queue route num %zu.", routeNum);
        return ACL_SUCCESS;
    }

    aclError QueueProcessor::QueryQueueRoutesOnDevice(const acltdtQueueRouteQueryInfo *const queryInfo,
        const size_t routeNum, rtEschedEventSummary_t &eventSum, rtEschedEventReply_t &ack,
        acltdtQueueRouteList *const qRouteList) const
    {
        ACL_LOG_INFO("start to query queue route %zu", routeNum);
        if (routeNum == 0U) {
            return ACL_SUCCESS;
        }
        const size_t routeSize = sizeof(bqs::QsRouteHead) + sizeof(bqs::QueueRouteQuery) +
            (routeNum * sizeof(bqs::QueueRoute));
        ACL_LOG_INFO("route size is %zu, queue route num is %zu", routeSize, qRouteList->routeList.size());
        void *devPtr = nullptr;
        void *mBuf = nullptr;
        ACL_REQUIRES_OK(AllocMBufOnDevice(&devPtr, &mBuf, routeSize));
        bqs::QsRouteHead *const head = reinterpret_cast<bqs::QsRouteHead *>(devPtr);
        head->length = routeSize;
        head->routeNum = routeNum;
        head->subEventId = bqs::ACL_QUERY_QUEUE;
        bqs::QueueRouteQuery *const routeQuery =
            reinterpret_cast<bqs::QueueRouteQuery *>(static_cast<uint8_t *>(devPtr) + sizeof(bqs::QsRouteHead));
        routeQuery->queryType = static_cast<uint32_t>(queryInfo->mode);
        routeQuery->srcId = queryInfo->srcId;
        routeQuery->dstId = queryInfo->dstId;
        // device need to use mbuff
        auto ret = rtMemQueueEnQueue(0, qsContactId_, mBuf);
        if (ret != RT_ERROR_NONE) {
            (void)rtMbufFree(mBuf);
            devPtr = nullptr;
            mBuf = nullptr;
            ACL_LOG_INNER_ERROR("[Call][Rts]call rtMemQueueEnQueue failed");
            return ret;
        }
        bqs::QueueRouteList qsCommonMsg = {0U, 0U, {0}};
        eventSum.subeventId = bqs::ACL_QUERY_QUEUE;
        eventSum.msgLen = sizeof(qsCommonMsg);
        eventSum.msg = reinterpret_cast<char_t *>(&qsCommonMsg);

        ret = rtEschedSubmitEventSync(0, &eventSum, &ack);
        eventSum.msgLen = 0U;
        eventSum.msg = nullptr;
        if (ret != RT_ERROR_NONE) {
            if (!isMbufEnhanced_) {
                (void)rtMbufFree(mBuf);
                mBuf = nullptr;
                devPtr = nullptr;
            }
            return ret;
        }
        if (isMbufEnhanced_) {
            // after event sync mbuf need to be dequeue to be used as mbuf can not be free by enqueue side
            ACL_REQUIRES_CALL_RTS_OK(rtMemQueueDeQueue(0, qsContactId_, &mBuf), rtMemQueueDeQueue);
            (void)rtMbufGetBuffAddr(mBuf, &devPtr);
        }

        bqs::QsProcMsgRsp *const rsp = reinterpret_cast<bqs::QsProcMsgRsp *>(ack.buf);
        if (rsp->retCode != 0) {
            ACL_LOG_INNER_ERROR("query queue route failed, ret code id %d", rsp->retCode);
            (void)rtMbufFree(mBuf);
            devPtr = nullptr;
            mBuf = nullptr;
            return ACL_ERROR_FAILURE;
        }
        size_t offset = sizeof(bqs::QsRouteHead) + sizeof(bqs::QueueRouteQuery);
        for (size_t i = 0UL; i < routeNum; ++i) {
            bqs::QueueRoute *const tmp =
                reinterpret_cast<bqs::QueueRoute *>(static_cast<uint8_t *>(devPtr) + offset);
            const acltdtQueueRoute tmpQueueRoute = {tmp->srcId, tmp->dstId, tmp->status};
            qRouteList->routeList.push_back(tmpQueueRoute);
            ACL_LOG_INFO("route %zu, srcqid is %u, dst pid is %u, status is %d", i, qRouteList->routeList[i].srcId,
                         qRouteList->routeList[i].dstId, qRouteList->routeList[i].status);
            offset += sizeof(bqs::QueueRoute);
        }
        (void)rtMbufFree(mBuf);
        devPtr = nullptr;
        mBuf = nullptr;
        ACL_LOG_INFO("Successfully to execute acltdtQueryQueueRoutes, queue route is %zu",
                     qRouteList->routeList.size());
        return ACL_SUCCESS;
    }

    aclError QueueProcessor::QueryAllocGroup()
    {
        ACL_LOG_INFO("Start to QueryAllocGroup.");
        static bool isGroupQuery = false;
        if (isGroupQuery) {
            return ACL_SUCCESS;
        }
        const std::lock_guard<std::mutex> lk(muForQueryGroup_);
        if (isGroupQuery) {
            return ACL_SUCCESS;
        }
        size_t grpNum;
        uint32_t alloc;
        std::string grpName;
        const auto pid = mmGetPid();
        rtMemGrpQueryInput_t input = {};
        input.cmd = RT_MEM_GRP_QUERY_GROUPS_OF_PROCESS;
        input.grpQueryByProc.pid = pid;
        rtMemGrpQueryOutput_t output = {};
        rtMemGrpOfProc_t outputInfo[QUERY_BUFF_GRP_MAX_NUM] = {{}};
        output.groupsOfProc = outputInfo;
        output.maxNum = QUERY_BUFF_GRP_MAX_NUM;

        ACL_REQUIRES_CALL_RTS_OK(rtMemGrpQuery(&input, &output), rtMemGrpQuery);
        grpNum = output.resultNum;
        if ((grpNum == 0U) || (output.groupsOfProc == nullptr)) {
            ACL_LOG_ERROR("[Check] grpNum is zero or groupsOfProc is nullptr, grpNum is %zu", grpNum);
            return ACL_ERROR_FAILURE;
        }
        for (size_t num = 0U; num < grpNum; num++) {
            alloc = output.groupsOfProc[num].attr.alloc;
            grpName = std::string(output.groupsOfProc[num].groupName);
            ACL_LOG_INFO("This proc [%d] has [%zu] group, alloc is %u, name is %s",
                         pid, grpNum, alloc, grpName.c_str());
            if (alloc == 1U) {
                ACL_REQUIRES_OK(QueryGroupId(grpName));
                isGroupQuery = true;
                return ACL_SUCCESS;
            }
        }
        ACL_LOG_ERROR("[Check] has no alloc");
        return ACL_ERROR_FAILURE;
    }

    aclError QueueProcessor::QueryGroupId(const std::string &grpName)
    {
        ACL_LOG_INFO("Query groupId from name = %s", grpName.c_str());
        rtMemGrpQueryInput_t input = {};
        input.cmd = RT_MEM_GRP_QUERY_GROUP_ID;
        const auto strcpyRet = strcpy_s(input.grpQueryGroupId.grpName,
                                        sizeof(input.grpQueryGroupId.grpName), grpName.c_str());
        if (strcpyRet != EOK) {
            ACL_LOG_INNER_ERROR("[strcpy]copy group name to input failed, result = %d.", strcpyRet);
            return ACL_ERROR_FAILURE;
        }
        rtMemGrpQueryOutput_t output = {};
        rtMemGrpQueryGroupIdInfo_t outputInfo = {};
        output.groupIdInfo = &outputInfo;

        ACL_REQUIRES_CALL_RTS_OK(rtMemGrpQuery(&input, &output), rtMemGrpQuery);
        qsGroupId_ = output.groupIdInfo->groupId;
        ACL_LOG_INFO("This groupId is %d, name is %s", qsGroupId_, grpName.c_str());
        return ACL_SUCCESS;
    }

    aclError QueueProcessor::acltdtAllocBufData(const size_t size, const uint32_t type, acltdtBuf *const buf)
    {
        rtError_t ret;
        if (!isMbufInit_) {
            rtMemBuffCfg_t cfg = {{}};
            ret = rtMbufInit(&cfg);
            if ((ret != ACL_RT_SUCCESS) && (ret != ACL_ERROR_RT_REPEATED_INIT)) {
                ACL_LOG_INNER_ERROR("mbuf init failed, ret is %d", ret);
                return ret;
            }
            isMbufInit_ = true;
        }
        ret = rtMbufAllocEx(buf, size, type, qsGroupId_);
        if (ret != RT_ERROR_NONE) {
            ACL_LOG_CALL_ERROR("[Alloc][mbuf]fail to alloc mbuf result = %d", ret);
            return ret;
        }
        return ACL_SUCCESS;
    }

    aclError QueueProcessor::acltdtFreeBuf(acltdtBuf buf)
    {
        return aclrtFreeBuf(buf);
    }

    aclError QueueProcessor::acltdtSetBufDataLen(const acltdtBuf buf, const size_t len)
    {
        return aclrtSetBufDataLen(buf, len);
    }

    aclError QueueProcessor::acltdtGetBufDataLen(const acltdtBuf buf, size_t *const len)
    {
        return aclrtGetBufDataLen(buf, len);
    }

    aclError QueueProcessor::acltdtGetBufData(const acltdtBuf buf, void **const dataPtr, size_t *const size)
    {
        return aclrtGetBufData(buf, dataPtr, size);
    }

    aclError QueueProcessor::acltdtGetBufUserData(const acltdtBuf buf, void *dataPtr,
                                                  const size_t size, const size_t offset)
    {
        return aclrtGetBufUserData(buf, dataPtr, size, offset);
    }

    aclError QueueProcessor::acltdtSetBufUserData(acltdtBuf buf, const void *dataPtr,
                                                  const size_t size, const size_t offset)
    {
        return aclrtSetBufUserData(buf, dataPtr, size, offset);
    }

    aclError QueueProcessor::acltdtCopyBufRef(const acltdtBuf buf, acltdtBuf *const newBuf)
    {
        return aclrtCopyBufRef(buf, newBuf);
    }

    aclError QueueProcessor::acltdtAppendBufChain(const acltdtBuf headBuf, const acltdtBuf buf)
    {
        return aclrtAppendBufChain(headBuf, buf);
    }

    aclError QueueProcessor::acltdtGetBufChainNum(const acltdtBuf headBuf, uint32_t *const num)
    {
        return aclrtGetBufChainNum(headBuf, num);
    }

    aclError QueueProcessor::acltdtGetBufFromChain(const acltdtBuf headBuf, const uint32_t index, acltdtBuf *const buf)
    {
        return aclrtGetBufFromChain(headBuf, index, buf);
    }

    QueueDataMutexPtr QueueProcessor::GetMutexForData(const uint32_t qid)
    {
        const std::lock_guard<std::mutex> lk(muForQueueMap_);
        const auto it = muForQueue_.find(qid);
        if (it != muForQueue_.end()) {
            return it->second;
        } else {
            const QueueDataMutexPtr queueDataMutex = std::make_shared<QueueDataMutex>();
            muForQueue_[qid] = queueDataMutex;
            return queueDataMutex;
        }
    }

    void QueueProcessor::DeleteMutexForData(const uint32_t qid)
    {
        const std::lock_guard<std::mutex> lk(muForQueueMap_);
        const auto it = muForQueue_.find(qid);
        if (it != muForQueue_.end()) {
            (void)muForQueue_.erase(it);
        }
        return;
    }

    uint64_t QueueProcessor::GetTimestamp() const
    {
        mmTimeval tv{};
        const auto ret = mmGetTimeOfDay(&tv, nullptr);
        if (ret != EN_OK) {
            ACL_LOG_WARN("Func mmGetTimeOfDay did not return success, errorCode = %d", ret);
        }
        // 1000000: seconds to microseconds
        const uint64_t totalUseTime = static_cast<size_t>(tv.tv_usec) +
            (static_cast<uint64_t>(tv.tv_sec) * 1000000UL);
        return totalUseTime;
    }

    aclError QueueProcessor::GetDeviceId(int32_t& deviceId) const
    {
        deviceId = 0;
        aclrtRunMode aclRunMode = ACL_HOST;
        const aclError getRunModeRet = aclrtGetRunMode(&aclRunMode);
        if (getRunModeRet != ACL_SUCCESS) {
            ACL_LOG_CALL_ERROR("[Get][RunMode]get run mode failed, errorCode = %d.", getRunModeRet);
            return getRunModeRet;
        }

        if (aclRunMode == ACL_HOST) {
            const rtError_t rtRet = rtGetDevice(&deviceId);
            if (rtRet != ACL_SUCCESS) {
                ACL_LOG_CALL_ERROR("[Get][DeviceId]fail to get deviceId errorCode = %d", rtRet);
                return rtRet;
            }
        }
        return ACL_SUCCESS;
    }

    aclError QueueProcessor::acltdtEnqueueData(const uint32_t qid, const void *const data, const size_t dataSize,
        const void *const userData, const size_t userDataSize, const int32_t timeout, const uint32_t rsv)
    {
        ACL_LOG_INFO("Start to enqueue data qid is %u, dataSize is %zu, userDataSize is %zu, "
                     "timeout is %d, rsv is %u", qid, dataSize, userDataSize, timeout, rsv);
        ACL_REQUIRES_NOT_NULL(data);
        ACL_REQUIRES_POSITIVE(dataSize);

        int32_t deviceId;
        ACL_REQUIRES_OK(GetDeviceId(deviceId));
        const QueueDataMutexPtr muPtr = GetMutexForData(qid);
        ACL_CHECK_MALLOC_RESULT(muPtr);
        const std::lock_guard<std::mutex> lk(muPtr->muForDequeue);

        rtMemQueueBuff_t queueBuf = {nullptr, 0U, nullptr, 0U};
        rtMemQueueBuffInfo queueBufInfo = {const_cast<void*>(data), dataSize};
        queueBuf.buffCount = 1U;
        queueBuf.buffInfo = &queueBufInfo;
        queueBuf.contextAddr = const_cast<void*>(userData);
        queueBuf.contextLen = userDataSize;

        const rtError_t ret = rtMemQueueEnQueueBuff(deviceId, qid, &queueBuf, timeout);
        if (ret == ACL_ERROR_RT_QUEUE_FULL) {
            ACL_LOG_INFO("queue is full, device is %d, qid is %u", deviceId, qid);
            return ret;
        }
        if (ret != RT_ERROR_NONE) {
            ACL_LOG_INNER_ERROR("Fail to execute rtMemQueueEnQueueBuff, device is %d, qid is %u", deviceId, qid);
            return ret;
        }

        ACL_LOG_INFO("success to execute acltdtEnqueueData, device is %d, qid is %u", deviceId, qid);
        return ACL_SUCCESS;
    }

    aclError QueueProcessor::acltdtDequeueData(const uint32_t qid, void *const data, const size_t dataSize,
        size_t *const retDataSize, void *const userData, const size_t userDataSize, const int32_t timeout)
    {
        ACL_LOG_INFO("Start to dequeue data qid is %u, dataSize is %zu, userDataSize is %zu, "
                     "timeout is %d,", qid, dataSize, userDataSize, timeout);
        ACL_REQUIRES_NOT_NULL(data);
        ACL_REQUIRES_NOT_NULL(retDataSize);
        ACL_REQUIRES_POSITIVE(dataSize);

        int32_t deviceId;
        ACL_REQUIRES_OK(GetDeviceId(deviceId));

        const QueueDataMutexPtr muPtr = GetMutexForData(qid);
        ACL_CHECK_MALLOC_RESULT(muPtr);
        const std::lock_guard<std::mutex> lk(muPtr->muForEnqueue);

        rtError_t ret = rtMemQueuePeek(deviceId, qid, retDataSize, timeout);
        if (ret == ACL_ERROR_RT_QUEUE_EMPTY) {
            ACL_LOG_INFO("queue is empty, device is %d, qid is %u", deviceId, qid);
            return ret;
        }
        if (ret != RT_ERROR_NONE) {
            ACL_LOG_ERROR("peek queue [%u] failed, device is %d", qid, deviceId);
            return ret;
        }

        rtMemQueueBuff_t queueBuf = {nullptr, 0U, nullptr, 0U};
        rtMemQueueBuffInfo queueBufInfo = {data, dataSize};
        queueBuf.buffCount = 1U;
        queueBuf.buffInfo = &queueBufInfo;
        queueBuf.contextAddr = userData;
        queueBuf.contextLen = userDataSize;

        ret = rtMemQueueDeQueueBuff(deviceId, qid, &queueBuf, timeout);
        if (ret == ACL_ERROR_RT_QUEUE_EMPTY) {
            ACL_LOG_INFO("queue is empty, device is %d, qid is %u", deviceId, qid);
            return ret;
        }

        if (ret != RT_ERROR_NONE) {
            ACL_LOG_ERROR("failed to rtMemQueueDeQueueBuf, device is %d, qid is %u", deviceId, qid);
            return ret;
        }

        ACL_LOG_INFO("success to execute acltdtDequeueData, device is %d, qid is %u, retDataSize is %zu",
            deviceId, qid, *retDataSize);
        return ACL_SUCCESS;
    }

    void QueueProcessor::acltdtSetDefaultQueueAttr(acltdtQueueAttr &attr)
    {
        (void)memset_s(attr.name, static_cast<size_t>(RT_MQ_MAX_NAME_LEN), 0, sizeof(attr.name));
        attr.depth = RT_MQ_DEPTH_DEFAULT;
        attr.workMode = static_cast<uint32_t>(RT_MQ_MODE_DEFAULT);
        attr.flowCtrlFlag = false;
        attr.flowCtrlDropTime = 0U;
        attr.overWriteFlag = false;
        return;
    }

    aclError QueueProcessor::acltdtCreateQueueWithAttr(const int32_t deviceId, const acltdtQueueAttr *const attr,
        uint32_t *const qid) const
    {
        if (attr == nullptr) {
            acltdtQueueAttr tmpAttr{};
            acltdtSetDefaultQueueAttr(tmpAttr);
            ACL_REQUIRES_CALL_RTS_OK(rtMemQueueCreate(deviceId, &tmpAttr, qid), rtMemQueueCreate);
        } else {
            ACL_REQUIRES_CALL_RTS_OK(rtMemQueueCreate(deviceId, attr, qid), rtMemQueueCreate);
        }
        return ACL_SUCCESS;
    }
}
