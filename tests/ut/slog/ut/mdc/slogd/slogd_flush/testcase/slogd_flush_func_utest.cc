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
#include <iostream>
#include <fstream>
#include <string>

#include "slogd_flush.h"
#include "log_pm_sig.h"
#include "log_pm.h"
#include "slogd_config_mgr.h"
#include "log_system_api.h"
#include "slogd_group_log.h"
#include "slogd_syslog.h"
#include "slogd_eventlog.h"
#include "slogd_applog_core.h"
#include "slogd_flush_stub.h"
#include "self_log_stub.h"
#include "slogd_appnum_watch.h"
#include "slogd_recv_core.h"
#include "log_to_file.h"
#include "log_recv.h"
#include "slogd_write_limit.h"
#include "log_iam_pub.h"
#include "slogd_stub.h"
#include "zlib.h"
#include "slogd_compress.h"
#include "iam.h"
#include "log_pm_sr.h"

using namespace std;
using namespace testing;
extern "C"
{
extern int32_t ioctl(int32_t fd, uint32_t cmd, int32_t f);
extern void SlogSysStateHandler(int32_t state);
LogStatus SlogdLogClassifyInit(int32_t devId, bool isDocker);
void SlogdLogClassifyExit(void);
extern int32_t SlogdGroupLogWrite(const char *msg, uint32_t msgLen, const LogInfo *info);
extern int32_t SlogdGroupLogFlush(void *buffer, size_t bufferLen, bool flag);
extern bool LogAgentWriteLimitCheck(StSubLogFileList *subList, uint32_t dataLen);
void SlogdEventlogGet(SessionItem *handle, void *buffer, uint32_t bufferLen, int32_t devId);
void SlogdSysLogGet(SessionItem *handle, void *buffer, uint32_t bufferLen, int32_t devId);
extern int LogIamOpsIoctl(struct IAMMgrFile *file, unsigned cmd, struct IAMIoctlArg* arg);
extern enum IAMResourceStatus g_slogdCompressResStatus;
extern enum SystemState g_systemState;

char *LogGetRootPath(void);
extern StLogFileList g_fileList;
}

class MDC_SLOGD_FLUSH_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
        system("> " AOS_PM_STATUS_FILE);
        g_slogdCompressResStatus = IAM_RESOURCE_READY;
        g_systemState = WORKING;
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

#define BLOCK_SIZE          (1024 * 1024) // 1MB
static unsigned char g_deflateIn[BLOCK_SIZE] = { 0 };
static unsigned char g_deflateOut[BLOCK_SIZE] = { 0 };

static uint32_t LogGetFileSize(const char *fileName)
{
    struct stat statbuff;
    if (stat(fileName, &statbuff) == 0) {
        return (uint32_t)statbuff.st_size;
    }
    return 0U;
}

static void LogUnCompressFile(const char *fileName)
{
    char gzFileName[1024] = { 0 };
    char ungzFileName[1024] = { 0 };
    char cmd[1024] = { 0 };
    snprintf_s(ungzFileName, 1024, 1023, "%s", fileName);
    if (strstr(fileName, ".gz") != NULL) {
        snprintf_s(gzFileName, 1024, 1023, "%s", fileName);
        ungzFileName[strlen(fileName) - 3] = '\0';
    } else {
        snprintf_s(gzFileName, 1024, 1023, "%s.gz", fileName);
        snprintf_s(cmd, 1024, 1023, "mv %s %s", fileName, gzFileName);
        system(cmd);
    }
    FILE *in = fopen(gzFileName, "r");
    FILE *out = fopen(ungzFileName, "w");
    if ((in == nullptr) || (out == nullptr)) {
        printf("fopen failed.\n");
        return;
    }
    uint64_t decompressed_len = BLOCK_SIZE;
    while (feof(in) == 0) {
        memset_s(g_deflateIn, BLOCK_SIZE, 0, BLOCK_SIZE);
        memset_s(g_deflateOut, BLOCK_SIZE, 0, BLOCK_SIZE);
        decompressed_len = BLOCK_SIZE;
        fread(g_deflateIn, 1, 5000, in);
        int ret = uncompress(g_deflateOut, &decompressed_len, g_deflateIn, 5000);
        if (ret != 0) {
            printf("uncompress failed, ret = %d.\n", ret);
            break;
        }
        fwrite(g_deflateOut, decompressed_len, 1, out);
    }
    fclose(in);
    fclose(out);
}

static void SlogdUnCompressFile(const char *path)
{
    ToolDirent **nameList = NULL;
    int32_t totalNum = ToolScandir(path, &nameList, NULL, alphasort);
    char filePath[1024] = { 0 };
    for (int32_t i = 0; i < totalNum; i++) {
        if (nameList[i]->d_type == DT_DIR) {
            continue;
        }
        printf("nameList[i]->d_name=%s.\n", nameList[i]->d_name);
        memset_s(filePath, 1024, 0, 1024);
        snprintf_s(filePath, 1024, 1023, "%s/%s", path, nameList[i]->d_name);
        LogUnCompressFile(filePath);
    }
    ToolScandirFree(nameList, totalNum);
}

static void SlogdLogFileParse(void)
{
    SlogdUnCompressFile(LOG_FILE_PATH "/debug");
    SlogdUnCompressFile(LOG_FILE_PATH "/run/device-os");
    SlogdUnCompressFile(LOG_FILE_PATH "/run/device-app-all");
    SlogdUnCompressFile(LOG_FILE_PATH "/run/event");
    SlogdUnCompressFile(LOG_FILE_PATH "/security/device-os");
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, FlushSyslog)
{
    // 初始化
    LogRecordSigNo(0);
    char *path = FILE_DIR;
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(LogGetRootPath).stubs().will(returnValue(path));
    SlogdCreateCmdFile(100);
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogInit(-1, false));
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    ResChangeStatus(KMS_IAM_SERVICE_PATH, IAM_RESOURCE_READY);
    SlogSysStateHandler(WORKING);

    // 向buffer内写数据
    char msg[1024] = "test for slogd flush thread.\n";
    LogInfo msgInfo = { RUN_LOG, SYSTEM, 100, 0, CCE, 0, 3 };
    SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);
    msgInfo.type = SECURITY_LOG;
    SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);
    // 等待flush线程创建并运行
    sleep(2);

    EXPECT_EQ(1, SlogdGetPrintNum(FILE_DIR, "/run/device-os"));
    EXPECT_EQ(1, SlogdGetPrintNum(FILE_DIR, "/security/device-os"));
    EXPECT_EQ(0, GetErrLogNum());
    // 释放
    LogRecordSigNo(15);
    SlogdFlushExit();
    SlogdLogClassifyExit();
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, FlushSyslogSleep)
{
    // 初始化
    LogRecordSigNo(0);
    char *path = FILE_DIR;
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(LogGetRootPath).stubs().will(returnValue(path));
    MOCKER(ioctl).stubs().will(returnValue(0));
    SlogdCreateCmdFile(100);
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogInit(-1, false));
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    ResChangeStatus(KMS_IAM_SERVICE_PATH, IAM_RESOURCE_READY);
    SlogSysStateHandler(SLEEP);

    // 向buffer内写数据
    char msg[1024] = "test for slogd flush thread.\n";
    LogInfo msgInfo = { RUN_LOG, SYSTEM, 100, 0, CCE, 0, 3 };
    SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);
    // 等待flush线程创建并运行
    sleep(2);

    EXPECT_EQ(0, SlogdGetPrintNum(FILE_DIR, "/run/device-os"));
    EXPECT_EQ(0, GetErrLogNum());
    ResChangeStatus(KMS_IAM_SERVICE_PATH, IAM_RESOURCE_WAITING);
    SlogSysStateHandler(WORKING);
    // 释放
    LogRecordSigNo(15);
    SlogdFlushExit();
    SlogdLogClassifyExit();
}

// slogd main函数落盘分组日志，增加休眠唤醒订阅数量上限
TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, MainWithWakeupSubscribe)
{
    MOCKER(ioctl).stubs().will(returnValue(0));
    // 初始化
    LogRecordSigNo(0);
    char *path = FILE_DIR;
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(LogGetRootPath).stubs().will(returnValue(path));
    MOCKER(ioctl).stubs().will(returnValue(0));
    SlogdCreateCmdFile(100);
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogInit(-1, false));
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    ResChangeStatus(KMS_IAM_SERVICE_PATH, IAM_RESOURCE_READY);
    SlogSysStateHandler(SLEEP);

    // 向buffer内写数据
    char msg[1024] = "test for slogd flush thread.\n";
    LogInfo msgInfo = { RUN_LOG, SYSTEM, 100, 0, CCE, 0, 3 };
    SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);
    // 等待flush线程创建并运行
    sleep(2);
    int32_t pid = 0;
    // 如果触发重复订阅，此处会卡主，执行不到变更状态为WORKING。通过该项测试用例，验证slogd对重复订阅的处理。
    for (int32_t i = 0; i < 100; i++) {
        struct IAMIoctlArg iamArg;
        iamArg.size = PATH_MAX;
        iamArg.argData = (void *)&pid;
        LogIamOpsIoctl(NULL, IAM_CMD_FLUSH_LOG, &iamArg);
    }
    sleep(1);
    SlogSysStateHandler(WORKING);
    sleep(1);

    EXPECT_EQ(1, SlogdGetPrintNum(FILE_DIR, "/run/device-os"));
    EXPECT_EQ(0, GetErrLogNum());
    ResChangeStatus(KMS_IAM_SERVICE_PATH, IAM_RESOURCE_WAITING);
    SlogSysStateHandler(WORKING);
    // 释放
    LogRecordSigNo(15);
    SlogdFlushExit();
    SlogdLogClassifyExit();
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, FlushSyslogFull)
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
    SlogdCompressInit();
    ResChangeStatus(KMS_IAM_SERVICE_PATH, IAM_RESOURCE_READY);
    SlogSysStateHandler(WORKING);

    // 向buffer内写数据
    char msg[1024] = "test for slogd flush thread.\n";
    for (int i = 0; i < 10240; i++) {
        LogInfo msgInfo = { RUN_LOG, SYSTEM, 100, 0, CCE, 0, 3 };
        SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);
    }
    // 等待flush线程创建并运行
    sleep(2);
    SlogdLogFileParse();
    EXPECT_LT(1024, SlogdGetPrintNum(FILE_DIR, "/run/device-os"));
    EXPECT_EQ(0, GetErrLogNum());
    // 释放
    LogRecordSigNo(15);
    SlogdFlushExit();
    LogAgentCleanUpDevice(&g_fileList);
    SlogdLogClassifyExit();
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, FlushEventlog)
{
    // 初始化
    LogRecordSigNo(0);
    char *path = FILE_DIR;
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(LogGetRootPath).stubs().will(returnValue(path));
    SlogdCreateCmdFile(100);
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdEventlogInit(-1, false));
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    ResChangeStatus(KMS_IAM_SERVICE_PATH, IAM_RESOURCE_READY);
    SlogSysStateHandler(WORKING);

    // 向buffer内写数据
    char msg[1024] = "test for slogd flush event log.\n";
    LogInfo msgInfo = { RUN_LOG, SYSTEM, 100, 0, 0, 0, 0x10 };
    SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);
    // 等待flush线程创建并运行
    sleep(2);
    EXPECT_EQ(1, SlogdGetPrintNum(FILE_DIR, "/run/event"));
    EXPECT_EQ(0, GetErrLogNum());
    // 释放
    LogRecordSigNo(15);
    SlogdFlushExit();
    SlogdLogClassifyExit();
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, FlushEventlogFull)
{
    // 初始化
    system("sed -i 's/WriteLimitSwitch=1/WriteLimitSwitch=0/g' " SLOG_CONF_FILE_PATH);
    LogRecordSigNo(0);
    system("mkdir -p " FILE_DIR "/run/event/");
    const char *logTest = "test log rotate";
    FILE *fp = fopen(FILE_DIR "/run/event/event_132329477_act.log.gz", "w");
    fwrite(logTest, strlen(logTest), 1, fp);
    fclose(fp);
    fp = fopen(FILE_DIR "/run/event/event_132329478.log", "w");
    fwrite(logTest, strlen(logTest), 1, fp);
    fclose(fp);
    fp = fopen(FILE_DIR "/run/event/event_132329479.log.gz", "w");
    fwrite(logTest, strlen(logTest), 1, fp);
    fclose(fp);
    char *path = FILE_DIR;
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(LogGetRootPath).stubs().will(returnValue(path));
    SlogdCreateCmdFile(100);
    SlogSysStateHandler(WORKING);
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdEventlogInit(-1, false));
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInit(&g_fileList));
    EXPECT_EQ(LOG_SUCCESS, SlogdEventMgrInit(&g_fileList));
    SlogdCompressInit();
    ResChangeStatus(KMS_IAM_SERVICE_PATH, IAM_RESOURCE_READY);
    SlogSysStateHandler(WORKING);

    // 向buffer内写数据
    char msg[1024] = "test for slogd flush event log.\n";
    for (int i = 0; i < 10240; i++) {
        LogInfo msgInfo = { RUN_LOG, SYSTEM, 100, 0, 0, 0, 0x10 };
        SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);
    }
    // 等待flush线程创建并运行
    sleep(2);
    SlogdLogFileParse();
    EXPECT_LT(1024, SlogdGetPrintNum(FILE_DIR, "/run/event"));
    EXPECT_EQ(0, GetErrLogNum());
    // 释放
    LogRecordSigNo(15);
    SlogdFlushExit();
    LogAgentCleanUpDevice(&g_fileList);
    SlogdLogClassifyExit();
    system("sed -i 's/WriteLimitSwitch=0/WriteLimitSwitch=1/g' " SLOG_CONF_FILE_PATH);
}

static int32_t SlogdCheckLog(char *msg)
{
    char resultFile[200];
    sprintf(resultFile, "%s/resultFile.txt", PATH_ROOT);
    char cmd[200];
    sprintf(cmd, "grep -rn \"%s\" %s | wc -l > %s", msg, FILE_DIR, resultFile);
    system(cmd);

    char buf[MSG_LENGTH] = {0};
    FILE *fp = fopen(resultFile, "r");
    if (fp == nullptr) {
        return false;
    }
    int size = fread(buf, 1, MSG_LENGTH, fp);
    fclose(fp);
    if (size == 0) {
        return 0;
    } else {
        return atoi(buf);
    }
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, FlushApplog)
{
    // 初始化
    LogRecordSigNo(0);
    char *path = FILE_DIR;
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(LogGetRootPath).stubs().will(returnValue(path));
    system("mkdir -p " FILE_DIR "/run/device-app-all/");
    const char *logTest = "test log rotate";
    FILE *fp = fopen(FILE_DIR "/run/device-app-all/device-app_202501123455.log", "w");
    fwrite(logTest, strlen(logTest), 1, fp);
    fclose(fp);
    SlogdCreateCmdFile(100);
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdApplogInit(0));
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    ResChangeStatus(KMS_IAM_SERVICE_PATH, IAM_RESOURCE_READY);
    SlogSysStateHandler(WORKING);

    // 向buffer内写数据
    char msg[1024] = "test for slogd flush app log.\n";
    LogInfo msgInfo = { RUN_LOG, APPLICATION, 100, 0, 0, 0, DLOG_INFO };
    SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);
    // 等待flush线程创建并运行
    sleep(2);
    SlogdUnCompressFile(LOG_FILE_PATH "/run/device-app-all");
    EXPECT_EQ(2, SlogdGetPrintNum(FILE_DIR, "/run/device-app-all"));
    EXPECT_EQ(1, SlogdCheckLog("rotate"));
    EXPECT_EQ(0, GetErrLogNum());
    // 释放
    LogRecordSigNo(15);
    SlogdFlushExit();
    SlogdLogClassifyExit();
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, FlushApplogHandleOpenNull)
{
    // 初始化
    LogRecordSigNo(0);
    char *path = FILE_DIR;
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(LogGetRootPath).stubs().will(returnValue(path));
    MOCKER(SlogdBufferHandleOpen).stubs().will(returnValue((void*)NULL));
    SlogdCreateCmdFile(100);
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdApplogInit(0));
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    ResChangeStatus(KMS_IAM_SERVICE_PATH, IAM_RESOURCE_READY);
    SlogSysStateHandler(WORKING);

    // 向buffer内写数据
    char msg[1024] = "test for slogd flush app log.\n";
    LogInfo msgInfo = { RUN_LOG, APPLICATION, 100, 0, 0, 0, DLOG_INFO };
    SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);
    // 等待flush线程创建并运行
    sleep(2);
    SlogdLogFileParse();
    EXPECT_EQ(0, SlogdGetPrintNum(FILE_DIR, "/run/device-app-100"));
    // 释放
    LogRecordSigNo(15);
    SlogdFlushExit();
    SlogdLogClassifyExit();
}

static int32_t AppLogDirFilterCommon(const ToolDirent *dir)
{
    ONE_ACT_NO_LOG(dir == NULL, return FILTER_NOK);
    if ((dir->d_type == DT_DIR) && (LogStrStartsWith(dir->d_name, "device-app") != false)) {
        return FILTER_OK;
    }
    return FILTER_NOK;
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, FlushApplogFull)
{
    // 初始化
    system("sed -i 's/WriteLimitSwitch=1/WriteLimitSwitch=0/g' " SLOG_CONF_FILE_PATH);
    LogRecordSigNo(0);
    char *path = FILE_DIR;
    system("mkdir -p " FILE_DIR "/run/device-app-100/");
    system("echo test > " FILE_DIR "/run/device-app-100/device-app-100_202501123455.log");
    system("mkdir -p " FILE_DIR "/run/device-app-101/");
    system("echo test > " FILE_DIR "/run/device-app-101/device-app-101_202501123455.log");
    system("mkdir -p " FILE_DIR "/run/device-app-102/");
    system("echo test > " FILE_DIR "/run/device-app-102/device-app-102_202501123455.log");
    system("mkdir -p " FILE_DIR "/run/device-app-103/");
    system("echo test > " FILE_DIR "/run/device-app-103/device-app-103_202501123455.log");
    MOCKER(LogGetRootPath).stubs().will(returnValue(path));
    SlogdCreateCmdFile(100);
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdApplogInit(0));
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    ResChangeStatus(KMS_IAM_SERVICE_PATH, IAM_RESOURCE_READY);
    SlogSysStateHandler(WORKING);

    // 向buffer内写数据
    char msg[1024] = "test for slogd flush app log, test for slogd flush app log.\n \
    test for slogd flush app log, test for slogd flush app log.\n   \
    test for slogd flush app log, test for slogd flush app log.\n   \
    test for slogd flush app log, test for slogd flush app log.\n   \
    test for slogd flush app log, test for slogd flush app log.\n   \
    test for slogd flush app log, test for slogd flush app log.\n   \
    test for slogd flush app log, test for slogd flush app log.\n   \
    test for slogd flush app log, test for slogd flush app log.\n";
    for (int i = 0; i < 1024000; i++) {
        LogInfo msgInfo = { RUN_LOG, APPLICATION, 100, 0, 0, 0, DLOG_INFO };
        SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);
    }

    // 等待flush线程创建并运行
    sleep(2);
    EXPECT_EQ(0, GetErrLogNum());
    char pathRun[1024] = { 0 };
    snprintf(pathRun, 1024, "%s/run/", FILE_DIR);
    ToolDirent **nameList = NULL;
    int32_t totalNum = ToolScandir(pathRun, &nameList, AppLogDirFilterCommon, alphasort);
    EXPECT_EQ(1, totalNum);
    EXPECT_EQ(0, strcmp(nameList[0]->d_name, "device-app-all"));
    ToolScandirFree(nameList, totalNum);
    EXPECT_LT(1024, SlogdGetPrintNum(FILE_DIR, "/run/device-app-all"));
    // 释放
    LogRecordSigNo(15);
    SlogdFlushExit();
    SlogdLogClassifyExit();
    system("sed -i 's/WriteLimitSwitch=0/WriteLimitSwitch=1/g' " SLOG_CONF_FILE_PATH);
}

static int32_t GEFileFilter(const ToolDirent *dir)
{
    ONE_ACT_NO_LOG(dir == NULL, return FILTER_NOK);
    if (LogStrStartsWith(dir->d_name, "GE_") && strstr(dir->d_name, ".gz") == NULL) {
        return FILTER_OK;
    }
    return FILTER_NOK;
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, SlogdGroupLogFlushWithOutFile)
{
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdGroupLogInit());

    system("mkdir -p /tmp/mdc610_slogd_A1SUs28SDBwhdcus/log/");

    char msg[1024] = "test for slogd flush group log\n";
    LogInfo msgInfo = { DEBUG_LOG, SYSTEM, 100, 0, GE, 0, 3 };
    SlogdGroupLogWrite(msg, strlen(msg), &msgInfo);
    SlogdGroupLogFlush(nullptr, 0, false);

    SlogdLogFileParse();

    ToolDirent **nameList = NULL;
    char path[1024] = { 0 };
    snprintf_s(path, 1024, 1023, "/tmp/mdc610_slogd_A1SUs28SDBwhdcus/log/debug/");
    int32_t totalNum = ToolScandir(path, &nameList, GEFileFilter, alphasort);
    EXPECT_EQ(1, totalNum);
    strncat_s(path, 1024, nameList[0]->d_name, strlen(nameList[0]->d_name));
    ToolScandirFree(nameList, totalNum);

    FILE *fp = fopen(path, "r");
    char msgOut[1024] = { 0 };
    fread(msgOut, 1, 1024, fp);
    fclose(fp);
    EXPECT_STREQ(msg, msgOut);

    SlogdGroupLogExit();
    SlogdFlushExit();
    SlogdConfigMgrExit();
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, SlogdLogGetStub)
{
    SlogdEventlogGet(nullptr, nullptr, 0, 0);
    SlogdSysLogGet(nullptr, nullptr, 0, 0);
    SlogdFirmwareLogGet(nullptr, nullptr, 0, 0);
    EXPECT_EQ(0, GetErrLogNum());
}

const char *g_label = "debug/TOOLS";
TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, SlogdWriteLimitPeriod0OverLimit)
{
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    WriteFileLimit *limit = NULL;
    const uint32_t baseBytes = 1024U;
    EXPECT_EQ(LOG_SUCCESS, WriteFileLimitInit(&limit, DEBUG_LOG, 150*baseBytes, 150*baseBytes));
    EXPECT_NE((void *)NULL, limit);
    EXPECT_EQ(7735345U, limit->writeSpecification);
    // period 0
    uint32_t dataLen = limit->writeSpecification * 1.8 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(limit, dataLen, g_label));
    EXPECT_EQ(false, WriteFileLimitCheck(limit, 10, g_label));
    // period 1
    limit->startTime.tv_sec -= 3600 + 1;
    dataLen = limit->writeSpecification * 0.8 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(limit, dataLen, g_label));
    EXPECT_EQ(false, WriteFileLimitCheck(limit, 10, g_label));
    // period 2
    limit->startTime.tv_sec -= 3600 + 1;
    dataLen = limit->writeSpecification * 0.8 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(limit, dataLen, g_label));
    EXPECT_EQ(false, WriteFileLimitCheck(limit, 10, g_label));
    // period 3
    limit->startTime.tv_sec -= 3600 + 1;
    dataLen = limit->writeSpecification * 0.8 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(limit, dataLen, g_label));
    EXPECT_EQ(false, WriteFileLimitCheck(limit, 10, g_label));
    // period 4
    limit->startTime.tv_sec -= 3600 + 1;
    dataLen = limit->writeSpecification * 0.8 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(limit, dataLen, g_label));
    EXPECT_EQ(false, WriteFileLimitCheck(limit, 10, g_label));

    WriteFileLimitUnInit(&limit);
    SlogdFlushExit();
    SlogdConfigMgrExit();
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, SlogdWriteLimitPeriod1OverLimit)
{
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    WriteFileLimit *limit = NULL;
    const uint32_t baseBytes = 1024U;
    EXPECT_EQ(LOG_SUCCESS, WriteFileLimitInit(&limit, DEBUG_LOG, 150*baseBytes, 150*baseBytes));
    EXPECT_NE((void *)NULL, limit);
    EXPECT_EQ(7735345U, limit->writeSpecification);
    // period 0
    // period 1
    limit->startTime.tv_sec -= 3600 + 1;
    uint32_t dataLen = limit->writeSpecification * 2.6 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(limit, dataLen, g_label));
    EXPECT_EQ(false, WriteFileLimitCheck(limit, 10, g_label));
    // period 2
    limit->startTime.tv_sec -= 3600 + 1;
    dataLen = limit->writeSpecification * 0.8 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(limit, dataLen, g_label));
    EXPECT_EQ(false, WriteFileLimitCheck(limit, 10, g_label));
    // period 3
    limit->startTime.tv_sec -= 3600 + 1;
    dataLen = limit->writeSpecification * 0.8 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(limit, dataLen, g_label));
    EXPECT_EQ(false, WriteFileLimitCheck(limit, 10, g_label));
    // period 4
    limit->startTime.tv_sec -= 3600 + 1;
    dataLen = limit->writeSpecification * 0.8 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(limit, dataLen, g_label));
    EXPECT_EQ(false, WriteFileLimitCheck(limit, 10, g_label));

    WriteFileLimitUnInit(&limit);
    SlogdFlushExit();
    SlogdConfigMgrExit();
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, SlogdWriteLimitPeriod2OverLimit)
{
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    WriteFileLimit *limit = NULL;
    const uint32_t baseBytes = 1024U;
    EXPECT_EQ(LOG_SUCCESS, WriteFileLimitInit(&limit, DEBUG_LOG, 150*baseBytes, 150*baseBytes));
    EXPECT_NE((void *)NULL, limit);
    EXPECT_EQ(7735345U, limit->writeSpecification);
    // period 0
    // period 1
    limit->startTime.tv_sec -= 3600 + 1;
    // period 2
    limit->startTime.tv_sec -= 3600 + 1;
    uint32_t dataLen = limit->writeSpecification * 3.4 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(limit, dataLen, g_label));
    EXPECT_EQ(false, WriteFileLimitCheck(limit, 10, g_label));
    // period 3
    limit->startTime.tv_sec -= 3600 + 1;
    dataLen = limit->writeSpecification * 0.8 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(limit, dataLen, g_label));
    EXPECT_EQ(false, WriteFileLimitCheck(limit, 10, g_label));
    // period 4
    limit->startTime.tv_sec -= 3600 + 1;
    dataLen = limit->writeSpecification * 0.8 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(limit, dataLen, g_label));
    EXPECT_EQ(false, WriteFileLimitCheck(limit, 10, g_label));

    WriteFileLimitUnInit(&limit);
    SlogdConfigMgrExit();
    SlogdFlushExit();
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, SlogdWriteLimitPeriod3OverLimit)
{
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    WriteFileLimit *limit = NULL;
    const uint32_t baseBytes = 1024U;
    EXPECT_EQ(LOG_SUCCESS, WriteFileLimitInit(&limit, DEBUG_LOG, 150*baseBytes, 150*baseBytes));
    EXPECT_NE((void *)NULL, limit);
    EXPECT_EQ(7735345U, limit->writeSpecification);
    // period 0
    // period 1
    limit->startTime.tv_sec -= 3600 + 1;
    // period 2
    limit->startTime.tv_sec -= 3600 + 1;
    // period 3
    limit->startTime.tv_sec -= 3600 + 1;
    uint32_t dataLen = limit->writeSpecification * 4.2 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(limit, dataLen, g_label));
    EXPECT_EQ(false, WriteFileLimitCheck(limit, 10, g_label));
    // period 4
    limit->startTime.tv_sec -= 3600 + 1;
    dataLen = limit->writeSpecification * 0.8 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(limit, dataLen, g_label));
    EXPECT_EQ(false, WriteFileLimitCheck(limit, 10, g_label));

    WriteFileLimitUnInit(&limit);
    SlogdFlushExit();
    SlogdConfigMgrExit();
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, SlogdWriteLimitPeriod4OverLimit)
{
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    WriteFileLimit *limit = NULL;
    const uint32_t baseBytes = 1024U;
    EXPECT_EQ(LOG_SUCCESS, WriteFileLimitInit(&limit, DEBUG_LOG, 150*baseBytes, 150*baseBytes));
    EXPECT_NE((void *)NULL, limit);
    EXPECT_EQ(7735345U, limit->writeSpecification);
    // period 0
    // period 1
    limit->startTime.tv_sec -= 3600 + 1;
    // period 2
    limit->startTime.tv_sec -= 3600 + 1;
    // period 3
    limit->startTime.tv_sec -= 3600 + 1;
    // period 4
    limit->startTime.tv_sec -= 3600 + 1;
    uint32_t dataLen = limit->writeSpecification * 5 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(limit, dataLen, g_label));
    EXPECT_EQ(false, WriteFileLimitCheck(limit, 10, g_label));

    WriteFileLimitUnInit(&limit);
    SlogdFlushExit();
    SlogdConfigMgrExit();
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, SlogdWriteLimitPeriod5OverLimit)
{
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    WriteFileLimit *limit = NULL;
    const uint32_t baseBytes = 1024U;
    EXPECT_EQ(LOG_SUCCESS, WriteFileLimitInit(&limit, DEBUG_LOG, 150*baseBytes, 150*baseBytes));
    EXPECT_NE((void *)NULL, limit);
    EXPECT_EQ(7735345U, limit->writeSpecification);
    // period 0
    // period 1
    limit->startTime.tv_sec -= 3600 + 1;
    // period 2
    limit->startTime.tv_sec -= 3600 + 1;
    // period 3
    limit->startTime.tv_sec -= 3600 + 1;
    // period 4
    limit->startTime.tv_sec -= 3600 + 1;
    // period 5, new check window
    limit->startTime.tv_sec -= 3600 + 1;
    uint32_t dataLen = limit->writeSpecification * 2;
    EXPECT_EQ(false, WriteFileLimitCheck(limit, dataLen, g_label));

    WriteFileLimitUnInit(&limit);
    GlobalMockObject::verify();

    EXPECT_EQ(LOG_SUCCESS, WriteFileLimitInit(&limit, DEBUG_LOG, 150*baseBytes, 150*baseBytes));
    EXPECT_NE((void *)NULL, limit);
    EXPECT_EQ(7735345U, limit->writeSpecification);
    // period 0
    // period 1
    limit->startTime.tv_sec -= 3600 + 1;
    // period 2
    limit->startTime.tv_sec -= 3600 + 1;
    // period 3
    limit->startTime.tv_sec -= 3600 + 1;
    // period 4
    limit->startTime.tv_sec -= 3600 + 1;
    // period 5, new check window
    limit->startTime.tv_sec -= 3600 + 1;
    dataLen = limit->writeSpecification * 1.8 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(limit, dataLen, g_label));

    WriteFileLimitUnInit(&limit);
    SlogdFlushExit();
    SlogdConfigMgrExit();
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, SlogdWriteLimitNoAffectEachOther)
{
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    WriteFileLimit *limit = NULL;
    const uint32_t baseBytes = 1024U;
    EXPECT_EQ(LOG_SUCCESS, WriteFileLimitInit(&limit, DEBUG_LOG, 150*baseBytes, 150*baseBytes));
    EXPECT_NE((void *)NULL, limit);
    EXPECT_EQ(7735345U, limit->writeSpecification);
    uint32_t dataLen = limit->writeSpecification * 1.8 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(limit, dataLen, g_label));
    EXPECT_EQ(false, WriteFileLimitCheck(limit, 10, g_label));
    // another limit
    WriteFileLimit *newLimit = NULL;
    EXPECT_EQ(LOG_SUCCESS, WriteFileLimitInit(&newLimit, DEBUG_LOG, 150*baseBytes, 150*baseBytes));
    EXPECT_NE((void *)NULL, newLimit);
    EXPECT_EQ(7735345U, newLimit->writeSpecification);
    dataLen = newLimit->writeSpecification * 1.8 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(newLimit, dataLen, g_label));
    EXPECT_EQ(false, WriteFileLimitCheck(newLimit, 10, g_label));

    WriteFileLimitUnInit(&limit);
    WriteFileLimitUnInit(&newLimit);
    SlogdFlushExit();
    SlogdConfigMgrExit();
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, SlogdWriteLimitConfigChange)
{
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    WriteFileLimit *limit = NULL;
    EXPECT_EQ(LOG_SUCCESS, WriteFileLimitInit(&limit, SECURITY_LOG, 1024000, 512000));
    EXPECT_NE((void *)NULL, limit);
    EXPECT_EQ(1546650U*0.5, limit->writeSpecification);
    WriteFileLimitUnInit(&limit);
    EXPECT_EQ(LOG_SUCCESS, WriteFileLimitInit(&limit, SECURITY_LOG, 1000000, 512000));
    EXPECT_NE((void *)NULL, limit);
    EXPECT_LT(1546650U*0.5, limit->writeSpecification);
    WriteFileLimitUnInit(&limit);
    SlogdFlushExit();
    SlogdConfigMgrExit();
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, SlogdWriteLimitTimeChange)
{
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    WriteFileLimit *limit = NULL;
    const uint32_t baseBytes = 1024U;
    EXPECT_EQ(LOG_SUCCESS, WriteFileLimitInit(&limit, DEBUG_LOG, 150*baseBytes, 150*baseBytes));
    EXPECT_NE((void *)NULL, limit);
    EXPECT_EQ(7735345U, limit->writeSpecification);
    // period 0
    uint32_t dataLen = limit->writeSpecification * 1.8 - 1;
    EXPECT_EQ(true, WriteFileLimitCheck(limit, dataLen, g_label));
    EXPECT_EQ(false, WriteFileLimitCheck(limit, 10, g_label));
    system("date 010100002100");
    EXPECT_EQ(false, WriteFileLimitCheck(limit, 10, g_label));
    WriteFileLimitUnInit(&limit);
    SlogdFlushExit();
    SlogdConfigMgrExit();
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, LogAgentWriteLimitCheckDebug)
{
    StSubLogFileList subInfo = { 0 };
    subInfo.maxFileSize = 1U * 1024U * 1024U;
    subInfo.totalMaxFileSize = 10U * 1024U * 1024U;
    snprintf_s(subInfo.filePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "/tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/");
    snprintf_s(subInfo.fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "device-0_");
    EXPECT_EQ(true, (LogAgentWriteLimitCheck(&subInfo, 100)));
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, LogAgentWriteLimitCheckRun)
{
    StSubLogFileList subInfo = { 0 };
    subInfo.maxFileSize = 1U * 1024U * 1024U;
    subInfo.totalMaxFileSize = 10U * 1024U * 1024U;
    snprintf_s(subInfo.filePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "/tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/run/device-os");
    snprintf_s(subInfo.fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "device-os_");
    EXPECT_EQ(true, (LogAgentWriteLimitCheck(&subInfo, 100)));
}

TEST_F(MDC_SLOGD_FLUSH_FUNC_UTEST, LogAgentWriteLimitCheckSecurity)
{
    StSubLogFileList subInfo = { 0 };
    subInfo.maxFileSize = 1U * 1024U * 1024U;
    subInfo.totalMaxFileSize = 10U * 1024U * 1024U;
    snprintf_s(subInfo.filePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "/tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/security/device-os");
    snprintf_s(subInfo.fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "device-os_");
    EXPECT_EQ(true, (LogAgentWriteLimitCheck(&subInfo, 100)));
}