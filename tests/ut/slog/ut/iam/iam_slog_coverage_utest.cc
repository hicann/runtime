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

#include <cstdarg>
#include <cstdlib>
#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>
#include <vector>

#include "dlog_async_process.h"
#include "dlog_attr.h"
#include "dlog_core.h"
#include "dlog_iam.h"
#include "dlog_level_mgr.h"
#include "log_iam_pub.h"

extern "C" {
bool DlogIsInited(void);
void DlogSetInited(bool initFlag);
void DlogIamResStatusCb(struct IAMVirtualResourceStatus* resList, int32_t listNum);
void DlogLevelInitCallBack(void);
uint64_t DlogGetBufNodeCount(RingBufferStat* ringBuffer);
void LogCtrlIncLogic(void);
int32_t DlogWriteBufToHiMem(RingBufferStat* ringBuffer);
void SafeWritesByIam(RingBufferStat* ringBuffer);
void DlogPrintLogLoss(void);

void IamSlogStubReset(void);
void IamSlogStubSetServicePreparation(bool ready);
void IamSlogStubSetRegisterRet(int32_t ret);
void IamSlogStubSetUnregisterRet(int32_t ret);
void IamSlogStubSetIoctlResult(int32_t ret, int32_t errorCode);
void IamSlogStubSetIoctlLevels(int32_t globalLevel, int32_t eventLevel, int32_t moduleLevel);
void IamSlogStubNotifyResource(enum IAMResourceStatus status);
void IamSlogStubFirePeriodicTimer(void);
}

namespace {
constexpr char kIamRoot[] = "/tmp/iam_slog_utest";
int32_t g_registerCallbackCount = 0;

void CountRegisterCallback()
{
    g_registerCallbackCount++;
}

void CreateIamService()
{
    (void)mkdir(kIamRoot, 0750);
    int32_t fd = open(LOGOUT_IAM_SERVICE_PATH, O_CREAT | O_RDWR | O_TRUNC, 0600);
    ASSERT_GE(fd, 0) << strerror(errno);
    ASSERT_EQ(0, close(fd));
}

LogMsgArg MakeMsgArg(uint32_t moduleId, uint32_t typeMask, int32_t level)
{
    LogMsgArg arg = {};
    arg.moduleId = moduleId;
    arg.typeMask = typeMask;
    arg.level = level;
    arg.attr.type = APPLICATION;
    return arg;
}

int32_t CallWrite(LogMsgArg* arg, const char* fmt, ...)
{
    va_list values;
    va_start(values, fmt);
    int32_t ret = DlogWriteInner(arg, fmt, values);
    va_end(values);
    return ret;
}

int RunAsyncCoverageScenario()
{
    int result = 0;
    auto check = [&result](bool condition) {
        if (!condition) {
            result = 1;
        }
    };
    DlogSetInited(false);
    DlogInit();
    check(DlogIsInited());
    DlogInit();

    KeyValue values[] = {{"request", "coverage"}};
    LogMsgArg debug = MakeMsgArg(SLOG, DEBUG_LOG_MASK, DLOG_ERROR);
    debug.kvArg.pstKVArray = values;
    debug.kvArg.kvNum = 1;
    check(CallWrite(&debug, "iam debug %d", 1) == LOG_SUCCESS);

    LogMsgArg security = MakeMsgArg(SLOG, SECURITY_LOG_MASK, DLOG_WARN);
    check(CallWrite(&security, "iam security") == LOG_SUCCESS);
    LogMsgArg invalidModule = MakeMsgArg(INVLID_MOUDLE_ID + 1U, DEBUG_LOG_MASK, DLOG_ERROR);
    check(CallWrite(&invalidModule, "invalid module") == LOG_SUCCESS);
    LogMsgArg stdoutLog = MakeMsgArg(SLOG, STDOUT_LOG_MASK, DLOG_ERROR);
    check(CallWrite(&stdoutLog, "iam stdout") == LOG_SUCCESS);
    LogMsgArg filtered = MakeMsgArg(SLOG, DEBUG_LOG_MASK, LOG_MAX_LEVEL);
    check(CallWrite(&filtered, "filtered") == LOG_FAILURE);

    DlogWriteToBuf(nullptr);
    DlogUpdateFlierLevelStatus();
    DlogRefreshCache();

    check(DlogGetBufNodeCount(nullptr) == 0U);
    RingBufferCtrl countCtrl = {};
    countCtrl.logNextSeq = 2U;
    countCtrl.lastSeq = 5U;
    RingBufferStat countBuffer = { sizeof(countCtrl), &countCtrl };
    check(DlogGetBufNodeCount(&countBuffer) == 0U);
    check(countCtrl.lastSeq == 2U);
    LogCtrlIncLogic();
    DlogPrintLogLoss();

    IamSlogStubNotifyResource(IAM_RESOURCE_READY);
    check(DlogIamServiceIsValid());

    const char text[] = "async coverage";
    LogMsg message = {};
    message.type = DEBUG_LOG;
    message.level = DLOG_ERROR;
    message.moduleId = SLOG;
    (void)strcpy_s(message.msg, sizeof(message.msg), text);
    message.msgLength = strlen(text);
    DlogWriteToBuf(&message);
    IamSlogStubFirePeriodicTimer();

    struct stat serviceStat = {};
    check((stat(LOGOUT_IAM_SERVICE_PATH, &serviceStat) == 0) && (serviceStat.st_size > 0));

    std::vector<char> retryStorage(DEF_SIZE / 4U);
    RingBufferStat retryBuffer = { static_cast<uint32_t>(retryStorage.size()),
                                   reinterpret_cast<RingBufferCtrl*>(retryStorage.data()) };
    check(LogBufInitHead(retryBuffer.ringBufferCtrl, retryBuffer.logBufSize, 0) == SYS_OK);
    LogHead retryHead = {};
    retryHead.magic = HEAD_MAGIC;
    retryHead.version = HEAD_VERSION;
    retryHead.moduleId = SLOG;
    retryHead.msgLength = 7U;
    check(LogBufWrite(retryBuffer.ringBufferCtrl, "reopen!", &retryHead, nullptr) > 0);
    IamSlogStubNotifyResource(IAM_RESOURCE_WAITING);
    SafeWritesByIam(&retryBuffer);
    check(DlogIamServiceIsValid());
    check(LogBufCheckEmpty(&retryBuffer));
    check(DlogWriteBufToHiMem(&retryBuffer) == SYS_ERROR);

    message.msgLength = sizeof(message.msg) - 1U;
    (void)memset_s(message.msg, sizeof(message.msg), 'x', message.msgLength);
    message.msg[message.msgLength] = '\0';
    for (int32_t i = 0; i < 1100; i++) {
        DlogWriteToBuf(&message);
    }
    message.level = DLOG_DEBUG;
    DlogWriteToBuf(&message);
    DlogUpdateFlierLevelStatus();
    IamSlogStubSetIoctlResult(SYS_ERROR, EIO);
    DlogFlushBuf();

    if (DlogIamServiceIsValid()) {
        IamSlogStubNotifyResource(IAM_RESOURCE_READY);
    }
    IamSlogStubNotifyResource(IAM_RESOURCE_WAITING);
    DlogAsyncExit();
    DlogSetInited(false);
    return result;
}
}

class IamSlogCoverageUtest : public testing::Test {
protected:
    void SetUp() override
    {
        originalGlobalLevel_ = GetGlobalLogTypeLevelVar(DLOG_GLOBAL_TYPE_MASK);
        originalEventLevel_ = GetGlobalEnableEventVar();
        originalModuleLevels_.clear();
        for (uint32_t moduleId = 0; moduleId < INVLID_MOUDLE_ID; moduleId++) {
            originalModuleLevels_.push_back(DlogGetLogTypeLevelByModuleId(moduleId, DLOG_GLOBAL_TYPE_MASK));
        }
        IamSlogStubReset();
        g_registerCallbackCount = 0;
        (void)unlink(LOGOUT_IAM_SERVICE_PATH);
        (void)rmdir(kIamRoot);
        LogAttr attr = {};
        attr.type = APPLICATION;
        DlogSetUserAttr(&attr);
        DlogSetInited(false);
    }

    void TearDown() override
    {
        if (DlogIamServiceIsValid()) {
            IamSlogStubNotifyResource(IAM_RESOURCE_READY);
        }
        IamSlogStubNotifyResource(IAM_RESOURCE_WAITING);
        EXPECT_FALSE(DlogIamServiceIsValid());
        DlogIamExit();
        SetGlobalLogTypeLevelVar(originalGlobalLevel_, DLOG_GLOBAL_TYPE_MASK);
        SetGlobalEnableEventVar(originalEventLevel_);
        for (uint32_t moduleId = 0; moduleId < originalModuleLevels_.size(); moduleId++) {
            (void)DlogSetLogTypeLevelByModuleId(
                moduleId, originalModuleLevels_[moduleId], DLOG_GLOBAL_TYPE_MASK);
        }
        DlogSetInited(false);
        (void)unlink(LOGOUT_IAM_SERVICE_PATH);
        (void)rmdir(kIamRoot);
    }

private:
    int32_t originalGlobalLevel_ = DLOG_DEBUG;
    bool originalEventLevel_ = true;
    std::vector<int32_t> originalModuleLevels_;
};

TEST_F(IamSlogCoverageUtest, InitializesAndReleasesIamLogging)
{
    EXPECT_FALSE(DlogIamServiceIsValid());
    EXPECT_EQ(SYS_ERROR, DlogIamIoctlGetLevel(nullptr));
    EXPECT_EQ(TRUE, DlogCheckLogLevel(DLOG_ERROR));
}

TEST_F(IamSlogCoverageUtest, InitializesWritesFlushesAndExits)
{
    CreateIamService();
    EXPECT_EXIT(std::exit(RunAsyncCoverageScenario()), testing::ExitedWithCode(0), "");
}

TEST_F(IamSlogCoverageUtest, HandlesIamRegistrationAndResourceLifecycle)
{
    IamSlogStubSetServicePreparation(false);
    EXPECT_EQ(SYS_ERROR, DlogIamInit());

    IamSlogStubSetServicePreparation(true);
    IamSlogStubSetRegisterRet(SYS_ERROR);
    EXPECT_EQ(SYS_ERROR, DlogIamInit());

    IamSlogStubSetRegisterRet(SYS_OK);
    EXPECT_EQ(SYS_OK, DlogIamInit());
    DlogIamRegisterServer(CountRegisterCallback);
    DlogIamRegisterServer(nullptr);
    DlogIamResStatusCb(nullptr, 0);

    CreateIamService();
    IamSlogStubNotifyResource(IAM_RESOURCE_READY);
    EXPECT_TRUE(DlogIamServiceIsValid());
    EXPECT_EQ(1, g_registerCallbackCount);
    IamSlogStubNotifyResource(IAM_RESOURCE_READY);
    EXPECT_EQ(1, g_registerCallbackCount);

    char data[] = "iam";
    EXPECT_EQ(3, DlogIamWrite(data, 3));
    IamSlogStubSetIoctlResult(SYS_OK, 0);
    EXPECT_EQ(SYS_OK, DlogIamIoctlGetLevel(nullptr));
    EXPECT_EQ(SYS_OK, DlogIamIoctlFlushLog(nullptr));

    IamSlogStubNotifyResource(IAM_RESOURCE_WAITING);
    EXPECT_FALSE(DlogIamServiceIsValid());
    IamSlogStubSetUnregisterRet(SYS_ERROR);
    DlogIamExit();
}

TEST_F(IamSlogCoverageUtest, InitializesSystemLevelsFromIam)
{
    LogAttr attr = {};
    attr.type = SYSTEM;
    DlogSetUserAttr(&attr);
    DlogLevelInit();
    EXPECT_EQ(DLOG_IAM_DEFAULT_LEVEL, GetGlobalLogTypeLevelVar(DLOG_GLOBAL_TYPE_MASK));

    CreateIamService();
    EXPECT_EQ(SYS_OK, DlogIamInit());
    IamSlogStubSetIoctlLevels(DLOG_WARN, EVENT_ENABLE_VALUE, DLOG_ERROR);
    IamSlogStubNotifyResource(IAM_RESOURCE_READY);
    EXPECT_EQ(DLOG_WARN, GetGlobalLogTypeLevelVar(DLOG_GLOBAL_TYPE_MASK));
    EXPECT_TRUE(GetGlobalEnableEventVar());
    EXPECT_EQ(DLOG_ERROR, DlogGetLogTypeLevelByModuleId(SLOG, DLOG_GLOBAL_TYPE_MASK));

    IamSlogStubSetIoctlResult(SYS_ERROR, EBUSY);
    DlogLevelInitCallBack();
}
