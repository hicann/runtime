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
#include <cstring>
#include "mockcpp/mockcpp.hpp"
#define protected public
#define private public

#include "adx_log.h"
#include "component/adx_server_manager.h"
#include "epoll/adx_hdc_epoll.h"
#include "epoll/adx_hdc_epoll.h"
#include "commopts/hdc_comm_opt.h"
#include "adx_dump_receive.h"
#include "mmpa_api.h"
#include "file_utils.h"
#include "ide_daemon_stub.h"
#include "adx_msg_proto.h"
#include "adx_msg.h"
#include "memory_utils.h"
#include "adx_dump_record.h"
#include "adx_datadump_callback.h"

using namespace Adx;

class ADX_DUMP_RECEIVE_TEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() { GlobalMockObject::verify(); }

    static SharedPtr<MsgProto> CreateMsgProto(
        MsgType msgType, MsgStatus status, uint32_t reqType = 1, uint32_t devId = 0)
    {
        MsgProto* proto = (MsgProto*)IdeXmalloc(sizeof(MsgProto));
        (void)memset_s(proto, sizeof(MsgProto), 0, sizeof(MsgProto));
        proto->msgType = msgType;
        proto->status = status;
        proto->reqType = reqType;
        proto->devId = devId;
        return SharedPtr<MsgProto>(proto, IdeXfree);
    }

    static CommHandle CreateHdcHandle()
    {
        CommHandle handle;
        handle.type = OptType::COMM_HDC;
        return handle;
    }
};

TEST_F(ADX_DUMP_RECEIVE_TEST, Init)
{
    Adx::AdxDumpReceive adxDumpReceive;
    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.Init());
}

TEST_F(ADX_DUMP_RECEIVE_TEST, UnInit)
{
    Adx::AdxDumpReceive adxDumpReceive;
    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.UnInit());
}

static int HdcReadCtrlDataInStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    MsgProto* msg = (MsgProto*)IdeXmalloc(sizeof(MsgProto));
    (void)memset_s(msg, sizeof(MsgProto), 0, sizeof(MsgProto));
    msg->msgType = MsgType::MSG_CTRL;
    msg->status = MsgStatus::MSG_STATUS_DATA_IN;
    *recvBuf = msg;
    *recvLen = sizeof(MsgProto);
    return IDE_DAEMON_OK;
}

static int HdcReadCtrlEndStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    MsgProto* msg = (MsgProto*)IdeXmalloc(sizeof(MsgProto));
    (void)memset_s(msg, sizeof(MsgProto), 0, sizeof(MsgProto));
    msg->msgType = MsgType::MSG_CTRL;
    msg->status = MsgStatus::MSG_STATUS_DATA_END;
    *recvBuf = msg;
    *recvLen = sizeof(MsgProto);
    return IDE_DAEMON_OK;
}

TEST_F(ADX_DUMP_RECEIVE_TEST, Process_InvalidMsgType)
{
    AdxDumpReceive adxDumpReceive;
    CommHandle handle = CreateHdcHandle();
    SharedPtr<MsgProto> protoPtrs = CreateMsgProto(MsgType::MSG_DATA, MsgStatus::MSG_STATUS_HAND_SHAKE);

    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.Init());
    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.Process(handle, protoPtrs));
    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.UnInit());
}

TEST_F(ADX_DUMP_RECEIVE_TEST, Process_InvalidStatus)
{
    AdxDumpReceive adxDumpReceive;
    CommHandle handle = CreateHdcHandle();
    SharedPtr<MsgProto> protoPtrs = CreateMsgProto(MsgType::MSG_CTRL, MsgStatus::MSG_STATUS_NONE_ERROR);

    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.Init());
    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.Process(handle, protoPtrs));
    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.UnInit());
}

TEST_F(ADX_DUMP_RECEIVE_TEST, Process_SendResponseFailed)
{
    AdxDumpReceive adxDumpReceive;
    CommHandle handle = CreateHdcHandle();
    SharedPtr<MsgProto> protoPtrs = CreateMsgProto(MsgType::MSG_CTRL, MsgStatus::MSG_STATUS_HAND_SHAKE);

    MOCKER(AdxMsgProto::SendResponse).stubs().will(returnValue(IDE_DAEMON_UNKNOW_ERROR));

    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.Init());
    EXPECT_EQ(IDE_DAEMON_UNKNOW_ERROR, adxDumpReceive.Process(handle, protoPtrs));
    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.UnInit());
}

TEST_F(ADX_DUMP_RECEIVE_TEST, Process_HandshakeSuccessAndReceive)
{
    AdxDumpReceive adxDumpReceive;
    CommHandle handle = CreateHdcHandle();
    SharedPtr<MsgProto> protoPtrs = CreateMsgProto(MsgType::MSG_CTRL, MsgStatus::MSG_STATUS_HAND_SHAKE);

    MOCKER(AdxMsgProto::SendResponse).stubs().will(returnValue(IDE_DAEMON_NONE_ERROR));
    MOCKER(HdcRead).stubs().will(invoke(HdcReadCtrlEndStub));

    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.Init());
    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.Process(handle, protoPtrs));
    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.UnInit());
}

static int HdcReadErrorStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen) { return IDE_DAEMON_ERROR; }

TEST_F(ADX_DUMP_RECEIVE_TEST, Receive_ReadError)
{
    AdxDumpReceive adxDumpReceive;
    adxDumpReceive.init_ = true;
    CommHandle handle = CreateHdcHandle();
    SharedPtr<MsgProto> protoPtrs = CreateMsgProto(MsgType::MSG_CTRL, MsgStatus::MSG_STATUS_HAND_SHAKE);

    MOCKER(AdxMsgProto::SendResponse).stubs().will(returnValue(IDE_DAEMON_NONE_ERROR));
    MOCKER(HdcRead).stubs().will(invoke(HdcReadErrorStub));

    EXPECT_EQ(IDE_DAEMON_ERROR, adxDumpReceive.Process(handle, protoPtrs));
}

static int HdcReadMsgNullStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    *recvBuf = nullptr;
    *recvLen = 0;
    return IDE_DAEMON_OK;
}

TEST_F(ADX_DUMP_RECEIVE_TEST, Receive_MsgNull)
{
    AdxDumpReceive adxDumpReceive;
    adxDumpReceive.init_ = true;
    CommHandle handle = CreateHdcHandle();
    SharedPtr<MsgProto> protoPtrs = CreateMsgProto(MsgType::MSG_CTRL, MsgStatus::MSG_STATUS_HAND_SHAKE);

    MOCKER(AdxMsgProto::SendResponse).stubs().will(returnValue(IDE_DAEMON_NONE_ERROR));
    MOCKER(HdcRead).stubs().will(invoke(HdcReadMsgNullStub));

    EXPECT_EQ(IDE_DAEMON_ERROR, adxDumpReceive.Process(handle, protoPtrs));
}

static int HdcReadLenTooSmallStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    MsgProto* msg = (MsgProto*)IdeXmalloc(sizeof(MsgProto));
    (void)memset_s(msg, sizeof(MsgProto), 0, sizeof(MsgProto));
    *recvBuf = msg;
    *recvLen = sizeof(MsgProto) - 1;
    return IDE_DAEMON_OK;
}

TEST_F(ADX_DUMP_RECEIVE_TEST, Receive_LenTooSmallForProtoHeader)
{
    AdxDumpReceive adxDumpReceive;
    adxDumpReceive.init_ = true;
    CommHandle handle = CreateHdcHandle();
    SharedPtr<MsgProto> protoPtrs = CreateMsgProto(MsgType::MSG_CTRL, MsgStatus::MSG_STATUS_HAND_SHAKE);

    MOCKER(AdxMsgProto::SendResponse).stubs().will(returnValue(IDE_DAEMON_NONE_ERROR));
    MOCKER(HdcRead).stubs().will(invoke(HdcReadLenTooSmallStub));

    EXPECT_EQ(IDE_DAEMON_ERROR, adxDumpReceive.Process(handle, protoPtrs));
}

static int HdcReadSliceLenMismatchStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    uint32_t protoHeaderLen = sizeof(MsgProto);
    uint32_t chunkHeaderLen = sizeof(DumpChunk);
    uint32_t dataLen = 100;
    uint32_t totalSize = protoHeaderLen + chunkHeaderLen + dataLen;
    MsgProto* msg = (MsgProto*)IdeXmalloc(totalSize);
    (void)memset_s(msg, totalSize, 0, totalSize);
    msg->msgType = MsgType::MSG_DATA;
    msg->sliceLen = dataLen + 10;
    DumpChunk* chunk = reinterpret_cast<DumpChunk*>(msg->data);
    chunk->bufLen = dataLen;
    *recvBuf = msg;
    *recvLen = totalSize;
    return IDE_DAEMON_OK;
}

TEST_F(ADX_DUMP_RECEIVE_TEST, Receive_SliceLenMismatch)
{
    AdxDumpReceive adxDumpReceive;
    adxDumpReceive.init_ = true;
    CommHandle handle = CreateHdcHandle();
    SharedPtr<MsgProto> protoPtrs = CreateMsgProto(MsgType::MSG_CTRL, MsgStatus::MSG_STATUS_HAND_SHAKE);

    MOCKER(AdxMsgProto::SendResponse).stubs().will(returnValue(IDE_DAEMON_NONE_ERROR));
    MOCKER(HdcRead).stubs().will(invoke(HdcReadSliceLenMismatchStub));

    EXPECT_EQ(IDE_DAEMON_ERROR, adxDumpReceive.Process(handle, protoPtrs));
}

static int HdcReadDataLenTooSmallStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    uint32_t protoHeaderLen = sizeof(MsgProto);
    uint32_t chunkHeaderLen = sizeof(DumpChunk);
    uint32_t totalSize = protoHeaderLen + chunkHeaderLen - 1;
    MsgProto* msg = (MsgProto*)IdeXmalloc(protoHeaderLen + chunkHeaderLen);
    (void)memset_s(msg, protoHeaderLen + chunkHeaderLen, 0, protoHeaderLen + chunkHeaderLen);
    msg->msgType = MsgType::MSG_DATA;
    msg->sliceLen = chunkHeaderLen - 1;
    *recvBuf = msg;
    *recvLen = totalSize;
    return IDE_DAEMON_OK;
}

TEST_F(ADX_DUMP_RECEIVE_TEST, Receive_ProtoDataLenTooSmallForChunkHeader)
{
    AdxDumpReceive adxDumpReceive;
    adxDumpReceive.init_ = true;
    CommHandle handle = CreateHdcHandle();
    SharedPtr<MsgProto> protoPtrs = CreateMsgProto(MsgType::MSG_CTRL, MsgStatus::MSG_STATUS_HAND_SHAKE);

    MOCKER(AdxMsgProto::SendResponse).stubs().will(returnValue(IDE_DAEMON_NONE_ERROR));
    MOCKER(HdcRead).stubs().will(invoke(HdcReadDataLenTooSmallStub));

    EXPECT_EQ(IDE_DAEMON_ERROR, adxDumpReceive.Process(handle, protoPtrs));
}

static int HdcReadBufLenExceedsStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    uint32_t protoHeaderLen = sizeof(MsgProto);
    uint32_t chunkHeaderLen = sizeof(DumpChunk);
    uint32_t dataLen = 50;
    uint32_t totalSize = protoHeaderLen + chunkHeaderLen + dataLen;
    MsgProto* msg = (MsgProto*)IdeXmalloc(totalSize);
    (void)memset_s(msg, totalSize, 0, totalSize);
    msg->msgType = MsgType::MSG_DATA;
    msg->sliceLen = chunkHeaderLen + dataLen;
    DumpChunk* chunk = reinterpret_cast<DumpChunk*>(msg->data);
    chunk->bufLen = dataLen + 100;
    *recvBuf = msg;
    *recvLen = totalSize;
    return IDE_DAEMON_OK;
}

TEST_F(ADX_DUMP_RECEIVE_TEST, Receive_BufLenExceedsChunkDataLen)
{
    AdxDumpReceive adxDumpReceive;
    adxDumpReceive.init_ = true;
    CommHandle handle = CreateHdcHandle();
    SharedPtr<MsgProto> protoPtrs = CreateMsgProto(MsgType::MSG_CTRL, MsgStatus::MSG_STATUS_HAND_SHAKE);

    MOCKER(AdxMsgProto::SendResponse).stubs().will(returnValue(IDE_DAEMON_NONE_ERROR));
    MOCKER(HdcRead).stubs().will(invoke(HdcReadBufLenExceedsStub));

    EXPECT_EQ(IDE_DAEMON_ERROR, adxDumpReceive.Process(handle, protoPtrs));
}

static int HdcReadValidDataStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    uint32_t protoHeaderLen = sizeof(MsgProto);
    uint32_t chunkHeaderLen = sizeof(DumpChunk);
    uint32_t dataLen = 100;
    uint32_t totalSize = protoHeaderLen + chunkHeaderLen + dataLen;
    MsgProto* msg = (MsgProto*)IdeXmalloc(totalSize);
    (void)memset_s(msg, totalSize, 0, totalSize);
    msg->msgType = MsgType::MSG_DATA;
    msg->sliceLen = chunkHeaderLen + dataLen;
    DumpChunk* chunk = reinterpret_cast<DumpChunk*>(msg->data);
    chunk->bufLen = dataLen;
    chunk->isLastChunk = 1;
    chunk->offset = 0;
    chunk->flag = 0;
    strcpy_s(chunk->fileName, MAX_FILE_PATH_LENGTH, "test_dump.bin");
    *recvBuf = msg;
    *recvLen = totalSize;
    return IDE_DAEMON_OK;
}

TEST_F(ADX_DUMP_RECEIVE_TEST, Receive_ValidData)
{
    AdxDumpReceive adxDumpReceive;
    adxDumpReceive.init_ = true;
    CommHandle handle = CreateHdcHandle();
    SharedPtr<MsgProto> protoPtrs = CreateMsgProto(MsgType::MSG_CTRL, MsgStatus::MSG_STATUS_HAND_SHAKE);

    MOCKER(AdxMsgProto::SendResponse).stubs().will(returnValue(IDE_DAEMON_NONE_ERROR));
    MOCKER(HdcRead)
        .stubs()
        .will(invoke(HdcReadCtrlDataInStub))
        .then(invoke(HdcReadCtrlDataInStub))
        .then(invoke(HdcReadValidDataStub))
        .then(invoke(HdcReadCtrlEndStub));

    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.Process(handle, protoPtrs));
}

TEST_F(ADX_DUMP_RECEIVE_TEST, Receive_ValidDataSendResponseFail)
{
    AdxDumpReceive adxDumpReceive;
    adxDumpReceive.init_ = true;
    CommHandle handle = CreateHdcHandle();
    SharedPtr<MsgProto> protoPtrs = CreateMsgProto(MsgType::MSG_CTRL, MsgStatus::MSG_STATUS_HAND_SHAKE);

    MOCKER(AdxMsgProto::SendResponse)
        .stubs()
        .will(returnValue(IDE_DAEMON_NONE_ERROR))
        .then(returnValue(IDE_DAEMON_UNKNOW_ERROR));
    MOCKER(HdcRead).stubs().will(invoke(HdcReadValidDataStub));

    EXPECT_EQ(IDE_DAEMON_ERROR, adxDumpReceive.Process(handle, protoPtrs));
}

TEST_F(ADX_DUMP_RECEIVE_TEST, Receive_QueueFullAllResponse)
{
    AdxDumpReceive adxDumpReceive;
    adxDumpReceive.init_ = true;
    CommHandle handle = CreateHdcHandle();
    SharedPtr<MsgProto> protoPtrs = CreateMsgProto(MsgType::MSG_CTRL, MsgStatus::MSG_STATUS_HAND_SHAKE);

    MOCKER(&AdxDumpRecord::RecordDumpDataToQueue).stubs().will(returnValue(false));
    MOCKER(AdxMsgProto::SendResponse).stubs().will(returnValue(IDE_DAEMON_NONE_ERROR));
    MOCKER(HdcRead)
        .stubs()
        .will(invoke(HdcReadValidDataStub))
        .then(invoke(HdcReadValidDataStub))
        .then(invoke(HdcReadCtrlEndStub));

    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.Process(handle, protoPtrs));
}

TEST_F(ADX_DUMP_RECEIVE_TEST, Receive_NotInited)
{
    AdxDumpReceive adxDumpReceive;
    adxDumpReceive.init_ = false;
    CommHandle handle = CreateHdcHandle();
    SharedPtr<MsgProto> protoPtrs = CreateMsgProto(MsgType::MSG_CTRL, MsgStatus::MSG_STATUS_HAND_SHAKE);

    MOCKER(AdxMsgProto::SendResponse).stubs().will(returnValue(IDE_DAEMON_NONE_ERROR));
    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.Process(handle, protoPtrs));
}

TEST_F(ADX_DUMP_RECEIVE_TEST, Terminate)
{
    AdxDumpReceive adxDumpReceive;
    adxDumpReceive.init_ = true;
    CommHandle handle = CreateHdcHandle();
    adxDumpReceive.StoreSession(0, &handle);
    adxDumpReceive.Terminate();
    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.Terminate());
}