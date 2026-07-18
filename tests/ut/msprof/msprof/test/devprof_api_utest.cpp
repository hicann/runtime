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
#include "devprof_api.h"
#include "aprof_pub.h"
#include "error_code.h"

#ifdef __cplusplus
extern "C" {
#endif
int32_t AdprofCheckFeatureIsOn(uint64_t feature);
uint64_t AdprofGetHashId(const char *hashInfo, size_t length);
int32_t AdprofReportAdditionalInfo(uint32_t nonPersistantFlag, const void *data, uint32_t length);
int32_t AdprofReportBatchAdditionalInfo(uint32_t nonPersistantFlag, const void *data, uint32_t length);
size_t AdprofGetBatchReportMaxSize(uint32_t type);
int32_t AdprofReportData(ConstVoidPtr data, uint32_t length);
int32_t AdprofAicpuStop();
int32_t AdprofStart(int32_t argc, const char *argv[]);
int32_t AdprofStop();
bool GetIsExit(void);
int32_t AdprofAicpuStartRegister(AicpuStartFunc aicpuStartCallback, const struct AicpuStartPara *para);
#ifdef __cplusplus
}
#endif

using analysis::dvvp::common::error::PROFILING_FAILED;

class DEVPROF_API_UTEST : public testing::Test {
protected:
    virtual void SetUp() {
        MOCKER(dlsym).stubs().will(returnValue((void *)nullptr));
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(DEVPROF_API_UTEST, CheckFeatureIsOn_func_nullptr)
{
    EXPECT_EQ(PROFILING_FAILED, DevprofApi::Instance()->CheckFeatureIsOn(0));
}

TEST_F(DEVPROF_API_UTEST, Start_func_nullptr)
{
    const char *argv[] = {"test"};
    EXPECT_EQ(PROFILING_FAILED, DevprofApi::Instance()->Start(1, argv));
}

TEST_F(DEVPROF_API_UTEST, Stop_func_nullptr)
{
    EXPECT_EQ(PROFILING_FAILED, DevprofApi::Instance()->Stop());
}

TEST_F(DEVPROF_API_UTEST, GetIsExit_func_nullptr)
{
    EXPECT_EQ(PROFILING_FAILED, DevprofApi::Instance()->GetIsExit());
}

TEST_F(DEVPROF_API_UTEST, GetHashId_func_nullptr)
{
    EXPECT_EQ(PROFILING_FAILED, DevprofApi::Instance()->GetHashId("hash", 4));
}

TEST_F(DEVPROF_API_UTEST, AicpuStartRegister_func_nullptr)
{
    AicpuStartFunc callback = []() -> int32_t { return 0; };
    struct AicpuStartPara para{};
    EXPECT_EQ(PROFILING_FAILED, DevprofApi::Instance()->AicpuStartRegister(callback, &para));
}

TEST_F(DEVPROF_API_UTEST, ReportAdditionalInfo_func_nullptr)
{
    EXPECT_EQ(PROFILING_FAILED, DevprofApi::Instance()->ReportAdditionalInfo(0, (void*)"data", 4));
}

TEST_F(DEVPROF_API_UTEST, ReportBatchAdditionalInfo_func_nullptr)
{
    EXPECT_EQ(PROFILING_FAILED, DevprofApi::Instance()->ReportBatchAdditionalInfo(0, (void*)"data", 4));
}

TEST_F(DEVPROF_API_UTEST, GetBatchReportMaxSize_func_nullptr)
{
    EXPECT_EQ(0U, DevprofApi::Instance()->GetBatchReportMaxSize(0));
}

TEST_F(DEVPROF_API_UTEST, AdprofCheckFeatureIsOn_c_api)
{
    EXPECT_EQ(PROFILING_FAILED, AdprofCheckFeatureIsOn(0));
}

TEST_F(DEVPROF_API_UTEST, AdprofGetHashId_c_api)
{
    EXPECT_EQ(PROFILING_FAILED, AdprofGetHashId("hash", 4));
}

TEST_F(DEVPROF_API_UTEST, AdprofReportAdditionalInfo_c_api)
{
    EXPECT_EQ(PROFILING_FAILED, AdprofReportAdditionalInfo(0, (void*)"data", 4));
}

TEST_F(DEVPROF_API_UTEST, AdprofReportBatchAdditionalInfo_c_api)
{
    EXPECT_EQ(PROFILING_FAILED, AdprofReportBatchAdditionalInfo(0, (void*)"data", 4));
}

TEST_F(DEVPROF_API_UTEST, AdprofGetBatchReportMaxSize_c_api)
{
    EXPECT_EQ(0U, AdprofGetBatchReportMaxSize(0));
}

TEST_F(DEVPROF_API_UTEST, AdprofReportData_c_api)
{
    EXPECT_EQ(PROFILING_FAILED, AdprofReportData((void*)"data", 4));
}

TEST_F(DEVPROF_API_UTEST, AdprofAicpuStop_c_api)
{
    EXPECT_EQ(PROFILING_FAILED, AdprofAicpuStop());
}

TEST_F(DEVPROF_API_UTEST, AdprofStart_c_api)
{
    const char *argv[] = {"test"};
    EXPECT_EQ(PROFILING_FAILED, AdprofStart(1, argv));
}

TEST_F(DEVPROF_API_UTEST, AdprofStop_c_api)
{
    EXPECT_EQ(PROFILING_FAILED, AdprofStop());
}

TEST_F(DEVPROF_API_UTEST, GetIsExit_c_api)
{
    EXPECT_EQ(true, GetIsExit());
}

TEST_F(DEVPROF_API_UTEST, AdprofAicpuStartRegister_c_api)
{
    AicpuStartFunc callback = []() -> int32_t { return 0; };
    struct AicpuStartPara para{};
    EXPECT_EQ(PROFILING_FAILED, AdprofAicpuStartRegister(callback, &para));
}
