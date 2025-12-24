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

#include "scd_core.h"
#include "scd_process.h"

class ScdRegsUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        system("rm -rf " LLT_TEST_DIR "/*");
        system("mkdir -p " LLT_TEST_DIR );
    }

    virtual void TearDown()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
        system("rm -rf " LLT_TEST_DIR );
    }

    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }
};


TEST_F(ScdRegsUtest, TestScdRegsLoadFromUcontext)
{
    ScdRegs regsInfo = {0};
    ucontext_t uc = {0};
    uintptr_t expectPc = 0;
    uintptr_t expectSp = 0;
    uintptr_t expectFp = 0;

    ScdRegsLoadFromUcontext(&regsInfo, &uc);

    ScdRegsSetPc(&regsInfo, expectPc);
    uintptr_t pc = ScdRegsGetPc(&regsInfo);
    EXPECT_EQ(expectPc, pc);

    ScdRegsSetSp(&regsInfo, expectSp);
    uintptr_t sp = ScdRegsGetSp(&regsInfo);
    EXPECT_EQ(expectSp, sp);

    ScdRegsSetFp(&regsInfo, expectFp);
    uintptr_t fp = ScdRegsGetFp(&regsInfo);
    EXPECT_EQ(expectFp, fp);
}

TEST_F(ScdRegsUtest, TestScdRegsGetString)
{
    ScdRegs regsInfo = {0};
    char tmpBuf[1024] = { 0 };
    TraStatus ret = TRACE_FAILURE;

    ret = ScdRegsGetString(&regsInfo, tmpBuf, 1024);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    EXPECT_EQ(TRACE_INVALID_PARAM, ScdRegsGetString(NULL, tmpBuf, 1024));
    EXPECT_EQ(TRACE_INVALID_PARAM, ScdRegsGetString(&regsInfo, NULL, 1024));
    EXPECT_EQ(TRACE_INVALID_PARAM, ScdRegsGetString(&regsInfo, tmpBuf, 0));

    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    ret = ScdRegsGetString(&regsInfo, tmpBuf, 1024);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}