/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software; you can redistribute it and/or modify it under the terms and conditions of
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
#include "thread_local_container.hpp"
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

class Arch5162RtMemTest : public testing::Test {
protected:
    static void SetUpTestCase() { GlobalContainer::SetRtChipType(CHIP_5162A); }

    static void TearDownTestCase() {}

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
