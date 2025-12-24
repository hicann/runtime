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
#include <thread>
#include <future>
#include <unistd.h>
#include <sys/syscall.h>
#include "cpu_detect.h"
#include "cpu_detect_types.h"
#include "cpu_detect_core.h"
#include "cpu_detect_test.h"
#include "mmpa_api.h"
#include "ascend_hal.h"
#include "slog.h"

#define DEVICE_MAX_CPU_NUM  64U

typedef struct {
    int32_t cpuId;
    int32_t moduleType;
} CpuInfo;

typedef struct {
    CpuInfo cpu;
    int32_t tid;
    pthread_t task;
    int32_t result;
} CpuDetectThreadMgr;

typedef struct {
    bool stop;
    uint32_t devNum;
    uint32_t cpuNum;
    uint32_t timeout;
    struct timeval startTime;
    CpuDetectThreadMgr thread[DEVICE_MAX_CPU_NUM];
} CpuDetectMgr;

extern "C" {
    extern CpuDetectMgr g_cpuDetectMgr;
    extern int32_t CpuDetectGetCpuInfo(uint32_t deviceNum, int32_t moduleType, CpuDetectThreadMgr *thread, uint32_t size);
    extern int32_t CpuDetectGetCcpuInfo(uint32_t deviceNum, CpuDetectThreadMgr *thread, uint32_t size);
    extern int32_t CpuDetectGetAicpuInfo(uint32_t deviceNum, CpuDetectThreadMgr *thread, uint32_t size);
    extern int32_t CpuDetectGetDcpuInfo(uint32_t deviceNum, CpuDetectThreadMgr *thread, uint32_t size); 
}

enum UTEST_TYPE {
    UTEST_NORMAL,
    UTEST_CREATE_THREAD_FAIL,
    UTEST_BIND_CGROUP_FAIL,
    UTEST_SETAFFINITY_FAIL,
    UTEST_TESTCASE_FAIL,
};

class CpuDetectCoreUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        system("rm -rf " LLT_TEST_DIR "/*");
        system("mkdir -p " LLT_TEST_DIR );
        system("echo [DBG][CpuDetectCore][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        system("rm -rf " LLT_TEST_DIR "/*");
        system("echo [DBG][CpuDetectCore][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("echo [DBG][CpuDetectCore][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("echo [DBG][CpuDetectCore][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }
 
    static void UtestEnvPrepara(int32_t envType, int32_t devNum)
    {
        if (envType == UTEST_NORMAL) {
            MOCKER(halBindCgroup).stubs().will(returnValue(0));
            MOCKER(pthread_setaffinity_np).stubs().will(returnValue(0));
        } else if (envType == UTEST_CREATE_THREAD_FAIL) {
            MOCKER(halBindCgroup).stubs().will(returnValue(0));
            MOCKER(pthread_setaffinity_np).stubs().will(returnValue(0));
            MOCKER(pthread_create)
                .stubs()
                .will(returnValue(10));
        } else if (envType == UTEST_BIND_CGROUP_FAIL) {
            MOCKER(halBindCgroup).stubs().will(returnValue(11));
            MOCKER(pthread_setaffinity_np).stubs().will(returnValue(0));
        } else if (envType == UTEST_SETAFFINITY_FAIL) {
            MOCKER(halBindCgroup).stubs().will(returnValue(0));
            MOCKER(pthread_setaffinity_np).stubs().will(returnValue(1));
        }  else if (envType == UTEST_TESTCASE_FAIL) {
            MOCKER(halBindCgroup).stubs().will(returnValue(0));
            MOCKER(pthread_setaffinity_np).stubs().will(returnValue(0));
            MOCKER(CpuDetectGroup)
                .stubs()
                .will(returnValue(100));
        } else {
            MOCKER(halBindCgroup).stubs().will(returnValue(0));
            MOCKER(pthread_setaffinity_np).stubs().will(returnValue(0));
            MOCKER(CpuDetectGroup).stubs().will(returnValue(0));
        }
 
        if (devNum >= 0) {
            static uint32_t devNum_ = devNum;
            MOCKER(drvGetDevNum)
                .stubs()
                .with(outBoundP(&devNum_, sizeof(uint32_t)))
                .will(returnValue((drvError_t)0));
        } else {
            MOCKER(drvGetDevNum).expects(once()).will(returnValue((drvError_t)100));
        }
    }
 
    static void UtestExitCheck()
    {
        EXPECT_EQ(g_cpuDetectMgr.stop, 0);
        EXPECT_EQ(g_cpuDetectMgr.devNum, 0);
        EXPECT_EQ(g_cpuDetectMgr.cpuNum, 0);
        EXPECT_EQ(g_cpuDetectMgr.timeout, 0);
        for (int i = 0; i < DEVICE_MAX_CPU_NUM; i++) {
            EXPECT_EQ(g_cpuDetectMgr.thread[i].cpu.cpuId, 0);
            EXPECT_EQ(g_cpuDetectMgr.thread[i].cpu.cpuId, 0);
            EXPECT_EQ(g_cpuDetectMgr.thread[i].tid, 0);
            EXPECT_EQ(g_cpuDetectMgr.thread[i].task, 0);
            EXPECT_EQ(g_cpuDetectMgr.thread[i].result, 0);
        }
    }
};

TEST_F(CpuDetectCoreUtest, UtestCpuDetectProcess)
{
    UtestEnvPrepara(UTEST_NORMAL, 1);
    CpudStatus ret = CpuDetectProcess(1);
    EXPECT_EQ(ret, CPUD_SUCCESS);
    UtestExitCheck();
}

TEST_F(CpuDetectCoreUtest, UtestCpuDetectProcess_InitFail)
{
    UtestEnvPrepara(UTEST_NORMAL, -1);
    CpudStatus ret = CpuDetectProcess(1);
    EXPECT_EQ(ret, CPUD_ERROR_INIT);
}

TEST_F(CpuDetectCoreUtest, UtestCpuDetectProcess_CreateThreadFail)
{
    UtestEnvPrepara(UTEST_CREATE_THREAD_FAIL, 1);
    CpudStatus ret = CpuDetectProcess(1);
    EXPECT_EQ(ret, CPUD_ERROR_CREATE_THREAD);
}

TEST_F(CpuDetectCoreUtest, UtestCpuDetectProcess_BindCgroupFail)
{
    UtestEnvPrepara(UTEST_BIND_CGROUP_FAIL, 1);
    CpudStatus ret = CpuDetectProcess(1);
    EXPECT_EQ(ret, CPUD_ERROR_CGROUP_BIND);
}

TEST_F(CpuDetectCoreUtest, UtestCpuDetectProcess_SetAffinityFail)
{
    UtestEnvPrepara(UTEST_SETAFFINITY_FAIL, 1);
    CpudStatus ret = CpuDetectProcess(1);
    EXPECT_EQ(ret, CPUD_ERROR_CPU_AFFINITY);
}

TEST_F(CpuDetectCoreUtest, UtestCpuDetectProcess_TestcaseFail)
{
    UtestEnvPrepara(UTEST_TESTCASE_FAIL, 1);
    CpudStatus ret = CpuDetectProcess(1);
    EXPECT_EQ(ret, CPUD_ERROR_TESTCASE);
}

TEST_F(CpuDetectCoreUtest, UtestCpuDetectProcess_GetCpuInfoFail)
{
    UtestEnvPrepara(UTEST_NORMAL, 1);
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(10));
    CpudStatus ret = CpuDetectProcess(1);
    EXPECT_EQ(ret, CPUD_ERROR_INIT);

    GlobalMockObject::verify();
    UtestEnvPrepara(UTEST_NORMAL, 1);
    MOCKER(CpuDetectGetCcpuInfo).stubs().will(returnValue(-1));
    ret = CpuDetectProcess(1);
    EXPECT_EQ(ret, CPUD_ERROR_INIT);

    GlobalMockObject::verify();
    UtestEnvPrepara(UTEST_NORMAL, 1);
    MOCKER(CpuDetectGetAicpuInfo).stubs().will(returnValue(-1));
    ret = CpuDetectProcess(1);
    EXPECT_EQ(ret, CPUD_ERROR_INIT);

    GlobalMockObject::verify();
    UtestEnvPrepara(UTEST_NORMAL, 1);
    MOCKER(CpuDetectGetDcpuInfo).stubs().will(returnValue(-1));
    ret = CpuDetectProcess(1);
    EXPECT_EQ(ret, CPUD_ERROR_INIT);

    GlobalMockObject::verify();
    UtestEnvPrepara(UTEST_NORMAL, 1);
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(0));
    ret = CpuDetectProcess(1);
    EXPECT_EQ(ret, CPUD_ERROR_INIT);
}

TEST_F(CpuDetectCoreUtest, UtestCpuDetectProcess_MallocBufferFail)
{
    // malloc regs failed
    UtestEnvPrepara(UTEST_NORMAL, 1);
    MOCKER(malloc).stubs().will(returnValue((void *)NULL));
    CpudStatus ret = CpuDetectProcess(1);
    EXPECT_EQ(ret, CPUD_ERROR_MALLOC);

    // malloc loadStoreBuf  failed
    GlobalMockObject::verify();
    uint32_t *regValues = (uint32_t *)malloc(64 * 512);
    UtestEnvPrepara(UTEST_NORMAL, 1);
    MOCKER(malloc).stubs().will(returnValue((void *)regValues)).then(returnValue((void *)NULL));
    ret = CpuDetectProcess(1);
    EXPECT_EQ(ret, CPUD_ERROR_MALLOC);
}