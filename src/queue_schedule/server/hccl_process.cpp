/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "hccl_process.h"
#include <cstdint>
#include "fsm/state_base.h"
#include "common/bqs_log.h"
#include "queue_manager.h"
#include "statistic_manager.h"
#include "entity_manager.h"
#include "router_server.h"
#include "profile_manager.h"

namespace dgw {
namespace {
// call hccl api max count when processing one event
constexpr uint32_t GET_DATA_THRESHOLD = 100U;
// supply hccl events
const std::vector<uint32_t> g_supplyEvents = {EVENT_RECV_REQUEST_MSG,
    EVENT_SEND_COMPLETION_MSG, EVENT_RECV_COMPLETION_MSG};
// link setup timeout gap
constexpr float64_t LINK_SET_UP_TIMEOUE = 60000000.0;
}

HcclProcess &HcclProcess::GetInstance()
{
    static HcclProcess instance;
    instance.Init();
    return instance;
}

void HcclProcess::Init()
{
    if (inited_) {
        return;
    }
    oneTrackEventEnabled_ = false;
    inited_ = true;
}

FsmStatus HcclProcess::ProcessRecvRequestEvent(const event_info &event, const uint32_t deviceId,
    const uint32_t resIndex)
{
    if (oneTrackEventEnabled_) {
        return FsmStatus::FSM_SUCCESS;
    }
    auto ret = FsmStatus::FSM_SUCCESS;
    auto &recvRequestEventAtomicFlag = (resIndex == 0U) ?
        recvRequestEventAtomicFlag_ : recvRequestEventAtomicFlagExtra_;
    if (!recvRequestEventAtomicFlag.test_and_set()) {
        DGW_LOG_INFO("Begin to process recv request event.");
        // init profiling data
        const uint64_t eventBegin = bqs::ProfileManager::GetInstance(resIndex).GetCpuTick();
        const uint64_t schedDelay = static_cast<uint64_t>(event.comm.sched_timestamp - event.comm.submit_timestamp);
        const uint64_t schedTimes = bqs::StatisticManager::GetInstance().HcclMpiRecvRequestEventStat();
        bqs::ProfileManager::GetInstance(resIndex).InitMarkerForRecvReqEvent(schedTimes, schedDelay);
        // process recv request
        const std::function<FsmStatus(const ChannelEntityPtr &, uint32_t &)> probeFunc =
            [this](const ChannelEntityPtr &entity, uint32_t &probeCount) -> FsmStatus {
            return ProbeCommChannel(entity, probeCount);
        };
        ret = EntityManager::Instance(resIndex).ProbeSrcCommChannel(probeFunc);
        // print profiling data
        bqs::ProfileManager::GetInstance(resIndex).DoMarkerForRecvReqEvent(eventBegin);
        // clear event working flag
        recvRequestEventAtomicFlag.clear();

        // ack event: if reply action in atomic lock, it maybe cause lost event
        (void)ReplyHcclEvent(event, deviceId);
        // postprocess: check and supply recv request event
        (void)EntityManager::Instance(resIndex).SupplyRecvRequestEvent();
    } else {
        bqs::StatisticManager::GetInstance().HcclMpiRecvReqFalseAwakenStat();
        ret = FsmStatus::FSM_FAILED;
        DGW_LOG_INFO("Recv request event is being processed by other thread.");
    }
    return ret;
}

FsmStatus HcclProcess::ProcessSendCompletionEvent(const event_info &event, const uint32_t deviceId,
    const uint32_t resIndex)
{
    if (oneTrackEventEnabled_) {
        return FsmStatus::FSM_SUCCESS;
    }
    auto ret = FsmStatus::FSM_SUCCESS;
    auto &sendCompEventAtomicFlag = (resIndex == 0U) ? sendCompEventAtomicFlag_ : sendCompEventAtomicFlagExtra_;
    if (!sendCompEventAtomicFlag.test_and_set()) {
        DGW_LOG_INFO("Begin to process send completion event.");
        // init profiling data
        const uint64_t eventBegin = bqs::ProfileManager::GetInstance(resIndex).GetCpuTick();
        const uint64_t schedDelay = static_cast<uint64_t>(event.comm.sched_timestamp - event.comm.submit_timestamp);
        const uint64_t schedTimes = bqs::StatisticManager::GetInstance().HcclMpiSendCompEventStat();
        bqs::ProfileManager::GetInstance(resIndex).InitMarkerForSendCompEvent(schedTimes, schedDelay);
        // process send comppletion
        const std::function<FsmStatus(CommChannels &, uint32_t &, uint32_t &)> testSomeFunc =
            [this](CommChannels &channels, uint32_t &totalCompCount, uint32_t &resIndexTmp) -> FsmStatus {
            return TestSomeCommChannels(channels, false, totalCompCount, resIndexTmp);
        };
        ret = EntityManager::Instance(resIndex).TestSomeCommChannels(testSomeFunc, false);
        // print profiling data
        bqs::ProfileManager::GetInstance(resIndex).DoMarkerForSendCompEvent(eventBegin);
        // clear event working flag
        sendCompEventAtomicFlag.clear();

        // ack event: if reply action in atomic lock, it maybe cause lost event
        (void)ReplyHcclEvent(event, deviceId);
        DGW_LOG_INFO("reply event[%u], deviceId[%u] success.", event.comm.event_id, deviceId);
    } else {
        bqs::StatisticManager::GetInstance().HcclMpiSendCompFalseAwakenStat();
        ret = FsmStatus::FSM_FAILED;
        DGW_LOG_INFO("Send completion event is being processed by other thread.");
    }
    return ret;
}

FsmStatus HcclProcess::ProcessRecvCompletionEvent(const event_info &event, const uint32_t deviceId,
    const uint32_t resIndex)
{
    auto ret = FsmStatus::FSM_SUCCESS;
    auto &recvCompEventAtomicFlag = (resIndex == 0U) ? recvCompEventAtomicFlag_ : recvCompEventAtomicFlagExtra_;
    if (!recvCompEventAtomicFlag.test_and_set()) {
        DGW_LOG_INFO("Begin to process recv completion event.deviceId[%u]", deviceId);
        // init profiling data
        const uint64_t eventBegin = bqs::ProfileManager::GetInstance(resIndex).GetCpuTick();
        const uint64_t schedDelay = static_cast<uint64_t>(event.comm.sched_timestamp - event.comm.submit_timestamp);
        const uint64_t schedTimes = bqs::StatisticManager::GetInstance().HcclMpiRecvCompEventStat();
        bqs::ProfileManager::GetInstance(resIndex).InitMarkerForRecvCompEvent(schedTimes, schedDelay);
        // process recv completion event
        const std::function<FsmStatus(CommChannels &, uint32_t &, uint32_t &)> testSomeFunc =
            [this](CommChannels &channels, uint32_t &totalCompCount, uint32_t &resIndexTmp) -> FsmStatus {
            return TestSomeCommChannels(channels, true, totalCompCount, resIndexTmp);
        };
        ret = EntityManager::Instance(resIndex).TestSomeCommChannels(testSomeFunc, true);

        if (oneTrackEventEnabled_) {
            // process send comppletion
            const std::function<FsmStatus(CommChannels &, uint32_t &, uint32_t &)> testSomeSendFunc =
                [this](CommChannels &channels, uint32_t &totalCompCount, uint32_t &resIndexTmp) -> FsmStatus {
                return TestSomeCommChannels(channels, false, totalCompCount, resIndexTmp);
            };
            (void)EntityManager::Instance(resIndex).TestSomeCommChannels(testSomeSendFunc, false);

            // process recv request
            const std::function<FsmStatus(const ChannelEntityPtr &, uint32_t &)> probeFunc =
                [this](const ChannelEntityPtr &entity, uint32_t &probeCount) -> FsmStatus {
                return ProbeCommChannel(entity, probeCount);
            };
            (void)EntityManager::Instance(resIndex).ProbeSrcCommChannel(probeFunc);
            (void)EntityManager::Instance(resIndex).SupplyOneTrackEvent();
        }

        // clear event working flag
        recvCompEventAtomicFlag.clear();
        // ack event: if reply action in atomic lock, it maybe cause lost event
        (void)ReplyHcclEvent(event, deviceId);
        // print profiling data
        bqs::ProfileManager::GetInstance(resIndex).DoMarkerForRecvCompEvent(eventBegin);
        DGW_LOG_INFO("reply event[%u], deviceId[%u] success.", event.comm.event_id, deviceId);
    } else {
        bqs::StatisticManager::GetInstance().HcclMpiRecvCompFalseAwakenStat();
        ret = FsmStatus::FSM_FAILED;
        DGW_LOG_INFO("Send completion event is being processed by other thread.");
    }
    return ret;
}

FsmStatus HcclProcess::ProcessCongestionReliefEvent(const event_info &event, const uint32_t deviceId,
    const uint32_t resIndex) const
{
    (void) deviceId;
    (void)event;
    (void) resIndex;
    DGW_LOG_ERROR("WARNING! Receive congestion relief event!");
    bqs::StatisticManager::GetInstance().HcclMpiF2nfEventStat();
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus HcclProcess::TestSomeCommChannels(CommChannels &channels, const bool isSrc, uint32_t &totalCompCount,
    const uint32_t resIndex) const
{
    auto &entities = channels.entities;
    auto &requests = channels.requests;
    // check request count
    if (entities.size() > requests.capacity()) {
        DGW_LOG_ERROR("WARNING: Please check requests capacity[%zu] which is less than entities size[%zu].",
            requests.capacity(), entities.size());
        return FsmStatus::FSM_FAILED;
    }

    auto ret = FsmStatus::FSM_SUCCESS;
    uint32_t reqCount = 0U;
    totalCompCount = 0U;
    while (reqCount < GET_DATA_THRESHOLD) {
        // fill requests
        bool allNullReq = true;
        size_t index = 0UL;
        for (auto iter = entities.begin(); iter != entities.end(); ++iter) {
            const RequestInfo * const hcclReq = (*iter)->FrontUncompReq();
            if (((*iter)->linkStatus_ == ChannelLinkStatus::ABNORMAL) || (hcclReq == nullptr)) {
                requests[index++] = HCCL_REQUEST_NULL;
            } else {
                if (!(hcclReq->isLink)) {
                    requests[index++] = hcclReq->req;
                    allNullReq = false;
                    DGW_LOG_DEBUG("Prepare to testsome req of entity[%s].", (*iter)->ToString().c_str());
                } else {
                    if (PreProcessSetUplinkReq(hcclReq) == FsmStatus::FSM_SUCCESS) {
                        requests[index++] = hcclReq->req;
                        allNullReq = false;
                    } else {
                        requests[index++] = HCCL_REQUEST_NULL;
                        (*iter)->linkStatus_ = ChannelLinkStatus::ABNORMAL;
                        DGW_LOG_ERROR("entity[%s] link setup timeout.", (*iter)->ToString().c_str());
                    }
                }
            }
        }
        if (allNullReq) {
            DGW_LOG_DEBUG("Not exist any request which need to be tested.");
            break;
        }
        // call HcclTestSome
        int32_t compCount = 0;
        auto &compIndices = channels.compIndices;
        auto &compStatus = channels.compStatus;
        const uint64_t begin = bqs::ProfileManager::GetInstance(resIndex).GetCpuTick();
        const auto hcclRet = HcclTestSome(static_cast<int32_t>(entities.size()), requests.data(),
                                          &compCount, compIndices.data(), compStatus.data());
        bqs::ProfileManager::GetInstance(resIndex).AddHcclTestSomeCost(
            bqs::ProfileManager::GetInstance(resIndex).GetCpuTick() - begin, isSrc);
        if (hcclRet == static_cast<int32_t>(HCCL_E_IN_STATUS)) {
            DGW_LOG_INFO("Test some is unreachable, ret is [%d].", hcclRet);
        } else if (hcclRet != static_cast<int32_t>(HCCL_SUCCESS)) {
            DGW_LOG_ERROR("Failed to test some, ret is [%d].", hcclRet);
            ret = FsmStatus::FSM_FAILED;
            break;
        }
        reqCount++;

        if (compCount == 0) {
            DGW_LOG_INFO("Not exist test completed request.");
            break;
        }
        totalCompCount += static_cast<uint32_t>(compCount);
        // check result
        (void)ProcTestSomeResults(compCount, channels, hcclRet);
    }
    if ((!isSrc) && (totalCompCount != 0U)) {
        (void)EntityManager::Instance(resIndex).SupplyEvent(static_cast<uint32_t>(EVENT_QUEUE_FULL_TO_NOT_FULL));
        DGW_LOG_INFO("Success to trigger tag f2nf event.");
    }
    DGW_LOG_INFO("Test some comm channels success count is %u.", reqCount);
    return ret;
}

FsmStatus HcclProcess::ProcTestSomeResults(const int32_t compCount, CommChannels &channels, int32_t hcclRet) const
{
    for (size_t i = 0UL; i < static_cast<size_t>(compCount); i++) {
        const size_t reqIdx = static_cast<size_t>(channels.compIndices[i]);
        HcclStatus &status = channels.compStatus[i];
        ChannelEntityPtr &entity = channels.entities[reqIdx];
        // check status
        if (status.error != 0) {
            DGW_LOG_ERROR("Comm channel[%s] test some failed, status:[rank:%d, tag:%d, error:%d], hcclRet[%d].",
                entity->ToString().c_str(), status.srcRank, status.tag, status.error, hcclRet);
            if (((status.error == static_cast<int32_t>(HCCL_E_TCP_TRANSFER)) ||
                 (status.error == static_cast<int32_t>(HCCL_E_ROCE_TRANSFER))) && (hcclRet == HCCL_E_IN_STATUS)) {
                entity->linkStatus_ = ChannelLinkStatus::ABNORMAL;
                DGW_LOG_RUN_INFO("set entity link status is abnormal.");
            }
            continue;
        }
        // process completed request
        (void)entity->ProcessCompReq();
    }
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus HcclProcess::ProbeCommChannel(const ChannelEntityPtr &entity, uint32_t &probeCount) const
{
    if (entity == nullptr) {
        probeCount = 0U;
        return FsmStatus::FSM_FAILED;
    }
    HcclMessage msg = nullptr;
    uint64_t dataCount = 0UL;

    uint32_t reqTotalCount = 0U;
    uint32_t envelopeCacheCount = 0U;
    uint64_t probeTick = 0UL;
    while (reqTotalCount < GET_DATA_THRESHOLD) {
        auto ret = entity->Probe(dataCount, msg, probeTick);
        // uncompReqQueue_ full, cache envelope, then continue probe
        if (ret == FsmStatus::FSM_CACHED) {
            envelopeCacheCount++;
            reqTotalCount++;
            continue;
        }
        // probe failed, perhaps current channel have no envelope, quit the loop
        if (ret != FsmStatus::FSM_SUCCESS) {
            break;
        }
        // probe success, alloc mbuf and call HcclImrecv to get request
        reqTotalCount++;
        ret = entity->ReceiveData(msg, dataCount, probeTick);
        if (ret != FsmStatus::FSM_SUCCESS) {
            break;
        }
    }
    probeCount = reqTotalCount;
    DGW_LOG_INFO("Probe comm channel success, total count is [%u], envelope cached count is [%u], entity:[%s].",
        reqTotalCount, envelopeCacheCount, entity->ToString().c_str());
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus HcclProcess::SupplyEvents(const uint32_t resIndex) const
{
    // supply F2NF event
    (void)EntityManager::Instance(resIndex).SupplyEvent(static_cast<uint32_t>(EVENT_QUEUE_FULL_TO_NOT_FULL));

    if (!bqs::RouterServer::GetInstance().GetCallHcclFlag()) {
        return FsmStatus::FSM_SUCCESS;
    }
    // supply hccl event
    if (oneTrackEventEnabled_) {
        (void)EntityManager::Instance(resIndex).SupplyEvent(EVENT_RECV_COMPLETION_MSG);
    } else {
        for (const auto eventId : g_supplyEvents) {
            (void)EntityManager::Instance(resIndex).SupplyEvent(eventId);
        };
    }
    DGW_LOG_INFO("Supply event success.");
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus HcclProcess::ReplyHcclEvent(const event_info &event, const uint32_t deviceId) const
{
    const uint32_t eventId = static_cast<uint32_t>(event.comm.event_id);
    // ack event
    const auto drvRet = halEschedAckEvent(deviceId,
        static_cast<EVENT_ID>(eventId), event.comm.subevent_id, nullptr, 0U);
    if (drvRet != DRV_ERROR_NONE) {
        DGW_LOG_ERROR("Failed to reply event[%u], deviceId[%u], ret is %d.", eventId, deviceId, drvRet);
        return FsmStatus::FSM_FAILED;
    }
    DGW_LOG_INFO("reply event[%u], deviceId[%u] success.", eventId, deviceId);

    // statistic callback count
    switch (eventId) {
        case dgw::EVENT_RECV_REQUEST_MSG: {
            bqs::StatisticManager::GetInstance().HcclMpiRecvReqCallbackStat();
            break;
        }
        case dgw::EVENT_SEND_COMPLETION_MSG: {
            bqs::StatisticManager::GetInstance().HcclMpiSendCompCallbackStat();
            break;
        }
        case dgw::EVENT_RECV_COMPLETION_MSG: {
            bqs::StatisticManager::GetInstance().HcclMpiRecvCompCallbackStat();
            break;
        }
        default: {
            DGW_LOG_ERROR("Unsupported event[%u].", eventId);
            break;
        }
    }
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus HcclProcess::PreProcessSetUplinkReq(const RequestInfo * const hcclReq) const
{
    const uint64_t curTick = bqs::ProfileManager::GetInstance().GetCpuTick();
    if (curTick >= hcclReq->startTick) {
        const auto timeCost = bqs::ProfileManager::GetInstance().GetTimeCost(curTick - hcclReq->startTick);
        if (timeCost >= LINK_SET_UP_TIMEOUE) {
            DGW_LOG_ERROR("curtick:%lu, setuptick:%lu, threshold:%.2fus, linkSetUp timeout:%.2fus.", curTick,
                          hcclReq->startTick, LINK_SET_UP_TIMEOUE, timeCost);
            return FsmStatus::FSM_FAILED;
        }
        return FsmStatus::FSM_SUCCESS;
    }
    DGW_LOG_ERROR("cur tick:%lu is smaller than SetUpTick:%lu.", curTick, hcclReq->startTick);
    return FsmStatus::FSM_FAILED;
}
}  // namespace dgw