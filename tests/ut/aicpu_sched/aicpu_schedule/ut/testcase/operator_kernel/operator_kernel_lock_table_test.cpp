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
#define private public
#include "aicpusd_model.h"
#include "aicpusd_resource_manager.h"
#include "operator_kernel_lock_table.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_stub.h"


using namespace AicpuSchedule;


class OperatorKernelLockTableTest : public OperatorKernelTest {
protected:
    OperatorKernelLockTable kernel_;
};

TEST_F(OperatorKernelLockTableTest, ModelLockTable_fail_MissingParam)
{
    AicpuTaskInfo taskT = {};
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelLockTableTest, ModelLockTable_fail_MissingModel)
{
    AicpuTaskInfo taskT;
    LockTableTaskParam wrLockParam = {};
    wrLockParam.lockType = 1;
    wrLockParam.tableId = 0U;
    taskT.paraBase = PtrToValue(&wrLockParam);
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(OperatorKernelLockTableTest, ModelLockTable_fail_multiTableLock)
{
    AicpuTaskInfo taskT;
    LockTableTaskParam wrLockParam = {};
    wrLockParam.lockType = 1;
    wrLockParam.tableId = 0U;
    taskT.paraBase = PtrToValue(&wrLockParam);

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    aicpuModel.SetTableTryLock(1);
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelLockTableTest, ModelLockTable_success_rdLock)
{
    AicpuTaskInfo taskT;
    LockTableTaskParam lockParam = {};
    lockParam.lockType = 0;
    lockParam.tableId = 0U;
    taskT.paraBase = PtrToValue(&lockParam);

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
    TableLockManager::GetInstance().UnLockTable(0U);
}

TEST_F(OperatorKernelLockTableTest, ModelLockTable_success_wrLock)
{
    AicpuTaskInfo taskT;
    LockTableTaskParam lockParam = {};
    lockParam.lockType = 1;
    lockParam.tableId = 0U;
    taskT.paraBase = PtrToValue(&lockParam);

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
    TableLockManager::GetInstance().UnLockTable(0U);
}

TEST_F(OperatorKernelLockTableTest, ModelLockTable_fail_invalidLockType)
{
    AicpuTaskInfo taskT;
    LockTableTaskParam lockParam = {};
    lockParam.lockType = 2;
    lockParam.tableId = 0U;
    taskT.paraBase = PtrToValue(&lockParam);

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelLockTableTest, ModelLockTable_pending_write_read)
{
    TableLockManager::GetInstance().WrLockTable(0U);
    AicpuTaskInfo taskT;
    LockTableTaskParam lockParam = {};
    lockParam.lockType = 0;
    lockParam.tableId = 0U;
    taskT.paraBase = PtrToValue(&lockParam);

    AicpuModel aicpuModel;
    aicpuModel.modelId_ = 0U;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    RunContext runContextLocal = {.modelId = 0,
                                  .modelTsId = 0,
                                  .streamId = 0,
                                  .pending = false,
                                  .executeInline = true,
                                  .gotoTaskIndex = -1};
    EXPECT_EQ(kernel_.Compute(taskT, runContextLocal), AICPU_SCHEDULE_OK);
    EXPECT_TRUE(runContextLocal.pending);
    EventWaitManager::TableUnlockWaitManager().ClearBatch({0U});
}