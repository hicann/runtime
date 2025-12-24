/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stackcore.h"
#include <signal.h>
#include <ucontext.h>
#include <string.h>
#include "stackcore_interface.h"
#include "stackcore_common.h"
#include "stackcore_stub.h"
#include "securec.h"

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
using namespace std;
using namespace testing;

class EP_STACKCORE_EXCP_UTEST: public testing::Test {
protected:
    virtual void SetUp()
    {
        system("rm -rf " PATH_ROOT "/*");
        system("mkdir -p " PATH_ROOT "/" SUBDIR);
        EXPECT_EQ(0, StackInit());
        EXPECT_EQ(0, StackcoreSetSubdirectory("")); //重置为默认路径
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
};

// 设置子目录失败 文件尝试向默认目录落盘
TEST_F(EP_STACKCORE_EXCP_UTEST, StackInitSubdirInputExcp)
{
    EXPECT_EQ(-1, StackcoreSetSubdirectory(SUBDIR "/"));
    EXPECT_EQ(-1, StackcoreSetSubdirectory("../" SUBDIR));

    ucontext_t utext = { 0 };
    EXPECT_NE(-1, getcontext(&utext));
    siginfo_t info = { 0 };
    info.si_signo = SIGQUIT;
    MOCKER(raise).stubs().will(invoke(raise_stub));
    MOCKER(StackFrame).stubs().will(invoke(StackFrame_stub));
    StackSigHandler(2, &info, &utext);
    char path[MAX_FILENAME_LEN] = { 0 };
    (void)snprintf_s(path, MAX_FILENAME_LEN, MAX_FILENAME_LEN - 1, "%s%s", PATH_ROOT, SUBDIR);
    EXPECT_EQ(0, CheckStackcoreFileNum(path));
    EXPECT_EQ(1, CheckStackcoreFileNum(PATH_ROOT));
    GlobalMockObject::verify();
}
