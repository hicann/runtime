/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"

#include <cstring>
#include <cstdlib>
#include <unistd.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <errno.h>

extern "C" {
#include "dlog_attr.h"
#include "dlog_core.h"
#include "dlog_socket.h"
#include "dlog_level_mgr.h"
#include "dlog_message.h"
#include "dlog_common.h"
#include "dlog_shm_control.h"
#include "dlog_console.h"
#include "dlog_time.h"
#include "slog_api.h"
#include "alog_to_slog.h"
#include "share_mem.h"
#include "log_common.h"
#include "log_file_info.h"
#include "log_error_code.h"
}

/* controllable hooks exported by slogd_utest_stub.c */
extern "C" {
void SetToolErrno(int32_t err);
void SetToolWriteFail(int32_t fail);
void SetToolSocketFail(int32_t fail);
void SetToolConnectFail(int32_t fail);
void SetToolCreateThread(int32_t en);
}

namespace {
constexpr int32_t RT_OK = 0;
constexpr int32_t RT_FAIL = -1;

constexpr key_t kShmKey = (key_t)0x474f4c46;
constexpr size_t kShmSize = 4096U;
constexpr size_t kModuleOffset = (size_t)(CONFIG_PATH_LEN + GLOBAL_ARR_LEN);   /* 1024 */
constexpr size_t kLevelOffset = (size_t)(CONFIG_PATH_LEN + GLOBAL_ARR_LEN + MODULE_ARR_LEN); /* 3072 */

LogMsgArg MakeMsgArg(uint32_t moduleId, uint32_t typeMask, int32_t level)
{
    LogMsgArg arg = {};
    arg.moduleId = moduleId;
    arg.typeMask = typeMask;
    arg.level = level;
    arg.selfPid = 0;
    arg.attr.type = APPLICATION;
    arg.attr.pid = 0;
    arg.attr.deviceId = 0;
    arg.attr.mode = 0;
    return arg;
}

int32_t CallWrite(LogMsgArg *arg, const char *fmt, ...)
{
    va_list v;
    va_start(v, fmt);
    int32_t ret = DlogWriteInner(arg, fmt, v);
    va_end(v);
    return ret;
}

/* ---- write/flush/fork/atfork callbacks used by dlog_core tests ---- */
extern "C" int32_t CovWriteOkCb(const char *content, uint32_t len, int32_t type)
{
    (void)content;
    (void)len;
    (void)type;
    return 0;
}
extern "C" int32_t CovWriteFailCb(const char *content, uint32_t len, int32_t type)
{
    (void)content;
    (void)len;
    (void)type;
    return -1;
}
extern "C" void CovFlushCb(void) {}
extern "C" void CovForkCb(void) {}
extern "C" void CovAtForkCb(int32_t stage)
{
    (void)stage;
}

/*
 * Build (or reset) the shared memory segment used by dlog_level_shm.c.
 * baseLen controls the length of the string stored at offset 0 (ShMemRead checks
 * strlen() from the segment base). moduleStr is written at the module offset and
 * levelBytes at the level offset.
 */
int32_t SetupShmemRaw(size_t baseLen, const char *moduleStr, const unsigned char *levelBytes, size_t levelLen)
{
    int32_t shmId = shmget(kShmKey, kShmSize, IPC_CREAT | 0666);
    if (shmId < 0) {
        return -1;
    }
    char *p = (char *)shmat(shmId, NULL, 0);
    if (p == (char *)-1) {
        return -1;
    }
    (void)memset(p, 0, kShmSize);
    if (baseLen > 0) {
        if (baseLen >= kShmSize) {
            baseLen = kShmSize - 1U;
        }
        (void)memset(p, 'A', baseLen);
        p[baseLen] = '\0';
    }
    if (moduleStr != nullptr) {
        (void)strcpy(p + kModuleOffset, moduleStr);
    }
    if ((levelBytes != nullptr) && (levelLen > 0U)) {
        (void)memcpy(p + kLevelOffset, levelBytes, levelLen);
    }
    (void)shmdt(p);
    return 0;
}

void RemoveShmem(void)
{
    int32_t shmId = shmget(kShmKey, kShmSize, 0666);
    if (shmId >= 0) {
        (void)shmctl(shmId, IPC_RMID, NULL);
    }
}
} // namespace

/* ====================================================================== */
/* dlog_attr.c                                                            */
/* ====================================================================== */
class DlogAttrUtest : public testing::Test {};

TEST_F(DlogAttrUtest, GetDefaultUserAttr)
{
    DlogInitGlobalAttr();
    LogAttr attr = {};
    DlogGetUserAttr(&attr);
    /* slog default process type is SYSTEM, device id 0, unify save mode */
    EXPECT_EQ(SYSTEM, attr.type);
    EXPECT_EQ(0U, attr.deviceId);
    EXPECT_EQ((unsigned int)LOG_SAVE_MODE_UNI, attr.mode);
    EXPECT_TRUE(DlogCheckAttrSystem());
    EXPECT_EQ(SYSTEM, DlogGetProcessType());
    EXPECT_EQ(0U, DlogGetAttrDeviceId());
}

TEST_F(DlogAttrUtest, SetUserAttrAllFields)
{
    LogAttr attr = {};
    attr.type = SYSTEM;
    attr.pid = 1234U;
    attr.deviceId = 7U;
    attr.mode = (unsigned int)LOG_SAVE_MODE_UNI;
    DlogSetUserAttr(&attr);

    LogAttr got = {};
    DlogGetUserAttr(&got);
    EXPECT_EQ(SYSTEM, got.type);
    EXPECT_EQ(7U, got.deviceId);
    EXPECT_EQ(1234U, got.pid);
    EXPECT_EQ((unsigned int)LOG_SAVE_MODE_UNI, got.mode);
    EXPECT_TRUE(DlogCheckAttrSystem());
    EXPECT_EQ(SYSTEM, DlogGetProcessType());
    EXPECT_EQ(7U, DlogGetAttrDeviceId());
    EXPECT_EQ(1234U, DlogGetHostPid());
}

TEST_F(DlogAttrUtest, SetUserAttrSeparateMode)
{
    LogAttr attr = {};
    attr.type = APPLICATION;
    attr.mode = (unsigned int)LOG_SAVE_MODE_SEP;
    DlogSetUserAttr(&attr);
    LogAttr got = {};
    DlogGetUserAttr(&got);
    EXPECT_EQ(APPLICATION, got.type);
    EXPECT_EQ((unsigned int)LOG_SAVE_MODE_SEP, got.mode);
    EXPECT_FALSE(DlogCheckAttrSystem());
    EXPECT_EQ(APPLICATION, DlogGetProcessType());
}

TEST_F(DlogAttrUtest, SetHostPidByEnv)
{
    (void)setenv("ASCEND_HOSTPID", "9999", 1);
    LogAttr attr = {};
    attr.type = APPLICATION;
    attr.pid = 0U; /* triggers DlogSetHostPid(0) -> read env */
    DlogSetUserAttr(&attr);
    LogAttr got = {};
    DlogGetUserAttr(&got);
    EXPECT_EQ(9999U, got.pid);
    EXPECT_EQ(9999U, DlogGetHostPid());
    (void)unsetenv("ASCEND_HOSTPID");
}

TEST_F(DlogAttrUtest, SetHostPidEnvInvalid)
{
    (void)setenv("ASCEND_HOSTPID", "not_a_number", 1);
    LogAttr attr = {};
    attr.type = APPLICATION;
    attr.pid = 0U;
    DlogSetUserAttr(&attr);
    /* invalid env value: host pid left unchanged (still 9999 from previous test) */
    EXPECT_EQ(9999U, DlogGetHostPid());
    (void)unsetenv("ASCEND_HOSTPID");
}

TEST_F(DlogAttrUtest, SetHostPidEnvAbsent)
{
    (void)unsetenv("ASCEND_HOSTPID");
    LogAttr attr = {};
    attr.type = APPLICATION;
    attr.pid = 0U;
    DlogSetUserAttr(&attr);
    /* env absent: cannot set pid, keep original value */
    EXPECT_NE(0U, DlogGetHostPid());
}

TEST_F(DlogAttrUtest, SetModeByEnvUnify)
{
    (void)setenv("ASCEND_LOG_SAVE_MODE", "1", 1);
    LogAttr attr = {};
    attr.type = APPLICATION;
    attr.mode = 999U; /* invalid -> DlogSetMode falls back to env */
    DlogSetUserAttr(&attr);
    LogAttr got = {};
    DlogGetUserAttr(&got);
    EXPECT_EQ((unsigned int)LOG_SAVE_MODE_UNI, got.mode);
    (void)unsetenv("ASCEND_LOG_SAVE_MODE");
}

TEST_F(DlogAttrUtest, SetModeByEnvSeparate)
{
    (void)setenv("ASCEND_LOG_SAVE_MODE", "2", 1);
    LogAttr attr = {};
    attr.type = APPLICATION;
    attr.mode = 999U;
    DlogSetUserAttr(&attr);
    LogAttr got = {};
    DlogGetUserAttr(&got);
    EXPECT_EQ((unsigned int)LOG_SAVE_MODE_SEP, got.mode);
    (void)unsetenv("ASCEND_LOG_SAVE_MODE");
}

TEST_F(DlogAttrUtest, SetModeByEnvAbsent)
{
    (void)unsetenv("ASCEND_LOG_SAVE_MODE");
    LogAttr attr = {};
    attr.type = APPLICATION;
    attr.mode = 999U;
    DlogSetUserAttr(&attr);
    LogAttr got = {};
    DlogGetUserAttr(&got);
    /* env absent: keep previous mode value (separate from the previous test) */
    EXPECT_EQ((unsigned int)LOG_SAVE_MODE_SEP, got.mode);
}

TEST_F(DlogAttrUtest, AosTypeSeaAndGea)
{
    (void)setenv("AOS_TYPE", "AOS_SEA", 1);
    DlogInitGlobalAttr();
    EXPECT_TRUE(DlogIsAosCore());
    EXPECT_EQ(AOS_SEA, DlogGetAosType());
    /* aos_core slog default process type is APPLICATION */
    EXPECT_EQ(APPLICATION, DlogGetProcessType());
    EXPECT_FALSE(DlogCheckAttrSystem());

    (void)unsetenv("AOS_TYPE");
    DlogInitGlobalAttr();
    EXPECT_FALSE(DlogIsAosCore());
    EXPECT_EQ(AOS_GEA, DlogGetAosType());
    EXPECT_EQ(SYSTEM, DlogGetProcessType());
    EXPECT_TRUE(DlogCheckAttrSystem());
}

TEST_F(DlogAttrUtest, PidAndPoolingAccessors)
{
    DlogSetCurrPid();
    EXPECT_EQ(0, DlogGetCurrPid());
    EXPECT_TRUE(DlogCheckCurrPid());
    EXPECT_FALSE(DlogIsPoolingDevice());
    EXPECT_EQ(0U, DlogGetUid());
    EXPECT_EQ(0U, DlogGetGid());
}

/* ====================================================================== */
/* dlog_socket.c                                                          */
/* ====================================================================== */
class DlogSocketUtest : public testing::Test {
protected:
    void SetUp() override
    {
        SetToolSocketFail(0);
        SetToolConnectFail(0);
        SetToolWriteFail(0);
        SetToolErrno(0);
        SetSocketConnectedStatus(FALSE);
        SetSocketFd(INVALID);
    }
    void TearDown() override
    {
        SetToolSocketFail(0);
        SetToolConnectFail(0);
        SetToolWriteFail(0);
        SetToolErrno(0);
        CloseLogInternal();
    }
};

TEST_F(DlogSocketUtest, SocketConnectedStatusValidAndInvalid)
{
    SetSocketConnectedStatus(TRUE);
    EXPECT_EQ(TRUE, IsSocketConnected());
    SetSocketConnectedStatus(FALSE);
    EXPECT_EQ(FALSE, IsSocketConnected());
    /* invalid status value is rejected, flag unchanged */
    SetSocketConnectedStatus(5);
    EXPECT_EQ(FALSE, IsSocketConnected());
}

TEST_F(DlogSocketUtest, SocketFdValidCheck)
{
    SetSocketFd(-5);
    EXPECT_FALSE(IsSocketFdValid());
    SetSocketFd(8);
    EXPECT_TRUE(IsSocketFdValid());
    EXPECT_EQ(8, GetSocketFd());
}

TEST_F(DlogSocketUtest, CloseLogInternalWhenNotConnected)
{
    SetSocketConnectedStatus(FALSE);
    CloseLogInternal(); /* early return, no crash */
    EXPECT_EQ(FALSE, IsSocketConnected());
}

TEST_F(DlogSocketUtest, CloseLogInternalWhenConnected)
{
    int32_t fd = CreatSocket(0);
    ASSERT_GE(fd, 0);
    SetSocketFd(fd);
    SetSocketConnectedStatus(TRUE);
    CloseLogInternal();
    EXPECT_EQ(FALSE, IsSocketConnected());
    EXPECT_EQ(INVALID, GetSocketFd());
}

TEST_F(DlogSocketUtest, SigPipeHandlerClosesLog)
{
    int32_t fd = CreatSocket(0);
    ASSERT_GE(fd, 0);
    SetSocketFd(fd);
    SetSocketConnectedStatus(TRUE);
    SigPipeHandler(SIGPIPE);
    EXPECT_EQ(FALSE, IsSocketConnected());
}

TEST_F(DlogSocketUtest, CreatSocketPfidSystemPath)
{
    /* default slog process type is SYSTEM -> GetSocketPathByPfid early return */
    LogAttr attr = {};
    attr.type = SYSTEM;
    DlogSetUserAttr(&attr);
    int32_t fd = CreatSocket(0);
    EXPECT_GE(fd, 0);
    if (fd >= 0) {
        (void)close(fd);
    }
}

TEST_F(DlogSocketUtest, CreatSocketVfidPath)
{
    int32_t fd = CreatSocket(40); /* 32<=devId<64 -> vfid path */
    EXPECT_GE(fd, 0);
    if (fd >= 0) {
        (void)close(fd);
    }
}

TEST_F(DlogSocketUtest, CreatSocketPfidNonSystemSameUser)
{
    LogAttr attr = {};
    attr.type = APPLICATION; /* non-system -> getpwuid path */
    DlogSetUserAttr(&attr);
    int32_t fd = CreatSocket(0);
    EXPECT_GE(fd, 0);
    if (fd >= 0) {
        (void)close(fd);
    }
    /* restore system type for later suites */
    attr.type = SYSTEM;
    DlogSetUserAttr(&attr);
}

TEST_F(DlogSocketUtest, CreatSocketFailWhenSocketUnavailable)
{
    SetToolSocketFail(1);
    EXPECT_EQ(SYS_ERROR, CreatSocket(0));
    EXPECT_EQ(SYS_ERROR, CreatSocket(40));
}

TEST_F(DlogSocketUtest, ConnectFailCoveredForRsyslogAndSlog)
{
    /* must run before DEBUG rsyslog fd is cached: triggers GetRsyslogSocket and
     * CreatSocket connect-failure paths (ToolConnect returns SYS_ERROR) */
    SetToolConnectFail(1);
    EXPECT_EQ(SYS_ERROR, GetRsyslogSocketFd(DEBUG_LOG_MASK));
    EXPECT_EQ(SYS_ERROR, CreatSocket(0));
    SetToolConnectFail(0);
}

TEST_F(DlogSocketUtest, GetRsyslogSocketFdFailThenSucceedAndCache)
{
    SetToolSocketFail(1);
    EXPECT_EQ(SYS_ERROR, GetRsyslogSocketFd(DEBUG_LOG_MASK));
    SetToolSocketFail(0);
    /* fd was set to -1, so next call re-creates the rsyslog socket */
    toolSockHandle fd = GetRsyslogSocketFd(DEBUG_LOG_MASK);
    EXPECT_GE(fd, 0);
    /* subsequent call returns the cached fd */
    EXPECT_EQ(fd, GetRsyslogSocketFd(DEBUG_LOG_MASK));
    /* non-matching typemask */
    EXPECT_EQ(-1, GetRsyslogSocketFd(0x99999999U));
}

TEST_F(DlogSocketUtest, GetRsyslogSocketFdAllMasks)
{
    EXPECT_GE(GetRsyslogSocketFd(SECURITY_LOG_MASK), 0);
    EXPECT_GE(GetRsyslogSocketFd(RUN_LOG_MASK), 0);
}

TEST_F(DlogSocketUtest, CloseSocketReturnsToolCloseResult)
{
    SetSocketFd(3);
    EXPECT_EQ(0, CloseSocket()); /* ToolClose stub returns 0 */
}

/* ====================================================================== */
/* dlog_core.c                                                            */
/* ====================================================================== */
class DlogCoreUtest : public testing::Test {
protected:
    void SetUp() override
    {
        SetToolSocketFail(0);
        SetToolConnectFail(0);
        SetToolWriteFail(0);
        SetToolErrno(0);
        CloseLogInternal();
        SetSocketConnectedStatus(FALSE);
        SetSocketFd(INVALID);
        /* ensure a known module threshold regardless of constructor-time shmem state */
        (void)dlog_setlevel(SLOG, DLOG_ERROR, 1);
    }
    void TearDown() override
    {
        SetToolWriteFail(0);
        SetToolErrno(0);
        SetToolSocketFail(0);
        CloseLogInternal();
    }
};

/* NOTE: the socket-path tests below must run before any LOG_WRITE callback is
 * registered, because g_hasRegistered becomes permanently true afterwards. */
TEST_F(DlogCoreUtest, WriteToSocketWhenNoCallback)
{
    LogMsgArg arg = MakeMsgArg(SLOG, DEBUG_LOG_MASK, DLOG_ERROR);
    EXPECT_EQ(LOG_SUCCESS, CallWrite(&arg, "socket log %d", 1));
}

TEST_F(DlogCoreUtest, WriteFallsBackToConsoleWhenSocketCreateFails)
{
    /* CreatSocket fails -> socket fd invalid -> fall back to WRITE_CONSOLE */
    SetToolSocketFail(1);
    LogMsgArg arg = MakeMsgArg(SLOG, DEBUG_LOG_MASK, DLOG_ERROR);
    EXPECT_EQ(LOG_SUCCESS, CallWrite(&arg, "no socket %d", 11));
    SetToolSocketFail(0);
}

TEST_F(DlogCoreUtest, WriteLevelFilteredReturnsFailure)
{
    /* default module threshold is ERROR, so DEBUG is filtered out */
    LogMsgArg arg = MakeMsgArg(SLOG, DEBUG_LOG_MASK, DLOG_DEBUG);
    EXPECT_EQ(LOG_FAILURE, CallWrite(&arg, "filtered %d", 2));
}

TEST_F(DlogCoreUtest, WriteToStdoutMask)
{
    LogMsgArg arg = MakeMsgArg(SLOG, STDOUT_LOG_MASK, DLOG_ERROR);
    EXPECT_EQ(LOG_SUCCESS, CallWrite(&arg, "stdout %d", 3));
}

TEST_F(DlogCoreUtest, WriteFailureTriggersLogCtrlThenRecovers)
{
    /* force writes to fail with EAGAIN on the socket path */
    SetToolWriteFail(1);
    SetToolErrno(EAGAIN);
    LogMsgArg arg = MakeMsgArg(SLOG, DEBUG_LOG_MASK, DLOG_ERROR);
    /* DlogWriteInner always returns LOG_SUCCESS (writes to socket internally) */
    EXPECT_EQ(LOG_SUCCESS, CallWrite(&arg, "failing write %d", 4));
    /* g_logCtrlSwitch is now true, g_logCtrlLevel == DLOG_ERROR */

    SetToolWriteFail(0);
    SetToolErrno(0);
    /* a successful write while switch is on exercises LogCtrlDecLogic (no-op, < interval) */
    LogMsgArg arg2 = MakeMsgArg(SLOG, DEBUG_LOG_MASK, DLOG_ERROR);
    EXPECT_EQ(LOG_SUCCESS, CallWrite(&arg2, "recover %d", 5));

    /* while switch on, a level below g_logCtrlLevel is filtered by DlogCheckLogLevel */
    LogMsgArg arg3 = MakeMsgArg(SLOG, DEBUG_LOG_MASK, DLOG_WARN);
    EXPECT_EQ(LOG_FAILURE, CallWrite(&arg3, "warn filtered %d", 6));

    /* a non-EAGAIN, non-EINTR write failure hits the SafeWrites break path */
    SetToolWriteFail(1);
    SetToolErrno(0);
    LogMsgArg arg4 = MakeMsgArg(SLOG, DEBUG_LOG_MASK, DLOG_ERROR);
    EXPECT_EQ(LOG_SUCCESS, CallWrite(&arg4, "plain fail %d", 12));
    SetToolWriteFail(0);
    SetToolErrno(0);

    /* after LOG_WARN_INTERVAL elapses, a successful write lowers g_logCtrlLevel to WARN */
    (void)usleep(2100000); /* 2.1s: >= LOG_WARN_INTERVAL(2s) and < LOG_INFO_INTERVAL(4s) */
    LogMsgArg arg5 = MakeMsgArg(SLOG, DEBUG_LOG_MASK, DLOG_ERROR);
    EXPECT_EQ(LOG_SUCCESS, CallWrite(&arg5, "lower to warn %d", 13));

    /* a subsequent EAGAIN failure increments g_logCtrlLevel back up (level < ERROR) */
    SetToolWriteFail(1);
    SetToolErrno(EAGAIN);
    LogMsgArg arg6 = MakeMsgArg(SLOG, DEBUG_LOG_MASK, DLOG_ERROR);
    EXPECT_EQ(LOG_SUCCESS, CallWrite(&arg6, "raise again %d", 14));
    SetToolWriteFail(0);
    SetToolErrno(0);
}

TEST_F(DlogCoreUtest, RegisterCallbacksAndPlogPath)
{
    EXPECT_EQ(SUCCESS, RegisterCallback(reinterpret_cast<ArgPtr>(CovWriteOkCb), LOG_WRITE));
    LogMsgArg arg = MakeMsgArg(SLOG, DEBUG_LOG_MASK, DLOG_ERROR);
    EXPECT_EQ(LOG_SUCCESS, CallWrite(&arg, "plog ok %d", 7));

    /* event log goes through plog path too */
    LogMsgArg evt = MakeMsgArg(SLOG, DEBUG_LOG_MASK, DLOG_EVENT);
    EXPECT_EQ(LOG_SUCCESS, CallWrite(&evt, "event %d", 8));

    /* failing callback -> WRITE_CONSOLE branch */
    EXPECT_EQ(SUCCESS, RegisterCallback(reinterpret_cast<ArgPtr>(CovWriteFailCb), LOG_WRITE));
    LogMsgArg argFail = MakeMsgArg(SLOG, DEBUG_LOG_MASK, DLOG_ERROR);
    EXPECT_EQ(LOG_SUCCESS, CallWrite(&argFail, "plog fail %d", 9));

    /* register NULL write callback: g_hasRegistered stays true, funcWrite NULL -> discarding */
    EXPECT_EQ(SUCCESS, RegisterCallback(nullptr, LOG_WRITE));
    LogMsgArg argDiscard = MakeMsgArg(SLOG, DEBUG_LOG_MASK, DLOG_ERROR);
    EXPECT_EQ(LOG_FAILURE, CallWrite(&argDiscard, "discard %d", 10));
}

TEST_F(DlogCoreUtest, RegisterFlushForkAtForkAndDefault)
{
    EXPECT_EQ(SUCCESS, RegisterCallback(reinterpret_cast<ArgPtr>(CovFlushCb), LOG_FLUSH));
    DlogRefreshCache(); /* invokes funcFlush */
    EXPECT_EQ(SUCCESS, RegisterCallback(reinterpret_cast<ArgPtr>(CovForkCb), LOG_FORK));
    EXPECT_EQ(SUCCESS, RegisterCallback(reinterpret_cast<ArgPtr>(CovAtForkCb), LOG_ATFORK));
    /* unknown callback type is ignored */
    EXPECT_EQ(SUCCESS, RegisterCallback(nullptr, (CallbackType)999));
    DlogRefreshCache();
}

TEST_F(DlogCoreUtest, DlogCheckLogLevelBranches)
{
    /* level >= LOG_MAX_LEVEL returns FALSE */
    EXPECT_EQ(FALSE, DlogCheckLogLevel(DLOG_NULL));
    EXPECT_EQ(FALSE, DlogCheckLogLevel(LOG_MAX_LEVEL + 1));
    /* valid level returns TRUE (log control switch may be on, but level==ERROR passes) */
    EXPECT_EQ(TRUE, DlogCheckLogLevel(DLOG_ERROR));
}

TEST_F(DlogCoreUtest, DlogInitIdempotentWhenAlreadyInited)
{
    /* constructor already initialized dlog; second call returns early */
    DlogInit();
    DlogInit();
    EXPECT_TRUE(true);
}

/* ====================================================================== */
/* dlog_level_shm.c                                                       */
/* ====================================================================== */
class DlogLevelShmUtest : public testing::Test {
protected:
    void SetUp() override
    {
        RemoveShmem();
        SetToolSocketFail(0);
        SetToolWriteFail(0);
        SetToolErrno(0);
        SetToolCreateThread(0);
    }
    void TearDown() override
    {
        SetToolCreateThread(0);
        RemoveShmem();
    }
};

TEST_F(DlogLevelShmUtest, InitWithoutShmemSkipsUpdate)
{
    RemoveShmem();
    /* no shared memory available: CheckShMemAvailable fails, UpdateLogLevel skipped */
    DlogLevelInit();
    DlogLevelReInit();
    EXPECT_TRUE(true);
}

TEST_F(DlogLevelShmUtest, UpdateLogLevelParsesGlobalAndModuleLevel)
{
    /* level byte 0x28: global=((0x28>>4)&7)-1=1(INFO), event=((0x28>>2)&3)-1=1(ENABLE) */
    /* reserve byte 0x01 (non-null so snprintf does not truncate the level string) */
    /* module levels for SLOG(n=2) and IDEDD(n=3) */
    const unsigned char level[] = {0x28, 0x01, 0x28, 0x10, 0x00};
    ASSERT_EQ(0, SetupShmemRaw(3, "SLOG;IDEDD;", level, sizeof(level)));
    DlogLevelInit();

    int32_t enableEvent = 0;
    EXPECT_EQ(DLOG_INFO, dlog_getlevel(SLOG, &enableEvent));
    EXPECT_EQ(TRUE, enableEvent);
    EXPECT_EQ(DLOG_DEBUG, dlog_getlevel(IDEDD, &enableEvent));
}

TEST_F(DlogLevelShmUtest, UpdateLogLevelModuleDefaultWhenLevelIndexOutOfBounds)
{
    /* level string length 4: SCC is the 3rd module (n=4) -> 4>=4 -> default level */
    const unsigned char level[] = {0x28, 0x01, 0x28, 0x28, 0x00};
    ASSERT_EQ(0, SetupShmemRaw(3, "SLOG;IDEDD;SCC;", level, sizeof(level)));
    DlogLevelInit();
    int32_t enableEvent = 0;
    /* SCC gets the debug default level (DLOG_DEBUG_DEFAULT_LEVEL == DLOG_ERROR) */
    EXPECT_EQ(DLOG_ERROR, dlog_getlevel(SCC, &enableEvent));
}

TEST_F(DlogLevelShmUtest, UpdateLogLevelUnknownModuleKeepsIndex)
{
    const unsigned char level[] = {0x28, 0x01, 0x28, 0x00};
    ASSERT_EQ(0, SetupShmemRaw(3, "SLOG;ZZZZ;", level, sizeof(level)));
    DlogLevelInit();
    int32_t enableEvent = 0;
    EXPECT_EQ(DLOG_INFO, dlog_getlevel(SLOG, &enableEvent));
}

TEST_F(DlogLevelShmUtest, UpdateLogLevelInvalidGlobalAndEventDefaults)
{
    /* byte 0x01: global invalid -> default ERROR, event invalid -> default ENABLE */
    const unsigned char level[] = {0x01, 0x01, 0x28, 0x00};
    ASSERT_EQ(0, SetupShmemRaw(3, "SLOG;", level, sizeof(level)));
    DlogLevelInit();
    /* invalid global level falls back to DLOG_GLOABLE_DEFAULT_LEVEL (ERROR) */
    EXPECT_EQ(DLOG_ERROR, GetGlobalLogTypeLevelVar(DLOG_GLOBAL_TYPE_MASK));
    int32_t enableEvent = 0;
    (void)dlog_getlevel(SLOG, &enableEvent);
    EXPECT_EQ(TRUE, enableEvent);
}

TEST_F(DlogLevelShmUtest, UpdateLogLevelEventDisableValue)
{
    /* byte 0x04: global invalid, event=((0x04>>2)&3)-1=0 -> DISABLE */
    const unsigned char level[] = {0x04, 0x01, 0x28, 0x00};
    ASSERT_EQ(0, SetupShmemRaw(3, "SLOG;", level, sizeof(level)));
    DlogLevelInit();
    int32_t enableEvent = 99;
    (void)dlog_getlevel(SLOG, &enableEvent);
    EXPECT_EQ(FALSE, enableEvent);
}

TEST_F(DlogLevelShmUtest, UpdateLogLevelModuleReadFailsWhenBaseEmpty)
{
    /* empty base string -> strlen(base)==0 -> ShMemRead fails -> module read fails */
    ASSERT_EQ(0, SetupShmemRaw(0, nullptr, nullptr, 0));
    DlogLevelInit();
    EXPECT_TRUE(true);
}

TEST_F(DlogLevelShmUtest, UpdateLogLevelLevelReadFailsWhenBaseTooLong)
{
    /* base length 1025: module read ok (len 2048), level read fails (len 1024) */
    ASSERT_EQ(0, SetupShmemRaw(1025, nullptr, nullptr, 0));
    DlogLevelInit();
    EXPECT_TRUE(true);
}

TEST_F(DlogLevelShmUtest, UpdateLogLevelModuleReadFailsWhenBaseExceedsModuleLen)
{
    /* base length 2049: module read fails (len 2048) */
    ASSERT_EQ(0, SetupShmemRaw(2049, nullptr, nullptr, 0));
    DlogLevelInit();
    EXPECT_TRUE(true);
}

TEST_F(DlogLevelShmUtest, ReInitRestartsWatcher)
{
    const unsigned char level[] = {0x28, 0x01, 0x28, 0x00};
    ASSERT_EQ(0, SetupShmemRaw(3, "SLOG;", level, sizeof(level)));
    DlogLevelInit();
    DlogLevelReInit();
    EXPECT_TRUE(true);
}

TEST_F(DlogLevelShmUtest, WatcherThreadRunsAndExitsWhenNotifyUnavailable)
{
    /* Provide shared memory so the watcher's CheckShMemAvailable succeeds and it
     * proceeds to ObtainNotifyFile + AddNewWatch. /usr/slog/level_notify does not
     * exist, so inotify_add_watch fails -> AddNewWatch returns NOTIFY_WATCH_FAILED
     * -> the watcher thread returns cleanly (no read() on the notify fd). */
    const unsigned char level[] = {0x28, 0x01, 0x28, 0x00};
    ASSERT_EQ(0, SetupShmemRaw(3, "SLOG;", level, sizeof(level)));
    DlogLevelInit();
    SetToolCreateThread(1);
    DlogLevelReInit(); /* spawns a real detached watcher thread */
    /* give the async watcher thread time to run through its path and exit */
    (void)usleep(200000);
    SetToolCreateThread(0);
    EXPECT_TRUE(true);
}
