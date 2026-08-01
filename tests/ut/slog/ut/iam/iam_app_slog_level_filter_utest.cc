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

#include <cstdlib>
#include <cstring>
#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>

#include "dlog_async_process.h"
#include "dlog_attr.h"
#include "dlog_core.h"
#include "dlog_iam.h"
#include "dlog_level_mgr.h"
#include "log_iam_pub.h"
#include "log_ring_buffer.h"

extern "C" {
bool DlogIsInited(void);
void DlogSetInited(bool initFlag);

void IamSlogStubReset(void);
void IamSlogStubNotifyResource(enum IAMResourceStatus status);
void IamSlogStubFirePeriodicTimer(void);
}

namespace {
constexpr char kIamRoot[] = "/tmp/iam_app_slog_utest";

void CreateIamService()
{
    (void)mkdir(kIamRoot, 0750);
    int32_t fd = open(LOGOUT_IAM_SERVICE_PATH, O_CREAT | O_RDWR | O_TRUNC, 0600);
    ASSERT_GE(fd, 0) << strerror(errno);
    ASSERT_EQ(0, close(fd));
}

// Read back the ring buffer header handed to slogd. slogd only re-checks the log
// level when levelFilter is LEVEL_FILTER_OPEN, so this header field is exactly
// what decides whether info logs survive on the daemon side.
bool ReadSentLevelFilter(uint8_t *levelFilter)
{
    int32_t fd = open(LOGOUT_IAM_SERVICE_PATH, O_RDONLY);
    if (fd < 0) {
        return false;
    }
    RingBufferCtrl ctrl = {};
    ssize_t readLen = read(fd, &ctrl, sizeof(ctrl));
    (void)close(fd);
    if (readLen != static_cast<ssize_t>(sizeof(ctrl))) {
        return false;
    }
    *levelFilter = ctrl.levelFilter;
    return true;
}

void WriteOneLogAndSend(int32_t level, const char *text)
{
    LogMsg message = {};
    message.type = DEBUG_LOG;
    message.level = level;
    message.moduleId = SLOG;
    if (strcpy_s(message.msg, sizeof(message.msg), text) != EOK) {
        return;
    }
    message.msgLength = strlen(text);

    DlogWriteToBuf(&message);
    IamSlogStubFirePeriodicTimer();
}

// DlogInit/DlogAsyncExit leave process-wide state behind (buffer indices, timer
// registration), so every scenario runs in its own forked child, matching the
// EXPECT_EXIT pattern already used by iam_slog_utest.
int RunEnvLowersLevelScenario()
{
    int result = 0;
    auto check = [&result](bool condition) {
        if (!condition) {
            result = 1;
        }
    };

    if (setenv("ASCEND_GLOBAL_LOG_LEVEL", "1", 1) != 0) {
        return 1;
    }

    DlogInit();
    check(DlogIsInited());
    check(GetGlobalLogTypeLevelVar(DLOG_GLOBAL_TYPE_MASK) == DLOG_INFO);

    // the service fd is only opened once iam reports the resource ready
    IamSlogStubNotifyResource(IAM_RESOURCE_READY);
    check(DlogIamServiceIsValid());

    WriteOneLogAndSend(DLOG_INFO, "app log level filter probe");

    uint8_t levelFilter = LEVEL_FILTER_OPEN;
    check(ReadSentLevelFilter(&levelFilter));
    check(levelFilter == LEVEL_FILTER_CLOSE);

    // release before _exit so the timer thread and fds are torn down in a
    // defined order instead of relying on the OS
    DlogAsyncExit();
    DlogSetInited(false);
    return result;
}

int RunDefaultLevelScenario()
{
    int result = 0;
    auto check = [&result](bool condition) {
        if (!condition) {
            result = 1;
        }
    };

    DlogInit();
    check(DlogIsInited());
    IamSlogStubNotifyResource(IAM_RESOURCE_READY);
    check(DlogIamServiceIsValid());

    WriteOneLogAndSend(DLOG_ERROR, "default level probe");

    struct stat serviceStat = {};
    check(stat(LOGOUT_IAM_SERVICE_PATH, &serviceStat) == 0);
    check(serviceStat.st_size > 0);

    DlogAsyncExit();
    DlogSetInited(false);
    return result;
}
}  // namespace

class IamAppSlogLevelFilterUtest : public testing::Test {
protected:
    void SetUp() override
    {
        originalGlobalLevel_ = GetGlobalLogTypeLevelVar(DLOG_GLOBAL_TYPE_MASK);
        IamSlogStubReset();
        (void)unlink(LOGOUT_IAM_SERVICE_PATH);
        (void)rmdir(kIamRoot);
        (void)unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
        LogAttr attr = {};
        attr.type = APPLICATION;
        DlogSetUserAttr(&attr);
        DlogSetInited(false);
    }

    void TearDown() override
    {
        DlogAsyncExit();
        DlogSetInited(false);
        DlogIamExit();
        (void)unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
        SetGlobalLogTypeLevelVar(originalGlobalLevel_, DLOG_GLOBAL_TYPE_MASK);
        (void)unlink(LOGOUT_IAM_SERVICE_PATH);
        (void)rmdir(kIamRoot);
    }

private:
    int32_t originalGlobalLevel_ = DLOG_ERROR;
};

// Issue #789: with ASCEND_GLOBAL_LOG_LEVEL=1 the client lets info logs through,
// but the buffer handed to slogd still carried LEVEL_FILTER_OPEN, so slogd
// dropped them against the slog.conf default level.
TEST_F(IamAppSlogLevelFilterUtest, ClosesSlogdLevelFilterWhenEnvLowersLevel)
{
    CreateIamService();
    EXPECT_EXIT(std::exit(RunEnvLowersLevelScenario()), testing::ExitedWithCode(0), "");
}

// Default level must keep working: DlogInit still initializes and ships logs.
TEST_F(IamAppSlogLevelFilterUtest, KeepsInitializingWithDefaultLevel)
{
    CreateIamService();
    EXPECT_EXIT(std::exit(RunDefaultLevelScenario()), testing::ExitedWithCode(0), "");
}
