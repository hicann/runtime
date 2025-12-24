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

#include "hdc_api_stest.h"
#include <vector>
#include "ide_daemon_hdc_stest.h"

using namespace Adx;
extern int g_sprintf_s_flag;
class HDC_API_STEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(HDC_API_STEST, HdcClientInit)
{
    HDC_CLIENT client = (HDC_CLIENT) 0x12345678;

    MOCKER(drvHdcClientCreate)
        .stubs()
        .with(outBoundP(&client, sizeof(HDC_CLIENT *)), any(), any(), any())
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    //drvHdcClientCreatePlus failed
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcClientInit(NULL));

    //drvHdcClientCreatePlus failed
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcClientInit(&client));

    //HdcClientInit success
    EXPECT_EQ(IDE_DAEMON_OK, HdcClientInit(&client));
}

TEST_F(HDC_API_STEST, HdcClientDestroy)
{
    HDC_CLIENT client = (HDC_CLIENT)0x123456;

    MOCKER(drvHdcClientDestroy)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    //drvHdcClientDestroy failed
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcClientDestroy(client));

    //HdcClientDestroy success
    EXPECT_EQ(IDE_DAEMON_OK, HdcClientDestroy(client));
}

TEST_F(HDC_API_STEST, HdcServerDestroy)
{
    HDC_SERVER  handle = (HDC_SERVER)0x123456;

    MOCKER(drvHdcServerDestroy)
        .stubs()
        .will(repeat(DRV_ERROR_CLIENT_BUSY, 40))
        .then(returnValue(DRV_ERROR_NONE));

    //drvHdcServerDestroy failed
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcServerDestroy(handle));
}

TEST_F(HDC_API_STEST, HdcRead_invalid_parameters)
{
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcRead(NULL, NULL, NULL));
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcReadNb(NULL, NULL, NULL));
}

TEST_F(HDC_API_STEST, HdcRead)
{
    HDC_SESSION session = (HDC_SESSION)(0x12345678);
    void *buf = (void *)0x87654321;
    int recv_len = 100;
    int recvBufCount= 1;
    int buf_len = 100;
    struct drvHdcMsg *hdcMsg = (struct drvHdcMsg *)0x12345678;
    char *buf_tmp = (char *)malloc(buf_len);
    struct IdeHdcPacket *packet = (struct IdeHdcPacket*)buf_tmp;
    memset(buf_tmp,0,100);
    packet->type = IdeDaemonPackageType::IDE_DAEMON_LITTLE_PACKAGE;
    packet->isLast = IdeLastPacket::IDE_LAST_PACK;
    packet->len=100-sizeof(struct IdeHdcPacket);
    MOCKER(drvHdcAllocMsg)
        .stubs()
        .with(any(), outBoundP(&hdcMsg, sizeof(struct drvHdcMsg *)), any())
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    MOCKER(halHdcRecv)
        .stubs()
        .with(any(), any(), any(), any(), outBoundP(&recvBufCount, sizeof(recvBufCount)))
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(36))
        .then(returnValue(DRV_ERROR_SOCKET_CLOSE))
        .then(returnValue(DRV_ERROR_NONE));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .with(any(), any(), outBoundP(&buf_tmp, sizeof(buf_tmp)), outBoundP(&buf_len, sizeof(buf_len)))
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    MOCKER(drvHdcReuseMsg)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))    //drvHdcRecv´íÎó·ÖÖ§µÚÒ»´Îµ÷ÓÃ
        .then(returnValue(DRV_ERROR_NONE))    //drvHdcRecv´íÎó·ÖÖ§µÚ¶þ´Îµ÷ÓÃ
        .then(returnValue(DRV_ERROR_NONE))  //drvHdcRecv´íÎó·ÖÖ§µÚÈý´Îµ÷ÓÃ
        .then(returnValue(DRV_ERROR_NONE))    //drvHdcGetMsgBuffer´íÎó·ÖÖ§µ÷ÓÃ
        .then(returnValue(DRV_ERROR_NO_DEVICE))    //×Ô¼ºµÄ´íÎó·ÖÖ§µ÷ÓÃ
        .then(returnValue(DRV_ERROR_NONE));

    /*drvHdcAllocMsg error*/
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcRead(session, &buf, &recv_len));
    hdcMsg = (struct drvHdcMsg *)0x12345678;
    /*drvHdcRecv error*/
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcRead(session, &buf, &recv_len));
    hdcMsg = (struct drvHdcMsg *)0x12345678;
    /*drvHdcRecv no block*/
    EXPECT_EQ(IDE_DAEMON_RECV_NODATA, HdcRead(session, &buf, &recv_len));
    hdcMsg = (struct drvHdcMsg *)0x12345678;
    /*drvHdcFreeMsg error*/
    EXPECT_EQ(IDE_DAEMON_SOCK_CLOSE, HdcRead(session, &buf, &recv_len));
    hdcMsg = (struct drvHdcMsg *)0x12345678;
    /*drvHdcGetMsgBuffer error*/
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcRead(session, &buf, &recv_len)); //test drvHdcGetMsgBuffer²¿·Ö
    hdcMsg = (struct drvHdcMsg *)0x12345678;
    /*drvHdcFreeMsg error*/
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcRead(session, &buf, &recv_len));
    hdcMsg = (struct drvHdcMsg *)0x12345678;
    /*drvHdcReuseMsg error*/
    packet->isLast = IdeLastPacket::IDE_NOT_LAST_PACK;
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcRead(session, &buf, &recv_len));
    hdcMsg = (struct drvHdcMsg *)0x12345678;
    packet->type = IdeDaemonPackageType::IDE_DAEMON_BIG_PACKAGE;
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcRead(session, &buf, &recv_len));
    hdcMsg = (struct drvHdcMsg *)0x12345678;
    packet->type = IdeDaemonPackageType::IDE_DAEMON_LITTLE_PACKAGE;
    /*true*/
    packet->isLast = IdeLastPacket::IDE_LAST_PACK;
    EXPECT_EQ(DRV_ERROR_NONE, HdcRead(session, &buf, &recv_len));
    free(buf);
    buf = NULL;
    free(buf_tmp);
    buf_tmp = NULL;
}

TEST_F(HDC_API_STEST, HdcReadNb)
{
    HDC_SESSION session = (HDC_SESSION)(0x12345678);
    void *recv_buf;
    int recv_len;

    MOCKER(drvHdcAllocMsg)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE));

    EXPECT_EQ(IDE_DAEMON_ERROR, HdcReadNb(session, &recv_buf, &recv_len));
}

TEST_F(HDC_API_STEST, HdcWrite_invalid_parameter)
{
    HDC_SESSION session = (HDC_SESSION)(0x12345678);
    void *buf = (void *)malloc(100);
    int len = 100;

    EXPECT_EQ(IDE_DAEMON_ERROR, HdcWrite(NULL, buf, len));
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcWrite(session, NULL, len));
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcWrite(session, buf, 0));
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcSessionWrite(session, buf, 0, 0));

    free(buf);
    buf=NULL;
}

TEST_F(HDC_API_STEST, HdcWrite)
{
    HDC_SESSION session = (HDC_SESSION)(0x12345678);
    uint32_t maxSegment = 100;
    void *buf = (void *)malloc(100);
    int len = 100;
    struct drvHdcMsg *pmsg = (struct drvHdcMsg*)(0x1234567);

    MOCKER(HdcCapacity)
        .stubs()
        .with(outBoundP(&maxSegment, sizeof(maxSegment)))
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    MOCKER(drvHdcAllocMsg)
        .stubs()
        .with(any(), outBoundP(&pmsg, sizeof(pmsg)), any())
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    MOCKER(drvHdcAddMsgBuffer)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    MOCKER(halHdcSend)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    MOCKER(drvHdcReuseMsg)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(repeat(DRV_ERROR_NONE, 3))
        .then(returnValue(DRV_ERROR_INVALID_VALUE))
        .then(returnValue(DRV_ERROR_NONE));

    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(EOK - 1))
        .then(returnValue(EOK));
    //1. drvHdcGetCapacity return error
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcWrite(session, buf, len)); //drvHdcGetCapacity´íÎó·ÖÖ§

    //2. drvHdcAllocMsg return error
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcWrite(session, buf, len)); //drvHdcAllocMsg´íÎó·ÖÖ§

    //3. drvHdcAddMsgBuffer return error
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcWrite(session, buf, len)); //drvHdcAddMsgBuffer´íÎó·ÖÖ§

    //4. drvHdcSend return error
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcWrite(session, buf, len)); //drvHdcSend´íÎó·ÖÖ§

    //5. drvHdcReuseMsg return error
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcWrite(session, buf, len)); //drvHdcReuseMsg´íÎó·ÖÖ§

    //6. drvHdcFreeMsg return error
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcWrite(session, buf, len)); //drvHdcFreeMsg´íÎó·ÖÖ§

    //7. HdcWrite succ
    EXPECT_EQ(IDE_DAEMON_OK, HdcWrite(session, buf, len)); //ÕýÈ··ÖÖ§
    free(buf);
    buf=NULL;
}

TEST_F(HDC_API_STEST, HdcWriteNb)
{
    HDC_SESSION session = (HDC_SESSION)(0x12345678);
    uint32_t maxSegment = 100;
    void *buf = (void *)malloc(100);
    int len = 100;

    MOCKER(HdcSessionWrite)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_OK, HdcWriteNb(session, buf, len));

    free(buf);
    buf=NULL;
}

TEST_F(HDC_API_STEST, HdcWrite_get_capacity_size_too_small)
{
    HDC_SESSION session = (HDC_SESSION)(0x12345678);
    void *buf = (void *)malloc(100);
    int len = 100;

    MOCKER(HdcCapacity)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    EXPECT_EQ(IDE_DAEMON_ERROR, HdcWrite(session, buf, len));
    free(buf);
    buf = NULL;
}

TEST_F(HDC_API_STEST, HdcWrite_xmalloc_failed)
{
    HDC_SESSION session = (HDC_SESSION)(0x12345678);
    uint32_t maxSegment = 1024;
    char *buf = (char *)"test";
    int len = strlen(buf);

    MOCKER(HdcCapacity)
        .stubs()
        .with(outBoundP(&maxSegment, sizeof(maxSegment)))
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(IdeXmalloc)
        .stubs()
        .will(returnValue((void *)NULL));

    //IdeXmalloc failed
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcWrite(session, buf, len));
}

TEST_F(HDC_API_STEST, HdcWrite_memcpy_s_failed)
{
    HDC_SESSION session = (HDC_SESSION)(0x12345678);
    uint32_t maxSegment = 1024;
    char *buf = (char *)"test";
    int len = strlen(buf);

    MOCKER(HdcCapacity)
        .stubs()
        .with(outBoundP(&maxSegment, sizeof(maxSegment)))
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(-1));

    //memcpy_s failed
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcWrite(session, buf, len));
}

TEST_F(HDC_API_STEST, HdcSessionConnect)
{
    int peer_node = 0;
    int peer_devid = 0;
    HDC_CLIENT client = (HDC_CLIENT)(0x87654321);
    HDC_SESSION session = (HDC_SESSION)(0x12345678);

    MOCKER(drvHdcSessionConnect)
        .stubs()
        .then(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    MOCKER(drvHdcSetSessionReference)
        .stubs()
        .then(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    EXPECT_EQ(IDE_DAEMON_ERROR, HdcSessionConnect(-1, -1, NULL, NULL));//invalid parameters
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcSessionConnect(peer_node, peer_devid, client, &session)); //drvHdcSessionConnect
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcSessionConnect(peer_node, peer_devid, client, &session)); //drvHdcSetSessionReference failed
    EXPECT_EQ(DRV_ERROR_NONE, HdcSessionConnect(peer_node, peer_devid, client, &session));
}

TEST_F(HDC_API_STEST, HalHdcSessionConnect)
{
    int peer_node = 0;
    int peer_devid = 0;
    int host_pid = 123;
    HDC_CLIENT client = (HDC_CLIENT)(0x87654321);
    HDC_SESSION session = (HDC_SESSION)(0x12345678);

    MOCKER(halHdcSessionConnectEx)
        .stubs()
        .then(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    MOCKER(drvHdcSetSessionReference)
        .stubs()
        .then(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    EXPECT_EQ(IDE_DAEMON_ERROR, HalHdcSessionConnect(-1, -1, -1, NULL, NULL));//invalid parameters
    EXPECT_EQ(IDE_DAEMON_ERROR, HalHdcSessionConnect(peer_node, peer_devid, host_pid, client, &session)); //drvHdcSessionConnect
    EXPECT_EQ(IDE_DAEMON_ERROR, HalHdcSessionConnect(peer_node, peer_devid, host_pid, client, &session)); //drvHdcSetSessionReference failed
    EXPECT_EQ(DRV_ERROR_NONE, HalHdcSessionConnect(peer_node, peer_devid, host_pid, client, &session));
}


TEST_F(HDC_API_STEST, HdcSessionDestroy)
{
    HDC_SESSION session = (HDC_SESSION)(0x12345678);

    MOCKER(drvHdcSessionClose)
        .stubs()
        .then(returnValue(DRV_ERROR_NO_DEVICE))    //×Ô¼ºµÄ´íÎó·ÖÖ§µ÷ÓÃ
        .then(returnValue(DRV_ERROR_NONE));    //ÕýÈ·ÅÜÍê

    EXPECT_EQ(IDE_DAEMON_ERROR, HdcSessionDestroy(NULL));//invalid parameter
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcSessionDestroy(session)); //drvHdcSessionDestroy´íÎó·ÖÖ§
    EXPECT_EQ(DRV_ERROR_NONE, HdcSessionDestroy(session)); //ÕýÈ·ÅÜÍê
}

TEST_F(HDC_API_STEST, HdcSessionClose)
{
    HDC_SESSION session = (HDC_SESSION)(0x12345678);

    MOCKER(drvHdcSessionClose)
        .stubs()
        .then(returnValue(DRV_ERROR_NO_DEVICE))    //×Ô¼ºµÄ´íÎó·ÖÖ§µ÷ÓÃ
        .then(returnValue(DRV_ERROR_NONE));    //ÕýÈ·ÅÜÍê

    EXPECT_EQ(IDE_DAEMON_ERROR, HdcSessionClose(NULL));//invalid parameter
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcSessionClose(session)); //drvHdcSessionClose´íÎó·ÖÖ§
    EXPECT_EQ(DRV_ERROR_NONE, HdcSessionClose(session)); //ÕýÈ·ÅÜÍê
}

TEST_F(HDC_API_STEST, HdcStorePackage)
{
    struct IoVec ioVec;
    char *buf_tmp = (char *)malloc(100);
    unsigned int buf_len = 100 - sizeof(struct IdeHdcPacket);
    ioVec.base = buf_tmp;
    ioVec.len = buf_len;
    struct IdeHdcPacket *packet = (struct IdeHdcPacket*)buf_tmp;
    memset(buf_tmp,0,100);
    packet->type = IdeDaemonPackageType::IDE_DAEMON_BIG_PACKAGE;
    packet->isLast = IdeLastPacket::IDE_LAST_PACK;
    packet->len = buf_len;
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcStorePackage(*packet, ioVec));
    free(buf_tmp);
}

TEST_F(HDC_API_STEST, HdcStorePackage_data_too_big)
{
    struct IoVec ioVec;
    char *buf_tmp = (char *)malloc(100);
    unsigned int buf_len = 100 - sizeof(struct IdeHdcPacket);
    ioVec.base = buf_tmp;
    ioVec.len = buf_len;
    struct IdeHdcPacket *packet = (struct IdeHdcPacket*)buf_tmp;
    memset(buf_tmp,0,100);
    packet->type = IdeDaemonPackageType::IDE_DAEMON_LITTLE_PACKAGE;
    packet->isLast = IdeLastPacket::IDE_LAST_PACK;
    packet->len = UINT32_MAX;
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcStorePackage(*packet, ioVec));
    IdeXfree(buf_tmp);
}

TEST_F(HDC_API_STEST, HdcStorePackage_IdeXrmalloc_failed)
{
    struct IoVec ioVec;
    char *buf_tmp = (char *)malloc(100);
    struct IdeHdcPacket *packet = (struct IdeHdcPacket*)buf_tmp;
    unsigned int buf_len = 100 - sizeof(struct IdeHdcPacket);
    ioVec.base = buf_tmp;
    ioVec.len = buf_len;
    memset(buf_tmp, 0, 100);
    packet->type = IdeDaemonPackageType::IDE_DAEMON_LITTLE_PACKAGE;
    packet->isLast = IdeLastPacket::IDE_LAST_PACK;
    packet->len = 100 - buf_len;

    MOCKER(IdeXrmalloc)
        .stubs()
        .will(returnValue((void *)NULL));

    EXPECT_EQ(IDE_DAEMON_ERROR, HdcStorePackage(*packet, ioVec));
    free(buf_tmp);
}

TEST_F(HDC_API_STEST, HdcStorePackage_memcpy_s_failed)
{
    struct IoVec ioVec;
    char *buf_tmp = (char *)malloc(100);
    void *new_buf = (char *)malloc(100);
    struct IdeHdcPacket *packet = (struct IdeHdcPacket*)buf_tmp;
    unsigned int buf_len = 100 - sizeof(struct IdeHdcPacket);
    memset(buf_tmp, 0, 100);
    packet->type = IdeDaemonPackageType::IDE_DAEMON_LITTLE_PACKAGE;
    packet->isLast = IdeLastPacket::IDE_LAST_PACK;
    packet->len = 100 - buf_len;
    ioVec.base = buf_tmp;
    ioVec.len = buf_len;

    memset(new_buf, 0, 100);
    struct IdeHdcPacket *packet1 = (struct IdeHdcPacket*)new_buf;
    packet1->type = IdeDaemonPackageType::IDE_DAEMON_LITTLE_PACKAGE;
    packet1->isLast = IdeLastPacket::IDE_LAST_PACK;
    packet1->len = 100 - buf_len;


    MOCKER(IdeXrmalloc)
        .stubs()
        .will(returnValue(new_buf));
    
    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(-1));

    EXPECT_EQ(IDE_DAEMON_ERROR, HdcStorePackage(*packet1, ioVec));
}

TEST_F(HDC_API_STEST, HdcCapacity)
{
    unsigned int segment = 0;

    struct drvHdcCapacity capacity;
    capacity.maxSegment = 32 * 1024;

    MOCKER(drvHdcGetCapacity)
        .stubs()
        .with(outBoundP(&capacity, sizeof(capacity)))
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    EXPECT_EQ(IDE_DAEMON_ERROR, HdcCapacity(&segment));
    EXPECT_EQ(IDE_DAEMON_OK, HdcCapacity(&segment));
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcCapacity(NULL));
}

TEST_F(HDC_API_STEST, HdcCapacity_invalid_segment)
{
    unsigned int segment = 0;

    struct drvHdcCapacity capacity;
    capacity.maxSegment = 32;

    MOCKER(drvHdcGetCapacity)
        .stubs()
        .with(outBoundP(&capacity, sizeof(capacity)))
        .will(returnValue(DRV_ERROR_NONE));

    EXPECT_EQ(IDE_DAEMON_ERROR, HdcCapacity(&segment));
}

TEST_F(HDC_API_STEST, IdeGetDevIdBySession)
{
    HDC_SESSION session = (HDC_SESSION)0x1234567;
    int devId = -1;
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeGetDevIdBySession(NULL, NULL));
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeGetDevIdBySession(session, NULL));
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeGetDevIdBySession(NULL, &devId));

    MOCKER(halHdcGetSessionAttr)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE));
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeGetDevIdBySession(session, &devId));
    GlobalMockObject::verify();

    EXPECT_EQ(IDE_DAEMON_OK, IdeGetDevIdBySession(session, &devId));
    EXPECT_EQ(0, devId);
}

TEST_F(HDC_API_STEST, IdeGetDevList)
{
    std::vector<uint32_t> devs(DEVICE_NUM_MAX, 0);
    uint32_t devNum = 0;
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeGetDevList(NULL, devs, DEVICE_NUM_MAX));
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeGetDevList(&devNum, devs, 0));

    MOCKER(drvGetDevNum)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE));
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeGetDevList(&devNum, devs, DEVICE_NUM_MAX));
    GlobalMockObject::verify();

    MOCKER(drvGetDevIDs)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE));
    EXPECT_EQ(IDE_DAEMON_OK, IdeGetDevList(&devNum, devs, DEVICE_NUM_MAX));
}

TEST_F(HDC_API_STEST, IdeGetLogIdByPhyId)
{
    uint32_t logId = -1;

    MOCKER(IdeGetDevList)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeGetLogIdByPhyId(0, &logId));
}

