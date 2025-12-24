/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#include "slog.h"
#include "log_level.h"
#include "log_ring_buffer.h"
#include "mdc_slog_stub.h"
#include "self_log_stub.h"
#include "dlog_common.h"
#include "library_load.h"
#include "dlog_async_process.h"
#include "dlog_unified_timer_api.h"
#include "dlog_iam.h"

using namespace std;
using namespace testing;
#define LOG_BUF_NUM                            4
typedef struct DlogBufferMgr {
    RingBufferStat *dlogBuf[LOG_BUF_NUM];
    uint64_t lossCount; // covered log loss count
    uint64_t lastPrintTime; // record log loss print time
    uint32_t writeBufIndex; // current buffer index to write
    uint32_t sendBufIndex; // current buffer index to write
} DlogBufferMgr;

typedef struct DlogLevelCtrlMgr {
    bool ctrlSwitch;
    int32_t ctrlLevel;
    uint64_t lossCount;
    struct timespec ctrlLastTv;
} DlogLevelCtrlMgr;

typedef struct DlogNsycMgr {
    bool initFlag;  // init flag
    bool syncFlag; // sync flag, indicates whether sync tash is registered
    DlogBufferMgr bufMgr; // buffer mgr
    ToolMutex mutex; // mutex
    DlogLevelCtrlMgr levelCtrl; // traffic limiting mechanism level control
    int32_t himemFd; // high memory fd
} DlogNsycMgr;

extern "C" {
    extern DlogNsycMgr g_dlogAsyncMgr;
    extern bool g_dlogIsInited;
    extern enum IAMResourceStatus g_iamResStatus;
    extern bool g_dlogLevelChanged;
    void DllMain(void);
    void DlogExitForIam(void);
    extern int32_t ioctl(int32_t fd, uint32_t cmd, int32_t f);
}

class MDC_SLOG_EXCP_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("> " LOGOUT_IAM_SERVICE_PATH);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
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
    }

public:
    static void DlogConstructor()
    {
        DlogCreateCmdFile(100);
        memset_s(&g_dlogAsyncMgr, sizeof(g_dlogAsyncMgr), 0, sizeof(g_dlogAsyncMgr));
        g_dlogIsInited = false;
        g_iamResStatus = IAM_RESOURCE_WAITING;
        g_dlogLevelChanged = false;
        MOCKER(dlopen).stubs().will(invoke(logDlopen));
        MOCKER(dlclose).stubs().will(invoke(logDlclose));
        MOCKER(dlsym).stubs().will(invoke(logDlsym));
        DllMain();
    }

    static void DlogDestructor()
    {
        SlogSetLevel(3);
        SlogSetEventLevel(1);
        ResetStatus();
        DlogExitForIam();
    }

    int32_t DlogCheckLogNum(const char *path, const char *msg)
    {
        FILE *iamFd = fopen(path, "rb");
        if (iamFd == NULL) {
            return -1;
        }
        RingBufferStat *iamBuf = (RingBufferStat *)malloc(sizeof(RingBufferStat));
        iamBuf->ringBufferCtrl = (RingBufferCtrl *)malloc(DEF_SIZE / 4);
        int32_t msgNum = 0;
        char iamMsg[MSG_LENGTH];
        LogHead msgRes;
        while (feof(iamFd) == 0) {
            memset(iamBuf->ringBufferCtrl, 0, DEF_SIZE / 4);
            fread(iamBuf->ringBufferCtrl, 1, DEF_SIZE / 4, iamFd);
            RingBufferCtrl *ringBufferCtrl = (RingBufferCtrl *)(iamBuf->ringBufferCtrl);
            ReadContext readContext;
            LogBufReStart(ringBufferCtrl, &readContext);
            while (true) {
                memset(iamMsg, 0, MSG_LENGTH);
                int32_t readRes = LogBufRead(&readContext, ringBufferCtrl, iamMsg, MSG_LENGTH, &msgRes);
                if (readRes < 0) {
                    break;
                }
                if (strstr(iamMsg, msg) != NULL) {
                    msgNum++;
                }
            }
        }
        free(iamBuf->ringBufferCtrl);
        iamBuf->ringBufferCtrl = NULL;
        free(iamBuf);
        iamBuf = NULL;
        return msgNum;
    }

};

// 日志落盘
TEST_F(MDC_SLOG_EXCP_UTEST, DlogPrintAddTimerFailed)
{
    MOCKER(SlogIamIoctl).stubs().will(invoke(SlogIamIoctlStub));
    MOCKER(clock_gettime).stubs().will(invoke(clock_gettime_stub));
    MOCKER(AddUnifiedTimer).stubs().will(returnValue(1U));
    // 初始化
    DlogConstructor();

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    dlog_error(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_debug, error_level.");

    // 打印 DLOG_WARN | DEBUG_LOG_MASK
    dlog_warn(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_debug, warn_level.");

    // 打印 DLOG_INFO | DEBUG_LOG_MASK
    dlog_info(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_debug, info_level.");

    // 打印 DLOG_DEBUG | DEBUG_LOG_MASK
    dlog_debug(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_debug, debug_level.");

    // 打印 DLOG_ERROR | RUN_LOG_MASK
    dlog_error(SLOG | RUN_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_run, error_level.");

    // 打印 DLOG_WARN | RUN_LOG_MASK
    dlog_warn(SLOG | RUN_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_run, warn_level.");

    // // 打印 DLOG_INFO | RUN_LOG_MASK
    dlog_info(SLOG | RUN_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_run, info_level.");

    // 打印 DLOG_DEBUG | RUN_LOG_MASK
    dlog_debug(SLOG | RUN_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_run, debug_level.");

    // 打印 DLOG_ERROR | SECURITY_LOG_MASK
    dlog_error(SLOG | SECURITY_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_security, error_level.");

    // 打印 DLOG_WARN | SECURITY_LOG_MASK
    dlog_warn(SLOG | SECURITY_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_security, warn_level.");

    // 打印 DLOG_INFO | SECURITY_LOG_MASK
    dlog_info(SLOG | SECURITY_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_security, info_level.");

    // 打印 DLOG_DEBUG | SECURITY_LOG_MASK
    dlog_debug(SLOG | SECURITY_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_security, debug_level.");

    // 打印 EVENT
    dlog_event(SLOG, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for no mask, event_level.");

    DlogFlush();

    // 释放
    DlogDestructor();

    EXPECT_EQ(1, CheckErrLog("add unified timer failed"));

    EXPECT_EQ(0, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "DEBUG"));
    EXPECT_EQ(0, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "INFO"));
    EXPECT_EQ(0, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "WARNING"));
    EXPECT_EQ(0, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "ERROR"));
    EXPECT_EQ(0, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "EVENT"));
}

TEST_F(MDC_SLOG_EXCP_UTEST, DlogPrintRemoveTimerFailed)
{
    MOCKER(SlogIamIoctl).stubs().will(invoke(SlogIamIoctlStub));
    MOCKER(clock_gettime).stubs().will(invoke(clock_gettime_stub));
    MOCKER(RemoveUnifiedTimer).stubs().will(returnValue(1U));
    // 初始化
    DlogConstructor();

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    dlog_error(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_debug, error_level.");

    // 打印 DLOG_WARN | DEBUG_LOG_MASK
    dlog_warn(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_debug, warn_level.");

    // 打印 DLOG_INFO | DEBUG_LOG_MASK
    dlog_info(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_debug, info_level.");

    // 打印 DLOG_DEBUG | DEBUG_LOG_MASK
    dlog_debug(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_debug, debug_level.");

    // 打印 DLOG_ERROR | RUN_LOG_MASK
    dlog_error(SLOG | RUN_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_run, error_level.");

    // 打印 DLOG_WARN | RUN_LOG_MASK
    dlog_warn(SLOG | RUN_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_run, warn_level.");

    // // 打印 DLOG_INFO | RUN_LOG_MASK
    dlog_info(SLOG | RUN_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_run, info_level.");

    // 打印 DLOG_DEBUG | RUN_LOG_MASK
    dlog_debug(SLOG | RUN_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_run, debug_level.");

    // 打印 DLOG_ERROR | SECURITY_LOG_MASK
    dlog_error(SLOG | SECURITY_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_security, error_level.");

    // 打印 DLOG_WARN | SECURITY_LOG_MASK
    dlog_warn(SLOG | SECURITY_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_security, warn_level.");

    // 打印 DLOG_INFO | SECURITY_LOG_MASK
    dlog_info(SLOG | SECURITY_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_security, info_level.");

    // 打印 DLOG_DEBUG | SECURITY_LOG_MASK
    dlog_debug(SLOG | SECURITY_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_security, debug_level.");

    // 打印 EVENT
    dlog_event(SLOG, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for no mask, event_level.");

    DlogFlush();

    // 释放
    DlogStopSendThread();
    DlogDestructor();
    EXPECT_EQ(1, CheckErrLog("remove unified timer failed"));

    EXPECT_EQ(0, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "DEBUG"));
    EXPECT_EQ(5, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "INFO"));
    EXPECT_EQ(1, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "WARNING"));
    EXPECT_EQ(2, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "ERROR"));
    EXPECT_EQ(1, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "EVENT"));
}

TEST_F(MDC_SLOG_EXCP_UTEST, DlogPrintRemoveTimerDlopenFailed)
{
    MOCKER(SlogIamIoctl).stubs().will(invoke(SlogIamIoctlStub));
    MOCKER(clock_gettime).stubs().will(invoke(clock_gettime_stub));
    MOCKER(dlopen).stubs().will(returnValue((void *)NULL));
    // 初始化
    DlogConstructor();

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    dlog_error(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_debug, error_level.");

    // 打印 DLOG_ERROR | RUN_LOG_MASK
    dlog_error(SLOG | RUN_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_run, error_level.");

    // 打印 DLOG_ERROR | SECURITY_LOG_MASK
    dlog_error(SLOG | SECURITY_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_security, error_level."); 

    // 打印 EVENT
    dlog_event(SLOG, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for no mask, event_level.");

    DlogFlush();

    // 释放
    DlogDestructor();
    EXPECT_EQ(1, CheckErrLog("dlog load unified_timer library failed"));

    EXPECT_EQ(0, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "test"));
}

TEST_F(MDC_SLOG_EXCP_UTEST, DlogPrintRemoveTimerDlsymFailed)
{
    MOCKER(SlogIamIoctl).stubs().will(invoke(SlogIamIoctlStub));
    MOCKER(clock_gettime).stubs().will(invoke(clock_gettime_stub));
    MOCKER(dlsym).stubs().will(returnValue((void *)NULL));
    // 初始化
    DlogConstructor();

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    dlog_error(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_debug, error_level.");

    // 打印 DLOG_ERROR | RUN_LOG_MASK
    dlog_error(SLOG | RUN_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_run, error_level.");

    // 打印 DLOG_ERROR | SECURITY_LOG_MASK
    dlog_error(SLOG | SECURITY_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_security, error_level.");

    // 打印 EVENT
    dlog_event(SLOG, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for no mask, event_level.");

    // 释放
    DlogDestructor();

    EXPECT_EQ(0, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "test"));
}

TEST_F(MDC_SLOG_EXCP_UTEST, DlogPrintRemoveTimerDlcloseFailed)
{
    MOCKER(SlogIamIoctl).stubs().will(invoke(SlogIamIoctlStub));
    MOCKER(clock_gettime).stubs().will(invoke(clock_gettime_stub));
    MOCKER(dlclose).stubs().will(returnValue(-1));
    // 初始化
    DlogConstructor();

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    dlog_error(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_EXCP_UTEST][DlogPrint] test for mask_debug, error_level.");

    // 打印 DLOG_ERROR | RUN_LOG_MASK
    dlog_error(SLOG | RUN_LOG_MASK, "[MDC_SLOG_EXCP_UTEST][DlogPrint] test for mask_run, error_level.");

    // 打印 DLOG_ERROR | SECURITY_LOG_MASK
    dlog_error(SLOG | SECURITY_LOG_MASK, "[MDC_SLOG_EXCP_UTEST][DlogPrint] test for mask_security, error_level.");

    // 打印 EVENT
    dlog_event(SLOG, "[MDC_SLOG_EXCP_UTEST][DlogPrint] test for no mask, event_level.");

    // 释放
    DlogDestructor();
    EXPECT_EQ(1, CheckErrLog("close unified_timer library handle failed"));

    EXPECT_EQ(0, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "test"));
}

static void *LogMallocStub(size_t size)
{
    void *buf = malloc(size);
    memset_s(buf, size, 0, size);
    return buf;
}

TEST_F(MDC_SLOG_EXCP_UTEST, DlogBufInitFailed)
{
    MOCKER(SlogIamIoctl).stubs().will(invoke(SlogIamIoctlStub));
    MOCKER(LogMalloc).stubs().will(returnValue((void *)NULL));
    // 初始化
    DlogConstructor();

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    dlog_error(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_debug, error_level.");
    DlogFlush();

    // 释放
    DlogDestructor();
    EXPECT_EQ(0, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "ERROR"));
}

TEST_F(MDC_SLOG_EXCP_UTEST, DlogBufInitFailedCtrl)
{
    MOCKER(SlogIamIoctl).stubs().will(invoke(SlogIamIoctlStub));
    MOCKER(LogMalloc).stubs().will(invoke(LogMallocStub)).then(invoke(LogMallocStub)).then(returnValue((void *)NULL));
    // 初始化
    DlogConstructor();

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    dlog_error(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_debug, error_level.");
    DlogFlush();

    // 释放
    DlogDestructor();
    EXPECT_EQ(0, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "ERROR"));
}

TEST_F(MDC_SLOG_EXCP_UTEST, DlogBufInitFailedSend)
{
    MOCKER(SlogIamIoctl).stubs().will(invoke(SlogIamIoctlStub));
    MOCKER(LogMalloc).stubs()
        .will(invoke(LogMallocStub))
        .then(invoke(LogMallocStub))
        .then(invoke(LogMallocStub))
        .then(returnValue((void *)NULL));
    // 初始化
    DlogConstructor();

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    dlog_error(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_debug, error_level.");
    DlogFlush();

    // 释放
    DlogDestructor();
    EXPECT_EQ(0, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "ERROR"));
}

TEST_F(MDC_SLOG_EXCP_UTEST, DlogBufInitAoscore)
{
    setenv("AOS_TYPE", "AOS_SEA", 1);
    system("> " HM_DRV_CHAR_DEV_USER_PATH);
    MOCKER(ioctl).stubs().will(returnValue(0));
    MOCKER(SlogIamIoctl).stubs().will(invoke(SlogIamIoctlStub));
    // 初始化
    DlogConstructor();

    MOCKER(write).stubs().will(returnValue(-1));
    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    dlog_error(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_EXCP_UTEST][DlogPrint] test for mask_debug, error_level.");
    DlogFlush();

    // 释放
    DlogDestructor();
    EXPECT_EQ(0, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "ERROR"));
    unsetenv("AOS_TYPE");
}

TEST_F(MDC_SLOG_EXCP_UTEST, DlogBufInitDllFailed)
{
    MOCKER(SlogIamIoctl).stubs().will(invoke(SlogIamIoctlStub));
    MOCKER(pthread_atfork).stubs().will(returnValue(-1));
    MOCKER(LoadRuntimeDll).stubs().will(returnValue((void *)NULL));
    // 初始化
    DlogConstructor();

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    for (int32_t i = 0; i < 5000; i++) {
        dlog_error(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_EXCP_UTEST][DlogPrint] test for mask_debug, error_level.");
    }
    sleep(1);

    // 释放
    DlogDestructor();
    EXPECT_EQ(0, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "ERROR"));
    EXPECT_EQ(0, DlogGetLogLossNum("covered", 1));
}

TEST_F(MDC_SLOG_EXCP_UTEST, DlogBufAddTimerFailed)
{
    MOCKER(SlogIamIoctl).stubs().will(invoke(SlogIamIoctlStub));
    MOCKER(AddUnifiedTimer).stubs().will(returnValue(1));
    // 初始化
    DlogConstructor();

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    for (int32_t i = 0; i < 5000; i++) {
        dlog_error(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_EXCP_UTEST][DlogPrint] test for mask_debug, error_level.");
    }
    sleep(1);

    // 释放
    DlogDestructor();
    EXPECT_EQ(0, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "ERROR"));
    EXPECT_EQ(0, DlogGetLogLossNum("covered", 1));
}

TEST_F(MDC_SLOG_EXCP_UTEST, DlogBufIamInvalid)
{
    MOCKER(SlogIamIoctl).stubs().will(invoke(SlogIamIoctlStub));
    system("rm " LOGOUT_IAM_SERVICE_PATH);
    // 初始化
    DlogConstructor();

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    dlog_error(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_debug, error_level.");
    sleep(1);

    // 释放
    DlogDestructor();
    EXPECT_EQ(-1, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "ERROR"));
    EXPECT_EQ(1, DlogGetLogLossNum("covered", 1));
}

TEST_F(MDC_SLOG_EXCP_UTEST, DlogBufIamWriteFailed)
{
    MOCKER(SlogIamIoctl).stubs().will(invoke(SlogIamIoctlStub));
    // 初始化
    DlogConstructor();
    MOCKER(DlogIamWrite).stubs().will(returnValue(-1));

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    dlog_error(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_debug, error_level.");
    sleep(1);

    // 释放
    DlogDestructor();
    EXPECT_EQ(0, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "ERROR"));
    EXPECT_EQ(1, DlogGetLogLossNum("covered", 1));
}

TEST_F(MDC_SLOG_EXCP_UTEST, DlogBufInvalid)
{
    EXPECT_EQ(LogBufCheckEnough((RingBufferStat *)NULL, 0), false);
}

TEST_F(MDC_SLOG_EXCP_UTEST, DlogIamInvalid)
{
    MOCKER(IAMRegResStatusChangeCb).stubs().will(returnValue(-1));
    // 初始化
    DlogConstructor();
    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    dlog_error(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_debug, error_level.");
    EXPECT_EQ(0, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "ERROR"));
    EXPECT_EQ(g_dlogAsyncMgr.initFlag, false);
    // 释放
    DlogDestructor();
}

TEST_F(MDC_SLOG_EXCP_UTEST, DlogRingBufferInitFailed)
{
    MOCKER(LogBufInitHead).stubs().will(returnValue(-1));
    // 初始化
    DlogConstructor();
    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    dlog_error(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_debug, error_level.");
    EXPECT_EQ(0, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "ERROR"));
    EXPECT_EQ(g_dlogAsyncMgr.initFlag, false);
    sleep(1);
    // 释放
    DlogDestructor();
}

TEST_F(MDC_SLOG_EXCP_UTEST, DlogMsgInvalid)
{
    MOCKER(SlogIamIoctl).stubs().will(invoke(SlogIamIoctlStub));
    // 初始化
    DlogConstructor();
    DlogWriteToBuf(nullptr);
    EXPECT_EQ(0, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "ERROR"));
    sleep(1);
    // 释放
    DlogDestructor();
}

TEST_F(MDC_SLOG_EXCP_UTEST, DlogWriteFailed)
{
    MOCKER(SlogIamIoctl).stubs().will(invoke(SlogIamIoctlStub));
    // 初始化
    DlogConstructor();
    MOCKER(LogBufWrite).stubs().will(returnValue(-1));
    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    dlog_error(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_STEST][DlogPrint] test for mask_debug, error_level.");
    EXPECT_EQ(0, DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "ERROR"));
    sleep(1);
    // 释放
    DlogDestructor();
}

TEST_F(MDC_SLOG_EXCP_UTEST, DlogPrintOverBufSizeSyncFuncFailed)
{
    MOCKER(SlogIamIoctl).stubs().will(invoke(SlogIamIoctlStub));
    // 初始化
    DlogConstructor();
    MOCKER(DlogAddUnifiedTimer).stubs().will(returnValue(1));

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    for (int32_t i = 0; i < 5000; i++) {
        dlog_error(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_UTEST][DlogPrint] test for mask_debug, error_level.");
    }
    usleep(100000);
    MOCKER(DlogLoadTimerDll).stubs().will(returnValue(-1));
    for (int32_t i = 0; i < 5000; i++) {
        dlog_error(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_UTEST][DlogPrint] test for mask_debug, error_level.");
    }
    usleep(100000);

    // 释放
    DlogDestructor();
    int32_t levelCtrlLoss = DlogGetLogLossNum("covered", 0);
    EXPECT_EQ(0, levelCtrlLoss);
    int32_t coverLoss = DlogGetLogLossNum("covered", 1);
    printf("log coverLoss loss num debug : %d.\n", coverLoss);

    EXPECT_EQ(10000, coverLoss + DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "ERROR"));
}

TEST_F(MDC_SLOG_EXCP_UTEST, DlogPrintOverBufSizeSyncLoadFailed)
{
    MOCKER(SlogIamIoctl).stubs().will(invoke(SlogIamIoctlStub));
    // 初始化
    DlogConstructor();
    MOCKER(DlogLoadTimerDll).stubs().will(returnValue(-1));

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    for (int32_t i = 0; i < 5000; i++) {
        dlog_error(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_UTEST][DlogPrint] test for mask_debug, error_level.");
    }
    usleep(100000);
    for (int32_t i = 0; i < 5000; i++) {
        dlog_error(SLOG | DEBUG_LOG_MASK, "[MDC_SLOG_FUNC_UTEST][DlogPrint] test for mask_debug, error_level.");
    }
    usleep(100000);

    // 释放
    DlogDestructor();
    int32_t levelCtrlLoss = DlogGetLogLossNum("covered", 0);
    EXPECT_EQ(0, levelCtrlLoss);
    int32_t coverLoss = DlogGetLogLossNum("covered", 1);
    printf("log coverLoss loss num debug : %d.\n", coverLoss);

    EXPECT_EQ(10000, coverLoss + DlogCheckLogNum(LOGOUT_IAM_SERVICE_PATH, "ERROR"));
}

TEST_F(MDC_SLOG_EXCP_UTEST, DlogFlushFailed)
{
    MOCKER(SlogIamIoctl).stubs().will(invoke(SlogIamIoctlStub));
    // 初始化
    DlogConstructor();
    MOCKER(DlogIamIoctlFlushLog).stubs().will(returnValue(-1));
    DlogFlush();
    MOCKER(DlogIamServiceIsValid).stubs().will(returnValue(false));
    DlogFlush();
    EXPECT_EQ(1, GetErrLogNum());
    // 释放
    DlogDestructor();
}