/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under
 * the terms and conditions of CANN Open Software License Agreement Version 2.0
 * (the "License"). Please refer to the License for details. You may not use
 * this file except in compliance with the License. THIS SOFTWARE IS PROVIDED ON
 * AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS
 * FOR A PARTICULAR PURPOSE. See LICENSE in the root of the software repository
 * for the full text of the License.
 */

#include <memory>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#include "api_impl_kernel_func.hpp"
#include "base_david.hpp"
#include "common/rt_utest_context_reset_helper.hpp"
#include "elf.hpp"
#include "kernel.hpp"
#include "runtime/rt.h"

using namespace cce::runtime;
using namespace testing;

class ApiKernelFuncTest : public Test {
protected:
    void SetUp() override { ASSERT_EQ(rtSetDevice(0), RT_ERROR_NONE); }

    void TearDown() override
    {
        GlobalMockObject::verify();
        GlobalMockObject::reset();
        ut::ForceResetPrimaryDeviceIfActive();
    }
};

TEST_F(ApiKernelFuncTest, QueryFunctionAddressSizeNameAndBinary)
{
    ApiImplKernelFunc apiKernelFunc;
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    Kernel kernel("testFunction", 0U, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048U, 1024U, 0U, 0U, 0U);
    kernel.SetKernelLength1(64U);
    kernel.SetKernelLength2(32U);

    void* aicAddr = nullptr;
    void* aivAddr = nullptr;
    EXPECT_EQ(apiKernelFunc.FuncGetAddr(&kernel, &aicAddr, &aivAddr), RT_ERROR_NONE);

    size_t aicSize = 0U;
    size_t aivSize = 0U;
    EXPECT_EQ(apiKernelFunc.FuncGetSize(&kernel, &aicSize, &aivSize), RT_ERROR_NONE);
    EXPECT_EQ(aicSize, 64U);
    EXPECT_EQ(aivSize, 32U);

    char_t name[32] = {};
    EXPECT_EQ(apiKernelFunc.FuncGetName(&kernel, sizeof(name), name), RT_ERROR_NONE);
    EXPECT_STREQ(name, "testFunction");

    Program* binHandle = nullptr;
    EXPECT_EQ(apiKernelFunc.FunctionGetBinary(&kernel, &binHandle), RT_ERROR_NONE);
    EXPECT_EQ(binHandle, &program);
}

TEST_F(ApiKernelFuncTest, QueryFunctionAttribute)
{
    ApiImplKernelFunc apiKernelFunc;
    ElfProgram program(RT_KERNEL_ATTR_TYPE_VECTOR);
    Kernel kernel("testFunction", 0U, &program, RT_KERNEL_ATTR_TYPE_VECTOR, 0U, 0U, 0U, 0U, 0U);

    int64_t attrValue = 0;
    EXPECT_EQ(
        apiKernelFunc.FunctionGetAttribute(
            static_cast<rtFuncHandle>(&kernel), RT_FUNCTION_ATTR_KERNEL_TYPE, &attrValue),
        RT_ERROR_NONE);
    EXPECT_EQ(attrValue, static_cast<int64_t>(RT_KERNEL_ATTR_TYPE_VECTOR));

    kernel.SetSchedMode(RT_SCHEM_MODE_BATCH);
    EXPECT_EQ(
        apiKernelFunc.FunctionGetAttribute(
            static_cast<rtFuncHandle>(&kernel), RT_FUNCTION_ATTR_KERNEL_SCHED_MODE, &attrValue),
        RT_ERROR_NONE);
    EXPECT_EQ(attrValue, static_cast<int64_t>(RT_SCHEM_MODE_BATCH));

    EXPECT_EQ(
        apiKernelFunc.FunctionGetAttribute(static_cast<rtFuncHandle>(&kernel), RT_FUNCTION_ATTR_MAX, &attrValue),
        RT_ERROR_INVALID_VALUE);
}

TEST_F(ApiKernelFuncTest, QueryFunctionParameters)
{
    ApiImplKernelFunc apiKernelFunc;
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    Kernel kernel("testFunction", 0U, &program, RT_KERNEL_ATTR_TYPE_AICORE, 0U, 0U, 0U, 0U, 0U);
    kernel.SetHasParamSummary(true);
    kernel.SetParamCount(2U);

    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[2]);
    paramInfos[0].info.offset = 0U;
    paramInfos[0].info.size = 64U;
    paramInfos[1].info.offset = 64U;
    paramInfos[1].info.size = 128U;
    kernel.SetParamInfos(paramInfos);

    size_t paramCount = 0U;
    EXPECT_EQ(apiKernelFunc.FunctionGetParamCount(&kernel, &paramCount), RT_ERROR_NONE);
    EXPECT_EQ(paramCount, 2U);

    size_t paramOffset = 0U;
    size_t paramSize = 0U;
    EXPECT_EQ(apiKernelFunc.FunctionGetParamInfo(&kernel, 1U, &paramOffset, &paramSize), RT_ERROR_NONE);
    EXPECT_EQ(paramOffset, 64U);
    EXPECT_EQ(paramSize, 128U);
    EXPECT_EQ(apiKernelFunc.FunctionGetParamInfo(&kernel, 2U, &paramOffset, &paramSize), RT_ERROR_INVALID_VALUE);
}

TEST_F(ApiKernelFuncTest, QueryAvailableDynamicUbuf)
{
    ApiImplKernelFunc apiKernelFunc;
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    Kernel kernel("testFunction", 0U, &program, RT_KERNEL_ATTR_TYPE_AICORE, 0U, 0U, 0U, 0U, 0U);
    kernel.SetKernelVfType_(static_cast<uint32_t>(AivTypeFlag::AIV_TYPE_SIMT_VF_ONLY));
    kernel.SetShareMemSize_(2048U);

    size_t dynamicUbufSize = 0U;
    EXPECT_EQ(apiKernelFunc.FunctionGetAvailDynUbufPerBlock(&kernel, 0U, &dynamicUbufSize), RT_ERROR_NONE);
    EXPECT_EQ(dynamicUbufSize, static_cast<size_t>(RT_SIMT_REMAIN_UB_SIZE - 2048U));
    EXPECT_EQ(apiKernelFunc.FunctionGetAvailDynUbufPerBlock(&kernel, 1U, &dynamicUbufSize), RT_ERROR_INVALID_VALUE);
}

TEST_F(ApiKernelFuncTest, GetFunctionBySymbolValidatesAndReportsMissingSymbol)
{
    ApiImplKernelFunc apiKernelFunc;
    int symbol = 0;
    Kernel* kernel = nullptr;

    EXPECT_EQ(apiKernelFunc.GetFunctionBySymbol(nullptr, &kernel), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(apiKernelFunc.GetFunctionBySymbol(&symbol, nullptr), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(apiKernelFunc.GetFunctionBySymbol(&symbol, &kernel), RT_ERROR_INVALID_DEVICE_FUNCTION);
}
