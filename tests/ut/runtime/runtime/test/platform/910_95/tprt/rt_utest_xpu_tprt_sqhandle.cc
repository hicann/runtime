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
#include "tprt_sqhandle.hpp"
#undef private

using namespace cce::tprt;

class TprtSqHandleTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "TprtSqHandleTest SetUP" << std::endl;

        std::cout << "TprtSqHandleTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "TprtSqHandleTest end" << std::endl;
    }

    virtual void SetUp()
    {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(TprtSqHandleTest, create_TprtSqHandle_Success_01)
{
    TprtSqHandle *sqHdl = new TprtSqHandle(0, 0);
    EXPECT_EQ(sqHdl->sqState_, TPRT_SQ_STATE_IS_RUNNING);
    DELETE_O(sqHdl);
}
