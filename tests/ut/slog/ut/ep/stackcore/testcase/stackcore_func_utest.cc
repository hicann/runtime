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
#include "securec.h"
#include <string.h>
#include <ucontext.h>
#include "stackcore_interface.h"
#include "stackcore_common.h"
#include "stackcore_stub.h"

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
using namespace std;
using namespace testing;

class EP_STACKCORE_FUNC_UTEST : public testing::Test
{
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

// 未设置子目录 向默认路径落盘stackcore文件
TEST_F(EP_STACKCORE_FUNC_UTEST, StackInit)
{
    ucontext_t utext = { 0 };
    EXPECT_NE(-1, getcontext(&utext));
    siginfo_t info = { 0 };
    info.si_signo = SIGQUIT;
    MOCKER(raise).stubs().will(invoke(raise_stub));
    MOCKER(StackFrame).stubs().will(invoke(StackFrame_stub));
    StackSigHandler(2, &info, &utext);
    EXPECT_EQ(1, CheckStackcoreFileNum(PATH_ROOT));
}

// 设置子目录 向设置的子目录中落盘stackcore文件
TEST_F(EP_STACKCORE_FUNC_UTEST, StackInitSetSubdir)
{
    EXPECT_EQ(0, StackcoreSetSubdirectory(SUBDIR));
    ucontext_t utext = { 0 };
    EXPECT_NE(-1, getcontext(&utext));
    siginfo_t info = { 0 };
    info.si_signo = SIGQUIT;
    MOCKER(raise).stubs().will(invoke(raise_stub));
    MOCKER(StackFrame).stubs().will(invoke(StackFrame_stub));
    StackSigHandler(2, &info, &utext);
    char path[MAX_FILENAME_LEN] = { 0 };
    (void)snprintf_s(path, MAX_FILENAME_LEN, MAX_FILENAME_LEN - 1, "%s%s", PATH_ROOT, SUBDIR);
    EXPECT_EQ(1, CheckStackcoreFileNum(path));
}
