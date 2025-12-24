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

#include "ascend_hal.h"
#include "hdc_api.h"
#include "adcore_api.h"
#include "memory_utils.h"
#include "adx_msg_proto.h"
#include "mmpa_api.h"
#include "file_utils.h"
#include "extra_config.h"
#include "hdc_comm_opt.h"

using namespace Adx;

class ADX_HDC_INTERFACE_UTEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(ADX_HDC_INTERFACE_UTEST, AdxSendMsgAndGetResultByType)
{
    const char *value = "a.txt;b.txt;123";
    struct tlv_req *req = NULL;
    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen(value) + 10);
    strcpy(req->value, value);
    req->len = strlen(value);
    req->type = IDE_SEND_FILE_REQ;
    char* result = "_result_";
    uint32_t len = sizeof(result);

    HDC_CLIENT client = (HDC_CLIENT)0x12345678;
    MOCKER(Adx::HdcClientCreate)
        .stubs()
        .will(returnValue((HDC_CLIENT)nullptr))
        .then(returnValue(client));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxSendMsgAndGetResultByType((enum drvHdcServiceType)0, nullptr, result, len));

    MOCKER(Adx::HdcSessionConnect)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxSendMsgAndGetResultByType((enum drvHdcServiceType)0, req, result, len));

    MOCKER(Adx::AdxMsgProto::SendMsgData)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxSendMsgAndGetResultByType((enum drvHdcServiceType)0, req, result, len));

    IDE_XFREE_AND_SET_NULL(req);
}

TEST_F(ADX_HDC_INTERFACE_UTEST, AdxSendMsgAndNoResultByType)
{
    const char *value = "a.txt;b.txt;123";
    struct tlv_req *req = NULL;
    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen(value) + 10);
    strcpy(req->value, value);
    req->len = strlen(value);
    req->type = IDE_SEND_FILE_REQ;

    HDC_CLIENT client = (HDC_CLIENT)0x12345678;
    MOCKER(Adx::HdcClientCreate)
        .stubs()
        .will(returnValue((HDC_CLIENT)nullptr))
        .then(returnValue(client));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxSendMsgAndNoResultByType((enum drvHdcServiceType)0, nullptr));

    MOCKER(Adx::HdcSessionConnect)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxSendMsgAndNoResultByType((enum drvHdcServiceType)0, req));

    MOCKER(Adx::AdxMsgProto::SendMsgData)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxSendMsgAndNoResultByType((enum drvHdcServiceType)0, req));

    IDE_XFREE_AND_SET_NULL(req);
}

TEST_F(ADX_HDC_INTERFACE_UTEST, ReadSettingResultNotEnd)
{
    const char *value = "a.txt;b.txt;123";
    struct tlv_req *req = NULL;
    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen(value) + 10);
    strcpy(req->value, value);
    req->len = strlen(value);
    req->type = IDE_SEND_FILE_REQ;
    char *result = "_result_";
    uint32_t len = sizeof(result);

    HDC_CLIENT client = (HDC_CLIENT)0x12345678;
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    MOCKER(Adx::HdcClientCreate).stubs().will(returnValue(client));
    MOCKER(Adx::HdcSessionConnect).stubs().with(any(), any(), any(), outBoundP(&session)).will(returnValue(IDE_DAEMON_OK));
    MOCKER(Adx::HdcWrite).stubs().will(returnValue(IDE_DAEMON_OK));

    std::string str = "_message_";
    MOCKER(Adx::AdxMsgProto::GetStringMsgData)
        .stubs()
        .with(any(), outBound(str))
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));
    EXPECT_NE(IDE_DAEMON_OK, AdxSendMsgAndGetResultByType((enum drvHdcServiceType)0, req, result, len));

    IDE_XFREE_AND_SET_NULL(req);
}

TEST_F(ADX_HDC_INTERFACE_UTEST, ReadSettingResultEnd)
{
    const char *value = "a.txt;b.txt;123";
    struct tlv_req *req = NULL;
    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen(value) + 10);
    strcpy(req->value, value);
    req->len = strlen(value);
    req->type = IDE_SEND_FILE_REQ;
    char *result = "_result_";
    uint32_t len = sizeof(result);

    HDC_CLIENT client = (HDC_CLIENT)0x12345678;
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    MOCKER(Adx::HdcClientCreate).stubs().will(returnValue(client));
    MOCKER(Adx::HdcSessionConnect).stubs().with(any(), any(), any(), outBoundP(&session)).will(returnValue(IDE_DAEMON_OK));
    MOCKER(Adx::HdcWrite).stubs().will(returnValue(IDE_DAEMON_OK));

    std::string str = "###[HDC_MSG]hdc_end_msg_used_by_framework###";
    MOCKER(Adx::AdxMsgProto::GetStringMsgData)
        .stubs()
        .with(any(), outBound(str))
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(strncpy_s)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    EXPECT_EQ(IDE_DAEMON_OK, AdxSendMsgAndGetResultByType((enum drvHdcServiceType)0, req, result, len));

    IDE_XFREE_AND_SET_NULL(req);
}

TEST_F(ADX_HDC_INTERFACE_UTEST, AdxSendMsgByHandle)
{
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    CommHandle handle{COMM_HDC, (OptHandle)session};
    const char *value = "receive_success";
    uint32_t len = sizeof(value);
    MOCKER(Adx::AdxMsgProto::SendMsgData)
        .stubs()
        .will(returnValue(IDE_DAEMON_UNKNOW_ERROR))
        .then(returnValue(IDE_DAEMON_NONE_ERROR));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxSendMsgByHandle(&handle, IDE_LOG_LEVEL_REQ, value, len));
    EXPECT_EQ(IDE_DAEMON_OK, AdxSendMsgByHandle(&handle, IDE_LOG_LEVEL_REQ, value, len));
}

TEST_F(ADX_HDC_INTERFACE_UTEST, AdxSendFileByHandle)
{
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    CommHandle handle{COMM_HDC, (OptHandle)session};
    char *src = "/home/src";
    char *des = "/home/des";

    MOCKER(Adx::FileUtils::IsFileExist)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxSendFileByHandle(&handle, IDE_EXEC_COMMAND_REQ, src, des, SEND_FILE_TYPE_REAL_FILE));

    MOCKER(mmOpen2)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(1));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxSendFileByHandle(&handle, IDE_EXEC_COMMAND_REQ, src, des, SEND_FILE_TYPE_REAL_FILE));

    MOCKER(Adx::AdxMsgProto::SendMsgData)
        .stubs()
        .will(returnValue(IDE_DAEMON_UNKNOW_ERROR))
        .then(returnValue(IDE_DAEMON_NONE_ERROR));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxSendFileByHandle(&handle, IDE_EXEC_COMMAND_REQ, src, des, SEND_FILE_TYPE_REAL_FILE));

    MOCKER(Adx::AdxMsgProto::SendEventFile)
        .stubs()
        .will(returnValue(IDE_DAEMON_UNKNOW_ERROR))
        .then(returnValue(IDE_DAEMON_NONE_ERROR));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxSendFileByHandle(&handle, IDE_EXEC_COMMAND_REQ, src, des, SEND_FILE_TYPE_REAL_FILE));
    EXPECT_EQ(IDE_DAEMON_OK, AdxSendFileByHandle(&handle, IDE_EXEC_COMMAND_REQ, src, des, SEND_FILE_TYPE_REAL_FILE));
}

static int HdcReadDumpDataApiEndStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    static int loop = 0;
    char *send = HDC_END_MSG;
    uint32_t len = strlen(send);
    MsgProto *msg = (MsgProto *)IdeXmalloc(sizeof(MsgProto) + len);

    msg->reqType = IDE_INVALID_REQ;
    msg->devId = 0;

    msg->sliceLen = len;
    msg->totalLen = len;

    (void)memcpy_s(msg->data, len, send, len);
    std::cout<<"HdcReadDumpDataApiEndStub : "<<*recvLen <<std::endl;
    *recvBuf = (void *)msg;
    *recvLen = msg->totalLen + sizeof(MsgProto);
    return IDE_DAEMON_OK;
}

static errno_t StrncpyStub(char *strDest, size_t destMax, const char *strSrc, size_t count)
{
    (void)strcpy(strDest, strSrc);
    return 0;
}

static int HdcReadDumpDataApiStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    static int loop = 1;
    char *send = "hdc_message";
    if (loop % 5 == 0) {
        send = HDC_END_MSG;
    }
    uint32_t len = strlen(send);
    MsgProto *msg = (MsgProto *)IdeXmalloc(sizeof(MsgProto) + len);
    msg->reqType = IDE_INVALID_REQ;
    msg->devId = 0;
    msg->sliceLen = len;
    msg->totalLen = len;
    (void)memcpy_s(msg->data, len, send, len);
    *recvBuf = (void *)msg;
    *recvLen = msg->totalLen + sizeof(MsgProto);
    std::cout<<"HdcReadDumpDataApiStub : "<<send <<std::endl;
    loop++;
    return IDE_DAEMON_OK;
}

TEST_F(ADX_HDC_INTERFACE_UTEST, AdxCreateCommHandle)
{
    AdxCommConHandle handle = AdxCreateCommHandle((enum drvHdcServiceType)3, 7, COMPONENT_GETD_FILE);
    EXPECT_EQ(-1, AdxIsCommHandleValid(handle));

    char send[100] = "hdc_message";
    unsigned int len = 100;
    char recv[100] = {"0"};
    char *get = (char *)IdeXmalloc(len);
    int val = -1;
    EXPECT_EQ(-1, AdxGetAttrByCommHandle(handle, 0, &val));
    EXPECT_EQ(-1, AdxSendMsg(handle, send, 100));

    MOCKER(HdcReadNb).stubs()
        .will(invoke(HdcReadDumpDataApiStub));

    MOCKER(memcpy_s)
        .stubs()
        .will(invoke(StrncpyStub));

    EXPECT_EQ(-1, AdxRecvMsg((AdxCommHandle)handle, &get, &len, -1));
    IdeXfree(get);

    AdxDestroyCommHandle((AdxCommHandle)handle);
    handle = nullptr;
}

hdcError_t DrvHdcAllocMsgStub(HDC_SESSION session, struct drvHdcMsg **ppMsg, signed int count)
{
    char *tmp = "tmp_value.";
    uint32_t len = strlen(tmp);
    struct IdeHdcPacket* packet = NULL;
    packet = (struct IdeHdcPacket *)IdeXmalloc(len + sizeof(struct IdeHdcPacket));
    packet->type = IdeDaemonPackageType::IDE_DAEMON_LITTLE_PACKAGE;
    packet->len = len;
    packet->isLast = IdeLastPacket::IDE_LAST_PACK;
    memcpy(packet->value, tmp, len);

    *ppMsg = (drvHdcMsg*)packet;
    return DRV_ERROR_NONE;
}

drvError_t DrvHdcFreeMsgStub(struct drvHdcMsg *msg)
{
    IdeXfree(msg);
    return DRV_ERROR_NONE;
}

TEST_F(ADX_HDC_INTERFACE_UTEST, AdxCreateRecvLenFail)
{
    MOCKER(drvHdcAllocMsg).stubs().will(invoke(DrvHdcAllocMsgStub));
    MOCKER(drvHdcFreeMsg).stubs().will(invoke(DrvHdcFreeMsgStub));
    AdxCommConHandle handle = AdxCreateCommHandle((enum drvHdcServiceType)3, 7, COMPONENT_GETD_FILE);
    EXPECT_EQ(0, AdxIsCommHandleValid(handle));

    char send[100] = "hdc_message";
    unsigned int len = 1;
    char recv[100] = {"0"};
    char *get = (char *)IdeXmalloc(len);
    int val = -1;
    EXPECT_EQ(0, AdxGetAttrByCommHandle(handle, 0, &val));
    EXPECT_EQ(0, AdxSendMsg(handle, send, 100));

    MOCKER(HdcReadNb).stubs()
        .will(invoke(HdcReadDumpDataApiStub));

    EXPECT_EQ(-1, AdxRecvMsg((AdxCommHandle)handle, &get, &len, -1));
    IdeXfree(get);

    AdxDestroyCommHandle((AdxCommHandle)handle);
    handle = nullptr;
}

static int HdcReadDumpDataLessStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    static int loop = 1;
    char *send = "hdc_message";
    if (loop % 5 == 0) {
        send = HDC_END_MSG;
    }
    uint32_t len = strlen(send);
    void *msg = (void *)IdeXmalloc(sizeof(MsgProto) - 10);
    *recvBuf = msg;
    *recvLen = sizeof(MsgProto) - 10;
    std::cout<<"HdcReadDumpDataLessStub : "<<send <<std::endl;
    loop++;
    return IDE_DAEMON_OK;
}

TEST_F(ADX_HDC_INTERFACE_UTEST, AdxCreateReadLessFail)
{
    MOCKER(drvHdcAllocMsg).stubs().will(invoke(DrvHdcAllocMsgStub));
    MOCKER(drvHdcFreeMsg).stubs().will(invoke(DrvHdcFreeMsgStub));
    AdxCommConHandle handle = AdxCreateCommHandle((enum drvHdcServiceType)3, 7, COMPONENT_GETD_FILE);
    EXPECT_EQ(0, AdxIsCommHandleValid(handle));

    char send[100] = "hdc_message";
    unsigned int len = 100;
    char recv[100] = {"0"};
    char *get = (char *)IdeXmalloc(len);
    int val = -1;
    EXPECT_EQ(0, AdxGetAttrByCommHandle(handle, 0, &val));
    EXPECT_EQ(0, AdxSendMsg(handle, send, 100));

    MOCKER(HdcReadNb).stubs()
        .will(invoke(HdcReadDumpDataLessStub));

    EXPECT_EQ(5, AdxRecvMsg((AdxCommHandle)handle, &get, &len, -1));
    IdeXfree(get);

    AdxDestroyCommHandle((AdxCommHandle)handle);
    handle = nullptr;
}

TEST_F(ADX_HDC_INTERFACE_UTEST, AdxCreateCommHandleGetCapacityFailed)
{
    struct drvHdcCapacity capacity = {HDC_CHAN_TYPE_MAX, 0};
    MOCKER(drvHdcGetCapacity)
        .stubs()
        .with(outBound(&capacity))
        .will(returnValue(0));

    AdxCommConHandle handle = AdxCreateCommHandle((enum drvHdcServiceType)3, 7, COMPONENT_GETD_FILE);
    EXPECT_EQ(-1, AdxIsCommHandleValid(handle));
}

TEST_F(ADX_HDC_INTERFACE_UTEST, AdxCreateCommHandleSessionConnectFailed)
{
    MOCKER(drvHdcSessionConnect)
        .stubs()
        .will(returnValue(2));

    AdxCommConHandle handle = AdxCreateCommHandle((enum drvHdcServiceType)3, 7, COMPONENT_GETD_FILE);
    EXPECT_EQ(-1, AdxIsCommHandleValid(handle));
}

TEST_F(ADX_HDC_INTERFACE_UTEST, AdxCreateCommHandleClientCreateFailed)
{
    MOCKER(drvHdcClientCreate)
        .stubs()
        .will(returnValue(2));

    AdxCommConHandle handle = AdxCreateCommHandle((enum drvHdcServiceType)3, 7, COMPONENT_GETD_FILE);
    EXPECT_EQ(-1, AdxIsCommHandleValid(handle));
}

TEST_F(ADX_HDC_INTERFACE_UTEST, AdxCreateCommHandleSendMsgFailed)
{
    MOCKER(halHdcSend)
        .stubs()
        .will(returnValue(2));

    AdxCommConHandle handle = AdxCreateCommHandle((enum drvHdcServiceType)3, 7, COMPONENT_GETD_FILE);
    EXPECT_EQ(-1, AdxIsCommHandleValid(handle));
}

TEST_F(ADX_HDC_INTERFACE_UTEST, AdcoreInterfaceInvalidInput)
{
    MOCKER(drvHdcAllocMsg).stubs()
        .will(invoke(DrvHdcAllocMsgStub));

    MOCKER(drvHdcFreeMsg).stubs()
        .will(invoke(DrvHdcFreeMsgStub));

    AdxCommConHandle handle = AdxCreateCommHandle((enum drvHdcServiceType)3, 7, COMPONENT_GETD_FILE);
    EXPECT_EQ(-1, AdxIsCommHandleValid(nullptr));
    EXPECT_EQ(-1, AdxGetAttrByCommHandle(handle, 0, nullptr));
    EXPECT_EQ(-1, AdxSendMsg(handle, nullptr, 100));
    EXPECT_EQ(-1, AdxRecvMsg((AdxCommHandle)handle, nullptr, nullptr, -1));
    uint32_t len = 100;
    EXPECT_EQ(-1, AdxRecvMsg((AdxCommHandle)handle, nullptr, &len, -1));
    EXPECT_EQ(0, len);
    AdxDestroyCommHandle((AdxCommHandle)handle);
    handle = nullptr;
}

hdcError_t DrvHdcGetMsgBufferStub(struct drvHdcMsg *msg, int index, char **pBuf, int *pLen)
{
    static int loop = 1;
    struct IdeHdcPacket* packet= (struct IdeHdcPacket*)msg;
    if (loop % 3 == 0) {
        packet->isLast = IdeLastPacket::IDE_LAST_PACK;
    } else {
        packet->isLast = IdeLastPacket::IDE_NOT_LAST_PACK;
    }
    *pBuf = (char *)packet;
    *pLen = packet->len + sizeof(IdeHdcPacket);
    loop++;
    return DRV_ERROR_NONE;
}

hdcError_t DrvHdcGetMsgBufferFullStub(struct drvHdcMsg *msg, int index, char **pBuf, int *pLen)
{
    static int loop = 1;
    struct IdeHdcPacket* packet= (struct IdeHdcPacket*)msg;
    if (loop % 3 == 0) {
        packet->isLast = IdeLastPacket::IDE_LAST_PACK;
        packet->len = UINT32_MAX;
        *pLen = INT32_MAX - 1;
    } else {
        packet->isLast = IdeLastPacket::IDE_NOT_LAST_PACK;
        *pLen = packet->len + sizeof(IdeHdcPacket);
    }
    *pBuf = (char *)packet;
    loop++;
    return DRV_ERROR_NONE;
}

hdcError_t DrvHdcRecvStub(HDC_SESSION session, struct drvHdcMsg *msg, int bufLen,
        unsigned long long flag, int *recvBufCount, unsigned int timeout)
{
   *recvBufCount = 1;
   return DRV_ERROR_NONE;
}

hdcError_t DrvHdcRecvFullStub(HDC_SESSION session, struct drvHdcMsg *msg, int bufLen,
        unsigned long long flag, int *recvBufCount, unsigned int timeout)
{
   *recvBufCount = 3;
   return DRV_ERROR_NONE;
}

TEST_F(ADX_HDC_INTERFACE_UTEST, HdcReadTimeout)
{
    OptHandle session = (OptHandle)0x123456;
    char *result;

    MOCKER(drvHdcAllocMsg).stubs()
        .will(invoke(DrvHdcAllocMsgStub));

    MOCKER(halHdcRecv).stubs()
        .will(invoke(DrvHdcRecvStub));

    MOCKER(drvHdcGetMsgBuffer).stubs()
        .will(invoke(DrvHdcGetMsgBufferStub));

    MOCKER(drvHdcFreeMsg).stubs()
        .will(invoke(DrvHdcFreeMsgStub));

    uint32_t length = 1024;
    char *data = (char *)IdeXmalloc(length);
    CommHandle handle = {OptType::COMM_HDC, (OptHandle)0x11223344, COMPONENT_TRACE, 36, nullptr};
    EXPECT_EQ(1, AdxRecvMsg(&handle, &data, &length, 25));

    IdeXfree(data);
    data = nullptr;
}

TEST_F(ADX_HDC_INTERFACE_UTEST, HdcReadPackageLenFailed)
{
    OptHandle session = (OptHandle)0x123456;
    char *result;

    MOCKER(drvHdcAllocMsg).stubs()
        .will(invoke(DrvHdcAllocMsgStub));

    MOCKER(halHdcRecv).stubs()
        .will(invoke(DrvHdcRecvFullStub));

    MOCKER(drvHdcGetMsgBuffer).stubs()
        .will(invoke(DrvHdcGetMsgBufferFullStub));

    MOCKER(drvHdcFreeMsg).stubs()
        .will(invoke(DrvHdcFreeMsgStub));

    uint32_t length = 1024;
    char *data = (char *)IdeXmalloc(length);
    CommHandle handle = {OptType::COMM_HDC, (OptHandle)0x11223344, COMPONENT_TRACE, 36, nullptr};
    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, AdxRecvMsg(&handle, &data, &length, 25));

    IdeXfree(data);
    data = nullptr;
}

TEST_F(ADX_HDC_INTERFACE_UTEST, HdcReadNoDeviceFailed)
{
    OptHandle session = (OptHandle)0x123456;
    char *result;

    MOCKER(drvHdcAllocMsg).stubs()
        .will(invoke(DrvHdcAllocMsgStub));

    MOCKER(halHdcRecv).stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE));

    MOCKER(drvHdcFreeMsg).stubs()
        .will(invoke(DrvHdcFreeMsgStub));

    uint32_t length = 1024;
    char *data = (char *)IdeXmalloc(length);
    CommHandle handle = {OptType::COMM_HDC, (OptHandle)0x11223344, COMPONENT_TRACE, 36, nullptr};
    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, AdxRecvMsg(&handle, &data, &length, 25));

    IdeXfree(data);
    data = nullptr;
}

TEST_F(ADX_HDC_INTERFACE_UTEST, HdcReuseMsgFailed)
{
    OptHandle session = (OptHandle)0x123456;
    char *result;

    MOCKER(drvHdcAllocMsg).stubs()
        .will(invoke(DrvHdcAllocMsgStub));

    MOCKER(halHdcRecv).stubs()
        .will(invoke(DrvHdcRecvStub));

    MOCKER(drvHdcGetMsgBuffer).stubs()
        .will(invoke(DrvHdcGetMsgBufferStub));

    MOCKER(drvHdcFreeMsg).stubs()
        .will(invoke(DrvHdcFreeMsgStub));

    MOCKER(drvHdcReuseMsg).stubs()
        .will(returnValue(DRV_ERROR_SOCKET_CLOSE));

    uint32_t length = 1024;
    char *data = (char *)IdeXmalloc(length);
    CommHandle handle = {OptType::COMM_HDC, (OptHandle)0x11223344, COMPONENT_TRACE, 36, nullptr};
    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, AdxRecvMsg(&handle, &data, &length, 25));

    IdeXfree(data);
    data = nullptr;
}

TEST_F(ADX_HDC_INTERFACE_UTEST, HdcReadTimeoutFailed)
{
    OptHandle session = (OptHandle)0x123456;
    char *result;

    MOCKER(drvHdcAllocMsg).stubs()
        .will(invoke(DrvHdcAllocMsgStub));

    MOCKER(halHdcRecv).stubs()
        .will(returnValue(DRV_ERROR_WAIT_TIMEOUT));

    MOCKER(drvHdcGetMsgBuffer).stubs()
        .will(invoke(DrvHdcGetMsgBufferStub));

    MOCKER(drvHdcFreeMsg).stubs()
        .will(invoke(DrvHdcFreeMsgStub));

    uint32_t length = 1024;
    char *data = (char *)IdeXmalloc(length);
    CommHandle handle = {OptType::COMM_HDC, (OptHandle)0x11223344, COMPONENT_TRACE, 36, nullptr};
    EXPECT_EQ(IDE_DAEMON_HDC_TIMEOUT, AdxRecvMsg(&handle, &data, &length, 25));

    IdeXfree(data);
    data = nullptr;
}

TEST_F(ADX_HDC_INTERFACE_UTEST, AdxGetAttrByCommHandle)
{
    int32_t value = 0;
    OptHandle session = (OptHandle)0x123456;
    AdxCommHandle handle = (AdxCommHandle)IdeXmalloc(sizeof(CommHandle));
    handle->type = OptType::COMM_HDC;
    handle->session = session;
    handle->comp = NR_COMPONENTS;
    handle->timeout = 0;
    handle->client = nullptr;
    EXPECT_EQ(0, AdxGetAttrByCommHandle(handle, HDC_SESSION_ATTR_VFID, &value));
    EXPECT_EQ(0, IdeGetDevIdBySession(handle, &value));
    EXPECT_EQ(0, IdeGetRunEnvBySession(handle, &value));
    EXPECT_EQ(0, IdeGetVfIdBySession(handle, &value));
    AdxDestroyCommHandle(handle);
    handle = nullptr;
}

TEST_F(ADX_HDC_INTERFACE_UTEST, AdxDevCommShortLink)
{
    AdxHdcServiceType type = HDC_SERVICE_TYPE_IDE_FILE_TRANS;
    std::string value = "value";
    AdxTlvReq req = (AdxTlvReq)IdeXmalloc(sizeof(TlvReq) + value.length());
    req->type = COMPONENT_HBM_DETECT;
    req->devId = 0;
    req->len = value.length();
    memcpy_s(req->value, value.length(), &value, value.length());
    static const uint16_t messageLen = 128;
    char message[messageLen] = {0};
    uint32_t timeout = 10;

    MOCKER(Adx::AdxMsgProto::SendMsgData).stubs().will(returnValue(IDE_DAEMON_OK));
    EXPECT_EQ(IDE_DAEMON_OK, AdxDevCommShortLink(type, req, nullptr, 0, timeout));

    HDC_CLIENT client = (HDC_CLIENT)0x12345678;
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    MOCKER(Adx::HdcClientCreate).stubs().will(returnValue(client));
    MOCKER(Adx::HdcSessionConnect)
        .stubs()
        .with(any(), any(), any(), outBoundP(&session))
        .will(returnValue(IDE_DAEMON_OK));
    MOCKER(Adx::HdcWrite).stubs().will(returnValue(IDE_DAEMON_OK));
    std::string str = "###[HDC_MSG]hdc_end_msg_used_by_framework###";
    MOCKER(Adx::AdxMsgProto::GetStringMsgData).stubs().with(any(), outBound(str)).will(returnValue(IDE_DAEMON_OK));
    MOCKER(strncpy_s).stubs().will(returnValue(IDE_DAEMON_OK));
    EXPECT_EQ(IDE_DAEMON_OK, AdxDevCommShortLink(type, req, message, messageLen, timeout));

    MOCKER(memcpy_s).stubs().will(returnValue(-1));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxDevCommShortLink(type, req, message, messageLen, timeout));

    req->type = NR_COMPONENTS;
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxDevCommShortLink(type, req, message, messageLen, timeout));

    req->len = -1;
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxDevCommShortLink(type, req, message, messageLen, timeout));

    EXPECT_EQ(IDE_DAEMON_ERROR, AdxDevCommShortLink(type, nullptr, message, messageLen, timeout));
    EXPECT_NE(nullptr, message);

    IDE_XFREE_AND_SET_NULL(req);
    GlobalMockObject::reset();
}

TEST_F(ADX_HDC_INTERFACE_UTEST, AdxDevCommShortLinkFail)
{
    AdxHdcServiceType type = HDC_SERVICE_TYPE_IDE_FILE_TRANS;
    std::string value = "value";
    AdxTlvReq req = (AdxTlvReq)malloc(sizeof(TlvReq) + value.length());
    req->type = COMPONENT_HBM_DETECT;
    req->devId = 0;
    req->len = value.length();
    memcpy_s(req->value, value.length(), &value, value.length());
    static const uint16_t messageLen = 128;
    char message[messageLen] = {0};
    uint32_t timeout = 10;

    MOCKER(Adx::AdxMsgProto::SendMsgData).stubs().will(returnValue(IDE_DAEMON_OK));
    EXPECT_EQ(IDE_DAEMON_OK, AdxDevCommShortLink(type, req, nullptr, 0, timeout));

    MOCKER(IdeXmalloc).stubs().will(returnValue((void*)nullptr));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxDevCommShortLink(type, req, nullptr, 0, timeout));

    HDC_CLIENT client = (HDC_CLIENT)0x12345678;
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    MOCKER(Adx::HdcClientCreate).stubs().will(returnValue(client));
    MOCKER(Adx::HdcSessionConnect)
        .stubs()
        .with(any(), any(), any(), outBoundP(&session))
        .will(returnValue(IDE_DAEMON_OK));
    MOCKER(Adx::HdcWrite).stubs().will(returnValue(IDE_DAEMON_OK));
    std::string str = "###[HDC_MSG]hdc_end_msg_used_by_framework###";
    MOCKER(Adx::AdxMsgProto::GetStringMsgData).stubs().with(any(), outBound(str)).will(returnValue(IDE_DAEMON_OK));
    MOCKER(strncpy_s).stubs().will(returnValue(-1));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxDevCommShortLink(type, nullptr, message, messageLen, timeout));

    IDE_XFREE_AND_SET_NULL(req);
    GlobalMockObject::reset();
}