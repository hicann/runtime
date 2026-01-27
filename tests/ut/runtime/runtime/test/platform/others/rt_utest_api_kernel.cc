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
#include "config.h"
#include "runtime.hpp"
#include "kernel.h"
#include "rt_error_codes.h"
#include "api_impl.hpp"
#include "api_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "api_profile_decorator.hpp"
#include "dev.h"
#include "profiler.hpp"
#include "binary_loader.hpp"
#include "thread_local_container.hpp"
#undef private

using namespace testing;
using namespace cce::runtime;

class ApiKernelTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"ApiKernelTest test start start. "<<std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout<<"ApiKernelTest test start end. "<<std::endl;

    }

    virtual void SetUp()
    {
        (void)rtSetDevice(0);
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
    }
};

TEST_F(ApiKernelTest, TestRtsRegKernelLaunchFillFuncFailed)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t preChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);

    rtBinHandle binHandle;
    rtKernelLaunchFillFunc callback;
    rtError_t error = rtsRegKernelLaunchFillFunc("testSymbol", callback);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    rtInstance->SetChipType(preChipType);
    GlobalContainer::SetRtChipType(preChipType);
}

TEST_F(ApiKernelTest, TestRtsUnRegKernelLaunchFillFuncFailed)
{
    Runtime *rtInstance = Runtime::Instance();
    rtChipType_t preChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);

    rtBinHandle binHandle;
    rtKernelLaunchFillFunc callback;
    rtError_t error = rtsUnRegKernelLaunchFillFunc("testSymbol");
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    rtInstance->SetChipType(preChipType);
    GlobalContainer::SetRtChipType(preChipType);
}
