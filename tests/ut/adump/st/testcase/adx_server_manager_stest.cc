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

#include "component/adx_server_manager.h"
#include "commopts/hdc_comm_opt.h"
#include "epoll/adx_hdc_epoll.h"
#include "protocol/adx_msg_proto.h"
#include "log/adx_log.h"
#include "memory_utils.h"
#include "hdc_api.h"
#include "adx_dump_receive.h"

using namespace Adx;

class ADX_SERVER_MANAGER_STEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(ADX_SERVER_MANAGER_STEST, RegisterEpoll)
{
    Adx::AdxServerManager server;
    std::unique_ptr<Adx::AdxEpoll> epoll = nullptr;
    bool ret = server.RegisterEpoll(epoll);
    EXPECT_EQ(false, ret);
    epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    ret = server.RegisterEpoll(epoll);
    EXPECT_EQ(true, ret);
}

TEST_F(ADX_SERVER_MANAGER_STEST, RegisterCommOpt)
{
    Adx::AdxCommOptManager::Instance().commOptMap_.clear();
    Adx::AdxServerManager server;
    std::unique_ptr<Adx::AdxCommOpt> opt = nullptr;
    bool ret = server.RegisterCommOpt(opt, std::to_string(3)); // 3 -> hdc service type
    EXPECT_EQ(false, ret);
    opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    ret = server.RegisterCommOpt(opt, std::to_string(3));
    EXPECT_EQ(true, ret);
}

TEST_F(ADX_SERVER_MANAGER_STEST, ServerInit)
{
    Adx::AdxServerManager server;
    std::map<std::string, std::string> info;
    bool ret = server.ServerInit(info);
    EXPECT_EQ(false, ret);
    std::unique_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    ret = server.RegisterEpoll(epoll);
    EXPECT_EQ(true, ret);
    std::unique_ptr<Adx::AdxCommOpt> opt = nullptr;
    ret = server.RegisterCommOpt(opt, std::to_string(3)); // 3 -> hdc service type
    EXPECT_EQ(false, ret);
    opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    ret = server.RegisterCommOpt(opt, std::to_string(3));
    EXPECT_EQ(true, ret);
    EXPECT_EQ(false, server.ServerInit(info));
    EXPECT_EQ(false, server.ServerInit(info));
    info["0"] = "0";
    info["1"] = "1";
    info["DeviceId"] = "0";
    info["ServiceType"] = "0";
    ret = server.ServerInit(info);
    EXPECT_EQ(true, ret);
}

TEST_F(ADX_SERVER_MANAGER_STEST, ServerInitEpollAddFailed)
{
    Adx::AdxServerManager server;
    std::map<std::string, std::string> info;
    bool ret = server.ServerInit(info);
    EXPECT_EQ(false, ret);
    std::unique_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    ret = server.RegisterEpoll(epoll);
    EXPECT_EQ(true, ret);
    std::unique_ptr<Adx::AdxCommOpt> opt = nullptr;
    opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    ret = server.RegisterCommOpt(opt, std::to_string(3)); // 3 -> hdc service type
    EXPECT_EQ(true, ret);
    info["0"] = "0";
    info["1"] = "1";
    info["DeviceId"] = "0";
    info["ServiceType"] = "0";
    MOCKER(drvHdcEpollCtl).stubs()
        .will(returnValue(DRV_ERROR_DEVICE_NOT_READY));
    ret = server.ServerInit(info);
    EXPECT_EQ(false, ret);
}

TEST_F(ADX_SERVER_MANAGER_STEST, AdxServerManagerExit)
{
    Adx::AdxServerManager server;
    std::map<std::string, std::string> info;
    std::unique_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    bool ret = server.RegisterEpoll(epoll);
    EXPECT_EQ(true, ret);
    std::unique_ptr<Adx::AdxCommOpt> opt = nullptr;
    ret = server.RegisterCommOpt(opt, std::to_string(3)); // 3 -> hdc service type
    EXPECT_EQ(false, ret);
    opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    ret = server.RegisterCommOpt(opt, std::to_string(3));
    EXPECT_EQ(true, ret);
    info["0"] = "0";
    info["1"] = "1";
    info["DeviceId"] = "0";
    info["ServiceType"] = "0";
    ret = server.ServerInit(info);
    EXPECT_EQ(true, ret);

    MOCKER_CPP(&Adx::AdxServerManager::ServerInit)
    .stubs()
    .will(returnValue(false))
    .then(returnValue(true));

    MOCKER(drvHdcEpollClose).stubs()
    .will(returnValue(DRV_ERROR_DEVICE_NOT_READY))
    .then(returnValue(DRV_ERROR_NONE));
}

TEST_F(ADX_SERVER_MANAGER_STEST, CommOptServerUnInit)
{
    Adx::AdxServerManager server;
    std::map<std::string, std::string> info;
    OptHandle epHandle = Adx::ADX_OPT_INVALID_HANDLE;
    bool ret = server.ServerUnInit(epHandle);
    EXPECT_EQ(false, ret);
    epHandle = 1;
    EXPECT_EQ(false, server.ServerUnInit(epHandle));
    std::unique_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    ret = server.RegisterEpoll(epoll);
    EXPECT_EQ(true, ret);
    std::unique_ptr<Adx::AdxCommOpt> opt = nullptr;
    ret = server.RegisterCommOpt(opt, std::to_string(3)); // 3 -> hdc service type
    EXPECT_EQ(false, ret);
    opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    ret = server.RegisterCommOpt(opt, std::to_string(3));
    EXPECT_EQ(true, ret);
    info["0"] = "0";
    info["1"] = "1";
    info["DeviceId"] = "0";
    info["ServiceType"] = "0";
    ret = server.ServerInit(info);
    EXPECT_EQ(true, ret);
    EXPECT_EQ(true, server.ServerUnInit(epHandle));
}

TEST_F(ADX_SERVER_MANAGER_STEST, ServerUnInitEpollDeleteFail)
{    Adx::AdxServerManager server;
    std::map<std::string, std::string> info;
    OptHandle epHandle = (OptHandle)1; // valid
    std::unique_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    bool ret = server.RegisterEpoll(epoll);
    EXPECT_EQ(true, ret);
    std::unique_ptr<Adx::AdxCommOpt> opt = nullptr;
    opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    ret = server.RegisterCommOpt(opt, std::to_string(3)); // 3 -> hdc service type
    EXPECT_EQ(true, ret);
    info["0"] = "0";
    info["1"] = "1";
    info["DeviceId"] = "0";
    info["ServiceType"] = "0";
    ret = server.ServerInit(info);
    EXPECT_EQ(true, ret);
    MOCKER(drvHdcEpollCtl).stubs()
        .will(returnValue(DRV_ERROR_DEVICE_NOT_READY))
        .then(returnValue(DRV_ERROR_NONE));
    ret = server.ServerUnInit(epHandle);
    EXPECT_EQ(false, ret);
    ret = server.ServerUnInit(epHandle);
    EXPECT_EQ(true, ret);
}

drvError_t drvHdcEpollWaitStub(HDC_EPOLL epoll, struct drvHdcEvent * events, int maxevents, int timeout, int * eventnum)
{
    events->data = 0x12345678;
    events->events = HDC_EPOLL_SESSION_CLOSE | HDC_EPOLL_CONN_IN | HDC_EPOLL_DATA_IN;
    *eventnum = 3;
    std::cout<<"drvHdcEpollWaitStub Enable"<<std::endl;
    return DRV_ERROR_NONE;
}

int HdcReadStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    const char *srcFile = "adx_server_manager";
    MsgProto *msg = AdxMsgProto::CreateMsgPacket(IDE_FILE_GETD_REQ, 0, srcFile, strlen(srcFile) + 1);
    *recvLen = sizeof(MsgProto) + strlen(srcFile) + 1;
    msg->totalLen = strlen(srcFile) + 1;
    std::cout<<"HdcReadStub"<<*recvLen <<std::endl;
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

int HdcReadDumpStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    const char *srcFile = "adx_server_manager_dump";
    MsgProto *msg = AdxMsgProto::CreateMsgPacket(IDE_DUMP_REQ, 0, srcFile, strlen(srcFile) + 1);
    *recvLen = sizeof(MsgProto) + strlen(srcFile) + 1;
    msg->totalLen = strlen(srcFile) + 1;
    std::cout<<"HdcReadDumpStub"<<*recvLen <<std::endl;
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

int HdcReadLenFailStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    const char *srcFile = "adx_server_manager";
    MsgProto *msg = AdxMsgProto::CreateMsgPacket(IDE_FILE_GETD_REQ, 0, srcFile, strlen(srcFile) + 1);
    *recvLen = sizeof(MsgProto) + strlen(srcFile) + 10;
    msg->totalLen = strlen(srcFile) + 1;
    std::cout<<"HdcReadLenFailStub"<<*recvLen <<std::endl;
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

extern int g_ide_create_task_time;
extern int g_mmCreateTaskWitchDeatchFlag;
TEST_F(ADX_SERVER_MANAGER_STEST, AdxServerManagerFileDumpRun)
{
    Adx::AdxServerManager server;
    bool ret = server.WaitServerInitted();
    EXPECT_EQ(false, ret);
    std::unique_ptr<Adx::AdxCommOpt> opt = nullptr;
    std::map<std::string, std::string> info;
    OptHandle epHandle = Adx::ADX_OPT_INVALID_HANDLE;
    ret = server.ComponentWaitEvent();
    EXPECT_EQ(false, ret);
    ret = server.ComponentInit();
    EXPECT_EQ(false, ret);
    // register epoll
    std::unique_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    ret = server.RegisterEpoll(epoll);
    EXPECT_EQ(true, ret);
    ret = server.RegisterCommOpt(opt, std::to_string(3)); // 3 -> hdc service type
    EXPECT_EQ(false, ret);
    opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    ret = server.RegisterCommOpt(opt, std::to_string(3));
    EXPECT_EQ(true, ret);
    // register server
    info["0"] = "0";
    info["1"] = "1";
    info["DeviceId"] = "0";
    info["ServiceType"] = "0";
    ret = server.ServerInit(info);
    EXPECT_EQ(true, ret);

    // register file dump
    std::unique_ptr<AdxComponent> cpn = nullptr;
    EXPECT_EQ(false, server.ComponentAdd(cpn));
    cpn = std::unique_ptr<Adx::AdxDumpReceive>(new Adx::AdxDumpReceive());
    EXPECT_EQ("DataDump", cpn->GetInfo());
    EXPECT_EQ(true, server.ComponentAdd(cpn));
    EXPECT_EQ(false, server.ComponentAdd(cpn));

    ret = server.ComponentInit();
    EXPECT_EQ(true, ret);
    MOCKER(drvHdcEpollWait).stubs()
        .will(invoke(drvHdcEpollWaitStub));
    MOCKER(HdcReadNb).stubs()
            .will(invoke(HdcReadStub));

    MOCKER(HdcRead).stubs()
            .will(invoke(HdcReadStub));
    struct drvHdcCapacity capacity;
    capacity.maxSegment = 32 * 1024;

    MOCKER(drvHdcGetCapacity)
        .stubs()
        .with(outBoundP(&capacity, sizeof(capacity)))
        .will(returnValue(DRV_ERROR_NONE));

    MOCKER_CPP(&Adx::Runnable::IsQuit).stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    g_ide_create_task_time = 1;
    g_mmCreateTaskWitchDeatchFlag = 1;
    server.Start();
    ret = server.WaitServerInitted();
    EXPECT_EQ(true, ret);
    g_ide_create_task_time = 0;
    g_mmCreateTaskWitchDeatchFlag = 0;
    // test dump service exit, init flag reset to false
    server.Exit();
    ret = server.WaitServerInitted();
    EXPECT_EQ(false, ret);
}

int g_AdxDumpReceiveProcessStubFlag = 0;
class AdxDumpReceiveStub : public AdxComponent {
public:
    AdxDumpReceiveStub() {}
    virtual ~AdxDumpReceiveStub() {}
    int32_t Init() override { return IDE_DAEMON_OK; };
    virtual const std::string GetInfo() { return "DumpReceive"; }
    ComponentType GetType() override { return ComponentType::COMPONENT_DUMP; };
    int32_t Process(const CommHandle &handle, const SharedPtr<MsgProto> &req) override {
        g_AdxDumpReceiveProcessStubFlag = 1;
        return IDE_DAEMON_OK;
    };
    virtual int32_t UnInit() override { return IDE_DAEMON_OK; };
};

int g_AdxFileDumpProcessStubFlag = 0;
class AdxFileDumpStub : public AdxComponent {
public:
    AdxFileDumpStub() {}
    virtual ~AdxFileDumpStub() {}
    int32_t Init() override { return IDE_DAEMON_OK; };
    virtual const std::string GetInfo() { return "TransferFile"; }
    ComponentType GetType() override { return ComponentType::COMPONENT_GETD_FILE; };
    int32_t Process(const CommHandle &handle, const SharedPtr<MsgProto> &req) override {
        g_AdxFileDumpProcessStubFlag = 1;
        return IDE_DAEMON_OK;
    };
    virtual int32_t UnInit() override { return IDE_DAEMON_OK; };
};

class AdxLogBackhaulStub : public AdxComponent {
public:
    AdxLogBackhaulStub() {}
    virtual ~AdxLogBackhaulStub() {}
    int32_t Init() override { return IDE_DAEMON_OK; };
    virtual const std::string GetInfo() { return "LogBackhaul"; }
    ComponentType GetType() override { return ComponentType::COMPONENT_LOG_BACKHAUL; };
    int32_t Process(const CommHandle &handle, const SharedPtr<MsgProto> &req) override {
        g_AdxFileDumpProcessStubFlag = 1;
        return IDE_DAEMON_OK;
    };
    virtual int32_t UnInit() override { return IDE_DAEMON_OK; };
};

TEST_F(ADX_SERVER_MANAGER_STEST, AdxServerManagerProcess)
{
    Adx::AdxServerManager server;
    std::map<std::string, std::string> info;
    OptHandle epHandle = Adx::ADX_OPT_INVALID_HANDLE;
    std::unique_ptr<Adx::AdxEpoll> epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    bool ret = server.RegisterEpoll(epoll);
    EXPECT_EQ(true, ret);
    std::unique_ptr<Adx::AdxCommOpt> opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    ret = server.RegisterCommOpt(opt, std::to_string(3));
    EXPECT_EQ(true, ret);
    // register server
    info["0"] = "0";
    info["1"] = "1";
    info["DeviceId"] = "0";
    info["ServiceType"] = "0";
    ret = server.ServerInit(info);
    EXPECT_EQ(true, ret);
    server.SetMode(0);
    server.SetDeviceId(-1);

    // register file dump
    std::cout<<"Add Transfer File Component"<<std::endl;
    std::unique_ptr<AdxComponent> cpn = std::unique_ptr<AdxFileDumpStub>(new AdxFileDumpStub());
    ret = server.ComponentAdd(cpn);
    EXPECT_EQ(true, ret);
    ret = server.ComponentInit();
    EXPECT_EQ(true, ret);
    MOCKER(drvHdcEpollWait).stubs()
        .will(invoke(drvHdcEpollWaitStub));
    MOCKER(HdcReadNb).stubs()
            .will(invoke(HdcReadStub));

    MOCKER(HdcRead).stubs()
            .will(invoke(HdcReadStub));
    MOCKER_CPP(&Adx::Runnable::IsQuit).stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    g_ide_create_task_time = 1;
    g_mmCreateTaskWitchDeatchFlag = 1;// mmCreateTaskWithDetach
    g_AdxFileDumpProcessStubFlag = 0;
    server.Start();
    g_ide_create_task_time = 0;
    g_mmCreateTaskWitchDeatchFlag = 0;
    EXPECT_EQ(1, g_AdxFileDumpProcessStubFlag);
}

int HdcReadFailStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    const char *srcFile = "adx_server_manager";
    MsgProto *msg = AdxMsgProto::CreateMsgPacket(IDE_FILE_GETD_REQ, 0, srcFile, strlen(srcFile) + 1);
    *recvLen = sizeof(MsgProto) + strlen(srcFile) + 10;
    msg->totalLen = strlen(srcFile) + 1;
    std::cout<<"HdcReadLenFailStub"<<*recvLen <<std::endl;
    *recvBuf = msg;
    free(msg);
    msg = nullptr;
    return IDE_DAEMON_ERROR;
}

TEST_F(ADX_SERVER_MANAGER_STEST, AdxServerManagerReadFail)
{
    Adx::AdxServerManager server;
    std::map<std::string, std::string> info;
    OptHandle epHandle = Adx::ADX_OPT_INVALID_HANDLE;
    std::unique_ptr<Adx::AdxEpoll> epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    bool ret = server.RegisterEpoll(epoll);
    EXPECT_EQ(true, ret);
    std::unique_ptr<Adx::AdxCommOpt> opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    ret = server.RegisterCommOpt(opt, std::to_string(3));
    EXPECT_EQ(true, ret);
    // register server
    info["0"] = "0";
    info["1"] = "1";
    info["DeviceId"] = "0";
    info["ServiceType"] = "0";
    ret = server.ServerInit(info);
    EXPECT_EQ(true, ret);
    server.SetMode(0);
    server.SetDeviceId(-1);

    // register file dump
    std::cout<<"Add Transfer File Component"<<std::endl;
    std::unique_ptr<AdxComponent> cpn = std::unique_ptr<AdxLogBackhaulStub>(new AdxLogBackhaulStub());
    ret = server.ComponentAdd(cpn);
    EXPECT_EQ(true, ret);
    ret = server.ComponentInit();
    EXPECT_EQ(true, ret);
    MOCKER(drvHdcEpollWait).stubs()
        .will(invoke(drvHdcEpollWaitStub));
    MOCKER(HdcReadNb).stubs()
            .will(invoke(HdcReadFailStub));

    MOCKER(HdcRead).stubs()
            .will(invoke(HdcReadFailStub));
    MOCKER_CPP(&Adx::Runnable::IsQuit).stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    g_ide_create_task_time = 1;
    g_mmCreateTaskWitchDeatchFlag = 1;// mmCreateTaskWithDetach
    g_AdxFileDumpProcessStubFlag = 0;
    server.Start();
    g_ide_create_task_time = 0;
    g_mmCreateTaskWitchDeatchFlag = 0;
    EXPECT_EQ(0, g_AdxFileDumpProcessStubFlag);
}

TEST_F(ADX_SERVER_MANAGER_STEST, AdxServerManagerReadLengthFail)
{
    Adx::AdxServerManager server;
    std::map<std::string, std::string> info;
    OptHandle epHandle = Adx::ADX_OPT_INVALID_HANDLE;
    std::unique_ptr<Adx::AdxEpoll> epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    bool ret = server.RegisterEpoll(epoll);
    EXPECT_EQ(true, ret);
    std::unique_ptr<Adx::AdxCommOpt> opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    ret = server.RegisterCommOpt(opt, std::to_string(3));
    EXPECT_EQ(true, ret);
    // register server
    info["0"] = "0";
    info["1"] = "1";
    info["DeviceId"] = "0";
    info["ServiceType"] = "0";
    ret = server.ServerInit(info);
    EXPECT_EQ(true, ret);
    server.SetMode(0);
    server.SetDeviceId(-1);

    // register file dump
    std::cout<<"Add Transfer File Component"<<std::endl;
    std::unique_ptr<AdxComponent> cpn = std::unique_ptr<AdxLogBackhaulStub>(new AdxLogBackhaulStub());
    ret = server.ComponentAdd(cpn);
    EXPECT_EQ(true, ret);
    ret = server.ComponentInit();
    EXPECT_EQ(true, ret);
    MOCKER(drvHdcEpollWait).stubs()
        .will(invoke(drvHdcEpollWaitStub));
    MOCKER(HdcReadNb).stubs()
            .will(invoke(HdcReadLenFailStub));

    MOCKER(HdcRead).stubs()
            .will(invoke(HdcReadLenFailStub));
    MOCKER_CPP(&Adx::Runnable::IsQuit).stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    g_ide_create_task_time = 1;
    g_mmCreateTaskWitchDeatchFlag = 1;// mmCreateTaskWithDetach
    g_AdxFileDumpProcessStubFlag = 0;
    server.Start();
    g_ide_create_task_time = 0;
    g_mmCreateTaskWitchDeatchFlag = 0;
    EXPECT_EQ(0, g_AdxFileDumpProcessStubFlag);
}

TEST_F(ADX_SERVER_MANAGER_STEST, AdxServerManagerProcessFail)
{
    Adx::AdxServerManager server;
    std::map<std::string, std::string> info;
    OptHandle epHandle = Adx::ADX_OPT_INVALID_HANDLE;
    std::unique_ptr<Adx::AdxEpoll> epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    bool ret = server.RegisterEpoll(epoll);
    EXPECT_EQ(true, ret);
    std::unique_ptr<Adx::AdxCommOpt> opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    ret = server.RegisterCommOpt(opt, std::to_string(3));
    EXPECT_EQ(true, ret);
    // register server
    info["0"] = "0";
    info["1"] = "1";
    info["DeviceId"] = "0";
    info["ServiceType"] = "0";
    ret = server.ServerInit(info);
    EXPECT_EQ(true, ret);
    server.SetMode(0);
    server.SetDeviceId(-1);

    // register file dump
    std::cout<<"Add Transfer File Component"<<std::endl;
    std::unique_ptr<AdxComponent> cpn = std::unique_ptr<AdxFileDumpStub>(new AdxFileDumpStub());
    ret = server.ComponentAdd(cpn);
    EXPECT_EQ(true, ret);
    ret = server.ComponentInit();
    EXPECT_EQ(true, ret);
    MOCKER(drvHdcEpollWait).stubs()
        .will(invoke(drvHdcEpollWaitStub));
    MOCKER(HdcReadNb).stubs()
            .will(invoke(HdcReadStub));

    MOCKER(HdcRead).stubs()
            .will(invoke(HdcReadStub));
    MOCKER_CPP(&Adx::Runnable::IsQuit).stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    MOCKER(IdeGetDevIdBySession).stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    g_ide_create_task_time = 1;
    g_mmCreateTaskWitchDeatchFlag = 1;// mmCreateTaskWithDetach
    g_AdxFileDumpProcessStubFlag = 0;
    server.Start();
    g_ide_create_task_time = 0;
    g_mmCreateTaskWitchDeatchFlag = 0;
    EXPECT_EQ(0, g_AdxFileDumpProcessStubFlag);
}

TEST_F(ADX_SERVER_MANAGER_STEST, AdxServerManagerMsnLinkOverloadFail)
{
    Adx::AdxServerManager server(0, -1);
    std::map<std::string, std::string> info;
    OptHandle epHandle = Adx::ADX_OPT_INVALID_HANDLE;
    std::unique_ptr<Adx::AdxEpoll> epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    bool ret = server.RegisterEpoll(epoll);
    EXPECT_EQ(true, ret);
    std::unique_ptr<Adx::AdxCommOpt> opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    ret = server.RegisterCommOpt(opt, std::to_string(3));
    EXPECT_EQ(true, ret);
    // register server
    info["0"] = "0";
    info["1"] = "1";
    info["DeviceId"] = "0";
    info["ServiceType"] = "0";
    ret = server.ServerInit(info);
    EXPECT_EQ(true, ret);
    server.SetMode(0);
    server.SetDeviceId(-1);

    // register file dump
    std::cout<<"Add Transfer File Component"<<std::endl;
    std::unique_ptr<AdxComponent> cpn = std::unique_ptr<AdxFileDumpStub>(new AdxFileDumpStub());
    ret = server.ComponentAdd(cpn);
    EXPECT_EQ(true, ret);
    ret = server.ComponentInit();
    EXPECT_EQ(true, ret);
    MOCKER(drvHdcEpollWait).stubs()
        .will(invoke(drvHdcEpollWaitStub));
    MOCKER(HdcReadNb).stubs()
            .will(invoke(HdcReadStub));

    MOCKER(HdcRead).stubs()
            .will(invoke(HdcReadStub));
    MOCKER_CPP(&Adx::Runnable::IsQuit).stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    MOCKER_CPP(&Adx::AdxServerManager::IsLinkOverload).stubs()
        .will(returnValue(true));

    g_ide_create_task_time = 1;
    g_mmCreateTaskWitchDeatchFlag = 1;// mmCreateTaskWithDetach
    g_AdxFileDumpProcessStubFlag = 0;
    server.Start();
    g_ide_create_task_time = 0;
    g_mmCreateTaskWitchDeatchFlag = 0;
    EXPECT_EQ(0, g_AdxFileDumpProcessStubFlag);
}

TEST_F(ADX_SERVER_MANAGER_STEST, AdxServerManagerDumpNotAffectedByLinkOverload)
{
    Adx::AdxServerManager server(0, -1);
    std::map<std::string, std::string> info;
    OptHandle epHandle = Adx::ADX_OPT_INVALID_HANDLE;
    std::unique_ptr<Adx::AdxEpoll> epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    bool ret = server.RegisterEpoll(epoll);
    EXPECT_EQ(true, ret);
    std::unique_ptr<Adx::AdxCommOpt> opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    ret = server.RegisterCommOpt(opt, std::to_string(3));
    EXPECT_EQ(true, ret);
    // register server
    info["0"] = "0";
    info["1"] = "1";
    info["DeviceId"] = "0";
    info["ServiceType"] = "0";
    ret = server.ServerInit(info);
    EXPECT_EQ(true, ret);
    server.SetMode(0);
    server.SetDeviceId(-1);

    // register data dump
    std::cout<<"Add Data Dump Component"<<std::endl;
    std::unique_ptr<AdxComponent> cpn = std::unique_ptr<AdxDumpReceiveStub>(new AdxDumpReceiveStub());
    ret = server.ComponentAdd(cpn);
    EXPECT_EQ(true, ret);
    ret = server.ComponentInit();
    EXPECT_EQ(true, ret);
    MOCKER(drvHdcEpollWait).stubs()
        .will(invoke(drvHdcEpollWaitStub));
    MOCKER(HdcReadNb).stubs()
            .will(invoke(HdcReadDumpStub));

    MOCKER(HdcRead).stubs()
            .will(invoke(HdcReadDumpStub));
    MOCKER_CPP(&Adx::Runnable::IsQuit).stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    MOCKER_CPP(&Adx::AdxServerManager::IsLinkOverload).stubs()
        .will(returnValue(true));

    g_ide_create_task_time = 1;
    g_mmCreateTaskWitchDeatchFlag = 1;// mmCreateTaskWithDetach
    g_AdxDumpReceiveProcessStubFlag = 0;
    server.Start();
    g_ide_create_task_time = 0;
    g_mmCreateTaskWitchDeatchFlag = 0;
    EXPECT_EQ(1, g_AdxDumpReceiveProcessStubFlag);
}

TEST_F(ADX_SERVER_MANAGER_STEST, AdxServerManagerCreateDetachTaskFail)
{
    Adx::AdxServerManager server;
    std::map<std::string, std::string> info;
    OptHandle epHandle = Adx::ADX_OPT_INVALID_HANDLE;
    std::unique_ptr<Adx::AdxEpoll> epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    bool ret = server.RegisterEpoll(epoll);
    EXPECT_EQ(true, ret);
    std::unique_ptr<Adx::AdxCommOpt> opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    ret = server.RegisterCommOpt(opt, std::to_string(3));
    EXPECT_EQ(true, ret);
    // register server
    info["0"] = "0";
    info["1"] = "1";
    info["DeviceId"] = "0";
    info["ServiceType"] = "0";
    ret = server.ServerInit(info);
    EXPECT_EQ(true, ret);
    server.SetMode(0);
    server.SetDeviceId(-1);

    // register file dump
    std::cout<<"Add Transfer File Component"<<std::endl;
    std::unique_ptr<AdxComponent> cpn = std::unique_ptr<AdxFileDumpStub>(new AdxFileDumpStub());
    ret = server.ComponentAdd(cpn);
    EXPECT_EQ(true, ret);
    ret = server.ComponentInit();
    EXPECT_EQ(true, ret);
    MOCKER(drvHdcEpollWait).stubs()
        .will(invoke(drvHdcEpollWaitStub));

    MOCKER_CPP(&Adx::Thread::CreateDetachTask).stubs()
        .will(returnValue(-1));

    MOCKER(HdcReadNb).stubs()
            .will(invoke(HdcReadStub));

    MOCKER(HdcRead).stubs()
            .will(invoke(HdcReadStub));
    MOCKER_CPP(&Adx::Runnable::IsQuit).stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    g_ide_create_task_time = 1;
    g_mmCreateTaskWitchDeatchFlag = 1;// mmCreateTaskWithDetach
    g_AdxFileDumpProcessStubFlag = 0;
    server.Start();
    g_ide_create_task_time = 0;
    g_mmCreateTaskWitchDeatchFlag = 0;
    EXPECT_EQ(0, g_AdxFileDumpProcessStubFlag);
}

TEST_F(ADX_SERVER_MANAGER_STEST, AdxServerManagerQueuePopFail)
{
    Adx::AdxServerManager server(0, -1);
    std::map<std::string, std::string> info;
    OptHandle epHandle = Adx::ADX_OPT_INVALID_HANDLE;
    std::unique_ptr<Adx::AdxEpoll> epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    bool ret = server.RegisterEpoll(epoll);
    EXPECT_EQ(true, ret);
    std::unique_ptr<Adx::AdxCommOpt> opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    ret = server.RegisterCommOpt(opt, std::to_string(3));
    EXPECT_EQ(true, ret);
    // register server
    info["0"] = "0";
    info["1"] = "1";
    info["DeviceId"] = "0";
    info["ServiceType"] = "0";
    ret = server.ServerInit(info);
    EXPECT_EQ(true, ret);
    server.SetMode(0);
    server.SetDeviceId(-1);

    // register file dump
    std::cout<<"Add Transfer File Component"<<std::endl;
    std::unique_ptr<AdxComponent> cpn = std::unique_ptr<AdxFileDumpStub>(new AdxFileDumpStub());
    ret = server.ComponentAdd(cpn);
    EXPECT_EQ(true, ret);
    ret = server.ComponentInit();
    EXPECT_EQ(true, ret);
    MOCKER(drvHdcEpollWait).stubs()
        .will(invoke(drvHdcEpollWaitStub));
    MOCKER(HdcReadNb).stubs()
            .will(invoke(HdcReadStub));

    MOCKER(HdcRead).stubs()
            .will(invoke(HdcReadStub));
    MOCKER_CPP(&Adx::Runnable::IsQuit).stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    MOCKER_CPP(&Adx::AdxServerManager::IsLinkOverload).stubs()
        .will(returnValue(true));

    g_ide_create_task_time = 1;
    g_mmCreateTaskWitchDeatchFlag = 1;// mmCreateTaskWithDetach
    g_AdxFileDumpProcessStubFlag = 0;
    server.Start();
    g_ide_create_task_time = 0;
    g_mmCreateTaskWitchDeatchFlag = 0;
    EXPECT_EQ(0, g_AdxFileDumpProcessStubFlag);
}

TEST_F(ADX_SERVER_MANAGER_STEST, AdxServerManagerLinkNumFailed)
{
    Adx::AdxServerManager server;
    server.linkNum_ = 16;
    std::map<std::string, std::string> info;
    OptHandle epHandle = Adx::ADX_OPT_INVALID_HANDLE;
    std::unique_ptr<Adx::AdxEpoll> epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    bool ret = server.RegisterEpoll(epoll);
    EXPECT_EQ(true, ret);
    std::unique_ptr<Adx::AdxCommOpt> opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    ret = server.RegisterCommOpt(opt, std::to_string(3));
    EXPECT_EQ(true, ret);
    // register server
    info["0"] = "0";
    info["1"] = "1";
    info["DeviceId"] = "0";
    info["ServiceType"] = "0";
    ret = server.ServerInit(info);
    EXPECT_EQ(true, ret);
    server.SetMode(0);
    server.SetDeviceId(-1);

    // register file dump
    std::cout<<"Add FileDump Component"<<std::endl;
    std::unique_ptr<AdxComponent> file = std::unique_ptr<AdxFileDumpStub>(new AdxFileDumpStub());
    ret = server.ComponentAdd(file);
    EXPECT_EQ(true, ret);
    ret = server.ComponentInit();
    EXPECT_EQ(true, ret);
    MOCKER(drvHdcEpollWait).stubs()
        .will(invoke(drvHdcEpollWaitStub));
    MOCKER(HdcReadNb).stubs()
            .will(invoke(HdcReadStub));

    MOCKER(HdcRead).stubs()
            .will(invoke(HdcReadStub));
    MOCKER_CPP(&Adx::Runnable::IsQuit).stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    g_ide_create_task_time = 1;
    g_mmCreateTaskWitchDeatchFlag = 1;// mmCreateTaskWithDetach
    g_AdxFileDumpProcessStubFlag = 0;
    server.Start();
    g_ide_create_task_time = 0;
    g_mmCreateTaskWitchDeatchFlag = 0;
    EXPECT_EQ(0, g_AdxFileDumpProcessStubFlag);
}

int g_AdxTraceProcessStubFlag = 0;
class AdxTraceStub : public AdxComponent {
public:
    AdxTraceStub() {}
    virtual ~AdxTraceStub() {}
    int32_t Init() override { return IDE_DAEMON_OK; };
    virtual const std::string GetInfo() { return "Trace"; }
    ComponentType GetType() override { return ComponentType::COMPONENT_TRACE; };
    int32_t Process(const CommHandle &handle, const SharedPtr<MsgProto> &req) override {
        g_AdxTraceProcessStubFlag = 1;
        free((AdxCommHandle)&handle);
        return IDE_DAEMON_OK;
    };
    virtual int32_t UnInit() override { return IDE_DAEMON_OK; };
};

TEST_F(ADX_SERVER_MANAGER_STEST, AdxServerManagerHandleFree)
{
    Adx::AdxServerManager server;
    std::map<std::string, std::string> info;
    OptHandle epHandle = Adx::ADX_OPT_INVALID_HANDLE;
    std::unique_ptr<Adx::AdxEpoll> epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    bool ret = server.RegisterEpoll(epoll);
    EXPECT_EQ(true, ret);
    std::unique_ptr<Adx::AdxCommOpt> opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    ret = server.RegisterCommOpt(opt, std::to_string(7));
    EXPECT_EQ(true, ret);
    // register server
    info["0"] = "0";
    info["1"] = "1";
    info["DeviceId"] = "0";
    info["ServiceType"] = "11";
    ret = server.ServerInit(info);
    EXPECT_EQ(true, ret);
    server.SetMode(0);
    server.SetDeviceId(-1);

    // register trace
    std::cout<<"Add Trace Component"<<std::endl;
    std::unique_ptr<AdxComponent> cpn = std::unique_ptr<AdxTraceStub>(new AdxTraceStub());
    ret = server.ComponentAdd(cpn);
    std::unique_ptr<AdxComponent> file = std::unique_ptr<AdxFileDumpStub>(new AdxFileDumpStub());
    ret = server.ComponentAdd(file);
    EXPECT_EQ(true, ret);
    ret = server.ComponentInit();
    EXPECT_EQ(true, ret);
    MOCKER(drvHdcEpollWait).stubs()
        .will(invoke(drvHdcEpollWaitStub));
    MOCKER(HdcReadNb).stubs()
            .will(invoke(HdcReadStub));

    MOCKER(HdcRead).stubs()
            .will(invoke(HdcReadStub));
    MOCKER_CPP(&Adx::Runnable::IsQuit).stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    g_ide_create_task_time = 1;
    g_mmCreateTaskWitchDeatchFlag = 1;// mmCreateTaskWithDetach
    g_AdxFileDumpProcessStubFlag = 0;
    server.Start();
    g_ide_create_task_time = 0;
    g_mmCreateTaskWitchDeatchFlag = 0;
    EXPECT_EQ(1, g_AdxFileDumpProcessStubFlag);
}