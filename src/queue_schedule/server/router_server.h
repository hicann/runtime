/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ROUTER_SERVER_H
#define ROUTER_SERVER_H

#include <map>
#include <vector>
#include <thread>
#include <condition_variable>
#include <atomic>

#include "bind_relation.h"
#include "queue_schedule/qs_client.h"
#include "common/bqs_status.h"
#include "common/bqs_msg.h"
#include "driver/ascend_hal.h"
#include "driver/ascend_hal_define.h"
#include "hccl/hccl_types_in.h"
#include "hccl/hccl_ex.h"
#include "config/config_info_operator.h"

namespace bqs {

enum class ThreadStatus : uint32_t {
    NOT_INIT,
    INIT_SUCCESS,
    INIT_FAIL,
};

class RouterServer {
public:
    static RouterServer &GetInstance();

    /**
     * Init bqs server, including init easycomm server
     * @return BQS_STATUS_OK:success other:failed
     */
    BqsStatus InitRouterServer(const InitQsParams &params);

    /**
     * Bqs server handle BqsMsg, get/getall deal now, bind/unbind send to work thread to deal
     * @return NA
     */
    void HandleBqsMsg(event_info &info);

    /**
     * Bqs server enqueue bind msg request process
     * @return NA
     */
    void BindMsgProc(const uint32_t index = 0U);

    /**
     * Bqs server destroy
     * @return NA
     */
    void Destroy();

    /**
     * get pipeline queueid
     * @return queue id
     */
    uint32_t GetPipelineQueueId() const;

    /**
     * get call hccl api flag
     * @return true
     * @return false
     */
    bool GetCallHcclFlag() const;

    void NotifyInitSuccess();

private:
    RouterServer();

    ~RouterServer();

    RouterServer(const RouterServer &) = delete;

    RouterServer(RouterServer &&) = delete;

    RouterServer &operator=(const RouterServer &) = delete;

    RouterServer &operator=(RouterServer &&) = delete;
    /**
     * Bqs server wait work thread to process msg
     * @return NA
     */
    BqsStatus WaitBindMsgProc();

    /**
     * Bqs server bind message processing function
     * @return BQS_STATUS_OK: success, other: failed.
     */
    BqsStatus ParseBindUnbindMsg() const;

    /**
     * Get relation detail infomation from mbuff, including (qsRouterHeadPtr_ aicpuRspHead_ subEventId_
     *                                                       qsRouterQueryPtr_ qsRouteListPtr_)
     * @return BQS_STATUS_OK: success, other: failed.
     */
    BqsStatus ParseRelationInfo(Mbuf **mbufPtr);
    /**
     * Bqs server bind query info from message
     * @return NA
     */
    void ParseGetBindNumMsg(const event_info &info);
    /**
     * Bqs server get bind message from mbuff
     * @return NA
     */
    BqsStatus ParseGetBindDetailMsg();
    /**
     * Bqs server get bind message by single queueid processing function
     * @return Number of query results
     */
    void GetBindRspBySingle(const EntityInfo& entityInfo, const uint32_t &queryType);

    /**
     * Bqs server get bind message by double queueid processing function
     * @return NA
     */
    void GetBindRspByDouble(const EntityInfo& src, const EntityInfo& dst, const uint32_t &queryType);

    void GetAllAbnormalBind();

    /**
     * Bqs server prcess get bind message and put data in buff
     * @return BQS_STATUS_OK: success, other: failed.
     */
    BqsStatus ProcessGetBindMsg(const uint32_t &queryType, const EntityInfo& src, const EntityInfo& dst);

    /**
     * Lisening bind/unbind/query message from aicpu-sd or acl
     * @return NA
     */
    void ManageQsEvent();

    /**
     * process bind initial
     * @return BQS_STATUS_OK: success, other: failed.
     */
    BqsStatus ProcessBindInit(const event_info &info);

    /**
     * process bind queue event
     * @return NA
     */
    void ProcessBindQueue(const uint32_t index);

    /**
     * process unbind queue event
     * @return NA
     */
    void ProcessUnbindQueue(const uint32_t index);

    /**
     * Send response event to acl or aicpu-sd
     * @return NA
     */
    void SendRspEvent(const int32_t result);

    /**
     * process event info
     * @return NA
     */
    void PreProcessEvent(const event_info &info);

    /**
     * process bind/unbind/query event
     * @return NA
     */
    void ProcessQueueRelationEvent(Mbuf *mbuf);

    /**
     * create queue for communicate between process
     * @return BQS_STATUS_OK: success, other: failed.
     */
    BqsStatus CreateAndGrantPipelineQueue();

    /**
     * attach and intial group at first
     * @return BQS_STATUS_OK: success, other: failed.
     */
    BqsStatus AttachAndInitGroup();

    /**
     * Construct a response message.
     * @return NA
     */
    void FillRspContent(QsProcMsgRsp &retRsp, const int32_t resultCode);

    /**
     * subscribe buf event
     * @return BQS_STATUS_OK: success, other: failed.
     */
    BqsStatus SubscribeBufEvent() const;

    /**
     * wait sync msg process
     * @return BQS_STATUS_OK:success, other:failed.
     */
    BqsStatus WaitSyncMsgProc();

    void FillRoutes(const EntityInfo &src, const EntityInfo &dst, const BindRelationStatus status);

    void ProcessConfigEvent(const QsOperType operType);

    void ProcessQueryLinkStatusEvent();

    bool AttachGroup();

    ThreadStatus PrePareForManageThread();

    EntityInfo CreateBasicEntityInfo(const uint32_t id, const dgw::EntityType eType) const;

    void SearchRelation(const MapEnitityInfoToInfoSet &relationMap, const EntityInfo& entityInfo,
        const BindRelationStatus status, bool bySrc);

    bool FindRelation(const MapEnitityInfoToInfoSet &relationMap, const EntityInfo& srcInfo, const EntityInfo& dstInfo) const;

    void TransRouteWithEntityInfo(const EntityInfo& srcInfo, const EntityInfo& dstInfo, const int32_t status,
        QueueRoute &routeInfo) const;

private:
    std::condition_variable cv_; // condition var to wait work thread process
    std::mutex mutex_;
    bool processing_;  // work thread is processing the bind request
    bool done_;        // work thread has finished the bind request
    bool processingExtra_;
    bool doneExtra_;

    std::thread monitorQsEvent_; // listening bind/unbind/query event from aicpusd or app process
    uint32_t bindQueueGroupId_; // for recieving and sending bind/unbind/query event
    bool running_; // running flag
    uint32_t deviceId_; // device ID

    int32_t srcPid_; // Pid of source process for event commucation
    uint16_t srcVersion_;
    std::atomic<int32_t> srcGroupId_; // groupId of of source process for event commucation
    std::atomic<uint32_t> pipelineQueueId_; // queue for bind unbind query message data
    uint32_t subEventId_; // type of event
    std::vector<QueueRoute> queueRouteQueryList_; // bind relation and status list for query event
    QueueSchedulerRunMode deployMode_; // 0:single process 1:allow multiple process 2:thread mode
    int32_t retCode_; // bind unbind result
    bool attachedFlag_; // current process need to attach group or not
    bool isAicpuEvent_; // event from aicpu
    QueueRoute *qsRouteListPtr_; // bind unbind query msg pointer
    QsRouteHead *qsRouterHeadPtr_; // bind unbind query msg header pointer
    QueueRouteQuery *qsRouterQueryPtr_; // query msg pointer
    event_sync_msg *drvSyncMsg_; // event head from acl request by calling sync event interface
    uint64_t aicpuRspHead_; // event head from aicpu
    std::string qsInitGroupName_; // group name send from parameters
    uint32_t f2nfGroupId_;
    uint64_t schedPolicy_;
    // config info operator
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    // call hccl api flag
    bool callHcclFlag_;
    bool numaFlag_;
    bool readyToHandleMsg_;
    std::mutex manageThreadMutex_;
    std::condition_variable manageThreadCv_; // condition var to wait manage thread to ready
    ThreadStatus manageThreadStatus_;  // 0:uninit, 1:success, 2:failed
    bool needAttachGroup_;
    bool compatMsg_;
};
} // namespace bqs
#endif // ROUTER_SERVER_H