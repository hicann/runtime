/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DGW_CHANNEL_ENTITY_H
#define DGW_CHANNEL_ENTITY_H

#include "simple_entity.h"
#include "bqs_util.h"
#include "hccl/comm_channel_queue.h"
#include "hccl/comm_channel_manager.h"
#include "hccl/hccl_ex.h"

namespace dgw {

// temporily record hccl data
struct HcclData {
    uint64_t headSize = 0UL;  // head size
    uint64_t dataSize = 0UL;  // data size
    Mbuf *mbuf = nullptr;     // mbuf ptr
    void *headBuf = nullptr;  // head buff addr
    uint64_t mbufHeadSize = 0UL;  // head size of mbuf
};

// request info
struct RequestInfo {
    HcclRequest req;     // hccl request
    bool isLink;         // is link
    Mbuf *mbuf;          // mbuf addr
    uint64_t startTick;  // start tick
};

// cached envelope info
struct EnvelopeInfo {
    HcclMessage msg;     // hccl recv request msg
    uint64_t dataSize;   // data size
    uint64_t probeTick;  // probe tick
};

class ChannelEntity : public SimpleEntity {
public:
    explicit ChannelEntity(const EntityMaterial &material, const uint32_t resIndex);
    ~ChannelEntity() override;
    ChannelEntity(const ChannelEntity &) = delete;
    ChannelEntity(const ChannelEntity &&) = delete;
    ChannelEntity &operator = (const ChannelEntity &) = delete;
    ChannelEntity &operator = (ChannelEntity &&) = delete;

    /**
     * @brief init comm channel entity
     * @param state entity state
     * @param direction entity direction
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus Init(const FsmState state, const EntityDirection direction) override;

    /**
     * @brief uinit comm channel entity
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus Uninit() override;

    /**
     * @brief dump channel entity
     */
    void Dump() const;

    /**
     * @brief probe comm channel
     * @param dataCount data count
     * @param msg hccl message
     * @param probeTick start tick
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus Probe(uint64_t &dataCount, HcclMessage &msg, uint64_t &probeTick);

    /**
     * @brief receive data from hccl
     * @param msg msg
     * @param dataCount data count
     * @param probeTick probe tick
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus ReceiveData(HcclMessage &msg, const uint64_t dataCount, const uint64_t probeTick);

    /**
     * @brief process completed request
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus ProcessCompReq();

    /**
     * @brief get front request from uncompleted request queue
     * @return RequestInfo* request
     */
    RequestInfo *FrontUncompReq();

    /**
     * @brief add cached request count
     * @return true: add success
     * @return false: add failed
     */
    bool AddCachedReqCount();

    /**
     * @brief reduce cached request count
     * @return true: reduce success
     * @return false: reduce failed
     */
    bool ReduceCachedReqCount();

    /**
     * @brief get the Comm Channel object
     * @return const CommChannel*
     */
    const CommChannel *GetCommChannel() const;

    /**
     * @brief get completed req queue id
     * @return const uint32_t compReqQueueId_
     */
    uint32_t GetQueueId() const override;

    /**
     * @brief check whether continue to process receive request event
     * @return true
     * @return false
     */
    bool CheckRecvReqEventContinue();

    FsmStatus MakeSureOutputCompletion() override;

    // link status
    ChannelLinkStatus linkStatus_;
protected:
    FsmStatus DoSendData(Mbuf *const mbuf) override;
    void PostDeque() override;

private:
    /**
     * @brief alloc mbuf
     * @param mbufPtr mbuf ptr
     * @param headBuf head buff addr
     * @param dataBuf data buff addr
     * @param dataLen data length
     * @return FsmStatus FSM_SUCCESS: success, other: failed
     */
    FsmStatus AllocMbuf(Mbuf *&mbufPtr, void *&headBuf, void *&dataBuf, const uint64_t dataLen);

    /**
     * @brief receive mbuf data
     * @param entity entity ptr
     * @param recordInfo recorded hccl info
     * @param msg hccl envelope msg
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus ReceiveMbufData(HcclMessage &msg);

    /**
     * @brief receive mbuf head
     * @param entity entity ptr
     * @param recordInfo recorded hccl info
     * @param msg hccl envelope msg
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus ReceiveMbufHead(HcclMessage &msg);

    /**
     * @brief receive data for link
     * @param msg hccl envelope msg
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus ReceiveDataForLink(HcclMessage &msg);

    /**
     * @brief send mbuf data
     * @param mbuf mbuf
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus SendMbufData(Mbuf * const mbuf);

    /**
     * @brief send mbuf head
     * @param mbuf mbuf
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus SendMbufHead(Mbuf * const mbuf);

    /**
     * @brief process send completion event
     * @param mbuf mbuf
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus ProcessSendCompletion(Mbuf* mbuf);

    /**
     * @brief process receive completion event
     * @param mbuf mbuf
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus ProcessReceiveCompletion(Mbuf * const mbuf);

    /**
     * @brief send data to establish a link with peer tag
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus SendDataForLink();

    /**
     * @brief process link request
     * @param req request
     * @param reqProcCost request process cost
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus ProcessLinkRequest(const HcclRequest &req, const float64_t reqProcCost);

    FsmStatus SendDataWithHccl(void *const dataBuf, const int32_t dataLen, Mbuf *const mbufToRecord);

    FsmStatus CreateAndSubscribeCompletedQueue();

    FsmStatus DoProbe(uint64_t &dataCount, HcclMessage &msg, uint64_t &probeSuccTick);

    void UpdateStatisticForBody(const uint64_t reqProcTickCost);

    void UpdateStatisticForHead(const uint64_t reqProcTickCost);

private:
    // comm channel info
    const CommChannel *channelPtr_;
    // channel queue for uncompleted request
    CommChannelQueue<RequestInfo> uncompReqQueue_;
    // drv queue for completed request
    uint32_t compReqQueueId_;
    // envelope cache queue
    CommChannelQueue<EnvelopeInfo> cachedEnvelopeQueue_;
    // cached req count: irecv, count++; dequeue from compReqQueue, count-2
    uint32_t cachedReqCount_;
    // spin lock for probeCount_
    bqs::SpinLock cachedReqCountLock;
    // max cached req count
    uint32_t maxCachedReqCount_;
    // record info for hccl receive data
    HcclData hcclData_;
    // whether data field of mbuf has been sent
    bool mbufDataSend_;
    // completed request total count
    uint64_t compReqCount_;
    // probed and processed envelope count(not include cached envelope)
    uint64_t procEnvelopeCount_;
};
}
#endif