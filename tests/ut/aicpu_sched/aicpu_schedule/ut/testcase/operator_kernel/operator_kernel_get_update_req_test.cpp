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
#include "operator_kernel_get_update_req.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_stub.h"


using namespace AicpuSchedule;


class OperatorKernelGetUpdateReqTest : public OperatorKernelTest {
protected:
    OperatorKernelGetUpdateReq kernel_;
};

TEST_F(OperatorKernelGetUpdateReqTest, ModelGetUpdateRequest_Success)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    char placeHolder[1500] = {0};
    char placeHolder1[1500] = {};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *mbufP1 = reinterpret_cast<Mbuf*>(placeHolder1);
    Mbuf *mbufP2 = reinterpret_cast<Mbuf*>(placeHolder1);
    Mbuf *mbufP3 = reinterpret_cast<Mbuf*>(placeHolder1);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    vec.emplace_back(&mbufP1);
    vec.emplace_back(&mbufP2);
    vec.emplace_back(&mbufP3);
    GetRemoteReqTaskParam param = {};
    param.inBuffPtr = vec.data();
    param.embeddingDim = 1U;
    param.inBuffNum = 4U;
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    HcclComm comm;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));
    MOCKER(StubHddsCollRecvUpdateRequest).stubs().will(returnValue(HCCL_SUCCESS));
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelGetUpdateReqTest, ModelGetUpdateRequest_FOUR_INPUT_Failed)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    char placeHolder[1500] = {0};
    char placeHolder1[1500] = {};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *mbufP1 = reinterpret_cast<Mbuf*>(placeHolder1);
    Mbuf *mbufP2 = reinterpret_cast<Mbuf*>(placeHolder1);
    Mbuf *mbufP3 = reinterpret_cast<Mbuf*>(placeHolder1);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    vec.emplace_back(&mbufP1);
    vec.emplace_back(&mbufP2);
    vec.emplace_back(&mbufP3);
    GetRemoteReqTaskParam param = {};
    param.inBuffPtr = vec.data();
    param.embeddingDim = 1U;
    param.inBuffNum = 4U;
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    HcclComm comm;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));
    MOCKER(StubHddsCollRecvUpdateRequest).stubs().will(returnValue(HCCL_SUCCESS));
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelGetUpdateReqTest, ModelGetUpdateRequest_THREE_INPUT_Failed)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    char placeHolder[1500] = {0};
    char placeHolder1[1500] = {};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *mbufP1 = reinterpret_cast<Mbuf*>(placeHolder1);
    Mbuf *mbufP2 = reinterpret_cast<Mbuf*>(placeHolder1);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    vec.emplace_back(&mbufP1);
    vec.emplace_back(&mbufP2);
    GetRemoteReqTaskParam param = {};
    param.inBuffPtr = vec.data();
    param.embeddingDim = 1U;
    param.inBuffNum = 3U;
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    HcclComm comm;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));
    MOCKER(StubHddsCollRecvUpdateRequest).stubs().will(returnValue(HCCL_SUCCESS));
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(OperatorKernelGetUpdateReqTest, ModelGetUpdateRequest_Failed_MissingModel)
{
    AicpuTaskInfo taskT = {};
    EXPECT_NE(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelGetUpdateReqTest, ModelGetUpdateRequest_Failed_MissingParam)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    GetRemoteReqTaskParam param = {};
    AicpuTaskInfo taskT = {};
    taskT.paraBase = (uint64_t)&param;
    EXPECT_NE(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelGetUpdateReqTest, ModelGetUpdateRequest_Failed_MissingComm)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    char placeHolder[1500] = {0};
    char placeHolder1[1500] = {};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *mbufP1 = reinterpret_cast<Mbuf*>(placeHolder1);
    Mbuf *mbufP2 = reinterpret_cast<Mbuf*>(placeHolder1);
    Mbuf *mbufP3 = reinterpret_cast<Mbuf*>(placeHolder1);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    vec.emplace_back(&mbufP1);
    vec.emplace_back(&mbufP2);
    vec.emplace_back(&mbufP3);
    GetRemoteReqTaskParam param = {};
    param.inBuffPtr = vec.data();
    param.embeddingDim = 1U;
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    HcclComm* comm = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(comm));
    EXPECT_NE(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelGetUpdateReqTest, ModelGetUpdateRequest_Failed_StubHddsCollRecvUpdateRequest)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    char placeHolder[1500] = {0};
    char placeHolder1[1500] = {};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *mbufP1 = reinterpret_cast<Mbuf*>(placeHolder1);
    Mbuf *mbufP2 = reinterpret_cast<Mbuf*>(placeHolder1);
    Mbuf *mbufP3 = reinterpret_cast<Mbuf*>(placeHolder1);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    vec.emplace_back(&mbufP1);
    vec.emplace_back(&mbufP2);
    vec.emplace_back(&mbufP3);
    GetRemoteReqTaskParam param = {};
    param.inBuffPtr = vec.data();
    param.embeddingDim = 1U;
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    HcclComm comm;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));
    MOCKER(StubHddsCollRecvUpdateRequest).stubs().will(returnValue(HCCL_E_RESERVED));
    EXPECT_NE(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelGetUpdateReqTest, ModelGetUpdateRequest_Failed_halMbufGetPrivInfo)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(returnValue(1));

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    char placeHolder[1500] = {0};
    char placeHolder1[1500] = {};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *mbufP1 = reinterpret_cast<Mbuf*>(placeHolder1);
    Mbuf *mbufP2 = reinterpret_cast<Mbuf*>(placeHolder1);
    Mbuf *mbufP3 = reinterpret_cast<Mbuf*>(placeHolder1);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    vec.emplace_back(&mbufP1);
    vec.emplace_back(&mbufP2);
    vec.emplace_back(&mbufP3);
    GetRemoteReqTaskParam param = {};
    param.inBuffPtr = vec.data();
    param.embeddingDim = 1U;
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    HcclComm comm;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));
    MOCKER(StubHddsCollRecvUpdateRequest).stubs().will(returnValue(HCCL_SUCCESS));
    EXPECT_NE(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}