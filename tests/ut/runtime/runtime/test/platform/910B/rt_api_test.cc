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
#include "driver/ascend_hal.h"
#include "securec.h"
#include "runtime/rt.h"
#include "runtime/event.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "api.hpp"
#include "api_impl.hpp"
#include "api_error.hpp"
#include "program.hpp"
#include "context.hpp"
#include "raw_device.hpp"
#include "logger.hpp"
#include "engine.hpp"
#include "task_res.hpp"
#include "stars.hpp"
#include "npu_driver.hpp"
#include "api_error.hpp"
#include "event.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "notify.hpp"
#include "profiler.hpp"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "device_state_callback_manager.hpp"
#include "task_fail_callback_manager.hpp"
#include "model.hpp"
#include "subscribe.hpp"
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include "thread_local_container.hpp"
#undef protected
#undef private

using namespace testing;
using namespace cce::runtime;

class ApiAbnormalTest910B : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }

    virtual void SetUp()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        oldChipType = rtInstance->GetChipType();
        (void)rtSetDevice(0);
    }

    virtual void TearDown()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(oldChipType);
        GlobalMockObject::verify();
        rtDeviceReset(0);
    }
private:
    rtChipType_t oldChipType;
};

TEST_F(ApiAbnormalTest910B, rtsGetMemcpyDescSizeTest)
{
    rtError_t error;
    char oriSocVersion[128] = {0};
    rtGetSocVersion(oriSocVersion, 128);
    GlobalContainer::SetHardwareChipType(CHIP_END);
    (void)rtSetSocVersion("Ascend910B1");
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtsGetMemcpyDescSize(RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
    GlobalContainer::SetHardwareChipType(CHIP_END);
    rtSetSocVersion(oriSocVersion);
}

TEST_F(ApiAbnormalTest910B, rtsMemcpyAsyncWithDescTest)
{
    rtError_t error;
    char desc[32];
    error = rtsMemcpyAsyncWithDesc(desc, RT_MEMCPY_KIND_HOST_TO_HOST, nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, rtsGetMemcpyDescSize_NonStarsV2Chip_Success)
{
    rtError_t error;
    size_t size;
    char oriSocVersion[128] = {0};
    rtGetSocVersion(oriSocVersion, 128);
    GlobalContainer::SetHardwareChipType(CHIP_END);
    (void)rtSetSocVersion("Ascend910B1");
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    
    error = rtsGetMemcpyDescSize(RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE, &size);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(size, MEMCPY_DESC_SIZE);
    GlobalContainer::SetHardwareChipType(CHIP_END);
    rtSetSocVersion(oriSocVersion);
}

TEST_F(ApiAbnormalTest910B, rtMemcpyAsyncPtrAbnormal)
{
    rtError_t error;
    char srcPtr[64];
    error = rtMemcpyAsyncPtr(srcPtr, 64, 64, RT_MEMCPY_HOST_TO_HOST, nullptr, 0);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, rtReduceAsyncV2Abnormal)
{
    rtError_t error;
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    EXPECT_NE(rtInstance, nullptr);
    error = rtReduceAsyncV2(nullptr, 0, nullptr, 0, RT_MEMCPY_SDMA_AUTOMATIC_ADD, RT_DATA_TYPE_FP32, nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, rtFftsPlusTaskLaunchAbnormal)
{
    rtError_t error;
    error = rtFftsPlusTaskLaunch(nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, rtNpuGetFloatStatusAbnormal)
{
    rtError_t error;
    error = rtNpuGetFloatStatus(nullptr, 0, 0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, rtGetBinaryDeviceBaseAddrAbnormal)
{
    rtError_t error;
    error = rtGetBinaryDeviceBaseAddr(nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, rtIpcSetMemoryNameAbnormal)
{
    rtError_t error;
    error = rtIpcSetMemoryName(nullptr, 0, nullptr, 0);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, rtIpcCloseMemoryAbnormal)
{
    rtError_t error;
    error = rtIpcCloseMemory(nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, rtsLaunchReduceAsyncTaskAbnormal)
{
    rtError_t error;
    error = rtsLaunchReduceAsyncTask(nullptr, nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, rtReduceAsyncTaskAbnormal)
{
    rtError_t ret;
    void *dst = nullptr;
    uint64_t destMax;
    void *src = nullptr;
    uint64_t cnt;
    rtRecudeKind_t kind;
    rtDataType_t dataType;
    rtStream_t stream;
    ret = rtReduceAsync(dst, destMax, src, cnt, kind, dataType, stream);
    EXPECT_NE(ret, RT_ERROR_NONE);

    uint32_t qosCfg;
    ret = rtReduceAsyncWithCfg(dst, destMax, src, cnt, kind, dataType, stream, qosCfg);
    EXPECT_NE(ret, RT_ERROR_NONE);

    rtTaskCfgInfo_t *cfgInfo = nullptr;
    ret = rtReduceAsyncWithCfgV2(dst, destMax, src, cnt, kind, dataType, stream, cfgInfo);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, event_work_abnormal)
{
    rtError_t error;

    error = rtEventWorkModeGet(nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, cm0_task_abnormal)
{
    rtError_t error;
    rtCmoTaskCfg_t cmoTaskCfg = {};

    cmoTaskCfg.cmoType = RT_CMO_RESERVED;
    error = rtsLaunchCmoTask(&cmoTaskCfg, nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, cntNotify_abnormal)
{
    rtError_t ret = RT_ERROR_NONE;
    rtCntNotify_t inNotify;
    rtCntNotifyWaitInfo_t waitInfo = {RT_CNT_NOTIFY_WAIT_EQUAL_MODE, 0, 10, false};
    uint32_t notifyId = 0;
    ret = rtCntNotifyCreate(0, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtCntNotifyCreateWithFlag(0, nullptr, 0);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtCntNotifyRecord(nullptr, nullptr, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtCntNotifyWaitWithTimeout(nullptr, nullptr, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtCntNotifyReset(nullptr, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtCntNotifyDestroy(nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtGetCntNotifyAddress(nullptr, nullptr, NOTIFY_TYPE_MAX);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtGetCntNotifyId(nullptr, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtCntNotifyCreateServer(&inNotify, 0);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtsCntNotifyWaitWithTimeout(inNotify, nullptr, &waitInfo);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtsCntNotifyReset(inNotify, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtCntNotifyReset(inNotify, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtCntNotifyDestroy(inNotify);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtsCntNotifyGetId(inNotify, &notifyId);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, ubDb_abnormal)
{
    rtError_t ret = RT_ERROR_NONE;
    ret = rtUbDbSend(nullptr, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtUbDirectSend(nullptr, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtFusionLaunch(nullptr, nullptr, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtCCULaunch(nullptr, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtUbDevQueryInfo(QUERY_TYPE_BUFF, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, devRes_abnormal)
{
    rtError_t ret = RT_ERROR_NONE;
    ret = rtGetDevResAddress(nullptr, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtReleaseDevResAddress(nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, taskbuffer_abnormal)
{ 
    rtError_t ret = RT_ERROR_NONE;
    rtTaskBuffType_t type;
    uint32_t bufferLen;
    ret = rtGetTaskBufferLen(type, &bufferLen);
    EXPECT_NE(ret, RT_ERROR_NONE);

    rtTaskInput_t taskInput;
    uint32_t taskLen;
    ret = rtTaskBuild(&taskInput, &taskLen);
    EXPECT_NE(ret, RT_ERROR_NONE);

    void *elfData = nullptr;
    uint32_t elfLen;
    uint32_t offset;
    ret = rtGetElfOffset(elfData, elfLen, &offset);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, rtGetStreamBufferLen_abnormal)
{ 
    const bool isHuge = true;
    uint32_t * const bufferLen = nullptr;
    rtError_t ret = rtGetStreamBufferLen(isHuge, bufferLen);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, rtIpcDestroyMemoryName_abnormal)
{ 
    rtError_t ret = RT_ERROR_NONE;
    ret = rtIpcDestroyMemoryName(nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, debug_abnormal)
{
    rtError_t error;

    error = rtDebugSetDumpMode(RT_DEBUG_DUMP_ON_EXCEPTION);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtDebugGetStalledCore(nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtDebugReadAICore(nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

// rts prefix api
TEST_F(ApiAbnormalTest910B, rtsNpuClearFloatOverFlowStatus)
{
    rtError_t error;
    error = rtsNpuClearFloatOverFlowStatus(0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, rtsNpuGetFloatOverFlowStatus)
{
    rtError_t error;
    error = rtsNpuGetFloatOverFlowStatus(nullptr, 0, 0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, rtsNpuGetFloatOverFlowDebugStatus)
{
    rtError_t error;
    error = rtsNpuGetFloatOverFlowDebugStatus(nullptr, 0, 0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, rtsNpuClearFloatOverFlowDebugStatus)
{
    rtError_t error;
    error = rtsNpuClearFloatOverFlowDebugStatus(0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}


TEST_F(ApiAbnormalTest910B, rtFreeKernelBinAbnormal)
{
    rtError_t error;
    error = rtFreeKernelBin(nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, rtEschedQueryInfoAbnormal)
{
    rtError_t error;
    error = rtEschedQueryInfo(0, RT_QUERY_TYPE_LOCAL_GRP_ID, nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, rtNpuClearFloatStatusAbnormal)
{
    rtError_t error;
    error = rtNpuClearFloatStatus(0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, rtsMemcpyAsyncTest)
{
    rtError_t error;
    char srcPtr[64];
    char dstPtr[64];
    Api *api = Api::Instance();
    MOCKER_CPP_VIRTUAL(api, &Api::RtsMemcpyAsync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = rtsMemcpyAsync(srcPtr, 64, dstPtr, 64, RT_MEMCPY_KIND_HOST_TO_HOST, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, rtsMemcpyTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;
    char srcPtr[64];
    char dstPtr[64];
    Api *api = Api::Instance();
    MOCKER_CPP_VIRTUAL(api, &Api::RtsMemcpy)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = rtsMemcpy(dstPtr, 64, srcPtr, 64, RT_MEMCPY_KIND_HOST_TO_HOST, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDecorator.RtsMemcpy(dstPtr, 64, srcPtr, 64, RT_MEMCPY_KIND_HOST_TO_HOST, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, RtsMemcpyAsyncTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    ApiDecorator apiDecorator(&impl);
    uint32_t srcPtr[64];
    uint32_t dstPtr[64];
    uint64_t count = 64;
    rtMemcpyAttribute_t attr;
    memset_s(&attr, sizeof(attr), 0, sizeof(attr));
    rtMemcpyConfig_t config;
    config.attrs = &attr;
    config.numAttrs = 1;
    MOCKER_CPP_VIRTUAL(api, &ApiErrorDecorator::MemcpyAsync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::PointerGetAttributes)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtError_t error = api.RtsMemcpyAsync(dstPtr, count, srcPtr, count, RT_MEMCPY_KIND_DEVICE_TO_DEVICE, &config, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
    attr.value.checkBitmap = 1;
    attr.id = RT_MEMCPY_ATTRIBUTE_CHECK;
    error = api.RtsMemcpyAsync(dstPtr, count, srcPtr, count, RT_MEMCPY_KIND_DEVICE_TO_DEVICE, &config, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = api.RtsMemcpyAsync(dstPtr, count, srcPtr, count, RT_MEMCPY_KIND_DEVICE_TO_DEVICE, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = api.RtsMemcpyAsync(dstPtr, count, srcPtr, count, RT_MEMCPY_KIND_INTER_DEVICE_TO_DEVICE, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    error = impl.RtsMemcpyAsync(dstPtr, count, srcPtr, count, RT_MEMCPY_KIND_INTER_DEVICE_TO_DEVICE, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = apiDecorator.RtsMemcpyAsync(dstPtr, count, srcPtr, count, RT_MEMCPY_KIND_INTER_DEVICE_TO_DEVICE, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, SetMemcpyDescTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    ApiDecorator apiDecorator(&impl);
    char desc[1024];
    void * descPtr = (void *)((((uint64_t)desc + 64)/64)*64);
    uint32_t srcPtr[64];
    uint32_t dstPtr[64];
    uint64_t count = 64;
    rtPointerAttributes_t attr;
    memset_s(&attr, sizeof(attr), 0, sizeof(attr));
    attr.locationType = RT_MEMORY_LOC_DEVICE;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::PointerGetAttributes)
        .stubs()
        .with(outBoundP(&attr))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&ApiImpl::CurrentContext)
            .stubs()
            .will(returnValue((Context*)nullptr));
    rtError_t error = api.SetMemcpyDesc(descPtr, dstPtr, srcPtr, count, RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = api.SetMemcpyDesc(descPtr, dstPtr, srcPtr, count, RT_MEMCPY_KIND_DEVICE_TO_DEVICE, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = apiDecorator.SetMemcpyDesc(descPtr, dstPtr, srcPtr, count, RT_MEMCPY_KIND_DEVICE_TO_DEVICE, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = impl.SetMemcpyDesc(descPtr, dstPtr, srcPtr, count, RT_MEMCPY_KIND_DEVICE_TO_DEVICE, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, rtMemcpyAsyncExAbnormal)
{
    rtError_t error = rtMemcpyAsyncEx(NULL, 0U, NULL, 0U, RT_MEMCPY_DEVICE_TO_DEVICE, NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiAbnormalTest910B, rtDevBinaryRegister_Null)
{
    rtError_t error;
    void *handle;
    error = rtDevBinaryRegister(NULL, &handle);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, MetadataRegisterTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    error = api.MetadataRegister(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    Program* program = new ElfProgram();
    error = api.MetadataRegister(program, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MetadataRegister)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    char_t *metadata = "test_metadata";
    error = api.MetadataRegister(program, metadata);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete program;
}

TEST_F(ApiAbnormalTest910B, DependencyRegisterTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    error = api.DependencyRegister(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    Program* mProgram = new ElfProgram();
    error = api.DependencyRegister(mProgram, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    Program* sProgram = new ElfProgram();
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DependencyRegister)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = api.DependencyRegister(mProgram, sProgram);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDecorator.DependencyRegister(mProgram, sProgram);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete sProgram;
    delete mProgram;
}

TEST_F(ApiAbnormalTest910B, GetAddrByFunTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    error = api.GetAddrByFun(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    void* addr = nullptr;
    error = api.GetAddrByFun(nullptr, &addr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    void* stubFunc = (void*)0x1000;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetAddrByFun)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = api.GetAddrByFun(stubFunc, &addr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDecorator.GetAddrByFun(stubFunc, &addr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetAddrAndPrefCntWithHandleTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    error = api.GetAddrAndPrefCntWithHandle(nullptr, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    void* hdl = (void*)0x1;
    void* addrPtr = nullptr;
    uint32_t prefetchCnt = 0;
    std::string kernelInfoExt(NAME_MAX_LENGTH, 'a');
    error = api.GetAddrAndPrefCntWithHandle(hdl, (void*)kernelInfoExt.c_str(), &addrPtr, &prefetchCnt);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    std::string validName(NAME_MAX_LENGTH - 1, 'a');
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetAddrAndPrefCntWithHandle)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = api.GetAddrAndPrefCntWithHandle(hdl, (void*)validName.c_str(), &addrPtr, &prefetchCnt);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, CheckArgsWithTypeCpuTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    rtCpuKernelArgs_t validInfo = {};
    int dummyArgs = 0x1234;
    validInfo.baseArgs.args = &dummyArgs;
    validInfo.baseArgs.argsSize = 1024;

    RtArgsWithType argsWithType;
    argsWithType.args.argHandle = nullptr;
    argsWithType.type = RT_ARGS_CPU_EX;
    argsWithType.args.cpuArgsInfo = &validInfo;

    error = api.CheckArgsWithType(&argsWithType);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, KernelGetAddrAndPrefCntTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    void* hdl = (void*)0x1;
    void* addrPtr = nullptr;
    uint32_t prefetchCnt = 0;
    void* stubFunc = (void*)0x1000;
    uint64_t tilingKey = 0;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::KernelGetAddrAndPrefCnt)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    uint32_t flag = RT_STATIC_SHAPE_KERNEL;
    error = api.KernelGetAddrAndPrefCnt(hdl, tilingKey, stubFunc, flag, &addrPtr, &prefetchCnt);
    EXPECT_EQ(error, RT_ERROR_NONE);

    flag = RT_DYNAMIC_SHAPE_KERNEL;
    error = api.KernelGetAddrAndPrefCnt(hdl, tilingKey, stubFunc, flag, &addrPtr, &prefetchCnt);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, KernelGetAddrAndPrefCntV2Test)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    void* hdl = (void*)0x1;
    uint32_t prefetchCnt = 0;
    void* stubFunc = (void*)0x1000;
    uint64_t tilingKey = 0;
    rtKernelDetailInfo_t kernelInfo;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::KernelGetAddrAndPrefCntV2)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    uint32_t flag = RT_STATIC_SHAPE_KERNEL;
    error = api.KernelGetAddrAndPrefCntV2(hdl, tilingKey, nullptr, flag, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::KernelGetAddrAndPrefCntV2)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = api.KernelGetAddrAndPrefCntV2(hdl, tilingKey, stubFunc, flag, &kernelInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);

    flag = RT_DYNAMIC_SHAPE_KERNEL;
    error = api.KernelGetAddrAndPrefCntV2(nullptr, tilingKey, stubFunc, flag, &kernelInfo);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(ApiAbnormalTest910B, CheckCfgTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    rtTaskCfgInfo_t taskCfgInfo = {};
    taskCfgInfo.schemMode = RT_SCHEM_MODE_END;
    error = api.CheckCfg(&taskCfgInfo);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(ApiAbnormalTest910B, RegisterCpuFuncTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    error = api.RegisterCpuFunc(nullptr, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    ElfProgram program;
    rtBinHandle binHandle = &program;
    rtFuncHandle funcHandle;
    char_t *funcName = "funcName";
    char_t *kernelName = "kernelName";
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::RegisterCpuFunc)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = api.RegisterCpuFunc(binHandle, funcName, kernelName, &funcHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDecorator.RegisterCpuFunc(binHandle, funcName, kernelName, &funcHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, LaunchKernelV3Test)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    error = api.LaunchKernelV3(nullptr, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1;
    Kernel * k1 = new Kernel(&fun1, "f1", "", program, 10);
    rtLaunchConfig_t launchConfig;
    rtLaunchAttribute_t attrs = {};
    launchConfig.attrs = &attrs;

    MOCKER_CPP(&ApiErrorDecorator::CheckArgs).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::LaunchKernelV3)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = api.LaunchKernelV3(k1, nullptr, nullptr, &launchConfig);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete k1;
}

TEST_F(ApiAbnormalTest910B, KernelLaunchWithHandleTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    uint32_t coreDim = 1;
    uint64_t tilingKey = 0;
    MOCKER_CPP(&ApiErrorDecorator::CheckArgs).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&ApiErrorDecorator::CheckCfg).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::KernelLaunchWithHandle)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = api.KernelLaunchWithHandle(nullptr, tilingKey, coreDim, nullptr, nullptr, nullptr, nullptr, false);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, CpuKernelLaunchExWithArgsTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    char_t *opName = "opName";
    uint32_t coreDim = 1;
    uint64_t arg = 0x1234567890;
    rtAicpuArgsEx_t argsInfo = {};
    argsInfo.args = (void*)&arg;
    argsInfo.argsSize = sizeof(arg);

    rtStream_t stm;
    error = rtStreamCreate(&stm, 0);
    Stream *stmPtr = static_cast<Stream *>(stm);
    stmPtr->flags_ = 0;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::CpuKernelLaunchExWithArgs)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = api.CpuKernelLaunchExWithArgs(opName, coreDim, &argsInfo, nullptr, stmPtr, 1, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamDestroy(stm);
}

TEST_F(ApiAbnormalTest910B, EventCreateForNotifyTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    Event* eventPtr = nullptr;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EventCreateForNotify)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = api.EventCreateForNotify(&eventPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDecorator.EventCreateForNotify(&eventPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, EventRecordForNotifyTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    rtEvent_t event;
    error = rtEventCreateWithFlag(&event, RT_EVENT_TIME_LINE);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    Event* const eventPtr = static_cast<Event *>(event);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EventRecordForNotify)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = api.EventRecordForNotify(eventPtr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDecorator.EventRecordForNotify(eventPtr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(ApiAbnormalTest910B, EventQueryTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    rtEvent_t event;
    error = rtEventCreateWithFlag(&event, RT_EVENT_TIME_LINE);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    Event* const eventPtr = static_cast<Event *>(event);
    eventPtr->isNewMode_ = false;

    MOCKER_CPP(&Event::IsCapturing).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EventQuery)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = api.EventQuery(eventPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(ApiAbnormalTest910B, DevMallocCachedTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    void* devPtr = nullptr;
    uint64_t size = 1;
    uint16_t moduleId = 0;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DevMallocCached)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = api.DevMallocCached(&devPtr, size, 0, moduleId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDecorator.DevMallocCached(&devPtr, size, 0, moduleId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, MallocHostSharedMemoryTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    error = api.MallocHostSharedMemory(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(ApiAbnormalTest910B, GetBinaryDeviceBaseAddrTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    Program* program = new ElfProgram();

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetBinaryDeviceBaseAddr)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = apiDecorator.GetBinaryDeviceBaseAddr(program, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete program;
}

TEST_F(ApiAbnormalTest910B, GetFunctionByNameTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    void *stubFunc;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetFunctionByName)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = apiDecorator.GetFunctionByName("foo", &stubFunc);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, QueryFunctionRegisteredTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::QueryFunctionRegistered)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.QueryFunctionRegistered("foo");
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, KernelLaunchTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    rtArgsEx_t argsInfo = {};
    argsInfo.args = nullptr;
    argsInfo.argsSize = 40000U;
    argsInfo.hostInputInfoNum = 4;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::KernelLaunch)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.KernelLaunch(nullptr, 1, &argsInfo, nullptr, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, CalcLaunchArgsSizeTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    size_t argsSize = 0;
    size_t hostInfoTotalSize = 0;
    size_t hostInfoNum = 0;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::CalcLaunchArgsSize)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    
    error = apiDecorator.CalcLaunchArgsSize(argsSize, hostInfoTotalSize, hostInfoNum, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, CreateLaunchArgsTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    size_t argsSize = 0;
    size_t hostInfoTotalSize = 0;
    size_t hostInfoNum = 0;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::CreateLaunchArgs)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.CreateLaunchArgs(argsSize, hostInfoTotalSize, hostInfoNum, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, DestroyLaunchArgsTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DestroyLaunchArgs)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.DestroyLaunchArgs(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, ResetLaunchArgsTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ResetLaunchArgs)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.ResetLaunchArgs(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, AppendLaunchAddrInfoTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::AppendLaunchAddrInfo)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.AppendLaunchAddrInfo(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, AppendLaunchHostInfoTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    size_t hostInfoSize = 0;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::AppendLaunchHostInfo)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.AppendLaunchHostInfo(nullptr, hostInfoSize, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, BinaryGetMetaInfoTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::BinaryGetMetaInfo)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.BinaryGetMetaInfo(nullptr, RT_BINARY_TYPE_BIN_VERSION, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, FunctionGetMetaInfoTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::FunctionGetMetaInfo)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.FunctionGetMetaInfo(nullptr, RT_FUNCTION_TYPE_KERNEL_TYPE, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, FuncGetAddrTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    ElfProgram program;
    uint64_t tilingKey = 0;
    Kernel kernel(nullptr, "testKernelName", tilingKey, nullptr, 2048, 1024, 0, 0, 0);
    void* func1;
    void* func2;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::FuncGetAddr)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.FuncGetAddr(&kernel, &func1, &func2);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, StreamQueryTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StreamQuery)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.StreamQuery(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetSqIdTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    uint32_t sqId = 0;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetSqId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetSqId(nullptr, &sqId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetCqIdTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    uint32_t cqId = 0;
    uint32_t logicCqId = 0;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetCqId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetCqId(nullptr, &cqId, &logicCqId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, EventCreateTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    uint64_t flag = RT_EVENT_TIME_LINE;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EventCreate)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    
    error = apiDecorator.EventCreate(nullptr, flag);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, EventDestroyTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EventDestroy)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    
    error = apiDecorator.EventDestroy(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, EventRecordTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EventRecord)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    
    error = apiDecorator.EventRecord(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, EventResetTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EventReset)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    
    error = apiDecorator.EventReset(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetEventIDTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetEventID)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    uint32_t evtId = 0;
    error = apiDecorator.GetEventID(nullptr, &evtId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, DevFreeTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DevFree)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    uint64_t size = 0;
    uint16_t moduleId = 0;
    error = apiDecorator.DevFree(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, DevDvppMallocTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DevDvppMalloc)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.DevDvppMalloc(nullptr, 1, 0, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, DevDvppFreeTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DevDvppFree)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.DevDvppFree(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, HostMallocWithCfgTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::HostMallocWithCfg)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.HostMallocWithCfg(nullptr, 1, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, HostUnregisterTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    ApiErrorDecorator api(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::HostUnregister)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.HostUnregister(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = api.HostUnregister(nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    void* ptr = (void*)0x1000;
    error = api.HostUnregister(ptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, FlushCacheTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::FlushCache)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.FlushCache(1, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, InvalidCacheTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::InvalidCache)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.InvalidCache(1, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, MemcpyAsyncWithDescTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemcpyAsyncWithDesc)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.MemcpyAsyncWithDesc(nullptr, nullptr, RT_MEMCPY_KIND_HOST_TO_DEVICE, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, CheckMemTypeTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::CheckMemType)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    uint32_t checkResult = 0;
    error = apiDecorator.CheckMemType(nullptr, 1, 1, &checkResult, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, PtrGetAttributesTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::PtrGetAttributes)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.PtrGetAttributes(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, MemPrefetchToDeviceTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemPrefetchToDevice)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.MemPrefetchToDevice(nullptr, 1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, OpenNetServiceTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::OpenNetService)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.OpenNetService(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, CloseNetServiceTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::CloseNetService)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.CloseNetService();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, SetDeviceTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::SetDevice)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.SetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, DeviceResetTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DeviceReset)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.DeviceReset(0, true);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, DeviceSetLimitTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DeviceSetLimit)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.DeviceSetLimit(0, RT_LIMIT_TYPE_LOW_POWER_TIMEOUT, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, DeviceSynchronizeTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DeviceSynchronize)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.DeviceSynchronize(10);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, DeviceTaskAbortTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DeviceTaskAbort)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.DeviceTaskAbort(0, 10);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, SnapShotProcessBackupTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::SnapShotProcessBackup)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.SnapShotProcessBackup();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, SnapShotProcessRestoreTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::SnapShotProcessRestore)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.SnapShotProcessRestore();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetDeviceInfoTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetDeviceInfo)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetDeviceInfo(0, 0, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetDeviceInfoByAttrTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetDeviceInfoByAttr)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetDeviceInfoByAttr(0, RT_DEV_ATTR_AICPU_CORE_NUM, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, DeviceSetTsIdTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    ApiErrorDecorator api(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DeviceSetTsId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.DeviceSetTsId(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = api.DeviceSetTsId(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, SetDeviceFailureModeTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::SetDeviceFailureMode)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.SetDeviceFailureMode(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, DeviceGetBareTgidTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DeviceGetBareTgid)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.DeviceGetBareTgid(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, ContextCreateTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ContextCreate)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.ContextCreate(nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, ContextDestroyTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ContextDestroy)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.ContextDestroy(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, ContextGetCurrentTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ContextGetCurrent)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.ContextGetCurrent(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, ModelExecuteSyncTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    ApiErrorDecorator api(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ModelExecuteSync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.ModelExecuteSync(nullptr, 10);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtModel_t rtModel;
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model* model = static_cast<Model *>(rtModel);
    error = api.ModelExecuteSync(model, 10);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, ModelTaskUpdateTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ModelTaskUpdate)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.ModelTaskUpdate(nullptr, 0, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetAiCoreCountTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetAiCoreCount)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetAiCoreCount(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetAiCpuCountTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetAiCpuCount)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetAiCpuCount(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetAiCoreSpecTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetAiCoreSpec)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetAiCoreSpec(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetAiCoreMemoryRatesTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetAiCoreMemoryRates)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetAiCoreMemoryRates(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetMemoryConfigTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetMemoryConfig)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetMemoryConfig(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, RegProfCtrlCallbackTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::RegProfCtrlCallback)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.RegProfCtrlCallback(1, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, IpcCloseMemoryByNameTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    ApiErrorDecorator api(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::IpcCloseMemoryByName)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.IpcCloseMemoryByName(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    char_t* name = "name";
    error = api.IpcCloseMemoryByName(name);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, NotifyDestroyTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::NotifyDestroy)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.NotifyDestroy(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, IpcOpenNotifyTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::IpcOpenNotify)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.IpcOpenNotify(nullptr, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, StreamSwitchExTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    ApiErrorDecorator api(&impl);
    rtError_t error;

    error = api.StreamSwitchEx(nullptr, RT_EQUAL, nullptr, nullptr, nullptr, RT_SWITCH_INT32);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StreamSwitchEx)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    void* ptr = (void*)0x1000;
    void* valuePtr = (void*)0x0100;
    rtStream_t trueStm;
    error = rtStreamCreate(&trueStm, 0);
    Stream *trueStream = static_cast<Stream *>(trueStm);

    rtStream_t stm;
    error = rtStreamCreate(&stm, 0);
    Stream *stream = static_cast<Stream *>(stm);

    error = apiDecorator.StreamSwitchEx(ptr, RT_EQUAL, valuePtr, trueStream, stream, RT_SWITCH_INT32);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = api.StreamSwitchEx(ptr, RT_EQUAL, valuePtr, trueStream, stream, RT_SWITCH_INT32);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamDestroy(stm);
    rtStreamDestroy(trueStm);
}

TEST_F(ApiAbnormalTest910B, StreamActiveTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    ApiErrorDecorator api(&impl);
    rtError_t error;

    error = api.StreamActive(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StreamActive)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtStream_t activeStm;
    error = rtStreamCreate(&activeStm, 0);
    Stream *activeStream = static_cast<Stream *>(activeStm);

    rtStream_t stm;
    error = rtStreamCreate(&stm, 0);
    Stream *stream = static_cast<Stream *>(stm);

    error = api.StreamActive(activeStream, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDecorator.StreamActive(activeStream, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamDestroy(stm);
    rtStreamDestroy(activeStm);
}

TEST_F(ApiAbnormalTest910B, ProfilerTraceTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ProfilerTrace)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.ProfilerTrace(1, true, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, ProfilerTraceExTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ProfilerTraceEx)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.ProfilerTraceEx(1, 1, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, SetIpcNotifyPidExTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    ApiErrorDecorator api(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::SetIpcNotifyPid)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.SetIpcNotifyPid(nullptr, nullptr, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    char_t *name = "name";
    int32_t pid[] = {0, 1};
    error = api.SetIpcNotifyPid(name, pid, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, CallbackLaunchTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::CallbackLaunch)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.CallbackLaunch(nullptr, nullptr, nullptr, true);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, UnSubscribeReportTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::UnSubscribeReport)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.UnSubscribeReport(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetRunModeTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetRunMode)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetRunMode(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetPairDevicesInfoTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetPairDevicesInfo)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetPairDevicesInfo(1, 0, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetPairPhyDevicesInfoTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetPairPhyDevicesInfo)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetPairPhyDevicesInfo(1, 0, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetRtCapabilityTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetRtCapability)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetRtCapability(FEATURE_TYPE_MEMCPY, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetDeviceCapabilityTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetDeviceCapability)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetDeviceCapability(0, 0, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, SetOpWaitTimeOutTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::SetOpWaitTimeOut)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.SetOpWaitTimeOut(10);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, SetOpExecuteTimeOutTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::SetOpExecuteTimeOut)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.SetOpExecuteTimeOut(10, RT_TIME_UNIT_TYPE_MS);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetOpExecuteTimeOutTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetOpExecuteTimeOut)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetOpExecuteTimeOut(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetOpExecuteTimeoutV2Test)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetOpExecuteTimeoutV2)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetOpExecuteTimeoutV2(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, CheckArchCompatibilityTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::CheckArchCompatibility)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.CheckArchCompatibility(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetDevMsgTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetDevMsg)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetDevMsg(RT_GET_DEV_ERROR_MSG, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, SetGroupTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::SetGroup)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.SetGroup(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetGroupCountTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetGroupCount)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetGroupCount(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetGroupInfoTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetGroupInfo)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetGroupInfo(0, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, StarsTaskLaunchTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StarsTaskLaunch)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.StarsTaskLaunch(nullptr, 1, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetC2cCtrlAddrTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetC2cCtrlAddr)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetC2cCtrlAddr(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, FftsPlusTaskLaunchTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::FftsPlusTaskLaunch)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.FftsPlusTaskLaunch(nullptr, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, NpuGetFloatStatusTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::NpuGetFloatStatus)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.NpuGetFloatStatus(nullptr, 0, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, NpuClearFloatStatusTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::NpuClearFloatStatus)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.NpuClearFloatStatus(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, NpuGetFloatDebugStatusTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::NpuGetFloatDebugStatus)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.NpuGetFloatDebugStatus(nullptr, 0, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, NpuClearFloatDebugStatusTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::NpuClearFloatDebugStatus)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.NpuClearFloatDebugStatus(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, ContextSetINFModeTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ContextSetINFMode)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.ContextSetINFMode(true);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, MemQueueExportTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemQueueExport)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.MemQueueExport(0, 0, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, MemQueueUnExportTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemQueueUnExport)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.MemQueueUnExport(0, 0, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, MemQueueImportTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemQueueImport)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.MemQueueImport(0, 0, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, MemQueueUnImportTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemQueueUnImport)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.MemQueueUnImport(0, 0, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, QueueSubscribeTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::QueueSubscribe)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.QueueSubscribe(0, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, EschedWaitEventTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EschedWaitEvent)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.EschedWaitEvent(0, 0, 0, 10, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, SetDeviceSatModeTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::SetDeviceSatMode)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.SetDeviceSatMode(RT_OVERFLOW_MODE_SATURATION);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetDeviceSatModeTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetDeviceSatMode)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetDeviceSatMode(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetDeviceSatModeForStreamTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetDeviceSatModeForStream)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetDeviceSatModeForStream(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, SetStreamOverflowSwitchTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::SetStreamOverflowSwitch)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.SetStreamOverflowSwitch(nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetStreamOverflowSwitchTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetStreamOverflowSwitch)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetStreamOverflowSwitch(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetKernelBinTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetKernelBin)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetKernelBin(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, MemSetAccessTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemSetAccess)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.MemSetAccess(nullptr, 0, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, ShrIdSetPodPidTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ShrIdSetPodPid)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.ShrIdSetPodPid(nullptr, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, ShmemSetPodPidTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ShmemSetPodPid)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.ShmemSetPodPid(nullptr, 0, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, DevVA2PATest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DevVA2PA)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.DevVA2PA(0, 0, nullptr, true);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, StreamAbortTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StreamAbort)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.StreamAbort(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, DebugSetDumpModeTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DebugSetDumpMode)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.DebugSetDumpMode(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, DebugGetStalledCoreTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DebugGetStalledCore)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.DebugGetStalledCore(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, DebugReadAICoreTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DebugReadAICore)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.DebugReadAICore(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetPrimaryCtxStateTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetPrimaryCtxState)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetPrimaryCtxState(0, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, ResetDeviceResLimitTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ResetDeviceResLimit)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.ResetDeviceResLimit(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetDeviceResLimitTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetDeviceResLimit)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetDeviceResLimit(0, RT_DEV_RES_CUBE_CORE, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetLogicDevIdByUserDevIdTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetLogicDevIdByUserDevId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetLogicDevIdByUserDevId(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetUserDevIdByLogicDevIdTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetUserDevIdByLogicDevId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetUserDevIdByLogicDevId(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetDeviceUuidTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetDeviceUuid)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetDeviceUuid(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, StreamBeginTaskUpdateTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StreamBeginTaskUpdate)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.StreamBeginTaskUpdate(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, StreamEndTaskUpdateTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StreamEndTaskUpdate)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.StreamEndTaskUpdate(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, ModelDebugJsonPrintTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ModelDebugJsonPrint)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.ModelDebugJsonPrint(nullptr, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, StreamBeginTaskGrpTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StreamBeginTaskGrp)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.StreamBeginTaskGrp(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, StreamEndTaskGrpTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StreamEndTaskGrp)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.StreamEndTaskGrp(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetCntNotifyIdTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetCntNotifyId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetCntNotifyId(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, MemWriteValueTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemWriteValue)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.MemWriteValue(nullptr, 0, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, MemWaitValueTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemWaitValue)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.MemWaitValue(nullptr, 0, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, FuncGetNameTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::FuncGetName)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.FuncGetName(nullptr, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetErrorVerboseTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetErrorVerbose)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.GetErrorVerbose(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, RepairErrorTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::RepairError)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.RepairError(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, LaunchHostFuncTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::LaunchHostFunc)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.LaunchHostFunc(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, EventWorkModeSetTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EventWorkModeSet)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.EventWorkModeSet(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, EventWorkModeGetTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::EventWorkModeGet)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.EventWorkModeGet(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, SetXpuDeviceTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::SetXpuDevice)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.SetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, ResetXpuDeviceTest)
{
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ResetXpuDevice)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = apiDecorator.ResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, ReduceAsyncTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ReduceAsync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    void* dst = (void*)0x1000;
    void* src = (void*)0x0010;
    error = api.ReduceAsync(dst, src, MAX_MEMCPY_SIZE_OF_D2D, RT_MEMCPY_SDMA_AUTOMATIC_ADD, RT_DATA_TYPE_FP16, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, ReduceAsyncV2Test)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ReduceAsyncV2)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    void* dst = (void*)0x1000;
    void* src = (void*)0x0010;
    void* overflowAddr = (void*)0x0001;
    error = api.ReduceAsyncV2(dst, src, MAX_MEMCPY_SIZE_OF_D2D, RT_MEMCPY_SDMA_AUTOMATIC_ADD, RT_DATA_TYPE_FP16, nullptr, overflowAddr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, MemGetL2InfoTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    error = api.MemGetL2Info(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    rtStream_t stm;
    error = rtStreamCreate(&stm, 0);
    Stream *stmPtr = static_cast<Stream *>(stm);
    void* dst = (void*)0x1000;
    uint32_t size = 0;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::MemGetL2Info)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = api.MemGetL2Info(stmPtr, &dst, &size);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamDestroy(stm);
}

TEST_F(ApiAbnormalTest910B, GetDeviceIDsTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    error = api.GetDeviceIDs(nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetDeviceIDs)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    uint32_t devId = 0;
    error = api.GetDeviceIDs(&devId, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, StartOnlineProfTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StartOnlineProf)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = api.StartOnlineProf(nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, StopOnlineProfTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StopOnlineProf)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = api.StopOnlineProf(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, AdcProfilerTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::AdcProfiler)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = api.AdcProfiler(0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetOnlineProfDataTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetOnlineProfData)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtProfDataInfo_t pProfData = {};
    error = api.GetOnlineProfData(nullptr, &pProfData, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, NopTaskTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::NopTask)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtStream_t stm;
    error = rtStreamCreate(&stm, 0);
    Stream *stmPtr = static_cast<Stream *>(stm);
    
    error = api.NopTask(stmPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamDestroy(stm);
}

TEST_F(ApiAbnormalTest910B, IpcDestroyMemoryNameTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    error = api.IpcDestroyMemoryName(nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::IpcDestroyMemoryName)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    char_t *name = "name";
    error = api.IpcDestroyMemoryName(name);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, SetIpcMemPidTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    error = api.SetIpcMemPid(nullptr, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::SetIpcMemPid)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    char_t *name = "name";
    int32_t pid[] = {0, 1};
    error = api.SetIpcMemPid(name, pid, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, IpcCloseMemoryTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    error = api.IpcCloseMemory(nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::IpcCloseMemory)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    void* ptr = (void*)0x1000;
    error = api.IpcCloseMemory(ptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, ModelGetIdTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    error = api.ModelGetId(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ModelGetId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtModel_t rtModel;
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Model* model = static_cast<Model *>(rtModel);
    uint32_t modelId = 0;
    error = api.ModelGetId(model, &modelId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, ModelSetSchGroupIdTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    error = api.ModelSetSchGroupId(nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    rtModel_t rtModel;
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Model* model = static_cast<Model *>(rtModel);
    error = api.ModelSetSchGroupId(model, 5);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ModelSetSchGroupId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = api.ModelSetSchGroupId(model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, DebugRegisterForStreamTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    error = api.DebugRegisterForStream(nullptr, 0, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DebugRegisterForStream)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtStream_t stm;
    error = rtStreamCreate(&stm, 0);
    Stream *stmPtr = static_cast<Stream *>(stm);
    void* addr = (void*)0x1000;
    uint32_t streamId = 0;
    uint32_t taskId = 0;
    error = api.DebugRegisterForStream(stmPtr, 0, addr, &streamId, &taskId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamDestroy(stm);
}

TEST_F(ApiAbnormalTest910B, DebugUnRegisterForStreamTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    error = api.DebugUnRegisterForStream(nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::DebugUnRegisterForStream)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtStream_t stm;
    error = rtStreamCreate(&stm, 0);
    Stream *stmPtr = static_cast<Stream *>(stm);
    error = api.DebugUnRegisterForStream(stmPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamDestroy(stm);
}

TEST_F(ApiAbnormalTest910B, ModelExecutorSetTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    error = api.ModelExecutorSet(nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ModelExecutorSet)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtModel_t rtModel;
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Model* model = static_cast<Model *>(rtModel);

    error = api.ModelExecutorSet(model, EXECUTOR_TS);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, ModelExitTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    error = api.ModelExit(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::ModelExit)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtModel_t rtModel;
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Model* model = static_cast<Model *>(rtModel);

    rtStream_t stm;
    error = rtStreamCreate(&stm, 0);
    Stream *stmPtr = static_cast<Stream *>(stm);

    error = api.ModelExit(model, stmPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stm);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest910B, GetNotifyIDTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t error;

    error = api.GetNotifyID(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetNotifyID)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    Notify* notify = new Notify(0, 0);
    uint32_t notifyId = 0;
    error = api.GetNotifyID(notify, &notifyId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete notify;
}