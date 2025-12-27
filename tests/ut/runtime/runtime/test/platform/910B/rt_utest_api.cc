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
#include "../../data/elf.h"

class CloudV2ApiTest : public testing::Test
{
public:
    static rtStream_t stream_;
    static rtEvent_t  event_;
    static void      *binHandle_;
    static char       function_;
    static uint32_t   binary_[32];
    static Driver*    driver_;
protected:
    static void SetUpTestCase()
    {
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
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

        std::cout<<"Cloudv2 api test start:"<<error1<<", "<<error2<<", "<<error3<<", "<<error4<<std::endl;
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
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
    }

    virtual void TearDown()
    {
         GlobalMockObject::verify();
    }
};
rtStream_t CloudV2ApiTest::stream_ = NULL;
rtEvent_t CloudV2ApiTest::event_ = NULL;
void* CloudV2ApiTest::binHandle_ = nullptr;
char  CloudV2ApiTest::function_ = 'a';
uint32_t CloudV2ApiTest::binary_[32] = {};
Driver* CloudV2ApiTest::driver_ = NULL;

TEST_F(CloudV2ApiTest, memcpyex_host_to_device)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    size_t free;
    size_t total;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyEx(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, memcpy_async_qos_910_B_93)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // RTS_MEMCPYASYNC_QOS_CONFIG_01, set qos null
    rtTaskCfgInfo_t *taskCfgInfoPtr = nullptr;

    error = rtMemcpyAsyncWithCfgV2(devPtr, 64, hostPtr, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, taskCfgInfoPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);


    // RTS_MEMCPYASYNC_QOS_CONFIG_02, config qos, but not config flag
    rtTaskCfgInfo_t taskCfgInfo = {};
    taskCfgInfo.qos = 2;
    taskCfgInfo.partId = 2;

    error = rtMemcpyAsyncWithCfgV2(devPtr, 64, hostPtr, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, &taskCfgInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // RTS_MEMCPYASYNC_QOS_CONFIG_03, not config qos, config flag = 1
    rtTaskCfgInfo_t taskCfgInfo1 = {};
    taskCfgInfo1.d2dCrossFlag = 1;
    error = rtMemcpyAsyncWithCfgV2(devPtr, 64, hostPtr, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, &taskCfgInfo1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // RTS_MEMCPYASYNC_QOS_CONFIG_04, not config qos, config flag = 0
    taskCfgInfo1.d2dCrossFlag = 0;
    error = rtMemcpyAsyncWithCfgV2(devPtr, 64, hostPtr, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, &taskCfgInfo1);
    EXPECT_EQ(error, RT_ERROR_NONE);


    // RTS_MEMCPYASYNC_QOS_CONFIG_05, config qos, config flag = 0
    taskCfgInfo1.qos = 3;
    taskCfgInfo1.partId = 3;
    error = rtMemcpyAsyncWithCfgV2(devPtr, 64, hostPtr, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, &taskCfgInfo1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // RTS_MEMCPYASYNC_QOS_CONFIG_06, config qos, config flag = 1
    taskCfgInfo1.d2dCrossFlag = 1;
    taskCfgInfo1.qos = 4;
    taskCfgInfo1.partId = 4;
    error = rtMemcpyAsyncWithCfgV2(devPtr, 64, hostPtr, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, &taskCfgInfo1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // RTS_MEMCPYASYNC_QOS_CONFIG_07, config invalid qos
    taskCfgInfo1.qos = 1000;
    error = rtMemcpyAsyncWithCfgV2(devPtr, 64, hostPtr, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, &taskCfgInfo1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    taskCfgInfo1.qos = -2;
    error = rtMemcpyAsyncWithCfgV2(devPtr, 64, hostPtr, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, &taskCfgInfo1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // RTS_MEMCPYASYNC_QOS_CONFIG_08, config invalid flag
    taskCfgInfo1.qos = 5;
    taskCfgInfo1.partId = 5;
    taskCfgInfo1.d2dCrossFlag = 10;

    error = rtMemcpyAsyncWithCfgV2(devPtr, 64, hostPtr, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, &taskCfgInfo1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // RTS_MEMCPYASYNC_QOS_CONFIG_09, config copy type != D2D
    taskCfgInfo1.d2dCrossFlag = 1;
    error = rtMemcpyAsyncWithCfgV2(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE, stream_, &taskCfgInfo1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, memory_advise)
{
    rtError_t error;
    uint64_t size = 128;
    void *ptr = NULL;
    Api* oldApi_ = Runtime::runtime_->api_;
    Profiler *profiler = new Profiler(oldApi_);
    profiler->Init();

    MOCKER(halMemAdvise)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));

    error = rtMemAllocManaged(&ptr, size, 0, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemAdvise(ptr, 100, 100);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtMemAdvise(ptr, 100, 100);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = profiler->apiProfileDecorator_->MemAdvise(ptr, 100, 100);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = profiler->apiProfileLogDecorator_->MemAdvise(ptr, 100, 100);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemFreeManaged(ptr);
    delete profiler;
}
TEST_F(CloudV2ApiTest, ipc_memory_success){
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    g_isAddrFlatDevice = true;

    error = rtIpcSetMemoryAttr("mem1", RT_ATTR_TYPE_MEM_MAP, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CloudV2ApiTest, LAUNCH_ALL_KERNEL_TEST_2)
{
    rtError_t error;
    void *handle;
    Program *prog;
    rtDevBinary_t bin;
    bin.magic = RT_DEV_BINARY_MAGIC_ELF;
    bin.version = 2;
    bin.data = (void*)elf_o;
    bin.length = elf_o_len;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtDevBinaryRegister(&bin, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // constructing dynamic shape kernel
    prog = (Program *)handle;
    Kernel *kernelPtr = new (std::nothrow) Kernel(NULL, "", 355, prog, 10);
    if (NULL == kernelPtr)
    {
        error = rtStreamSynchronize(NULL);
        EXPECT_EQ(error, RT_ERROR_NONE);

        error = rtDevBinaryUnRegister(handle);
        EXPECT_EQ(error, RT_ERROR_NONE);

        printf("kernelPtr is null\n");
        return;
    }

    const uint32_t nameOffset = prog->AppendKernelName("355");
    kernelPtr->SetNameOffset(nameOffset);

    prog->kernelCount_ = 1;
    if (prog->KernelTable_ == nullptr) {
        prog->KernelTable_ = new rtKernelArray_t[1];
    }
    error = prog->AllKernelAdd(kernelPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // api test
    void * addr = NULL;
    uint32_t cnt = 0U;
    error = rtKernelGetAddrAndPrefCnt(handle, 355, NULL, RT_DYNAMIC_SHAPE_KERNEL, &addr, &cnt);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDevBinaryUnRegister(handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
TEST_F(CloudV2ApiTest, LAUNCH_ALL_KERNEL_TEST_2_V2)
{
    rtError_t error;
    void *handle;
    Program *prog;
    rtDevBinary_t bin;
    bin.magic = RT_DEV_BINARY_MAGIC_ELF;
    bin.version = 2;
    bin.data = (void*)elf_o;
    bin.length = elf_o_len;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    error = rtDevBinaryRegister(&bin, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // constructing dynamic shape kernel
    prog = (Program *)handle;
    Kernel *kernelPtr = new (std::nothrow) Kernel(NULL, "", 355, prog, 10);
    if (NULL == kernelPtr)
    {
        error = rtStreamSynchronize(NULL);
        EXPECT_EQ(error, RT_ERROR_NONE);

        error = rtDevBinaryUnRegister(handle);
        EXPECT_EQ(error, RT_ERROR_NONE);

        printf("kernelPtr is null\n");
        return;
    }

    const uint32_t nameOffset = prog->AppendKernelName("355");
    kernelPtr->SetNameOffset(nameOffset);

    prog->kernelCount_ = 1;
    if (prog->KernelTable_ == nullptr) {
        prog->KernelTable_ = new rtKernelArray_t[1];
    }
    error = prog->AllKernelAdd(kernelPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // api test
    rtKernelDetailInfo_t kernelInfo;
    rtFunctionInfo_t *functionInfo = kernelInfo.functionInfo;
    functionInfo[0].pcAddr = NULL;
    functionInfo[1].pcAddr = NULL;
    functionInfo[0].prefetchCnt = 0U;
    functionInfo[1].prefetchCnt = 0U;
    error = rtKernelGetAddrAndPrefCntV2(handle, DEFAULT_TILING_KEY, NULL, RT_DYNAMIC_SHAPE_KERNEL, &kernelInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtKernelGetAddrAndPrefCntV2(handle, 355, NULL, RT_DYNAMIC_SHAPE_KERNEL, &kernelInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDevBinaryUnRegister(handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
TEST_F(CloudV2ApiTest, LAUNCH_ALL_KERNEL_TEST_2_V2_error1)
{
    rtError_t error;
    void *handle;
    Program *prog;
    rtDevBinary_t bin;
    bin.magic = RT_DEV_BINARY_MAGIC_ELF;
    bin.version = 2;
    bin.data = (void*)elf_o;
    bin.length = elf_o_len;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    error = rtDevBinaryRegister(&bin, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // constructing dynamic shape kernel
    prog = (Program *)handle;
    Kernel *kernelPtr = new (std::nothrow) Kernel(NULL, "", 355, prog, 10);
    if (NULL == kernelPtr)
    {
        error = rtStreamSynchronize(NULL);
        EXPECT_EQ(error, RT_ERROR_NONE);

        error = rtDevBinaryUnRegister(handle);
        EXPECT_EQ(error, RT_ERROR_NONE);

        printf("kernelPtr is null\n");
        return;
    }

    const uint32_t nameOffset = prog->AppendKernelName("355");
    kernelPtr->SetNameOffset(nameOffset);

    prog->kernelCount_ = 1;
    if (prog->KernelTable_ == nullptr) {
        prog->KernelTable_ = new rtKernelArray_t[1];
    }
    error = prog->AllKernelAdd(kernelPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // api test
    rtKernelDetailInfo_t kernelInfo;
    rtFunctionInfo_t *functionInfo = kernelInfo.functionInfo;
    functionInfo[0].pcAddr = NULL;
    functionInfo[1].pcAddr = NULL;
    functionInfo[0].prefetchCnt = 0U;
    functionInfo[1].prefetchCnt = 0U;

    MOCKER_CPP(&Runtime::KernelLookup).stubs().will(returnValue(nullptr));
    error = rtKernelGetAddrAndPrefCntV2(handle, NULL, NULL, RT_DYNAMIC_SHAPE_KERNEL, &kernelInfo);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDevBinaryUnRegister(handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
TEST_F(CloudV2ApiTest, LAUNCH_ALL_KERNEL_TEST_2_V2_error2)
{
    rtError_t error;
    void *handle;
    Program *prog;
    rtDevBinary_t bin;
    bin.magic = RT_DEV_BINARY_MAGIC_ELF;
    bin.version = 2;
    bin.data = (void*)elf_o;
    bin.length = elf_o_len;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    error = rtDevBinaryRegister(&bin, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // constructing dynamic shape kernel
    prog = (Program *)handle;
    Kernel *kernelPtr = new (std::nothrow) Kernel(NULL, "", 355, prog, 10);
    if (NULL == kernelPtr)
    {
        error = rtStreamSynchronize(NULL);
        EXPECT_EQ(error, RT_ERROR_NONE);

        error = rtDevBinaryUnRegister(handle);
        EXPECT_EQ(error, RT_ERROR_NONE);

        printf("kernelPtr is null\n");
        return;
    }

    const uint32_t nameOffset = prog->AppendKernelName("355");
    kernelPtr->SetNameOffset(nameOffset);

    prog->kernelCount_ = 1;
    if (prog->KernelTable_ == nullptr) {
        prog->KernelTable_ = new rtKernelArray_t[1];
    }
    error = prog->AllKernelAdd(kernelPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // api test
    rtKernelDetailInfo_t kernelInfo;
    rtFunctionInfo_t *functionInfo = kernelInfo.functionInfo;
    functionInfo[0].pcAddr = NULL;
    functionInfo[1].pcAddr = NULL;
    functionInfo[0].prefetchCnt = 0U;
    functionInfo[1].prefetchCnt = 0U;

    error = rtKernelGetAddrAndPrefCntV2(handle, NULL, NULL, RT_STATIC_SHAPE_KERNEL, &kernelInfo);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDevBinaryUnRegister(handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, KERNEL_LAUNCH_EX_1)
{
    rtError_t error;
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    void * devPtr;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    error = api.KernelLaunchEx("", (void *)1, 1, 0, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = api.ManagedMemFree(NULL);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    uint64_t size = 128;
    uint32_t device = 1;
    void *ptr = NULL;

    MOCKER(halShmemCloseHandle)
        .stubs()
        .will(returnValue(DRV_ERROR_RESERVED));

    error = rtMalloc(&devPtr, 60, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = api.MemSetSync(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = api.MemPrefetchToDevice(ptr, size, device);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = api.IpcSetMemoryName(ptr, 0, "mem1", 4, 0UL);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = api.IpcSetMemoryAttr("mem1", RT_ATTR_TYPE_MAX, 0);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = api.IpcCloseMemory(ptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    GlobalMockObject::verify();

    void *dst = NULL;
    const void *src = NULL;
    uint64_t count = 0;
    rtRecudeKind_t kind;
    rtDataType_t type;
    Stream *stream = NULL;
    error = api.ReduceAsync(dst, src, count, kind, type, stream, 0);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    g_isAddrFlatDevice = true;
    error = api.IpcSetMemoryAttr("mem1", RT_ATTR_TYPE_MEM_MAP, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, label_api)
{
    rtError_t error;
    rtLabel_t label;
    rtStream_t stream;
    const char *name = "label";
    uint32_t value = 0;

    rtModel_t model;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtLabelCreate(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtLabelCreateV2(&label, model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ((Label *)label)->SetLabelDevAddr(NULL);

    error = rtLabelSet(label, stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtLabelGoto(label, stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtLabelGoto(label, stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtLabelDestroy(label);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
//changed
TEST_F(CloudV2ApiTest, memcpy_async_host_to_device_81)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    void *hostPtr;
    void *devPtr;

    rtError_t error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);//RT_MEMORY_TYPE_HOST
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);//RT_MEMORY_TYPE_DEVICE
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream *stream = static_cast<Stream *>(stream_);
    error = rtMemcpyAsync(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE, stream_);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, LAUNCH_KERNEL_WITH_TYPE)
{
    rtError_t error;
    rtDevBinary_t devBin;
    void      *binHandle_;
    uint32_t   binary_[32];

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    void *args[] = {&error, NULL};
    devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    devBin.version = 1;
    devBin.length = sizeof(binary_);
    devBin.data = binary_;
    error = rtDevBinaryRegister(&devBin, &binHandle_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    void *stub_func = (void *)0x123;
    error = rtFunctionRegister(binHandle_, stub_func, "stub_func1", "foo", (1 << 16)); // mix aic

    stub_func = (void *)0x1234;
    error = rtFunctionRegister(binHandle_, stub_func, "stub_func1", "foo", (2 << 16)); // mix aiv

    stub_func = (void *)0x12345;
    error = rtFunctionRegister(binHandle_, stub_func, "stub_func1", "foo", (3 << 16)); // mix aic && aiv
}

TEST_F(CloudV2ApiTest, GetDevArgsAddr)
{
    rtStream_t stm;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    rtError_t error = rtStreamCreate(&stm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t arg = 0x1234567890;
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    void *devArgsAddr = nullptr, *argsHandle = nullptr;
    error = rtGetDevArgsAddr(stm, &argsInfo, &devArgsAddr, &argsHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

class CloudV2ApiTest2 : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        (void)rtSetSocVersion("Ascend910B1");
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        (void)rtSetDevice(0);
        (void)rtSetTSDevice(1);
    }

    static void TearDownTestCase()
    {
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

public:
    static rtError_t GetNotifyPhyInfo_stub_succ(cce::runtime::ApiImpl *api, Notify *const inNotify, rtNotifyPhyInfo* notifyInfo)
    {
        notifyInfo->phyId = 1;
        notifyInfo->tsId = 2;
        return RT_ERROR_NONE;
    }

    static int32_t stubRtsDeviceTaskAbortCallback(uint32_t devId, rtDeviceTaskAbortStage stage, uint32_t timeout, void *args)
    {
        return 0;
    }
};

TEST_F(CloudV2ApiTest2, ipc_open_with_flag_succ)
{
    ApiImpl apiImpl;
    rtError_t error;
    uint32_t phyDevId;
    uint32_t tsId;
    uint32_t notifyId;
    rtNotifyPhyInfo notifyInfo;
    rtNotify_t notify = new (std::nothrow) Notify(0, 0);

    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::IpcOpenNotify).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetNotifyPhyInfo).stubs()
        .will(invoke(GetNotifyPhyInfo_stub_succ));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::NotifyDestroy).stubs().will(returnValue(RT_ERROR_NONE));
    error = rtIpcOpenNotifyWithFlag(&notify, "abc", 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtNotifyGetPhyInfo(notify, &phyDevId, &tsId);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(phyDevId, 1);
    EXPECT_EQ(tsId, 2);
    error = rtNotifyGetPhyInfoExt(notify, &notifyInfo);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    rtNotifyDestroy(notify);
    delete notify;
}

TEST_F(CloudV2ApiTest2, notify_get_phyinfo_invalid_1)
{
    ApiImpl apiImpl;
    rtNotify_t notify;
    rtError_t error;
    uint32_t phyDevId;
    uint32_t tsId;
    uint32_t notifyId;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::IpcOpenNotify).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetNotifyPhyInfo).stubs()
        .then(returnValue(RT_ERROR_INVALID_VALUE));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::NotifyDestroy).stubs().will(returnValue(RT_ERROR_NONE));
    error = rtIpcOpenNotifyWithFlag(&notify, "abc", 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtNotifyGetPhyInfo(notify, &phyDevId, &tsId);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    rtNotifyDestroy(notify);
}

TEST_F(CloudV2ApiTest2, rtGetP2PStatus)
{
    rtError_t error;
    uint32_t status = 0;

    error = rtGetP2PStatus(0, 0, &status);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetP2PStatus(0, 0, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER(drvGetP2PStatus)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtGetP2PStatus(0, 0, &status);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest2, ipc_open_with_flag_error)
{
    ApiImpl apiImpl;
    rtNotify_t notify;
    rtError_t error;
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::IpcOpenNotify).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    error = rtIpcOpenNotifyWithFlag(&notify, "abc", 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest2, notify_record)
{
    rtNotify_t notify;
    rtError_t error;
    int32_t device_id = 0;

    error = rtNotifyCreate(device_id, &notify);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyRecord(notify, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyWait(notify, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyDestroy(notify);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest2, notify_record1)
{
    rtNotify_t notify;
    rtError_t error;
    int32_t device_id = 0;
    int32_t time_out = 70;

    error = rtNotifyCreate(device_id, &notify);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyRecord(notify, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyWaitWithTimeOut(notify, NULL, time_out);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyDestroy(notify);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest2, stream_get_priority)
{
    rtError_t error;
    rtStream_t stream;
    uint32_t priority = 0;

    error = rtStreamCreateWithFlags(&stream, 5, RT_STREAM_FORBIDDEN_DEFAULT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamGetPriority(stream, &priority);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(priority, 5);

    error = rtStreamGetPriority(nullptr, &priority);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamGetPriority(stream, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest2, stream_get_flags)
{
    rtStream_t stream;
    rtError_t error = RT_ERROR_NONE;
    uint32_t flags = 0;

    error = rtStreamCreateWithFlags(&stream, 1, RT_STREAM_PERSISTENT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamGetFlags(stream, &flags);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(flags, RT_STREAM_PERSISTENT);

    error = rtStreamGetFlags(nullptr, &flags);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamGetFlags(stream, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(CloudV2ApiTest2, rtStreamSetModeTest_normal)
{
    rtError_t error;
    int32_t device_id = 0;
    uint32_t tsId = 0;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_SET_STREAM_MODE);

    rtStream_t stm;
    rtEvent_t event;
    error = rtStreamCreate(&stm, 0);
    Stream *stream = static_cast<Stream *>(stm);
    rtError_t contextStatus = stream->Context_()->GetFailureError();
    TsStreamFailureMode ctxMode =  stream->Context_()->GetCtxMode();
    stream->Context_()->SetCtxMode(STOP_ON_FAILURE);

    stream->EnterFailureAbort();
    EXPECT_EQ(stream->GetFailureMode(), 2);

    stream->Context_()->SetFailureError(contextStatus);
    stream->Context_()->SetCtxMode(ctxMode);
    error = rtStreamDestroy(stm);
    device->SetTschVersion(version);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2ApiTest2, reset_device_force)
{
    rtStream_t *stream = nullptr;
    (void)rtSetDevice(0);
    (void)rtSetDevice(0);
    (void)rtSetDevice(0);
    (void)rtSetDevice(0);

    rtError_t error;
    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    int32_t devId;
    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceResetForce(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceResetForce(0);
    EXPECT_NE(error, RT_ERROR_NONE);
    error = rtGetDevice(0);
    EXPECT_NE(error, RT_ERROR_NONE);
    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest2, set_device_by_default_device_id)
{
    rtError_t error;
    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSetDefaultDeviceId(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    int32_t devId;
    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSetDefaultDeviceId(0xFFFFFFFF);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest2, set_device_by_default_device_id_02)
{
    rtError_t error = rtDeviceResetForce(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSetDefaultDeviceId(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_EQ(rtInstance->defaultDeviceId_, 0);
    EXPECT_EQ(rtInstance->hasSetDefaultDevId_, true);
    // 隐式setdevice
    rtStream_t stream;
    EXPECT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);

    error = rtDeviceResetForce(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSetDefaultDeviceId(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    int32_t devId;
    error = rtCtxGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSetDefaultDeviceId(0xFFFFFFFF);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

class CloudV2ApiTest3 : public testing::Test
{
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

        for (uint32_t i = 0; i < sizeof(binary_)/sizeof(uint32_t); i++)
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

        std::cout<<"api test start:"<<error1<<", "<<error2<<", "<<error3<<", "<<error4<<std::endl;
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
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
    }

    virtual void TearDown()
    {
         GlobalMockObject::verify();
    }

public:

    static int32_t StubTaskAbortCallBack(uint32_t devId, rtTaskAbortStage_t stage, uint32_t timeout, void *args)
    {
        g_taskAbortCallBack = true;
        return 0;
    }

    static int32_t stubRtsDeviceTaskAbortCallback(uint32_t devId, rtDeviceTaskAbortStage stage, uint32_t timeout, void *args)
    {
        return 0;
    }

    static rtStream_t stream_;
    static rtEvent_t  event_;
    static void      *binHandle_;
    static char       function_;
    static uint32_t   binary_[32];
    static Driver*    driver_;
    static bool       g_taskAbortCallBack;
};
rtStream_t CloudV2ApiTest3::stream_ = nullptr;
rtEvent_t CloudV2ApiTest3::event_ = nullptr;
void* CloudV2ApiTest3::binHandle_ = nullptr;
char  CloudV2ApiTest3::function_ = 'a';
uint32_t CloudV2ApiTest3::binary_[32] = {};
Driver* CloudV2ApiTest3::driver_ = nullptr;
bool CloudV2ApiTest3::g_taskAbortCallBack = false;

TEST_F(CloudV2ApiTest3, TEST_Stars_Launch)
{
    cce::runtime::rtStarsCommonSqe_t commonSqe = {{0}, {0}};
    commonSqe.sqeHeader.type = RT_STARS_SQE_TYPE_VPC;

    rtStream_t stream;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStarsTaskLaunch(&commonSqe, sizeof(cce::runtime::rtStarsCommonSqe_t), stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStarsTaskLaunch(&commonSqe, sizeof(cce::runtime::rtStarsCommonSqe_t) - 1, stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStarsTaskLaunch(NULL, 0, stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    commonSqe.sqeHeader.type = RT_STARS_SQE_TYPE_END;
    error = rtStarsTaskLaunch(&commonSqe, sizeof(cce::runtime::rtStarsCommonSqe_t), stream);
    EXPECT_NE(error, RT_ERROR_NONE);
}


TEST_F(CloudV2ApiTest3, test_get_fault_event)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    uint32_t eventCount;
    error = rtGetFaultEvent(0, nullptr, nullptr, 10, &eventCount);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    rtDmsEventFilter filter;
    rtDmsFaultEvent dmsEvent;
    MOCKER(halGetFaultEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    error = rtGetFaultEvent(0, &filter, &dmsEvent, sizeof(rtDmsFaultEvent), &eventCount);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest3, TaskAbortCallBack)
{
    char moduleName[] = "HCCL";
    rtError_t error;
    char args[] = "0x100";

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtSetTaskAbortCallBack(moduleName, StubTaskAbortCallBack, args);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtInstance->taskAbortCallbackMap_.count("HCCL");
    EXPECT_EQ(error, 1);
}

TEST_F(CloudV2ApiTest3, SetWaitTimeOutMilan)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtSetOpWaitTimeOut(1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest3, set_device_repeat)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(-1);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest3, rtStreamWaitEventWithTimeoutStars)
{
    rtError_t error;
    error = rtStreamWaitEventWithTimeout(nullptr, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamWaitEventWithTimeout(nullptr, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest3, rtStreamWaitEventWithTimeout)
{
    rtError_t error;
    error = rtStreamWaitEventWithTimeout(nullptr, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamWaitEventWithTimeout(nullptr, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest3, rtStreamWaitEventStars)
{
    rtError_t error;
    error = rtStreamWaitEvent(nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtStreamWaitEvent(nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest3, rtsSetDeviceTaskAbortCallback_002)
{
    char moduleName[] = "HCCL";
    rtError_t error;
    char args[] = "0x100";

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtsSetDeviceTaskAbortCallback(moduleName, &stubRtsDeviceTaskAbortCallback, args);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtInstance->taskAbortCallbackMap_.count("HCCL");
    EXPECT_EQ(error, 1);
}

TEST_F(CloudV2ApiTest3, rtsProfTrace_001)
{
    rtError_t error;
    int32_t length = 18;
    error = rtsProfTrace(nullptr, length, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest3, rtsProfTrace_002)
{
    rtError_t error;
    int32_t length = 20;
    uint8_t data1[length] = {0x11, 0x22, 0x33, 0x44, 0x55, 0x11, 0x22, 0x33, 0x44, 0x55,
        0x11, 0x22, 0x33, 0x44, 0x55, 0x11, 0x22, 0x33, 0x44, 0x55};
    error = rtsProfTrace(&data1, length, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest3, rtsProfTrace_003)
{
    rtError_t error;
    int32_t length = 15;
    uint8_t data2[length] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00};
    error = rtsProfTrace(&data2, length, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest3, rtsProfTrace_004)
{
    rtError_t error;
    int32_t length = 18;
    uint8_t data3[length] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x01};
    error = rtsProfTrace(&data3, length, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest3, rtsNpuGetFloatOverFlowStatus)
{
    void *descBuf = malloc(8);         // device memory
    uint64_t descBufLen=64;
    uint32_t checkmode = 0;

    rtError_t error = rtsNpuGetFloatOverFlowStatus(descBuf, descBufLen, checkmode, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    free(descBuf);
}

TEST_F(CloudV2ApiTest3, rtsNpuGetFloatOverFlowDebugStatus)
{
    void *descBuf = malloc(8);         // device memory
    uint64_t descBufLen=64;
    uint32_t checkmode = 0;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    FeatureToTsVersionInit();
    Device* dev = rtInstance->GetDevice(0, 0);
    int32_t version = dev->GetTschVersion();
    dev->SetTschVersion(((uint32_t)TS_BRANCH_TRUNK << 16) | TS_VERSION_OVER_FLOW_DEBUG);
    rtError_t error = rtsNpuGetFloatOverFlowDebugStatus(descBuf, descBufLen, checkmode, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    dev->SetTschVersion(version);
    free(descBuf);
}

TEST_F(CloudV2ApiTest3, rtsNpuClearFloatOverFlowStatus)
{
    uint32_t checkmode = 0;
    rtError_t error = rtsNpuClearFloatOverFlowStatus(checkmode, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest3, rtsNpuClearFloatDebugStatus)
{
    uint32_t checkmode = 0;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    FeatureToTsVersionInit();
    rtChipType_t chipType = rtInstance->GetChipType();

    Device* dev = rtInstance->GetDevice(0, 0);
    int32_t version = dev->GetTschVersion();
    dev->SetTschVersion(((uint32_t)TS_BRANCH_TRUNK << 16) | TS_VERSION_OVER_FLOW_DEBUG);
    rtError_t error = rtsNpuClearFloatOverFlowDebugStatus(checkmode, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    dev->SetTschVersion(version);
}

TEST_F(CloudV2ApiTest, rtMallocPysical)
{
    rtError_t error;
    rtDrvMemHandle handVal;
    rtDrvMemProp_t prop = {};
    prop.mem_type = 1;
    prop.pg_type = 2;
    rtDrvMemHandle* handle = &handVal;
    error = rtMallocPhysical(handle, 0, &prop, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, rts_ipc_open_with_flag_succ)
{
    ApiImpl apiImpl;
    rtError_t error;
    uint32_t phyDevId;
    uint32_t tsId;
    uint32_t notifyId;
    rtNotifyPhyInfo notifyInfo;
    rtNotify_t notify = new (std::nothrow) Notify(0, 0);

    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::IpcOpenNotify).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetNotifyPhyInfo).stubs()
        .will(invoke(GetNotifyPhyInfoStub));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::NotifyDestroy).stubs().will(returnValue(RT_ERROR_NONE));
    error = rtsNotifyImportByKey(&notify, "aaaa", 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtNotifyGetPhyInfo(notify, &phyDevId, &tsId);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(phyDevId, 1);
    EXPECT_EQ(tsId, 2);
    error = rtNotifyGetPhyInfoExt(notify, &notifyInfo);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    rtNotifyDestroy(notify);
    delete notify;
}

TEST_F(CloudV2ApiTest, rtGetOpTimeOutV2_notset)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtSocType_t socType = rtInstance->GetSocType();

    //not set timeout
    uint32_t timeout = 0;
    Runtime::Instance()->timeoutConfig_.isInit = false;
    rtInstance->SetSocType(SOC_ASCEND910B1);
    error = rtGetOpExecuteTimeoutV2(&timeout);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(timeout, 1090922);

    rtInstance->SetSocType(socType);
}

TEST_F(CloudV2ApiTest, rtGetOpTimeOutV2_set)
{
    rtError_t error;
    rtStream_t stream;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtSocType_t socType = rtInstance->GetSocType();
    bool oriisCfgOpExcTaskTimeout = rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout;
    int32_t oriopExcTaskTimeout = rtInstance->timeoutConfig_.opExcTaskTimeout;
    rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout = true;

    uint32_t timeout = 0;
    Runtime::Instance()->timeoutConfig_.isInit = false;
    rtInstance->timeoutConfig_.opExcTaskTimeout = 10;
    //change soctype
    rtInstance->SetSocType(SOC_ASCEND910B1);
    error = rtGetOpExecuteTimeoutV2(&timeout);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(timeout, 4295);

    rtInstance->SetSocType(socType);
    rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout = oriisCfgOpExcTaskTimeout;
    rtInstance->timeoutConfig_.opExcTaskTimeout = oriopExcTaskTimeout;
}

TEST_F(CloudV2ApiTest, rtLaunchSqeUpdateTask_USE_AICPUTASK_TEST)
{
    rtStarsDsaSqe_t sqe = {};
    rtRandomNumTaskInfo_t task_info = {};

    task_info.randomNumFuncParaInfo.funcType = RT_RANDOM_NUM_FUNC_TYPE_NORMAL_DIS;
    uint32_t mean = 100;
    memcpy_s(task_info.randomNumFuncParaInfo.paramInfo.normalDisInfo.mean.valueOrAddr,
             sizeof(task_info.randomNumFuncParaInfo.paramInfo.normalDisInfo.mean.valueOrAddr),
             &mean, 2);
    task_info.randomNumFuncParaInfo.paramInfo.normalDisInfo.mean.size = 2;
    task_info.randomNumFuncParaInfo.paramInfo.normalDisInfo.mean.isAddr = false;
    uint32_t stddev = 100;
    memcpy_s(task_info.randomNumFuncParaInfo.paramInfo.normalDisInfo.stddev.valueOrAddr,
             sizeof(task_info.randomNumFuncParaInfo.paramInfo.normalDisInfo.stddev.valueOrAddr),
             &stddev, 2);
    task_info.randomNumFuncParaInfo.paramInfo.normalDisInfo.stddev.size = 2;
    task_info.randomNumFuncParaInfo.paramInfo.normalDisInfo.stddev.isAddr = false;

    task_info.randomParaAddr = nullptr;
    uint32_t addr = 0;
    task_info.randomResultAddr = &addr;
    task_info.randomCounterAddr = &addr;
    uint32_t seed = 0;
    memcpy_s(task_info.randomSeed.valueOrAddr,
             sizeof(task_info.randomSeed.valueOrAddr),
             &seed, sizeof(uint32_t));
    task_info.randomSeed.size = sizeof(uint32_t);
    task_info.randomSeed.isAddr = false;
    uint32_t num = 128;
    memcpy_s(task_info.randomNum.valueOrAddr,
             sizeof(task_info.randomNum.valueOrAddr),
             &num, sizeof(uint32_t));
    task_info.randomNum.size = sizeof(uint32_t);
    task_info.randomNum.isAddr = false;
    task_info.dataType = RT_RANDOM_NUM_DATATYPE_FP32;


    // uint32_t *hostPtr;
    uint32_t *devPtr;

    rtError_t error;
    rtStream_t sinkStream;
    rtStream_t execStream;
    rtModel_t  model;
    uint32_t dsa_taskid = 0;
    uint32_t dsa_streamId = 0;

    uint64_t dsa_update_size = sizeof(rtRandomNumTaskInfo_t);

    error = rtStreamCreateWithFlags(&sinkStream, 5, RT_STREAM_PERSISTENT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreateWithFlags(&execStream, 5, RT_STREAM_DEFAULT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, sinkStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsLaunchRandomNumTask(&task_info, sinkStream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelGetTaskId(model, &dsa_taskid, &dsa_streamId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error=  rtEndGraph(model, sinkStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelLoadComplete(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc((void **)&devPtr, dsa_update_size, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpy(devPtr, dsa_update_size, &task_info, dsa_update_size, RT_MEMCPY_HOST_TO_DEVICE);

    rtDsaTaskUpdateAttr_t attr = {};
    attr.srcAddr = (void *)devPtr;
    attr.size = dsa_update_size;

    rtTaskUpdateCfg_t cfg = {};
    cfg.id = RT_UPDATE_DSA_TASK;
    cfg.val.dsaTaskAttr = attr;

   // normal test
    error = rtsLaunchUpdateTask(sinkStream, dsa_taskid, execStream, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelExecute(model, execStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, sinkStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(sinkStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(execStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, rtLaunchSqeUpdateTask_USE_AICPUTASK_TEST_2)
{
    rtStarsDsaSqe_t sqe = {};
    rtRandomNumTaskInfo_t task_info = {};

    // uint32_t *hostPtr;
    uint32_t *devPtr;
    void *devPtr2;
    rtError_t error;
    rtStream_t sinkStream;
    rtStream_t execStream;
    rtModel_t  model;
    uint32_t dsa_taskid = 0;
    uint32_t dsa_streamId = 0;

    uint64_t dsa_update_size = sizeof(rtRandomNumTaskInfo_t);

    uint32_t dropoutRation = 1000;
    error = rtMalloc((void **)&devPtr2, 20, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpy(devPtr2, 20, &dropoutRation, 4, RT_MEMCPY_HOST_TO_DEVICE);

    task_info.randomNumFuncParaInfo.funcType = RT_RANDOM_NUM_FUNC_TYPE_DROPOUT_BITMASK;

    memcpy_s(task_info.randomNumFuncParaInfo.paramInfo.dropoutBitmaskInfo.dropoutRation.valueOrAddr,
             sizeof(task_info.randomNumFuncParaInfo.paramInfo.dropoutBitmaskInfo.dropoutRation.valueOrAddr),
             &devPtr2, 8);
    task_info.randomNumFuncParaInfo.paramInfo.dropoutBitmaskInfo.dropoutRation.size = 8;
    task_info.randomNumFuncParaInfo.paramInfo.dropoutBitmaskInfo.dropoutRation.isAddr = true;

    task_info.randomParaAddr = nullptr;
    uint32_t addr = 0;
    task_info.randomResultAddr = &addr;
    task_info.randomCounterAddr = &addr;
    uint32_t seed = 0;
    memcpy_s(task_info.randomSeed.valueOrAddr,
             sizeof(task_info.randomSeed.valueOrAddr),
             &seed, sizeof(uint32_t));
    task_info.randomSeed.size = sizeof(uint32_t);
    task_info.randomSeed.isAddr = false;
    uint32_t num = 128;
    memcpy_s(task_info.randomNum.valueOrAddr,
             sizeof(task_info.randomNum.valueOrAddr),
             &num, sizeof(uint32_t));
    task_info.randomNum.size = sizeof(uint32_t);
    task_info.randomNum.isAddr = false;
    task_info.dataType = RT_RANDOM_NUM_DATATYPE_FP32;

    error = rtStreamCreateWithFlags(&sinkStream, 5, RT_STREAM_PERSISTENT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreateWithFlags(&execStream, 5, RT_STREAM_DEFAULT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, sinkStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsLaunchRandomNumTask(&task_info, sinkStream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelGetTaskId(model, &dsa_taskid, &dsa_streamId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error=  rtEndGraph(model, sinkStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelLoadComplete(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc((void **)&devPtr, dsa_update_size, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpy(devPtr, dsa_update_size, &task_info, dsa_update_size, RT_MEMCPY_HOST_TO_DEVICE);

    rtDsaTaskUpdateAttr_t attr = {};
    attr.srcAddr = (void *)devPtr;
    attr.size = dsa_update_size;

    rtTaskUpdateCfg_t cfg = {};
    cfg.id = RT_UPDATE_DSA_TASK;
    cfg.val.dsaTaskAttr = attr;

   // normal test
    error = rtsLaunchUpdateTask(sinkStream, dsa_taskid, execStream, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelExecute(model, execStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, sinkStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(sinkStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(execStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr2);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, rtLaunchSqeUpdateTask_USE_AICPUTASK_TEST_3)
{
    rtStarsDsaSqe_t sqe = {};
    rtRandomNumTaskInfo_t task_info = {};

    // uint32_t *hostPtr;
    uint32_t *devPtr;
    void *devPtr2;
    rtError_t error;
    rtStream_t sinkStream;
    rtStream_t execStream;
    rtModel_t  model;
    uint32_t dsa_taskid = 0;
    uint32_t dsa_streamId = 0;

    uint64_t dsa_update_size = sizeof(rtRandomNumTaskInfo_t);

    uint32_t min = 1000;
    uint32_t max = 1000;
    error = rtMalloc((void **)&devPtr2, 20, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpy(devPtr2, 20, &max, 4, RT_MEMCPY_HOST_TO_DEVICE);

    task_info.randomNumFuncParaInfo.funcType = RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS;

    memcpy_s(task_info.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.valueOrAddr,
             sizeof(task_info.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.valueOrAddr),
             &min, 4);
    task_info.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.size = 4;
    task_info.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.isAddr = false;

    memcpy_s(task_info.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.valueOrAddr,
             sizeof(task_info.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.valueOrAddr),
             &devPtr2, 8);
    task_info.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.size = 8;
    task_info.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.isAddr = true;

    task_info.randomParaAddr = nullptr;
    uint32_t addr = 0;
    task_info.randomResultAddr = &addr;
    task_info.randomCounterAddr = &addr;
    uint32_t seed = 0;
    memcpy_s(task_info.randomSeed.valueOrAddr,
             sizeof(task_info.randomSeed.valueOrAddr),
             &seed, sizeof(uint32_t));
    task_info.randomSeed.size = sizeof(uint32_t);
    task_info.randomSeed.isAddr = false;
    uint32_t num = 128;
    memcpy_s(task_info.randomNum.valueOrAddr,
             sizeof(task_info.randomNum.valueOrAddr),
             &num, sizeof(uint32_t));
    task_info.randomNum.size = sizeof(uint32_t);
    task_info.randomNum.isAddr = false;
    task_info.dataType = RT_RANDOM_NUM_DATATYPE_FP32;

    error = rtStreamCreateWithFlags(&sinkStream, 5, RT_STREAM_PERSISTENT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreateWithFlags(&execStream, 5, RT_STREAM_DEFAULT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, sinkStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsLaunchRandomNumTask(&task_info, sinkStream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelGetTaskId(model, &dsa_taskid, &dsa_streamId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error=  rtEndGraph(model, sinkStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelLoadComplete(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc((void **)&devPtr, dsa_update_size, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpy(devPtr, dsa_update_size, &task_info, dsa_update_size, RT_MEMCPY_HOST_TO_DEVICE);

    rtDsaTaskUpdateAttr_t attr = {};
    attr.srcAddr = (void *)devPtr;
    attr.size = dsa_update_size;

    rtTaskUpdateCfg_t cfg = {};
    cfg.id = RT_UPDATE_DSA_TASK;
    cfg.val.dsaTaskAttr = attr;

   // normal test
    error = rtsLaunchUpdateTask(sinkStream, dsa_taskid, execStream, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelExecute(model, execStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, sinkStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(sinkStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(execStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr2);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, rtsLaunchRandomNumTask_TEST_abnormal)
{
    rtRandomNumTaskInfo_t task_info = {};

    // uint32_t *hostPtr;
    void *devPtr2;
    rtError_t error;
    rtStream_t sinkStream;
    rtModel_t  model;

    uint32_t min = 1000;
    uint32_t max = 1000;
    error = rtMalloc((void **)&devPtr2, 20, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpy(devPtr2, 20, &max, 4, RT_MEMCPY_HOST_TO_DEVICE);

    task_info.randomNumFuncParaInfo.funcType = RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS;

    memcpy_s(task_info.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.valueOrAddr,
             sizeof(task_info.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.valueOrAddr),
             &min, 4);
    task_info.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.size = 4;
    task_info.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.isAddr = 2;

    memcpy_s(task_info.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.valueOrAddr,
             sizeof(task_info.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.valueOrAddr),
             &devPtr2, 8);
    task_info.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.size = 8;
    task_info.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.isAddr = true;

    task_info.randomParaAddr = nullptr;
    uint32_t addr = 0;
    task_info.randomResultAddr = &addr;
    task_info.randomCounterAddr = &addr;
    uint32_t seed = 0;
    memcpy_s(task_info.randomSeed.valueOrAddr,
             sizeof(task_info.randomSeed.valueOrAddr),
             &seed, sizeof(uint32_t));
    task_info.randomSeed.size = sizeof(uint32_t);
    task_info.randomSeed.isAddr = false;
    uint32_t num = 128;
    memcpy_s(task_info.randomNum.valueOrAddr,
             sizeof(task_info.randomNum.valueOrAddr),
             &num, sizeof(uint32_t));
    task_info.randomNum.size = sizeof(uint32_t);
    task_info.randomNum.isAddr = false;
    task_info.dataType = RT_RANDOM_NUM_DATATYPE_FP32;

    error = rtStreamCreateWithFlags(&sinkStream, 5, RT_STREAM_PERSISTENT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, sinkStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsLaunchRandomNumTask(&task_info, sinkStream, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtModelUnbindStream(model, sinkStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(sinkStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr2);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, rtModelCheckCompatibility_archVersion)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtArchType_t oriArchType = rtInstance->GetArchType();

    rtInstance->SetArchType(ARCH_M300);
    // OmArchVersion is null
    error = rtModelCheckCompatibility("SOC_ASCEND910B1", "");
    EXPECT_EQ(error, RT_ERROR_NONE);
    // OmArchVersion is nullptr
    error = rtModelCheckCompatibility("SOC_ASCEND910B1", nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    // OmArchVersion is not same as archType
    error = rtModelCheckCompatibility("SOC_ASCEND910B1", "11");
    EXPECT_EQ(error, ACL_ERROR_RT_SOC_VERSION);

    // OmArchVersion is same as archType
    error = rtModelCheckCompatibility("SOC_ASCEND910B1", "10");
    EXPECT_EQ(error, RT_ERROR_NONE);

    // OmArchVersion is not find
    error = rtModelCheckCompatibility("SOC_ASCEND910B1", "20");
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    // restore all type
    rtInstance->SetArchType(oriArchType);
}

TEST_F(CloudV2ApiTest, rtLaunchSqeUpdateTask_PARAM_SRC_NULL)
{
    rtError_t error;
    uint32_t streamId = 1U;
    uint32_t taskId = 1U;
    uint64_t cnt = 40U;

    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // src == null
    error = rtLaunchSqeUpdateTask(streamId, taskId, nullptr, cnt, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, rtLaunchSqeUpdateTask_PARAM_CNT_INVALID)
{
    rtError_t error;
    uint32_t streamId = 1U;
    uint32_t taskId = 1U;
    uint64_t src_addr = 0U;
    uint64_t cnt = 100U; // test not equa 40 byte

    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // invalid  cnt
    error = rtLaunchSqeUpdateTask(streamId, taskId, reinterpret_cast<void*>(src_addr), cnt, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, rtLaunchSqeUpdateTask_PARAM_NORMAL_TEST)
{
    uint32_t *hostPtr_01;
    uint32_t *devPtr_01;
    uint32_t *hostPtr_02;
    uint32_t *devPtr_02;
    uint32_t *hostPtr_03;
    uint32_t *devPtr_03;
    uint32_t *hostPtr_04;
    uint32_t *devPtr_04;
    uint32_t *hostPtr_05;
    uint32_t *devPtr_05;

    uint32_t *hostPtr_06;
    uint32_t *devPtr_06;
    uint32_t *hostPtr_07;
    uint32_t *devPtr_07;
    uint32_t *hostPtr_08;
    uint32_t *devPtr_08;
    uint32_t *hostPtr_09;
    uint32_t *devPtr_09;
    uint32_t *hostPtr_10;
    uint32_t *devPtr_10;

    uint32_t *hostPtr;
    uint32_t *devPtr;

    rtError_t error;
    rtStream_t sinkStream;
    rtStream_t execStream;
    rtModel_t  model;
    uint32_t dsa_taskid = 0;
    uint32_t dsa_streamId = 0;

    uint64_t dsa_update_size = 40U;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    error = rtStreamCreateWithFlags(&sinkStream, 5, RT_STREAM_PERSISTENT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreateWithFlags(&execStream, 5, RT_STREAM_DEFAULT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, sinkStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsDsaSqe_t dsa_sqe_;
    dsa_sqe_.sqeHeader.type = 15;        //RT_STARS_SQE_TYPE_DSA;
    dsa_sqe_.start = 1;
    dsa_sqe_.functionType = 0;
    dsa_sqe_.dataType = 6;    // f32
    dsa_sqe_.algoType = 0;
    dsa_sqe_.paramVldBitmap = 1;
    dsa_sqe_.paramAddrValBitmap = 1;
    dsa_sqe_.kernelCredit = 100U;

    // mem_01
    error = rtMallocHost((void **)&hostPtr_01, 16, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc((void **)&devPtr_01, 16, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    initData(hostPtr_01, 16/sizeof(uint32_t), 0);
    error = rtMemcpy(devPtr_01, 16, hostPtr_01, 16, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    dsa_sqe_.dsaCfgResultAddrLow = static_cast<uint32_t>((uint64_t)(devPtr_01) & 0xFFFFFFFFU);
    dsa_sqe_.dsaCfgResultAddrHigh = static_cast<uint32_t>((uint64_t)(devPtr_01) >> 32);

    // mem_02
    error = rtMallocHost((void **)&hostPtr_02, 16, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc((void **)&devPtr_02, 16, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    initData(hostPtr_02, 16/sizeof(uint32_t), 0);
    error = rtMemcpy(devPtr_02, 16, hostPtr_02, 16, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    dsa_sqe_.dsaCfgStateAddrLow = static_cast<uint32_t>((uint64_t)(devPtr_02) & 0xFFFFFFFFU);
    dsa_sqe_.dsaCfgStateAddrHigh = static_cast<uint32_t>((uint64_t)(devPtr_02) >> 32);

    // mem_03
    error = rtMallocHost((void **)&hostPtr_03, 16, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc((void **)&devPtr_03, 16, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    initData(hostPtr_03, 16/sizeof(uint32_t), 0x3f000000);
    error = rtMemcpy(devPtr_03, 16, hostPtr_03, 16, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    dsa_sqe_.dsaCfgParamAddrLow = static_cast<uint32_t>((uint64_t)(devPtr_03) & 0xFFFFFFFFU);
    dsa_sqe_.dsaCfgParamAddrHigh = static_cast<uint32_t>((uint64_t)(devPtr_03) >> 32);

    // mem_04
    error = rtMallocHost((void **)&hostPtr_04, 16, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc((void **)&devPtr_04, 16, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    initData(hostPtr_04, 16/sizeof(uint32_t), 0);
    error = rtMemcpy(devPtr_04, 16, hostPtr_04, 16, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);
    dsa_sqe_.dsaCfgSeedLow = static_cast<uint32_t>((uint64_t)(devPtr_04) & 0xFFFFFFFFU);
    dsa_sqe_.dsaCfgSeedHigh = static_cast<uint32_t>((uint64_t)(devPtr_04) >> 32);

    // mem_05
    error = rtMallocHost((void **)&hostPtr_05, 8, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc((void **)&devPtr_05, 8, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    initData(hostPtr_05, 8/sizeof(uint32_t), 0x100);
    error = rtMemcpy(devPtr_05, 8, hostPtr_05, 8, RT_MEMCPY_HOST_TO_DEVICE);

    dsa_sqe_.dsaCfgNumberLow = static_cast<uint32_t>((uint64_t)(devPtr_05) & 0xFFFFFFFFU);
    dsa_sqe_.dsaCfgNumberHigh = static_cast<uint32_t>((uint64_t)(devPtr_05) >> 32);

    std::vector<uintptr_t> input;
    input.push_back(reinterpret_cast<uintptr_t>(&dsa_sqe_));
    input.push_back(static_cast<uintptr_t>(sizeof(dsa_sqe_)));
    input.push_back(reinterpret_cast<uintptr_t>(sinkStream));

    error = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_STARS_TSK);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelGetTaskId(model, &dsa_taskid, &dsa_streamId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error=  rtEndGraph(model, sinkStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelLoadComplete(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // mem_06
    error = rtMallocHost((void **)&hostPtr_06, 16, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc((void **)&devPtr_06, 16, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    initData(hostPtr_01, 16/sizeof(uint32_t), 0);
    error = rtMemcpy(devPtr_06, 16, hostPtr_06, 16, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    dsa_sqe_.dsaCfgResultAddrLow = static_cast<uint32_t>((uint64_t)(devPtr_06) & 0xFFFFFFFFU);
    dsa_sqe_.dsaCfgResultAddrHigh = static_cast<uint32_t>((uint64_t)(devPtr_06) >> 32);

    // mem_07
    error = rtMallocHost((void **)&hostPtr_07, 16, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc((void **)&devPtr_07, 16, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    initData(hostPtr_07, 16/sizeof(uint32_t), 0);
    error = rtMemcpy(devPtr_07, 16, hostPtr_07, 16, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    dsa_sqe_.dsaCfgStateAddrLow = static_cast<uint32_t>((uint64_t)(devPtr_07) & 0xFFFFFFFFU);
    dsa_sqe_.dsaCfgStateAddrHigh = static_cast<uint32_t>((uint64_t)(devPtr_07) >> 32);

    // mem_08
    error = rtMallocHost((void **)&hostPtr_08, 16, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc((void **)&devPtr_08, 16, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    initData(hostPtr_08, 16/sizeof(uint32_t), 0x3f000000);
    error = rtMemcpy(devPtr_08, 16, hostPtr_08, 16, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    dsa_sqe_.dsaCfgParamAddrLow = static_cast<uint32_t>((uint64_t)(devPtr_08) & 0xFFFFFFFFU);
    dsa_sqe_.dsaCfgParamAddrHigh = static_cast<uint32_t>((uint64_t)(devPtr_08) >> 32);

    // mem_09
    error = rtMallocHost((void **)&hostPtr_09, 16, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc((void **)&devPtr_09, 16, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    initData(hostPtr_09, 16/sizeof(uint32_t), 0);
    error = rtMemcpy(devPtr_09, 16, hostPtr_09, 16, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);
    dsa_sqe_.dsaCfgSeedLow = static_cast<uint32_t>((uint64_t)(devPtr_09) & 0xFFFFFFFFU);
    dsa_sqe_.dsaCfgSeedHigh = static_cast<uint32_t>((uint64_t)(devPtr_09) >> 32);

    // mem_10
    error = rtMallocHost((void **)&hostPtr_10, 8, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc((void **)&devPtr_10, 8, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    initData(hostPtr_10, 8/sizeof(uint32_t), 0x100);
    error = rtMemcpy(devPtr_10, 8, hostPtr_10, 8, RT_MEMCPY_HOST_TO_DEVICE);

    dsa_sqe_.dsaCfgNumberLow = static_cast<uint32_t>((uint64_t)(devPtr_10) & 0xFFFFFFFFU);
    dsa_sqe_.dsaCfgNumberHigh = static_cast<uint32_t>((uint64_t)(devPtr_10) >> 32);

    // mem_update_dsa
    error = rtMallocHost((void **)&hostPtr, dsa_update_size, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc((void **)&devPtr, dsa_update_size, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    initUpdateDsaSqe(hostPtr, &dsa_sqe_);
    error = rtMemcpy(devPtr, dsa_update_size, hostPtr, dsa_update_size, RT_MEMCPY_HOST_TO_DEVICE);

   // normal test
    error = rtLaunchSqeUpdateTask(dsa_streamId, dsa_taskid, devPtr, dsa_update_size, execStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

   // normal test 01
    error = rtLaunchSqeUpdateTask(dsa_streamId, dsa_taskid, devPtr, dsa_update_size, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

   // devPtr changed
    uint64_t dsaSrcDevAddr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(devPtr)) + 16U;
    uint32_t* testWrongDevPtr = reinterpret_cast<uint32_t *>(static_cast<uintptr_t>(dsaSrcDevAddr));
    error = rtLaunchSqeUpdateTask(dsa_streamId, dsa_taskid, testWrongDevPtr, dsa_update_size, execStream);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    Stream* modelStream = static_cast<Stream *>(sinkStream);
    modelStream->SetBindFlag(false);
    error = rtLaunchSqeUpdateTask(dsa_streamId, dsa_taskid, devPtr, dsa_update_size, execStream);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    modelStream->SetBindFlag(true);

    // dsa task is null
    error = rtLaunchSqeUpdateTask(dsa_streamId, 65533U, devPtr, dsa_update_size, execStream);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtModelExecute(model, execStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, sinkStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(sinkStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(execStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr_01);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr_01);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr_02);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr_02);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr_03);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr_03);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr_04);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr_04);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr_05);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr_05);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr_06);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr_06);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr_07);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr_07);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr_08);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr_08);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr_09);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr_09);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr_10);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr_10);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, rtNpuGetFloatStatus)
{
    void *descBuf = malloc(8);         // device memory
    uint64_t descBufLen=64;
    uint32_t checkmode = 0;

    std::vector<uintptr_t> input;
    input.push_back(reinterpret_cast<uintptr_t>(descBuf));
    input.push_back(static_cast<uintptr_t>(descBufLen));
    input.push_back(static_cast<uintptr_t>(checkmode));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));
    rtError_t error = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_NPU_GET_FLOAT_STATUS);

    EXPECT_EQ(error, RT_ERROR_NONE);

    free(descBuf);
}

TEST_F(CloudV2ApiTest, rtNpuGetFloatDebugStatus)
{
    void *descBuf = malloc(8);         // device memory
    uint64_t descBufLen=64;
    uint32_t checkmode = 0;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    FeatureToTsVersionInit();
    Device* dev = rtInstance->GetDevice(0, 0);
    int32_t version = dev->GetTschVersion();
    dev->SetTschVersion(((uint32_t)TS_BRANCH_TRUNK << 16) | TS_VERSION_OVER_FLOW_DEBUG);

    std::vector<uintptr_t> input;
    input.push_back(reinterpret_cast<uintptr_t>(descBuf));
    input.push_back(static_cast<uintptr_t>(descBufLen));
    input.push_back(static_cast<uintptr_t>(checkmode));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));
    rtError_t error = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_NPU_GET_FLOAT_DEBUG_STATUS);

    EXPECT_EQ(error, RT_ERROR_NONE);
    dev->SetTschVersion(version);
    free(descBuf);
}

TEST_F(CloudV2ApiTest, rtNpuGetFloatDebugStatus_01)
{
    void *descBuf = malloc(8);         // device memory
    uint64_t descBufLen=64;
    uint32_t checkmode = 0;

    // not mock tsch version
    std::vector<uintptr_t> input;
    input.push_back(reinterpret_cast<uintptr_t>(descBuf));
    input.push_back(static_cast<uintptr_t>(descBufLen));
    input.push_back(static_cast<uintptr_t>(checkmode));
    input.push_back(reinterpret_cast<uintptr_t>(nullptr));
    rtError_t error = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_NPU_GET_FLOAT_DEBUG_STATUS);

    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    free(descBuf);
}

TEST_F(CloudV2ApiTest, rtNpuClearFloatDebugStatus)
{
    uint32_t checkmode = 0;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    FeatureToTsVersionInit();

    Device* dev = rtInstance->GetDevice(0, 0);
    int32_t version = dev->GetTschVersion();
    dev->SetTschVersion(((uint32_t)TS_BRANCH_TRUNK << 16) | TS_VERSION_OVER_FLOW_DEBUG);
    std::vector<uintptr_t> input;
    input.push_back(static_cast<uintptr_t>(checkmode));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));
    rtError_t error = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_NPU_CLEAR_FLOAT_DEBUG_STATUS);

    EXPECT_EQ(error, RT_ERROR_NONE);
    dev->SetTschVersion(version);
}

TEST_F(CloudV2ApiTest, rtNpuClearFloatDebugStatus_01)
{
    uint32_t checkmode = 0;
    std::vector<uintptr_t> input;
    input.push_back(static_cast<uintptr_t>(checkmode));
    input.push_back(reinterpret_cast<uintptr_t>(nullptr));
    rtError_t error = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_NPU_CLEAR_FLOAT_DEBUG_STATUS);

    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest, rtNpuClearFloatStatus)
{
    uint32_t checkmode = 0;

    std::vector<uintptr_t> input;
    input.push_back(static_cast<uintptr_t>(checkmode));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));
    rtError_t error = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_NPU_CLEAR_FLOAT_STATUS);

    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, rtsGetHardwareSyncAddr)
{
    rtError_t error;
    void *addr = nullptr;
    error = rtsGetHardwareSyncAddr(&addr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, rtsCmoAsyn_testCmoType)
{
    uint64_t srcAddr = 0;
    rtError_t error = rtsCmoAsync(&srcAddr, 5, RT_CMO_PREFETCH, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsCmoAsync(&srcAddr, 0, RT_CMO_WRITEBACK, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    // srcLen is zero invalid
    error = rtsCmoAsync(&srcAddr, 0, RT_CMO_INVALID, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    // srcLen is zero invalid
    error = rtsCmoAsync(&srcAddr, 0, RT_CMO_FLUSH, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest, rtsCheckMemType)
{
    rtError_t error;
    void *addr = nullptr;
    uint32_t result;
    error = rtsCheckMemType(&addr, 1, 2, &result, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    uint32_t flag = RT_MEMORY_ATTRIBUTE_READONLY | RT_MEMORY_DDR | RT_MEMORY_POLICY_HUGE_PAGE_ONLY | 0x40000000;
    void * devPtr = nullptr;
    error = rtDvppMallocWithFlag(&devPtr, 60, flag, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    MOCKER(halMemGetInfo).stubs().will(returnValue(DRV_ERROR_IOCRL_FAIL));
    error = rtsCheckMemType(&devPtr, 1, 8, &result, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_DRV_INTERNAL_ERROR);
    error = rtDvppFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, rtsCmoAsyncWithBarrier_test)
{
    uint64_t srcAddr = 0;
    uint32_t logicId= 1;
    rtError_t error = rtsCmoAsyncWithBarrier(&srcAddr, 4, RT_CMO_PREFETCH, logicId, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(CloudV2ApiTest, rtsDeviceStatusQuery_01)
{
    rtError_t error = RT_ERROR_NONE;
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    uint32_t devId = 0U;
    RawDevice *dev = new RawDevice(devId);
    rtDeviceStatus deviceStatus = RT_DEVICE_STATUS_NORMAL;
    error = rtInstance->SetWatchDogDevStatus(dev, RT_DEVICE_STATUS_ABNORMAL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsDeviceStatusQuery(devId, &deviceStatus);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete dev;
}

TEST_F(CloudV2ApiTest, rtsDvppLaunch_test_03)
{
    rtError_t error;
    void *args[] = {&error, NULL};
    void *stubFunc;

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    cce::runtime::rtStarsCommonSqe_t sqe = {};
    sqe.sqeHeader.type = RT_STARS_SQE_TYPE_VPC;
    rtDvppAttr_t attr = {RT_DVPP_MAX, true};
    rtDvppCfg_t cfg = {&attr, 1};
    error = rtLaunchDvppTask(&sqe, sizeof(cce::runtime::rtStarsCommonSqe_t), stream_, &cfg);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    attr.id = RT_DVPP_CMDLIST_NOT_FREE;
    attr.value.isCmdListNotFree = false;
    error = rtLaunchDvppTask(&sqe, sizeof(cce::runtime::rtStarsCommonSqe_t), stream_, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, cache_last_task_opinfo_coverage_apidecorator)
{
    rtError_t error;
    ApiImpl *apiImpl = new ApiImpl();
    ApiDecorator api(apiImpl);
    char rawInfo[] = "test_op_info_data";
    size_t infoSize = sizeof(rawInfo);

    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::CacheLastTaskOpInfo)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = api.CacheLastTaskOpInfo(rawInfo, infoSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete apiImpl;
}

TEST_F(CloudV2ApiTest, cache_last_task_opinfo_coverage_apierrordecorator)
{
    rtError_t error;
    ApiImpl *apiImpl = new ApiImpl();
    ApiErrorDecorator api(apiImpl);
    char rawInfo[] = "test_op_info_data";
    size_t infoSize = sizeof(rawInfo);

    error = api.CacheLastTaskOpInfo(nullptr, infoSize);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    char rawInfo1[] = "";
    error = api.CacheLastTaskOpInfo(rawInfo1, 0U);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = api.CacheLastTaskOpInfo(rawInfo, 65537U);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::CacheLastTaskOpInfo)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = api.CacheLastTaskOpInfo(rawInfo, infoSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete apiImpl;
}

TEST_F(CloudV2ApiTest, cache_last_task_opinfo_coverage_apiprofiledecorator)
{
    rtError_t error;
    ApiImpl impl;
    Profiler profiler(nullptr);
    ApiProfileDecorator api(&impl, &profiler);
    char rawInfo[] = "test_op_info_data";
    size_t infoSize = sizeof(rawInfo);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::CacheLastTaskOpInfo)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = api.CacheLastTaskOpInfo(rawInfo, infoSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, cache_last_task_opinfo_coverage_apiprofilelogdecorator)
{
    rtError_t error;
    ApiImpl impl;
    Profiler profiler(nullptr);
    ApiProfileLogDecorator api(&impl, &profiler);
    char rawInfo[] = "test_op_info_data";
    size_t infoSize = sizeof(rawInfo);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::CacheLastTaskOpInfo)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = api.CacheLastTaskOpInfo(rawInfo, infoSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, rtCacheLastTaskOpInfo_success)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtStreamAttrValue_t setvalue;
    rtStreamAttrValue_t stmModeRet;

    char rawInfo[] = "test_op_info_data";
    size_t infoSize = sizeof(rawInfo);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    setvalue = {0};
    setvalue.cacheOpInfoSwitch = 1;
    error = rtsStreamSetAttribute(stream, RT_STREAM_ATTR_CACHE_OP_INFO, &setvalue);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream * const exeStream = static_cast<Stream *>(stream);
    Stream* captureStream = exeStream->GetCaptureStream();
    MOCKER_CPP(&StreamSqCqManage::GetStreamById)
        .stubs()
        .with(mockcpp::any(), outBoundP(&captureStream), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    TaskInfo task = {};
    InitByStream(&task, captureStream);
    MOCKER_CPP(&TaskFactory::GetTask).stubs().will(returnValue(&task));
    error = rtCacheLastTaskOpInfo(rawInfo, infoSize);
    EXPECT_EQ(error, RT_ERROR_NONE);

    stmModeRet = {0};
    error = rtsStreamGetAttribute(stream, RT_STREAM_ATTR_CACHE_OP_INFO, &stmModeRet);
    EXPECT_EQ(stmModeRet.cacheOpInfoSwitch, 1);

    Runtime *rt = ((Runtime *)Runtime::Instance());
    Profiler* profiler = rt->profiler_;
    profiler->ReportCacheShapeInfo();

    MOCKER(MsprofReportAdditionalInfo).stubs().will(returnValue((int)1));
    profiler->ReportCacheShapeInfo();

    const size_t totalSize = sizeof(MsprofShapeInfo) + sizeof(MsprofShapeHeader) + infoSize;
    auto rawMemPtr = std::make_unique<uint8_t []>(totalSize);
    MsprofShapeInfo *shapeInfo = RtPtrToPtr<MsprofShapeInfo *, uint8_t *>(rawMemPtr.get());
    shapeInfo->dataLen = 0U;
    Model* mdl = captureStream->Model_();
    CaptureModel *captureMdl = dynamic_cast<CaptureModel *>(mdl);
    captureMdl->AddShapeInfo(rawMemPtr);
    profiler->ReportCacheShapeInfo();

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, rtCacheLastTaskOpInfo_switch_off)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;

    char rawInfo[] = "test_op_info_data";
    size_t infoSize = sizeof(rawInfo);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream * const exeStream = static_cast<Stream *>(stream);
    Stream* captureStream = exeStream->GetCaptureStream();
    MOCKER_CPP(&StreamSqCqManage::GetStreamById)
        .stubs()
        .with(mockcpp::any(), outBoundP(&captureStream), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    error = rtCacheLastTaskOpInfo(rawInfo, infoSize);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, rtCacheLastTaskOpInfo_task_null)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtStreamAttrValue_t setvalue;

    char rawInfo[] = "test_op_info_data";
    size_t infoSize = sizeof(rawInfo);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream * const exeStream = static_cast<Stream *>(stream);
    Stream* captureStream = exeStream->GetCaptureStream();
    MOCKER_CPP(&StreamSqCqManage::GetStreamById)
        .stubs()
        .with(mockcpp::any(), outBoundP(&captureStream), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    setvalue = {0};
    setvalue.cacheOpInfoSwitch = 1;
    error = rtsStreamSetAttribute(stream, RT_STREAM_ATTR_CACHE_OP_INFO, &setvalue);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCacheLastTaskOpInfo(rawInfo, infoSize);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, rtCacheLastTaskOpInfo_memcpy_error)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtStreamAttrValue_t setvalue;
    rtStreamAttrValue_t stmModeRet;

    char rawInfo[] = "test_op_info_data";
    size_t infoSize = sizeof(rawInfo);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    setvalue = {0};
    setvalue.cacheOpInfoSwitch = 1;
    error = rtsStreamSetAttribute(stream, RT_STREAM_ATTR_CACHE_OP_INFO, &setvalue);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream * const exeStream = static_cast<Stream *>(stream);
    Stream* captureStream = exeStream->GetCaptureStream();
    MOCKER_CPP(&StreamSqCqManage::GetStreamById)
        .stubs()
        .with(mockcpp::any(), outBoundP(&captureStream), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    TaskInfo task = {};
    InitByStream(&task, captureStream);
    MOCKER_CPP(&TaskFactory::GetTask).stubs().will(returnValue(&task));

    MOCKER(memcpy_s).stubs().will(returnValue((int)1));

    error = rtCacheLastTaskOpInfo(rawInfo, infoSize);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, set_stream_cache_opinfo_switch_coverage_apierrordecorator)
{
    rtError_t error;
    rtStream_t stream;

    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    uint32_t cacheOpInfoSwitch = 1;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = api.SetStreamCacheOpInfoSwitch(nullptr, cacheOpInfoSwitch);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    Stream * const exeStream = static_cast<Stream *>(stream);
    const uint32_t invalidCacheOpInfoSwitch = 3;
    error = api.SetStreamCacheOpInfoSwitch(exeStream, invalidCacheOpInfoSwitch);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, get_stream_cache_opinfo_switch_coverage_apierrordecorator)
{
    rtError_t error;
    rtStream_t stream;

    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    uint32_t cacheOpInfoSwitch = 1;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = api.GetStreamCacheOpInfoSwitch(nullptr, &cacheOpInfoSwitch);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    Stream * const exeStream = static_cast<Stream *>(stream);
    error = api.GetStreamCacheOpInfoSwitch(exeStream, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, set_stream_cache_opinfo_switch_coverage_apidecorator)
{
    rtError_t error;
    rtStream_t stream;

    ApiImpl impl;
    ApiDecorator api(&impl);
    uint32_t cacheOpInfoSwitch = 1;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::SetStreamCacheOpInfoSwitch)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    Stream * const exeStream = static_cast<Stream *>(stream);
    error = api.SetStreamCacheOpInfoSwitch(exeStream, cacheOpInfoSwitch);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest, get_stream_cache_opinfo_switch_coverage_apidecorator)
{
    rtError_t error;
    rtStream_t stream;

    ApiImpl impl;
    ApiDecorator api(&impl);
    uint32_t cacheOpInfoSwitch = 1;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetStreamCacheOpInfoSwitch)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    Stream * const exeStream = static_cast<Stream *>(stream);
    error = api.GetStreamCacheOpInfoSwitch(exeStream, &cacheOpInfoSwitch);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
