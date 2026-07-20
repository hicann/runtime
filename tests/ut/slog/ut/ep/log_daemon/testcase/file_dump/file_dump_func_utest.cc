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
#include <algorithm>
#include <filesystem>
#include <fstream>
#define protected public
#define private public

extern "C" {
#include "hdclog_device_init.h"
#include "hdclog_com.h"
#include "config_common.h"
#include "log_cmd.h"
#include "log_drv.h"

HdclogErr LogCmdRespSettingResult(HDC_SESSION session, const char *errMsg, size_t errLen);
bool IsContainsStr(const char *str, const char *subStr);
HdclogErr ParseDeviceLogCmd(HDC_SESSION session, const LogDataMsg *msg);
bool JudgeIfComputePowerGroup(HDC_SESSION session, int32_t vfId);
HdclogErr PreProcessBeforeParseCmd(HDC_SESSION session);
}
#include "log_dsmi_drv.h"
#include "log_file_dump_c.h"
#include "log_file_utils.h"
#include "log_get_file.h"
#include "log_process_util.h"
#undef private
#undef protected
using namespace std;
using namespace testing;
using namespace Adx;

#include "self_log_stub.h"

class EP_FILE_DUMP_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
        ResetErrLog();
    }

    virtual void TearDown()
    {
        EXPECT_EQ(0, GetErrLogNum());
        system("rm -rf " PATH_ROOT "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("mkdir -p " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }
};

namespace Adx {
int32_t CreateProcess(const char *fileName, const mmArgvEnv *env, mmProcess *id);
}

namespace {
int32_t g_logCmdResponseMode = 0;

int32_t LogCmdSendLogMsgCoverageStub(LogCmdMsg *rcvMsg, const char *msg, uint16_t devId)
{
    (void)msg;
    (void)devId;
    const char *response = LEVEL_SETTING_SUCCESS;
    if (g_logCmdResponseMode == 1) {
        response = "[event]\nenable";
    } else if (g_logCmdResponseMode == 2) {
        response = "setting failed";
    }
    (void)strcpy_s(rcvMsg->msgData, sizeof(rcvMsg->msgData), response);
    return CONFIG_OK;
}

int32_t LogIdeContainerCoverageStub(HDC_SESSION session, int32_t *runEnv)
{
    (void)session;
    *runEnv = 2;
    return SYS_OK;
}

std::shared_ptr<MsgProto> MakeFileRequest(MsgType type, const char *logType)
{
    size_t dataLen = (logType == nullptr) ? 0U : strlen(logType) + 1U;
    MsgProto *proto = static_cast<MsgProto *>(calloc(1, sizeof(MsgProto) + dataLen));
    if (proto == nullptr) {
        return nullptr;
    }
    proto->msgType = type;
    if (logType != nullptr) {
        (void)strcpy_s(reinterpret_cast<char *>(proto->data), dataLen, logType);
    }
    return std::shared_ptr<MsgProto>(proto, free);
}
}

TEST_F(EP_FILE_DUMP_FUNC_UTEST, ComponentLifecycle)
{
    EXPECT_EQ(SYS_OK, FileDumpInit());
    FileDumpExit();
    EXPECT_EQ(SYS_OK, HdclogDeviceInit());
    EXPECT_EQ(SYS_OK, HdclogDeviceDestroy());
}

TEST_F(EP_FILE_DUMP_FUNC_UTEST, HdclogValidatesAndPreprocessesCommands)
{
    EXPECT_TRUE(IsContainsStr("[event] enable", "[event]"));
    EXPECT_FALSE(IsContainsStr("global", "[event]"));
    EXPECT_EQ(HDCLOG_SUCCESSED, LogCmdRespSettingResult(reinterpret_cast<HDC_SESSION>(1), "ok", 2));
    EXPECT_FALSE(JudgeIfComputePowerGroup(reinterpret_cast<HDC_SESSION>(1), 0));
    EXPECT_TRUE(JudgeIfComputePowerGroup(reinterpret_cast<HDC_SESSION>(1), 1));
    EXPECT_EQ(HDCLOG_SUCCESSED, PreProcessBeforeParseCmd(reinterpret_cast<HDC_SESSION>(1)));

    size_t size = sizeof(LogDataMsg) + 8U;
    LogDataMsg *message = static_cast<LogDataMsg *>(calloc(1, size));
    ASSERT_NE(nullptr, message);
    message->sliceLen = 0;
    EXPECT_EQ(HDCLOG_INIT_FAILED, ParseDeviceLogCmd(reinterpret_cast<HDC_SESSION>(1), message));
    message->sliceLen = MSG_MAX_LEN;
    EXPECT_EQ(HDCLOG_INIT_FAILED, ParseDeviceLogCmd(reinterpret_cast<HDC_SESSION>(1), message));
    free(message);
    ResetErrLog();
}

TEST_F(EP_FILE_DUMP_FUNC_UTEST, HdclogParsesResponsesAndProcessesRequest)
{
    MOCKER(LogCmdSendLogMsg).stubs().will(invoke(LogCmdSendLogMsgCoverageStub));
    size_t size = sizeof(LogDataMsg) + 32U;
    LogDataMsg *message = static_cast<LogDataMsg *>(calloc(1, size));
    ASSERT_NE(nullptr, message);
    message->sliceLen = 16U;
    message->devId = 0;
    (void)strcpy_s(reinterpret_cast<char *>(message->data), 32U, "SetLogLevel(0)");

    g_logCmdResponseMode = 0;
    EXPECT_EQ(HDCLOG_SUCCESSED, ParseDeviceLogCmd(reinterpret_cast<HDC_SESSION>(1), message));
    g_logCmdResponseMode = 1;
    EXPECT_EQ(HDCLOG_SUCCESSED, ParseDeviceLogCmd(reinterpret_cast<HDC_SESSION>(1), message));
    g_logCmdResponseMode = 2;
    EXPECT_EQ(HDCLOG_SUCCESSED, ParseDeviceLogCmd(reinterpret_cast<HDC_SESSION>(1), message));
    ResetErrLog();

    CommHandle handle = {};
    handle.type = COMM_HDC;
    handle.session = 1U;
    EXPECT_EQ(HDCLOG_EMPTY_QUEUE, IdeDeviceLogProcess(nullptr, message, static_cast<uint32_t>(size)));
    EXPECT_EQ(HDCLOG_EMPTY_QUEUE, IdeDeviceLogProcess(&handle, nullptr, static_cast<uint32_t>(size)));
    g_logCmdResponseMode = 0;
    EXPECT_EQ(HDCLOG_SUCCESSED, IdeDeviceLogProcess(&handle, message, static_cast<uint32_t>(size)));
    handle.session = 0U;
    EXPECT_EQ(HDCLOG_IDE_GET_EVN_OR_VFID_FAILED,
              IdeDeviceLogProcess(&handle, message, static_cast<uint32_t>(size)));
    free(message);
    ResetErrLog();
}

TEST_F(EP_FILE_DUMP_FUNC_UTEST, HdclogReportsResponseFailure)
{
    MOCKER(AdxSendMsgByHandle).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(HDCLOG_WRITE_FAILED,
              LogCmdRespSettingResult(reinterpret_cast<HDC_SESSION>(1), "failed", strlen("failed")));
    ResetErrLog();
}

TEST_F(EP_FILE_DUMP_FUNC_UTEST, SessionAttributes)
{
    int32_t runEnv = 0;
    int32_t pid = 0;
    HDC_SESSION session = reinterpret_cast<HDC_SESSION>(1);
    EXPECT_EQ(SYS_OK, LogIdeGetRunEnvBySession(session, &runEnv));
    EXPECT_EQ(1, runEnv);
    EXPECT_EQ(SYS_OK, LogIdeGetPidBySession(session, &pid));
    EXPECT_EQ(0, pid);
}

TEST_F(EP_FILE_DUMP_FUNC_UTEST, FileUtilitiesAndComponent)
{
    EXPECT_TRUE(LogFileUtils::StartsWith("slog/device", "slog"));
    EXPECT_TRUE(LogFileUtils::EndsWith("device.log", ".log"));

    LogGetFile getFile;
    EXPECT_EQ(SYS_OK, getFile.Init());
    EXPECT_FALSE(getFile.IsIntDigital("12x"));
    EXPECT_TRUE(getFile.IsIntDigital("123"));
    EXPECT_EQ(SYS_OK, getFile.UnInit());
}

TEST_F(EP_FILE_DUMP_FUNC_UTEST, FileUtilitiesCoverRealDirectoryTree)
{
    const std::string root = std::string(PATH_ROOT) + "/file-utils";
    const std::string nested = root + "/first/second";
    ASSERT_EQ(IDE_DAEMON_NONE_ERROR, LogFileUtils::CreateDir(nested));
    EXPECT_TRUE(LogFileUtils::IsDirectory(root));
    EXPECT_TRUE(LogFileUtils::IsDirExist(nested));

    const std::string source = root + "/prefix-source.log";
    const std::string copied = root + "/prefix-copy.log";
    const std::string nestedFile = nested + "/prefix-nested.log";
    const std::string ignored = nested + "/prefix-ignore.tmp";
    for (const std::string& path : {source, nestedFile, ignored}) {
        std::ofstream file(path);
        ASSERT_TRUE(file.is_open());
        file << path;
    }

    EXPECT_TRUE(LogFileUtils::IsFileExist(source));
    EXPECT_TRUE(LogFileUtils::IsAccessible(source));
    EXPECT_FALSE(LogFileUtils::IsDirectory(source));
    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, LogFileUtils::CopyFileAndRename(source, copied));
    EXPECT_TRUE(LogFileUtils::IsFileExist(copied));

    std::string resolved;
    EXPECT_EQ(SYS_OK, LogFileUtils::FilePathIsReal(root, resolved));
    EXPECT_FALSE(resolved.empty());
    EXPECT_EQ(SYS_OK, LogFileUtils::FileNameIsReal(source, resolved));
    EXPECT_EQ(source, resolved);

    std::string name;
    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, LogFileUtils::GetFileName(source, name));
    EXPECT_EQ("prefix-source.log", name);
    EXPECT_EQ(root, LogFileUtils::GetFileDir(source));
    EXPECT_EQ("/", LogFileUtils::GetFileDir("/name"));

    std::string replace = "debug/device/debug";
    EXPECT_EQ("run/device/run", LogFileUtils::ReplaceAll(replace, "debug", "run"));

    std::vector<std::string> files;
    ASSERT_TRUE(LogFileUtils::GetDirFileList(root + "/", files, nullptr, "prefix", 3));
    EXPECT_NE(files.end(), std::find(files.begin(), files.end(), source));
    EXPECT_NE(files.end(), std::find(files.begin(), files.end(), copied));
    EXPECT_TRUE(std::any_of(files.begin(), files.end(), [](const std::string& path) {
        return path.find("prefix-nested.log") != std::string::npos;
    }));
    EXPECT_EQ(files.end(), std::find(files.begin(), files.end(), ignored));

    std::string removable = root;
    EXPECT_EQ(SYS_OK, LogFileUtils::RemoveDir(removable, 0));
    EXPECT_FALSE(LogFileUtils::IsFileExist(root));
}

TEST_F(EP_FILE_DUMP_FUNC_UTEST, LogGetFileValidatesPathsAndMessageNames)
{
    LogGetFile getFile;
    ASSERT_EQ(SYS_OK, getFile.Init());
    EXPECT_TRUE(getFile.IsValidLogType("dvpp"));
    EXPECT_FALSE(getFile.IsValidLogType("unknown"));

    std::string match;
    EXPECT_EQ(SYS_OK, getFile.GetPathPrefix("/var/log/npu/slog/device.log.42.tmp", match, 42));
    EXPECT_EQ("/var/log/npu/slog/", match);

    match.clear();
    EXPECT_TRUE(getFile.IsValidTmpFilePath(
        "/home/HwHiAiUser/ide_daemon/module_info/42/report.log", match, 42));
    EXPECT_EQ("/home/HwHiAiUser/ide_daemon/module_info/42", match);

    LogGetFile::g_numToPid[17] = 42;
    EXPECT_EQ(17, getFile.GetMappingPid(42));
    EXPECT_EQ(32, getFile.GetMappingPid(999));

    std::string message = "/var/log/messages";
    EXPECT_TRUE(getFile.IsValidMessageFile(message));
    message = "/var/log/messages.99";
    EXPECT_TRUE(getFile.IsValidMessageFile(message));
    message = "/var/log/messages.100";
    EXPECT_FALSE(getFile.IsValidMessageFile(message));
    message = "/var/log/messages.invalid";
    EXPECT_FALSE(getFile.IsValidMessageFile(message));
    ResetErrLog();

    std::vector<std::string> files;
    EXPECT_EQ(SYS_ERROR, getFile.GetFileList("", files, 42));
    ResetErrLog();
    EXPECT_EQ(SYS_ERROR, getFile.GetFileList("unknown", files, 42));
    ResetErrLog();

    CommHandle handle = {};
    EXPECT_EQ(SYS_OK, getFile.TransferProcess(handle, "event_sched", "/tmp/source", "dest"));
    EXPECT_EQ(SYS_OK, getFile.TransferProcess(handle, "slog", "/tmp/source", "dest"));
    LogGetFile::g_numToPid.clear();
    EXPECT_EQ(SYS_OK, getFile.UnInit());
}

TEST_F(EP_FILE_DUMP_FUNC_UTEST, LogGetFileTransfersKnownPathsAndRejectsInvalidPaths)
{
    LogGetFile getFile;
    ASSERT_EQ(SYS_OK, getFile.Init());
    CommHandle handle = {};
    handle.type = COMM_HDC;
    handle.session = 1U;

    EXPECT_EQ(SYS_OK, getFile.TransferFile(handle, "event_sched",
        "/sys/devices/virtual/devdrv_manager/davinci_manager/node/event.log", 42));
    LogGetFile::g_numToPid[17] = 42;
    EXPECT_EQ(SYS_OK, getFile.TransferFile(handle, "message",
        "/var/log/ide_daemon/message/17/messages", 42));
    EXPECT_EQ(SYS_ERROR, getFile.TransferFile(handle, "event_sched", "/tmp/not-a-device-path", 42));
    EXPECT_EQ(SYS_ERROR, getFile.TransferFile(handle, "slog", PATH_ROOT "/missing.log", 42));
    ResetErrLog();

    std::string match;
    EXPECT_EQ(SYS_OK, getFile.GetPathPrefix(
        "/sys/devices/virtual/devdrv_manager/davinci_manager/node/event.log", match, 42));
    match.clear();
    EXPECT_EQ(SYS_OK, getFile.GetPathPrefix("/var/log/ide_daemon/message/17/messages", match, 42));
    match.clear();
    EXPECT_EQ(SYS_ERROR, getFile.GetPathPrefix("/tmp/not-a-device-path", match, 42));
    ResetErrLog();

    EXPECT_EQ(SYS_ERROR, getFile.ExportModuleInfo("unknown", 42));
    ResetErrLog();
    EXPECT_EQ(SYS_INVALID_PARAM, getFile.ExportModuleInfo("dvpp", 42));
    std::vector<std::string> files;
    EXPECT_EQ(SYS_INVALID_PARAM, getFile.GetFileList("dvpp", files, 42));
    LogGetFile::g_numToPid.clear();
}

TEST_F(EP_FILE_DUMP_FUNC_UTEST, LogGetFileHandlesMessagePreprocessAndClearFailures)
{
    LogGetFile getFile;
    ASSERT_EQ(SYS_OK, getFile.Init());
    LogGetFile::g_numToPid[17] = 42;
    MOCKER(AdxCreateProcess).stubs().will(returnValue(SYS_ERROR));

    std::string message = "/var/log/messages";
    EXPECT_EQ(SYS_ERROR, getFile.CopyFileToUserDir(message, 42));
    std::string logType = "message";
    getFile.ClearTmpDir(logType, 42);
    ResetErrLog();
    LogGetFile::g_numToPid.clear();
}

TEST_F(EP_FILE_DUMP_FUNC_UTEST, LogGetFileProcessRejectsNonDataAndUnknownType)
{
    LogGetFile getFile;
    ASSERT_EQ(SYS_OK, getFile.Init());
    CommHandle handle = {};
    handle.type = COMM_HDC;
    handle.session = 1U;

    auto nonData = MakeFileRequest(MsgType::MSG_CTRL, nullptr);
    ASSERT_NE(nullptr, nonData);
    EXPECT_EQ(SYS_OK, getFile.Process(handle, nonData));
    ResetErrLog();

    auto unknown = MakeFileRequest(MsgType::MSG_DATA, "unknown");
    ASSERT_NE(nullptr, unknown);
    EXPECT_EQ(SYS_ERROR, getFile.Process(handle, unknown));
    ResetErrLog();
}

TEST_F(EP_FILE_DUMP_FUNC_UTEST, LogGetFileProcessBlocksContainerRequests)
{
    LogGetFile getFile;
    ASSERT_EQ(SYS_OK, getFile.Init());
    CommHandle handle = {};
    handle.type = COMM_HDC;
    handle.session = 1U;
    MOCKER(LogIdeGetRunEnvBySession).stubs().will(invoke(LogIdeContainerCoverageStub));
    auto request = MakeFileRequest(MsgType::MSG_DATA, "slog");
    ASSERT_NE(nullptr, request);
    EXPECT_EQ(SYS_OK, getFile.Process(handle, request));
    ResetErrLog();
}

TEST_F(EP_FILE_DUMP_FUNC_UTEST, CreateProcessSuccess)
{
    MOCKER(Adx::CreateProcess).stubs().will(returnValue(EN_OK));
    MOCKER(mmWaitPid).stubs().will(returnValue(EN_ERR));
    EXPECT_EQ(SYS_OK, AdxCreateProcess("true"));
}
