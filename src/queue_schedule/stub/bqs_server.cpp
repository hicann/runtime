/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "bqs_server.h"

namespace bqs {

BqsServer::BqsServer()
{}

BqsServer::~BqsServer()
{}

BqsServer &BqsServer::GetInstance()
{
    static BqsServer instance;
    return instance;
}


/**
 * Bqs server enqueue bind msg request process
 * @return NA
 */
void BqsServer::BindMsgProc()
{
    BQS_LOG_INFO("BqsServer BindMsgProc begin");
    BQS_LOG_INFO("BqsServer BindMsgProc end");
    return;
}

/**
 * Init bqs server, including init easycomm server and bind relation
 * @return BQS_STATUS_OK:success other:failed
 */
BqsStatus BqsServer::InitBqsServer(const std::string &qsInitGrpName, const uint32_t deviceId)
{
    BQS_LOG_INFO("BqsServer Init begin");
    BQS_LOG_INFO("BqsServer Init success qsInitGrpName[%s] deviceId[%u]", qsInitGrpName.c_str(), deviceId);
    return BQS_STATUS_OK;
}
} // namespace bqs
