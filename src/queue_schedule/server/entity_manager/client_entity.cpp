/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "client_entity.h"

#include <thread>

#include "entity_manager.h"
#include "queue_manager.h"

namespace dgw {

ClientEntity::ClientEntity(const EntityMaterial &material, const uint32_t resIndex)
    : SimpleEntity(material, resIndex), asyncDataState_(AsyncDataState::FSM_ASYNC_DATA_INIT)
{
    (void)entityDesc_.append(", data state:").append(std::to_string(static_cast<int32_t>(asyncDataState_)));
}

FsmStatus ClientEntity::DoDequeue()
{
    if (asyncDataState_ == AsyncDataState::FSM_ASYNC_DATA_WAIT) {
        return FsmStatus::FSM_KEEP_STATE;
    }
    if (asyncDataState_ == AsyncDataState::FSM_ASYNC_DATA_SENT) {
        asyncDataState_ = AsyncDataState::FSM_ASYNC_ENTITY_DONE;
        return FsmStatus::FSM_SUCCESS;
    }

    asyncDataState_ = AsyncDataState::FSM_ASYNC_DATA_WAIT;
    try {
        InvokeDequeThread();
    } catch(std::exception &e) {
        DGW_LOG_ERROR("create async mem buff thread object failed, %s", e.what());
        asyncDataState_ = AsyncDataState::FSM_ASYNC_DATA_INIT;
        return FsmStatus::FSM_FAILED;
    }
    return FsmStatus::FSM_KEEP_STATE;
}

void ClientEntity::InvokeDequeThread()
{
    std::thread th(&ClientEntity::DoClientDequeue, this);
    th.detach();
}

void ClientEntity::DoClientDequeue()
{
    if(DoDequeueMbuf(PtrToPtr<Mbuf *, void*>(&mbuf_)) != FsmStatus::FSM_SUCCESS) {
        asyncDataState_ = AsyncDataState::FSM_ASYNC_DATA_INIT;
        return;
    }

    asyncDataState_ = AsyncDataState::FSM_ASYNC_DATA_SENT;
    // enable AsyncMemDequeue Queue flag
    bqs::QueueManager::GetInstance().enableAsyncMemDequeueFlag();
    const auto bqsRet = bqs::QueueManager::GetInstance().EnqueueAsynMemBuffEvent();
    if (bqsRet != bqs::BQS_STATUS_OK) {
        DGW_LOG_ERROR("failed to EnqueueAsynMemBuffEvent for entity[%s], ret[%d].", entityDesc_.c_str(),
            static_cast<int32_t>(bqsRet));
    }
}

FsmStatus ClientEntity::DoDequeueMbuf(void **mbufPtr) const
{
    DGW_LOG_INFO("Entity[%s] Start AsyncMemBuffDeQueueEvent", entityDesc_.c_str());
    const uint32_t deviceId = GetDeviceId();
    const uint32_t queueId = GetQueueId();

    // q empty idle
    int32_t srcStatus = static_cast<int32_t>(QUEUE_NORMAL);
    auto ret = halQueueGetStatus(deviceId, queueId, QUERY_QUEUE_STATUS,
                                 static_cast<uint32_t>(sizeof(uint32_t)), &srcStatus);
    if (ret != DRV_ERROR_NONE) {
        DGW_LOG_WARN("queue[%u] on device[%u] halQueueGetStatus ret=%d", queueId, deviceId, static_cast<int32_t>(ret));
        return (ret == DRV_ERROR_NOT_EXIST) ? FsmStatus::FSM_ERROR_PENDING : FsmStatus::FSM_FAILED;
    }
    if (srcStatus == static_cast<int32_t>(QUEUE_EMPTY)) {
        DGW_LOG_DEBUG("Entity[%s] has been dequeued to empty", entityDesc_.c_str());
        return FsmStatus::FSM_SRC_EMPTY;
    }

    DGW_LOG_INFO("Entity[%s] Begin halQueuePeek", entityDesc_.c_str());
    // get mbuf data
    uint64_t deqLen = 0U;
    ret = halQueuePeek(deviceId, queueId, &deqLen, -1);
    if ((ret != DRV_ERROR_NONE) || (deqLen == 0U)) {
        DGW_LOG_ERROR("halQueuePeek from queue[%u] in device[%u] failed, ret[%d], deqLen[%u]",
            queueId, deviceId, static_cast<int32_t>(ret), deqLen);
        return (ret == DRV_ERROR_NOT_EXIST) ? FsmStatus::FSM_ERROR_PENDING : FsmStatus::FSM_FAILED;
    }
    DGW_LOG_INFO("Entity[%s] Finish halQueuePeek", entityDesc_.c_str());

    // alloc mbuf
    Mbuf *mbuf = nullptr;
    int32_t retCode = halMbufAlloc(deqLen, &mbuf);
    if ((retCode != DRV_ERROR_NONE) || (mbuf == nullptr)) {
        DGW_LOG_ERROR("halMbufAlloc fail for entity[%s], size[%zu], ret=[%d].", entityDesc_.c_str(), deqLen, retCode);
        return FsmStatus::FSM_FAILED;
    }

    const auto dequeRet = FillMbufWithDeque(deqLen, mbuf);
    if (dequeRet != FsmStatus::FSM_SUCCESS) {
        (void)halMbufFree(mbuf);
        return dequeRet;
    }
    *mbufPtr = mbuf;
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus ClientEntity::FillMbufWithDeque(const uint64_t deqLen, Mbuf *const mbuf) const
{
    // setdatalen
    auto retCode = halMbufSetDataLen(mbuf, deqLen);
    if (retCode != static_cast<int32_t>(DRV_ERROR_NONE)) {
        DGW_LOG_ERROR("Failed to call halMbufSetDataLen for entity[%s], ret=[%d].", entityDesc_.c_str(), retCode);
        return FsmStatus::FSM_FAILED;
    }

    // get mbuf head
    void *headBuf = nullptr;
    uint32_t headBufSize = 0U;
    retCode = halMbufGetPrivInfo(mbuf, &headBuf, &headBufSize);
    if (retCode != static_cast<int32_t>(DRV_ERROR_NONE)) {
        DGW_LOG_ERROR("halMbufGetPrivInfo from mbuf for entity[%s] failed, ret is %d.", entityDesc_.c_str(), retCode);
        return FsmStatus::FSM_FAILED;
    }
    if (headBufSize < MBUF_HEAD_MAX_SIZE) {
        DGW_LOG_ERROR("mbuf head size:%u is invalid.", headBufSize);
        return FsmStatus::FSM_FAILED;
    }

    // get mbuf data
    void *dataPtr = nullptr;
    retCode = halMbufGetBuffAddr(mbuf, &dataPtr);
    if ((retCode != static_cast<int32_t>(DRV_ERROR_NONE)) || (dataPtr == nullptr)) {
        DGW_LOG_ERROR("Failed to get data or data is nullptr, retCode[%d].", retCode);
        return FsmStatus::FSM_FAILED;
    }

    const size_t totalLen = sizeof(struct buff_iovec) + sizeof(struct iovec_info);
    std::unique_ptr<char_t[]> vecUniquePtr(new (std::nothrow) char_t[totalLen], std::default_delete<char_t[]>());
    DGW_CHECK((vecUniquePtr != nullptr), FsmStatus::FSM_FAILED,
        "failed to alloc memory for buffIovec, size[%zu].", totalLen);

    buff_iovec * const buffIovec = PtrToPtr<char_t, buff_iovec>(vecUniquePtr.get());
    buffIovec->context_base = headBuf;
    buffIovec->context_len = headBufSize;
    buffIovec->count = 1U;
    buffIovec->ptr[0U].iovec_base = dataPtr;
    buffIovec->ptr[0U].len = deqLen;
    const auto ret = halQueueDeQueueBuff(deviceId_, id_, buffIovec, -1);
    if (ret != DRV_ERROR_NONE) {
        DGW_LOG_ERROR("halQueueDeQueueBuff queue[%u] on device[%u] fail, ret is %d.", id_, deviceId_,
            static_cast<int32_t>(ret));
        return FsmStatus::FSM_FAILED;
    }

    return FsmStatus::FSM_SUCCESS;
}

FsmStatus ClientEntity::ResetSrcState()
{
    ResetSrcSubState();
    return ChangeState(FsmState::FSM_IDLE_STATE);
}

void ClientEntity::ResetSrcSubState()
{
    asyncDataState_ = AsyncDataState::FSM_ASYNC_DATA_INIT;
}

Mbuf *ClientEntity::PrepareMbufToPush(DataObjPtr dataObj) const
{
    Mbuf * const mbuf = const_cast<Mbuf *>(dataObj->GetMbuf());
    return mbuf;
}

FsmStatus ClientEntity::DoSendData(Mbuf *const mbuf)
{
    if (asyncDataState_ == AsyncDataState::FSM_ASYNC_DATA_WAIT) {
        return FsmStatus::FSM_KEEP_STATE;
    }
    if (asyncDataState_ == AsyncDataState::FSM_ASYNC_DATA_SENT) {
        asyncDataState_ = AsyncDataState::FSM_ASYNC_DATA_INIT;
        return FsmStatus::FSM_SUCCESS;
    }

    asyncDataState_ = AsyncDataState::FSM_ASYNC_DATA_WAIT;
    try {
        InvokeEnqueThread(mbuf);
    } catch(std::exception &e) {
        DGW_LOG_ERROR("create aync mem buff thread object failed, %s", e.what());
        asyncDataState_ = AsyncDataState::FSM_ASYNC_DATA_INIT;
        return FsmStatus::FSM_FAILED;
    }
    return FsmStatus::FSM_KEEP_STATE;
}

void ClientEntity::InvokeEnqueThread(Mbuf *const mbuf)
{
    std::thread th(&ClientEntity::DoClientEnqueue, this, mbuf);
    th.detach();
}

FsmStatus ClientEntity::DoClientEnqueue(Mbuf *const mbuf)
{
    DGW_LOG_INFO("Entity[%s] Start AsyncMemBuffEnQueueEvent", entityDesc_.c_str());
    const auto ret = DoEnqueueMbuf(mbuf);
    if (ret != FsmStatus::FSM_SUCCESS) {
        if (ret == FsmStatus::FSM_DEST_FULL) {
            bqs::StatisticManager::GetInstance().DataQueueEnqueueFullStat();
        } else {
           bqs::StatisticManager::GetInstance().DataQueueEnqueueFailStat();
        }
        asyncDataState_ = AsyncDataState::FSM_ASYNC_DATA_INIT;
    } else {
        bqs::StatisticManager::GetInstance().DataQueueEnqueueSuccStat();
        // mask dst aysnc mem entity
        dgw::EntityManager::Instance().SetExistAsyncMemEntity();
        // enable AsyncMemEnqueue Queue flag
        bqs::QueueManager::GetInstance().enableAsyncMemEnqueueFlag();
        const auto bqsRet = bqs::QueueManager::GetInstance().EnqueueAsynMemBuffEvent();
        if (bqsRet != bqs::BQS_STATUS_OK) {
            DGW_LOG_ERROR("failed to EnqueueAsynMemBuffEvent, ret[%d].", static_cast<int32_t>(bqsRet));
        }
        asyncDataState_ = AsyncDataState::FSM_ASYNC_DATA_SENT;
    }
    return ret;
}

FsmStatus ClientEntity::DoEnqueueMbuf(Mbuf *const mbuf) const
{
    // get mbuf head
    void *headBuf = nullptr;
    uint32_t headBufSize = 0U;
    auto ret = halMbufGetPrivInfo(mbuf, &headBuf, &headBufSize);
    if (ret != DRV_ERROR_NONE) {
        DGW_LOG_ERROR("halMbufGetPrivInfo from mbuf failed, ret is %d.", static_cast<int32_t>(ret));
        return FsmStatus::FSM_FAILED;
    }
    if (headBufSize < MBUF_HEAD_MAX_SIZE) {
        DGW_LOG_ERROR("mbuf head size:%u is invalid.", headBufSize);
        return FsmStatus::FSM_FAILED;
    }

    // get mbuf data length
    uint64_t dataLen = 0UL;
    auto retCode = halMbufGetDataLen(mbuf, &dataLen);
    if ((retCode != static_cast<int32_t>(DRV_ERROR_NONE)) || (dataLen == 0)) {
        DGW_LOG_ERROR("Fail to get buff size for mbuf, ret=[%d], dataLen[%u]", retCode, dataLen);
        return FsmStatus::FSM_FAILED;
    }

    // get mbuf data
    void *dataPtr = nullptr;
    retCode = halMbufGetBuffAddr(mbuf, &dataPtr);
    if ((retCode != static_cast<int32_t>(DRV_ERROR_NONE)) || (dataPtr == nullptr)) {
        DGW_LOG_ERROR("Failed to get data or data is nullptr, ret[%d].", retCode);
        return FsmStatus::FSM_FAILED;
    }

    const size_t totalLen = sizeof(struct buff_iovec) + sizeof(struct iovec_info);
    std::unique_ptr<char_t[]> vecUniquePtr(new (std::nothrow) char_t[totalLen], std::default_delete<char_t[]>());
    DGW_CHECK((vecUniquePtr != nullptr), FsmStatus::FSM_FAILED,
        "failed to alloc memory for buffIovec, size[%zu].", totalLen);

    buff_iovec * const buffIovec = PtrToPtr<char_t, buff_iovec>(vecUniquePtr.get());
    buffIovec->context_base = headBuf;
    buffIovec->context_len = headBufSize;
    buffIovec->count = 1U;
    buffIovec->ptr[0U].iovec_base = dataPtr;
    buffIovec->ptr[0U].len = dataLen;
    DGW_LOG_INFO("Entity[%s] Begin halQueueEnQueueBuff", entityDesc_.c_str());
    ret = halQueueEnQueueBuff(deviceId_, id_, buffIovec, -1);
    DGW_LOG_INFO("entity:[%s] halQueueEnQueueBuff queue id:[%u] device id:[%u] result:[%d].",
        entityDesc_.c_str(), id_, deviceId_, static_cast<int32_t>(ret));
    if (ret == DRV_ERROR_QUEUE_FULL) {
        DGW_LOG_WARN("halQueueEnQueue queue id:[%u] on device:[%u] FULL!!!!.", id_, deviceId_);
        return FsmStatus::FSM_DEST_FULL;
    }
    if (ret != DRV_ERROR_NONE) {
        DGW_LOG_ERROR("halQueueEnQueueBuff queue id:[%u] on device:[%u] FAILED!!!!.", id_, deviceId_);
        return (ret == DRV_ERROR_NOT_EXIST) ? FsmStatus::FSM_ERROR_PENDING : FsmStatus::FSM_FAILED;
    }
    return FsmStatus::FSM_SUCCESS;
}

bool ClientEntity::IsDataPeeked() const
{
    return (asyncDataState_ == AsyncDataState::FSM_ASYNC_ENTITY_DONE);
}

}