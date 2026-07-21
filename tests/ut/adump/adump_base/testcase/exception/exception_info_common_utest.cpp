/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include <cstring>
#include "mockcpp/mockcpp.hpp"
#include "exception_info_common.h"

using namespace Adx;

namespace {
rtExceptionInfo MakeException(rtExceptionExpandType_t type, uint32_t retcode = 0U)
{
    rtExceptionInfo exception = {};
    exception.deviceid = 1U;
    exception.taskid = 2U;
    exception.streamid = 3U;
    exception.retcode = retcode;
    exception.expandInfo.type = type;
    return exception;
}
}  // namespace

class ExceptionInfoCommonUtest : public testing::Test {
protected:
    void SetUp() override {}
    void TearDown() override
    {
        GlobalMockObject::verify();
    }
};

TEST_F(ExceptionInfoCommonUtest, IsSupportDefaultExceptionDump_TypeMatrix)
{
    EXPECT_TRUE(ExceptionInfoCommon::IsSupportDefaultExceptionDump(MakeException(RT_EXCEPTION_FFTS_PLUS)));
    EXPECT_TRUE(ExceptionInfoCommon::IsSupportDefaultExceptionDump(MakeException(RT_EXCEPTION_AICORE)));
    EXPECT_TRUE(ExceptionInfoCommon::IsSupportDefaultExceptionDump(MakeException(RT_EXCEPTION_FUSION)));
    // AICPU 能进入 exception dump 入口，但不支持默认 dump 路径。
    EXPECT_FALSE(ExceptionInfoCommon::IsSupportDefaultExceptionDump(MakeException(RT_EXCEPTION_AICPU)));
    EXPECT_FALSE(ExceptionInfoCommon::IsSupportDefaultExceptionDump(MakeException(RT_EXCEPTION_INVALID)));
    EXPECT_FALSE(ExceptionInfoCommon::IsSupportDefaultExceptionDump(MakeException(RT_EXCEPTION_UB)));
}

TEST_F(ExceptionInfoCommonUtest, GetExceptionTaskTypeName_Aicpu)
{
    EXPECT_EQ(ExceptionInfoCommon::GetExceptionTaskTypeName(MakeException(RT_EXCEPTION_AICPU)), "aicpu");
    EXPECT_EQ(ExceptionInfoCommon::GetExceptionTaskTypeName(MakeException(RT_EXCEPTION_AICORE)), "aicore");
    EXPECT_EQ(ExceptionInfoCommon::GetExceptionTaskTypeName(MakeException(RT_EXCEPTION_FUSION)), "fusion");
    EXPECT_EQ(ExceptionInfoCommon::GetExceptionTaskTypeName(
        MakeException(static_cast<rtExceptionExpandType_t>(9999))), "unknown");
}

TEST_F(ExceptionInfoCommonUtest, GetExceptionKernelName_AicpuValid)
{
    rtExceptionInfo exception = MakeException(RT_EXCEPTION_AICPU);
    const char kernelName[] = "aicpu_kernel";
    exception.expandInfo.u.aicpuInfo.kernelName = kernelName;
    EXPECT_EQ(ExceptionInfoCommon::GetExceptionKernelName(exception), "aicpu_kernel");
}

TEST_F(ExceptionInfoCommonUtest, GetExceptionKernelName_AicpuNullReturnsEmpty)
{
    rtExceptionInfo exception = MakeException(RT_EXCEPTION_AICPU);
    exception.expandInfo.u.aicpuInfo.kernelName = nullptr;
    EXPECT_EQ(ExceptionInfoCommon::GetExceptionKernelName(exception), "");
}

TEST_F(ExceptionInfoCommonUtest, GetExceptionKernelName_AicoreValid)
{
    rtExceptionInfo exception = MakeException(RT_EXCEPTION_AICORE);
    const char kernelName[] = "aicore_kernel";
    rtExceptionKernelInfo_t &kernelInfo = exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo;
    kernelInfo.kernelName = kernelName;
    kernelInfo.kernelNameSize = static_cast<uint32_t>(std::strlen(kernelName));
    EXPECT_EQ(ExceptionInfoCommon::GetExceptionKernelName(exception), "aicore_kernel");
}

TEST_F(ExceptionInfoCommonUtest, GetExceptionKernelName_AicoreStripsMixSuffix)
{
    rtExceptionInfo exception = MakeException(RT_EXCEPTION_AICORE);
    const char kernelName[] = "aicore_kernel_mix_aic";
    rtExceptionKernelInfo_t &kernelInfo = exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo;
    kernelInfo.kernelName = kernelName;
    kernelInfo.kernelNameSize = static_cast<uint32_t>(std::strlen(kernelName));
    EXPECT_EQ(ExceptionInfoCommon::GetExceptionKernelName(exception), "aicore_kernel");
}

TEST_F(ExceptionInfoCommonUtest, GetExceptionKernelName_AicoreNullReturnsEmpty)
{
    rtExceptionInfo exception = MakeException(RT_EXCEPTION_AICORE);
    rtExceptionKernelInfo_t &kernelInfo = exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo;
    kernelInfo.kernelName = nullptr;
    kernelInfo.kernelNameSize = 0U;
    EXPECT_EQ(ExceptionInfoCommon::GetExceptionKernelName(exception), "");
}

TEST_F(ExceptionInfoCommonUtest, GetExceptionKernelName_UnsupportedTypeReturnsEmpty)
{
    EXPECT_EQ(ExceptionInfoCommon::GetExceptionKernelName(MakeException(RT_EXCEPTION_UB)), "");
}
