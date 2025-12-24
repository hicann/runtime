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
#include "awatchdog.h"
#include "slog.h"
#include "mmpa_api.h"
#include "adiag_list.h"
#include "slog_stub.h"

extern "C" {
    typedef struct AwdWatchDog {
        struct AdiagList runList;
        struct AdiagList newList;
    } AwdWatchDog;
    void AwdMonitorInit(void);
    void AwdMonitorExit(void);
    struct AwdWatchDog* AwdGetWatchDog(enum AwdWatchdogType type);
    AwdThreadWatchdog *AwdWatchdogCreate(uint32_t moduleId, uint32_t timeout, AwatchdogCallbackFunc callback,
    enum AwdWatchdogType type);
    void AwdWatchdogDestroy(AwdThreadWatchdog *node);
}

class AwatchdogMonitorUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        Clear();
        system("mkdir -p " LLT_TEST_DIR );
        AwdWatchDog *awd = AwdGetWatchDog(AWD_WATCHDOG_TYPE_THREAD);
        AdiagListInit(&awd->runList);
        AdiagListInit(&awd->newList);
    }
    void Clear()
    {
        AwdWatchDog *awd = AwdGetWatchDog(AWD_WATCHDOG_TYPE_THREAD);
        AdiagListDestroy(&awd->runList);
        AdiagListDestroy(&awd->newList);
        system("rm -rf " LLT_TEST_DIR "/*");
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        Clear();
    }

    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }
};

TEST_F(AwatchdogMonitorUtest, TestMonitorInitCreateThreadFailed)
{
    EXPECT_CheckErrorLog();
    MOCKER(mmCreateTaskWithThreadAttr).stubs().will(returnValue(-1));
    AwdMonitorInit();
    AwdMonitorExit();
}

TEST_F(AwatchdogMonitorUtest, TestMonitorInit)
{
    EXPECT_CheckNoErrorLog();
    AwdMonitorInit();
    AwdMonitorExit();
}

void AwatchdogCallback(void *args)
{
    sleep(1);
}

TEST_F(AwatchdogMonitorUtest, TestMonitorTimeoutWithoutStart)
{
    EXPECT_CheckNoErrorLog();
    AwdMonitorInit();
    MOCKER(AwatchdogCallback).expects(never());
    auto awd = AwdGetWatchDog(AWD_WATCHDOG_TYPE_THREAD);
    int timeout = 1;
    auto dog = AwdWatchdogCreate(ASCENDCL, timeout, AwatchdogCallback, AWD_WATCHDOG_TYPE_THREAD);
    sleep(1);
    AwdMonitorExit();
}

TEST_F(AwatchdogMonitorUtest, TestMonitorTimeout)
{
    EXPECT_CheckNoErrorLog();
    AwdMonitorInit();
    MOCKER(AwatchdogCallback).expects(once());
    auto awd = AwdGetWatchDog(AWD_WATCHDOG_TYPE_THREAD);
    int timeout = 1;
    auto dog = AwdWatchdogCreate(ASCENDCL, timeout, AwatchdogCallback, AWD_WATCHDOG_TYPE_THREAD);
    AwdStartThreadWatchdog((AwdHandle)dog);
    sleep(1);
    AwdMonitorExit();
}

TEST_F(AwatchdogMonitorUtest, TestMonitorTimeoutDurationTooLong)
{
    EXPECT_CheckNoErrorLog();
    AwdMonitorInit();
    int num = 10;
    auto awd = AwdGetWatchDog(AWD_WATCHDOG_TYPE_THREAD);
    for (int i = 0; i < num; i++) {
        int timeout = 1;
        auto dog = AwdWatchdogCreate(ASCENDCL, timeout, AwatchdogCallback, AWD_WATCHDOG_TYPE_THREAD);
        AwdStartThreadWatchdog((AwdHandle)dog);
    }
    sleep(1);
    AwdMonitorExit();
}

TEST_F(AwatchdogMonitorUtest, TestMonitorTimeoutWithRunCountLoop)
{
    EXPECT_CheckNoErrorLog();
    AwdMonitorInit();
    MOCKER(AwatchdogCallback).expects(once());
    auto awd = AwdGetWatchDog(AWD_WATCHDOG_TYPE_THREAD);
    int timeout = 1;
    auto dog = AwdWatchdogCreate(ASCENDCL, timeout, AwatchdogCallback, AWD_WATCHDOG_TYPE_THREAD);
    dog->runCount = 0xFFFFFFF - 1;
    AwdStartThreadWatchdog((AwdHandle)dog);
    sleep(1);
    AwdMonitorExit();
}

TEST_F(AwatchdogMonitorUtest, TestMonitorDestroyDog)
{
    EXPECT_CheckNoErrorLog();
    AwdMonitorInit();
    auto awd = AwdGetWatchDog(AWD_WATCHDOG_TYPE_THREAD);
    int timeout = 1;
    auto dog = AwdWatchdogCreate(ASCENDCL, timeout, AwatchdogCallback, AWD_WATCHDOG_TYPE_THREAD);
    dog->runCount = 0xFFFFFFF - 1;
    AwdStartThreadWatchdog((AwdHandle)dog);
    AwdDestroyThreadWatchdog((AwdHandle)dog);
    sleep(1);
    AwdMonitorExit();
}

TEST_F(AwatchdogMonitorUtest, TestMonitorThreadExit)
{
    EXPECT_CheckNoErrorLog();
    AwdMonitorInit();
    std::vector<std::future<int>> thread; 
    thread.push_back(std::move(std::async([]{
        int timeout = 1;
        auto dog = AwdWatchdogCreate(ASCENDCL, timeout, AwatchdogCallback, AWD_WATCHDOG_TYPE_THREAD);
        AwdStartThreadWatchdog((AwdHandle)dog);
        return 0;
    })));
    for (auto &fret : thread) {
        auto ret  = fret.get();
        EXPECT_EQ(ret, 0);
    }
    sleep(1);
    AwdMonitorExit();
}