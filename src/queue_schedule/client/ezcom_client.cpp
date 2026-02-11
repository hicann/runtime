/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "ezcom_client.h"

#include <securec.h>
#include "easy_comm.h"

#include "bqs_log.h"
#include "bqs_msg.h"
#include "bqs_util.h"

namespace {
std::mutex g_ezClientMut;
}
namespace bqs {
int32_t EzcomClient::clientFd_(0);
std::atomic<bool> EzcomClient::initFlag_(false);

/* *
 * Create instance of EzcomClient.
 * @return EzcomClient*: success
 */
EzcomClient *EzcomClient::GetInstance(const int32_t fd)
{
    const std::lock_guard<std::mutex> lk(g_ezClientMut);
    if (!initFlag_) {
        clientFd_ = fd;
        initFlag_ = true;
    }
    static EzcomClient instance;
    return &instance;
}

/* *
 * Assembly bind BQSMsg message
 * @return BQS_STATUS_OK: success, other: error
 */
BqsStatus EzcomClient::SerializeBindMsg(const std::vector<BQSBindQueueItem> &bindQueueVec, BQSMsg &bqsClientMsg) const
{
    BQS_LOG_INFO("Bind relation [add], stage [client], type [request], relation [size:%zu]", bindQueueVec.size());
    if (bindQueueVec.empty()) {
        BQS_LOG_WARN("The number of bind relation to be added should be greater than zero.");
        return BQS_STATUS_PARAM_INVALID;
    }

    bqsClientMsg.set_msg_type(BQSMsg::BIND);
    BQSBindQueueMsgs * const bqsBindQueueMsgBuff = bqsClientMsg.mutable_bind_queue_msgs();

    for (size_t i = 0U; i < bindQueueVec.size(); i++) {
        BQSBindQueueMsg * const bqsBindQueueEzMsg = bqsBindQueueMsgBuff->add_bind_queue_vec();

        bqsBindQueueEzMsg->set_src_queue_id(bindQueueVec[i].srcQueueId_);
        bqsBindQueueEzMsg->set_dst_queue_id(bindQueueVec[i].dstQueueId_);
        BQS_LOG_INFO("Bind relation [add], stage [client], type [request], relation [src:%u, dst:%u]",
            bindQueueVec[i].srcQueueId_, bindQueueVec[i].dstQueueId_);
    }
    return BQS_STATUS_OK;
}

/* *
 * Send BQSMsg message to server
 * @return BQS_STATUS_OK: success, other: error
 */
BqsStatus EzcomClient::SendBqsMsg(const BQSMsg &bqsReqMsg, BQSMsg &bqsRespMsg) const
{
    const uint32_t bqsMsgLen = static_cast<uint32_t>(bqsReqMsg.ByteSizeLong());
    uint32_t reqLength = 0U;
    bool isOverflow = false;
    BqsCheckAssign32UAdd(bqsMsgLen, BQS_MSG_HEAD_SIZE, reqLength, isOverflow);
    if (isOverflow) {
        return BQS_STATUS_INNER_ERROR;
    }

    std::unique_ptr<char_t[]> reqData(new (std::nothrow) char_t[reqLength], std::default_delete<char_t[]>());
    if (reqData == nullptr) {
        BQS_LOG_ERROR("Malloc memory error, reqData is nullptr");
        return BQS_STATUS_INNER_ERROR;
    }
    // met Exceptions, no need to checks for security functions
    const auto ret = memset_s(reqData.get(), static_cast<size_t>(reqLength), 0, static_cast<size_t>(reqLength));
    if (ret != EOK) {
        BQS_LOG_ERROR("memset_s fail, ret is %d.", ret);
        return BQS_STATUS_INNER_ERROR;
    }
    // Add msg length to check
    *(reinterpret_cast<uint32_t *>(reqData.get())) = bqsMsgLen + BQS_MSG_HEAD_SIZE;

    if (!bqsReqMsg.SerializePartialToArray(reqData.get() + BQS_MSG_HEAD_SIZE, static_cast<int32_t>(bqsMsgLen))) {
        BQS_LOG_ERROR("serialize bqsReqMsg fail.");
        return BQS_STATUS_INNER_ERROR;
    }

    uint8_t * const msgDesc = nullptr;
    EzcomRequest req = {.id = 0U, .data = reinterpret_cast<uint8_t *>(reqData.get()), .size = reqLength};
    struct EzcomResponse resp = { 0U };
    // Send msg and get response
    BQS_LOG_INFO("EzcomRPCSync begin, fd:%d, msg size:%u", clientFd_, reqLength);
    int32_t err = EzcomRPCSync(clientFd_, &req, &resp);
    if (err == -EAGAIN) {
        err = EzcomRPCSync(clientFd_, &req, &resp);
        BQS_LOG_INFO("Need to retry ezcom send, fd=%d", clientFd_);
    }

    // scope resp.data
    const ScopeGuard respDataGuard([&resp]() {
        if (resp.data != nullptr) {
            delete[] resp.data;
            resp.data = nullptr;
        }
    });

    if ((err < 0) || (resp.data == nullptr)) {
        BQS_LOG_ERROR("EasyRPCSync failed: %d", err);
        return BQS_STATUS_EASY_COMM_ERROR;
    }

    if (resp.size < BQS_MSG_HEAD_SIZE) {
        BQS_LOG_ERROR("EasyRPCSync response size:%u error, should be not less than head size:%u.", resp.size,
            BQS_MSG_HEAD_SIZE);
        return BQS_STATUS_EASY_COMM_ERROR;
    }

    BQS_LOG_INFO("EzcomRPCSync end, response id:%u, response length:%u", resp.id, resp.size);

    // Check response msg
    const uint32_t currMsgSize = *(reinterpret_cast<uint32_t *>(resp.data));
    if (currMsgSize != resp.size) {
        BQS_LOG_ERROR("message error, head msg content:%u, response size:%u", currMsgSize, resp.size);
        return BQS_STATUS_EASY_COMM_ERROR;
    }

    // Parse response msg to BQSMsg
    char_t * const respData = reinterpret_cast<char_t *>(resp.data);
    const uint32_t parseLength = currMsgSize - BQS_MSG_HEAD_SIZE;
    if (!bqsRespMsg.ParseFromArray(respData + BQS_MSG_HEAD_SIZE, static_cast<int32_t>(parseLength))) {
        BQS_LOG_ERROR("parse bqsRespMsg fail.");
        return BQS_STATUS_INNER_ERROR;
    }
    return BQS_STATUS_OK;
}

/* *
 * Parse bind response BQSMsg message
 * @return number of bind relation success
 */
uint32_t EzcomClient::ParseBindRespMsg(BQSMsg &bqsRespMsg, std::vector<BQSBindQueueResult> &bindResultVec) const
{
    uint32_t bindNum = 0U;
    const BQSBindQueueRsps * const bqsBindQueueRspBuff = bqsRespMsg.mutable_resp_msgs();

    BQS_LOG_INFO("Bind relation [add/del], stage [client], type [response], relation [size:%d]",
        bqsBindQueueRspBuff->bind_result_vec_size());
    for (int32_t i = 0; i < bqsBindQueueRspBuff->bind_result_vec_size(); i++) {
        const BQSBindQueueRsp bqsBindQueueEzRsp = bqsBindQueueRspBuff->bind_result_vec(i);
        const BQSBindQueueResult bindResult = {bqsBindQueueEzRsp.bind_result()};
        bindResultVec.push_back(bindResult);

        const int32_t result = bqsBindQueueEzRsp.bind_result();
        BQS_LOG_INFO("Bind relation [add/del], stage [client], type [response], relation [index:%d, result:%d].", i,
            result);
        if (result == BQS_STATUS_OK) {
            bindNum++;
        }
    }
    return bindNum;
}

/* *
 * Assembly unbind BQSMsg message
 * @return BQS_STATUS_OK: success, other: failed
 */
BqsStatus EzcomClient::SerializeUnbindMsg(const std::vector<BQSQueryPara> &bqsQueryParaVec, BQSMsg &bqsClientMsg) const
{
    BQS_LOG_INFO("Bind relation [del], stage [client], type [request], relation [size:%zu]", bqsQueryParaVec.size());
    if (bqsQueryParaVec.size() == 0U) {
        BQS_LOG_WARN("The number of bind relation to be deleted should be greater than zero.");
        return BQS_STATUS_PARAM_INVALID;
    }

    bqsClientMsg.set_msg_type(BQSMsg::UNBIND);
    BQSQueryMsgs * const bqsQueryMsgBuff = bqsClientMsg.mutable_query_msgs();

    for (size_t i = 0U; i < bqsQueryParaVec.size(); i++) {
        BQSQueryMsg * const bqsQueryEzMsg = bqsQueryMsgBuff->add_query_msg_vec();

        bqsQueryEzMsg->set_key_type(static_cast<BQSQueryMsg::QsQueryType>(bqsQueryParaVec[i].keyType_));
        BQSBindQueueMsg * const bqsBindQueueEzMsg = bqsQueryEzMsg->mutable_bind_queue_item();

        bqsBindQueueEzMsg->set_src_queue_id(bqsQueryParaVec[i].bqsBindQueueItem_.srcQueueId_);
        bqsBindQueueEzMsg->set_dst_queue_id(bqsQueryParaVec[i].bqsBindQueueItem_.dstQueueId_);

        BQS_LOG_INFO("Bind relation [del], stage [client], type [request], relation [type{0:src, 1:dst, 2:src-dst}:%d, "
            "src:%u, dst:%u]",
            bqsQueryParaVec[i].keyType_, bqsQueryParaVec[i].bqsBindQueueItem_.srcQueueId_,
            bqsQueryParaVec[i].bqsBindQueueItem_.dstQueueId_);
    }
    return BQS_STATUS_OK;
}

/**
 * Assembly get bind BQSMsg message
 * @return BQS_STATUS_OK: success, other: failed
 */
BqsStatus EzcomClient::SerializeGetBindMsg(const BQSQueryPara &queryPara, BQSMsg &bqsClientMsg) const
{
    BQS_LOG_INFO("Bind relation [get], stage [client], type [request]");
    bqsClientMsg.set_msg_type(BQSMsg::GET_BIND);
    BQSQueryMsg * const bqsQueryEzMsg = bqsClientMsg.mutable_query_msg();

    bqsQueryEzMsg->set_key_type(static_cast<BQSQueryMsg::QsQueryType>(queryPara.keyType_));
    BQSBindQueueMsg * const bqsBindQueueEzMsg = bqsQueryEzMsg->mutable_bind_queue_item();

    bqsBindQueueEzMsg->set_src_queue_id(queryPara.bqsBindQueueItem_.srcQueueId_);
    bqsBindQueueEzMsg->set_dst_queue_id(queryPara.bqsBindQueueItem_.dstQueueId_);
    BQS_LOG_INFO("Bind relation [get], stage [client], type [request], relation [type{0:src, 1:dst, 2:src-dst}:%d, "
        "src:%u, dst:%u]",
        queryPara.keyType_, queryPara.bqsBindQueueItem_.srcQueueId_, queryPara.bqsBindQueueItem_.dstQueueId_);
    return BQS_STATUS_OK;
}

/**
 * Parse get bind response BQSMsg message
 * @return number of bind relation
 */
uint32_t EzcomClient::ParseGetBindRespMsg(BQSMsg &bqsRespMsg, std::vector<BQSBindQueueItem> &bindQueueVec) const
{
    uint32_t bindNum = 0U;
    const BQSBindQueueMsgs * const bqsBindQueueMsgBuff = bqsRespMsg.mutable_bind_queue_msgs();

    bindNum = static_cast<uint32_t>(bqsBindQueueMsgBuff->bind_queue_vec_size());
    BQS_LOG_INFO("Bind relation [get], stage [client], type [response], relation [size:%u]", bindNum);
    for (uint32_t i = 0U; i < bindNum; i++) {
        const BQSBindQueueMsg bqsBindQueueEzMsg = bqsBindQueueMsgBuff->bind_queue_vec(static_cast<int32_t>(i));
        const BQSBindQueueItem bindItem = {
            bqsBindQueueEzMsg.src_queue_id(),
            bqsBindQueueEzMsg.dst_queue_id()
        };
        bindQueueVec.push_back(bindItem);
        BQS_LOG_INFO(
            "Bind relation [get], stage [client], type [response], relation [index:%u, src:%u, dst:%u]", i,
            bindItem.srcQueueId_, bindItem.dstQueueId_);
    }
    return bindNum;
}

/* *
 * Assembly get paged bind BQSMsg message
 * @return BQS_STATUS_OK: success, other: failed
 */
BqsStatus EzcomClient::SerializeGetPagedBindMsg(const uint32_t offset, const uint32_t limit, BQSMsg &bqsClientMsg) const
{
    BQS_LOG_INFO("Bind relation [get_paged], stage [client], type [request]");
    bqsClientMsg.set_msg_type(BQSMsg::GET_ALL_BIND);
    BQSPagedMsg * const bqsPagedEzMsg = bqsClientMsg.mutable_paged_msg();
    bqsPagedEzMsg->set_offset(offset);
    bqsPagedEzMsg->set_limit(limit);
    return BQS_STATUS_OK;
}

/**
 * Parse get paged bind response BQSMsg message
 * @return number of bind relation
 */
uint32_t EzcomClient::ParseGetPagedBindRespMsg(BQSMsg &bqsRespMsg, std::vector<BQSBindQueueItem> &bindQueueVec,
    uint32_t &total) const
{
    uint32_t bindNum = 0U;
    const BQSBindQueueMsgs * const bqsBindQueueMsgBuff = bqsRespMsg.mutable_bind_queue_msgs();

    const BQSPagedMsg * const bqsPagedEzMsg = bqsRespMsg.mutable_paged_msg();
    total = bqsPagedEzMsg->total();

    bindNum = static_cast<uint32_t>(bqsBindQueueMsgBuff->bind_queue_vec_size());
    BQS_LOG_INFO("Bind relation [get_paged], stage [client], type [response], relation [size:%u]", bindNum);
    for (uint32_t i = 0U; i < bindNum; i++) {
        const BQSBindQueueMsg bqsBindQueueEzMsg = bqsBindQueueMsgBuff->bind_queue_vec(static_cast<int32_t>(i));
        const BQSBindQueueItem bindItem = {
            bqsBindQueueEzMsg.src_queue_id(),
            bqsBindQueueEzMsg.dst_queue_id()
        };
        bindQueueVec.push_back(bindItem);
        BQS_LOG_INFO(
            "Bind relation [get_paged], stage [client], type [response], relation [index:%u, src:%u, dst:%u]", i,
            bindItem.srcQueueId_, bindItem.dstQueueId_);
    }
    return bindNum;
}
} // namespace bqs