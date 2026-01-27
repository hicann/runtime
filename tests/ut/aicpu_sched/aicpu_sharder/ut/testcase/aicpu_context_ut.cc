/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpu_context.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include <cstdint>
#include <stdio.h>
#include <stdlib.h>
#include <queue>
#include <exception>
#include <string>
#include <functional>
#include "driver/ascend_hal_define.h"

using namespace aicpu;
using namespace std;

class AiCPUContextUt : public ::testing::Test {
public:
    virtual void SetUp()
    {}

    virtual void TearDown()
    {}
};

// schedule run closure
TEST_F(AiCPUContextUt, EventCallback000)
{
    std::function<void (void *)> callback = [&](void * param) {
      std::cout << "do callback function" << std::endl;
    };
    EXPECT_EQ(RegisterEventCallback(EVENT_QUEUE_ENQUEUE, 0, callback), 0);
    EXPECT_EQ(DoEventCallback(EVENT_QUEUE_ENQUEUE, 0, nullptr), 0);
}

// duplicate register callback function
TEST_F(AiCPUContextUt, EventCallback001)
{
    std::function<void (void *)> callback = [&](void * param) {
      std::cout << "do callback function" << std::endl;
    };
    EXPECT_EQ(RegisterEventCallback(EVENT_QUEUE_ENQUEUE, 0, callback), 0);
    EXPECT_NE(RegisterEventCallback(EVENT_QUEUE_ENQUEUE, 0, callback), 0);
}

// can not find callback function
TEST_F(AiCPUContextUt, EventCallback002)
{
    std::function<void (void *)> callback = [&](void * param) {
      std::cout << "do callback function" << std::endl;
    };
    EXPECT_NE(DoEventCallback(0, 1, nullptr), 0);
}

// register & unregister callback function
TEST_F(AiCPUContextUt, EventCallback003)
{
    std::function<void (void *)> callback = [&](void * param) {
      std::cout << "do callback function" << std::endl;
    };
    RegisterEventCallback(0, 0, callback);
    EXPECT_EQ(UnRegisterCallback(0, 0), 0);
}

// unregister not exist callback function
TEST_F(AiCPUContextUt, EventCallback004)
{
    std::function<void (void *)> callback = [&](void * param) {
      std::cout << "do callback function" << std::endl;
    };
    EXPECT_EQ(UnRegisterCallback(1, 1), 0);
}

// SetProfContext and GetProfContext
TEST_F(AiCPUContextUt, SetAndGetProfContext)
{
    aicpu::aicpuProfContext_t ctx;
    EXPECT_EQ(aicpu::aicpuSetProfContext(ctx), 0);
    aicpu::aicpuGetProfContext();
}

TEST_F(AiCPUContextUt, GetAllThreadCtxInfo)
{
    auto ret = GetAllThreadCtxInfo(CTX_DEBUG, 10);
    bool result = (typeid(ret) == typeid(std::map<std::string, std::string>));
    EXPECT_EQ(result, true);
    ret = GetAllThreadCtxInfo(CTX_PROF, 10);
    result = (typeid(ret) == typeid(std::map<std::string, std::string>));
    EXPECT_EQ(result, true);
    ret = GetAllThreadCtxInfo(CTX_DEFAULT, 10);
    result = (typeid(ret) == typeid(std::map<std::string, std::string>));
    EXPECT_EQ(result, true);
}


TEST_F(AiCPUContextUt, InitTaskMonitorContext)
{
    InitTaskMonitorContext(3U);
    SetAicpuThreadIndex(2U);
    string opname = "opname";
    status_t ret = SetOpname(opname);
    EXPECT_EQ(ret, 0);

    ret = GetOpname(2U, opname);
    EXPECT_EQ(ret, 0);
}

TEST_F(AiCPUContextUt, SetTaskAndStreamId)
{
    status_t ret = SetTaskAndStreamId(0U,0U);
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
}

TEST_F(AiCPUContextUt, SetAicpuRunMode)
{
    status_t ret = SetAicpuRunMode(0U);
    SetCustAicpuSdFlag(false);
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
}

TEST_F(AiCPUContextUt, RemoveThreadLocalCtx)
{
    string key = "key";
    string val = "val";
    status_t ret = SetThreadLocalCtx(key, val);
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
    ret = RemoveThreadLocalCtx(key);
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
}

TEST_F(AiCPUContextUt, SetThreadCtxInfo)
{
    string key = "key";
    string val = "val";
    status_t ret = SetThreadCtxInfo(aicpu::CTX_DEBUG, key, val);
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
    ret = RemoveThreadCtxInfo(aicpu::CTX_DEBUG, key);
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
}

TEST_F(AiCPUContextUt, SetThreadCtxInfo_failed)
{
    string key = "";
    string val = "val";
    status_t ret = SetThreadCtxInfo(aicpu::CTX_DEBUG, key, val);
    EXPECT_EQ(ret, AICPU_ERROR_FAILED);
    ret = RemoveThreadCtxInfo(aicpu::CTX_DEBUG, key);
    EXPECT_EQ(ret, AICPU_ERROR_FAILED);
}

TEST_F(AiCPUContextUt, GetThreadCtxInfo)
{
    string key = "key";
    string val = "val";
    status_t ret = SetThreadCtxInfo(aicpu::CTX_DEBUG, key, val);
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
    ret = GetThreadCtxInfo(aicpu::CTX_DEBUG, key, val);
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
    ret = RemoveThreadCtxInfo(aicpu::CTX_DEBUG, key);
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
}

TEST_F(AiCPUContextUt, GetThreadCtxInfo_failed)
{
    string key = "";
    string val = "val";
    status_t ret = SetThreadCtxInfo(aicpu::CTX_DEBUG, key, val);
    EXPECT_EQ(ret, AICPU_ERROR_FAILED);
    ret = GetThreadCtxInfo(aicpu::CTX_DEBUG, key, val);
    EXPECT_EQ(ret, AICPU_ERROR_FAILED);
    ret = RemoveThreadCtxInfo(aicpu::CTX_DEBUG, key);
    EXPECT_EQ(ret, AICPU_ERROR_FAILED);
}

TEST_F(AiCPUContextUt, InitTaskMonitorContextCoreCntNull)
{
    EXPECT_EQ(InitTaskMonitorContext(0), AICPU_ERROR_FAILED);
}

TEST_F(AiCPUContextUt, SetThreadLocalCtxKeyNull)
{
    EXPECT_EQ(SetThreadLocalCtx("", ""), AICPU_ERROR_FAILED);
}

TEST_F(AiCPUContextUt, GetThreadLocalCtxKeyNull)
{
    std::string val;
    EXPECT_EQ(GetThreadLocalCtx("", val), AICPU_ERROR_FAILED);
    EXPECT_EQ(GetThreadLocalCtx("123sad21dsadads", val), AICPU_ERROR_FAILED);
}

TEST_F(AiCPUContextUt, RemoveThreadLocalCtxFail)
{
    EXPECT_EQ(RemoveThreadLocalCtx("123sad21dsad312daads"), AICPU_ERROR_FAILED);
}


TEST_F(AiCPUContextUt, DoEventCallbackFail)
{
    EXPECT_EQ(DoEventCallback(0, 123987654, nullptr), AICPU_ERROR_FAILED);
}

TEST_F(AiCPUContextUt, UnRegisterCallbackFail)
{
    EXPECT_EQ(UnRegisterCallback(0, 123987654), AICPU_ERROR_NONE);
}

TEST_F(AiCPUContextUt, StreamDvppBuffTest)
{
    MOCKER_CPP(&aicpu::GetTaskAndStreamId).stubs().will(returnValue(AICPU_ERROR_FAILED));
    SetStreamDvppBuffBychlType(AICPU_DVPP_CHL_VPC, 10, (uint8_t *)nullptr);
    uint8_t buff;
    uint64_t buffLen = 1;
    GetDvppBufAndLenBychlType(AICPU_DVPP_CHL_VPC, (uint8_t **)0, &buffLen);
    bool result = IsCustAicpuSd();
    EXPECT_EQ(result, false);
}

TEST_F(AiCPUContextUt, StreamDvppBuffTest2)
{
    EXPECT_EQ(GetStreamDvppChannelId(10, AICPU_DVPP_CHL_BUTT), -1);
    uint8_t buff;
    uint64_t buffLen = 1;
    EXPECT_EQ(GetCurTaskDvppChannelId(AICPU_DVPP_CHL_BUTT), -1);
    EXPECT_EQ(UnInitStreamDvppChannel(0, AICPU_DVPP_CHL_BUTT), -1);
}

TEST_F(AiCPUContextUt, GetUniqueVfIdSuccess)
{
    uint32_t ret = GetUniqueVfId();
    EXPECT_EQ(ret, 0);
    bool result = IsCustAicpuSd();
    EXPECT_EQ(result, false);
}

TEST_F(AiCPUContextUt, GetThreadCtxInfoFail)
{
    std::string val;
    EXPECT_EQ(GetThreadCtxInfo(CTX_DEFAULT, "135asd8ceasd", val), AICPU_ERROR_FAILED);
}

TEST_F(AiCPUContextUt, GetSqeIdSuccess)
{
    const uint32_t inital = 0x80000000;
    uint32_t start = 0U;
    uint32_t end = 0U;
    uint32_t numMax = (UINT32_MAX - inital);
    GetSqeId(1, start, end);
    EXPECT_EQ(start, inital);
    EXPECT_EQ(end, inital + 1);
    GetSqeId(16, start, end);
    EXPECT_EQ(start, inital + 1);
    EXPECT_EQ(end, inital + 17);
    GetSqeId(numMax, start, end);
    EXPECT_EQ(start, inital);
    EXPECT_EQ(end, UINT32_MAX);
    GetSqeId(UINT32_MAX-20U, start, end);
    EXPECT_EQ(start, inital);
    GetSqeId(30, start, end);
    EXPECT_EQ(start, inital);
    EXPECT_EQ(end, inital + 30);
}
