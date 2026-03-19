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
#include "securec.h"
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#define private public
#include "kernel.hpp"
#include "program.hpp"
#include "uma_arg_loader.hpp"
#include "raw_device.hpp"
#include "memory_pool.hpp"
#include "memory_pool_manager.hpp"
#include "stream_mem_pool.hpp"
#include "soma.hpp"
#undef private
#include "runtime.hpp"
#include "event.hpp"
#include "npu_driver.hpp"
#include "api.hpp"
#include "cmodel_driver.h"
#include "thread_local_container.hpp"
using namespace testing;
using namespace cce::runtime;

extern "C"
{
#include "runtime/stars_interface.h"
}

class MemoryPoolManagerTest : public testing::Test
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
        std::cout << "======== init ========" << std::endl;
        MOCKER(rtSetDevice).stubs().will(returnValue(0));
        MOCKER(rtDeviceReset).stubs().will(invoke(rtDeviceResetStub));
        rtError_t rtErr;
    }

    static void TearDownTestCase()
    {

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
private:
    rtChipType_t originType;
};

// 测试基本功能
rtError_t DevMemAllocStubxx(void ** const dptr, const uint64_t size, const rtMemType_t type,
    const uint32_t deviceId, const uint16_t moduleId, const bool isLogError, const bool readOnlyFlag,
    const bool starsTillingFlag)
{
    void *ptr = malloc(size);
    *dptr = ptr;
    return RT_ERROR_NONE;
}

TEST_F(MemoryPoolManagerTest, kernel_memory_pool_test)
{
    int32_t devId = -1;
    rtError_t error;
    Device *device;

    NpuDriver * rawDrv = new NpuDriver();

    void *memBase = (void*)100;
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    int64_t aiCpuCnt = 1;
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetDevInfo)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&aiCpuCnt, sizeof(aiCpuCnt)))
        .will(returnValue(RT_ERROR_NONE));
    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device = ((Runtime *)Runtime::Instance())->DeviceRetain(devId, 0);

    MemoryPoolManager* kernelMemPoolMng = new (std::nothrow) MemoryPoolManager(device);
    error = kernelMemPoolMng->Init();
    EXPECT_EQ(error, RT_ERROR_NONE);

    // allocate
    size_t kernelSize = 4 * 1024;
    void *deviceMem = kernelMemPoolMng->Allocate(kernelSize, true);
    // release
    kernelMemPoolMng->Release(deviceMem, kernelSize);
    EXPECT_EQ(kernelMemPoolMng->numPools_, 1);
    // 为多个kernel 申请内存！
    for(size_t i = 0; i < 512; i++) {
        deviceMem = kernelMemPoolMng->Allocate(kernelSize, true);
    }
    EXPECT_EQ(kernelMemPoolMng->numPools_, 1);

    deviceMem = kernelMemPoolMng->Allocate(kernelSize, true);
    EXPECT_EQ(kernelMemPoolMng->numPools_, 2);

    // 申请超出五个内存池 并记录内存池地址
    vector<void *> deviceAddrs;

    size_t bigSize = 2 * 1024 * 1024;
    for (size_t i = 0; i < 10; i++) {
        deviceMem = kernelMemPoolMng->Allocate(bigSize, true);
        deviceAddrs.push_back(deviceMem);
    }
    EXPECT_EQ(kernelMemPoolMng->numPools_, 12);

    // 释放五个
    for (size_t i = 0; i < 5; i++) {
        kernelMemPoolMng->Release(deviceAddrs[i], bigSize);
    }
    EXPECT_EQ(kernelMemPoolMng->numPools_, 12);

    // 再释放一个 此处调用接口处 进行验证！！
    kernelMemPoolMng->Release(deviceAddrs[5], bigSize);
    EXPECT_EQ(kernelMemPoolMng->numPools_, 11);

    // 申请超出2M 内存！
    deviceMem = kernelMemPoolMng->Allocate(3 * 1024 * 1024, true);
    EXPECT_EQ(deviceMem, nullptr);

    // 申请2个1M内存
    void *deviceMem1 = kernelMemPoolMng->Allocate(1024 * 1024, true);
    void *deviceMem2 = kernelMemPoolMng->Allocate(1024 * 1024, true);
    // 释放2个1M内存
    kernelMemPoolMng->Release(deviceMem2, 1024 * 1024);
    kernelMemPoolMng->Release(deviceMem1, 1024 * 1024);

    const void* poolAddr = kernelMemPoolMng->pools_[0]->GetAddr();
    EXPECT_NE(poolAddr, nullptr);

    delete kernelMemPoolMng;
    delete rawDrv;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(MemoryPoolManagerTest, kernel_memory_list_test)
{
    int32_t devId = -1;
    rtError_t error;
    Device *device;

    NpuDriver * rawDrv = new NpuDriver();

    void *memBase = (void*)100;
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    int64_t aiCpuCnt = 1;
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetDevInfo)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&aiCpuCnt, sizeof(aiCpuCnt)))
        .will(returnValue(RT_ERROR_NONE));
    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device = ((Runtime *)Runtime::Instance())->DeviceRetain(devId, 0);

    MemoryPoolManager* kernelMemPoolMng = new (std::nothrow) MemoryPoolManager(device);
    error = kernelMemPoolMng->Init();
    EXPECT_EQ(error, RT_ERROR_NONE);

    // 申请0.5M, 1M, 0.5内存
    void *deviceMem1 = kernelMemPoolMng->Allocate(512 * 1024, true);
    void *deviceMem2 = kernelMemPoolMng->Allocate(1024 * 1024, true);
    void *deviceMem3 = kernelMemPoolMng->Allocate(512 * 1024, true);
    // 释放0.5M, 1M
    kernelMemPoolMng->Release(deviceMem1, 512 * 1024);
    kernelMemPoolMng->Release(deviceMem2, 1024 * 1024);

    void *deviceMem4 = kernelMemPoolMng->Allocate(1024 * 1024, true);

    // 释放空闲池中的内存
    kernelMemPoolMng->Release(deviceMem1 + 1, 512 * 1024);
    
    delete kernelMemPoolMng;
    delete rawDrv;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(MemoryPoolManagerTest, kernel_memory_pool_allocate_fail)
{
    int32_t devId = -1;
    rtError_t error;
    Device *device;

    NpuDriver * rawDrv = new NpuDriver();

    void *memBase = (void*)100;
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_DRV_ERR));

    int64_t aiCpuCnt = 1;
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetDevInfo)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&aiCpuCnt, sizeof(aiCpuCnt)))
        .will(returnValue(RT_ERROR_NONE));
    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device = ((Runtime *)Runtime::Instance())->DeviceRetain(devId, 0);

    MemoryPoolManager* kernelMemPoolMng = new (std::nothrow) MemoryPoolManager(device);
    error = kernelMemPoolMng->Init();
    EXPECT_NE(error, RT_ERROR_NONE);

    delete kernelMemPoolMng;
    delete rawDrv;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(MemoryPoolManagerTest, kernel_memory_pool_add_pool_fail)
{
    int32_t devId = -1;
    rtError_t error;
    Device *device;

    NpuDriver * rawDrv = new NpuDriver();

    void *memBase = (void*)100;
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_DRV_ERR));

    int64_t aiCpuCnt = 1;
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetDevInfo)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&aiCpuCnt, sizeof(aiCpuCnt)))
        .will(returnValue(RT_ERROR_NONE));
    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device = ((Runtime *)Runtime::Instance())->DeviceRetain(devId, 0);

    MemoryPoolManager* kernelMemPoolMng = new (std::nothrow) MemoryPoolManager(device);
    error = kernelMemPoolMng->AddMemoryPool(true);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete kernelMemPoolMng;
    delete rawDrv;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(MemoryPoolManagerTest, streamMemSegmentManagerNullptr)
{
    SegmentManager segManeger(nullptr, 0U, true);
}

TEST_F(MemoryPoolManagerTest, MemPoolTest)
{
    SegmentManager *memPool = nullptr;
    rtError_t error = PoolRegistry::Instance().CreateMemPool(64U, 0U, true, memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);
    uint64_t size = 8U;
    Segment *ptr = nullptr;
    const int streamId = 0;
    error = memPool->SegmentAlloc(ptr, size, streamId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = memPool->SegmentFree(ptr->basePtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    PoolRegistry::Instance().RemoveMemPool(memPool);
}

TEST_F(MemoryPoolManagerTest, PoolAllocatorSetAttributeTest)
{
    SegmentManager *memPool = nullptr;
    rtError_t error = PoolRegistry::Instance().CreateMemPool(64U, 0U, true, memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);
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
    EXPECT_EQ(error, RT_ERROR_POOL_OP_INVALID);
    attr = rtMemPoolAttr::rtMemPoolAttrUsedMemHigh;
    value = &one;
    error = memPool->SetAttribute(attr, value);
    EXPECT_EQ(error, RT_ERROR_POOL_PROP_INVALID);
    PoolRegistry::Instance().RemoveMemPool(memPool);
}

TEST_F(MemoryPoolManagerTest, PoolAllocatorGetAttributeTest)
{
    SegmentManager *memPool = nullptr;
    rtError_t error = PoolRegistry::Instance().CreateMemPool(64U, 0U, true, memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);
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
    PoolRegistry::Instance().RemoveMemPool(memPool);
}

TEST_F(MemoryPoolManagerTest, StreamOpportReuseTest_Single_Reuse)
{
    SegmentManager *memPool = nullptr;
    rtError_t error = PoolRegistry::Instance().CreateMemPool(64U, 0U, true, memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);
    uint64_t size = 8U;
    Segment *ptr = nullptr;
    const int streamId = 0;
    error = memPool->SegmentAlloc(ptr, size, streamId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = memPool->SegmentFree(ptr->basePtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ReuseFlag flag;
    Segment *ret = memPool->StreamOpportReuse(5U, 0, flag);
    EXPECT_EQ(flag, ReuseFlag::REUSE_FLAG_SINGLE_STREAM);
    EXPECT_NE(ret, nullptr);
    PoolRegistry::Instance().RemoveMemPool(memPool);
}

TEST_F(MemoryPoolManagerTest, StreamOpportReuseTest_Opport_Reuse)
{
    SegmentManager *memPool = nullptr;
    rtError_t error = PoolRegistry::Instance().CreateMemPool(64U, 0U, true, memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);
    uint64_t size = 8U;
    Segment *ptr = nullptr;
    const int streamId = 1;
    error = memPool->SegmentAlloc(ptr, size, streamId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = memPool->SegmentFree(ptr->basePtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ReuseFlag flag;
    Segment *ret = memPool->StreamOpportReuse(5U, 0, flag);
    EXPECT_EQ(flag, ReuseFlag::REUSE_FLAG_OPPOR);
    EXPECT_NE(ret, nullptr);
    PoolRegistry::Instance().RemoveMemPool(memPool);
}

TEST_F(MemoryPoolManagerTest, StreamEventReuseTest_Single_Reuse)
{
    SegmentManager *memPool = nullptr;
    rtError_t error = PoolRegistry::Instance().CreateMemPool(64U, 0U, true, memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);
    uint64_t size = 8U;
    Segment *ptr = nullptr;
    const int streamId = 0;
    error = memPool->SegmentAlloc(ptr, size, streamId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = memPool->SegmentFree(ptr->basePtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ReuseFlag flag;
    Segment *ret = memPool->StreamEventReuse(5U, 0, flag);
    EXPECT_EQ(flag, ReuseFlag::REUSE_FLAG_SINGLE_STREAM);
    EXPECT_NE(ret, nullptr);
    PoolRegistry::Instance().RemoveMemPool(memPool);
}

TEST_F(MemoryPoolManagerTest, StreamEventReuseTest_Event_Reuse)
{
    SegmentManager *memPool = nullptr;
    rtError_t error = PoolRegistry::Instance().CreateMemPool(64U, 0U, true, memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);
    uint64_t size = 8U;
    Segment *ptr = nullptr;
    const int streamId = 0;
    error = memPool->SegmentAlloc(ptr, size, streamId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = memPool->SegmentFree(ptr->basePtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    const int eventId = 0;
    const int streamId1 = 1;
    PoolRegistry::Instance().InsertEventIdToStream(streamId1, eventId);
    PoolRegistry::Instance().AddEventId(streamId, eventId);
    ReuseFlag flag;
    Segment *ret = memPool->StreamEventReuse(5U, 1, flag);
    EXPECT_EQ(flag, ReuseFlag::REUSE_FLAG_EVENT);
    EXPECT_NE(ret, nullptr);
    PoolRegistry::Instance().RemoveMemPool(memPool);
}

TEST_F(MemoryPoolManagerTest, StreamEventReuseTest_Reuse_None)
{
    SegmentManager *memPool = nullptr;
    rtError_t error = PoolRegistry::Instance().CreateMemPool(64U, 0U, true, memPool);
    EXPECT_EQ(error, RT_ERROR_NONE);
    uint64_t size = 8U;
    Segment *ptr = nullptr;
    const int streamId = 0;
    error = memPool->SegmentAlloc(ptr, size, streamId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = memPool->SegmentFree(ptr->basePtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    const int eventId1 = 0;
    const int eventId2 = 1;
    const int eventId3 = 2;
    const int streamId1 = 1;
    PoolRegistry::Instance().InsertEventIdToStream(streamId1, eventId1);
    PoolRegistry::Instance().InsertEventIdToStream(streamId1, eventId2);
    PoolRegistry::Instance().AddEventId(streamId, eventId3);
    ReuseFlag flag;
    Segment *ret = memPool->StreamEventReuse(5U, 1, flag);
    EXPECT_EQ(flag, ReuseFlag::REUSE_FLAG_NONE);
    EXPECT_EQ(ret, nullptr);
    PoolRegistry::Instance().RemoveMemPool(memPool);
}

TEST_F(MemoryPoolManagerTest, FindMemPoolByPtrTest)
{
    rtError_t error = RT_ERROR_NONE;
    SegmentManager *ret = nullptr;
    uint64_t size = DEVICE_POOL_ALIGN_SIZE;
    uint64_t ptr = 0;

    SegmentManager *memPool1 = nullptr;
    error = PoolRegistry::Instance().CreateMemPool(size, 0U, true, memPool1);
    ASSERT_EQ(error, RT_ERROR_NONE);
    ASSERT_NE(memPool1, nullptr);
    ptr = memPool1->PoolSegAddr();
    ret = PoolRegistry::Instance().FindMemPoolByPtr(ptr - 1);
    EXPECT_EQ(ret, nullptr);
    ret = PoolRegistry::Instance().FindMemPoolByPtr(ptr);
    EXPECT_EQ(ret, memPool1);
    EXPECT_EQ(ret->PoolSize(), size);
    ret = PoolRegistry::Instance().FindMemPoolByPtr(ptr + ret->PoolSize() - 1);
    EXPECT_EQ(ret, memPool1);
    ret = PoolRegistry::Instance().FindMemPoolByPtr(ptr + ret->PoolSize());
    EXPECT_EQ(ret, nullptr);

    SegmentManager *memPool2 = nullptr;
    error = PoolRegistry::Instance().CreateMemPool(size, 0U, true, memPool2);
    ASSERT_EQ(error, RT_ERROR_NONE);
    ASSERT_NE(memPool2, nullptr);
    ptr = memPool2->PoolSegAddr() + memPool2->PoolSize() / 2;
    ret = PoolRegistry::Instance().FindMemPoolByPtr(ptr);
    EXPECT_EQ(ret, memPool2);

    PoolRegistry::Instance().RemoveMemPool(memPool1);
    PoolRegistry::Instance().RemoveMemPool(memPool2);
}

TEST_F(MemoryPoolManagerTest, SomaApiTest_Create_Destory)
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
    error = SomaApi::CreateMemPool(poolProps, totalSize, memPool1);
    ASSERT_EQ(error, RT_ERROR_NONE);
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
    error = SomaApi::CreateMemPool(poolProps1, totalSize, memPool1);
    ASSERT_EQ(error, RT_ERROR_MEMORY_ALLOCATION);
}

TEST_F(MemoryPoolManagerTest, SomaApiTest_Alloc_Free)
{
    rtError_t error = RT_ERROR_NONE;
    uint64_t totalSize = DEVICE_POOL_ALIGN_SIZE;

    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = 0,
        .reserve = 0
    };
    SegmentManager *memPool = nullptr;
    error = SomaApi::CreateMemPool(poolProps, totalSize, memPool);
    ASSERT_EQ(error, RT_ERROR_NONE);
    ASSERT_NE(memPool, nullptr);

    void *ptr;
    uint64_t size = 64;
    const int32_t streamId = 0;
    rtMemPool_t memPoolId = RtValueToPtr<void *>(memPool->MemPoolId());
    error = SomaApi::AllocFromMemPool(&ptr, size, memPoolId, streamId);
    ASSERT_EQ(error, RT_ERROR_NONE);
    error = SomaApi::FreeToMemPool(ptr);
    ASSERT_EQ(error, RT_ERROR_NONE);
    error = SomaApi::DestroyMemPool(memPool);
    ASSERT_EQ(error, RT_ERROR_NONE);
}

TEST_F(MemoryPoolManagerTest, SomaApiMemoryAlignmentTest)
{
    rtError_t error = RT_ERROR_NONE;
    uint64_t totalSize = DEVICE_POOL_VADDR_SIZE;

    rtMemPoolProps poolProps = {
        .side = 1,
        .devId = 0,
        .handleType = RT_MEM_HANDLE_TYPE_POSIX,
        .maxSize = DEVICE_POOL_ALIGN_SIZE - 1,
        .reserve = 0
    };
    SegmentManager *memPool = nullptr;
    error = SomaApi::CreateMemPool(poolProps, totalSize, memPool);
    ASSERT_EQ(error, RT_ERROR_NONE);
    ASSERT_NE(memPool, nullptr);
    ASSERT_EQ(memPool->PoolSize(), DEVICE_POOL_ALIGN_SIZE);

    ASSERT_EQ(error, RT_ERROR_NONE);
    error = SomaApi::DestroyMemPool(memPool);
    ASSERT_EQ(error, RT_ERROR_NONE);
}