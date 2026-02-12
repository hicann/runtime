/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "server/bqs_server.h"

#include <csignal>
#include <algorithm>
#include <securec.h>
#include "easy_comm.h"
#include "driver/ascend_hal.h"

#include "queue_manager.h"
#include "statistic_manager.h"
#include "router_server.h"
#include "common/bqs_log.h"
#include "aicpu_sched/common/type_def.h"
namespace bqs {
namespace {
// prevents concurrent execution of multiple clients
std::mutex g_bqsMutex;

constexpr const char_t *BQS_SERVER_THREAD_NAME_PREFIX = "bqs_server";

/**
 * Message process function, need to send a response to avoid blocking
 * @return NA
 */
void RpcHandler(const int32_t fd, EzcomRequest * const req)
{
    if (req == nullptr) {
        BQS_LOG_RUN_INFO("Pipe of client has been closed, fd:%d.", fd);
        (void)EzcomClosePipe(fd);
        return;
    }

    const std::unique_lock<std::mutex> lk(g_bqsMutex);
    BQS_LOG_INFO("BqsServer receive a request, id = %u, msg_size = %u", req->id, req->size);
    BqsServer::GetInstance().HandleBqsReqMsg(req->id, reinterpret_cast<const char_t *>(req->data), req->size);
    // send response
    BqsServer::GetInstance().SendRspMsg(fd, req->id);
    BQS_LOG_INFO("BqsServer HandleBqsReqMsg a request success, id = %u, msg_size = %u", req->id, req->size);
    return;
}

void NodeHandlerWrapper(const int32_t fd, const char_t * const clientName, const int32_t nameLen)
{
    (void)fd;
    if ((clientName == nullptr) || (nameLen <= 0)) {
        BQS_LOG_ERROR("Client name is nullptr");
        return;
    }
    (void)pthread_setname_np(pthread_self(), BQS_SERVER_THREAD_NAME_PREFIX);
}
}  // namespace

BqsServer::BqsServer() : msgId_(0U), processing_(false), done_(false)
{}

BqsServer::~BqsServer()
{}

BqsServer &BqsServer::GetInstance()
{
    static BqsServer instance;
    return instance;
}

void BqsServer::InitBuff() const
{
    BuffCfg defaultCfg = {};
    const int32_t drvRet = halBuffInit(&defaultCfg);
    if ((drvRet != DRV_ERROR_NONE) && (drvRet != DRV_ERROR_REPEATED_INIT)) {
        BQS_LOG_ERROR("[BqsServer]Buffer initial failed ret[%d]", drvRet);
        return;
    }
    BQS_LOG_INFO("[RouterServer] Buffer init success ret = %d", drvRet);
}

/**
 * Bqs server handle BqsMsg, get/getall deal now, bind/unbind send to work thread to deal
 * @return NA
 */
void BqsServer::HandleBqsReqMsg(const uint32_t msgId, const char_t * const data, const uint32_t dataSize)
{
    BQS_LOG_INFO("Bind relation, stage [server:receive], type [request], msg [id = %u]", msgId);
    msgId_ = msgId;
    bqsRespMsg_.Clear();  // init response msg
    if (data == nullptr) {
        BQS_LOG_ERROR("Request of BqsClient is nullptr.");
        return;
    }
    if (dataSize < BQS_MSG_HEAD_SIZE) {
        BQS_LOG_ERROR("Request of BqsClient size:%u should be not less than head:%u.", dataSize, BQS_MSG_HEAD_SIZE);
        return;
    }
    InitBuff();
    const uint32_t currMsgSize = *(PtrToPtr<const char_t, const uint32_t>(data));
    if (currMsgSize != dataSize) {
        BQS_LOG_ERROR("message error, head_msg_content = %u, request_size = %u", currMsgSize, dataSize);
        return;
    }
    const uint32_t parseLength = currMsgSize - BQS_MSG_HEAD_SIZE;
    if (bqsReqMsg_.ParseFromArray(data + BQS_MSG_HEAD_SIZE, static_cast<int32_t>(parseLength))) {
        BQS_LOG_INFO("BqsServer request msg type{%d:BIND, %d:UNBIND, %d:GET_BIND, %d:GET_ALL_BIND}:%d "
                     "begin to process",
                     BQSMsg::BIND, BQSMsg::UNBIND, BQSMsg::GET_BIND, BQSMsg::GET_ALL_BIND,
                     bqsReqMsg_.msg_type());
        switch (bqsReqMsg_.msg_type()) {
            case BQSMsg::GET_BIND:
                StatisticManager::GetInstance().GetBindStat();
                ParseGetBindMsg(bqsReqMsg_, bqsRespMsg_);
                break;
            case BQSMsg::GET_ALL_BIND:
                StatisticManager::GetInstance().GetAllBindStat();
                ParseGetPagedBindMsg(bqsReqMsg_, bqsRespMsg_);
                break;
            case BQSMsg::BIND:
                StatisticManager::GetInstance().BindStat();
                WaitBindMsgProc();
                break;
            case BQSMsg::UNBIND:
                StatisticManager::GetInstance().UnbindStat();
                WaitBindMsgProc();
                break;
            default:
                BQS_LOG_ERROR("BqsServer receive unsupported msg type:%d", bqsReqMsg_.msg_type());
                break;
        }
    }
    BQS_LOG_INFO("BqsServer HandleBqsMsg end");
    return;
}

/**
 * Bqs server wait work thread to process msg
 * @return NA
 */
void BqsServer::WaitBindMsgProc()
{
    BQS_LOG_INFO("Bind relation [add/del], stage [server:enqueue], type [request], msg [id = %u]", msgId_);
    std::unique_lock<std::mutex> bqsLock(mutex_);
    const BqsStatus ret = QueueManager::GetInstance().EnqueueRelationEvent();
    if (ret == BQS_STATUS_OK) {
        done_ = false;
        BQS_LOG_INFO("Bind relation [add/del], stage [server:wait], type [request], msg [id = %u]", msgId_);
        (void)cv_.wait_for(bqsLock, std::chrono::milliseconds(MAX_WAITING_NOTIFY), [this] { return done_; });
        while ((!done_) && (processing_)) {
            cv_.wait(bqsLock);
        }
        if (!done_) {
            QueueManager::GetInstance().LogErrorRelationQueueStatus();
            BQS_LOG_ERROR("Bind relation [add/del], stage [server:wait], msg [id:%u] timeout, relation queue[enqueue "
                          "cnt:%lu, dequeue cnt:%lu].",
                msgId_,
                StatisticManager::GetInstance().GetRelationEnqueCnt(),
                StatisticManager::GetInstance().GetRelationDequeCnt());
        }
    }
    BQS_LOG_INFO("BqsServer WaitBindMsgProc end, msg [id = %u]", msgId_);
    return;
}

/**
 * Bqs server enqueue bind msg request process
 * @return NA
 */
void BqsServer::BindMsgProc()
{
    BQS_LOG_INFO("BqsServer BindMsgProc begin.");
    {
        const std::unique_lock<std::mutex> bqsLock(mutex_);
        processing_ = true;
    }
    // parse bind and unbind BQSMsg
    if (bqsReqMsg_.msg_type() == BQSMsg::BIND) {
        ParseBindMsg(bqsReqMsg_, bqsRespMsg_);
    } else if (bqsReqMsg_.msg_type() == BQSMsg::UNBIND) {
        ParseUnbindMsg(bqsReqMsg_, bqsRespMsg_);
    } else {
        BQS_LOG_ERROR("Invalid request type[%d]", static_cast<int32_t>(bqsReqMsg_.msg_type()));
    }
    bqsReqMsg_.Clear();

    {
        const std::unique_lock<std::mutex> bqsLock(mutex_);
        processing_ = false;
        done_ = true;
        cv_.notify_one();
    }
    BQS_LOG_INFO("BqsServer BindMsgProc end.");
    return;
}

/**
 * Init easycomm server, including register handler and start listening
 * @return BQS_STATUS_OK:success other:failed
 */
BqsStatus BqsServer::InitHandler() const
{
    BQS_LOG_INFO("BqsServer service handler init begin.");
    // easycomm start listening
    struct EzcomServerAttr serverAttr;
    serverAttr.openCallback = &NodeHandlerWrapper;
    serverAttr.handler = &RpcHandler;
    serverAttr.gid = qsGroupId_;
    const auto err = EzcomCreateServer(&serverAttr);
    if (err < 0) {
        BQS_LOG_ERROR("Init server failed, another process may have already owned the server. "
                      "errno = %d.", err);
        return BQS_STATUS_EASY_COMM_ERROR;
    }
    return BQS_STATUS_OK;
}

/**
 * Init bqs server, including init easycomm server and bind relation
 * @return BQS_STATUS_OK:success other:failed
 */
BqsStatus BqsServer::InitBqsServer(const std::string &qsInitGrpName, const uint32_t deviceId)
{
    BQS_LOG_INFO("BqsServer Init begin.");

    (void)signal(SIGPIPE, SIG_IGN);

    const BqsStatus ret = InitHandler();
    if (ret != BQS_STATUS_OK) {
        return ret;
    }
    qsInitGroupName_ = qsInitGrpName;
    deviceId_ = deviceId;
    BQS_LOG_INFO("BqsServer Init success.");
    return BQS_STATUS_OK;
}

/**
 * Bqs server send response msg to client, need to send a response to avoid blocking
 * @return NA
 */
void BqsServer::SendRspMsg(const int32_t fd, const uint32_t msgId) const
{
    BQS_LOG_INFO("Bind relation, stage [server:send], type [response], msg [fd = %d, id = %u]", fd, msgId);

    const uint32_t msgLen = static_cast<uint32_t>(bqsRespMsg_.ByteSizeLong());
    const uint32_t respLength = msgLen + BQS_MSG_HEAD_SIZE;
    char_t * const respData = new (std::nothrow) char_t[respLength];
    if (respData == nullptr) {
        BQS_LOG_ERROR("Malloc memory error, respData is nullptr");
        return;
    }

    // add msg length to check
    bool isOverflow = false;
    BqsCheckAssign32UAdd(msgLen, BQS_MSG_HEAD_SIZE, *(reinterpret_cast<uint32_t *>(respData)), isOverflow);
    if (isOverflow) {
        BQS_LOG_ERROR("msgLen[%u] is too big.", msgLen);
        delete[] respData;
        return;
    }
    if (!bqsRespMsg_.SerializePartialToArray(respData + BQS_MSG_HEAD_SIZE, static_cast<int32_t>(msgLen))) {
        BQS_LOG_ERROR("Serialize response msg failed.");
        delete[] respData;
        return;
    }

    EzcomResponse resp = {0U};
    resp.id = msgId;
    resp.data = reinterpret_cast<uint8_t *>(respData);
    resp.size = respLength;
    BQS_LOG_INFO("EzcomSendResponse begin, fd=%d, msgId=%u", fd, msgId);
    int32_t ret = EzcomSendResponse(fd, &resp);
    if (ret == -EAGAIN) {
        // just retry one times
        ret = EzcomSendResponse(fd, &resp);
        BQS_LOG_INFO("Need to retry ezcom send, fd=%d, msgId=%u", fd, msgId);
    }
    if (ret != 0) {
        BQS_LOG_ERROR("EzcomSendResponse end, fd=%d, msgId=%u, result=failed, ret=%d", fd, msgId, ret);
    } else {
        BQS_LOG_INFO("EzcomSendResponse end, fd=%d, msgId=%u, result=success", fd, msgId);
    }

    delete[] respData;
    StatisticManager::GetInstance().ResponseStat();
    return;
}

/**
 * Bqs server bind message processing function
 * @return NA
 */
void BqsServer::ParseBindMsg(BQSMsg &requestMsg, BQSMsg &responseMsg) const
{
    BQS_LOG_INFO("Bind relation [add], stage [server:process], type [request], msg [id:%u].", msgId_);
    BQSBindQueueMsgs * const bindQueueMsgs = requestMsg.mutable_bind_queue_msgs();

    BQSBindQueueRsps * const bqsBindQueueRspBuff = responseMsg.mutable_resp_msgs();
    auto &relationInstance = BindRelation::GetInstance();

    const uint32_t vecSize = static_cast<uint32_t>(bindQueueMsgs->bind_queue_vec_size());
    for (uint32_t i = 0U; i < vecSize; i++) {
        const BQSBindQueueMsg bindQueueMsg = bindQueueMsgs->bind_queue_vec(static_cast<int32_t>(i));
        const uint32_t srcQid = bindQueueMsg.src_queue_id();
        const uint32_t dstQid = bindQueueMsg.dst_queue_id();

        // add bind relation
        EntityInfo src(srcQid, deviceId_);
        EntityInfo dst(dstQid, deviceId_);
        int32_t result = BQS_STATUS_OK;
        // halQueueAttach third para 0 means attach without block
        auto drvRet = halQueueAttach(deviceId_, srcQid, 0);
        drvRet = (drvRet == DRV_ERROR_NONE) ? halQueueAttach(deviceId_, dstQid, 0) : drvRet;
        if (drvRet == DRV_ERROR_NONE) {
            result = relationInstance.Bind(src, dst);
        } else {
            BQS_LOG_ERROR("Fail to attach src queue[%u] or dst queue[%u], result[%d]", srcQid, dstQid, drvRet);
            result = BQS_STATUS_DRIVER_ERROR;
        }
        BQSBindQueueRsp * const bqsBindQueueInfo = bqsBindQueueRspBuff->add_bind_result_vec();
        bqsBindQueueInfo->set_bind_result(result);
        BQS_LOG_RUN_INFO("Bind relation [add], stage [server:process], relation [srcQid:%u, dstQid:%u, result:%d]",
            srcQid, dstQid, result);
    }
    relationInstance.Order();
    return;
}

/**
 * Bqs server unbind message processing function
 * @return unbind result, BQS_STATUS_OK:success other:failed
 */

int32_t BqsServer::UnbindRelation(BindRelation &relationInstance,
    const BQSQueryMsg::QsQueryType &queryType, EntityInfo &srcId, EntityInfo &dstId) const
{
    int32_t result = BQS_STATUS_INNER_ERROR;
    switch (queryType) {
        case BQSQueryMsg::BQS_QUERY_TYPE_SRC:
            result = relationInstance.UnBindBySrc(srcId);
            BQS_LOG_RUN_INFO("Bind relation [del], stage [server:process], relation [query type:src, src = %u, "
                "result = %d]", srcId.GetId(), result);
            break;
        case BQSQueryMsg::BQS_QUERY_TYPE_DST:
            result = relationInstance.UnBindByDst(dstId);
            BQS_LOG_RUN_INFO(
                "Bind relation [del], stage [server:process], relation [query type:dst, dst:%u, result:%d]",
                dstId.GetId(), result);
            break;
        case BQSQueryMsg::BQS_QUERY_TYPE_SRC_AND_DST:
            result = relationInstance.UnBind(srcId, dstId);
            BQS_LOG_RUN_INFO(
                "Bind relation [del], stage [server:process], relation [query type:src-dst, src:%u, dst:%u, result:%d]",
                srcId.GetId(), dstId.GetId(), result);
            break;
        default:
            BQS_LOG_ERROR("BqsServer unbind error, unsupported query type{0:src, 1:dst, 2:src-dst}:%d", queryType);
            break;
    }
    return result;
}

/**
 * Bqs server unbind message processing function
 * @return NA
 */
void BqsServer::ParseUnbindMsg(BQSMsg &requestMsg, BQSMsg &responseMsg) const
{
    BQS_LOG_INFO("Bind relation [del], stage [server:process], type [request], msg [id = %u].", msgId_);
    BQSQueryMsgs * const bqsQueryMsgBuff = requestMsg.mutable_query_msgs();

    BQSBindQueueRsps * const bqsBindQueueRspBuff = responseMsg.mutable_resp_msgs();

    auto &relationInstance = BindRelation::GetInstance();

    for (int32_t i = 0; i < bqsQueryMsgBuff->query_msg_vec_size(); i++) {
        BQSQueryMsg bqsQueryInfo = bqsQueryMsgBuff->query_msg_vec(i);
        const BQSQueryMsg::QsQueryType keyType = bqsQueryInfo.key_type();
        BQSBindQueueMsg * const bindQueueinfo = bqsQueryInfo.mutable_bind_queue_item();

        const uint32_t srcQid = bindQueueinfo->src_queue_id();
        const uint32_t dstQid = bindQueueinfo->dst_queue_id();
        EntityInfo src(srcQid, deviceId_);
        EntityInfo dst(dstQid, deviceId_);

        // delete bind relation
        const int32_t result = UnbindRelation(relationInstance, keyType, src, dst);

        BQSBindQueueRsp * const relationProcessRsp = bqsBindQueueRspBuff->add_bind_result_vec();
        relationProcessRsp->set_bind_result(result);
    }

    relationInstance.Order();
    return;
}

/**
 * Assembly response of get bind message according to src queueId
 * @return NA
 */
void BqsServer::SerializeGetBindRspBySrc(const uint32_t srcId, BQSMsg &responseMsg) const
{
    BQS_LOG_INFO("BqsServer serialize get bind rsponse by src begin, srcId:%u", srcId);
    const EntityInfo src(srcId, deviceId_);
    auto &relationInstance = BindRelation::GetInstance();

    // Find all dst queue id who has subscribed to the src queue id
    auto &srcToDstRelation = relationInstance.GetSrcToDstRelation();
    const auto iter = srcToDstRelation.find(src);

    const auto &abnormalSrcToDstRelation = relationInstance.GetAbnormalSrcToDstRelation();
    const auto abnormalIter = abnormalSrcToDstRelation.find(src);
    if (iter == srcToDstRelation.end() && abnormalIter == abnormalSrcToDstRelation.end()) {
        BQS_LOG_WARN("BqsServer get relation according to src:%u failed, record does not exist", src.GetId());
        return;
    }

    BQSBindQueueMsgs * const bqsBindQueueMsgBuff = responseMsg.mutable_bind_queue_msgs();
    if (iter != srcToDstRelation.end()) {
        FillGetBindRspBySrc(srcId, iter->second, false, bqsBindQueueMsgBuff);
    }
    if (abnormalIter != abnormalSrcToDstRelation.end()) {
        FillGetBindRspBySrc(srcId, abnormalIter->second, true, bqsBindQueueMsgBuff);
    }
}

/**
 * Fill getBind response by src and dstSet, one-to-one relation
 * @return NA
 */
void BqsServer::FillGetBindRspBySrc(const uint32_t srcId, const std::unordered_set<EntityInfo, EntityInfoHash> &dstSet,
    bool isAbnormal, BQSBindQueueMsgs *const bqsBindQueueMsgBuff) const
{
    BQS_LOG_INFO("Bind relation [get], stage [server:process], relation [size:%zu].", dstSet.size());
    int32_t i = 0;
    for (auto setIter = dstSet.begin(); setIter != dstSet.end(); ++setIter) {
        BQSBindQueueMsg * const bqsBindQueueInfo = bqsBindQueueMsgBuff->add_bind_queue_vec();
        bqsBindQueueInfo->set_src_queue_id(srcId);
        const EntityInfo dstQ = *setIter;
        bqsBindQueueInfo->set_dst_queue_id(dstQ.GetId());
        ++i;
        BQS_LOG_INFO(
            "Bind relation [get], stage [server:process], relation [abnormal:%d, index:%d, src:%u, dst:%u]",
            static_cast<int32_t>(isAbnormal), i, srcId, dstQ.GetId());
    }
}

/**
 * Assembly response of get bind message according to dst queueId, one-to-one relation
 * @return NA
 */
void BqsServer::SerializeGetBindRspByDst(const uint32_t dstId, BQSMsg &responseMsg) const
{
    BQS_LOG_INFO("BqsServer serialize get bind rsponse by dst begin, dstId:%u", dstId);
    auto &relationInstance = BindRelation::GetInstance();
    const EntityInfo dst(dstId, deviceId_);

    auto &dstToSrcRelation = relationInstance.GetDstToSrcRelation();
    const auto iter = dstToSrcRelation.find(dst);

    const auto &abnormalDstToSrcRelation = relationInstance.GetAbnormalDstToSrcRelation();
    const auto abnormalIter = abnormalDstToSrcRelation.find(dst);
    if ((iter == dstToSrcRelation.end()) && (abnormalIter == abnormalDstToSrcRelation.end())) {
        BQS_LOG_WARN("BqsServer get relation according to dst:%u failed, record does not exist", dstId);
        return;
    }

    BQSBindQueueMsgs * const bqsBindQueueMsgBuff = responseMsg.mutable_bind_queue_msgs();
    if (iter != dstToSrcRelation.end()) {
        FillGetBindRspByDst(iter->second, dstId, false, bqsBindQueueMsgBuff);
    }
    if (abnormalIter != abnormalDstToSrcRelation.end()) {
        FillGetBindRspByDst(abnormalIter->second, dstId, true, bqsBindQueueMsgBuff);
    }
}

/**
 * Fill getBind response by srcSet and dst, one-to-one relation
 * @return NA
 */
void BqsServer::FillGetBindRspByDst(const std::unordered_set<EntityInfo, EntityInfoHash> &srcSet, const uint32_t dstId,
    bool isAbnormal, BQSBindQueueMsgs *const bqsBindQueueMsgBuff) const
{
    BQS_LOG_INFO("Bind relation [get], stage [server:process], relation [size:%zu].", srcSet.size());
    int32_t i = 0;
    for (auto setIter = srcSet.begin(); setIter != srcSet.end(); ++setIter) {
        BQSBindQueueMsg * const bqsBindQueueInfo = bqsBindQueueMsgBuff->add_bind_queue_vec();
        bqsBindQueueInfo->set_src_queue_id(setIter->GetId());
        bqsBindQueueInfo->set_dst_queue_id(dstId);
        ++i;
        BQS_LOG_INFO("Bind relation [get], stage [server:process], relation [abnormal:%d, index:%d, src:%u, dst:%u]",
            static_cast<int32_t>(isAbnormal), i, setIter->GetId(), dstId);
    }
}

/**
 * Assembly response of get bind message
 * @return NA
 */
void BqsServer::SerializeGetBindRsp(
    const BQSQueryMsg::QsQueryType &queryType, const uint32_t srcId, const uint32_t dstId, BQSMsg &responseMsg) const
{
    switch (queryType) {
        case BQSQueryMsg::BQS_QUERY_TYPE_SRC:
            SerializeGetBindRspBySrc(srcId, responseMsg);
            break;
        case BQSQueryMsg::BQS_QUERY_TYPE_DST:
            SerializeGetBindRspByDst(dstId, responseMsg);
            break;
        default:
            BQS_LOG_ERROR("BqsServer get bind error, unsupported query type{0:src, 1:dst, 2:src-dst}:%d", queryType);
            break;
    }
    return;
}

/**
 * Bqs server get bind message processing function
 * @return NA
 */
void BqsServer::ParseGetBindMsg(BQSMsg &requestMsg, BQSMsg &responseMsg) const
{
    BQS_LOG_INFO("Bind relation [get], stage [server:process], type [request], msg [id:%u].", msgId_);
    BQSQueryMsg * const bqsQueryInfo = requestMsg.mutable_query_msg();

    const BQSQueryMsg::QsQueryType keyType = bqsQueryInfo->key_type();
    BQSBindQueueMsg * const bqsBindQueueInfo = bqsQueryInfo->mutable_bind_queue_item();

    const uint32_t src = bqsBindQueueInfo->src_queue_id();
    const uint32_t dst = bqsBindQueueInfo->dst_queue_id();

    SerializeGetBindRsp(keyType, src, dst, responseMsg);
    return;
}

/**
 * Bqs server get paged bind message processing function
 * @return NA
 */
void BqsServer::ParseGetPagedBindMsg(BQSMsg &requestMsg, BQSMsg &responseMsg) const
{
    BQS_LOG_INFO("Bind relation [get_all], stage [server:process], type [request], msg [id:%u].", msgId_);
    BQSBindQueueMsgs * const bqsBindQueueMsgBuff = responseMsg.mutable_bind_queue_msgs();

    BQSPagedMsg * const pagedMsg = requestMsg.mutable_paged_msg();

    BQSPagedMsg * const pagedRspMsg = responseMsg.mutable_paged_msg();

    auto &relationInstance = BindRelation::GetInstance();

    static std::vector<std::tuple<uint32_t, uint32_t>> relations;
    static uint32_t offsetSave = 0U;
    static uint32_t total = 0U;
    const uint32_t msgOffset = pagedMsg->offset();
    if ((msgOffset == 0U) || (msgOffset < offsetSave) || relations.empty()) {
        auto &srcToDstRelation = relationInstance.GetSrcToDstRelation();
        RelationsCopy(relations, total, srcToDstRelation);
        AppendRelations(relations, relationInstance.GetAbnormalSrcToDstRelation());
        offsetSave = msgOffset;
        total = static_cast<uint32_t>(relations.size());
    }
    pagedRspMsg->set_total(total);
    const uint32_t offset = (msgOffset > total) ? total : msgOffset;
    const uint32_t limit = pagedMsg->limit();

    // get bind relation
    uint32_t i = 0U;
    auto iter = relations.begin();
    BQS_LOG_INFO("Bind relation [get_paged], stage [server:process], relation [offset:%u, limit:%u, size:%u]",
        pagedMsg->offset(),
        limit,
        total);
    std::advance(iter, offset);
    while ((iter != relations.end()) && (i < limit)) {
        const uint32_t srcId = std::get<0>(*iter);
        const uint32_t dstId = std::get<1>(*iter);
        BQSBindQueueMsg * const bqsBindQueueInfo = bqsBindQueueMsgBuff->add_bind_queue_vec();

        bqsBindQueueInfo->set_src_queue_id(srcId);
        bqsBindQueueInfo->set_dst_queue_id(dstId);
        ++iter;
        ++i;
    }
    return;
}

/**
 * Copy relation map to a vector container
 * @return NA
 */
void BqsServer::RelationsCopy(std::vector<std::tuple<uint32_t, uint32_t>> &relations, const uint32_t oldSize,
    const std::unordered_map<EntityInfo, std::unordered_set<EntityInfo, EntityInfoHash>, EntityInfoHash> &srcMap) const
{
    relations.clear();
    if (oldSize != 0U) {
        relations.reserve(static_cast<std::vector<std::tuple<uint32_t, uint32_t>>::size_type>(oldSize));
    }
    for (const auto &iter : srcMap) {
        (void) std::transform(iter.second.begin(), iter.second.end(), std::back_inserter(relations),
                              [&](const EntityInfo entityInfo) {
                                  return std::make_pair(iter.first.GetId(), entityInfo.GetId());
                              });
    }
}

/**
 * append relations to a vector container
 * @return NA
 */
void BqsServer::AppendRelations(std::vector<std::tuple<uint32_t, uint32_t>> &relations,
    const std::unordered_map<EntityInfo, std::unordered_set<EntityInfo, EntityInfoHash>, EntityInfoHash> &srcMap) const
{
    for (const auto &iter : srcMap) {
        (void) std::transform(iter.second.begin(), iter.second.end(), std::back_inserter(relations),
                              [&](const EntityInfo entityInfo) {
                                  return std::make_pair(iter.first.GetId(), entityInfo.GetId());
                              });
    }
}

}  // namespace bqs