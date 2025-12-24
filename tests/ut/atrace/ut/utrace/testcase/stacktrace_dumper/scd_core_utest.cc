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
#include "stacktrace_err_code.h"
#include "stacktrace_logger.h"

extern "C" {
    int32_t ScdCoreMain(int32_t argc, const char** argv);
}

class ScdCoreUtest: public testing::Test {
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


TEST_F(ScdCoreUtest, TestScdCoreMain)
{
    const char *argValue[] = {"./asc_dumper"};
    const char **argv = (const char **)&argValue;
    auto argc = sizeof(argv) / sizeof(argv[0]);
    TraStatus ret = TRACE_FAILURE;

    MOCKER(ScdUtilReadStdin).stubs().will(returnValue(TRACE_FAILURE));
    ret = ScdCoreMain(argc, argv);
    EXPECT_EQ(SCD_ERR_CODE_READ_STDIN, ret);
    GlobalMockObject::verify();

    MOCKER(ScdUtilReadStdin).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER(ScdProcessDump).stubs().will(returnValue(TRACE_SUCCESS));
    ret = ScdCoreMain(argc, argv);
    EXPECT_EQ(SCD_ERR_CODE_SUCCESS, ret);
    GlobalMockObject::verify();

    MOCKER(ScdUtilReadStdin).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(access).stubs().will(returnValue(-1));
    ret = ScdCoreMain(argc, argv);
    EXPECT_EQ(SCD_ERR_CODE_WAIT_DIR, ret);
    GlobalMockObject::verify();

    MOCKER(ScdUtilReadStdin).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER(StacktraceLogInit).stubs().will(returnValue(TRACE_FAILURE));
    ret = ScdCoreMain(argc, argv);
    EXPECT_EQ(SCD_ERR_CODE_INIT_LOGCAT, ret);
    GlobalMockObject::verify();

    MOCKER(ScdUtilReadStdin).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER(ScdProcessDump).stubs().will(returnValue(TRACE_FAILURE));
    ret = ScdCoreMain(argc, argv);
    EXPECT_EQ(SCD_ERR_CODE_DUMP_INFO, ret);
    GlobalMockObject::verify();
}