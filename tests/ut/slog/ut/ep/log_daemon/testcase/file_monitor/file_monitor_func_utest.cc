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

#include "self_log_stub.h"
#include "file_monitor_core.h"
#include "file_monitor_common.h"
#include "file_bbox_monitor.h"
#include "stackcore_file_monitor.h"
#include "file_slogdlog_monitor.h"
#include "file_device_app_monitor.h"
#include "server_mgr.h"
#include "adcore_api.h"
#include "log_system_api.h"
#include "log_path_mgr.h"

using namespace std;
using namespace testing;

extern "C" {
    extern ServerMgr g_serverMgr[NR_COMPONENTS];
    int32_t FileMonitorStart(ServerHandle handle);
    int32_t FileMonitorStop(void);
    int32_t ServerProcess(const CommHandle* handle, const void* msg, uint32_t len);
}

class EP_FILE_MONITOR_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
        ResetErrLog();
    }

    virtual void TearDown()
    {
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

static int32_t ServerRecvMsgStub(ServerHandle handle, char **data, uint32_t *len, uint32_t timeout)
{
    char *str = "dev-os-0";
    (void)memcpy_s(*data, *len, str, strlen(str));
    *len = strlen(str) + 1;
    return 0;
}

static void AddStackcoreFile(void)
{
    system("mkdir -p " PATH_ROOT "/coredump/udf");
    system("mkdir -p " CORE_DEFAULT_PATH "udf");
    char cmd[1024] = { 0 };
    for (int i = 0; i < 100; i++) {
        (void)memset_s(cmd, 1024, 0, 1024);
        (void)sprintf_s(cmd, 1024, "echo 'test' > %s/coredump/stackcore.slogd.11.%d", PATH_ROOT, i);
        system(cmd);
        (void)memset_s(cmd, 1024, 0, 1024);
        (void)sprintf_s(cmd, 1024, "chmod 440 %s/coredump/stackcore.slogd.11.%d", PATH_ROOT, i);
        system(cmd);
        (void)memset_s(cmd, 1024, 0, 1024);
        (void)sprintf_s(cmd, 1024, "echo 'test' > %s/coredump/udf/stackcore.slogd.11.%d", PATH_ROOT, i);
        system(cmd);
        (void)memset_s(cmd, 1024, 0, 1024);
        (void)sprintf_s(cmd, 1024, "chmod 440 %s/coredump/udf/stackcore.slogd.11.%d", PATH_ROOT, i);
        system(cmd);
    }
    system("mv " PATH_ROOT "/coredump/* " CORE_DEFAULT_PATH);
}

static void GetFileList(std::string &filePath, std::vector<std::string> &fileList)
{
    DIR* dir = opendir(filePath.c_str());
    if (dir == NULL) {
        return;
    }
    struct dirent *entry;
    while ((entry = readdir(dir)) != nullptr) {
        if (entry->d_type == DT_DIR || strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
            continue;
        }
        fileList.emplace_back(filePath + "/" + std::string(entry->d_name));
    }
    closedir(dir);
}

static int32_t ToolCondTimedWaitStub(ToolCond *cond, ToolMutex *mutex, UINT32 milliSecond)
{
    usleep(1);
    return 0;
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, StackcoreMonitorAging)
{
    AddStackcoreFile();
    MOCKER(ToolCondTimedWait).stubs().will(invoke(ToolCondTimedWaitStub));
    MOCKER(ServerSyncFile).expects(exactly(100)).will(returnValue(0));
    MOCKER(ServerSyncFile).stubs().will(returnValue(0));
    EXPECT_EQ(LOG_SUCCESS, FileMonitorInit());
    sleep(1);
    ServerHandle handle = (ServerMgr *)LogMalloc(sizeof(ServerMgr));
    MOCKER(ServerRecvMsg).stubs().will(invoke(ServerRecvMsgStub));
    EXPECT_EQ(LOG_SUCCESS, FileMonitorStart(handle));
    sleep(1);
    FileMonitorStop();
    sleep(1);
    FileMonitorExit();

    std::string path = CORE_DEFAULT_PATH;
    std::vector<std::string> fileList;
    GetFileList(path, fileList);
    EXPECT_EQ(50, fileList.size());
    fileList.clear();
    path.clear();
    char *sub = "udf";
    path = CORE_DEFAULT_PATH + std::string(sub);
    GetFileList(path, fileList);
    EXPECT_EQ(50, fileList.size());
    free(handle);
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, StackcoreMonitorAgingRemoveFailed)
{
    AddStackcoreFile();
    MOCKER(ToolCondTimedWait).stubs().will(invoke(ToolCondTimedWaitStub));
    MOCKER(ServerSyncFile).expects(exactly(200)).will(returnValue(0));
    MOCKER(ServerSyncFile).stubs().will(returnValue(0));
    MOCKER(static_cast<int(*)(const char*)>(remove)).stubs().will(returnValue(-1));
    EXPECT_EQ(LOG_SUCCESS, FileMonitorInit());
    sleep(1);
    ServerHandle handle = (ServerMgr *)LogMalloc(sizeof(ServerMgr));
    MOCKER(ServerRecvMsg).stubs().will(invoke(ServerRecvMsgStub));
    EXPECT_EQ(LOG_SUCCESS, FileMonitorStart(handle));
    sleep(1);
    FileMonitorStop();
    sleep(1);
    FileMonitorExit();
    free(handle);
}

static int32_t ServerSyncFileStub(ServerHandle handle, const char *srcFileName, const char *dstFileName)
{
    printf("send file: %s\n", srcFileName);
    return 0;
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitor)
{
    system("mkdir -p " BBOX_DIR_MONITOR);
    system("mkdir -p " CORE_DEFAULT_PATH);
    system("mkdir -p " CORE_DEFAULT_PATH "udf");
    system("echo test > " CORE_DEFAULT_PATH "stackcore.slogd.11.1290318907");
    system("echo test > " CORE_DEFAULT_PATH "udf/stackcore.udf.11.1290318907");
    system("chmod 440 " CORE_DEFAULT_PATH "stackcore.slogd.11.1290318907");
    system("chmod 440 " CORE_DEFAULT_PATH "udf/stackcore.udf.11.1290318907");
    system("mkdir -p " PATH_ROOT "/hisi_logs");
    system("echo test1 > " PATH_ROOT "/hisi_logs/history.log");
    system("mkdir -p " PATH_ROOT "/hisi_logs/device-0/bbox");
    system("echo test > " PATH_ROOT "/hisi_logs/device-0/bbox/test1.log");
    system("mkdir -p " SLOG_PATH "/slogd");
    system("echo test > " SLOG_PATH "/slogd/slogdlog");
    system("mkdir -p " SLOG_PATH "/debug/device-app-123");
    system("echo test > " SLOG_PATH "/debug/device-app-123/device-app-123_2024.log");
    system("mkdir -p " SLOG_PATH "/debug/device-app-456");
    system("echo test > " SLOG_PATH "/debug/device-app-456/device-app-456_2024.log");
    system("mkdir -p " SLOG_PATH "/run/device-app-123");
    system("echo test > " SLOG_PATH "/run/device-app-123/device-app-123_2024.log");

    MOCKER(ToolCondTimedWait).stubs().will(invoke(ToolCondTimedWaitStub));
    MOCKER(ServerSyncFile).expects(exactly(17)).will(invoke(ServerSyncFileStub));
    char *rootPath = SLOG_PATH;
    MOCKER(LogGetRootPath).stubs().will(returnValue(rootPath));
    EXPECT_EQ(LOG_SUCCESS, FileMonitorInit());
    sleep(1);
    ServerHandle handle = (ServerMgr *)LogMalloc(sizeof(ServerMgr));
    MOCKER(ServerRecvMsg).stubs().will(invoke(ServerRecvMsgStub));
    EXPECT_EQ(LOG_SUCCESS, FileMonitorStart(handle));

    sleep(1);
    system("echo test2 > " PATH_ROOT "/hisi_logs/history.log");
    system("mkdir -p " PATH_ROOT "/hisi_logs/device-0/bbox2");
    system("echo test2 > " PATH_ROOT "/hisi_logs/device-0/bbox2/test2.log");

    system("echo test > " CORE_DEFAULT_PATH "stackcore.slogd.6.1344565645");
    system("chmod 440 " CORE_DEFAULT_PATH "stackcore.slogd.6.1344565645");
    system("echo test > " CORE_DEFAULT_PATH "udf/stackcore.udf.6.1432545633");
    system("chmod 440 " CORE_DEFAULT_PATH "udf/stackcore.udf.6.1432545633");

    system("mv " PATH_ROOT "/slog/slogd/slogdlog " PATH_ROOT "/slog/slogd/slogdlog.old");
    system("echo test > " PATH_ROOT "/slog/slogd/slogdlog");
    system("mkdir -p " PATH_ROOT "/slog/debug/device-app-456");
    system("mkdir -p " PATH_ROOT "/slog/run/device-app-456");
    system("echo test > " PATH_ROOT "/slog/debug/device-app-456/device-app-456_2024.log");
    system("echo test > " PATH_ROOT "/slog/run/device-app-456/device-app-456_2024.log");
    sleep(4);
    FileMonitorStop();
    sleep(1);
    FileMonitorExit();
    free(handle);
}

static void *MallocStub(size_t len)
{
    void *buf = malloc(len);
    memset_s(buf, len, 0, len);
    return buf;
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitorMallocFailed)
{
    system("mkdir -p " BBOX_DIR_MONITOR);
    system("mkdir -p " CORE_DEFAULT_PATH);
    system("mkdir -p " CORE_DEFAULT_PATH "udf");
    system("echo test > " CORE_DEFAULT_PATH "stackcore.slogd.11.1290318907");
    system("echo test > " CORE_DEFAULT_PATH "udf/stackcore.udf.11.1290318907");
    system("chmod 440 " CORE_DEFAULT_PATH "stackcore.slogd.11.1290318907");
    system("chmod 440 " CORE_DEFAULT_PATH "udf/stackcore.udf.11.1290318907");
    MOCKER(ToolCondTimedWait).stubs().will(invoke(ToolCondTimedWaitStub));
    MOCKER(ServerSyncFile).expects(exactly(2)).will(returnValue(0));
    EXPECT_EQ(LOG_SUCCESS, FileMonitorInit());
    sleep(1);
    ServerHandle handle = (ServerMgr *)LogMalloc(sizeof(ServerMgr));
    MOCKER(ServerRecvMsg).stubs().will(invoke(ServerRecvMsgStub));
    EXPECT_EQ(LOG_SUCCESS, FileMonitorStart(handle));
    sleep(1);
    MOCKER(LogMalloc).stubs().will(returnValue((void *)nullptr));
    system("echo test > " CORE_DEFAULT_PATH "stackcore.slogd.6.1344565645");
    system("echo test > " CORE_DEFAULT_PATH "udf/stackcore.udf.6.1432545633");
    system("chmod 440 " CORE_DEFAULT_PATH "stackcore.slogd.6.1344565645");
    system("chmod 440 " CORE_DEFAULT_PATH "udf/stackcore.udf.6.1432545633");
    sleep(2);
    FileMonitorStop();
    sleep(1);
    FileMonitorExit();
    free(handle);
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitorStartTwice)
{
    system("mkdir -p " BBOX_DIR_MONITOR);
    system("mkdir -p " CORE_DEFAULT_PATH "udf");
    system("mkdir -p " PATH_ROOT "/" BBOX_DIR_MONITOR);
    system("echo test > " PATH_ROOT "/hisi_logs/history.log");
    system("mkdir -p " PATH_ROOT "/hisi_logs/device-0/bbox");
    system("echo test > " PATH_ROOT "/hisi_logs/device-0/bbox/test2.log");
    MOCKER(ToolCondTimedWait).stubs().will(returnValue(0));
    MOCKER(ServerSyncFile).expects(exactly(2)).will(returnValue(0));
    EXPECT_EQ(LOG_SUCCESS, FileMonitorInit());
    sleep(1);
    ServerHandle handle = (ServerMgr *)LogMalloc(sizeof(ServerMgr));
    MOCKER(ServerRecvMsg).stubs().will(invoke(ServerRecvMsgStub));
    EXPECT_EQ(LOG_SUCCESS, FileMonitorStart(handle));
    EXPECT_EQ(LOG_FAILURE, FileMonitorStart(handle));
    sleep(1);
    system("mv " PATH_ROOT "/hisi_logs/* " BBOX_DIR_MONITOR);
    sleep(2);
    FileMonitorStop();
    sleep(1);
    FileMonitorExit();
    free(handle);
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitorCreateEventFailed)
{
    MOCKER(ToolCreateTaskWithThreadAttr).stubs().will(returnValue(-1));
    EXPECT_EQ(LOG_FAILURE, FileMonitorInit());
    FileMonitorExit();
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitorInitAllFailed)
{
    MOCKER(BboxMonitorInit).stubs().will(returnValue(-1));
    EXPECT_EQ(LOG_FAILURE, FileMonitorInit());
    FileMonitorExit();
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitorGetDevFailed)
{
    system("mkdir -p " BBOX_DIR_MONITOR);
    MOCKER(ToolCondTimedWait).stubs().will(invoke(ToolCondTimedWaitStub));
    MOCKER(halGetDevNumEx).stubs().will(returnValue(1));
    EXPECT_EQ(LOG_SUCCESS, FileMonitorInit());
    sleep(1);
    ServerHandle handle = (ServerMgr *)LogMalloc(sizeof(ServerMgr));
    MOCKER(ServerRecvMsg).stubs().will(invoke(ServerRecvMsgStub));
    EXPECT_EQ(LOG_FAILURE, FileMonitorStart(handle));
    sleep(1);
    system("mkdir -p " BBOX_DIR_MONITOR "device-0/bbox");
    system("echo test > " BBOX_DIR_MONITOR "device-0/bbox/test2.log");
    sleep(1);
    FileMonitorStop();
    sleep(1);
    FileMonitorExit();
    free(handle);
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitorNotifyFailed)
{
    system("mkdir -p " BBOX_DIR_MONITOR);
    system("mkdir -p " CORE_DEFAULT_PATH "udf");
    MOCKER(ToolCondTimedWait).stubs().will(invoke(ToolCondTimedWaitStub));
    MOCKER(inotify_init1).stubs().will(returnValue(-1));
    EXPECT_EQ(LOG_SUCCESS, FileMonitorInit());
    sleep(1);
    ServerHandle handle = (ServerMgr *)LogMalloc(sizeof(ServerMgr));
    MOCKER(ServerRecvMsg).stubs().will(invoke(ServerRecvMsgStub));
    EXPECT_EQ(LOG_FAILURE, FileMonitorStart(handle));
    sleep(1);
    system("mkdir -p " BBOX_DIR_MONITOR "device-0/bbox");
    system("echo test > " BBOX_DIR_MONITOR "device-0/bbox/test2.log");
    sleep(1);
    FileMonitorStop();
    sleep(1);
    FileMonitorExit();
    free(handle);
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitorInitNoFile)
{
    system("mkdir -p " BBOX_DIR_MONITOR);
    system("mkdir -p " CORE_DEFAULT_PATH "udf");
    EXPECT_EQ(LOG_SUCCESS, FileMonitorInit());
    sleep(1);
    ServerHandle handle = (ServerMgr *)LogMalloc(sizeof(ServerMgr));
    MOCKER(ServerRecvMsg).stubs().will(invoke(ServerRecvMsgStub));
    MOCKER(ServerSyncFile).stubs().will(returnValue(0));
    EXPECT_EQ(LOG_SUCCESS, FileMonitorStart(handle));
    sleep(1);
    system("mkdir -p " BBOX_DIR_MONITOR);
    system("mkdir -p " BBOX_DIR_MONITOR "device-0/");
    sleep(1);
    FileMonitorStop();
    sleep(1);
    FileMonitorExit();
    free(handle);
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitorInitFileNoPermission)
{
    system("mkdir -p " BBOX_DIR_MONITOR);
    system("mkdir -p " CORE_DEFAULT_PATH "udf");
    system("> " CORE_DEFAULT_PATH "stackcore.slogd.11.1290318907");
    system("chmod 440 " CORE_DEFAULT_PATH "stackcore.slogd.11.1290318907");
    EXPECT_EQ(LOG_SUCCESS, FileMonitorInit());
    sleep(1);
    ServerHandle handle = (ServerMgr *)LogMalloc(sizeof(ServerMgr));
    MOCKER(ServerRecvMsg).stubs().will(invoke(ServerRecvMsgStub));
    MOCKER(ServerSyncFile).stubs().will(returnValue(0));
    EXPECT_EQ(LOG_SUCCESS, FileMonitorStart(handle));
    sleep(1);
    system("mkdir -p " BBOX_DIR_MONITOR);
    system("mkdir -p " BBOX_DIR_MONITOR "device-0/");
    sleep(1);
    FileMonitorStop();
    sleep(1);
    FileMonitorExit();
    free(handle);
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitorInitTwoFile)
{
    system("rm -rf " BBOX_DIR_MONITOR);
    system("mkdir -p " BBOX_DIR_MONITOR);
    EXPECT_EQ(LOG_SUCCESS, FileMonitorInit());
    sleep(1);
    ServerHandle handle = (ServerMgr *)LogMalloc(sizeof(ServerMgr));
    MOCKER(ServerRecvMsg).stubs().will(invoke(ServerRecvMsgStub));
    MOCKER(ServerSyncFile).stubs().will(returnValue(0));
    EXPECT_EQ(LOG_SUCCESS, FileMonitorStart(handle));
    sleep(1);
    system("echo test > " BBOX_DIR_MONITOR "history.log");
    system("mkdir -p " BBOX_DIR_MONITOR "device-0/29389742/bbox");
    system("echo test > " BBOX_DIR_MONITOR "device-0/29389742/bbox/test2.log");
    sleep(1);
    system("mkdir -p " BBOX_DIR_MONITOR "device-0/193279173/log");
    system("echo test > " BBOX_DIR_MONITOR "device-0/193279173/log/test2.log");
    system("mkdir -p " BBOX_DIR_MONITOR "device-0/1739739/log");
    system("echo test > " BBOX_DIR_MONITOR "device-0/1739739/log/test2.log");
    sleep(1);
    FileMonitorStop();
    sleep(1);
    FileMonitorExit();
    free(handle);
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitorNull)
{
    EXPECT_EQ(LOG_FAILURE, BboxMonitorInit(nullptr));
    BboxMonitorExit();
    EXPECT_EQ(LOG_SUCCESS, StackcoreMonitorInit(nullptr));
    StackcoreMonitorExit();
}

static void FileMonitorTestFailed(void)
{
    FileMonitorInit();
    sleep(1);
    ServerHandle handle = (ServerMgr *)LogMalloc(sizeof(ServerMgr));
    MOCKER(ServerRecvMsg).stubs().will(invoke(ServerRecvMsgStub));
    FileMonitorStart(handle);
    sleep(1);
    system("mkdir -p " BBOX_DIR_MONITOR "device-0/120828973/bbox");
    system("echo test > " BBOX_DIR_MONITOR "device-0/120828973/bbox/test2.log");
    sleep(1);
    FileMonitorStop();
    sleep(1);
    FileMonitorExit();
    free(handle);
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitorSprintfFailed)
{
    for(int32_t i = 0; i < 10; i++) {
        system("rm -rf " BBOX_DIR_MONITOR);
        ResetErrLog();
        system("mkdir -p " BBOX_DIR_MONITOR);
        system("echo test > " BBOX_DIR_MONITOR "history.log");
        system("mkdir -p " BBOX_DIR_MONITOR "device-0/20394792379/bbox");
        system("echo test > " BBOX_DIR_MONITOR "device-0/20394792379/bbox/test2.log");
        system("mkdir -p " CORE_DEFAULT_PATH);
        system("mkdir -p " CORE_DEFAULT_PATH "udf");
        system("echo test > " CORE_DEFAULT_PATH "stackcore.slogd.11.1290318907");
        system("echo test > " CORE_DEFAULT_PATH "udf/stackcore.udf.11.1290318907");
        system("chmod 440 " CORE_DEFAULT_PATH "stackcore.slogd.11.1290318907");
        system("chmod 440 " CORE_DEFAULT_PATH "udf/stackcore.udf.11.1290318907");
        MOCKER(ToolCondTimedWait).stubs().will(invoke(ToolCondTimedWaitStub));
        MOCKER(ServerSyncFile).stubs().will(returnValue(0));

        MOCKER(vsprintf_s).stubs().will(repeat(0, i)).then(returnValue(-1));

        FileMonitorTestFailed();
        EXPECT_LT(0, GetErrLogNum());
        GlobalMockObject::verify();
    }
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitorStrcpyFailed)
{
    for(int32_t i = 0; i < 2; i++) {
        system("rm -rf " BBOX_DIR_MONITOR);
        ResetErrLog();
        system("mkdir -p " BBOX_DIR_MONITOR);
        system("echo test > " BBOX_DIR_MONITOR "history.log");
        system("mkdir -p " BBOX_DIR_MONITOR "device-0/20394792379/bbox");
        system("echo test > " BBOX_DIR_MONITOR "device-0/20394792379/bbox/test2.log");
        system("mkdir -p " CORE_DEFAULT_PATH);
        system("mkdir -p " CORE_DEFAULT_PATH "udf");
        system("echo test > " CORE_DEFAULT_PATH "stackcore.slogd.11.1290318907");
        system("echo test > " CORE_DEFAULT_PATH "udf/stackcore.udf.11.1290318907");
        system("chmod 440 " CORE_DEFAULT_PATH "stackcore.slogd.11.1290318907");
        system("chmod 440 " CORE_DEFAULT_PATH "udf/stackcore.udf.11.1290318907");
        MOCKER(ToolCondTimedWait).stubs().will(invoke(ToolCondTimedWaitStub));
        MOCKER(ServerSyncFile).stubs().will(returnValue(0));

        MOCKER(strcpy_s).stubs().will(repeat(0, i)).then(returnValue(-1));

        FileMonitorTestFailed();
        EXPECT_LT(0, GetErrLogNum());
        GlobalMockObject::verify();
    }
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitorCommon)
{
    char *str = FileMonitorGetMasterIdStr();
    EXPECT_EQ(LOG_FAILURE, FileMonitorAddWatch(nullptr, 0, nullptr, 0));
    system("mkdir -p " BBOX_DIR_MONITOR);
    int32_t wd = 0;
    MOCKER(inotify_add_watch).stubs().will(returnValue(-1));
    EXPECT_EQ(LOG_FAILURE, FileMonitorAddWatch(BBOX_DIR_MONITOR, 0, &wd, 0));
}

static int32_t ServerRecvMsgFailed(ServerHandle handle, char **data, uint32_t *len, uint32_t timeout)
{
    char *str = "device-0";
    (void)memcpy_s(*data, *len, str, strlen(str));
    *len = strlen(str) + 1;
    return 0;
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitorStartFailed)
{
    EXPECT_EQ(LOG_FAILURE, FileMonitorStart(nullptr));
    MOCKER(ServerRecvMsg).stubs().will(returnValue(-1));
    ServerHandle handle = (ServerMgr *)LogMalloc(sizeof(ServerMgr));
    EXPECT_EQ(LOG_FAILURE, FileMonitorStart(handle));

    GlobalMockObject::verify();
    MOCKER(ServerRecvMsg).stubs().will(invoke(ServerRecvMsgFailed));
    EXPECT_EQ(LOG_FAILURE, FileMonitorStart(handle));
    GlobalMockObject::verify();

    MOCKER(ServerRecvMsg).stubs().will(invoke(ServerRecvMsgStub));
    MOCKER(BboxMonitorStart).stubs().will(returnValue(LOG_FAILURE));
    EXPECT_EQ(LOG_FAILURE, FileMonitorStart(nullptr));
    free(handle);
}

static int32_t SyncFunc(const char *srcFileName, const char *dstFileName)
{
    return 0;
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitorStackcoreInitFailed)
{
    MOCKER(LogMalloc).stubs().will(returnValue((void *)nullptr));
    EXPECT_EQ(LOG_FAILURE, StackcoreMonitorInit(SyncFunc));
    StackcoreMonitorExit();
    GlobalMockObject::verify();

    MOCKER(LogMalloc).stubs().will(invoke(MallocStub)).then(returnValue((void *)nullptr));
    EXPECT_EQ(LOG_FAILURE, StackcoreMonitorInit(SyncFunc));
    StackcoreMonitorExit();
    GlobalMockObject::verify();

    MOCKER(LogMalloc).stubs().will(invoke(MallocStub)).then(invoke(MallocStub)).then(returnValue((void *)nullptr));
    EXPECT_EQ(LOG_FAILURE, StackcoreMonitorInit(SyncFunc));
    StackcoreMonitorExit();
    GlobalMockObject::verify();

    MOCKER(LogMalloc).stubs().will(invoke(MallocStub)).then(invoke(MallocStub))
        .then(invoke(MallocStub)).then(returnValue((void *)nullptr));
    EXPECT_EQ(LOG_FAILURE, StackcoreMonitorInit(SyncFunc));
    StackcoreMonitorExit();
    GlobalMockObject::verify();
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitorStackcoreFailed)
{
    MOCKER(ToolMkdir).stubs().will(returnValue(-1));
    EXPECT_EQ(LOG_FAILURE, StackcoreMonitorInit(SyncFunc));
    StackcoreMonitorExit();
    GlobalMockObject::verify();

    MOCKER(ToolStatGet).stubs().will(returnValue(-1));
    system("mkdir -p " CORE_DEFAULT_PATH);
    system("mkdir -p " CORE_DEFAULT_PATH "udf");
    system("echo test > " CORE_DEFAULT_PATH "stackcore.slogd.11.1290318907");
    system("echo test > " CORE_DEFAULT_PATH "udf/stackcore.udf.11.1290318907");
    system("chmod 440 " CORE_DEFAULT_PATH "stackcore.slogd.11.1290318907");
    system("chmod 440 " CORE_DEFAULT_PATH "udf/stackcore.udf.11.1290318907");
    EXPECT_EQ(LOG_SUCCESS, StackcoreMonitorInit(SyncFunc));
    sleep(1);
    StackcoreMonitorExit();
    system("rm -rf " CORE_DEFAULT_PATH);
    GlobalMockObject::verify();

    system("mkdir -p " CORE_DEFAULT_PATH);
    system("mkdir -p " CORE_DEFAULT_PATH "udf");
    EXPECT_EQ(LOG_SUCCESS, StackcoreMonitorInit(SyncFunc));
    EXPECT_EQ(LOG_SUCCESS, StackcoreMonitorStart());
    system("echo test > " CORE_DEFAULT_PATH "stackcore.slogd.11.1290318907");
    system("echo test > " CORE_DEFAULT_PATH "udf/stackcore.udf.11.1290318907");
    system("chmod 440 " CORE_DEFAULT_PATH "stackcore.slogd.11.1290318907");
    system("chmod 440 " CORE_DEFAULT_PATH "udf/stackcore.udf.11.1290318907");
    sleep(1);
    StackcoreMonitorStop();
    StackcoreMonitorExit();
    GlobalMockObject::verify();

    system("mkdir -p " CORE_DEFAULT_PATH);
    system("mkdir -p " CORE_DEFAULT_PATH "udf");
    EXPECT_EQ(LOG_SUCCESS, StackcoreMonitorInit(SyncFunc));
    EXPECT_EQ(LOG_SUCCESS, StackcoreMonitorStart());
    MOCKER(LogMalloc).stubs().will(returnValue((void *)nullptr));
    system("echo test > " CORE_DEFAULT_PATH "stackcore.slogd.11.1290318907");
    system("echo test > " CORE_DEFAULT_PATH "udf/stackcore.udf.11.1290318907");
    system("chmod 440 " CORE_DEFAULT_PATH "stackcore.slogd.11.1290318907");
    system("chmod 440 " CORE_DEFAULT_PATH "udf/stackcore.udf.11.1290318907");
    sleep(1);
    StackcoreMonitorStop();
    StackcoreMonitorExit();
    GlobalMockObject::verify();
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitorStackcoreStartFailed)
{
    StackcoreMonitorStop();
    StackcoreMonitorExit();
    GlobalMockObject::verify();

    system("mkdir -p " CORE_DEFAULT_PATH);
    system("mkdir -p " CORE_DEFAULT_PATH "udf");
    EXPECT_EQ(LOG_SUCCESS, StackcoreMonitorInit(SyncFunc));
    MOCKER(inotify_add_watch).stubs().will(returnValue(-1));
    EXPECT_EQ(LOG_FAILURE, StackcoreMonitorStart());
    StackcoreMonitorStop();
    StackcoreMonitorExit();
    GlobalMockObject::verify();

    EXPECT_EQ(LOG_SUCCESS, StackcoreMonitorInit(SyncFunc));
    MOCKER(LogMalloc).stubs().will(returnValue((void *)nullptr));
    EXPECT_EQ(LOG_FAILURE, StackcoreMonitorStart());
    StackcoreMonitorStop();
    StackcoreMonitorExit();
    GlobalMockObject::verify();

    EXPECT_EQ(LOG_SUCCESS, StackcoreMonitorInit(SyncFunc));
    system("rm -rf " CORE_DEFAULT_PATH);
    EXPECT_EQ(LOG_FAILURE, StackcoreMonitorStart());
    StackcoreMonitorStop();
    StackcoreMonitorExit();
    GlobalMockObject::verify();
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitorSlogdlogStartFailed)
{
    EXPECT_EQ(LOG_FAILURE, SlogdlogMonitorInit(NULL));
    EXPECT_EQ(LOG_SUCCESS, SlogdlogMonitorInit(SyncFunc));
    MOCKER(EventAdd).stubs()
        .will(repeat((EventHandle)0x12345, 3))
        .then(returnValue((EventHandle)NULL));
    EXPECT_EQ(LOG_SUCCESS, SlogdlogMonitorStart());
    MOCKER(EventDelete).stubs().will(returnValue(LOG_FAILURE));
    SlogdlogMonitorStop();                              // EventDelete failed
    EXPECT_EQ(LOG_FAILURE, SlogdlogMonitorStart());     // SlogdlogMonitorScanStart failed
    EXPECT_EQ(LOG_FAILURE, SlogdlogMonitorStart());     // SlogdlogMonitorNotifyStart failed
    GlobalMockObject::verify();
    MOCKER(inotify_init1).stubs().will(returnValue(-1));
    EXPECT_EQ(LOG_FAILURE, SlogdlogMonitorStart());
    SlogdlogMonitorExit();
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitorDeviceAppStartFailed)
{
    EXPECT_EQ(LOG_FAILURE, DeviceAppMonitorInit(NULL));
    EXPECT_EQ(LOG_SUCCESS, DeviceAppMonitorInit(SyncFunc));
    MOCKER(EventAdd).stubs().will(returnValue((EventHandle)NULL));
    EXPECT_EQ(LOG_FAILURE, DeviceAppMonitorStart());
    DeviceAppMonitorExit();
}

static int32_t FileMonitorSync(const char *srcFileName, const char *dstFileName)
{
    return 0;
}

TEST_F(EP_FILE_MONITOR_FUNC_UTEST, FileMonitorSyncFileListFailed)
{
    system("mkdir -p " PATH_ROOT "/coredump/udf");
    EXPECT_EQ(FileMonitorSyncFileList(PATH_ROOT, "test", FileMonitorSync, 0), LOG_SUCCESS);
}
