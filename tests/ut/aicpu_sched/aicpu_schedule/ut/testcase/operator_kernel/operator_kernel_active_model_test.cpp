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
#include "aicpusd_status.h"
#include "aicpusd_msg_send.h"
#include "aicpusd_info.h"
#include "operator_kernel_active_model.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;

namespace {
uint32_t g_activeModelEventModelId = 0U;

int32_t SendAICPUSubEventFake(
    const char_t* const msg, const uint32_t msgLen, const uint32_t subEventId, const uint32_t grpId,
    const bool syncSendFlag)
{
    (void)msgLen;
    (void)subEventId;
    (void)grpId;
    (void)syncSendFlag;
    const AICPUSubEventInfo* const info = PtrToPtr<const char_t, const AICPUSubEventInfo>(msg);
    g_activeModelEventModelId = info->modelId;
    return AICPU_SCHEDULE_OK;
}
} // namespace

class OperatorKernelActiveModelTest : public OperatorKernelTest {
protected:
    OperatorKernelActiveModel activeModelKernel_;
};

TEST_F(OperatorKernelActiveModelTest, ModelActiveModelExecute_success)
{
    AicpuTaskInfo taskT;
    uint32_t modelID = 0;
    taskT.paraBase = (uint64_t)&modelID;
    int ret = activeModelKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelActiveModelTest, ModelActiveModelExecute_failed_for_nullPara)
{
    AicpuTaskInfo taskT;
    uint32_t modelID = 0;
    taskT.paraBase = (uint64_t) nullptr;
    int ret = activeModelKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelActiveModelTest, ModelActiveModelExecute_modelIdMismatch_useParaBase)
{
    AicpuTaskInfo taskT;
    uint32_t modelID = 5U; // mismatch with runContextT.modelId
    taskT.paraBase = (uint64_t)&modelID;
    MOCKER_CPP(&AicpuMsgSend::SendAICPUSubEvent).stubs().will(invoke(SendAICPUSubEventFake));
    g_activeModelEventModelId = 0U;
    int ret = activeModelKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(g_activeModelEventModelId, 5U);
}