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

#include "log_config_common.h"
#include "log_config_block.h"
#include "log_config_group.h"
#include "log_config_api.h"
#include "slogd_config_mgr.h"
#include "slogd_write_limit.h"
#include "log_drv.h"
#include "driver_api.h"
#include "slogd_parse_msg.h"
#include "slogd_recv_msg.h"
#include "log_communication.h"
#include "slogd_appnum_watch.h"
#include "log_to_file.h"
#include "log_file_info.h"
#include "log_session_manage.h"
#include "slogd_dynamic_level.h"
#include "operate_loglevel.h"
#include "log_pm_sig.h"
#include "msg_queue.h"
#include "log_level_stub.h"

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>

using namespace std;

static const char *g_appSortBase = PATH_ROOT "/appsort";

static void SendLevelCmd(toolMsgid qid, const char *cmd, uint32_t sleepUs)
{
    LogCmdMsg msg;
    (void)memset_s(&msg, sizeof(msg), 0, sizeof(msg));
    msg.msgType = FORWARD_MSG_TYPE;
    msg.phyDevId = 0;
    (void)strcpy_s(msg.msgData, MSG_MAX_LEN, cmd);
    (void)MsgQueueSend(qid, (const Buff *)&msg, MSG_MAX_LEN, false);
    usleep(sleepUs);
    LogCmdMsg resp;
    (void)memset_s(&resp, sizeof(resp), 0, sizeof(resp));
    while (MsgQueueRecv(qid, (Buff *)&resp, MSG_MAX_LEN, true, FEEDBACK_MSG_TYPE) == LOG_SUCCESS) {
        (void)memset_s(&resp, sizeof(resp), 0, sizeof(resp));
    }
}

static void DynLevelShmMock(void)
{
    MOCKER(shmget).stubs().will(invoke(shmgetStub));
    MOCKER(shmat).stubs().will(invoke(shmatStub));
    MOCKER(shmdt).stubs().will(invoke(shmdtStub));
    MOCKER(shmctl).stubs().will(invoke(shmctlStub));
}

static drvError_t DrvHdcGetCapacityZeroStub(struct drvHdcCapacity *capacity)
{
    capacity->chanType = HDC_CHAN_TYPE_PCIE;
    capacity->maxSegment = 0U;
    return DRV_ERROR_NONE;
}

static drvError_t DrvHdcGetCapacityHugeStub(struct drvHdcCapacity *capacity)
{
    capacity->chanType = HDC_CHAN_TYPE_PCIE;
    capacity->maxSegment = 0xFFFFFFFFU;
    return DRV_ERROR_NONE;
}

static void SendDataCb(uint32_t pid, uint32_t devId, int32_t timeout)
{
    (void)pid;
    (void)devId;
    (void)timeout;
}

class SLOGD_COVERAGE_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("rm -rf " PATH_ROOT "/*");
        system("mkdir -p " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        EXPECT_EQ(0U, GetErrLogNum());
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

// ------------------------- log_config_common.c -------------------------
TEST_F(SLOGD_COVERAGE_UTEST, LogConfCheckPathCoverage)
{
    EXPECT_FALSE(LogConfCheckPath(NULL, 10));
    EXPECT_FALSE(LogConfCheckPath("/tmp/x.cfg", 0));
    EXPECT_TRUE(LogConfCheckPath("/tmp/x.cfg", strlen("/tmp/x.cfg")));
    EXPECT_TRUE(LogConfCheckPath("/tmp/x.conf", strlen("/tmp/x.conf")));
    EXPECT_TRUE(LogConfCheckPath("/tmp/x.info", strlen("/tmp/x.info")));
    EXPECT_FALSE(LogConfCheckPath("/tmp/x.txt", strlen("/tmp/x.txt")));
    EXPECT_FALSE(LogConfCheckPath("/tmp/x.cfg.txt", strlen("/tmp/x.cfg.txt")));
    EXPECT_EQ(0U, GetErrLogNum());
}

TEST_F(SLOGD_COVERAGE_UTEST, LogConfOpenFileCoverage)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    FILE *fp = NULL;
    EXPECT_EQ(SUCCESS, LogConfOpenFile(&fp, NULL));
    LOG_CLOSE_FILE(fp);

    const char *tmpConf = PATH_ROOT "/sub.conf";
    system("mkdir -p " PATH_ROOT);
    system("cp " CONF_PATH " " PATH_ROOT "/sub.conf");
    EXPECT_EQ(SUCCESS, LogConfOpenFile(&fp, tmpConf));
    LOG_CLOSE_FILE(fp);

    EXPECT_NE(SUCCESS, LogConfOpenFile(&fp, PATH_ROOT "/notexist.conf"));
    EXPECT_NE(SUCCESS, LogConfOpenFile(&fp, PATH_ROOT "/badfile.txt"));
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, LogConfParseLineCoverage)
{
    char name[CONF_NAME_MAX_LEN + 1] = { 0 };
    char val[CONF_VALUE_MAX_LEN + 1] = { 0 };
    EXPECT_EQ(SUCCESS, LogConfParseLine("name=value", name, CONF_NAME_MAX_LEN, val, CONF_VALUE_MAX_LEN));
    EXPECT_STREQ("name", name);
    EXPECT_STREQ("value", val);

    EXPECT_NE(SUCCESS, LogConfParseLine("noequals", name, CONF_NAME_MAX_LEN, val, CONF_VALUE_MAX_LEN));
    EXPECT_EQ(SUCCESS, LogConfParseLine("name=  value  ", name, CONF_NAME_MAX_LEN, val, CONF_VALUE_MAX_LEN));
    EXPECT_STREQ("value", val);
    EXPECT_EQ(SUCCESS, LogConfParseLine("name=value#comment", name, CONF_NAME_MAX_LEN, val, CONF_VALUE_MAX_LEN));
    EXPECT_STREQ("value", val);
    EXPECT_NE(SUCCESS, LogConfParseLine("name=   ", name, CONF_NAME_MAX_LEN, val, CONF_VALUE_MAX_LEN));
    // LogConfParseName trims trailing spaces before '=' (leading spaces are trimmed by the caller)
    EXPECT_EQ(SUCCESS, LogConfParseLine("name  =value", name, CONF_NAME_MAX_LEN, val, CONF_VALUE_MAX_LEN));
    EXPECT_STREQ("name", name);
    EXPECT_EQ(SUCCESS, LogConfParseLine("name=value\r\n", name, CONF_NAME_MAX_LEN, val, CONF_VALUE_MAX_LEN));
    EXPECT_STREQ("value", val);
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, GetSymbolCoverage)
{
    char symbol[SYMBOL_NAME_MAX_LEN + 1] = { 0 };
    EXPECT_EQ(SUCCESS, GetSymbol("[debug]", symbol, sizeof(symbol)));
    EXPECT_STREQ("debug", symbol);

    // "[]" yields an empty symbol but still SUCCESS (current implementation)
    (void)memset_s(symbol, sizeof(symbol), 0, sizeof(symbol));
    EXPECT_EQ(SUCCESS, GetSymbol("[]", symbol, sizeof(symbol)));
    EXPECT_EQ(0U, strlen(symbol));
    // symbol longer than SYMBOL_NAME_MAX_LEN-1 -> error
    EXPECT_NE(SUCCESS, GetSymbol(
        "[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa]",
        symbol, sizeof(symbol)));
    // not a block line -> SUCCESS, symbol left empty
    (void)memset_s(symbol, sizeof(symbol), 0, sizeof(symbol));
    EXPECT_EQ(SUCCESS, GetSymbol("no brackets here", symbol, sizeof(symbol)));
    EXPECT_NE(SUCCESS, GetSymbol(NULL, symbol, sizeof(symbol)));
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, LogConfGetDigitCoverage)
{
    EXPECT_EQ(100U, LogConfGetDigit("name", "100", 1, 1000, 50));
    EXPECT_EQ(1U, LogConfGetDigit("name", "0", 1, 1000, 50));
    EXPECT_EQ(1000U, LogConfGetDigit("name", "2000", 1, 1000, 50));
    EXPECT_EQ(50U, LogConfGetDigit("name", "abc", 1, 1000, 50));
    EXPECT_EQ(1U, LogConfGetDigit("name", "1", 1, 1000, 50));
    EXPECT_EQ(1000U, LogConfGetDigit("name", "1000", 1, 1000, 50));
    ResetErrLog();
}

// ------------------------- log_config_block.c -------------------------
TEST_F(SLOGD_COVERAGE_UTEST, LogConfParseBlockCoverage)
{
    // NOTE: each block's first "class=" line saves a zeroed confClass (logClassify=0) to index 0,
    // so the debug block (logClassify=0) must be parsed LAST, otherwise a later block clobbers index 0.
    const char *conf = "garbageline_outer\n"
                       "[run]\nclass=system\ninput_rule=system\noutput_rule=buffer;1048576;2;2097152\n"
                       "storage_rule=0\n[unknownblock]\nclass=system\n"
                       "[debug]\nclass=system\ninput_rule=system\noutput_rule=file;1048576;2;2097152\n"
                       "storage_rule=24\n";
    const char *confFile = PATH_ROOT "/block.conf";
    FILE *fp = fopen(confFile, "w");
    ASSERT_TRUE(fp != NULL);
    fwrite(conf, 1, strlen(conf), fp);
    fclose(fp);

    fp = fopen(confFile, "r");
    ASSERT_TRUE(fp != NULL);
    LogConfParseBlock(fp);
    fclose(fp);

    LogConfClass *cls = LogConfGetClass(DEBUG_SYS_LOG_TYPE);
    EXPECT_TRUE(cls != NULL);
    EXPECT_STREQ("system", cls->inputRule.inputClassify);
    EXPECT_EQ(DEBUG_SYS_LOG_TYPE, cls->logClassify);
    EXPECT_EQ(0, cls->outputRule.saveMode); // LOG_SAVE_FILE
    EXPECT_EQ(1048576U, cls->outputRule.fileSize);
    EXPECT_EQ(2U, cls->outputRule.fileNum);
    EXPECT_EQ(2097152U, cls->outputRule.totalSize);
    EXPECT_EQ(24U * 3600U, cls->storageRule.storagePeriod);

    LogConfClass *runCls = LogConfGetClass(RUN_SYS_LOG_TYPE);
    EXPECT_TRUE(runCls != NULL);
    EXPECT_EQ(1, runCls->outputRule.saveMode); // LOG_SAVE_BUFFER

    EXPECT_TRUE(LogConfGetClass(-1) == NULL);
    EXPECT_TRUE(LogConfGetClass(LOG_TYPE_MAX_NUM) == NULL);
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, LogConfGetClassCoverage)
{
    EXPECT_TRUE(LogConfGetClass(-1) == NULL);
    EXPECT_TRUE(LogConfGetClass(LOG_TYPE_MAX_NUM) == NULL);
    EXPECT_TRUE(LogConfGetClass(0) != NULL);
    EXPECT_EQ(0U, GetErrLogNum());
}

// ------------------------- log_config_group.c (#else branch) -------------------------
TEST_F(SLOGD_COVERAGE_UTEST, LogConfGroupBranchCoverage)
{
    EXPECT_FALSE(LogConfGroupGetSwitch());
    LogConfGroupInit(NULL);
    LogConfGroupInit("/tmp/nonexistent_group.conf");
    EXPECT_FALSE(LogConfGroupGetSwitch());
    EXPECT_TRUE(LogConfGroupGetInfo() == NULL);
    EXPECT_EQ(0U, GetErrLogNum());
}

// ------------------------- slogd_write_limit.c -------------------------
TEST_F(SLOGD_COVERAGE_UTEST, WriteFileLimitSwitchOffCoverage)
{
    // default config has no WriteLimitSwitch, so switch is off
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    EXPECT_FALSE(SlogdConfigMgrGetWriteFileLimit());

    WriteFileLimit *limit = (WriteFileLimit *)0x1;
    EXPECT_EQ(LOG_SUCCESS, WriteFileLimitInit(&limit, DEBUG_LOG, 1024, 0));
    EXPECT_TRUE(limit == (WriteFileLimit *)0x1); // not allocated when switch off
    WriteFileLimitUnInit(&limit);
    EXPECT_TRUE(WriteFileLimitCheck(NULL, 100, "label"));
    SlogdConfigMgrExit();
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, WriteFileLimitSwitchOnCoverage)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    system("sed -i '/WriteLimitSwitch/d' " SLOG_CONF_FILE_PATH);
    // the source slog.conf has no trailing newline on its last line, so add a blank line first
    system("echo '' >> " SLOG_CONF_FILE_PATH);
    system("echo 'WriteLimitSwitch=1' >> " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    EXPECT_TRUE(SlogdConfigMgrGetWriteFileLimit());

    WriteFileLimit *limit = NULL;
    EXPECT_EQ(LOG_INVALID_PTR, WriteFileLimitInit(NULL, DEBUG_LOG, 1024, 1024));
    limit = (WriteFileLimit *)0x1; // already-initialized pointer
    EXPECT_EQ(LOG_INVALID_PARAM, WriteFileLimitInit(&limit, DEBUG_LOG, 1024, 1024));
    limit = NULL;
    EXPECT_EQ(LOG_INVALID_PARAM, WriteFileLimitInit(&limit, (int32_t)LOG_TYPE_NUM, 1024, 1024));
    EXPECT_TRUE(limit == NULL);
    WriteFileLimitUnInit(&limit);
    WriteFileLimitUnInit(NULL);

    // normal create (non-zero currSize so the computed specification is > 0)
    ASSERT_EQ(LOG_SUCCESS, WriteFileLimitInit(&limit, DEBUG_LOG, 102400, 102400));
    EXPECT_TRUE(limit != NULL);
    // pass: dataLen fits in period left size
    EXPECT_TRUE(WriteFileLimitCheck(limit, 100, "debug"));
    // trigger shared config consumption: make periodConfig usedSize close to totalSize
    limit->periodConfig[limit->periodIndex].usedSize = limit->periodConfig[limit->periodIndex].totalSize - 10;
    EXPECT_TRUE(WriteFileLimitCheck(limit, 100, "debug")); // spills into shared
    // exceed all -> limited
    limit->sharedConfig.usedSize = limit->sharedConfig.totalSize;
    EXPECT_FALSE(WriteFileLimitCheck(limit, 0xFFFFFFFFU, "debug"));
    // already limited -> drop size grows
    EXPECT_FALSE(WriteFileLimitCheck(limit, 100, "debug"));

    // time process: move startTime into the past to force refresh path (periodIndex < NUM-1)
    limit->periodIndex = 0;
    limit->startTime.tv_sec -= (2 * 3600); // 2 hours ago -> 2 refreshes
    EXPECT_TRUE(WriteFileLimitCheck(limit, 10, "debug"));

    // refresh hitting the last period (reset branch)
    limit->periodIndex = WRITE_LIMIT_PERIOD_NUM - 1U;
    limit->startTime.tv_sec -= 3600;
    EXPECT_TRUE(WriteFileLimitCheck(limit, 10, "debug"));

    // drop size overflow path
    limit->periodConfig[limit->periodIndex].isLimit = true;
    limit->periodConfig[limit->periodIndex].dropSize = 0xFFFFFFFFU;
    EXPECT_FALSE(WriteFileLimitCheck(limit, 100, "debug"));

    WriteFileLimitUnInit(&limit);
    EXPECT_TRUE(limit == NULL);
    SlogdConfigMgrExit();
    ResetErrLog();
}

// ------------------------- log_drv.c -------------------------
TEST_F(SLOGD_COVERAGE_UTEST, DrvSessionReleaseCoverage)
{
    EXPECT_EQ(-1, DrvSessionRelease(NULL));
    EXPECT_EQ(0, DrvSessionRelease((HDC_SESSION)0x1000));
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, DrvSessionReleaseErrorCoverage)
{
    MOCKER(drvHdcSessionClose).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    EXPECT_EQ(-1, DrvSessionRelease((HDC_SESSION)0x1000));
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, DrvDevIdGetBySessionCoverage)
{
    int32_t value = 0;
    EXPECT_EQ(-1, DrvDevIdGetBySession(NULL, HDC_SESSION_ATTR_VFID, &value));
    EXPECT_EQ(-1, DrvDevIdGetBySession((HDC_SESSION)0x1000, HDC_SESSION_ATTR_VFID, NULL));
    EXPECT_EQ(0, DrvDevIdGetBySession((HDC_SESSION)0x1000, HDC_SESSION_ATTR_VFID, &value));
    EXPECT_EQ(1, value);
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, DrvDevIdGetBySessionErrorCoverage)
{
    int32_t value = 0;
    MOCKER(halHdcGetSessionAttr).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    EXPECT_EQ(-1, DrvDevIdGetBySession((HDC_SESSION)0x1000, HDC_SESSION_ATTR_VFID, &value));
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, DrvBufWriteCoverage)
{
    char smallBuf[128] = "hello hdc";
    EXPECT_EQ(-1, DrvBufWrite(NULL, smallBuf, sizeof(smallBuf)));
    EXPECT_EQ(-1, DrvBufWrite((HDC_SESSION)0x1000, NULL, sizeof(smallBuf)));
    EXPECT_EQ(-1, DrvBufWrite((HDC_SESSION)0x1000, smallBuf, 0));
    EXPECT_EQ(0, DrvBufWrite((HDC_SESSION)0x1000, smallBuf, strlen(smallBuf)));

    // large buffer -> subcontract into multiple packets
    size_t bigLen = 600 * 1024; // 600KB > 512KB max segment
    char *bigBuf = (char *)calloc(1, bigLen);
    ASSERT_TRUE(bigBuf != NULL);
    memset(bigBuf, 'A', bigLen);
    EXPECT_EQ(0, DrvBufWrite((HDC_SESSION)0x1000, bigBuf, bigLen));
    free(bigBuf);
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, DrvBufWriteCapacityErrorCoverage)
{
    char buf[64] = "data";
    MOCKER(drvHdcGetCapacity).stubs().will(invoke(DrvHdcGetCapacityZeroStub));
    EXPECT_EQ(-1, DrvBufWrite((HDC_SESSION)0x1000, buf, strlen(buf)));
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, DrvBufWriteCapacityHugeCoverage)
{
    char buf[64] = "data";
    MOCKER(drvHdcGetCapacity).stubs().will(invoke(DrvHdcGetCapacityHugeStub));
    EXPECT_EQ(-1, DrvBufWrite((HDC_SESSION)0x1000, buf, strlen(buf)));
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, DrvBufWriteAllocErrorCoverage)
{
    char buf[64] = "data";
    MOCKER(drvHdcAllocMsg).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    EXPECT_EQ(-1, DrvBufWrite((HDC_SESSION)0x1000, buf, strlen(buf)));
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, DrvBufWriteSendErrorCoverage)
{
    char buf[64] = "data";
    MOCKER(halHdcSend).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    EXPECT_EQ(-1, DrvBufWrite((HDC_SESSION)0x1000, buf, strlen(buf)));
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, DrvBufWriteAddMsgErrorCoverage)
{
    char buf[64] = "data";
    MOCKER(drvHdcAddMsgBuffer).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    EXPECT_EQ(-1, DrvBufWrite((HDC_SESSION)0x1000, buf, strlen(buf)));
    ResetErrLog();
}

// ------------------------- slogd_parse_msg.c -------------------------
TEST_F(SLOGD_COVERAGE_UTEST, ProcSyslogBufCoverage)
{
    int32_t size = 0;
    EXPECT_EQ(SYS_ERROR, ProcSyslogBuf(NULL, &size));
    char buf[64] = "hello";
    EXPECT_EQ(SYS_ERROR, ProcSyslogBuf(buf, NULL));
    size = -1;
    EXPECT_EQ(SYS_ERROR, ProcSyslogBuf(buf, &size));
    size = 0;
    EXPECT_EQ(SYS_ERROR, ProcSyslogBuf(buf, &size));

    (void)strcpy_s(buf, sizeof(buf), "abc\0");
    size = 4; // trailing '\0'
    EXPECT_EQ(SYS_OK, ProcSyslogBuf(buf, &size));
    EXPECT_EQ(3, size);

    (void)strcpy_s(buf, sizeof(buf), "abc\n\n");
    size = (int32_t)strlen("abc\n\n");
    EXPECT_EQ(SYS_OK, ProcSyslogBuf(buf, &size));
    EXPECT_EQ(3, size);

    // all-trailing buffer -> strips to 0 -> SYS_ERROR (*size not modified on this path)
    (void)strcpy_s(buf, sizeof(buf), "\n\n");
    size = (int32_t)strlen("\n\n");
    EXPECT_EQ(SYS_ERROR, ProcSyslogBuf(buf, &size));

    (void)strcpy_s(buf, sizeof(buf), "abc");
    size = (int32_t)strlen("abc");
    EXPECT_EQ(SYS_OK, ProcSyslogBuf(buf, &size));
    EXPECT_EQ(3, size);
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, ProcEscapeThenLogCoverage)
{
    EXPECT_EQ(LOG_SUCCESS, SlogdInitGlobals());
    // NULL input
    ProcEscapeThenLog(NULL, 10, DEBUG_LOG);
    ResetErrLog();

    // tag-style message
    {
        char tagBuf[] = "[1,100,0,0,0]hello world";
        ProcEscapeThenLog(tagBuf, (int32_t)strlen(tagBuf), DEBUG_LOG);
        ResetErrLog();
    }
    // tag with newline and control char
    {
        char tagBuf[] = "[0,1,0,0,0]a\nb\x01";
        ProcEscapeThenLog(tagBuf, (int32_t)strlen(tagBuf), RUN_LOG);
        ResetErrLog();
    }
    // binary head-style message (valid magic + version)
    {
        char headBuf[256] = { 0 };
        LogHead head;
        (void)memset_s(&head, sizeof(head), 0, sizeof(head));
        head.magic = HEAD_MAGIC;
        head.version = HEAD_VERSION;
        head.logType = (uint8_t)DEBUG_LOG;
        head.processType = (uint8_t)APPLICATION;
        head.hostPid = 200;
        head.deviceId = 0;
        head.moduleId = 0;
        head.aosType = 0;
        head.logLevel = 0;
        (void)memcpy_s(headBuf, sizeof(headBuf), &head, sizeof(LogHead));
        (void)strcpy_s(headBuf + sizeof(LogHead), sizeof(headBuf) - sizeof(LogHead), "headmsg");
        ProcEscapeThenLog(headBuf, (int32_t)(sizeof(LogHead) + strlen("headmsg")), SECURITY_LOG);
        ResetErrLog();
    }
    // tag with empty payload after ']'
    {
        char tagBuf[] = "[2,2,0,0,0]";
        ProcEscapeThenLog(tagBuf, (int32_t)strlen(tagBuf), DEBUG_LOG);
        ResetErrLog();
    }
    SlogdFreeGlobals();
}

// ------------------------- slogd_appnum_watch.c -------------------------
TEST_F(SLOGD_COVERAGE_UTEST, SlogdApplogSortFileFuncCoverage)
{
    system("rm -rf " PATH_ROOT "/appsort");
    system("mkdir -p " PATH_ROOT "/appsort/device-app-0");
    system("mkdir -p " PATH_ROOT "/appsort/device-app-1");
    system("mkdir -p " PATH_ROOT "/appsort/device-app-empty");
    system("echo data > " PATH_ROOT "/appsort/device-app-0/device-app-0_x.log");
    system("echo data > " PATH_ROOT "/appsort/device-app-1/device-app-1_x.log");
    system("echo data > " PATH_ROOT "/appsort/device-app-empty/other.txt");
    // make device-app-1 newer
    system("touch " PATH_ROOT "/appsort/device-app-1/device-app-1_x.log");

    ToolDirent da;
    ToolDirent db;
    ToolDirent dempty;
    ToolDirent dnonexist;
    (void)memset_s(&da, sizeof(da), 0, sizeof(da));
    (void)memset_s(&db, sizeof(db), 0, sizeof(db));
    (void)memset_s(&dempty, sizeof(dempty), 0, sizeof(dempty));
    (void)memset_s(&dnonexist, sizeof(dnonexist), 0, sizeof(dnonexist));
    (void)strcpy_s(da.d_name, sizeof(da.d_name), "device-app-0");
    (void)strcpy_s(db.d_name, sizeof(db.d_name), "device-app-1");
    (void)strcpy_s(dempty.d_name, sizeof(dempty.d_name), "device-app-empty");
    (void)strcpy_s(dnonexist.d_name, sizeof(dnonexist.d_name), "device-app-nonexist");

    const ToolDirent *pa = &da;
    const ToolDirent *pb = &db;

    // null input cases
    EXPECT_EQ(1, SlogdApplogSortFileFunc(NULL, &pa, &pb));
    EXPECT_EQ(1, SlogdApplogSortFileFunc(g_appSortBase, NULL, &pb));
    const ToolDirent *nullA = NULL;
    EXPECT_EQ(1, SlogdApplogSortFileFunc(g_appSortBase, &nullA, &pb));

    // both dirs with files -> compare newest file mtime
    (void)SlogdApplogSortFileFunc(g_appSortBase, &pa, &pb);

    // dir A empty, dir B with files (numA<=0, numB>0)
    pa = &dempty;
    pb = &db;
    (void)SlogdApplogSortFileFunc(g_appSortBase, &pa, &pb);

    // dir A with files, dir B empty (numA>0, numB<=0)
    pa = &da;
    pb = &dempty;
    (void)SlogdApplogSortFileFunc(g_appSortBase, &pa, &pb);

    // both empty dirs (numA<=0, numB<=0)
    pa = &dempty;
    pb = &dempty;
    (void)SlogdApplogSortFileFunc(g_appSortBase, &pa, &pb);

    // non-existent dir A -> ScanAndGetDirFile fails
    pa = &dnonexist;
    pb = &db;
    EXPECT_EQ(1, SlogdApplogSortFileFunc(g_appSortBase, &pa, &pb));

    ResetErrLog();
}

// ------------------------- log_to_file.c -------------------------
TEST_F(SLOGD_COVERAGE_UTEST, LogToFileMiscCoverage)
{
    EXPECT_EQ(0U, LogCalTotalFileSize(100, 0));
    EXPECT_EQ(0U, LogCalTotalFileSize(100, -1));
    EXPECT_EQ(200U, LogCalTotalFileSize(100, 3));

    StSubLogFileList subInfo;
    (void)memset_s(&subInfo, sizeof(subInfo), 0, sizeof(subInfo));
    (void)strcpy_s(subInfo.filePath, sizeof(subInfo.filePath), PATH_ROOT "/logdir");
    (void)strcpy_s(subInfo.fileName, sizeof(subInfo.fileName), "device-os_x.log");
    char full[MAX_FULLPATH_LEN + 1] = { 0 };
    EXPECT_EQ(OK, FilePathSplice(&subInfo, full, sizeof(full) - 1U));
    EXPECT_TRUE(strstr(full, "device-os_x.log") != NULL);

    EXPECT_EQ(NOK, LogAgentRemoveFile(NULL));
    EXPECT_EQ(NOK, LogAgentRemoveFile(PATH_ROOT "/no_such_file.log"));
    const char *tmpFile = PATH_ROOT "/tmp_remove.log";
    FILE *fp = fopen(tmpFile, "w");
    ASSERT_TRUE(fp != NULL);
    fwrite("x", 1, 1, fp);
    fclose(fp);
    EXPECT_EQ(OK, LogAgentRemoveFile(tmpFile));

    EXPECT_EQ(NOK, LogAgentInitMaxFileNumHelper(NULL, PATH_ROOT, 10));
    EXPECT_EQ(NOK, LogAgentInitMaxFileNumHelper(&subInfo, NULL, 10));
    EXPECT_EQ(NOK, LogAgentInitMaxFileNumHelper(&subInfo, PATH_ROOT, 0));
    EXPECT_EQ(OK, LogAgentInitMaxFileNumHelper(&subInfo, PATH_ROOT "/logdir", (int32_t)strlen(PATH_ROOT "/logdir")));
    EXPECT_STREQ(PATH_ROOT "/logdir", subInfo.filePath);

    // LogFileMgrInitClass
    StSubLogFileList classList;
    (void)memset_s(&classList, sizeof(classList), 0, sizeof(classList));
    LogConfClass confClass;
    (void)memset_s(&confClass, sizeof(confClass), 0, sizeof(confClass));
    confClass.outputRule.fileSize = 1024;
    confClass.outputRule.totalSize = 4096;
    confClass.outputRule.fileNum = 3;
    confClass.storageRule.storagePeriod = 3600;
    (void)strcpy_s(confClass.className, sizeof(confClass.className), "device-os");
    LogFileMgrInitClass(&classList, &confClass);
    EXPECT_EQ(1024U, classList.maxFileSize);
    EXPECT_EQ(3072U, classList.totalMaxFileSize);
    EXPECT_EQ(3600U, classList.storage.period);
    EXPECT_EQ(3U, classList.storage.maxFileNum);
    EXPECT_STREQ("device-os_", classList.fileHead);

    // empty class name -> snprintf skipped branch
    (void)memset_s(&confClass, sizeof(confClass), 0, sizeof(confClass));
    (void)memset_s(&classList, sizeof(classList), 0, sizeof(classList));
    LogFileMgrInitClass(&classList, &confClass);
    EXPECT_EQ(0U, strlen(classList.fileHead));

    // LogAgentCreateNewFileName
    StSubLogFileList newFile;
    (void)memset_s(&newFile, sizeof(newFile), 0, sizeof(newFile));
    (void)strcpy_s(newFile.fileHead, sizeof(newFile.fileHead), "device-os_");
    EXPECT_EQ(OK, LogAgentCreateNewFileName(&newFile));
    EXPECT_TRUE(strlen(newFile.fileName) > 0);
    EXPECT_EQ(NOK, LogAgentCreateNewFileName(NULL));

    // LogAgentGetCfg
    EXPECT_EQ(LOG_INVALID_PTR, LogAgentGetCfg(NULL));
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, LogAgentGetCfgAndStorageCoverage)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    StLogFileList logList;
    (void)memset_s(&logList, sizeof(logList), 0, sizeof(logList));
    EXPECT_EQ(LOG_SUCCESS, LogAgentGetCfg(&logList));
    EXPECT_TRUE(strlen(logList.aucFilePath) > 0);

    // LogFileMgrStorage early-return paths
    StSubLogFileList sub;
    (void)memset_s(&sub, sizeof(sub), 0, sizeof(sub));
    LogFileMgrStorage(NULL);
    sub.storage.period = 100;
    sub.storage.curTime = 10; // curTime < period -> return
    LogFileMgrStorage(&sub);
    EXPECT_EQ(0U, strlen(sub.fileName));
    SlogdConfigMgrExit();
    ResetErrLog();
}

// ------------------------- log_session_manage.c -------------------------
TEST_F(SLOGD_COVERAGE_UTEST, SessionNodeListCoverage)
{
    EXPECT_EQ(SUCCESS, InitSessionList());
    EXPECT_TRUE(IsSessionNodeListNull());
    EXPECT_TRUE(GetSessionNode(100, GLOBAL_MAX_DEV_NUM) == NULL); // invalid devId
    EXPECT_TRUE(GetDeletedSessionNode(100, GLOBAL_MAX_DEV_NUM) == NULL);
    EXPECT_TRUE(PopDeletedSessionNode() == NULL); // empty
    EXPECT_EQ(ARGV_NULL, InsertSessionNode(0, 100, GLOBAL_MAX_DEV_NUM)); // invalid devId
    EXPECT_EQ(ARGV_NULL, DeleteSessionNode(0, 100, GLOBAL_MAX_DEV_NUM)); // invalid devId
    EXPECT_EQ(ARGV_NULL, DeleteSessionNode(0, 100, -1));
    EXPECT_EQ(ARGV_NULL, DeleteSessionNode(0, 100, 0)); // empty list, valid devId

    EXPECT_EQ(SUCCESS, InsertSessionNode(0x100, 100, 0));
    EXPECT_EQ(SUCCESS, InsertSessionNode(0x101, 101, 0));
    EXPECT_FALSE(IsSessionNodeListNull());
    SessionNode *n = GetSessionNode(100, 0);
    EXPECT_TRUE(n != NULL);
    EXPECT_EQ(100, n->pid);
    EXPECT_TRUE(GetSessionNode(999, 0) == NULL);
    EXPECT_TRUE(GetDeletedSessionNode(100, 0) == NULL); // not in deleted list

    // delete head
    EXPECT_EQ(SUCCESS, DeleteSessionNode(0x100, 100, 0));
    // delete non-head
    EXPECT_EQ(SUCCESS, DeleteSessionNode(0x101, 101, 0));
    // delete non-existent (list empty now)
    EXPECT_EQ(ARGV_NULL, DeleteSessionNode(0x102, 102, 0));
    // popped deleted node should exist
    SessionNode *popped = PopDeletedSessionNode();
    EXPECT_TRUE(popped != NULL);
    SessionNode *iter = popped;
    while (iter != NULL) {
        SessionNode *next = iter->next;
        free(iter);
        iter = next;
    }
    FreeSessionList();
    EXPECT_TRUE(IsSessionNodeListNull());
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, SessionPushPopListCoverage)
{
    EXPECT_EQ(SUCCESS, InitSessionList());
    // push single nodes
    SessionNode *s1 = (SessionNode *)calloc(1, sizeof(SessionNode));
    SessionNode *s2 = (SessionNode *)calloc(1, sizeof(SessionNode));
    ASSERT_TRUE(s1 != NULL && s2 != NULL);
    s1->pid = 1;
    s2->pid = 2;
    PushDeletedSessionNode(s1); // list: [s1]
    PushDeletedSessionNode(s2); // list: [s2, s1]
    // push a node which itself is a list (next != NULL)
    SessionNode *s3 = (SessionNode *)calloc(1, sizeof(SessionNode));
    SessionNode *s4 = (SessionNode *)calloc(1, sizeof(SessionNode));
    ASSERT_TRUE(s3 != NULL && s4 != NULL);
    s3->pid = 3;
    s4->pid = 4;
    s3->next = s4;
    PushDeletedSessionNode(s3); // appended to tail

    SessionNode *head = PopDeletedSessionNode();
    EXPECT_TRUE(head != NULL);
    SessionNode *iter = head;
    while (iter != NULL) {
        SessionNode *next = iter->next;
        free(iter);
        iter = next;
    }
    EXPECT_TRUE(PopDeletedSessionNode() == NULL);
    FreeSessionList();
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, HandleDeletedSessionNodeCoverage)
{
    EXPECT_EQ(SUCCESS, InitSessionList());
    // node that times out (timeout=1 -> freed, DevLogReportEnd called)
    SessionNode *dn = (SessionNode *)calloc(1, sizeof(SessionNode));
    ASSERT_TRUE(dn != NULL);
    dn->pid = 300;
    dn->devId = 0;
    dn->session = (uintptr_t)0x3000;
    dn->timeout = 1;
    PushDeletedSessionNode(dn);
    HandleDeletedSessionNode(SendDataCb);
    EXPECT_TRUE(PopDeletedSessionNode() == NULL);

    // node that does NOT time out (stays in list)
    SessionNode *dn2 = (SessionNode *)calloc(1, sizeof(SessionNode));
    ASSERT_TRUE(dn2 != NULL);
    dn2->pid = 301;
    dn2->devId = 0;
    dn2->session = (uintptr_t)0x3001;
    dn2->timeout = 2000; // > ONE_SECOND(1000) so it does NOT time out and stays in the list
    PushDeletedSessionNode(dn2);
    HandleDeletedSessionNode(SendDataCb);
    EXPECT_TRUE(PopDeletedSessionNode() != NULL); // still there
    FreeSessionList();
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, HandleInvalidSessionNodeCoverage)
{
    EXPECT_EQ(SUCCESS, InitSessionList());
    // empty list -> no-op
    HandleInvalidSessionNode();
    // insert a node; stub halHdcGetSessionAttr returns success -> node stays
    EXPECT_EQ(SUCCESS, InsertSessionNode((uintptr_t)0x4000, 400, 0));
    HandleInvalidSessionNode();
    EXPECT_FALSE(IsSessionNodeListNull());
    FreeSessionList();
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, HandleInvalidSessionNodeRemoveCoverage)
{
    EXPECT_EQ(SUCCESS, InitSessionList());
    EXPECT_EQ(SUCCESS, InsertSessionNode((uintptr_t)0x5000, 500, 0));
    EXPECT_EQ(SUCCESS, InsertSessionNode((uintptr_t)0x5001, 501, 0));
    // mock halHdcGetSessionAttr to fail -> nodes treated invalid, released+freed
    MOCKER(halHdcGetSessionAttr).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    HandleInvalidSessionNode();
    EXPECT_TRUE(IsSessionNodeListNull());
    FreeSessionList();
    ResetErrLog();
}

TEST_F(SLOGD_COVERAGE_UTEST, SendDataToSessionNodeCoverage)
{
    EXPECT_EQ(SUCCESS, InitSessionList());
    // no node present
    EXPECT_EQ(ARGV_NULL, SendDataToSessionNode(600, 0, "data", 4));
    EXPECT_EQ(SUCCESS, InsertSessionNode((uintptr_t)0x6000, 600, 0));
    EXPECT_EQ(0, SendDataToSessionNode(600, 0, "data", 4));
    FreeSessionList();
    ResetErrLog();
}

// ------------------------- slogd_dynamic_level.c -------------------------
TEST_F(SLOGD_COVERAGE_UTEST, DynamicSetLevelCoverage)
{
    DynLevelShmMock();
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    system("mkdir -p " DEFAULT_LOG_WORKSPACE);
    system("> " DEFAULT_LOG_WORKSPACE "/" LEVEL_NOTIFY_FILE);
    EXPECT_EQ(LOG_SUCCESS, LogConfInit());
    LogRecordSigNo(0); // make sure the worker thread is willing to run
    EXPECT_EQ(LOG_SUCCESS, SlogdLevelInit(-1, 0, FALSE));
    usleep(300000); // let thread init module arr, handle level change, then block on recv

    toolMsgid qid = -1;
    EXPECT_EQ(LOG_SUCCESS, MsgQueueOpen(&qid));

    SendLevelCmd(qid, "GetLogLevel", 80000);
    SendLevelCmd(qid, "GetLogLevelTableFormat", 80000);
    SendLevelCmd(qid, "SetLogLevel(0)[info]", 250000);          // global success path
    SendLevelCmd(qid, "SetLogLevel(1)[SLOG:debug]", 120000);    // module success path
    SendLevelCmd(qid, "SetLogLevel(2)[enable]", 100000);        // event success path
    SendLevelCmd(qid, "SetLogLevel(9)[info]", 50000);           // invalid mode
    SendLevelCmd(qid, "SetLogLevel(0)[badlevel]", 50000);       // invalid global level
    SendLevelCmd(qid, "SetLogLevel(1)[BADMOD:debug]", 50000);   // invalid module name
    SendLevelCmd(qid, "SetLogLevel(2)[badval]", 50000);         // invalid event value
    SendLevelCmd(qid, "SetLogLevel(0)[info", 50000);            // malformed (no ')')
    SendLevelCmd(qid, "BadCommand", 50000);                     // invalid prefix

    LogRecordSigNo(15);
    SendLevelCmd(qid, "GetLogLevel", 200000); // unblock recv so the worker checks signal and exits
    MsgQueueRemove();
    usleep(100000); // ensure any blocked worker exits after queue removal
    SlogdLevelExit();
    system("rm " DEFAULT_LOG_WORKSPACE "/" LEVEL_NOTIFY_FILE);
    ResetErrLog();
}
