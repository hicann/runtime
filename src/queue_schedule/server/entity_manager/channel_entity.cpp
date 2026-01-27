/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "channel_entity.h"
#include <algorithm>
#include "bqs_status.h"
#include "bqs_util.h"
#include "msprof_manager.h"
#include "profile_manager.h"
#include "queue_manager.h"
#include "schedule_config.h"

namespace dgw {

namespace {
    // probe comm channel failed
    constexpr int32_t PROBE_COMM_CHANNEL_FAILED = 0;
    // comm channel queue name prefix
    constexpr const char_t *COMM_CHANNEL_QUEUE_NAME_PREFIX = "CommChannelQueue_";
    // request process completed time cost threshold (us) maybe 500000us
    constexpr float64_t REQ_COMP_TIME_COST_THRESHOLD = 500000.0;
    // envelope processed time cost threshold (us)
    constexpr float64_t ENVELOPE_PROC_TIME_COST_THRESHOLD = 500000.0;
    // count threshold for print error (first improbe and testsome cost too long time, no need check)
    const uint64_t COUNT_THRESHOLD_FOR_PRINT_ERROR = 10UL;
    const uint32_t CHECK_SEND_COMPLETION_INTERVAL_US = 100U;
    const uint32_t CHECK_SEND_COMPLETION_LIMIT_US = 100000U;  // 100ms
}

ChannelEntity::ChannelEntity(const EntityMaterial &material, const uint32_t resIndex)
    : SimpleEntity(material, resIndex),
      linkStatus_(ChannelLinkStatus::UNCONNECTED),
      channelPtr_(material.channel),
      compReqQueueId_(0U),
      cachedReqCount_(0U),
      maxCachedReqCount_(0U),
      mbufDataSend_(false),
      compReqCount_(0UL),
      procEnvelopeCount_(0UL)
{
    if (channelPtr_ != nullptr) {
        (void)entityDesc_.append(", ").append(channelPtr_->ToString());
    }
}

ChannelEntity::~ChannelEntity()
{
    DGW_LOG_RUN_INFO("Success to destruct tag entity[%s].", entityDesc_.c_str());
}

FsmStatus ChannelEntity::Init(const FsmState state, const EntityDirection direction)
{
    if (channelPtr_ == nullptr) {
        DGW_LOG_ERROR("channelPtr_ is nullptr in comm channel entity[%s].", entityDesc_.c_str());
        return FsmStatus::FSM_FAILED;
    }

    (void) SimpleEntity::Init(state, direction);

    // calculate maxCachedReqCount_
    maxCachedReqCount_ = channelPtr_->GetLocalTagDepth() * 2U;
    // init uncompleted request queue
    const uint32_t uncompQueDepth = channelPtr_->GetLocalTagDepth() * 2U + 1U;
    auto ret = uncompReqQueue_.Init(uncompQueDepth);
    if (ret != FsmStatus::FSM_SUCCESS) {
        return ret;
    }

    // only src tag need envelope chached queue and completed request queue
    // dst tag need try to establish a link with peer tag
    if (direction == EntityDirection::DIRECTION_RECV) {
        ret = SendDataForLink();
    } else {
        // init envelope cached queue
        const uint32_t cacheQueDepth = channelPtr_->GetPeerTagDepth() * 2U + 1U;
        ret = cachedEnvelopeQueue_.Init(cacheQueDepth);
        if (ret != FsmStatus::FSM_SUCCESS) {
            return ret;
        }

        ret = CreateAndSubscribeCompletedQueue();
        if (ret != FsmStatus::FSM_SUCCESS) {
            return ret;
        }
        (void)entityDesc_.append(", compReqQueue:").append(std::to_string(compReqQueueId_));
    }
    if (ret != FsmStatus::FSM_SUCCESS) {
        return ret;
    }

    linkStatus_ = dgw::ChannelLinkStatus::UNCONNECTED;
    // add unlink tag count
    const uint32_t unlinkTagCount = bqs::StatisticManager::GetInstance().AddUnlinkCount();
    bqs::StatisticManager::GetInstance().AddTagCount();
    DGW_LOG_RUN_INFO("Success to init entity:[%s], current unlink tag count is [%u].",
        entityDesc_.c_str(), unlinkTagCount);
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus ChannelEntity::CreateAndSubscribeCompletedQueue()
{
    // create and subscribe completed request queue
    std::string queueName(COMM_CHANNEL_QUEUE_NAME_PREFIX);
    (void)queueName.append(std::to_string(id_)).append("_");
    const uint32_t compQueDepth = channelPtr_->GetLocalTagDepth() + 1U;
    auto bqsRet = bqs::QueueManager::GetInstance()
        .CreateQueue(queueName.c_str(), compQueDepth, compReqQueueId_, deviceId_);
    if (bqsRet != bqs::BqsStatus::BQS_STATUS_OK) {
        DGW_LOG_ERROR("Create completed queue failed, queueName[%s], ret[%d].", queueName.c_str(),
                        static_cast<int32_t>(bqsRet));
        return FsmStatus::FSM_FAILED;
    }
    const auto subscriber = GetSubscriber();
    if (subscriber == nullptr) {
        return FsmStatus::FSM_FAILED;
    }
    bqsRet = subscriber->Subscribe(compReqQueueId_);
    if (bqsRet != bqs::BqsStatus::BQS_STATUS_OK) {
        DGW_LOG_ERROR("Subscribe completed queue failed, queueName[%s], queueId[%u], ret[%d].",
            queueName.c_str(), compReqQueueId_, static_cast<int32_t>(bqsRet));
        return FsmStatus::FSM_FAILED;
    }
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus ChannelEntity::Uninit()
{
    // clear mbuf
    while (!uncompReqQueue_.IsEmpty()) {
        RequestInfo * const uncompReq = uncompReqQueue_.Front();
        if (uncompReq == nullptr) {
            DGW_LOG_ERROR("Failed to get front from uncompleted req queue, entity:[%s].", entityDesc_.c_str());
            break;
        }
        const auto mbuf = uncompReq->mbuf;
        if (mbuf != nullptr) {
            (void)halMbufFree(mbuf);
            if (direction_ == EntityDirection::DIRECTION_RECV) {
                statInfo_.freeMbufTimes++;
            }
            DGW_LOG_RUN_INFO("Success to free mbuf for entity[%s] when uninit entity.", entityDesc_.c_str());
        }
        if (uncompReqQueue_.Pop() == 0) {
            DGW_LOG_ERROR("Failed to pop from uncompleted req queue, entity:[%s].", entityDesc_.c_str());
        } else {
            statInfo_.uncompReqQueuePopTimes++;
            DGW_LOG_RUN_INFO("Success to pop from uncompleted req queue when uninit entity:[%s].", entityDesc_.c_str());
        }
    }

    uncompReqQueue_.Uninit();
    if (direction_ == EntityDirection::DIRECTION_SEND) {
        cachedEnvelopeQueue_.Uninit();
         const auto subscriber = GetSubscriber();
        if (subscriber == nullptr) {
            return FsmStatus::FSM_FAILED;
        }
        subscriber->Unsubscribe(compReqQueueId_);
        (void)bqs::QueueManager::GetInstance().DestroyQueue(compReqQueueId_, deviceId_);
    }
    bqs::StatisticManager::GetInstance().ReduceTagCount();
    if (hostGroupId_ == INVALID_GROUP_ID) {
        (void)CommChannelManager::GetInstance().DeleteCommChannel(*channelPtr_);
    }
    Dump();
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus ChannelEntity::Probe(uint64_t &dataCount, HcclMessage &msg, uint64_t &probeTick)
{
    bool cachedEnvelopeQueEmpty = true;
    // check cached envelope queue empty
    if (!cachedEnvelopeQueue_.IsEmpty()) {
        // no need check uncompReqQue full
        if (AddCachedReqCount()) {
            const auto info = cachedEnvelopeQueue_.Front();
            msg = info->msg;
            dataCount = info->dataSize;
            probeTick = info->probeTick;
            (void)cachedEnvelopeQueue_.Pop();
            DGW_LOG_INFO("Get cached envelope for comm channel[%s], rest envelope size is [%u].",
                entityDesc_.c_str(), cachedEnvelopeQueue_.Size());
            return FsmStatus::FSM_SUCCESS;
        }
        if (cachedEnvelopeQueue_.IsFull()) {
            DGW_LOG_INFO("Cached req count of comm channel[%s] is up to [%u] and cachedEnvelopeQueue is up to [%u],"
                "then skip probe.", entityDesc_.c_str(), maxCachedReqCount_, cachedEnvelopeQueue_.Size());
            return FsmStatus::FSM_FAILED;
        }
        cachedEnvelopeQueEmpty = false;
        DGW_LOG_INFO(
            "Cached req count of comm channel[%s] is up to [%u], try to probe channel, then cache envelope.",
            entityDesc_.c_str(), maxCachedReqCount_);
    }

    uint64_t probeSuccTick = 0U;
    const auto probeRet = DoProbe(dataCount, msg, probeSuccTick);
    if (probeRet != FsmStatus::FSM_SUCCESS) {
        return probeRet;
    }

    // cachedEnvelopeQueue_ not empty: cache envelope
    // cachedEnvelopeQueue_ empty: if cached req count up to max, cache envelope
    if ((!cachedEnvelopeQueEmpty) || (!AddCachedReqCount())) {
        EnvelopeInfo info = {.msg = msg, .dataSize = dataCount, .probeTick = probeSuccTick};
        if (cachedEnvelopeQueue_.Push(info) != 1) {
            DGW_LOG_ERROR("Unhandle error! cached req count of channel[%s] is up to max[%u], but cache envelope failed!"
                " Current cache envelope count is [%u].",
                entityDesc_.c_str(), maxCachedReqCount_, cachedEnvelopeQueue_.Size());
            return FsmStatus::FSM_FAILED;
        }
        DGW_LOG_RUN_INFO(
            "Cached req count of channel[%s] is up to max[%u], cache envelope info, current count is [%u].",
            entityDesc_.c_str(), maxCachedReqCount_, cachedEnvelopeQueue_.Size());
        return FsmStatus::FSM_CACHED;
    }
    probeTick = probeSuccTick;
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus ChannelEntity::DoProbe(uint64_t &dataCount, HcclMessage &msg, uint64_t &probeSuccTick)
{
    // probe src tag
    DGW_LOG_DEBUG("Begin to probe comm channel[%s].", entityDesc_.c_str());
    HcclStatus status = {};
    int32_t probeFlag = PROBE_COMM_CHANNEL_FAILED;
    const uint64_t probeBegin = bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick();
    auto hcclRet = HcclImprobe(static_cast<int32_t>(channelPtr_->GetPeerRankId()),
                               static_cast<int32_t>(channelPtr_->GetPeerTagId()),
                               channelPtr_->GetHandle(), &probeFlag, &msg, &status);
    bqs::ProfileManager::GetInstance(resIndex_).AddHcclImprobeCost(
        bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick() - probeBegin);
    statInfo_.hcclImprobeTotalTimes++;
    if (hcclRet != static_cast<int32_t>(HCCL_SUCCESS)) {
        statInfo_.hcclImprobeFailTimes++;
        DGW_LOG_ERROR("Failed to probe comm channel[%s], ret is [%d].", entityDesc_.c_str(), hcclRet);
        return FsmStatus::FSM_FAILED;
    }
    if (probeFlag == PROBE_COMM_CHANNEL_FAILED) {
        DGW_LOG_DEBUG("No data in comm channel[%s], flag is [%d].", entityDesc_.c_str(), probeFlag);
        return FsmStatus::FSM_FAILED;
    }
    probeSuccTick = bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick();
    DGW_LOG_DEBUG("Success to probe comm channel[%s].", entityDesc_.c_str());

    // get count
    int32_t count = 0;
    const uint64_t getCountBegin = bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick();
    hcclRet = HcclGetCount(&status, HCCL_DATA_TYPE_INT8, &count);
    bqs::ProfileManager::GetInstance(resIndex_).AddHcclGetCountCost(
        bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick() - getCountBegin);
    if (hcclRet != static_cast<int32_t>(HCCL_SUCCESS)) {
        DGW_LOG_ERROR("Failed to get count from comm channel[%s], ret is [%d].", entityDesc_.c_str(), hcclRet);
        return FsmStatus::FSM_FAILED;
    }
    dataCount = static_cast<uint64_t>(count);

    // check link message
    if (dataCount == 0UL) {
        DGW_LOG_RUN_INFO("Success to get link message from comm channel[%s].", entityDesc_.c_str());
    } else {
        statInfo_.hcclImprobeSuccTimes++;
        DGW_LOG_DEBUG("Success to get data count[%lu] from comm channel[%s].", dataCount, entityDesc_.c_str());
    }
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus ChannelEntity::AllocMbuf(Mbuf *&mbufPtr, void *&headBuf, void *&dataBuf, const uint64_t dataLen)
{
    bqs::ProfInfo reportData = { };
    if (bqs::BqsMsprofManager::GetInstance().IsStartProfling()) {
        reportData.type = static_cast<uint32_t>(bqs::DgwProfInfoType::ALLOC_MBUF);
        reportData.itemId = transId_;
        reportData.timeStamp = bqs::GetTimeStamp();
    }

    const uint64_t begin = bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick();
    int32_t ret = halMbufAlloc(dataLen, &mbufPtr);
    bqs::ProfileManager::GetInstance(resIndex_).
        AddMbufAllocCost(bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick() - begin);
    bqs::BqsMsprofManager::GetInstance().ReportApiPerf(reportData);
    if (ret != static_cast<int32_t>(DRV_ERROR_NONE)) {
        DGW_LOG_ERROR("Failed to call halMbufAlloc, dataLen:[%lu], ret=[%d].", dataLen, ret);
        return FsmStatus::FSM_FAILED;
    }
    bqs::StatisticManager::GetInstance().MbufAllocStat(dataLen);

    ret = halMbufSetDataLen(mbufPtr, dataLen);
    if (ret != static_cast<int32_t>(DRV_ERROR_NONE)) {
        DGW_LOG_ERROR("Failed to call halMbufSetDataLen, ret=[%d].", ret);
        (void)halMbufFree(mbufPtr);
        return FsmStatus::FSM_FAILED;
    }

    uint32_t headerSize = 0U;
    ret = halMbufGetPrivInfo(mbufPtr, &headBuf, &headerSize);
    if ((ret != static_cast<int32_t>(DRV_ERROR_NONE)) || (headBuf == nullptr)) {
        DGW_LOG_ERROR("Failed to call halMbufGetPrivInfo, ret=[%d].", ret);
        (void)halMbufFree(mbufPtr);
        return FsmStatus::FSM_FAILED;
    }
    hcclData_.mbufHeadSize = static_cast<uint64_t>(headerSize);

    ret = halMbufGetBuffAddr(mbufPtr, &dataBuf);
    if ((ret != static_cast<int32_t>(DRV_ERROR_NONE)) || (dataBuf == nullptr)) {
        DGW_LOG_ERROR("Failed to call halMbufGetBuffAddr, ret=[%d].", ret);
        (void)halMbufFree(mbufPtr);
        return FsmStatus::FSM_FAILED;
    }
    DGW_LOG_DEBUG("Success to alloc mbuf, dataLen:[%lu].", dataLen);
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus ChannelEntity::ReceiveData(HcclMessage &msg, const uint64_t dataCount, const uint64_t probeTick)
{
    // process link message
    if (dataCount == 0UL) {
        return ReceiveDataForLink(msg);
    }

    procEnvelopeCount_++;
    const auto timeCost = bqs::ProfileManager::GetInstance(resIndex_).GetTimeCost(
        bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick() - probeTick);
    if ((timeCost > ENVELOPE_PROC_TIME_COST_THRESHOLD) && (procEnvelopeCount_ > COUNT_THRESHOLD_FOR_PRINT_ERROR)) {
        DGW_LOG_RUN_INFO("Time cost to process envelope is %.2fus, count:[%lu], entity:[%s].",
            timeCost, procEnvelopeCount_, entityDesc_.c_str());
    }

    bool isMbufData = true;
    {
        // no need lock, no parallel scenarios
        if (hcclData_.dataSize == 0UL) {
            hcclData_.dataSize = dataCount;
            isMbufData = true;
        } else {
            hcclData_.headSize = dataCount;
            isMbufData = false;
        }
    }

    if (isMbufData) {
        return ReceiveMbufData(msg);
    }
    return ReceiveMbufHead(msg);
}

FsmStatus ChannelEntity::ReceiveDataForLink(HcclMessage &msg)
{
    HcclRequest request;
    const uint64_t begin = bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick();
    const auto hcclRet = HcclImrecv(nullptr, 0, HCCL_DATA_TYPE_INT8, &msg, &request);
    bqs::ProfileManager::GetInstance(resIndex_).
        AddHcclImrecvCost(bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick() - begin);
    if (hcclRet != HCCL_SUCCESS) {
        // unable to handle irecv error
        bqs::StatisticManager::GetInstance().HcclMpiRecvFailStat();
        DGW_LOG_ERROR("Fail to call HcclImrecv to recv link zero data, entity:[%s], ret:[%d].",
            entityDesc_.c_str(), hcclRet);
        return FsmStatus::FSM_FAILED;
    }
    bqs::StatisticManager::GetInstance().HcclMpiRecvSuccStat();

    // save request, unable to handle enqueue failure
    RequestInfo req = {.req = request, .isLink = true, .mbuf = nullptr,
                       .startTick = bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick()};
    const int32_t count = uncompReqQueue_.Push(req);
    if (count == 0) {
        DGW_LOG_ERROR("Unhandled error! Failed to enqueue uncompleted request for link establishment, entity[%s].",
            entityDesc_.c_str());
        return FsmStatus::FSM_FAILED;
    }
    DGW_LOG_RUN_INFO("Success to receive zero data for link establishment, entity:[%s].",
        entityDesc_.c_str());
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus ChannelEntity::ReceiveMbufData(HcclMessage &msg)
{
    Mbuf *mbuf = nullptr;
    void *headBuf = nullptr;
    void *dataBuf = nullptr;
    const uint64_t dataSize = hcclData_.dataSize;
    const auto ret = AllocMbuf(mbuf, headBuf, dataBuf, dataSize);
    if (ret != FsmStatus::FSM_SUCCESS) {
        return ret;
    }
    statInfo_.allocMbufTimes++;
    // record mbuf and headBuf
    hcclData_.mbuf = mbuf;
    hcclData_.headBuf = headBuf;

    // call hccl irecv api
    HcclRequest request;
    const uint64_t begin = bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick();
    const auto hcclRet = HcclImrecv(dataBuf, static_cast<int32_t>(dataSize), HCCL_DATA_TYPE_INT8, &msg, &request);
    bqs::ProfileManager::GetInstance(resIndex_).
        AddHcclImrecvCost(bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick() - begin);
    if (hcclRet != static_cast<int32_t>(HCCL_SUCCESS)) {
        DGW_LOG_ERROR("HcclImrecv fail for entity:[%s], ret:[%d].", entityDesc_.c_str(), hcclRet);
        statInfo_.hcclImrecvFailTimes++;
        // unable to handle irecv error
        bqs::StatisticManager::GetInstance().HcclMpiRecvFailStat();
        return FsmStatus::FSM_FAILED;
    }
    statInfo_.hcclImrecvSuccTimes++;
    bqs::StatisticManager::GetInstance().HcclMpiRecvSuccStat();
    DGW_LOG_INFO("Success to call HcclImrecv to recv data, data size:[%lu], "
        "entity:[%s]", dataSize, entityDesc_.c_str());

    // save request, unable to handle enqueue failure
    RequestInfo req = {.req = request, .isLink = false, .mbuf = nullptr,
                       .startTick = bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick()};
    const int32_t count = uncompReqQueue_.Push(req);
    if (count == 0) {
        DGW_LOG_ERROR("Unhandled error! Failed to enqueue uncompleted request for entity[%s].", entityDesc_.c_str());
        return FsmStatus::FSM_FAILED;
    }
    statInfo_.uncompReqQueuePushTimes++;
    DGW_LOG_INFO("Success to enqueue uncompleted request and mbuf for entity[%s]",
        entityDesc_.c_str());
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus ChannelEntity::ReceiveMbufHead(HcclMessage &msg)
{
    // call hccl irecv api
    HcclRequest request;
    const uint64_t begin = bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick();
    const auto hcclRet = HcclImrecv(hcclData_.headBuf, static_cast<int32_t>(hcclData_.mbufHeadSize),
                                    HCCL_DATA_TYPE_INT8, &msg, &request);
    bqs::ProfileManager::GetInstance(resIndex_).
        AddHcclImrecvCost(bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick() - begin);
    Mbuf * const mbuf = hcclData_.mbuf;
    if (hcclRet != static_cast<int32_t>(HCCL_SUCCESS)) {
        DGW_LOG_ERROR("HcclImrecv fail for entity:[%s], ret:[%d].", entityDesc_.c_str(), hcclRet);
        statInfo_.hcclImrecvFailTimes++;
        // unable to handle irecv error
        if (mbuf != nullptr) {
            DGW_LOG_INFO("Free Mbuf for entity[%s].", entityDesc_.c_str());
            (void)halMbufFree(mbuf);
        }
        bqs::StatisticManager::GetInstance().HcclMpiRecvFailStat();
        return FsmStatus::FSM_FAILED;
    }
    statInfo_.hcclImrecvSuccTimes++;
    bqs::StatisticManager::GetInstance().HcclMpiRecvSuccStat();

    // clear hcclData
    hcclData_.headSize = 0UL;
    hcclData_.dataSize = 0UL;
    hcclData_.mbuf = nullptr;
    hcclData_.headBuf = nullptr;
    hcclData_.mbufHeadSize = 0UL;
    // save request, unable to handle enqueue failure
    RequestInfo req = {.req = request, .isLink = false, .mbuf = mbuf,
                       .startTick = bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick()};
    const int32_t count = uncompReqQueue_.Push(req);
    if (count == 0) {
        return FsmStatus::FSM_FAILED;
    }
    statInfo_.uncompReqQueuePushTimes++;
    DGW_LOG_INFO("Success to enqueue uncompleted request and mbuf for entity[%s].",
        entityDesc_.c_str());
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus ChannelEntity::DoSendData(Mbuf *const mbuf)
{
    if (linkStatus_ == ChannelLinkStatus::ABNORMAL) {
        DGW_LOG_ERROR("channel is abnormal send data failed.");
        return FsmStatus::FSM_ERROR_PENDING;
    }
    bqs::ProfInfo reportData = { };
    if (bqs::BqsMsprofManager::GetInstance().IsStartProfling()) {
        reportData.type = static_cast<uint32_t>(bqs::DgwProfInfoType::HCCL_TRANS_DATA);
        reportData.itemId = transId_;
        reportData.timeStamp = bqs::GetTimeStamp();
    }
    bqs::ScopeGuard profGuard([&reportData]() { bqs::BqsMsprofManager::GetInstance().ReportApiPerf(reportData); });
    // After recovery, if the data filed of mbuf has been sent, it will not be sent again
    // first, send data field of mbuf; then, send head field of mbuf
    if (!mbufDataSend_) {
        const FsmStatus sendDataRet = SendMbufData(mbuf);
        if (sendDataRet != FsmStatus::FSM_SUCCESS) {
            return sendDataRet;
        }
        mbufDataSend_ = true;
    }

    const FsmStatus sendHeadRet = SendMbufHead(mbuf);
    if (sendHeadRet != FsmStatus::FSM_SUCCESS) {
        return sendHeadRet;
    }
    // set status for next data
    mbufDataSend_ = false;
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus ChannelEntity::SendDataWithHccl(void *const dataBuf, const int32_t dataLen, Mbuf *const mbufToRecord)
{
    HcclRequest req = nullptr;
    HcclComm handle = channelPtr_->GetHandle();
    const int32_t rankId = static_cast<int32_t>(channelPtr_->GetPeerRankId());
    const int32_t tagId = static_cast<int32_t>(channelPtr_->GetPeerTagId());
    const uint64_t begin = bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick();
    const auto hcclRet = HcclIsend(dataBuf, dataLen, HCCL_DATA_TYPE_INT8, rankId, tagId, handle, &req);
    bqs::ProfileManager::GetInstance(resIndex_).
        AddHcclIsendCost(bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick() - begin);
    if (hcclRet == static_cast<int32_t>(HCCL_E_AGAIN)) {
        statInfo_.hcclIsendFullTimes++;
        bqs::StatisticManager::GetInstance().HcclMpiSendFullStat();
        DGW_LOG_WARN("Failed to call HcclIsendWithEvent to send data for mbuf, tag full, entity:[%s], ret=[%d]",
            entityDesc_.c_str(), hcclRet);
        return FsmStatus::FSM_DEST_FULL;
    }
    if (hcclRet != static_cast<int32_t>(HCCL_SUCCESS)) {
        statInfo_.hcclIsendFailTimes++;
        bqs::StatisticManager::GetInstance().HcclMpiSendFailStat();
        DGW_LOG_ERROR("entity:[%s] fail to send data with hccl.", entityDesc_.c_str());
        return FsmStatus::FSM_ERROR_PENDING;
    }
    statInfo_.hcclIsendSuccTimes++;
    bqs::StatisticManager::GetInstance().HcclMpiSendSuccStat();

    // cache request
    RequestInfo reqInfo = {.req = req, .isLink = false, .mbuf = mbufToRecord,
                           .startTick = bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick()};
    const int32_t count = uncompReqQueue_.Push(reqInfo);
    if (count == 0) {
        DGW_LOG_ERROR("entity:[%s] fail to push req into uncompReqQueue.", entityDesc_.c_str());
        return FsmStatus::FSM_ERROR_PENDING;
    }
    statInfo_.uncompReqQueuePushTimes++;
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus ChannelEntity::SendMbufData(Mbuf * const mbuf)
{
    // check uncompleted req queue full
    if (uncompReqQueue_.IsFull()) {
        DGW_LOG_RUN_INFO("Uncompleted request queue of dst entity:[%s] is full.", entityDesc_.c_str());
        return FsmStatus::FSM_DEST_FULL;
    }

    uint64_t dataLen = 0UL;
    auto drvRet = halMbufGetDataLen(mbuf, &dataLen);
    if ((drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) || (dataLen == 0U)) {
        drvRet = halMbufGetBuffSize(mbuf, &dataLen);
        if (drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
            DGW_LOG_ERROR("Fail to get buff size for mbuf, entity:[%s], ret=[%d]", entityDesc_.c_str(), drvRet);
            return FsmStatus::FSM_FAILED;
        }
    }

    void *dataBuf = nullptr;
    drvRet = halMbufGetBuffAddr(mbuf, &dataBuf);
    if ((drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) || (dataBuf == nullptr)) {
        DGW_LOG_ERROR("Fail to get buff addr for mbuf, entity:[%s], ret=[%d]", entityDesc_.c_str(), drvRet);
        return FsmStatus::FSM_FAILED;
    }

    DGW_LOG_INFO("Tag[%u] HcclIsend data[%lu]", channelPtr_->GetPeerTagId(), dataLen);
    const auto sendRet = SendDataWithHccl(dataBuf, static_cast<int32_t>(dataLen), nullptr);
    if (sendRet != FsmStatus::FSM_SUCCESS) {
        DGW_LOG_ERROR("Tag[%u] HcclIsend data[%lu] fail", channelPtr_->GetPeerTagId(), dataLen);
        return sendRet;
    }

    DGW_LOG_INFO("Success to call HcclIsend to send data for mbuf, entity:[%s], len:[%lu].",
        entityDesc_.c_str(), dataLen);
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus ChannelEntity::SendMbufHead(Mbuf * const mbuf)
{
    // check uncompleted req queue full
    if (uncompReqQueue_.IsFull()) {
        DGW_LOG_RUN_INFO("Uncompleted request queue of dst entity:[%s] is full.", entityDesc_.c_str());
        return FsmStatus::FSM_DEST_FULL;
    }

    uint32_t headSize = 0U;
    void *headBuf = nullptr;
    const auto drvRet = halMbufGetPrivInfo(mbuf, &headBuf, &headSize);
    if (drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
        DGW_LOG_ERROR("Failed to get head info from mbuf, ret[%d].", drvRet);
        return FsmStatus::FSM_FAILED;
    }

    const auto sendRet = SendDataWithHccl(headBuf, static_cast<int32_t>(headSize), mbuf);
    if (sendRet != FsmStatus::FSM_SUCCESS) {
        DGW_LOG_ERROR("Tag[%u] HcclIsend head fail", channelPtr_->GetPeerTagId());
        return sendRet;
    }

    DGW_LOG_INFO("Success to call HcclIsend to send head for mbuf, entity:[%s], len:[%lu].",
        entityDesc_.c_str(), headSize);
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus ChannelEntity::SendDataForLink()
{
    HcclRequest req;
    const uint64_t begin = bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick();
    const auto hcclRet = HcclIsend(nullptr, 0, HCCL_DATA_TYPE_INT8,
                                   static_cast<int32_t>(channelPtr_->GetPeerRankId()),
                                   static_cast<int32_t>(channelPtr_->GetPeerTagId()),
                                   channelPtr_->GetHandle(), &req);
    bqs::ProfileManager::GetInstance(resIndex_).
        AddHcclIsendCost(bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick() - begin);
    if (hcclRet != HCCL_SUCCESS) {
        DGW_LOG_ERROR("Failed to call HcclIsend to send zero data for link establishment, entity:[%s], ret=[%d]",
            entityDesc_.c_str(), hcclRet);
        bqs::StatisticManager::GetInstance().HcclMpiSendFailStat();
        return FsmStatus::FSM_FAILED;
    }
    bqs::StatisticManager::GetInstance().HcclMpiSendSuccStat();

    // cache request
    RequestInfo reqInfo = {.req = req, .isLink = true, .mbuf = nullptr,
                           .startTick = bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick()};
    const int32_t count = uncompReqQueue_.Push(reqInfo);
    if (count == 0) {
        return FsmStatus::FSM_FAILED;
    }
    DGW_LOG_INFO("Success to send zero data for link establishment, entity:[%s].",
        entityDesc_.c_str());
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus ChannelEntity::ProcessCompReq()
{
    RequestInfo * const uncompReq = uncompReqQueue_.Front();
    if (uncompReq == nullptr) {
        DGW_LOG_ERROR("Failed to get front from uncompleted req queue, entity:[%s].", entityDesc_.c_str());
        return FsmStatus::FSM_FAILED;
    }
    const bool isSrc = (direction_ == EntityDirection::DIRECTION_SEND);
    const auto mbuf = uncompReq->mbuf;
    const auto req = uncompReq->req;
    const auto isLink = uncompReq->isLink;
    const auto reqProcTickCost = bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick() - uncompReq->startTick;
    const auto reqProcCost = bqs::ProfileManager::GetInstance(resIndex_).AddReqProcCompCost(reqProcTickCost, isSrc);

    // process link request
    if (isLink) {
        return ProcessLinkRequest(req, reqProcCost);
    }

    // process request of data send/receive
    compReqCount_++;
    if ((reqProcCost > REQ_COMP_TIME_COST_THRESHOLD) && (compReqCount_ > COUNT_THRESHOLD_FOR_PRINT_ERROR)) {
        DGW_LOG_RUN_INFO("Time cost to complete request is %.2fus, count:[%lu], entity:[%s], isSrc[%d].",
            reqProcCost, compReqCount_, entityDesc_.c_str(), static_cast<int32_t>(isSrc));
    }

    statInfo_.hcclTestSomeSuccTimes++;
    // pop request: pop failed, unhandled error
    const int32_t count = uncompReqQueue_.Pop();
    if (count == 0) {
        DGW_LOG_ERROR("Failed to pop request from uncompleted req queue, entity:[%s].", entityDesc_.c_str());
    } else {
        statInfo_.uncompReqQueuePopTimes++;
        DGW_LOG_DEBUG("Success to pop request from uncompleted req queue, entity:[%s].",
            entityDesc_.c_str());
    }
    // no need to process when mbuf is nullptr
    if (mbuf == nullptr) {
        // data
        UpdateStatisticForBody(reqProcTickCost);
        DGW_LOG_DEBUG("Mbuf is nullptr, no need to process!");
        return FsmStatus::FSM_SUCCESS;
    }
    // head
    UpdateStatisticForHead(reqProcTickCost);

    return isSrc ? ProcessReceiveCompletion(mbuf) : ProcessSendCompletion(mbuf);
}

void ChannelEntity::UpdateStatisticForBody(const uint64_t reqProcTickCost)
{
    if (reqProcTickCost > statInfo_.maxCompletionGapTickForBody) {
        statInfo_.maxCompletionGapTickForBody = reqProcTickCost;
    }
    if ((reqProcTickCost < statInfo_.minCompletionGapTickForBody) ||
        statInfo_.totalCompletionCountForBody == 0U) {
        statInfo_.minCompletionGapTickForBody = reqProcTickCost;
    }
    statInfo_.totalCompletionGapTickForBody += reqProcTickCost;
    ++statInfo_.totalCompletionCountForBody;
}

void ChannelEntity::UpdateStatisticForHead(const uint64_t reqProcTickCost)
{
    if (reqProcTickCost > statInfo_.maxCompletionGapTickForHead) {
        statInfo_.maxCompletionGapTickForHead = reqProcTickCost;
    }
    if ((reqProcTickCost < statInfo_.minCompletionGapTickForHead) ||
        (statInfo_.totalCompletionCountForHead == 0U)) {
        statInfo_.minCompletionGapTickForHead = reqProcTickCost;
    }
    statInfo_.totalCompletionGapTickForHead += reqProcTickCost;
    ++statInfo_.totalCompletionCountForHead;
}

RequestInfo *ChannelEntity::FrontUncompReq()
{
    return uncompReqQueue_.Front();
}

bool ChannelEntity::AddCachedReqCount()
{
    cachedReqCountLock.Lock();
    if (ScheduleConfig::GetInstance().IsStopped(schedCfgKey_)) {
        cachedReqCount_ = 0U;
        DGW_LOG_INFO("Entity[%s] modify cachedReqCount to zero for schedule_stopped", entityDesc_.c_str());
        cachedReqCountLock.Unlock();
        return true;
    }

    if (cachedReqCount_ >= maxCachedReqCount_) {
        cachedReqCountLock.Unlock();
        DGW_LOG_INFO("cached req count[%u] for entity[%s] is up to max[%u].",
            cachedReqCount_, entityDesc_.c_str(), maxCachedReqCount_);
        return false;
    }
    ++cachedReqCount_;
    cachedReqCountLock.Unlock();
    DGW_LOG_DEBUG("Success to add cached req count for entity[%s], current count:[%u].",
        entityDesc_.c_str(), cachedReqCount_);
    return true;
}

bool ChannelEntity::ReduceCachedReqCount()
{
    cachedReqCountLock.Lock();
    if (cachedReqCount_ == 0U) {
        cachedReqCountLock.Unlock();
        DGW_LOG_ERROR("Entity[%s] has no cached req!", entityDesc_.c_str());
        return false;
    }
    --cachedReqCount_;
    cachedReqCountLock.Unlock();
    DGW_LOG_DEBUG("Success to reduce cached req count for entity[%s], current count:[%u].",
        entityDesc_.c_str(), cachedReqCount_);
    return true;
}

const CommChannel *ChannelEntity::GetCommChannel() const
{
    return channelPtr_;
}

uint32_t ChannelEntity::GetQueueId() const
{
    return compReqQueueId_;
}

bool ChannelEntity::CheckRecvReqEventContinue()
{
    if (cachedEnvelopeQueue_.IsEmpty()) {
        return false;
    }
    bool flag = false;
    cachedReqCountLock.Lock();
    flag = (cachedReqCount_ != maxCachedReqCount_) ? true : false;
    cachedReqCountLock.Unlock();
    DGW_LOG_DEBUG("Check entity[%s] to supply receive request event, flag:[%d].",
        entityDesc_.c_str(), static_cast<int32_t>(flag));
    return flag;
}

FsmStatus ChannelEntity::ProcessSendCompletion(Mbuf* mbuf)
{
    uint64_t dataLen = 0UL;
    auto drvRet = halMbufGetBuffSize(mbuf, &dataLen);
    if (drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
        DGW_LOG_ERROR("Unhandled error!! Fail to get buff size for mbuf, entity:[%s], ret=[%d]",
            entityDesc_.c_str(), drvRet);
    }

    const uint64_t begin = bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick();
    MbufTypeInfo typeInfo = {};
    uint32_t outLen = sizeof(typeInfo);
    drvRet = halBuffGetInfo(BUFF_GET_MBUF_TYPE_INFO, PtrToPtr<Mbuf*, void>(&mbuf),
        static_cast<uint32_t>(sizeof(mbuf)), PtrToPtr<MbufTypeInfo, void>(&typeInfo), &outLen);
    if ((drvRet == static_cast<int32_t>(DRV_ERROR_NONE)) &&
        (typeInfo.type == static_cast<uint32_t>(MBUF_CREATE_BY_BUILD))) {
        void *buff = nullptr;
        uint64_t len = 0U;
        drvRet = halMbufUnBuild(mbuf, &buff, &len);
        if (drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
            DGW_LOG_ERROR("halMbufUnBuild fail, ret: %d", drvRet);
        } else {
            halBuffPut(nullptr, buff);
            DGW_LOG_INFO("Free head success");
        }
    } else {
        if (drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
            DGW_LOG_ERROR("halBuffGetInfo fail, ret: %d", drvRet);
        }
        (void)halMbufFree(mbuf);
        DGW_LOG_INFO("Free mbuf.");
    }

    bqs::ProfileManager::GetInstance(resIndex_).
        AddMbufFreeCost(bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick() - begin);
    statInfo_.freeMbufTimes++;
    bqs::StatisticManager::GetInstance().MbufFreeStat(dataLen);
    DGW_LOG_INFO("Success to free mbuf for entity[%s] when processing send completion event.",
        entityDesc_.c_str());
    
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus ChannelEntity::ProcessReceiveCompletion(Mbuf * const mbuf)
{
    bqs::ProfInfo reportData = { };
    if (bqs::BqsMsprofManager::GetInstance().IsStartProfling()) {
        reportData.type = static_cast<uint32_t>(bqs::DgwProfInfoType::ENQUEUE_DATA);
        reportData.itemId = transId_;
        reportData.timeStamp = bqs::GetTimeStamp();
    }
    DGW_LOG_INFO("Tag[%u] recv completion", channelPtr_->GetPeerTagId());

    if (ScheduleConfig::GetInstance().IsStopped(schedCfgKey_)) {
        (void)halMbufFree(mbuf);
        DGW_LOG_INFO("Entity[%s] discard mbuf for schedule_stopped", entityDesc_.c_str());
        return FsmStatus::FSM_SUCCESS;
    }
    // recv completion
    const uint64_t begin = bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick();
    const auto drvRet = halQueueEnQueue(deviceId_, compReqQueueId_, PtrToPtr<void, Mbuf>(mbuf));

    DGW_LOG_INFO("%s halQueueEnQueue queue id:[%u] device id:[%u] result:[%d].",
        entityDesc_.c_str(), compReqQueueId_, deviceId_, static_cast<int32_t>(drvRet));
    bqs::BqsMsprofManager::GetInstance().ReportApiPerf(reportData);
    bqs::ProfileManager::GetInstance(resIndex_).
        AddHcclEnqueueCost(bqs::ProfileManager::GetInstance(resIndex_).GetCpuTick() - begin);
    if (drvRet != DRV_ERROR_NONE) {
        statInfo_.hcclEnqueueFailTimes++;
        DGW_LOG_ERROR("Drop mbuf! Failed to enqueue completed req mbuf, entity:[%s], ret:[%d].",
            entityDesc_.c_str(), static_cast<int32_t>(drvRet));
        (void)halMbufFree(mbuf);
        return FsmStatus::FSM_FAILED;
    }
    statInfo_.hcclEnqueueSuccTimes++;
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus ChannelEntity::ProcessLinkRequest(const HcclRequest &req, const float64_t reqProcCost)
{
    (void)req;
    (void)reqProcCost;
    DGW_LOG_RUN_INFO("Time cost to complete link request is %.2fus, entity:[%s], isSrc[%d].",
        reqProcCost, entityDesc_.c_str(), (direction_ == EntityDirection::DIRECTION_SEND));

    // pop request: pop failed, unhandled error
    const int32_t count = uncompReqQueue_.Pop();
    if (count == 0) {
        DGW_LOG_ERROR("Failed to pop link request from uncompleted req queue, entity:[%s].", entityDesc_.c_str());
        return FsmStatus::FSM_FAILED;
    }

    DGW_LOG_INFO("Success to pop link request from uncompleted req queue, entity:[%s].",
        entityDesc_.c_str());

    linkStatus_ = dgw::ChannelLinkStatus::CONNECTED;
    const uint32_t unlinkTagCount = bqs::StatisticManager::GetInstance().ReduceUnlinkCount();
    DGW_LOG_RUN_INFO("Success to establish a link for entity:[%s], current unlink tag count is [%u]",
        entityDesc_.c_str(), unlinkTagCount);
    return FsmStatus::FSM_SUCCESS;
}

void ChannelEntity::Dump() const
{
    const std::string desc = (direction_ == EntityDirection::DIRECTION_SEND) ? "Src" : "Dst";
    const auto maxCompletionGapForBody =
        bqs::ProfileManager::GetInstance(resIndex_).GetTimeCost(statInfo_.maxCompletionGapTickForBody);
    const auto minCompletionGapForBody =
        bqs::ProfileManager::GetInstance(resIndex_).GetTimeCost(statInfo_.minCompletionGapTickForBody);
    const auto avgCompletionGapForBody = (statInfo_.totalCompletionCountForBody == 0U) ? 0.0 :
        bqs::ProfileManager::GetInstance(resIndex_).GetTimeCost(statInfo_.totalCompletionGapTickForBody) /
            statInfo_.totalCompletionCountForBody;
    const auto maxCompletionGapForHead =
        bqs::ProfileManager::GetInstance(resIndex_).GetTimeCost(statInfo_.maxCompletionGapTickForHead);
    const auto minCompletionGapForHead =
        bqs::ProfileManager::GetInstance(resIndex_).GetTimeCost(statInfo_.minCompletionGapTickForHead);
    const auto avgCompletionGapForHead = (statInfo_.totalCompletionCountForHead == 0U) ? 0.0 :
        bqs::ProfileManager::GetInstance(resIndex_).GetTimeCost(statInfo_.totalCompletionGapTickForHead) /
            statInfo_.totalCompletionCountForHead;
    DGW_LOG_RUN_INFO("%s entity statistic info: desc=[%s], HcclImprobe=[succ:%lu, fail:%lu, total:%lu], "
        "alloc mbuf=[%lu], HcclImrecv=[succ:%lu, fail:%lu], HcclTestSome=[succ:%lu], "
        "uncompReqQueue=[push:%lu, pop:%lu], bodyCostUs=[max: %.2f, avg: %.2f, min: %.2f], "
        "headCostUs=[max: %.2f, avg: %.2f, min: %.2f], "
        "HcclIsend=[succ:%lu, full:%lu, fail:%lu], "
        "free mbuf=[%lu], hccl enqueue=[succ:%lu, fail:%lu], dequeue=[succ:%lu, fail:%lu], "
        "cached envelope=[%u], link status=[%d].",
        desc.c_str(), entityDesc_.c_str(), statInfo_.hcclImprobeSuccTimes,
        statInfo_.hcclImprobeFailTimes, statInfo_.hcclImprobeTotalTimes,
        statInfo_.allocMbufTimes, statInfo_.hcclImrecvSuccTimes,
        statInfo_.hcclImrecvFailTimes, statInfo_.hcclTestSomeSuccTimes,
        statInfo_.uncompReqQueuePushTimes, statInfo_.uncompReqQueuePopTimes,
        maxCompletionGapForBody, avgCompletionGapForBody, minCompletionGapForBody,
        maxCompletionGapForHead, avgCompletionGapForHead, minCompletionGapForHead,
        statInfo_.hcclIsendSuccTimes, statInfo_.hcclIsendFullTimes,
        statInfo_.hcclIsendFailTimes, statInfo_.freeMbufTimes,
        statInfo_.hcclEnqueueSuccTimes, statInfo_.hcclEnqueueFailTimes,
        statInfo_.dequeueSuccTimes, statInfo_.dequeueFailTimes, cachedEnvelopeQueue_.Size(), linkStatus_);
}

FsmStatus ChannelEntity::MakeSureOutputCompletion()
{
    DGW_LOG_INFO("Entity[%s] start to wait send completion", entityDesc_.c_str());
    FsmStatus ret = FsmStatus::FSM_SUCCESS;
    uint32_t totalWaitUs = 0U;
    while (!uncompReqQueue_.IsEmpty()) {
        if (totalWaitUs >= CHECK_SEND_COMPLETION_LIMIT_US) {
            DGW_LOG_RUN_INFO("Entity[%s] fail to finish sending in [%u] us", entityDesc_.c_str(),
                CHECK_SEND_COMPLETION_LIMIT_US);
            ret = FsmStatus::FSM_FAILED;
            break;
        }
        usleep(CHECK_SEND_COMPLETION_INTERVAL_US);
        totalWaitUs += CHECK_SEND_COMPLETION_INTERVAL_US;
    }

    DGW_LOG_INFO("Entity[%s] Finish to wait send completion, cost [%u] us, left [%u] requests", entityDesc_.c_str(),
        totalWaitUs, uncompReqQueue_.Size());
    while (!uncompReqQueue_.IsEmpty()) {
        uncompReqQueue_.Pop();
    }
    return ret;
}

void ChannelEntity::PostDeque()
{
    const bool firstRet = ReduceCachedReqCount();
    const bool secondRet = ReduceCachedReqCount();
    if ((!firstRet) || (!secondRet)) {
        DGW_LOG_ERROR("Unhandled error! Reduce cached req count failed! first ret:[%d], second ret:[%d].",
            static_cast<int32_t>(firstRet), static_cast<int32_t>(secondRet));
    }
}

}