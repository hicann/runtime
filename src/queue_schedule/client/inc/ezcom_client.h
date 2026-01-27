/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_SCHEDULE_EZCOM_CLIENT_H
#define QUEUE_SCHEDULE_EZCOM_CLIENT_H

#include <vector>
#include <atomic>

#include "proto/easycom_message.pb.h"
#include "qs_client.h"
#include "bqs_status.h"

namespace bqs {
class EzcomClient {
public:
    static EzcomClient *GetInstance(const int32_t fd);

    EzcomClient(const EzcomClient &) = delete;

    EzcomClient(EzcomClient &&) = delete;

    EzcomClient &operator=(const EzcomClient &) = delete;

    EzcomClient &operator=(EzcomClient &&) = delete;

    /**
     * Send BQSMsg message to server
     * @return BQS_STATUS_OK: success, other: error
     */
    BqsStatus SendBqsMsg(const BQSMsg &bqsReqMsg, BQSMsg &bqsRespMsg) const;

    /**
     * Assembly bind BQSMsg message
     * @return BQS_STATUS_OK: success, other: error
     */
    BqsStatus SerializeBindMsg(const std::vector<BQSBindQueueItem> &bindQueueVec, BQSMsg &bqsClientMsg) const;

    /**
     * Parse bind response BQSMsg message
     * @return number of bind relation success
     */
    uint32_t ParseBindRespMsg(BQSMsg &bqsRespMsg, std::vector<BQSBindQueueResult> &bindResultVec) const;

    /**
     * Assembly unbind BQSMsg message
     * @return BQS_STATUS_OK: success, other: failed
     */
    BqsStatus SerializeUnbindMsg(const std::vector<BQSQueryPara> &bqsQueryParaVec, BQSMsg &bqsClientMsg) const;

    /**
     * Assembly get bind BQSMsg message
     * @return BQS_STATUS_OK: success, other: failed
     */
    BqsStatus SerializeGetBindMsg(const BQSQueryPara &queryPara, BQSMsg &bqsClientMsg) const;

    /**
     * Parse get bind response BQSMsg message
     * @return number of bind relation
     */
    uint32_t ParseGetBindRespMsg(BQSMsg &bqsRespMsg, std::vector<BQSBindQueueItem> &bindQueueVec) const;

    /* *
    * Assembly get paged bind BQSMsg message
    * @return BQS_STATUS_OK: success, other: failed
    */
    BqsStatus SerializeGetPagedBindMsg(const uint32_t offset, const uint32_t limit, BQSMsg &bqsClientMsg) const;

    /**
     * Parse get paged bind response BQSMsg message
     * @return number of bind relation
     */
    uint32_t ParseGetPagedBindRespMsg(BQSMsg &bqsRespMsg,
        std::vector<BQSBindQueueItem> &bindQueueVec, uint32_t &total) const;

private:
    EzcomClient() = default;

    ~EzcomClient() = default;

private:
    static int32_t clientFd_;
    static std::atomic<bool> initFlag_;
};
}       // namespace bqs
#endif  // QUEUE_SCHEDULE_EZCOM_CLIENT_H
