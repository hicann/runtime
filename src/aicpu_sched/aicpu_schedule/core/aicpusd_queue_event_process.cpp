/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpusd_queue_event_process.h"

#include "aicpusd_hal_interface_ref.h"
#include "aicpusd_monitor.h"
#include "aicpusd_status.h"
#include "securec.h"
#include "type_def.h"

namespace {
    const GroupShareAttr ALL_ATTR_FOR_GROUP = { 1U, 1U, 1U, 1U, 0U }; // admin + read + write + alloc
    const uint16_t MAJOR_VERSION = 1U;
}

namespace AicpuSchedule {
    AicpuQueueEventProcess &AicpuQueueEventProcess::GetInstance()
    {
        static AicpuQueueEventProcess instance;
        return instance;
    }

    int32_t AicpuQueueEventProcess::DoProcessDrvMsg(const event_info &event, bool &needRes)
    {
        int32_t ret = AICPU_SCHEDULE_OK;
        switch (event.comm.subevent_id) {
            case DRV_SUBEVENT_GRANT_MSG: {
                ret = GrantQueue(event);
                needRes = true;
                break;
            }
            case DRV_SUBEVENT_ATTACH_MSG: {
                ret = AttachQueue(event);
                needRes = true;
                break;
            }
            default: {
                if (event.comm.subevent_id == DRV_SUBEVENT_QUEUE_INIT_MSG) {
                    std::string groupName;
                    ret = GetOrCreateGroup(groupName);
                    if (ret != AICPU_SCHEDULE_OK) {
                        needRes = true;
                        return ret;
                    }
                }
                event_info * const eventToDrv = const_cast<event_info*>(&event);
                const int32_t drvRet = halEventProc(AicpuDrvManager::GetInstance().GetDeviceId(), eventToDrv);
                if (drvRet != DRV_ERROR_NONE) {
                    aicpusd_err("Call halEventProc failed, subevent_id=[%u],ret=[%d]", event.comm.subevent_id, drvRet);
                    return drvRet;
                }
                break;
            }
        }
        return ret;
    }

    int32_t AicpuQueueEventProcess::ProcessDrvMsg(const event_info &event)
    {
        aicpusd_debug("Begin to process drv event. eventId=%u, subEventId=%u, hostPid=%d, grpId=%u",
                      event.comm.event_id, event.comm.subevent_id, event.comm.host_pid, event.comm.grp_id);
        bool needRes = false;
        int32_t ret = DoProcessDrvMsg(event, needRes);
        if (needRes) {
            event_proc_result rsp = {};
            rsp.ret = ret;
            const int32_t resRet =
                ResponseEvent(event, PtrToPtr<event_proc_result, const char_t>(&rsp), sizeof(event_proc_result));
            if (ret == AICPU_SCHEDULE_OK) {
                ret = resRet;
            }
        }
        aicpusd_debug("End to process drv event. eventId=%u, subEventId=%u, hostPid=%d, grpId=%u",
                      event.comm.event_id, event.comm.subevent_id, event.comm.host_pid, event.comm.grp_id);
        return ret;
    }

    int32_t AicpuQueueEventProcess::DoProcessQsMsg(const event_info &event,
                                                   std::shared_ptr<CallbackMsg> &callback,
                                                   const bqs::QsProcMsgRspDstAicpu *&qsProcMsgRsp,
                                                   bool &isRes)
    {
        int32_t ret = AICPU_SCHEDULE_OK;
        switch (event.comm.subevent_id) {
            case bqs::ACL_BIND_QUEUE_INIT:
                ret = ProcessBindQueueInit(event);
                break;
            case bqs::AICPU_BIND_QUEUE_INIT_RES:
                ret = ProcessBindQueueInitRet(event, callback, &qsProcMsgRsp);
                isRes = true;
                break;
            case bqs::ACL_BIND_QUEUE:
                ret = ProcessQueueEventWithMbuf(event, bqs::AICPU_BIND_QUEUE);
                break;
            case bqs::AICPU_BIND_QUEUE_RES:
                ret = ProcessQsRetWithMbuf(event, callback, &qsProcMsgRsp);
                isRes = true;
                break;
            case bqs::ACL_UNBIND_QUEUE:
                ret = ProcessQueueEventWithMbuf(event, bqs::AICPU_UNBIND_QUEUE);
                break;
            case bqs::AICPU_UNBIND_QUEUE_RES:
                ret = ProcessQsRetWithMbuf(event, callback, &qsProcMsgRsp);
                isRes = true;
                break;
            case bqs::ACL_QUERY_QUEUE_NUM:
                ret = ProcessQueryQueueNum(event);
                break;
            case bqs::AICPU_QUERY_QUEUE_NUM_RES:
                ret = ProcessQsRet(event, callback, &qsProcMsgRsp);
                isRes = true;
                break;
            case bqs::ACL_QUERY_QUEUE:
                ret = ProcessQueueEventWithMbuf(event, bqs::AICPU_QUERY_QUEUE);
                break;
            case bqs::AICPU_QUERY_QUEUE_RES:
                ret = ProcessQsRetWithMbuf(event, callback, &qsProcMsgRsp);
                isRes = true;
                break;
            default:
                aicpusd_err("The queue event sub event id is not found, subevent id[%u]", event.comm.subevent_id);
                ret = AICPU_SCHEDULE_ERROR_NOT_FOUND_QUEUE_SUB_EVENT_ID;
                break;
        }
        return ret;
    }

    int32_t AicpuQueueEventProcess::ProcessQsMsg(const event_info &event)
    {
        aicpusd_info("Begin to ProcessQsMsg subevent_id[%u]", event.comm.subevent_id);
        bool isRes = false;
        const bqs::QsProcMsgRspDstAicpu *qsProcMsgRsp = nullptr;
        std::shared_ptr<CallbackMsg> callback = nullptr;
        const int32_t ret = DoProcessQsMsg(event, callback, qsProcMsgRsp, isRes);
        if (callback != nullptr) {
            return ResponseEvent(callback->event,
                PtrToPtr<const bqs::QsProcMsgRspDstAicpu, const char_t>(qsProcMsgRsp),
                sizeof(bqs::QsProcMsgRspDstAicpu));
        }
        if ((ret != AICPU_SCHEDULE_OK) && (!isRes)) {
            bqs::QsProcMsgRspDstAicpu msg = {};
            msg.retCode = ret;
            (void) ResponseEvent(event, PtrToPtr<bqs::QsProcMsgRspDstAicpu, const char_t>(&msg),
                                 sizeof(bqs::QsProcMsgRspDstAicpu));
            return ret;
        }
        return ret;
    }

    int32_t AicpuQueueEventProcess::AddCallback(uint64_t userData, std::shared_ptr<CallbackMsg> &callback)
    {
        bool ret = false;
        {
            const std::lock_guard<std::mutex> guard(lockCallback_);
            const auto msg = callbacks_.emplace(userData, callback);
            ret = msg.second;
        }
        if (!ret) {
            aicpusd_err("Save event callback failed, subevent_id[%u], userData[%llu]",
                callback->event.comm.subevent_id, userData);
            return AICPU_SCHEDULE_ERROR_ADD_CALLBACK_FAILED;
        }
        aicpusd_info("Success to AddCallback subevent_id[%d], userData[%llu].",
            callback->event.comm.subevent_id, userData);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::GetAndDeleteCallback(const uint64_t userData,
        std::shared_ptr<CallbackMsg> &callback)
    {
        const std::lock_guard<std::mutex> guard(lockCallback_);
        const auto iter = callbacks_.find(userData);
        if (iter == callbacks_.end()) {
            aicpusd_err("Get event callback failed, userData[%llu]", userData);
            return AICPU_SCHEDULE_ERROR_GET_CALLBACK_FAILED;
        }
        callback = iter->second;
        (void) callbacks_.erase(iter);
        aicpusd_info("Success to GetAndDeleteCallback subevent_id[%u], userData[%llu].",
            callback->event.comm.subevent_id, userData);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::CreateAndAddCallbackMsg(const event_info &event, Mbuf * const buff,
        const uint64_t userData, std::shared_ptr<CallbackMsg> &callback)
    {
        try {
            callback = std::make_shared<CallbackMsg>();
        } catch(std::bad_alloc &) {
            aicpusd_err("Create callback msg failed, subevent_id[%u].", event.comm.subevent_id);
            if (buff != nullptr) {
                (void) halMbufFree(buff);
            }
            return AICPU_SCHEDULE_ERROR_CREATE_CALLBACK_FAILED;
        }
        callback->event = event;
        callback->buff = buff;
        return AddCallback(userData, callback);
    }

    int32_t AicpuQueueEventProcess::ProcessBindQueueInit(const event_info &event)
    {
        aicpusd_info("Begin to ProcessBindQueueInit.");
        if (initPipeline_ != BindQueueInitStatus::UNINIT) {
            aicpusd_err("Already call bind queue init, don't call repeatedly.");
            return AICPU_SCHEDULE_ERROR_REPEATED_BIND_QUEUE_INIT;
        }
        if ((lockInit_.test_and_set()) || (initPipeline_ != BindQueueInitStatus::UNINIT)) {
            aicpusd_err("Already call bind queue init, don't call repeatedly.");
            return AICPU_SCHEDULE_ERROR_REPEATED_BIND_QUEUE_INIT;
        }
        const ScopeGuard lockGuard([this] () { lockInit_.clear(); });
        initPipeline_ = BindQueueInitStatus::INITING;

        // check event params
        const char_t *qsBindInitMsg = nullptr;
        int32_t ret = ParseQueueEventMessage(event, qsBindInitMsg, sizeof(bqs::QsBindInit));
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }

        // query qs pid
        ret = QueryQsPid();
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }

        // add qs to cp shape group
        std::string groupName;
        ret = GetOrCreateGroup(groupName);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        ret = ShareGroupWithProcess(groupName, qsPid_);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }

        // add callback
        std::shared_ptr<CallbackMsg> callback = nullptr;
        const uint64_t userData = PtrToValue(PtrToPtr<const char_t, const void>(qsBindInitMsg));
        ret = CreateAndAddCallbackMsg(event, nullptr, userData, callback);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }

        // send init pipeline event to qs
        bqs::QsBindInit msg = {};
        msg.syncEventHead = userData;
        msg.pid = curPid_;
        msg.grpId = AicpuDrvManager::GetInstance().GetGroupId();
        msg.majorVersion = MAJOR_VERSION;
        ret = SendEventToQs(PtrToPtr<bqs::QsBindInit, char_t>(&msg),
            sizeof(bqs::QsBindInit), bqs::AICPU_BIND_QUEUE_INIT);
        if (ret != AICPU_SCHEDULE_OK) {
            (void) GetAndDeleteCallback(userData, callback);
            return ret;
        }
        aicpusd_info("Success to ProcessBindQueueInit.");
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::ProcessBindQueueInitRet(const event_info &event,
        std::shared_ptr<CallbackMsg> &callback, const bqs::QsProcMsgRspDstAicpu ** const qsProcMsgRsp)
    {
        aicpusd_info("Begin to ProcessBindQueueInitRet.");
        const int32_t ret = ProcessQsRet(event, callback, qsProcMsgRsp);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        pipelineQueueId_ = (*qsProcMsgRsp)->retValue;
        auto drvRet = halQueueInit(AicpuDrvManager::GetInstance().GetDeviceId());
        if ((drvRet != DRV_ERROR_NONE) && (drvRet != DRV_ERROR_REPEATED_INIT)) {
            aicpusd_err("halQueueInit error, deviceId[%u], ret[%d]",
                AicpuDrvManager::GetInstance().GetDeviceId(), drvRet);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        drvRet = halQueueAttach(AicpuDrvManager::GetInstance().GetDeviceId(), pipelineQueueId_, 0);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Cp attach Qs queue failed, queueId[%u] ret[%d]", pipelineQueueId_,
                        static_cast<int32_t>(drvRet));
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        initPipeline_ = BindQueueInitStatus::INITED;
        aicpusd_info("Success to ProcessBindQueueInitRet, queueId[%u].", pipelineQueueId_);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::ProcessQueryQueueNum(const event_info &event)
    {
        aicpusd_info("Begin to ProcessQueryQueueNum.");
        if (initPipeline_ != BindQueueInitStatus::INITED) {
            aicpusd_err("Need call bind queue init before bind queue.");
            return AICPU_SCHEDULE_ERROR_CP_QS_PIPELINE_NOT_INIT;
        }
        const char_t *msg = nullptr;
        int32_t ret = ParseQueueEventMessage(event, msg, sizeof(bqs::QueueRouteQuery));
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        const bqs::QueueRouteQuery * const queryMsg = PtrToPtr<const char_t, const bqs::QueueRouteQuery>(msg);
        // add callback
        std::shared_ptr<CallbackMsg> callback = nullptr;
        const uint64_t userData = PtrToValue(queryMsg);
        ret = CreateAndAddCallbackMsg(event, nullptr, userData, callback);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }

        // send event to qs
        bqs::QueueRouteQuery sendMsg = *queryMsg;
        sendMsg.syncEventHead = userData;
        ret = SendEventToQs(PtrToPtr<bqs::QueueRouteQuery, char_t>(&sendMsg),
            sizeof(bqs::QueueRouteQuery), bqs::AICPU_QUERY_QUEUE_NUM);
        if (ret != AICPU_SCHEDULE_OK) {
            (void) GetAndDeleteCallback(userData, callback);
            return ret;
        }

        aicpusd_info("Success to ProcessQueryQueueNum.");
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::ProcessQsRet(const event_info &event,
        std::shared_ptr<CallbackMsg> &callback, const bqs::QsProcMsgRspDstAicpu ** const qsProcMsgRsp)
    {
        const char_t *msg = nullptr;
        int32_t ret = ParseQueueEventMessage(event, msg, sizeof(bqs::QsProcMsgRspDstAicpu));
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        *qsProcMsgRsp = PtrToPtr<const char_t, const bqs::QsProcMsgRspDstAicpu>(msg);
        ret = GetAndDeleteCallback((*qsProcMsgRsp)->syncEventHead, callback);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::CheckAndInitParamWithMbuf(const event_info &event,
        const bqs::QueueRouteList *&msg, bqs::QsRouteHead *&routeHead) const
    {
        if (initPipeline_ != BindQueueInitStatus::INITED) {
            aicpusd_err("Need call bind queue init first.");
            return AICPU_SCHEDULE_ERROR_CP_QS_PIPELINE_NOT_INIT;
        }
        const char_t *routeListMsg = nullptr;
        const int32_t ret = ParseQueueEventMessage(event, routeListMsg, sizeof(bqs::QueueRouteList));
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        msg = PtrToPtr<const char_t, const bqs::QueueRouteList>(routeListMsg);
        routeHead = PtrToPtr<void, bqs::QsRouteHead>(ValueToPtr(msg->routeListMsgAddr));
        if (routeHead == nullptr) {
            aicpusd_err("The event_info msg QsRouteHead is nullptr.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        if (routeHead->routeNum == 0U) {
            aicpusd_err("The route num is 0.");
            return AICPU_SCHEDULE_ERROR_ROUTE_NUM_IS_ZERO;
        }
        const uint32_t routeSize = static_cast<uint32_t>(sizeof(bqs::QsRouteHead) +
            (routeHead->routeNum * sizeof(bqs::QueueRoute)));
        if (routeHead->length < routeSize) {
            aicpusd_err("The event_info msg QsRouteHead.length[%u] < routeSize[%u].", routeHead->length, routeSize);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::ProcessQueueEventWithMbuf(const event_info &event,
        const bqs::QueueSubEventType drvSubeventId)
    {
        const bqs::QueueRouteList *msg = nullptr;
        bqs::QsRouteHead *routeHead = nullptr;
        int32_t ret = CheckAndInitParamWithMbuf(event, msg, routeHead);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }

        if (drvSubeventId == bqs::AICPU_BIND_QUEUE) {
            const bqs::QueueRoute * const queueRoute = PtrToPtr<void, bqs::QueueRoute>(
                ValueToPtr(msg->routeListMsgAddr + sizeof(bqs::QsRouteHead)));
            ret = AddQueueAuthToQs(queueRoute, routeHead->routeNum);
            if (ret != AICPU_SCHEDULE_OK) {
                return ret;
            }
        }

        routeHead->subEventId = drvSubeventId;
        const uint64_t userData = PtrToValue(PtrToPtr<const bqs::QueueRouteList, const void>(msg));
        routeHead->userData = userData;

        // alloc mbuf
        Mbuf *buff = nullptr;
        ret = AllocMbufAndEnqueue(routeHead, static_cast<size_t>(routeHead->length), &buff);
        if (ret != AICPU_SCHEDULE_OK) {
            if (buff != nullptr) {
                (void) halMbufFree(buff);
            }
            return ret;
        }

        // add callback
        std::shared_ptr<CallbackMsg> callback = nullptr;
        ret = CreateAndAddCallbackMsg(event, buff, userData, callback);
        if (ret != AICPU_SCHEDULE_OK) {
            AicpuMonitor::GetInstance().SendKillMsgToTsd();
            return ret;
        }

        bqs::QueueRouteList msgToQs = *msg;
        msgToQs.syncEventHead = userData;
        ret = SendEventToQs(PtrToPtr<bqs::QueueRouteList, char_t>(&msgToQs),
            sizeof(bqs::QueueRouteList), bqs::AICPU_QUEUE_RELATION_PROCESS);
        if (ret != AICPU_SCHEDULE_OK) {
            AicpuMonitor::GetInstance().SendKillMsgToTsd();
            return ret;
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::SendEventToQs(char_t * const msg, const size_t msgLen,
        const bqs::QueueSubEventType drvSubeventId) const
    {
        event_summary sched = {};
        sched.pid = qsPid_;
        sched.grp_id = 7U; // default: 7 is qs event group
        sched.event_id = EVENT_QS_MSG;
        sched.subevent_id = drvSubeventId;
        sched.msg_len = static_cast<uint32_t>(msgLen);
        sched.msg = msg;
        sched.dst_engine = CCPU_DEVICE;

        const int32_t drvRet = halEschedSubmitEvent(AicpuDrvManager::GetInstance().GetDeviceId(), &sched);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Failed to submit event to qs, ret=[%d].", drvRet);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::ParseQueueEventMessage(const event_info &event, const char_t *&msg,
        const size_t msgSize, const bool isSyncEvent) const
    {
        size_t offset = 0U;
        if (isSyncEvent) {
            offset = sizeof(event_sync_msg);
        }
        if (event.priv.msg_len != (msgSize + offset)) {
            aicpusd_err("The len[%u] is not equal to sizeof(msg)[%zu] + [%zu].",
                event.priv.msg_len, msgSize, offset);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        msg = &(event.priv.msg[offset]);
        if (msg == nullptr) {
            aicpusd_err("The event_info msg is nullptr.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::ResponseEvent(
        const event_info &event, const char_t * const msg, const size_t len) const
    {
        aicpusd_info("Begin to response event event_id[%u], subevent_id[%u].", event.comm.event_id,
            event.comm.subevent_id);
        event_summary response = {};
        auto const msgHead = PtrToPtr<const char_t, const event_sync_msg>(event.priv.msg);
        response.dst_engine = msgHead->dst_engine;
        response.policy = ONLY;
        response.pid = msgHead->pid;
        response.grp_id = msgHead->gid;
        response.event_id = static_cast<EVENT_ID>(msgHead->event_id);
        response.subevent_id = msgHead->subevent_id;
        response.msg_len = static_cast<uint32_t>(len);
        response.msg = const_cast<char_t *>(msg);
        const int32_t drvRet = halEschedSubmitEvent(AicpuDrvManager::GetInstance().GetDeviceId(), &response);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Failed to response event to acl event_id[%u], subevent_id[%u].", event.comm.event_id,
                event.comm.subevent_id);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        aicpusd_info("Success to response event event_id[%u], subevent_id[%u].", event.comm.event_id,
            event.comm.subevent_id);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::ProcessQsRetWithMbuf(const event_info &event,
        std::shared_ptr<CallbackMsg> &callback, const bqs::QsProcMsgRspDstAicpu ** const qsProcMsgRsp)
    {
        int32_t ret = ProcessQsRet(event, callback, qsProcMsgRsp);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        Mbuf *resultMbuf = nullptr;
        const auto drvRet = halQueueDeQueue(AicpuDrvManager::GetInstance().GetDeviceId(), pipelineQueueId_,
            PtrToPtr<Mbuf*, void*>(&resultMbuf));
        if ((drvRet != DRV_ERROR_NONE) || (resultMbuf == nullptr)) {
            aicpusd_err("Dequeue from pipelineQ[%u] fail, ret is %d", pipelineQueueId_, static_cast<int32_t>(drvRet));
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        callback->buff = resultMbuf;
        ret = CopyResult(callback);
        const auto drvFreeRet = halMbufFree(callback->buff);
        if (drvFreeRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
            aicpusd_err("Failed to free mbuf, ret[%d].", drvFreeRet);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        callback->buff = nullptr;

        return ret;
    }

    int32_t AicpuQueueEventProcess::CopyResult(const std::shared_ptr<CallbackMsg> &callback) const
    {
        const char_t *msg = nullptr;
        const int32_t ret = ParseQueueEventMessage(callback->event, msg, sizeof(bqs::QueueRouteList));
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }

        bqs::QsRouteHead * const routeHead = PtrToPtr<void, bqs::QsRouteHead>(
            ValueToPtr(PtrToPtr<const char_t, const bqs::QueueRouteList>(msg)->routeListMsgAddr));
        if (routeHead == nullptr) {
            aicpusd_err("QueueRoute is nullptr.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        if (callback->buff == nullptr) {
            aicpusd_err("Mbuf is nullptr.");
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        uint8_t *mbufData = nullptr;
        int32_t drvRet = halMbufGetBuffAddr(callback->buff, PtrToPtr<uint8_t *, void *>(&mbufData));
        if ((drvRet != DRV_ERROR_NONE) || (mbufData == nullptr)) {
            aicpusd_err("Failed to get mbuf data, ret[%d].", drvRet);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }

        uint64_t mbufSize = 0U;
        drvRet = halMbufGetDataLen(callback->buff, &mbufSize);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Failed to get mbuf data size, ret[%d].", drvRet);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }

        if (static_cast<uint64_t>(routeHead->length) != mbufSize) {
            aicpusd_err("RouteHead size[%u], but mbuf size[%lu].", routeHead->length, mbufSize);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        const errno_t memRet = memcpy_s(routeHead, static_cast<size_t>(routeHead->length),
            mbufData, static_cast<size_t>(mbufSize));
        if (memRet != EOK) {
            aicpusd_err("Memcpy size[%u] failed, ret[%d]", routeHead->length, memRet);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::AddQueueAuthToQs(const bqs::QueueRoute * const queueRoute,
        const uint32_t routeNum)
    {
            std::set<uint32_t> srcQueuesId;
            std::set<uint32_t> dstQueuesId;
            for (uint32_t i = 0U; i < routeNum; ++i) {
                auto iter = grantedSrcQueueSet_.find(queueRoute[i].srcId);
                if (iter == grantedSrcQueueSet_.end()) {
                    (void)srcQueuesId.insert(queueRoute[i].srcId);
                } else {
                    aicpusd_info("aicpusd has already grant queueId[%u] read authority to qs", queueRoute[i].srcId);
                }
                iter = grantedDstQueueSet_.find(queueRoute[i].dstId);
                if (iter == grantedDstQueueSet_.end()) {
                    (void)dstQueuesId.insert(queueRoute[i].dstId);
                } else {
                    aicpusd_info("aicpusd has already grant queueId[%u] write authority to qs", queueRoute[i].dstId);
                }
            }

            for (auto iter = srcQueuesId.begin(); iter != srcQueuesId.end(); ++iter) {
                QueueShareAttr attr = {};
                attr.read = 1U;
                const int32_t drvRet = halQueueGrant(AicpuDrvManager::GetInstance().GetDeviceId(),
                    static_cast<int32_t>(*iter), qsPid_, attr);
                if ((drvRet != DRV_ERROR_NONE) && (drvRet != DRV_ERROR_REPEATED_INIT)) {
                    aicpusd_err("Call halQueueGrant read failed, queueid[%u], ret[%d].", *iter, drvRet);
                    return AICPU_SCHEDULE_ERROR_DRV_ERR;
                }
                (void)grantedSrcQueueSet_.insert(*iter);
            }

            for (auto iter = dstQueuesId.begin(); iter != dstQueuesId.end(); ++iter) {
                QueueShareAttr attr = {};
                attr.write = 1U;
                const int32_t drvRet = halQueueGrant(AicpuDrvManager::GetInstance().GetDeviceId(),
                    static_cast<int32_t>(*iter), qsPid_, attr);
                if ((drvRet != DRV_ERROR_NONE) && (drvRet != DRV_ERROR_REPEATED_INIT)) {
                    aicpusd_err("Call halQueueGrant write failed, queueid[%u], ret[%d].", *iter, drvRet);
                    return AICPU_SCHEDULE_ERROR_DRV_ERR;
                }
                (void)grantedDstQueueSet_.insert(*iter);
            }
            return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::AllocMbufAndEnqueue(const bqs::QsRouteHead * const data,
        const size_t size, Mbuf ** const buff)
    {
        int32_t drvRet = halMbufAlloc(size, buff);
        if ((drvRet != DRV_ERROR_NONE) || (*buff == nullptr)) {
            aicpusd_err("Failed to alloc mbuf, size[%u], ret[%d].", size, drvRet);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        drvRet = halMbufSetDataLen(*buff, static_cast<uint64_t>(size));
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Failed to set data len[%zu] for mbuf, ret[%d]", size, drvRet);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }

        bqs::QsRouteHead *mbufData = nullptr;
        drvRet = halMbufGetBuffAddr(*buff, PtrToPtr<bqs::QsRouteHead *, void *>(&mbufData));
        if ((drvRet != DRV_ERROR_NONE) || (mbufData == nullptr)) {
            aicpusd_err("Failed to get mbuf data, ret[%d]", drvRet);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }

        const errno_t ret = memcpy_s(mbufData, size, data, size);
        if (ret != EOK) {
            aicpusd_err("Memcpy size=[%zu] failed, ret=[%d]", size, ret);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        // lock for enqueue
        lockEnqueue_.Lock();
        drvRet = halQueueEnQueue(AicpuDrvManager::GetInstance().GetDeviceId(), pipelineQueueId_, *buff);
        lockEnqueue_.Unlock();
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Call halQueueEnQueue error, queue id[%u], ret=[%d]", pipelineQueueId_, drvRet);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        aicpusd_info("Call halQueueEnQueue success, queue id[%u], ret=[%d]", pipelineQueueId_, drvRet);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::QueryQsPid()
    {
        aicpusd_info("Begin to QueryQsPid.");
        //  query qs pid
        halQueryDevpidInfo para = {};
        para.hostpid = AicpuDrvManager::GetInstance().GetHostPid();
        para.proc_type = DEVDRV_PROCESS_QS;
        para.vfid = AicpuDrvManager::GetInstance().GetVfId();
        para.devid = AicpuDrvManager::GetInstance().GetDeviceId();
        const int32_t drvRet =  halQueryDevpid(para, &qsPid_);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Query qs pid failed, ret=[%d]", drvRet);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        aicpusd_info("Success to QueryQsPid.");
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::CreateGroupForMaster(std::string &outGroupName, const char_t * const inGroupName,
        const uint64_t size, const uint32_t allocFlag)
    {
        aicpusd_info("Create new group for master aicpusd[%d].", curPid_);
        std::string groupName;
        if (inGroupName == nullptr) {
            groupName = "Aicpusd_" + std::to_string(curPid_);
        } else {
            groupName = std::string(inGroupName);
        }
        GroupCfg groupConf = {};
        groupConf.maxMemSize = size;
        groupConf.privMbufFlag = BUFF_ENABLE_PRIVATE_MBUF;
        groupConf.cacheAllocFlag = allocFlag;
        int32_t drvRet = halGrpCreate(groupName.c_str(), &groupConf);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Create group failed in aicpusd[%d], result[%d]", curPid_, drvRet);
            return drvRet;
        }
        drvRet = halGrpAddProc(groupName.c_str(), curPid_, ALL_ATTR_FOR_GROUP);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Add group[%s] for master aicpusd[%d] failed, ret[%d]",
                groupName.c_str(), curPid_, drvRet);
            return drvRet;
        }
        drvRet = halGrpAttach(groupName.c_str(), 0);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Attach group[%s] for master aicpusd[%d] failed, ret[%d]",
                groupName.c_str(), curPid_, drvRet);
            return drvRet;
        }
        outGroupName = groupName;
        grpName_ = groupName;
        type_ = CpType::MASTER;
        BuffCfg buffConfig = {};
        drvRet = halBuffInit(&buffConfig);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Buffer initial failed for master aicpusd[%d], ret[%d]", curPid_, drvRet);
            return drvRet;
        }
        aicpusd_info("Create new group[%s] for master aicpusd[%d] success", groupName.c_str(), curPid_);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::AttachGroupForSlave(const std::map<std::string, GroupShareAttr> &grpInfos,
                                                        std::string &outGroupName)
    {
        // only one group
        const uint32_t groupNum = grpInfos.size();
        if (groupNum != 1U) {
            aicpusd_err("Slave aicpusd[%d] should own only one group rather than [%u]",
                curPid_, groupNum);
            return AICPU_SCHEDULE_ERROR_MULTI_GRP_ERROR;
        }

        // attach and initial process
        const std::string groupName = grpInfos.begin()->first;
        auto drvRet = halGrpAttach(groupName.c_str(), 0);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Group[%s] attach failed for slave aicpusd[%d] ret[%d]", groupName.c_str(), curPid_, drvRet);
            return drvRet;
        }
        outGroupName = groupName;
        type_ = CpType::SLAVE;
        grpName_ = outGroupName;
        BuffCfg buffConfig = {};
        drvRet = halBuffInit(&buffConfig);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Buffer initial failed for slave aicpusd[%d] ret[%d", curPid_, drvRet);
            return drvRet;
        }
        aicpusd_info("Attach group[%s] for slave aicpusd[%d] success", outGroupName.c_str(), curPid_);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::GetOrCreateGroup(std::string &outGroupName)
    {
        // check group is exists
        if (!grpName_.empty()) {
            aicpusd_info("Aicpusd[%d] already created group[%s].", curPid_, grpName_.c_str());
            outGroupName = grpName_;
            return AICPU_SCHEDULE_OK;
        }

        // create or get group, need spinlock
        lockGroup_.Lock();
        const ScopeGuard lockGuard([this] () { lockGroup_.Unlock(); });
        if (!grpName_.empty()) {
            aicpusd_info("Aicpusd[%d] already created group[%s].", curPid_, grpName_.c_str());
            outGroupName = grpName_;
            return AICPU_SCHEDULE_OK;
        }

        // get group info for current process
        std::map<std::string, GroupShareAttr> grpInfos;
        const int32_t ret = AicpuDrvManager::GetInstance().QueryProcBuffInfo(curPid_, grpInfos);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Fail to get group info of master aicpusd[%d]", curPid_);
            return ret;
        }

        // 0 group need to create group
        if (grpInfos.size() == 0U) {
            return CreateGroupForMaster(outGroupName);
        }

        // current process already in sharepool group, need attach group
        return AttachGroupForSlave(grpInfos, outGroupName);
    }

    int32_t AicpuQueueEventProcess::ShareGroupWithProcess(const std::string &groupName, const pid_t &pid) const
    {
        std::map<std::string, GroupShareAttr> grpInfos;
        const int32_t ret = AicpuDrvManager::GetInstance().QueryProcBuffInfo(pid, grpInfos);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Fail to get group info of master aicpusd[%d]", pid);
            return ret;
        }

        for (const auto &iter : grpInfos) {
            const std::string queryGroupName(iter.first);
            if (queryGroupName != groupName) {
                if (iter.second.admin != 0U) {
                    aicpusd_warn("Aicpusd already add group[%s] to slave process[%d]", groupName.c_str(), pid);
                    return AICPU_SCHEDULE_OK;
                } else {
                    aicpusd_err("Slave aicpusd[%d] already in group[%s], but doesn't has admin.",
                        pid, groupName.c_str());
                    return AICPU_SCHEDULE_ERROR_SLAVE_GRP_INVALID;
                }
            }
        }
        const int32_t drvRet = halGrpAddProc(groupName.c_str(), pid, ALL_ATTR_FOR_GROUP);
        if ((drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) &&
            (drvRet != static_cast<int32_t>(DRV_ERROR_REPEATED_INIT))) {
            aicpusd_err("Add group[%s] for slave process[%d] failed, result[%d]", groupName.c_str(), pid, drvRet);
            return drvRet;
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::GrantQueue(const event_info &event)
    {
        std::string groupName;
        int32_t ret = GetOrCreateGroup(groupName);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        if (type_ != CpType::MASTER) {
            aicpusd_err("Current process is not master, can't grant queue.");
            return AICPU_SCHEDULE_ERROR_GRANT_QUEUE_FAILED;
        }
        const char_t *msg = nullptr;
        ret = ParseQueueEventMessage(event, msg, sizeof(QueueGrantPara), true);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        const QueueGrantPara * const grantPara = PtrToPtr<const char_t, const QueueGrantPara>(msg);
        ret = ShareGroupWithProcess(groupName, grantPara->pid);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        const int32_t drvRet = halQueueGrant(grantPara->devid, static_cast<int32_t>(grantPara->qid),
            grantPara->pid, grantPara->attr);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Fail to add queue[%d] authority for aicpusd[%d], result[%d].",
                grantPara->qid, grantPara->pid, drvRet);
            return drvRet;
        }
        aicpusd_info("Add queue[%d] auth for aicpusd[%d] success.", grantPara->qid, grantPara->pid);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::AttachQueue(const event_info &event)
    {
        std::string groupName;
        int32_t ret = GetOrCreateGroup(groupName);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        if (type_ != CpType::SLAVE) {
            aicpusd_warn("Current process is not slave, not need to attach queue.");
            return AICPU_SCHEDULE_OK;
        }
        const char_t *msg = nullptr;
        ret = ParseQueueEventMessage(event, msg, sizeof(QueueAttachPara), true);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        const QueueAttachPara * const attachPara = PtrToPtr<const char_t, const QueueAttachPara>(msg);
        auto drvRet = halQueueInit(AicpuDrvManager::GetInstance().GetDeviceId());
        if ((drvRet != DRV_ERROR_NONE) && (drvRet != DRV_ERROR_REPEATED_INIT)) {
            aicpusd_err("halQueueInit error, deviceId[%u], ret[%d]",
                AicpuDrvManager::GetInstance().GetDeviceId(), drvRet);
            return drvRet;
        }
        drvRet = halQueueAttach(AicpuDrvManager::GetInstance().GetDeviceId(), attachPara->qid, 0);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Fail to attach queue[%u], result[%d]", attachPara->qid, drvRet);
            return drvRet;
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::ProcessProxyMsg(const event_info &event)
    {
        ProxyMsgRsp rsp = {};
        DoProcessProxyMsg(event, rsp);
        const int32_t resRet =
            ResponseEvent(event, PtrToPtr<ProxyMsgRsp, const char_t>(&rsp), sizeof(ProxyMsgRsp));
        return resRet;
    }

    void AicpuQueueEventProcess::DoProcessProxyMsg(const event_info &event, ProxyMsgRsp &rsp)
    {
        aicpusd_info("DoProcessProxyMsg, subevent: %u", event.comm.subevent_id);
        switch (event.comm.subevent_id) {
            case PROXY_SUBEVENT_CREATE_GROUP: {
                rsp.retCode = ProxyCreateGroup(event);
                break;
            }
            case PROXY_SUBEVENT_ALLOC_MBUF: {
                Mbuf *mbuf = nullptr;
                void *data = nullptr;
                rsp.retCode = ProxyAllocMbuf(event, &mbuf, &data);
                rsp.mbufAddr = PtrToValue(mbuf);
                rsp.dataAddr = PtrToValue(data);
                break;
            }
            case PROXY_SUBEVENT_FREE_MBUF: {
                rsp.retCode = ProxyFreeMbuf(event);
                break;
            }
            case PROXY_SUBEVENT_COPY_QMBUF: {
                rsp.retCode = ProxyCopyQMbuf(event);
                break;
            }
            case PROXY_SUBEVENT_ADD_GROUP: {
                rsp.retCode = ProxyAddGroup(event);
                break;
            }
            case PROXY_SUBEVENT_ALLOC_CACHE: {
                rsp.retCode = ProxyAllocCache(event);
                break;
            }
            default: {
                aicpusd_err("Unknown proxy subeventId: %u", event.comm.subevent_id);
                rsp.retCode = AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
                break;
            }
        }
    }

    int32_t AicpuQueueEventProcess::ProxyCreateGroup(const event_info &event)
    {
        const char_t *msg = nullptr;
        int32_t ret = ParseQueueEventMessage(event, msg, sizeof(ProxyMsgCreateGroup), true);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        const ProxyMsgCreateGroup * const createGroupMsg = PtrToPtr<const char_t, const ProxyMsgCreateGroup>(msg);
        const char_t * const groupName = createGroupMsg->groupName;
        if ((!grpName_.empty())) {
            aicpusd_info("Aicpusd[%d] already created group[%s].", curPid_, grpName_.c_str());
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        aicpusd_info("Proxy create group [%s], size[%lu]KB, allocSize[%ld].", groupName, createGroupMsg->size,
            createGroupMsg->allocSize);

        std::string outGroupName;
        ret = CreateGroupForMaster(outGroupName, groupName, createGroupMsg->size, 1U);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to create group [%s].", groupName);
            return ret;
        }

        if (createGroupMsg->allocSize >= 0) {
            GrpCacheAllocPara allocPar = {};
            allocPar.memSize = (createGroupMsg->allocSize == 0) ?
                createGroupMsg->size : static_cast<uint64_t>(createGroupMsg->allocSize);
            allocPar.memFlag = BUFF_SP_HUGEPAGE_ONLY;
            const auto allocRet = DoAllocCache(groupName, &allocPar);
            if (allocRet != AICPU_SCHEDULE_OK) {
                return allocRet;
            }
        }
        aicpusd_info("Proxy create group[%s] success", groupName);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::ProxyAllocMbuf(const event_info &event, Mbuf **mbufPtr, void **dataPptr) const
    {
        const char_t *msg = nullptr;
        int32_t ret = ParseQueueEventMessage(event, msg, sizeof(ProxyMsgAllocMbuf), true);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        const ProxyMsgAllocMbuf * const allocMbufMsg = PtrToPtr<const char_t, const ProxyMsgAllocMbuf>(msg);
        const uint64_t &mbufLen = allocMbufMsg->size;
        Mbuf *mbuf = nullptr;
        ret = halMbufAlloc(mbufLen, &mbuf);
        if ((ret != static_cast<int32_t>(DRV_ERROR_NONE)) || (mbuf == nullptr)) {
            aicpusd_err("Failed to alloc mbuf, size[%lu], ret=[%d].", mbufLen, ret);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }

        ret = halMbufGetBuffAddr(mbuf, dataPptr);
        if ((ret != static_cast<int32_t>(DRV_ERROR_NONE)) || (*dataPptr == nullptr)) {
            aicpusd_err("Failed to get mbuf data, ret=[%d]", ret);
            (void)halMbufFree(mbuf);
            mbuf = nullptr;
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        *mbufPtr = mbuf;
        aicpusd_info("Proxy Alloc mbuf success, size[%lu].", mbufLen);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::ProxyFreeMbuf(const event_info &event) const
    {
        const char_t *msg = nullptr;
        int32_t ret = ParseQueueEventMessage(event, msg, sizeof(ProxyMsgFreeMbuf), true);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        const ProxyMsgFreeMbuf * const freeMbufMsg = PtrToPtr<const char_t, const ProxyMsgFreeMbuf>(msg);
        Mbuf *const mbuf = PtrToPtr<void, Mbuf>(ValueToPtr(freeMbufMsg->mbufAddr));
        if (mbuf == nullptr) {
            aicpusd_err("Null mbuf to free");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        ret = halMbufFree(mbuf);
        if (ret != static_cast<int32_t>(DRV_ERROR_NONE)) {
            aicpusd_err("Fail to free mbuf, ret is %d", ret);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        aicpusd_info("Proxy free mbuf success.");
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::ProxyCopyQMbuf(const event_info &event) const
    {
        const char_t *msg = nullptr;
        int32_t ret = ParseQueueEventMessage(event, msg, sizeof(ProxyMsgCopyQMbuf), true);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        const ProxyMsgCopyQMbuf * const copyQMbufMsg = PtrToPtr<const char_t, const ProxyMsgCopyQMbuf>(msg);
        void *destAddr = ValueToPtr(copyQMbufMsg->destAddr);
        const auto &destLen = copyQMbufMsg->destLen;
        const auto &queueId = copyQMbufMsg->queueId;

        Mbuf *mbuf = nullptr;
        const auto drvRet = halQueueDeQueue(AicpuDrvManager::GetInstance().GetDeviceId(), queueId,
            PtrToPtr<Mbuf*, void*>(&mbuf));
        if ((drvRet != DRV_ERROR_NONE) || (mbuf == nullptr)) {
            aicpusd_err("Fail to dequeue Mbuf from queue[%u], ret is %d", queueId, static_cast<int32_t>(drvRet));
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }

        const ScopeGuard mbufGuard([&mbuf]() {
            if (mbuf != nullptr) {
                aicpusd_info("Guard to free mbuf");
                const auto drvFreeRet = halMbufFree(mbuf);
                if (drvFreeRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
                    aicpusd_err("Free mbuf failed, ret[%d].", drvFreeRet);
                }
                mbuf = nullptr;
            }
        });

        void *data = nullptr;
        ret = halMbufGetBuffAddr(mbuf, &data);
        if ((ret != static_cast<int32_t>(DRV_ERROR_NONE)) || (data == nullptr)) {
            aicpusd_err("Failed to get mbuf data, ret=[%d]", ret);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }

        uint64_t dataLen = 0U;
        ret = halMbufGetBuffSize(mbuf, &dataLen);
        if (ret != static_cast<int32_t>(DRV_ERROR_NONE)) {
            aicpusd_err("Failed to get mbuf data size, ret=[%d]", ret);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }

        if (destLen < dataLen) {
            aicpusd_err("Fail to copy for destLen[%u] < mbufLen[%u]", destLen, dataLen);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        const errno_t eRet = memcpy_s(destAddr, destLen, data, dataLen);
        if (eRet != EOK) {
            aicpusd_err("Data copy failed. dstAddrLen[%lu], dataSize[%lu], ret[%d]",
                        destLen, dataLen, eRet);
            return AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR;
        }

        aicpusd_info("Proxy copy queue[%u]'s mbuf success.", queueId);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::ProxyAddGroup(const event_info &event) const
    {
        const char_t *msg = nullptr;
        int32_t ret = ParseQueueEventMessage(event, msg, sizeof(ProxyMsgAddGroup), true);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        const ProxyMsgAddGroup * const addGroupMsg = PtrToPtr<const char_t, const ProxyMsgAddGroup>(msg);
        const char_t* const groupName = addGroupMsg->groupName;
        const auto &pid = addGroupMsg->pid;
        aicpusd_info("Proxy add group[%s] for pid[%d].", groupName, pid);

        const GroupShareAttr attrForGroup = { addGroupMsg->admin, addGroupMsg->read, addGroupMsg->write,
                                              addGroupMsg->alloc, 0U };
        ret = halGrpAddProc(groupName, pid, attrForGroup);
        if ((ret != static_cast<int32_t>(DRV_ERROR_NONE)) && (ret != static_cast<int32_t>(DRV_ERROR_REPEATED_INIT))) {
            aicpusd_err("Add group[%s] for proxy process [%d] failed, ret[%d]",
                groupName, pid, ret);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        aicpusd_info("Proxy add group[%s] for pid[%d] success", groupName, pid);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::ProxyAllocCache(const event_info &event) const
    {
        const char_t *msg = nullptr;
        int32_t ret = ParseQueueEventMessage(event, msg, sizeof(ProxyMsgAllocCache), true);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }

        if (grpName_.empty()) {
            aicpusd_err("Can not alloc cache for group has not been created!");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        const ProxyMsgAllocCache * const allocCacheMsg = PtrToPtr<const char_t, const ProxyMsgAllocCache>(msg);
        GrpCacheAllocPara allocPar = {};
        allocPar.memSize = allocCacheMsg->memSize;
        allocPar.memFlag = BUFF_SP_HUGEPAGE_ONLY;
        allocPar.allocMaxSize = allocCacheMsg->allocMaxSize;
        const auto allocRet = DoAllocCache(grpName_.c_str(), &allocPar);
        if (allocRet != AICPU_SCHEDULE_OK) {
            return allocRet;
        }
        aicpusd_info("Proxy alloc cache [%llu:%u] in group[%s] success",
            allocCacheMsg->memSize, allocCacheMsg->allocMaxSize, grpName_.c_str());
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuQueueEventProcess::DoAllocCache(const char_t* const groupName, GrpCacheAllocPara* const allocPar) const
    {
        if (&halGrpCacheAlloc == nullptr) {
            aicpusd_err("halGrpCacheAlloc not support");
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        const auto allocRet = halGrpCacheAlloc(groupName, AicpuDrvManager::GetInstance().GetDeviceId(), allocPar);
        if (allocRet != DRV_ERROR_NONE) {
            aicpusd_err("Failed to allocate group [%s], size[%llu]KB, allocMaxSize[%u], ret is %d.",
                groupName, allocPar->memSize, allocPar->allocMaxSize, static_cast<int32_t>(allocRet));
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        return AICPU_SCHEDULE_OK;
    }
}
