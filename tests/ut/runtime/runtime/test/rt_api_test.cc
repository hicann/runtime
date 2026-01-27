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
#include "async_hwts_engine.hpp"
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

class ApiAbnormalTest : public testing::Test
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
    }

    virtual void TearDown()
    {
         GlobalMockObject::verify();
    }
};

TEST_F(ApiAbnormalTest, rtMemcpyAsyncPtrAbnormal)
{
    rtError_t error;
    char srcPtr[64];
    error = rtMemcpyAsyncPtr(srcPtr, 64, 64, RT_MEMCPY_HOST_TO_HOST, nullptr, 0);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest, rtReduceAsyncV2Abnormal)
{
    rtError_t error;
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    EXPECT_NE(rtInstance, nullptr);
    rtChipType_t originType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DAVID);
    GlobalContainer::SetRtChipType(CHIP_DAVID);
    error = rtReduceAsyncV2(nullptr, 0, nullptr, 0, RT_MEMCPY_SDMA_AUTOMATIC_ADD, RT_DATA_TYPE_FP32, nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
    rtInstance->SetChipType(originType);
    GlobalContainer::SetRtChipType(originType);
}

TEST_F(ApiAbnormalTest, rtRDMASendAbnormal)
{
    rtError_t error;
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    EXPECT_NE(rtInstance, nullptr);
    rtChipType_t originType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DAVID);
    GlobalContainer::SetRtChipType(CHIP_DAVID);
    error = rtRDMASend(0, 0, 0);
    EXPECT_NE(error, RT_ERROR_NONE);
    rtInstance->SetChipType(originType);
    GlobalContainer::SetRtChipType(originType);
}

TEST_F(ApiAbnormalTest, rtRDMADBSendAbnormal)
{
    rtError_t error;
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    EXPECT_NE(rtInstance, nullptr);
    rtChipType_t originType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DAVID);
    GlobalContainer::SetRtChipType(CHIP_DAVID);
    error = rtRDMADBSend(0, 0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
    rtInstance->SetChipType(originType);
    GlobalContainer::SetRtChipType(originType);
}

TEST_F(ApiAbnormalTest, rtFftsPlusTaskLaunchAbnormal)
{
    rtError_t error;
    error = rtFftsPlusTaskLaunch(nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest, rtNpuGetFloatStatusAbnormal)
{
    rtError_t error;
    error = rtNpuGetFloatStatus(nullptr, 0, 0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

// rts prefix api
TEST_F(ApiAbnormalTest, rtsNpuClearFloatOverFlowStatus)
{
    rtError_t error;
    error = rtsNpuClearFloatOverFlowStatus(0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest, rtsNpuGetFloatOverFlowStatus)
{
    rtError_t error;
    error = rtsNpuGetFloatOverFlowStatus(nullptr, 0, 0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest, rtsNpuGetFloatOverFlowDebugStatus)
{
    rtError_t error;
    error = rtsNpuGetFloatOverFlowDebugStatus(nullptr, 0, 0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest, rtsNpuClearFloatOverFlowDebugStatus)
{
    rtError_t error;
    error = rtsNpuClearFloatOverFlowDebugStatus(0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}


TEST_F(ApiAbnormalTest, rtFreeKernelBinAbnormal)
{
    rtError_t error;
    error = rtFreeKernelBin(nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest, rtEschedQueryInfoAbnormal)
{
    rtError_t error;
    error = rtEschedQueryInfo(0, RT_QUERY_TYPE_LOCAL_GRP_ID, nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest, rtNpuClearFloatStatusAbnormal)
{
    rtError_t error;
    error = rtNpuClearFloatStatus(0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest, rtsMemcpyAsyncTest)
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

TEST_F(ApiAbnormalTest, rtsMemcpyTest)
{
    rtError_t error;
    char srcPtr[64];
    char dstPtr[64];
    Api *api = Api::Instance();
    MOCKER_CPP_VIRTUAL(api, &Api::RtsMemcpy)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = rtsMemcpy(srcPtr, 64, dstPtr, 64, RT_MEMCPY_KIND_HOST_TO_HOST, nullptr);
    
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest, rtsGetMemcpyDescSize_DavidChip_Success)
{
    rtError_t error;
    size_t size;
    char oriSocVersion[128] = {0};
    
    rtGetSocVersion(oriSocVersion, 128);
    GlobalContainer::SetHardwareChipType(CHIP_END);
    (void)rtSetSocVersion("ASCEND910_958A");
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DAVID);
    GlobalContainer::SetRtChipType(CHIP_DAVID);
    
    error = rtsGetMemcpyDescSize(RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE, &size);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(size, MEMCPY_DESC_SIZE_V2);
    
    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    GlobalContainer::SetHardwareChipType(CHIP_END);
    rtSetSocVersion(oriSocVersion);
}

TEST_F(ApiAbnormalTest, rtsSetMemcpyDescTest)
{
    rtError_t error;
    char desc[32];
    uint32_t srcPtr[64];
    uint32_t dstPtr[64];
    size_t count = 64;
    error = rtsSetMemcpyDesc(desc, RT_MEMCPY_KIND_HOST_TO_HOST, srcPtr, dstPtr, count, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    MOCKER_CPP(&ApiImpl::CurrentContext)
            .stubs()
            .will(returnValue((Context *)dstPtr));
    MOCKER_CPP(&Context::SetMemcpyDesc)
            .stubs()
            .will(returnValue(RT_ERROR_NONE));
    error = rtsSetMemcpyDesc(desc, RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE, srcPtr, dstPtr, count, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
    Api *api = Api::Instance();
    MOCKER_CPP_VIRTUAL(api, &Api::SetMemcpyDesc)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = rtsSetMemcpyDesc(desc, RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE, srcPtr, dstPtr, count, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest, RtsMemcpyAsyncTest)
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

TEST_F(ApiAbnormalTest, RtsMemcpyTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    ApiDecorator apiDecorator(&impl);
    rtMemcpyAttribute_t attr;
    memset_s(&attr, sizeof(attr), 0, sizeof(attr));
    rtMemcpyConfig_t config;
    config.attrs = &attr;
    config.numAttrs = 1;
    uint32_t srcPtr[64];
    uint32_t dstPtr[64];
    uint64_t count = 64;
    MOCKER_CPP_VIRTUAL(api, &ApiErrorDecorator::MemCopySync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::PointerGetAttributes)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtError_t error = api.RtsMemcpy(dstPtr, count, srcPtr, count, RT_MEMCPY_KIND_DEVICE_TO_DEVICE, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = api.RtsMemcpy(dstPtr, count, srcPtr, count, RT_MEMCPY_KIND_DEVICE_TO_DEVICE, &config);
    EXPECT_NE(error, RT_ERROR_NONE);
    attr.value.checkBitmap = 1;
    attr.id = RT_MEMCPY_ATTRIBUTE_CHECK;
    error = api.RtsMemcpy(dstPtr, count, srcPtr, count, RT_MEMCPY_KIND_DEVICE_TO_DEVICE, &config);
    EXPECT_NE(error, RT_ERROR_NONE);
    error = api.RtsMemcpy(dstPtr, count, srcPtr, count, RT_MEMCPY_KIND_INTER_DEVICE_TO_DEVICE, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    error = impl.RtsMemcpy(dstPtr, count, srcPtr, count, RT_MEMCPY_KIND_INTER_DEVICE_TO_DEVICE, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = apiDecorator.RtsMemcpy(dstPtr, count, srcPtr, count, RT_MEMCPY_KIND_INTER_DEVICE_TO_DEVICE, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest, SetMemcpyDescTest)
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

TEST_F(ApiAbnormalTest, rtsGetMemcpyDescSizeTest)
{
    rtError_t error;
    size_t size;
    error = rtsGetMemcpyDescSize(RT_MEMCPY_KIND_HOST_TO_HOST, &size);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtsGetMemcpyDescSize(RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtsGetMemcpyDescSize(RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE, &size);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiAbnormalTest, rtMemcpyAsyncExAbnormal)
{
    rtError_t error = rtMemcpyAsyncEx(NULL, 0U, NULL, 0U, RT_MEMCPY_DEVICE_TO_DEVICE, NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}