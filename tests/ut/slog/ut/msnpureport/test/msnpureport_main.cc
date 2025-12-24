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
#include "log_file_util.h"
#include "msnpureport_common.h"
#include "msnpureport_report.h"
#include "msnpureport_file_mgr.h"
#include "msnpureport_print.h"
#include "msnpureport_options_old.h"
#include "msnpureport_utils.h"
#include "bbox_dump_lib.h"
#include "log_communication.h"

extern "C" {
#include "securec.h"
#include "mmpa_api.h"
#include "msn_operate_log_level.h"
#include "ascend_hal.h"
#include "msnpureport_stub.h"
#include "errno.h"

extern int MsnTest(int argc, char **argv);
extern int GetOptions(int argc, char **argv, ArgInfo *opts);
extern int RequestHandle(const ArgInfo *argInfo);
extern int InitArgInfoLevel(ArgInfo *opts, const char *optarg);
extern void OptionsUsage(void);
extern int GetHelpInfo(ArgInfo *opts);
extern int InitArgInfoLevelByNoParameterOption(ArgInfo *opts);
extern bool MsnIsDockerEnv(void);
extern bool IsHaveExecPermission(void);
extern int SetDockerFlag(ArgInfo *opts);
extern int32_t SyncDeviceLog(const struct BboxDumpOpt *opt, int32_t logType);
extern int32_t MsnFileMgrDeviceInit(int32_t devId);
extern uint32_t MsnFileMgrGetTimeStr(char *timeStr, uint32_t len);
extern int32_t MsnFileMgrRemoveFile(const char *filename);
}

using namespace std;
using namespace testing;

class MsnpureportMain : public testing::Test
{
    protected:
        static void SetUpTestCase()
        {
            cout << "msnpureport_main SetUP" <<endl;
            system("mkdir -p " PATH_ROOT);
            chdir(PATH_ROOT);
        }
        static void TearDownTestCase()
        {
            cout << "msnpureport_main TearDown" << endl;
        }
        virtual void SetUp()
        {
            optind = 1;
            MsnSetLogPrintMode(1);
            cout << "a test SetUP" << endl;
        }
        virtual void TearDown()
        {
            system("rm -rf " PATH_ROOT "/*");
            cout << "a test TearDown" << endl;
            GlobalMockObject::verify();
        }
};

TEST_F(MsnpureportMain, test)
{
    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(false));
    MOCKER(IsHaveExecPermission).stubs().will(returnValue(true));
    char *argv[] = {"msnpureport", "--docker"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(2, argv));
    char *argv1[] = {"msnpureport"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(1, argv1));
    char *argv2[] = {"msnpureport", "-a"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(2, argv2));
    char *argv3[] = {"msnpureport", "-f"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(2, argv3));
    char *argv4[] = {"msnpureport", "-t", "0"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(3, argv4));
    char *argv5[] = {"msnpureport", "-t", "1"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(3, argv5));
    char *argv6[] = {"msnpureport", "-t", "2"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(3, argv6));
    char *argv7[] = {"msnpureport", "-t", "3"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(3, argv7));
    char *argv8[] = {"msnpureport", "-r"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(2, argv8));
    char *argv9[] = {"msnpureport", "-d", "1"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv9));
    char *argv10[] = {"msnpureport", "-d", "0"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv10));
    char *argv11[] = {"msnpureport", "-g", "info", "test"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(4, argv11));
    char *argv14[] = {"msnpureport", "-t", "5"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(3, argv14));
    char *argv15[] = {"msnpureport", "-t", "6"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv15));
}

TEST_F(MsnpureportMain, GetHelpInfo1)
{
    ArgInfo argInfo;
    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(false));
    MOCKER(IsHaveExecPermission).stubs().will(returnValue(true));
    EXPECT_EQ(EN_INVALID_PARAM, GetHelpInfo(&argInfo));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, test1)
{
    MOCKER(mmGetTimeOfDay).stubs().will(returnValue(EN_ERROR));
    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(false));
    MOCKER(IsHaveExecPermission).stubs().will(returnValue(true));
    char *argv[] = {"msnpureport"};
    EXPECT_EQ(EN_ERROR, MsnTest(1, argv));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, test2)
{
    MOCKER(mmLocalTimeR).stubs().will(returnValue(EN_ERROR));
    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(false));
    MOCKER(IsHaveExecPermission).stubs().will(returnValue(true));
    char *argv[] = {"msnpureport"};
    EXPECT_EQ(EN_ERROR, MsnTest(1, argv));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, test3)
{
    MOCKER(calloc).stubs().will(returnValue((void *)NULL));
    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(false));
    MOCKER(IsHaveExecPermission).stubs().will(returnValue(true));
    char *argv[] = {"msnpureport"};
    EXPECT_EQ(EN_ERROR, MsnTest(1, argv));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, test4)
{
    MOCKER(mmGetCwd).stubs().will(returnValue(EN_ERROR));
    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(false));
    MOCKER(IsHaveExecPermission).stubs().will(returnValue(true));
    char *argv[] = {"msnpureport"};
    EXPECT_EQ(EN_ERROR, MsnTest(1, argv));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, CreateLogRootPathFailed)
{
    MOCKER(vsprintf_s).stubs().will(returnValue(-1));
    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(false));
    MOCKER(IsHaveExecPermission).stubs().will(returnValue(true));
    char *argv[] = {"msnpureport"};
    EXPECT_EQ(EN_ERROR, MsnTest(1, argv));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, test6)
{
    MOCKER(mmAccess).stubs().will(returnValue(EN_ERROR));
    MOCKER(mmMkdir).stubs().will(returnValue(EN_ERROR));
    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(false));
    MOCKER(IsHaveExecPermission).stubs().will(returnValue(true));
    char *argv[] = {"msnpureport"};
    EXPECT_EQ(EN_ERROR, MsnTest(1, argv));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, drvGetDevNumFailed)
{
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(drvGetDevNum).stubs().will(returnValue(1));
    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(false));
    MOCKER(IsHaveExecPermission).stubs().will(returnValue(true));
    char *argv[] = {"msnpureport"};
    EXPECT_EQ(EN_ERROR, MsnTest(1, argv));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, drvGetDevIDsFailed)
{
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(drvGetDevIDs).stubs().will(returnValue(1));
    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(false));
    MOCKER(IsHaveExecPermission).stubs().will(returnValue(true));
    char *argv[] = {"msnpureport"};
    EXPECT_EQ(EN_ERROR, MsnTest(1, argv));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, test10)
{
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(false));
    MOCKER(IsHaveExecPermission).stubs().will(returnValue(true));
    char *argv[] = {"msnpureport"};
    EXPECT_EQ(EN_OK, MsnTest(1, argv));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, drvDeviceGetPhyIdByIndexFailed)
{
    unsigned int devNum = 4;
    unsigned int ids[64] = { 0 };
    ids[0] = 65;

    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(drvGetDevNum).stubs().with(outBoundP(&devNum)).will(returnValue(EN_OK));
    MOCKER(drvGetDevIDs).stubs().with(outBoundP(ids), any()).will(returnValue(EN_OK));
    MOCKER(drvDeviceGetPhyIdByIndex).stubs().will(returnValue(1)).then(returnValue(0));
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(1)).then(returnValue(0));
    MOCKER(mmCreateTaskWithThreadAttr).stubs().will(returnValue(EN_ERROR));
    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(false));
    MOCKER(IsHaveExecPermission).stubs().will(returnValue(true));
    char *argv[] = {"msnpureport"};
    EXPECT_EQ(EN_ERROR, MsnTest(1, argv));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, test12)
{
    unsigned int devNum = 1;
    unsigned int ids[64] = { 0 };

    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(drvGetDevNum).stubs().with(outBoundP(&devNum)).will(returnValue(EN_OK));
    MOCKER(drvGetDevIDs).stubs().with(outBoundP(ids), any()).will(returnValue(EN_OK));
    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(false));
    MOCKER(IsHaveExecPermission).stubs().will(returnValue(true));
    char *argv[] = {"msnpureport"};
    EXPECT_EQ(EN_OK, MsnTest(1, argv));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, test_ExportFilesInDockerWithoutOperation)
{
    // export files in docker, but not use "--docker"
    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(true));
    char *argv[] = {"msnpureport"};
    EXPECT_EQ(EN_ERROR, MsnTest(1, argv));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, test_ExportFilesInVirtualDocker)
{
    // export files in virtual docker, get physical id from driver will failed
    MOCKER(drvDeviceGetPhyIdByIndex).stubs().will(returnValue(1));

    char *argv[2] = { "msnpureport", "--docker"};
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(true));
    MOCKER(IsHaveExecPermission).stubs().will(returnValue(true));
    EXPECT_EQ(EN_ERROR, MsnTest(2, argv));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, GetOptions)
{
    EXPECT_EQ(EN_ERROR, GetOptions(0, NULL, NULL));
    GlobalMockObject::reset();
    OptionsUsage();
    MOCKER(OptionsUsage).stubs().will(ignoreReturnValue());
    
    ArgInfo opts = {INVALID_CMD, (uint32_t)INVALID_TYPE, 0, 0, -1, 0, false, {0}};
    MOCKER(mmGetOptLong).stubs().will(invoke(getopt_long));

    char *argv[5] = { "msnpureport", "-d", "1", "-g", "info:FMK" };
    EXPECT_EQ(EN_ERROR, GetOptions(5, argv, &opts));
    MOCKER(mmGetOptLong).stubs().will(returnValue(-1));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, GetOptions1)
{
    EXPECT_EQ(EN_ERROR, GetOptions(0, NULL, NULL));
    GlobalMockObject::reset();
    OptionsUsage();
    MOCKER(OptionsUsage).stubs().will(ignoreReturnValue());

    ArgInfo opts = {INVALID_CMD, (uint32_t)INVALID_TYPE, 0, 0, -1, 0, false, {0}};
    MOCKER(mmGetOptLong).stubs().will(returnValue(109));
    char *argv2[3] = { "msnpureport", "-m", "info" };
    EXPECT_EQ(EN_ERROR, GetOptions(3, argv2, &opts));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, GetOptions2)
{
    EXPECT_EQ(EN_ERROR, GetOptions(0, NULL, NULL));
    GlobalMockObject::reset();
    OptionsUsage();
    MOCKER(OptionsUsage).stubs().will(ignoreReturnValue());

    ArgInfo opts = {INVALID_CMD, (uint32_t)INVALID_TYPE, 0, 0, -1, 0, false, {0}};
    MOCKER(mmGetOptLong).stubs().will(returnValue(109));
    char *argv2[3] = { "msnpureport", "-m", "info:FMK" };
    EXPECT_EQ(EN_ERROR, GetOptions(3, argv2, &opts));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, GetOptions3)
{
    EXPECT_EQ(EN_ERROR, GetOptions(0, NULL, NULL));
    GlobalMockObject::reset();
    OptionsUsage();
    MOCKER(OptionsUsage).stubs().will(ignoreReturnValue());

    ArgInfo opts = {INVALID_CMD, (uint32_t)INVALID_TYPE, 0, 0, -1, 0, false, {0}};
    MOCKER(mmGetOptLong).stubs().will(returnValue(101));
    char *argv2[3] = { "msnpureport", "-e", "hahha" };
    EXPECT_EQ(EN_ERROR, GetOptions(3, argv2, &opts));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, GetOptions4)
{
    EXPECT_EQ(EN_ERROR, GetOptions(0, NULL, NULL));
    GlobalMockObject::reset();
    OptionsUsage();
    MOCKER(OptionsUsage).stubs().will(ignoreReturnValue());

    ArgInfo opts = {INVALID_CMD, (uint32_t)INVALID_TYPE, 0, 0, -1, 0, false, {0}};
    MOCKER(mmGetOptLong).stubs().will(returnValue(101));
    //MOCKER(mmGetOptLong).stubs().will(invoke(getopt_long));
    char *argv2[4] = { "msnpureport", "-r" , "-d", "1111111"};
    EXPECT_EQ(EN_ERROR, GetOptions(4, argv2, &opts));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, GetOptions5)
{
    EXPECT_EQ(EN_ERROR, GetOptions(0, NULL, NULL));
    GlobalMockObject::reset();
    OptionsUsage();
    MOCKER(OptionsUsage).stubs().will(ignoreReturnValue());

    ArgInfo opts = {INVALID_CMD, (uint32_t)INVALID_TYPE, 0, 0, -1, 0, false, {0}};
    MOCKER(mmGetOptLong).stubs().will(returnValue(101));
    MOCKER(InitArgInfoLevelByNoParameterOption).stubs().will(returnValue(EN_OK));
    char *argv2[3] = { "msnpureport", "-f", "-r"};
    EXPECT_EQ(EN_ERROR, GetOptions(2, argv2, &opts));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, GetOptions6)
{
    EXPECT_EQ(EN_ERROR, GetOptions(0, NULL, NULL));
    GlobalMockObject::reset();
    OptionsUsage();
    MOCKER(OptionsUsage).stubs().will(ignoreReturnValue());

    ArgInfo opts = {INVALID_CMD, (uint32_t)INVALID_TYPE, 0, 0, -1, 0, false, {0}};
    MOCKER(mmGetOptLong).stubs().will(returnValue(101));
    MOCKER(InitArgInfoLevelByNoParameterOption).stubs().will(returnValue(EN_ERROR));
    char *argv2[3] = { "msnpureport", "-f", "-r"};
    EXPECT_EQ(EN_ERROR, GetOptions(3, argv2, &opts));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, GetOptions7)
{
    ArgInfo opts = {INVALID_CMD, (uint32_t)INVALID_TYPE, 0, 0, -1, 0, false, {0}};
    optind = 1;
    char *argv2[3] = { "msnpureport", "-t", "1" };
    EXPECT_EQ(EN_ERROR, GetOptions(3, argv2, &opts));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, MsnSetLogLevelOld)
{
    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(false));
    MOCKER(IsHaveExecPermission).stubs().will(returnValue(true));
    ArgInfo opts = {INVALID_CMD, (uint32_t)INVALID_TYPE, MAX_DEV_NUM, 0, -1, 0, false, {0}};
    optind = 1;
    char *argv1[5] = { "msnpureport", "-m", "FMK:debug"};
    EXPECT_EQ(EN_OK, GetOptions(3, argv1, &opts));
    optind = 1;
    opts.cmdType = INVALID_CMD;
    char *argv2[5] = { "msnpureport", "-g", "info"};
    EXPECT_EQ(EN_OK, GetOptions(3, argv2, &opts));
    optind = 1;
    opts.cmdType = INVALID_CMD;
    char *argv3[5] = { "msnpureport", "-e", "enable"};
    EXPECT_EQ(EN_OK, GetOptions(3, argv3, &opts));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, RequestHandle)
{
    ArgInfo opts;
    char a[40] = "FMK:INFO";
    int32_t ret = sprintf_s(opts.value, MAX_VALUE_STR_LEN, "SetLogLevel(%d)[%s]", LOGLEVEL_MODULE, a);
    opts.deviceId = 0;
    MOCKER(MsnOperateDeviceLogLevel)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(-1));
    EXPECT_EQ(EN_OK, RequestHandle(&opts));
    EXPECT_EQ(EN_ERROR, RequestHandle(&opts));
    GlobalMockObject::reset();
}

static int32_t g_mtok = 1048576;

TEST_F(MsnpureportMain, SyncDeviceLogFailedInDocker)
{
    struct BboxDumpOpt bboxDumpOpt;
    bboxDumpOpt.force = false;
    int logType = 0;

    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(true));
    EXPECT_EQ(EN_ERROR, SyncDeviceLog(&bboxDumpOpt, logType));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, SyncDeviceLogFailedNoPermission)
{
    struct BboxDumpOpt bboxDumpOpt;
    bboxDumpOpt.force = false;
    int logType = 0;

    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(false));
    MOCKER(IsHaveExecPermission).stubs().will(returnValue(false));
    EXPECT_EQ(EN_ERROR, SyncDeviceLog(&bboxDumpOpt, logType));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, SetDockerFlagSuccess)
{
    ArgInfo opts;
    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(true)).then(returnValue(false));
    EXPECT_EQ(EN_OK, SetDockerFlag(&opts));
    EXPECT_EQ(EN_ERROR, SetDockerFlag(&opts));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, IsDockerEnvCheck)
{
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK)).then(returnValue(SYS_ERROR));
    EXPECT_EQ(true, MsnIsDockerEnv());
    EXPECT_EQ(false, MsnIsDockerEnv());
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, IsHaveExecPermissionSuccess)
{
    uint32_t id = 0;
    MOCKER(geteuid).stubs().will(returnValue(id));
    EXPECT_EQ(true, IsHaveExecPermission());
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, IsHaveExecPermissionFailed)
{
    uint32_t id = 1000;
    MOCKER(geteuid).stubs().will(returnValue(id));
    EXPECT_EQ(false, IsHaveExecPermission());
    GlobalMockObject::reset();
}

int32_t ToolWriteStub(INT32 fd, const VOID *buf, UINT32 bufLen)
{
    return (int32_t)bufLen;
}

int32_t ToolRealPathStub(const CHAR *path, CHAR *realPath, INT32 realPathLen)
{
    (void)memcpy_s(realPath, 100, path, 100);
    return SYS_OK;
}

#define ROOT_PATH "/home/test/timestamp/slog"
FileAgeingParam g_param = { 0 };
void FileAgeingParamInit()
{
    g_param.sysLogFileNum = 2;
    g_param.sysLogFileSize = 50;
    g_param.eventLogFileNum = 2;
    g_param.eventLogFileSize = 100;
    g_param.securityLogFileNum = 3;
    g_param.securityLogFileSize = 100;
    g_param.firmwareLogFileNum = 4;
    g_param.firmwareLogFileSize = 100;
    g_param.stackcoreFileNum = 10;
    g_param.slogdLogFileNum = 10;
    g_param.deviceAppDirNum = 10;
    g_param.faultEventDirNum = 10;
    g_param.bboxDirNum = 10;
}

TEST_F(MsnpureportMain, MsnFileMgrWriteDeviceLogFirm)
{
    const char *buffer = "test_log_buffer_";
    LogReportMsg *msg = (LogReportMsg *)malloc(sizeof(LogReportMsg) + strlen(buffer) + 1);
    msg->magic = LOG_REPORT_MAGIC;
    msg->logType = 4;
    msg->bufLen = strlen(buffer) + 1;
    msg->devId = 4;
    (void)memcpy_s(msg->buf, msg->bufLen, buffer, msg->bufLen);
    ToolStat dirStat = {0};
    dirStat.st_uid = (uid_t)12345;
    dirStat.st_size = (off_t)(50 * g_mtok);
    FileAgeingParamInit();
    EXPECT_EQ(0, MsnFileMgrInit(&g_param, ROOT_PATH));
    MOCKER(mmMkdir).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolRealPath).stubs().will(invoke(ToolRealPathStub));
    MOCKER(ToolStatGet).stubs().with(any(), outBoundP(&dirStat)).will(returnValue(0));
    MOCKER(ToolOpenWithMode).stubs().will(returnValue(0x12345));
    MOCKER(ToolWrite).stubs().will(invoke(ToolWriteStub));

    EXPECT_EQ(0, MsnFileMgrWriteDeviceSlog((void *)msg, sizeof(LogReportMsg) + strlen(buffer) + 1, 0));
    EXPECT_EQ(0, MsnFileMgrWriteDeviceSlog((void *)msg, sizeof(LogReportMsg) + strlen(buffer) + 1, 0));
    EXPECT_EQ(0, MsnFileMgrWriteDeviceSlog((void *)msg, sizeof(LogReportMsg) + strlen(buffer) + 1, 0));
    EXPECT_EQ(0, MsnFileMgrWriteDeviceSlog((void *)msg, sizeof(LogReportMsg) + strlen(buffer) + 1, 0));
    free(msg);
    MsnFileMgrExit();
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, MsnFileMgrWriteDeviceSlog)
{
    const char *buffer = "test_log_buffer_";
    LogReportMsg *msg = (LogReportMsg *)malloc(sizeof(LogReportMsg) + strlen(buffer) + 1);
    msg->magic = LOG_REPORT_MAGIC;
    msg->logType = 0;
    msg->bufLen = strlen(buffer) + 1;
    msg->devId = 0;
    (void)memcpy_s(msg->buf, msg->bufLen, buffer, msg->bufLen);
    FileAgeingParamInit();
    EXPECT_EQ(0, MsnFileMgrInit(&g_param, ROOT_PATH));
    MOCKER(mmMkdir).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolRealPath).stubs().will(invoke(ToolRealPathStub));
    MOCKER(ToolOpenWithMode).stubs().will(returnValue(0x12345));
    MOCKER(ToolWrite).stubs().will(invoke(ToolWriteStub));

    EXPECT_EQ(0, MsnFileMgrWriteDeviceSlog((void *)msg, sizeof(LogReportMsg) + strlen(buffer) + 1, 0));
    EXPECT_EQ(0, MsnFileMgrWriteDeviceSlog((void *)msg, sizeof(LogReportMsg) + strlen(buffer) + 1, 0));
    EXPECT_EQ(0, MsnFileMgrWriteDeviceSlog((void *)msg, sizeof(LogReportMsg) + strlen(buffer) + 1, 0));
    EXPECT_EQ(0, MsnFileMgrWriteDeviceSlog((void *)msg, sizeof(LogReportMsg) + strlen(buffer) + 1, 0));
    free(msg);
    MsnFileMgrExit();
    GlobalMockObject::reset();
}

int32_t ToolStatGetStub(const char *path,  ToolStat *buffer)
{
    static int32_t time = 0;
    buffer->st_uid = (uid_t)12345;
    buffer->st_size += (off_t)(50 * g_mtok * ++time);
    return 0;
}

TEST_F(MsnpureportMain, MsnFileMgrWriteDeviceLogEvent)
{
    const char *buffer = "test_log_buffer_";
    LogReportMsg *msg = (LogReportMsg *)malloc(sizeof(LogReportMsg) + strlen(buffer) + 1);
    msg->magic = LOG_REPORT_MAGIC;
    msg->logType = 3;
    msg->bufLen = strlen(buffer) + 1;
    msg->devId = 0;
    (void)memcpy_s(msg->buf, msg->bufLen, buffer, msg->bufLen);
    FileAgeingParamInit();
    EXPECT_EQ(0, MsnFileMgrInit(&g_param, ROOT_PATH));
    MOCKER(mmMkdir).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolRealPath).stubs().will(invoke(ToolRealPathStub));
    MOCKER(ToolStatGet).stubs().will(invoke(ToolStatGetStub));
    MOCKER(ToolOpenWithMode).stubs().will(returnValue(0x12345));
    MOCKER(ToolWrite).stubs().will(invoke(ToolWriteStub));

    EXPECT_EQ(0, MsnFileMgrWriteDeviceSlog((void *)msg, sizeof(LogReportMsg) + strlen(buffer) + 1, 0));
    EXPECT_EQ(0, MsnFileMgrWriteDeviceSlog((void *)msg, sizeof(LogReportMsg) + strlen(buffer) + 1, 0));
    EXPECT_EQ(0, MsnFileMgrWriteDeviceSlog((void *)msg, sizeof(LogReportMsg) + strlen(buffer) + 1, 0));
    EXPECT_EQ(0, MsnFileMgrWriteDeviceSlog((void *)msg, sizeof(LogReportMsg) + strlen(buffer) + 1, 0));
    EXPECT_EQ(0, MsnFileMgrWriteDeviceSlog((void *)msg, sizeof(LogReportMsg) + strlen(buffer) + 1, 0));
    free(msg);
    MsnFileMgrExit();
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, MsnFileMgrWriteDeviceMallocFailed)
{
    const char *buffer = "test_log_buffer_";
    LogReportMsg *msg = (LogReportMsg *)malloc(sizeof(LogReportMsg) + strlen(buffer) + 1);
    msg->magic = LOG_REPORT_MAGIC;
    msg->logType = 3;
    msg->bufLen = strlen(buffer) + 1;
    msg->devId = 0;
    (void)memcpy_s(msg->buf, msg->bufLen, buffer, msg->bufLen);
    FileAgeingParamInit();
    EXPECT_EQ(0, MsnFileMgrInit(&g_param, ROOT_PATH));
    MOCKER(mmMkdir).stubs().will(returnValue(SYS_OK));
    MOCKER(memset_s).stubs().will(returnValue((errno_t)6));

    EXPECT_EQ(-1, MsnFileMgrWriteDeviceSlog((void *)msg, sizeof(LogReportMsg) + strlen(buffer) + 1, 0));
    free(msg);
    MsnFileMgrExit();
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, MsnMkdirMulti)
{
    const char *path = "/tmp/msnpureport_test/time/slog/device-os/";
    EXPECT_EQ(EN_OK, MsnMkdirMulti(path));
    MOCKER(mmAccess).stubs().will(returnValue(EN_ERROR));
    EXPECT_EQ(EN_OK, MsnMkdirMulti(path));
    MOCKER(MsnMkdir).stubs().will(returnValue(EN_ERROR));
    EXPECT_EQ(EN_ERROR, MsnMkdirMulti("/tmp"));
    system("rm -r /tmp/msnpureport_test");
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, MsnFileMgrFileAgeing)
{
    const char *buffer = "test_log_buffer_";
    LogReportMsg *msg = (LogReportMsg *)malloc(sizeof(LogReportMsg) + strlen(buffer) + 1);
    msg->magic = LOG_REPORT_MAGIC;
    msg->logType = 0;
    msg->bufLen = strlen(buffer) + 1;
    msg->devId = 0;
    (void)memcpy_s(msg->buf, msg->bufLen, buffer, msg->bufLen);
    FileAgeingParamInit();
    g_param.sysLogFileSize = 5;
    EXPECT_EQ(0, MsnFileMgrInit(&g_param, ROOT_PATH));
    MOCKER(mmMkdir).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolRealPath).stubs().will(invoke(ToolRealPathStub));
    MOCKER(ToolOpenWithMode).stubs().will(returnValue(0x12345));
    MOCKER(ToolWrite).stubs().will(invoke(ToolWriteStub));
    EXPECT_EQ(0, MsnFileMgrWriteDeviceSlog((void *)msg, sizeof(LogReportMsg) + strlen(buffer) + 1, 0));
    free(msg);
    MsnFileMgrExit();
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, MsnFileMgrDataWriteFail)
{
    const char *buffer = "test_log_buffer_";
    LogReportMsg *msg = (LogReportMsg *)malloc(sizeof(LogReportMsg) + strlen(buffer) + 1);
    msg->magic = LOG_REPORT_MAGIC;
    msg->logType = 0;
    msg->bufLen = strlen(buffer) + 1;
    msg->devId = 0;
    (void)memcpy_s(msg->buf, msg->bufLen, buffer, msg->bufLen);
    FileAgeingParamInit();
    EXPECT_EQ(0, MsnFileMgrInit(&g_param, ROOT_PATH));
    MOCKER(mmMkdir).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolRealPath).stubs().will(invoke(ToolRealPathStub));
    MOCKER(ToolOpenWithMode).stubs().will(returnValue(0x12345));
    MOCKER(ToolWrite).stubs().will(returnValue(-1));

    EXPECT_EQ(-1, MsnFileMgrWriteDeviceSlog((void *)msg, sizeof(LogReportMsg) + strlen(buffer) + 1, 0));
    free(msg);
    MsnFileMgrExit();
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, MsnFileMgrInitInputFail)
{
    EXPECT_EQ(-1, MsnFileMgrInit(NULL, NULL));
    MOCKER(strcpy_s).stubs().will(returnValue(-1));
    FileAgeingParamInit();
    EXPECT_EQ(-1, MsnFileMgrInit(&g_param, ROOT_PATH));
    GlobalMockObject::reset();
}

int32_t g_memsetFlag = 0;
errno_t MemsetStub(void *dest, size_t destMax, int c, size_t count)
{
    g_memsetFlag++;
    if (g_memsetFlag % 2 == 1) {
        return (errno_t)(6);
    }
    return EOK;
}

TEST_F(MsnpureportMain, MsnFileMgrInitMallocFail)
{
    MOCKER(memset_s).stubs().will(invoke(MemsetStub));
    g_memsetFlag = 0;
    EXPECT_EQ(-1, MsnFileMgrDeviceInit(4));
    EXPECT_EQ(-1, MsnFileMgrDeviceInit(4));
    g_memsetFlag = 0;
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, MsnFileMgrGetTimeStrFail)
{
    const int32_t timeSize = 32;
    EXPECT_EQ(-1, MsnFileMgrGetTimeStr(NULL, timeSize));
    char time[timeSize + 1] = { 0 };
    MOCKER(gettimeofday).stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    EXPECT_EQ(-1, MsnFileMgrGetTimeStr(time, timeSize));
    struct tm tmp = { 0 };
    MOCKER(localtime_r).stubs()
        .will(returnValue((struct tm*)NULL))
        .then(returnValue(&tmp));
    EXPECT_EQ(-1, MsnFileMgrGetTimeStr(time, timeSize));
    MOCKER(vsnprintf_s).stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    EXPECT_EQ(-1, MsnFileMgrGetTimeStr(time, timeSize));
    EXPECT_EQ(0, MsnFileMgrGetTimeStr(time, timeSize));
    GlobalMockObject::reset();
}

TEST_F(MsnpureportMain, MsnFileMgrRemoveFile)
{
    EXPECT_EQ(-1, MsnFileMgrRemoveFile(NULL));
    const char *path = "/home/test/timestamp/slog/";
    MOCKER(chmod).stubs().will(returnValue(-1)).then(returnValue(0));
    EXPECT_EQ(-1, MsnFileMgrRemoveFile(path));
    MOCKER(unlink).stubs().will(returnValue(0)).then(returnValue(1));
    EXPECT_EQ(-0, MsnFileMgrRemoveFile(path));
    MOCKER(ToolGetErrorCode).stubs().will(returnValue(0)).then(returnValue(1)).then(returnValue(ENOENT));
    EXPECT_EQ(-1, MsnFileMgrRemoveFile(path));
}
