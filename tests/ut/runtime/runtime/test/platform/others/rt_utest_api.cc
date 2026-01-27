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

TEST_F(ApiTest, util_test)
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

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t type = rtInstance->chipType_;
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = rtGetAllUtilizations(0, RT_UTIL_TYPE_MAX, &utilValue);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    GlobalContainer::SetRtChipType(type);
}

TEST_F(ApiTest, ut_GetAddrAndPrefCntWithHandle_null)
{
    uint32_t prefetchCnt = 0;
    rtError_t error = rtGetAddrAndPrefCntWithHandle(NULL, NULL, NULL, &prefetchCnt);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, TestRtsGetDeviceInfo)
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

TEST_F(ApiTest, testRtDevBinaryRegisterAllApiTest)
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

TEST_F(ApiTest, testMemcpyHostTaskTest)
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

TEST_F(ApiTest, testMemAdviseTest)
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

TEST_F(ApiTest, testGetTaskBufferLenTest)
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

TEST_F(ApiTest, testBuffAllocTest)
{
    ApiImpl impl;
    ApiDecorator apiDec(&impl);
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::BuffAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    auto error = apiDec.BuffAlloc(1, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::BuffConfirm).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.BuffConfirm(NULL, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::BuffFree).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.BuffFree(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EschedSubscribeEvent).stubs().will(returnValue(RT_ERROR_NONE));
    error = apiDec.EschedSubscribeEvent(1, 1, 1, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, testBinaryGetFunctionTest)
{
    ApiImpl impl;
    ApiDecorator apiDec(&impl);
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::BinaryGetFunction).stubs().will(returnValue(RT_ERROR_NONE));
    auto error = apiDec.BinaryGetFunction(NULL, 1, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Program *prog;
    error = apiDec.MetadataRegister(prog, "test");
    EXPECT_EQ(error, RT_ERROR_METADATA);

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

TEST_F(ApiTest, TEST_RT_DEV_SETLIMIT)
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

TEST_F(ApiTest, TEST_MODEL_LOAD_COMPLETE_SINK)
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
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, TEST_MODEL_LOAD_COMPLETE_MODEL_MORE_THEN_1)
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
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, TEST_MODEL_LOAD_COMPLETE_FAIL)
{
    rtError_t error = RT_ERROR_NONE;
    rtModel_t model;
    rtStream_t stream;
    Engine *engine = new AsyncHwtsEngine(NULL);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(engine, &Engine::SubmitTaskNormal).stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtModelLoadComplete(model);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, stream);
    EXPECT_NE(error, RT_ERROR_NONE); // synchonize fail

    error = rtStreamDestroy(stream);
    EXPECT_NE(error, RT_ERROR_NONE); // stream bind err

    delete engine;
    GlobalMockObject::verify();
}

TEST_F(ApiTest, TEST_MODEL_LOAD_COMPLETE)
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
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, test_get_fault_event)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t type = rtInstance->chipType_;
    uint32_t eventCount;
    rtDmsEventFilter filter;
    rtDmsFaultEvent dmsEvent;
    MOCKER(halGetFaultEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = rtGetFaultEvent(0, &filter, &dmsEvent, sizeof(rtDmsFaultEvent), &eventCount);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    rtInstance->SetChipType(type);
    GlobalContainer::SetRtChipType(type);
}

TEST_F(ApiTest, TaskFailCallBackManager_Notify)
{
    rtExceptionInfo_t exceptionInfo = {0};
    TaskFailCallBackReg("test",  RtPtrToPtr<void *>(StubTaskFailCallback), nullptr,
        TaskFailCallbackType::RT_REG_TASK_FAIL_CALLBACK_BY_MODULE);
    TaskFailCallBackNotify(&exceptionInfo);
    EXPECT_EQ(g_exception_device_id, 0);
}

TEST_F(ApiTest, TaskFailCallBackManager_NotifyException)
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

TEST_F(ApiTest, stub_acl_interfaces)
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

TEST_F(ApiTest, StreamGetMode_test)
{
    rtError_t error;

    ApiImpl impl;
    ApiDecorator api(&impl);

    uint64_t model = 0;
    error = api.StreamGetMode((cce::runtime::Stream*)stream_, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, stream_with_vector_core_or_other_flags)
{
    rtError_t error;
    rtStream_t stream;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);

    error = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_VECTOR_CORE_USE | RT_STREAM_PERSISTENT | RT_STREAM_AICPU);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}

TEST_F(ApiTest, stream_with_mc2_or_other_flags)
{
    rtError_t error;
    rtStream_t stream;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);

    error = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_CP_PROCESS_USE | RT_STREAM_PERSISTENT);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}

TEST_F(ApiTest, stream_with_flag_vector_core_ok)
{
    rtError_t error;
    rtStream_t stream;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);

    error = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_VECTOR_CORE_USE);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}

TEST_F(ApiTest, stream_with_flag_mc2)
{
    rtError_t error;
    rtStream_t stream;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);

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

    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}

TEST_F(ApiTest, stream_with_flag_external)
{
    rtError_t error;
    rtStream_t stream;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t originType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);

    error = rtStreamCreateWithFlagsExternal(&stream, 5, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    rtInstance->SetChipType(originType);
    GlobalContainer::SetRtChipType(originType);
}

TEST_F(ApiTest, stream_with_flag_api_fast)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreateWithFlags(&stream, 0, (0x200 | 0x400));
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, stream_with_flag_api)
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

TEST_F(ApiTest, stream_wait_event_null)
{
    rtError_t error;
    error = rtStreamWaitEvent(stream_, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, stream_wait_event_default_stream)
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

TEST_F(ApiTest, stream_wait_event_and_sync)
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

TEST_F(ApiTest, stream_wait_event_and_sync_02)
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

TEST_F(ApiTest, stream_sync)
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

TEST_F(ApiTest, stream_switch_adc)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    error = rtStreamSwitchEx(NULL, RT_EQUAL, NULL, NULL, NULL, RT_SWITCH_INT32);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);

    rtStream_t falseStream;
    error = rtStreamCreate(&falseStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsSwitchStream(NULL, RT_EQUAL, NULL, RT_SWITCH_INT32, NULL, falseStream, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID); // falseStream not null

    error = rtsSwitchStream(NULL, RT_EQUAL, NULL, RT_SWITCH_INT32, NULL, NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest, stream_state_callback_reg)
{
    rtError_t error;
	char *regName ="lltruntime";
    error = rtRegStreamStateCallback(regName, RegStreamStateCallbackFunc);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ApiImpl impl;
    ApiDecorator api(&impl);
    error = rtRegStreamStateCallback("lltruntimeV2", RegStreamStateCallbackFunc);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, stream_state_callback_reg_null)
{
    rtError_t error = rtRegStreamStateCallback("lltruntime", NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, stream_state_callback_reg_notify)
{
    rtError_t error = rtRegStreamStateCallback("test", RegStreamStateCallbackFunc);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtStream_t stream;
    EXPECT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
    error = rtRegStreamStateCallback("test", nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, stream_reset_event_stream_null)
{
    rtError_t error;
    rtStream_t stream;
    rtEvent_t event;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DAVID);
    GlobalContainer::SetRtChipType(CHIP_DAVID);

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

    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}

TEST_F(ApiTest, stream_reset_event_and_sync)
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

TEST_F(ApiTest, stream_queuy)
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

TEST_F(ApiTest, stream_get_priority)
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

TEST_F(ApiTest, stream_get_flags)
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


TEST_F(ApiTest, stream_create_and_destroy_01)
{
    rtError_t error;

    Api *api_ = ((Runtime *)Runtime::Instance())->api_;
    ((Runtime *)Runtime::Instance())->api_ = NULL;

    error = rtStreamCreate(NULL, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    ((Runtime *)Runtime::Instance())->api_ = api_;
}


TEST_F(ApiTest, start5612spmpool)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *) Runtime::Instance();
    rtSocType_t oldSocType = rtInstance->GetSocType();
    Runtime::Instance()->SetSocType(SOC_ASCEND320T);
    int64_t hardwareVersion = CHIP_5612 << 8;
    driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver_,
        &Driver::GetDevInfo).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(),outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER(halGetSocVersion).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any()).will(returnValue(DRV_ERROR_NOT_SUPPORT));
    MOCKER(halGetDeviceInfo).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion))).will(returnValue(RT_ERROR_NONE));
    RawDevice *device = new RawDevice(1);
    error = device->Init();
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream * stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    device->primaryStream_ = stream;
    device->GetPendingNum();
    delete(device);
    rtInstance->SetSocType(oldSocType);
}

TEST_F(ApiTest, sq_lock_unlock_test)
{
    rtError_t error;
    rtStream_t stream;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_AS31XM1);
    GlobalContainer::SetRtChipType(CHIP_AS31XM1);
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSetStreamSqLock(stream);
    error = rtSetStreamSqUnlock(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
}

TEST_F(ApiTest, set_taskFail_callback)
{
    rtError_t error;

    error = rtSetTaskFailCallback(taskFailCallback);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetTaskFailCallback(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, set_ipc_open_notify_adc)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    error = rtIpcOpenNotify(NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
}

TEST_F(ApiTest, set_ipc_notify_name_adc)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    error = rtIpcSetNotifyName(NULL, NULL, 1);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
}

TEST_F(ApiTest, set_device_repeat)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    rtChipType_t chipTypeOri = rtInstance->GetChipType();

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(-1);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtInstance->SetChipType(chipTypeOri);
}

TEST_F(ApiTest, set_default_device_id_valid)
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

TEST_F(ApiTest, set_default_device_id)
{
    rtError_t error = RT_ERROR_NONE;
    error = rtSetDefaultDeviceId(0xFFFFFFFF);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_EQ(rtInstance->defaultDeviceId_, 0xFFFFFFFF);
    EXPECT_EQ(rtInstance->hasSetDefaultDevId_, false);
}

TEST_F(ApiTest, set_default_device_id_invalid)
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

TEST_F(ApiTest, send_task_fail)
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

TEST_F(ApiTest, runtime_stream_create_test)
{
    int32_t devId = 0;
    rtError_t error;
    rtContext_t ctx;
    rtStream_t stream;

    MOCKER(Api::Instance).stubs().will(returnValue((Api *)NULL));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);
}

TEST_F(ApiTest, runtime_memcpy_Async_test)
{
    rtError_t error;
    void *hostPtr = (void*)0x41;
    void *devPtr = (void*)0x42;
    uint64_t count = 64*1024*1024+1;

    error = rtMemcpyAsync(devPtr, count, hostPtr, count, RT_MEMCPY_DEVICE_TO_DEVICE, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, rtStreamWaitEventWithTimeout)
{
    rtError_t error;
    error = rtStreamWaitEventWithTimeout(nullptr, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
    error = rtStreamWaitEventWithTimeout(nullptr, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    rtInstance->SetChipType(CHIP_MINI_V3);
    GlobalContainer::SetRtChipType(CHIP_MINI_V3);
    error = rtStreamWaitEventWithTimeout(nullptr, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    rtInstance->SetChipType(CHIP_5612);
    GlobalContainer::SetRtChipType(CHIP_5612);
    error = rtStreamWaitEventWithTimeout(nullptr, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    rtInstance->SetChipType(CHIP_AS31XM1);
    GlobalContainer::SetRtChipType(CHIP_AS31XM1);
    error = rtStreamWaitEventWithTimeout(nullptr, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    rtInstance->SetChipType(CHIP_DAVID);
    GlobalContainer::SetRtChipType(CHIP_DAVID);
    error = rtStreamWaitEventWithTimeout(nullptr, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    error = rtStreamWaitEventWithTimeout(nullptr, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
}

TEST_F(ApiTest, rtStreamTaskClean_02)
{
    rtError_t error = RT_ERROR_NONE;
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtChipType_t originType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DAVID);
    GlobalContainer::SetRtChipType(CHIP_DAVID);
    uint32_t devId = 0U;
    RawDevice *device = new RawDevice(0);
    device->Init();
    Stream *stm = new Stream(device, 0);

    stm->SetBindFlag(true);
    error = rtStreamTaskClean(stm);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);
    rtInstance->SetChipType(originType);
    GlobalContainer::SetRtChipType(originType);

    delete stm;
    delete device;
}

TEST_F(ApiTest, rtStreamSynchronizeWithTimeout)
{
    rtError_t error;

    rtStream_t stream;
    error = rtStreamCreate(&stream, 5);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *stream_var_t = static_cast<Stream *>(stream);
    MOCKER_CPP_VIRTUAL(stream_var_t, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_END_OF_SEQUENCE));

    error = rtStreamSynchronizeWithTimeout(stream, 100);
    EXPECT_NE(error, RT_ERROR_NONE);
    Stream *stream_var = static_cast<Stream *>(stream);
    stream_var->pendingNum_.Set(0);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

TEST_F(ApiTest, rtStreamSynchronize_ctx_switch)
{
    rtError_t error;
    rtStream_t stream;
    error = rtStreamCreate(&stream, 5);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t oldCtx;
    rtCtxGetCurrent(&oldCtx);
    rtContext_t ctx;
    rtCtxCreate(&ctx, 0, 1);
    Stream *stream_var_t = static_cast<Stream *>(stream);
    MOCKER_CPP_VIRTUAL(stream_var_t, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_END_OF_SEQUENCE));
    error = rtStreamSynchronize(stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_NE(error, RT_ERROR_NONE);  // contxt != curCtx err

    (void)rtCtxDestroy(ctx);
    rtCtxSetCurrent(oldCtx);
    GlobalMockObject::verify();
}

TEST_F(ApiTest, rtStreamSynchronize)
{
    rtError_t error;

    rtStream_t stream;
    error = rtStreamCreate(&stream, 5);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream *stream_var_t = static_cast<Stream *>(stream);
    MOCKER_CPP_VIRTUAL(stream_var_t, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_END_OF_SEQUENCE));

    error = rtStreamSynchronize(stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

TEST_F(ApiTest, rtStreamSetModeTest_chipAbnorm)
{
    rtError_t error;
    void *stm = nullptr;
    error = rtStreamSetMode(stm, 1);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, rtStreamAbort_02) {
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
TEST_F(ApiTest, rtStreamAbort_00) {
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

TEST_F(ApiTest, rtsStreamStop) {
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

TEST_F(ApiTest, rtsSetTaskFailCallback_001)
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

TEST_F(ApiTest, rtsSetTaskFailCallback_002)
{
    rtError_t error;

    error = rtsSetTaskFailCallback("_DEFAULT_MODEL_NAME_", &stubRtsTaskFailCallback, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsSetTaskFailCallback("_DEFAULT_MODEL_NAME_", nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, rtsSetTaskFailCallback_003)
{
    rtError_t error;
    char *regName ="lltruntime-fake";
    error = rtsSetTaskFailCallbackFake(regName, &stubRtsTaskFailCallback, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest, rtsSetDeviceTaskAbortCallback_001)
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

TEST_F(ApiTest, rtsSetDeviceTaskAbortCallback_003)
{
    rtError_t error;
	char *regName ="HCCL-fake";
    error = rtsSetDeviceTaskAbortCallbackFake(regName, &stubRtsDeviceTaskAbortCallback, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest, rtsSetDeviceTaskAbortCallback_004)
{
    rtError_t error;
    char *regName ="task-abort";
    error = rtsSetDeviceTaskAbortCallback(regName, &stubRtsDeviceTaskAbortCallback, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtInstance->TaskAbortCallBack(0, RT_DEVICE_ABORT_PRE, 1000);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, rtsSetDefaultDeviceId_01)
{
    rtError_t error = RT_ERROR_NONE;
    error = rtsSetDefaultDeviceId(0xFFFFFFFF);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_EQ(rtInstance->defaultDeviceId_, 0xFFFFFFFF);
    EXPECT_EQ(rtInstance->hasSetDefaultDevId_, false);
}


TEST_F(ApiTest, rtsRegStreamStateCallback_001)
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

TEST_F(ApiTest, rtsRegStreamStateCallback_002)
{
    rtError_t error = rtsRegStreamStateCallback("lltruntime", nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, rtsRegStreamStateCallback_003)
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

TEST_F(ApiTest, rtsRegStreamStateCallback_004)
{
    rtError_t error;
    char *regName ="streamstate-fake";
    error = rtsRegStreamStateCallbackFake(regName, &stubRtsStreamStateCallback, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}


TEST_F(ApiTest, rtsRegDeviceStateCallback_001)
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

TEST_F(ApiTest, rtsRegDeviceStateCallback_002)
{
    rtError_t error;
	char *regName ="devstate-fake";
    error = rtsRegDeviceStateCallbackFake(regName, &stubRtsDeviceStateCallback, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest, rtsRegDeviceStateCallback_003)
{
    ResetAllDeviceStateV2();
    DeviceStateCallbackManager::Instance().Notify(0, false, DEV_CB_POS_BACK, RT_DEVICE_STATE_RESET_POST);
    DeviceStateCallbackManager::Instance().Notify(1, true, DEV_CB_POS_BACK, RT_DEVICE_STATE_SET_POST);
    EXPECT_EQ(g_rtsDeviceStateCallback[0], RT_DEVICE_STATE_RESET_POST);
    EXPECT_EQ(g_rtsDeviceStateCallback[1], RT_DEVICE_STATE_SET_POST);
}

TEST_F(ApiTest, rtsProfTrace_005)
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


TEST_F(ApiTest, rtsProfTrace_006)
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

TEST_F(ApiTest, rtsProfTrace_007)
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

TEST_F(ApiTest, rtsPersistentTaskClean_001)
{
    rtError_t error = RT_ERROR_NONE;
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtChipType_t originType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DAVID);
    GlobalContainer::SetRtChipType(CHIP_DAVID);
    uint32_t devId = 0U;
    RawDevice *device = new RawDevice(0);
    device->Init();
    Stream *stm = new Stream(device, 0);

    stm->SetBindFlag(true);
    error = rtsPersistentTaskClean(stm);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);
    rtInstance->SetChipType(originType);
    GlobalContainer::SetRtChipType(originType);

    delete stm;
    delete device;
}


TEST_F(ApiTest, rtsMemReserveAddress)
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

TEST_F(ApiTest, rtsMemReserveAddress_01)
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

TEST_F(ApiTest, rtsMemReserveAddress_02)
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

TEST_F(ApiTest, rtsMemReserveAddress_03)
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

TEST_F(ApiTest, rtsMemMap)
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

TEST_F(ApiTest, rtsMemMap_01)
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

TEST_F(ApiTest, rtsMemMap_02)
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

TEST_F(ApiTest, rtsMemMallocPhysical)
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

TEST_F(ApiTest, rtsMemMallocPhysical_01)
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

TEST_F(ApiTest, rtsMemMallocPhysical_02)
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

TEST_F(ApiTest, rtsMemMallocPhysical_03)
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

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t originType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);

    rtMemHandle handVal;
    rtMemHandle* handle = &handVal;

    error = rtsMemMallocPhysical(handle, 100, policy, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = rtsMemMallocPhysical(handle, 100, policy, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsMemFreePhysical(handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtInstance->SetChipType(originType);
    GlobalContainer::SetRtChipType(originType);
}

TEST_F(ApiTest, rtsMemMallocPhysical_04)
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

TEST_F(ApiTest, rtsMemMallocPhysical_05)
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
TEST_F(ApiTest, rtsMalloc_01)
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

TEST_F(ApiTest, rtsMalloc_02)
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

TEST_F(ApiTest, rtsMalloc_03)
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
    for (uint32_t i = 0; i < 6; ++i) {
        error = rtsMalloc(&devPtr, 60, static_cast<rtMallocPolicy>(i), RT_MEM_ADVISE_NONE, &cfg);
        if (i < 3) {
            EXPECT_EQ(error, RT_ERROR_NONE);
            error = rtsFree(devPtr);
            EXPECT_EQ(error, RT_ERROR_NONE);
        } else { // device memory do not support p2p memory
            EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
        }
    }
}

TEST_F(ApiTest, rtsMalloc_04)
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

TEST_F(ApiTest, rtsMalloc_05)
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

TEST_F(ApiTest, rtsMalloc_06)
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

TEST_F(ApiTest, rtsMalloc_07)
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
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t ori_chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_LHISI);
    GlobalContainer::SetRtChipType(CHIP_LHISI);
    error = rtsMalloc(&devPtr, 60, RT_MEM_MALLOC_HUGE_FIRST, RT_MEM_ADVISE_CACHED, &cfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(ori_chipType);
    GlobalContainer::SetRtChipType(ori_chipType);
}

TEST_F(ApiTest, label_api)
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

TEST_F(ApiTest, kernel_launch)
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

TEST_F(ApiTest, kernel_launch_cloud)
{
    rtError_t error;
    void *args[] = {&error, NULL};

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    rtChipType_t chipType = rtInstance->GetChipType();

    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);

    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}


TEST_F(ApiTest, kernel_launch_fusion_not_mini)
{
    rtError_t error;
    void *args[] = {&error, NULL};

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    rtChipType_t chipType =rtInstance->GetChipType();

    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);

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

    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}

//changed
TEST_F(ApiTest, kernel_launch_l2_preload_mem_unaligned)
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


TEST_F(ApiTest, kernel_trans_arg)
{
    rtError_t error;
    void *arg = NULL;

    error = rtKernelConfigTransArg(NULL, 128, 0, &arg);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtKernelConfigTransArg(&error, 128, 0, &arg);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(ApiTest, kernel_trans_arg_cmodel)
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


TEST_F(ApiTest, kernel_launch_with_default_stream)
{
    rtError_t error;
    void *args[] = {&error, NULL};

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(ApiTest, host_mem_alloc_free)
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


TEST_F(ApiTest, host_mem_alloc_free_02)
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


TEST_F(ApiTest, host_mem_alloc_free_03)
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

    error = rtsFreeHost(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete[] mallocAttrs;
    free(malloCfg);
}


TEST_F(ApiTest, host_mem_alloc_free_04)
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


TEST_F(ApiTest, host_mem_alloc_free_05)
{
    rtError_t error;
    void * hostPtr;
    rtMallocConfig_t *malloCfg = (rtMallocConfig_t *)malloc(sizeof(rtMallocConfig_t));
    rtMallocAttribute_t* mallocAttrs = nullptr;
    malloCfg->numAttrs = 1;
    malloCfg->attrs = mallocAttrs;
    error = rtsMallocHost(&hostPtr, 30, malloCfg);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsFreeHost(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    free(malloCfg);
}


TEST_F(ApiTest, host_mem_alloc_free_apiDec)
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


TEST_F(ApiTest, memory_attritue_fail)
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


TEST_F(ApiTest, memory_attritue_1)
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

TEST_F(ApiTest, memory_attritue_apiDec)
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

TEST_F(ApiTest, memcpy_host_to_device_00)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    size_t free;
    size_t total;
    rtMemInfo_t memInfo;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);

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


TEST_F(ApiTest, memcpy_host_to_device_auto)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    size_t free;
    size_t total;
    rtMemInfo_t memInfo;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);

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



TEST_F(ApiTest, memcpyasyncex_host_to_device)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();

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


TEST_F(ApiTest, memcpy_host_to_device_01)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    size_t free;
    size_t total;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);

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


TEST_F(ApiTest, memcpy_async_host_to_device)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();

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

    rtInstance->SetChipType(CHIP_MINI_V3);
    GlobalContainer::SetRtChipType(CHIP_MINI_V3);
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
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}


TEST_F(ApiTest, memcpy_async_qos)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();

    error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // RTS_MEMCPYASYNC_QOS_CONFIG_01, set qos null
    rtTaskCfgInfo_t *taskCfgInfoPtr = nullptr;

    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = rtMemcpyAsyncWithCfgV2(devPtr, 64, hostPtr, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, taskCfgInfoPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // RTS_MEMCPYASYNC_QOS_CONFIG_02, config qos, but not config flag
    rtTaskCfgInfo_t taskCfgInfo = {};
    taskCfgInfo.qos = 2;
    taskCfgInfo.partId = 2;

    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    error = rtMemcpyAsyncWithCfgV2(devPtr, 64, hostPtr, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, &taskCfgInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtTaskCfgInfo_t taskCfgInfo1 = {};

    // RTS_MEMCPYASYNC_QOS_CONFIG_04, not config qos, config flag = 0
    taskCfgInfo1.d2dCrossFlag = 0;

    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = rtMemcpyAsyncWithCfgV2(devPtr, 64, hostPtr, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, &taskCfgInfo1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // RTS_MEMCPYASYNC_QOS_CONFIG_05, config qos, config flag = 0
    taskCfgInfo1.qos = 3;
    taskCfgInfo1.partId = 3;

    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
    error = rtMemcpyAsyncWithCfgV2(devPtr, 64, hostPtr, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, &taskCfgInfo1);
    EXPECT_EQ(error, RT_ERROR_NONE);


    // RTS_MEMCPYASYNC_QOS_CONFIG_08, config invalid flag
    taskCfgInfo1.qos = 5;
    taskCfgInfo1.partId = 5;

    // RTS_MEMCPYASYNC_QOS_CONFIG_09, config copy type != D2D
    taskCfgInfo1.d2dCrossFlag = 1;


    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
    error = rtMemcpyAsyncWithCfgV2(devPtr, 64, hostPtr, 64, RT_MEMCPY_DEVICE_TO_DEVICE, stream_, &taskCfgInfo1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}

TEST_F(ApiTest, memcpy_async_d2d_not_stars)
{
    rtError_t error;
    void *srcPtr;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    error = rtMalloc(&srcPtr, 64, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyAsyncPtr(srcPtr, 64, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(srcPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(ApiTest, memcpy_async_d2d_invalid_size)
{
    rtError_t error;
    void *srcPtr;
    void *dstPtr;
    uint64_t invalidSize = MAX_MEMCPY_SIZE_OF_D2D + 1;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    error = rtMalloc(&srcPtr, 64, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&dstPtr, 64, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyAsyncPtr(dstPtr, invalidSize, invalidSize, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, NULL, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);  // invalid size

    rtInstance->SetChipType(CHIP_MINI_V3);
    GlobalContainer::SetRtChipType(CHIP_MINI_V3);
    error = rtMemcpyAsyncPtr(dstPtr, invalidSize, invalidSize, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, NULL, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);  // invalid size

    error = rtFree(srcPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(dstPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(ApiTest, memcpy_async_ptr_qos)
{
    rtError_t error;
    void *srcPtr;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    error = rtMalloc(&srcPtr, 64, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // RTS_MEMCPYASYNCPTR_QOS_CONFIG_02
    rtTaskCfgInfo_t taskCfgInfo = {};
    taskCfgInfo.qos = 1;
    taskCfgInfo.partId = 1;

    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = rtMemcpyAsyncPtrV2(srcPtr, 64, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, &taskCfgInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // RTS_MEMCPYASYNCPTR_QOS_CONFIG_03
    rtTaskCfgInfo_t taskCfgInfo1 = {};
    taskCfgInfo1.d2dCrossFlag = 0;

    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
    error = rtMemcpyAsyncPtrV2(srcPtr, 64, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, &taskCfgInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // RTS_MEMCPYASYNCPTR_QOS_CONFIG_04
    taskCfgInfo1.d2dCrossFlag = 1;

    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    error = rtMemcpyAsyncPtrV2(srcPtr, 64, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, &taskCfgInfo1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // RTS_MEMCPYASYNCPTR_QOS_CONFIG_05
    taskCfgInfo1.qos = 3;
    taskCfgInfo.partId = 3;
    taskCfgInfo1.d2dCrossFlag = 0;

    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
    error = rtMemcpyAsyncPtrV2(srcPtr, 64, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, &taskCfgInfo1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // RTS_MEMCPYASYNCPTR_QOS_CONFIG_06
    taskCfgInfo1.d2dCrossFlag = 1;
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
    error = rtMemcpyAsyncPtrV2(srcPtr, 64, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, &taskCfgInfo1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // RTS_MEMCPYASYNCPTR_QOS_CONFIG_08
    taskCfgInfo1.qos = 5;
    taskCfgInfo1.d2dCrossFlag = 10;
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = rtMemcpyAsyncPtrV2(srcPtr, 64, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, stream_, &taskCfgInfo1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // RTS_MEMCPYASYNCPTR_QOS_CONFIG_09
    taskCfgInfo1.d2dCrossFlag = 1;
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = rtMemcpyAsyncPtrV2(srcPtr, 64, 64, RT_MEMCPY_HOST_TO_DEVICE_EX, stream_, &taskCfgInfo1);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    error = rtFree(srcPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}




TEST_F(ApiTest, memcpy_async_host_to_device_64M)
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


TEST_F(ApiTest, memcpy_async_host_to_device_64M_error)
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


TEST_F(ApiTest, memcpy_async_host_to_device_64M_auto)
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


TEST_F(ApiTest, memcpy_async_host_to_device_64M_error2)
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


TEST_F(ApiTest, memcpy_async_coverage)
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
TEST_F(ApiTest, memcpy_asyncPtr_coverage)
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


TEST_F(ApiTest, memcpy_coverage)
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
TEST_F(ApiTest, managed_mem)
{
    rtError_t error;
    void *ptr = NULL;

    error = rtMemAllocManaged(&ptr, 128, 0, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemFreeManaged(ptr);

    error = rtMemAllocManaged(&ptr, 128, RT_MEMORY_DDR_NC, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemFreeManaged(ptr);
}

TEST_F(ApiTest, kernelinfo_callback)
{
    rtError_t error;
    rtKernelReportCallback callBack = (rtKernelReportCallback)0x6000;

    error = rtSetKernelReportCallback((rtKernelReportCallback)NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
//changed
TEST_F(ApiTest, LAUNCH_KERNEL_TEST_1)
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

TEST_F(ApiTest, LAUNCH_KERNEL_TEST_2)
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
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamSynchronize(stream_);
    (const_cast<TaskFactory *>(stubDevice->GetTaskFactory()))->Recycle(pctraceTask);
    delete pctraceHandle;
    delete stubDevice;
}

TEST_F(ApiTest, LAUNCH_KERNEL_TEST_3)
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

TEST_F(ApiTest, LAUNCH_KERNEL_TEST_4)
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
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamSynchronize(stream_);
    (const_cast<TaskFactory *>(stubDevice->GetTaskFactory()))->Recycle(pctraceTask);
    delete pctraceHandle;
    delete stubDevice;
}

TEST_F(ApiTest, LAUNCH_ALL_KERNEL_TEST_1)
{
    rtError_t error;
    void *m_handle;
    Program *m_prog;
    rtDevBinary_t master_bin;
    master_bin.magic = RT_DEV_BINARY_MAGIC_ELF;
    master_bin.version = 2;
    master_bin.data = (void*)elf_o;
    master_bin.length = elf_o_len;

    error = rtRegisterAllKernel(&master_bin, &m_handle);
    error = rtSetExceptionExtInfo(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    rtArgsSizeInfo_t argsSizeInfo;
    argsSizeInfo.infoAddr = (void *)0x12345678;
    argsSizeInfo.atomicIndex = 0x87654321;
    error = rtSetExceptionExtInfo(&argsSizeInfo);

    EXPECT_EQ(error, RT_ERROR_NONE);
    uint64_t arg = 0x1234567890;
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    error = rtKernelLaunchWithHandle(m_handle, 355, 1, &argsInfo, NULL, NULL, "info");

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDevBinaryUnRegister(m_handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, AI_CPU_KERNEL_LAUNCH_TEST)
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

TEST_F(ApiTest, LAUNCH_KERNEL_WITH_HANDLE_NO_TILINGKEY_01)
{
    size_t MAX_LENGTH = 75776;
    FILE *master = NULL;
    master = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o", "rb");
    if (NULL == master)
    {
        printf ("master open error\n");
        return;
    }

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

    error = rtRegisterAllKernel(&master_bin, &m_handle);
    error = rtSetExceptionExtInfo(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    rtArgsSizeInfo_t argsSizeInfo;
    argsSizeInfo.infoAddr = (void *)0x12345678;
    argsSizeInfo.atomicIndex = 0x87654321;
    error = rtSetExceptionExtInfo(&argsSizeInfo);

    EXPECT_EQ(error, RT_ERROR_NONE);
    uint64_t arg = 0x1234567890;
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    error = rtKernelLaunchWithHandle(m_handle, DEFAULT_TILING_KEY, 1, &argsInfo, NULL, NULL, "info");

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDevBinaryUnRegister(m_handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(ApiTest, LAUNCH_KERNEL_WITH_HANDLE_NO_TILINGKEY_02)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);

    size_t MAX_LENGTH = 75776;
    FILE *master = NULL;
    master = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o", "rb");
    if (NULL == master)
    {
        printf ("master open error\n");
        return;
    }

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

    error = rtRegisterAllKernel(&master_bin, &m_handle);
    error = rtSetExceptionExtInfo(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    rtArgsSizeInfo_t argsSizeInfo;
    argsSizeInfo.infoAddr = (void *)0x12345678;
    argsSizeInfo.atomicIndex = 0x87654321;
    error = rtSetExceptionExtInfo(&argsSizeInfo);

    EXPECT_EQ(error, RT_ERROR_NONE);
    uint64_t arg = 0x1234567890;
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    error = rtKernelLaunchWithHandle(m_handle, DEFAULT_TILING_KEY, 1, &argsInfo, NULL, NULL, "info");

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDevBinaryUnRegister(m_handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}


TEST_F(ApiTest, LAUNCH_ALL_KERNEL_TEST_3)
{
    size_t MAX_LENGTH = 75776;
    FILE *master = NULL;
    master = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o", "rb");
    if (NULL == master)
    {
        printf ("master open error\n");
        return;
    }

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

    error = rtRegisterAllKernel(&master_bin, &m_handle);

    uint64_t arg = 0x1234567890;
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);

    rtTaskCfgInfo_t taskCfgInfo = {};
    taskCfgInfo.qos = 1;
    taskCfgInfo.partId = 1;
    error = rtKernelLaunchWithHandleV2(m_handle, 355, 1, &argsInfo, NULL, NULL, &taskCfgInfo);

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDevBinaryUnRegister(m_handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(ApiTest, LAUNCH_ALL_KERNEL_TEST_4)
{
    rtError_t error;
    void *m_handle;
    Program *m_prog;
    rtDevBinary_t master_bin;
    master_bin.magic = RT_DEV_BINARY_MAGIC_ELF;
    master_bin.version = 2;
    master_bin.data = (void*)elf_o;
    master_bin.length = elf_o_len;

    error = rtRegisterAllKernel(&master_bin, &m_handle);

    uint64_t arg = 0x1234567890;
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);

    rtTaskCfgInfo_t taskCfgInfo = {};
    taskCfgInfo.qos = 1;
    taskCfgInfo.partId = 1;
    LaunchArgment &launchArg = ThreadLocalContainer::GetLaunchArg();
    launchArg.argCount = 0U;
    error = rtVectorCoreKernelLaunchWithHandle(m_handle, 355, 1, &argsInfo, NULL, NULL, &taskCfgInfo);

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDevBinaryUnRegister(m_handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, memcpy_async_host_to_device_ex)
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


TEST_F(ApiTest, kernel_launch_1)
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


TEST_F(ApiTest, kernel_config_dump)
{
    rtError_t error;
    void *dumpBaseVAddr = NULL;
    NpuDriver drv;

    error = rtKernelConfigDump(RT_DATA_DUMP_KIND_DUMP, 0,  3, &dumpBaseVAddr, ApiTest::stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}


TEST_F(ApiTest, kernel_config_dump_host_malloc_fail)
{
    rtError_t error;
    void *dumpBaseVAddr = NULL;
    NpuDriver drv;

    error = rtKernelConfigDump(RT_DATA_DUMP_KIND_DUMP, 0,  3, &dumpBaseVAddr, ApiTest::stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtKernelConfigDump(RT_DATA_DUMP_KIND_DUMP, 100,  0, &dumpBaseVAddr, ApiTest::stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtKernelConfigDump(RT_DATA_DUMP_KIND_DUMP, 100, 3, &dumpBaseVAddr, ApiTest::stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtKernelConfigDump(RT_DATA_DUMP_KIND_DUMP, 100, 3, &dumpBaseVAddr, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    MOCKER_CPP_VIRTUAL(drv,&NpuDriver::HostMemAlloc)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));
    error = rtKernelConfigDump(RT_DATA_DUMP_KIND_DUMP, 100, 3, &dumpBaseVAddr, ApiTest::stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}


TEST_F(ApiTest, kernel_launch_with_dump)
{
    rtError_t error;
    void *dumpBaseVAddr = NULL;
    void *args[] = {&error, NULL};

    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(NULL));

    error = rtKernelConfigDump(RT_DATA_DUMP_KIND_DUMP, 100, 3, &dumpBaseVAddr, ApiTest::stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::reset();
}


TEST_F(ApiTest, kernel_launch_with_dump_error)
{
    rtError_t error;
    void *dumpBaseVAddr = NULL;
    void *args[] = {&error, NULL};

    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(NULL));

    error = rtKernelConfigDump(RT_DATA_DUMP_KIND_DUMP, 100, 3, &dumpBaseVAddr, ApiTest::stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    MOCKER_CPP(&Context::GetModule).stubs().will(returnValue((Module *)NULL));

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::reset();
}

TEST_F(ApiTest, ipc_set_notify_pid2)
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

TEST_F(ApiTest, kernel_launch_set_kernel_task_id)
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

TEST_F(ApiTest, label_create_error)
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


TEST_F(ApiTest, label_destroy_error)
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


TEST_F(ApiTest, label_task_api_error)
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


TEST_F(ApiTest, GetDevicePhyIdByIndex)
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

TEST_F(ApiTest, GetDeviceIndexByPhyId)
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

TEST_F(ApiTest, kernel_launch_with_onlineprof2)
{
    rtError_t error;
    ProfilefDataInfo ProfilefData_t = {0};
    void *args[] = {&error, NULL};

    MOCKER(halMemAlloc)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtStartOnlineProf(stream_, 1);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetOnlineProfData(stream_, &ProfilefData_t, 1);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStopOnlineProf(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(ApiTest, kernel_launch_with_onlineprof_dulstart)
{
    rtError_t error;
    ProfilefDataInfo ProfilefData_t = {0};
    void *args[] = {&error, NULL};

    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(NULL));
    error = rtStartOnlineProf(stream_, 1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStartOnlineProf(stream_, 1);
    EXPECT_NE(error, ACL_RT_SUCCESS);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtGetOnlineProfData(stream_, &ProfilefData_t, 1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStopOnlineProf(stream_);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}


TEST_F(ApiTest, kernel_launch_ex_dump)
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


TEST_F(ApiTest, GetOpTimeOut_set)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtSocType_t socType = rtInstance->GetSocType();

    rtInstance->SetSocType(SOC_ASCEND910B4_1);
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

    rtInstance->SetSocType(socType);
}

TEST_F(ApiTest, GetDeviceCapModelUpdate)
{
    rtError_t error;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int32_t value = 0;

    error = rtGetDeviceCapability(0, RT_MODULE_TYPE_TSCPU, FEATURE_TYPE_MODEL_TASK_UPDATE, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(value, RT_DEV_CAP_NOT_SUPPORT);
}


TEST_F(ApiTest, GetDeviceCapModelUpdate_StubDev)
{
    rtError_t error;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int32_t value = 0;

    error = rtGetDeviceCapability(64, RT_MODULE_TYPE_TSCPU, FEATURE_TYPE_MODEL_TASK_UPDATE, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(value, RT_DEV_CAP_NOT_SUPPORT);
}


TEST_F(ApiTest, ADCProfiler)
{
    rtError_t error;
    void *addr;
    uint32_t length = 256 * 1024;

    error = rtStartADCProfiler(&addr, length);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtStopADCProfiler(addr);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
//changed
TEST_F(ApiTest, memcpy_async_device_to_host_1911)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_MINI_V3);
    GlobalContainer::SetRtChipType(CHIP_MINI_V3);

    void *hostPtr;
    void *devPtr;

    rtError_t error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);//RT_MEMORY_TYPE_HOST
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);//RT_MEMORY_TYPE_DEVICE
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream *stream = static_cast<Stream *>(stream_);
    error = rtMemcpyAsync(devPtr, 64, hostPtr, 64, RT_MEMCPY_DEVICE_TO_HOST_EX, stream_);
    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
}

TEST_F(ApiTest, memcpy2d_host_to_device_00)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    size_t free;
    size_t total;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);

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

TEST_F(ApiTest, memcpy2d_host_to_device_01)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    size_t free;
    size_t total;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);

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


TEST_F(ApiTest, memcpy2d_host_to_device_02)
{
    rtError_t error;
    error = rtsMemcpy2D(NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

//changed
TEST_F(ApiTest, memcpy2d_host_to_device_auto)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    size_t free;
    size_t total;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);

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


TEST_F(ApiTest, memcpy2d_async_success_coverage)
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

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = errApi.MemCopy2DAsync(devPtr, 100, hostPtr, 100, 10, 1, NULL, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(ApiTest, memcpy2d_async_success_d2d)
{
    void *destPtr;
    void *srcPtr;
    rtError_t error = RT_ERROR_NONE; 
    ApiImpl impl;

    rtStream_t stm;
    error = rtStreamCreate(&stm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream * const exeStream = static_cast<Stream *>(stm);

    uint64_t size = 10;
    uint64_t* realSize = &size;
    MOCKER_CPP(&Context::MemCopy2DAsync)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(),
         mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), 
         outBoundP(realSize), mockcpp::any(), mockcpp::any())
         .will(returnValue(RT_ERROR_NONE));
    error = impl.MemCopy2DAsync(destPtr, 150, srcPtr, 150, 10, 2, exeStream, RT_MEMCPY_DEVICE_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stm);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, memcpy2d_async_host_to_device_cloud_device2host)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);

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


TEST_F(ApiTest, memcpy2d_async_host_to_device_cloud_device2host_01)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);

    error = rtMallocHost(&hostPtr, 100, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 100, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtMemcpy2DParams_t para;
    para.dst = hostPtr;
    para.dstPitch = 100;
    para.src = devPtr;
    para.srcPitch = 100;
    para.height = 10;
    para.width = 1;
    para.kind = RT_MEMCPY_KIND_DEVICE_TO_HOST;

    Api *api = Api::Instance();
    MOCKER_CPP_VIRTUAL(api, &Api::MemCopy2DAsync).stubs().will(returnValue(RT_ERROR_NONE));
    error = rtsMemcpy2DAsync(&para, NULL, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(ApiTest, memcpy2d_host_to_device_fail)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;
    size_t free;
    size_t total;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);

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


TEST_F(ApiTest, memcpy2d_async_param_fail)
{
    rtError_t error;
    error = rtsMemcpy2DAsync(NULL, NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest, ipc_memory_ex)
{
    rtError_t error;
    void *ptr1 = NULL;
    void *ptr2 = (void *)0x20000;
    void *ptr3 = (void *)0x10000;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t originType = Runtime::Instance()->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
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

    rtInstance->SetChipType(originType);
    GlobalContainer::SetRtChipType(originType);
    delete rawDrv;
}


TEST_F(ApiTest, GetDevArgsAddrForError)
{
    rtStream_t stm;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t originType = rtInstance->GetChipType();

    rtError_t error = rtStreamCreate(&stm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t arg = 0x1234567890;
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    void *devArgsAddr = nullptr, *argsHandle = nullptr;
    error = rtGetDevArgsAddr(stm, &argsInfo, &devArgsAddr, &argsHandle);
    rtInstance->SetChipType(originType);
    GlobalContainer::SetRtChipType(originType);
}


TEST_F(ApiTest, hdc_server_create)
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


TEST_F(ApiTest, hdc_server_destroy)
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


TEST_F(ApiTest, hdc_session_connect)
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


TEST_F(ApiTest, hdc_session_close)
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


TEST_F(ApiTest, mem_wait_record_task_02)
{
    rtError_t error;
    rtStream_t stream;
    void * devPtr;
 
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
 
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
 
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
 
    error = rtMalloc(&devPtr, 60, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtsValueWrite(devPtr, 0, 0, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
 
    error = rtsValueWait(devPtr, 0, 0, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    Stream *stream_var = static_cast<Stream *>(stream);
    stream_var->pendingNum_.Set(0);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}

TEST_F(ApiTest, host_register_test)
{
    rtError_t error;
    int ptr = 10;
    void *devPtr = nullptr;

    ApiImpl apiImpl;
    ApiDecorator apiDecorator(&apiImpl);
    error = apiDecorator.HostRegister(&ptr, 100, RT_HOST_REGISTER_MAPPED, &devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(ApiTest, memcpy_batch)
{
    rtError_t error;
    size_t failIdx;
    error = rtsMemcpyBatch(nullptr, nullptr, nullptr, 0, nullptr, nullptr, 0, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}


TEST_F(ApiTest, memcpy_batch_async)
{
    rtError_t error;
    size_t failIdx;
    error = rtsMemcpyBatchAsync(nullptr, nullptr,  nullptr, nullptr, 0, nullptr, nullptr, 0, &failIdx, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}


TEST_F(ApiTest, ipc_set_notify_pid3)
{
    rtNotify_t notify = nullptr;
    rtError_t error;
    int32_t pid[]={1};
    int num = 1;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DAVID);
    GlobalContainer::SetRtChipType(CHIP_DAVID);
    error = rtsNotifySetImportPid(notify, pid,num);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}

TEST_F(ApiTest, rts_ipc_open_with_flag_succ)
{
    ApiImpl apiImpl;
    rtError_t error;
    uint32_t phyDevId;
    uint32_t tsId;
    uint32_t notifyId;
    rtNotifyPhyInfo notifyInfo;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
 
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::IpcOpenNotify).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetNotifyPhyInfo).stubs().will(invoke(GetNotifyPhyInfoStub));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::NotifyDestroy).stubs().will(returnValue(RT_ERROR_NONE));
 
    rtNotify_t notify2 = new (std::nothrow) Notify(0, 0);
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
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
 
TEST_F(ApiTest, rtMallocPysical)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtDrvMemHandle handVal;
    rtDrvMemProp_t prop = {};
    prop.mem_type = 1;
    prop.pg_type = 2;
    rtDrvMemHandle *handle = &handVal;
 
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    rtInstance->SetIsSupport1GHugePage(false);
    error = rtMallocPhysical(handle, 0, &prop, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
 
TEST_F(ApiTest, rts_memset_sync)
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
 
TEST_F(ApiTest, rts_memset_async)
{
    rtError_t error;
    void *devPtr;
    void *tmp_devPtr = (void *)0x10000000;
 
    error = rtsMemsetAsync(NULL, 60, 0, 60, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    rtMallocConfig_t *p = nullptr;
    error = rtsMalloc(&devPtr, 60, RT_MEM_MALLOC_HUGE_FIRST, RT_MEM_ADVISE_NONE, p);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtsMemsetAsync(devPtr, 60, 0, 60, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtsFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest, rtsLabelSwitchListCreate)
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
 
TEST_F(ApiTest, rtsLabelSwitchByIndex)
{
    typedef void *rtAddr_t;
    typedef struct {
        uint32_t *hostAddr = nullptr;
        uint32_t *devAddr = nullptr;
    } memUnit;
 
    Api *oldApi_ = const_cast<Api *>(Runtime::runtime_->api_);
    Profiler *profiler = new Profiler(oldApi_);
    profiler->Init();
 
    rtStream_t streamExe;
    rtStream_t stream[2];
    rtError_t error = rtStreamCreate(&streamExe, 0);
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
    ;
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
    ;
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtModelLoadComplete(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelExecute(model, streamExe, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
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
 
TEST_F(ApiTest, rtSetProfDirEx)
{
    rtError_t error = rtSetProfDirEx(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
 
TEST_F(ApiTest, rtSetMsprofReporterCallback)
{
    rtError_t ret;
    ret = rtSetMsprofReporterCallback(msprofreportcallback);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
}
 
TEST_F(ApiTest, rtSetDeviceSatMode)
{
    rtError_t ret;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
 
    ret = rtSetDeviceSatMode(RT_OVERFLOW_MODE_SATURATION);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
 
    ret = rtSetDeviceSatMode(RT_OVERFLOW_MODE_INFNAN);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
 
TEST_F(ApiTest, rtsGetInterCoreSyncAddr)
{
    rtError_t error;
    uint64_t addr;
    uint32_t len;
    error = rtsGetInterCoreSyncAddr(&addr, &len);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest, rtsGetHardwareSyncAddr)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtError_t error;
    void *addr = nullptr;
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = rtsGetHardwareSyncAddr(&addr);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
 
TEST_F(ApiTest, rtGetC2cCtrlAddr)
{
    rtError_t error;
    uint64_t addr;
    uint32_t len;
    error = rtGetC2cCtrlAddr(&addr, &len);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest, rtGetC2cCtrlAddr_david)
{
    rtError_t error;
    uint64_t addr;
    uint32_t len;
 
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DAVID);
    GlobalContainer::SetRtChipType(CHIP_DAVID);
 
    error = rtGetC2cCtrlAddr(&addr, &len);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
}
 
TEST_F(ApiTest, rtLabelSwitchByIndex)
{
    typedef void *rtAddr_t;
    typedef struct {
        uint32_t *hostAddr = nullptr;
        uint32_t *devAddr = nullptr;
    } memUnit;
 
    Api *oldApi_ = const_cast<Api *>(Runtime::runtime_->api_);
    Profiler *profiler = new Profiler(oldApi_);
    profiler->Init();
 
    rtStream_t streamExe;
    rtStream_t stream[2];
    rtError_t error = rtStreamCreate(&streamExe, 0);
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
    ;
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtModelLoadComplete(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelExecute(model, streamExe, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
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
 
TEST_F(ApiTest, rtQueryDevPid)
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
 
TEST_F(ApiTest, rtMbufInit)
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
 
TEST_F(ApiTest, rtMbufAlloc)
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
 
TEST_F(ApiTest, rtMbufAllocEx_malloc)
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
 
TEST_F(ApiTest, rtMbufBuild)
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
 
TEST_F(ApiTest, rtMbufUnBuild)
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
 
TEST_F(ApiTest, rtMbufAllocEx_malloc_ex)
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
 
TEST_F(ApiTest, rtMbufFree)
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
 
TEST_F(ApiTest, rtMbufSetDataLen)
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
 
TEST_F(ApiTest, rtMbufGetDataLen)
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
 
TEST_F(ApiTest, rtMbufGetBuffAddr)
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
 
TEST_F(ApiTest, rtMbufGetBuffSize)
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
 
TEST_F(ApiTest, rtMbufGetPrivInfo)
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
 
TEST_F(ApiTest, rtMbufCopyBufRef)
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
 
TEST_F(ApiTest, rtMbufChainAppend)
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
 
TEST_F(ApiTest, rtMbufChainGetMbufNum)
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
 
TEST_F(ApiTest, rtMbufChainGetMbuf)
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
 
TEST_F(ApiTest, rtLabelListCpyV2)
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
    ;
    EXPECT_NE(error, RT_ERROR_NONE);
    error = rtLabelSet(label[1], stream[1]);
    ;
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
 
TEST_F(ApiTest, rtMemQueueInitQS)
{
    char grpName[] = "group_name";
    // normal
    rtError_t error = rtMemQueueInitQS(0, grpName);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest, rtMemQueueInitFlowGw)
{
    rtInitFlowGwInfo_t info = {nullptr, 0};
    // normal
    rtError_t error = rtMemQueueInitFlowGw(0, &info);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest, rtMemQueueCreate)
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
 
TEST_F(ApiTest, rtMemQueueDestroy)
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
 
TEST_F(ApiTest, rtMemQueueInit)
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
 
TEST_F(ApiTest, rtMemQueueEnQueue)
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
 
TEST_F(ApiTest, rtMemQueueDeQueue)
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
 
TEST_F(ApiTest, rtMemQueuePeek)
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
 
TEST_F(ApiTest, rtMemQueueEnQueueBuff)
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

TEST_F(ApiTest, rtMemQueueEnQueueBuff_128)
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
 
TEST_F(ApiTest, rtMemQueueDeQueueBuff)
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
 
TEST_F(ApiTest, rtMemQueueQueryInfo)
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
 
TEST_F(ApiTest, rtMemQueueQuery)
{
    rtMemQueueQueryCmd_t queryCmd = (rtMemQueueQueryCmd_t)QUEUE_QUERY_QUE_ATTR_OF_CUR_PROC;
    EXPECT_EQ(RT_MQ_QUERY_QUE_ATTR_OF_CUR_PROC, queryCmd);
    queryCmd = (rtMemQueueQueryCmd_t)QUEUE_QUERY_QUES_OF_CUR_PROC;
    EXPECT_EQ(RT_MQ_QUERY_QUES_OF_CUR_PROC, queryCmd);

    // normal
    rtMemQueueBuff_t buff = {nullptr};
    rtMemQueueQueryCmd_t cmd = RT_MQ_QUERY_QUE_ATTR_OF_CUR_PROC;
    rtMemQueueShareAttr_t attr = {0};
    uint32_t qid = 0;
    uint32_t outLen = sizeof(attr);
    rtError_t error = rtMemQueueQuery(0, cmd, &qid, sizeof(qid), &attr, &outLen);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtMemQueueQueryCmd_t tmpCmd = RT_MQ_QUERY_QUES_ATTR_ENTITY_TYPE;
    uint32_t tmpOutLen = sizeof(uint32_t);
    uint32_t tmpOutInfo = 0U;
    error = rtMemQueueQuery(0, tmpCmd, &qid, sizeof(qid), &tmpOutInfo, &tmpOutLen);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // invalid paramter
    error = rtMemQueueQuery(0, cmd, nullptr, sizeof(qid), &attr, &outLen);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtMemQueueQuery(0, cmd, &qid, sizeof(qid), nullptr, &outLen);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtMemQueueQuery(0, cmd, &qid, sizeof(qid), &attr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER(halQueueQuery).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemQueueQuery(0, cmd, &qid, sizeof(qid), &attr, &outLen);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest, rtMemQueueAttach)
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
 
TEST_F(ApiTest, rtMemGrpAddProc)
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
 
TEST_F(ApiTest, rtMemGrpAttach)
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
 
TEST_F(ApiTest, rtMemGrpCacheAlloc)
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
 
TEST_F(ApiTest, rtMemQueueSet)
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
 
TEST_F(ApiTest, rtMemGrpCreate)
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
 
TEST_F(ApiTest, rtMemGrpQuery)
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
 
TEST_F(ApiTest, rtMemGrpQuery_addrInfo)
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
 
TEST_F(ApiTest, rtMemGrpQuery_addrInfo_maxGrp)
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
 
TEST_F(ApiTest, rtMemGrpQuery_grpId)
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
 
TEST_F(ApiTest, rtMemQueueGetQidByName)
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
 
TEST_F(ApiTest, rtQueueSubscribe)
{
    int32_t device = 0;
    uint32_t qid = 0;
    uint32_t groupId = 1;
    int type = 2;  //QUEUE_TYPE
 
    MOCKER(NpuDriver::QueueSubscribe).stubs().will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    rtError_t error = rtQueueSubscribe(device, qid, groupId, type);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
 
TEST_F(ApiTest, rtQueueSubF2NFEvent)
{
    int32_t device = 0;
    uint32_t qid = 0;
    uint32_t groupId = 1;
 
    MOCKER(NpuDriver::QueueSubF2NFEvent).stubs().will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    rtError_t error = rtQueueSubF2NFEvent(device, qid, groupId);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
 
TEST_F(ApiTest, rtGetTsMemType)
{
    uint32_t memType = 0U;
    memType = rtGetTsMemType(MEM_REQUEST_FEATURE_DEFAULT, 1024U);
 
    EXPECT_EQ(memType, RT_MEMORY_HBM);
}
 
TEST_F(ApiTest, rtProfilingCommandHandle)
{
    void *data = malloc(8);
    uint32_t len = 8;
 
    rtError_t error = rtProfilingCommandHandle(0, data, len);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    error = rtProfilingCommandHandle(1, data, len);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    free(data);
}
 
TEST_F(ApiTest, rtProfilingCommandHandle_02)
{
    rtProfCommandHandle_t profilerConfig;
    memset_s(&profilerConfig, sizeof(rtProfCommandHandle_t), 0, sizeof(rtProfCommandHandle_t));
    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_START;
    profilerConfig.profSwitch = 1;
    profilerConfig.devNums = 1;
    rtError_t error =
        rtProfilingCommandHandle(PROF_CTRL_SWITCH, (void *)(&profilerConfig), sizeof(rtProfCommandHandle_t));
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest, rtProfilingCommandHandle_03)
{
    rtProfCommandHandle_t profilerConfig;
    memset_s(&profilerConfig, sizeof(rtProfCommandHandle_t), 0, sizeof(rtProfCommandHandle_t));
    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_STOP;
    profilerConfig.profSwitch = 1;
    profilerConfig.devNums = 1;
    rtError_t error =
        rtProfilingCommandHandle(PROF_CTRL_SWITCH, (void *)(&profilerConfig), sizeof(rtProfCommandHandle_t));
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest, rtProfilerInit)
{
    rtError_t error = rtProfilerInit(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
 
TEST_F(ApiTest, rtProfilerConfig)
{
    rtError_t error;
    uint16_t type = 0;
 
    error = rtProfilerConfig(type);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
 
TEST_F(ApiTest, rtsFreeAddress_null)
{
    rtError_t error;
    error = rtsMemFreePhysical(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsMemFreeAddress(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest, rts_st_notify_with_flag_notsupport)
{
    rtNotify_t notify;
    rtError_t error;
    int32_t device_id = 0;
 
    error = rtNotifyCreateWithFlag(device_id, &notify, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtNotifyDestroy(notify);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest, rtLabelGotoEx)
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
 
TEST_F(ApiTest, rtLabelListCpy)
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
 
TEST_F(ApiTest, rtLabelCreateEx)
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
 
TEST_F(ApiTest, rts_read_aicore_mem)
{
    Context *const curCtx = Runtime::Instance()->CurrentContext();
    EXPECT_EQ(curCtx != nullptr, true);
    Device *const dev = curCtx->Device_();
    EXPECT_EQ(dev != nullptr, true);
    MOCKER_CPP_VIRTUAL(dev, &Device::CheckFeatureSupport).stubs().will(returnValue(true));
 
    ApiImpl impl;
    ApiDecorator api(&impl);
    EXPECT_EQ(rtsDebugSetDumpMode(RT_DEBUG_DUMP_ON_EXCEPTION), ACL_RT_SUCCESS);
    EXPECT_EQ(api.DebugSetDumpMode(RT_DEBUG_DUMP_ON_EXCEPTION), ACL_RT_SUCCESS);
 
    rtDbgCoreInfo_t coreInfo = {};
    EXPECT_EQ(rtsDebugGetStalledCore(&coreInfo), ACL_RT_SUCCESS);
    EXPECT_EQ(api.DebugGetStalledCore(&coreInfo), ACL_RT_SUCCESS);
 
    uint8_t data[8192U];
    rtDebugMemoryParam param = {};
    param.debugMemType = RT_DEBUG_MEM_TYPE_L0A;
    param.coreType = RT_CORE_TYPE_AIC;
    param.coreId = 0U;
    param.elementSize = 0U;
    param.srcAddr = 0U;
    param.dstAddr = reinterpret_cast<uint64_t>(&data[0U]);
    param.memLen = 8192U;
    EXPECT_EQ(rtsDebugReadAICore(&param), ACL_RT_SUCCESS);
    param.debugMemType = RT_DEBUG_MEM_TYPE_REGISTER;
    param.elementSize = 8U;
    EXPECT_EQ(rtsDebugReadAICore(&param), ACL_RT_SUCCESS);
}
 
TEST_F(ApiTest, rtGetPriCtxByDeviceId)
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
 
TEST_F(ApiTest, rtGetSocVersion)
{
    GlobalContainer::SetHardwareChipType(CHIP_END);
    rtError_t error;
    char version[50] = {0};
 
    MOCKER(halGetDeviceInfo).stubs().will(invoke(stubHalGetDeviceInfo));
 
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtSocType_t socBak = rtInstance->GetSocType();
 
    error = rtGetSocVersion(nullptr, 50);
    EXPECT_NE(error, RT_ERROR_NONE);
 
    drvStubInit(SOC_ASCEND910A);
    rtInstance->InitSocType();
 
    rtInstance->SetSocType(SOC_ASCEND910A);
    GlobalContainer::SetSocType(SOC_ASCEND910A);
    memset_s(version, 50, 0, 50);
    error = rtGetSocVersion(version, 50);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(strcmp("Ascend910A", version), 0);
 
    rtInstance->SetSocType(SOC_ASCEND610);
    GlobalContainer::SetSocType(SOC_ASCEND610);
    memset_s(version, 50, 0, 50);
    error = rtGetSocVersion(version, 50);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(strcmp("Ascend610", version), 0);
 
    rtInstance->SetSocType(SOC_ASCEND310);
    GlobalContainer::SetSocType(SOC_ASCEND310);
    memset_s(version, 50, 0, 50);
    error = rtGetSocVersion(version, 50);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(strcmp("Ascend310", version), 0);
 
    rtInstance->SetSocType(SOC_ASCEND910B);
    GlobalContainer::SetSocType(SOC_ASCEND910B);
    memset_s(version, 50, 0, 50);
    error = rtGetSocVersion(version, 50);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(strcmp("Ascend910B", version), 0);
 
    rtInstance->SetSocType(SOC_ASCEND910ProA);
    GlobalContainer::SetSocType(SOC_ASCEND910ProA);
    memset_s(version, 50, 0, 50);
    error = rtGetSocVersion(version, 50);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(strcmp("Ascend910ProA", version), 0);
 
    rtInstance->SetSocType(SOC_ASCEND910PremiumA);
    GlobalContainer::SetSocType(SOC_ASCEND910PremiumA);
    memset_s(version, 50, 0, 50);
    error = rtGetSocVersion(version, 50);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(strcmp("Ascend910PremiumA", version), 0);
 
    rtInstance->SetSocType(SOC_ASCEND310P3);
    GlobalContainer::SetSocType(SOC_ASCEND310P3);
    memset_s(version, 50, 0, 50);
    error = rtGetSocVersion(version, 50);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(strcmp("Ascend310P3", version), 0);
 
    rtInstance->SetSocType(SOC_BS9SX1AA);
    GlobalContainer::SetSocType(SOC_BS9SX1AA);
    memset_s(version, 50, 0, 50);
    error = rtGetSocVersion(version, 50);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(strcmp("BS9SX1AA", version), 0);
 
    rtInstance->SetSocType(SOC_BS9SX1AB);
    GlobalContainer::SetSocType(SOC_BS9SX1AB);
    memset_s(version, 50, 0, 50);
    error = rtGetSocVersion(version, 50);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(strcmp("BS9SX1AB", version), 0);
 
    rtInstance->SetSocType(SOC_BS9SX1AC);
    GlobalContainer::SetSocType(SOC_BS9SX1AC);
    memset_s(version, 50, 0, 50);
    error = rtGetSocVersion(version, 50);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(strcmp("BS9SX1AC", version), 0);
 
    rtInstance->SetSocType(SOC_END);
    GlobalContainer::SetSocType(SOC_END);
    memset_s(version, 50, 0, 50);
    error = rtGetSocVersion(version, 50);
    EXPECT_NE(error, RT_ERROR_NONE);
 
    error = rtSetSocVersion("BS9SX1AA");
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtSetSocVersion("BS9SX1AB");
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtSetSocVersion("BS9SX1AC");
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtSetSocVersion("ERROR");
    EXPECT_NE(error, RT_ERROR_NONE);
 
    drvStubInit(SOC_SD3403);
    rtInstance->InitSocType();
 
    drvStubInit(SOC_ASCEND910B1);
    rtInstance->InitSocType();
 
    drvStubInit(SOC_ASCEND910B2);
    rtInstance->InitSocType();
 
    drvStubInit(SOC_ASCEND910B3);
    rtInstance->InitSocType();
 
    drvStubInit(SOC_ASCEND910B4);
    rtInstance->InitSocType();
 
    rtInstance->InitSocTypeFrom910BVersion(PLAT_COMBINE(ARCH_V200, CHIP_910_B_93, 0));
    rtInstance->InitSocTypeFrom910BVersion(PLAT_COMBINE(ARCH_V200, CHIP_910_B_93, 1));
    rtInstance->InitSocTypeFrom910BVersion(PLAT_COMBINE(ARCH_V200, CHIP_910_B_93, 2));
    rtInstance->InitSocTypeFrom910BVersion(PLAT_COMBINE(ARCH_V200, CHIP_910_B_93, 3));
    rtInstance->InitSocTypeFrom910BVersion(PLAT_COMBINE(ARCH_V200, CHIP_910_B_93, 4));
    rtInstance->InitSocTypeFrom910BVersion(PLAT_COMBINE(ARCH_V200, CHIP_910_B_93, 5));
    rtInstance->InitSocTypeFrom910BVersion(PLAT_COMBINE(ARCH_V200, CHIP_910_B_93, 6));
    rtInstance->InitSocTypeFrom910BVersion(PLAT_COMBINE(ARCH_V200, CHIP_910_B_93, 7));
    rtInstance->InitSocTypeFrom910BVersion(PLAT_COMBINE(ARCH_V200, CHIP_910_B_93, 8));
    rtInstance->InitSocTypeFrom910BVersion(PLAT_COMBINE(ARCH_V200, CHIP_910_B_93, 9));
    rtInstance->InitSocTypeFrom910BVersion(PLAT_COMBINE(ARCH_V200, CHIP_910_B_93, 10));
    rtInstance->InitSocTypeFrom910BVersion(PLAT_COMBINE(ARCH_V200, CHIP_910_B_93, 11));
 
    drvStubInit(SOC_ASCEND310B1);
    rtInstance->InitSocType();
    rtInstance->MacroInit(CHIP_MINI_V3);
 
    drvStubInit(SOC_ASCEND310B1);
    rtInstance->InitSocType();
    rtInstance->MacroInit(CHIP_MINI_V3);
 
    drvStubInit(SOC_Hi3796CV300ES);
    rtInstance->InitSocType();
 
    drvStubInit(SOC_ASCEND320T);
    rtInstance->InitSocType();
    rtInstance->MacroInit(CHIP_5612);
 
    // restore soc type
    drvStubInit(socBak);
    rtInstance->InitSocType();
    ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
    GlobalContainer::SetHardwareChipType(CHIP_END);
}
 
TEST_F(ApiTest, rtModelCheckCompatibility_socVersion)
{
    rtError_t error;
    char version[50] = {0};
 
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtArchType_t oriArchType = rtInstance->GetArchType();
    rtSocType_t socBak = rtInstance->GetSocType();
 
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    rtInstance->SetSocType(SOC_ASCEND910B);
    GlobalContainer::SetSocType(SOC_ASCEND910B);
 
    memset_s(version, 50, 0, 50);
    error = rtGetSocVersion(version, 50);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(strcmp("Ascend910B", version), 0);
 
    rtInstance->SetArchType(ARCH_M300);
    // OMSocVersion is null
    error = rtModelCheckCompatibility("", "10");
    EXPECT_EQ(error, RT_ERROR_NONE);
    // OMSocVersion is nullptr
    error = rtModelCheckCompatibility(nullptr, "10");
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    // restore all type
    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    drvStubInit(socBak);
    rtInstance->InitSocType();
    rtInstance->SetArchType(oriArchType);
}
 
TEST_F(ApiTest, rtModelCheckCompatibility_archVersion)
{
    rtError_t error;
 
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtArchType_t oriArchType = rtInstance->GetArchType();
 
    // 只换1-2包
    rtInstance->SetArchType(ARCH_V100);
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = rtModelCheckCompatibility("SOC_ASCEND910", "3");
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    error = rtModelCheckCompatibility("SOC_ASCEND910", "0");
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // restore all type
    rtInstance->SetArchType(oriArchType);
}
 
TEST_F(ApiTest, rtGetPairDevicesInfo)
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
 
TEST_F(ApiTest, rtGetPairPhyDevicesInfo)
{
    rtError_t error;
    int64_t value = 0;
 
    error = rtGetPairPhyDevicesInfo(0, 1, 0, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtGetPairPhyDevicesInfo(0, 1, 0, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}
 
TEST_F(ApiTest, rtLaunchSqeUpdateTask_FEATURE_NOT_SUPPORT)
{
    rtError_t error;
    uint32_t streamId = 1U;
    uint32_t taskId = 1U;
    uint64_t src_addr = 0U;
    uint64_t cnt = 40U;
 
    // not support chiptype
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
 
    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtLaunchSqeUpdateTask(streamId, taskId, reinterpret_cast<void *>(src_addr), cnt, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    Stream *stream_var = static_cast<Stream *>(stream);
    stream_var->pendingNum_.Set(0);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest, rtMemAddress)
{
    rtError_t error = rtReserveMemAddress(nullptr, 0, 0, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    error = rtReleaseMemAddress(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t ori_chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
    rtDrvMemHandle handVal;
    rtDrvMemProp_t prop = {};
    prop.mem_type = 1;
    prop.pg_type = 1;
    rtDrvMemHandle *handle = &handVal;
    error = rtMallocPhysical(handle, 0, &prop, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(ori_chipType);
    GlobalContainer::SetRtChipType(ori_chipType);
 
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
}
 
TEST_F(ApiTest, rtOperateWithHostid)
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
 
TEST_F(ApiTest, rtMemcpyD2DAddrAsync)
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
 
TEST_F(ApiTest, rtLabel_CreateEx)
{
    rtError_t error;
    error = rtLabelCreateEx(NULL, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
 
TEST_F(ApiTest, rtNpuGetFloatDebugStatus)
{
    void *descBuf = malloc(8);  // device memory
    uint64_t descBufLen = 64;
    uint32_t checkmode = 0;
 
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    FeatureToTsVersionInit();
 
    std::vector<uintptr_t> input;
    input.push_back(reinterpret_cast<uintptr_t>(descBuf));
    input.push_back(static_cast<uintptr_t>(descBufLen));
    input.push_back(static_cast<uintptr_t>(checkmode));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));
 
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    rtError_t error = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_NPU_GET_FLOAT_DEBUG_STATUS);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    free(descBuf);
}

TEST_F(ApiTest, rtNpuGetFloatDebugStatus_02)
{
    void *descBuf = malloc(8);  // device memory
    uint64_t descBufLen = 64;
    uint32_t checkmode = 0;
 
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
 
    std::vector<uintptr_t> input;
    input.push_back(reinterpret_cast<uintptr_t>(descBuf));
    input.push_back(static_cast<uintptr_t>(descBufLen));
    input.push_back(static_cast<uintptr_t>(checkmode));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));
    rtError_t error = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_NPU_GET_FLOAT_DEBUG_STATUS);
    EXPECT_EQ(error, RT_ERROR_NONE);
    free(descBuf);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}

TEST_F(ApiTest, rtNpuClearFloatDebugStatus_02)
{
    uint32_t checkmode = 0;
 
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
 
    std::vector<uintptr_t> input;
    input.push_back(static_cast<uintptr_t>(checkmode));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));
    rtError_t error = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_NPU_CLEAR_FLOAT_DEBUG_STATUS);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(ApiTest, rtMemAddress_01)
{
    rtError_t error = rtReserveMemAddress(nullptr, 0, 0, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    error = rtReleaseMemAddress(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t ori_chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
    rtDrvMemHandle handVal;
    rtDrvMemProp_t prop = {};
    prop.mem_type = 1;
    prop.pg_type = 1;
    rtDrvMemHandle *handle = &handVal;
    error = rtMallocPhysical(handle, 0, &prop, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(ori_chipType);
    GlobalContainer::SetRtChipType(ori_chipType);
 
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
}
 
TEST_F(ApiTest, rtsDvppLaunch_test_01)
{
    rtError_t error;
    void *args[] = {&error, NULL};
    void *stubFunc;
 
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
 
    error = rtLaunchDvppTask(nullptr, 0, stream_, nullptr);
    EXPECT_NE(error, RT_ERROR_INVALID_VALUE);
}
 
TEST_F(ApiTest, rtMultipleTaskInfoLaunchCtrl_aicpuTask)
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
 
TEST_F(ApiTest, rtMultipleTaskInfoLaunchCtrl_dvppTask)
{
    rtTaskDesc_t taskDesc;
    rtMultipleTaskInfo_t multipleTaskInfo = {0};
    multipleTaskInfo.taskNum = 1;
    multipleTaskInfo.taskDesc = &taskDesc;
    memset(multipleTaskInfo.taskDesc, 0, sizeof(rtTaskDesc_t));
 
    void *devPtr;
    rtMalloc(&devPtr, 16, RT_MEMORY_HBM, DEFAULT_MODULEID);
    multipleTaskInfo.taskDesc[0].type = RT_MULTIPLE_TASK_TYPE_DVPP;
    multipleTaskInfo.taskDesc[0].u.dvppTaskDesc.sqe.sqeHeader.type = 14;  // RT_STARS_SQE_TYPE_JPEGD;
    multipleTaskInfo.taskDesc[0].u.dvppTaskDesc.aicpuTaskPos = 1 + 3;     // for dvpp rr, add 3 write value
 
    std::vector<uintptr_t> input;
    input.push_back(reinterpret_cast<uintptr_t>(&multipleTaskInfo));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));
    rtError_t error = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_MULTIPLE_TSK);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtFree(devPtr);
}
 
TEST_F(ApiTest, rtMultipleTaskInfoLaunchWithFlagCtrl_dvppTask_RuntimeFreeCmdList)
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
    multipleTaskInfo.taskDesc[0].u.dvppTaskDesc.sqe.sqeHeader.type = 14;  // RT_STARS_SQE_TYPE_JPEGD;
    multipleTaskInfo.taskDesc[0].u.dvppTaskDesc.aicpuTaskPos = 1 + 3;     // for dvpp rr, add 3 write value
 
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
 
TEST_F(ApiTest, rtMultipleTaskInfoLaunchWithFlagCtrl_dvppTask_RuntimeNotFreeCmdList)
{
    rtTaskDesc_t taskDesc;
    rtMultipleTaskInfo_t multipleTaskInfo = {0};
    multipleTaskInfo.taskNum = 1;
    multipleTaskInfo.taskDesc = &taskDesc;
    memset(multipleTaskInfo.taskDesc, 0, sizeof(rtTaskDesc_t));
 
    void *devPtr;
    rtMalloc(&devPtr, 16, RT_MEMORY_HBM, DEFAULT_MODULEID);
    multipleTaskInfo.taskDesc[0].type = RT_MULTIPLE_TASK_TYPE_DVPP;
    multipleTaskInfo.taskDesc[0].u.dvppTaskDesc.sqe.sqeHeader.type = 14;  // RT_STARS_SQE_TYPE_JPEGD;
    multipleTaskInfo.taskDesc[0].u.dvppTaskDesc.aicpuTaskPos = 1 + 3;     // for dvpp rr, add 3 write value
 
    std::vector<uintptr_t> input;
    input.push_back(reinterpret_cast<uintptr_t>(&multipleTaskInfo));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));
    uint32_t flag = 0x40U;
    input.push_back(static_cast<uintptr_t>(flag));
    int32_t ret = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_MULTIPLE_TSK_FLAG);
    rtFree(devPtr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}
 
TEST_F(ApiTest, rtMultipleTaskInfoLaunchCtrl_InvalidTask)
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
 
TEST_F(ApiTest, rtMultipleTaskInfoLaunchWithFlagCtrl_InvalidTask)
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
 
TEST_F(ApiTest, rtsDvppLaunch_test_02)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
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
 
TEST_F(ApiTest, rtsCmoAsyncWithBarrier_test)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    uint64_t srcAddr = 0;
    uint32_t logicId = 1;
    rtInstance->SetChipType(CHIP_MINI_V3);
    GlobalContainer::SetRtChipType(CHIP_MINI_V3);
    // srcAddr is nullptr
    rtError_t error = rtsCmoAsyncWithBarrier(nullptr, 4, RT_CMO_PREFETCH, logicId, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    // srcLen is zero invalid
    error = rtsCmoAsyncWithBarrier(&srcAddr, 0, RT_CMO_INVALID, logicId, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    // prefetch, writeback, flush, can't set logicId
    error = rtsCmoAsyncWithBarrier(&srcAddr, 4, RT_CMO_PREFETCH, logicId, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtsCmoAsyncWithBarrier(&srcAddr, 4, RT_CMO_FLUSH, logicId, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtsCmoAsyncWithBarrier(&srcAddr, 4, RT_CMO_WRITEBACK, logicId, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    // upsupport cmotype
    error = rtsCmoAsyncWithBarrier(&srcAddr, 4, RT_CMO_RESERVED, logicId, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
 
    // invalid op, but logicId is 0
    error = rtsCmoAsyncWithBarrier(&srcAddr, 4, RT_CMO_INVALID, 0, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    // success case
    error = rtsCmoAsyncWithBarrier(&srcAddr, 4, RT_CMO_PREFETCH, 0, stream_);
    EXPECT_EQ(error, 507000);
    error = rtsCmoAsyncWithBarrier(&srcAddr, 4, RT_CMO_INVALID, logicId, stream_);
    EXPECT_EQ(error, 507000);
}
 
TEST_F(ApiTest, rts_memroy_attritue_fail)
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
 
TEST_F(ApiTest, rts_get_bin_and_stack_buffer)
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
 
TEST_F(ApiTest, rts_callback_subscribe_interface)
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
 
TEST_F(ApiTest, rts_memory_attritue_1)
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
 
TEST_F(ApiTest, rts_memory_attritue_2)
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
 
TEST_F(ApiTest, rts_memory_attritue_3)
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
 
TEST_F(ApiTest, rts_memory_attritue_4)
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
 
TEST_F(ApiTest, rts_memory_reallocation)
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

TEST_F(ApiTest, get_taskid_streamid)
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

TEST_F(ApiTest, rtGetMaxModelNum)
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

TEST_F(ApiTest, rtGetMaxModelNum2)
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

TEST_F(ApiTest, rts_api_get_taskid)
{
    uint32_t taskid;

    rtError_t error = rtsGetThreadLastTaskId(&taskid);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, rtGetOpTimeOutInterval)
{
    rtError_t error;
    uint64_t interval = 0UL;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_610LITE);
    GlobalContainer::SetRtChipType(CHIP_610LITE);
    rtSocType_t socType = rtInstance->GetSocType();
    rtInstance->SetSocType(SOC_ASCEND910B1);
    rtInstance->InitChipAndSocType();
    error= rtGetOpTimeOutInterval(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID); // nullptr
    Runtime::Instance()->timeoutConfig_.isInit = false;
    error= rtGetOpTimeOutInterval(&interval);
    EXPECT_EQ(error, ACL_ERROR_RT_DEV_SETUP_ERROR);

    Runtime::Instance()->timeoutConfig_.isInit = false;
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0); // set device
    MOCKER_CPP_VIRTUAL(device, &Device::CheckFeatureSupport)
        .stubs().will(returnValue(false));
    ((Runtime *)Runtime::Instance())->InitOpExecTimeout(device);
    error = rtGetOpTimeOutInterval(&interval);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    rtInstance->SetSocType(socType);
}

TEST_F(ApiTest, rtSetOpExecuteTimeOutV2)
{
    rtError_t error;
    uint64_t timeout = 100 * 1000 * 100UL; // 100s
    uint64_t actualTimeout = 0UL;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_610LITE);
    GlobalContainer::SetRtChipType(CHIP_610LITE);
    rtSocType_t socType = rtInstance->GetSocType();
    rtInstance->SetSocType(SOC_ASCEND910B1);
    rtInstance->InitChipAndSocType();
    error= rtSetOpExecuteTimeOutV2(timeout, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID); // nullptr
    Runtime::Instance()->timeoutConfig_.isInit = false;
    error= rtSetOpExecuteTimeOutV2(timeout, &actualTimeout);
    EXPECT_EQ(error, ACL_ERROR_RT_DEV_SETUP_ERROR); // not set device

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0); // set device
    Runtime::Instance()->timeoutConfig_.isInit = false;
    MOCKER_CPP_VIRTUAL(device, &Device::CheckFeatureSupport)
        .stubs().will(returnValue(false));
    ((Runtime *)Runtime::Instance())->InitOpExecTimeout(device);
    error= rtSetOpExecuteTimeOutV2(timeout, &actualTimeout);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    rtInstance->SetSocType(socType);
}