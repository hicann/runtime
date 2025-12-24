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
#include "ascend_hal_stub.h"

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#include "log_common.h"
#include "slogd_syslog.h"
#include "slogd_kernel_log.h"
#include "slogd_config_mgr.h"
#include "slogd_buffer.h"

using namespace std;
using namespace testing;

extern "C" {
void SlogdKernelLogReceive(void *args);
bool SlogdKernelLogIsNeedInit(void);
int32_t SlogdSysLogWrite(const char *msg, uint32_t msgLen, const LogInfo *info);
LogStatus SlogdKernelLogProcessBuf(char *msg, uint32_t length);

extern SlogdKernelLogMgr g_kernelLogMgr;
}

class EP_SLOGD_SYS_LOG_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("mkdir -p " LOG_FILE_PATH "/device-os");
        system("touch " KERNEL_LOG_PATH);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        system("rm -rf " PATH_ROOT "/*");
        system("rm -rf " LOG_FILE_PATH "/*");
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

public:
    int DlogCmdGetIntRet(const char *path, const char*cmd)
    {
        char resultFile[200] = {0};
        sprintf(resultFile, "%s/EP_SLOGD_SYS_LOG_FUNC_UTEST_cmd_result.txt", path);

        char cmdToFile[400] = {0};
        sprintf(cmdToFile, "%s > %s", cmd, resultFile);
        system(cmdToFile);

        char buf[100] = {0};
        FILE *fp = fopen(resultFile, "r");
        if (fp == NULL) {
            return 0;
        }
        int size = fread(buf, 1, 100, fp);
        fclose(fp);
        if (size == 0) {
            return 0;
        }
        return atoi(buf);
    }

    int DlogCheckLog(const char *path, const char *str)
    {
        if (access(path, F_OK) != 0) {
            return 0;
        }

        char cmd[200] = {0};
        sprintf(cmd, "cat %s | grep -i %s | wc -l", path, str);
        int ret = DlogCmdGetIntRet(PATH_ROOT, cmd);
        return ret;
    }
};

static int32_t g_sysFileFd = -1;
int32_t SlogdSysLogWrite_stub(const char *msg, uint32_t msgLen, const LogInfo *info)
{
    (void)info;
    if (g_sysFileFd == -1) {
        g_sysFileFd = open(LOG_FILE_PATH "/device-os/device-os_2025022835702082.log", O_CREAT | O_RDWR, 0644);
        EXPECT_LT(0, g_sysFileFd);
    }
    write(g_sysFileFd, msg, msgLen);
    return 0;
}

static void ClearFd(void)
{
    if (g_sysFileFd != -1) {
        close(g_sysFileFd);
        g_sysFileFd = -1;
    }
}

TEST_F(EP_SLOGD_SYS_LOG_FUNC_UTEST, SyslogInit)
{
    MOCKER(SlogdConfigMgrGetBufSize).stubs().will(returnValue(1024));
    MOCKER(SlogdBufferInit).stubs().will(returnValue(LOG_SUCCESS));
    MOCKER(SlogdBufferExit).stubs();
    LogStatus ret = LOG_FAILURE;

    ret = SlogdSyslogInit(-1, false);
    EXPECT_EQ(LOG_SUCCESS, ret);
    SlogdSyslogExit();

    MOCKER(lseek).stubs().will(returnValue((off_t)-1));
    ret = SlogdSyslogInit(-1, false);
    EXPECT_EQ(LOG_FAILURE, ret);
}

TEST_F(EP_SLOGD_SYS_LOG_FUNC_UTEST, KernelLogInit)
{
    MOCKER(SlogdKernelLogIsNeedInit).stubs().will(returnValue(false));
    LogStatus ret = LOG_FAILURE;

    ret = SlogdKernelLogInit(NULL);
    EXPECT_EQ(LOG_SUCCESS, ret);
    SlogdKernelLogExit();
}

static int32_t kernel_log_poll_stub(struct pollfd *fds, nfds_t nfds, int32_t timeout)
{
    static int32_t cnt = 0;
    cnt++;
    if (cnt == 1) {
        g_kernelLogMgr.pollFd.revents = 0; // nodata
        return 1;
    } else if (cnt == 2) {
        return -1; // error
    } else if (cnt == 3) {
        return 0; // timeout
    } else if (cnt == 4) {
        system("echo \"0,1525,10000100,-,caller=T3730;test for kernel log0.\" >> " KERNEL_LOG_PATH);
    } else if (cnt == 5) {
        system("echo \"1,1525,10000100,-,caller=T3730;test for kernel log1.\" >> " KERNEL_LOG_PATH);
    } else if (cnt == 6) {
        system("echo \"2,1525,10000100,-,caller=T3730;test for kernel log2.\" >> " KERNEL_LOG_PATH);
    } else if (cnt == 7) {
        system("echo \"3,1525,10000100,-,caller=T3730;test for kernel log3.\" >> " KERNEL_LOG_PATH);
    } else if (cnt == 8) {
        system("echo \"4,1525,10000100,-,caller=T3730;\\x0 test for kernel log4.\" >> " KERNEL_LOG_PATH);
    } else if (cnt == 9) {
        system("echo \"5,1525,10000100,-,caller=T3730;test for kernel log5.\" >> " KERNEL_LOG_PATH);
    } else if (cnt == 10) {
        system("echo \"6,1525,10000100,-,caller=T3730;\\xA test for kernel log6.\" >> " KERNEL_LOG_PATH);
    } else if (cnt == 11) {
        system("echo \"7,1525,10000100,-,caller=T3730;\\xa test for kernel log7.\" >> " KERNEL_LOG_PATH);
    } else if (cnt == 12) {
        system("echo \"8,1525,10000100,-,caller=T3730;\\xt test for kernel log8.\" >> " KERNEL_LOG_PATH);
    }

    if (cnt >= 4 && cnt <= 12) {
        g_kernelLogMgr.pollFd.revents = POLLIN;
        return 1; // data
    }

    g_kernelLogMgr.pollFd.revents = POLLIN;
    return 1;
}

static int32_t poll_stub(struct pollfd *fds, nfds_t nfds, int32_t timeout)
{
    system("echo \"0,1525,10000100,-,caller=T3730;test for kernel log0.\" >> " KERNEL_LOG_PATH);
    g_kernelLogMgr.pollFd.revents = POLLIN;
    return 1;
}

TEST_F(EP_SLOGD_SYS_LOG_FUNC_UTEST, KernelLogReceive)
{
    MOCKER(poll).stubs().will(invoke(kernel_log_poll_stub));
    LogStatus ret = LOG_FAILURE;
    ret = SlogdKernelLogInit(SlogdSysLogWrite_stub);
    EXPECT_EQ(LOG_SUCCESS, ret);

    for(int32_t i = 0; i < 20; i++) {
        SlogdKernelLogReceive(nullptr);
    }

    EXPECT_EQ(9, DlogCheckLog(LOG_FILE_PATH "/device-os/device-os_2025022835702082.log", "KERNEL"));
    SlogdKernelLogExit();
}

TEST_F(EP_SLOGD_SYS_LOG_FUNC_UTEST, KernelLogReceive_read_failed)
{
    MOCKER(poll).stubs().will(invoke(kernel_log_poll_stub));
    MOCKER(read).stubs().will(returnValue(-1));
    LogStatus ret = LOG_FAILURE;
    ret = SlogdKernelLogInit(SlogdSysLogWrite_stub);
    EXPECT_EQ(LOG_SUCCESS, ret);

    SlogdKernelLogReceive(nullptr);

    EXPECT_EQ(0, DlogCheckLog(LOG_FILE_PATH "/device-os/device-os_2025022835702082.log", "KERNEL"));
    SlogdKernelLogExit();
}

TEST_F(EP_SLOGD_SYS_LOG_FUNC_UTEST, SlogdKernelLogProcessBuf)
{
    char msg[1024] = {"test for kernel log process buf"};
    LogStatus ret = LOG_FAILURE;

    MOCKER(memcpy_s).stubs().will(returnValue(-1));
    ret = SlogdKernelLogProcessBuf(msg, sizeof(msg));
    EXPECT_EQ(LOG_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(vsprintf_s).stubs().will(returnValue(-1));
    ret = SlogdKernelLogProcessBuf(msg, sizeof(msg));
    EXPECT_EQ(LOG_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(EP_SLOGD_SYS_LOG_FUNC_UTEST, KernelLogReceive_snprintf_failed)
{
    MOCKER(poll).stubs().will(invoke(poll_stub));
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    LogStatus ret = LOG_FAILURE;
    ret = SlogdKernelLogInit(SlogdSysLogWrite_stub);
    EXPECT_EQ(LOG_SUCCESS, ret);

    SlogdKernelLogReceive(nullptr);
    EXPECT_EQ(0, DlogCheckLog(LOG_FILE_PATH "/device-os/device-os_2025022835702082.log", "KERNEL"));
    EXPECT_EQ(2, GetErrLogNum());

    SlogdKernelLogExit();
}