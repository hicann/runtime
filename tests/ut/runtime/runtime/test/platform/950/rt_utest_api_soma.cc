/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "../../rt_utest_api.hpp"
#include "platform_manager_v2.h"
#include "rt_unwrap.h"
#include "aicpu_timeout_control.h"

rtError_t LaunchHostFuncNormalStub(
    cce::runtime::ApiImpl* impl, Stream* const stm, const rtCallback_t callBackFunc, void* const fnData)
{
    if (callBackFunc == nullptr) {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    (void)callBackFunc(fnData);
    return RT_ERROR_NONE;
}

rtError_t LaunchHostFuncFailStub(
    cce::runtime::ApiImpl* impl, Stream* const stm, const rtCallback_t callBackFunc, void* const fnData)
{
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

class ApiTestSoma950 : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        RawDevice* rawDevice = new RawDevice(0);
        delete rawDevice;
        std::cout << "engine test start" << std::endl;
    }

    virtual void SetUp()
    {
        MOCKER(AicpuTimeoutControl::CheckKernelSupported).stubs().will(returnValue(RT_ERROR_NONE));
        (void)rtSetDevice(0);
        RawDevice* rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        MOCKER_CPP(&ApiImplSoma::SomaAicpuKernelLaunch).stubs().will(returnValue(RT_ERROR_NONE));
        delete rawDevice;
    }

    virtual void TearDown()
    {
        (void)rtDeviceReset(0);
        GlobalMockObject::verify();
    }
};

TEST_F(ApiTestSoma950, MallocFromPoolAsyncSuccess)
{
    rtError_t error;
    rtStream_t streamId;
    error = rtStreamCreate(&streamId, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RawDevice* device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(*device, &RawDevice::CheckFeatureSupport).stubs().with(mockcpp::any()).will(returnValue(true));

    rtMemPool_t memPoolId = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1, .devId = 0, .handleType = RT_MEM_HANDLE_TYPE_POSIX, .maxSize = (10UL << 30), .reserve = 0};
    uint64_t fakeVa = (1ULL << 32);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::StreamMemPoolCreate)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(fakeVa))
        .will(returnValue(RT_ERROR_NONE));
    error = rtMemPoolCreate(&memPoolId, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    size_t size = 1;
    void* devPtr = nullptr;
    rtMemType_t asyncpolicy = RT_MEMORY_DEFAULT;
    rtError_t ret = rtMemPoolMallocAsync(&devPtr, size, memPoolId, streamId);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtMemPoolFreeAsync(devPtr, streamId);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    error = rtMemPoolDestroy(memPoolId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete device;
}

TEST_F(ApiTestSoma950, rt_free_from_mempool_normal)
{
    rtError_t error;
    rtStream_t stream1;
    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;

    RawDevice* device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(*device, &RawDevice::CheckFeatureSupport).stubs().with(mockcpp::any()).will(returnValue(true));

    rtMemPool_t memPoolId = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1, .devId = 0, .handleType = RT_MEM_HANDLE_TYPE_POSIX, .maxSize = (10UL << 30), .reserve = 0};
    uint64_t fakeVa = (1ULL << 32);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::StreamMemPoolCreate)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(fakeVa))
        .will(returnValue(RT_ERROR_NONE));
    error = rtMemPoolCreate(&memPoolId, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);
    size_t size = (2UL * 1024 * 1024);
    void* ptr = nullptr;
    const int32_t stmId = 0;
    rtError_t ret = SomaApi::AllocFromMemPool(&ptr, size, memPoolId, stmId, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtMemPoolFreeAsync(ptr, stream1);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    size = (16UL * 1024 * 1024);
    ret = SomaApi::AllocFromMemPool(&ptr, size, memPoolId, stmId, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtMemPoolFreeAsync(ptr, stream1);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    size = (10UL * 1024 * 1024 * 1024) - (16UL * 1024 * 1024) - (2UL * 1024 * 1024);
    ret = SomaApi::AllocFromMemPool(&ptr, size, memPoolId, stmId, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtMemPoolFreeAsync(ptr, stream1);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    error = rtMemPoolDestroy(memPoolId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete device;
}

TEST_F(ApiTestSoma950, rt_free_from_mempool_invaild_ptr)
{
    rtError_t error;
    rtStream_t stream1;
    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;

    RawDevice* device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(*device, &RawDevice::CheckFeatureSupport).stubs().with(mockcpp::any()).will(returnValue(true));

    rtMemPool_t memPoolId = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1, .devId = 0, .handleType = RT_MEM_HANDLE_TYPE_POSIX, .maxSize = (10UL << 30), .reserve = 0};
    uint64_t fakeVa = (1ULL << 32);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::StreamMemPoolCreate)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(fakeVa))
        .will(returnValue(RT_ERROR_NONE));
    error = rtMemPoolCreate(&memPoolId, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    void* ptr = nullptr;
    rtError_t ret = rtMemPoolFreeAsync(ptr, stream1);
    EXPECT_NE(ret, RT_ERROR_NONE);

    size_t size = (6ULL << 10);
    const int32_t stmId = 0;
    ret = SomaApi::AllocFromMemPool(&ptr, size, memPoolId, stmId, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    error = rtMemPoolDestroy(memPoolId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete device;
}

TEST_F(ApiTestSoma950, rt_free_from_mempool_nullptr_stm)
{
    rtError_t error;
    rtStream_t stream1 = nullptr;
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;

    RawDevice* device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(*device, &RawDevice::CheckFeatureSupport).stubs().with(mockcpp::any()).will(returnValue(true));

    rtMemPool_t memPoolId = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1, .devId = 0, .handleType = RT_MEM_HANDLE_TYPE_POSIX, .maxSize = (10UL << 30), .reserve = 0};
    uint64_t fakeVa = (1ULL << 32);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::StreamMemPoolCreate)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(fakeVa))
        .will(returnValue(RT_ERROR_NONE));
    error = rtMemPoolCreate(&memPoolId, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    size_t size = 32;
    void* ptr = nullptr;
    const int32_t stmId = 0;
    rtError_t ret = SomaApi::AllocFromMemPool(&ptr, size, memPoolId, stmId, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtMemPoolFreeAsync(ptr, stream1);
    EXPECT_NE(ret, RT_ERROR_NONE);

    error = rtMemPoolDestroy(memPoolId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete device;
}

TEST_F(ApiTestSoma950, rt_sync_alloc_and_async_free)
{
    ApiImpl* apiImplObj = static_cast<ApiImpl*>(Runtime::Instance()->ApiImpl_());
    MOCKER_CPP_VIRTUAL(*apiImplObj, &ApiImpl::LaunchHostFunc).stubs().will(invoke(LaunchHostFuncNormalStub));

    RawDevice* device = new RawDevice(0);
    device->Init();
    rtStream_t streamId;
    rtError_t ret = rtStreamCreate(&streamId, 0);
    ASSERT_EQ(ret, RT_ERROR_NONE);

    size_t size = (1UL << 30);
    void* ptr;
    ret = rtMalloc(&ptr, size, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    ASSERT_EQ(ret, RT_ERROR_NONE);

    ret = rtMemPoolFreeAsync(ptr, streamId);
    ASSERT_EQ(ret, RT_ERROR_NONE);

    rtStreamSynchronize(streamId);

    delete device;
}

TEST_F(ApiTestSoma950, rt_sync_alloc_and_async_free_failed)
{
    ApiImpl* apiImplObj = static_cast<ApiImpl*>(Runtime::Instance()->ApiImpl_());
    MOCKER_CPP_VIRTUAL(*apiImplObj, &ApiImpl::LaunchHostFunc).stubs().will(invoke(LaunchHostFuncFailStub));

    RawDevice* device = new RawDevice(0);
    device->Init();
    rtStream_t streamId;
    rtError_t ret = rtStreamCreate(&streamId, 0);
    ASSERT_EQ(ret, RT_ERROR_NONE);

    size_t size = (1UL << 30);
    void* ptr;
    ret = rtMalloc(&ptr, size, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    ASSERT_EQ(ret, RT_ERROR_NONE);

    ret = rtMemPoolFreeAsync(ptr, streamId);
    ASSERT_NE(ret, RT_ERROR_NONE);

    rtStreamSynchronize(streamId);

    ret = rtFree(ptr);
    ASSERT_EQ(ret, RT_ERROR_NONE);

    delete device;
}

drvError_t halMemFreeNormalStub(void* pp)
{
    RT_LOG(RT_LOG_DEBUG, "halMemFree Normal ptr=%" PRIx64 ".", RtPtrToValue(pp));
    return DRV_ERROR_NONE;
}

TEST_F(ApiTestSoma950, rt_async_alloc_and_sync_free)
{
    RawDevice* device = new RawDevice(0);
    device->Init();
    rtStream_t streamId;
    rtError_t ret = rtStreamCreate(&streamId, 0);
    ASSERT_EQ(ret, RT_ERROR_NONE);

    size_t totalSize = (16UL << 30);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(*device, &RawDevice::CheckFeatureSupport).stubs().with(mockcpp::any()).will(returnValue(true));

    rtMemPool_t memPoolId;
    rtMemPoolProps poolProps = {
        .side = 1, .devId = 0, .handleType = RT_MEM_HANDLE_TYPE_POSIX, .maxSize = (1UL << 30), .reserve = 0};
    uint64_t fakeVa = (1ULL << 32);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::StreamMemPoolCreate)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(fakeVa))
        .will(returnValue(RT_ERROR_NONE));
    ret = rtMemPoolCreate(&memPoolId, &poolProps);
    ASSERT_EQ(ret, RT_ERROR_NONE);

    size_t size = (1UL << 30);
    void* ptr = nullptr;
    ret = rtMemPoolMallocAsync(&ptr, size, memPoolId, streamId);
    ASSERT_EQ(ret, RT_ERROR_NONE);

    uint64_t expectSize = size;
    MOCKER_CPP(&halMemPoolTrim)
        .stubs()
        .with(mockcpp::any(), outBoundP(&expectSize, sizeof(expectSize)), mockcpp::any(), mockcpp::any())
        .will(returnValue(DRV_ERROR_NONE));

    rtStreamSynchronize(streamId);

    MOCKER_CPP(&halMemFree).stubs().will(returnValue(DRV_ERROR_NONE)).then(invoke(halMemFreeNormalStub));

    ret = rtFree(ptr);
    ASSERT_EQ(ret, RT_ERROR_NONE);

    ret = rtMemPoolDestroy(memPoolId);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    delete device;
}
