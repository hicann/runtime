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
#include "prof_avp_plugin.h"
#include "aprof_pub.h"
#include "prof_api.h"
#include "error_code.h"
#include <limits>

using namespace ProfAPI;
using analysis::dvvp::common::error::PROFILING_FAILED;

class PROF_AVP_PLUGIN_UTEST : public testing::Test {
protected:
    virtual void SetUp() {
        MOCKER(dlsym).stubs().will(returnValue((void *)nullptr));
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(PROF_AVP_PLUGIN_UTEST, ProfApiInit_dlopen_fail)
{
    MOCKER(dlopen).stubs().will(returnValue((void *)nullptr));
    ProfAvpPlugin::instance()->ProfApiInit();
}

TEST_F(PROF_AVP_PLUGIN_UTEST, ProfInit)
{
    EXPECT_EQ(0, ProfAvpPlugin::instance()->ProfInit(0, nullptr, 0));
}

TEST_F(PROF_AVP_PLUGIN_UTEST, ProfRegisterCallback_nullptr_handle)
{
    EXPECT_EQ(-1, ProfAvpPlugin::instance()->ProfRegisterCallback(0, nullptr));
}

TEST_F(PROF_AVP_PLUGIN_UTEST, ProfRegisterCallback_valid_handle)
{
    auto handle = [](uint32_t, void *, uint32_t) -> int32_t { return 0; };
    EXPECT_EQ(0, ProfAvpPlugin::instance()->ProfRegisterCallback(1, handle));
}

TEST_F(PROF_AVP_PLUGIN_UTEST, ProfReportApi)
{
    MsprofApi api{};
    EXPECT_EQ(0, ProfAvpPlugin::instance()->ProfReportApi(0, api));
}

TEST_F(PROF_AVP_PLUGIN_UTEST, ProfReportEvent)
{
    MsprofEvent event{};
    EXPECT_EQ(0, ProfAvpPlugin::instance()->ProfReportEvent(0, event));
}

TEST_F(PROF_AVP_PLUGIN_UTEST, ProfReportCompactInfo)
{
    EXPECT_EQ(0, ProfAvpPlugin::instance()->ProfReportCompactInfo(0, (void*)"data", 4));
}

TEST_F(PROF_AVP_PLUGIN_UTEST, ProfReportAdditionalInfo)
{
    EXPECT_EQ(0, ProfAvpPlugin::instance()->ProfReportAdditionalInfo(0, (void*)"data", 4));
}

TEST_F(PROF_AVP_PLUGIN_UTEST, ProfReportRegTypeInfo)
{
    EXPECT_EQ(0, ProfAvpPlugin::instance()->ProfReportRegTypeInfo(0, 1, "type"));
}

TEST_F(PROF_AVP_PLUGIN_UTEST, ProfReportGetHashId)
{
    EXPECT_EQ(0U, ProfAvpPlugin::instance()->ProfReportGetHashId("hash", 4));
}

TEST_F(PROF_AVP_PLUGIN_UTEST, ProfNotifySetDevice)
{
    EXPECT_EQ(0, ProfAvpPlugin::instance()->ProfNotifySetDevice(1, 2, true));
}

TEST_F(PROF_AVP_PLUGIN_UTEST, ProfFinalize)
{
    EXPECT_EQ(0, ProfAvpPlugin::instance()->ProfFinalize());
}

TEST_F(PROF_AVP_PLUGIN_UTEST, ProfSysCycleTime)
{
    EXPECT_EQ(0U, ProfAvpPlugin::instance()->ProfSysCycleTime());
}

class PROF_AVP_INNER_API_UTEST : public testing::Test {
protected:
    virtual void SetUp() {
        MOCKER(dlsym).stubs().will(returnValue((void *)nullptr));
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(PROF_AVP_INNER_API_UTEST, MsprofInit)
{
    EXPECT_EQ(0, MsprofInit(0, nullptr, 0));
}

TEST_F(PROF_AVP_INNER_API_UTEST, MsprofFinalize)
{
    EXPECT_EQ(0, MsprofFinalize());
}

TEST_F(PROF_AVP_INNER_API_UTEST, MsprofNotifySetDevice)
{
    EXPECT_EQ(0, MsprofNotifySetDevice(1, 2, true));
}

TEST_F(PROF_AVP_INNER_API_UTEST, MsprofRegisterCallback)
{
    auto handle = [](uint32_t, void *, uint32_t) -> int32_t { return 0; };
    EXPECT_EQ(0, MsprofRegisterCallback(0, handle));
}

TEST_F(PROF_AVP_INNER_API_UTEST, MsprofReportEvent_nullptr)
{
    EXPECT_EQ(PROFILING_FAILED, MsprofReportEvent(0, nullptr));
}

TEST_F(PROF_AVP_INNER_API_UTEST, MsprofReportEvent_valid)
{
    MsprofEvent event{};
    EXPECT_EQ(0, MsprofReportEvent(0, &event));
}

TEST_F(PROF_AVP_INNER_API_UTEST, MsprofReportApi_nullptr)
{
    EXPECT_EQ(PROFILING_FAILED, MsprofReportApi(0, nullptr));
}

TEST_F(PROF_AVP_INNER_API_UTEST, MsprofReportApi_valid)
{
    MsprofApi api{};
    EXPECT_EQ(0, MsprofReportApi(0, &api));
}

TEST_F(PROF_AVP_INNER_API_UTEST, MsprofReportCompactInfo_nullptr)
{
    EXPECT_EQ(PROFILING_FAILED, MsprofReportCompactInfo(0, nullptr, 0));
}

TEST_F(PROF_AVP_INNER_API_UTEST, MsprofReportCompactInfo_valid)
{
    EXPECT_EQ(0, MsprofReportCompactInfo(0, (void*)"data", 4));
}

TEST_F(PROF_AVP_INNER_API_UTEST, MsprofReportAdditionalInfo_nullptr)
{
    EXPECT_EQ(PROFILING_FAILED, MsprofReportAdditionalInfo(0, nullptr, 0));
}

TEST_F(PROF_AVP_INNER_API_UTEST, MsprofReportAdditionalInfo_valid)
{
    EXPECT_EQ(0, MsprofReportAdditionalInfo(0, (void*)"data", 4));
}

TEST_F(PROF_AVP_INNER_API_UTEST, MsprofRegTypeInfo_nullptr)
{
    EXPECT_EQ(PROFILING_FAILED, MsprofRegTypeInfo(0, 1, nullptr));
}

TEST_F(PROF_AVP_INNER_API_UTEST, MsprofRegTypeInfo_valid)
{
    EXPECT_EQ(0, MsprofRegTypeInfo(0, 1, "type"));
}

TEST_F(PROF_AVP_INNER_API_UTEST, MsprofGetHashId_nullptr)
{
    EXPECT_EQ(std::numeric_limits<uint64_t>::max(), MsprofGetHashId(nullptr, 0));
}

TEST_F(PROF_AVP_INNER_API_UTEST, MsprofGetHashId_valid)
{
    EXPECT_EQ(0U, MsprofGetHashId("hash", 4));
}

TEST_F(PROF_AVP_INNER_API_UTEST, MsprofSysCycleTime)
{
    EXPECT_EQ(0U, MsprofSysCycleTime());
}
