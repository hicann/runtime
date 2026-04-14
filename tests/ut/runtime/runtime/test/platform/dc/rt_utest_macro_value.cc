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
#include "runtime.hpp"
#include "dev_info_manage.h"

using namespace cce::runtime;

class UpdateDevPropertiesValueTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        GlobalMockObject::verify();
    }

    static void TearDownTestCase()
    {
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(UpdateDevPropertiesValueTest, UpdateDevPropertiesValue)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_NE(rtInstance, nullptr);
    DevProperties props;
    EXPECT_EQ(GET_DEV_PROPERTIES(CHIP_DC, props), RT_ERROR_NONE);
    EXPECT_EQ(props.maxPersistTaskNum, 32760U);
    EXPECT_EQ(props.maxSupportTaskNum, 2091008U);
    EXPECT_EQ(props.stubEventCount, 1024U);
    EXPECT_EQ(props.maxReportTimeoutCnt, 36);
    EXPECT_EQ(props.rtcqDepth, 0U);
    EXPECT_EQ(props.baseAicpuStreamId, 1024U);
    EXPECT_EQ(props.expandStreamRsvTaskNum, 0U);
    EXPECT_EQ(props.expandStreamSqDepthAdapt, 0U);
    EXPECT_EQ(props.expandStreamAdditionalSqeNum, 0U);
    EXPECT_EQ(props.rsvAicpuStreamNum, 0U);
    EXPECT_EQ(props.maxPhysicalStreamNum, 992U);
    EXPECT_EQ(props.maxAllocStreamNum, 992U);
    EXPECT_EQ(props.rtsqDepth, 2048U);
    EXPECT_EQ(props.maxTaskNumPerStream, 2042U);
    EXPECT_EQ(props.rtsqReservedTaskNum, 6U);
}
