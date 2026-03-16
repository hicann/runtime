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
#define private public
#include "tprt_device.hpp"
#include "tprt_sqhandle.hpp"
#include "tprt_cqhandle.hpp"
#include "tprt.hpp"

#undef private

using namespace cce::tprt;

class TprtDeviceTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "TprtDeviceTest SetUP" << std::endl;

        std::cout << "TprtDeviceTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "TprtDeviceTest end" << std::endl;
    }

    virtual void SetUp()
    {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(TprtDeviceTest, TprtSqCqAlloc_Success)
{
    uint32_t sqId = 0;
    uint32_t cqId = 0;
    uint32_t devId = 0;
    TprtDevice* tprtDev = new TprtDevice(devId);
    uint32_t ret = tprtDev->TprtSqCqAlloc(sqId, cqId);
    EXPECT_EQ(ret, TPRT_SUCCESS);
    DELETE_O(tprtDev);
}

TEST_F(TprtDeviceTest, TprtSqCqAlloc_sqHandle_duplicate_Fail)
{
    uint32_t sqId = 0;
    uint32_t cqId = 0;
    uint32_t devId = 0;
    TprtDevice* tprtDev = new TprtDevice(devId);
    TprtSqHandle* sqHandle = new (std::nothrow) TprtSqHandle(0, 0);
    tprtDev->sqHandleMap_[0] = sqHandle;
    uint32_t ret = tprtDev->TprtSqCqAlloc(sqId, cqId);
    EXPECT_EQ(ret, TPRT_SQ_HANDLE_INVALID);
    sqHandle->Destructor();
    DELETE_O(tprtDev);
}

TEST_F(TprtDeviceTest, TprtSqCqAlloc_cqHandle_duplicate_Fail)
{
    uint32_t sqId = 0;
    uint32_t cqId = 0;
    uint32_t devId = 0;
    TprtDevice* tprtDev = new TprtDevice(devId);
    TprtCqHandle* cqHandle = new (std::nothrow) TprtCqHandle(0, 0);
    tprtDev->cqHandleMap_[0] = cqHandle;
    uint32_t ret = tprtDev->TprtSqCqAlloc(sqId, cqId);
    EXPECT_EQ(ret, TPRT_CQ_HANDLE_INVALID);
    DELETE_O(cqHandle);
    DELETE_O(tprtDev);
}

TEST_F(TprtDeviceTest, TprtSqCqAlloc_worker_start_Fail)
{
    MOCKER_CPP(&TprtWorker::TprtWorkerStart).stubs().will(returnValue(TPRT_START_WORKER_FAILED));
    uint32_t sqId = 0;
    uint32_t cqId = 0;
    uint32_t devId = 0;
    TprtDevice* tprtDev = new TprtDevice(devId);
    uint32_t ret = tprtDev->TprtSqCqAlloc(sqId, cqId);
    EXPECT_EQ(ret, TPRT_START_WORKER_FAILED);
    DELETE_O(tprtDev);
}

TEST_F(TprtDeviceTest, TprtSqCqAlloc_worker_start2_Fail)
{
    MOCKER(mmSemInit).stubs().will(returnValue(TPRT_START_WORKER_FAILED));
    uint32_t sqId = 0;
    uint32_t cqId = 0;
    uint32_t devId = 0;
    TprtDevice* tprtDev = new TprtDevice(devId);
    uint32_t ret = tprtDev->TprtSqCqAlloc(sqId, cqId);
    EXPECT_EQ(ret, TPRT_START_WORKER_FAILED);
    DELETE_O(tprtDev);
}

TEST_F(TprtDeviceTest, TprtDeviceConstructor_Success)
{
    uint32_t devId = 0;
    uint32_t timeoutMonitorUint = 1000;
    TprtDevice* tprtDev = new TprtDevice(devId, timeoutMonitorUint);
    EXPECT_NE(tprtDev, nullptr);
    EXPECT_NE(tprtDev->timer_, nullptr);
    DELETE_O(tprtDev);
}

TEST_F(TprtDeviceTest, TprtDeviceDestructor_Success)
{
    uint32_t devId = 0;
    TprtDevice* tprtDev = new TprtDevice(devId);
    DELETE_O(tprtDev);
}

TEST_F(TprtDeviceTest, TprtGetSqHandleSharedPtrById_Success)
{
    uint32_t devId = 0;
    TprtDevice* tprtDev = new TprtDevice(devId);

    uint32_t sqId = 1;
    TprtSqHandle* sqHandle = new TprtSqHandle(devId, sqId);
    tprtDev->sqHandleMap_[sqId] = sqHandle;

    std::shared_ptr<TprtSqHandle> sharedSqHandle;
    uint32_t ret = tprtDev->TprtGetSqHandleSharedPtrById(sqId, sharedSqHandle);
    EXPECT_EQ(ret, TPRT_SUCCESS);
    EXPECT_NE(sharedSqHandle.get(), nullptr);

    sqHandle->Destructor();
    DELETE_O(tprtDev);
}

TEST_F(TprtDeviceTest, TprtGetSqHandleSharedPtrById_NotFound)
{
    uint32_t devId = 0;
    TprtDevice* tprtDev = new TprtDevice(devId);

    uint32_t sqId = 1;
    std::shared_ptr<TprtSqHandle> sharedSqHandle;
    uint32_t ret = tprtDev->TprtGetSqHandleSharedPtrById(sqId, sharedSqHandle);
    EXPECT_EQ(ret, TPRT_SQ_HANDLE_INVALID);
    EXPECT_EQ(sharedSqHandle.get(), nullptr);

    DELETE_O(tprtDev);
}

TEST_F(TprtDeviceTest, GetAllSqHandleId_Success)
{
    uint32_t devId = 0;
    TprtDevice* tprtDev = new TprtDevice(devId);

    TprtSqHandle* sqHandle1 = new TprtSqHandle(devId, 1);
    TprtSqHandle* sqHandle2 = new TprtSqHandle(devId, 2);
    tprtDev->sqHandleMap_[1] = sqHandle1;
    tprtDev->sqHandleMap_[2] = sqHandle2;

    std::vector<uint32_t> sqHandleIdList;
    tprtDev->GetAllSqHandleId(sqHandleIdList);

    EXPECT_EQ(sqHandleIdList.size(), 2);
    EXPECT_NE(std::find(sqHandleIdList.begin(), sqHandleIdList.end(), 1), sqHandleIdList.end());
    EXPECT_NE(std::find(sqHandleIdList.begin(), sqHandleIdList.end(), 2), sqHandleIdList.end());

    DELETE_O(sqHandle1);
    DELETE_O(sqHandle2);
    DELETE_O(tprtDev);
}

TEST_F(TprtDeviceTest, RunCheckTaskTimeout_NoSqHandles)
{
    uint32_t devId = 0;
    TprtDevice* tprtDev = new TprtDevice(devId);
    tprtDev->sqHandleMap_.clear();
    tprtDev->RunCheckTaskTimeout();

    DELETE_O(tprtDev);
}

TEST_F(TprtDeviceTest, RunCheckTaskTimeout_WithSqHandles)
{
    uint32_t devId = 0;
    TprtDevice* tprtDev = new TprtDevice(devId);
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    uint32_t sqId = 1;
    TprtSqHandle* sqHandle = new TprtSqHandle(devId, sqId);
    sqHandle->SqSetSqState(TPRT_SQ_STATE_IS_RUNNING);
    sqHandle->sqHead_ = 0U;
    sqHandle->sqTail_ = 1U;
    tprtDev->sqHandleMap_[sqId] = sqHandle;
    tprtDev->RunCheckTaskTimeout();

    sqHandle->Destructor();
    DELETE_O(cce::tprt::TprtManage::tprt_);
    DELETE_O(tprtDev);
}

TEST_F(TprtDeviceTest, RunCheckTaskTimeout_SetWaitInfo)
{
    uint32_t devId = 0;
    TprtDevice* tprtDev = new TprtDevice(devId);

    uint32_t sqId = 1;
    TprtSqHandle* sqHandle = new TprtSqHandle(devId, sqId);
    sqHandle->SqSetSqState(TPRT_SQ_STATE_IS_RUNNING);
    sqHandle->sqHead_ = 0U;
    sqHandle->sqTail_ = 1U;
    TprtSqe_t headTask = {};
    headTask.commonSqe.sqeHeader.taskSn = 1;
    headTask.aicpuSqe.timeout = 1500000U;
    sqHandle->sqQueue_[sqHandle->sqHead_] = headTask;
    tprtDev->sqHandleMap_[sqId] = sqHandle;

    TprtWorker* worker = new TprtWorker(devId, sqHandle, nullptr);
    MOCKER_CPP(&TprtDevice::TprtGetWorkHandleBySqHandle).stubs().will(returnValue(worker));

    MOCKER_CPP(&TprtWorker::TprtWorkerProcessErrorCqe).stubs();

    tprtDev->RunCheckTaskTimeout();

    sqHandle->Destructor();
    DELETE_O(worker);
    DELETE_O(tprtDev);
}

TEST_F(TprtDeviceTest, RunCheckTaskTimeout_Process)
{
    TprtSqHandle* sqHandle = new TprtSqHandle(0, 1);
    sqHandle->SqSetSqState(TPRT_SQ_STATE_IS_RUNNING);
    sqHandle->sqHead_ = 0U;
    sqHandle->sqTail_ = 1U;
    TprtSqe_t headTask = {};
    headTask.commonSqe.sqeHeader.taskSn = 12345U;
    headTask.aicpuSqe.timeout = 30000U;
    sqHandle->sqQueue_[sqHandle->sqHead_] = headTask;
    TprtDevice* tprtDev = new TprtDevice(0);
    tprtDev->sqHandleMap_[1] = sqHandle;

    TprtWorker* worker = new TprtWorker(0, sqHandle, nullptr);
    MOCKER_CPP(&TprtDevice::TprtGetWorkHandleBySqHandle).stubs().will(returnValue(worker));

    MOCKER_CPP(&TprtWorker::TprtWorkerProcessErrorCqe).stubs();

    sqHandle->SetTimeoutWaitInfo();
    tprtDev->RunCheckTaskTimeout();

    sqHandle->sqHead_ = 0U;
    sqHandle->sqTail_ = 0U;
    tprtDev->RunCheckTaskTimeout();

    sqHandle->sqHead_ = 0U;
    sqHandle->sqTail_ = 1U;
    sqHandle->SqSetSqState(TPRT_SQ_STATE_ERROR_ENCOUNTERED);
    tprtDev->RunCheckTaskTimeout();

    sqHandle->Destructor();
    DELETE_O(worker);
    DELETE_O(tprtDev);
}

TEST_F(TprtDeviceTest, GetAllSqHandleId_EmptyMap)
{
    uint32_t devId = 0;
    TprtDevice* tprtDev = new TprtDevice(devId);

    std::vector<uint32_t> sqHandleIdList;
    tprtDev->GetAllSqHandleId(sqHandleIdList);

    EXPECT_EQ(sqHandleIdList.size(), 0);

    DELETE_O(tprtDev);
}
