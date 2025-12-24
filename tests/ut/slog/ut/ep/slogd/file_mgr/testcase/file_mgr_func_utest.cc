/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "self_log_stub.h"
#include "log_to_file.h"
#include "slogd_config_mgr.h"
#include "slogd_flush.h"
#include "log_file_util.h"
#include "slogd_eventlog.h"
#include "slogd_syslog.h"
#include "slogd_compress.h"
#include "log_compress/log_compress.h"

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
using namespace std;
using namespace testing;

class EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("rm -rf " PATH_ROOT "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        EXPECT_EQ(0, GetErrLogNum());
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("mkdir -p " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }

public:
    int DlogCmdGetIntRet(const char *path, const char*cmd)
    {
        char resultFile[200] = {0};
        sprintf(resultFile, "%s/EP_SLOGD_FUNC_STEST_cmd_result.txt", path);

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

    int DlogCheckDir(const char *path, const char *str)
    {
        if (access(path, F_OK) != 0) {
            return 0;
        }

        char cmd[200] = {0};
        sprintf(cmd, "ls %s | grep %s | wc -l", path, str);
        int ret = DlogCmdGetIntRet(PATH_ROOT, cmd);
        return ret;
    }
};

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentGetFileListForModuleOs)
{
    // 创建文件列表
    char cmd[1024] = { 0 };
    for (int32_t i = 0; i < 5; i++) {
        memset_s(cmd, 1024, 0, 1024);
        snprintf_s(cmd, 1024, 1023, "test > %s/device-os_202312190876%d.log", PATH_ROOT, i);
        system(cmd);
    }
    // 获取最新文件
    StSubLogFileList subInfo = { 0 };
    subInfo.maxFileSize = 1U * 1024U * 1024U;
    subInfo.totalMaxFileSize = 10U * 1024U * 1024U;
    snprintf_s(subInfo.filePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s", PATH_ROOT);
    snprintf_s(subInfo.fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "device-os");
    EXPECT_EQ(OK, LogAgentGetFileListForModule(&subInfo, PATH_ROOT));
    EXPECT_STREQ("device-os_2023121908764.log", subInfo.fileName);
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentGetFileListForModuleApp)
{
    // 创建文件列表
    char cmd[1024] = { 0 };
    for (int32_t i = 0; i < 5; i++) {
        memset_s(cmd, 1024, 0, 1024);
        snprintf_s(cmd, 1024, 1023, "test > %s/device-os_202312190876%d.log", PATH_ROOT, i);
        system(cmd);
    }
    // 获取最新文件
    StSubLogFileList subInfo = { 0 };
    subInfo.maxFileSize = 1U * 1024U * 1024U;
    subInfo.totalMaxFileSize = 10U * 1024U * 1024U;
    snprintf_s(subInfo.filePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s", PATH_ROOT);
    snprintf_s(subInfo.fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "device-app");
    EXPECT_EQ(OK, LogAgentGetFileListForModule(&subInfo, PATH_ROOT));
    EXPECT_EQ(0U, strlen(subInfo.fileName));
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentInitMaxFileNumHelper)
{
    StSubLogFileList subInfo = { 0 };
    subInfo.maxFileSize = 1U * 1024U * 1024U;
    subInfo.totalMaxFileSize = 10U * 1024U * 1024U;
    snprintf_s(subInfo.fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "device-os_");
    EXPECT_EQ(OK, LogAgentInitMaxFileNumHelper(&subInfo, PATH_ROOT, strlen(PATH_ROOT)));
    EXPECT_STREQ(PATH_ROOT, subInfo.filePath);
    EXPECT_EQ(0, strlen(subInfo.fileName));
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, SlogdSyslogMgrInit)
{
    // 初始化
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    // 创建文件列表
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/run/device-os");
    char cmd[1024] = { 0 };
    for (int32_t i = 0; i < 5; i++) {
        memset_s(cmd, 1024, 0, 1024);
        snprintf_s(cmd, 1024, 1023, "test > /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/run/device-os/device-os_202312190876%d.log", i);
        system(cmd);
    }
    StLogFileList fileList = { 0 };
    snprintf_truncated_s(fileList.aucFilePath, MAX_FILEDIR_LEN + 1U, "%s", LOG_FILE_PATH);
    LogAgentGetCfg(&fileList);
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInit(&fileList));

    // check fileList info
    EXPECT_EQ(2, fileList.maxOsFileNum);
    EXPECT_EQ(1048576, fileList.ulMaxOsFileSize);
    EXPECT_EQ(2, fileList.maxAppFileNum);
    EXPECT_EQ(524288, fileList.ulMaxAppFileSize);
    EXPECT_EQ(2, fileList.maxNdebugFileNum);
    EXPECT_EQ(1048576, fileList.ulMaxNdebugFileSize);
    EXPECT_EQ(8, fileList.maxFileNum);
    EXPECT_EQ(2097152, fileList.ulMaxFileSize);
    EXPECT_STREQ("/tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog", fileList.aucFilePath);

    // check device-os info
    EXPECT_EQ(1048576, fileList.sortDeviceOsLogList[0].totalMaxFileSize);
    EXPECT_EQ(1048576, fileList.sortDeviceOsLogList[0].maxFileSize);
    EXPECT_EQ(SECURITY_FILE_SIZE, fileList.sortDeviceOsLogList[1].totalMaxFileSize);
    EXPECT_EQ(SECURITY_FILE_SIZE, fileList.sortDeviceOsLogList[1].maxFileSize);
    EXPECT_EQ(1048576, fileList.sortDeviceOsLogList[2].totalMaxFileSize);
    EXPECT_EQ(1048576, fileList.sortDeviceOsLogList[2].maxFileSize);
    char deviceOsLogPath[MAX_FILEPATH_LEN + 1U] = { 0 };
    const char* sortDirName[(int32_t)LOG_TYPE_NUM] = { DEBUG_DIR_NAME, SECURITY_DIR_NAME, RUN_DIR_NAME };
    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        memset_s(deviceOsLogPath, MAX_FILEPATH_LEN + 1U, 0, MAX_FILEPATH_LEN + 1U);
        snprintf_s(deviceOsLogPath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s%s%s%s%s",
                   fileList.aucFilePath, FILE_SEPARATOR, sortDirName[i], FILE_SEPARATOR, DEVICE_OS_HEAD);
        EXPECT_STREQ("device-os_", fileList.sortDeviceOsLogList[i].fileHead);
        EXPECT_STREQ(deviceOsLogPath, fileList.sortDeviceOsLogList[i].filePath);
    }
    EXPECT_EQ(0, strlen(fileList.sortDeviceOsLogList[0].fileName));
    EXPECT_EQ(0, strlen(fileList.sortDeviceOsLogList[1].fileName));
    EXPECT_STREQ("device-os_2023121908764.log", fileList.sortDeviceOsLogList[2].fileName);
    LogAgentCleanUpDevice(&fileList);
    SlogdConfigMgrExit();
}

static int32_t OsFileFilter(const ToolDirent *dir)
{
    ONE_ACT_NO_LOG(dir == NULL, return FILTER_NOK);
    if (LogStrStartsWith(dir->d_name, "device-os")) {
        return FILTER_OK;
    }
    return FILTER_NOK;
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentWriteDeviceOsLogWithoutFile)
{
    StSubLogFileList subInfo = { 0 };
    subInfo.maxFileSize = 1U * 1024U * 1024U;
    subInfo.totalMaxFileSize = 10U * 1024U * 1024U;
    snprintf_s(subInfo.filePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "/tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-os");
    snprintf_s(subInfo.fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "device-os_");
    char msg[1024] = "test write to deviceos log";
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/");
    EXPECT_EQ(OK, LogAgentWriteDeviceOsLog(DEBUG_LOG, &subInfo, msg, 1024));

    // check file msg
    ToolDirent **nameList = NULL;
    int32_t totalNum = ToolScandir(subInfo.filePath, &nameList, OsFileFilter, alphasort);
    EXPECT_EQ(1, totalNum);
    char path[1024] = { 0 };
    snprintf_s(path, 1024, 1023, "%s/%s", subInfo.filePath, nameList[0]->d_name);
    ToolScandirFree(nameList, totalNum);
    FILE *fp = fopen(path, "r");
    char msgOut[1024] = { 0 };
    fread(msgOut, 1, 1024, fp);
    fclose(fp);
    EXPECT_STREQ(msg, msgOut);
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentWriteDeviceOsLog)
{
    StSubLogFileList subInfo = { 0 };
    subInfo.maxFileSize = 1U * 1024U * 1024U;
    subInfo.totalMaxFileSize = 10U * 1024U * 1024U;
    snprintf_s(subInfo.filePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "/tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-os");
    snprintf_s(subInfo.fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "device-os_");
    snprintf_s(subInfo.fileName, MAX_FILENAME_LEN + 1U, MAX_FILENAME_LEN, "device-os_202312190876.log");
    char msg[1024] = "test write to deviceos log";
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/");
    EXPECT_EQ(OK, LogAgentWriteDeviceOsLog(DEBUG_LOG, &subInfo, msg, 1024));

    // check file msg
    char path[1024] = { 0 };
    snprintf_s(path, 1024, 1023, "%s/%s", subInfo.filePath, subInfo.fileName);
    FILE *fp = fopen(path, "r");
    char msgOut[1024] = { 0 };
    fread(msgOut, 1, 1024, fp);
    fclose(fp);
    EXPECT_STREQ(msg, msgOut);
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentWriteDeviceOsLogAging)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog");
    StLogFileList *fileList = GetGlobalLogFileList();
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInit(fileList));

    // write to file
    char msg[1024] = "test write to os log, test write to os log, test write to os log, \
                      test write to os log, test write to os log, test write to os log, \
                      test write to os log, test write to os log, test write to os log, \
                      test write to os log, test write to os log, test write to os log, \
                      test write to os log, test write to os log, test write to os log.";
    for (int32_t i = 0; i < 10240; i++) {
        EXPECT_EQ(OK, LogAgentWriteDeviceOsLog(DEBUG_LOG, &fileList->sortDeviceOsLogList[DEBUG_LOG], msg, strlen(msg)));
    }

    ToolDirent **nameList = NULL;
    char path[1024] = { 0 };
    int32_t totalNum = ToolScandir(fileList->sortDeviceOsLogList[DEBUG_LOG].filePath, &nameList, OsFileFilter, alphasort);
    EXPECT_EQ(2, totalNum);
    ToolScandirFree(nameList, totalNum);

    LogAgentCleanUpDevice(fileList);
    SlogdConfigMgrExit();
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentWriteDeviceOsLogAgingWithOriFile)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-os");
    system("> /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-os/device-os_201212192434133.log");
    StLogFileList *fileList = GetGlobalLogFileList();
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInit(fileList));

    // write to file
    char msg[1024] = "test write to os log, test write to os log, test write to os log, \
                      test write to os log, test write to os log, test write to os log, \
                      test write to os log, test write to os log, test write to os log, \
                      test write to os log, test write to os log, test write to os log, \
                      test write to os log, test write to os log, test write to os log.";
    for (int32_t i = 0; i < 10240; i++) {
        EXPECT_EQ(OK, LogAgentWriteDeviceOsLog(DEBUG_LOG, &fileList->sortDeviceOsLogList[DEBUG_LOG], msg, strlen(msg)));
    }

    ToolDirent **nameList = NULL;
    char path[1024] = { 0 };
    int32_t totalNum = ToolScandir(fileList->sortDeviceOsLogList[DEBUG_LOG].filePath, &nameList, OsFileFilter, alphasort);
    EXPECT_EQ(2, totalNum);
    ToolScandirFree(nameList, totalNum);
    EXPECT_EQ(SYS_ERROR, ToolAccess("/tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-os/device-os_201212192434133.log"));
    LogAgentCleanUpDevice(fileList);
    SlogdConfigMgrExit();
}

static int32_t DeviceFileFilter(const ToolDirent *dir)
{
    ONE_ACT_NO_LOG(dir == NULL, return FILTER_NOK);
    if (LogStrStartsWith(dir->d_name, "device-0")) {
        return FILTER_OK;
    }
    return FILTER_NOK;
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentInitDeviceWithoutFile)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    StLogFileList logList = { 0 };
    LogAgentGetCfg(&logList);
    EXPECT_EQ(OK, LogAgentInitDevice(&logList, MAX_DEV_NUM));
    char cmd[1024] = { 0 };
    snprintf_s(cmd, 1024, 1023, "mkdir -p %s", logList.deviceLogList[DEBUG_LOG]->filePath);
    system(cmd);
    char msg[1024] = "test write to device log";
    DeviceWriteLogInfo logInfo = { strlen(msg), 0, DEBUG_LOG, LP };
    EXPECT_EQ(OK, LogAgentWriteDeviceLog(&logList, msg, &logInfo));
    // check file msg
    ToolDirent **nameList = NULL;
    int32_t totalNum = ToolScandir(logList.deviceLogList[DEBUG_LOG]->filePath, &nameList, DeviceFileFilter, alphasort);
    EXPECT_EQ(1, totalNum);
    char path[1024] = { 0 };
    snprintf_s(path, 1024, 1023, "%s/%s", logList.deviceLogList[DEBUG_LOG]->filePath, nameList[0]->d_name);
    ToolScandirFree(nameList, totalNum);
    FILE *fp = fopen(path, "r");
    char msgOut[1024] = { 0 };
    fread(msgOut, 1, 1024, fp);
    fclose(fp);
    EXPECT_STREQ(msg, msgOut);

    LogAgentCleanUpDevice(&logList);
    SlogdConfigMgrExit();
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentInitDevice)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    StLogFileList logList = { 0 };
    LogAgentGetCfg(&logList);
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-0");
    system("> /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-0/device-0_2023121902341.log");
    EXPECT_EQ(OK, LogAgentInitDevice(&logList, MAX_DEV_NUM));
    char msg[1024] = "test write to device log";
    DeviceWriteLogInfo logInfo = { strlen(msg), 0, DEBUG_LOG, LP };
    EXPECT_EQ(OK, LogAgentWriteDeviceLog(&logList, msg, &logInfo));
    // check file msg
    char path[1024] = { 0 };
    snprintf_s(path, 1024, 1023, "%s/device-0_2023121902341.log", logList.deviceLogList[DEBUG_LOG]->filePath);
    FILE *fp = fopen(path, "r");
    char msgOut[1024] = { 0 };
    fread(msgOut, 1, 1024, fp);
    fclose(fp);
    EXPECT_STREQ(msg, msgOut);

    LogAgentCleanUpDevice(&logList);
    SlogdConfigMgrExit();
}

static int32_t AppLogDirFilter(const ToolDirent *dir)
{
    ONE_ACT_NO_LOG(dir == NULL, return FILTER_NOK);
    if ((dir->d_type == DT_DIR) &&
        ((LogStrStartsWith(dir->d_name, DEVICE_APP_HEAD) != false) ||
         (LogStrStartsWith(dir->d_name, AOS_CORE_DEVICE_APP_HEAD) != false))) {
        return FILTER_OK;
    }
    return FILTER_NOK;
}

static int32_t AppFileFilter(const ToolDirent *dir)
{
    ONE_ACT_NO_LOG(dir == NULL, return FILTER_NOK);
    if (LogStrStartsWith(dir->d_name, "device-app")) {
        return FILTER_OK;
    }
    return FILTER_NOK;
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentWriteDeviceApplicationLogWithOutFile)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog");
    char msg[1024] = "test write to device app log";
    LogInfo info = { DEBUG_LOG, APPLICATION, 0, 0, AICPU, 0, 3 };
    StLogFileList *fileList = GetGlobalLogFileList();
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInit(fileList));
    EXPECT_EQ(OK, LogAgentWriteDeviceApplicationLog(msg, strlen(msg), &info, fileList));

    ToolDirent **nameList = NULL;
    char path[1024] = { 0 };
    snprintf_s(path, 1024, 1023, "%s/debug/", fileList->aucFilePath);
    int32_t totalNum = ToolScandir(path, &nameList, AppLogDirFilter, alphasort);
    EXPECT_EQ(1, totalNum);
    strncat_s(path, 1024, nameList[0]->d_name, strlen(nameList[0]->d_name));
    ToolScandirFree(nameList, totalNum);

    // check file msg
    ToolDirent **nameList1 = NULL;
    totalNum = ToolScandir(path, &nameList1, AppFileFilter, alphasort);
    EXPECT_EQ(1, totalNum);
    strncat_s(path, 1024, "/", strlen("/"));
    strncat_s(path, 1024, nameList1[0]->d_name, strlen(nameList1[0]->d_name));
    ToolScandirFree(nameList1, totalNum);

    FILE *fp = fopen(path, "r");
    char msgOut[1024] = { 0 };
    fread(msgOut, 1, 1024, fp);
    fclose(fp);
    EXPECT_STREQ(msg + 1, msgOut);
    LogAgentCleanUpDevice(fileList);
    SlogdConfigMgrExit();
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentWriteDeviceApplicationLog)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-app-0/");
    system("> /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-app-0/device-app-0_2023121902342.log");
    char msg[1024] = "test write to device app log";
    LogInfo info = { DEBUG_LOG, APPLICATION, 0, 0, AICPU, 0, 3 };
    StLogFileList *fileList = GetGlobalLogFileList();
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInit(fileList));
    EXPECT_EQ(OK, LogAgentWriteDeviceApplicationLog(msg, strlen(msg), &info, fileList));

    FILE *fp = fopen("/tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-app-0/device-app-0_2023121902342.log", "r");
    char msgOut[1024] = { 0 };
    fread(msgOut, 1, 1024, fp);
    fclose(fp);
    EXPECT_STREQ(msg + 1, msgOut);
    LogAgentCleanUpDevice(fileList);
    SlogdConfigMgrExit();
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentWriteDeviceApplicationLogWith)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-app-0/");
    system("> /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-app-0/device-app-0_2023121902342.log");
    char msg[1024] = "[ERROR]test write to device app log";
    LogInfo info = { DEBUG_LOG, APPLICATION, 0, 0, AICPU, 0, 3 };
    StLogFileList *fileList = GetGlobalLogFileList();
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInit(fileList));
    EXPECT_EQ(OK, LogAgentWriteDeviceApplicationLog(msg, strlen(msg), &info, fileList));

    FILE *fp = fopen("/tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-app-0/device-app-0_2023121902342.log", "r");
    char msgOut[1024] = { 0 };
    fread(msgOut, 1, 1024, fp);
    fclose(fp);
    EXPECT_STREQ(msg, msgOut);
    LogAgentCleanUpDevice(fileList);
    SlogdConfigMgrExit();
}

static int32_t EventFileFilter(const ToolDirent *dir)
{
    ONE_ACT_NO_LOG(dir == NULL, return FILTER_NOK);
    if (LogStrStartsWith(dir->d_name, "event_")) {
        return FILTER_OK;
    }
    return FILTER_NOK;
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentWriteEventLogWithoutFile)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog");
    char msg[1024] = "test write to event log";
    StLogFileList *fileList = GetGlobalLogFileList();
    (void)memset_s((void *)fileList, sizeof(StLogFileList), 0, sizeof(StLogFileList));
    snprintf_truncated_s(fileList->aucFilePath, MAX_FILEDIR_LEN + 1U, "%s", LOG_FILE_PATH);
    LogAgentGetCfg(fileList);
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInit(fileList));
    EXPECT_EQ(LOG_SUCCESS, SlogdEventMgrInit(fileList));
    EXPECT_EQ(OK, LogAgentWriteEventLog(&fileList->eventLogList, msg, strlen(msg)));

    ToolDirent **nameList = NULL;
    char path[1024] = { 0 };
    int32_t totalNum = ToolScandir(fileList->eventLogList.filePath, &nameList, EventFileFilter, alphasort);
    EXPECT_EQ(1, totalNum);
    snprintf_s(path, 1024, 1023, "%s/%s", fileList->eventLogList.filePath, nameList[0]->d_name);
    ToolScandirFree(nameList, totalNum);

    FILE *fp = fopen(path, "r");
    char msgOut[1024] = { 0 };
    fread(msgOut, 1, 1024, fp);
    fclose(fp);
    EXPECT_STREQ(msg, msgOut);
    LogAgentCleanUpDevice(fileList);
    SlogdConfigMgrExit();
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentWriteEventLog)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/run/event/");
    system("> /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/run/event/event_201212192434133.log");
    char msg[1024] = "test write to event log";
    StLogFileList *fileList = GetGlobalLogFileList();
    (void)memset_s((void *)fileList, sizeof(StLogFileList), 0, sizeof(StLogFileList));
    snprintf_truncated_s(fileList->aucFilePath, MAX_FILEDIR_LEN + 1U, "%s", LOG_FILE_PATH);
    LogAgentGetCfg(fileList);
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInit(fileList));
    EXPECT_EQ(LOG_SUCCESS, SlogdEventMgrInit(fileList));
    EXPECT_EQ(OK, LogAgentWriteEventLog(&fileList->eventLogList, msg, strlen(msg)));

    FILE *fp = fopen("/tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/run/event/event_201212192434133.log", "r");
    char msgOut[1024] = { 0 };
    fread(msgOut, 1, 1024, fp);
    fclose(fp);
    EXPECT_STREQ(msg, msgOut);
    LogAgentCleanUpDevice(fileList);
    SlogdConfigMgrExit();
}

static void CheckFileMode(char *path, char *fileName, mode_t mode)
{
    char file[1024] = { 0 };
    snprintf_s(file, 1024, 1023, "%s/%s", path, fileName);
    struct stat buf;
    stat(file, &buf);
    EXPECT_EQ(mode, buf.st_mode & 0770);
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentWriteEventLogAging)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog");
    StLogFileList *fileList = GetGlobalLogFileList();
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInit(fileList));
    EXPECT_EQ(LOG_SUCCESS, SlogdEventMgrInit(fileList));

    // write to file
    char msg[1024] = "test write to event log, test write to event log, test write to event log, \
                      test write to event log, test write to event log, test write to event log, \
                      test write to event log, test write to event log, test write to event log, \
                      test write to event log, test write to event log, test write to event log, \
                      test write to event log, test write to event log, test write to event log.";
    for (int32_t i = 0; i < 10240; i++) {
        EXPECT_EQ(OK, LogAgentWriteEventLog(&fileList->eventLogList, msg, strlen(msg)));
    }

    ToolDirent **nameList = NULL;
    char path[1024] = { 0 };
    int32_t totalNum = ToolScandir(fileList->eventLogList.filePath, &nameList, EventFileFilter, alphasort);
    EXPECT_EQ(2, totalNum);
    CheckFileMode(fileList->eventLogList.filePath, nameList[0]->d_name, S_IRUSR | S_IRGRP); // 440
    CheckFileMode(fileList->eventLogList.filePath, nameList[1]->d_name, S_IRUSR | S_IWUSR | S_IRGRP); // 640
    ToolScandirFree(nameList, totalNum);
    LogAgentCleanUpDevice(fileList);
    SlogdConfigMgrExit();
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentWriteEventLogAgingWithOriFile)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/run/event/");
    system("> /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/run/event/event_201212192434133.log");
    StLogFileList *fileList = GetGlobalLogFileList();
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInit(fileList));
    EXPECT_EQ(LOG_SUCCESS, SlogdEventMgrInit(fileList));

    // write to file
    char msg[1024] = "test write to event log, test write to event log, test write to event log, \
                      test write to event log, test write to event log, test write to event log, \
                      test write to event log, test write to event log, test write to event log, \
                      test write to event log, test write to event log, test write to event log, \
                      test write to event log, test write to event log, test write to event log.";
    for (int32_t i = 0; i < 10240; i++) {
        EXPECT_EQ(OK, LogAgentWriteEventLog(&fileList->eventLogList, msg, strlen(msg)));
    }

    ToolDirent **nameList = NULL;
    char path[1024] = { 0 };
    int32_t totalNum = ToolScandir(fileList->eventLogList.filePath, &nameList, EventFileFilter, alphasort);
    EXPECT_EQ(2, totalNum);
    CheckFileMode(fileList->eventLogList.filePath, nameList[0]->d_name, S_IRUSR | S_IRGRP); // 440
    CheckFileMode(fileList->eventLogList.filePath, nameList[1]->d_name, S_IRUSR | S_IWUSR | S_IRGRP); // 640
    ToolScandirFree(nameList, totalNum);

    EXPECT_EQ(SYS_ERROR, ToolAccess("/tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/run/event/event_201212192434133.log"));
    LogAgentCleanUpDevice(fileList);
    SlogdConfigMgrExit();
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentWriteDeviceOsLogAgingWithConf)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceOsMaxFileNum *= *.*/DeviceOsMaxFileNum=1/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceOsNdebugMaxFileNum *= *.*/DeviceOsNdebugMaxFileNum=1/g' " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog");
    StLogFileList *fileList = GetGlobalLogFileList();
    (void)memset_s((void *)fileList, sizeof(StLogFileList), 0, sizeof(StLogFileList));
    snprintf_truncated_s(fileList->aucFilePath, MAX_FILEDIR_LEN + 1U, "%s", LOG_FILE_PATH);
    LogAgentGetCfg(fileList);
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInit(fileList));

    // write to file
    char msg[1024] = "test write to os log, test write to os log, test write to os log, \
                      test write to os log, test write to os log, test write to os log, \
                      test write to os log, test write to os log, test write to os log, \
                      test write to os log, test write to os log, test write to os log, \
                      test write to os log, test write to os log, test write to os log.";
    for (int32_t i = 0; i < 10240; i++) {
        EXPECT_EQ(OK, LogAgentWriteDeviceOsLog(DEBUG_LOG, &fileList->sortDeviceOsLogList[DEBUG_LOG], msg, strlen(msg)));
    }

    ToolDirent **nameList = NULL;
    char path[1024] = { 0 };
    int32_t totalNum = ToolScandir(fileList->sortDeviceOsLogList[DEBUG_LOG].filePath, &nameList, OsFileFilter, alphasort);
    EXPECT_EQ(1, totalNum);
    CheckFileMode(fileList->sortDeviceOsLogList[DEBUG_LOG].filePath, nameList[0]->d_name, S_IRUSR | S_IWUSR | S_IRGRP); // 640
    ToolScandirFree(nameList, totalNum);
    LogAgentCleanUpDevice(fileList);
    SlogdConfigMgrExit();
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentWriteDeviceOsLogAgingWithOriFileWithConf)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceOsMaxFileNum *= *.*/DeviceOsMaxFileNum=1/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceOsNdebugMaxFileNum *= *.*/DeviceOsNdebugMaxFileNum=1/g' " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-os");
    system("> /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-os/device-os_201212192434133.log");
    StLogFileList *fileList = GetGlobalLogFileList();
    (void)memset_s((void *)fileList, sizeof(StLogFileList), 0, sizeof(StLogFileList));
    snprintf_truncated_s(fileList->aucFilePath, MAX_FILEDIR_LEN + 1U, "%s", LOG_FILE_PATH);
    LogAgentGetCfg(fileList);
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInit(fileList));

    // write to file
    char msg[1024] = "test write to os log, test write to os log, test write to os log, \
                      test write to os log, test write to os log, test write to os log, \
                      test write to os log, test write to os log, test write to os log, \
                      test write to os log, test write to os log, test write to os log, \
                      test write to os log, test write to os log, test write to os log.";
    for (int32_t i = 0; i < 10240; i++) {
        EXPECT_EQ(OK, LogAgentWriteDeviceOsLog(DEBUG_LOG, &fileList->sortDeviceOsLogList[DEBUG_LOG], msg, strlen(msg)));
    }

    ToolDirent **nameList = NULL;
    char path[1024] = { 0 };
    int32_t totalNum = ToolScandir(fileList->sortDeviceOsLogList[DEBUG_LOG].filePath, &nameList, OsFileFilter, alphasort);
    EXPECT_EQ(1, totalNum);
    CheckFileMode(fileList->sortDeviceOsLogList[DEBUG_LOG].filePath, nameList[0]->d_name, S_IRUSR | S_IWUSR | S_IRGRP); // 640
    ToolScandirFree(nameList, totalNum);
    EXPECT_EQ(SYS_ERROR, ToolAccess("/tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-os/device-os_201212192434133.log"));
    LogAgentCleanUpDevice(fileList);
    SlogdConfigMgrExit();
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentWriteSecurityLogAging)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog");
    StLogFileList *fileList = GetGlobalLogFileList();
    (void)memset_s((void *)fileList, sizeof(StLogFileList), 0, sizeof(StLogFileList));
    snprintf_truncated_s(fileList->aucFilePath, MAX_FILEDIR_LEN + 1U, "%s", LOG_FILE_PATH);
    LogAgentGetCfg(fileList);
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInit(fileList));

    // write to file
    char msg[1024] = "test write to os log, test write to os log, test write to os log, \
                      test write to os log, test write to os log, test write to os log, \
                      test write to os log, test write to os log, test write to os log, \
                      test write to os log, test write to os log, test write to os log, \
                      test write to os log, test write to os log, test write to os log.";
    for (int32_t i = 0; i < 10240; i++) {
        EXPECT_EQ(OK, LogAgentWriteDeviceOsLog(SECURITY_LOG, &fileList->sortDeviceOsLogList[SECURITY_LOG], msg, strlen(msg)));
    }

    ToolDirent **nameList = NULL;
    char path[1024] = { 0 };
    int32_t totalNum = ToolScandir(fileList->sortDeviceOsLogList[SECURITY_LOG].filePath, &nameList, OsFileFilter, alphasort);
    EXPECT_EQ(2, totalNum);
    CheckFileMode(fileList->sortDeviceOsLogList[SECURITY_LOG].filePath, nameList[0]->d_name, S_IRUSR | S_IRGRP); // 440
    CheckFileMode(fileList->sortDeviceOsLogList[SECURITY_LOG].filePath, nameList[1]->d_name, S_IRUSR | S_IWUSR | S_IRGRP); // 640
    ToolScandirFree(nameList, totalNum);
    LogAgentCleanUpDevice(fileList);
    SlogdConfigMgrExit();
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentWriteDeviceApplicationLogWithOutFileAging)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    StLogFileList *fileList = GetGlobalLogFileList();
    (void)memset_s((void *)fileList, sizeof(StLogFileList), 0, sizeof(StLogFileList));
    snprintf_truncated_s(fileList->aucFilePath, MAX_FILEDIR_LEN + 1U, "%s", LOG_FILE_PATH);
    LogAgentGetCfg(fileList);
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInit(fileList));
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog");
    char msg[1024] = "test write to device app log, test write to device app log, test write to device app log, \
                      test write to device app log, test write to device app log, test write to device app log, \
                      test write to device app log, test write to device app log, test write to device app log, \
                      test write to device app log, test write to device app log, test write to device app log, \
                      test write to device app log, test write to device app log, test write to device app log.";
    LogInfo info = { DEBUG_LOG, APPLICATION, 0, 0, AICPU, 0, 3 };
    for (int32_t i = 0; i < 10240; i++) {
        EXPECT_EQ(OK, LogAgentWriteDeviceApplicationLog(msg, strlen(msg), &info, fileList));
    }

    ToolDirent **nameList = NULL;
    char path[1024] = { 0 };
    snprintf_s(path, 1024, 1023, "%s/debug/device-app-0/", fileList->aucFilePath);
    int32_t totalNum = ToolScandir(path, &nameList, AppFileFilter, alphasort);
    EXPECT_EQ(2, totalNum);
    CheckFileMode(path, nameList[0]->d_name, S_IRUSR | S_IRGRP); // 440
    CheckFileMode(path, nameList[1]->d_name, S_IRUSR | S_IWUSR | S_IRGRP); // 640
    ToolScandirFree(nameList, totalNum);
    LogAgentCleanUpDevice(fileList);
    SlogdConfigMgrExit();
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentWriteDeviceApplicationLogAging)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    StLogFileList *fileList = GetGlobalLogFileList();
    (void)memset_s((void *)fileList, sizeof(StLogFileList), 0, sizeof(StLogFileList));
    snprintf_truncated_s(fileList->aucFilePath, MAX_FILEDIR_LEN + 1U, "%s", LOG_FILE_PATH);
    LogAgentGetCfg(fileList);
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInit(fileList));
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-app-0/");
    system("> /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-app-0/device-app-0_2023121902342.log");
    char msg[1024] = "test write to device app log, test write to device app log, test write to device app log, \
                      test write to device app log, test write to device app log, test write to device app log, \
                      test write to device app log, test write to device app log, test write to device app log, \
                      test write to device app log, test write to device app log, test write to device app log, \
                      test write to device app log, test write to device app log, test write to device app log.";
    LogInfo info = { DEBUG_LOG, APPLICATION, 0, 0, AICPU, 0, 3 };
    for (int32_t i = 0; i < 10240; i++) {
        EXPECT_EQ(OK, LogAgentWriteDeviceApplicationLog(msg, strlen(msg), &info, fileList));
    }

    ToolDirent **nameList = NULL;
    char path[1024] = { 0 };
    snprintf_s(path, 1024, 1023, "%s/debug/device-app-0/", fileList->aucFilePath);
    int32_t totalNum = ToolScandir(path, &nameList, AppFileFilter, alphasort);
    EXPECT_EQ(2, totalNum);
    CheckFileMode(path, nameList[0]->d_name, S_IRUSR | S_IRGRP); // 440
    CheckFileMode(path, nameList[1]->d_name, S_IRUSR | S_IWUSR | S_IRGRP); // 640
    ToolScandirFree(nameList, totalNum);
    EXPECT_EQ(SYS_ERROR, ToolAccess("/tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-app-0/device-app-0_2023121902342.log"));
    LogAgentCleanUpDevice(fileList);
    SlogdConfigMgrExit();
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentWriteDeviceApplicationLogWithOutFileAgingWithConf)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceAppMaxFileNum *= *.*/DeviceAppMaxFileNum=1/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceAppMaxFileNum *= *.*/DeviceAppMaxFileNum=1/g' " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    StLogFileList *fileList = GetGlobalLogFileList();
    (void)memset_s((void *)fileList, sizeof(StLogFileList), 0, sizeof(StLogFileList));
    snprintf_truncated_s(fileList->aucFilePath, MAX_FILEDIR_LEN + 1U, "%s", LOG_FILE_PATH);
    LogAgentGetCfg(fileList);
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInit(fileList));
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog");
    char msg[1024] = "test write to device app log, test write to device app log, test write to device app log, \
                      test write to device app log, test write to device app log, test write to device app log, \
                      test write to device app log, test write to device app log, test write to device app log, \
                      test write to device app log, test write to device app log, test write to device app log, \
                      test write to device app log, test write to device app log, test write to device app log.";
    LogInfo info = { DEBUG_LOG, APPLICATION, 0, 0, AICPU, 0, 3 };
    for (int32_t i = 0; i < 10240; i++) {
        EXPECT_EQ(OK, LogAgentWriteDeviceApplicationLog(msg, strlen(msg), &info, fileList));
    }

    ToolDirent **nameList = NULL;
    char path[1024] = { 0 };
    snprintf_s(path, 1024, 1023, "%s/debug/device-app-0/", fileList->aucFilePath);
    int32_t totalNum = ToolScandir(path, &nameList, AppFileFilter, alphasort);
    EXPECT_EQ(1, totalNum);
    CheckFileMode(path, nameList[0]->d_name, S_IRUSR | S_IWUSR | S_IRGRP); // 640
    ToolScandirFree(nameList, totalNum);
    LogAgentCleanUpDevice(fileList);
    SlogdConfigMgrExit();
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogAgentWriteDeviceApplicationLogAgingWithConf)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceAppMaxFileNum *= *.*/DeviceAppMaxFileNum=1/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceAppMaxFileNum *= *.*/DeviceAppMaxFileNum=1/g' " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    StLogFileList *fileList = GetGlobalLogFileList();
    (void)memset_s((void *)fileList, sizeof(StLogFileList), 0, sizeof(StLogFileList));
    snprintf_truncated_s(fileList->aucFilePath, MAX_FILEDIR_LEN + 1U, "%s", LOG_FILE_PATH);
    LogAgentGetCfg(fileList);
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInit(fileList));
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-app-0/");
    system("> /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-app-0/device-app-0_2023121902342.log");
    char msg[1024] = "test write to device app log, test write to device app log, test write to device app log, \
                      test write to device app log, test write to device app log, test write to device app log, \
                      test write to device app log, test write to device app log, test write to device app log, \
                      test write to device app log, test write to device app log, test write to device app log, \
                      test write to device app log, test write to device app log, test write to device app log.";
    LogInfo info = { DEBUG_LOG, APPLICATION, 0, 0, AICPU, 0, 3 };
    for (int32_t i = 0; i < 10240; i++) {
        EXPECT_EQ(OK, LogAgentWriteDeviceApplicationLog(msg, strlen(msg), &info, fileList));
    }

    ToolDirent **nameList = NULL;
    char path[1024] = { 0 };
    snprintf_s(path, 1024, 1023, "%s/debug/device-app-0/", fileList->aucFilePath);
    int32_t totalNum = ToolScandir(path, &nameList, AppFileFilter, alphasort);
    EXPECT_EQ(1, totalNum);
    CheckFileMode(path, nameList[0]->d_name, S_IRUSR | S_IWUSR | S_IRGRP); // 640
    ToolScandirFree(nameList, totalNum);
    EXPECT_EQ(SYS_ERROR, ToolAccess("/tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/npu/slog/debug/device-app-0/device-app-0_2023121902342.log"));
    LogAgentCleanUpDevice(fileList);
    SlogdConfigMgrExit();
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogGetDirSize)
{
    system("mkdir -p " PATH_ROOT "/testDir");
    system("mkdir -p " PATH_ROOT "/testDirNull");
    system("echo test > " PATH_ROOT "/testDir/test.log");
    EXPECT_LT(0, LogGetDirSize(PATH_ROOT, 0));
    EXPECT_EQ(0, LogGetDirSize(PATH_ROOT "/testDirNull", 0));
    EXPECT_LT(0, LogGetDirSize(PATH_ROOT "/testDir", 0));
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_FUNC_UTEST, LogCompressStub)
{
    EXPECT_EQ(LOG_SUCCESS, SlogdCompress(nullptr, 0, nullptr, 0));
    EXPECT_EQ(LOG_SUCCESS, LogCompressFileRotate(nullptr));
}