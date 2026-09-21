/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "operator_kernel_common.h"
#include "dump_task.h"
#include "aicpusd_status.h"
#include "common/type_def.h"
#include "aicpusd_common.h"

using namespace AicpuSchedule;

/* DumpOpInfo should accept TaskInfoExt& (non-const, modifies indexId_) */
TEST(AicpuAlertRectificationTest, DumpOpInfoTaskInfoExtTest)
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

/* DumpOpInfo 5-param should accept TaskInfoExt& */
TEST(AicpuAlertRectificationTest, DumpOpInfo5ParamTaskInfoExtTest)
{
    TaskInfoExt dumpTaskInfo;
    dumpTaskInfo.streamId_ = 1;
    dumpTaskInfo.taskId_ = 2;
    dumpTaskInfo.contextId_ = 3;
    dumpTaskInfo.threadId_ = 4;
    int32_t ret = OpDumpTaskManager::GetInstance().DumpOpInfo(dumpTaskInfo, 1, 2, 3, 4);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

/* G.CNS.04: TraceQueueData should accept const void* headBuf */
TEST(AicpuAlertRectificationTest, TraceQueueDataConstVoidPtrTest)
{
    const void* headBuf = nullptr;
    RunContext taskContext = {};
    OperatorKernelCommon::TraceQueueData(taskContext, headBuf, 256, "Dequeued");
    SUCCEED();
}

/* G.CNS.04: BackupHeadMsg should accept const void* headBuf */
TEST(AicpuAlertRectificationTest, BackupHeadMsgConstVoidPtrTest)
{
    const void* headBuf = nullptr;
    auto result = OperatorKernelCommon::BackupHeadMsg(headBuf, 256, "Enqueued");
    EXPECT_EQ(result, nullptr);
}

/* G.CNS.04: TraceQueueData with valid const buffer should work */
TEST(AicpuAlertRectificationTest, TraceQueueDataConstBufferTest)
{
    uint8_t buffer[256] = {0};
    const void* headBuf = static_cast<const void*>(buffer);
    RunContext taskContext = {};
    OperatorKernelCommon::TraceQueueData(taskContext, headBuf, 256, "Enqueued");
    SUCCEED();
}
