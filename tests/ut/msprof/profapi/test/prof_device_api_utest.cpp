/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mockcpp/mockcpp.hpp"
#include "gtest/gtest.h"
#include <dlfcn.h>
#include "prof_device_api.h"
#include "aprof_pub.h"
#include "error_code.h"

using namespace ProfAPI;
using analysis::dvvp::common::error::PROFILING_FAILED;

class PROF_DEVICE_API_UTEST : public testing::Test {
protected:
    virtual void SetUp() {
        MOCKER(dlsym).stubs().will(returnValue((void *)nullptr));
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(PROF_DEVICE_API_UTEST, ProfInit_func_nullptr)
{
    EXPECT_EQ(PROFILING_FAILED, ProfDevApi::instance()->ProfInit(0, nullptr, 0));
}

TEST_F(PROF_DEVICE_API_UTEST, ProfRegisterCallback_func_nullptr)
{
    auto handle = [](uint32_t, void *, uint32_t) -> int32_t { return 0; };
    EXPECT_EQ(PROFILING_FAILED, ProfDevApi::instance()->ProfRegisterCallback(0, handle));
}

TEST_F(PROF_DEVICE_API_UTEST, ProfFinalize_func_nullptr)
{
    EXPECT_EQ(PROFILING_FAILED, ProfDevApi::instance()->ProfFinalize());
}

TEST_F(PROF_DEVICE_API_UTEST, ProfStr2Id_func_nullptr)
{
    EXPECT_EQ(PROFILING_FAILED, ProfDevApi::instance()->ProfStr2Id("test", 4));
}

TEST_F(PROF_DEVICE_API_UTEST, ProfReportAdditionalInfo_func_nullptr)
{
    EXPECT_EQ(PROFILING_FAILED, ProfDevApi::instance()->ProfReportAdditionalInfo(0, (void*)"data", 4));
}

TEST_F(PROF_DEVICE_API_UTEST, ProfReportBatchAdditionalInfo_func_nullptr)
{
    EXPECT_EQ(PROFILING_FAILED, ProfDevApi::instance()->ProfReportBatchAdditionalInfo(0, (void*)"data", 4));
}

TEST_F(PROF_DEVICE_API_UTEST, ProfGetBatchReportMaxSize_func_nullptr)
{
    EXPECT_EQ(SIZE_MAX, ProfDevApi::instance()->ProfGetBatchReportMaxSize(0));
}

TEST_F(PROF_DEVICE_API_UTEST, MsprofInit_c_api)
{
    EXPECT_EQ(PROFILING_FAILED, MsprofInit(0, nullptr, 0));
}

TEST_F(PROF_DEVICE_API_UTEST, MsprofRegisterCallback_c_api)
{
    auto handle = [](uint32_t, void *, uint32_t) -> int32_t { return 0; };
    EXPECT_EQ(PROFILING_FAILED, MsprofRegisterCallback(0, handle));
}

TEST_F(PROF_DEVICE_API_UTEST, MsprofFinalize_c_api)
{
    EXPECT_EQ(PROFILING_FAILED, MsprofFinalize());
}

TEST_F(PROF_DEVICE_API_UTEST, MsprofStr2Id_c_api)
{
    EXPECT_EQ(PROFILING_FAILED, MsprofStr2Id("test", 4));
}

TEST_F(PROF_DEVICE_API_UTEST, MsprofReportAdditionalInfo_c_api)
{
    EXPECT_EQ(PROFILING_FAILED, MsprofReportAdditionalInfo(0, (void*)"data", 4));
}

TEST_F(PROF_DEVICE_API_UTEST, MsprofReportBatchAdditionalInfo_c_api)
{
    EXPECT_EQ(PROFILING_FAILED, MsprofReportBatchAdditionalInfo(0, (void*)"data", 4));
}

TEST_F(PROF_DEVICE_API_UTEST, MsprofGetBatchReportMaxSize_c_api)
{
    EXPECT_EQ(SIZE_MAX, MsprofGetBatchReportMaxSize(0));
}
