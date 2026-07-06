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
#include "program.hpp"
#include "uma_arg_loader.hpp"
#include "raw_device.hpp"
#include "stream_mem_pool.hpp"
#include "soma.hpp"
#undef private
#include "runtime.hpp"
#include "api.hpp"
#include "event.hpp"
#include "npu_driver.hpp"
#include "cmodel_driver.h"
#include "event_state_callback_manager.hpp"
#include "runtime/stars_interface.h"

using namespace testing;
using namespace cce::runtime;

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
    }

    static void TearDownTestCase()
    {
        std::cout << "======== SomaTest Start TearDownTestCase ========" << std::endl;
    }

    virtual void SetUp()
    {
        GlobalMockObject::verify();
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }
};

static SegmentManager* CreateTestMemPool(uint64_t size, uint32_t devId = 0U)
{
    static uint64_t nextVa = (1ULL << 30);   // 从 1GB 起，避免 nullptr 区域
    uint64_t va = nextVa;
    nextVa += size;
    Segment *seg = SegmentManager::CreateSegment(va, size, nullptr, nullptr);
    SegmentManager *mgr = PoolRegistry::CreateManager(seg, devId, true);
    PoolRegistry::Instance().RegisterMemPool(mgr);
    return mgr;
}

TEST_F(SomaTest, streamMemSegmentManagerNullptr)
{
    SegmentManager segManeger(nullptr, 0U, true);
}

TEST_F(SomaTest, MemPoolAttrToName)
{
    EXPECT_STREQ(SomaApi::MemPoolAttrToName(rtMemPoolAttrReservedMemCurrent), "rtMemPoolAttrReservedMemCurrent");
    EXPECT_STREQ(SomaApi::MemPoolAttrToName(rtMemPoolAttrUsedMemCurrent), "rtMemPoolAttrUsedMemCurrent");
    EXPECT_STREQ(SomaApi::MemPoolAttrToName(static_cast<rtMemPoolAttr>(0xFF)), "Unknown");
}

TEST_F(SomaTest, MemPoolTest)
{
    SegmentManager *memPool = CreateTestMemPool(64U, 0U);
    rtError_t error = RT_ERROR_NONE;
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;
    uint64_t size = 8U;
    Segment *ptr = nullptr;
    const int streamId = 0;
    error = memPool->SegmentAlloc(ptr, size, streamId, flag);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(flag, ReuseFlag::REUSE_FLAG_NONE);
    error = memPool->SegmentFree(ptr->basePtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    std::shared_ptr<SegmentManager> owned;
    error = PoolRegistry::Instance().RemoveMemPool(memPool, owned);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, PoolAllocatorSetAttributeTest)
{
    SegmentManager *memPool = CreateTestMemPool(64U, 0U);
    rtError_t error = RT_ERROR_NONE;
    memPool->isIPCPool_ = true;
    rtMemPoolAttr attr = rtMemPoolAttr::rtMemPoolReuseFollowEventDependencies;
    size_t zero = 0;
    size_t one = 1;
    void* value = &zero;
    error = memPool->SetAttribute(attr, value);
    EXPECT_EQ(error, RT_ERROR_POOL_UNSUPPORTED);
    memPool->isIPCPool_ = false;
    error = memPool->SetAttribute(attr, value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    attr = rtMemPoolAttr::rtMemPoolReuseAllowOpportunistic;
    error = memPool->SetAttribute(attr, value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    attr = rtMemPoolAttr::rtMemPoolReuseAllowInternalDependencies;
    error = memPool->SetAttribute(attr, value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    attr = rtMemPoolAttr::rtMemPoolAttrUsedMemCurrent;
    error = memPool->SetAttribute(attr, value);
    EXPECT_EQ(error, RT_ERROR_POOL_PROP_INVALID);
    attr = rtMemPoolAttr::rtMemPoolAttrUsedMemHigh;
    value = &one;
    error = memPool->SetAttribute(attr, value);
    EXPECT_EQ(error, RT_ERROR_POOL_PROP_INVALID);
    std::shared_ptr<SegmentManager> owned;
    error = PoolRegistry::Instance().RemoveMemPool(memPool, owned);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, PoolAllocatorGetAttributeTest)
{
    SegmentManager *memPool = CreateTestMemPool(64U, 0U);
    rtError_t error = RT_ERROR_NONE;
    size_t local = 0;
    void* value = &local;
    rtMemPoolAttr attr = rtMemPoolAttr::rtMemPoolReuseFollowEventDependencies;
    error = memPool->GetAttribute(attr, value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    attr = rtMemPoolAttr::rtMemPoolReuseAllowOpportunistic;
    error = memPool->GetAttribute(attr, value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    attr = rtMemPoolAttr::rtMemPoolReuseAllowInternalDependencies;
    error = memPool->GetAttribute(attr, value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    attr = rtMemPoolAttr::rtMemPoolAttrReleaseThreshold;
    error = memPool->GetAttribute(attr, value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    attr = rtMemPoolAttr::rtMemPoolAttrReservedMemCurrent;
    error = memPool->GetAttribute(attr, value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    attr = rtMemPoolAttr::rtMemPoolAttrReservedMemHigh;
    error = memPool->GetAttribute(attr, value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    attr = rtMemPoolAttr::rtMemPoolAttrUsedMemCurrent;
    error = memPool->GetAttribute(attr, value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    attr = rtMemPoolAttr::rtMemPoolAttrUsedMemHigh;
    error = memPool->GetAttribute(attr, value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    std::shared_ptr<SegmentManager> owned;
    error = PoolRegistry::Instance().RemoveMemPool(memPool, owned);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, StreamInternalReuseTest_Opport_Reuse)
{
    SegmentManager *memPool = CreateTestMemPool(64U, 0U);
    rtError_t error = RT_ERROR_NONE;
    uint64_t size = 8U;
    Segment *ptr = nullptr;
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;
    const int streamId = 0;
    error = memPool->SegmentAlloc(ptr, size, streamId, flag);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(flag, ReuseFlag::REUSE_FLAG_NONE);
    error = memPool->SegmentFree(ptr->basePtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Segment *segManager = memPool->StreamInternalReuse(5U, 0, true, flag);
    EXPECT_NE(segManager, nullptr);
    EXPECT_EQ(flag, ReuseFlag::REUSE_FLAG_STANDARD);
    std::shared_ptr<SegmentManager> owned;
    error = PoolRegistry::Instance().RemoveMemPool(memPool, owned);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, StreamInternalReuseTest_Internal_Reuse)
{
    SegmentManager *memPool = CreateTestMemPool(64U, 0U);
    rtError_t error = RT_ERROR_NONE;
    uint64_t size = 8U;
    Segment *ptr = nullptr;
    const int streamId = 1;
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;
    error = memPool->SegmentAlloc(ptr, size, streamId, flag);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(flag, ReuseFlag::REUSE_FLAG_NONE);
    error = memPool->SegmentFree(ptr->basePtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Segment *segManager = memPool->StreamInternalReuse(5U, 0, false, flag);
    EXPECT_EQ(flag, ReuseFlag::REUSE_FLAG_INTERNAL);
    EXPECT_NE(segManager, nullptr);
    std::shared_ptr<SegmentManager> owned;
    error = PoolRegistry::Instance().RemoveMemPool(memPool, owned);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, StreamEventReuseTest_Event_Reuse)
{
    SegmentManager *memPool = CreateTestMemPool(64U, 0U);
    rtError_t error = RT_ERROR_NONE;
    uint64_t size = 8U;
    Segment *ptr = nullptr;
    const int streamId = 0;
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;
    error = memPool->SegmentAlloc(ptr, size, streamId, flag);
    EXPECT_EQ(flag, ReuseFlag::REUSE_FLAG_NONE);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = memPool->SegmentFree(ptr->basePtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    const int eventId = 0;
    const int streamId1 = 1;
    PoolRegistry::Instance().UpdateEventMap(streamId, eventId);
    PoolRegistry::Instance().UpdateSeqMap(streamId1, eventId);
    Segment *segManager = memPool->StreamEventReuse(5U, 1, flag);
    EXPECT_EQ(flag, ReuseFlag::REUSE_FLAG_STANDARD);
    EXPECT_NE(segManager, nullptr);
    std::shared_ptr<SegmentManager> owned;
    error = PoolRegistry::Instance().RemoveMemPool(memPool, owned);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, StreamEventReuseTest_Reuse_None)
{
    SegmentManager *memPool = CreateTestMemPool(64U, 0U);
    rtError_t error = RT_ERROR_NONE;
    uint64_t size = 8U;
    Segment *ptr = nullptr;
    const int streamId = 0;
    const int streamId1 = 1;
    const int eventId = 0;
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;
    error = memPool->SegmentAlloc(ptr, size, streamId, flag);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(flag, ReuseFlag::REUSE_FLAG_NONE);
    PoolRegistry::Instance().UpdateEventMap(streamId, eventId);
    PoolRegistry::Instance().UpdateSeqMap(streamId1, eventId);
    PoolRegistry::Instance().UpdateEventMap(streamId, eventId);
    error = memPool->SegmentFree(ptr->basePtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Segment *ret = memPool->StreamEventReuse(5U, 1, flag);
    EXPECT_EQ(flag, ReuseFlag::REUSE_FLAG_NONE);
    EXPECT_EQ(ret, nullptr);
    std::shared_ptr<SegmentManager> owned;
    error = PoolRegistry::Instance().RemoveMemPool(memPool, owned);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, FindMemPoolByPtrTest)
{
    rtError_t error = RT_ERROR_NONE;
    uint64_t size = DEVICE_POOL_ALIGN_SIZE;
    uint64_t ptr = 0;

    SegmentManager *memPool1 = CreateTestMemPool(size, 0U);
    ASSERT_NE(memPool1, nullptr);
    ptr = memPool1->PoolSegAddr();
    std::shared_ptr<SegmentManager> retPool = PoolRegistry::Instance().FindMemPoolByPtr(ptr - 1);
    EXPECT_NE(retPool.get(), memPool1);
    retPool = PoolRegistry::Instance().FindMemPoolByPtr(ptr);
    EXPECT_EQ(retPool.get(), memPool1);
    EXPECT_EQ(retPool->PoolSize(), size);
    retPool = PoolRegistry::Instance().FindMemPoolByPtr(ptr + retPool->PoolSize() - 1);
    EXPECT_EQ(retPool.get(), memPool1);
    retPool = PoolRegistry::Instance().FindMemPoolByPtr(ptr + retPool->PoolSize());
    EXPECT_NE(retPool.get(), memPool1);

    SegmentManager *memPool2 = CreateTestMemPool(size, 0U);
    ASSERT_NE(memPool2, nullptr);
    ptr = memPool2->PoolSegAddr() + memPool2->PoolSize() / 2;
    retPool = PoolRegistry::Instance().FindMemPoolByPtr(ptr);
    EXPECT_EQ(retPool.get(), memPool2);

    std::shared_ptr<SegmentManager> owned1, owned2;
    error = PoolRegistry::Instance().RemoveMemPool(memPool1, owned1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = PoolRegistry::Instance().RemoveMemPool(memPool2, owned2);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, SomaApiTest_Create_Destory)
{
    rtError_t error = RT_ERROR_NONE;
    uint64_t totalSize = DEVICE_POOL_ALIGN_SIZE * 2;

    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = 0,
        .reserve = 0
    };
    SegmentManager *memPool1 = nullptr;
    error = SomaApi::AlignAndValidatePoolSize(poolProps, totalSize);
    ASSERT_EQ(error, RT_ERROR_NONE);
    memPool1 = CreateTestMemPool(poolProps.maxSize, poolProps.devId);
    ASSERT_NE(memPool1, nullptr);

    error = SomaApi::CheckMemPool(memPool1);
    ASSERT_EQ(error, RT_ERROR_NONE);
    error = SomaApi::DestroyMemPool(memPool1);
    ASSERT_EQ(error, RT_ERROR_NONE);

    rtMemPoolProps poolProps1 = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = DEVICE_POOL_ALIGN_SIZE * 3,
        .reserve = 0
    };
    error = SomaApi::AlignAndValidatePoolSize(poolProps1, totalSize);
    ASSERT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(SomaTest, SomaApiMemoryAlignmentTest)
{
    rtError_t error = RT_ERROR_NONE;
    uint64_t totalSize = (2ULL << 40);

    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = DEVICE_POOL_ALIGN_SIZE - 1,
        .reserve = 0
    };
    SegmentManager *memPool = nullptr;
    error = SomaApi::AlignAndValidatePoolSize(poolProps, totalSize);
    ASSERT_EQ(error, RT_ERROR_NONE);
    memPool = CreateTestMemPool(poolProps.maxSize, poolProps.devId);
    ASSERT_NE(memPool, nullptr);
    ASSERT_EQ(memPool->PoolSize(), DEVICE_POOL_ALIGN_SIZE);

    ASSERT_EQ(error, RT_ERROR_NONE);
    error = SomaApi::DestroyMemPool(memPool);
    ASSERT_EQ(error, RT_ERROR_NONE);
}


TEST_F(SomaTest, MemPoolTest_TrimTo_trim_part)
{
    SegmentManager *memPool = nullptr;
    const int streamId = 0;
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;

    memPool = CreateTestMemPool(1000U, 0U);
    rtError_t error = RT_ERROR_NONE;

    Segment *ptr = nullptr;
    error = memPool->SegmentAlloc(ptr, 200U, streamId, flag);
    ASSERT_EQ(error, RT_ERROR_NONE);
    {
        Segment *ptr = nullptr;
        error = memPool->SegmentAlloc(ptr, 300U, streamId, flag);
        ASSERT_EQ(error, RT_ERROR_NONE);

        error = memPool->TrimTo(400U);
        ASSERT_NE(error, RT_ERROR_NONE);

        error = memPool->SegmentFree(ptr->basePtr);
        ASSERT_EQ(error, RT_ERROR_NONE);
    }
    error = memPool->TrimTo(400U);
    ASSERT_EQ(error, RT_ERROR_NONE);

    uint64_t reservedSize = 0;
    memPool->GetAttribute(rtMemPoolAttrReservedMemCurrent, &reservedSize);
    ASSERT_EQ(reservedSize, 400U);

    error = memPool->SegmentFree(ptr->basePtr);
    ASSERT_EQ(error, RT_ERROR_NONE);

    std::shared_ptr<SegmentManager> owned;
    error = PoolRegistry::Instance().RemoveMemPool(memPool, owned);
    ASSERT_EQ(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, MemPoolTest_TrimTo_not_trim)
{
    SegmentManager *memPool = nullptr;
    const int streamId = 0;
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;

    memPool = CreateTestMemPool((10UL << 20), 0U);
    rtError_t error = RT_ERROR_NONE;

    Segment *ptr = nullptr;
    error = memPool->SegmentAlloc(ptr, (2UL << 20), streamId, flag);
    ASSERT_EQ(error, RT_ERROR_NONE);
    {
        Segment *ptr = nullptr;
        error = memPool->SegmentAlloc(ptr, (3UL << 20), streamId, flag);
        ASSERT_EQ(error, RT_ERROR_NONE);
        error = memPool->SegmentFree(ptr->basePtr);
        ASSERT_EQ(error, RT_ERROR_NONE);

        uint64_t usedSize = 0;
        memPool->GetAttribute(rtMemPoolAttrUsedMemCurrent, &usedSize);
        ASSERT_EQ(usedSize, (2UL << 20));
        uint64_t reservedSize = 0;
        memPool->GetAttribute(rtMemPoolAttrReservedMemCurrent, &reservedSize);
        ASSERT_EQ(reservedSize, (5UL << 20));

        error = memPool->TrimTo((6UL << 20));
        ASSERT_EQ(error, RT_ERROR_NONE);

        error = memPool->TrimTo((10UL << 20));
        ASSERT_EQ(error, RT_ERROR_NONE);

        error = memPool->TrimTo((12UL << 20));
        ASSERT_NE(error, RT_ERROR_NONE);

        memPool->GetAttribute(rtMemPoolAttrReservedMemCurrent, &reservedSize);
        ASSERT_EQ(reservedSize, (5UL << 20));
    }
    error = memPool->SegmentFree(ptr->basePtr);
    ASSERT_EQ(error, RT_ERROR_NONE);

    std::shared_ptr<SegmentManager> owned;
    error = PoolRegistry::Instance().RemoveMemPool(memPool, owned);
    ASSERT_EQ(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, MemPoolTest_TrimTo_trim_all)
{
    SegmentManager *memPool = nullptr;
    const int streamId = 0;
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;

    memPool = CreateTestMemPool((100UL << 10), 0U);
    rtError_t error = RT_ERROR_NONE;

    Segment *ptr = nullptr;
    error = memPool->SegmentAlloc(ptr, (20UL << 10), streamId, flag);
    ASSERT_EQ(error, RT_ERROR_NONE);
    {
        Segment *ptr = nullptr;
        error = memPool->SegmentAlloc(ptr, (30UL << 10), streamId, flag);
        ASSERT_EQ(error, RT_ERROR_NONE);
        error = memPool->SegmentFree(ptr->basePtr);
        ASSERT_EQ(error, RT_ERROR_NONE);

        error = memPool->TrimTo(0UL);
        ASSERT_NE(error, RT_ERROR_NONE);

        error = memPool->TrimTo((20UL << 10));
        ASSERT_EQ(error, RT_ERROR_NONE);

        uint64_t reservedSize = 0;
        memPool->GetAttribute(rtMemPoolAttrReservedMemCurrent, &reservedSize);
        ASSERT_EQ(reservedSize, (20UL << 10));
    }
    error = memPool->SegmentFree(ptr->basePtr);
    ASSERT_EQ(error, RT_ERROR_NONE);

    std::shared_ptr<SegmentManager> owned;
    error = PoolRegistry::Instance().RemoveMemPool(memPool, owned);
    ASSERT_EQ(error, RT_ERROR_NONE);
}

TEST_F(SomaTest, MemPoolTest_TrimTo_mempools)
{
    SegmentManager *memPool = nullptr;
    const int streamId = 0;
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;

    memPool = CreateTestMemPool(100U, 0U);
    rtError_t error = RT_ERROR_NONE;

    Segment *ptr = nullptr;

    error = memPool->SegmentAlloc(ptr, 100U, streamId, flag);
    ASSERT_EQ(error, RT_ERROR_NONE);
    error = memPool->TrimTo(5U);
    ASSERT_EQ(error, RT_ERROR_POOL_OP_INVALID);

    {
        SegmentManager *memPool2 = nullptr;
        Segment *ptr2 = nullptr;
        memPool2 = CreateTestMemPool(100U, 0U);
        error = memPool2->SegmentAlloc(ptr2, 10U, streamId, flag);
        ASSERT_EQ(error, RT_ERROR_NONE);
        error = memPool2->SegmentFree(ptr2->basePtr);
        ASSERT_EQ(error, RT_ERROR_NONE);

        error = memPool2->TrimTo(0U);
        ASSERT_EQ(error, RT_ERROR_NONE);

        std::shared_ptr<SegmentManager> owned;
        error = PoolRegistry::Instance().RemoveMemPool(memPool2, owned);
        ASSERT_EQ(error, RT_ERROR_NONE);
    }

    error = memPool->SegmentFree(ptr->basePtr);
    ASSERT_EQ(error, RT_ERROR_NONE);

    std::shared_ptr<SegmentManager> owned;
    error = PoolRegistry::Instance().RemoveMemPool(memPool, owned);
    ASSERT_EQ(error, RT_ERROR_NONE);
}

void EventStateStubCallback(Stream* stream, Event* event, EventStatePeriod period, void *args)
{
    UNUSED(stream);
    UNUSED(event);
    UNUSED(period);
    UNUSED(args);
}

TEST_F(SomaTest, SomaApiEventStateCallbackRegTest)
{
    rtError_t ret = EventStateCallbackManager::Instance().RegEventStateCallback("Stub#NullptrCallback",
        nullptr, nullptr, EventStateCallbackType::RT_EVENT_STATE_CALLBACK);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = EventStateCallbackManager::Instance().RegEventStateCallback("Stub#WrongTypeCallback",
        RtPtrToPtr<void *>(EventStateStubCallback), nullptr,
        EventStateCallbackType::RT_EVENT_STATE_CALLBACK_TYPE_MAX);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
}
