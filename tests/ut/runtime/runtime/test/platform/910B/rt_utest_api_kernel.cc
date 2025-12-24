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

class KernelApiTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"KernelApiTest test start start. "<<std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout<<"KernelApiTest test start end. "<<std::endl;

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

TEST_F(KernelApiTest, TestRtsRegKernelLaunchFillFuncSuccess)
{
    Runtime *rtInstance = Runtime::Instance();
    MOCKER_CPP_VIRTUAL(rtInstance, &Runtime::RegKernelLaunchFillFunc).stubs().will(returnValue(RT_ERROR_NONE));

    rtBinHandle binHandle;
    rtKernelLaunchFillFunc callback;
    rtError_t error = rtsRegKernelLaunchFillFunc("testSymbol", callback);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(KernelApiTest, TestRtsUnRegKernelLaunchFillFuncSuccess)
{
    Runtime *rtInstance = Runtime::Instance();
    MOCKER_CPP_VIRTUAL(rtInstance, &Runtime::UnRegKernelLaunchFillFunc).stubs().will(returnValue(RT_ERROR_NONE));

    rtBinHandle binHandle;
    rtKernelLaunchFillFunc callback;
    rtError_t error = rtsUnRegKernelLaunchFillFunc("testSymbol");
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(KernelApiTest, TestRtsBinaryLoadFromFileSuccess)
{
    MOCKER_CPP(&BinaryLoader::Load).stubs().will(returnValue(RT_ERROR_NONE));
    char *path = "test_path";
    rtLoadBinaryConfig_t cfg;
    void *handle;
    rtError_t error = rtsBinaryLoadFromFile(path, &cfg, &handle);

    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(KernelApiTest, TestRtsBinaryLoadFromDataSuccess)
{
    MOCKER_CPP(&BinaryLoader::Load).stubs().will(returnValue(RT_ERROR_NONE));
    uint32_t tmp;
    rtLoadBinaryConfig_t cfg;
    void *handle;
    rtError_t error = rtsBinaryLoadFromData(static_cast<void*>(&tmp), 1024, &cfg, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(KernelApiTest, TestRtsBinaryUnloadSuccess)
{
    ApiImpl apiImpl;
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::BinaryUnLoad).stubs().will(returnValue(RT_ERROR_NONE));
    void *handle;
    rtError_t error = rtsBinaryUnload(&handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(KernelApiTest, TestFuncGetAddr)
{
    ElfProgram program;
    uint64_t tilingKey = 0;
    Kernel kernel(nullptr, "testKernelName", tilingKey, &program, 2048, 1024, 0, 0, 0);

    void* func1;
    void* func2;
    rtError_t error = rtsFuncGetAddr(&kernel, &func1, &func2);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(KernelApiTest, TestRtsFuncGetByEntrySuccess)
{
    ApiImpl apiImpl;
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::BinaryGetFunctionByEntry).stubs().will(returnValue(RT_ERROR_NONE));
    ElfProgram program;
    rtBinHandle binHandle = &program;
    void *handle;
    rtError_t error = rtsFuncGetByEntry(binHandle, 1024, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(KernelApiTest, TestRtsGetNonCacheAddrOffset)
{
    ApiImpl apiImpl;
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetL2CacheOffset).stubs().will(returnValue(RT_ERROR_NONE));

    uint64_t offset;
    rtError_t error = rtsGetNonCacheAddrOffset(0, &offset);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(KernelApiTest, TestFuncGetName)
{
    ElfProgram program;
    uint64_t tilingKey = 0;
    Kernel kernel(nullptr, "testKernelName", tilingKey, &program, 2048, 1024, 0, 0, 0);
    char_t name[128];
    rtError_t error = rtsFuncGetName(&kernel, 128, name);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(KernelApiTest, TestFuncGetNameFail)
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

TEST_F(KernelApiTest, TestFuncGetNameMaxLenFail)
{
    ElfProgram program;
    uint64_t tilingKey = 0;
    Kernel kernel(nullptr, "testKernelName", tilingKey, &program, 2048, 1024, 0, 0, 0);
    char_t name[128];
    rtError_t error = rtsFuncGetName(&kernel, 1, name);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(KernelApiTest, TestCpuKernelLaunch)
{
    rtError_t error = rtsLaunchCpuKernel(nullptr, 1, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(KernelApiTest, TestRtsLaunchKernelWithDevArgs)
{
    rtError_t error = rtsLaunchKernelWithDevArgs(nullptr, 1, nullptr, nullptr, nullptr, 0U, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(KernelApiTest, TestBinaryLoadFromFileFailed)
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

TEST_F(KernelApiTest, TestBinaryLoadFromDataFailed)
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

TEST_F(KernelApiTest, TestFuncGetByEntry)
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

TEST_F(KernelApiTest, TestFuncGetAddrWithProgramNull)
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

TEST_F(KernelApiTest, MemcpyBatch)
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

TEST_F(KernelApiTest, MemcpyBatchAsync)
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

TEST_F(KernelApiTest, TestFuncGetAttribute)
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


TEST_F(KernelApiTest, LAUNCH_ALL_KERNEL_TEST_1)
{
    size_t MAX_LENGTH = 75776;
    FILE *master = NULL;
    master = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o", "rb");
    if (NULL == master)
    {
        printf ("master open error\n");
        return;
    }

    char m_data[MAX_LENGTH];
    size_t m_len = 0;
    m_len = fread(m_data, sizeof(char), MAX_LENGTH, master);
    fclose(master);

    rtError_t error;
    void *m_handle;
    Program *m_prog;
    rtDevBinary_t master_bin;
    master_bin.magic = RT_DEV_BINARY_MAGIC_ELF;
    master_bin.version = 2;
    master_bin.data = m_data;
    master_bin.length = m_len;

    error = rtRegisterAllKernel(&master_bin, &m_handle);
    error = rtSetExceptionExtInfo(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    rtArgsSizeInfo_t argsSizeInfo;
    argsSizeInfo.infoAddr = (void *)0x12345678;
    argsSizeInfo.atomicIndex = 0x87654321;
    error = rtSetExceptionExtInfo(&argsSizeInfo);

    EXPECT_EQ(error, RT_ERROR_NONE);
    uint64_t arg = 0x1234567890;
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    error = rtKernelLaunchWithHandle(m_handle, 355, 1, &argsInfo, NULL, NULL, "info");

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDevBinaryUnRegister(m_handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(KernelApiTest, LAUNCH_KERNEL_WITH_HANDLE_NO_TILINGKEY_01)
{
    size_t MAX_LENGTH = 75776;
    FILE *master = NULL;
    master = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o", "rb");
    if (NULL == master)
    {
        printf ("master open error\n");
        return;
    }

    char m_data[MAX_LENGTH];
    size_t m_len = 0;
    m_len = fread(m_data, sizeof(char), MAX_LENGTH, master);
    fclose(master);

    rtError_t error;
    void *m_handle;
    Program *m_prog;
    rtDevBinary_t master_bin;
    master_bin.magic = RT_DEV_BINARY_MAGIC_ELF;
    master_bin.version = 2;
    master_bin.data = m_data;
    master_bin.length = m_len;

    error = rtRegisterAllKernel(&master_bin, &m_handle);
    error = rtSetExceptionExtInfo(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    rtArgsSizeInfo_t argsSizeInfo;
    argsSizeInfo.infoAddr = (void *)0x12345678;
    argsSizeInfo.atomicIndex = 0x87654321;
    error = rtSetExceptionExtInfo(&argsSizeInfo);

    EXPECT_EQ(error, RT_ERROR_NONE);
    uint64_t arg = 0x1234567890;
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    error = rtKernelLaunchWithHandle(m_handle, DEFAULT_TILING_KEY, 1, &argsInfo, NULL, NULL, "info");

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDevBinaryUnRegister(m_handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(KernelApiTest, LAUNCH_ALL_KERNEL_TEST_3)
{
    size_t MAX_LENGTH = 75776;
    FILE *master = NULL;
    master = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o", "rb");
    if (NULL == master)
    {
        printf ("master open error\n");
        return;
    }

    char m_data[MAX_LENGTH];
    size_t m_len = 0;
    m_len = fread(m_data, sizeof(char), MAX_LENGTH, master);
    fclose(master);

    rtError_t error;
    void *m_handle;
    Program *m_prog;
    rtDevBinary_t master_bin;
    master_bin.magic = RT_DEV_BINARY_MAGIC_ELF;
    master_bin.version = 2;
    master_bin.data = m_data;
    master_bin.length = m_len;

    error = rtRegisterAllKernel(&master_bin, &m_handle);

    uint64_t arg = 0x1234567890;
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);

    rtTaskCfgInfo_t taskCfgInfo = {};
    taskCfgInfo.qos = 1;
    taskCfgInfo.partId = 1;
    error = rtKernelLaunchWithHandleV2(m_handle, 355, 1, &argsInfo, NULL, NULL, &taskCfgInfo);

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDevBinaryUnRegister(m_handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(KernelApiTest, LAUNCH_ALL_KERNEL_TEST_4)
{
    size_t MAX_LENGTH = 75776;
    FILE *master = nullptr;
    master = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o", "rb");
    if (master == nullptr)
    {
        printf ("master open error\n");
        return;
    }

    char m_data[MAX_LENGTH];
    size_t m_len = 0;
    m_len = fread(m_data, sizeof(char), MAX_LENGTH, master);
    fclose(master);

    rtError_t error;
    void *m_handle;
    Program *m_prog;
    rtDevBinary_t master_bin;
    master_bin.magic = RT_DEV_BINARY_MAGIC_ELF;
    master_bin.version = 2;
    master_bin.data = m_data;
    master_bin.length = m_len;

    error = rtRegisterAllKernel(&master_bin, &m_handle);

    uint64_t arg = 0x1234567890;
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);

    rtTaskCfgInfo_t taskCfgInfo = {};
    taskCfgInfo.qos = 1;
    taskCfgInfo.partId = 1;
    LaunchArgment &launchArg = ThreadLocalContainer::GetLaunchArg();
    launchArg.argCount = 0U;
    error = rtVectorCoreKernelLaunchWithHandle(m_handle, 355, 1, &argsInfo, NULL, NULL, &taskCfgInfo);

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDevBinaryUnRegister(m_handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
