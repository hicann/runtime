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
#include "thread_local_container.hpp"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

class SetDeviceFailureModeTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {}

    static void TearDownTestCase()
    {}

    virtual void SetUp()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        oldChipType = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_ADC);
        GlobalContainer::SetRtChipType(CHIP_ADC);
        int64_t hardwareVersion = CHIP_910_B_93 << 8;
        Driver *driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver_, &Driver::GetDevInfo)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        MOCKER(halGetSocVersion).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any()).will(returnValue(DRV_ERROR_NOT_SUPPORT));
        MOCKER(halGetDeviceInfo).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion))).will(returnValue(RT_ERROR_NONE));
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(oldChipType);
        GlobalContainer::SetRtChipType(oldChipType);
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }
private:
    rtChipType_t oldChipType;
};

TEST_F(SetDeviceFailureModeTest, set_mode_adc)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_SET_STREAM_MODE);
    auto ret = rtSetDeviceFailureMode(STOP_ON_FAILURE);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    rtInstance->DeviceRelease(device);
}
