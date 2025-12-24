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

#include <stdio.h>
#include "log_get_file.h"
#include "log_file_utils.h"
#include "log_dsmi_drv.h"
#include "adx_msg.h"
#include "adx_msg_proto.h"
#include "adcore_api.h"
#include "log_process_util.h"
#include "log_drv.h"

using namespace Adx;

class ADX_GET_FILE_UTEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

static bool GetDirFileListStub(const std::string &path, std::vector<std::string> &list, const FileFilterFn fileter,
    const std::string &fileNamePrefix, int32_t recursiveDepth)
{
    list.push_back("/var/log/test1.111");
    list.push_back("/var/log/test2");
    list.push_back("/var/log/test3");
    return true;
}

TEST_F(ADX_GET_FILE_UTEST, TransferFile)
{
    CommHandle handle{OptType::COMM_HDC, 1};
    std::shared_ptr<Adx::LogGetFile> getFile = nullptr;
    getFile = std::make_shared<Adx::LogGetFile>();

    MOCKER(Adx::LogFileUtils::CopyFileAndRename)
    .stubs()
    .will(returnValue(IDE_DAEMON_UNKNOW_ERROR))
    .then(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(AdxSendFileByHandle)
    .stubs()
    .will(returnValue(-1))
    .then(returnValue(0));

    MOCKER(remove)
    .stubs()
    .will(returnValue(0));

    EXPECT_EQ(IDE_DAEMON_ERROR, getFile->TransferFile(handle, "dvpp", "/home/HwHiAiUser/ide_daemon/module_info", 3));
    EXPECT_EQ(IDE_DAEMON_ERROR, getFile->TransferFile(handle, "message", "/var/log/npu/hisi_logs/testlog", 3));
    EXPECT_EQ(IDE_DAEMON_OK, getFile->TransferFile(handle, "event_sched", "/var/log/npu/hisi_logs/testlog", 3));
    EXPECT_EQ(IDE_DAEMON_ERROR, getFile->TransferFile(handle, "message", "/var/log/npu/hisixxx_logs/testlog", 3));
    EXPECT_EQ(IDE_DAEMON_OK, getFile->TransferFile(handle, "message", "/var/log/npu/hisi_logs/testlog", 3));
    EXPECT_EQ(IDE_DAEMON_OK, getFile->TransferFile(handle, "event_sched", "/var/log/npu/hisi_logs/testlog", 3));
    EXPECT_EQ(IDE_DAEMON_ERROR, getFile->TransferFile(handle, "dvpp", "/home/HwHiAiUser/ide_daemon/module_info", 3));
    EXPECT_EQ(IDE_DAEMON_OK, getFile->TransferFile(handle, "dvpp", "/home/HwHiAiUser/ide_daemon/module_info/3", 3));
}

TEST_F(ADX_GET_FILE_UTEST, GetFileList)
{
    std::shared_ptr<Adx::LogGetFile> getFile = nullptr;
    getFile = std::make_shared<Adx::LogGetFile>();

    std::string logType = "dvpp";
    std::vector<std::string> list;
    int32_t pid = 12345;

    MOCKER_CPP(&Adx::LogGetFile::ExportModuleInfo)
    .stubs()
    .will(returnValue(IDE_DAEMON_ERROR))
    .then(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_ERROR, getFile->GetFileList(logType, list, pid));

    MOCKER(LogFileUtils::IsDirExist)
    .stubs()
    .will(returnValue(false))
    .then(returnValue(true));

    EXPECT_EQ(IDE_DAEMON_OK, getFile->GetFileList(logType, list, pid));

    MOCKER(Adx::LogFileUtils::GetDirFileList)
    .stubs()
    .will(returnValue(false))
    .then(returnValue(true));

    EXPECT_EQ(IDE_DAEMON_ERROR, getFile->GetFileList(logType, list, pid));

    EXPECT_EQ(IDE_DAEMON_OK, getFile->GetFileList(logType, list, pid));

    GlobalMockObject::verify();
    logType = "event_sched";

    MOCKER(Adx::LogFileUtils::GetDirFileList)
    .stubs()
    .will(invoke(GetDirFileListStub));

    EXPECT_EQ(IDE_DAEMON_OK, getFile->GetFileList(logType, list, pid));

    GlobalMockObject::verify();
    logType = "test";

    EXPECT_EQ(IDE_DAEMON_ERROR, getFile->GetFileList(logType, list, pid));
}

TEST_F(ADX_GET_FILE_UTEST, CopyFileToUserDir)
{
    std::string messagesFilePath = "/home/test";
    CommHandle handle;
    std::shared_ptr<Adx::LogGetFile> getFile = nullptr;
    getFile = std::make_shared<Adx::LogGetFile>();
    int32_t pid = 12345;

    MOCKER(Adx::LogFileUtils::GetFileName)
    .stubs()
    .will(returnValue(IDE_DAEMON_UNKNOW_ERROR))
    .then(returnValue(IDE_DAEMON_OK));
    EXPECT_EQ(IDE_DAEMON_ERROR, getFile->CopyFileToUserDir(messagesFilePath, pid));

    MOCKER(AdxCreateProcess).stubs().will(returnValue(IDE_DAEMON_OK));
    MOCKER(AdxCreateProcess).stubs().will(returnValue(IDE_DAEMON_OK));
    MOCKER(AdxCreateProcess).stubs().will(returnValue(IDE_DAEMON_OK));

    MOCKER(Adx::LogFileUtils::IsFileExist)
    .stubs()
    .will(returnValue(false))
    .then(returnValue(true));

    EXPECT_EQ(IDE_DAEMON_ERROR, getFile->CopyFileToUserDir(messagesFilePath, pid));
    EXPECT_EQ(IDE_DAEMON_OK, getFile->CopyFileToUserDir(messagesFilePath, pid));
}

TEST_F(ADX_GET_FILE_UTEST, IsValidMessageFile)
{
    std::string messagesFilePath;
    CommHandle handle;
    std::shared_ptr<Adx::LogGetFile> getFile = nullptr;
    getFile = std::make_shared<Adx::LogGetFile>();

    messagesFilePath = "/var/test/messages";
    EXPECT_EQ(true, getFile->IsValidMessageFile(messagesFilePath));

    messagesFilePath = "/var/test/messages.abx";
    EXPECT_EQ(false, getFile->IsValidMessageFile(messagesFilePath));

    messagesFilePath = "/var/test/messages.4294967295";
    EXPECT_EQ(false, getFile->IsValidMessageFile(messagesFilePath));

    messagesFilePath = "/var/test/messages.111";
    EXPECT_EQ(false, getFile->IsValidMessageFile(messagesFilePath));
}

MsgProto *LogCreateDataMsg(char *data, uint32_t length)
{
    MsgProto *msg = nullptr;
    uint32_t mallocLen = length + sizeof(MsgProto);
    msg = reinterpret_cast<MsgProto *>(malloc(mallocLen));
    (void)memcpy_s(msg->data, length, data, length);
    msg->msgType = MsgType::MSG_DATA;
    msg->sliceLen = length;
    msg->totalLen = length;
    msg->headInfo = ADX_PROTO_MAGIC_VALUE;
    msg->headVer = ADX_PROTO_VERSION;
    msg->order = 0;
    return msg;
}

TEST_F(ADX_GET_FILE_UTEST, ProcessTest)
{
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    std::shared_ptr<Adx::LogGetFile> getFile = nullptr;
    getFile = std::make_shared<Adx::LogGetFile>();

    char msgData[8] = {'m','e','s','s','a','g','e', '\0'};
    struct MsgProto *msg = LogCreateDataMsg(msgData, 8);
    std::shared_ptr<MsgProto> proto(msg, free);
    proto->msgType = MsgType::MSG_DATA;
    int32_t runEnv = 1;

    MOCKER(LogIdeGetRunEnvBySession)
    .stubs()
    .with(any(), outBoundP(&runEnv))
    .will(returnValue(IDE_DAEMON_OK));


    MOCKER(LogIdeGetPidBySession)
    .stubs()
    .will(returnValue(IDE_DAEMON_ERROR))
    .then(returnValue(IDE_DAEMON_OK));

    MOCKER(Adx::LogFileUtils::GetDirFileList)
    .stubs()
    .will(invoke(GetDirFileListStub));

    MOCKER(Adx::LogFileUtils::GetFileName)
    .stubs()
    .will(returnValue(IDE_DAEMON_INVALID_PATH_ERROR))
    .then(returnValue(IDE_DAEMON_INVALID_PATH_ERROR));

    MOCKER(remove)
    .stubs()
    .will(returnValue(0));

    MOCKER(AdxSendMsgByHandle)
    .stubs()
    .will(returnValue(IDE_DAEMON_OK));
    EXPECT_EQ(IDE_DAEMON_ERROR, getFile->Process(handle, proto));
    EXPECT_EQ(IDE_DAEMON_OK, getFile->Process(handle, proto));
}

TEST_F(ADX_GET_FILE_UTEST, ProcessTestRemoveTmpDir)
{
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    std::shared_ptr<Adx::LogGetFile> getFile = std::make_shared<Adx::LogGetFile>();
    struct MsgProto *msg = LogCreateDataMsg("hal", 4);
    std::shared_ptr<MsgProto> proto(msg, free);
    proto->msgType = MsgType::MSG_DATA;

    int32_t runEnv = 1;
    MOCKER(LogIdeGetRunEnvBySession)
        .stubs()
        .with(any(), outBoundP(&runEnv))
        .will(returnValue(IDE_DAEMON_OK));
    MOCKER(LogIdeGetPidBySession).stubs().will(returnValue(IDE_DAEMON_OK));
    MOCKER(AdxSendMsgByHandle).stubs().will(returnValue(IDE_DAEMON_OK));
    MOCKER(AdxCreateProcess).stubs().will(returnValue(IDE_DAEMON_OK));
    MOCKER(Adx::LogFileUtils::GetDirFileList).stubs().will(invoke(GetDirFileListStub));
    MOCKER(Adx::LogFileUtils::GetFileName).stubs().will(returnValue(IDE_DAEMON_INVALID_PATH_ERROR));
    MOCKER(remove).stubs().will(returnValue(0));
    MOCKER(AdxSendMsgByHandle).stubs().will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_OK, getFile->Process(handle, proto));
}

TEST_F(ADX_GET_FILE_UTEST, ProcessTestNoModuleScript)
{
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    std::shared_ptr<Adx::LogGetFile> getFile = std::make_shared<Adx::LogGetFile>();
    struct MsgProto *msg = LogCreateDataMsg("hal", 4);
    std::shared_ptr<MsgProto> proto(msg, free);
    proto->msgType = MsgType::MSG_DATA;

    int32_t runEnv = 1;
    MOCKER(LogIdeGetRunEnvBySession)
        .stubs()
        .with(any(), outBoundP(&runEnv))
        .will(returnValue(IDE_DAEMON_OK));
    MOCKER(LogIdeGetPidBySession).stubs().will(returnValue(IDE_DAEMON_OK));
    MOCKER(AdxSendMsgByHandle).stubs().will(returnValue(IDE_DAEMON_OK));
    MOCKER(LogFileUtils::IsFileExist).stubs().then(returnValue(false));

    EXPECT_EQ(IDE_DAEMON_OK, getFile->Process(handle, proto));
}

TEST_F(ADX_GET_FILE_UTEST, ProcessGetRunFailTest)
{
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    std::shared_ptr<Adx::LogGetFile> getFile = nullptr;
    getFile = std::make_shared<Adx::LogGetFile>();

    char msgData[8] = {'m','e','s','s','a','g','e', '\0'};
    struct MsgProto *msg = LogCreateDataMsg(msgData, 8);
    std::shared_ptr<MsgProto> proto(msg, free);
    proto->msgType = MsgType::MSG_DATA;

    MOCKER(LogIdeGetRunEnvBySession)
    .stubs()
    .will(returnValue(IDE_DAEMON_ERROR));

    EXPECT_EQ(IDE_DAEMON_ERROR, getFile->Process(handle, proto));
}

TEST_F(ADX_GET_FILE_UTEST, ProcessGetRunDockerTest)
{
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    std::shared_ptr<Adx::LogGetFile> getFile = nullptr;
    getFile = std::make_shared<Adx::LogGetFile>();

    char msgData[8] = {'m','e','s','s','a','g','e', '\0'};
    struct MsgProto *msg = LogCreateDataMsg(msgData, 8);
    std::shared_ptr<MsgProto> proto(msg, free);
    proto->msgType = MsgType::MSG_DATA;
    int32_t runEnv = 2;

    MOCKER(LogIdeGetRunEnvBySession)
    .stubs()
    .with(any(), outBound(&runEnv))
    .will(returnValue(IDE_DAEMON_OK));

    MOCKER(AdxSendMsgByHandle)
    .stubs()
    .will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_OK, getFile->Process(handle, proto));
}

TEST_F(ADX_GET_FILE_UTEST, ExportModuleInfoWithScript)
{
    std::shared_ptr<Adx::LogGetFile> getFile = nullptr;
    getFile = std::make_shared<Adx::LogGetFile>();
    int32_t pid = 12345;
    MOCKER(LogFileUtils::IsAccessible)
        .stubs()
        .will(returnValue(true));

    MOCKER(AdxCreateProcess)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));


    EXPECT_EQ(IDE_DAEMON_OK, getFile->ExportModuleInfo("dvpp", pid));
}

TEST_F(ADX_GET_FILE_UTEST, ExportModuleInfoWithoutScript)
{
    std::shared_ptr<Adx::LogGetFile> getFile = nullptr;
    getFile = std::make_shared<Adx::LogGetFile>();
    int32_t pid = 12345;
    MOCKER(LogFileUtils::IsFileExist)
        .stubs()
        .then(returnValue(false));

    EXPECT_EQ(-2, getFile->ExportModuleInfo("dvpp", pid));
    EXPECT_EQ(-1, getFile->ExportModuleInfo("error", pid));
}

TEST_F(ADX_GET_FILE_UTEST, IsIntDigital)
{
    std::shared_ptr<Adx::LogGetFile> getFile = nullptr;
    getFile = std::make_shared<Adx::LogGetFile>();
    EXPECT_EQ(false, getFile->IsIntDigital(""));
    EXPECT_EQ(false, getFile->IsIntDigital("12345abcd"));
    EXPECT_EQ(true, getFile->IsIntDigital("1234567890"));
}