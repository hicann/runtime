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
#include "tprt.hpp"
#include "tprt_base.hpp"
#include "tprt_sqhandle.hpp"
#include "tprt_cqhandle.hpp"
#include "tprt_worker.hpp"
#undef private


using namespace cce::tprt;

class TprtWorkerTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "TprtWorkerTest SetUP" << std::endl;

        std::cout << "TprtWorkerTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "TprtWorkerTest end" << std::endl;
    }

    virtual void SetUp()
    {

    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(TprtWorkerTest, create_TprtWorker_Success_01)
{
    TprtSqHandle *sqHdl = new TprtSqHandle(0, 0);
    TprtCqHandle *cqHdl = new TprtCqHandle(0, 0);
    TprtWorker *worker = new TprtWorker(0, sqHdl, cqHdl);
    EXPECT_EQ(worker->workerName_, "0_0");
    DELETE_O(sqHdl);
    DELETE_O(cqHdl);
    DELETE_O(worker);
}

TEST_F(TprtWorkerTest, create_TprtWorker_error)
{
    MOCKER(mmGetTid).stubs().will(returnValue(101));
    TprtSqHandle *sqHdl = new TprtSqHandle(0, 0);
    TprtCqHandle *cqHdl = new TprtCqHandle(0, 0);
    TprtWorker *worker = new TprtWorker(0, sqHdl, cqHdl);
    MOCKER(mmSemInit).stubs().will(returnValue(TPRT_INPUT_NULL));
    uint32_t ans = worker->TprtWorkerStart();
    delete sqHdl;
    delete cqHdl;
    delete worker;
}
