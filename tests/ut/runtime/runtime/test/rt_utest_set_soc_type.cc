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
#define private public
#include "runtime.hpp"
#include "runtime_keeper.h"
#include "npu_driver.hpp"
#include "api_impl.hpp"
#include "program.hpp"
#include "profiler.hpp"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "raw_device.hpp"
#include "platform/platform_info.h"
#include "soc_info.h"
#include "thread_local_container.hpp"

#undef private

using namespace testing;
using namespace cce::runtime;

class RuntimeSetSocTypeTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {}

    static void TearDownTestCase()
    {}

    virtual void SetUp()
    {

    }

    virtual void TearDown()
    {
    }
};

TEST_F(RuntimeSetSocTypeTest, SetSocTypeByChipType_test_for_david_v120)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    EXPECT_NE(rtInstance, nullptr);
 
    int64_t aicoreNumLevel = 0;
    int64_t vmAicoreNum = 0;
    rtError_t result = RT_ERROR_NONE;
 
    rtInstance->chipType_ = CHIP_DAVID;
    result = rtInstance->SetSocTypeByChipType((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN24)), aicoreNumLevel, vmAicoreNum);
    EXPECT_EQ(result, RT_ERROR_NONE);
 
    result = rtInstance->SetSocTypeByChipType((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN25)), aicoreNumLevel, vmAicoreNum);
    EXPECT_EQ(result, RT_ERROR_NONE);
 
    result = rtInstance->SetSocTypeByChipType((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN26)), aicoreNumLevel, vmAicoreNum);
    EXPECT_EQ(result, RT_ERROR_NONE);
 
    result = rtInstance->SetSocTypeByChipType((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN27)), aicoreNumLevel, vmAicoreNum);
    EXPECT_EQ(result, RT_ERROR_NONE);
 
    result = rtInstance->SetSocTypeByChipType((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN28)), aicoreNumLevel, vmAicoreNum);
    EXPECT_EQ(result, RT_ERROR_NONE);
 
    result = rtInstance->SetSocTypeByChipType((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN29)), aicoreNumLevel, vmAicoreNum);
    EXPECT_EQ(result, RT_ERROR_NONE);
 
    result = rtInstance->SetSocTypeByChipType((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN30)), aicoreNumLevel, vmAicoreNum);
    EXPECT_EQ(result, RT_ERROR_NONE);
 
    result = rtInstance->SetSocTypeByChipType((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN31)), aicoreNumLevel, vmAicoreNum);
    EXPECT_EQ(result, RT_ERROR_NONE);
 
    result = rtInstance->SetSocTypeByChipType((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN32)), aicoreNumLevel, vmAicoreNum);
    EXPECT_EQ(result, RT_ERROR_NONE);
 
    result = rtInstance->SetSocTypeByChipType((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN33)), aicoreNumLevel, vmAicoreNum);
    EXPECT_EQ(result, RT_ERROR_NONE);
}
