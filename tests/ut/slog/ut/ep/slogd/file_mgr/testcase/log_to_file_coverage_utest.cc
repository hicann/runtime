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
#include "slogd_write_limit.h"
#include "slogd_appnum_watch.h"
#include "log_queue.h"
#include "log_common.h"
#include "log_types.h"

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>

using namespace std;

static LogStatus SlogdSyslogMgrInitCov(StLogFileList *fileList)
{
    LogStatus ret = LogAgentInitDeviceOs(fileList);
    if (ret != LOG_SUCCESS) {
        return ret;
    }
    return LogAgentInitDeviceApplication(fileList);
}

// Stub that makes ToolStatGet succeed but report a huge file size, to exercise the
// filesize-overflow guard in GetFileOfSize.
static INT32 StatGetHugeStub(const CHAR *path, ToolStat *buffer)
{
    (void)path;
    if (buffer != NULL) {
        buffer->st_size = (off_t)0xFFFFFFFF;
    }
    return SYS_OK;
}

class EP_SLOGD_LOG_TO_FILE_COV_UTEST : public testing::Test
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
        system("rm -rf " PATH_ROOT "/*");
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
};

// ------------------------- log_to_file.c: null/guard paths -------------------------
TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, LogAgentNullInputGuards)
{
    // LogAgentInitDeviceOs / InitDeviceApplication / CleanUpDevice NULL guards
    EXPECT_EQ(LOG_FAILURE, LogAgentInitDeviceOs(NULL));
    EXPECT_EQ(LOG_FAILURE, LogAgentInitDeviceApplication(NULL));
    LogAgentCleanUpDevice(NULL);

    // LogAgentWriteDeviceOsLog input guards: (logType, subLogList, msg, len)
    StSubLogFileList sub;
    (void)memset_s(&sub, sizeof(sub), 0, sizeof(sub));
    char m[] = "x";
    EXPECT_EQ(NOK, LogAgentWriteDeviceOsLog(DEBUG_LOG, NULL, NULL, 0));   // msg NULL
    EXPECT_EQ(NOK, LogAgentWriteDeviceOsLog(DEBUG_LOG, &sub, NULL, 10));  // msg NULL
    EXPECT_EQ(NOK, LogAgentWriteDeviceOsLog(DEBUG_LOG, &sub, m, 0));      // len 0
    EXPECT_EQ(NOK, LogAgentWriteDeviceOsLog(DEBUG_LOG, NULL, m, 1));      // subLogList NULL
    EXPECT_EQ(NOK, LogAgentWriteDeviceOsLog(-1, &sub, m, 1));             // wrong logType
    EXPECT_EQ(NOK, LogAgentWriteDeviceOsLog(LOG_TYPE_NUM, &sub, m, 1));   // wrong logType

    // LogAgentWriteEventLog input guards: (subLogList, msg, len)
    EXPECT_EQ(NOK, LogAgentWriteEventLog(NULL, NULL, 1));  // msg NULL
    EXPECT_EQ(NOK, LogAgentWriteEventLog(NULL, m, 0));     // len 0
    EXPECT_EQ(NOK, LogAgentWriteEventLog(NULL, m, 1));     // subLogList NULL

    // LogAgentWriteDeviceApplicationLog input guards: (msg, len, logInfo, logList)
    EXPECT_EQ(NOK, LogAgentWriteDeviceApplicationLog(NULL, 1, NULL, NULL));  // msg NULL
    EXPECT_EQ(NOK, LogAgentWriteDeviceApplicationLog(m, 1, NULL, NULL));     // logInfo NULL
    LogInfo info;
    (void)memset_s(&info, sizeof(info), 0, sizeof(info));
    info.processType = SYSTEM;
    EXPECT_EQ(NOK, LogAgentWriteDeviceApplicationLog(m, 1, &info, NULL));   // processType != APPLICATION
    info.processType = APPLICATION;
    EXPECT_EQ(NOK, LogAgentWriteDeviceApplicationLog(m, 1, &info, NULL));   // logList NULL
    StLogFileList logList;
    (void)memset_s(&logList, sizeof(logList), 0, sizeof(logList));
    info.type = (LogType)LOG_TYPE_NUM;
    EXPECT_EQ(NOK, LogAgentWriteDeviceApplicationLog(m, 1, &info, &logList)); // type >= LOG_TYPE_NUM
    ResetErrLog();
}

TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, LogAgentGetCfgConfigFail)
{
    StLogFileList logList;
    (void)memset_s(&logList, sizeof(logList), 0, sizeof(logList));
    // SlogdConfigMgrGetList fails -> log error and return LOG_SUCCESS
    MOCKER(SlogdConfigMgrGetList).stubs().will(returnValue((int32_t)LOG_FAILURE));
    EXPECT_EQ(LOG_SUCCESS, LogAgentGetCfg(&logList));
    GlobalMockObject::verify();
    ResetErrLog();
}

// ------------------------- log_to_file.c: device application COMMON storage mode -------------------------
// Mocks SlogdConfigMgrGetStorageMode to STORAGE_RULE_COMMON so that LogAgentInitDeviceApplication
// body, LogAgentInitDeviceAppDir, LogAgentSortDirList, LogAgentAddLogDirList, AppLogPidDirFilter
// and LogAgentRemoveDir get exercised.
TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, LogAgentInitDeviceApplicationCommonMode)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    // DeviceAppMaxFileNum=1 -> totalMaxFileSize = 0, which forces aging/dir-removal during init.
    system("sed -i 's/DeviceAppMaxFileNum *= *.*/DeviceAppMaxFileNum=1/g' " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();

    // device-app-0 dir with content (dirTotalSize > 0) under debug sort dir
    system("mkdir -p " LOG_FILE_PATH "/debug/device-app-0");
    system("mkdir -p " LOG_FILE_PATH "/debug/device-app-all");
    system("echo data > " LOG_FILE_PATH "/debug/device-app-0/inner.log");
    // a matching log file in device-app-all so scandir returns non-null namelist
    system("echo data > " LOG_FILE_PATH "/debug/device-app-all/device-app_202312190876.log");
    // security / run sort dirs (empty device-app-all so they return early/safely)
    system("mkdir -p " LOG_FILE_PATH "/security/device-app-all");
    system("mkdir -p " LOG_FILE_PATH "/run/device-app-all");

    MOCKER(SlogdConfigMgrGetStorageMode).stubs().will(returnValue((int32_t)STORAGE_RULE_COMMON));
    StLogFileList logList;
    (void)memset_s(&logList, sizeof(logList), 0, sizeof(logList));
    (void)snprintf_truncated_s(logList.aucFilePath, MAX_FILEDIR_LEN + 1U, "%s", LOG_FILE_PATH);
    EXPECT_EQ(LOG_SUCCESS, LogAgentGetCfg(&logList));
    EXPECT_EQ(LOG_SUCCESS, LogAgentInitDeviceApplication(&logList));
    GlobalMockObject::verify();

    LogAgentCleanUpDevice(&logList);
    SlogdConfigMgrExit();
    ResetErrLog();
}

// Covers the COMMON storage write branch (mutex lock/unlock path) of LogAgentWriteDeviceApplicationLog.
TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, LogAgentWriteDeviceApplicationLogCommonMode)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    system("mkdir -p " LOG_FILE_PATH);

    MOCKER(SlogdConfigMgrGetStorageMode).stubs().will(returnValue((int32_t)STORAGE_RULE_COMMON));
    StLogFileList *fileList = GetGlobalLogFileList();
    (void)memset_s((void *)fileList, sizeof(StLogFileList), 0, sizeof(StLogFileList));
    (void)snprintf_truncated_s(fileList->aucFilePath, MAX_FILEDIR_LEN + 1U, "%s", LOG_FILE_PATH);
    EXPECT_EQ(LOG_SUCCESS, LogAgentGetCfg(fileList));
    EXPECT_EQ(LOG_SUCCESS, LogAgentInitDeviceApplication(fileList));

    char msg[1024] = "test app log common branch";
    LogInfo info = { DEBUG_LOG, APPLICATION, 0, 0, AICPU, 0, 3 };
    EXPECT_EQ(OK, LogAgentWriteDeviceApplicationLog(msg, (unsigned int)strlen(msg), &info, fileList));
    GlobalMockObject::verify();

    LogAgentCleanUpDevice(fileList);
    SlogdConfigMgrExit();
    ResetErrLog();
}

// Covers the AOS_CORE device app head path in LogAgentInitDeviceApp (aosType != 0).
TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, LogAgentWriteDeviceApplicationLogAosCore)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    StLogFileList *fileList = GetGlobalLogFileList();
    (void)memset_s((void *)fileList, sizeof(StLogFileList), 0, sizeof(StLogFileList));
    (void)snprintf_truncated_s(fileList->aucFilePath, MAX_FILEDIR_LEN + 1U, "%s", LOG_FILE_PATH);
    EXPECT_EQ(LOG_SUCCESS, LogAgentGetCfg(fileList));
    system("mkdir -p " LOG_FILE_PATH "/debug/aos-core-app-0");
    char msg[1024] = "test aos core app log";
    // aosType=1 -> AOS_CORE_DEVICE_APP_HEAD branch; default storage mode is FILTER_PID (else branch)
    LogInfo info = { DEBUG_LOG, APPLICATION, 0, 0, AICPU, 1, 3 };
    EXPECT_EQ(OK, LogAgentWriteDeviceApplicationLog(msg, (unsigned int)strlen(msg), &info, fileList));
    SlogdConfigMgrExit();
    ResetErrLog();
}

// ------------------------- log_to_file.c: write file limit -------------------------
// Enables WriteLimitSwitch so the write-limit init helpers and LogAgentWriteLimitCheck run,
// including the limit-rejected path (WriteFileLimitCheck returns false).
TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, LogAgentWriteFileLimitOn)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    system("sed -i '/WriteLimitSwitch/d' " SLOG_CONF_FILE_PATH);
    system("echo '' >> " SLOG_CONF_FILE_PATH);
    system("echo 'WriteLimitSwitch=1' >> " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    EXPECT_TRUE(SlogdConfigMgrGetWriteFileLimit());
    system("mkdir -p " LOG_FILE_PATH);
    StLogFileList *fileList = GetGlobalLogFileList();
    (void)memset_s((void *)fileList, sizeof(StLogFileList), 0, sizeof(StLogFileList));
    (void)snprintf_truncated_s(fileList->aucFilePath, MAX_FILEDIR_LEN + 1U, "%s", LOG_FILE_PATH);
    EXPECT_EQ(LOG_SUCCESS, LogAgentGetCfg(fileList));
    EXPECT_EQ(LOG_SUCCESS, SlogdSyslogMgrInitCov(fileList));

    char msg[1024] = "test write limit os log";
    // debug os: typeSize==0 -> limit stays NULL -> WriteFileLimitCheck(NULL)=true
    EXPECT_EQ(OK, LogAgentWriteDeviceOsLog(DEBUG_LOG, &fileList->sortDeviceOsLogList[DEBUG_LOG], msg,
                                           (unsigned int)strlen(msg)));
    // security os: limit initialized -> real WriteFileLimitCheck passes
    EXPECT_EQ(OK, LogAgentWriteDeviceOsLog(SECURITY_LOG, &fileList->sortDeviceOsLogList[SECURITY_LOG], msg,
                                           (unsigned int)strlen(msg)));
    // force the limit-rejected branch: mark current period as already limited
    WriteFileLimit *lim = fileList->sortDeviceOsLogList[SECURITY_LOG].limit;
    ASSERT_TRUE(lim != NULL);
    lim->periodConfig[lim->periodIndex].isLimit = true;
    EXPECT_EQ(OK, LogAgentWriteDeviceOsLog(SECURITY_LOG, &fileList->sortDeviceOsLogList[SECURITY_LOG], msg,
                                           (unsigned int)strlen(msg)));

    LogAgentCleanUpDevice(fileList);
    SlogdConfigMgrExit();
    ResetErrLog();
}

// Covers the trailing-slash trim (line 563) and the "debug" dir label branch (lines 576-582)
// inside LogAgentWriteLimitCheck by feeding crafted filePath values through LogAgentWriteFile.
TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, LogAgentWriteLimitCheckBranches)
{
    system("mkdir -p " LOG_FILE_PATH "/debug/device-os");
    system("mkdir -p " LOG_FILE_PATH "/debug");

    StLogDataBlock logData;
    (void)memset_s(&logData, sizeof(logData), 0, sizeof(logData));
    char msg[64] = "hello limit check";
    logData.paucData = msg;
    logData.ulDataLen = (unsigned int)strlen(msg);

    // 1) filePath with trailing '/' -> trims trailing slash in LogAgentWriteLimitCheck
    StSubLogFileList subSlash;
    (void)memset_s(&subSlash, sizeof(subSlash), 0, sizeof(subSlash));
    (void)snprintf_s(subSlash.filePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s", LOG_FILE_PATH "/debug/device-os/");
    (void)snprintf_s(subSlash.fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "%s", "device-os_");
    subSlash.maxFileSize = 1U * 1024U * 1024U;
    subSlash.totalMaxFileSize = 10U * 1024U * 1024U;
    EXPECT_EQ(OK, LogAgentWriteFile(&subSlash, &logData));

    // 2) filePath ending with "/debug" -> DEBUG_DIR_NAME label branch
    StSubLogFileList subDebug;
    (void)memset_s(&subDebug, sizeof(subDebug), 0, sizeof(subDebug));
    (void)snprintf_s(subDebug.filePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s", LOG_FILE_PATH "/debug");
    (void)snprintf_s(subDebug.fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "%s", "device-os_");
    subDebug.maxFileSize = 1U * 1024U * 1024U;
    subDebug.totalMaxFileSize = 10U * 1024U * 1024U;
    EXPECT_EQ(OK, LogAgentWriteFile(&subDebug, &logData));
    ResetErrLog();
}

// ------------------------- log_to_file.c: LogAgentWriteDeviceLog (#else branch) errors -------------------------
TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, LogAgentWriteDeviceLogErrorPaths)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    StLogFileList logList;
    (void)memset_s(&logList, sizeof(logList), 0, sizeof(logList));
    EXPECT_EQ(LOG_SUCCESS, LogAgentGetCfg(&logList));

    char msg[64] = "data";
    // deviceLogList not allocated yet -> deviceLogList[num] == NULL path
    DeviceWriteLogInfo info = { (unsigned int)strlen(msg), 0, DEBUG_LOG, LP };
    EXPECT_EQ(NOK, LogAgentWriteDeviceLog(&logList, msg, &info));
    ResetErrLog();

    // allocate device list, then wrong device id (> ucDeviceNum)
    EXPECT_EQ(OK, LogAgentInitDevice(&logList, MAX_DEV_NUM));
    DeviceWriteLogInfo badDev = { (unsigned int)strlen(msg), 100, DEBUG_LOG, LP };
    EXPECT_EQ(NOK, LogAgentWriteDeviceLog(&logList, msg, &badDev));
    ResetErrLog();

    // logType >= LOG_TYPE_NUM is reset to DEBUG_LOG, then a normal write happens
    DeviceWriteLogInfo badType = { (unsigned int)strlen(msg), 0, (LogType)LOG_TYPE_NUM, LP };
    EXPECT_EQ(OK, LogAgentWriteDeviceLog(&logList, msg, &badType));

    LogAgentCleanUpDevice(&logList);
    SlogdConfigMgrExit();
    ResetErrLog();
}

// ------------------------- log_to_file.c: LogFileMgrStorage rotation path -------------------------
TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, LogFileMgrStorageRotation)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    StSubLogFileList sub;
    (void)memset_s(&sub, sizeof(sub), 0, sizeof(sub));
    (void)snprintf_s(sub.filePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s", LOG_FILE_PATH "/debug/device-os");
    (void)snprintf_s(sub.fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "%s", "device-os_");
    (void)snprintf_s(sub.fileName, MAX_FILENAME_LEN + 1U, MAX_FILENAME_LEN, "%s", "device-os_202312190876.log");
    sub.storage.period = 100;
    sub.storage.curTime = 200; // curTime >= period -> proceed with rotation
    sub.maxFileSize = 1U * 1024U * 1024U;
    sub.totalMaxFileSize = 10U * 1024U * 1024U;
    system("mkdir -p " LOG_FILE_PATH "/debug/device-os");
    system("echo data > " LOG_FILE_PATH "/debug/device-os/device-os_202312190876.log");
    LogFileMgrStorage(&sub);
    EXPECT_EQ(0U, (unsigned int)strlen(sub.fileName));
    SlogdConfigMgrExit();
    ResetErrLog();
}

// ------------------------- log_to_file.c: GetFileOfSize invalid realpath -------------------------
// A pre-existing non-.log file makes ToolRealPath succeed but IsPathValidbyLog fail, exercising
// the CFG_FILE_INVALID path in GetFileOfSize and the subsequent write failure.
TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, GetFileOfSizeInvalidRealpath)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    StSubLogFileList sub;
    (void)memset_s(&sub, sizeof(sub), 0, sizeof(sub));
    (void)snprintf_s(sub.filePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s", LOG_FILE_PATH "/debug/device-os");
    (void)snprintf_s(sub.fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "%s", "device-os_");
    // fileName points to a non-.log file that exists -> realpath valid but suffix invalid
    (void)snprintf_s(sub.fileName, MAX_FILENAME_LEN + 1U, MAX_FILENAME_LEN, "%s", "notalog.txt");
    sub.maxFileSize = 1U * 1024U * 1024U;
    sub.totalMaxFileSize = 10U * 1024U * 1024U;
    system("mkdir -p " LOG_FILE_PATH "/debug/device-os");
    system("echo data > " LOG_FILE_PATH "/debug/device-os/notalog.txt");
    char msg[64] = "trigger invalid realpath";
    EXPECT_EQ(NOK, LogAgentWriteDeviceOsLog(DEBUG_LOG, &sub, msg, (unsigned int)strlen(msg)));
    SlogdConfigMgrExit();
    ResetErrLog();
}

// ------------------------- log_to_file.c: LogAgentRemoveFile warn paths -------------------------
TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, LogAgentRemoveFileChmodWarn)
{
    const char *tmpFile = PATH_ROOT "/tmp_chmod_fail.log";
    FILE *fp = fopen(tmpFile, "w");
    ASSERT_TRUE(fp != NULL);
    (void)fwrite("x", 1, 1, fp);
    (void)fclose(fp);
    errno = EACCES; // ensure ToolGetErrorCode() != ENOENT so the warn branch is taken
    MOCKER(ToolChmod).stubs().will(returnValue((INT32)(-1)));
    EXPECT_EQ(OK, LogAgentRemoveFile(tmpFile)); // unlink still succeeds
    GlobalMockObject::verify();
    ResetErrLog();
}

TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, LogAgentRemoveFileUnlinkWarn)
{
    const char *tmpFile = PATH_ROOT "/tmp_unlink_fail.log";
    FILE *fp = fopen(tmpFile, "w");
    ASSERT_TRUE(fp != NULL);
    (void)fwrite("x", 1, 1, fp);
    (void)fclose(fp);
    errno = EACCES;
    MOCKER(ToolUnlink).stubs().will(returnValue((INT32)(-1)));
    EXPECT_EQ(NOK, LogAgentRemoveFile(tmpFile));
    GlobalMockObject::verify();
    // file still on disk, clean it up
    (void)unlink(tmpFile);
    ResetErrLog();
}

// ------------------------- log_to_file.c: LogAgentWriteDataToFile error paths -------------------------
static void PrepOsSubList(StSubLogFileList &sub)
{
    (void)memset_s(&sub, sizeof(sub), 0, sizeof(sub));
    (void)snprintf_s(sub.filePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s", LOG_FILE_PATH "/debug/device-os");
    (void)snprintf_s(sub.fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "%s", "device-os_");
    sub.maxFileSize = 1U * 1024U * 1024U;
    sub.totalMaxFileSize = 10U * 1024U * 1024U;
    system("mkdir -p " LOG_FILE_PATH "/debug/device-os");
}

TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, WriteDataToFileOpenFail)
{
    StSubLogFileList sub;
    PrepOsSubList(sub);
    char msg[64] = "open fail test";
    MOCKER(ToolOpenWithMode).stubs().will(returnValue((INT32)(-1)));
    EXPECT_EQ(NOK, LogAgentWriteDeviceOsLog(DEBUG_LOG, &sub, msg, (unsigned int)strlen(msg)));
    GlobalMockObject::verify();
    ResetErrLog();
}

TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, WriteDataToFileWriteFail)
{
    StSubLogFileList sub;
    PrepOsSubList(sub);
    char msg[64] = "write fail test";
    errno = EACCES;
    MOCKER(ToolWrite).stubs().will(returnValue((INT32)(-1)));
    EXPECT_EQ(NOK, LogAgentWriteDeviceOsLog(DEBUG_LOG, &sub, msg, (unsigned int)strlen(msg)));
    GlobalMockObject::verify();
    ResetErrLog();
}

TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, WriteDataToFileFchownFail)
{
    StSubLogFileList sub;
    PrepOsSubList(sub);
    char msg[64] = "fchown fail test";
    errno = EACCES;
    MOCKER(ToolFChownPath).stubs().will(returnValue((INT32)SYS_ERROR));
    EXPECT_EQ(OK, LogAgentWriteDeviceOsLog(DEBUG_LOG, &sub, msg, (unsigned int)strlen(msg)));
    GlobalMockObject::verify();
    ResetErrLog();
}

// ------------------------- log_to_file.c: GetFileOfSize malloc fail + overflow -------------------------
TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, GetFileOfSizeMallocFail)
{
    StSubLogFileList sub;
    PrepOsSubList(sub);
    // a non-empty fileName is required so LogAgentGetFileName reaches GetFileOfSize (which calls LogMalloc)
    (void)snprintf_s(sub.fileName, MAX_FILENAME_LEN + 1U, MAX_FILENAME_LEN, "%s", "device-os_202312190876.log");
    char msg[64] = "malloc fail test";
    MOCKER(LogMalloc).stubs().will(returnValue((void *)NULL));
    EXPECT_EQ(NOK, LogAgentWriteDeviceOsLog(DEBUG_LOG, &sub, msg, (unsigned int)strlen(msg)));
    GlobalMockObject::verify();
    ResetErrLog();
}

TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, GetFileOfSizeOverflow)
{
    StSubLogFileList sub;
    PrepOsSubList(sub);
    // pre-create an existing .log file so GetFileOfSize reaches the stat/overflow check
    (void)snprintf_s(sub.fileName, MAX_FILENAME_LEN + 1U, MAX_FILENAME_LEN, "%s", "device-os_202312190876.log");
    system("echo data > " LOG_FILE_PATH "/debug/device-os/device-os_202312190876.log");
    char msg[64] = "overflow test";
    MOCKER(ToolStatGet).stubs().will(invoke(StatGetHugeStub));
    EXPECT_EQ(NOK, LogAgentWriteDeviceOsLog(DEBUG_LOG, &sub, msg, (unsigned int)strlen(msg)));
    GlobalMockObject::verify();
    ResetErrLog();
}

// ------------------------- log_to_file.c: LogAgentMkdir root mkdir failure -------------------------
TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, LogAgentMkdirRootFail)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    StLogFileList logList;
    (void)memset_s(&logList, sizeof(logList), 0, sizeof(logList));
    EXPECT_EQ(LOG_SUCCESS, LogAgentGetCfg(&logList)); // sets g_logRootPath
    StSubLogFileList sub;
    (void)memset_s(&sub, sizeof(sub), 0, sizeof(sub));
    // a non-existent path so ToolAccess fails and LogMkdirRecur is invoked
    (void)snprintf_s(sub.filePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s", LOG_FILE_PATH "/noexist/sub");
    (void)snprintf_s(sub.fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "%s", "device-os_");
    sub.maxFileSize = 1U * 1024U * 1024U;
    sub.totalMaxFileSize = 10U * 1024U * 1024U;
    char msg[64] = "mkdir root fail";
    MOCKER(LogMkdirRecur).stubs().will(returnValue((LogRt)MKDIR_FAILED));
    EXPECT_EQ(NOK, LogAgentWriteDeviceOsLog(DEBUG_LOG, &sub, msg, (unsigned int)strlen(msg)));
    GlobalMockObject::verify();
    SlogdConfigMgrExit();
    ResetErrLog();
}

// ------------------------- log_to_file.c: LogAgentRemoveDir remove failure -------------------------
TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, LogAgentRemoveDirRemoveFail)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceAppMaxFileNum *= *.*/DeviceAppMaxFileNum=1/g' " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    system("mkdir -p " LOG_FILE_PATH "/debug/device-app-0");
    system("mkdir -p " LOG_FILE_PATH "/debug/device-app-all");
    system("echo data > " LOG_FILE_PATH "/debug/device-app-0/inner.log");
    system("echo data > " LOG_FILE_PATH "/debug/device-app-all/device-app_202312190876.log");
    system("mkdir -p " LOG_FILE_PATH "/security/device-app-all");
    system("mkdir -p " LOG_FILE_PATH "/run/device-app-all");

    MOCKER(SlogdConfigMgrGetStorageMode).stubs().will(returnValue((int32_t)STORAGE_RULE_COMMON));
    MOCKER(LogRemoveDir).stubs().will(returnValue(SYS_ERROR)); // dir removal fails -> warn+continue
    StLogFileList logList;
    (void)memset_s(&logList, sizeof(logList), 0, sizeof(logList));
    (void)snprintf_truncated_s(logList.aucFilePath, MAX_FILEDIR_LEN + 1U, "%s", LOG_FILE_PATH);
    EXPECT_EQ(LOG_SUCCESS, LogAgentGetCfg(&logList));
    EXPECT_EQ(LOG_SUCCESS, LogAgentInitDeviceApplication(&logList));
    GlobalMockObject::verify();
    LogAgentCleanUpDevice(&logList);
    SlogdConfigMgrExit();
    ResetErrLog();
}

// ------------------------- log_to_file.c: LogAgentWriteFile final chmod warn -------------------------
TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, LogAgentWriteFileChmodWarn)
{
    StSubLogFileList sub;
    PrepOsSubList(sub);
    char msg[64] = "final chmod warn";
    errno = EACCES;
    MOCKER(ToolChmod).stubs().will(returnValue((INT32)(-1)));
    EXPECT_EQ(OK, LogAgentWriteDeviceOsLog(DEBUG_LOG, &sub, msg, (unsigned int)strlen(msg)));
    GlobalMockObject::verify();
    ResetErrLog();
}

// ------------------------- log_to_file.c: write-limit init failure paths -------------------------
// WriteFileLimitInit is only invoked from the write-limit init helpers, so mocking it cleanly
// exercises the failure returns of LogAgentInitDeviceOsWriteLimit / LogAgentInitDeviceWriteLimit
// and their callers.
TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, LogAgentInitDeviceOsWriteLimitFail)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    system("sed -i '/WriteLimitSwitch/d' " SLOG_CONF_FILE_PATH);
    system("echo '' >> " SLOG_CONF_FILE_PATH);
    system("echo 'WriteLimitSwitch=1' >> " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    StLogFileList logList;
    (void)memset_s(&logList, sizeof(logList), 0, sizeof(logList));
    EXPECT_EQ(LOG_SUCCESS, LogAgentGetCfg(&logList));
    MOCKER(WriteFileLimitInit).stubs().will(returnValue((LogStatus)LOG_FAILURE));
    EXPECT_EQ(LOG_FAILURE, LogAgentInitDeviceOs(&logList));
    GlobalMockObject::verify();
    LogAgentCleanUpDevice(&logList);
    SlogdConfigMgrExit();
    ResetErrLog();
}

TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, LogAgentInitDeviceWriteLimitFail)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    system("sed -i '/WriteLimitSwitch/d' " SLOG_CONF_FILE_PATH);
    system("echo '' >> " SLOG_CONF_FILE_PATH);
    system("echo 'WriteLimitSwitch=1' >> " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    StLogFileList logList;
    (void)memset_s(&logList, sizeof(logList), 0, sizeof(logList));
    EXPECT_EQ(LOG_SUCCESS, LogAgentGetCfg(&logList));
    MOCKER(WriteFileLimitInit).stubs().will(returnValue((LogStatus)LOG_FAILURE));
    EXPECT_EQ(NOK, LogAgentInitDevice(&logList, MAX_DEV_NUM));
    GlobalMockObject::verify();
    LogAgentCleanUpDevice(&logList);
    SlogdConfigMgrExit();
    ResetErrLog();
}

// ------------------------- log_queue.c -------------------------
TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, LogQueueEdgeCases)
{
    EXPECT_EQ(ARGV_NULL, LogQueueInit(NULL, 0));
    LogQueue q;
    EXPECT_EQ(SUCCESS, LogQueueInit(&q, 1));
    EXPECT_EQ(ARGV_NULL, LogQueueFull(NULL));
    EXPECT_EQ(ARGV_NULL, LogQueueNULL(NULL));
    EXPECT_EQ(QUEUE_IS_NULL, LogQueueNULL(&q));
    EXPECT_EQ(SUCCESS, LogQueueFull(&q));

    LogNode *out = NULL;
    EXPECT_EQ(ARGV_NULL, LogQueueDequeue(NULL, &out));
    EXPECT_EQ(ARGV_NULL, LogQueueDequeue(&q, NULL));
    EXPECT_EQ(QUEUE_IS_NULL, LogQueueDequeue(&q, &out));

    EXPECT_EQ(ARGV_NULL, LogQueueEnqueue(NULL, NULL));
    EXPECT_EQ(ARGV_NULL, LogQueueEnqueue(&q, NULL));
    LogNode zeroNode;
    (void)memset_s(&zeroNode, sizeof(zeroNode), 0, sizeof(zeroNode));
    zeroNode.uiNodeDataLen = 0;
    EXPECT_EQ(ARGV_NULL, LogQueueEnqueue(&q, &zeroNode));

    // fill queue up to MAX_QUEUE_COUNT
    LogNode *nodes[MAX_QUEUE_COUNT];
    for (int i = 0; i < MAX_QUEUE_COUNT; i++) {
        nodes[i] = (LogNode *)calloc(1, sizeof(LogNode));
        ASSERT_TRUE(nodes[i] != NULL);
        nodes[i]->uiNodeDataLen = 10;
        nodes[i]->stNodeData = calloc(1, 10);
        EXPECT_EQ(SUCCESS, LogQueueEnqueue(&q, nodes[i]));
    }
    EXPECT_EQ(QUEUE_IS_FULL, LogQueueFull(&q));
    LogNode extra;
    (void)memset_s(&extra, sizeof(extra), 0, sizeof(extra));
    extra.uiNodeDataLen = 10;
    EXPECT_EQ(QUEUE_IS_FULL, LogQueueEnqueue(&q, &extra));

    // dequeue until count==1, then the last dequeue exercises the count==1 branch (re-init)
    LogNode *d = NULL;
    EXPECT_EQ(SUCCESS, LogQueueDequeue(&q, &d));
    for (int i = 0; i < MAX_QUEUE_COUNT - 2; i++) {
        LogNode *dd = NULL;
        EXPECT_EQ(SUCCESS, LogQueueDequeue(&q, &dd));
    }
    LogNode *last = NULL;
    EXPECT_EQ(SUCCESS, LogQueueDequeue(&q, &last));
    EXPECT_EQ(0U, q.uiCount);
    EXPECT_EQ(QUEUE_IS_NULL, LogQueueDequeue(&q, &out));

    for (int i = 0; i < MAX_QUEUE_COUNT; i++) {
        free(nodes[i]->stNodeData);
        free(nodes[i]);
    }

    // XFreeLogNode guards + normal free
    XFreeLogNode(NULL);
    LogNode *nullN = NULL;
    XFreeLogNode(&nullN);
    LogNode *real = (LogNode *)calloc(1, sizeof(LogNode));
    real->stNodeData = calloc(1, 8);
    real->uiNodeDataLen = 8;
    XFreeLogNode(&real);
    EXPECT_TRUE(real == NULL);

    // LogQueueFree guards
    EXPECT_EQ(ARGV_NULL, LogQueueFree(NULL, NULL));
    EXPECT_EQ(ARGV_NULL, LogQueueFree(&q, NULL));
    // fill again and free whole queue via XFreeLogNode
    for (int i = 0; i < 3; i++) {
        LogNode *nn = (LogNode *)calloc(1, sizeof(LogNode));
        nn->uiNodeDataLen = 5;
        nn->stNodeData = calloc(1, 5);
        (void)LogQueueEnqueue(&q, nn);
    }
    EXPECT_EQ(SUCCESS, LogQueueFree(&q, XFreeLogNode));
    EXPECT_EQ(0U, q.uiCount);
    ResetErrLog();
}

// ------------------------- log_common.c -------------------------
TEST_F(EP_SLOGD_LOG_TO_FILE_COV_UTEST, LogCommonEdgeCases)
{
    // LogMalloc(0)
    EXPECT_TRUE(LogMalloc(0) == NULL);

    // LogStrToInt
    int64_t num = 0;
    EXPECT_EQ(LOG_FAILURE, LogStrToInt(NULL, &num));
    EXPECT_EQ(LOG_FAILURE, LogStrToInt("123", NULL));
    EXPECT_EQ(LOG_FAILURE, LogStrToInt("abc", &num));
    EXPECT_EQ(LOG_FAILURE, LogStrToInt("99999999999999999999999999", &num)); // ERANGE
    EXPECT_EQ(LOG_SUCCESS, LogStrToInt("123", &num));
    EXPECT_EQ(123, num);

    // LogStrToUint
    uint32_t unum = 0;
    EXPECT_EQ(LOG_FAILURE, LogStrToUint(NULL, &unum));
    EXPECT_EQ(LOG_FAILURE, LogStrToUint("123", NULL));
    EXPECT_EQ(LOG_FAILURE, LogStrToUint("abc", &unum));
    EXPECT_EQ(LOG_FAILURE, LogStrToUint("99999999999999999999", &unum)); // > UINT_MAX / ERANGE
    EXPECT_EQ(LOG_SUCCESS, LogStrToUint("123", &unum));
    EXPECT_EQ(123U, unum);

    // LogStrToUlong
    uint64_t lnum = 0;
    EXPECT_EQ(LOG_FAILURE, LogStrToUlong(NULL, &lnum));
    EXPECT_EQ(LOG_FAILURE, LogStrToUlong("-1", &lnum)); // negative rejected
    EXPECT_EQ(LOG_FAILURE, LogStrToUlong("abc", &lnum));
    EXPECT_EQ(LOG_SUCCESS, LogStrToUlong("123", &lnum));
    EXPECT_EQ(123ULL, lnum);

    // LogStrCheckNaturalNum
    EXPECT_FALSE(LogStrCheckNaturalNum(NULL));
    EXPECT_FALSE(LogStrCheckNaturalNum(""));
    EXPECT_TRUE(LogStrCheckNaturalNum("0"));
    EXPECT_FALSE(LogStrCheckNaturalNum("00"));
    EXPECT_TRUE(LogStrCheckNaturalNum("123"));
    EXPECT_FALSE(LogStrCheckNaturalNum("12a"));
    EXPECT_FALSE(LogStrCheckNaturalNum("99999999999")); // > INT_MAX

    // LogStrTrimEnd
    LogStrTrimEnd(NULL, 10);
    char s[] = "abc  \t\n/";
    LogStrTrimEnd(s, 100);
    EXPECT_STREQ("abc", s);
    char empty[] = "";
    LogStrTrimEnd(empty, 100);

    // StrcatDir
    char path[256];
    EXPECT_EQ(SYS_ERROR, StrcatDir(NULL, "f", "d", 10));
    EXPECT_EQ(SYS_ERROR, StrcatDir(path, NULL, "d", 10));
    EXPECT_EQ(SYS_ERROR, StrcatDir(path, "f", NULL, 10));
    EXPECT_EQ(SYS_ERROR, StrcatDir(path, "file", "dir", 3)); // overflow
    EXPECT_EQ(SYS_OK, StrcatDir(path, "file", "dir", sizeof(path)));
    EXPECT_STREQ("dirfile", path);

    // LogStrlen
    EXPECT_EQ(0U, LogStrlen(""));
    ResetErrLog();
}
