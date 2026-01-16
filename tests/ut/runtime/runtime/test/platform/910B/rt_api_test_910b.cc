/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "../../rt_utest_api.hpp"

class ApiTest910b : public testing::Test
{
public:
    static rtStream_t stream_;
    static rtEvent_t  event_;
    static void      *binHandle_;
    static char       function_;
    static uint32_t   binary_[32];
    static Driver*    driver_;
    static rtChipType_t originType_;
protected:
    static void SetUpTestCase()
    {
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        (void)rtSetDevice(0);
        (void)rtSetTSDevice(1);
        rtError_t error1 = rtStreamCreate(&stream_, 0);
        rtError_t error2 = rtEventCreate(&event_);

        for (uint32_t i = 0; i < sizeof(binary_) / sizeof(uint32_t); i++)
        {
            binary_[i] = i;
        }

        rtDevBinary_t devBin;
        devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
        devBin.version = 1;
        devBin.length = sizeof(binary_);
        devBin.data = binary_;
        rtError_t error3 = rtDevBinaryRegister(&devBin, &binHandle_);

        rtError_t error4 = rtFunctionRegister(binHandle_, &function_, "foo", NULL, 0);
        delete rawDevice;

        std::cout<<"api test 910b start:"<<error1<<", "<<error2<<", "<<error3<<", "<<error4<<std::endl;
    }

    static void TearDownTestCase()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtError_t error1 = rtStreamDestroy(stream_);
        rtError_t error2 = rtEventDestroy(event_);
        rtError_t error3 = rtDevBinaryUnRegister(binHandle_);
        std::cout<<"api test start end : "<<error1<<", "<<error2<<", "<<error3<<std::endl;
        GlobalMockObject::verify();
        rtDeviceReset(0);
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        (void)rtSetSocVersion("");
    }

    virtual void SetUp()
    {
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};
rtChipType_t ApiTest910b::originType_;
rtStream_t ApiTest910b::stream_ = NULL;
rtEvent_t ApiTest910b::event_ = NULL;
void* ApiTest910b::binHandle_ = nullptr;
char  ApiTest910b::function_ = 'a';
uint32_t ApiTest910b::binary_[32] = {};
Driver* ApiTest910b::driver_ = NULL;

TEST_F(ApiTest910b, memcpy_host_to_device_00)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    size_t free;
    size_t total;
    rtMemInfo_t memInfo;

    error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpy(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halMemGetInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));

    error = rtMemGetInfo(&free, &total);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemGetInfoByType(0, RT_MEM_INFO_TYPE_HBM_SIZE, &memInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemGetInfoEx(RT_MEMORYINFO_DDR, &free, &total);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemGetInfo(RT_MEMORYINFO_DDR, &free, &total);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, memcpy_host_to_device_auto)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    size_t free;
    size_t total;
    rtMemInfo_t memInfo;

    error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpy(devPtr, 64, hostPtr, 64, RT_MEMCPY_DEFAULT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halMemGetInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));

    error = rtMemGetInfo(&free, &total);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemGetInfoByType(0, RT_MEM_INFO_TYPE_HBM_P2P_SIZE, &memInfo);

    memInfo.addrInfo.memType = RT_MEMORY_TYPE_HOST;
    error = rtMemGetInfoByType(0, RT_MEM_INFO_TYPE_ADDR_CHECK, &memInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemGetInfoEx(RT_MEMORYINFO_DDR, &free, &total);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, memcpyasyncex_host_to_device)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;

    error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyAsyncWithoutCheckKind(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE, stream_);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, memcpy_host_to_device_01)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    size_t free;
    size_t total;

    error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpy(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halMemGetInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));

    error = rtMemGetInfoEx(RT_MEMORYINFO_HBM, &free, &total);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, memcpy_async_host_to_device)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;

    error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtTaskCfgInfo_t taskCfgInfo = {};
    taskCfgInfo.qos = 1;
    taskCfgInfo.partId = 1;

    error = rtMemcpyAsync(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE, stream_);
    error = rtMemcpyAsyncWithCfg(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE, stream_, 0);
    error = rtMemcpyAsyncWithCfgV2(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE, stream_, &taskCfgInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyAsync(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE, stream_);
    std::vector<uintptr_t> input;
    input.push_back(reinterpret_cast<uintptr_t>(devPtr));
    input.push_back(static_cast<uintptr_t>(64));
    input.push_back(reinterpret_cast<uintptr_t>(hostPtr));
    input.push_back(static_cast<uintptr_t>(64));
    input.push_back(static_cast<uintptr_t>(RT_MEMCPY_HOST_TO_DEVICE));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));
    input.push_back(static_cast<uintptr_t>(0));
    error = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_MEMCPY_ASYNC_CFG);

    error = rtMemcpyAsync(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE, stream_);
    error = rtMemcpyAsyncWithCfg(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE, stream_, 0);
    error = rtMemcpyAsyncWithCfgV2(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE, stream_, &taskCfgInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, memcpy_async_d2d_invalid_size)
{
    rtError_t error;
    void *srcPtr;
    void *dstPtr;
    uint64_t invalidSize = MAX_MEMCPY_SIZE_OF_D2D + 1;

    error = rtMalloc(&srcPtr, 64, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&dstPtr, 64, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyAsyncPtr(dstPtr, invalidSize, invalidSize, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, NULL, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);  // invalid size

    error = rtFree(srcPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(dstPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, memcpy_async_host_to_device_64M)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    uint64_t memsize = 64*1024*1024+1;

    Api *api = Api::Instance();
    MOCKER_CPP_VIRTUAL(api, &Api::MemcpyAsync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = rtMalloc(&hostPtr, memsize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, memsize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyAsync(devPtr, memsize, hostPtr, memsize, RT_MEMCPY_HOST_TO_DEVICE, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, memcpy_async_host_to_device_64M_error)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    uint64_t memsize = 64*1024*1024+1;

    Api *api = Api::Instance();
    MOCKER_CPP_VIRTUAL(api, &Api::MemcpyAsync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtMalloc(&hostPtr, memsize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, memsize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyAsync(devPtr, memsize, hostPtr, memsize, RT_MEMCPY_HOST_TO_DEVICE, NULL);
    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, memcpy_async_host_to_device_64M_auto)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    uint64_t memsize = 64*1024*1024+1;

    Api *api = Api::Instance();
    MOCKER_CPP_VIRTUAL(api, &Api::MemcpyAsync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtMalloc(&hostPtr, memsize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, memsize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyAsync(devPtr, memsize, hostPtr, memsize, RT_MEMCPY_DEFAULT, NULL);
    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, memcpy_async_host_to_device_64M_error2)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    uint64_t memsize = 64*1024*1024;

    Api *api = Api::Instance();
    MOCKER_CPP_VIRTUAL(api, &Api::MemcpyAsync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = rtMalloc(&hostPtr, memsize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, memsize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyAsync(devPtr, memsize, hostPtr, memsize+1, RT_MEMCPY_HOST_TO_DEVICE, NULL);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, memcpy_async_coverage)
{
    void *hostPtr;
    void *devPtr;
    ApiImpl impl;
    ApiDecorator api(&impl);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemcpyAsync)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    rtError_t error = api.MemcpyAsync(devPtr, 64*1024*1024, hostPtr, 64*1024*1024, RT_MEMCPY_HOST_TO_DEVICE, NULL, 0);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

//changed
TEST_F(ApiTest910b, memcpy_asyncPtr_coverage)
{
    rtMemcpyAddrInfo *memcpyAddrInfo;
    ApiImpl impl;
    ApiErrorDecorator api(&impl);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ContextGetCurrent)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));
    rtError_t error = api.MemcpyAsyncPtr(memcpyAddrInfo, 64*1024*1024, 64*1024*1024, NULL, 0);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(ApiTest910b, memcpy_coverage)
{
    void *hostPtr;
    void *devPtr;
    ApiImpl impl;
    ApiDecorator api(&impl);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemCopySync)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    rtError_t error = api.MemCopySync(devPtr,  64*1024*1024, hostPtr, 64*1024*1024, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

//changed
TEST_F(ApiTest910b, managed_mem)
{
    rtError_t error;
    void *ptr = NULL;

    error = rtMemAllocManaged(&ptr, 128, 0, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemFreeManaged(ptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, kernelinfo_callback)
{
    rtError_t error;
    rtKernelReportCallback callBack = (rtKernelReportCallback)0x6000;

    error = rtSetKernelReportCallback((rtKernelReportCallback)NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

//changed
TEST_F(ApiTest910b, LAUNCH_KERNEL_TEST_1)
{
    rtError_t error;
    void *args[] = {&error, NULL};

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Context::KernelTaskConfig).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, LAUNCH_KERNEL_TEST_2)
{
    rtError_t error;
    void *args[] = {&error, NULL};
    PCTrace* pctraceHandle = new PCTrace();
    RawDevice *stubDevice = new RawDevice(0);
    stubDevice->Init();

    TaskInfo *pctraceTask = (const_cast<TaskFactory *>(stubDevice->GetTaskFactory()))->Alloc(
        (cce::runtime::Stream*)stream_, TS_TASK_TYPE_PCTRACE_ENABLE, error);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Context::ConfigPCTraceTask).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    // ConfigPCTraceTask not use in product=mini
    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    (const_cast<TaskFactory *>(stubDevice->GetTaskFactory()))->Recycle(pctraceTask);
    delete pctraceHandle;
    delete stubDevice;
}

TEST_F(ApiTest910b, LAUNCH_KERNEL_TEST_3)
{
    rtError_t error;
    void *args[] = {&error, NULL};
    PCTrace* pctraceHandle = new PCTrace();
    RawDevice *stubDevice = new RawDevice(0);
    stubDevice->Init();

    TaskInfo *pctraceTask = (const_cast<TaskFactory *>(stubDevice->GetTaskFactory()))->Alloc(
        (cce::runtime::Stream*)stream_, TS_TASK_TYPE_PCTRACE_ENABLE, error);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Context::ConfigPCTraceTask).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    MOCKER_CPP(&Context::GetModule).stubs().will(returnValue((Module *)NULL));

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_MEMORY_ALLOCATION);

    error = rtStreamSynchronize(stream_);
    (const_cast<TaskFactory *>(stubDevice->GetTaskFactory()))->Recycle(pctraceTask);
    delete pctraceHandle;
    delete stubDevice;
}

TEST_F(ApiTest910b, LAUNCH_KERNEL_TEST_4)
{
    rtError_t error;
    void *args[] = {&error, NULL};
    PCTrace* pctraceHandle = new PCTrace();
    RawDevice *stubDevice = new RawDevice(0);
    stubDevice->Init();

    TaskInfo *pctraceTask = (const_cast<TaskFactory *>(stubDevice->GetTaskFactory()))->Alloc(
        (cce::runtime::Stream*)stream_, TS_TASK_TYPE_PCTRACE_ENABLE, error);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Context::ConfigPCTraceTask).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    (const_cast<TaskFactory *>(stubDevice->GetTaskFactory()))->Recycle(pctraceTask);
    delete pctraceHandle;
    delete stubDevice;
}

TEST_F(ApiTest910b, memcpy_async_host_to_device_ex)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    void *hostPtr;
    void *devPtr;

    rtError_t error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);//RT_MEMORY_TYPE_HOST
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);//RT_MEMORY_TYPE_DEVICE
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtModel_t model;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyAsync(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE_EX, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtModelUnbindStream(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, kernel_launch_1)
{
    rtError_t error;
    void *args[] = {&error, NULL};

    MOCKER(memcpy_s).stubs().will(returnValue(EOK));

    error = rtKernelLaunch(&error, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtKernelLaunch(&function_, 1, NULL, 0, NULL, stream_);
    EXPECT_NE(error, RT_ERROR_NONE);
    MOCKER_CPP(&PCTrace::FreePCTraceMemory).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtKernelLaunch(&function_, 0, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, kernel_config_dump)
{
    rtError_t error;
    void *dumpBaseVAddr = NULL;
    NpuDriver drv;

    error = rtKernelConfigDump(RT_DATA_DUMP_KIND_DUMP, 0,  3, &dumpBaseVAddr, ApiTest910b::stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTest910b, kernel_config_dump_host_malloc_fail)
{
    rtError_t error;
    void *dumpBaseVAddr = NULL;
    NpuDriver drv;

    error = rtKernelConfigDump(RT_DATA_DUMP_KIND_DUMP, 0,  3, &dumpBaseVAddr, ApiTest910b::stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtKernelConfigDump(RT_DATA_DUMP_KIND_DUMP, 100,  0, &dumpBaseVAddr, ApiTest910b::stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtKernelConfigDump(RT_DATA_DUMP_KIND_DUMP, 100, 3, &dumpBaseVAddr, ApiTest910b::stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtKernelConfigDump(RT_DATA_DUMP_KIND_DUMP, 100, 3, &dumpBaseVAddr, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    MOCKER_CPP_VIRTUAL(drv,&NpuDriver::HostMemAlloc)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));
    error = rtKernelConfigDump(RT_DATA_DUMP_KIND_DUMP, 100, 3, &dumpBaseVAddr, ApiTest910b::stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}


TEST_F(ApiTest910b, kernel_launch_with_dump)
{
    rtError_t error;
    void *dumpBaseVAddr = NULL;
    void *args[] = {&error, NULL};

    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(NULL));

    error = rtKernelConfigDump(RT_DATA_DUMP_KIND_DUMP, 100, 3, &dumpBaseVAddr, ApiTest910b::stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::reset();
}

TEST_F(ApiTest910b, kernel_launch_with_dump_error)
{
    rtError_t error;
    void *dumpBaseVAddr = NULL;
    void *args[] = {&error, NULL};

    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(NULL));

    error = rtKernelConfigDump(RT_DATA_DUMP_KIND_DUMP, 100, 3, &dumpBaseVAddr, ApiTest910b::stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    MOCKER_CPP(&Context::GetModule).stubs().will(returnValue((Module *)NULL));

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::reset();
}

TEST_F(ApiTest910b, ipc_set_notify_pid2)
{
    rtError_t error;
    uint64_t devAddrOffset = 0;
    Notify *notify = NULL;
    Notify notify1(0, 0);
    int32_t pid[]={1};
    int num = 1;

    Api *api = Api::Instance();
    ApiDecorator apiDec(api);

    MOCKER(drvNotifyIdAddrOffset).stubs().will(returnValue(DRV_ERROR_NONE));

    error = apiDec.NotifyGetAddrOffset(&notify1, &devAddrOffset);
    EXPECT_EQ(error, RT_ERROR_DRV_NULL);
}

TEST_F(ApiTest910b, kernel_launch_set_kernel_task_id)
{
    rtError_t error;
    rtL2Ctrl_t ctrl;
    void *args[] = {&error, NULL};

    memset_s(&ctrl, sizeof(rtSmDesc_t), 0, sizeof(rtSmDesc_t));
    ctrl.size = 128;
    for (uint32_t i = 0; i < 8; i++)
    {
        ctrl.data[i].L2_mirror_addr = 0x40 * i;
    }

    rtModel_t  model;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream_, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ctrl.size = 128;
    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), &ctrl, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, label_create_error)
{
    rtError_t error;
    rtLabel_t label;

    ApiImpl *apiImpl = new ApiImpl();
    ApiDecorator api(apiImpl);
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LabelCreate)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    error = api.LabelCreate((Label**)&label, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtLabelCreateV2(&label, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    delete apiImpl;
}

TEST_F(ApiTest910b, label_destroy_error)
{
    rtError_t error;
    rtLabel_t label;

    rtModel_t model;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtLabelCreateV2(&label, model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ApiImpl *apiImpl = new ApiImpl();
    ApiDecorator api(apiImpl);
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LabelDestroy)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    error = api.LabelDestroy((Label*)label);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtLabelDestroy(label);
    EXPECT_NE(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    delete apiImpl;

    error = rtLabelDestroy(label);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, label_task_api_error)
{
    rtError_t error;

    ApiImpl *apiImpl = new ApiImpl();
    ApiDecorator api(apiImpl);

    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LabelGoto)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LabelSet)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LabelSwitchListCreate)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    error = api.LabelGoto(NULL, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = api.LabelSet(NULL, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = api.LabelSwitchListCreate(NULL, 0, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    delete apiImpl;
}

TEST_F(ApiTest910b, GetDevicePhyIdByIndex)
{
    rtError_t error;
    uint32_t devIndex = 0;
    uint32_t phyId = 0;

    error = rtGetDevicePhyIdByIndex(devIndex, &phyId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetDevicePhyIdByIndex(devIndex, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER(drvDeviceGetPhyIdByIndex)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE));

    error = rtGetDevicePhyIdByIndex(devIndex, &phyId);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}

TEST_F(ApiTest910b, GetDeviceIndexByPhyId)
{
    rtError_t error;
    uint32_t devIndex = 0;
    uint32_t phyId = 0;

    error = rtGetDeviceIndexByPhyId(phyId, &devIndex);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetDeviceIndexByPhyId(phyId, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER(drvDeviceGetIndexByPhyId)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE));

    error = rtGetDeviceIndexByPhyId(phyId, &devIndex);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}

TEST_F(ApiTest910b, kernel_launch_ex_dump)
{
    rtError_t error;
    rtStream_t stream;

    error = rtKernelLaunchEx(NULL, 0, 2, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtKernelLaunchEx((void *)1, 1, 2, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream *stream0 = (Stream *)stream;
    Context *context0 = (Context *)stream0->Context_();
    stream0->SetContext((Context *)NULL);

    error = rtKernelLaunchEx((void *)1, 1, 2, stream);
    EXPECT_NE(error, RT_ERROR_NONE);
    Stream *stream_var = static_cast<Stream *>(stream);
    stream_var->pendingNum_.Set(0);
    stream0->SetContext(context0);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, GetOpTimeOut_set)
{
    uint32_t aiCpuCnt = 0U;
    MOCKER(rtGetAiCpuCount)
    .stubs()
    .with(outBoundP(&aiCpuCnt, sizeof(aiCpuCnt)))
    .will(returnValue(ACL_RT_SUCCESS));

    rtError_t error;
    error = rtSetOpWaitTimeOut(1);

    uint32_t timeout = 0;
    rtGetOpExecuteTimeOut(&timeout);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetOpExecuteTimeOut(&timeout);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, GetDeviceCapModelUpdate)
{
    rtError_t error;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int32_t value = 0;

    error = rtGetDeviceCapability(0, RT_MODULE_TYPE_TSCPU, FEATURE_TYPE_MODEL_TASK_UPDATE, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(value, RT_DEV_CAP_NOT_SUPPORT);
}

TEST_F(ApiTest910b, GetDeviceCapModelUpdate_StubDev)
{
    rtError_t error;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int32_t value = 0;

    error = rtGetDeviceCapability(64, RT_MODULE_TYPE_TSCPU, FEATURE_TYPE_MODEL_TASK_UPDATE, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(value, RT_DEV_CAP_NOT_SUPPORT);
}

TEST_F(ApiTest910b, ADCProfiler)
{
    rtError_t error;
    void *addr;
    uint32_t length = 256 * 1024;

    error = rtStartADCProfiler(&addr, length);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtStopADCProfiler(addr);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTest910b, memcpy2d_host_to_device_00)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    size_t free;
    size_t total;

    error = rtMalloc(&hostPtr, 100, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 100, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpy2d(devPtr, 100, hostPtr, 100, 10, 1, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, memcpy2d_host_to_device_01)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    size_t free;
    size_t total;

    error = rtMalloc(&hostPtr, 100, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 100, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtMemcpy2DParams_t para;
    para.dst = devPtr;
    para.dstPitch = 100;
    para.src = hostPtr;
    para.srcPitch = 100;
    para.height = 10;
    para.width = 1;
    para.kind = RT_MEMCPY_KIND_HOST_TO_DEVICE;

    error = rtsMemcpy2D(&para, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, memcpy2d_host_to_device_02)
{
    rtError_t error;
    error = rtsMemcpy2D(NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

//changed
TEST_F(ApiTest910b, memcpy2d_host_to_device_auto)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    size_t free;
    size_t total;

    error = rtMalloc(&hostPtr, 100, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 100, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpy2d(devPtr, 100, hostPtr, 100, 10, 1, RT_MEMCPY_DEFAULT);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, memcpy2d_async_success_coverage)
{
    void *hostPtr;
    void *devPtr;
    ApiImpl impl;
    ApiDecorator api(&impl);
    ApiErrorDecorator errApi(&impl);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemCopy2DAsync)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemCopy2DSync)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    rtError_t error = api.MemCopy2DAsync(devPtr, 100, hostPtr, 100, 10, 1, NULL, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = api.MemCopy2DSync(devPtr, 100, hostPtr, 100, 10, 1, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = errApi.MemCopy2DAsync(devPtr, 100, hostPtr, 100, 10, 1, NULL, RT_MEMCPY_DEVICE_TO_HOST);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = errApi.MemCopy2DAsync(devPtr, 100, hostPtr, 100, 10, 1, NULL, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(ApiTest910b, memcpy2d_host_to_device_fail)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    size_t free;
    size_t total;

    error = rtMalloc(&hostPtr, 100, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 100, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpy2d(devPtr, 100, hostPtr, 100, 10, 1, RT_MEMCPY_HOST_TO_HOST);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, memcpy2d_async_param_fail)
{
    rtError_t error;
    error = rtsMemcpy2DAsync(NULL, NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910b, ipc_memory_ex)
{
    rtError_t error;
    void *ptr1 = NULL;
    void *ptr2 = (void *)0x20000;
    void *ptr3 = (void *)0x10000;

    error = rtSetDevice(0);
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::OpenIpcMem).stubs().will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMalloc(&ptr1, 128, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtIpcOpenMemory(&ptr2, "mem1");
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(ptr1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(ApiTest910b, GetDevArgsAddrForError)
{
    rtStream_t stm;
    rtError_t error = rtStreamCreate(&stm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t arg = 0x1234567890;
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    void *devArgsAddr = nullptr, *argsHandle = nullptr;
    error = rtGetDevArgsAddr(stm, &argsInfo, &devArgsAddr, &argsHandle);
}

TEST_F(ApiTest910b, hdc_server_create)
{
    rtError_t error;
    rtHdcServer_t server = nullptr;

    error = rtHdcServerCreate(-1, RT_HDC_SERVICE_TYPE_DMP, &server);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
    error = rtHdcServerCreate(0, RT_HDC_SERVICE_TYPE_MAX, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER(drvHdcServerCreate)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    for (int32_t type = RT_HDC_SERVICE_TYPE_DMP; type < RT_HDC_SERVICE_TYPE_MAX; type++) {
        error = rtHdcServerCreate(0, static_cast<rtHdcServiceType_t>(type), &server);
        EXPECT_EQ(error, ACL_RT_SUCCESS);
    }

    GlobalMockObject::verify();

    MOCKER(drvHdcServerCreate)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE));
    for (int32_t type = RT_HDC_SERVICE_TYPE_DMP; type < RT_HDC_SERVICE_TYPE_MAX; type++) {
        error = rtHdcServerCreate(0, static_cast<rtHdcServiceType_t>(type), &server);
        EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
    }

    GlobalMockObject::verify();

    MOCKER(drvHdcServerCreate)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    for (int32_t type = RT_HDC_SERVICE_TYPE_DMP; type < RT_HDC_SERVICE_TYPE_MAX; type++) {
        error = rtHdcServerCreate(0, static_cast<rtHdcServiceType_t>(type), &server);
        EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    }

    GlobalMockObject::verify();

    MOCKER(drvHdcServerCreate)
        .stubs()
        .will(returnValue(DRV_ERROR_SERVER_CREATE_FAIL));
    for (int32_t type = RT_HDC_SERVICE_TYPE_DMP; type < RT_HDC_SERVICE_TYPE_MAX; type++) {
        error = rtHdcServerCreate(0, static_cast<rtHdcServiceType_t>(type), &server);
        EXPECT_EQ(error, ACL_ERROR_RT_DRV_INTERNAL_ERROR);
    }

    GlobalMockObject::verify();

    MOCKER(NpuDriver::HdcServerCreate)
        .stubs()
        .will(returnValue(RT_ERROR_DRV_NOT_SUPPORT));
    for (int32_t type = RT_HDC_SERVICE_TYPE_DMP; type < RT_HDC_SERVICE_TYPE_MAX; type++) {
        error = rtHdcServerCreate(0, static_cast<rtHdcServiceType_t>(type), &server);
        EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    }
}

TEST_F(ApiTest910b, hdc_server_destroy)
{
    rtError_t error;
    rtHdcServer_t server = (void *)&error;

    error = rtHdcServerDestroy(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER(drvHdcServerDestroy)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_DEVICE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE))
        .then(returnValue(DRV_ERROR_CLIENT_BUSY));
    error = rtHdcServerDestroy(server);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtHdcServerDestroy(server);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
    error = rtHdcServerDestroy(server);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtHdcServerDestroy(server);
    EXPECT_EQ(error, ACL_ERROR_RT_DRV_INTERNAL_ERROR);

    MOCKER(NpuDriver::HdcServerDestroy)
        .stubs()
        .will(returnValue(RT_ERROR_DRV_NOT_SUPPORT));
    error = rtHdcServerDestroy(server);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTest910b, hdc_session_connect)
{
    rtError_t error;
    rtHdcSession_t session = nullptr;
    rtHdcClient_t client = &error;

    error = rtHdcSessionConnect(0, 0, nullptr, &session);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtHdcSessionConnect(0, 0, client, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtHdcSessionConnect(0, -1, client, &session);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);

    MOCKER(drvHdcSessionConnect)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_DEVICE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE))
        .then(returnValue(DRV_ERROR_OUT_OF_MEMORY))
        .then(returnValue(DRV_ERROR_SOCKET_CONNECT));
    error = rtHdcSessionConnect(0, 0, client, &session);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtHdcSessionConnect(0, 0, client, &session);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
    error = rtHdcSessionConnect(0, 0, client, &session);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtHdcSessionConnect(0, 0, client, &session);
    EXPECT_EQ(error, ACL_ERROR_RT_MEMORY_ALLOCATION);
    error = rtHdcSessionConnect(0, 0, client, &session);
    EXPECT_EQ(error, ACL_ERROR_RT_DRV_INTERNAL_ERROR);

    MOCKER(NpuDriver::HdcSessionConnect)
        .stubs()
        .will(returnValue(RT_ERROR_DRV_NOT_SUPPORT));
    error = rtHdcSessionConnect(0, 0, client, &session);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTest910b, hdc_session_close)
{
    rtError_t error;
    rtHdcSession_t session = &error;

    error = rtHdcSessionClose(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER(drvHdcSessionClose)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtHdcSessionClose(session);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtHdcSessionClose(session);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER(NpuDriver::HdcSessionClose)
        .stubs()
        .will(returnValue(RT_ERROR_DRV_NOT_SUPPORT));
    error = rtHdcSessionClose(session);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}


TEST_F(ApiTest910b, host_register_test)
{
    rtError_t error;
    int ptr = 10;
    void *devPtr = nullptr;

    ApiImpl apiImpl;
    ApiDecorator apiDecorator(&apiImpl);
    error = apiDecorator.HostRegister(&ptr, 100, RT_HOST_REGISTER_MAPPED, &devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, host_register_pinned)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    uintptr_t value = 0x123U;
    void **devPtr = (void **)&value;

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtHostGetDevicePointer(ptr.get(), devPtr, 0U);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(*devPtr, nullptr);

    error = rtHostRegisterV2(RtValueToPtr<void *>(RtPtrToValue(ptr.get()) + 1U), sizeof(uint32_t), RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, ACL_ERROR_HOST_MEMORY_ALREADY_REGISTERED);

    error = rtHostRegisterV2(RtValueToPtr<void *>(RtPtrToValue(ptr.get()) + 2U), sizeof(uint32_t), RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, ACL_ERROR_HOST_MEMORY_ALREADY_REGISTERED);

    error = rtHostRegisterV2(RtValueToPtr<void *>(RtPtrToValue(ptr.get()) + 3U), sizeof(uint32_t), RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, ACL_ERROR_HOST_MEMORY_ALREADY_REGISTERED);

    error = rtHostRegisterV2(RtValueToPtr<void *>(RtPtrToValue(ptr.get()) + 4U), sizeof(uint32_t), RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(*devPtr, nullptr);

    error = rtsHostUnregister(ptr.get()); 
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsHostUnregister(RtValueToPtr<void *>(RtPtrToValue(ptr.get()) + 4U)); 
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

drvError_t halHostRegister_stub(void *hostPtr, UINT64 size, UINT32 flag, UINT32 devid, void **devPtr)
{
    *devPtr = hostPtr;
    return DRV_ERROR_NONE;
}

TEST_F(ApiTest910b, host_register_pinned_mapped)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    uintptr_t value = 0x123U;
    void **devPtr = (void **)&value;

    MOCKER(&halHostRegister)
        .stubs()
        .will(invoke(halHostRegister_stub));

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_MAPPED | RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtHostGetDevicePointer(ptr.get(), devPtr, 0U);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(*devPtr, ptr.get());

    error = rtHostRegisterV2(RtValueToPtr<void *>(RtPtrToValue(ptr.get()) + 1U), sizeof(uint32_t), RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, ACL_ERROR_HOST_MEMORY_ALREADY_REGISTERED);

    error = rtHostRegisterV2(RtValueToPtr<void *>(RtPtrToValue(ptr.get()) + 2U), sizeof(uint32_t), RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, ACL_ERROR_HOST_MEMORY_ALREADY_REGISTERED);

    error = rtHostRegisterV2(RtValueToPtr<void *>(RtPtrToValue(ptr.get()) + 3U), sizeof(uint32_t), RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, ACL_ERROR_HOST_MEMORY_ALREADY_REGISTERED);

    error = rtHostRegisterV2(RtValueToPtr<void *>(RtPtrToValue(ptr.get()) + 4U), sizeof(uint32_t), RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtHostGetDevicePointer(RtValueToPtr<void *>(RtPtrToValue(ptr.get()) + 4U), devPtr, 0U);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(*devPtr, nullptr);

    error = rtHostGetDevicePointer(RtValueToPtr<void *>(RtPtrToValue(ptr.get()) + 5U), devPtr, 1U);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(*devPtr, nullptr);

    error = rtsHostUnregister(ptr.get()); 
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsHostUnregister(RtValueToPtr<void *>(RtPtrToValue(ptr.get()) + 4U)); 
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    auto ptr2 = std::make_unique<uint32_t>();
    uintptr_t value2 = 0x123U;
    void **devPtr2 = (void **)&value2;

    error = rtsHostRegister(ptr2.get(), sizeof(uint32_t), RT_HOST_REGISTER_MAPPED, devPtr2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsHostUnregister(ptr2.get());
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(ApiTest910b, host_register_atomic)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    uintptr_t value = 0x123U;
    void **devPtr = (void **)&value;

    MOCKER(&halHostRegister)
        .stubs()
        .will(invoke(halHostRegister_stub));

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_MAPPED | RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, ACL_ERROR_HOST_MEMORY_ALREADY_REGISTERED);
    error = rtHostGetDevicePointer(ptr.get(), devPtr, 0U);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(*devPtr, nullptr);
    error = rtsHostUnregister(ptr.get());
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(ApiTest910b, pin_memory_attribute)
{
    rtError_t error;
    auto ptr = std::make_unique<uint32_t>();
    rtPointerAttributes_t attributes;

    error = rtHostRegisterV2(ptr.get(), sizeof(uint32_t), RT_MEM_HOST_REGISTER_PINNED);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_7));
    error = rtPointerGetAttributes(&attributes, ptr.get());
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(attributes.locationType, RT_MEMORY_LOC_HOST);

    error = rtsHostUnregister(ptr.get()); 
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(ApiTest910b, memcpy_batch)
{
    rtError_t error;
    size_t failIdx;
    error = rtsMemcpyBatch(nullptr, nullptr, nullptr, 0, nullptr, nullptr, 0, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}


TEST_F(ApiTest910b, memcpy_batch_async)
{
    rtError_t error;
    size_t failIdx;
    error = rtsMemcpyBatchAsync(nullptr, nullptr,  nullptr, nullptr, 0, nullptr, nullptr, 0, &failIdx, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910b, ipc_set_notify_pid3)
{
    rtNotify_t notify = nullptr;
    rtError_t error;
    int32_t pid[]={1};
    int num = 1;
    error = rtsNotifySetImportPid(notify, pid,num);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910b, rts_ipc_open_with_flag_succ)
{
    ApiImpl apiImpl;
    rtError_t error;
    uint32_t phyDevId;
    uint32_t tsId;
    uint32_t notifyId;
    rtNotifyPhyInfo notifyInfo;
 
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::IpcOpenNotify).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetNotifyPhyInfo).stubs().will(invoke(GetNotifyPhyInfoStub));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::NotifyDestroy).stubs().will(returnValue(RT_ERROR_NONE));
 
    rtNotify_t notify2 = new (std::nothrow) Notify(0, 0);
    error = rtsNotifyImportByKey(&notify2, "aaaa", 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtNotifyGetPhyInfo(notify2, &phyDevId, &tsId);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(phyDevId, 1);
    EXPECT_EQ(tsId, 2);
    error = rtNotifyGetPhyInfoExt(notify2, &notifyInfo);
    error = rtNotifyDestroy(notify2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    delete notify2;
}

TEST_F(ApiTest910b, rtMallocPysical)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtDrvMemHandle handVal;
    rtDrvMemProp_t prop = {};
    prop.mem_type = 1;
    prop.pg_type = 2;
    rtDrvMemHandle *handle = &handVal;

    rtInstance->SetIsSupport1GHugePage(false);
    error = rtMallocPhysical(handle, 0, &prop, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest910b, rts_memset_sync)
{
    rtError_t error;
    void *devPtr;
    rtMallocConfig_t *p = nullptr;
    error = rtsMalloc(&devPtr, 60, RT_MEM_MALLOC_HUGE_FIRST, RT_MEM_ADVISE_NONE, p);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtsMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtsFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, rtsLabelSwitchListCreate)
{
    rtError_t error;
    const size_t labelNum = 65535U;
    rtLabel_t label[labelNum];
    rtLabel_t labelInfo[labelNum];
    for (size_t i = 0; i < labelNum; i++) {
        error = rtsLabelCreate(&label[i]);
        EXPECT_EQ(error, RT_ERROR_NONE);
        labelInfo[i] = label[i];
    }
    rtLabel_t labelTmp;
    error = rtsLabelCreate(&labelTmp);  // 超规格
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);
 
    void *labelList = nullptr;
    error = rtsLabelSwitchListCreate(nullptr, labelNum, &labelList);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtsLabelSwitchListCreate(&labelInfo[0], 0U, &labelList);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtsLabelSwitchListCreate(&labelInfo[0], 65536U, &labelList);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtsLabelSwitchListCreate(&labelInfo[0], labelNum, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    error = rtsLabelSwitchListCreate(&labelInfo[0], labelNum, &labelList);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtsLabelSwitchListDestroy(labelList);
    EXPECT_EQ(error, RT_ERROR_NONE);
    for (size_t i = 0; i < labelNum; i++) {
        error = rtsLabelDestroy(label[i]);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }
}
 
TEST_F(ApiTest910b, rtsLabelSwitchByIndex)
{
    typedef void *rtAddr_t;
    typedef struct {
        uint32_t *hostAddr = nullptr;
        uint32_t *devAddr = nullptr;
    } memUnit;    
 
    rtError_t error;
    rtContext_t ctx;
    error = rtCtxGetCurrent(&ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Device *device = (Device *)((Context *)ctx)->Device_();
    device->SetTschVersion(0);

    Api *oldApi_ = const_cast<Api *>(Runtime::runtime_->api_);
    Profiler *profiler = new Profiler(oldApi_);
    profiler->Init();
 
    rtStream_t streamExe;
    rtStream_t stream[2];
    error = rtStreamCreate(&streamExe, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamCreateWithFlags(&stream[0], 5, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamCreateWithFlags(&stream[1], 5, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    rtModel_t model;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    rtLabel_t label[3];
    error = rtsLabelCreate(&label[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsLabelCreate(&label[1]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsLabelCreate(&label[2]);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtModelBindStream(model, stream[0], 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelBindStream(model, stream[1], 0xFFFFFFFF);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    void *args[] = {&error, NULL};
    error = rtsLabelSet(label[0], stream[1]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream[1]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsLabelSet(label[1], stream[1]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream[1]);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    const uint32_t ptrMemSize = 4;
    memUnit memPtr;
    error = rtMallocHost((void **)&memPtr.hostAddr, ptrMemSize, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    *(uint32_t *)memPtr.hostAddr = 1;
    error = rtMalloc((void **)&memPtr.devAddr, ptrMemSize, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMemcpy(memPtr.devAddr, ptrMemSize, memPtr.hostAddr, ptrMemSize, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    rtLabel_t labelInfo[2];
    labelInfo[0] = label[0];
    labelInfo[1] = label[1];
    const uint32_t labelMax = 2;
    const uint32_t labelMemSize = sizeof(rtLabelDevInfo) * labelMax;
    memUnit labelPtr;
    error = rtMalloc((void **)&labelPtr.devAddr, ptrMemSize, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    void *labelList = nullptr;
    error = rtsLabelSwitchListCreate(&labelInfo[0], labelMax, &labelList);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtsLabelSwitchByIndex((void *)memPtr.devAddr, labelMax, labelList, stream[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtLabelGotoEx(label[2], stream[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->LabelGotoEx((Label *)label[2], (Stream *)stream[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtLabelSet(label[2], stream[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtModelLoadComplete(model);
    EXPECT_NE(error, RT_ERROR_NONE);
    error = rtModelExecute(model, streamExe, 0);
    EXPECT_NE(error, RT_ERROR_NONE);
    error = rtStreamSynchronize(streamExe);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtFree(labelPtr.devAddr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtFree(memPtr.devAddr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtFreeHost(memPtr.hostAddr);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtModelUnbindStream(model, stream[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelUnbindStream(model, stream[1]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsLabelDestroy(label[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsLabelDestroy(label[1]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsLabelDestroy(label[2]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream[1]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(streamExe);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsLabelSwitchListDestroy(labelList);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete profiler;
}

TEST_F(ApiTest910b, rtSetProfDirEx)
{
    rtError_t error = rtSetProfDirEx(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
 
TEST_F(ApiTest910b, rtSetMsprofReporterCallback)
{
    rtError_t ret;
    ret = rtSetMsprofReporterCallback(msprofreportcallback);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
}
 
TEST_F(ApiTest910b, rtSetDeviceSatMode)
{
    rtError_t ret;
    ret = rtSetDeviceSatMode(RT_OVERFLOW_MODE_SATURATION);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
 
    ret = rtSetDeviceSatMode(RT_OVERFLOW_MODE_INFNAN);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
}

TEST_F(ApiTest910b, rtsGetInterCoreSyncAddr)
{
    rtError_t error;
    uint64_t addr;
    uint32_t len;
    error = rtsGetInterCoreSyncAddr(&addr, &len);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest910b, rtsGetHardwareSyncAddr)
{
    rtError_t error;
    void *addr = nullptr;
    error = rtsGetHardwareSyncAddr(&addr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, rtGetC2cCtrlAddr)
{
    rtError_t error;
    uint64_t addr;
    uint32_t len;
    error = rtGetC2cCtrlAddr(&addr, &len);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, rtLabelSwitchByIndex)
{
    typedef void *rtAddr_t;
    typedef struct {
        uint32_t *hostAddr = nullptr;
        uint32_t *devAddr = nullptr;
    } memUnit;

    rtError_t error;
    rtContext_t ctx;
    error = rtCtxGetCurrent(&ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Device *device = (Device *)((Context *)ctx)->Device_();
    device->SetTschVersion(0);

    Api *oldApi_ = const_cast<Api *>(Runtime::runtime_->api_);
    Profiler *profiler = new Profiler(oldApi_);
    profiler->Init();

    rtStream_t streamExe;
    rtStream_t stream[2];
    error = rtStreamCreate(&streamExe, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamCreateWithFlags(&stream[0], 5, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamCreateWithFlags(&stream[1], 5, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtModel_t model;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtLabel_t label[3];
    error = rtLabelCreateV2(&label[0], model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtLabelCreateV2(&label[1], model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtLabelCreateV2(&label[2], model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream[0], 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelBindStream(model, stream[1], 0xFFFFFFFF);
    EXPECT_EQ(error, RT_ERROR_NONE);

    void *args[] = {&error, NULL};
    error = rtLabelSet(label[0], stream[1]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream[1]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtLabelSet(label[1], stream[1]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream[1]);
    EXPECT_EQ(error, RT_ERROR_NONE);

    const uint32_t ptrMemSize = 4;
    memUnit memPtr;
    error = rtMallocHost((void **)&memPtr.hostAddr, ptrMemSize, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    *(uint32_t *)memPtr.hostAddr = 1;
    error = rtMalloc((void **)&memPtr.devAddr, ptrMemSize, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMemcpy(memPtr.devAddr, ptrMemSize, memPtr.hostAddr, ptrMemSize, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtLabel_t labelInfo[2];
    labelInfo[0] = label[0];
    labelInfo[1] = label[1];
    const uint32_t labelMax = 2;
    const uint32_t labelMemSize = sizeof(rtLabelDevInfo) * labelMax;
    memUnit labelPtr;
    error = rtMalloc((void **)&labelPtr.devAddr, ptrMemSize, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtLabelListCpy(&labelInfo[0], labelMax, (void *)labelPtr.devAddr, labelMemSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->LabelListCpy((Label **)&labelInfo[0], labelMax, (void *)labelPtr.devAddr,
                                                         labelMemSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtLabelSwitchByIndex((void *)memPtr.devAddr, labelMax, (void *)labelPtr.devAddr, stream[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->LabelSwitchByIndex((void *)memPtr.devAddr, labelMax,
                                                               (void *)labelPtr.devAddr, (Stream *)stream[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtLabelGotoEx(label[2], stream[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->LabelGotoEx((Label *)label[2], (Stream *)stream[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtLabelSet(label[2], stream[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtModelLoadComplete(model);
    EXPECT_NE(error, RT_ERROR_NONE);
    error = rtModelExecute(model, streamExe, 0);
    EXPECT_NE(error, RT_ERROR_NONE);
    error = rtStreamSynchronize(streamExe);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtFree(labelPtr.devAddr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtFree(memPtr.devAddr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtFreeHost(memPtr.hostAddr);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtModelUnbindStream(model, stream[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelUnbindStream(model, stream[1]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtLabelDestroy(label[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtLabelDestroy(label[1]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtLabelDestroy(label[2]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream[1]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(streamExe);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete profiler;
}
 
TEST_F(ApiTest910b, rtQueryDevPid)
{
    uint32_t dst = (uint32_t)DEVDRV_PROCESS_CP1;
    EXPECT_EQ(RT_DEV_PROCESS_CP1, dst);
    dst = (uint32_t)DEVDRV_PROCESS_CP2;
    EXPECT_EQ(RT_DEV_PROCESS_CP2, dst);
    dst = (uint32_t)DEVDRV_PROCESS_DEV_ONLY;
    EXPECT_EQ(RT_DEV_PROCESS_DEV_ONLY, dst);
    dst = (uint32_t)DEVDRV_PROCESS_QS;
    EXPECT_EQ(RT_DEV_PROCESS_QS, dst);
 
    EXPECT_EQ(PROCESS_SIGN_LENGTH, RT_DEV_PROCESS_SIGN_LENGTH);
 
    dst = (uint32_t)ONLY;
    EXPECT_EQ(RT_SCHEDULE_POLICY_ONLY, dst);
    dst = (uint32_t)FIRST;
    EXPECT_EQ(RT_SCHEDULE_POLICY_FIRST, dst);
 
    // normal
    rtBindHostpidInfo_t info = {0};
    pid_t devPid = 0;
    rtError_t error = rtQueryDevPid(&info, &devPid);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtQueryDevPid(nullptr, &devPid);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtQueryDevPid(&info, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    MOCKER(halQueryDevpid).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtQueryDevPid(&info, &devPid);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910b, rtMbufInit)
{
    EXPECT_EQ(RT_MEM_BUFF_MAX_CFG_NUM, BUFF_MAX_CFG_NUM);
 
    // normal
    rtMemBuffCfg_t cfg = {{0}};
    rtError_t error = rtMbufInit(&cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtMbufInit(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halBuffInit)
        .stubs()
        .will(returnValue(code));
    error = rtMbufInit(&cfg);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMbufAlloc)
{
    // normal
    rtMbufPtr_t mbuf = nullptr;
    rtError_t error = rtMbufAlloc(&mbuf, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMbufAlloc(nullptr, 1);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halMbufAlloc)
        .stubs()
        .will(returnValue(code));
    error = rtMbufAlloc(&mbuf, 1);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910b, rtMbufAllocEx_malloc)
{
    // normal
    rtMbufPtr_t mbuf = nullptr;
    rtError_t error = rtMbufAllocEx(&mbuf, 1, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtMbufAllocEx(&mbuf, 1, 3, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    // invalid paramter
    error = rtMbufAllocEx(nullptr, 1, 0, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halMbufAlloc)
        .stubs()
        .will(returnValue(code));
    error = rtMbufAllocEx(&mbuf, 1, 0, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMbufBuild)
{
    // normal
    rtMbufPtr_t mbuf = nullptr;
    const uint64_t alloc_size = 100;
    void *buff = malloc(alloc_size);
    rtError_t error = rtMbufBuild(buff, alloc_size, &mbuf);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMbufBuild(nullptr, alloc_size, &mbuf);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halMbufBuild)
        .stubs()
        .will(returnValue(code));
    error = rtMbufBuild(buff, alloc_size, &mbuf);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    free(buff);
}
 
TEST_F(ApiTest910b, rtMbufUnBuild)
{
    // normal
    rtMbufPtr_t mbuf = (rtMbufPtr_t)1;
    uint64_t alloc_size_free = 0U;
    void *buff = nullptr;
    rtError_t error = rtMbufUnBuild(mbuf, &buff, &alloc_size_free);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMbufUnBuild(nullptr, &buff, &alloc_size_free);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halMbufUnBuild)
        .stubs()
        .will(returnValue(code));
    error = rtMbufUnBuild(mbuf, &buff, &alloc_size_free);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMbufAllocEx_malloc_ex)
{
    // normal
    rtMbufPtr_t mbuf = nullptr;
    rtError_t error = rtMbufAllocEx(&mbuf, 1, 1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMbufAllocEx(nullptr, 1, 1, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halMbufAllocEx)
        .stubs()
        .will(returnValue(code));
    error = rtMbufAllocEx(&mbuf, 1, 1, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMbufFree)
{
    // normal
    rtMbufPtr_t mbuf = (rtMbufPtr_t)1;
    rtError_t error = rtMbufFree(mbuf);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMbufFree(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halMbufFree).stubs().will(returnValue(code));
    error = rtMbufFree(mbuf);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMbufSetDataLen)
{
    // normal
    rtMbufPtr_t mbuf = (rtMbufPtr_t)1;
    rtError_t error = rtMbufSetDataLen(mbuf, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMbufSetDataLen(nullptr, 1);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(code));
    error = rtMbufSetDataLen(mbuf, 1);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMbufGetDataLen)
{
    // normal
    rtMbufPtr_t mbuf = (rtMbufPtr_t)1;
    uint64_t size = 0U;
    rtError_t error = rtMbufGetDataLen(mbuf, &size);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMbufGetDataLen(nullptr, &size);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    error = rtMbufGetDataLen(mbuf, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halMbufGetDataLen).stubs().will(returnValue(code));
    error = rtMbufGetDataLen(mbuf, &size);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMbufGetBuffAddr)
{
    // normal
    rtMbufPtr_t mbuf = (rtMbufPtr_t)1;
    void *buff = nullptr;
    rtError_t error = rtMbufGetBuffAddr(mbuf, &buff);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMbufGetBuffAddr(nullptr, &buff);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtMbufGetBuffAddr(mbuf, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halMbufGetBuffAddr).stubs().will(returnValue(code));
    error = rtMbufGetBuffAddr(mbuf, &buff);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMbufGetBuffSize)
{
    // normal
    rtMbufPtr_t mbuf = (rtMbufPtr_t)1;
    uint64_t totalSize = 0;
    rtError_t error = rtMbufGetBuffSize(mbuf, &totalSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMbufGetBuffSize(nullptr, &totalSize);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtMbufGetBuffSize(mbuf, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halMbufGetBuffSize).stubs().will(returnValue(code));
    error = rtMbufGetBuffSize(mbuf, &totalSize);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMbufGetPrivInfo)
{
    // normal
    rtMbufPtr_t mbuf = (rtMbufPtr_t)1;
    void *priv = nullptr;
    uint64_t size = 0;
    rtError_t error = rtMbufGetPrivInfo(mbuf, &priv, &size);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMbufGetPrivInfo(nullptr, &priv, &size);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtMbufGetPrivInfo(mbuf, nullptr, &size);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtMbufGetPrivInfo(mbuf, &priv, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMbufCopyBufRef)
{
    // normal
    rtMbufPtr_t mbuf = (rtMbufPtr_t)1;
    rtMbufPtr_t newMbuf = (rtMbufPtr_t)2;
    rtError_t error = rtMbufCopyBufRef(mbuf, &newMbuf);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMbufCopyBufRef(nullptr, &newMbuf);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtMbufCopyBufRef(mbuf, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMbufChainAppend)
{
    // normal
    rtMbufPtr_t memBufChainHead = (rtMbufPtr_t)1;
    rtMbufPtr_t memBuf = (rtMbufPtr_t)2;
    rtError_t error = rtMbufChainAppend(memBufChainHead, memBuf);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMbufChainAppend(nullptr, memBuf);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtMbufChainAppend(memBufChainHead, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halMbufChainAppend).stubs().will(returnValue(code));
    error = rtMbufChainAppend(memBufChainHead, memBuf);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMbufChainGetMbufNum)
{
    // normal
    rtMbufPtr_t memBufChainHead = (rtMbufPtr_t)1;
    uint32_t num = 0;
    rtError_t error = rtMbufChainGetMbufNum(memBufChainHead, &num);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMbufChainGetMbufNum(nullptr, &num);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtMbufChainGetMbufNum(memBufChainHead, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halMbufChainGetMbufNum).stubs().will(returnValue(code));
    error = rtMbufChainGetMbufNum(memBufChainHead, &num);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMbufChainGetMbuf)
{
    // normal
    rtMbufPtr_t memBufChainHead = (rtMbufPtr_t)1;
    rtMbufPtr_t memBuf = (rtMbufPtr_t)2;
    rtError_t error = rtMbufChainGetMbuf(memBufChainHead, 0, &memBuf);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMbufChainGetMbuf(nullptr, 0, &memBuf);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtMbufChainGetMbuf(memBufChainHead, 0, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halMbufChainGetMbuf).stubs().will(returnValue(code));
    error = rtMbufChainGetMbuf(memBufChainHead, 0, &memBuf);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910b, rtLabelListCpyV2)
{
    rtError_t error;
    rtContext_t ctx;
    error = rtCtxGetCurrent(&ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Device *device = (Device *)((Context *)ctx)->Device_();
    device->SetTschVersion(2);
 
    typedef struct {
        uint32_t *hostAddr = nullptr;
        uint32_t *devAddr = nullptr;
    } memUnit;
    rtLabel_t label[3];
    const uint32_t ptrMemSize = 4;
 
    rtStream_t streamExe;
    rtStream_t stream[2];
    error = rtStreamCreate(&streamExe, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamCreateWithFlags(&stream[0], 5, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamCreateWithFlags(&stream[1], 5, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    rtModel_t model;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtLabelCreateV2(&label[0], model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtLabelCreateV2(&label[1], model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtLabelCreateV2(&label[2], model);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtModelBindStream(model, stream[0], 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelBindStream(model, stream[1], 0xFFFFFFFF);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    rtLabel_t labelInfo1[2];
    labelInfo1[0] = label[0];
    labelInfo1[1] = label[1];
    const uint32_t labelMax1 = 2;
    memUnit labelPtr;
    const uint32_t labelMemSize1 = sizeof(rtLabelDevInfo) * labelMax1;
    error = rtMalloc((void **)&labelPtr.devAddr, ptrMemSize, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtLabelListCpy(&labelInfo1[0], labelMax1, (void *)labelPtr.devAddr, labelMemSize1);
    EXPECT_NE(error, RT_ERROR_NONE);
 
    void *args[] = {&error, NULL};
    error = rtLabelSet(label[0], stream[1]);
    EXPECT_NE(error, RT_ERROR_NONE);
    error = rtLabelSet(label[1], stream[1]);
    EXPECT_NE(error, RT_ERROR_NONE);
 
    rtLabel_t labelInfo[2];
    labelInfo[0] = label[0];
    labelInfo[1] = label[1];
    const uint32_t labelMax = 2;
    const uint32_t labelMemSize = sizeof(rtLabelDevInfo) * labelMax;
    error = rtLabelListCpy(&labelInfo[0], labelMax, (void *)labelPtr.devAddr, labelMemSize);
    EXPECT_NE(error, RT_ERROR_NONE);
    error = rtFree(labelPtr.devAddr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelUnbindStream(model, stream[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelUnbindStream(model, stream[1]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtLabelDestroy(label[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtLabelDestroy(label[1]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtLabelDestroy(label[2]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream[0]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream[1]);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(streamExe);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, rtMemQueueInitQS)
{
    char grpName[] = "group_name";
    // normal
    rtError_t error = rtMemQueueInitQS(0, grpName);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest910b, rtMemQueueInitFlowGw)
{
    rtInitFlowGwInfo_t info = {nullptr, 0};
    // normal
    rtError_t error = rtMemQueueInitFlowGw(0, &info);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest910b, rtMemQueueCreate)
{
    EXPECT_EQ(RT_MQ_MAX_NAME_LEN, QUEUE_MAX_STR_LEN);
    uint32_t workMode = (uint32_t)QUEUE_MODE_PUSH;
    EXPECT_EQ(RT_MQ_MODE_PUSH, workMode);
    workMode = (uint32_t)QUEUE_MODE_PULL;
    EXPECT_EQ(RT_MQ_MODE_PULL, workMode);
 
    rtMemQueueAttr_t attr;
    memset_s(&attr, sizeof(attr), 0, sizeof(attr));
    attr.depth = RT_MQ_DEPTH_MIN;
    uint32_t qid = 0;
    // normal
    rtError_t error = rtMemQueueCreate(0, &attr, &qid);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid param
    error = rtMemQueueCreate(0, nullptr, &qid);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    error = rtMemQueueCreate(0, &attr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    attr.depth = 0;
    error = rtMemQueueCreate(0, &attr, &qid);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    attr.depth = RT_MQ_DEPTH_MIN;
    
}
 
TEST_F(ApiTest910b, rtMemQueueDestroy)
{
    // normal
    rtError_t error = rtMemQueueDestroy(0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    MOCKER(halQueueDestroy)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemQueueDestroy(0, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMemQueueInit)
{
    // normal
    rtError_t error = rtMemQueueInit(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtSetDefaultDeviceId(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMemQueueInit(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSetDefaultDeviceId(0xFFFFFFFF);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    MOCKER(halGetAPIVersion).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE)).then(invoke(halGetAPIVersionStub));
    error = rtMemQueueInit(0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    error = rtMemQueueInit(0);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
 
TEST_F(ApiTest910b, rtMemQueueEnQueue)
{
    // normal
    uint64_t value = 0;
    rtError_t error = rtMemQueueEnQueue(0, 0, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMemQueueEnQueue(0, 0, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    MOCKER(halQueueEnQueue)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemQueueEnQueue(0, 0, &value);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMemQueueDeQueue)
{
    // normal
    void *value = nullptr;
    rtError_t error = rtMemQueueDeQueue(0, 0, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMemQueueDeQueue(0, 0, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    MOCKER(halQueueDeQueue)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemQueueDeQueue(0, 0, &value);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMemQueuePeek)
{
    // normal
    size_t value = 0;
    rtError_t error = rtMemQueuePeek(0, 0, &value, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMemQueuePeek(0, 0, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    MOCKER(halQueuePeek)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemQueuePeek(0, 0, &value, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMemQueueEnQueueBuff)
{
    // normal
    rtMemQueueBuff_t buff = {nullptr};
    rtError_t error = rtMemQueueEnQueueBuff(0, 0, &buff, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMemQueueEnQueueBuff(0, 0, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    MOCKER(halQueueEnQueueBuff)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemQueueEnQueueBuff(0, 0, &buff, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910b, rtMemQueueEnQueueBuff_128)
{
    // normal
    rtMemQueueBuff_t queueBuf = {nullptr, 0, nullptr, 0};
    int32_t dataTmp = 0;
    rtMemQueueBuffInfo tmpInfo = {&dataTmp, sizeof(dataTmp)};
    std::vector<rtMemQueueBuffInfo> queueBufInfoVec;
    for (size_t i = 0U; i < 130; ++i) {
        queueBufInfoVec.push_back(tmpInfo);
    }
    queueBuf.buffCount = queueBufInfoVec.size();
    queueBuf.buffInfo = queueBufInfoVec.data();
    rtError_t error = rtMemQueueEnQueueBuff(0, 0, &queueBuf, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    MOCKER(drvMemcpy).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemQueueEnQueueBuff(0, 0, &queueBuf, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMemQueueDeQueueBuff)
{
    // normal
    rtMemQueueBuff_t buff = {nullptr};
    rtError_t error = rtMemQueueDeQueueBuff(0, 0, &buff, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMemQueueDeQueueBuff(0, 0, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    MOCKER(halQueueDeQueueBuff)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemQueueDeQueueBuff(0, 0, &buff, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMemQueueQueryInfo)
{
    // normal
    rtMemQueueInfo_t queInfo = {0};
    rtError_t error = rtMemQueueQueryInfo(0, 0, &queInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMemQueueQueryInfo(0, 0, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    MOCKER(halQueueQueryInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemQueueQueryInfo(0, 0, &queInfo);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMemQueueQuery)
{
    rtMemQueueQueryCmd_t queryCmd = (rtMemQueueQueryCmd_t)QUEUE_QUERY_QUE_ATTR_OF_CUR_PROC;
    EXPECT_EQ(RT_MQ_QUERY_QUE_ATTR_OF_CUR_PROC, queryCmd);
    queryCmd = (rtMemQueueQueryCmd_t)QUEUE_QUERY_QUES_OF_CUR_PROC;
    EXPECT_EQ(RT_MQ_QUERY_QUES_OF_CUR_PROC, queryCmd);
 
    // normal
    rtMemQueueBuff_t buff = {nullptr};
    rtMemQueueQueryCmd_t cmd = RT_MQ_QUERY_QUE_ATTR_OF_CUR_PROC;
    rtMemQueueShareAttr_t attr = {0};
    uint32_t pid = 0;
    uint32_t outLen = sizeof(attr);
    rtError_t error = rtMemQueueQuery(0, cmd, &pid, sizeof(pid), &attr, &outLen);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMemQueueQuery(0, cmd, nullptr, sizeof(pid), &attr, &outLen);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtMemQueueQuery(0, cmd, &pid, sizeof(pid), nullptr, &outLen);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtMemQueueQuery(0, cmd, &pid, sizeof(pid), &attr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    MOCKER(halQueueQuery)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemQueueQuery(0, cmd, &pid, sizeof(pid), &attr, &outLen);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMemQueueAttach)
{
    // normal
    rtError_t error = rtMemQueueAttach(0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    MOCKER(halQueueAttach)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemQueueAttach(0, 0, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMemGrpAddProc)
{
    // normal
    rtMemGrpShareAttr_t attr = {0};
    const char *name = "grp0";
    int32_t pid = 0;
    rtError_t error = rtMemGrpAddProc(name, pid, &attr);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMemGrpAddProc(nullptr, pid, &attr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtMemGrpAddProc(name, pid, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halGrpAddProc).stubs().will(returnValue(code));
    error = rtMemGrpAddProc(name, pid, &attr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMemGrpAttach)
{
    // normal
    const char *name = "grp0";
    int32_t timeout = 0;
    rtError_t error = rtMemGrpAttach(name, timeout);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMemGrpAttach(nullptr, timeout);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halGrpAttach).stubs().will(returnValue(code));
    error = rtMemGrpAttach(name, timeout);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMemGrpCacheAlloc)
{
    // normal
    rtMemGrpCacheAllocPara para = {};
    const int32_t devId = 0;
    const char *name = "grp0";
    rtError_t error = rtMemGrpCacheAlloc(name, devId, &para);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMemGrpCacheAlloc(nullptr, devId, &para);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtMemGrpCacheAlloc(name, devId, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halGrpCacheAlloc).stubs().will(returnValue(code));
    error = rtMemGrpCacheAlloc(name, devId, &para);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMemQueueSet)
{
    // normal
    rtMemQueueSetInputPara para = {};
    rtError_t error = rtMemQueueSet(0, RT_MQ_QUEUE_ENABLE_LOCAL_QUEUE, &para);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMemQueueSet(0, RT_MQ_QUEUE_ENABLE_LOCAL_QUEUE, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halQueueSet)
        .stubs()
        .will(returnValue(code));
    error = rtMemQueueSet(0, RT_MQ_QUEUE_ENABLE_LOCAL_QUEUE, &para);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910b, rtMemGrpCreate)
{
    // normal
    rtMemGrpConfig_t cfg = {0};
    const char *name = "grp0";
    rtError_t error = rtMemGrpCreate(name, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMemGrpCreate(nullptr, &cfg);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtMemGrpCreate(name, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halGrpCreate).stubs().will(returnValue(code));
    error = rtMemGrpCreate(name, &cfg);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMemGrpQuery)
{
    uint32_t value = (uint32_t)GRP_QUERY_GROUPS_OF_PROCESS;
    EXPECT_EQ(RT_MEM_GRP_QUERY_GROUPS_OF_PROCESS, value);
    EXPECT_EQ(RT_MEM_GRP_NAME_LEN, BUFF_GRP_NAME_LEN);
 
    // normal
    rtMemGrpQueryInput_t input;
    input.cmd = RT_MEM_GRP_QUERY_GROUPS_OF_PROCESS;
    input.grpQueryByProc.pid = 0;
    rtMemGrpOfProc_t proc[5];
    memset_s(&proc, sizeof(proc), 0, sizeof(proc));
    rtMemGrpQueryOutput_t output;
    output.maxNum = 5;
    output.groupsOfProc = &proc[0];
    output.resultNum = 0;
    rtError_t error = rtMemGrpQuery(&input, &output);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMemGrpQuery(nullptr, &output);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtMemGrpQuery(&input, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halGrpQuery).stubs().will(returnValue(code));
    error = rtMemGrpQuery(&input, &output);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMemGrpQuery_addrInfo)
{
    // normal
    rtMemGrpQueryInput_t input;
    input.cmd = RT_MEM_GRP_QUERY_GROUP_ADDR_INFO;
    input.grpQueryGroupAddrPara.devId = 0;
 
    rtMemGrpQueryGroupAddrInfo_t addrInfo;
    memset_s(&addrInfo, sizeof(addrInfo), 0, sizeof(addrInfo));
 
    rtMemGrpQueryOutput_t output;
    output.maxNum = 1;
    output.groupAddrInfo = &addrInfo;
    output.resultNum = 0;
    rtError_t error = rtMemGrpQuery(&input, &output);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest910b, rtMemGrpQuery_addrInfo_maxGrp)
{
    rtMemGrpQueryInput_t input;
    input.cmd = RT_MEM_GRP_QUERY_GROUP_ADDR_INFO;
    input.grpQueryGroupAddrPara.devId = 0;
 
    const std::unique_ptr<rtMemGrpQueryGroupAddrInfo_t[]> addrInfo(new (std::nothrow)
                                                                       rtMemGrpQueryGroupAddrInfo_t[BUFF_GRP_MAX_NUM]);
    memset_s(reinterpret_cast<rtMemGrpQueryGroupAddrInfo_t *>(addrInfo.get()),
             sizeof(rtMemGrpQueryGroupAddrInfo_t) * BUFF_GRP_MAX_NUM, 0x0,
             sizeof(rtMemGrpQueryGroupAddrInfo_t) * BUFF_GRP_MAX_NUM);
 
    rtMemGrpQueryOutput_t output;
    output.maxNum = BUFF_GRP_MAX_NUM + 1U;
    output.groupAddrInfo = reinterpret_cast<rtMemGrpQueryGroupAddrInfo_t *>(addrInfo.get());
    output.resultNum = 0U;
    unsigned int outLen = (sizeof(GrpQueryGroupAddrInfo) * (BUFF_GRP_MAX_NUM + 1U));
    MOCKER(halGrpQuery)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&outLen, sizeof(outLen)))
        .will(returnValue(RT_ERROR_NONE));
    rtError_t error = rtMemGrpQuery(&input, &output);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest910b, rtMemGrpQuery_grpId)
{
    uint32_t value = (uint32_t)GRP_QUERY_GROUP_ID;
    EXPECT_EQ(RT_MEM_GRP_QUERY_GROUP_ID, value);
    EXPECT_EQ(RT_MEM_GRP_NAME_LEN, BUFF_GRP_NAME_LEN);
 
    // normal
    rtMemGrpQueryInput_t input;
    input.cmd = GRP_QUERY_GROUP_ID;
    strcpy(input.grpQueryGroupId.grpName, "test name");
    rtMemGrpQueryGroupIdInfo_t proc[5];
    memset_s(&proc, sizeof(proc), 0, sizeof(proc));
    rtMemGrpQueryOutput_t output;
    output.maxNum = 5;
    output.groupIdInfo = &proc[0];
    output.resultNum = 0;
    rtError_t error = rtMemGrpQuery(&input, &output);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMemGrpQuery(nullptr, &output);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtMemGrpQuery(&input, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halGrpQuery).stubs().will(returnValue(code));
    error = rtMemGrpQuery(&input, &output);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtMemQueueGetQidByName)
{
    int32_t device = 0;
    char name[] = "buffer_group";
    uint32_t qid = 0;
 
    rtError_t error = rtMemQueueGetQidByName(device, name, &qid);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // invalid paramter
    error = rtMemQueueGetQidByName(device, nullptr, &qid);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtMemQueueGetQidByName(device, name, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    drvError_t code = DRV_ERROR_INVALID_VALUE;
    MOCKER(halQueueGetQidbyName).stubs().will(returnValue(code));
    error = rtMemQueueGetQidByName(device, name, &qid);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rtQueueSubscribe)
{
    int32_t device = 0;
    uint32_t qid = 0;
    uint32_t groupId = 1;
    int type = 2;  //QUEUE_TYPE
 
    MOCKER(NpuDriver::QueueSubscribe).stubs().will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    rtError_t error = rtQueueSubscribe(device, qid, groupId, type);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
 
TEST_F(ApiTest910b, rtQueueSubF2NFEvent)
{
    int32_t device = 0;
    uint32_t qid = 0;
    uint32_t groupId = 1;
 
    MOCKER(NpuDriver::QueueSubF2NFEvent).stubs().will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    rtError_t error = rtQueueSubF2NFEvent(device, qid, groupId);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
 
TEST_F(ApiTest910b, rtGetTsMemType)
{
    uint32_t memType = 0U;
    memType = rtGetTsMemType(MEM_REQUEST_FEATURE_DEFAULT, 1024U);
 
    EXPECT_EQ(memType, RT_MEMORY_HBM);
}

TEST_F(ApiTest910b, rtProfilingCommandHandle)
{
    void *data = malloc(8);
    uint32_t len = 8;
 
    rtError_t error = rtProfilingCommandHandle(0, data, len);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    error = rtProfilingCommandHandle(1, data, len);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    free(data);
}
 
TEST_F(ApiTest910b, rtProfilingCommandHandle_02)
{
    rtProfCommandHandle_t profilerConfig;
    memset_s(&profilerConfig, sizeof(rtProfCommandHandle_t), 0, sizeof(rtProfCommandHandle_t));
    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_START;
    profilerConfig.profSwitch = 1;
    profilerConfig.devNums = 1;
    rtError_t error =
        rtProfilingCommandHandle(PROF_CTRL_SWITCH, (void *)(&profilerConfig), sizeof(rtProfCommandHandle_t));
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);
}
 
TEST_F(ApiTest910b, rtProfilingCommandHandle_03)
{
    rtProfCommandHandle_t profilerConfig;
    memset_s(&profilerConfig, sizeof(rtProfCommandHandle_t), 0, sizeof(rtProfCommandHandle_t));
    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_STOP;
    profilerConfig.profSwitch = 1;
    profilerConfig.devNums = 1;
    rtError_t error =
        rtProfilingCommandHandle(PROF_CTRL_SWITCH, (void *)(&profilerConfig), sizeof(rtProfCommandHandle_t));
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);
}
 
TEST_F(ApiTest910b, rtProfilerInit)
{
    rtError_t error = rtProfilerInit(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
 
TEST_F(ApiTest910b, rtProfilerConfig)
{
    rtError_t error;
    uint16_t type = 0;
 
    error = rtProfilerConfig(type);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
 
TEST_F(ApiTest910b, rtsFreeAddress_null)
{
    rtError_t error;
    error = rtsMemFreePhysical(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsMemFreeAddress(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest910b, rts_st_notify_with_flag_notsupport)
{
    rtNotify_t notify;
    rtError_t error;
    int32_t device_id = 0;
 
    error = rtNotifyCreateWithFlag(device_id, &notify, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtNotifyDestroy(notify);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest910b, rtLabelGotoEx)
{
    rtError_t error;
 
    ApiImpl *apiImpl = new ApiImpl();
    ApiDecorator api(apiImpl);
 
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LabelGotoEx).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
 
    error = api.LabelGotoEx(NULL, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);
 
    error = rtLabelGotoEx(NULL, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);
 
    GlobalMockObject::verify();
    delete apiImpl;
}
 
TEST_F(ApiTest910b, rtLabelListCpy)
{
    rtError_t error;
 
    ApiImpl *apiImpl = new ApiImpl();
    ApiDecorator api(apiImpl);
 
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LabelListCpy).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
 
    error = api.LabelListCpy(NULL, 0, NULL, 0);
    EXPECT_NE(error, RT_ERROR_NONE);
 
    error = rtLabelListCpy(NULL, 0, NULL, 0);
    EXPECT_NE(error, RT_ERROR_NONE);
 
    GlobalMockObject::verify();
    delete apiImpl;
}
 
TEST_F(ApiTest910b, rtLabelCreateEx)
{
    rtError_t error;
    rtLabel_t labelEx;
    rtStream_t stream;
 
    rtModel_t model;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtLabelCreateExV2(&labelEx, model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtLabelDestroy(labelEx);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *stream_var = static_cast<Stream *>(stream);
    stream_var->pendingNum_.Set(0);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest910b, rtGetPriCtxByDeviceId)
{
    rtContext_t ctx;
    rtError_t error;
 
    error = rtGetPriCtxByDeviceId(0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
 
    error = rtGetPriCtxByDeviceId(0, &ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtGetPriCtxByDeviceId(65, &ctx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910b, rtModelCheckCompatibility_socVersion)
{
    rtError_t error;
    char version[50] = {0};
 
    memset_s(version, 50, 0, 50);
    error = rtGetSocVersion(version, 50);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // OMSocVersion is null
    error = rtModelCheckCompatibility("", "10");
    EXPECT_EQ(error, ACL_ERROR_RT_SOC_VERSION);
    // OMSocVersion is nullptr
    error = rtModelCheckCompatibility(nullptr, "10");
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910b, rtModelCheckCompatibility_archVersion)
{
    rtError_t error;
    error = rtModelCheckCompatibility("SOC_Ascend910B1", "3");
    EXPECT_EQ(error, ACL_ERROR_RT_SOC_VERSION);
}

TEST_F(ApiTest910b, rtGetPairDevicesInfo)
{
    rtError_t error;
    int64_t value = 0;
 
    error = rtGetPairDevicesInfo(0, 1, 0, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtGetPairDevicesInfo(0, 1, 0, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    MOCKER(halGetPairDevicesInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE))
        .then(returnValue(DRV_ERROR_NOT_SUPPORT));
 
    error = rtGetPairDevicesInfo(0, 1, 0, &value);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    error = rtGetPairDevicesInfo(0, 1, 0, &value);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
 
TEST_F(ApiTest910b, rtGetPairPhyDevicesInfo)
{
    rtError_t error;
    int64_t value = 0;
 
    error = rtGetPairPhyDevicesInfo(0, 1, 0, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtGetPairPhyDevicesInfo(0, 1, 0, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910b, rtLaunchSqeUpdateTask_FEATURE_SUPPORT)
{
    rtError_t error;
    uint32_t streamId = 1U;
    uint32_t taskId = 1U;
    uint64_t src_addr = 0U;
    uint64_t cnt = 40U;
 
    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtLaunchSqeUpdateTask(streamId, taskId, reinterpret_cast<void *>(src_addr), cnt, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    Stream *stream_var = static_cast<Stream *>(stream);
    stream_var->pendingNum_.Set(0);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, rtMemAddress)
{
    rtError_t error = rtReserveMemAddress(nullptr, 0, 0, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    error = rtReleaseMemAddress(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDrvMemHandle handVal;
    rtDrvMemProp_t prop = {};
    prop.mem_type = 1;
    prop.pg_type = 1;
    rtDrvMemHandle *handle = &handVal;
    error = rtMallocPhysical(handle, 0, &prop, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtFreePhysical(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtMapMem(nullptr, 0, 0, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtUnmapMem(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
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
 
    MOCKER(halMemGetAllocationGranularity).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemGetAllocationGranularity(&prop, RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    GlobalMockObject::verify();
}

TEST_F(ApiTest910b, rtOperateWithHostid)
{
    rtBindHostpidInfo info = {};
    rtError_t error = rtBindHostPid(info);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtUnbindHostPid(info);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtQueryProcessHostPid(0, nullptr, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    uint32_t chipId = UINT32_MAX;
    error = rtQueryProcessHostPid(0, &chipId, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest910b, rtMemcpyD2DAddrAsync)
{
    rtError_t error;
    void *srcPtr;
    void *dstPtr;
    error = rtMalloc(&srcPtr, 64, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtMalloc(&dstPtr, 64, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtMemcpyD2DAddrAsync(dstPtr, 64, 0, srcPtr, 1, 0, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
 
    error = rtFree(srcPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtFree(dstPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest910b, rtLabel_CreateEx)
{
    rtError_t error;
    error = rtLabelCreateEx(NULL, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTest910b, rtNpuGetFloatDebugStatus)
{
    void *descBuf = malloc(8);  // device memory
    uint64_t descBufLen = 64;
    uint32_t checkmode = 0;
    FeatureToTsVersionInit();
 
    std::vector<uintptr_t> input;
    input.push_back(reinterpret_cast<uintptr_t>(descBuf));
    input.push_back(static_cast<uintptr_t>(descBufLen));
    input.push_back(static_cast<uintptr_t>(checkmode));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));

    rtError_t error = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_NPU_GET_FLOAT_DEBUG_STATUS);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    free(descBuf);
}

TEST_F(ApiTest910b, rtNpuGetFloatDebugStatus_02)
{
    void *descBuf = malloc(8);  // device memory
    uint64_t descBufLen = 64;
    uint32_t checkmode = 0;
 
    std::vector<uintptr_t> input;
    input.push_back(reinterpret_cast<uintptr_t>(descBuf));
    input.push_back(static_cast<uintptr_t>(descBufLen));
    input.push_back(static_cast<uintptr_t>(checkmode));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));
    rtError_t error = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_NPU_GET_FLOAT_DEBUG_STATUS);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    free(descBuf);
}

TEST_F(ApiTest910b, rtNpuClearFloatDebugStatus_02)
{
    uint32_t checkmode = 0;
    std::vector<uintptr_t> input;
    input.push_back(static_cast<uintptr_t>(checkmode));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));
    rtError_t error = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_NPU_CLEAR_FLOAT_DEBUG_STATUS);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTest910b, rtMemAddress_01)
{
    rtError_t error = rtReserveMemAddress(nullptr, 0, 0, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    error = rtReleaseMemAddress(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDrvMemHandle handVal;
    rtDrvMemProp_t prop = {};
    prop.mem_type = 1;
    prop.pg_type = 1;
    rtDrvMemHandle *handle = &handVal;
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
 
    MOCKER(halMemGetAllocationGranularity).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemGetAllocationGranularity(&prop, RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    GlobalMockObject::verify();
}

TEST_F(ApiTest910b, rtsDvppLaunch_test_01)
{
    rtError_t error;
    void *args[] = {&error, NULL};
    void *stubFunc;
 
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
 
    error = rtLaunchDvppTask(nullptr, 0, stream_, nullptr);
    EXPECT_NE(error, RT_ERROR_INVALID_VALUE);
}
 
TEST_F(ApiTest910b, rtsDvppLaunch_test_02)
{
    rtError_t error;
    void *args[] = {&error, NULL};
    void *stubFunc;
 
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    cce::runtime::rtStarsCommonSqe_t sqe = {};
    sqe.sqeHeader.type = RT_STARS_SQE_TYPE_VPC;
    rtDvppAttr_t attr = {RT_DVPP_CMDLIST_NOT_FREE, true};
    rtDvppCfg_t cfg = {&attr, 1};
    error = rtLaunchDvppTask(&sqe, sizeof(cce::runtime::rtStarsCommonSqe_t), stream_, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest910b, rtsCmoAsyncWithBarrier_test)
{
    uint64_t srcAddr = 0;
    uint32_t logicId = 1;
    // srcAddr is nullptr
    rtError_t error = rtsCmoAsyncWithBarrier(nullptr, 4, RT_CMO_PREFETCH, logicId, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
 
    // srcLen is zero invalid
    error = rtsCmoAsyncWithBarrier(&srcAddr, 0, RT_CMO_INVALID, logicId, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
 
    // prefetch, writeback, flush, can't set logicId
    error = rtsCmoAsyncWithBarrier(&srcAddr, 4, RT_CMO_PREFETCH, logicId, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    error = rtsCmoAsyncWithBarrier(&srcAddr, 4, RT_CMO_FLUSH, logicId, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    error = rtsCmoAsyncWithBarrier(&srcAddr, 4, RT_CMO_WRITEBACK, logicId, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    // upsupport cmotype
    error = rtsCmoAsyncWithBarrier(&srcAddr, 4, RT_CMO_RESERVED, logicId, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
 
    // invalid op, but logicId is 0
    error = rtsCmoAsyncWithBarrier(&srcAddr, 4, RT_CMO_INVALID, 0, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
 
    // success case
    error = rtsCmoAsyncWithBarrier(&srcAddr, 4, RT_CMO_PREFETCH, 0, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    error = rtsCmoAsyncWithBarrier(&srcAddr, 4, RT_CMO_INVALID, logicId, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
 
TEST_F(ApiTest910b, rts_memroy_attritue_fail)
{
    rtError_t error;
    void *hostPtr;
    rtPtrAttributes_t attributes;
 
    error = rtMallocHost(&hostPtr, 60, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_2));
 
    error = rtsPointerGetAttributes(hostPtr, &attributes);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtFreeHost(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtsPointerGetAttributes(NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rts_get_bin_and_stack_buffer)
{
    unsigned char *m_data = g_m_data;
    size_t m_len = sizeof(g_m_data) / sizeof(g_m_data[0]);
    rtBinHandle bin_handle = nullptr;
    rtDevBinary_t bin;
    bin.magic = RT_DEV_BINARY_MAGIC_ELF_AICUBE;
    bin.version = 2;
    bin.data = m_data;
    bin.length = m_len;
    EXPECT_EQ(rtBinaryLoad(&bin, &bin_handle), RT_ERROR_NONE);
 
    ApiImpl impl;
    ApiDecorator api(&impl);
    void *outputBin = nullptr;
    uint32_t binSize = 0U;
    EXPECT_EQ(rtsBinaryGetDevAddress(bin_handle, &outputBin, &binSize), RT_ERROR_NONE);
    EXPECT_EQ(binSize, m_len);
 
    const void *stack = nullptr;
    uint32_t stackSize = 0U;
    EXPECT_EQ(rtsGetStackBuffer(bin_handle, RT_CORE_TYPE_AIC, 0, &stack, &stackSize), RT_ERROR_NONE);
    EXPECT_EQ(rtsGetStackBuffer(bin_handle, RT_CORE_TYPE_AIV, 0, &stack, &stackSize), RT_ERROR_NONE);
    EXPECT_EQ(api.GetStackBuffer(bin_handle, RT_CORE_TYPE_AIV, 0, &stack, &stackSize), RT_ERROR_NONE);
    EXPECT_EQ(rtBinaryUnLoad(bin_handle), RT_ERROR_NONE);
}
 
TEST_F(ApiTest910b, rts_callback_subscribe_interface)
{
    rtError_t error;
    rtStream_t stream;
 
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtsSubscribeReport(1, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtsUnSubscribeReport(1, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *stream_var = static_cast<Stream *>(stream);
    stream_var->pendingNum_.Set(0);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest910b, rts_memory_attritue_1)
{
    rtError_t error;
    void *hostPtr;
    rtPtrAttributes_t attributes;
 
    error = rtMallocHost(&hostPtr, 60, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_1));
    error = rtsPointerGetAttributes(hostPtr, &attributes);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
 
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_2));
    error = rtsPointerGetAttributes(hostPtr, &attributes);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
 
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_3));
    error = rtsPointerGetAttributes(hostPtr, &attributes);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
 
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_4));
    error = rtsPointerGetAttributes(hostPtr, &attributes);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
 
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_5));
    error = rtsPointerGetAttributes(hostPtr, &attributes);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
 
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_6));
    error = rtsPointerGetAttributes(hostPtr, &attributes);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
 
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_7));
    error = rtsPointerGetAttributes(hostPtr, &attributes);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
 
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_8));
    error = rtsPointerGetAttributes(hostPtr, &attributes);
    EXPECT_NE(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
 
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_2));
    error = rtFreeHost(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest910b, rts_memory_attritue_2)
{
    rtError_t error;
    void *hostPtr;
    rtPtrAttributes_t attributes;
 
    error = rtMallocHost(&hostPtr, 60, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    MOCKER(drvMemGetAttribute).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
 
    error = rtsPointerGetAttributes(hostPtr, &attributes);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    error = rtFreeHost(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtsPointerGetAttributes(NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest910b, rts_memory_attritue_3)
{
    rtError_t error;
    void *hostPtr;
    rtPtrAttributes_t attributes;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    bool tmp = rtInstance->isHaveDevice_;
    rtInstance->isHaveDevice_ = false;
 
    error = rtMallocHost(&hostPtr, 60, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    MOCKER(drvMemGetAttribute).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
 
    error = rtsPointerGetAttributes(hostPtr, &attributes);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    error = rtFreeHost(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtsPointerGetAttributes(NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    rtInstance->isHaveDevice_ = tmp;
}
 
TEST_F(ApiTest910b, rts_memory_attritue_4)
{
    rtError_t error;
    void *hostPtr;
    rtPtrAttributes_t attributes;
 
    error = rtMallocHost(&hostPtr, 60, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(false));
 
    error = rtsPointerGetAttributes(hostPtr, &attributes);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(true));
 
    error = rtsPointerGetAttributes(hostPtr, &attributes);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtFreeHost(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest910b, rts_memory_reallocation)
{
    rtError_t error;
    void *hostPtr;
    rtMemLocationType location;
    rtMemLocationType realLocation;
 
    NpuDriver drv;
 
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_1));
    error = drv.PtrGetRealLocation(hostPtr, location, realLocation);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
 
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_2));
    error = drv.PtrGetRealLocation(hostPtr, location, realLocation);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
 
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_3));
    error = drv.PtrGetRealLocation(hostPtr, location, realLocation);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
 
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_4));
    error = drv.PtrGetRealLocation(hostPtr, location, realLocation);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
 
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_5));
    error = drv.PtrGetRealLocation(hostPtr, location, realLocation);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
 
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_6));
    error = drv.PtrGetRealLocation(hostPtr, location, realLocation);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
 
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_7));
    error = drv.PtrGetRealLocation(hostPtr, location, realLocation);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
 
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_8));
    error = drv.PtrGetRealLocation(hostPtr, location, realLocation);
    EXPECT_NE(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
}

TEST_F(ApiTest910b, get_taskid_streamid)
{
    uint32_t streamid;
    uint32_t taskid;
    rtError_t error;

    error = rtGetTaskIdAndStreamID(&taskid, &streamid);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetTaskIdAndStreamID(NULL, &streamid);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtGetTaskIdAndStreamID(&taskid, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, rtGetMaxModelNum)
{
    rtError_t error;
    uint32_t maxModelCount;
    MOCKER_CPP(&ApiImpl::CurrentContext)
        .stubs()
        .will(invoke(CurrentContextStub));
    ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(true);
    error = rtGetMaxModelNum(&maxModelCount);
    ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910b, rtGetMaxModelNum2)
{
    rtError_t error;
    uint32_t maxModelCount;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    bool oldHaveDevice = rtInstance->isHaveDevice_;
    bool oldOffline = rtInstance->GetIsUserSetSocVersion();
    rtInstance->isHaveDevice_ = false;
    rtInstance->SetIsUserSetSocVersion(false);
    error = rtGetMaxModelNum(&maxModelCount);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    rtInstance->isHaveDevice_ = true;
    rtInstance->SetIsUserSetSocVersion(true);
    error = rtGetMaxModelNum(&maxModelCount);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->isHaveDevice_ = oldHaveDevice;
    rtInstance->SetIsUserSetSocVersion(oldOffline);
}

TEST_F(ApiTest910b, rts_api_get_taskid)
{
    uint32_t taskid;
    rtError_t error = rtsGetThreadLastTaskId(&taskid);
    EXPECT_EQ(error, RT_ERROR_NONE);
}