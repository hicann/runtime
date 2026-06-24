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
#include "inner_kernel.h"
#include "rt_error_codes.h"
#include "api_impl.hpp"
#include "api_decorator.hpp"
#include "api_error.hpp"
#include "api_profile_log_decorator.hpp"
#include "api_profile_decorator.hpp"
#include "dev.h"
#include "profiler.hpp"
#include "binary_loader.hpp"
#include "thread_local_container.hpp"
#include "dev_info_manage.h"
#include "rt_unwrap.h"
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
    Program *prog = new PlainProgram();
    MOCKER_CPP(&BinaryLoader::Load).stubs().with(outBoundP(&prog, sizeof(Program *))).will(returnValue(RT_ERROR_NONE));
    char *path = "test_path";
    rtLoadBinaryConfig_t cfg;
    void *handle;
    rtError_t error = rtsBinaryLoadFromFile(path, &cfg, &handle);

    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiKernelTest, TestRtsBinaryLoadFromDataSuccess)
{
    Program *prog = new PlainProgram();
    MOCKER_CPP(&BinaryLoader::Load).stubs().with(outBoundP(&prog, sizeof(Program *))).will(returnValue(RT_ERROR_NONE));
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
    PlainProgram program;
    Program *programBase = &program;
    rtBinHandle handle = rt_ut::InitAndExportHandle<rtBinHandle>(programBase);
    rtError_t error = rtsBinaryUnload(handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiKernelTest, TestFuncGetAddr)
{
    ElfProgram program;
    uint64_t tilingKey = 0;
    Kernel kernel("testKernelName", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    void* func1;
    void* func2;
    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtsFuncGetAddr(funcHandle, &func1, &func2);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiKernelTest, TestFuncGetSize)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_VECTOR);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernelName", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    size_t aicSize = 0;
    size_t aivSize = 0;
    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtFuncGetSize(funcHandle, &aicSize, &aivSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiKernelTest, TestRtsFuncGetByEntrySuccess)
{
    ApiImpl apiImpl;
    Kernel *kernel = new Kernel("testKernelName", 0, nullptr, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::BinaryGetFunctionByEntry)
    .stubs()
    .with(mockcpp::any(), mockcpp::any(), outBoundP(&kernel, sizeof(Kernel *)))
    .will(returnValue(RT_ERROR_NONE));
    ElfProgram program;
    Program *programBase = &program;
    rtBinHandle binHandle = rt_ut::InitAndExportHandle<rtBinHandle>(programBase);
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
    Kernel kernel("testKernelName", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    char_t name[128];
    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtsFuncGetName(funcHandle, 128, name);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiKernelTest, TestFuncGetNameFail)
{
    ApiImpl apiImpl;
    ElfProgram program;
    uint64_t tilingKey = 0;
    Kernel kernel("testKernelName", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    MOCKER(memcpy_s).stubs().will(returnValue(1));
    char_t name[128];
    rtError_t error = apiImpl.FuncGetName(&kernel,128, name);
    EXPECT_EQ(error, RT_ERROR_SEC_HANDLE);
}

TEST_F(CloudV2ApiKernelTest, TestFuncGetNameMaxLenFail)
{
    ElfProgram program;
    uint64_t tilingKey = 0;
    Kernel kernel("testKernelName", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    char_t name[128];
    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtsFuncGetName(funcHandle, 1, name);
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
    rtFuncHandle funcHandle = nullptr;
    rtBinHandle binHandle = nullptr;
    char_t name[128]="testName";

    rtError_t error = rtsFuncGetByName(binHandle, name, &funcHandle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiKernelTest, TestRegisterCpuFunc)
{
    PlainProgram prog;
    Program *programBase = &prog;
    rtBinHandle binHandle = rt_ut::InitAndExportHandle<rtBinHandle>(programBase);
    rtFuncHandle funcHandle = nullptr;
    rtError_t error = rtsRegisterCpuFunc(binHandle, "RunCpuKernel", "Abs", &funcHandle);
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
    Kernel kernel("testKernelName", tilingKey, nullptr, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

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
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernelName", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    int64_t attrValue = 0;
    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtFunctionGetAttribute(funcHandle, RT_FUNCTION_ATTR_KERNEL_TYPE, &attrValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtFunctionGetAttribute(funcHandle, RT_FUNCTION_ATTR_MAX, &attrValue);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtFunctionGetAttribute(funcHandle, RT_FUNCTION_ATTR_KERNEL_RATIO, &attrValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    ApiImpl apiImpl;
    error = apiImpl.FunctionGetAttribute(static_cast<rtFuncHandle>(&kernel), RT_FUNCTION_ATTR_MAX, &attrValue);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiImpl.FunctionGetAttribute(static_cast<rtFuncHandle>(&kernel), RT_FUNCTION_ATTR_KERNEL_RATIO, &attrValue);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ApiDecorator apiDecorator(&apiImpl);
    error = apiDecorator.FunctionGetAttribute(static_cast<rtFuncHandle>(&kernel), RT_FUNCTION_ATTR_MAX, &attrValue);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiKernelTest, TestFuncGetAttribute2)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernelName", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel.SetMixType(NO_MIX);
    kernel.SetTaskRation(0);

    int64_t attrValue = 0;
    ApiImpl apiImpl;
    rtError_t error = apiImpl.FunctionGetAttribute(static_cast<rtFuncHandle>(&kernel), RT_FUNCTION_ATTR_KERNEL_RATIO, &attrValue);
    EXPECT_EQ(error, RT_ERROR_NONE);

    kernel.SetMixType(MIX_AIC);
    error = apiImpl.FunctionGetAttribute(static_cast<rtFuncHandle>(&kernel), RT_FUNCTION_ATTR_KERNEL_RATIO, &attrValue);
    EXPECT_EQ(error, RT_ERROR_NONE);

    kernel.SetMixType(MIX_AIV);
    error = apiImpl.FunctionGetAttribute(static_cast<rtFuncHandle>(&kernel), RT_FUNCTION_ATTR_KERNEL_RATIO, &attrValue);
    EXPECT_EQ(error, RT_ERROR_NONE);

    kernel.SetMixType(MIX_AIC_AIV_MAIN_AIC);
    kernel.SetTaskRation(1);
    error = apiImpl.FunctionGetAttribute(static_cast<rtFuncHandle>(&kernel), RT_FUNCTION_ATTR_KERNEL_RATIO, &attrValue);
    EXPECT_EQ(error, RT_ERROR_NONE);

    kernel.SetTaskRation(2);
    error = apiImpl.FunctionGetAttribute(static_cast<rtFuncHandle>(&kernel), RT_FUNCTION_ATTR_KERNEL_RATIO, &attrValue);
    EXPECT_EQ(error, RT_ERROR_NONE);

    kernel.SetMixType(MIX_AIC_AIV_MAIN_AIV);
    kernel.SetTaskRation(1);
    error = apiImpl.FunctionGetAttribute(static_cast<rtFuncHandle>(&kernel), RT_FUNCTION_ATTR_KERNEL_RATIO, &attrValue);
    EXPECT_EQ(error, RT_ERROR_NONE);

    kernel.SetTaskRation(2);
    error = apiImpl.FunctionGetAttribute(static_cast<rtFuncHandle>(&kernel), RT_FUNCTION_ATTR_KERNEL_RATIO, &attrValue);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiKernelTest, TestFunctionGetBinary)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernelName", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    rtBinHandle binHandle = nullptr;
    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);

    int64_t attrValue = 0;
    rtError_t error = rtFunctionGetBinary(nullptr, &binHandle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtFunctionGetBinary(funcHandle, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtFunctionGetBinary(funcHandle, &binHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    ApiImpl apiImpl;
    Program* programHandle;
    error = apiImpl.FunctionGetBinary(&kernel, &programHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ApiDecorator apiDecorator(&apiImpl);
    error = apiDecorator.FunctionGetBinary(&kernel, &programHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiKernelTest, TestFuncGetSizeWithOnlyAiv)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_VECTOR);
    Kernel kernelAicObj("testKernelName", 1, &program, RT_KERNEL_ATTR_TYPE_VECTOR, 2048, 0, 0, 0, 0);
    kernelAicObj.SetKernelLength1(10);

    size_t aicSize = 0;
    size_t aivSize = 0;
    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernelAicObj);
    rtFuncGetSize(funcHandle, &aicSize, &aivSize);
    EXPECT_EQ(aicSize, 0);
    EXPECT_EQ(aivSize, 10);
}

TEST_F(CloudV2ApiKernelTest, TestFuncGetSizeWithOnlyAivWithKernelType)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_VECTOR);
    Kernel kernelObj("testKernelName", 1, &program, RT_KERNEL_ATTR_TYPE_VECTOR, 2048, 0, 0, 0, 0);
    kernelObj.SetKernelAttrType(RT_KERNEL_ATTR_TYPE_VECTOR);
    kernelObj.SetKernelLength1(10);

    size_t aicSize = 0;
    size_t aivSize = 0;
    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernelObj);
    rtFuncGetSize(funcHandle, &aicSize, &aivSize);
    EXPECT_EQ(aicSize, 0);
    EXPECT_EQ(aivSize, 10);
}

TEST_F(CloudV2ApiKernelTest, TestFuncGetSizeWithMixOnlyAiv)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    Kernel kernelObj("testKernelName", 1, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 0, 0, 0, 0);
    kernelObj.SetMixType(MIX_AIV);
    kernelObj.SetKernelLength1(10);

    size_t aicSize = 0;
    size_t aivSize = 0;
    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernelObj);
    rtFuncGetSize(funcHandle, &aicSize, &aivSize);
    EXPECT_EQ(aicSize, 0);
    EXPECT_EQ(aivSize, 10);
}

TEST_F(CloudV2ApiKernelTest, TestFuncGetSchedMode)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_VECTOR);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernelName", tilingKey, &program, RT_KERNEL_ATTR_TYPE_VECTOR, 2048, 1024, 0, 0, 0);

    kernel.SetSchedMode(RT_SCHEM_MODE_NORMAL);
    int64_t attrValue = 0;
    ApiImpl apiImpl;
    rtError_t error = apiImpl.FunctionGetAttribute(
        static_cast<rtFuncHandle>(&kernel),
        RT_FUNCTION_ATTR_KERNEL_SCHED_MODE,
        &attrValue);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(attrValue, 0);

    kernel.SetSchedMode(RT_SCHEM_MODE_BATCH);
    error = apiImpl.FunctionGetAttribute(
        static_cast<rtFuncHandle>(&kernel),
        RT_FUNCTION_ATTR_KERNEL_SCHED_MODE,
        &attrValue);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(attrValue, 1);
}

TEST_F(CloudV2ApiKernelTest, TestApiImplRegisterFuncSymbol_APITest)
{
    ElfProgram *prog = new ElfProgram(RT_KERNEL_ATTR_TYPE_AICPU);  
    const void *symbol = (const void *)0x01;
    char *kernelName = "test_path";

    ApiImpl apiImpl;
    ApiErrorDecorator apiError(&apiImpl);
    rtError_t ret = apiError.RegisterFuncSymbol(nullptr, symbol, kernelName);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    ret = apiError.RegisterFuncSymbol(prog, nullptr, kernelName);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    ret = apiError.RegisterFuncSymbol(prog, symbol, nullptr);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
}

TEST_F(CloudV2ApiKernelTest, TestApiImplRegisterFuncSymbol_Success)
{
    ElfProgram *prog = new ElfProgram(RT_KERNEL_ATTR_TYPE_AICPU);
    uint64_t tilingValue = 0ULL;
    Kernel *kernelPtr = new (std::nothrow) Kernel("test_funcsymbol", tilingValue, prog, RT_KERNEL_ATTR_TYPE_AICORE, 0, 0, NO_MIX);
    EXPECT_NE(kernelPtr, nullptr);

    uint32_t error = prog->KernelNameMapAdd(kernelPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    const void *symbol = (const void *)0x01;
    char *kernelName = "test_funcsymbol";

    ApiImpl apiImpl;
    rtError_t ret = apiImpl.RegisterFuncSymbol(prog, symbol, kernelName);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ApiErrorDecorator apiError(&apiImpl);
    ret = apiError.RegisterFuncSymbol(prog, symbol, kernelName);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ApiDecorator apiDecorator(&apiImpl);
    ret = apiDecorator.RegisterFuncSymbol(prog, symbol, kernelName);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}
TEST_F(CloudV2ApiKernelTest, TestApiImplrtFuncGetBySymbol_Success)
{
    const void *symbol = (const void *)0x05;
    rtFuncHandle funcHandle = nullptr;
    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api *>(&apiImpl)));
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    Kernel *retKernel = &kernel;
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetFunctionBySymbol)
        .stubs()
        .with(mockcpp::any(), outBoundP(&retKernel, sizeof(Kernel *)))
        .will(returnValue(RT_ERROR_NONE));
    rtError_t ret = rtGetFuncBySymbol(symbol, &funcHandle);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    EXPECT_EQ(rt_ut::UnwrapOrNull<Kernel>(funcHandle), &kernel);
}

TEST_F(CloudV2ApiKernelTest, TestApiImplrtFuncGetBySymbol_APITest)
{
    const void *symbol = (const void *)0x05;
    Kernel *outKernel = nullptr;
    ApiImpl apiImpl;
    ApiErrorDecorator apiError(&apiImpl);
    rtError_t ret = apiError.GetFunctionBySymbol(nullptr, &outKernel);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    ret = apiError.GetFunctionBySymbol(symbol, nullptr);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
}
TEST_F(CloudV2ApiKernelTest, TestApiImplrtFuncGetBySymbol_SymbolNotFound)
{
    const void *symbol = (const void *)0x05;
    Kernel *outKernel = nullptr;
    ApiImpl apiImpl;
    rtError_t ret = apiImpl.GetFunctionBySymbol(symbol, &outKernel);
    EXPECT_EQ(ret, RT_ERROR_INVALID_DEVICE_FUNCTION);
    ApiErrorDecorator apiError(&apiImpl);
    ret = apiError.GetFunctionBySymbol(symbol, &outKernel);
    EXPECT_EQ(ret, RT_ERROR_INVALID_DEVICE_FUNCTION);
    ApiDecorator apiDecorator(&apiImpl);
    ret = apiDecorator.GetFunctionBySymbol(symbol, &outKernel);
    EXPECT_EQ(ret, RT_ERROR_INVALID_DEVICE_FUNCTION);
}

TEST_F(CloudV2ApiKernelTest, TestApiImplrtFuncGetBySymbol_SymbolFound)
{
    const void *symbol = (const void *)0x05;
    Kernel *outKernel = nullptr;
    char *kernelName = "testKernelName";
    ApiImpl apiImpl;
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel *kernelPtr = new (std::nothrow) Kernel(kernelName, tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    uint32_t error = program.KernelNameMapAdd(kernelPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtError_t ret = apiImpl.RegisterFuncSymbol(&program, symbol, kernelName);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    
    ret = apiImpl.GetFunctionBySymbol(symbol, &outKernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiKernelTest, TestApiImplBinaryGetGlobal_Success)
{
    ElfProgram prog;
    prog.elfData_ = new rtElfData();
    prog.elfData_->globalSymbolMap["test_global_var"] = {0x100, 256};
    prog.SetBinBaseAddr((void *)0x8000, 0);
    prog.SetBinAlignBaseAddr((void *)0x8000, 0);
    InitEmbeddedInnerHandle<Program>(&prog);
    void *dptr = nullptr;
    size_t size = 0;
    rtError_t ret = rtBinaryGetGlobal(static_cast<rtBinHandle>(prog.GetInnerHandle()), "test_global_var", &dptr, &size);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    EXPECT_EQ(dptr, (void *)0x8100);
    EXPECT_EQ(size, 256);
}

TEST_F(CloudV2ApiKernelTest, TestApiImplBinaryGetGlobal_SymbolNotFound)
{
    ElfProgram prog;
    prog.elfData_ = new rtElfData();
    prog.SetBinBaseAddr((void *)0x8000, 0);
    prog.SetBinAlignBaseAddr((void *)0x8000, 0);
    ApiImpl apiImpl;
    void *dptr = nullptr;
    size_t size = 0;
    rtError_t ret = apiImpl.BinaryGetGlobal(static_cast<const Program*>(&prog), "nonexistent_symbol", &dptr, &size);
    EXPECT_EQ(ret, RT_ERROR_SYMBOL_NOT_FOUND);
}


TEST_F(CloudV2ApiKernelTest, TestApiImplBinaryGetGlobal_NullOutputsParams)
{
    ElfProgram prog;
    prog.elfData_ = new rtElfData();
    prog.elfData_->globalSymbolMap["test_global_var"] = {0x100, 256};
    prog.SetBinBaseAddr((void *)0x8000, 0);
    prog.SetBinAlignBaseAddr((void *)0x8000, 0);
    ApiImpl apiImpl;
    rtError_t ret = apiImpl.BinaryGetGlobal(static_cast<const Program*>(&prog), "test_global_var", nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiKernelTest, TestApiImplBinaryGetGlobal_CPUKernelNotSupport)
{
    PlainProgram prog(RT_KERNEL_REG_TYPE_CPU);
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);
    void *dptr = nullptr;
    size_t size = 0;
    rtError_t ret = apiError.BinaryGetGlobal(static_cast<const Program*>(&prog), "test_symbol", &dptr, &size);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(CloudV2ApiKernelTest, TestApiImplBinaryGetGlobal_XPUFeatureNotSupport)
{
    MOCKER_CPP(&DevInfoManage::IsSupportChipFeature).stubs().will(returnValue(true));
    ApiImpl apiImpl;
    void *dptr = nullptr;
    size_t size = 0;
    rtError_t ret = rtBinaryGetGlobal((rtBinHandle)0x01, "test_symbol", &dptr, &size);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(CloudV2ApiKernelTest, TestApiImplBinaryGetGlobal_BaseAddrNull)
{
    ElfProgram prog;
    prog.elfData_ = new rtElfData();
    prog.elfData_->globalSymbolMap["test_global_var"] = {0x100, 256};
    prog.SetBinBaseAddr(nullptr, 0);
    prog.SetBinAlignBaseAddr(nullptr, 0);
    
    ApiImpl apiImpl;
    void *dptr = nullptr;
    size_t size = 0;
    rtError_t ret = apiImpl.BinaryGetGlobal(static_cast<const Program*>(&prog), "test_global_var", &dptr, &size);
    EXPECT_EQ(ret, 0x7090001);
}
