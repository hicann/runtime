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
#include "adx_dsmi.h"
#include "adcore_api.h"

using namespace Adx;

class ADX_SERVER_MANAGER_UTEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() { GlobalMockObject::verify(); }
};

TEST_F(ADX_SERVER_MANAGER_UTEST, RegisterEpoll)
{
    Adx::AdxServerManager server;
    std::unique_ptr<Adx::AdxEpoll> epoll = nullptr;
    bool ret = server.RegisterEpoll(epoll);
    EXPECT_EQ(false, ret);
    epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    ret = server.RegisterEpoll(epoll);
    EXPECT_EQ(true, ret);
}

TEST_F(ADX_SERVER_MANAGER_UTEST, RegisterCommOpt)
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

TEST_F(ADX_SERVER_MANAGER_UTEST, ServerInit)
{
    Adx::AdxServerManager server;
    std::map<std::string, std::string> info;
    EXPECT_EQ(false, server.ServerInit(info));
    std::unique_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    EXPECT_EQ(true, server.RegisterEpoll(epoll));
    std::unique_ptr<Adx::AdxCommOpt> opt = nullptr;
    EXPECT_EQ(false, server.RegisterCommOpt(opt, std::to_string(3))); // 3 -> hdc service type
    opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    EXPECT_EQ(true, server.RegisterCommOpt(opt, std::to_string(3)));
    EXPECT_EQ(false, server.ServerInit(info));
    EXPECT_EQ(false, server.ServerInit(info));
    info["0"] = "0";
    info["1"] = "1";
    info["DeviceId"] = "0";
    info["ServiceType"] = "0";
    EXPECT_EQ(true, server.ServerInit(info));
}

TEST_F(ADX_SERVER_MANAGER_UTEST, ServerInitEpollAddFailed)
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
    MOCKER(drvHdcEpollCtl).stubs().will(returnValue(DRV_ERROR_DEVICE_NOT_READY));
    ret = server.ServerInit(info);
    EXPECT_EQ(false, ret);
}

TEST_F(ADX_SERVER_MANAGER_UTEST, VirtualDeviceEnable)
{
    std::unique_ptr<Adx::AdxCommOpt> opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    auto device = opt->GetDevice();
    EXPECT_EQ(true, device != nullptr);
    std::vector<std::string> devices;
    device->GetAllEnableDevices(1, 32, devices);
    EXPECT_EQ(devices.size(), 1);
    device->GetAllEnableDevices(0, -1, devices);
    EXPECT_EQ(devices.size(), 1);
}

TEST_F(ADX_SERVER_MANAGER_UTEST, GetLogIdByPhyId)
{
    uint32_t phyId = 0;
    uint32_t logId = 0;
    EXPECT_EQ(IdeGetLogIdByPhyId(phyId, &logId), 0);
    EXPECT_EQ(AdxGetLogIdByPhyId(phyId, &logId), 0);
}

TEST_F(ADX_SERVER_MANAGER_UTEST, AdxServerManagerExit)
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

    MOCKER_CPP(&Adx::AdxServerManager::ServerInit).stubs().will(returnValue(false)).then(returnValue(true));

    MOCKER(drvHdcEpollClose).stubs().will(returnValue(DRV_ERROR_DEVICE_NOT_READY)).then(returnValue(DRV_ERROR_NONE));
}

TEST_F(ADX_SERVER_MANAGER_UTEST, CommOptServerUnInit)
{
    Adx::AdxServerManager server;
    std::map<std::string, std::string> info;
    OptHandle epHandle = Adx::ADX_OPT_INVALID_HANDLE;
    EXPECT_EQ(false, server.ServerUnInit(epHandle));
    epHandle = 1;
    EXPECT_EQ(false, server.ServerUnInit(epHandle));
    std::unique_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    EXPECT_EQ(true, server.RegisterEpoll(epoll));
    std::unique_ptr<Adx::AdxCommOpt> opt = nullptr;
    EXPECT_EQ(false, server.RegisterCommOpt(opt, std::to_string(3))); // 3 -> hdc service type
    opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    EXPECT_EQ(true, server.RegisterCommOpt(opt, std::to_string(3)));
    info["0"] = "0";
    info["1"] = "1";
    info["DeviceId"] = "0";
    info["ServiceType"] = "0";
    EXPECT_EQ(true, server.ServerInit(info));
    EXPECT_EQ(true, server.ServerUnInit(epHandle));
}

TEST_F(ADX_SERVER_MANAGER_UTEST, ServerUnInitCloseServerFail)
{
    Adx::AdxServerManager server;
    std::map<std::string, std::string> info;
    OptHandle epHandle = (OptHandle)1;
    std::unique_ptr<Adx::AdxEpoll> epoll = nullptr;
    epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    EXPECT_EQ(true, server.RegisterEpoll(epoll));
    std::unique_ptr<Adx::AdxCommOpt> opt = nullptr;
    opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    EXPECT_EQ(true, server.RegisterCommOpt(opt, std::to_string(3)));
    info["0"] = "0";
    info["1"] = "1";
    info["DeviceId"] = "0";
    info["ServiceType"] = "0";
    EXPECT_EQ(true, server.ServerInit(info));
    MOCKER(drvHdcEpollCtl).stubs().will(returnValue(DRV_ERROR_DEVICE_NOT_READY)).then(returnValue(DRV_ERROR_NONE));
    bool ret = server.ServerUnInit(epHandle);
    EXPECT_EQ(false, ret);
    MOCKER(drvHdcServerDestroy)
        .stubs()
        .will(repeat(DRV_ERROR_CLIENT_BUSY, 30)) // 30 -> max retry times
        .then(returnValue(DRV_ERROR_NONE));
    MOCKER(mmSleep).stubs().will(returnValue(EN_OK));
    ret = server.ServerUnInit(epHandle);
    EXPECT_EQ(false, ret);
}

// Exit must keep the servers_ entry whose ServerUnInit failed, otherwise the handle is leaked
// and the next ServerInit opens a server on a device that still has one
TEST_F(ADX_SERVER_MANAGER_UTEST, ExitKeepServerOnUnInitFail)
{
    Adx::AdxServerManager server;
    std::unique_ptr<Adx::AdxEpoll> epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    EXPECT_EQ(true, server.RegisterEpoll(epoll));
    std::unique_ptr<Adx::AdxCommOpt> opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    EXPECT_EQ(true, server.RegisterCommOpt(opt, std::to_string(3))); // 3 -> hdc service type
    std::map<std::string, std::string> info;
    info["DeviceId"] = "0";
    info["ServiceType"] = "0";
    EXPECT_EQ(true, server.ServerInit(info));
    EXPECT_EQ(1U, server.servers_.size());

    // let EpollDel fail so ServerUnInit returns false during Exit
    MOCKER(drvHdcEpollCtl).stubs().will(returnValue(DRV_ERROR_DEVICE_NOT_READY));
    EXPECT_EQ(IDE_DAEMON_ERROR, server.Exit());
    // the entry survives instead of being dropped, so its handle is not leaked
    EXPECT_EQ(1U, server.servers_.size());
    // Exit returned before EpollDestroy, so the epoll is still usable for a later retry.
    // without this assertion the test cannot tell the early return was removed
    EXPECT_NE(nullptr, server.epoll_.get());
}

// the retained entry must still be closeable: a later Exit() retries the failed ServerUnInit,
// which only works because the first Exit() returned before destroying the epoll
TEST_F(ADX_SERVER_MANAGER_UTEST, ExitRetryClosesRetainedServer)
{
    Adx::AdxServerManager server;
    std::unique_ptr<Adx::AdxEpoll> epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    EXPECT_EQ(true, server.RegisterEpoll(epoll));
    std::unique_ptr<Adx::AdxCommOpt> opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    EXPECT_EQ(true, server.RegisterCommOpt(opt, std::to_string(3))); // 3 -> hdc service type
    std::map<std::string, std::string> info;
    info["DeviceId"] = "0";
    info["ServiceType"] = "2";
    EXPECT_EQ(true, server.ServerInit(info));

    // EpollDel fails the first time, succeeds the second
    MOCKER(drvHdcEpollCtl).stubs().will(returnValue(DRV_ERROR_DEVICE_NOT_READY)).then(returnValue(DRV_ERROR_NONE));
    EXPECT_EQ(IDE_DAEMON_ERROR, server.Exit());
    EXPECT_EQ(1U, server.servers_.size());

    EXPECT_EQ(IDE_DAEMON_OK, server.Exit());
    EXPECT_EQ(0U, server.servers_.size());
}

// the counterpart: when ServerUnInit succeeds, Exit drops the entry and reports success
TEST_F(ADX_SERVER_MANAGER_UTEST, ExitEraseServerOnUnInitOk)
{
    Adx::AdxServerManager server;
    std::unique_ptr<Adx::AdxEpoll> epoll = std::unique_ptr<Adx::AdxHdcEpoll>(new Adx::AdxHdcEpoll());
    EXPECT_EQ(true, server.RegisterEpoll(epoll));
    std::unique_ptr<Adx::AdxCommOpt> opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    EXPECT_EQ(true, server.RegisterCommOpt(opt, std::to_string(3))); // 3 -> hdc service type
    std::map<std::string, std::string> info;
    info["DeviceId"] = "0";
    info["ServiceType"] = "1";
    EXPECT_EQ(true, server.ServerInit(info));
    EXPECT_EQ(1U, server.servers_.size());

    EXPECT_EQ(IDE_DAEMON_OK, server.Exit());
    EXPECT_EQ(0U, server.servers_.size());
    // the success path runs to the end and releases the epoll
    EXPECT_EQ(nullptr, server.epoll_.get());
}

TEST_F(ADX_SERVER_MANAGER_UTEST, ServerUnInitEpollDeleteFail)
{
    Adx::AdxServerManager server;
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
    MOCKER(drvHdcEpollCtl).stubs().will(returnValue(DRV_ERROR_DEVICE_NOT_READY)).then(returnValue(DRV_ERROR_NONE));
    ret = server.ServerUnInit(epHandle);
    EXPECT_EQ(false, ret);
    ret = server.ServerUnInit(epHandle);
    EXPECT_EQ(true, ret);
}

drvError_t drvHdcEpollWaitStub(HDC_EPOLL epoll, struct drvHdcEvent* events, int maxevents, int timeout, int* eventnum)
{
    events->data = 0x12345678;
    events->events = HDC_EPOLL_SESSION_CLOSE | HDC_EPOLL_CONN_IN | HDC_EPOLL_DATA_IN;
    *eventnum = 3;
    std::cout << "drvHdcEpollWaitStub Enable" << std::endl;
    return DRV_ERROR_NONE;
}

int HdcReadStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    const char* srcFile = "adx_server_manager";
    MsgProto* msg = AdxMsgProto::CreateMsgPacket(IDE_FILE_GETD_REQ, 0, srcFile, strlen(srcFile) + 1);
    *recvLen = sizeof(MsgProto) + strlen(srcFile) + 1;
    msg->totalLen = strlen(srcFile) + 1;
    std::cout << "HdcReadStub" << *recvLen << std::endl;
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

int HdcReadLenFailStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    const char* srcFile = "adx_server_manager";
    MsgProto* msg = AdxMsgProto::CreateMsgPacket(IDE_FILE_GETD_REQ, 0, srcFile, strlen(srcFile) + 1);
    *recvLen = sizeof(MsgProto) + strlen(srcFile) + 10;
    msg->totalLen = strlen(srcFile) + 1;
    std::cout << "HdcReadLenFailStub" << *recvLen << std::endl;
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

int HdcReadShortStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    constexpr int32_t shortLength = 8;
    *recvBuf = malloc(shortLength);
    *recvLen = shortLength;
    return IDE_DAEMON_OK;
}

uint32_t g_ideXfreeCount = 0;
void IdeXfreeCountStub(const IdeMemHandle ptr)
{
    ++g_ideXfreeCount;
    free(ptr);
}

uint32_t g_hdcSessionCloseCount = 0;
int32_t HdcSessionCloseCountStub(HDC_SESSION session)
{
    (void)session;
    ++g_hdcSessionCloseCount;
    return IDE_DAEMON_OK;
}

int HdcReadFailStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    const char* srcFile = "adx_server_manager";
    MsgProto* msg = AdxMsgProto::CreateMsgPacket(IDE_FILE_GETD_REQ, 0, srcFile, strlen(srcFile) + 1);
    *recvLen = sizeof(MsgProto) + strlen(srcFile) + 10;
    msg->totalLen = strlen(srcFile) + 1;
    std::cout << "HdcReadLenFailStub" << *recvLen << std::endl;
    *recvBuf = msg;
    return IDE_DAEMON_ERROR;
}

extern int g_ide_create_task_time;
extern int g_mmCreateTaskWitchDeatchFlag;
TEST_F(ADX_SERVER_MANAGER_UTEST, AdxServerManagerFileDumpRun)
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
    MOCKER(drvHdcEpollWait).stubs().will(invoke(drvHdcEpollWaitStub));
    MOCKER(HdcReadNb).stubs().will(invoke(HdcReadStub));

    MOCKER(HdcRead).stubs().will(invoke(HdcReadStub));
    struct drvHdcCapacity capacity;
    capacity.maxSegment = 32 * 1024;

    MOCKER(drvHdcGetCapacity).stubs().with(outBoundP(&capacity, sizeof(capacity))).will(returnValue(DRV_ERROR_NONE));

    MOCKER_CPP(&Adx::Runnable::IsQuit).stubs().will(returnValue(false)).then(returnValue(true));

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

int g_AdxFileDumpProcessStubFlag = 0;
class AdxFileDumpStub : public AdxComponent {
public:
    AdxFileDumpStub() {}
    virtual ~AdxFileDumpStub() {}
    int32_t Init() override { return IDE_DAEMON_OK; };
    virtual const std::string GetInfo() { return "TransferFile"; }
    ComponentType GetType() override { return ComponentType::COMPONENT_GETD_FILE; };
    int32_t Process(const CommHandle& handle, const SharedPtr<MsgProto>& req) override
    {
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
    int32_t Process(const CommHandle& handle, const SharedPtr<MsgProto>& req) override
    {
        g_AdxFileDumpProcessStubFlag = 1;
        return IDE_DAEMON_OK;
    };
    virtual int32_t UnInit() override { return IDE_DAEMON_OK; };
};

TEST_F(ADX_SERVER_MANAGER_UTEST, AdxServerManagerProcess)
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
    std::cout << "Add Transfer File Component" << std::endl;
    std::unique_ptr<AdxComponent> cpn = std::unique_ptr<AdxFileDumpStub>(new AdxFileDumpStub());
    ret = server.ComponentAdd(cpn);
    EXPECT_EQ(true, ret);
    ret = server.ComponentInit();
    EXPECT_EQ(true, ret);
    MOCKER(drvHdcEpollWait).stubs().will(invoke(drvHdcEpollWaitStub));
    MOCKER(HdcReadNb).stubs().will(invoke(HdcReadStub));

    MOCKER(HdcRead).stubs().will(invoke(HdcReadStub));
    MOCKER_CPP(&Adx::Runnable::IsQuit).stubs().will(returnValue(false)).then(returnValue(true));

    g_ide_create_task_time = 1;
    g_mmCreateTaskWitchDeatchFlag = 1; // mmCreateTaskWithDetach
    g_AdxFileDumpProcessStubFlag = 0;
    server.Start();
    g_ide_create_task_time = 0;
    g_mmCreateTaskWitchDeatchFlag = 0;
    EXPECT_EQ(1, g_AdxFileDumpProcessStubFlag);
}

TEST_F(ADX_SERVER_MANAGER_UTEST, AdxServerManagerReadFail)
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
    std::cout << "Add Transfer File Component" << std::endl;
    std::unique_ptr<AdxComponent> cpn = std::unique_ptr<AdxLogBackhaulStub>(new AdxLogBackhaulStub());
    ret = server.ComponentAdd(cpn);
    EXPECT_EQ(true, ret);
    ret = server.ComponentInit();
    EXPECT_EQ(true, ret);
    MOCKER(drvHdcEpollWait).stubs().will(invoke(drvHdcEpollWaitStub));
    MOCKER(HdcReadNb).stubs().will(invoke(HdcReadFailStub));

    MOCKER(HdcRead).stubs().will(invoke(HdcReadFailStub));
    MOCKER_CPP(&Adx::Runnable::IsQuit).stubs().will(returnValue(false)).then(returnValue(true));

    g_ide_create_task_time = 1;
    g_mmCreateTaskWitchDeatchFlag = 1; // mmCreateTaskWithDetach
    g_AdxFileDumpProcessStubFlag = 0;
    server.Start();
    g_ide_create_task_time = 0;
    g_mmCreateTaskWitchDeatchFlag = 0;
    EXPECT_EQ(0, g_AdxFileDumpProcessStubFlag);
}

TEST_F(ADX_SERVER_MANAGER_UTEST, AdxServerManagerReadLengthFail)
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
    std::cout << "Add Transfer File Component" << std::endl;
    std::unique_ptr<AdxComponent> cpn = std::unique_ptr<AdxLogBackhaulStub>(new AdxLogBackhaulStub());
    ret = server.ComponentAdd(cpn);
    EXPECT_EQ(true, ret);
    ret = server.ComponentInit();
    EXPECT_EQ(true, ret);
    MOCKER(drvHdcEpollWait).stubs().will(invoke(drvHdcEpollWaitStub));
    MOCKER(HdcReadNb).stubs().will(invoke(HdcReadLenFailStub));

    MOCKER(HdcRead).stubs().will(invoke(HdcReadLenFailStub));
    MOCKER_CPP(&Adx::Runnable::IsQuit).stubs().will(returnValue(false)).then(returnValue(true));

    g_ide_create_task_time = 1;
    g_mmCreateTaskWitchDeatchFlag = 1; // mmCreateTaskWithDetach
    g_AdxFileDumpProcessStubFlag = 0;
    server.Start();
    g_ide_create_task_time = 0;
    g_mmCreateTaskWitchDeatchFlag = 0;
    EXPECT_EQ(0, g_AdxFileDumpProcessStubFlag);
}

TEST_F(ADX_SERVER_MANAGER_UTEST, AdxServerManagerProcessFail)
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
    std::cout << "Add Transfer File Component" << std::endl;
    std::unique_ptr<AdxComponent> cpn = std::unique_ptr<AdxFileDumpStub>(new AdxFileDumpStub());
    ret = server.ComponentAdd(cpn);
    EXPECT_EQ(true, ret);
    ret = server.ComponentInit();
    EXPECT_EQ(true, ret);
    MOCKER(drvHdcEpollWait).stubs().will(invoke(drvHdcEpollWaitStub));
    MOCKER(HdcReadNb).stubs().will(invoke(HdcReadStub));

    MOCKER(HdcRead).stubs().will(invoke(HdcReadStub));
    MOCKER_CPP(&Adx::Runnable::IsQuit).stubs().will(returnValue(false)).then(returnValue(true));

    MOCKER(IdeGetDevIdBySession).stubs().will(returnValue(IDE_DAEMON_ERROR));

    g_ide_create_task_time = 1;
    g_mmCreateTaskWitchDeatchFlag = 1; // mmCreateTaskWithDetach
    g_AdxFileDumpProcessStubFlag = 0;
    server.Start();
    g_ide_create_task_time = 0;
    g_mmCreateTaskWitchDeatchFlag = 0;
    EXPECT_EQ(0, g_AdxFileDumpProcessStubFlag);
}

TEST_F(ADX_SERVER_MANAGER_UTEST, AdxServerManagerLinkOverloadFail)
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
    std::cout << "Add Transfer File Component" << std::endl;
    std::unique_ptr<AdxComponent> cpn = std::unique_ptr<AdxFileDumpStub>(new AdxFileDumpStub());
    ret = server.ComponentAdd(cpn);
    EXPECT_EQ(true, ret);
    ret = server.ComponentInit();
    EXPECT_EQ(true, ret);
    MOCKER(drvHdcEpollWait).stubs().will(invoke(drvHdcEpollWaitStub));
    MOCKER(HdcReadNb).stubs().will(invoke(HdcReadStub));

    MOCKER(HdcRead).stubs().will(invoke(HdcReadStub));
    MOCKER_CPP(&Adx::Runnable::IsQuit).stubs().will(returnValue(false)).then(returnValue(true));
    MOCKER_CPP(&Adx::AdxServerManager::IsLinkOverload).stubs().will(returnValue(true));

    g_ide_create_task_time = 1;
    g_mmCreateTaskWitchDeatchFlag = 1; // mmCreateTaskWithDetach
    g_AdxFileDumpProcessStubFlag = 0;
    server.Start();
    g_ide_create_task_time = 0;
    g_mmCreateTaskWitchDeatchFlag = 0;
    EXPECT_EQ(0, g_AdxFileDumpProcessStubFlag);
}

TEST_F(ADX_SERVER_MANAGER_UTEST, AdxServerManagerCreateDetachTaskFail)
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
    std::cout << "Add Transfer File Component" << std::endl;
    std::unique_ptr<AdxComponent> cpn = std::unique_ptr<AdxFileDumpStub>(new AdxFileDumpStub());
    ret = server.ComponentAdd(cpn);
    EXPECT_EQ(true, ret);
    ret = server.ComponentInit();
    EXPECT_EQ(true, ret);
    MOCKER(drvHdcEpollWait).stubs().will(invoke(drvHdcEpollWaitStub));

    MOCKER_CPP(&Adx::Thread::CreateDetachTask).stubs().will(returnValue(-1));

    MOCKER(HdcReadNb).stubs().will(invoke(HdcReadStub));

    MOCKER(HdcRead).stubs().will(invoke(HdcReadStub));
    MOCKER_CPP(&Adx::Runnable::IsQuit).stubs().will(returnValue(false)).then(returnValue(true));

    g_ide_create_task_time = 1;
    g_mmCreateTaskWitchDeatchFlag = 1; // mmCreateTaskWithDetach
    g_AdxFileDumpProcessStubFlag = 0;
    server.Start();
    g_ide_create_task_time = 0;
    g_mmCreateTaskWitchDeatchFlag = 0;
    EXPECT_EQ(0, g_AdxFileDumpProcessStubFlag);
}

TEST_F(ADX_SERVER_MANAGER_UTEST, AdxServerManagerQueuePopFail)
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
    std::cout << "Add Transfer File Component" << std::endl;
    std::unique_ptr<AdxComponent> cpn = std::unique_ptr<AdxFileDumpStub>(new AdxFileDumpStub());
    ret = server.ComponentAdd(cpn);
    EXPECT_EQ(true, ret);
    ret = server.ComponentInit();
    EXPECT_EQ(true, ret);
    MOCKER(drvHdcEpollWait).stubs().will(invoke(drvHdcEpollWaitStub));
    MOCKER(HdcReadNb).stubs().will(invoke(HdcReadStub));

    MOCKER(HdcRead).stubs().will(invoke(HdcReadStub));
    MOCKER_CPP(&Adx::Runnable::IsQuit).stubs().will(returnValue(false)).then(returnValue(true));
    MOCKER_CPP(&Adx::AdxServerManager::IsLinkOverload).stubs().will(returnValue(true));

    g_ide_create_task_time = 1;
    g_mmCreateTaskWitchDeatchFlag = 1; // mmCreateTaskWithDetach
    g_AdxFileDumpProcessStubFlag = 0;
    server.Start();
    g_ide_create_task_time = 0;
    g_mmCreateTaskWitchDeatchFlag = 0;
    EXPECT_EQ(0, g_AdxFileDumpProcessStubFlag);
}

TEST_F(ADX_SERVER_MANAGER_UTEST, AdxServerManagerLinkNumFailed)
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
    std::cout << "Add FileDump Component" << std::endl;
    std::unique_ptr<AdxComponent> file = std::unique_ptr<AdxFileDumpStub>(new AdxFileDumpStub());
    ret = server.ComponentAdd(file);
    EXPECT_EQ(true, ret);
    ret = server.ComponentInit();
    EXPECT_EQ(true, ret);
    MOCKER(drvHdcEpollWait).stubs().will(invoke(drvHdcEpollWaitStub));
    MOCKER(HdcReadNb).stubs().will(invoke(HdcReadStub));

    MOCKER(HdcRead).stubs().will(invoke(HdcReadStub));
    MOCKER_CPP(&Adx::Runnable::IsQuit).stubs().will(returnValue(false)).then(returnValue(true));

    g_ide_create_task_time = 1;
    g_mmCreateTaskWitchDeatchFlag = 1; // mmCreateTaskWithDetach
    g_AdxFileDumpProcessStubFlag = 0;
    server.Start();
    g_ide_create_task_time = 0;
    g_mmCreateTaskWitchDeatchFlag = 0;
    EXPECT_EQ(0, g_AdxFileDumpProcessStubFlag);
}
TEST_F(ADX_SERVER_MANAGER_UTEST, ProcessRequestContinuesAfterNoDataRequest)
{
    AdxCommOptManager::Instance().commOptMap_.clear();
    AdxServerManager server;
    std::unique_ptr<AdxCommOpt> opt(new HdcCommOpt());
    EXPECT_TRUE(server.RegisterCommOpt(opt, std::to_string(3)));

    const auto deadline = AdxServerManager::RequestClock::now() + std::chrono::seconds(1);
    AdxServerManager::PendingRequest first{1, deadline};
    AdxServerManager::PendingRequest second{2, deadline};

    MOCKER(HdcReadNb).expects(exactly(3)).will(returnValue(IDE_DAEMON_RECV_NODATA)).then(invoke(HdcReadStub));
    MOCKER_CPP(&AdxServerManager::LaunchComponentProcess).expects(exactly(2)).will(returnValue(true));

    server.ProcessRequest(first);
    server.ProcessRequest(second);

    AdxCommOptManager::Instance().commOptMap_.clear();
}

TEST_F(ADX_SERVER_MANAGER_UTEST, PrepareComponentProcessOwnsShortRequest)
{
    AdxCommOptManager::Instance().commOptMap_.clear();
    AdxServerManager server;
    std::unique_ptr<AdxCommOpt> opt(new HdcCommOpt());
    EXPECT_TRUE(server.RegisterCommOpt(opt, std::to_string(3)));

    MOCKER(HdcReadNb).expects(once()).will(invoke(HdcReadShortStub));
    g_ideXfreeCount = 0;
    MOCKER(IdeXfree).expects(once()).will(invoke(IdeXfreeCountStub));

    CommHandle handle{OptType::COMM_HDC, 1, NR_COMPONENTS, -1, nullptr};
    SharedPtr<MsgProto> msgPtr;
    ComponentType comp = NR_COMPONENTS;
    EXPECT_EQ(AdxServerManager::PrepareResult::FAILED, server.PrepareComponentProcess(handle, msgPtr, comp));
    EXPECT_NE(nullptr, msgPtr);
    msgPtr.reset();
    EXPECT_EQ(1U, g_ideXfreeCount);

    AdxCommOptManager::Instance().commOptMap_.clear();
}

class AdxOwnershipCountStub : public AdxComponent {
public:
    AdxOwnershipCountStub(ComponentType type, bool destroyHandle, bool processSuccess)
        : type_(type), destroyHandle_(destroyHandle), processSuccess_(processSuccess)
    {}

    int32_t Init() override { return IDE_DAEMON_OK; }
    const std::string GetInfo() override { return "OwnershipCount"; }
    ComponentType GetType() override { return type_; }
    int32_t UnInit() override { return IDE_DAEMON_OK; }

    int32_t Process(const CommHandle& handle, const SharedPtr<MsgProto>& req) override
    {
        (void)req;
        if (destroyHandle_) {
            AdxDestroyCommHandle(const_cast<AdxCommHandle>(&handle));
        }
        return processSuccess_ ? IDE_DAEMON_OK : IDE_DAEMON_ERROR;
    }

private:
    ComponentType type_;
    bool destroyHandle_;
    bool processSuccess_;
};

static uint32_t g_adxDestroyCommHandleCount = 0;
static void AdxDestroyCommHandleCountStub(AdxCommHandle handle)
{
    (void)handle;
    ++g_adxDestroyCommHandleCount;
}

static void ClearCommOptMap() { AdxCommOptManager::Instance().commOptMap_.clear(); }

static bool RegisterHdcCommOpt(AdxServerManager& server)
{
    std::unique_ptr<AdxCommOpt> commOpt(new HdcCommOpt());
    return server.RegisterCommOpt(commOpt, std::to_string(3));
}

static SharedPtr<MsgProto> MakeOwnershipMsg()
{
    const char* payload = "ownership";
    MsgProto* msg = AdxMsgProto::CreateMsgPacket(IDE_FILE_GETD_REQ, 0, payload, strlen(payload) + 1);
    if (msg == nullptr) {
        return SharedPtr<MsgProto>();
    }
    return SharedPtr<MsgProto>(msg, free);
}

// 非持久组件：无论 Process 成败，框架都必须且只能关闭一次 session、释放一次 CommHandle。
TEST_F(ADX_SERVER_MANAGER_UTEST, RunProcessTaskReleasesNonPersistentHandleExactlyOnce)
{
    AdxServerManager server;
    ClearCommOptMap();
    ASSERT_TRUE(RegisterHdcCommOpt(server));
    AdxCommHandle processHandle = static_cast<AdxCommHandle>(IdeXmalloc(sizeof(CommHandle)));
    ASSERT_NE(nullptr, processHandle);
    *processHandle = CommHandle{OptType::COMM_HDC, 1, ComponentType::COMPONENT_GETD_FILE, -1, nullptr};
    SharedPtr<MsgProto> msgPtr = MakeOwnershipMsg();
    std::unique_ptr<AdxComponent> component(
        new AdxOwnershipCountStub(ComponentType::COMPONENT_GETD_FILE, false, false));
    ASSERT_TRUE(server.ComponentAdd(component));

    g_hdcSessionCloseCount = 0;
    g_ideXfreeCount = 0;
    g_adxDestroyCommHandleCount = 0;
    MOCKER(HdcSessionClose).expects(once()).will(invoke(HdcSessionCloseCountStub));
    MOCKER(IdeXfree).expects(once()).will(invoke(IdeXfreeCountStub));
    MOCKER(AdxDestroyCommHandle).stubs().will(invoke(AdxDestroyCommHandleCountStub));

    AdxServerManager::ProcessTask task{&server, processHandle, msgPtr, ComponentType::COMPONENT_GETD_FILE, true};
    server.RunProcessTask(task);

    EXPECT_EQ(1U, g_hdcSessionCloseCount);
    EXPECT_EQ(1U, g_ideXfreeCount);
    EXPECT_EQ(0U, g_adxDestroyCommHandleCount);
    EXPECT_EQ(0U, server.linkNum_);
    EXPECT_EQ(nullptr, task.handle);
}

// 持久组件自释放场景：框架不 Close、不 IdeXfree，组件的 AdxDestroyCommHandle 是唯一释放点。
TEST_F(ADX_SERVER_MANAGER_UTEST, RunProcessTaskLetsPersistentComponentOwnHandle)
{
    AdxServerManager server;
    AdxCommHandle processHandle = static_cast<AdxCommHandle>(IdeXmalloc(sizeof(CommHandle)));
    ASSERT_NE(nullptr, processHandle);
    *processHandle = CommHandle{OptType::COMM_HDC, 1, ComponentType::COMPONENT_TRACE, -1, nullptr};
    SharedPtr<MsgProto> msgPtr = MakeOwnershipMsg();
    std::unique_ptr<AdxComponent> component(new AdxOwnershipCountStub(ComponentType::COMPONENT_TRACE, true, true));
    ASSERT_TRUE(server.ComponentAdd(component));

    g_hdcSessionCloseCount = 0;
    g_ideXfreeCount = 0;
    g_adxDestroyCommHandleCount = 0;
    MOCKER(HdcSessionClose).expects(never()).will(invoke(HdcSessionCloseCountStub));
    MOCKER(IdeXfree).expects(never()).will(invoke(IdeXfreeCountStub));
    MOCKER(AdxDestroyCommHandle).expects(once()).will(invoke(AdxDestroyCommHandleCountStub));

    AdxServerManager::ProcessTask task{&server, processHandle, msgPtr, ComponentType::COMPONENT_TRACE, false};
    server.RunProcessTask(task);

    EXPECT_EQ(0U, g_hdcSessionCloseCount);
    EXPECT_EQ(0U, g_ideXfreeCount);
    EXPECT_EQ(1U, g_adxDestroyCommHandleCount);
    EXPECT_EQ(nullptr, task.handle);
}

// 持久组件 Process 失败但不释放句柄时，保持旧契约：组件拥有句柄，框架不得二次释放。
// 若未来契约改为“失败交还框架”，本用例会显式失败，防止所有权模型被隐式改动。
TEST_F(ADX_SERVER_MANAGER_UTEST, RunProcessTaskDoesNotDoubleFreePersistentFailedHandle)
{
    AdxServerManager server;
    AdxCommHandle processHandle = static_cast<AdxCommHandle>(IdeXmalloc(sizeof(CommHandle)));
    ASSERT_NE(nullptr, processHandle);
    *processHandle = CommHandle{OptType::COMM_HDC, 1, ComponentType::COMPONENT_SYS_REPORT, -1, nullptr};
    SharedPtr<MsgProto> msgPtr = MakeOwnershipMsg();
    std::unique_ptr<AdxComponent> component(
        new AdxOwnershipCountStub(ComponentType::COMPONENT_SYS_REPORT, false, false));
    ASSERT_TRUE(server.ComponentAdd(component));

    g_hdcSessionCloseCount = 0;
    g_ideXfreeCount = 0;
    g_adxDestroyCommHandleCount = 0;
    MOCKER(HdcSessionClose).expects(never()).will(invoke(HdcSessionCloseCountStub));
    MOCKER(IdeXfree).expects(never()).will(invoke(IdeXfreeCountStub));
    MOCKER(AdxDestroyCommHandle).expects(never()).will(invoke(AdxDestroyCommHandleCountStub));

    AdxServerManager::ProcessTask task{&server, processHandle, msgPtr, ComponentType::COMPONENT_SYS_REPORT, false};
    server.RunProcessTask(task);

    EXPECT_EQ(0U, g_hdcSessionCloseCount);
    EXPECT_EQ(0U, g_ideXfreeCount);
    EXPECT_EQ(0U, g_adxDestroyCommHandleCount);
    EXPECT_EQ(nullptr, task.handle);
}

// 组件在启动后被移除：框架必须关闭 session 并释放句柄，不能因组件缺失造成泄漏。
TEST_F(ADX_SERVER_MANAGER_UTEST, RunProcessTaskReleasesHandleWhenComponentMissing)
{
    AdxServerManager server;
    ClearCommOptMap();
    ASSERT_TRUE(RegisterHdcCommOpt(server));
    AdxCommHandle processHandle = static_cast<AdxCommHandle>(IdeXmalloc(sizeof(CommHandle)));
    ASSERT_NE(nullptr, processHandle);
    *processHandle = CommHandle{OptType::COMM_HDC, 1, ComponentType::COMPONENT_DUMP, -1, nullptr};
    SharedPtr<MsgProto> msgPtr = MakeOwnershipMsg();

    g_hdcSessionCloseCount = 0;
    g_ideXfreeCount = 0;
    MOCKER(HdcSessionClose).expects(once()).will(invoke(HdcSessionCloseCountStub));
    MOCKER(IdeXfree).expects(once()).will(invoke(IdeXfreeCountStub));

    AdxServerManager::ProcessTask task{&server, processHandle, msgPtr, ComponentType::COMPONENT_DUMP, false};
    server.RunProcessTask(task);

    EXPECT_EQ(1U, g_hdcSessionCloseCount);
    EXPECT_EQ(1U, g_ideXfreeCount);
    EXPECT_EQ(nullptr, task.handle);
}
