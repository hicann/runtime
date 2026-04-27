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

class CloudV2ApiTestSOMA : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        RawDevice *rawDevice = new RawDevice(0);
        delete rawDevice;
        std::cout<<"engine test start"<<std::endl;
    }

    static void TearDownTestCase()
    {
    }

    virtual void SetUp()
    {
        (void)rtSetDevice(0);
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
    }

    virtual void TearDown()
    {
        (void)rtDeviceReset(0);
        GlobalMockObject::verify();
    }

private:
    rtChipType_t oldChipType;
};

TEST_F(CloudV2ApiTestSOMA, rtMemPoolCreate)
{
    RawDevice *device = new RawDevice(0);
    device->Init();

    rtMemPool_t memPool = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (10UL << 30),
        .reserve = 0
    };
    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));
    rtError_t error = rtMemPoolCreate(&memPool, &poolProps);
    auto memPool1 = memPool;
    EXPECT_EQ(error, RT_ERROR_NONE);
    poolProps.maxSize = (5UL * 1024 * 1024 * 1024);
    error = rtMemPoolCreate(&memPool, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemPoolDestroy(memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMemPoolDestroy(memPool1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete device;
}

TEST_F(CloudV2ApiTestSOMA, rtMemPoolCreateAndDestroy)
{
    RawDevice *device = new RawDevice(0);
    device->Init();

    EXPECT_EQ(DEVICE_POOL_VADDR_SIZE, (2ULL << 40));

    rtMemPool_t memPool = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (3UL << 39),
        .reserve = 0
    };
    size_t totalSize = (2ULL << 40);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));
    rtError_t error = rtMemPoolCreate(&memPool, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    poolProps.maxSize = (2UL << 39);
    error = rtMemPoolCreate(&memPool, &poolProps);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtMemPoolDestroy(memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemPoolCreate(&memPool, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemPoolDestroy(memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete device;
}

TEST_F(CloudV2ApiTestSOMA, rtMemPoolDestroy)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));
    rtMemPool_t memPool = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (10UL << 30),
        .reserve = 0
    };
    rtError_t error = rtMemPoolCreate(&memPool, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemPoolDestroy(memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete device;
}

TEST_F(CloudV2ApiTestSOMA, rtMemPoolSetAttr)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));
    rtMemPool_t memPool = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (10UL << 30),
        .reserve= 0
    };
    rtError_t error= rtMemPoolCreate(&memPool, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t waterMark = (2UL << 30);
    error = rtMemPoolSetAttr(memPool, rtMemPoolAttrReleaseThreshold, (void *)&waterMark);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemPoolDestroy(memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete device;
}

TEST_F(CloudV2ApiTestSOMA, rtMemPoolGetAttr)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));
    rtMemPool_t memPool = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (10UL << 30),
        .reserve = 0
    };
    rtError_t error = rtMemPoolCreate(&memPool, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t waterMark = (2UL << 30);
    error = rtMemPoolGetAttr(memPool, rtMemPoolAttrReleaseThreshold, (void *)&waterMark);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(waterMark, 0);

    error = rtMemPoolDestroy(memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete device;
}

TEST_F(CloudV2ApiTestSOMA, MallocFromPoolAsyncSuccess)
{
    rtError_t error;
    rtStream_t streamId;
    error = rtStreamCreate(&streamId, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    RawDevice *device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));
 
    MOCKER_CPP_VIRTUAL(*device, &RawDevice::CheckFeatureSupport)
        .stubs()
        .with(mockcpp::any())
        .will(returnValue(true));
 
    rtMemPool_t memPoolId = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (10UL << 30),
        .reserve = 0
    };
    error = rtMemPoolCreate(&memPoolId, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    size_t size = 1;
    void *devPtr = nullptr;
    rtMemType_t asyncpolicy = RT_MEMORY_DEFAULT;
    rtError_t ret = rtMemPoolMallocAsync(&devPtr, size, memPoolId, streamId);
    EXPECT_EQ(ret, RT_ERROR_NONE);
 
    ret = rtMemPoolFreeAsync(devPtr, streamId);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    
    error = rtMemPoolDestroy(memPoolId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete device;
}

TEST_F(CloudV2ApiTestSOMA, rt_free_from_mempool_normal)
{
    rtError_t error;
    rtStream_t stream1;
    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;

    RawDevice *device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));
    
    MOCKER_CPP_VIRTUAL(*device, &RawDevice::CheckFeatureSupport)
        .stubs()
        .with(mockcpp::any())
        .will(returnValue(true));

    rtMemPool_t memPoolId = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (10UL << 30),
        .reserve = 0
    };
    error = rtMemPoolCreate(&memPoolId, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    size_t size = (2UL * 1024 * 1024);
    void *ptr = nullptr;
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

TEST_F(CloudV2ApiTestSOMA, rt_free_from_mempool_invaild_ptr)
{
    rtError_t error;
    rtStream_t stream1;
    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;

    RawDevice *device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));
    
    MOCKER_CPP_VIRTUAL(*device, &RawDevice::CheckFeatureSupport)
        .stubs()
        .with(mockcpp::any())
        .will(returnValue(true));

    rtMemPool_t memPoolId = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (10UL << 30),
        .reserve = 0
    };
    error = rtMemPoolCreate(&memPoolId, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    void *ptr = nullptr;
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

TEST_F(CloudV2ApiTestSOMA, rt_free_from_mempool_nullptr_stm)
{
    rtError_t error;
    rtStream_t stream1 = nullptr;
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;

    RawDevice *device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));
    
    MOCKER_CPP_VIRTUAL(*device, &RawDevice::CheckFeatureSupport)
        .stubs()
        .with(mockcpp::any())
        .will(returnValue(true));

    rtMemPool_t memPoolId = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (10UL << 30),
        .reserve = 0
    };
    error = rtMemPoolCreate(&memPoolId, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    size_t size = 32;
    void *ptr = nullptr;
    const int32_t stmId = 0;
    rtError_t ret = SomaApi::AllocFromMemPool(&ptr, size, memPoolId, stmId, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtMemPoolFreeAsync(ptr, stream1);
    EXPECT_NE(ret, RT_ERROR_NONE);

    error = rtMemPoolDestroy(memPoolId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    delete device;
}

TEST_F(CloudV2ApiTestSOMA, rtMemPoolTrimToSuccess)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(*device, &RawDevice::CheckFeatureSupport)
        .stubs()
        .with(mockcpp::any())
        .will(returnValue(true));

    rtMemPool_t memPool = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (10UL * 1024 * 1024 * 1024),
        .reserve = 0
    };
    rtError_t error = rtMemPoolCreate(&memPool, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t minKeepSize = (5UL * 1024 * 1024 * 1024);
    error = rtMemPoolTrimTo(memPool, minKeepSize);
    EXPECT_EQ(error, RT_ERROR_NONE);

    minKeepSize = (1UL * 1024 * 1024 * 1024);
    error = rtMemPoolTrimTo(memPool, minKeepSize);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemPoolDestroy(memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete device;
}

TEST_F(CloudV2ApiTestSOMA, rtMemPoolTrimToFailed)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(*device, &RawDevice::CheckFeatureSupport)
        .stubs()
        .with(mockcpp::any())
        .will(returnValue(true));

    rtError_t error = rtMemPoolTrimTo(nullptr, (5UL * 1024 * 1024 * 1024));
    EXPECT_NE(error, RT_ERROR_NONE);

    rtMemPool_t memPool = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (5UL * 1024 * 1024 * 1024),
        .reserve = 0
    };
    error = rtMemPoolCreate(&memPool, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemPoolTrimTo(memPool, (10UL * 1024 * 1024 * 1024));
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtMemPoolDestroy(memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete device;
}

TEST_F(CloudV2ApiTestSOMA, rtMemPoolTrimImplicit_StreamSync_Threshold0G)
{
    rtStream_t stream1;
    rtError_t error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    RawDevice *device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024); // 16GB设备总内存
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(*device, &RawDevice::CheckFeatureSupport)
        .stubs()
        .with(mockcpp::any())
        .will(returnValue(true));

    rtMemPool_t memPool = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (10UL * 1024 * 1024 * 1024), // 10GB内存池
        .reserve = 0
    };
    error = rtMemPoolCreate(&memPool, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t releaseThreshold = 0UL;
    error = rtMemPoolSetAttr(memPool, rtMemPoolAttrReleaseThreshold, &releaseThreshold);
    EXPECT_EQ(error, RT_ERROR_NONE);

    size_t size1 = (2UL * 1024 * 1024 * 1024); // 2GB
    size_t size2 = (3UL * 1024 * 1024 * 1024); // 3GB
    void *ptr1 = nullptr;
    void *ptr2 = nullptr;

    error = rtMemPoolMallocAsync(&ptr1, size1, memPool, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMemPoolMallocAsync(&ptr2, size2, memPool, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMemPoolFreeAsync(ptr2, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t expectSize = size1;
    MOCKER_CPP(&halMemPoolTrim)
        .stubs()
        .with(mockcpp::any(), outBoundP(&expectSize, sizeof(expectSize)), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    rtStreamSynchronize(stream1);

    uint64_t poolUsedMem = 0;
    error = rtMemPoolGetAttr(memPool, rtMemPoolAttrReservedMemCurrent, &poolUsedMem);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(poolUsedMem, size1);
    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMemPoolDestroy(memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete device;
}

TEST_F(CloudV2ApiTestSOMA, rtMemPoolTrimImplicit_EventSync_Threshold1G)
{
    rtStream_t stream1;
    rtEvent_t event;
    rtError_t error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);
    RawDevice *device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024); // 16GB设备总内存
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(*device, &RawDevice::CheckFeatureSupport)
        .stubs()
        .with(mockcpp::any())
        .will(returnValue(true));

    rtMemPool_t memPool = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (10UL * 1024 * 1024 * 1024), // 10GB内存池
        .reserve = 0
    };
    error = rtMemPoolCreate(&memPool, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t releaseThreshold = (1UL * 1024 * 1024 * 1024);
    error = rtMemPoolSetAttr(memPool, rtMemPoolAttrReleaseThreshold, &releaseThreshold);
    EXPECT_EQ(error, RT_ERROR_NONE);

    size_t size1 = (2UL * 1024 * 1024 * 1024); // 2GB
    size_t size2 = (3UL * 1024 * 1024 * 1024); // 3GB
    void *ptr1 = nullptr;
    void *ptr2 = nullptr;

    error = rtMemPoolMallocAsync(&ptr1, size1, memPool, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMemPoolMallocAsync(&ptr2, size2, memPool, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMemPoolFreeAsync(ptr2, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t expectSize = (2UL * 1024 * 1024 * 1024);
    MOCKER_CPP(&halMemPoolTrim)
        .stubs()
        .with(mockcpp::any(), outBoundP(&expectSize, sizeof(expectSize)), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    rtEventSynchronize(event);

    uint64_t poolUsedMem = 0;
    error = rtMemPoolGetAttr(memPool, rtMemPoolAttrReservedMemCurrent, &poolUsedMem);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(poolUsedMem, size1);
    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMemPoolDestroy(memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete device;
}

TEST_F(CloudV2ApiTestSOMA, rtMemPoolTrimImplicit_DeviceSync_Threshold3G)
{
    rtStream_t stream1;
    rtError_t error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    RawDevice *device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024); // 16GB设备总内存
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(*device, &RawDevice::CheckFeatureSupport)
        .stubs()
        .with(mockcpp::any())
        .will(returnValue(true));

    rtMemPool_t memPool = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (10UL * 1024 * 1024 * 1024), // 10GB内存池
        .reserve = 0
    };
    error = rtMemPoolCreate(&memPool, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t releaseThreshold = (3UL * 1024 * 1024 * 1024);
    error = rtMemPoolSetAttr(memPool, rtMemPoolAttrReleaseThreshold, &releaseThreshold);
    EXPECT_EQ(error, RT_ERROR_NONE);

    size_t size1 = (2UL * 1024 * 1024 * 1024); // 2GB
    size_t size2 = (3UL * 1024 * 1024 * 1024); // 3GB
    void *ptr1 = nullptr;
    void *ptr2 = nullptr;

    error = rtMemPoolMallocAsync(&ptr1, size1, memPool, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMemPoolMallocAsync(&ptr2, size2, memPool, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMemPoolFreeAsync(ptr2, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t expectSize = (3UL * 1024 * 1024 * 1024);
    MOCKER_CPP(&halMemPoolTrim)
        .stubs()
        .with(mockcpp::any(), outBoundP(&expectSize, sizeof(expectSize)), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    rtDeviceSynchronize();

    uint64_t poolUsedMem = 0;
    error = rtMemPoolGetAttr(memPool, rtMemPoolAttrReservedMemCurrent, &poolUsedMem);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(poolUsedMem, expectSize);
    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMemPoolDestroy(memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete device;
}

TEST_F(CloudV2ApiTestSOMA, rtMemPoolTrimImplicit_Malloc)
{
    rtStream_t stream1;
    rtError_t error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    RawDevice *device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024); // 16GB设备总内存
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx).stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::DevMemAlloc).stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), 
        mockcpp::any(), mockcpp::any(), mockcpp::any(), 
        mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    MOCKER_CPP_VIRTUAL(*device, &RawDevice::CheckFeatureSupport).stubs()
        .with(mockcpp::any()).will(returnValue(true));

    rtMemPool_t memPool = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (10UL * 1024 * 1024 * 1024), // 10GB内存池
        .reserve = 0
    };
    error = rtMemPoolCreate(&memPool, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    size_t size1 = (2UL * 1024 * 1024 * 1024); // 2GB
    size_t size2 = (3UL * 1024 * 1024 * 1024); // 3GB
    void *ptr1 = nullptr;
    void *ptr2 = nullptr;
    void *ptr3 = nullptr;

    error = rtMemPoolMallocAsync(&ptr1, size1, memPool, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMemPoolMallocAsync(&ptr2, size2, memPool, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMemPoolFreeAsync(ptr2, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t expectSize = (2UL * 1024 * 1024 * 1024);
    MOCKER_CPP(&halMemPoolTrim).stubs()
        .with(mockcpp::any(), outBoundP(&expectSize, sizeof(expectSize)), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    size_t mallocSize = (1024UL * 1024 * 1024 * 1024);
    rtMalloc(&ptr3, mallocSize, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);

    uint64_t poolUsedMem = 0;
    error = rtMemPoolGetAttr(memPool, rtMemPoolAttrReservedMemCurrent, &poolUsedMem);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(poolUsedMem, size1);

    rtFree(ptr3);
    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMemPoolDestroy(memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete device;
}

TEST_F(CloudV2ApiTestSOMA, rt_sync_alloc_and_async_free)
{
    ApiImpl apiImpl_;
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::LaunchHostFunc).stubs().will(invoke(LaunchHostFuncNormalStub));

    RawDevice *device = new RawDevice(0);
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

TEST_F(CloudV2ApiTestSOMA, rt_sync_alloc_and_async_free_failed)
{
    ApiImpl apiImpl_;
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::LaunchHostFunc).stubs().will(invoke(LaunchHostFuncFailStub));

    RawDevice *device = new RawDevice(0);
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

drvError_t halMemFreeNormalStub(void *pp)
{
    RT_LOG(RT_LOG_DEBUG, "halMemFree Normal ptr=%" PRIx64 ".", RtPtrToValue(pp));
    free(pp);
    return DRV_ERROR_NONE;
}

TEST_F(CloudV2ApiTestSOMA, rt_async_alloc_and_sync_free)
{

    RawDevice *device = new RawDevice(0);
    device->Init();
    rtStream_t streamId;
    rtError_t ret = rtStreamCreate(&streamId, 0);
    ASSERT_EQ(ret, RT_ERROR_NONE);

    size_t totalSize = (16UL << 30);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE)); 
    MOCKER_CPP_VIRTUAL(*device, &RawDevice::CheckFeatureSupport)
        .stubs()
        .with(mockcpp::any())
        .will(returnValue(true));

    rtMemPool_t memPoolId;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (1UL << 30),
        .reserve = 0
    };
    ret = rtMemPoolCreate(&memPoolId, &poolProps);
    ASSERT_EQ(ret, RT_ERROR_NONE);
 
    size_t size = (1UL << 30);
    void *ptr = nullptr;
    ret = rtMemPoolMallocAsync(&ptr, size, memPoolId, streamId);
    ASSERT_EQ(ret, RT_ERROR_NONE);

    uint64_t expectSize = size;
    MOCKER_CPP(&halMemPoolTrim).stubs()
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

TEST_F(CloudV2ApiTestSOMA, rt_malloc_from_mempool_by_single_reuse)
{
    rtError_t error;
    rtStream_t stream1;
    rtStream_t stream2;
    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamCreate(&stream2, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    const int32_t stmId1 = rt_ut::UnwrapOrNull<Stream>(stream1)->Id_();
    const int32_t stmId2 = rt_ut::UnwrapOrNull<Stream>(stream2)->Id_();

    RawDevice *device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
    .stubs()
    .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
    .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(*device, &RawDevice::CheckFeatureSupport)
    .stubs()
    .with(mockcpp::any())
    .will(returnValue(true));

    rtMemPool_t memPoolId = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (10UL << 30),
        .reserve = 0
    };
    error = rtMemPoolCreate(&memPoolId, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);
    uint32_t val = 0;
    rtMemPoolAttr attr = rtMemPoolReuseFollowEventDependencies;
    error = rtMemPoolSetAttr(memPoolId, attr, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    attr = rtMemPoolReuseAllowOpportunistic;
    error = rtMemPoolSetAttr(memPoolId, attr, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    attr = rtMemPoolReuseAllowInternalDependencies;
    error = rtMemPoolSetAttr(memPoolId, attr, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    size_t size = 32;
    void *ptr = nullptr;
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;
    rtError_t ret = SomaApi::AllocFromMemPool(&ptr, size, memPoolId, stmId1, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtMemPoolFreeAsync(ptr, stream1);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    void *ptrReuse = nullptr;
    ret = SomaApi::AllocFromMemPool(&ptrReuse, size, memPoolId, stmId2, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_NE(ptrReuse, ptr);
    EXPECT_EQ(flag, ReuseFlag::REUSE_FLAG_NONE);

    ret = SomaApi::AllocFromMemPool(&ptrReuse, size, memPoolId, stmId1, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(ptrReuse, ptr);
    EXPECT_EQ(flag, ReuseFlag::REUSE_FLAG_STANDARD);

    ret = rtStreamDestroy(stream1);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(stream2);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtMemPoolDestroy(memPoolId);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete device;
}

TEST_F(CloudV2ApiTestSOMA, rt_malloc_from_mempool_by_event_reuse)
{
    rtError_t error;
    rtStream_t stream1;
    rtStream_t stream2;
    rtEvent_t event;
    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamCreate(&stream2, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);
    const int32_t stmId1 = rt_ut::UnwrapOrNull<Stream>(stream1)->Id_();
    const int32_t stmId2 = rt_ut::UnwrapOrNull<Stream>(stream2)->Id_();

    RawDevice *device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(*device, &RawDevice::CheckFeatureSupport)
        .stubs()
        .with(mockcpp::any())
        .will(returnValue(true));

    rtMemPool_t memPoolId = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (10UL << 30),
        .reserve = 0
    };
    error = rtMemPoolCreate(&memPoolId, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    size_t size = 32;
    void *ptr = nullptr;
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;
    rtError_t ret = SomaApi::AllocFromMemPool(&ptr, size, memPoolId, stmId1, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtMemPoolFreeAsync(ptr, stream1);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtEventRecord(event, stream1);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamWaitEvent(stream2, event);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    void *ptrReuse = nullptr;
    uint32_t val = 1;
    rtMemPoolAttr attr = rtMemPoolReuseFollowEventDependencies;
    error = rtMemPoolSetAttr(memPoolId, attr, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ret = SomaApi::AllocFromMemPool(&ptrReuse, size, memPoolId, stmId2, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(ptrReuse, ptr);
    EXPECT_EQ(flag, ReuseFlag::REUSE_FLAG_STANDARD);
    ret = rtStreamSynchronize(stream1);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamSynchronize(stream2);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(stream1);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(stream2);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtEventDestroy(event);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtMemPoolDestroy(memPoolId);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete device;
}

TEST_F(CloudV2ApiTestSOMA, rt_malloc_from_mempool_by_event_reuse_fail)
{
    rtError_t error;
    rtStream_t stream1;
    rtStream_t stream2;
    rtEvent_t event;
    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamCreate(&stream2, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);
    const int32_t stmId1 = rt_ut::UnwrapOrNull<Stream>(stream1)->Id_();
    const int32_t stmId2 = rt_ut::UnwrapOrNull<Stream>(stream2)->Id_();

    RawDevice *device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(*device, &RawDevice::CheckFeatureSupport)
        .stubs()
        .with(mockcpp::any())
        .will(returnValue(true));

    rtMemPool_t memPoolId = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (10UL << 30),
        .reserve = 0
    };
    error = rtMemPoolCreate(&memPoolId, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    size_t size = 32;
    void *ptr = nullptr;
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;
    rtError_t ret = SomaApi::AllocFromMemPool(&ptr, size, memPoolId, stmId1, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtEventRecord(event, stream1);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamWaitEvent(stream2, event);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtMemPoolFreeAsync(ptr, stream1);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    void *ptrReuse = nullptr;
    ret = SomaApi::AllocFromMemPool(&ptrReuse, size, memPoolId, stmId2, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_NE(ptrReuse, ptr);
    EXPECT_EQ(flag, ReuseFlag::REUSE_FLAG_NONE);
    ret = rtStreamSynchronize(stream1);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamSynchronize(stream2);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(stream1);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(stream2);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtEventDestroy(event);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtMemPoolDestroy(memPoolId);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete device;
}

TEST_F(CloudV2ApiTestSOMA, rt_malloc_from_mempool_by_opport_reuse)
{
    rtError_t error;
    rtStream_t stream1;
    rtStream_t stream2;
    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamCreate(&stream2, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    const int32_t stmId1 = rt_ut::UnwrapOrNull<Stream>(stream1)->Id_();
    const int32_t stmId2 = rt_ut::UnwrapOrNull<Stream>(stream2)->Id_();

    RawDevice *device = new RawDevice(0);
    device->Init();
    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(*device, &RawDevice::CheckFeatureSupport)
        .stubs()
        .with(mockcpp::any())
        .will(returnValue(true));
    
    rtMemPool_t memPoolId = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (10UL << 30),
        .reserve = 0
    };
    error = rtMemPoolCreate(&memPoolId, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t val = 1;
    rtMemPoolAttr attr = rtMemPoolReuseAllowOpportunistic;
    error = rtMemPoolSetAttr(memPoolId, attr, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);

    size_t size = 32;
    void *ptr = nullptr;
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;
    rtError_t ret = SomaApi::AllocFromMemPool(&ptr, size, memPoolId, stmId1, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtMemPoolFreeAsync(ptr, stream1);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    void *ptrReuse = nullptr;
    ret = SomaApi::AllocFromMemPool(&ptrReuse, size, memPoolId, stmId2, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(ptrReuse, ptr);
    EXPECT_EQ(flag, ReuseFlag::REUSE_FLAG_STANDARD);

    ret = rtStreamDestroy(stream1);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(stream2);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtMemPoolDestroy(memPoolId);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete device;
}