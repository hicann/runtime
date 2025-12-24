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
#include "epoll/adx_epoll.h"
#include "epoll/adx_hdc_epoll.h"
#include "ide_daemon_stub.h"
using namespace Adx;
class ADX_HDC_EPOLL_UTEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(ADX_HDC_EPOLL_UTEST, EpollCreate)
{
    std::shared_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::make_shared<Adx::AdxHdcEpoll>();

    const int invalidSize = -1;
    const int validSize = 1;
    MOCKER(drvHdcEpollCreate).stubs()
        .will(returnValue(-1));

    int ret = epoll->EpollCreate(invalidSize);
    EXPECT_EQ(IDE_DAEMON_ERROR, ret);

    ret = epoll->EpollCreate(validSize);
    EXPECT_EQ(IDE_DAEMON_ERROR, ret);
}
/*
TEST_F(ADX_HDC_EPOLL_UTEST, EpollDestroy)
{

    std::shared_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::make_shared<Adx::AdxHdcEpoll>();

    MOCKER(drvHdcEpollClose).stubs()
        .will(returnValue(-1));
    EXPECT_EQ(-1, epoll->EpollDestroy());
}
*/

TEST_F(ADX_HDC_EPOLL_UTEST, EpollCtl)
{

    std::shared_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::make_shared<Adx::AdxHdcEpoll>();

    EpollEvent event;
    event.events = -1;
    event.data = -1;

    EpollHandle handle = -1;
    EXPECT_EQ(-1, epoll->EpollCtl(handle, event, HDC_EPOLL_CTL_ADD));

    handle = 1;
    MOCKER(drvHdcEpollCtl).stubs()
        .will(returnValue(-1));

    EXPECT_EQ(-1, epoll->EpollCtl(handle, event, HDC_EPOLL_CTL_ADD));
}

TEST_F(ADX_HDC_EPOLL_UTEST, EpollWait)
{
    std::shared_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::make_shared<Adx::AdxHdcEpoll>();

    int32_t size = 0;
    std::vector<EpollEvent> event(1);
    event[0].events = -1;
    event[0].data = -1;
    int32_t timeout = 0;
    EXPECT_EQ(-1, epoll->EpollWait(event, size, timeout));

    MOCKER(drvHdcEpollWait).stubs()
        .will(returnValue(-1));

    EXPECT_EQ(-1, epoll->EpollWait(event, size, timeout));
}

TEST_F(ADX_HDC_EPOLL_UTEST, EpollErrorHandle)
{
    std::shared_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::make_shared<Adx::AdxHdcEpoll>();

    EXPECT_EQ(0, epoll->EpollErrorHandle());
}

TEST_F(ADX_HDC_EPOLL_UTEST, EpollGetSize)
{
    std::shared_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::make_shared<Adx::AdxHdcEpoll>();

    EXPECT_EQ(128, epoll->EpollGetSize());

}
