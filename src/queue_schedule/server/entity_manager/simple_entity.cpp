/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "simple_entity.h"
#include "bqs_util.h"
#include "dgw_client.h"
#include "profile_manager.h"
namespace dgw {

namespace {
    constexpr uint32_t FLAG_DEVICEID_OFFSET = 32U;
    constexpr uint32_t MBUF_ALLOC_ALIGN = 64U;
}

SimpleEntity::SimpleEntity(const EntityMaterial &material, const uint32_t resIndex)
    : Entity(material, resIndex)
{
}

FsmStatus SimpleEntity::Dequeue()
{
    const auto dequeAllow = AllowDeque();
    if (dequeAllow != FsmStatus::FSM_SUCCESS) {
        return dequeAllow;
    }

    bqs::ProfileManager::GetInstance(resIndex_).AddDequeueNum();
    FsmStatus dequeRet = DoDequeue();
    if (dequeRet == FsmStatus::FSM_KEEP_STATE) {
        return dequeRet;
    }
    if (dequeRet == FsmStatus::FSM_SRC_EMPTY) {
        statInfo_.dequeueEmptyTimes++;
        DGW_LOG_DEBUG("QueueId[%u] on device[%u] has been dequeued to empty.", GetQueueId(), deviceId_);
        return FsmStatus::FSM_FAILED;
    }
    if (dequeRet != FsmStatus::FSM_SUCCESS) {
        statInfo_.dequeueFailTimes++;
        bqs::StatisticManager::GetInstance().DataScheduleFailedStat();
        return dequeRet;
    }

    DGW_LOG_INFO("Success to dequeue mbuf for entity[%s] in peek state.", entityDesc_.c_str());
    bqs::StatisticManager::GetInstance().DataDequeueStat();
    statInfo_.dequeueSuccTimes++;
    // PostDoDeque
    PostDeque();

    // save wait_scheduled mbuf to entity
    const auto refreshRet = RefreshWithData();
    if (refreshRet != FsmStatus::FSM_SUCCESS) {
        (void)halMbufFree(mbuf_);
        mbuf_ = nullptr;
        return refreshRet;
    }
    AddScheduleCount();
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus SimpleEntity::DoDequeue()
{
    return DoDequeueMbuf(PtrToPtr<Mbuf *, void*>(&mbuf_));
}

FsmStatus SimpleEntity::DoDequeueMbuf(void **mbufPtr) const
{
    const uint32_t queueId = GetQueueId();
    const auto ret = halQueueDeQueue(deviceId_, queueId, mbufPtr);
    if (ret == DRV_ERROR_QUEUE_EMPTY) {
        DGW_LOG_DEBUG("QueueId[%u] on device[%u] has been dequeued to empty.", queueId, deviceId_);
        return FsmStatus::FSM_SRC_EMPTY;
    }
    if ((ret != DRV_ERROR_NONE) || (*mbufPtr == nullptr)) {
        DGW_LOG_ERROR("DeQueue from queueId[%u] on device[%u] failed, ret:[%d]",
            queueId, deviceId_, static_cast<int32_t>(ret));
        if (ret == DRV_ERROR_NOT_EXIST) {
            return FsmStatus::FSM_ERROR_PENDING;
        }
        return FsmStatus::FSM_FAILED;
    }
    return FsmStatus::FSM_SUCCESS;
}

void SimpleEntity::PostDeque()
{
    return;
}

FsmStatus SimpleEntity::RefreshWithData()
{
    if (!needTransId_) {
        return FsmStatus::FSM_SUCCESS;
    }

    // src entity is group entity or dst entities has group entity
    // get transId
    void *headBuf = nullptr;
    uint32_t headBufSize = 0U;
    const auto drvRet = halMbufGetPrivInfo(mbuf_, &headBuf, &headBufSize);
    if (drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
        DGW_LOG_ERROR("halMbufGetPrivInfo from mbuf in entity[%s] failed.", entityDesc_.c_str());
        return FsmStatus::FSM_FAILED;
    }
    if (headBufSize < MBUF_HEAD_MAX_SIZE) {
        DGW_LOG_ERROR("mbuf head size:%u in entity[%s] is invalid.", headBufSize, entityDesc_.c_str());
        return FsmStatus::FSM_FAILED;
    }

    const uint32_t offset = headBufSize - static_cast<uint32_t>(sizeof(bqs::IdentifyInfo));
    bqs::IdentifyInfo * const info = PtrToPtr<void, bqs::IdentifyInfo>(ValueToPtr(PtrToValue(headBuf) + offset));
    transId_ = info->transId;
    routeLabel_ = info->routeLabel;
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus SimpleEntity::ResetSrcState()
{
    return ChangeState(FsmState::FSM_IDLE_STATE);
}

void SimpleEntity::SelectDstEntities(const uint64_t key, std::vector<Entity*> &toPushDstEntities,
    std::vector<Entity*> &reprocessDstEntities, std::vector<Entity*> &abnormalDstEntities)
{
    (void)key;
    (void)reprocessDstEntities;
    (void)abnormalDstEntities;
    toPushDstEntities.emplace_back(this);
}

FsmStatus SimpleEntity::SendData(const DataObjPtr dataObj)
{
    Mbuf *const mbufToPush = PrepareMbufToPush(dataObj);
    if (mbufToPush == nullptr) {
        return FsmStatus::FSM_FAILED;
    }
    const auto sendRet = DoSendData(mbufToPush);
    if (sendRet == FsmStatus::FSM_SUCCESS) {
        statInfo_.enqueueSuccTimes++;
    } else if (sendRet != FsmStatus::FSM_KEEP_STATE) {
        Mbuf * const mbuf = const_cast<Mbuf *>(dataObj->GetMbuf());
        if (mbufToPush != mbuf) {
            (void)halMbufFree(mbufToPush);
        }
    }
    return sendRet;
}

Mbuf *SimpleEntity::PrepareMbufToPush(DataObjPtr dataObj) const
{
    Entity *const sendEntity = dataObj->GetSendEntity();
    Mbuf * const mbuf = const_cast<Mbuf *>(dataObj->GetMbuf());

    if ((sendEntity->GetMbufQueueType() != bqs::CLIENT_Q) && (GetDeviceId() != sendEntity->GetMbufDeviceId())) {
        return SdmaCopy(mbuf);
    }
    if (dataObj->GetRecvEntitySize() > 1U) {
        Mbuf *copyMbuf = nullptr;
        auto &profileInstance = bqs::ProfileManager::GetInstance(resIndex_);
        const uint64_t copyBegin = profileInstance.GetCpuTick();
        const int32_t drvRet = halMbufCopyRef(mbuf, &copyMbuf);
        profileInstance.AddCopyTotalCost(profileInstance.GetCpuTick() - copyBegin);
        if ((drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) || (copyMbuf == nullptr)) {
            BQS_LOG_RUN_WARN("MbufCopy failed when from queue[%u] to queue[%u] in device[%u], error=[%d].",
                sendEntity->GetId(), GetId(), GetDeviceId(), drvRet);
            bqs::StatisticManager::GetInstance().DataScheduleFailedStat();
        }
        return copyMbuf;
    }

    dataObj->MaintainMbuf();
    return mbuf;
}

FsmStatus SimpleEntity::DoSendData(Mbuf *const mbuf)
{
    const auto ret = halQueueEnQueue(deviceId_, id_, mbuf);
    DGW_LOG_INFO("%s halQueueEnQueue queue id:[%u] device id:[%u] result:[%d].",
        entityDesc_.c_str(), id_, deviceId_, static_cast<int32_t>(ret));
    if (ret == DRV_ERROR_NONE) {
        bqs::StatisticManager::GetInstance().DataQueueEnqueueSuccStat();
        return FsmStatus::FSM_SUCCESS;
    }

    if (ret == DRV_ERROR_QUEUE_FULL) {
        bqs::StatisticManager::GetInstance().DataQueueEnqueueFullStat();
        DGW_LOG_INFO("[%s] halQueueEnQueue queue id:[%u] FULL!!!!.", GetTypeDesc().c_str(), id_);
        return FsmStatus::FSM_DEST_FULL;
    }

    bqs::StatisticManager::GetInstance().DataQueueEnqueueFailStat();
    DGW_LOG_ERROR("[%s] halQueueEnQueue queue id:[%u] FAILED!!!!.", GetTypeDesc().c_str(), id_);
    if (ret == DRV_ERROR_NOT_EXIST) {
        return FsmStatus::FSM_ERROR_PENDING;
    }
    return FsmStatus::FSM_FAILED;
}

Mbuf* SimpleEntity::SdmaCopy(Mbuf * const mbuf) const
{
    // 调用sdma拷贝
    uint64_t desBufLen = 0;
    auto retHal = halMbufGetDataLen(mbuf, &desBufLen);
    if (retHal != static_cast<int32_t>(DRV_ERROR_NONE)) {
        BQS_LOG_ERROR("halMbufGetDataLen error ret=[%d]", retHal);
        return nullptr;
    }
    void *srcDataBuf = nullptr;
    auto drvRet = halMbufGetBuffAddr(mbuf, &srcDataBuf);
    if ((drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) || (srcDataBuf == nullptr)) {
        DGW_LOG_ERROR("Fail to get buff addr for mbuf, ret=[%d]", drvRet);
        return nullptr;
    }
    void *srcHeadBuf = nullptr;
    uint32_t srcHeadBufSize = 0U;
    drvRet = halMbufGetPrivInfo(mbuf, &srcHeadBuf, &srcHeadBufSize);
    if (drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
        DGW_LOG_ERROR("halMbufGetPrivInfo fail, ret=[%d]", drvRet);
        return nullptr;
    }

    Mbuf *mbufPtr = AllocateMbuf(desBufLen);
    if (mbufPtr == nullptr) {
        BQS_LOG_ERROR("Allocate Mbuf fail.");
        return nullptr;
    }

    if (SdmaCopyData(srcDataBuf, desBufLen, mbufPtr) != FsmStatus::FSM_SUCCESS) {
        BQS_LOG_ERROR("Sdma copy data fail.");
        (void)halMbufFree(mbufPtr);
        return nullptr;
    }

    if (SdmaCopyHead(srcHeadBuf, srcHeadBufSize, mbufPtr) != FsmStatus::FSM_SUCCESS) {
        BQS_LOG_ERROR("Sdma copy head fail.");
        (void)halMbufFree(mbufPtr);
        return nullptr;
    }

    BQS_LOG_INFO("Success to sdma copy.");
    return mbufPtr;
}

Mbuf* SimpleEntity::AllocateMbuf(const uint64_t desBufLen) const
{
    uint64_t flag = (static_cast<uint64_t>(deviceId_) << FLAG_DEVICEID_OFFSET) |
        static_cast<uint64_t>(BUFF_SP_NORMAL);
    int32_t memGroupId = 0;
    Mbuf *mbufPtr = nullptr;
    // alignSize use 64
    auto drvRet = halMbufAllocEx(desBufLen, MBUF_ALLOC_ALIGN, flag, memGroupId, &mbufPtr);
    if ((drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) || mbufPtr == nullptr) {
        BQS_LOG_ERROR("halMbufAllocEx failed, drvRet=%d, dataSize=%lu, flag=%lu, groupId=%d.", drvRet, desBufLen,
            flag, memGroupId);
        return nullptr;
    }
    drvRet = halMbufSetDataLen(mbufPtr, desBufLen);
    if (drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
        BQS_LOG_ERROR("halMbufSetDataLen failed, ret=%d.", drvRet);
        (void)halMbufFree(mbufPtr);
        return nullptr;
    }
    return mbufPtr;
}

FsmStatus SimpleEntity::SdmaCopyData(void *const srcDataBuf, const uint64_t desBufLen, Mbuf *const mbufPtr) const
{
    void *dstDataBuf = nullptr;
    auto drvRet = halMbufGetBuffAddr(mbufPtr, &dstDataBuf);
    if ((drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) || (dstDataBuf == nullptr)) {
        DGW_LOG_ERROR("Fail to get buff addr for mbuf, ret=[%d].", drvRet);
        return FsmStatus::FSM_FAILED;
    }
    drvRet = halSdmaCopy(PtrToValue(dstDataBuf), desBufLen, PtrToValue(srcDataBuf), desBufLen);
    if (drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
        DGW_LOG_ERROR("halSdmaCopy error ret:%d.", drvRet);
        return FsmStatus::FSM_FAILED;
    }
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus SimpleEntity::SdmaCopyHead(void *const srcHeadBuf, const uint32_t srcHeadBufSize, Mbuf *const mbufPtr) const
{
    void *dstHeadBuf = nullptr;
    uint32_t dstHeadBufSize = 0U;
    auto drvRet = halMbufGetPrivInfo(mbufPtr, &dstHeadBuf, &dstHeadBufSize);
    if (drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
        DGW_LOG_ERROR("halMbufGetPrivInfo fail, ret=[%d]", drvRet);
        return FsmStatus::FSM_FAILED;
    }
    if ((srcHeadBuf == nullptr) || (dstHeadBuf == nullptr) || (dstHeadBufSize < srcHeadBufSize)) {
        DGW_LOG_ERROR("dstHeadBufSize[%u] vs srcHeadBufSize[%u]", dstHeadBufSize, srcHeadBufSize);
        return FsmStatus::FSM_FAILED;
    }
    drvRet = halSdmaCopy(PtrToValue(dstHeadBuf), dstHeadBufSize, PtrToValue(srcHeadBuf), srcHeadBufSize);
    if (drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
        DGW_LOG_ERROR("halSdmaCopy error ret:%d", drvRet);
        return FsmStatus::FSM_FAILED;
    }
    return FsmStatus::FSM_SUCCESS;
}

bqs::SubscribeManager *SimpleEntity::GetSubscriber() const
{
    bqs::SubscribeManager * const subscribeManager =
        bqs::Subscribers::GetInstance().GetSubscribeManager(resIndex_, deviceId_);
    if (subscribeManager == nullptr) {
        DGW_LOG_ERROR("Failed to find subscribeManager for resIndex: %u, device: %u, queueType: %d",
            resIndex_, deviceId_, static_cast<int32_t>(queueType_));
    }
    return subscribeManager;
}

FsmStatus SimpleEntity::PauseSubscribe(const Entity &fullEntity)
{
    if (subscribeStatus_ == SubscribeStatus::SUBSCRIBE_PAUSE) {
        DGW_LOG_WARN("No need to pause subscribe for entity[%s].", entityDesc_.c_str());
        return FsmStatus::FSM_SUCCESS;
    }
    DGW_LOG_INFO("[FSM] Pause subscribe src entity[%s] because dst entity[id:%u, type:%s] full.",
        entityDesc_.c_str(), fullEntity.GetId(), fullEntity.GetTypeDesc().c_str());
    subscribeStatus_ = SubscribeStatus::SUBSCRIBE_PAUSE;

    const auto subscriber = GetSubscriber();
    if (subscriber == nullptr) {
        return FsmStatus::FSM_FAILED;
    }
    subscriber->PauseSubscribe(GetQueueId(), fullEntity.GetId(), false);
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus SimpleEntity::ResumeSubscribe(const Entity &notFullEntity)
{
    if (subscribeStatus_ == SubscribeStatus::SUBSCRIBE_RESUME) {
        DGW_LOG_WARN("No need to resume subscribe for entity[%s].", entityDesc_.c_str());
        return FsmStatus::FSM_SUCCESS;
    }
    DGW_LOG_INFO("[FSM] Resume subscribe src entity[%s] because dst entity[id:%u, type:%s] not full.",
        entityDesc_.c_str(), notFullEntity.GetId(), notFullEntity.GetTypeDesc().c_str());
    subscribeStatus_ = SubscribeStatus::SUBSCRIBE_RESUME;
    const auto subscriber = GetSubscriber();
    if (subscriber == nullptr) {
        return FsmStatus::FSM_FAILED;
    }
    subscriber->ResumeSubscribe(GetQueueId(), notFullEntity.GetId());
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus SimpleEntity::ClearQueue()
{
    DGW_LOG_INFO("Entity[%s] clear queue", entityDesc_.c_str());
    do {
        void *mbuf = nullptr;
        const auto dequeRet = DoDequeueMbuf(&mbuf);
        if (dequeRet == FsmStatus::FSM_SRC_EMPTY) {
            break;
        }

        if ((dequeRet != FsmStatus::FSM_SUCCESS) || (mbuf == nullptr)) {
            DGW_LOG_ERROR("DeQueue from queueId[%u] in device[%u] failed, ret:[%d]",
                GetQueueId(), deviceId_, static_cast<int32_t>(dequeRet));
            return FsmStatus::FSM_FAILED;
        }
        (void) halMbufFree(PtrToPtr<void, Mbuf>(mbuf));
    } while (true);

    for (auto sendDataObj : sendDataObjs_) {
        for (auto recvEntity : sendDataObj->GetRecvEntities()) {
            auto &recvObjs = recvEntity->GetRecvDataObjs();
            for (auto iter = recvObjs.begin(); iter != recvObjs.end();) {
                if (Equal((*iter)->GetSendEntity())) {
                    auto tempIter = iter;
                    iter++;
                    recvObjs.erase(tempIter);
                } else {
                    iter++;
                }
            }
        }
    }
    sendDataObjs_.clear();
    DGW_LOG_INFO("Entity[%s] clear queue finish", entityDesc_.c_str());
    return FsmStatus::FSM_SUCCESS;
}

bool SimpleEntity::IsDataPeeked() const
{
    return (curState_ == FsmState::FSM_PEEK_STATE);
}

FsmStatus SimpleEntity::Uninit()
{
    DGW_LOG_RUN_INFO("[%s] has dequeued[%lu], enqueued[%lu].", entityDesc_.c_str(), statInfo_.dequeueSuccTimes,
        statInfo_.enqueueSuccTimes);
    return FsmStatus::FSM_SUCCESS;
}

}