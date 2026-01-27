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
#include "operator_kernel_lookup_req.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;

namespace {
}  // namespace

class OperatorKernelLookupReqTest : public OperatorKernelTest {
protected:
    OperatorKernelGetLookupReq getKernel_;
    OperatorKernelCollRecvLookupReq recvKernel_;
};

TEST_F(OperatorKernelLookupReqTest, ModelGetLookupRequest_Success)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    char placeHolder[1500] = {0};
    char placeHolder1[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *mbufP1 = reinterpret_cast<Mbuf*>(placeHolder1);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    vec.emplace_back(&mbufP1);
    GetRemoteReqTaskParam param = {0};
    param.inBuffPtr = vec.data();
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    HcclComm comm;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));
    MOCKER(StubHcclGetLookupRequest).stubs().will(returnValue(HCCL_SUCCESS));
    EXPECT_EQ(getKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelLookupReqTest, ModelGetLookupRequest_fail_MissingModel)
{
    AicpuTaskInfo taskT;
    EXPECT_NE(getKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelLookupReqTest, ModelGetLookupRequest_fail_MissingParam)
{
    AicpuTaskInfo taskT = {};
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    EXPECT_NE(getKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelLookupReqTest, ModelGetLookupRequest_fail_halMbufGetBuffSize)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    AicpuTaskInfo taskT = {};
    char placeHolder[1500] = {0};
    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *mbufP1 = reinterpret_cast<Mbuf*>(placeHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    vec.emplace_back(&mbufP1);
    GetRemoteReqTaskParam param = {0};
    param.inBuffPtr = vec.data();
    taskT.paraBase = (uint64_t)&param;
    MOCKER(halMbufGetBuffSize).stubs().will(returnValue(1));
    EXPECT_NE(getKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelLookupReqTest, ModelGetLookupRequest_fail_halMbufGetBuffAddr)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    AicpuTaskInfo taskT = {};
    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *mbufP1 = reinterpret_cast<Mbuf*>(placeHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    vec.emplace_back(&mbufP1);
    GetRemoteReqTaskParam param = {0};
    param.inBuffPtr = vec.data();
    taskT.paraBase = (uint64_t)&param;
    MOCKER(halMbufGetBuffAddr).stubs().will(returnValue(1));
    EXPECT_NE(getKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelLookupReqTest, ModelGetLookupRequest_fail_MissingComm)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));
    HcclComm *comm = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(comm));
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    AicpuTaskInfo taskT = {};
    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *mbufP1 = reinterpret_cast<Mbuf*>(placeHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    vec.emplace_back(&mbufP1);
    GetRemoteReqTaskParam param = {0};
    param.inBuffPtr = vec.data();
    taskT.paraBase = (uint64_t)&param;
    EXPECT_NE(getKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelLookupReqTest, ModelGetLookupRequest_fail_StubHcclGetLookupRequest)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));
    HcclComm comm;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));
    MOCKER(StubHcclGetLookupRequest).stubs().will(returnValue(HCCL_E_RESERVED));
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    AicpuTaskInfo taskT = {};
    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *mbufP1 = reinterpret_cast<Mbuf*>(placeHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    vec.emplace_back(&mbufP1);
    GetRemoteReqTaskParam param = {0};
    param.inBuffPtr = vec.data();
    taskT.paraBase = (uint64_t)&param;
    EXPECT_NE(getKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelLookupReqTest, ModelGetLookupRequest_fail_halMbufGetPrivInfo)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    HcclComm comm;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));
    MOCKER(StubHcclGetLookupRequest).stubs().will(returnValue(HCCL_SUCCESS));
    MOCKER(halMbufGetPrivInfo).stubs().will(returnValue(1));
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    AicpuTaskInfo taskT = {};
    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *mbufP1 = reinterpret_cast<Mbuf*>(placeHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    vec.emplace_back(&mbufP1);
    GetRemoteReqTaskParam param = {0};
    param.inBuffPtr = vec.data();
    taskT.paraBase = (uint64_t)&param;
    EXPECT_NE(getKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelLookupReqTest, ModelLookupRequest001)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    HcclComm comm;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));
    MOCKER(StubHcclGetLookupRequest).stubs().will(returnValue(HCCL_SUCCESS));
    MOCKER(halMbufGetPrivInfo).stubs().will(returnValue(1));
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    AicpuTaskInfo taskT = {};
    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *mbufP1 = reinterpret_cast<Mbuf*>(placeHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    vec.emplace_back(&mbufP1);
    GetRemoteReqTaskParam param = {0};
    param.inBuffPtr = vec.data();
    taskT.paraBase = (uint64_t)&param;
    EXPECT_NE(getKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelLookupReqTest, ModelLookupRequest002)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    HcclComm comm;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));
    MOCKER(StubHcclGetLookupRequest).stubs().will(returnValue(HCCL_SUCCESS));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    AicpuTaskInfo taskT = {};
    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *mbufP1 = reinterpret_cast<Mbuf*>(placeHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    vec.emplace_back(&mbufP1);
    GetRemoteReqTaskParam param = {0};
    param.inBuffPtr = vec.data();
    taskT.paraBase = (uint64_t)&param;
    EXPECT_EQ(getKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelLookupReqTest, ModelGetLookupRequest_success_break)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    HcclComm comm;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));
    MOCKER(StubHcclGetLookupRequest).stubs().will(returnValue(HCCL_E_AGAIN));
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    AicpuTaskInfo taskT = {};
    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *mbufP1 = reinterpret_cast<Mbuf*>(placeHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    vec.emplace_back(&mbufP1);
    GetRemoteReqTaskParam param = {0};
    param.inBuffPtr = vec.data();
    taskT.paraBase = (uint64_t)&param;

    uint32_t stubId = 1U;
    RunContext runContextLocal = {.modelId = stubId,
                                  .modelTsId = stubId,
                                  .streamId = stubId,
                                  .pending = false,
                                  .executeInline = true,
                                  .gotoTaskIndex = -1};
    EXPECT_EQ(getKernel_.Compute(taskT, runContextLocal),
              AICPU_SCHEDULE_OK);
    EXPECT_EQ(runContextLocal.pending, true);
}

TEST_F(OperatorKernelLookupReqTest, ModelCollGetLookupReq_Success)
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
    Mbuf *mbufP1 = reinterpret_cast<Mbuf*>(placeHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    vec.emplace_back(&mbufP1);
    GetRemoteReqTaskParam param = {0};
    param.inBuffPtr = vec.data();
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    HcclComm comm;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));
    MOCKER(StubHcclGetLookupRequest).stubs().will(returnValue(HCCL_SUCCESS));
    MOCKER(StubHddsCollRecvLookupRequest).stubs().will(returnValue(HCCL_SUCCESS));
    EXPECT_EQ(recvKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelLookupReqTest, ModelCollGetLookupReq_CounterFilter_Success)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));

    AicpuModel aicpuModel;
    aicpuModel.isSupportCounterFilter_ = true;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    Mbuf *mbufP = reinterpret_cast<Mbuf*>(placeHolder);
    Mbuf *mbufP1 = reinterpret_cast<Mbuf*>(placeHolder);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    vec.emplace_back(&mbufP1);
    GetRemoteReqTaskParam param = {0};
    param.inBuffPtr = vec.data();
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    HcclComm comm;
    MOCKER_CPP(&AicpuModelManager::GetHcclComm).stubs().will(returnValue(&comm));
    MOCKER(StubHcclGetLookupRequest).stubs().will(returnValue(HCCL_SUCCESS));
    MOCKER(StubHddsCollRecvLookupRequest).stubs().will(returnValue(HCCL_SUCCESS));
    EXPECT_EQ(recvKernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}