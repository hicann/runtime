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
#include "device.hpp"
#include "raw_device.hpp"
#include "stream.hpp"
#include "runtime.hpp"
#include "npu_driver.hpp"
#include "context.hpp"
#include "api_error.hpp"
#include "api_impl.hpp"

using namespace cce::runtime;
class ApiTest : public testing::Test {
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

TEST_F(ApiTest, SetOpWaitTimeOut_test)
{
    Device *device = ((Runtime *)Runtime::Instance())->GetDevice(0, 0);
    rtError_t ret = rtSetOpWaitTimeOut(10);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTest, notify_wait_timeout)
{
    rtError_t error;
    rtStream_t streamA;
    uint64_t buff_size = 100;
 
    error = rtStreamCreate(&streamA, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtNotify_t notify;
    
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    
    device->SetTschVersion(TS_VERSION_WAIT_TIMEOUT_DC);
    error = rtSetOpWaitTimeOut(3);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtNotifyCreate(0, &notify);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtNotifyWait(notify, streamA);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamSynchronize(streamA);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->SetTschVersion(version);
    error = rtStreamDestroy(streamA);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtNotifyDestroy(notify);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiTest, GROUP_INFO_1)
{
    rtError_t error;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    Device* dev = rtInstance->GetDevice(0, 0);
    dev->GroupInfoSetup();

    error = rtSetGroup(0);
    EXPECT_EQ(error, ACL_ERROR_RT_GROUP_NOT_CREATE);
                
    error = rtSetGroup(2);
    EXPECT_EQ(error, ACL_ERROR_RT_GROUP_NOT_CREATE);

    error = rtSetGroup(1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t count = 0;
    error = rtGetGroupCount(&count);
    EXPECT_EQ(error, RT_ERROR_NONE);
                                                     
    rtGroupInfo_t groupInfo[count];
    error = rtGetGroupInfo(-1, groupInfo, count);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetGroupInfo(3, groupInfo, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetGroupInfo(-10, groupInfo, 1);
    EXPECT_EQ(error, ACL_ERROR_RT_GROUP_NOT_CREATE);
}

TEST_F(ApiTest, GROUP_INF)
{
    rtError_t error;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device* dev = rtInstance->GetDevice(0, 0);

    error = rtSetGroup(1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t count = 0;
    error = rtGetGroupCount(&count);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtGroupInfo_t groupInfo[count];
    error = rtGetGroupInfo(-1, groupInfo, count);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, StreamRecoverNotSupport)
{
    ApiImpl api;
    ApiErrorDecorator apiErrorDec(&api);
    rtStream_t stream;
    Stream * stream_ = nullptr;
    rtError_t error = RT_ERROR_NONE;
    
    error = rtStreamCreate(&stream, 0);
    stream_ = (Stream *)stream;
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiErrorDec.StreamRecover(stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtStreamDestroy(stream);
}

TEST_F(ApiTest, rtLaunchKernelExByFuncHandle)
{
    rtError_t error = RT_ERROR_NONE;

    size_t argsSize = sizeof(uint64_t) * 3;
    size_t hostInfoTotalSize = 1024;
    size_t launchArgsSize;
    size_t hostInfoNum = 2;
    error = rtCalcLaunchArgsSize(argsSize, hostInfoTotalSize, hostInfoNum, &launchArgsSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
    char* argsData = new (std::nothrow) char[launchArgsSize]();
    rtLaunchArgsHandle argsHandle = nullptr;
    error = rtCreateLaunchArgs(argsSize, hostInfoTotalSize, hostInfoNum, static_cast<void*>(argsData), &argsHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    size_t intput1 = 1;
    size_t intput2 = 2;
    size_t outpput1 = 3;
    void *addrInfo = static_cast<void *>(&intput1);
    error = rtAppendLaunchAddrInfo(argsHandle, addrInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
    addrInfo = static_cast<void *>(&intput2);
    error = rtAppendLaunchAddrInfo(argsHandle, addrInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
    addrInfo = static_cast<void *>(&outpput1);
    error = rtAppendLaunchAddrInfo(argsHandle, addrInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
    size_t hostInfoSize = 256;
    void *hostInfo = nullptr;
    error = rtAppendLaunchHostInfo(argsHandle, hostInfoSize, &hostInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t blockDim = 32;
    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    ((Stream *)stream)->SetSqMemAttr(false);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtLaunchAttribute_t* attrs = (rtLaunchAttribute_t*)malloc(sizeof(rtLaunchAttribute_t) *
        (RT_LAUNCH_ATTRIBUTE_MAX + 1));
    attrs[0].id = RT_LAUNCH_ATTRIBUTE_BLOCKDIM;
    attrs[0].value.blockDim = 1;

    attrs[1].id = RT_LAUNCH_ATTRIBUTE_DYNAMIC_SHARE_MEM_SIZE;
    attrs[1].value.dynamicShareMemSize = 12U * 1024U;

    attrs[2].id = RT_LAUNCH_ATTRIBUTE_GROUP;
    attrs[2].value.Group.groupDim = 2U;
    attrs[2].value.Group.groupBlockDim = 10U;

    attrs[3].id = RT_LAUNCH_ATTRIBUTE_QOS;
    attrs[3].value.qos = 1;

    attrs[4].id = RT_LAUNCH_ATTRIBUTE_PARTID;
    attrs[4].value.partId = 1;

    attrs[5].id = RT_LAUNCH_ATTRIBUTE_SCHEMMODE;
    attrs[5].value.schemMode  = 0;

    attrs[6].id = RT_LAUNCH_ATTRIBUTE_BLOCKDIM_OFFSET;
    attrs[6].value.blockDimOffset = 20;

    attrs[7].id = RT_LAUNCH_ATTRIBUTE_DUMPFLAG;
    attrs[7].value.dumpflag = 1;

    rtLaunchConfig_t launchConfig = {};
    launchConfig.numAttrs = RT_LAUNCH_ATTRIBUTE_MAX;
    launchConfig.attrs = attrs;

    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1;
    Kernel *kernel = new Kernel(&fun1, "f1", "", program, 10);

    error = rtLaunchKernelExByFuncHandle(nullptr, &launchConfig, argsHandle, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtLaunchKernelExByFuncHandle(kernel, nullptr, argsHandle, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtLaunchKernelExByFuncHandle(kernel, &launchConfig, nullptr, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtLaunchKernelExByFuncHandle(kernel, &launchConfig, argsHandle, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    attrs[5].value.schemMode = 3;
    error = rtLaunchKernelExByFuncHandle(kernel, &launchConfig, argsHandle, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    attrs[5].value.schemMode = 0;

    attrs[0].value.blockDim = 0x10000U;
    error = rtLaunchKernelExByFuncHandle(kernel, &launchConfig, argsHandle, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    attrs[0].value.blockDim = 0U;
    attrs[2].value.Group.groupDim = 0U;
    attrs[2].value.Group.groupBlockDim = 1U;
    error = rtLaunchKernelExByFuncHandle(kernel, &launchConfig, argsHandle, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    attrs[2].value.Group.groupBlockDim = 0U;
    error = rtLaunchKernelExByFuncHandle(kernel, &launchConfig, argsHandle, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    attrs[2].value.Group.groupDim = 512U;
    attrs[2].value.Group.groupBlockDim = 128U;
    error = rtLaunchKernelExByFuncHandle(kernel, &launchConfig, argsHandle, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    attrs[0].value.blockDim = 1U;
    attrs[2].value.Group.groupDim = 2U;
    attrs[2].value.Group.groupBlockDim = 10U;

    attrs[8].id = RT_LAUNCH_ATTRIBUTE_MAX;
    attrs[8].value.dumpflag = 1;
    launchConfig.numAttrs = RT_LAUNCH_ATTRIBUTE_MAX + 1;
    launchConfig.attrs = attrs;

    error = rtLaunchKernelExByFuncHandle(kernel, &launchConfig, argsHandle, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtDestroyLaunchArgs(argsHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete[] argsData;
    free(attrs);
    delete kernel;
}
