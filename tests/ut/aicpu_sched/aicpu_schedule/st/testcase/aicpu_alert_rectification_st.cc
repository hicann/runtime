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
#include "operator_kernel_common.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "ts_api.h"

#define private public
#include "aicpusd_cust_dump_process.h"
#undef private

using namespace AicpuSchedule;
using namespace aicpu;

class AicpuAlertRectificationSt : public ::testing::Test {
public:
    virtual void SetUp() {}
    virtual void TearDown() {}
};

/* ProfModelMessage::ReportProfModelMessage should be callable */
TEST_F(AicpuAlertRectificationSt, ReportProfModelMessageIntegrationTest)
{
    aicpu::ProfModelMessage profModelMessage("AICPU_MODEL");
    int32_t ret = profModelMessage.ReportProfModelMessage();
    EXPECT_EQ(ret, 0);
}

/* G.CNS.03: TaskQueueMgr::OnPreprocessEvent should be callable on const object */
TEST_F(AicpuAlertRectificationSt, OnPreprocessEventConstIntegrationTest)
{
    const DataPreprocess::TaskQueueMgr& mgr = DataPreprocess::TaskQueueMgr::GetInstance();
    mgr.OnPreprocessEvent(0);
    SUCCEED();
}

/* DumpOpInfo should accept TaskInfoExt& in integration (non-const, modifies indexId_) */
TEST_F(AicpuAlertRectificationSt, DumpOpInfoTaskInfoExtIntegrationTest)
{
    TaskInfoExt dumpTaskInfo;
    dumpTaskInfo.streamId_ = 1;
    dumpTaskInfo.taskId_ = 2;
    dumpTaskInfo.contextId_ = INVALID_VAL;
    dumpTaskInfo.threadId_ = INVALID_VAL;
    DumpFileName dumpFileName(1, 2);
    int32_t ret = OpDumpTaskManager::GetInstance().DumpOpInfo(dumpTaskInfo, dumpFileName);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

/* G.CNS.04: TraceQueueData should accept const void* in integration */
TEST_F(AicpuAlertRectificationSt, TraceQueueDataConstVoidPtrIntegrationTest)
{
    uint8_t buffer[256] = {0};
    const void* headBuf = static_cast<const void*>(buffer);
    RunContext taskContext = {};
    OperatorKernelCommon::TraceQueueData(taskContext, headBuf, 256, "Enqueued");
    SUCCEED();
}

/* G.CNS.04: BackupHeadMsg should accept const void* in integration */
TEST_F(AicpuAlertRectificationSt, BackupHeadMsgConstVoidPtrIntegrationTest)
{
    const void* headBuf = nullptr;
    auto result = OperatorKernelCommon::BackupHeadMsg(headBuf, 256, "Enqueued");
    EXPECT_EQ(result, nullptr);
}

/* G.EXP.03: ProfIdentity struct usage in integration */
TEST_F(AicpuAlertRectificationSt, ProfIdentityStructIntegrationTest)
{
    ProfIdentity profIdentity = {100, 200, 1, 0};
    EXPECT_EQ(profIdentity.taskId, 100UL);
    EXPECT_EQ(profIdentity.streamId, 200UL);
    EXPECT_EQ(profIdentity.threadIndex, 1U);
    EXPECT_EQ(profIdentity.deviceId, 0U);
}

/* G.ENU.01: enum class TaskEventID scoped enum in integration */
TEST_F(AicpuAlertRectificationSt, TaskEventIDScopedEnumIntegrationTest)
{
    DataPreprocess::TaskEventID lowId = DataPreprocess::TaskEventID::TASK_QUEUE_LOW_EVENT_ID;
    DataPreprocess::TaskEventID highId = DataPreprocess::TaskEventID::TASK_QUEUE_HIGH_EVENT_ID;
    EXPECT_NE(static_cast<int>(lowId), static_cast<int>(highId));
}
