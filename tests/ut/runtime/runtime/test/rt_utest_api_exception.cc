/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "rt_utest_api.hpp"

class ApiExceptionTest : public testing::Test
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
    }

    virtual void TearDown()
    {
         GlobalMockObject::verify();
    }
};

void MyOpExceptionCallback(rtExceptionInfo_t *exceptionInfo, void *userData)
{
    EXPECT_EQ(exceptionInfo->retcode, 100);
}

TEST_F(ApiExceptionTest, rtBinarySetExceptionCallback)
{
    ElfProgram bin_handle;
    rtError_t error;

    rtOpExceptionCallback callback = MyOpExceptionCallback;
    error = rtBinarySetExceptionCallback(RtPtrToPtr<rtBinHandle>(&bin_handle), callback, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(bin_handle.opExceptionCallback_, callback);

    // 验证重复注册场景
    error = rtBinarySetExceptionCallback(RtPtrToPtr<rtBinHandle>(&bin_handle), callback, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiExceptionTest, rtGetFuncHandleFromExceptionInfo)
{
    ElfProgram bin_handle;
    // bin_handle析构会释放内存
    Kernel *kernel = new Kernel("kernel.so", "kernel_func", "op_type");
    kernel->SetCpuOpType("test");
    bin_handle.MixKernelAdd(kernel);
    rtError_t error;

    (void)rtSetDevice(0);

    rtExceptionInfo_t exceptionInfo;
    (void)memset_s(&exceptionInfo, sizeof(rtExceptionInfo_t), 0, sizeof(rtExceptionInfo_t));
    exceptionInfo.retcode = 100;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = RtPtrToPtr<rtBinHandle>(&bin_handle);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = "test";

    rtFuncHandle func;
    error = rtGetFuncHandleFromExceptionInfo(&exceptionInfo, &func);
    EXPECT_EQ(error, RT_ERROR_NONE);

    exceptionInfo.expandInfo.type = RT_EXCEPTION_FUSION;
    exceptionInfo.expandInfo.u.fusionInfo.type == RT_FUSION_AICORE_CCU;
    exceptionInfo.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.exceptionKernelInfo.bin = RtPtrToPtr<rtBinHandle>(&bin_handle);
    exceptionInfo.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.exceptionKernelInfo.kernelName = "test";

    rtFuncHandle func1;
    error = rtGetFuncHandleFromExceptionInfo(&exceptionInfo, &func1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    exceptionInfo.expandInfo.type = RT_EXCEPTION_INVALID;

    rtFuncHandle func2;
    error = rtGetFuncHandleFromExceptionInfo(&exceptionInfo, &func2);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiExceptionTest, OpTaskFailCallbackNotify)
{
    ElfProgram bin_handle;
    rtError_t error;

    rtExceptionInfo_t exceptionInfo;
    (void)memset_s(&exceptionInfo, sizeof(rtExceptionInfo_t), 0, sizeof(rtExceptionInfo_t));
    exceptionInfo.retcode = 100;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = RtPtrToPtr<rtBinHandle>(&bin_handle);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = "test";

    rtOpExceptionCallback callback = MyOpExceptionCallback;
    error = rtBinarySetExceptionCallback(RtPtrToPtr<rtBinHandle>(&bin_handle), callback, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    OpTaskFailCallbackNotify(&exceptionInfo);

    exceptionInfo.expandInfo.type = RT_EXCEPTION_FUSION;
    exceptionInfo.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.exceptionKernelInfo.bin = RtPtrToPtr<rtBinHandle>(&bin_handle);
    exceptionInfo.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.exceptionKernelInfo.kernelName = "test";
    OpTaskFailCallbackNotify(&exceptionInfo);

    exceptionInfo.expandInfo.type = RT_EXCEPTION_INVALID;
    OpTaskFailCallbackNotify(&exceptionInfo);
}