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
#include <string.h>
#include <google/protobuf/util/json_util.h>
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "socket/local_socket.h"
#include "utils/utils.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::socket;

class LOCAL_SOCKET_UTEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(LOCAL_SOCKET_UTEST, LocalSocket_Create) {
    GlobalMockObject::verify();
    int backlog = 1;
    std::string key = "";
    EXPECT_EQ(LocalSocket::Create(key, backlog), PROFILING_FAILED);

    key = "create";
    MOCKER(mmSocket)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_OK));
    EXPECT_EQ(LocalSocket::Create(key, backlog), PROFILING_FAILED);

    MOCKER(mmBind)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_ERROR))
        .then(returnValue(EN_OK));
    MOCKER(mmGetErrorCode)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(EADDRINUSE));
    MOCKER_CPP(&LocalSocket::Close)
        .stubs()
        .will(ignoreReturnValue());
    EXPECT_EQ(LocalSocket::Create(key, backlog), PROFILING_FAILED);
    EXPECT_EQ(LocalSocket::Create(key, backlog), SOCKET_ERR_EADDRINUSE);

    MOCKER(mmListen)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_OK));
    EXPECT_EQ(LocalSocket::Create(key, backlog), PROFILING_FAILED);

    EXPECT_EQ(LocalSocket::Create(key, backlog), EN_OK);
}

TEST_F(LOCAL_SOCKET_UTEST, LocalSocket_Open) {
    GlobalMockObject::verify();
    MOCKER(mmSocket)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_OK));
    int ret = LocalSocket::Open();
    EXPECT_EQ(ret, PROFILING_FAILED);
    ret = LocalSocket::Open();
    EXPECT_EQ(ret, EN_OK);
}

TEST_F(LOCAL_SOCKET_UTEST, LocalSocket_Accept) {
    GlobalMockObject::verify();
    int fd = -1;
    EXPECT_EQ(LocalSocket::Accept(fd), PROFILING_FAILED);
    fd = 1;
    MOCKER(mmAccept)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(-1))
        .then(returnValue(10));
    MOCKER(mmGetErrorCode)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(EAGAIN));
    EXPECT_EQ(LocalSocket::Accept(fd), PROFILING_FAILED);
    EXPECT_EQ(LocalSocket::Accept(fd), SOCKET_ERR_EAGAIN);

    EXPECT_EQ(LocalSocket::Accept(fd), 10);
}

TEST_F(LOCAL_SOCKET_UTEST, LocalSocket_Connect) {
    GlobalMockObject::verify();
    int fd = 1;
    std::string key = "";
    int ret = LocalSocket::Connect(fd, key);
    EXPECT_EQ(ret, PROFILING_FAILED);

    key = "socket";
    MOCKER(mmConnect)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_OK));
    MOCKER_CPP(&LocalSocket::Close)
        .stubs()
        .will(ignoreReturnValue());
    ret = LocalSocket::Connect(fd, key);
    EXPECT_EQ(ret, PROFILING_FAILED);
    ret = LocalSocket::Connect(fd, key);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
}

TEST_F(LOCAL_SOCKET_UTEST, LocalSocket_SetRecvTimeOut) {
    GlobalMockObject::verify();
    int fd = 1;
    long sec = 1;
    long usec = 1;
    MOCKER(setsockopt)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(10));
    int ret = LocalSocket::SetRecvTimeOut(fd, sec, usec);
    EXPECT_EQ(ret, PROFILING_FAILED);
    ret = LocalSocket::SetRecvTimeOut(fd, sec, usec);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
}

TEST_F(LOCAL_SOCKET_UTEST, LocalSocket_SetSendTimeOut) {
    GlobalMockObject::verify();
    int fd = 1;
    long sec = 1;
    long usec = 1;
    MOCKER(setsockopt)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(10));
    int ret = LocalSocket::SetSendTimeOut(fd, sec, usec);
    EXPECT_EQ(ret, PROFILING_FAILED);
    ret = LocalSocket::SetSendTimeOut(fd, sec, usec);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
}

TEST_F(LOCAL_SOCKET_UTEST, LocalSocket_Recv) {
    GlobalMockObject::verify();
    int fd = 0;
    int len = -1;
    int ret = LocalSocket::Recv(fd, &fd, len, fd);
    EXPECT_EQ(ret, PROFILING_FAILED);

    len = 1;
    MOCKER(mmSocketRecv)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(-1))
        .then(returnValue(10));
    MOCKER(mmGetErrorCode)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(EAGAIN));
    EXPECT_EQ(LocalSocket::Recv(fd, &fd, len, fd), PROFILING_FAILED);
    EXPECT_EQ(LocalSocket::Recv(fd, &fd, len, fd), SOCKET_ERR_EAGAIN);
    EXPECT_EQ(LocalSocket::Recv(fd, &fd, len, fd), 10);
}

TEST_F(LOCAL_SOCKET_UTEST, LocalSocket_Send) {
    GlobalMockObject::verify();
    int fd = 0;
    int len = -1;
    int ret = LocalSocket::Send(fd, &fd, len, fd);
    EXPECT_EQ(ret, PROFILING_FAILED);

    len = 1;
    MOCKER(mmSocketSend)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(-1))
        .then(returnValue(0));
    MOCKER(mmGetErrorCode)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(EAGAIN));
    EXPECT_EQ(LocalSocket::Send(fd, &fd, len, fd), PROFILING_FAILED);
    EXPECT_EQ(LocalSocket::Send(fd, &fd, len, fd), SOCKET_ERR_EAGAIN);
    EXPECT_EQ(LocalSocket::Send(fd, &fd, len, fd), PROFILING_SUCCESS);
}

TEST_F(LOCAL_SOCKET_UTEST, LocalSocket_Close) {
    GlobalMockObject::verify();
    int fd = 0;
    MOCKER(mmClose)
        .stubs()
        .will(returnValue(EN_ERROR));
    LocalSocket::Close(fd);
    EXPECT_EQ(fd, -1);
}
