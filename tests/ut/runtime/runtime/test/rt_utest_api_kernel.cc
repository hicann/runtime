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
#include "acl_base_rt.h"
#define private public
#include "config.h"
#include "runtime.hpp"
#include "kernel.h"
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
#include "inner_kernel.h"
#include "base_david.hpp"
#include "elf.hpp"
#include "rt_unwrap.h"
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

namespace {
    Kernel* CreateTestKernelForCheckArgs(rtKernelAttrType attrType,
                                         KernelRegisterType regType,
                                         bool hasParamSummary,
                                         size_t paramCount = 0) {
        ElfProgram* program = new ElfProgram(attrType);
        uint64_t tilingKey = 0;
        Kernel* kernel = new Kernel("testKernel", tilingKey, program, attrType,
                                    2048, 1024, 0, 0, 0);
        kernel->SetKernelRegisterType(regType);
        kernel->SetHasParamSummary(hasParamSummary);
        if (paramCount > 0) {
            kernel->SetParamCount(paramCount);
        }
        return kernel;
    }

    void DestroyTestKernel(Kernel* kernel) {
        if (kernel != nullptr) {
            Program* program = kernel->Program_();
            delete kernel;
            if (program != nullptr) {
                delete program;
            }
        }
    }

    void InitBatchAttr(rtMemcpyBatchAttr &attr)
    {
        attr = {};
        attr.dstLoc.type = RT_MEMORY_LOC_DEVICE;
        attr.dstLoc.id = 0U;
        attr.srcLoc.type = RT_MEMORY_LOC_HOST;
        attr.srcLoc.id = 0U;
    }

    void InitPtrAttr(rtPtrAttributes_t &attr, rtMemLocationType type)
    {
        attr = {};
        attr.location.type = type;
        attr.location.id = 0U;
    }
}

TEST_F(ApiKernelTest, TestRtsBinaryLoadFromFileSuccess)
{
    Program *prog = new PlainProgram();
    MOCKER_CPP(&BinaryLoader::Load).stubs().with(outBoundP(&prog, sizeof(Program *))).will(returnValue(RT_ERROR_NONE));
    char *path = "test_path";
    rtLoadBinaryConfig_t cfg;
    void *handle;
    rtError_t error = rtsBinaryLoadFromFile(path, &cfg, &handle);

    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiKernelTest, TestRtsBinaryLoadFromDataSuccess)
{
    Program *prog = new PlainProgram();
    MOCKER_CPP(&BinaryLoader::Load).stubs().with(outBoundP(&prog, sizeof(Program *))).will(returnValue(RT_ERROR_NONE));
    uint32_t tmp;
    rtLoadBinaryConfig_t cfg;
    void *handle;
    rtError_t error = rtsBinaryLoadFromData(static_cast<void*>(&tmp), 1024, &cfg, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiKernelTest, TestRtsBinaryUnloadSuccess)
{
    ApiImpl apiImpl;
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::BinaryUnLoad).stubs().will(returnValue(RT_ERROR_NONE));
    PlainProgram program;
    Program *programBase = &program;
    rtBinHandle handle = rt_ut::InitAndExportHandle<rtBinHandle>(programBase);
    rtError_t error = rtsBinaryUnload(handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

}

TEST_F(ApiKernelTest, TestFuncGetAddr)
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

TEST_F(ApiKernelTest, TestRtsFuncGetByEntrySuccess)
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

TEST_F(ApiKernelTest, TestRtsGetNonCacheAddrOffset)
{
    ApiImpl apiImpl;
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetL2CacheOffset).stubs().will(returnValue(RT_ERROR_NONE));

    uint64_t offset;
    rtError_t error = rtsGetNonCacheAddrOffset(0, &offset);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiKernelTest, TestFuncGetName)
{
    ElfProgram program;
    uint64_t tilingKey = 0;
    Kernel kernel("testKernelName", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    char_t name[128];
    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtsFuncGetName(funcHandle, 128, name);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiKernelTest, TestFuncGetNameFail)
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

TEST_F(ApiKernelTest, TestFuncGetNameMaxLenFail)
{
    ElfProgram program;
    uint64_t tilingKey = 0;
    Kernel kernel("testKernelName", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    char_t name[128];
    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtsFuncGetName(funcHandle, 1, name);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiKernelTest, TestCpuKernelLaunch)
{
    rtError_t error = rtsLaunchCpuKernel(nullptr, 1, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiKernelTest, TestRegisterCpuFunc)
{
    PlainProgram prog;
    Program *programBase = &prog;
    rtBinHandle binHandle = rt_ut::InitAndExportHandle<rtBinHandle>(programBase);
    rtFuncHandle funcHandle = nullptr;
    rtError_t error = rtsRegisterCpuFunc(binHandle, "RunCpuKernel", "Abs", &funcHandle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(nullptr, funcHandle);

    prog.SetKernelRegType(RT_KERNEL_REG_TYPE_CPU);
    funcHandle = nullptr;
    error = rtsRegisterCpuFunc(binHandle, "RunCpuKernel", "Abs", &funcHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(true, funcHandle != nullptr);

    MOCKER_CPP(&Program::StoreKernelLiteralNameToDevice).stubs().will(returnValue(ACL_ERROR_RT_DEVICE_MEM_ERROR));
    funcHandle = nullptr;
    error = rtsRegisterCpuFunc(binHandle, "RunCpuKernel", "Add", &funcHandle);
    EXPECT_EQ(error, ACL_ERROR_RT_DEVICE_MEM_ERROR);
    EXPECT_EQ(nullptr, funcHandle);
}

TEST_F(ApiKernelTest, TestRtsLaunchKernelWithDevArgs)
{
    rtError_t error = rtsLaunchKernelWithDevArgs(nullptr, 1, nullptr, nullptr, nullptr, 0U, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

class ApiImplKernelTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"ApiImplKernelTest test start start. "<<std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout<<"ApiImplKernelTest test start end. "<<std::endl;

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

TEST_F(ApiImplKernelTest, TestBinaryLoadFromFileFailed)
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

TEST_F(ApiImplKernelTest, TestBinaryLoadFromDataFailed)
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

TEST_F(ApiImplKernelTest, TestFuncGetAddr)
{
    ApiImpl apiImpl;
    ElfProgram program;
    uint64_t tilingKey = 0;
    Kernel kernel("testKernelName", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    void* func1;
    void* func2;
    rtError_t error = apiImpl.FuncGetAddr(&kernel, &func1, &func2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ApiDecorator apiDecorator(&apiImpl);
    error = apiDecorator.FuncGetAddr(&kernel, &func1, &func2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Profiler profiler(&apiImpl);
    ApiProfileDecorator apiProfileDecorator(&apiImpl, &profiler);
    error = apiProfileDecorator.FuncGetAddr(&kernel, &func1, &func2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ApiProfileLogDecorator apiProfileLogDecorator(&apiImpl, &profiler);
    error = apiProfileLogDecorator.FuncGetAddr(&kernel, &func1, &func2);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiImplKernelTest, TestFuncGetByEntry)
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

TEST_F(ApiImplKernelTest, TestFuncGetAddrWithProgramNull)
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

TEST_F(ApiImplKernelTest, MemcpyBatch)
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

TEST_F(ApiImplKernelTest, MemcpyBatchAsync)
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

TEST_F(ApiKernelTest, TestFuncGetAttribute)
{
    ElfProgram program;
    uint64_t tilingKey = 0;
    Kernel kernel("testKernelName", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    int64_t attrValue = 0;
    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtFunctionGetAttribute(funcHandle, RT_FUNCTION_ATTR_KERNEL_TYPE, &attrValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtFunctionGetAttribute(funcHandle, RT_FUNCTION_ATTR_MAX, &attrValue);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    ApiImpl apiImpl;
    error = apiImpl.FunctionGetAttribute(static_cast<rtFuncHandle>(&kernel), RT_FUNCTION_ATTR_MAX, &attrValue);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ApiDecorator apiDecorator(&apiImpl);
    error = apiDecorator.FunctionGetAttribute(static_cast<rtFuncHandle>(&kernel), RT_FUNCTION_ATTR_MAX, &attrValue);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiKernelTest, TestFunctionGetMetaInfoSize)
{
    ApiImpl apiImpl;
    ApiErrorDecorator apiErrorDecorator(&apiImpl);
    rtError_t error;
    size_t metaSize = 0;
    Kernel kernel("testKernelName", 0, nullptr, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    error = apiErrorDecorator.FunctionGetMetaInfoSize(nullptr, RT_FUNCTION_TYPE_KERNEL_TYPE, &metaSize);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiErrorDecorator.FunctionGetMetaInfoSize(&kernel, RT_FUNCTION_TYPE_KERNEL_TYPE, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(ApiKernelTest, TestFuncGetSchedMode)
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

TEST_F(ApiKernelTest, TestRtLaunchKernelWithArgsArray_ParamCheck)
{
    uint32_t numBlocks = 1;
    rtStream_t stm = nullptr;
    rtKernelLaunchCfg_t cfg = {};
    void *argsArray[2] = {(void *)0x10, (void *)0x20};

    rtError_t error = rtLaunchKernelWithArgsArray(nullptr, numBlocks, stm, &cfg, argsArray);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiKernelTest, TestRtLaunchKernelWithArgsArray_ApiImplSuccess)
{
    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api *>(&apiImpl)));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LaunchKernelV2).stubs().will(returnValue(RT_ERROR_NONE));

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    uint32_t numBlocks = 1;
    rtStream_t stm = nullptr;
    rtKernelLaunchCfg_t cfg = {};
    void *argsArray[2] = {(void *)0x10, (void *)0x20};

    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtLaunchKernelWithArgsArray(funcHandle, numBlocks, stm, &cfg, argsArray);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiKernelTest, TestRtLaunchKernelWithArgsArray_ApiImplSuccessWithSymbol)
{
    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api *>(&apiImpl)));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LaunchKernelV2).stubs().will(returnValue(RT_ERROR_NONE));

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    Kernel *retKernel = &kernel;
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetFunctionBySymbol)
        .stubs()
        .with(mockcpp::any(), outBoundP(&retKernel, sizeof(Kernel *)))
        .will(returnValue(RT_ERROR_NONE));
    
    uint32_t numBlocks = 1;
    rtStream_t stm = nullptr;
    rtKernelLaunchCfg_t cfg = {};
    void *argsArray[2] = {(void *)0x10, (void *)0x20};
    
    rtError_t error = rtLaunchKernelWithArgsArray(static_cast<void *>(&kernel), numBlocks, stm, &cfg, argsArray);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiKernelTest, TestRtLaunchKernelWithArgsArray_ApiImplKernelInvalid)
{
    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api *>(&apiImpl)));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LaunchKernelV2).stubs().will(returnValue(RT_ERROR_KERNEL_INVALID));

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    uint32_t numBlocks = 1;
    rtStream_t stm = nullptr;
    rtKernelLaunchCfg_t cfg = {};
    void *argsArray[2] = {(void *)0x10, (void *)0x20};

    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtLaunchKernelWithArgsArray(funcHandle, numBlocks, stm, &cfg, argsArray);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_HANDLE);
}

TEST_F(ApiKernelTest, TestRtLaunchKernelWithArgsArray_ApiImplFeatureNotSupport)
{
    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api *>(&apiImpl)));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LaunchKernelV2).stubs().will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    uint32_t numBlocks = 1;
    rtStream_t stm = nullptr;
    rtKernelLaunchCfg_t cfg = {};
    void *argsArray[2] = {(void *)0x10, (void *)0x20};

    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtLaunchKernelWithArgsArray(funcHandle, numBlocks, stm, &cfg, argsArray);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiKernelTest, TestRtLaunchKernelWithArgsArray_ApiImplOtherError)
{
    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api *>(&apiImpl)));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LaunchKernelV2).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    uint32_t numBlocks = 1;
    rtStream_t stm = nullptr;
    rtKernelLaunchCfg_t cfg = {};
    void *argsArray[2] = {(void *)0x10, (void *)0x20};

    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtLaunchKernelWithArgsArray(funcHandle, numBlocks, stm, &cfg, argsArray);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}



TEST_F(ApiKernelTest, TestRtFunctionGetParamCount_ApiImplSuccess)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel.SetHasParamSummary(true);
    kernel.SetParamCount(3);

    size_t paramCount = 0;
    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api *>(&apiImpl)));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::FunctionGetParamCount).stubs().will(returnValue(RT_ERROR_NONE));

    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtFunctionGetParamCount(funcHandle, &paramCount);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiKernelTest, TestRtFunctionGetParamCount_ApiImplFeatureNotSupport)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    size_t paramCount = 0;
    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api *>(&apiImpl)));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::FunctionGetParamCount).stubs().will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));

    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtFunctionGetParamCount(funcHandle, &paramCount);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiKernelTest, TestRtFunctionGetParamCount_ApiImplOtherError)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    size_t paramCount = 0;
    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api *>(&apiImpl)));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::FunctionGetParamCount).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtFunctionGetParamCount(funcHandle, &paramCount);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}



TEST_F(ApiKernelTest, TestRtFunctionGetParamInfo_ApiImplSuccess)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    size_t paramIndex = 0;
    size_t paramOffset = 0;
    size_t paramSize = 0;
    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api *>(&apiImpl)));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::FunctionGetParamInfo).stubs().will(returnValue(RT_ERROR_NONE));

    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtFunctionGetParamInfo(funcHandle, paramIndex, &paramOffset, &paramSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiKernelTest, TestRtFunctionGetParamInfo_ApiImplFeatureNotSupport)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    size_t paramIndex = 0;
    size_t paramOffset = 0;
    size_t paramSize = 0;
    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api *>(&apiImpl)));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::FunctionGetParamInfo).stubs().will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));

    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtFunctionGetParamInfo(funcHandle, paramIndex, &paramOffset, &paramSize);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiKernelTest, TestRtFunctionGetParamInfo_ApiImplOtherError)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    size_t paramIndex = 0;
    size_t paramOffset = 0;
    size_t paramSize = 0;
    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api *>(&apiImpl)));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::FunctionGetParamInfo).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtFunctionGetParamInfo(funcHandle, paramIndex, &paramOffset, &paramSize);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiKernelTest, TestXPUChipNotSupport)
{
    rtError_t error;
    size_t paramOffset = 0;
    size_t paramSize = 0;
    size_t paramCount = 0;
    uint32_t numBlocks = 1;
    rtStream_t stm = nullptr;
    rtKernelLaunchCfg_t cfg = {};
    void* argsArray[2] = {(void*)0x10, (void*)0x20};
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    rtChipType_t oldChipType = rtInstance->GetChipType();
    rtChipType_t oldGlobalChipType = GlobalContainer::GetRtChipType();

    GlobalContainer::SetRtChipType(CHIP_XPU);
    rtInstance->SetChipType(CHIP_XPU);

    error = rtFunctionGetParamInfo(static_cast<const void*>(&kernel), 0, &paramOffset, &paramSize);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtFunctionGetParamCount(static_cast<const void*>(&kernel), &paramCount);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtLaunchKernelWithArgsArray(static_cast<void*>(&kernel), numBlocks, stm, &cfg, argsArray);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    GlobalContainer::SetRtChipType(oldGlobalChipType);
    rtInstance->SetChipType(oldChipType);
}


TEST_F(ApiKernelTest, TestRtFunctionGetAvailDynUbufPerBlock_ApiImplSuccess)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    size_t dynamicUbufSize = 0;
    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api *>(&apiImpl)));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::FunctionGetAvailDynUbufPerBlock).stubs().will(returnValue(RT_ERROR_NONE));

    rtError_t error = rtFunctionGetAvailDynUbufPerBlock(rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel), 0U, &dynamicUbufSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiKernelTest, TestRtFunctionGetAvailDynUbufPerBlock_ApiImplOtherError)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    size_t dynamicUbufSize = 0;
    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api *>(&apiImpl)));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::FunctionGetAvailDynUbufPerBlock).stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    rtError_t error = rtFunctionGetAvailDynUbufPerBlock(rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel), 0U, &dynamicUbufSize);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}



TEST_F(ApiKernelTest, TestRtFunctionGetParamCount_CpuKernelNoParamSummary)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICPU);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICPU, 2048, 1024, 0, 0, 0);
    kernel.SetKernelRegisterType(RT_KERNEL_REG_TYPE_CPU);
    kernel.SetHasParamSummary(false);
    
    size_t paramCount = 0;
    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtFunctionGetParamCount(funcHandle, &paramCount);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiKernelTest, TestRtFunctionGetParamCount_KernelNoParamSummary)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel.SetHasParamSummary(false);
    
    size_t paramCount = 0;
    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtFunctionGetParamCount(funcHandle, &paramCount);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiKernelTest, TestRtFunctionGetParamCount_Success_RealDecorator)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel.SetHasParamSummary(true);
    kernel.SetParamCount(5);
    
    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[5]);
    for (size_t i = 0; i < 5; i++) {
        paramInfos[i].info.offset = i * 32;
        paramInfos[i].info.size = 32;
    }
    kernel.SetParamInfos(paramInfos);
    
    size_t paramCount = 0;
    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtFunctionGetParamCount(funcHandle, &paramCount);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(paramCount, 5);
}



TEST_F(ApiKernelTest, TestRtFunctionGetParamInfo_CpuKernelNoParamSummary)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICPU);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICPU, 2048, 1024, 0, 0, 0);
    kernel.SetKernelRegisterType(RT_KERNEL_REG_TYPE_CPU);
    kernel.SetHasParamSummary(false);
    
    size_t paramOffset = 0;
    size_t paramSize = 0;
    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtFunctionGetParamInfo(funcHandle, 0, &paramOffset, &paramSize);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiKernelTest, TestRtFunctionGetParamInfo_KernelNoParamSummary)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel.SetHasParamSummary(false);
    
    size_t paramOffset = 0;
    size_t paramSize = 0;
    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtFunctionGetParamInfo(funcHandle, 0, &paramOffset, &paramSize);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiKernelTest, TestRtFunctionGetParamInfo_Success_RealDecorator)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel.SetHasParamSummary(true);
    kernel.SetParamCount(3);
    
    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[3]);
    paramInfos[0].info.offset = 0;
    paramInfos[0].info.size = 64;
    paramInfos[1].info.offset = 64;
    paramInfos[1].info.size = 128;
    paramInfos[2].info.offset = 192;
    paramInfos[2].info.size = 256;
    kernel.SetParamInfos(paramInfos);
    
    size_t paramOffset = 0;
    size_t paramSize = 0;
    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtFunctionGetParamInfo(funcHandle, 1, &paramOffset, &paramSize);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(paramOffset, 64);
    EXPECT_EQ(paramSize, 128);
}

TEST_F(ApiKernelTest, TestRtFunctionGetParamInfo_ParamIndexOutOfRange)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel.SetHasParamSummary(true);
    kernel.SetParamCount(3);
    
    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[3]);
    paramInfos[0].info.offset = 0;
    paramInfos[0].info.size = 64;
    paramInfos[1].info.offset = 64;
    paramInfos[1].info.size = 128;
    paramInfos[2].info.offset = 192;
    paramInfos[2].info.size = 256;
    kernel.SetParamInfos(paramInfos);
    
    size_t paramOffset = 0;
    size_t paramSize = 0;
    rtError_t error = rtFunctionGetParamInfo(rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel), 3, &paramOffset, &paramSize);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiKernelTest, TestRtFunctionGetParamInfo_ParamIndexMuchOutOfRange)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel.SetHasParamSummary(true);
    kernel.SetParamCount(3);
    
    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[3]);
    paramInfos[0].info.offset = 0;
    paramInfos[0].info.size = 64;
    paramInfos[1].info.offset = 64;
    paramInfos[1].info.size = 128;
    paramInfos[2].info.offset = 192;
    paramInfos[2].info.size = 256;
    kernel.SetParamInfos(paramInfos);
    
    size_t paramOffset = 0;
    size_t paramSize = 0;
    rtError_t error = rtFunctionGetParamInfo(rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel), 100, &paramOffset, &paramSize);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiKernelTest, TestRtFunctionGetAvailDynUbufPerBlock_NonSimtSuccess)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    size_t dynamicUbufSize = 1U;
    rtError_t error = rtFunctionGetAvailDynUbufPerBlock(rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel), 0U, &dynamicUbufSize);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(dynamicUbufSize, 0U);
}

TEST_F(ApiKernelTest, TestRtFunctionGetAvailDynUbufPerBlock_SimtSuccess)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel.SetKernelVfType_(static_cast<uint32_t>(AivTypeFlag::AIV_TYPE_SIMT_VF_ONLY));
    kernel.SetShareMemSize_(2048U);

    size_t dynamicUbufSize = 0U;
    rtError_t error = rtFunctionGetAvailDynUbufPerBlock(rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel), 0U, &dynamicUbufSize);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(dynamicUbufSize, static_cast<size_t>(RT_SIMT_REMAIN_UB_SIZE - 2048U));
}

TEST_F(ApiKernelTest, TestRtFunctionGetAvailDynUbufPerBlock_SimdSimtMixSuccess)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel.SetKernelVfType_(static_cast<uint32_t>(AivTypeFlag::AIV_TYPE_SIMD_SIMT_MIX_VF));
    kernel.SetShareMemSize_(4096U);

    size_t dynamicUbufSize = 0U;
    rtError_t error = rtFunctionGetAvailDynUbufPerBlock(rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel), 0U, &dynamicUbufSize);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(dynamicUbufSize, static_cast<size_t>(RT_SIMT_REMAIN_UB_SIZE - 4096U));
}

TEST_F(ApiKernelTest, TestRtFunctionGetAvailDynUbufPerBlock_SimtShareMemSizeOverflow)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel.SetKernelVfType_(static_cast<uint32_t>(AivTypeFlag::AIV_TYPE_SIMT_VF_ONLY));
    kernel.SetShareMemSize_(RT_SIMT_REMAIN_UB_SIZE + 1U);

    size_t dynamicUbufSize = 0U;
    rtError_t error = rtFunctionGetAvailDynUbufPerBlock(rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel), 0U, &dynamicUbufSize);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiKernelTest, TestRtFunctionGetAvailDynUbufPerBlock_FuncNullptr)
{
    size_t dynamicUbufSize = 0U;
    rtError_t error = rtFunctionGetAvailDynUbufPerBlock(nullptr, 0U, &dynamicUbufSize);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiKernelTest, TestRtFunctionGetAvailDynUbufPerBlock_OutputNullptr)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    rtError_t error = rtFunctionGetAvailDynUbufPerBlock(rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel), 0U, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiKernelTest, TestRtFunctionGetAvailDynUbufPerBlock_FlagsNotZero)
{
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    size_t dynamicUbufSize = 0U;
    rtError_t error = rtFunctionGetAvailDynUbufPerBlock(rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel), 1U, &dynamicUbufSize);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiKernelTest, TestRtFunctionGetAvailDynUbufPerBlock_ProgramNullptr)
{
    Kernel kernel("cpuKernelSo", "cpuFunctionName", "cpuOpType");

    size_t dynamicUbufSize = 0U;
    rtError_t error = rtFunctionGetAvailDynUbufPerBlock(rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel), 0U, &dynamicUbufSize);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_CpuKernelArgsArray)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    Kernel* kernel = CreateTestKernelForCheckArgs(
        RT_KERNEL_ATTR_TYPE_AICPU,
        RT_KERNEL_REG_TYPE_CPU,
        false
    );

    RtArgsWithType argsWithType;
    argsWithType.type = RT_ARGS_ARRAY;
    argsWithType.args.argsArrayInfo = nullptr;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    DestroyTestKernel(kernel);
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_KernelNoParamSummary)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    Kernel* kernel = CreateTestKernelForCheckArgs(
        RT_KERNEL_ATTR_TYPE_AICORE,
        RT_KERNEL_REG_TYPE_NON_CPU,
        false
    );

    RtArgsWithType argsWithType;
    argsWithType.type = RT_ARGS_ARRAY;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    DestroyTestKernel(kernel);
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_ParamCountPositiveNullArgsArrayInfo)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    Kernel* kernel = CreateTestKernelForCheckArgs(
        RT_KERNEL_ATTR_TYPE_AICORE,
        RT_KERNEL_REG_TYPE_NON_CPU,
        true,
        5
    );

    RtArgsWithType argsWithType;
    argsWithType.type = RT_ARGS_ARRAY;
    argsWithType.args.argsArrayInfo = nullptr;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    DestroyTestKernel(kernel);
}


TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtKernel_BlockDimZero)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U); // AIV_TYPE_SIMT_VF_ONLY
    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(0);

    SimtArgsArray simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {0, 1, 1}; // x = 0 should fail

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_ARRAY;
    argsWithType.args.simtArgsArray = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtKernel_NotSimtKernel)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel =
        new Kernel("testAicoreKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(0U); // AIV_TYPE_AICORE, not SIMT
    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(0);

    SimtArgsArray simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 1, 1};

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_ARRAY;
    argsWithType.args.simtArgsArray = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtKernel_NoParamSummary)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U);      // AIV_TYPE_SIMT_VF_ONLY
    kernel->SetHasParamSummary(false); // no param summary

    SimtArgsArray simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 1, 1};

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_ARRAY;
    argsWithType.args.simtArgsArray = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtKernel_Success)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U); // AIV_TYPE_SIMT_VF_ONLY
    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(0);

    SimtArgsArray simtArgs = {};
    simtArgs.gridDim = {2, 2, 2};
    simtArgs.blockDim = {4, 4, 4};
    simtArgs.dynUbufSize = 1024;

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_ARRAY;
    argsWithType.args.simtArgsArray = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtHostArgs_GridDimZero)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U); // AIV_TYPE_SIMT_VF_ONLY
    kernel->SetHasParamSummary(true);

    char hostArgsBuf[128];
    SimtArgsHost simtArgs = {};
    simtArgs.gridDim = {0, 1, 1}; // x = 0 should fail
    simtArgs.blockDim = {1, 1, 1};
    simtArgs.argsSize = 128;
    simtArgs.hostArgs = hostArgsBuf;

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_HOST;
    argsWithType.args.simtArgsHost = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtHostArgs_Success)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U); // AIV_TYPE_SIMT_VF_ONLY
    kernel->SetHasParamSummary(true);

    char hostArgsBuf[128];
    SimtArgsHost simtArgs = {};
    simtArgs.gridDim = {2, 2, 2};
    simtArgs.blockDim = {4, 4, 4};
    simtArgs.argsSize = 128;
    simtArgs.hostArgs = hostArgsBuf;
    simtArgs.dynUbufSize = 2048;

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_HOST;
    argsWithType.args.simtArgsHost = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtHostArgs_BlockDimZero)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U); // AIV_TYPE_SIMT_VF_ONLY

    char hostArgsBuf[128];
    SimtArgsHost simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {0, 1, 1}; // x = 0 should fail
    simtArgs.argsSize = 128;
    simtArgs.hostArgs = hostArgsBuf;

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_HOST;
    argsWithType.args.simtArgsHost = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtHostArgs_ArgsSizeZero)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U); // AIV_TYPE_SIMT_VF_ONLY

    SimtArgsHost simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 1, 1};
    simtArgs.argsSize = 0; // should fail
    simtArgs.hostArgs = nullptr;

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_HOST;
    argsWithType.args.simtArgsHost = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtHostArgs_NullHostArgs)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U); // AIV_TYPE_SIMT_VF_ONLY

    SimtArgsHost simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 1, 1};
    simtArgs.argsSize = 128;
    simtArgs.hostArgs = nullptr; // should fail

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_HOST;
    argsWithType.args.simtArgsHost = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtHostArgs_PlaceHolderNull)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U); // AIV_TYPE_SIMT_VF_ONLY

    char hostArgsBuf[128];
    SimtArgsHost simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 1, 1};
    simtArgs.argsSize = 128;
    simtArgs.hostArgs = hostArgsBuf;
    simtArgs.placeHolderNum = 2;
    simtArgs.placeHolderArray = nullptr; // should fail when placeHolderNum > 0

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_HOST;
    argsWithType.args.simtArgsHost = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtHostArgs_PlaceHolderOffsetInvalid)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U); // AIV_TYPE_SIMT_VF_ONLY
    kernel->SetHasParamSummary(true);

    char hostArgsBuf[128];
    rtPlaceHolderInfo_t placeHolders[2];
    placeHolders[0].addrOffset = 200; // > argsSize, should fail
    placeHolders[0].dataOffset = 10;

    SimtArgsHost simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 1, 1};
    simtArgs.argsSize = 128;
    simtArgs.hostArgs = hostArgsBuf;
    simtArgs.placeHolderNum = 2;
    simtArgs.placeHolderArray = placeHolders;

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_HOST;
    argsWithType.args.simtArgsHost = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtHostArgs_PlaceHolderSuccess)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U); // AIV_TYPE_SIMT_VF_ONLY
    kernel->SetHasParamSummary(true);

    char hostArgsBuf[128];
    rtPlaceHolderInfo_t placeHolders[2];
    placeHolders[0].addrOffset = 10;
    placeHolders[0].dataOffset = 20;
    placeHolders[1].addrOffset = 30;
    placeHolders[1].dataOffset = 40;

    SimtArgsHost simtArgs = {};
    simtArgs.gridDim = {2, 2, 2};
    simtArgs.blockDim = {4, 4, 4};
    simtArgs.argsSize = 128;
    simtArgs.hostArgs = hostArgsBuf;
    simtArgs.placeHolderNum = 2;
    simtArgs.placeHolderArray = placeHolders;
    simtArgs.dynUbufSize = 2048;

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_HOST;
    argsWithType.args.simtArgsHost = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtLaunchSIMTKernelWithArgsArray_XpuNotSupport)
{
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    rtChipType_t preChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_XPU);
    GlobalContainer::SetRtChipType(CHIP_XPU);

    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api*>(&apiImpl)));

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    rtDim3 gridDim = {1, 1, 1};
    rtDim3 blockDim = {1, 1, 1};
    size_t dynUbufSize = 0;
    rtStream_t stm = nullptr;
    rtKernelLaunchCfg_t cfg = {};
    void* argsArray[2] = {(void*)0x10, (void*)0x20};

    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtLaunchSIMTKernelWithArgsArray(
        funcHandle, gridDim, blockDim, dynUbufSize, stm, &cfg, argsArray);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtInstance->SetChipType(preChipType);
    GlobalContainer::SetRtChipType(preChipType);
}

TEST_F(ApiKernelTest, TestRtLaunchSIMTKernelWithArgsArray_KernelInvalid)
{
    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api*>(&apiImpl)));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LaunchKernelV2).stubs().will(returnValue(RT_ERROR_KERNEL_INVALID));

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    rtDim3 gridDim = {1, 1, 1};
    rtDim3 blockDim = {1, 1, 1};
    size_t dynUbufSize = 0;
    rtStream_t stm = nullptr;
    rtKernelLaunchCfg_t cfg = {};
    void* argsArray[2] = {(void*)0x10, (void*)0x20};

    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtLaunchSIMTKernelWithArgsArray(
        funcHandle, gridDim, blockDim, dynUbufSize, stm, &cfg, argsArray);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_HANDLE);
}

TEST_F(ApiKernelTest, TestRtLaunchSIMTKernelWithArgsArray_FeatureNotSupport)
{
    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api*>(&apiImpl)));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LaunchKernelV2).stubs().will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    rtDim3 gridDim = {1, 1, 1};
    rtDim3 blockDim = {1, 1, 1};
    size_t dynUbufSize = 0;
    rtStream_t stm = nullptr;
    rtKernelLaunchCfg_t cfg = {};
    void* argsArray[2] = {(void*)0x10, (void*)0x20};

    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtLaunchSIMTKernelWithArgsArray(
        funcHandle, gridDim, blockDim, dynUbufSize, stm, &cfg, argsArray);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiKernelTest, TestRtLaunchSIMTKernelWithArgsArray_OtherError)
{
    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api*>(&apiImpl)));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LaunchKernelV2).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    rtDim3 gridDim = {1, 1, 1};
    rtDim3 blockDim = {1, 1, 1};
    size_t dynUbufSize = 0;
    rtStream_t stm = nullptr;
    rtKernelLaunchCfg_t cfg = {};
    void* argsArray[2] = {(void*)0x10, (void*)0x20};

    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtLaunchSIMTKernelWithArgsArray(
        funcHandle, gridDim, blockDim, dynUbufSize, stm, &cfg, argsArray);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiKernelTest, TestRtLaunchSIMTKernelWithHostArgs_XpuNotSupport)
{
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    rtChipType_t preChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_XPU);
    GlobalContainer::SetRtChipType(CHIP_XPU);

    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api*>(&apiImpl)));

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    rtDim3 gridDim = {1, 1, 1};
    rtDim3 blockDim = {1, 1, 1};
    size_t dynUbufSize = 0;
    rtStream_t stm = nullptr;
    rtKernelLaunchCfg_t cfg = {};
    char hostArgs[128];
    rtPlaceHolderInfo_t placeHolders[2];

    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtLaunchSIMTKernelWithHostArgs(
        funcHandle, gridDim, blockDim, dynUbufSize, stm, &cfg, hostArgs, 128, placeHolders, 2);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtInstance->SetChipType(preChipType);
    GlobalContainer::SetRtChipType(preChipType);
}

TEST_F(ApiKernelTest, TestRtLaunchSIMTKernelWithHostArgs_KernelInvalid)
{
    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api*>(&apiImpl)));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LaunchKernelV2).stubs().will(returnValue(RT_ERROR_KERNEL_INVALID));

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    rtDim3 gridDim = {1, 1, 1};
    rtDim3 blockDim = {1, 1, 1};
    size_t dynUbufSize = 0;
    rtStream_t stm = nullptr;
    rtKernelLaunchCfg_t cfg = {};
    char hostArgs[128];
    rtPlaceHolderInfo_t placeHolders[2];

    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtLaunchSIMTKernelWithHostArgs(
        funcHandle, gridDim, blockDim, dynUbufSize, stm, &cfg, hostArgs, 128, placeHolders, 2);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_HANDLE);
}

TEST_F(ApiKernelTest, TestRtLaunchSIMTKernelWithHostArgs_FeatureNotSupport)
{
    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api*>(&apiImpl)));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LaunchKernelV2).stubs().will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    rtDim3 gridDim = {1, 1, 1};
    rtDim3 blockDim = {1, 1, 1};
    size_t dynUbufSize = 0;
    rtStream_t stm = nullptr;
    rtKernelLaunchCfg_t cfg = {};
    char hostArgs[128];
    rtPlaceHolderInfo_t placeHolders[2];

    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtLaunchSIMTKernelWithHostArgs(
        funcHandle, gridDim, blockDim, dynUbufSize, stm, &cfg, hostArgs, 128, placeHolders, 2);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiKernelTest, TestRtLaunchSIMTKernelWithHostArgs_OtherError)
{
    ApiImpl apiImpl;
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api*>(&apiImpl)));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LaunchKernelV2).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel kernel("testKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);

    rtDim3 gridDim = {1, 1, 1};
    rtDim3 blockDim = {1, 1, 1};
    size_t dynUbufSize = 0;
    rtStream_t stm = nullptr;
    rtKernelLaunchCfg_t cfg = {};
    char hostArgs[128];
    rtPlaceHolderInfo_t placeHolders[2];

    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(&kernel);
    rtError_t error = rtLaunchSIMTKernelWithHostArgs(
        funcHandle, gridDim, blockDim, dynUbufSize, stm, &cfg, hostArgs, 128, placeHolders, 2);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtArray_NullSimtArgs)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U);
    kernel->SetHasParamSummary(true);

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_ARRAY;
    argsWithType.args.simtArgsArray = nullptr;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtArray_GridDimYZero)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U);
    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(0);

    SimtArgsArray simtArgs = {};
    simtArgs.gridDim = {1, 0, 1};
    simtArgs.blockDim = {1, 1, 1};

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_ARRAY;
    argsWithType.args.simtArgsArray = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtArray_GridDimZZero)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U);
    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(0);

    SimtArgsArray simtArgs = {};
    simtArgs.gridDim = {1, 1, 0};
    simtArgs.blockDim = {1, 1, 1};

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_ARRAY;
    argsWithType.args.simtArgsArray = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtArray_BlockDimYZero)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U);
    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(0);

    SimtArgsArray simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 0, 1};

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_ARRAY;
    argsWithType.args.simtArgsArray = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtArray_BlockDimZZero)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U);
    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(0);

    SimtArgsArray simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 1, 0};

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_ARRAY;
    argsWithType.args.simtArgsArray = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtArray_SimdSimtMixVf)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(4U);
    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(0);

    SimtArgsArray simtArgs = {};
    simtArgs.gridDim = {2, 2, 2};
    simtArgs.blockDim = {4, 4, 4};

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_ARRAY;
    argsWithType.args.simtArgsArray = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtArray_ParamCountPositiveNullArgsArray)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U);
    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(5);

    SimtArgsArray simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 1, 1};
    simtArgs.argsArrayInfo = nullptr;

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_ARRAY;
    argsWithType.args.simtArgsArray = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtArray_ParamCountPositiveWithArgsArray)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U);
    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(2);

    void* argsArray[2] = {(void*)0x10, (void*)0x20};
    SimtArgsArray simtArgs = {};
    simtArgs.gridDim = {2, 2, 2};
    simtArgs.blockDim = {4, 4, 4};
    simtArgs.argsArrayInfo = argsArray;

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_ARRAY;
    argsWithType.args.simtArgsArray = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtHost_NullSimtArgs)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U);

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_HOST;
    argsWithType.args.simtArgsHost = nullptr;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtHost_GridDimYZero)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U);

    char hostArgsBuf[128];
    SimtArgsHost simtArgs = {};
    simtArgs.gridDim = {1, 0, 1};
    simtArgs.blockDim = {1, 1, 1};
    simtArgs.argsSize = 128;
    simtArgs.hostArgs = hostArgsBuf;

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_HOST;
    argsWithType.args.simtArgsHost = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtHost_GridDimZZero)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U);

    char hostArgsBuf[128];
    SimtArgsHost simtArgs = {};
    simtArgs.gridDim = {1, 1, 0};
    simtArgs.blockDim = {1, 1, 1};
    simtArgs.argsSize = 128;
    simtArgs.hostArgs = hostArgsBuf;

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_HOST;
    argsWithType.args.simtArgsHost = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtHost_BlockDimYZero)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U);

    char hostArgsBuf[128];
    SimtArgsHost simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 0, 1};
    simtArgs.argsSize = 128;
    simtArgs.hostArgs = hostArgsBuf;

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_HOST;
    argsWithType.args.simtArgsHost = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtHost_BlockDimZZero)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U);

    char hostArgsBuf[128];
    SimtArgsHost simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 1, 0};
    simtArgs.argsSize = 128;
    simtArgs.hostArgs = hostArgsBuf;

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_HOST;
    argsWithType.args.simtArgsHost = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtHost_DataOffsetInvalid)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(3U);

    char hostArgsBuf[128];
    rtPlaceHolderInfo_t placeHolders[2];
    placeHolders[0].addrOffset = 10;
    placeHolders[0].dataOffset = 200;

    SimtArgsHost simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 1, 1};
    simtArgs.argsSize = 128;
    simtArgs.hostArgs = hostArgsBuf;
    simtArgs.placeHolderNum = 2;
    simtArgs.placeHolderArray = placeHolders;

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_HOST;
    argsWithType.args.simtArgsHost = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtHost_SimdSimtMixVf)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel = new Kernel("testSimtKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(4U);
    kernel->SetHasParamSummary(true);

    char hostArgsBuf[128];
    SimtArgsHost simtArgs = {};
    simtArgs.gridDim = {2, 2, 2};
    simtArgs.blockDim = {4, 4, 4};
    simtArgs.argsSize = 128;
    simtArgs.hostArgs = hostArgsBuf;

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_HOST;
    argsWithType.args.simtArgsHost = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete kernel;
}

TEST_F(ApiKernelTest, TestRtCheckArgsWithType_SimtHost_NotSimtKernel)
{
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    uint64_t tilingKey = 0;
    Kernel* kernel =
        new Kernel("testAicoreKernel", tilingKey, &program, RT_KERNEL_ATTR_TYPE_AICORE, 2048, 1024, 0, 0, 0);
    kernel->SetKernelVfType_(0U);

    char hostArgsBuf[128];
    SimtArgsHost simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 1, 1};
    simtArgs.argsSize = 128;
    simtArgs.hostArgs = hostArgsBuf;

    RtArgsWithType argsWithType;
    argsWithType.type = RT_SIMT_ARGS_HOST;
    argsWithType.args.simtArgsHost = &simtArgs;

    rtError_t error = apiError.CheckArgsWithType(kernel, &argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}