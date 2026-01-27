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
#define private public
#define protected public
#include "runtime/rt.h"
#include "thread_local_container.hpp"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

class DfxApiTest : public testing::Test {
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
    bool isTaskTagValid = ThreadLocalContainer::IsTaskTagValid();;
    EXPECT_FALSE(isTaskTagValid);
    const char *taskTag = "123456";
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
    bool isTaskTagValid = ThreadLocalContainer::IsTaskTagValid();;
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
    const char *key = "key";
    const char *value = "value";
    rtError_t error = rtSetAicpuAttr(key, value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    auto func = [](const char_t * const, const char_t * const)->TDT_StatusType {
        return 0U;
    };
    Runtime::Instance()->tsdSetAttr_ = func;
    error = rtSetAicpuAttr(key, value);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(DfxApiTest, getTsdQos_success)
{
    auto func = [](const int32_t, const int32_t, const uint64_t)->TDT_StatusType {
        return 0U;
    };

    uint16_t qos;
    Runtime::Instance()->tsdGetCapability_ = func;
    rtError_t error = Runtime::Instance()->GetTsdQos(0, qos);
    EXPECT_EQ(error, RT_ERROR_NONE);

    auto failStub = [](const int32_t, const int32_t, const uint64_t)->TDT_StatusType {
        return 1U;
    };

    Runtime::Instance()->tsdGetCapability_ = failStub;
    error = Runtime::Instance()->GetTsdQos(0, qos);
    EXPECT_EQ(error, RT_ERROR_DRV_TSD_ERR);
}