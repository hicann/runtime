/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "qs_client.h"

#include <chrono>
#include <thread>
#include "proto/easycom_message.pb.h"
#include "easy_comm.h"

#include "bqs_log.h"
#include "ezcom_client.h"
#include "bqs_feature_ctrl.h"

namespace {
const uint32_t MAX_PAGED_BIND_RELATION = 450U;
const int32_t CONNECT_WAIT_TIME_OUT = 10000; // 10s
const uint32_t MAX_CONNECT_CALL_TIMES = 100U;
const uint32_t TIMEOUT_CONNECT_CALL_TIMES = 10U;
const uint32_t CONNECT_CALL_TIME_INTERVAL = 100U; // 100ms
using MsgHandler = void (*)(int fd, struct EzcomRequest *req);
const uint32_t MAX_PAGED_QUEUE_RELATION = 300U;
const int32_t EZCOMSERVER_NOT_START = -2;
}

namespace bqs {
std::mutex BqsClient::mutex_;
int32_t BqsClient::clientFd_(-1);
bool BqsClient::initFlag_(false);

BqsClient::BqsClient() {}

BqsClient::~BqsClient()
{
    BQS_LOG_INFO("BqsClient release");
    const std::unique_lock<std::mutex> bqsLock(mutex_);
    if (clientFd_ >= 0) {
        BQS_LOG_INFO("EzcomClosePipe begin");
        (void)EzcomClosePipe(clientFd_);
        clientFd_ = -1;
    }
}

int32_t BqsClient::Destroy() const
{
    BQS_LOG_INFO("Destroy begin");
    int32_t ret = 0;

    const std::unique_lock<std::mutex> bqsLock(mutex_);
    if (clientFd_ >= 0) {
        BQS_LOG_INFO("EzcomClosePipe begin");
        ret = EzcomClosePipe(clientFd_);
        clientFd_ = -1;
    }

    initFlag_ = false;
    return ret;
}

/**
 * Create instance of BqsClient.
 * @return BqsClient*: success, nullptr: error
 */
BqsClient *BqsClient::GetInstance(const char_t * const serverProcName,
    const uint32_t procNameLen, const ExeceptionCallback fn)
{
    if (serverProcName == nullptr) {
        BQS_LOG_ERROR("BqsClient make instance failed, server name is null");
        return nullptr;
    }
    std::string serverProcNameTmp;
    if (FeatureCtrl::IsAosCore()) {
        serverProcNameTmp = AOSCORE_PREFIX + serverProcName;
    } else {
        serverProcNameTmp = serverProcName;
    }

    BQS_LOG_INFO("BqsClient GetInstance begin");
    {
        const std::unique_lock<std::mutex> bqsLock(mutex_);
        if (!initFlag_) {
            BQS_LOG_RUN_INFO("BqsClient EzcomCreateClient begin, server name:%s, serverCreateTryTime:%u",
                             serverProcNameTmp.c_str(), MAX_CONNECT_CALL_TIMES);
            uint32_t connectTime = 1U;
            uint32_t serverCreateTryTime = 1U;
            struct EzcomAttr clientAttr;
            clientAttr.handler = reinterpret_cast<MsgHandler>(fn);
            clientAttr.targetName = serverProcNameTmp.c_str();
            clientAttr.timeout = CONNECT_WAIT_TIME_OUT;
            clientAttr.mode = EZCOM_CLIENT;
            while (true) {
                clientFd_ = EzcomCreateClient(&clientAttr);
                if (((clientFd_ == -ENXIO) || (clientFd_ == -EAGAIN)) && (connectTime < MAX_CONNECT_CALL_TIMES)) {
                    connectTime++;
                    std::this_thread::sleep_for(std::chrono::milliseconds(CONNECT_CALL_TIME_INTERVAL));
                    continue;
                }

                if ((clientFd_ == -ETIMEDOUT) && (connectTime < TIMEOUT_CONNECT_CALL_TIMES)) {
                    connectTime++;
                    continue;
                }

                if ((clientFd_ == EZCOMSERVER_NOT_START) && (serverCreateTryTime < MAX_CONNECT_CALL_TIMES)) {
                    serverCreateTryTime++;
                    std::this_thread::sleep_for(std::chrono::milliseconds(CONNECT_CALL_TIME_INTERVAL));
                    continue;
                }

                if (clientFd_ <= 0) {
                    BQS_LOG_ERROR("EzcomTimedConnectServer failed, err:%d, connect times:%u, serverCreateTryTime:%u",
                                  clientFd_, connectTime, serverCreateTryTime);
                    return nullptr;
                }
                break;
            }

            BQS_LOG_RUN_INFO("BqsClient EzcomCreateClient success, server name:%s, connect times:%u",
                serverProcNameTmp.c_str(), connectTime);

            initFlag_ = true;
        }
    }

    static BqsClient instance;
    BQS_LOG_INFO("BqsClient GetInstance success");
    return &instance;
}

/**
 * Add bind relation, support batch bind.
 * @return Number of bind relation success, record already exists indicate successfully add
 */
uint32_t BqsClient::BindQueue(const std::vector<BQSBindQueueItem> &bindQueueVec,
    std::vector<BQSBindQueueResult> &bindResultVec) const
{
    BQS_LOG_INFO("BqsClient BindQueue begin, vector size:%zu", bindQueueVec.size());
    if (bindQueueVec.size() > MAX_PAGED_QUEUE_RELATION) {
        auto bindQueueIter = bindQueueVec.begin();
        const auto bindQueEndIter = bindQueueVec.end();
        uint32_t bindNum = 0U;
        while (bindQueueIter != bindQueEndIter) {
            auto tempBindQueEndIter = bindQueueIter + MAX_PAGED_QUEUE_RELATION;
            if (tempBindQueEndIter > bindQueEndIter) {
                tempBindQueEndIter = bindQueEndIter;
            }
            std::vector<BQSBindQueueItem> bindQueue(bindQueueIter, tempBindQueEndIter);
            std::vector<BQSBindQueueResult> bindResult;
            bindNum += DoBindQueue(bindQueue, bindResult);
            bindResultVec.insert(bindResultVec.end(), bindResult.begin(), bindResult.end());
            bindQueueIter = tempBindQueEndIter;
        }
        return bindNum;
    } else {
        return DoBindQueue(bindQueueVec, bindResultVec);
    }
}

uint32_t BqsClient::DoBindQueue(const std::vector<BQSBindQueueItem> &bindQueueVec,
    std::vector<BQSBindQueueResult> &bindResultVec) const
{
    BQS_LOG_INFO("BqsClient DoBindQueue begin, vector size:%zu", bindQueueVec.size());
    BQSMsg bqsReqMsg = {};
    BQSMsg bqsRespMsg = {};
    if (EzcomClient::GetInstance(clientFd_)->SerializeBindMsg(bindQueueVec, bqsReqMsg) != BQS_STATUS_OK) {
        return 0U;
    }

    if (EzcomClient::GetInstance(clientFd_)->SendBqsMsg(bqsReqMsg, bqsRespMsg) != BQS_STATUS_OK) {
        return 0U;
    }
    return EzcomClient::GetInstance(clientFd_)->ParseBindRespMsg(bqsRespMsg, bindResultVec);
}

/**
 * Delete bind relation, support batch unbind according to src queueId or dst queueId or src-dst queueId
 * @return Number of unbind relation success, record not exists indicate successfully delete
 */
uint32_t BqsClient::UnbindQueue(const std::vector<BQSQueryPara> &bqsQueryParaVec,
    std::vector<BQSBindQueueResult> &bindResultVec) const
{
    BQS_LOG_INFO("BqsClient UnbindQueue begin, vector size:%zu", bqsQueryParaVec.size());
    if (bqsQueryParaVec.size() > MAX_PAGED_QUEUE_RELATION) {
        auto bindQueueIter = bqsQueryParaVec.begin();
        const auto bindQueEndIter = bqsQueryParaVec.end();
        uint32_t bindNum = 0U;
        while (bindQueueIter != bindQueEndIter) {
            auto tempBindQueEndIter = bindQueueIter + MAX_PAGED_QUEUE_RELATION;
            if (tempBindQueEndIter > bindQueEndIter) {
                tempBindQueEndIter = bindQueEndIter;
            }
            std::vector<BQSQueryPara> bindQueue(bindQueueIter, tempBindQueEndIter);
            std::vector<BQSBindQueueResult> bindResult;
            bindNum += DoUnbindQueue(bindQueue, bindResult);
            bindResultVec.insert(bindResultVec.end(), bindResult.begin(), bindResult.end());
            bindQueueIter = tempBindQueEndIter;
        }
        return bindNum;
    } else {
        return DoUnbindQueue(bqsQueryParaVec, bindResultVec);
    }
}

uint32_t BqsClient::DoUnbindQueue(const std::vector<BQSQueryPara> &bqsQueryParaVec,
    std::vector<BQSBindQueueResult> &bindResultVec) const
{
    BQS_LOG_INFO("BqsClient DoUnbindQueue begin, vector size:%zu", bqsQueryParaVec.size());
    BQSMsg bqsReqMsg = {};
    BQSMsg bqsRespMsg = {};
    if (EzcomClient::GetInstance(clientFd_)->SerializeUnbindMsg(bqsQueryParaVec, bqsReqMsg) != BQS_STATUS_OK) {
        return 0U;
    }

    if (EzcomClient::GetInstance(clientFd_)->SendBqsMsg(bqsReqMsg, bqsRespMsg) != BQS_STATUS_OK) {
        return 0U;
    }
    return EzcomClient::GetInstance(clientFd_)->ParseBindRespMsg(bqsRespMsg, bindResultVec);
}

/**
 * Get bind relation, support get bind according to src queueId or dst queueId
 * @return Number of get bind relation success
 */
uint32_t BqsClient::GetBindQueue(const BQSQueryPara &queryPara, std::vector<BQSBindQueueItem> &bindQueueVec) const
{
    BQS_LOG_INFO("BqsClient GetBindQueue begin");
    BQSMsg bqsReqMsg = {};
    BQSMsg bqsRespMsg = {};
    if (EzcomClient::GetInstance(clientFd_)->SerializeGetBindMsg(queryPara, bqsReqMsg) != BQS_STATUS_OK) {
        return 0U;
    }

    if (EzcomClient::GetInstance(clientFd_)->SendBqsMsg(bqsReqMsg, bqsRespMsg) != BQS_STATUS_OK) {
        return 0U;
    }
    return EzcomClient::GetInstance(clientFd_)->ParseGetBindRespMsg(bqsRespMsg, bindQueueVec);
}

/**
 * Get paged bind relation
 * @return Number of get bind relation success
 */
uint32_t BqsClient::GetPagedBindQueue(const uint32_t offset, const uint32_t limit,
    std::vector<BQSBindQueueItem> &bindQueueVec, uint32_t &total) const
{
    BQS_LOG_INFO("BqsClient GetPagedBindQueue begin, offset:%u, limit:%u.", offset, limit);
    BQSMsg bqsReqMsg = {};
    BQSMsg bqsRespMsg = {};
    if (EzcomClient::GetInstance(clientFd_)->SerializeGetPagedBindMsg(offset, limit, bqsReqMsg) != BQS_STATUS_OK) {
        return 0U;
    }

    if (EzcomClient::GetInstance(clientFd_)->SendBqsMsg(bqsReqMsg, bqsRespMsg) != BQS_STATUS_OK) {
        return 0U;
    }
    return EzcomClient::GetInstance(clientFd_)->ParseGetPagedBindRespMsg(bqsRespMsg, bindQueueVec, total);
}

/**
 * Get all bind relation
 * @return Number of get bind relation success
 */
uint32_t BqsClient::GetAllBindQueue(std::vector<BQSBindQueueItem> &bindQueueVec) const
{
    BQS_LOG_INFO("BqsClient GetAllBindQueue begin");
    uint32_t offset = 0U;
    uint32_t total = 0U;
    do {
        std::vector<BQSBindQueueItem> pagedBindQueueVec;
        const auto getNum = GetPagedBindQueue(offset, MAX_PAGED_BIND_RELATION, pagedBindQueueVec, total);
        if (getNum == 0U) {
            break;
        }

        for (size_t i = 0U; i < pagedBindQueueVec.size(); i++) {
            bindQueueVec.emplace_back(pagedBindQueueVec[i]);
        }

        bool isOverflow = false;
        BqsCheckAssign32UAdd(offset, getNum, offset, isOverflow);
        if (isOverflow) {
            break;
        }
        BQS_LOG_INFO("BqsClient GetPagedBindQueue success, total:%u, getNum:%u, offset:%u", total, getNum, offset);
    } while (offset < total);

    return offset;
}

uint32_t BqsClient::BindQueueMbufPool(const std::vector<BQSBindQueueMbufPoolItem> &bindQueueVec,
                                      std::vector<BQSBindQueueResult> &bindResultVec) const
{
    (void)(bindQueueVec);
    (void)(bindResultVec);
    return 0;
}

uint32_t BqsClient::UnbindQueueMbufPool(const std::vector<BQSUnbindQueueMbufPoolItem> &bindQueueVec,
                             std::vector<BQSBindQueueResult> &bindResultVec) const
{
    (void)(bindQueueVec);
    (void)(bindResultVec);
    return 0;
}

uint32_t BqsClient::BindQueueInterChip(BindQueueInterChipInfo &interChipInfo) const
{
    (void)(interChipInfo);
    return 0;
}

uint32_t BqsClient::UnbindQueueInterChip(uint16_t srcQueueId) const
{
    (void)(srcQueueId);
    return 0;
}
} // namespace bqs
