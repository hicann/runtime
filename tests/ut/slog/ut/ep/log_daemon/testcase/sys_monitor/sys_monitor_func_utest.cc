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
#include <cstring>
#include "self_log_stub.h"
#include "log_daemon_stub.h"
#include "sys_monitor_frame.h"
#include "sys_monitor_common.h"
#include "log_time.h"
using namespace std;
using namespace testing;

typedef struct CpuInfo {
    uint64_t u, n, s, i, w, x, y, z;
    uint64_t uSav, sSav, nSav, iSav, wSav, xSav, ySav, zSav;
} CpuInfo;

typedef struct MemInfo {
    uint64_t total;      // MemTotal
    uint64_t free;
    uint64_t buffers;
    uint64_t cached;
    uint64_t shmem;
    uint64_t slab;
} MemInfo;

typedef struct MemInfoTable {
    const char *name;
    uint64_t *count;
} MemInfoTable;

extern "C" {
extern float SysmonitorCpuGetUsage(void);
extern uint32_t SysmonitorGetCommonDivisor(uint32_t a, uint32_t b);
extern SysmonitorInfo g_sysmonitorInfo[SYS_MONITOR_COUNT];
extern void SysmonitorCpuProcessAlarm(void);
extern MemInfoTable g_memInfoTable[6];
extern int32_t SysmonitorMemParseInfo(char *data);
extern void SysmonitorMemProcessAlarm(float usage);
extern struct MemInfo g_memInfo;
extern uint32_t g_threadStatus;
extern float SysmonitorFdGetUsage(void);
extern int32_t SysmonitorZpGetInfo(uint32_t *count);
extern void SysmonitorFdProcessAlarm(float usage);
extern void SysmonitorCpu(void);
extern void SysmonitorMem(void);
extern void SysmonitorFd(void);
extern void SysmonitorZp(void);
}
class EP_SYS_MONITOR_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
        ResetErrLog();
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
    }
};

static int32_t WaitThreadFinish(void)
{
    while (true) {
        if (g_threadStatus != 3) { // exit
            usleep(3000);
            continue;
        }
        break;
    }
    return 0;
}

TEST(EP_SYS_MONITOR_FUNC_UTEST, Sysmonitor)
{
    MOCKER(ToolSleep)
        .stubs()
        .will(returnValue(0));
    EXPECT_EQ(LOG_SUCCESS, SysmonitorInit());
    LogClearPrintNum();
    EXPECT_EQ(LOG_SUCCESS, SysmonitorProcess());
    usleep(50000);
    SysmonitorExit();

    EXPECT_EQ(0, WaitThreadFinish());
    EXPECT_EQ(1, LogGetFrameStart());
    LogClearPrintNum();
}

TEST(EP_SYS_MONITOR_FUNC_UTEST, SysmonitorCpuAlarm)
{
    MOCKER(SysmonitorCpuGetUsage)
        .stubs()
        .will(returnValue(99.0f));
    EXPECT_EQ(LOG_SUCCESS, SysmonitorInit());
    SysmonitorCpu();

    EXPECT_EQ(1, LogGetCpuAlarmNum());
    LogClearPrintNum();
}

int32_t g_memTime = 0;
errno_t memsetStub(void *dest, size_t size, int value, size_t count)
{
    if (g_memTime++ != 3) {
        if (dest != nullptr) {
            size_t len = (count < size) ? count : size;
            auto *destByte = static_cast<unsigned char *>(dest);
            for (size_t i = 0; i < len; ++i) {
                destByte[i] = static_cast<unsigned char>(value);
            }
        }
        return EOK;
    }
    return (errno_t)(6);
}

static void RunSysmonitorCpuMallocFail(int32_t memTime, int32_t expectedAlarmNum)
{
    MOCKER(SysmonitorCpuGetUsage)
        .stubs()
        .will(returnValue(99.0f));
    MOCKER(memset_s)
        .stubs()
        .will(invoke(memsetStub));
    g_memTime = memTime;
    EXPECT_EQ(LOG_SUCCESS, SysmonitorInit());
    SysmonitorCpu();

    EXPECT_EQ(expectedAlarmNum, LogGetCpuAlarmNum());
    LogClearPrintNum();
}

TEST(EP_SYS_MONITOR_FUNC_UTEST, SysmonitorCpuAlarmMallocFail)
{
    RunSysmonitorCpuMallocFail(2, 1);
}

TEST(EP_SYS_MONITOR_FUNC_UTEST, SysmonitorCpuAlarmGetInfoMallocFail)
{
    RunSysmonitorCpuMallocFail(3, 0);
}

TEST(EP_SYS_MONITOR_FUNC_UTEST, SysmonitorCpuAlarmTopTenMallocFail)
{
    RunSysmonitorCpuMallocFail(2, 1);
}

TEST(EP_SYS_MONITOR_FUNC_UTEST, SysmonitorCpuStat)
{
    MOCKER(SysmonitorCpuGetUsage)
        .stubs()
        .will(returnValue(99.0f));
    MOCKER(SysmonitorCpuProcessAlarm)
        .stubs()
        .will(returnValue(0));
    EXPECT_EQ(LOG_SUCCESS, SysmonitorInit());
    g_sysmonitorInfo[0].statCount = 1000;
    SysmonitorCpu();

    EXPECT_EQ(1, LogGetCpuStatNum());
    LogClearPrintNum();
    GlobalMockObject::verify();
}

int32_t SysmonitorMemParseInfoStub(char *data)
{
    (void)data;
    *(g_memInfoTable[0].count) = 98U;
    *(g_memInfoTable[1].count) = 1U;
    *(g_memInfoTable[2].count) = 1U;
    *(g_memInfoTable[3].count) = 1U;
    *(g_memInfoTable[4].count) = 1U;
    *(g_memInfoTable[5].count) = 2U;
    g_memInfo.total = 10086U;
    return 0;
}

TEST(EP_SYS_MONITOR_FUNC_UTEST, SysmonitorMemAlarm)
{
    MOCKER(SysmonitorMemParseInfo)
        .stubs()
        .will(invoke(SysmonitorMemParseInfoStub));
    EXPECT_EQ(LOG_SUCCESS, SysmonitorInit());
    SysmonitorMem();

    EXPECT_EQ(1, LogGetMemAlarmNum());
    LogClearPrintNum();
}

static void RunSysmonitorMemMallocFail(int32_t memTime)
{
    MOCKER(SysmonitorMemParseInfo)
        .stubs()
        .will(invoke(SysmonitorMemParseInfoStub));
    MOCKER(memset_s)
        .stubs()
        .will(invoke(memsetStub));
    g_memTime = memTime;
    EXPECT_EQ(LOG_SUCCESS, SysmonitorInit());
    SysmonitorMem();

    EXPECT_EQ(1, LogGetMemAlarmNum());
    LogClearPrintNum();
}

TEST(EP_SYS_MONITOR_FUNC_UTEST, SysmonitorMemAlarmGetInfoMallocFail)
{
    RunSysmonitorMemMallocFail(1);
}

TEST(EP_SYS_MONITOR_FUNC_UTEST, SysmonitorMemAlarmTopTenMallocFail)
{
    RunSysmonitorMemMallocFail(1);
}

TEST(EP_SYS_MONITOR_FUNC_UTEST, SysmonitorMemStat)
{
    MOCKER(SysmonitorMemParseInfo)
        .stubs()
        .will(invoke(SysmonitorMemParseInfoStub));
    MOCKER(SysmonitorMemProcessAlarm)
        .stubs()
        .will(returnValue(0));
    EXPECT_EQ(LOG_SUCCESS, SysmonitorInit());
    g_sysmonitorInfo[1].statCount = 1000;
    SysmonitorMem();

    EXPECT_EQ(1, LogGetMemStatNum());
    LogClearPrintNum();
    GlobalMockObject::verify();
}

int32_t topPrintNum = 0;
int32_t ToolReadFdInfoStub(int32_t fd, void *buf, uint32_t bufLen)
{
    (void)fd;
    const char fdInfo[] = "1 0 100";
    if ((buf == nullptr) || (bufLen < sizeof(fdInfo))) {
        return -1;
    }
    (void)memcpy(buf, fdInfo, sizeof(fdInfo));
    return sizeof(fdInfo) - 1;
}

char *fgetsStub(char *str, int n, FILE *stream)
{
    (void)str;
    (void)n;
    (void)stream;
    if (topPrintNum++ < 10000) {
        return "pid comm";
    }
    return NULL;
}

char *strtokStub(char *str, const char *delim, char **context)
{
    (void)str;
    (void)delim;
    (void)context;
    if (topPrintNum < 100) {
        return "100";
    } else if (topPrintNum < 500) {
        return "500";
    } else if (topPrintNum < 3000) {
        return "3000";
    }
    return "9999";
}

TEST(EP_SYS_MONITOR_FUNC_UTEST, SysmonitorFdAlarm)
{
    MOCKER(ToolRead)
        .stubs()
        .will(invoke(ToolReadFdInfoStub));
    MOCKER(SysmonitorFdGetUsage)
        .stubs()
        .will(returnValue(99.0f));
    MOCKER(fgets)
        .stubs()
        .will(invoke(fgetsStub));
    MOCKER(strtok_s)
        .stubs()
        .will(invoke(strtokStub));
    topPrintNum = 0;
    EXPECT_EQ(LOG_SUCCESS, SysmonitorInit());
    SysmonitorFd();

    EXPECT_EQ(1, LogGetFdAlarmNum());
    EXPECT_EQ(3, LogGetFdTopNum());
    LogClearPrintNum();
    GlobalMockObject::verify();
}

TEST(EP_SYS_MONITOR_FUNC_UTEST, SysmonitorFdStat)
{
    MOCKER(ToolRead)
        .stubs()
        .will(invoke(ToolReadFdInfoStub));
    MOCKER(SysmonitorFdGetUsage)
        .stubs()
        .will(returnValue(99.0f));
    MOCKER(SysmonitorFdProcessAlarm)
        .stubs()
        .will(returnValue(0));
    EXPECT_EQ(LOG_SUCCESS, SysmonitorInit());
    g_sysmonitorInfo[2].statCount = 1000;
    SysmonitorFd();

    EXPECT_EQ(1, LogGetFdStatNum());
    LogClearPrintNum();
    GlobalMockObject::verify();
}

int32_t SysmonitorZpGetInfoStub(uint32_t *count)
{
    *count = 6;
    return 0;
}

TEST(EP_SYS_MONITOR_FUNC_UTEST, SysmonitorZpAlarm)
{
    MOCKER(SysmonitorZpGetInfo)
        .stubs()
        .will(invoke(SysmonitorZpGetInfoStub));
    EXPECT_EQ(LOG_SUCCESS, SysmonitorInit());
    SysmonitorZp();

    EXPECT_EQ(1, LogGetZpAlarmNum());
    LogClearPrintNum();
}

TEST(EP_SYS_MONITOR_FUNC_UTEST, SysmonitorZpStat)
{
    MOCKER(SysmonitorZpGetInfo)
        .stubs()
        .will(invoke(SysmonitorZpGetInfoStub));
    EXPECT_EQ(LOG_SUCCESS, SysmonitorInit());
    g_sysmonitorInfo[3].statCount = 1000;
    SysmonitorZp();

    EXPECT_EQ(1, LogGetZpStatNum());
    LogClearPrintNum();
    GlobalMockObject::verify();
}

TEST(EP_SYS_MONITOR_FUNC_UTEST, SysmonitorGetCommonDivisor)
{
    EXPECT_EQ(1, SysmonitorGetCommonDivisor(6, 7));
    EXPECT_EQ(2, SysmonitorGetCommonDivisor(6, 10));
    EXPECT_EQ(3, SysmonitorGetCommonDivisor(6, 21));
    EXPECT_EQ(4, SysmonitorGetCommonDivisor(16, 68));
}
