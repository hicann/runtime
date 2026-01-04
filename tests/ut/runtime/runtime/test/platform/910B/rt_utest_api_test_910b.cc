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

class ApiTest910B : public testing::Test
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

        std::cout<<"910B api test start:"<<error1<<", "<<error2<<", "<<error3<<", "<<error4<<std::endl;
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
rtStream_t ApiTest910B::stream_ = NULL;
rtEvent_t ApiTest910B::event_ = NULL;
void* ApiTest910B::binHandle_ = nullptr;
char  ApiTest910B::function_ = 'a';
uint32_t ApiTest910B::binary_[32] = {};
Driver* ApiTest910B::driver_ = NULL;


rtError_t rtStarsGetEventId(int deviceId, uint32_t count, rtKpEventIdType_t *eventId);
rtError_t rtStarsReleaseEventId(int deviceId, uint32_t count, rtKpEventIdType_t *eventId);

rtError_t MemcpyAsyncCheckKindAndLocationStub(rtMemcpyKind_t *kind, rtMemoryType_t &srcLocationType,
    rtMemoryType_t &dstLocationType, const void *const src, void *const dst)
{
    srcLocationType = RT_MEMORY_TYPE_USER;
    dstLocationType = RT_MEMORY_TYPE_DEVICE;
    *kind = RT_MEMCPY_HOST_TO_DEVICE;
    return RT_ERROR_NONE;
}

TEST_F(ApiTest910B, event_create_and_destroy)
{
    rtError_t error;
    rtEvent_t event;

    error = rtEventCreate(NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, event_destroy_null)
{
    rtError_t error;
    error = rtEventDestroy(NULL);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, event_destroysync_null)
{
    rtError_t error;
    error = rtEventDestroySync(NULL);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, event_destroysync_notsupport)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    bool oldFlag = rtInstance->GetDisableThread();
    rtInstance->SetDisableThread(true);
    Context * const curCtx = Runtime::Instance()->CurrentContext();
    EXPECT_EQ(curCtx != nullptr, true);
    Device * const dev = curCtx->Device_();
    EXPECT_EQ(dev != nullptr, true);
    MOCKER_CPP_VIRTUAL(dev, &Device::CheckFeatureSupport)
    .stubs()
    .will(returnValue(false));

    error = rtEventDestroySync(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    rtInstance->SetDisableThread(oldFlag);
}

TEST_F(ApiTest910B, rtEventDestroySync_test2)
{
    rtError_t error;
    rtEvent_t event;

    error = rtEventCreate(&event);
    Event *eventObj = (Event*) event;
    EXPECT_EQ(error, RT_ERROR_NONE);;

    Context * const curCtx = Runtime::Instance()->CurrentContext();
    EXPECT_EQ(curCtx != nullptr, true);
    Device * const dev = curCtx->Device_();
    EXPECT_EQ(dev != nullptr, true);
    MOCKER_CPP_VIRTUAL(dev, &Device::CheckFeatureSupport)
    .stubs()
    .will(returnValue(true));

    error = rtEventDestroySync(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(ApiTest910B, rtEventDestroySync_test4)
{
    rtError_t error;
    rtEvent_t event;

    error = rtEventCreate(&event);
    Event *eventObj = (Event*) event;
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&Event::IsEventTaskEmpty).stubs().will(returnValue(false)).then(returnValue(true));
    MOCKER_CPP_VIRTUAL(eventObj, &Event::ReclaimTask).stubs().will(returnValue(RT_ERROR_END_OF_SEQUENCE));

    error = eventObj->WaitForBusy();

    MOCKER_CPP(&Event::IsEventTaskEmpty).stubs().will(returnValue(false)).then(returnValue(true));
    MOCKER_CPP(&Event::GetFailureStatus).stubs().will(returnValue(RT_ERROR_END_OF_SEQUENCE));
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    bool oldFlag = rtInstance->GetDisableThread();
    rtInstance->SetDisableThread(true);

    Context * const curCtx = Runtime::Instance()->CurrentContext();
    EXPECT_EQ(curCtx != nullptr, true);
    Device * const dev = curCtx->Device_();
    EXPECT_EQ(dev != nullptr, true);
    MOCKER_CPP_VIRTUAL(dev, &Device::CheckFeatureSupport)
    .stubs()
    .will(returnValue(false));

    error = rtEventDestroySync(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    rtInstance->SetDisableThread(oldFlag);
}

TEST_F(ApiTest910B, event_record_null)
{
    rtError_t error;
    error = rtEventRecord(NULL, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, event_reset_null)
{
    rtError_t error;
    error = rtEventReset(NULL, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, writevalue)
{
    rtError_t ret = RT_ERROR_NONE;
    ret = rtWriteValue(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    ret = rtWriteValuePtr(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, dqs_test)
{
    rtError_t ret = RT_ERROR_NONE;
    ret = rtsDqsSchedConfig(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtsDqsNotifyWait(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtsDqsDequeue(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtsDqsZeroCopy(nullptr, RT_DQS_ZERO_COPY_INPUT, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    ret = rtsDqsPrepare(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtsDqsEnqueue(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtsDqsFree(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtsFrameAlign(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtsDqsSchedEnd(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtsDqsInterChipInit(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtsDqsLaunchAdspcTask(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTest910B, xpu_Normal)
{
    rtError_t error;
    error = rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, event_work_Normal)
{
    rtError_t error;
    error = rtEventWorkModeSet(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, cm0_task_normal)
{
    rtError_t error;
    rtCmoTaskCfg_t cmoTaskCfg = {};
    cmoTaskCfg.cmoType = RT_CMO_PREFETCH;
    error = rtsLaunchCmoTask(&cmoTaskCfg, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    cmoTaskCfg.cmoType = RT_CMO_WRITEBACK;
    error = rtsLaunchCmoTask(&cmoTaskCfg, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, AI_CPU_KERNEL_LAUNCH_TEST)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t aiCpuCnt = 0U;
    Api *api = Api::Instance();
    MOCKER_CPP_VIRTUAL(api, &Api::GetAiCpuCount)
    .stubs()
    .with(outBoundP(&aiCpuCnt, sizeof(aiCpuCnt)))
    .will(returnValue(RT_ERROR_NONE));

    rtSmDesc_t desc;
    const rtKernelLaunchNames_t name = {
        "soName",
        "kernelName",
        "opName"
    };
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    void *args[] = {&error, NULL};
    rtArgsEx_t argsInfo = {};
    argsInfo.args = args;
    argsInfo.argsSize = sizeof(args);

    error = rtAicpuKernelLaunchWithFlag(&name, 1, &argsInfo, &desc, stream, 2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, memcpy2d_async_host_to_device_cloud_device2host)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    error = rtMallocHost(&hostPtr, 100, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 100, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Api *api = Api::Instance();
    MOCKER_CPP_VIRTUAL(api, &Api::MemCopy2DAsync).stubs().will(returnValue(RT_ERROR_NONE));
    error = rtMemcpy2dAsync(hostPtr, 100, devPtr, 100, 10, 1, RT_MEMCPY_DEVICE_TO_HOST, stream_);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, rtEschedSubscribeEvent)
{
    int32_t device = 0;
    uint32_t grpId = 0;
    uint32_t threadId = 0;
    uint64_t eventBitmap = 0;

    rtError_t error = rtEschedSubscribeEvent(device, grpId, threadId, eventBitmap);
    EXPECT_EQ(error, RT_ERROR_NONE);

    drvError_t code = DRV_ERROR_INVALID_VALUE;
    MOCKER(halEschedSubscribeEvent)
        .stubs()
        .will(returnValue(code));
    error = rtEschedSubscribeEvent(device, grpId, threadId, eventBitmap);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, onlineprof)
{
    rtError_t error;
    ProfilefDataInfo ProfilefData_t = {0};
    void *args[] = {&error, NULL};

    MOCKER(halMemAlloc)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtStartOnlineProf(stream_, 1);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStopOnlineProf(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, onlineprof2)
{
    rtError_t error;
    ProfilefDataInfo ProfilefData_t = {0};
    void *args[] = {&error, NULL};

    MOCKER(halMemAlloc)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtStartOnlineProf(stream_, 1);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtGetOnlineProfData(stream_, &ProfilefData_t, 1);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStopOnlineProf(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, notify_ipc2)
{
    rtNotify_t notify;
    rtError_t error;
    int32_t device_id = 0;
    uint64_t devAddrOffset = 0;

    error = rtIpcOpenNotify(&notify, "test_ipc");
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyWait(notify, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyGetAddrOffset(notify, &devAddrOffset);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyGetAddrOffset(NULL, &devAddrOffset);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtNotifyGetAddrOffset(notify, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtNotifyDestroy(notify);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, ipc_set_notify_pid3)
{
    rtNotify_t notify;
    rtError_t error;
    int32_t device_id = 0;
    uint64_t devAddrOffset = 0;
    int32_t pid[]={1};
    int num = 1;

    error = rtIpcOpenNotify(&notify, "test_ipc");
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetIpcNotifyPid( "test_ipc",pid,num);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyWait(notify, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyGetAddrOffset(notify, &devAddrOffset);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyGetAddrOffset(NULL, &devAddrOffset);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtNotifyGetAddrOffset(notify, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtNotifyDestroy(notify);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, debug_register_for_stream)
{
    rtStream_t stream;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t stream_id;
    uint32_t task_id;

    error = rtDebugRegisterForStream(stream, 1, (const void*)0x1, &stream_id, &task_id);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDebugUnRegisterForStream(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, QueryFunctionRegistered)
{
    rtError_t error;

    error = rtQueryFunctionRegistered("foo");
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtQueryFunctionRegistered("fooooo");
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtQueryFunctionRegistered(NULL);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, device_binary_register_null)
{
    rtError_t error;
    void *handle;

    error = rtDevBinaryRegister(NULL, &handle);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtDevBinaryUnRegister(NULL);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, function_register_null)
{
    rtError_t error;

    error = rtFunctionRegister(NULL, NULL, NULL, NULL, 0);
    EXPECT_NE(error, RT_ERROR_NONE);
}


TEST_F(ApiTest910B, get_device_count)
{
    rtError_t error;
    int32_t count;

    error = rtGetDeviceCount(&count);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(drvGetDevNum).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtGetDeviceCount(&count);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, get_device_id)
{
    rtError_t error;
    int32_t count;
    uint32_t device_arr[2];
    error = rtGetDeviceCount(&count);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Api *api = Api::Instance();
    MOCKER_CPP_VIRTUAL(api, &Api::GetDeviceIDs).stubs().will(returnValue(RT_ERROR_NONE));
    error = rtGetDeviceIDs(device_arr, 2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(ApiTest910B, get_device_handle)
{
    rtError_t error;
    int32_t handle;

    error = rtGetDevice(&handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsGetDevice(&handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, get_priority_range)
{
    rtError_t error;
    int32_t leastPriority;
    int32_t greatestPriority;

    error = rtDeviceGetStreamPriorityRange(&leastPriority, &greatestPriority);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, get_priority_range_coverage)
{
    rtError_t error;
    int32_t leastPriority;
    int32_t greatestPriority;

    ApiImpl impl;
    ApiDecorator api(&impl);

    error = api.DeviceGetStreamPriorityRange(&leastPriority, &greatestPriority);
    EXPECT_EQ(error, RT_ERROR_NONE);
    uint32_t tag = 0;
    error = api.SetStreamTag((cce::runtime::Stream*)stream_, tag);
    error = api.GetStreamTag((cce::runtime::Stream*)stream_, &tag);
}

TEST_F(ApiTest910B, nop_task_api_test_01)
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

TEST_F(ApiTest910B, rtCheckArchCompatibility_socVersion)
{
    rtError_t error;
    char version[50] = {0};
    int32_t canCompatible = 0;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtArchType_t oriArchType = rtInstance->GetArchType();

    rtInstance->SetArchType(ARCH_C220);

    // OmSocVersion is null
    error = rtCheckArchCompatibility(nullptr, &canCompatible);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtCheckArchCompatibility("Ascend910B1", nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    // OmSocVersion is ""
    error = rtCheckArchCompatibility("", &canCompatible);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    // OmSocVersion is not find
    error = rtCheckArchCompatibility("Ascend000", &canCompatible);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    // OmSocVersion is same as archType
    error = rtCheckArchCompatibility("Ascend910B1", &canCompatible);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    // restore all type
    rtInstance->SetArchType(oriArchType);
}

TEST_F(ApiTest910B, ai_cpu_info_load_test_01)
{
    rtError_t error;
    rtStream_t stream;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Context * const curCtx = Runtime::Instance()->CurrentContext();
    EXPECT_EQ(curCtx != nullptr, true);
    Device * const dev = curCtx->Device_();
    EXPECT_EQ(dev != nullptr, true);
    MOCKER_CPP_VIRTUAL(dev, &Device::CheckFeatureSupport)
    .stubs()
    .will(returnValue(true));
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    char aicpu_info[16] = "aicpu info";
    error = rtAicpuInfoLoad((const void *)aicpu_info, 16);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, get_phyid_by_index)
{
    rtError_t error;
    uint32_t devIndex;
    uint32_t phyId;

    ApiImpl impl;
    ApiDecorator api(&impl);

    error = api.GetDevicePhyIdByIndex(devIndex, &phyId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, get_index_by_phyid)
{
    rtError_t error;
    uint32_t devIndex;
    uint32_t phyId;

    ApiImpl impl;
    ApiDecorator api(&impl);

    error = api.GetDeviceIndexByPhyId(phyId, &devIndex);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, device_mem_null_memfree)
{
    rtError_t error;
    rtContext_t ctx = nullptr;
    void * devPtr;

    error = rtMalloc(&devPtr, 60, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&ApiImpl::CurrentContext)
        .stubs()
        .will(invoke(CurrentContextStub));

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, device_mem_null_rtHostFree)
{
    rtError_t error;
    rtContext_t ctx = nullptr;
    void * devPtr;

    error = rtMallocHost(&devPtr, 60, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&ApiImpl::CurrentContext)
        .stubs()
        .will(invoke(CurrentContextStub));

    error = rtFreeHost(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, device_mem_null_DvppFree)
{
    rtError_t error;
    rtContext_t ctx = nullptr;
    void * devPtr;

    error = rtDvppMalloc(&devPtr, 60, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&ApiImpl::CurrentContext)
        .stubs()
        .will(invoke(CurrentContextStub));

    error = rtDvppFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, device_mem_null_ManageMemFree)
{
    rtError_t error;
    rtContext_t ctx = nullptr;
    void * devPtr;

    error = rtMemAllocManaged(&devPtr, 60, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&ApiImpl::CurrentContext)
        .stubs()
        .will(invoke(CurrentContextStub));

    error = rtMemFreeManaged(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, device_mem_alloc_free)
{
    rtError_t error;
    void * devPtr;

    error = rtMalloc(&devPtr, 60, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, device_dvpp_mem_alloc_free)
{
    rtError_t error;
    void * devPtr;

    error = rtDvppMalloc(&devPtr, 60, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDvppFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, device_dvpp_with_flag_mem_alloc_free)
{
    uint32_t flag = RT_MEMORY_ATTRIBUTE_READONLY;
    void * devPtr = nullptr;
    rtError_t error = rtDvppMallocWithFlag(&devPtr, 60, flag, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDvppFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, device_dvpp_with_flag_hbm_mem_alloc_free)
{
    uint32_t flag = RT_MEMORY_ATTRIBUTE_READONLY | RT_MEMORY_HBM | RT_MEMORY_POLICY_HUGE_PAGE_ONLY;
    void * devPtr = nullptr;
    rtError_t error = rtDvppMallocWithFlag(&devPtr, 60, flag, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDvppFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, device_dvpp_with_flag_ddr_mem_alloc_free)
{
    uint32_t flag = RT_MEMORY_ATTRIBUTE_READONLY | RT_MEMORY_DDR | RT_MEMORY_POLICY_HUGE_PAGE_ONLY | 0x40000000;
    void * devPtr = nullptr;
    rtError_t error = rtDvppMallocWithFlag(&devPtr, 60, flag, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDvppFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, device_dvpp_with_flag_ddr_mem_alloc_failed)
{
    MOCKER(halMemAlloc)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    uint32_t flag = RT_MEMORY_ATTRIBUTE_READONLY | RT_MEMORY_DDR | RT_MEMORY_POLICY_HUGE_PAGE_ONLY | 0x40000000;
    void * devPtr = nullptr;
    rtError_t error = rtDvppMallocWithFlag(&devPtr, 60, flag, DEFAULT_MODULEID);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, device_cache_mem_alloc_free)
{
    rtError_t error;
    void *devMem;
    error = rtMallocCached((void**)&devMem, 100 * sizeof(uint32_t), 2, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFlushCache(devMem, 100 * sizeof(uint32_t));
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtInvalidCache(devMem, 100 * sizeof(uint32_t));
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devMem);
    EXPECT_EQ(error, RT_ERROR_NONE);

    devMem = NULL;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtMallocCached((void**)&devMem, 100 * sizeof(uint32_t), 2, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devMem);
}

TEST_F(ApiTest910B, device_cache_mem_alloc_free_02)
{
    rtError_t error;
    void *devMem;
    error = rtMallocCached((void**)&devMem, 100 * sizeof(uint32_t), 2, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemFlushCache(devMem, 100 * sizeof(uint32_t));
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemInvalidCache(devMem, 100 * sizeof(uint32_t));
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devMem);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, rts_memset_sync)
{
    rtError_t error;
    void * devPtr;
    rtMallocConfig_t * p = nullptr;
    error = rtsMalloc(&devPtr, 60, RT_MEM_MALLOC_HUGE_FIRST, RT_MEM_ADVISE_NONE, p);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, memset_sync)
{
    rtError_t error;
    void * devPtr;

    error = rtMalloc(&devPtr, 60, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, memset_sync_2)
{
    rtError_t error;
    void * devPtr;

    error = rtMalloc(&devPtr, 60, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, memset_async_host)
{
    rtError_t error;
    void * hostPtr;

    NpuDriver * rawDrv = new NpuDriver();

    uint32_t memsize = 64;
    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_2));

    error = rtMallocHost(&hostPtr, memsize+1, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemsetAsync(hostPtr, memsize+1, 0, memsize+1, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFreeHost(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(ApiTest910B, memcpy_async_host_to_device_Not_support_user_mem)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    uint64_t memsize = 64;

    Context *curCtx = Runtime::Instance()->CurrentContext();
    EXPECT_EQ(curCtx != nullptr, true);
    RawDevice *device = (RawDevice *)(curCtx->Device_());
    EXPECT_EQ(device != nullptr, true);
    bool isSupportUserMem = device->IsSupportUserMem();
    device->isDrvSupportUserMem_ = false;

    hostPtr = malloc(memsize);

    error = rtMalloc(&devPtr, memsize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyAsync(devPtr, memsize, hostPtr, memsize, RT_MEMCPY_HOST_TO_DEVICE, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    free(hostPtr);

    device->isDrvSupportUserMem_ = isSupportUserMem;
}


TEST_F(ApiTest910B, dsa_update_coverage_apidecorator)
{
    rtError_t error;
    uint32_t dsaStreamId = 0;
    uint32_t dsaTaskId = 0;
    ApiImpl *apiImpl = new ApiImpl();
    ApiDecorator api(apiImpl);

    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LaunchSqeUpdateTask)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = api.LaunchSqeUpdateTask(dsaStreamId, dsaTaskId, nullptr, 40U, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete apiImpl;
}

TEST_F(ApiTest910B, memsetAsync_coverage)
{
    void *hostPtr;
    void *devPtr;
    ApiImpl impl;
    ApiDecorator api(&impl);
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemsetAsync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    rtError_t error = api.MemsetAsync(devPtr, 60, 0, 60, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

drvError_t drvDeviceGetChannelTypeByAddrStubD2d(void *src, void* dest, uint8_t *Channel_type, uint32_t *HCCS_id)
{
    *Channel_type = 0;
    *HCCS_id = 0;
    return DRV_ERROR_NONE;
}

TEST_F(ApiTest910B, dev_sync_null)
{
    int32_t devId;
    rtError_t error;

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);


    error = rtDeviceSynchronize();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
}

TEST_F(ApiTest910B, dev_sync_ok)
{
    rtError_t error;

    error = rtDeviceSynchronize();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceSynchronizeWithTimeout(1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, dev_get_all)
{
    int32_t devId;
    rtError_t error;

    error = rtGetDevice(NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(devId, 0);

    error = rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
}

TEST_F(ApiTest910B, device_exchange)
{
    int32_t devId;
    rtError_t error;

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);

    error = rtSetDevice(1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error =rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
}

TEST_F(ApiTest910B, dev_default_use)
{
    rtError_t error;
    rtContext_t ctx;
    rtStream_t stream;
    int32_t devId, defaultDevId;

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxSetCurrent(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtCtxGetCurrent(&ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxGetDevice(&defaultDevId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetDevice(&defaultDevId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(defaultDevId, 0);

    error =rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, event_query_status)
{
    rtError_t error;
    rtEventStatus_t status = RT_EVENT_RECORDED;
    error = rtEventQueryStatus(NULL, &status);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtEventQueryStatus(ApiTest910B::event_, &status);
}

TEST_F(ApiTest910B, event_query_wait_status_success)
{
    rtError_t error;
    rtContext_t ctx;
    rtEvent_t event;

    rtEventWaitStatus_t status = EVENT_STATUS_MAX;

    int32_t devId = 0;
    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxCreate(&ctx, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(ctx, (rtContext_t)NULL);

    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventQueryWaitStatus(event, &status);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, event_query_wait_status_failure)
{
    rtError_t error;
    rtContext_t ctx;
    rtEvent_t event;
    Context *context = NULL;
    rtEventWaitStatus_t status = EVENT_STATUS_MAX;

    int32_t devId = 0;
    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxCreate(&ctx, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(ctx, (rtContext_t)NULL);

    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    context = (Context *)ctx;
    context->SetFailureError(RT_ERROR_END_OF_SEQUENCE);
    TsStreamFailureMode flag = context->GetCtxMode();
    context->SetCtxMode(STOP_ON_FAILURE);
    error = rtEventQueryWaitStatus(event, &status);
    EXPECT_EQ(error, ACL_ERROR_RT_END_OF_SEQUENCE);
    context->SetFailureError(RT_ERROR_NONE);
    context->SetCtxMode(flag);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, get_sqid)
{
    rtStream_t stream;
    rtError_t error = RT_ERROR_NONE;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t sqId;
    error = rtStreamGetSqid(stream, &sqId);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, context_create_and_destroy)
{
    rtError_t error;
    rtContext_t ctx;
    rtStream_t stream;

    error = rtCtxGetCurrent(&ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtCtxCreate(NULL, 0, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    int32_t devNum = 0;
    error = rtGetDeviceCount(&devNum);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxCreate(&ctx, 0, devNum);
    EXPECT_NE(error, RT_ERROR_NONE);

    int32_t devId = 0;
    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxCreate(&ctx, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(ctx, (rtContext_t)NULL);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t current = NULL;
    error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(current, ctx);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, context_set_and_get)
{
    rtError_t error;
    rtContext_t ctxA, ctxB;
    rtContext_t current = NULL;
    int32_t currentDevId = -1;

    error = rtCtxGetDevice(NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtCtxGetCurrent(NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    int32_t devId = 0;
    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxGetDevice(&currentDevId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(currentDevId, devId);

    error = rtCtxCreate(&ctxA, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxCreate(&ctxB, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxSetCurrent(ctxA);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxGetDevice(&currentDevId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(currentDevId, devId);

    error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(current, ctxA);

    error = rtCtxSetCurrent(ctxB);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxGetDevice(&currentDevId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(currentDevId, devId);

    error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(current, ctxB);

    error = rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctxA);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctxB);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, context_sync)
{
    rtError_t error;
    rtContext_t ctx;

    int32_t devId = 0;
    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxCreate(&ctx, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, context_sync_failMode_stream_failed)
{
    rtError_t error;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_SET_STREAM_MODE);

    Stream *stream = nullptr;
    error = rtStreamSetMode(stream, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtStream_t stm;
    error = rtStreamCreate(&stm, 0);
    stream = static_cast<Stream *>(stm);

    stream->failureMode_ = STOP_ON_FAILURE;
    MOCKER_CPP(&Stream::Synchronize)
        .stubs()
        .will(returnValue(RT_ERROR_TSFW_AICORE_TRAP_EXCEPTION));

    error = rtStreamDestroy(stm);
    device->SetTschVersion(version);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiTest910B, context_sync_stream_failed)
{
    rtError_t error;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_SET_STREAM_MODE);

    Stream *stream = nullptr;
    error = rtStreamSetMode(stream, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtStream_t stm;
    error = rtStreamCreate(&stm, 0);
    stream = static_cast<Stream *>(stm);

    MOCKER_CPP(&Stream::Synchronize)
        .stubs()
        .will(returnValue(RT_ERROR_TSFW_AICORE_TRAP_EXCEPTION));

    error = rtStreamDestroy(stm);
    device->SetTschVersion(version);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiTest910B, device_memory_ddr)
{
    rtError_t error;
    uint32_t info = RT_RUN_MODE_ONLINE;
    void *devPtr = (void *)0x100;
    void *devPtr1 = (void *)0x200;
    void *devPtr2 = (void *)0x300;
    void *devPtr3 = (void *)0x400;
    int64_t devInfo;

    MOCKER(drvGetPlatformInfo).stubs().with(outBoundP(&info, sizeof(info))).will(returnValue(DRV_ERROR_NONE));

    error = rtMalloc(&devPtr, 64, RT_MEMORY_DDR, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr1, 2*1024*1024, RT_MEMORY_DDR, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr2, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr3, 2*1024*1024, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr3);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

void taskFailCallbackByMode(rtExceptionInfo_t *exceptionInfo)
{
    printf("taskFailCallbackByMode, taskid=[%d],streamid=[%d],tid=[%d],deviceid=[%d],retcode=[%d]",
	exceptionInfo->taskid,exceptionInfo->streamid,exceptionInfo->tid,exceptionInfo->deviceid, exceptionInfo->retcode);
}

TEST_F(ApiTest910B, reg_taskFailByModule_callback)
{
    rtError_t error;
	char *regName ="lltruntime";
    error = rtRegTaskFailCallbackByModule(regName, taskFailCallbackByMode);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtRegTaskFailCallbackByModule(regName, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtRegTaskFailCallbackByModule(nullptr, taskFailCallbackByMode);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, reg_taskFailByModule_callback_1)
{
    rtError_t error;
	char *regName ="struntime";
    error = rtRegTaskFailCallbackByModule(regName, taskFailCallbackByMode);
    EXPECT_EQ(error, RT_ERROR_NONE);
	char *regName1 ="struntime_1";
    error = rtRegTaskFailCallbackByModule(regName1, taskFailCallbackByMode);

    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, get_dev_info)
{
    rtError_t error;
    int32_t devid = 0;
    int64_t hardwareVersion = 0;
    error = rtGetDeviceInfo(devid, MODULE_TYPE_SYSTEM, INFO_TYPE_VERSION, &hardwareVersion);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetDeviceInfo(-1, MODULE_TYPE_SYSTEM, INFO_TYPE_VERSION, &hardwareVersion);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    NpuDriver * rawDrv = new NpuDriver();
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetDeviceCount)
                    .stubs()
                    .will(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtGetDeviceInfo(devid, MODULE_TYPE_SYSTEM, INFO_TYPE_VERSION, &hardwareVersion);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    delete rawDrv;
}

TEST_F(ApiTest910B, get_phy_dev_info)
{
    rtError_t error;
    int32_t devid = 0;
    int64_t phyDevInfo = 0;

    error = rtGetPhyDeviceInfo(devid, RT_MODULE_TYPE_SYSTEM, RT_PHY_INFO_TYPE_MASTER_ID, &phyDevInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, get_dev_info_err)
{
    rtError_t error;
    int32_t devid = 0;
    int64_t hardwareVersion = 0;
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE));

    error = rtGetDeviceInfo(devid, RT_MODULE_TYPE_VECTOR_CORE, INFO_TYPE_VERSION, &hardwareVersion);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, advise_mem)
{
    rtError_t error;

    uint64_t size = 128;
    uint32_t advise = 1;
    void *ptr = NULL;

    error = rtMemAllocManaged(&ptr, size, 0, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemFreeManaged(ptr);
}

TEST_F(ApiTest910B, prefetch_mem)
{
    rtError_t error;
    uint64_t size = 128;
    int32_t device = 0;
    void *ptr = NULL;

    error = rtMemAllocManaged(&ptr, size, 0, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemPrefetchToDevice(ptr, size, device);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemFreeManaged(ptr);
}

extern "C" drvError_t halMemAdvise(DVdeviceptr ptr, size_t count, unsigned int advise, DVdevice device);

void excptCallback(rtExceptionType type)
{
    printf("this is app exception callback, exception type=%d\n", type);
}

TEST_F(ApiTest910B, api_error_test)
{
    rtError_t error;
    Event *event = NULL;
    Event event1;
    Context *ctx = NULL;
    Stream *stream = NULL;
    const char *name=NULL;
    rtAiCoreMemorySize_t memSize = {0,0,0,0,0,0,0};

    error = rtCtxSetCurrent(ctx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtNameStream(stream, name);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtNameStream(&stream_, name);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtNameEvent(event, name);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtNameEvent(&event1, name);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtMemGetInfo(NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtMemGetInfoByType(0, RT_MEM_INFO_TYPE_AI_NUMA_INFO, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtMemGetInfoEx(RT_MEMORYINFO_HBM_NORMAL, NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, api_error_test_coverage)
{
    rtError_t error;
    Event *event = NULL;
    Event event1;
    Context *ctx = NULL;
    Stream *stream = NULL;
    const char *name = NULL;
    rtAiCoreMemorySize_t memSize = {0,0,0,0,0,0,0};

    ApiImpl impl;
    ApiDecorator api(&impl);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ContextSetCurrent)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));
    error = api.ContextSetCurrent(ctx);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::NameStream)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));
    error = api.NameStream(stream, name);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::NameEvent)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));
    error = api.NameEvent(event, name);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    size_t *free;
    size_t *total;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemGetInfo)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));
    error = api.MemGetInfo(free, total);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(ApiTest910B, get_aiCoreCount_test_null)
{
    rtError_t error;
    uint32_t *aiCoreCnt;
    aiCoreCnt = (uint32_t *)malloc(sizeof(uint32_t));

    error = rtGetAiCoreCount((uint32_t *)NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    free(aiCoreCnt);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    bool tmp = rtInstance->isHaveDevice_;
    rtInstance->isHaveDevice_ = false;
    error = rtGetAiCoreCount((uint32_t *)NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    rtInstance->isHaveDevice_ = tmp;
}

TEST_F(ApiTest910B, get_aiCpuCount_test)
{
    rtError_t error;
    uint32_t *aiCpuCnt;
    aiCpuCnt = (uint32_t *)malloc(sizeof(uint32_t));
    Device *rawDevice = new RawDevice(0);
    rawDevice->SetPlatformType(PLATFORM_910B1);

    error = rtGetAiCpuCount(aiCpuCnt);

    EXPECT_EQ(error, RT_ERROR_NONE);
    free(aiCpuCnt);
    delete rawDevice;
}

TEST_F(ApiTest910B, get_aiCpuCount_test_null)
{
    rtError_t error;
    uint32_t aiCpuCnt;

    error = rtGetAiCpuCount((uint32_t *)NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    bool flag = Runtime::Instance()->GetIsUserSetSocVersion();
    bool tmp = rtInstance->isHaveDevice_;
    rtInstance->isHaveDevice_ = false;
    error = rtGetAiCpuCount(&aiCpuCnt);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    rtInstance->isHaveDevice_ = tmp;
}

TEST_F(ApiTest910B, get_aiCpuCount_ctx_null)
{
    rtError_t error;
    uint32_t aiCpuCnt;
    error = rtGetAiCpuCount((uint32_t *)NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtGetAiCpuCount(&aiCpuCnt);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, RT_MEMCPY_ASYNC_TEST_1)
{
    rtError_t error;
    void *hostPtr = (void*)0x41;
    void *devPtr = (void*)0x42;
    uint64_t count = 64*1024*1024+1;

    MOCKER_CPP_VIRTUAL((Api *)(((Runtime *)Runtime::Instance())->Api_()),&Api::MemcpyAsync).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtMemcpyAsync(devPtr, count, hostPtr, count, RT_MEMCPY_DEVICE_TO_DEVICE, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, RT_MEMCPY_ASYNC_2)
{
    rtError_t error;
    void *hostPtr = (void*)0x41;
    void *devPtr = (void*)0x42;
    uint64_t count = 64*1024*1024+1;

    MOCKER_CPP_VIRTUAL((Api *)(((Runtime *)Runtime::Instance())->Api_()),&Api::MemcpyAsync).stubs().will(returnValue(RT_ERROR_NONE)).then(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtMemcpyAsync(devPtr, count, hostPtr, count, RT_MEMCPY_DEVICE_TO_DEVICE, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, memcpyasync_withoutcheckkind_host_to_device_default)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;

    error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyAsyncWithoutCheckKind(devPtr, 64, hostPtr, 64, RT_MEMCPY_DEFAULT, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, CPU_KERNEL_LAUNCH_Ex_API2)
{
    rtError_t error;
    rtStream_t stream;
    rtSmDesc_t desc;
    char_t* name = "opName";

    Api *api = Api::Instance();
    MOCKER_CPP_VIRTUAL(api, &Api::CpuKernelLaunchExWithArgs).stubs().will(returnValue(RT_ERROR_NONE));
    void *args[] = {&error, NULL};
    rtAicpuArgsEx_t argsInfo = {};
    argsInfo.args = args;
    argsInfo.argsSize = sizeof(args);
    error = rtAicpuKernelLaunchExWithArgs(2, name, 1, NULL, &desc, stream, 2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtAicpuKernelLaunchExWithArgs(4, name, 1, NULL, &desc, stream, 2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtAicpuKernelLaunchExWithArgs(1, name, 1, NULL, &desc, stream, 2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtAicpuKernelLaunchExWithArgs(100, name, 1, NULL, &desc, stream, 2);
    EXPECT_NE(error, ACL_RT_SUCCESS);
}

TEST_F(ApiTest910B, CPU_KERNEL_LAUNCH_TEST1)
{
    rtError_t error;
    ApiImpl impl;
    ApiDecorator api(&impl);
    void * devPtr;

    void *args[] = {&error, NULL};
    rtArgsEx_t argsInfo = {};
    argsInfo.args = args;
    argsInfo.argsSize = sizeof(args);
    std::string soName = "libDvpp.so";
    std::string kernelName = "DvppResize";
    rtKernelLaunchNames_t name = {reinterpret_cast<const char *>(soName.c_str()),
                                 reinterpret_cast<const char *>(kernelName.c_str()),
                                 ""};
    error = api.CpuKernelLaunch(&name, 1, &argsInfo, NULL, NULL,0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, CPU_KERNEL_LAUNCH_TEST2)
{
    rtError_t error;
    ApiImpl impl;
    ApiDecorator api(&impl);
    void * devPtr;

    void *args[] = {&error, NULL};
    rtArgsEx_t argsInfo = {};
    argsInfo.args = args;
    argsInfo.argsSize = sizeof(args);
    std::string soName = "libDvpp.so";
    std::string kernelName = "DvppResize";
    rtKernelLaunchNames_t name = {reinterpret_cast<const char *>(soName.c_str()),
                                 reinterpret_cast<const char *>(kernelName.c_str()),
                                 ""};
    uint32_t flag = 0x20;
    error = api.CpuKernelLaunch(&name, 1, &argsInfo, NULL, NULL,flag);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

rtError_t RdmaSendTaskInitStub(TaskInfo* taskInfo, const uint32_t sqId, const uint32_t wqeId)
{
    taskInfo->type = TS_TASK_TYPE_RDMA_SEND;
    taskInfo->typeName = "RDMA_SEND";
    taskInfo->u.rdmaSendTask.sqIndex = sqId;
    taskInfo->u.rdmaSendTask.wqeIndex = wqeId;
    return RT_ERROR_INVALID_VALUE;
}

TEST_F(ApiTest910B, rdma_send_test_2)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RawDevice *stubDevice = new RawDevice(0);
    stubDevice->Init();

    MOCKER(RdmaSendTaskInit).stubs().will(invoke(RdmaSendTaskInitStub));

    error = rtRDMASend(1, 1, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete stubDevice;
}

TEST_F(ApiTest910B, rdma_db_send_test_1)
{
    rtError_t error;
    int32_t devId = 0;
    rtContext_t ctxA,current;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtCtxCreate(&ctxA, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtRDMADBSend(1, 1, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_CONTEXT);
    error = rtCtxSetCurrent(current);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtCtxDestroy(ctxA);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

rtError_t RdmaDbSendTaskInitStub(TaskInfo* taskInfo, const uint32_t dbIndex, const uint64_t dbInfo)
{
    taskInfo->type = TS_TASK_TYPE_RDMA_DB_SEND;
    taskInfo->typeName = "RDMA_DB_SEND";
    taskInfo->u.rdmaDbSendTask.taskDbIndex.value = dbIndex;
    taskInfo->u.rdmaDbSendTask.taskDbInfo.value = dbInfo;

    return RT_ERROR_INVALID_VALUE;
}

TEST_F(ApiTest910B, rdma_db_send_test_2)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RawDevice *stubDevice = new RawDevice(0);
    stubDevice->Init();

    MOCKER(RdmaDbSendTaskInit).stubs().will(invoke(RdmaDbSendTaskInitStub));

    error = rtRDMADBSend(1, 1, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete stubDevice;
}

TEST_F(ApiTest910B, rdma_db_send_test_3)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtRDMADBSend(1, 1, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    GlobalMockObject::verify();

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, notify_record)
{

    rtNotify_t notify;
    rtError_t error;
    int32_t device_id = 0;

    Context *ctx = NULL;
    Api *api = Api::Instance();
    error = api->ContextGetCurrent(&ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
    RawDevice* device= (RawDevice*)ctx->Device_();
    device->platformConfig_ = 0x100;

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

    device->platformConfig_ = 0;
}

TEST_F(ApiTest910B, notify_record_01)
{
    ApiImpl apiImpl;
    Event* event;
    rtError_t error;

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiImpl.EventCreateForNotify(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiImpl.EventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, memset_rc)
{
    rtError_t error;
    void * devPtr;
    uint64_t readcount = 3;

    error = rtMalloc(&devPtr, 60, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, readcount, 60, readcount);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, model_get_taskId)
{
    rtError_t error;
    rtModel_t model;
    uint32_t taskid;
    uint32_t streamId = 0;

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelGetTaskId(model, &taskid, &streamId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, model_get_taskId_fail)
{
    rtError_t error;
    rtModel_t model;
    uint32_t taskid;
    uint32_t streamId = 0;

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ApiImpl *apiImpl = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::ModelGetTaskId).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtModelGetTaskId(model, &taskid, &streamId);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl;
}

TEST_F(ApiTest910B, dev_alloc_mem_online_exception2)
{
    void * dptr = NULL;
    rtError_t error;

    MOCKER(halMemAlloc)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE));

    NpuDriver * rawDrv = new NpuDriver();
    error = rawDrv->DevMemAllocOnline(&dptr, 2*1024*1024, RT_MEMORY_HBM, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INVALID_DEVICE);
    delete rawDrv;
}

TEST_F(ApiTest910B, dev_alloc_mem_online_exception3)
{
    void * dptr = NULL;
    rtError_t error;

    MOCKER(halMemAlloc)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE));

    NpuDriver * rawDrv = new NpuDriver();
    error = rawDrv->DevMemAllocOnline(&dptr, 1024, RT_MEMORY_HBM, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INVALID_DEVICE);
    delete rawDrv;
}

TEST_F(ApiTest910B, dev_getdevinfo_ex1)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    MOCKER(drvDeviceGetPhyIdByIndex)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE));

    NpuDriver * rawDrv = new NpuDriver();
    error = rawDrv->GetDevInfo(0, MODULE_TYPE_SYSTEM, INFO_TYPE_VERSION, NULL);

    delete rawDrv;

    error = rtInstance->startAicpuExecutor(0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtInstance->StopAicpuExecutor(0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    bool tmp = rtInstance->isHaveDevice_;
    rtInstance->isHaveDevice_ = false;
    error = rtInstance->startAicpuExecutor(0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtInstance->StopAicpuExecutor(0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->isHaveDevice_ = tmp;
}

TEST_F(ApiTest910B, dev_getdevinfo_ex2)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    error = rtInstance->startAicpuExecutor(64, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtInstance->StopAicpuExecutor(64, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

rtError_t ProfilerTraceTaskInitStub(TaskInfo* taskInfo, const uint64_t id, const bool notifyFlag, const uint32_t flags)
{
    UNUSED(flags);
    taskInfo->type = TS_TASK_TYPE_PROFILER_TRACE;
    taskInfo->typeName = "PROFILER_TRACE";
    taskInfo->u.profilertraceTask.profilerTraceId = id;
    taskInfo->u.profilertraceTask.notify = (notifyFlag) ? 1U : 0U;

    return RT_ERROR_INVALID_VALUE;
}

TEST_F(ApiTest910B, Profiler_trace_fail)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RawDevice *stubDevice = new RawDevice(0);
    stubDevice->Init();

    MOCKER(ProfilerTraceTaskInit).stubs().will(invoke(ProfilerTraceTaskInitStub));

    error = rtProfilerTrace(0, 0, 0, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete stubDevice;
}

TEST_F(ApiTest910B, Profiler_trace_ex_api_flag)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_FORBIDDEN_DEFAULT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtProfilerTraceEx(0, 0, 0, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error =rtStreamSynchronize(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, Profiler_trace_ex_fail)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RawDevice *stubDevice = new RawDevice(0);
    stubDevice->Init();

    MOCKER(ProfilerTraceExTaskInit).stubs().will(invoke(ProfilerTraceExTaskInitStub));

    error = rtProfilerTraceEx(0, 0, 0, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete stubDevice;
}

TEST_F(ApiTest910B, EnableP2P)
{
    rtError_t error;
    uint32_t devIdDes = 0;
    uint32_t phyIdSrc = 1;
    uint32_t flag = 0;

    error = rtsEnableP2P(devIdDes, phyIdSrc, flag);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEnableP2P(devIdDes, phyIdSrc, flag);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEnableP2P(devIdDes, 65, flag);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtEnableP2P(65, phyIdSrc, flag);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER(halDeviceEnableP2P)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE));

    error = rtEnableP2P(devIdDes, phyIdSrc, flag);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}

TEST_F(ApiTest910B, DisableP2P)
{
    rtError_t error;
    uint32_t devIdDes = 0;
    uint32_t phyIdSrc = 1;

    error = rtsDisableP2P(devIdDes, phyIdSrc);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDisableP2P(devIdDes, phyIdSrc);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDisableP2P(devIdDes, 65);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtDisableP2P(65, phyIdSrc);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER(halDeviceDisableP2P)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE));

    error = rtDisableP2P(devIdDes, phyIdSrc);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}

TEST_F(ApiTest910B, DeviceCanAccessPeer)
{
    rtError_t error;
    uint32_t devId = 0;
    uint32_t peerDevId = 1;
    int32_t canAccessPeer = 0;

    // online
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_1));

    error = rtsDeviceCanAccessPeer(devId, peerDevId, &canAccessPeer);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceCanAccessPeer(&canAccessPeer, devId, peerDevId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceCanAccessPeer(&canAccessPeer, devId, 65);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtDeviceCanAccessPeer(&canAccessPeer, 65, peerDevId);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER(halDeviceCanAccessPeer)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE));

    error = rtDeviceCanAccessPeer(&canAccessPeer, devId, peerDevId);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}

TEST_F(ApiTest910B, api_DeviceCanAccessPeer)
{
    rtError_t error;
    uint32_t devId = 0;
    uint32_t peerDevId = 1;
    int32_t canAccessPeer = 0;
    ApiImpl *apiImpl = new ApiImpl();
    ApiDecorator api(apiImpl);

    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::DeviceCanAccessPeer)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    error = api.DeviceCanAccessPeer(&canAccessPeer, devId, peerDevId);
    EXPECT_NE(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    delete apiImpl;
}

TEST_F(ApiTest910B, api_EnableP2P)
{
    rtError_t error;
    uint32_t devId = 0;
    uint32_t peerDevId = 1;
    uint32_t flag = 0;
    ApiImpl *apiImpl = new ApiImpl();
    ApiDecorator api(apiImpl);

    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::EnableP2P).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    error = api.EnableP2P(devId, peerDevId, flag);
    EXPECT_NE(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::DisableP2P).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.DisableP2P(devId, peerDevId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t status;
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetP2PStatus).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.GetP2PStatus(devId, peerDevId, &status);
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    delete apiImpl;
}

TEST_F(ApiTest910B, callback_subscribe_interface)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSubscribeReport(1, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtUnSubscribeReport(1, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, api_rts_rtsCallbackLaunch)
{
    rtError_t error = rtsCallbackLaunch(NULL, NULL, NULL, true);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, api_rts_rtsLaunchHostFunc)
{
    rtError_t error = rtsLaunchHostFunc(NULL, NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, CtxDestroyEx)
{
    rtError_t error;
    error = rtCtxDestroyEx(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, CPU_KERNEL_LAUNCH_DUMP)
{
    rtError_t error;
    rtStream_t stream;

    error = rtCpuKernelLaunchWithFlag(NULL, NULL, 1, NULL, NULL, NULL,2);
    EXPECT_NE(error, RT_ERROR_NONE);

    std::string soName = "libDvpp.so";
    std::string kernelName = "DvppResize";
    error = rtCpuKernelLaunchWithFlag(reinterpret_cast<const void *>(soName.c_str()),
                              reinterpret_cast<const void *>(kernelName.c_str()),
                              1, NULL, NULL, NULL,2);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream *stream0 = (Stream *)stream;
    Context *context0 = (Context *)stream0->Context_();
    stream0->SetContext((Context *)NULL);

    uint64_t arg = 0x1234567890;
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    error = rtCpuKernelLaunchWithFlag(reinterpret_cast<const void *>(soName.c_str()),
                              reinterpret_cast<const void *>(kernelName.c_str()),
                              1, &argsInfo, NULL, stream,2);
    EXPECT_NE(error, RT_ERROR_NONE);

    stream0->SetContext(context0);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

}

TEST_F(ApiTest910B, rtGetC2cCtrlAddr)
{
    rtError_t error;
    uint64_t addr;
    uint32_t len;
    error = rtGetC2cCtrlAddr(&addr, &len);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, rtsGetInterCoreSyncAddr)
{
    rtError_t error;
    uint64_t addr;
    uint32_t len;
    error = rtsGetInterCoreSyncAddr(&addr, &len);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, rtsLabelSwitchListCreate)
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
    error = rtsLabelCreate(&labelTmp); // 超规格
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

TEST_F(ApiTest910B, rtLabelGotoEx)
{
    rtError_t error;

    ApiImpl *apiImpl = new ApiImpl();
    ApiDecorator api(apiImpl);

    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LabelGotoEx)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    error = api.LabelGotoEx(NULL, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtLabelGotoEx(NULL, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    delete apiImpl;
}

TEST_F(ApiTest910B, rtLabelListCpy)
{
    rtError_t error;

    ApiImpl *apiImpl = new ApiImpl();
    ApiDecorator api(apiImpl);

    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::LabelListCpy)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    error = api.LabelListCpy(NULL, 0, NULL, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtLabelListCpy(NULL, 0, NULL, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    delete apiImpl;
}

TEST_F(ApiTest910B, rtLabelCreateEx)
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

TEST_F(ApiTest910B, rtDebugRegister)
{
    rtError_t error;
    rtModel_t model;
    uint32_t flag = 1;
    uint64_t addr = 0x1000;
    uint32_t streamId = 0;
    uint32_t taskId = 0;
    ApiImpl *apiImpl = new ApiImpl();

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::DebugRegister)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = rtDebugRegister(model, flag, &addr, &streamId, &taskId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete apiImpl;
}

TEST_F(ApiTest910B, rtDebugUnRegister)
{
    rtError_t error;
    rtModel_t model;
    uint32_t flag = 1;
    uint64_t addr = 0x1000;
    uint32_t streamId = 0;
    uint32_t taskId = 0;
    ApiImpl *apiImpl = new ApiImpl();

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::DebugUnRegister)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = rtDebugUnRegister(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete apiImpl;
}

TEST_F(ApiTest910B, DebugRegister)
{
    rtError_t error;
    rtModel_t model;
    uint32_t flag = 1;
    uint64_t addr = 0x1000;
    uint32_t streamId = 0;
    uint32_t taskId = 0;
    ApiImpl *apiImpl = new ApiImpl();
    ApiDecorator api(apiImpl);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::DebugRegister)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = api.DebugRegister((Model*)model, flag, &addr, &streamId, &taskId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete apiImpl;
}

TEST_F(ApiTest910B, DebugUnRegister)
{
    rtError_t error;
    rtModel_t model;
    uint32_t flag = 1;
    uint64_t addr = 0x1000;
    uint32_t streamId = 0;
    uint32_t taskId = 0;
    ApiImpl *apiImpl = new ApiImpl();
    ApiDecorator api(apiImpl);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::DebugUnRegister)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = api.DebugUnRegister((Model*)model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete apiImpl;
}

TEST_F(ApiTest910B, rtGetPriCtxByDeviceId)
{
    rtContext_t ctx;
    rtError_t error;

    error =  rtGetPriCtxByDeviceId(0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    error =  rtGetPriCtxByDeviceId(0, &ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error =  rtGetPriCtxByDeviceId(65, &ctx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtDeviceGetBareTgid)
{
    rtError_t error;
    uint32_t pid = 0;

    error = rtDeviceGetBareTgid(&pid);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceGetBareTgid(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsDeviceGetBareTgid(&pid);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, rtGetPairDevicesInfo)
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

TEST_F(ApiTest910B, rtGetPairPhyDevicesInfo)
{
    rtError_t error;
    int64_t value = 0;

    error = rtGetPairPhyDevicesInfo(0, 1, 0, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetPairPhyDevicesInfo(0, 1, 0, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, notify_record1_otherChip)
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

TEST_F(ApiTest910B, GetAicpuDeploy)
{
    rtError_t error;
    rtAicpuDeployType_t deplyType;

    error = rtGetAicpuDeploy(&deplyType);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(deplyType, AICPU_DEPLOY_RESERVED);

    error = rtGetAicpuDeploy(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, get_runtime_capability)
{
    rtError_t error;
    int64_t value = 0;

    error = rtGetRtCapability(FEATURE_TYPE_MEMCPY, MEMCPY_INFO_SUPPORT_ZEROCOPY, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtGetRtCapability(FEATURE_TYPE_MEMORY, MEMORY_INFO_TS_4G_LIMITED, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, get_runtime_milan_capability)
{
    rtError_t error;
    int64_t value = 0;

    error = rtGetRtCapability(FEATURE_TYPE_UPDATE_SQE, UPDATE_SQE_SUPPORT_DSA, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, rtSetProfDirEx)
{
    rtError_t error = rtSetProfDirEx(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTest910B, rtProfilerInit)
{
    rtError_t error = rtProfilerInit(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTest910B, rtProfilerConfig)
{
    rtError_t error;
    uint16_t type = 0;

    error = rtProfilerConfig(type);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTest910B, FEATURECAPINFO_Versiondvpp)
{
    rtError_t error;
    int32_t value = 0;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device* dev = rtInstance->GetDevice(0, 0);
    int32_t version = dev->GetTschVersion();
    dev->SetTschVersion(TS_VERSION_SUPER_TASK_FOR_DVPP);
    error = rtGetDeviceCapability(0, MODULE_TYPE_AICPU, FEATURE_TYPE_SCHE, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    dev->SetTschVersion(version);
}

TEST_F(ApiTest910B, FEATURECAPINFO_Blocking_Operator)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int32_t value = 0;

    error = rtGetDeviceCapability(0, 0xff, FEATURE_TYPE_SCHE, &value);

    error = rtGetDeviceCapability(0, MODULE_TYPE_AICPU, FEATURE_TYPE_BLOCKING_OPERATOR, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, context_set_INFMode)
{
    rtError_t error;

    error = rtSetCtxINFMode(false);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, model_exit_stream_NULL)
{
    rtError_t error;
    rtModel_t model;

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error =rtModelExit(model, NULL);
}

static bool g_logDeviceStateOpen[TEST_MAX_DEV_NUM];
static bool g_profilingDeviceStateOpen[TEST_MAX_DEV_NUM];
static void ResetAllDeviceState()
{
    for (uint32_t i = 0; i < TEST_MAX_DEV_NUM; ++i) {
        g_logDeviceStateOpen[i] = false;
        g_profilingDeviceStateOpen[i] = false;
    }
}
static void StubLogDeviceStateCallback(uint32_t deviceId, bool isOpen)
{
    g_logDeviceStateOpen[deviceId] = isOpen;
}

static void StubProfilingDeviceStateCallback(uint32_t deviceId, bool isOpen)
{
    g_profilingDeviceStateOpen[deviceId] = isOpen;
}

TEST_F(ApiTest910B, RegDeviceStateCallbackEx)
{
    rtError_t error = rtRegDeviceStateCallbackEx("gepre", StubLogDeviceStateCallback, DEV_CB_POS_FRONT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtRegDeviceStateCallbackEx(nullptr, StubLogDeviceStateCallback, DEV_CB_POS_FRONT);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtRegDeviceStateCallbackEx("gepre", StubLogDeviceStateCallback, DEV_CB_POS_END);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, RegDeviceStateCallback_no_reg)
{
    ResetAllDeviceState();
    DeviceStateCallbackManager::Instance().Notify(0, false, DEV_CB_POS_BACK, RT_DEVICE_STATE_RESET_POST);
    DeviceStateCallbackManager::Instance().Notify(1, true, DEV_CB_POS_BACK, RT_DEVICE_STATE_SET_POST);
    EXPECT_EQ(g_logDeviceStateOpen[0], false);
    EXPECT_EQ(g_logDeviceStateOpen[1], false);
    EXPECT_EQ(g_profilingDeviceStateOpen[0], false);
    EXPECT_EQ(g_profilingDeviceStateOpen[1], false);
}

TEST_F(ApiTest910B, get_runtime_version)
{
    uint32_t runtimeVersion;
    rtError_t error;

    error = rtGetRuntimeVersion(&runtimeVersion);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(runtimeVersion, 1001);
}

TEST_F(ApiTest910B, rtMemQueueCreate)
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

TEST_F(ApiTest910B, rtMemQueueDestroy)
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

TEST_F(ApiTest910B, rtMemQueueInit)
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

    MOCKER(halGetAPIVersion)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE))
        .then(invoke(halGetAPIVersionStub));
    error = rtMemQueueInit(0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtMemQueueInit(0);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTest910B, rtMemQueueEnQueue)
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

TEST_F(ApiTest910B, rtMemQueueDeQueue)
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

TEST_F(ApiTest910B, rtMemQueuePeek)
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

TEST_F(ApiTest910B, rtMemQueueEnQueueBuff)
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

TEST_F(ApiTest910B, rtMemQueueEnQueueBuff_128)
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

    MOCKER(drvMemcpy)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemQueueEnQueueBuff(0, 0, &queueBuf, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtMemQueueDeQueueBuff)
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

TEST_F(ApiTest910B, rtMemQueueQueryInfo)
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

TEST_F(ApiTest910B, rtMemQueueQuery)
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

TEST_F(ApiTest910B, rtMemQueueAttach)
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

TEST_F(ApiTest910B, rtEschedSubmitEventSync)
{
    uint32_t dst = (uint32_t)ACPU_DEVICE;
    constexpr uint32_t EVENT_QS_MSG = 25U;
    EXPECT_EQ(RT_MQ_DST_ENGINE_ACPU_DEVICE, dst);
    dst = (uint32_t)ACPU_HOST;
    EXPECT_EQ(RT_MQ_DST_ENGINE_ACPU_HOST, dst);
    dst = (uint32_t)CCPU_DEVICE;
    EXPECT_EQ(RT_MQ_DST_ENGINE_CCPU_DEVICE, dst);
    dst = (uint32_t)CCPU_HOST;
    EXPECT_EQ(RT_MQ_DST_ENGINE_CCPU_HOST, dst);
    dst = (uint32_t)DCPU_DEVICE;
    EXPECT_EQ(RT_MQ_DST_ENGINE_DCPU_DEVICE, dst);
    dst = (uint32_t)TS_CPU;
    EXPECT_EQ(RT_MQ_DST_ENGINE_TS_CPU, dst);
    dst = (uint32_t)DVPP_CPU;
    EXPECT_EQ(RT_MQ_DST_ENGINE_DVPP_CPU, dst);

    dst = (uint32_t)ONLY;
    EXPECT_EQ(RT_SCHEDULE_POLICY_ONLY, dst);
    dst = (uint32_t)FIRST;
    EXPECT_EQ(RT_SCHEDULE_POLICY_FIRST, dst);

    dst = (uint32_t)EVENT_QS_MSG;
    EXPECT_EQ(RT_MQ_SCHED_EVENT_QS_MSG, dst);

    // normal
    rtEschedEventSummary_t event = {0};
    event.eventId = RT_MQ_SCHED_EVENT_QS_MSG;
    rtEschedEventReply_t ack = {0};
    rtError_t error = rtEschedSubmitEventSync(0, &event, &ack);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // invalid paramter
    error = rtEschedSubmitEventSync(0, nullptr, &ack);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtEschedSubmitEventSync(0, &event, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER(halEschedSubmitEventSync)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtEschedSubmitEventSync(0, &event, &ack);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtQueryDevPid)
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

    MOCKER(halQueryDevpid)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtQueryDevPid(&info, &devPid);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtMbufInit)
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

TEST_F(ApiTest910B, rtBuffConfirm)
{
    // normal
    const uint64_t alloc_size = 100;
    void *buff = malloc(alloc_size);
    rtError_t error = rtBuffConfirm(buff, alloc_size);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // invalid paramter
    error = rtBuffConfirm(nullptr, alloc_size);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halBuffGet)
        .stubs()
        .will(returnValue(code));
    error = rtBuffConfirm(buff, alloc_size);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    free(buff);
}

TEST_F(ApiTest910B, rtBuffAlloc)
{
    // normal
    const uint64_t alloc_size = 100;
    const uint64_t alloc_zero_size = 0U;
    void *buff = nullptr;
    rtError_t error = rtBuffAlloc(alloc_size, &buff);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // invalid paramter
    error = rtBuffAlloc(alloc_zero_size, &buff);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halBuffAlloc)
        .stubs()
        .will(returnValue(code));
    error = rtBuffAlloc(alloc_size, &buff);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtMbufAlloc)
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

TEST_F(ApiTest910B, rtMbufAllocEx_malloc)
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

TEST_F(ApiTest910B, rtMbufBuild)
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

TEST_F(ApiTest910B, rtBuffFree)
{
    // normal
    const uint64_t alloc_size = 100;
    void *buff = malloc(alloc_size);

    rtError_t error = rtBuffFree(buff);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // invalid paramter
    error = rtBuffFree(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halBuffFree)
        .stubs()
        .will(returnValue(code));
    error = rtBuffFree(buff);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    free(buff);
}

TEST_F(ApiTest910B, rtMbufUnBuild)
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

TEST_F(ApiTest910B, rtBuffGet)
{
    // normal
    const uint64_t alloc_size = 100;
    void *buff = malloc(alloc_size);
    rtError_t error = rtBuffGet(nullptr, buff, alloc_size);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // invalid paramter
    error = rtBuffGet(nullptr, nullptr, alloc_size);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halBuffGet)
        .stubs()
        .will(returnValue(code));
    error = rtBuffGet(nullptr, buff, alloc_size);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    free(buff);
}

TEST_F(ApiTest910B, rtBuffPut)
{
    // normal
    const uint64_t alloc_size = 100;
    void *buff = malloc(alloc_size);
    rtError_t error = rtBuffPut(nullptr, buff);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // invalid paramter
    error = rtBuffPut(nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    free(buff);
}

TEST_F(ApiTest910B, rtMbufAllocEx_malloc_ex)
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

TEST_F(ApiTest910B, rtMbufFree)
{
    // normal
    rtMbufPtr_t mbuf = (rtMbufPtr_t)1;
    rtError_t error = rtMbufFree(mbuf);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // invalid paramter
    error = rtMbufFree(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halMbufFree)
        .stubs()
        .will(returnValue(code));
    error = rtMbufFree(mbuf);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtMbufSetDataLen)
{
    // normal
    rtMbufPtr_t mbuf = (rtMbufPtr_t)1;
    rtError_t error = rtMbufSetDataLen(mbuf, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // invalid paramter
    error = rtMbufSetDataLen(nullptr, 1);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halMbufSetDataLen)
        .stubs()
        .will(returnValue(code));
    error = rtMbufSetDataLen(mbuf, 1);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtMbufGetDataLen)
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
    MOCKER(halMbufGetDataLen)
        .stubs()
        .will(returnValue(code));
    error = rtMbufGetDataLen(mbuf, &size);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtMbufGetBuffAddr)
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
    MOCKER(halMbufGetBuffAddr)
        .stubs()
        .will(returnValue(code));
    error = rtMbufGetBuffAddr(mbuf, &buff);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtMbufGetBuffSize)
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
    MOCKER(halMbufGetBuffSize)
        .stubs()
        .will(returnValue(code));
    error = rtMbufGetBuffSize(mbuf, &totalSize);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtMbufGetPrivInfo)
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

TEST_F(ApiTest910B, rtMbufCopyBufRef)
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

TEST_F(ApiTest910B, rtMbufChainAppend)
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
    MOCKER(halMbufChainAppend)
        .stubs()
        .will(returnValue(code));
    error = rtMbufChainAppend(memBufChainHead, memBuf);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtMbufChainGetMbufNum)
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
    MOCKER(halMbufChainGetMbufNum)
        .stubs()
        .will(returnValue(code));
    error = rtMbufChainGetMbufNum(memBufChainHead, &num);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtMbufChainGetMbuf)
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
    MOCKER(halMbufChainGetMbuf)
        .stubs()
        .will(returnValue(code));
    error = rtMbufChainGetMbuf(memBufChainHead, 0, &memBuf);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtMemGrpCreate)
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
    MOCKER(halGrpCreate)
        .stubs()
        .will(returnValue(code));
    error = rtMemGrpCreate(name, &cfg);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtBuffGetInfo)
{
    // normal
    rtBuffGetCmdType cmd_type = RT_BUFF_GET_MBUF_BUILD_INFO;
    rtBuffBuildInfo buff_info = {};
    int32_t inbuff = 0;
    uint32_t len = 0;
    rtError_t error = rtBuffGetInfo(cmd_type, (void *)&inbuff, sizeof(void *), &buff_info, &len);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // invalid paramter
    error = rtBuffGetInfo(cmd_type, nullptr, sizeof(void *), &buff_info, &len);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtBuffGetInfo(cmd_type, (void *)&inbuff, sizeof(void *), nullptr, &len);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtBuffGetInfo(cmd_type, (void *)&inbuff, sizeof(void *), &buff_info, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halBuffGetInfo)
        .stubs()
        .will(returnValue(code));
    error = rtBuffGetInfo(cmd_type, (void *)&inbuff, sizeof(void *), &buff_info, &len);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, rtMemGrpCacheAlloc)
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
    MOCKER(halGrpCacheAlloc)
        .stubs()
        .will(returnValue(code));
    error = rtMemGrpCacheAlloc(name, devId, &para);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtMemQueueSet)
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

TEST_F(ApiTest910B, rtMemGrpAddProc)
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
    MOCKER(halGrpAddProc)
        .stubs()
        .will(returnValue(code));
    error = rtMemGrpAddProc(name, pid, &attr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtMemGrpAttach)
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
    MOCKER(halGrpAttach)
        .stubs()
        .will(returnValue(code));
    error = rtMemGrpAttach(name, timeout);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtMemGrpQuery)
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
    MOCKER(halGrpQuery)
        .stubs()
        .will(returnValue(code));
    error = rtMemGrpQuery(&input, &output);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtMemGrpQuery_addrInfo)
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

TEST_F(ApiTest910B, rtMemGrpQuery_addrInfo_maxGrp)
{
    rtMemGrpQueryInput_t input;
    input.cmd = RT_MEM_GRP_QUERY_GROUP_ADDR_INFO;
    input.grpQueryGroupAddrPara.devId = 0;

    const std::unique_ptr<rtMemGrpQueryGroupAddrInfo_t[]> \
        addrInfo(new (std::nothrow)rtMemGrpQueryGroupAddrInfo_t[BUFF_GRP_MAX_NUM]);
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

TEST_F(ApiTest910B, rtMemGrpQuery_grpId)
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
    MOCKER(halGrpQuery)
        .stubs()
        .will(returnValue(code));
    error = rtMemGrpQuery(&input, &output);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtMemQueueGetQidByName)
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
    MOCKER(halQueueGetQidbyName)
        .stubs()
        .will(returnValue(code));
    error = rtMemQueueGetQidByName(device, name, &qid);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtQueueSubscribe)
{
    int32_t device = 0;
    uint32_t qid = 0;
    uint32_t groupId = 1;
    int type = 2;  //QUEUE_TYPE

    MOCKER(NpuDriver::QueueSubscribe)
        .stubs()
        .will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    rtError_t error = rtQueueSubscribe(device, qid, groupId, type);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTest910B, rtQueueSubF2NFEvent)
{
    int32_t device = 0;
    uint32_t qid = 0;
    uint32_t groupId = 1;

    MOCKER(NpuDriver::QueueSubF2NFEvent)
        .stubs()
        .will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    rtError_t error = rtQueueSubF2NFEvent(device, qid, groupId);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTest910B, rtEschedAttachDevice)
{
    int32_t device = 0;

    rtError_t error = rtEschedAttachDevice(device);
    EXPECT_EQ(error, RT_ERROR_NONE);

    drvError_t code = DRV_ERROR_INVALID_VALUE;
    MOCKER(halEschedAttachDevice)
        .stubs()
        .will(returnValue(code));
    error = rtEschedAttachDevice(device);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtEschedDettachDevice)
{
    int32_t device = 0;

    rtError_t error = rtEschedDettachDevice(device);
    EXPECT_EQ(error, RT_ERROR_NONE);

    drvError_t code = DRV_ERROR_INVALID_VALUE;
    MOCKER(halEschedDettachDevice)
        .stubs()
        .will(returnValue(code));
    error = rtEschedDettachDevice(device);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtEschedWaitEvent)
{
    int32_t device = 0;
    uint32_t grpId = 0;
    uint32_t threadId = 0;
    int32_t timeout = 0;
    rtEschedEventSummary_t event;
    char msg[128] = "test";

    event.pid = 0; // dst PID
    event.grpId = 0;
    event.eventId = 0; // only RT_MQ_SCHED_EVENT_QS_MSG is supported
    event.subeventId = 0;
    event.msgLen = sizeof(msg);
    event.msg = msg;
    event.dstEngine = 0; // dst system cpu type
    event.policy = 0;

    rtError_t error = rtEschedWaitEvent(device, grpId, threadId, timeout, &event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // invalid paramter
    error = rtEschedWaitEvent(device, grpId, threadId, timeout, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    drvError_t code = DRV_ERROR_INVALID_VALUE;
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(code));
    error = rtEschedWaitEvent(device, grpId, threadId, timeout, &event);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtEschedCreateGrp)
{
    int32_t device = 0;
    uint32_t grpId = 0;
    rtGroupType_t type = RT_GRP_TYPE_BIND_DP_CPU;

    rtError_t error = rtEschedCreateGrp(device, grpId, type);
    EXPECT_EQ(error, RT_ERROR_NONE);


    drvError_t code = DRV_ERROR_INVALID_VALUE;
    MOCKER(halEschedCreateGrp)
        .stubs()
        .will(returnValue(code));
    error = rtEschedCreateGrp(device, grpId, type);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtEschedSubmitEvent)
{
    int32_t device = 0;
     rtEschedEventSummary_t event;

    rtError_t error = rtEschedSubmitEvent(device, &event);
    EXPECT_EQ(error, RT_ERROR_NONE);


    drvError_t code = DRV_ERROR_INVALID_VALUE;
    MOCKER(halEschedSubmitEvent)
        .stubs()
        .will(returnValue(code));
    error = rtEschedSubmitEvent(device, &event);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtEschedAckEvent)
{
    int32_t device = 0;
    rtEventIdType_t event_id = RT_EVENT_RANDOM_KERNEL;
    uint32_t subevent_id = 0;
    char msg[] = "success";
    uint32_t len = sizeof(msg);

    rtError_t error = rtEschedAckEvent(device, event_id, subevent_id, msg, len);
    EXPECT_EQ(error, RT_ERROR_NONE);

    drvError_t code = DRV_ERROR_INVALID_VALUE;
    MOCKER(halEschedAckEvent)
        .stubs()
        .will(returnValue(code));
    error = rtEschedAckEvent(device, event_id, subevent_id, msg, len);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, FftsPlusTaskLaunchApi)
{
    ApiImpl impl;
    rtError_t error = RT_ERROR_NONE;
    rtFftsPlusTaskInfo_t fftsPlusTaskInfo = {};
    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&Context::FftsPlusTaskLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    impl.FftsPlusTaskLaunch(&fftsPlusTaskInfo, static_cast<Stream *>(stream), 0);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, api_mem_and_buf_test)
{
    rtError_t error;
    Api *api = Api::Instance();
    ApiDecorator apiDec(api);
    Stream *stream = static_cast<Stream *>(stream_);
    char grpName[] = "group";

    error = apiDec.KernelLaunchEx("", (void *)1, 1, 0, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    void *m_devPtr;
    error = rtMalloc(&m_devPtr, 60, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDec.MemSetSync(m_devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(m_devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::ReduceAsync).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.ReduceAsync(NULL, NULL, 0, RT_RECUDE_KIND_END, RT_DATA_TYPE_END, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    void *m_ptr = NULL;
    uint64_t m_size = 100 * sizeof(uint32_t);
    error = apiDec.ManagedMemAlloc(&m_ptr, 128, RT_MEMORY_SPM);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = apiDec.ManagedMemFree(m_ptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::IpcSetMemoryName).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.IpcSetMemoryName(NULL, 0, NULL, 0, 0UL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::IpcSetMemoryAttr).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.IpcSetMemoryAttr(NULL, RT_ATTR_TYPE_MEM_MAP, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::IpcOpenMemory).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.IpcOpenMemory(NULL, NULL, 0UL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::IpcCloseMemory).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.IpcCloseMemory(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MallocHostSharedMemory).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MallocHostSharedMemory(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::FreeHostSharedMemory).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.FreeHostSharedMemory(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::IpcDestroyMemoryName).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.IpcDestroyMemoryName(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemGetInfoEx).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemGetInfoEx(RT_MEMORYINFO_DDR_NORMAL, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemQueueInitQS).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemQueueInitQS(0, grpName);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemQueueCreate).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemQueueCreate(0, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemQueueDestroy).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemQueueDestroy(0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemQueueInit).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemQueueInit(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemQueueEnQueue).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemQueueEnQueue(0, 0, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemQueueDeQueue).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemQueueDeQueue(0, 0, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemQueuePeek).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemQueuePeek(0, 0, NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemQueueEnQueueBuff).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemQueueEnQueueBuff(0, 0, NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemQueueDeQueueBuff).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemQueueDeQueueBuff(0, 0, NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemQueueQueryInfo).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemQueueQueryInfo(0, 0, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemQueueQuery).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemQueueQuery(0, RT_MQ_QUERY_QUE_ATTR_OF_CUR_PROC, NULL, 0, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemQueueGrant).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemQueueGrant(0, 0, 0, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemQueueAttach).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemQueueAttach(0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::QueryDevPid).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.QueryDevPid(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MbufAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MbufAlloc(NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MbufFree).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MbufFree(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MbufGetBuffAddr).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MbufGetBuffAddr(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MbufGetBuffSize).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MbufGetBuffSize(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MbufGetPrivInfo).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MbufGetPrivInfo(NULL, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemGrpCreate).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemGrpCreate(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemQueueSet).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemQueueSet(0, RT_MQ_QUEUE_ENABLE_LOCAL_QUEUE, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::BuffGetInfo).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.BuffGetInfo(RT_BUFF_GET_MBUF_BUILD_INFO, NULL, 0, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemGrpCacheAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemGrpCacheAlloc(NULL, 0, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemGrpAddProc).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemGrpAddProc(NULL, 0, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemGrpAttach).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemGrpAttach(NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemGrpQuery).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemGrpQuery(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::MemQueueGetQidByName).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemQueueGetQidByName(0, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, api_model_test)
{
    rtError_t error;
    Api *api = Api::Instance();
    ApiDecorator apiDec(api);
    Model *m_model = NULL;

    error = apiDec.ModelCreate(&m_model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    char dump_info[16] = "dump info";
    error = apiDec.DatadumpInfoLoad((const void *)dump_info, sizeof(dump_info), RT_KERNEL_DEFAULT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t modelId;
    MOCKER_CPP_VIRTUAL(api, &Api::ModelGetId).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.ModelGetId(m_model, &modelId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDec.ModelBindQueue(m_model, 0, RT_MODEL_INPUT_QUEUE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::ModelBindStream).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.ModelBindStream(m_model, NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::ModelUnbindStream).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.ModelUnbindStream(m_model, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::ModelExecute).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.ModelExecute(m_model, NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::ModelExecutorSet).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.ModelExecutorSet(m_model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::ModelEndGraph).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.ModelEndGraph(m_model, NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDec.ModelAbort(m_model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::ModelExit).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.ModelExit(m_model, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDec.ModelDestroy(m_model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(api, &Api::ModelLoadComplete).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.ModelLoadComplete(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, api_model_test_impl)
{
    rtError_t error;
    ApiImpl impl;
    ApiDecorator apiDec(&impl);
    Model m_model;
    Api *api = Api::Instance();

    MOCKER_CPP_VIRTUAL(api, &Api::ModelSetExtId).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Model::SendTaskToAicpu).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.ModelSetExtId(&m_model, 0U);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, api_model_test_log)
{
    rtError_t error;
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    Model mdl;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ModelSetExtId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP(&Model::SendTaskToAicpu).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.ModelSetExtId(&mdl, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, api_model_test_profiling)
{
    rtError_t error;
    ApiImpl impl;
    Profiler profiler(nullptr);
    ApiProfileDecorator api(&impl, &profiler);
    Model mdl;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ModelSetExtId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP(&Model::SendTaskToAicpu).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.ModelSetExtId(&mdl, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, api_model_test_profiling_log)
{
    rtError_t error;
    ApiImpl impl;
    Profiler profiler(nullptr);
    ApiProfileLogDecorator api(&impl, &profiler);
    Model mdl;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ModelSetExtId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP(&Model::SendTaskToAicpu).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.ModelSetExtId(&mdl, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, api_test_DeviceSynchronize)
{
    rtError_t error;
    ApiImpl impl;
    Profiler profiler(nullptr);
    ApiProfileLogDecorator api(&impl, &profiler);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DeviceSynchronize).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.DeviceSynchronize(-1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, api_model_test_error)
{
    rtError_t error;
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    Model mdl;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ModelSetExtId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP(&Model::SendTaskToAicpu).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.ModelSetExtId(&mdl, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, api_model_test_set_ext_id)
{
    rtError_t error;
    ApiImpl impl;
    ApiDecorator api(&impl);
    Model mdl;

    MOCKER_CPP(&Model::SendTaskToAicpu).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.ModelSetExtId(&mdl, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&ApiImpl::CurrentContext)
        .stubs()
        .will(invoke(CurrentContextStubCtx));
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, api_kernel_fusion_test)
{
    rtError_t error;
    Api *api = Api::Instance();
    ApiDecorator apiDec(api);

    error = apiDec.KernelFusionStart(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDec.KernelFusionEnd(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, api_notify_test)
{
    rtError_t error;
    ApiImpl impl;
    ApiDecorator api(&impl);

    Notify *m_notify;
    uint32_t notifyID;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::NotifyCreate).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.NotifyCreate(0, &m_notify);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::NotifyRecord).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.NotifyRecord(m_notify, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::NotifyWait).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.NotifyWait(m_notify, NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetNotifyID).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.GetNotifyID(m_notify, &notifyID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::IpcSetNotifyName).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.IpcSetNotifyName(m_notify, NULL, 0, 0UL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, api_online_test)
{
    rtError_t error;
    ApiImpl impl;
    ApiDecorator api(&impl);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StartOnlineProf).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.StartOnlineProf(NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StopOnlineProf).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.StopOnlineProf(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetOnlineProfData).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.GetOnlineProfData(NULL, NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::AdcProfiler).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.AdcProfiler(0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, api_stream_test)
{
    rtError_t error;
    ApiImpl impl;
    ApiDecorator api(&impl);

    Stream *stream;
    Event event;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StreamCreate).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.StreamCreate(&stream, 0, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StreamDestroy).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.StreamDestroy(stream, false);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StreamWaitEvent).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.StreamWaitEvent(stream, &event, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StreamSynchronize).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.StreamSynchronize(stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetMaxStreamAndTask).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.GetMaxStreamAndTask(0, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetTaskIdAndStreamID).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.GetTaskIdAndStreamID(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetStreamId).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.GetStreamId(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DebugRegisterForStream).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.DebugRegisterForStream(stream, 0, NULL, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DebugUnRegisterForStream).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.DebugUnRegisterForStream(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StreamSwitchN).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.StreamSwitchN(NULL, 0, NULL, &stream, 0, NULL, RT_SWITCH_INT64);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, api_event_test)
{
    rtError_t error;
    ApiImpl impl;
    ApiDecorator api(&impl);

    Event event;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EventSynchronize).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.EventSynchronize(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EschedSubmitEventSync).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.EschedSubmitEventSync(0, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EventQuery).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.EventQuery(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EventQueryStatus).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.EventQueryStatus(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EventQueryWaitStatus).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.EventQueryWaitStatus(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EventElapsedTime).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.EventElapsedTime(NULL, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EventGetTimeStamp).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.EventGetTimeStamp(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::QueueSubF2NFEvent).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.QueueSubF2NFEvent(0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::BufEventTrigger).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.BufEventTrigger(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::NotifyReset).stubs().will(returnValue(RT_ERROR_NONE));
    error = api.NotifyReset(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, apic_rtprocess_report)
{
    rtError_t error;
    ApiImpl impl;
    ApiDecorator api(&impl);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ProcessReport).stubs().will(returnValue(RT_ERROR_NONE));
    error = rtProcessReport(1000);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, apic_rtsprocess_report)
{
    rtError_t error;
    ApiImpl impl;
    ApiDecorator api(&impl);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ProcessReport).stubs().will(returnValue(RT_ERROR_NONE));
    error = rtsProcessReport(1000);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, rtLabel_CreateEx)
{
    rtError_t error;
    error = rtLabelCreateEx(NULL, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTest910B, rtGet_DevMsg)
{
    rtError_t error;
    ApiImpl impl;
    ApiDecorator api(&impl);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetDevMsg).stubs().will(returnValue(RT_ERROR_NONE));
    error = rtGetDevMsg(RT_GET_DEV_ERROR_MSG, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtBufEventTrigger)
{
    // normal
    const char *name = "name";
    rtError_t error = rtBufEventTrigger(name);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // invalid paramter
    error = rtBufEventTrigger(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halBufEventReport)
    .stubs()
    .will(returnValue(code));
    error = rtBufEventTrigger(name);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

}

TEST_F(ApiTest910B, rtGetAvailStreamNum)
{
    rtError_t error;
    uint32_t avaliStrCount;

    error = rtGetAvailStreamNum(RT_NORMAL_STREAM, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetAvailStreamNum(RT_NORMAL_STREAM, &avaliStrCount);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtGetAvailStreamNum(RT_NORMAL_STREAM, &avaliStrCount);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtGetAvailStreamNum(RT_HUGE_STREAM, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetAvailStreamNum(RT_HUGE_STREAM, &avaliStrCount);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTest910B, rtGetAvailEventNum)
{
    rtError_t error;
    uint32_t avaliEventCount;

    error = rtGetAvailEventNum(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetAvailEventNum(&avaliEventCount);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halResourceInfoQuery)
        .stubs()
        .will(returnValue(code));
    error = rtGetAvailEventNum(&avaliEventCount);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtGetTsMemType)
{
    uint32_t memType = 0U;
    memType = rtGetTsMemType(MEM_REQUEST_FEATURE_DEFAULT, 1024U);

    EXPECT_EQ(memType, RT_MEMORY_HBM);
}

TEST_F(ApiTest910B, rtProfilingCommandHandle)
{
    void *data = malloc(8);
    uint32_t len = 8;

    rtError_t error = rtProfilingCommandHandle(0, data, len);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    error = rtProfilingCommandHandle(1, data, len);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    free(data);
}

extern "C" drvError_t halMemcpySumbit(struct DMA_ADDR *dmaAddr, int32_t flag);
extern "C" drvError_t halMemcpyFinish(struct DMA_ADDR *dmaAddr);
TEST_F(ApiTest910B, drv_mem_dma_api)
{
    rtError_t error;
    NpuDriver drv;
    struct DMA_ADDR dmaHandle;

    MOCKER(halMemcpySumbit)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    rtError_t ret = drv.MemCopyAsyncEx(&dmaHandle);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    MOCKER(halMemcpySumbit)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE));
    ret = drv.MemCopyAsyncEx(&dmaHandle);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    MOCKER(halMemcpyWait)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    ret = drv.MemCopyAsyncWaitFinishEx(&dmaHandle);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    MOCKER(halMemcpyWait)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE));
    ret = drv.MemCopyAsyncWaitFinishEx(&dmaHandle);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, rtSetMsprofReporterCallback)
{
    rtError_t ret;
    ret = rtSetMsprofReporterCallback(msprofreportcallback);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
}

TEST_F(ApiTest910B, rtMultipleTaskInfoLaunchCtrl_aicpuTask)
{
    rtError_t error;
    void *args[] = {&error, NULL};
    rtMultipleTaskInfo_t multipleTaskInfo = {0};
    rtTaskDesc_t taskDesc;
    multipleTaskInfo.taskNum = 1;
    multipleTaskInfo.taskDesc = &taskDesc;
    memset(multipleTaskInfo.taskDesc, 0, sizeof(rtTaskDesc_t));
    multipleTaskInfo.taskDesc[0].type = RT_MULTIPLE_TASK_TYPE_AICPU;
    multipleTaskInfo.taskDesc[0].u.aicpuTaskDesc.kernelLaunchNames.soName = "librts_aicpulaunch.so";
    multipleTaskInfo.taskDesc[0].u.aicpuTaskDesc.kernelLaunchNames.kernelName = "cpu4_add_multiblock_device";
    multipleTaskInfo.taskDesc[0].u.aicpuTaskDesc.kernelLaunchNames.opName = "cpu4_add_multiblock_device";
    multipleTaskInfo.taskDesc[0].u.aicpuTaskDesc.blockDim = 2;
    multipleTaskInfo.taskDesc[0].u.aicpuTaskDesc.argsInfo.args = args;
    multipleTaskInfo.taskDesc[0].u.aicpuTaskDesc.argsInfo.argsSize = sizeof(args);

    std::vector<uintptr_t> input;
    input.push_back(reinterpret_cast<uintptr_t>(&multipleTaskInfo));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));
    error = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_MULTIPLE_TSK);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, rtMultipleTaskInfoLaunchCtrl_dvppTask)
{
    rtTaskDesc_t taskDesc;
    rtMultipleTaskInfo_t multipleTaskInfo = {0};
    multipleTaskInfo.taskNum = 1;
    multipleTaskInfo.taskDesc = &taskDesc;
    memset(multipleTaskInfo.taskDesc, 0, sizeof(rtTaskDesc_t));

    void *devPtr;
    rtMalloc(&devPtr, 16, RT_MEMORY_HBM, DEFAULT_MODULEID);
    multipleTaskInfo.taskDesc[0].type = RT_MULTIPLE_TASK_TYPE_DVPP;
    multipleTaskInfo.taskDesc[0].u.dvppTaskDesc.sqe.sqeHeader.type = 14; // RT_STARS_SQE_TYPE_JPEGD;
    multipleTaskInfo.taskDesc[0].u.dvppTaskDesc.aicpuTaskPos = 1 + 3;  // for dvpp rr, add 3 write value

    std::vector<uintptr_t> input;
    input.push_back(reinterpret_cast<uintptr_t>(&multipleTaskInfo));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));
    rtError_t error = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_MULTIPLE_TSK);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtFree(devPtr);
}

TEST_F(ApiTest910B, rtMultipleTaskInfoLaunchWithFlagCtrl_dvppTask_RuntimeFreeCmdList)
{
    rtTaskDesc_t taskDesc;
    rtMultipleTaskInfo_t multipleTaskInfo = {0};
    multipleTaskInfo.taskNum = 1;
    multipleTaskInfo.taskDesc = &taskDesc;
    memset(multipleTaskInfo.taskDesc, 0, sizeof(rtTaskDesc_t));

    void *devPtr;
    auto ret = rtMalloc(&devPtr, 16, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    multipleTaskInfo.taskDesc[0].type = RT_MULTIPLE_TASK_TYPE_DVPP;
    multipleTaskInfo.taskDesc[0].u.dvppTaskDesc.sqe.sqeHeader.type = 14; // RT_STARS_SQE_TYPE_JPEGD;
    multipleTaskInfo.taskDesc[0].u.dvppTaskDesc.aicpuTaskPos = 1 + 3;  // for dvpp rr, add 3 write value

    std::vector<uintptr_t> input;
    input.push_back(reinterpret_cast<uintptr_t>(&multipleTaskInfo));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));
    uint32_t flag = 0x0U;
    input.push_back(static_cast<uintptr_t>(flag));
    ret = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_MULTIPLE_TSK_FLAG);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtFree(devPtr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, rtMultipleTaskInfoLaunchWithFlagCtrl_dvppTask_RuntimeNotFreeCmdList)
{
    rtTaskDesc_t taskDesc;
    rtMultipleTaskInfo_t multipleTaskInfo = {0};
    multipleTaskInfo.taskNum = 1;
    multipleTaskInfo.taskDesc = &taskDesc;
    memset(multipleTaskInfo.taskDesc, 0, sizeof(rtTaskDesc_t));

    void *devPtr;
    rtMalloc(&devPtr, 16, RT_MEMORY_HBM, DEFAULT_MODULEID);
    multipleTaskInfo.taskDesc[0].type = RT_MULTIPLE_TASK_TYPE_DVPP;
    multipleTaskInfo.taskDesc[0].u.dvppTaskDesc.sqe.sqeHeader.type = 14; // RT_STARS_SQE_TYPE_JPEGD;
    multipleTaskInfo.taskDesc[0].u.dvppTaskDesc.aicpuTaskPos = 1 + 3;  // for dvpp rr, add 3 write value

    std::vector<uintptr_t> input;
    input.push_back(reinterpret_cast<uintptr_t>(&multipleTaskInfo));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));
    uint32_t flag = 0x40U;
    input.push_back(static_cast<uintptr_t>(flag));
    int32_t ret = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_MULTIPLE_TSK_FLAG);
    rtFree(devPtr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, rtMultipleTaskInfoLaunchCtrl_InvalidTask)
{
    rtTaskDesc_t taskDesc;
    rtMultipleTaskInfo_t multipleTaskInfo = {0};
    multipleTaskInfo.taskNum = 1;
    multipleTaskInfo.taskDesc = &taskDesc;
    memset(multipleTaskInfo.taskDesc, 0, sizeof(rtTaskDesc_t));
    multipleTaskInfo.taskDesc[0].type = RT_MULTIPLE_TASK_TYPE_MAX;
    std::vector<uintptr_t> input;
    input.push_back(reinterpret_cast<uintptr_t>(&multipleTaskInfo));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));
    auto ret = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_MULTIPLE_TSK);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rtMultipleTaskInfoLaunchWithFlagCtrl_InvalidTask)
{
    rtTaskDesc_t taskDesc;
    rtMultipleTaskInfo_t multipleTaskInfo = {0};
    multipleTaskInfo.taskNum = 1;
    multipleTaskInfo.taskDesc = &taskDesc;
    memset(multipleTaskInfo.taskDesc, 0, sizeof(rtTaskDesc_t));
    multipleTaskInfo.taskDesc[0].type = RT_MULTIPLE_TASK_TYPE_MAX;
    std::vector<uintptr_t> input;
    input.push_back(reinterpret_cast<uintptr_t>(&multipleTaskInfo));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));
    auto ret = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_MULTIPLE_TSK_FLAG);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, memset_async_errorTest)
{
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    rtError_t error;
    void * devPtr;

    error = rtMalloc(&devPtr, 60, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

     error = rtFree(devPtr);
     EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, get_bin_and_stack_buffer)
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
    EXPECT_EQ(rtGetBinBuffer(bin_handle, RT_BIN_HOST_ADDR, &outputBin, &binSize), RT_ERROR_NONE);
    EXPECT_EQ(binSize, m_len);
    EXPECT_EQ(api.GetBinBuffer(bin_handle, RT_BIN_HOST_ADDR, &outputBin, &binSize), RT_ERROR_NONE);
    EXPECT_EQ(rtGetBinBuffer(bin_handle, RT_BIN_DEVICE_ADDR, &outputBin, &binSize), RT_ERROR_NONE);
    EXPECT_EQ(binSize, m_len);

    const void *stack = nullptr;
    uint32_t stackSize = 0U;
    EXPECT_EQ(rtGetStackBuffer(bin_handle, 0, 0, &stack, &stackSize), RT_ERROR_NONE);
    EXPECT_EQ(rtGetStackBuffer(bin_handle, 1, 0, &stack, &stackSize), RT_ERROR_NONE);
    EXPECT_EQ(api.GetStackBuffer(bin_handle, 1, 0, &stack, &stackSize), RT_ERROR_NONE);
    EXPECT_EQ(rtBinaryUnLoad(bin_handle), RT_ERROR_NONE);
}

TEST_F(ApiTest910B, rts_get_bin_and_stack_buffer)
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

TEST_F(ApiTest910B, get_srvid_by_sdid_test)
{
    rtError_t error;
    uint32_t sdid1 = 0x66666666U;
    uint32_t sdid2 = 0x88888888U;
    uint32_t sdid3 = 0x0U;
    uint32_t srvid = 0;

    error = rtGetServerIDBySDID(sdid1, &srvid);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

rtError_t rtStarsSendTask(rtStream_t stm, const rtStarsTransParm_t *transParm, uint32_t taskCount);
rtError_t rtStarsWaitCqe(rtStream_t stm, uint32_t taskCount, uint32_t *taskCmplCount, void *output);

TEST_F(ApiTest910B, rtDeviceStatusQuery_03)
{
    rtError_t error;

    ApiImpl impl;
    ApiDecorator api(&impl);
    uint32_t devId = 0U;
    rtDeviceStatus deviceStatus = RT_DEVICE_STATUS_NORMAL;
    error = api.DeviceStatusQuery(devId, &deviceStatus);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, rtDeviceStatusQuery_04)
{
    rtError_t error = RT_ERROR_NONE;
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    uint32_t devId = 0U;
    rtDeviceStatus deviceStatus = RT_DEVICE_STATUS_NORMAL;
    RawDevice *dev = new RawDevice(devId);
    error = rtInstance->SetWatchDogDevStatus(dev, RT_DEVICE_STATUS_ABNORMAL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceStatusQuery(devId, &deviceStatus);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(deviceStatus, RT_DEVICE_STATUS_ABNORMAL);
    delete dev;
}

TEST_F(ApiTest910B, rtOperateWithHostid)
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

rtError_t rtGetProfilingBuffer(uint32_t sqId, uint32_t *profBufId);
rtError_t rtPrintProfilingLog(uint32_t profBufId);
rtError_t rtReleaseProfilingBuffer(uint32_t sqId, uint32_t profBufId);

TEST_F(ApiTest910B, BIN_LOAD_MIX_KERNEL_TEST_2)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Api * const apiInstance = Api::Instance();
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    uint8_t data[64];
    Program *prog = nullptr;
    Kernel *kernel = nullptr;

    profiler->apiProfileLogDecorator_->BinaryLoadWithoutTilingKey((void *)&data[0], 0, &prog);
    profiler->apiProfileDecorator_->BinaryLoadWithoutTilingKey((void *)&data[0], 0, &prog);
    EXPECT_EQ(prog, nullptr);

    apiInstance->BinaryLoadWithoutTilingKey((void *)&data[0], 0, &prog);
    EXPECT_EQ(prog, nullptr);

    prog = new (std::nothrow) ElfProgram(Program::MACH_AI_MIX_KERNEL);
    rtError_t error = profiler->apiProfileDecorator_->BinaryGetFunctionByName(prog, "abc", &kernel);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiInstance->BinaryGetFunctionByName(prog, "abc", &kernel);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete prog;
}

TEST_F(ApiTest910B, get_cqId) {
    rtStream_t stream;
    rtError_t error = RT_ERROR_NONE;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    uint32_t cqid;
    uint32_t logicCqid;
    rtStreamGetCqid(stream, &cqid, &logicCqid);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtStreamClear(stream, RT_STREAM_STOP);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, rtDeviceCleanRes_01)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t devId = 0U;
    error = rtDeviceResourceClean(0);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTest910B, ctx_get_current_default_stream)
{
    rtStream_t stream;
    rtError_t error = rtCtxGetCurrentDefaultStream(&stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(stream, nullptr);
    error = rtCtxGetCurrentDefaultStream(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, get_lasterr)
{
    rtError_t error;
    error = rtGetLastError(RT_THREAD_LEVEL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID );
}

TEST_F(ApiTest910B, peek_lasterr)
{
    rtError_t error;
    error = rtPeekAtLastError(RT_THREAD_LEVEL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, get_lasterr1)
{
    rtError_t error;
    error = rtGetLastError(RT_CONTEXT_LEVEL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID );
}

TEST_F(ApiTest910B, peek_lasterr1)
{
    rtError_t error;
    error = rtPeekAtLastError(RT_CONTEXT_LEVEL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, get_lasterr2)
{
    rtError_t error;
    error = rtGetLastError((rtLastErrLevel_t)(RT_CONTEXT_LEVEL+2));
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, peek_lasterr2)
{
    rtError_t error;
    error = rtPeekAtLastError((rtLastErrLevel_t)(RT_CONTEXT_LEVEL+2));
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, get_device_status)
{
    rtError_t error;
    drvStatus_t drvStatus = DRV_STATUS_RESERVED;
    rtDevStatus_t rtStatus = RT_DEV_STATUS_RESERVED;
    std::map<drvStatus_t, rtDevStatus_t> status = {
        {DRV_STATUS_INITING, RT_DEV_STATUS_INITING},
        {DRV_STATUS_WORK, RT_DEV_STATUS_WORK},
        {DRV_STATUS_EXCEPTION, RT_DEV_STATUS_EXCEPTION},
        {DRV_STATUS_SLEEP, RT_DEV_STATUS_SLEEP},
        {DRV_STATUS_COMMUNICATION_LOST, RT_DEV_STATUS_COMMUNICATION_LOST}
    };

    error = rtGetDeviceStatus(-1, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
    error = rtGetDeviceStatus(0, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    for (auto it = status.begin(); it != status.end(); it++) {
        drvStatus = it->first;
        MOCKER(drvDeviceStatus)
            .stubs()
            .with(mockcpp::any(), outBoundP(&drvStatus, sizeof(drvStatus)))
            .will(returnValue(DRV_ERROR_NONE));
        error = rtGetDeviceStatus(0, &rtStatus);
        EXPECT_EQ(error, ACL_RT_SUCCESS);
        EXPECT_EQ(rtStatus, it->second);
        GlobalMockObject::verify();
    }

    MOCKER(drvDeviceStatus)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE))
        .then(returnValue(DRV_ERROR_INVALID_DEVICE));
    error = rtGetDeviceStatus(0, &rtStatus);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtGetDeviceStatus(0, &rtStatus);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);

    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::GetDeviceStatus)
        .stubs()
        .will(returnValue(RT_ERROR_DRV_NOT_SUPPORT));
    error = rtGetDeviceStatus(0, &rtStatus);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTest910B, get_hostcpu_deviceId)
{
    rtError_t error;

    error = rtGetHostCpuDevId(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t device_id = -1;
    error = rtGetHostCpuDevId(&device_id);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(device_id, DEFAULT_HOSTCPU_USER_DEVICE_ID);
}

TEST_F(ApiTest910B, rtsFreeAddress_null)
{
    rtError_t error;
    error = rtsMemFreePhysical(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsMemFreeAddress(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, rtsMemMap)
{
    rtError_t error;

    void *virptr = (void *)10;
    rtMemHandle handVal;

    error = rtsMemMap(virptr, 100, 0, handVal, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemUnmap(virptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemMap(virptr, 0, 0, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemMap(nullptr, 10, 0, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemUnmap(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

/* new memory api ut */
TEST_F(ApiTest910B, rtMemAlloc)
{
    // rtMallocConfig_t cfg is nullptr
    rtError_t error;
    void * devPtr;
    rtMallocConfig_t * p = nullptr;
    error = rtMemAlloc(&devPtr, 60, RT_MEM_MALLOC_HUGE_FIRST, RT_MEM_ADVISE_NONE, p);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, rtsDvppLaunch_test_01)
{
    rtError_t error;
    void *args[] = {&error, NULL};
    void *stubFunc;

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    error = rtLaunchDvppTask(nullptr, 0, stream_, nullptr);
    EXPECT_NE(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(ApiTest910B, create_args_test_01)
{
    rtError_t error;
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1;
    Kernel * k1 = new Kernel(&fun1, "f1", "", program, 10);
    k1->userParaNum_ = 2;
    k1->systemParaNum_ = 2;
    k1->isSupportOverFlow_ = true;
    k1->isNeedSetFftsAddrInArg_ = true;
    void *argsHandle;
    error = rtsKernelArgsInit(k1, &argsHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(argsHandle, nullptr);
    RtArgsHandle *handle = (RtArgsHandle *)argsHandle;
    EXPECT_NE(handle->buffer, nullptr);
    EXPECT_NE(handle->bufferSize, 0);
    uint32_t param1 = 1002;
    void *paramHandle = nullptr;
    error = rtsKernelArgsAppend(argsHandle, &param1, sizeof(uint32_t), &paramHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ParaDetail *pHandle = (ParaDetail *)paramHandle;
    uint32_t *addr1 = reinterpret_cast<uint32_t *>(reinterpret_cast<uintptr_t>(handle->buffer) + static_cast<uint64_t>(pHandle->paraOffset));
    EXPECT_EQ(*addr1, param1);
    error = rtsKernelArgsFinalize(argsHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t test1 = 1001;
    ParaDetail tmpPhandle = {};
    tmpPhandle.type = 1;
    tmpPhandle.paraSize = sizeof(uint64_t);
    error = rtsKernelArgsParaUpdate(argsHandle, &tmpPhandle, &test1, sizeof(uint32_t));
    EXPECT_NE(error, RT_ERROR_NONE);

    uint32_t test2 = 1001;
    tmpPhandle.type = 0;
    tmpPhandle.paraSize = sizeof(uint64_t);
    error = rtsKernelArgsParaUpdate(argsHandle, &tmpPhandle, &test2, sizeof(uint32_t));
    EXPECT_NE(error, RT_ERROR_NONE);
    rtKernelLaunchCfg_t cfg;
    rtLaunchKernelAttr_t attrs[7];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE;
    attrs[0].value.schemMode = 0;
    attrs[1].id = RT_LAUNCH_KERNEL_ATTR_LOCAL_MEM_SIZE;
    attrs[1].value.localMemorySize = 100;
    attrs[2].id = RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE;
    attrs[2].value.engineType = RT_ENGINE_TYPE_AIV;
    attrs[3].id = RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET;
    attrs[3].value.blockDimOffset = 10;
    attrs[4].id = RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH;
    attrs[4].value.isBlockTaskPrefetch = 1U;
    attrs[5].id = RT_LAUNCH_KERNEL_ATTR_DATA_DUMP;
    attrs[5].value.isDataDump = 1U;
    attrs[6].id = RT_LAUNCH_KERNEL_ATTR_TIMEOUT;
    attrs[6].value.isDataDump = 10U;

    cfg.attrs = attrs;
    cfg.numAttrs = 6;

    error = rtsLaunchKernelWithConfig(k1, 1, stream_, &cfg, argsHandle, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsLaunchKernelWithHostArgs(k1, 1, stream_, &cfg, 0,0,nullptr,0);
    EXPECT_NE(error, RT_ERROR_NONE);
    delete k1;
}

TEST_F(ApiTest910B, create_args_test_03)
{
    rtError_t error;
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1;
    Kernel * k1 = new Kernel(&fun1, "f1", "", program, 10);
    k1->userParaNum_ = 20;
    k1->systemParaNum_ = 2;
    k1->isSupportOverFlow_ = true;
    k1->isNeedSetFftsAddrInArg_ = true;
    void *argsHandle;
    error = rtsKernelArgsInit(k1, &argsHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(argsHandle, nullptr);

    for (uint16_t i = 0; i < 128; i++) {
        void *paraHandle;
        error = rtsKernelArgsAppendPlaceHolder(argsHandle, &paraHandle);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }

    RtArgsHandle *handle = (RtArgsHandle *)argsHandle;
    rtKernelLaunchCfg_t cfg;
    rtLaunchKernelAttr_t attrs[5];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE;
    attrs[0].value.schemMode = 0;
    attrs[1].id = RT_LAUNCH_KERNEL_ATTR_LOCAL_MEM_SIZE;
    attrs[1].value.localMemorySize = 100;
    attrs[2].id = RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE;
    attrs[2].value.engineType = RT_ENGINE_TYPE_AIV;
    attrs[3].id = RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET;
    attrs[3].value.blockDimOffset = 10;
    attrs[4].id = RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH;
    attrs[4].value.isBlockTaskPrefetch = 1U;

    error = rtsKernelArgsFinalize(argsHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    cfg.attrs = attrs;
    cfg.numAttrs = 5;
    handle->placeHolderNum = 20;
    error = rtsLaunchKernelWithConfig(k1, 1, stream_, &cfg, argsHandle, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    attrs[0].value.schemMode = RT_SCHEM_MODE_END;
    error = rtsLaunchKernelWithConfig(k1, 1, stream_, &cfg, argsHandle, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
    delete k1;
}

TEST_F(ApiTest910B, api_rtsLaunchBarrierTask)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtBarrierTaskInfo_t barrierTask = {0};
    barrierTask.logicIdNum=1;
    barrierTask.cmoInfo[0].cmoType=RT_CMO_INVALID;
    barrierTask.cmoInfo[0].logicId=1;
    rtError_t error = rtsLaunchBarrierTask(&barrierTask,  NULL, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    uint32_t tag = 0;
    std::vector<uintptr_t> input2;
    input2.push_back(reinterpret_cast<uintptr_t>(stream_));
    input2.push_back(static_cast<uintptr_t>(tag));
    rtGeneralCtrl(input2.data(), input2.size(), RT_GNL_CTRL_TYPE_SET_STREAM_TAG);
    (void)rtGetStreamTag(stream_, &tag);

    // taskInfo is nullptr
    error = rtsLaunchBarrierTask(nullptr,  stream_, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    barrierTask.logicIdNum = 0U;
    error = rtsLaunchBarrierTask(&barrierTask,  stream_, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    // logicIdNum exceeded the upper limit
    barrierTask.logicIdNum = RT_CMO_MAX_BARRIER_NUM + 1U;
    error = rtsLaunchBarrierTask(&barrierTask,  stream_, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    // invalid op,but logicId is 0
    barrierTask.logicIdNum = 1;
    barrierTask.cmoInfo[0].cmoType=RT_CMO_INVALID;
    barrierTask.cmoInfo[0].logicId=0;
    error = rtsLaunchBarrierTask(&barrierTask,  stream_, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    // prefetch op 
    barrierTask.logicIdNum = 1;
    barrierTask.cmoInfo[0].cmoType=RT_CMO_PREFETCH;
    error = rtsLaunchBarrierTask(&barrierTask,  stream_, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rt_logtest)
{
    std::vector<char> vec;
    vec.push_back('H');
    vec.push_back('e');
    vec.push_back('l');
    vec.push_back('l');
    vec.push_back('o');
    ReportErrMsg("570000", vec);
}

TEST_F(ApiTest910B, rts_memroy_attritue_fail)
{
    rtError_t error;
    void * hostPtr;
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

TEST_F(ApiTest910B, rts_memory_attritue_1)
{
    rtError_t error;
    void * hostPtr;
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

TEST_F(ApiTest910B, rts_memory_attritue_2)
{
    rtError_t error;
    void * hostPtr;
    rtPtrAttributes_t attributes;

    error = rtMallocHost(&hostPtr, 60, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(drvMemGetAttribute)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtsPointerGetAttributes(hostPtr, &attributes);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtFreeHost(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsPointerGetAttributes(NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest910B, rts_memory_attritue_3)
{
    rtError_t error;
    void * hostPtr;
    rtPtrAttributes_t attributes;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    bool tmp = rtInstance->isHaveDevice_;
    rtInstance->isHaveDevice_ = false;

    error = rtMallocHost(&hostPtr, 60, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(drvMemGetAttribute)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtsPointerGetAttributes(hostPtr, &attributes);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtFreeHost(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsPointerGetAttributes(NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    rtInstance->isHaveDevice_ = tmp;
}

TEST_F(ApiTest910B, rts_memory_attritue_4)
{
    rtError_t error;
    void * hostPtr;
    rtPtrAttributes_t attributes;

    error = rtMallocHost(&hostPtr, 60, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue((Context *)NULL));
    MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(false));

    error = rtsPointerGetAttributes(hostPtr, &attributes);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(true));

    error = rtsPointerGetAttributes(hostPtr, &attributes);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFreeHost(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, rts_memory_reallocation)
{
    rtError_t error;
    void * hostPtr;
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

TEST_F(ApiTest910B, rts_notify_batch_reset_2)
{
    rtNotify_t notify;
    rtNotify_t notify1;
    rtError_t error;
    int32_t device_id = 0;
    rtContext_t ctx;
    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtNotify_t notify_arr[2];
    error = rtNotifyCreate(device_id, &notify);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtNotifyCreate(device_id, &notify1);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    notify_arr[0] = notify;
    notify_arr[1] = notify1;
    error = rtsNotifyBatchReset(notify_arr, 2U);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
  
    error = rtNotifyDestroy(notify);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtNotifyDestroy(notify1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest910B, rt_notify_reset_all_2)
{
    MOCKER(rtGetDevice).stubs().will(returnValue(ACL_ERROR_RT_CONTEXT_NULL));
    rtError_t error = rtNotifyResetAll();
    EXPECT_EQ(error, ACL_ERROR_RT_CONTEXT_NULL);
}

TEST_F(ApiTest910B, profling_getctxState)
{
    rtError_t error;
    uint64_t size = 128;
    void *ptr = NULL;
    Api* oldApi_ = Runtime::runtime_->api_;
    Profiler *profiler = new Profiler(oldApi_);
    profiler->Init();

    int32_t active = 0;
    uint32_t flags = 0U;
    error = profiler->apiProfileDecorator_->GetPrimaryCtxState(0, &flags, &active);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete profiler;
}

int32_t stubRtsDeviceTaskAbortCallback2(uint32_t devId, rtDeviceTaskAbortStage stage, uint32_t timeout, void *args)
{
    return 1;
}

TEST_F(ApiTest910B, rtsSetDeviceTaskAbortCallback_005)
{
    rtError_t error;
    char *regName ="task-abort-005";
    error = rtsSetDeviceTaskAbortCallback(regName, &stubRtsDeviceTaskAbortCallback2, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtInstance->TaskAbortCallBack(0, RT_DEVICE_ABORT_PRE, 1000);
    EXPECT_EQ(error, 1);
}

bool g_taskAbortCallBackV2 = false;
static int32_t StubTaskAbortCallBackV2(uint32_t devId, rtTaskAbortStage_t stage, uint32_t timeout, void *args)
{
    g_taskAbortCallBackV2 = true;
    return 1;
}

TEST_F(ApiTest910B, rtTaskAbortCallBack_006)
{
    char moduleName[] = "task-abort-006";
    rtError_t error;
    char args[] = "0x100";

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtSetTaskAbortCallBack(moduleName, StubTaskAbortCallBackV2, args);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtInstance->TaskAbortCallBack(0, RT_DEVICE_ABORT_PRE, 1000);
    EXPECT_EQ(error, 1);
}

TEST_F(ApiTest910B, LAUNCH_NPU_SAVE)
{
    size_t MAX_LENGTH = 75776;
    FILE *master = NULL;
    master = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o", "rb");
    if (NULL == master)
    {
        printf ("master open error\n");
        return;
    }

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SaveModule();
    rtInstance->RestoreModule();
    rtInstance->DeleteModuleBackupPoint();

    char m_data[MAX_LENGTH];
    size_t m_len = 0;
    m_len = fread(m_data, sizeof(char), MAX_LENGTH, master);
    fclose(master);

    rtError_t error;
    void *m_handle;
    Program *m_prog;
    rtDevBinary_t master_bin;
    master_bin.magic = RT_DEV_BINARY_MAGIC_ELF;
    master_bin.version = 2;
    master_bin.data = m_data;
    master_bin.length = m_len;

    error = rtDevBinaryRegister(&master_bin, &m_handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(m_handle, (void *)NULL);

    //_Z15executor_conv2dPDhj
    void *stub_func = (void *)0x869242;
    error = rtFunctionRegister(m_handle, stub_func, "stub_func1", "_Z15executor_conv2dPDhj", 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t arg = 0x1234567890;
    error = rtKernelLaunch(stub_func, 1, (void *)&arg, sizeof(arg), NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtInstance->SaveModule();
    rtInstance->RestoreModule();
    rtInstance->DeleteModuleBackupPoint();

    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream* stm = static_cast<Stream*>(stream);

    MOCKER_CPP_VIRTUAL(stm->Device_()->Driver_(), &Driver::MemCopySync)
       .stubs()
       .will(returnValue(RT_ERROR_INVALID_VALUE));

    rtInstance->SaveModule();
    rtInstance->DeleteModuleBackupPoint();
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDevBinaryUnRegister(m_handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}