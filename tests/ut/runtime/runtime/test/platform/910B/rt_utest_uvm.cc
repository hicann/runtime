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
#include "uvm_callback.hpp"

using namespace testing;
using namespace cce::runtime;

class UvmApiTest : public testing::Test {
public:
protected:
    static void SetUpTestCase()
    {
        (void)rtSetDevice(0);
    }

    static void TearDownTestCase()
    {
        rtDeviceReset(0);
    }

    virtual void SetUp()
    {
        GlobalMockObject::verify();
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(UvmApiTest, memory_managed_advise)
{
    rtError_t error;
    uint64_t size = 128;
    void *ptr = NULL;
    Api* oldApi_ = Runtime::runtime_->api_;
    Profiler *profiler = new Profiler(oldApi_);
    profiler->Init();

    error = rtMemAllocManaged(&ptr, size, 0, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtMemManagedLocation MemManagedLocation;
    MemManagedLocation.id = 0;
    MemManagedLocation.type = rtMemLocationTypeDevice;

    error = rtMemManagedAdvise(ptr, 100, 1, MemManagedLocation);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MemManagedLocation.id = 0;
    MemManagedLocation.type = rtMemLocationTypeHostNuma;
    error = rtMemManagedAdvise(ptr, 100, 1, MemManagedLocation);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = profiler->apiProfileDecorator_->MemManagedAdvise(ptr, 100, 1, MemManagedLocation);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MOCKER(halMemManagedAdvise).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemManagedAdvise(ptr, 100, 1, MemManagedLocation);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtFree(ptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete profiler;
}

TEST_F(UvmApiTest, memory_managed_attribute)
{
    rtError_t error;
    void *ptr;
    uint64_t size = 128;
    void *data;
    size_t dataSize = 4;
    rtMemManagedRangeAttribute attribute = rtMemRangeAttributeReadMostly;
    Api *oldApi_ = Runtime::runtime_->api_;
    Profiler *profiler = new Profiler(oldApi_);
    profiler->Init();

    error = rtMemAllocManaged(&ptr, size, 0, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemManagedGetAttr(attribute, ptr, size, data, dataSize);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = profiler->apiProfileDecorator_->MemManagedGetAttr(attribute, ptr, size, data, dataSize);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(false));
    error = rtMemManagedGetAttr(attribute, ptr, size, data, dataSize);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MOCKER(halMemManagedRangeGetAttributes).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemManagedGetAttr(attribute, ptr, size, data, dataSize);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtFree(ptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete profiler;
}

TEST_F(UvmApiTest, memory_managed_attributes)
{
    rtError_t error;
    void *ptr;
    uint64_t size = 128;
    void *data;
    size_t dataSizes;
    size_t numAttributes = 2;
    rtMemManagedRangeAttribute attributes[2] = {rtMemRangeAttributeReadMostly, rtMemRangeAttributeAccessedBy};
    Api *oldApi_ = Runtime::runtime_->api_;
    Profiler *profiler = new Profiler(oldApi_);
    profiler->Init();

    error = rtMemAllocManaged(&ptr, size, 0, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemManagedGetAttrs(attributes, numAttributes, ptr, size, &data, &dataSizes);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = profiler->apiProfileDecorator_->MemManagedGetAttrs(attributes, numAttributes, ptr, size, &data, &dataSizes);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(false));
    error = rtMemManagedGetAttrs(attributes, numAttributes, ptr, size, &data, &dataSizes);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MOCKER(halMemManagedRangeGetAttributes).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemManagedGetAttrs(attributes, numAttributes, ptr, size, &data, &dataSizes);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtFree(ptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete profiler;
}

TEST_F(UvmApiTest, memory_managed_memset_async)
{
    rtError_t error;
    uint64_t size = 128;
    void *ptr = NULL;
    Api* oldApi_ = Runtime::runtime_->api_;
    Profiler *profiler = new Profiler(oldApi_);
    profiler->Init();

    error = rtMemAllocManaged(&ptr, size, 0, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    rtStream_t stream = nullptr;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemsetAsync(ptr, 32768, 'a', 32768, stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MOCKER(UvmCallback::IsUvmMem).stubs().will(returnValue(true));
    ApiImpl apiImpl_;
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::LaunchHostFunc).stubs().will(invoke(LaunchHostFuncNormalStub));
    error = rtsMemsetAsync(ptr, 32768, 'a', 32768, stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtFree(ptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete profiler;
}