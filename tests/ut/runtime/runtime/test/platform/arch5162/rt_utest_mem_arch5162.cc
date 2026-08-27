/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "driver/ascend_hal.h"
#include "npu_driver.hpp"
#include "runtime/rt.h"
#include "rt_external_mem.h"
#include "api_impl.hpp"
#include "base_info.hpp"
#include "rt_error_codes.h"

using namespace cce::runtime;

class Arch5162MemTest : public testing::Test {
protected:
    static void SetUpTestCase() { std::cout << "Arch5162MemTest test start" << std::endl; }

    static void TearDownTestCase() { std::cout << "Arch5162MemTest test end" << std::endl; }

    virtual void SetUp() {}

    virtual void TearDown() { GlobalMockObject::verify(); }
};

TEST_F(Arch5162MemTest, DevMemAllocCached_Success)
{
    NpuDriver drv;
    void* devPtr = nullptr;
    rtError_t error = drv.DevMemAllocCached(&devPtr, 1024, RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(devPtr, nullptr);

    error = drv.DevMemFree(devPtr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(Arch5162MemTest, DevMemAllocCached_NonDefaultPolicy_NotSupport)
{
    NpuDriver drv;
    void* devPtr = nullptr;
    rtError_t error = drv.DevMemAllocCached(&devPtr, 1024, RT_MEMORY_POLICY_HUGE_PAGE_ONLY, 0);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    error = drv.DevMemAllocCached(&devPtr, 1024, (rtMemType_t)0, 0);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(Arch5162MemTest, DevMemAllocCached_HalMemAllocFail)
{
    NpuDriver drv;
    void* devPtr = nullptr;
    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    rtError_t error = drv.DevMemAllocCached(&devPtr, 1024, RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY, 0);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(Arch5162MemTest, DevMemFlushCache_Success)
{
    NpuDriver drv;
    rtError_t error = drv.DevMemFlushCache(0x1000, 256);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(Arch5162MemTest, DevMemInvalidCache_Success)
{
    NpuDriver drv;
    rtError_t error = drv.DevMemInvalidCache(0x1000, 256);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(Arch5162MemTest, FlushCache_BaseZero_InvalidValue)
{
    ApiImpl apiImpl;
    rtError_t error = apiImpl.FlushCache(0U, 256U);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(Arch5162MemTest, FlushCache_LenZero_InvalidValue)
{
    ApiImpl apiImpl;
    rtError_t error = apiImpl.FlushCache(0x1000U, 0U);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(Arch5162MemTest, InvalidCache_BaseZero_InvalidValue)
{
    ApiImpl apiImpl;
    rtError_t error = apiImpl.InvalidCache(0U, 256U);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(Arch5162MemTest, InvalidCache_LenZero_InvalidValue)
{
    ApiImpl apiImpl;
    rtError_t error = apiImpl.InvalidCache(0x1000U, 0U);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(Arch5162MemTest, DevMallocCached_NullPtr_InvalidValue)
{
    ApiImpl apiImpl;
    rtError_t error = apiImpl.DevMallocCached(nullptr, 1024, RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY, 0);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(Arch5162MemTest, DevMallocCached_SizeTooLarge_InvalidValue)
{
    ApiImpl apiImpl;
    void* devPtr = nullptr;
    rtError_t error = apiImpl.DevMallocCached(&devPtr, MAX_ALLOC_SIZE + 1, RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY, 0);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(Arch5162MemTest, CommonCopySetApiImpls_UseRealImplementations)
{
    ApiImpl apiImpl;

    EXPECT_EQ(apiImpl.MemCopySync(nullptr, 0U, nullptr, 0U, RT_MEMCPY_HOST_TO_HOST), RT_ERROR_CONTEXT_NULL);
    EXPECT_EQ(
        apiImpl.MemcpyAsync(nullptr, 0U, nullptr, 0U, RT_MEMCPY_HOST_TO_HOST, nullptr, nullptr, nullptr, true, nullptr),
        RT_ERROR_CONTEXT_NULL);
    EXPECT_EQ(apiImpl.MemSetSync(nullptr, 0U, 0U, 0U), RT_ERROR_CONTEXT_NULL);
    EXPECT_EQ(apiImpl.MemsetAsync(nullptr, 0U, 0U, 0U, nullptr), RT_ERROR_CONTEXT_NULL);
}

TEST_F(Arch5162MemTest, UnsupportedHostMemoryApiImpls_ReturnNotSupport)
{
    ApiImpl apiImpl;

    EXPECT_EQ(apiImpl.HostMalloc(nullptr, 0U, 0U), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.HostMallocWithCfg(nullptr, 0U, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.HostFree(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(
        apiImpl.HostRegister(nullptr, 0U, static_cast<rtHostRegisterType>(0), nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.HostRegisterV2(nullptr, 0U, 0U), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.HostUnregister(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.HostGetDevicePointer(nullptr, nullptr, 0U), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.HostMemMapCapabilities(0U, static_cast<rtHacType>(0), nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.ManagedMemAlloc(nullptr, 0U, 0U, 0U), RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(Arch5162MemTest, UnsupportedMemoryCopyApiImpls_ReturnNotSupport)
{
    ApiImpl apiImpl;

    EXPECT_EQ(apiImpl.MemCopySyncEx(nullptr, 0U, nullptr, 0U, RT_MEMCPY_HOST_TO_HOST), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(
        apiImpl.RtsMemcpyAsync(nullptr, 0U, nullptr, 0U, static_cast<rtMemcpyKind>(0), nullptr, nullptr),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(
        apiImpl.RtsMemcpy(nullptr, 0U, nullptr, 0U, static_cast<rtMemcpyKind>(0), nullptr),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(
        apiImpl.SetMemcpyDesc(nullptr, nullptr, nullptr, 0U, static_cast<rtMemcpyKind>(0), nullptr),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(
        apiImpl.MemcpyAsyncWithDesc(nullptr, nullptr, static_cast<rtMemcpyKind>(0), nullptr),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.MemcpyAsyncPtr(nullptr, 0U, 0U, nullptr, nullptr, false), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(
        apiImpl.ReduceAsync(
            nullptr, nullptr, 0U, static_cast<rtRecudeKind_t>(0), static_cast<rtDataType_t>(0), nullptr, nullptr),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(
        apiImpl.ReduceAsyncV2(
            nullptr, nullptr, 0U, static_cast<rtRecudeKind_t>(0), static_cast<rtDataType_t>(0), nullptr, nullptr),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(
        apiImpl.MemCopy2DSync(nullptr, 0U, nullptr, 0U, 0U, 0U, RT_MEMCPY_HOST_TO_HOST, static_cast<rtMemcpyKind>(0)),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(
        apiImpl.MemCopy2DAsync(
            nullptr, 0U, nullptr, 0U, 0U, 0U, nullptr, RT_MEMCPY_HOST_TO_HOST, static_cast<rtMemcpyKind>(0)),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(
        apiImpl.MemcpyHostTask(nullptr, 0U, nullptr, 0U, RT_MEMCPY_HOST_TO_HOST, nullptr),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(
        apiImpl.MemcpyBatch(nullptr, nullptr, nullptr, 0U, nullptr, nullptr, 0U, nullptr),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(
        apiImpl.MemcpyBatchAsync(nullptr, nullptr, nullptr, nullptr, 0U, nullptr, nullptr, 0U, nullptr, nullptr),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.MemWaitValue(nullptr, 0U, 0U, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(Arch5162MemTest, UnsupportedVirtualMemoryApiImpls_ReturnNotSupport)
{
    ApiImpl apiImpl;

    EXPECT_EQ(
        apiImpl.DevMalloc(nullptr, 0U, static_cast<rtMallocPolicy>(0), static_cast<rtMallocAdvise>(0), nullptr),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.ReserveMemAddress(nullptr, 0U, 0U, nullptr, 0U), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.ReleaseMemAddress(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.MallocPhysical(nullptr, 0U, nullptr, 0U), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.FreePhysical(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.MapMem(nullptr, 0U, 0U, nullptr, 0U), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.UnmapMem(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.MemSetAccess(nullptr, 0U, nullptr, 0U), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.MemGetAccess(nullptr, nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(
        apiImpl.GetAllocationGranularity(nullptr, static_cast<rtDrvMemGranularityOptions>(0), nullptr),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(
        apiImpl.MemReserveAddress(nullptr, 0U, static_cast<rtMallocPolicy>(0), nullptr, nullptr),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(
        apiImpl.MemMallocPhysical(nullptr, 0U, static_cast<rtMallocPolicy>(0), nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(Arch5162MemTest, UnsupportedSharedAndQueryMemoryApiImpls_ReturnNotSupport)
{
    ApiImpl apiImpl;

    EXPECT_EQ(
        apiImpl.ExportToShareableHandle(nullptr, static_cast<rtDrvMemHandleType>(0), 0U, nullptr),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(
        apiImpl.ExportToShareableHandleV2(nullptr, static_cast<rtMemSharedHandleType>(0), 0U, nullptr),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.ImportFromShareableHandle(0U, 0, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(
        apiImpl.ImportFromShareableHandleV2(nullptr, static_cast<rtMemSharedHandleType>(0), 0U, 0, nullptr),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.SetPidToShareableHandle(0U, nullptr, 0U), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(
        apiImpl.SetPidToShareableHandleV2(nullptr, static_cast<rtMemSharedHandleType>(0), nullptr, 0U),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.CheckMemType(nullptr, 0U, 0U, nullptr, 0U), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.GetMemUsageInfo(0U, nullptr, 0U, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.MemGetInfoEx(static_cast<rtMemInfoType_t>(0), nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.MemPrefetchToDevice(nullptr, 0U, 0), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.MemRetainAllocationHandle(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.MemGetAllocationPropertiesFromHandle(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.MemGetAddressRange(nullptr, nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.MemMapSelectedLink(nullptr, 0U, nullptr, 0U), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.MemMapSetLink(nullptr, static_cast<rtMemLinkType>(0)), RT_ERROR_FEATURE_NOT_SUPPORT);
}

class Arch5162RtMemTest : public testing::Test {
protected:
    virtual void SetUp() {}

    virtual void TearDown() { GlobalMockObject::verify(); }
};

TEST_F(Arch5162RtMemTest, rtMallocCached_NullPtr_InvalidValue)
{
    rtError_t error = rtMallocCached(nullptr, 1024, RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY, DEFAULT_MODULEID);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(Arch5162RtMemTest, rtMallocCached_SizeZero_InvalidValue)
{
    void* devPtr = nullptr;
    rtError_t error = rtMallocCached(&devPtr, 0, RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY, DEFAULT_MODULEID);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(Arch5162RtMemTest, rtMallocCached_NoContext_ContextNull)
{
    void* devPtr = nullptr;
    rtError_t error = rtMallocCached(&devPtr, 1024, RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY, DEFAULT_MODULEID);
    EXPECT_EQ(error, ACL_ERROR_RT_CONTEXT_NULL);
}

TEST_F(Arch5162RtMemTest, DevMallocCached_NoContext_ContextNull)
{
    ApiImpl apiImpl;
    void* devPtr = nullptr;
    rtError_t error = apiImpl.DevMallocCached(&devPtr, 1024, RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY, 0);
    EXPECT_EQ(error, RT_ERROR_CONTEXT_NULL);
}

TEST_F(Arch5162RtMemTest, rtMallocCached_NonDefaultPolicy_NoContext_ContextNull)
{
    void* devPtr = nullptr;
    rtError_t error = rtMallocCached(&devPtr, 1024, RT_MEMORY_POLICY_HUGE_PAGE_ONLY, DEFAULT_MODULEID);
    EXPECT_EQ(error, ACL_ERROR_RT_CONTEXT_NULL);
}

TEST_F(Arch5162RtMemTest, rtFlushCache_BaseZero_InvalidValue)
{
    rtError_t error = rtFlushCache(nullptr, 256);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(Arch5162RtMemTest, rtFlushCache_LenZero_InvalidValue)
{
    uint64_t base = 0x1000U;
    rtError_t error = rtFlushCache(RtValueToPtr<void*>(base), 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(Arch5162RtMemTest, rtFlushCache_NoContext_ContextNull)
{
    uint64_t base = 0x1000U;
    rtError_t error = rtFlushCache(RtValueToPtr<void*>(base), 256);
    EXPECT_EQ(error, ACL_ERROR_RT_CONTEXT_NULL);
}

TEST_F(Arch5162RtMemTest, rtInvalidCache_BaseZero_InvalidValue)
{
    rtError_t error = rtInvalidCache(nullptr, 256);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(Arch5162RtMemTest, rtInvalidCache_LenZero_InvalidValue)
{
    uint64_t base = 0x1000U;
    rtError_t error = rtInvalidCache(RtValueToPtr<void*>(base), 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(Arch5162RtMemTest, rtInvalidCache_NoContext_ContextNull)
{
    uint64_t base = 0x1000U;
    rtError_t error = rtInvalidCache(RtValueToPtr<void*>(base), 256);
    EXPECT_EQ(error, ACL_ERROR_RT_CONTEXT_NULL);
}
