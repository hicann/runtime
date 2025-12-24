/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <sys/time.h>
#include <dirent.h>
#include <fcntl.h>
#include <pthread.h>
#include <string.h>
#include "log_file_util.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "log_file_util.h"
#include "slogd_syslog.h"

extern "C" {
    #include "securec.h"
    #include "log_to_file.h"
    #include "log_config_api.h"
    #include "slogd_utest_stub.h"
    #include "log_queue.h"
    void FsyncLogToDisk(const char *logPath);
    unsigned int LogAgentMkdir(const char *logPath);
    unsigned int LogAgentInitDeviceApp(StLogFileList *logList, StSubLogFileList *subFileList, LogInfo* logInfo);
    unsigned int LogAgentGetDeviceAppFileList(StSubLogFileList *subFileList);
    unsigned int LogAgentInitDeviceOsMaxFileNum(StLogFileList *logList);
    unsigned int LogAgentGetDeviceFileList(StLogFileList *logList);
    unsigned int LogAgentGetDeviceOsFileList(StLogFileList *logList);
    unsigned int LogAgentWriteDeviceLog(const StLogFileList *logList, char *msg, const DeviceWriteLogInfo *info);
    int32_t GetFileOfSize(StSubLogFileList *pstSubInfo, const StLogDataBlock *pstLogData,
                          const char *pFileName, off_t *filesize);
    bool IsPathValidbyLog(const char *ppath, size_t pathLen);
    bool CheckPathValid(const char *ppath);
    uint32_t GetLocalTimeHelper(size_t bufLen, char *timeBuffer);
    uint32_t LogAgentWriteDataToFile(StSubLogFileList *pstSubInfo, const StLogDataBlock *pstLogData,
                                     char *const aucFileName, size_t aucFileNameLen);
}

#define LLT_SLOG_DIR "llt/abl/slog"
#define TIME_STR_SIZE 32

class LogToFile : public testing::Test {
public:
    void SetUp();
    void TearDown();
};

void LogToFile::SetUp()
{
    MOCKER(LogAgentRemoveFile).stubs().will(returnValue((unsigned int)OK));
}

void LogToFile::TearDown()
{
    GlobalMockObject::reset();
}

TEST_F(LogToFile, GetLocalTime01)
{
    EXPECT_EQ(NOK, GetLocalTimeHelper(0, NULL));
}

TEST_F(LogToFile, GetLocalTime02)
{
    CHAR aucTime[TIME_STR_SIZE + 1] = { 0 };
    MOCKER(ToolLocalTimeR).stubs().will(returnValue(1));
    EXPECT_EQ(NOK, GetLocalTimeHelper(TIME_STR_SIZE, aucTime));
    GlobalMockObject::reset();
}

TEST_F(LogToFile, GetLocalTime03)
{
    CHAR aucTime[TIME_STR_SIZE + 1] = { 0 };
    MOCKER(ToolGetTimeOfDay).stubs().will(returnValue(-1));
    EXPECT_EQ(NOK, GetLocalTimeHelper(TIME_STR_SIZE, aucTime));
    GlobalMockObject::reset();
}

TEST_F(LogToFile, GetLocalTime04)
{
    CHAR aucTime[TIME_STR_SIZE + 1] = { 0 };
    EXPECT_EQ(NOK, GetLocalTimeHelper(1, aucTime));
    GlobalMockObject::reset();
}

TEST_F(LogToFile, GetLocalTime05)
{
    CHAR aucTime[TIME_STR_SIZE + 1] = { 0 };
    EXPECT_EQ(OK, GetLocalTimeHelper(TIME_STR_SIZE, aucTime));
    GlobalMockObject::reset();
}

/***********/
TEST_F(LogToFile, LogAgentRemoveFile01)
{
    GlobalMockObject::reset();
    EXPECT_EQ(NOK, LogAgentRemoveFile((const char*)NULL));
    GlobalMockObject::reset();
}

TEST_F(LogToFile, LogAgentRemoveFile02)
{
    char filename[] = "host-0_20180921173146916.log";
    MOCKER(remove).stubs().will(returnValue(-1));
    MOCKER(ToolChmod).stubs().will(returnValue(-1));
    MOCKER(ToolUnlink).stubs().will(returnValue(-1));
    EXPECT_EQ((unsigned int)0, LogAgentRemoveFile(filename));
    GlobalMockObject::reset();
}

#ifdef PROCESS_LOG
TEST_F(LogToFile, LogMkdirRecur)
{
    const char* path = "/var/log";

    EXPECT_EQ(SUCCESS, LogMkdirRecur(path));
    GlobalMockObject::reset();
}
#endif

TEST_F(LogToFile, LogAgentMkdir01)
{
    const char* path = "/var/log";
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(OK, LogAgentMkdir(path));
    GlobalMockObject::reset();
}

TEST_F(LogToFile, LogAgentMkdir02)
{
    const char* path = "/var/log";
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK + 1));
    MOCKER(LogMkdir).stubs().will(returnValue(SUCCESS + 1));
    EXPECT_EQ(NOK, LogAgentMkdir(path));
    GlobalMockObject::reset();
}

TEST_F(LogToFile, LogAgentMkdir03)
{
    const char* path = "/var/log";
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK + 1));
    MOCKER(LogMkdir).stubs().will(returnValue(SUCCESS));
    EXPECT_EQ(OK, LogAgentMkdir(path));
    GlobalMockObject::reset();
}

#define NUMBER_ZERO 0
#define NUMBER_FOUR 4
#define NUMBER_THREE 3
#define NUMBER_SEVEN 7

TEST_F(LogToFile, GetFileSizeOverFlow)
{
    StSubLogFileList stSubInfo;
    StLogDataBlock stLogData;
    stLogData.ulDataLen = 4294967295;
    off_t filesize = 1000;
    CHAR aucfilename[MAX_FILEPATH_LEN + MAX_FILENAME_LEN + 1] = "";
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    MOCKER(IsPathValidbyLog).stubs().will(returnValue(true));
    MOCKER(FsyncLogToDisk).stubs();
    EXPECT_EQ(NOK, GetFileOfSize(&stSubInfo, &stLogData, aucfilename, &filesize));
    GlobalMockObject::reset();
}

TEST_F(LogToFile, LogAgentGetDeviceOsFileList01)
{
    EXPECT_EQ(NOK, LogAgentGetDeviceOsFileList(NULL));
}

TEST_F(LogToFile, LogAgentGetDeviceOsFileList02)
{
    StLogFileList pstLogFileInfo;
    MOCKER(LogAgentGetFileListForModule).stubs().will(returnValue(NOK));
    EXPECT_EQ(NOK, LogAgentGetDeviceOsFileList(&pstLogFileInfo));
    GlobalMockObject::reset();
}

TEST_F(LogToFile, LogAgentInitDeviceOsMaxFileNum01)
{
    StLogFileList stInfo;
    strcpy(stInfo.aucFilePath, LLT_SLOG_DIR "/ut/slog/res");
    EXPECT_EQ((unsigned int)NOK, LogAgentInitDeviceOsMaxFileNum(NULL));
    MOCKER(LogAgentInitMaxFileNumHelper).stubs().will(returnValue((unsigned int)OK));
    EXPECT_EQ((unsigned int)OK, LogAgentInitDeviceOsMaxFileNum(&stInfo));
    GlobalMockObject::reset();
}

TEST_F(LogToFile, LogAgentInitDeviceOs01)
{
    EXPECT_EQ(LOG_FAILURE, SlogdSyslogMgrInit(NULL));
}

TEST_F(LogToFile, LogAgentInitDeviceOs02)
{
    MOCKER(LogAgentGetCfg).stubs().will(returnValue(LOG_INVALID_PTR));
    EXPECT_EQ(LOG_FAILURE, SlogdFlushInit());
    GlobalMockObject::reset();
}

TEST_F(LogToFile, LogAgentWriteDeviceOsLog01)
{
    EXPECT_EQ(NOK, LogAgentWriteDeviceOsLog(DEBUG_LOG, NULL, NULL, 0));
}

TEST_F(LogToFile, LogAgentWriteDeviceOsLog02)
{
    char msg[] = "No such file or directry.";
    StLogFileList stLogFileInfo;
    MOCKER(LogAgentWriteFile).stubs().will(returnValue(NOK));
    EXPECT_EQ(NOK, LogAgentWriteDeviceOsLog(DEBUG_LOG, &(stLogFileInfo.sortDeviceOsLogList[0]), msg, 0));
    GlobalMockObject::reset();
}

TEST_F(LogToFile, LogAgentWriteDeviceOsLog03)
{
    char msg[] = "No such file or directry.";
    StLogFileList stLogFileInfo;
    MOCKER(LogAgentWriteFile).stubs().will(returnValue((unsigned int)OK));
    EXPECT_EQ((unsigned int)OK, LogAgentWriteDeviceOsLog(DEBUG_LOG, &(stLogFileInfo.sortDeviceOsLogList[0]), msg, strlen(msg)));
    GlobalMockObject::reset();
}

TEST_F(LogToFile, LogAgentCleanUpDevice)
{
    char dir[] = LLT_SLOG_DIR "/ut/slog/res";
    StLogFileList pstLogFileInfo = { 0 };
    uint32_t deviceNum = 2;
    pstLogFileInfo.ucDeviceNum = deviceNum;
    size_t len = sizeof(StSubLogFileList) * deviceNum;
    for (uint32_t iType = 0; iType < LOG_TYPE_NUM; iType++) {
        pstLogFileInfo.deviceLogList[iType] = (StSubLogFileList *)malloc(len);
        for (uint32_t idx = 0; idx < deviceNum; idx++) {
            LogAgentInitMaxFileNumHelper(&pstLogFileInfo.deviceLogList[iType][idx], dir, 1);
        }
    }
    LogAgentCleanUpDevice(&pstLogFileInfo);
    for (uint32_t iType = 0; iType < LOG_TYPE_NUM; iType++) {
        EXPECT_EQ(NULL, pstLogFileInfo.deviceLogList[iType]);
    }
    GlobalMockObject::reset();
}

TEST_F(LogToFile, LogAgentGetDeviceFileList01)
{
    EXPECT_EQ(NOK, LogAgentGetDeviceFileList(NULL));
}

TEST_F(LogToFile, LogAgentGetDeviceFileList02)
{
    StLogFileList pstLogFileInfo;
    pstLogFileInfo.ucDeviceNum = 1;
    pstLogFileInfo.deviceLogList[0] = (StSubLogFileList *)malloc(sizeof(StSubLogFileList));
    MOCKER(LogAgentGetFileListForModule).stubs().will(returnValue(NOK));
    EXPECT_EQ(NOK, LogAgentGetDeviceFileList(&pstLogFileInfo));
    free(pstLogFileInfo.deviceLogList[0]);
    pstLogFileInfo.deviceLogList[0] = NULL;
    GlobalMockObject::reset();
}

TEST_F(LogToFile, LogAgentInitDeviceMaxFileNum01)
{
    EXPECT_EQ(NOK, LogAgentInitDeviceMaxFileNum(NULL));
    GlobalMockObject::reset();
}

TEST_F(LogToFile, LogAgentInitDeviceMaxFileNum02)
{
    StLogFileList stLogFileInfo;
    strcpy(stLogFileInfo.aucFilePath, LLT_SLOG_DIR "/ut/slog/res");
    stLogFileInfo.ucDeviceNum = 1;
    stLogFileInfo.deviceLogList[0] = (StSubLogFileList *)malloc(sizeof(StSubLogFileList));
    MOCKER(LogAgentInitMaxFileNumHelper).stubs().will(returnValue(NOK));
    EXPECT_EQ(NOK, LogAgentInitDeviceMaxFileNum(&stLogFileInfo));
    free(stLogFileInfo.deviceLogList[0]);
    stLogFileInfo.deviceLogList[0] = NULL;
    GlobalMockObject::reset();
}

TEST_F(LogToFile, LogAgentInitDevice01)
{
    EXPECT_EQ(LOG_INVALID_PARAM, LogAgentInitDevice(NULL, 0));
}

TEST_F(LogToFile, LogAgentInitDevice03)
{
    StLogFileList stLogFileInfo = { 0 };
    stLogFileInfo.ucDeviceNum = 1;
    MOCKER(LogAgentInitDeviceMaxFileNum).stubs().will(returnValue((unsigned int)OK));
    MOCKER(LogAgentGetDeviceFileList).stubs().will(returnValue((unsigned int)OK));
    EXPECT_EQ((unsigned int)OK, LogAgentInitDevice(&stLogFileInfo, 1));
    XFREE(stLogFileInfo.deviceLogList[0]);
    GlobalMockObject::reset();
    LogAgentCleanUpDevice(&stLogFileInfo);
}

TEST_F(LogToFile, LogAgentWriteDeviceLog01)
{
    EXPECT_EQ(NOK, LogAgentWriteDeviceLog(NULL, NULL, 0));
}

TEST_F(LogToFile, LogAgentWriteDeviceLog02)
{
    char msg[] = "No such file or directry.";
    DeviceWriteLogInfo info = { 0 };
    StLogFileList stLogFileInfo;
    stLogFileInfo.ucDeviceNum = 10;
    info.deviceId = 15;
    EXPECT_EQ(NOK, LogAgentWriteDeviceLog(&stLogFileInfo, msg, &info));
    GlobalMockObject::reset();
}

TEST_F(LogToFile, LogAgentWriteDeviceLog03)
{
    char msg[] = "No such file or directry.";
    DeviceWriteLogInfo info = { 0 };
    StLogFileList stLogFileInfo;
    stLogFileInfo.ucDeviceNum = 10;
    stLogFileInfo.deviceLogList[0] = NULL;
    info.deviceId = 8;
    EXPECT_EQ(NOK, LogAgentWriteDeviceLog(&stLogFileInfo, msg, &info));
    GlobalMockObject::reset();
}

TEST_F(LogToFile, LogAgentWriteDeviceLog04)
{
    char msg[] = "No such file or directry.";
    DeviceWriteLogInfo info = { 0 };
    StLogFileList stLogFileInfo;
    StSubLogFileList stSubLogFileList;
    stLogFileInfo.ucDeviceNum = 10;
    stLogFileInfo.deviceLogList[0] = &stSubLogFileList;
    info.deviceId = 8;
    info.logType = LOG_TYPE_NUM;
    EXPECT_EQ(OK,LogAgentWriteDeviceLog(&stLogFileInfo, msg, &info));
    GlobalMockObject::reset();
}

TEST_F(LogToFile, LogAgentGetDeviceAppFileList01)
{
    EXPECT_EQ(NOK, LogAgentGetDeviceAppFileList(NULL));
}

TEST_F(LogToFile, LogAgentGetDeviceAppFileList02)
{
    StSubLogFileList list;
    MOCKER(LogAgentGetFileListForModule).stubs().will(returnValue(NOK));
    EXPECT_EQ(NOK, LogAgentGetDeviceAppFileList(&list));
    GlobalMockObject::reset();
}

TEST_F(LogToFile, LogAgentInitDeviceApp01)
{
    EXPECT_EQ(NOK, LogAgentInitDeviceApp(NULL, NULL, NULL));
}

TEST_F(LogToFile, LogAgentInitDeviceApp02)
{
    StLogFileList info;
    StSubLogFileList subInfo;
    LogInfo logInfo;
    logInfo.pid = 0;
    logInfo.type = DEBUG_LOG;
    strcpy(info.aucFilePath, LLT_SLOG_DIR "/ut/slog/res");
    MOCKER(LogAgentInitMaxFileNumHelper).stubs().will(returnValue((unsigned int)OK));
    MOCKER(LogAgentGetDeviceAppFileList).stubs().will(returnValue((unsigned int)OK));
    EXPECT_EQ((unsigned int)OK, LogAgentInitDeviceApp(&info, &subInfo, &logInfo));
    GlobalMockObject::reset();
}

TEST_F(LogToFile, LogAgentWriteDeviceApplicationLogNull)
{
    EXPECT_EQ(NOK, LogAgentWriteDeviceApplicationLog(NULL, 0, NULL, NULL));
}

TEST_F(LogToFile, LogAgentWriteDeviceApplicationLogSysInfo)
{
    char msg[] = "0[DEBUG] DRV(2677,aicpu_scheduler):2023-01-17-05:40:51.376.919 device app log.";
    unsigned int length = strlen(msg);
    LogInfo info;
    info.processType = SYSTEM;
    StLogFileList *logList;
    EXPECT_EQ(NOK, LogAgentWriteDeviceApplicationLog(msg, length, &info, logList));
    GlobalMockObject::reset();
}

TEST_F(LogToFile, LogAgentWriteDeviceApplicationLog)
{
    char msg[] = "[DEBUG] DRV(2677,aicpu_scheduler):2023-01-17-05:40:51.376.919 device app log.";
    unsigned int length = strlen(msg);
    LogInfo info;
    info.processType = APPLICATION;
    StLogFileList *logList;
    MOCKER(LogAgentInitDeviceApp).stubs().will(returnValue((unsigned int)OK));
    MOCKER(LogAgentWriteFile).stubs().will(returnValue((unsigned int)1));
    EXPECT_EQ((unsigned int)1, LogAgentWriteDeviceApplicationLog(msg, length, &info, logList));
    GlobalMockObject::reset();
}

TEST_F(LogToFile, LogAgentWriteDeviceApplicationLog_withTag)
{
    char msg[] = "0[DEBUG] DRV(2677,aicpu_scheduler):2023-01-17-05:40:51.376.919 device app log.";
    unsigned int length = strlen(msg);
    LogInfo info;
    info.processType = APPLICATION;
    StLogFileList *logList;
    MOCKER(LogAgentInitDeviceApp).stubs().will(returnValue((unsigned int)OK));
    MOCKER(LogAgentWriteFile).stubs().will(returnValue((unsigned int)1));
    EXPECT_EQ((unsigned int)1, LogAgentWriteDeviceApplicationLog(msg, length, &info, logList));
    GlobalMockObject::reset();
}

TEST_F(LogToFile, GetValidPath_Failed)
{
    char path[10] = { 0 };
    char validPath[10] = { 0 };
    EXPECT_EQ(SYS_ERROR, GetValidPath(NULL, 0, NULL, 0));

    MOCKER(CheckPathValid).stubs().will(returnValue(false));
    EXPECT_EQ(SYS_ERROR, GetValidPath(path, 10, validPath, 10));
    GlobalMockObject::reset();

    MOCKER(CheckPathValid).stubs().will(returnValue(true));
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(SYS_ERROR, GetValidPath(path, 10, validPath, 10));
    GlobalMockObject::reset();
}