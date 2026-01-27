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
#include "tprt_log.hpp"
#include "tprt_base.hpp"
#undef private
using namespace cce::tprt;
class TprtLogTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "TprtLogTest SetUP" << std::endl;

        std::cout << "TprtLogTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "TprtLogTest end" << std::endl;
    }

    virtual void SetUp()
    {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(TprtLogTest, tprt_log_1)
{
    RecordErrorLog(__FILE__, __LINE__, __FUNCTION__, nullptr);
    RecordLog(DLOG_DEBUG, __FILE__, __LINE__, __FUNCTION__, nullptr);
    EXPECT_TRUE(true);
}

TEST_F(TprtLogTest, tprt_log_2)
{
    RecordErrorLog(__FILE__, __LINE__, __FUNCTION__, "%s", "unknown error");
    RecordLog(DLOG_DEBUG, __FILE__, __LINE__, __FUNCTION__, "%s", "unknown error");
    EXPECT_TRUE(true);
}