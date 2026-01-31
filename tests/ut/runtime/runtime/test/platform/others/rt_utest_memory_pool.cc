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

TEST_F(MemoryPoolManagerTest, get_memory_pool_advise_mutex_fail)
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
    std::mutex * adviseMutex = kernelMemPoolMng->GetMemoryPoolAdviseMutex(nullptr);
    EXPECT_EQ(adviseMutex, nullptr);

    delete kernelMemPoolMng;
    delete rawDrv;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(MemoryPoolManagerTest, get_memory_pool_base_addr_fail)
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
    const void * baseAddr = kernelMemPoolMng->GetMemoryPoolBaseAddr(nullptr);
    EXPECT_EQ(baseAddr, nullptr);

    delete kernelMemPoolMng;
    delete rawDrv;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}
