/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <securec.h>
#define private public
#include "aicpu_error_log.h"
#include "aicpu_error_log_api.h"
#undef private
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

using namespace aicpu;

class AicpuErrorLogTest : public ::testing::Test {
public:
    virtual void SetUp() {}

    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(AicpuErrorLogTest, RestoreErrorLogSuccess) {
    AicpuErrorLog logs;
    va_list ap;
    logs.RestoreErrorLog("RestoreErrorLogSuccess", "log_test.cpp", 1234, 1, "cust aicpu test log", ap);
    EXPECT_EQ(logs.GetErrorLogSize(), 1);
    logs.PrintErrorLog();
}

TEST_F(AicpuErrorLogTest, RestoreErrorLogParaInvalid) {
    AicpuErrorLog logs;
    va_list ap;
    logs.RestoreErrorLog(nullptr, "log_test.cpp", 1234, 1, "cust aicpu test log", ap);
    EXPECT_EQ(logs.GetErrorLogSize(), 0);
}

TEST_F(AicpuErrorLogTest, RestoreErrorLogMemSetFail) {
    MOCKER(memset_s).stubs().will(returnValue(-1));
    AicpuErrorLog logs;
    va_list ap;
    logs.RestoreErrorLog("RestoreErrorLogSuccess", "log_test.cpp", 1234, 1, "cust aicpu test log", ap);
    EXPECT_EQ(logs.GetErrorLogSize(), 0);
}

TEST_F(AicpuErrorLogTest, RestoreErrorLogStrFmtFail) {
    std::string longStr = "";
    for (uint32_t i = 0; i < 65U; ++i) {
        longStr.append(std::to_string(i));
        longStr.append(std::to_string(i));
        longStr.append(std::to_string(i));
        longStr.append(std::to_string(i));
    }

    AicpuErrorLog logs;
    va_list ap;
    logs.RestoreErrorLog("RestoreErrorLogSuccess", "log_test.cpp", 1234, 1, longStr.c_str(), ap);
    EXPECT_EQ(logs.GetErrorLogSize(), 0);
    PrintErrorLog();
}

TEST_F(AicpuErrorLogTest, RestoreErrorLogApiNullptr) {
    RestoreErrorLog("RestoreErrorLogSuccess", "log_test.cpp", 1234, 1, "cust aicpu test log");
    EXPECT_EQ(HasErrorLog(), false);
    PrintErrorLog();
}

TEST_F(AicpuErrorLogTest, RestoreErrorLogApiSuccess) {
    InitAicpuErrorLog();
    RestoreErrorLog("RestoreErrorLogSuccess", "log_test.cpp", 1234, 1, "cust aicpu test log");
    EXPECT_EQ(HasErrorLog(), true);
    PrintErrorLog();
}
