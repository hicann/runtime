/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "profiling_adp.h"
#include "aicpu_engine.h"
#include "ascend_hal.h"
#include "task_queue.h"
#include "dump_task.h"
#include "aicpusd_status.h"
#include "aicpu_async_event.h"
#include "aicpusd_mpi_mgr.h"
#include "aicpusd_task_queue.h"
#include "aicpusd_queue_event_process.h"
#include "tdt/status.h"
#include "tsd.h"
#include "common/type_def.h"
#include "aicpusd_common.h"
#include "ts_api.h"
#include "gtest/gtest.h"

#define private public
#include "aicpusd_cust_dump_process.h"
#undef private

using namespace AicpuSchedule;
using namespace aicpu;

/* ReportProfModelMessage should be callable */
TEST(AicpuAlertRectificationStubTest, ReportProfModelMessageTest)
{
    aicpu::ProfModelMessage profModelMessage("AICPU_MODEL");
    int32_t ret = profModelMessage.ReportProfModelMessage();
    EXPECT_EQ(ret, 0);
}

/* G.CNS.03: OnPreprocessEvent should be callable on const object */
TEST(AicpuAlertRectificationStubTest, OnPreprocessEventConstTest)
{
    const DataPreprocess::TaskQueueMgr& mgr = DataPreprocess::TaskQueueMgr::GetInstance();
    mgr.OnPreprocessEvent(0);
    SUCCEED();
}

/* G.CNS.04: tsDevSendMsgAsync should accept nullptr */
TEST(AicpuAlertRectificationStubTest, TsDevSendMsgAsyncNullptrTest)
{
    int ret = tsDevSendMsgAsync(0, 0, nullptr, 0, 0);
    EXPECT_EQ(ret, 0);
}

/* G.FUN.02: CreateOrFindCustPid should accept const char* const groupNameList */
TEST(AicpuAlertRectificationStubTest, CreateOrFindCustPidConstPointerTest)
{
    const char* const groupNameList = "test_group";
    int32_t custProcPid = 0;
    bool firstStart = false;
    int32_t ret = CreateOrFindCustPid(0, 0, nullptr, 0, 0, groupNameList, 0, &custProcPid, &firstStart);
    EXPECT_EQ(ret, 0);
}

/* G.CNS.04: DoUdfDatadumpSubmitEventSync should accept const event_proc_result* rsp */
TEST(AicpuAlertRectificationStubTest, DoUdfDatadumpSubmitEventSyncConstRspTest)
{
    AicpuSdCustDumpProcess& proc = AicpuSdCustDumpProcess::GetInstance();
    char msgBuf[256] = {0};
    const char_t* const msg = msgBuf;
    struct event_proc_result rsp = {};
    const struct event_proc_result* const rspPtr = &rsp;
    int32_t ret = proc.DoUdfDatadumpSubmitEventSync(msg, sizeof(msgBuf), rspPtr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

/* G.ENU.01: enum class TaskEventID should be scoped */
TEST(AicpuAlertRectificationStubTest, TaskEventIDScopedEnumTest)
{
    DataPreprocess::TaskEventID lowId = DataPreprocess::TaskEventID::TASK_QUEUE_LOW_EVENT_ID;
    DataPreprocess::TaskEventID highId = DataPreprocess::TaskEventID::TASK_QUEUE_HIGH_EVENT_ID;
    EXPECT_NE(lowId, highId);
    EXPECT_EQ(static_cast<int>(lowId), 1);
    EXPECT_EQ(static_cast<int>(highId), 2);
}

/* G.EXP.03: ProfIdentity should be usable as a struct (not typedef) */
TEST(AicpuAlertRectificationStubTest, ProfIdentityStructTest)
{
    ProfIdentity profIdentity = {1, 2, 3, 4};
    EXPECT_EQ(profIdentity.taskId, 1UL);
    EXPECT_EQ(profIdentity.streamId, 2UL);
    EXPECT_EQ(profIdentity.threadIndex, 3U);
    EXPECT_EQ(profIdentity.deviceId, 4U);
}
