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
#include "profiling_agent.hpp"
#include "osal.hpp"

using namespace testing;
using namespace cce::runtime;

namespace RuntTimeUtest {

__THREAD_LOCAL__ uint32_t g_lastModelId = UINT32_MAX;
__THREAD_LOCAL__ uint32_t g_lastType = UINT32_MAX;
__THREAD_LOCAL__ uint32_t g_lastLen = UINT32_MAX;
__THREAD_LOCAL__ const void *g_lastDataPtr = nullptr;
__THREAD_LOCAL__ bool g_lastSuccess = false;

class CloudV2ProfilingAgentTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "ProfilingAgentTest SetUP" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "ProfilingAgentTest Tear Down" << std::endl;
    }

    virtual void SetUp()
    {
        ProfilingAgent::Instance().SetMsprofReporterCallback(nullptr);
        ResetLastInfo();
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }

    void ResetLastInfo()
    {
        g_lastModelId = UINT32_MAX;
        g_lastType = UINT32_MAX;
        g_lastLen = 0;
        g_lastDataPtr = nullptr;
        g_lastSuccess = false;
    }

};

int32_t MsprofReporterCallbackSuccessStub(uint32_t moduleId, uint32_t type, void *data, uint32_t len)
{
    g_lastModelId = moduleId;
    g_lastType = type;
    g_lastDataPtr = nullptr;
    g_lastLen = 0;
    if (type == MSPROF_REPORTER_REPORT) {
        const ReporterData *reporterData = (const ReporterData *) data;
        if (reporterData != nullptr) {
            g_lastDataPtr = reporterData->data;
            g_lastLen = reporterData->dataLen;
        }
    }
    g_lastSuccess = true;
    return MSPROF_ERROR_NONE;
}

int32_t MsprofReporterCallbackErrorStub(uint32_t moduleId, uint32_t type, void *data, uint32_t len)
{
    g_lastModelId = moduleId;
    g_lastType = type;
    g_lastDataPtr = nullptr;
    g_lastLen = 0;
    if (type == MSPROF_REPORTER_REPORT) {
        const ReporterData *reporterData = (const ReporterData *) data;
        if (reporterData != nullptr) {
            g_lastDataPtr = reporterData->data;
            g_lastLen = reporterData->dataLen;
        }
    }
    g_lastSuccess = false;
    return MSPROF_ERROR;
}

TEST_F(CloudV2ProfilingAgentTest, PROF_NULL)
{
    ProfilingAgent::Instance().SetMsprofReporterCallback(nullptr);
    rtError_t ret = ProfilingAgent::Instance().Init();
    ASSERT_EQ(ret, RT_ERROR_NONE);

    RuntimeProfApiData profData = {};
    ProfilingAgent::Instance().ReportProfApi(0, profData);

    EXPECT_EQ(g_lastModelId, UINT32_MAX);
    EXPECT_EQ(g_lastType, UINT32_MAX);
    EXPECT_EQ(g_lastLen, 0);
    EXPECT_EQ(g_lastDataPtr, nullptr);
    EXPECT_FALSE(g_lastSuccess);

    ret = ProfilingAgent::Instance().UnInit();
    ASSERT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2ProfilingAgentTest, PROF_API_SUCCESS)
{
    ProfilingAgent::Instance().SetMsprofReporterCallback(MsprofReporterCallbackSuccessStub);
    rtError_t ret = ProfilingAgent::Instance().Init();
    ASSERT_EQ(ret, RT_ERROR_NONE);

    ResetLastInfo();

    RuntimeProfApiData profData = {};
    ProfilingAgent::Instance().ReportProfApi(0, profData);
    ResetLastInfo();

    ret = ProfilingAgent::Instance().UnInit();
    ASSERT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2ProfilingAgentTest, PROF_TaskTrack_SUCCESS)
{
    ProfilingAgent::Instance().SetMsprofReporterCallback(MsprofReporterCallbackSuccessStub);
    rtError_t ret = ProfilingAgent::Instance().Init();
    ASSERT_EQ(ret, RT_ERROR_NONE);

    ResetLastInfo();

    ResetLastInfo();

    ret = ProfilingAgent::Instance().UnInit();
    ASSERT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2ProfilingAgentTest, PROF_INIT_FAIL)
{
    ProfilingAgent::Instance().SetMsprofReporterCallback(MsprofReporterCallbackErrorStub);
    rtError_t ret = ProfilingAgent::Instance().Init();
    ASSERT_EQ(ret, RT_ERROR_NONE);

    ResetLastInfo();

    RuntimeProfApiData profData = {};
    ProfilingAgent::Instance().ReportProfApi(0, profData);

    ResetLastInfo();

    ret = ProfilingAgent::Instance().UnInit();
    ASSERT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2ProfilingAgentTest, PROF_INIT_MSPROF_API_FAIL)
{
    MOCKER(MsprofRegTypeInfo).stubs().will(returnValue(1));
    rtError_t ret = ProfilingAgent::Instance().Init();
    ASSERT_EQ(ret, RT_ERROR_PROF_OPER);

    MOCKER(MsprofReportData).stubs().will(returnValue(1));
    ret = ProfilingAgent::Instance().Init();
    ASSERT_EQ(ret, RT_ERROR_PROF_OPER);

    ret = ProfilingAgent::Instance().UnInit();
    ASSERT_EQ(ret, RT_ERROR_PROF_OPER);
}

TEST_F(CloudV2ProfilingAgentTest, PROF_REPORT_PROF_API_FAIL)
{
    rtError_t ret = ProfilingAgent::Instance().Init();

    MOCKER(MsprofReportCompactInfo).stubs().will(returnValue(1));
    RuntimeProfApiData profData = {};
    profData.dataSize = 1;
    ProfilingAgent::Instance().ReportProfApi(0, profData);
    MOCKER(MsprofReportApi).stubs().will(returnValue(1));
    ProfilingAgent::Instance().ReportProfApi(0, profData);
    ProfilingAgent::Instance().UnInit();
    ASSERT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2ProfilingAgentTest, PROF_REPORT_FAIL)
{
    ProfilingAgent::Instance().SetMsprofReporterCallback(MsprofReporterCallbackSuccessStub);
    rtError_t ret = ProfilingAgent::Instance().Init();
    ASSERT_EQ(ret, RT_ERROR_NONE);

    ResetLastInfo();

    ProfilingAgent::Instance().SetMsprofReporterCallback(MsprofReporterCallbackErrorStub);
    RuntimeProfApiData profData = {};
    ProfilingAgent::Instance().ReportProfApi(0, profData);

    ResetLastInfo();

    ProfilingAgent::Instance().SetMsprofReporterCallback(MsprofReporterCallbackSuccessStub);
    ret = ProfilingAgent::Instance().UnInit();
    ASSERT_EQ(ret, RT_ERROR_NONE);
}
}
