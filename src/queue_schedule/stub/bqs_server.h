/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef BQS_STUB_SERVER_H
#define BQS_STUB_SERVER_H
#include <string>
#include "bqs_log.h"
#include "bqs_msg.h"
#include "bqs_status.h"

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
         * Bqs server enqueue bind msg request process
         * @return NA
         */
        void BindMsgProc();

    private:
        BqsServer();

        ~BqsServer();
    };
}      // namespace bqs
#endif  // BQS_STUB_SERVER_H