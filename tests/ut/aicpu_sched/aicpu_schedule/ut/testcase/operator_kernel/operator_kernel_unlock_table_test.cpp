/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <vector>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "aicpusd_common.h"
#define private public
#include "aicpusd_model.h"
#include "aicpusd_resource_manager.h"
#include "operator_kernel_unlock_table.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_common.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;

class OperatorKernelUnlockTableTest : public OperatorKernelTest {
protected:
    OperatorKernelUnlockTable kernel_;
};

TEST_F(OperatorKernelUnlockTableTest, ModelUnlockTable_fail_MissingParam)
{
    AicpuTaskInfo taskT = {};
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelUnlockTableTest, ModelUnlockTable_fail_MissingModel)
{
    AicpuTaskInfo taskT;
    UnlockTableTaskParam unLockParam = {};
    unLockParam.tableId = 0U;
    taskT.paraBase = PtrToValue(&unLockParam);
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(OperatorKernelUnlockTableTest, ModelUnlockTable_success_noLock)
{
    AicpuTaskInfo taskT;
    UnlockTableTaskParam unLockParam = {};
    unLockParam.tableId = 0U;
    taskT.paraBase = PtrToValue(&unLockParam);

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelUnlockTableTest, ModelUnlockTable_success)
{
    uint32_t tableId = 0U;
    AicpuTaskInfo taskT;
    UnlockTableTaskParam unLockParam = {};
    unLockParam.tableId = tableId;
    taskT.paraBase = PtrToValue(&unLockParam);

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    TableLockManager::GetInstance().RdLockTable(tableId);
    aicpuModel.RecordLockedTable(tableId);

    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}