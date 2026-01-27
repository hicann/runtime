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
#include "operator_kernel_set_update_resp.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_common.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;

class OperatorKernelSetUpdateRespTest : public OperatorKernelTest {
protected:
    OperatorKernelSetUpdateResp kernel_;
};

TEST_F(OperatorKernelSetUpdateRespTest, ModelSetUpdateResponse_Success)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    char placeHolder[1500] = {0};
    char placeHolder1[1500] = {};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize)
        .stubs()
        .with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    Mbuf *mbufP = reinterpret_cast<Mbuf *>(placeHolder);
    Mbuf *mbufP1 = reinterpret_cast<Mbuf *>(placeHolder1);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    vec.emplace_back(&mbufP1);
    SetRemoteRespTaskParam param = {};
    param.inBuffPtr = vec.data();
    param.inBuffNum = 2U;
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    HcclComm comm;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));
    MOCKER(StubHddsIsendUpdateResponse).stubs().will(returnValue(HCCL_SUCCESS));
    MOCKER(SingleHcclWait).stubs().will(returnValue(RET_SUCCESS));
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelSetUpdateRespTest, ModelSetUpdateResponse_Failed_MissingModel)
{
    AicpuTaskInfo taskT = {};
    EXPECT_NE(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelSetUpdateRespTest, ModelSetUpdateResponse_Failed_MissingParam)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    AicpuTaskInfo taskT = {};
    EXPECT_NE(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelSetUpdateRespTest, ModelSetUpdateResponse_Failed_MissingComm)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    char placeHolder[1500] = {0};
    char placeHolder1[1500] = {};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize)
        .stubs()
        .with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    Mbuf *mbufP = reinterpret_cast<Mbuf *>(placeHolder);
    Mbuf *mbufP1 = reinterpret_cast<Mbuf *>(placeHolder1);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    vec.emplace_back(&mbufP1);
    SetRemoteRespTaskParam param = {};
    param.inBuffPtr = vec.data();
    param.inBuffNum = 2U;
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    HcclComm *comm = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(comm));
    EXPECT_NE(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelSetUpdateRespTest, ModelSetUpdateResponse_Failed_StubHddsIsendUpdateResponse)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    char placeHolder[1500] = {0};
    char placeHolder1[1500] = {};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize)
        .stubs()
        .with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    Mbuf *mbufP = reinterpret_cast<Mbuf *>(placeHolder);
    Mbuf *mbufP1 = reinterpret_cast<Mbuf *>(placeHolder1);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    vec.emplace_back(&mbufP1);
    SetRemoteRespTaskParam param = {};
    param.inBuffPtr = vec.data();
    param.inBuffNum = 2U;
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    HcclComm comm;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));
    MOCKER(StubHddsIsendUpdateResponse).stubs().will(returnValue(HCCL_E_RESERVED));
    EXPECT_NE(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}