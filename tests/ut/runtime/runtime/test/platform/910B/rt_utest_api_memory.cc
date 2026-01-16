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
#include "runtime/rts/rts.h"
#include "runtime/event.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "api.hpp"
#include "api_impl.hpp"
#include "api_error.hpp"
#include "api_c.h"
#include "api_error.hpp"
#include "raw_device.hpp"
#include "npu_driver.hpp"
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include <cstring>
#undef protected
#undef private

using namespace testing;
using namespace cce::runtime;

class RtMemoryApiTest : public testing::Test
{

protected:
    static void SetUpTestCase()
    {
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
        std::cout<<"engine test start"<<std::endl;
    }

    static void TearDownTestCase()
    {
    }

    virtual void SetUp()
    {
        (void)rtSetDevice(0);
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        (void)rtDeviceReset(0);
    }

private:
    rtChipType_t originType_;
};

TEST_F(RtMemoryApiTest, rtReserveMemAddress)
{
    void *devPtr = nullptr;
    rtError_t error = rtReserveMemAddress(&devPtr, 0, 0, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halMemAddressReserve)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtReserveMemAddress(&devPtr, 0, 0, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtReleaseMemAddress)
{
    rtError_t error = rtReleaseMemAddress(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halMemAddressFree)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtReleaseMemAddress(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtMallocPhysical)
{
    rtDrvMemHandle handle = nullptr;
    rtDrvMemProp_t prop = {};
    prop.mem_type = RT_MEMORY_DEFAULT;  // HBM 内存，当前只支持申请HBM内存
    prop.pg_type = 1;
    prop.side = 1;
    prop.devid = 0;
    prop.module_id = 0;
    size_t size = 32;

    MOCKER(halMemCreate)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    rtError_t error = rtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, testHostNumaAlloc)
{
    rtDrvMemHandle handle = nullptr;
    rtDrvMemProp_t prop = {};
    prop.side = 4;
    prop.devid = 0;
    prop.pg_type = RT_MEMORY_DEFAULT;
    prop.mem_type = 0;
    int32_t deviceId = 0;
    rtError_t error = rtSetDevice(deviceId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    MOCKER(halMemCreate)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    error = rtMallocPhysical(&handle, 1, &prop, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceReset(deviceId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtMemoryApiTest, rtFreePhysical)
{
    rtDrvMemHandle handle = nullptr;
    rtError_t error = rtFreePhysical(handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halMemRelease)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtFreePhysical(handle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtMapMem)
{
    rtError_t error = rtMapMem(nullptr, 0, 0, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halMemMap)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMapMem(nullptr, 0, 0, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtUnmapMem)
{
    rtError_t error = rtUnmapMem(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halMemUnmap)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtUnmapMem(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtSetIpcMemorySuperPodPid)
{
    rtError_t error;
    int32_t pids[2] = {100, 1000};
    error = rtSetIpcMemorySuperPodPid("test1", 100, pids, sizeof(pids)/sizeof(int32_t));
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halShmemSetPodPid)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtSetIpcMemorySuperPodPid("test1", 100, pids, sizeof(pids)/sizeof(int32_t));
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtBindHostPid)
{
    rtBindHostpidInfo info = {};
    rtError_t error = rtBindHostPid(info);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(drvBindHostPid)
    .stubs()
    .will(returnValue(DRV_ERROR_INVALID_VALUE));  

    error = rtBindHostPid(info);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtUnbindHostPid)
{
    rtBindHostpidInfo info = {};
    rtError_t error = rtUnbindHostPid(info);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(drvUnbindHostPid)
    .stubs()
    .will(returnValue(DRV_ERROR_INVALID_VALUE));  

    error = rtUnbindHostPid(info);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtQueryProcessHostPid)
{
    rtError_t error;
    error = rtQueryProcessHostPid(0, nullptr, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(drvQueryProcessHostPid)
    .stubs()
    .will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtQueryProcessHostPid(0, nullptr, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtGetServerIDBySDID)
{
    rtError_t error;
    uint32_t sdid1 = 0x66660000U;
    uint32_t srvid = 0;

    error = rtGetServerIDBySDID(sdid1, &srvid);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MOCKER(halParseSDID)
    .stubs()
    .will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtGetServerIDBySDID(sdid1, &srvid);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtGetMemUsageInfo)
{
    uint32_t deviceId = 0;
    rtMemUsageInfo_t memUsageInfo[10];
    size_t inputNum = 10;
    size_t outputNum = 10;

    rtError_t error = rtGetMemUsageInfo(deviceId, memUsageInfo, inputNum, &outputNum);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    ApiImpl apiImpl;
    ApiDecorator apiDecorator(&apiImpl);
    error = apiDecorator.GetMemUsageInfo(deviceId, memUsageInfo, inputNum, &outputNum);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MOCKER(halGetMemUsageInfo)
    .stubs()
    .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtGetMemUsageInfo(deviceId, memUsageInfo, inputNum, &outputNum);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtMemoryApiTest, rtsMallocHost_001)
{
    rtError_t error;
    Api *Api_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(Api_);
    void * hostPtr;
    rtMallocConfig_t *malloCfg = (rtMallocConfig_t *)malloc(sizeof(rtMallocConfig_t));
    rtMallocAttribute_t* mallocAttrs = new rtMallocAttribute_t[1];
    malloCfg->numAttrs = 1;

    // 无效cfg校验
    malloCfg->attrs = nullptr;
    error = apiDecorator_->HostMallocWithCfg(&hostPtr, 1, malloCfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    // 无效hostPtr校验
    malloCfg->attrs = mallocAttrs;
    mallocAttrs[0].attr = RT_MEM_MALLOC_ATTR_MODULE_ID;
    mallocAttrs[0].value.moduleId = 1;
    error = apiDecorator_->HostMallocWithCfg(nullptr, 1, malloCfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    // 无效size校验
    error = apiDecorator_->HostMallocWithCfg(&hostPtr, 0, malloCfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete[] mallocAttrs;
    free(malloCfg);
    delete apiDecorator_;
}

TEST_F(RtMemoryApiTest, rtsMallocHost_002)
{
    rtError_t error;
    Api *Api_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(Api_);
    void * hostPtr;
    rtMallocConfig_t *malloCfg = (rtMallocConfig_t *)malloc(sizeof(rtMallocConfig_t));
    rtMallocAttribute_t* mallocAttrs = new rtMallocAttribute_t[1];
    malloCfg->numAttrs = 1;
    malloCfg->attrs = mallocAttrs;

    // 申请内存的cfg不支持module/uva之外的类型
    mallocAttrs[0].attr = RT_MEM_MALLOC_ATTR_RSV;
    mallocAttrs[0].value.moduleId = 0;
    error = apiDecorator_->HostMallocWithCfg(&hostPtr, 60, malloCfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    mallocAttrs[0].attr = RT_MEM_MALLOC_ATTR_DEVICE_ID;
    error = apiDecorator_->HostMallocWithCfg(&hostPtr, 60, malloCfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    // 配置moduleId
    mallocAttrs[0].attr = RT_MEM_MALLOC_ATTR_MODULE_ID;
    mallocAttrs[0].value.moduleId = 1;
    error = apiDecorator_->HostMallocWithCfg(&hostPtr, 60, malloCfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = apiDecorator_->HostFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete[] mallocAttrs;
    free(malloCfg);
    delete apiDecorator_;
}

TEST_F(RtMemoryApiTest, rtsMallocHost_003)
{
    rtError_t error;
    Api *Api_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(Api_);
    void * hostPtr;
    rtMallocConfig_t *malloCfg = (rtMallocConfig_t *)malloc(sizeof(rtMallocConfig_t));
    rtMallocAttribute_t* mallocAttrs = new rtMallocAttribute_t[1];
    malloCfg->numAttrs = 1;
    malloCfg->attrs = mallocAttrs;

    // UVA类型，但是value为0，默认不启用特性
    mallocAttrs[0].attr = RT_MEM_MALLOC_ATTR_VA_FLAG;
    mallocAttrs[0].value.vaFlag = 0;
    error = apiDecorator_->HostMallocWithCfg(&hostPtr, 60, malloCfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = apiDecorator_->HostFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // UVA类型，value设置为1，启用特性
    mallocAttrs[0].value.vaFlag = 1;
    error = apiDecorator_->HostMallocWithCfg(&hostPtr, 60, malloCfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = apiDecorator_->HostFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete[] mallocAttrs;
    free(malloCfg);
    delete apiDecorator_;
}
