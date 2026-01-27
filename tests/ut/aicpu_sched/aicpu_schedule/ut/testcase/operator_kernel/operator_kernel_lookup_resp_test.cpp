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
#include "operator_kernel_lookup_resp.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_stub.h"


using namespace AicpuSchedule;


class OperatorKernelLookupRespTest : public OperatorKernelTest {
protected:
    OperatorKernelSetLookupResp setKernel_;
    OperatorKernelCollSendLookupResp collKernel_;
};

TEST_F(OperatorKernelLookupRespTest, ModelSetLookupResponse_Success)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));

    AicpuModel aicpuModel;
    aicpuModel.modelId_ = 0U;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    SetRemoteRespTaskParam param = {0};
    param.inBuffPtr = vec.data();
    param.outBuffPtr = vec.data();
    param.inBuffNum = 1U;
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    HcclComm comm;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));
    MOCKER(StubHcclIsetLookupResponse).stubs().will(returnValue(HCCL_SUCCESS));
    MOCKER(StubHcclWaitSome).stubs().will(invoke(HcclWaitOneSuccessFake));
    EXPECT_EQ(setKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
    aicpuModel.ReleaseModelResource();
}

TEST_F(OperatorKernelLookupRespTest, ModelSetLookupResponse_fail_MissingModel)
{
    AicpuTaskInfo taskT;
    EXPECT_NE(setKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelLookupRespTest, ModelSetLookupResponse_fail_MissingParam)
{
    AicpuTaskInfo taskT = {};
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    EXPECT_NE(setKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelLookupRespTest, ModelSetLookupResponse_fail_halMbufGetBuffSize)
{
    MOCKER(halMbufGetBuffSize).stubs().will(returnValue(1));

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;

    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    SetRemoteRespTaskParam param = {0};
    param.inBuffPtr = vec.data();
    param.outBuffPtr = vec.data();
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    EXPECT_NE(setKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelLookupRespTest, ModelSetLookupResponse_fail_halMbufGetBuffAddr)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(returnValue(1));

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    SetRemoteRespTaskParam param = {0};
    param.inBuffPtr = vec.data();
    param.outBuffPtr = vec.data();
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    EXPECT_NE(setKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelLookupRespTest, ModelSetLookupResponse_fail_halMbufGetPrivInfo)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(returnValue(1));

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    SetRemoteRespTaskParam param = {0};
    param.inBuffPtr = vec.data();
    param.outBuffPtr = vec.data();
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    EXPECT_NE(setKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelLookupRespTest, ModelSetLookupResponse_fail_modelExecuteAbnormal)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MbufHeadMsg *head = reinterpret_cast<MbufHeadMsg*>(&placeHolder[mbufDataOffSet - 64]);
    head->retCode = 1;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    SetRemoteRespTaskParam param = {0};
    param.inBuffPtr = vec.data();
    param.outBuffPtr = vec.data();
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    EXPECT_NE(setKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelLookupRespTest, ModelSetLookupResponse_fail_MissingComm)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    SetRemoteRespTaskParam param = {0};
    param.inBuffPtr = vec.data();
    param.outBuffPtr = vec.data();
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    HcclComm* comm = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(comm));
    EXPECT_NE(setKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelLookupRespTest, ModelSetLookupResponse_fail_StubHcclIsetLookupResponse)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    SetRemoteRespTaskParam param = {0};
    param.inBuffPtr = vec.data();
    param.outBuffPtr = vec.data();
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    HcclComm comm;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));
    MOCKER(StubHcclIsetLookupResponse).stubs().will(returnValue(HCCL_E_RESERVED));
    EXPECT_NE(setKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelLookupRespTest, ModelCollSetLookupResp_Success)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));

    AicpuModel aicpuModel;
    aicpuModel.modelId_ = 0U;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    SetRemoteRespTaskParam param = {0};
    param.inBuffPtr = vec.data();
    param.outBuffPtr = vec.data();
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    HcclComm comm;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));
    MOCKER(StubHddsIsendLookupResponse).stubs().will(returnValue(HCCL_SUCCESS));
    MOCKER(StubHcclWaitSome).stubs().will(invoke(HcclWaitOneSuccessFake));
    EXPECT_EQ(collKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
    aicpuModel.ReleaseModelResource();
}