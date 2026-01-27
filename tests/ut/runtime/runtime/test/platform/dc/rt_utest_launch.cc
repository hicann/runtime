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
#include "runtime/rt.h"
#include "runtime.hpp"
#include "device.hpp"

using namespace cce::runtime;
class TaskLaunchTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        GlobalMockObject::verify();
        std::cout<<"TaskLaunchTest test start start"<<std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout<<"TaskLaunchTest test start end"<<std::endl;
    }

    virtual void SetUp()
    {
        (void)rtSetDevice(0);
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
    }
};

TEST_F(TaskLaunchTest, nop_task_test_01)
{
    rtError_t error;
    rtStream_t stream;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device* dev = rtInstance->GetDevice(0, 0);
    int32_t version = dev->GetTschVersion();
    dev->SetTschVersion(TS_VERSION_NOP_TASK);
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtNopTask(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    dev->SetTschVersion(version);
}

TEST_F(TaskLaunchTest, ReduceAsync_errorTest)
{
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    rtError_t error;
    rtStream_t streamA;
    uint64_t buff_size = 100;

    error = rtStreamCreate(&streamA, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t *devMemSrc;
    uint32_t *devMem;

    error = rtMalloc((void **)&devMemSrc, buff_size, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc((void **)&devMem, buff_size, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtReduceAsync(devMem,
                          buff_size,
                          devMemSrc,
                          buff_size,
                          RT_MEMCPY_SDMA_AUTOMATIC_EQUAL,
                          RT_DATA_TYPE_FP32,
                          streamA);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtFree(devMem);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devMemSrc);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(streamA);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(TaskLaunchTest, rtMemAddress_2)
{
    rtError_t error = rtReserveMemAddress(nullptr, 0, 0, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    error = rtReleaseMemAddress(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtDrvMemHandle handVal;
    rtDrvMemProp_t prop = {};
    prop.mem_type = 1;
    prop.pg_type = 1;
    rtDrvMemHandle* handle = &handVal;
    error = rtMallocPhysical(handle, 0, &prop, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtFreePhysical(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtMapMem(nullptr, 0, 0, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtUnmapMem(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    rtMemLocation location;
    location.type = RT_MEMORY_LOC_HOST;
    location.id = 0;
 
    size_t size = 1024*1024;//1mb
    rtMemAccessDesc desc = {};
    desc.location = location;
    desc.flags = RT_MEM_ACCESS_FLAGS_READWRITE;

    error = rtMemSetAccess(nullptr, size, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    uint64_t shareableHandle;
    error = rtMemExportToShareableHandle(handle, RT_MEM_HANDLE_TYPE_NONE, 0, &shareableHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtMemImportFromShareableHandle(shareableHandle, 0, handle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    int pid[1024];
    error = rtMemSetPidToShareableHandle(shareableHandle, pid, 2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    size_t granularity;
    error = rtMemGetAllocationGranularity(&prop, RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MOCKER(halMemGetAllocationGranularity)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemGetAllocationGranularity(&prop, RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(TaskLaunchTest, rtMemAddress_01)
{
    rtError_t error = rtReserveMemAddress(nullptr, 0, 0, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtReleaseMemAddress(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtDrvMemHandle handVal;
    rtDrvMemProp_t prop = {};
    prop.mem_type = 1;
    prop.pg_type = 1;
    rtDrvMemHandle* handle = &handVal;
    error = rtMallocPhysical(handle, 0, &prop, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFreePhysical(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMapMem(nullptr, 0, 0, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtUnmapMem(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t shareableHandle;
    error = rtsMemExportToShareableHandle(handle, RT_MEM_HANDLE_TYPE_NONE, 0, &shareableHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsMemImportFromShareableHandle(shareableHandle, 0, handle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    int pid[1024];
    error = rtsMemSetPidToShareableHandle(shareableHandle, pid, 2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    size_t granularity;
    error = rtsMemGetAllocationGranularity(&prop, RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MOCKER(halMemGetAllocationGranularity)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemGetAllocationGranularity(&prop, RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

}

TEST_F(TaskLaunchTest, notify_create_with_flag)
{
    rtNotify_t notify = nullptr;
    rtError_t error;
    int32_t device_id = 0;

    uint32_t flag = 0x0U;

    error = rtNotifyCreateWithFlag(device_id, &notify, flag);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyDestroy(notify);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsNotifyCreate(&notify, flag);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsNotifyDestroy(notify);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtNotify_t notify2;
    error = rtNotifyCreateWithFlag(device_id, &notify2, flag);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyDestroy(notify2);
    EXPECT_EQ(error, RT_ERROR_NONE);
}