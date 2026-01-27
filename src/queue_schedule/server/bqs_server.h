/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef BQS_SERVER_H
#define BQS_SERVER_H

#include <condition_variable>
#include "proto/easycom_message.pb.h"

#include "bqs_status.h"
#include "bqs_log.h"
#include "bqs_msg.h"
#include "bind_relation.h"

namespace bqs {
class BqsServer {
public:
    static BqsServer &GetInstance();

    BqsServer(const BqsServer &) = delete;

    BqsServer(BqsServer &&) = delete;

    BqsServer &operator=(const BqsServer &) = delete;

    BqsServer &operator=(BqsServer &&) = delete;

    /**
     * Init bqs server, including init easycomm server
     * @return BQS_STATUS_OK:success other:failed
     */
    BqsStatus InitBqsServer(const std::string &qsInitGrpName, const uint32_t deviceId);

    /**
     * Bqs server handle BqsMsg, get/getall deal now, bind/unbind send to work thread to deal
     * @return NA
     */
    void HandleBqsReqMsg(const uint32_t msgId, const char_t * const data, const uint32_t dataSize);

    /**
     * Bqs server send response msg to client, need to send a response to avoid blocking
     * @return NA
     */
    void SendRspMsg(const int fd, const uint32_t msgId) const;

    /**
     * Bqs server enqueue bind msg request process
     * @return NA
     */
    void BindMsgProc();

private:
    BqsServer();

    ~BqsServer();

    /**
     * Init easycomm server, including register handler and start listening
     * @return BQS_STATUS_OK:success other:failed
     */
    BqsStatus InitHandler() const;

    /**
     * Bqs server wait work thread to process msg
     * @return NA
     */
    void WaitBindMsgProc();

    /**
     * Bqs server bind message processing function
     * @return NA
     */
    void ParseBindMsg(BQSMsg &requestMsg, BQSMsg &responseMsg) const;

    /**
     * Bqs server unbind message processing function
     * @return NA
     */
    void ParseUnbindMsg(BQSMsg &requestMsg, BQSMsg &responseMsg) const;

    /**
     * Bqs server get bind message processing function
     * @return NA
     */
    void ParseGetBindMsg(BQSMsg &requestMsg, BQSMsg &responseMsg) const;

    /**
     * Bqs server get paged bind message processing function
     * @return NA
     */
    void ParseGetPagedBindMsg(BQSMsg &requestMsg, BQSMsg &responseMsg) const;

    /**
     * Bqs server unbind message processing function
     * @return unbind result, BQS_STATUS_OK:success other:failed
     */
    int32_t UnbindRelation(BindRelation &relationInstance,
        const BQSQueryMsg::QsQueryType &queryType, EntityInfo &srcId, EntityInfo &dstId) const;

    /**
     * Assembly response of get bind message according to src queueId
     * @return NA
     */
    void SerializeGetBindRspBySrc(const uint32_t srcId, BQSMsg &responseMsg) const;

    /**
     * Assembly response of get bind message according to dst queueId, one-to-one relation
     * @return NA
     */
    void SerializeGetBindRspByDst(const uint32_t dstId, BQSMsg &responseMsg) const;

    /**
     * Assembly response of get bind message
     * @return NA
     */
    void SerializeGetBindRsp(
        const BQSQueryMsg::QsQueryType &queryType, const uint32_t srcId,
        const uint32_t dstId, BQSMsg &responseMsg) const;

    /**
     * Copy relation map to a vector container
     * @return NA
     */
    void RelationsCopy(std::vector<std::tuple<uint32_t, uint32_t>> &relations, const uint32_t oldSize,
        const std::unordered_map<EntityInfo, std::unordered_set<EntityInfo, EntityInfoHash>, EntityInfoHash> &srcMap)
        const;

    /**
     * Append relations to a vector container
     * @return NA
     */
    void AppendRelations(std::vector<std::tuple<uint32_t, uint32_t>> &relations,
        const std::unordered_map<EntityInfo, std::unordered_set<EntityInfo, EntityInfoHash>, EntityInfoHash> &srcMap)
        const;
    /* *
     * attach and init buff group
     * @return NA
     */
    void InitBuff() const;

    /**
    * Fill getBind response by src and dstSet, one-to-one relation
    * @return NA
    */
    void FillGetBindRspBySrc(const uint32_t srcId,
        const std::unordered_set<EntityInfo, EntityInfoHash> &dstSet,
        bool isAbnormal, BQSBindQueueMsgs *const bqsBindQueueMsgBuff) const;

    /**
    * Fill getBind response by srcSet and dst, one-to-one relation
    * @return NA
    */
    void FillGetBindRspByDst(const std::unordered_set<EntityInfo, EntityInfoHash> &srcSet,
        const uint32_t dstId, bool isAbnormal, BQSBindQueueMsgs *const bqsBindQueueMsgBuff) const;

private:
    uint32_t msgId_;     // msg id from client
    BQSMsg bqsReqMsg_;   // request msg from client
    BQSMsg bqsRespMsg_;  // response msg to client

    std::condition_variable cv_;  // condition var to wait work thread process
    std::mutex mutex_;
    bool processing_;  // ture means work thread is processing the bind request
    bool done_;        // ture means work thread has processed the bind request

    const uint32_t qsGroupId_ = 1000U; // queue schedule init ezcomm connect group id
    std::string qsInitGroupName_; // initial group name in parameters
    uint32_t deviceId_ = 0U; // device id
};
}      // namespace bqs
#endif  // BQS_SERVER_H