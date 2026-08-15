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
#include <thread>
#include <vector>
#define private public
#define protected public
#include "runtime/rt.h"
#include "runtime/rt_inner_dfx.h"
#include "parse_kernel_dfx_info.hpp"
#include "thread_local_container.hpp"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

class DfxApiTest : public testing::Test {
protected:
    static void SetUpTestCase() {}

    static void TearDownTestCase() {}

    virtual void SetUp() {}

    virtual void TearDown() { GlobalMockObject::verify(); }
};

TEST_F(DfxApiTest, rtSetTaskTag_param_check)
{
    ThreadLocalContainer::ResetTaskTag();
    rtError_t error = rtSetTaskTag(nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtSetTaskTag("");
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(DfxApiTest, rtSetTaskTag_success)
{
    ThreadLocalContainer::ResetTaskTag();
    bool isTaskTagValid = ThreadLocalContainer::IsTaskTagValid();
    ;
    EXPECT_FALSE(isTaskTagValid);
    const char* taskTag = "123456";
    rtError_t error = rtSetTaskTag(taskTag);
    EXPECT_EQ(error, RT_ERROR_NONE);

    isTaskTagValid = ThreadLocalContainer::IsTaskTagValid();
    EXPECT_TRUE(isTaskTagValid);

    std::string tagName;
    ThreadLocalContainer::GetTaskTag(tagName);
    EXPECT_STREQ(tagName.c_str(), taskTag);
    ThreadLocalContainer::ResetTaskTag();
}

TEST_F(DfxApiTest, rtSetTaskTag_overlens)
{
    ThreadLocalContainer::ResetTaskTag();
    bool isTaskTagValid = ThreadLocalContainer::IsTaskTagValid();
    ;
    EXPECT_FALSE(isTaskTagValid);

    constexpr size_t overLen = TASK_TAG_MAX_LEN + 10;
    char buffer[overLen] = {0};
    memset(buffer, 'a', sizeof(buffer));
    buffer[overLen - 1] = '\0';

    rtError_t error = rtSetTaskTag(buffer);
    EXPECT_EQ(error, RT_ERROR_NONE);

    isTaskTagValid = ThreadLocalContainer::IsTaskTagValid();
    EXPECT_TRUE(isTaskTagValid);

    std::string tagName;
    ThreadLocalContainer::GetTaskTag(tagName);
    EXPECT_EQ(tagName.length(), TASK_TAG_MAX_LEN - 1);
    // trunk
    buffer[TASK_TAG_MAX_LEN - 1] = '\0';
    EXPECT_STREQ(tagName.c_str(), buffer);

    ThreadLocalContainer::ResetTaskTag();
}

TEST_F(DfxApiTest, rtSetAicpuAttr_success)
{
    const char* key = "key";
    const char* value = "value";
    rtError_t error = rtSetAicpuAttr(key, value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    auto func = [](const char_t* const, const char_t* const) -> TDT_StatusType { return 0U; };
    Runtime::Instance()->tsdSetAttr_ = func;
    error = rtSetAicpuAttr(key, value);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(DfxApiTest, getTsdQos_success)
{
    auto func = [](const int32_t, const int32_t, const uint64_t) -> TDT_StatusType { return 0U; };

    uint16_t qos;
    Runtime::Instance()->tsdGetCapability_ = func;
    rtError_t error = Runtime::Instance()->GetTsdQos(0, qos);
    EXPECT_EQ(error, RT_ERROR_NONE);

    auto failStub = [](const int32_t, const int32_t, const uint64_t) -> TDT_StatusType { return 1U; };

    Runtime::Instance()->tsdGetCapability_ = failStub;
    error = Runtime::Instance()->GetTsdQos(0, qos);
    EXPECT_EQ(error, RT_ERROR_DRV_TSD_ERR);
}

static void DummyParseCallback(const rtDfxParseParam* param, uint64_t* consumedLen)
{
    (void)param;
    *consumedLen = 0U;
}

static void DummyParseCallback2(const rtDfxParseParam* param, uint64_t* consumedLen)
{
    (void)param;
    *consumedLen = 0U;
}

class ParseDfxInfoApiTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        ParseKernelDfxInfo* inst = ParseKernelDfxInfo::Instance();
        if (inst != nullptr) {
            (void)inst->SetCallback(nullptr);
        }
    }

    virtual void TearDown()
    {
        ParseKernelDfxInfo* inst = ParseKernelDfxInfo::Instance();
        if (inst != nullptr) {
            (void)inst->SetCallback(nullptr);
        }
        GlobalMockObject::verify();
    }
};

TEST_F(ParseDfxInfoApiTest, ParseKernelDfxInfo_SetCallback_WhenValidFunc_ExpectSuccess)
{
    rtError_t ret = ParseKernelDfxInfo::Instance()->SetCallback(DummyParseCallback);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(ParseKernelDfxInfo::Instance()->GetCallback(), DummyParseCallback);
}

TEST_F(ParseDfxInfoApiTest, ParseKernelDfxInfo_SetCallback_WhenDuplicate_ExpectOverwritten)
{
    (void)ParseKernelDfxInfo::Instance()->SetCallback(DummyParseCallback);
    rtError_t ret = ParseKernelDfxInfo::Instance()->SetCallback(DummyParseCallback2);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(ParseKernelDfxInfo::Instance()->GetCallback(), DummyParseCallback2);
}

TEST_F(ParseDfxInfoApiTest, ParseKernelDfxInfo_SetCallback_WhenNullptrClear_ExpectSuccess)
{
    (void)ParseKernelDfxInfo::Instance()->SetCallback(DummyParseCallback);
    rtError_t ret = ParseKernelDfxInfo::Instance()->SetCallback(nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(ParseKernelDfxInfo::Instance()->GetCallback(), nullptr);
}

TEST_F(ParseDfxInfoApiTest, rtRegisterParseDfxInfoFunc_WhenNullptr_ExpectSuccess)
{
    rtError_t ret = rtRegisterParseDfxInfoFunc(nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(ParseKernelDfxInfo::Instance()->GetCallback(), nullptr);
}

TEST_F(ParseDfxInfoApiTest, rtRegisterParseDfxInfoFunc_WhenValidFunc_ExpectCallbackSet)
{
    rtError_t ret = rtRegisterParseDfxInfoFunc(DummyParseCallback);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(ParseKernelDfxInfo::Instance()->GetCallback(), DummyParseCallback);
}

TEST_F(ParseDfxInfoApiTest, ParseKernelDfxInfo_SetCallback_WhenNullptrAndNoExisting_ExpectSuccess)
{
    (void)ParseKernelDfxInfo::Instance()->SetCallback(nullptr);
    rtError_t ret = ParseKernelDfxInfo::Instance()->SetCallback(nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(ParseKernelDfxInfo::Instance()->GetCallback(), nullptr);
}

TEST_F(ParseDfxInfoApiTest, ParseKernelDfxInfo_WhenConcurrentAccess_ExpectNoCrash)
{
    ParseKernelDfxInfo* inst = ParseKernelDfxInfo::Instance();
    ASSERT_NE(inst, nullptr);

    const int threadNum = 4;
    std::vector<std::thread> threads;
    for (int i = 0; i < threadNum; i++) {
        threads.emplace_back([inst]() {
            for (int j = 0; j < 100; j++) {
                (void)inst->GetCallback();
            }
        });
    }
    for (auto& t : threads) {
        t.join();
    }

    SUCCEED();
}
