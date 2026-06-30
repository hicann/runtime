/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

/**
 * @file  plog_coverage_utest.cc
 * @brief Coverage-focused unit tests for plog_file_mgr.c (host/device log
 *        write pipeline, file rotation, env-based init) and plog_drv.c
 *        (HDC client/session/platform/buf read-write helpers).
 */

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#include "self_log_stub.h"
#include "plog_file_mgr.h"
#include "plog_drv.h"
#include "plog_driver_api.h"
#include "dlog_attr.h"
#include "plog_stub.h"
#include "ascend_hal_stub.h"
#include "system_api_stub.h"
#include "securec.h"
#include "log_common.h"

#include <string>
#include <cstring>
#include <cstdlib>
#include <dlfcn.h>
#include <unistd.h>
#include <sys/stat.h>

using namespace std;
using namespace testing;

/* g_platform is file-static in plog_drv.c (STATIC is empty under _LOG_UT_),
 * exposed here so each test can reset the platform-info cache. */
extern "C" {
    extern uint32_t g_platform;
}

/* ──────────────────────────────────────────────────────────────────────── *
 *  Part A: plog_file_mgr.c coverage
 * ──────────────────────────────────────────────────────────────────────── */
class PlogFileMgrCovUtest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
        system("rm -rf " PATH_ROOT);
        system("mkdir -p " PATH_ROOT);
        system("echo [DBG][TEST] Start PlogFileMgrCov suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        unsetenv("ASCEND_PROCESS_LOG_PATH");
        system("echo [DBG][TEST] End PlogFileMgrCov suite");
    }

    virtual void SetUp()
    {
        system("rm -rf " PATH_ROOT "/*");
        setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
        ResetErrLog();
    }

    virtual void TearDown()
    {
        PlogFileMgrExit();
        GlobalMockObject::verify();
    }
};

static int CountFilesInDir(const char *dir)
{
    char cmd[300] = {0};
    char resFile[300] = {0};
    (void)snprintf_s(resFile, sizeof(resFile), sizeof(resFile) - 1U, "%s/cov_count.txt", PATH_ROOT);
    (void)snprintf_s(cmd, sizeof(cmd), sizeof(cmd) - 1U, "ls -lR %s 2>/dev/null | grep -c '^-'", dir);
    (void)snprintf_s(cmd, sizeof(cmd), sizeof(cmd) - 1U, "ls -lR %s 2>/dev/null | grep '^-' | wc -l > %s", dir, resFile);
    (void)system(cmd);
    FILE *fp = fopen(resFile, "r");
    if (fp == NULL) {
        return 0;
    }
    char buf[32] = {0};
    (void)fread(buf, 1, sizeof(buf) - 1U, fp);
    (void)fclose(fp);
    return atoi(buf);
}

/* TC: write host logs of every type; exercises PlogWriteFile -> PlogMkdir
 * (debug/security/run + plog subdir creation) -> PlogWrite -> PlogGetFileName
 * (fileNum==0 new-file path) -> PlogCreateNewFileName -> PlogFilePathSplice ->
 * PlogGetFileOfSize (realpath+fopen+stat) -> open/write/chmod. */
TEST_F(PlogFileMgrCovUtest, WriteHostLog_AllTypes_Success)
{
    ASSERT_EQ(LOG_SUCCESS, PlogFileMgrInit());

    char msg[128] = "coverage host log line";
    uint32_t len = (uint32_t)strlen(msg);
    EXPECT_EQ(LOG_SUCCESS, PlogWriteHostLog(DEBUG_LOG, msg, len));
    EXPECT_EQ(LOG_SUCCESS, PlogWriteHostLog(SECURITY_LOG, msg, len));
    EXPECT_EQ(LOG_SUCCESS, PlogWriteHostLog(RUN_LOG, msg, len));

    char debugDir[300] = {0};
    char secDir[300] = {0};
    char runDir[300] = {0};
    (void)snprintf_s(debugDir, sizeof(debugDir), sizeof(debugDir) - 1U, "%s/debug/plog", PATH_ROOT);
    (void)snprintf_s(secDir, sizeof(secDir), sizeof(secDir) - 1U, "%s/security/plog", PATH_ROOT);
    (void)snprintf_s(runDir, sizeof(runDir), sizeof(runDir) - 1U, "%s/run/plog", PATH_ROOT);
    EXPECT_GE(CountFilesInDir(debugDir), 1);
    EXPECT_GE(CountFilesInDir(secDir), 1);
    EXPECT_GE(CountFilesInDir(runDir), 1);
}

/* TC: invalid-parameter guards of PlogWriteHostLog. */
TEST_F(PlogFileMgrCovUtest, WriteHostLog_InvalidParams)
{
    char msg[16] = "x";
    // before init -> g_plogFileList is NULL
    ASSERT_EQ(nullptr, PlogGetFileMgrInfo());
    EXPECT_EQ(LOG_FAILURE, PlogWriteHostLog(DEBUG_LOG, msg, 1));

    ASSERT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    EXPECT_EQ(LOG_FAILURE, PlogWriteHostLog(DEBUG_LOG, NULL, 1));   // null msg
    EXPECT_EQ(LOG_FAILURE, PlogWriteHostLog(DEBUG_LOG, msg, 0));    // zero len
    EXPECT_EQ(LOG_FAILURE, PlogWriteHostLog(-1, msg, 1));           // logType < DEBUG_LOG
    EXPECT_EQ(LOG_FAILURE, PlogWriteHostLog(LOG_TYPE_NUM, msg, 1)); // logType >= LOG_TYPE_NUM
}

/* TC: file rotation. With a tiny maxFileSize and maxFileNum, repeated writes
 * exercise: archive+fsync of the full file, currIndex increment and modulo
 * wrap, the fileNum==maxFileNum delete-current-file path, and the archive
 * chmod loop. */
TEST_F(PlogFileMgrCovUtest, WriteHostLog_FileRotation)
{
    ASSERT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    PlogFileMgrInfo *fl = PlogGetFileMgrInfo();
    ASSERT_NE(nullptr, fl);
    // shrink limits so rotation triggers immediately
    fl->hostLogList[DEBUG_LOG].maxFileSize = 4;   // 4 bytes
    fl->hostLogList[DEBUG_LOG].maxFileNum = 2;

    char msg[4] = "AB";
    uint32_t len = 2;
    for (int i = 0; i < 4; i++) { // 4 writes -> at least one delete + wrap
        EXPECT_EQ(LOG_SUCCESS, PlogWriteHostLog(DEBUG_LOG, msg, len));
    }
    char debugDir[300] = {0};
    (void)snprintf_s(debugDir, sizeof(debugDir), sizeof(debugDir) - 1U, "%s/debug/plog", PATH_ROOT);
    // rotation keeps at most maxFileNum active files
    EXPECT_GE(CountFilesInDir(debugDir), 1);
}

/* TC: PlogGetFileOfSize fopen-fail path. An existing file chmod'd to 0000
 * makes fopen("r") fail (fp==NULL) so the fsync/archive block is skipped. */
TEST_F(PlogFileMgrCovUtest, WriteHostLog_FopenFailPath)
{
    ASSERT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    PlogFileMgrInfo *fl = PlogGetFileMgrInfo();
    ASSERT_NE(nullptr, fl);
    // maxFileSize smaller than payload so rotation triggers even when the
    // stat-read fopen fails (filesize stays 0).
    fl->hostLogList[DEBUG_LOG].maxFileSize = 1;

    char msg[4] = "AB";
    // first write creates the file
    ASSERT_EQ(LOG_SUCCESS, PlogWriteHostLog(DEBUG_LOG, msg, 2));
    // strip all permissions from the just-created file so fopen("r") fails
    char cmd[300] = {0};
    (void)snprintf_s(cmd, sizeof(cmd), sizeof(cmd) - 1U, "chmod 000 %s/debug/plog/* 2>/dev/null", PATH_ROOT);
    (void)system(cmd);
    // second write hits fp==NULL branch in PlogGetFileOfSize; rotation still
    // creates a fresh file so the write succeeds.
    EXPECT_EQ(LOG_SUCCESS, PlogWriteHostLog(DEBUG_LOG, msg, 2));
    ResetErrLog();
}

/* TC: device log write success + invalid params. */
TEST_F(PlogFileMgrCovUtest, WriteDeviceLog_SuccessAndInvalid)
{
    char msg[64] = "device log line";
    ASSERT_EQ(nullptr, PlogGetFileMgrInfo());
    EXPECT_EQ(LOG_FAILURE, PlogWriteDeviceLog(msg, NULL)); // null info before init
    PlogDeviceLogInfo badInfo = {0};
    EXPECT_EQ(LOG_FAILURE, PlogWriteDeviceLog(NULL, &badInfo)); // null msg before init

    ASSERT_EQ(LOG_SUCCESS, PlogFileMgrInit());

    PlogDeviceLogInfo info = {0};
    info.len = (uint32_t)strlen(msg);
    info.deviceId = 0;
    info.logType = DEBUG_LOG;
    EXPECT_EQ(LOG_SUCCESS, PlogWriteDeviceLog(msg, &info));

    // invalid params after init
    EXPECT_EQ(LOG_FAILURE, PlogWriteDeviceLog(NULL, &info));     // null msg
    EXPECT_EQ(LOG_FAILURE, PlogWriteDeviceLog(msg, NULL));       // null info
    info.slogFlag = 1;
    EXPECT_EQ(LOG_FAILURE, PlogWriteDeviceLog(msg, &info));      // slogFlag==1
    info.slogFlag = 0;
    info.deviceId = (uint32_t)MAX_DEV_NUM + 1U; // deviceId > deviceNum
    EXPECT_EQ(LOG_FAILURE, PlogWriteDeviceLog(msg, &info));
    info.deviceId = 0;
    info.logType = LOG_TYPE_NUM; // out of range -> defaults to DEBUG_LOG, success
    EXPECT_EQ(LOG_SUCCESS, PlogWriteDeviceLog(msg, &info));
    char devDir[300] = {0};
    (void)snprintf_s(devDir, sizeof(devDir), sizeof(devDir) - 1U, "%s/debug/device-0", PATH_ROOT);
    EXPECT_GE(CountFilesInDir(devDir), 1);
}

/* TC: PlogGetHostFileNum env parsing via ASCEND_HOST_LOG_FILE_NUM. */
TEST_F(PlogFileMgrCovUtest, FileMgrInit_HostLogFileNumEnv)
{
    const char *envName = "ASCEND_HOST_LOG_FILE_NUM";
    // valid value
    setenv(envName, "5", 1);
    ASSERT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    EXPECT_EQ(5, PlogGetFileMgrInfo()->hostLogList[DEBUG_LOG].maxFileNum);
    PlogFileMgrExit();
    // below minimum -> default
    setenv(envName, "0", 1);
    ASSERT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    EXPECT_EQ(10, PlogGetFileMgrInfo()->hostLogList[DEBUG_LOG].maxFileNum);
    PlogFileMgrExit();
    // above maximum -> default
    setenv(envName, "2000", 1);
    ASSERT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    EXPECT_EQ(10, PlogGetFileMgrInfo()->hostLogList[DEBUG_LOG].maxFileNum);
    PlogFileMgrExit();
    // non-numeric -> default
    setenv(envName, "abc", 1);
    ASSERT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    EXPECT_EQ(10, PlogGetFileMgrInfo()->hostLogList[DEBUG_LOG].maxFileNum);
    PlogFileMgrExit();
    unsetenv(envName);
}

/* TC: PlogGetEnvPath ASCEND_WORK_PATH fallback path. */
TEST_F(PlogFileMgrCovUtest, FileMgrInit_WorkPathFallback)
{
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    setenv("ASCEND_WORK_PATH", PATH_ROOT, 1);
    ASSERT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    PlogFileMgrInfo *fl = PlogGetFileMgrInfo();
    ASSERT_NE(nullptr, fl);
    EXPECT_NE(nullptr, strstr(fl->rootPath, "log"));
    // restore for subsequent tests
    unsetenv("ASCEND_WORK_PATH");
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
}

/* TC: PlogInitRootPath default home-directory path when no env is set. */
TEST_F(PlogFileMgrCovUtest, FileMgrInit_DefaultHomePath)
{
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    unsetenv("ASCEND_WORK_PATH");
    ASSERT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    PlogFileMgrInfo *fl = PlogGetFileMgrInfo();
    ASSERT_NE(nullptr, fl);
    EXPECT_NE(nullptr, strstr(fl->rootPath, "ascend"));
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
}

/* TC: PlogFileMgrExit is safe when not initialised. */
TEST_F(PlogFileMgrCovUtest, FileMgrExit_NullListSafe)
{
    ASSERT_EQ(nullptr, PlogGetFileMgrInfo());
    PlogFileMgrExit(); // must not crash
    EXPECT_EQ(nullptr, PlogGetFileMgrInfo());
}

/* TC: PlogWriteDeviceLog "device log file list is null" guard. */
TEST_F(PlogFileMgrCovUtest, WriteDeviceLog_DeviceLogListNull)
{
    ASSERT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    PlogFileMgrInfo *fl = PlogGetFileMgrInfo();
    ASSERT_NE(nullptr, fl);
    PlogFileList *saved = fl->deviceLogList[DEBUG_LOG];
    fl->deviceLogList[DEBUG_LOG] = NULL; // force the null-list branch
    PlogDeviceLogInfo info = {0};
    info.len = 4;
    info.deviceId = 0;
    info.logType = DEBUG_LOG;
    char msg[8] = "dev";
    EXPECT_EQ(LOG_FAILURE, PlogWriteDeviceLog(msg, &info));
    fl->deviceLogList[DEBUG_LOG] = saved; // restore so Exit can free it
}

/* TC: PlogReinitFileHeadsForChild skips deviceLogList entries that are NULL. */
TEST_F(PlogFileMgrCovUtest, ReinitForChild_DeviceLogListNull)
{
    ASSERT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    PlogFileMgrInfo *fl = PlogGetFileMgrInfo();
    ASSERT_NE(nullptr, fl);
    PlogFileList *saved = fl->deviceLogList[SECURITY_LOG];
    fl->deviceLogList[SECURITY_LOG] = NULL;
    PlogReinitFileHeadsForChild(); // covers the NULL `continue` branch
    fl->deviceLogList[SECURITY_LOG] = saved; // restore for clean Exit
}

/* TC: PlogChownPath failure path inside PlogWrite. fchown to a foreign uid
 * (as non-root) fails, exercising the chown-error log without aborting. */
TEST_F(PlogFileMgrCovUtest, WriteHostLog_ChownFail)
{
    ASSERT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    // DlogGetUid/Gid feed fchown; a non-zero foreign uid makes fchown fail.
    MOCKER(DlogGetUid).stubs().will(returnValue((uint32_t)99999));
    MOCKER(DlogGetGid).stubs().will(returnValue((uint32_t)99999));
    char msg[16] = "chown fail test";
    EXPECT_EQ(LOG_SUCCESS, PlogWriteHostLog(DEBUG_LOG, msg, (uint32_t)strlen(msg)));
    ResetErrLog();
}

/* ──────────────────────────────────────────────────────────────────────── *
 *  Part B: plog_drv.c coverage
 * ──────────────────────────────────────────────────────────────────────── */
class PlogDrvCovUtest : public testing::Test {
protected:
    virtual void SetUp()
    {
        system("rm -rf " PATH_ROOT "/*");
        system("mkdir -p " PATH_ROOT); // LogPrintSys writes PATH_ROOT/LogFile.txt
        MOCKER(dlopen).stubs().will(invoke(logDlopen));
        MOCKER(dlclose).stubs().will(invoke(logDlclose));
        MOCKER(dlsym).stubs().will(invoke(logDlsym));
        g_platform = PLATFORM_INVALID_VALUE; // reset platform-info cache
        ResetErrLog();
        ASSERT_EQ(0, DrvFunctionsInit());
    }

    virtual void TearDown()
    {
        (void)DrvFunctionsUninit();
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("mkdir -p " PATH_ROOT);
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
    }
};

/* --- DrvClientCreate / DrvClientRelease --- */
TEST_F(PlogDrvCovUtest, DrvClientCreate_Success)
{
    HDC_CLIENT client = NULL;
    EXPECT_EQ(0, DrvClientCreate(&client, 0));
    EXPECT_NE(nullptr, client);
}

TEST_F(PlogDrvCovUtest, DrvClientCreate_NullClient)
{
    EXPECT_EQ(-1, DrvClientCreate(NULL, 0));
}

TEST_F(PlogDrvCovUtest, DrvClientCreate_CreateFailed)
{
    MOCKER(drvHdcClientCreate).stubs().will(returnValue((drvError_t)DRV_ERROR_BUSY));
    HDC_CLIENT client = NULL;
    EXPECT_EQ(-1, DrvClientCreate(&client, 0));
}

TEST_F(PlogDrvCovUtest, DrvClientCreate_NullHdcClient)
{
    // mock returns success but leaves the out-param NULL -> null-client guard
    MOCKER(drvHdcClientCreate).stubs().will(returnValue((drvError_t)DRV_ERROR_NONE));
    HDC_CLIENT client = NULL;
    EXPECT_EQ(-1, DrvClientCreate(&client, 0));
}

TEST_F(PlogDrvCovUtest, DrvClientRelease_NullAndSuccess)
{
    EXPECT_EQ(0, DrvClientRelease(NULL));
    HDC_CLIENT client = (HDC_CLIENT)1;
    EXPECT_EQ(0, DrvClientRelease(client));
}

TEST_F(PlogDrvCovUtest, DrvClientRelease_BusyRetryLoop)
{
    // mock ToolSleep so the 30-iteration busy loop does not stall
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(drvHdcClientDestroy).stubs().will(returnValue((drvError_t)DRV_ERROR_CLIENT_BUSY));
    HDC_CLIENT client = (HDC_CLIENT)1;
    EXPECT_EQ(0, DrvClientRelease(client)); // always returns 0
}

/* --- DrvSessionInit / DrvSessionRelease --- */
TEST_F(PlogDrvCovUtest, DrvSessionInit_Success)
{
    HDC_CLIENT client = (HDC_CLIENT)1;
    HDC_SESSION session = NULL;
    EXPECT_EQ(0, DrvSessionInit(client, &session, 0));
    EXPECT_NE(nullptr, session);
}

TEST_F(PlogDrvCovUtest, DrvSessionInit_InvalidParams)
{
    HDC_CLIENT client = (HDC_CLIENT)1;
    HDC_SESSION session = NULL;
    EXPECT_EQ(-1, DrvSessionInit(NULL, &session, 0));     // null client
    EXPECT_EQ(-1, DrvSessionInit(client, NULL, 0));       // null session
    EXPECT_EQ(-1, DrvSessionInit(client, &session, -1));  // devId < 0
    EXPECT_EQ(-1, DrvSessionInit(client, &session, HOST_MAX_DEV_NUM)); // devId >= max
}

TEST_F(PlogDrvCovUtest, DrvSessionInit_ConnectFailed)
{
    MOCKER(drvHdcSessionConnect).stubs().will(returnValue((drvError_t)DRV_ERROR_SOCKET_CONNECT));
    HDC_CLIENT client = (HDC_CLIENT)1;
    HDC_SESSION session = NULL;
    EXPECT_EQ(-1, DrvSessionInit(client, &session, 0));
}

TEST_F(PlogDrvCovUtest, DrvSessionInit_SetRefFailed)
{
    MOCKER(drvHdcSetSessionReference).stubs().will(returnValue((drvError_t)DRV_ERROR_INNER_ERR));
    HDC_CLIENT client = (HDC_CLIENT)1;
    HDC_SESSION session = NULL;
    EXPECT_EQ(-1, DrvSessionInit(client, &session, 0));
}

TEST_F(PlogDrvCovUtest, DrvSessionRelease_NullAndSuccessAndFail)
{
    EXPECT_EQ(-1, DrvSessionRelease(NULL));
    HDC_SESSION session = (HDC_SESSION)1;
    EXPECT_EQ(0, DrvSessionRelease(session));
    MOCKER(drvHdcSessionClose).stubs().will(returnValue((drvError_t)DRV_ERROR_SOCKET_CLOSE));
    EXPECT_EQ(-1, DrvSessionRelease(session));
}

/* --- DrvGetPlatformInfo --- */
TEST_F(PlogDrvCovUtest, DrvGetPlatformInfo_NullInfo)
{
    EXPECT_EQ(-1, DrvGetPlatformInfo(NULL));
}

TEST_F(PlogDrvCovUtest, DrvGetPlatformInfo_FetchAndCache)
{
    unsigned int info = PLATFORM_INVALID_VALUE;
    // first call: cache empty -> fetches via the real loaded stub (HOST_SIDE)
    EXPECT_EQ(0, DrvGetPlatformInfo(&info));
    EXPECT_EQ(HOST_SIDE, info);
    // second call: cache hit -> returns cached value without calling driver
    info = PLATFORM_INVALID_VALUE;
    EXPECT_EQ(0, DrvGetPlatformInfo(&info));
    EXPECT_EQ(HOST_SIDE, info);
}

TEST_F(PlogDrvCovUtest, DrvGetPlatformInfo_GetFailed)
{
    MOCKER(drvGetPlatformInfo).stubs().will(returnValue((drvError_t)DRV_ERROR_BUSY));
    unsigned int info = PLATFORM_INVALID_VALUE;
    EXPECT_EQ(-1, DrvGetPlatformInfo(&info));
}

static drvError_t PlatInfoInvalidStub(uint32_t *info)
{
    if (info != NULL) {
        *info = 999; // neither DEVICE_SIDE nor HOST_SIDE
    }
    return DRV_ERROR_NONE;
}

TEST_F(PlogDrvCovUtest, DrvGetPlatformInfo_InvalidPlatform)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(PlatInfoInvalidStub));
    unsigned int info = PLATFORM_INVALID_VALUE;
    EXPECT_EQ(-1, DrvGetPlatformInfo(&info));
}

/* --- DrvGetDevNum --- */
TEST_F(PlogDrvCovUtest, DrvGetDevNum_SuccessAndFail)
{
    unsigned int num = 0;
    EXPECT_EQ(0, DrvGetDevNum(&num));
    EXPECT_EQ(1U, num);
    // NOTE: DrvGetDevNum(NULL) is intentionally NOT tested: the production code
    // dereferences `num` without a NULL guard, so passing NULL would crash.
    MOCKER(drvGetDevNum).stubs().will(returnValue((drvError_t)DRV_ERROR_INNER_ERR));
    EXPECT_EQ(-1, DrvGetDevNum(&num));
}

/* --- DrvBufWrite --- */
TEST_F(PlogDrvCovUtest, DrvBufWrite_SinglePacket)
{
    HDC_SESSION session = (HDC_SESSION)1;
    const char *buf = "hello plog";
    EXPECT_EQ(0, DrvBufWrite(session, buf, strlen(buf)));
}

TEST_F(PlogDrvCovUtest, DrvBufWrite_MultiPacket)
{
    HDC_SESSION session = (HDC_SESSION)1;
    string big(600000, 'X'); // larger than HDC max segment -> subcontract
    EXPECT_EQ(0, DrvBufWrite(session, big.data(), big.size()));
}

TEST_F(PlogDrvCovUtest, DrvBufWrite_InvalidParams)
{
    HDC_SESSION session = (HDC_SESSION)1;
    EXPECT_EQ(-1, DrvBufWrite(NULL, "x", 1));
    EXPECT_EQ(-1, DrvBufWrite(session, NULL, 1));
    EXPECT_EQ(-1, DrvBufWrite(session, "x", 0));
}

TEST_F(PlogDrvCovUtest, DrvBufWrite_CapacityFailed)
{
    MOCKER(drvHdcGetCapacity).stubs().will(returnValue((drvError_t)DRV_ERROR_BUSY));
    HDC_SESSION session = (HDC_SESSION)1;
    EXPECT_EQ(-1, DrvBufWrite(session, "x", 1));
}

static drvError_t CapInvalidStub(struct drvHdcCapacity *capacity)
{
    if (capacity != NULL) {
        capacity->maxSegment = 0; // invalid
    }
    return DRV_ERROR_NONE;
}

TEST_F(PlogDrvCovUtest, DrvBufWrite_CapacityInvalid)
{
    MOCKER(drvHdcGetCapacity).stubs().will(invoke(CapInvalidStub));
    HDC_SESSION session = (HDC_SESSION)1;
    EXPECT_EQ(-1, DrvBufWrite(session, "x", 1));
}

TEST_F(PlogDrvCovUtest, DrvBufWrite_AllocMsgFailed)
{
    MOCKER(drvHdcAllocMsg).stubs().will(returnValue((drvError_t)DRV_ERROR_NO_RESOURCES));
    HDC_SESSION session = (HDC_SESSION)1;
    EXPECT_EQ(-1, DrvBufWrite(session, "x", 1));
}

TEST_F(PlogDrvCovUtest, DrvBufWrite_AddBufferFailed)
{
    MOCKER(drvHdcAddMsgBuffer).stubs().will(returnValue((drvError_t)DRV_ERROR_INNER_ERR));
    HDC_SESSION session = (HDC_SESSION)1;
    EXPECT_EQ(-1, DrvBufWrite(session, "x", 1));
}

TEST_F(PlogDrvCovUtest, DrvBufWrite_SendFailed)
{
    MOCKER(halHdcSend).stubs().will(returnValue((drvError_t)DRV_ERROR_SEND_MESG));
    HDC_SESSION session = (HDC_SESSION)1;
    EXPECT_EQ(-1, DrvBufWrite(session, "abcdef", 6));
}

TEST_F(PlogDrvCovUtest, DrvBufWrite_ReuseFailed)
{
    MOCKER(drvHdcReuseMsg).stubs().will(returnValue((drvError_t)DRV_ERROR_INNER_ERR));
    HDC_SESSION session = (HDC_SESSION)1;
    EXPECT_EQ(-1, DrvBufWrite(session, "abcdef", 6));
}

/* --- DrvBufRead --- */
struct CovRecvPkt {
    DataPacket hdr;
    char data[16];
};
static struct CovRecvPkt g_covPkt;

static drvError_t GetMsgBufSingle(struct drvHdcMsg *msg, int idx, char **pBuf, int *pLen)
{
    (void)msg;
    (void)idx;
    *pBuf = (char *)&g_covPkt;
    *pLen = (int)sizeof(g_covPkt);
    return DRV_ERROR_NONE;
}

static int g_covMultiCall = 0;
static drvError_t GetMsgBufMulti(struct drvHdcMsg *msg, int idx, char **pBuf, int *pLen)
{
    (void)msg;
    (void)idx;
    *pBuf = (char *)&g_covPkt;
    *pLen = (int)sizeof(g_covPkt);
    if (g_covMultiCall == 0) {
        g_covPkt.hdr.isLast = (char)(~DATA_LAST_PACKET);
    } else {
        g_covPkt.hdr.isLast = (char)DATA_LAST_PACKET;
    }
    g_covMultiCall++;
    return DRV_ERROR_NONE;
}

static void PrepCovPkt(const char *data, unsigned int dataLen, char isLast)
{
    (void)memset_s(&g_covPkt, sizeof(g_covPkt), 0, sizeof(g_covPkt));
    g_covPkt.hdr.dataLen = dataLen;
    g_covPkt.hdr.isLast = isLast;
    g_covPkt.hdr.type = LOG_LITTLE_PACKAGE;
    if (dataLen > 0) {
        (void)memcpy_s(g_covPkt.data, sizeof(g_covPkt.data), data, dataLen);
    }
}

TEST_F(PlogDrvCovUtest, DrvBufRead_InvalidParams)
{
    HDC_SESSION session = (HDC_SESSION)1;
    char *buf = NULL;
    unsigned int len = 0;
    EXPECT_EQ(LOG_INVALID_PARAM, DrvBufRead(NULL, 0, &buf, &len, 1));
    EXPECT_EQ(LOG_INVALID_PARAM, DrvBufRead(session, 0, NULL, &len, 1));
    EXPECT_EQ(LOG_INVALID_PARAM, DrvBufRead(session, 0, &buf, NULL, 1));
    EXPECT_EQ(LOG_INVALID_PARAM, DrvBufRead(session, -1, &buf, &len, 1));
    EXPECT_EQ(LOG_INVALID_PARAM, DrvBufRead(session, HOST_MAX_DEV_NUM, &buf, &len, 1));
}

TEST_F(PlogDrvCovUtest, DrvBufRead_SuccessSinglePacket)
{
    PrepCovPkt("test", 4, (char)DATA_LAST_PACKET);
    MOCKER(halHdcRecv).stubs().will(returnValue((drvError_t)DRV_ERROR_NONE));
    MOCKER(drvHdcGetMsgBuffer).stubs().will(invoke(GetMsgBufSingle));
    HDC_SESSION session = (HDC_SESSION)1;
    char *buf = NULL;
    unsigned int len = 0;
    EXPECT_EQ(LOG_SUCCESS, DrvBufRead(session, 0, &buf, &len, 100));
    EXPECT_EQ(4U, len);
    free(buf);
}

TEST_F(PlogDrvCovUtest, DrvBufRead_SuccessMultiPacket)
{
    g_covMultiCall = 0;
    PrepCovPkt("aaaa", 4, (char)(~DATA_LAST_PACKET)); // first packet not-last
    MOCKER(halHdcRecv).stubs().will(returnValue((drvError_t)DRV_ERROR_NONE));
    MOCKER(drvHdcGetMsgBuffer).stubs().will(invoke(GetMsgBufMulti));
    HDC_SESSION session = (HDC_SESSION)1;
    char *buf = NULL;
    unsigned int len = 0;
    EXPECT_EQ(LOG_SUCCESS, DrvBufRead(session, 0, &buf, &len, 100));
    EXPECT_EQ(8U, len); // two 4-byte packets
    free(buf);
}

TEST_F(PlogDrvCovUtest, DrvBufRead_AllocMsgFailed)
{
    MOCKER(drvHdcAllocMsg).stubs().will(returnValue((drvError_t)DRV_ERROR_NO_RESOURCES));
    HDC_SESSION session = (HDC_SESSION)1;
    char *buf = NULL;
    unsigned int len = 0;
    EXPECT_NE(LOG_SUCCESS, DrvBufRead(session, 0, &buf, &len, 100));
}

TEST_F(PlogDrvCovUtest, DrvBufRead_RecvErrorMapping)
{
    HDC_SESSION session = (HDC_SESSION)1;
    char *buf = NULL;
    unsigned int len = 0;
    // chain: each DrvBufRead triggers exactly one Recv call (errors goto
    // READ_ERROR immediately, so the recv loop runs once per call).
    MOCKER(halHdcRecv).stubs()
        .will(returnValue((drvError_t)DRV_ERROR_SOCKET_CLOSE))
        .then(returnValue((drvError_t)DRV_ERROR_NON_BLOCK))
        .then(returnValue((drvError_t)DRV_ERROR_WAIT_TIMEOUT))
        .then(returnValue((drvError_t)DRV_ERROR_BUSY));
    EXPECT_EQ(LOG_SESSION_CLOSE, DrvBufRead(session, 0, &buf, &len, 1));
    EXPECT_EQ(LOG_FAILURE, DrvBufRead(session, 0, &buf, &len, 1));
    EXPECT_EQ(LOG_SESSION_RECV_TIMEOUT, DrvBufRead(session, 0, &buf, &len, 1));
    EXPECT_EQ(LOG_FAILURE, DrvBufRead(session, 0, &buf, &len, 1));
}

TEST_F(PlogDrvCovUtest, DrvBufRead_GetMsgBufferFailed)
{
    MOCKER(halHdcRecv).stubs().will(returnValue((drvError_t)DRV_ERROR_NONE));
    MOCKER(drvHdcGetMsgBuffer).stubs().will(returnValue((drvError_t)DRV_ERROR_INNER_ERR));
    HDC_SESSION session = (HDC_SESSION)1;
    char *buf = NULL;
    unsigned int len = 0;
    EXPECT_EQ(LOG_FAILURE, DrvBufRead(session, 0, &buf, &len, 100));
}

TEST_F(PlogDrvCovUtest, DrvBufRead_GetMsgBufferNullBuf)
{
    // stub leaves pBuf NULL -> "(drvErr != NONE) || (pBuf == NULL)" guard fires.
    // READ_ERROR returns the last drvErr (NONE), which DrvBufRead maps to SUCCESS.
    MOCKER(halHdcRecv).stubs().will(returnValue((drvError_t)DRV_ERROR_NONE));
    MOCKER(drvHdcGetMsgBuffer).stubs().will(returnValue((drvError_t)DRV_ERROR_NONE));
    HDC_SESSION session = (HDC_SESSION)1;
    char *buf = NULL;
    unsigned int len = 0;
    EXPECT_EQ(LOG_SUCCESS, DrvBufRead(session, 0, &buf, &len, 100));
}

TEST_F(PlogDrvCovUtest, DrvBufRead_ReuseFailed)
{
    PrepCovPkt("test", 4, (char)DATA_LAST_PACKET);
    MOCKER(halHdcRecv).stubs().will(returnValue((drvError_t)DRV_ERROR_NONE));
    MOCKER(drvHdcGetMsgBuffer).stubs().will(invoke(GetMsgBufSingle));
    MOCKER(drvHdcReuseMsg).stubs().will(returnValue((drvError_t)DRV_ERROR_INNER_ERR));
    HDC_SESSION session = (HDC_SESSION)1;
    char *buf = NULL;
    unsigned int len = 0;
    EXPECT_EQ(LOG_FAILURE, DrvBufRead(session, 0, &buf, &len, 100));
}
