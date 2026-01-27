/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <fstream>
#include "errno/error_code.h"
#include "utils/utils.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "info_json.h"

using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::host;
using namespace analysis::dvvp::common::error;

class INFO_JSON_TEST : public testing::Test {
protected:
    virtual void SetUp() {
        GlobalMockObject::verify();
        jobInfo = ("64");
        devices = ("0");
        hostpid = 15151;
    }
    virtual void TearDown() {
    }

public:
    std::string jobInfo;
    std::string devices;
    int hostpid;
};

TEST_F(INFO_JSON_TEST, DrvGetAiCpuCoreIdWithCoreNum) {
    GlobalMockObject::verify();
    int device_id = 0;
    DeviceInfo dev_info;

    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));

    dev_info.aiCpuCoreNum = 8;
    InfoJson infoJson(jobInfo, devices, hostpid);
    EXPECT_EQ(PROFILING_SUCCESS, infoJson.GetDevInfo(device_id, dev_info));
}