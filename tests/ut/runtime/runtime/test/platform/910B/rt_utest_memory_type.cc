/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include "mem_base.h"
#include "mem_type.hpp"

using namespace testing;
using namespace cce::runtime;

class MemoryTypeManagerTest : public testing::Test
{
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

TEST_F(MemoryTypeManagerTest, memory_type_test)
{
    rtMemLocationType type = RT_MEMORY_LOC_HOST;
    EXPECT_STREQ(MemLocationTypeToStr(type), "RT_MEMORY_LOCATION_HOST");

    type = RT_MEMORY_LOC_DEVICE;
    EXPECT_STREQ(MemLocationTypeToStr(type), "RT_MEMORY_LOCATION_DEVICE");

    type = RT_MEMORY_LOC_UNREGISTERED;
    EXPECT_STREQ(MemLocationTypeToStr(type), "RT_MEMORY_LOCATION_UNREGISTERED");

    type = RT_MEMORY_LOC_MANAGED;
    EXPECT_STREQ(MemLocationTypeToStr(type), "RT_MEMORY_LOCATION_MANAGED");

    type = RT_MEMORY_LOC_MAX;
    EXPECT_STREQ(MemLocationTypeToStr(type), "RT_MEMORY_LOCATION_MAX");
}