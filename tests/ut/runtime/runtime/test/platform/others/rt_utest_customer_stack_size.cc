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
#include "raw_device.hpp"
#include "module.hpp"
#include "notify.hpp"
#include "event.hpp"
#include "task_info.hpp"
#include "task_info.h"
#include "ffts_task.h"
#include "device/device_error_proc.hpp"
#include "program.hpp"
#include "uma_arg_loader.hpp"
#include "npu_driver.hpp"
#include "ctrl_res_pool.hpp"
#include "stream_sqcq_manage.hpp"
#include "davinci_kernel_task.h"
#include "profiler.hpp"
#include "rdma_task.h"
#include "thread_local_container.hpp"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

class CustomerStackSize : public testing::Test {
protected:
    static void SetUpTestCase()
    {}

    static void TearDownTestCase()
    {}

    virtual void SetUp()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        oldChipType = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_910_B_93);
    GlobalContainer::SetRtChipType(CHIP_910_B_93);
        int64_t hardwareVersion = CHIP_910_B_93 << 8;
        Driver *driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver_, &Driver::GetDevInfo)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        isCfgOpWaitTaskTimeout = rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout;
        isCfgOpExcTaskTimeout = rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout;
        rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout = false;
        rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout = false;
    }

    virtual void TearDown()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout = isCfgOpWaitTaskTimeout;
        rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout = isCfgOpExcTaskTimeout;
        rtInstance->SetChipType(oldChipType);
    GlobalContainer::SetRtChipType(oldChipType);
        GlobalMockObject::verify();
        rtInstance->deviceCustomerStackSize_ = 0;
    }

private:
    rtChipType_t oldChipType;
    bool isCfgOpWaitTaskTimeout{false};
    bool isCfgOpExcTaskTimeout{false};
};

TEST_F(CustomerStackSize, AllocCustomerStackPhyBaseMinitV3)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    auto oldChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_MINI_V3);
    GlobalContainer::SetRtChipType(CHIP_MINI_V3);
    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, KERNEL_STACK_SIZE_32K);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    RawDevice *dev = new RawDevice(0);
    dev->Init();
    rtError_t ret = dev->AllocCustomerStackPhyBase();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
    rtInstance->SetChipType(oldChipType);
    GlobalContainer::SetRtChipType(oldChipType);
}

TEST_F(CustomerStackSize, AllocCustomerStackPhyBaseDavid)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    auto oldChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DAVID);
    GlobalContainer::SetRtChipType(CHIP_DAVID);
    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, KERNEL_STACK_SIZE_32K);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    RawDevice *dev = new RawDevice(0);
    dev->Init();
    rtError_t ret = dev->AllocCustomerStackPhyBase();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
    rtInstance->SetChipType(oldChipType);
    GlobalContainer::SetRtChipType(oldChipType);
}
