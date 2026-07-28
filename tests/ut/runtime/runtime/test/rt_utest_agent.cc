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
__THREAD_LOCAL__ const void* g_lastDataPtr = nullptr;
__THREAD_LOCAL__ bool g_lastSuccess = false;
constexpr uint32_t COMPACT_INFO_CAPTURE_NUM = 4U;
__THREAD_LOCAL__ uint32_t g_compactCount = 0U;
__THREAD_LOCAL__ MsprofCompactInfo g_compactInfos[COMPACT_INFO_CAPTURE_NUM] = {};

class ProfilingAgentTest : public testing::Test {
protected:
    static void SetUpTestCase() { std::cout << "ProfilingAgentTest SetUP" << std::endl; }

    static void TearDownTestCase() { std::cout << "ProfilingAgentTest Tear Down" << std::endl; }

    virtual void SetUp()
    {
        ProfilingAgent::Instance().SetMsprofReporterCallback(nullptr);
        ResetLastInfo();
    }

    virtual void TearDown() { GlobalMockObject::verify(); }

    void ResetLastInfo()
    {
        g_lastModelId = UINT32_MAX;
        g_lastType = UINT32_MAX;
        g_lastLen = 0;
        g_lastDataPtr = nullptr;
        g_lastSuccess = false;
        g_compactCount = 0U;
        for (uint32_t i = 0U; i < COMPACT_INFO_CAPTURE_NUM; ++i) {
            g_compactInfos[i] = {};
        }
    }
};

int32_t MsprofReporterCallbackSuccessStub(uint32_t moduleId, uint32_t type, void* data, uint32_t len)
{
    g_lastModelId = moduleId;
    g_lastType = type;
    g_lastDataPtr = nullptr;
    g_lastLen = 0;
    if (type == MSPROF_REPORTER_REPORT) {
        const ReporterData* reporterData = (const ReporterData*)data;
        if (reporterData != nullptr) {
            g_lastDataPtr = reporterData->data;
            g_lastLen = reporterData->dataLen;
        }
    }
    g_lastSuccess = true;
    return MSPROF_ERROR_NONE;
}

int32_t MsprofReporterCallbackErrorStub(uint32_t moduleId, uint32_t type, void* data, uint32_t len)
{
    g_lastModelId = moduleId;
    g_lastType = type;
    g_lastDataPtr = nullptr;
    g_lastLen = 0;
    if (type == MSPROF_REPORTER_REPORT) {
        const ReporterData* reporterData = (const ReporterData*)data;
        if (reporterData != nullptr) {
            g_lastDataPtr = reporterData->data;
            g_lastLen = reporterData->dataLen;
        }
    }
    g_lastSuccess = false;
    return MSPROF_ERROR;
}

int32_t MsprofReportCompactInfoCaptureStub(uint32_t agingFlag, const VOID_PTR data, uint32_t length)
{
    if ((data != nullptr) && (length == sizeof(MsprofCompactInfo)) && (g_compactCount < COMPACT_INFO_CAPTURE_NUM)) {
        g_compactInfos[g_compactCount] = *static_cast<const MsprofCompactInfo*>(data);
    }
    ++g_compactCount;
    return MSPROF_ERROR_NONE;
}

TEST_F(ProfilingAgentTest, PROF_NULL)
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

TEST_F(ProfilingAgentTest, PROF_API_SUCCESS)
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

TEST_F(ProfilingAgentTest, PROF_TaskTrack_SUCCESS)
{
    ProfilingAgent::Instance().SetMsprofReporterCallback(MsprofReporterCallbackSuccessStub);
    rtError_t ret = ProfilingAgent::Instance().Init();
    ASSERT_EQ(ret, RT_ERROR_NONE);

    ResetLastInfo();

    ResetLastInfo();

    ret = ProfilingAgent::Instance().UnInit();
    ASSERT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(ProfilingAgentTest, PROF_INIT_FAIL)
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

TEST_F(ProfilingAgentTest, PROF_INIT_MSPROF_API_FAIL)
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

TEST_F(ProfilingAgentTest, PROF_REPORT_PROF_API_FAIL)
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

TEST_F(ProfilingAgentTest, PROF_REPORT_FAIL)
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

TEST_F(ProfilingAgentTest, PROF_REPORT_EXT_MEMCPY_INFO)
{
    MOCKER(MsprofReportCompactInfo).stubs().will(invoke(MsprofReportCompactInfoCaptureStub));
    RuntimeProfApiData profData = {};
    profData.threadId = 10U;
    profData.entryTime = 100U;
    profData.exitTime = 200U;
    profData.profileType = RT_PROF_API_MEM_CPY;
    profData.extInfoCount = 1U;
    profData.extInfos[0].extInfoType = RT_PROFILE_TYPE_MEMCPY_EXT_INFO;
    profData.extInfos[0].extInfo.memcpyInfo.bytes = 1024U;
    profData.extInfos[0].extInfo.memcpyInfo.copyKind = RT_MEMCPY_HOST_TO_DEVICE;
    profData.extInfos[0].extInfo.memcpyInfo.deviceId = 2U;
    profData.extInfos[0].extInfo.memcpyInfo.streamId = 3U;

    ProfilingAgent::Instance().ReportProfApi(0, profData);

    ASSERT_EQ(g_compactCount, 1U);
    EXPECT_EQ(g_compactInfos[0].type, RT_PROFILE_TYPE_MEMCPY_EXT_INFO);
    EXPECT_EQ(g_compactInfos[0].dataLen, sizeof(MsprofMemcpyInfo));
    EXPECT_EQ(g_compactInfos[0].data.memcpyInfo.bytes, 1024U);
    EXPECT_EQ(g_compactInfos[0].data.memcpyInfo.copyKind, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(g_compactInfos[0].data.memcpyInfo.deviceId, 2U);
    EXPECT_EQ(g_compactInfos[0].data.memcpyInfo.streamId, 3U);
}

TEST_F(ProfilingAgentTest, PROF_REPORT_EXT_MEMSET_INFO)
{
    MOCKER(MsprofReportCompactInfo).stubs().will(invoke(MsprofReportCompactInfoCaptureStub));
    RuntimeProfApiData profData = {};
    profData.threadId = 11U;
    profData.entryTime = 100U;
    profData.exitTime = 200U;
    profData.profileType = RT_PROF_API_Memset;
    profData.extInfoCount = 1U;
    profData.extInfos[0].extInfoType = RT_PROFILE_TYPE_MEMSET_INFO;
    profData.extInfos[0].extInfo.memsetInfo.bytes = 2048U;
    profData.extInfos[0].extInfo.memsetInfo.value = -1;
    profData.extInfos[0].extInfo.memsetInfo.deviceId = 4U;
    profData.extInfos[0].extInfo.memsetInfo.streamId = 5U;
    profData.extInfos[0].extInfo.memsetInfo.rsv[0] = 0U;
    profData.extInfos[0].extInfo.memsetInfo.rsv[1] = 0U;
    profData.extInfos[0].extInfo.memsetInfo.rsv[2] = 0U;

    ProfilingAgent::Instance().ReportProfApi(0, profData);

    ASSERT_EQ(g_compactCount, 1U);
    EXPECT_EQ(g_compactInfos[0].type, RT_PROFILE_TYPE_MEMSET_INFO);
    EXPECT_EQ(g_compactInfos[0].dataLen, sizeof(MsprofMemsetInfo));
    EXPECT_EQ(g_compactInfos[0].data.memsetInfo.bytes, 2048U);
    EXPECT_EQ(g_compactInfos[0].data.memsetInfo.value, -1);
    EXPECT_EQ(g_compactInfos[0].data.memsetInfo.deviceId, 4U);
    EXPECT_EQ(g_compactInfos[0].data.memsetInfo.streamId, 5U);
    EXPECT_EQ(g_compactInfos[0].data.memsetInfo.rsv[0], 0U);
    EXPECT_EQ(g_compactInfos[0].data.memsetInfo.rsv[1], 0U);
    EXPECT_EQ(g_compactInfos[0].data.memsetInfo.rsv[2], 0U);
}

TEST_F(ProfilingAgentTest, PROF_REPORT_EXT_MEMMNG_INFO)
{
    MOCKER(MsprofReportCompactInfo).stubs().will(invoke(MsprofReportCompactInfoCaptureStub));
    RuntimeProfApiData profData = {};
    profData.threadId = 12U;
    profData.entryTime = 300U;
    profData.exitTime = 400U;
    profData.profileType = RT_PROF_API_DEV_MALLOC;
    profData.extInfoCount = 1U;
    profData.extInfos[0].extInfoType = RT_PROFILE_TYPE_MEMMNG_INFO;
    profData.extInfos[0].extInfo.memMngInfo.address = 0x1234U;
    profData.extInfos[0].extInfo.memMngInfo.size = 4096U;
    profData.extInfos[0].extInfo.memMngInfo.memoryType = MSPROF_MEMORY_TYPE_DEVICE;
    profData.extInfos[0].extInfo.memMngInfo.memMngType = RT_PROF_MEM_MNG_TYPE_MALLOC;
    profData.extInfos[0].extInfo.memMngInfo.deviceId = 6U;
    profData.extInfos[0].extInfo.memMngInfo.streamId = 7U;
    profData.extInfos[0].extInfo.memMngInfo.rsv = 0U;

    ProfilingAgent::Instance().ReportProfApi(0, profData);

    ASSERT_EQ(g_compactCount, 1U);
    EXPECT_EQ(g_compactInfos[0].type, RT_PROFILE_TYPE_MEMMNG_INFO);
    EXPECT_EQ(g_compactInfos[0].dataLen, sizeof(MsprofMemMngInfo));
    EXPECT_EQ(g_compactInfos[0].data.memMngInfo.address, 0x1234U);
    EXPECT_EQ(g_compactInfos[0].data.memMngInfo.size, 4096U);
    EXPECT_EQ(g_compactInfos[0].data.memMngInfo.memoryType, MSPROF_MEMORY_TYPE_DEVICE);
    EXPECT_EQ(g_compactInfos[0].data.memMngInfo.memMngType, RT_PROF_MEM_MNG_TYPE_MALLOC);
    EXPECT_EQ(g_compactInfos[0].data.memMngInfo.deviceId, 6U);
    EXPECT_EQ(g_compactInfos[0].data.memMngInfo.streamId, 7U);
    EXPECT_EQ(g_compactInfos[0].data.memMngInfo.rsv, 0U);
}

TEST_F(ProfilingAgentTest, PROF_REPORT_UNKNOWN_EXT_INFO)
{
    MOCKER(MsprofReportCompactInfo).stubs().will(invoke(MsprofReportCompactInfoCaptureStub));
    RuntimeProfApiData profData = {};
    profData.threadId = 13U;
    profData.entryTime = 100U;
    profData.exitTime = 200U;
    profData.profileType = RT_PROF_API_MEM_CPY;
    profData.extInfoCount = 1U;
    profData.extInfos[0].extInfoType = RT_PROFILE_TYPE_MAX;

    ProfilingAgent::Instance().ReportProfApi(0, profData);

    EXPECT_EQ(g_compactCount, 0U);
}

TEST_F(ProfilingAgentTest, PROF_REPORT_BATCH_EXT_MEMCPY_INFO)
{
    MOCKER(MsprofReportCompactInfo).stubs().will(invoke(MsprofReportCompactInfoCaptureStub));
    RuntimeProfApiData profData = {};
    profData.threadId = 14U;
    profData.entryTime = 100U;
    profData.exitTime = 200U;
    profData.profileType = RT_PROF_API_MEMCPY_BATCH;
    profData.extInfoCount = 2U;
    profData.extInfos[0].extInfoType = RT_PROFILE_TYPE_MEMCPY_EXT_INFO;
    profData.extInfos[0].extInfo.memcpyInfo.bytes = 30U;
    profData.extInfos[0].extInfo.memcpyInfo.copyKind = RT_MEMCPY_KIND_HOST_TO_DEVICE;
    profData.extInfos[1].extInfoType = RT_PROFILE_TYPE_MEMCPY_EXT_INFO;
    profData.extInfos[1].extInfo.memcpyInfo.bytes = 40U;
    profData.extInfos[1].extInfo.memcpyInfo.copyKind = RT_MEMCPY_KIND_DEVICE_TO_HOST;

    ProfilingAgent::Instance().ReportProfApi(0, profData);

    ASSERT_EQ(g_compactCount, 2U);
    EXPECT_EQ(g_compactInfos[0].type, RT_PROFILE_TYPE_MEMCPY_EXT_INFO);
    EXPECT_EQ(g_compactInfos[0].data.memcpyInfo.bytes, 30U);
    EXPECT_EQ(g_compactInfos[0].data.memcpyInfo.copyKind, RT_MEMCPY_KIND_HOST_TO_DEVICE);
    EXPECT_EQ(g_compactInfos[0].timeStamp, 101U);
    EXPECT_EQ(g_compactInfos[1].type, RT_PROFILE_TYPE_MEMCPY_EXT_INFO);
    EXPECT_EQ(g_compactInfos[1].data.memcpyInfo.bytes, 40U);
    EXPECT_EQ(g_compactInfos[1].data.memcpyInfo.copyKind, RT_MEMCPY_KIND_DEVICE_TO_HOST);
    EXPECT_EQ(g_compactInfos[1].timeStamp, 102U);
}
} // namespace RuntTimeUtest
