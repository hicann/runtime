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

class CloudV2ApiTest910b : public testing::Test
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
rtChipType_t CloudV2ApiTest910b::originType_;
rtStream_t CloudV2ApiTest910b::stream_ = NULL;
rtEvent_t CloudV2ApiTest910b::event_ = NULL;
void* CloudV2ApiTest910b::binHandle_ = nullptr;
char  CloudV2ApiTest910b::function_ = 'a';
uint32_t CloudV2ApiTest910b::binary_[32] = {};
Driver* CloudV2ApiTest910b::driver_ = NULL;

TEST_F(CloudV2ApiTest910b, util_test)
{
    rtError_t error;
    uint8_t utilValue = 0;
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    error = rtGetAllUtilizations(0, RT_UTIL_TYPE_AICORE, &utilValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtGetAllUtilizations(0, RT_UTIL_TYPE_AIVECTOR, &utilValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtGetAllUtilizations(0, RT_UTIL_TYPE_AICPU, &utilValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtGetAllUtilizations(0, RT_UTIL_TYPE_MAX, &utilValue);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest910b, ut_GetAddrAndPrefCntWithHandle_null)
{
    uint32_t prefetchCnt = 0;
    rtError_t error = rtGetAddrAndPrefCntWithHandle(NULL, NULL, NULL, &prefetchCnt);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest910b, memcpy_async_ptr_qos)
{
    rtError_t error;
    void *srcPtr;
    void *alignedPtr;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    uint64_t size = 64;
    uint64_t alignment = 64;

    error = rtMalloc(&srcPtr, size + alignment, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uintptr_t rawAddr = (uintptr_t)srcPtr;
    uintptr_t alignedAddr = (rawAddr + alignment - 1) & ~(alignment - 1);
    alignedPtr = (void *)alignedAddr;

    EXPECT_EQ((uintptr_t)alignedPtr % 64, 0);

    // RTS_MEMCPYASYNCPTR_QOS_CONFIG_02
    rtTaskCfgInfo_t taskCfgInfo = {};
    taskCfgInfo.qos = 1;
    taskCfgInfo.partId = 1;

    error = rtMemcpyAsyncPtrV2(alignedPtr, 64, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, &taskCfgInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(srcPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, TestRtsGetDeviceInfo)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    ApiErrorDecorator apiError(&impl);

    int32_t devid = 0;
    rtError_t error;
    bool isHugeOnly = true;
    size_t freeSize = 0;
    size_t totalSize = 0;
    int64_t val = 0;

    MOCKER_CPP(&fe::PlatformInfoManager::InitRuntimePlatformInfos)
        .stubs()
        .will(returnValue(0xFFFFFFFF));

    error = apiDecorator.MemGetInfoByDeviceId(devid, isHugeOnly, &freeSize, &totalSize);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDecorator.GetDeviceInfoFromPlatformInfo(devid, "SoCInfo", "cube_core_cnt", &val);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiError.MemGetInfoByDeviceId(devid, isHugeOnly, &freeSize, &totalSize);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiError.GetDeviceInfoFromPlatformInfo(devid, "SoCInfo", "cube_core_cnt", &val);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(CloudV2ApiTest910b, testRtDevBinaryRegisterAllApiTest)
{
    ApiImpl impl;
    ApiDecorator apiDec(&impl);
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DevBinaryRegister).stubs().will(returnValue(RT_ERROR_NONE));
    auto error = apiDec.DevBinaryRegister(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetNotifyAddress).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.GetNotifyAddress(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::RegisterAllKernel).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.RegisterAllKernel(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::BinaryRegisterToFastMemory).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.BinaryRegisterToFastMemory(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DevBinaryUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.DevBinaryUnRegister(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MetadataRegister).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MetadataRegister(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::FunctionRegister).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.FunctionRegister(NULL, NULL, NULL, NULL, -1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetAddrAndPrefCntWithHandle).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.GetAddrAndPrefCntWithHandle(NULL, NULL, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::KernelGetAddrAndPrefCnt).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.KernelGetAddrAndPrefCnt(NULL, 1, NULL, 1, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::KernelGetAddrAndPrefCntV2).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.KernelGetAddrAndPrefCntV2(NULL, 1, NULL, 1, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::KernelLaunchWithHandle).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.KernelLaunchWithHandle(NULL, 1, 1, NULL, NULL, NULL, NULL, false);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::CpuKernelLaunchExWithArgs).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.CpuKernelLaunchExWithArgs(NULL, 1, NULL, NULL, NULL, 1, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MultipleTaskInfoLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MultipleTaskInfoLaunch(NULL, NULL, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::BinaryLoad).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.BinaryLoad(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, testMemcpyHostTaskTest)
{
    ApiImpl impl;
    ApiDecorator apiDec(&impl);
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemcpyHostTask).stubs().will(returnValue(RT_ERROR_NONE));
    auto error = apiDec.MemcpyHostTask(NULL, 1, NULL, 1, RT_MEMCPY_DEVICE_TO_HOST_EX, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DvppGroupCreate).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.DvppGroupCreate(NULL, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DvppGroupDestory).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.DvppGroupDestory(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DvppWaitGroupReport).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.DvppWaitGroupReport(NULL, NULL, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetVisibleDeviceIdByLogicDeviceId).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.GetVisibleDeviceIdByLogicDeviceId(1, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::CtxSetSysParamOpt).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.CtxSetSysParamOpt(SYS_OPT_DETERMINISTIC, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::CtxGetSysParamOpt).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.CtxGetSysParamOpt(SYS_OPT_DETERMINISTIC, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::CtxGetOverflowAddr).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.CtxGetOverflowAddr(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetDeviceSatStatus).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.GetDeviceSatStatus(NULL, 1, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::CleanDeviceSatStatus).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.CleanDeviceSatStatus(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetAllUtilizations).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.GetAllUtilizations(1, RT_UTIL_TYPE_AICORE, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, testMemAdviseTest)
{
    ApiImpl impl;
    ApiDecorator apiDec(&impl);
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemAdvise).stubs().will(returnValue(RT_ERROR_NONE));
    auto error = apiDec.MemAdvise(NULL, 1, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemCopySyncEx).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemCopySyncEx(NULL, 1, NULL, 1, RT_MEMCPY_HOST_TO_HOST);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemcpyAsyncPtr).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemcpyAsyncPtr(NULL, 1, 1, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetDevArgsAddr).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.GetDevArgsAddr(NULL, NULL, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ReduceAsyncV2).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.ReduceAsyncV2(NULL, NULL, 1, RT_MEMCPY_SDMA_AUTOMATIC_ADD, RT_DATA_TYPE_FP32, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetDeviceIDs).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.GetDeviceIDs(NULL, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetPhyDeviceInfo).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.GetPhyDeviceInfo(1, 1, 1, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ModelSetSchGroupId).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.ModelSetSchGroupId(NULL, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::SetExceptCallback).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.SetExceptCallback(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetNotifyPhyInfo).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.GetNotifyPhyInfo(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::SetMsprofReporterCallback).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.SetMsprofReporterCallback(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetFaultEvent).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.GetFaultEvent(1, NULL, NULL, 1, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemQueueInitFlowGw).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemQueueInitFlowGw(1, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, testGetTaskBufferLenTest)
{
    ApiImpl impl;
    ApiDecorator apiDec(&impl);
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetTaskBufferLen).stubs().will(returnValue(RT_ERROR_NONE));
    auto error = apiDec.GetTaskBufferLen(HWTS_STATIC_TASK_DESC, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::TaskSqeBuild).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.TaskSqeBuild(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::FreeKernelBin).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.FreeKernelBin(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EschedQueryInfo).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.EschedQueryInfo(1, RT_QUERY_TYPE_LOCAL_GRP_ID, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ModelCheckArchVersion).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.ModelCheckArchVersion(NULL, ARCH_S202);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ReserveMemAddress).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.ReserveMemAddress(NULL, 1, 1, NULL, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ReleaseMemAddress).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.ReleaseMemAddress(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MallocPhysical).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MallocPhysical(NULL, 1, NULL, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::FreePhysical).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.FreePhysical(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MapMem).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MapMem(NULL, 1, 1, NULL, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::UnmapMem).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.UnmapMem(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ExportToShareableHandle).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.ExportToShareableHandle(NULL, RT_MEM_HANDLE_TYPE_NONE, 1, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ImportFromShareableHandle).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.ImportFromShareableHandle(1, 1, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::SetPidToShareableHandle).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.SetPidToShareableHandle(1, NULL, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetAllocationGranularity).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.GetAllocationGranularity(NULL, RT_MEM_ALLOC_GRANULARITY_RECOMMENDED, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::BindHostPid).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.BindHostPid({});
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::UnbindHostPid).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.UnbindHostPid({});
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::QueryProcessHostPid).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.QueryProcessHostPid(1, NULL, NULL, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::SetStreamSqLockUnlock).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.SetStreamSqLockUnlock(NULL, false);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StreamClear).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.StreamClear(NULL, RT_STREAM_STOP);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::SetTaskAbortCallBack).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.SetTaskAbortCallBack(NULL, NULL, NULL, TaskAbortCallbackType::RT_SET_TASK_ABORT_CALLBACK);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::SetTaskAbortCallBack).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.SetTaskAbortCallBack(NULL, NULL, NULL, TaskAbortCallbackType::RTS_SET_DEVICE_TASK_ABORT_CALLBACK);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetMemUceInfo).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.GetMemUceInfo(0, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemUceRepair).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemUceRepair(0, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemQueueReset).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MemQueueReset(0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ResourceClean).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.ResourceClean(0, RT_NOTIFY_ID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EventDestroySync).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.EventDestroySync(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::NotifyReset).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.NotifyReset(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StreamTaskAbort).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.StreamTaskAbort(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StreamRecover).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.StreamRecover(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StreamTaskClean).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.StreamTaskClean(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, testBuffAllocTest)
{
    ApiImpl impl;
    ApiDecorator apiDec(&impl);
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::BuffAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    auto error = apiDec.BuffAlloc(1, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::BuffConfirm).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.BuffConfirm(NULL, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MbufBuild).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MbufBuild(NULL, 1, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MbufAllocEx).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MbufAllocEx(NULL, 1, 1, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::BuffFree).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.BuffFree(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MbufUnBuild).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MbufUnBuild(NULL, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MbufGet).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MbufGet(NULL, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MbufPut).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MbufPut(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MbufSetDataLen).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MbufSetDataLen(NULL, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MbufGetDataLen).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MbufGetDataLen(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MbufCopyBufRef).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MbufCopyBufRef(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MbufChainAppend).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MbufChainAppend(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MbufChainGetMbufNum).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MbufChainGetMbufNum(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MbufChainGetMbuf).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.MbufChainGetMbuf(NULL, 1, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EschedSubscribeEvent).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.EschedSubscribeEvent(1, 1, 1, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, testBinaryGetFunctionTest)
{
    ApiImpl impl;
    ApiDecorator apiDec(&impl);
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::BinaryGetFunction).stubs().will(returnValue(RT_ERROR_NONE));
    auto error = apiDec.BinaryGetFunction(NULL, 1, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::BinaryUnLoad).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.BinaryUnLoad(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::LaunchKernel).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.LaunchKernel(NULL, 1, NULL, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::AicpuInfoLoad).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.AicpuInfoLoad(NULL, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::NopTask).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.NopTask(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StreamSetMode).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.StreamSetMode(NULL, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetAvailStreamNum).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.GetAvailStreamNum(1, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetAvailEventNum).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.GetAvailEventNum(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetMaxModelNum).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.GetMaxModelNum(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EventCreateEx).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.EventCreateEx(NULL, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, TEST_RT_DEV_SETLIMIT)
{
    int32_t device = 0;
    rtLimitType_t type = RT_LIMIT_TYPE_LOW_POWER_TIMEOUT;
    uint32_t value = 0;
    rtError_t error = RT_ERROR_NONE;
    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetDevice(&device);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ((Runtime *)Runtime::Instance())->PrimaryContextRetain(device);

    error = rtDeviceSetLimit(device, type, value);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ((Runtime *)Runtime::Instance())->PrimaryContextRelease(device);


    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, TEST_MODEL_LOAD_COMPLETE_SINK)
{
    rtError_t error = RT_ERROR_NONE;
    rtModel_t model;
    rtStream_t stream;

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_PERSISTENT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelLoadComplete(model);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, TEST_MODEL_LOAD_COMPLETE_MODEL_MORE_THEN_1)
{
    rtError_t error = RT_ERROR_NONE;
    rtModel_t model;
    rtModel_t model2;
    rtStream_t stream;

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model2, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelLoadComplete(model);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, TEST_MODEL_LOAD_COMPLETE_FAIL)
{
    rtError_t error = RT_ERROR_NONE;
    rtModel_t model;
    rtStream_t stream;

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelLoadComplete(model);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
}

TEST_F(CloudV2ApiTest910b, TEST_MODEL_LOAD_COMPLETE)
{
    rtError_t error = RT_ERROR_NONE;
    rtModel_t model;
    rtStream_t stream;

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelLoadComplete(model);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, test_get_fault_event)
{
    rtError_t error;
    uint32_t eventCount;
    rtDmsEventFilter filter;
    rtDmsFaultEvent dmsEvent;
    MOCKER(halGetFaultEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    error = rtGetFaultEvent(0, &filter, &dmsEvent, sizeof(rtDmsFaultEvent), &eventCount);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, TaskFailCallBackManager_Notify)
{
    rtExceptionInfo_t exceptionInfo = {0};
    TaskFailCallBackReg("test",  RtPtrToPtr<void *>(StubTaskFailCallback), nullptr,
        TaskFailCallbackType::RT_REG_TASK_FAIL_CALLBACK_BY_MODULE);
    TaskFailCallBackNotify(&exceptionInfo);
    EXPECT_EQ(g_exception_device_id, 0);
}

TEST_F(CloudV2ApiTest910b, TaskFailCallBackManager_NotifyException)
{
    rtExceptionInfo_t exceptionInfo = {0};
    TaskFailCallBackReg("test",  RtPtrToPtr<void *>(StubTaskFailCallback), nullptr,
        TaskFailCallbackType::RT_REG_TASK_FAIL_CALLBACK_BY_MODULE);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *dev = rtInstance->GetDevice(0, 0);
    auto& exceptionRegMap = dev->GetExceptionRegMap();

    // taskId和streamId作为key值不匹配，从Map中未获取到数据
    std::pair<uint32_t, uint32_t> invalidKey = {0, 1};
    exceptionRegMap[invalidKey] = {};
    TaskFailCallBackNotify(&exceptionInfo);
    EXPECT_EQ(g_exception_device_id, 0);

    std::pair<uint32_t, uint32_t> key = {0, 0};
    rtExceptionErrRegInfo_t regInfo = {0};
    regInfo.coreId = 1;
    exceptionRegMap[key].push_back(regInfo);
    TaskFailCallBackNotify(&exceptionInfo);
    EXPECT_EQ(g_exception_device_id, 0);
}

TEST_F(CloudV2ApiTest910b, stub_acl_interfaces)
{
    rtError_t error;
    error = rtSetStreamSqLock(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtSetStreamSqUnlock(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtEndGraph(NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtEndGraphEx(NULL, NULL, 2);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtModelExit(NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtModelExecutorSet(NULL,0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtModelAbort(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtsModelAbort(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest910b, StreamGetMode_test)
{
    rtError_t error;

    ApiImpl impl;
    ApiDecorator api(&impl);

    uint64_t model = 0;
    error = api.StreamGetMode((cce::runtime::Stream*)stream_, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, stream_with_vector_core_or_other_flags)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_VECTOR_CORE_USE | RT_STREAM_PERSISTENT | RT_STREAM_AICPU);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, stream_with_mc2_or_other_flags)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_CP_PROCESS_USE | RT_STREAM_PERSISTENT);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest910b, stream_with_flag_vector_core_ok)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_VECTOR_CORE_USE);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, stream_with_flag_mc2)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreateWithFlags(&stream, 0, (RT_STREAM_ACSQ_LOCK | RT_STREAM_CP_PROCESS_USE));
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    error = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_CP_PROCESS_USE);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_ACSQ_LOCK);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamCreateWithFlags(&stream, 0, (RT_STREAM_CP_PROCESS_USE | RT_STREAM_FORCE_COPY));
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest910b, stream_with_flag_external)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreateWithFlagsExternal(&stream, 5, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest910b, stream_with_flag_api_fast)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreateWithFlags(&stream, 0, (0x200 | 0x400));
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, stream_with_flag_api)
{
    rtError_t error;
    rtStream_t stream;
    rtEvent_t event = NULL;

    error = rtStreamCreateWithFlags(&stream, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventReset(event, stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, stream_wait_event_null)
{
    rtError_t error;
    error = rtStreamWaitEvent(stream_, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, stream_wait_event_default_stream)
{
    rtError_t error;
    rtStream_t stream;
    rtEvent_t event;

    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventRecord(event, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamWaitEvent(NULL, event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, stream_wait_event_and_sync)
{
    rtError_t error;
    rtStream_t stream;
    rtEvent_t event;
    uint32_t event_id = 0;

    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventRecord(event, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetEventID(event, &event_id);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamWaitEvent(stream_, event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, stream_wait_event_and_sync_02)
{
    rtError_t error;
    rtStream_t stream;
    rtEvent_t event;
    uint32_t event_id = 0;

    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventRecord(event, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetEventID(event, &event_id);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamWaitEvent(stream_, event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronizeWithTimeout(stream_, 3);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, stream_sync)
{
    rtError_t error;
    rtEvent_t event;
    uint32_t event_id = 0;

    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventRecord(event, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetEventID(event, &event_id);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamWaitEvent(stream_, event);
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    TsStreamFailureMode old = ((Stream *)stream_)->Context_()->GetCtxMode();
    ((Stream *)stream_)->Context_()->SetCtxMode(STOP_ON_FAILURE);
    ((Stream *)stream_)->Device_()->SetIsRingbufferGetErr(true);
    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ((Stream *)stream_)->Device_()->SetIsRingbufferGetErr(false);
    ((Stream *)stream_)->Context_()->SetCtxMode(old);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, stream_switch)
{
    rtError_t error = rtStreamSwitchEx(NULL, RT_EQUAL, NULL, NULL, NULL, RT_SWITCH_INT32);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    rtStream_t falseStream;
    error = rtStreamCreate(&falseStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsSwitchStream(NULL, RT_EQUAL, NULL, RT_SWITCH_INT32, NULL, falseStream, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID); // falseStream not null

    error = rtsSwitchStream(NULL, RT_EQUAL, NULL, RT_SWITCH_INT32, NULL, NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest910b, stream_state_callback_reg)
{
    rtError_t error;
    char *regName = "lltruntime";
    error = rtRegStreamStateCallback(regName, RegStreamStateCallbackFunc);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ApiImpl impl;
    ApiDecorator api(&impl);
    error = rtRegStreamStateCallback("lltruntimeV2", RegStreamStateCallbackFunc);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtRegStreamStateCallback(regName, NULL);
    rtRegStreamStateCallback("lltruntimeV2", NULL);
}

TEST_F(CloudV2ApiTest910b, stream_state_callback_reg_null)
{
    rtError_t error = rtRegStreamStateCallback("lltruntime", NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, stream_state_callback_reg_notify)
{
    rtError_t error = rtRegStreamStateCallback("test", RegStreamStateCallbackFunc);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtStream_t stream;
    EXPECT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
    error = rtRegStreamStateCallback("test", NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, stream_reset_event_stream_null)
{
    rtError_t error;
    rtStream_t stream;
    rtEvent_t event;

    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventRecord(event, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamWaitEvent(nullptr, event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventReset(event, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, stream_reset_event_and_sync)
{
    rtError_t error;
    rtStream_t stream;
    rtEvent_t event;

    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventRecord(event, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventReset(event, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, stream_queuy)
{
    rtStream_t stream;
    rtError_t error = RT_ERROR_NONE;

    error = rtStreamCreate(&stream, 0);
    Api *api = Api::Instance();
    MOCKER_CPP_VIRTUAL(api, &Api::StreamQuery).stubs().will(returnValue(RT_ERROR_NONE));
    error = rtStreamQuery(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    int32_t id;
    error = rtGetStreamId(stream, &id);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    uint32_t mstr_count;
    uint32_t mtsk_count;
    ApiImpl impl;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetMaxStreamAndTask).stubs().will(returnValue(RT_ERROR_NONE));
    error = rtGetMaxStreamAndTask(1, &mstr_count, &mstr_count);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, stream_create_and_destroy_01)
{
    rtError_t error;

    Api *api_ = ((Runtime *)Runtime::Instance())->api_;
    ((Runtime *)Runtime::Instance())->api_ = NULL;

    error = rtStreamCreate(NULL, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    ((Runtime *)Runtime::Instance())->api_ = api_;
}

TEST_F(CloudV2ApiTest910b, sq_lock_unlock_test)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSetStreamSqLock(stream);
    error = rtSetStreamSqUnlock(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, set_taskFail_callback)
{
    rtError_t error;

    error = rtSetTaskFailCallback(taskFailCallback);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetTaskFailCallback(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, set_ipc_open_notify)
{
    rtError_t error;
    error = rtIpcOpenNotify(NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest910b, set_ipc_notify_name)
{
    rtError_t error;
    error = rtIpcSetNotifyName(NULL, NULL, 1);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest910b, set_device_repeat)
{
    rtError_t error;

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(-1);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, set_default_device_id_valid)
{
    rtError_t error = RT_ERROR_NONE;
    error = rtSetDefaultDeviceId(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_EQ(rtInstance->defaultDeviceId_, 0);
    EXPECT_EQ(rtInstance->hasSetDefaultDevId_, true);
    error = rtSetDefaultDeviceId(0xFFFFFFFF);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, set_default_device_id)
{
    rtError_t error = RT_ERROR_NONE;
    error = rtSetDefaultDeviceId(0xFFFFFFFF);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_EQ(rtInstance->defaultDeviceId_, 0xFFFFFFFF);
    EXPECT_EQ(rtInstance->hasSetDefaultDevId_, false);
}

TEST_F(CloudV2ApiTest910b, set_default_device_id_invalid)
{
    rtError_t error = RT_ERROR_NONE;
    error = rtSetDefaultDeviceId(1000);
    EXPECT_NE(error, RT_ERROR_NONE);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_EQ(rtInstance->defaultDeviceId_, 0xFFFFFFFF);
    EXPECT_EQ(rtInstance->hasSetDefaultDevId_, false);
    error = rtSetDefaultDeviceId(0xFFFFFFFF);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, send_task_fail)
{
    rtError_t error;
    rtEvent_t event;
    uint32_t event_id = 0;

    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    TsStreamFailureMode old = ((Stream *)stream_)->Context_()->GetCtxMode();
    ((Stream *)stream_)->Context_()->SetCtxMode(STOP_ON_FAILURE);
    ((Stream *)stream_)->Context_()->SetFailureError(TS_ERROR_AIVEC_OVERFLOW);
    ((Stream *)stream_)->failureMode_ = ABORT_ON_FAILURE;
    error = rtEventRecord(event, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Stream *)stream_)->failureMode_ = CONTINUE_ON_FAILURE;
    ((Stream *)stream_)->Context_()->SetFailureError(0);
    ((Stream *)stream_)->Context_()->SetCtxMode(old);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, runtime_stream_create_test)
{
    int32_t devId = 0;
    rtError_t error;
    rtContext_t ctx;
    rtStream_t stream;

    MOCKER(Api::Instance).stubs().will(returnValue((Api *)NULL));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);
}

TEST_F(CloudV2ApiTest910b, runtime_memcpy_Async_test)
{
    rtError_t error;
    void *hostPtr = (void*)0x41;
    void *devPtr = (void*)0x42;
    uint64_t count = 64*1024*1024+1;

    error = rtMemcpyAsync(devPtr, count, hostPtr, count, RT_MEMCPY_DEVICE_TO_DEVICE, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, rtStreamWaitEventWithTimeout)
{
    rtError_t error;
    error = rtStreamWaitEventWithTimeout(nullptr, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest910b, rtStreamTaskClean_02)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t devId = 0U;
    RawDevice *device = new RawDevice(0);
    device->Init();
    Stream *stm = new Stream(device, 0);

    stm->SetBindFlag(true);
    error = rtStreamTaskClean(stm);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    delete stm;
    delete device;
}

TEST_F(CloudV2ApiTest910b, rtStreamSynchronizeWithTimeout)
{
    rtError_t error;

    rtStream_t stream;
    error = rtStreamCreate(&stream, 5);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_END_OF_SEQUENCE));

    error = rtStreamSynchronizeWithTimeout(stream, 100);
    EXPECT_NE(error, RT_ERROR_NONE);
    Stream *stream_var = static_cast<Stream *>(stream);
    stream_var->pendingNum_.Set(0);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

TEST_F(CloudV2ApiTest910b, rtStreamSynchronize_ctx_switch)
{
    rtError_t error;
    rtStream_t stream;
    error = rtStreamCreate(&stream, 5);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t oldCtx;
    rtCtxGetCurrent(&oldCtx);
    rtContext_t ctx;
    rtCtxCreate(&ctx, 0, 1);
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_END_OF_SEQUENCE));
    error = rtStreamSynchronize(stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_NE(error, RT_ERROR_NONE);  // contxt != curCtx err

    (void)rtCtxDestroy(ctx);
    rtCtxSetCurrent(oldCtx);
    GlobalMockObject::verify();
}

TEST_F(CloudV2ApiTest910b, rtStreamSynchronize)
{
    rtError_t error;

    rtStream_t stream;
    error = rtStreamCreate(&stream, 5);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_END_OF_SEQUENCE));

    error = rtStreamSynchronize(stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

TEST_F(CloudV2ApiTest910b, rtStreamSetModeTest_chipAbnorm)
{
    rtError_t error;
    void *stm = nullptr;
    error = rtStreamSetMode(stm, 1);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(CloudV2ApiTest910b, rtStreamAbort_02) {
    rtStream_t stream;
    rtError_t error = RT_ERROR_NONE;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ts_ctrl_msg_body_t ack;
    ack.u.query_task_ack_info.status = 3;
    size_t count;
    count = sizeof(ts_ctrl_msg_body_t);
    MOCKER(halTsdrvCtl)
        .stubs()
	.with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP((void*)&ack, sizeof(ack)), outBoundP(&count, sizeof(count)))
        .will(returnValue(DRV_ERROR_NONE));

    MOCKER(halSqCqFree)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER(halSqCqAllocate)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER_CPP(&StreamSqCqManage::UpdateStreamSqCq)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = rtStreamAbort(stream);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

// normal case
TEST_F(CloudV2ApiTest910b, rtStreamAbort_00) {
    rtStream_t stream;
    rtError_t error = RT_ERROR_NONE;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ts_ctrl_msg_body_t ack;
    ack.u.query_task_ack_info.status = 3;
    size_t count;
    count = sizeof(ts_ctrl_msg_body_t);
    MOCKER(halTsdrvCtl)
        .stubs()
	.with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP((void*)&ack, sizeof(ack)), outBoundP(&count, sizeof(count)))
        .will(returnValue(DRV_ERROR_NONE));

    MOCKER_CPP(&Context::IsStreamAbortSupported)
        .stubs()
        .will(returnValue(true));

    MOCKER(halSqCqFree)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER(halSqCqAllocate)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER_CPP(&StreamSqCqManage::UpdateStreamSqCq)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = rtStreamAbort(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, rtsStreamStop) {
    rtStream_t stream;
    rtError_t error = RT_ERROR_NONE;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    uint32_t cqid;
    uint32_t logicCqid;
    rtStreamGetCqid(stream, &cqid, &logicCqid);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtsStreamStop(stream);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, rtsSetTaskFailCallback_001)
{
    rtError_t error;
    char *regName ="lltruntime";
    error = rtsSetTaskFailCallback(regName, &stubRtsTaskFailCallback, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsSetTaskFailCallback(regName, &stubRtsTaskFailCallback, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsSetTaskFailCallback(regName, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsSetTaskFailCallback(nullptr, &stubRtsTaskFailCallback, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    char *regName1 ="struntime-rts";
    error = rtsSetTaskFailCallback(regName1, &stubRtsTaskFailCallback, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, rtsSetTaskFailCallback_002)
{
    rtError_t error;

    error = rtsSetTaskFailCallback("_DEFAULT_MODEL_NAME_", &stubRtsTaskFailCallback, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsSetTaskFailCallback("_DEFAULT_MODEL_NAME_", nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, rtsSetTaskFailCallback_003)
{
    rtError_t error;
    char *regName ="lltruntime-fake";
    error = rtsSetTaskFailCallbackFake(regName, &stubRtsTaskFailCallback, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest910b, rtsSetDeviceTaskAbortCallback_001)
{
    rtError_t error;
	char *regName ="HCCL";
    error = rtsSetDeviceTaskAbortCallback(regName, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsSetDeviceTaskAbortCallback(regName, &stubRtsDeviceTaskAbortCallback, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsSetDeviceTaskAbortCallback(regName, &stubRtsDeviceTaskAbortCallback, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsSetDeviceTaskAbortCallback(regName, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsSetDeviceTaskAbortCallback(regName, &stubRtsDeviceTaskAbortCallback, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsSetDeviceTaskAbortCallback(nullptr, &stubRtsDeviceTaskAbortCallback, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest910b, rtsSetDeviceTaskAbortCallback_003)
{
    rtError_t error;
	char *regName ="HCCL-fake";
    error = rtsSetDeviceTaskAbortCallbackFake(regName, &stubRtsDeviceTaskAbortCallback, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest910b, rtsSetDeviceTaskAbortCallback_004)
{
    rtError_t error;
    char *regName ="task-abort";
    error = rtsSetDeviceTaskAbortCallback(regName, &stubRtsDeviceTaskAbortCallback, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtInstance->TaskAbortCallBack(0, RT_DEVICE_ABORT_PRE, 1000);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, rtsSetDefaultDeviceId_01)
{
    rtError_t error = RT_ERROR_NONE;
    error = rtsSetDefaultDeviceId(0xFFFFFFFF);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_EQ(rtInstance->defaultDeviceId_, 0xFFFFFFFF);
    EXPECT_EQ(rtInstance->hasSetDefaultDevId_, false);
}


TEST_F(CloudV2ApiTest910b, rtsRegStreamStateCallback_001)
{
    rtError_t error;
    char *regName ="streamstate";
    error = rtsRegStreamStateCallback(regName, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsRegStreamStateCallback(regName, &stubRtsStreamStateCallback, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsRegStreamStateCallback(regName, &stubRtsStreamStateCallback, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsRegStreamStateCallback(regName, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsRegStreamStateCallback(nullptr, &stubRtsStreamStateCallback, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    char *regName1 ="streamstate-rts";    
    error = rtsRegStreamStateCallback(regName1, &stubRtsStreamStateCallback, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, rtsRegStreamStateCallback_002)
{
    rtError_t error = rtsRegStreamStateCallback("lltruntime", nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, rtsRegStreamStateCallback_003)
{
    rtError_t error = rtsRegStreamStateCallback("test", &stubRtsStreamStateCallback, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtStream_t stream;
    EXPECT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
    error = rtsRegStreamStateCallback("test", nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

rtError_t rtsRegStreamStateCallbackFake(const char_t *regName, rtsStreamStateCallback callback, void *args)
{
    Api * const apiInstance = Api::Instance();
    const rtError_t error = apiInstance->RegStreamStateCallback(regName, RtPtrToPtr<void *>(callback),
        args, StreamStateCallback::STREAM_CALLBACK_TYPE_MAX);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

TEST_F(CloudV2ApiTest910b, rtsRegStreamStateCallback_004)
{
    rtError_t error;
    char *regName ="streamstate-fake";
    error = rtsRegStreamStateCallbackFake(regName, &stubRtsStreamStateCallback, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}


TEST_F(CloudV2ApiTest910b, rtsRegDeviceStateCallback_001)
{
    rtError_t error;
    char *regName = "test_001";
    error = rtsRegDeviceStateCallback(regName, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsRegDeviceStateCallback(regName, &stubRtsDeviceStateCallback, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsRegDeviceStateCallback(nullptr, &stubRtsDeviceStateCallback, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsRegDeviceStateCallback(regName, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    char *regName2 = "test_002";
    error = rtsRegDeviceStateCallback(regName2, &stubRtsDeviceStateCallback, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsRegDeviceStateCallback(regName2, &stubRtsDeviceStateCallback, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

rtError_t rtsRegDeviceStateCallbackFake(const char_t *regName, rtsDeviceStateCallback callback, void *args)
{
    Api * const apiInstance = Api::Instance();
    const rtError_t error = apiInstance->RegDeviceStateCallback(regName, RtPtrToPtr<void *>(callback),
        args, DeviceStateCallback::DEVICE_CALLBACK_TYPE_MAX, DEV_CB_POS_END);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

TEST_F(CloudV2ApiTest910b, rtsRegDeviceStateCallback_002)
{
    rtError_t error;
	char *regName ="devstate-fake";
    error = rtsRegDeviceStateCallbackFake(regName, &stubRtsDeviceStateCallback, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest910b, rtsRegDeviceStateCallback_003)
{
    ResetAllDeviceStateV2();
    DeviceStateCallbackManager::Instance().Notify(0, false, DEV_CB_POS_BACK, RT_DEVICE_STATE_RESET_POST);
    DeviceStateCallbackManager::Instance().Notify(1, true, DEV_CB_POS_BACK, RT_DEVICE_STATE_SET_POST);
    EXPECT_EQ(g_rtsDeviceStateCallback[0], RT_DEVICE_STATE_RESET_POST);
    EXPECT_EQ(g_rtsDeviceStateCallback[1], RT_DEVICE_STATE_SET_POST);
}

TEST_F(CloudV2ApiTest910b, rtsProfTrace_005)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    int32_t length = 18;
    uint8_t data[length] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
    error = rtsProfTrace(&data, length, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(CloudV2ApiTest910b, rtsProfTrace_006)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_FORBIDDEN_DEFAULT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    int32_t length = 18;
    uint8_t data[length] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
    error = rtsProfTrace(&data, length, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error =rtStreamSynchronize(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, rtsProfTrace_007)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RawDevice *stubDevice = new RawDevice(0);
    stubDevice->Init();

    MOCKER(ProfilerTraceExTaskInit).stubs().will(invoke(ProfilerTraceExTaskInitStub));

    int32_t length = 18;
    uint8_t data[length] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
    error = rtsProfTrace(&data, length, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete stubDevice;
}

TEST_F(CloudV2ApiTest910b, rtsPersistentTaskClean_001)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t devId = 0U;
    RawDevice *device = new RawDevice(0);
    device->Init();
    Stream *stm = new Stream(device, 0);

    stm->SetBindFlag(true);
    error = rtsPersistentTaskClean(stm);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    delete stm;
    delete device;
}


TEST_F(CloudV2ApiTest910b, rtsMemReserveAddress)
{
    rtError_t error;
    rtMallocPolicy policy = RT_MEM_MALLOC_HUGE_FIRST;

    error = rtsMemReserveAddress(nullptr, 10, policy, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    void *virPtr = nullptr;
    error = rtsMemReserveAddress(&virPtr, 0, policy, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsMemReserveAddress(&virPtr, 100, policy, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemFreeAddress(&virPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemReserveAddress(&virPtr, 100, policy, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemFreeAddress(&virPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, rtsMemReserveAddress_01)
{
    rtError_t error;

    rtMallocPolicy policy = RT_MEM_MALLOC_HUGE_ONLY;

    void *virPtr = nullptr;

    error = rtsMemReserveAddress(&virPtr, 100, policy, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemFreeAddress(&virPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halMemAddressReserve)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtsMemReserveAddress(&virPtr, 100, policy, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsMemFreeAddress(&virPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, rtsMemReserveAddress_02)
{
    rtError_t error;
    void *virPtr = (void *)100;
    rtMallocPolicy policy = RT_MEM_MALLOC_HUGE_ONLY;

    error = rtsMemReserveAddress(&virPtr, 100, policy, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemFreeAddress(&virPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    virPtr = (void *)100;
    MOCKER(halMemAddressReserve)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtsMemReserveAddress(&virPtr, 100, policy, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsMemFreeAddress(&virPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();

    virPtr = (void *)100;
    MOCKER(halMemAddressReserve)
        .stubs()
        .will(returnValue(DRV_ERROR_NOT_SUPPORT));

    error = rtsMemReserveAddress(&virPtr, 100, policy, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    GlobalMockObject::verify();
}

TEST_F(CloudV2ApiTest910b, rtsMemReserveAddress_03)
{
    // rtMallocConfig_t cfg
    // rtMallocConfig_t cfg
    rtError_t error;
    rtMallocAttribute_t attrs[1];
    // 默认参数
    // memType
    // attrsNum
    rtMallocConfig_t cfg;
    cfg.attrs = attrs;
    cfg.numAttrs = sizeof(attrs) / sizeof(rtMallocAttribute_t);

    rtMallocPolicy policy =  RT_MEM_MALLOC_HUGE_ONLY_P2P;
    void *virPtr = nullptr;

    error = rtsMemReserveAddress(&virPtr, 100, policy, nullptr, &cfg);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest910b, rtsMemMap)
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

TEST_F(CloudV2ApiTest910b, rtsMemMap_01)
{
    rtError_t error;

    void *virptr = (void *)10;
    rtMemHandle handVal;

    MOCKER(halMemMap)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtsMemMap(virptr, 100, 0, handVal, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsMemUnmap(virptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, rtsMemMap_02)
{
    rtError_t error;

    void *virptr = (void *)10;
    rtMemHandle handVal;

    GlobalMockObject::verify();
    MOCKER(halMemMap)
        .stubs()
        .will(returnValue(DRV_ERROR_NOT_SUPPORT));

    error = rtsMemMap(virptr, 100, 0, handVal, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtsMemUnmap(virptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, rtsMemMallocPhysical)
{
    rtError_t error;
    // rtMallocConfig_t cfg
    rtMallocAttribute_t attrs[2];
    // 默认参数
    // policy
    // moduleId
    attrs[1].attr = RT_MEM_MALLOC_ATTR_MODULE_ID;
    attrs[1].value.moduleId = DEFAULT_MODULEID;
    // attrsNum
    rtMallocConfig_t cfg;
    cfg.attrs = attrs;
    cfg.numAttrs = sizeof(attrs) / sizeof(rtMallocAttribute_t);

    rtMallocPolicy policy =  RT_MEM_MALLOC_HUGE_FIRST;

    rtMemHandle handVal;
    rtMemHandle* handle = &handVal;

    error = rtsMemMallocPhysical(handle, 0, policy, &cfg);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsMemFreePhysical(handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemMallocPhysical(nullptr, 0, policy, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest910b, rtsMemMallocPhysical_01)
{
    rtError_t error;
    // rtMallocConfig_t cfg
    rtMallocAttribute_t attrs[2];
    // 默认参数
    // policy
    // moduleId
    attrs[0].attr = RT_MEM_MALLOC_ATTR_MODULE_ID;
    attrs[0].value.moduleId = DEFAULT_MODULEID;
    // deviceId
    attrs[1].attr = RT_MEM_MALLOC_ATTR_DEVICE_ID;
    attrs[1].value.deviceId = 0;
    // attrsNum
    rtMallocConfig_t cfg;
    cfg.attrs = attrs;
    cfg.numAttrs = sizeof(attrs) / sizeof(rtMallocAttribute_t);

    rtMallocPolicy policy =  static_cast<rtMallocPolicy>(RT_MEM_MALLOC_HUGE_ONLY | RT_MEM_TYPE_HIGH_BAND_WIDTH);

    rtMemHandle handVal;
    rtMemHandle* handle = &handVal;

    error = rtsMemMallocPhysical(handle, 100, policy, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemFreePhysical(handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemMallocPhysical(nullptr, 0,  policy, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest910b, rtsMemMallocPhysical_02)
{
    rtError_t error;
    // rtMallocConfig_t cfg
    rtMallocAttribute_t attrs[1];
    // 默认参数
    // policy
    // moduleId
    attrs[0].attr = RT_MEM_MALLOC_ATTR_MODULE_ID;
    attrs[0].value.moduleId = DEFAULT_MODULEID;
    // attrsNum
    rtMallocConfig_t cfg;
    cfg.attrs = attrs;
    cfg.numAttrs = sizeof(attrs) / sizeof(rtMallocAttribute_t);

    rtMallocPolicy policy =  static_cast<rtMallocPolicy>(RT_MEM_MALLOC_NORMAL_ONLY | RT_MEM_TYPE_HIGH_BAND_WIDTH);

    rtMemHandle handVal;
    rtMemHandle* handle = &handVal;

    error = rtsMemMallocPhysical(handle, 100, policy, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemFreePhysical(handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemMallocPhysical(handle, 100, policy, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halMemCreate)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));

    error = rtsMemMallocPhysical(handle, 100, policy, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    MOCKER(halMemCreate)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtsMemMallocPhysical(handle, 100, policy, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest910b, rtsMemMallocPhysical_03)
{
    rtError_t error;
    // rtMallocConfig_t cfg
    rtMallocAttribute_t attrs[1];
    // 默认参数
    // moduleId
    attrs[0].attr = RT_MEM_MALLOC_ATTR_MODULE_ID;
    attrs[0].value.moduleId = DEFAULT_MODULEID;
    // attrsNum
    rtMallocConfig_t cfg;
    cfg.attrs = attrs;
    cfg.numAttrs = sizeof(attrs) / sizeof(rtMallocAttribute_t);

    rtMallocPolicy policy =  static_cast<rtMallocPolicy>(RT_MEM_MALLOC_NORMAL_ONLY | RT_MEM_TYPE_HIGH_BAND_WIDTH);

    rtMemHandle handVal;
    rtMemHandle* handle = &handVal;

    error = rtsMemMallocPhysical(handle, 100, policy, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemFreePhysical(handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, rtsMemMallocPhysical_04)
{
    rtError_t error;
    // rtMallocConfig_t cfg
    rtMallocAttribute_t attrs[2];
    // 默认参数
    // moduleId
    attrs[0].attr = RT_MEM_MALLOC_ATTR_MODULE_ID;
    attrs[0].value.moduleId = DEFAULT_MODULEID;
    // error
    attrs[1].attr = RT_MEM_MALLOC_ATTR_MAX;
    // attrsNum
    rtMallocConfig_t cfg;
    cfg.attrs = attrs;
    cfg.numAttrs = sizeof(attrs) / sizeof(rtMallocAttribute_t);

    rtMallocPolicy policy =  static_cast<rtMallocPolicy>(RT_MEM_MALLOC_NORMAL_ONLY | RT_MEM_TYPE_HIGH_BAND_WIDTH);

    rtMemHandle handVal;
    rtMemHandle* handle = &handVal;

    error = rtsMemMallocPhysical(handle, 100, policy, &cfg);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiTest910b, rtsMemMallocPhysical_05)
{
    rtError_t error;
    rtMallocConfig_t cfg;
    cfg.attrs = nullptr;
    cfg.numAttrs = 1;

    rtMallocPolicy policy =  static_cast<rtMallocPolicy>(RT_MEM_MALLOC_NORMAL_ONLY | RT_MEM_TYPE_HIGH_BAND_WIDTH);

    rtMemHandle handVal;
    rtMemHandle* handle = &handVal;

    error = rtsMemMallocPhysical(handle, 100, policy, &cfg);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

/* new memory api ut */
TEST_F(CloudV2ApiTest910b, rtsMalloc_01)
{
    // rtMallocConfig_t cfg is nullptr
    rtError_t error;
    void * devPtr;
    rtMallocConfig_t * p = nullptr;
    error = rtsMalloc(&devPtr, 60, RT_MEM_MALLOC_HUGE_FIRST, RT_MEM_ADVISE_NONE, p);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, rtsMalloc_02)
{
    // rtMallocConfig_t cfg
    rtMallocAttribute_t attrs[1];
    // 默认参数
    // moduleId
    attrs[0].attr = RT_MEM_MALLOC_ATTR_MODULE_ID;
    attrs[0].value.moduleId = DEFAULT_MODULEID;

    rtMallocConfig_t cfg;
    cfg.attrs = attrs;
    cfg.numAttrs = sizeof(attrs) / sizeof(rtMallocAttribute_t);
    rtError_t error;
    void * devPtr;
    error = rtsMalloc(&devPtr, 60, RT_MEM_MALLOC_HUGE_FIRST, RT_MEM_ADVISE_NONE, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, rtsMalloc_03)
{
    // rtMallocConfig_t cfg  advise == RT_MEM_ADVISE_CACHED
    rtMallocAttribute_t attrs[1];
    // 默认参数

    // moduleId
    attrs[0].attr = RT_MEM_MALLOC_ATTR_MODULE_ID;
    attrs[0].value.moduleId = DEFAULT_MODULEID;

    rtMallocPolicy policy = RT_MEM_MALLOC_HUGE_FIRST;

    rtMallocConfig_t cfg;
    cfg.attrs = attrs;
    cfg.numAttrs = sizeof(attrs) / sizeof(rtMallocAttribute_t);
    rtError_t error;
    void * devPtr;
    error = rtsMalloc(&devPtr, 60, policy, RT_MEM_ADVISE_CACHED, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    // advise == RT_MEMORY_TS

    error = rtsMalloc(&devPtr, 60, policy, RT_MEM_ADVISE_TS, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    // advise == RT_MEMORY_NONE, policy = RT_MEMROY_POLICY_HUGE_ONLY
    // enumerate policy
    for (uint32_t i = 0; i < 3; ++i) {
        error = rtsMalloc(&devPtr, 60, static_cast<rtMallocPolicy>(i), RT_MEM_ADVISE_NONE, &cfg);
        EXPECT_EQ(error, RT_ERROR_NONE);
        error = rtsFree(devPtr);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }
}

TEST_F(CloudV2ApiTest910b, rtsMalloc_04)
{
    // rtMallocConfig_t cfg
    rtMallocAttribute_t attrs[1];
    // for dvpp
    // moduleId
    attrs[0].attr = RT_MEM_MALLOC_ATTR_MODULE_ID;
    attrs[0].value.moduleId = DEFAULT_MODULEID;

    rtMallocConfig_t cfg;
    cfg.attrs = attrs;
    cfg.numAttrs = sizeof(attrs) / sizeof(rtMallocAttribute_t);
    rtError_t error;
    void * devPtr;
    rtMallocPolicy policy = RT_MEM_ACCESS_USER_SPACE_READONLY;
    error = rtsMalloc(&devPtr, 60, policy, RT_MEM_ADVISE_DVPP, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    //policy not in  rtMallocPolicy use default
    policy = static_cast<rtMallocPolicy>(0xFF);
    error = rtsMalloc(&devPtr, 60, policy, RT_MEM_ADVISE_DVPP, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    // invalid attr RT_MEM_MALLOC_ATTR_MAX
    attrs[0].attr = RT_MEM_MALLOC_ATTR_MAX;
    error = rtsMalloc(&devPtr, 60, policy, RT_MEM_ADVISE_DVPP, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, rtsMalloc_05)
{
    // rtMallocConfig_t cfg
    rtMallocAttribute_t attrs[1];
    // 默认参数

    // memType
    rtMallocPolicy policy = static_cast<rtMallocPolicy>(RT_MEM_MALLOC_HUGE_FIRST | 0x100);
    // moduleId
    attrs[0].attr = RT_MEM_MALLOC_ATTR_RSV;

    rtMallocConfig_t cfg;
    cfg.attrs = attrs;
    cfg.numAttrs = sizeof(attrs) / sizeof(rtMallocAttribute_t);
    rtError_t error;
    void * devPtr;
    error = rtsMalloc(&devPtr, 60, policy, RT_MEM_ADVISE_NONE, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    policy = static_cast<rtMallocPolicy>(RT_MEM_MALLOC_HUGE_FIRST | 0x1000);
    attrs[0].attr = RT_MEM_MALLOC_ATTR_DEVICE_ID;
    attrs[0].value.deviceId = 0;
    error = rtsMalloc(&devPtr, 60, policy, RT_MEM_ADVISE_NONE, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

}

TEST_F(CloudV2ApiTest910b, rtsMalloc_06)
{
    // rtMallocConfig_t cfg
    rtMallocAttribute_t attrs[1];
    // 默认参数
    // moduleId
    attrs[0].attr = RT_MEM_MALLOC_ATTR_DEVICE_ID;
    attrs[0].value.moduleId = 0x5AU;

    rtMallocConfig_t cfg;
    cfg.attrs = attrs;
    cfg.numAttrs = sizeof(attrs) / sizeof(rtMallocAttribute_t);
    rtError_t error;
    void * devPtr;
    error = rtsMalloc(&devPtr, 60, RT_MEM_MALLOC_HUGE_FIRST, RT_MEM_ADVISE_NONE, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, rtsMalloc_07)
{
    // rtMallocConfig_t cfg
    rtMallocAttribute_t attrs[1];
    // 默认参数
    // moduleId
    attrs[0].attr = RT_MEM_MALLOC_ATTR_MODULE_ID;
    attrs[0].value.moduleId = DEFAULT_MODULEID;

    rtMallocConfig_t cfg;
    cfg.attrs = attrs;
    cfg.numAttrs = sizeof(attrs) / sizeof(rtMallocAttribute_t);
    rtError_t error;
    void * devPtr;
    error = rtsMalloc(&devPtr, 60, RT_MEM_MALLOC_HUGE_FIRST, RT_MEM_ADVISE_CACHED, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, label_api)
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

    error = rtLabelDestroy(label);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, kernel_launch)
{
    rtError_t error;
    void *args[] = {&error, NULL};
    void *stubFunc;

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    error = rtKernelLaunch(&error, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtKernelLaunch(&function_, 1, NULL, 0, NULL, stream_);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtKernelLaunch(&function_, 0, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetFunctionByName("foo", &stubFunc);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(stubFunc, (void*)&function_);

    error = rtGetFunctionByName("fooooo", &stubFunc);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtGetFunctionByName(NULL, &stubFunc);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, kernel_launch_cloud)
{
    rtError_t error;
    void *args[] = {&error, NULL};

    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(CloudV2ApiTest910b, kernel_launch_fusion_not_mini)
{
    rtError_t error;
    void *args[] = {&error, NULL};

    error = rtKernelFusionStart(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtKernelFusionEnd(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

//changed
TEST_F(CloudV2ApiTest910b, kernel_launch_l2_preload_mem_unaligned)
{
    rtError_t error;
    rtL2Ctrl_t ctrl;
    void *args[] = {&error, NULL};

    memset_s(&ctrl, sizeof(rtSmDesc_t), 0, sizeof(rtSmDesc_t));

    ctrl.size = 0;

    for (uint32_t i = 0; i < 8; i++)
    {
        ctrl.data[i].L2_mirror_addr = 0x40 * i;
    }
    ctrl.data[2].L2_mirror_addr = 0x41;
    ctrl.size = 128;
    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), &ctrl, stream_);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}


TEST_F(CloudV2ApiTest910b, kernel_trans_arg)
{
    rtError_t error;
    void *arg = NULL;

    error = rtKernelConfigTransArg(NULL, 128, 0, &arg);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtKernelConfigTransArg(&error, 128, 0, &arg);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(CloudV2ApiTest910b, kernel_trans_arg_cmodel)
{
    rtError_t error;
    void *arg = NULL;

    error = rtKernelConfigTransArg(NULL, 128, 0, &arg);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtKernelConfigTransArg(&error, 128, 0, &arg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    void *args[] = {arg, NULL, NULL};
    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(CloudV2ApiTest910b, kernel_launch_with_default_stream)
{
    rtError_t error;
    void *args[] = {&error, NULL};

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(CloudV2ApiTest910b, host_mem_alloc_free)
{
    rtError_t error;
    void * hostPtr;

    error = rtMallocHost(&hostPtr, 0, DEFAULT_MODULEID);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtMallocHost(&hostPtr, 60, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFreeHost(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(CloudV2ApiTest910b, host_mem_alloc_free_02)
{
    rtError_t error;
    void * hostPtr;
    rtMallocConfig_t *malloCfg = (rtMallocConfig_t *)malloc(sizeof(rtMallocConfig_t));
    rtMallocAttribute_t* mallocAttrs = new rtMallocAttribute_t[1];
    malloCfg->numAttrs = 1;
    malloCfg->attrs = mallocAttrs;
    mallocAttrs[0].attr = RT_MEM_MALLOC_ATTR_MODULE_ID;
    mallocAttrs[0].value.moduleId = 1;
    error = rtsMallocHost(&hostPtr, 0, malloCfg);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsMallocHost(&hostPtr, 60, malloCfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsFreeHost(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete[] mallocAttrs;
    free(malloCfg);
}


TEST_F(CloudV2ApiTest910b, host_mem_alloc_free_03)
{
    rtError_t error;
    void * hostPtr;
    rtMallocConfig_t *malloCfg = (rtMallocConfig_t *)malloc(sizeof(rtMallocConfig_t));
    rtMallocAttribute_t* mallocAttrs = new rtMallocAttribute_t[1];
    malloCfg->numAttrs = 1;
    malloCfg->attrs = mallocAttrs;
    mallocAttrs[0].attr = RT_MEM_MALLOC_ATTR_MAX;
    error = rtsMallocHost(&hostPtr, 0, malloCfg);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsMallocHost(&hostPtr, 60, malloCfg);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    delete[] mallocAttrs;
    free(malloCfg);
}


TEST_F(CloudV2ApiTest910b, host_mem_alloc_free_04)
{
    rtError_t error;
    void * hostPtr;
    rtMallocConfig_t *malloCfg = (rtMallocConfig_t *)malloc(sizeof(rtMallocConfig_t));
    rtMallocAttribute_t* mallocAttrs = new rtMallocAttribute_t[2];
    malloCfg->numAttrs = 2;
    malloCfg->attrs = mallocAttrs;
    mallocAttrs[0].attr = RT_MEM_MALLOC_ATTR_MODULE_ID;
    mallocAttrs[0].value.moduleId = 1;
    mallocAttrs[1].attr = RT_MEM_MALLOC_ATTR_MODULE_ID;
    mallocAttrs[1].value.moduleId = 3;
    error = rtsMallocHost(&hostPtr, 0, malloCfg);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsMallocHost(&hostPtr, 60, malloCfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsFreeHost(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete[] mallocAttrs;
    free(malloCfg);
}


TEST_F(CloudV2ApiTest910b, host_mem_alloc_free_05)
{
    rtError_t error;
    void * hostPtr;
    rtMallocConfig_t *malloCfg = (rtMallocConfig_t *)malloc(sizeof(rtMallocConfig_t));
    rtMallocAttribute_t* mallocAttrs = nullptr;
    malloCfg->numAttrs = 1;
    malloCfg->attrs = mallocAttrs;
    error = rtsMallocHost(&hostPtr, 30, malloCfg);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    free(malloCfg);
}


TEST_F(CloudV2ApiTest910b, host_mem_alloc_free_apiDec)
{
    rtError_t error;
    void * hostPtr;

    Api *api = Api::Instance();
    ApiDecorator apiDec(api);

    error = apiDec.HostMalloc(&hostPtr, 64);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDec.HostFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(CloudV2ApiTest910b, memory_attritue_fail)
{
    rtError_t error;
    void * hostPtr;
    rtPointerAttributes_t attributes;

    error = rtMallocHost(&hostPtr, 60, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_2));

    error = rtPointerGetAttributes(&attributes, hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFreeHost(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtPointerGetAttributes(NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}


TEST_F(CloudV2ApiTest910b, memory_attritue_1)
{
    rtError_t error;
    void * hostPtr;
    rtPointerAttributes_t attributes;

    error = rtMallocHost(&hostPtr, 60, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_1));
    error = rtPointerGetAttributes(&attributes, hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();

    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_2));
    error = rtPointerGetAttributes(&attributes, hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();

    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_3));
    error = rtPointerGetAttributes(&attributes, hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();

    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_4));
    error = rtPointerGetAttributes(&attributes, hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();

    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_5));
    error = rtPointerGetAttributes(&attributes, hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();

    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_6));
    error = rtPointerGetAttributes(&attributes, hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();

    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_7));
    error = rtPointerGetAttributes(&attributes, hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();

    error = rtFreeHost(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiTest910b, memory_attritue_apiDec)
{
    rtError_t error;
    void * hostPtr;
    rtPointerAttributes_t attributes;

    Api *api = Api::Instance();
    ApiDecorator apiDec(api);

    error = apiDec.HostMalloc(&hostPtr, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(drvMemGetAttribute).stubs().will(invoke(drvMemGetAttribute_2));

    error = apiDec.PointerGetAttributes(&attributes, hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDec.HostFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}