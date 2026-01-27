/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "driver/ascend_hal.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "model.hpp"
#include "device.hpp"
#include "raw_device.hpp"
#include "module.hpp"
#include "notify.hpp"
#include "event.hpp"
#include "task_info.hpp"
#include "task_info.h"
#include "device/device_error_proc.hpp"
#include "program.hpp"
#include "uma_arg_loader.hpp"
#include "npu_driver.hpp"
#include "ctrl_res_pool.hpp"
#include "stream_sqcq_manage.hpp"
#include "davinci_kernel_task.h"
#include <fstream>
#include "tsch_defines.h"
#include "utils.h"
#include <functional>
#include "npu_driver_dcache_lock.hpp"
#include "thread_local_container.hpp"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

class DcacheDeviceTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {}

    static void TearDownTestCase()
    {}

    virtual void SetUp()
    {
        int64_t hardwareVersion = CHIP_910_B_93 << 8;
        Driver *driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver_, &Driver::GetDevInfo)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        MOCKER(halGetSocVersion).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any()).will(returnValue(DRV_ERROR_NOT_SUPPORT));
        MOCKER(halGetDeviceInfo).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion))).will(returnValue(RT_ERROR_NONE));
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(DcacheDeviceTest, AllocStackPhyBase_01)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_MINI_V3);
    GlobalContainer::SetRtChipType(CHIP_MINI_V3);
    RawDevice *dev = new RawDevice(1);
    dev->Init();
    int32_t temp;
    dev->stackPhyBase32k_ = &temp;
    rtError_t ret = dev->AllocStackPhyBase();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
}

TEST_F(DcacheDeviceTest, AllocStackPhyBase_02)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_5612);
    GlobalContainer::SetRtChipType(CHIP_5612);
    RawDevice *dev = new RawDevice(1);
    dev->Init();
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    rtError_t ret = dev->AllocStackPhyBase();
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    delete dev;
}

TEST_F(DcacheDeviceTest, AllocStackPhyBase_03)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_MINI_V3);
    GlobalContainer::SetRtChipType(CHIP_MINI_V3);
    RawDevice *dev = new RawDevice(1);
    dev->Init();
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    rtError_t ret = dev->AllocStackPhyBase();
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    delete dev;
}

TEST_F(DcacheDeviceTest, AllocStackPhyBase_04)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_MINI_V3);
    GlobalContainer::SetRtChipType(CHIP_MINI_V3);
    RawDevice *dev = new RawDevice(1);
    dev->Init();
    uint32_t tmp = 0;
    void *addr = &tmp;
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&addr, sizeof(void *)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    dev->stackPhyBase16k_ = &tmp;
    rtError_t ret = dev->AllocStackPhyBase();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
}

TEST_F(DcacheDeviceTest, AllocStackPhyBase_05)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_MINI_V3);
    GlobalContainer::SetRtChipType(CHIP_MINI_V3);
    RawDevice *dev = new RawDevice(1);
    dev->Init();
    uint32_t tmp = 0;
    void *addr = &tmp;
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&addr, sizeof(void *)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_INVALID_VALUE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t ret = dev->AllocStackPhyBase();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
}
