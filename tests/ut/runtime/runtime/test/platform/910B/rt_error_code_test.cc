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
#include "runtime/rt.h"
#include "error_code.h"
#include "errcode_manage.hpp"
#include "runtime.hpp"
#include "rt_log.h"
using namespace testing;
using namespace cce::runtime;
class CloudV2RtErrorCodeTest : public Test {
protected:
    static void SetUpTestCase()
    {}

    static void TearDownTestCase()
    {}

    virtual void SetUp()
    {}

    virtual void TearDown()
    {}
};

TEST_F(CloudV2RtErrorCodeTest, GetTsErrModuleType)
{
    EXPECT_EQ(GetTsErrModuleType(TS_SUCCESS), ERR_MODULE_RTS);
}

TEST_F(CloudV2RtErrorCodeTest, GetTsErrModuleTypeNotFind)
{
    EXPECT_EQ(GetTsErrModuleType(TS_ERROR_RESERVED + 1), ERR_MODULE_RTS);
}

TEST_F(CloudV2RtErrorCodeTest, GetTsErrCodeDescNotFind)
{
    RecordErrorLog(__FILE__, __LINE__, __FUNCTION__,  "%s", "unknown error");
    RecordLog(DLOG_DEBUG, __FILE__, __LINE__, __FUNCTION__,  "%s", "unknown error");
    EXPECT_EQ(strcmp(GetTsErrCodeDesc(TS_ERROR_RESERVED + 1), "unknown error"), 0);
}

TEST_F(CloudV2RtErrorCodeTest, GetTsErrDescByRtErr)
{
    RecordErrorLog(__FILE__, __LINE__, __FUNCTION__, nullptr);
    RecordLog(DLOG_DEBUG, __FILE__, __LINE__, __FUNCTION__,  nullptr);
    EXPECT_EQ(strcmp(GetTsErrDescByRtErr(RT_ERROR_NONE), "success"), 0);
}