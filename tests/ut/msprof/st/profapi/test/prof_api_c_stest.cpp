/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <dlfcn.h>
#include "mockcpp/mockcpp.hpp"
#include "gtest/gtest.h"
#include "prof_plugin.h"
#include "prof_avp_plugin.h"
#include "prof_api.h"
#include "mmpa_api.h"
class PROF_API_C_STEST : public testing::Test {
protected:
    virtual void SetUp()
    {
        DlStub();
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
    void DlStub()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
    }
};

TEST_F(PROF_API_C_STEST, AvpInnerBase)
{
    const std::string data = "{\"switch\":\"on\"}";
    const char *p = data.c_str();
    EXPECT_EQ(0, MsprofInit(0, (void *)p, data.size()));
    EXPECT_EQ(0, MsprofFinalize());
    EXPECT_EQ(0, MsprofNotifySetDevice(0, 0, 1));
    EXPECT_EQ(-1, MsprofRegisterCallback(0, nullptr));
    EXPECT_EQ(-1, MsprofReportEvent(0, nullptr));
    EXPECT_EQ(-1, MsprofReportApi(0, nullptr));
    EXPECT_EQ(-1, MsprofReportCompactInfo(0, nullptr, 0));
    EXPECT_EQ(-1, MsprofReportAdditionalInfo(0, nullptr, 0));
    EXPECT_EQ(-1, MsprofRegTypeInfo(0, 0, nullptr));
    MsprofApi api;
    MsprofEvent event;
    MsprofCompactInfo compactInfo;
    MsprofAdditionalInfo additionalInfo;
    EXPECT_EQ(0, MsprofReportApi(0, &api));
    EXPECT_EQ(0, MsprofReportEvent(0, &event));
    EXPECT_EQ(0, MsprofReportCompactInfo(0, &compactInfo, sizeof(MsprofCompactInfo)));
    EXPECT_EQ(0, MsprofReportAdditionalInfo(0, &additionalInfo, sizeof(MsprofAdditionalInfo)));
    EXPECT_EQ(0, MsprofGetHashId("test get hash id", 16));
    EXPECT_EQ(std::numeric_limits<uint64_t>::max(), MsprofGetHashId(nullptr, 0));
    EXPECT_EQ(0, MsprofSysCycleTime());
    EXPECT_EQ(0, MsprofRegTypeInfo(0, 0, "node"));
}