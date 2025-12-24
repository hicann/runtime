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
#include "slogd_appnum_watch.h"
#include "slogd_config_mgr.h"
#include "log_file_info.h"
#include "log_pm_sig.h"
extern "C" {
#include "log_common.h"
#include "log_config_api.h"
#include "log_path_mgr.h"
#include <sys/inotify.h>

#define MAX_FILE_NAME_LEN 256

typedef struct {
    ToolStat aStatbuff;
    ToolStat bStatbuff;
    ToolStat aDirStatbuff;
    ToolStat bDirStatbuff;
    ToolDirent **listA;
    ToolDirent **listB;
    char aDirName[MAX_FILE_NAME_LEN];
    char bDirName[MAX_FILE_NAME_LEN];
    char aFileName[MAX_FILE_NAME_LEN];
    char bFileName[MAX_FILE_NAME_LEN];
} SortArg;

LogRt CheckAppDirIfExist(const char *appLogPath);
void *AppLogWatcher(ArgPtr arg);
int AppLogDirFilter(const ToolDirent *dir);
int AppLogFileFilter(const ToolDirent *dir);
int SlogdApplogSortFileFunc(const char *path, const ToolDirent **a, const ToolDirent **b);
int RemoveDir(const char *dir);
void RemoveAppLogDir(int logType, const char *dir);
LogRt ScanAppLog(const char *path, int logType);
void CreateThread(int logType);
void CreateAppLogWatchThread();
INT32 ScanAndGetDirFile(SortArg *sortArg, const char *path, const ToolDirent **a, const ToolDirent **b);
extern INT32 GetSortResult(SortArg *sortArg, int type, int numA, int numB);
}

class AppLogWatch : public testing::Test
{
public:
    void SetUp();
    void TearDown();
};

void AppLogWatch::SetUp()
{

}

void AppLogWatch::TearDown()
{

}

TEST_F(AppLogWatch, CheckAppDirIfExist01)
{
    const char *path = "/var/log";
    MOCKER(access).stubs().will(returnValue(1));
    MOCKER(ToolMkdir).stubs().will(returnValue(-1));
    EXPECT_EQ(MKDIR_FAILED, CheckAppDirIfExist(path));
    GlobalMockObject::reset();
}

TEST_F(AppLogWatch, CheckAppDirIfExist02)
{
    const char *path = "/var/log";
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER(ToolMkdir).stubs().will(returnValue(0));
    EXPECT_EQ(SUCCESS, CheckAppDirIfExist(path));
    GlobalMockObject::reset();
}

typedef struct {
    int logType;
    char appLogPath[CFG_LOGAGENT_PATH_MAX_LENGTH + 1];
} ThreadArg;

int SetState02() {
    LogRecordSigNo(1);
    return 0;
}

TEST_F(AppLogWatch, AppLogWatcher01)
{
    ThreadArg arg[LOG_TYPE_NUM];
    arg[0].logType = DEBUG_LOG;
    strcpy_s(arg[0].appLogPath, CFG_LOGAGENT_PATH_MAX_LENGTH, "/var/log");
    LogRecordSigNo(0);
    MOCKER(ToolSetThreadName).stubs().will(returnValue(-1));
    MOCKER(CheckAppDirIfExist).stubs().will(returnValue(SUCCESS));
    MOCKER(ScanAppLog).stubs().will(invoke(SetState02));
    EXPECT_EQ((void*)NULL, AppLogWatcher((ArgPtr)&arg));
    GlobalMockObject::reset();
}

TEST_F(AppLogWatch, AppLogDirFilter01)
{
    ToolDirent *namelist = NULL;
    namelist = (ToolDirent *)malloc(sizeof(ToolDirent));
    strcpy_s(namelist->d_name, 256, "core.123456");
    EXPECT_EQ(0, AppLogDirFilter(namelist));
    free(namelist);
    namelist = NULL;
}

TEST_F(AppLogWatch, AppLogFileFilter01)
{
    ToolDirent *namelist = NULL;
    namelist = (ToolDirent *)malloc(sizeof(ToolDirent));
    strcpy_s(namelist->d_name, 256, "core");
    EXPECT_EQ(0, AppLogFileFilter(namelist));
    free(namelist);
    namelist = NULL;
}

TEST_F(AppLogWatch, GetSortResult01)
{
    SortArg sortArg;
    memset(&sortArg, 0, sizeof(sortArg));
    ToolDirent **list = (ToolDirent**)malloc(sizeof(ToolDirent*) * 1);
    list[0] = (ToolDirent *)malloc(sizeof(ToolDirent));
    strcpy_s(list[0]->d_name, 256, "1.log");
    sortArg.listB = list;
    int type = 0;
    int numA = 0;
    int numB = 1;
    MOCKER(ToolStatGet).stubs().will(returnValue(0));
    EXPECT_EQ(0, GetSortResult(&sortArg, type, numA, numB));
    free(list[0]);
    free(list);
    list = NULL;
    GlobalMockObject::reset();
}

TEST_F(AppLogWatch, GetSortResult02)
{
    SortArg sortArg;
    memset(&sortArg, 0, sizeof(sortArg));
    ToolDirent **list = (ToolDirent**)malloc(sizeof(ToolDirent*) * 1);
    list[0] = (ToolDirent *)malloc(sizeof(ToolDirent));
    strcpy_s(list[0]->d_name, 256, "1.log");
    sortArg.listA = list;
    int type = 1;
    int numA = 1;
    int numB = 0;
    MOCKER(ToolStatGet).stubs().will(returnValue(0));
    EXPECT_EQ(0, GetSortResult(&sortArg, type, numA, numB));
    free(list[0]);
    free(list);
    list = NULL;
    GlobalMockObject::reset();
}

TEST_F(AppLogWatch, SortFileFunc01)
{
    EXPECT_EQ(1, SlogdApplogSortFileFunc(NULL, NULL, NULL));
    GlobalMockObject::reset();
}

TEST_F(AppLogWatch, SortFileFunc02)
{
    const char *path = "/var/log";
    const struct dirent a[] = { 0, 0, 0, 0, "device-0_20180807190224530.log" };
    const struct dirent b[] = { 0, 0, 0, 0, "device-0_20180807190224529.log" };
    const struct dirent* c = a;
    const struct dirent* d = b;
    const struct dirent** e = &c;
    const struct dirent** f = &d;
    ToolStat astatbuff = { 0 };
    astatbuff.st_ctime = 125;
    MOCKER(ToolScandir).stubs().will(returnValue(0));
    MOCKER(ToolScandirFree).stubs();
    EXPECT_EQ(0, SlogdApplogSortFileFunc(path, e, f));
    GlobalMockObject::reset();
}

TEST_F(AppLogWatch, SortFileFunc03)
{
    const char *path = "/var/log";
    const struct dirent a[] = { 0, 0, 0, 0, "device-0_20180807190224530.log" };
    const struct dirent b[] = { 0, 0, 0, 0, "device-0_20180807190224529.log" };
    const struct dirent* c = a;
    const struct dirent* d = b;
    const struct dirent** e = &c;
    const struct dirent** f = &d;
    ToolDirent **namelist = (ToolDirent**)malloc(sizeof(ToolDirent*) * 1);
    namelist[0] = (ToolDirent *)malloc(sizeof(ToolDirent));
    memset(namelist[0], 0, sizeof(ToolDirent));
    strcpy_s(namelist[0]->d_name, 256, "1.log");
    MOCKER(ToolScandir).stubs().with(any(), outBoundP(&namelist), any(), any()).will(returnValue(1));

    ToolStat astatbuff = { 0 };
    astatbuff.st_ctime = 125;
    MOCKER(ToolStatGet).stubs().with(any(), outBoundP(&astatbuff)).will(returnValue(0));
    MOCKER(ToolScandir).stubs().will(returnValue(0));
    MOCKER(ToolScandirFree).stubs();
    EXPECT_EQ(0, SlogdApplogSortFileFunc(path, e, f));
    free(namelist[0]);
    free(namelist);
    GlobalMockObject::reset();
}

TEST_F(AppLogWatch, SortFileFunc04)
{
    const char *path = "/var/log";
    const struct dirent a[] = { 0, 0, 0, 0, "device-0_20180807190224530.log" };
    const struct dirent b[] = { 0, 0, 0, 0, "device-0_20180807190224529.log" };
    const struct dirent* c = a;
    const struct dirent* d = b;
    const struct dirent** e = &c;
    const struct dirent** f = &d;
    ToolDirent **namelist = (ToolDirent**)malloc(sizeof(ToolDirent*) * 1);
    namelist[0] = (ToolDirent *)malloc(sizeof(ToolDirent));
    memset(namelist[0], 0, sizeof(ToolDirent));
    strcpy_s(namelist[0]->d_name, 256, "1.log");
    MOCKER(ToolScandir).stubs().with(any(), outBoundP(&namelist), any(), any()).will(returnValue(1));

    ToolStat astatbuff = { 0 };
    astatbuff.st_ctime = 125;
    MOCKER(ToolStatGet).stubs().with(any(), outBoundP(&astatbuff)).will(returnValue(1));
    MOCKER(ToolScandir).stubs().will(returnValue(0));
    MOCKER(ToolScandirFree).stubs();
    EXPECT_EQ(1, SlogdApplogSortFileFunc(path, e, f));
    free(namelist[0]);
    free(namelist);
    GlobalMockObject::reset();
}

TEST_F(AppLogWatch, RemoveDir01)
{
    char srcName[] = "/tmp/coredump/core.123";
    MOCKER(ToolScandir).stubs().will(returnValue(0));
    MOCKER(rmdir).stubs().will(returnValue(0));
    EXPECT_EQ(SYS_OK, RemoveDir(srcName));
    GlobalMockObject::reset();
}

TEST_F(AppLogWatch, RemoveDir02)
{
    const char* path = "/var/log";
    ToolDirent **namelist = (ToolDirent**)malloc(sizeof(ToolDirent*) * 1);
    namelist[0] = (ToolDirent *)malloc(sizeof(ToolDirent));
    memset(namelist[0], 0, sizeof(ToolDirent));
    strcpy_s(namelist[0]->d_name, 256, "1.log");
    MOCKER(ToolScandir).stubs().with(any(), outBoundP(&namelist), any(), any()).will(returnValue(1));
    MOCKER(ToolScandirFree).stubs();
    MOCKER(remove).stubs().will(returnValue(0));
    MOCKER(rmdir).stubs().will(returnValue(0));
    EXPECT_EQ(SYS_OK, RemoveDir(path));
    free(namelist[0]);
    free(namelist);
    GlobalMockObject::reset();
}

TEST_F(AppLogWatch, RemoveDir03)
{
    const char* path = "/var/log";
    ToolDirent **namelist = (ToolDirent**)malloc(sizeof(ToolDirent*) * 1);
    namelist[0] = (ToolDirent *)malloc(sizeof(ToolDirent));
    memset(namelist[0], 0, sizeof(ToolDirent));
    strcpy_s(namelist[0]->d_name, 256, "1.log");
    MOCKER(ToolScandir).stubs().with(any(), outBoundP(&namelist), any(), any()).will(returnValue(1));
    MOCKER(ToolScandirFree).stubs();
    MOCKER(remove).stubs().will(returnValue(SYS_OK + 1));
    MOCKER(rmdir).stubs().will(returnValue(0));
    EXPECT_EQ(SYS_ERROR, RemoveDir(path));
    free(namelist[0]);
    free(namelist);
    GlobalMockObject::reset();
}

TEST_F(AppLogWatch, ScanAppLog01)
{
    const char* path = "/var/log";
    MOCKER(ToolScandir).stubs().will(returnValue(-1));
    EXPECT_EQ(SCANDIR_DIR_FAILED, ScanAppLog(path, DEBUG_LOG));
    GlobalMockObject::reset();
}

TEST_F(AppLogWatch, ScanAppLog03)
{
    const char* path = "/var/log";
    ToolDirent **namelist = (ToolDirent**)malloc(sizeof(ToolDirent*) * 2);
    namelist[0] = (ToolDirent *)malloc(sizeof(ToolDirent));
    namelist[1] = (ToolDirent *)malloc(sizeof(ToolDirent));
    strcpy_s(namelist[0]->d_name, 256, "core.123456");
    strcpy_s(namelist[1]->d_name, 256, "core.123456");
    MOCKER(ToolScandir).stubs().with(any(), outBoundP(&namelist), any(), any()).will(returnValue(2));
    MOCKER(ToolScandirFree).stubs();
    EXPECT_EQ(SUCCESS, ScanAppLog(path, DEBUG_LOG));
    free(namelist[0]);
    free(namelist[1]);
    free(namelist);
    GlobalMockObject::reset();
}

#define MAX_RESERVE_APP_DIR_NUMS 48
TEST_F(AppLogWatch, ScanAppLog04)
{
    const char* path = "/var/log";
    const int maxDirNum = MAX_RESERVE_APP_DIR_NUMS + 1;
    ToolDirent **namelist = (ToolDirent**)malloc(sizeof(ToolDirent*) * maxDirNum);
    if (namelist == NULL) {
        printf("malloc failed.\n");
        return;
    }
    (void)memset_s(namelist, sizeof(ToolDirent*) * maxDirNum, 0, sizeof(ToolDirent*) * maxDirNum);
    for (int i = 0; i < maxDirNum; i++) {
        namelist[i] = (ToolDirent *)malloc(sizeof(ToolDirent));
        if (namelist[i] == NULL) {
            printf("malloc failed.\n");
            goto TEST_END;
        }
        int ret = snprintf_s(namelist[i]->d_name, 256, 255, "device-app-%d", i);
        if (ret <= 0) {
            printf("copy failed.\n");
            goto TEST_END;
        }
    }
    MOCKER(ToolScandir).stubs().with(any(), outBoundP(&namelist), any(), any()).will(returnValue(maxDirNum));
    MOCKER(SlogdApplogSortFileFunc).stubs().will(returnValue(1));
    MOCKER(RemoveAppLogDir).stubs();
    MOCKER(ToolScandirFree).stubs();
    EXPECT_EQ(SUCCESS, ScanAppLog(path, DEBUG_LOG));
    GlobalMockObject::reset();

TEST_END:
    for (int i = 0; i < maxDirNum; i++) {
        if (namelist[i] != NULL) {
            free(namelist[i]);
            namelist[i] = NULL;
        }
    }
    free(namelist);
    namelist = NULL;
}
