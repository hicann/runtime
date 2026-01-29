/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mockcpp/ChainingMockHelper.h"
#define private public
#define protected public
#include "inc/log.h"
#undef private
#undef protected
#include "slog.h"
#include "tsd/status.h"
#include "driver/ascend_hal.h"

using namespace std;
using namespace tsd;

class LogUnitTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        while (!tsd::TSDLog::GetInstance()->errorList_.empty()) {
            tsd::TSDLog::GetInstance()->errorList_.pop();
        }
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};


int vsnprintf_stub(char *strDest, size_t destMax, size_t count, const char *format,
                   va_list argList)
{
    return -1;
}


TEST_F(LogUnitTest, RestoreErrorMsgSuccess)
{
    tsd::TSDLog::GetInstance()->RestoreErrorMsg(&__FUNCTION__[0], "log_test.cpp", 1234, "tsdaemon test log");
    EXPECT_EQ(tsd::TSDLog::GetInstance()->errorList_.size() > 20UL, false);
}

TEST_F(LogUnitTest, GetErrorMsgSuccess)
{
    tsd::TSDLog::GetInstance()->RestoreErrorMsg(&__FUNCTION__[0], "log_test.cpp", 1234, "tsdaemon test log");
    const std::string errorLog = tsd::TSDLog::GetInstance()->GetErrorMsg();
    EXPECT_STREQ(errorLog.c_str(), "tsdaemon test log,[log_test.cpp:1234:TestBody]1\n");
}

TEST_F(LogUnitTest, RestoreErrorMsgMemSetFail)
{
    MOCKER(memset_s).stubs().will(returnValue(-1));
    tsd::TSDLog::GetInstance()->RestoreErrorMsg(&__FUNCTION__[0], "log_test.cpp", 1234, "tsdaemon test log");
    EXPECT_EQ(tsd::TSDLog::GetInstance()->errorList_.size() > 20UL, false);
}

TEST_F(LogUnitTest, RestoreErrorMsgStrFmtFail)
{
    MOCKER(vsnprintf_s).stubs().will(invoke(vsnprintf_stub));
    tsd::TSDLog::GetInstance()->RestoreErrorMsg(&__FUNCTION__[0], "log_test.cpp", 1234, "tsdaemon test log");
    EXPECT_EQ(tsd::TSDLog::GetInstance()->errorList_.size() > 20UL, false);
}

/* EOF */
