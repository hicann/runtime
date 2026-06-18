/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "test/rt_utest_api.hpp"
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

TEST_F(UvmApiTest, memcpy_async_uvm_to_uvm) 
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    uint64_t count = 128;

    rtStream_t stream = nullptr;
    rtError_t err = rtStreamCreate(&stream, 0);
    EXPECT_EQ(err, RT_ERROR_NONE);

    error = rtMemAllocManaged(&hostPtr, count, 1, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemAllocManaged(&devPtr, count, 1, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(UvmCallback::IsUvmMem).stubs().will(returnValue(true));

    ApiImpl apiImpl_;
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::LaunchHostFunc).stubs().will(invoke(LaunchHostFuncNormalStub));

    error = rtMemcpyAsync(devPtr, count, hostPtr, count, RT_MEMCPY_HOST_TO_DEVICE, stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(UvmApiTest, rtMemManagedPrefetchAsync_abnormal_para)
{
    Api *api_= const_cast<Api *>(Runtime::runtime_->api_);
    Profiler profiler(nullptr);
    ApiDecorator *apiDecorator_ = new ApiDecorator(api_);
    ApiProfileDecorator *apiProfDecorator_ = new ApiProfileDecorator(api_, &profiler);
    ApiProfileLogDecorator *apiProfLogDecorator_ = new ApiProfileLogDecorator(api_, &profiler);

    constexpr size_t uvmSize = 32UL;
    uint8_t* devPtr = new uint8_t[uvmSize];
    rtMemManagedLocation location = { rtMemLocationTypeInvalid, 0 };
    uint8_t flags = 0;
    rtStream_t stream = nullptr;
    rtError_t err = rtStreamCreate(&stream, 0);
    EXPECT_EQ(err, RT_ERROR_NONE);

    err = rtMemManagedPrefetchAsync(devPtr, uvmSize, location, flags, stream);
    EXPECT_EQ(err, ACL_ERROR_RT_PARAM_INVALID);

    Stream* stm = static_cast<Stream*>(stream);
    err = apiDecorator_->MemManagedPrefetchAsync(devPtr, uvmSize, location, flags, stm);
    EXPECT_EQ(err, RT_ERROR_INVALID_VALUE);

    err = apiProfDecorator_->MemManagedPrefetchAsync(devPtr, uvmSize, location, flags, stm);
    EXPECT_EQ(err, RT_ERROR_INVALID_VALUE);

    err = apiProfLogDecorator_->MemManagedPrefetchAsync(devPtr, uvmSize, location, flags, stm);
    EXPECT_EQ(err, RT_ERROR_INVALID_VALUE);

    err = rtMemManagedPrefetchAsync(devPtr, uvmSize, location, 1U, stream);
    EXPECT_EQ(err, ACL_ERROR_RT_PARAM_INVALID);

    err = rtMemManagedPrefetchAsync(nullptr, uvmSize, location, flags, stream);
    EXPECT_EQ(err, ACL_ERROR_RT_PARAM_INVALID);

    err = rtMemManagedPrefetchAsync(devPtr, 0UL, location, flags, stream);
    EXPECT_EQ(err, ACL_ERROR_RT_PARAM_INVALID);

    ApiImpl apiImpl_;
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::LaunchHostFunc).stubs().will(invoke(LaunchHostFuncNormalStub));
    flags = 0;
    location.type = rtMemLocationTypeHost;
    err = rtMemManagedPrefetchAsync(devPtr, uvmSize, location, flags, stream);
    EXPECT_EQ(err, ACL_RT_SUCCESS);
    delete[] devPtr;
    delete apiDecorator_;
    delete apiProfDecorator_;
    delete apiProfLogDecorator_;
}

TEST_F(UvmApiTest, ApiImpl_MemManagedPrefetchAsync)
{
    ApiImpl apiImpl_;
    constexpr size_t uvmSize = 32UL;
    uint8_t* devPtr = new uint8_t[uvmSize];
    rtMemManagedLocation location = { rtMemLocationTypeInvalid, 0 };
    uint32_t flags = 1U;
    rtStream_t stream = nullptr;
    rtError_t err = rtStreamCreate(&stream, 0);
    EXPECT_EQ(err, RT_ERROR_NONE);
    Stream* stm = static_cast<Stream*>(stream);

    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::LaunchHostFunc).stubs().will(invoke(LaunchHostFuncNormalStub));
    err = apiImpl_.MemManagedPrefetchAsync(devPtr, uvmSize, location, flags, stm);
    EXPECT_EQ(err, RT_ERROR_INVALID_VALUE);

    flags = 0U;
    err = apiImpl_.MemManagedPrefetchAsync(nullptr, uvmSize, location, flags, stm);
    EXPECT_EQ(err, RT_ERROR_INVALID_VALUE);

    location.type = rtMemLocationTypeHostNumaCurrent;
    err = apiImpl_.MemManagedPrefetchAsync(devPtr, uvmSize, location, flags, stm);
    EXPECT_EQ(err, RT_ERROR_NONE);

    location.type = rtMemLocationTypeHost;
    err = apiImpl_.MemManagedPrefetchAsync(devPtr, uvmSize, location, flags, stm);
    EXPECT_EQ(err, RT_ERROR_NONE);

    MOCKER(halMemManagedPrefetch).stubs().will(invoke(halMemManagedPrefetchFailed));
    err = apiImpl_.MemManagedPrefetchAsync(devPtr, uvmSize, location, flags, stm);
    EXPECT_EQ(err, RT_ERROR_NONE);

    location.type = rtMemLocationTypeHostNumaCurrent;
    MOCKER(halGetCurrentThreadNumaNode).stubs().will(invoke(halGetCurrentThreadNumaNodeFailed));
    err = apiImpl_.MemManagedPrefetchAsync(devPtr, uvmSize, location, flags, stm);
    EXPECT_EQ(err, RT_ERROR_DRV_ERR);

    delete[] devPtr;
}

TEST_F(UvmApiTest, ApiImpl_MemManagedPrefetchAsync_HostLaunchFail)
{
    ApiImpl apiImpl_;
    constexpr size_t uvmSize = 32UL;
    uint8_t* devPtr = new uint8_t[uvmSize];
    rtMemManagedLocation location = { rtMemLocationTypeHost, 0 };
    uint32_t flags = 0U;
    rtStream_t stream = nullptr;
    rtError_t err = rtStreamCreate(&stream, 0);
    EXPECT_EQ(err, RT_ERROR_NONE);
    Stream* stm = static_cast<Stream*>(stream);
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::LaunchHostFunc).stubs().will(invoke(LaunchHostFuncFailStub));
    err = apiImpl_.MemManagedPrefetchAsync(devPtr, uvmSize, location, flags, stm);
    EXPECT_EQ(err, RT_ERROR_FEATURE_NOT_SUPPORT);
    delete[] devPtr;
}

TEST_F(UvmApiTest, rtMemManagedPrefetchBatchAsync_Decorator)
{
    Api *api_= const_cast<Api *>(Runtime::runtime_->api_);
    Profiler profiler(nullptr);
    ApiDecorator *apiDecorator_ = new ApiDecorator(api_);
    ApiProfileDecorator *apiProfDecorator_ = new ApiProfileDecorator(api_, &profiler);
    ApiProfileLogDecorator *apiProfLogDecorator_ = new ApiProfileLogDecorator(api_, &profiler);

    constexpr size_t numUvmPtrs = 3UL;
    constexpr size_t numPrefetchLocs = 2UL;
    rtMemManagedLocation prefetchLocsArr[numPrefetchLocs];
    size_t prefetchLocIdxsArr[numPrefetchLocs];
    void* devPtrsArr[numUvmPtrs] = { nullptr };
    size_t sizesArr[numUvmPtrs] = { 0UL };
    for (uint32_t index = 0; index < numPrefetchLocs; index++) {
        prefetchLocsArr[index].id = 0;
        prefetchLocsArr[index].type = rtMemLocationTypeInvalid;
    }
    uint64_t flags = 0UL;
    rtStream_t stream = nullptr;
    rtError_t err = rtStreamCreate(&stream, 0);
    EXPECT_EQ(err, RT_ERROR_NONE);
    err = rtMemManagedPrefetchBatchAsync((const void**)devPtrsArr, sizesArr, numUvmPtrs, prefetchLocsArr,
        prefetchLocIdxsArr, numPrefetchLocs, flags, stream);
    EXPECT_EQ(err, ACL_ERROR_RT_PARAM_INVALID);

    flags = 1UL;
    err = rtMemManagedPrefetchBatchAsync((const void**)devPtrsArr, sizesArr, numUvmPtrs, prefetchLocsArr,
        prefetchLocIdxsArr, numPrefetchLocs, flags, stream);
    EXPECT_EQ(err, ACL_ERROR_RT_PARAM_INVALID);

    Stream* stm = static_cast<Stream*>(stream);
    err = apiDecorator_->MemManagedPrefetchBatchAsync((const void**)devPtrsArr, sizesArr, numUvmPtrs, prefetchLocsArr,
        prefetchLocIdxsArr, numPrefetchLocs, flags, stm);
    EXPECT_EQ(err, RT_ERROR_INVALID_VALUE);

    err = apiProfDecorator_->MemManagedPrefetchBatchAsync((const void**)devPtrsArr, sizesArr, numUvmPtrs, prefetchLocsArr,
        prefetchLocIdxsArr, numPrefetchLocs, flags, stm);
    EXPECT_EQ(err, RT_ERROR_INVALID_VALUE);

    err = apiProfLogDecorator_->MemManagedPrefetchBatchAsync((const void**)devPtrsArr, sizesArr, numUvmPtrs, prefetchLocsArr,
        prefetchLocIdxsArr, numPrefetchLocs, flags, stm);
    EXPECT_EQ(err, RT_ERROR_INVALID_VALUE);

    delete apiDecorator_;
    delete apiProfDecorator_;
    delete apiProfLogDecorator_;
}

TEST_F(UvmApiTest, rtMemManagedPrefetchBatchAsync_abnormal_para)
{
    constexpr size_t numUvmPtrs = 3UL;
    void* devPtrsArr[numUvmPtrs] = { (void*)0x10, (void*)0x20, (void*)0x30 };
    size_t sizesArr[numUvmPtrs] = { 0UL };

    rtStream_t stream = nullptr;
    rtError_t err = rtStreamCreate(&stream, 0);
    EXPECT_EQ(err, RT_ERROR_NONE);

    ApiImpl apiImpl_;
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::LaunchHostFunc).stubs().will(invoke(LaunchHostFuncNormalStub));
    constexpr size_t numPrefetchLocs = 2;
    rtMemManagedLocation prefetchLocsArr[numPrefetchLocs];
    size_t prefetchLocIdxsArr[numPrefetchLocs] = { 0UL, 2UL }; // prefetch uvm 0-1 to phy loc 1, uvm 2 to phy loc 2
    uint64_t flags = 0;
    for (uint32_t index = 0; index < numPrefetchLocs; index++) {
        prefetchLocsArr[index].id = 0;
        prefetchLocsArr[index].type = rtMemLocationTypeHost;
    }

    err = rtMemManagedPrefetchBatchAsync(nullptr, sizesArr, numUvmPtrs, prefetchLocsArr,
        prefetchLocIdxsArr, numPrefetchLocs, flags, stream);
    EXPECT_EQ(err, ACL_ERROR_RT_PARAM_INVALID);
    err = rtMemManagedPrefetchBatchAsync((const void**)devPtrsArr, nullptr, numUvmPtrs, prefetchLocsArr,
        prefetchLocIdxsArr, numPrefetchLocs, flags, stream);
    EXPECT_EQ(err, ACL_ERROR_RT_PARAM_INVALID);
    err = rtMemManagedPrefetchBatchAsync((const void**)devPtrsArr, sizesArr, numUvmPtrs, nullptr,
        prefetchLocIdxsArr, numPrefetchLocs, flags, stream);
    EXPECT_EQ(err, ACL_ERROR_RT_PARAM_INVALID);
    err = rtMemManagedPrefetchBatchAsync((const void**)devPtrsArr, sizesArr, numUvmPtrs, prefetchLocsArr,
        nullptr, numPrefetchLocs, flags, stream);
    EXPECT_EQ(err, ACL_ERROR_RT_PARAM_INVALID);
    err = rtMemManagedPrefetchBatchAsync((const void**)devPtrsArr, 0UL, numUvmPtrs, prefetchLocsArr,
        prefetchLocIdxsArr, numPrefetchLocs, flags, stream);
    EXPECT_EQ(err, ACL_ERROR_RT_PARAM_INVALID);
    err = rtMemManagedPrefetchBatchAsync((const void**)devPtrsArr, sizesArr, 0UL, prefetchLocsArr,
        prefetchLocIdxsArr, numPrefetchLocs, flags, stream);
    EXPECT_EQ(err, ACL_ERROR_RT_PARAM_INVALID);
    err = rtMemManagedPrefetchBatchAsync((const void**)devPtrsArr, sizesArr, 1, prefetchLocsArr,
        prefetchLocIdxsArr, numPrefetchLocs, flags, stream);
    EXPECT_EQ(err, ACL_ERROR_RT_PARAM_INVALID);
    err = rtMemManagedPrefetchBatchAsync((const void**)devPtrsArr, sizesArr, numUvmPtrs, prefetchLocsArr,
        prefetchLocIdxsArr, 1, flags, stream);
    EXPECT_EQ(err, ACL_RT_SUCCESS);
    devPtrsArr[0] = nullptr;
    err = rtMemManagedPrefetchBatchAsync((const void**)devPtrsArr, sizesArr, numUvmPtrs, prefetchLocsArr,
        prefetchLocIdxsArr, numPrefetchLocs, flags, stream);
    EXPECT_EQ(err, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UvmApiTest, ApiImpl_MemManagedPrefetchBatchAsync)
{
    ApiImpl apiImpl_;
    constexpr size_t numUvmPtrs = 3UL;
    void* devPtrsArr[numUvmPtrs] = { nullptr };
    size_t sizesArr[numUvmPtrs] = { 0UL };
    constexpr size_t numPrefetchLocs = 2UL;
    size_t prefetchLocIdxsArr[numPrefetchLocs] = { 0UL, 2UL }; // prefetch uvm 0-1 to phy loc 1, uvm 2 to phy loc 2
    rtMemManagedLocation prefetchLocsArr[numPrefetchLocs];

    for (uint32_t index = 0; index < numPrefetchLocs; index++) {
        prefetchLocsArr[index].id = 0;
        prefetchLocsArr[index].type = rtMemLocationTypeInvalid;
    }
    rtStream_t stream = nullptr;
    rtError_t err = rtStreamCreate(&stream, 0);
    EXPECT_EQ(err, RT_ERROR_NONE);
    Stream* stm = static_cast<Stream*>(stream);
    uint64_t flags = 1;
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::LaunchHostFunc).stubs().will(invoke(LaunchHostFuncNormalStub));
    err = apiImpl_.MemManagedPrefetchBatchAsync((const void**)devPtrsArr, sizesArr, numUvmPtrs, prefetchLocsArr,
        prefetchLocIdxsArr, numPrefetchLocs, flags, stm);
    EXPECT_EQ(err, RT_ERROR_INVALID_VALUE);

    flags = 0;
    for (uint32_t index = 0; index < numPrefetchLocs; index++) {
        prefetchLocsArr[index].id = 0;
        prefetchLocsArr[index].type = rtMemLocationTypeHost;
    }
    err = apiImpl_.MemManagedPrefetchBatchAsync((const void**)devPtrsArr, sizesArr, numUvmPtrs, prefetchLocsArr,
        prefetchLocIdxsArr, numPrefetchLocs, flags, stm);
    EXPECT_EQ(err, RT_ERROR_NONE);

    MOCKER(halMemManagedPrefetchBatch).stubs().will(invoke(halMemManagedPrefetchBatchFailed));
    err = apiImpl_.MemManagedPrefetchBatchAsync((const void**)devPtrsArr, sizesArr, numUvmPtrs, prefetchLocsArr,
        prefetchLocIdxsArr, numPrefetchLocs, flags, stm);
    EXPECT_EQ(err, RT_ERROR_NONE);
}


TEST_F(UvmApiTest, MemManagedPrefetchAsync_DeviceLocation)
{
    Api *api_ = const_cast<Api *>(Runtime::runtime_->api_);
    Profiler profiler(nullptr);
    ApiDecorator *apiDecorator_ = new ApiDecorator(api_);
    ApiImpl *innerImpl = static_cast<ApiImpl *>(static_cast<ApiDecorator *>(api_)->impl_);

    constexpr size_t uvmSize = 32UL;
    uint8_t *devPtr = new uint8_t[uvmSize];
    rtMemManagedLocation location = {rtMemLocationTypeDevice, 0};
    uint32_t flags = 0U;
    rtStream_t stream = nullptr;
    rtError_t err = rtStreamCreate(&stream, 0);
    EXPECT_EQ(err, RT_ERROR_NONE);
    Stream *stm = static_cast<Stream *>(stream);

    MOCKER_CPP_VIRTUAL((*innerImpl), &ApiImpl::LaunchHostFunc).stubs().will(invoke(LaunchHostFuncNormalStub));
    err = apiDecorator_->MemManagedPrefetchAsync(devPtr, uvmSize, location, flags, stm);
    EXPECT_EQ(err, RT_ERROR_NONE);

    delete[] devPtr;
    delete apiDecorator_;
}

TEST_F(UvmApiTest, MemManagedPrefetchBatchAsync_DeviceLocation)
{
    Api *api_ = const_cast<Api *>(Runtime::runtime_->api_);
    Profiler profiler(nullptr);
    ApiDecorator *apiDecorator_ = new ApiDecorator(api_);
    ApiImpl *innerImpl = static_cast<ApiImpl *>(static_cast<ApiDecorator *>(api_)->impl_);

    constexpr size_t numUvmPtrs = 3UL;
    constexpr size_t numPrefetchLocs = 1UL;
    void *devPtrsArr[numUvmPtrs] = {(void *)0x10, (void *)0x20, (void *)0x30};
    size_t sizesArr[numUvmPtrs] = {32UL, 32UL, 32UL};
    rtMemManagedLocation prefetchLocsArr[numPrefetchLocs];
    size_t prefetchLocIdxsArr[numPrefetchLocs] = {0UL};
    prefetchLocsArr[0].id = 0;
    prefetchLocsArr[0].type = rtMemLocationTypeDevice;
    uint64_t flags = 0UL;
    rtStream_t stream = nullptr;
    rtError_t err = rtStreamCreate(&stream, 0);
    EXPECT_EQ(err, RT_ERROR_NONE);
    Stream *stm = static_cast<Stream *>(stream);

    MOCKER_CPP_VIRTUAL((*innerImpl), &ApiImpl::LaunchHostFunc).stubs().will(invoke(LaunchHostFuncNormalStub));
    err = apiDecorator_->MemManagedPrefetchBatchAsync((const void **)devPtrsArr, sizesArr, numUvmPtrs,
        prefetchLocsArr, prefetchLocIdxsArr, numPrefetchLocs, flags, stm);
    EXPECT_EQ(err, RT_ERROR_NONE);

    delete apiDecorator_;
}

TEST_F(UvmApiTest, ApiImpl_MemManagedPrefetchBatchAsync_HostLaunchFail)
{
    rtStream_t stream = nullptr;
    constexpr size_t numPrefetchLocs = 2UL;
    constexpr size_t numUvmPtrs = 3UL;
    void* devPtrsArr[numUvmPtrs] = { nullptr };
    size_t sizesArr[numUvmPtrs] = { 0 };
    rtMemManagedLocation prefetchLocsArr[numPrefetchLocs];
    size_t prefetchLocIdxsArr[numPrefetchLocs];
    for (uint32_t index = 0; index < numPrefetchLocs; index++) {
        prefetchLocsArr[index].id = 0;
        prefetchLocsArr[index].type = rtMemLocationTypeHost;
    }
    rtError_t err = rtStreamCreate(&stream, 0);
    EXPECT_EQ(err, RT_ERROR_NONE);
    Stream* stm = static_cast<Stream*>(stream);
    ApiImpl apiImpl_;
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::LaunchHostFunc).stubs().will(invoke(LaunchHostFuncFailStub));
    uint64_t flags = 0;
    err = apiImpl_.MemManagedPrefetchBatchAsync((const void**)devPtrsArr, sizesArr, numUvmPtrs, prefetchLocsArr,
        prefetchLocIdxsArr, numPrefetchLocs, flags, stm);
    EXPECT_EQ(err, RT_ERROR_FEATURE_NOT_SUPPORT);
}
