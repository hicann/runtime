/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "queue_manager.h"

#include <cstring>
#include <securec.h>
#include "driver/ascend_hal.h"
#include "bqs_msg.h"
#include "subscribe_manager.h"
#include "statistic_manager.h"
#include "server/bqs_server.h"
#include "router_server.h"
#include "common/bqs_util.h"

namespace bqs {
namespace {
constexpr const char_t *RELATION_QUEUE_NAME = "QSRelationEvent";
constexpr const char_t *F2NF_QUEUE_NAME = "QSF2NFEvent";
constexpr const char_t *ASYNC_MEM_BUFF_DEQ_QUEUE_NAME = "QSAsyncMemDeBuffEvent";
constexpr const char_t *ASYNC_MEM_BUFF_ENQ_QUEUE_NAME = "QSAsyncMemEnBuffEvent";
// relation message type enqueue message length
constexpr const uint32_t BIND_EVENT_MSG_LENGTH(1U);
constexpr const uint32_t MAX_QUEUE_DEPTH = 8U * 1024U;
constexpr const uint32_t MAX_DEQUEUE_COUNT = MAX_QUEUE_DEPTH;
constexpr const char_t *RELATION_QUEUE_NAME_EXTRA = "QSRelationEventExtra";
constexpr const char_t *F2NF_QUEUE_NAME_EXTRA = "QSF2NFEventExtra";
}  // namespace

QueueManager::QueueManager()
    : deviceId_(0U),
      groupId_(0U),
      relationEventQId_(0U),
      fullToNotFullEventQId_(0U),
      asyncMemDequeueBuffQId_(0),
      asyncMemEnqueueBuffQId_(0),
      initialized_(false),
      stopped_(false),
      f2nfQueueEmptyFlag_(true),
      mbufForF2nf_(nullptr),
      relationEventQInitialized_(false),
      fullToNotFullEventQInitialized_(false),
      deviceIdExtra_(0U),
      groupIdExtra_(0U),
      relationEventQIdExtra_(0U),
      relationEventQInitializedExtra_(false),
      fullToNotFullEventQIdExtra_(0U),
      fullToNotFullEventQInitializedExtra_(false),
      mbufForF2nfExtra_(nullptr),
      f2nfQueueEmptyFlagExtra_(true),
      isTriggeredByAsyncMemDequeue_(false),
      isTriggeredByAsyncMemEnqueue_(false),
      ayncMemBuffEventQInitialized_(false),
      initiallizedExtra_(false)
{}

QueueManager::~QueueManager()
{
    Clear();
}

QueueManager &QueueManager::GetInstance()
{
    static QueueManager instance;
    return instance;
}

BqsStatus QueueManager::CreateQueue(const char_t * const name, const uint32_t depth, uint32_t &queueId,
    uint32_t deviceId) const
{
    std::string nameStr(name);
    const auto curPid = static_cast<uint32_t>(drvDeviceGetBareTgid());
    nameStr += std::to_string(curPid);
    QueueAttr queAttr = {};
    const auto memcpyRet = memcpy_s(queAttr.name, static_cast<uint32_t>(QUEUE_MAX_STR_LEN),
                                    nameStr.c_str(), nameStr.length());
    if (memcpyRet != EOK) {
        BQS_LOG_ERROR("CreateAndSubscribeQueue memcpy_s failed, ret[%d].", memcpyRet);
        return BQS_STATUS_INNER_ERROR;
    }
    queAttr.depth = depth;
    queAttr.deploy_type = CLIENT_QUEUE_DEPLOY;
    if (bqs::GetRunContext() == bqs::RunContext::HOST) {
        queAttr.deploy_type = LOCAL_QUEUE_DEPLOY;
    }
    BQS_LOG_INFO("CreateAndSubscribeQueue queue depth[%d]", depth);
    const drvError_t ret = halQueueCreate(deviceId, &queAttr, &queueId);
    if (ret != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("Create buff queue[%s] error, ret=%d", nameStr.c_str(), static_cast<int32_t>(ret));
        return BQS_STATUS_DRIVER_ERROR;
    }
    const drvError_t drvRet = halQueueAttach(deviceId, queueId, 0);
    if (drvRet != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("Fail to attach queue[%ud], result[%d]", queueId, static_cast<int32_t>(drvRet));
        (void)DestroyQueue(queueId);
        return BQS_STATUS_DRIVER_ERROR;
    }
    BQS_LOG_RUN_INFO("Create buff queue[%s] on device[%u] success, queue[%u].", nameStr.c_str(), deviceId, queueId);
    return BQS_STATUS_OK;
}

BqsStatus QueueManager::CreateQueue(const char_t * const name, const uint32_t depth, uint32_t &queueId) const
{
    return CreateQueue(name, depth, queueId, deviceId_);
}

BqsStatus QueueManager::CreateAndSubscribeQueue(const char_t * const name,
                                                const uint32_t depth, uint32_t &queueId) const
{
    const BqsStatus ret = CreateQueue(name, depth, queueId);
    if (ret != BQS_STATUS_OK) {
        BQS_LOG_ERROR("Create buff queue[name:%s, depth:%u] failed, ret=%d.",
                      name, depth, static_cast<int32_t>(ret));
        return ret;
    }

    drvError_t drvRet = DRV_ERROR_NONE;
    if (bqs::GetRunContext() != bqs::RunContext::HOST) {
        drvRet = halQueueSubscribe(deviceId_, queueId, groupId_, QUEUE_TYPE_GROUP);
    } else {
        struct QueueSubPara queSubParm;
        queSubParm.eventType = QUEUE_ENQUE_EVENT;
        queSubParm.qid = queueId;
        queSubParm.queType = QUEUE_TYPE_GROUP;
        queSubParm.groupId = groupId_;
        queSubParm.devId = deviceId_;
        queSubParm.flag = 0;
        drvRet = halQueueSubEvent(&queSubParm);
    }

    if (drvRet != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("Subscribe buff queue[name:%s, id:%u] failed, deviceId[%u], groupId[%u], ret=%d.",
            name, queueId, deviceId_, groupId_, static_cast<int32_t>(drvRet));
        (void)DestroyQueue(queueId);
        return BQS_STATUS_DRIVER_ERROR;
    }
    BQS_LOG_INFO("Subscribe buff queue[name:%s, id:%u] success, deviceId[%u], groupId[%u]",
                 name, queueId, deviceId_, groupId_);
    return BQS_STATUS_OK;
}

BqsStatus QueueManager::CreateAndSubscribeQueueExtra(const char_t * const name,
    const uint32_t depth, uint32_t &queueId) const
{
    const BqsStatus ret = CreateQueue(name, depth, queueId, deviceIdExtra_);
    if (ret != BQS_STATUS_OK) {
        BQS_LOG_ERROR("Create buff queue[name:%s, depth:%u] failed, ret=%d.",
                      name, depth, static_cast<int32_t>(ret));
        return ret;
    }

    const drvError_t drvRet = halQueueSubscribe(deviceIdExtra_, queueId, groupIdExtra_, QUEUE_TYPE_GROUP);
    if (drvRet != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("Subscribe buff queue[name:%s, id:%u] failed, deviceId[%u], groupId[%u], ret=%d.",
            name, queueId, deviceIdExtra_, groupIdExtra_, static_cast<int32_t>(drvRet));
        (void)DestroyQueue(queueId, deviceIdExtra_);
        return BQS_STATUS_DRIVER_ERROR;
    }
    BQS_LOG_INFO("Subscribe buff queue[name:%s, id:%u] success, deviceId[%u], groupId[%u].",
                 name, queueId, deviceIdExtra_, groupIdExtra_);
    return BQS_STATUS_OK;
}

BqsStatus QueueManager::DestroyQueue(const uint32_t queueId) const
{
    return DestroyQueue(queueId, deviceId_);
}

BqsStatus QueueManager::DestroyQueue(const uint32_t queueId, uint32_t deviceId) const
{
    const int32_t ret = halQueueDestroy(deviceId, queueId);
    if (ret != static_cast<int32_t>(DRV_ERROR_NONE)) {
        BQS_LOG_ERROR("halQueueDestroy failed, queue id:[%u], ret:[%d]", queueId, ret);
        return BQS_STATUS_DRIVER_ERROR;
    }
    BQS_LOG_RUN_INFO("Destroy queue[%u] on deviceId[%u] success.", queueId, deviceId);
    return BQS_STATUS_OK;
}

BqsStatus QueueManager::UnsubscribeQueue(const uint32_t queueId, const QUEUE_EVENT_TYPE eventType) const
{
    auto status = DRV_ERROR_NONE;
    if (bqs::GetRunContext() != bqs::RunContext::HOST) {
        status = halQueueUnsubscribe(deviceId_, queueId);
    } else {
        struct QueueUnsubPara queUnsubParm;
        queUnsubParm.eventType = eventType;
        queUnsubParm.qid = queueId;
        queUnsubParm.devId = deviceId_;
        status = halQueueUnsubEvent(&queUnsubParm);
    }

    if ((status != DRV_ERROR_NONE) && (status != DRV_ERROR_NOT_EXIST)) {
        BQS_LOG_ERROR("halQueueUnsubscribe queue[%u] failed, ret=%d.", queueId, static_cast<int32_t>(status));
        return BQS_STATUS_DRIVER_ERROR;
    }
    return BQS_STATUS_OK;
}

/**
 * init/create/subscribe buff queue
 * @return BQS_STATUS_OK:success other:failed
 */
BqsStatus QueueManager::InitQueueManager(const uint32_t deviceId, const uint32_t groupId, const bool hasAICPU,
                                         const std::string& groupName)
{
    (void)hasAICPU;
    deviceId_ = deviceId;
    groupId_ = groupId;
    grpName_ = groupName;
    BQS_LOG_INFO("QueueManager init begin, deviceId[%u], groupId[%u], groupName[%s].", deviceId, groupId,
                 grpName_.c_str());

    if (!groupName.empty()) {
        const auto queueInitRet = InitQueue();
        if (queueInitRet != BQS_STATUS_OK) {
            BQS_LOG_ERROR("QueueManager Init failed, deviceId[%u], groupId[%u]", deviceId, groupId);
            return queueInitRet;
        }
    }

    BQS_LOG_INFO("QueueManager init success, deviceId[%u], groupId[%u].", deviceId, groupId);
    return BQS_STATUS_OK;
}


void QueueManager::InitExtra(const uint32_t deviceIdExtra, const uint32_t groupIdExtra)
{
    deviceIdExtra_ = deviceIdExtra;
    groupIdExtra_ = groupIdExtra;
    if (!grpName_.empty()) {
        const auto queueInitRet = InitQueueExtra();
        if (queueInitRet != BQS_STATUS_OK) {
            BQS_LOG_ERROR("QueueManager Init failed, deviceId[%u], groupId[%u]", deviceIdExtra, groupIdExtra);
        }
    }
}

BqsStatus QueueManager::InitQueueExtra()
{
    BQS_LOG_INFO("InitQueueExtra begin, deviceId[%u].", deviceIdExtra_);
    const auto ret = halQueueInit(deviceIdExtra_);
    if ((ret != DRV_ERROR_NONE) && (ret != DRV_ERROR_REPEATED_INIT)) {
        BQS_LOG_ERROR("halQueueInit error, ret=[%d]", static_cast<int32_t>(ret));
        return BQS_STATUS_DRIVER_ERROR;
    }

    BqsStatus bqsRet = CreateAndSubscribeQueueExtra(RELATION_QUEUE_NAME_EXTRA, MAX_QUEUE_DEPTH, relationEventQIdExtra_);
    if (bqsRet != BQS_STATUS_OK) {
        BQS_LOG_ERROR("Create and subscribe relation queue error, ret=[%d]", static_cast<int32_t>(bqsRet));
        return bqsRet;
    }
    relationEventQInitializedExtra_ = true;
    BQS_LOG_INFO("InitQueue[%u] success, deviceId[%u].", relationEventQIdExtra_, deviceIdExtra_);

    bqsRet = CreateAndSubscribeQueueExtra(F2NF_QUEUE_NAME_EXTRA, MAX_QUEUE_DEPTH, fullToNotFullEventQIdExtra_);
    if (bqsRet != BQS_STATUS_OK) {
        BQS_LOG_ERROR("Create and subscribe F2NF queue error, ret=[%d]", static_cast<int32_t>(bqsRet));
        return bqsRet;
    }
    fullToNotFullEventQInitializedExtra_ = true;
    return BQS_STATUS_OK;
}

BqsStatus QueueManager::InitQueue()
{
    BQS_LOG_INFO("InitQueue begin, deviceId[%u].", deviceId_);
    if (bqs::GetRunContext() == bqs::RunContext::HOST) {
        // local need queue set
        QueueSetInputPara inPutParam;
        (void)halQueueSet(deviceId_, QUEUE_ENABLE_LOCAL_QUEUE, &inPutParam);
    }

    const auto ret = halQueueInit(deviceId_);
    if ((ret != DRV_ERROR_NONE) && (ret != DRV_ERROR_REPEATED_INIT)) {
        BQS_LOG_ERROR("halQueueInit error, ret=[%d]", static_cast<int32_t>(ret));
        return BQS_STATUS_DRIVER_ERROR;
    }

    BqsStatus bqsRet = CreateAndSubscribeQueue(RELATION_QUEUE_NAME, MAX_QUEUE_DEPTH, relationEventQId_);
    if (bqsRet != BQS_STATUS_OK) {
        BQS_LOG_ERROR("Create and subscribe relation queue error, ret=[%d]", static_cast<int32_t>(bqsRet));
        return bqsRet;
    }
    relationEventQInitialized_ = true;

    bqsRet = CreateAndSubscribeQueue(F2NF_QUEUE_NAME, MAX_QUEUE_DEPTH, fullToNotFullEventQId_);
    if (bqsRet != BQS_STATUS_OK) {
        BQS_LOG_ERROR("Create and subscribe F2NF queue error, ret=[%d]", static_cast<int32_t>(bqsRet));
        return bqsRet;
    }
    fullToNotFullEventQInitialized_ = true;

    bqsRet = CreateAndSubscribeQueue(ASYNC_MEM_BUFF_DEQ_QUEUE_NAME, MAX_QUEUE_DEPTH, asyncMemDequeueBuffQId_);
    if (bqsRet != BQS_STATUS_OK) {
        BQS_LOG_ERROR("Create and subscribe AsyncMemBuff queue error, ret=[%d]", static_cast<int32_t>(bqsRet));
        return bqsRet;
    }

    bqsRet = CreateAndSubscribeQueue(ASYNC_MEM_BUFF_ENQ_QUEUE_NAME, MAX_QUEUE_DEPTH, asyncMemEnqueueBuffQId_);
    if (bqsRet != BQS_STATUS_OK) {
        BQS_LOG_ERROR("Create and subscribe AsyncMemBuff queue error, ret=[%d]", static_cast<int32_t>(bqsRet));
        return bqsRet;
    }
    ayncMemBuffEventQInitialized_ = true;

    BQS_LOG_INFO("InitQueue success, deviceId[%u]", deviceId_);
    return BQS_STATUS_OK;
}

/**
 * destroy buff queue
 * @return NA
 */
void QueueManager::Destroy()
{
    BQS_LOG_INFO("QueueManager Destroy begin");

    {
        const std::unique_lock<std::mutex> destroyLock(mutex_);
        stopped_ = true;
        cv_.notify_all();
    }

    Clear();
    BQS_LOG_INFO("QueueManager Destroy success");
    return;
}

void QueueManager::Clear()
{
    if (mbufForF2nf_ != nullptr) {
        (void)halMbufFree(mbufForF2nf_);
        mbufForF2nf_ = nullptr;
    }

    if (mbufForF2nfExtra_ != nullptr) {
        (void)halMbufFree(mbufForF2nfExtra_);
        mbufForF2nfExtra_ = nullptr;
    }

    if (relationEventQInitialized_) {
        ClearQueue(relationEventQId_, QUEUE_ENQUE_EVENT);
        relationEventQInitialized_ = false;
    }

    if (relationEventQInitializedExtra_) {
        halQueueUnsubscribe(deviceIdExtra_, relationEventQIdExtra_);
        (void)DestroyQueue(relationEventQIdExtra_, deviceIdExtra_);
        relationEventQInitializedExtra_ = false;
    }

    if (fullToNotFullEventQInitialized_) {
        ClearQueue(fullToNotFullEventQId_, QUEUE_F2NF_EVENT);
        fullToNotFullEventQInitialized_ = false;
    }

    if (fullToNotFullEventQInitializedExtra_) {
        halQueueUnsubscribe(deviceIdExtra_, fullToNotFullEventQIdExtra_);
        (void)DestroyQueue(fullToNotFullEventQIdExtra_, deviceIdExtra_);
        fullToNotFullEventQInitializedExtra_ = false;
    }

    if (ayncMemBuffEventQInitialized_) {
        ClearQueue(asyncMemDequeueBuffQId_, QUEUE_ENQUE_EVENT);
        ClearQueue(asyncMemEnqueueBuffQId_, QUEUE_ENQUE_EVENT);
        ayncMemBuffEventQInitialized_ = false;
    }
}

void QueueManager::ClearQueue(const uint32_t queueId, const QUEUE_EVENT_TYPE eventType) const
{
    (void)UnsubscribeQueue(queueId, eventType);
    (void)DestroyQueue(queueId);
}

/**
 * work thread init success will notify queue manager
 * @return NA
 */
void QueueManager::NotifyInitSuccess(const uint32_t index)
{
    const std::unique_lock<std::mutex> notifyLock(mutex_);
    if (!initialized_ && (index == 0U)) {
        initialized_ = true;
        cv_.notify_all();
        BQS_LOG_INFO("Queue schedule init success.");
    } else if (!initiallizedExtra_ && (index == 1U)) {
        initiallizedExtra_ = true;
        cv_.notify_all();
        BQS_LOG_INFO("Queue schedule extra init success.");
    }
    return;
}

BqsStatus QueueManager::EnqueueRelationEvent()
{
    {
        // wait for work thread halEschedWaitEvent execute
        std::unique_lock<std::mutex> equeueRelationEventLock(mutex_);
        while ((!initialized_) && (!stopped_)) {
            BQS_LOG_INFO("Relation msg enqueue wait for init success.");
            cv_.wait(equeueRelationEventLock);
            std::this_thread::sleep_for(std::chrono::milliseconds(1));
        }

        if (stopped_) {
            BQS_LOG_INFO("Queue manager has been stopped, no need to enqueue relation.");
            return BQS_STATUS_OK;
        }
    }

    return EnqueueRelationEventToQ(deviceId_, relationEventQId_);
}

BqsStatus QueueManager::EnqueueRelationEventExtra()
{
    {
        // wait for work thread halEschedWaitEvent execute
        std::unique_lock<std::mutex> equeueRelationEventLock(mutex_);
        while ((!initiallizedExtra_) && (!stopped_)) {
            BQS_LOG_INFO("Relation msg enqueue wait for init success.");
            cv_.wait(equeueRelationEventLock);
            std::this_thread::sleep_for(std::chrono::milliseconds(1));
        }

        if (stopped_) {
            BQS_LOG_INFO("Queue manager has been stopped, no need to enqueue relation.");
            return BQS_STATUS_OK;
        }
    }
    return EnqueueRelationEventToQ(deviceIdExtra_, relationEventQIdExtra_);
}
/**
 * Enqueue a data to implies that the client sent a message
 * @return BQS_STATUS_OK:success other:failed
 */
BqsStatus QueueManager::EnqueueRelationEventToQ(const uint32_t deviceId, const uint32_t relationEventQ) const
{
    BQS_LOG_INFO("QueueManager EnqueueRelationEvent begin");

    Mbuf *mbufPtr = nullptr;
    int32_t ret = halMbufAlloc(BIND_EVENT_MSG_LENGTH, &mbufPtr);
    if (ret != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("halMbufAlloc error, queue id:[%u], ret=[%d]", relationEventQ, ret);
        return BQS_STATUS_DRIVER_ERROR;
    }

    ret = halQueueEnQueue(deviceId, relationEventQ, mbufPtr);
    if (ret != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("halQueueEnQueue error, queue id:[%u], ret=[%d]", relationEventQ, ret);
        (void)halMbufFree(mbufPtr);
        return BQS_STATUS_DRIVER_ERROR;
    }
    StatisticManager::GetInstance().RelationEnqueueStat();
    BQS_LOG_INFO("QueueManager EnqueueRelationEvent end, queueId[%u] deviceId[%u]", relationEventQ, deviceId);
    return BQS_STATUS_OK;
}

/**
 * handle the bind or unbind msg that the client sent
 * @return true:has handle relation msg, false:not handle
 */
bool QueueManager::HandleRelationEvent(const uint32_t index) const
{
    bool dequeue = false;
    Mbuf *mbufPtr = nullptr;
    int32_t ret = DRV_ERROR_NONE;
    auto deviceId = (index == 0U) ? deviceId_ : deviceIdExtra_;
    auto relationEventQId = (index == 0U) ? relationEventQId_ : relationEventQIdExtra_;
    while (true) {
        ret = halQueueDeQueue(deviceId, relationEventQId, PtrToPtr< Mbuf *, void *>(&mbufPtr));
        if (ret == DRV_ERROR_QUEUE_EMPTY) {
            break;
        }

        BQS_LOG_INFO("HandleRelationEvent dequeue deviceId[%u], relationQ[%u]", deviceId, relationEventQId);
        if (ret != DRV_ERROR_NONE) {
            BQS_LOG_ERROR("halQueueDeQueue error, queue id:[%u], ret=[%d]", relationEventQId, ret);
            break;
        }
        dequeue = true;
        StatisticManager::GetInstance().RelationDequeueStat();

        ret = halMbufFree(mbufPtr);
        if (ret != DRV_ERROR_NONE) {
            BQS_LOG_ERROR("halMbufFree error, queue id:[%u], ret=[%d]", relationEventQId, ret);
        }
    }

    if (dequeue) {
        // pipeline queue id is valid : event mode
        if (RouterServer::GetInstance().GetPipelineQueueId() < MAX_QUEUE_ID_NUM) {
            RouterServer::GetInstance().BindMsgProc(index);
        } else {
            BqsServer::GetInstance().BindMsgProc();
        }
        BQS_LOG_INFO("HandleRelationEvent end.");
    }
    return dequeue;
}

void QueueManager::MakeUpMbuf(Mbuf **mbufPtr) const
{
    // malloc mbuf for f2nf queue
    const size_t mbufLen = sizeof(EntityInfo);
    auto drvRet = halMbufAlloc(mbufLen, mbufPtr);
    if (drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
        BQS_LOG_ERROR("Failed to malloc mbuf, ret=[%d]", drvRet);
        return;
    }
    Mbuf* &mbuf = *mbufPtr;
    drvRet = halMbufSetDataLen(mbuf, mbufLen);
    if (drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
        BQS_LOG_ERROR("Set data len for mbuf failed, dataLen:[%zu], ret=[%d]", mbufLen, drvRet);
        (void)halMbufFree(mbuf);
        mbuf = nullptr;
        return;
    }
}

void QueueManager::MakeUpF2NFMbuf(const uint32_t index)
{
    if (index == 0U) {
        static std::once_flag onceFlag;
        std::call_once(onceFlag, [&]() {
            BQS_LOG_INFO("make up mbufForF2nf_");
            MakeUpMbuf(&mbufForF2nf_);
        });
    } else {
        static std::once_flag onceFlagExtra;
        std::call_once(onceFlagExtra, [&]() {
            BQS_LOG_INFO("make up mbufForF2nfExtra_");
            MakeUpMbuf(&mbufForF2nfExtra_);
        });
    }
}
/**
 * enqueue the queue id of full to not full queue
 * @return BQS_STATUS_OK:success other:failed
 */
BqsStatus QueueManager::EnqueueFullToNotFullEvent(const uint32_t index)
{
    MakeUpF2NFMbuf(index);
    auto &f2nfLock = (index == 0U) ? f2nfLock_ : f2nfLockExtra_;
    auto &mbufForF2nf = (index == 0U) ? mbufForF2nf_ : mbufForF2nfExtra_;
    auto &f2nfQueueEmptyFlag = (index == 0U) ? f2nfQueueEmptyFlag_ : f2nfQueueEmptyFlagExtra_;
    auto &deviceId = (index == 0U) ? deviceId_ : deviceIdExtra_;
    auto &fullToNotFullEventQId = (index == 0U) ? fullToNotFullEventQId_ : fullToNotFullEventQIdExtra_;

    if (mbufForF2nf == nullptr) {
        BQS_LOG_ERROR("Failed to malloc mbuf for f2nf event, index is %u.", index);
        return BqsStatus::BQS_STATUS_INNER_ERROR;
    }

    f2nfLock.Lock();
    if (!f2nfQueueEmptyFlag.load()) {
        DGW_LOG_DEBUG("EnqueueFullToNotFullEvent f2NfQueueEmptyFlag is false, index is %u.", index);
        f2nfLock.Unlock();
        return BqsStatus::BQS_STATUS_OK;
    }
    BQS_LOG_INFO("Begin to enqueue f2nf event, index is %u.", index);
    // In order to prevent event from being dropped, first store f2nFQueueEmptyFlag to false, then enqueue
    f2nfQueueEmptyFlag.store(false);
    const auto ret = halQueueEnQueue(deviceId, fullToNotFullEventQId, mbufForF2nf);
    if (ret != DRV_ERROR_NONE) {
        // reset f2nfQueueEmptyFlag, perhaps events were dropped because enqueue failed
        f2nfQueueEmptyFlag.store(true);
        BQS_LOG_ERROR("halQueueEnQueue error, ret=[%d], index is %u.", ret, index);
        f2nfLock.Unlock();
        return BqsStatus::BQS_STATUS_DRIVER_ERROR;
    }
    f2nfLock.Unlock();
    StatisticManager::GetInstance().F2nfEnqueueStat();
    BQS_LOG_INFO("Finish to enqueue f2nf event, index is %u,", index);
    return BqsStatus::BQS_STATUS_OK;
}

/**
 * handle the event of full to not full
 * @return true:has handle f2nf msg, false:not handle
 */
bool QueueManager::HandleFullToNotFullEvent(const uint32_t index)
{
    uint32_t dequeueCount = 0U;
    auto &f2nfLock = (index == 0U) ? f2nfLock_ : f2nfLockExtra_;
    auto &mbufForF2nf = (index == 0U) ? mbufForF2nf_ : mbufForF2nfExtra_;
    auto &f2nfQueueEmptyFlag = (index == 0U) ? f2nfQueueEmptyFlag_ : f2nfQueueEmptyFlagExtra_;
    auto &deviceId = (index == 0U) ? deviceId_ : deviceIdExtra_;
    auto &fullToNotFullEventQId = (index == 0U) ? fullToNotFullEventQId_ : fullToNotFullEventQIdExtra_;

    f2nfLock.Lock();
    while (dequeueCount <= MAX_DEQUEUE_COUNT) {
        void *dequeuedMbuf = nullptr;
        const int32_t ret = halQueueDeQueue(deviceId, fullToNotFullEventQId, &dequeuedMbuf);
        if (ret == DRV_ERROR_QUEUE_EMPTY) {
            break;
        }
        if (ret != DRV_ERROR_NONE) {
            BQS_LOG_ERROR("halQueueDeQueue error, queue id:[%u], ret=[%d]", fullToNotFullEventQId, ret);
            f2nfLock.Unlock();
            return false;
        }
        mbufForF2nf = PtrToPtr<void, Mbuf>(dequeuedMbuf);
        StatisticManager::GetInstance().F2nfDequeueStat();
        // mbuf for f2nf event will be freed when destroy queue manager
        dequeueCount++;
    }
    f2nfQueueEmptyFlag.store(true);
    f2nfLock.Unlock();
    return (dequeueCount > 0U);
}

/**
 * Enqueue a data to implies that the clientQ sent a message
 * @return BQS_STATUS_OK:success other:failed
 */
BqsStatus QueueManager::EnqueueAsynMemBuffEvent()
{
    // avoid parallel halEnQueue
    std::lock_guard<std::mutex> lock(mutex_);
    Mbuf *mbufPtr = nullptr;
    int32_t ret = halMbufAlloc(BIND_EVENT_MSG_LENGTH, &mbufPtr);
    if (ret != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("halMbufAlloc error, queue id:[%u]/[%u], ret=[%d]",
                      asyncMemDequeueBuffQId_, asyncMemEnqueueBuffQId_, ret);
        return BQS_STATUS_DRIVER_ERROR;
    }

    uint32_t asyncMemBuffQId = 0;
    if (isTriggeredByAsyncMemDequeue_) {
        asyncMemBuffQId = asyncMemDequeueBuffQId_;
        ret = halQueueEnQueue(deviceId_, asyncMemDequeueBuffQId_, mbufPtr);
    } else if (isTriggeredByAsyncMemEnqueue_) {
        asyncMemBuffQId = asyncMemEnqueueBuffQId_;
        ret = halQueueEnQueue(deviceId_, asyncMemEnqueueBuffQId_, mbufPtr);
    } else {
        ;
    }

    if (ret != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("halQueueEnQueue error, queue id:[%u], ret=[%d]", asyncMemBuffQId, ret);
        (void)halMbufFree(mbufPtr);
        return BQS_STATUS_DRIVER_ERROR;
    }
    StatisticManager::GetInstance().AsynMemEnqueueStat();
    return BQS_STATUS_OK;
}

/**
 * handle the event of Aysn mem buffer
 * @return true:has handle Aysn mem buffer msg, false:not handle
 */
bool QueueManager::HandleAsynMemBuffEvent(const uint32_t index)
{
    (void)index;
    Mbuf *mbufPtr = nullptr;
    int32_t ret = DRV_ERROR_RESERVED;
    bool isTriggered = false;
    while (true) {
        uint32_t asyncMemBuffQId = 0;
        if (isTriggeredByAsyncMemDequeue_) {
            isTriggered = true;
            asyncMemBuffQId = asyncMemDequeueBuffQId_;
            ret = halQueueDeQueue(deviceId_, asyncMemDequeueBuffQId_, PtrToPtr<Mbuf *, void *>(&mbufPtr));
        }

        if (isTriggeredByAsyncMemEnqueue_) {
            isTriggered = true;
            asyncMemBuffQId = asyncMemEnqueueBuffQId_;
            ret = halQueueDeQueue(deviceId_, asyncMemEnqueueBuffQId_, PtrToPtr<Mbuf *, void *>(&mbufPtr));
        }

        if (ret == DRV_ERROR_QUEUE_EMPTY || ret == DRV_ERROR_RESERVED) {
            if (isTriggeredByAsyncMemDequeue_) {
                isTriggeredByAsyncMemDequeue_ = false;
            }
            if (isTriggeredByAsyncMemEnqueue_) {
                isTriggeredByAsyncMemEnqueue_ = false;
            }
            break;
        }

        if (ret != DRV_ERROR_NONE) {
            BQS_LOG_ERROR("halQueueDeQueue error, queue id:[%u], ret=[%d]", asyncMemBuffQId, ret);
            break;
        }

        if (isTriggered) {
            StatisticManager::GetInstance().AsynMemDequeueStat();
            ret = halMbufFree(mbufPtr);
            if (ret != DRV_ERROR_NONE) {
                BQS_LOG_ERROR("halMbufFree error, queue id:[%u], ret=[%d]", asyncMemBuffQId, ret);
            }
        }
    }
    return true;
}

void QueueManager::LogErrorRelationQueueStatus() const
{
    LogErrorQueueStatus(relationEventQId_);
}

void QueueManager::LogErrorQueueStatus(const uint32_t queueId) const
{
    QueueInfo queueInfoObj;
    auto ret = halQueueQueryInfo(deviceId_, queueId, &queueInfoObj);
    if (ret == DRV_ERROR_NONE) {
        BQS_LOG_ERROR("halQueueQueryInfo get queue info, deviceId_:%u, "
                      "queueId:%u, size:%d, depth:%d, status:%d, workMode:%d, "
                      "type:%d, subGroupId:%d,subPid:%d, subF2NFGroupId:%d, "
                      "subF2NFPid:%d, enqueCnt:%llu, dequeCnt:%llu, "
                      "enqueFailCnt:%llu, dequeFailCnt:%llu, enqueEventOk:%llu, "
                      "enqueEventFail:%llu, f2nfEventOk:%llu, f2nfEventFail:%llu, "
                      "lastEnqueTime.tv_sec:%ld, lastEnqueTime.tv_usec:%ld, "
                      "lastDequeTime.tv_sec:%ld, lastDequeTime.tv_usec:%ld.",
            deviceId_, queueInfoObj.id, queueInfoObj.size, queueInfoObj.depth,
            queueInfoObj.status, queueInfoObj.workMode, queueInfoObj.type,
            queueInfoObj.subGroupId, queueInfoObj.subPid, queueInfoObj.subF2NFGroupId,
            queueInfoObj.subF2NFPid, queueInfoObj.stat.enqueCnt,
            queueInfoObj.stat.dequeCnt, queueInfoObj.stat.enqueFailCnt,
            queueInfoObj.stat.dequeFailCnt, queueInfoObj.stat.enqueEventOk,
            queueInfoObj.stat.enqueEventFail, queueInfoObj.stat.f2nfEventOk,
            queueInfoObj.stat.f2nfEventFail, queueInfoObj.stat.lastEnqueTime.tv_sec,
            queueInfoObj.stat.lastEnqueTime.tv_usec, queueInfoObj.stat.lastDequeTime.tv_sec,
            queueInfoObj.stat.lastDequeTime.tv_usec);
    } else {
        BQS_LOG_ERROR("halQueueQueryInfo error, deviceId_:[%u], queueId:[%u], ret:[%d]", deviceId_, queueId, ret);
    }

    int32_t status = QUEUE_NORMAL;
    ret = halQueueGetStatus(deviceId_, queueId, QUERY_QUEUE_STATUS, static_cast<uint32_t>(sizeof(uint32_t)), &status);
    if (ret == DRV_ERROR_NONE) {
        BQS_LOG_DEBUG("halQueueGetStatus succ, queueId:[%u] status:[%d].", queueId, status);
    } else {
        BQS_LOG_ERROR("halQueueGetStatus failed, queueId:[%u], ret:[%d].", queueId, ret);
    }
}
}  // namespace bqs
