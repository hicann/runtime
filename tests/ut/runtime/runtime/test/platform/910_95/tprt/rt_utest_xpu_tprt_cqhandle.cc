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
#include "tprt_cqhandle.hpp"
#undef private

using namespace cce::tprt;

class TprtCqHandleTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "TprtCqHandleTest SetUP" << std::endl;

        std::cout << "TprtCqHandleTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "TprtCqHandleTest end" << std::endl;
    }

    virtual void SetUp()
    {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(TprtCqHandleTest, create_TprtCqHandle_Success)
{
    TprtCqHandle *cqHdl = new TprtCqHandle(0, 0);
    EXPECT_EQ(cqHdl->devId_, 0);
    DELETE_O(cqHdl);
}

TEST_F(TprtCqHandleTest, when_sqHandle_is_nullptr_TprtCqWriteCqe_should_be_Failed)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxDepth_ = 10U;
    TprtCqHandle *cqHdl = new TprtCqHandle(0, 0);
    TprtSqe_t headTask = {};
    uint32_t error = cqHdl->TprtCqWriteCqe(TPRT_EXIST_ERROR, TPRT_SQE_TYPE_IS_INVALID, &headTask, nullptr);
    EXPECT_EQ(error, TPRT_SQ_HANDLE_INVALID);
    DELETE_O(cqHdl);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtCqHandleTest, when_queue_is_full_TprtCqWriteCqe_should_be_Failed)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxDepth_ = 10U;
    TprtCqHandle *cqHdl = new TprtCqHandle(0, 0);
    TprtSqHandle *sqHdl = new TprtSqHandle(0, 0);
    cqHdl->cqHead_=1U;
    TprtSqe_t headTask = {};
    uint32_t error = cqHdl->TprtCqWriteCqe(TPRT_EXIST_ERROR, TPRT_SQE_TYPE_IS_INVALID, &headTask, sqHdl);
    EXPECT_EQ(error, TPRT_SQ_QUEUE_FULL);
    DELETE_O(sqHdl);
    DELETE_O(cqHdl);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}