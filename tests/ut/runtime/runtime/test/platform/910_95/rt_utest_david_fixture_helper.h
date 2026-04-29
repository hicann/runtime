/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RT_UTEST_DAVID_FIXTURE_HELPER_H_
#define RT_UTEST_DAVID_FIXTURE_HELPER_H_

/*
 * This header must be included AFTER:
 *   - mockcpp/mockcpp.hpp
 *   - runtime.hpp, raw_device.hpp, npu_driver.hpp (with private/protected access)
 *   - runtime/rt.h
 */

static Driver *MockDavidDriverSetup()
{
    int64_t hardwareVersion = ((ARCH_V100 << 16) | (CHIP_DAVID << 8) | (VER_NA));
    Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver,
        &Driver::GetDevInfo).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(),
        outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
        .will(returnValue(RT_ERROR_NONE));
    char *socVer = "Ascend950PR_9599";
    MOCKER(halGetSocVersion).stubs().with(mockcpp::any(), outBoundP(socVer, strlen("Ascend950PR_9599")),
        mockcpp::any()).will(returnValue(DRV_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::StreamBindLogicCq)
            .stubs()
            .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::StreamUnBindLogicCq)
            .stubs()
            .will(returnValue(RT_ERROR_NONE));
    return driver;
}

static void SetupDavidDeviceAndEngine(Device *&device_, Engine *&engine_)
{
    rtSetDevice(0);
    (void)rtSetSocVersion("Ascend950PR_9599");
    ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
    device_ = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    device_->SetChipType(CHIP_DAVID);
    engine_ = ((RawDevice *)device_)->engine_;
}

#endif  // RT_UTEST_DAVID_FIXTURE_HELPER_H_
