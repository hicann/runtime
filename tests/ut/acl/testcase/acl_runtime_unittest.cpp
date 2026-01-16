/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string>
#include <cassert>
#include <iostream>

#include "acl/acl.h"
#include "common/log_inner.h"
#include "acl/acl_rt.h"
#include "acl_rt_impl_base.h"

#include "set_device_vxx.h"
#include "runtime/dev.h"
#include "runtime/stream.h"
#include "runtime/context.h"
#include "runtime/event.h"
#include "runtime/mem.h"
#include "runtime/rts/rts_mem.h"
#include "runtime/kernel.h"
#include "runtime/base.h"
#include "runtime/config.h"
#include "acl/acl_rt_allocator.h"
#include "acl_stub.h"
#define private public
#include "aclrt_impl/init_callback_manager.h"
#undef private

#include <gtest/gtest.h>
#include <gmock/gmock.h>

using namespace testing;
using namespace std;
using namespace acl;

namespace acl {
extern void resetAclJsonHash();
}

class UTEST_ACL_Runtime : public testing::Test
{
protected:
    void SetUp() override
    {
        MockFunctionTest::aclStubInstance().ResetToDefaultMock();
        ON_CALL(MockFunctionTest::aclStubInstance(), GetPlatformResWithLock(_, _))
            .WillByDefault(Return(true));
        resetAclJsonHash();
    }
    void TearDown() override
    {
        Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));
    }
};

extern aclError MemcpyKindTranslate(aclrtMemcpyKind kind, rtMemcpyKind_t &rtKind);

rtError_t rtEventQueryWaitStatus_Invoke(rtEvent_t event, rtEventWaitStatus *status)
{
    (void) event;
    *status = EVENT_STATUS_COMPLETE;
    return RT_ERROR_NONE;
}

rtError_t rtEventQueryWaitStatus_Invoke2(rtEvent_t event, rtEventWaitStatus *status)
{
    (void) event;
    *status = EVENT_STATUS_NOT_READY;
    return RT_ERROR_NONE;
}

rtError_t rtEventQueryStatus_Invoke(rtEvent_t event, rtEventStatus *status)
{
    (void) event;
    *status = RT_EVENT_INIT;
    return RT_ERROR_NONE;
}

rtError_t rtEventQueryStatus_Invoke2(rtEvent_t event, rtEventStatus *status)
{
    (void) event;
    *status = RT_EVENT_RECORDED;
    return RT_ERROR_NONE;
}

rtError_t rtMalloc1g(void **devPtr, uint64_t size, rtMemType_t type, uint16_t moduleId) {
    (void) devPtr;
    (void) moduleId;
    std::cout << "call rtMalloc1g" << std::endl;
    if (size != 1024UL * 1024UL * 1024UL) {
        return -1;
    }
    if (type == 0x10000U || type == 0x20000U) {
        return 0;
    }

    return -1;
}

rtError_t rtMallocPhysical1g(rtDrvMemHandle *handle, size_t size, rtDrvMemProp_t *prop, uint64_t flags) {
    (void) handle;
    (void) flags;
    std::cout << "call rtMallocPhysical1g" << std::endl;
    if (size != 1024UL * 1024UL * 1024UL) {
        return -1;
    }
    if (prop->pg_type == 2) {
        return 0;
    }
    return -1;
}

aclError InitCallback_Success(const char *configStr, size_t len, void *userData) {
    (void)configStr;
    (void)len;
    (void)userData;
    return ACL_SUCCESS;
}

aclError InitCallback_Fail(const char *configStr, size_t len, void *userData) {
    (void)configStr;
    (void)len;
    (void)userData;
    return ACL_ERROR_FAILURE;
}

aclError FinalizeCallback_Success(void *userData) {
    (void)userData;
    return ACL_SUCCESS;
}

aclError FinalizeCallback_Fail(void *userData) {
    (void)userData;
    return ACL_ERROR_FAILURE;
}

TEST_F(UTEST_ACL_Runtime, aclrtSetDeviceFailedTest)
{
    int32_t deviceId = 1;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetDevice(_))
        .WillOnce(Return(ACL_ERROR_RT_INVALID_DEVICEID));
    aclError ret = aclrtSetDevice(deviceId);
    EXPECT_EQ(ret, ACL_ERROR_RT_INVALID_DEVICEID);
}

TEST_F(UTEST_ACL_Runtime, UpdatePlatformInfoTest)
{
    int32_t deviceId = 99;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), InitRuntimePlatformInfos(_))
        .WillOnce(Return(1))
        .WillRepeatedly(Return(0));
    auto ret = aclrtSetDevice(deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetAiCoreCount(_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID))
        .WillRepeatedly(Return(RT_ERROR_NONE));
    ret = aclrtSetDevice(deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDeviceInfo(_, _, _, _))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID))
        .WillOnce(Return(RT_ERROR_NONE))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID))
        .WillRepeatedly(Return(RT_ERROR_NONE));
    ret = aclrtSetDevice(deviceId); // get vector num fail
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtSetDevice(deviceId); // get cube core num fail
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), GetRuntimePlatformInfosByDevice(_, _))
        .WillOnce(Return(1))
        .WillRepeatedly(Return(0));
    ret = aclrtSetDevice(deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), GetPlatformResWithLock(_, _))
        .WillOnce(Return(false))
        .WillRepeatedly(Return(true));
    ret = aclrtSetDevice(deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), UpdateRuntimePlatformInfosByDevice(_, _))
        .WillOnce(Return(1));
    ret = aclrtSetDevice(deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), InitRuntimePlatformInfos(_))
        .WillOnce(Return(1));
    aclrtContext ctx;
    ret = aclrtCreateContext(&ctx, 98); // 98：special deviceid
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetDeviceSuccessTest)
{
    //ensure ut cover two functions below
    string testStr = "test";
    acl::AclErrorLogManager::ReportInnerError("%s", testStr.c_str());
    acl::AclErrorLogManager::ReportCallError("%s", testStr.c_str());

    int32_t deviceId = 0;
    aclError ret = aclrtSetDevice(deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtResetDeviceTest)
{
    int32_t deviceId = 0;
    aclError ret = aclrtResetDevice(deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceReset(_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtResetDevice(deviceId);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtResetDeviceForceTest)
{
    int32_t deviceId = 0;
    aclError ret = aclrtResetDeviceForce(deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceResetForce(_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID))
        .WillOnce(Return(ACL_SUCCESS));
    ret = aclrtResetDeviceForce(deviceId);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    ret = aclrtSetDevice(deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtSetDevice(deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtResetDeviceForce(deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceReset(_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtResetDevice(deviceId);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetDeviceWithoutTsdVXXTest)
{
    int32_t deviceId = 0;
    aclError ret = aclrtSetDeviceWithoutTsdVXX(deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetDeviceWithoutTsd(_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtSetDeviceWithoutTsdVXX(deviceId);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtResetDeviceWithoutTsdVXXTest)
{
    int32_t deviceId = 0;
    aclError ret = aclrtResetDeviceWithoutTsdVXX(deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceResetWithoutTsd(_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtResetDeviceWithoutTsdVXX(deviceId);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetDeviceTest)
{
    int32_t deviceId = 0;
    aclError ret = aclrtGetDevice(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtGetDevice(&deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDevice(_))
        .WillRepeatedly(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtGetDevice(&deviceId);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetLogicDevIdByUserDevIdTest)
{
    int32_t userDevid = 0;
    int32_t logicDevId;
    aclError ret = aclrtGetLogicDevIdByUserDevId(userDevid, &logicDevId);
    EXPECT_EQ(ret, ACL_SUCCESS);


    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsGetLogicDevIdByUserDevId(_,_))
        .WillRepeatedly(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtGetLogicDevIdByUserDevId(userDevid, &logicDevId);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetUserDevIdByLogicDevIdTest)
{
    int32_t logicDevId = 0;
    int32_t userDevid;
    aclError ret = aclrtGetUserDevIdByLogicDevId(logicDevId, &userDevid);
    EXPECT_EQ(ret, ACL_SUCCESS);


    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsGetUserDevIdByLogicDevId(_,_))
        .WillRepeatedly(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtGetUserDevIdByLogicDevId(logicDevId, &userDevid);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetLogicDevIdByPhyDevIdTest)
{
    int32_t phyDevId = 0;
    int32_t logicDevId;
    aclError ret = aclrtGetLogicDevIdByPhyDevId(phyDevId, &logicDevId);
    EXPECT_EQ(ret, ACL_SUCCESS);


    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsGetLogicDevIdByPhyDevId(_,_))
        .WillRepeatedly(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtGetLogicDevIdByPhyDevId(phyDevId, &logicDevId);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetPhyDevIdByLogicDevIdTest)
{
    int32_t logicDevId = 0;
    int32_t phyDevId;
    aclError ret = aclrtGetPhyDevIdByLogicDevId(logicDevId, &phyDevId);
    EXPECT_EQ(ret, ACL_SUCCESS);


    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsGetPhyDevIdByLogicDevId(_,_))
        .WillRepeatedly(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtGetPhyDevIdByLogicDevId(logicDevId, &phyDevId);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtSynchronizeDeviceTest)
{
    aclError ret =  aclrtSynchronizeDevice();
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceSynchronize())
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtSynchronizeDevice();
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtSynchronizeDevice_succ)
{
    int32_t timeout = 1;
    aclError ret =  aclrtSynchronizeDeviceWithTimeout(timeout);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtSynchronizeDevice_with_invalid_timeout)
{
    int32_t timeout = -2;
    aclError ret =  aclrtSynchronizeDeviceWithTimeout(timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}


TEST_F(UTEST_ACL_Runtime, aclrtSynchronizeDevice_with_timeout)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceSynchronizeWithTimeout(_))
        .WillOnce(Return((ACL_ERROR_RT_STREAM_SYNC_TIMEOUT)));
    int32_t timeout = 1;
    aclError ret = aclrtSynchronizeDeviceWithTimeout(timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_STREAM_SYNC_TIMEOUT);
}

TEST_F(UTEST_ACL_Runtime, aclrtSynchronizeDevice_with_rts_fail)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceSynchronizeWithTimeout(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    int32_t timeout = 1;
    aclError ret = aclrtSynchronizeDeviceWithTimeout(timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetRunModeTest)
{
    aclrtRunMode runMode;
    aclError ret = aclrtGetRunMode(&runMode);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetRunMode(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtGetRunMode(&runMode);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetTsDeviceTest)
{
    aclrtTsId tsId = ACL_TS_ID_RESERVED;
    aclError ret = aclrtSetTsDevice(tsId);
    EXPECT_NE(ret, ACL_SUCCESS);

    tsId = ACL_TS_ID_AICORE;
    ret = aclrtSetTsDevice(tsId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetTSDevice(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtSetTsDevice(tsId);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetDeviceCountTest)
{
    uint32_t count = 0;
    aclError ret = aclrtGetDeviceCount(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtGetDeviceCount(&count);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDeviceCount(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtGetDeviceCount(&count);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCreateContextTest)
{
    aclrtContext context = (aclrtContext)0x01;
    int32_t deviceId = 0;
    // aclrtCreateContext
    aclError ret = aclrtCreateContext(&context, deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtCreateContext(nullptr, deviceId);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtCtxCreateEx(_, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtCreateContext(&context, deviceId);
    EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtDestroyContextTest)
{
    // aclrtDestroyContext
    aclrtContext context = (aclrtContext)0x01;
    aclError ret = aclrtDestroyContext(context);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtDestroyContext(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtCtxDestroyEx(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtDestroyContext(context);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetCurrentContextTest)
{
    // aclrtSetCurrentContext
    aclrtContext context = (aclrtContext)0x01;
    aclError ret = aclrtSetCurrentContext(context);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtSetCurrentContext(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtCtxSetCurrent(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtSetCurrentContext(context);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetCurrentContextTest)
{
    // aclrtGetCurrentContext
    aclrtContext context = (aclrtContext)0x01;
    aclError ret = aclrtGetCurrentContext(&context);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtGetCurrentContext(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtCtxGetCurrent(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtGetCurrentContext(&context);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCreateStreamTest)
{
    // test aclrtCreateStream
    aclrtStream stream = (aclrtStream)0x01;
    aclError ret = aclrtCreateStream(&stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtCreateStream(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamCreate(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtCreateStream(&stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCreateStreamWithConfigTest)
{
    // test aclrtCreateStreamWithConfig
    aclrtStream stream = (aclrtStream)0x01;
    uint32_t priority = 0u;
    uint32_t flag = ACL_STREAM_FAST_LAUNCH;
    aclError ret = aclrtCreateStreamWithConfig(&stream, priority, flag);
    EXPECT_EQ(ret, ACL_SUCCESS);

    flag |= ACL_STREAM_FAST_SYNC;
    ret = aclrtCreateStreamWithConfig(&stream, priority, flag);
    EXPECT_EQ(ret, ACL_SUCCESS);

    flag = ACL_STREAM_PERSISTENT;
    ret = aclrtCreateStreamWithConfig(&stream, priority, flag);
    EXPECT_EQ(ret, ACL_SUCCESS);

    flag = ACL_STREAM_HUGE;
    ret = aclrtCreateStreamWithConfig(&stream, priority, flag);
    EXPECT_EQ(ret, ACL_SUCCESS);

    flag = ACL_STREAM_CPU_SCHEDULE;
    ret = aclrtCreateStreamWithConfig(&stream, priority, flag);
    EXPECT_EQ(ret, ACL_SUCCESS);

    flag = ACL_STREAM_DEVICE_USE_ONLY;
    ret = aclrtCreateStreamWithConfig(&stream, priority, flag);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtCreateStreamWithConfig(nullptr, priority, flag);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    // priority is supported with value(0~7)
    ret = aclrtCreateStreamWithConfig(&stream, 1, flag);
    EXPECT_EQ(ret, ACL_SUCCESS);

    // 8 is out of range, priority will be adjusted to 7
    ret = aclrtCreateStreamWithConfig(&stream, 8, flag);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtDestroyStreamTest)
{
    // test aclrtDestroyStream
    aclrtStream stream = (aclrtStream)0x01;
    aclError ret = aclrtDestroyStream(stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtDestroyStream(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamDestroy(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtDestroyStream(stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtDestroyStreamForceTest)
{
    // test aclrtDestroyStreamForce
    aclrtStream stream = (aclrtStream)0x01;
    aclError ret = aclrtDestroyStreamForce(stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtDestroyStreamForce(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamDestroyForce(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtDestroyStreamForce(stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtSynchronizeStreamTest)
{
    // test aclrtSynchronizeStream
    aclrtStream stream = (aclrtStream)0x01;
    aclError ret = aclrtSynchronizeStream(stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtSynchronizeStream(nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamSynchronize(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtSynchronizeStream(stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamSynchronize(_))
        .WillOnce(Return((ACL_ERROR_RT_END_OF_SEQUENCE)));
    ret = aclrtSynchronizeStream(stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_END_OF_SEQUENCE);
}

TEST_F(UTEST_ACL_Runtime, aclrtSynchronizeStreamWithTimeoutTest)
{
    // test aclrtSynchronizeStreamWithTimeout
    aclrtStream stream = (aclrtStream)0x01;
    int32_t timeout = 100;
    aclError ret = aclrtSynchronizeStreamWithTimeout(stream, timeout);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtSynchronizeStreamWithTimeout(nullptr, timeout);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamSynchronizeWithTimeout(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtSynchronizeStreamWithTimeout(nullptr, timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamSynchronizeWithTimeout(_, _))
        .WillOnce(Return((ACL_ERROR_RT_STREAM_SYNC_TIMEOUT)));
    ret = aclrtSynchronizeStreamWithTimeout(stream, timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_STREAM_SYNC_TIMEOUT);

    timeout = -2;
    ret = aclrtSynchronizeStreamWithTimeout(stream, timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    timeout = 2; // timeout
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamSynchronizeWithTimeout(_, _))
        .WillOnce(Return((ACL_ERROR_RT_END_OF_SEQUENCE)));
    ret = aclrtSynchronizeStreamWithTimeout(stream, timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_END_OF_SEQUENCE);
}

TEST_F(UTEST_ACL_Runtime, aclrtStreamQueryTest)
{
    // test aclrtStreamQuery
    aclrtStream stream = (aclrtStream)0x01;
    aclrtStreamStatus status;

    aclError ret = aclrtStreamQuery(stream, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamQuery(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtStreamQuery(stream, &status);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamQuery(_))
        .WillOnce(Return((RT_ERROR_NONE)));
    ret = aclrtStreamQuery(stream, &status);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(status, ACL_STREAM_STATUS_COMPLETE);
    
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamQuery(_))
        .WillOnce(Return((ACL_ERROR_RT_STREAM_NOT_COMPLETE)));
    ret = aclrtStreamQuery(stream, &status);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(status, ACL_STREAM_STATUS_NOT_READY);
}

TEST_F(UTEST_ACL_Runtime, aclrtStreamGetPriorityTest)
{
    // test aclrtStreamGetPriority
    aclrtStream stream = (aclrtStream)0x01;
    uint32_t priority;

    aclError ret = aclrtStreamGetPriority(nullptr, &priority);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtStreamGetPriority(stream, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamGetPriority(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtStreamGetPriority(stream, &priority);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamGetPriority(_, _))
        .WillOnce(DoAll(SetArgPointee<1>(5), Return(RT_ERROR_NONE)));
    ret = aclrtStreamGetPriority(stream, &priority);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(priority, 5);
}

TEST_F(UTEST_ACL_Runtime, aclrtStreamGetFlagsTest)
{
    // test aclrtStreamGetFlags
    aclrtStream stream = (aclrtStream)0x01;
    uint32_t flags;

    aclError ret = aclrtStreamGetFlags(nullptr, &flags);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtStreamGetFlags(stream, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamGetFlags(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtStreamGetFlags(stream, &flags);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamGetFlags(_, _))
        .WillOnce(DoAll(SetArgPointee<1>(RT_STREAM_FAST_LAUNCH), Return(RT_ERROR_NONE)));
    ret = aclrtStreamGetFlags(stream, &flags);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(flags, ACL_STREAM_FAST_LAUNCH);
}

TEST_F(UTEST_ACL_Runtime, aclrtStreamWaitEventTest)
{
    // test aclrtStreamWaitEvent
    aclrtStream stream = (aclrtStream)0x01;
    aclrtEvent event = (aclrtEvent)0x01;
    aclError ret = aclrtStreamWaitEvent(stream, event);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtStreamWaitEvent(nullptr, event);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamWaitEvent(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtStreamWaitEvent(stream, event);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtStreamWaitEventWithTimeoutTest)
{
    aclrtStream stream = (aclrtStream)0x01;
    aclrtEvent event = (aclrtEvent)0x01;
    int32_t timeout = -1;
    
    aclError ret = aclrtStreamWaitEventWithTimeout(stream, event, timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    timeout = 1;
    ret = aclrtStreamWaitEventWithTimeout(stream, event, timeout);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtStreamWaitEventWithTimeout(nullptr, event, timeout);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsEventWait(_, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtStreamWaitEventWithTimeout(stream, event, timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtIpcGetEventHandleTest)
{
    aclrtIpcEventHandle handle;
    aclrtEvent event = (aclrtEvent)0x01;
    aclError ret = aclrtIpcGetEventHandle(event, &handle);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtIpcGetEventHandle(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtIpcGetEventHandle(event, &handle);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtIpcGetEventHandle(_, _))
        .WillOnce(Return((ACL_ERROR_RT_FEATURE_NOT_SUPPORT)));
    ret = aclrtIpcGetEventHandle(event, &handle);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(UTEST_ACL_Runtime, aclrtIpcOpenEventHandleTest)
{
    aclrtIpcEventHandle handle;
    (void)memset_s(handle.reserved, ACL_IPC_EVENT_HANDLE_SIZE, 0, ACL_IPC_EVENT_HANDLE_SIZE);
    aclrtEvent event;
    aclError ret = aclrtIpcOpenEventHandle(handle, &event);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtIpcOpenEventHandle(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtIpcOpenEventHandle(handle, &event);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtIpcOpenEventHandle(_, _))
        .WillOnce(Return((ACL_ERROR_RT_FEATURE_NOT_SUPPORT)));
    ret = aclrtIpcOpenEventHandle(handle, &event);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetStreamFailureMode_DSTest)
{
  aclError ret = aclrtSetStreamFailureMode(nullptr, ACL_STOP_ON_FAILURE);
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamSetMode(_, _))
  .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
  ret = aclrtSetStreamFailureMode(nullptr, ACL_STOP_ON_FAILURE);
  EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetStreamFailureMode_DCTest)
{
  aclError ret = aclrtSetStreamFailureMode(nullptr, ACL_CONTINUE_ON_FAILURE);
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamSetMode(_, _))
  .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
  ret = aclrtSetStreamFailureMode(nullptr, ACL_CONTINUE_ON_FAILURE);
  EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetStreamFailureMode_STest)
{
  aclrtStream stream = (aclrtStream)0x01;
  aclError ret = aclrtCreateStream(&stream);
  EXPECT_EQ(ret, ACL_SUCCESS);
  ret = aclrtSetStreamFailureMode(stream, ACL_STOP_ON_FAILURE);
  EXPECT_EQ(ret, ACL_SUCCESS);

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamSetMode(_, _))
  .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
  ret = aclrtSetStreamFailureMode(stream, ACL_STOP_ON_FAILURE);
  EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetStreamFailureMode_CTest)
{
  aclrtStream stream = (aclrtStream)0x01;
  aclError ret = aclrtCreateStream(&stream);
  EXPECT_EQ(ret, ACL_SUCCESS);
  ret = aclrtSetStreamFailureMode(stream, ACL_CONTINUE_ON_FAILURE);
  EXPECT_EQ(ret, ACL_SUCCESS);

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamSetMode(_, _))
  .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
  ret = aclrtSetStreamFailureMode(stream, ACL_CONTINUE_ON_FAILURE);
  EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtStreamAbortTest)
{
    aclrtStream stream = (aclrtStream)0x01;
    aclError ret = aclrtStreamAbort(stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtStreamAbort(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamAbort(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtStreamAbort(stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCreateEventTest)
{
    aclrtEvent event = (aclrtEvent)0x01;
    // aclrtCreateEvent
    aclError ret = aclrtCreateEvent(&event);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtCreateEvent(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventCreate(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtCreateEvent(&event);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtDestroyEventTest)
{
    // aclrtDestroyEvent
    aclrtEvent event = (aclrtEvent)0x01;
    aclError ret = aclrtDestroyEvent(event);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtDestroyEvent(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventDestroy(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtDestroyEvent(event);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtRecordEventTest)
{
    // aclrtRecordEvent(aclrtEvent event, aclrtStream stream)
    aclrtEvent event = (aclrtEvent)0x01;
    aclrtStream stream = (aclrtStream)0x01;
    aclError ret = aclrtRecordEvent(event, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtRecordEvent(nullptr, stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventRecord(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtRecordEvent(event, stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtResetEventTest)
{
    // aclrtResetEvent
    aclrtEvent event = (aclrtEvent)0x01;
    aclrtStream stream = (aclrtStream)0x01;
    aclError ret = aclrtResetEvent(event, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtResetEvent(nullptr, stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventReset(_, _))
        .WillRepeatedly(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtResetEvent(event, stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtQueryEventWaitStatusTest)
{
    //aclrtQueryEventWaitStatus
    aclrtEvent event = (aclrtEvent)0x01;
    aclrtEventWaitStatus status;
    aclError ret = aclrtQueryEventWaitStatus(nullptr, &status);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtQueryEventWaitStatus(event, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventQueryWaitStatus(_,_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret =  aclrtQueryEventWaitStatus(event, &status);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventQueryWaitStatus(_,_))
        .WillOnce(Invoke(rtEventQueryWaitStatus_Invoke));
    ret =  aclrtQueryEventWaitStatus(event, &status);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(status, ACL_EVENT_WAIT_STATUS_COMPLETE);

   EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventQueryWaitStatus(_,_))
        .WillOnce(Invoke(rtEventQueryWaitStatus_Invoke2));
    ret =  aclrtQueryEventWaitStatus(event, &status);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(status, ACL_EVENT_WAIT_STATUS_NOT_READY);
}

TEST_F(UTEST_ACL_Runtime, aclrtQueryEventStatusTest)
{
    //aclrtQueryEventStatus
    aclrtEvent event = (aclrtEvent)0x01;
    aclrtEventRecordedStatus status;
    aclError ret = aclrtQueryEventStatus(nullptr, &status);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtQueryEventStatus(event, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventQueryStatus(_,_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret =  aclrtQueryEventStatus(event, &status);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventQueryStatus(_,_))
        .WillOnce(Invoke(rtEventQueryStatus_Invoke));
    ret =  aclrtQueryEventStatus(event, &status);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(status, ACL_EVENT_RECORDED_STATUS_NOT_READY);

   EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventQueryStatus(_,_))
        .WillOnce(Invoke(rtEventQueryStatus_Invoke2));
    ret =  aclrtQueryEventStatus(event, &status);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(status, ACL_EVENT_RECORDED_STATUS_COMPLETE);
}

TEST_F(UTEST_ACL_Runtime, aclrtQueryEventTest)
{
    // aclrtQueryEvent
    aclrtEvent event = (aclrtEvent)0x01;
    aclrtEventStatus status;
    aclError ret = aclrtResetEvent(nullptr, &status);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventReset(_, _))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtResetEvent(event, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    ret = aclrtQueryEvent(event, &status);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(status, ACL_EVENT_STATUS_COMPLETE);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventQuery(_))
        .WillOnce(Return((ACL_ERROR_RT_EVENT_NOT_COMPLETE)));
    ret =  aclrtQueryEvent(event, &status);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(status, ACL_EVENT_STATUS_NOT_READY);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventQuery(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtQueryEvent(event, &status);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtSynchronizeEventTest)
{
    // aclrtSynchronizeEvent
    aclrtEvent event = (aclrtEvent)0x01;
    aclError ret = aclrtSynchronizeEvent(event);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtSynchronizeEvent(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventSynchronize(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtSynchronizeEvent(event);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtSynchronizeEventWithTimeoutTest)
{
    // aclrtSynchronizeEventWithTimeout
    aclrtEvent event = (aclrtEvent)0x01;
    int32_t timeout = 100;
    aclError ret = aclrtSynchronizeEventWithTimeout(event, timeout);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtSynchronizeEventWithTimeout(nullptr, timeout);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventSynchronizeWithTimeout(_,_))
            .WillOnce(Return((ACL_ERROR_RT_EVENT_SYNC_TIMEOUT)));
    ret = aclrtSynchronizeEventWithTimeout(event, timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_EVENT_SYNC_TIMEOUT);

    timeout = -2;
    ret = aclrtSynchronizeEventWithTimeout(event, timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCreateEventWithFlagTest)
{
    uint32_t flag = 0x00000008u;
    aclError ret;
    aclrtEvent event = (aclrtEvent)0x01;

    ret = aclrtCreateEventWithFlag(nullptr, flag);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtCreateEventWithFlag(&event, flag);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventCreateWithFlag(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtCreateEventWithFlag(&event, flag);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCreateEventExWithFlagTest)
{
    uint32_t flag = 0x00000008u;
    aclError ret;
    aclrtEvent event = (aclrtEvent)0x01;

    ret = aclrtCreateEventExWithFlag(nullptr, flag);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtCreateEventExWithFlag(&event, flag);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventCreateExWithFlag(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtCreateEventExWithFlag(&event, flag);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventCreateExWithFlag(_, _))
        .WillOnce(Return((ACL_ERROR_RT_FEATURE_NOT_SUPPORT)));
    ret = aclrtCreateEventExWithFlag(&event, flag);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(UTEST_ACL_Runtime, aclrtEventElapsedTimeTest)
{
    // aclrtEventElapsedTime
    float time = 0.0f;
    aclError ret;
    aclrtEvent start = (aclrtEvent)0x01;
    aclrtEvent end = (aclrtEvent)0x01;

    ret = aclrtEventElapsedTime(nullptr, start, end);
    EXPECT_NE(ret, ACL_SUCCESS);
    ret = aclrtEventElapsedTime(&time, nullptr, end);
    EXPECT_NE(ret, ACL_SUCCESS);
    ret = aclrtEventElapsedTime(&time, start, nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtEventElapsedTime(&time, start, end);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventElapsedTime(_, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtEventElapsedTime(&time, start, end);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtEventGetTimestamp)
{
    uint64_t ts = 0;
    aclrtEvent event = aclrtEvent(&ts);
    EXPECT_EQ(aclrtEventGetTimestamp(event, nullptr), ACL_ERROR_INVALID_PARAM);
    EXPECT_EQ(aclrtEventGetTimestamp(nullptr, &ts), ACL_ERROR_INVALID_PARAM);
    EXPECT_EQ(aclrtEventGetTimestamp(event, &ts), ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetOpWaitTimeout)
{
    uint32_t timeout = 3;
    aclError ret = aclrtSetOpWaitTimeout(timeout);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetOpWaitTimeOut(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtSetOpWaitTimeout(timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

void CallBackFuncStub(void *arg)
{
    (void) arg;
    int a = 1;
    a++;
}

TEST_F(UTEST_ACL_Runtime, aclrtSubscribeReportTest)
{
    aclError ret;
    aclrtStream stream = (aclrtStream)0x01;
    ret = aclrtSubscribeReport(1, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtUnSubscribeReportTest)
{
    aclrtStream stream = (aclrtStream)0x01;
    aclError ret = aclrtUnSubscribeReport(1, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtUnSubscribeReport(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    EXPECT_EQ(aclrtUnSubscribeReport(1, stream), ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtLaunchCallbackTest)
{
    aclrtStream stream = (aclrtStream)0x01;
    aclError ret = aclrtLaunchCallback(CallBackFuncStub, nullptr, ACL_CALLBACK_BLOCK, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtLaunchCallback(CallBackFuncStub, nullptr, static_cast<aclrtCallbackBlockType>(2), stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtCallbackLaunch(_, _, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtLaunchCallback(CallBackFuncStub, nullptr, ACL_CALLBACK_BLOCK, stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtLaunchHostFuncTest)
{
    aclrtStream stream = (aclrtStream)0x01;
    aclError ret = aclrtLaunchHostFunc(stream, CallBackFuncStub, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsLaunchHostFunc(_, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtLaunchHostFunc(stream, CallBackFuncStub, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtProcessReportTest)
{
    // timeout value is invalid
    aclError ret = aclrtProcessReport(0);
    EXPECT_NE(ret, ACL_SUCCESS);

    // aclrtProcessReport success
    ret = aclrtProcessReport(1);
    EXPECT_EQ(ret, ACL_SUCCESS);

    // rtProcessReport failed
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtProcessReport(_))
        .WillOnce(Return((ACL_ERROR_RT_THREAD_SUBSCRIBE)));
    EXPECT_EQ(aclrtProcessReport(1), ACL_ERROR_RT_THREAD_SUBSCRIBE);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtProcessReport(_))
        .WillOnce(Return((ACL_ERROR_RT_REPORT_TIMEOUT)));
    EXPECT_EQ(aclrtProcessReport(1), ACL_ERROR_RT_REPORT_TIMEOUT);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtProcessReport(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    EXPECT_EQ(aclrtProcessReport(1), ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtMalloc_DeviceTest)
{
    void *devPtr = nullptr;
    size_t size = 1;

    aclError ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(devPtr, nullptr);

    ret = aclrtFree(devPtr);
    devPtr = nullptr;
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclrtFree(devPtr);
    devPtr = nullptr;
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMalloc(nullptr, size, ACL_MEM_MALLOC_HUGE_FIRST);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_ONLY);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclrtFree(devPtr);
    devPtr = nullptr;
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclrtFree(devPtr);
    devPtr = nullptr;
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST_P2P);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclrtFree(devPtr);
    devPtr = nullptr;
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_ONLY_P2P);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclrtFree(devPtr);
    devPtr = nullptr;
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY_P2P);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclrtFree(devPtr);
    devPtr = nullptr;
    EXPECT_EQ(ret, ACL_SUCCESS);

    size = static_cast<size_t>(-1);
    ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY);
    EXPECT_NE(ret, ACL_SUCCESS);
    
    size = static_cast<size_t>(0);
    ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY);
    EXPECT_NE(ret, ACL_SUCCESS);

    size = 1;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMalloc(_, _, _, _))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_ONLY);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclMalloc_1GHuge) {
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMalloc(_, _, _, _))
        .WillRepeatedly(Invoke(rtMalloc1g));
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMallocCached(_, _, _, _))
        .WillRepeatedly(Invoke(rtMalloc1g));
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMallocPhysical(_, _, _, _))
        .WillRepeatedly(Invoke(rtMallocPhysical1g));
    void *devPtr = nullptr;
    size_t size = 1024UL * 1024UL * 1024UL;
    auto ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE1G_ONLY);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE1G_ONLY_P2P);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclrtMallocAlign32(&devPtr, size, ACL_MEM_MALLOC_HUGE1G_ONLY);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclrtMallocAlign32(&devPtr, size, ACL_MEM_MALLOC_HUGE1G_ONLY_P2P);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclrtMallocCached(&devPtr, size, ACL_MEM_MALLOC_HUGE1G_ONLY);
    EXPECT_EQ(ret, ACL_SUCCESS);

    aclrtDrvMemHandle handle = nullptr;
    aclrtPhysicalMemProp prop = {};
    prop.handleType = ACL_MEM_HANDLE_TYPE_NONE;
    prop.allocationType = ACL_MEM_ALLOCATION_TYPE_PINNED;
    prop.memAttr = ACL_HBM_MEM_HUGE1G;
    prop.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    prop.location.id = 0;

    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);

    prop.memAttr = ACL_HBM_MEM_P2P_HUGE1G;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtMallocCached_DeviceTest)
{
    void *devPtr = nullptr;
    size_t size = 1;

    aclError ret = aclrtMallocCached(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclrtFree(devPtr);
    devPtr = nullptr;
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMallocCached(&devPtr, size, ACL_MEM_MALLOC_HUGE_ONLY);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclrtFree(devPtr);
    devPtr = nullptr;
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMallocCached(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(devPtr, nullptr);
    ret = aclrtFree(devPtr);
    devPtr = nullptr;
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMallocCached(_, _, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtMallocCached(&devPtr, size, ACL_MEM_MALLOC_HUGE_ONLY);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtMemFlushTest)
{
    // aclrtMemFlush
    void *devPtr = nullptr;
    size_t size = 1;
    aclError ret = aclrtMemFlush(devPtr, size);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    size = 0;
    devPtr = (void *)0x11;
    ret = aclrtMemFlush(devPtr, size);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    size = 1;
    devPtr = (void *)0x11;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtFlushCache(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtMemFlush(devPtr, size);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtMemInvalidateTest)
{
    // aclrtMemInvalidate
    void *devPtr = nullptr;
    size_t size = static_cast<size_t>(1);
    aclError ret = aclrtMemInvalidate(devPtr, size);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    size = static_cast<size_t>(0);
    devPtr = (void *)0x11;
    ret = aclrtMemInvalidate(devPtr, size);
    EXPECT_NE(ret, ACL_SUCCESS);

    size = static_cast<size_t>(-1);
    ret = aclrtMallocCached(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY);
    EXPECT_NE(ret, ACL_SUCCESS);

    size = static_cast<size_t>(0);
    ret = aclrtMallocCached(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY);
    EXPECT_NE(ret, ACL_SUCCESS);

    size = static_cast<size_t>(1);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtInvalidCache(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtMemInvalidate(devPtr, size);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, memory_free_device)
{
    aclError ret = aclrtFree(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    void *devPtr = nullptr;
    size_t size = 1;
    aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_ONLY_P2P);
    ret = aclrtFree(devPtr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_ONLY_P2P);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtFree(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)))
        .WillRepeatedly(Invoke([](void *devPtr) {
            return aclStub().rtFree(devPtr);
        }));
    ret = aclrtFree(devPtr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(aclrtFree(devPtr), ACL_SUCCESS);
    devPtr = nullptr;
}

TEST_F(UTEST_ACL_Runtime, memory_malloc_host)
{
    void *hostPtr = nullptr;
    size_t size = 0;

    aclError ret = aclrtMallocHost(&hostPtr, size);
    EXPECT_NE(ret, ACL_SUCCESS);

    size = 1;
    ret = aclrtMallocHost(&hostPtr, size);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(hostPtr, nullptr);

    ret = aclrtFreeHost(hostPtr);
    hostPtr = nullptr;
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMallocHost(nullptr, size);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtMallocHost(&hostPtr, size);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclrtFreeHost(hostPtr);
    hostPtr = nullptr;
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMallocHost(_, _, _))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtMallocHost(&hostPtr, size);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, memoryFreeHostTest)
{
    void *hostPtr = nullptr;

    aclError ret = aclrtFreeHost(hostPtr);
    EXPECT_NE(ret, ACL_SUCCESS);
    size_t size = 1;
    ret = aclrtMallocHost(&hostPtr, size);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(hostPtr, nullptr);
    ret = aclrtFreeHost(hostPtr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMallocHost(&hostPtr, size);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtFreeHost(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)))
        .WillRepeatedly(Invoke([](void *hostPtr) {
            return aclStub().rtFreeHost(hostPtr);
        }));
    ret = aclrtFreeHost(hostPtr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(aclrtFreeHost(hostPtr), ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, device_free_with_dev_sync)
{
    aclError ret = aclrtFreeWithDevSync(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    void *devPtr = nullptr;
    size_t size = 1;
    ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_ONLY_P2P);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclrtFreeWithDevSync(devPtr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_ONLY_P2P);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtFreeWithDevSync(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)))
        .WillRepeatedly(Invoke([](void *devPtr) {
            return aclStub().rtFreeWithDevSync(devPtr);
        }));
    ret = aclrtFreeWithDevSync(devPtr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(aclrtFreeWithDevSync(devPtr), ACL_SUCCESS);
    devPtr = nullptr;
}

TEST_F(UTEST_ACL_Runtime, host_free_with_dev_sync)
{
    void *hostPtr = nullptr;
    aclError ret = aclrtFreeHostWithDevSync(hostPtr);
    EXPECT_NE(ret, ACL_SUCCESS);

    size_t size = 1;
    ret = aclrtMallocHost(&hostPtr, size);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclrtFreeHostWithDevSync(hostPtr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMallocHost(&hostPtr, size);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtFreeHostWithDevSync(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)))
        .WillRepeatedly(Invoke([](void *hostPtr) {
            return aclStub().rtFreeHostWithDevSync(hostPtr);
        }));
    ret = aclrtFreeHostWithDevSync(hostPtr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(aclrtFreeHostWithDevSync(hostPtr), ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, memory_memset)
{
    aclError ret = aclrtMemset(nullptr, 1, 1, 1);
    EXPECT_NE(ret, ACL_SUCCESS);

    void *src = (void *)malloc(5);
    ret = aclrtMemset(src, 1, 1, 1);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemset(_, _, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtMemset(src, 1, 1, 1);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    free(src);
}

TEST_F(UTEST_ACL_Runtime, memory_memcpy)
{
    char src[5] = {};
    char dst[5] = {};
    aclError ret = aclrtMemcpy(dst, 1, src, 1, ACL_MEMCPY_HOST_TO_HOST);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpy(nullptr, 1, src, 1, ACL_MEMCPY_HOST_TO_HOST);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtMemcpy(dst, 1, nullptr, 1, ACL_MEMCPY_HOST_TO_HOST);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtMemcpy(dst, 1, src, 1, ACL_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpy(dst, 1, src, 1, ACL_MEMCPY_DEVICE_TO_HOST);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpy(dst, 1, src, 1, ACL_MEMCPY_DEVICE_TO_DEVICE);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpy(dst, 1, src, 1, ACL_MEMCPY_DEFAULT);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpy(dst, 1, src, 1, ACL_MEMCPY_HOST_TO_BUF_TO_DEVICE);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpy(dst, 1, src, 1, (aclrtMemcpyKind)0x7FFFFFFF);
    
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemcpy(_, _, _, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtMemcpy(dst, 1, src, 1, ACL_MEMCPY_DEVICE_TO_DEVICE);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, memory_memcpyAsync)
{
    void *dst = (void *)0x01;
    void *src = (void *)0x02;
    aclrtStream stream = (aclrtStream)0x10;
    aclError ret = aclrtMemcpyAsync(dst, 1, src, 1, ACL_MEMCPY_HOST_TO_HOST, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsync(nullptr, 1, src, 1, ACL_MEMCPY_HOST_TO_HOST, stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsync(dst, 1, nullptr, 1, ACL_MEMCPY_HOST_TO_HOST, stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsync(dst, 1, src, 1, ACL_MEMCPY_HOST_TO_DEVICE, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsync(dst, 1, src, 1, ACL_MEMCPY_HOST_TO_DEVICE, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsync(dst, 1, src, 1, ACL_MEMCPY_DEVICE_TO_HOST, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsync(dst, 1, src, 1, ACL_MEMCPY_DEVICE_TO_DEVICE, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsync(dst, 1, src, 1, ACL_MEMCPY_DEFAULT, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsync(dst, 1, src, 1, ACL_MEMCPY_HOST_TO_BUF_TO_DEVICE, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsync(dst, 1, src, 1, (aclrtMemcpyKind)0x7FFFFFFF, stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    // aclrtMemcpyAsync failed
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemcpyAsync(_, _, _, _, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtMemcpyAsync(dst, 1, src, 1, ACL_MEMCPY_DEVICE_TO_DEVICE, stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, memory_memcpyAsyncWithCondition)
{
    void *dst = (void *)0x01;
    void *src = (void *)0x02;
    aclrtStream stream = (aclrtStream)0x10;

    aclError ret = aclrtMemcpyAsyncWithCondition(dst, 1, src, 1, ACL_MEMCPY_HOST_TO_HOST, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsyncWithCondition(dst, 1, src, 1, ACL_MEMCPY_HOST_TO_DEVICE, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsyncWithCondition(nullptr, 1, src, 1, ACL_MEMCPY_HOST_TO_DEVICE, stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsyncWithCondition(dst, 1, nullptr, 1, ACL_MEMCPY_HOST_TO_DEVICE, stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsyncWithCondition(dst, 1, src, 1, ACL_MEMCPY_HOST_TO_DEVICE, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsyncWithCondition(dst, 1, src, 1, ACL_MEMCPY_DEVICE_TO_HOST, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsyncWithCondition(dst, 1, src, 1, ACL_MEMCPY_DEVICE_TO_DEVICE, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsyncWithCondition(dst, 1, src, 1, ACL_MEMCPY_DEFAULT, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsyncWithCondition(dst, 1, src, 1, ACL_MEMCPY_HOST_TO_BUF_TO_DEVICE, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsyncWithCondition(dst, 1, src, 1, (aclrtMemcpyKind)0x7FFFFFFF, stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    // aclrtMemcpyAsync failed
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemcpyAsyncEx(_, _, _, _, _, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtMemcpyAsyncWithCondition(dst, 1, src, 1, ACL_MEMCPY_DEVICE_TO_DEVICE, stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, memory_getMemInfo)
{
    size_t free = 0x01;
    size_t total = 0x02;
    aclError ret = aclrtGetMemInfo(ACL_DDR_MEM_HUGE, &free, &total);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtGetMemInfo(ACL_DDR_MEM_HUGE, &free, &total);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtGetMemInfo(ACL_HBM_MEM, &free, &total);
    EXPECT_EQ(ret, ACL_SUCCESS);

    // aclrtGetMemInfo failed
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemGetInfoEx(_, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtGetMemInfo(ACL_DDR_MEM_HUGE, &free, &total);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetMemUsageInfo)
{
    int32_t deviceId = 0;
    aclrtMemUsageInfo memUsageInfo[10];
    size_t numInput = 10;
    size_t numOutput = 0;
    aclError ret = aclrtGetMemUsageInfo(deviceId, memUsageInfo, numInput, &numOutput);
    EXPECT_EQ(ret, ACL_SUCCESS);

    // aclrtGetMemUsageInfo failed
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetMemUsageInfo(_, _, _, _))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtGetMemUsageInfo(deviceId, memUsageInfo, numInput, &numOutput);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtMemsetAsyncFailedTest)
{
    void *devPtr = (void *)0x01;
    aclrtStream stream = (aclrtStream)0x10;
    aclError ret = aclrtMemsetAsync(nullptr, 1, 1, 1, stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    // aclrtMemsetAsync failed
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemsetAsync(_, _, _, _, _))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtMemsetAsync(devPtr, 1, 1, 1, stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}


TEST_F(UTEST_ACL_Runtime, aclrtCheckMemTypeTest)
{
    void *devPtr = nullptr;
    size_t size = 1;

    aclError ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(devPtr, nullptr);
    uint32_t checkResult = 0;
    ret = aclrtCheckMemType(&devPtr, size, ACL_RT_MEM_TYPE_DEV, &checkResult, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(checkResult, 0);
    ret = aclrtFree(devPtr);
    devPtr = nullptr;
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtMemsetAsyncSuccessTest)
{
    void *devPtr = (void *)0x01;
    aclrtStream stream = (aclrtStream)0x10;
    aclError ret = aclrtMemsetAsync(devPtr, 1, 1, 1, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetGroupCountTest)
{
    // aclrtGetGroupCount success
    uint32_t count = 0;
    EXPECT_EQ(aclrtGetGroupCount(&count), ACL_SUCCESS);

    // aclrtGetGroupCount failed
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetGroupCount(_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    EXPECT_EQ(aclrtGetGroupCount(&count), ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCreateGroupInfoTest)
{
    // aclrtCreateGroupInfo success
    aclrtGroupInfo *groupInfo = aclrtCreateGroupInfo();
    EXPECT_NE(groupInfo, nullptr);
    EXPECT_EQ(aclrtDestroyGroupInfo(groupInfo), ACL_SUCCESS);

    // aclrtCreateGroupInfo failed
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetGroupCount(_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    EXPECT_EQ(aclrtCreateGroupInfo(), nullptr);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetGroupInfoDetailTest)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetGroupCount(_))
        .WillOnce(Return(RT_ERROR_NONE))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID))
        .WillRepeatedly(Return(RT_ERROR_NONE));

    aclrtGroupInfo *groupInfo = aclrtCreateGroupInfo();
    uint32_t aicoreNum = 0;
    size_t param_ret_size = 0;
    EXPECT_EQ(aclrtGetGroupInfoDetail(groupInfo, 1, ACL_GROUP_AICORE_INT,
        (void *)(&aicoreNum), 4, &param_ret_size), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(aicoreNum, 0);
    EXPECT_EQ(param_ret_size, 0);

    uint32_t aicpuNum = 0;
    EXPECT_EQ(aclrtGetGroupInfoDetail(groupInfo, 1, ACL_GROUP_AIC_INT,
        (void *)(&aicpuNum), 4, &param_ret_size), ACL_SUCCESS);
    EXPECT_NE(aicpuNum, 0);

    uint32_t aivectorNum = 0;
    EXPECT_EQ(aclrtGetGroupInfoDetail(groupInfo, 1, ACL_GROUP_AIV_INT,
        (void *)(&aivectorNum), 4, &param_ret_size), ACL_SUCCESS);
    EXPECT_NE(aivectorNum, 0);

    uint32_t sdmaNum = 0;
    EXPECT_EQ(aclrtGetGroupInfoDetail(groupInfo, 1, ACL_GROUP_SDMANUM_INT,
        (void *)(&sdmaNum), 4, &param_ret_size), ACL_SUCCESS);
    EXPECT_NE(sdmaNum, 0);

    uint32_t activeStreamNum = 0;
    EXPECT_EQ(aclrtGetGroupInfoDetail(groupInfo, 1, ACL_GROUP_ASQNUM_INT,
        (void *)(&activeStreamNum), 4, &param_ret_size), ACL_SUCCESS);
    EXPECT_NE(activeStreamNum, 0);

    uint32_t groupId = 0;
    EXPECT_EQ(aclrtGetGroupInfoDetail(groupInfo, 1, ACL_GROUP_GROUPID_INT,
        (void *)(&groupId), 4, &param_ret_size), ACL_SUCCESS);

    EXPECT_EQ(aclrtGetGroupInfoDetail(groupInfo, 2, ACL_GROUP_ASQNUM_INT,
        (void *)(&activeStreamNum), 4, &param_ret_size), ACL_ERROR_INVALID_PARAM);

    EXPECT_EQ(aclrtGetGroupInfoDetail(groupInfo, 1, static_cast<aclrtGroupAttr>(6),
        (void *)(&activeStreamNum), 4, &param_ret_size), ACL_ERROR_INVALID_PARAM);

    EXPECT_EQ(aclrtDestroyGroupInfo(groupInfo), ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetAllGroupInfoTest)
{
    aclrtGroupInfo *groupInfo = aclrtCreateGroupInfo();

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetGroupCount(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)))
        .WillRepeatedly(Return(RT_ERROR_NONE));
    EXPECT_EQ(aclrtGetAllGroupInfo(groupInfo), ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetGroupInfo(_, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)))
        .WillOnce(Return(RT_ERROR_NONE));
    EXPECT_EQ(aclrtGetAllGroupInfo(groupInfo), ACL_ERROR_RT_PARAM_INVALID);

    // successfull execute aclrtGetAllGroupInfo
    EXPECT_EQ(aclrtGetAllGroupInfo(groupInfo), ACL_SUCCESS);
    EXPECT_EQ(aclrtDestroyGroupInfo(groupInfo), ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetGroupFailedTest)
{
    int32_t groupId = 1;
    EXPECT_EQ(aclrtSetGroup(groupId), ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetGroup(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    EXPECT_EQ(aclrtSetGroup(groupId), ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclDeviceCanAccessPeerTest)
{
    int32_t canAccessPeer = 0;
    EXPECT_EQ(aclrtDeviceCanAccessPeer(&canAccessPeer, 0, 0), ACL_ERROR_INVALID_PARAM);
    EXPECT_EQ(aclrtDeviceCanAccessPeer(&canAccessPeer, 0, 1), ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDevicePhyIdByIndex(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)))
        .WillRepeatedly(Return(RT_ERROR_NONE));
    EXPECT_EQ(aclrtDeviceCanAccessPeer(&canAccessPeer, 0, 1), ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceCanAccessPeer(_, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)))
        .WillRepeatedly(Return(RT_ERROR_NONE));
    EXPECT_EQ(aclrtDeviceCanAccessPeer(&canAccessPeer, 0, 1), ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclEnablePeerAccessTest)
{
    int32_t peerDeviceId = 1;

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDevice(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)))
        .WillRepeatedly(Return(RT_ERROR_NONE));
    EXPECT_EQ(aclrtDeviceEnablePeerAccess(peerDeviceId, 0), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(aclrtDeviceEnablePeerAccess(0, 1), ACL_ERROR_FEATURE_UNSUPPORTED);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDevicePhyIdByIndex(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)))
        .WillRepeatedly(Return(RT_ERROR_NONE));
    EXPECT_EQ(aclrtDeviceEnablePeerAccess(peerDeviceId, 0), ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEnableP2P(_, _, _))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    EXPECT_EQ(aclrtDeviceEnablePeerAccess(peerDeviceId, 0), ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclDisablePeerAccessTest)
{
    int32_t peerDeviceId = 1;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDevice(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)))
        .WillRepeatedly(Return(RT_ERROR_NONE));
    EXPECT_EQ(aclrtDeviceDisablePeerAccess(peerDeviceId), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(aclrtDeviceDisablePeerAccess(0), ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDevicePhyIdByIndex(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)))
        .WillRepeatedly(Return(RT_ERROR_NONE));
    EXPECT_EQ(aclrtDeviceDisablePeerAccess(peerDeviceId), ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDisableP2P(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    EXPECT_EQ(aclrtDeviceDisablePeerAccess(peerDeviceId), ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtSubscribeReportFailedTest)
{
    uint64_t threadId = 1;
    aclrtStream stream = nullptr;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSubscribeReport(_,_))
        .WillOnce(Return((1)));
    aclError ret = aclrtSubscribeReport(threadId, stream);
    EXPECT_EQ(ret, 1);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetExceptionInfoCallbackFailedTest)
{
    aclrtExceptionInfoCallback callback = nullptr;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtRegTaskFailCallbackByModule(_, _))
        .WillOnce(Return((1)));
    aclError ret = aclrtSetExceptionInfoCallback(callback);
    EXPECT_EQ(ret, 1);
}

TEST_F(UTEST_ACL_Runtime, aclrtMemcpy2dTest)
{
    int32_t temp = 1;
    void *dst = reinterpret_cast<void *>(&temp);
    void *src = reinterpret_cast<void *>(&temp);
    size_t dpitch = 2;
    size_t spitch = 2;
    size_t width = 3;
    size_t height = 1;
    aclrtMemcpyKind kind = ACL_MEMCPY_HOST_TO_DEVICE;
    aclError ret = aclrtMemcpy2d(dst, dpitch, src, spitch, width, height, kind);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    width = 2;
    height = 0;
    ret = aclrtMemcpy2d(dst, dpitch, src, spitch, width, height, kind);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    width = 1;
    height = 2;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemcpy2d(_, _, _, _, _, _, _))
        .WillOnce(Return(1))
        .WillOnce(Return(0))
        .WillOnce(Return(0));
    ret = aclrtMemcpy2d(dst, dpitch, src, spitch, width, height, kind);
    EXPECT_EQ(ret, 1);

    width = 1;
    height = 2;
    kind = ACL_MEMCPY_HOST_TO_HOST;
    ret = aclrtMemcpy2d(dst, dpitch, src, spitch, width, height, kind);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    width = 1;
    height = 2;
    kind = ACL_MEMCPY_HOST_TO_DEVICE;
    ret = aclrtMemcpy2d(dst, dpitch, src, spitch, width, height, kind);
    EXPECT_EQ(ret, ACL_SUCCESS);

    width = 1;
    height = 2;
    kind = ACL_MEMCPY_DEFAULT;
    ret = aclrtMemcpy2d(dst, dpitch, src, spitch, width, height, kind);
    EXPECT_EQ(ret, ACL_SUCCESS);

    width = 1;
    height = 2;
    kind = ACL_MEMCPY_HOST_TO_BUF_TO_DEVICE;
    ret = aclrtMemcpy2d(dst, dpitch, src, spitch, width, height, kind);
    EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtMemcpy2dAsyncTest)
{
    int32_t temp = 1;
    void *dst = reinterpret_cast<void *>(&temp);
    void *src = reinterpret_cast<void *>(&temp);
    size_t dpitch = 2;
    size_t spitch = 2;
    size_t width = 3;
    size_t height = 1;
    aclrtStream stream;
    aclrtMemcpyKind kind = ACL_MEMCPY_HOST_TO_DEVICE;
    aclError ret = aclrtMemcpy2dAsync(dst, dpitch, src, spitch, width, height, kind, &stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    width = 2;
    height = 0;
    ret = aclrtMemcpy2dAsync(dst, dpitch, src, spitch, width, height, kind, &stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    width = 1;
    height = 2;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemcpy2dAsync(_, _, _, _, _, _, _, _))
        .WillOnce(Return(1))
        .WillOnce(Return(0))
        .WillOnce(Return(0));
    ret = aclrtMemcpy2dAsync(dst, dpitch, src, spitch, width, height, kind, stream);
    EXPECT_EQ(ret, 1);

    width = 1;
    height = 2;
    kind = ACL_MEMCPY_HOST_TO_HOST;
    ret = aclrtMemcpy2dAsync(dst, dpitch, src, spitch, width, height, kind, stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    width = 1;
    height = 2;
    kind = ACL_MEMCPY_HOST_TO_DEVICE;
    ret = aclrtMemcpy2dAsync(dst, dpitch, src, spitch, width, height, kind, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    width = 1;
    height = 2;
    kind = ACL_MEMCPY_DEFAULT;
    ret = aclrtMemcpy2dAsync(dst, dpitch, src, spitch, width, height, kind, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    width = 1;
    height = 2;
    kind = ACL_MEMCPY_HOST_TO_BUF_TO_DEVICE;
    ret = aclrtMemcpy2dAsync(dst, dpitch, src, spitch, width, height, kind, stream);
    EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetStreamOverflowSwitch)
{
    aclrtStream stream = nullptr;
    aclError ret = aclrtSetStreamOverflowSwitch(stream, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetStreamOverflowSwitch(_, _))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    ret = aclrtSetStreamOverflowSwitch(stream, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetStreamOverflowSwitch)
{
    aclrtStream stream = nullptr;
    uint32_t flag;
    aclError ret = aclrtGetStreamOverflowSwitch(stream, &flag);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetStreamOverflowSwitch(_, _))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    ret = aclrtGetStreamOverflowSwitch(stream, &flag);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetDeviceSatMode)
{
    aclError ret = aclrtSetDeviceSatMode(ACL_RT_OVERFLOW_MODE_SATURATION);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetDeviceSatMode(_))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    ret = aclrtSetDeviceSatMode(ACL_RT_OVERFLOW_MODE_SATURATION);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetDeviceSatMode)
{
    aclrtFloatOverflowMode mode = ACL_RT_OVERFLOW_MODE_UNDEF;
    aclError ret = aclrtGetDeviceSatMode(&mode);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDeviceSatMode(_))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    ret = aclrtGetDeviceSatMode(&mode);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

class ExternalAllocatorDesc {
public:
    ExternalAllocatorDesc(): obj(nullptr), allocFunc(nullptr), freeFunc(nullptr), allocAdviseFunc(nullptr), getAddrFromBlockFunc(nullptr) {}
    ExternalAllocatorDesc(aclrtAllocator allocator,
                     aclrtAllocatorAllocFunc allocFunc,
                     aclrtAllocatorFreeFunc freeFunc,
                     aclrtAllocatorAllocAdviseFunc allocAdviseFunc,
                     aclrtAllocatorGetAddrFromBlockFunc getAddrFromBlockFunc)
    {
        this->obj = allocator;
        this->allocFunc = allocFunc;
        this->freeFunc = freeFunc;
        this->allocAdviseFunc = allocAdviseFunc;
        this->getAddrFromBlockFunc = getAddrFromBlockFunc;
    }
    ~ExternalAllocatorDesc() {}
    bool operator==(const ExternalAllocatorDesc &allocatorDesc) {
        return obj == allocatorDesc.obj &&
                allocFunc == allocatorDesc.allocFunc &&
                freeFunc == allocatorDesc.freeFunc &&
                allocAdviseFunc == allocatorDesc.allocAdviseFunc &&
                getAddrFromBlockFunc == allocatorDesc.getAddrFromBlockFunc;
    }
    aclrtAllocator obj;
    aclrtAllocatorAllocFunc allocFunc;
    aclrtAllocatorFreeFunc freeFunc;
    aclrtAllocatorAllocAdviseFunc allocAdviseFunc;
    aclrtAllocatorGetAddrFromBlockFunc getAddrFromBlockFunc;
};

TEST_F(UTEST_ACL_Runtime, aclrtAllocatorCreateDescTest)
{
    aclrtStream stream = (aclrtStream)0x01;
    auto allocatorDesc = aclrtAllocatorCreateDesc();
    EXPECT_NE(allocatorDesc, nullptr);
    static_cast<ExternalAllocatorDesc *>(allocatorDesc)->obj = nullptr;
    static_cast<ExternalAllocatorDesc *>(allocatorDesc)->allocFunc = nullptr;
    static_cast<ExternalAllocatorDesc *>(allocatorDesc)->freeFunc = nullptr;
    static_cast<ExternalAllocatorDesc *>(allocatorDesc)->getAddrFromBlockFunc = nullptr;

    aclError ret = aclrtAllocatorRegister(stream, allocatorDesc);
    EXPECT_NE(ret, ACL_SUCCESS);

    void *obj = (void *)0x10;
    ret = aclrtAllocatorSetObjToDesc(allocatorDesc, obj);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(static_cast<ExternalAllocatorDesc *>(allocatorDesc)->obj, obj);

    ret = aclrtAllocatorRegister(stream, allocatorDesc);
    EXPECT_NE(ret, ACL_SUCCESS);

    aclrtAllocatorAllocFunc alloc_func = (aclrtAllocatorAllocFunc)0x20;
    ret = aclrtAllocatorSetAllocFuncToDesc(allocatorDesc, alloc_func);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(static_cast<ExternalAllocatorDesc *>(allocatorDesc)->allocFunc, alloc_func);

    ret = aclrtAllocatorRegister(stream, allocatorDesc);
    EXPECT_NE(ret, ACL_SUCCESS);

    aclrtAllocatorFreeFunc free_func = (aclrtAllocatorFreeFunc)0x30;
    ret = aclrtAllocatorSetFreeFuncToDesc(allocatorDesc, free_func);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(static_cast<ExternalAllocatorDesc *>(allocatorDesc)->freeFunc, free_func);

    aclrtAllocatorAllocAdviseFunc alloc_advise_func = (aclrtAllocatorAllocAdviseFunc)0x40;
    ret = aclrtAllocatorSetAllocAdviseFuncToDesc(allocatorDesc, alloc_advise_func);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(static_cast<ExternalAllocatorDesc *>(allocatorDesc)->allocAdviseFunc, alloc_advise_func);

    ret = aclrtAllocatorRegister(stream, static_cast<ExternalAllocatorDesc *>(allocatorDesc));
    EXPECT_NE(ret, ACL_SUCCESS);

    aclrtAllocatorGetAddrFromBlockFunc get_addr_from_block_func = (aclrtAllocatorGetAddrFromBlockFunc)0x50;
    ret = aclrtAllocatorSetGetAddrFromBlockFuncToDesc(allocatorDesc, get_addr_from_block_func);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(static_cast<ExternalAllocatorDesc *>(allocatorDesc)->getAddrFromBlockFunc, get_addr_from_block_func);

    ret = aclrtAllocatorRegister(stream, static_cast<ExternalAllocatorDesc *>(allocatorDesc));
    EXPECT_EQ(ret, ACL_SUCCESS);

    aclrtAllocatorDesc aclrt_desc;
    ExternalAllocatorDesc desc;
    ret = aclrtAllocatorGetByStream(stream, &aclrt_desc, nullptr, nullptr, nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclrtAllocatorGetByStream(stream, &aclrt_desc, &desc.obj, &desc.allocFunc, &desc.freeFunc,
         &desc.allocAdviseFunc, &desc.getAddrFromBlockFunc);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(allocatorDesc, aclrt_desc);
    ret = aclrtAllocatorDestroyDesc(allocatorDesc);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclrtAllocatorGetByStream(stream, &aclrt_desc, &desc.obj, &desc.allocFunc, &desc.freeFunc,
         &desc.allocAdviseFunc, &desc.getAddrFromBlockFunc);
    EXPECT_EQ(allocatorDesc, aclrt_desc);
    EXPECT_EQ(desc.obj, obj);
    EXPECT_EQ(desc.allocFunc, alloc_func);
    EXPECT_EQ(desc.freeFunc, free_func);
    EXPECT_EQ(desc.allocAdviseFunc, alloc_advise_func);
    EXPECT_EQ(desc.getAddrFromBlockFunc, get_addr_from_block_func);

    ret = aclrtAllocatorRegister(nullptr, static_cast<ExternalAllocatorDesc *>(allocatorDesc));
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtAllocatorUnregister(stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtAllocatorUnregister(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetDeviceUtilizationRate)
{
    const int32_t devId = 1;
    aclrtUtilizationInfo utilInfo;
    aclrtUtilizationExtendInfo utilizationExtend;
    utilInfo.utilizationExtend = &utilizationExtend;
    aclError ret = aclrtGetDeviceUtilizationRate(devId, &utilInfo);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    utilInfo.utilizationExtend = nullptr;
    ret = aclrtGetDeviceUtilizationRate(devId, &utilInfo);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetAllUtilizations(_,_,_))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM))
        .WillOnce(Return(ACL_ERROR_RT_FEATURE_NOT_SUPPORT))
        .WillRepeatedly(Return(RT_ERROR_NONE));
    ret = aclrtGetDeviceUtilizationRate(devId, &utilInfo);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, virtual_memory_address_reserve_release)
{
    void *virPtr = nullptr;
    size_t size = 1;

    aclError ret = aclrtReserveMemAddress(&virPtr, size, 0, nullptr, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(virPtr, nullptr);

    ret = aclrtReleaseMemAddress(virPtr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtReserveMemAddress(&virPtr, 0, 0, nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtReserveMemAddress(&virPtr, size, 0, nullptr, 2);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtReserveMemAddress(_,_,_,_,_))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    ret = aclrtReserveMemAddress(&virPtr, size, 0, nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtReserveMemAddress(_,_,_,_,_))
        .WillOnce(Return(ACL_ERROR_RT_FEATURE_NOT_SUPPORT));
    ret = aclrtReserveMemAddress(&virPtr, size, 0, nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtReleaseMemAddress(_))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    ret = aclrtReleaseMemAddress(virPtr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, physical_memory_malloc_free)
{
    aclrtDrvMemHandle handle = nullptr;
    size_t size = 1;
    aclrtPhysicalMemProp prop = {};
    prop.handleType = ACL_MEM_HANDLE_TYPE_NONE;
    prop.allocationType = ACL_MEM_ALLOCATION_TYPE_PINNED;
    prop.memAttr = ACL_HBM_MEM_HUGE;
    prop.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    prop.location.id = 0;

    aclError ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);

    prop.memAttr = ACL_HBM_MEM_NORMAL;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);

    prop.memAttr = ACL_DDR_MEM;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    prop.memAttr = ACL_HBM_MEM_HUGE;

    prop.handleType = (aclrtMemHandleType)100;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    prop.handleType = ACL_MEM_HANDLE_TYPE_NONE;

    prop.allocationType = (aclrtMemAllocationType)100;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    prop.location.type = ACL_MEM_LOCATION_TYPE_UNREGISTERED;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    prop.allocationType = ACL_MEM_ALLOCATION_TYPE_PINNED;

    ret = aclrtFreePhysical(handle);
    EXPECT_EQ(ret, ACL_SUCCESS);

    prop.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    ret = aclrtMallocPhysical(&handle, 0, &prop, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtMallocPhysical(&handle, size, &prop, 1);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMallocPhysical(_,_,_,_))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtFreePhysical(_))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    ret = aclrtFreePhysical(handle);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, physical_memory_malloc_host)
{
    aclrtDrvMemHandle handle = nullptr;
    size_t size = 1;
    aclrtPhysicalMemProp prop = {};
    prop.handleType = ACL_MEM_HANDLE_TYPE_NONE;
    prop.allocationType = ACL_MEM_ALLOCATION_TYPE_PINNED;
    prop.location.type = ACL_MEM_LOCATION_TYPE_HOST_NUMA;
    prop.location.id = 0;
    
    prop.memAttr = ACL_DDR_MEM_HUGE;
    aclError ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);

    prop.memAttr = ACL_DDR_MEM_NORMAL;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);

    prop.memAttr = ACL_DDR_MEM_P2P_HUGE;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);

    prop.memAttr = ACL_DDR_MEM_P2P_NORMAL;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);

    prop.memAttr = ACL_MEM_NORMAL;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);

    prop.memAttr = ACL_MEM_HUGE;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);

    prop.memAttr = ACL_MEM_HUGE1G;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);

    prop.memAttr = ACL_MEM_P2P_NORMAL;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);

    prop.memAttr = ACL_MEM_P2P_HUGE;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);

    prop.memAttr = ACL_MEM_P2P_HUGE1G;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);
}

TEST_F(UTEST_ACL_Runtime, physical_memory_malloc_device)
{
    aclrtDrvMemHandle handle = nullptr;
    size_t size = 1;
    aclrtPhysicalMemProp prop = {};
    prop.handleType = ACL_MEM_HANDLE_TYPE_NONE;
    prop.allocationType = ACL_MEM_ALLOCATION_TYPE_PINNED;
    prop.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    prop.location.id = 0;

    prop.memAttr = ACL_MEM_NORMAL;
    aclError ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);

    prop.memAttr = ACL_MEM_HUGE;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);

    prop.memAttr = ACL_MEM_HUGE1G;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);

    prop.memAttr = ACL_MEM_P2P_NORMAL;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);

    prop.memAttr = ACL_MEM_P2P_HUGE;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);

    prop.memAttr = ACL_MEM_P2P_HUGE1G;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);

    prop.memAttr = ACL_DDR_MEM_NORMAL;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    EXPECT_NE(handle, nullptr);
}

TEST_F(UTEST_ACL_Runtime, virtual_physical_memory_map_unmap)
{
    void *virPtr = nullptr;
    size_t size = 1;

    aclError ret = aclrtReserveMemAddress(&virPtr, size, 0, nullptr, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(virPtr, nullptr);    

    aclrtDrvMemHandle handle = nullptr;
    aclrtPhysicalMemProp prop = {};
    prop.allocationType = ACL_MEM_ALLOCATION_TYPE_PINNED;
    prop.memAttr = ACL_HBM_MEM_HUGE;
    prop.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    prop.location.id = 0;

    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);

    ret = aclrtMapMem(virPtr, size, 0, handle, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtUnmapMem(virPtr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMapMem(virPtr, 0, 0, handle, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtMapMem(virPtr, size, 0, handle, 1);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtReleaseMemAddress(virPtr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtFreePhysical(handle);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMapMem(_,_,_,_,_))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    ret = aclrtMapMem(virPtr, size, 0, handle, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtUnmapMem(_))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    ret = aclrtUnmapMem(virPtr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, create_binary_failed_with_nullptr_input)
{
  aclrtBinary binary = nullptr;
  binary = aclrtCreateBinary(nullptr, 0);
  EXPECT_EQ(binary, nullptr);
}

TEST_F(UTEST_ACL_Runtime, create_binary_successful)
{
  aclrtBinary binary = nullptr;
  char *data = new char[100];
  size_t dataLen = 0x333;
  binary = aclrtCreateBinary(static_cast<void *>(data), dataLen);
  EXPECT_NE(binary, nullptr);

  (void)aclrtDestroyBinary(binary);
  delete [] data;
}

TEST_F(UTEST_ACL_Runtime, destroy_binary_failed_with_nullptr_input)
{
  aclrtBinary binary = nullptr;
  aclError ret = aclrtDestroyBinary(binary);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, destroy_binary_successful)
{
  char *data = reinterpret_cast<char *>(0x01);
  size_t dataLen = 0x333;
  aclrtBinary binary = aclrtCreateBinary(static_cast<void *>(data), dataLen);
  EXPECT_NE(binary, nullptr);

  aclError ret = aclrtDestroyBinary(binary);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, load_binary_failed_with_nullptr_input)
{
  aclrtBinary binary = nullptr;
  aclrtBinHandle *binHandle = nullptr;
  aclError ret = aclrtBinaryLoad(binary, binHandle);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

  char *data = reinterpret_cast<char *>(0x01);
  size_t dataLen = 0x333;
  binary = aclrtCreateBinary(static_cast<void *>(data), dataLen);
  EXPECT_NE(binary, nullptr);

  ret = aclrtBinaryLoad(binary, binHandle);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

  (void)aclrtDestroyBinary(binary);
}

TEST_F(UTEST_ACL_Runtime, load_binary_successful)
{
  char *data = reinterpret_cast<char *>(0x01);
  size_t dataLen = 0x333;
  aclrtBinary binary = aclrtCreateBinary(static_cast<void *>(data), dataLen);
  EXPECT_NE(binary, nullptr);

  aclrtBinHandle binHandle = nullptr;
  aclError ret = aclrtBinaryLoad(binary, &binHandle);
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_NE(binHandle, nullptr);

  (void)aclrtDestroyBinary(binary);
}

TEST_F(UTEST_ACL_Runtime, load_binary_failed_with_rt_func_failed)
{
  char *data = reinterpret_cast<char *>(0x01);
  size_t dataLen = 0x333;
  aclrtBinary binary = aclrtCreateBinary(static_cast<void *>(data), dataLen);
  EXPECT_NE(binary, nullptr);

  aclrtBinHandle binHandle = nullptr;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtBinaryLoadWithoutTilingKey(_, _, _))
          .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
  aclError ret = aclrtBinaryLoad(binary, &binHandle);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

  (void)aclrtDestroyBinary(binary);
}

TEST_F(UTEST_ACL_Runtime, unload_binary_failed_with_nullptr_input)
{
  aclrtBinHandle *binHandle = nullptr;
  aclError ret = aclrtBinaryUnLoad(binHandle);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, unload_binary_successful)
{
  aclrtBinHandle binHandlePtr;
  aclrtBinHandle *binHandle = &binHandlePtr;

  aclError ret = aclrtBinaryUnLoad(binHandle);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, unload_binary_failed_with_rt_func_failed)
{
  aclrtBinHandle binHandlePtr;
  aclrtBinHandle *binHandle = &binHandlePtr;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtBinaryUnLoad(_))
          .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
  aclError ret = aclrtBinaryUnLoad(binHandle);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, binary_get_func_failed_with_nullptr_input)
{
  aclrtBinHandle binHandle = nullptr;
  const char *kernelName = nullptr;
  aclrtFuncHandle *funcHandle = nullptr;
  aclError ret = aclrtBinaryGetFunction(binHandle, kernelName, funcHandle);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

  binHandle = (aclrtBinHandle)0x01U;
  ret = aclrtBinaryGetFunction(binHandle, kernelName, funcHandle);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

  kernelName = "add_0";
  ret = aclrtBinaryGetFunction(binHandle, kernelName, funcHandle);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, binary_get_func_successful)
{
  aclrtBinHandle binHandle = (aclrtBinHandle)0x01U;
  const char *kernelName = "add_0";
  aclrtFuncHandle funcHandle = nullptr;
  aclError ret = aclrtBinaryGetFunction(binHandle, kernelName, &funcHandle);
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_NE(funcHandle, nullptr);
}

TEST_F(UTEST_ACL_Runtime, binary_get_func_failed_with_rt_func_failed)
{
  aclrtBinHandle binHandle = (aclrtBinHandle)0x01U;
  const char *kernelName = "add_0";
  aclrtFuncHandle funcHandle = nullptr;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsFuncGetByName(_, _, _))
          .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
  aclError ret = aclrtBinaryGetFunction(binHandle, kernelName, &funcHandle);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, launch_kernel_failed_with_nullptr_input)
{
  aclrtFuncHandle funcHandle = nullptr;
  void *argsData = nullptr;
  aclrtStream stream = nullptr;
  aclError ret = aclrtLaunchKernel(funcHandle, 0, argsData, 0, stream);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

  funcHandle = (aclrtFuncHandle)0x01U;
  ret = aclrtLaunchKernel(funcHandle, 0, argsData, 0, stream);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

  argsData = reinterpret_cast<void *>(0x01U);
  ret = aclrtLaunchKernel(funcHandle, 0, argsData, 0, stream);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, launch_kernel_successful)
{
  aclrtFuncHandle funcHandle = (aclrtFuncHandle)0x01U;
  void *argsData = reinterpret_cast<void *>(0x01U);
  aclrtStream stream = (aclrtStream)0x01U;
  uint32_t blockDim = 24;
  size_t argsSize = 100;
  aclError ret = aclrtLaunchKernel(funcHandle, blockDim, argsData, argsSize, stream);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, launch_kernel_failed_with_rt_launch_kernel_func_failed)
{
  aclrtFuncHandle funcHandle = (aclrtFuncHandle)0x01U;
  void *argsData = reinterpret_cast<void *>(0x01U);
  aclrtStream stream = (aclrtStream)0x01U;
  uint32_t blockDim = 24;
  size_t argsSize = 100;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtLaunchKernelByFuncHandleV3(_, _, _, _, _))
          .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
  aclError ret = aclrtLaunchKernel(funcHandle, blockDim, argsData, argsSize, stream);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}
TEST_F(UTEST_ACL_Runtime, launch_kernel_failed_with_rt_launch_kernel_func_failed_2)
{
    aclrtFuncHandle funcHandle = (aclrtFuncHandle)0x01U;
    void *argsData = reinterpret_cast<void *>(0x01U);
    aclrtStream stream = (aclrtStream)0x01U;
    uint32_t blockDim = 24;
    size_t argsSize = 100;

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtLaunchKernelByFuncHandleV3(_, _, _, _, _))
          .WillOnce(Return(ACL_ERROR_RT_INVALID_HANDLE));
    aclError ret = aclrtLaunchKernel(funcHandle, blockDim, argsData, argsSize, stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_INVALID_HANDLE);
}

TEST_F(UTEST_ACL_Runtime, export_to_shareablehandle_failed_with_rt_func_failed)
{
  aclrtDrvMemHandle handle = (aclrtDrvMemHandle)0x01U;
  aclrtMemHandleType handleType = ACL_MEM_HANDLE_TYPE_NONE;
  uint64_t flag = 0ULL;
  uint64_t shareableHandle;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsMemExportToShareableHandle(_, _, _, _))
          .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
  aclError ret = aclrtMemExportToShareableHandle(handle, handleType, flag, &shareableHandle);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, export_to_shareablehandle_succ_with_rt_func_succ)
{
  aclrtDrvMemHandle handle = (aclrtDrvMemHandle)0x01U;
  aclrtMemHandleType handleType = ACL_MEM_HANDLE_TYPE_NONE;
  uint64_t flag = 0ULL;
  uint64_t shareableHandle;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsMemExportToShareableHandle(_, _, _, _))
          .WillOnce(Return(RT_ERROR_NONE));
  aclError ret = aclrtMemExportToShareableHandle(handle, handleType, flag, &shareableHandle);
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_EQ(shareableHandle, 0x1111);
}

TEST_F(UTEST_ACL_Runtime, export_to_shareablehandle_failed_with_handle_nullptr)
{
  aclrtDrvMemHandle handle = nullptr;
  aclrtMemHandleType handleType = ACL_MEM_HANDLE_TYPE_NONE;
  uint64_t flag = 0ULL;
  uint64_t shareableHandle;

  aclError ret = aclrtMemExportToShareableHandle(handle, handleType, flag, &shareableHandle);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, export_to_shareablehandle_failed_with_invalid_handleType)
{
  aclrtDrvMemHandle handle = (aclrtDrvMemHandle)0x01U;
  aclrtMemHandleType handleType = static_cast<aclrtMemHandleType>(0xFFFFFFFF);
  uint64_t flag = 0ULL;
  uint64_t shareableHandle;

  aclError ret = aclrtMemExportToShareableHandle(handle, handleType, flag, &shareableHandle);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, export_to_shareablehandle_V2_failed_with_rt_func_failed)
{
  aclrtDrvMemHandle handle = (aclrtDrvMemHandle)0x01U;
  aclrtMemSharedHandleType shareType = ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT;
  uint64_t flag = 0ULL;
  uint64_t shareableHandle;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemExportToShareableHandleV2(_, _, _, _))
    .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
  aclError ret = aclrtMemExportToShareableHandleV2(handle, flag, shareType, static_cast<void*>(&shareableHandle));
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, export_to_shareablehandle_V2_succ_with_rt_func_succ)
{
  aclrtDrvMemHandle handle = (aclrtDrvMemHandle)0x01U;
  aclrtMemSharedHandleType shareType = ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT;
  uint64_t flag = 0ULL;
  uint64_t shareableHandle;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemExportToShareableHandleV2(_, _, _, _))
    .WillOnce(Return(ACL_RT_SUCCESS));
  aclError ret = aclrtMemExportToShareableHandleV2(handle, flag, shareType, static_cast<void*>(&shareableHandle));
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, export_to_shareablehandle_V2_failed_with_handle_nullptr)
{
  aclrtDrvMemHandle handle = nullptr;
  aclrtMemSharedHandleType shareType = ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT;
  uint64_t flag = 0ULL;
  uint64_t shareableHandle;

  aclError ret = aclrtMemExportToShareableHandleV2(handle, flag, shareType, static_cast<void*>(&shareableHandle));
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, import_from_shareablehandle_succ_with_rt_func_succ)
{
  aclrtDrvMemHandle handle = nullptr;
  uint64_t shareableHandle = 0ULL;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemImportFromShareableHandle(_, _, _))
          .WillOnce(Return(RT_ERROR_NONE));
  aclError ret = aclrtMemImportFromShareableHandle(shareableHandle, 0, &handle);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, import_from_shareablehandle_failed_with_rt_func_failed)
{
  aclrtDrvMemHandle handle = nullptr;
  uint64_t shareableHandle = 0ULL;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemImportFromShareableHandle(_, _, _))
          .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
  aclError ret = aclrtMemImportFromShareableHandle(shareableHandle, 0, &handle);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, import_from_shareablehandle_failed_with_handle_nullptr)
{
  uint64_t shareableHandle = 0ULL;
  aclError ret = aclrtMemImportFromShareableHandle(shareableHandle, 0, nullptr);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, import_from_shareablehandle_V2_succ_with_rts_func_succ)
{
  aclrtDrvMemHandle handle = (aclrtDrvMemHandle)0x01U;
  uint64_t shareableHandle = 0ULL;
  aclrtMemSharedHandleType shareType = ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT;
  uint64_t flag = 0ULL;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemImportFromShareableHandleV2(_, _, _, _, _))
    .WillOnce(Return(ACL_RT_SUCCESS));
  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsGetDevice(_))
    .WillOnce(Return(ACL_RT_SUCCESS));
  aclError ret = aclrtMemImportFromShareableHandleV2(static_cast<void*>(&shareableHandle), shareType, flag, &handle);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, import_from_shareablehandle_V2_failed_with_rts_func_failed)
{
  aclrtDrvMemHandle handle = (aclrtDrvMemHandle)0x01U;
  uint64_t shareableHandle = 0ULL;
  aclrtMemSharedHandleType shareType = ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT;
  uint64_t flag = 0ULL;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsGetDevice(_))
    .WillOnce(Return(ACL_RT_SUCCESS));
  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemImportFromShareableHandleV2(_, _, _, _, _))
    .WillOnce(Return(ACL_ERROR_INVALID_PARAM));

  aclError ret = aclrtMemImportFromShareableHandleV2(static_cast<void*>(&shareableHandle), shareType, flag, &handle);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, import_from_shareablehandle_V2_failed_with_handle_nullptr)
{
  uint64_t shareableHandle = 0ULL;
  aclrtMemSharedHandleType shareType = ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT;
  uint64_t flag = 0ULL;

  aclError ret = aclrtMemImportFromShareableHandleV2(static_cast<void*>(&shareableHandle), shareType, flag, nullptr);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, import_from_shareablehandle_V2_failed_with_invalid_flags)
{
  aclrtDrvMemHandle handle = (aclrtDrvMemHandle)0x01U;
  uint64_t shareableHandle = 1ULL;
  aclrtMemSharedHandleType shareType = ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT;
  uint64_t flag = 1ULL;

  aclError ret = aclrtMemImportFromShareableHandleV2(static_cast<void*>(&shareableHandle), shareType, flag, &handle);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, set_pid_to_shareablehandle_succ_with_rt_func_succ)
{
  uint64_t shareableHandle = 0ULL;
  int32_t pid[1] = {0};

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemSetPidToShareableHandle(_, _, _))
    .WillOnce(Return(RT_ERROR_NONE));
  aclError ret = aclrtMemSetPidToShareableHandle(shareableHandle, pid, sizeof(pid)/sizeof(pid[0]));
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, set_pid_to_shareablehandle_failed_with_rt_func_failed)
{
  uint64_t shareableHandle = 0ULL;
  int32_t pid[1] = {0};

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemSetPidToShareableHandle(_, _, _))
          .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
  aclError ret = aclrtMemSetPidToShareableHandle(shareableHandle, pid, sizeof(pid)/sizeof(pid[0]));
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, set_pid_to_shareablehandle_failed_with_pid_nullptr)
{
  uint64_t shareableHandle = 0ULL;

  aclError ret = aclrtMemSetPidToShareableHandle(shareableHandle, nullptr, 1);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, set_pid_to_shareablehandle_failed_with_invalid_pidNum)
{
  uint64_t shareableHandle = 0ULL;
  int32_t pid[1] = {0};

  aclError ret = aclrtMemSetPidToShareableHandle(shareableHandle, pid, 0);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, set_pid_to_shareablehandle_V2_succ_with_rts_func_succ)
{
  uint64_t shareableHandle = 0ULL;
  int32_t pid[1] = {0};
  aclrtMemSharedHandleType shareType = ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemSetPidToShareableHandleV2(_, _, _, _))
    .WillOnce(Return(ACL_RT_SUCCESS)); 
  aclError ret = aclrtMemSetPidToShareableHandleV2(static_cast<void*>(&shareableHandle), shareType, pid, sizeof(pid)/sizeof(pid[0]));
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, set_pid_to_shareablehandle_V2_failed_with_rts_func_failed)
{
  uint64_t shareableHandle = 0ULL;
  int32_t pid[1] = {0};
  aclrtMemSharedHandleType shareType = ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemSetPidToShareableHandleV2(_, _, _, _))
    .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
  aclError ret = aclrtMemSetPidToShareableHandleV2(static_cast<void*>(&shareableHandle), shareType, pid, sizeof(pid)/sizeof(pid[0]));
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, set_pid_to_shareablehandle_V2_failed_with_pid_nullptr)
{
  uint64_t shareableHandle = 0ULL;
  aclrtMemSharedHandleType shareType = ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT;

  aclError ret = aclrtMemSetPidToShareableHandleV2(static_cast<void*>(&shareableHandle), shareType, nullptr, 1);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, set_pid_to_shareablehandle_V2_failed_with_invalid_pidNum)
{
  uint64_t shareableHandle = 0ULL;
  int32_t pid[1] = {0};
  aclrtMemSharedHandleType shareType = ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT;

  aclError ret = aclrtMemSetPidToShareableHandleV2(static_cast<void*>(&shareableHandle), shareType, pid, 0);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, get_allocation_granularity_succ_with_rt_func_succ_hbm)
{
  aclrtPhysicalMemProp prop = {};
  prop.memAttr = ACL_HBM_MEM_HUGE;
  aclrtMemGranularityOptions option = ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM;
  size_t granularity = 0UL;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemGetAllocationGranularity(_, _, _))
          .WillOnce(Return(RT_ERROR_NONE));
  aclError ret = aclrtMemGetAllocationGranularity(&prop, option, &granularity);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, get_allocation_granularity_succ_with_rt_func_succ_hbm1g)
{
  aclrtPhysicalMemProp prop = {};
  prop.memAttr = ACL_HBM_MEM_HUGE1G;
  aclrtMemGranularityOptions option = ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM;
  size_t granularity = 0UL;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemGetAllocationGranularity(_, _, _))
          .WillOnce(Return(RT_ERROR_NONE));
  aclError ret = aclrtMemGetAllocationGranularity(&prop, option, &granularity);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, get_allocation_granularity_succ_with_rt_func_succ_normal)
{
  aclrtPhysicalMemProp prop = {};
  prop.memAttr = ACL_HBM_MEM_NORMAL;
  aclrtMemGranularityOptions option = ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM;
  size_t granularity = 0UL;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemGetAllocationGranularity(_, _, _))
          .WillOnce(Return(RT_ERROR_NONE));
  aclError ret = aclrtMemGetAllocationGranularity(&prop, option, &granularity);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, get_allocation_granularity_failed_with_unsupport_memAttr)
{
  aclrtPhysicalMemProp prop = {};
  prop.memAttr = ACL_HBM_MEM_P2P_NORMAL;
  aclrtMemGranularityOptions option = ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM;
  size_t granularity = 0UL;

  aclError ret = aclrtMemGetAllocationGranularity(&prop, option, &granularity);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, get_allocation_granularity_failed_with_rt_func_failed)
{
  aclrtPhysicalMemProp prop = {};
  prop.memAttr = ACL_HBM_MEM_NORMAL;
  aclrtMemGranularityOptions option = ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM;
  size_t granularity = 0UL;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemGetAllocationGranularity(_, _, _))
          .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
  aclError ret = aclrtMemGetAllocationGranularity(&prop, option, &granularity);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, get_allocation_granularity_failed_with_prop_nullptr)
{
  aclrtMemGranularityOptions option = ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM;
  size_t granularity = 0UL;

  aclError ret = aclrtMemGetAllocationGranularity(nullptr, option, &granularity);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, get_allocation_granularity_failed_with_granularity_nullptr)
{
  aclrtPhysicalMemProp prop = {};
  prop.memAttr = ACL_HBM_MEM_NORMAL;
  aclrtMemGranularityOptions option = ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM;

  aclError ret = aclrtMemGetAllocationGranularity(&prop, option, nullptr);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, get_tgid_succ_with_rt_func_succ)
{
  int32_t pid = 0;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceGetBareTgid(_))
          .WillOnce(Return(RT_ERROR_NONE));
  aclError ret = aclrtDeviceGetBareTgid(&pid);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, get_tgid_failed_with_rt_func_failed)
{
  int32_t pid = 0;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceGetBareTgid(_))
          .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
  aclError ret = aclrtDeviceGetBareTgid(&pid);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, get_tgid_failed_with_pid_nullptr)
{
  aclError ret = aclrtDeviceGetBareTgid(nullptr);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, get_mem_uce_info_success)
{
  int32_t deviceId = 0;
  aclrtMemUceInfo memUceInfoArray[RT_MAX_RECORD_PA_NUM_PER_DEV];
  size_t arraySize = RT_MAX_RECORD_PA_NUM_PER_DEV;
  size_t retSize = 0;

  aclError ret = aclrtGetMemUceInfo(deviceId, memUceInfoArray, arraySize, &retSize);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, get_error_verbose_success)
{
    int32_t deviceId = 0;
    aclrtErrorInfo errorInfo;

    aclError ret = aclrtGetErrorVerbose(deviceId, &errorInfo);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, repair_error_success)
{
    int32_t deviceId = 0;
    aclrtErrorInfo errorInfo{};

    aclError ret = aclrtRepairError(deviceId, &errorInfo);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, SnapShotProcessLock_success)
{
    aclError ret = aclrtSnapShotProcessLock();
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, SnapShotProcessLock_failed)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSnapShotProcessLock())
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    aclError ret = aclrtSnapShotProcessLock();
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, SnapShotProcessUnlock_success)
{
    aclError ret = aclrtSnapShotProcessUnlock();
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, SnapShotProcessUnlock_failed)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSnapShotProcessUnlock())
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    aclError ret = aclrtSnapShotProcessUnlock();
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, SnapShotProcessBackup_success)
{
    aclError ret = aclrtSnapShotProcessBackup();
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, SnapShotProcessBackup_failed)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSnapShotProcessBackup())
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    aclError ret = aclrtSnapShotProcessBackup();
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, SnapShotProcessRestore_success)
{
    aclError ret = aclrtSnapShotProcessRestore();
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, SnapShotProcessRestore_failed)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSnapShotProcessRestore())
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    aclError ret = aclrtSnapShotProcessRestore();
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, SnapShotCallbackRegister_failed)
{
    aclError ret = aclrtSnapShotCallbackRegister(ACL_RT_SNAPSHOT_LOCK_PRE, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, SnapShotCallbackUnregister_failed)
{
    aclError ret = aclrtSnapShotCallbackUnregister(ACL_RT_SNAPSHOT_LOCK_PRE, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, get_mem_uce_info__failedwith_invalid_array)
{
  int32_t deviceId = 0;
  size_t arraySize = RT_MAX_RECORD_PA_NUM_PER_DEV - 1;
  size_t retSize = 0;

  aclError ret = aclrtGetMemUceInfo(deviceId, nullptr, arraySize, &retSize);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, get_mem_uce_info_failed_with_invalid_ret_size)
{
  int32_t deviceId = 0;
  aclrtMemUceInfo memUceInfoArray[RT_MAX_RECORD_PA_NUM_PER_DEV];
  size_t arraySize = RT_MAX_RECORD_PA_NUM_PER_DEV;

  aclError ret = aclrtGetMemUceInfo(deviceId, memUceInfoArray, arraySize, nullptr);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

static rtError_t rtGetMemUceInfo_invoke(int32_t deviceId, rtMemUceInfo* rtUceInfo){
  rtUceInfo->devid = deviceId;
  rtUceInfo->count = RT_MAX_RECORD_PA_NUM_PER_DEV + 1;
  return RT_ERROR_NONE;
}

TEST_F(UTEST_ACL_Runtime, get_mem_uce_info_failed_with_space_not_enough)
{
  int32_t deviceId = 0;
  aclrtMemUceInfo memUceInfoArray[RT_MAX_RECORD_PA_NUM_PER_DEV];
  size_t arraySize = RT_MAX_RECORD_PA_NUM_PER_DEV;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetMemUceInfo(_,_))
        .WillOnce(Invoke(rtGetMemUceInfo_invoke));
  aclError ret = aclrtGetMemUceInfo(deviceId, memUceInfoArray, arraySize, &arraySize);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, get_mem_uce_info_succ_with_valid_addr)
{
  int32_t deviceId = 0;
  aclrtMemUceInfo memUceInfoArray[RT_MAX_RECORD_PA_NUM_PER_DEV + 1];
  size_t arraySize = RT_MAX_RECORD_PA_NUM_PER_DEV + 1;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetMemUceInfo(_,_))
        .WillOnce(Invoke(rtGetMemUceInfo_invoke));
  aclError ret = aclrtGetMemUceInfo(deviceId, memUceInfoArray, arraySize, &arraySize);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, get_mem_uce_info_failed_with_rts_error)
{
  int32_t deviceId = 0;
  aclrtMemUceInfo memUceInfoArray[RT_MAX_RECORD_PA_NUM_PER_DEV];
  size_t arraySize = RT_MAX_RECORD_PA_NUM_PER_DEV;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetMemUceInfo(_,_))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
  aclError ret = aclrtGetMemUceInfo(deviceId, memUceInfoArray, arraySize, &arraySize);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, set_device_task_abort_success)
{
  int32_t deviceId = 0;
  uint32_t timeOut = 100;

  aclError ret = aclrtDeviceTaskAbort(deviceId, timeOut);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, set_device_task_abort_failed_with_rts_error)
{
  int32_t deviceId = 0;
  uint32_t timeOut = 100;
  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceTaskAbort(_,_))
    .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
  aclError ret = aclrtDeviceTaskAbort(deviceId, timeOut);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, mem_uce_repair_success)
{
  int32_t deviceId = 0;
  aclrtMemUceInfo memUceInfoArray[8];
  size_t arraySize = 8;

  for (size_t i = 0; i < arraySize; ++i) {
    (void)memset_s(memUceInfoArray[i].reserved, UCE_INFO_RESERVED_SIZE, 0, UCE_INFO_RESERVED_SIZE);
  }

  aclError ret = aclrtMemUceRepair(deviceId, memUceInfoArray, arraySize);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, mem_uce_repair_failed_with_array_nullptr)
{
  int32_t deviceId = 0;
  size_t arraySize = 8;

  aclError ret = aclrtMemUceRepair(deviceId, nullptr, arraySize);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, mem_uce_repair_failed_with_nonzero_reserved_value)
{
  int32_t deviceId = 0;
  aclrtMemUceInfo memUceInfoArray[8];
  size_t arraySize = 8;

  for (size_t i = 0; i < arraySize; ++i) {
    (void)memset_s(memUceInfoArray[i].reserved, UCE_INFO_RESERVED_SIZE, 0, UCE_INFO_RESERVED_SIZE);
    memUceInfoArray[i].reserved[0] = 1;
  }

  aclError ret = aclrtMemUceRepair(deviceId, memUceInfoArray, arraySize);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, mem_uce_repair_failed_with_invalid_array_size)
{
  int32_t deviceId = 0;
  aclrtMemUceInfo memUceInfoArray[RT_MAX_RECORD_PA_NUM_PER_DEV + 1];
  size_t arraySize = RT_MAX_RECORD_PA_NUM_PER_DEV + 1;

  aclError ret = aclrtMemUceRepair(deviceId, memUceInfoArray, arraySize);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, mem_uce_repair_failed_with_rts_error)
{
  int32_t deviceId = 0;
  aclrtMemUceInfo memUceInfoArray[8] = {};
  size_t arraySize = 8;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemUceRepair(_,_))
    .WillOnce(Return(ACL_ERROR_INVALID_PARAM));

  aclError ret = aclrtMemUceRepair(deviceId, memUceInfoArray, arraySize);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, cmo_success)
{
  void *devPtr = reinterpret_cast<void *>(0x01U);
  size_t size = 1024UL;
  aclrtStream stream = nullptr;
  aclrtCmoType cmoType = ACL_RT_CMO_TYPE_PREFETCH;

  aclError ret = aclrtCmoAsync(devPtr, size, cmoType, stream);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, cmo_failed_with_null_address)
{
  void *devPtr = nullptr;
  size_t size = 1024UL;
  aclrtStream stream = nullptr;
  aclrtCmoType cmoType = ACL_RT_CMO_TYPE_PREFETCH;

  aclError ret = aclrtCmoAsync(devPtr, size, cmoType, stream);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, cmo_failed_with_zero_size)
{
  void *devPtr = reinterpret_cast<void *>(0x01U);
  size_t size = 0UL;
  aclrtStream stream = nullptr;
  aclrtCmoType cmoType = ACL_RT_CMO_TYPE_PREFETCH;

  aclError ret = aclrtCmoAsync(devPtr, size, cmoType, stream);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, cmo_failed_with_rts_error)
{
  void *devPtr = reinterpret_cast<void *>(0x01U);
  size_t size = 1024UL;
  aclrtStream stream = nullptr;
  aclrtCmoType cmoType = ACL_RT_CMO_TYPE_PREFETCH;

  EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtCmoAsync(_,_,_,_))
    .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
  aclError ret = aclrtCmoAsync(devPtr, size, cmoType, stream);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtPeekAtLastError)
{
  int32_t level_invalid = 1;
  auto ret = aclrtPeekAtLastError(static_cast<aclrtLastErrLevel>(level_invalid));
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
  aclrtLastErrLevel level = ACL_RT_THREAD_LEVEL;
  ret = aclrtPeekAtLastError(level);
  EXPECT_EQ(ret, ACL_ERROR_RT_FAILURE);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetLastError)
{
  int32_t level_invalid = 1;
  auto ret = aclrtGetLastError(static_cast<aclrtLastErrLevel>(level_invalid));
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
  aclrtLastErrLevel level = ACL_RT_THREAD_LEVEL;
  ret = aclrtGetLastError(level);
  EXPECT_EQ(ret, ACL_ERROR_RT_FAILURE);
}

TEST_F(UTEST_ACL_Runtime, aclrtMemcpyAsyncWithDesc_failed_with_invalid_args)
{
    auto ret = aclrtMemcpyAsyncWithDesc(nullptr, ACL_MEMCPY_HOST_TO_HOST, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    auto desc = reinterpret_cast<void *>(0x1000U);
    ret = aclrtMemcpyAsyncWithDesc(desc, ACL_MEMCPY_HOST_TO_HOST, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsMemcpyAsyncWithDesc(_,_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    auto stream = reinterpret_cast<aclrtStream>(0x4000U);;
    ret = aclrtMemcpyAsyncWithDesc(desc, ACL_MEMCPY_HOST_TO_HOST, stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    desc = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtMemcpyAsyncWithOffset)
{
    auto ret = aclrtMemcpyAsyncWithOffset(nullptr, 0, 0, nullptr, 0, 0, ACL_MEMCPY_INNER_DEVICE_TO_DEVICE, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemcpyAsyncWithOffset(_,_,_,_,_,_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtMemcpyAsyncWithOffset(nullptr, 0, 0, nullptr, 0, 0, ACL_MEMCPY_INNER_DEVICE_TO_DEVICE, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemcpyAsyncWithOffset(_,_,_,_,_,_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_FEATURE_NOT_SUPPORT));
    ret = aclrtMemcpyAsyncWithOffset(nullptr, 0, 0, nullptr, 0, 0, ACL_MEMCPY_INNER_DEVICE_TO_DEVICE, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(UTEST_ACL_Runtime, aclrtMemcpyAsyncWithDesc_success)
{
    auto desc = reinterpret_cast<void *>(0x1000U);
    auto stream = reinterpret_cast<aclrtStream>(0x4000U);;
    const auto ret = aclrtMemcpyAsyncWithDesc(desc, ACL_MEMCPY_HOST_TO_HOST, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);
    desc = nullptr;
    stream = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtGetMemcpyDescSize_failed_with_invalid_args)
{
    size_t descSize = 0U;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsGetMemcpyDescSize(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    const auto ret = aclrtGetMemcpyDescSize(ACL_MEMCPY_HOST_TO_HOST, &descSize);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetMemcpyDescSize_success)
{
    size_t descSize = 0U;
    auto ret = aclrtGetMemcpyDescSize(ACL_MEMCPY_HOST_TO_HOST, &descSize);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetMemcpyDesc_failed_with_invalid_args)
{
    auto ret = aclrtSetMemcpyDesc(nullptr, ACL_MEMCPY_HOST_TO_HOST, nullptr, nullptr, 0U, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    auto desc = reinterpret_cast<void *>(0x1000U);
    ret = aclrtSetMemcpyDesc(desc, ACL_MEMCPY_HOST_TO_HOST, nullptr, nullptr, 0U, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    auto srcAddr = reinterpret_cast<uint32_t *>(0x2000U);
    ret = aclrtSetMemcpyDesc(desc, ACL_MEMCPY_HOST_TO_HOST, srcAddr, nullptr, 0U, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    auto *dstAddr = reinterpret_cast<uint32_t *>(0x3000U);
    ret = aclrtSetMemcpyDesc(desc, ACL_MEMCPY_HOST_TO_HOST, srcAddr, dstAddr, 0U, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsSetMemcpyDesc(_,_,_,_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtSetMemcpyDesc(desc, ACL_MEMCPY_HOST_TO_HOST, srcAddr, dstAddr, 0x10U, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetMemcpyDesc_success)
{
    auto desc = reinterpret_cast<void *>(0x1000U);
    auto *srcAddr = reinterpret_cast<uint32_t *>(0x2000U);
    auto *dstAddr = reinterpret_cast<uint32_t *>(0x3000U);
    uint64_t count = 0x10U;
    const auto ret = aclrtSetMemcpyDesc(desc, ACL_MEMCPY_HOST_TO_HOST, srcAddr, dstAddr, count, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    desc = srcAddr = dstAddr = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtBinaryLoadFromFile_failed_with_invalid_args)
{
    aclrtBinHandle binHandle = nullptr;
    auto ret = aclrtBinaryLoadFromFile(nullptr, nullptr, &binHandle);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsBinaryLoadFromFile(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    const char *binPath = "./binary/add.json";
    ret = aclrtBinaryLoadFromFile(binPath, nullptr, &binHandle);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtBinaryLoadFromFile_success)
{
   const char *binPath = "./binary/add.json";
   auto *options = reinterpret_cast<aclrtBinaryLoadOptions *>(0x1000U);
   aclrtBinHandle binHandle = nullptr;
   const auto ret = aclrtBinaryLoadFromFile(binPath, options, &binHandle);
   EXPECT_EQ(ret, ACL_SUCCESS);
   options = nullptr;
}

TEST_F(UTEST_ACL_Runtime, binary_get_dev_address_failed)
{
    void *binAddr = nullptr;
    size_t binSize = 0U;
    auto ret = aclrtBinaryGetDevAddress(nullptr, &binAddr, &binSize);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsBinaryGetDevAddress(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    auto binHandle = reinterpret_cast<aclrtBinHandle>(0x1000U);
    ret = aclrtBinaryGetDevAddress(binHandle, &binAddr, &binSize);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    binHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, binary_get_dev_address_success)
{
    auto binHandle = reinterpret_cast<aclrtBinHandle>(0x1000U);
    size_t binSize = 0U;
    void *binAddr = nullptr;
    auto ret = aclrtBinaryGetDevAddress(binHandle, &binAddr, &binSize);
    
    EXPECT_EQ(ret, ACL_SUCCESS);
    binHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, mem_set_access_failed)
{
    void *virPtr = nullptr;

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemSetAccess(_,_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    auto ret = aclrtMemSetAccess(virPtr, 0, nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, mem_get_access_failed)
{
    void *virPtr = nullptr;
    size_t size = 1;
    aclError ret = aclrtReserveMemAddress(&virPtr, size, 0, nullptr, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(virPtr, nullptr); 
    aclrtMemLocation location;
    location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    location.id = 1U;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemGetAccess(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    uint64_t flag = 0U;
    ret = aclrtMemGetAccess(virPtr, &location, &flag);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, mem_set_access_success)
{
    void *virPtr = nullptr;
    size_t size = 1;

    aclError ret = aclrtReserveMemAddress(&virPtr, size, 0, nullptr, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(virPtr, nullptr);   

    aclrtDrvMemHandle handle = nullptr;
    aclrtPhysicalMemProp prop = {};
    prop.allocationType = ACL_MEM_ALLOCATION_TYPE_PINNED;
    prop.memAttr = ACL_HBM_MEM_HUGE;
    prop.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    prop.location.id = 0;

    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);

    ret = aclrtMapMem(virPtr, size, 0, handle, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);

    aclrtMemAccessFlags flags = ACL_RT_MEM_ACCESS_FLAGS_NONE;
    aclrtMemLocation location;
    location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    location.id = 1U;
    aclrtMemAccessDesc desc[1];
    desc[0].flags = flags;
    desc[0].location = location;
    constexpr uint32_t rsvMaxSize = sizeof(aclrtMemAccessDesc::rsv) / sizeof(uint8_t);
    for (uint32_t i = 0U; i < rsvMaxSize; i++) {
        desc[0].rsv[i] = 0U;
    }

    ret = aclrtMemSetAccess(virPtr, size, desc, 1);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtUnmapMem(virPtr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtFreePhysical(handle);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtReleaseMemAddress(virPtr);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, mem_set_get_access_success)
{
    void *virPtr = nullptr;
    size_t size = 1;

    aclError ret = aclrtReserveMemAddress(&virPtr, size, 0, nullptr, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(virPtr, nullptr);   

    aclrtMemAccessFlags flags = ACL_RT_MEM_ACCESS_FLAGS_NONE;
    aclrtMemLocation location;
    location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    location.id = 1U;
    aclrtMemAccessDesc desc[1];
    desc[0].flags = flags;
    desc[0].location = location;
    constexpr uint32_t rsvMaxSize = sizeof(aclrtMemAccessDesc::rsv) / sizeof(uint8_t);
    for (uint32_t i = 0U; i < rsvMaxSize; i++) {
        desc[0].rsv[i] = 0U;
    }

    ret = aclrtMemSetAccess(virPtr, size, desc, 1);
    EXPECT_EQ(ret, ACL_SUCCESS);

    uint64_t flag = 0U;
    ret = aclrtMemGetAccess(virPtr, &location, &flag);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtReleaseMemAddress(virPtr);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtBinaryGetFunctionByEntry_failed_with_invalid_args)
{
    aclrtFuncHandle funcHandle = nullptr;
    auto ret = aclrtBinaryGetFunctionByEntry(nullptr, 0U, &funcHandle);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsFuncGetByEntry(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    auto binHandle = reinterpret_cast<aclrtBinHandle>(0x1000U);
    ret = aclrtBinaryGetFunctionByEntry(binHandle, 0U, &funcHandle);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    binHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtBinaryGetFunctionByEntry_success)
{
    auto binHandle = reinterpret_cast<aclrtBinHandle>(0x1000U);
    aclrtFuncHandle funcHandle = nullptr;
    auto ret = aclrtBinaryGetFunctionByEntry(binHandle, 0U, &funcHandle);
    EXPECT_EQ(ret, ACL_SUCCESS);
    binHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtGetFunctionAddr_failed_with_invalid_args)
{
    void *aicAddr = nullptr;
    void *aivAddr = nullptr;
    auto ret = aclrtGetFunctionAddr(nullptr, &aicAddr, &aivAddr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsFuncGetAddr(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    auto funcHandle = reinterpret_cast<aclrtFuncHandle>(0x1000U);
    ret = aclrtGetFunctionAddr(funcHandle, &aicAddr, &aivAddr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    funcHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtGetFunctionAddr_success)
{
    auto funcHandle = reinterpret_cast<aclrtFuncHandle>(0x1000U);
    void *aicAddr = nullptr;
    void *aivAddr = nullptr;
    const auto ret = aclrtGetFunctionAddr(funcHandle, &aicAddr, &aivAddr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    funcHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtLaunchKernelWithConfig_failed_with_invalid_args)
{
    auto ret = aclrtLaunchKernelWithConfig(nullptr, 0U, nullptr, nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    auto funcHandle = reinterpret_cast<aclrtFuncHandle>(0x1000U);
    ret = aclrtLaunchKernelWithConfig(funcHandle, 0U, nullptr, nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtLaunchKernelWithConfig(funcHandle, 0x10U, nullptr, nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsLaunchKernelWithConfig(_,_,_,_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    auto argsHandle = reinterpret_cast<aclrtArgsHandle>(0x3000U);
    ret = aclrtLaunchKernelWithConfig(funcHandle, 0x10U, nullptr, nullptr, argsHandle, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    funcHandle = argsHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtLaunchKernelWithConfig_failed_with_invalid_func)
{
    auto funcHandle = reinterpret_cast<aclrtFuncHandle>(0x1000U);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsLaunchKernelWithConfig(_,_,_,_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_INVALID_HANDLE));

    auto argsHandle = reinterpret_cast<aclrtArgsHandle>(0x3000U);
    auto ret = aclrtLaunchKernelWithConfig(funcHandle, 0x10U, nullptr, nullptr, argsHandle, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_INVALID_HANDLE);
    funcHandle = argsHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtLaunchKernelWithConfig_success)
{
    auto funcHandle = reinterpret_cast<aclrtFuncHandle>(0x1000U);
    aclrtLaunchKernelCfg cfg;
    cfg.numAttrs = 1U;

    aclrtLaunchKernelAttr attrs[cfg.numAttrs];
    attrs[0U].id = ACL_RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE;

    aclrtLaunchKernelAttrValue value;
    value.schemMode = 1U;
    attrs[0U].value = value;
    cfg.attrs = attrs;

    auto argsHandle = reinterpret_cast<aclrtArgsHandle>(0x4000U);
    const auto ret = aclrtLaunchKernelWithConfig(funcHandle, 0x10U, nullptr, &cfg, argsHandle, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    funcHandle = argsHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtKernelArgsInit_failed_with_invalid_args)
{
    aclrtArgsHandle argsHandle = nullptr;
    auto ret = aclrtKernelArgsInit(nullptr, &argsHandle);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsKernelArgsInit(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    auto funcHandle = reinterpret_cast<aclrtFuncHandle>(0x1000U);
    ret = aclrtKernelArgsInit(funcHandle, &argsHandle);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    funcHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtKernelArgsInit_success) {
    auto funcHandle = reinterpret_cast<aclrtFuncHandle>(0x1000U);
    aclrtArgsHandle argsHandle = nullptr;
    const auto ret = aclrtKernelArgsInit(funcHandle, &argsHandle);
    EXPECT_EQ(ret, ACL_SUCCESS);
    funcHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtKernelArgsInitByUserMem_failed_with_invalid_args)
{
    auto ret = aclrtKernelArgsInitByUserMem(nullptr, nullptr, nullptr, 0U);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    auto funcHandle = reinterpret_cast<aclrtFuncHandle>(0x1000U);
    ret = aclrtKernelArgsInitByUserMem(funcHandle, nullptr, nullptr, 0U);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    auto argsHandle = reinterpret_cast<aclrtArgsHandle>(0x2000U);
    ret = aclrtKernelArgsInitByUserMem(funcHandle, argsHandle, nullptr, 0U);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    auto *userHostMem = reinterpret_cast<void *>(0x3000U);
    ret = aclrtKernelArgsInitByUserMem(funcHandle, argsHandle, userHostMem, 0U);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsKernelArgsInitByUserMem(_,_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtKernelArgsInitByUserMem(funcHandle, argsHandle, userHostMem, 0x10U);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    funcHandle = argsHandle = userHostMem = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtKernelArgsInitByUserMem_success)
{
    auto funcHandle = reinterpret_cast<aclrtFuncHandle>(0x1000U);
    auto argsHandle = reinterpret_cast<aclrtArgsHandle>(0x2000U);
    auto *userHostMem = reinterpret_cast<void *>(0x3000U);
    const auto ret = aclrtKernelArgsInitByUserMem(funcHandle, argsHandle, userHostMem, 0x10U);
    EXPECT_EQ(ret, ACL_SUCCESS);
    funcHandle = argsHandle = userHostMem = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtKernelArgsFinalize_failed_with_invalid_args)
{
    auto argsHandle = reinterpret_cast<aclrtArgsHandle>(0x1000U);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsKernelArgsFinalize(_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    const auto ret = aclrtKernelArgsFinalize(argsHandle);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    argsHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtKernelArgsFinalize_success) {
    auto argsHandle = reinterpret_cast<aclrtArgsHandle>(0x1000U);
    const auto ret = aclrtKernelArgsFinalize(argsHandle);
    EXPECT_EQ(ret, ACL_SUCCESS);
    argsHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtKernelArgsAppend_failed_with_invalid_args)
{
    aclrtParamHandle paramHandle = nullptr;
    auto ret = aclrtKernelArgsAppend(nullptr, nullptr, 0U, &paramHandle);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    auto argsHandle = reinterpret_cast<aclrtArgsHandle>(0x1000U);
    ret = aclrtKernelArgsAppend(argsHandle, nullptr, 0U, &paramHandle);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    auto *para = reinterpret_cast<void *>(0x2000U);
    ret = aclrtKernelArgsAppend(argsHandle, para, 0U, &paramHandle);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsKernelArgsAppend(_,_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtKernelArgsAppend(argsHandle, para, 0x10U, &paramHandle);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    argsHandle = para = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtKernelArgsAppend_success)
{
    auto argsHandle = reinterpret_cast<aclrtArgsHandle>(0x1000U);
    auto *para = reinterpret_cast<void *>(0x2000U);
    aclrtParamHandle paramHandle = nullptr;
    const auto ret = aclrtKernelArgsAppend(argsHandle, para, 1U, &paramHandle);
    EXPECT_EQ(ret, ACL_SUCCESS);
    argsHandle = para = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtKernelArgsAppendPlaceHolder_failed_with_invalid_args)
{
    aclrtParamHandle paramHandle = nullptr;
    auto ret = aclrtKernelArgsAppendPlaceHolder(nullptr, &paramHandle);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsKernelArgsAppendPlaceHolder(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    auto argsHandle = reinterpret_cast<aclrtArgsHandle>(0x1000U);
    ret = aclrtKernelArgsAppendPlaceHolder(argsHandle, &paramHandle);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    argsHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtKernelArgsAppendPlaceHolder_success)
{
    auto argsHandle = reinterpret_cast<aclrtArgsHandle>(0x1000U);
    aclrtParamHandle paramHandle = nullptr;
    const auto ret = aclrtKernelArgsAppendPlaceHolder(argsHandle, &paramHandle);
    EXPECT_EQ(ret, ACL_SUCCESS);
    argsHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtKernelArgsGetPlaceHolderBuffer_failed_with_invalid_args)
{
    void *bufferAddr = nullptr;
    auto ret = aclrtKernelArgsGetPlaceHolderBuffer(nullptr, nullptr, 0U, &bufferAddr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    auto argsHandle = reinterpret_cast<aclrtArgsHandle>(0x1000U);
    ret = aclrtKernelArgsGetPlaceHolderBuffer(argsHandle, nullptr, 0U, &bufferAddr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    auto paramHandle = reinterpret_cast<aclrtArgsHandle>(0x2000U);
    ret = aclrtKernelArgsGetPlaceHolderBuffer(argsHandle, paramHandle, 0U, &bufferAddr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsKernelArgsGetPlaceHolderBuffer(_,_,_,_))
            .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtKernelArgsGetPlaceHolderBuffer(argsHandle, paramHandle, 0x10U, &bufferAddr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    argsHandle = paramHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtKernelArgsGetPlaceHolderBuffer_success)
{
    auto argsHandle = reinterpret_cast<aclrtArgsHandle>(0x1000U);
    auto paramHandle = reinterpret_cast<aclrtArgsHandle>(0x2000U);
    void *bufferAddr = nullptr;
    auto ret = aclrtKernelArgsGetPlaceHolderBuffer(argsHandle, paramHandle, 0x10U, &bufferAddr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    argsHandle = paramHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtKernelArgsGetHandleMemSize_failed_with_invalid_args)
{
    size_t memSize = 0U;
    auto ret = aclrtKernelArgsGetHandleMemSize(nullptr, &memSize);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsKernelArgsGetHandleMemSize(_,_))
                        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    auto funcHandle = reinterpret_cast<aclrtFuncHandle>(0x1000U);
    ret = aclrtKernelArgsGetHandleMemSize(funcHandle, &memSize);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    funcHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtKernelArgsGetHandleMemSize_success)
{
    auto funcHandle = reinterpret_cast<aclrtFuncHandle>(0x1000U);
    size_t memSize = 0U;
    const auto ret = aclrtKernelArgsGetHandleMemSize(funcHandle, &memSize);
    EXPECT_EQ(ret, ACL_SUCCESS);
    funcHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtKernelArgsGetMemSize_Failed_invalid_args)
{
    size_t actualArgsSize = 0U;
    auto ret = aclrtKernelArgsGetMemSize(nullptr, 0U, &actualArgsSize);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsKernelArgsGetMemSize(_,_,_))
                        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    auto funcHandle = reinterpret_cast<aclrtFuncHandle>(0x1000U);
    ret = aclrtKernelArgsGetMemSize(funcHandle, 0x10U, &actualArgsSize);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    funcHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtKernelArgsGetMemSize_success)
{
    auto funcHandle = reinterpret_cast<aclrtFuncHandle>(0x1000U);
    size_t actualArgsSize = 0U;
    const auto ret = aclrtKernelArgsGetMemSize(funcHandle, 0x10U, &actualArgsSize);
    EXPECT_EQ(ret, ACL_SUCCESS);
    funcHandle = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtKernelArgsParaUpdate_failed_with_invalid_args)
{
    auto ret = aclrtKernelArgsParaUpdate(nullptr, nullptr, nullptr, 0U);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    auto argsHandle = reinterpret_cast<aclrtArgsHandle>(0x1000U);
    ret = aclrtKernelArgsParaUpdate(argsHandle, nullptr, nullptr, 0U);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    auto paramHandle = reinterpret_cast<aclrtParamHandle>(0x2000U);
    ret = aclrtKernelArgsParaUpdate(argsHandle, paramHandle, nullptr, 0U);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    auto *para = reinterpret_cast<void *>(0x3000U);
    ret = aclrtKernelArgsParaUpdate(argsHandle, paramHandle, para, 0U);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsKernelArgsParaUpdate(_,_,_,_))
                        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtKernelArgsParaUpdate(argsHandle, paramHandle, para, 0x10U);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    argsHandle = paramHandle = para = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtKernelArgsParaUpdate_success)
{
    auto argsHandle = reinterpret_cast<aclrtArgsHandle>(0x1000U);
    auto paramHandle = reinterpret_cast<aclrtParamHandle>(0x2000U);
    auto *para = reinterpret_cast<void *>(0x3000U);
    auto ret = aclrtKernelArgsParaUpdate(argsHandle, paramHandle, para, 0x10U);
    EXPECT_EQ(ret, ACL_SUCCESS);
    argsHandle = paramHandle = para = nullptr;
}

TEST_F(UTEST_ACL_Runtime, aclrtMallocWithCfg_with_null_addr)
{
    size_t size = 1024U;
    aclrtMemMallocPolicy policy = ACL_MEM_MALLOC_HUGE_FIRST;

    auto ret = aclrtMallocWithCfg(nullptr, size, policy, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtMallocWithCfg_with_invalid_size_0)
{
    void *devPtr = nullptr;
    size_t size = 0U;
    aclrtMemMallocPolicy policy = ACL_MEM_MALLOC_HUGE_FIRST;

    auto ret = aclrtMallocWithCfg(&devPtr, size, policy, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtMallocWithCfg_succ_without_cfg)
{
    void *devPtr = nullptr;
    size_t size = 1024U;
    aclrtMemMallocPolicy policy = ACL_MEM_MALLOC_HUGE_FIRST;

    auto ret = aclrtMallocWithCfg(&devPtr, size, policy, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    aclrtMallocConfig cfg = {nullptr, 0U};
    ret = aclrtMallocWithCfg(&devPtr, size, policy, &cfg);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtMallocWithCfg_succ_without_advise)
{
    void *devPtr = nullptr;
    size_t size = 1024U;
    aclrtMemMallocPolicy policy = ACL_MEM_MALLOC_HUGE_FIRST;

    aclrtMallocAttribute attrs;
    attrs.attr = ACL_RT_MEM_ATTR_MODULE_ID;
    attrs.value.moduleId = APP_MODE_ID;
    aclrtMallocConfig cfg = {&attrs, 1U};
    auto ret = aclrtMallocWithCfg(&devPtr, size, policy, &cfg);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtMallocWithCfg_fail_with_rts_error)
{
    void *devPtr = nullptr;
    size_t size = 1024U;
    aclrtMemMallocPolicy policy = ACL_MEM_MALLOC_HUGE_FIRST;

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsMalloc(_,_,_,_,_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID))
        .WillRepeatedly(Return(RT_ERROR_NONE));
    auto ret = aclrtMallocWithCfg(&devPtr, size, policy, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtMallocWithCfg_with_invalid_cfg_num)
{
    void *devPtr = nullptr;
    size_t size = 1024U;
    aclrtMemMallocPolicy policy = ACL_MEM_MALLOC_HUGE_FIRST;
    aclrtMallocConfig cfg = {nullptr, 1U};
    auto ret = aclrtMallocWithCfg(&devPtr, size, policy, &cfg);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtMallocForTaskScheduler_succ_without_cfg)
{
    void *devPtr = nullptr;
    size_t size = 1024U;
    aclrtMemMallocPolicy policy = ACL_MEM_MALLOC_HUGE_FIRST;

    auto ret = aclrtMallocForTaskScheduler(&devPtr, size, policy, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtMallocForTaskScheduler_succ_whith_cfg02)
{
    void *devPtr = nullptr;
    size_t size = 1024U;
    aclrtMemMallocPolicy policy = ACL_MEM_MALLOC_HUGE_FIRST;

    aclrtMallocAttribute attrs;
    attrs.attr = ACL_RT_MEM_ATTR_MODULE_ID;
    attrs.value.moduleId = APP_MODE_ID;
    aclrtMallocConfig cfg = {&attrs, 1U};
    auto ret = aclrtMallocForTaskScheduler(&devPtr, size, policy, &cfg);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtMallocForTaskScheduler_fail_with_rts_error)
{
    void *devPtr = nullptr;
    size_t size = 1024U;
    aclrtMemMallocPolicy policy = ACL_MEM_MALLOC_HUGE_FIRST;

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsMalloc(_,_,_,_,_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID))
        .WillRepeatedly(Return(RT_ERROR_NONE));
    auto ret = aclrtMallocForTaskScheduler(&devPtr, size, policy, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtMallocHostWithCfg_succ_without_cfg)
{
    void *hostPtr;
    uint64_t size = 1024U;
    auto ret = aclrtMallocHostWithCfg(&hostPtr, size, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtMallocHostWithCfg_succ_with_cfg)
{
    void *hostPtr;
    uint64_t size = 1024U;
    aclrtMallocAttribute attrs;
    attrs.attr = ACL_RT_MEM_ATTR_MODULE_ID;
    attrs.value.moduleId = APP_MODE_ID;
    aclrtMallocConfig cfg = {&attrs, 1U};
    auto ret = aclrtMallocHostWithCfg(&hostPtr, size, &cfg);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtMallocHostWithCfg_fail_with_invalid_addr)
{
    uint64_t size = 1024U;
    auto ret = aclrtMallocHostWithCfg(nullptr, size, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtMallocHostWithCfg_fail_with_invalid_0_size)
{
    void *hostPtr;
    uint64_t size = 0U;
    auto ret = aclrtMallocHostWithCfg(&hostPtr, size, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtMallocHostWithCfg_fail_with_rts_error)
{
    void *hostPtr;
    uint64_t size = 1024U;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsMallocHost(_,_,_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID))
        .WillRepeatedly(Return(RT_ERROR_NONE));
    auto ret = aclrtMallocHostWithCfg(&hostPtr, size, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtPointerGetAttributes_succ)
{
    void *ptr = (void*)0xff;
    aclrtPtrAttributes attributes;
    auto ret = aclrtPointerGetAttributes(ptr, &attributes);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtPointerGetAttributes_failed01)
{
    void *ptr = nullptr;
    aclrtPtrAttributes attributes;
    auto ret = aclrtPointerGetAttributes(ptr, &attributes);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtPointerGetAttributes_failed02)
{
    void *ptr = (void*)0xff;
    aclrtPtrAttributes attributes;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsPointerGetAttributes(_,_))
        .WillOnce(Return(ACL_ERROR_RT_FAILURE));
    auto ret = aclrtPointerGetAttributes(ptr, &attributes);
    EXPECT_EQ(ret, ACL_ERROR_RT_FAILURE);
}

TEST_F(UTEST_ACL_Runtime, aclrtHostRegister_succ)
{
    void *ptr = (void*)0xff;
    uint64_t size = 1024UL;
    aclrtHostRegisterType type = {};
    void *devPtr = nullptr;
    auto ret = aclrtHostRegister(ptr, size, type, &devPtr);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtHostRegister_failed01)
{
    void *ptr = nullptr;
    uint64_t size = 1024UL;
    aclrtHostRegisterType type = {};
    void *devPtr = nullptr;
    auto ret = aclrtHostRegister(ptr, size, type, &devPtr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtHostRegister_failed02)
{
    void *ptr = (void*)0xff;
    uint64_t size = 0UL;
    aclrtHostRegisterType type = {};
    void *devPtr = nullptr;
    auto ret = aclrtHostRegister(ptr, size, type, &devPtr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtHostRegister_failed03)
{
    void *ptr = (void*)0xff;
    uint64_t size = 1024UL;
    aclrtHostRegisterType type = {};
    void *devPtr = nullptr;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsHostRegister(_,_,_,_))
        .WillOnce(Return(ACL_ERROR_RT_FAILURE));
    auto ret = aclrtHostRegister(ptr, size, type, &devPtr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FAILURE);
}

TEST_F(UTEST_ACL_Runtime, aclrtHostUnregister_succ)
{
    void *ptr = (void*)0xff;
    auto ret = aclrtHostUnregister(ptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtHostUnregister_failed01)
{
    void *ptr = nullptr;
    auto ret = aclrtHostUnregister(ptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtHostUnregister_failed02)
{
    void *ptr = (void*)0xff;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsHostUnregister(_))
        .WillOnce(Return(ACL_ERROR_RT_FAILURE));
    auto ret = aclrtHostUnregister(ptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FAILURE);
}

TEST_F(UTEST_ACL_Runtime, aclrtHostRegisterV2_succ)
{
    void *ptr = (void*)0xff;
    uint64_t size = 1024UL;
    uint32_t flag = ACL_HOST_REG_MAPPED;
    auto ret = aclrtHostRegisterV2(ptr, size, flag);
    EXPECT_EQ(ret, ACL_SUCCESS);

    flag = ACL_HOST_REG_PINNED;
    ret = aclrtHostRegisterV2(ptr, size, flag);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtHostRegisterV2_failed01)
{
    void *ptr = nullptr;
    uint64_t size = 1024UL;
    uint32_t flag = ACL_HOST_REG_MAPPED;
    auto ret = aclrtHostRegisterV2(ptr, size, flag);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtHostRegisterV2_failed02)
{
    void *ptr = (void*)0xff;
    uint64_t size = 0UL;
    uint32_t flag = ACL_HOST_REG_MAPPED;
    auto ret = aclrtHostRegisterV2(ptr, size, flag);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtHostRegisterV2_failed03)
{
    void *ptr = (void*)0xff;
    uint64_t size = 1024UL;
    uint32_t flag = ACL_HOST_REG_MAPPED;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtHostRegisterV2(_,_,_))
        .WillOnce(Return(ACL_ERROR_RT_FAILURE));
    auto ret = aclrtHostRegisterV2(ptr, size, flag);
    EXPECT_EQ(ret, ACL_ERROR_RT_FAILURE);
}

TEST_F(UTEST_ACL_Runtime, aclrtHostGetDevicePointer_succ)
{
    void *pHost = (void*)0xff;
    void *pDevice = nullptr;
    uint32_t flag = 0U;
    auto ret = aclrtHostGetDevicePointer(pHost, &pDevice, flag);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtHostGetDevicePointer_failed01)
{
    void *pHost = nullptr;
    void *pDevice = nullptr;
    uint32_t flag = 0U;
    auto ret = aclrtHostGetDevicePointer(pHost, &pDevice, flag);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtHostGetDevicePointer_failed02)
{
    void *pHost = (void*)0xff;
    void *pDevice = nullptr;
    uint32_t flag = 1U;
    auto ret = aclrtHostGetDevicePointer(pHost, &pDevice, flag);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtHostGetDevicePointer_failed03)
{
    void *pHost = (void*)0xff;
    void *pDevice = nullptr;
    uint32_t flag = 0U;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtHostGetDevicePointer(_,_,_))
        .WillOnce(Return(ACL_ERROR_RT_FAILURE));
    auto ret = aclrtHostGetDevicePointer(pHost, &pDevice, flag);
    EXPECT_EQ(ret, ACL_ERROR_RT_FAILURE);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetThreadLastTaskId_succ)
{
    uint32_t taskId = 0;
    auto ret = aclrtGetThreadLastTaskId(&taskId);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetThreadLastTaskId_failed)
{
    uint32_t taskId = 0;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsGetThreadLastTaskId(_))
        .WillOnce(Return(ACL_ERROR_RT_FAILURE));
    auto ret = aclrtGetThreadLastTaskId(&taskId);
    EXPECT_EQ(ret, ACL_ERROR_RT_FAILURE);
}

TEST_F(UTEST_ACL_Runtime, aclrtStreamGetId_succ)
{
    aclrtStream stream = (aclrtStream)0x01;
    int32_t streamId = 0;
    auto ret = aclrtStreamGetId(stream, &streamId);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtStreamGetId_failed)
{
    aclrtStream stream = (aclrtStream)0x01;
    int32_t streamId = 0;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsStreamGetId(_,_))
        .WillOnce(Return(ACL_ERROR_RT_FAILURE));
    auto ret = aclrtStreamGetId(stream, &streamId);
    EXPECT_EQ(ret, ACL_ERROR_RT_FAILURE);
}

TEST_F(UTEST_ACL_Runtime, aclrtValueWrite_failed_with_invalid_args)
{
    auto ret = aclrtValueWrite(nullptr, 100, 0, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsValueWrite(_,_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    auto devAddr = reinterpret_cast<void *>(0x1000U);
    ret = aclrtValueWrite(devAddr, 100, 0, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtValueWrite_success)
{
    auto devAddr = reinterpret_cast<void *>(0x1000U);
    const auto ret = aclrtValueWrite(devAddr, 100, 0, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtValueWait_failed_with_invalid_args)
{
    auto ret = aclrtValueWait(nullptr, 100, ACL_STREAM_WAIT_VALUE_GEQ, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsValueWait(_,_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    auto devAddr = reinterpret_cast<void *>(0x1000U);
    ret = aclrtValueWait(devAddr, 100, ACL_STREAM_WAIT_VALUE_GEQ, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtValueWait_success)
{
    auto devAddr = reinterpret_cast<void *>(0x1000U);
    const auto ret = aclrtValueWait(devAddr, 100, ACL_STREAM_WAIT_VALUE_GEQ, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetStreamAvailableNum_failed_with_invalid_args)
{
    auto ret = aclrtGetStreamAvailableNum(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsStreamGetAvailableNum(_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    uint32_t streamCount = 0;
    ret = aclrtGetStreamAvailableNum(&streamCount);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetStreamAvailableNum_success)
{
    uint32_t streamCount = 0;
    const auto ret = aclrtGetStreamAvailableNum(&streamCount);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetStreamAttribute_failed_with_invalid_args)
{
    aclrtStreamAttr stmAttrType = ACL_STREAM_ATTR_FAILURE_MODE;
    auto ret = aclrtSetStreamAttribute(nullptr, stmAttrType, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    aclrtStream stream = (aclrtStream)0x01;
    ret = aclrtSetStreamAttribute(stream, stmAttrType, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsStreamSetAttribute(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    aclrtStreamAttrValue value;
    ret = aclrtSetStreamAttribute(stream, stmAttrType, &value);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetStreamAttribute_success)
{
    aclrtStreamAttr stmAttrType = ACL_STREAM_ATTR_FAILURE_MODE;
    aclrtStream stream = (aclrtStream)0x01;
    aclrtStreamAttrValue value;
    const auto ret = aclrtSetStreamAttribute(stream, stmAttrType, &value);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetStreamAttribute_failed_with_invalid_args)
{
    aclrtStreamAttr stmAttrType = ACL_STREAM_ATTR_FAILURE_MODE;
    auto ret = aclrtGetStreamAttribute(nullptr, stmAttrType, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    aclrtStream stream = (aclrtStream)0x01;
    ret = aclrtGetStreamAttribute(stream, stmAttrType, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsStreamGetAttribute(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    aclrtStreamAttrValue value;
    ret = aclrtGetStreamAttribute(stream, stmAttrType, &value);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetStreamAttribute_success)
{
    aclrtStreamAttr stmAttrType = ACL_STREAM_ATTR_FAILURE_MODE;
    aclrtStream stream = (aclrtStream)0x01;
    aclrtStreamAttrValue value;
    const auto ret = aclrtGetStreamAttribute(stream, stmAttrType, &value);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtCreateNotify_failed_with_invalid_args)
{
    auto ret = aclrtCreateNotify(nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsNotifyCreate(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    aclrtNotify notify = (aclrtNotify)0x01;
    ret = aclrtCreateNotify(&notify, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCreateNotify_success)
{
    aclrtNotify notify = (aclrtNotify)0x01;
    const auto ret = aclrtCreateNotify(&notify, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtDestroyNotify_failed_with_invalid_args)
{
    auto ret = aclrtDestroyNotify(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsNotifyDestroy(_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    aclrtNotify notify = (aclrtNotify)0x01;
    ret = aclrtDestroyNotify(notify);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtDestroyNotify_success)
{
    aclrtNotify notify = (aclrtNotify)0x01;
    const auto ret = aclrtDestroyNotify(notify);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtCntNotifyCreate)
{
    aclrtNotify cntNotify = nullptr;
    auto ret = aclrtCntNotifyCreate(&cntNotify, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtCntNotifyCreateServer(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtCntNotifyCreate(&cntNotify, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCntNotifyDestroy)
{
    aclrtNotify cntNotify = nullptr;
    auto ret = aclrtCntNotifyDestroy(cntNotify);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtCntNotifyDestroy(_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtCntNotifyDestroy(cntNotify);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtRecordNotify_failed_with_invalid_args)
{
    auto ret = aclrtRecordNotify(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsNotifyRecord(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    aclrtNotify notify = (aclrtNotify)0x01;
    ret = aclrtRecordNotify(notify, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtRecordNotify_success)
{
    aclrtNotify notify = (aclrtNotify)0x01;
    const auto ret = aclrtRecordNotify(notify, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtWaitAndResetNotify_failed_with_invalid_args)
{
    auto ret = aclrtWaitAndResetNotify(nullptr, nullptr, 1);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsNotifyWaitAndReset(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    aclrtNotify notify = (aclrtNotify)0x01;
    ret = aclrtWaitAndResetNotify(notify, nullptr, 1);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtWaitAndResetNotify_success)
{
    aclrtNotify notify = (aclrtNotify)0x01;
    const auto ret = aclrtWaitAndResetNotify(notify, nullptr, 1);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetNotifyId_failed_with_invalid_args)
{
    auto ret = aclrtGetNotifyId(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    aclrtNotify notify = (aclrtNotify)0x01;
    ret = aclrtGetNotifyId(notify, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsNotifyGetId(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    uint32_t notifyId = 0;
    ret = aclrtGetNotifyId(notify, &notifyId);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetNotifyId_success)
{
    aclrtNotify notify = (aclrtNotify)0x01;
    uint32_t notifyId = 0;
    const auto ret = aclrtGetNotifyId(notify, &notifyId);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetEventId_failed_with_invalid_args)
{
    auto ret = aclrtGetEventId(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    aclrtEvent event = (aclrtEvent)0x01;
    ret = aclrtGetEventId(event, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsEventGetId(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    uint32_t eventId = 0;
    ret = aclrtGetEventId(event, &eventId);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetEventId_success)
{
    aclrtEvent event = (aclrtEvent)0x01;
    uint32_t eventId = 0;
    const auto ret = aclrtGetEventId(event, &eventId);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetEventAvailNum_failed_with_invalid_args)
{
    auto ret = aclrtGetEventAvailNum(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsEventGetAvailNum(_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    uint32_t eventCount = 0;
    ret = aclrtGetEventAvailNum(&eventCount);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetEventAvailNum_success)
{
    uint32_t eventCount = 0;
    const auto ret = aclrtGetEventAvailNum(&eventCount);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetDeviceInfo_failed_with_invalid_args)
{
    uint32_t deviceId = 0;
    aclrtDevAttr attr = ACL_DEV_ATTR_AICPU_CORE_NUM;
    auto ret = aclrtGetDeviceInfo(deviceId, attr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsDeviceGetInfo(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    int64_t value = 0;
    ret = aclrtGetDeviceInfo(deviceId, attr, &value);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetDeviceInfo_success)
{
    uint32_t deviceId = 0;
    aclrtDevAttr attr = ACL_DEV_ATTR_AICPU_CORE_NUM;
    int64_t value = 0;
    const auto ret = aclrtGetDeviceInfo(deviceId, attr, &value);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtDeviceGetStreamPriorityRange_success)
{
    int32_t leastPriority = 0;
    int32_t greatestPriority = 0;
    auto ret = aclrtDeviceGetStreamPriorityRange(&leastPriority, &greatestPriority);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtDeviceGetStreamPriorityRange(nullptr, &greatestPriority);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtDeviceGetStreamPriorityRange(&leastPriority, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtDeviceGetStreamPriorityRange(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetDeviceCapability_failed_with_invalid_args)
{
    int32_t deviceId = 0;
    aclrtDevFeatureType devFeatureType = ACL_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV;
    auto ret = aclrtGetDeviceCapability(deviceId, devFeatureType, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsDeviceGetCapability(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    int32_t value = 0;
    ret = aclrtGetDeviceCapability(deviceId, devFeatureType, &value);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetDeviceCapability_success)
{
    int32_t deviceId = 0;
    aclrtDevFeatureType devFeatureType = ACL_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV;
    int32_t value = 0;
    const auto ret = aclrtGetDeviceCapability(deviceId, devFeatureType, &value);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtDeviceGetUuid_failed_with_invalid_args)
{
    int32_t deviceId = 0;
    aclrtUuid uuid = {0};
    
    auto ret = aclrtDeviceGetUuid(deviceId, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDeviceUuid(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtDeviceGetUuid(deviceId, &uuid);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtDeviceGetUuid_success)
{
    int32_t deviceId = 0;
    aclrtUuid uuid = {0};
    const auto ret = aclrtDeviceGetUuid(deviceId, &uuid);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtCtxGetCurrentDefaultStream_failed_with_invalid_args)
{
    auto ret = aclrtCtxGetCurrentDefaultStream(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsCtxGetCurrentDefaultStream(_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    aclrtStream stream = (aclrtStream)0x01;
    ret = aclrtCtxGetCurrentDefaultStream(&stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCtxGetCurrentDefaultStream_success)
{
    aclrtStream stream = (aclrtStream)0x01;
    const auto ret = aclrtCtxGetCurrentDefaultStream(&stream);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetPrimaryCtxState_success)
{
    int32_t devId = 0;
    uint32_t *flags = nullptr;
    int active = 0;
    const auto ret = aclrtGetPrimaryCtxState(devId, flags, &active);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtGrimaryCtxState_iled_with_invliad_active)
{
    int32_t devId = 0;
    uint32_t *flags = nullptr;
    const auto ret = aclrtGetPrimaryCtxState(devId, flags, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtGrimaryCtxState_iled_with_invliad_flags)
{
    int32_t devId = 0;
    uint32_t flags;
    int active = 0;
    const auto ret = aclrtGetPrimaryCtxState(devId, &flags, &active);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtGrimaryCtxState_iled_with_rts_error)
{
    int32_t devId = 0;
    uint32_t *flags = nullptr;
    int active = 0;

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsGetPrimaryCtxState(_,_,_))
    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    const auto ret = aclrtGetPrimaryCtxState(devId, flags, &active);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclmdlRIBuildBegin_failed_with_invalid_args)
{
    auto ret = aclmdlRIBuildBegin(nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsModelCreate(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    aclmdlRI modelRI = (aclmdlRI)0x01;
    ret = aclmdlRIBuildBegin(&modelRI, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclmdlRIBuildBegin_success)
{
    aclmdlRI modelRI = (aclmdlRI)0x01;
    const auto ret = aclmdlRIBuildBegin(&modelRI, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclmdlRIBindStream_failed_with_invalid_args)
{
    aclmdlRI modelRI = (aclmdlRI)0x01;
    auto ret = aclmdlRIBindStream(nullptr, nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsModelBindStream(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclmdlRIBindStream(modelRI, nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclmdlRIBindStream_success)
{
    aclmdlRI modelRI = (aclmdlRI)0x01;
    aclrtStream stream = (aclrtStream)0x01;
    const auto ret = aclmdlRIBindStream(modelRI, stream, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclmdlRIEndTask_failed_with_invalid_args)
{
    aclmdlRI modelRI = (aclmdlRI)0x01;
    auto ret = aclmdlRIEndTask(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsEndGraph(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclmdlRIEndTask(modelRI, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclmdlRIEndTask_success)
{
    aclmdlRI modelRI = (aclmdlRI)0x01;
    const auto ret = aclmdlRIEndTask(modelRI, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclmdlRIBuildEnd_failed_with_invalid_args)
{
    aclmdlRI modelRI = (aclmdlRI)0x01;
    void *reserve = (void *)0x01;
    auto ret = aclmdlRIBuildEnd(nullptr, reserve);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclmdlRIBuildEnd(modelRI, reserve);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsModelLoadComplete(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclmdlRIBuildEnd(modelRI, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclmdlRIBuildEnd_success)
{
    aclmdlRI modelRI = (aclmdlRI)0x01;
    const auto ret = aclmdlRIBuildEnd(modelRI, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclmdlRIUnbindStream_failed_with_invalid_args)
{
    aclmdlRI modelRI = (aclmdlRI)0x01;
    auto ret = aclmdlRIUnbindStream(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsModelUnbindStream(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclmdlRIUnbindStream(modelRI, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclmdlRIUnbindStream_success)
{
    aclmdlRI modelRI = (aclmdlRI)0x01;
    const auto ret = aclmdlRIUnbindStream(modelRI, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclmdlRIExecute_failed_with_invalid_args)
{
    aclmdlRI modelRI = (aclmdlRI)0x01;
    int32_t timeout = -1;
    auto ret = aclmdlRIExecute(nullptr, timeout);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsModelExecute(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclmdlRIExecute(modelRI, timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclmdlRIExecute_success)
{
    aclmdlRI modelRI = (aclmdlRI)0x01;
    int32_t timeout = -1;
    const auto ret = aclmdlRIExecute(modelRI, timeout);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtReduceAsync_failed_with_invalid_args)
{
    void *dst = reinterpret_cast<void *>(0x04);
    void *src = reinterpret_cast<void *>(0x04);
    void *reserve = (void *)0x01;
    uint64_t count = 10;
    aclrtReduceKind kind = ACL_RT_MEMCPY_SDMA_AUTOMATIC_SUM;
    aclDataType type = ACL_INT8;

    auto ret = aclrtReduceAsync(nullptr, nullptr, count, kind, type, nullptr, reserve);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtReduceAsync(dst, nullptr, count, kind, type, nullptr, reserve);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    type = ACL_DT_UNDEFINED;
    ret = aclrtReduceAsync(dst, src, count, kind, type, nullptr, reserve);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsLaunchReduceAsyncTask(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    type = ACL_INT8;
    ret = aclrtReduceAsync(dst, src, count, kind, type, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtReduceAsync_success)
{
    void *dst = reinterpret_cast<void *>(0x04);
    void *src = reinterpret_cast<void *>(0x04);
    uint64_t count = 10;
    aclrtReduceKind kind = ACL_RT_MEMCPY_SDMA_AUTOMATIC_SUM;
    aclDataType type = ACL_FLOAT;
    auto ret = aclrtReduceAsync(dst, src, count, kind, type, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    type = ACL_FLOAT16;
    ret = aclrtReduceAsync(dst, src, count, kind, type, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    type = ACL_INT16;
    ret = aclrtReduceAsync(dst, src, count, kind, type, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    type = ACL_INT4;
    ret = aclrtReduceAsync(dst, src, count, kind, type, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    type = ACL_INT8;
    ret = aclrtReduceAsync(dst, src, count, kind, type, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    type = ACL_INT32;
    ret = aclrtReduceAsync(dst, src, count, kind, type, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    type = ACL_BF16;
    ret = aclrtReduceAsync(dst, src, count, kind, type, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    type = ACL_UINT8;
    ret = aclrtReduceAsync(dst, src, count, kind, type, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    type = ACL_UINT16;
    ret = aclrtReduceAsync(dst, src, count, kind, type, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    type = ACL_UINT32;
    ret = aclrtReduceAsync(dst, src, count, kind, type, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetDeviceResLimit_failed_with_invalid_args)
{
    const int32_t deviceId = 0x01;
    aclrtDevResLimitType type = ACL_RT_DEV_RES_CUBE_CORE;
    uint32_t value = 0;
    auto ret = aclrtGetDeviceResLimit(deviceId, type, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsGetDeviceResLimit(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtGetDeviceResLimit(deviceId, type, &value);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetDeviceResLimit_success)
{
    const int32_t deviceId = 0x01;
    aclrtDevResLimitType type = ACL_RT_DEV_RES_CUBE_CORE;
    uint32_t value = 0;
    const auto ret = aclrtGetDeviceResLimit(deviceId, type, &value);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetDeviceResLimit_failed_with_invalid_args)
{
    const int32_t deviceId = 0x01;
    aclrtDevResLimitType type = ACL_RT_DEV_RES_CUBE_CORE;
    uint32_t value = 0;

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsSetDeviceResLimit(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    const auto ret = aclrtSetDeviceResLimit(deviceId, type, value);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetDeviceResLimit_success)
{
    const int32_t deviceId = 0x01;
    aclrtDevResLimitType type = ACL_RT_DEV_RES_CUBE_CORE;
    uint32_t value = 0;
    const auto ret = aclrtSetDeviceResLimit(deviceId, type, value);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtResetDeviceResLimit_failed_with_invalid_args)
{
    const int32_t deviceId = 0x01;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsResetDeviceResLimit(_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    const auto ret = aclrtResetDeviceResLimit(deviceId);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtResetDeviceResLimit_success)
{
    const int32_t deviceId = 0x01;
    const auto ret = aclrtResetDeviceResLimit(deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetStreamResLimit_failed_with_invalid_args)
{
    aclrtDevResLimitType type = ACL_RT_DEV_RES_CUBE_CORE;

    aclrtStream stream = (aclrtStream)0x01;
    auto ret = aclrtGetStreamResLimit(stream, type, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsGetStreamResLimit(_,_,_))
        .WillRepeatedly(Return(ACL_ERROR_RT_PARAM_INVALID));

    uint32_t value = 0;
    ret = aclrtGetStreamResLimit(nullptr, type, &value);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    stream = (aclrtStream)0x01;
    ret = aclrtGetStreamResLimit(stream, type, &value);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetStreamResLimit_success)
{
    aclrtStream stream = (aclrtStream)0x01;
    aclrtDevResLimitType type = ACL_RT_DEV_RES_CUBE_CORE;
    uint32_t value = 0;
    const auto ret = aclrtGetStreamResLimit(stream, type, &value);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetStreamResLimit_failed_with_invalid_args)
{
    aclrtDevResLimitType type = ACL_RT_DEV_RES_CUBE_CORE;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsSetStreamResLimit(_,_,_))
        .WillRepeatedly(Return(ACL_ERROR_RT_PARAM_INVALID));

    uint32_t value = 0;
    auto ret = aclrtSetStreamResLimit(nullptr, type, value);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    aclrtStream stream = (aclrtStream)0x01;
    ret = aclrtSetStreamResLimit(stream, type, value);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetStreamResLimit_success)
{
    aclrtStream stream = (aclrtStream)0x01;
    aclrtDevResLimitType type = ACL_RT_DEV_RES_CUBE_CORE;
    uint32_t value = 0;
    const auto ret = aclrtSetStreamResLimit(stream, type, value);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtResetStreamResLimit_failed_with_invalid_args)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsResetStreamResLimit(_))
        .WillRepeatedly(Return(ACL_ERROR_RT_PARAM_INVALID));

    auto ret = aclrtResetStreamResLimit(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    aclrtStream stream = (aclrtStream)0x01;
    ret = aclrtResetStreamResLimit(stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtResetStreamResLimit_success)
{
    aclrtStream stream = (aclrtStream)0x01;
    const auto ret = aclrtResetStreamResLimit(stream);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtUseStreamResInCurrentThread_failed_with_invalid_args)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsUseStreamResInCurrentThread(_))
        .WillRepeatedly(Return(ACL_ERROR_RT_PARAM_INVALID));

    auto ret = aclrtUseStreamResInCurrentThread(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    aclrtStream stream = (aclrtStream)0x01;
    ret = aclrtUseStreamResInCurrentThread(stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtUseStreamResInCurrentThread_success)
{
    aclrtStream stream = (aclrtStream)0x01;
    const auto ret = aclrtUseStreamResInCurrentThread(stream);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtUnuseStreamResInCurrentThread_failed_with_invalid_args)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsNotUseStreamResInCurrentThread(_))
        .WillRepeatedly(Return(ACL_ERROR_RT_PARAM_INVALID));

    auto ret = aclrtUnuseStreamResInCurrentThread(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    aclrtStream stream = (aclrtStream)0x01;
    ret = aclrtUnuseStreamResInCurrentThread(stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtUnuseStreamResInCurrentThread_success)
{
    aclrtStream stream = (aclrtStream)0x01;
    const auto ret = aclrtUnuseStreamResInCurrentThread(stream);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetResInCurrentThread_failed_with_invalid_args)
{
    aclrtDevResLimitType type = ACL_RT_DEV_RES_CUBE_CORE;
    auto ret = aclrtGetResInCurrentThread(type, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsGetResInCurrentThread(_, _))
        .WillRepeatedly(Return(ACL_ERROR_RT_PARAM_INVALID));
    uint32_t value = 0;
    ret = aclrtGetResInCurrentThread(type, &value);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetResInCurrentThread_success)
{
    aclrtDevResLimitType type = ACL_RT_DEV_RES_CUBE_CORE;
    uint32_t value = 0;
    const auto ret = aclrtGetResInCurrentThread(type, &value);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclmdlRISetName_failed_with_invalid_args)
{
    aclmdlRI modelRI = (aclmdlRI)0x01;
    const char *name = "name";
    auto ret = aclmdlRISetName(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclmdlRISetName(modelRI, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsModelSetName(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclmdlRISetName(modelRI, name);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclmdlRISetName_success)
{
    aclmdlRI modelRI = (aclmdlRI)0x01;
    const char *name = "name";
    const auto ret = aclmdlRISetName(modelRI, name);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclmdlRIGetName_failed_with_invalid_args)
{
    aclmdlRI modelRI = (aclmdlRI)0x01;
    constexpr uint32_t maxLen = 10;
    char name[maxLen] = {0};
    auto ret = aclmdlRIGetName(nullptr, maxLen, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclmdlRIGetName(modelRI, maxLen, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsModelGetName(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclmdlRIGetName(modelRI, maxLen, name);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclmdlRIGetName_success)
{
    aclmdlRI modelRI = (aclmdlRI)0x01;
    constexpr uint32_t maxLen = 10;
    char name[maxLen] = {0};
    const auto ret = aclmdlRIGetName(modelRI, maxLen, name);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtCreateLabel_failed_with_invalid_args)
{
    aclrtLabel label = (aclrtLabel)0x01;
    auto ret = aclrtCreateLabel(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsLabelCreate(_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtCreateLabel(&label);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCreateLabel_success)
{
    aclrtLabel label = (aclrtLabel)0x01;
    const auto ret = aclrtCreateLabel(&label);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetLabel_failed_with_invalid_args)
{
    aclrtLabel label = (aclrtLabel)0x01;
    aclrtStream stream = (aclrtStream)0x01;
    auto ret = aclrtSetLabel(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtSetLabel(label, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsLabelSet(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtSetLabel(label, stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtSetLabel_success)
{
    aclrtLabel label = (aclrtLabel)0x01;
    aclrtStream stream = (aclrtStream)0x01;
    const auto ret = aclrtSetLabel(label, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtDestroyLabel_failed_with_invalid_args)
{
    aclrtLabel label = (aclrtLabel)0x01;
    auto ret = aclrtDestroyLabel(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsLabelDestroy(_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtDestroyLabel(label);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtDestroyLabel_success)
{
    aclrtLabel label = (aclrtLabel)0x01;
    const auto ret = aclrtDestroyLabel(label);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtCreateLabelList_failed_with_invalid_args)
{
    aclrtLabel label = (aclrtLabel)0x01;
    size_t num = 1;
    aclrtLabelList labelList = (aclrtLabelList)0x01;
    auto ret = aclrtCreateLabelList(nullptr, num, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtCreateLabelList(&label, num, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsLabelSwitchListCreate(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtCreateLabelList(&label, num, &labelList);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCreateLabelList_success)
{
    aclrtLabel label = (aclrtLabel)0x01;
    size_t num = 1;
    aclrtLabelList labelList = (aclrtLabelList)0x01;
    const auto ret = aclrtCreateLabelList(&label, num, &labelList);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtDestroyLabelList_failed_with_invalid_args)
{
    aclrtLabelList labelList = (aclrtLabelList)0x01;
    auto ret = aclrtDestroyLabelList(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsLabelSwitchListDestroy(_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtDestroyLabelList(labelList);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtDestroyLabelList_success)
{
    aclrtLabelList labelList = (aclrtLabelList)0x01;
    const auto ret = aclrtDestroyLabelList(labelList);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtSwitchLabelByIndex_failed_with_invalid_args)
{
    void *ptr = (void*)0xff;
    uint32_t maxValue = 1;
    aclrtLabelList labelList = (aclrtLabelList)0x01;
    aclrtStream stream = (aclrtStream)0x01;
    auto ret = aclrtSwitchLabelByIndex(nullptr, maxValue, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtSwitchLabelByIndex(ptr, maxValue, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtSwitchLabelByIndex(ptr, maxValue, labelList, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsLabelSwitchByIndex(_,_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtSwitchLabelByIndex(ptr, maxValue, labelList, stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtSwitchLabelByIndex_success)
{
    void *ptr = (void*)0xff;
    uint32_t maxValue = 1;
    aclrtLabelList labelList = (aclrtLabelList)0x01;
    aclrtStream stream = (aclrtStream)0x01;
    const auto ret = aclrtSwitchLabelByIndex(ptr, maxValue, labelList, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtActiveStream_failed_with_invalid_args)
{
    aclrtStream activeStream = (aclrtStream)0x01;
    aclrtStream stream = (aclrtStream)0x01;
    auto ret = aclrtActiveStream(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtActiveStream(activeStream, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsActiveStream(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtActiveStream(activeStream, stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtActiveStream_success)
{
    aclrtStream activeStream = (aclrtStream)0x01;
    aclrtStream stream = (aclrtStream)0x01;
    const auto ret = aclrtActiveStream(activeStream, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtSwitchStream_failed_with_invalid_args)
{
    void *leftValue = (void*)0xff;
    aclrtCondition cond = ACL_RT_EQUAL;
    void *rightValue = (void*)0xff;
    aclrtCompareDataType dataType = ACL_RT_SWITCH_INT32;
    aclrtStream trueStream = (aclrtStream)0x01;
    aclrtStream falseStream = (aclrtStream)0x01;
    aclrtStream stream = (aclrtStream)0x01;
    auto ret = aclrtSwitchStream(nullptr, cond, nullptr, dataType, nullptr, falseStream, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtSwitchStream(leftValue, cond, nullptr, dataType, nullptr, falseStream, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtSwitchStream(leftValue, cond, rightValue, dataType, nullptr, falseStream, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtSwitchStream(leftValue, cond, rightValue, dataType, trueStream, falseStream, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtSwitchStream(leftValue, cond, rightValue, dataType, trueStream, falseStream, stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsSwitchStream(_,_,_,_,_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtSwitchStream(leftValue, cond, rightValue, dataType, trueStream, nullptr, stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtSwitchStream_success)
{
    void *leftValue = (void*)0xff;
    aclrtCondition cond = ACL_RT_EQUAL;
    void *rightValue = (void*)0xff;
    aclrtCompareDataType dataType = ACL_RT_SWITCH_INT32;
    aclrtStream trueStream = (aclrtStream)0x01;
    aclrtStream stream = (aclrtStream)0x01;
    const auto ret = aclrtSwitchStream(leftValue, cond, rightValue, dataType, trueStream, nullptr, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetFunctionName_failed_with_invalid_args)
{
    aclrtFuncHandle funcHandle = (aclrtFuncHandle)0x01;
    constexpr uint32_t maxLen = 10;
    char name[maxLen] = {0};
    auto ret = aclrtGetFunctionName(nullptr, maxLen, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtGetFunctionName(funcHandle, maxLen, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsFuncGetName(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtGetFunctionName(funcHandle, maxLen, name);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetFunctionName_success)
{
    aclrtFuncHandle funcHandle = (aclrtFuncHandle)0x01;
    constexpr uint32_t maxLen = 10;
    char name[maxLen] = {0};
    const auto ret = aclrtGetFunctionName(funcHandle, maxLen, name);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtAllocBuf_failed_with_invalid_args)
{
    aclrtMbuf mbuf = nullptr;
    uint64_t size = 1;
    auto ret = aclrtAllocBuf(nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtAllocBuf(&mbuf, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufAlloc(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtAllocBuf(&mbuf, size);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(aclrtFreeBuf(mbuf), ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtAllocBuf_success)
{
    aclrtMbuf mbuf = nullptr;
    size_t size = 1;
    const auto ret = aclrtAllocBuf(&mbuf, size);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(aclrtFreeBuf(mbuf), ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtBinaryLoadFromData_failed_with_invalid_args)
{
    void *data = (void*)0x01;
    size_t length = 1;
    aclrtBinHandle *binHandle = (aclrtBinHandle*)0x01;
    auto ret = aclrtBinaryLoadFromData(nullptr, length, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtBinaryLoadFromData(data, length, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsBinaryLoadFromData(_,_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtBinaryLoadFromData(data, length, nullptr, binHandle);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtBinaryLoadFromData_success)
{
    void *data = (void*)0x01;
    size_t length = 1;
    aclrtBinHandle *binHandle = (aclrtBinHandle*)0x01;
    const auto ret = aclrtBinaryLoadFromData(data, length, nullptr, binHandle);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtRegisterCpuFunc_failed_with_invalid_args)
{
    aclrtBinHandle handle = (aclrtBinHandle)0x01;
    const char *funcName = "funcName";
    const char *kernelName = "kernelName";
    aclrtFuncHandle *funcHandle = (aclrtFuncHandle*)0x01;
    auto ret = aclrtRegisterCpuFunc(nullptr, nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtRegisterCpuFunc(handle, nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtRegisterCpuFunc(handle, funcName, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtRegisterCpuFunc(handle, funcName, kernelName, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsRegisterCpuFunc(_,_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtRegisterCpuFunc(handle, funcName, kernelName, funcHandle);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtRegisterCpuFunc_success)
{
    aclrtBinHandle handle = (aclrtBinHandle)0x01;
    const char *funcName = "funcName";
    const char *kernelName = "kernelName";
    aclrtFuncHandle *funcHandle = (aclrtFuncHandle*)0x01;
    const auto ret = aclrtRegisterCpuFunc(handle, funcName, kernelName, funcHandle);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtCmoAsyncWithBarrier_failed_with_invalid_args)
{
    void *src = (void*)0xff;
    size_t size = 1;
    aclrtCmoType cmoType = ACL_RT_CMO_TYPE_PREFETCH;
    uint32_t barrierId = 1;
    aclrtStream stream = (aclrtStream)0x01;
    auto ret = aclrtCmoAsyncWithBarrier(nullptr, size, cmoType, barrierId, stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsCmoAsyncWithBarrier(_,_,_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtCmoAsyncWithBarrier(src, size, cmoType, barrierId, stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCmoAsyncWithBarrier_success)
{
    void *src = (void*)0xff;
    size_t size = 1;
    aclrtCmoType cmoType = ACL_RT_CMO_TYPE_PREFETCH;
    uint32_t barrierId = 1;
    aclrtStream stream = (aclrtStream)0x01;
    const auto ret = aclrtCmoAsyncWithBarrier(src, size, cmoType, barrierId, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtCmoWaitBarrier_failed_with_invalid_args)
{
    aclrtBarrierTaskInfo taskInfo;
    aclrtStream stream = (aclrtStream)0x01;
    uint32_t flag = 0;
    auto ret = aclrtCmoWaitBarrier(nullptr, stream, flag);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    taskInfo.barrierNum = 0U;
    ret = aclrtCmoWaitBarrier(&taskInfo, stream, flag);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    taskInfo.barrierNum = 7U;
    ret = aclrtCmoWaitBarrier(&taskInfo, stream, flag);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsLaunchBarrierTask(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    taskInfo.barrierNum = 1U;
    ret = aclrtCmoWaitBarrier(&taskInfo, stream, flag);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCmoWaitBarrier_success)
{
    aclrtBarrierTaskInfo taskInfo;
    taskInfo.barrierNum = 1U;
    uint32_t flag = 0;
    aclrtStream stream = (aclrtStream)0x01;
    const auto ret = aclrtCmoWaitBarrier(&taskInfo, stream, flag);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetDevicesTopo_failed_with_invalid_args)
{
    uint32_t deviceId = 1;
    uint32_t otherDeviceId = 2;
    uint64_t value = 0;
    auto ret = aclrtGetDevicesTopo(deviceId, otherDeviceId, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsGetPairDevicesInfo(_,_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtGetDevicesTopo(deviceId, otherDeviceId, &value);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetDevicesTopo_success)
{
    uint32_t deviceId = 1;
    uint32_t otherDeviceId = 2;
    uint64_t value = 0;
    auto ret = aclrtGetDevicesTopo(deviceId, otherDeviceId, &value);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtMemcpyBatch_failed_with_invalid_args)
{
    constexpr size_t numBatches = 10UL;
    void **dsts = reinterpret_cast<void **>(0x04);
    size_t destMax[numBatches] = {1, 0, 1, 1, 1, 1, 1, 1, 1, 1};
    void **srcs = reinterpret_cast<void **>(0x04);
    size_t sizes[numBatches] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
    aclrtMemcpyBatchAttr attrs;
    size_t attrsIndexes = 0;
    size_t numAttrs = 1;
    size_t failIndex = 0;

    auto ret = aclrtMemcpyBatch(nullptr, nullptr, nullptr, nullptr, 0, nullptr, nullptr, numAttrs, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtMemcpyBatch(dsts, nullptr, nullptr, nullptr, 0, nullptr, nullptr, numAttrs, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtMemcpyBatch(dsts, destMax, nullptr, nullptr, 0, nullptr, nullptr, numAttrs, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtMemcpyBatch(dsts, destMax, srcs, nullptr, 0, nullptr, nullptr, numAttrs, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtMemcpyBatch(dsts, destMax, srcs, sizes, 0, nullptr, nullptr, numAttrs, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtMemcpyBatch(dsts, destMax, srcs, sizes, 0, &attrs, nullptr, numAttrs, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtMemcpyBatch(dsts, destMax, srcs, sizes, 0, &attrs, &attrsIndexes, numAttrs, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtMemcpyBatch(dsts, destMax, srcs, sizes, 0, &attrs, &attrsIndexes, numAttrs, &failIndex);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtMemcpyBatch(dsts, destMax, srcs, sizes, numBatches, &attrs, &attrsIndexes, numAttrs, &failIndex);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    destMax[1] = 1;
    attrs.rsv[0] = 1;
    ret = aclrtMemcpyBatch(dsts, destMax, srcs, sizes, numBatches, &attrs, &attrsIndexes, numAttrs, &failIndex);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsMemcpyBatch(_,_,_,_,_,_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    constexpr uint32_t rsvMaxSize = sizeof(aclrtMemcpyBatchAttr::rsv) / sizeof(uint8_t);
    for (uint32_t i = 0U; i < rsvMaxSize; i++) {
        attrs.rsv[i] = 0U;
    }
    ret = aclrtMemcpyBatch(dsts, destMax, srcs, sizes, numBatches, &attrs, &attrsIndexes, numAttrs, &failIndex);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtMemcpyBatch_success)
{
    constexpr size_t numBatches = 10UL;
    void **dsts = reinterpret_cast<void **>(0x04);
    size_t destMax[numBatches] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
    void **srcs = reinterpret_cast<void **>(0x04);
    size_t sizes[numBatches] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
    aclrtMemcpyBatchAttr attrs;
    size_t attrsIndexes = 0;
    size_t numAttrs = 1;
    size_t failIndex = 0;
    constexpr uint32_t rsvMaxSize = sizeof(aclrtMemcpyBatchAttr::rsv) / sizeof(uint8_t);
    for (uint32_t i = 0U; i < rsvMaxSize; i++) {
        attrs.rsv[i] = 0U;
    }
    const auto ret = aclrtMemcpyBatch(dsts, destMax, srcs, sizes, numBatches, &attrs, &attrsIndexes, numAttrs, &failIndex);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtMemcpyBatchAsync_failed_with_invalid_args)
{
    constexpr size_t numBatches = 5UL;
    void **dsts = reinterpret_cast<void **>(0x04);
    size_t destMax[numBatches] = {1, 0, 1, 1, 1};
    void **srcs = reinterpret_cast<void **>(0x04);
    size_t sizes[numBatches] = {1, 1, 1, 1, 1};
    aclrtMemcpyBatchAttr attrs;
    size_t attrsIndexes = 0;
    size_t numAttrs = 1;
    size_t failIndex = 0;
    aclrtStream stream = nullptr;

    auto ret = aclrtMemcpyBatchAsync(nullptr, nullptr, nullptr, nullptr, 0,nullptr, nullptr, numAttrs, nullptr,
                                     stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtMemcpyBatchAsync(dsts, nullptr, nullptr, nullptr, 0, nullptr, nullptr, numAttrs, nullptr, stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtMemcpyBatchAsync(dsts, destMax, nullptr, nullptr, 0, nullptr, nullptr, numAttrs, nullptr, stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtMemcpyBatchAsync(dsts, destMax, srcs, nullptr, 0, nullptr, nullptr, numAttrs, nullptr, stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtMemcpyBatchAsync(dsts, destMax, srcs, sizes, 0, nullptr, nullptr, numAttrs, nullptr, stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtMemcpyBatchAsync(dsts, destMax, srcs, sizes, 0, &attrs, nullptr, numAttrs, nullptr, stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtMemcpyBatchAsync(dsts, destMax, srcs, sizes, 0, &attrs, &attrsIndexes, numAttrs, nullptr, stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtMemcpyBatchAsync(dsts, destMax, srcs, sizes, 0, &attrs, &attrsIndexes, numAttrs, &failIndex, stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtMemcpyBatchAsync(dsts, destMax, srcs, sizes, numBatches, &attrs, &attrsIndexes, numAttrs, &failIndex, stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    destMax[1] = 1;
    attrs.rsv[0] = 1;
    ret = aclrtMemcpyBatchAsync(dsts, destMax, srcs, sizes, numBatches, &attrs, &attrsIndexes, numAttrs, &failIndex, stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsMemcpyBatchAsync(_,_,_,_,_,_,_,_,_,_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    constexpr uint32_t rsvMaxSize = sizeof(aclrtMemcpyBatchAttr::rsv) / sizeof(uint8_t);
    for (uint32_t i = 0U; i < rsvMaxSize; i++) {
        attrs.rsv[i] = 0U;
    }
    ret = aclrtMemcpyBatchAsync(dsts, destMax, srcs, sizes, numBatches, &attrs, &attrsIndexes, numAttrs, &failIndex, stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtMemcpyBatchAsync_success)
{
    constexpr size_t numBatches = 5UL;
    void **dsts = reinterpret_cast<void **>(0x04);
    size_t destMax[numBatches] = {1, 1, 1, 1, 1};
    void **srcs = reinterpret_cast<void **>(0x04);
    size_t sizes[numBatches] = {1, 1, 1, 1, 1};
    aclrtMemcpyBatchAttr attrs;
    size_t attrsIndexes = 0;
    size_t numAttrs = 1;
    size_t failIndex = 0;
    attrs.dstLoc.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    attrs.srcLoc.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    constexpr uint32_t rsvMaxSize = sizeof(aclrtMemcpyBatchAttr::rsv) / sizeof(uint8_t);
    for (uint32_t i = 0U; i < rsvMaxSize; i++) {
        attrs.rsv[i] = 0U;
    }
    const auto ret = aclrtMemcpyBatchAsync(dsts, destMax, srcs, sizes, numBatches, &attrs, &attrsIndexes, numAttrs,
                                           &failIndex, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtIpcMemGetExportKey_failed_with_invalid_args)
{
    void *devPtr = (void*)0xff;
    size_t size = 1;
    char key[] = "key";
    size_t len = 3;
    uint64_t flags = 1;
    auto ret = aclrtIpcMemGetExportKey(nullptr, size, nullptr, len, flags);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtIpcMemGetExportKey(devPtr, size, nullptr, len, flags);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsIpcMemGetExportKey(_,_,_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtIpcMemGetExportKey(devPtr, size, key, len, flags);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtIpcMemGetExportKey_success)
{
    void *devPtr = (void*)0xff;
    size_t size = 1;
    char key[] = "key";
    size_t len = 3;
    uint64_t flags = 1;
    const auto ret = aclrtIpcMemGetExportKey(devPtr, size, key, len, flags);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtIpcMemClose_failed_with_invalid_args)
{
    const char *key = "key";
    auto ret = aclrtIpcMemClose(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsIpcMemClose(_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtIpcMemClose(key);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtIpcMemClose_success)
{
    const char *key = "key";
    const auto ret = aclrtIpcMemClose(key);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtIpcMemImportByKey_failed_with_invalid_args)
{
    void *devPtr = nullptr;
    const char *key = "key";
    uint64_t flags = 1;
    auto ret = aclrtIpcMemImportByKey(nullptr, nullptr, flags);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtIpcMemImportByKey(&devPtr, nullptr, flags);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsIpcMemImportByKey(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtIpcMemImportByKey(&devPtr, key, flags);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtIpcMemImportByKey_success)
{
    void *devPtr = nullptr;
    const char *key = "key";
    uint64_t flags = 1;
    const auto ret = aclrtIpcMemImportByKey(&devPtr, key, flags);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtIpcMemSetImportPid_failed_with_invalid_args)
{
    const char *key = "key";
    int32_t pid[] = {1, 2, 3};
    size_t num = 3;
    auto ret = aclrtIpcMemSetImportPid(nullptr, nullptr, num);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtIpcMemSetImportPid(key, nullptr, num);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsIpcMemSetImportPid(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtIpcMemSetImportPid(key, pid, num);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtIpcMemSetImportPid_success)
{
    const char *key = "key";
    int32_t pid[] = {1, 2, 3};
    size_t num = 3;
    const auto ret = aclrtIpcMemSetImportPid(key, pid, num);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtIpcMemImportPidInterServer)
{
    const char *key = "key";
    aclrtServerPid serverPids[3] = {};
    size_t num = 3;
    auto ret = aclrtIpcMemImportPidInterServer(key, serverPids, num);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtIpcMemImportPidInterServer(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtIpcMemImportPidInterServer(key, serverPids, num);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);  
}

TEST_F(UTEST_ACL_Runtime, aclrtIpcSetMemoryAttr)
{
    const char *key = "key";
    aclrtIpcMemAttrType type = ACL_RT_IPC_MEM_ATTR_ACCESS_LINK;
    uint64_t attr = ACL_RT_IPC_MEM_ATTR_ACCESS_LINK_SIO;
    auto ret = aclrtIpcMemSetAttr(key, type, attr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtIpcSetMemoryAttr(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtIpcMemSetAttr(key, type, attr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);  
}

TEST_F(UTEST_ACL_Runtime, aclrtNotifyBatchReset_failed_with_invalid_args)
{
    aclrtNotify notifies = nullptr;
    size_t num = 3;
    auto ret = aclrtNotifyBatchReset(nullptr, num);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsNotifyBatchReset(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtNotifyBatchReset(&notifies, num);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtNotifyBatchReset_success)
{
    aclrtNotify notifies = nullptr;
    size_t num = 3;
    const auto ret = aclrtNotifyBatchReset(&notifies, num);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtNotifyGetExportKey_failed_with_invalid_args)
{
    aclrtNotify notify = (aclrtNotify)0x01;
    char key[] = "key";
    size_t len = 3;
    uint64_t flags = 1;
    auto ret = aclrtNotifyGetExportKey(nullptr, nullptr, len, flags);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtNotifyGetExportKey(notify, nullptr, len, flags);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsNotifyGetExportKey(_,_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtNotifyGetExportKey(notify, key, len, flags);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtNotifyGetExportKey_success)
{
    aclrtNotify notify = (aclrtNotify)0x01;
    char key[] = "key";
    size_t len = 3;
    uint64_t flags = 1;
    const auto ret = aclrtNotifyGetExportKey(notify, key, len, flags);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtNotifyImportByKey_failed_with_invalid_args)
{
    aclrtNotify notify = nullptr;
    const char *key = "key";
    uint64_t flags = 1;
    auto ret = aclrtNotifyImportByKey(nullptr, nullptr, flags);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtNotifyImportByKey(&notify, nullptr, flags);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsNotifyImportByKey(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtNotifyImportByKey(&notify, key, flags);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtNotifyImportByKey_success)
{
    aclrtNotify notify = nullptr;
    const char *key = "key";
    uint64_t flags = 1;
    const auto ret = aclrtNotifyImportByKey(&notify, key, flags);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtNotifySetImportPid_failed_with_invalid_args)
{
    aclrtNotify notify = (aclrtNotify)0x01;
    int32_t pid[] = {1, 2, 3};
    size_t num = 3;
    auto ret = aclrtNotifySetImportPid(nullptr, nullptr, num);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtNotifySetImportPid(notify, nullptr, num);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsNotifySetImportPid(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtNotifySetImportPid(notify, pid, num);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtNotifySetImportPid_success)
{
    aclrtNotify notify = (aclrtNotify)0x01;
    int32_t pid[] = {1, 2, 3};
    size_t num = 3;
    const auto ret = aclrtNotifySetImportPid(notify, pid, num);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtNotifySetImportPidInterServer)
{
    aclrtNotify notify = (aclrtNotify)0x01;
    aclrtServerPid serverPid[3] = {};
    size_t num = 3;
    auto ret = aclrtNotifySetImportPidInterServer(notify, serverPid, num);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtNotifySetImportPidInterServer(_,_,_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtNotifySetImportPidInterServer(notify, serverPid, num);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, InitCallbackManager_InitCallbackTest)
{
    auto &cbMgrInstance = InitCallbackManager::GetInstance();
    auto bakInitCbMap = cbMgrInstance.initCallbackMap_;
    cbMgrInstance.initCallbackMap_.clear();
    auto ret = cbMgrInstance.RegInitCallback(ACL_REG_TYPE_ACL_MODEL, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    ret = cbMgrInstance.RegInitCallback(ACL_REG_TYPE_ACL_MODEL, InitCallback_Success, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = cbMgrInstance.RegInitCallback(ACL_REG_TYPE_ACL_MODEL, InitCallback_Success, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
    ret = cbMgrInstance.RegInitCallback(ACL_REG_TYPE_OTHER, InitCallback_Success, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = cbMgrInstance.RegInitCallback(ACL_REG_TYPE_OTHER, InitCallback_Success, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = cbMgrInstance.UnRegInitCallback(ACL_REG_TYPE_ACL_MODEL, InitCallback_Success);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = cbMgrInstance.UnRegInitCallback(ACL_REG_TYPE_ACL_MODEL, InitCallback_Fail);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
    ret = cbMgrInstance.UnRegInitCallback(ACL_REG_TYPE_OTHER, InitCallback_Success);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = cbMgrInstance.UnRegInitCallback(ACL_REG_TYPE_OTHER, InitCallback_Success);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = cbMgrInstance.UnRegInitCallback(ACL_REG_TYPE_OTHER, InitCallback_Success);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
    cbMgrInstance.initCallbackMap_ = bakInitCbMap;
}

TEST_F(UTEST_ACL_Runtime, aclCallbackManager_FinalizeCallbackTest)
{
    auto &cbMgrInstance = InitCallbackManager::GetInstance();
    auto bakFinalizeCbMap = cbMgrInstance.finalizeCallbackMap_;
    cbMgrInstance.finalizeCallbackMap_.clear();
    auto ret = cbMgrInstance.RegFinalizeCallback(ACL_REG_TYPE_ACL_MODEL, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    ret = cbMgrInstance.RegFinalizeCallback(ACL_REG_TYPE_ACL_MODEL, FinalizeCallback_Success, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = cbMgrInstance.RegFinalizeCallback(ACL_REG_TYPE_ACL_MODEL, FinalizeCallback_Success, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
    ret = cbMgrInstance.RegFinalizeCallback(ACL_REG_TYPE_OTHER, FinalizeCallback_Success, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = cbMgrInstance.RegFinalizeCallback(ACL_REG_TYPE_OTHER, FinalizeCallback_Success, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = cbMgrInstance.UnRegFinalizeCallback(ACL_REG_TYPE_ACL_MODEL, FinalizeCallback_Success);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = cbMgrInstance.UnRegFinalizeCallback(ACL_REG_TYPE_ACL_MODEL, FinalizeCallback_Fail);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
    ret = cbMgrInstance.UnRegFinalizeCallback(ACL_REG_TYPE_OTHER, FinalizeCallback_Success);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = cbMgrInstance.UnRegFinalizeCallback(ACL_REG_TYPE_OTHER, FinalizeCallback_Success);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = cbMgrInstance.UnRegFinalizeCallback(ACL_REG_TYPE_OTHER, FinalizeCallback_Success);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
    cbMgrInstance.finalizeCallbackMap_ = bakFinalizeCbMap;
}

TEST_F(UTEST_ACL_Runtime, aclInitCallbackApiTest) {
    auto ret = aclInit(nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    auto &cbMgrInstance = InitCallbackManager::GetInstance();
    auto bakInitCbMap = cbMgrInstance.initCallbackMap_;
    cbMgrInstance.initCallbackMap_.clear();
    ret = aclInitCallbackRegister(ACL_REG_TYPE_ACL_MODEL, InitCallback_Success, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclInitCallbackUnRegister(ACL_REG_TYPE_ACL_MODEL, InitCallback_Fail);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
    ret = aclInitCallbackRegister(ACL_REG_TYPE_ACL_MODEL, InitCallback_Fail, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
    ret = aclInitCallbackUnRegister(ACL_REG_TYPE_ACL_MODEL, InitCallback_Success);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclInitCallbackUnRegister(ACL_REG_TYPE_ACL_MODEL, InitCallback_Fail);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
    ret = aclInitCallbackRegister(ACL_REG_TYPE_ACL_MODEL, InitCallback_Success, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclInitCallbackRegister(ACL_REG_TYPE_OTHER, InitCallback_Success, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclInitCallbackRegister(ACL_REG_TYPE_OTHER, InitCallback_Fail, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclInitCallbackUnRegister(ACL_REG_TYPE_OTHER, InitCallback_Success);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclInitCallbackUnRegister(ACL_REG_TYPE_OTHER, InitCallback_Fail);
    EXPECT_EQ(ret, ACL_SUCCESS);
    cbMgrInstance.initCallbackMap_ = bakInitCbMap;

    ret = aclFinalize();
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclInitCallbackTest) {
    const std::string configPath = ACL_BASE_DIR "/tests/ut/acl/json/handleOpConfig.json";
    auto &cbMgrInstance = InitCallbackManager::GetInstance();
    auto bakInitCbMap = cbMgrInstance.initCallbackMap_;
    auto bakFinalizeCbMap = cbMgrInstance.finalizeCallbackMap_;
    cbMgrInstance.initCallbackMap_.clear();
    cbMgrInstance.finalizeCallbackMap_.clear();

    auto ret = aclInitCallbackRegister(ACL_REG_TYPE_ACL_MODEL, InitCallback_Fail, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclInit(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);
    cbMgrInstance.initCallbackMap_.clear();

    resetAclJsonHash();
    ret = aclInitCallbackRegister(ACL_REG_TYPE_ACL_OP_EXECUTOR, InitCallback_Fail, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclInit(configPath.c_str());
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);
    cbMgrInstance.initCallbackMap_.clear();

    ret = aclInitCallbackRegister(ACL_REG_TYPE_ACL_DVPP, InitCallback_Fail, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclInit(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);
    cbMgrInstance.initCallbackMap_.clear();

    ret = aclInitCallbackRegister(ACL_REG_TYPE_OTHER, InitCallback_Fail, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclInit(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);
    cbMgrInstance.initCallbackMap_.clear();

    ret = aclInit(nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclFinalizeCallbackRegister(ACL_REG_TYPE_ACL_MODEL, FinalizeCallback_Fail, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclFinalize();
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);
    cbMgrInstance.finalizeCallbackMap_.clear();

    ret = aclFinalizeCallbackRegister(ACL_REG_TYPE_ACL_OP_COMPILER, FinalizeCallback_Fail, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclFinalize();
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);
    cbMgrInstance.finalizeCallbackMap_.clear();

    ret = aclFinalizeCallbackRegister(ACL_REG_TYPE_ACL_DVPP, FinalizeCallback_Fail, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclFinalize();
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);
    cbMgrInstance.finalizeCallbackMap_.clear();

    ret = aclFinalizeCallbackRegister(ACL_REG_TYPE_OTHER, FinalizeCallback_Fail, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclFinalize();
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);
    cbMgrInstance.finalizeCallbackMap_.clear();

    ret = aclFinalize();
    EXPECT_EQ(ret, ACL_SUCCESS);

    cbMgrInstance.initCallbackMap_ = bakInitCbMap;
    cbMgrInstance.finalizeCallbackMap_ = bakFinalizeCbMap;
}

TEST_F(UTEST_ACL_Runtime, aclFinalizeCallbackApiTest) {
    auto ret = aclInit(nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    auto &cbMgrInstance = InitCallbackManager::GetInstance();
    auto bakFinalizeCbMap = cbMgrInstance.finalizeCallbackMap_;
    cbMgrInstance.finalizeCallbackMap_.clear();

    ret = aclFinalizeCallbackRegister(ACL_REG_TYPE_ACL_MODEL, FinalizeCallback_Success, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclFinalizeCallbackUnRegister(ACL_REG_TYPE_ACL_MODEL, FinalizeCallback_Fail);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
    ret = aclFinalizeCallbackRegister(ACL_REG_TYPE_ACL_MODEL, FinalizeCallback_Fail, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
    ret = aclFinalizeCallbackUnRegister(ACL_REG_TYPE_ACL_MODEL, FinalizeCallback_Success);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclFinalizeCallbackUnRegister(ACL_REG_TYPE_ACL_MODEL, FinalizeCallback_Fail);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
    ret = aclFinalizeCallbackRegister(ACL_REG_TYPE_ACL_MODEL, FinalizeCallback_Success, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclFinalizeCallbackRegister(ACL_REG_TYPE_OTHER, FinalizeCallback_Success, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclFinalizeCallbackRegister(ACL_REG_TYPE_OTHER, FinalizeCallback_Fail, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclFinalizeCallbackUnRegister(ACL_REG_TYPE_OTHER, FinalizeCallback_Success);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclFinalizeCallbackUnRegister(ACL_REG_TYPE_OTHER, FinalizeCallback_Fail);
    EXPECT_EQ(ret, ACL_SUCCESS);

    cbMgrInstance.finalizeCallbackMap_ = bakFinalizeCbMap;

    ret = aclFinalize();
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtProfTrace_invalid_userdata)
{
    int32_t length = 18;
    aclrtStream stream = (aclrtStream)0x01;

    const auto ret = aclrtProfTrace(nullptr, length, stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtProfTrace_invalid_length)
{
    int32_t length = 20;
    aclrtStream stream = (aclrtStream)0x01;

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsProfTrace(_,_,_))
                .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    uint8_t data[length] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09,
        0x10, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x10};
    const auto ret = aclrtProfTrace(&data, length, stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtProfTrace_success_1)
{
    int32_t length = 15;
    aclrtStream stream = (aclrtStream)0x01;
    uint8_t data[length] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
        0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08};

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsProfTrace(_,_,_))
                .WillOnce(Return(ACL_SUCCESS));

    const auto ret = aclrtProfTrace(&data, length, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, aclrtProfTrace_success_2)
{
    int32_t length = 18;
    aclrtStream stream = (aclrtStream)0x01;
    uint8_t data[length] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
        0x09, 0x10, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08};

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsProfTrace(_,_,_))
                .WillOnce(Return(ACL_SUCCESS));

    const auto ret = aclrtProfTrace(&data, length, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, launch_kernel_V2_failed_with_nullptr_input)
{
    aclrtFuncHandle funcHandle = nullptr;
    void *argsData = nullptr;
    aclrtStream stream = nullptr;
    aclError ret = aclrtLaunchKernelV2(funcHandle, 0, argsData, 0, nullptr, stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    funcHandle = (aclrtFuncHandle)0x01U;
    ret = aclrtLaunchKernelV2(funcHandle, 0, argsData, 0, nullptr, stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, launch_kernel_V2_successful)
{
    aclrtFuncHandle funcHandle = (aclrtFuncHandle)0x01U;
    void *argsData = reinterpret_cast<void *>(0x01U);
    aclrtStream stream = (aclrtStream)0x01U;
    uint32_t blockDim = 24;
    size_t argsSize = 100;

    aclrtLaunchKernelCfg cfg;
    cfg.numAttrs = 1U;

    aclrtLaunchKernelAttr attrs[cfg.numAttrs];
    attrs[0U].id = ACL_RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE;

    aclrtLaunchKernelAttrValue value;
    value.schemMode = 1U;
    attrs[0U].value = value;
    cfg.attrs = attrs;

    aclError ret = aclrtLaunchKernelV2(funcHandle, blockDim, argsData, argsSize, &cfg, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtLaunchKernelV2(funcHandle, blockDim, argsData, argsSize, nullptr, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, launch_kernel_V2_failed_with_rt_launch_kernel_func_failed)
{
    aclrtFuncHandle funcHandle = (aclrtFuncHandle)0x01U;
    void *argsData = reinterpret_cast<void *>(0x01U);
    aclrtStream stream = (aclrtStream)0x01U;
    uint32_t blockDim = 24;
    size_t argsSize = 100;

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsLaunchKernelWithDevArgs(_, _, _, _, _, _, _))
          .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    aclError ret = aclrtLaunchKernelV2(funcHandle, blockDim, argsData, argsSize, nullptr, stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, launch_kernel_V2_failed_with_rt_launch_kernel_func_failed_2)
{
    aclrtFuncHandle funcHandle = (aclrtFuncHandle)0x01U;
    void *argsData = reinterpret_cast<void *>(0x01U);
    aclrtStream stream = (aclrtStream)0x01U;
    uint32_t blockDim = 24;
    size_t argsSize = 100;

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsLaunchKernelWithDevArgs(_, _, _, _, _, _, _))
          .WillOnce(Return(ACL_ERROR_RT_INVALID_HANDLE));
    aclError ret = aclrtLaunchKernelV2(funcHandle, blockDim, argsData, argsSize, nullptr, stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_INVALID_HANDLE);
}

TEST_F(UTEST_ACL_Runtime, launch_kernel_with_host_args_failed_with_nullptr_input)
{
    aclrtFuncHandle funcHandle = nullptr;
    void *hostArgs = nullptr;
    aclrtStream stream = nullptr;
    aclError ret = aclrtLaunchKernelWithHostArgs(funcHandle, 0, stream, nullptr, hostArgs, 0, nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    funcHandle = (aclrtFuncHandle)0x01U;
    ret = aclrtLaunchKernelWithHostArgs(funcHandle, 0, stream, nullptr, hostArgs, 0, nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, launch_kernel_with_host_args_successful)
{
    aclrtFuncHandle funcHandle = (aclrtFuncHandle)0x01U;
    void *hostArgs = reinterpret_cast<void *>(0x01U);
    aclrtStream stream = (aclrtStream)0x01U;
    uint32_t blockDim = 24;
    size_t argsSize = 100;

    aclrtLaunchKernelCfg cfg;
    cfg.numAttrs = 1U;

    aclrtLaunchKernelAttr attrs[cfg.numAttrs];
    attrs[0U].id = ACL_RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE;

    aclrtLaunchKernelAttrValue value;
    value.schemMode = 1U;
    attrs[0U].value = value;
    cfg.attrs = attrs;

    aclrtPlaceHolderInfo placeHolderArray;
    placeHolderArray.addrOffset = 0;
    placeHolderArray.dataOffset = 0;

    aclError ret = aclrtLaunchKernelWithHostArgs(funcHandle, blockDim, stream, &cfg, hostArgs, argsSize, &placeHolderArray, 1);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtLaunchKernelWithHostArgs(funcHandle, blockDim, stream, nullptr, hostArgs, argsSize, nullptr, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Runtime, launch_kernel_with_host_args_failed_with_rt_launch_kernel_func_failed)
{
    aclrtFuncHandle funcHandle = (aclrtFuncHandle)0x01U;
    void *hostArgs = reinterpret_cast<void *>(0x01U);
    aclrtStream stream = (aclrtStream)0x01U;
    uint32_t blockDim = 24;
    size_t argsSize = 100;

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsLaunchKernelWithHostArgs(_, _, _, _, _, _, _, _))
          .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    aclError ret = aclrtLaunchKernelWithHostArgs(funcHandle, blockDim, stream, nullptr, hostArgs, argsSize, nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, launch_kernel_with_host_args_failed_with_rt_launch_kernel_func_failed_2)
{
    aclrtFuncHandle funcHandle = (aclrtFuncHandle)0x01U;
    void *hostArgs = reinterpret_cast<void *>(0x01U);
    aclrtStream stream = (aclrtStream)0x01U;
    uint32_t blockDim = 24;
    size_t argsSize = 100;

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsLaunchKernelWithHostArgs(_, _, _, _, _, _, _, _))
          .WillOnce(Return(ACL_ERROR_RT_INVALID_HANDLE));
    aclError ret = aclrtLaunchKernelWithHostArgs(funcHandle, blockDim, stream, nullptr, hostArgs, argsSize, nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_INVALID_HANDLE);
}

TEST_F(UTEST_ACL_Runtime, aclrtCtxGetFloatOverflowAddr_success)
{
    aclError ret = aclrtCtxGetFloatOverflowAddr(nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsCtxGetFloatOverflowAddr(_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtCtxGetFloatOverflowAddr(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetFloatOverflowStatus_success)
{
    aclError ret = aclrtGetFloatOverflowStatus(0, 0, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsGetFloatOverflowStatus(_,_,_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtGetFloatOverflowStatus(0, 0, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtResetFloatOverflowStatus_success)
{
    aclError ret = aclrtResetFloatOverflowStatus(nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsResetFloatOverflowStatus(_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtResetFloatOverflowStatus(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtNpuGetFloatOverFlowStatus_success)
{
    aclError ret = aclrtNpuGetFloatOverFlowStatus(nullptr, 0, 0, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsNpuGetFloatOverFlowStatus(_,_,_,_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtNpuGetFloatOverFlowStatus(nullptr, 0, 0, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtNpuClearFloatOverFlowStatus_success)
{
    aclError ret = aclrtNpuClearFloatOverFlowStatus(0, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsNpuClearFloatOverFlowStatus(_,_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtNpuClearFloatOverFlowStatus(0, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, get_hardware_sync_addr)
{
    void *addr = nullptr;
    aclError ret = aclrtGetHardwareSyncAddr(&addr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsGetHardwareSyncAddr(_))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    ret = aclrtGetHardwareSyncAddr(&addr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, launch_random_task)
{
    aclrtStream stream = (aclrtStream)0x01U;
    aclrtRandomNumTaskInfo info = {};
    void *resv = reinterpret_cast<void *>(0x01U);
    aclError ret = aclrtRandomNumAsync(nullptr, stream, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    info.dataType = ACL_BOOL;
    ret = aclrtRandomNumAsync(&info, nullptr, resv);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    info.dataType = ACL_FLOAT16;
    ret = aclrtRandomNumAsync(&info, stream, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    info.dataType = ACL_FLOAT16;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsLaunchRandomNumTask(_, _, _))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    ret = aclrtRandomNumAsync(&info, stream, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

void taskFailCallback(aclrtExceptionInfo exceptionInfo)
{
    (void)exceptionInfo;
}

void streamStateCallback(aclrtStream stm, aclrtStreamState state, void *args)
{
    (void)stm;
    (void)state;
    (void)args;
}

TEST_F(UTEST_ACL_Runtime, set_stream_state_callback)
{
    const char_t *name = "callback";
    void *resv = reinterpret_cast<void *>(0x01U);
    aclError ret = aclrtRegStreamStateCallback(nullptr, streamStateCallback, resv);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    ret = aclrtRegStreamStateCallback(name, nullptr, resv);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtRegStreamStateCallback(name, streamStateCallback, resv);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsRegStreamStateCallback(_, _, _))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    ret = aclrtRegStreamStateCallback(name, streamStateCallback, resv);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

void deviceStateCallback(int32_t deviceId, aclrtDeviceState state, void *args)
{
    (void)deviceId;
    (void)state;
    (void)args;
}

TEST_F(UTEST_ACL_Runtime, set_device_state_callback)
{
    const char_t *name = "callback";
    void *resv = reinterpret_cast<void *>(0x01U);
    aclError ret = aclrtRegDeviceStateCallback(nullptr, deviceStateCallback, resv);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    ret = aclrtRegDeviceStateCallback(name, nullptr, resv);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtRegDeviceStateCallback(name, deviceStateCallback, resv);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsRegDeviceStateCallback(_, _, _))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    ret = aclrtRegDeviceStateCallback(name, deviceStateCallback, resv);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

int32_t taskAbortCallback(int32_t deviceId, aclrtDeviceTaskAbortStage stage, uint32_t timeout, void *args)
{
    (void)deviceId;
    (void)stage;
    (void)timeout;
    (void)args;
    return 0;
}

TEST_F(UTEST_ACL_Runtime, set_task_abort_callback)
{
    const char_t *name = "callback";
    aclError ret = aclrtSetDeviceTaskAbortCallback(nullptr, taskAbortCallback, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    ret = aclrtSetDeviceTaskAbortCallback(name, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtSetDeviceTaskAbortCallback(name, taskAbortCallback, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsSetDeviceTaskAbortCallback(_, _, _))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    void *resv = reinterpret_cast<void *>(0x01U);
    ret = aclrtSetDeviceTaskAbortCallback(name, taskAbortCallback, resv);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, get_op_execute_timeout)
{
    uint32_t timeout = 0U;
    aclError ret = aclrtGetOpExecuteTimeout(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtGetOpExecuteTimeout(&timeout);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetOpExecuteTimeoutV2(_))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    ret = aclrtGetOpExecuteTimeout(&timeout);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, device_peer_access_status)
{
    int32_t devIdDes = 0U;
    int32_t phyIdSrc = 0U;
    int32_t status = 0U;
    aclError ret = aclrtDevicePeerAccessStatus(devIdDes, phyIdSrc, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtDevicePeerAccessStatus(devIdDes, phyIdSrc, &status);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsGetP2PStatus(_, _, _))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    ret = aclrtDevicePeerAccessStatus(devIdDes, phyIdSrc, &status);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, stream_stop)
{
    aclrtStream stream = (aclrtStream)0x01U;
    aclError ret = aclrtStreamStop(nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtStreamStop(stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsStreamStop(_))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    ret = aclrtStreamStop(stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, launch_update_task)
{
    aclrtStream stream = (aclrtStream)0x01U;
    uint32_t taskId = 0U;
    aclrtStream execStream = (aclrtStream)0x01U;
    aclrtTaskUpdateInfo info = {};
    
    aclError ret = aclrtTaskUpdateAsync(nullptr, taskId, &info, execStream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtTaskUpdateAsync(stream, UINT32_MAX, &info, execStream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtTaskUpdateAsync(stream, taskId, nullptr, execStream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtTaskUpdateAsync(stream, taskId, &info, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtTaskUpdateAsync(stream, taskId, &info, execStream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    info.id = ACL_RT_UPDATE_RANDOM_TASK;
    ret = aclrtTaskUpdateAsync(stream, taskId, &info, execStream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsLaunchUpdateTask(_, _, _, _))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    ret = aclrtTaskUpdateAsync(stream, taskId, &info, execStream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclAppLog_success)
{
    const char *strLog = "hello, acl";
    std::string strLogOverflow(1025, 'a');
    std::string strLogNearOverflow(1023, 'a');
    aclAppLog(ACL_INFO, __FUNCTION__, __FILE__, __LINE__, strLog);
    aclAppLog(ACL_INFO, __FUNCTION__, __FILE__, __LINE__, strLogOverflow.c_str());
    aclAppLog(ACL_INFO, __FUNCTION__, __FILE__, __LINE__, strLogNearOverflow.c_str());
}

TEST_F(UTEST_ACL_Runtime, aclrtCheckArchCompatibilityTest)
{
    int32_t canCompatible = 255;
    aclError ret = aclrtCheckArchCompatibility("SOC_ASCEND910B1", &canCompatible);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtCheckArchCompatibility(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtCheckArchCompatibility("SOC_ASCEND910B1", &canCompatible);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCmoGetDescSizeTest)
{
    size_t size = 0;
    auto ret = aclrtCmoGetDescSize(&size);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(size, 0U);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsGetCmoDescSize(_)).WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtCmoGetDescSize(&size);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCmoSetDescTest)
{
    void *cmodesc = (void *)0x1;
    void *srcAddr = nullptr;
    size_t memLen = 64;
    auto ret = aclrtCmoSetDesc(cmodesc, srcAddr, memLen);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsSetCmoDesc(_, _, _))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtCmoSetDesc(&cmodesc, srcAddr, memLen);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCmoAsyncWithDescTest)
{
    void *cmodesc = (void *)0x1;
    auto ret = aclrtCmoAsyncWithDesc(cmodesc, ACL_RT_CMO_TYPE_PREFETCH, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsLaunchCmoAddrTask(_, _, _, _))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtCmoAsyncWithDesc(&cmodesc, ACL_RT_CMO_TYPE_PREFETCH, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclmdlRIAbortTest)
{
    aclmdlRI modelRI = (aclmdlRI)0x01;
    auto ret = aclmdlRIAbort(modelRI);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsModelAbort(_)).WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclmdlRIAbort(modelRI);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtMemRetainAllocationHandletest)
{
    void *virPtr = nullptr;
    size_t size = 1;

    auto ret = aclrtReserveMemAddress(&virPtr, size, 0, nullptr, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(virPtr, nullptr);   

    aclrtDrvMemHandle handle = nullptr;
    aclrtPhysicalMemProp prop = {};
    prop.allocationType = ACL_MEM_ALLOCATION_TYPE_PINNED;
    prop.memAttr = ACL_HBM_MEM_HUGE;
    prop.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    prop.location.id = 0;

    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(handle, nullptr);

    ret = aclrtMapMem(virPtr, size, 0, handle, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);

    aclrtDrvMemHandle handle1 = nullptr;
    ret = aclrtMemRetainAllocationHandle(nullptr, &handle1);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtMemRetainAllocationHandle(virPtr, &handle1);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtUnmapMem(virPtr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtFreePhysical(handle);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtReleaseMemAddress(virPtr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemRetainAllocationHandle(_,_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtMemRetainAllocationHandle(virPtr, &handle);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtMemGetAllocationPropertiesFromHandletest)
{
    size_t size = 1;
    aclrtDrvMemHandle handle = nullptr;
    aclrtPhysicalMemProp prop = {};
    prop.allocationType = ACL_MEM_ALLOCATION_TYPE_PINNED;
    prop.memAttr = ACL_HBM_MEM_HUGE;
    prop.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    prop.location.id = 0;

    auto ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);

    aclrtPhysicalMemProp prop1 = {};
    ret = aclrtMemGetAllocationPropertiesFromHandle(nullptr, &prop1);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtMemGetAllocationPropertiesFromHandle(handle, &prop1);
    EXPECT_EQ(ret, ACL_SUCCESS);

    prop.memAttr = ACL_HBM_MEM_NORMAL;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclrtMemGetAllocationPropertiesFromHandle(handle, &prop1);
    EXPECT_EQ(ret, ACL_SUCCESS);

    prop.memAttr = ACL_HBM_MEM_HUGE1G;
    ret = aclrtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclrtMemGetAllocationPropertiesFromHandle(handle, &prop1);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtFreePhysical(handle);
    EXPECT_EQ(ret, ACL_SUCCESS);
  
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemGetAllocationPropertiesFromHandle(_,_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtMemGetAllocationPropertiesFromHandle(handle, &prop1);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCntNotifyRecord)
{
    aclrtStream stream = (aclrtStream)0x01U;

    aclrtNotify cntNotify = nullptr;
    aclrtCntNotifyRecordInfo info = {ACL_RT_CNT_NOTIFY_RECORD_SET_VALUE_MODE, 0};
    auto ret = aclrtCntNotifyRecord(&cntNotify, stream, &info);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtCntNotifyRecord(&cntNotify, stream, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsCntNotifyRecord(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtCntNotifyRecord(&cntNotify, stream, &info);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCntNotifyWaitWithTimeout)
{
    aclrtStream stream = (aclrtStream)0x01U;

    aclrtNotify cntNotify = nullptr;
    aclrtCntNotifyWaitInfo info = {ACL_RT_CNT_NOTIFY_WAIT_LESS_MODE, 0, 0, true, 0};
    auto ret = aclrtCntNotifyWaitWithTimeout(&cntNotify, stream, &info);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtCntNotifyWaitWithTimeout(&cntNotify, stream, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsCntNotifyWaitWithTimeout(_,_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtCntNotifyWaitWithTimeout(&cntNotify, stream, &info);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCntNotifyReset)
{
    aclrtStream stream = (aclrtStream)0x01U;

    aclrtNotify cntNotify = nullptr;
    auto ret = aclrtCntNotifyReset(&cntNotify, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsCntNotifyReset(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtCntNotifyReset(&cntNotify, stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtCntNotifyGetId)
{
    aclrtNotify cntNotify = nullptr;
    auto ret = aclrtCntNotifyGetId(&cntNotify, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsCntNotifyGetId(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    uint32_t notifyId = 0U;
    ret = aclrtCntNotifyGetId(&cntNotify, &notifyId);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtPersistentTaskClean)
{
    aclrtStream stream = (aclrtStream)0x01U;
    aclError ret = aclrtPersistentTaskClean(nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtPersistentTaskClean(stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsPersistentTaskClean(_))
        .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
    ret = aclrtPersistentTaskClean(stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Runtime, aclrtCacheLastTaskOpInfo)
{
    char rawInfo[] = "test_op_info_data";
    size_t infoSize = sizeof(rawInfo);

    auto ret = aclrtCacheLastTaskOpInfo(nullptr, infoSize);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtCacheLastTaskOpInfo(rawInfo, 0U);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtCacheLastTaskOpInfo(rawInfo, infoSize);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtCacheLastTaskOpInfo(_,_))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtCacheLastTaskOpInfo(rawInfo, infoSize);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Runtime, aclrtGetFunctionAttribute)
{
    aclrtFuncAttribute attrType = ACL_FUNC_ATTR_KERNEL_TYPE;
    aclrtFuncHandle funcHandle = (aclrtFuncHandle)0x01;
    int64_t attrValue = 0U;

    auto ret = aclrtGetFunctionAttribute(nullptr, attrType, &attrValue);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclrtGetFunctionAttribute(funcHandle, attrType, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtFunctionGetAttribute(_, _, _))
                    .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtGetFunctionAttribute(funcHandle, attrType, &attrValue);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}
