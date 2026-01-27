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

#include "commopts/adx_comm_opt_manager.h"
#include "commopts/hdc_comm_opt.h"
#include "commopts/sock_comm_opt.h"
#include <arpa/inet.h>
#include <netinet/tcp.h>
#include "mmpa_api.h"
#include "ide_daemon_stub.h"
#include "memory_utils.h"

using namespace Adx;
class ADX_COMMOPT_MANAGER_UTEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(ADX_COMMOPT_MANAGER_UTEST, CommOptsRegister)
{
    std::unique_ptr<Adx::AdxCommOpt> opt = nullptr;
    bool ret = Adx::AdxCommOptManager::Instance().CommOptsRegister(opt);
    EXPECT_EQ(false, ret);

    opt = std::unique_ptr<Adx::AdxCommOpt>((new Adx::HdcCommOpt()));
    ret = Adx::AdxCommOptManager::Instance().CommOptsRegister(opt);
    EXPECT_EQ(true, ret);

    // redo register
    opt = std::unique_ptr<Adx::AdxCommOpt>((new Adx::HdcCommOpt()));
    ret = Adx::AdxCommOptManager::Instance().CommOptsRegister(opt);
    EXPECT_EQ(true, ret);
}

TEST_F(ADX_COMMOPT_MANAGER_UTEST, OpenServer)
{
    std::map<std::string, std::string> info;
    CommHandle handle = Adx::AdxCommOptManager::Instance().OpenServer(OptType::NR_COMM, info);
    EXPECT_EQ(handle.type, OptType::NR_COMM);
    EXPECT_EQ(handle.session, ADX_OPT_INVALID_HANDLE);
    handle = AdxCommOptManager::Instance().OpenServer(OptType::COMM_HDC, info);
    EXPECT_EQ(handle.type, OptType::COMM_HDC);
    EXPECT_EQ(handle.session, ADX_OPT_INVALID_HANDLE);
    info["0"] = "2";
    handle = AdxCommOptManager::Instance().OpenServer(OptType::COMM_HDC, info);
    EXPECT_EQ(handle.session, -1);
    info["DeviceId"] = "0";
    handle = AdxCommOptManager::Instance().OpenServer(OptType::COMM_HDC, info);
    EXPECT_EQ(handle.session, -1);
    info["ServiceType"] = "a";
    handle = AdxCommOptManager::Instance().OpenServer(OptType::COMM_HDC, info);
    EXPECT_EQ(handle.session, -1);
    info["ServiceType"] = "0";
    info["DeviceId"] = "-1";
    handle = AdxCommOptManager::Instance().OpenServer(OptType::COMM_HDC, info);
    EXPECT_EQ(handle.session, -1);
    info["DeviceId"] = "0";
    handle = AdxCommOptManager::Instance().OpenServer(OptType::COMM_HDC, info);
    EXPECT_EQ(handle.type, OptType::COMM_HDC);
    EXPECT_EQ(handle.session, 0x123245678);
}

TEST_F(ADX_COMMOPT_MANAGER_UTEST, CloseServer)
{
    // session invalid
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_HDC);
    int32_t ret = AdxCommOptManager::Instance().CloseServer(handle);
    EXPECT_EQ(ret, IDE_DAEMON_ERROR);
    handle.session = 123456789;
    ret = AdxCommOptManager::Instance().CloseServer(handle);
    EXPECT_EQ(ret, IDE_DAEMON_OK);
    // not find type
    handle.type = OptType::NR_COMM;
    ret = AdxCommOptManager::Instance().CloseServer(handle);
    EXPECT_EQ(ret, IDE_DAEMON_OK);
}

TEST_F(ADX_COMMOPT_MANAGER_UTEST, OpenClient)
{
    // not found
    std::map<std::string, std::string> info;
    CommHandle handle = AdxCommOptManager::Instance().OpenClient(OptType::NR_COMM, info);
    EXPECT_EQ(handle.type, OptType::NR_COMM);
    EXPECT_EQ(handle.session, ADX_OPT_INVALID_HANDLE);
    // info invalid
    handle = AdxCommOptManager::Instance().OpenClient(OptType::COMM_HDC, info);
    EXPECT_EQ(handle.type, OptType::COMM_HDC);
    EXPECT_EQ(handle.session, ADX_OPT_INVALID_HANDLE);
    // info valid
    info["0"] = "2";
    handle = AdxCommOptManager::Instance().OpenClient(OptType::COMM_HDC, info);
    EXPECT_EQ(handle.session, -1);
    info["ServiceType"] = "a";
    handle = AdxCommOptManager::Instance().OpenClient(OptType::COMM_HDC, info);
    EXPECT_EQ(handle.session, -1);
    info["ServiceType"] = "1000";
    handle = AdxCommOptManager::Instance().OpenClient(OptType::COMM_HDC, info);
    EXPECT_EQ(handle.session, -1);
    info["ServiceType"] = "0";
    handle = AdxCommOptManager::Instance().OpenClient(OptType::COMM_HDC, info);
    EXPECT_EQ(handle.type, OptType::COMM_HDC);
    EXPECT_EQ(handle.session, 0x78563421);
}

TEST_F(ADX_COMMOPT_MANAGER_UTEST, CloseClient)
{
    std::map<std::string, std::string> info;
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_HDC);
    int32_t ret = AdxCommOptManager::Instance().CloseClient(handle);
    EXPECT_EQ(ret, IDE_DAEMON_ERROR);
    handle.session = 123456789;
    ret = AdxCommOptManager::Instance().CloseClient(handle);
    EXPECT_EQ(ret, IDE_DAEMON_OK);
    // not find type
    handle.type = OptType::NR_COMM;
    ret = AdxCommOptManager::Instance().CloseClient(handle);
    EXPECT_EQ(ret, IDE_DAEMON_OK);
}

TEST_F(ADX_COMMOPT_MANAGER_UTEST, Accept)
{
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_HDC);
    CommHandle session = AdxCommOptManager::Instance().Accept(handle);
    EXPECT_EQ(session.session, ADX_OPT_INVALID_HANDLE);
    handle.session = 123456789;
    session = AdxCommOptManager::Instance().Accept(handle);
    EXPECT_EQ(session.session, 0x123456789);
    // not find type
    handle.type = OptType::NR_COMM;
    session = AdxCommOptManager::Instance().Accept(handle);
    EXPECT_EQ(session.session, ADX_OPT_INVALID_HANDLE);
}

TEST_F(ADX_COMMOPT_MANAGER_UTEST, AcceptFail)
{
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_HDC);
    handle.session = 123456789;
    MOCKER(drvHdcSessionAccept).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    CommHandle session = AdxCommOptManager::Instance().Accept(handle);
    EXPECT_EQ(ADX_OPT_INVALID_HANDLE, session.session);
    GlobalMockObject::verify();
    MOCKER(drvHdcSetSessionReference).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    session = AdxCommOptManager::Instance().Accept(handle);
    EXPECT_EQ(ADX_OPT_INVALID_HANDLE, session.session);
    GlobalMockObject::verify();
}

TEST_F(ADX_COMMOPT_MANAGER_UTEST, Connect)
{
    std::map<std::string, std::string> info;
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_HDC);
    CommHandle session = AdxCommOptManager::Instance().Connect(handle, info);
    EXPECT_EQ(session.session, ADX_OPT_INVALID_HANDLE);
    handle.session = 123456789;
    session = AdxCommOptManager::Instance().Connect(handle, info);
    EXPECT_EQ(session.session, ADX_OPT_INVALID_HANDLE);

    handle.session = 123456789;
    info["0"] = "0";
    session = AdxCommOptManager::Instance().Connect(handle, info);
    EXPECT_EQ(session.session, -1);
    info["DeviceId"] = "a";
    session = AdxCommOptManager::Instance().Connect(handle, info);
    EXPECT_EQ(session.session, -1);
    info["DeviceId"] = "0";
    session = AdxCommOptManager::Instance().Connect(handle, info);
    EXPECT_EQ(session.session, 0x123245678);
    info["Pid"] = "-123";
    session = AdxCommOptManager::Instance().Connect(handle, info);
    EXPECT_EQ(session.session, -1);
    info["Pid"] = "a";
    session = AdxCommOptManager::Instance().Connect(handle, info);
    EXPECT_EQ(session.session, -1);

    info["Pid"] = "123";
    session = AdxCommOptManager::Instance().Connect(handle, info);
    EXPECT_EQ(session.session, 0x123245678);
    // not find type
    handle.type = OptType::NR_COMM;
    session = AdxCommOptManager::Instance().Connect(handle, info);
    EXPECT_EQ(session.session, ADX_OPT_INVALID_HANDLE);
}

TEST_F(ADX_COMMOPT_MANAGER_UTEST, ConnectFail)
{
    std::map<std::string, std::string> info;
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_HDC);
    handle.session = 123456789;
    info["DeviceId"] = "0";
    MOCKER(drvHdcSessionConnect).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    CommHandle session = AdxCommOptManager::Instance().Connect(handle, info);
    EXPECT_EQ(ADX_OPT_INVALID_HANDLE, session.session);
    GlobalMockObject::verify();
    MOCKER(drvHdcSetSessionReference).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    session = AdxCommOptManager::Instance().Connect(handle, info);
    EXPECT_EQ(ADX_OPT_INVALID_HANDLE, session.session);
    GlobalMockObject::verify();
    info["Pid"] = "123";
    MOCKER(halHdcSessionConnectEx).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    session = AdxCommOptManager::Instance().Connect(handle, info);
    EXPECT_EQ(ADX_OPT_INVALID_HANDLE, session.session);
    GlobalMockObject::verify();
    MOCKER(drvHdcSetSessionReference).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    session = AdxCommOptManager::Instance().Connect(handle, info);
    EXPECT_EQ(ADX_OPT_INVALID_HANDLE, session.session);
    GlobalMockObject::verify();
}

TEST_F(ADX_COMMOPT_MANAGER_UTEST, Close)
{
    std::map<std::string, std::string> info;
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_HDC);
    int32_t ret = AdxCommOptManager::Instance().Close(handle);
    EXPECT_EQ(ret, IDE_DAEMON_OK);
    handle.session = 123456789;
    ret = AdxCommOptManager::Instance().Close(handle);
    EXPECT_EQ(ret, IDE_DAEMON_OK);

    // not find type
    handle.type = OptType::NR_COMM;
    ret = AdxCommOptManager::Instance().Close(handle);
    EXPECT_EQ(ret, IDE_DAEMON_OK);
}

static hdcError_t DrvHdcAllocMsgStub(HDC_SESSION session, struct drvHdcMsg **ppMsg, signed int count)
{
    char *tmp = "tmp_value.";
    uint32_t len = strlen(tmp);
    struct IdeHdcPacket* packet = NULL;
    packet = (struct IdeHdcPacket *)malloc(len + sizeof(struct IdeHdcPacket));
    packet->type = IdeDaemonPackageType::IDE_DAEMON_LITTLE_PACKAGE;
    packet->len = len;
    packet->isLast = IdeLastPacket::IDE_LAST_PACK;
    memcpy(packet->value, tmp, len);

    *ppMsg = (drvHdcMsg*)packet;
    return DRV_ERROR_NONE;
}

static drvError_t DrvHdcFreeMsgStub(struct drvHdcMsg *msg)
{
    IdeXfree(msg);
    return DRV_ERROR_NONE;
}

TEST_F(ADX_COMMOPT_MANAGER_UTEST, Write)
{
    uint8_t buffer[100] = {0};
    int32_t length = 100;
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_HDC);
    int32_t ret = AdxCommOptManager::Instance().Write(handle, buffer, length, 0);
    EXPECT_EQ(ret, -1);
    handle.session = 123456789;
    ret = AdxCommOptManager::Instance().Write(handle, nullptr, length, 0);
    EXPECT_EQ(ret, -1);
    int32_t invalidLength = 0;
    ret = AdxCommOptManager::Instance().Write(handle, buffer, invalidLength, 0);
    EXPECT_EQ(ret, -1);

    handle.session = 123456789;
    ret = AdxCommOptManager::Instance().Write(handle, buffer, length, COMM_OPT_NOBLOCK);
    EXPECT_EQ(ret, -1);
    ret = AdxCommOptManager::Instance().Write(handle, buffer, length, COMM_OPT_BLOCK);
    EXPECT_EQ(ret, -1);
    // not find type
    handle.type = OptType::NR_COMM;
    ret = AdxCommOptManager::Instance().Write(handle, buffer, length, 0);
    EXPECT_EQ(ret, -1);

    handle.type = OptType::COMM_HDC;
    MOCKER(drvHdcAllocMsg).stubs().will(invoke(DrvHdcAllocMsgStub));
    MOCKER(drvHdcFreeMsg).stubs().will(invoke(DrvHdcFreeMsgStub));
    MOCKER(IdeXmalloc).stubs().will(returnValue((void*)nullptr));
    ret = AdxCommOptManager::Instance().Write(handle, buffer, length, 0);
    EXPECT_EQ(ret, -1);
}

TEST_F(ADX_COMMOPT_MANAGER_UTEST, Read)
{
    void *buffer = nullptr;
    int32_t length = 0;
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_HDC);
    int32_t ret = AdxCommOptManager::Instance().Read(handle, &buffer, length, 0);
    EXPECT_EQ(ret, -1);
    handle.session = 123456789;
    ret = AdxCommOptManager::Instance().Read(handle, nullptr, length, 0);
    EXPECT_EQ(ret, -1);
    ret = AdxCommOptManager::Instance().Read(handle, &buffer, length, 0);
    EXPECT_EQ(ret, -1);

    handle.session = 123456789;
    ret = AdxCommOptManager::Instance().Read(handle, &buffer, length, COMM_OPT_NOBLOCK);
    EXPECT_EQ(ret, -1);
    ret = AdxCommOptManager::Instance().Read(handle, &buffer, length, COMM_OPT_BLOCK);
    EXPECT_EQ(ret, -1);
    // not find type
    handle.type = OptType::NR_COMM;
    ret = AdxCommOptManager::Instance().Read(handle, &buffer, length, 0);
    EXPECT_EQ(ret, -1);
}

TEST_F(ADX_COMMOPT_MANAGER_UTEST, SockCommOptsRegister)
{
    std::unique_ptr<Adx::AdxCommOpt> opt = nullptr;
    bool ret = Adx::AdxCommOptManager::Instance().CommOptsRegister(opt);
    EXPECT_EQ(false, ret);

    opt = std::unique_ptr<Adx::AdxCommOpt>((new Adx::SockCommOpt()));
    ret = Adx::AdxCommOptManager::Instance().CommOptsRegister(opt);
    EXPECT_EQ(true, ret);

    // redo register
    opt = std::unique_ptr<Adx::AdxCommOpt>((new Adx::SockCommOpt()));
    ret = Adx::AdxCommOptManager::Instance().CommOptsRegister(opt);
    EXPECT_EQ(true, ret);
}

TEST_F(ADX_COMMOPT_MANAGER_UTEST, SockOpenServer)
{
    std::map<std::string, std::string> info;
    CommHandle handle = Adx::AdxCommOptManager::Instance().OpenServer(OptType::NR_COMM, info);
    EXPECT_EQ(handle.type, OptType::NR_COMM);
    EXPECT_EQ(handle.session, ADX_OPT_INVALID_HANDLE);
    handle = AdxCommOptManager::Instance().OpenServer(OptType::COMM_LOCAL, info);
    EXPECT_EQ(handle.type, OptType::COMM_LOCAL);
    EXPECT_EQ(handle.session, ADX_OPT_INVALID_HANDLE);
    info["0"] = "2";

    info["DeviceId"] = "0";
    handle = AdxCommOptManager::Instance().OpenServer(OptType::COMM_LOCAL, info);
    EXPECT_EQ(handle.session, ADX_OPT_INVALID_HANDLE);
    info["ServiceType"] = "0";
    handle = AdxCommOptManager::Instance().OpenServer(OptType::COMM_LOCAL, info);
    EXPECT_EQ(handle.type, OptType::COMM_LOCAL);
    EXPECT_EQ(handle.session, 1);

    info["0"] = "2";
    info["ServiceType"] = "0";
    MOCKER(close).stubs()
        .will(invoke(close_stub));
    MOCKER(strcpy_s).stubs()
            .will(returnValue(-1))
            .then(returnValue(EOK));
    handle = AdxCommOptManager::Instance().OpenServer(OptType::COMM_LOCAL, info);
    EXPECT_EQ(handle.type, OptType::COMM_LOCAL);
    EXPECT_EQ(handle.session, -1);

    MOCKER(mmBind).stubs()
            .will(returnValue(-1))
            .then(returnValue(EOK));
    handle = AdxCommOptManager::Instance().OpenServer(OptType::COMM_LOCAL, info);
    EXPECT_EQ(handle.type, OptType::COMM_LOCAL);
    EXPECT_EQ(handle.session, -1);

    MOCKER(mmListen).stubs()
            .will(returnValue(-1));
    handle = AdxCommOptManager::Instance().OpenServer(OptType::COMM_LOCAL, info);
    EXPECT_EQ(handle.type, OptType::COMM_LOCAL);
    EXPECT_EQ(handle.session, -1);
}


TEST_F(ADX_COMMOPT_MANAGER_UTEST, SockCloseServer)
{
    // session invalid
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_LOCAL);
    int32_t ret = AdxCommOptManager::Instance().CloseServer(handle);
    EXPECT_EQ(ret, IDE_DAEMON_ERROR);
    handle.session = 123456789;
    ret = AdxCommOptManager::Instance().CloseServer(handle);
    EXPECT_EQ(ret, IDE_DAEMON_OK);
    // session invalid1
    handle.session = -2;
    ret = AdxCommOptManager::Instance().CloseServer(handle);
    EXPECT_EQ(ret, IDE_DAEMON_ERROR);
    // not find type
    handle.type = OptType::NR_COMM;
    ret = AdxCommOptManager::Instance().CloseServer(handle);
    EXPECT_EQ(ret, IDE_DAEMON_OK);
}

TEST_F(ADX_COMMOPT_MANAGER_UTEST, SockOpenClient)
{
    // not found
    std::map<std::string, std::string> info;
    CommHandle handle = AdxCommOptManager::Instance().OpenClient(OptType::NR_COMM, info);
    EXPECT_EQ(handle.type, OptType::NR_COMM);
    EXPECT_EQ(handle.session, ADX_OPT_INVALID_HANDLE);
    // info invalid
    handle = AdxCommOptManager::Instance().OpenClient(OptType::COMM_LOCAL, info);
    EXPECT_EQ(handle.type, OptType::COMM_LOCAL);
    EXPECT_EQ(handle.session, 1);
    // info valid
    info["0"] = "2";
    info["ServiceType"] = "0";
    handle = AdxCommOptManager::Instance().OpenClient(OptType::COMM_LOCAL, info);
    EXPECT_EQ(handle.type, OptType::COMM_LOCAL);
    EXPECT_EQ(handle.session, 1);
}

TEST_F(ADX_COMMOPT_MANAGER_UTEST, SockCloseClient)
{
    std::map<std::string, std::string> info;
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_LOCAL);
    int32_t ret = AdxCommOptManager::Instance().CloseClient(handle);
    EXPECT_EQ(ret, IDE_DAEMON_ERROR);
    handle.session = 123456789;
    ret = AdxCommOptManager::Instance().CloseClient(handle);
    EXPECT_EQ(ret, IDE_DAEMON_OK);
    // not find type
    handle.type = OptType::NR_COMM;
    ret = AdxCommOptManager::Instance().CloseClient(handle);
    EXPECT_EQ(ret, IDE_DAEMON_OK);
}

TEST_F(ADX_COMMOPT_MANAGER_UTEST, SockAccept)
{
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_LOCAL);
    CommHandle session = AdxCommOptManager::Instance().Accept(handle);
    EXPECT_EQ(session.session, ADX_OPT_INVALID_HANDLE);
    handle.session = 123456789;
    MOCKER(mmAccept).stubs()
        .will(returnValue(-1))
        .then(returnValue(1));
    session = AdxCommOptManager::Instance().Accept(handle);
    EXPECT_EQ(session.session, ADX_OPT_INVALID_HANDLE);
    session = AdxCommOptManager::Instance().Accept(handle);
    EXPECT_EQ(session.session, 1);
    // not find type
    handle.type = OptType::NR_COMM;
    session = AdxCommOptManager::Instance().Accept(handle);
    EXPECT_EQ(session.session, ADX_OPT_INVALID_HANDLE);
}

TEST_F(ADX_COMMOPT_MANAGER_UTEST, SockConnect)
{
    std::map<std::string, std::string> info;
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_LOCAL);
    CommHandle session = AdxCommOptManager::Instance().Connect(handle, info);
    EXPECT_EQ(session.session, ADX_OPT_INVALID_HANDLE);
    handle.session = 123456789;
    session = AdxCommOptManager::Instance().Connect(handle, info);
    EXPECT_EQ(session.session, ADX_OPT_INVALID_HANDLE);

    MOCKER(accept).stubs()
            .will(returnValue(1));

    handle.session = 123456789;
    info["0"] = "0";
    info["DeviceId"] = "0";
    info["ServiceType"] = "0";
    session = AdxCommOptManager::Instance().Connect(handle, info);
    EXPECT_EQ(session.session, 123456789);

    info["Pid"] = "123";
    session = AdxCommOptManager::Instance().Connect(handle, info);
    EXPECT_EQ(session.session,123456789);

    MOCKER(strcpy_s).stubs()
            .will(returnValue(-1))
            .then(returnValue(EOK));
    session = AdxCommOptManager::Instance().Connect(handle, info);
    EXPECT_EQ(session.session, ADX_OPT_INVALID_HANDLE);

    MOCKER(mmConnect).stubs()
            .will(returnValue(-1))
            .then(returnValue(EOK));
    session = AdxCommOptManager::Instance().Connect(handle, info);
    EXPECT_EQ(session.session, ADX_OPT_INVALID_HANDLE);

    // not find type
    handle.type = OptType::NR_COMM;
    session = AdxCommOptManager::Instance().Connect(handle, info);
    EXPECT_EQ(session.session, ADX_OPT_INVALID_HANDLE);
}

TEST_F(ADX_COMMOPT_MANAGER_UTEST, SockClose)
{
    std::map<std::string, std::string> info;
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_LOCAL);
    int32_t ret = AdxCommOptManager::Instance().Close(handle);
    EXPECT_EQ(ret, IDE_DAEMON_ERROR);
    handle.session = 123456789;
    ret = AdxCommOptManager::Instance().Close(handle);
    EXPECT_EQ(ret, IDE_DAEMON_OK);

    handle.session = -2;
    ret = AdxCommOptManager::Instance().Close(handle);
    EXPECT_EQ(ret, IDE_DAEMON_ERROR);

    // not find type
    handle.type = OptType::NR_COMM;
    ret = AdxCommOptManager::Instance().Close(handle);
    EXPECT_EQ(ret, IDE_DAEMON_OK);
}

TEST_F(ADX_COMMOPT_MANAGER_UTEST, SockWrite)
{
    uint8_t buffer[100] = {0};
    int32_t length = 100;
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_LOCAL);
    int32_t ret = AdxCommOptManager::Instance().Write(handle, buffer, length, 0);
    EXPECT_EQ(ret, -1);
    handle.session = 123456789;
    ret = AdxCommOptManager::Instance().Write(handle, nullptr, length, 0);
    EXPECT_EQ(ret, -1);
    int32_t invalidLength = 0;
    ret = AdxCommOptManager::Instance().Write(handle, buffer, invalidLength, 0);
    EXPECT_EQ(ret, -1);
    MOCKER(accept).stubs()
                .will(returnValue(1));

    handle.session = 123456789;
    ret = AdxCommOptManager::Instance().Write(handle, buffer, length, COMM_OPT_NOBLOCK);
    EXPECT_EQ(ret, 0);
    ret = AdxCommOptManager::Instance().Write(handle, buffer, length, COMM_OPT_BLOCK);
    EXPECT_EQ(ret, 0);

    MOCKER(mmSocketSend).stubs()
        .will(returnValue(-1));
    ret = AdxCommOptManager::Instance().Write(handle, buffer, length, COMM_OPT_NOBLOCK);
    EXPECT_EQ(ret, -1);

    handle.session = -2;
    ret = AdxCommOptManager::Instance().Write(handle, buffer, length, COMM_OPT_NOBLOCK);
    EXPECT_EQ(ret, -1);
    // not find type
    handle.type = OptType::NR_COMM;
    ret = AdxCommOptManager::Instance().Write(handle, buffer, length, 0);
    EXPECT_EQ(ret, -1);
}

TEST_F(ADX_COMMOPT_MANAGER_UTEST, SockRead)
{
    void *buffer[100] = {0};
    int32_t length = 100;
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_LOCAL);

    int32_t ret = AdxCommOptManager::Instance().Read(handle, buffer, length, 0);
    EXPECT_EQ(ret, -1);
    handle.session = 123456789;
    ret = AdxCommOptManager::Instance().Read(handle, nullptr, length, COMM_OPT_NOBLOCK);
    EXPECT_EQ(ret, -1);
    ret = AdxCommOptManager::Instance().Read(handle, buffer, length, COMM_OPT_NOBLOCK);
    EXPECT_EQ(ret, -1);

    handle.session = 123456789;
    ret = AdxCommOptManager::Instance().Read(handle, buffer, length, COMM_OPT_NOBLOCK);
    EXPECT_EQ(ret, -1);
    ret = AdxCommOptManager::Instance().Read(handle, buffer, length, COMM_OPT_BLOCK);
    EXPECT_EQ(ret, -1);

    handle.session = -1;
    ret = AdxCommOptManager::Instance().Read(handle, buffer, length, COMM_OPT_BLOCK);
    EXPECT_EQ(ret, -1);

// not find type
    handle.type = OptType::NR_COMM;
    ret = AdxCommOptManager::Instance().Read(handle, buffer, length, COMM_OPT_NOBLOCK);
    EXPECT_EQ(ret, -1);
}
