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

#include "slogd_flush.h"
#include "log_pm_sig.h"
#include "log_pm.h"
#include "slogd_flush_stub.h"
#include "self_log_stub.h"
#include "slogd_group_log.h"
#include "slogd_syslog.h"
#include "slogd_appnum_watch.h"
#include "slogd_config_mgr.h"
#include "log_to_file.h"
#include "log_path_mgr.h"
#include "slogd_applog_core.h"
#include "slogd_eventlog.h"
#include "slogd_syslog.h"
#include "iam.h"
#include "log_iam_pub.h"
#include "slogd_stub.h"
#include "ascend_hal_stub.h"
#include "log_file_util.h"

extern "C"
{
    int32_t SlogdLogClassifyInit(int32_t devId, bool isDocker);
    void SlogdLogClassifyExit(void);
    extern int32_t SlogdGroupLogWrite(const char *msg, uint32_t msgLen, const LogInfo *info);
    extern int32_t SlogdGroupLogFlush(void *buffer, size_t bufferLen, bool flag);
    extern bool LogAgentWriteLimitCheck(StSubLogFileList *subList, uint32_t dataLen);
    extern void SlogSysStateHandler(int32_t state);
    extern StLogFileList g_fileList;
}
using namespace std;
using namespace testing;

class MDC_SLOGD_FLUSH_EXCP_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
        MOCKER(CreateAppLogWatchThread).stubs();
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

public:
    void SlogdCreateCmdFile(int32_t clockId)
    {
        FILE *fp = fopen(BOOTARGS_FILE_PATH, "w");
        uint32_t length = 1024;
        char msg[length];
        snprintf_s(msg, length, length - 1, "[MDC_SLOGD_FLUSH_FUNC_UTEST][Log] test for dpclk=%d", clockId);
        fwrite(msg, length, 1, fp);
        fclose(fp);
    }
    int SlogdCmdGetIntRet(const char *path, const char*cmd)
    {
        char resultFile[200] = {0};
        sprintf(resultFile, "%s/MDC_SLOGD_FLUSH_FUNC_UTEST_cmd_result.txt", path);

        char cmdToFile[400] = {0};
        sprintf(cmdToFile, "%s > %s", cmd, resultFile);
        system(cmdToFile);

        char buf[100] = {0};
        FILE *fp = fopen(resultFile, "r");
        if (fp == NULL) {
            return 0;
        }
        int size = fread(buf, 1, 100, fp);
        fclose(fp);
        if (size == 0) {
            return 0;
        }
        return atoi(buf);
    }

    int32_t SlogdGetPrintNum(const char *path, const char *dir)
    {
        char cmd[200] = {0};
        sprintf(cmd, " cat %s/%s/* | wc -l", path, dir);

        int ret = SlogdCmdGetIntRet(path, cmd);
        return ret;
    }

};

static void *MallocStub(size_t len)
{
    void *buf = malloc(len);
    (void)memset_s(buf, len, 0, len);
    return buf;
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, FlushApplogFullMallocFailed)
{
    // 初始化
    LogRecordSigNo(0);
    char *path = FILE_DIR;
    MOCKER(LogGetRootPath).stubs().will(returnValue(path));
    SlogdCreateCmdFile(100);
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdApplogInit(0));
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    MOCKER(LogMalloc).stubs()
        .will(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(returnValue((void *)NULL))
        .then(invoke(MallocStub));
    
    // 向buffer内写数据
    char msg[1024] = "test for slogd flush app log.\n";
    for (int i = 0; i < 10240; i++) {
        LogInfo msgInfo = { RUN_LOG, APPLICATION, 100, 0, 0, 0, DLOG_INFO };
        SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);
    }
    // 等待flush线程创建并运行
    sleep(2);

    EXPECT_NE(0, GetErrLogNum());
    // 释放
    LogRecordSigNo(15);
    SlogdFlushExit();
    SlogdLogClassifyExit();
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, FlushApplogMallocFailed)
{
    // 初始化
    LogRecordSigNo(0);
    char *path = FILE_DIR;
    MOCKER(LogGetRootPath).stubs().will(returnValue(path));
    SlogdCreateCmdFile(100);
    SlogdConfigMgrInit();
    MOCKER(LogMalloc).stubs()
        .will(returnValue((void *)NULL));
    EXPECT_EQ(LOG_FAILURE, SlogdApplogInit(0));
    SlogdConfigMgrExit();
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, FlushEventlogFullMallocFailed)
{
    // 初始化
    LogRecordSigNo(0);
    char *path = FILE_DIR;
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(LogGetRootPath).stubs().will(returnValue(path));
    SlogdCreateCmdFile(100);
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdEventlogInit(-1, false));
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInit(&g_fileList));
    EXPECT_EQ(LOG_SUCCESS, SlogdEventMgrInit(&g_fileList));
    MOCKER(LogMalloc).stubs()
        .will(invoke(MallocStub))
        .then(returnValue((void *)NULL))
        .then(invoke(MallocStub));

    // 向buffer内写数据
    char msg[1024] = "test for slogd flush event log.\n";
    for (int i = 0; i < 10240; i++) {
        LogInfo msgInfo = { RUN_LOG, SYSTEM, 100, 0, 0, 0, 0x10 };
        SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);
    }
    // 等待flush线程创建并运行
    sleep(2);

    EXPECT_EQ(1, GetErrLogNum());
    // 释放
    LogRecordSigNo(15);
    SlogdFlushExit();
    LogAgentCleanUpDevice(&g_fileList);
    SlogdLogClassifyExit();
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, FlushSyslogFullMallocFailed)
{
    // 初始化
    LogRecordSigNo(0);
    char *path = FILE_DIR;
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(LogGetRootPath).stubs().will(returnValue(path));
    SlogdCreateCmdFile(100);
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogInit(-1, false));
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInit(&g_fileList));
    MOCKER(LogMalloc).stubs()
        .will(invoke(MallocStub))
        .then(returnValue((void *)NULL))
        .then(invoke(MallocStub));

    // 向buffer内写数据
    char msg[1024] = "test for slogd flush thread.\n";
    for (int i = 0; i < 10240; i++) {
        LogInfo msgInfo = { RUN_LOG, SYSTEM, 100, 0, CCE, 0, 3 };
        SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);
    }
    // 等待flush线程创建并运行
    sleep(2);

    EXPECT_EQ(1, GetErrLogNum());
    // 释放
    LogRecordSigNo(15);
    SlogdFlushExit();
    LogAgentCleanUpDevice(&g_fileList);
    SlogdLogClassifyExit();
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, FlushSyslogFailed)
{
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogInit(0, true));
    SlogdLogClassifyExit();
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, InitSyslogMallocFailed)
{
    SlogdConfigMgrInit();
    MOCKER(LogMalloc).stubs()
        .will(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(returnValue((void *)NULL));
    EXPECT_EQ(LOG_FAILURE, SlogdSyslogInit(-1, false));
    SlogdSyslogExit();
    SlogdConfigMgrExit();
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, SlogdLogClassifyInit)
{
    int32_t devId = 0;
    bool isDocker = false;
    MOCKER(SlogdSyslogInit).stubs().will(returnValue(LOG_FAILURE));
    EXPECT_EQ(LOG_FAILURE, SlogdLogClassifyInit(devId, isDocker));
    SlogdLogClassifyExit();
    GlobalMockObject::verify();

    MOCKER(SlogdGroupLogInit).stubs().will(returnValue(LOG_FAILURE));
    EXPECT_EQ(LOG_FAILURE, SlogdLogClassifyInit(devId, isDocker));
    SlogdLogClassifyExit();
    GlobalMockObject::verify();
}

static void *LogMallocStub(size_t size)
{
    void *buf = malloc(size);
    memset_s(buf, size, 0, size);
    return buf;
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, InitDeviceAppMallocFailed)
{
    system("mkdir -p " LOG_FILE_PATH);
    system("mkdir -p " LOG_FILE_PATH "/run/device-app-100/");
    system("echo test > " LOG_FILE_PATH "/run/device-app-100/device-app-100_202501123455.log");
    system("mkdir -p " LOG_FILE_PATH "/run/device-app-101/");
    system("echo test > " LOG_FILE_PATH "/run/device-app-101/device-app-101_202501123455.log");
    SlogdConfigMgrInit();
    StLogFileList list = { 0 };
    (void)snprintf_s(list.aucFilePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s", LOG_FILE_PATH);
    MOCKER(LogMalloc).stubs().will(returnValue((void *)NULL)).then(invoke(LogMallocStub));
    EXPECT_EQ(LOG_SUCCESS, LogAgentInitDeviceApplication(&list));
    EXPECT_EQ(1, GetErrLogNum());
    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        WriteFileLimitUnInit(&list.sortDeviceAppLogList[i].limit);
    }
    SlogdConfigMgrExit();
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, InitWriteFileLimitMallocFailed)
{
    system("mkdir -p " LOG_FILE_PATH);
    system("mkdir -p " LOG_FILE_PATH "/run/device-app-100/");
    system("echo test > " LOG_FILE_PATH "/run/device-app-100/device-app-100_202501123455.log");
    system("mkdir -p " LOG_FILE_PATH "/run/device-app-101/");
    system("echo test > " LOG_FILE_PATH "/run/device-app-101/device-app-101_202501123455.log");
    SlogdConfigMgrInit();
    StLogFileList list = { 0 };
    (void)snprintf_s(list.aucFilePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s", LOG_FILE_PATH);
    MOCKER(LogMalloc).stubs().will(returnValue((void *)NULL));
    EXPECT_EQ(LOG_FAILURE, LogAgentInitDeviceApplication(&list));
    EXPECT_EQ(3, GetErrLogNum());
    SlogdConfigMgrExit();
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, InitDeviceAppSnprintfFailed)
{
    system("mkdir -p " LOG_FILE_PATH);
    system("mkdir -p " LOG_FILE_PATH "/run/device-app-100/");
    system("echo test > " LOG_FILE_PATH "/run/device-app-100/device-app-100_202501123455.log");
    system("mkdir -p " LOG_FILE_PATH "/run/device-app-101/");
    system("echo test > " LOG_FILE_PATH "/run/device-app-101/device-app-101_202501123455.log");
    SlogdConfigMgrInit();
    StLogFileList list = { 0 };
    (void)snprintf_s(list.aucFilePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s", LOG_FILE_PATH);
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    EXPECT_EQ(LOG_FAILURE, LogAgentInitDeviceApplication(&list));
    SlogdConfigMgrExit();
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, SlogdFlushInitAppFailed)
{
    system("mkdir -p " LOG_FILE_PATH);
    system("mkdir -p " LOG_FILE_PATH "/run/device-app-100/");
    system("echo test > " LOG_FILE_PATH "/run/device-app-100/device-app-100_202501123455.log");
    system("mkdir -p " LOG_FILE_PATH "/run/device-app-101/");
    system("echo test > " LOG_FILE_PATH "/run/device-app-101/device-app-101_202501123455.log");
    SlogdConfigMgrInit();
    MOCKER(LogAgentInitDeviceApplication).stubs()
        .will(returnValue(LOG_FAILURE));
    EXPECT_EQ(LOG_FAILURE, SlogdFlushInit());
    SlogdFlushExit();
    SlogdConfigMgrExit();
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, SlogdFlushInitCompressFailed)
{
    system("mkdir -p " LOG_FILE_PATH);
    system("mkdir -p " LOG_FILE_PATH "/run/device-app-100/");
    system("echo test > " LOG_FILE_PATH "/run/device-app-100/device-app-100_202501123455.log");
    system("mkdir -p " LOG_FILE_PATH "/run/device-app-101/");
    system("echo test > " LOG_FILE_PATH "/run/device-app-101/device-app-101_202501123455.log");
    SlogdConfigMgrInit();
    MOCKER(IAMRegResStatusChangeCb).stubs()
        .will(returnValue(LOG_FAILURE));
    EXPECT_EQ(LOG_FAILURE, SlogdFlushInit());
    SlogdFlushExit();
    SlogdConfigMgrExit();
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, FlushEventlogInitClassNameFailed)
{
    // 初始化
    LogRecordSigNo(0);
    char *path = FILE_DIR;
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(LogGetRootPath).stubs().will(returnValue(path));
    SlogdCreateCmdFile(100);
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdEventlogInit(-1, false));
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    EXPECT_EQ(LOG_FAILURE, SlogdEventMgrInit(&g_fileList));

    // 释放
    LogAgentCleanUpDevice(&g_fileList);
    SlogdLogClassifyExit();
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, FlushEventlogInitFileHeadFailed)
{
    LogRecordSigNo(0);
    char *path = FILE_DIR;
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(LogGetRootPath).stubs().will(returnValue(path));
    SlogdCreateCmdFile(100);
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdEventlogInit(-1, false));
    MOCKER(LogStrlen).stubs().will(returnValue((uint32_t)0));
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    EXPECT_EQ(LOG_FAILURE, SlogdEventMgrInit(&g_fileList));

    // 释放
    LogAgentCleanUpDevice(&g_fileList);
    SlogdLogClassifyExit();
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, FlushEventlogInitGetListFailed)
{
    LogRecordSigNo(0);
    char *path = FILE_DIR;
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(LogGetRootPath).stubs().will(returnValue(path));
    SlogdCreateCmdFile(100);
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdEventlogInit(-1, false));
    MOCKER(ToolAccess).stubs().will(returnValue(0));
    MOCKER(ToolScandir).stubs().will(returnValue(-1));
    EXPECT_EQ(LOG_FAILURE, SlogdEventMgrInit(&g_fileList));
    EXPECT_EQ(2, GetErrLogNum());

    // 释放
    LogAgentCleanUpDevice(&g_fileList);
    SlogdLogClassifyExit();
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, SlogdWriteLimitDropSize)
{
    WriteFileLimit *limit = NULL;
    const uint32_t baseBytes = 1024U;
    const char *label = "debug/GE";
    EXPECT_EQ(LOG_SUCCESS, WriteFileLimitInit(&limit, DEBUG_LOG, 150*baseBytes, 150*baseBytes));
    EXPECT_NE((void *)NULL, limit);
    EXPECT_EQ(7735345U, limit->writeSpecification);
    uint32_t dataLen = limit->writeSpecification * 1.8 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(limit, dataLen, label));
    EXPECT_EQ(false, WriteFileLimitCheck(limit, UINT32_MAX -1, label));
    EXPECT_EQ(false, WriteFileLimitCheck(limit, 10, label));
    EXPECT_EQ(false, WriteFileLimitCheck(limit, 10, label));
    limit->startTime.tv_sec -= 3600 + 1;
    dataLen = limit->writeSpecification * 0.8 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(limit, dataLen, label));

    WriteFileLimitUnInit(&limit);
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, SlogdWriteLimitGetSpecTypeFailed)
{
    WriteFileLimit *limit = NULL;
    const uint32_t baseBytes = 1024U;
    const char *label = "debug/GE";
    EXPECT_EQ(LOG_INVALID_PARAM, WriteFileLimitInit(&limit, LOG_TYPE_NUM, 150*baseBytes, 150*baseBytes));
    EXPECT_EQ((void *)NULL, limit);
    WriteFileLimitUnInit(&limit);
}

int32_t g_timeErrIndex = 0;
int32_t clock_gettime_error_stub(clockid_t clock_id, struct timespec *tp)
{
    if (g_timeErrIndex > 0) {
        static long nsec = 0;
        nsec += 200 * 1000000; // 200ms
        tp->tv_nsec = nsec;
        g_timeErrIndex--;
        return 0;
    }
    return -1;
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, SlogdWriteLimitInitFailed)
{
    g_timeErrIndex = 0;
    MOCKER(clock_gettime).stubs().will(invoke(clock_gettime_error_stub));
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdGroupLogInit());
    SlogdGroupLogExit();
    SlogdConfigMgrExit();
    GlobalMockObject::verify();
    g_timeErrIndex = 0;
    MOCKER(clock_gettime).stubs().will(invoke(clock_gettime_error_stub));
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_FAILURE, SlogdFlushInit());
    SlogdFlushExit();
    SlogdConfigMgrExit();
    GlobalMockObject::verify();
    g_timeErrIndex = 2;
    MOCKER(clock_gettime).stubs().will(invoke(clock_gettime_error_stub));
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_FAILURE, SlogdFlushInit());
    SlogdFlushExit();
    SlogdConfigMgrExit();
    GlobalMockObject::verify();
    g_timeErrIndex = 130;
    MOCKER(clock_gettime).stubs().will(invoke(clock_gettime_error_stub));
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_FAILURE, SlogdFlushInit());
    SlogdFlushExit();
    SlogdConfigMgrExit();
    GlobalMockObject::verify();
    g_timeErrIndex = 131;
    MOCKER(clock_gettime).stubs().will(invoke(clock_gettime_error_stub));
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_FAILURE, SlogdFlushInit());
    SlogdFlushExit();
    SlogdConfigMgrExit();
    GlobalMockObject::verify();
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, FlushSyslogCompressFailed)
{
    // 初始化
    LogRecordSigNo(0);
    char *path = FILE_DIR;
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(LogGetRootPath).stubs().will(returnValue(path));
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogInit(-1, false));
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    ResChangeStatus(KMS_IAM_SERVICE_PATH, IAM_RESOURCE_READY);
    SlogSysStateHandler(WORKING);
    MOCKER(hw_deflateInit2_).stubs().will(returnValue(-1));

    // 向buffer内写数据
    char msg[1024] = "test for slogd flush thread.\n";
    LogInfo msgInfo = { RUN_LOG, SYSTEM, 100, 0, CCE, 0, 3 };
    SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);
    // 等待flush线程创建并运行
    sleep(2);

    EXPECT_EQ(0, SlogdGetPrintNum(FILE_DIR, "/run/device-os"));
    EXPECT_NE(0, GetErrLogNum());
    // 释放
    LogRecordSigNo(15);
    SlogdFlushExit();
    SlogdLogClassifyExit();
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, SlogdWriteLimitSprintfFailed)
{
    MOCKER(vsprintf_s).stubs().will(returnValue(-1));
    StSubLogFileList subInfoFirst = { 0 };
    subInfoFirst.maxFileSize = 1U * 1024U * 1024U;
    subInfoFirst.totalMaxFileSize = 10U * 1024U * 1024U;
    snprintf_s(subInfoFirst.filePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "/tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/");
    snprintf_s(subInfoFirst.fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "device-0_");
    EXPECT_EQ(false, (LogAgentWriteLimitCheck(&subInfoFirst, 100)));
    GlobalMockObject::verify();
    MOCKER(vsprintf_s).stubs().will(returnValue(-1));
    StSubLogFileList subInfoSecond = { 0 };
    subInfoSecond.maxFileSize = 1U * 1024U * 1024U;
    subInfoSecond.totalMaxFileSize = 10U * 1024U * 1024U;
    snprintf_s(subInfoSecond.filePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "/tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/security/device-os");
    snprintf_s(subInfoSecond.fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "device-os_");
    EXPECT_EQ(false, (LogAgentWriteLimitCheck(&subInfoSecond, 100)));
    GlobalMockObject::verify();
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, SlogdWriteLimitStrrchrFailed)
{
    StSubLogFileList subInfoFirst = { 0 };
    subInfoFirst.maxFileSize = 1U * 1024U * 1024U;
    subInfoFirst.totalMaxFileSize = 10U * 1024U * 1024U;
    snprintf_s(subInfoFirst.filePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "device-os");
    snprintf_s(subInfoFirst.fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "device-os_");
    EXPECT_EQ(false, (LogAgentWriteLimitCheck(&subInfoFirst, 100)));
    GlobalMockObject::verify();
    StSubLogFileList subInfoSecond = { 0 };
    subInfoSecond.maxFileSize = 1U * 1024U * 1024U;
    subInfoSecond.totalMaxFileSize = 10U * 1024U * 1024U;
    snprintf_s(subInfoSecond.filePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "security/device-os");
    snprintf_s(subInfoSecond.fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "device-os_");
    EXPECT_EQ(false, (LogAgentWriteLimitCheck(&subInfoSecond, 100)));
    GlobalMockObject::verify();
}

TEST_F(MDC_SLOGD_FLUSH_EXCP_UTEST, SlogdWriteLimitCheckFailed)
{
    MOCKER(WriteFileLimitCheck).stubs().will(returnValue(false));
    MOCKER(LogMkdir).stubs().will(returnValue(SUCCESS));
    StSubLogFileList stubInfo = { 0 };
    stubInfo.maxFileSize = 1U * 1024U * 1024U;
    stubInfo.totalMaxFileSize = 10U * 1024U * 1024U;
    snprintf_s(stubInfo.filePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "/tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/security/device-os");
    snprintf_s(stubInfo.fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "device-os_");
    StLogDataBlock stLogData;
    stLogData.paucData = "hi, all. APP,pid is 0, My name is IDEDD.";
    stLogData.ulDataLen = 40U;
    EXPECT_EQ(OK, LogAgentWriteFile(&stubInfo, &stLogData));
}