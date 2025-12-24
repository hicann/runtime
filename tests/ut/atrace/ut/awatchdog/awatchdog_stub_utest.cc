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

class AwatchdogStubUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        Clear();
        system("mkdir -p " LLT_TEST_DIR );
    }
    void Clear()
    {
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

DEFINE_THREAD_WATCHDOG(threadHandle);
TEST_F(AwatchdogStubUtest, TestWatchDogInvalidhandle)
{
    AwdCreateThreadWatchdog(0, 0, NULL);
    AwdStartThreadWatchdog(threadHandle);
    EXPECT_NE(AwdStartThreadWatchdog(threadHandle), AWD_SUCCESS);
    AwdFeedThreadWatchdog(threadHandle);
    AwdStopThreadWatchdog(threadHandle);
    AwdDestroyThreadWatchdog(threadHandle);
}

TEST_F(AwatchdogStubUtest, TestWatchDogValidhandle)
{
    AwdThreadWatchdog dog;
    AwdHandle handle = (AwdHandle)&dog;
    EXPECT_NE(AwdStartThreadWatchdog(threadHandle), AWD_SUCCESS);
    AwdFeedThreadWatchdog(handle);
    AwdStopThreadWatchdog(handle);
    AwdDestroyThreadWatchdog(handle);
}
