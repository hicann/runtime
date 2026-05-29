/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mockcpp/ChainingMockHelper.h"
#define private public
#define protected public
#include "device_comm.h"
#include "tsd_hdc_client.h"
#undef private
#undef protected

using namespace tsd;
using namespace std;

class DeviceCommTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        cout << "Before DeviceCommTest()" << endl;
    }

    virtual void TearDown()
    {
        cout << "After DeviceCommTest" << endl;
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }
};

TEST_F(DeviceCommTest, GetInstance_DevIdOutOfRange_ReturnNull)
{
    auto comm = DeviceComm::GetInstance(128, DeviceCommType::HDC);
    EXPECT_EQ(comm, nullptr);
}

TEST_F(DeviceCommTest, GetInstance_DevIdMaxRange_ReturnNull)
{
    auto comm = DeviceComm::GetInstance(200, DeviceCommType::HDC);
    EXPECT_EQ(comm, nullptr);
}

TEST_F(DeviceCommTest, GetInstance_InvalidCommType_ReturnNull)
{
    auto comm = DeviceComm::GetInstance(0, DeviceCommType::DEVICE_COMM_TYPE_TOTAL_NUM);
    EXPECT_EQ(comm, nullptr);
}

TEST_F(DeviceCommTest, GetInstance_HdcType_Success)
{
    auto comm = DeviceComm::GetInstance(0, DeviceCommType::HDC);
    EXPECT_NE(comm, nullptr);
    auto hdcClient = std::dynamic_pointer_cast<HdcClient>(comm);
    EXPECT_NE(hdcClient, nullptr);
}

TEST_F(DeviceCommTest, GetInstance_SameDevSameType_ReturnSame)
{
    auto comm1 = DeviceComm::GetInstance(0, DeviceCommType::HDC);
    auto comm2 = DeviceComm::GetInstance(0, DeviceCommType::HDC);
    EXPECT_NE(comm1, nullptr);
    EXPECT_EQ(comm1, comm2);
}

TEST_F(DeviceCommTest, GetInstance_DiffDev_ReturnDifferent)
{
    auto comm1 = DeviceComm::GetInstance(0, DeviceCommType::HDC);
    auto comm2 = DeviceComm::GetInstance(1, DeviceCommType::HDC);
    EXPECT_NE(comm1, nullptr);
    EXPECT_NE(comm2, nullptr);
    EXPECT_NE(comm1, comm2);
}

TEST_F(DeviceCommTest, GetInstance_InsertIntoMap_Success)
{
    auto comm = DeviceComm::GetInstance(2, DeviceCommType::HDC);
    EXPECT_NE(comm, nullptr);
    auto commAgain = DeviceComm::GetInstance(2, DeviceCommType::HDC);
    EXPECT_EQ(comm, commAgain);
}

TEST_F(DeviceCommTest, GetInstance_NonZeroDev_InsertIntoMap_Success)
{
    auto comm = DeviceComm::GetInstance(5, DeviceCommType::HDC);
    EXPECT_NE(comm, nullptr);
    auto commAgain = DeviceComm::GetInstance(5, DeviceCommType::HDC);
    EXPECT_EQ(comm, commAgain);
}

TEST_F(DeviceCommTest, Constructor_DerivedClassFieldsSet)
{
    HdcClient client(5U);
    EXPECT_EQ(client.deviceId_, 5U);
    EXPECT_EQ(client.commType_, DeviceCommType::HDC);
}

TEST_F(DeviceCommTest, GetInstance_VirtualDispatch)
{
    auto comm = DeviceComm::GetInstance(0, DeviceCommType::HDC);
    ASSERT_NE(comm, nullptr);
    // 通过基类指针调用纯虚函数应分发到 HdcClient 子类实现
    HDCMessage msg;
    TSD_StatusT ret = comm->CommSendMsg(999U, msg);
    EXPECT_EQ(ret, TSD_HDC_SEND_MSG_ERROR);
}

// =====================================================================
// Register() 及注册式工厂补充用例
// =====================================================================

TEST_F(DeviceCommTest, Register_ReturnTrue)
{
    // Register() 应始终返回 true
    bool result = DeviceComm::Register(
        static_cast<DeviceCommType>(99U),
        [](uint32_t devId) -> std::shared_ptr<DeviceComm> {
            return std::make_shared<HdcClient>(devId);
        });
    EXPECT_TRUE(result);
}

TEST_F(DeviceCommTest, Register_CreatorAddedToCreatorMap)
{
    // 注册后，可通过该类型创建出实例
    DeviceComm::Register(
        static_cast<DeviceCommType>(98U),
        [](uint32_t devId) -> std::shared_ptr<DeviceComm> {
            return std::make_shared<HdcClient>(devId);
        });
    auto comm = DeviceComm::GetInstance(98U, static_cast<DeviceCommType>(98U));
    EXPECT_NE(comm, nullptr);
    auto hdcClient = std::dynamic_pointer_cast<HdcClient>(comm);
    EXPECT_NE(hdcClient, nullptr);
    EXPECT_EQ(hdcClient->deviceId_, 98U);
}

TEST_F(DeviceCommTest, Register_CustomType_GetInstanceSuccess)
{
    // 注册自定义类型后，GetInstance 可通过注册表创建实例
    DeviceComm::Register(
        static_cast<DeviceCommType>(97U),
        [](uint32_t devId) -> std::shared_ptr<DeviceComm> {
            return std::make_shared<HdcClient>(devId);
        });
    auto comm = DeviceComm::GetInstance(0U, static_cast<DeviceCommType>(97U));
    EXPECT_NE(comm, nullptr);
}

TEST_F(DeviceCommTest, Register_CreatorReturnsNull_GetInstanceReturnNull)
{
    // 注册一个返回 nullptr 的 creator，GetInstance 应返回 nullptr（TSD_CHECK 触发）
    DeviceComm::Register(
        static_cast<DeviceCommType>(96U),
        [](uint32_t) -> std::shared_ptr<DeviceComm> {
            return nullptr;
        });
    auto comm = DeviceComm::GetInstance(0U, static_cast<DeviceCommType>(96U));
    EXPECT_EQ(comm, nullptr);
}

TEST_F(DeviceCommTest, GetInstance_BoundaryDevId127_Success)
{
    // devId=127 是合法上界，应能正常创建实例
    auto comm = DeviceComm::GetInstance(127U, DeviceCommType::HDC);
    EXPECT_NE(comm, nullptr);
    auto hdcClient = std::dynamic_pointer_cast<HdcClient>(comm);
    EXPECT_NE(hdcClient, nullptr);
    EXPECT_EQ(hdcClient->deviceId_, 127U);
}

TEST_F(DeviceCommTest, KeyCompose_DifferentDevIdProduceDifferentKey)
{
    // KeyCompose 对不同 devId 应产生不同 key
    uint64_t key0 = KeyCompose(0U, DeviceCommType::HDC);
    uint64_t key1 = KeyCompose(1U, DeviceCommType::HDC);
    EXPECT_NE(key0, key1);
}

TEST_F(DeviceCommTest, KeyCompose_SameDevIdSameTypeSameKey)
{
    // 相同输入下 KeyCompose 结果一致
    uint64_t keyA = KeyCompose(5U, DeviceCommType::HDC);
    uint64_t keyB = KeyCompose(5U, DeviceCommType::HDC);
    EXPECT_EQ(keyA, keyB);
}
