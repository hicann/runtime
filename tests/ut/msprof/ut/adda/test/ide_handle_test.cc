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
#include <fcntl.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <vector>

#include "ide_daemon_hdc_test.h"
#include "mmpa_stub.h"
#include "ide_platform_stub.h"
#include "ide_daemon_hdc.h"
#include "ide_common_util.h"
#include "adx_dsmi.h"
#include "ide_daemon_stub.h"
#include <map>

using std::make_pair;
using std::vector;
using namespace Adx;
using namespace Analysis::Dvvp::Adx;

using DevInfoT = struct IdeDevInfo;
extern struct IdeGlobalCtrlInfo g_ideGlobalInfo;
extern struct IdeComponentsFuncs g_ideComponentsFuncs;
extern int IdeDaemonHdcProcessEventOne(struct IdeSock &clientFd);
extern int IdeDaemonReadReq(const struct IdeTransChannel &handle, IdeTlvReqAddr req);
extern int IdeDaemonHdcProcessEventOne(const struct DevSession &devSession);
extern void IdeDaemonCreateHdcServer(DevInfoT *devInfo);
extern int IdeCreateHdcHandleThread(HDC_SESSION session, const DevInfoT &devInfo);
extern int IdeHdcDistroyDevice(const DevInfoT &devInfo);
extern IdeThreadArg IdeDaemonHdcHandleEvent(IdeThreadArg args);
extern int IdeHdcCheckRunEnv(HDC_SESSION session);

class IDE_HANDLE_UTEST: public testing::Test {
protected:
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    virtual void SetUp() {
        g_ideGlobalInfo.mapDevInfo.clear();
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(IDE_HANDLE_UTEST, IdeDaemonReadReq_recv_len_failed)
{
    int buf_len = UINT32_MAX;
    void *sock_desc = (void *)0x12345678;
    struct tlv_req *req = NULL;

    MOCKER(IdeRead)
        .stubs()
        .with(any(), any(), outBoundP(&buf_len, sizeof(int)), any())
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    struct IdeTransChannel handle = {IdeChannel::IDE_CHANNEL_SOCK, sock_desc};
    //IdeRead failed
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeDaemonReadReq(handle, &req));
    EXPECT_TRUE(req == NULL);
    //IdeXmalloc failed
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeDaemonReadReq(handle, &req));
    EXPECT_TRUE(req == NULL);
}

TEST_F(IDE_HANDLE_UTEST, IdeDaemonReadReq_IdeXmalloc_failed)
{
    int buf_len = 4;
    char *buf = (char *)IdeXmalloc(buf_len);
    void *sock_desc = (void *)0x12345678;
    struct tlv_req *req = NULL;

    MOCKER(IdeXmalloc)
        .stubs()
        .will(returnValue((void *)NULL));

    MOCKER(IdeRead)
        .stubs()
        .with(any(), outBoundP((void **)&buf, sizeof(void *)), outBoundP(&buf_len, sizeof(int)), any())
        .will(returnValue(IDE_DAEMON_OK));

    //IdeXmalloc failed
    struct IdeTransChannel handle = {IdeChannel::IDE_CHANNEL_SOCK, sock_desc};
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeDaemonReadReq(handle, &req));
    EXPECT_TRUE(req == NULL);
}

TEST_F(IDE_HANDLE_UTEST, IdeDaemonReadReq_memcpy_s_failed)
{
    int buf_len = 4;
    char *buf = (char *)IdeXmalloc(buf_len);
    void *sock_desc = (void *)0x12345678;
    struct tlv_req *req = NULL;

    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(-1));

    MOCKER(IdeRead)
        .stubs()
        .with(any(), outBoundP((void **)&buf, sizeof(void *)), outBoundP(&buf_len, sizeof(int)), any())
        .will(returnValue(IDE_DAEMON_OK));

    //IdeXmalloc failed
    struct IdeTransChannel handle = {IdeChannel::IDE_CHANNEL_SOCK, sock_desc};
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeDaemonReadReq(handle, &req));
}

TEST_F(IDE_HANDLE_UTEST, IdeDaemonReadReqLenFailed)
{
    int buf_len = 24;
    char *buf = (char *)IdeXmalloc(buf_len);
    struct tlv_req * ceq = (struct tlv_req *)buf;
    ceq->len = buf_len - sizeof(struct tlv_req) - 1;
    void *sock_desc = (void *)0x12345678;
    struct tlv_req *req = NULL;

    MOCKER(IdeRead)
        .stubs()
        .with(any(), outBoundP((void **)&buf, sizeof(void *)), outBoundP(&buf_len, sizeof(int)), any())
        .will(returnValue(IDE_DAEMON_OK));
    //succ failed
    struct IdeTransChannel handle = {IdeChannel::IDE_CHANNEL_SOCK, sock_desc};
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeDaemonReadReq(handle, &req));
}

TEST_F(IDE_HANDLE_UTEST, IdeDaemonReadReqSucc)
{
    int buf_len = 24;
    char *buf = (char *)IdeXmalloc(buf_len);
    struct tlv_req * ceq = (struct tlv_req *)buf;
    ceq->len = buf_len - sizeof(struct tlv_req);
    void *sock_desc = (void *)0x12345678;
    struct tlv_req *req = NULL;

   MOCKER(IdeRead)
        .stubs()
        .with(any(), outBoundP((void **)&buf, sizeof(void *)), outBoundP(&buf_len, sizeof(int)), any())
        .will(returnValue(IDE_DAEMON_OK));

    //succ failed
    struct IdeTransChannel handle = {IdeChannel::IDE_CHANNEL_SOCK, sock_desc};
    EXPECT_EQ(IDE_DAEMON_OK, IdeDaemonReadReq(handle, &req));
    IdeXfree(req);
}

TEST_F(IDE_HANDLE_UTEST, IdeDaemonHdcProcessEventOneTest)
{
    HDC_SESSION  session = (HDC_SESSION)0x12345678;
    struct DevSession *devSession = (struct DevSession *)IdeXmalloc(sizeof(struct DevSession));
    TlvReqT *req = (TlvReqT *)IdeXmalloc(sizeof(TlvReqT));
    devSession->session  = session;
    req->type = IDE_INVALID_REQ;
    req->dev_id = 0;

    g_ideComponentsFuncs.hdcProcess[IDE_COMPONENT_CMD] = ide_daemon_cmd_process_stub;

    MOCKER(IdeDaemonReadReq)
        .stubs()
        .with(any(), outBoundP(&req, sizeof(struct tlv_req *)), any())
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    MOCKER(IdeGetComponentType)
        .stubs()
        .will(returnValue(IDE_COMPONENT_CMD))
        .then(returnValue(NR_IDE_COMPONENTS));

    //3.IdeDaemonHdcProcessEventOne success
    MOCKER(ide_daemon_cmd_process_stub)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    MOCKER(IdeReqFree)
        .stubs();

    //1.ide_daemon_sock_read_req failed
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeDaemonHdcProcessEventOne(*devSession));

    //2.ide_daemon_cmd_process_stub failed
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeDaemonHdcProcessEventOne(*devSession));

    //3.ide_daemon_cmd_process_stub success
    EXPECT_EQ(nullptr, IdeDaemonHdcProcessEvent(devSession));
    IdeXfree(req);
}

int32_t g_drvHdcServ = 0;
hdcError_t drvHdcServerCreateStub(int devid, int serviceType, HDC_SERVER *pServer)
{
    *pServer = (HDC_SERVER)0x12345678;
    g_drvHdcServ++;
    if (g_drvHdcServ == 1) {
        return DRV_ERROR_DEVICE_NOT_READY;
    }
    if (g_drvHdcServ == 2) {
        return (hdcError_t)(DRV_ERROR_NONE + 1);
    }
    return DRV_ERROR_NONE;
}

TEST_F(IDE_HANDLE_UTEST, IdeDaemonCreateHdcServerTest)
{
    struct IdeDevInfo devInfo;
    devInfo.phyDevId  = 1;
    devInfo.serviceType = (drvHdcServiceType)0x1;

    g_ideGlobalInfo.hdcHandleEventFlag = true;

    MOCKER(IdeGetLogIdByPhyId)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    MOCKER(drvHdcServerCreate)
        .stubs()
        .will(invoke(drvHdcServerCreateStub));

    IdeDaemonCreateHdcServer(&devInfo);
    EXPECT_EQ(devInfo.server, (HDC_SERVER)0x12345678);
}

TEST_F(IDE_HANDLE_UTEST, IdeCreateHdcHandleThread)
{
    HDC_SESSION  session = (HDC_SESSION)0x12345678;
    struct DevSession devSession;
    struct IdeDevInfo devInfo;
    uintptr_t server_id = 0x12345678;
    HDC_SERVER server = (HDC_SERVER)server_id;
    devInfo.phyDevId  = 1;
    devInfo.server = server;
    devInfo.serviceType = (drvHdcServiceType)0x1;

    g_ideGlobalInfo.hdcHandleEventFlag = true;

    MOCKER(IdeXmalloc)
        .stubs()
        .will(returnValue((void*)NULL))
        .then(returnValue((void*)&devSession));

    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_OK));

    MOCKER(IdeXfree)
        .stubs();

    //1.IdeCreateHdcHandleThread failed
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCreateHdcHandleThread(session, devInfo));
    //2.IdeCreateHdcHandleThread failed
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCreateHdcHandleThread(session, devInfo));
    //3.IdeCreateHdcHandleThread success
    EXPECT_EQ(IDE_DAEMON_OK, IdeCreateHdcHandleThread(session, devInfo));
}

TEST_F(IDE_HANDLE_UTEST, IdeHdcDistroyDeviceTest)
{
    DevInfoT devInfo = {0};
    uint32_t phyDevId = 1;
    uint32_t devCount = 0;

    g_ideGlobalInfo.hdcClient = (HDC_CLIENT)1;

    devInfo.phyDevId = phyDevId;
    devInfo.server = nullptr;
    devInfo.createHdc = false;
    devInfo.devDisable = true;
    devInfo.serviceType = HDC_SERVICE_TYPE_IDE2;

    g_ideGlobalInfo.mapDevInfo.insert(std::pair<int, DevInfoT>(phyDevId, devInfo));
    phyDevId += 1;
    devInfo.phyDevId = phyDevId;
    g_ideGlobalInfo.mapDevInfo.insert(std::pair<int, DevInfoT>(phyDevId, devInfo));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHdcDistroyDevice(devInfo));
    devInfo.devDisable = false;
    EXPECT_EQ(IDE_DAEMON_OK, IdeHdcDistroyDevice(devInfo));
}

TEST_F(IDE_HANDLE_UTEST, IdeDaemonHdcHandleEventTest)
{
    HDC_SESSION session = (HDC_SESSION)0x12345;
    DevInfoT devInfo = {0};
    uint32_t phyDevId = 1;
    uint32_t devCount = 0;
    uintptr_t server_id = 0x12345678;

    g_ideGlobalInfo.hdcClient = (HDC_CLIENT)1;

    devInfo.phyDevId = phyDevId;
    devInfo.server = (HDC_SERVER)server_id;
    devInfo.createHdc = false;
    devInfo.devDisable = true;
    devInfo.serviceType = HDC_SERVICE_TYPE_IDE2;

    MOCKER(IdeDaemonCreateHdcServer)
        .stubs();

    MOCKER(drvHdcSessionAccept)
        .stubs()
        .with(any(), outBoundP(&session))
        .will(returnValue(DRV_ERROR_DEVICE_NOT_READY))
        .then(returnValue(DRV_ERROR_DEVICE_NOT_READY))
        .then(returnValue(DRV_ERROR_NONE));

    MOCKER(mmGetErrorCode)
        .stubs()
        .will(returnValue(EINTR))
        .then(returnValue(EINTR+1));

    MOCKER(drvHdcServerDestroy)
        .stubs()
        .will(returnValue(DRV_ERROR_DEVICE_NOT_READY))
        .then(returnValue(DRV_ERROR_NONE));

    MOCKER(IdeHdcDistroyDevice)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    MOCKER(drvHdcSetSessionReference)
        .stubs()
        .will(returnValue(DRV_ERROR_DEVICE_NOT_READY))
        .then(returnValue(DRV_ERROR_NONE));

    MOCKER(IdeHdcCheckRunEnv)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(IdeCreateHdcHandleThread)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    MOCKER(HdcSessionClose)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    //1.IdeDaemonHdcHandleEvent first break
    EXPECT_EQ(nullptr, IdeDaemonHdcHandleEvent(IdeThreadArg(&devInfo)));
    //2.IdeDaemonHdcHandleEvent second break
    EXPECT_EQ(nullptr, IdeDaemonHdcHandleEvent(IdeThreadArg(&devInfo)));
}
