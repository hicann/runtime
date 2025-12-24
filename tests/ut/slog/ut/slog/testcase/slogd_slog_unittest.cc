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
#include <stdint.h>
#include <errno.h>
#include <sys/stat.h>
#include <dlfcn.h>
#include "securec.h"
#include "slogd_applog_flush.h"
#include "slogd_config_mgr.h"
#include "slogd_buffer.h"
#include "slogd_applog_report.h"
#include "log_pm_sig.h"
#include "log_file_util.h"

extern "C" {
    #include "plog.h"
    #include "slog.h"
    #include "operate_loglevel.h"
    #include "share_mem.h"
    #include "log_config_api.h"
    #include "log_common.h"
    #include "dlog_message.h"
    #include "dlog_console.h"
    #include "dlog_socket.h"
    #include "operate_loglevel.h"
    #include "dlog_level_mgr.h"
    #include "dlog_attr.h"
    #include "log_path_mgr.h"
    #include "slogd_utest_stub.h"

    int CheckLogLevel(int moduleId, int logLevel);
    int FullWrites(int fd, const void *buf, size_t len, int moduleID, int level);
    long DlogTimeDiff(const struct timespec *lastTv);
    void DlogGetTime(char* timeStr, uint32_t size);
    void LogCtrlIncLogic();
    void LogCtrlDecLogic();
    int32_t GetSocketPathByVfid(const uint32_t vfid, char *socketPath, const uint32_t pathLen);
    int32_t GetSocketPathByPfid(char *socketPath, const uint32_t pathLen);
    int32_t GetSlogSocketPath(const uint32_t devId, char *socketPath, const uint32_t pathLen);
    int dlog_setlevel(int moduleId, int level, int enableEvent);
    void *LevelNotifyWatcher();
    LogRt AddNewWatch(int *pNotifyFd, int *pWatchFd, const char *notifyFile);
    LogRt ParseLogLevel(const char *levelStr, const char *moduleStr);
    void StartThreadForLevelChangeWatcher();
    int UpdateLogLevel();
    int32_t DlogWriteToPlog(LogMsg *logMsg);
    void DlogWriteToConsole(LogMsg *logMsg);
    void DlogWriteToSocket(LogMsg *logMsg, const LogMsgArg *msgArg);
    void DlogInitServerType(void);
    int32_t ConstructBaseLogMsg(char *msg, uint32_t msgLen, const LogMsgArg *msgArg);
    int SafeWrites(int fd, const void *buf, size_t count, int moduleId, int level);
    int IsThreadExit();
    int32_t CheckShMemAvailable(void);
    int32_t ObtainNotifyFile(char *notifyFile);
    bool DlogCheckAttrSystem(void);
    bool IsWatcherThreadExit(void);
    // applog
    AppLogList *InnerInsertAppNode(const LogInfo *info);
}

static bool g_shmAvail = false;

int CallBack(const char * data, unsigned int len)
{
    std::cout << data;
    return 0;
}

class SlogdSlog : public testing::Test
{
protected:
    virtual void SetUp()
    {
        // a test SetUP
    }
    virtual void TearDown()
    {
        // a test TearDown
        EXPECT_EQ(0, CheckMutex());
        GlobalMockObject::reset();
    }
};

TEST_F(SlogdSlog, TestConstructBaseLogMsg)
{
    char msg[100];
    LogAttr attr;
    attr.type = APPLICATION;
    attr.pid = 1;
    attr.deviceId = 0;
    // moduleId: valid; level: valid
    LogMsgArg msgArg = { 0, 0, 3, 1, attr, "12345", nullptr };
    ConstructBaseLogMsg(msg, 100, &msgArg);
    EXPECT_STREQ("[ERROR] SLOG(1,toolchain_log_slogd_ut):12345 ", msg);
    // moduleId: valid; level: invalid
    msgArg.level = -1;
    ConstructBaseLogMsg(msg, 100, &msgArg);
    EXPECT_STREQ("[-1] SLOG(1,toolchain_log_slogd_ut):12345 ", msg);
    // moduleId: invalid; level: valid
    msgArg.moduleId = 100;
    ConstructBaseLogMsg(msg, 100, &msgArg);
    EXPECT_STREQ("[-1] 100(1,toolchain_log_slogd_ut):12345 ", msg);
    // moduleId: invalid; level: invalid
    msgArg.level = 3;
    ConstructBaseLogMsg(msg, 100, &msgArg);
    EXPECT_STREQ("[ERROR] 100(1,toolchain_log_slogd_ut):12345 ", msg);
}

TEST_F(SlogdSlog, TimeDiff00)
{
    EXPECT_EQ(0, DlogTimeDiff(NULL));
}

TEST_F(SlogdSlog, GetSlogSocketPath)
{
    char path[WORKSPACE_PATH_MAX_LENGTH + 1] = { 0 };
    EXPECT_EQ(0, GetSlogSocketPath(0, path, WORKSPACE_PATH_MAX_LENGTH));
    EXPECT_STREQ("/usr/slog/slog", path);

    memset_s(path, WORKSPACE_PATH_MAX_LENGTH, 0, WORKSPACE_PATH_MAX_LENGTH);
    EXPECT_EQ(0, GetSlogSocketPath(32, path, WORKSPACE_PATH_MAX_LENGTH));
    EXPECT_STREQ("/usr/slog/slog_32", path);
    GlobalMockObject::reset();
}

TEST_F(SlogdSlog, CreatSocket00)
{
    int g_pid = 22222;
    MOCKER(ToolSocket).stubs().will(returnValue(SYS_ERROR));
    MOCKER(ToolClose).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_ERROR, CreatSocket(0));
    GlobalMockObject::reset();
}

TEST_F(SlogdSlog, CreatSocket01)
{
    int g_pid = 22222;
    MOCKER(ToolSocket).stubs().will(returnValue(0));
    MOCKER(setsockopt).stubs().will(returnValue(-1));
    MOCKER(ToolClose).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_ERROR, CreatSocket(0));
    GlobalMockObject::reset();
}

TEST_F(SlogdSlog, CreatSocket02)
{
    int g_pid = 22222;
    MOCKER(ToolSocket).stubs().will(returnValue(0));
    MOCKER(setsockopt).stubs().will(returnValue(0));
    MOCKER(memset_s).stubs().will(returnValue(-1));
    MOCKER(ToolClose).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_ERROR, CreatSocket(0));
    GlobalMockObject::reset();
}

TEST_F(SlogdSlog, CreatSocket03)
{
    int g_pid = 22222;
    MOCKER(ToolSocket).stubs().will(returnValue(0));
    MOCKER(setsockopt).stubs().will(returnValue(0));
    MOCKER(memset_s).stubs().will(returnValue(0));
    MOCKER(GetSlogSocketPath).stubs().will(returnValue(0));
    MOCKER(strcpy_s).stubs().will(returnValue(-1));
    MOCKER(ToolClose).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_ERROR, CreatSocket(0));
    GlobalMockObject::reset();
}

TEST_F(SlogdSlog, CreatSocket04)
{
    int g_pid = 22222;
    MOCKER(ToolSocket).stubs().will(returnValue(0));
    MOCKER(setsockopt).stubs().will(returnValue(0));
    MOCKER(memset_s).stubs().will(returnValue(0));
    MOCKER(GetSlogSocketPath).stubs().will(returnValue(0));
    MOCKER(strcpy_s).stubs().will(returnValue(0));
    MOCKER(ToolConnect).stubs().will(returnValue(SYS_ERROR));
    MOCKER(ToolClose).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(SYS_ERROR, CreatSocket(0));
    GlobalMockObject::reset();
}

TEST_F(SlogdSlog, CreatSocket05)
{
    int g_pid = 22222;
    MOCKER(ToolSocket).stubs().will(returnValue(0));
    MOCKER(setsockopt).stubs().will(returnValue(0));
    MOCKER(memset_s).stubs().will(returnValue(0));
    MOCKER(GetSlogSocketPath).stubs().will(returnValue(0));
    MOCKER(strcpy_s).stubs().will(returnValue(0));
    MOCKER(ToolConnect).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(0, CreatSocket(0));
    GlobalMockObject::reset();
}

TEST_F(SlogdSlog, DlogSetlevel00) {
    EXPECT_EQ(SYS_OK, dlog_setlevel(0, 1, 1));
    EXPECT_EQ(SYS_ERROR, dlog_setlevel(0, 1, -1));
    EXPECT_EQ(SYS_ERROR, dlog_setlevel(0, 5, 1));
    EXPECT_EQ(SYS_OK, dlog_setlevel(-1, 1, 1));
}

TEST_F(SlogdSlog, UpdateLogLevel)
{
    MOCKER(ShMemOpen).stubs().will(returnValue(SHM_ERROR));
    EXPECT_EQ(SYS_ERROR, UpdateLogLevel());
    GlobalMockObject::reset();

    int shmId = 1;
    MOCKER(ShMemOpen).stubs().with(outBoundP(&shmId)).will(returnValue(SHM_SUCCEED));
    MOCKER(malloc).stubs().will(returnValue((void*)NULL));
    EXPECT_EQ(SYS_ERROR, UpdateLogLevel());
    GlobalMockObject::reset();

    MOCKER(ShMemOpen).stubs().with(outBoundP(&shmId)).will(returnValue(SHM_SUCCEED));
    MOCKER(ShMemRead).stubs().will(returnValue(SHM_ERROR));
    EXPECT_EQ(SYS_ERROR, UpdateLogLevel());
    GlobalMockObject::reset();

    MOCKER(ShMemOpen).stubs().with(outBoundP(&shmId)).will(returnValue(SHM_SUCCEED));
    MOCKER(ShMemRead).stubs().will(returnValue(SHM_SUCCEED)).then(returnValue(SHM_ERROR));
    EXPECT_EQ(SYS_ERROR, UpdateLogLevel());
    GlobalMockObject::reset();

    MOCKER(ShMemOpen).stubs().with(outBoundP(&shmId)).will(returnValue(SHM_SUCCEED));
    MOCKER(ShMemRead).stubs().will(returnValue(SHM_SUCCEED));
    MOCKER(ParseLogLevel).stubs().will(returnValue(SUCCESS + 1));
    EXPECT_EQ(SYS_ERROR, UpdateLogLevel());
    GlobalMockObject::reset();

    MOCKER(ShMemOpen).stubs().with(outBoundP(&shmId)).will(returnValue(SHM_SUCCEED));
    MOCKER(ShMemRead).stubs().will(returnValue(SHM_SUCCEED));
    MOCKER(ParseLogLevel).stubs().will(returnValue(SUCCESS));
    EXPECT_EQ(SYS_OK, UpdateLogLevel());
    GlobalMockObject::reset();
}

TEST_F(SlogdSlog, ParseLogLevel)
{
    int i = 0;
    char moduleLevel = 0x5 | (0x5 << 4);
    char globalLevel = (0x5 << 4) | (0x3 << 2);
    char *levelStr = (char *)malloc(LEVEL_ARR_LEN);
    if (levelStr == NULL) {
        printf("malloc failed\n");
        return;
    }
    (void)memset(levelStr, moduleLevel, LEVEL_ARR_LEN);
    levelStr[0] = globalLevel;
    levelStr[LEVEL_ARR_LEN - 1] = '\0';
    char *moduleStr = (char *)malloc(MODULE_ARR_LEN);
    if (moduleStr == NULL) {
        printf("malloc failed.\n");
        free(levelStr);
        return;
    }
    (void)memset(moduleStr, 0, MODULE_ARR_LEN);

    const char *moduleStrTmp = "SLOG;IDEDD;HCCL;FMK;DVPP;RUNTIME;CCE;HDC;DRV;MLL;DEVMM;KERNEL;LIBMEDIA;CCECPU;ASCENDDK;ROS;HCCP;ROCE;TEFUSION;PROFILING;DP;APP;TS;TSDUMP;AICPU;LP;TDT;FE;MD;MB;ME;IMU;IMP;GE;CAMERA;ASCENDCL;TEEOS;ISP;SIS;HSM;DSS;PROCMGR;BBOX;AIVECTOR;TBE;FV";

    (void)strcpy(moduleStr, moduleStrTmp);

    EXPECT_EQ(ARGV_NULL, ParseLogLevel(NULL, NULL));

    EXPECT_EQ(ARGV_NULL, ParseLogLevel((const char *)levelStr, NULL));

    EXPECT_EQ(SUCCESS, ParseLogLevel((const char *)levelStr, (const char *)moduleStr));

    free(moduleStr);
    free(levelStr);
}

TEST_F(SlogdSlog, CheckShMemAvailSuccess)
{
    MOCKER(ShMemOpen).stubs().will(returnValue(SHM_SUCCEED));
    EXPECT_EQ(SYS_OK, CheckShMemAvailable());
}

TEST_F(SlogdSlog, LevelNotifyWatcher)
{
    const char *tmp = "/usr/slog";
    char workpath[256] = { 0 };
    strcpy(workpath, tmp);
    MOCKER(LogGetWorkspacePath).stubs().will(returnValue((char *)workpath));
    MOCKER(AddNewWatch).stubs().will(returnValue(SUCCESS + 1));
    EXPECT_EQ((void *)NULL, LevelNotifyWatcher());
    GlobalMockObject::reset();
}

TEST_F(SlogdSlog, LevelNotifyWatchershmNotAvailable)
{
    g_shmAvail = false;
    MOCKER(CheckShMemAvailable).stubs().will(returnValue(SYS_ERROR)).then(returnValue(SYS_OK));
    MOCKER(ToolSleep).stubs();
    MOCKER(UpdateLogLevel).stubs();
    EXPECT_EQ((void *)NULL, LevelNotifyWatcher());
    GlobalMockObject::reset();
}

TEST_F(SlogdSlog, LevelNotifyWatcherReadInDeleteSelfEvent)
{
    g_shmAvail = true;
    char notifyFile[CFG_WORKSPACE_PATH_MAX_LENGTH] = "/usr/slog";
    int32_t notifyFd = 0;
    int32_t watchFd = 0;
    MOCKER(ObtainNotifyFile).stubs().with(outBoundP(notifyFile)).will(returnValue(SYS_OK));
    MOCKER(AddNewWatch).stubs()
                       .with(outBoundP(&notifyFd), outBoundP(&watchFd), any())
                       .will(returnValue(SUCCESS))
                       .then(returnValue(NOTIFY_INIT_FAILED));
    MOCKER(IsWatcherThreadExit).stubs().will(returnValue(false)).then(returnValue(true));
    MOCKER(DlogCheckAttrSystem).stubs().will(returnValue(true));
    MOCKER(UpdateLogLevel).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ((void *)NULL, LevelNotifyWatcher());
    GlobalMockObject::reset();
}

TEST_F(SlogdSlog, AddNewWatch)
{
    int notifyFd = 0;
    int watchFd = 0;
    const char *file = "/usr/slog/level_notify";

    EXPECT_EQ(ARGV_NULL, AddNewWatch(NULL, NULL, NULL));
    EXPECT_EQ(ARGV_NULL, AddNewWatch(&notifyFd, NULL, NULL));
    EXPECT_EQ(ARGV_NULL, AddNewWatch(&notifyFd, &watchFd, NULL));

    MOCKER(ToolAccess).stubs().will(returnValue(SYS_ERROR)).then(returnValue(SYS_OK));
    MOCKER(inotify_rm_watch).stubs().will(returnValue(0));
    MOCKER(inotify_init).stubs().will(returnValue(-1));
    EXPECT_EQ(NOTIFY_INIT_FAILED, AddNewWatch(&notifyFd, &watchFd, file));
    GlobalMockObject::reset();

    MOCKER(ToolAccess).stubs().will(returnValue(SYS_ERROR)).then(returnValue(SYS_OK));
    MOCKER(inotify_rm_watch).stubs().will(returnValue(0));
    MOCKER(inotify_init).stubs().will(returnValue(0));
    MOCKER(inotify_add_watch).stubs().will(returnValue(-1));
    EXPECT_EQ(NOTIFY_WATCH_FAILED, AddNewWatch(&notifyFd, &watchFd, file));
    GlobalMockObject::reset();

    MOCKER(ToolAccess).stubs().will(returnValue(SYS_ERROR)).then(returnValue(SYS_OK));
    MOCKER(inotify_rm_watch).stubs().will(returnValue(0));
    MOCKER(inotify_init).stubs().will(returnValue(0));
    MOCKER(inotify_add_watch).stubs().will(returnValue(0));
    EXPECT_EQ(SUCCESS, AddNewWatch(&notifyFd, &watchFd, file));
    GlobalMockObject::reset();
}

TEST_F(SlogdSlog, DlogSetAttr_HostPid_env)
{
    LogAttr logAttr;
    logAttr.type = APPLICATION;
    logAttr.deviceId = 0;
    logAttr.pid = 0;
    logAttr.mode = LOG_SAVE_MODE_UNI;
    char *env = "123";
    MOCKER(getenv).stubs().will(returnValue(env));
    EXPECT_EQ(LOG_SUCCESS, DlogSetAttr(logAttr));

    LogAttr curAttr;
    DlogGetUserAttr(&curAttr);
    EXPECT_EQ(logAttr.type, curAttr.type);
    EXPECT_EQ(logAttr.deviceId, curAttr.deviceId);
    EXPECT_EQ(123, curAttr.pid);
    EXPECT_EQ(logAttr.mode, curAttr.mode);
    GlobalMockObject::reset();
}

TEST_F(SlogdSlog, DlogSetAttr_HostPid_original)
{
    LogAttr oriAttr;
    DlogGetUserAttr(&oriAttr);
    LogAttr logAttr;
    logAttr.type = APPLICATION;
    logAttr.deviceId = 0;
    logAttr.pid = 0;
    logAttr.mode = LOG_SAVE_MODE_UNI;
    char *env = "-1";
    MOCKER(getenv).stubs().will(returnValue(env));
    EXPECT_EQ(LOG_SUCCESS, DlogSetAttr(logAttr));

    LogAttr curAttr;
    DlogGetUserAttr(&curAttr);
    EXPECT_EQ(logAttr.type, curAttr.type);
    EXPECT_EQ(logAttr.deviceId, curAttr.deviceId);
    EXPECT_EQ(oriAttr.pid, curAttr.pid);
    EXPECT_EQ(logAttr.mode, curAttr.mode);
    GlobalMockObject::reset();
}

TEST_F(SlogdSlog, DlogSetAttr_SaveMode_EnvUni)
{
    LogAttr logAttr;
    logAttr.type = APPLICATION;
    logAttr.deviceId = 0;
    logAttr.pid = 123;
    logAttr.mode = LOG_SAVE_MODE_DEF;
    char *env = "1";
    MOCKER(getenv).stubs().will(returnValue(env));
    EXPECT_EQ(LOG_SUCCESS, DlogSetAttr(logAttr));

    LogAttr curAttr;
    DlogGetUserAttr(&curAttr);
    EXPECT_EQ(logAttr.type, curAttr.type);
    EXPECT_EQ(logAttr.deviceId, curAttr.deviceId);
    EXPECT_EQ(logAttr.pid, curAttr.pid);
    EXPECT_EQ(LOG_SAVE_MODE_UNI, curAttr.mode);
    GlobalMockObject::reset();
}

TEST_F(SlogdSlog, DlogSetAttr_SaveMode_EnvSep)
{
    LogAttr logAttr;
    logAttr.type = APPLICATION;
    logAttr.deviceId = 0;
    logAttr.pid = 123;
    logAttr.mode = LOG_SAVE_MODE_DEF;
    char *env = "2";
    MOCKER(getenv).stubs().will(returnValue(env));
    EXPECT_EQ(LOG_SUCCESS, DlogSetAttr(logAttr));

    LogAttr curAttr;
    DlogGetUserAttr(&curAttr);
    EXPECT_EQ(logAttr.type, curAttr.type);
    EXPECT_EQ(logAttr.deviceId, curAttr.deviceId);
    EXPECT_EQ(logAttr.pid, curAttr.pid);
    EXPECT_EQ(LOG_SAVE_MODE_SEP, curAttr.mode);
    GlobalMockObject::reset();
}

TEST_F(SlogdSlog, DlogSetAttr_SaveMode_original)
{
    LogAttr oriAttr;
    DlogGetUserAttr(&oriAttr);
    LogAttr logAttr;
    logAttr.type = APPLICATION;
    logAttr.deviceId = 0;
    logAttr.pid = 123;
    logAttr.mode = LOG_SAVE_MODE_DEF;
    char *env = "789";
    MOCKER(getenv).stubs().will(returnValue(env));
    EXPECT_EQ(LOG_SUCCESS, DlogSetAttr(logAttr));

    LogAttr curAttr;
    DlogGetUserAttr(&curAttr);
    EXPECT_EQ(logAttr.type, curAttr.type);
    EXPECT_EQ(logAttr.deviceId, curAttr.deviceId);
    EXPECT_EQ(logAttr.pid, curAttr.pid);
    EXPECT_EQ(oriAttr.mode, curAttr.mode);
    GlobalMockObject::reset();
}

TEST_F(SlogdSlog, DlogGetServerType)
{
    MOCKER(dlsym).stubs().will(returnValue(nullptr));
    DlogInitServerType();
    EXPECT_EQ(false, DlogIsPoolingDevice());

    GlobalMockObject::verify();
}

TEST_F(SlogdSlog, RsyslogSocketTest)
{
    MOCKER(DlogIsPoolingDevice).stubs().will(returnValue(true));
    EXPECT_EQ(0, IsSocketConnected());
    EXPECT_EQ(true, IsSocketFdValid());
    GlobalMockObject::verify();

    EXPECT_EQ(-1, GetRsyslogSocketFd(STDOUT_LOG_MASK));

    MOCKER(ToolSocket).stubs().will(returnValue(0));
    MOCKER(setsockopt).stubs().will(returnValue(0));
    MOCKER(memset_s).stubs().will(returnValue(0));
    MOCKER(strcpy_s).stubs().will(returnValue(0));
    MOCKER(ToolConnect).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(0, GetRsyslogSocketFd(RUN_LOG_MASK));

    GlobalMockObject::verify();
}

TEST_F(SlogdSlog, RsyslogSocketTest_Failed)
{
    MOCKER(ToolSocket).stubs().will(returnValue(0));
    MOCKER(setsockopt).stubs().will(returnValue(0));
    MOCKER(memset_s).stubs().will(returnValue(0));
    MOCKER(strcpy_s).stubs().will(returnValue(0));
    MOCKER(ToolConnect).stubs().will(returnValue(SYS_ERROR));
    MOCKER(ToolClose).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(SYS_ERROR, GetRsyslogSocketFd(DEBUG_LOG_MASK));
    GlobalMockObject::verify();
}
static int32_t ToolWrite_stub(int32_t fd,const void *buf, uint32_t len)
{
    return write(fd, buf, (size_t)len);
}

TEST_F(SlogdSlog, WriteToRsyslogSocket)
{
    LogMsg logMsg;
    (void)memset_s(&logMsg, sizeof(LogMsg), 0, sizeof(LogMsg));
    logMsg.type = DEBUG_LOG;
    char msg[MSG_LENGTH + 1] = "[0,1,0,0][INFO] SLOG(1,toolchain_log_st):test for 1024.\n";
    memcpy_s(logMsg.msg, MSG_LENGTH, msg, strlen(msg));
    char *pos = strchr(logMsg.msg, ']');
    logMsg.logContent = pos + 1;
    logMsg.msgLength = MSG_LENGTH - 1;
    DlogSetMessageNl(&logMsg);

    LogAttr attr;
    attr.type = APPLICATION;
    attr.pid = 1;
    attr.deviceId = 0;
    LogMsgArg msgArg = { 0, 0, 3, 1, attr, "12345", nullptr };

    int32_t fd = open("/tmp/WriteToRsyslogSocket.txt", O_CREAT | O_RDWR, 0777);
    EXPECT_LT(-1, fd);
    MOCKER(DlogIsPoolingDevice).stubs().will(returnValue(true));
    MOCKER(GetRsyslogSocketFd).stubs().will(returnValue(fd));
    MOCKER(ToolWrite).stubs().will(invoke(ToolWrite_stub));
    DlogWriteToSocket(&logMsg, &msgArg);
    char result[1024] = {0};
    int32_t ret = read(fd, result, sizeof(result) - 1);
    EXPECT_LT(-1, ret);
    close(fd);
    system("rm -f /tmp/WriteToRsyslogSocket.txt");
    GlobalMockObject::verify();
}

TEST_F(SlogdSlog, RegisterCallback)
{
    EXPECT_EQ(SUCCESS, RegisterCallback(NULL, LOG_WRITE));
}

TEST_F(SlogdSlog, DlogReportInitialize)
{
    EXPECT_EQ(0, DlogReportInitialize());
}

TEST_F(SlogdSlog, DlogReportFinalize)
{
    EXPECT_EQ(0, DlogReportFinalize());
}

TEST_F(SlogdSlog, DlogReportStart) {
    EXPECT_EQ(SYS_OK, DlogReportStart(0, 0));
    DlogReportStop(0);
}

TEST_F(SlogdSlog, DlogSetMessageNl)
{
    LogMsg logMsg;
    (void)memset_s(&logMsg, sizeof(LogMsg), 0, sizeof(LogMsg));
    logMsg.type = DEBUG_LOG;
    char msg[MSG_LENGTH + 1] = "[0,1,0,0][INFO] SLOG(1,toolchain_log_st):test for 1024.";
    memcpy_s(logMsg.msg, MSG_LENGTH, msg, strlen(msg));
    char *pos = strchr(logMsg.msg, ']');
    logMsg.logContent = pos + 1;

    logMsg.msgLength = MSG_LENGTH - 1;
    DlogSetMessageNl(&logMsg);
    EXPECT_EQ('\n', logMsg.msg[MSG_LENGTH - 2]);
}

TEST_F(SlogdSlog, InnerDeleteAppNode)
{
    SlogdApplogFlushExit();
    MOCKER(SlogdConfigMgrGetBufSize).stubs().will(returnValue(1024));
    LogInfo node1 = { DEBUG_LOG, APPLICATION, 100, 0, 0, 0 };
    LogInfo node2 = { DEBUG_LOG, APPLICATION, 200, 0, 0, 0 };
    (void)InnerInsertAppNode(&node1);
    (void)InnerInsertAppNode(&node2);
    EXPECT_EQ(2, SlogdGetAppNodeNum());
    // can't find input node in list
    AppLogList input0;
    input0.type = DEBUG_LOG;
    input0.pid = 0;
    input0.deviceId = 0;
    InnerDeleteAppNode(&input0);
    EXPECT_EQ(2, SlogdGetAppNodeNum());
    // find input node in list after traverse
    AppLogList input1;
    input1.type = DEBUG_LOG;
    input1.pid = 100;
    input1.deviceId = 0;
    InnerDeleteAppNode(&input1);
    EXPECT_EQ(1, SlogdGetAppNodeNum());

    // find input node in list, it's first node
    AppLogList input2;
    input2.type = DEBUG_LOG;
    input2.pid = 200;
    input2.deviceId = 0;
    InnerDeleteAppNode(&input2);
    EXPECT_EQ(0, SlogdGetAppNodeNum());

    SlogdApplogFlushExit();
    GlobalMockObject::verify();
}

TEST_F(SlogdSlog, SlogdAppLogFlushToBufByReport)
{
    int applogBufSize = 1024;
    MOCKER(SlogdConfigMgrGetBufSize).stubs().will(returnValue(applogBufSize));

    LogInfo info = { DEBUG_LOG, APPLICATION, 100, 0, 0, 0 };
    char msg[1024] = "test for applog, buffer is not full and save log to buffer.";
    EXPECT_EQ(LOG_SUCCESS, SlogdAppLogFlushToBufByReport(msg, strlen((const char*)&msg), &info));

    MOCKER(SlogdBufferCheckFull).stubs().will(returnValue(true));
    char msg1[1024] = "test for applog, buffer is full and send log to host.";
    EXPECT_EQ(LOG_SUCCESS, SlogdAppLogFlushToBufByReport(msg1, strlen((const char*)&msg1), &info));

    SlogdApplogFlushExit();
    GlobalMockObject::verify();
}

TEST_F(SlogdSlog, SlogdAppLogReport)
{
    int applogBufSize = 1024;
    MOCKER(SlogdConfigMgrGetBufSize).stubs().will(returnValue(applogBufSize));

    LogInfo info = { DEBUG_LOG, APPLICATION, 100, 0, 0, 0 };
    char msg[1024] = "test for applog report, send buffer log to host.";
    EXPECT_EQ(LOG_SUCCESS, SlogdAppLogFlushToBufByReport(msg, strlen((const char*)&msg), &info));
    // for MAX_WRITE_WAIT_TIME
    for (int i = 0; i <= MAX_WRITE_WAIT_TIME; i++) {
        EXPECT_EQ(LOG_SUCCESS, SlogdAppLogReport());
    }

    SlogdApplogFlushExit();
    GlobalMockObject::verify();
}