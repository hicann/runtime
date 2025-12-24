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

class RtQueueApiTest : public testing::Test
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

TEST_F(RtQueueApiTest, rtBuffAlloc)
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

TEST_F(RtQueueApiTest, rtBuffFree)
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

TEST_F(RtQueueApiTest, rtBuffConfirm)
{
    // normal
    const uint64_t alloc_size = 100;
    void *buff = malloc(alloc_size);
    rtError_t error = rtBuffConfirm(buff, alloc_size);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // invalid paramter
    error = rtBuffConfirm(nullptr, alloc_size);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER(halBuffGet)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtBuffConfirm(buff, alloc_size);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    free(buff);
}

TEST_F(RtQueueApiTest, rtBuffGetInfo)
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

TEST_F(RtQueueApiTest, rtBuffGet)
{
    // normal
    const uint64_t alloc_size = 100;
    void *buff = malloc(alloc_size);
    rtError_t error = rtBuffGet(nullptr, buff, alloc_size);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // invalid paramter
    error = rtBuffGet(nullptr, nullptr, alloc_size);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER(halBuffGet)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtBuffGet(nullptr, buff, alloc_size);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    free(buff);
}

TEST_F(RtQueueApiTest, rtBuffPut)
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

TEST_F(RtQueueApiTest, rtBufEventTrigger)
{
    // normal
    const char *name = "name";
    rtError_t error = rtBufEventTrigger(name);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // invalid paramter
    error = rtBufEventTrigger(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER(halBufEventReport)
    .stubs()
    .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtBufEventTrigger(name);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtQueueApiTest, rtEschedAttachDevice)
{
    int32_t device = 0;

    rtError_t error = rtEschedAttachDevice(device);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halEschedAttachDevice)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtEschedAttachDevice(device);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtQueueApiTest, rtEschedDettachDevice)
{
    int32_t device = 0;

    rtError_t error = rtEschedDettachDevice(device);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halEschedDettachDevice)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtEschedDettachDevice(device);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtQueueApiTest, rtEschedSubmitEvent)
{
    int32_t device = 0;
     rtEschedEventSummary_t event;

    rtError_t error = rtEschedSubmitEvent(device, &event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halEschedSubmitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtEschedSubmitEvent(device, &event);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtQueueApiTest, rtEschedSubmitEventSync)
{
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

TEST_F(RtQueueApiTest, rtEschedCreateGrp)
{
    int32_t device = 0;
    uint32_t grpId = 0;
    rtGroupType_t type = RT_GRP_TYPE_BIND_DP_CPU;

    rtError_t error = rtEschedCreateGrp(device, grpId, type);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halEschedCreateGrp)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtEschedCreateGrp(device, grpId, type);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(RtQueueApiTest, rtEschedQueryInfo)
{
    uint32_t device = 0;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtEschedInputInfo *inPut = nullptr;
    rtEschedOutputInfo *outPut = nullptr;
    rtError_t error = rtEschedQueryInfo(device, RT_QUERY_TYPE_LOCAL_GRP_ID, inPut, outPut);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    inPut = (rtEschedInputInfo *)malloc(sizeof(rtEschedInputInfo));
    outPut = (rtEschedOutputInfo *)malloc(sizeof(rtEschedOutputInfo));

    error = rtEschedQueryInfo(device, RT_QUERY_TYPE_LOCAL_GRP_ID, inPut, outPut);
    EXPECT_EQ(error, RT_ERROR_NONE);

    drvError_t code = DRV_ERROR_INVALID_VALUE;
    MOCKER(halEschedQueryInfo)
        .stubs()
        .will(returnValue(code));
    error = rtEschedQueryInfo(device, RT_QUERY_TYPE_LOCAL_GRP_ID, inPut, outPut);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    free(inPut);
    free(outPut);
}
