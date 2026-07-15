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
#include "driver/ascend_hal.h"
#define private public
#define protected public
#include "module.hpp"
#include "device.hpp"
#include "program.hpp"
#include "runtime.hpp"
#include "common/rt_utest_context_reset_helper.hpp"

#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

class ModuleTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {

    }

    static void TearDownTestCase()
    {

    }

    virtual void SetUp()
    {
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        ut::ResetPrimaryDeviceIfActiveWithDeviceDown();
    }
};

class TestProgram : public Program
{
public:
    TestProgram()
    {
        machine_ = RT_KERNEL_ATTR_TYPE_AICORE;
        offset_ = 0;
        loadSize_ = 100;
        extractResult_ = RT_ERROR_NONE;
    }

    uint32_t SymbolOffset(const void *symbol)
    {
        return offset_;
    }
    uint32_t LoadSize()
    {
        return loadSize_;
    }
    rtError_t LoadExtract(void *output, uint32_t size)
    {
        return extractResult_;
    }
    void *Data()
    {
        return binary_;
    }

    uint32_t offset_;
    uint32_t loadSize_;
    rtError_t extractResult_;
};

TEST_F(ModuleTest, TearDownIsIdempotent)
{
    // Empty-resource module verifies host state reset and repeated TearDown no-op without entering device free paths.
    Module module(nullptr);
    module.baseAddrAlign_ = reinterpret_cast<void *>(0x1000);
    module.baseFMAddr_ = reinterpret_cast<void *>(0x2000);
    module.baseAddrSize_ = 64U;
    module.programId_ = 1U;

    module.TearDown();

    EXPECT_EQ(module.device_, nullptr);
    EXPECT_EQ(module.baseAddr_, nullptr);
    EXPECT_EQ(module.baseFMAddr_, nullptr);
    EXPECT_EQ(module.baseAddrAlign_, nullptr);
    EXPECT_EQ(module.kernelNamesBaseAddr_, nullptr);
    EXPECT_EQ(module.soNamesBaseAddr_, nullptr);
    EXPECT_EQ(module.baseAddrSize_, 0U);
    EXPECT_EQ(module.programId_, UINT32_MAX);

    module.TearDown();

    EXPECT_EQ(module.device_, nullptr);
    EXPECT_EQ(module.baseAddr_, nullptr);
    EXPECT_EQ(module.baseFMAddr_, nullptr);
    EXPECT_EQ(module.baseAddrAlign_, nullptr);
    EXPECT_EQ(module.kernelNamesBaseAddr_, nullptr);
    EXPECT_EQ(module.soNamesBaseAddr_, nullptr);
    EXPECT_EQ(module.baseAddrSize_, 0U);
    EXPECT_EQ(module.programId_, UINT32_MAX);
}
