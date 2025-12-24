/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string.h>
#include "ai_drv_dev_api.h"
#include "ai_drv_dsmi_api.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "config/config_manager.h"
#include "validation/param_validation.h"

using namespace Analysis::Dvvp::Driver;
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::validation;

class DRV_DSMI_API_STEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(DRV_DSMI_API_STEST, DrvGetAicoreInfo)
{
    GlobalMockObject::verify();
    int deviceId;
    int64_t freq;
    deviceId = -1;
    EXPECT_EQ(PROFILING_FAILED, DrvGetAicoreInfo(deviceId, freq));
    deviceId = 0;
    freq = 1;
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(deviceId))
        .then(returnValue(freq));
    EXPECT_EQ(deviceId, DrvGetAicoreInfo(deviceId, freq));
    EXPECT_EQ(freq, DrvGetAicoreInfo(deviceId, freq));

}

TEST_F(DRV_DSMI_API_STEST, DrvGeAicFrq)
{
    GlobalMockObject::verify();
    auto configManger = Analysis::Dvvp::Common::Config::ConfigManager::instance();
    configManger->configMap_["aicFrq"] = "TEST";
    std::string defAicFrq;
    int32_t deviceId;
    defAicFrq = "TEST";
    deviceId = -1;
    EXPECT_EQ(defAicFrq, DrvGeAicFrq(deviceId));
    deviceId = 0;
    EXPECT_EQ(defAicFrq, DrvGeAicFrq(deviceId));
}