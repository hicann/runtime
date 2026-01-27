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
    {

    }

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
    TprtDevice *tprtDev = new TprtDevice(devId);
    uint32_t ret = tprtDev->TprtSqCqAlloc(sqId,cqId);
    EXPECT_EQ(ret, TPRT_SUCCESS);
    DELETE_O(tprtDev);
}

TEST_F(TprtDeviceTest, TprtSqCqAlloc_sqHandle_duplicate_Fail)
{
    uint32_t sqId = 0;
    uint32_t cqId = 0;
    uint32_t devId = 0;
    TprtDevice *tprtDev = new TprtDevice(devId);
    TprtSqHandle *sqHandle = new (std::nothrow) TprtSqHandle(0, 0);
    tprtDev->sqHandleMap_[0] = sqHandle;
    uint32_t ret = tprtDev->TprtSqCqAlloc(sqId, cqId);
    EXPECT_EQ(ret, TPRT_SQ_HANDLE_INVALID);
    DELETE_O(sqHandle);
    DELETE_O(tprtDev);
}

TEST_F(TprtDeviceTest, TprtSqCqAlloc_cqHandle_duplicate_Fail)
{
    uint32_t sqId = 0;
    uint32_t cqId = 0;
    uint32_t devId = 0;
    TprtDevice *tprtDev = new TprtDevice(devId);
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
    TprtDevice *tprtDev = new TprtDevice(devId);
    uint32_t ret = tprtDev->TprtSqCqAlloc(sqId,cqId);
    EXPECT_EQ(ret, TPRT_START_WORKER_FAILED);
    DELETE_O(tprtDev);
}

TEST_F(TprtDeviceTest, TprtSqCqAlloc_worker_start2_Fail)
{
    MOCKER(mmSemInit).stubs().will(returnValue(TPRT_START_WORKER_FAILED));
    uint32_t sqId = 0;
    uint32_t cqId = 0;
    uint32_t devId = 0;
    TprtDevice *tprtDev = new TprtDevice(devId);
    uint32_t ret = tprtDev->TprtSqCqAlloc(sqId,cqId);
    EXPECT_EQ(ret, TPRT_START_WORKER_FAILED);
    DELETE_O(tprtDev);
}