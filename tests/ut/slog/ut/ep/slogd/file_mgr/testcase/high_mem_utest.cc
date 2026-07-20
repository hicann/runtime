/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "high_mem.h"

#include <cerrno>
#include <cstdlib>
#include <cstring>
#include <fcntl.h>
#include <unistd.h>
#include <vector>

#include "gtest/gtest.h"
#include "log_error_code.h"
#include "self_log_stub.h"

extern "C" {
LogStatus HiMemWrite(int32_t fd, const char* buffer, size_t len);
int32_t HiMemRead(int32_t fd, char* buffer, size_t len);
int32_t HiMemWriteLog(int32_t fd, const char* buffer, uint32_t len, const LogHead* head);
int32_t HiMemReadLog(int32_t fd, char* buffer, size_t len, LogHead* head);
}

namespace {
int RunIamRingBufferRoundTrip()
{
    int result = 0;
    if (HiMemWriteIamLog(0, nullptr) != SYS_ERROR || HiMemReadIamLog(0, nullptr) != 0U) {
        result = 1;
    }

    std::vector<char> sourceStorage(DEF_SIZE);
    RingBufferStat source = { static_cast<uint32_t>(sourceStorage.size()),
                              reinterpret_cast<RingBufferCtrl*>(sourceStorage.data()) };
    if (LogBufInitHead(source.ringBufferCtrl, source.logBufSize, 0) != SYS_OK) {
        return 1;
    }

    LogHead head = {};
    head.magic = HEAD_MAGIC;
    head.version = HEAD_VERSION;
    head.moduleId = SLOG;
    head.msgLength = 8;
    if (LogBufWrite(source.ringBufferCtrl, "coverage", &head, nullptr) <= 0) {
        return 1;
    }

    int32_t pipeFd[2] = { -1, -1 };
    if (pipe(pipeFd) != 0) {
        return 1;
    }
    if (HiMemWriteIamLog(pipeFd[1], &source) != SYS_OK) {
        result = 1;
    }
    (void)close(pipeFd[1]);

    std::vector<char> destinationStorage(DEF_SIZE);
    RingBufferStat destination = { static_cast<uint32_t>(destinationStorage.size()),
                                   reinterpret_cast<RingBufferCtrl*>(destinationStorage.data()) };
    if (LogBufInitHead(destination.ringBufferCtrl, destination.logBufSize, 0) != SYS_OK ||
        HiMemReadIamLog(pipeFd[0], &destination) != 1U || LogBufCheckEmpty(&destination)) {
        result = 1;
    }
    (void)close(pipeFd[0]);
    return result;
}
}

class EP_SLOGD_HIGH_MEM_UTEST : public testing::Test {
protected:
    void SetUp() override
    {
        ResetErrLog();
    }

    void TearDown() override
    {
        ResetErrLog();
    }
};

TEST_F(EP_SLOGD_HIGH_MEM_UTEST, HiMemInitReturnsFailureWhenDeviceIsUnavailable)
{
    int32_t fd = -1;
    EXPECT_EQ(LOG_FAILURE, HiMemInit(&fd));
    EXPECT_EQ(-1, fd);
}

TEST_F(EP_SLOGD_HIGH_MEM_UTEST, HiMemFreeClosesPositiveFd)
{
    int32_t fd = open("/dev/null", O_RDONLY);
    ASSERT_GT(fd, 0);
    int32_t savedFd = fd;

    HiMemFree(&fd);

    EXPECT_EQ(0, fd);
    errno = 0;
    EXPECT_EQ(-1, fcntl(savedFd, F_GETFD));
    EXPECT_EQ(EBADF, errno);
}

TEST_F(EP_SLOGD_HIGH_MEM_UTEST, HiMemRawIoRoundTrip)
{
    char buffer[16] = { 0 };
    EXPECT_EQ(LOG_FAILURE, HiMemWrite(0, "data", 4));
    EXPECT_EQ(LOG_FAILURE, HiMemRead(0, buffer, sizeof(buffer)));

    int32_t pipeFd[2] = { -1, -1 };
    ASSERT_EQ(0, pipe(pipeFd));
    EXPECT_EQ(LOG_SUCCESS, HiMemWrite(pipeFd[1], "data", 4));
    EXPECT_EQ(4, HiMemRead(pipeFd[0], buffer, sizeof(buffer)));
    EXPECT_STREQ("data", buffer);
    ASSERT_EQ(0, close(pipeFd[0]));
    ASSERT_EQ(0, close(pipeFd[1]));
}

TEST_F(EP_SLOGD_HIGH_MEM_UTEST, HiMemLogMessageRoundTripAndRejectsShortInput)
{
    int32_t pipeFd[2] = { -1, -1 };
    ASSERT_EQ(0, pipe(pipeFd));
    LogHead head = {};
    head.magic = HEAD_MAGIC;
    head.version = HEAD_VERSION;
    head.moduleId = SLOG;
    head.msgLength = 5;
    ASSERT_EQ(LOG_SUCCESS, HiMemWriteLog(pipeFd[1], "hello", 5, &head));

    char message[MSG_LENGTH] = { 0 };
    LogHead actual = {};
    EXPECT_EQ(5, HiMemReadLog(pipeFd[0], message, sizeof(message), &actual));
    EXPECT_STREQ("hello", message);
    EXPECT_EQ(HEAD_MAGIC, actual.magic);
    EXPECT_EQ(SLOG, actual.moduleId);
    ASSERT_EQ(0, close(pipeFd[0]));
    ASSERT_EQ(0, close(pipeFd[1]));

    ASSERT_EQ(0, pipe(pipeFd));
    ASSERT_EQ(1, write(pipeFd[1], "x", 1));
    ASSERT_EQ(0, close(pipeFd[1]));
    EXPECT_EQ(SYS_ERROR, HiMemReadLog(pipeFd[0], message, sizeof(message), &actual));
    ASSERT_EQ(0, close(pipeFd[0]));
}

TEST_F(EP_SLOGD_HIGH_MEM_UTEST, IamRingBufferRoundTrip)
{
    EXPECT_EXIT(std::exit(RunIamRingBufferRoundTrip()), testing::ExitedWithCode(0), "");
}
