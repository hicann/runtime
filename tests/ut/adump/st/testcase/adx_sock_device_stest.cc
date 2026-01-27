/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include "mockcpp/mockcpp.hpp"
#define protected public
#define private public
#include "adx_sock_device.h"
#include "log/adx_log.h"
#include "ascend_hal.h"
#include "adx_dsmi.h"
#include "adx_device.h"
#include "common_utils.h"
#include "adx_comm_opt_manager.h"
#include "adx_comm_opt.h"
#include "sock_comm_opt.h"

using namespace Adx;

class ADX_SOCK_DEVICE_STEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(ADX_SOCK_DEVICE_STEST, EnableNotify)
{
    std::unique_ptr<AdxCommOpt> opt(new (std::nothrow) SockCommOpt());
    (void)AdxCommOptManager::Instance().CommOptsRegister(opt);

    std::shared_ptr<Adx::AdxDevice> device = Adx::AdxCommOptManager::Instance().GetDevice(OptType::COMM_LOCAL);
    const std::string devId0 = "0";
    const std::string devId1 = "1";
    const std::string devId2 = "2";
    std::vector<std::string> devices;

    device->InitDevice(devId0);
    device->InitDevice(devId1);
    device->GetEnableDevices(devices);
    EXPECT_EQ(devices.size(), 2);

    devices.clear();
    device->DisableNotify(devId0);
    device->GetDisableDevices(devices);
    EXPECT_EQ(devices.size(), 1);

    devices.clear();
    device->EnableNotify(devId0);
    device->GetEnableDevices(devices);
    EXPECT_EQ(devices.size(), 2);

    devices.clear();
    device->EnableNotify(devId2);
    device->GetEnableDevices(devices);
    EXPECT_EQ(devices.size(), 2);
}