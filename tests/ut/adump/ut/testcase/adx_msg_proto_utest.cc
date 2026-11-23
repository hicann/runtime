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

#include "ide_daemon_stub.h"
#include "mmpa_api.h"
#include "adx_msg_proto.h"
#include "adx_msg_proto_utest.h"
#include "ide_hdc_stub.h"
#include "mmpa_stub.h"
#include "adx_comm_opt_manager.h"
#include "commopts/hdc_comm_opt.h"
#include "memory_utils.h"

using namespace Adx;
class ADX_MSG_PROTO_UTEST : public testing::Test {
protected:
    virtual void SetUp()
    {
        // register the real hdc commopt so the mocked HdcReadTimeout is reachable via the manager
        AdxCommOptManager::Instance().commOptMap_.clear();
        std::unique_ptr<AdxCommOpt> opt(new HdcCommOpt());
        ASSERT_EQ(true, AdxCommOptManager::Instance().CommOptsRegister(opt));
    }
    virtual void TearDown()
    {
        // keep COMM_HDC registered after clear: the AdxDumpHdcHelper singleton skips re-register once initialized,
        // so later suites (e.g. ADX_DATA_DUMP_UTEST) rely on the map still holding a valid opt
        AdxCommOptManager::Instance().commOptMap_.clear();
        std::unique_ptr<AdxCommOpt> opt(new HdcCommOpt());
        (void)AdxCommOptManager::Instance().CommOptsRegister(opt);
        GlobalMockObject::verify();
    }

    static CommHandle CreateHdcHandle()
    {
        CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_HDC);
        handle.session = 0x12345678; // a non-invalid session accepted by HdcCommOpt::Read
        return handle;
    }
};

TEST_F(ADX_MSG_PROTO_UTEST, SendEventFile)
{
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_LOCAL);

    MOCKER(mmLseek).stubs().will(returnValue((long)1000));

    MOCKER(mmRead).stubs().will(returnValue((long)-1)).then(returnValue((long)-1)).then(returnValue((long)1000));

    MOCKER(mmGetErrorCode).stubs().will(returnValue(EIO)).then(returnValue(0));

    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, AdxMsgProto::SendEventFile(handle, IDE_FILE_GETD_REQ, 0, 1));
    EXPECT_EQ(IDE_DAEMON_UNKNOW_ERROR, AdxMsgProto::SendEventFile(handle, IDE_FILE_GETD_REQ, 0, 1));
    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, AdxMsgProto::SendEventFile(handle, IDE_FILE_GETD_REQ, 0, 1));
}

static int32_t HdcReadShortFrameStub(HDC_SESSION session, uint32_t timeout, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    // the actually received length is less than the MsgProto header
    MsgProto* msg = (MsgProto*)IdeXmalloc(sizeof(MsgProto));
    msg->msgType = MsgType::MSG_DATA;
    msg->sliceLen = 1;
    msg->totalLen = 1;
    msg->offset = 0;
    *recvLen = static_cast<int32_t>(sizeof(MsgProto)) - 1;
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

TEST_F(ADX_MSG_PROTO_UTEST, RecvFileShortFrame)
{
    CommHandle handle = CreateHdcHandle();

    MOCKER(HdcReadTimeout).stubs().will(invoke(HdcReadShortFrameStub));

    EXPECT_EQ(IDE_DAEMON_UNKNOW_ERROR, AdxMsgProto::RecvFile(handle, 1));
}

static int32_t HdcReadSliceLenMismatchStub(
    HDC_SESSION session, uint32_t timeout, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    // sliceLen declared by the peer exceeds the actually received payload
    const char* srcFile = "adx_server_manager";
    MsgProto* msg = AdxMsgProto::CreateMsgPacket(IDE_FILE_GETD_REQ, 0, srcFile, strlen(srcFile) + 1);
    *recvLen = sizeof(MsgProto) + strlen(srcFile) + 1;
    // 512000 equals the recv-side slice cap, far beyond the actual payload, simulating the reported attack
    msg->sliceLen = 512000;
    msg->totalLen = 512000;
    msg->offset = 0;
    msg->msgType = MsgType::MSG_DATA;
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

TEST_F(ADX_MSG_PROTO_UTEST, RecvFileSliceLenMismatch)
{
    CommHandle handle = CreateHdcHandle();

    MOCKER(HdcReadTimeout).stubs().will(invoke(HdcReadSliceLenMismatchStub));
    // mmWrite must not be reached when sliceLen is inconsistent with the actually received length
    MOCKER(mmWrite).expects(never()).will(returnValue((mmSsize_t)1));

    EXPECT_EQ(IDE_DAEMON_UNKNOW_ERROR, AdxMsgProto::RecvFile(handle, 1));
}

static int32_t HdcReadFirstSliceOfTwoStub(HDC_SESSION session, uint32_t timeout, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    // the first slice of a two-slice file, totalLen exceeds this slice so receiving continues
    const char* srcFile = "adx_server_manager";
    MsgProto* msg = AdxMsgProto::CreateMsgPacket(IDE_FILE_GETD_REQ, 0, srcFile, strlen(srcFile) + 1);
    *recvLen = sizeof(MsgProto) + strlen(srcFile) + 1;
    uint32_t sliceLen = strlen(srcFile) + 1;
    msg->offset = 0;
    msg->sliceLen = sliceLen;
    msg->totalLen = 2 * sliceLen;
    msg->msgType = MsgType::MSG_DATA;
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

static int32_t HdcReadSecondSliceInvalidOffsetStub(
    HDC_SESSION session, uint32_t timeout, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    // the second slice declares a wrong offset, not matching the local received progress
    const char* srcFile = "adx_server_manager";
    MsgProto* msg = AdxMsgProto::CreateMsgPacket(IDE_FILE_GETD_REQ, 0, srcFile, strlen(srcFile) + 1);
    *recvLen = sizeof(MsgProto) + strlen(srcFile) + 1;
    uint32_t sliceLen = strlen(srcFile) + 1;
    msg->offset = 0; // the received progress is already sliceLen here
    msg->sliceLen = sliceLen;
    msg->totalLen = 2 * sliceLen;
    msg->msgType = MsgType::MSG_DATA;
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

TEST_F(ADX_MSG_PROTO_UTEST, RecvFileSecondSliceOffsetMismatch)
{
    CommHandle handle = CreateHdcHandle();

    // the first slice is accepted (mmWrite reached), the second slice declares a wrong offset;
    // mockcpp's invoke() stub always reports isCompleted, so the first will() is skipped on the first
    // call and must be registered twice (same as Receive_ValidData in adx_dump_receive_utest.cc)
    MOCKER(HdcReadTimeout)
        .stubs()
        .will(invoke(HdcReadFirstSliceOfTwoStub))
        .then(invoke(HdcReadFirstSliceOfTwoStub))
        .then(invoke(HdcReadSecondSliceInvalidOffsetStub));
    // mmWrite writes the whole slice at once, only the valid first slice hits the disk
    MOCKER(mmWrite).expects(exactly(1)).will(returnValue((mmSsize_t)strlen("adx_server_manager") + 1));

    EXPECT_EQ(IDE_DAEMON_UNKNOW_ERROR, AdxMsgProto::RecvFile(handle, 1));
}

static int32_t HdcReadSecondSliceTotalLenChangedStub(
    HDC_SESSION session, uint32_t timeout, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    // the second slice rewrites totalLen to shrink the declared file size, totalLen must stay fixed;
    // the package itself is well-formed (offset keeps pace, no payload), only totalLen is tampered
    const char* srcFile = "adx_server_manager";
    uint32_t sliceLen = strlen(srcFile) + 1;
    MsgProto* msg = (MsgProto*)IdeXmalloc(sizeof(MsgProto));
    msg->offset = sliceLen;   // offset keeps pace with the local received progress
    msg->sliceLen = 0;
    msg->totalLen = sliceLen; // totalLen is rewritten to receivedLen to fake an early completion
    msg->msgType = MsgType::MSG_DATA;
    *recvLen = sizeof(MsgProto);
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

TEST_F(ADX_MSG_PROTO_UTEST, RecvFileSecondSliceTotalLenChanged)
{
    CommHandle handle = CreateHdcHandle();

    // the first slice declares totalLen = 2 * sliceLen, the second slice rewrites totalLen = sliceLen
    MOCKER(HdcReadTimeout)
        .stubs()
        .will(invoke(HdcReadFirstSliceOfTwoStub))
        .then(invoke(HdcReadFirstSliceOfTwoStub))
        .then(invoke(HdcReadSecondSliceTotalLenChangedStub));
    // mmWrite writes the whole slice at once, only the first slice hits the disk
    MOCKER(mmWrite).expects(exactly(1)).will(returnValue((mmSsize_t)strlen("adx_server_manager") + 1));

    EXPECT_EQ(IDE_DAEMON_UNKNOW_ERROR, AdxMsgProto::RecvFile(handle, 1));
}

static int32_t HdcReadZeroSliceNotDoneStub(
    HDC_SESSION session, uint32_t timeout, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    // a well-formed package carrying no payload while the file is not complete: receiving must not stall on it
    MsgProto* msg = (MsgProto*)IdeXmalloc(sizeof(MsgProto));
    msg->msgType = MsgType::MSG_DATA;
    msg->sliceLen = 0;
    msg->totalLen = 100;
    msg->offset = 0;
    *recvLen = sizeof(MsgProto);
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

TEST_F(ADX_MSG_PROTO_UTEST, RecvFileZeroSliceNotDone)
{
    CommHandle handle = CreateHdcHandle();

    MOCKER(HdcReadTimeout).stubs().will(invoke(HdcReadZeroSliceNotDoneStub));
    // mmWrite must not be reached when the file is not complete and the slice carries no payload
    MOCKER(mmWrite).expects(never()).will(returnValue((mmSsize_t)1));

    EXPECT_EQ(IDE_DAEMON_UNKNOW_ERROR, AdxMsgProto::RecvFile(handle, 1));
}

static int32_t HdcReadEmptyFileStub(HDC_SESSION session, uint32_t timeout, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    // legal empty file: totalLen == 0 and sliceLen == 0, receiving ends immediately
    MsgProto* msg = (MsgProto*)IdeXmalloc(sizeof(MsgProto));
    msg->msgType = MsgType::MSG_DATA;
    msg->sliceLen = 0;
    msg->totalLen = 0;
    msg->offset = 0;
    *recvLen = sizeof(MsgProto);
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

TEST_F(ADX_MSG_PROTO_UTEST, RecvFileEmptyFile)
{
    CommHandle handle = CreateHdcHandle();

    MOCKER(HdcReadTimeout).stubs().will(invoke(HdcReadEmptyFileStub));
    MOCKER(AdxMsgProto::SendResponse).stubs().will(returnValue(IDE_DAEMON_NONE_ERROR));

    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, AdxMsgProto::RecvFile(handle, 1));
}

static int32_t HdcReadCtrlEndStub(HDC_SESSION session, uint32_t timeout, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    MsgProto* msg = (MsgProto*)IdeXmalloc(sizeof(MsgProto));
    msg->msgType = MsgType::MSG_CTRL;
    msg->status = MsgStatus::MSG_STATUS_DATA_END;
    *recvLen = sizeof(MsgProto);
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

TEST_F(ADX_MSG_PROTO_UTEST, RecvFileCtrlEnd)
{
    CommHandle handle = CreateHdcHandle();

    MOCKER(HdcReadTimeout).stubs().will(invoke(HdcReadCtrlEndStub));

    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, AdxMsgProto::RecvFile(handle, 1));
}

static int32_t HdcReadTwoSliceStub(HDC_SESSION session, uint32_t timeout, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    // a two-slice file: the first slice is fully written, the second slice only half written
    const char* srcFile = "adx_server_manager";
    uint32_t sliceLen = strlen(srcFile) + 1;
    static uint32_t callCount = 0;
    MsgProto* msg = AdxMsgProto::CreateMsgPacket(IDE_FILE_GETD_REQ, 0, srcFile, sliceLen);
    callCount++;
    msg->sliceLen = sliceLen;
    msg->totalLen = 2 * sliceLen;
    msg->offset = (callCount == 1) ? 0 : sliceLen;
    msg->msgType = MsgType::MSG_DATA;
    *recvLen = sizeof(MsgProto) + sliceLen;
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

static mmSsize_t MmWriteShortWriteStub(INT32 fd, VOID* mmBuf, UINT32 mmCount)
{
    // the first call writes the whole slice, the second call writes only 1 byte (short write)
    static mmSsize_t callCount = 0;
    callCount++;
    if (callCount == 1) {
        return static_cast<mmSsize_t>(mmCount);
    }
    return 1;
}

TEST_F(ADX_MSG_PROTO_UTEST, RecvFileShortWriteFail)
{
    CommHandle handle = CreateHdcHandle();

    MOCKER(HdcReadTimeout).stubs().will(invoke(HdcReadTwoSliceStub));
    // mmWrite is retried on short writes, 1 full write + 1 short write + following retries all fail
    MOCKER(mmWrite).stubs().will(invoke(MmWriteShortWriteStub));

    // RecvFile returns CHANNEL_ERROR because the loop keeps reading until the file completes, but
    // the two-slice stub keeps the second slice arriving forever after the write path fails early;
    // IDE_DAEMON_CHANNEL_ERROR(10) is acceptable: the short write never lands as a success
    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, AdxMsgProto::RecvFile(handle, 1));
}

TEST_F(ADX_MSG_PROTO_UTEST, SendFile)
{
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_LOCAL);

    MOCKER(mmLseek).stubs().will(returnValue((long)1000));

    MOCKER(mmRead).stubs().will(returnValue((long)1000));

    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, AdxMsgProto::SendFile(handle, IDE_FILE_GETD_REQ, 0, 1));
}