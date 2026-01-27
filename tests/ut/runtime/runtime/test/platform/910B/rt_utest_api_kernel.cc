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

class CloudV2ApiKernelTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"CloudV2ApiKernelTest test start start. "<<std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout<<"CloudV2ApiKernelTest test start end. "<<std::endl;

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
private:
    rtChipType_t oldChipType;
};

TEST_F(CloudV2ApiKernelTest, TestRtsRegKernelLaunchFillFuncSuccess)
{
    Runtime *rtInstance = Runtime::Instance();
    MOCKER_CPP_VIRTUAL(rtInstance, &Runtime::RegKernelLaunchFillFunc).stubs().will(returnValue(RT_ERROR_NONE));

    rtBinHandle binHandle;
    rtKernelLaunchFillFunc callback;
    rtError_t error = rtsRegKernelLaunchFillFunc("testSymbol", callback);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiKernelTest, TestRtsUnRegKernelLaunchFillFuncSuccess)
{
    Runtime *rtInstance = Runtime::Instance();
    MOCKER_CPP_VIRTUAL(rtInstance, &Runtime::UnRegKernelLaunchFillFunc).stubs().will(returnValue(RT_ERROR_NONE));

    rtBinHandle binHandle;
    rtKernelLaunchFillFunc callback;
    rtError_t error = rtsUnRegKernelLaunchFillFunc("testSymbol");
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiKernelTest, TestRtsBinaryLoadFromFileSuccess)
{
    MOCKER_CPP(&BinaryLoader::Load).stubs().will(returnValue(RT_ERROR_NONE));
    char *path = "test_path";
    rtLoadBinaryConfig_t cfg;
    void *handle;
    rtError_t error = rtsBinaryLoadFromFile(path, &cfg, &handle);

    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiKernelTest, TestRtsBinaryLoadFromDataSuccess)
{
    MOCKER_CPP(&BinaryLoader::Load).stubs().will(returnValue(RT_ERROR_NONE));
    uint32_t tmp;
    rtLoadBinaryConfig_t cfg;
    void *handle;
    rtError_t error = rtsBinaryLoadFromData(static_cast<void*>(&tmp), 1024, &cfg, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiKernelTest, TestRtsBinaryUnloadSuccess)
{
    ApiImpl apiImpl;
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::BinaryUnLoad).stubs().will(returnValue(RT_ERROR_NONE));
    void *handle;
    rtError_t error = rtsBinaryUnload(&handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiKernelTest, TestFuncGetAddr)
{
    ElfProgram program;
    uint64_t tilingKey = 0;
    Kernel kernel(nullptr, "testKernelName", tilingKey, &program, 2048, 1024, 0, 0, 0);

    void* func1;
    void* func2;
    rtError_t error = rtsFuncGetAddr(&kernel, &func1, &func2);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiKernelTest, TestRtsFuncGetByEntrySuccess)
{
    ApiImpl apiImpl;
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::BinaryGetFunctionByEntry).stubs().will(returnValue(RT_ERROR_NONE));
    ElfProgram program;
    rtBinHandle binHandle = &program;
    void *handle;
    rtError_t error = rtsFuncGetByEntry(binHandle, 1024, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiKernelTest, TestRtsGetNonCacheAddrOffset)
{
    ApiImpl apiImpl;
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetL2CacheOffset).stubs().will(returnValue(RT_ERROR_NONE));

    uint64_t offset;
    rtError_t error = rtsGetNonCacheAddrOffset(0, &offset);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiKernelTest, TestFuncGetName)
{
    ElfProgram program;
    uint64_t tilingKey = 0;
    Kernel kernel(nullptr, "testKernelName", tilingKey, &program, 2048, 1024, 0, 0, 0);
    char_t name[128];
    rtError_t error = rtsFuncGetName(&kernel, 128, name);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiKernelTest, TestFuncGetNameFail)
{
    ApiImpl apiImpl;
    ElfProgram program;
    uint64_t tilingKey = 0;
    Kernel kernel(nullptr, "testKernelName", tilingKey, &program, 2048, 1024, 0, 0, 0);
    MOCKER(memcpy_s).stubs().will(returnValue(1));
    char_t name[128];
    rtError_t error = apiImpl.FuncGetName(&kernel,128, name);
    EXPECT_EQ(error, RT_ERROR_SEC_HANDLE);
}

TEST_F(CloudV2ApiKernelTest, TestFuncGetNameMaxLenFail)
{
    ElfProgram program;
    uint64_t tilingKey = 0;
    Kernel kernel(nullptr, "testKernelName", tilingKey, &program, 2048, 1024, 0, 0, 0);
    char_t name[128];
    rtError_t error = rtsFuncGetName(&kernel, 1, name);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiKernelTest, TestCpuKernelLaunch)
{
    rtError_t error = rtsLaunchCpuKernel(nullptr, 1, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiKernelTest, TestRtsLaunchKernelWithDevArgs)
{
    rtError_t error = rtsLaunchKernelWithDevArgs(nullptr, 1, nullptr, nullptr, nullptr, 0U, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiKernelTest, TestRtsFuncGetByName)
{
    rtFuncHandle funcHandle;
    rtBinHandle binHandle;
    char_t name[128]="testName";

    rtError_t error = rtsFuncGetByName(binHandle, name, &funcHandle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiKernelTest, TestRegisterCpuFunc)
{
    PlainProgram prog;
    rtFuncHandle funcHandle = nullptr;
    rtError_t error = rtsRegisterCpuFunc(&prog, "RunCpuKernel", "Abs", &funcHandle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(nullptr, funcHandle);
}

TEST_F(CloudV2ApiKernelTest, TestBinaryLoadFromFileFailed)
{
    ApiImpl apiImpl;
    MOCKER_CPP(&BinaryLoader::Load).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    char *path = "test_path";
    rtLoadBinaryConfig_t cfg;
    Program *handle;
    rtError_t error = apiImpl.BinaryLoadFromFile(path, &cfg, &handle);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    ApiDecorator apiDecorator(&apiImpl);
    error = apiDecorator.BinaryLoadFromFile(path, &cfg, &handle);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    Profiler profiler(&apiImpl);
    ApiProfileDecorator apiProfileDecorator(&apiImpl, &profiler);
    error = apiProfileDecorator.BinaryLoadFromFile(path, &cfg, &handle);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(CloudV2ApiKernelTest, TestBinaryLoadFromDataFailed)
{
    ApiImpl apiImpl;
    MOCKER_CPP(&BinaryLoader::Load).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    uint32_t tmp;
    rtLoadBinaryConfig_t cfg;
    Program *handle;
    rtError_t error = apiImpl.BinaryLoadFromData(static_cast<void*>(&tmp), 1024, &cfg, &handle);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    ApiDecorator apiDecorator(&apiImpl);
    error = apiDecorator.BinaryLoadFromData(static_cast<void*>(&tmp), 1024, &cfg, &handle);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    Profiler profiler(&apiImpl);
    ApiProfileDecorator apiProfileDecorator(&apiImpl, &profiler);
    error = apiProfileDecorator.BinaryLoadFromData(static_cast<void*>(&tmp), 1024, &cfg, &handle);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(CloudV2ApiKernelTest, TestFuncGetByEntry)
{
    ApiImpl apiImpl;
    ElfProgram program;
    rtFuncHandle funcHandle;
    Kernel *kernel;

    ApiDecorator apiDecorator(&apiImpl);
    auto error = apiDecorator.BinaryGetFunctionByEntry(&program, 1024, &kernel);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    Profiler profiler(&apiImpl);
    ApiProfileDecorator apiProfileDecorator(&apiImpl, &profiler);
    error = apiProfileDecorator.BinaryGetFunctionByEntry(&program, 1024, &kernel);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    ApiProfileLogDecorator apiProfileLogDecorator(&apiImpl, &profiler);
    error = apiProfileLogDecorator.BinaryGetFunctionByEntry(&program, 1024, &kernel);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(CloudV2ApiKernelTest, TestFuncGetAddrWithProgramNull)
{
    ApiImpl apiImpl;
    ElfProgram program;
    uint64_t tilingKey = 0;
    Kernel kernel(nullptr, "testKernelName", tilingKey, nullptr, 2048, 1024, 0, 0, 0);

    void* func1;
    void* func2;
    rtError_t error = apiImpl.FuncGetAddr(&kernel, &func1, &func2);
    EXPECT_EQ(error, RT_ERROR_PROGRAM_NULL);
}

TEST_F(CloudV2ApiKernelTest, MemcpyBatch)
{
    ApiImpl apiImpl;
    rtError_t error;
    constexpr size_t len = 8U;
    constexpr size_t count = 1U;
    char *dsts[count];
    char *srcs[count];
    size_t sizes[count];
    for (size_t i = 0; i < count; i++) {
        dsts[i] = new (std::nothrow) char[len];
        srcs[i] = new (std::nothrow) char[len];
        sizes[i] = 1U;
    }
    size_t attrsIdxs = 0;
    size_t numAttrs = 1;
    size_t failIdx;
    rtMemcpyBatchAttr attrs = {};

    ApiDecorator apiDecorator(&apiImpl);
    error = apiDecorator.MemcpyBatch((void **)(dsts), (void **)(srcs), sizes, count, &attrs, &attrsIdxs, numAttrs, &failIdx);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    Profiler profiler(&apiImpl);
    ApiProfileDecorator apiProfileDecorator(&apiImpl, &profiler);
    error = apiProfileDecorator.MemcpyBatch((void **)(dsts), (void **)(srcs), sizes, count, &attrs, &attrsIdxs, numAttrs, &failIdx);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    ApiProfileLogDecorator apiProfileLogDecorator(&apiImpl, &profiler);
    error = apiProfileLogDecorator.MemcpyBatch((void **)(dsts), (void **)(srcs), sizes, count, &attrs, &attrsIdxs, numAttrs, &failIdx);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    for (size_t i = 0; i < count; i++) {
        delete [] dsts[i];
        delete [] srcs[i];
    }
}

TEST_F(CloudV2ApiKernelTest, MemcpyBatchAsync)
{
    ApiImpl apiImpl;
    rtError_t error;
    constexpr size_t len = 8U;
    constexpr size_t count = 1U;
    char *dsts[count];
    char *srcs[count];
    size_t sizes[count];
    size_t destMaxs[count];
    for (size_t i = 0; i < count; i++) {
        dsts[i] = new (std::nothrow) char[len];
        srcs[i] = new (std::nothrow) char[len];
        sizes[i] = 1U;
        destMaxs[i] = len;
    }
    size_t attrsIdxs = 0;
    size_t numAttrs = 1;
    size_t failIdx;
    rtMemcpyBatchAttr attrs = {};

    ApiDecorator apiDecorator(&apiImpl);
    error = apiDecorator.MemcpyBatchAsync((void **)(dsts), destMaxs, (void **)(srcs), sizes, count, &attrs, &attrsIdxs, numAttrs, &failIdx, nullptr);
    EXPECT_EQ(error,RT_ERROR_DRV_NOT_SUPPORT);

    MOCKER(halSupportFeature).stubs().will(returnValue(false));
    error = apiDecorator.MemcpyBatchAsync((void **)(dsts), destMaxs, (void **)(srcs), sizes, count, &attrs, &attrsIdxs, numAttrs, &failIdx, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    Profiler profiler(&apiImpl);
    ApiProfileDecorator apiProfileDecorator(&apiImpl, &profiler);

    error = apiProfileDecorator.MemcpyBatchAsync((void **)(dsts), destMaxs, (void **)(srcs), sizes, count, &attrs, &attrsIdxs, numAttrs, &failIdx, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    for (size_t i = 0; i < count; i++) {
        delete [] dsts[i];
        delete [] srcs[i];
    }
}

TEST_F(CloudV2ApiKernelTest, TestFuncGetAttribute)
{
    ElfProgram program;
    uint64_t tilingKey = 0;
    Kernel kernel(nullptr, "testKernelName", tilingKey, &program, 2048, 1024, 0, 0, 0);

    int64_t attrValue = 0;
    rtError_t error = rtFunctionGetAttribute(static_cast<rtFuncHandle>(&kernel), RT_FUNCTION_ATTR_KERNEL_TYPE, &attrValue);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtFunctionGetAttribute(static_cast<rtFuncHandle>(&kernel), RT_FUNCTION_ATTR_MAX, &attrValue);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    ApiImpl apiImpl;
    error = apiImpl.FunctionGetAttribute(static_cast<rtFuncHandle>(&kernel), RT_FUNCTION_ATTR_MAX, &attrValue);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ApiDecorator apiDecorator(&apiImpl);
    error = apiDecorator.FunctionGetAttribute(static_cast<rtFuncHandle>(&kernel), RT_FUNCTION_ATTR_MAX, &attrValue);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
