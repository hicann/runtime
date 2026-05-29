/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"

#include "bqs_server.h"
#include "qs_tsd.h"

using namespace bqs;

namespace {

TEST(QueueScheduleStubUtest, BqsServerStubFunctions)
{
    BqsServer &server = BqsServer::GetInstance();
    EXPECT_EQ(&server, &BqsServer::GetInstance());
    EXPECT_EQ(server.InitBqsServer("stub_group", 7U), BQS_STATUS_OK);
    server.BindMsgProc();
}

TEST(QueueScheduleStubUtest, TsdStubFunctions)
{
    SubProcEventCallBackInfo regInfo {};
    regInfo.eventType = TSD_EVENT_START_QS_MODULE;
    regInfo.callBackFunc = nullptr;

    EXPECT_EQ(RegEventMsgCallBackFunc(&regInfo), 0);
    UnRegEventMsgCallBackFunc(TSD_EVENT_START_QS_MODULE);
    EXPECT_EQ(TsdWaitForShutdown(0U, TSD_QS, 1U, 2U), 0);
    EXPECT_EQ(TsdReportStartOrStopErrCode(0U, TSD_QS, 1U, 2U, "err", 3U), 0);
    EXPECT_EQ(SubModuleProcessResponse(0U, TSD_QS, 1U, 2U, TSD_EVENT_START_QS_MODULE_RSP), 0);
    EXPECT_EQ(TsdDestroy(0U, TSD_QS, 1U, 2U), 0);
}

}  // namespace
