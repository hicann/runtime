/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_print.h"
#include "log_file_util.h"
#include "slogd_recv_msg.h"
#include "slogd_flush.h"
#include "slogd_recv_core.h"

extern "C"
{
    #include "log_queue.h"
    #include "log_ring_buffer.h"
    #include "log_common.h"
    #include "string.h"
    #include "log_daemon_ut_stub.h"
    #include "log_common.h"
    #include "log_config_api.h"
    #include "dlog_level_mgr.h"
    #include "log_level_parse.h"
    #include "log_pm.h"
    #include "log_monitor.h"
    #include "slogd_buffer.h"
    #include "log_compress/log_hardware_zip.h"
    #include "slogd_collect_log.h"
    #include "slogd_firmware_log.h"
    #include "log_recv.h"
    #include <signal.h>
    #include <execinfo.h>
    #include <sys/ioctl.h>
    #define MSG_LENGTH 1024

    typedef struct BufList {
    char buf[MSG_LENGTH];
    int type;
    unsigned int len;
    struct BufList *next;
    } BufList;
typedef struct {
    ToolMutex mutex;
    ToolCond cond;
    ToolThread  tid;
} ThreadCondInfo;

typedef struct {
    uint32_t current;
    uint32_t last;
    char collectLogPath[10][PATH_MAX];
} CollectLogPath;

typedef struct {
    ThreadCondInfo thread;
    bool collectWait;
    uint32_t collectStatus;
    CollectLogPath path;
} CollectInfo;

    int IamReady(void);
    LogStatus SlogdCommunicationInit(void);
    ssize_t LogIamOpsRead(struct IAMMgrFile *file, char *buf, size_t len, loff_t *pos);
    int RegisterIamTotalService(void);
    int RegisterIamService(const char *serviceName, const int serviceNameLen, const struct IAMFileOps *ops);
    ssize_t LogIamOpsWrite(struct IAMMgrFile *file, const char *buf, size_t len, loff_t *pos);
    int IamRead(char *recvBuf, unsigned int recvBufLen, int *logType);
    int LogIamOpsIoctl(struct IAMMgrFile *file, unsigned cmd, struct IAMIoctlArg* arg);
    int LogIamOpsIoctlGetLevel(LogLevelConfInfo *levelConfInfo);
    int LogIamOpsOpen(struct IAMMgrFile *file);
    int LogIamOpsClose(struct IAMMgrFile *file);
    extern unsigned int g_bufListNodeNum;
    extern BufList *g_bufHead;
    void SyncAllToDisk(int appPid);
    void SyncOsLogToDisk(StSubLogFileList* pstSubInfo);
    int AppLogFlushFilter(const ToolDirent *dir);
    void SyncAppLogToDisk(const char* path, int appPid);
    void SysStateRecvHandler(const int32_t fd, struct EzcomRequest* req);
    uint8_t DealWithEzcomRequest(const struct EzcomRequest *req);
    void SlogSysStateHandler(int32_t state);
    enum SystemState GetSystemState(void);
    extern void *SlogdCollectLog(ArgPtr arg);
    extern void SlogdStartCollectThread(void);
    extern LogStatus SlogdCollectCompress(char *logBuf);
    extern BufList *g_bufHead;
    extern SlogdStatus g_slogdStatus;
    extern CollectInfo g_collectInfo;
};

#include "iam.h"
#include "log_iam_pub.h"
#include "slogd_communication.h"
#include "start_single_process.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "slogd_group_log.h"
#include "slogd_flush.h"
#include "slogd_syslog.h"
#include "log_pm_sig.h"
#include "slogd_parse_msg.h"
#include "slogd_recv_msg.h"

using namespace std;
using namespace testing;

class SyslogdIamUtest : public testing::Test
{
public:
    void SetUp();
    void TearDown();
};

void SyslogdIamUtest::SetUp()
{
    SlogdCommunicationInit();
}

void SyslogdIamUtest::TearDown()
{
    SlogdCommunicationExit();
    GlobalMockObject::reset();
}

TEST_F(SyslogdIamUtest, SlogdInitGlobals02)
{
    MOCKER(malloc).stubs().will(returnValue((void*)NULL));
    EXPECT_EQ(SYS_ERROR, SlogdCommunicationInit());
    GlobalMockObject::reset();
}

TEST_F(SyslogdIamUtest, RegisterIamService02)
{
    EXPECT_EQ(SYS_OK, RegisterIamTotalService());
    GlobalMockObject::reset();

    MOCKER(RegisterIamService).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(SYS_ERROR, RegisterIamTotalService());
    GlobalMockObject::reset();
}

TEST_F(SyslogdIamUtest, IamRead01)
{
    char string[128];
    int logType = 0;
    // struct BufList **buflist = NULL;
    // buflist = getBufList();
    g_bufHead = NULL;
    EXPECT_EQ(SYS_ERROR, IamRead(NULL, 0, NULL));
    EXPECT_EQ(SYS_INVALID_PARAM, IamRead(string, 128, &logType));
    GlobalMockObject::reset();
}

TEST_F(SyslogdIamUtest, LogIamOpsWrite01)
{
    EXPECT_EQ(SYS_OK, LogIamOpsWrite(NULL, NULL, 2048, NULL));
    GlobalMockObject::reset();

    LogHead head;
    int32_t length = sizeof(RingBufferCtrl) + 400 + 20;
    char *mem = (char *)calloc(1, length);
    RingBufferCtrl *ctrl = (RingBufferCtrl *)mem;
    ctrl->dataLen = 400 + 20;
    ctrl->dataOffset = sizeof(RingBufferCtrl);
    char szBuff[14];
    int32_t count1 = 10;
    int32_t res;
    uint64_t coverCount = 0;
    for (int32_t i = 0; i < 15; i++) {
        sprintf(szBuff,"%s%d","Hello world",count1);
        head.msgLength = strlen(szBuff);
        res = LogBufWrite(ctrl, szBuff, &head, &coverCount);
        count1++;
    }
    MOCKER(malloc).stubs().will(returnValue((void*)NULL));
    EXPECT_EQ(length, LogIamOpsWrite(NULL, (const char *)ctrl, length, NULL));
    free(mem);
    mem = NULL;
    GlobalMockObject::reset();
}

TEST_F(SyslogdIamUtest, LogIamOpsWrite02)
{
    LogHead head;
    int32_t length = sizeof(RingBufferCtrl) + 400 + 20;
    char *mem = (char *)calloc(1, length);
    RingBufferCtrl *ctrl = (RingBufferCtrl *)mem;
    ctrl->dataLen = 400 + 20;
    ctrl->dataOffset = sizeof(RingBufferCtrl);
    char szBuff[14];
    int32_t count1 = 10;
    int32_t res;
    uint64_t coverCount;
    for (int32_t i = 0; i < 15; i++) {
        sprintf(szBuff,"%s%d","Hello world",count1);
        head.msgLength = strlen(szBuff);
        res = LogBufWrite(ctrl, szBuff, &head, &coverCount);
        count1++;
    }
    char *ptr = (char *)malloc(2048);
    MOCKER(malloc).stubs().will(returnValue((void *)ptr));
    EXPECT_EQ(length, LogIamOpsWrite(NULL, (const char *)ctrl, length, NULL));
    free(mem);
    mem = NULL;
    free(ptr);
    ptr = NULL;
    g_bufHead = NULL;
    GlobalMockObject::reset();
}

TEST_F(SyslogdIamUtest, LogIamOpsWrite03)
{
    LogHead head;
    int32_t length = sizeof(RingBufferCtrl) + 400 + 20;
    char *mem = (char *)calloc(1, length);
    RingBufferCtrl *ctrl = (RingBufferCtrl *)mem;
    ctrl->dataLen = 400 + 20;
    ctrl->dataOffset = sizeof(RingBufferCtrl);
    char szBuff[14];
    int32_t count1 = 10;
    int32_t res;
    uint64_t coverCount;
    for (int32_t i = 0; i < 15; i++) {
        sprintf(szBuff,"%s%d","Hello world",count1);
        head.msgLength = strlen(szBuff);
        res = LogBufWrite(ctrl, szBuff, &head, &coverCount);
        count1++;
    }
    g_bufListNodeNum = 50000;
    MOCKER(malloc).stubs().will(returnValue((void*)NULL));
    EXPECT_EQ(SYS_ERROR, LogIamOpsWrite(NULL, (const char *)ctrl, length, NULL));
    g_bufListNodeNum = 0;
    free(mem);
    mem = NULL;
    GlobalMockObject::reset();
}

TEST_F(SyslogdIamUtest, LogIamOpsWriteSecondVerify)
{
    LogHead head;
    int32_t length = sizeof(RingBufferCtrl) + 400 + 20;
    char *mem = (char *)calloc(1, length);
    RingBufferCtrl *ctrl = (RingBufferCtrl *)mem;
    ctrl->dataLen = 400 + 20;
    ctrl->dataOffset = sizeof(RingBufferCtrl);
    ctrl->levelFilter = true;
    char szBuff[14];
    int32_t count1 = 10;
    int32_t res;
    uint64_t coverCount;
    int32_t level[5] = { 0x0, 0x1, 0x2, 0x5, 0x10 };
    int32_t moduleid[5] = { 0, 1, 2, 3, 4 };
    for (int32_t i = 0; i < 5; i++) {
        sprintf(szBuff,"%s%d","Hello world",count1);
        head.logLevel = level[i];
        head.moduleId = moduleid[i];
        head.msgLength = strlen(szBuff);
        res = LogBufWrite(ctrl, szBuff, &head, &coverCount);
        count1++;
    }
    MOCKER(SlogdGetGlobalLevel).stubs().will(returnValue(3));
    MOCKER(SlogdGetEventLevel).stubs().will(returnValue(1));
    MOCKER(SlogdGetModuleLevel).stubs().will(returnValue(0))
                                       .then(returnValue(3))
                                       .then(returnValue(-1));
    g_bufListNodeNum = 0;
    char *ptr = (char *)malloc(2048);
    MOCKER(malloc).stubs().will(returnValue((void*)ptr));
    EXPECT_EQ(length, LogIamOpsWrite(NULL, (const char *)ctrl, length, NULL));
    g_bufListNodeNum = 0;
    free(mem);
    mem = NULL;
    free(ptr);
    ptr = NULL;
    g_bufHead = NULL;
    GlobalMockObject::reset();
}

void FflushLogDataBufStub() {
    LogRecordSigNo(1);
}

TEST_F(SyslogdIamUtest, LogIamOpsIoctl01)
{
    FlushInfo info;
    struct IAMIoctlArg arg;
    arg.size = sizeof(FlushInfo);
    arg.argData = &info;
    EXPECT_EQ(SYS_OK, LogIamOpsIoctl(NULL, IAM_CMD_FLUSH_LOG, &arg));
    EXPECT_EQ(SYS_OK, LogIamOpsIoctl(NULL, IAM_CMD_FLUSH_LOG + 5, &arg));
    GlobalMockObject::reset();
}

TEST_F(SyslogdIamUtest, LogIamOpsIoctlSnprintfFailed)
{
    FlushInfo info = { 100 };
    struct IAMIoctlArg arg;
    arg.size = sizeof(FlushInfo);
    arg.argData = &info;
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    EXPECT_EQ(SYS_OK, LogIamOpsIoctl(NULL, IAM_CMD_FLUSH_LOG, &arg));
    GlobalMockObject::reset();
}

TEST_F(SyslogdIamUtest, LogIamOpsIoctl03)
{
    LogLevelConfInfo levelConfInfo;
    struct IAMIoctlArg arg;
    arg.size = sizeof(LogLevelConfInfo);
    arg.argData = &levelConfInfo;
    MOCKER(LogIamOpsIoctlGetLevel).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, LogIamOpsIoctl(NULL, IAM_CMD_GET_LEVEL, &arg));
    GlobalMockObject::reset();

    MOCKER(LogIamOpsIoctlGetLevel).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(SYS_ERROR, LogIamOpsIoctl(NULL, IAM_CMD_GET_LEVEL, &arg));
    GlobalMockObject::reset();
}

TEST_F(SyslogdIamUtest, LogIamOpsIoctl04)
{
    LogLevelConfInfo levelConfInfo;
    strcpy(levelConfInfo.configName, GLOBALLEVEL_KEY);
    EXPECT_EQ(SYS_OK, LogIamOpsIoctlGetLevel(&levelConfInfo));
    GlobalMockObject::reset();
}

TEST_F(SyslogdIamUtest, LogIamOpsIoctl05)
{
    LogLevelConfInfo levelConfInfo;
    strcpy(levelConfInfo.configName, IOCTL_MODULE_NAME);
    MOCKER(LogConfListGetValue).stubs().will(returnValue(SUCCESS + 1));
    EXPECT_EQ(SYS_OK, LogIamOpsIoctlGetLevel(&levelConfInfo));
    GlobalMockObject::reset();

    char val1[CONF_VALUE_MAX_LEN + 1] = "1";
    MOCKER(LogConfListGetValue).stubs().with(any(), any(), outBoundP(val1), any()).will(returnValue(SUCCESS));
    EXPECT_EQ(SYS_OK, LogIamOpsIoctlGetLevel(&levelConfInfo));
    GlobalMockObject::reset();
}

TEST_F(SyslogdIamUtest, LogIamOpsIoctl_COLLECT_DIRFAILED)
{
    char dir[256] = "test";
    struct IAMIoctlArg arg;
    arg.size = 256;
    arg.argData = (void *)dir;
    EXPECT_EQ(SYS_ERROR, LogIamOpsIoctl(NULL, IAM_CMD_COLLECT_LOG, &arg));
    GlobalMockObject::reset();
}

TEST_F(SyslogdIamUtest, LogIamOpsIoctl_COLLECT)
{
    system("mkdir -p " ROOT_PATH);
    char dir[256] = COLLECT_PATH;
    struct IAMIoctlArg arg;
    arg.size = 256;
    arg.argData = (void *)dir;
    EXPECT_EQ(SYS_OK, LogIamOpsIoctl(NULL, IAM_CMD_COLLECT_LOG, &arg));
    system("rm -rf " ROOT_PATH);
    GlobalMockObject::reset();
}

TEST_F(SyslogdIamUtest, LogIamOpsOpen01)
{
    EXPECT_EQ(SYS_OK, LogIamOpsOpen(NULL));
    GlobalMockObject::reset();
}

TEST_F(SyslogdIamUtest, LogIamOpsClose01)
{
    EXPECT_EQ(SYS_OK, LogIamOpsClose(NULL));
    GlobalMockObject::reset();
}

int SetState() {
    LogRecordSigNo(1);
    return 0;
}

TEST_F(SyslogdIamUtest, SlogdGetLogPatterns)
{
    LogConfigInfo configInfo;
    char val[CONF_VALUE_MAX_LEN + 1] = "tmp/";
    MOCKER(LogConfListGetValue).stubs().with(any(), any(), outBoundP(val), any()).will(returnValue(SUCCESS));
    GeneralGroupInfo info = { 0 };
    snprintf_s(info.agentFileDir, SLOG_AGENT_FILE_DIR + 1, SLOG_AGENT_FILE_DIR, "/home/mdc/var/log/");
    info.map[0].fileRatio = 50;
    info.map[0].isInit = 1;
    snprintf_s(info.map[0].name, GROUP_NAME_MAX_LEN, GROUP_NAME_MAX_LEN - 1, "DRV");
    info.map[1].fileRatio = 50;
    info.map[1].isInit = 1;
    snprintf_s(info.map[1].name, GROUP_NAME_MAX_LEN, GROUP_NAME_MAX_LEN - 1, "ROS");
    MOCKER(LogConfGroupGetInfo).stubs().will(returnValue((const GeneralGroupInfo*)&info));
    EXPECT_EQ(LOG_SUCCESS, SlogdGetLogPatterns(&configInfo));
    EXPECT_STREQ("/home/mdc/var/log/", configInfo.groupPath);
    EXPECT_STREQ("DRV", configInfo.groupName[0]);
    EXPECT_STREQ("ROS", configInfo.groupName[1]);
    GlobalMockObject::verify();
}

TEST_F(SyslogdIamUtest, AppLogFlushFilter01)
{
    ToolDirent *namelist = NULL;
    namelist = (ToolDirent *)malloc(sizeof(ToolDirent));
    strcpy_s(namelist->d_name, 256, "core");
    EXPECT_EQ(0, AppLogFlushFilter(namelist));
    free(namelist);
    namelist = NULL;
    GlobalMockObject::reset();
}

int32_t SysStateRecvHandlerStub(int32_t state)
{
    SlogSysStateHandler(state);
    return 0;
}

TEST_F(SyslogdIamUtest, SysStateRecvHandler)
{
    EXPECT_EQ(0, SysStateRecvHandlerStub(0));
    GlobalMockObject::reset();
}

TEST_F(SyslogdIamUtest, SysStateRecvHandlerSleep)
{
    EXPECT_EQ(0, SysStateRecvHandlerStub(2));
    GlobalMockObject::reset();
}
