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
using namespace std;
using namespace testing;

class EP_ALOG_HOST_PERF_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
        DlogConstructor();
    }

    virtual void TearDown()
    {
        DlogDestructor();
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
    void DlogConstructor()
    {
    }

    void DlogDestructor()
    {
    }
    bool DlogCheckPrint()
    {
    }
    bool DlogCheckPrintNum()
    {
    }
    bool DlogCheckFileValue()
    {
    }
};

#define SEC_TO_NS 1000000000ULL

static uint64_t GetSysCycleTime()
{
    struct timespec now = {0, 0};
    (void)clock_gettime(CLOCK_MONOTONIC_RAW, &now);
    return (static_cast<uint64_t>(now.tv_sec) * SEC_TO_NS) + static_cast<uint64_t>(now.tv_nsec);
}

static uint64_t CheckLogLevelPerfFunc(const int32_t times, int32_t moduleId, int32_t level)
{
    uint64_t startTime = GetSysCycleTime();
    for (int32_t i = 0; i < times; i++) {
        auto ret = CheckLogLevel(moduleId, level);
    }
    uint64_t stopTime = GetSysCycleTime();
    return stopTime - startTime;
}

// 1s带宽性能

// 满规格性能，检测会不会丢