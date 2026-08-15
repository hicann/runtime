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
#include "driver/ascend_hal.h"
#include "securec.h"
#include "runtime/rt.h"
#include "runtime/rts/rts.h"
#include "runtime/event.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "api.hpp"
#include "api_impl.hpp"
#include "api_error.hpp"
#include "api_c.h"
#include "api_error.hpp"
#include "raw_device.hpp"
#include "npu_driver.hpp"
#include "register_memory.hpp"
#include "runtime/mem.h"
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include <cstring>
#undef protected
#undef private

using namespace testing;
using namespace cce::runtime;

class RtMemoryApiTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        Runtime* rtInstance = const_cast<Runtime*>(Runtime::Instance());
        rtInstance->SetIsUserSetSocVersion(false);
        rtInstance->SetSocVersion("Ascend910B2");
        GlobalContainer::SetRtChipType(CHIP_910_B_93);
        GlobalContainer::SetSocVersion("Ascend910B2");
        GlobalContainer::SetHardwareSocVersion("Ascend910B2");
        RawDevice* rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
        std::cout << "engine test start" << std::endl;
    }

    static void TearDownTestCase() {}

    virtual void SetUp()
    {
        Runtime* rtInstance = const_cast<Runtime*>(Runtime::Instance());
        rtInstance->SetIsUserSetSocVersion(false);
        rtInstance->SetSocVersion("Ascend910B2");
        GlobalContainer::SetRtChipType(CHIP_910_B_93);
        GlobalContainer::SetSocVersion("Ascend910B2");
        GlobalContainer::SetHardwareSocVersion("Ascend910B2");
        EXPECT_EQ(rtSetDevice(0), RT_ERROR_NONE);
        RawDevice* rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        (void)rtDeviceReset(0);
    }

private:
    rtChipType_t originType_;
};

TEST_F(RtMemoryApiTest, rtReserveMemAddress)
{
    void* devPtr = nullptr;
    rtError_t error = rtReserveMemAddress(&devPtr, 0, 0, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halMemAddressReserve).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtReserveMemAddress(&devPtr, 0, 0, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtReleaseMemAddress)
{
    rtError_t error = rtReleaseMemAddress(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halMemAddressFree).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtReleaseMemAddress(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtMallocPhysical)
{
    rtDrvMemHandle handle = nullptr;
    rtDrvMemProp_t prop = {};
    prop.mem_type = RT_MEMORY_DEFAULT; // HBM 内存，当前只支持申请HBM内存
    prop.pg_type = 1;
    prop.side = 1;
    prop.devid = 0;
    prop.module_id = 0;
    size_t size = 32;

    MOCKER(halMemCreate).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error = rtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, testHostNumaAlloc)
{
    rtDrvMemHandle handle = nullptr;
    rtDrvMemProp_t prop = {};
    prop.side = 4;
    prop.devid = 0;
    prop.pg_type = RT_MEMORY_DEFAULT;
    prop.mem_type = 0;
    int32_t deviceId = 0;
    rtError_t error = rtSetDevice(deviceId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    MOCKER(halMemCreate).stubs().will(returnValue(DRV_ERROR_NONE));
    error = rtMallocPhysical(&handle, 1, &prop, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceReset(deviceId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtMemoryApiTest, testGetAllocationGranularity)
{
    rtDrvMemProp_t prop = {};
    prop.side = 1;
    prop.pg_type = 0;
    prop.mem_type = 0;

    MOCKER(halMemGetAllocationGranularity).stubs().will(returnValue(DRV_ERROR_NONE));
    size_t granularity;
    rtError_t error = rtMemGetAllocationGranularity(&prop, RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity);
    EXPECT_EQ(error, RT_ERROR_NONE);

    int32_t deviceId = 0;
    error = rtSetDevice(deviceId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    prop.side = 4;
    prop.devid = deviceId;
    error = rtMemGetAllocationGranularity(&prop, RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceReset(deviceId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtMemoryApiTest, testMemSetAccess)
{
    std::vector<rtMemAccessDesc> accessDescs;
    rtMemAccessDesc desc;
    int32_t deviceId = 0;
    void* virptr = (void*)10;
    size_t size = 2 * 1024 * 1024;
    desc.location.type = static_cast<rtMemLocationType>(4);
    desc.location.id = deviceId;
    desc.flags = RT_MEM_ACCESS_FLAGS_READWRITE;
    accessDescs.push_back(desc);

    MOCKER(halMemSetAccess).stubs().will(returnValue(DRV_ERROR_NONE));

    rtError_t error = rtMemSetAccess(virptr, size, accessDescs.data(), accessDescs.size());
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtMemoryApiTest, rtFreePhysical)
{
    rtDrvMemHandle handle = nullptr;
    rtError_t error = rtFreePhysical(handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halMemRelease).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtFreePhysical(handle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtMapMem)
{
    rtError_t error = rtMapMem(nullptr, 0, 0, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halMemMap).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMapMem(nullptr, 0, 0, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, NpuDriverMemMapNoAccessPassesAllArgumentsToHal)
{
    uint8_t virPtrToken = 0U;
    void* virPtr = static_cast<void*>(&virPtrToken);
    constexpr size_t size = 0x200000U;
    constexpr size_t offset = 0x1000U;
    uint8_t handleToken = 0U;
    rtDrvMemHandle handle = static_cast<void*>(&handleToken);
    constexpr uint64_t flags = 0U;

    MOCKER(halMemMapNoAccess)
        .expects(once())
        .with(
            mockcpp::eq(virPtr), mockcpp::eq(size), mockcpp::eq(offset),
            mockcpp::eq(reinterpret_cast<drv_mem_handle_t*>(handle)), mockcpp::eq(flags))
        .will(returnValue(DRV_ERROR_NONE));

    const rtError_t error = NpuDriver::MemMapNoAccess(virPtr, size, offset, handle, flags);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtMemoryApiTest, NpuDriverMemMapNoAccessReturnsFeatureNotSupport)
{
    uint8_t virPtrToken = 0U;
    uint8_t handleToken = 0U;
    rtDrvMemHandle handle = static_cast<void*>(&handleToken);
    MOCKER(halMemMapNoAccess).expects(once()).will(returnValue(DRV_ERROR_NOT_SUPPORT));

    const rtError_t error = NpuDriver::MemMapNoAccess(&virPtrToken, 1U, 0U, handle, 0U);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(RtMemoryApiTest, NpuDriverMemMapNoAccessConvertsDriverError)
{
    uint8_t virPtrToken = 0U;
    uint8_t handleToken = 0U;
    rtDrvMemHandle handle = static_cast<void*>(&handleToken);
    MOCKER(halMemMapNoAccess).expects(once()).will(returnValue(DRV_ERROR_INVALID_VALUE));

    const rtError_t error = NpuDriver::MemMapNoAccess(&virPtrToken, 1U, 0U, handle, 0U);
    EXPECT_EQ(error, RT_GET_DRV_ERRCODE(DRV_ERROR_INVALID_VALUE));
}

TEST_F(RtMemoryApiTest, RtMemMapNoAccessPassesAllArgumentsToHal)
{
    uint8_t virPtrToken = 0U;
    void* virPtr = static_cast<void*>(&virPtrToken);
    constexpr size_t size = 0x200000U;
    constexpr size_t offset = 0x1000U;
    uint8_t handleToken = 0U;
    rtDrvMemHandle handle = static_cast<void*>(&handleToken);
    constexpr uint64_t flags = 0U;

    MOCKER(halMemMapNoAccess)
        .expects(once())
        .with(
            mockcpp::eq(virPtr), mockcpp::eq(size), mockcpp::eq(offset),
            mockcpp::eq(reinterpret_cast<drv_mem_handle_t*>(handle)), mockcpp::eq(flags))
        .will(returnValue(DRV_ERROR_NONE));

    const rtError_t error = rtMemMapNoAccess(virPtr, size, offset, handle, flags);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtMemoryApiTest, RtMemMapNoAccessConvertsFeatureNotSupport)
{
    uint8_t virPtrToken = 0U;
    uint8_t handleToken = 0U;
    rtDrvMemHandle handle = static_cast<void*>(&handleToken);
    MOCKER(halMemMapNoAccess).expects(once()).will(returnValue(DRV_ERROR_NOT_SUPPORT));

    const rtError_t error = rtMemMapNoAccess(&virPtrToken, 1U, 0U, handle, 0U);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(RtMemoryApiTest, RtMemMapNoAccessConvertsDriverError)
{
    uint8_t virPtrToken = 0U;
    uint8_t handleToken = 0U;
    rtDrvMemHandle handle = static_cast<void*>(&handleToken);
    MOCKER(halMemMapNoAccess).expects(once()).will(returnValue(DRV_ERROR_INVALID_VALUE));

    const rtError_t error = rtMemMapNoAccess(&virPtrToken, 1U, 0U, handle, 0U);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtUnmapMem)
{
    rtError_t error = rtUnmapMem(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halMemUnmap).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtUnmapMem(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtSetIpcMemorySuperPodPid)
{
    rtError_t error;
    int32_t pids[2] = {100, 1000};
    error = rtSetIpcMemorySuperPodPid("test1", 100, pids, sizeof(pids) / sizeof(int32_t));
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halShmemSetPodPid).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtSetIpcMemorySuperPodPid("test1", 100, pids, sizeof(pids) / sizeof(int32_t));
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtBindHostPid)
{
    rtBindHostpidInfo info = {};
    rtError_t error = rtBindHostPid(info);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(drvBindHostPid).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtBindHostPid(info);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtUnbindHostPid)
{
    rtBindHostpidInfo info = {};
    rtError_t error = rtUnbindHostPid(info);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(drvUnbindHostPid).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtUnbindHostPid(info);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtQueryProcessHostPid)
{
    rtError_t error;
    error = rtQueryProcessHostPid(0, nullptr, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(drvQueryProcessHostPid).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtQueryProcessHostPid(0, nullptr, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtGetServerIDBySDID)
{
    rtError_t error;
    uint32_t sdid1 = 0x66660000U;
    uint32_t srvid = 0;

    error = rtGetServerIDBySDID(sdid1, &srvid);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MOCKER(halParseSDID).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtGetServerIDBySDID(sdid1, &srvid);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtGetMemUsageInfo)
{
    uint32_t deviceId = 0;
    rtMemUsageInfo_t memUsageInfo[10];
    size_t inputNum = 10;
    size_t outputNum = 10;

    rtError_t error = rtGetMemUsageInfo(deviceId, memUsageInfo, inputNum, &outputNum);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    ApiImpl apiImpl;
    ApiDecorator apiDecorator(&apiImpl);
    error = apiDecorator.GetMemUsageInfo(deviceId, memUsageInfo, inputNum, &outputNum);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MOCKER(halGetMemUsageInfo).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtGetMemUsageInfo(deviceId, memUsageInfo, inputNum, &outputNum);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtsMallocHost_001)
{
    rtError_t error;
    Api* Api_ = const_cast<Api*>(Runtime::runtime_->api_);
    ApiDecorator* apiDecorator_ = new ApiDecorator(Api_);
    void* hostPtr = nullptr;
    rtMallocConfig_t* malloCfg = (rtMallocConfig_t*)malloc(sizeof(rtMallocConfig_t));
    rtMallocAttribute_t* mallocAttrs = new rtMallocAttribute_t[1];
    malloCfg->numAttrs = 1;

    // 无效cfg校验
    malloCfg->attrs = nullptr;
    error = apiDecorator_->HostMallocWithCfg(&hostPtr, 1, malloCfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    // 无效hostPtr校验
    malloCfg->attrs = mallocAttrs;
    mallocAttrs[0].attr = RT_MEM_MALLOC_ATTR_MODULE_ID;
    mallocAttrs[0].value.moduleId = 1;
    error = apiDecorator_->HostMallocWithCfg(nullptr, 1, malloCfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    // 无效size校验
    error = apiDecorator_->HostMallocWithCfg(&hostPtr, 0, malloCfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete[] mallocAttrs;
    free(malloCfg);
    delete apiDecorator_;
}

TEST_F(RtMemoryApiTest, rtsMallocHost_002)
{
    rtError_t error;
    Api* Api_ = const_cast<Api*>(Runtime::runtime_->api_);
    ApiDecorator* apiDecorator_ = new ApiDecorator(Api_);
    void* hostPtr = nullptr;
    rtMallocConfig_t* malloCfg = (rtMallocConfig_t*)malloc(sizeof(rtMallocConfig_t));
    rtMallocAttribute_t* mallocAttrs = new rtMallocAttribute_t[1];
    malloCfg->numAttrs = 1;
    malloCfg->attrs = mallocAttrs;

    // 申请内存的cfg不支持module/uva之外的类型
    mallocAttrs[0].attr = RT_MEM_MALLOC_ATTR_RSV;
    mallocAttrs[0].value.moduleId = 0;
    error = apiDecorator_->HostMallocWithCfg(&hostPtr, 60, malloCfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    mallocAttrs[0].attr = RT_MEM_MALLOC_ATTR_DEVICE_ID;
    error = apiDecorator_->HostMallocWithCfg(&hostPtr, 60, malloCfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    // 配置moduleId
    mallocAttrs[0].attr = RT_MEM_MALLOC_ATTR_MODULE_ID;
    mallocAttrs[0].value.moduleId = 1;
    error = apiDecorator_->HostMallocWithCfg(&hostPtr, 60, malloCfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
    if (error == RT_ERROR_NONE) {
        error = apiDecorator_->HostFree(hostPtr);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }

    delete[] mallocAttrs;
    free(malloCfg);
    delete apiDecorator_;
}

TEST_F(RtMemoryApiTest, rtsMallocHost_003)
{
    rtError_t error;
    Api* Api_ = const_cast<Api*>(Runtime::runtime_->api_);
    ApiDecorator* apiDecorator_ = new ApiDecorator(Api_);
    void* hostPtr = nullptr;
    rtMallocConfig_t* malloCfg = (rtMallocConfig_t*)malloc(sizeof(rtMallocConfig_t));
    rtMallocAttribute_t* mallocAttrs = new rtMallocAttribute_t[1];
    malloCfg->numAttrs = 1;
    malloCfg->attrs = mallocAttrs;

    // UVA类型，但是value为0，默认不启用特性
    mallocAttrs[0].attr = RT_MEM_MALLOC_ATTR_VA_FLAG;
    mallocAttrs[0].value.vaFlag = 0;
    error = apiDecorator_->HostMallocWithCfg(&hostPtr, 60, malloCfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
    if (error == RT_ERROR_NONE) {
        error = apiDecorator_->HostFree(hostPtr);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }

    // UVA类型，value设置为1，启用特性
    mallocAttrs[0].value.vaFlag = 1;
    error = apiDecorator_->HostMallocWithCfg(&hostPtr, 60, malloCfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
    if (error == RT_ERROR_NONE) {
        error = apiDecorator_->HostFree(hostPtr);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }

    delete[] mallocAttrs;
    free(malloCfg);
    delete apiDecorator_;
}

namespace {
static UINT32 g_hostRegFlagCapture = 0U;
static uint32_t g_hostRegCallCount = 0U;

drvError_t halHostRegister_capture_stub(void* hostPtr, UINT64 size, UINT32 flag, UINT32 devid, void** devPtr)
{
    g_hostRegFlagCapture = flag;
    g_hostRegCallCount++;
    *devPtr = hostPtr;
    return DRV_ERROR_NONE;
}

drvError_t halHostRegister_first_success_then_fail(void* hostPtr, UINT64 size, UINT32 flag, UINT32 devid, void** devPtr)
{
    g_hostRegCallCount++;
    if (g_hostRegCallCount == 1U) {
        g_hostRegFlagCapture = flag;
        *devPtr = hostPtr;
        return DRV_ERROR_NONE;
    }
    return DRV_ERROR_BUSY;
}

static uint32_t g_hostUnregCallCount = 0U;
static uint32_t g_hostUnregExCallCount = 0U;
drvError_t halHostUnregister_success(void* hostPtr, UINT32 devid)
{
    g_hostUnregCallCount++;
    return DRV_ERROR_NONE;
}

drvError_t halHostUnregisterEx_success(void* srcPtr, UINT32 devid, UINT32 flag)
{
    g_hostUnregExCallCount++;
    return DRV_ERROR_NONE;
}

void checkRegisterStatus(UINT32 expectedFlag, void* ptr, bool mapExists, bool pinExists)
{
    EXPECT_EQ(g_hostRegFlagCapture, expectedFlag);
    if (mapExists) {
        EXPECT_TRUE(IsMappedMemoryBase(ptr));
    } else {
        EXPECT_FALSE(IsMappedMemoryBase(ptr));
    }
    if (pinExists) {
        EXPECT_TRUE(IsPinnedMemoryBase(ptr));
    } else {
        EXPECT_FALSE(IsPinnedMemoryBase(ptr));
    }
}
} // namespace

class RtMemRegisterApiTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        (void)rtSetDevice(0);
        (void)rtSetTSDevice(0);
    }

    static void TearDownTestCase()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
    }

    virtual void SetUp()
    {
        GlobalMockObject::verify();
        g_hostRegFlagCapture = 0U;
        g_hostRegCallCount = 0U;
        g_hostUnregCallCount = 0U;
        g_hostUnregExCallCount = 0U;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        g_hostRegFlagCapture = 0U;
        g_hostRegCallCount = 0U;
        g_hostUnregCallCount = 0U;
        g_hostUnregExCallCount = 0U;
    }

    void MockPinRegister(bool value)
    {
        Device* device = Runtime::Instance()->CurrentContext()->Device_();
        MOCKER_CPP_VIRTUAL(device, &Device::IsSupportPinRegister).stubs().will(returnValue(value));
    }
};

// switch on + pin only
TEST_F(RtMemRegisterApiTest, host_register_v2_drv_pin_only)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    MockPinRegister(true);

    MOCKER(halHostRegister).stubs().will(invoke(halHostRegister_capture_stub));
    MOCKER(halHostUnregister).stubs().will(invoke(halHostUnregister_success));
    MOCKER(halHostUnregisterEx).stubs().will(invoke(halHostUnregisterEx_success));

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(g_hostRegCallCount, 1);
    checkRegisterStatus(static_cast<UINT32>(MEM_REGISTER_HOST_PINNED), ptr.get(), false, false);

    error = rtsHostUnregister(ptr.get());
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(g_hostUnregCallCount, 1);
    EXPECT_EQ(g_hostUnregExCallCount, 0);

    GlobalMockObject::verify();
}

// switch on + mapped only
TEST_F(RtMemRegisterApiTest, host_register_v2_drv_mapped_only)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    MockPinRegister(true);

    MOCKER(halHostRegister).stubs().will(invoke(halHostRegister_capture_stub));
    MOCKER(halHostUnregister).stubs().will(invoke(halHostUnregister_success));
    MOCKER(halHostUnregisterEx).stubs().will(invoke(halHostUnregisterEx_success));

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_MAPPED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(g_hostRegCallCount, 1);
    checkRegisterStatus(static_cast<UINT32>(HOST_MEM_MAP_DEV_V2), ptr.get(), false, false);

    error = rtsHostUnregister(ptr.get());
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(g_hostUnregCallCount, 1);
    EXPECT_EQ(g_hostUnregExCallCount, 0);

    GlobalMockObject::verify();
}

// switch on + pin+map combined, single halHostRegister call
TEST_F(RtMemRegisterApiTest, host_register_v2_drv_pin_mapped_combined)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    MockPinRegister(true);

    MOCKER(halHostRegister).stubs().will(invoke(halHostRegister_capture_stub));
    MOCKER(halHostUnregister).stubs().will(invoke(halHostUnregister_success));
    MOCKER(halHostUnregisterEx).stubs().will(invoke(halHostUnregisterEx_success));

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_MAPPED | RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(g_hostRegCallCount, 1);
    checkRegisterStatus(
        static_cast<UINT32>(MEM_REGISTER_HOST_PINNED) | static_cast<UINT32>(HOST_MEM_MAP_DEV_V2), ptr.get(), false,
        false);

    error = rtsHostUnregister(ptr.get());
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(g_hostUnregCallCount, 1);
    EXPECT_EQ(g_hostUnregExCallCount, 0);

    GlobalMockObject::verify();
}

// switch on + duplicate registration: first call success, second returns error
TEST_F(RtMemRegisterApiTest, host_register_v2_drv_already_registered)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    MockPinRegister(true);
    g_hostRegCallCount = 0U;

    MOCKER(halHostRegister).stubs().will(invoke(halHostRegister_first_success_then_fail));
    MOCKER(halHostUnregister).stubs().will(returnValue(DRV_ERROR_NONE));

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, ACL_ERROR_HOST_MEMORY_ALREADY_REGISTERED);

    error = rtsHostUnregister(ptr.get());
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

// switch on + driver returns generic error
TEST_F(RtMemRegisterApiTest, host_register_v2_drv_error)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    MockPinRegister(true);

    MOCKER(halHostRegister).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT));

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    GlobalMockObject::verify();
}

// switch off + pin only, halHostRegister not called
TEST_F(RtMemRegisterApiTest, host_register_v2_sw_pin_only)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    MockPinRegister(false);
    MOCKER(halHostRegister).stubs().will(invoke(halHostRegister_capture_stub));
    MOCKER(halHostUnregister).stubs().will(invoke(halHostUnregister_success));
    MOCKER(halHostUnregisterEx).stubs().will(invoke(halHostUnregisterEx_success));

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(g_hostRegCallCount, 0);
    EXPECT_TRUE(IsPinnedMemoryBase(ptr.get()));
    EXPECT_FALSE(IsMappedMemoryBase(ptr.get()));

    error = rtsHostUnregister(ptr.get());
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(g_hostUnregCallCount, 0);
    EXPECT_EQ(g_hostUnregExCallCount, 0);
    EXPECT_FALSE(IsPinnedMemoryBase(ptr.get()));
    EXPECT_FALSE(IsMappedMemoryBase(ptr.get()));
    GlobalMockObject::verify();
}

// switch off + mapped, software table recorded
TEST_F(RtMemRegisterApiTest, host_register_v2_sw_mapped_only)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    MockPinRegister(false);

    MOCKER(halHostRegister).stubs().will(invoke(halHostRegister_capture_stub));
    MOCKER(halHostUnregister).stubs().will(invoke(halHostUnregister_success));
    MOCKER(halHostUnregisterEx).stubs().will(invoke(halHostUnregisterEx_success));

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_MAPPED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(g_hostRegCallCount, 1);
    checkRegisterStatus(static_cast<UINT32>(HOST_MEM_MAP_DEV_PCIE_TH), ptr.get(), true, false);

    error = rtsHostUnregister(ptr.get());
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(g_hostUnregCallCount, 0);
    EXPECT_EQ(g_hostUnregExCallCount, 1);
    EXPECT_FALSE(IsPinnedMemoryBase(ptr.get()));
    EXPECT_FALSE(IsMappedMemoryBase(ptr.get()));

    GlobalMockObject::verify();
}

// switch off + pin+map
TEST_F(RtMemRegisterApiTest, host_register_v2_sw_pin_mapped_no_pin_flag)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    MockPinRegister(false);

    MOCKER(halHostRegister).stubs().will(invoke(halHostRegister_capture_stub));
    MOCKER(halHostUnregister).stubs().will(invoke(halHostUnregister_success));
    MOCKER(halHostUnregisterEx).stubs().will(invoke(halHostUnregisterEx_success));

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_MAPPED | RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(g_hostRegCallCount, 1);
    checkRegisterStatus(static_cast<UINT32>(HOST_MEM_MAP_DEV_PCIE_TH), ptr.get(), true, true);

    error = rtsHostUnregister(ptr.get());
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(g_hostUnregCallCount, 0);
    EXPECT_EQ(g_hostUnregExCallCount, 1);
    EXPECT_FALSE(IsPinnedMemoryBase(ptr.get()));
    EXPECT_FALSE(IsMappedMemoryBase(ptr.get()));

    GlobalMockObject::verify();
}

// switch off + driver call fails, no software table recorded
TEST_F(RtMemRegisterApiTest, host_register_v2_sw_drv_fail)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    MockPinRegister(false);

    MOCKER(halHostRegister).stubs().will(returnValue(DRV_ERROR_INNER_ERR));

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_MAPPED);
    EXPECT_NE(error, RT_ERROR_NONE);
    EXPECT_FALSE(IsMappedMemoryBase(ptr.get()));

    error = rtsHostUnregister(ptr.get());
    EXPECT_NE(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

// switch off + duplicate registration: pin first, then map+pin on same address
TEST_F(RtMemRegisterApiTest, host_register_v2_sw_pin_then_pin_mapped_duplicate)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    MockPinRegister(false);
    MOCKER(halHostRegister).stubs().will(invoke(halHostRegister_capture_stub));

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(g_hostRegCallCount, 0);

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_MAPPED | RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, ACL_ERROR_HOST_MEMORY_ALREADY_REGISTERED);
    EXPECT_EQ(g_hostRegCallCount, 0);

    error = rtHostRegisterV2(
        RtValueToPtr<void*>(RtPtrToValue(ptr.get()) + 1U), sizeof(uint32_t),
        RT_MEM_HOST_REGISTER_MAPPED | RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, ACL_ERROR_HOST_MEMORY_ALREADY_REGISTERED);
    EXPECT_EQ(g_hostRegCallCount, 0);

    error = rtsHostUnregister(ptr.get());
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

// switch on + unregister unregistered memory
TEST_F(RtMemRegisterApiTest, host_unregister_v2_drv_unregistered)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    MockPinRegister(true);

    MOCKER(halHostUnregister).stubs().will(returnValue(DRV_ERROR_NOT_EXIST));

    error = rtsHostUnregister(ptr.get());
    EXPECT_EQ(error, ACL_ERROR_HOST_MEMORY_NOT_REGISTERED);

    GlobalMockObject::verify();
}

// switch off + unregister unregistered memory
TEST_F(RtMemRegisterApiTest, host_unregister_v2_sw_unregistered)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    MockPinRegister(false);

    error = rtsHostUnregister(ptr.get());
    EXPECT_EQ(error, ACL_ERROR_HOST_MEMORY_NOT_REGISTERED);

    GlobalMockObject::verify();
}

// switch on + rtsHostRegister mapped: flag = HOST_MEM_MAP_DEV_V2
TEST_F(RtMemRegisterApiTest, host_register_mapped_drv)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    void* devPtr = nullptr;

    MockPinRegister(true);
    MOCKER(halHostRegister).stubs().will(invoke(halHostRegister_capture_stub));
    MOCKER(halHostUnregister).stubs().will(invoke(halHostUnregister_success));
    MOCKER(halHostUnregisterEx).stubs().will(invoke(halHostUnregisterEx_success));

    error = rtsHostRegister(ptr.get(), sizeof(uint32_t), RT_HOST_REGISTER_MAPPED, &devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(g_hostRegCallCount, 1);
    checkRegisterStatus(static_cast<UINT32>(HOST_MEM_MAP_DEV_V2), ptr.get(), false, false);

    error = rtsHostUnregister(ptr.get());
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(g_hostUnregCallCount, 1);
    EXPECT_EQ(g_hostUnregExCallCount, 0);

    GlobalMockObject::verify();
}

// switch on + rtsHostRegister duplicate: first success, second returns error
TEST_F(RtMemRegisterApiTest, host_register_duplicate_drv)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    void* devPtr = nullptr;

    MockPinRegister(true);
    g_hostRegCallCount = 0U;
    MOCKER(halHostRegister).stubs().will(invoke(halHostRegister_first_success_then_fail));
    MOCKER(halHostUnregister).stubs().will(returnValue(DRV_ERROR_NONE));

    error = rtsHostRegister(ptr.get(), sizeof(uint32_t), RT_HOST_REGISTER_MAPPED, &devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsHostRegister(ptr.get(), sizeof(uint32_t), RT_HOST_REGISTER_MAPPED, &devPtr);
    EXPECT_EQ(error, ACL_ERROR_HOST_MEMORY_ALREADY_REGISTERED);

    error = rtsHostUnregister(ptr.get());
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

// switch off + rtsHostRegister mapped: InsertMappedMemory recorded
TEST_F(RtMemRegisterApiTest, host_register_mapped_sw)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    void* devPtr = nullptr;

    MockPinRegister(false);
    MOCKER(halHostRegister).stubs().will(invoke(halHostRegister_capture_stub));
    MOCKER(halHostUnregister).stubs().will(invoke(halHostUnregister_success));
    MOCKER(halHostUnregisterEx).stubs().will(invoke(halHostUnregisterEx_success));

    error = rtsHostRegister(ptr.get(), sizeof(uint32_t), RT_HOST_REGISTER_MAPPED, &devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(g_hostRegCallCount, 1);
    checkRegisterStatus(static_cast<UINT32>(HOST_MEM_MAP_DEV_PCIE_TH), ptr.get(), true, false);

    error = rtsHostUnregister(ptr.get());
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(g_hostUnregCallCount, 0);
    EXPECT_EQ(g_hostUnregExCallCount, 1);
    EXPECT_FALSE(IsPinnedMemoryBase(ptr.get()));

    GlobalMockObject::verify();
}

// switch off + rtsHostRegister mapped twice: no duplicate check in old API
TEST_F(RtMemRegisterApiTest, host_register_duplicate_sw)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    void* devPtr = nullptr;

    MockPinRegister(false);
    MOCKER(halHostRegister).stubs().will(invoke(halHostRegister_first_success_then_fail));

    error = rtsHostRegister(ptr.get(), sizeof(uint32_t), RT_HOST_REGISTER_MAPPED, &devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // old API does not have CheckMemoryRangeRegistered, but driver returns DRV_ERROR_BUSY
    // on duplicate registration, which is mapped to ACL_ERROR_HOST_MEMORY_ALREADY_REGISTERED
    error = rtsHostRegister(ptr.get(), sizeof(uint32_t), RT_HOST_REGISTER_MAPPED, &devPtr);
    EXPECT_EQ(error, ACL_ERROR_HOST_MEMORY_ALREADY_REGISTERED);

    error = rtsHostUnregister(ptr.get());
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

// switch on + IO READONLY PIN combined
TEST_F(RtMemRegisterApiTest, host_register_v2_forall_nopin)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    MockPinRegister(true);

    MOCKER(halHostRegister).stubs().will(invoke(halHostRegister_capture_stub));
    MOCKER(halHostUnregister).stubs().will(returnValue(DRV_ERROR_NONE));

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_IOMEMORY);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(static_cast<UINT32>(HOST_IO_MAP_DEV), ptr.get(), false, false);
    (void)rtsHostUnregister(ptr.get());

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_READONLY);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_MEM_MAP_DEV_V2) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), false,
        false);
    (void)rtsHostUnregister(ptr.get());

    error =
        rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_IOMEMORY | RT_MEM_HOST_REGISTER_READONLY);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_IO_MAP_DEV) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), false, false);
    (void)rtsHostUnregister(ptr.get());

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_IOMEMORY | RT_MEM_HOST_REGISTER_MAPPED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(static_cast<UINT32>(HOST_IO_MAP_DEV), ptr.get(), false, false);
    (void)rtsHostUnregister(ptr.get());

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_READONLY | RT_MEM_HOST_REGISTER_MAPPED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_MEM_MAP_DEV_V2) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), false,
        false);
    (void)rtsHostUnregister(ptr.get());

    error = rtHostRegisterV2(
        ptr.get(), sizeof(uint32_t),
        RT_MEM_HOST_REGISTER_MAPPED | RT_MEM_HOST_REGISTER_IOMEMORY | RT_MEM_HOST_REGISTER_READONLY);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_IO_MAP_DEV) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), false, false);
    (void)rtsHostUnregister(ptr.get());

    GlobalMockObject::verify();
}

TEST_F(RtMemRegisterApiTest, host_register_v2_forall_withpin)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    MockPinRegister(true);

    MOCKER(halHostRegister).stubs().will(invoke(halHostRegister_capture_stub));
    MOCKER(halHostUnregister).stubs().will(returnValue(DRV_ERROR_NONE));

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_IOMEMORY | RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(static_cast<UINT32>(HOST_IO_MAP_DEV), ptr.get(), false, false);
    (void)rtsHostUnregister(ptr.get());

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_READONLY | RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_MEM_MAP_DEV_V2) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY) |
            static_cast<UINT32>(MEM_REGISTER_HOST_PINNED),
        ptr.get(), false, false);
    (void)rtsHostUnregister(ptr.get());

    error = rtHostRegisterV2(
        ptr.get(), sizeof(uint32_t),
        RT_MEM_HOST_REGISTER_IOMEMORY | RT_MEM_HOST_REGISTER_READONLY | RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_IO_MAP_DEV) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), false, false);
    (void)rtsHostUnregister(ptr.get());

    error = rtHostRegisterV2(
        ptr.get(), sizeof(uint32_t),
        RT_MEM_HOST_REGISTER_MAPPED | RT_MEM_HOST_REGISTER_READONLY | RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_MEM_MAP_DEV_V2) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY) |
            static_cast<UINT32>(MEM_REGISTER_HOST_PINNED),
        ptr.get(), false, false);
    (void)rtsHostUnregister(ptr.get());

    error = rtHostRegisterV2(
        ptr.get(), sizeof(uint32_t),
        RT_MEM_HOST_REGISTER_MAPPED | RT_MEM_HOST_REGISTER_IOMEMORY | RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(static_cast<UINT32>(HOST_IO_MAP_DEV), ptr.get(), false, false);
    (void)rtsHostUnregister(ptr.get());

    error = rtHostRegisterV2(
        ptr.get(), sizeof(uint32_t),
        RT_MEM_HOST_REGISTER_MAPPED | RT_MEM_HOST_REGISTER_IOMEMORY | RT_MEM_HOST_REGISTER_READONLY |
            RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_IO_MAP_DEV) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), false, false);
    (void)rtsHostUnregister(ptr.get());

    GlobalMockObject::verify();
}

// switch off + IO READONLY PIN combined
TEST_F(RtMemRegisterApiTest, host_register_v2_forall_olddrv_nopin)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    MockPinRegister(false);

    MOCKER(halHostRegister).stubs().will(invoke(halHostRegister_capture_stub));
    MOCKER(halHostUnregisterEx).stubs().will(returnValue(DRV_ERROR_NONE));

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_IOMEMORY);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(static_cast<UINT32>(HOST_IO_MAP_DEV), ptr.get(), true, false);
    (void)rtsHostUnregister(ptr.get());

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_READONLY);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_MEM_MAP_DEV_PCIE_TH) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), true,
        false);
    (void)rtsHostUnregister(ptr.get());

    error =
        rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_IOMEMORY | RT_MEM_HOST_REGISTER_READONLY);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_IO_MAP_DEV) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), true, false);
    (void)rtsHostUnregister(ptr.get());

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_IOMEMORY | RT_MEM_HOST_REGISTER_MAPPED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(static_cast<UINT32>(HOST_IO_MAP_DEV), ptr.get(), true, false);
    (void)rtsHostUnregister(ptr.get());

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_READONLY | RT_MEM_HOST_REGISTER_MAPPED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_MEM_MAP_DEV_PCIE_TH) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), true,
        false);
    (void)rtsHostUnregister(ptr.get());

    error = rtHostRegisterV2(
        ptr.get(), sizeof(uint32_t),
        RT_MEM_HOST_REGISTER_MAPPED | RT_MEM_HOST_REGISTER_IOMEMORY | RT_MEM_HOST_REGISTER_READONLY);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_IO_MAP_DEV) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), true, false);
    (void)rtsHostUnregister(ptr.get());

    GlobalMockObject::verify();
}

TEST_F(RtMemRegisterApiTest, host_register_v2_forall_olddrv_withpin)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    MockPinRegister(false);

    MOCKER(halHostRegister).stubs().will(invoke(halHostRegister_capture_stub));
    MOCKER(halHostUnregisterEx).stubs().will(returnValue(DRV_ERROR_NONE));

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_IOMEMORY | RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(static_cast<UINT32>(HOST_IO_MAP_DEV), ptr.get(), true, true);
    (void)rtsHostUnregister(ptr.get());

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_READONLY | RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_MEM_MAP_DEV_PCIE_TH) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), true,
        true);
    (void)rtsHostUnregister(ptr.get());

    error = rtHostRegisterV2(
        ptr.get(), sizeof(uint32_t),
        RT_MEM_HOST_REGISTER_IOMEMORY | RT_MEM_HOST_REGISTER_READONLY | RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_IO_MAP_DEV) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), true, true);
    (void)rtsHostUnregister(ptr.get());

    error = rtHostRegisterV2(
        ptr.get(), sizeof(uint32_t),
        RT_MEM_HOST_REGISTER_MAPPED | RT_MEM_HOST_REGISTER_READONLY | RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_MEM_MAP_DEV_PCIE_TH) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), true,
        true);
    (void)rtsHostUnregister(ptr.get());

    error = rtHostRegisterV2(
        ptr.get(), sizeof(uint32_t),
        RT_MEM_HOST_REGISTER_MAPPED | RT_MEM_HOST_REGISTER_IOMEMORY | RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(static_cast<UINT32>(HOST_IO_MAP_DEV), ptr.get(), true, true);
    (void)rtsHostUnregister(ptr.get());

    error = rtHostRegisterV2(
        ptr.get(), sizeof(uint32_t),
        RT_MEM_HOST_REGISTER_MAPPED | RT_MEM_HOST_REGISTER_IOMEMORY | RT_MEM_HOST_REGISTER_READONLY |
            RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_IO_MAP_DEV) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), true, true);
    (void)rtsHostUnregister(ptr.get());

    GlobalMockObject::verify();
}

// switch on + rtsHostRegister HOST_IO_MAP_DEV RT_HOST_REGISTER_READONLY
TEST_F(RtMemRegisterApiTest, host_register_forall)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    void* devPtr = nullptr;

    MockPinRegister(true);
    MOCKER(halHostRegister).stubs().will(invoke(halHostRegister_capture_stub));
    MOCKER(halHostUnregister).stubs().will(returnValue(DRV_ERROR_NONE));

    error = rtsHostRegister(ptr.get(), sizeof(uint32_t), RT_HOST_REGISTER_IOMEMORY, &devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(static_cast<UINT32>(HOST_IO_MAP_DEV), ptr.get(), false, false);
    (void)rtsHostUnregister(ptr.get());

    error = rtsHostRegister(ptr.get(), sizeof(uint32_t), RT_HOST_REGISTER_READONLY, &devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_MEM_MAP_DEV_V2) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), false,
        false);
    (void)rtsHostUnregister(ptr.get());

    error = rtsHostRegister(
        ptr.get(), sizeof(uint32_t),
        static_cast<rtHostRegisterType>(RT_HOST_REGISTER_MAPPED | RT_HOST_REGISTER_READONLY), &devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_MEM_MAP_DEV_V2) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), false,
        false);
    (void)rtsHostUnregister(ptr.get());

    error = rtsHostRegister(
        ptr.get(), sizeof(uint32_t),
        static_cast<rtHostRegisterType>(RT_HOST_REGISTER_MAPPED | RT_HOST_REGISTER_IOMEMORY), &devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(static_cast<UINT32>(HOST_IO_MAP_DEV), ptr.get(), false, false);
    (void)rtsHostUnregister(ptr.get());

    error = rtsHostRegister(
        ptr.get(), sizeof(uint32_t),
        static_cast<rtHostRegisterType>(RT_HOST_REGISTER_READONLY | RT_HOST_REGISTER_IOMEMORY), &devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_IO_MAP_DEV) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), false, false);
    (void)rtsHostUnregister(ptr.get());

    error = rtsHostRegister(
        ptr.get(), sizeof(uint32_t),
        static_cast<rtHostRegisterType>(
            RT_HOST_REGISTER_MAPPED | RT_HOST_REGISTER_IOMEMORY | RT_HOST_REGISTER_READONLY),
        &devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_IO_MAP_DEV) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), false, false);
    (void)rtsHostUnregister(ptr.get());

    GlobalMockObject::verify();
}

TEST_F(RtMemRegisterApiTest, host_register_forall_olddrv)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    void* devPtr = nullptr;

    MockPinRegister(false);
    MOCKER(halHostRegister).stubs().will(invoke(halHostRegister_capture_stub));
    MOCKER(halHostUnregister).stubs().will(returnValue(DRV_ERROR_NONE));

    error = rtsHostRegister(ptr.get(), sizeof(uint32_t), RT_HOST_REGISTER_IOMEMORY, &devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(static_cast<UINT32>(HOST_IO_MAP_DEV), ptr.get(), true, false);
    (void)rtsHostUnregister(ptr.get());

    error = rtsHostRegister(ptr.get(), sizeof(uint32_t), RT_HOST_REGISTER_READONLY, &devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_MEM_MAP_DEV_PCIE_TH) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), true,
        false);
    (void)rtsHostUnregister(ptr.get());

    error = rtsHostRegister(
        ptr.get(), sizeof(uint32_t),
        static_cast<rtHostRegisterType>(RT_HOST_REGISTER_MAPPED | RT_HOST_REGISTER_READONLY), &devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_MEM_MAP_DEV_PCIE_TH) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), true,
        false);
    (void)rtsHostUnregister(ptr.get());

    error = rtsHostRegister(
        ptr.get(), sizeof(uint32_t),
        static_cast<rtHostRegisterType>(RT_HOST_REGISTER_MAPPED | RT_HOST_REGISTER_IOMEMORY), &devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(static_cast<UINT32>(HOST_IO_MAP_DEV), ptr.get(), true, false);
    (void)rtsHostUnregister(ptr.get());

    error = rtsHostRegister(
        ptr.get(), sizeof(uint32_t),
        static_cast<rtHostRegisterType>(RT_HOST_REGISTER_READONLY | RT_HOST_REGISTER_IOMEMORY), &devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_IO_MAP_DEV) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), true, false);
    (void)rtsHostUnregister(ptr.get());

    error = rtsHostRegister(
        ptr.get(), sizeof(uint32_t),
        static_cast<rtHostRegisterType>(
            RT_HOST_REGISTER_MAPPED | RT_HOST_REGISTER_IOMEMORY | RT_HOST_REGISTER_READONLY),
        &devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    checkRegisterStatus(
        static_cast<UINT32>(HOST_IO_MAP_DEV) | static_cast<UINT32>(MEM_REGISTER_READ_ONLY), ptr.get(), true, false);
    (void)rtsHostUnregister(ptr.get());

    GlobalMockObject::verify();
}
