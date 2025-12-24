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
#include <string>
#include <google/protobuf/util/json_util.h>
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "socket/local_socket.h"
#include "utils/utils.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::socket;

class LOCAL_SOCKET_STEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(LOCAL_SOCKET_STEST, LocalSocket_create)
{
    GlobalMockObject::verify();
    SHARED_PTR_ALIA<LocalSocket> localSocket;
    localSocket = std::make_shared<LocalSocket>();
    int backlog = 1;
    std::string key = "";
    int ret = localSocket->Create(key, backlog);
    EXPECT_EQ(ret, PROFILING_FAILED);

    key = "create";
    MOCKER(mmSocket)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_OK))
        .then(returnValue(EN_OK))
        .then(returnValue(EN_OK));
    ret = localSocket->Create(key, backlog);
    EXPECT_EQ(ret, PROFILING_FAILED);

    MOCKER(mmBind)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_OK))
        .then(returnValue(EN_OK));
    MOCKER_CPP(&LocalSocket::Close)
        .stubs()
        .will(ignoreReturnValue())
        .then(ignoreReturnValue());
    ret = localSocket->Create(key, backlog);
    EXPECT_EQ(ret, PROFILING_FAILED);

    MOCKER(mmListen)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_OK));
    ret = localSocket->Create(key, backlog);
    EXPECT_EQ(ret, PROFILING_FAILED);

    ret = localSocket->Create(key, backlog);
    EXPECT_EQ(ret, EN_OK);
}

TEST_F(LOCAL_SOCKET_STEST, LocalSocket_Open) {
    GlobalMockObject::verify();
    SHARED_PTR_ALIA<LocalSocket> localSocket;
    localSocket = std::make_shared<LocalSocket>();
    MOCKER(mmSocket)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_OK));
    int ret = localSocket->Open();
    EXPECT_EQ(ret, PROFILING_FAILED);
    ret = localSocket->Open();
    EXPECT_EQ(ret, EN_OK);
}

TEST_F(LOCAL_SOCKET_STEST, LocalSocket_Accept) {
    GlobalMockObject::verify();
    SHARED_PTR_ALIA<LocalSocket> localSocket;
    localSocket = std::make_shared<LocalSocket>();
    int fd = -1;
    int ret = localSocket->Accept(fd);
    EXPECT_EQ(ret, PROFILING_FAILED);
    fd = 1;
    MOCKER(mmAccept)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(10));
    ret = localSocket->Accept(fd);
    EXPECT_EQ(ret, PROFILING_FAILED);

    ret = localSocket->Accept(fd);
    EXPECT_EQ(ret, 10);
}

TEST_F(LOCAL_SOCKET_STEST, LocalSocket_Connect) {
    GlobalMockObject::verify();
    SHARED_PTR_ALIA<LocalSocket> localSocket;
    localSocket = std::make_shared<LocalSocket>();
    int fd = 1;
    std::string key = "";
    int ret = localSocket->Connect(fd, key);
    EXPECT_EQ(ret, PROFILING_FAILED);

    key = "socket";
    MOCKER(mmConnect)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_OK));
    MOCKER_CPP(&LocalSocket::Close)
        .stubs()
        .will(ignoreReturnValue());
    ret = localSocket->Connect(fd, key);
    EXPECT_EQ(ret, PROFILING_FAILED);
    ret = localSocket->Connect(fd, key);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
}

TEST_F(LOCAL_SOCKET_STEST, LocalSocket_SetRecvTimeOut) {
    GlobalMockObject::verify();
    SHARED_PTR_ALIA<LocalSocket> localSocket;
    localSocket = std::make_shared<LocalSocket>();
    int fd = 1;
    long sec = 1;
    long usec = 1;
    MOCKER(setsockopt)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(10));
    int ret = localSocket->SetRecvTimeOut(fd, sec, usec);
    EXPECT_EQ(ret, PROFILING_FAILED);
    ret = localSocket->SetRecvTimeOut(fd, sec, usec);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
}

TEST_F(LOCAL_SOCKET_STEST, LocalSocket_SetSendTimeOut) {
    GlobalMockObject::verify();
    SHARED_PTR_ALIA<LocalSocket> localSocket;
    localSocket = std::make_shared<LocalSocket>();
    int fd = 1;
    long sec = 1;
    long usec = 1;
    MOCKER(setsockopt)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(10));
    int ret = localSocket->SetSendTimeOut(fd, sec, usec);
    EXPECT_EQ(ret, PROFILING_FAILED);
    ret = localSocket->SetSendTimeOut(fd, sec, usec);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
}

TEST_F(LOCAL_SOCKET_STEST, LocalSocket_Recv) {
    GlobalMockObject::verify();
    SHARED_PTR_ALIA<LocalSocket> localSocket;
    localSocket = std::make_shared<LocalSocket>();
    int fd = 0;
    int len = -1;
    int ret = localSocket->Recv(fd, &fd, len, fd);
    EXPECT_EQ(ret, PROFILING_FAILED);

    len = 1;
    MOCKER(mmSocketRecv)
        .stubs()
        .will(returnValue(-1));
    ret = localSocket->Recv(fd, &fd, len, fd);
    EXPECT_EQ(ret, PROFILING_FAILED);
}

TEST_F(LOCAL_SOCKET_STEST, LocalSocket_Send) {
    GlobalMockObject::verify();
    SHARED_PTR_ALIA<LocalSocket> localSocket;
    localSocket = std::make_shared<LocalSocket>();
    int fd = 0;
    int len = -1;
    int ret = localSocket->Send(fd, &fd, len, fd);
    EXPECT_EQ(ret, PROFILING_FAILED);

    len = 1;
    MOCKER(mmSocketSend)
        .stubs()
        .will(returnValue(-1));
    ret = localSocket->Send(fd, &fd, len, fd);
    EXPECT_EQ(ret, PROFILING_FAILED);
}

TEST_F(LOCAL_SOCKET_STEST, LocalSocket_Close) {
    GlobalMockObject::verify();
    SHARED_PTR_ALIA<LocalSocket> localSocket;
    localSocket = std::make_shared<LocalSocket>();
    int fd = 0;
    MOCKER(mmClose)
        .stubs()
        .will(returnValue(EN_ERROR));
    localSocket->Close(fd);
    EXPECT_EQ(fd, -1);
}
