/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "high_mem.h"
#include "log_proxy.h"
#include "slogd_stub.h"
#include "self_log_stub.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
extern "C"
{
extern int32_t g_iamFd;
int32_t MAIN(int argc, char **argv);
extern int32_t ioctl(int32_t fd, uint32_t cmd, int32_t f);
int32_t HiMemWriteLog(int32_t fd, const char* buffer, uint32_t len, const LogHead *head);
LogStatus HiMemWrite(int32_t fd, const char *buffer, size_t len);
extern RingBufferStat *g_logProxBuf;
extern enum IAMResourceStatus g_iamResStatus;
}

using namespace std;
using namespace testing;

#define AOS_TPYE_ENV_PATH   "AOS_TYPE"
#define AOS_TYPE_AOS_SEA    "AOS_SEA"
#define LOG_NUM 10

class MDC_LOG_PROXY_FUNC_UTEST : public testing::Test
{
    protected:
        virtual void SetUp()
        {
            ResetErrLog();
            LogProxyConstructor();
            LogProxyReset();
            system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
        }

        virtual void TearDown()
        {
            EXPECT_EQ(0, GetErrLogNum());
            system("rm -rf " PATH_ROOT "/*");
            system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
            GlobalMockObject::verify();
        }

        static void SetUpTestCase()
        {
            system("rm -rf " PATH_ROOT);
            system("mkdir -p " PATH_ROOT);
            system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
        }

        static void TearDownTestCase()
        {
            system("rm -rf " PATH_ROOT);
            system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
            LogProxyDestructor();
        }
    public:
        static void LogProxyConstructor()
        {
            system("mkdir -p " TESTCASE_PATH);
            LogProxyCreateLogFile();
            // set type to aos core
            setenv(AOS_TPYE_ENV_PATH, AOS_TYPE_AOS_SEA, 1);
        }
        static void LogProxyDestructor()
        {
        }
        static void LogProxyCreateLogFile();
        static void LogProxyReset();
};

void MDC_LOG_PROXY_FUNC_UTEST::LogProxyCreateLogFile()
{
    system("> " LOG_FILE);
    int32_t fd = open(LOG_FILE, O_RDWR);
    char msg[MSG_LENGTH];
    int32_t ret;
    for (int32_t i = 0; i < LOG_NUM; ++i) {
        ret = snprintf_s(msg, MSG_LENGTH, MSG_LENGTH - 1,
                         "now I am testing log_proxy. this is a log which write to himem, index = %d", i);
        write(fd, msg, MSG_LENGTH);
    }
    close(fd);
}

void MDC_LOG_PROXY_FUNC_UTEST::LogProxyReset()
{
    g_iamFd = INVALID;
    g_iamResStatus = IAM_RESOURCE_WAITING;
    system("rm " HM_DRV_CHAR_DEV_USER_PATH);
    system("rm " LOGOUT_IAM_SERVICE_PATH);
    system("> " HM_DRV_CHAR_DEV_USER_PATH);
    system("> " LOGOUT_IAM_SERVICE_PATH);
}

/**
 * @brief       : check iamfd with logfd
 * @in          : logNum: num of log in iamfd
 * @return      : NA
 */
static void CheckIam(int32_t logNum)
{
    int32_t iamFd = open(LOGOUT_IAM_SERVICE_PATH, O_RDWR);
    RingBufferStat *iamBuf = (RingBufferStat *)malloc(sizeof(RingBufferStat));
    iamBuf->ringBufferCtrl = (RingBufferCtrl *)malloc(DEF_SIZE);
    read(iamFd, iamBuf->ringBufferCtrl, DEF_SIZE);
    RingBufferCtrl *ringBufferCtrl = (RingBufferCtrl *)(iamBuf->ringBufferCtrl);
    ReadContext readContext;
    LogBufReStart(ringBufferCtrl, &readContext);
    char msgLog[MSG_LENGTH];
    char iamMsg[MSG_LENGTH];
    LogHead msgRes;
    int readRes = -1;
    int32_t logFd = open(LOG_FILE, O_RDWR);
    for (int32_t i = 0; i < logNum; ++i) {
        readRes = LogBufRead(&readContext, ringBufferCtrl, iamMsg, MSG_LENGTH, &msgRes);
        memset(msgLog, 0, MSG_LENGTH);
        read(logFd, msgLog, MSG_LENGTH);
        EXPECT_STREQ(msgLog, iamMsg);
    }
    free(iamBuf->ringBufferCtrl);
    iamBuf->ringBufferCtrl = NULL;
    free(iamBuf);
    iamBuf = NULL;
    close(iamFd);
    close(logFd);
}

/**
 * @brief       : write log to himem
 * @return      : NA
 */
static void WriteToHimem()
{
    int32_t fdLog = open(LOG_FILE, O_RDWR);
    int32_t fdHimem = open(HM_DRV_CHAR_DEV_USER_PATH, O_RDWR);
    char msg[MSG_LENGTH];
    HimemLogMsg msgHimem;
    for (int32_t i = 0; i < LOG_NUM; ++i) {
        memset_s(msgHimem.msg, MSG_LENGTH - 1, 0, MSG_LENGTH - 1);
        read(fdLog, msg, MSG_LENGTH);
        memcpy_s(msgHimem.msg, MSG_LENGTH - 1, msg, MSG_LENGTH - 1);
        msgHimem.head.logType = 0;
        write(fdHimem, (const char *)&msgHimem, sizeof(HimemLogMsg));
    }
}

typedef struct {
    int32_t argc;
    char **argv;
} Args;

static void *MainThreadFunc(void *arg)
{
    Args *in = (Args *)arg;
    MAIN(in->argc, in->argv);
    return nullptr;
}

static pthread_t StartThread(Args *arg)
{
    pthread_t tid = 0;
    pthread_attr_t attr;
    (void)pthread_create(&tid, NULL, MainThreadFunc, (void *)arg);
    return tid;
}

/**
 * @brief       : read log from himem to iam when himem is empty
 * @return      : NA
 */
TEST_F(MDC_LOG_PROXY_FUNC_UTEST, LogProxyNull)
{
    MOCKER(ioctl).stubs().will(returnValue(0));

    Args arg = { 0, nullptr };
    pthread_t tid = StartThread(&arg);
    sleep(2);

    // check g_iamFd is null
    CheckIam(0);
}

/**
 * @brief       : read log from himem to iam
 * @return      : NA
 */
TEST_F(MDC_LOG_PROXY_FUNC_UTEST, LogProxy)
{
    MOCKER(ioctl).stubs().will(returnValue(0));
    // mock write log to himem
    WriteToHimem();

    Args arg = { 0, nullptr };
    pthread_t tid = StartThread(&arg);
    sleep(1);
    ResChangeStatus(LOGOUT_IAM_SERVICE_PATH, IAM_RESOURCE_READY);
    sleep(2);
    CheckIam(LOG_NUM);
}

/**
 * @brief       : iam status from INVALID to READY
 * @return      : NA
 */
TEST_F(MDC_LOG_PROXY_FUNC_UTEST, LogProxyIAMStatusChange)
{
    MOCKER(ioctl).stubs().will(returnValue(0));
    // mock write log to himem
    WriteToHimem();
    Args arg = { 0, nullptr };
    pthread_t tid = StartThread(&arg);
    sleep(1);
    ResChangeStatus(LOGOUT_IAM_SERVICE_PATH, IAM_RESOURCE_INVALID);
    ResChangeStatus(LOGOUT_IAM_SERVICE_PATH, IAM_RESOURCE_READY);
    sleep(2);
    CheckIam(LOG_NUM);
}

TEST_F(MDC_LOG_PROXY_FUNC_UTEST, HiMemWriteLog)
{
    MOCKER(HiMemWrite).stubs().will(returnValue(LOG_SUCCESS));
    char msg[100] = "test for write himem.\n";
    LogHead head;
    head.msgLength = strlen(msg);
    EXPECT_EQ(LOG_SUCCESS, HiMemWriteLog(1, msg, strlen(msg), &head));
}