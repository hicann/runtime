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
#include "operator_kernel_model_report_status.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;

class OperatorKernelModelReportStatusTest : public OperatorKernelTest {
protected:
    OperatorKernelModelReportStatus kernel_;
};

TEST_F(OperatorKernelModelReportStatusTest, ModelReportStatus_Success01)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    halMbufGetBuffAddrFakeAddr = malloc(200);
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake2));
    AicpuTaskInfo taskT;
    uint32_t *paraMem = (uint32_t *)malloc(sizeof(ReportStatusInfo) + sizeof(QueueAttrs));
    ReportStatusInfo *reportStatusInfo = reinterpret_cast<ReportStatusInfo *>(paraMem);
    reportStatusInfo->inputNum = 1U;
    taskT.paraBase = (uintptr_t)paraMem;
    auto ret = kernel_.Compute(taskT, runContextT);
    free(paraMem);
    free(halMbufGetBuffAddrFakeAddr);
    halMbufGetBuffAddrFakeAddr = nullptr;
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelModelReportStatusTest, ModelReportStatus_Success02)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    halMbufGetBuffAddrFakeAddr = malloc(200);
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake2));
    MOCKER(halQueueEnQueue).stubs().will(returnValue(DRV_ERROR_QUEUE_FULL));
    AicpuTaskInfo taskT;
    uint32_t *paraMem = (uint32_t *)malloc(sizeof(ReportStatusInfo) + sizeof(QueueAttrs));
    ReportStatusInfo *reportStatusInfo = reinterpret_cast<ReportStatusInfo *>(paraMem);
    reportStatusInfo->inputNum = 1U;
    taskT.paraBase = (uintptr_t)paraMem;
    auto ret = kernel_.Compute(taskT, runContextT);
    free(paraMem);
    free(halMbufGetBuffAddrFakeAddr);
    halMbufGetBuffAddrFakeAddr = nullptr;
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelModelReportStatusTest, ModelReportStatus_Fail01)
{
    BUILD_SUCC_PREPARE_INFO();
    AicpuTaskInfo taskT;
    taskT.paraBase = (uintptr_t)0;
    auto ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelReportStatusTest, ModelReportStatus_Fail02)
{
    BUILD_SUCC_PREPARE_INFO();
    AicpuModel *aicpuModel1 = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel1));
    AicpuTaskInfo taskT;
    uint32_t *paraMem = (uint32_t *)malloc(sizeof(ReportStatusInfo) + sizeof(QueueAttrs));
    ReportStatusInfo *reportStatusInfo = reinterpret_cast<ReportStatusInfo *>(paraMem);
    reportStatusInfo->inputNum = 1U;
    taskT.paraBase = (uintptr_t)paraMem;
    auto ret = kernel_.Compute(taskT, runContextT);
    free(paraMem);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(OperatorKernelModelReportStatusTest, ModelReportStatus_Fail03)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halMbufAlloc).stubs().will(returnValue(10));
    AicpuTaskInfo taskT;
    uint32_t *paraMem = (uint32_t *)malloc(sizeof(ReportStatusInfo) + sizeof(QueueAttrs));
    ReportStatusInfo *reportStatusInfo = reinterpret_cast<ReportStatusInfo *>(paraMem);
    reportStatusInfo->inputNum = 1U;
    taskT.paraBase = (uintptr_t)paraMem;
    auto ret = kernel_.Compute(taskT, runContextT);
    free(paraMem);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(OperatorKernelModelReportStatusTest, ModelReportStatus_Fail04)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(10));
    AicpuTaskInfo taskT;
    uint32_t *paraMem = (uint32_t *)malloc(sizeof(ReportStatusInfo) + sizeof(QueueAttrs));
    ReportStatusInfo *reportStatusInfo = reinterpret_cast<ReportStatusInfo *>(paraMem);
    reportStatusInfo->inputNum = 1U;
    taskT.paraBase = (uintptr_t)paraMem;
    auto ret = kernel_.Compute(taskT, runContextT);
    free(paraMem);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(OperatorKernelModelReportStatusTest, ModelReportStatus_Fail05)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halMbufGetBuffAddr).stubs().will(returnValue(10));
    AicpuTaskInfo taskT;
    uint32_t *paraMem = (uint32_t *)malloc(sizeof(ReportStatusInfo) + sizeof(QueueAttrs));
    ReportStatusInfo *reportStatusInfo = reinterpret_cast<ReportStatusInfo *>(paraMem);
    reportStatusInfo->inputNum = 1U;
    taskT.paraBase = (uintptr_t)paraMem;
    auto ret = kernel_.Compute(taskT, runContextT);
    free(paraMem);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(OperatorKernelModelReportStatusTest, ModelReportStatus_Fail06)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    halMbufGetBuffAddrFakeAddr = malloc(200);
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake2));
    MOCKER(halQueueEnQueue).stubs().will(returnValue(10));
    AicpuTaskInfo taskT;
    uint32_t *paraMem = (uint32_t *)malloc(sizeof(ReportStatusInfo) + sizeof(QueueAttrs));
    ReportStatusInfo *reportStatusInfo = reinterpret_cast<ReportStatusInfo *>(paraMem);
    reportStatusInfo->inputNum = 1U;
    taskT.paraBase = (uintptr_t)paraMem;
    auto ret = kernel_.Compute(taskT, runContextT);
    free(paraMem);
    free(halMbufGetBuffAddrFakeAddr);
    halMbufGetBuffAddrFakeAddr = nullptr;
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(OperatorKernelModelReportStatusTest, ModelReportStatus_Fail07)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    halMbufGetBuffAddrFakeAddr = malloc(200);
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake2));
    MOCKER(halQueueEnQueue).stubs().will(returnValue(10));
    AicpuTaskInfo taskT;
    uint32_t *paraMem = (uint32_t *)malloc(sizeof(ReportStatusInfo) + sizeof(QueueAttrs));
    ReportStatusInfo *reportStatusInfo = reinterpret_cast<ReportStatusInfo *>(paraMem);
    reportStatusInfo->inputNum = 1U;
    taskT.paraBase = (uintptr_t)paraMem;
    MOCKER(halQueueQueryInfo).stubs().will(returnValue(10));
    auto ret = kernel_.Compute(taskT, runContextT);
    free(paraMem);
    free(halMbufGetBuffAddrFakeAddr);
    halMbufGetBuffAddrFakeAddr = nullptr;
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}