/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include "mockcpp/mockcpp.hpp"
#define protected public
#define private public

#include "epoll/adx_hdc_epoll.h"
#include "commopts/hdc_comm_opt.h"
#include "create_func.h"
using namespace Adx;
class CREATE_FUNC_TEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(CREATE_FUNC_TEST, CreateAdxEpoll)
{
    EpollType epollType = EpollType::EPOLL_HDC;
    EXPECT_NE(nullptr, CreateAdxEpoll(epollType));
    epollType = EpollType::NR_EPOLL;
    EXPECT_EQ(nullptr, CreateAdxEpoll(epollType));
}

TEST_F(CREATE_FUNC_TEST, CreateAdxCommOpt)
{
    OptType optType = OptType::COMM_HDC;
    EXPECT_NE(nullptr, CreateAdxCommOpt(optType));
    optType = OptType::NR_COMM;
    EXPECT_EQ(nullptr, CreateAdxCommOpt(optType));
}