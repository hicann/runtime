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
#include "acl_base_rt.h"
#include "dev_info_manage.h"
#include "soc_info.h"
#include "platform_manager_v2.h"
#include "feature_type.h"
#include "runtime.hpp"
#include "kernel.hpp"
#include "arch9201/aic_aiv_sqe.h"
#include "arch9201/arch9201_sqe_utils.hpp"

using namespace cce::runtime;

static rtError_t StubGetChipTypeFromPlatform(const char_t* const socName, rtChipType_t& chipType)
{
    (void)socName;
    chipType = CHIP_CLOUD_V5;
    return RT_ERROR_NONE;
}

class Ost960Test : public testing::Test {
protected:
    static void SetUpTestCase() {}

    virtual void SetUp()
    {
        MOCKER(GetChipTypeFromPlatform).stubs().will(invoke(StubGetChipTypeFromPlatform));
        (void)rtSetDevice(0);
        Runtime::Instance()->SetEnableOstFlag(false);
    }

    virtual void TearDown()
    {
        Runtime::Instance()->SetEnableOstFlag(false);
        (void)rtDeviceReset(0);
        GlobalMockObject::verify();
    }
};

TEST_F(Ost960Test, EnableOst)
{
    rtError_t ret = rtSetSysParamOpt(SYS_OPT_ENABLE_KERNEL_EARLY_START, SYS_OPT_ENABLE);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_TRUE(Runtime::Instance()->GetEnableOstFlag());
}

TEST_F(Ost960Test, DisableOst)
{
    rtError_t ret = rtSetSysParamOpt(SYS_OPT_ENABLE_KERNEL_EARLY_START, SYS_OPT_ENABLE);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_TRUE(Runtime::Instance()->GetEnableOstFlag());

    ret = rtSetSysParamOpt(SYS_OPT_ENABLE_KERNEL_EARLY_START, SYS_OPT_DISABLE);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_FALSE(Runtime::Instance()->GetEnableOstFlag());
}

TEST_F(Ost960Test, SetOstRejectsInvalidSysParamValueAndKeepsFlag)
{
    EXPECT_EQ(rtSetSysParamOpt(SYS_OPT_ENABLE_KERNEL_EARLY_START, SYS_OPT_ENABLE), RT_ERROR_NONE);
    EXPECT_TRUE(Runtime::Instance()->GetEnableOstFlag());

    EXPECT_EQ(
        rtSetSysParamOpt(SYS_OPT_ENABLE_KERNEL_EARLY_START, static_cast<int64_t>(SYS_OPT_MAX)),
        ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_TRUE(Runtime::Instance()->GetEnableOstFlag());

    EXPECT_EQ(rtSetSysParamOpt(SYS_OPT_ENABLE_KERNEL_EARLY_START, -1), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_TRUE(Runtime::Instance()->GetEnableOstFlag());
}

TEST_F(Ost960Test, ConfigArch9201OstEnableWithKernelEarlyStart)
{
    Kernel kernel("ost_kernel", 0ULL, nullptr, RT_KERNEL_ATTR_TYPE_AICORE, 0U);
    RtArch9201StarsAicAivKernelSqe sqe = {};

    kernel.SetEarlyStartEnable(false);
    ConfigArch9201OstEnable(&kernel, &sqe);
    EXPECT_EQ(sqe.ost, 0U);

    kernel.SetEarlyStartEnable(true);
    ConfigArch9201OstEnable(&kernel, &sqe);
    EXPECT_EQ(sqe.ost, 1U);
}

TEST_F(Ost960Test, ConfigArch9201OstEnableWithNullKernel)
{
    RtArch9201StarsAicAivKernelSqe sqe = {};
    sqe.ost = 1U;

    ConfigArch9201OstEnable(nullptr, &sqe);
    EXPECT_EQ(sqe.ost, 0U);
}

TEST_F(Ost960Test, ConfigArch9201OstEnableKeepsOstWhenPreOrPostPExists)
{
    Kernel kernel("ost_kernel", 0ULL, nullptr, RT_KERNEL_ATTR_TYPE_AICORE, 0U);
    kernel.SetEarlyStartEnable(true);

    RtArch9201StarsAicAivKernelSqe sqe = {};
    sqe.header.preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    ConfigArch9201OstEnable(&kernel, &sqe);
    EXPECT_EQ(sqe.ost, 0U);

    sqe = {};
    sqe.header.postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    ConfigArch9201OstEnable(&kernel, &sqe);
    EXPECT_EQ(sqe.ost, 0U);

    sqe = {};
    sqe.ost = 1U;
    sqe.header.preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    ConfigArch9201OstEnable(&kernel, &sqe);
    EXPECT_EQ(sqe.ost, 1U);

    sqe = {};
    sqe.ost = 1U;
    sqe.header.postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    ConfigArch9201OstEnable(&kernel, &sqe);
    EXPECT_EQ(sqe.ost, 1U);
}
