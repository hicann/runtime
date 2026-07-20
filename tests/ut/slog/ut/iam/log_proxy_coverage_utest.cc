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

#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>

#include "high_mem.h"
#include "iam.h"
#include "log_proxy.h"
#include "log_system_api.h"

extern "C" {
int32_t test(int argc, char** argv);
LogStatus LogProxyIamOpenServiceFd(int32_t* fd);
bool LogProxyIamResStatusIsChange(struct IAMVirtualResourceStatus* resList, int32_t listNum);
void LogProxyIamResStatusCb(struct IAMVirtualResourceStatus* resList, int32_t listNum);
LogStatus InitIam(void);
void DeInitIam(void);
void FlushIamLog(int32_t himemFd);
int32_t HimemRead(int32_t himemFd);

extern RingBufferStat* g_logProxBuf;
extern int32_t g_iamFd;
extern enum IAMResourceStatus g_iamResStatus;

void LogProxyStubReset(void);
void LogProxyStubSetIamReady(int32_t ret);
void LogProxyStubSetRegisterRet(int32_t ret);
void LogProxyStubSetUnregisterRet(int32_t ret);
void LogProxyStubSetHiMemInitRet(LogStatus ret);
void LogProxyStubSetHiMemReadNodes(uint32_t nodes);
void LogProxyStubSetLogBufInitRet(int32_t ret);
}

namespace {
constexpr char kRoot[] = "/tmp/log_proxy_coverage_utest";

void CreateIamService()
{
    ASSERT_EQ(0, mkdir(kRoot, 0750)) << strerror(errno);
    int32_t fd = open(LOGOUT_IAM_SERVICE_PATH, O_CREAT | O_RDWR | O_TRUNC, 0600);
    ASSERT_GE(fd, 0) << strerror(errno);
    ASSERT_EQ(0, close(fd));
}
}

class LogProxyCoverageUtest : public testing::Test {
protected:
    void SetUp() override
    {
        (void)unlink(LOGOUT_IAM_SERVICE_PATH);
        (void)rmdir(kRoot);
        LogProxyStubReset();
        g_logProxBuf = nullptr;
        g_iamFd = INVALID;
        g_iamResStatus = IAM_RESOURCE_WAITING;
    }

    void TearDown() override
    {
        if (g_iamFd >= 0) {
            (void)close(g_iamFd);
            g_iamFd = INVALID;
        }
        (void)unlink(LOGOUT_IAM_SERVICE_PATH);
        (void)rmdir(kRoot);
    }
};

TEST_F(LogProxyCoverageUtest, OpensServiceAndTracksResourceTransitions)
{
    int32_t fd = INVALID;
    EXPECT_EQ(LOG_FAILURE, LogProxyIamOpenServiceFd(&fd));

    CreateIamService();
    EXPECT_EQ(LOG_SUCCESS, LogProxyIamOpenServiceFd(&fd));
    EXPECT_GE(fd, 0);
    EXPECT_EQ(LOG_SUCCESS, LogProxyIamOpenServiceFd(&fd));

    IAMVirtualResourceStatus resources[] = {
        {"other", IAM_RESOURCE_READY},
        {LOGOUT_IAM_SERVICE_PATH, IAM_RESOURCE_READY},
    };
    EXPECT_TRUE(LogProxyIamResStatusIsChange(resources, 2));
    EXPECT_FALSE(LogProxyIamResStatusIsChange(resources, 2));
    EXPECT_FALSE(LogProxyIamResStatusIsChange(resources, 1));

    LogProxyIamResStatusCb(nullptr, 0);
    LogProxyIamResStatusCb(resources, 2);
    resources[1].status = IAM_RESOURCE_WAITING;
    LogProxyIamResStatusCb(resources, 2);
    EXPECT_EQ(INVALID, g_iamFd);
    (void)close(fd);
}

TEST_F(LogProxyCoverageUtest, InitializesAndDeinitializesIam)
{
    EXPECT_EQ(LOG_FAILURE, InitIam());

    LogProxyStubSetIamReady(SYS_OK);
    EXPECT_EQ(LOG_SUCCESS, InitIam());
    LogProxyStubSetRegisterRet(SYS_ERROR);
    EXPECT_EQ(LOG_FAILURE, InitIam());

    CreateIamService();
    g_iamFd = open(LOGOUT_IAM_SERVICE_PATH, O_RDWR);
    ASSERT_GE(g_iamFd, 0);
    LogProxyStubSetUnregisterRet(SYS_ERROR);
    DeInitIam();
    EXPECT_EQ(INVALID, g_iamFd);
}

TEST_F(LogProxyCoverageUtest, ReadsHighMemoryAndFlushesBufferedLogs)
{
    LogProxyStubSetLogBufInitRet(SYS_ERROR);
    EXPECT_EQ(SYS_ERROR, HimemRead(1));

    LogProxyStubSetLogBufInitRet(SYS_OK);
    EXPECT_EQ(SYS_OK, HimemRead(1));

    CreateIamService();
    g_iamFd = open(LOGOUT_IAM_SERVICE_PATH, O_RDWR);
    ASSERT_GE(g_iamFd, 0);
    RingBufferStat buffer = {};
    buffer.logBufSize = DEF_SIZE;
    buffer.ringBufferCtrl = static_cast<RingBufferCtrl*>(calloc(1, DEF_SIZE));
    ASSERT_NE(nullptr, buffer.ringBufferCtrl);
    buffer.ringBufferCtrl->dataLen = 99U;
    g_logProxBuf = &buffer;
    LogProxyStubSetHiMemReadNodes(1);
    FlushIamLog(1);
    EXPECT_EQ(0U, buffer.ringBufferCtrl->dataLen);
    free(buffer.ringBufferCtrl);
    g_logProxBuf = nullptr;
}

TEST_F(LogProxyCoverageUtest, MainCleansUpEveryInitializationPath)
{
    EXPECT_EQ(SYS_ERROR, test(0, nullptr));

    LogProxyStubSetIamReady(SYS_OK);
    EXPECT_EQ(SYS_ERROR, test(0, nullptr));

    LogProxyStubSetHiMemInitRet(LOG_SUCCESS);
    LogProxyStubSetLogBufInitRet(SYS_ERROR);
    EXPECT_EQ(SYS_ERROR, test(0, nullptr));

    LogProxyStubSetLogBufInitRet(SYS_OK);
    EXPECT_EQ(SYS_OK, test(0, nullptr));
}
