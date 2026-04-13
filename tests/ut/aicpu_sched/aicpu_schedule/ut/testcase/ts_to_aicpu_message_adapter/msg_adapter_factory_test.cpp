/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use. this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "message_adapter_common_stub.h"
#include "ts_msg_adapter_factory.h"

using namespace AicpuSchedule;
using namespace aicpu;

class TsMsgAdapterFactoryTEST : public ::testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "TsMsgAdapterFactoryTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "TsMsgAdapterFactoryTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "TsMsgAdapterFactoryTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "TsMsgAdapterFactoryTEST TearDown" << std::endl;
    }
};

TEST_F(TsMsgAdapterFactoryTEST, CreateAdapterVersion0)
{
    MOCKER_CPP(&FeatureCtrl::GetTsMsgVersion).stubs().will(returnValue(VERSION_0));
    TsMsgAdapterFactory factory;
    auto adapter = factory.CreateAdapter();
    EXPECT_NE(adapter, nullptr);
    EXPECT_TRUE(adapter->IsAdapterInvaildParameter());
}

TEST_F(TsMsgAdapterFactoryTEST, CreateAdapterVersion1)
{
    MOCKER_CPP(&FeatureCtrl::GetTsMsgVersion).stubs().will(returnValue(VERSION_1));
    TsMsgAdapterFactory factory;
    auto adapter = factory.CreateAdapter();
    EXPECT_NE(adapter, nullptr);
    EXPECT_TRUE(adapter->IsAdapterInvaildParameter());
}

TEST_F(TsMsgAdapterFactoryTEST, CreateAdapterInvalidVersion)
{
    MOCKER_CPP(&FeatureCtrl::GetTsMsgVersion).stubs().will(returnValue((uint16_t)2));
    TsMsgAdapterFactory factory;
    auto adapter = factory.CreateAdapter();
    EXPECT_EQ(adapter, nullptr);
}

TEST_F(TsMsgAdapterFactoryTEST, CreateAdapterWithMsgVersion0)
{
    MOCKER_CPP(&FeatureCtrl::GetTsMsgVersion).stubs().will(returnValue(VERSION_0));
    TsMsgAdapterFactory factory;
    
    char msg[MAX_MSG_LEN] = {0};
    TsAicpuSqe* sqe = reinterpret_cast<TsAicpuSqe*>(msg);
    sqe->pid = 1;
    sqe->cmd_type = AICPU_MODEL_OPERATE;
    sqe->vf_id = 2;
    sqe->tid = 3;
    sqe->ts_id = 4;
    
    auto adapter = factory.CreateAdapter(msg);
    EXPECT_NE(adapter, nullptr);
    EXPECT_FALSE(adapter->IsAdapterInvaildParameter());
    EXPECT_EQ(adapter->pid_, 1);
    EXPECT_EQ(adapter->cmdType_, AICPU_MODEL_OPERATE);
    EXPECT_EQ(adapter->vfId_, 2);
    EXPECT_EQ(adapter->tid_, 3);
    EXPECT_EQ(adapter->tsId_, 4);
}

TEST_F(TsMsgAdapterFactoryTEST, CreateAdapterWithMsgVersion1)
{
    MOCKER_CPP(&FeatureCtrl::GetTsMsgVersion).stubs().will(returnValue(VERSION_1));
    TsMsgAdapterFactory factory;
    
    char msg[MAX_MSG_LEN] = {0};
    TsAicpuMsgInfo* msgInfo = reinterpret_cast<TsAicpuMsgInfo*>(msg);
    msgInfo->pid = 1;
    msgInfo->cmd_type = TS_AICPU_MODEL_OPERATE;
    msgInfo->vf_id = 2;
    msgInfo->tid = 3;
    msgInfo->ts_id = 4;
    
    auto adapter = factory.CreateAdapter(msg);
    EXPECT_NE(adapter, nullptr);
    EXPECT_FALSE(adapter->IsAdapterInvaildParameter());
    EXPECT_EQ(adapter->pid_, 1);
    EXPECT_EQ(adapter->cmdType_, TS_AICPU_MODEL_OPERATE);
    EXPECT_EQ(adapter->vfId_, 2);
    EXPECT_EQ(adapter->tid_, 3);
    EXPECT_EQ(adapter->tsId_, 4);
}

TEST_F(TsMsgAdapterFactoryTEST, CreateAdapterWithMsgInvalidVersion)
{
    MOCKER_CPP(&FeatureCtrl::GetTsMsgVersion).stubs().will(returnValue((uint16_t)2));
    TsMsgAdapterFactory factory;
    
    char msg[MAX_MSG_LEN] = {0};
    auto adapter = factory.CreateAdapter(msg);
    EXPECT_EQ(adapter, nullptr);
}
