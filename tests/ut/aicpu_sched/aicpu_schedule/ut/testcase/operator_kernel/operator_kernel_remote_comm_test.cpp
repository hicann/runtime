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
#include "operator_kernel_remote_comm.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_common.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;

class OperatorKernelRemoteCommTest : public OperatorKernelTest {
protected:
    OperatorKernelRemoteComm kernel_;
};

TEST_F(OperatorKernelRemoteCommTest, ModelRemoteComm_Failed_InvalidOpType)
{
    HcomOpDesc opdesc = {0};
    opdesc.opType = HCOM_OP_TYPE_NUM;
    Mbuf *mbuf = nullptr;
    RemoteCommTaskParm param = {};
    param.hcomOpDescAddr = PtrToValue(&opdesc);
    param.buffAddrLen = 1U;
    param.buffAddr[0] = PtrToValue(&mbuf);
    AicpuTaskInfo taskT = {};
    taskT.paraBase = PtrToValue(&param);

    MOCKER(StubHcomSendByOS).stubs().will(returnValue(HCCL_SUCCESS));
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), static_cast<int32_t>(AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID));
}

TEST_F(OperatorKernelRemoteCommTest, ModelRemoteComm_broadcast_success)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    HcomOpDesc opdesc = {0};
    opdesc.opType = HCOM_OP_TYPE_BROADCAST;
    Mbuf *mbuf = nullptr;
    RemoteCommTaskParm param = {};
    param.hcomOpDescAddr = PtrToValue(&opdesc);
    HcomCollOpInfo coll = {};
    int64_t save_step = 37;
    coll.inputAddr = PtrToValue(&save_step);
    opdesc.info.coll = coll;
    param.buffAddrLen = 2U;
    param.buffAddr[0] = PtrToValue(&mbuf);
    param.buffAddr[1] = PtrToValue(&mbuf);
    AicpuTaskInfo taskT = {};
    taskT.paraBase = PtrToValue(&param);

    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize)
        .stubs()
        .with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));

    Mbuf *mbufP = reinterpret_cast<Mbuf *>(&placeHolder[0U]);
    MOCKER_CPP(&MBufferPool::Allocate).stubs().with(outBoundP(&mbufP, sizeof(Mbuf **))).will(returnValue(0));

    MOCKER(StubHcomBroadcastByOS).stubs().will(returnValue(HCCL_SUCCESS));
    EXPECT_NE(kernel_.Compute(taskT, runContextT), static_cast<int32_t>(AICPU_SCHEDULE_ERROR_TASK_EXECUTE_FAILED));
}

TEST_F(OperatorKernelRemoteCommTest, ModelRemoteComm_broadcast_fail_allocate1)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    HcomOpDesc opdesc = {0};
    opdesc.opType = HCOM_OP_TYPE_BROADCAST;
    Mbuf *mbuf = nullptr;
    RemoteCommTaskParm param = {};
    param.hcomOpDescAddr = PtrToValue(&opdesc);
    param.buffAddrLen = 1U;
    param.buffAddr[0] = PtrToValue(&mbuf);
    AicpuTaskInfo taskT = {};
    taskT.paraBase = PtrToValue(&param);

    MOCKER(StubHcomBroadcastByOS).stubs().will(returnValue(HCCL_SUCCESS));
    MOCKER_CPP(&MBufferPool::Allocate).stubs().will(returnValue(-1));

    EXPECT_EQ(kernel_.Compute(taskT, runContextT), static_cast<int32_t>(AICPU_SCHEDULE_ERROR_INNER_ERROR));
}

TEST_F(OperatorKernelRemoteCommTest, ModelRemoteComm_broadcast_fail_allocate2)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    HcomOpDesc opdesc = {0};
    opdesc.opType = HCOM_OP_TYPE_BROADCAST;
    Mbuf *mbuf = nullptr;
    RemoteCommTaskParm param = {};
    param.hcomOpDescAddr = PtrToValue(&opdesc);
    HcomCollOpInfo coll = {};
    int64_t save_step = 37;
    coll.inputAddr = PtrToValue(&save_step);
    opdesc.info.coll = coll;
    param.buffAddrLen = 2U;
    param.buffAddr[0] = PtrToValue(&mbuf);
    param.buffAddr[1] = PtrToValue(&mbuf);
    AicpuTaskInfo taskT = {};
    taskT.paraBase = PtrToValue(&param);

    MOCKER(StubHcomBroadcastByOS).stubs().will(returnValue(HCCL_SUCCESS));
    char placeHolder[1500] = {0};
    Mbuf *mbufP = reinterpret_cast<Mbuf *>(&placeHolder[0U]);
    MOCKER_CPP(&MBufferPool::Allocate)
        .stubs()
        .with(outBoundP(&mbufP, sizeof(Mbuf **)))
        .will(returnValue(0))
        .then(returnValue(-1));
    MOCKER_CPP(&OperatorKernelCommon::GetMbufAddrAndSize)
        .stubs()
        .will(returnValue(static_cast<int32_t>(AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID)));

    EXPECT_EQ(kernel_.Compute(taskT, runContextT), static_cast<int32_t>(AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID));
}

TEST_F(OperatorKernelRemoteCommTest, ModelRemoteComm_broadcast_fail_allocate3)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    HcomOpDesc opdesc = {0};
    opdesc.opType = HCOM_OP_TYPE_BROADCAST;
    Mbuf *mbuf = nullptr;
    RemoteCommTaskParm param = {};
    param.hcomOpDescAddr = PtrToValue(&opdesc);
    HcomCollOpInfo coll = {};
    int64_t save_step = 37;
    coll.inputAddr = PtrToValue(&save_step);
    opdesc.info.coll = coll;
    param.buffAddrLen = 2U;
    param.buffAddr[0] = PtrToValue(&mbuf);
    param.buffAddr[1] = PtrToValue(&mbuf);
    AicpuTaskInfo taskT = {};
    taskT.paraBase = PtrToValue(&param);

    MOCKER(StubHcomBroadcastByOS).stubs().will(returnValue(HCCL_SUCCESS));
    char placeHolder[1500] = {0};
    Mbuf *mbufP = reinterpret_cast<Mbuf *>(&placeHolder[0U]);
    MOCKER_CPP(&MBufferPool::Allocate)
        .stubs()
        .with(outBoundP(&mbufP, sizeof(Mbuf **)))
        .will(returnValue(0))
        .then(returnValue(-1));
    uint64_t psIdDataLen = 1025;
    MOCKER(&OperatorKernelCommon::GetMbufAddrAndSize)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), outBoundP(&psIdDataLen), mockcpp::any())
        .will(returnValue(static_cast<int32_t>(AICPU_SCHEDULE_OK)));

    EXPECT_EQ(kernel_.Compute(taskT, runContextT), static_cast<int32_t>(AICPU_SCHEDULE_ERROR_INNER_ERROR));
}

TEST_F(OperatorKernelRemoteCommTest, ModelRemoteComm_broadcast_fail_allocate4)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    HcomOpDesc opdesc = {0};
    opdesc.opType = HCOM_OP_TYPE_BROADCAST;
    Mbuf *mbuf = nullptr;
    RemoteCommTaskParm param = {};
    param.hcomOpDescAddr = PtrToValue(&opdesc);
    HcomCollOpInfo coll = {};
    int64_t save_step = 37;
    coll.inputAddr = PtrToValue(&save_step);
    opdesc.info.coll = coll;
    param.buffAddrLen = 2U;
    param.buffAddr[0] = PtrToValue(&mbuf);
    param.buffAddr[1] = PtrToValue(&mbuf);
    AicpuTaskInfo taskT = {};
    taskT.paraBase = PtrToValue(&param);

    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize)
        .stubs()
        .with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    ;
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));

    Mbuf *mbufP = reinterpret_cast<Mbuf *>(&placeHolder[0U]);
    MOCKER_CPP(&MBufferPool::Allocate)
        .stubs()
        .with(outBoundP(&mbufP, sizeof(Mbuf **)))
        .will(returnValue(0))
        .then(returnValue(-1));

    MOCKER(StubHcomBroadcastByOS).stubs().will(returnValue(HCCL_SUCCESS));
    EXPECT_NE(kernel_.Compute(taskT, runContextT), static_cast<int32_t>(AICPU_SCHEDULE_ERROR_TASK_EXECUTE_FAILED));
}

TEST_F(OperatorKernelRemoteCommTest, ModelRemoteComm_broadcast_fail_allocate5)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    HcomOpDesc opdesc = {0};
    opdesc.opType = HCOM_OP_TYPE_BROADCAST;
    Mbuf *mbuf = nullptr;
    RemoteCommTaskParm param = {};
    param.hcomOpDescAddr = PtrToValue(&opdesc);
    HcomCollOpInfo coll = {};
    int64_t save_step = 37;
    coll.inputAddr = PtrToValue(&save_step);
    opdesc.info.coll = coll;
    param.buffAddrLen = 2U;
    param.buffAddr[0] = PtrToValue(&mbuf);
    param.buffAddr[1] = PtrToValue(&mbuf);
    AicpuTaskInfo taskT = {};
    taskT.paraBase = PtrToValue(&param);

    char placeHolder[1500] = {0};
    uint64_t dataLen = 1500 - mbufDataOffSet;
    MOCKER(halMbufGetBuffSize)
        .stubs()
        .with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)))
        .then(invoke(halMbufGetBuffSizeFake));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));

    Mbuf *mbufP = reinterpret_cast<Mbuf *>(&placeHolder[0U]);
    MOCKER_CPP(&MBufferPool::Allocate).stubs().with(outBoundP(&mbufP, sizeof(Mbuf **))).will(returnValue(0));

    MOCKER(StubHcomBroadcastByOS).stubs().will(returnValue(HCCL_SUCCESS));
    EXPECT_NE(kernel_.Compute(taskT, runContextT), static_cast<int32_t>(-1));
}

TEST_F(OperatorKernelRemoteCommTest, ModelRemoteComm_broadcast_fail_dataLen)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    HcomOpDesc opdesc = {0};
    opdesc.opType = HCOM_OP_TYPE_BROADCAST;
    Mbuf *mbuf = nullptr;
    RemoteCommTaskParm param = {};
    param.hcomOpDescAddr = PtrToValue(&opdesc);
    param.buffAddrLen = 1U;
    param.buffAddr[0] = PtrToValue(&mbuf);
    AicpuTaskInfo taskT = {};
    taskT.paraBase = PtrToValue(&param);

    char placeHolder[1500] = {0};
    uint64_t dataLen = 1025;
    MOCKER(halMbufGetBuffSize)
        .stubs()
        .with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));

    Mbuf *mbufP = reinterpret_cast<Mbuf *>(&placeHolder[0U]);
    MOCKER_CPP(&MBufferPool::Allocate).stubs().with(outBoundP(&mbufP, sizeof(Mbuf **))).will(returnValue(0));
    MOCKER_CPP(&MBufferPool::Free).stubs().will(returnValue(0));

    MOCKER(StubHcomBroadcastByOS).stubs().will(returnValue(HCCL_SUCCESS));
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), static_cast<int32_t>(AICPU_SCHEDULE_ERROR_INNER_ERROR));
}

TEST_F(OperatorKernelRemoteCommTest, ModelRemoteComm_broadcast_breaked)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    HcomOpDesc opdesc = {0};
    opdesc.opType = HCOM_OP_TYPE_BROADCAST;
    Mbuf *mbuf = nullptr;
    RemoteCommTaskParm param = {};
    param.hcomOpDescAddr = PtrToValue(&opdesc);
    param.buffAddrLen = 1U;
    param.buffAddr[0] = PtrToValue(&mbuf);
    AicpuTaskInfo taskT = {};
    taskT.paraBase = PtrToValue(&param);
    MOCKER(StubHcomBroadcastByOS).stubs().will(returnValue(HCCL_E_AGAIN));
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), static_cast<int32_t>(AICPU_SCHEDULE_OK));
    EXPECT_TRUE(runContextT.pending);
    runContextT.pending = false;
}

TEST_F(OperatorKernelRemoteCommTest, ModelRemoteComm_broadcast_failed)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    HcomOpDesc opdesc = {0};
    opdesc.opType = HCOM_OP_TYPE_BROADCAST;
    Mbuf *mbuf = nullptr;
    RemoteCommTaskParm param = {};
    param.hcomOpDescAddr = PtrToValue(&opdesc);
    param.buffAddrLen = 8U;
    param.buffAddr[0] = PtrToValue(&mbuf);
    AicpuTaskInfo taskT = {};
    taskT.paraBase = PtrToValue(&param);
    MOCKER(StubHcomBroadcastByOS).stubs().will(returnValue(HCCL_E_AGAIN));
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), static_cast<int32_t>(AICPU_SCHEDULE_ERROR_INNER_ERROR));
}

TEST_F(OperatorKernelRemoteCommTest, ModelRemoteComm_gather_success)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    HcomOpDesc opdesc = {0};
    opdesc.opType = HCOM_OP_TYPE_GATHER;
    Mbuf *mbuf = reinterpret_cast<Mbuf *>(1);
    RemoteCommTaskParm param = {};
    param.hcomOpDescAddr = PtrToValue(&opdesc);
    HcomCollOpInfo coll = {};
    int64_t save_step = 37;
    coll.inputAddr = PtrToValue(&save_step);
    opdesc.info.coll = coll;
    param.buffAddrLen = 2U;
    param.buffAddr[0] = PtrToValue(&mbuf);
    param.buffAddr[1] = PtrToValue(&mbuf);
    AicpuTaskInfo taskT = {};
    taskT.paraBase = PtrToValue(&param);
    MOCKER_CPP(&MBufferPool::Free).stubs().will(returnValue(0));
    MOCKER(StubHcomGatherByOS).stubs().will(returnValue(HCCL_SUCCESS));
    EXPECT_NE(kernel_.Compute(taskT, runContextT), static_cast<int32_t>(AICPU_SCHEDULE_ERROR_TASK_EXECUTE_FAILED));
}

TEST_F(OperatorKernelRemoteCommTest, ModelRemoteComm_gather_breaked)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    HcomOpDesc opdesc = {0};
    opdesc.opType = HCOM_OP_TYPE_GATHER;
    Mbuf *mbuf = nullptr;
    Mbuf *mbuf1 = reinterpret_cast<Mbuf *>(1);
    RemoteCommTaskParm param = {};
    HcomCollOpInfo coll = {};
    int64_t save_step = 37;
    coll.inputAddr = PtrToValue(&save_step);
    opdesc.info.coll = coll;
    param.buffAddrLen = 2U;
    param.buffAddr[0] = PtrToValue(&mbuf);
    param.buffAddr[1] = PtrToValue(&mbuf1);
    param.hcomOpDescAddr = PtrToValue(&opdesc);
    AicpuTaskInfo taskT = {};
    taskT.paraBase = PtrToValue(&param);
    MOCKER_CPP(&MBufferPool::Free).stubs().will(returnValue(0));
    MOCKER(StubHcomGatherByOS).stubs().will(returnValue(HCCL_E_AGAIN));
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), static_cast<int32_t>(AICPU_SCHEDULE_OK));
    EXPECT_TRUE(runContextT.pending);
    runContextT.pending = false;
}