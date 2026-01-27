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
#include "epoll/adx_sock_epoll.h"
#include "extra_config.h"
#include <sys/epoll.h>
using namespace Adx;
class ADX_SOCK_EPOLL_STEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(ADX_SOCK_EPOLL_STEST, EpollCreate)
{
    std::shared_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::make_shared<Adx::AdxSockEpoll>();

    const int invalidSize = -1;
    EXPECT_EQ(IDE_DAEMON_ERROR, epoll->EpollCreate(invalidSize));

    MOCKER(epoll_create).stubs().will(returnValue(-1)).then(returnValue(0));

    const int validSize = 1;
    EXPECT_EQ(IDE_DAEMON_ERROR, epoll->EpollCreate(validSize));
    EXPECT_EQ(IDE_DAEMON_OK, epoll->EpollCreate(validSize));
}

TEST_F(ADX_SOCK_EPOLL_STEST, EpollDestroy)
{
    std::shared_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::make_shared<Adx::AdxSockEpoll>();

    EXPECT_EQ(0, epoll->EpollDestroy());
}

TEST_F(ADX_SOCK_EPOLL_STEST, EpollCtl)
{
    std::shared_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::make_shared<Adx::AdxSockEpoll>();
    const int validSize = 1;
    int ret = epoll->EpollCreate(validSize);

    EpollEvent event;
    event.events = -1;
    event.data = -1;

    EpollHandle handle = -1;
    EXPECT_EQ(-1, epoll->EpollCtl(handle, event, EPOLL_CTL_ADD));

    event.events = 1;
    event.data = 1;
    handle = 1;
    MOCKER(epoll_ctl).stubs().will(returnValue(0));
    EXPECT_EQ(0, epoll->EpollCtl(handle, event, EPOLL_CTL_ADD));
}

TEST_F(ADX_SOCK_EPOLL_STEST, EpollAdd)
{
    std::shared_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::make_shared<Adx::AdxSockEpoll>();
    const int validSize = 1;
    int ret = epoll->EpollCreate(validSize);

    EpollEvent event;

    event.events = 1;
    event.data = 1;
    EpollHandle handle = 1;
    MOCKER(epoll_ctl).stubs().will(returnValue(0));
    EXPECT_EQ(0, epoll->EpollAdd(handle, event));
}

TEST_F(ADX_SOCK_EPOLL_STEST, EpollDel)
{
    std::shared_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::make_shared<Adx::AdxSockEpoll>();
    const int validSize = 1;
    int ret = epoll->EpollCreate(validSize);

    EpollEvent event;
    event.events = 1;
    event.data = 1;
    EpollHandle handle = 1;
    MOCKER(epoll_ctl).stubs().will(returnValue(0));
    EXPECT_EQ(0, epoll->EpollDel(handle, event));
}

TEST_F(ADX_SOCK_EPOLL_STEST, EpollWait)
{
    std::shared_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::make_shared<Adx::AdxSockEpoll>();
    const int validSize = 2;
    int ret = epoll->EpollCreate(validSize);

    int32_t size = 0;
    std::vector<EpollEvent> event(1);
    event[0].events = -1;
    event[0].data = -1;
    int32_t timeout = 0;
    EXPECT_EQ(-1, epoll->EpollWait(event, size, timeout));

    event[0].events = 1;
    event[0].data = 1;
    MOCKER(epoll_wait).stubs().will(returnValue(-1)).then(returnValue(1));
    EXPECT_EQ(-1, epoll->EpollWait(event, size, timeout));
    EXPECT_EQ(1, epoll->EpollWait(event, size, timeout));
}

TEST_F(ADX_SOCK_EPOLL_STEST, EpollErrorHandle)
{
    std::shared_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::make_shared<Adx::AdxSockEpoll>();

    EXPECT_EQ(0, epoll->EpollErrorHandle());
}

TEST_F(ADX_SOCK_EPOLL_STEST, EpollGetSize)
{
    std::shared_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::make_shared<Adx::AdxSockEpoll>();

    EXPECT_EQ(128, epoll->EpollGetSize());
}
