/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#define private public
#include "raw_device.hpp"
#include "stream_mem_pool.hpp"
#include "soma.hpp"
#undef private
#include "../../rt_utest_api.hpp"
#include "runtime.hpp"
#include "api.hpp"
#include "npu_driver.hpp"
#include "cmodel_driver.h"
#include "event_state_callback_manager.hpp"
#include "runtime/stars_interface.h"

using namespace testing;
using namespace cce::runtime;

static SegmentManager *CreateSimplePool(uint64_t size, uint32_t devId = 0U)
{
    static uint64_t nextVa = (1ULL << 30);
    uint64_t va = nextVa;
    nextVa += size;
    Segment *seg = SegmentManager::CreateSegment(va, size, nullptr, nullptr);
    SegmentManager *mgr = PoolRegistry::CreateManager(seg, devId, true);
    PoolRegistry::Instance().RegisterMemPool(mgr);
    return mgr;
}

class SomaTest : public testing::Test
{
public:
    static rtError_t rtDeviceResetStub(int32_t device)
    {
        return RT_ERROR_NONE;
    }

protected:
    static void SetUpTestCase()
    {
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        std::cout << "======== SomaTest Start SetUpTestCase ========" << std::endl;
        MOCKER(rtDeviceReset).stubs().will(invoke(rtDeviceResetStub));
        MOCKER(rtSetDevice).stubs().will(returnValue(0));
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
        (void)PoolRegistry::Instance().Init();
    }

    static void TearDownTestCase()
    {
        std::cout << "======== SomaTest Start TearDownTestCase ========" << std::endl;
    }

    virtual void SetUp()
    {
        GlobalMockObject::verify();
        rtSetDevice(0);
        defaultMemPool = CreateSimplePool((10UL << 30), 0U);
    }

    virtual void TearDown()
    {
        SomaApi::DestroyMemPool(defaultMemPool);
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }

private:
    SegmentManager *defaultMemPool = nullptr;
};

TEST_F(SomaTest, SegmentManagerNullptr)
{
    SegmentManager segMgr(nullptr, 0U, true);
}

TEST_F(SomaTest, AlignAndValidate_DefaultMaxSize)
{
    uint64_t totalSize = DEVICE_POOL_ALIGN_SIZE * 4;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = 0,
        .reserve = 0
    };
    rtError_t error = SomaApi::AlignAndValidatePoolSize(poolProps, totalSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(poolProps.maxSize, totalSize);
}

TEST_F(SomaTest, AlignAndValidate_ExceedTotal_Fail)
{
    uint64_t totalSize = DEVICE_POOL_ALIGN_SIZE * 2;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = DEVICE_POOL_ALIGN_SIZE * 3,
        .reserve = 0
    };
    rtError_t error = SomaApi::AlignAndValidatePoolSize(poolProps, totalSize);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(SomaTest, AlignAndValidate_SizeRoundUp)
{
    uint64_t totalSize = (2ULL << 40);
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = DEVICE_POOL_ALIGN_SIZE - 1,
        .reserve = 0
    };
    rtError_t error = SomaApi::AlignAndValidatePoolSize(poolProps, totalSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(poolProps.maxSize, DEVICE_POOL_ALIGN_SIZE);
}

TEST_F(SomaTest, MemPool_CreateAndDestroy_Direct)
{
    uint64_t totalSize = DEVICE_POOL_ALIGN_SIZE * 4;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = 0,
        .reserve = 0
    };
    rtError_t error = SomaApi::AlignAndValidatePoolSize(poolProps, totalSize);
    ASSERT_EQ(error, RT_ERROR_NONE);

    SegmentManager *memPool = CreateSimplePool(poolProps.maxSize, poolProps.devId);
    ASSERT_NE(memPool, nullptr);

    error = SomaApi::CheckMemPool(memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = SomaApi::DestroyMemPool(memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, MemPool_CreateTwoPools_DestroyAll)
{
    SegmentManager *pool1 = CreateSimplePool(DEVICE_POOL_ALIGN_SIZE, 0U);
    ASSERT_NE(pool1, nullptr);
    SegmentManager *pool2 = CreateSimplePool(DEVICE_POOL_ALIGN_SIZE * 2, 0U);
    ASSERT_NE(pool2, nullptr);

    EXPECT_EQ(SomaApi::CheckMemPool(pool1), RT_ERROR_NONE);
    EXPECT_EQ(SomaApi::CheckMemPool(pool2), RT_ERROR_NONE);
    EXPECT_EQ(SomaApi::DestroyMemPool(pool1), RT_ERROR_NONE);
    EXPECT_EQ(SomaApi::DestroyMemPool(pool2), RT_ERROR_NONE);
}

TEST_F(SomaTest, MemPool_DestroyNonExistent_Fail)
{
    SegmentManager *pool = CreateSimplePool(DEVICE_POOL_ALIGN_SIZE, 0U);
    ASSERT_NE(pool, nullptr);

    EXPECT_EQ(SomaApi::DestroyMemPool(pool), RT_ERROR_NONE);
}

TEST_F(SomaTest, MemPoolCreate_ExplicitSize)
{
    RawDevice *device = new RawDevice(0);
    device->Init();

    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));
    uint64_t fakeVa = (1ULL << 32);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::StreamMemPoolCreate)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(fakeVa))
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
    EXPECT_NE(memPool, nullptr);

    error = rtMemPoolDestroy(memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete device;
}

TEST_F(SomaTest, MemPoolCreate_DefaultMaxSize)
{
    RawDevice *device = new RawDevice(0);
    device->Init();

    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));

    uint64_t fakeVa = (1ULL << 32);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::StreamMemPoolCreate)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(fakeVa))
        .will(returnValue(RT_ERROR_NONE));

    rtMemPool_t memPool = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = 0,
        .reserve = 0
    };
    rtError_t error = rtMemPoolCreate(&memPool, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(memPool, nullptr);

    error = rtMemPoolDestroy(memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete device;
}

TEST_F(SomaTest, MemPoolCreate_SizeExceedTotal_Fail)
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
        .maxSize = (20UL * 1024 * 1024 * 1024),
        .reserve = 0
    };
    rtError_t error = rtMemPoolCreate(&memPool, &poolProps);
    EXPECT_NE(error, RT_ERROR_NONE);
    EXPECT_EQ(memPool, nullptr);
    delete device;
}

TEST_F(SomaTest, MemPoolCreate_DriverFail)
{
    RawDevice *device = new RawDevice(0);
    device->Init();

    size_t totalSize = (16UL * 1024 * 1024 * 1024);
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::MemGetInfoEx)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&totalSize, sizeof(totalSize)))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::StreamMemPoolCreate)
        .stubs()
        .will(returnValue(RT_ERROR_MEMORY_ALLOCATION));

    rtMemPool_t memPool = nullptr;
    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = (10UL << 30),
        .reserve = 0
    };
    rtError_t error = rtMemPoolCreate(&memPool, &poolProps);
    EXPECT_EQ(error, ACL_ERROR_RT_MEMORY_ALLOCATION);
    delete device;
}

TEST_F(SomaTest, MemPoolDestroy_NullHandle)
{
    rtError_t error = rtMemPoolDestroy(nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, MemPoolCreate_ThenDestroy_ThenCreateAgain)
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
        .maxSize = (5UL * 1024 * 1024 * 1024),
        .reserve = 0
    };

    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::StreamMemPoolCreate)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtError_t error = rtMemPoolCreate(&memPool, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(memPool, nullptr);

    error = rtMemPoolDestroy(memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);

    memPool = nullptr;
    error = rtMemPoolCreate(&memPool, &poolProps);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(memPool, nullptr);

    error = rtMemPoolDestroy(memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete device;
}

TEST_F(SomaTest, SomaApiSetAttrInvalidPool)
{
    rtMemPool_t invalidPool = reinterpret_cast<rtMemPool_t>(0xDEADBEEF);
    uint64_t value = 100;
    rtError_t error = SomaApi::StreamMemPoolSetAttr(invalidPool, rtMemPoolAttrReleaseThreshold, &value);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, SomaApiGetAttrInvalidPool)
{
    rtMemPool_t invalidPool = reinterpret_cast<rtMemPool_t>(0xDEADBEEF);
    uint64_t value = 0;
    rtError_t error = SomaApi::StreamMemPoolSetAttr(invalidPool, rtMemPoolAttrReleaseThreshold, &value);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, SomaApiSetAttrReusePolicy)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t reuseValue = 1;
    error = SomaApi::StreamMemPoolSetAttr(defaultMemPool, rtMemPoolReuseFollowEventDependencies, &reuseValue);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = SomaApi::StreamMemPoolSetAttr(defaultMemPool, rtMemPoolReuseAllowOpportunistic, &reuseValue);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = SomaApi::StreamMemPoolSetAttr(defaultMemPool, rtMemPoolReuseAllowInternalDependencies, &reuseValue);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, SomaApiGetAttrReusePolicy)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t reuseValue = 1;
    error = SomaApi::StreamMemPoolSetAttr(defaultMemPool, rtMemPoolReuseFollowEventDependencies, &reuseValue);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t getValue = 0;
    error = SomaApi::StreamMemPoolGetAttr(defaultMemPool, rtMemPoolReuseFollowEventDependencies, &getValue);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(getValue, 1);

    error = SomaApi::StreamMemPoolGetAttr(defaultMemPool, rtMemPoolReuseAllowOpportunistic, &getValue);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = SomaApi::StreamMemPoolGetAttr(defaultMemPool, rtMemPoolReuseAllowInternalDependencies, &getValue);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, SomaApiSetAttrReservedMemHigh)
{
    rtError_t error = RT_ERROR_NONE;
    uint64_t resetValue = 0;
    error = SomaApi::StreamMemPoolSetAttr(defaultMemPool, rtMemPoolAttrReservedMemHigh, &resetValue);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RawDevice *device = new RawDevice(0);
    device->Init();
    MOCKER_CPP_VIRTUAL(*device->driver_, &Driver::StreamMemPoolSetAttr).expects(mockcpp::once())
        .will(returnValue(RT_ERROR_INVALID_VALUE));
    delete device;

    uint64_t invalidValue = 100;
    error = SomaApi::StreamMemPoolSetAttr(defaultMemPool, rtMemPoolAttrReservedMemHigh, &invalidValue);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, SomaApiSetAttrUsedMemHighSuccess)
{
    rtError_t error = RT_ERROR_NONE;
    uint64_t resetValue = 0;
    error = SomaApi::StreamMemPoolSetAttr(defaultMemPool, rtMemPoolAttrUsedMemHigh, &resetValue);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, SomaApiGetAttrInvalidAttr)
{
    rtError_t error = RT_ERROR_NONE;
    uint64_t value = 0;
    rtMemPoolAttr invalidAttr = static_cast<rtMemPoolAttr>(0xFF);
    error = SomaApi::StreamMemPoolGetAttr(defaultMemPool, invalidAttr, &value);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, SomaApiSetAttrInvalidAttr)
{
    rtError_t error = RT_ERROR_NONE;
    uint64_t value = 100;
    rtMemPoolAttr invalidAttr = static_cast<rtMemPoolAttr>(0xFF);
    error = SomaApi::StreamMemPoolSetAttr(defaultMemPool, invalidAttr, &value);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, SomaApiSetAttrReadOnlyAttr)
{
    rtError_t error = RT_ERROR_NONE;
    uint64_t value = 100;
    error = SomaApi::StreamMemPoolSetAttr(defaultMemPool, rtMemPoolAttrReservedMemCurrent, &value);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = SomaApi::StreamMemPoolSetAttr(defaultMemPool, rtMemPoolAttrUsedMemCurrent, &value);
    EXPECT_NE(error, RT_ERROR_NONE);
}

static uint64_t g_halMemPoolSetAttrValue[MEM_POOL_ATTR_MAX] = {0};
drvError_t halMemPoolSetAttrSuccessStub(soma_mem_pool_t pool, soma_mem_pool_attr attr, void* value)
{
    uint64_t* val = static_cast<uint64_t*>(value);
    g_halMemPoolSetAttrValue[attr] = *val;
    return DRV_ERROR_NONE;
}

TEST_F(SomaTest, SomaApiSetAttrDriverSuccess)
{
    rtError_t error = RT_ERROR_NONE;
    uint64_t releaseThreshold = DEVICE_POOL_ALIGN_SIZE;
    MOCKER_CPP(&halMemPoolSetAttr).expects(mockcpp::once()).will(invoke(halMemPoolSetAttrSuccessStub));

    error = SomaApi::StreamMemPoolSetAttr(defaultMemPool, rtMemPoolAttrReleaseThreshold, &releaseThreshold);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(releaseThreshold, g_halMemPoolSetAttrValue[MEM_POOL_ATTR_RELEASE_THRESHOLD]);
}

static uint64_t g_halMemPoolGetAttrValue[MEM_POOL_ATTR_MAX] = {0};
drvError_t halMemPoolGetAttrSuccessStub(soma_mem_pool_t pool, soma_mem_pool_attr attr, void* value)
{
    uint64_t* val = static_cast<uint64_t*>(value);
    *val = g_halMemPoolGetAttrValue[attr];
    return DRV_ERROR_NONE;
}

TEST_F(SomaTest, SomaApiGetAttrDriverSuccess)
{
    rtError_t error = RT_ERROR_NONE;
    g_halMemPoolGetAttrValue[MEM_POOL_ATTR_RELEASE_THRESHOLD] = DEVICE_POOL_ALIGN_SIZE;
    MOCKER_CPP(&halMemPoolGetAttr).expects(mockcpp::once()).will(invoke(halMemPoolGetAttrSuccessStub));

    uint64_t releaseThreshold = 0;
    error = SomaApi::StreamMemPoolGetAttr(defaultMemPool, rtMemPoolAttrReleaseThreshold, &releaseThreshold);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(releaseThreshold, g_halMemPoolGetAttrValue[MEM_POOL_ATTR_RELEASE_THRESHOLD]);
}

TEST_F(SomaTest, ReuseDisabledFreeToCached)
{
    SegmentManager *memPool = CreateSimplePool(64U, 0U);

    Segment *ptr = nullptr;
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;
    const int streamId = 0;
    rtError_t error = memPool->SegmentAlloc(ptr, 8U, streamId, flag);
    EXPECT_EQ(error, RT_ERROR_NONE);

    size_t cachedBefore = memPool->cachedSegs_.size();
    error = memPool->SegmentFree(ptr->basePtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_GT(memPool->cachedSegs_.size(), cachedBefore);

    std::shared_ptr<SegmentManager> owned;
    error = PoolRegistry::Instance().RemoveMemPool(memPool, owned);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

